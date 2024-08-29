create database retail_sales;

create table sales_data(
             transactions_id INT PRIMARY KEY,
             sale_date DATE,
             sale_time TIME,
             customer_id INT,
             gender VARCHAR(15),
             age INT,
             category VARCHAR(15),
             quantiy INT,
             price_per_unit FLOAT,
             cogs FLOAT,
             total_sale FLOAT
);

select count(*) from sales_data;

select count(*) from sales_data;
select count(distinct(customer_id)) from sales_data;
select distinct(category) from sales_data;

-- Write a SQL query to retrieve all columns for sales made on '2022-11-05
select * from sales_data
where sale_date = "2022-11-05" ;

-- Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
select * from sales_data
where category = 'Clothing' and sale_date >= '2022-11-01' and sale_date < '2022-11-30'
and quantiy >=4;

-- Write a SQL query to calculate the total sales (total_sale) for each category
select sum(total_sale), category from sales_data
group by category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
select avg(age) from sales_data
where category='Beauty';

-- Write a SQL query to find all transactions where the total_sale is greater than 1000
select * from sales_data
where total_sale > 1000;

-- Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
select count(transactions_id), gender, category from sales_data
group by gender, category;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
select avg(total_sale), month(sale_date) from sales_data
group by month(sale_date)
order by avg(total_sale) desc;

-- Write a SQL query to find the top 5 customers based on the highest total sales
select customer_id, sum(total_sale) from sales_data
group by customer_id order by sum(total_sale) desc limit 5;

-- Write a SQL query to find the number of unique customers who purchased items from each category
select count(distinct(customer_id)), category from sales_data
group by category;


-- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
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
