-- Validate subscription date ranges.
-- A subscription cannot end before its start date.
-- Expected result: 0 rows.

select
    subscription_id,
    start_date,
    end_date,
    cancelled_date
from {{ ref('stg_subskribe__subscriptions') }}
where end_date < start_date
   or (cancelled_date is not null and cancelled_date < start_date)