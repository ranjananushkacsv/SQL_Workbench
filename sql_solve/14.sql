SELECT line_item_product_code, SUM(line_item_unblended_cost) AS total_cost
FROM cur_data
GROUP BY line_item_product_code
HAVING SUM(line_item_unblended_cost) > 300;

