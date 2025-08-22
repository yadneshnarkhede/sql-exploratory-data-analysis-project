#Performance Analysis
/*
current measure - target measure
current sales - average sales
current year sales - previous year sales
current sales - lowest sales
*/

/*
Task
Analyze a the yearly performance of products 
by comparing each product's sales to both 
its average sales performace and the prevous year sales  */

/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.

SQL Functions Used:
    - LAG(): Accesses data from previous rows.
    - AVG() OVER(): Computes average values within partitions.
    - CASE: Defines conditional logic for trend analysis.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */

with yearly_product_sales as (
select 
year(s.order_date) as order_year,
p.product_name,
sum(s.sales_amount) as current_sales
from sales as s
left join products as p
on s.product_key = p.product_key
where year(s.order_date) is not null
group by year(s.order_date),p.product_name
)
select 
order_year,
product_name,
current_sales,
round(avg(current_sales) over(partition by product_name),2) as avg_sales,
current_sales - round(avg(current_sales) over(partition by product_name),2) as diff_avg,
case when current_sales - round(avg(current_sales) over(partition by product_name),2) > 0 then 'Above avg'
     when current_sales - round(avg(current_sales) over(partition by product_name),2) < 0 then 'Below avg'
     else 'Avg'
     end avg_change,
lag(current_sales) over(partition by product_name order by order_year) as previous_year_sales,
current_sales - lag(current_sales) over(partition by product_name order by order_year) as diff_py_sales,
case when current_sales - lag(current_sales) over(partition by product_name order by order_year) > 0 then 'Increasing'
     when current_sales - lag(current_sales) over(partition by product_name order by order_year) < 0 then 'Decreasing'
     else 'No Change'
     end py_change
from yearly_product_sales
order by product_name,order_year;



/*
Task-2
Analyze a the monthly performance of products 
by comparing each product's sales to both 
its average sales performace and the prevous month sales  */
with monthly_product_sales as(
select
date_format(s.order_date,'%Y-%m') as order_month,
p.product_name,
sum(s.sales_amount) as current_sales
from sales as s
left join products as p
on s.product_key = p.product_key
where s.order_date is not null
group by s.order_date,p.product_name
)
select 
order_month,
product_name,
current_sales,
round(avg(current_sales) over(partition by product_name),2) as avg_sales,
current_sales - round(avg(current_sales) over(partition by product_name),2) as diff_avg,
case when current_sales - round(avg(current_sales) over(partition by product_name),2) > 0 then 'Above Avg'
     when current_sales - round(avg(current_sales) over(partition by product_name),2) < 0 then 'Below avg'
     else 'avg'
     end avg_change,
lag(current_sales) over(partition by product_name order by order_month) as py_sales,
current_sales - lag(current_sales) over(partition by product_name order by order_month) as diff_py_sales,
case when lag(current_sales) over(partition by product_name order by order_month) > 0 then 'Incresing'
     when lag(current_sales) over(partition by product_name order by order_month) < 0 then 'Decresing'
     else 'no change'
     end py_change
from monthly_product_sales;
