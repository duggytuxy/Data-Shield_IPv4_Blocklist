# About this project 🧪

I started this project in June 2023 when I discovered, through logs on specific instances, a number of triggers coming from IPv4 addresses with strong signals whose behaviors appeared to be aggressive scan ports, RCE attempts linked to highly exploited CVEs.

I started retrieving them, analyzing them and then storing them in a txt list (I didn't mess around apparently🤣).

And since then, this list has evolved to include data from 16 probes (decoy) deployed in strategic areas of the French and Belgian network.

**I work hard to ensure that you have high-quality data (IPv4) (the most aggressive, malicious and most up-to-date).**

# Intelligence IPv4 Blocklist 🧱

- [**Intelligence IPv4 Blocklist**](https://raw.githubusercontent.com/duggytuxy/Intelligence_IPv4_Blocklist/refs/heads/main/agressive_ips_dst_fr_be_blocklist.txt) : target destination 👉 Europa

# CVEs 🔩

| **CVE**🐞 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **CVE-2020-25078** | An issue was discovered on D-Link DCS-2530L... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2020-25078">🔗</a></div> |
| **CVE-2021-42013** | It was found that the fix for CVE-2021-41773... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2021-42013">🔗</a></div> |
| **CVE-2021-41773** | A flaw was found in a change made to path... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2021-41773">🔗</a></div> |
| **CVE-2024-3400** | PAN-OS : A command injection as a result... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2024-3400">🔗</a></div> |
| **CVE-2017-16894** | In Laravel framework through 5.5.21... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2017-16894">🔗</a></div> |
| **CVE-2024-3721** | A vulnerability was found in TBK DVR-4104 and DVR-4216... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2024-3721">🔗</a></div> |
| **CVE-2022-30023** | Tenda ONT GPON AC1200 Dual band WiFi HG9 v1.0.1... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-30023">🔗</a></div> |
| **CVE-2017-9841** | Util/PHP/eval-stdin.php in PHPUnit before 4.8.28... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2017-9841">🔗</a></div> |
| **CVE-2018-10561** | An issue was discovered on Dasan GPON home routers... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2018-10561">🔗</a></div> |
| **CVE-2018-20062** | An issue was discovered in NoneCms V1.3... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2018-20062">🔗</a></div> |
| **CVE-2022-44808** | Vulnerability has been found on D-Link DIR-823G devices... | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-44808">🔗</a></div> |
| **CVE-2022-41040** | Microsoft Exchange Server Elevation of PV** | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-41040">🔗</a></div> |
| **CVE-2022-41082**| Microsoft Exchange Server RCE Vulnerability** | <div align="center"><a href="https://nvd.nist.gov/vuln/detail/CVE-2022-41082">🔗</a></div> |

Etc.

# TTPs 🐞

- [**Apache Attack**](https://attack.mitre.org/techniques/T1190/)
- [**Nginx Attack**](https://attack.mitre.org/techniques/T1102/)
- [**Ransomware Attack**](https://attack.mitre.org/techniques/T1486/)
- [**VPN Attack**](https://attack.mitre.org/techniques/T1133/)
- [**RDP Attack**](https://attack.mitre.org/techniques/T1021/001/)
- [**NTLM Attack**](https://attack.mitre.org/techniques/T1187/)
- [**Kerberos Attack**](https://attack.mitre.org/techniques/T1558/003/)
- [**Wordpress Enumeration**](https://attack.mitre.org/techniques/T1087/)
- [**Botnet Recruitment**](https://attack.mitre.org/techniques/T1583/005/)
- [**Brute-force Attack**](https://attack.mitre.org/techniques/T1110/)
- [**Brute-Force SSH Login**](https://attack.mitre.org/techniques/T1110/)
- [**Directory Busting**](https://attack.mitre.org/techniques/T1083/)
- [**Credentials Dumping**](https://attack.mitre.org/techniques/T1003/)
- [**Email Attack**](https://attack.mitre.org/techniques/T1114/)
- [**SMB Attack**](https://attack.mitre.org/techniques/T1021/002/)
- [**FTP Attack**](https://attack.mitre.org/techniques/T1105/)
- [**IMAP Attack**](https://attack.mitre.org/techniques/T1071/003/)
- [**Information Gathering**](https://attack.mitre.org/techniques/T1591/)
- [**Remote Code Execution**](https://attack.mitre.org/techniques/T1210/)
- [**Scanning**](https://attack.mitre.org/techniques/T1595/)
- [**SSH Attack**](https://attack.mitre.org/techniques/T1021/004/)
- [**Tor Exit Node**](https://attack.mitre.org/software/S0183/)
- [**Tor Node**](https://attack.mitre.org/software/S0183/)
- [**VOIP Attack**](https://attack.mitre.org/techniques/T1616/)
- [**Web Traversal**](https://capec.mitre.org/data/definitions/139.html)

Etc.

PS: this list will be updated every 4/24h

# Tips 💡

✋You can easily integrate this list into your FWs under the Inbound/Outbound policy rules, Threat feeds.

To add my blocklist to the Fortinet, CheckPoint, Palo Alto and OPNsense FWs, here are some interesting links

| **Vendor**🧱 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **Fortinet** | External blocklist policy | <div align="center"><a href="https://docs.fortinet.com/document/fortigate/7.2.0/administration-guide/891236">🔗</a></div> |
| **Checkpoint** | IP Block Feature | <div align="center"><a href="https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm">🔗</a></div> |
| **Palo Alto** | Configure the Firewall to Access an External Dynamic List | <div align="center"><a href="https://docs.paloaltonetworks.com/pan-os/10-2/pan-os-admin/policy/use-an-external-dynamic-list-in-policy/configure-the-firewall-to-access-an-external-dynamic-list">🔗</a></div> |
| **OPNsense** | OPNsense : Block malicious IPs | <div align="center"><a href="https://slash-root.fr/opnsense-block-malicious-ips/">🔗</a></div> |

# A few figures 🎖️

According to feedback, more than 127 small and medium-sized companies (Acensi as well) have already implemented this list in their FW Fortinet, Palo Alto, Checkpoint, etc.

# Support my work with a donation 🙏

| **Site**📍 | **Description**📜 | **Link**🌍 |
|---|---|---|
| **Ko-Fi** | Join all types of creators getting donations, memberships, etc. from their fans! | <div align="center"><a href="https://ko-fi.com/laurentmduggytuxy">🔗</a></div> |
| **Liberapay** | Liberapay is a recurring donation platform. | <div align="center"><a href="https://liberapay.com/Duggy_Tuxy">🔗</a></div> |

Intelligence IPv4 Blocklist © 2023 by Duggy Tuxy is licensed under Creative Commons Attribution-NonCommercial 4.0 International. To view a copy of this license, visit https://creativecommons.org/licenses/by-nc/4.0/
