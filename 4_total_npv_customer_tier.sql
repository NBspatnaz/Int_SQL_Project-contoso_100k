/*Compute Net Present Value (NPV) of Customer Lifetime Value (LTV),
 adjusted for the time value of money, for each customer and cohort, 
 and flag the top 10% premium customers based on their NPV. And
 do a segmentation of the premium and regular customer*/


WITH LTV_base AS 
(
	SELECT
		ca.customer_key ,
		ca.cohort_year,
		DATE_PART('month', AGE(orderdate, first_order)) + 
		12*DATE_PART('year', AGE(orderdate, first_order))  AS months_since_first_order,
		ca.total_revenue AS LTV
	FROM cohort_analysis ca 

),

NPV_base AS (SELECT
	lt.customer_key,
	MAX(lt.cohort_year) cohort_year,
	SUM (lt.ltv/POWER((1+.01), months_since_first_order) )AS NPV
FROM LTV_base AS lt

GROUP BY 
	lt.customer_key),
	
percentile_base AS (SELECT
	PERCENTILE_CONT(.90) WITHIN GROUP (ORDER BY npv) AS NPV_ltv
FROM NPV_base),

customer_npv AS
(SELECT
	np.customer_key,
	np.cohort_year,
	np.npv,
	CASE
		WHEN np.npv>= p.NPV_ltv THEN 'Premium'
		ELSE 'Regular'
	END AS customer_tier
FROM NPV_base AS np,
percentile_base AS p 

ORDER BY 
	Customer_key
)

SELECT
	customer_tier,
	COUNT(customer_key) AS num_customer,
	ROUND(CAST(SUM(npv)AS NUMERIC),2) AS total_npv,
	ROUND(CAST(AVG(npv)AS NUMERIC),2)AS avg_npv

FROM customer_npv

GROUP BY
	customer_tier
ORDER BY 
	customer_tier 
	