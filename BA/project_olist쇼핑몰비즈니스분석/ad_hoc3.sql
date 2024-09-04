/* 
시별 주문수, 매출, 고객수 구하기
조건 1. 2017년
조건 2. 고객수 기준 순위 제공
조건 3. 순위는 전체 순위, 주 기준 순위 둘다 제공할 것
조건 4. 배송완료(order_status = 'delivered') 된 건만 집계 
*/

WITH tb AS (
  SELECT 
    item.order_id, 
    SUM(item.price) AS ord_amt
  FROM `olist.olist_order_items` AS item
  GROUP BY item.order_id
)
, base AS (
  SELECT
    cust.customer_state as `시`,
    cust.customer_city as `도시`,
    COUNT(DISTINCT ord.order_id) AS `총주문건수`, 
    COUNT(DISTINCT cust.customer_unique_id) AS `총고객수`, 
    SUM(tb.ord_amt) AS `총매출` 
  FROM `olist.olist_order` AS ord
  LEFT JOIN `olist.olist_customers` AS cust 
    ON ord.customer_id = cust.customer_id
  INNER JOIN tb 
    ON ord.order_id = tb.order_id 
  WHERE 1=1
    AND EXTRACT(YEAR FROM order_approved_at) = 2017
    AND order_status = 'delivered'
  GROUP BY 1,2
)

SELECT 
  *,
  ROW_NUMBER() OVER (ORDER BY `총고객수` DESC) AS `전체순위`,
  ROW_NUMBER() OVER (PARTITION BY `시` ORDER BY `총고객수` DESC) AS `시 내 도시별 고객수순위`
FROM base
ORDER BY `전체순위` ASC
