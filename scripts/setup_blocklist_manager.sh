#!/bin/bash
# ==============================================================================
# Script Name: setup_blocklist_manager.sh
# Version:     0.1.03 (Release Candidate 3)
# Description: Interactive installer for IPv4 Blocklist updater.
#              Features: Source Failover, Path Hardening, PGP/SHA256,
#              Atomic Updates, Strict IP Validation, Immutable Locking,
#              Secure Storage, Systemd Timer & Re-run Safety.
# Author:      Duggy Tuxy (Laurent M.)
# ==============================================================================

set -euo pipefail

# --- Configuration ---
SOURCES=(
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
    "https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_data-shield_ipv4_blocklist.txt"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
)

GENERATED_SCRIPT_PATH="/usr/local/bin/update_blocklist.sh"
SELECTED_URL=""
SECURITY_MODE="none" # none, sha256, pgp
PGP_KEY_URL=""

# --- Colors for UX ---
NC="\e[0m"
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
CYAN="\e[36m"

# --- Dynamic Path Discovery (Anti-Tampering) ---
CMD_BASH=$(command -v bash || echo "/bin/bash")
CMD_IPTABLES=$(command -v iptables || echo "/sbin/iptables")
CMD_IPSET=$(command -v ipset || echo "/sbin/ipset")
CMD_NFT=$(command -v nft || echo "/usr/sbin/nft")
CMD_CURL=$(command -v curl || echo "/usr/bin/curl")
CMD_RM=$(command -v rm || echo "/bin/rm")
CMD_CHMOD=$(command -v chmod || echo "/bin/chmod")
CMD_CHATTR=$(command -v chattr || echo "/usr/bin/chattr")
CMD_LSATTR=$(command -v lsattr || echo "/usr/bin/lsattr")
CMD_GPG=$(command -v gpg || echo "/usr/bin/gpg")
CMD_SYSTEMCTL=$(command -v systemctl || echo "/bin/systemctl")

# --- Helper Functions ---
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_input() { echo -e "${YELLOW}[INPUT]${NC} $1"; }

check_root() {
    if [[ $EUID -ne 0 ]]; then
       log_error "This script must be run as root (sudo)." 
       exit 1
    fi
}

check_dependencies() {
    local missing_deps=()
    if ! command -v curl &>/dev/null; then missing_deps+=("curl"); fi
    if ! command -v awk &>/dev/null; then missing_deps+=("awk"); fi
    if ! command -v grep &>/dev/null; then missing_deps+=("grep"); fi
    
    local has_fw=false
    if command -v iptables &>/dev/null && command -v ipset &>/dev/null; then has_fw=true; fi
    if command -v nft &>/dev/null; then has_fw=true; fi
    
    if [[ "$has_fw" == false ]]; then missing_deps+=("iptables+ipset or nftables"); fi
    
    if [[ ${#missing_deps[@]} -gt 0 ]]; then
        log_error "Missing dependencies: ${missing_deps[*]}"
        exit 1
    fi
    log_success "All base dependencies are installed."
}

# --- Step 0: Pre-flight Cleanup (Fix for Immutable Trap) ---
unlock_existing_script() {
    if [[ -f "$GENERATED_SCRIPT_PATH" ]]; then
        # Check if file is immutable (has 'i' attribute)
        if $CMD_LSATTR "$GENERATED_SCRIPT_PATH" 2>/dev/null | grep -q "i"; then
            log_info "Existing script is locked (immutable). Unlocking for update..."
            $CMD_CHATTR -i "$GENERATED_SCRIPT_PATH" || {
                log_error "Failed to unlock $GENERATED_SCRIPT_PATH. Cannot overwrite."
                exit 1
            }
        fi
    fi
}

# --- Step 1: Source Connectivity Test ---
select_working_source() {
    echo ""
    log_info "Step 1: Testing blocklist source connectivity..."
    
    for url in "${SOURCES[@]}"; do
        log_info "Testing: $url"
        # Added timeouts to avoid hanging
        if $CMD_CURL --connect-timeout 5 --max-time 10 -s -I --fail "$url" > /dev/null; then
            SELECTED_URL="$url"
            log_success "Source reachable (HEAD). Selecting: $url"
            break
        elif $CMD_CURL --connect-timeout 5 --max-time 15 -sfL "$url" -o /dev/null; then
            SELECTED_URL="$url"
            log_success "Source reachable (GET). Selecting: $url"
            break
        else
            log_error "Source unreachable, trying next..."
        fi
    done

    if [[ -z "$SELECTED_URL" ]]; then
        log_error "All sources failed. Please check your internet connection."
        exit 1
    fi
}

# --- Step 2: Advanced Security Options ---
configure_security() {
    echo ""
    log_info "Step 2: Integrity & Authenticity"
    echo -e "Choose verification method:"
    echo -e "  1) ${CYAN}SHA256 Hash${NC} (Integrity only - Simple)"
    echo -e "  2) ${CYAN}PGP Signature${NC} (Integrity + Authenticity - High Security)"
    echo -e "  3) ${CYAN}None${NC} (Not recommended)"
    
    log_input "Enter your choice (1/2/3):"
    read -r SEC_CHOICE

    case "$SEC_CHOICE" in
        1)
            SECURITY_MODE="sha256"
            log_info "Selected: SHA256 Verification."
            ;;
        2)
            SECURITY_MODE="pgp"
            if ! command -v gpg &>/dev/null; then
                log_error "'gpg' is not installed. Please install GnuPG to use this feature."
                exit 1
            fi
            log_info "Selected: PGP Signature Verification."
            
            while [[ -z "$PGP_KEY_URL" ]]; do
                log_input "Please enter the URL of the Public Key (.asc/pub):"
                read -r USER_KEY_URL
                # Basic URL validation
                if [[ "$USER_KEY_URL" =~ ^https?:// ]]; then
                    PGP_KEY_URL="$USER_KEY_URL"
                else
                    log_error "Invalid URL. Must start with http:// or https://"
                fi
            done
            ;;
        *)
            SECURITY_MODE="none"
            log_info "Selected: No verification."
            ;;
    esac
}

# --- Step 3: Generate the Script ---
generate_script() {
    echo ""
    log_info "Step 3: Select Firewall Engine"
    log_input "Do you want to create the script for IPtables or NFtables? (Type 'IPtables' or 'NFtables')"
    read -r ENGINE_CHOICE

    local SHEBANG="#!$CMD_BASH"
    
    # Ensure destination is writable
    unlock_existing_script

    case "${ENGINE_CHOICE,,}" in
        iptables)
            log_info "Generating IPtables script..."
            create_iptables_file "$SHEBANG"
            ;;
        nftables)
            log_info "Generating NFtables script..."
            create_nftables_file "$SHEBANG"
            ;;
        *)
            log_error "Invalid choice."
            exit 1
            ;;
    esac

    log_success "Script generated at: $GENERATED_SCRIPT_PATH"
}

# --- Generators ---

get_security_logic() {
    local LOGIC=""
    
    if [[ "$SECURITY_MODE" == "sha256" ]]; then
        LOGIC='
# --- Security: SHA256 Integrity Check ---
HASH_URL="${BLOCKLIST_URL}.sha256"
if curl --connect-timeout 10 --max-time 30 -s --fail "$HASH_URL" -o "$BLOCKLIST_DIR/remote.sha256"; then
    REMOTE_HASH=$(awk "{print \$1}" "$BLOCKLIST_DIR/remote.sha256")
    LOCAL_HASH=$(sha256sum "$TMP_BLOCKLIST" | awk "{print \$1}")
    if [[ "$REMOTE_HASH" != "$LOCAL_HASH" ]]; then
        log "CRITICAL: SHA256 mismatch! Update aborted."
        exit 1
    else
        log "INFO: SHA256 Verified."
    fi
else
    log "WARN: Could not download SHA256 file. Skipping verification."
fi
'
    elif [[ "$SECURITY_MODE" == "pgp" ]]; then
        LOGIC='
# --- Security: PGP Signature Verification ---
# We use an ephemeral keyring to avoid polluting the root user keyring.
PUB_KEY_URL="'"$PGP_KEY_URL"'"
SIG_URL="${BLOCKLIST_URL}.asc"
TMP_KEYRING="$BLOCKLIST_DIR/tmp_keyring.gpg"
TMP_PUBKEY="$BLOCKLIST_DIR/pubkey.asc"
TMP_SIG="$BLOCKLIST_DIR/signature.asc"

# 1. Download Public Key
if ! curl --connect-timeout 10 --max-time 30 -s --fail "$PUB_KEY_URL" -o "$TMP_PUBKEY"; then
    log "CRITICAL: Failed to download Public Key. Aborting."
    exit 1
fi

# 2. Download Detached Signature
if ! curl --connect-timeout 10 --max-time 30 -s --fail "$SIG_URL" -o "$TMP_SIG"; then
    log "CRITICAL: Failed to download PGP Signature. Aborting."
    exit 1
fi

# 3. Verify
# Import key to temp keyring
rm -f "$TMP_KEYRING"
'$CMD_GPG' --no-default-keyring --keyring "$TMP_KEYRING" --import "$TMP_PUBKEY" >/dev/null 2>&1

# Verify data against signature
if '$CMD_GPG' --no-default-keyring --keyring "$TMP_KEYRING" --verify "$TMP_SIG" "$TMP_BLOCKLIST" >/dev/null 2>&1; then
    log "INFO: PGP Signature Verified. Authenticity Confirmed."
else
    log "CRITICAL: PGP Signature INVALID! File may be tampered. Aborting."
    exit 1
fi

# Cleanup auth files
rm -f "$TMP_KEYRING" "$TMP_PUBKEY" "$TMP_SIG"
'
    fi
    echo "$LOGIC"
}

create_iptables_file() {
    local SHEBANG="$1"
    local SECURITY_BLOCK=$(get_security_logic)

cat <<EOF > "$GENERATED_SCRIPT_PATH"
$SHEBANG
set -euo pipefail

# ==============================================================================
# Script: update_blocklist.sh (IPtables/IPSet Version)
# Generated by: setup_blocklist_manager.sh
# ==============================================================================

# --- Variables ---
BLOCKLIST_URL="$SELECTED_URL"
BLOCKLIST_DIR="/etc/iptables_blocklist"
PREVIOUS_BLOCKLIST="\$BLOCKLIST_DIR/previous_blocklist.txt"
CURRENT_BLOCKLIST="\$BLOCKLIST_DIR/current_blocklist.txt"
TMP_BLOCKLIST="\$BLOCKLIST_DIR/tmp_blocklist.txt"
IPSET_SAVE_FILE="\$BLOCKLIST_DIR/ipset_dump.save"
BLOCKLIST_SET_NAME="myblocklist"
LOGFILE="/var/log/ipset_update.log"

# --- Dynamic Paths ---
IPTABLES="$CMD_IPTABLES"
IPSET="$CMD_IPSET"
RM="$CMD_RM"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') : \$*" >> "\$LOGFILE"; }

# --- 1. Secure Preparation ---
# Create directory and set permissions to 700 (Read/Write/Execute for root ONLY)
if [[ ! -d "\$BLOCKLIST_DIR" ]]; then
    mkdir -p "\$BLOCKLIST_DIR"
    chmod 700 "\$BLOCKLIST_DIR"
fi
touch "\$PREVIOUS_BLOCKLIST" "\$LOGFILE"
chmod 600 "\$LOGFILE" # Log file secure too

# --- 2. Secure Download ---
# Added Timeouts to prevent hanging processes
if ! curl --connect-timeout 10 --max-time 60 -s --fail "\$BLOCKLIST_URL" -o "\$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist."
    exit 1
fi

$SECURITY_BLOCK

# --- 3. Strict Validation ---
grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' "\$TMP_BLOCKLIST" | \
awk -F. '\$1<=255 && \$2<=255 && \$3<=255 && \$4<=255' | \
sort -u > "\$CURRENT_BLOCKLIST"

if [[ ! -s "\$CURRENT_BLOCKLIST" ]]; then
    log "ERROR: Blocklist is empty after validation. Aborting."
    exit 1
fi

log "INFO: \$(wc -l < "\$CURRENT_BLOCKLIST") valid IPs loaded."

# --- 4. Atomic Update (Swap) ---
TMP_SET_NAME="\${BLOCKLIST_SET_NAME}_tmp"

if \$IPSET list -n | grep -q "\$TMP_SET_NAME"; then
    \$IPSET flush "\$TMP_SET_NAME"
else
    \$IPSET create "\$TMP_SET_NAME" hash:ip
fi

while read -r IP; do
    \$IPSET add "\$TMP_SET_NAME" "\$IP" 2>/dev/null || true
done < "\$CURRENT_BLOCKLIST"

if \$IPSET list -n | grep -q "\$BLOCKLIST_SET_NAME"; then
    \$IPSET swap "\$TMP_SET_NAME" "\$BLOCKLIST_SET_NAME"
    \$IPSET destroy "\$TMP_SET_NAME"
else
    \$IPSET rename "\$TMP_SET_NAME" "\$BLOCKLIST_SET_NAME"
fi

# --- 5. Persistence ---
\$IPSET save > "\$IPSET_SAVE_FILE"
chmod 600 "\$IPSET_SAVE_FILE"

# --- 6. Firewall Rule ---
if ! \$IPTABLES -C INPUT -m set --match-set "\$BLOCKLIST_SET_NAME" src -j DROP 2>/dev/null; then
    \$IPTABLES -I INPUT -m set --match-set "\$BLOCKLIST_SET_NAME" src -j DROP
    log "INFO: Added IPtables rule."
fi

# --- 7. Logging & Cleanup ---
comm -23 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "REMOVED: \$IP"; done
comm -13 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "ADDED: \$IP"; done

cp "\$CURRENT_BLOCKLIST" "\$PREVIOUS_BLOCKLIST"
\$RM -f "\$TMP_BLOCKLIST"

log "INFO: Update completed successfully."
EOF
}

create_nftables_file() {
    local SHEBANG="$1"
    local SECURITY_BLOCK=$(get_security_logic)

cat <<EOF > "$GENERATED_SCRIPT_PATH"
$SHEBANG
set -euo pipefail

# ==============================================================================
# Script: update_blocklist.sh (NFtables Version)
# Generated by: setup_blocklist_manager.sh
# ==============================================================================

# --- Variables ---
BLOCKLIST_URL="$SELECTED_URL"
BLOCKLIST_DIR="/etc/nftables_blocklist"
PREVIOUS_BLOCKLIST="\$BLOCKLIST_DIR/previous_blocklist.txt"
CURRENT_BLOCKLIST="\$BLOCKLIST_DIR/current_blocklist.txt"
TMP_BLOCKLIST="\$BLOCKLIST_DIR/tmp_blocklist.txt"
NFT_SAVE_FILE="\$BLOCKLIST_DIR/nftables_blocklist.nft"
LOGFILE="/var/log/nft_blocklist_update.log"

NFT_TABLE="inet filter"
NFT_CHAIN="input"
NFT_SET="blocklist_ipv4"

# --- Dynamic Paths ---
NFT="$CMD_NFT"
RM="$CMD_RM"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') : \$*" >> "\$LOGFILE"; }

# --- 1. Secure Preparation ---
if [[ ! -d "\$BLOCKLIST_DIR" ]]; then
    mkdir -p "\$BLOCKLIST_DIR"
    chmod 700 "\$BLOCKLIST_DIR"
fi
touch "\$PREVIOUS_BLOCKLIST" "\$LOGFILE"
chmod 600 "\$LOGFILE"

# --- 2. Secure Download ---
if ! curl --connect-timeout 10 --max-time 60 -s --fail "\$BLOCKLIST_URL" -o "\$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist."
    exit 1
fi

$SECURITY_BLOCK

# --- 3. Strict Validation ---
grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' "\$TMP_BLOCKLIST" | \
awk -F. '\$1<=255 && \$2<=255 && \$3<=255 && \$4<=255' | \
sort -u > "\$CURRENT_BLOCKLIST"

if [[ ! -s "\$CURRENT_BLOCKLIST" ]]; then
    log "ERROR: Blocklist is empty after validation. Aborting."
    exit 1
fi

log "INFO: \$(wc -l < "\$CURRENT_BLOCKLIST") valid IPs loaded."

# --- 4. NFtables Structure ---
if ! \$NFT list table \$NFT_TABLE >/dev/null 2>&1; then
    \$NFT add table \$NFT_TABLE
fi
if ! \$NFT list set \$NFT_TABLE \$NFT_SET >/dev/null 2>&1; then
    \$NFT add set \$NFT_TABLE \$NFT_SET '{ type ipv4_addr; flags interval; }'
fi

# --- 5. Atomic Update ---
\$NFT flush set \$NFT_TABLE \$NFT_SET
while read -r IP; do
    \$NFT add element \$NFT_TABLE \$NFT_SET { \$IP } 2>/dev/null || log "WARN: Could not add \$IP"
done < "\$CURRENT_BLOCKLIST"

# --- 6. Enforce Rule ---
if ! \$NFT list chain \$NFT_TABLE input | grep -q "\$NFT_SET"; then
    \$NFT insert rule \$NFT_TABLE input ip saddr @\${NFT_SET} drop
    log "INFO: Rule added to block IPs"
fi

# --- 7. Persistence ---
\$NFT list table \$NFT_TABLE > "\$NFT_SAVE_FILE"
chmod 600 "\$NFT_SAVE_FILE"

# --- 8. Logging & Cleanup ---
comm -23 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "REMOVED: \$IP"; done
comm -13 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "ADDED: \$IP"; done

cp "\$CURRENT_BLOCKLIST" "\$PREVIOUS_BLOCKLIST"
\$RM -f "\$TMP_BLOCKLIST"

log "INFO: Update completed successfully."
EOF
}

# --- Step 4: Permissions & Security Locking ---
setup_permissions() {
    echo ""
    log_info "Step 4: Execution Permissions & Security"
    log_input "Do you want to make the script executable? (yes/no)"
    read -r PERM_CHOICE

    if [[ "${PERM_CHOICE,,}" == "yes" || "${PERM_CHOICE,,}" == "y" ]]; then
        $CMD_CHMOD +x "$GENERATED_SCRIPT_PATH"
        log_success "Permissions granted."
        
        log_input "Do you want to LOCK the file (immutable bit)? (yes/no)"
        read -r LOCK_CHOICE
        if [[ "${LOCK_CHOICE,,}" == "yes" || "${LOCK_CHOICE,,}" == "y" ]]; then
            if command -v chattr &>/dev/null; then
                chattr +i "$GENERATED_SCRIPT_PATH"
                log_success "File locked (immutable)."
            else
                log_error "'chattr' not found. Skipping lock."
            fi
        fi
    else
        log_info "Skipping permissions."
        exit 0
    fi
}

# --- Step 5: Automation (Systemd/Cron) ---
setup_automation() {
    echo ""
    log_info "Step 5: Automation"
    echo -e "Choose an automation method:"
    echo -e "  1) ${CYAN}Systemd Timer${NC} (Recommended - Better logs & dependency handling)"
    echo -e "  2) ${CYAN}Cron Job${NC} (Legacy - Simple)"
    echo -e "  3) ${CYAN}None${NC}"
    
    log_input "Enter your choice (1/2/3):"
    read -r AUTO_CHOICE

    case "$AUTO_CHOICE" in
        1)
            setup_systemd_timer
            ;;
        2)
            setup_cron_job
            ;;
        *)
            log_info "No automation configured."
            ;;
    esac
}

setup_systemd_timer() {
    if ! command -v systemctl &>/dev/null; then
        log_error "Systemd is not available. Falling back to Cron."
        setup_cron_job
        return
    fi

    log_info "Configuring Systemd Timer..."
    
    SERVICE_FILE="/etc/systemd/system/blocklist-update.service"
    TIMER_FILE="/etc/systemd/system/blocklist-update.timer"

    # Create Service
    cat <<EOF > "$SERVICE_FILE"
[Unit]
Description=Update IPv4 Blocklist
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot
ExecStart=$GENERATED_SCRIPT_PATH
User=root
EOF

    # Create Timer (Hourly)
    cat <<EOF > "$TIMER_FILE"
[Unit]
Description=Run blocklist update every hour

[Timer]
OnCalendar=hourly
Persistent=true
Unit=blocklist-update.service

[Install]
WantedBy=timers.target
EOF

    # Enable and Reload
    $CMD_SYSTEMCTL daemon-reload
    $CMD_SYSTEMCTL enable --now blocklist-update.timer
    # If timer was already running, restart it to apply changes
    $CMD_SYSTEMCTL restart blocklist-update.timer
    
    log_success "Systemd timer enabled and started."
}

setup_cron_job() {
    log_info "Configuring Cron Job..."
    if crontab -l 2>/dev/null | grep -q "$GENERATED_SCRIPT_PATH"; then
            log_info "Cron job already exists."
    else
        (crontab -l 2>/dev/null; echo "0 * * * * $GENERATED_SCRIPT_PATH >/dev/null 2>&1") | crontab -
        log_success "Cron job added (Hourly)."
    fi
}

# --- Main Flow ---
check_root
check_dependencies
select_working_source
configure_security
generate_script
setup_permissions
setup_automation

echo ""
log_success "Installation complete. System secured."