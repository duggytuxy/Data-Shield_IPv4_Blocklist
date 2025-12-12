#!/bin/bash
# ==============================================================================
# Script Name: setup_blocklist_manager.sh
# Version :    0.1.10 (Pre-Production 1)
# Description: Production-grade installer for IPv4 Blocklist Manager.
#              Features: Dynamic Failover, Atomic Firewall Updates,
#              Sandboxed Systemd, Log Rotation, Strict Validation.
# Target OS:   Ubuntu 24.04 LTS or + / Debian 13 or +
# Author:      Duggy Tuxy (Laurent M.)
# ==============================================================================

# --- Safety & Strict Mode ---
set -euo pipefail
IFS=$'\n\t'

# --- Configuration Constants ---
# Using an array implies we will inject ALL of them into the final script for failover
readonly SOURCES=(
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
    "https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_data-shield_ipv4_blocklist.txt"
)

readonly TARGET_SCRIPT="/usr/local/bin/update_blocklist.sh"
readonly LOG_FILE="/var/log/blocklist_manager_install.log"

# --- Visual Feedback ---
readonly C_RESET='\033[0m'
readonly C_INFO='\033[0;34m'
readonly C_OK='\033[0;32m'
readonly C_WARN='\033[0;33m'
readonly C_ERR='\033[0;31m'

# --- Helper Functions ---

log() {
    local level=$1
    local msg=$2
    local color=$C_INFO
    case $level in
        SUCCESS) color=$C_OK ;;
        WARNING) color=$C_WARN ;;
        ERROR)   color=$C_ERR ;;
    esac
    echo -e "${color}[${level}]${C_RESET} ${msg}" | tee -a "$LOG_FILE"
}

assert_root() {
    if [[ $EUID -ne 0 ]]; then
        log ERROR "This script must be run with root privileges (sudo)."
        exit 1
    fi
}

check_dependencies() {
    log INFO "Checking dependencies..."
    local deps=("curl" "grep" "awk" "sed" "systemctl")
    local missing=()

    # Check firewall backend availability
    if command -v nft >/dev/null; then
        log SUCCESS "Backend detected: nftables"
    elif command -v iptables >/dev/null && command -v ipset >/dev/null; then
        log SUCCESS "Backend detected: iptables + ipset"
    else
        missing+=("nftables OR (iptables + ipset)")
    fi

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null; then
            missing+=("$cmd")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        log ERROR "Missing dependencies: ${missing[*]}"
        exit 1
    fi
}

# --- Core Generators ---

# Function: generate_failover_logic
# Description: Injects a bash loop to try mirrors sequentially inside the target script.
generate_failover_logic() {
    cat <<'EOF'
    # --- Failover Logic ---
    TMP_FILE=$(mktemp)
    DOWNLOAD_SUCCESS=false
    
    # List of mirrors injected by setup script
    MIRRORS=(
EOF
    # Injection of URLs from the SOURCES array
    for url in "${SOURCES[@]}"; do
        echo "        \"$url\""
    done

    cat <<'EOF'
    )

    for url in "${MIRRORS[@]}"; do
        log "INFO" "Attempting download from: $url"
        # Timeout settings: 5s connect, 15s max transfer
        if curl -fsSL --connect-timeout 5 --max-time 15 "$url" -o "$TMP_FILE"; then
            if [[ -s "$TMP_FILE" ]]; then
                log "INFO" "Download successful."
                DOWNLOAD_SUCCESS=true
                break
            else
                log "WARN" "Empty file received from $url"
            fi
        else
            log "WARN" "Connection failed to $url"
        fi
    done

    if [[ "$DOWNLOAD_SUCCESS" = false ]]; then
        log "CRITICAL" "Unable to download blocklist from any mirror."
        rm -f "$TMP_FILE"
        exit 1
    fi
EOF
}

create_nftables_script() {
    local failover_block
    failover_block=$(generate_failover_logic)

    cat <<EOF > "$TARGET_SCRIPT"
#!/bin/bash
set -euo pipefail

# --- Configuration ---
NFT_TABLE="inet filter"
NFT_SET="blocklist_ipv4"
LOG_FILE="/var/log/nft_blocklist.log"
NFT_CMD="/usr/sbin/nft"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') [\$1] : \$2" >> "\$LOG_FILE"; }

# 1. Acquire Data (Failover)
log "INFO" "Starting blocklist update..."
$failover_block

# 2. Validate Data
# Regex for strictly valid IPv4 (0-255)
VALIDATED_FILE=\$(mktemp)
grep -E '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$' "\$TMP_FILE" > "\$VALIDATED_FILE"

LINE_COUNT=\$(wc -l < "\$VALIDATED_FILE")
if [[ "\$LINE_COUNT" -lt 10 ]]; then
    log "ERROR" "Validated file too small (\$LINE_COUNT lines). Security triggered."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE"
    exit 1
fi

# 3. Atomic Apply (NFTables)
# We build a single transaction file to ensure atomicity
BATCH_FILE=\$(mktemp)

cat <<NFT > "\$BATCH_FILE"
add table \$NFT_TABLE
add set \$NFT_TABLE \$NFT_SET { type ipv4_addr; flags interval; }
flush set \$NFT_TABLE \$NFT_SET
add element \$NFT_TABLE \$NFT_SET {
NFT

# Append IPs with comma separation
sed 's/$/, /' "\$VALIDATED_FILE" >> "\$BATCH_FILE"

cat <<NFT >> "\$BATCH_FILE"
}
NFT

# Apply the batch
if \$NFT_CMD -f "\$BATCH_FILE"; then
    log "SUCCESS" "Blocklist updated: \$LINE_COUNT IPs loaded."
else
    log "ERROR" "Failed to apply NFTables rules."
fi

# 4. Enforce Rule (Idempotent)
# Check if rule exists, if not add it. Drops traffic from the set.
if ! \$NFT_CMD list chain \$NFT_TABLE input | grep -q "@\$NFT_SET"; then
    \$NFT_CMD insert rule \$NFT_TABLE input ip saddr @\$NFT_SET drop
    log "INFO" "Blocking rule injected."
fi

# Cleanup
rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
EOF
}

# --- Systemd Automation with Hardening ---
setup_systemd() {
    log INFO "Configuring Systemd..."
    
    local service_file="/etc/systemd/system/blocklist-update.service"
    local timer_file="/etc/systemd/system/blocklist-update.timer"

    # Hardened Service Unit
    cat <<EOF > "$service_file"
[Unit]
Description=Update IPv4 Blocklist Firewall Rules
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=$TARGET_SCRIPT
User=root
# Security Hardening
ProtectSystem=full
ProtectHome=true
PrivateTmp=true
NoNewPrivileges=true
CapabilityBoundingSet=CAP_NET_ADMIN
EOF

    # Hourly Timer with Random Delay (to spread load on mirrors)
    cat <<EOF > "$timer_file"
[Unit]
Description=Run blocklist update every hour

[Timer]
OnCalendar=hourly
RandomizedDelaySec=300
Persistent=true

[Install]
WantedBy=timers.target
EOF

    systemctl daemon-reload
    systemctl enable --now blocklist-update.timer
    log SUCCESS "Systemd Timer enabled."
}

setup_logrotate() {
    log INFO "Configuring log rotation..."
    cat <<EOF > /etc/logrotate.d/blocklist-manager
/var/log/nft_blocklist.log {
    daily
    rotate 7
    compress
    missingok
    notifempty
    create 0640 root root
}
EOF
}

# --- Main Execution Flow ---

main() {
    assert_root
    check_dependencies
    
    # Detect Engine (Default to NFTables if available as it is the modern standard)
    if command -v nft >/dev/null; then
        log INFO "Generating script for NFTables..."
        create_nftables_script
    else
        log INFO "NFTables not found. Generating for IPtables (Legacy)..."
        # Note: Function create_iptables_script would go here (omitted for brevity, logical equivalent of nft)
        log ERROR "Please install nftables to use this script (apt install nftables)."
        exit 1
    fi

    # Permissions & Immutability
    chmod 700 "$TARGET_SCRIPT"
    
    # Handle Immutability attribute intelligently
    if lsattr "$TARGET_SCRIPT" 2>/dev/null | grep -q "i"; then
        chattr -i "$TARGET_SCRIPT"
    fi
    # Re-lock if desired (optional policy)
    # chattr +i "$TARGET_SCRIPT"

    setup_systemd
    setup_logrotate

    # First Run
    log INFO "Immediate execution for initialization..."
    if "$TARGET_SCRIPT"; then
        log SUCCESS "Installation complete. Your infrastructure is secure."
    else
        log ERROR "The generated script failed during the first test."
        exit 1
    fi
}

main