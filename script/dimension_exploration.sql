/* Dimension Exploration

Purpose:
- To explore the structure of dimension tables 

SQL function used:
- DISTINCT
- ORDER BY 
*/

SELECT * FROM gold.dim_customers;
-- Retrieve a list of unique countries from which customers originate 
SELECT DISTINCT
	country
FROM gold.dim_customers
ORDER BY country;


SELECT * FROM gold.dim_products;
-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT
	product_name,
	category,
	subcategory
FROM gold.dim_products
ORDER BY category, subcategory, product_name;

