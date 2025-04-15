/* 
Ranking Analysis 

Purpose: 
	- To rank items (e.g., products, customers) based on performance or other metrics
	- To identify top performers or laggards

SQL Function used: 
	- Window Ranking Functions : RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
	- Clauses: GROUP BY, ORDER BY

*/

-- Which 5 products generating the highest revenue?
-- Simple Ranking


SELECT TOP 5
	product_name,
	SUM(sales_amount) AS revenue
FROM
	gold.fact_sales s 
	LEFT JOIN
	gold.dim_products p ON p.product_key = s.product_key
GROUP BY product_name
ORDER BY revenue DESC;


-- Complex but flexibility ranking using Window Functions
WITH ranking AS (
SELECT
	product_name,
	SUM(sales_amount) AS revenue,
	RANK() OVER(ORDER BY SUM(sales_amount) DESC) AS rank_products
FROM
	gold.fact_sales s
	JOIN
	gold.dim_products p ON s.product_key = p.product_key
GROUP BY product_name
)
SELECT 
	product_name,
	revenue
FROM ranking
WHERE rank_products <= 5;


-- What are the 5 worst-performing products in terms of sales? 
SELECT TOP 5
	p.product_name,
	SUM(sales_amount) AS revenue
FROM
	gold.fact_sales s
	JOIN
	gold.dim_products p ON s.product_key = p.product_key
GROUP BY p.product_name
ORDER BY revenue;

-- Find the top 10 customers who have generated the highest revenue
SELECT TOP 10
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(sales_amount) AS revenue
FROM
	gold.dim_customers c
	LEFT JOIN
	gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
	c.customer_key,
	c.first_name,
	c.last_name,
	COUNT(DISTINCT order_number) AS orders_count
FROM
	gold.dim_customers c
	LEFT JOIN
	gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY orders_count;