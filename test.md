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
8. [Support the Project](#support-the-project)  
9. [License](#license) 

# Data‑Shield IPv4 Blocklist Community

**The Data-Shield IPv4 Blocklist Community** provides an official, curated registry of IPv4 addresses identified as malicious. Updated continuously, this resource offers vital threat intelligence to bolster your **Firewall** and **WAF** instances, delivering a robust, additional layer of security for your infrastructure.

## Key Features & Benefits

- **Proactive Defense & Reduced Attack Surface** The Data-Shield IPv4 Blocklist Community serves as an essential protective layer for your exposed assets (Web Apps, WordPress, APIs). By blocking malicious traffic early, it significantly reduces the reconnaissance phase and lowers visibility on scanners like **Shodan**.

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

