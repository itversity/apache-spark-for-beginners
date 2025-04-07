-- Databricks notebook source
-- Setting up the database and table
USE studentsdb;

-- COMMAND ----------

SHOW tables;

-- COMMAND ----------

DESCRIBE FORMATTED mystudents;

-- COMMAND ----------

-- Insert single records
-- Insert for the first student
INSERT INTO mystudents 
(student_id, student_first_name, student_last_name, student_email, student_gender, student_phone_number, action) 
VALUES 
(1, 'Eduino', 'Dawdry', 'edawdry0@whitehouse.gov', 'Bigender', '5737119029', 'I');


-- COMMAND ----------

-- Insert for the second student
INSERT INTO mystudents 
(student_id, student_first_name, student_last_name, student_email, student_gender, student_phone_number, action) 
VALUES 
(2, 'Lacee', 'Prosek', 'lprosek1@barnesandnoble.com', 'Polygender', '9526294997', 'I');

-- COMMAND ----------

-- Insert multiple records at once
INSERT INTO mystudents 
(student_id, student_first_name, student_last_name, student_email, student_gender, student_phone_number, action) 
VALUES 
    (3, 'Richart', 'Zimmer', 'rzimmer2@ox.ac.uk', 'Non-binary', '3129072019', 'I'),
    (4, 'Elyse', 'Addionisio', '', 'Polygender', '7347984926', 'I'),
    (5, 'Lilian', 'Warret', '', 'Male', '5031246553', 'I');
