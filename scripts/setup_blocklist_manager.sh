#!/bin/bash
# ==============================================================================
# Script Name: setup_blocklist_manager.sh
# Version:     0.0.10 (beta - 1)
# Description: Interactive installer to generate an IPv4 Blocklist updater
#              for either IPtables (via IPSet) or NFtables.
#              Features automatic source failover and Cron setup.
# Author:      Duggy Tuxy (Laurent M.)
# ==============================================================================

set -euo pipefail

# --- Configuration ---
# List of sources ordered by priority (Failover mechanism)
SOURCES=(
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads"
    "https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_data-shield_ipv4_blocklist.txt"
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
)

GENERATED_SCRIPT_PATH="/usr/local/bin/update_blocklist.sh"
SELECTED_URL=""

# --- Helper Functions ---

# Function to print colored logs for better visibility
log_info() { echo -e "\e[34m[INFO]\e[0m $1"; }
log_success() { echo -e "\e[32m[SUCCESS]\e[0m $1"; }
log_error() { echo -e "\e[31m[ERROR]\e[0m $1"; }
log_input() { echo -e "\e[33m[INPUT]\e[0m $1"; }

# Check if user is root
check_root() {
    if [[ $EUID -ne 0 ]]; then
       log_error "This script must be run as root (sudo)." 
       exit 1
    fi
}

# --- Step 1: Source Connectivity Test ---
select_working_source() {
    echo ""
    log_info "Step 1: Testing blocklist source connectivity..."
    
    for url in "${SOURCES[@]}"; do
        log_info "Testing: $url"
        # Using curl -I (Head request) to check availability quickly
        if curl -s -I --fail "$url" > /dev/null; then
            SELECTED_URL="$url"
            log_success "Source is reachable. Selecting: $url"
            break
        else
            log_error "Source unreachable, trying next fallback..."
        fi
    done

    if [[ -z "$SELECTED_URL" ]]; then
        log_error "All sources failed. Please check your internet connection."
        exit 1
    fi
}

# --- Step 2: Generate the Script ---
generate_script() {
    echo ""
    log_info "Step 2: Select Firewall Engine"
    log_input "Do you want to create the script for IPtables or NFtables? (Type 'IPtables' or 'NFtables')"
    read -r ENGINE_CHOICE

    # Convert input to lowercase for comparison
    case "${ENGINE_CHOICE,,}" in
        iptables)
            log_info "Generating IPtables script..."
            create_iptables_file
            ;;
        nftables)
            log_info "Generating NFtables script..."
            create_nftables_file
            ;;
        *)
            log_error "Invalid choice. Please type 'IPtables' or 'NFtables'. Exiting."
            exit 1
            ;;
    esac

    log_success "Script generated at: $GENERATED_SCRIPT_PATH"
}

create_iptables_file() {
cat <<EOF > "$GENERATED_SCRIPT_PATH"
#!/bin/bash
set -euo pipefail

# --- Generated Blocklist Updater for IPtables (IPSet) ---
# Source: $SELECTED_URL

# Variables
BLOCKLIST_URL="$SELECTED_URL"
BLOCKLIST_DIR="/etc/iptables_blocklist"
PREVIOUS_BLOCKLIST="\$BLOCKLIST_DIR/previous_blocklist.txt"
CURRENT_BLOCKLIST="\$BLOCKLIST_DIR/current_blocklist.txt"
TMP_BLOCKLIST="\$BLOCKLIST_DIR/tmp_blocklist.txt"
IPTABLES="/sbin/iptables"
IPSET="/sbin/ipset"
BLOCKLIST_SET_NAME="myblocklist"
LOGFILE="/var/log/ipset_update.log"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') : \$*" >> "\$LOGFILE"; }

# Preparation
mkdir -p "\$BLOCKLIST_DIR"
touch "\$PREVIOUS_BLOCKLIST" "\$LOGFILE"

# Secure download
if ! curl -s --fail "\$BLOCKLIST_URL" -o "\$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist."
    exit 1
fi

# Validate IPs
grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' "\$TMP_BLOCKLIST" | sort -u > "\$CURRENT_BLOCKLIST"

# Create temp set
TMP_SET_NAME="\${BLOCKLIST_SET_NAME}_tmp"
if \$IPSET list -n | grep -q "\$TMP_SET_NAME"; then
    \$IPSET flush "\$TMP_SET_NAME"
else
    \$IPSET create "\$TMP_SET_NAME" hash:ip
fi

# Add IPs to temp set
while read -r IP; do
    \$IPSET add "\$TMP_SET_NAME" "\$IP" 2>/dev/null || true
done < "\$CURRENT_BLOCKLIST"

# Swap sets
if \$IPSET list -n | grep -q "\$BLOCKLIST_SET_NAME"; then
    \$IPSET swap "\$TMP_SET_NAME" "\$BLOCKLIST_SET_NAME"
    \$IPSET destroy "\$TMP_SET_NAME"
else
    \$IPSET rename "\$TMP_SET_NAME" "\$BLOCKLIST_SET_NAME"
fi

# Add IPtables rule if missing
if ! \$IPTABLES -C INPUT -m set --match-set "\$BLOCKLIST_SET_NAME" src -j DROP 2>/dev/null; then
    \$IPTABLES -I INPUT -m set --match-set "\$BLOCKLIST_SET_NAME" src -j DROP
    log "INFO: Added IPtables rule."
fi

# Logging differences
comm -23 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "ADDED: \$IP"; done
comm -13 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "REMOVED: \$IP"; done

cp "\$CURRENT_BLOCKLIST" "\$PREVIOUS_BLOCKLIST"
log "INFO: Update completed successfully."
EOF
}

create_nftables_file() {
cat <<EOF > "$GENERATED_SCRIPT_PATH"
#!/bin/bash
set -euo pipefail

# --- Generated Blocklist Updater for NFtables ---
# Source: $SELECTED_URL

# Variables
BLOCKLIST_URL="$SELECTED_URL"
BLOCKLIST_DIR="/etc/nftables_blocklist"
PREVIOUS_BLOCKLIST="\$BLOCKLIST_DIR/previous_blocklist.txt"
CURRENT_BLOCKLIST="\$BLOCKLIST_DIR/current_blocklist.txt"
TMP_BLOCKLIST="\$BLOCKLIST_DIR/tmp_blocklist.txt"
NFT="/usr/sbin/nft"
NFT_TABLE="inet filter"
NFT_CHAIN="input"
NFT_SET="blocklist_ipv4"
LOGFILE="/var/log/nft_blocklist_update.log"

log() { echo "\$(date '+%Y-%m-%d %H:%M:%S') : \$*" >> "\$LOGFILE"; }

# Preparation
mkdir -p "\$BLOCKLIST_DIR"
touch "\$PREVIOUS_BLOCKLIST" "\$LOGFILE"

# Secure download
if ! curl -s --fail "\$BLOCKLIST_URL" -o "\$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist."
    exit 1
fi

# Validate IPs
grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' "\$TMP_BLOCKLIST" | sort -u > "\$CURRENT_BLOCKLIST"

# Create table/set if missing
if ! \$NFT list table \$NFT_TABLE >/dev/null 2>&1; then
    \$NFT add table \$NFT_TABLE
    log "INFO: Table \$NFT_TABLE created"
fi
if ! \$NFT list set \$NFT_TABLE \$NFT_SET >/dev/null 2>&1; then
    \$NFT add set \$NFT_TABLE \$NFT_SET '{ type ipv4_addr; flags interval; }'
    log "INFO: Set \$NFT_SET created"
fi

# Atomic update
\$NFT flush set \$NFT_TABLE \$NFT_SET
while read -r IP; do
    \$NFT add element \$NFT_TABLE \$NFT_SET { \$IP } 2>/dev/null || log "WARN: Could not add \$IP"
done < "\$CURRENT_BLOCKLIST"

# Add rule if missing
if ! \$NFT list chain \$NFT_TABLE input | grep -q "\$NFT_SET"; then
    \$NFT insert rule \$NFT_TABLE input ip saddr @\${NFT_SET} drop
    log "INFO: Rule added to block IPs"
fi

# Logging differences
comm -23 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "ADDED: \$IP"; done
comm -13 <(sort -u "\$PREVIOUS_BLOCKLIST") <(sort -u "\$CURRENT_BLOCKLIST") | while read -r IP; do log "REMOVED: \$IP"; done

cp "\$CURRENT_BLOCKLIST" "\$PREVIOUS_BLOCKLIST"
EOF
}

# --- Step 3: Permissions ---
setup_permissions() {
    echo ""
    log_info "Step 3: Execution Permissions"
    log_input "Do you want to make the generated script executable? (yes/no)"
    read -r PERM_CHOICE

    if [[ "${PERM_CHOICE,,}" == "yes" || "${PERM_CHOICE,,}" == "y" ]]; then
        chmod +x "$GENERATED_SCRIPT_PATH"
        log_success "Permissions granted: chmod +x $GENERATED_SCRIPT_PATH"
    else
        log_info "Skipping permissions. You will need to chmod it manually."
        log_info "Exiting setup."
        exit 0
    fi
}

# --- Step 4: Cron Job ---
setup_cron() {
    echo ""
    log_info "Step 4: Automation (Cron)"
    log_input "Do you want to create a Cron task to update the blocklist automatically? (yes/no)"
    read -r CRON_CHOICE

    if [[ "${CRON_CHOICE,,}" == "yes" || "${CRON_CHOICE,,}" == "y" ]]; then
        log_info "Setting up hourly cron job (recommended)..."
        
        # Check if job already exists to avoid duplicates
        if crontab -l 2>/dev/null | grep -q "$GENERATED_SCRIPT_PATH"; then
             log_info "Cron job already exists for this script."
        else
            # Append the job to the current crontab (runs at minute 0 of every hour)
            (crontab -l 2>/dev/null; echo "0 * * * * $GENERATED_SCRIPT_PATH >/dev/null 2>&1") | crontab -
            log_success "Cron job added successfully (Every hour)."
        fi
    else
        log_info "No Cron job added. You will need to run the script manually."
        exit 0
    fi
}

# --- Main Execution Flow ---
check_root
select_working_source
generate_script
setup_permissions
setup_cron

echo ""
log_success "Installation and setup complete!"
echo "You can verify the installation by running: $GENERATED_SCRIPT_PATH"