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
  <img src="https://img.shields.io/badge/Made%20with-%E2%9D%A4-red?style=for-the-badge">
  <img src="https://img.shields.io/badge/No_False_Positive-100%25-green?style=for-the-badge&logo=cachet">
  <img src="https://img.shields.io/badge/License-GNU_GPLv3-0052cc?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=IPv4%20Blocklist%20Last%20Update&color=informational&style=for-the-badge&logo=github">
</p>

<div align="center">
  <br />
  <a href="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist" target="_blank">GitHub</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist" target="_blank">GitLab (Mirror 1)</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/" target="_blank">Gitea (Mirror 2)</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://www.linkedin.com/in/laurent-minne/" target="_blank">Linkedin Profile</a>
  <span>&nbsp;&nbsp;•&nbsp;&nbsp;</span>
  <a href="https://ko-fi.com/laurentmduggytuxy" target="_blank">Ko-Fi Page</a>
  <br />
</div>

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
- **Frequency of updates**: Data-Shield IPv4 Blocklist is updated every ```24``` hours to maintain the most recent data in order to protect you as effectively as possible.
- **Data retention (IPv4 only)**: Data retention is limited to a maximum of ```60``` days. This retention is mainly used to continuously monitor the activities of IPv4 addresses tagged as malicious, which have short lifespans but are likely to resurface.
- **Performance**: Data-Shield IPv4 Blocklist is just as effective as those offered by other solutions and vendors.
- **The GNU GPLv3 Licence**: Data-Shield IPv4 Blocklist is licensed under [GNU GPLv3](/LICENSE).

## Primary objectives

- Reduce noise by up to 50%, save time on incident response, reduce consumption of CPU, RAM, and other server resources.
- Block up to approximately 90% of malicious bot traffic in order to significantly reduce the load on servers in terms of resources.
- Automatic update of blocklists via GitHub, JSdelivr [CDN](https://en.wikipedia.org/wiki/Content_delivery_network), GitLab and Gitea Raw URLs.

## Production lists

> [!IMPORTANT]
> Data-Shield IPv4 Blocklist consists of 5 official lists that are updated every 24 hours.
> To ensure availability and resilience, two mirrors and an open-source CDN are put into production.
> Exhaustive lists of those that are put into production, followed by their uses and limitations:

| **GitHub RAW URL** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [prod_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) | Full | 110.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |
| **GitLab RAW URL (Mirror)** | **Source** | **Limitation** |
| [prod_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_data-shield_ipv4_blocklist.txt?ref_type=heads) | Full | 110.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_aa_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ab_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ac_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://gitlab.com/duggytuxy/Data-Shield-IPv4-Blocklist/-/raw/main/prod_ad_data-shield_ipv4_blocklist.txt?ref_type=heads) | Split D | 30.000 IPs |
| **CDN JSdelivr URL** | **Source** | **Limitation** |
| [prod_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_data-shield_ipv4_blocklist.txt) | Full | 110.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |
| **Gitea RAW URL (Mirror)** | **Source** | **Limitation** |
| [prod_data-shield_ipv4_blocklist.txt](https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_data-shield_ipv4_blocklist.txt) | Full | 110.000 IPs |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30.000 IPs |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30.000 IPs |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30.000 IPs |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://gitea.com/duggytuxy/Data-Shield_IPv4_Blocklist/raw/branch/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30.000 IPs |

## Integration tutorials:

> [!IMPORTANT]
> The main firewall rule around Data-Shield IPv4 Blocklist lists is implemented as follows so that it is operational and effective in terms of blocking:

> [!TIP]
> **From the internet to the internal network (WAN to LAN 👉 Inbound Rules)**

> [!CAUTION]
> **Do not integrate these flow rules in this direction (LAN to WAN 👉 Outbound Rules)**

> [!NOTE]
> To facilitate the integration of Data-Shield IPv4 Blocklist into firewall instances, here is a non-exhaustive list of some tutorials offered by vendors and the Cyber community:

| **Vendors URL** | **Source** | **Limitation** |
|:---|:---:|:---:|
| [Fortinet](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext) | Official guide | To Be Confirmed |
| [Checkpoint](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) | Manufacturer's guide | To Be Confirmed |
| [Palo Alto](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama) | EDL Overview | To Be Confirmed |
| [OPNsense](https://slash-root.fr/opnsense-block-malicious-ips/) | Slash-Root Guide (Julien Louis) | To Be Confirmed |
| [Stormshield](https://www.youtube.com/watch?v=yT2oas7M2UM) | Official video | To Be Confirmed |
| [F5 BIG-IP](https://my.f5.com/manage/s/article/K10978895) | Official guide | To Be Confirmed |
| [NFtables, IPtables](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#integration-scripts) | Duggy Tuxy tutorials | To Be Confirmed |
| [NAS Synology](https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html) | MyOwnServer website | To Be Confirmed |

## Integration scripts

> [!TIP]
> Implementing the Data-Shield IPv4 Blocklist with [NFtables](https://en.wikipedia.org/wiki/Nftables) and [IPtables](https://en.wikipedia.org/wiki/Iptables):

> [!CAUTION]
> Scripts must be used beforehand in pre-production or labs to avoid side effects (rules not adapted to the environment, etc.) in production.

- Coming soon...

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

## Licence

> [!IMPORTANT]
> Data-Shield IPv4 Blocklist ```2023-2025``` by Duggy Tuxy (Laurent Minne) is under [license](/LICENSE)
