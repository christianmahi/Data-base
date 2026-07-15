-- ===========================================
-- Base de données : FitTrack
-- Script de création des tables
-- ===========================================

-- Supprime les anciennes tables si elles existent

DROP TABLE IF EXISTS seance_exercice;
DROP TABLE IF EXISTS programme_exercice;
DROP TABLE IF EXISTS equipement;
DROP TABLE IF EXISTS exercice;
DROP TABLE IF EXISTS groupe_musculaire;
DROP TABLE IF EXISTS programme;
DROP TABLE IF EXISTS salle;

DROP TABLE IF EXISTS paiement;
DROP TABLE IF EXISTS seance;
DROP TABLE IF EXISTS membre;
DROP TABLE IF EXISTS coach;
DROP TABLE IF EXISTS abonnement;


-- =====================
-- TABLE : Abonnement
-- =====================

CREATE TABLE abonnement (
    id_abonnement SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(8,2) NOT NULL,
    duree_mois INTEGER NOT NULL,
    description TEXT,

    CONSTRAINT chk_abonnement_prix
        CHECK (prix >= 0),

    CONSTRAINT chk_abonnement_duree
        CHECK (duree_mois > 0)
);


-- =====================
-- TABLE : Coach
-- =====================

CREATE TABLE coach (
    id_coach SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    telephone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    specialite VARCHAR(100),
    date_embauche DATE
);


-- =====================
-- TABLE : Membre
-- =====================

CREATE TABLE membre (
    id_membre SERIAL PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prenom VARCHAR(50) NOT NULL,
    sexe VARCHAR(20),
    date_naissance DATE,
    telephone VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    adresse VARCHAR(150),
    ville VARCHAR(100),
    code_postal VARCHAR(20),
    date_inscription DATE NOT NULL DEFAULT CURRENT_DATE,

    id_abonnement INTEGER NOT NULL,
    id_coach INTEGER,

    CONSTRAINT fk_membre_abonnement
        FOREIGN KEY (id_abonnement)
        REFERENCES abonnement(id_abonnement),

    CONSTRAINT fk_membre_coach
        FOREIGN KEY (id_coach)
        REFERENCES coach(id_coach)
        ON DELETE SET NULL
);


-- =====================
-- TABLE : Paiement
-- =====================

CREATE TABLE paiement (
    id_paiement SERIAL PRIMARY KEY,
    date_paiement DATE NOT NULL DEFAULT CURRENT_DATE,
    montant DECIMAL(8,2) NOT NULL,
    mode_paiement VARCHAR(30),
    id_membre INTEGER NOT NULL,

    CONSTRAINT chk_paiement_montant
        CHECK (montant > 0),

    CONSTRAINT fk_paiement_membre
        FOREIGN KEY (id_membre)
        REFERENCES membre(id_membre)
        ON DELETE CASCADE
);


-- =====================
-- TABLE : Seance
-- Une séance représente une visite à la salle
-- =====================

CREATE TABLE seance (
    id_seance SERIAL PRIMARY KEY,
    id_membre INTEGER NOT NULL,
    date_seance DATE NOT NULL DEFAULT CURRENT_DATE,
    heure_entree TIME NOT NULL,
    heure_sortie TIME,

    CONSTRAINT fk_seance_membre
        FOREIGN KEY (id_membre)
        REFERENCES membre(id_membre)
        ON DELETE CASCADE,

    CONSTRAINT chk_seance_heures
        CHECK (
            heure_sortie IS NULL
            OR heure_sortie > heure_entree
        )
);
