# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Database Used**: `MySQL`

In this project, I demonstrates SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
3. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE p1_retail_db;

CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);
```

### 2. EDA

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
select count(*) from sales_data;
select count(distinct(customer_id)) from sales_data;
select distinct(category) from sales_data;
```

### 3. Data Analysis & Findings

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
select * from sales_data
where sale_date = "2022-11-05" ;
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

```sql
select * from sales_data
where category = 'Clothing' and sale_date >= '2022-11-01' and sale_date < '2022-11-30'
and quantiy >=4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:

```sql
select sum(total_sale), category from sales_data
group by category;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
select avg(age) from sales_data
where category='Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
select * from sales_data
where total_sale > 1000;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
select count(transactions_id), gender, category from sales_data
group by gender, category;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
select avg(total_sale), month(sale_date) from sales_data
group by month(sale_date)
order by avg(total_sale) desc;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales**:

```sql
select customer_id, sum(total_sale) from sales_data
group by customer_id order by sum(total_sale) desc limit 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:

```sql
select count(distinct(customer_id)), category from sales_data
group by category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
with hourly_sale
as(
select *,
	  case
         when extract(hour from sale_time) < 12 then "Morning"
         when extract(hour from sale_time) between 12 and 17 then "Afternoon"
         else "Evening"
	end as shift
from sales_data
)
select shift, count(transactions_id)
from hourly_sale
group by shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.
