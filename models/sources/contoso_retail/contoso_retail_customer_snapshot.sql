{{ config(materialized='table') }}

with source as (
    SELECT 
        CASE 
            WHEN GENDER = 'M' THEN 'M' 
            WHEN GENDER = 'F' THEN 'F' 
            WHEN GENDER IS NULL THEN 'Unspecified'
            ELSE 'Mx'
        END AS GENDER,
        ROUND(AVG(DATEDIFF('year', BIRTHDATE, CURRENT_TIMESTAMP))) AS AVERAGE_AGE,
        ROUND(AVG(YEARLYINCOME), 3) AS AVERAGE_INCOME,
        ROUND(AVG(TOTALCHILDREN), 2) AS AVERAGE_NUM_CHILDREN,
        ROUND(AVG(DATEDIFF('year', BIRTHDATE, DATEFIRSTPURCHASE))) AS AVERAGE_AGE_AT_FIRST_PURCHASE
    FROM {{ source('contoso_retail_dw_dbo', 'DimCustomer') }}
    GROUP BY GENDER
)

select *
from source