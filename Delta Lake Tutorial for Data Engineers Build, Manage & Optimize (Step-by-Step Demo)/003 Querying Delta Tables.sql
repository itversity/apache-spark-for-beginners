-- Databricks notebook source
USE studentsdb;

-- COMMAND ----------

-- Querying all data from Delta Table
SELECT * FROM mystudents;

-- COMMAND ----------

-- Querying with a filter
SELECT * FROM mystudents WHERE student_gender = 'Bigender';

-- COMMAND ----------

-- Counting the number of rows
SELECT COUNT(*) FROM mystudents;