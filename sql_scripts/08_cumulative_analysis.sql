## Cumulative Analysis
# Calculate the total sales per month
# and the running total of sales over time


select
order_date,
total_sales,
sum(total_sales) over(partition by order_date order by order_date) as running_total_sales
from
(
select 
x as order_date,
sum(sales_amount) as total_sales
from sales
where order_date IS NOT NULL
group by date_format(order_date, '%Y-%m')
) t;

# Calculate the total sales per year
# and the running total of sales over time
select
order_date,
total_sales,
sum(total_sales) over(order by order_date) as running_total_sales,
round(avg(avg_price) over(order by order_date),2) as moving_avg_price
from
(
select 
date_format(order_date,'%Y-01')as order_date,
sum(sales_amount) as total_sales,
round(avg(price),2) as avg_price
from sales
where order_date is not null
group by date_format(order_date,'%Y-01')
order by order_date
)t;



