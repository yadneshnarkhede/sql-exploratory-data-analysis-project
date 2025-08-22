use data_analysis;
/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/
-- Retrieve a list of unique countries from which customers originate

select distinct country from customers;

-- Explore all category from product
select distinct category from products;

-- Retrieve a list of unique categories, subcategories, and products
select distinct category,subcategory,product_name from products
order by 1,2,3