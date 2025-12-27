#!/bin/bash
# ==============================================================================
# Script Name: install_blocklist_manager.sh
# Version:     v0.3.04
# Description: Enterprise-grade installer for an IPv4 Blocklist Manager.
#              Features:
#               - Interactive Source Selection
#               - Strict TLS 1.2+ & Integrity Audit
#               - Atomic NFTables Updates
#               - Systemd Hardening
#               - Idempotent Installation (Safe Updates)
#               - Full Uninstallation Support
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
readonly SERVICE_NAME="blocklist-update"

# Default Official Sources
readonly OFFICIAL_SOURCES=(
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
	"https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
)

# Mutable global variables
SELECTED_SOURCES=()
PKG_MANAGER=""
OS_ID=""

# --------------------------- Visual feedback --------------------------------
readonly C_RESET='\033[0m'
readonly C_INFO='\033[0;34m'
readonly C_OK='\033[0;32m'
readonly C_WARN='\033[0;33m'
readonly C_ERR='\033[0;31m'
readonly C_QUESTION='\033[0;36m'

# --------------------------- Helper functions -------------------------------
log() {
    local level=$1
    local msg=$2
    local color=$C_INFO
    case $level in
        SUCCESS) color=$C_OK ;;
        WARNING) color=$C_WARN ;;
        ERROR|CRITICAL)   color=$C_ERR ;;
        QUESTION) color=$C_QUESTION ;;
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

# --------------------------- Lifecycle Management ---------------------------

# Function: uninstall
# Description: Completely removes the application, logs, services, and firewall rules.
uninstall() {
    log WARNING "Starting Uninstallation process..."

    # 1. Stop and Disable Systemd Services
    if systemctl list-units --full -all | grep -q "${SERVICE_NAME}.timer"; then
        systemctl stop "${SERVICE_NAME}.timer" "${SERVICE_NAME}.service" || true
        systemctl disable "${SERVICE_NAME}.timer" "${SERVICE_NAME}.service" || true
        log INFO "Systemd services stopped and disabled."
    fi

    rm -f "/etc/systemd/system/${SERVICE_NAME}.service"
    rm -f "/etc/systemd/system/${SERVICE_NAME}.timer"
    systemctl daemon-reload

    # 2. Remove Target Script (Handle Immutable Bit)
    if [[ -f "$TARGET_SCRIPT" ]]; then
        if command -v chattr >/dev/null; then
            chattr -i "$TARGET_SCRIPT" 2>/dev/null || true
            log INFO "Immutable bit removed from target script."
        fi
        rm -f "$TARGET_SCRIPT"
        log INFO "Removed script: $TARGET_SCRIPT"
    fi

    # 3. Clean Logs
    rm -f "$LOG_FILE"
    rm -f "/var/log/nft_blocklist.log"

    # 4. Clean Nftables (Optional but cleaner)
    if command -v nft >/dev/null; then
        if nft list tables | grep -q "data_shield"; then
            nft delete table inet data_shield 2>/dev/null || true
            log INFO "Nftables table 'data_shield' removed."
        fi
    fi

    echo -e "${C_OK}[SUCCESS] Uninstallation complete. System is clean.${C_RESET}"
    exit 0
}

# Function: prepare_target_environment
# Description: Ensures we can write to the target file (removes immutable bit if exists).
#              This enables "Idempotence" (safe re-installation/update).
prepare_target_environment() {
    if [[ -f "$TARGET_SCRIPT" ]]; then
        log INFO "Existing installation detected. Preparing for update..."
        if command -v chattr >/dev/null; then
            # Unlock the file so we can overwrite it
            chattr -i "$TARGET_SCRIPT" 2>/dev/null || true
        fi
    fi
}

# --------------------------- User Interaction -------------------------------
validate_url() {
    local url="$1"
    if [[ ! "$url" =~ ^https:// ]]; then
        log ERROR "Invalid Protocol. Only HTTPS is accepted."
        return 1
    fi
    log INFO "Verifying connectivity/TLS: $url"
    if curl --output /dev/null --silent --head --fail --tlsv1.2 --proto =https "$url"; then
        return 0
    else
        log ERROR "URL unreachable or TLS < 1.2."
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
                custom_url=$(echo "$custom_url" | xargs)
                if validate_url "$custom_url"; then
                    SELECTED_SOURCES=("$custom_url")
                    log SUCCESS "Custom source verified."
                    break
                else
                    log WARNING "Invalid URL. Try again."
                fi
            done
            ;;
        *)
            log ERROR "Invalid selection."
            exit 1
            ;;
    esac
}

# --------------------------- OS & Env ---------------------------------------
detect_os_and_configure() {
    if [[ -f /etc/os-release ]]; then
        OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
    else
        log ERROR "Cannot detect OS."
        exit 1
    fi

    case "$OS_ID" in
        fedora) handle_fedora_specifics ;;
        *) ;;
    esac
}

handle_fedora_specifics() {
    # Added user prompt for safety
    if systemctl is-active --quiet firewalld; then
        echo -e "${C_WARN}WARNING: Firewalld is active and conflicts with pure Nftables.${C_RESET}"
        echo -n "Do you want to disable Firewalld? [y/N]: "
        read -r confirm
        if [[ "$confirm" =~ ^[Yy]$ ]]; then
            log INFO "Disabling firewalld..."
            systemctl stop firewalld
            systemctl disable firewalld
        else
            log ERROR "Aborted by user. Cannot proceed with Firewalld active."
            exit 1
        fi
    fi
    if ! systemctl is-enabled --quiet nftables; then
        systemctl enable nftables
    fi
}

check_environment() {
    if [[ ! -d "$INSTALL_DIR" ]]; then mkdir -p "$INSTALL_DIR"; fi
    if [[ ! -f "$LOG_FILE" ]]; then touch "$LOG_FILE"; chmod 600 "$LOG_FILE"; fi

    local deps=("curl" "grep" "sort" "sha256sum" "systemctl")
    if ! command -v nft >/dev/null; then log ERROR "nftables missing."; exit 1; fi

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null; then log ERROR "Missing dependency: $cmd"; exit 1; fi
    done
}

# --------------------------- Generator --------------------------------------
generate_failover_logic() {
    cat <<'EOF'
    # --- Source & Integrity Logic ---
    TMP_FILE=$(mktemp)
    DOWNLOAD_SUCCESS=false
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
                FILE_HASH=$(sha256sum "$TMP_FILE" | awk '{print $1}')
                log INFO "Integrity SHA256: $FILE_HASH"
                DOWNLOAD_SUCCESS=true
                break
            fi
        fi
    done

    if [[ "$DOWNLOAD_SUCCESS" = false ]]; then
        log CRITICAL "All sources failed."
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

# --- 2. Validation ---
VALIDATED_FILE=\$(mktemp)
grep -E '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$' "\$TMP_FILE" > "\$VALIDATED_FILE"
sort -u "\$VALIDATED_FILE" -o "\$VALIDATED_FILE"
LINE_COUNT=\$(wc -l < "\$VALIDATED_FILE")

if (( LINE_COUNT < 5 )); then
    log ERROR "Validation Failed: Too few IPs (\$LINE_COUNT)."
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

paste -sd, "\$VALIDATED_FILE" >> "\$BATCH_FILE"
echo "}" >> "\$BATCH_FILE"

if ! \$NFT_CMD list chain \$NFT_TABLE \$NFT_CHAIN | grep -q "@\$NFT_SET"; then
    \$NFT_CMD insert rule \$NFT_TABLE \$NFT_CHAIN ip saddr @\$NFT_SET drop
fi

if ! \$NFT_CMD -f "\$BATCH_FILE" 2>>"\$LOG_FILE"; then
    log ERROR "NFT Transaction Failed."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
    exit 1
fi

log SUCCESS "Update applied. IPs: \$LINE_COUNT."
rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
EOF
}

setup_systemd() {
    log INFO "Configuring Systemd..."
    local service_file="/etc/systemd/system/${SERVICE_NAME}.service"
    local timer_file="/etc/systemd/system/${SERVICE_NAME}.timer"

    cat <<EOF > "$service_file"
[Unit]
Description=Update IPv4 Blocklist (Secure)
After=network-online.target
[Service]
Type=oneshot
ExecStart=$TARGET_SCRIPT
User=root
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
    systemctl enable --now "${SERVICE_NAME}.timer"
    systemctl enable "${SERVICE_NAME}.service"
}

# --------------------------- Main -------------------------------------------
main() {
    assert_root
    
    # Check for arguments (Uninstallation)
    if [[ "${1:-}" == "--uninstall" ]]; then
        uninstall
    fi

    log INFO "Starting Installation (v0.3.04)..."
    detect_os_and_configure
    check_environment
    
    select_source_mode

    # Prepare environment (Unlock existing file if update)
    prepare_target_environment

    log INFO "Generating secure updater..."
    create_nftables_script
    chmod 750 "$TARGET_SCRIPT"
    
    # Immutable bit (Locking the file)
    if command -v chattr >/dev/null; then
        chattr +i "$TARGET_SCRIPT"
    fi

    setup_systemd

    log INFO "Running initial update/verification..."
    if "$TARGET_SCRIPT"; then
        log SUCCESS "Installation & Initial Verification Complete."
    else
        log CRITICAL "Initial download failed. Check Internet or Firewall."
        exit 1
    fi
}

# Pass all arguments to main
main "$@"