WITH product_sales AS (
    SELECT
        p.category,
        p.product_name,
        SUM(t.total_amount) AS total_sales
    FROM transactions t
    JOIN products p
        ON t.product_id = p.product_id
    WHERE SUBSTR(t.transaction_date, 1, 4) = '2026'
    GROUP BY
        p.category,
        p.product_id,
        p.product_name
),
ranked_products AS (
    SELECT
        category,
        product_name,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS rn
    FROM product_sales
)
SELECT
    category,
    product_name,
    ROUND(total_sales, 2) AS total_revenue
FROM ranked_products
WHERE rn = 1
ORDER BY total_revenue DESC;
