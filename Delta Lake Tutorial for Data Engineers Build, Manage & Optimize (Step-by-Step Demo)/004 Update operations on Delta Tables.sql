-- Databricks notebook source
USE studentsdb;

-- COMMAND ----------

SHOW tables;

-- COMMAND ----------

SELECT * FROM students;

-- COMMAND ----------

-- Updating records in the students table
UPDATE students
SET student_email = 'eaddionisio3@berkeley.edu', action = 'U'
WHERE student_id = 4;

-- COMMAND ----------

SELECT * FROM students;

-- COMMAND ----------

UPDATE students
SET student_email = 'lwarret4@nsw.gov.au', action = 'U'
WHERE student_last_name = 'Warret';

-- COMMAND ----------

SELECT * FROM students;