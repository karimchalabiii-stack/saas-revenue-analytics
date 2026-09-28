SELECT
    subscription_id,
    account_id AS customer_id,
    subscription_state,
    start_date,
    end_date,
    cancelled_date,
    renewed_from_subscription_id,
    is_renewal,
    lifecycle_start_date
FROM {{ ref('int_subskribe__subscription_lifecycle') }}