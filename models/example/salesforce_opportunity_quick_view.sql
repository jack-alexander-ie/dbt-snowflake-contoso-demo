
-- Use the `ref` function to select from other models

select *
from {{ ref('salesforce_opportunity_quick_overview') }}
where id = 1
