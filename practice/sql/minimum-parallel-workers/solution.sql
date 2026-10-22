SELECT MAX(overlap_count) AS min_workers
FROM (
    SELECT
        a.job_id,
        COUNT(DISTINCT b.job_id) AS overlap_count
    FROM batch_jobs a
    JOIN batch_jobs b
      ON a.started < b.ended
     AND b.started < a.ended
    GROUP BY a.job_id
) t;
