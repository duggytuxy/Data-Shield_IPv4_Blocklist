<p align="left">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/images/data_shield_logo_official_dark_white.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/images/data_shield_logo_official_white_dark.png">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/images/data_shield_logo_official_white_dark.png" />
</picture>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/powered%20by-DuggyTuxy-darkred?style=for-the-badge&logo=apachekafka">
  <img src="https://img.shields.io/badge/Status-Production--Grade-brightgreen?style=for-the-badge&logo=status">
  <img src="https://img.shields.io/badge/Security-Hardened-blue?style=for-the-badge&logo=security">
  <img src="https://img.shields.io/badge/Platform-Debian%20%7C%20Ubuntu%20%7C%20Fedora-orange?style=for-the-badge&logo=platform">
  <img src="https://img.shields.io/badge/License-GNU_GPLv3-0052cc?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=IPv4%20Blocklist%20Last%20Update&color=informational&style=for-the-badge&logo=github">
</p>

<div align="center">
  <a href="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist" target="_blank">GitHub</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist" target="_blank">GitLab</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/" target="_blank">BitBucket</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist" target="_blank">Codeberg</a>
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

# Data-Shield IPv4 Blocklist 

Data-Shield IPv4 Blocklist is an additional layer of protection containing a list of [IP addresses (version 4)](https://en.wikipedia.org/wiki/IPv4) whose activities have been detected as malicious.

This list is designed around the discipline of [Deceptive Security](https://en.wikipedia.org/wiki/Deception_technology) based on intelligent behavioral analysis of malicious activities related to cybercrime.

Data-Shield IPv4 Blocklist contains the most recent data (IPv4 addresses) to provide an additional layer of security for your [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)) and [WAF](https://en.wikipedia.org/wiki/Web_application_firewall) instances.

## Why Data-Shield IPv4 Blocklist?

- **Protective layer**: [Data-Shield IPv4 Blocklist](https://www.linkedin.com/in/laurent-minne/) provides an additional layer of security to reduce the number and attack surface of your exposed assets (web applications, websites, DMZs, public IPs, etc.), reducing the recon phase and exposure of your data on platforms such as [Shodan](https://www.shodan.io/) and similar.
- **Open to the general public**: Data-Shield IPv4 Blocklist is open to any user with a firewall, WAF and other similar protection mechanisms.
- **Single origin**: Data-Shield IPv4 Blocklist comes from a single source, processed by probes located around the world. Logs are centralized on a self-hosted [HIDS](https://en.wikipedia.org/wiki/Host-based_intrusion_detection_system)/[SIEM](https://fr.wikipedia.org/wiki/Security_information_and_event_management) platform, secured via an open-source WAF.
- **Easy integration into your firewall and WAF instances**: This list can be easily integrated into most vendors as a single link (RAW) for standard recognition of the included data.
- **Customizable based on vendor limitations**: Some vendors have limited the number of IPv4 addresses per entry (per list) to prevent resource consumption overload. Data-Shield IPv4 Blocklist is designed to comply with this limitation by creating split lists.
- **Data reliability (IPv4)**: Data-Shield IPv4 Blocklist provides high-quality, reliable data by minimizing false positives to avoid blocking legitimate exposed instances.
- **Portability**: The content of the Data-Shield IPv4 Blocklist can be used to enrich [IoC](https://en.wikipedia.org/wiki/Indicator_of_compromise) data types on open source [CTI](https://en.wikipedia.org/wiki/Cyber_threat_intelligence) platforms such as [OpenCTI](https://github.com/OpenCTI-Platform/opencti), [MISP](https://github.com/MISP/MISP), and others.
- **Frequency of updates**: Data-Shield IPv4 Blocklist is updated every ```12``` hours to maintain the most recent data in order to protect you as effectively as possible.
- **Data retention (IPv4 only)**: Data retention is limited to a maximum of ```60``` days. This retention is mainly used to continuously monitor the activities of IPv4 addresses tagged as malicious, which have short lifespans but are likely to resurface.
- **Performance**: Data-Shield IPv4 Blocklist is just as effective as those offered by other solutions and vendors.
- **The GNU GPLv3 Licence**: Data-Shield IPv4 Blocklist is licensed under [GNU GPLv3](/LICENSE).

## Primary objectives

- Data-Shield IPv4 Blocklist contains the latest data for blocking IPs generating malicious traffic and activities.
- Reduce noise by up to 50%, save time on incident response, reduce consumption of CPU, RAM, and other server resources.
- Block up to approximately 95% of malicious bot traffic in order to significantly reduce the load on servers in terms of resources.
- Automatic update of blocklists via GitHub, JSdelivr [CDN](https://en.wikipedia.org/wiki/Content_delivery_network) and GitLab Raw URLs.

## Production lists

> [!IMPORTANT]
> Data-Shield IPv4 Blocklist consists of 9 official lists that are updated every 24 hours.
> To ensure availability and resilience, two mirrors and an open-source CDN are put into production.
> Exhaustive lists of those that are put into production, followed by their uses and limitations:

> [!TIP]
> **GitHub Repository**
> [Official Link](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist)

| **GitHub RAW URL (Mirror)** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [prod_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) | Full | 240.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |
| [prod_ae_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ae_data-shield_ipv4_blocklist.txt) | Split E | 30.000 IPs |
| [prod_af_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_af_data-shield_ipv4_blocklist.txt) | Split F | 30.000 IPs |
| [prod_ag_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ag_data-shield_ipv4_blocklist.txt) | Split G | 30.000 IPs |
| [prod_ah_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ah_data-shield_ipv4_blocklist.txt) | Split H | 30.000 IPs |

> [!TIP]
> **GitLab Repository**
> [Official Link](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/)

| **GitLab RAW URL (Main)** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [prod_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads) | Full | 240.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_aa_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ab_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ac_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ad_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split D | 30.000 IPs |
| [prod_ae_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ae_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split E | 30.000 IPs |
| [prod_af_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_af_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split F | 30.000 IPs |
| [prod_ag_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ag_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split G | 30.000 IPs |
| [prod_ah_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ah_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split H | 30.000 IPs |

> [!TIP]
> **CDN JSdelivr Refs**
> [Official Link](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/)

| **CDN JSdelivr URL (Mirror)** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [prod_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_data-shield_ipv4_blocklist.txt) | Full | 240.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |
| [prod_ae_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ae_data-shield_ipv4_blocklist.txt) | Split E | 30.000 IPs |
| [prod_af_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_af_data-shield_ipv4_blocklist.txt) | Split F | 30.000 IPs |
| [prod_ag_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ag_data-shield_ipv4_blocklist.txt) | Split G | 30.000 IPs |
| [prod_ah_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@refs/heads/main/prod_ah_data-shield_ipv4_blocklist.txt) | Split H | 30.000 IPs |

> [!TIP]
> **BitBucket Repository**
> [Official Link](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/)

| **BitBucket RAW URL (Mirror)** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [prod_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_data-shield_ipv4_blocklist.txt) | Full | 240.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |
| [prod_ae_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ae_data-shield_ipv4_blocklist.txt) | Split E | 30.000 IPs |
| [prod_af_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_af_data-shield_ipv4_blocklist.txt) | Split F | 30.000 IPs |
| [prod_ag_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ag_data-shield_ipv4_blocklist.txt) | Split G | 30.000 IPs |
| [prod_ah_data-shield_ipv4_blocklist.txt](https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/raw/99c4b9fd8aa92f0e7d0f7b76cd465d130d752f5d/prod_ah_data-shield_ipv4_blocklist.txt) | Split H | 30.000 IPs |

> [!TIP]
> **Codeberg Repository**
> [Official Link](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist)

| **Codeberg RAW URL (Mirror)** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [prod_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt) | Full | 240.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |
| [prod_ae_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ae_data-shield_ipv4_blocklist.txt) | Split E | 30.000 IPs |
| [prod_af_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_af_data-shield_ipv4_blocklist.txt) | Split F | 30.000 IPs |
| [prod_ag_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ag_data-shield_ipv4_blocklist.txt) | Split G | 30.000 IPs |
| [prod_ah_data-shield_ipv4_blocklist.txt](https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ah_data-shield_ipv4_blocklist.txt) | Split H | 30.000 IPs |
## Integration tutorials:

> [!IMPORTANT]
> The main firewall rule around Data-Shield IPv4 Blocklist lists is implemented as follows so that it is operational and effective in terms of blocking:

> [!TIP]
> **From the internet to the internal network (WAN to LAN 👉 Inbound Rules)**
> - Example (IPtables): `sudo iptables -A INPUT -s <IP_ADDRESS> -j DROP`
> - Example (NFtables): `sudo nft add rule inet filter input ip saddr <IP_ADDRESS> drop`

> [!CAUTION]
> **Do not integrate these flow rules in this direction (LAN to WAN 👉 Outbound Rules)**
> - Example (IPtables): `sudo iptables -A OUTPUT -d <IP_ADDRESS> -j DROP`
> - Example (NFtables): `sudo nft add rule inet filter output ip daddr <IP_ADDRESS> drop`

> [!NOTE]
> To facilitate the integration of Data-Shield IPv4 Blocklist into firewall instances, here is a non-exhaustive list of some tutorials offered by vendors and the Cyber community:

| **Vendors URL** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [Fortinet](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext) | Official guide | ≥ 100.000 IPs |
| [Checkpoint](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) | Manufacturer's guide | To Be Confirmed |
| [Palo Alto](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama) | EDL Overview | To Be Confirmed |
| [OPNsense](https://slash-root.fr/opnsense-block-malicious-ips/) | Slash-Root Guide (Julien Louis) | ≥ 100.000 IPs |
| [Stormshield](https://www.youtube.com/watch?v=yT2oas7M2UM) | Official video | To Be Confirmed |
| [F5 BIG-IP](https://my.f5.com/manage/s/article/K10978895) | Official guide | To Be Confirmed |
| [NFtables, IPtables](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#integration-scripts) | Duggy Tuxy tutorials | ≥ 100.000 IPs |
| [NAS Synology](https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html) | MyOwnServer website | ≥ 100.000 IPs |

## Integration scripts

```
[  Internet / Bad Actors  ]
                 |
                 | (Incoming Packet: src=1.2.3.4)
                 v
      +-------------------------+
      | Network Interface (NIC) |
      +-------------------------+
                 |
                 v
      +=========================+
      |    NFtables (Kernel)    |
      +=========================+
                 |
                 |  <--- Hook: Input
                 v
      +-------------------------+
      | Chain: 'inbound_block'  | <--- (Priority -100 : Very High)
      +-------------------------+
                 |
                 v
      /-------------------------\
      |    Is Source IP in      |
      |       Named SET         |
      |    @blocklist_ipv4 ?    |
      \-------------------------/
           /           \
    (YES / Match)   (NO / No Match)
         |               |
         v               v
    +---------+     +---------+
    |  DROP   |     | ACCEPT  | ---> Continue to next chains...
    +---------+     +---------+      (SSH, Docker, Nginx, etc.)
         X               |
     (Silently)          v
                  [ Application / Server ]
```

> [!TIP]
> Implementing the Data-Shield IPv4 Blocklist with [NFtables](https://en.wikipedia.org/wiki/Nftables):

A secure, atomic, and idempotent manager designed for critical Linux infrastructures. It automatically deploys Nftables rules to block malicious traffic using the Data-Shield list.

### Hardened Security

- Strict TLS 1.2+ verification
- Sandboxed Systemd execution (`ProtectSystem=full`, `NoNewPrivileges`)
- Immutable script protection (`chattr +i`)

### High Performance

- Atomic Nftables Updates: Zero downtime during rule reloading
- Optimized Nftables sets for handling thousands of IPs efficiently

### Idempotence & Safety

- Safe to run multiple times (handles updates automatically)
- Auto-Failover: Switches to mirrors if the primary source is down

## Quick Installation

> [!NOTE]
> Supported OS: Debian 11+, Ubuntu 20.04+, Fedora 41+

> [!CAUTION]
> Scripts must be used beforehand in pre-production or labs to avoid side effects (rules not adapted to the environment, etc.) in production.

```
# 1. Download the installer
wget https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/download/v0.3.04/install_blocklist_manager.sh
chmod +x install_blocklist_manager.sh

# 2. Run with root privileges
sudo ./install_blocklist_manager.sh
```

> [!NOTE]
> Follow the interactive prompts to select your source (Official or Custom).

Once installed, a Systemd timer (`blocklist-update.timer`) runs hourly:

- Audit: Downloads the list and verifies integrity (SHA256)
- Validate: Checks IP format (Strict Regex) and minimum entry count
- Apply: Atomically swaps the Nftables set using a temporary batch file

## Uninstallation

> [!NOTE]
> To cleanly remove the script, services, logs, and firewall rules:

```
sudo ./install_blocklist_manager.sh --uninstall
```

## Automated Testing (Docker)

> [!NOTE]
> To ensure stability and security, this project includes a complete test harness that runs inside a Docker container. This validates installation, idempotence, and uninstallation without modifying your host system.

### 1. Test Environment Setup

Create a `Dockerfile` in the root directory:

```
# Use a Debian image with Systemd support
FROM jlei/systemd-debian:12

# Install dependencies required by the script
RUN apt-get update && apt-get install -y \
    curl \
    nftables \
    e2fsprogs \
    kmod \
    sudo \
    && rm -rf /var/lib/apt/lists/*

# Copy scripts
COPY install_blocklist_manager.sh /root/
COPY run_tests.sh /root/

WORKDIR /root/
RUN chmod +x install_blocklist_manager.sh run_tests.sh

# Default command: Run the test suite
CMD ["./run_tests.sh"]
```

### 2. Running the Tests

You can run the full validation suite using the following commands:

```
# 1. Build the test image
docker build -t blocklist-tester .

# 2. Run the tests (Requires privileged mode for Nftables/Systemd)
docker run --rm --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro blocklist-tester
```

### 3. Expected Output

The test suite performs 4 phases:

- Static Analysis: Syntax checking and linting
- Cold Installation: Verifies file creation, Systemd services, and Nftables tables
- Idempotence: Re-runs installation to ensure safe updates (checking `chattr` handling)
- Uninstallation: Verifies complete cleanup of the system

## GRC Compliance Model

> [!IMPORTANT]
> For compliance purposes, companies wishing to implement the Data-Shield IPv4 Blocklist can refer to the “[ISO27001:2022](https://en.wikipedia.org/wiki/ISO/IEC_27001), [NIS2](https://en.wikipedia.org/wiki/Cyber-security_regulation#NIS_2_Directive), and [GDPR](https://en.wikipedia.org/wiki/General_Data_Protection_Regulation) compliance model” documents, which are available and listed in the table below.

| **Document URL** | **Language** | **Rights** | **ISO27001:2022, NIS2 and GDPR** |
|:---|:---:|:---:|:---:|
| [EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.docx](/docs/EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.docx) | English | R/W | ✅ |
| [EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.pdf](/docs/EN_GRC_Compliance_Model_DataShield_IPv4_Blocklist.pdf) | English | R | ✅ |
| [FR_Modele_GRC_DataShield_IPv4_Blocklist.docx](/docs/FR_Modele_GRC_DataShield_IPv4_Blocklist.docx) | French | R/W | ✅ |
| [FR_Modele_GRC_DataShield_IPv4_Blocklist.pdf](/docs/FR_Modele_GRC_DataShield_IPv4_Blocklist.pdf) | French | R | ✅ |

> [!NOTE]
> These documents may be modified for adaptation purposes to ensure compliance under the best conditions for the implementation of the Data-Shield IPv4 Blocklist.

> [!TIP]
> Simply download them, modify them according to your needs, and insert them into your GRC processes.

## Support Data-Shield IPv4 Blocklist!

> [!NOTE]
> Data-Shield IPv4 Blocklist requires time and funding. That is why it is important to appeal for donations so that it can be maintained over time and in the best possible conditions:

- **Ko-Fi**: ```https://ko-fi.com/laurentmduggytuxy```

## License

> [!IMPORTANT]
> Data-Shield IPv4 Blocklist ```2023-2026``` by Duggy Tuxy (Laurent Minne) is under [license](/LICENSE)
