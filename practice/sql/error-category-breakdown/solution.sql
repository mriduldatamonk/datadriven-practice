with category_redefined as (
 select 
   err_id
 , case when lower(err_type) like '%timeout%' then 'timeout'
        when lower(err_type) like '%memory%' then 'memory'
        else 'other'
   end as error_category
 
from err_tracks

)

select error_category, count(*) from category_redefined group by error_category
