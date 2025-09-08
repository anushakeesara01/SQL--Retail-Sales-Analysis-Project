--SQL Retail Sales Analysis Project---
-- Creating table---
CREATE TABLE Retail_sales
(transactions_id	INT PRIMARY KEY,
 sale_date	DATE,
 sale_time	TIME,
 customer_id INT,	
 gender	VARCHAR(15),
 age	INT,
 category	VARCHAR(15),
 quantiy INT,	
 price_per_unit	FLOAT,
 cogs	FLOAT,
 total_sale FLOAT );
 SELECT * FROM projects.retail_sales;
 --- Data Cleaning----
 SELECT * FROM projects.retail_sales
 WHERE transactions_id IS NULL
 OR
 sale_date IS NULL
 OR sale_time IS NULL
 OR customer_id IS NULL
 OR gender IS NULL
 OR age IS NULL 
 OR category IS NULL
 OR quantiy IS NULL
 OR price_per_unit IS NULL
 OR cogs IS NULL
 OR total_sale IS NULL;
 --deleting null values---
 SET SQL_SAFE_UPDATES = 0;
 DELETE FROM retail_sales
 WHERE transactions_id IS NULL
 OR
 sale_date IS NULL
 OR sale_time IS NULL
 OR customer_id IS NULL
 OR gender IS NULL
 OR age IS NULL 
 OR category IS NULL
 OR quantiy IS NULL
 OR price_per_unit IS NULL
 OR cogs IS NULL
 OR total_sale IS NULL;
 --- Data exploration----
 --how many sales we have--
 select count(transactions_id) from retail_sales;
  --how many customers we have--
 select count(distinct(customer_id)) from retail_sales;
   --how many categories  we have--
 select distinct(category) from retail_sales;
 ---Data analysis & business key problems & answers--
 1.Write a SQL query to retrieve all columns for sales made on '2022-11-05':
 select * from retail_sales
 where sale_date = '2022-11-05';
 2.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
  select transactions_id,quantiy from retail_sales
 where category = 'Clothing' and quantiy >=4 and MONTH (sale_date)=11;
 
3.Write a SQL query to calculate the total sales (total_sale) for each category.:
select SUM(total_sale) AS sale_per_category,category from retail_sales
group by category;
4.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select avg(Age) AS avgage from retail_sales
WHERE category='Beauty';
5.Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select transactions_id from retail_sales
WHERE total_sale>1000;
6.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
select COUNT(transactions_id) as nooftransactions,gender ,category from retail_sales
group by gender ,category;
7.Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select * from (select month (sale_date) as salemonth,year (sale_date)  as saleyear,avg(total_sale),
RANK() OVER(PARTITION BY (YEAR (sale_date)) ORDER BY AVG(total_sale) DESC) as r_a_n_k
from retail_sales 
group by 1,2) as t1
where r_a_n_k=1
order by 1,2,3 desc----
8.Write a SQL query to find the top 5 customers based on the highest total sales ---
select customer_id, sum(total_sale) as net_sale
from retail_sales
group by customer_id
order by net_sale
limit 5;
9.Write a SQL query to find the number of unique customers who purchased items from each category.---
select category,count(distinct(customer_id))
from retail_sales
group by category;
10.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)---
with hourly_sale as 
(select *,
case when hour(sale_time)<12 then 'Morning'
       when hour(sale_time) between 12 AND 17 then 'Afernoon'
	ELSE 'Evening'
    end as shift
from retail_sales)
select shift,count(*) as totalorders from hourly_sale
group by shift;
----end of project---