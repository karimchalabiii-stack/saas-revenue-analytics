with source as (

    select
        subscription_id,
        account_id,
        subscription_state,
        start_date,
        end_date,
        cancelled_date,
        renewed_from_subscription_id,
        creation_time,
        updated_at
    from {{ source('subskribe', 'subscriptions') }}

),

renamed as (

    select
        subscription_id,
        account_id,
        subscription_state,
        start_date,
        end_date,
        cancelled_date,
        renewed_from_subscription_id,
        creation_time as created_at,
        updated_at
    from source

)

select
    subscription_id,
    account_id,
    subscription_state,
    start_date,
    end_date,
    cancelled_date,
    renewed_from_subscription_id,
    created_at,
    updated_at
from renamed