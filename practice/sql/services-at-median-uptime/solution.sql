WITH service_avg AS (
    SELECT
        svc_name,
        AVG(uptime) AS avg_uptime
    FROM svc_health
    GROUP BY svc_name
),
tiered AS (
    SELECT
        *,
        NTILE(4) OVER (
            ORDER BY avg_uptime ASC, svc_name
        ) AS tier,
        MAX(avg_uptime) OVER () AS fleet_best
    FROM service_avg
),
compared AS (
    SELECT
        *,
        MAX(avg_uptime) OVER (
            PARTITION BY tier
        ) AS tier_best
    FROM tiered
)
SELECT
    svc_name,
    ROUND(avg_uptime, 3) AS avg_uptime,
    ROUND(fleet_best - avg_uptime, 3) AS gap_to_best,
    ROUND(tier_best - avg_uptime, 3) AS gap_to_tier_best
FROM compared
WHERE tier IN (1, 2)
ORDER BY svc_name;
