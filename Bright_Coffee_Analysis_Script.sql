---- I am scanning through the data to check the types of data in the table (date, time, words and numbers)
SELECT*
FROM Sales.PUBLIC.COFFEE
LIMIT 10;
g
---Listing of categories 
SELECT
store_location,
product_category,
product_type,
product_detail,
TO_DATE(transaction_date) AS date_of_purchase,
DAYOFMONTH(TO_DATE(transaction_date)) AS day_of_month,
DAYNAME(TO_DATE(transaction_date)) AS day_name,
MONTHNAME(TO_DATE(transaction_date)) AS month_name,
TO_CHAR(TO_DATE(transaction_date), 'YYYYMM') AS month_id,

--- Time buckets
CASE 
WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
ELSE 'Night'
END AS time_buckets,

 -- Aggregates and COUNTS
SUM(transaction_qty * unit_price) AS Revenue,
AVG(transaction_qty * unit_price) AS Average_per_transaction,
MIN(transaction_time) AS Opening_time,
MAX(transaction_time) AS Closing_time,
COUNT(DISTINCT transaction_id) AS number_of_sales,
COUNT(DISTINCT product_id) AS number_of_products,
COUNT(DISTINCT store_id) AS number_of_stores,

--- Classifying if purchases are on Weekdays/Weekends
CASE    
WHEN DAYNAME(TO_DATE(transaction_date)) IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday'
END AS classification_of_day

FROM Sales.PUBLIC.COFFEE

GROUP BY
store_location,
product_category,
product_type,
product_detail,
TO_DATE(transaction_date),
DAYOFMONTH(TO_DATE(transaction_date)),
DAYNAME(TO_DATE(transaction_date)),
 MONTHNAME(TO_DATE(transaction_date)),
TO_CHAR(TO_DATE(transaction_date), 'YYYYMM'),
   
CASE 
WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening'
ELSE 'Night'
END,
    
CASE    
WHEN DAYNAME(TO_DATE(transaction_date)) IN ('Saturday','Sunday') THEN 'Weekend'
ELSE 'Weekday'
 END

ORDER BY date_of_purchase, store_location;







