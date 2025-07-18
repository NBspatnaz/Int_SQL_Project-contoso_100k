EXPLAIN ANALYZE
WITH order_data AS
(	SELECT 
	c.customer_key ,
	c.full_name ,
	c.first_order ,
	c.cohort_year,
	MAX(orderdate) AS last_order
FROM cohort_analysis c 
GROUP BY
	c.customer_key ,
	c.full_name,
	first_order,
	cohort_year
	),
	
	
churned_customer AS 	
	(SELECT 
	*,
		CASE 
		    WHEN last_order <  (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months' THEN 'Churned'
		    ELSE 'Active'
		END AS customer_status
	FROM order_data

	WHERE first_order <  (SELECT MAX(orderdate) FROM sales) - INTERVAL '6 months')

SELECT --This is for finding out the customer status in the pie chart
	customer_status,
	COUNT(ur.customer_key ) AS num_customer,
	SUM(COUNT(ur.customer_key) ) OVER() AS total_customer,
	ROUND(COUNT(ur.customer_key )/SUM(COUNT(ur.customer_key) ) OVER(),2) AS retention_percentage
FROM churned_customer ur
GROUP BY
	customer_status
	
	
	
/*-- this is for finding the cohort_analysis of the retained customer over the years
 SELECT
	cohort_year,
	customer_status,
	COUNT(ur.customer_key ) AS num_customer,
	SUM(COUNT(ur.customer_key) ) OVER(PARTITION BY cohort_year) AS total_customer,
	ROUND(COUNT(ur.customer_key )/SUM(COUNT(ur.customer_key) ) OVER(PARTITION BY cohort_year),2) AS retention_percentage
FROM churned_customer ur
GROUP BY
	cohort_year,
	customer_status
	*/