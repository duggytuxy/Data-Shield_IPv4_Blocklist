<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/powered%20by-DuggyTuxy-darkred?style=for-the-badge&logo=apachekafka">
  <img src="https://img.shields.io/badge/Status-Production--Grade-brightgreen?style=for-the-badge&logo=status">
  <img src="https://img.shields.io/badge/Security-Hardened-blue?style=for-the-badge&logo=security">
  <img src="https://img.shields.io/badge/Platform-Debian%20%7C%20Ubuntu%20%7C%20Fedora-orange?style=for-the-badge&logo=platform">
  <img src="https://img.shields.io/badge/License-GNU_GPLv3-0052cc?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=IPv4%20Blocklist%20Last%20Update&color=informational&style=for-the-badge&logo=github">
</p>

## Quick Links  

| Platform | Link |
|---|---|
| **GitHub** | <https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist> |
| **GitLab** | <https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist> |
| **Bitbucket** | <https://bitbucket.org/duggytuxy/data-shield-ipv4-blocklist/src/main/> |
| **Codeberg** | <https://codeberg.org/duggytuxy21/Data-Shield_IPv4_Blocklist> |
| **LinkedIn** | <https://www.linkedin.com/in/laurent-minne/> |
| **TryHackMe** | <https://tryhackme.com/p/duggytuxy> |
| **Ko‑Fi** | <https://ko-fi.com/laurentmduggytuxy> |
| **Issue Tracker** | <https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues> |

## Table of Contents  

1. [Why Data‑Shield IPv4 Blocklist?](#why-data-shield-ipv4-blocklist)  
2. [Primary Objectives](#primary-objectives)  
3. [Production Lists (Mirrors)](#production-lists-mirrors)  
4. [Integration Tutorials](#integration-tutorials)  
5. [Installation & Management Scripts](#installation--management-scripts)  
6. [GRC Compliance Model](#grc-compliance-model)  
7. [Support the Project](#support-the-project)  
8. [License](#license) 

## Why Data‑Shield IPv4 Blocklist?  

- **Additional defensive layer** – blocks known malicious IPv4 sources before they reach your perimeter or web applications.  
- **Open to everyone** – free for any firewall, WAF, or IDS that can consume a plain‑text IP list.  
- **Single, curated source** – probes worldwide feed a central HIDS/SIEM; the list is generated from that unified view.  
- **Easy integration** – each vendor can pull a raw URL; the list is split when necessary to respect vendor limits.  
- **High data quality** – aggressive false‑positive filtering keeps legitimate traffic untouched.  
- **Portable IoC enrichment** – compatible with OpenCTI, MISP, and other CTI platforms.  
- **Frequent updates** – refreshed every **6 hours** to keep pace with fast‑moving threats.  
- **Limited retention** – entries expire after **15 days**, ensuring the list stays current.  
- **Performance‑tested** – comparable to commercial feeds while remaining 100 % open source. 

## Primary Objectives  

| Goal | Metric |
|---|---|
| **Latest malicious IP data** | Updated every 6 h |
| **Noise reduction** | ≤ 50 % false‑positive traffic |
| **Resource savings** | Lower CPU/RAM consumption on firewalls |
| **Malicious traffic blocked** | ≈ 95 % of known bot traffic |
| **Broad vendor compatibility** | OPNsense, Fortinet, Palo Alto, NFtables, pfSense, BunkerWeb |