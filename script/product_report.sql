/* 
Product Report 

Purpose:
	- This report consolidates key product metrics and behaviors.

Highlights:
	1. Gathers essential fields such as product name, category, subcategory, and cost.
	2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
	3. Aggregate product-level metrics:
		- Total Orders
		- Total Sales
		- Total Quantity Sold
		- Total Customers (unique)
		- Lifespan (in months) 
	4. Calculate valuable KPIs:
		- recency (months since last sale)
		- average order revenue (AOR)
		- average monthly revenue 

*/ 
CREATE VIEW gold.report_products AS 
WITH base_query AS ( 

-- 1) Base Query: Retrieve core columns from fact_sales and dim_products tables */

SELECT
	f.order_number,
	f.order_date,
	f.customer_key,
	f.sales_amount,
	f.quantity,
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.cost
FROM
	gold.fact_sales f
	LEFT JOIN
	gold.dim_products p ON f.product_key = p.product_key
WHERE f.order_date IS NOT NULL
),
product_aggregation AS (

-- 2) Product Aggregation: Summarizes key metrics at the product level

SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity_sold,
	COUNT(DISTINCT customer_key) AS total_customers,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS life_span,
	MAX(order_date) AS last_order_date,
	ROUND(AVG(CAST(sales_amount AS float) / quantity),1) AS avg_selling_price
FROM
	base_query
GROUP BY product_key,
	product_name,
	category,
	subcategory,
	cost
)

-- 3. Combine all results into one

SELECT
	product_key,
	product_name,
	category,
	subcategory,
	cost,
	last_order_date,
	DATEDIFF(MONTH, last_order_date, GETDATE()) AS recency,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	life_span,
	total_orders,
	total_sales,
	total_quantity_sold,
	total_customers,
	avg_selling_price,
-- Average Order Revenue 
	CASE WHEN total_orders = 0 THEN 0
	ELSE total_sales / total_orders
	END AS avg_order_revenue,
-- Average Monthly Revenue
	CASE WHEN life_span = 0 THEN total_sales
	ELSE total_sales / life_span
	END AS avg_monthly_revenue
FROM 
	product_aggregation;


SELECT * FROM gold.report_products;


-- In each category, define the number of product_segment
SELECT
	category,
	COUNT(
		CASE WHEN product_segment = 'High-Performer' THEN product_key 
		END) AS high_count,
	COUNT(
		CASE WHEN product_segment = 'Mid-Range' THEN product_key 
		END) AS mid_count,
	COUNT(
		CASE WHEN product_segment = 'Low-Performer' THEN product_key 
		END) AS low_count
FROM
	gold.report_products
GROUP BY category;