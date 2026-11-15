---this will check avg,not median

-- select tbl_name, round(avg(fail_pct)) from dq_checks 
-- group by tbl_name


SELECT
    tbl_name,
    ROUND(
        PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY fail_pct)
    ) AS median_fail_pct
FROM dq_checks
GROUP BY tbl_name;
