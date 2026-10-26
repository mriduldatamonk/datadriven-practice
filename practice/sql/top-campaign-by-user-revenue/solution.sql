with per_user_per_campaign_revenue as (
select 
  user_id, 
  ad_campaign, 
  sum(revenue) as total_rev
from ad_impressions where clicked=1   --consider only clicked ads
group by user_id, ad_campaign

)

--now, do the ranking
select user_id, ad_campaign from(
select user_id, ad_campaign,
rank() over(partition by user_id order by total_rev desc) as rn
from per_user_per_campaign_revenue 
)
where rn=1
order by user_id
