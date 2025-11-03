#!/bin/bash

set -euo pipefail

BLOCKLIST_URL="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
PREVIOUS_BLOCKLIST="/etc/iptables_blocklist/previous_blocklist.txt"
CURRENT_BLOCKLIST="/etc/iptables_blocklist/current_blocklist.txt"
IPTABLES="/sbin/iptables"
IPSET="/sbin/ipset"
BLOCKLIST_SET_NAME="myblocklist"
# Download the current blocklist
curl -s $BLOCKLIST_URL -o $CURRENT_BLOCKLIST
# Create the ipset set if it does not exist
$IPSET list -n | grep -q $BLOCKLIST_SET_NAME || $IPSET create $BLOCKLIST_SET_NAME hash:ip
# Add new IPs to the blocklist
comm -23 <(sort $PREVIOUS_BLOCKLIST | sort | uniq) <(sort $CURRENT_BLOCKLIST | sort | uniq) | while read -r IP; do
  $IPSET add $BLOCKLIST_SET_NAME $IP
done
# Remove outdated IPs from the blocklist
comm -13 <(sort $PREVIOUS_BLOCKLIST | sort | uniq) <(sort $CURRENT_BLOCKLIST | sort | uniq) | while read -r IP; do
  $IPSET del $BLOCKLIST_SET_NAME $IP
done
# Ensure the IPtables rule is in place
$IPTABLES -C INPUT -m set --match-set $BLOCKLIST_SET_NAME src -j DROP 2>/dev/null || $IPTABLES -I INPUT -m set --match-set $BLOCKLIST_SET_NAME src -j DROP
# Save the current blocklist as the previous one for the next run
cp $CURRENT_BLOCKLIST $PREVIOUS_BLOCKLIST