MEMBRE
-------
id_membre (PK)
nom
prenom
date_naissance
sexe
telephone
email
adresse
ville
code_postal
date_inscription
id_abonnement (FK)
id_coach (FK)

COACH
------
id_coach (PK)
nom
prenom
telephone
email
specialite
date_embauche

ABONNEMENT
-----------
id_abonnement (PK)
nom
prix
duree_mois
description

PAIEMENT
---------
id_paiement (PK)
date_paiement
montant
mode_paiement
id_membre (FK)

PROGRAMME
----------
id_programme (PK)
nom
objectif
niveau
description

EXERCICE
---------
id_exercice (PK)
nom
description
id_groupe (FK)

GROUPE_MUSCULAIRE
-----------------
id_groupe (PK)
nom

SEANCE
-------
id_seance (PK)
date_seance
duree_minutes
id_membre (FK)
id_salle (FK)

SEANCE_EXERCICE
----------------
id_seance (FK)
id_exercice (FK)
series
repetitions
poids

PROGRAMME_EXERCICE
-------------------
id_programme (FK)
id_exercice (FK)
ordre

SALLE
------
id_salle (PK)
nom
capacite

EQUIPEMENT
-----------
id_equipement (PK)
nom
marque
etat
id_salle (FK)