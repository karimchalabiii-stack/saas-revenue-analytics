select
    accounts.account_id,
    accounts.company_name as subskribe_company_name,
    accounts.currency,
    accounts.created_date as subskribe_created_date,

    mapping.hubspot_company_id,
    mapping.canonical_company_id,
    mapping.mapping_type,

    hubspot.company_name as hubspot_company_name,
    hubspot.company_size,
    hubspot.industry,
    hubspot.country

from {{ ref('stg_subskribe__accounts') }} as accounts

left join {{ ref('int_hubspot__company_id_mapping') }} as mapping
    on accounts.account_id = mapping.account_id

left join {{ ref('stg_hubspot__companies') }} as hubspot
    on mapping.canonical_company_id = hubspot.company_id