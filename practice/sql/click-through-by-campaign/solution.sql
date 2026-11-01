SELECT
    ad_campaign,
    COUNT(*) AS total_impressions,

    ROUND(
        100.0 * SUM(clicked) / COUNT(*),
        2
    ) AS clicked_pct,

    ROUND(
        100.0 * (COUNT(*) - SUM(clicked)) / COUNT(*),
        2
    ) AS not_clicked_pct

FROM ad_impressions

GROUP BY ad_campaign

ORDER BY ad_campaign;
