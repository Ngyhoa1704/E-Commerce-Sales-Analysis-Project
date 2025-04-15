# 🧠 SQL Data Analysis – Retail Sales Data Warehouse

## 📌 Overview
This project showcases advanced SQL techniques to analyze a simulated retail data warehouse. It includes customer, product, and sales data to deliver business insights through segmentation, trends, KPIs, and ranking analysis.

## 🗂️ Datasets
- `gold.fact_sales`: Sales transactions  
- `gold.dim_customers`: Customer demographics  
- `gold.dim_products`: Product details  

## 🎯 Objectives
- Segment customers & products (VIP, High-Performer, etc.)
- Track trends with cumulative and moving averages
- Identify top/bottom products and customers
- Generate customer and product reports using views
- Measure KPIs like total sales, order count, AOV

## 🧪 Techniques Used
- `CASE`, `GROUP BY`, `JOIN`
- Window functions: `SUM() OVER()`, `LAG()`, `RANK()`
- Time functions: `DATEPART()`, `DATETRUNC()`, `FORMAT()`
- Views: `CREATE VIEW` for `report_customers` & `report_products`

## 📊 Key Reports
- `report_customers`: Segmentation, recency, AOV, lifetime value  
- `report_products`: Revenue tiering, recency, monthly revenue  
- Sales trends: Yearly & monthly growth  
- Rankings: Top/bottom products & customers  
- Country/gender breakdown

## 🏗️ Tools
- SQL Server (T-SQL syntax)
- Fact & dimension model

