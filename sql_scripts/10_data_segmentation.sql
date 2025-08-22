## Data Segmentation
/*
mesure by mesure
total product by sales range
total customer by age 

segment product into cost range and
count how many product fall into each segment */
/*
===============================================================================
Data Segmentation Analysis
===============================================================================
Purpose:
    - To group data into meaningful categories for targeted insights.
    - For customer segmentation, product categorization, or regional analysis.

SQL Functions Used:
    - CASE: Defines custom segmentation logic.
    - GROUP BY: Groups data into segments.
===============================================================================
*/

/*Segment products into cost ranges and 
count how many products fall into each segment*/
with product_segmentation as(
select
product_key,
product_name,
cost,
case when cost < 100 then 'below 100'
     when cost between 100 and 500 then '100-500'
     when cost between 500 and 1000 then '500-1000'
     else 'above 1000'
end cost_range
from products
)
select 
cost_range,
count(product_key) as total_product
from product_segmentation
group by cost_range
order by total_product desc;


/*
Group customer into 3 segments based on their spending behaviour:
 -VIP: Customer atleast 12 month of history and spending more time $5000.
 -Regular: Customer atleast 12 month of history but spending $5000 or less.
 -New: Customer with lifespan less then 12 months.
and find the total number of customers by each group.
*/

with customer_spending as (
select
c.customer_key,
sum(s.sales_amount) as total_spending,
min(order_date) as first_order,
max(order_date) as last_order,
TIMESTAMPDIFF(month,min(order_date),max(order_date)) as lifespan
from sales as s
left join customers as c
on s.customer_key = c.customer_key 
group by customer_key
)
select 
customer_segment,
count(customer_key) as total_customers
from(
	select 
	customer_key,
	total_spending,
	lifespan,
	case when lifespan >= 12 and total_spending > 5000 then 'VIP'
		 when lifespan >= 12 and total_spending <= 5000 then 'Regular'
		 else 'NEW'
	end customer_segment
	from customer_spending) t
group by customer_segment
order by total_customers desc

