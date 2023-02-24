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


/*Quries for vets*/


    SELECT vet_clinic.animals.A_name as animal_name, vet_clinic.vets.v_name as Vet, vet_clinic.visits.date_of_visit FROM vet_clinic.vets
    JOIN vet_clinic.visits ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
    JOIN vet_clinic.animals ON vet_clinic.animals.A_id = vet_clinic.visits.animals_id
    WHERE vet_clinic.vets.v_name = 'William Tatcher'
    ORDER BY vet_clinic.visits.date_of_visit DESC
    LIMIT 1;
    
    SELECT COUNT(*) as visited FROM vet_clinic.vets
    JOIN vet_clinic.visits ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
    WHERE vet_clinic.vets.v_name = 'Stephanie Mendez';
    
    SELECT vet_clinic.vets.v_name as VET_NAME, vet_clinic.species.S_name AS SPECIES_NAME FROM vet_clinic.vets
    LEFT JOIN vet_clinic.specializations ON vet_clinic.specializations.vets_id = vet_clinic.vets.v_id
    LEFT JOIN  vet_clinic.species ON vet_clinic.specializations.species_id = vet_clinic.species.S_id;
    
    SELECT vet_clinic.animals.A_name AS animal_name, vet_clinic.visits.date_of_visit FROM vet_clinic.animals
    JOIN vet_clinic.visits ON vet_clinic.visits.animals_id = vet_clinic.animals.A_id
    JOIN vet_clinic.vets ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
    WHERE vet_clinic.vets.v_name = 'Stephanie Mendez' AND vet_clinic.visits.date_of_visit >= '2020-04-01' AND vet_clinic.visits.date_of_visit <= '2020-08-30';
    
    SELECT vet_clinic.animals.A_name as animal_name, COUNT(*) AS total FROM vet_clinic.animals
    JOIN vet_clinic.visits ON vet_clinic.visits.animals_id = vet_clinic.animals.A_id
    GROUP BY vet_clinic.animals.A_name
    ORDER BY total DESC
    LIMIT 1;
    
    SELECT vet_clinic.vets.v_name as vet_NAME, vet_clinic.visits.date_of_visit as date_of_vist, vet_clinic.animals.A_name as animal_name FROM vet_clinic.visits 
    JOIN vet_clinic.vets ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
    JOIN vet_clinic.animals ON vet_clinic.animals.A_id = vet_clinic.visits.animals_id
    WHERE vet_clinic.vets.v_name = 'Maisy Smith'
    ORDER BY vet_clinic.visits.date_of_visit
    LIMIT 1;
    
    SELECT date_of_visit,
	vet_clinic.animals.A_DOB AS animal_date,
	vet_clinic.animals.A_escape_attempts,
	vet_clinic.animals.neutered,
	vet_clinic.animals.weight_kg AS animal_weight,
	vet_clinic.vets.v_name AS vet_name,
	vet_clinic.vets.v_age AS vet_age,
	vet_clinic.vets.date_of_graduation
FROM vet_clinic.visits
JOIN vet_clinic.animals ON vet_clinic.animals.A_id = visits.animals_id
JOIN vet_clinic.vets ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
ORDER BY date_of_visit
LIMIT 1;

SELECT COUNT(*)
    FROM vet_clinic.visits 
    JOIN vet_clinic.animals ON vet_clinic.animals.A_id = vet_clinic.visits.animals_id
    JOIN vet_clinic.vets ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
    JOIN vet_clinic.specializations ON vet_clinic.specializations.vets_id = vet_clinic.visits.vets_id
    WHERE vet_clinic.animals.species_id != vet_clinic.specializations.species_id;
    
SELECT vet_clinic.species.S_name as species_NAME, COUNT(*) as _count FROM vet_clinic.visits
    JOIN vet_clinic.vets ON vet_clinic.vets.v_id = vet_clinic.visits.vets_id
    JOIN vet_clinic.animals ON vet_clinic.animals.A_id = vet_clinic.visits.animals_id
    JOIN vet_clinic.species ON vet_clinic.species.S_id = vet_clinic.animals.species_id
    WHERE vet_clinic.vets.v_name = 'Maisy Smith'
    GROUP BY vet_clinic.species.S_name;
