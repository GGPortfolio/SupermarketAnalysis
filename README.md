<h1>&nbsp;Supermarket Sales Analysis SQL Project</h1>
<h2>About Dataset:</h2>
<p>The expansion of supermarkets in densely populated urban centers is on the rise, accompanied by heightened market competition. The dataset comprises historical sales data from a supermarket company, encompassing three months of records across three distinct branches.</p>
<p>This dataset contains sales transactions from a three different branches, respectively located in Mandalay, Yangon and Naypyitaw. The data contains 17 columns and 1000 rows.</p>
<table>
<thead>
<tr>
<th>Column</th>
<th>Description</th>
<th>Data Type</th>
</tr>
</thead>
<tbody>
<tr>
<td>invoice_id</td>
<td>Invoice of the sales made</td>
<td>VARCHAR(30)</td>
</tr>
<tr>
<td>branch</td>
<td>Branch at which sales were made</td>
<td>VARCHAR(5)</td>
</tr>
<tr>
<td>city</td>
<td>The location of the branch</td>
<td>VARCHAR(30)</td>
</tr>
<tr>
<td>customer_type</td>
<td>The type of the customer</td>
<td>VARCHAR(30)</td>
</tr>
<tr>
<td>gender</td>
<td>Gender of the customer making purchase</td>
<td>VARCHAR(10)</td>
</tr>
<tr>
<td>product_line</td>
<td>Product line of the product solf</td>
<td>VARCHAR(100)</td>
</tr>
<tr>
<td>unit_price</td>
<td>The price of each product</td>
<td>DECIMAL(10, 2)</td>
</tr>
<tr>
<td>quantity</td>
<td>The amount of the product sold</td>
<td>INT</td>
</tr>
<tr>
<td>VAT</td>
<td>The amount of tax on the purchase</td>
<td>FLOAT(6, 4)</td>
</tr>
<tr>
<td>total</td>
<td>The total cost of the purchase</td>
<td>DECIMAL(10, 2)</td>
</tr>
<tr>
<td>date</td>
<td>The date on which the purchase was made</td>
<td>DATE</td>
</tr>
<tr>
<td>time</td>
<td>The time at which the purchase was made</td>
<td>TIMESTAMP</td>
</tr>
<tr>
<td>payment_method</td>
<td>The total amount paid</td>
<td>DECIMAL(10, 2)</td>
</tr>
<tr>
<td>cogs</td>
<td>Cost Of Goods sold</td>
<td>DECIMAL(10, 2)</td>
</tr>
<tr>
<td>gross_margin_percentage</td>
<td>Gross margin percentage</td>
<td>FLOAT(11, 9)</td>
</tr>
<tr>
<td>gross_income</td>
<td>Gross Income</td>
<td>DECIMAL(10, 2)</td>
</tr>
<tr>
<td>rating</td>
<td>Rating</td>
<td>FLOAT(2, 1)</td>
</tr>
</tbody>
</table>
<p><em>Source: <a href="https://www.kaggle.com/datasets/aungpyaeap/supermarket-sales/data">Supermarket Sales Data</a></em></p>
<h2 data-selectable-paragraph="">Purpose:</h2>
<p>The major aim of this project is to gain insight into the sales data to understand the different factors that affect sales of the different branches. Examining top-performing branches and items, sales trends for various products, and understanding consumer behaviour will allow us to gain deeper insights.&nbsp;</p>
<p>I will be using&nbsp;PostgreSQL for this Project.</p>
<h2 data-selectable-paragraph="">Approach Used:</h2>
<h3>1. Data Wrangling</h3>
<ul>
<li>Building the database and inserting the data.</li>
<li>Ensuring Null and missing values are detected and replaced.</li>
</ul>
<h3>2. Feature Engineering</h3>
<ul>
<li>Adding three new columns to the database using existsing columns in order to aid analysis:
<ul>
<li>time_of_day</li>
<li>name_of_day</li>
<li>month_name</li>
</ul>
</li>
</ul>
<h3>3. Exploratory Data Analysis(EDA)</h3>
<ul>
<li>Analyzing and understanding the data.</li>
<li>Creating business questions to answer.</li>
</ul>
<h2 data-selectable-paragraph="">Business Questions Answered:</h2>
<h3>1.&nbsp;Branch &amp; City Insights&nbsp;</h3>
<ul>
<li>How many unique cities does the data have?</li>
<li>How many branches per city?</li>
<li>What is the branch code for each city?</li>
<li>On Average, which branch sold more products than the average products sold across all branches?</li>
</ul>
<h3>2.&nbsp;Product Insights</h3>
<ul>
<li>How many unique product lines(categories) does the data have?</li>
<li>What is the average rating of each product line?</li>
<li>What are the top-selling product lines and how do their sales compare over time?</li>
<li>What product line had the largest revenue?</li>
<li>What is the most common method of payment?</li>
<li>Categorizing product lines by "Above Average" or "Below Average" if it is above/below average sales.</li>
<li>What is the most common product line by gender?</li>
</ul>
<h3>3. Sales Insights</h3>
<ul>
<li>What is the total revenue by month?</li>
<li>Which customer types brings in the most revenue?</li>
<li>What weekday and time of day is the most popular time to shop?</li>
<li>What is the sales revenue by day of week / time of day?</li>
<li>What rate are sales increasing or decreasing MoM?</li>
<li>What is the city with the largest revenue?</li>
</ul>
<h3>4.&nbsp;Customer Analysis</h3>
<ul>
<li>What is the gender distribution per branch?</li>
<li>What is the average spend per
<ul>
<li>A)customer</li>
<li>B)customer type</li>
<li>C)gender</li>
</ul>
</li>
<li>Who is the best customer?</li>
<li>What time of day do customers give the most ratings per branch?</li>
<li>What day of the week has the best average ratings per branch?</li>
</ul>
<h2>SQL Code:</h2>
<p>The SQL code for this project can be found on <a href="https://github.com/GGPortfolio/DataAnalysis/blob/main/Supermarket%20Sales%20Analysis.sql">Supermarket Sales Analysis</a></p>
