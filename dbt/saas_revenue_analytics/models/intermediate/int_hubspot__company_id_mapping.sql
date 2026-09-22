with hubspot_merged_ids as (

    select 
        company_id as current_company_id,
        trim(old_company_id) as old_company_id
    from {{ ref('stg_hubspot__companies') }}
    cross join unnest(split(merged_old_company_ids,';')) as old_company_id
    where merged_old_company_ids is not null

),

company_id_mapping as (

    select
        accounts.account_id,
        accounts.hubspot_company_id,
        coalesce(
            current_company.company_id,
            merged_company.current_company_id
        ) as canonical_company_id,

        case
            when current_company.company_id is not null then 'direct'
            when merged_company.current_company_id is not null then 'merged'
            else 'unresolved'
        end as mapping_type

    from {{ ref('stg_subskribe__accounts') }} as accounts

    left join {{ ref('stg_hubspot__companies') }} as current_company
        on accounts.hubspot_company_id = current_company.company_id
    
    left join hubspot_merged_ids as merged_company
        on accounts.hubspot_company_id = merged_company.old_company_id

)

select
    account_id,
    hubspot_company_id,
    canonical_company_id,
    mapping_type
from company_id_mapping