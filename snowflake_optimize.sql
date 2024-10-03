WITH filtered_orders AS (
  -- Select order_id, order_date and filter records where order_date is greater than November 1, 2015.
  SELECT order_id, order_date 
  FROM orders
  WHERE order_date > '2015-11-01'
)

, filtered_pizza_type AS (
  -- Select name, pizza_type_id and filter the pizzas which has Veggie category
  SELECT name, pizza_type_id 
  FROM pizza_type
  WHERE category = 'Veggie'
)

SELECT o.order_id, o.order_date, pt.name, od.quantity
-- Get the details from filtered_orders CTE
FROM filtered_orders AS o
JOIN order_details AS od ON o.order_id = od.order_id
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
-- JOIN CTE filtered_pizza_type on common column
JOIN filtered_pizza_type AS pt ON pt.pizza_type_id = p.pizza_type_id