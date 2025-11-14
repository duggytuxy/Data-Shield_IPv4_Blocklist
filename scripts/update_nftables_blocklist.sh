#!/bin/bash
set -euo pipefail

# Variables
BLOCKLIST_URL="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
BLOCKLIST_DIR="/etc/nftables_blocklist"
PREVIOUS_BLOCKLIST="$BLOCKLIST_DIR/previous_blocklist.txt"
CURRENT_BLOCKLIST="$BLOCKLIST_DIR/current_blocklist.txt"
TMP_BLOCKLIST="$BLOCKLIST_DIR/tmp_blocklist.txt"
IPSET="/sbin/ipset"
NFT="/usr/sbin/nft"
BLOCKLIST_SET_NAME="myblocklist"
NFT_TABLE="inet"
NFT_CHAIN="filter"
NFT_RULE_HANDLE_FILE="$BLOCKLIST_DIR/nft_rule_handle"
LOGFILE="/var/log/ipset_update.log"

# Utility functions
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $*" >> "$LOGFILE"
}

# Preparation
mkdir -p "$BLOCKLIST_DIR"
touch "$PREVIOUS_BLOCKLIST"
touch "$LOGFILE"

# Secure download
if ! curl -s --fail "$BLOCKLIST_URL" -o "$TMP_BLOCKLIST"; then
    log "ERROR : Failed to download the blocklist from $BLOCKLIST_URL"
    exit 1
fi

# IP validation and cleanup
grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' "$TMP_BLOCKLIST" | sort -u > "$CURRENT_BLOCKLIST"

# Creation of temporary set for atomicity
TMP_SET_NAME="${BLOCKLIST_SET_NAME}_tmp"
if $IPSET list -n | grep -q "$TMP_SET_NAME"; then
    $IPSET flush "$TMP_SET_NAME"
else
    $IPSET create "$TMP_SET_NAME" hash:ip
fi

# Adding IPs to the temporary set
while read -r IP; do
    $IPSET add "$TMP_SET_NAME" "$IP" 2>/dev/null || log "WARN : Unable to add $IP (possibly already present)"
done < "$CURRENT_BLOCKLIST"

# Swap for atomicity
if $IPSET list -n | grep -q "$BLOCKLIST_SET_NAME"; then
    $IPSET swap "$TMP_SET_NAME" "$BLOCKLIST_SET_NAME"
    $IPSET destroy "$TMP_SET_NAME"
else
    $IPSET rename "$TMP_SET_NAME" "$BLOCKLIST_SET_NAME"
fi

# Check if the nftables rule exists
if ! $NFT list chain $NFT_TABLE $NFT_CHAIN | grep -q "$BLOCKLIST_SET_NAME"; then
    $NFT add rule $NFT_TABLE $NFT_CHAIN ip saddr @${BLOCKLIST_SET_NAME} drop
    log "INFO : Added nftables rule to block IPs"
fi

# Logging changes
comm -23 <(sort -u "$PREVIOUS_BLOCKLIST") <(sort -u "$CURRENT_BLOCKLIST") | while read -r IP; do
    log "ADD : $IP"
done

comm -13 <(sort -u "$PREVIOUS_BLOCKLIST") <(sort -u "$CURRENT_BLOCKLIST") | while read -r IP; do
    log "REMOVE : $IP"
done

# Save for next run
cp "$CURRENT_BLOCKLIST" "$PREVIOUS_BLOCKLIST"
log "INFO : Update completed successfully"