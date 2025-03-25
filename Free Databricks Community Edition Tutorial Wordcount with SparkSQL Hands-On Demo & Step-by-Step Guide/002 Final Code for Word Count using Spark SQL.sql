-- Databricks notebook source
CREATE EXTERNAL TABLE IF NOT EXISTS lines
USING TEXT 
OPTIONS (
  PATH='dbfs:/databricks-datasets/SPARK_README.md'
)

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
