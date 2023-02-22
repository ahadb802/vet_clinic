/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM vet_clinic.animals Where A_name like "%mon";
SELECT A_name FROM vet_clinic.animals Where A_DOB BETWEEN '2016-01-01' AND '2019-12-31';
SELECT A_name FROM vet_clinic.animals where neutered=TRUE AND A_escape_attempts<3;
SELECT A_DOB FROM vet_clinic.animals where A_name="Agumon" OR A_name="Pikachu";
SELECT A_name,A_escape_attempts FROM vet_clinic.animals where weight_kg>10.5;
SELECT * FROM vet_clinic.animals where weight_kg>10.5;
SELECT * FROM vet_clinic.animals where A_name<>"Gabumon";
SELECT * FROM vet_clinic.animals where weight_kg>=10.4 AND weight_kg<=17.3;
