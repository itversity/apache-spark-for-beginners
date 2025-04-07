-- Databricks notebook source
USE studentsdb;

-- COMMAND ----------

SELECT * FROM students;

-- COMMAND ----------

-- Deleting specific records from the students table
DELETE FROM students WHERE student_id = 4;

-- COMMAND ----------

-- Delete records where the email ends with 'gov'
DELETE FROM students WHERE student_email LIKE '%gov';

-- COMMAND ----------

SELECT * FROM students;