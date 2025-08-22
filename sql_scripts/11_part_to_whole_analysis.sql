## Part-of-whole Analysis(Proportional)
/*
===============================================================================
Part-to-Whole Analysis
===============================================================================
Purpose:
    - To compare performance or metrics across dimensions or time periods.
    - To evaluate differences between categories.
    - Useful for A/B testing or regional comparisons.

SQL Functions Used:
    - SUM(), AVG(): Aggregates values for comparison.
    - Window Functions: SUM() OVER() for total calculations.
===============================================================================
*/
-- Which categories contribute the most to overall sales?
with category_sales as (
select
p.category,
sum(s.sales_amount) as total_sales
from sales as s
left join products as p
on p.product_key=s.product_key
group by p.category
)
select 
category,
total_sales,
sum(total_sales) over() overall_sales,
concat(round((total_sales / sum(total_sales) over() ) * 100,2),'%') as percentage_of_total
from category_sales
order by total_sales desc;
