# Data-Shield IPv4 Blocklist - Blockage d'adresses IP malveillantes

<p align="center">


  ![Open Source](https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative)
  ![No False Positive](https://img.shields.io/badge/No_False_Positive-100%25-green?style=for-the-badge&logo=cachet)
  ![Last update](https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github)
  </p>

# Présentation du projet

Ce projet vise à réduire le nombre d'attaques en bloquant les adresses IP identifiées comme abusives, agressives ou malveillantes. Grâce à un réseau de 16 leurres déployés dans des zones stratégiques du cyberespace européen, plus de **8000 adresses IP uniques** sont collectées quotidiennement. Après analyse et validation, les adresses IP sont ajoutées à cette liste de blocage, surveillée en continu. Je rappelle que cette liste ne remplace en aucun cas les bonnes pratiques de sécurité, elle y contribue !

### Objectifs

Cette liste constitue une **couche de protection supplémentaire** visant à :

- Réduire le nombre d’attaques
- Limiter la cartographie des actifs exposés (IP publiques)
- Réduire légèrement la surface d’attaque (ex. reconnaissance)

Mises à jour effectuées toutes les **4 à 24 heures**

### Politique de suppression

Les adresses IP sont conservées pendant **60 jours maximum**. Si aucune activité n’est détectée durant cette période, elles sont retirées de la liste de blocage et transférées dans une **liste blanche** également surveillée.

# Points clés 

- **Destination principale** : Europe  
- Certaines adresses IP ont une durée de vie courte (APT, infostealers, malwares, etc.)

# Types d’attaques identifiées

| **CVE** | **URL** |
|---|---|
| **CVE-2020-25078** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2020-25078) |
| **CVE-2021-42013** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-42013) |
| **CVE-2021-41773** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-41773) |
| **CVE-2024-3400** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3400) |
| **CVE-2017-16894** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-16894) |
| **CVE-2024-3721** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3721) |
| **CVE-2022-30023** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-30023) |
| **CVE-2017-9841** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-9841) |
| **CVE-2018-10561** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-10561) |
| **CVE-2018-20062** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-20062) |
| **CVE-2022-44808** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-44808) |
| **CVE-2022-41040** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41040) |
| **CVE-2022-41082**| [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41082) |

| **TTPs** | **Indicateur de risque (%)** |
|---|---|
| [**Apache Attack**](https://attack.mitre.org/techniques/T1190/) | 80 |
| [**Nginx Attack**](https://attack.mitre.org/techniques/T1102/) | 80 |
| [**Ransomware Attack**](https://attack.mitre.org/techniques/T1486/) | 90 |
| [**VPN Attack**](https://attack.mitre.org/techniques/T1133/) | 80 |
| [**RDP Attack**](https://attack.mitre.org/techniques/T1021/001/) | 90 |
| [**NTLM Attack**](https://attack.mitre.org/techniques/T1187/) | 80 |
| [**Kerberos Attack**](https://attack.mitre.org/techniques/T1558/003/) | 85 | 
| [**Wordpress Enumeration**](https://attack.mitre.org/techniques/T1087/) | 50 |
| [**Botnet Recruitment**](https://attack.mitre.org/techniques/T1583/005/) | 50 |
| [**Brute-force Attack**](https://attack.mitre.org/techniques/T1110/) | 80 |
| [**Brute-Force SSH Login**](https://attack.mitre.org/techniques/T1110/) | 80 |
| [**Directory Busting**](https://attack.mitre.org/techniques/T1083/) | 60 |
| [**Credentials Dumping**](https://attack.mitre.org/techniques/T1003/) | 90 |
| [**Email Attack**](https://attack.mitre.org/techniques/T1114/) | 80 |
| [**SMB Attack**](https://attack.mitre.org/techniques/T1021/002/) | 75 |
| [**FTP Attack**](https://attack.mitre.org/techniques/T1105/) | 70 |
| [**IMAP Attack**](https://attack.mitre.org/techniques/T1071/003/) | 80 |
| [**Information Gathering**](https://attack.mitre.org/techniques/T1591/) | 70 |
| [**Remote Code Execution**](https://attack.mitre.org/techniques/T1210/) | 80 |
| [**Scanning**](https://attack.mitre.org/techniques/T1595/) | 50 |
| [**SSH Attack**](https://attack.mitre.org/techniques/T1021/004/) | 80 |
| [**OT/ICS Attack**](https://attack.mitre.org/techniques/ics/) | 90 |
| [**IoT Attack**](https://attack.mitre.org/campaigns/C0053/) | 80 |
| [**Tor Exit Node**](https://attack.mitre.org/software/S0183/) | 60 |
| [**Tor Node**](https://attack.mitre.org/software/S0183/) | 60 |
| [**VOIP Attack**](https://attack.mitre.org/techniques/T1616/) | 70 |
| [**Web Traversal**](https://capec.mitre.org/data/definitions/139.html) | 75 |

## Intégration dans les pare-feux

| **Fournisseur** | **URL** |
|---|---|
| **Fortinet** | [**Lien vers l'intégration**](https://docs.fortinet.com/document/fortigate/7.2.0/administration-guide/891236) |
| **Checkpoint** | [**Lien vers l'intégration**](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) |
| **Palo Alto** | [**Lien vers l'intégration**](https://docs.paloaltonetworks.com/pan-os/10-2/pan-os-admin/policy/use-an-external-dynamic-list-in-policy/configure-the-firewall-to-access-an-external-dynamic-list) |
| **OPNsense** | [**Lien vers l'intégration**](https://slash-root.fr/opnsense-block-malicious-ips/) |

# Quelques retours notables

D'après les informations reccueillies sur **Linkedin** à travers mon réseau professionnel, ce sont plus de 85 petites et moyennes entreprises (dont **Acensi**) ont déjà intégré cette liste dans leur pare-feux Fortinet, Palo Alto, Checkpoint, etc.

# Soutenir le projet

| **Site de donations** | **Description** | **URL** |
|---|---|---|
| **Ko-Fi** | Rejoignez tous les types de créateurs qui reçoivent des dons, des adhésions, etc. de la part de leurs fans ! | [**Merci à vous !!!**](https://ko-fi.com/laurentmduggytuxy) |

Data-Shield IPv4 Blocklist © 2023 by Duggy Tuxy is licensed [**License File**](/LICENSE)
