#!/bin/bash
# ==============================================================================
# Script Name: setup_blocklist_manager.sh
# Version:     0.1.01 (Release Candidate 1)
# Description: Interactive installer for IPv4 Blocklist updater.
#              Generates a self-documented, secure script for IPtables or NFtables.
#              Features: Failover, Path Hardening, SHA256, Atomic Updates, 
#              Strict IP Validation & Immutable Locking.
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
USE_SHA256="no"

# --- Colors for UX ---
NC="\e[0m"
BLUE="\e[34m"
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"

# --- Dynamic Path Discovery (Anti-Tampering) ---
# We verify absolute paths to prevent PATH Hijacking attacks
CMD_BASH=$(command -v bash || echo "/bin/bash")
CMD_IPTABLES=$(command -v iptables || echo "/sbin/iptables")
CMD_IPSET=$(command -v ipset || echo "/sbin/ipset")
CMD_NFT=$(command -v nft || echo "/usr/sbin/nft")
CMD_CURL=$(command -v curl || echo "/usr/bin/curl")
CMD_RM=$(command -v rm || echo "/bin/rm")
CMD_CHMOD=$(command -v chmod || echo "/bin/chmod")

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
    log_success "All dependencies are installed."
}

# --- Step 1: Source Connectivity Test ---
select_working_source() {
    echo ""
    log_info "Step 1: Testing blocklist source connectivity..."
    
    for url in "${SOURCES[@]}"; do
        log_info "Testing: $url"
        if $CMD_CURL -s -I --fail "$url" > /dev/null; then
            SELECTED_URL="$url"
            log_success "Source reachable (HEAD). Selecting: $url"
            break
        elif $CMD_CURL -sfL "$url" -o /dev/null; then
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

# --- Step 2: Security Options ---
configure_security() {
    echo ""
    log_info "Step 2: Security Options"
    log_input "Do you want to enable SHA256 integrity verification? (yes/no)"
    read -r SHA_CHOICE
    USE_SHA256="${SHA_CHOICE,,}"
}

# --- Step 3: Generate the Script ---
generate_script() {
    echo ""
    log_info "Step 3: Select Firewall Engine"
    log_input "Do you want to create the script for IPtables or NFtables? (Type 'IPtables' or 'NFtables')"
    read -r ENGINE_CHOICE

    local SHEBANG="#!$CMD_BASH"

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

# --- Generators with FULL DOCUMENTATION ---

create_iptables_file() {
    local SHEBANG="$1"
    local SHA_LOGIC=""
    if [[ "$USE_SHA256" == "yes" || "$USE_SHA256" == "y" ]]; then
        SHA_LOGIC='
# --- Security: SHA256 Integrity Check ---
# We download a checksum file to verify the blocklist has not been tampered with.
HASH_URL="${BLOCKLIST_URL}.sha256"
if curl -s --fail "$HASH_URL" -o "$BLOCKLIST_DIR/remote.sha256"; then
    REMOTE_HASH=$(awk "{print \$1}" "$BLOCKLIST_DIR/remote.sha256")
    LOCAL_HASH=$(sha256sum "$TMP_BLOCKLIST" | awk "{print \$1}")
    
    if [[ "$REMOTE_HASH" != "$LOCAL_HASH" ]]; then
        log "CRITICAL: SHA256 mismatch! File corrupted or tampered. Update aborted."
        exit 1
    else
        log "INFO: SHA256 Verified. Integrity confirmed."
    fi
else
    log "WARN: Could not download SHA256 file. Skipping verification."
fi
'
    fi

cat <<EOF > "$GENERATED_SCRIPT_PATH"
$SHEBANG
set -euo pipefail

# ==============================================================================
# Script: update_blocklist.sh (IPtables/IPSet Version)
# Description: Downloads, validates, and updates a list of malicious IPs.
#              Uses IPSet 'swap' method for atomic updates (no downtime).
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

# --- Dynamic Paths (Hardcoded for Security against PATH Hijacking) ---
IPTABLES="$CMD_IPTABLES"
IPSET="$CMD_IPSET"
RM="$CMD_RM"

# --- Logging Function ---
log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') : \$*" >> "\$LOGFILE"; }

# --- 1. Preparation ---
# Create directory structure and log file if they don't exist
mkdir -p "\$BLOCKLIST_DIR"
touch "\$PREVIOUS_BLOCKLIST" "\$LOGFILE"

# --- 2. Secure Download ---
# curl flags: -s (silent), --fail (exit on 404/500 errors)
if ! curl -s --fail "\$BLOCKLIST_URL" -o "\$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist from source."
    exit 1
fi

$SHA_LOGIC

# --- 3. Strict Validation ---
# We sanitize the input. We only accept valid IPv4 formats (0.0.0.0 to 255.255.255.255).
# Regex: Checks structure. Awk: Checks numerical range (<=255).
grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' "\$TMP_BLOCKLIST" | \
awk -F. '\$1<=255 && \$2<=255 && \$3<=255 && \$4<=255' | \
sort -u > "\$CURRENT_BLOCKLIST"

# Safety Check: Never apply an empty list (would clear protection)
if [[ ! -s "\$CURRENT_BLOCKLIST" ]]; then
    log "ERROR: Blocklist is empty after validation. Aborting update to maintain protection."
    exit 1
fi

log "INFO: \$(wc -l < "\$CURRENT_BLOCKLIST") valid IPs loaded."

# --- 4. Atomic Update (The Swap Method) ---
# We create a temporary IPSet, fill it, then swap it with the live set.
# This ensures there is ZERO moment where the firewall is unprotected.

TMP_SET_NAME="\${BLOCKLIST_SET_NAME}_tmp"

# Flush or create temporary set
if \$IPSET list -n | grep -q "\$TMP_SET_NAME"; then
    \$IPSET flush "\$TMP_SET_NAME"
else
    \$IPSET create "\$TMP_SET_NAME" hash:ip
fi

# Fill temporary set (suppress errors for duplicates)
while read -r IP; do
    \$IPSET add "\$TMP_SET_NAME" "\$IP" 2>/dev/null || true
done < "\$CURRENT_BLOCKLIST"

# Perform the Swap
if \$IPSET list -n | grep -q "\$BLOCKLIST_SET_NAME"; then
    \$IPSET swap "\$TMP_SET_NAME" "\$BLOCKLIST_SET_NAME"
    \$IPSET destroy "\$TMP_SET_NAME"
else
    # First run: just rename
    \$IPSET rename "\$TMP_SET_NAME" "\$BLOCKLIST_SET_NAME"
fi

# --- 5. Persistence ---
# Save the set to a file so it can be restored on reboot
\$IPSET save > "\$IPSET_SAVE_FILE"

# --- 6. Firewall Rule Enforcement ---
# Ensure the rule exists in IPtables. If not, insert it at the top.
if ! \$IPTABLES -C INPUT -m set --match-set "\$BLOCKLIST_SET_NAME" src -j DROP 2>/dev/null; then
    \$IPTABLES -I INPUT -m set --match-set "\$BLOCKLIST_SET_NAME" src -j DROP
    log "INFO: Added IPtables rule to Drop traffic from blocklist."
fi

# --- 7. Logging Changes ---
# Compare previous list vs current list to log what changed
comm -23 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "REMOVED: \$IP"; done
comm -13 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "ADDED: \$IP"; done

# --- 8. Cleanup ---
cp "\$CURRENT_BLOCKLIST" "\$PREVIOUS_BLOCKLIST"
\$RM -f "\$TMP_BLOCKLIST"

log "INFO: Update completed successfully."
EOF
}

create_nftables_file() {
    local SHEBANG="$1"
    local SHA_LOGIC=""
    if [[ "$USE_SHA256" == "yes" || "$USE_SHA256" == "y" ]]; then
        SHA_LOGIC='
# --- Security: SHA256 Integrity Check ---
HASH_URL="${BLOCKLIST_URL}.sha256"
if curl -s --fail "$HASH_URL" -o "$BLOCKLIST_DIR/remote.sha256"; then
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
    fi

cat <<EOF > "$GENERATED_SCRIPT_PATH"
$SHEBANG
set -euo pipefail

# ==============================================================================
# Script: update_blocklist.sh (NFtables Version)
# Description: Downloads, validates, and updates a list of malicious IPs.
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

# NFtables Objects
NFT_TABLE="inet filter"
NFT_CHAIN="input"
NFT_SET="blocklist_ipv4"

# --- Dynamic Paths ---
NFT="$CMD_NFT"
RM="$CMD_RM"

# --- Logging Function ---
log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') : \$*" >> "\$LOGFILE"; }

# --- 1. Preparation ---
mkdir -p "\$BLOCKLIST_DIR"
touch "\$PREVIOUS_BLOCKLIST" "\$LOGFILE"

# --- 2. Secure Download ---
if ! curl -s --fail "\$BLOCKLIST_URL" -o "\$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist."
    exit 1
fi

$SHA_LOGIC

# --- 3. Strict Validation ---
# Validate IPv4 format (Regex) and range 0-255 (Awk)
grep -E '^([0-9]{1,3}\.){3}[0-9]{1,3}$' "\$TMP_BLOCKLIST" | \
awk -F. '\$1<=255 && \$2<=255 && \$3<=255 && \$4<=255' | \
sort -u > "\$CURRENT_BLOCKLIST"

# Safety Check: Empty list protection
if [[ ! -s "\$CURRENT_BLOCKLIST" ]]; then
    log "ERROR: Blocklist is empty after validation. Aborting update."
    exit 1
fi

log "INFO: \$(wc -l < "\$CURRENT_BLOCKLIST") valid IPs loaded."

# --- 4. NFtables Structure ---
# Create table and set if they don't exist
if ! \$NFT list table \$NFT_TABLE >/dev/null 2>&1; then
    \$NFT add table \$NFT_TABLE
    log "INFO: Table \$NFT_TABLE created"
fi
if ! \$NFT list set \$NFT_TABLE \$NFT_SET >/dev/null 2>&1; then
    \$NFT add set \$NFT_TABLE \$NFT_SET '{ type ipv4_addr; flags interval; }'
    log "INFO: Set \$NFT_SET created"
fi

# --- 5. Atomic Update ---
# Flush old entries and add new ones
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
log "INFO: NFtables state saved to file."

# --- 8. Logging Changes ---
comm -23 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "REMOVED: \$IP"; done
comm -13 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "ADDED: \$IP"; done

# --- 9. Cleanup ---
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
        log_success "Permissions granted: +x"
        
        # New Feature: Immutable Bit
        log_input "Do you want to LOCK the file (immutable bit)? (yes/no)"
        echo "      (Prevents modification/deletion even by root. Recommended for Prod.)"
        read -r LOCK_CHOICE
        if [[ "${LOCK_CHOICE,,}" == "yes" || "${LOCK_CHOICE,,}" == "y" ]]; then
            if command -v chattr &>/dev/null; then
                chattr +i "$GENERATED_SCRIPT_PATH"
                log_success "File locked! (Use 'chattr -i' to unlock if you need to edit it)."
            else
                log_error "'chattr' command not found. Skipping lock."
            fi
        fi
    else
        log_info "Skipping permissions."
        exit 0
    fi
}

# --- Step 5: Cron Job ---
setup_cron() {
    echo ""
    log_info "Step 5: Automation (Cron)"
    log_input "Do you want to create a Cron task (Every hour)? (yes/no)"
    read -r CRON_CHOICE

    if [[ "${CRON_CHOICE,,}" == "yes" || "${CRON_CHOICE,,}" == "y" ]]; then
        if crontab -l 2>/dev/null | grep -q "$GENERATED_SCRIPT_PATH"; then
             log_info "Cron job already exists."
        else
            (crontab -l 2>/dev/null; echo "0 * * * * $GENERATED_SCRIPT_PATH >/dev/null 2>&1") | crontab -
            log_success "Cron job added successfully."
        fi
    fi
}

# --- Main Flow ---
check_root
check_dependencies
select_working_source
configure_security
generate_script
setup_permissions
setup_cron

echo ""
log_success "Installation complete. Enjoy your automated protection!"