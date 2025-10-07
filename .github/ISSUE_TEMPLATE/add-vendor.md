name: 🔧 Demande d'ajout - Nouvel éditeur / vendor
description: Demande structurée pour ajouter le support d'un nouvel éditeur (ex : Ubiquiti, MikroTik, etc.)
title: "[VENDOR REQUEST] {vendor} - {usage}"
labels: ['vendor-request','triage']
body:
  - type: markdown
    attributes:
      value: >
        Merci de remplir ce formulaire pour demander l'ajout d'un nouvel **éditeur / vendor**.
        Fournissez autant d'informations que possible afin d'accélérer l'analyse.
  - type: input
    id: vendor
    attributes:
      label: Nom de l'éditeur (vendor) *
      description: Ex: Ubiquiti, MikroTik, Fortinet (si autre, précisez la version/ligne produit)
      placeholder: Ubiquiti
      required: true
  - type: input
    id: usage
    attributes:
      label: Usage / cas d'usage principal *
      description: Ex: import EDL, format d'IPset, threat feed HTTP, intégration via API, etc.
      placeholder: Ex: External Dynamic List (EDL) - EDL HTTP
      required: true
  - type: textarea
    id: motivation
    attributes:
      label: Pourquoi voulez-vous cet éditeur ajouté ? *
      description: Impact opérationnel, nombre d'utilisateurs potentiels, services affectés.
      placeholder: Ex: Nous utilisons des routeurs MikroTik dans tous nos sites et l'import EDL nous manque.
      required: true
  - type: input
    id: doc_link
    attributes:
      label: Lien(s) vers la documentation officielle (URL)
      description: Documentation d'import / example config / API docs
      placeholder: https://www.example.com/docs
      required: false
  - type: input
    id: sample_config
    attributes:
      label: Exemple de configuration / snippet (facultatif)
      description: Un petit extrait qui montre comment lister/consommer une blocklist (ex: commande ipset, config CLI)
      required: false
  - type: input
    id: tested
    attributes:
      label: Avez-vous testé quelque chose localement ? (oui/non)
      description: Si oui, précisez ce que vous avez testé (script, commande, version)
      placeholder: oui - import EDL via 7.4.9
      required: false
  - type: input
    id: expected_size
    attributes:
      label: Taille estimée / contrainte (approx. nombre d'IP attendu)
      description: Permet d'évaluer l'impact sur les tables et le sharding
      placeholder: ex: ~50k / liste splittée
      required: false
  - type: textarea
    id: privacy_note
    attributes:
      label: Données personnelles / confidentialité (si applicable)
      description: Indiquez si vous joignez des logs ou données sensibles (anonymisez-les)
      required: false
  - type: dropdown
    id: contribution
    attributes:
      label: Souhaitez-vous contribuer à l'intégration (ex: fournir un snippet / tester) ?
      options:
        - "Oui - je peux aider"
        - "Non - merci"
        - "Peut-être"
      required: true
  - type: input
    id: contact
    attributes:
      label: Contact (GitHub / email) si besoin de précision
      placeholder: @mon-compte-github
      required: false
  - type: textarea
    id: additional
    attributes:
      label: Informations additionnelles (facultatif)
      description: Tout autre détail utile (compatibilité firmware, version, notes particulières)
      required: false
