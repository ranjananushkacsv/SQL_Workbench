SELECT line_item_line_item_type , AVG(line_item_unblended_cost) AS average_unblended_cost
FROM cur_data
GROUP BY line_item_line_item_type;

