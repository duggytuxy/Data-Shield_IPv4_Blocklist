#!/bin/bash

# --- SAFETY FIRST ---
set -euo pipefail
IFS=$'\n\t'

# --- COLORS & FORMATTING ---
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# --- CONFIGURATION CONSTANTS ---
LOG_FILE="/var/log/datashield-install.log"
SET_NAME="datashield_blacklist"
TMP_DIR=$(mktemp -d)

# --- LIST URLS (Extracted from provided files) ---
# Standard List (~85k IPs)
declare -A URLS_STANDARD
URLS_STANDARD[GitHub]="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
URLS_STANDARD[GitLab]="https://gitlab.com/duggytuxy/data-shield-ipv4-blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt"
URLS_STANDARD[Bitbucket]="https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_data-shield_ipv4_blocklist.txt"
URLS_STANDARD[Codeberg]="https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"

# Critical List (~100k IPs)
declare -A URLS_CRITICAL
URLS_CRITICAL[GitHub]="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_data-shield_ipv4_blocklist.txt"
URLS_CRITICAL[GitLab]="https://gitlab.com/duggytuxy/data-shield-ipv4-blocklist/-/raw/main/prod_critical_data-shield_ipv4_blocklist.txt"
URLS_CRITICAL[Bitbucket]="https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_critical_data-shield_ipv4_blocklist.txt"
URLS_CRITICAL[Codeberg]="https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_critical_data-shield_ipv4_blocklist.txt"

# ==============================================================================
# HELPER FUNCTIONS
# ==============================================================================

log() {
    local level="$1"
    local message="$2"
    local timestamp=$(date "+%Y-%m-%d %H:%M:%S")
    echo -e "${timestamp} [${level}] ${message}" | tee -a "$LOG_FILE"
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
       echo -e "${RED}ERROR: This script must be run as root.${NC}"
       exit 1
    fi
}

cleanup() {
    rm -rf "$TMP_DIR"
}
trap cleanup EXIT

detect_os_backend() {
    log "INFO" "Detecting Operating System and Firewall Backend..."
    
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        OS=$NAME
    else
        OS="Unknown"
    fi

    # Determine Firewall Backend (Nftables vs Ipset/Iptables)
    if command -v nft >/dev/null 2>&1 && systemctl is-active --quiet nftables; then
        FIREWALL_BACKEND="nftables"
    elif command -v firewall-cmd >/dev/null 2>&1; then
        FIREWALL_BACKEND="firewalld" # RHEL/Alma default
    else
        FIREWALL_BACKEND="ipset" # Fallback for older Debian/Ubuntu with ufw/iptables
    fi

    log "INFO" "OS: $OS"
    log "INFO" "Detected Firewall Backend: $FIREWALL_BACKEND"
}

install_dependencies() {
    log "INFO" "Checking dependencies..."
    local missing_pkgs=""

    # Common tools
    if ! command -v curl >/dev/null; then missing_pkgs="$missing_pkgs curl"; fi
    if ! command -v bc >/dev/null; then missing_pkgs="$missing_pkgs bc"; fi

    # Firewall tools: Check specifically for ipset if backend is not purely nftables-only
    if ! command -v ipset >/dev/null; then 
        missing_pkgs="$missing_pkgs ipset"
    fi

    # NEW: Fail2ban check (Requested by User)
    if ! command -v fail2ban-client >/dev/null; then 
        missing_pkgs="$missing_pkgs fail2ban"
    fi

    if [[ -n "$missing_pkgs" ]]; then
        log "WARN" "Installing missing packages: $missing_pkgs"
        
        if [[ -f /etc/debian_version ]]; then
            # FIX: Update of deposits REQUIRED
            log "INFO" "Updating apt repositories..."
            apt-get update -qq
            
            # Installation (ipset + fail2ban + others)
            apt-get install -y $missing_pkgs
            
        elif [[ -f /etc/redhat-release ]]; then
            dnf install -y $missing_pkgs
        fi
    else
        log "INFO" "All dependencies are installed."
    fi
}

# ==============================================================================
# CORE LOGIC
# ==============================================================================

select_list_type() {
    echo -e "\n${BLUE}=== Step 1: Select Blocklist Type ===${NC}"
    echo "1) Standard List (~85,000 IPs) - Recommended for Web Servers (Apache/Nginx, WP)"
    echo "2) Critical List (~100,000 IPs) - Recommended for High Security (DMZ, Exposed Assets)"
    echo "3) Custom List (Provide your own .txt URL)"
    read -p "Enter choice [1/2/3]: " choice

    case "$choice" in
        1) LIST_TYPE="Standard";;
        2) LIST_TYPE="Critical";;
        3) 
           LIST_TYPE="Custom"
           read -p "Enter the full URL (must start with http/https): " CUSTOM_URL
           # Basic URL validation
           if [[ ! "$CUSTOM_URL" =~ ^https?:// ]]; then
               log "ERROR" "Invalid URL format. It must start with http:// or https://"
               exit 1
           fi
           ;;
        *) log "ERROR" "Invalid choice. Exiting."; exit 1;;
    esac
    log "INFO" "User selected: $LIST_TYPE Blocklist"
}

measure_latency() {
    local url="$1"
    local domain=$(echo "$url" | awk -F/ '{print $3}')
    
    # Ping 2 times, timeout 1s, extract average time
    local ping_res
    ping_res=$(ping -c 2 -W 1 "$domain" | tail -1 | awk -F '/' '{print $5}' 2>/dev/null)
    
    if [[ -z "$ping_res" ]]; then
        echo "9999" # Penalty for unreachable
    else
        echo "$ping_res"
    fi
}

select_mirror() {
    # --- START ADDED: Custom URL ---
    if [[ "$LIST_TYPE" == "Custom" ]]; then
        SELECTED_URL="$CUSTOM_URL"
        log "INFO" "Custom URL detected. Skipping mirror benchmark."
        echo -e "\n${GREEN}Using Custom Source: $SELECTED_URL${NC}"
        return
    fi
    # --- END ADDED ---

    echo -e "\n${BLUE}=== Step 2: Selecting Fastest Mirror ===${NC}"
    log "INFO" "Benchmarking mirrors for latency..."

    declare -n URL_MAP
    if [[ "$LIST_TYPE" == "Standard" ]]; then
        URL_MAP=URLS_STANDARD
    else
        URL_MAP=URLS_CRITICAL
    fi

    local fastest_time=10000
    local fastest_name=""
    local fastest_url=""

    # Associative array to store results for display
    declare -A results

    for name in "${!URL_MAP[@]}"; do
        url="${URL_MAP[$name]}"
        echo -n "Pinging $name... "
        time=$(measure_latency "$url")
        results[$name]=$time
        echo "${time} ms"

        # Float comparison using bc
        if (( $(echo "$time < $fastest_time" | bc -l) )); then
            fastest_time=$time
            fastest_name=$name
            fastest_url=$url
        fi
    done

    echo -e "\n${GREEN}Fastest Mirror Detected: $fastest_name (${fastest_time} ms)${NC}"
    read -p "Use this mirror? [Y/n]: " confirm
    confirm=${confirm:-Y}

    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo "Please select a mirror manually:"
        select name in "${!URL_MAP[@]}"; do
            if [[ -n "$name" ]]; then
                SELECTED_URL="${URL_MAP[$name]}"
                log "INFO" "User manually selected: $name"
                break
            fi
        done
    else
        SELECTED_URL="$fastest_url"
        log "INFO" "Auto-selected fastest mirror: $fastest_name"
    fi
}

download_list() {
    echo -e "\n${BLUE}=== Step 3: Downloading Blocklist ===${NC}"
    log "INFO" "Fetching list from $SELECTED_URL..."
    
    local output_file="$TMP_DIR/blocklist.txt"
    
    # Download with curl, handle errors
    if curl -sS --retry 3 --connect-timeout 10 "$SELECTED_URL" -o "$output_file"; then
        # Verification: Count lines
        local count=$(wc -l < "$output_file")
        if [[ "$count" -lt 1000 ]]; then
            log "ERROR" "Downloaded file seems too small ($count lines). Something went wrong."
            exit 1
        fi
        log "INFO" "Download success. Lines: $count"
        
        # Clean list: remove comments, empty lines, and validate IP format roughly
        grep -E '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' "$output_file" > "$TMP_DIR/clean_list.txt"
        FINAL_LIST="$TMP_DIR/clean_list.txt"
    else
        log "ERROR" "Failed to download blocklist."
        exit 1
    fi
}

apply_firewall_rules() {
    echo -e "\n${BLUE}=== Step 4: Applying Firewall Rules (Backend: $FIREWALL_BACKEND) ===${NC}"
    
    if [[ "$FIREWALL_BACKEND" == "nftables" ]]; then
        # --- NFTABLES METHOD (Best for Debian 12/Ubuntu 24.04) ---
        log "INFO" "Configuring Nftables Set..."
        
        # Generate an atomic nft file
        cat <<EOF > "$TMP_DIR/datashield.nft"
table inet datashield_table {
    set $SET_NAME {
        type ipv4_addr
        flags interval
        auto-merge
        elements = {
$(awk '{print $1 ","}' "$FINAL_LIST")
        }
    }
    chain input {
        type filter hook input priority filter - 10; policy accept;
        ip saddr @$SET_NAME log prefix "[DataShield-BLOCK] " flags all drop
    }
}
EOF
        # Apply atomically
        nft -f "$TMP_DIR/datashield.nft"
        log "INFO" "Nftables rules applied successfully."

    elif [[ "$FIREWALL_BACKEND" == "firewalld" ]]; then
        # --- FIREWALLD METHOD (RHEL/Alma) ---
        log "INFO" "Configuring Firewalld IPSet..."
        
        # Create ipset if not exists
        firewall-cmd --permanent --new-ipset="$SET_NAME" --type=hash:ip --option=family=inet --option=hashsize=131072 --option=maxelem=200000 || true
        firewall-cmd --reload
        
        # Add entries from file (efficient method)
        firewall-cmd --ipset="$SET_NAME" --add-entries-from-file="$FINAL_LIST"
        
        # Add Drop Rule with Logging
        firewall-cmd --permanent --add-rich-rule="rule source ipset='$SET_NAME' log prefix='[DataShield-BLOCK] ' level='info' drop"
        firewall-cmd --reload
        log "INFO" "Firewalld rules applied successfully."

    else
        # --- IPSET + IPTABLES METHOD (Legacy/Universal) ---
        log "INFO" "Configuring IPSet and Iptables..."
        
        # Create temp set, load IPs, swap to live set (Atomic update)
        ipset create "${SET_NAME}_tmp" hash:ip hashsize 131072 maxelem 200000 -exist
        
        log "INFO" "Loading IPs into temporary set..."
        sed "s/^/add ${SET_NAME}_tmp /" "$FINAL_LIST" | ipset restore
        
        ipset create "$SET_NAME" hash:ip hashsize 131072 maxelem 200000 -exist
        ipset swap "${SET_NAME}_tmp" "$SET_NAME"
        ipset destroy "${SET_NAME}_tmp"
        
        # Check if rule exists in iptables INPUT
        if ! iptables -C INPUT -m set --match-set "$SET_NAME" src -j DROP 2>/dev/null; then
            # Insert at top of INPUT chain
            iptables -I INPUT 1 -m set --match-set "$SET_NAME" src -j DROP
            iptables -I INPUT 1 -m set --match-set "$SET_NAME" src -j LOG --log-prefix "[DataShield-BLOCK] "
            log "INFO" "Iptables DROP rule inserted."
            
            # Persist iptables (Basic check for persistence tools)
            if command -v netfilter-persistent >/dev/null; then
                netfilter-persistent save
            fi
        fi
    fi
}

detect_protected_services() {
    echo -e "\n${BLUE}=== Step 5: Service Integration Check ===${NC}"
    log "INFO" "Checking Fail2ban status to confirm coverage..."
    
    if command -v fail2ban-client >/dev/null && systemctl is-active --quiet fail2ban; then
        JAILS=$(fail2ban-client status | grep "Jail list" | sed 's/.*Jail list://g')
        log "INFO" "Fail2ban is ACTIVE. Jails found: ${JAILS}"
        log "INFO" "Security Note: The Data-Shield blocklist has been applied globally (INPUT Chain)."
        log "INFO" "It effectively protects ALL valid services on this host, including: ${JAILS}"
        log "INFO" "No specific Jail configuration needed - Traffic is dropped before reaching Fail2ban."
    else
        log "WARN" "Fail2ban not detecting or not running. Global Blocklist is still ACTIVE and protecting all ports."
    fi
}

setup_siem_logging() {
    # Logging is already configured in the firewall rules with prefix [DataShield-BLOCK]
    # This usually goes to /var/log/kern.log or /var/log/syslog
    echo -e "\n${BLUE}=== Step 6: SIEM Logging Status ===${NC}"
    log "INFO" "Firewall logging enabled with prefix '[DataShield-BLOCK]'."
    log "INFO" "Logs are being written to kernel facility (syslog/dmesg)."
    log "INFO" "For Wazuh/ELK: Monitor '/var/log/syslog' or '/var/log/kern.log' for this string."
}

# ==============================================================================
# MAIN EXECUTION
# ==============================================================================

clear
echo -e "${GREEN}#############################################################"
echo -e "#     Data-Shield IPv4 Blocklist Community Installer (Pro/Secu)    #"
echo -e "#############################################################${NC}"

check_root
detect_os_backend
install_dependencies
select_list_type
select_mirror
download_list
apply_firewall_rules
detect_protected_services
setup_siem_logging

echo -e "\n${GREEN}#############################################################"
echo -e "#                    INSTALLATION SUCCESSFUL                  #"
echo -e "#############################################################${NC}"
echo -e " -> List loaded: $LIST_TYPE"
echo -e " -> Backend: $FIREWALL_BACKEND"
echo -e " -> Mirror used: $SELECTED_URL"
echo -e " -> Logs: $LOG_FILE"
echo -e " -> SIEM Integration: Monitor logs for '[DataShield-BLOCK]'"
echo -e "\nThe system is now protected against known threats."