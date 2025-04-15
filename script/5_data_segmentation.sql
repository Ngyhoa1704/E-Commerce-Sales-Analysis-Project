/* 
Data Segmentation Analysis 

Purpose: 
	- To group data into meaningful categories for targeted insights 
	- For customer segmentation, product categorization, or regional analysis 

SQL Function used:
	- CASE: Defines custom segmentation logic
	- GROUP BY: Groups data into segments

*/

/* Segment products into cost ranges and count how many products fall into each segment */
WITH product_segments AS (
SELECT
	product_key,
	product_name,
	cost,
	CASE
		WHEN cost < 100 THEN 'Below 100'
		WHEN cost BETWEEN 100 AND 500 THEN '100-500'
		WHEN cost BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM
	gold.dim_products
)
SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM
	product_segments
GROUP BY cost_range
ORDER BY total_products DESC;

/* Group customers into three segments based on their spending behavior:
	- VIP: Customers with at least 12 months of history and spending more than 5000.
	- Regular: Customers with at least 12 months of history but spending 5000 or less
	- New: Customers with a lifespan less than 12 months 
And find the total number of customers by each group 
*/
WITH customer_spending AS (
SELECT
	customer_key,
	SUM(sales_amount) AS total_spending,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS life_span
FROM
	gold.fact_sales
GROUP BY customer_key
),
customer_segments AS (
SELECT
	customer_key,
	total_spending,
	life_span,
	CASE
		WHEN total_spending > 5000 AND life_span >= 12 THEN 'VIP'
		WHEN total_spending <= 5000 AND life_span >= 12 THEN 'Regular'
		ELSE 'New'
	END AS customer_group
FROM
	customer_spending
)
SELECT 
	customer_group,
	COUNT(customer_key) AS total_customers
FROM
	customer_segments
GROUP BY customer_group
ORDER BY total_customers DESC;



