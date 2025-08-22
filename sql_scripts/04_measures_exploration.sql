/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
===============================================================================
*/

-- Find the total sales
select sum(sales_amount) as total_sales from sales;

-- How many item are sold
select sum(quantity) as total_quantity from sales;

-- find the average selling price
select avg(sales_amount) as avg_selling_price from sales;

-- Find the total number of orders
select count(distinct order_number) as total_orders from sales;

-- FInd the total number of product
select count(distinct product_name) as total_product from products;

-- Find the total number customers
select count(customer_key)as total_customer from customers;

-- find the total number of customers that has placesd an ordes 
select count(distinct customer_key) as total_customer from sales;


-- Generate a Report that shows all key metrics of the business
select 'Total sales' as measure_name, sum(sales_amount) as measure_value from sales
union all
select 'Total Quantity', sum(quantity)  from sales
union all
select 'Average price',  avg(price) from sales
union all 
select 'Total no. Orders', count(distinct order_number) from sales
union all
select 'Total no. Product', count(distinct product_name) from products
union all
select 'Total no. Customers' , count(distinct customer_key) from customers	

