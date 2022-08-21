{{ config(materialized='table') }}

WITH FACT_STRATEGY_PLANNING AS (
  SELECT 
      FSP.DATEKEY,
      DA.ACCOUNTNAME,
      DS.SCENARIONAME,
      DPC.PRODUCTCATEGORYNAME,
      DE.ENTITYNAME,
      FSP.AMOUNT
  FROM {{ source('contoso_retail_dw_dbo', 'FactStrategyPlan') }} FSP
  LEFT JOIN {{ source('contoso_retail_dw_dbo', 'DimAccount') }} DA
      ON FSP.ACCOUNTKEY = DA.ACCOUNTKEY
  LEFT JOIN {{ source('contoso_retail_dw_dbo', 'DimScenario') }} DS
      ON FSP.SCENARIOKEY = DS.SCENARIOKEY
  LEFT JOIN {{ source('contoso_retail_dw_dbo', 'DimProductCategory') }} DPC
      ON FSP.PRODUCTCATEGORYKEY = DPC.PRODUCTCATEGORYKEY
  LEFT JOIN {{ source('contoso_retail_dw_dbo', 'DimEntity') }} DE
      ON FSP.ENTITYKEY = DE.ENTITYKEY
)
SELECT *
FROM FACT_STRATEGY_PLANNING