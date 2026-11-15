---this will check avg,not median

-- select tbl_name, round(avg(fail_pct)) from dq_checks 
-- group by tbl_name


--correct but hifi approach


-- SELECT
--     tbl_name,
--     ROUND(
--         PERCENTILE_CONT(0.5)
--         WITHIN GROUP (ORDER BY fail_pct)
--     ) AS median_fail_pct
-- FROM dq_checks
-- GROUP BY tbl_name;



WITH ranked AS (
    SELECT
        tbl_name,
        fail_pct,

        ROW_NUMBER() OVER (
            PARTITION BY tbl_name
            ORDER BY fail_pct ASC
        ) AS rn,

        COUNT(*) OVER (
            PARTITION BY tbl_name
        ) AS total_rows

    FROM dq_checks
    WHERE fail_pct IS NOT NULL
)

SELECT
    tbl_name,
    ROUND(AVG(fail_pct)) AS median_fail_pct
FROM ranked
WHERE rn IN (
    FLOOR((total_rows + 1) / 2.0),
    FLOOR((total_rows + 2) / 2.0)
)
GROUP BY tbl_name
ORDER BY tbl_name;
