WITH monthly_sales AS (
    SELECT
        product_id,
        STRFTIME('%Y-%m', transaction_date) AS month,
        SUM(total_amount) AS monthly_total
    FROM transactions
    WHERE product_id IS NOT NULL
    GROUP BY
        product_id,
        STRFTIME('%Y-%m', transaction_date)
)
SELECT
    product_id,
    month,
    ROUND(monthly_total, 3) AS monthly_total,
    ROUND(
        SUM(monthly_total) OVER (
            PARTITION BY product_id
            ORDER BY month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        3
    ) AS cumulative_total
FROM monthly_sales
ORDER BY product_id, month;
