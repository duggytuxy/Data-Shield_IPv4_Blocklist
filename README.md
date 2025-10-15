<p align="left">
  <img src=https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/data_shield_ipv4_blocklist.png
</p>

# 🛡️ Data-Shield IPv4 Blocklist  
_"Bloquez les adresses IP dangereuses et réduisez la surface d’attaque."_

<p align="left">
  <img src="https://img.shields.io/badge/Open%20Source-100%25-brightgreen?style=for-the-badge&logo=opensourceinitiative">
  <img src="https://img.shields.io/badge/No_False_Positive-99,99%25-green?style=for-the-badge&logo=cachet">
  <img src="https://img.shields.io/github/last-commit/duggytuxy/Intelligence_IPv4_Blocklist?label=Last%20update&color=informational&style=for-the-badge&logo=github">
</p>

---

## 📖 Présentation du projet

**Data-Shield IPv4 Blocklist** vise à réduire le nombre d’attaques en bloquant les adresses IP identifiées comme sources d’activités malveillantes.

Grâce à un réseau de **`43` leurres** déployés dans des zones stratégiques du cyberespace, plus de **`9 520 IP uniques`** sont collectées chaque jour.  
Après analyse et validation, les adresses IP sont ajoutées à cette liste de blocage, **mise à jour toutes les `24 heures`**.

> ⚠️ Cette liste ne remplace pas les bonnes pratiques de sécurité. Elle constitue une **couche de protection complémentaire**.

---

## 🎯 Objectifs

- Réduire le volume d’attaques et de scans réseau  
- Limiter la cartographie des actifs exposés  
- Compléter les protections existantes (IDS/IPS, SOC, etc.)

---

## 🧱 Politique de rétention

Les adresses IP sont conservées **60 jours maximum**.  
Sans activité détectée durant cette période, elles sont retirées et placées dans une **liste blanche** également surveillée.

---

## 🔑 Points clés

- **Portée globale** : 🌍 “World”  
- Certaines IP ont une durée de vie très courte (APT, ransomware, infostealer, etc.)  
- Vérification rigoureuse pour limiter les faux positifs  

---

## ⚔️ Types d’attaques identifiées

| **CVE** | **Technique MITRE ATT&CK** | **Pays les plus ciblés** |
|:--|:--|:--|
| [CVE-2020-25078](https://cti.wazuh.com/vulnerabilities/cves/CVE-2020-25078) | [Apache Exploit](https://attack.mitre.org/techniques/T1190/) | FR, BE, NL, DE |
| [CVE-2021-42013](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-42013) | [Nginx Exploit](https://attack.mitre.org/techniques/T1102/) | BE, IT, NL, PL |
| [CVE-2021-41773](https://cti.wazuh.com/vulnerabilities/cves/CVE-2021-41773) | [VPN Exploit](https://attack.mitre.org/techniques/T1133/) | FR, BE, NL, DE |
| [CVE-2024-3400](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3400) | [RDP Abuse](https://attack.mitre.org/techniques/T1021/001/) | FR, BE, IT, ES |
| [CVE-2017-16894](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-16894) | [SSH Brute-Force](https://attack.mitre.org/techniques/T1110/) | PL, BE, NL, FR |
| [CVE-2024-3721](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-3721) | [Credential Dumping](https://attack.mitre.org/techniques/T1003/) | FR, BE, ES, PT |
| [CVE-2022-30023](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-30023) | [Information Gathering](https://attack.mitre.org/techniques/T1591/) | FR, BE, NL, LU |
| [CVE-2017-9841](https://cti.wazuh.com/vulnerabilities/cves/CVE-2017-9841) | [Remote Code Execution](https://attack.mitre.org/techniques/T1210/) | FR, BE, LU, DE |
| [CVE-2018-10561](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-10561) | [Ransomware](https://attack.mitre.org/techniques/T1486/) | FR, BE, ES, PT |
| [CVE-2018-20062](https://cti.wazuh.com/vulnerabilities/cves/CVE-2018-20062) | [OT/ICS Attack](https://attack.mitre.org/techniques/ics/) | FR, BE, NL, DE |
| [CVE-2022-44808](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-44808) | [Tor Exit Node Abuse](https://attack.mitre.org/software/S0183/) | DE, FR, NL, PL |
| [CVE-2022-41040](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41040) | [Web Traversal](https://capec.mitre.org/data/definitions/139.html) | BE, FR, NL, AT |
| [CVE-2022-41082](https://cti.wazuh.com/vulnerabilities/cves/CVE-2022-41082) | [IMAP Exploit](https://attack.mitre.org/techniques/T1071/003/) | FR, BE, NL, DE |
| [CVE-2024-4577](https://cti.wazuh.com/vulnerabilities/cves/CVE-2024-4577) | [Phishing](https://attack.mitre.org/techniques/T1566/) | BE, US, FR, NL |

---

## 🛂Flux de traitement et d'intégration

<p align="left">
  <img src=https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist/blob/main/graph_pipeline_data_bl.png
</p>

---

## 🔗 Intégration dans les pare-feux

⚠️**Informations importantes autour de la configuration liée à l'intégration**

> Comme ce sont des adresses IP qui tamponnent les assets exposés, la configuration DOIT se faire uniquement : WAN to LAN (de l'Internet vers le réseau interne)

---

## 📝Listes en production

| **Nom de la liste** | **Usage recommandé** | **Limite IPs** |
|:--|:--|:--:|
| [prod_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_data-shield_ipv4_blocklist.txt) | Liste complète | 100 000 |
| [prod_aa_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_aa_data-shield_ipv4_blocklist.txt) | Split A | 30 000 |
| [prod_ab_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ab_data-shield_ipv4_blocklist.txt) | Split B | 30 000 |
| [prod_ac_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ac_data-shield_ipv4_blocklist.txt) | Split C | 30 000 |
| [prod_ad_data-shield_ipv4_blocklist.txt](https://raw.githubusercontent.com/duggytuxy/Data-Shield_IPv4_Blocklist/refs/heads/main/prod_ad_data-shield_ipv4_blocklist.txt) | Split D | 30 000 |

---

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

---

## 💬 Retours de la communauté

D’après les retours recueillis sur **LinkedIn**, plus de **`165 entreprises et indépendants`** (dont **Acensi**) utilisent déjà Data-Shield IPv4 Blocklist dans leurs pare-feux Fortinet, Palo Alto, Check Point, etc.

---

## 🚨 Signaler un faux positif
Si vous pensez qu’une IP a été ajoutée par erreur, merci de créer une *Issue* en utilisant le template **Signalement - Faux positif** (bouton "New issue" → sélectionner "❗ Signalement - Faux positif").  
Indiquez l’IP, le contexte, les extraits de logs (anonymisés) et la mesure souhaitée (suppression immédiate / réexamen).

---

## ❤️ Soutenir le projet

Le maintien de ce projet nécessite du temps et des ressources :

- Hébergement et supervision des leurres  
- APIs et corrélation de données  
- Qualification, validation, intégration et publication continue  

| **Plateforme** | **Description** | **Lien** |
|:--|:--|:--|
| **Ko-Fi** | Soutenez le projet et rejoignez les contributeurs. | [👉 Faire un don](https://ko-fi.com/laurentmduggytuxy) |
| **Duggy Tuxy Store** | Boutique officielle (goodies et produits dérivés). | [🛍️ Visiter la boutique](https://duggy-tuxy.myspreadshop.be/) |

---

### ⚖️ Mentions légales & RGPD

L’utilisation de cette liste doit respecter les réglementations locales et le RGPD.  
Les adresses IP publiées proviennent de flux techniques anonymes et **ne permettent pas d’identifier une personne physique**.  
Elles sont conservées **60 jours maximum** à des fins de **cybersécurité défensive**, conformément à l’article 6-1.f du RGPD.  
➡️ Consultez le document complet : [**LEGAL**](/LEGAL.md)

Data-Shield IPv4 Blocklist © 2023-2025 par Duggy Tuxy (Laurent Minne) est sous licence [**License File**](/LICENSE.md)

<p align="center">🧠 _“Security through intelligence, not noise.”_</p>
