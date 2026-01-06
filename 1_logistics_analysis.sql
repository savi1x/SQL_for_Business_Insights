WITH base_info AS (
  SELECT oo.customer_id,
    oo.order_estimated_delivery_date::date,
    oo.order_delivered_customer_date::date,
    oo.order_estimated_delivery_date::date - oo.order_delivered_customer_date::date AS delivery_delays,
    oor.order_id,
    oor.review_score,
    CASE
      WHEN (oo.order_estimated_delivery_date::date - oo.order_delivered_customer_date::date) >= 0 THEN 'On time'
      WHEN (oo.order_estimated_delivery_date::date - oo.order_delivered_customer_date::date) BETWEEN -3 AND -1 THEN '1-3 Days Late'
      WHEN (oo.order_estimated_delivery_date::date - oo.order_delivered_customer_date::date) BETWEEN -6 AND -4 THEN '4-6 Days Late'
      WHEN (oo.order_estimated_delivery_date::date - oo.order_delivered_customer_date::date) <= -7 THEN '7+ Days Late'
    END AS delays_category
  FROM olist_orders oo
    INNER JOIN olist_order_reviews oor ON oo.order_id = oor.order_id
  WHERE oo.order_delivered_customer_date IS NOT null
)
SELECT delays_category,
  ROUND(AVG(review_score), 2) AS avg_review_score,
  COUNT(DISTINCT order_id) AS orders_count,
  ROUND(COUNT(DISTINCT order_id) * 100.0 / SUM(COUNT(DISTINCT order_id)) OVER (),2) AS pct_of_total
FROM base_info
GROUP BY delays_category
ORDER BY avg_review_score DESC