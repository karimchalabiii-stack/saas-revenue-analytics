with source as (

    select
        company_id,
        company_name,
        size_grouped,
        industry,
        country,
        merged_object_ids,
        created_at
    from {{ source('hubspot', 'companies') }}

),

renamed as (

    select
        company_id,
        company_name,
        size_grouped as company_size,
        industry,
        country,
        merged_object_ids as merged_old_company_ids,
        created_at as created_date
    from source

)

select
    company_id,
    company_name,
    company_size,
    industry,
    country,
    merged_old_company_ids,
    created_date
from renamed