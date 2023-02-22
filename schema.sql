/* Database schema to keep the structure of entire database. */
CREATE SCHEMA `vet_clinic` ;

CREATE TABLE vet_clinic.animals (
A_id INT NULL,
A_name varchar(100) NULL,
A_DOB varchar(100) NULL,
A_escape_attempts INT NULL,
neutered BOOLEAN DEFAULT NULL,
weight_kg DECIMAL(4,2) NULL
);

