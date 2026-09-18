with source as (

    select
        invoice_id,
        account_id,
        subscription_id,
        invoice_date,
        total,
        total_nzd,
        currency,
        status
    from {{ source('subskribe', 'invoices') }}

),

renamed as (

    select
        invoice_id,
        account_id,
        subscription_id,
        invoice_date,
        cast(total as numeric) as total_amount,
        cast(total_nzd as numeric) as total_amount_nzd,
        currency,
        status
    from source

)

select
    invoice_id,
    account_id,
    subscription_id,
    invoice_date,
    total_amount,
    total_amount_nzd,
    currency,
    status
from renamed