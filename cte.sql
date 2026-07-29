WITH spends AS (
    SELECT customer_id, SUM(amount) AS spent 
    FROM orders 
    GROUP BY customer_id
)
SELECT customer_id, spent 
FROM spends 
WHERE spent > 700;