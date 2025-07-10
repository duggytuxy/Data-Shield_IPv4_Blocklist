# Intelligence IPv4 Blocklist 🧱

Intelligence Blocklist (IPv4): Botnets, RaT, CVE's RCE, Scanners. DST = FR![fr](https://github.com/user-attachments/assets/32761f6d-9980-4dbc-bc90-3a1076ea3891) - BE![be](https://github.com/user-attachments/assets/b1ecb2d5-4358-4c80-8469-d84a4ff0ded8)

✋You can easily integrate this list into your FWs under the Inbound/Outbound policy rules, Threat feeds.

# About this project 🧪

I started this project in June 2023 when I discovered, through logs on specific instances, a number of triggers coming from IPv4 addresses with strong signals whose behaviors appeared to be aggressive scan ports, RCE attempts linked to highly exploited CVEs.

I started retrieving them, analyzing them and then storing them in a txt list (I didn't mess around apparently🤣).

And since then, this list has evolved to include data from 16 probes (decoy) deployed in strategic areas of the French and Belgian network.

**I work hard to ensure that you have high-quality data (IPv4) (the most aggressive, malicious and most up-to-date).**

# A few figures 🎖️

According to feedback, more than 115 small and medium-sized companies (Acensi as well) have already implemented this list in their FW Fortinet, Palo Alto, Checkpoint, etc.

# Single list 📄

✅agressive_ips_dst_fr_be_blocklist.txt

# TTPs 🐞

- Apache Attack
- Nginx Attack
- Ransomware Attack
- VPN Attack
- RDP Attack
- NTLM Attack
- Kerberos Attack
- Wordpress Enumeration
- Botnet Recruitment
- Brute-force Attack
- Brute-Force SSH Login
- Directory Busting
- Credentials Dumping
- Email Attack
- SMB Attack
- FTP Attack
- IMAP Attack
- Information Gathering
- Remote Code Execution
- Scanning
- SSH Attack
- Tor Exit Node
- Tor Node
- VOIP Attack
- Web Traversal

Etc.

# CVEs 🔩

| **CVE**🐞 | **Description**📜 | **Link**🌍 |
|---|---|---|

| **CVE-2020-25078** | **An issue was discovered on D-Link DCS-2530L before 1.06.01 Hotfix and DCS-2670L through 2.02 devices**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2020-25078">🔗</a></div> |
| **CVE-2021-42013** | **It was found that the fix for CVE-2021-41773 in Apache HTTP Server 2.4.50 was insufficient** | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2021-42013">🔗</a></div> |
| **CVE-2021-41773** | **A flaw was found in a change made to path normalization in Apache HTTP Server 2.4.49**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2021-41773">🔗</a></div> |
| **CVE-2024-3400** | **A command injection as a result of arbitrary file creation vulnerability in the GP feature PAN-OS software**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2024-3400">🔗</a></div> |
| **CVE-2017-16894** | **In Laravel framework through 5.5.21, remote attackers can obtain sensitive information...**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2017-16894">🔗</a></div> |
| **CVE-2024-3721** | **A vulnerability was found in TBK DVR-4104 and DVR-4216 up to 20240412...**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2024-3721">🔗</a></div> |
| **CVE-2022-30023** | **Tenda ONT GPON AC1200 Dual band WiFi HG9 v1.0.1 is vulnerable to Command Injection via the Ping function**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-30023">🔗</a></div> |
| **CVE-2017-9841** | **Util/PHP/eval-stdin.php in PHPUnit before 4.8.28 and 5.x before 5.6.3 allows remote attackers...**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2017-9841">🔗</a></div> |
| **CVE-2018-10561** | **An issue was discovered on Dasan GPON home routers...**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2018-10561">🔗</a></div> |
| **CVE-2018-20062** | **An issue was discovered in NoneCms V1.3. thinkphp/library/think/App.php allows remote attackers...**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20062">🔗</a></div> |
| **CVE-2022-44808** | **A command injection vulnerability has been found on D-Link DIR-823G devices with firmware version 1.02B03...**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-44808">🔗</a></div> |
| **CVE-2022-41040** | **Microsoft Exchange Server Elevation of Privilege Vulnerability**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-41040">🔗</a></div> |
| **CVE-2022-41082**| **Microsoft Exchange Server Remote Code Execution Vulnerability**  | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-41082">🔗</a></div> |

Etc.

PS: this list will be updated every 24/48h

# Tips 💡

To add my blocklist to the Fortinet, CheckPoint, Palo Alto and OPNsense FWs, here are some interesting links

| **Vendor**🧱 | **Link**🌍 |
|---|---|
| **Fortinet** | <div align="center"><a href="https://docs.fortinet.com/document/fortigate/7.2.0/administration-guide/891236">🔗</a></div> |
| **Checkpoint** | <div align="center"><a href="https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm">🔗</a></div> |
| **Palo Alto** | <div align="center"><a href="https://docs.paloaltonetworks.com/pan-os/10-2/pan-os-admin/policy/use-an-external-dynamic-list-in-policy/configure-the-firewall-to-access-an-external-dynamic-list">🔗</a></div> |
| **OPNsense** | <div align="center"><a href="https://slash-root.fr/opnsense-block-malicious-ips/">🔗</a></div> |

# Support my work with a donation 🙏

| **Site**📍 | **Link**🌍 |
|---|---|
| **Ko-Fi** | <div align="center"><a href="https://ko-fi.com/laurentmduggytuxy">🔗</a></div> |
| **Liberapay** | <div align="center"><a href="https://liberapay.com/Duggy_Tuxy">🔗</a></div> |

Intelligence IPv4 Blocklist © 2023 by Duggy Tuxy is licensed under Creative Commons Attribution-NonCommercial 4.0 International. To view a copy of this license, visit https://creativecommons.org/licenses/by-nc/4.0/
