#!/bin/bash
set -euo pipefail

# Variables
BLOCKLIST_URL="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
BLOCKLIST_DIR="/etc/nftables_blocklist"
PREVIOUS_BLOCKLIST="$BLOCKLIST_DIR/previous_blocklist.txt"
CURRENT_BLOCKLIST="$BLOCKLIST_DIR/current_blocklist.txt"
TMP_BLOCKLIST="$BLOCKLIST_DIR/tmp_blocklist.txt"
NFT="/usr/sbin/nft"
NFT_TABLE="inet filter"
NFT_CHAIN="input"
NFT_SET="blocklist_ipv4"
LOGFILE="/var/log/nft_blocklist_update.log"

# Logging function
log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') : $*" >> "$LOGFILE"
}

# Preparation
mkdir -p "$BLOCKLIST_DIR"
touch "$PREVIOUS_BLOCKLIST"
touch "$LOGFILE"

# Secure download
if ! curl -s --fail "$BLOCKLIST_URL" -o "$TMP_BLOCKLIST"; then
    log "ERROR: Failed to download blocklist from $BLOCKLIST_URL"
    exit 1
fi

# Validate IPs and clean up
grep -E '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' "$TMP_BLOCKLIST" | sort -u > "$CURRENT_BLOCKLIST"

# Create table and set if necessary
if ! $NFT list table inet filter >/dev/null 2>&1; then
    $NFT add table inet filter
    log "INFO: Table inet filter created"
fi

if ! $NFT list set inet filter $NFT_SET >/dev/null 2>&1; then
    $NFT add set inet filter $NFT_SET '{ type ipv4_addr; flags interval; }'
    log "INFO: Set $NFT_SET created"
fi

# Atomic update: flush + add IPs
$NFT flush set inet filter $NFT_SET
while read -r IP; do
    $NFT add element inet filter $NFT_SET { $IP } 2>/dev/null || log "WARN: Could not add $IP"
done < "$CURRENT_BLOCKLIST"

# Add rule if missing
if ! $NFT list chain inet filter input | grep -q "$NFT_SET"; then
    $NFT insert rule inet filter input ip saddr @${NFT_SET} drop
    log "INFO: Rule added to block IPs"
fi

# Log changes
comm -23 <(sort -u "$PREVIOUS_BLOCKLIST") <(sort -u "$CURRENT_BLOCKLIST") | while read -r IP; do
    log "ADDED: $IP"
done

comm -13 <(sort -u "$PREVIOUS_BLOCKLIST") <(sort -u "$CURRENT_BLOCKLIST") | while read -r IP; do
    log "REMOVED: $IP"
done

# Save for next run
cp "$CURRENT_BLOCKLIST" "$PREVIOUS_BLOCKLIST"
