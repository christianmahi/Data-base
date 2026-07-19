# Présentation du projet FitTrack

## 1. Présentation générale

FitTrack est un projet de base de données relationnelle permettant de gérer l'activité d'une salle de sport.

Le projet a été réalisé dans le cadre d'un portfolio de niveau Licence 3 Informatique. Son objectif est de mettre en pratique les principales compétences liées à la conception et à l'utilisation d'une base de données PostgreSQL.

Le projet se concentre uniquement sur la base de données et le langage SQL. Une interface utilisateur pourra éventuellement être développée plus tard.

## 2. Objectifs du projet

FitTrack permet de gérer :

- les membres inscrits dans la salle de sport ;
- les coachs ;
- les différentes formules d'abonnement ;
- les paiements effectués par les membres ;
- les visites des membres dans la salle.

Le projet doit rester :

- simple à comprendre ;
- réaliste ;
- correctement modélisé ;
- facile à présenter pendant un entretien ou devant un professeur ;
- suffisamment complet pour démontrer des compétences en PostgreSQL et en SQL.

## 3. Technologies et outils utilisés

Les technologies et outils utilisés sont :

- PostgreSQL pour la base de données relationnelle ;
- SQL pour la création, la manipulation et l'interrogation des données ;
- DBeaver pour administrer et consulter la base de données ;
- Neon pour héberger la base PostgreSQL ;
- Mockaroo pour générer une première version des données fictives ;
- CSV pour importer des données dans les tables ;
- Markdown pour documenter le projet.

## 4. Périmètre fonctionnel

FitTrack contient cinq entités principales :

1. Membre
2. Coach
3. Abonnement
4. Paiement
5. Séance

### Membre

La table `membre` contient les informations personnelles et administratives des personnes inscrites dans la salle.

Chaque membre possède obligatoirement un abonnement.

Un membre peut également être suivi par un coach, mais cette relation reste facultative.

### Coach

La table `coach` contient les informations concernant les coachs employés par la salle.

Un coach possède une spécialité et peut suivre plusieurs membres.

### Abonnement

La table `abonnement` contient les différentes formules proposées par la salle.

Chaque abonnement possède :

- un nom ;
- un prix ;
- une durée en mois ;
- une description.

Les abonnements utilisés dans le projet sont inspirés de formules de salles de sport existantes.

### Paiement

La table `paiement` enregistre les transactions réalisées par les membres.

Chaque paiement possède :

- une date ;
- un montant ;
- un mode de paiement ;
- un membre associé.

### Séance

La table `seance` représente une visite d'un membre dans la salle de sport.

Chaque séance contient :

- le membre concerné ;
- la date de la visite ;
- l'heure d'entrée ;
- l'heure de sortie.

Le nombre de visites n'est pas stocké directement dans la table `membre`. Il est calculé à partir des lignes présentes dans la table `seance`.

## 5. Relations entre les entités

Les principales relations du projet sont les suivantes :

- un membre possède exactement un abonnement ;
- un abonnement peut être possédé par plusieurs membres ;
- un membre peut être suivi par un coach ;
- un coach peut suivre plusieurs membres ;
- un membre peut effectuer plusieurs paiements ;
- un paiement appartient à un seul membre ;
- un membre peut effectuer plusieurs séances ;
- une séance appartient à un seul membre.

## 6. Cardinalités

```text
ABONNEMENT (0,N) ← MEMBRE (1,1)

COACH (0,N) ← MEMBRE (0,1)

MEMBRE (0,N) ← PAIEMENT (1,1)

MEMBRE (0,N) ← SEANCE (1,1)
```

## 7. Contraintes d'intégrité

Plusieurs contraintes ont été ajoutées afin de garantir la cohérence des données.

### Clés primaires

Chaque table possède une clé primaire :

- `abonnement.id_abonnement`
- `coach.id_coach`
- `membre.id_membre`
- `paiement.id_paiement`
- `seance.id_seance`

### Clés étrangères

Les clés étrangères sont :

- `membre.id_abonnement` vers `abonnement.id_abonnement` ;
- `membre.id_coach` vers `coach.id_coach` ;
- `paiement.id_membre` vers `membre.id_membre` ;
- `seance.id_membre` vers `membre.id_membre`.

### Contraintes supplémentaires

Le projet utilise également les contraintes suivantes :

- le nom d'un abonnement doit être unique ;
- l'adresse électronique d'un membre doit être unique ;
- l'adresse électronique d'un coach doit être unique ;
- le prix d'un abonnement ne peut pas être négatif ;
- la durée d'un abonnement doit être supérieure à zéro ;
- le montant d'un paiement doit être strictement positif ;
- l'heure de sortie doit être postérieure à l'heure d'entrée ;
- un membre doit obligatoirement posséder un abonnement ;
- le coach d'un membre reste facultatif.

## 8. Gestion des suppressions

La base utilise plusieurs règles de suppression.

### Suppression d'un coach

Si un coach est supprimé, les membres suivis par ce coach sont conservés.

La valeur `id_coach` de ces membres devient `NULL` grâce à :

```sql
ON DELETE SET NULL
```

### Suppression d'un membre

Si un membre est supprimé, ses paiements et ses séances sont également supprimés grâce à :

```sql
ON DELETE CASCADE
```

Cela évite de conserver des paiements ou des visites sans membre associé.

## 9. Données utilisées

La base contient actuellement :

- 4 abonnements ;
- 12 coachs ;
- 200 membres ;
- 1 332 paiements ;
- 6 489 séances.

Les données des coachs et des membres ont été générées initialement avec Mockaroo, puis nettoyées avant leur importation.

Les principales modifications apportées aux données sont :

- correction des noms des colonnes ;
- conversion des dates au format PostgreSQL ;
- ajout de dates de naissance réalistes ;
- ajout des clés étrangères ;
- attribution d'un abonnement à chaque membre ;
- attribution facultative d'un coach ;
- création de paiements mensuels ;
- création de visites cohérentes avec les dates d'inscription.

## 10. Requêtes SQL réalisées

Le fichier `database/queries.sql` contient différentes catégories de requêtes.

### Requêtes sur les membres

Les requêtes permettent notamment de :

- afficher tous les membres ;
- compter le nombre total de membres ;
- afficher l'abonnement de chaque membre ;
- compter les membres par abonnement ;
- afficher le coach de chaque membre ;
- identifier les membres sans coach ;
- compter les membres suivis par chaque coach.

### Requêtes sur les paiements

Les requêtes permettent notamment de :

- afficher l'historique des paiements ;
- afficher les paiements avec les informations du membre ;
- compter les paiements ;
- calculer le montant total encaissé ;
- calculer le montant total payé par membre ;
- calculer les revenus mensuels ;
- regrouper les paiements par mode de paiement ;
- afficher les paiements les plus récents.

### Requêtes sur les visites

Les requêtes permettent notamment de :

- afficher les visites des membres ;
- compter le nombre total de visites ;
- compter les visites d'un membre ;
- compter les visites de la semaine ;
- compter les visites du mois ;
- afficher la dernière visite de chaque membre ;
- classer les membres les plus assidus ;
- identifier les membres sans visite ;
- construire un calendrier de présence ;
- calculer la durée de chaque visite ;
- calculer la durée moyenne des visites ;
- compter les visites par jour et par mois ;
- identifier le jour le plus fréquenté.

## 11. Exemple de calcul du nombre de visites

Le nombre de visites n'est pas enregistré dans la table `membre`.

Il est calculé avec une requête utilisant la table `seance` :

```sql
SELECT COUNT(*) AS nombre_visites
FROM seance
WHERE id_membre = 1;
```

Cette méthode évite la duplication des informations et garantit que le résultat reste toujours cohérent avec les séances enregistrées.

## 12. Exemple de classement des membres assidus

La requête suivante permet d'afficher les dix membres ayant effectué le plus de visites :

```sql
SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    COUNT(s.id_seance) AS nombre_visites
FROM membre m
JOIN seance s
    ON s.id_membre = m.id_membre
GROUP BY
    m.id_membre,
    m.nom,
    m.prenom
ORDER BY nombre_visites DESC
LIMIT 10;
```

## 13. Organisation du projet

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

## 14. Compétences démontrées

Ce projet permet de démontrer les compétences suivantes :

- analyse d'un besoin ;
- définition de règles de gestion ;
- conception d'un modèle conceptuel de données ;
- transformation d'un MCD en modèle logique ;
- création de tables PostgreSQL ;
- utilisation de clés primaires et étrangères ;
- mise en place de contraintes d'intégrité ;
- utilisation de `CHECK`, `UNIQUE`, `NOT NULL` et `DEFAULT` ;
- utilisation de `ON DELETE SET NULL` et `ON DELETE CASCADE` ;
- importation de données CSV ;
- nettoyage et préparation de données ;
- utilisation de jointures SQL ;
- utilisation de fonctions d'agrégation ;
- regroupement de résultats avec `GROUP BY` ;
- filtrage de données ;
- gestion des dates et des heures ;
- calcul de statistiques à partir de données relationnelles ;
- documentation d'un projet informatique.

## 15. Améliorations possibles

Plusieurs améliorations pourront être apportées ultérieurement :

- développer une interface utilisateur avec React ;
- permettre aux membres de consulter leurs visites ;
- afficher un calendrier de présence ;
- afficher des graphiques de fréquentation ;
- gérer l'authentification ;
- gérer le renouvellement ou la résiliation des abonnements ;
- ajouter le statut des paiements ;
- ajouter une date de début et de fin d'abonnement ;
- ajouter plusieurs salles de sport si le projet évolue vers une gestion multi-clubs.

Ces améliorations ne font pas partie de la première version du projet afin de conserver une architecture simple et adaptée au niveau Licence 3.

## 16. Conclusion

FitTrack est un projet relationnel simple, réaliste et complet.

La base de données permet de gérer les principales informations d'une salle de sport tout en respectant les règles de cohérence entre les données.

Le projet met particulièrement en valeur la conception relationnelle, les contraintes d'intégrité, les jointures, les agrégations et la manipulation des dates avec PostgreSQL.