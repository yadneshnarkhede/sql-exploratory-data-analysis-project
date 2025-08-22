/*
===============================================================================
Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors

Highlights:
    1. Gathers essential fields such as names, ages, and transaction details.
	2. Segments customers into categories (VIP, Regular, New) and age groups.
    3. Aggregates customer-level metrics:
	   - total orders
	   - total sales
	   - total quantity purchased
	   - total products
	   - lifespan (in months)
    4. Calculates valuable KPIs:
	    - recency (months since last order)
		- average order value
		- average monthly spend
===============================================================================
*/

-- =============================================================================
-- Create Report: customers
-- =============================================================================

/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
create view gold_report_customer as 
with base_query as(
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from tables
---------------------------------------------------------------------------*/
select 
s.order_number,
s.product_key,
s.order_date,
s.sales_amount,
s.quantity,
c.customer_key,
c.customer_number,
concat(c.first_name,' ',c.last_name) as customers_name,
timestampdiff(year,c.birthdate,CURDATE()) as age 
from sales as s
left join customers as c
on s.customer_key = c.customer_key
where order_Date is not null
)
, customer_aggregation as (
/*---------------------------------------------------------------------------
2) Customer Aggregations: Summarizes key metrics at the customer level
---------------------------------------------------------------------------*/
select 
	customer_key,
	customer_number,
	customers_name,
	age,
	count(distinct customer_number) as total_order,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct product_key) as total_product,
	max(order_date) as last_order_date,
	timestampdiff(month,min(order_date),max(order_date)) as lifespan
from base_query
group by
	customer_key,
	customer_number,
	customers_name,
	age) 

select
customer_key,
customer_number,
customers_name,
age,
case when age < 20 then 'under 20'
     when age between 20 and 29 then '20-20'
     when age between 30 and 39 then '30-39'
     when age between 40 and 49 then '40-49'
     else '50 and above'
	 end age_group,
case when lifespan >= 12 and total_sales then 'VIP'
     when lifespan >= 12 and total_sales then 'Regular'
     else 'NEW'
end as customer_segment,
last_order_date,
timestampdiff(month,last_order_date,CURDATE()) as recency,   ## 4.1 calculate KPIs recency
total_order,
total_sales,
total_quantity,
total_product,
lifespan,
-- Compute average order value(AVO) KPIs 
-- average order value = total sales/total number of order
case when total_sales = 0 then 0
     else round(total_sales / total_order,0) 
end as avg_order_value,
-- average monthly spend KPIs
-- avg_month_spend = total_sales / total number of month
case when lifespan = 0 then 0
     else round(total_sales / lifespan,2)
     end avg_monthly_spend
from customer_aggregation