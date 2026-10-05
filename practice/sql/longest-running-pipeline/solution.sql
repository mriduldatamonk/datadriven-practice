select distinct pipe_name from(
select pipe_name, dur_secs , dense_rank() over (order by dur_secs desc) as rnk
from data_pipes)
where rnk=1
