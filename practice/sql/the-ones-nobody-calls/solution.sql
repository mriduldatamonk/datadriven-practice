select endpoint, call_count, rnk from(
select endpoint, call_count, dense_rank() over (order by call_count)
as rnk from
(select endpoint, count(call_id) as call_count
from api_calls
where upper(method)='POST'
group by endpoint))
where rnk<=3;
