drop database if exists Forage;
CREATE DATABASE Forage;
use Forage;

CREATE TABLE IF NOT EXISTS client(
    id_client INT AUTO_INCREMENT PRIMARY KEY,
    nom_client VARCHAR(50),
    telephone_client VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS region(
    id_region INT AUTO_INCREMENT PRIMARY KEY,
    nom_region VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS district (
    id_district INT AUTO_INCREMENT PRIMARY KEY,
    id_region INT,
    nom_district VARCHAR(50),                             
    FOREIGN KEY (id_region) REFERENCES region(id_region)
);

CREATE TABLE IF NOT EXISTS commune (
    id_commune INT AUTO_INCREMENT PRIMARY KEY,
    id_district INT,
    nom_commune VARCHAR(50),
    FOREIGN KEY (id_district) REFERENCES district(id_district)
);

CREATE TABLE IF NOT EXISTS demande (
    id_demande INT AUTO_INCREMENT PRIMARY KEY,
    ref_demande VARCHAR(50),
    id_client INT,                                       
    date_demande DATETIME,
    lieu_demande VARCHAR(50),
    id_commune INT,                                        
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_commune) REFERENCES commune(id_commune)
);
CREATE TABLE IF NOT EXISTS status(
    id_status INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50)
);

CREATE TABLE IF NOT EXISTS parametre (
    id_parametre INT AUTO_INCREMENT PRIMARY KEY,
    id_status1 INT NOT NULL,
    id_status2 INT NOT NULL,
    duree BIGINT NOT NULL,
    couleur VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_status1) REFERENCES status(id_status),
    FOREIGN KEY (id_status2) REFERENCES status(id_status)
);

INSERT IGNORE INTO status (id_status, libelle) VALUES
  (1, 'Demande Cree'),
  (2, 'Demande Accepte'),
  (3, 'Demande Refuse'),
  (4, 'Devis Etude Cree'),
  (5, 'Devis Etude Refuse'),
  (6, 'Devis Forage Cree'),
  (7, 'Devis Forage Refuse');

INSERT IGNORE INTO parametre (id_parametre, id_status1, id_status2, duree, couleur) VALUES
  (1, 1, 2, 50, 'vert'),
  (2, 1, 2, 220, 'jaune'),
  (3, 1, 2, 350, 'rouge');

CREATE TABLE IF NOT EXISTS demande_status (
    id_demande INT,
    id_status INT,
    observation VARCHAR(100),
    date_status DATETIME,
    PRIMARY KEY (id_demande, id_status),
    FOREIGN KEY (id_demande) REFERENCES demande(id_demande),
    FOREIGN KEY (id_status) REFERENCES status(id_status)
);

 CREATE TABLE IF NOT EXISTS type_devis (
    id_type_devis INT AUTO_INCREMENT PRIMARY KEY,
    libelle VARCHAR(50) NOT NULL
);
insert into type_devis(libelle) values ('Etude'),('Forage');
CREATE TABLE IF NOT EXISTS devis (
    id_devis     INT AUTO_INCREMENT PRIMARY KEY,
    id_demande   INT          NOT NULL,
    date_devis   DATE         NOT NULL,
    observation varchar(255),
    id_type_devis  INT            NOT NULL,
    FOREIGN KEY (id_type_devis) REFERENCES type_devis(id_type_devis),
    FOREIGN KEY (id_demande) REFERENCES demande(id_demande)
);

CREATE TABLE IF NOT EXISTS detail_devis (
    id_detail      INT AUTO_INCREMENT PRIMARY KEY,
    id_devis       INT            NOT NULL,
    libelle        VARCHAR(100)   NOT NULL,
    quantite       DECIMAL(10,2)  NOT NULL DEFAULT 1,
    prix_unitaire  DECIMAL(15,2)  NOT NULL DEFAULT 0,
    FOREIGN KEY (id_devis) REFERENCES devis(id_devis) ON DELETE CASCADE
);
 
INSERT INTO region (nom_region) VALUES
  ('Analamanga'),
  ('Vakinankaratra'),
  ('Itasy'),
  ('Bongolava'),
  ('Haute Matsiatra'),
  ('Amoroni Mania'),
  ('Vatovavy Fitovinany'),
  ('Ihorombe'),
  ('Atsimo Atsinanana'),
  ('Atsinanana'),
  ('Analanjirofo'),
  ('Alaotra Mangoro'),
  ('Boeny'),
  ('Sofia'),
  ('Betsiboka'),
  ('Melaky'),
  ('Atsimo Andrefana'),
  ('Androy'),
  ('Anosy'),
  ('Menabe'),
  ('Diana'),
  ('Sava');



INSERT INTO district (id_region, nom_district) VALUES
  -- Analamanga (id_region = 1)
  (1, 'Antananarivo Atsimondrano'),
  (1, 'Antananarivo Avaradrano'),
  (1, 'Antananarivo Renivohitra'),
  (1, 'Ambohidratrimo'),
  (1, 'Ankazobe'),
  (1, 'Andramasina'),
  -- Atsinanana (id_region = 10)
  (10, 'Toamasina I'),
  (10, 'Toamasina II'),
  (10, 'Brickaville'),
  (10, 'Fénérive Est'),
  (10, 'Mahanoro'),
  (10, 'Marolambo'),
  (10, 'Vatomandry'),
  -- Diana (id_region = 21)
  (21, 'Antsiranana I'),
  (21, 'Antsiranana II'),
  (21, 'Ambanja'),
  (21, 'Ambilobe'),
  (21, 'Nosy Be');

  INSERT INTO commune (id_district, nom_commune) VALUES
  -- Antananarivo Renivohitra (id_district = 3)
  (3, 'Antananarivo Renivohitra'),
  -- Ambohidratrimo (id_district = 4)
  (4, 'Ambohidratrimo'),
  (4, 'Ivato'),
  (4, 'Mahitsy'),
  (4, 'Fieferana'),
  (4, 'Anosiala'),
  -- Toamasina I (id_district = 7)
  (7, 'Toamasina I'),
  -- Toamasina II (id_district = 8)
  (8, 'Ambodirafia'),
  (8, 'Ampisikina'),
  (8, 'Mangarivotra'),
  -- Nosy Be (id_district = 18)
  (18, 'Hellville'),
  (18, 'Ampangorina'),
  (18, 'Mahatsinjo'),
  (18, 'Marodokana'),
  (18, 'Dzamandzar');

  insert into client (nom_client, telephone_client) values
  ('John Doe', '0341234567'),
  ('Jane Smith', '0329876543'),
  ('Alice Johnson', '0334567890');
