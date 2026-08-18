SELECT 
    line_item_id,
    line_item_unblended_cost,
    CASE 
        WHEN line_item_unblended_cost < 0 THEN 'Credit/Refund'
        WHEN line_item_line_item_type = 'Tax' THEN 'Tax'
        ELSE 'Usage'
    END AS cost_category
FROM cur_data;