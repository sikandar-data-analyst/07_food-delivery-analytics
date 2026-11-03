-- 01 KPI
-- WHAT: calculate the headline KPIs in SQL
-- WHY: they must match the numbers from Python (the baseline)
-- NOTE: money numbers use Delivered orders only, as we decided in Phase 1
SELECT
    COUNT(*) AS total_orders,
    SUM(CASE WHEN Order_Status = 'Delivered' THEN 1 ELSE 0 END) AS delivered_orders,
    ROUND(SUM(CASE WHEN Order_Status = 'Delivered' THEN 1 ELSE 0 END) / COUNT(*) * 100, 1) AS completion_rate,
    ROUND(SUM(CASE WHEN Order_Status = 'Delivered' THEN Final_Order_Value_INR END)) AS final_order_value,
    ROUND(SUM(CASE WHEN Order_Status = 'Delivered' THEN Platform_Revenue_INR END)) AS platform_revenue,
    ROUND(SUM(CASE WHEN Order_Status = 'Delivered' THEN Estimated_Profit_INR END)) AS estimated_profit,
    ROUND(AVG(CASE WHEN Order_Status = 'Delivered' THEN Final_Order_Value_INR END), 1) AS avg_order_value,
    MIN(Order_Date) AS first_date,
    MAX(Order_Date) AS last_date
FROM orders;
-- RESULT: the file has 100,000 orders and 91,976 of them were delivered (92.0%).
-- The other 8,000 orders (4,927 cancelled and 3,097 refunded) are not in the money numbers.
-- Total final order value is Rs 47,287,300.
-- Platform revenue is Rs 15,625,814, which is about 33% of the final order value.
-- Estimated profit is Rs 9,367,045.
-- The average order value is Rs 514.1.
-- The data runs from 2025-01-01 to 2026-08-30.
-- These numbers are the same as my Python results, so both tools agree.


-- 02 KPI
-- WHAT: orders, revenue and profit for each month
-- WHY: business question 1, is the business growing?
-- DATE_FORMAT turns a date like 2026-05-12 into "2026-05"
SELECT
    DATE_FORMAT(Order_Date, '%Y-%m') AS order_month,
    COUNT(*) AS delivered_orders,
    ROUND(SUM(Platform_Revenue_INR)) AS revenue,
    ROUND(SUM(Estimated_Profit_INR)) AS profit
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
ORDER BY order_month;
-- RESULT: 20 rows, one for each month from Jan 2025 to Aug 2026.
-- Delivered orders stay between 4,173 and 4,750 a month, so there is no clear growth.
-- The lowest month is February 2025 (4,173 orders, Rs 426,070 profit).
-- February 2026 is the second lowest in profit (Rs 436,119).
-- Both Februaries are low because February has fewer days.
-- The highest profit month is April 2025 (Rs 495,905).
-- The highest order month is May 2026 (4,750 orders).
-- Revenue and profit go up and down with the number of orders.
-- Matches my Python monthly table (4,665 orders in Jan 2025 and 4,173 in Feb 2025).


-- 03 KPI
-- WHAT: profit for each month, plus the change compared with the month before
-- WHY: shows which months went up or down, without comparing them by eye
-- CTE (WITH ...): first build the monthly table, then work on top of it
WITH monthly AS (
    SELECT
        DATE_FORMAT(Order_Date, '%Y-%m') AS order_month,
        COUNT(*) AS delivered_orders,
        ROUND(SUM(Estimated_Profit_INR)) AS profit
    FROM orders
    WHERE Order_Status = 'Delivered'
    GROUP BY DATE_FORMAT(Order_Date, '%Y-%m')
)
SELECT
    order_month,
    delivered_orders,
    profit,
    -- LAG looks at the previous row, here the previous month
    LAG(profit) OVER (ORDER BY order_month) AS prev_month_profit,
    ROUND((profit - LAG(profit) OVER (ORDER BY order_month))
          / LAG(profit) OVER (ORDER BY order_month) * 100, 1) AS profit_change_pct
FROM monthly
ORDER BY order_month;
-- RESULT: the first month (Jan 2025) shows NULL because there is no month before it.
-- The biggest drop is February 2025 (-9.5%), then February 2026 (-8.9%).
-- The biggest rise is March 2026 (+11.1%), then March 2025 (+9.5%).
-- Each big rise comes right after a February drop, so it looks like a calendar effect.
-- August 2026 is down 7.6% because the data stops on 30 August.
-- Per day, orders stay at about 150, so I do not see a real up or down trend.