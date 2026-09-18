-- Validate invoice amount consistency.
-- Original and NZD-converted invoice amounts must be strictly positive.
-- Expected result: 0 rows.

select
    invoice_id,
    total_amount,
    total_amount_nzd
from {{ ref('stg_subskribe__invoices') }}
where total_amount <= 0
   or total_amount_nzd <= 0