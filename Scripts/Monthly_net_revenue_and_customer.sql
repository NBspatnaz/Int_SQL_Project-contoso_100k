--Monthly_net_revenue_and_customer

SELECT
		DATE_TRUNC('month', c.orderdate ):: date AS year_month ,
		SUM(c.total_revenue) AS total_net_revenue,
		COUNT(DISTINCT customer_key) AS total_customer,
		SUM(c.total_revenue)/COUNT(DISTINCT customer_key) AS customer_revenue
FROM cohort_analysis c 
WHERE c.orderdate = c.first_order 
GROUP BY
	year_month