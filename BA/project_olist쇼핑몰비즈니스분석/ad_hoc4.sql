/* 
우리 고객들은 매월 평균 얼마를 쓰고 있나요? 
1. 월별 지표 
2. +) SAFE_DIVIDE 사용 (결제액이나, 고객수가 0이될수있으므로)
3. 결제일자가 나온 데이터만 사용(not null)
*/ 

SELECT
  DATE_TRUNC(DATE(ord.order_approved_at) , MONTH) AS month,
  round(SUM(item.price),2) AS `총매출`, 
  COUNT(DISTINCT cust.customer_unique_id) AS `총고객수`, 
  round(SAFE_DIVIDE(SUM(item.price) ,COUNT(DISTINCT cust.customer_unique_id)),2) AS `ARPPU_month`
FROM `olist.olist_order` AS ord
INNER JOIN `olist.olist_order_items` AS item
  ON ord.order_id = item.order_id 
LEFT JOIN `olist.olist_customers` AS cust
  ON ord.customer_id = cust.customer_id
where DATE_TRUNC(DATE(ord.order_approved_at) , MONTH) IS NOT NULL 
GROUP BY month
ORDER BY month