-- ===========================================
-- Base de données : FitTrack
-- Script de création des tables
-- ===========================================

-- =====================
-- TABLE : Coach
-- =====================

create table coach (
    id_coach serial primary key,
    nom varchar(50) not null,
    prenom varchar(50) not null,
    telephone varchar(20),
    email varchar(100) unique,
    specialite varchar(100),
    date_embauche date
);

-- =====================
-- TABLE : Abonnement
-- =====================

create table abonnement (
    id_abonnement serial primary key,
    nom varchar(50) not null,
    prix decimal(8,2) not null,
    duree_mois integer not null,
    description text
);

-- =====================
-- TABLE : Membre
-- =====================

create table membre (
    id_membre serial primary key,
    nom varchar(50) not null,
    prenom varchar(50) not null,
    sexe varchar(10),
    date_naissance date,
    telephone varchar(20),
    email varchar(100) unique,
    adresse varchar(150),
    ville varchar(100),
    code_postal varchar(10),
    date_inscription date not null,

    id_abonnement integer,
    id_coach integer,

    constraint fk_membre_abonnement
        foreign key (id_abonnement)
        references abonnement(id_abonnement),

    constraint fk_membre_coach
        foreign key (id_coach)
        references coach(id_coach)
);

-- =====================
-- TABLE : Paiement
-- =====================

create table paiement (
    id_paiement serial primary key,
    date_paiement date not null,
    montant decimal(8,2) not null,
    mode_paiement varchar(30),

    id_membre integer not null,

    constraint fk_paiement_membre
        foreign key (id_membre)
        references membre(id_membre)
);

-- =====================
-- TABLE : Groupe Musculaire
-- =====================

create table groupe_musculaire (
    id_groupe serial primary key,
    nom varchar(50) not null
);

-- =====================
-- TABLE : Exercice
-- =====================

create table exercice (
    id_exercice serial primary key,
    nom varchar(100) not null,
    description text,

    id_groupe integer not null,

    constraint fk_exercice_groupe
        foreign key (id_groupe)
        references groupe_musculaire(id_groupe)
);

-- =====================
-- TABLE : Programme
-- =====================

create table programme (
    id_programme serial primary key,
    nom varchar(100) not null,
    objectif varchar(100),
    niveau varchar(30),
    description text
);

-- =====================
-- TABLE : Salle
-- =====================

create table salle (
    id_salle serial primary key,
    nom varchar(100) not null,
    capacite integer
);

-- =====================
-- TABLE : Equipement
-- =====================

create table equipement (
    id_equipement serial primary key,
    nom varchar(100) not null,
    marque varchar(100),
    etat varchar(30),

    id_salle integer,

    constraint fk_equipement_salle
        foreign key (id_salle)
        references salle(id_salle)
);

-- =====================
-- TABLE : Seance
-- =====================

create table seance (
    id_seance serial primary key,
    date_seance date not null,
    duree_minutes integer,

    id_membre integer not null,
    id_salle integer not null,

    constraint fk_seance_membre
        foreign key (id_membre)
        references membre(id_membre),

    constraint fk_seance_salle
        foreign key (id_salle)
        references salle(id_salle)
);

-- =====================
-- TABLE : Programme_Exercice
-- =====================

create table programme_exercice (
    id_programme integer,
    id_exercice integer,
    ordre integer,

    primary key (id_programme, id_exercice),

    foreign key (id_programme)
        references programme(id_programme),

    foreign key (id_exercice)
        references exercice(id_exercice)
);

-- =====================
-- TABLE : Seance_Exercice
-- =====================

create table seance_exercice (
    id_seance integer,
    id_exercice integer,

    series integer,
    repetitions integer,
    poids decimal(6,2),

    primary key (id_seance, id_exercice),

    foreign key (id_seance)
        references seance(id_seance),

    foreign key (id_exercice)
        references exercice(id_exercice)
);