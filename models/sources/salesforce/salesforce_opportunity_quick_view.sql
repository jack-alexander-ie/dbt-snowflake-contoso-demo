select PROSPECT_NAME, ACTIVE_OPPORTUNITIES, TOTAL_AMOUNT, TOTAL_EXPECTED_REVENUE, MOST_RECENT_ACTIVITY
from {{ ref('salesforce_opportunity_quick_overview') }}
