/*
===============================================================================
Date Range Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/
-- find the date of first and last orders
-- how many years of sales are available
select
min(order_date) as first_order_date,
max(order_date) as last_order_date,
timestampdiff(year,min(order_date),max(order_date)) as order_range_year
from sales;

-- find the youngest and oldest customers
select 
min(birthdate) as oldest_birthdate,
timestampdiff(year,min(birthdate),curdate()) as oldest_age,
max(birthdate) as youngest_birthdate,
timestampdiff(year,max(birthdate),curdate()) as youngest_age
from customers
