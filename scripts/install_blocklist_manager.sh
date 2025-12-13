#!/bin/bash
# ==============================================================================
# Script Name: install_blocklist_manager.sh
# Version:     v0.2.02 (Pre-Retail)
# Description: Enterprise-grade installer for an IPv4 Blocklist Manager.
#              Features:
#               - UFW Compatibility (Isolated Table with High Priority)
#               - Multi-Distro Support (Debian/Ubuntu/Fedora)
#               - Dynamic Source Failover (High Availability)
#               - Atomic NFTables Updates (No firewall downtime)
#               - Systemd Hardening (Sandboxing)
# Target OS:   Ubuntu 20.04+, Debian 11+, Fedora 41+
# Author:      Senior Bash Automation Expert
# ==============================================================================

# --- Strict Mode & Safety ---
set -euo pipefail
IFS=$'\n\t'

# --- Configuration Constants ---
readonly SOURCES=(
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
    "https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
)

readonly INSTALL_DIR="/usr/local/bin"
readonly TARGET_SCRIPT="${INSTALL_DIR}/update_blocklist.sh"
readonly LOG_FILE="/var/log/blocklist_manager_install.log"

# --- Visual Feedback ---
readonly C_RESET='\033[0m'
readonly C_INFO='\033[0;34m'
readonly C_OK='\033[0;32m'
readonly C_WARN='\033[0;33m'
readonly C_ERR='\033[0;31m'

# Global variables for Environment Detection
PKG_MANAGER=""
OS_ID=""

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
    echo -e "${color}[${level}]${C_RESET} ${msg}"
    echo "$(date '+%Y-%m-%d %H:%M:%S') [${level}] ${msg}" >> "$LOG_FILE"
}

assert_root() {
    if [[ $EUID -ne 0 ]]; then
        log ERROR "This script must be run with root privileges (sudo)."
        exit 1
    fi
}

# --- System Detection ---

detect_os_and_configure() {
    log INFO "Detecting Operating System..."
    
    if [[ -f /etc/os-release ]]; then
        source /etc/os-release
        OS_ID=$ID
    else
        log ERROR "Cannot detect OS: /etc/os-release not found."
        exit 1
    fi

    case "$OS_ID" in
        fedora)
            log INFO "OS Detected: Fedora Linux"
            PKG_MANAGER="dnf"
            handle_fedora_specifics
            ;;
        ubuntu|debian)
            log INFO "OS Detected: Debian/Ubuntu family"
            PKG_MANAGER="apt"
            ;;
        *)
            log WARNING "Unknown OS ($OS_ID). Proceeding with generic assumptions."
            PKG_MANAGER="apt"
            ;;
    esac
}

handle_fedora_specifics() {
    log INFO "Applying Fedora-specific configurations..."

    # 1. Handle Firewalld Conflict
    # Fedora uses firewalld by default. We disable it to allow direct NFTables management.
    if systemctl is-active --quiet firewalld; then
        log WARNING "Firewalld detected. Disabling it to avoid conflicts with our NFTables rules..."
        systemctl stop firewalld
        systemctl disable firewalld
        log SUCCESS "Firewalld disabled."
    fi

    # 2. Ensure native NFTables service is enabled
    if ! systemctl is-enabled --quiet nftables; then
        log INFO "Enabling native nftables service..."
        systemctl enable nftables
    fi
}

check_environment() {
    log INFO "Checking system dependencies..."
    
    # Ensure install directory exists
    if [[ ! -d "$INSTALL_DIR" ]]; then
        mkdir -p "$INSTALL_DIR"
    fi

    local deps=("curl" "grep" "awk" "sed" "systemctl")
    local missing=()

    # Check firewall backend availability
    if command -v nft >/dev/null; then
        log SUCCESS "Firewall backend detected: nftables"
    else
        log ERROR "nftables is not installed."
        if [[ "$PKG_MANAGER" == "dnf" ]]; then
             log INFO "Please run: dnf install nftables"
        else
             log INFO "Please run: apt update && apt install nftables"
        fi
        exit 1
    fi

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null; then
            missing+=("$cmd")
        fi
    done

    if [[ ${#missing[@]} -gt 0 ]]; then
        log ERROR "Missing system dependencies: ${missing[*]}"
        log INFO "Please install them using: $PKG_MANAGER install ${missing[*]}"
        exit 1
    fi
}

# --- Code Generators ---

generate_failover_logic() {
    cat <<'EOF'
    # --- Failover Logic ---
    TMP_FILE=$(mktemp)
    DOWNLOAD_SUCCESS=false
    
    # List of mirrors injected by the setup script
    MIRRORS=(
EOF
    for url in "${SOURCES[@]}"; do
        echo "        \"$url\""
    done

    cat <<'EOF'
    )

    for url in "${MIRRORS[@]}"; do
        log "INFO" "Attempting download from: $url"
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
        log "CRITICAL" "All mirrors failed. Aborting update."
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
# ==============================================================================
# Script: update_blocklist.sh
# Type:   NFTables Atomic Updater (UFW Compatible)
# Generated by: install_blocklist_manager.sh
# ==============================================================================
set -euo pipefail

# --- Configuration (Isolated Namespace) ---
# We use a custom table name to avoid conflict with UFW's 'inet filter'
NFT_TABLE="inet data_shield"
NFT_CHAIN="inbound_block"
NFT_SET="blocklist_ipv4"
LOG_FILE="/var/log/nft_blocklist.log"
NFT_CMD="/usr/sbin/nft"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') [\$1] : \$2" >> "\$LOG_FILE"; }

# 1. Acquire Data
log "INFO" "Starting blocklist update sequence..."
$failover_block

# 2. Validate Data (Strict IPv4 Regex)
VALIDATED_FILE=\$(mktemp)
grep -E '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$' "\$TMP_FILE" > "\$VALIDATED_FILE"

LINE_COUNT=\$(wc -l < "\$VALIDATED_FILE")
if [[ "\$LINE_COUNT" -lt 10 ]]; then
    log "ERROR" "Validated file too small (\$LINE_COUNT lines). Security abort."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE"
    exit 1
fi

# 3. Atomic Apply
BATCH_FILE=\$(mktemp)

cat <<NFT > "\$BATCH_FILE"
# Create isolated table (won't be flushed by UFW)
add table \$NFT_TABLE

# Chain Definition:
# Priority -100 ensures this runs BEFORE standard firewalls (UFW uses priority 0).
# This drops bad traffic early, saving CPU and avoiding conflicts.
add chain \$NFT_TABLE \$NFT_CHAIN { type filter hook input priority -100; }

# Set definition
add set \$NFT_TABLE \$NFT_SET { type ipv4_addr; flags interval; }
flush set \$NFT_TABLE \$NFT_SET
add element \$NFT_TABLE \$NFT_SET {
NFT

# Format list for NFTables
sed 's/$/, /' "\$VALIDATED_FILE" >> "\$BATCH_FILE"

cat <<NFT >> "\$BATCH_FILE"
}
NFT

# Apply transaction
if \$NFT_CMD -f "\$BATCH_FILE"; then
    log "SUCCESS" "Blocklist updated successfully. \$LINE_COUNT IPs active."
else
    log "ERROR" "Failed to apply NFTables transaction."
    exit 1
fi

# 4. Enforce Rule (Idempotent)
# Drop traffic coming from the blocklist set
if ! \$NFT_CMD list chain \$NFT_TABLE \$NFT_CHAIN | grep -q "@\$NFT_SET"; then
    \$NFT_CMD insert rule \$NFT_TABLE \$NFT_CHAIN ip saddr @\$NFT_SET drop
    log "INFO" "Blocking rule injected with high priority."
fi

# Cleanup
rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
EOF
}

# --- Systemd Automation ---
setup_systemd() {
    log INFO "Configuring Systemd automation..."
    
    local service_file="/etc/systemd/system/blocklist-update.service"
    local timer_file="/etc/systemd/system/blocklist-update.timer"

    # Service Unit (Hardened)
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

[Install]
WantedBy=multi-user.target
EOF

    # Timer Unit (Hourly)
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
    systemctl enable blocklist-update.service
    log SUCCESS "Systemd Timer and Service enabled."
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
    log INFO "Starting Blocklist Manager Installation (UFW-Safe Edition)..."
    
    assert_root
    
    # 1. Detect OS (Fedora vs Debian/Ubuntu)
    detect_os_and_configure
    
    # 2. Check deps
    check_environment
    
    # 3. Generate script
    log INFO "Generating High-Priority NFTables script at $TARGET_SCRIPT..."
    create_nftables_script

    chmod 700 "$TARGET_SCRIPT"
    
    # Clean immutable flag if exists
    if lsattr "$TARGET_SCRIPT" 2>/dev/null | grep -q "i"; then
        chattr -i "$TARGET_SCRIPT"
    fi

    # Fedora Specific: SELinux Context
    if [[ "$OS_ID" == "fedora" ]] && command -v restorecon >/dev/null; then
        log INFO "Applying SELinux context to script..."
        restorecon -v "$TARGET_SCRIPT"
    fi

    # 4. Automation
    setup_systemd
    setup_logrotate

    # 5. Initial Run
    log INFO "Executing initial blocklist update..."
    if "$TARGET_SCRIPT"; then
        log SUCCESS "Installation complete."
        log INFO "The blocklist is now active in table 'inet data_shield' (Priority -100)."
        log INFO "This runs safely alongside UFW."
    else
        log ERROR "Initial test failed. Check /var/log/nft_blocklist.log."
        exit 1
    fi
}

main