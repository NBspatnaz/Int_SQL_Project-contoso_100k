CREATE VIEW cohort_analysis AS

WITH cohort AS (
         SELECT s.customerkey AS customer_key,
            s.orderkey,
            s.orderdate,
            min(s.orderdate) OVER (PARTITION BY s.customerkey) AS first_order,
            EXTRACT(year FROM min(s.orderdate) OVER (PARTITION BY s.customerkey)) AS cohort_year,
            (s.quantity::double precision * s.netprice * s.exchangerate) AS revenue,
            CONCAT(TRIM(c.givenname), ' ', TRIM(c.surname)) AS full_name,
            c.gender,
            c.age
           FROM sales s
             JOIN customer c ON s.customerkey = c.customerkey
        )
 SELECT customer_key,
    full_name,
    MAX(gender) AS gender,
    MAX(age) AS age,
    cohort_year,
    first_order,
    orderdate,
    count(orderkey) AS num_orders,
    sum(revenue) AS total_revenue
   FROM cohort
  GROUP BY customer_key, orderdate, full_name, cohort_year, first_order
  ORDER BY customer_key;