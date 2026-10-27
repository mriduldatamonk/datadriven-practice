# /* got accepted but not technically correct 
# select svc_name, min(uptime) from svc_health 
# group by svc_name
# order by uptime asc
# limit 10

# */
# /*
# with svc_name_total_uptime as (
#   select svc_name,
#   min(uptime) as least_uptime -- get min uptime for each 
#   from svc_health
#   where uptime is not null -- exclude the null value, because we can't determine those rows for calculation
#   group by svc_name
# )
# select 
# svc_name,
# least_uptime,
# dense_rank() over(order by least_uptime) as least_reliable_rnk -- if clash, we will consider them all and give next rank to the next row
# from svc_name_total_uptime
# qualify least_reliable_rnk <=10

# */




import pyspark.sql.functions as F
from pyspark.sql.window import Window


aggregated_df = svc_health.groupBy("svc_name").agg(F.min('uptime').alias("min_uptime")).select("svc_name", "min_uptime")
window = Window.orderBy("min_uptime")
aggregated_df.withColumn("rank", F.dense_rank().over(window)).filter(F.col("rank")<=10).drop("rank")
