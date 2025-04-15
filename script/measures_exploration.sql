/* 
Measures Exploration (Key Metrics) 

Purpose: 
- To calculate aggregated metrics (e.g., totals, average) for quick insights.
- To identify overall trend or spot anomalies

SQL Function used:
- COUNT(), SUM(), AVG()
*/

SELECT * FROM gold.fact_sales;

-- Find the total sales
SELECT SUM(sales_amount) AS total_sales 
FROM gold.fact_sales;

-- Find how many items are sold 
SELECT SUM(quantity) AS total_quantity
FROM gold.fact_sales;

-- Find the average selling price
SELECT AVG(price) AS avg_price
FROM gold.fact_sales;

-- Find the Total number of orders
SELECT 
	COUNT(DISTINCT order_number) AS total_orders
FROM gold.fact_sales;

-- Find the total number of products
SELECT
	COUNT(product_name) AS total_products
FROM gold.dim_products;

-- Find the Total number of customers
SELECT
	COUNT(customer_key) AS total_customers 
FROM
	gold.dim_customers;

-- Find the total number of customers that has placed an order
SELECT
	COUNT(DISTINCT customer_key) AS total_customers
FROM
	gold.fact_sales;


-- Generate a report that show all key metrics of the business
SELECT
	'Total Sales' AS measure_name, SUM(sales_amount) AS measure_value FROM gold.fact_sales
UNION ALL
SELECT 
	'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT
	'Average Selling Price', AVG(price) FROM gold.fact_sales
UNION ALL 
SELECT
	'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT
	'Total Products', COUNT(product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(customer_key) FROM gold.dim_customers;