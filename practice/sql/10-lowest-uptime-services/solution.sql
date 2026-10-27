select svc_name, min(uptime) from svc_health 
group by svc_name
order by uptime asc
limit 10
