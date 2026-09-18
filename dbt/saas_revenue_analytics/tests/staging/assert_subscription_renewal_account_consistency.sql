-- Validate account consistency across subscription renewals.
-- A renewed subscription must belong to the same account
-- as the subscription from which it was renewed.
-- Expected result: 0 rows.

select
    current_sub.subscription_id,
    current_sub.renewed_from_subscription_id,
    current_sub.account_id as current_account_id,
    previous_sub.subscription_id as previous_subscription_id,
    previous_sub.account_id as previous_account_id
from {{ ref('stg_subskribe__subscriptions') }} as current_sub
inner join {{ ref('stg_subskribe__subscriptions') }} as previous_sub
    on current_sub.renewed_from_subscription_id = previous_sub.subscription_id
where current_sub.account_id != previous_sub.account_id