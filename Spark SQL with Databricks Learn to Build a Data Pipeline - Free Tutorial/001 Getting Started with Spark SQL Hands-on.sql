-- Databricks notebook source
SELECT current_database()

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/databricks-datasets/

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/databricks-datasets/online_retail/data-001/

-- COMMAND ----------

-- MAGIC %fs head dbfs:/databricks-datasets/online_retail/data-001/data.csv

-- COMMAND ----------

CREATE EXTERNAL TABLE online_retail
USING CSV
OPTIONS (
  PATH='dbfs:/databricks-datasets/online_retail/data-001/data.csv',
  HEADER='true',
  INFERSCHEMA='true'
)

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

DESCRIBE online_retail

-- COMMAND ----------

SELECT * FROM online_retail

-- COMMAND ----------

SELECT count(*) FROM online_retail

-- COMMAND ----------

SHOW FUNCTIONS

-- COMMAND ----------

DESCRIBE FUNCTION round

-- COMMAND ----------

SELECT t.*, round(t.Quantity * t.UnitPrice, 2) AS ItemRevenue FROM online_retail AS t;

-- COMMAND ----------

SELECT t.InvoiceNo,
  round(sum(t.Quantity * t.UnitPrice), 2) AS InvoiceRevenue,
  count(t.InvoiceNo) AS ItemCount,
  sum(t.Quantity) AS InvoiceQuantity -- 1 -- 7
FROM online_retail AS t -- 2 -- 1
GROUP BY t.InvoiceNo -- 6 -- 5
ORDER BY InvoiceRevenue DESC; -- 8 -- 8

-- COMMAND ----------

CREATE OR REPLACE VIEW invoice_revenue_v
AS
SELECT t.InvoiceNo,
  round(sum(t.Quantity * t.UnitPrice), 2) AS InvoiceRevenue,
  count(t.InvoiceNo) AS ItemCount,
  sum(t.Quantity) AS InvoiceQuantity
FROM online_retail AS t
GROUP BY t.InvoiceNo 
ORDER BY InvoiceRevenue DESC;

-- COMMAND ----------

SHOW TABLES

-- COMMAND ----------

DESCRIBE FORMATTED invoice_revenue_v

-- COMMAND ----------

SELECT * FROM invoice_revenue_v;

-- COMMAND ----------

WITH invoice_revenue_cte AS (
  SELECT t.InvoiceNo,
    round(sum(t.Quantity * t.UnitPrice), 2) AS InvoiceRevenue,
    count(t.InvoiceNo) AS ItemCount,
    sum(t.Quantity) AS InvoiceQuantity
  FROM online_retail AS t
  GROUP BY t.InvoiceNo 
) SELECT * FROM invoice_revenue_cte
ORDER BY InvoiceRevenue DESC

-- COMMAND ----------

DROP TABLE invoice_revenue;

-- COMMAND ----------

CREATE TABLE invoice_revenue (
  InvoiceNo STRING,
  InvoiceRevenue DOUBLE,
  ItemCount INTEGER,
  InvoiceQuantity INTEGER
) USING PARQUET;

-- COMMAND ----------

SHOW TABLES;

-- COMMAND ----------

DESCRIBE FORMATTED online_retail

-- COMMAND ----------

DESCRIBE FORMATTED invoice_revenue

-- COMMAND ----------

INSERT OVERWRITE TABLE invoice_revenue
SELECT t.InvoiceNo,
  round(sum(t.Quantity * t.UnitPrice), 2) AS InvoiceRevenue,
  count(t.InvoiceNo) AS ItemCount,
  sum(t.Quantity) AS InvoiceQuantity
FROM online_retail AS t
GROUP BY t.InvoiceNo 

-- COMMAND ----------

-- MAGIC %fs ls dbfs:/user/hive/warehouse/invoice_revenue

-- COMMAND ----------

SELECT count(*) FROM invoice_revenue;

-- COMMAND ----------

SELECT * FROM invoice_revenue
ORDER BY InvoiceRevenue DESC;

-- COMMAND ----------


