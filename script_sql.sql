CREATE DATABASE IF NOT EXISTS GisellePotion;
USE GisellePotion;

DROP TABLE IF EXISTS Fournisseur;
DROP TABLE IF EXISTS FournitureDiluant;
DROP TABLE IF EXISTS Inventeur;
DROP TABLE IF EXISTS Preparation;
DROP TABLE IF EXISTS FournitureIngredient;
DROP TABLE IF EXISTS Recette;
DROP TABLE IF EXISTS Diluant;
DROP TABLE IF EXISTS Clients;
DROP TABLE IF EXISTS PasserCommande;
DROP TABLE IF EXISTS Ingredient;
DROP TABLE IF EXISTS IngredientCommande;
DROP TABLE IF EXISTS Emballage;
DROP TABLE IF EXISTS Recipient;
DROP TABLE IF EXISTS RecipientCommande;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS DiluantCommande;

CREATE TABLE IF NOT EXISTS Fournisseur
(
	fournisseur_ID INTEGER AUTO_INCREMENT,
    fournisseur_nom VARCHAR(24),
    fournisseur_prenom VARCHAR(24),
    CONSTRAINT PRIMARY KEY (fournisseur_ID)
);

CREATE TABLE IF NOT EXISTS Diluant
(
	diluant_ID INTEGER AUTO_INCREMENT,
    diluant_nom VARCHAR(24),
    dliuant_prix INTEGER(5),
    CONSTRAINT PRIMARY KEY (diluant_ID)
);

CREATE TABLE IF NOT EXISTS FournitureDiluant
(
	fournisseur_ID_FK INTEGER,
    diluant_ID_FK INTEGER,
    CONSTRAINT PRIMARY KEY (fournisseur_ID_FK, diluant_ID_FK),
    CONSTRAINT FOREIGN KEY (fournisseur_ID_FK)
		REFERENCES Fournisseur(fournisseur_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (diluant_ID_FK)
		REFERENCES Diluant(diluant_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Inventeur
(
	inventeur_ID INTEGER AUTO_INCREMENT,
    inventeur_nom VARCHAR(24),
    inventeur_prenom VARCHAR(24),
    CONSTRAINT PRIMARY KEY (inventeur_ID)
);

CREATE TABLE IF NOT EXISTS Ingredient
(
	ingredient_ID INTEGER AUTO_INCREMENT,
    ingredient_fraicheur INTEGER(5),
    ingredient_nom VARCHAR(24),
    ingredient_prix INTEGER(5),
    CONSTRAINT PRIMARY KEY (ingredient_ID)
);

CREATE TABLE IF NOT EXISTS Preparation
(
	preparation_ID INTEGER AUTO_INCREMENT,
    preparation_nom VARCHAR(24),
    preparation_prix INTEGER (5),
    preparation_temperature INTEGER (5),
    inventeur_ID_FK INTEGER,
    diluant_ID_FK INTEGER,
    CONSTRAINT PRIMARY KEY (preparation_ID)
);

CREATE TABLE IF NOT EXISTS FournitureIngredient
(
	ingredient_ID_FK INTEGER,
    fournisseur_ID_FK INTEGER,
    CONSTRAINT PRIMARY KEY (ingredient_ID_FK, fournisseur_ID_FK),
    CONSTRAINT FOREIGN KEY (ingredient_ID_FK)
		REFERENCES Ingredient(ingredient_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (fournisseur_ID_FK)
		REFERENCES Fournisseur(fournisseur_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Recette
(
	ingredient_ID_FK INTEGER,
    preparation_ID_FK INTEGER,
    ordreIngredient INTEGER(4),
    ingredient_coupe VARCHAR(24),
    ingredient_prix VARCHAR(24),
    CONSTRAINT PRIMARY KEY (ingredient_ID_FK, preparation_ID_FK),
    CONSTRAINT FOREIGN KEY (ingredient_ID_FK)
		REFERENCES Ingredient(ingredient_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (preparation_ID_FK)
		REFERENCES Preparation(preparation_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Clients
(
	client_ID INTEGER AUTO_INCREMENT,
    client_nom VARCHAR(24),
    client_prenom VARCHAR(24),
    CONSTRAINT PRIMARY KEY (client_ID)
);

CREATE TABLE IF NOT EXISTS Commande
(
	commande_ID INTEGER AUTO_INCREMENT,
    client_FK INTEGER,
    CONSTRAINT PRIMARY KEY (commande_ID),
    CONSTRAINT FOREIGN KEY (client_FK)
		REFERENCES Clients(client_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS IngredientCommande
(
	ingredient_ID_FK INTEGER,
    commande_ID_FK INTEGER,
    commande_quantite_client INTEGER (5),
    commande_prix INTEGER (5),
    CONSTRAINT PRIMARY KEY (ingredient_ID_FK, commande_ID_FK),
    CONSTRAINT FOREIGN KEY (ingredient_ID_FK)
		REFERENCES Ingredient(ingredient_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (commande_ID_FK)
		REFERENCES Commande(commande_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Recipient
(
	recipient_ID INTEGER AUTO_INCREMENT,
    recipient_prix INTEGER(5),
    recipient_type VARCHAR (24),
    CONSTRAINT PRIMARY KEY (recipient_ID)
);

CREATE TABLE IF NOT EXISTS Emballage
(
	preparation_ID_FK INTEGER,
    recipient_ID_FK INTEGER,
    CONSTRAINT PRIMARY KEY (preparation_ID_FK, recipient_ID_FK),
    CONSTRAINT FOREIGN KEY (preparation_ID_FK)
		REFERENCES Preparation(preparation_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (recipient_ID_FK)
		REFERENCES Recipient(recipient_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS RecipientCommande
(
	recipient_ID_FK INTEGER,
    commande_ID_FK INTEGER,
    commande_quantite_client INTEGER (5),
    commande_prix INTEGER (5),
    CONSTRAINT PRIMARY KEY (recipient_ID_FK, commande_ID_FK),
    CONSTRAINT FOREIGN KEY (recipient_ID_FK)
		REFERENCES Recipient(recipient_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (commande_ID_FK)
		REFERENCES Commande(commande_ID)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS DiluantCommande
(
	diluant_ID_FK INTEGER,
	commande_ID_FK INTEGER,
    commande_quantite_client INTEGER (5),
    commande_prix INTEGER (5),
    CONSTRAINT PRIMARY KEY (diluant_ID_FK, commande_ID_FK),
    CONSTRAINT FOREIGN KEY (diluant_ID_FK)
		REFERENCES Diluant(diluant_ID)
        ON DELETE CASCADE,
	CONSTRAINT FOREIGN KEY (commande_ID_FK)
		REFERENCES Commande(commande_ID)
);