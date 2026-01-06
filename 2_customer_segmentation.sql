WITH ltv_per_customer AS (
    SELECT oc.customer_unique_id,
        sum(ooi.price) AS customer_ltv
    FROM olist_orders oo
        INNER JOIN olist_order_items ooi ON oo.order_id = ooi.order_id
        INNER JOIN olist_customers oc ON oo.customer_id = oc.customer_id
    GROUP BY oc.customer_unique_id
),
ranked_customers AS (
    SELECT customer_unique_id,
        customer_ltv,
        ntile(4) OVER (
            ORDER BY customer_ltv
        ) AS quartiles,
        CASE
            WHEN ntile(4) OVER (ORDER BY customer_ltv) = 1 THEN 'Low_value'
            WHEN ntile(4) OVER (ORDER BY customer_ltv) = 4 THEN 'High_value'
            ELSE 'Mid_value'
        END AS customer_segment
    FROM ltv_per_customer
)
SELECT customer_segment,
    sum(customer_ltv) AS total_revenue,
    round((SUM(customer_ltv) * 100.0 / SUM(SUM(customer_ltv)) OVER ())::numeric,2) AS revenue_pct,
    count(DISTINCT customer_unique_id) AS customers_count
FROM ranked_customers
GROUP BY customer_segment
ORDER BY total_revenue DESC