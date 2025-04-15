/* 
Performance Analysis 

Purpose: 
	- To measure the performance of the products, customers, or regions over time
	- For benchmarking and identifying high-performing entities
	- To track yearly trends and growth

SQL Function used:
	- LAG(): Access data from previous rows.
	- AVG() OVER(): Computes average values within partitions.
	- CASE: Defines conditional logic for trend analysis

*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

WITH yearly_product_sales AS (
SELECT
	YEAR(s.order_date) AS year,
	p.product_name,
	SUM(s.sales_amount) AS current_sales
FROM 
	gold.fact_sales s 
LEFT JOIN 
	gold.dim_products p ON s.product_key = p.product_key
WHERE YEAR(s.order_date) IS NOT NULL
GROUP BY YEAR(s.order_date), p.product_name
)
SELECT 
	year,
	product_name,
	current_sales,
	AVG(current_sales) OVER(PARTITION BY product_name) AS avg_sales,
	current_sales - AVG(current_sales) OVER(PARTITION BY product_name) AS diff_avg,
	CASE
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) > 0 THEN 'Above Avg'
		WHEN current_sales - AVG(current_sales) OVER(PARTITION BY product_name) < 0 THEN 'Below Avg'
		ELSE 'Avg'
	END AS avg_change,
	-- Year-over-Year analysis
	LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year) AS py_sales,
	current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year) AS diff_py,
	CASE
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) OVER(PARTITION BY product_name ORDER BY year) < 0 THEN 'Decrease'
		ELSE 'No change'
	END AS prev_change
FROM
	yearly_product_sales;
