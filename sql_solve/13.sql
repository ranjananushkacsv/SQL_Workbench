SELECT line_item_account_id, COUNT(line_item_usage_account_id)
FROM cur_data
GROUP BY line_item_account_id;

SELECT line_item_usage_account_id, COUNT(*) AS total_line_items
FROM cur_data
GROUP BY line_item_usage_account_id;