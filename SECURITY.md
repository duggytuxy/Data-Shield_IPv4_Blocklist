# MODÈLE DE CONFORMITÉ GRC - Document pour l'intégration de la Data-Shield IPv4 Blocklist
Version : 1.1

- ***Propriétaire : Laurent Minne (Mainteneur Data-Shield)***
- ***Contributeurs clés :*** Équipe Opérations Sécurité, Équipe Réseau, Responsable Conformité IT

# Introduction

### Objectif
- Décrire les politiques, responsabilités et contrôles permettant d'intégrer la Data-Shield IPv4 Blocklist comme source de renseignement de menace protégeant l'infrastructure réseau de l'entreprise. La liste alimente les pare-feux et systèmes de prévention pour bloquer automatiquement les adresses IP identifiées comme malveillantes à partir du réseau de 36 leurres Data-Shield mis à jour toutes les 24 heures.

### Portée
- Ce document couvre la consommation sécurisée de la blocklist (versions complète et segmentées) dans les pare-feux Fortinet, Check Point, Palo Alto, OPNsense, Stormshield, F5 et infrastructures IPTables, ainsi que les processus internes de validation, de déploiement automatisé et de suivi continu des 9 240 IP malicieuses collectées quotidiennement.

# Cadre de gouvernance

### Déclaration de politique générale
- La blocklist Data-Shield doit être intégrée comme flux externe approuvé, synchronisé toutes les 24 heures, avec conservation locale limitée à 60 jours. Toute modification des règles d’ingestion ou de distribution doit être approuvée par le Responsable Sécurité Systèmes d’Information (RSSI) et documentée dans le référentiel de configuration des pare-feux. La politique impose la vérification de l’intégrité du flux, la traçabilité des mises à jour et la possibilité de désactivation contrôlée en cas d’incident.

### Rôles et responsabilités
- Le modèle RACI défini en annexe précise :
  - **Laurent Minne (Mainteneur)** : responsable de la qualité du flux, publication quotidienne et notification des changements majeurs.
  - **Équipe Opérations Sécurité** : responsable opérationnel du déploiement sur les pare-feux, approbateur des changements de règles et point focal en astreinte.
  - **Équipe Réseau** : consultée pour l’ingénierie de routage, segmentation et validation des performances.
  - **Responsable Conformité IT** : consulté pour l’alignement aux normes (ISO 27001, NIS2) et informé des rapports de suivi.
  - **Direction Cybersécurité** : informée des indicateurs de réduction des attaques et des incidents associés.

# Évaluation des risques

### Identifier les risques
- Risque de faux positifs entraînant le blocage de clients légitimes.
- Risque d’indisponibilité ou de corruption du flux (perte d’accès GitHub, altération du fichier).
- Risque de dérive de configuration lors de la mise à jour automatisée des pare-feux.
- Risque de non-conformité réglementaire liée au traitement d’adresses IP (données personnelles).
- Risque de retard d’intégration entraînant une exposition prolongée aux menaces.

### Analyse des risques
- **Faux positifs** : probabilité faible grâce à la validation manuelle des IP, impact moyen (perturbation de service).
- **Indisponibilité du flux** : probabilité moyenne (dépendance GitHub), impact élevé (perte de protection actualisée).
- **Dérive de configuration** : probabilité moyenne (scripts d’automatisation), impact élevé (rupture de service ou fail-open).
- **Non-conformité réglementaire** : probabilité faible, impact élevé (sanctions GDPR/NIS2).
- **Retard d’intégration** : probabilité moyenne (processus change), impact moyen (fenêtre d’exposition accrue).

### Atténuation des risques
- Mettre en place une liste de contournement et un processus d’exclusion rapide pour les IP légitimes signalées par le support client.
- Surveiller la disponibilité GitHub via un job de supervision, maintenir un miroir interne signé de la blocklist et vérifier l’empreinte SHA256 avant déploiement.
- Utiliser un pipeline d’intégration continue avec environnement de test réseau et validation par l’équipe Réseau avant mise en production ; activer le versionnement des configurations.
- Documenter le fondement légitime du traitement d’IP (sécurité réseau) et appliquer une rétention locale inférieure à 60 jours conforme à la politique de Data-Shield ; intégrer la procédure dans le registre GDPR.
- Automatiser les déploiements quotidiens avec alertes en cas d’échec et tenir un journal de contrôle attestant du respect de la fréquence de 24 heures.

# Exigences en matière de conformité

### Conformité réglementaire
- S’aligner sur les contrôles ISO/IEC 27001 Annexe A (A.8.16 Surveillance, A.5.7 Partenariats externes) en documentant l’usage du flux Data-Shield comme mesure de sécurité. Respecter les obligations NIS2 concernant la détection et la prévention des cybermenaces, et garantir la conformité GDPR pour le traitement d’adresses IP en s’appuyant sur l’intérêt légitime de sécurité et la limitation de conservation à 60 jours.

### Conformité interne
- Aligner la mise en œuvre sur la Politique de Sécurité des Systèmes d’Information (PSSI) et sur les procédures de gestion des changements réseau. Chaque mise à jour doit être enregistrée dans l’outil ITSM, revue par le Change Advisory Board (CAB) sécurité et validée par le RSSI ; les procédures de rollback doivent être testées trimestriellement.

# Plan d'intégration

### Calendrier du projet
- **Semaine 1** : cadrage, revue des besoins pare-feux, définition des indicateurs et validation du plan par le RSSI.
- **Semaines 2-3** : mise en place du pipeline d’ingestion (scripts d’automatisation, vérification d’intégrité) et tests en environnement pré-production.
- **Semaine 4** : déploiement progressif (pare-feux périmétriques priorisés), monitoring rapproché et collecte des retours utilisateurs.
- **Semaine 5** : extension aux zones internes critiques, revue des incidents, ajustements de règles et validation finale par le CAB.

### Allocation des ressources
- 1 Mainteneur Data-Shield (fournisseur de la blocklist) pour la coordination et la communication des mises à jour.
- 2 Ingénieurs Opérations Sécurité pour l’automatisation et la supervision du déploiement.
- 1 Ingénieur Réseau pour l’optimisation des performances et des limites de taille de tables (50k/130k IP selon équipement).
- Support conformité/GDPR pour la documentation réglementaire et les audits.
- Infrastructure : référentiel Git interne, serveurs d’automatisation (Ansible/GitLab CI), monitoring (Prometheus, SIEM).

### Plan de communication
- Notifications hebdomadaires aux équipes SOC/Réseau sur les volumes d’IP ajoutées/supprimées et incidents bloqués.
- Alertes immédiates (mail + Teams) en cas d’indisponibilité du flux ou de changement critique communiqué par Laurent Minne.
- Rapport mensuel de conformité partagé avec la Direction Cybersécurité et le RSSI incluant indicateurs de réduction d’attaques et cas de faux positifs traités.

# Suivi et révision

### Mécanismes de suivi
- Tableau de bord SIEM consolidant les tentatives bloquées par la blocklist et comparant les statistiques avant/après intégration.
- Surveillance continue des jobs d’ingestion (retour code, taille des fichiers, empreinte) avec alerting 24/7.
- Revue hebdomadaire des IP exclues pour s’assurer du respect de la politique de rétention de 60 jours.

### Processus d'examen
- Revue trimestrielle par le RSSI et le Responsable Conformité pour évaluer l’efficacité du flux, ajuster les politiques de blocage et mettre à jour les procédures.
- Audit annuel ISO 27001/NIS2 pour vérifier la traçabilité des mises à jour, la conformité GDPR et l’adéquation des contrôles techniques.
- Post-mortem systématique après tout incident majeur lié au flux (faux positifs critiques ou indisponibilité prolongée) avec plan d’actions suivi.

# Annexes

### Modèle RACI
| **Tâche** | **Responsable** | **Approbateur** | **Consulté** | **Informé** |
|---|---|---|---|---|
| Publication quotidienne de la blocklist | Laurent Minne | RSSI | Équipe Opérations Sécurité | Direction Cybersécurité |
| Validation technique et tests | Équipe Opérations Sécurité | RSSI | Équipe Réseau | Responsable Conformité IT |
| Déploiement pare-feux (Fortinet, Palo Alto, etc.) | Équipe Opérations Sécurité | Directeur Infrastructure | Équipe Réseau | SOC |
| Gestion des exceptions/faux positifs | Équipe Opérations Sécurité | RSSI | Support Client, Responsable Conformité IT | Direction Cybersécurité |
| Suivi des indicateurs et reporting | Responsable Conformité IT | RSSI | SOC | Direction Générale |
| Audits et revues annuelles | Responsable Conformité IT | RSSI | Laurent Minne, Équipe Opérations Sécurité | Direction Générale |

### Documentation supplémentaire
- Référentiel GitHub Data-Shield IPv4 Blocklist : https://github.com/duggytuxy/Data-Shield_IPv4_Blocklist
- Tutoriels d’intégration par fournisseur (Fortinet, Check Point, Palo Alto, etc.) listés dans le README du projet.

# Prochaines étapes

### Créer le document
- Migrer ce canevas dans l’espace documentaire de l’entreprise (Confluence ou SharePoint) et intégrer les annexes complémentaires (procédures d’automatisation, scripts Ansible, registres GDPR).

### Remplir les sections
- Compléter les parties spécifiques à l’entreprise : inventaire des pare-feux concernés, responsables nominatifs, liens vers les procédures internes (ITSM, SOC, réponse à incident).

### Révision et approbation
- Soumettre le document au CAB sécurité pour validation formelle, obtenir l’approbation du RSSI et de la Direction Cybersécurité, puis diffuser la version approuvée aux parties prenantes.

### Mise en œuvre
- Exécuter le plan d’intégration décrit ci-dessus, suivre les indicateurs définis et déclencher les revues périodiques conformément aux exigences de conformité.
