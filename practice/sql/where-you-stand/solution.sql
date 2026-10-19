select svc_name, region, latency, avg(latency) over (partition by region)
as avg_region_latency from svc_health
order by region asc, svc_name asc, latency asc
