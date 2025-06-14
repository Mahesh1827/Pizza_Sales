USE [data1]
GO

SELECT [order_details_id]
      ,[order_id]
      ,[pizza_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [dbo].[pizza_sales]

GO


-- #1 TOTAL REVENUE

select cast(sum(total_price) as decimal(10,2)) as Total_Revenue
from dbo.pizza_sales;


-- #2 AVERAGE_ORDER_VALUE

select cast(sum(total_price)/ count(distinct order_id) as decimal(10,2)) as Avg_order_value
from dbo.pizza_sales;

--#3 TOTAL PIZZA SOLD

select sum(quantity) as total_pizza_sold
from dbo.pizza_sales;

--#4 TOTAL ORDERS
select count(distinct order_id) as total_orders
from dbo.pizza_sales;

--#5 AVG PIZZA PER ORDER
select cast(cast(sum(quantity) as decimal(10,2)) / cast(count( distinct order_id) as decimal(10,2)) as decimal (10,2)) as avg_pizzas_per_order
from dbo.pizza_sales;

--#6 Daily trend for total orders
SELECT datename(dw,order_date) AS order_day, COUNT(order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY datename(dw,order_date)
ORDER BY total_orders;

--#7 Month Trend for orders
SELECT datename(MONTH,order_date) AS order_day, COUNT(order_id) AS total_orders
FROM dbo.pizza_sales
GROUP BY datename(MONTH,order_date)

--#8 % of sales by pizza category
SELECT 
    pizza_category, 
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100.0 / 
        (SELECT SUM(total_price) FROM dbo.pizza_sales) 
        AS DECIMAL(10,2)) AS pct
FROM 
    dbo.pizza_sales
GROUP BY 
    pizza_category;



--#9 % of sales by pizza size
SELECT 
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10,2)) AS total_revenue,
    CAST(SUM(total_price) * 100.0 / 
        (SELECT SUM(total_price) FROM dbo.pizza_sales) 
        AS DECIMAL(10,2)) AS pct
FROM 
    dbo.pizza_sales
GROUP BY 
    pizza_size
ORDER BY
    pizza_size;

--#10Total pizzas sold by category
SELECT 
    pizza_category, 
    SUM(quantity) AS total_pizzas_sold 
    FROM dbo.pizza_sales
    --where MONTH(order_date) = 2
GROUP BY 
    pizza_category
order by total_pizzas_sold desc

--11 TOP5 PIZZAS BY REVENUE
select 
    Top 5 pizza_name, 
    sum(total_price) as Total_revenue
    FROM dbo.pizza_sales
GROUP BY 
    pizza_name
order by 
    Total_revenue desc


--12 BOTTOM 5 PIZZAS BY REVENUE
select 
    Top 5 pizza_name, 
    sum(total_price) as Total_revenue
    FROM dbo.pizza_sales
GROUP BY 
    pizza_name
order by 
    Total_revenue

--13 TOP 5 PIZZAS BY TOTAL ORDERS
select 
    Top 5 pizza_name, 
    COUNT(distinct order_id) as Total_orders
    FROM dbo.pizza_sales
GROUP BY 
    pizza_name
order by 
    Total_orders desc;

--14 BOTTOM 5 PIZZAS BY TOTAL ORDERS
select 
    Top 5 pizza_name, 
    count(distinct order_id) as Total_orders
    FROM dbo.pizza_sales
GROUP BY 
    pizza_name
order by 
    Total_orders;

--15 TOP 5 PIZZAS BY QUANTITY
select 
    Top 5 pizza_name, 
    sum(quantity) as Total_pizzas_sold
    FROM dbo.pizza_sales
GROUP BY 
    pizza_name
order by 
    Total_pizzas_sold desc;

--16 BOTTOM 5 PIZZAS BY QUANTITY
select 
    Top 5 pizza_name, 
    sum(quantity) as Total_pizzas_sold
    FROM dbo.pizza_sales
GROUP BY 
    pizza_name
order by 
    Total_pizzas_sold;

