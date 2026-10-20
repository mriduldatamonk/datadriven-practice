with ranked_tokens as (
    select
        token_id,
        scope,
        requests,
        percent_rank() over (
            partition by scope
            order by requests asc
        ) as percentile_rank
    from api_tokens
)

select
    token_id,
    scope,
    requests,
    round(percentile_rank, 2) as percentile_rank
from ranked_tokens
where percentile_rank >= 0.95
order by
    scope asc,
    requests desc,
    token_id asc;
