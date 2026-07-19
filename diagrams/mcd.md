# MCD — FitTrack

Le modèle conceptuel de données de FitTrack comporte cinq entités :

- Membre
- Coach
- Abonnement
- Paiement
- Séance

## Membre ↔ Abonnement

Un membre possède obligatoirement un seul abonnement.

Un abonnement peut être associé à plusieurs membres, mais il peut également n'être associé à aucun membre.

### Cardinalités

```text
Membre (1,1) -------- possède -------- (0,N) Abonnement
```

---

## Coach ↔ Membre

Un coach peut suivre plusieurs membres, mais peut également ne suivre aucun membre.

Un membre peut être suivi par un seul coach au maximum. Le suivi par un coach n'est pas obligatoire.

### Cardinalités

```text
Coach (0,N) -------- suit -------- (0,1) Membre
```

---

## Membre ↔ Paiement

Un membre peut effectuer plusieurs paiements, mais peut également ne pas avoir encore effectué de paiement.

Un paiement est obligatoirement effectué par un seul membre.

### Cardinalités

```text
Membre (0,N) -------- effectue -------- (1,1) Paiement
```

---

## Membre ↔ Séance

Un membre peut effectuer plusieurs séances, mais peut également n'effectuer aucune séance.

Une séance correspond obligatoirement à un seul membre.

Dans FitTrack, une séance représente une visite à la salle avec une date, une heure d'entrée et une heure de sortie.

### Cardinalités

```text
Membre (0,N) -------- effectue -------- (1,1) Séance
```

---

# Vue d'ensemble du MCD

```text
ABONNEMENT (0,N)
       |
    possède
       |
     (1,1)
     MEMBRE
     /   \
    /     \
(0,1)     (0,N)
  |          |
suivi par  effectue
  |          |
(0,N)      (1,1)
 COACH     PAIEMENT


MEMBRE (0,N)
       |
    effectue
       |
     (1,1)
     SÉANCE
```

# Règles de gestion

1. Un membre doit obligatoirement posséder un abonnement.
2. Un abonnement peut être attribué à plusieurs membres.
3. Un abonnement peut ne pas être encore attribué à un membre.
4. Un membre peut être suivi par un coach.
5. Un membre peut ne pas avoir de coach.
6. Un coach peut suivre plusieurs membres.
7. Un coach peut ne suivre aucun membre.
8. Un membre peut effectuer plusieurs paiements.
9. Un membre peut ne pas avoir encore effectué de paiement.
10. Chaque paiement appartient obligatoirement à un seul membre.
11. Un membre peut effectuer plusieurs visites dans la salle.
12. Un membre peut n'avoir effectué aucune visite.
13. Chaque séance appartient obligatoirement à un seul membre.
14. Une séance contient une date, une heure d'entrée et éventuellement une heure de sortie.