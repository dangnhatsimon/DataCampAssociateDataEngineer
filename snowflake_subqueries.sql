SELECT 
    pt.name, 
    pt.category, 
    SUM(od.quantity) AS total_quantity
FROM pizza_type AS pt
-- Join pizzas and order_details table
JOIN pizzas AS pz
    ON pt.pizza_type_id = pz.pizza_type_id
JOIN order_details AS od
    ON pz.pizza_id = od.pizza_id
-- Group by name and category
GROUP BY pt.name, pt.category
HAVING SUM(od.quantity) < (
    -- Calculate AVG of total_quantity 
    SELECT AVG(sub.total_quantity)
    FROM (
        SELECT SUM(od2.quantity) AS total_quantity
        FROM pizzas AS pz2
        JOIN order_details AS od2
            ON pz2.pizza_id = od2.pizza_id
        GROUP BY pz2.pizza_type_id
    ) AS sub
)
-- Order  by total_quantity in ascending order
ORDER BY total_quantity ASC

