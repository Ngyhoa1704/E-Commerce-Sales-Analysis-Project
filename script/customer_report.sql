/* 
Customer Report

Purpose:
	- This report consolidates key customer metrics and behaviors 

Highlights:
	1. Gathers essential fields such as names, ages, and transaction details 
	2. Segments customers into categories (VIP, Regular, New) and age groups.
	3. Aggregates customer-level metrics:
		- total orders
		- total sales
		- total quantity purchased
		- total products 
		- lifespan (in months)
	4. Calculate valuable KPIs:
		- recency (months since last order)
		- average order value 
		- average monthly spend
*/

-- 1. Base query: Retrive core columns from table

CREATE VIEW gold.report_customers AS 
WITH base_query AS (

-- 1) Base Query: Retrive core columns from fact_sales and dim_customers tables 

SELECT
	f.order_number,
	f.product_key,
	f.order_date,
	f.sales_amount,
	f.quantity,
	c.customer_key,
	c.customer_number,
	c.first_name + ' ' + c.last_name AS customer_name,
	DATEDIFF(year, c.birthdate, GETDATE()) AS age
FROM
	gold.fact_sales f
	LEFT JOIN
	gold.dim_customers c ON f.customer_key = c.customer_key
WHERE order_date IS NOT NULL
),
customer_aggregation AS (

-- 2) Customer Aggregation: Summarizes key metrics at the customer level 

SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_spending,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS life_span
FROM
	base_query
GROUP BY customer_key,
	customer_number,
	customer_name,
	age
)

-- 3) Return all the results

SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE 
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 and above'
	END AS age_group,
	CASE
		WHEN life_span >= 12 AND total_spending > 5000 THEN 'VIP'
		WHEN life_span >= 12 AND total_spending <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	last_order_date,
	DATEDIFF(month, last_order_date, GETDATE()) AS recency,
	total_orders,
	total_spending,
	total_quantity,
	total_products,
	life_span,
	-- Compute Average Order Value (AOV)
	CASE WHEN total_orders = 0 THEN 0
	ELSE total_spending / total_orders 
	END AS avg_order_value,
	-- Compute Average Monthly Spend
	CASE WHEN life_span = 0 THEN total_spending
    ELSE total_spending / life_span
	END AS avg_monthly_spend
FROM
	customer_aggregation;


SELECT * FROM gold.report_customers;