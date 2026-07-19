# Entités du projet FitTrack

FitTrack est une base de données permettant de gérer les membres, les coachs, les abonnements, les paiements et les visites d'une salle de sport.

## Membre

Le membre représente une personne inscrite à la salle de sport.

### Attributs

- `id_membre` : identifiant unique du membre ;
- `nom` : nom du membre ;
- `prenom` : prénom du membre ;
- `sexe` : sexe du membre ;
- `date_naissance` : date de naissance du membre ;
- `telephone` : numéro de téléphone du membre ;
- `email` : adresse électronique du membre ;
- `adresse` : adresse postale du membre ;
- `ville` : ville de résidence du membre ;
- `code_postal` : code postal du membre ;
- `date_inscription` : date d'inscription à la salle ;
- `id_abonnement` : abonnement du membre ;
- `id_coach` : coach qui suit éventuellement le membre.

## Coach

Le coach représente un employé chargé d'accompagner les membres dans leur pratique sportive.

### Attributs

- `id_coach` : identifiant unique du coach ;
- `nom` : nom du coach ;
- `prenom` : prénom du coach ;
- `telephone` : numéro de téléphone du coach ;
- `email` : adresse électronique du coach ;
- `specialite` : spécialité sportive du coach ;
- `date_embauche` : date d'embauche du coach.

## Abonnement

L'abonnement représente une formule donnant accès aux services de la salle de sport.

### Attributs

- `id_abonnement` : identifiant unique de l'abonnement ;
- `nom` : nom de la formule ;
- `prix` : prix mensuel de la formule ;
- `duree_mois` : durée de l'engagement en mois ;
- `description` : description des services inclus.

## Paiement

Le paiement représente une transaction effectuée par un membre.

### Attributs

- `id_paiement` : identifiant unique du paiement ;
- `date_paiement` : date du paiement ;
- `montant` : montant payé ;
- `mode_paiement` : moyen de paiement utilisé ;
- `id_membre` : membre ayant effectué le paiement.

## Séance

La séance représente une visite d'un membre dans la salle de sport.

### Attributs

- `id_seance` : identifiant unique de la séance ;
- `id_membre` : membre ayant effectué la visite ;
- `date_seance` : date de la visite ;
- `heure_entree` : heure d'entrée dans la salle ;
- `heure_sortie` : heure de sortie de la salle.

# Relations entre les entités

- Un abonnement peut être possédé par plusieurs membres.
- Un membre possède exactement un abonnement.
- Un coach peut suivre plusieurs membres.
- Un membre peut être suivi par un seul coach.
- Un membre peut ne pas avoir de coach.
- Un membre peut effectuer plusieurs paiements.
- Un paiement appartient à un seul membre.
- Un membre peut effectuer plusieurs séances.
- Une séance appartient à un seul membre.

# Cardinalités principales

- `Abonnement (0,N) — possède — Membre (1,1)`
- `Coach (0,N) — suit — Membre (0,1)`
- `Membre (0,N) — effectue — Paiement (1,1)`
- `Membre (0,N) — effectue — Séance (1,1)`