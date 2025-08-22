/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/

-- Which 5 products Generating the Highest Revenue?
-- Simple Ranking
select 
p.product_name,
sum(s.sales_amount) as total_revenue
from sales as s
left join products as p
on s.product_key = p.product_key
group by product_name
order by total_revenue desc
limit 5;

-- Complex but Flexibly Ranking Using Window Functions
select 
p.product_name,
sum(s.sales_amount) as total_revenue,
row_number() over(order by sum(s.sales_amount) desc) as rank_product
from sales as s
left join products as p
on s.product_key = p.product_key
group by product_name
order by total_revenue desc;


-- Which 5 sub-category Generating the Highest Revenue?
-- Simple Ranking
select 
p.subcategory,
sum(s.sales_amount) as total_revenue
from sales as s
left join products as p
on s.product_key = p.product_key
group by subcategory
order by total_revenue desc
limit 5;


-- What are the 5 worst-performing products in terms of sales?

select 
p.product_name,
sum(s.sales_amount) as total_revenue
from sales as s
left join products as p
on s.product_key = p.product_key
group by product_name
order by total_revenue 
limit 5;

-- Find the top 10 customers who have generated the highest revenue
select 
c.customer_key,
concat(c.first_name,' ',c.last_name) as customer_name,
sum(sales_amount) as total_revenue
from sales as s
left join customers as c
on s.customer_key=c.customer_key
group by customer_key,
customer_name
order by total_revenue desc;

-- the 3 customer with the fewest order places
select 
c.customer_key,
concat(c.first_name,' ',c.last_name) as customer_name,
count(distinct order_number) as total_order
from sales as s
left join customers as c
on s.customer_key=c.customer_key
group by customer_key,
customer_name
order by total_order ,
customer_key
limit 3;





