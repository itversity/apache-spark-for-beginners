-- Databricks notebook source
CREATE DATABASE IF NOT EXISTS retail_db;

-- COMMAND ----------

USE retail_db

-- COMMAND ----------

CREATE EXTERNAL TABLE IF NOT EXISTS online_retail
USING CSV
OPTIONS (
  PATH='dbfs:/databricks-datasets/online_retail/data-001/',
  HEADER='true',
  INFERSCHEMA='true'
)

-- COMMAND ----------

CREATE TABLE IF NOT EXISTS invoice_metrics (
  InvoiceNo STRING,
  InvoiceRevenue DOUBLE,
  ItemCount INTEGER,
  InvoiceQuantity INTEGER
) USING PARQUET;

-- COMMAND ----------

INSERT OVERWRITE TABLE invoice_metrics
SELECT t.InvoiceNo,
  round(sum(t.Quantity * t.UnitPrice), 2) AS InvoiceRevenue,
  count(t.InvoiceNo) AS ItemCount,
  sum(t.Quantity) AS InvoiceQuantity
FROM online_retail AS t
GROUP BY t.InvoiceNo 

-- COMMAND ----------

SELECT * FROM invoice_metrics

-- COMMAND ----------

SELECT count(*) FROM invoice_metrics

-- COMMAND ----------


