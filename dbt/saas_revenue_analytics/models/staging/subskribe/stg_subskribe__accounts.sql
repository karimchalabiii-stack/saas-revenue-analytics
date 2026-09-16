with source as (

    select
        account_id,
        company_name,
        crmid,
        currency,
        created_at
    from {{ source('subskribe', 'accounts') }}

),

renamed as (

    select
        account_id,
        company_name,
        crmid as hubspot_company_id,
        currency,
        created_at as created_date
    from source

)

select
    account_id,
    company_name,
    hubspot_company_id,
    currency,
    created_date
from renamed