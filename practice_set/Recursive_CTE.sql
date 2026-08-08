WITH order_counts AS (
    SELECT customer_id, COUNT(*) AS total_orders, SUM(amount) AS total_spent
    FROM orders
    GROUP BY customer_id
    HAVING COUNT(*) > 1
),
city_spend AS (
    SELECT c.city, SUM(oc.total_spent) AS city_total
    FROM customers c
    JOIN order_counts oc ON c.customer_id = oc.customer_id
    GROUP BY c.city
)
SELECT city, city_total
FROM city_spend
ORDER BY city_total DESC
LIMIT 1;