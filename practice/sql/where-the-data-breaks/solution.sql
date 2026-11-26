select tbl_name, count(*) as failing_checks, countif(lower(severity) in ('high', 'critical')) as 
 high_severity_failures

from dq_checks
where passed=false
group by tbl_name
order by failing_checks desc, tbl_name asc
