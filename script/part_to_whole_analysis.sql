/* 
Part-to-Whole Analysis

Purpose:
	- To compare difference or metrics accross dimensions or time periods
	- To evaluate differences between categories
	- Useful for A/B testing or regional comparisons 

SQL Function used:
	- SUM(), AVG(): Aggregates values for comparison
	- Window Functions: SUM() OVER() for total calculations

*/

-- Which categories contributes the most to overall sales?
WITH category_sales AS (
SELECT 
	p.category,
	SUM(sales_amount) AS total_sales
FROM
	gold.fact_sales s
	LEFT JOIN
	gold.dim_products p ON s.product_key = p.product_key
GROUP BY p.category
)
SELECT
	category,
	total_sales,
	SUM(total_sales) OVER() AS overall_sales,
	ROUND(CAST(total_sales AS float) / SUM(total_sales) OVER() * 100, 2) AS percentage
FROM
	category_sales

