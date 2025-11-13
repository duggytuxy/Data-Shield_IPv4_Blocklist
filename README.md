<p align="left">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_dark_white.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_white_dark.png">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_white_dark.png" />
</picture>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/Made%20with-%E2%9D%A4-red?style=for-the-badge">
  <img src="https://img.shields.io/badge/False_Positive-0%25-green?style=for-the-badge&logo=cachet">
  <img src="https://img.shields.io/badge/License-CC_BY_4.0-red?style=for-the-badge&logo=license">
  <img src="https://img.shields.io/github/forks/duggytuxy/Data-Shield_IPv4_Blocklist?style=for-the-badge&logo=github">
  <img src="https://img.shields.io/github/stars/duggytuxy/Data-Shield_IPv4_Blocklist?style=for-the-badge&logo=github">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Data-Shield_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github">
</p>

> 🛡Block malicious IP addresses and reduce your attack surface!

# Data-Shield IPv4 Blocklist 

Data-Shield IPv4 Blocklist is an additional layer of protection containing a list of [IP addresses (version 4)](https://en.wikipedia.org/wiki/IPv4) whose activities have been detected as malicious.

This list is designed around the discipline of [Deceptive Security](https://www.orangecyberdefense.com/be/blog/discover-deception-security#:~:text=What%20is%20deception%20security?,potentially%20demotivate%20some%20of%20them.) based on intelligent behavioral analysis of malicious activities related to cybercrime.

Data-Shield IPv4 Blocklist contains the most recent data (IPv4 addresses) to provide an additional layer of security for your [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)), [WAF](https://en.wikipedia.org/wiki/Web_application_firewall), and [DNS sinkhole](https://en.wikipedia.org/wiki/DNS_sinkhole) instances.

## Why Data-Shield IPv4 Blocklist?

- **Protective layer**: [Data-Shield IPv4 Blocklist](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist) provides an additional layer of security to reduce the number and attack surface of your exposed assets (web applications, websites, DMZs, public IPs, etc.), reducing the recon phase and exposure of your data on platforms such as [Shodan](https://www.shodan.io/) and similar.
- **Open to the general public**: Data-Shield IPv4 Blocklist is open to any user with a firewall, WAF, DNS sinkhole, and other similar protection mechanisms.
- **Single origin**: Data-Shield IPv4 Blocklist comes from a single source, processed by probes located around the world. Logs are centralized on a self-hosted [HIDS](https://en.wikipedia.org/wiki/Host-based_intrusion_detection_system)/[SIEM](https://fr.wikipedia.org/wiki/Security_information_and_event_management) platform, secured via an open-source WAF.
- **Easy integration into your firewall, WAF, DNS Sinkhole instances**: This list can be easily integrated into most vendors as a single link (RAW) for standard recognition of the included data.
- **Customizable based on vendor limitations**: Some vendors have limited the number of IPv4 addresses per entry (per list) to prevent resource consumption overload. Data-Shield IPv4 Blocklist is designed to comply with this limitation by creating split lists.
- **Data reliability (IPv4)**: Data-Shield IPv4 Blocklist provides high-quality, reliable data by minimizing false positives to avoid blocking legitimate exposed instances.
- **Frequency of updates**: Data-Shield IPv4 Blocklist is updated every 24 hours to maintain the most recent data in order to protect you as effectively as possible.
- **Data retention (IPv4 only)**: Data retention is limited to a maximum of 54 days. This retention is mainly used to continuously monitor the activities of IPv4 addresses tagged as malicious, which have short lifespans but are likely to resurface.
- **The CC BY 4.0 Licence**: Data-Shield IPv4 Blocklist is licensed under [CC BY 4.0](/LICENSE) so that you can benefit fully from the list(s) offered in this repository.

## Production lists

> [!NOTE]
> Data-Shield IPv4 Blocklist consists of 5 official lists that are updated every 24 hours.

> [!IMPORTANT]
> Exhaustive lists of those that are put into production, followed by their uses and limitations:

- **prod_data-shield_ipv4_blocklist.txt**: Full list, limited to 110,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt```
- **prod_aa_data-shield_ipv4_blocklist.txt**: Split list ```A```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt```
- **prod_ab_data-shield_ipv4_blocklist.txt**: Split list ```B```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt```
- **prod_ac_data-shield_ipv4_blocklist.txt**: Split list ```C```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt```
- **prod_ad_data-shield_ipv4_blocklist.txt**: Split list ```D```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt```

## Integration tutorials:

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
- **IPtables**: Duggy Tuxy tutorial: See the tutorial link [Implementing the Data-Shield IPv4 Blocklist with IPtables](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#integration-scripts)
- **UniFi’s Next-Gen Firewall**: Manufacturer's guide: ```https://help.ui.com/hc/en-us/articles/28314415752727-Application-Filtering-in-UniFi```
- **NAS Synology**: MyOwnServer's website : ```https://myownserver.org/posts/Automatiser_la_liste_de_blocage.html```

## Integration scripts

> [!TIP]
> Implementing the Data-Shield IPv4 Blocklist with IPtables:

- Create a directory to store the blocklist and scripts

```
mkdir /etc/iptables_blocklist
cd /etc/iptables_blocklist
```

- Create a script named ```update_blocklist.sh```:

```
#!/bin/bash

set -euo pipefail

BLOCKLIST_URL="https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt"
PREVIOUS_BLOCKLIST="/etc/iptables_blocklist/previous_blocklist.txt"
CURRENT_BLOCKLIST="/etc/iptables_blocklist/current_blocklist.txt"
IPTABLES="/sbin/iptables"
IPSET="/sbin/ipset"
BLOCKLIST_SET_NAME="myblocklist"
# Download the current blocklist
curl -s $BLOCKLIST_URL -o $CURRENT_BLOCKLIST
# Create the ipset set if it does not exist
$IPSET list -n | grep -q $BLOCKLIST_SET_NAME || $IPSET create $BLOCKLIST_SET_NAME hash:ip
# Add new IPs to the blocklist
comm -23 <(sort $PREVIOUS_BLOCKLIST | sort | uniq) <(sort $CURRENT_BLOCKLIST | sort | uniq) | while read -r IP; do
  $IPSET add $BLOCKLIST_SET_NAME $IP
done
# Remove outdated IPs from the blocklist
comm -13 <(sort $PREVIOUS_BLOCKLIST | sort | uniq) <(sort $CURRENT_BLOCKLIST | sort | uniq) | while read -r IP; do
  $IPSET del $BLOCKLIST_SET_NAME $IP
done
# Ensure the IPtables rule is in place
$IPTABLES -C INPUT -m set --match-set $BLOCKLIST_SET_NAME src -j DROP 2>/dev/null || $IPTABLES -I INPUT -m set --match-set $BLOCKLIST_SET_NAME src -j DROP
# Save the current blocklist as the previous one for the next run
cp $CURRENT_BLOCKLIST $PREVIOUS_BLOCKLIST
```

- Make the script executable:

```
chmod +x /etc/iptables_blocklist/update_blocklist.sh
```

- To keep your blocklist updated, create a cron job to run the script regularly:

```
crontab -e
```

- Add the following line to execute the script every hour:

```
0 * * * * /etc/iptables_blocklist/update_blocklist.sh
```

- Save and exit the editor.

## Star History

<a href="https://www.star-history.com/#duggytuxy/Data-Shield_IPv4_Blocklist&type=date&legend=top-left">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=duggytuxy/Data-Shield_IPv4_Blocklist&type=date&theme=dark&legend=top-left" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=duggytuxy/Data-Shield_IPv4_Blocklist&type=date&legend=top-left" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=duggytuxy/Data-Shield_IPv4_Blocklist&type=date&legend=top-left" />
 </picture>
</a>

## Support Data-Shield IPv4 Blocklist!

Data-Shield IPv4 Blocklist requires time and funding. That is why it is important to appeal for donations so that it can be maintained over time and in the best possible conditions:

- **Ko-Fi**: ```https://ko-fi.com/laurentmduggytuxy```
- **Duggy Tuxy Store**: ```https://duggy-tuxy.myspreadshop.be```

## Licence

Data-Shield IPv4 Blocklist ```2023-2025``` by Duggy Tuxy (Laurent Minne) is under [license](/LICENSE)

> 🧠Security through intelligence, not noise!
