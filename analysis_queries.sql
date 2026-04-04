-- ============================================================
--  RETAIL SALES ANALYSIS — BUSINESS QUERIES
--  Author  : Satyam Chauhan
--  GitHub  : https://github.com/SatyamChauhan2005
--  Total   : 20 Queries | Concepts: JOINs, GROUP BY,
--            Subqueries, Window Functions, CTEs, CASE
-- ============================================================

USE retail_sales_db;

-- ============================================================
-- QUERY 01 — Total Revenue, Profit & Orders (KPI Overview)
-- Concept  : Aggregate functions, JOIN, computed columns
-- ============================================================
SELECT
    COUNT(DISTINCT o.order_id)                                          AS total_orders,
    COUNT(DISTINCT o.customer_id)                                       AS unique_customers,
    ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2)      AS total_revenue,
    ROUND(SUM(oi.quantity * (p.unit_price * (1 - oi.discount)
              - p.cost_price)), 2)                                       AS total_profit,
    ROUND(
        SUM(oi.quantity * (p.unit_price*(1-oi.discount) - p.cost_price))
        / NULLIF(SUM(oi.quantity * p.unit_price * (1-oi.discount)),0)
        * 100, 2
    )                                                                   AS profit_margin_pct
FROM orders o
JOIN order_items oi ON o.order_id   = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
WHERE o.status = 'Delivered';


-- ============================================================
-- QUERY 02 — Monthly Revenue Trend (2023 vs 2024)
-- Concept  : DATE functions, GROUP BY, ORDER BY
-- ============================================================
SELECT
    YEAR(o.order_date)                                                  AS yr,
    MONTH(o.order_date)                                                 AS mth,
    MONTHNAME(o.order_date)                                             AS month_name,
    ROUND(SUM(oi.quantity * p.unit_price * (1 - oi.discount)), 2)      AS revenue,
    COUNT(DISTINCT o.order_id)                                          AS orders
FROM orders o
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY yr, mth, month_name
ORDER BY yr, mth;


-- ============================================================
-- QUERY 03 — Revenue by Customer Segment
-- Concept  : GROUP BY on ENUM, JOIN multiple tables
-- ============================================================
SELECT
    c.segment,
    COUNT(DISTINCT o.order_id)                                          AS total_orders,
    COUNT(DISTINCT o.customer_id)                                       AS customers,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue,
    ROUND(AVG(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS avg_order_value,
    ROUND(
        SUM(oi.quantity*(p.unit_price*(1-oi.discount)-p.cost_price))
        / NULLIF(SUM(oi.quantity*p.unit_price*(1-oi.discount)),0)*100,2
    )                                                                   AS profit_margin_pct
FROM orders o
JOIN customers   c  ON o.customer_id = c.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY c.segment
ORDER BY revenue DESC;


-- ============================================================
-- QUERY 04 — Top 10 Customers by Revenue
-- Concept  : JOIN, GROUP BY, ORDER BY, LIMIT
-- ============================================================
SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    r.region_name,
    COUNT(DISTINCT o.order_id)                                          AS orders_placed,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS total_revenue,
    ROUND(SUM(oi.quantity*(p.unit_price*(1-oi.discount)-p.cost_price)),2) AS total_profit
FROM customers   c
JOIN orders      o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
JOIN regions     r  ON c.region_id   = r.region_id
WHERE o.status = 'Delivered'
GROUP BY c.customer_id, c.customer_name, c.segment, r.region_name
ORDER BY total_revenue DESC
LIMIT 10;


-- ============================================================
-- QUERY 05 — Revenue & Profit by Product Category
-- Concept  : Multi-table JOIN, GROUP BY, computed columns
-- ============================================================
SELECT
    cat.category_name,
    COUNT(DISTINCT oi.item_id)                                          AS items_sold,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue,
    ROUND(SUM(oi.quantity*(p.unit_price*(1-oi.discount)-p.cost_price)),2) AS profit,
    ROUND(
        SUM(oi.quantity*(p.unit_price*(1-oi.discount)-p.cost_price))
        / NULLIF(SUM(oi.quantity*p.unit_price*(1-oi.discount)),0)*100,2
    )                                                                   AS margin_pct
FROM order_items oi
JOIN products    p   ON oi.product_id   = p.product_id
JOIN categories  cat ON p.category_id   = cat.category_id
JOIN orders      o   ON oi.order_id     = o.order_id
WHERE o.status = 'Delivered'
GROUP BY cat.category_name
ORDER BY revenue DESC;


-- ============================================================
-- QUERY 06 — Top 5 Best-Selling Products by Quantity
-- Concept  : JOIN, GROUP BY, ORDER BY, LIMIT
-- ============================================================
SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    SUM(oi.quantity)                                                    AS total_qty_sold,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue
FROM order_items oi
JOIN products   p   ON oi.product_id = p.product_id
JOIN categories cat ON p.category_id = cat.category_id
JOIN orders     o   ON oi.order_id   = o.order_id
WHERE o.status = 'Delivered'
GROUP BY p.product_id, p.product_name, cat.category_name
ORDER BY total_qty_sold DESC
LIMIT 5;


-- ============================================================
-- QUERY 07 — Region-Wise Revenue Performance
-- Concept  : JOIN across 5 tables, GROUP BY
-- ============================================================
SELECT
    r.zone,
    r.region_name,
    COUNT(DISTINCT o.order_id)                                          AS orders,
    COUNT(DISTINCT c.customer_id)                                       AS customers,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue,
    ROUND(SUM(oi.quantity*(p.unit_price*(1-oi.discount)-p.cost_price)),2) AS profit
FROM regions     r
JOIN customers   c  ON r.region_id   = c.region_id
JOIN orders      o  ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY r.zone, r.region_name
ORDER BY revenue DESC;


-- ============================================================
-- QUERY 08 — Discount Impact on Profit Margin
-- Concept  : CASE WHEN bucketing, GROUP BY
-- ============================================================
SELECT
    CASE
        WHEN oi.discount = 0            THEN 'No Discount'
        WHEN oi.discount <= 0.05        THEN '1–5%'
        WHEN oi.discount <= 0.10        THEN '6–10%'
        ELSE 'Above 10%'
    END                                                                 AS discount_band,
    COUNT(*)                                                            AS line_items,
    ROUND(AVG(p.unit_price * (1-oi.discount)), 2)                      AS avg_selling_price,
    ROUND(
        AVG((p.unit_price*(1-oi.discount) - p.cost_price)
            / NULLIF(p.unit_price*(1-oi.discount), 0) * 100), 2
    )                                                                   AS avg_margin_pct
FROM order_items oi
JOIN products p  ON oi.product_id = p.product_id
JOIN orders   o  ON oi.order_id   = o.order_id
WHERE o.status = 'Delivered'
GROUP BY discount_band
ORDER BY avg_margin_pct DESC;


-- ============================================================
-- QUERY 09 — Order Status Breakdown
-- Concept  : GROUP BY on ENUM, percentage calculation
-- ============================================================
SELECT
    status,
    COUNT(*)                                                            AS total_orders,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM orders), 2)        AS pct_of_total
FROM orders
GROUP BY status
ORDER BY total_orders DESC;


-- ============================================================
-- QUERY 10 — Payment Mode Preference Analysis
-- Concept  : GROUP BY, ROUND, ORDER BY
-- ============================================================
SELECT
    o.payment_mode,
    COUNT(DISTINCT o.order_id)                                          AS orders,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue,
    ROUND(AVG(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS avg_order_value
FROM orders      o
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY o.payment_mode
ORDER BY revenue DESC;


-- ============================================================
-- QUERY 11 — Customers With No Orders (Lost Leads)
-- Concept  : LEFT JOIN + IS NULL (anti-join pattern)
-- ============================================================
SELECT
    c.customer_id,
    c.customer_name,
    c.segment,
    c.joined_date,
    r.region_name
FROM customers c
LEFT JOIN orders o ON c.customer_id = o.customer_id
JOIN regions     r ON c.region_id   = r.region_id
WHERE o.order_id IS NULL
ORDER BY c.joined_date;


-- ============================================================
-- QUERY 12 — Average Shipping Days by Region
-- Concept  : DATEDIFF, JOIN, GROUP BY
-- ============================================================
SELECT
    r.region_name,
    ROUND(AVG(DATEDIFF(o.ship_date, o.order_date)), 1)                 AS avg_ship_days,
    MIN(DATEDIFF(o.ship_date, o.order_date))                           AS min_ship_days,
    MAX(DATEDIFF(o.ship_date, o.order_date))                           AS max_ship_days
FROM orders    o
JOIN customers c ON o.customer_id = c.customer_id
JOIN regions   r ON c.region_id   = r.region_id
WHERE o.status = 'Delivered'
GROUP BY r.region_name
ORDER BY avg_ship_days;


-- ============================================================
-- QUERY 13 — Pareto Analysis: Top 20% Products → Revenue %
-- Concept  : Subquery, cumulative revenue, window function
-- ============================================================
WITH product_revenue AS (
    SELECT
        p.product_name,
        cat.category_name,
        ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)    AS revenue
    FROM order_items oi
    JOIN products   p   ON oi.product_id = p.product_id
    JOIN categories cat ON p.category_id = cat.category_id
    JOIN orders     o   ON oi.order_id   = o.order_id
    WHERE o.status = 'Delivered'
    GROUP BY p.product_name, cat.category_name
),
total AS (
    SELECT SUM(revenue) AS grand_total FROM product_revenue
)
SELECT
    pr.product_name,
    pr.category_name,
    pr.revenue,
    ROUND(pr.revenue / t.grand_total * 100, 2)                         AS revenue_pct,
    ROUND(
        SUM(pr.revenue) OVER (ORDER BY pr.revenue DESC) / t.grand_total * 100
    , 2)                                                                AS cumulative_pct
FROM product_revenue pr, total t
ORDER BY pr.revenue DESC;


-- ============================================================
-- QUERY 14 — Customer Ranking by Revenue (Window Function)
-- Concept  : RANK() OVER, PARTITION BY segment
-- ============================================================
WITH customer_revenue AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.segment,
        ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)    AS revenue
    FROM customers   c
    JOIN orders      o  ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id    = oi.order_id
    JOIN products    p  ON oi.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY c.customer_id, c.customer_name, c.segment
)
SELECT
    customer_name,
    segment,
    revenue,
    RANK()       OVER (PARTITION BY segment ORDER BY revenue DESC)     AS rank_in_segment,
    DENSE_RANK() OVER (ORDER BY revenue DESC)                          AS overall_rank
FROM customer_revenue
ORDER BY segment, rank_in_segment;


-- ============================================================
-- QUERY 15 — Month-over-Month Revenue Growth %
-- Concept  : LAG() window function, CTE
-- ============================================================
WITH monthly AS (
    SELECT
        DATE_FORMAT(o.order_date, '%Y-%m')                             AS yr_month,
        ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)    AS revenue
    FROM orders      o
    JOIN order_items oi ON o.order_id    = oi.order_id
    JOIN products    p  ON oi.product_id = p.product_id
    WHERE o.status = 'Delivered'
    GROUP BY yr_month
)
SELECT
    yr_month,
    revenue,
    LAG(revenue) OVER (ORDER BY yr_month)                              AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY yr_month))
        / NULLIF(LAG(revenue) OVER (ORDER BY yr_month), 0) * 100
    , 2)                                                               AS mom_growth_pct
FROM monthly
ORDER BY yr_month;


-- ============================================================
-- QUERY 16 — Repeat vs One-Time Customers
-- Concept  : Subquery with HAVING, CASE WHEN
-- ============================================================
SELECT
    CASE
        WHEN order_count = 1 THEN 'One-Time'
        WHEN order_count = 2 THEN 'Repeat (2x)'
        ELSE 'Loyal (3x+)'
    END                                                                 AS customer_type,
    COUNT(*)                                                            AS customer_count,
    ROUND(AVG(order_count), 1)                                         AS avg_orders
FROM (
    SELECT
        customer_id,
        COUNT(order_id) AS order_count
    FROM orders
    WHERE status = 'Delivered'
    GROUP BY customer_id
) AS order_counts
GROUP BY customer_type
ORDER BY customer_count DESC;


-- ============================================================
-- QUERY 17 — Products Never Ordered (Dead Stock)
-- Concept  : LEFT JOIN + IS NULL (anti-join)
-- ============================================================
SELECT
    p.product_id,
    p.product_name,
    cat.category_name,
    p.unit_price
FROM products   p
LEFT JOIN order_items oi ON p.product_id = oi.product_id
JOIN categories cat      ON p.category_id = cat.category_id
WHERE oi.item_id IS NULL
ORDER BY p.category_id;


-- ============================================================
-- QUERY 18 — Quarterly Revenue Comparison (YoY)
-- Concept  : QUARTER(), YEAR(), GROUP BY, pivot-style
-- ============================================================
SELECT
    YEAR(o.order_date)                                                  AS yr,
    QUARTER(o.order_date)                                               AS qtr,
    CONCAT('Q', QUARTER(o.order_date), '-', YEAR(o.order_date))        AS quarter_label,
    COUNT(DISTINCT o.order_id)                                          AS orders,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue,
    ROUND(SUM(oi.quantity*(p.unit_price*(1-oi.discount)-p.cost_price)),2) AS profit
FROM orders      o
JOIN order_items oi ON o.order_id    = oi.order_id
JOIN products    p  ON oi.product_id = p.product_id
WHERE o.status = 'Delivered'
GROUP BY yr, qtr, quarter_label
ORDER BY yr, qtr;


-- ============================================================
-- QUERY 19 — Returned & Cancelled Orders: Loss Analysis
-- Concept  : CASE WHEN, GROUP BY, computed columns
-- ============================================================
SELECT
    o.status,
    COUNT(DISTINCT o.order_id)                                          AS orders,
    ROUND(SUM(oi.quantity * p.unit_price * (1-oi.discount)), 2)        AS revenue_lost,
    ROUND(SUM(oi.quantity * p.cost_price), 2)                          AS cost_incurred,
    GROUP_CONCAT(DISTINCT cat.category_name ORDER BY cat.category_name) AS affected_categories
FROM orders      o
JOIN order_items oi  ON o.order_id    = oi.order_id
JOIN products    p   ON oi.product_id = p.product_id
JOIN categories  cat ON p.category_id = cat.category_id
WHERE o.status IN ('Returned', 'Cancelled')
GROUP BY o.status;


-- ============================================================
-- QUERY 20 — Full Customer 360° View (Summary Report)
-- Concept  : CTE, multiple JOINs, window functions
-- ============================================================
WITH customer_stats AS (
    SELECT
        c.customer_id,
        c.customer_name,
        c.segment,
        r.region_name,
        r.zone,
        COUNT(DISTINCT o.order_id)                                      AS total_orders,
        SUM(CASE WHEN o.status='Returned'  THEN 1 ELSE 0 END)          AS returns,
        SUM(CASE WHEN o.status='Cancelled' THEN 1 ELSE 0 END)          AS cancels,
        ROUND(SUM(oi.quantity*p.unit_price*(1-oi.discount)), 2)        AS lifetime_revenue,
        MIN(o.order_date)                                               AS first_order,
        MAX(o.order_date)                                               AS last_order,
        DATEDIFF(MAX(o.order_date), MIN(o.order_date))                 AS active_days
    FROM customers   c
    JOIN regions     r  ON c.region_id   = r.region_id
    JOIN orders      o  ON c.customer_id = o.customer_id
    JOIN order_items oi ON o.order_id    = oi.order_id
    JOIN products    p  ON oi.product_id = p.product_id
    GROUP BY c.customer_id, c.customer_name, c.segment, r.region_name, r.zone
)
SELECT
    customer_id,
    customer_name,
    segment,
    region_name,
    zone,
    total_orders,
    returns,
    cancels,
    lifetime_revenue,
    first_order,
    last_order,
    active_days,
    RANK() OVER (ORDER BY lifetime_revenue DESC)                        AS revenue_rank,
    RANK() OVER (PARTITION BY segment ORDER BY lifetime_revenue DESC)  AS segment_rank
FROM customer_stats
ORDER BY lifetime_revenue DESC;
