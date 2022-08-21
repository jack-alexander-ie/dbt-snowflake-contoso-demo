{{ config(materialized='table') }}

WITH source AS (
    SELECT
        CHANNELNAME,
        (UNITPRICE * SALESQUANTITY) - DISCOUNTAMOUNT AS SALES_TOTAL,
        (UNITCOST * SALESQUANTITY) - RETURNAMOUNT AS COST_TOTAL,
        RETURNAMOUNT,
        ((UNITPRICE * SALESQUANTITY) - DISCOUNTAMOUNT) - ((UNITCOST * SALESQUANTITY) - RETURNAMOUNT) AS TOTAL_PROFIT,
        DATEKEY
    FROM "JACKM_CONTOSO"."CONTOSO_RETAIL_DW_DBO"."FACTSALES" S
    LEFT JOIN "JACKM_CONTOSO"."CONTOSO_RETAIL_DW_DBO"."DIMCHANNEL" C
        ON S.CHANNELKEY = C.CHANNELKEY
)

SELECT *
FROM source