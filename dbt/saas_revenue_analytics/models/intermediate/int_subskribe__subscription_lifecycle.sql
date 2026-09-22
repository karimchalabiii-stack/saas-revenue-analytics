select
    subscription_id,
    account_id,
    subscription_state,
    start_date,
    end_date,
    cancelled_date,
    renewed_from_subscription_id,
    renewed_from_subscription_id is not null as is_renewal,

    min(start_date) over (
        partition by account_id
    ) as lifecycle_start_date

from {{ ref('stg_subskribe__subscriptions') }}