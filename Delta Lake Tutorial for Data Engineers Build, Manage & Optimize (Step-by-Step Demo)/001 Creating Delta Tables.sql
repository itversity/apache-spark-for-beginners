-- Databricks notebook source
-- Creating a new Delta table in the studentsdb database
CREATE DATABASE IF NOT EXISTS studentsdb;

-- COMMAND ----------

USE studentsdb;

-- COMMAND ----------

DROP TABLE IF EXISTS mystudents;

-- COMMAND ----------

CREATE TABLE mystudents (
    student_id INT,
    student_first_name STRING,
    student_last_name STRING,
    student_email STRING,
    student_gender STRING,
    student_phone_number STRING,
    action STRING
) USING DELTA;