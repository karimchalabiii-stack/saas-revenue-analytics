WITH all_dates AS (

    SELECT
        invoice_date AS date
    FROM {{ ref('stg_subskribe__invoices') }}

    UNION ALL

    SELECT
        start_date AS date
    FROM {{ ref('int_subskribe__subscription_lifecycle') }}

    UNION ALL

    SELECT
        end_date AS date
    FROM {{ ref('int_subskribe__subscription_lifecycle') }}

    UNION ALL

    SELECT
        cancelled_date AS date
    FROM {{ ref('int_subskribe__subscription_lifecycle') }}

    UNION ALL

    SELECT
        subskribe_created_date AS date
    FROM {{ ref('int_subskribe__accounts_enriched') }}

),

date_boundaries AS (

    SELECT
        DATE_TRUNC(MIN(date), YEAR) AS min_date,
        LAST_DAY(MAX(date), YEAR) AS max_date
    FROM all_dates

),

date_spine AS (

    SELECT
        date
    FROM date_boundaries
    CROSS JOIN UNNEST(
        GENERATE_DATE_ARRAY(min_date, max_date, INTERVAL 1 DAY)
    ) AS date

)

SELECT
    date,
    EXTRACT(YEAR FROM date) AS year,
    CONCAT('Q', CAST(EXTRACT(QUARTER FROM date) AS STRING)) AS quarter,
    EXTRACT(MONTH FROM date) AS month,
    FORMAT_DATE('%B', date) AS month_name,
    FORMAT_DATE('%Y-%m', date) AS year_month,
    EXTRACT(ISOWEEK FROM date) AS week,
    FORMAT_DATE('%G-W%V', date) AS year_week,
    EXTRACT(DAY FROM date) AS day,
    CAST(FORMAT_DATE('%u', date) AS INT64) AS day_of_week,
    FORMAT_DATE('%A', date) AS day_name
FROM date_spine