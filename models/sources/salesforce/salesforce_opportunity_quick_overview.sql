{{ config(materialized='table') }}

with source as (
    SELECT
        A.ID AS PROSPECT_ACCOUNT_ID, 
        A.NAME PROSPECT_NAME, 
        COUNT(O.ID) AS ACTIVE_OPPORTUNITIES, 
        SUM(O.AMOUNT) AS TOTAL_AMOUNT, 
        SUM(O.EXPECTED_REVENUE) TOTAL_EXPECTED_REVENUE,
        MAX(O.LAST_ACTIVITY_DATE) MOST_RECENT_ACTIVITY
    FROM {{ source('salesforce', 'Opportunity') }} O
    LEFT JOIN {{ source('salesforce', 'Account') }} A 
        ON A.ID = O.ACCOUNT_ID
    WHERE NOT O.IS_CLOSED AND NOT O.IS_WON
    GROUP BY A.ID, A.NAME
)

select *
from source