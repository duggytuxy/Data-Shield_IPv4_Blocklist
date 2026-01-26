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

1. [Presentation](#presentation)
2. [Why Data‑Shield IPv4 Blocklist?](#why-datashield-ipv4-blocklist)  
3. [Primary Objectives](#primary-objectives)  
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

