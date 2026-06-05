-- ═══════════════════════════════════════════════════════════════
--  ScriptSql_fixed.sql  –  Forage Web (version corrigée)
-- ═══════════════════════════════════════════════════════════════

DROP DATABASE IF EXISTS Forage;
CREATE DATABASE Forage CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE Forage;

-- ── Clients ─────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS client (
    id_client        INT AUTO_INCREMENT PRIMARY KEY,
    nom_client       VARCHAR(100) NOT NULL,
    telephone_client VARCHAR(20)
);

-- ── Géographie ──────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS region (
    id_region  INT AUTO_INCREMENT PRIMARY KEY,
    nom_region VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS district (
    id_district  INT AUTO_INCREMENT PRIMARY KEY,
    id_region    INT NOT NULL,
    nom_district VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE IF NOT EXISTS commune (
    id_commune  INT AUTO_INCREMENT PRIMARY KEY,
    id_district INT NOT NULL,
    nom_commune VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_district) REFERENCES district(id_district)
);

-- ── Status ──────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS status (
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    libelle   VARCHAR(100) NOT NULL
);

-- ── Paramètres couleur ──────────────────────────────────────────
CREATE TABLE IF NOT EXISTS parametre (
    id_parametre INT AUTO_INCREMENT PRIMARY KEY,
    id_status1   INT          NOT NULL,
    id_status2   INT          NOT NULL,
    duree        BIGINT       NOT NULL,   -- seuil MAX en minutes
    couleur      VARCHAR(20)  NOT NULL,
    FOREIGN KEY (id_status1) REFERENCES status(id_status),
    FOREIGN KEY (id_status2) REFERENCES status(id_status)
);

-- ── Demandes ────────────────────────────────────────────────────
-- CORRECTION : date_demande passe de DATETIME → DATE (cohérent avec LocalDate en Java)
CREATE TABLE IF NOT EXISTS demande (
    id_demande   INT AUTO_INCREMENT PRIMARY KEY,
    ref_demande  VARCHAR(50)  UNIQUE,
    id_client    INT,
    date_demande DATE,
    lieu_demande VARCHAR(100),
    id_commune   INT,
    FOREIGN KEY (id_client)  REFERENCES client(id_client),
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune)
);

-- ── Statuts des demandes ─────────────────────────────────────────
-- CORRECTION : PK allégée → on ajoute une colonne séquentielle
--              pour autoriser plusieurs passages par le même statut
CREATE TABLE IF NOT EXISTS demande_status (
    id           INT AUTO_INCREMENT PRIMARY KEY,   -- ← nouvelle PK séquentielle
    id_demande   INT      NOT NULL,
    id_status    INT      NOT NULL,
    observation  VARCHAR(255),
    date_status  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_demande) REFERENCES demande(id_demande) ON DELETE CASCADE,
    FOREIGN KEY (id_status)  REFERENCES status(id_status)
);

-- ── Types de devis ───────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS type_devis (
    id_type_devis INT AUTO_INCREMENT PRIMARY KEY,
    libelle       VARCHAR(100) NOT NULL
);

-- ── Devis ────────────────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS devis (
    id_devis      INT  AUTO_INCREMENT PRIMARY KEY,
    id_demande    INT  NOT NULL,
    date_devis    DATE NOT NULL,
    observation   VARCHAR(255),
    id_type_devis INT  NOT NULL,
    FOREIGN KEY (id_type_devis) REFERENCES type_devis(id_type_devis),
    FOREIGN KEY (id_demande)    REFERENCES demande(id_demande)
);

-- ── Détails devis ────────────────────────────────────────────────
-- CORRECTION : ajout des colonnes unite, description et montant GENERATED
CREATE TABLE IF NOT EXISTS detail_devis (
    id_detail     INT AUTO_INCREMENT PRIMARY KEY,
    id_devis      INT            NOT NULL,
    libelle       VARCHAR(100)   NOT NULL,
    unite         VARCHAR(30),
    quantite      DECIMAL(10,2)  NOT NULL DEFAULT 1,
    prix_unitaire DECIMAL(15,2)  NOT NULL DEFAULT 0,
    description   VARCHAR(255),
    montant       DECIMAL(18,2)  GENERATED ALWAYS AS (quantite * prix_unitaire) STORED,
    FOREIGN KEY (id_devis) REFERENCES devis(id_devis) ON DELETE CASCADE
);

-- ════════════════════════════════════════════════════════════════
--  DONNÉES DE RÉFÉRENCE
-- ════════════════════════════════════════════════════════════════

INSERT INTO status (id_status, libelle) VALUES
  (1, 'Demande Créée'),
  (2, 'Demande Acceptée'),     -- CORRECTION : était id=3 dans le code Java
  (3, 'Devis Étude Créé'),
  (4, 'Devis Étude Refusé'),
  (5, 'Devis Forage Créé'),
  (6, 'Devis Forage Refusé');
-- Paramètres couleur (basés uniquement sur la durée travaillée)
-- Logique : 100-149 min = vert, 150-199 = jaune, 200+ = rouge
INSERT INTO parametre (id_status1, id_status2, duree, couleur) VALUES
  (1,2,0,'bleu'),
  (1, 2, 100,  'vert'),
  (1, 2,150,  'jaune'),
  (1, 2, 200,'rouge');

INSERT INTO type_devis (libelle) VALUES ('Étude'), ('Forage');

INSERT INTO region (nom_region) VALUES
  ('Analamanga'),('Vakinankaratra'),('Itasy'),('Bongolava'),
  ('Haute Matsiatra'),('Amoroni Mania'),('Vatovavy Fitovinany'),
  ('Ihorombe'),('Atsimo Atsinanana'),('Atsinanana'),
  ('Analanjirofo'),('Alaotra Mangoro'),('Boeny'),('Sofia'),
  ('Betsiboka'),('Melaky'),('Atsimo Andrefana'),('Androy'),
  ('Anosy'),('Menabe'),('Diana'),('Sava');

INSERT INTO district (id_region, nom_district) VALUES
  (1,'Antananarivo Atsimondrano'),(1,'Antananarivo Avaradrano'),
  (1,'Antananarivo Renivohitra'),(1,'Ambohidratrimo'),
  (1,'Ankazobe'),(1,'Andramasina'),
  (10,'Toamasina I'),(10,'Toamasina II'),(10,'Brickaville'),
  (10,'Fénérive Est'),(10,'Mahanoro'),(10,'Marolambo'),(10,'Vatomandry'),
  (21,'Antsiranana I'),(21,'Antsiranana II'),(21,'Ambanja'),
  (21,'Ambilobe'),(21,'Nosy Be');

INSERT INTO commune (id_district, nom_commune) VALUES
  (3,'Antananarivo Renivohitra'),
  (4,'Ambohidratrimo'),(4,'Ivato'),(4,'Mahitsy'),(4,'Fieferana'),(4,'Anosiala'),
  (7,'Toamasina I'),
  (8,'Ambodirafia'),(8,'Ampisikina'),(8,'Mangarivotra'),
  (18,'Hellville'),(18,'Ampangorina'),(18,'Mahatsinjo'),
  (18,'Marodokana'),(18,'Dzamandzar');

INSERT INTO client (nom_client, telephone_client) VALUES
  ('John Doe',       '034 12 345 67'),
  ('Jane Smith',     '032 98 765 43'),
  ('Alice Johnson',  '033 45 678 90');