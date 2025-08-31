# Data-Shield IPv4 Blocklist - Blockage d'adresses IP malveillantes

<p align="center">


  ![Open Source](https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative)
  ![No False Positive](https://img.shields.io/badge/No_False_Positive-100%25-green?style=for-the-badge&logo=cachet)
  ![Last update](https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github)
  </p>

# Présentation du projet

Ce projet vise à réduire le nombre d'attaques en bloquant les adresses IP identifiées comme abusives, agressives ou malveillantes. Grâce à un réseau de 16 leurres déployés dans des zones stratégiques du cyberespace européen, plus de **8000 adresses IP uniques** sont collectées quotidiennement. Après analyse et validation, les adresses IP sont ajoutées à cette liste de blocage, surveillée en continu. Je rappelle que cette liste ne remplace en aucun cas les bonnes pratiques de sécurité, elle y contribue et mise à journée toutes les **4 à 24 heures**

### Objectif

Cette liste constitue une **couche de protection supplémentaire** visant à :

- Réduire le nombre d’attaques
- Limiter la cartographie des actifs exposés (IP publiques)
- Réduire légèrement la surface d’attaque (ex. reconnaissance)

### Politique de rétention

Les adresses IP sont conservées pendant **60 jours maximum**. Si aucune activité n’est détectée durant cette période, elles sont retirées de la liste de blocage et transférées dans une **liste blanche** également surveillée.

# Points clés 

- **Destination principale** : Europe  
- Certaines adresses IP ont une durée de vie courte (APT, infostealers, malwares, etc.)

# Types d’attaques identifiées

| **CVE** | **URL** | **TTPs** | **Pays les plus ciblés** |
|---|---|---|---|
| **CVE-2020-25078** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2020-25078) | [**Apache Attack**](https://attack.mitre.org/techniques/T1190/) | FR, BE, NL, GE |
| **CVE-2021-42013** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-42013) | [**Nginx Attack**](https://attack.mitre.org/techniques/T1102/) | BE, IT, NL, PL |
| **CVE-2021-41773** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-41773) | [**VPN Attack**](https://attack.mitre.org/techniques/T1133/) | FR, BE, NL, GE |
| **CVE-2024-3400** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3400) | [**RDP Attack**](https://attack.mitre.org/techniques/T1021/001/) | FR, BE, IT, ES |
| **CVE-2017-16894** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-16894) | [**Brute-Force SSH Login**](https://attack.mitre.org/techniques/T1110/) | PL, BE, NL, FR |
| **CVE-2024-3721** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3721) | [**Credentials Dumping**](https://attack.mitre.org/techniques/T1003/) | FR, BE, ES, PT |
| **CVE-2022-30023** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-30023) | [**Information Gathering**](https://attack.mitre.org/techniques/T1591/) | FR, BE, NL, LU |
| **CVE-2017-9841** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-9841) | [**Remote Code Execution**](https://attack.mitre.org/techniques/T1210/) | FR, BE, LU, GE |
| **CVE-2018-10561** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-10561) | [**Ransomware Attack**](https://attack.mitre.org/techniques/T1486/) | FR, BE, ES, PT |
| **CVE-2018-20062** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-20062) | [**OT/ICS Attack**](https://attack.mitre.org/techniques/ics/) | FR, BE, NL, GE |
| **CVE-2022-44808** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-44808) | [**Tor Exit Node**](https://attack.mitre.org/software/S0183/) | GE, FR, NL, PL |
| **CVE-2022-41040** | [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41040) | [**Web Traversal**](https://capec.mitre.org/data/definitions/139.html) | BE, FR, NL, AT |
| **CVE-2022-41082**| [**Wazuh CTI Website**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41082) | [**IMAP Attack**](https://attack.mitre.org/techniques/T1071/003/) | FR, BE, NL, GE |

## Intégration dans les pare-feux

| **Fournisseur** | **URL** |
|---|---|
| **Fortinet** | [**Lien vers l'intégration**](https://docs.fortinet.com/document/fortigate/7.2.0/administration-guide/891236) |
| **Checkpoint** | [**Lien vers l'intégration**](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) |
| **Palo Alto** | [**Lien vers l'intégration**](https://docs.paloaltonetworks.com/pan-os/10-2/pan-os-admin/policy/use-an-external-dynamic-list-in-policy/configure-the-firewall-to-access-an-external-dynamic-list) |
| **OPNsense** | [**Lien vers l'intégration**](https://slash-root.fr/opnsense-block-malicious-ips/) |

# Quelques retours notables

D'après les informations reccueillies sur **Linkedin** à travers mon réseau professionnel, 157 petites, moyennes entreprises (dont **Acensi**), des particuliers et freelances ont déjà intégré cette liste dans leur pare-feux Fortinet, Palo Alto, Checkpoint, etc.

# Soutenir le projet

Ce projet peut sembler être d'une facilité déconcertante à maintenir mais il représente du temps de travail et du financement :

- Hébergement des leurres (VPS)
- APIs
- Corrélation de données
- Vérification, qualification, intégration et mise en production continue

Grâce à votre soutien et aux dons, ce projet sera maintenu et perdurera son existance !

| **Site de donations** | **Description** | **URL** |
|---|---|---|
| **Ko-Fi** | Rejoignez tous les types de créateurs qui reçoivent des dons, des adhésions, etc. de la part de leurs fans ! | [**Merci à vous !!!**](https://ko-fi.com/laurentmduggytuxy) |

Data-Shield IPv4 Blocklist © 2023 par Duggy Tuxy (Laurent Minne) est sous licence [**License File**](/LICENSE)
