<p align="center">


  ![Open Source](https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative)
  ![Made with ❤️](https://img.shields.io/badge/Made%20with-%E2%9D%A4-red?style=for-the-badge)
  ![Last update](https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github)
  </p>

# About this project 🧪

This project (blocking list) aims to reduce the number of attacks by inserting IP addresses known to be abusive, aggressive and malicious (confidence of abuse 100%).

**This blocklist is made up of reliable, high-quality data from decoys placed geolocally in public and private infrastructures such as :**

| **Country**🌍 | **OS**🖥️ | **Technologies**🎛️ | Online🛜 |
|---|---|---|---|
| **Belgium** | GNU/Linux | SMB, Apache, Wordpress, VPN-SSL | **On** |
| **Germany** | GNU/Linux | VPN-SSL, Nginx, Squid, SMB | **On** |
| **Austria** | WinSrv 2022 | Apache, IIS, SMB, DC | **On** |
| **Netherlands** | WinSrv 2022 | Apache, SMB, DC | **On** |
| **France** | GNU/Linux | VPN-SSL, SMB, CVEs, Wordpress | **On** |
| **Spain** | WinSrv 2025 | IIS, Apache, SMB, DC | **On** |
| **Portugal** | GNU/Linux | DNS, Squid, Wireguard | **On** |
| **Italy** | GNU/Linux | Apache, Nginx, Wordpress, Webmin | **On** |
| **Greece** | GNU/Linux | VPN-SSL, CVEs | **On** |
| **Lithuania** | GNU/Linux | CVEs, SMB, Squid, OpenVPN | **On** |

<p align="center">


  ![Europa map](/images/europa.png)
  </p>

**What's special about these decoys is that they contain several configurations, depending on the IS mapping and the specific needs of the customer or the data I want to collect, so I can correlate them with other CTI platforms**

> - To give you a few figures, I collect (on average) over 7195 IP addresses unique per day, and after analysis and feedback, once they're really reliable, I add them to this blocking list, which is closely monitored 24/7.
> - For the deletion part, the policy in force is that I keep these IP addresses for 30 days: if no activity has been reported within this period, these IP addresses are removed from the blocking list to be inserted in a “Whitelist” also monitored.

**PS: I want to make it clear that this block list is an additional layer of protection to :**

> - **Reduce the number of attacks**
> - **Reduce the possibility of mapping your exposed assets (public IPs)**
> - **Slightly reduce the attack surface (e.g. Recon)**

🫸***But under no circumstances will it replace all the best practices in your security posture.***

# A few highlights 🧱

- [**Intelligence IPv4 Blocklist**](https://raw.githubusercontent.com/duggytuxy/Intelligence_IPv4_Blocklist/refs/heads/main/agressive_ips_dst_fr_be_blocklist.txt) : target destination 👉 Europa

> - **Some IP addresses have a relatively short lifespan (such as APTs, groups that deploy infostealers and malware, etc.)**.
> - 👇Here are some of the vectors and types of attack these IP addresses can inflict at any given time👇.

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

| **TTPs**🥷 | **A few countries of origin**🌍 | **Avg IP addr per day**🛜 |
|---|---|---|
| [**Apache Attack**](https://attack.mitre.org/techniques/T1190/) | **Belgium, UK, Poland, Russia** | NC |
| [**Nginx Attack**](https://attack.mitre.org/techniques/T1102/) | **Brazil, USA, France, China** | NC |
| [**Ransomware Attack**](https://attack.mitre.org/techniques/T1486/) | **Brazil, Lithuania, Russia** | NC |
| [**VPN Attack**](https://attack.mitre.org/techniques/T1133/) | **Belgium, UK, Poland, Russia** | NC |
| [**RDP Attack**](https://attack.mitre.org/techniques/T1021/001/) | **USA, Brazil, Peru, Morocco** | NC |
| [**NTLM Attack**](https://attack.mitre.org/techniques/T1187/) | **China, UK, Poland, Belgium** | NC |
| [**Kerberos Attack**](https://attack.mitre.org/techniques/T1558/003/) | **Venezuela, Brazil, Poland, Algeria** | NC | 
| [**Wordpress Enumeration**](https://attack.mitre.org/techniques/T1087/) | **USA, China, Russia, UK** | NC |
| [**Botnet Recruitment**](https://attack.mitre.org/techniques/T1583/005/) | **USA, China, Brazil, Chile** | NC |
| [**Brute-force Attack**](https://attack.mitre.org/techniques/T1110/) | **USA, China, UK, France** | NC |
| [**Brute-Force SSH Login**](https://attack.mitre.org/techniques/T1110/) | **USA, China, Poland, Netherlands** | NC |
| [**Directory Busting**](https://attack.mitre.org/techniques/T1083/) | **USA, China, Italy, India** | NC |
| [**Credentials Dumping**](https://attack.mitre.org/techniques/T1003/) | **India, Japan, UK, Netherlands** | NC |
| [**Email Attack**](https://attack.mitre.org/techniques/T1114/) | **USA, China, India, Spain** | NC |
| [**SMB Attack**](https://attack.mitre.org/techniques/T1021/002/) | **USA, China, Poland, France** | NC |
| [**FTP Attack**](https://attack.mitre.org/techniques/T1105/) | **UK, France, Poland, Vietnam** | NC |
| [**IMAP Attack**](https://attack.mitre.org/techniques/T1071/003/) | **USA, China, Poland, France** | NC |
| [**Information Gathering**](https://attack.mitre.org/techniques/T1591/) | **USA, China, India, Lithuania** | NC |
| [**Remote Code Execution**](https://attack.mitre.org/techniques/T1210/) | **USA, India, Pakistan, Iran** | NC |
| [**Scanning**](https://attack.mitre.org/techniques/T1595/) | **USA, China, India, Indonesia** | NC |
| [**SSH Attack**](https://attack.mitre.org/techniques/T1021/004/) | **USA, China, India, France** | NC |
| [**Tor Exit Node**](https://attack.mitre.org/software/S0183/) | **Switzerland, France, Germany** | NC |
| [**Tor Node**](https://attack.mitre.org/software/S0183/) | **Switzerland, France, Germany** | NC |
| [**VOIP Attack**](https://attack.mitre.org/techniques/T1616/) | **Belgium, India, Vietnam, Indonesia** | NC |
| [**Web Traversal**](https://capec.mitre.org/data/definitions/139.html) | **USA, China, Lithuania, France** | NC |

Etc.

**PS: this list will be updated every 4/24h**

# Tips 💡

> - You can easily integrate this list into your FWs under the Inbound/Outbound policy rules, Threat feeds.
> - To add my blocklist to the Fortinet, CheckPoint, Palo Alto and OPNsense FWs, here are some interesting links

| **Vendor**🧱 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **Fortinet** | External blocklist policy | [**Fortinet Website**](https://docs.fortinet.com/document/fortigate/7.2.0/administration-guide/891236) |
| **Checkpoint** | IP Block Feature | [**Checkpoint Website**](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) |
| **Palo Alto** | Configure the Firewall to Access an External Dynamic List | [**Palo Alto Website**](https://docs.paloaltonetworks.com/pan-os/10-2/pan-os-admin/policy/use-an-external-dynamic-list-in-policy/configure-the-firewall-to-access-an-external-dynamic-list) |
| **OPNsense** | OPNsense : Block malicious IPs | [**Slash-Root Website**](https://slash-root.fr/opnsense-block-malicious-ips/) |

# A few figures 🎖️

> According to feedback, more than 70 small and medium-sized companies (Acensi as well) have already implemented this list in their FW Fortinet, Palo Alto, Checkpoint, etc.

# Support my work with a donation 🙏

| **Site**📍 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **Ko-Fi** | Join all types of creators getting donations, memberships, etc. from their fans! | [**Thank you !!!**](https://ko-fi.com/laurentmduggytuxy) |
| **Liberapay** | Liberapay is a recurring donation platform. | [**Thank you !!!**](https://liberapay.com/Duggy_Tuxy) |

Intelligence IPv4 Blocklist © 2023 by Duggy Tuxy is licensed under Creative Commons Attribution-NonCommercial 4.0 International. To view a copy of this license, visit [**the official website**](https://creativecommons.org/licenses/by-nc/4.0/)
