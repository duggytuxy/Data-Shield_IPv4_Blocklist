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
# Author:      Duggy Tuxy (Laurent M.)
# ==============================================================================
#
# ------------------------------------------------------------------------------

# --------------------------- Strict mode & safety ---------------------------
set -euo pipefail
IFS=$'\n\t'

# --------------------------- Configuration constants -------------------------
readonly SOURCES=(
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
    "https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
)

readonly INSTALL_DIR="/usr/local/bin"
readonly TARGET_SCRIPT="${INSTALL_DIR}/update_blocklist.sh"
readonly LOG_FILE="/var/log/blocklist_manager_install.log"

# --------------------------- Visual feedback --------------------------------
readonly C_RESET='\033[0m'
readonly C_INFO='\033[0;34m'
readonly C_OK='\033[0;32m'
readonly C_WARN='\033[0;33m'
readonly C_ERR='\033[0;31m'
readonly C_CRIT='\033[1;31m'   # bold red for CRITICAL

# Global variables for environment detection
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
        CRITICAL)color=$C_CRIT ;;
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

# --------------------------- Safe OS detection ----------------------------
detect_os_and_configure() {
    log INFO "Detecting Operating System..."

    # ----- Safe parsing of /etc/os-release -----------------------------
    if [[ -f /etc/os-release ]]; then
        # Do NOT source the file – parse only the ID field
        OS_ID=$(grep '^ID=' /etc/os-release | cut -d= -f2 | tr -d '"')
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
            log WARNING "Unknown OS ($OS_ID). Assuming Debian-style."
            PKG_MANAGER="apt"
            ;;
    esac
}

handle_fedora_specifics() {
    log INFO "Applying Fedora-specific configurations..."

    # ----- Graceful handling of firewalld ------------------------------
    if systemctl is-active --quiet firewalld; then
        log WARNING "Firewalld is active – disabling to avoid NFTables conflict."
        systemctl stop firewalld
        systemctl disable firewalld
        log SUCCESS "Firewalld stopped and disabled."
    fi

    # Ensure native nftables service is enabled
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

    # ----- Secure log file creation ------------------------------------
    if [[ ! -f "$LOG_FILE" ]]; then
        touch "$LOG_FILE"
        chmod 600 "$LOG_FILE"
        chown root:root "$LOG_FILE"
    fi

    local deps=("curl" "grep" "awk" "sed" "systemctl")
    local missing=()

    # Verify nftables backend
    if command -v nft >/dev/null; then
        log SUCCESS "Firewall backend detected: nftables"
    else
        log ERROR "nftables is not installed."
        if [[ "$PKG_MANAGER" == "dnf" ]]; then
            log INFO "Install with: dnf install nftables"
        else
            log INFO "Install with: apt update && apt install nftables"
        fi
        exit 1
    fi

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null; then
            missing+=("$cmd")
        fi
    done

    if (( ${#missing[@]} )); then
        log ERROR "Missing dependencies: ${missing[*]}"
        log INFO "Install with: $PKG_MANAGER install ${missing[*]}"
        exit 1
    fi
}

# --------------------------- Code generators -------------------------------
generate_failover_logic() {
    cat <<'EOF'
    # --- Failover Logic ---
    TMP_FILE=$(mktemp)
    DOWNLOAD_SUCCESS=false

    MIRRORS=(
EOF
    # ----- Escape URLs safely before injection -------------------------
    for url in "${SOURCES[@]}"; do
        printf '        "%s"\n' "$url"
    done
    cat <<'EOF'
    )

    for url in "${MIRRORS[@]}"; do
        log INFO "Attempting download from: $url"
        if curl -fsSL --connect-timeout 5 --max-time 15 "$url" -o "$TMP_FILE"; then
            if [[ -s "$TMP_FILE" ]]; then
                log INFO "Download successful."
                DOWNLOAD_SUCCESS=true
                break
            else
                log WARNING "Empty file received from $url"
            fi
        else
            log WARNING "Connection failed to $url"
        fi
    done

    if [[ "$DOWNLOAD_SUCCESS" = false ]]; then
        log CRITICAL "All mirrors failed – aborting update."
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

# --------------------------- Configuration -------------------------------
NFT_TABLE="inet data_shield"
NFT_CHAIN="inbound_block"
NFT_SET="blocklist_ipv4"
LOG_FILE="/var/log/nft_blocklist.log"
NFT_CMD="/usr/sbin/nft"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') [\$1] : \$2" >> "\$LOG_FILE"; }

# --------------------------- Download blocklist ----------------------
$failover_block

# --------------------------- Validate IPs ---------------------------
VALIDATED_FILE=\$(mktemp)
grep -E '^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\$' "\$TMP_FILE" > "\$VALIDATED_FILE"

# Remove duplicates and sort
sort -u "\$VALIDATED_FILE" -o "\$VALIDATED_FILE"

LINE_COUNT=\$(wc -l < "\$VALIDATED_FILE")
if (( LINE_COUNT < 10 )); then
    log ERROR "Validated file too small (\$LINE_COUNT lines). Abort."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE"
    exit 1
fi

# --------------------------- Build atomic nft batch -----------------
BATCH_FILE=\$(mktemp)

cat <<NFT > "\$BATCH_FILE"
add table \$NFT_TABLE
add chain \$NFT_TABLE \$NFT_CHAIN { type filter hook input priority -100; }
add set \$NFT_TABLE \$NFT_SET { type ipv4_addr; flags interval; }
flush set \$NFT_TABLE \$NFT_SET
add element \$NFT_TABLE \$NFT_SET {
NFT

# Build a comma-separated list without a trailing comma
ELEMENTS=\$(paste -sd, "\$VALIDATED_FILE")
printf "    %s\n" "\$ELEMENTS" >> "\$BATCH_FILE"

cat <<NFT >> "\$BATCH_FILE"
}
NFT

# Ensure the rule exists (idempotent)
if ! \$NFT_CMD list chain \$NFT_TABLE \$NFT_CHAIN | grep -q "@\$NFT_SET"; then
    \$NFT_CMD insert rule \$NFT_TABLE \$NFT_CHAIN ip saddr @\$NFT_SET drop
    log INFO "Blocking rule injected with high priority."
fi
NFT

# --------------------------- Apply transaction --------------------
if ! \$NFT_CMD -f "\$BATCH_FILE" 2>>"\$LOG_FILE"; then
    log ERROR "nft transaction failed – see log."
    rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
    exit 1
fi
log SUCCESS "Blocklist updated – \$LINE_COUNT IPs active."

# --------------------------- Cleanup ------------------------------------
rm -f "\$TMP_FILE" "\$VALIDATED_FILE" "\$BATCH_FILE"
EOF
}

# --------------------------- Systemd automation -------------------------
setup_systemd() {
    log INFO "Configuring Systemd automation..."

    local service_file="/etc/systemd/system/blocklist-update.service"
    local timer_file="/etc/systemd/system/blocklist-update.timer"

    cat <<EOF > "$service_file"
[Unit]
Description=Update IPv4 Blocklist Firewall Rules
After=network-online.target
Wants=network-online.target

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
RuntimeMaxSec=300
EOF

    cat <<EOF > "$timer_file"
[Unit]
Description=Run blocklist update hourly

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
    log SUCCESS "Systemd timer and service enabled."
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

# --------------------------- Main execution flow -------------------------
main() {
    log INFO "Starting Blocklist Manager Installation (UFW-Safe edition)…"

    assert_root
    detect_os_and_configure
    check_environment

    log INFO "Generating high-priority NFTables updater at $TARGET_SCRIPT…"
    create_nftables_script
    chmod 750 "$TARGET_SCRIPT"

    # ----- Immutable lock (prevent tampering) -------------------------
    if lsattr "$TARGET_SCRIPT" 2>/dev/null | grep -q "i"; then
        chattr -i "$TARGET_SCRIPT"
    fi
    chattr +i "$TARGET_SCRIPT"

    # Fedora-specific SELinux context
    if [[ "$OS_ID" == "fedora" ]] && command -v restorecon >/dev/null; then
        log INFO "Applying SELinux context to script..."
        restorecon -v "$TARGET_SCRIPT"
    fi

    setup_systemd
    setup_logrotate

    log INFO "Running initial blocklist update…"
    if "$TARGET_SCRIPT"; then
        log SUCCESS "Installation complete."
        log INFO "Blocklist active in table 'inet data_shield' (priority –100)."
        log INFO "Runs safely alongside UFW."
    else
        log CRITICAL "Initial update failed – inspect /var/log/nft_blocklist.log."
        exit 1
    fi
}

main