/* 
Cumulative Analysis and Moving Average Analysis

Purpose: 
	- To calculate running totals and  moving averages for key metrics 
	- To track performance over time cumulatively
	- Useful for growth analysis or identifying long-term trends

SQL Function used:
	- Window Functions: SUM() OVER(), AVG() OVER() 


*/
-- Calculate the total sales per year
-- and the running total of sales over time
USE DataWarehouseAnalytics;
WITH t1 AS (
	SELECT
		DATETRUNC(YEAR, order_date) AS yearly,
		SUM(sales_amount) AS total_sales,
		AVG(price) AS avg_price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR, order_date)
)
SELECT 
	yearly,
	total_sales,
	SUM(total_sales) OVER(ORDER BY yearly) AS running_total_sales,
	AVG(avg_price) OVER(ORDER BY yearly) AS moving_avg_price
FROM t1;


-- Calculate the total sales monthly by year
-- and the running total of sales over time by year
WITH t2 AS (
	SELECT
		YEAR (order_date) AS year,
		MONTH(order_date) AS month,
		SUM(sales_amount) AS total_sales,
		AVG(price) AS avg_price
	FROM
		gold.fact_sales
	WHERE DATETRUNC(YEAR, order_date) IS NOT NULL
	GROUP BY YEAR(order_date),
			 MONTH(order_date)
	)
SELECT
	year,
	month,
	total_sales,
	SUM(total_sales) OVER(PARTITION BY year ORDER BY month) AS cumulative_sales,
	AVG(avg_price) OVER(PARTITION BY year ORDER BY month) AS moving_avg_price
FROM
	t2
