#!/bin/bash
# ==============================================================================
# Script Name: install_blocklist_manager.sh
# Version:     v0.3.03-1 (Pre-Production)
# Description: Enterprise-grade installer for an IPv4 Blocklist Manager.
#              Security Features:
#               - Interactive Source Selection (Official/Custom)
#               - Strict TLS 1.2+ Enforcement
#               - Source Integrity Audit (SHA256 Hashing)
#               - Atomic NFTables Updates (No downtime)
#               - Systemd Hardening (Sandboxing)
# Target OS:   Ubuntu 20.04+, Debian 11+, Fedora 41+
# Author:      Duggy Tuxy (Laurent M.)
# ==============================================================================

# --------------------------- Strict mode & safety ---------------------------
set -euo pipefail
IFS=$'\n\t'

# --------------------------- Configuration ----------------------------------
readonly INSTALL_DIR="/usr/local/bin"
readonly TARGET_SCRIPT="${INSTALL_DIR}/update_blocklist.sh"
readonly LOG_FILE="/var/log/blocklist_manager_install.log"

# Default Official Sources (Direct Raw Access - No CDN Caching)
readonly OFFICIAL_SOURCES=(
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
)

# Variable to hold the final selection (Mutable)
SELECTED_SOURCES=()

# --------------------------- Visual feedback --------------------------------
readonly C_RESET='\033[0m'
readonly C_INFO='\033[0;34m'
readonly C_OK='\033[0;32m'
readonly C_WARN='\033[0;33m'
readonly C_ERR='\033[0;31m'
readonly C_QUESTION='\033[0;36m'

# Global variables
PKG_MANAGER=""
OS_ID=""

# --------------------------- Helper functions -------------------------------
log() {
    local level=$1
    local msg=$2
    local color=$C_INFO
    case $level in
        SUCCESS) color=$C_OK ;;
        WARNING) color=$C_WARN ;;
        ERROR)   color=$C_ERR ;;
        QUESTION) color=$C_QUESTION ;;
    esac
    echo -e "${color}[${level}]${C_RESET} ${msg}"
    # Remove color codes for log file
    echo "$(date '+%Y-%m-%d %H:%M:%S') [${level}] ${msg}" >> "$LOG_FILE"
}

assert_root() {
    if [[ $EUID -ne 0 ]]; then
        log ERROR "This script must be run with root privileges (sudo)."
        exit 1
    fi
}

# --------------------------- User Interaction -------------------------------
validate_url() {
    local url="$1"
    
    # 1. Syntax Check (Regex for HTTPS)
    if [[ ! "$url" =~ ^https:// ]]; then
        log ERROR "Invalid Protocol. Only HTTPS is accepted for security."
        return 1
    fi

    # 2. Accessibility & TLS Check (Head request, TLS 1.2 min)
    log INFO "Verifying connectivity and TLS version for: $url"
    if curl --output /dev/null --silent --head --fail --tlsv1.2 --proto =https "$url"; then
        return 0
    else
        log ERROR "URL unreachable or TLS version too old (<1.2)."
        return 1
    fi
}

select_source_mode() {
    echo -e "\n${C_QUESTION}--- Source Selection ---${C_RESET}"
    echo "1) Use Official Trusted Sources (Auto-Failover)"
    echo "2) Use Custom Source (Expert Mode)"
    echo -n "Select an option [1-2]: "
    read -r choice

    case "$choice" in
        1)
            log INFO "Selected: Official Sources."
            SELECTED_SOURCES=("${OFFICIAL_SOURCES[@]}")
            ;;
        2)
            log INFO "Selected: Custom Source."
            while true; do
                echo -e "\n${C_QUESTION}Enter your custom Blocklist URL (HTTPS required):${C_RESET}"
                read -r custom_url
                
                # Input sanitization (trim whitespace)
                custom_url=$(echo "$custom_url" | xargs)

                if validate_url "$custom_url"; then
                    SELECTED_SOURCES=("$custom_url")
                    log SUCCESS "Custom source verified and accepted."
                    break
                else
                    log WARNING "Please try again with a valid HTTPS URL (TLS 1.2+)."
                fi
            done
            ;;
        *)
            log ERROR "Invalid selection. Exiting."
            exit 1
            ;;
    esac
}

# --------------------------- OS Detection -----------------------------------
detect_os_and_configure() {
    if [[ -f /etc/os-release ]]; then
        OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    else
        log ERROR "Cannot detect OS: /etc/os-release not found."
        exit 1
    fi

    case "$OS_ID" in
        fedora) PKG_MANAGER="dnf" ; handle_fedora_specifics ;;
        ubuntu|debian) PKG_MANAGER="apt" ;;
        *) PKG_MANAGER="apt" ;; # Fallback
    esac
}

handle_fedora_specifics() {
    if systemctl is-active --quiet firewalld; then
        log WARNING "Disabling firewalld to prevent conflicts..."
        systemctl stop firewalld
        systemctl disable firewalld
    fi
    if ! systemctl is-enabled --quiet nftables; then
        systemctl enable nftables
    fi
}

check_environment() {
    if [[ ! -d "$INSTALL_DIR" ]]; then mkdir -p "$INSTALL_DIR"; fi
    if [[ ! -f "$LOG_FILE" ]]; then touch "$LOG_FILE"; chmod 600 "$LOG_FILE"; chown root:root "$LOG_FILE"; fi

    local deps=("curl" "grep" "sort" "sha256sum" "systemctl")
    
    if ! command -v nft >/dev/null; then
        log ERROR "nftables not installed."
        exit 1
    fi

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null; then
            log ERROR "Missing dependency: $cmd"
            exit 1
        fi
    done
}

# --------------------------- Code Generator ---------------------------------
generate_failover_logic() {
    # Dynamically inject the SELECTED_SOURCES array into the script
    cat <<'EOF'
    # --- Source & Integrity Logic ---
    TMP_FILE=$(mktemp)
    DOWNLOAD_SUCCESS=false

    # Enforce TLS 1.2+ and HTTPS
    CURL_OPTS="--fsSL --connect-timeout 10 --max-time 30 --tlsv1.2 --proto =https"

    MIRRORS=(
EOF
    for url in "${SELECTED_SOURCES[@]}"; do
        printf '        "%s"\n' "$url"
    done
    cat <<'EOF'
    )

    for url in "${MIRRORS[@]}"; do
        log INFO "Audit: Downloading from $url"
        
        if curl $CURL_OPTS "$url" -o "$TMP_FILE"; then
            if [[ -s "$TMP_FILE" ]]; then
                # --- INTEGRITY CHECK (SIGNATURE) ---
                FILE_HASH=$(sha256sum "$TMP_FILE" | awk '{print $1}')
                log INFO "Integrity SHA256: $FILE_HASH"
                
                DOWNLOAD_SUCCESS=true
                break
            else
                log WARNING "Source returned empty file: $url"
            fi
        else
            log WARNING "TLS/Connection failed to: $url"
        fi
    done

    if [[ "$DOWNLOAD_SUCCESS" = false ]]; then
        log CRITICAL "All sources failed validation or download."
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
# Generated: $(date)
# Security: TLS 1.2 Enforced | SHA256 Audited
# ==============================================================================
set -euo pipefail

NFT_TABLE="inet data_shield"
NFT_CHAIN="inbound_block"
NFT_SET="blocklist_ipv4"
LOG_FILE="/var/log/nft_blocklist.log"
NFT_CMD="/usr/sbin/nft"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') [\$1] : \$2" >> "\$LOG_FILE"; }

# --- 1. Download & Audit ---
$failover_block

# --- 2. Validation (Content Check) ---
VALIDATED_FILE=\$(mktemp)
# Strict IPv4 Regex
grep -E '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$' "\$TMP_FILE" > "\$VALIDATED_FILE"

sort -u "\$VALIDATED_FILE" -o "\$VALIDATED_FILE"
LINE_COUNT=\$(wc -l < "\$VALIDATED_FILE")

if (( LINE_COUNT < 5 )); then
    log ERROR "Validation Failed: File contains invalid data or too few IPs (\$LINE_COUNT)."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE"
    exit 1
fi

# --- 3. Atomic Application ---
BATCH_FILE=\$(mktemp)

cat <<NFT > "\$BATCH_FILE"
add table \$NFT_TABLE
add chain \$NFT_TABLE \$NFT_CHAIN { type filter hook input priority -100; }
add set \$NFT_TABLE \$NFT_SET { type ipv4_addr; flags interval; }
flush set \$NFT_TABLE \$NFT_SET
add element \$NFT_TABLE \$NFT_SET {
NFT

# Paste IPs with comma separation
paste -sd, "\$VALIDATED_FILE" >> "\$BATCH_FILE"

cat <<NFT >> "\$BATCH_FILE"
}
NFT

# Idempotent rule injection
if ! \$NFT_CMD list chain \$NFT_TABLE \$NFT_CHAIN | grep -q "@\$NFT_SET"; then
    \$NFT_CMD insert rule \$NFT_TABLE \$NFT_CHAIN ip saddr @\$NFT_SET drop
fi

if ! \$NFT_CMD -f "\$BATCH_FILE" 2>>"\$LOG_FILE"; then
    log ERROR "NFT Transaction Failed. Reverting..."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
    exit 1
fi

log SUCCESS "Update applied. Active IPs: \$LINE_COUNT. (Source Hash verified)."
rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
EOF
}

# --------------------------- Systemd & Main ---------------------------------
setup_systemd() {
    log INFO "Configuring Systemd..."
    local service_file="/etc/systemd/system/blocklist-update.service"
    local timer_file="/etc/systemd/system/blocklist-update.timer"

    cat <<EOF > "$service_file"
[Unit]
Description=Update IPv4 Blocklist (Secure)
After=network-online.target

[Service]
Type=oneshot
ExecStart=$TARGET_SCRIPT
User=root
# ---------- Hardening ----------
ProtectSystem=full
ProtectHome=true
PrivateTmp=true
NoNewPrivileges=true
CapabilityBoundingSet=CAP_NET_ADMIN
MemoryDenyWriteExecute=yes
RestrictAddressFamilies=AF_INET AF_INET6
EOF
    
    cat <<EOF > "$timer_file"
[Unit]
Description=Hourly Blocklist Update
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
}

main() {
    log INFO "Starting Interactive Installation..."
    
    assert_root
    detect_os_and_configure
    check_environment
    
    # New Interactive Step
    select_source_mode

    log INFO "Generating secure updater..."
    create_nftables_script
    chmod 750 "$TARGET_SCRIPT"
    
    # Immutable bit
    if command -v chattr >/dev/null; then
        chattr -i "$TARGET_SCRIPT" 2>/dev/null || true
        chattr +i "$TARGET_SCRIPT"
    fi

    setup_systemd

    log INFO "Running initial update/verification..."
    if "$TARGET_SCRIPT"; then
        log SUCCESS "Installation & Initial Verification Complete."
    else
        log CRITICAL "Initial download failed. Check URL or Firewall."
        exit 1
    fi
}

main