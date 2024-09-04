WITH tb AS (
  SELECT 
    item.order_id, 
    SUM(item.price) AS ord_amt, 
    COUNT(item.order_item_id) AS prd_cnt
  FROM `olist.olist_order_items` AS item
  GROUP BY item.order_id
)
/* 두 번째 : 주문 정보 테이블에 1번 결과와, 고객 unique ID를 붙입니다 */
, base AS (
  SELECT 
    ord.order_approved_at, 
    -- 주차 단위로 날짜를 잘라냅니다.
    TIMESTAMP_TRUNC(ord.order_approved_at, WEEK) as ord_week_t, 

    ord.order_id,
    ord.customer_id,
    cust.customer_unique_id,
    tb.ord_amt, 
    tb.prd_cnt 
  FROM `olist.olist_order` AS ord
  LEFT JOIN `olist.olist_customers` AS cust
    ON ord.customer_id = cust.customer_id
  INNER JOIN tb 
    ON ord.order_id = tb.order_id
)
/* 주차별 집계를 수행하고 주차에 대한 순차적인 번호를 매깁니다 */
, week_summary AS (
  SELECT 
    ord_week_t,  -- 주차 단위로 자른 날짜
    ROW_NUMBER() OVER (ORDER BY ord_week_t) AS week_number,  -- 주차별로 순차적으로 번호를 매깁니다
    round(SUM(ord_amt),2) AS `총매출`, 
    COUNT(DISTINCT order_id) AS `총주문수`, 
    SUM(prd_cnt) AS `총판매상품수`, -- 총 판매 상품 수
    round(SUM(ord_amt) / COUNT(DISTINCT order_id),2) AS `주문당평균가격`, -- 주문 당 평균 가격  
    round(SUM(prd_cnt) / COUNT(DISTINCT order_id),1) AS `평균판매상품수`, -- 주문 당 평균 판매상품 수 
    round(SUM(ord_amt) / SUM(prd_cnt),2) AS `제품개당평균가격`, -- 판매 제품 당 평균 가격
    COUNT(DISTINCT customer_unique_id) AS `주문고객수`, 
    round(COUNT(DISTINCT order_id) / COUNT(DISTINCT customer_unique_id)) AS `주문빈도`
    
  FROM base
  GROUP BY ord_week_t  -- 주차 단위로 그룹화
  ORDER BY ord_week_t
)
SELECT *
FROM week_summary
ORDER BY ord_week_t;
