INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (0,'Agumon', '2022-02-03', 0, TRUE, 10.23);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (1,'Gabumon', '2018-11-15', 2, TRUE, 8.0);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (2,'Pikachu', '2021-01-07', 1, FALSE, 15.04);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (3,'Devimon', '2017-05-12', 5, TRUE, 11.0);

/* Populate animal table with new data. */
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (4,'Charmander', '2020-02-08', 0, FALSE, -11);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (5,'Plantmon', '2021-11-15', 2, true, -5.7);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (6,'Squirtle', '1993-04-02', 3, false, -12.13);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (7,'Angemon', '2005-06-12', 1, true, -45);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (8,'Boarmon', '2005-06-07', 7, true, 20.4);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (9,'Blossom', '1998-10-13', 3, true, 17);
INSERT INTO vet_clinic.animals(A_id,A_name,A_DOB,A_escape_attempts,neutered,weight_kg) VALUES (10,'Ditto', '2022-05-14', 4, true, 22);

/* Populate Owners table with new data. */
INSERT INTO vet_clinic.owners (o_name, o_age) VALUES('Sam Smith', 34);
INSERT INTO vet_clinic.owners (o_name, o_age) VALUES('Jennifer Orwell', 19);
INSERT INTO vet_clinic.owners (o_name, o_age) VALUES('Bob', 45);
INSERT INTO vet_clinic.owners (o_name, o_age) VALUES('Melody Pond', 77);
INSERT INTO vet_clinic.owners (o_name, o_age) VALUES('Dean Winchester', 14);
INSERT INTO vet_clinic.owners (o_name, o_age) VALUES('Jodie Whittaker', 38);

/* Populate species table with new data. */
INSERT INTO vet_clinic.species (S_name) VALUES('Pokemon');
INSERT INTO vet_clinic.species (S_name) VALUES('Digimon');

/*
Modify your inserted animals so it includes the species_id value:
    If the name ends in "mon" it will be Digimon
    All other animals are Pokemon
 */
UPDATE vet_clinic.animals
SET species_id = (SELECT S_id from vet_clinic.species WHERE S_name = 'Digimon')
WHERE A_name like '%mon';

UPDATE vet_clinic.animals
SET species_id = (SELECT S_id from vet_clinic.species WHERE S_name = 'Pokemon')
WHERE species_id IS NULL;

/*Modify your inserted animals to include owner information (owner_id):*/
UPDATE vet_clinic.animals
SET owner_id = (SELECT o_id from vet_clinic.owners WHERE o_name = 'Sam Smith')
WHERE A_name = 'Agumon';

UPDATE vet_clinic.animals
SET owner_id = (SELECT o_id from vet_clinic.owners WHERE o_name = 'Jennifer Orwell')
WHERE A_name = 'Pikachu' OR A_name = 'Gabumon';

UPDATE vet_clinic.animals
SET owner_id = (SELECT o_id from vet_clinic.owners WHERE o_name = 'Bob')
WHERE A_name = 'Devimon' OR A_name = 'Plantmon';

UPDATE vet_clinic.animals
SET owner_id = (SELECT o_id from vet_clinic.owners WHERE o_name = 'Melody Pond')
WHERE A_name = 'Charmander' OR A_name = 'Squirtle' OR A_name ='Blossom';

UPDATE vet_clinic.animals
SET owner_id = (SELECT o_id from vet_clinic.owners WHERE o_name = 'Dean Winchester')
WHERE A_name = 'Boarmon' OR A_name = 'Angemon';


/*insert data in vets table*/

INSERT INTO vet_clinic.vets (v_name, v_age, date_of_graduation) VALUES ('William Tatcher', 45, date '2000-04-23');
INSERT INTO vet_clinic.vets (v_name, v_age, date_of_graduation) VALUES ('Maisy Smith', 26, date '2019-01-17');
INSERT INTO vet_clinic.vets (v_name, v_age, date_of_graduation) VALUES ('Stephanie Mendez', 64, date '1981-05-04');
INSERT INTO vet_clinic.vets (v_name, v_age, date_of_graduation) VALUES ('Jack Harkness', 38, date '2008-06-08');

/*insert data in specializations*/

INSERT INTO vet_clinic.specializations (species_id, vets_id)
VALUES ((SELECT S_id FROM vet_clinic.species WHERE S_name = 'Pokemon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'William Tatcher')),
	   ((SELECT S_id FROM vet_clinic.species WHERE S_name = 'Pokemon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Stephanie Mendez')),
       ((SELECT S_id FROM vet_clinic.species WHERE S_name = 'Digimon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Stephanie Mendez')),
	   ((SELECT S_id FROM vet_clinic.species WHERE S_name = 'Digimon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Jack Harkness'));
       
/*insert data into visits*/
INSERT INTO vet_clinic.visits (animals_id, vets_id, date_of_visit) 
VALUES ((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Agumon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'William Tatcher'), '2020-05-24'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Agumon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Stephanie Mendez'), '2020-07-22'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Gabumon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Jack Harkness'), '2021-02-02'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Pikachu'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2020-01-05'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Pikachu'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2020-03-08'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Pikachu'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2020-05-14'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Devimon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Stephanie Mendez'), '2021-05-04'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Charmander'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Jack Harkness'), '2021-02-24'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Plantmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2019-12-21'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Plantmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'William Tatcher'), '2020-08-10'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Plantmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2021-04-07'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Squirtle'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Stephanie Mendez'), '2019-09-29'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Angemon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Jack Harkness'), '2020-10-03'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Angemon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Jack Harkness'), '2020-11-04'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Boarmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2019-01-24'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Boarmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2019-05-15'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Boarmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2020-02-27'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Boarmon'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Maisy Smith'), '2020-08-03'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Blossom'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'Stephanie Mendez'), '2020-05-24'),
	((SELECT A_id FROM vet_clinic.animals WHERE A_name = 'Blossom'), (SELECT v_id FROM vet_clinic.vets WHERE v_name = 'William Tatcher'), '2021-01-11');
