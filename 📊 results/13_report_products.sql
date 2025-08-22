/*
===============================================================================
Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.

Highlights:
    1. Gathers essential fields such as product name, category, subcategory, and cost.
    2. Segments products by revenue to identify High-Performers, Mid-Range, or Low-Performers.
    3. Aggregates product-level metrics:
       - total orders
       - total sales
       - total quantity sold
       - total customers (unique)
       - lifespan (in months)
    4. Calculates valuable KPIs:
       - recency (months since last sale)
       - average order revenue (AOR)
       - average monthly revenue
===============================================================================
*/
-- =============================================================================
-- Create Report: gold.report_products
-- =============================================================================
create view report_products as 
with base_query as(
/*---------------------------------------------------------------------------
1) Base Query: Retrieves core columns from fact_sales and dim_products
---------------------------------------------------------------------------*/
select
s.order_number,
s.order_date,
s.customer_key,
s.sales_amount,
s.quantity,
p.product_key,
p.product_name,
p.category,
p.subcategory,
p.cost
from sales as s
left join products as p
on s.product_key = p.product_key
where order_date is not null
),
product_aggregation as (
select
	product_key,
    product_name,
    category,
    subcategory,
    cost,
    timestampdiff(month,min(order_date),max(order_date)) as lifespan,
    max(order_date) as last_sale_date,
	count(distinct order_number) as total_order,
	sum(sales_amount) as total_sales,
	sum(quantity) as total_quantity,
	count(distinct customer_key)as total_customers,
    AVG(CAST(sales_amount AS FLOAT) / NULLIF(quantity, 0)) as avg_selling_price
from base_query
group by 
	product_key,
    product_name,
    category,
    subcategory,
    cost
)
/*---------------------------------------------------------------------------
  3) Final Query: Combines all product results into one output
---------------------------------------------------------------------------*/
select
	product_key,
    product_name,
    category,
    subcategory,
    cost,
    last_sale_date,
    timestampdiff(month,last_sale_date,curdate()) as recency_in_month,
    case when total_sales > 50000 then 'High-Performer'
         when total_sales >= 10000 then 'Mid_range'
         else 'Low-performer'
	end as product_segment,
    lifespan,
	total_order,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
    -- Calculates valuable KPIs
    -- average order revenue (AOR)
    case 
        when total_order = 0 then 0
        else total_sales / total_order
	end as avg_order_revenue,
    -- average monthly revenue
    case
        when lifespan = 0 then 0
        else total_sales / lifespan  
	end as avg_monthly_revenue
from 
product_aggregation;

select * from  report_products
