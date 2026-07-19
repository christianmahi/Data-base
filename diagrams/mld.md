# MLD — FitTrack

Le modèle logique de données de FitTrack contient cinq relations :

- `ABONNEMENT`
- `COACH`
- `MEMBRE`
- `PAIEMENT`
- `SEANCE`

## ABONNEMENT

```text
ABONNEMENT
-----------
id_abonnement (PK)
nom
prix
duree_mois
description
```

- Clé primaire : `id_abonnement`
- Le nom de l'abonnement est unique.
- Le prix doit être positif ou égal à zéro.
- La durée doit être supérieure à zéro.

---

## COACH

```text
COACH
------
id_coach (PK)
nom
prenom
telephone
email
specialite
date_embauche
```

- Clé primaire : `id_coach`
- L'adresse électronique du coach est unique.

---

## MEMBRE

```text
MEMBRE
-------
id_membre (PK)
nom
prenom
sexe
date_naissance
telephone
email
adresse
ville
code_postal
date_inscription
id_abonnement (FK, NOT NULL)
id_coach (FK, NULL autorisé)
```

- Clé primaire : `id_membre`
- Clé étrangère : `id_abonnement` référence `ABONNEMENT(id_abonnement)`
- Clé étrangère : `id_coach` référence `COACH(id_coach)`
- L'adresse électronique du membre est unique.
- `id_abonnement` est obligatoire.
- `id_coach` est facultatif.
- Si un coach est supprimé, la valeur `id_coach` du membre devient `NULL`.

---

## PAIEMENT

```text
PAIEMENT
---------
id_paiement (PK)
date_paiement
montant
mode_paiement
id_membre (FK, NOT NULL)
```

- Clé primaire : `id_paiement`
- Clé étrangère : `id_membre` référence `MEMBRE(id_membre)`
- Le montant doit être strictement supérieur à zéro.
- Si un membre est supprimé, ses paiements sont également supprimés.

---

## SEANCE

```text
SEANCE
-------
id_seance (PK)
id_membre (FK, NOT NULL)
date_seance
heure_entree
heure_sortie
```

- Clé primaire : `id_seance`
- Clé étrangère : `id_membre` référence `MEMBRE(id_membre)`
- Une séance représente une visite dans la salle de sport.
- L'heure d'entrée est obligatoire.
- L'heure de sortie peut être absente lorsqu'un membre est encore présent.
- Lorsqu'elle est renseignée, l'heure de sortie doit être postérieure à l'heure d'entrée.
- Si un membre est supprimé, ses séances sont également supprimées.

---

# Écriture relationnelle synthétique

```text
ABONNEMENT(
    #id_abonnement,
    nom,
    prix,
    duree_mois,
    description
)

COACH(
    #id_coach,
    nom,
    prenom,
    telephone,
    email,
    specialite,
    date_embauche
)

MEMBRE(
    #id_membre,
    nom,
    prenom,
    sexe,
    date_naissance,
    telephone,
    email,
    adresse,
    ville,
    code_postal,
    date_inscription,
    id_abonnement*,
    id_coach*
)

PAIEMENT(
    #id_paiement,
    date_paiement,
    montant,
    mode_paiement,
    id_membre*
)

SEANCE(
    #id_seance,
    id_membre*,
    date_seance,
    heure_entree,
    heure_sortie
)
```

Dans cette représentation :

- `#` indique une clé primaire ;
- `*` indique une clé étrangère ;
- `id_coach` est une clé étrangère facultative ;
- les autres clés étrangères sont obligatoires.

# Références entre les relations

```text
MEMBRE.id_abonnement
    → ABONNEMENT.id_abonnement

MEMBRE.id_coach
    → COACH.id_coach

PAIEMENT.id_membre
    → MEMBRE.id_membre

SEANCE.id_membre
    → MEMBRE.id_membre
```

