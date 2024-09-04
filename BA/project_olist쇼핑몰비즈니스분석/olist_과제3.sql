/*
설정조건들
조건 1. 2017년 월별 (날짜 기준 = 'order_approved_at', 날짜 null인 경우 제외)
조건 2. 집계 후 정렬은 연도.월 기준 오름차순, 매출 기준 내림차순
조건 3. 배송완료(order_status = 'delivered') 된 건만 집계
조건 4. 주문 테이블과 주문 상품 정보 테이블에 모두 있는 주문건만 사용, 주문 상품 정보 테이블 기준으로 카테고리명을 붙일 것

*/

SELECT 
  DATE_TRUNC(DATE(order_approved_at), MONTH) AS ord_month, 
  catg.ctg1 as `카테고리이름_영문명`, 
  SUM(item.price) AS `매출총액`
FROM `olist.olist_order_items` AS item
INNER JOIN `olist.olist_order` AS ord
  USING (order_id) 
LEFT JOIN `olist.olist_products` AS prd
  ON item.product_id = prd.product_id
LEFT JOIN `olist.product_category_name_translation` AS catg
  ON prd.product_category_name = catg.category_name_port
WHERE 1=1
  AND EXTRACT(YEAR FROM ord.order_approved_at) = 2017
  AND ord.order_status = 'delivered'
GROUP BY 1, 2
ORDER BY ord_month ASC, `매출총액` DESC


