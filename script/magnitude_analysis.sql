/* 
Magnitude Analysis 
Purpose:
	- To quantify data and group results by specific dimensions.
	- For understand data distribution across categories. 

SQL Function used:
	- Aggregate Functions: SUM(), COUNT(), AVG() 
	- GROUP BY, ORDER BY 
*/
SELECT * FROM gold.dim_customers;
-- Find total customers by countries
SELECT
	country,
	COUNT(customer_key) AS total_customers
FROM
	gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;
-- Find total customers by gender
SELECT
	gender,
	COUNT(customer_key) AS total_customers
FROM
	gold.dim_customers
GROUP BY gender
ORDER BY total_customers DESC;

SELECT * FROM gold.dim_products;
-- Find total products by category
SELECT
	category,
	COUNT(product_key) AS total_products
FROM
	gold.dim_products
GROUP BY category
ORDER BY total_products DESC;
-- What is the average costs in each category?
SELECT
	category,
	AVG(cost) AS avg_cost
FROM
	gold.dim_products
GROUP BY category
ORDER BY avg_cost DESC;
-- What is the total revenue generated for each category?
SELECT
	p.category,
	SUM(s.sales_amount) AS total_revenue
FROM
	gold.dim_products p
	LEFT JOIN
	gold.fact_sales s ON p.product_key = s.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;
-- What is the total revenue generated for each customer?
SELECT
	c.customer_key,
	c.first_name,
	c.last_name,
	SUM(s.sales_amount) AS total_revenue
FROM
	gold.dim_customers c
	LEFT JOIN
	gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC;


USE DataWarehouseAnalytics;
-- What is the distribution of sold items across countries?
SELECT
	c.country,
	SUM(quantity) AS total_items
FROM
	gold.dim_customers c
	LEFT JOIN
	gold.fact_sales s ON c.customer_key = s.customer_key
GROUP BY c.country
ORDER BY total_items DESC;
