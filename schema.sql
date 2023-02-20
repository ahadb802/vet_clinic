/* Database schema to keep the structure of entire database. */
CREATE SCHEMA `vet_clinic` ;

CREATE TABLE `vet_clinic`.`animals` (
  `idanimals` INT NULL,
  `name` VARCHAR(100) NULL,
  `date_of_birth` DATE NULL,
  `escape_attempts` INT NULL,
  `neutered` BOOLEAN NULL,
  `weight_kg` DECIMAL() NULL);
