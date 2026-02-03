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
declare -A URLS_STANDARD
URLS_STANDARD[GitHub]="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
URLS_STANDARD[GitLab]="https://gitlab.com/duggytuxy/data-shield-ipv4-blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt"
URLS_STANDARD[Bitbucket]="https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_data-shield_ipv4_blocklist.txt"
URLS_STANDARD[Codeberg]="https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt"

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

    # 1. Mandatory repository update
    if [[ -f /etc/debian_version ]]; then
        log "INFO" "Updating apt repositories..."
        apt-get update -qq
    fi

    # 2. Basic tools (curl only, 'bc' removed)
    if ! command -v curl >/dev/null; then missing_common="$missing_common curl"; fi
    
    if [[ -n "$missing_common" ]]; then
        if [[ -f /etc/debian_version ]]; then apt-get install -y $missing_common; 
        elif [[ -f /etc/redhat-release ]]; then dnf install -y $missing_common; fi
    fi

    # 3. Separate installation of IPSET
    if ! command -v ipset >/dev/null; then
        log "WARN" "Installing package: ipset"
        if [[ -f /etc/debian_version ]]; then
            apt-get install -y ipset
        elif [[ -f /etc/redhat-release ]]; then
            dnf install -y ipset
        fi
    fi

    # 4. Separate installation of FAIL2BAN
    if ! command -v fail2ban-client >/dev/null; then
        log "WARN" "Installing package: fail2ban"
        if [[ -f /etc/debian_version ]]; then
            apt-get install -y fail2ban
        elif [[ -f /etc/redhat-release ]]; then
            # FIX: AlmaLinux/RHEL need EPEL repo for fail2ban
            log "INFO" "Enabling EPEL repository (Required for Fail2ban)..."
            dnf install -y epel-release || true
            dnf install -y fail2ban
        fi
    fi

    # 5. NFTABLES Installation
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
    # This solves timeouts on GitHub/GitLab and avoids 'bc' dependency
    local time_sec
    time_sec=$(curl -o /dev/null -s -w '%{time_connect}\n' --connect-timeout 2 "$url" || echo "error")
    
    if [[ "$time_sec" == "error" ]] || [[ -z "$time_sec" ]]; then
        echo "9999"
    else
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
    log "INFO" "Benchmarking mirrors for latency (TCP Connect)..."

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
        echo -n "Connecting to $name... "
        time=$(measure_latency "$url")
        
        if [[ "$time" -eq 9999 ]]; then
             echo "FAIL (Timeout)"
        else
             echo "${time} ms"
             if (( time < fastest_time )); then
                fastest_time=$time
                fastest_name=$name
                fastest_url=$url
                valid_mirror_found=true
             fi
        fi
    done

    if [[ "$valid_mirror_found" == "false" ]]; then
        log "WARN" "All mirrors unreachable. Defaulting to Codeberg."
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
    if curl -sS -L --retry 3 --connect-timeout 10 "$SELECTED_URL" -o "$output_file"; then
        local count=$(wc -l < "$output_file")
        if [[ "$count" -lt 10 ]]; then 
            log "ERROR" "Downloaded file seems too small ($count lines). Check URL or Network."
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
        
        # 1. Clean old config to avoid conflicts
        firewall-cmd --permanent --delete-ipset="$SET_NAME" 2>/dev/null || true
        firewall-cmd --reload

        # 2. Create Permanent IPSet (No hashsize for Alma/RHEL compatibility)
        firewall-cmd --permanent --new-ipset="$SET_NAME" --type=hash:ip --option=family=inet --option=maxelem=200000
        firewall-cmd --reload
        
        # 3. Import IPs to PERMANENT config (Crucial step fixed)
        log "INFO" "Importing IPs into Firewalld (This may take a moment)..."
        firewall-cmd --permanent --ipset="$SET_NAME" --add-entries-from-file="$FINAL_LIST"
        
        # 4. Add the Drop Rule
        firewall-cmd --permanent --add-rich-rule="rule source ipset='$SET_NAME' log prefix='[DataShield-BLOCK] ' level='info' drop"
        
        # 5. Final Reload to apply everything
        firewall-cmd --reload
        log "INFO" "Firewalld rules applied successfully."

    else
        log "INFO" "Configuring IPSet and Iptables..."
        
        # Pre-cleanup
        ipset destroy "${SET_NAME}_tmp" 2>/dev/null || true
        
        # FIX ROCKY/RHEL IFS ISSUE:
        # We execute commands directly without using a variable to prevent
        # the script (with strict IFS) from treating the whole string as a single argument.
        
        if [[ -f /etc/debian_version ]]; then
            # DEBIAN/UBUNTU (Optimization)
            ipset create "${SET_NAME}_tmp" hash:ip hashsize 131072 maxelem 200000 -exist
        else
            # RHEL/ROCKY/ALMA (Strict syntax 'family inet' and standard hashsize)
            ipset create "${SET_NAME}_tmp" hash:ip family inet hashsize 65536 maxelem 200000 -exist
        fi
        
        log "INFO" "Loading IPs into temporary set..."
        sed "s/^/add ${SET_NAME}_tmp /" "$FINAL_LIST" | ipset restore
        
        # Create Real Set and Swap (Same separated logic)
        if [[ -f /etc/debian_version ]]; then
            ipset create "$SET_NAME" hash:ip hashsize 131072 maxelem 200000 -exist
        else
            ipset create "$SET_NAME" hash:ip family inet hashsize 65536 maxelem 200000 -exist
        fi
        
        ipset swap "${SET_NAME}_tmp" "$SET_NAME"
        ipset destroy "${SET_NAME}_tmp"
        
        if ! iptables -C INPUT -m set --match-set "$SET_NAME" src -j DROP 2>/dev/null; then
            iptables -I INPUT 1 -m set --match-set "$SET_NAME" src -j DROP
            iptables -I INPUT 1 -m set --match-set "$SET_NAME" src -j LOG --log-prefix "[DataShield-BLOCK] "
            log "INFO" "Iptables DROP rule inserted."
            if command -v netfilter-persistent >/dev/null; then netfilter-persistent save; fi
        fi
    fi
}

configure_fail2ban() {
    # On configure seulement si Fail2ban est installé
    if command -v fail2ban-client >/dev/null; then
        log "INFO" "Generating Fail2ban configuration (jail.local)..."

        # Backup de sécurité si une config existe déjà
        if [[ -f /etc/fail2ban/jail.local ]]; then
            cp /etc/fail2ban/jail.local /etc/fail2ban/jail.local.bak
            log "INFO" "Backup of existing config saved to jail.local.bak"
        fi

        # Écriture de la configuration
        cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
# Durée du bannissement (1 heure)
bantime = 1h
# Fenêtre de temps pour compter les échecs (10 minutes)
findtime = 10m
# Nombre d'échecs avant ban
maxretry = 5
# Ne jamais se bannir soi-même (Localhost)
ignoreip = 127.0.0.1/8 ::1
# Backend automatique
backend = systemd

# --- SSH Protection ---
[sshd]
enabled = true
# "mode = aggressive" détecte plus de types d'attaques SSH (DDOS, etc.)
mode = aggressive
port = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s

# --- Web Server Protection (Nginx) ---
[nginx-http-auth]
enabled = true
port = http,https
logpath = /var/log/nginx/error.log

[nginx-botsearch]
enabled = true
port = http,https
logpath = /var/log/nginx/access.log

# --- Web Server Protection (Apache) ---
[apache-auth]
enabled = true
port = http,https
logpath = %(apache_error_log)s

[apache-badbots]
enabled = true
port = http,https
logpath = %(apache_access_log)s

# --- Database Protection (MongoDB) ---
[mongodb-auth]
enabled = true
port = 27017
logpath = /var/log/mongodb/mongod.log
EOF

        log "INFO" "Fail2ban configured with protections: SSH, Nginx, Apache, MongoDB."
        
        # Redémarrage pour appliquer
        systemctl restart fail2ban
        sleep 2
    fi
}

setup_abuse_reporting() {
    echo -e "\n${BLUE}=== Step 7: AbuseIPDB Reporting Setup ===${NC}"
    echo "Would you like to automatically report blocked IPs to AbuseIPDB?"
    echo "This helps the community and requires a free API Key."
    read -p "Enable AbuseIPDB reporting? (y/N): " response

    if [[ "$response" =~ ^[Yy]$ ]]; then
        read -p "Enter your AbuseIPDB API Key: " USER_API_KEY
        
        if [[ -z "$USER_API_KEY" ]]; then
            log "ERROR" "No API Key provided. Skipping reporting setup."
            return
        fi

        log "INFO" "Installing Python dependencies..."
        if [[ -f /etc/debian_version ]]; then
            apt-get install -y python3-requests
        elif [[ -f /etc/redhat-release ]]; then
            dnf install -y python3-requests
        fi

        log "INFO" "Creating reporter script..."
        # Utilisation de 'EOF' entre quotes pour éviter que Bash n'interprète les variables Python
        cat <<'EOF' > /usr/local/bin/abuse_reporter.py
#!/usr/bin/env python3
import subprocess
import select
import re
import requests
import time
import sys

# --- CONFIGURATION ---
API_KEY = "PLACEHOLDER_KEY"
REPORT_INTERVAL = 900  # 15 minutes
MY_SERVER_NAME = "DataShield-Srv"

# --- DEFINITIONS ---
reported_cache = {}

def send_report(ip, categories, comment):
    """Envoie le signalement à AbuseIPDB"""
    current_time = time.time()
    
    if ip in reported_cache:
        if current_time - reported_cache[ip] < REPORT_INTERVAL:
            return 

    url = 'https://api.abuseipdb.com/api/v2/report'
    headers = {'Key': API_KEY, 'Accept': 'application/json'}
    params = {
        'ip': ip,
        'categories': categories,
        'comment': f"{comment} - Source: {ip}"
    }

    try:
        response = requests.post(url, params=params, headers=headers)
        if response.status_code == 200:
            print(f"[SUCCESS] Reported {ip} -> Cats [{categories}] : {comment}")
            reported_cache[ip] = current_time 
            clean_cache()
        elif response.status_code == 429:
            print(f"[LIMIT] API Quota exceeded.")
        else:
            print(f"[ERROR] API {response.status_code}: {response.text}")
    except Exception as e:
        print(f"[FAIL] Connection error: {e}")

def clean_cache():
    """Nettoie le cache"""
    current_time = time.time()
    to_delete = [ip for ip, ts in reported_cache.items() if current_time - ts > REPORT_INTERVAL]
    for ip in to_delete:
        del reported_cache[ip]

def monitor_logs():
    """Lit le journalctl et applique la logique avancée"""
    print("🚀 Monitoring logs with Advanced Port Detection...")
    
    f = subprocess.Popen(['journalctl', '-f', '-n', '0'], stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    p = select.poll()
    p.register(f.stdout)

    # Regex DataShield (SRC + DPT)
    regex_ds = re.compile(r"\[DataShield-BLOCK\].*SRC=([\d\.]+).*DPT=(\d+)")
    # Regex Fail2ban
    regex_f2b = re.compile(r"fail2ban\.actions.*\[(.*?)\] Ban ([\d\.]+)")

    while True:
        if p.poll(100):
            line = f.stdout.readline().decode('utf-8', errors='ignore')
            if not line:
                continue

            # --- LOGIQUE DATASHIELD (KERNEL) ---
            match_ds = regex_ds.search(line)
            if match_ds:
                ip = match_ds.group(1)
                try:
                    port = int(match_ds.group(2))
                except ValueError:
                    port = 0
                
                cats = ["14"]
                attack_type = "Port Scan"

                if port in [80, 443]:
                    cats.extend(["20", "21"])
                    attack_type = "Web Attack"
                elif port in [22, 2222]:
                    cats.extend(["18", "22"])
                    attack_type = "SSH Attack"
                elif port in [53, 5353]:
                    cats.extend(["1", "2", "20"])
                    attack_type = "DNS Attack"
                elif port in [25, 110, 143, 465, 587, 993, 995]:
                    cats.extend(["11", "17"])
                    attack_type = "Mail Relay/Spam"

                final_cats = ",".join(cats)
                send_report(ip, final_cats, f"Blocked by DataShield ({attack_type} on Port {port})")

            # --- LOGIQUE FAIL2BAN ---
            else:
                match_f2b = regex_f2b.search(line)
                if match_f2b:
                    jail = match_f2b.group(1)
                    ip = match_f2b.group(2)
                    
                    cats = "18"
                    if "ssh" in jail: cats = "18,22"
                    elif "nginx" in jail or "apache" in jail: cats = "18,21"
                    
                    send_report(ip, cats, f"Banned by Fail2ban (Jail: {jail})")

if __name__ == "__main__":
    monitor_logs()
EOF

        # Injection de la clé API
        sed -i "s/PLACEHOLDER_KEY/$USER_API_KEY/" /usr/local/bin/abuse_reporter.py
        chmod +x /usr/local/bin/abuse_reporter.py

        log "INFO" "Applying extended Fail2ban configuration (jail.local)..."
        cat <<EOF > /etc/fail2ban/jail.local
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5
ignoreip = 127.0.0.1/8 ::1
backend = systemd

[sshd]
enabled = true
mode = aggressive
port = ssh
logpath = %(sshd_log)s
backend = %(sshd_backend)s

[nginx-http-auth]
enabled = true
port = http,https
logpath = /var/log/nginx/error.log

[nginx-botsearch]
enabled = true
port = http,https
logpath = /var/log/nginx/access.log

[apache-auth]
enabled = true
port = http,https
logpath = %(apache_error_log)s

[apache-badbots]
enabled = true
port = http,https
logpath = %(apache_access_log)s

[mongodb-auth]
enabled = true
port = 27017
logpath = /var/log/mongodb/mongod.log
EOF
        if systemctl is-active --quiet fail2ban; then
            systemctl restart fail2ban
        fi

        log "INFO" "Creating and starting systemd service..."
        cat <<EOF > /etc/systemd/system/abuse-reporter.service
[Unit]
Description=AbuseIPDB Auto-Reporter (DataShield & Fail2ban)
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/abuse_reporter.py
Restart=always
User=root
ProtectSystem=full

[Install]
WantedBy=multi-user.target
EOF

        systemctl daemon-reload
        systemctl enable --now abuse-reporter
        log "INFO" "AbuseIPDB Reporter is now ACTIVE."
        
    else
        log "INFO" "Skipping AbuseIPDB reporting setup."
    fi
}

detect_protected_services() {
    echo -e "\n${BLUE}=== Step 5: Service Integration Check ===${NC}"
    
    # FIX: Force start Fail2ban if installed but not running (Required for RHEL/Alma)
    if command -v fail2ban-client >/dev/null && ! systemctl is-active --quiet fail2ban; then
        log "WARN" "Fail2ban is installed but stopped. Starting service..."
        systemctl enable --now fail2ban || true
        sleep 2
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
    log "INFO" "Monitor '/var/log/syslog', '/var/log/messages' or 'journalctl -k' for '[DataShield-BLOCK]'."
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

    # 1. Cleaning up Auto-Reporter (New in v4.0)
    if systemctl is-active --quiet abuse-reporter; then
        log "INFO" "Stopping AbuseIPDB Reporter service..."
        systemctl disable --now abuse-reporter 2>/dev/null || true
        rm -f /etc/systemd/system/abuse-reporter.service
        systemctl daemon-reload
        log "INFO" "AbuseIPDB Reporter service removed."
    fi

    if [[ -f "/usr/local/bin/abuse_reporter.py" ]]; then
        rm -f "/usr/local/bin/abuse_reporter.py"
        log "INFO" "Reporter script removed."
    fi

    # 2. Cleaning up Cron
    if [[ -f "/etc/cron.d/datashield-update" ]]; then
        rm -f "/etc/cron.d/datashield-update"
        log "INFO" "Cron job removed."
    fi

    # 3. Cleaning Firewall Rules
    log "INFO" "Cleaning firewall rules..."
    
    if command -v nft >/dev/null; then
        nft delete table inet datashield_table 2>/dev/null || true
    fi

    if command -v firewall-cmd >/dev/null && systemctl is-active --quiet firewalld; then
        firewall-cmd --permanent --remove-rich-rule="rule source ipset='$SET_NAME' log prefix='[DataShield-BLOCK] ' level='info' drop" 2>/dev/null || true
        firewall-cmd --permanent --delete-ipset="$SET_NAME" 2>/dev/null || true
        firewall-cmd --reload 2>/dev/null || true
    fi

    if command -v iptables >/dev/null; then
        iptables -D INPUT -m set --match-set "$SET_NAME" src -j DROP 2>/dev/null || true
        iptables -D INPUT -m set --match-set "$SET_NAME" src -j LOG --log-prefix "[DataShield-BLOCK] " 2>/dev/null || true
        if command -v netfilter-persistent >/dev/null; then netfilter-persistent save 2>/dev/null || true; fi
    fi
    
    if command -v ipset >/dev/null; then
        ipset destroy "$SET_NAME" 2>/dev/null || true
    fi

    # 4. Cleaning Configs
    rm -f "$CONF_FILE"
    log "INFO" "Configuration file removed."
    
    # Note: On ne supprime pas fail2ban ni python3-requests car ils peuvent être utilisés par autre chose.
    
    echo -e "${GREEN}Uninstallation complete. Data-Shield and Reporter have been removed.${NC}"
    exit 0
}

# ==============================================================================
# MAIN EXECUTION
# ==============================================================================

MODE="${1:-install}"

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

# --- SECTEUR STATIQUE (S'exécute uniquement à l'installation manuelle) ---
if [[ "$MODE" != "update" ]]; then
    install_dependencies
    configure_fail2ban
fi

# --- SECTEUR DYNAMIQUE (S'exécute tout le temps : Install & Update) ---
select_list_type "$MODE"
select_mirror "$MODE"
download_list
apply_firewall_rules
detect_protected_services

# --- CONFIGURATION SIEM & REPORTING (Uniquement à l'installation manuelle) ---
if [[ "$MODE" != "update" ]]; then
    setup_siem_logging
    setup_abuse_reporting
    setup_cron_autoupdate "$MODE"
    
    echo -e "\n${GREEN}#############################################################"
    echo -e "#                    INSTALLATION SUCCESSFUL                  #"
    echo -e "#############################################################${NC}"
    echo -e " -> List loaded: $LIST_TYPE"
    echo -e " -> Backend: $FIREWALL_BACKEND"
    echo -e " -> Auto-Update: Every Hour"
    echo -e " -> Protection Status: ACTIVE (Permanent Drop)"
fi