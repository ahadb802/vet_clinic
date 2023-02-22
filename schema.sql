/* Database schema to keep the structure of entire database. */
CREATE SCHEMA `vet_clinic` ;

CREATE TABLE vet_clinic.animals (
A_id INT NOT NULL AUTO_INCREMENT,
A_name varchar(100) NULL,
A_DOB varchar(100) NULL,
A_escape_attempts INT NULL,
neutered BOOLEAN DEFAULT NULL,
weight_kg DECIMAL(4,2) NULL
);

/*ADD new column in animals table name species*/

ALter table vet_clinic.animals
ADD species varchar(45);

/*Added owners table*/
Create Table vet_clinic.owners(
o_id INT NOT NULL AUTO_INCREMENT,
o_name varchar(45) NULL,
o_age int NULL,
PRIMARY KEY (`o_id`)
);

/*create species table*/
Create Table vet_clinic.species(
S_id INT NOT NULL AUTO_INCREMENT,
S_name varchar(45) NULL,
PRIMARY KEY (`S_id`)
);

/*Make sure that id is set as autoincremented PRIMARY KEY
Remove column species
Add column species_id which is a foreign key referencing species table
Add column owner_id which is a foreign key referencing the owners table*/
Alter table vet_clinic.animals ADD PRIMARY KEY (A_id);
Alter Table vet_clinic.animals DROP species;
Alter Table vet_clinic.animals ADD species_id int;
Alter Table vet_clinic.animals ADD FOREIGN KEY (species_id) REFERENCES vet_clinic.species (S_id);
Alter Table vet_clinic.animals ADD owner_id int;
Alter Table vet_clinic.animals ADD FOREIGN KEY (owner_id) REFERENCES vet_clinic.owners (o_id);
