# Data-Shield IPv4 Blocklist - Bloquez les adresses IP malveillantes

<p align="center">


  ![Open Source](https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative)
  ![No False Positive](https://img.shields.io/badge/No_False_Positive-100%25-green?style=for-the-badge&logo=cachet)
  ![Last update](https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github)
  </p>

# Présentation du projet

Ce projet vise à réduire le nombre d'attaques en bloquant les adresses IP identifiées comme abusives, agressives, dangereuses. Grâce à un réseau de 36 leurres déployés dans des zones stratégiques du cyberespace, plus de **9240 adresses IP uniques** sont collectées quotidiennement. Après analyse et validation, les adresses IP sont ajoutées à cette liste de blocage, surveillée en continu. Je rappelle que cette liste ne remplace en aucun cas les bonnes pratiques de sécurité, elle y contribue et mise à journée toutes les **24 heures**

### Objectif

Cette liste constitue une **couche de protection supplémentaire** visant à :

- Réduire le nombre d’attaques
- Limiter la cartographie des actifs exposés (IP publiques)
- Réduire légèrement la surface d’attaque (ex. reconnaissance)

### Politique de rétention

Les adresses IP sont conservées pendant **60 jours maximum**. Si aucune activité n’est détectée durant cette période, elles sont retirées de la liste de blocage et transférées dans une **liste blanche** également surveillée.

# Points clés 

- **Destination** : World  
- Certaines adresses IP ont une durée de vie courte (APT, infostealers, malwares, etc.)

# Types d’attaques identifiées

| **CVE** | **TTPs** | **Pays les plus ciblés** |
|---|---|---|
| [**CVE-2020-25078**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2020-25078) | [**Apache Attack**](https://attack.mitre.org/techniques/T1190/) | FR, BE, NL, GE |
| [**CVE-2021-42013**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-42013) | [**Nginx Attack**](https://attack.mitre.org/techniques/T1102/) | BE, IT, NL, PL |
| [**CVE-2021-41773**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-41773) | [**VPN Attack**](https://attack.mitre.org/techniques/T1133/) | FR, BE, NL, GE |
| [**CVE-2024-3400**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3400) | [**RDP Attack**](https://attack.mitre.org/techniques/T1021/001/) | FR, BE, IT, ES |
| [**CVE-2017-16894**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-16894) | [**Brute-Force SSH Login**](https://attack.mitre.org/techniques/T1110/) | PL, BE, NL, FR |
| [**CVE-2024-3721**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3721) | [**Credentials Dumping**](https://attack.mitre.org/techniques/T1003/) | FR, BE, ES, PT |
| [**CVE-2022-30023**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-30023) | [**Information Gathering**](https://attack.mitre.org/techniques/T1591/) | FR, BE, NL, LU |
| [**CVE-2017-9841**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-9841) | [**Remote Code Execution**](https://attack.mitre.org/techniques/T1210/) | FR, BE, LU, GE |
| [**CVE-2018-10561**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-10561) | [**Ransomware Attack**](https://attack.mitre.org/techniques/T1486/) | FR, BE, ES, PT |
| [**CVE-2018-20062**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-20062) | [**OT/ICS Attack**](https://attack.mitre.org/techniques/ics/) | FR, BE, NL, GE |
| [**CVE-2022-44808**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-44808) | [**Tor Exit Node**](https://attack.mitre.org/software/S0183/) | GE, FR, NL, PL |
| [**CVE-2022-41040**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41040) | [**Web Traversal**](https://capec.mitre.org/data/definitions/139.html) | BE, FR, NL, AT |
| [**CVE-2022-41082**](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41082) | [**IMAP Attack**](https://attack.mitre.org/techniques/T1071/003/) | FR, BE, NL, GE |

## Intégration dans les pare-feux

4 listes sont à votre disposition

- [**prod_data-shield_ipv4_blocklist.txt**](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) (liste complète) pour les pare-feux dont la limitation est de 130.000 IPs par liste externe
- [**prod_aa_data-shield_ipv4_blocklist.txt**](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) (liste splittée) pour les pare-feux dont la limitation est de 50.000 IPs par liste externe
- [**prod_ab_data-shield_ipv4_blocklist.txt**](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) (liste splittée) pour les pare-feux dont la limitation est de 50.000 IPs par liste externe
- [**prod_ac_data-shield_ipv4_blocklist.txt**](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) (liste splittée) pour les pare-feux dont la limitation est de 50.000 IPs par liste externe

### Tutoriels en provenance de quelques fournisseurs pour l'intégration

| **Fournisseur** | **URL** | **Taille des tables** |
|---|---|---|
| **Fortinet** | [**Lien vers l'intégration**](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext) | Tailles augmentées depuis [**le firmware 7.4.9**](https://docs.fortinet.com/document/fortigate/7.4.9/fortios-release-notes/626946/changes-in-table-size)
| **Checkpoint** | [**Lien vers l'intégration**](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) | TBD |
| **Palo Alto** | [**Lien vers l'intégration**](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama) | TBD |
| **OPNsense** | [**Lien vers l'intégration**](https://slash-root.fr/opnsense-block-malicious-ips/) | TBD |
| **Stormshield**| [**Bloquer les IP et pays à risque**](https://www.youtube.com/watch?v=yT2oas7M2UM) | TBD |

# Quelques retours notables

D'après les informations reccueillies sur **Linkedin** à travers mon réseau professionnel, 165 petites, moyennes entreprises (dont **Acensi**), des particuliers et freelances ont déjà intégré cette liste dans leur pare-feux Fortinet, Palo Alto, Checkpoint, etc.

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

Data-Shield IPv4 Blocklist © 2023-2025 par Duggy Tuxy (Laurent Minne) est sous licence [**License File**](/LICENSE)
