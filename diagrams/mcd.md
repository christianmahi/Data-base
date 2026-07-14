# MCD - FitTrack

## Membre ↔ Abonnement

Un membre possède un abonnement.

Cardinalités :

Membre (1,1) -------- possède -------- (0,N) Abonnement

---

## Membre ↔ Paiement

Un membre effectue plusieurs paiements.

Cardinalités :

Membre (1,N) -------- effectue -------- (1,1) Paiement

---

## Coach ↔ Membre

Un coach suit plusieurs membres.

Un membre peut avoir un coach.

Cardinalités :

Coach (0,N) -------- suit -------- (0,1) Membre

---

## Membre ↔ Séance

Un membre réalise plusieurs séances.

Cardinalités :

Membre (1,N) -------- réalise -------- (1,1) Séance

---

## Séance ↔ Exercice

Une séance contient plusieurs exercices.

Un exercice peut être réalisé dans plusieurs séances.

Cardinalités :

Séance (1,N) -------- contient -------- (1,N) Exercice

---

## Programme ↔ Exercice

Un programme contient plusieurs exercices.

Un exercice peut appartenir à plusieurs programmes.

Cardinalités :

Programme (1,N) -------- contient -------- (1,N) Exercice

---

## Groupe Musculaire ↔ Exercice

Un groupe musculaire possède plusieurs exercices.

Chaque exercice cible un groupe musculaire.

Cardinalités :

Groupe_Musculaire (1,N) -------- cible -------- (1,1) Exercice

---

## Salle ↔ Équipement

Une salle contient plusieurs équipements.

Chaque équipement appartient à une salle.

Cardinalités :

Salle (1,N) -------- contient -------- (1,1) Équipement

---

## Salle ↔ Séance

Une salle accueille plusieurs séances.

Chaque séance se déroule dans une salle.

Cardinalités :

Salle (1,N) -------- accueille -------- (1,1) Séance