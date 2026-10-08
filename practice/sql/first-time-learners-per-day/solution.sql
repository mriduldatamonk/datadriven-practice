WITH first_sessions AS (
    SELECT
        user_id,
        MIN(DATE(session_start)) AS first_session_date
    FROM user_sessions
    GROUP BY user_id
)
SELECT
    first_session_date,
    COUNT(*) AS new_user_count
FROM first_sessions
GROUP BY first_session_date
ORDER BY first_session_date;
