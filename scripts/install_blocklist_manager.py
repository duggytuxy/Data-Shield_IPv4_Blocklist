#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Script Name: install_blocklist_manager.py
Description: Enterprise-grade installer for an IPv4 Blocklist Manager.
Target OS:   Ubuntu 20.04+, Debian 11+, Fedora 41+
Python Ver:  3.9+
Author:      Duggy Tuxy (Laurent M.)
"""

import os
import sys
import shutil
import logging
import platform
import subprocess
import urllib.request
import urllib.error
import ssl
import hashlib
import textwrap
import re
from typing import List, Optional

# --- Global Configuration ---
INSTALL_DIR = "/usr/local/bin"
TARGET_SCRIPT_NAME = "update_blocklist.py" # Switching to .py extension
TARGET_SCRIPT = os.path.join(INSTALL_DIR, TARGET_SCRIPT_NAME)
LOG_FILE = "/var/log/blocklist_manager_install.log"

OFFICIAL_SOURCES = [
    "https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt",
    "https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads",
    "https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
]

# --- Console Colors ---
class Colors:
    RESET = '\033[0m'
    INFO = '\033[0;34m'
    OK = '\033[0;32m'
    WARN = '\033[0;33m'
    ERR = '\033[0;31m'
    QUEST = '\033[0;36m'

# --- Logging Configuration ---
logging.basicConfig(
    filename=LOG_FILE,
    level=logging.INFO,
    format='%(asctime)s [%(levelname)s] %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S'
)

def console_log(level: str, msg: str):
    """Displays logs in the console with colors and writes to the log file."""
    color = Colors.INFO
    if level == "SUCCESS": color = Colors.OK
    elif level == "WARNING": color = Colors.WARN
    elif level == "ERROR" or level == "CRITICAL": color = Colors.ERR
    elif level == "QUESTION": color = Colors.QUEST
    
    print(f"{color}[{level}]{Colors.RESET} {msg}")
    logging.info(f"[{level}] {msg}")

# --- Security and System Functions ---

def assert_root():
    """Checks that the script is run with root privileges."""
    if os.geteuid() != 0:
        console_log("ERROR", "Ce script doit être exécuté avec les privilèges root (sudo).")
        sys.exit(1)

def validate_url(url: str) -> bool:
    """Validates the URL (HTTPS) and checks connectivity + TLS 1.2+."""
    url = url.strip()
    if not url.startswith("https://"):
        console_log("ERROR", "Protocole invalide. Seul HTTPS est accepté pour la sécurité.")
        return False

    console_log("INFO", f"Vérification de la connectivité et TLS pour : {url}")
    
    # Create a strict SSL context (TLS 1.2 minimum default on Python 3.9+)
    context = ssl.create_default_context()
    context.minimum_version = ssl.TLSVersion.TLSv1_2

    try:
        req = urllib.request.Request(url, method='HEAD')
        with urllib.request.urlopen(req, context=context, timeout=10) as response:
            if response.status == 200:
                return True
            else:
                console_log("ERROR", f"Code retour inattendu : {response.status}")
                return False
    except (urllib.error.URLError, ssl.SSLError) as e:
        console_log("ERROR", f"URL inaccessible ou erreur TLS : {e}")
        return False
    except Exception as e:
        console_log("ERROR", f"Erreur inattendue lors de la validation : {e}")
        return False

def check_dependencies():
    """Checks for the presence of critical system tools."""
    # nft is required for execution, systemctl for the service
    deps = ["nft", "systemctl"] 
    # curl, grep, sort, sha256sum are no longer required because we use Python!
    
    missing = []
    for cmd in deps:
        if not shutil.which(cmd):
            missing.append(cmd)
    
    if missing:
        console_log("ERROR", f"Dépendances manquantes : {', '.join(missing)}")
        sys.exit(1)

def handle_os_specifics():
    """Detects the OS and applies specific fixes (e.g., Fedora firewalld)."""
    try:
        with open("/etc/os-release", "r") as f:
            os_data = f.read()
        
        if "ID=fedora" in os_data:
            console_log("INFO", "OS détecté : Fedora. Gestion de firewalld...")
            # Disable firewalld if active to prevent conflicts
            subprocess.run(["systemctl", "stop", "firewalld"], stderr=subprocess.DEVNULL)
            subprocess.run(["systemctl", "disable", "firewalld"], stderr=subprocess.DEVNULL)
            
            # Enable nftables
            subprocess.run(["systemctl", "enable", "nftables"], stderr=subprocess.DEVNULL)
        elif "ID=ubuntu" in os_data or "ID=debian" in os_data:
            console_log("INFO", "OS détecté : Debian/Ubuntu.")
        else:
            console_log("WARNING", "OS non explicitement supporté, continuation standard.")
            
    except FileNotFoundError:
        console_log("ERROR", "/etc/os-release introuvable. Impossible de détecter l'OS.")
        sys.exit(1)

# --- User Interaction ---

def select_sources() -> List[str]:
    """Interactive menu for source selection."""
    print(f"\n{Colors.QUEST}--- Sélection des Sources ---{Colors.RESET}")
    print("1) Utiliser les sources officielles de confiance (Auto-Failover)")
    print("2) Utiliser une source personnalisée (Mode Expert)")
    
    choice = input("Sélectionnez une option [1-2] : ").strip()

    if choice == "1":
        console_log("INFO", "Sélectionné : Sources Officielles.")
        return OFFICIAL_SOURCES
    elif choice == "2":
        console_log("INFO", "Sélectionné : Source Personnalisée.")
        while True:
            print(f"\n{Colors.QUEST}Entrez votre URL de Blocklist (HTTPS requis) :{Colors.RESET}")
            custom_url = input("> ").strip()
            
            if validate_url(custom_url):
                console_log("SUCCESS", "Source personnalisée vérifiée et acceptée.")
                return [custom_url]
            else:
                console_log("WARNING", "Veuillez réessayer avec une URL HTTPS valide.")
    else:
        console_log("ERROR", "Sélection invalide. Sortie.")
        sys.exit(1)

# --- Code Generator (The Core System) ---

def generate_updater_script(sources: List[str]):
    """Generates the standalone Python update script."""
    
    # We convert the list of sources into a formatted string for the target Python code
    sources_repr = str(sources)

    # This is the "Updater" script that will be written to disk.
    # It is standalone and only relies on standard Python libraries.
    updater_code = f"""#!/usr/bin/env python3
# ==============================================================================
# Script: {TARGET_SCRIPT_NAME}
# Generated by install_blocklist_manager.py
# Security: TLS 1.2 Enforced | SHA256 Audited | Atomic NFTables
# ==============================================================================

import sys
import os
import subprocess
import urllib.request
import ssl
import hashlib
import tempfile
import re

# Injected Configuration
MIRRORS = {sources_repr}
NFT_TABLE = "data_shield"
NFT_CHAIN = "inbound_block"
NFT_SET = "blocklist_ipv4"
LOG_FILE = "/var/log/nft_blocklist.log"

def log(msg):
    import datetime
    timestamp = datetime.datetime.now().strftime('%Y-%m-%d %H:%M:%S')
    entry = f"{{timestamp}} : {{msg}}"
    print(entry)
    with open(LOG_FILE, "a") as f:
        f.write(entry + "\\n")

def fetch_data():
    # Enforce TLS 1.2+
    context = ssl.create_default_context()
    context.minimum_version = ssl.TLSVersion.TLSv1_2
    
    for url in MIRRORS:
        log(f"Audit: Téléchargement depuis {{url}}")
        try:
            with urllib.request.urlopen(url, context=context, timeout=30) as response:
                data = response.read()
                if not data:
                    log(f"Attention: Fichier vide reçu de {{url}}")
                    continue
                
                # Integrity Check (SHA256 Hash)
                file_hash = hashlib.sha256(data).hexdigest()
                log(f"Integrity SHA256: {{file_hash}}")
                return data.decode('utf-8', errors='ignore')
        except Exception as e:
            log(f"Échec TLS/Connexion vers {{url}}: {{e}}")
    
    return None

def apply_nftables(valid_ips):
    if not valid_ips:
        log("Erreur: Aucune IP valide à appliquer.")
        sys.exit(1)

    # Create atomic batch file content
    batch_content = []
    batch_content.append(f"add table inet {{NFT_TABLE}}")
    batch_content.append(f"add chain inet {{NFT_TABLE}} {{NFT_CHAIN}} {{ type filter hook input priority -100; }}")
    batch_content.append(f"add set inet {{NFT_TABLE}} {{NFT_SET}} {{ type ipv4_addr; flags interval; }}")
    batch_content.append(f"flush set inet {{NFT_TABLE}} {{NFT_SET}}")
    
    # Optimization: Group IPs in a single "add element" command
    ips_str = ", ".join(valid_ips)
    batch_content.append(f"add element inet {{NFT_TABLE}} {{NFT_SET}} {{ {{ips_str}} }}")

    # Drop Rule Logic
    # Conditional injection (using shell for rule idempotence check)
    check_cmd = ["nft", "list", "chain", "inet", NFT_TABLE, NFT_CHAIN]
    try:
        proc = subprocess.run(check_cmd, capture_output=True, text=True)
        if f"@{NFT_SET}" not in proc.stdout:
             batch_content.append(f"insert rule inet {{NFT_TABLE}} {{NFT_CHAIN}} ip saddr @{{NFT_SET}} drop")
    except Exception:
        pass # The table might not exist yet

    # Write to temporary file
    with tempfile.NamedTemporaryFile(mode='w', delete=False) as tmp:
        tmp.write("\\n".join(batch_content))
        tmp_name = tmp.name

    # Apply Configuration via nft -f
    try:
        subprocess.run(["nft", "-f", tmp_name], check=True, stderr=subprocess.PIPE)
        log(f"SUCCESS: Mise à jour appliquée. IPs actives: {{len(valid_ips)}}")
    except subprocess.CalledProcessError as e:
        log(f"ERROR: Transaction NFTables échouée. {{e.stderr.decode()}}")
        os.unlink(tmp_name)
        sys.exit(1)
    
    # Cleanup
    os.unlink(tmp_name)

def main():
    raw_data = fetch_data()
    if not raw_data:
        log("CRITICAL: Toutes les sources ont échoué.")
        sys.exit(1)

    # Strict IPv4 Regex Validation
    ipv4_pattern = re.compile(r'^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$')
    
    valid_ips = set()
    for line in raw_data.splitlines():
        line = line.strip()
        # Ignore comments and empty lines
        if not line or line.startswith('#'):
            continue
        # Basic cleaning (in case there is text after the IP)
        ip_candidate = line.split()[0]
        if ipv4_pattern.match(ip_candidate):
            valid_ips.add(ip_candidate)
    
    if len(valid_ips) < 5:
        log(f"ERROR: Validation échouée. Trop peu d'IPs valides ({{len(valid_ips)}}).")
        sys.exit(1)
        
    apply_nftables(sorted(list(valid_ips)))

if __name__ == "__main__":
    main()
"""

    try:
        with open(TARGET_SCRIPT, "w") as f:
            f.write(updater_code)
        console_log("SUCCESS", f"Script de mise à jour généré : {TARGET_SCRIPT}")
    except IOError as e:
        console_log("ERROR", f"Impossible d'écrire le script cible : {e}")
        sys.exit(1)

def setup_systemd():
    """Configures the Systemd service and Timer."""
    console_log("INFO", "Configuration de Systemd (Hardening activé)...")
    
    service_content = textwrap.dedent(f"""\
        [Unit]
        Description=Update IPv4 Blocklist (Secure Python)
        After=network-online.target

        [Service]
        Type=oneshot
        ExecStart=/usr/bin/python3 {TARGET_SCRIPT}
        User=root
        # ---------- Hardening ----------
        ProtectSystem=full
        ProtectHome=true
        PrivateTmp=true
        NoNewPrivileges=true
        CapabilityBoundingSet=CAP_NET_ADMIN
        MemoryDenyWriteExecute=yes
        RestrictAddressFamilies=AF_INET AF_INET6
    """)

    timer_content = textwrap.dedent("""\
        [Unit]
        Description=Hourly Blocklist Update
        [Timer]
        OnCalendar=hourly
        RandomizedDelaySec=300
        Persistent=true
        [Install]
        WantedBy=timers.target
    """)

    try:
        with open("/etc/systemd/system/blocklist-update.service", "w") as f:
            f.write(service_content)
        with open("/etc/systemd/system/blocklist-update.timer", "w") as f:
            f.write(timer_content)
            
        subprocess.run(["systemctl", "daemon-reload"], check=True)
        subprocess.run(["systemctl", "enable", "--now", "blocklist-update.timer"], check=True)
        subprocess.run(["systemctl", "enable", "blocklist-update.service"], check=True)
    except Exception as e:
        console_log("ERROR", f"Échec de la configuration Systemd : {e}")
        sys.exit(1)

def apply_permissions():
    """Applies file permissions and the immutable attribute."""
    # chmod 750
    os.chmod(TARGET_SCRIPT, 0o750)
    
    # chattr +i (Immutable)
    if shutil.which("chattr"):
        # Try to remove the attribute first in case the file existed
        subprocess.run(["chattr", "-i", TARGET_SCRIPT], stderr=subprocess.DEVNULL)
        subprocess.run(["chattr", "+i", TARGET_SCRIPT], stderr=subprocess.DEVNULL)
        console_log("INFO", "Attribut immuable (+i) appliqué.")

def main():
    console_log("INFO", "Démarrage de l'installation interactive (Version Python)...")
    
    assert_root()
    handle_os_specifics()
    check_dependencies()
    
    if not os.path.exists(INSTALL_DIR):
        os.makedirs(INSTALL_DIR, mode=0o755)

    # 1. Selection
    sources = select_sources()
    
    # 2. Generation
    console_log("INFO", "Génération du gestionnaire sécurisé...")
    generate_updater_script(sources)
    
    # 3. Permissions
    apply_permissions()
    
    # 4. Systemd
    setup_systemd()
    
    # 5. Initial Test
    console_log("INFO", "Lancement de la mise à jour initiale...")
    try:
        # Execute the generated script
        subprocess.run([sys.executable, TARGET_SCRIPT], check=True)
        console_log("SUCCESS", "Installation et vérification initiale terminées.")
    except subprocess.CalledProcessError:
        console_log("CRITICAL", "Le téléchargement initial a échoué. Vérifiez vos logs.")
        sys.exit(1)

if __name__ == "__main__":
    main()