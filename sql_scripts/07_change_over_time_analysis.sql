use data_analysis;
/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - To track trends, growth, and changes in key metrics over time.
    - For time-series analysis and identifying seasonality.
    - To measure growth or decline over specific periods.

SQL Functions Used:
    - Date Functions: DATEPART(), DATETRUNC(), FORMAT()
    - Aggregate Functions: SUM(), COUNT(), AVG()
===============================================================================
*/

-- Analyse sales performance over time
-- Quick Date Functions
select 
	year(order_date) as order_year,
	month(order_date) as order_month,
	sum(sales_amount) as total_sales ,
	count(distinct customer_key) as total_customer,
	sum(quantity) as total_quantity	
from sales
where order_date is not null
group by year(order_date), month(order_date)
order by year(order_date), month(order_date);

-- FORMAT()
select 
	FORMAT(order_date) as order_date,
	sum(sales_amount) as total_sales,
	count(distinct customer_key) as total_customer,
	sum(quantity) as total_quantity
from sales
where order_date is not null
group by FORMAT(order_date)
order by FORMAT(order_date);	

-- DATETRUNC()
SELECT
    DATE_FORMAT(order_date, '%Y-%m-01') AS order_month,
    SUM(sales_amount) AS total_sales,
    COUNT(DISTINCT customer_key) AS total_customers,
    SUM(quantity) AS total_quantity
FROM sales
WHERE order_date IS NOT NULL
GROUP BY DATE_FORMAT(order_date, '%Y-%m-01')
ORDER BY DATE_FORMAT(order_date, '%Y-%m-01');
