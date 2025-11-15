<p align="left">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/images/data_shield_logo_official_dark_white.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/images/data_shield_logo_official_white_dark.png">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/images/data_shield_logo_official_white_dark.png" />
</picture>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/Made%20with-%E2%9D%A4-red?style=for-the-badge">
  <img src="https://img.shields.io/badge/False_Positive-0%25-green?style=for-the-badge&logo=cachet">
  <img src="https://img.shields.io/badge/License-GNU_GPLv3-blue?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/forks/duggytuxy/Data-Shield_IPv4_Blocklist?style=for-the-badge&logo=github">
  <img src="https://img.shields.io/github/stars/duggytuxy/Data-Shield_IPv4_Blocklist?style=for-the-badge&logo=github">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github">
</p>

> 🛡Block malicious IP addresses and reduce your attack surface!

# 🧱Data-Shield IPv4 Blocklist 

Data-Shield IPv4 Blocklist is an additional layer of protection containing a list of [IP addresses (version 4)](https://en.wikipedia.org/wiki/IPv4) whose activities have been detected as malicious.

This list is designed around the discipline of [Deceptive Security](https://en.wikipedia.org/wiki/Deception_technology) based on intelligent behavioral analysis of malicious activities related to cybercrime.

Data-Shield IPv4 Blocklist contains the most recent data (IPv4 addresses) to provide an additional layer of security for your [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)), [WAF](https://en.wikipedia.org/wiki/Web_application_firewall), and [DNS sinkhole](https://en.wikipedia.org/wiki/DNS_sinkhole) instances.

## 🎯Why Data-Shield IPv4 Blocklist?

- **Protective layer**: [Data-Shield IPv4 Blocklist](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist) provides an additional layer of security to reduce the number and attack surface of your exposed assets (web applications, websites, DMZs, public IPs, etc.), reducing the recon phase and exposure of your data on platforms such as [Shodan](https://www.shodan.io/) and similar.
- **Open to the general public**: Data-Shield IPv4 Blocklist is open to any user with a firewall, WAF, DNS sinkhole, and other similar protection mechanisms.
- **Single origin**: Data-Shield IPv4 Blocklist comes from a single source, processed by probes located around the world. Logs are centralized on a self-hosted [HIDS](https://en.wikipedia.org/wiki/Host-based_intrusion_detection_system)/[SIEM](https://fr.wikipedia.org/wiki/Security_information_and_event_management) platform, secured via an open-source WAF.
- **Easy integration into your firewall, WAF, DNS Sinkhole instances**: This list can be easily integrated into most vendors as a single link (RAW) for standard recognition of the included data.
- **Customizable based on vendor limitations**: Some vendors have limited the number of IPv4 addresses per entry (per list) to prevent resource consumption overload. Data-Shield IPv4 Blocklist is designed to comply with this limitation by creating split lists.

> [!IMPORTANT]
> - **Data reliability (IPv4)**: Data-Shield IPv4 Blocklist provides high-quality, reliable data by minimizing false positives to avoid blocking legitimate exposed instances.
> - **Frequency of updates**: Data-Shield IPv4 Blocklist is updated every ```24``` hours to maintain the most recent data in order to protect you as effectively as possible.
> - **Data retention (IPv4 only)**: Data retention is limited to a maximum of ```15``` days. This retention is mainly used to continuously monitor the activities of IPv4 addresses tagged as malicious, which have short lifespans but are likely to resurface.
> - **Performance**: Data-Shield IPv4 Blocklist is just as effective as those offered by other solutions and vendors.
> - **The GNU GPLv3 Licence**: Data-Shield IPv4 Blocklist is licensed under [GNU GPLv3](/LICENSE).

## 🚀Objectives

- Reduce noise by up to 50%, save time on incident response, reduce consumption of CPU, RAM, and other server resources.
- Block up to approximately 90% of malicious bot traffic in order to significantly reduce the load on servers in terms of resources.
- Automatic update of blocklists via GitHub Raw URLs (GitLab coming soon...) and [bash scripts](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/tag/Linux).

## 📋Production lists

> [!NOTE]
> Data-Shield IPv4 Blocklist consists of 5 official lists that are updated every 24 hours.

> [!IMPORTANT]
> Exhaustive lists of those that are put into production, followed by their uses and limitations:

> [!TIP]
> Use the official URLs of the GitHub repository

- **prod_data-shield_ipv4_blocklist.txt**: Full list, limited to 110,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt```
- **prod_aa_data-shield_ipv4_blocklist.txt**: Split list ```A```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt```
- **prod_ab_data-shield_ipv4_blocklist.txt**: Split list ```B```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt```
- **prod_ac_data-shield_ipv4_blocklist.txt**: Split list ```C```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt```
- **prod_ad_data-shield_ipv4_blocklist.txt**: Split list ```D```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt```

Or

> [!TIP]
> Use URLs from the JSdelivr CDN

- **prod_data-shield_ipv4_blocklist.txt**: Full list, limited to 110,000 IPv4 addresses: ```https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@latest/prod_data-shield_ipv4_blocklist.txt```
- **prod_aa_data-shield_ipv4_blocklist.txt**: Split list ```A```, limited to 30,000 IPv4 addresses: ```https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@latest/prod_aa_data-shield_ipv4_blocklist.txt```
- **prod_ab_data-shield_ipv4_blocklist.txt**: Split list ```B```, limited to 30,000 IPv4 addresses: ```https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@latest/prod_ab_data-shield_ipv4_blocklist.txt```
- **prod_ac_data-shield_ipv4_blocklist.txt**: Split list ```C```, limited to 30,000 IPv4 addresses: ```https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@latest/prod_ac_data-shield_ipv4_blocklist.txt```
- **prod_ad_data-shield_ipv4_blocklist.txt**: Split list ```D```, limited to 30,000 IPv4 addresses: ```https://cdn.jsdelivr.net/gh/duggytuxy/Data-Shield_IPv4_Blocklist@latest/prod_ad_data-shield_ipv4_blocklist.txt```

## 🎓Integration tutorials:

> [!IMPORTANT]
> The main firewall rule around Data-Shield IPv4 Blocklist lists is implemented as follows so that it is operational and effective in terms of blocking:

> [!TIP]
> From the internet to the internal network (WAN to LAN)

> [!CAUTION]
> Do not integrate these flow rules in this direction (LAN to WAN)

> [!NOTE]
> To facilitate the integration of Data-Shield IPv4 Blocklist into firewall instances, here is a non-exhaustive list of some tutorials offered by vendors and the Cyber community:


- **Fortinet**: Official guide : ```https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext```
- **Checkpoint**: Manufacturer's guide: ```https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm```
- **Palo Alto**: EDL Overview: ```https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama```
- **OPNsense**: Slash-Root Guide (Julien Louis): ```https://slash-root.fr/opnsense-block-malicious-ips/```
- **Stormshield**: Official video: ```https://www.youtube.com/watch?v=yT2oas7M2UM```
- **F5 BIG-IP**: Official guide: ```https://my.f5.com/manage/s/article/K10978895```
- **NFtables**: Duggy Tuxy tutorial: See the tutorial [link](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#integration-scripts)
- **NAS Synology**: MyOwnServer's website : ```https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html```

## ⚙Integration scripts

> [!TIP]
> Implementing the Data-Shield IPv4 Blocklist with [NFtables](https://en.wikipedia.org/wiki/Nftables) or [IPtables](https://en.wikipedia.org/wiki/Iptables):

- Create a directory to store the blocklist and scripts

```
mkdir /etc/nftables_blocklist
cd /etc/nftables_blocklist
```

Or

```
mkdir /etc/iptables_blocklist
cd /etc/iptables_blocklist
```

- Download the script using the following command:

```
wget https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/download/Linux/update_nftables_blocklist.sh
```

Or

```
wget https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/releases/download/Linux/update_iptables_blocklist.sh
```

- Make the script executable:

```
chmod +x /etc/nftables_blocklist/update_nftables_blocklist.sh
```

Or

```
chmod +x /etc/iptables_blocklist/update_iptables_blocklist.sh
```

- To keep your blocklist updated, create a cron job to run the script regularly:

```
crontab -e
```

- Add the following line to execute the script every hour:

```
0 * * * * /etc/nftables_blocklist/update_nftables_blocklist.sh
```

Or

```
0 * * * * /etc/iptables_blocklist/update_iptables_blocklist.sh
```

- Save and exit the editor.

## 💖Support Data-Shield IPv4 Blocklist!

> [!NOTE]
> Data-Shield IPv4 Blocklist requires time and funding. That is why it is important to appeal for donations so that it can be maintained over time and in the best possible conditions:

- **Ko-Fi**: ```https://ko-fi.com/laurentmduggytuxy```
- **Duggy Tuxy Store**: ```https://duggy-tuxy.myspreadshop.be```

## ⚖Licence

> [!IMPORTANT]
> Data-Shield IPv4 Blocklist ```2023-2025``` by Duggy Tuxy (Laurent Minne) is under [license](/LICENSE)
