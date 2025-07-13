<p align="center">


  ![Open Source](https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative)
  ![Made with ❤️](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red?style=for-the-badge)
  ![Last update](https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github)
  </p>

# About this project 🧪

This project (blocking list) aims to reduce the number of attacks by inserting IP addresses known to be abusive, aggressive and malicious (confidence of abuse 100%).

This blocklist is made up of reliable, high-quality data from decoys placed geolocally in public and private infrastructures such as:

| **Belgium**
| **Germany**
| **Austria**
| **Netherlands**
| **France**
| **Spain**
| **Portugal**
| **Italy**
| **Greece**
| **Switzerland**
| **Lithuania**

**What's special about these decoys is that they contain several configurations, depending on the IS mapping and the specific needs of the customer or the data I want to collect, so I can correlate them with other CTI platforms**

| To give you a few figures, I collect (on average) over 1970 IP addresses alone, and after analysis and feedback, once they're really reliable, I add them to this blocking list, which is closely monitored 24/7.
| For the deletion part, the policy in force is that I keep these IP addresses for 30 days: if no activity has been reported within this period, these IP addresses are removed from the blocking list to be inserted in a “Whitelist” also monitored.

# A few highlights 🧱

- [**Intelligence IPv4 Blocklist**](https://raw.githubusercontent.com/duggytuxy/Intelligence_IPv4_Blocklist/refs/heads/main/agressive_ips_dst_fr_be_blocklist.txt) : target destination 👉 Europa

| **Some IP addresses have a relatively short lifespan (such as APTs, groups that deploy infostealers and malware, etc.)**.
| 👇Here are some of the vectors and types of attack these IP addresses can inflict at any given time👇.

# CVEs 🔩

| **CVE**🐞 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **CVE-2020-25078** | An issue was discovered on D-Link DCS-2530L... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2020-25078) |
| **CVE-2021-42013** | It was found that the fix for CVE-2021-41773... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2021-42013) |
| **CVE-2021-41773** | A flaw was found in a change made to path... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2021-41773) |
| **CVE-2024-3400** | PAN-OS : A command injection as a result... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2024-3400) |
| **CVE-2017-16894** | In Laravel framework through 5.5.21... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2017-16894) |
| **CVE-2024-3721** | A vulnerability was found in TBK DVR-4104 and DVR-4216... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2024-3721) |
| **CVE-2022-30023** | Tenda ONT GPON AC1200 Dual band WiFi HG9 v1.0.1... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2022-30023) |
| **CVE-2017-9841** | Util/PHP/eval-stdin.php in PHPUnit before 4.8.28... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2017-9841) |
| **CVE-2018-10561** | An issue was discovered on Dasan GPON home routers... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2018-10561) |
| **CVE-2018-20062** | An issue was discovered in NoneCms V1.3... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2018-20062) |
| **CVE-2022-44808** | Vulnerability has been found on D-Link DIR-823G devices... | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2022-44808) |
| **CVE-2022-41040** | Microsoft Exchange Server Elevation of PV** | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2022-41040) |
| **CVE-2022-41082**| Microsoft Exchange Server RCE Vulnerability** | [**NIST Website**](https://nvd.nist.gov/vuln/detail/CVE-2022-41082) |

Etc.

# TTPs 🐞

| **TTPs**🥷 | **Avg IP addr per day**🛜 | **A few countries of origin**🌍 |
|---|---|---|
| [**Apache Attack**](https://attack.mitre.org/techniques/T1190/) | 1540 | **Belgium, UK, Poland, Russia** |
| [**Nginx Attack**](https://attack.mitre.org/techniques/T1102/) | 2490 | **Brazil, USA, France, China** |
| [**Ransomware Attack**](https://attack.mitre.org/techniques/T1486/) | 7 | **Brazil, Lithuania, Russia** |
| [**VPN Attack**](https://attack.mitre.org/techniques/T1133/) | 1670 | **Belgium, UK, Poland, Russia** |
| [**RDP Attack**](https://attack.mitre.org/techniques/T1021/001/) | 3410 | **USA, Brazil, Peru, Morocco** |
| [**NTLM Attack**](https://attack.mitre.org/techniques/T1187/) | 940 | **China, UK, Poland, Belgium** |
| [**Kerberos Attack**](https://attack.mitre.org/techniques/T1558/003/) | 730 | **Venezuela, Brazil, Poland, Algeria** |
| [**Wordpress Enumeration**](https://attack.mitre.org/techniques/T1087/) | 4180 | **USA, China, Russia, UK** |
| [**Botnet Recruitment**](https://attack.mitre.org/techniques/T1583/005/) | NC | **USA, China, Brazil, Chile** |
| [**Brute-force Attack**](https://attack.mitre.org/techniques/T1110/) | 7980 | **USA, China, UK, France** |
| [**Brute-Force SSH Login**](https://attack.mitre.org/techniques/T1110/) | 6710 | **USA, China, Poland, Netherlands** |
| [**Directory Busting**](https://attack.mitre.org/techniques/T1083/) | 3610 | **USA, China, Italy, India** |
| [**Credentials Dumping**](https://attack.mitre.org/techniques/T1003/) | 390 | **India, Japan, UK, Netherlands** |
| [**Email Attack**](https://attack.mitre.org/techniques/T1114/) | 1100 | **USA, China, India, Spain** |
| [**SMB Attack**](https://attack.mitre.org/techniques/T1021/002/) | 4190 | **USA, China, Poland, France** |
| [**FTP Attack**](https://attack.mitre.org/techniques/T1105/) | 560 | **UK, France, Poland, Vietnam** |
| [**IMAP Attack**](https://attack.mitre.org/techniques/T1071/003/) | 980 | **USA, China, Poland, France** |
| [**Information Gathering**](https://attack.mitre.org/techniques/T1591/) | NC | **USA, China, India, Lithuania** |
| [**Remote Code Execution**](https://attack.mitre.org/techniques/T1210/) | 650 | **USA, India, Pakistan, Iran** |
| [**Scanning**](https://attack.mitre.org/techniques/T1595/) | 10540 | **USA, China, India, Indonesia** |
| [**SSH Attack**](https://attack.mitre.org/techniques/T1021/004/) | 6710 | **USA, China, India, France** |
| [**Tor Exit Node**](https://attack.mitre.org/software/S0183/) | 200 | **Switzerland, France, Germany** |
| [**Tor Node**](https://attack.mitre.org/software/S0183/) | 220 | **Switzerland, France, Germany** |
| [**VOIP Attack**](https://attack.mitre.org/techniques/T1616/) | 70 | **Belgium, India, Vietnam, Indonesia** |
| [**Web Traversal**](https://capec.mitre.org/data/definitions/139.html) | 2100 | **USA, China, Lithuania, France** |

Etc.

PS: this list will be updated every 4/24h

# Tips 💡

✋You can easily integrate this list into your FWs under the Inbound/Outbound policy rules, Threat feeds.

To add my blocklist to the Fortinet, CheckPoint, Palo Alto and OPNsense FWs, here are some interesting links

| **Vendor**🧱 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **Fortinet** | External blocklist policy | [**Fortinet Website**](https://docs.fortinet.com/document/fortigate/7.2.0/administration-guide/891236) |
| **Checkpoint** | IP Block Feature | [**Checkpoint Website**](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) |
| **Palo Alto** | Configure the Firewall to Access an External Dynamic List | [**Palo Alto Website**](https://docs.paloaltonetworks.com/pan-os/10-2/pan-os-admin/policy/use-an-external-dynamic-list-in-policy/configure-the-firewall-to-access-an-external-dynamic-list) |
| **OPNsense** | OPNsense : Block malicious IPs | [**Slash-Root Website**](https://slash-root.fr/opnsense-block-malicious-ips/) |

# A few figures 🎖️

According to feedback, more than 127 small and medium-sized companies (Acensi as well) have already implemented this list in their FW Fortinet, Palo Alto, Checkpoint, etc.

# Support my work with a donation 🙏

| **Site**📍 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **Ko-Fi** | Join all types of creators getting donations, memberships, etc. from their fans! | [**Thank you !!!**](https://ko-fi.com/laurentmduggytuxy) |
| **Liberapay** | Liberapay is a recurring donation platform. | [**Thank you !!!**](https://liberapay.com/Duggy_Tuxy) |

Intelligence IPv4 Blocklist © 2023 by Duggy Tuxy is licensed under Creative Commons Attribution-NonCommercial 4.0 International. To view a copy of this license, visit [**the official website**](https://creativecommons.org/licenses/by-nc/4.0/)
