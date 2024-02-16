--create table
CREATE TABLE IF NOT EXISTS sales(
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct NUMERIC(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date TIMESTAMP NOT NULL,  -- Change DATETIME to TIMESTAMP
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct NUMERIC(11,9),
    gross_income DECIMAL(12, 4),
    rating NUMERIC(2, 1)
);


ALTER TABLE sales
ALTER COLUMN rating TYPE NUMERIC(3,1); -- Changed precision to 3 to allow values up to 99.9

-- Testing DB columns uploaded correctly
SELECT *
FROM sales
--
SELECT 
	CASE
		WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
		WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
		ELSE 'Evening'
		END AS time_of_day
FROM sales;

 --
ALTER TABLE sales ADD COLUMN time_of_day VARCHAR(20);

UPDATE sales
SET time_of_day = (
		CASE
			WHEN time BETWEEN '00:00:00' AND '12:00:00' THEN 'Morning'
			WHEN time BETWEEN '12:01:00' AND '16:00:00' THEN 'Afternoon'
			ELSE 'Evening'
		END
	);

--

SELECT to_char(date, 'Day') as name_of_day
FROM sales;

ALTER TABLE sales ADD COLUMN name_of_day VARCHAR(20);

UPDATE sales
SET name_of_day = (
		SELECT to_char(date, 'Day')); 

--
SELECT to_char(date, 'Month') as month_name
FROM sales;

ALTER TABLE sales ADD COLUMN month_name VARCHAR(20);

UPDATE sales
SET month_name = (
	SELECT to_char(date, 'Month')
);

-- TESTING THE ABOVE ADDITIONS 
SELECT time_of_day, name_of_day, month_name
FROM sales;

                 ----------------------------------------
                 -----------Business Questions-----------
		 ----------------------------------------
				 
-- A. BRANCH & CITY INSIGHTS

---- 1. How many unique cities does the data have?

SELECT COUNT(DISTINCT city)
FROM sales;

---- 2. How many branches per city?

SELECT city, COUNT(*)
FROM sales
GROUP BY city
ORDER BY 2 DESC;

----3. What is the branch code for each city?

SELECT DISTINCT city,branch
FROM sales;

----4. On Average, which branch sold more products than the average products sold across all branches

SELECT branch
FROM sales
GROUP BY branch
HAVING AVG(quantity) > (SELECT AVG(quantity)FROM sales);


-- B. PRODUCT INSIGHTS

----1. How many unique product lines(categories) does the data have?

SELECT COUNT(DISTINCT product_line)
FROM sales;

----2.What is the average rating of each product line?

SELECT product_line,
	   ROUND(AVG(rating),2) AS average_rating
FROM sales
GROUP BY product_line
ORDER BY 2 DESC;


----3. What are the top-selling product lines and how do their sales compare over time?

WITH product_sales AS (
    SELECT 
        Product_line,
        SUM(Total) AS total_sales
    FROM 
        sales
    WHERE 
        EXTRACT(YEAR FROM date) = 2019 AND EXTRACT(MONTH FROM date) BETWEEN 1 AND 3 -- Filter for January to March 2019
    GROUP BY 
        Product_line
    ORDER BY 
        total_sales DESC  
)

SELECT 
    ps.product_line,
    CAST(ROUND(ps.total_sales, 2)AS money) AS total_sales,
    EXTRACT(MONTH FROM s.date) AS sales_month,
    CAST(ROUND(SUM(s.Total),2)AS money) AS monthly_sales
FROM 
    product_sales AS ps
JOIN 
    sales AS s 
ON ps.product_line = s.product_line
WHERE 
    EXTRACT(YEAR FROM s.date) = 2019 AND EXTRACT(MONTH FROM s.date) BETWEEN 1 AND 3 -- Filter for January to March 2019
GROUP BY 
    ps.Product_line,
    ps.total_sales, 
    sales_month
ORDER BY 
    total_sales DESC,
	ps.Product_line,
    sales_month;


----4. What product line had the largest revenue?

SELECT product_line,
	   CAST(ROUND(SUM(total),2) AS money) AS total_revenue
FROM sales
GROUP BY product_line
ORDER BY 2 DESC;
	
----5. What is the most common method of payment?

SELECT payment AS payment_type,
       COUNT(*) AS count_of_payment_type
FROM sales
GROUP BY payment_type
ORDER BY 2 DESC;


----6. Categorize product lines by "Above Average" or "Below Average" if it is above/below average sales

SELECT product_line,
	   CASE
	   	WHEN AVG(total) > (SELECT AVG(total) FROM sales) THEN 'Above Average'
		ELSE 'Below Average'
	   END AS category
FROM sales
GROUP BY product_line
ORDER BY category;

----7.What is the most common product line by gender?

SELECT gender,
       product_line,
	   COUNT(*) AS count_of_transactions
FROM sales
GROUP BY gender, product_line
ORDER BY product_line, 3 DESC;

-- C. SALES INSIGHTS

----1. What is the total revenue by month?

SELECT month_name,
       CAST(ROUND(SUM(total),2) AS money) AS total_revenue
FROM sales
GROUP BY month_name
ORDER BY 2 DESC;

----2. Which customer types brings in the most revenue?

SELECT customer_type,
       CAST(ROUND(SUM(total),2) AS money) AS revenue
FROM sales
GROUP BY customer_type
ORDER BY revenue DESC;

----3.What weekday and time of day is the most popular time to shop?
SELECT name_of_day AS weekday,
       time_of_day,
       COUNT(*) AS number_of_transactions -- transctions
FROM sales
GROUP BY weekday, time_of_day
ORDER BY number_of_transactions DESC,weekday
LIMIT 3;

SELECT name_of_day AS weekday,
       time_of_day,
	   SUM(quantity) AS number_of_units_sold -- units sold
FROM sales
GROUP BY weekday, time_of_day
ORDER BY number_of_units_sold DESC,weekday
LIMIT 3;

----4. Sales revenue by day of week / time of day
SELECT name_of_day,
	   CAST(ROUND(SUM(total),2) AS money) AS revenue
FROM sales
GROUP BY name_of_day
ORDER BY revenue DESC;

SELECT time_of_day,
	   CAST(ROUND(SUM(total),2) AS money) AS revenue
FROM sales
GROUP BY time_of_day
ORDER BY revenue DESC;

----5. What rate are sales increasing or decreasing MoM?
SELECT 
    EXTRACT(MONTH FROM date) AS month,
    CAST(ROUND(SUM(total), 2) AS money) AS total_revenue,
    CONCAT(
	   ROUND(
		 COALESCE(
       			  (SUM(total) - LAG(SUM(total)) OVER (ORDER BY EXTRACT(MONTH FROM date))) /
        			NULLIF(LAG(SUM(total)) OVER (ORDER BY EXTRACT(MONTH FROM date)), 0) * 100, --Using NULLIF to avoid errors in division.
       				 0),2),'%')
     					AS percent_change
FROM sales
GROUP BY month;

----6.What is the city with the largest revenue?

SELECT city,
       CAST(ROUND(SUM(total),2) AS money) AS total_revenue
FROM sales
GROUP BY city
ORDER BY 2 DESC;


-- D. CUSTOMER ANALYSIS

----1.What is the gender distribution per branch?
SELECT branch,
	   gender,
	   COUNT(*) AS distribution
FROM sales
GROUP BY branch, gender
ORDER BY branch, gender;

----2. What is the average spend per A)customer, B)customer type, and C)gender. 2A)Who is your best customer?

--A)
SELECT ROUND(AVG(total),2) AS average_per_customer
FROM sales;
--B)
SELECT customer_type,
	   ROUND(AVG(total),2) AS average_spend
FROM sales
GROUP BY customer_type;
--C)
SELECT gender,
	   ROUND(AVG(total),2) AS average_spend
FROM sales
GROUP BY gender;

--2A.Who is the best customer?
SELECT gender,
       customer_type,
	   ROUND(AVG(total),2) AS average_spend
FROM sales
GROUP BY gender, customer_type
ORDER BY average_spend DESC;

----3. What time of day do customers give the most ratings per branch?

SELECT branch,
	   time_of_day,
	   COUNT(rating) AS ratings
FROM sales
GROUP BY branch,time_of_day
ORDER BY ratings DESC;

----4. What day of the week has the best average ratings per branch?

SELECT branch,
	   name_of_day AS day,
	   time_of_day,
	   ROUND(AVG(rating),2) AS avg_rating
FROM sales
GROUP BY branch, day, time_of_day
ORDER BY avg_rating DESC;  
