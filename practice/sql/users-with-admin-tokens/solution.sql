with users_api as(
select
  u.user_id
, u.username
, u.email
, a.token_id
, a.scope
, a.issued

from users u 
left join api_tokens a
on u.user_id= a.owner_id


where a.scope like ('%admin%')

order by u.user_id
),

ranked as (
select user_id, username, email, token_id, scope
, row_number() over (partition by user_id
order by cast(issued as date) asc) as rn
from users_api)

select user_id, username, email, token_id
, scope

from ranked order by user_id, rn;

/*

SELECT
    owner_id AS user_id,
    token_id,
    issued,
    CAST(issued AS DATE) AS issued_date
FROM api_tokens
WHERE owner_id = 197
  AND scope LIKE '%admin%'
ORDER BY CAST(issued AS DATE) ASC;

*/
