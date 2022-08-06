{{ config(materialized='table') }}

with source as (
    SELECT 
        G.REGIONCOUNTRYNAME AS COUNTRY,
        ROUND(AVG(DATEDIFF('year', C.BIRTHDATE, CURRENT_TIMESTAMP))) AS AVERAGE_AGE,
        ROUND(AVG(C.YEARLYINCOME), 3) AS AVERAGE_INCOME,
        ROUND(AVG(C.TOTALCHILDREN), 2) AS AVERAGE_NUM_CHILDREN,
        ROUND(AVG(DATEDIFF('year', BIRTHDATE, DATEFIRSTPURCHASE))) AS AVERAGE_AGE_AT_FIRST_PURCHASE
    FROM {{ source('contoso_retail_dw_dbo', 'DimCustomer') }} C
    LEFT JOIN {{ source('contoso_retail_dw_dbo', 'DimGeography') }} G
        ON C.GEOGRAPHYKEY = G.GEOGRAPHYKEY
    GROUP BY G.REGIONCOUNTRYNAME
)

select *
from source