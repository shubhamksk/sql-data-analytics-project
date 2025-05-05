--Cummulative Analysis
--Calculate the Total Sales per Month and Running Total of Sales over Time.
--Without Partitioning
SELECT
Order_Month,
Total_Sales,
SUM(Total_Sales) OVER (ORDER BY Order_Month) AS Running_Total_Sales
--window function
FROM
	(
	SELECT
	DATETRUNC(month, order_date) AS Order_Month,
	SUM(sales_amount) AS Total_Sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(month, order_date)
	)t

--With Partitoning
SELECT
Order_Month,
Total_Sales,
SUM(Total_Sales) OVER (PARTITION BY Order_Month ORDER BY Order_Month) AS Running_Total_Sales
--window function
FROM
	(
	SELECT
	DATETRUNC(month, order_date) AS Order_Month,
	SUM(sales_amount) AS Total_Sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(month, order_date)
	)t

--Changing the Granularity to Year
SELECT
Order_Month,
Total_Sales,
SUM(Total_Sales) OVER (ORDER BY Order_Month) AS Running_Total_Sales
--window function
FROM
	(
	SELECT
	DATETRUNC(YEAR, order_date) AS Order_Month,
	SUM(sales_amount) AS Total_Sales
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR, order_date)
	)t

--Moving Average
SELECT
Order_Year,
Total_Sales,
SUM(Total_Sales) OVER (ORDER BY Order_Year) AS Running_Total_Sales,
AVG(Average_Price) OVER (ORDER BY Order_Year) AS Moving_Avergae_Sales
--window function
FROM
	(
	SELECT
	DATETRUNC(YEAR, order_date) AS Order_Year,
	SUM(sales_amount) AS Total_Sales,
	AVG(price) AS Average_Price
	FROM gold.fact_sales
	WHERE order_date IS NOT NULL
	GROUP BY DATETRUNC(YEAR, order_date)
	)t