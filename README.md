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

![Alt](https://repobeats.axiom.co/api/embed/8ead3fb191fc45d23c0953782d4aee4901b85ded.svg "Repobeats analytics image")

# Data‑Shield IPv4 Blocklist Community

**The Data-Shield IPv4 Blocklist Community** provides an official, curated registry of IPv4 addresses identified as malicious. Updated continuously, this resource offers vital threat intelligence to bolster your **Firewall** and **WAF** instances, delivering a robust, additional layer of security for your infrastructure.

## ⚡ Key Features & Benefits

- **Proactive Defense & Reduced Attack Surface** The Data-Shield IPv4 Blocklist Community Community serves as an essential protective layer for your exposed assets (Web Apps, WordPress, Websites, VPS with Apache, Nginx). By blocking malicious traffic early, it significantly reduces the reconnaissance phase and lowers visibility on scanners like **Shodan**.

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

## 🎯 Core Objectives & Impact

- **Drastic Noise Reduction & Streamlined Response** By filtering out approximately **95% of malicious bot traffic**, we reduce overall log noise by up to **50%**. This significantly improves the signal-to-noise ratio, allowing **Cybersecurity Incident Responders (CIRs)** to focus on genuine anomalies and critical alerts rather than sifting through automated background noise.

- **Optimized Resource Consumption** Blocking threats at the perimeter prevents them from reaching your application logic. This leads to a direct reduction in **CPU, RAM, and bandwidth usage**, preserving your server resources for legitimate user traffic and reducing infrastructure costs.

- **Automated, Multi-Channel Delivery** Ensure your defense is always active without manual intervention. Blocklists are automatically updated and distributed via high-availability networks including **GitHub, JSdelivr CDN, BitBucket, Codeberg, and GitLab**, guaranteeing reliable access through standard Raw URLs.

## 📋 Production Lists
>  For **Web Apps, WordPress, Websites, VPS with Apache, Nginx**

To guarantee high availability and resilience, the Data-Shield IPv4 Blocklist Community is deployed across a robust multi-cloud infrastructure. The data is synchronized every **6 hours** across multiple repositories and a global CDN.

- **Which list should I use?**

  - **Full List**: Recommended for most modern Firewalls, WAFs, and SIEMs.
  - **Split Lists (A/B/C)**: Designed for legacy hardware or vendors with strict entry limits per object (e.g., max 30k IPs). If used, ensure all 3 parts are ingested.
  
#### ✅ GitHub Repository (Mirror)
> **[View Official Repository](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) |

#### ✅ GitLab Repository (Main Source)
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

#### ✅ BitBucket Repository (Mirror)
> **[View Official Repository](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_ac_data-shield_ipv4_blocklist.txt) |

#### ✅ Codeberg Repository (Mirror)
> **[View Official Repository](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_aa_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_ab_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_ac_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ac_data-shield_ipv4_blocklist.txt) |

### 🐞 New Production Lists
>  For **DMZs, critical assets, exposed infrastructure, and APIs**

- **Critical Infrastructure & Specialized Lists** Tailored for SMBs and enterprise environments, we provide **5 dedicated lists** specifically designed to protect high-value targets such as **DMZs, critical assets, exposed infrastructure, and APIs**. This expanded coverage offers granular protection suited for complex environments, ensuring your most sensitive components remain secure.

#### ✅ GitHub Repository (Mirror)
> **[View Official Repository](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_critical_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_critical_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_critical_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_critical_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_ac_data-shield_ipv4_blocklist.txt) |
| Split List D | 30k IPs | [prod_critical_ad_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_critical_ad_data-shield_ipv4_blocklist.txt) |

#### ✅ GitLab Repository (Main Source)
> **[View Official Repository](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_critical_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_critical_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List A | 30k IPs | [prod_critical_aa_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_critical_aa_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List B | 30k IPs | [prod_critical_ab_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_critical_ab_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List C | 30k IPs | [prod_critical_ac_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_critical_ac_data-shield_ipv4_blocklist.txt?ref_type=heads) |
| Split List D | 30k IPs | [prod_critical_ad_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_critical_ad_data-shield_ipv4_blocklist.txt?ref_type=heads) |

#### ⚡ jsDelivr CDN (High Performance)
> **[View CDN Status](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_critical_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_critical_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_critical_aa_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_critical_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_critical_ab_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_critical_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_critical_ac_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_critical_ac_data-shield_ipv4_blocklist.txt) |
| Split List D | 30k IPs | [prod_critical_ad_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_critical_ad_data-shield_ipv4_blocklist.txt) |

#### ✅ BitBucket Repository (Mirror)
> **[View Official Repository](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_critical_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_critical_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_critical_aa_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_critical_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_critical_ab_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_critical_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_critical_ac_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_critical_ac_data-shield_ipv4_blocklist.txt) |
| Split List D | 30k IPs | [prod_critical_ad_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/HEAD/prod_critical_ad_data-shield_ipv4_blocklist.txt) |

#### ✅ Codeberg Repository (Mirror)
> **[View Official Repository](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist)**

| **Dataset Variant** | **Entry Cap** | **Raw Link** |
| :--- | :---: | :--- |
| **Full List** | ~100k IPs | [prod_critical_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_critical_data-shield_ipv4_blocklist.txt) |
| Split List A | 30k IPs | [prod_critical_aa_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_critical_aa_data-shield_ipv4_blocklist.txt) |
| Split List B | 30k IPs | [prod_critical_ab_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_critical_ab_data-shield_ipv4_blocklist.txt) |
| Split List C | 30k IPs | [prod_critical_ac_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_critical_ac_data-shield_ipv4_blocklist.txt) |
| Split List D | 30k IPs | [prod_critical_ad_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_critical_ad_data-shield_ipv4_blocklist.txt) |

## ⚙️ Integration Tutorials

To ensure the Data-Shield IPv4 Blocklist Community is operational and effective, it is crucial to apply the filtering rules in the correct direction of traffic flow.

### Deployment Strategy

> **✅ Correct Usage: WAN to LAN (Inbound Traffic)**
> The blocklist is designed to stop threats *entering* your network from the Internet.
>
> * **IPtables:** `sudo iptables -A INPUT -s <IP_ADDRESS> -j DROP`
> * **NFtables:** `sudo nft add rule inet filter input ip saddr <IP_ADDRESS> drop`

> **⛔ Restricted Usage: LAN to WAN (Outbound Traffic)**
> Do not apply these rules to outgoing traffic (from your internal network to the Internet).
>
> * **IPtables:** `sudo iptables -A OUTPUT -d <IP_ADDRESS> -j DROP`
> * **NFtables:** `sudo nft add rule inet filter output ip daddr <IP_ADDRESS> drop`

### Community & Vendor Tutorials

A non-exhaustive collection of guides to facilitate integration across various environments.

| **Vendor / Platform** | **Resource Type** | **Capacity Note** |
| :--- | :---: | :---: |
| **[BunkerWeb](https://docs.bunkerweb.io/latest/features/#__tabbed_8_1)** | Official Documentation | ≥ 100k IPs |
| **[Fortinet](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext)** | Official Guide | ≥ 100k IPs |
| **[Checkpoint](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm)** | Manufacturer's Guide | *TBC* |
| **[Palo Alto](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama)** | EDL Overview | *TBC* |
| **[F5 BIG-IP](https://my.f5.com/manage/s/article/K10978895)** | Official Guide | *TBC* |
| **[Stormshield](https://www.youtube.com/watch?v=yT2oas7M2UM)** | Official Video | *TBC* |
| **[OPNsense](https://slash-root.fr/opnsense-block-malicious-ips/)** | Slash-Root Guide | ≥ 100k IPs |
| **[Synology NAS](https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html)** | MyOwnServer Guide | ≥ 100k IPs |

## Integration Universal Script for Linux Servers

**First Official Release (v1.0.1-02)**

This release marks a major milestone for the Data-Shield project. After extensive testing across Debian 12/13, Ubuntu 24.04, AlmaLinux 10, and Rocky Linux 10, we have achieved a truly universal script.

Data-Shield transforms your Linux server into a fortress by preemptively blocking over **100,000 known malicious IPs** (botnets, scanners, brute-forcers, etc.) at the network layer, before they even touch your services.

### Key Features in v1.0.1-02

* **Universal OS Support:** Auto-detects and adapts to **Debian, Ubuntu, RHEL, AlmaLinux, and Rocky Linux**.
* **Intelligent Backend Detection:** Automatically selects the best firewall technology present on your system:
    * 🔥 **Firewalld** (RHEL/Alma/Rocky native integration)
    * 🧱 **Nftables** (Modern Debian/Ubuntu standard)
    * 🛡️ **IPSet/Iptables** (Legacy support)
* **Smart Mirror Selection:** Replaced ICMP Pings with **TCP/HTTP latency checks** to bypass firewall restrictions on GitHub/GitLab, ensuring you always download from the fastest mirror.
* **Kernel-Safe Optimization:**
    * Enables high-performance memory hashing (`hashsize`) on Debian/Ubuntu.
    * Uses conservative, stability-first settings on RHEL/Rocky kernels to prevent "Invalid Argument" crashes.
* **Persistence Guaranteed:** Rules are written to disk (XML for Firewalld, persistent saves for Netfilter), surviving reboots instantly.
* **Auto-Update:** Installs a cron job to refresh the blocklist hourly.

### Technical Deep Dive: Integration Logic

#### 1. The Nftables + Fail2ban Synergy (Debian/Ubuntu)
Many admins worry that installing a massive blocklist might conflict with Fail2ban. **Data-Shield v1.0.1-02 solves this via layering.**
* **Data-Shield (Layer 1):** Creates a high-performance Nftables `set` containing ~100k IPs. This acts as a static shield, dropping known bad actors instantly using extremely efficient kernel-level lookups.
* **Fail2ban (Layer 2):** Continues to monitor logs for *new*, unknown attackers.
* **Result:** Fail2ban uses less CPU because Data-Shield filters out the "background noise" (99% of automated scans) before Fail2ban even has to parse a log line.

#### 2. The Firewalld + Fail2ban Synergy (RHEL/Alma/Rocky)
On Enterprise Linux, proper integration with `firewalld` is critical.
* **Native Sets:** Data-Shield creates a permanent `ipset` type within Firewalld's configuration logic.
* **Rich Rules:** It applies a "Rich Rule" that drops traffic from this set *before* it reaches your zones or services.
* **Persistence:** Unlike simple scripts that run `ipset` commands (which vanish on reload), v1.0.1-02 writes the configuration to `/etc/firewalld/`, ensuring the protection persists across service reloads and server reboots.

### Project Objectives

1.  **Noise Reduction:** Drastically reduce the size of system logs (`/var/log/auth.log`, `journalctl`) by blocking scanners at the door.
2.  **Resource Saving:** Save CPU cycles and bandwidth by dropping packets at the kernel level rather than letting application servers (Nginx, SSHD) handle them.
3.  **Proactive Security:** Move from a "Reactive" stance (wait for 5 failed logins -> Ban) to a "Proactive" stance (Ban the IP because it attacked a server in another country 10 minutes ago).

### 📦 How to Install (root)

```bash
## For Ubuntu/Debian
apt update && apt upgrade

## For Rocky/AlmaLinux/RHEL
dnf update

## install script
wget https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/download/v1.0.1-02/install-datashield.sh
chmod +x install-datashield.sh
sudo ./install-datashield.sh
```

### Uninstallation

```bash
sudo ./install-datashield.sh uninstall
```

## 👩‍⚖️ GRC & Compliance

- **Governance & Operational Efficiency**
  The solution reduces operational noise by up to **50%** and blocks **95%** of malicious bot traffic, significantly freeing up server resources (CPU, RAM). It enforces a strict **WAN-to-LAN configuration** to guarantee system effectiveness while offering 5 official lists (up to 120,000 IPs) adapted to hardware limitations.

- **Regulatory Alignment (ISO 27001 & NIS2)**
  Integration directly supports **ISO 27001:2022** controls (A.8.20 Network Security, A.5.7 Threat Intelligence) by automating perimeter defense against known attacks. It also meets **NIS2 Directive** requirements for essential entities by providing structured risk management and proportionate technical measures to ensure service resilience.

- **GDPR & Privacy Standards**
  When correctly configured (WAN-to-LAN only), the blocklist operates **outside the scope of GDPR**, as blocked IPs belong to external malicious actors with no contractual relationship to your organization. This ensures a compliance-friendly integration without the need for complex personal data processing documentation.

- **Risk Management & Reliability**
  We utilize a rigorous behavioral analysis methodology to minimize false positives, targeting a rate of less than **2 occurrences per month**. High availability is guaranteed via 4 independent download sources (GitHub, BitBucket, Codeberg, GitLab), ensuring continuous protection even during host incidents.

- **Structured Deployment & Community Feedback**
  Adoption follows a secure, phased approach—from **Observation** (logging only) to **Activation**—ensuring non-regression on critical flows. The project fosters transparency with a clear process for reporting false positives via GitHub, aiming for collective improvement and resolution within 48 hours.

> **Download the complete GRC Compliance Model** to modify it if necessary and insert it into your information systems security policy, in accordance with your GRC officer [Docx and PDF formats](/docs).

## 🛣️ Roadmap

| Objective | Target Date |
| :--- | :---: |
| Fail2ban Integration | Q1 2026 |
| API v2 | Q2 2026 |
| Dashboard Management (SaaS) | Q3 2026 |

## 🙏 Support & Sustainability

> **Help keep the project alive**
> Developing and maintaining a high-fidelity, real-time blocklist requires significant infrastructure resources and dedicated time. Your contributions are vital to ensure the project remains sustainable, up-to-date, and free for the community.
> If you find this project useful, consider supporting its ongoing development:

* ☕ **Ko-Fi:** [https://ko-fi.com/laurentmduggytuxy](https://ko-fi.com/laurentmduggytuxy)

## ⚖️ License & Copyright

- **Data-Shield IPv4 Blocklist Community** © 2023–2026  
- Developed by **Duggy Tuxy (Laurent Minne)**.

"This project is open-source software licensed under the **[GNU GPLv3 License](/LICENSE)**."
