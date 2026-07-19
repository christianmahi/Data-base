# FitTrack

FitTrack est un projet de base de données relationnelle permettant de gérer l'activité d'une salle de sport.

Ce projet a été réalisé dans le cadre d'un portfolio de niveau Licence 3 Informatique afin de mettre en pratique la conception de bases de données, PostgreSQL et le langage SQL.

## Fonctionnalités

FitTrack permet de gérer :

- les membres inscrits ;
- les coachs ;
- les formules d'abonnement ;
- les paiements des membres ;
- les visites des membres dans la salle.

Le projet permet également de calculer :

- le nombre total de membres ;
- le nombre de membres par abonnement ;
- le nombre de membres suivis par chaque coach ;
- le montant total encaissé ;
- les revenus par mois ;
- le nombre de visites d'un membre ;
- les visites de la semaine ;
- les visites du mois ;
- la dernière visite d'un membre ;
- les membres les plus assidus ;
- la durée moyenne des visites ;
- les membres n'ayant effectué aucune visite.

## Technologies et outils

- PostgreSQL
- SQL
- DBeaver
- Neon
- Mockaroo
- CSV
- Markdown

DBeaver est utilisé pour administrer la base de données.

La base PostgreSQL est hébergée sur Neon.

## Modèle de données

Le projet contient cinq tables principales :

- `abonnement`
- `coach`
- `membre`
- `paiement`
- `seance`

### Relations

- Un membre possède obligatoirement un abonnement.
- Un abonnement peut être associé à plusieurs membres.
- Un membre peut être suivi par un coach.
- Un coach peut suivre plusieurs membres.
- Un membre peut effectuer plusieurs paiements.
- Un paiement appartient à un seul membre.
- Un membre peut effectuer plusieurs séances.
- Une séance appartient à un seul membre.

### Cardinalités

```text
ABONNEMENT (0,N) ← MEMBRE (1,1)

COACH (0,N) ← MEMBRE (0,1)

MEMBRE (0,N) ← PAIEMENT (1,1)

MEMBRE (0,N) ← SEANCE (1,1)
```

## Structure du projet

```text
FitTrack/
├── database/
│   ├── data/
│   │   ├── coachs.csv
│   │   ├── membres.csv
│   │   ├── paiements.csv
│   │   └── seances.csv
│   ├── create_tables.sql
│   ├── insert_data.sql
│   └── queries.sql
├── diagrams/
│   ├── entite.md
│   ├── mcd.md
│   └── mld.md
├── docs/
│   └── presentation.md
└── README.md
```

## Description des fichiers

### `database/create_tables.sql`

Ce fichier contient :

- la création des cinq tables ;
- les clés primaires ;
- les clés étrangères ;
- les contraintes `NOT NULL` ;
- les contraintes `UNIQUE` ;
- les contraintes `CHECK` ;
- les règles `ON DELETE CASCADE` ;
- la règle `ON DELETE SET NULL`.

### `database/insert_data.sql`

Ce fichier contient l'insertion des quatre formules d'abonnement.

### `database/queries.sql`

Ce fichier contient les requêtes SQL permettant d'interroger les membres, les coachs, les abonnements, les paiements et les séances.

### `database/data/`

Ce dossier contient les fichiers CSV utilisés pour importer les données.

### `diagrams/`

Ce dossier contient la documentation de la conception :

- la description des entités ;
- le modèle conceptuel de données ;
- le modèle logique de données.

### `docs/presentation.md`

Ce fichier contient une présentation détaillée du projet, des choix de conception et des compétences mises en œuvre.

## Données disponibles

La base contient :

- 4 abonnements ;
- 12 coachs ;
- 200 membres ;
- 1 332 paiements ;
- 6 489 séances.

Les données proviennent initialement de Mockaroo. Elles ont été nettoyées et adaptées avant leur importation dans PostgreSQL.

Les modifications ont notamment concerné :

- les noms des colonnes ;
- le format des dates ;
- les dates de naissance ;
- les spécialités des coachs ;
- les clés étrangères ;
- les abonnements attribués aux membres ;
- les coachs attribués aux membres ;
- les paiements mensuels ;
- les visites dans la salle.

## Installation de la base

### 1. Créer une base PostgreSQL

Créer une base de données PostgreSQL, localement ou avec un service d'hébergement comme Neon.

### 2. Exécuter le script de création

Exécuter le fichier suivant :

```text
database/create_tables.sql
```

