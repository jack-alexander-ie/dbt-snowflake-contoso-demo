{{ config(materialized='table') }}

WITH FACT_STRATEGY_PLANNING AS (
  SELECT *
  FROM {{ source('fivetran_log', 'account') }} A
  LIMIT 1
)
SELECT *
FROM FACT_STRATEGY_PLANNING