SELECT
    invoice_id,
    account_id AS customer_id,
    subscription_id,
    invoice_date,
    total_amount,
    total_amount_nzd,
    currency,
    status,
    CAST(
        CASE
            WHEN status IN ('PAID', 'POSTED') THEN total_amount_nzd
            ELSE 0
        END AS NUMERIC
    ) AS billed_revenue_nzd
    
FROM {{ ref('stg_subskribe__invoices') }}