-- 주문수로 침투율의 크기를 판단한다고 가정
select cust.customer_state, count(cust.customer_unique_id) as `고객수`, count(ord.order_id) as `주문수`
from `olistba1.olist.olist_order` as ord
left join `olistba1.olist.olist_customers` as cust
on ord.customer_id=cust.customer_id
where cust.customer_state IN ('RJ','SP')
group by cust.customer_state
order by `주문수`;
