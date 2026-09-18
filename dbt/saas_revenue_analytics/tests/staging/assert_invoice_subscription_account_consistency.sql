-- Validate account consistency between invoices and subscriptions.
-- An invoice must belong to the same account as its associated subscription.
-- Expected result: 0 rows.

select
    i.invoice_id,
    i.subscription_id,
    i.account_id as invoice_account_id,
    s.account_id as subscription_account_id
from {{ ref('stg_subskribe__invoices') }} as i
inner join {{ ref('stg_subskribe__subscriptions') }} as s
    on i.subscription_id = s.subscription_id
where i.account_id != s.account_id