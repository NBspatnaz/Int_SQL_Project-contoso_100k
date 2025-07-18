WITH LTV_customer AS 
(
SELECT 
	 c.customer_key,
	c.full_name,
ROUND(CAST(SUM(c.total_revenue) AS NUMERIC), 2) AS total_LTV
FROM cohort_analysis c 
GROUP BY
c.customer_key,
	c.full_name),
	
	
percentile_data AS(SELECT
	PERCENTILE_CONT(0.25) WITHIN GROUP(ORDER BY total_LTV) AS ltv_25th,
	PERCENTILE_CONT(0.75) WITHIN GROUP(ORDER BY total_LTV) AS ltv_75th
FROM LTV_customer 
),

	categories_tier AS (SELECT
		l.*,
		CASE 
				WHEN l.total_LTV <= ltv_25th  THEN '1-Low-Value'
				WHEN l.total_LTV <= ltv_75th  THEN '2-Mid-Value'
				WHEN l.total_LTV >  ltv_75th THEN '3-high-Value'
				ELSE 'Null'
		END AS categories
		
	FROM LTV_customer AS L,
	 percentile_data AS P)
	
	SELECT
		categories,
		COUNT(*) AS categories_count,
		SUM(total_ltv) AS total_net_ltv,
		SUM(total_ltv)/COUNT(*) AS AVG_ltv
	FROM categories_tier AS ca
	GROUP BY
		categories
	
	
	
	
	