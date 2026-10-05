/*select msg_id,
case when content is null or trim(content)='' then 0
else array_length(regexp_extract_all(trim(content), '\S+'))
end as word_count
from chat_msgs */
---this code works fine in actual bigquery

--523, 1087,

select msg_id, length(trim(content))- length(replace(trim(content), ' ',''))+1
 as word_count

from chat_msgs
