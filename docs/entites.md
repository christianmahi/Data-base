# Entités du projet FitTrack

## Membre
Personne inscrite à la salle de sport.

## Coach
Employé chargé d'accompagner les membres.

## Abonnement
Formule donnant accès aux services de la salle.

## Paiement
Transaction effectuée par un membre pour son abonnement.

## Programme
Ensemble d'exercices conçus pour atteindre un objectif (prise de masse, perte de poids, etc.).

## Exercice
Mouvement réalisable lors d'une séance.

## Groupe_Musculaire
Zone du corps principalement sollicitée par un exercice.

## Séance
Entraînement réalisé par un membre à une date donnée.

## Séance_Exercice
Association entre une séance et les exercices réalisés.

## Équipement
Machine ou matériel disponible dans la salle.

## Salle
Zone ou espace de la salle de sport (musculation, cardio, cours collectifs...).


# Relations

- Un membre possède un abonnement.
- Un membre effectue plusieurs séances.
- Un membre peut être suivi par un coach.
- Un coach peut suivre plusieurs membres.
- Un membre effectue plusieurs paiements.
- Un programme contient plusieurs exercices.
- Un exercice peut appartenir à plusieurs programmes.
- Un exercice cible un groupe musculaire.
- Une séance contient plusieurs exercices.
- Une salle contient plusieurs équipements.
- Une séance se déroule dans une salle.