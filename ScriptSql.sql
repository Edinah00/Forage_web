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

CREATE TABLE IF NOT EXISTS demande_status (
    id_demande INT,
    id_status INT,
    date_status DATETIME,
    PRIMARY KEY (id_demande, id_status),
    FOREIGN KEY (id_demande) REFERENCES demande(id_demande),
    FOREIGN KEY (id_status) REFERENCES status(id_status)
);

insert into client (nom_client, telephone_client) values ('John Doe', '1234567890');
insert into region(nom_region) value ('Amoron i Mania');
insert into district(nom_district) value ('Ambositra');
insert into commune(nom_commune) value ('Ambositra2');