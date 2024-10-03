SELECT 
    pt.category,
	-- Calculate total_revenue 
    SUM(p.price * od.quantity) total_revenue
FROM order_details AS od
-- NATURAL JOIN all tables
NATURAL JOIN pizzas AS p 
NATURAL JOIN pizza_type AS pt
-- GROUP the records by category from pizza_type table
GROUP BY pt.category
-- ORDER by total_revenue and limit the records
ORDER BY total_revenue DESC
LIMIT 1

SELECT COUNT(o.order_id) AS total_orders
FROM orders AS o
-- Use appropriate JOIN
LEFT JOIN order_details AS od
ON o.order_id = od.order_id


SELECT COUNT(o.order_id) AS total_orders,
        AVG(p.price) AS average_price,
        -- Calculate total revenue
        SUM(p.price * od.quantity) AS total_revenue,
        -- Get the name from pizza_type table
		pt.name AS pizza_name
FROM orders AS o
-- Use appropriate JOIN
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
-- Use appropriate JOIN with pizzas table
RIGHT JOIN pizzas p
ON od.pizza_id = p.pizza_id
-- Natural join pizza_type table
NATURAL JOIN pizza_type AS pt
GROUP BY pt.name, pt.category
ORDER BY total_revenue desc, total_orders desc


SELECT pt.name, 
	   pt.category, 
       o.order_date,
       -- Get max quantity from lateral query
       x.max_quantity
FROM pizzas AS pz
JOIN pizza_type AS pt ON pz.pizza_type_id = pt.pizza_type_id
JOIN order_details AS od ON pz.pizza_id = od.pizza_id
-- Join with orders table
JOIN orders AS o ON o.order_id = od.order_id,    
LATERAL (
  -- Select max of order_details quantity
    SELECT MAX(od2.quantity) AS max_quantity
    FROM order_details AS od2
    -- Join with pizzas table
    JOIN pizzas AS pz2 
        ON od2.pizza_id = pz2.pizza_id
    -- Filtering condition for the subquery
    WHERE pz2.pizza_type_id = pz.pizza_type_id
) AS x
WHERE od.quantity = x.max_quantity
GROUP BY pt.name, pt.category, o.order_date, x.max_quantity
ORDER BY pt.name;