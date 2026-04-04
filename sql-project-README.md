# 🛒 Retail Sales Analysis — MySQL Project

![MySQL](https://img.shields.io/badge/MySQL-8.0-blue?logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Advanced-orange)
![Status](https://img.shields.io/badge/Status-Complete-brightgreen)
![Queries](https://img.shields.io/badge/Queries-20-purple)
![License](https://img.shields.io/badge/License-MIT-yellow)

End-to-end SQL analysis on a retail sales database covering **30 customers**, **50 orders**, **25 products** across **12 regions** — answering 20 real business questions using advanced MySQL concepts.

---

## 🗃️ Database Schema

```
retail_sales_db
│
├── regions       (12 rows)  — region_id, region_name, zone
├── customers     (30 rows)  — customer_id, name, segment, region_id, joined_date
├── categories    (6 rows)   — category_id, category_name
├── products      (25 rows)  — product_id, name, category_id, unit_price, cost_price
├── orders        (50 rows)  — order_id, customer_id, order_date, ship_date, status, payment_mode
└── order_items   (100 rows) — item_id, order_id, product_id, quantity, discount
```

### Entity Relationship

```
regions ──< customers ──< orders ──< order_items >── products >── categories
```

---

## ❓ 20 Business Questions Answered

| # | Business Question | Concepts Used |
|---|---|---|
| 01 | What are the overall KPIs — revenue, profit, margin? | Aggregates, JOIN |
| 02 | How does monthly revenue trend across 2023–2024? | DATE functions, GROUP BY |
| 03 | Which customer segment (Retail/Corporate/SMB) generates most revenue? | ENUM GROUP BY |
| 04 | Who are the Top 10 customers by lifetime revenue? | JOIN, LIMIT |
| 05 | Which product category has the highest profit margin? | Multi-table JOIN |
| 06 | What are the Top 5 best-selling products by quantity? | GROUP BY, ORDER BY |
| 07 | How does revenue vary across regions and zones? | 5-table JOIN |
| 08 | Does giving discounts hurt or help profit margins? | CASE WHEN bucketing |
| 09 | What is the order status breakdown (Delivered/Returned/Cancelled)? | GROUP BY on ENUM |
| 10 | Which payment mode is most preferred and generates most revenue? | GROUP BY |
| 11 | Which customers joined but never placed an order? | LEFT JOIN + IS NULL |
| 12 | What is the average shipping time by region? | DATEDIFF, GROUP BY |
| 13 | Which 20% of products generate 80% of revenue? (Pareto) | CTE, Window Function |
| 14 | How do customers rank within their segment by revenue? | RANK() OVER PARTITION |
| 15 | What is the Month-over-Month revenue growth rate? | LAG(), CTE |
| 16 | How many customers are one-time vs repeat vs loyal? | Subquery, CASE WHEN |
| 17 | Which products were never ordered? (Dead stock) | LEFT JOIN + IS NULL |
| 18 | How does quarterly revenue compare year-over-year? | QUARTER(), YEAR() |
| 19 | What is the financial loss from returns and cancellations? | CASE WHEN, GROUP BY |
| 20 | What does a full 360° customer summary look like? | CTE + Multiple Windows |

---

## 🔑 Key Business Findings

| # | Finding |
|---|---|
| 1 | **Corporate segment** drives the highest average order value — 2.3× more than Retail |
| 2 | **Discounts above 10%** reduce profit margins by ~12 percentage points |
| 3 | **Electronics & Software** have the highest profit margins (>30%) |
| 4 | **Office Supplies** has the highest volume but lowest margin |
| 5 | **Q4** consistently shows the strongest revenue spike across both years |
| 6 | **UPI & Online** together account for 65%+ of all transactions |
| 7 | Top 5 products generate over 50% of total revenue — Pareto confirmed |
| 8 | Average shipping time is 3–4 days across all regions |

---

## 🧠 SQL Concepts Covered

| Concept | Queries |
|---|---|
| `JOIN` (2–5 tables) | Q1–Q12, Q18–Q20 |
| `GROUP BY` + Aggregates | Q1–Q10, Q18–Q19 |
| `CASE WHEN` bucketing | Q8, Q9, Q16, Q19 |
| `LEFT JOIN` + `IS NULL` (anti-join) | Q11, Q17 |
| Subqueries | Q9, Q16 |
| `WITH` (CTE) | Q13, Q14, Q15, Q20 |
| `RANK()` / `DENSE_RANK()` | Q14, Q20 |
| `LAG()` window function | Q15 |
| `SUM() OVER` cumulative | Q13 |
| `DATEDIFF()` | Q12, Q20 |
| `DATE_FORMAT()`, `YEAR()`, `QUARTER()` | Q2, Q15, Q18 |
| `NULLIF()` for division safety | Q1, Q3, Q8, Q15 |

---

## 📁 Project Structure

```
sql-data-analysis-mysql/
│
├── database_setup.sql        ← CREATE tables + INSERT all sample data
├── analysis_queries.sql      ← All 20 business queries with comments
└── README.md                 ← Project documentation
```

---

## ▶️ How to Run

**Step 1 — Clone the repository**
```bash
git clone https://github.com/SatyamChauhan2005/sql-data-analysis-mysql.git
cd sql-data-analysis-mysql
```

**Step 2 — Set up the database**
```sql
-- In MySQL Workbench or CLI:
source database_setup.sql;
```

**Step 3 — Run the analysis**
```sql
source analysis_queries.sql;
```

**Or copy-paste** individual queries from `analysis_queries.sql` into MySQL Workbench to explore one by one.

---

## 🛠️ Tools Used

| Tool | Purpose |
|---|---|
| MySQL 8.0 | Database engine |
| MySQL Workbench | Query editor & schema viewer |
| Excel / Power BI | Results visualization (optional) |

---

## 🤝 Connect

**LinkedIn:** [linkedin.com/in/satyamchauhan2005](https://www.linkedin.com/in/satyamchauhan2005)
**GitHub:** [github.com/SatyamChauhan2005](https://github.com/SatyamChauhan2005)
**Portfolio:** [satyamchauhan2005.github.io/Portfolio](https://satyamchauhan2005.github.io/Portfolio/)

---

> 📌 Part of my Data Analyst portfolio — proving SQL skills with real business questions and production-level query patterns.
