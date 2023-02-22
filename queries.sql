/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM vet_clinic.animals Where A_name like "%mon";
SELECT A_name FROM vet_clinic.animals Where A_DOB BETWEEN '2016-01-01' AND '2019-12-31';
SELECT A_name FROM vet_clinic.animals where neutered=TRUE AND A_escape_attempts<3;
SELECT A_DOB FROM vet_clinic.animals where A_name="Agumon" OR A_name="Pikachu";
SELECT A_name,A_escape_attempts FROM vet_clinic.animals where weight_kg>10.5;
SELECT * FROM vet_clinic.animals where weight_kg>10.5;
SELECT * FROM vet_clinic.animals where A_name<>"Gabumon";
SELECT * FROM vet_clinic.animals where weight_kg>=10.4 AND weight_kg<=17.3;

/*setting the species column to unspecified*/

START TRANSACTION;
UPDATE vet_clinic.animals SET species = 'unspecified';
Select Species from vet_clinic.animals;
ROLLBACK;
Select Species from vet_clinic.animals;

/*Update the animals table by setting the species column to following*/

START TRANSACTION;
UPDATE vet_clinic.animals SET species = 'digimon' where A_name like "%mon";
UPDATE vet_clinic.animals SET species = 'pokemon' where A_name is null;
COMMIT;
Select Species from vet_clinic.animals;

/*Deleting all the data of animals table and then rollback*/

START TRANSACTION;
delete from vet_clinic.animals;
ROLLBACK;
Select A_name from vet_clinic.animals;

/*Delete all animals born after Jan 1st, 2022.
Create a savepoint for the transaction.
Update all animals' weight to be their weight multiplied by -1.
Rollback to the savepoint
Update all animals' weights that are negative to be their weight multiplied by -1.
Commit transaction*/

START TRANSACTION;
DELETE FROM vet_clinic.animals WHERE  A_DOB > '2022-01-01';
SAVEPOINT newDATA;
Update vet_clinic.animals set weight_kg=weight_kg*-1;
ROLLBACK TO newDATA;
Update vet_clinic.animals set weight_kg=weight_kg*-1 where weight_kg<0;
commit;

/*How many animals are there?*/
Select COUNT(*) from vet_clinic.animals;

/*How many animals have never tried to escape?*/
Select *,COUNT(*) as TOTAL from vet_clinic.animals where A_escape_attempts =0;

/*Who escapes the most, neutered or not neutered animals?*/
SELECT  A_escape_attempts,neutered FROM vet_clinic.animals WHERE A_escape_attempts = (SELECT MAX(A_escape_attempts) FROM vet_clinic.animals);

/*What is the average weight of animals?*/
Select AVG(weight_kg) from vet_clinic.animals;

/*What is the minimum and maximum weight of each type of animal?*/
Select species,min(weight_kg) as MIN_WEIGHT,max(weight_kg) as MAX_WEIGHT from vet_clinic.animals group by species

/*What is the average number of escape attempts per animal type of those born between 1990 and 2000?*/
Select species, ROUND(AVG(A_escape_attempts),2) as AVG_RUN From vet_clinic.animals where A_DOB BETWEEN "1990-01-01" AND "2000-12-31" group by species;

/*Write queries (using JOIN) to answer the following questions*/

SELECT A_name FROM vet_clinic.animals
    JOIN vet_clinic.owners ON vet_clinic.animals.owner_id = vet_clinic.owners.o_id 
    WHERE o_name = 'Melody Pond';


SELECT vet_clinic.animals.*, vet_clinic.species.S_name AS specie FROM vet_clinic.animals
    JOIN vet_clinic.species ON vet_clinic.animals.species_id = vet_clinic.species.S_id
    WHERE vet_clinic.species.S_name = 'Pokemon';

SELECT vet_clinic.animals.A_name AS A_name, vet_clinic.owners.o_name AS o_name FROM vet_clinic.owners
    LEFT JOIN vet_clinic.animals ON vet_clinic.owners.o_id = vet_clinic.animals.owner_id;
    
SELECT vet_clinic.species.S_name AS species_name, COUNT(*) FROM vet_clinic.animals
    JOIN vet_clinic.species ON vet_clinic.species.S_id = vet_clinic.animals.species_id
    GROUP BY species.S_name;

SELECT vet_clinic.animals.A_name as animal_name, vet_clinic.owners.o_name AS owner_name, vet_clinic.species.S_name AS species_name 
from vet_clinic.animals
JOIN vet_clinic.species ON vet_clinic.species.S_id = vet_clinic.animals.species_id
JOIN vet_clinic.owners ON vet_clinic.owners.o_id = vet_clinic.animals.owner_id
WHERE vet_clinic.species.S_name = 'Digimon' AND vet_clinic.owners.o_name = 'Jennifer Orwell';

SELECT * from vet_clinic.animals
JOIN vet_clinic.owners ON vet_clinic.animals.owner_id = vet_clinic.owners.o_id
WHERE vet_clinic.owners.o_name = 'Dean Winchester' AND vet_clinic.animals.A_escape_attempts = 0;

SELECT vet_clinic.owners.o_name, COUNT(vet_clinic.animals.A_name) AS TOTAL
FROM vet_clinic.owners
LEFT JOIN vet_clinic.animals ON vet_clinic.owners.o_id = vet_clinic.animals.owner_id
GROUP BY vet_clinic.owners.o_name
ORDER BY TOTAL DESC;
