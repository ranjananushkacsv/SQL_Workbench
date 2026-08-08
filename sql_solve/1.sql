-- Select all columns for line items belonging to product code `EC2`.

SELECT *  FROM cur_data
WHERE line_item_product_code = 'EC2';