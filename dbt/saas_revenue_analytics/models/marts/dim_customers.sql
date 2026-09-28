SELECT
    account_id AS customer_id,
    hubspot_company_id,
    canonical_company_id AS hubspot_current_company_id,
    COALESCE(
        hubspot_company_name,
        subskribe_company_name
    ) AS customer_name,
    hubspot_company_name,
    subskribe_company_name,
    company_size,
    industry,
    country,
    currency,
    subskribe_created_date,
    mapping_type
FROM {{ ref('int_subskribe__accounts_enriched') }}