-- ===========================================
-- Base de données : FitTrack
-- Requêtes SQL
-- ===========================================

-- =====================
-- 1. AFFICHER TOUS LES MEMBRES
-- =====================

SELECT *
FROM membre
ORDER BY id_membre;

-- =====================
-- 2. AFFICHER LE NOMBRE TOTAL DE MEMBRES
-- =====================

SELECT COUNT(*) AS nombre_total_membres
FROM membre;

-- =====================
-- 3. AFFICHER LES MEMBRES AVEC LEUR ABONNEMENT
-- =====================

SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    m.email,
    a.nom AS abonnement,
    a.prix,
    a.duree_mois
FROM membre m
JOIN abonnement a
    ON m.id_abonnement = a.id_abonnement
ORDER BY m.nom, m.prenom;

-- =====================
-- 4. COMPTER LES MEMBRES PAR ABONNEMENT
-- =====================

SELECT
    a.id_abonnement,
    a.nom AS abonnement,
    COUNT(m.id_membre) AS nombre_membres
FROM abonnement a
LEFT JOIN membre m
    ON m.id_abonnement = a.id_abonnement
GROUP BY
    a.id_abonnement,
    a.nom
ORDER BY a.id_abonnement;

-- =====================
-- 5. AFFICHER LES MEMBRES AVEC LEUR COACH
-- =====================

SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    c.nom AS nom_coach,
    c.prenom AS prenom_coach,
    c.specialite
FROM membre m
LEFT JOIN coach c
    ON m.id_coach = c.id_coach
ORDER BY m.nom, m.prenom;

-- =====================
-- 6. AFFICHER LES MEMBRES SANS COACH
-- =====================

SELECT
    id_membre,
    nom,
    prenom,
    email
FROM membre
WHERE id_coach IS NULL
ORDER BY nom, prenom;

-- =====================
-- 7. COMPTER LES MEMBRES SANS COACH
-- =====================

SELECT COUNT(*) AS nombre_membres_sans_coach
FROM membre
WHERE id_coach IS NULL;

-- =====================
-- 8. COMPTER LES MEMBRES SUIVIS PAR CHAQUE COACH
-- =====================

SELECT
    c.id_coach,
    c.nom,
    c.prenom,
    c.specialite,
    COUNT(m.id_membre) AS nombre_membres_suivis
FROM coach c
LEFT JOIN membre m
    ON m.id_coach = c.id_coach
GROUP BY
    c.id_coach,
    c.nom,
    c.prenom,
    c.specialite
ORDER BY
    nombre_membres_suivis DESC,
    c.nom;

-- ===========================================
-- REQUÊTES SUR LES PAIEMENTS
-- ===========================================

-- =====================
-- 9. AFFICHER TOUS LES PAIEMENTS
-- =====================

SELECT *
FROM paiement
ORDER BY date_paiement DESC, id_paiement DESC;

-- =====================
-- 10. AFFICHER LES PAIEMENTS AVEC LE MEMBRE
-- =====================

SELECT
    p.id_paiement,
    p.date_paiement,
    p.montant,
    p.mode_paiement,
    m.id_membre,
    m.nom,
    m.prenom
FROM paiement p
JOIN membre m
    ON p.id_membre = m.id_membre
ORDER BY p.date_paiement DESC, p.id_paiement DESC;

-- =====================
-- 11. COMPTER LE NOMBRE TOTAL DE PAIEMENTS
-- =====================

SELECT COUNT(*) AS nombre_total_paiements
FROM paiement;

-- =====================
-- 12. CALCULER LE MONTANT TOTAL ENCAISSÉ
-- =====================

SELECT
    ROUND(SUM(montant), 2) AS montant_total_encaisse
FROM paiement;

-- =====================
-- 13. CALCULER LE TOTAL PAYÉ PAR MEMBRE
-- =====================

SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    COUNT(p.id_paiement) AS nombre_paiements,
    COALESCE(ROUND(SUM(p.montant), 2), 0) AS montant_total_paye
FROM membre m
LEFT JOIN paiement p
    ON p.id_membre = m.id_membre
GROUP BY
    m.id_membre,
    m.nom,
    m.prenom
ORDER BY montant_total_paye DESC;

-- =====================
-- 14. CALCULER LES REVENUS PAR MOIS
-- =====================

SELECT
    DATE_TRUNC('month', date_paiement)::DATE AS mois,
    COUNT(*) AS nombre_paiements,
    ROUND(SUM(montant), 2) AS revenu_mensuel
FROM paiement
GROUP BY DATE_TRUNC('month', date_paiement)
ORDER BY mois;

-- =====================
-- 15. COMPTER LES PAIEMENTS PAR MODE DE PAIEMENT
-- =====================

SELECT
    mode_paiement,
    COUNT(*) AS nombre_paiements,
    ROUND(SUM(montant), 2) AS montant_total
FROM paiement
GROUP BY mode_paiement
ORDER BY nombre_paiements DESC;

-- =====================
-- 16. AFFICHER LES 10 DERNIERS PAIEMENTS
-- =====================

SELECT
    p.id_paiement,
    p.date_paiement,
    p.montant,
    p.mode_paiement,
    m.nom,
    m.prenom
FROM paiement p
JOIN membre m
    ON p.id_membre = m.id_membre
ORDER BY
    p.date_paiement DESC,
    p.id_paiement DESC
LIMIT 10;

-- ===========================================
-- REQUÊTES SUR LES SÉANCES ET LES VISITES
-- ===========================================

-- =====================
-- 17. AFFICHER TOUTES LES SÉANCES
-- =====================

SELECT *
FROM seance
ORDER BY date_seance DESC, heure_entree DESC;

-- =====================
-- 18. AFFICHER LES SÉANCES AVEC LE MEMBRE
-- =====================

SELECT
    s.id_seance,
    s.date_seance,
    s.heure_entree,
    s.heure_sortie,
    m.id_membre,
    m.nom,
    m.prenom
FROM seance s
JOIN membre m
    ON s.id_membre = m.id_membre
ORDER BY
    s.date_seance DESC,
    s.heure_entree DESC;

-- =====================
-- 19. COMPTER LE NOMBRE TOTAL DE VISITES
-- =====================

SELECT COUNT(*) AS nombre_total_visites
FROM seance;

-- =====================
-- 20. COMPTER TOUTES LES VISITES D'UN MEMBRE
-- Exemple avec le membre numéro 1
-- =====================

SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    COUNT(s.id_seance) AS nombre_total_visites
FROM membre m
LEFT JOIN seance s
    ON s.id_membre = m.id_membre
WHERE m.id_membre = 1
GROUP BY
    m.id_membre,
    m.nom,
    m.prenom;

-- =====================
-- 21. COMPTER LES VISITES DE LA SEMAINE
-- Exemple avec le membre numéro 1
-- =====================

SELECT COUNT(*) AS visites_cette_semaine
FROM seance
WHERE id_membre = 1
  AND date_seance >= DATE_TRUNC('week', CURRENT_DATE)::DATE
  AND date_seance < (
      DATE_TRUNC('week', CURRENT_DATE) + INTERVAL '1 week'
  )::DATE;

-- =====================
-- 22. COMPTER LES VISITES DU MOIS
-- Exemple avec le membre numéro 1
-- =====================

SELECT COUNT(*) AS visites_ce_mois
FROM seance
WHERE id_membre = 1
  AND date_seance >= DATE_TRUNC('month', CURRENT_DATE)::DATE
  AND date_seance < (
      DATE_TRUNC('month', CURRENT_DATE) + INTERVAL '1 month'
  )::DATE;

-- =====================
-- 23. AFFICHER LA DERNIÈRE VISITE DE CHAQUE MEMBRE
-- =====================

SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    MAX(s.date_seance) AS derniere_visite
FROM membre m
LEFT JOIN seance s
    ON s.id_membre = m.id_membre
GROUP BY
    m.id_membre,
    m.nom,
    m.prenom
ORDER BY derniere_visite DESC NULLS LAST;

-- =====================
-- 24. AFFICHER LES 10 MEMBRES LES PLUS ASSIDUS
-- =====================

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
ORDER BY
    nombre_visites DESC,
    m.nom,
    m.prenom
LIMIT 10;

-- =====================
-- 25. AFFICHER LES MEMBRES SANS AUCUNE VISITE
-- =====================

SELECT
    m.id_membre,
    m.nom,
    m.prenom,
    m.email,
    m.date_inscription
FROM membre m
LEFT JOIN seance s
    ON s.id_membre = m.id_membre
WHERE s.id_seance IS NULL
ORDER BY m.nom, m.prenom;

-- =====================
-- 26. COMPTER LES MEMBRES SANS AUCUNE VISITE
-- =====================

SELECT COUNT(*) AS nombre_membres_sans_visite
FROM membre m
WHERE NOT EXISTS (
    SELECT 1
    FROM seance s
    WHERE s.id_membre = m.id_membre
);

-- =====================
-- 27. AFFICHER LE CALENDRIER DE PRÉSENCE D'UN MEMBRE
-- Exemple avec le membre numéro 1
-- =====================

SELECT
    date_seance AS jour_presence,
    MIN(heure_entree) AS premiere_entree,
    MAX(heure_sortie) AS derniere_sortie
FROM seance
WHERE id_membre = 1
GROUP BY date_seance
ORDER BY date_seance;

-- =====================
-- 28. CALCULER LA DURÉE DE CHAQUE VISITE
-- =====================

SELECT
    s.id_seance,
    m.nom,
    m.prenom,
    s.date_seance,
    s.heure_entree,
    s.heure_sortie,
    s.heure_sortie - s.heure_entree AS duree_visite
FROM seance s
JOIN membre m
    ON s.id_membre = m.id_membre
WHERE s.heure_sortie IS NOT NULL
ORDER BY s.date_seance DESC;

-- =====================
-- 29. CALCULER LA DURÉE MOYENNE DES VISITES
-- Résultat exprimé en minutes
-- =====================

SELECT
    ROUND(
        AVG(
            EXTRACT(EPOCH FROM (heure_sortie - heure_entree)) / 60
        ),
        2
    ) AS duree_moyenne_minutes
FROM seance
WHERE heure_sortie IS NOT NULL;

-- =====================
-- 30. COMPTER LES VISITES PAR JOUR
-- =====================

SELECT
    date_seance,
    COUNT(*) AS nombre_visites
FROM seance
GROUP BY date_seance
ORDER BY date_seance;

-- =====================
-- 31. COMPTER LES VISITES PAR MOIS
-- =====================

SELECT
    DATE_TRUNC('month', date_seance)::DATE AS mois,
    COUNT(*) AS nombre_visites
FROM seance
GROUP BY DATE_TRUNC('month', date_seance)
ORDER BY mois;

-- =====================
-- 32. AFFICHER LE JOUR LE PLUS FRÉQUENTÉ
-- =====================

SELECT
    date_seance,
    COUNT(*) AS nombre_visites
FROM seance
GROUP BY date_seance
ORDER BY nombre_visites DESC, date_seance DESC
LIMIT 1;