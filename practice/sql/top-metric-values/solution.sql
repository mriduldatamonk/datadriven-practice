select distinct
    printf('%.3f', metric_value) as metric_value
from employee_metrics
where metric_value is not null
order by metric_value desc
limit 5;
