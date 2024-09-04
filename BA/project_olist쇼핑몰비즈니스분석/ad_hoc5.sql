조건확인:
고객들의 월별 구입금액에 기반해서 그룹을 나누고,
각 그룹별 비중이 변화하는지/유지되는지를 확인하려고 합니다.
월 – 고객 unique ID – 해당 월의 구매금액 – 그룹 순서로 보여주세요.
300 BRL 이상은 A, 150 BRL 이상 300 BRL 미만은 B, 그 외 C입니다.
*/


SELECT
  DATE_TRUNC(DATE(ord.order_approved_at), MONTH) AS ord_month, 
  cust.customer_unique_id as `고객id`,
  SUM(item.price) AS `매출총액`, 
  CASE WHEN SUM(item.price) >= 300 THEN 'A' 
    WHEN SUM(item.price) >= 150 AND SUM(item.price) < 300 THEN 'B'
    ELSE 'C' END AS level
FROM `olist.olist_order` AS ord
INNER JOIN `olist.olist_order_items` AS item
  ON ord.order_id = item.order_id 
LEFT JOIN `olist.olist_customers` AS cust
  ON ord.customer_id = cust.customer_id
WHERE 1=1 
  AND order_approved_at IS NOT NULL 
GROUP BY 1, 2
ORDER BY ord_month ASC, `매출총액` DESC
;