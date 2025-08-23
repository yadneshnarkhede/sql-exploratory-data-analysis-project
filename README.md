# sql-exploratory-data-analysis-project

## 1. 📌 Project Overview

This project focuses on performing **Exploratory Data Analysis (EDA) using SQL** on a dataset related to **bikes and their components**. The dataset consists of **three CSV files**:

1. `customers.csv` → Customer details
2. `products.csv` → Bike products and components
3. `sales.csv` → Sales transactions

The objective is to uncover insights about **customer behavior, sales trends, and product performance** using SQL queries.

---

## 2. 🗂 Dataset Description

* **Customers**: Contains customer details such as customer ID, name, location, and demographics.
* **Products**: Contains information about bikes and components (dimensions, categories, prices).
* **Sales**: Records transaction details including order ID, customer ID, product ID, sales amount, and date.

---

## 3. 🎯 Key Explorations and Insights

The following types of EDA were performed:

1. **Customer Behavior Analysis** – Segmentation of customers based on purchase patterns.
2. **Sales Trends** – Identifying seasonal or monthly fluctuations in sales.
3. **Product Performance** – Evaluating top-performing bikes and components.
4. **Dimensions Exploration** – Exploring categorical attributes like product categories, regions, and customer types.
5. **Data Range Exploration** – Checking min/max/avg values for sales and product prices.
6. **Measure Exploration** – Understanding distributions (e.g., avg sales per customer).
7. **Magnitude Analysis** – Comparing total sales across products and regions.
8. **Change Over Time** – Analyzing trends (monthly/yearly growth in sales).
9. **Performance Analysis** – Ranking best-selling products and high-value customers.
10. **Data Segmentation** – Breaking down sales and customer data by demographics and geography.

---

## 4. 🛠️ SQL Techniques Used

1. **CASE WHEN** – For conditional data categorization (e.g., segmenting customers into groups).
2. **Common Table Expressions (CTEs)** – For simplifying complex queries and creating temporary result sets.
3. **JOINS (INNER, LEFT, RIGHT)** – For combining `customers`, `products`, and `sales` datasets to derive meaningful insights.
4. **Window Functions** – For advanced analytics such as running totals, moving averages, ranking products/customers, and analyzing sales trends over time.
---

## 5. 📈 Example Insights Found

* Monthly sales trends showed significant peaks during festive seasons.
* Certain product categories (e.g., mountain bikes) had higher performance compared to others.
* High-value customers were concentrated in specific regions.
* Average sales amount per transaction indicated upselling opportunities.

---

## 6. 🗃️ Project Structure

```
📂 SQL_EDA_Bike_Project
 ┣ 📜 README.md   # Project documentation
 ┣ 📂 data
 ┃ ┣ customers.csv
 ┃ ┣ products.csv
 ┃ ┗ sales.csv
 ┣ 📂 sql_scripts
 ┃ ┣ exploratory_queries.sql
 ┃ ┗ insights_analysis.sql
 ┗ 📊 report
   ┣ customer_behavior_report.sql
   ┣ sales_trends_report.sql
   ┗ product_performance_report.sql
```

---

## 7. 🚀 How to Run

1. Import the CSV files (`customers.csv`, `products.csv`, `sales.csv`) into your SQL database.
2. Run the scripts in the `sql_scripts` folder step by step:

   * `data_cleaning.sql` → Prepares the raw data.
   * `exploratory_queries.sql` → Performs EDA queries.
   * `insights_analysis.sql` → Extracts key insights.
3. Review generated reports in the `results` folder.

---

## 8. 📌 Conclusion

This SQL EDA project provided clear insights into **customer behavior, product performance, and sales trends**. Using **CASE WHEN, CTEs, and JOINS**, complex queries were simplified and structured for analysis. These insights can support better decision-making for marketing strategies, product focus, and customer engagement.

---
