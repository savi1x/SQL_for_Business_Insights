WITH customer_orders AS (
    SELECT oc.customer_unique_id,
        oo.order_id,
        oo.order_purchase_timestamp,
        MIN(oo.order_purchase_timestamp) OVER (
            PARTITION BY oc.customer_unique_id
        ) AS first_purchase_date
    FROM olist_orders oo
        JOIN olist_customers oc ON oo.customer_id = oc.customer_id
    WHERE oo.order_status = 'delivered'
),
cohort_data AS (
    SELECT customer_unique_id,
        TO_CHAR(first_purchase_date, 'YYYY-MM') AS cohort_month,
        (
            EXTRACT(
                YEAR
                FROM order_purchase_timestamp
            ) - EXTRACT(
                YEAR
                FROM first_purchase_date
            )
        ) * 12 + (
            EXTRACT(
                MONTH
                FROM order_purchase_timestamp
            ) - EXTRACT(
                MONTH
                FROM first_purchase_date
            )
        ) AS month_lag
    FROM customer_orders
),
cohort_counts AS (
    SELECT cohort_month,
        month_lag,
        COUNT(DISTINCT customer_unique_id) AS customers_count
    FROM cohort_data
    GROUP BY cohort_month,
        month_lag
),
cohort_sizes AS (
    SELECT cohort_month,
        customers_count AS cohort_size
    FROM cohort_counts
    WHERE month_lag = 0
)
SELECT cc.cohort_month,
    cc.month_lag,
    cc.customers_count,
    cs.cohort_size,
    ROUND(100.0 * cc.customers_count / cs.cohort_size, 2) AS retention_pct
FROM cohort_counts cc
    JOIN cohort_sizes cs ON cc.cohort_month = cs.cohort_month
ORDER BY cc.cohort_month,
    cc.month_lag