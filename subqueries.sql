/* Provide the name of the sales_rep in each region with the largest amount of
of total_amt_usd sales */
SELECT t3.sales_rep, t2.region_name, t2.max_sales, COUNT(*)
FROM
  (SELECT region_name, MAX(total_amt)  max_sales
  FROM
    (SELECT s.name sales_rep, r.name region_name , SUM(o.total_amt_usd) total_amt
    FROM region r
    JOIN sales_reps s
    ON s.region_id = r.id
    JOIN accounts a
    ON a.sales_rep_id = s.id
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1 , 2
    ORDER BY 3) t1
  GROUP BY 1
  ORDER BY 2) t2
JOIN (
  SELECT s.name sales_rep, r.name region_name , SUM(o.total_amt_usd) total_amt
  FROM region r
  JOIN sales_reps s
  ON s.region_id = r.id
  JOIN accounts a
  ON a.sales_rep_id = s.id
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY 1 , 2
  ORDER BY 3) t3
ON t2.region_name = t3.region_name AND t2.max_sales = t3.total_amt




/*For the region with the largest (sum) of sales total_amt_usd,
how many total (count) orders were placed?*/
SELECT MAX(no_of_orders) , t1.region_name
FROM
  (SELECT r.name region_name, SUM(o.total_amt_usd), COUNT(*) no_of_orders
  FROM region r
  JOIN sales_reps s
  ON r.id = region_id
  JOIN accounts a
  ON s.id = a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY 1) t1
ORDER BY 1





SELECT r.name region_name, SUM(o.total_amt_usd), COUNT(*)
FROM region r
JOIN sales_reps s
ON r.id = region_id
JOIN accounts a
ON s.id = a.sales_rep_id
JOIN orders o
ON a.id = o.account_id
GROUP BY 1






/* Provide the name of the sales_rep in each region with the largest amount of
of total_amt_usd sales . I am redoing this to master it*/
SELECT t2.largest_sum, t2.region_name, t3.rep_name
FROM (
  SELECT region_name , MAX(total_amt) largest_sum
  FROM(
    SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
    FROM region r
    JOIN sales_reps s
    ON r.id= s.region_id
    JOIN accounts a
    ON s.id= a.sales_rep_id
    JOIN orders o
    ON a.id = o.account_id
    GROUP BY 1, 2
    ORDER BY 3 DESC) t1
  GROUP BY 1
  ORDER BY 2) t2
JOIN (
  SELECT s.name rep_name, r.name region_name, SUM(o.total_amt_usd) total_amt
  FROM region r
  JOIN sales_reps s
  ON r.id= s.region_id
  JOIN accounts a
  ON s.id= a.sales_rep_id
  JOIN orders o
  ON a.id = o.account_id
  GROUP BY 1, 2
  ORDER BY 3) t3
ON t3.region_name = t2.region_name AND t3.largest_sum = t2.total_amt;
