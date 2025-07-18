--customer revenue by cohort

SELECT
		c.cohort_year ,
		SUM(c.total_revenue) AS total_net_revenue,
		COUNT(DISTINCT customer_key) AS total_customer,
		SUM(c.total_revenue)/COUNT(DISTINCT customer_key) AS customer_revenue
FROM cohort_analysis c 
WHERE c.orderdate = c.first_order 
GROUP BY
	cohort_year