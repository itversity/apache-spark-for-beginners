-- Databricks notebook source
-- Step into the specified database and show tables for confirmation
USE studentsdb;

-- COMMAND ----------

SHOW tables;

-- COMMAND ----------

-- Clear any existing data in the 'students' table
TRUNCATE TABLE students;

-- COMMAND ----------

-- Create the staging table for merging data

CREATE TABLE students_stg (
  student_id INT,
  student_first_name STRING,
  student_last_name STRING,
  student_email STRING,
  student_gender STRING,
  student_phone_number STRING,
  action STRING
) USING DELTA;

-- COMMAND ----------

-- Insert initial records into 'students_stg'
INSERT INTO students_stg
(student_id, student_first_name, student_last_name, student_email, student_gender, student_phone_number, action) 
VALUES 
(1, 'Eduino', 'Dawdry', 'edawdry0@whitehouse.gov', 'Bigender', '5737119029', 'I'),
(2, 'Lacee', 'Prosek', 'lprosek1@barnesandnoble.com', 'Polygender', '9526294997', 'I'),
(3, 'Richart', 'Zimmer', 'rzimmer2@ox.ac.uk', 'Non-binary', '3129072019', 'I'),
(4, 'Elyse', 'Addionisio', '', 'Polygender', '7347984926', 'I'),
(5, 'Lilian', 'Warret', '', 'Male', '5031246553', 'I');

-- COMMAND ----------

-- Insert data from 'students_stg' into the main 'students' table
INSERT INTO students
SELECT * FROM students_stg;

-- COMMAND ----------

-- Verify the data in the main 'students' table
SELECT * FROM students;

-- COMMAND ----------

-- Clear the 'students_stg' table for new data
TRUNCATE TABLE students_stg;

-- COMMAND ----------

-- Insert new data into 'students_stg' with various actions
INSERT INTO students_stg
(student_id, student_first_name, student_last_name, student_email, student_gender, student_phone_number, action) 
VALUES 
(4, 'Elyse', 'Addionisio', 'eaddionisio3@berkeley.edu', 'Polygender', '7347984926', 'U'),
(5, 'Lilian', 'Warret', 'lwarret4@nsw.gov.au', 'Male', '5031246553', 'D'),
(6, 'Tate', 'Swyne', 'tswyne5@hud.gov', 'Agender', '2021437429', 'I'),
(7, 'Ichabod', 'Moring', 'imoring6@un.org', 'Female', '7147001301', 'I'),
(8, 'Ariel', 'Howler', 'ahowler7@tinypic.com', 'Agender', NULL, 'I'),
(9, 'Octavia', 'Stenner', 'ostenner8@networksolutions.com', 'Bigender', NULL, 'I'),
(10, 'Ronda', 'Stean', 'rstean9@xrea.com', 'Genderfluid', NULL, 'I');

-- COMMAND ----------

-- Merging records from 'students_stg' into 'students' based on action
MERGE INTO students
USING students_stg
ON students.student_id = students_stg.student_id
WHEN MATCHED AND students_stg.action = 'D' THEN DELETE
WHEN MATCHED AND students_stg.action = 'U' THEN UPDATE SET *
WHEN NOT MATCHED THEN INSERT *;

-- COMMAND ----------

-- Display the final records in the 'students' table to verify the merge operation
SELECT * FROM students ORDER BY student_id;