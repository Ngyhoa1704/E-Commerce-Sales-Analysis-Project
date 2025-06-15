# SQL Business Analysis Project

This project showcases a collection of SQL scripts used to analyze business performance data. Each script focuses on a different analytical perspective, using SQL techniques for querying, reporting, and exploration.

---

## Project Goals

- Segment customers & products (VIP, High-Performer, etc.)
- Track trends with cumulative and moving averages
- Identify top/bottom products and customers
- Generate customer and product reports using views
- Measure KPIs like total sales, order count, AOV

## Datasets
- `gold.fact_sales`: Sales transactions  
- `gold.dim_customers`: Customer demographics  
- `gold.dim_products`: Product details 

## Tools & Skills

- SQL (compatible with PostgreSQL, MySQL, or BigQuery)
- CTEs
- Window Functions
- Aggregations (SUM, COUNT, AVG, etc.)
- Subqueries
- Filtering and Sorting
- CASE WHEN Logic


## File Overview

| File Name                      | Purpose                              | Key SQL Concepts Used               |
|-------------------------------|--------------------------------------|-------------------------------------|
| `5_data_segmentation.sql`     | Segment data into logical groups     | CTEs, GROUP BY, ORDER BY, subqueries |
| `Cumulative_sales.sql`        | Calculate running totals             | CTEs, Window functions, Aggregates  |
| `change_over_time_analysis.sql`| Analyze trends over time           | GROUP BY, Aggregates, ORDER BY      |
| `customer_report.sql`         | Generate summary report per customer | CTEs, CASE WHEN, Subqueries         |
| `date_range_exploration.sql`  | Filter and explore by date ranges    | CTEs, Subqueries                    |
| `dimension_exploration.sql`   | Explore available dimensions         | ORDER BY                            |
| `magnitude_analysis.sql`      | Assess scale/magnitude of metrics    | GROUP BY, Aggregates                |
| `measures_exploration.sql`    | Examine different KPIs               | Aggregates                          |
| `part_to_whole_analysis.sql`  | Analyze parts of a whole (e.g., share) | CTEs, Window functions, Aggregates |
| `performance_analysis.sql`    | Detailed performance review          | CTEs, Joins, Window functions       |
| `product_report.sql`          | Generate product-level summaries     | CTEs, CASE WHEN                     |
| `ranking_analysis.sql`        | Rank entities based on KPIs          | CTEs, Window functions, Aggregates  |



## Sample Use Cases

- **Who are the top-performing products this month?**
- **What is the cumulative growth in sales over time?**
- **Which customers generate the most revenue?**
- **How is performance trending by dimension/category?**

## Key Reports
- `report_customers`: Segmentation, recency, AOV, lifetime value  
- `report_products`: Revenue tiering, recency, monthly revenue  
- Sales trends: Yearly & monthly growth  
- Rankings: Top/bottom products & customers  
- Country/gender breakdown

## Tools
- SQL Server (T-SQL syntax)
- Fact & dimension model




