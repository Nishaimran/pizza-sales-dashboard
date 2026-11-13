-- PIZZA SALES SQL QUERIES (MySQL)

-- A. KPIs

-- 1. Total Revenue
SELECT SUM(total_price) AS Total_Revenue
FROM pizza_sales;

-- 2. Average Order Value
SELECT (SUM(total_price) / COUNT(DISTINCT order_id)) AS Avg_Order_Value
FROM pizza_sales;

-- 3. Total Pizzas Sold
SELECT SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales;

-- 4. Total Orders
SELECT COUNT(DISTINCT order_id) AS Total_Orders
FROM pizza_sales;

-- 5. Average Pizzas Per Order
SELECT CAST(
    SUM(quantity) / COUNT(DISTINCT order_id)
    AS DECIMAL(10,2)
) AS Avg_Pizzas_Per_Order
FROM pizza_sales;


-- B. Daily Trend for Total Orders
SELECT DAYNAME(order_date) AS order_day,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY DAYNAME(order_date);


-- C. Hourly Trend for Orders
SELECT HOUR(order_time) AS order_hours,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY HOUR(order_time)
ORDER BY HOUR(order_time);


-- D. Percentage of Sales by Pizza Category
SELECT pizza_category,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(
           SUM(total_price) * 100 /
           (SELECT SUM(total_price) FROM pizza_sales)
           AS DECIMAL(10,2)
       ) AS PCT
FROM pizza_sales
GROUP BY pizza_category;


-- E. Percentage of Sales by Pizza Size
SELECT pizza_size,
       CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
       CAST(
           SUM(total_price) * 100 /
           (SELECT SUM(total_price) FROM pizza_sales)
           AS DECIMAL(10,2)
       ) AS PCT
FROM pizza_sales
GROUP BY pizza_size
ORDER BY pizza_size;


-- F. Total Pizzas Sold by Pizza Category 
SELECT pizza_category,
       SUM(quantity) AS Total_Quantity_Sold
FROM pizza_sales
GROUP BY pizza_category
ORDER BY Total_Quantity_Sold DESC;


-- G. Top 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name,
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold DESC
LIMIT 5;


-- H. Bottom 5 Best Sellers by Total Pizzas Sold
SELECT pizza_name,
       SUM(quantity) AS Total_Pizza_Sold
FROM pizza_sales
GROUP BY pizza_name
ORDER BY Total_Pizza_Sold ASC
LIMIT 5;
