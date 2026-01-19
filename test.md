<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/powered%20by-DuggyTuxy-darkred?style=for-the-badge&logo=apachekafka">
  <img src="https://img.shields.io/badge/Status-Production--Ready-brightgreen?style=for-the-badge&logo=status">
  <img src="https://img.shields.io/badge/Security-Hardened-blue?style=for-the-badge&logo=security">
  <img src="https://img.shields.io/badge/License-GNU_GPLv3-0052cc?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=Last%20Update&color=informational&style=for-the-badge&logo=github">
</p>

<div align="center">
  <a href="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist">GitHub</a> • 
  <a href="https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist">GitLab</a> • 
  <a href="https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/">BitBucket</a> • 
  <a href="https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist">Codeberg</a> • 
  <a href="https://www.linkedin.com/in/laurent-minne/">LinkedIn</a> • 
  <a href="https://ko-fi.com/laurentmduggytuxy">Support</a>
</div>

<br>

<p align="center">
  <a href="https://ko-fi.com/L4L71HRILD">
    <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support on Ko-fi">
  </a>
</p>

---

# Data-Shield IPv4 Blocklist

**A curated, production-ready blocklist protecting your infrastructure from malicious traffic.**

Data-Shield provides up-to-date IPv4 addresses identified through intelligent threat detection and deceptive security techniques. Integrate seamlessly with firewalls and WAFs to reduce attack surface, block malicious bots, and save server resources.

---

## Why Choose Data-Shield?

### 🛡️ **Enhanced Protection**
Block malicious IPs before they reach your applications. Reduce reconnaissance activities and prevent exposure on platforms like Shodan.

### 📊 **Proven Results**
- Reduce noise by up to **50%**
- Block approximately **95%** of malicious bot traffic
- Lower CPU and RAM consumption on your servers

### 🔄 **Always Current**
- Updated every **6 hours**
- Data retention: **15 days** (optimized for short-lived threats)
- Single-source intelligence from global probes

### 🚀 **Easy Integration**
- Compatible with major firewall and WAF vendors
- Simple URL-based updates (no complex configurations)
- Available in split lists to accommodate vendor limitations

### ✅ **Reliable & Open**
- High-quality data with minimal false positives
- GNU GPLv3 licensed
- Free for all users
- Compatible with CTI platforms (OpenCTI, MISP)

---

## How It Works

```
┌─────────────────────────────────────┐
│   Data-Shield IPv4 Blocklist        │
│   (Central Threat Intelligence)     │
└──────────────┬──────────────────────┘
               │
       ┌───────┴────────┐
       │                │
       ▼                ▼
┌─────────────┐  ┌─────────────┐
│  Firewalls  │  │    WAFs     │
│  (L3/L4)    │  │   (L7)      │
└─────────────┘  └─────────────┘
       │                │
       └───────┬────────┘
               ▼
    ┌──────────────────┐
    │ Protected Assets │
    └──────────────────┘
```

---

## Available Lists

Data-Shield offers **5 production lists** updated every 6 hours across multiple platforms for high availability.

| List Type | Max IPs | Description |
|-----------|---------|-------------|
| **Full** | 120,000 | Complete blocklist |
| **Split A-D** | 30,000 each | Divided lists for vendor limitations |

### Download Sources

Choose your preferred platform:

**Primary Source (GitLab)**
- [Full List](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads)
- [Split A](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_aa_data-shield_ipv4_blocklist.txt?ref_type=heads) | [B](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ab_data-shield_ipv4_blocklist.txt?ref_type=heads) | [C](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ac_data-shield_ipv4_blocklist.txt?ref_type=heads) | [D](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ad_data-shield_ipv4_blocklist.txt?ref_type=heads)

**Mirror: GitHub**
- [Full List](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt)
- [Split A](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | [B](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | [C](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | [D](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt)

**CDN: JSDelivr**
- [Full List](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt)
- [Split A](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | [B](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | [C](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | [D](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt)

<details>
<summary><b>Additional Mirrors (BitBucket, Codeberg)</b></summary>

**BitBucket**
- [Full List](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_data-shield_ipv4_blocklist.txt)
- [Split A](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_aa_data-shield_ipv4_blocklist.txt) | [B](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ab_data-shield_ipv4_blocklist.txt) | [C](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ac_data-shield_ipv4_blocklist.txt) | [D](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ad_data-shield_ipv4_blocklist.txt)

**Codeberg**
- [Full List](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt)
- [Split A](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_aa_data-shield_ipv4_blocklist.txt) | [B](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ab_data-shield_ipv4_blocklist.txt) | [C](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ac_data-shield_ipv4_blocklist.txt) | [D](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ad_data-shield_ipv4_blocklist.txt)

</details>

---

## Quick Start

### Supported Platforms

**Firewalls**
- OPNsense (≥100K IPs) - [Guide](https://slash-root.fr/opnsense-block-malicious-ips/)
- Fortinet FortiGate (≥100K IPs) - [Guide](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext)
- Palo Alto Networks - [Guide](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list)
- Checkpoint, Stormshield, F5 BIG-IP

**Web Application Firewalls**
- Cloudflare WAF
- BunkerWeb
- AWS WAF

**Linux Systems**
- NFtables (≥100K IPs) - Automated script available
- IPtables (≥100K IPs)

**Other**
- Synology NAS - [Guide](https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html)

---

## Installation (Linux)

### Automated NFtables Deployment

**System Requirements:**
- Debian 11+, Ubuntu 20.04+, or Fedora 41+
- Root/sudo access
- Internet connection

**Install in 2 steps:**

```bash
# 1. Download installer
wget https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/download/v0.4.0/install_blocklist_manager.sh
chmod +x install_blocklist_manager.sh

# 2. Run installation
sudo ./install_blocklist_manager.sh
```

**Features:**
- ✅ Automatic hourly updates via systemd
- ✅ Atomic rule reloading (zero downtime)
- ✅ TLS 1.2+ verification
- ✅ Sandboxed execution
- ✅ Auto-failover to mirrors

### Important Configuration

**✅ Correct Rule Direction (WAN → LAN / Inbound)**
```bash
# NFtables example
sudo nft add rule inet filter input ip saddr <IP_ADDRESS> drop

# IPtables example
sudo iptables -A INPUT -s <IP_ADDRESS> -j DROP
```

**❌ Incorrect Direction (LAN → WAN / Outbound) - DO NOT USE**
```bash
# These will block your outbound traffic - AVOID
sudo nft add rule inet filter output ip daddr <IP_ADDRESS> drop
sudo iptables -A OUTPUT -d <IP_ADDRESS> -j DROP
```

### Log Rotation (Recommended)

Prevent log file growth with automatic rotation:

```bash
# Create logrotate configuration
cat <<EOF | sudo tee /etc/logrotate.d/blocklist-manager
/var/log/nft_blocklist.log
/var/log/blocklist_manager_install.log {
    weekly
    rotate 4
    compress
    delaycompress
    missingok
    notifempty
    create 0640 root adm
}
EOF

# Set permissions
sudo chmod 644 /etc/logrotate.d/blocklist-manager
sudo chown root:root /etc/logrotate.d/blocklist-manager

# Test configuration
sudo logrotate -d /etc/logrotate.d/blocklist-manager
```

### Uninstallation

```bash
sudo ./install_blocklist_manager.sh --uninstall
```

---

## Compliance & Documentation

For organizations requiring compliance documentation, GRC models are available:

| Document | Language | Format | Compliance |
|----------|----------|--------|------------|
| [EN_GRC_Compliance_Model](./docs/EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.pdf) | English | PDF | ISO27001:2022, NIS2, GDPR |
| [EN_GRC_Compliance_Model](./docs/EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.docx) | English | DOCX (Editable) | ISO27001:2022, NIS2, GDPR |
| [FR_Modele_GRC](./docs/FR_Modele_GRC_DataShield_IPv4_Blocklist.pdf) | French | PDF | ISO27001:2022, NIS2, GDPR |
| [FR_Modele_GRC](./docs/FR_Modele_GRC_DataShield_IPv4_Blocklist.docx) | French | DOCX (Editable) | ISO27001:2022, NIS2, GDPR |

These documents can be customized to fit your organization's GRC processes.

---

## Support This Project

Data-Shield is maintained by **Laurent Minne (Duggy Tuxy)** and requires ongoing time and resources.

**Support development:**
- ☕ [Ko-fi Donations](https://ko-fi.com/laurentmduggytuxy)

---

## License

**Data-Shield IPv4 Blocklist** © 2023-2026 by Laurent Minne (Duggy Tuxy)  
Licensed under [GNU General Public License v3.0](./LICENSE)

---

## Connect

- 🌐 [LinkedIn](https://www.linkedin.com/in/laurent-minne/)
- 🎯 [TryHackMe](https://tryhackme.com/p/duggytuxy)
- 💻 [GitHub](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist)
- 🦊 [GitLab](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist)

---

<p align="center">
  <i>Protecting infrastructure through intelligent threat intelligence</i>
</p>