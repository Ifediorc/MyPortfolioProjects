SELECT TOP (1000) [pizza_id]
      ,[order_id]
      ,[pizza_name_id]
      ,[quantity]
      ,[order_date]
      ,[order_time]
      ,[unit_price]
      ,[total_price]
      ,[pizza_size]
      ,[pizza_category]
      ,[pizza_ingredients]
      ,[pizza_name]
  FROM [PortfolioProject].[dbo].[pizza_sales]

SELECT* FROM pizza_sales

Select*
 FROM pizza_sales
 
 SELECT SUM(total_price) AS Total_Revenue FROM pizza_sales

 SELECT SUM(total_price) / COUNT (DISTINCT order_id) as Avg_Order_Value From pizza_sales

 SELECT SUM(quantity) AS Total_Pizza_Sold FROM pizza_sales

 SELECT COUNT(DISTINCT order_id) AS Total_orders FROM pizza_sales

 SELECT CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10,2)) from pizza_sales

 SELECT CAST(CAST(SUM(quantity) AS DECIMAL(10,2)) / CAST(COUNT(DISTINCT order_id) 
 AS DECIMAL(10,2)) AS DECIMAL(10,2)) AS Avg_Pizzas_Per_order from pizza_sales

 ---Daily Trend
 SELECT DATENAME(DW, order_date) AS order_day, COUNT(DISTINCT order_id) AS Total_orders
 FROM pizza_sales
 GROUP BY DATENAME(DW, order_date)

---Hourly Trend
 SELECT DATEPART(HOUR, order_time) AS order_hours, COUNT(DISTINCT order_id) AS Total_orders
 FROM pizza_sales
 GROUP BY DATEPART(HOUR, order_time)
 ORDER BY DATEPART(HOUR, order_time)

 ---MONTH OF JAN

SELECT * FROM pizza_sales


SELECT pizza_category, SUM(total_price) AS Total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales) AS PCT
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

----Percentage of Sales by Pizza Category

SELECT pizza_category, SUM(total_price) AS Total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales WHERE MONTH(order_date) = 1) AS PCT
FROM pizza_sales 
WHERE MONTH(order_date) = 1
GROUP BY pizza_category;

--Percentage of Sales by Pizza Size
SELECT pizza_size, SUM(total_price) AS Total_sales, SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales) AS PCT
FROM pizza_sales 
GROUP BY pizza_size
ORDER BY PCT DESC

--SHowing in two decimal points
SELECT pizza_size, CAST(SUM(total_price) AS DECIMAL(10,2)) AS Total_sales, CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) 
FROM pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales 
WHERE DATEPART(quarter, order_date)=1
GROUP BY pizza_size
ORDER BY PCT DESC

--Total Pizzas Sold by Pizza Category

SELECT pizza_category, sum(quantity) as Total_Pizzas_Sold
from pizza_sales
Group by pizza_category

--Top 5 Best Sellers by Total Pizzas Sold

SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
From pizza_sales
GROUP BY pizza_name
ORDER by sum(quantity) DESC

SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
From pizza_sales
GROUP BY pizza_name
ORDER by sum(quantity) ASC

SELECT TOP 5 pizza_name, sum(quantity) as Total_Pizzas_Sold
From pizza_sales
WHERE MONTH(order_date) = 1
GROUP BY pizza_name
ORDER by sum(quantity) ASC