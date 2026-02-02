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
CONF_FILE="/etc/datashield.conf"
SET_NAME="datashield_blacklist"
TMP_DIR=$(mktemp -d)

# --- LIST URLS ---
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
        OS_ID=$ID
    else
        OS="Unknown"
        OS_ID="unknown"
    fi

    # EXPERT FIX: Force Nftables on modern Debian/Ubuntu unless explicitly using firewalld
    if [[ "$OS_ID" == "ubuntu" ]] || [[ "$OS_ID" == "debian" ]]; then
        FIREWALL_BACKEND="nftables"
    elif command -v firewall-cmd >/dev/null 2>&1; then
        FIREWALL_BACKEND="firewalld" # RHEL/Alma default
    elif command -v nft >/dev/null 2>&1; then
        FIREWALL_BACKEND="nftables"
    else
        FIREWALL_BACKEND="ipset" # Fallback
    fi

    log "INFO" "OS: $OS"
    log "INFO" "Detected Firewall Backend: $FIREWALL_BACKEND"
}

install_dependencies() {
    log "INFO" "Checking dependencies..."
    local missing_common=""

    # 1. Mise à jour impérative des dépôts
    if [[ -f /etc/debian_version ]]; then
        log "INFO" "Updating apt repositories..."
        apt-get update -qq
    fi

    # 2. Outils de base (curl only, 'bc' removed)
    if ! command -v curl >/dev/null; then missing_common="$missing_common curl"; fi
    
    if [[ -n "$missing_common" ]]; then
        if [[ -f /etc/debian_version ]]; then apt-get install -y $missing_common; 
        elif [[ -f /etc/redhat-release ]]; then dnf install -y $missing_common; fi
    fi

    # 3. Installation séparée de IPSET
    if ! command -v ipset >/dev/null; then
        log "WARN" "Installing package: ipset"
        if [[ -f /etc/debian_version ]]; then
            apt-get install -y ipset
        elif [[ -f /etc/redhat-release ]]; then
            dnf install -y ipset
        fi
    fi

    # 4. Installation séparée de FAIL2BAN
    if ! command -v fail2ban-client >/dev/null; then
        log "WARN" "Installing package: fail2ban"
        if [[ -f /etc/debian_version ]]; then
            apt-get install -y fail2ban
        elif [[ -f /etc/redhat-release ]]; then
            # FIX: AlmaLinux/RHEL need EPEL repo for fail2ban
            log "INFO" "Enabling EPEL repository (Required for Fail2ban)..."
            # On tente d'installer epel-release, s'il est déjà là, dnf le dira et continuera
            dnf install -y epel-release || true
            dnf install -y fail2ban
        fi
    fi

    # 5. Installation de NFTABLES
    if [[ "$FIREWALL_BACKEND" == "nftables" ]] && ! command -v nft >/dev/null; then
        log "WARN" "Installing package: nftables"
        if [[ -f /etc/debian_version ]]; then apt-get install -y nftables;
        elif [[ -f /etc/redhat-release ]]; then dnf install -y nftables; fi
    fi

    log "INFO" "All dependencies check complete."
}

# ==============================================================================
# CORE LOGIC
# ==============================================================================

select_list_type() {
    if [[ "${1:-}" == "update" ]] && [[ -f "$CONF_FILE" ]]; then
        source "$CONF_FILE"
        log "INFO" "Update Mode: Loaded configuration (Type: $LIST_TYPE)"
        return
    fi

    echo -e "\n${BLUE}=== Step 1: Select Blocklist Type ===${NC}"
    echo "1) Standard List (~85,000 IPs) - Recommended for Web Servers"
    echo "2) Critical List (~100,000 IPs) - Recommended for High Security"
    echo "3) Custom List (Provide your own .txt URL)"
    read -p "Enter choice [1/2/3]: " choice

    case "$choice" in
        1) LIST_TYPE="Standard";;
        2) LIST_TYPE="Critical";;
        3) 
           LIST_TYPE="Custom"
           read -p "Enter the full URL (must start with http/https): " CUSTOM_URL
           if [[ ! "$CUSTOM_URL" =~ ^https?:// ]]; then
               log "ERROR" "Invalid URL format."
               exit 1
           fi
           ;;
        *) log "ERROR" "Invalid choice. Exiting."; exit 1;;
    esac
    
    echo "LIST_TYPE='$LIST_TYPE'" > "$CONF_FILE"
    if [[ -n "${CUSTOM_URL:-}" ]]; then
        echo "CUSTOM_URL='$CUSTOM_URL'" >> "$CONF_FILE"
    fi
    log "INFO" "User selected: $LIST_TYPE Blocklist"
}

measure_latency() {
    local url="$1"
    
    # EXPERT FIX: Use curl (TCP/HTTP) instead of ping (ICMP)
    # GitHub/GitLab often block ICMP pings. We measure 'time_connect' (TCP Handshake) instead.
    # This is the "True" latency for downloading the file.
    
    local time_sec
    # -w %{time_connect} gives latency in seconds (e.g., 0.045)
    time_sec=$(curl -o /dev/null -s -w '%{time_connect}\n' --connect-timeout 2 "$url" || echo "error")
    
    if [[ "$time_sec" == "error" ]] || [[ -z "$time_sec" ]]; then
        echo "9999"
    else
        # Convert seconds to milliseconds (0.045 -> 45) using awk (No 'bc' needed)
        echo "$time_sec" | awk '{print int($1 * 1000)}' 2>/dev/null || echo "9999"
    fi
}

select_mirror() {
    if [[ "${1:-}" == "update" ]] && [[ -f "$CONF_FILE" ]]; then
        source "$CONF_FILE"
        log "INFO" "Update Mode: keeping mirror $SELECTED_URL"
        return
    fi

    if [[ "$LIST_TYPE" == "Custom" ]]; then
        SELECTED_URL="$CUSTOM_URL"
        echo "SELECTED_URL='$SELECTED_URL'" >> "$CONF_FILE"
        log "INFO" "Custom URL set: $SELECTED_URL"
        return
    fi

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
    local valid_mirror_found=false

    for name in "${!URL_MAP[@]}"; do
        url="${URL_MAP[$name]}"
        echo -n "Pinging $name... "
        time=$(measure_latency "$url")
        
        if [[ "$time" -eq 9999 ]]; then
             echo "FAIL (Timeout)"
        else
             echo "${time} ms"
             # FIX: Logic improvement
             if (( time < fastest_time )); then
                fastest_time=$time
                fastest_name=$name
                fastest_url=$url
                valid_mirror_found=true
             fi
        fi
    done

    # Fallback if all pings failed (ICMP blocked?)
    if [[ "$valid_mirror_found" == "false" ]]; then
        log "WARN" "All mirrors unreachable via ping (ICMP blocked?). Defaulting to Codeberg."
        SELECTED_URL="${URL_MAP[Codeberg]}"
        fastest_name="Codeberg (Fallback)"
    else
        SELECTED_URL="$fastest_url"
    fi

    echo "SELECTED_URL='$SELECTED_URL'" >> "$CONF_FILE"
    log "INFO" "Auto-selected fastest mirror: $fastest_name"
}

download_list() {
    echo -e "\n${BLUE}=== Step 3: Downloading Blocklist ===${NC}"
    log "INFO" "Fetching list from $SELECTED_URL..."
    
    local output_file="$TMP_DIR/blocklist.txt"
    # Added -L to follow redirects (GitHub raw often redirects)
    if curl -sS -L --retry 3 --connect-timeout 10 "$SELECTED_URL" -o "$output_file"; then
        local count=$(wc -l < "$output_file")
        if [[ "$count" -lt 10 ]]; then 
            log "ERROR" "Downloaded file seems too small ($count lines). Check URL or Network."
            # Display file content for debugging if small
            cat "$output_file"
            exit 1
        fi
        log "INFO" "Download success. Lines: $count"
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
        log "INFO" "Configuring Nftables Set..."
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
        nft -f "$TMP_DIR/datashield.nft"
        log "INFO" "Nftables rules applied successfully."

    elif [[ "$FIREWALL_BACKEND" == "firewalld" ]]; then
        # FIX: Ensure Firewalld is actually running
        if ! systemctl is-active --quiet firewalld; then
            log "WARN" "Firewalld service is stopped. Starting it now..."
            systemctl enable --now firewalld
        fi

        log "INFO" "Configuring Firewalld IPSet..."
        
        # FIX ALMALINUX EXPERT:
        # 1. On retire '--option=hashsize=...' qui cause "Invalid argument" sur RHEL/Alma
        # 2. On garde '--option=family=inet' et 'maxelem'
        # 3. On supprime l'ancien set potentiellement corrompu avant de recréer
        firewall-cmd --permanent --delete-ipset="$SET_NAME" 2>/dev/null || true
        firewall-cmd --reload

        firewall-cmd --permanent --new-ipset="$SET_NAME" --type=hash:ip --option=family=inet --option=maxelem=200000
        firewall-cmd --reload
        
        firewall-cmd --ipset="$SET_NAME" --add-entries-from-file="$FINAL_LIST"
        firewall-cmd --permanent --add-rich-rule="rule source ipset='$SET_NAME' log prefix='[DataShield-BLOCK] ' level='info' drop"
        firewall-cmd --reload
        log "INFO" "Firewalld rules applied successfully."

    else
        log "INFO" "Configuring IPSet and Iptables..."
        
        # FIX EXPERT ALMALINUX: 
        # 1. On force 'family inet' (Obligatoire sur RHEL 9/10 sinon "Invalid Argument")
        # 2. On fixe hashsize à 65536 (Valeur sûre) pour éviter les erreurs d'allocation noyau
        local ipset_opts="hash:ip family inet hashsize 65536 maxelem 200000 -exist"
        
        # Optimisation spécifique Debian/Ubuntu (plus permissif)
        if [[ -f /etc/debian_version ]]; then
            ipset_opts="hash:ip hashsize 131072 maxelem 200000 -exist"
        fi
        
        # Nettoyage préventif en cas d'état corrompu ("Invalid Argument")
        ipset destroy "${SET_NAME}_tmp" 2>/dev/null || true
        
        # Création du Set temporaire
        ipset create "${SET_NAME}_tmp" $ipset_opts
        
        log "INFO" "Loading IPs into temporary set..."
        sed "s/^/add ${SET_NAME}_tmp /" "$FINAL_LIST" | ipset restore
        
        # Création du Set réel et Swap
        ipset create "$SET_NAME" $ipset_opts
        ipset swap "${SET_NAME}_tmp" "$SET_NAME"
        ipset destroy "${SET_NAME}_tmp"
        
        # Application de la règle Iptables
        if ! iptables -C INPUT -m set --match-set "$SET_NAME" src -j DROP 2>/dev/null; then
            iptables -I INPUT 1 -m set --match-set "$SET_NAME" src -j DROP
            iptables -I INPUT 1 -m set --match-set "$SET_NAME" src -j LOG --log-prefix "[DataShield-BLOCK] "
            log "INFO" "Iptables DROP rule inserted."
            if command -v netfilter-persistent >/dev/null; then netfilter-persistent save; fi
        fi
    fi
}

detect_protected_services() {
    echo -e "\n${BLUE}=== Step 5: Service Integration Check ===${NC}"
    
    # FIX: Force start Fail2ban if installed but not running (Required for RHEL/Alma)
    if command -v fail2ban-client >/dev/null && ! systemctl is-active --quiet fail2ban; then
        log "WARN" "Fail2ban is installed but stopped. Starting service..."
        systemctl enable --now fail2ban || true
        sleep 2 # Wait for startup
    fi

    if command -v fail2ban-client >/dev/null && systemctl is-active --quiet fail2ban; then
        JAILS=$(fail2ban-client status | grep "Jail list" | sed 's/.*Jail list://g')
        log "INFO" "Fail2ban is ACTIVE. Jails found: ${JAILS}"
        log "INFO" "Global Blocklist is ACTIVE and protects all services."
    else
        log "WARN" "Fail2ban not active. Global Blocklist is still ACTIVE."
    fi
}

setup_siem_logging() {
    echo -e "\n${BLUE}=== Step 6: SIEM Logging Status ===${NC}"
    log "INFO" "Monitor '/var/log/syslog' or '/var/log/kern.log' for '[DataShield-BLOCK]'."
}

setup_cron_autoupdate() {
    if [[ "${1:-}" != "update" ]]; then
        local script_path=$(realpath "$0")
        local cron_file="/etc/cron.d/datashield-update"
        echo "0 * * * * root $script_path update >> $LOG_FILE 2>&1" > "$cron_file"
        chmod 644 "$cron_file"
        log "INFO" "Automatic updates enabled: Runs every hour via $cron_file"
    fi
}

uninstall_datashield() {
    echo -e "\n${RED}=== Uninstalling Data-Shield ===${NC}"
    log "WARN" "Starting Uninstallation..."

    # 1. Remove Cron Job
    if [[ -f "/etc/cron.d/datashield-update" ]]; then
        rm -f "/etc/cron.d/datashield-update"
        log "INFO" "Cron job removed."
    fi

    # 2. Clean Firewall (Universal Cleanup)
    log "INFO" "Cleaning firewall rules..."
    
    # Nftables cleanup
    if command -v nft >/dev/null; then
        nft delete table inet datashield_table 2>/dev/null || true
    fi

    # Firewalld cleanup
    if command -v firewall-cmd >/dev/null && systemctl is-active --quiet firewalld; then
        firewall-cmd --permanent --remove-rich-rule="rule source ipset='$SET_NAME' log prefix='[DataShield-BLOCK] ' level='info' drop" 2>/dev/null || true
        firewall-cmd --permanent --delete-ipset="$SET_NAME" 2>/dev/null || true
        firewall-cmd --reload 2>/dev/null || true
    fi

    # Iptables/IPSet cleanup
    if command -v iptables >/dev/null; then
        iptables -D INPUT -m set --match-set "$SET_NAME" src -j DROP 2>/dev/null || true
        iptables -D INPUT -m set --match-set "$SET_NAME" src -j LOG --log-prefix "[DataShield-BLOCK] " 2>/dev/null || true
        # Save change if persistent
        if command -v netfilter-persistent >/dev/null; then netfilter-persistent save 2>/dev/null || true; fi
    fi
    
    if command -v ipset >/dev/null; then
        ipset destroy "$SET_NAME" 2>/dev/null || true
    fi

    # 3. Remove Config & Logs
    rm -f "$CONF_FILE"
    log "INFO" "Configuration file removed."
    
    # Optional: remove log file or keep for history? (Here we remove for full clean)
    rm -f "$LOG_FILE"
    
    echo -e "${GREEN}Uninstallation complete. Data-Shield has been removed.${NC}"
    exit 0
}
# ==============================================================================
# MAIN EXECUTION
# ==============================================================================

MODE="${1:-install}"

# Gestion du mode Désinstallation
if [[ "$MODE" == "uninstall" ]]; then
    check_root
    uninstall_datashield
fi

if [[ "$MODE" != "update" ]]; then
    clear
    echo -e "${GREEN}#############################################################"
    echo -e "#     Data-Shield Community Blocklist Installer (Pro/Secu)    #"
    echo -e "#############################################################${NC}"
fi

check_root
detect_os_backend
install_dependencies
select_list_type "$MODE"
select_mirror "$MODE"
download_list
apply_firewall_rules
detect_protected_services
setup_siem_logging
setup_cron_autoupdate "$MODE"

if [[ "$MODE" != "update" ]]; then
    echo -e "\n${GREEN}#############################################################"
    echo -e "#                    INSTALLATION SUCCESSFUL                  #"
    echo -e "#############################################################${NC}"
    echo -e " -> List loaded: $LIST_TYPE"
    echo -e " -> Backend: $FIREWALL_BACKEND"
    echo -e " -> Auto-Update: Every Hour"
    echo -e " -> Protection Status: ACTIVE (Permanent Drop)"
fi