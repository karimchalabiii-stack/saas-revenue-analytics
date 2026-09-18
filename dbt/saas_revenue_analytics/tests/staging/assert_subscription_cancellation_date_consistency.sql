-- Validate consistency between subscription state and cancellation date.
-- CANCELED subscriptions must have a cancellation date,
-- while all other subscription states must not have one.
-- Expected result: 0 rows.

select
    subscription_id,
    subscription_state,
    cancelled_date
from {{ ref('stg_subskribe__subscriptions') }}
where
    (subscription_state = 'CANCELED' and cancelled_date is null)
    or
    (subscription_state != 'CANCELED' and cancelled_date is not null)