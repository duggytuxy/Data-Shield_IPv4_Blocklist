<p align="left">
  <img src="https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_logo_official_white_dark.png">
</p>
<p align="center">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/No_False_Positive-100%25-green?style=for-the-badge&logo=cachet">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github">
</p>

> 🛡Block malicious IP addresses and reduce your attack surface!

# Data-Shield IPv4 Blocklist  

Data-Shield IPv4 Blocklist is an additional layer of protection containing a list of [IP addresses (version 4)](https://en.wikipedia.org/wiki/IPv4) whose activities have been detected as malicious.

This list is designed around the discipline of [Deceptive Security](https://www.orangecyberdefense.com/be/blog/discover-deception-security#:~:text=What%20is%20deception%20security?,potentially%20demotivate%20some%20of%20them.) based on intelligent behavioral analysis of malicious activities related to cybercrime.

Data-Shield IPv4 Blocklist contains the most recent data (IPv4 addresses) to provide an additional layer of security for your [firewall](https://en.wikipedia.org/wiki/Firewall_(computing)), [WAF](https://en.wikipedia.org/wiki/Web_application_firewall), and [DNS sinkhole](https://en.wikipedia.org/wiki/DNS_sinkhole) instances.

## Why Data-Shield IPv4 Blocklist?

- **Easy integration into your firewall, WAF, DNS Sinkhole instances**: This list can be easily integrated into most vendors as a single link (RAW) for standard recognition of the included data.
- **Customizable based on vendor limitations**: Some vendors have limited the number of IPv4 addresses per entry (per list) to prevent resource consumption overload. Data-Shield IPv4 Blocklist is designed to comply with this limitation by creating split lists.
- **Data reliability (IPv4)**: Data-Shield IPv4 Blocklist provides high-quality, reliable data by minimizing false positives to avoid blocking legitimate exposed instances.
- **Frequency of updates**: Data-Shield IPv4 Blocklist is updated every 24 hours to maintain the most recent data in order to protect you as effectively as possible.
- **Data retention (IPv4 only)**: Data retention is limited to a maximum of 54 days. This retention is mainly used to continuously monitor the activities of IPv4 addresses tagged as malicious, which have short lifespans but are likely to resurface.

## Malicious activities detected (TTPs)

A non-exhaustive list of Malicious activities (CVEs Exploit):

- **CVE-2020-25078**: CVSS 3.1: ```7.5```,```https://cti.wazuh.com/vulnerabilities/cves/CVE-2020-25078``` | [Apache Exploit](https://attack.mitre.org/techniques/T1190/) | FR, BE, NL, DE |
- **CVE-2021-42013**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-42013``` | [Nginx Exploit](https://attack.mitre.org/techniques/T1102/) | BE, IT, NL, PL |
- **CVE-2021-41773**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-41773``` | [VPN Exploit](https://attack.mitre.org/techniques/T1133/) | FR, BE, NL, DE |
- **CVE-2024-3400** : ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3400``` | [RDP Abuse](https://attack.mitre.org/techniques/T1021/001/) | FR, BE, IT, ES |
- **CVE-2025-0282** : ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2025-0282``` | [SSH Brute-Force](https://attack.mitre.org/techniques/T1110/) | PL, BE, NL, FR |
- **CVE-2024-3721** : ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3721``` | [Credential Dumping](https://attack.mitre.org/techniques/T1003/) | FR, BE, ES, PT |
- **CVE-2022-30023**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-30023``` | [Information Gathering](https://attack.mitre.org/techniques/T1591/) | FR, BE, NL, LU |
- **CVE-2017-9841** : ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-9841``` | [Remote Code Execution](https://attack.mitre.org/techniques/T1210/) | FR, BE, LU, DE |
- **CVE-2018-10561**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-10561``` | [Ransomware](https://attack.mitre.org/techniques/T1486/) | FR, BE, ES, PT |
- **CVE-2018-20062**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-20062``` | [OT/ICS Attack](https://attack.mitre.org/techniques/ics/) | FR, BE, NL, DE |
- **CVE-2022-44808**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-44808``` | [Tor Exit Node Abuse](https://attack.mitre.org/software/S0183/) | DE, FR, NL, PL |
- **CVE-2022-41040**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41040``` | [Web Traversal](https://capec.mitre.org/data/definitions/139.html) | BE, FR, NL, AT |
- **CVE-2022-41082**: ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41082``` | [IMAP Exploit](https://attack.mitre.org/techniques/T1071/003/) | FR, BE, NL, DE |
- **CVE-2024-4577** : ```https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-4577``` | [Phishing](https://attack.mitre.org/techniques/T1566/) | BE, US, FR, NL |

## 🛂Flux de traitement et d'intégration
**Informations autour des flux de traitements**
- Collecte de logs en provenance des agents de leurres
- Traitement depuis la plateforme centralisée sur Wazuh 4.13
- Création de `2 flux` - Whitelist et Blocklist
- Traitement et suppresion des faux-positifs (FPs)
- Création des blocklists [listes en production](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#listes-en-production)

**Informations autour de l'intégration**
- L'intégration des blocklists se font principalement depuis les Firewalls (FortiOS, PAN-OS, IPtables, pfSense, OPNsense, etc.)
- Pour intégrer les listes selon les vendors, visitez cette partie [Tutoriels d'intégration](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist?tab=readme-ov-file#-tutoriels-dint%C3%A9gration)

## 🔗 Règles dans les pare-feux
⚠️**Informations importantes autour de la configuration liée à l'intégration**

> Comme ce sont des adresses IP qui tamponnent les assets exposés, la configuration DOIT se faire uniquement : WAN to LAN (de l'Internet vers le réseau interne)

## 📝Listes en production
| **Nom de la liste** | **Usage recommandé** | **Limite IPs** |
|:--|:--|:--:|
| [prod_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) | Liste complète | 100 000 |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30 000 |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30 000 |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30 000 |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30 000 |
| [prod_daily_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_daily_data-shield_ipv4_blocklist.txt) | Liste complète "Daily" | 60 000 |

📁**Explications sur le contenu des blocklists**

> **prod_data-shield_ipv4_blocklist.txt** 👉 Liste complète avec un historique de 60 jours

```
https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt
```

> **prod_aa_data-shield_ipv4_blocklist.txt** 👉 Liste splittée "A" avec un historique de 60 jours

```
https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt
```

> **prod_ab_data-shield_ipv4_blocklist.txt** 👉 Liste splittée "B" avec un historique de 60 jours

```
https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt
```
> **prod_ac_data-shield_ipv4_blocklist.txt** 👉 Liste splittée "C" avec un historique de 60 jours

```
https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt
```

> **prod_ad_data-shield_ipv4_blocklist.txt** 👉 Liste splittée "D" avec un historique de 60 jours

```
https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt
```

✅**Nouvelle liste en production**

> **prod_daily_data-shield_ipv4_blocklist.txt** 👉 Liste complète sans historique (mise à journée toutes les 24 heures)

> ⚙***Cette liste est idéale pour les assets critiques exposés car elle consommera moins de ressources vue le nombre d'adresses IP réduit***

```
https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_daily_data-shield_ipv4_blocklist.txt
```

## 📚 Tutoriels d’intégration
| **Fournisseur** | **Documentation / Tutoriel** | **Taille max. de table** |
|:--|:--|:--:|
| **Fortinet** | [Guide officiel](https://docs.fortinet.com/document/fortigate/7.4.9/administration-guide/379433/configuring-a-threat-feed#threat-ext) | [FortiOS 7.4.9](https://docs.fortinet.com/document/fortigate/7.4.9/fortios-release-notes/626946/changes-in-table-size) |
| **Checkpoint** | [Guide constructeur](https://sc1.checkpoint.com/documents/R80.20SP/WebAdminGuides/EN/CP_R80.20SP_Maestro_AdminGuide/Topics-Maestro-AG/IP-Block-Feature.htm) | TBD |
| **Palo Alto** | [Panorama EDL](https://docs.paloaltonetworks.com/network-security/security-policy/administration/objects/external-dynamic-lists/configure-the-firewall-to-access-an-external-dynamic-list#configure-the-firewall-to-access-an-external-dynamic-list-panorama) | TBD |
| **OPNsense** | [Guide Slash-Root (Julien Louis)](https://slash-root.fr/opnsense-block-malicious-ips/) | TBD |
| **Stormshield** | [Vidéo officielle](https://www.youtube.com/watch?v=yT2oas7M2UM) | TBD |
| **F5 BIG-IP** | [Guide officiel](https://my.f5.com/manage/s/article/K10978895) | TBD |
| **IPTables** | [Tutoriel Lupovis (X. Bellekens)](https://www.linkedin.com/posts/activity-7125481101728313345-b8jM) | TBD |
| **UniFi’s Next-Gen Firewall** | [Guide constructeur](https://help.ui.com/hc/en-us/articles/28314415752727-Application-Filtering-in-UniFi) | TBD |

## 💬 Retours de la communauté
D’après les retours recueillis sur **LinkedIn**, plus de **`204 entreprises et indépendants`** (dont **Acensi**) utilisent déjà Data-Shield IPv4 Blocklist dans leurs pare-feux Fortinet, Palo Alto, Check Point, etc.

## ❓ Faq

### Comment utiliser les blocklists ?
Les blocklists peuvent être intégrées dans vos pare-feux, WAF ou systèmes de détection d'intrusion (IDS/IPS) pour bloquer automatiquement les adresses IP malveillantes.

### Quelle est la fréquence de mise à jour ?
Les listes sont mises à jour toutes les 24 heures pour garantir une protection optimale.

### Est-ce que cette liste remplace un antivirus ou un firewall ?
Non. Elle est complémentaire aux solutions de sécurité existantes.

### Que faire en cas de faux positif ?
Les IP sont vérifiées rigoureusement. En cas de doute, vous pouvez soumettre un rapport via les canaux communautaires [Issues](https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/issues).

### Puis-je contribuer au projet ?
Oui ! Vous pouvez soutenir le projet via Ko-Fi.

### Quels systèmes sont compatibles ?
Les blocklists sont compatibles avec Fortinet, Palo Alto, Check Point, OPNsense, pfSense, IPTables, Stormshield, F5 BIG-IP, UniFi, etc.

## ❤️ Soutenir le projet
Le maintien de ce projet nécessite du temps et des ressources :

- Hébergement et supervision des leurres  
- APIs et corrélation de données  
- Qualification, validation, intégration et publication continue  

| **Plateforme** | **Description** | **Lien** |
|:--|:--|:--|
| **Ko-Fi** | Soutenez le projet et rejoignez les contributeurs. | [👉 Faire un don](https://ko-fi.com/laurentmduggytuxy) |
| **Duggy Tuxy Store** | Boutique officielle (goodies et produits dérivés). | [🛍️ Visiter la boutique](https://duggy-tuxy.myspreadshop.be/)

## ⚖Licence
Data-Shield IPv4 Blocklist © 2023-2025 par Duggy Tuxy (Laurent Minne) est sous [licence](/LICENSE.md)

<p align="center">🧠 _“Security through intelligence, not noise.”_</p>
