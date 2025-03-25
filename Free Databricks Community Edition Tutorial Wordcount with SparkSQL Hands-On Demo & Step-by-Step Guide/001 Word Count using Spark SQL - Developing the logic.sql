-- Databricks notebook source
-- MAGIC %fs ls dbfs:/databricks-datasets/SPARK_README.md

-- COMMAND ----------

SELECT * FROM text.`dbfs:/databricks-datasets/SPARK_README.md`

-- COMMAND ----------

CREATE EXTERNAL TABLE lines
USING TEXT 
OPTIONS (
  PATH='dbfs:/databricks-datasets/SPARK_README.md'
)

-- COMMAND ----------

SHOW tables

-- COMMAND ----------

DESCRIBE lines

-- COMMAND ----------

DESCRIBE FORMATTED lines

-- COMMAND ----------

SELECT * FROM lines

-- COMMAND ----------

SELECT count(*) FROM lines

-- COMMAND ----------

SELECT * FROM lines
WHERE value != '';

-- COMMAND ----------

-- Standard Transformations
-- Projection (SELECT)
-- Filtering (WHERE)
-- Aggregations (GROUP BY and HAVING)
-- Join (INNER, OUTER)
-- Sorting (ORDER BY)
-- Ranking and Cumulative Aggregations (func() OVER (PARTITION BY key ORDER BY key))

-- COMMAND ----------

SHOW FUNCTIONS

-- COMMAND ----------

DESCRIBE FUNCTION abs

-- COMMAND ----------

DESCRIBE FUNCTION split

-- COMMAND ----------

DESCRIBE FUNCTION explode

-- COMMAND ----------

SELECT explode(split('Spark is a fast and general cluster computing system for Big Data. It provides', ' ')) AS word

-- COMMAND ----------

SELECT explode(split(value, ' ')) AS word
FROM lines
WHERE value != ''

-- COMMAND ----------

WITH words_cte AS (
  SELECT explode(split(value, ' ')) AS word
  FROM lines
  WHERE value != ''
) SELECT word, count(*) AS word_count
FROM words_cte
GROUP BY word
ORDER BY 2 DESC


-- COMMAND ----------

INSERT OVERWRITE DIRECTORY 'dbfs:/data/word_count'
USING CSV
OPTIONS (
  HEADER='true'
)
WITH words_cte AS (
  SELECT explode(split(value, ' ')) AS word
  FROM lines
  WHERE value != ''
) SELECT word, count(*) AS word_count
FROM words_cte
GROUP BY word
ORDER BY 2 DESC

-- COMMAND ----------

CREATE OR REPLACE TEMPORARY VIEW word_count_v
USING CSV
OPTIONS (
  PATH='dbfs:/data/word_count',
  HEADER='true',
  INFERSCHEMA='true'
)

-- COMMAND ----------

SELECT * FROM word_count_v;
