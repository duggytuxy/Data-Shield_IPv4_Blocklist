<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/powered%20by-DuggyTuxy-darkred?style=for-the-badge&logo=apachekafka">
  <img src="https://img.shields.io/badge/Status-Community--Professional-brightgreen?style=for-the-badge&logo=status">
  <img src="https://img.shields.io/badge/Security-Hardened-blue?style=for-the-badge&logo=security">
  <img src="https://img.shields.io/badge/Platform-Debian%20%7C%20Ubuntu%20%7C%20Fedora-orange?style=for-the-badge&logo=platform">
  <img src="https://img.shields.io/badge/License-GNU_GPLv3-0052cc?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=IPv4%20Blocklist%20Last%20Update&color=informational&style=for-the-badge&logo=github">
</p>

<div align="center">
  <a href="https://duggytuxy.github.io/" target="_blank">Website</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues">Issues Tracker</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://www.linkedin.com/in/laurent-minne/" target="_blank">Linkedin</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://tryhackme.com/p/duggytuxy" target="_blank">TryHackMe</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://ko-fi.com/laurentmduggytuxy" target="_blank">Ko-Fi</a>
  <br />
</div>

<p align="center">
  <br />
  <a href="https://ko-fi.com/L4L71HRILD" target="_blank">
    <img src="https://ko-fi.com/img/githubbutton_sm.svg" alt="Support me on Ko-fi">
  </a>
  <br />
</p>

## Table of Contents  

1. [Presentation](#datashield-ipv4-blocklist-community)
2. [Key Features & Benefits](#key-features--benefits)  
3. [Core Objectives & Impact](#core-objectives--impact)  
4. [Production Lists (Mirrors)](#production-lists-mirrors)  
5. [Integration Tutorials](#integration-tutorials)  
6. [Installation & Management Scripts](#installation--management-scripts)  
7. [GRC Compliance Model](#grc-compliance-model) 
8. [Roadmap](#roadmap) 
9. [Support & Sustainability](#support--sustainability)  

# Data‑Shield IPv4 Blocklist Community

**The Data-Shield IPv4 Blocklist Community** provides an official, curated registry of IPv4 addresses identified as malicious. Updated continuously, this resource offers vital threat intelligence to bolster your **Firewall** and **WAF** instances, delivering a robust, additional layer of security for your infrastructure.

## Key Features & Benefits

- **Proactive Defense & Reduced Attack Surface** The Data-Shield IPv4 Blocklist Community serves as an essential protective layer for your exposed assets (Web Apps, WordPress, Websites, VPS with Linux OS). By blocking malicious traffic early, it significantly reduces the reconnaissance phase and lowers visibility on scanners like **Shodan**.

- **High-Fidelity, Centralized Intelligence** Data is aggregated from a single, verified source fed by global probes and processed via a self-hosted HIDS/SIEM stack. We prioritize **data reliability** to minimize false positives, ensuring your legitimate traffic remains uninterrupted.

- **Seamless Compatibility & Integration** Designed for universal deployment:
  - **Universal Format**: Easily integrates via a single RAW link into most Firewalls and WAFs.
  - **Vendor-Agnostic**: Includes split-list logic to accommodate hardware vendors with strict entry-count limitations.
  - **CTI Ready**: Fully portable for enrichment in Threat Intelligence platforms like OpenCTI and MISP.

- **Freshness & Performance**
  - **Updates**: Refreshed every **6 hours** to counter immediate threats.
  - **Retention**: A **15-day** rolling window ensures we track short-lived malicious IPs without bloating your rulesets with obsolete data.
  - **Efficiency**: Delivers enterprise-grade performance comparable to commercial solutions.

- **Open Source & Community Driven** Accessible to anyone—from hobbyists to enterprise admins. The project is proudly distributed under the [GNU GPLv3 license](/LICENSE), fostering a transparent and collaborative security ecosystem.

- **Professional Plan & Management Dashboard** Designed for SMBs and large enterprises, the **Professional Plan** extends protection to high-value targets such as **DMZs, critical assets, critical assets exposed and APIs**. This tier grants access to a dedicated **Management Dashboard**, allowing for granular control over list configurations and deployment strategies suited for complex environments. See [**official website**](https://duggytuxy.github.io).

## Core Objectives & Impact

- **Drastic Noise Reduction & Streamlined Response** By filtering out approximately **95% of malicious bot traffic**, we reduce overall log noise by up to **50%**. This significantly improves the signal-to-noise ratio, allowing **Cybersecurity Incident Responders (CIRs)** to focus on genuine anomalies and critical alerts rather than sifting through automated background noise.

- **Optimized Resource Consumption** Blocking threats at the perimeter prevents them from reaching your application logic. This leads to a direct reduction in **CPU, RAM, and bandwidth usage**, preserving your server resources for legitimate user traffic and reducing infrastructure costs.

- **Automated, Multi-Channel Delivery** Ensure your defense is always active without manual intervention. Blocklists are automatically updated and distributed via high-availability networks including **GitHub, JSdelivr CDN, BitBucket, Codeberg, and GitLab**, guaranteeing reliable access through standard Raw URLs.

## Production Lists (Mirrors)

To guarantee high availability and resilience, the Data-Shield IPv4 Blocklist is deployed across a robust multi-cloud infrastructure. The data is synchronized every **6 hours** across multiple repositories and a global CDN.

- **Which list should I use?**

  - **Full List**: Recommended for most modern Firewalls, WAFs, and SIEMs.
  - **Split Lists (A/B/C)**: Designed for legacy hardware or vendors with strict entry limits per object (e.g., max 30k IPs). If used, ensure all 3 parts are ingested.

#### <img src="https://github.githubassets.com/images/modules/logos_page/GitHub-Mark.png" width="20"/> GitHub Repository (Mirror)
> **[View Official Repository](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) |

#### <img src="https://about.gitlab.com/images/press/press-kit-icon.svg" width="20"/> GitLab Repository (Main Source)
> **[View Official Repository](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_aa_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ab_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ac_data-shield_ipv4_blocklist.txt?ref_type=heads) |

#### ⚡ jsDelivr CDN (High Performance)
> **[View CDN Status](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) |

#### <img src="https://cdn.worldvectorlogo.com/logos/bitbucket.svg" width="20"/> BitBucket Repository (Mirror)
> **[View Official Repository](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ac_data-shield_ipv4_blocklist.txt) |

#### <img src="https://codeberg.org/assets/img/logo.svg" width="20"/> Codeberg Repository (Mirror)
> **[View Official Repository](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ac_data-shield_ipv4_blocklist.txt) |

## Integration Tutorials

To ensure the Data-Shield IPv4 Blocklist is operational and effective, it is crucial to apply the filtering rules in the correct direction of traffic flow.

### Deployment Strategy

> [!TIP]
> **✅ Correct Usage: WAN to LAN (Inbound Traffic)**
> The blocklist is designed to stop threats *entering* your network from the Internet.
>
> * **IPtables:** `sudo iptables -A INPUT -s <IP_ADDRESS> -j DROP`
> * **NFtables:** `sudo nft add rule inet filter input ip saddr <IP_ADDRESS> drop`

> [!CAUTION]
> **⛔ Restricted Usage: LAN to WAN (Outbound Traffic)**
> Do not apply these rules to outgoing traffic (from your internal network to the Internet).
>
> * **IPtables:** `sudo iptables -A OUTPUT -d <IP_ADDRESS> -j DROP`
> * **NFtables:** `sudo nft add rule inet filter output ip daddr <IP_ADDRESS> drop`

### Community & Vendor Tutorials

A non-exhaustive collection of guides to facilitate integration across various environments.

| **Vendor / Platform** | **Resource Type** | **Capacity Note** |
| :--- | :---: | :---: |
| **[Fortinet](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext)** | Official Guide | ≥ 100k IPs |
| **[Checkpoint](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm)** | Manufacturer's Guide | *TBC* |
| **[Palo Alto](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama)** | EDL Overview | *TBC* |
| **[F5 BIG-IP](https://my.f5.com/manage/s/article/K10978895)** | Official Guide | *TBC* |
| **[Stormshield](https://www.youtube.com/watch?v=yT2oas7M2UM)** | Official Video | *TBC* |
| **[OPNsense](https://slash-root.fr/opnsense-block-malicious-ips/)** | Slash-Root Guide | ≥ 100k IPs |
| **[Synology NAS](https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html)** | MyOwnServer Guide | ≥ 100k IPs |
| **[Linux (NFtables/IPtables)](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#integration-scripts)** | Duggy Tuxy Tutorials | ≥ 100k IPs |

## Installation & Management Scripts

### Automated Installation & Management (NFtables)

> [!TIP]
> **Why use this manager?**
> This solution provides a secure, atomic, and idempotent way to deploy the Data-Shield Blocklist on critical Linux infrastructures. It ensures zero downtime during rule updates and includes strict validation mechanisms.

#### Key Capabilities
* **Hardened Security:** Enforces strict TLS 1.2+ verification, sandboxed Systemd execution (`ProtectSystem=full`), and immutable script protection.
* **High Performance:** Utilizes optimized NFtables sets and performs **atomic updates**, ensuring no traffic is dropped or allowed incorrectly during reloads.
* **Resilient & Idempotent:** Designed to run safely multiple times. Includes auto-failover to mirrors if the primary source is unreachable.

### 1. Quick Deployment

> [!NOTE]
> **Supported OS:** Debian 11+, Ubuntu 20.04+, Fedora 41+

> [!CAUTION]
> **Pre-Production Testing Required**
> Always test these scripts in a lab or staging environment before deploying to production to ensure compatibility with your existing firewall rules.

```bash
# 1. Download the installer
wget https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/download/v0.4.0/install_blocklist_manager.sh
chmod +x install_blocklist_manager.sh

# 2. Run with root privileges
sudo ./install_blocklist_manager.sh
```
***During installation, follow the interactive prompts to select your source (Official or Custom).***

### 2. Automatic Updates (Systemd)

Once installed, a timer (`blocklist-update.timer`) executes hourly to perform the following cycle:

  - **Audit**: Downloads the list and verifies SHA256 integrity.
  - **Validate**: Checks IP formats (Strict Regex) and entry counts.
  - **Apply**: Atomically swaps the NFtables set using a temporary batch file.

### 3. Log Rotation (Highly Recommended)

To prevent disk saturation from the hourly execution logs, it is essential to configure `logrotate`.

> [!IMPORTANT]
> Why is this necessary?

  - **Disk Space**: Prevents `/var` from filling up indefinitely.
  - **Security**: Enforces `0640` permissions, adhering to the Principle of Least Privilege.
  - **Performance**: Uses `delaycompress` to prevent race conditions during writing.

**Quick Setup (Copy & Paste)** Run the following block as root to create the configuration and verify permissions:

```bash
# 1. Create the configuration file
cat <<EOF > /etc/logrotate.d/blocklist-manager
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

# 2. Secure the file permissions
chmod 644 /etc/logrotate.d/blocklist-manager
chown root:root /etc/logrotate.d/blocklist-manager

# 3. Verify configuration (Dry Run)
logrotate -d /etc/logrotate.d/blocklist-manager
```

### 4. Uninstallation

> [!NOTE] 
> To cleanly remove the script, services, logs, and firewall rules:

```bash
sudo ./install_blocklist_manager.sh --uninstall
```

## GRC Compliance Model

> [!IMPORTANT]
> **Regulatory Alignment**
> To support organizations in their compliance journey, we provide dedicated documentation mapping the Data-Shield IPv4 Blocklist implementation to key standards: **[ISO27001:2022](https://en.wikipedia.org/wiki/ISO/IEC_27001)**, **[NIS2 Directive](https://en.wikipedia.org/wiki/Cyber-security_regulation#NIS_2_Directive)**, and **[GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation)**.

### Available Documentation

| **Document Title & Link** | **Language** | **Format / Rights** | **Compliance Scope** |
| :--- | :---: | :---: | :---: |
| **[GRC Compliance Model (Editable)](/docs/EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.docx)** | 🇬🇧 EN | `.docx` (Read/Write) | ✅ ISO, NIS2, GDPR |
| [GRC Compliance Model (Reference)](/docs/EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.pdf) | 🇬🇧 EN | `.pdf` (Read Only) | ✅ ISO, NIS2, GDPR |
| **[Modèle de Conformité GRC (Editable)](/docs/FR_Modele_GRC_DataShield_IPv4_Blocklist.docx)** | 🇫🇷 FR | `.docx` (Read/Write) | ✅ ISO, NIS2, GDPR |
| [Modèle de Conformité GRC (Reference)](/docs/FR_Modele_GRC_DataShield_IPv4_Blocklist.pdf) | 🇫🇷 FR | `.pdf` (Read Only) | ✅ ISO, NIS2, GDPR |

### How to use these resources

> [!NOTE]
> **Template Flexibility**
> These documents are designed as templates. They should be reviewed and adapted to accurately reflect your specific infrastructure and security policies.

> [!TIP]
> **Integration Workflow**
> 1. **Download** the editable `.docx` version suitable for your region.
> 2. **Customize** the content to match your specific deployment of the blocklist.
> 3. **Insert** the finalized document into your organization's GRC registry or Information Security Management System (ISMS).

## Support & Sustainability

> [!IMPORTANT]
> **Help keep the project alive**
> Developing and maintaining a high-fidelity, real-time blocklist requires significant infrastructure resources and dedicated time. Your contributions are vital to ensure the project remains sustainable, up-to-date, and free for the community.

If you find this project useful, consider supporting its ongoing development:

* ☕ **Ko-Fi:** [https://ko-fi.com/laurentmduggytuxy](https://ko-fi.com/laurentmduggytuxy)

### ⚖️ License & Copyright

- **Data-Shield IPv4 Blocklist Community** © 2023–2026  
- Developed by **Duggy Tuxy (Laurent Minne)**.

"This project is open-source software licensed under the **[GNU GPLv3 License](/LICENSE)**."