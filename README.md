**Retail Sales Analysis SQL Project**

**Project Overview**

Project Title: Retail Sales Analysis
In this project I have used SQL skills and techniques to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries.

**Objectives**

1.**Set up a retail sales database**: Created retail sales database and imported sales data.

2.**Data Cleaning**: Identified if any records are ther with missing or null values and delted the null values.

3.**Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.

4.**Business Analysis**: Used SQL to answer specific business questions and derive insights from the sales data.

**Project Structure**

**1.Database Setup**

**Database Creation**: The project starts by creating a database named projects.

**Table Creation**: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount

***sql
CREATE DATABASE Projects;
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
***

**2.Data Exploration & Cleaning**

**Record Count**: Determined the total number of records in the dataset.

**Customer Count**: Found out how many unique customers are in the dataset.

**Category Count**: Identified all unique product categories in the dataset.

**Null Value Check**: Checked for any null values in the dataset and delete records with missing data.

 ***sql
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

 select count(transactions_id) from retail_sales;
 select count(distinct(customer_id)) from retail_sales;
 select distinct(category) from retail_sales;
 
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
 ***

**3. Data Analysis & Findings**
The following SQL queries were developed to answer specific business questions:
1.**Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
***sql
select * from retail_sales where sale_date = '2022-11-05';
***

2.***Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
***sql
 select transactions_id,quantiy from retail_sales where category = 'Clothing' and quantiy >=4 and MONTH (sale_date)=11
 ***
 
3.**Write a SQL query to calculate the total sales (total_sale) for each category**:
***sql
select SUM(total_sale) AS sale_per_category,category from retail_sales
group by category;
***

4.**Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category**:

***sql
select avg(Age) AS avgage from retail_sales
WHERE category='Beauty';
***

5.**Write a SQL query to find all transactions where the total_sale is greater than 1000**:

***sql
select transactions_id from retail_sales
WHERE total_sale>1000;
***

6.**Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category**:

***sql
select COUNT(transactions_id) as nooftransactions,gender ,category from retail_sales
group by gender ,category;
***

7.**a SQL query to calculate the average sale for each month. Find out best selling month in each year**:

***sql
select * from (select month (sale_date) as salemonth,year (sale_date)  as saleyear,avg(total_sale),
RANK() OVER(PARTITION BY (YEAR (sale_date)) ORDER BY AVG(total_sale) DESC) as r_a_n_k
from retail_sales 
group by 1,2) as t1
where r_a_n_k=1
***

8.**Write a SQL query to find the top 5 customers based on the highest total sales**:

***sql 
select customer_id, sum(total_sale) as net_sale
from retail_sales
group by customer_id
order by net_sale
limit 5;
***
9.**Write a SQL query to find the number of unique customers who purchased items from each category**

***sql
select category,count(distinct(customer_id))
from retail_sales
group by category;
***

10.**Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

***sql
with hourly_sale as 
(select *,
case when hour(sale_time)<12 then 'Morning'
       when hour(sale_time) between 12 AND 17 then 'Afernoon'
	ELSE 'Evening'
    end as shift
from retail_sales)
select shift,count(*) as totalorders from hourly_sale
group by shift;
***
