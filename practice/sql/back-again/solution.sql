WITH completed AS (
    SELECT
        user_id,
        COUNT(*) AS txn_count
    FROM transactions
    WHERE total_amount > 0
    GROUP BY user_id
),
ranked AS (
    SELECT
        user_id,
        txn_count,
        DENSE_RANK() OVER (
            ORDER BY txn_count DESC
        ) AS tier
    FROM completed
)
SELECT
    u.username,
    r.txn_count,
    r.tier
FROM ranked r
JOIN users u
    ON u.user_id = r.user_id
WHERE r.tier <= 2
ORDER BY r.tier, u.username;
