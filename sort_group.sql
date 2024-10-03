-- Retrieve order_id, pizza_id and sum of quantity
SELECT order_id, pizza_id, SUM(quantity) AS total_quantity
FROM order_details
-- GROUP the orders using group by all having total_quantity greater than 3
GROUP BY ALL
HAVING total_quantity > 3
-- ORDER BY order id and total quantity in descending order
ORDER BY order_id, total_quantity DESC