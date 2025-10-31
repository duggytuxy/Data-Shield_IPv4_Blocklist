<p align="left">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_dark_white.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_white_dark.png">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_white_dark.png" />
</picture>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/False_Positive-0%25-green?style=for-the-badge&logo=cachet">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github">
</p>

> 🛡Block malicious IP addresses and reduce your attack surface!

# Data-Shield IPv4 Blocklist 

<p align="left">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data-shield_ipv4_blocklist_schema_dark.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data-shield_ipv4_blocklist_schema.png">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data-shield_ipv4_blocklist_technical_schema.png" />
</picture>
</p>

Data-Shield IPv4 Blocklist is an additional layer of protection containing a list of [IP addresses (version 4)](https://en.wikipedia.org/wiki/IPv4) whose activities have been detected as malicious.

This list is designed around the discipline of [Deceptive Security](https://www.orangecyberdefense.com/be/blog/discover-deception-security#:~:text=What%20is%20deception%20security?,potentially%20demotivate%20some%20of%20them.) based on intelligent behavioral analysis of malicious activities related to cybercrime.

Data-Shield IPv4 Blocklist contains the most recent data (IPv4 addresses) to provide an additional layer of security for your [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)), [WAF](https://en.wikipedia.org/wiki/Web_application_firewall), and [DNS sinkhole](https://en.wikipedia.org/wiki/DNS_sinkhole) instances.

## Why Data-Shield IPv4 Blocklist?

- **Protective layer**: Data-Shield IPv4 Blocklist provides an additional layer of security to reduce the number and attack surface of your exposed assets (web applications, websites, DMZs, public IPs, etc.), reducing the recon phase and exposure of your data on platforms such as [Shodan](https://www.shodan.io/) and similar.
- **Open to the general public**: Data-Shield IPv4 Blocklist is open to any user with a firewall, WAF, DNS sinkhole, and other similar protection mechanisms.
- **Single origin**: Data-Shield IPv4 Blocklist comes from a single source, processed by probes located around the world. Logs are centralized on a self-hosted HIDS/SIEM platform, secured via an open-source WAF.
- **Easy integration into your firewall, WAF, DNS Sinkhole instances**: This list can be easily integrated into most vendors as a single link (RAW) for standard recognition of the included data.
- **Customizable based on vendor limitations**: Some vendors have limited the number of IPv4 addresses per entry (per list) to prevent resource consumption overload. Data-Shield IPv4 Blocklist is designed to comply with this limitation by creating split lists.
- **Data reliability (IPv4)**: Data-Shield IPv4 Blocklist provides high-quality, reliable data by minimizing false positives to avoid blocking legitimate exposed instances.
- **Frequency of updates**: Data-Shield IPv4 Blocklist is updated every 24 hours to maintain the most recent data in order to protect you as effectively as possible.
- **Data retention (IPv4 only)**: Data retention is limited to a maximum of 54 days. This retention is mainly used to continuously monitor the activities of IPv4 addresses tagged as malicious, which have short lifespans but are likely to resurface.
- **The CC BY 4.0 Licence**: Data-Shield IPv4 Blocklist is licensed under [CC BY 4.0](/LICENSE) so that you can benefit fully from the list(s) offered in this repository.

## Malicious activities detected (TTPs)

A non-exhaustive list of Malicious activities (CVEs Exploit):

- **CVE-2020-25078**: CVSS 3.1: ```7.5```: An issue was discovered on D-Link DCS-2530L before 1.06.01 Hotfix and DCS-2670L through 2.02 devices. The unauthenticated /config/getuser endpoint allows for remote administrator password disclosure. 
- **CVE-2021-42013**: CVSS 3.1: ```9.8```: It was found that the fix for CVE-2021-41773 in Apache HTTP Server 2.4.50 was insufficient. An attacker could use a path traversal attack to map URLs to files outside the directories configured by Alias-like directives. If files outside of these directories are not protected by the usual default configuration "require all denied", these requests can succeed. If CGI scripts are also enabled for these aliased pathes, this could allow for remote code execution. This issue only affects Apache 2.4.49 and Apache 2.4.50 and not
- **CVE-2021-41773**: CVSS 3.1: ```7.5```: A flaw was found in a change made to path normalization in Apache HTTP Server 2.4.49. An attacker could use a path traversal attack to map URLs to files outside the directories configured by Alias-like directives. If files outside of these directories are not protected by the usual default configuration "require all denied", these requests can succeed. If CGI scripts are also enabled for these aliased pathes, this could allow for remote code execution. This issue is known to be exploited in the wild. This issue only affects Apache
- **CVE-2024-3400** : CVSS 3.1: ```10.```: A command injection as a result of arbitrary file creation vulnerability in the GlobalProtect feature of Palo Alto Networks PAN-OS software for specific PAN-OS versions and distinct feature configurations may enable an unauthenticated attacker to execute arbitrary code with root privileges on the firewall. Cloud NGFW, Panorama appliances, and Prisma Access are not impacted by this vulnerability.
- **CVE-2025-0282** : CVSS 3.1: ```9.0```: A stack-based buffer overflow in Ivanti Connect Secure before version 22.7R2.5, Ivanti Policy Secure before version 22.7R1.2, and Ivanti Neurons for ZTA gateways before version 22.7R2.3 allows a remote unauthenticated attacker to achieve remote code execution
- **CVE-2024-3721** : CVSS 3.1: ```6.3```: A vulnerability was found in TBK DVR-4104 and DVR-4216 up to 20240412 and classified as critical. This issue affects some unknown processing of the file /device.rsp?opt=sys&cmd=___S_O_S_T_R_E_A_MAX___. The manipulation of the argument mdb/mdc leads to os command injection. The attack may be initiated remotely. The exploit has been disclosed to the public and may be used. The identifier VDB-260573 was assigned to this vulnerability.
- **CVE-2022-30023**: CVSS 3.1: ```8.8```: Tenda ONT GPON AC1200 Dual band WiFi HG9 v1.0.1 is vulnerable to Command Injection via the Ping function.
- **CVE-2017-9841** : CVSS 3.1: ```9.8```: Util/PHP/eval-stdin.php in PHPUnit before 4.8.28 and 5.x before 5.6.3 allows remote attackers to execute arbitrary PHP code via HTTP POST data beginning with a "<?php" substring, as demonstrated by an attack on a site with an exposed ```/vendor``` folder, i.e., external access to the ```/vendor/phpunit/phpunit/src/Util/PHP/eval-stdin.php``` URI.
- **CVE-2018-10561**: CVSS 3.1: ```9.8```: An issue was discovered on Dasan GPON home routers. It is possible to bypass authentication simply by appending "?images" to any URL of the device that requires authentication, as demonstrated by the ```/menu.html?images/``` or ```/GponForm/diag_FORM?images/``` URI. One can then manage the device.
- **CVE-2018-20062**: CVSS 3.1: ```9.8```: An issue was discovered in NoneCms V1.3. thinkphp/library/think/App.php allows remote attackers to execute arbitrary PHP code via crafted use of the filter parameter, as demonstrated by the ```s=index/\think\Request/input&filter=phpinfo&data=1``` query string.
- **CVE-2022-44808**: CVSS 3.1: ```9.8```: A command injection vulnerability has been found on D-Link DIR-823G devices with firmware version 1.02B03 that allows an attacker to execute arbitrary operating system commands through well-designed /HNAP1 requests. Before the HNAP API function can process the request, the system function executes an untrusted command that triggers the vulnerability.
- **CVE-2022-41040**: CVSS 3.1: ```8.8```: Microsoft Exchange Server Elevation of Privilege Vulnerability
- **CVE-2022-41082**: CVSS 3.1: ```8.0```: Microsoft Exchange Server Remote Code Execution Vulnerability
- **CVE-2024-4577** : CVSS 3.1: ```9.8```: In PHP versions 8.1. before 8.1.29, 8.2. before 8.2.20, 8.3. before 8.3.8, when using Apache and PHP-CGI on Windows, if the system is set up to use certain code pages, Windows may use "Best-Fit" behavior to replace characters in command line given to Win32 API functions. PHP CGI module may misinterpret those characters as PHP options, which may allow a malicious user to pass options to PHP binary being run, and thus reveal the source code of scripts, run arbitrary PHP code on the server, etc.

A non-exhaustive list of Malicious activities (TTPs):

- **Exploited Host**: Host is likely infected with malware and being used for other attacks or to host malicious content. The host owner may not be aware of the compromise. This category is often used in combination with other attack categories.
- **Brute-Force**: Credential brute-force attacks on webpage logins and services like SSH, FTP, SIP, SMTP, RDP, etc. This category is separate from DDoS attacks. 
- **Port Scans**: Scanning for open ports and vulnerable services. 
- **IoT Targets**: Abuse was targeted at an &quot;Internet of Things&quot; type device. Include information about what type of device was targeted in the comments.
- **SQL Injection**: Attempts at SQL injection.
- **Web App Attack**: Attempts to probe for or exploit installed web applications such as a CMS like WordPress/Drupal, e-commerce solutions, forum software, phpMyAdmin and various other software plugins/solutions.
- **Web Spam**: Comment/forum spam, HTTP referer spam, or other CMS spam.
- **Bad Web Bot**: Webpage scraping (for email addresses, content, etc) and crawlers that do not honor robots.txt. Excessive requests and user agent spoofing can also be reported here, etc.

## Production lists

<p align="left">
<picture>
  <source media="(prefers-color-scheme: dark)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data-shield_ipv4_blocklist_technical_schema_dark.png">
  <source media="(prefers-color-scheme: light)" srcset="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data-shield_ipv4_blocklist_technical_schema.png">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data-shield_ipv4_blocklist_technical_schema.png" />
</picture>
</p>

Data-Shield IPv4 Blocklist consists of 5 official lists that are updated every 24 hours.

Exhaustive lists of those that are put into production, followed by their uses and limitations:

- **prod_data-shield_ipv4_blocklist.txt**: Full list, limited to 110,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt```
- **prod_aa_data-shield_ipv4_blocklist.txt**: Split list ```A```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt```
- **prod_ab_data-shield_ipv4_blocklist.txt**: Split list ```B```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt```
- **prod_ac_data-shield_ipv4_blocklist.txt**: Split list ```C```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt```
- **prod_ad_data-shield_ipv4_blocklist.txt**: Split list ```D```, limited to 30,000 IPv4 addresses: ```https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt```

## Integration tutorials:

The main firewall rule around Data-Shield IPv4 Blocklist lists is implemented as follows so that it is operational and effective in terms of blocking:

- ```From the internet to the internal network (WAN to LAN)```

To facilitate the integration of Data-Shield IPv4 Blocklist into firewall instances, here is a non-exhaustive list of some tutorials offered by vendors and the Cyber community:

- **Fortinet**: Official guide : ```https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext```
- **Checkpoint**: Manufacturer's guide: ```https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm```
- **Palo Alto**: EDL Overview: ```https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama```
- **OPNsense**: Slash-Root Guide (Julien Louis): ```https://slash-root.fr/opnsense-block-malicious-ips/```
- **Stormshield**: Official video: ```https://www.youtube.com/watch?v=yT2oas7M2UM```
- **F5 BIG-IP**: Official guide: ```https://my.f5.com/manage/s/article/K10978895```
- **IPTables**: Lupovis tutorial (X. Bellekens): ```https://www.linkedin.com/posts/activity-7125481101728313345-b8jM```
- **UniFi’s Next-Gen Firewall**: Manufacturer's guide: ```https://help.ui.com/hc/en-us/articles/28314415752727-Application-Filtering-in-UniFi```

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

> 🧠 Security through intelligence, not noise!
