select err_type
, case when count=0 then 'NONE'
       when count between 1 and 5 then 'LOW'
       when count between 6 and 20 then 'MODERATE'
       when count between 21 and 50 then 'HIGH'
       when count>50 then 'CRITICAL'
  end as severity_level
from err_tracks
where count is not null
