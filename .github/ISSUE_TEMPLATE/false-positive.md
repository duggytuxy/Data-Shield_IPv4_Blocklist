---
name: ❗ Signalement - Faux positif
about: Signaler une adresse IP présente dans la blocklist que vous considérez comme légitime / non-malveillante.
title: "[FALSE-POSITIVE] <IP> - <Contexte court>"
labels: false-positive, triage
assignees: []
---

## 🧾 Résumé
**Adresse IP concernée (obligatoire)** : `x.x.x.x`  
**Fichier / liste** : (ex : `prod_data-shield_ipv4_blocklist.txt`, `prod_aa_...`)  
**Date / heure observée (UTC)** : YYYY-MM-DD HH:MM

---

## 🔍 Contexte & preuve (indiquez ici autant d'éléments que possible)
- **Contexte d’utilisation de l’IP** : (ex : serveur web hébergé chez OVH, serveur mail Azure, appliance entreprise, box résidentielle, etc.)  
- **Pourquoi vous pensez que c’est un faux positif** : (ex : activité normale, service légitime, logs d’accès légitimes, IDS qui indique trafic non-malveillant, etc.)  
- **Preuves (logs, captures, headers, requêtes, URLs, etc.)** :  
  - `grep` / extrait de log (masquez les données sensibles si besoin)  
  - capture d’écran (joindre en tant que fichier)  
  - entêtes HTTP, User-Agent, reverse DNS, ASN (si disponibles)  
- **ASN / FAI** (si connu) : ex. `ASXXXXX - OVH SAS`

---

## ℹ️ Détails techniques utiles
- **Plage CIDR associée (si applicable)** : ex. `x.x.x.0/24`  
- **Ports & services observés** : ex. `80 (http)`, `443 (https)`, `25 (smtp)`  
- **Dernière activité observée** : YYYY-MM-DD HH:MM UTC  
- **Impact opérationnel** : (ex : blocage d’accès utilisateur, interruption d’un service client, souci de monitoring, autres)

---

## ✅ Action demandée
- [ ] Supprimer immédiatement l’IP de la blocklist (urgence)  
- [ ] Mettre en quarantaine / déplacer vers liste de vérification manuelle avant suppression  
- [ ] Requalifier comme “whitelisted” (surveillance passive)  
- [ ] Autre : (préciser)

---

## 🔐 Confidentialité / note
Si vous fournissez des logs contenant des données personnelles, **veuillez supprimer/anonymiser** les éléments sensibles (noms, emails, tokens). Pour toute information sensible, utilisez la voie privée (email ou message chiffré) après contact via GitHub.

---

Merci - notre équipe va examiner la demande et répondre sous 48h (souvent plus vite).
