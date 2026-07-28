-- subquerry: query written inside another query
-- Scalar Subquery: returns a single value )one row or one coloumn) 
-- corelated subquery: a subquery that depends on the outer subquery

-- EXISTS : checks if a subquery returns any rows, it does not care about what it reurns, just that something is returned 

```sql
SELECT order_id, amount
FROM orders
WHERE amount > (SELECT AVG(amount) FROM orders);
```
```sql
SELECT o1.order_id, o1.customer_id, o1.amount
FROM orders o1
WHERE o1.amount > (
    SELECT AVG(o2.amount) 
    FROM orders o2 
    WHERE o2.customer_id = o1.customer_id);
```