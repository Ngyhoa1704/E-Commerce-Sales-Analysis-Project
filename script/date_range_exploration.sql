/* 
Date Range Exploration 

Purpose: 
- To determine the temporal boundaries of key data points.
- To understand the range of historical data 

SQL function used: 
- MIN(), MAX(), DATEDIFF() 
*/
SELECT * FROM gold.fact_sales;
-- Determine the first and last order date and the total duration in month 
SELECT
	MIN(order_date) AS first_order_date,
	MAX(order_date) AS last_order_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS order_range_month
FROM
	gold.fact_sales;

SELECT * FROM gold.dim_customers;
-- Find the youngest and oldest customer based on birthdate

SELECT
	MIN(birthdate) AS oldest_birthdate,
	DATEDIFF(YEAR, MIN(birthdate),CAST(GETDATE() AS DATE)) AS oldest_age,
	MAX(birthdate) AS youngest_birthdate,
	DATEDIFF(YEAR, MAX(birthdate), CAST(GETDATE() AS DATE)) AS youngest_age
FROM
	gold.dim_customers;

-- Additional: Find the youngest and oldest customer along with their name
WITH AgeExtremes AS (
	SELECT
		MIN(birthdate) AS oldest_birthdate,
		MAX(birthdate) AS youngest_birthdate
	FROM
		gold.dim_customers
)
SELECT
	c.first_name + ' ' + c.last_name AS full_name,
	c.birthdate,
	DATEDIFF(YEAR, c.birthdate, CAST(GETDATE() AS DATE)) AS age,
	CASE 
		WHEN c.birthdate = oldest_birthdate THEN 'oldest' 
		WHEN c.birthdate = youngest_birthdate THEN 'youngest'
	END AS age_group
FROM
	gold.dim_customers c 
	JOIN
	AgeExtremes ae ON c.birthdate = ae.oldest_birthdate OR c.birthdate = ae.youngest_birthdate;