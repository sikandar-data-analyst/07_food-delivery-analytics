# KPI Validation

I calculated the same KPIs in Python, SQL (MySQL) and Power BI, then compared them.
If the three tools give the same number, I can trust the cleaning and the logic.

**Rule used for money numbers:** only Delivered orders are counted.
Cancelled and Refunded orders are not included in revenue, profit or order value.

## Main KPIs

| KPI | Python | SQL | Power BI |
|---|---|---|---|
| Total orders | 100,000 | 100,000 | 100K |
| Delivered orders | 91,976 | 91,976 | 92K |
| Completion rate | 92.0% | 92.0% | 92.0% |
| Final order value (Rs) | 47,287,300 | 47,287,300 | 47.29M |
| Platform revenue (Rs) | 15,625,814 | 15,625,814 | 15.63M |
| Estimated profit (Rs) | 9,367,045 | 9,367,045 | 9.37M |
| Average order value (Rs) | 514.1 | 514.1 | 514.13 |

Power BI cards round big numbers (for example 9.37M). I set display units to "None"
when I wanted to see the full number.

## Extra cross-checks

| Check | Python | SQL | Power BI |
|---|---|---|---|
| Top city by profit | Mumbai, Rs 797,738 | Mumbai, Rs 797,738 | Mumbai, 0.80M |
| Top restaurant by profit | Popeyes, Rs 477,580 | Popeyes, Rs 477,580 | Popeyes, Rs 152 per order (top of chart) |
| Orders lost money, up to Rs 200 | 13.0% | 13.0% | 13.03% |
| Orders lost money, over Rs 400 | 0.0% | 0.0% | 0.00% |
| Discount given on delivered orders (Rs) | 4,217,719 | not queried | 4.22M |
| Share of delivered orders with a discount | 57.3% | not queried | 57.31% |

## Mistakes I found and fixed in Power BI

1. **Two cards used the default sum, not my measure.** "Sum of Final_Order_Value_INR"
   showed 51.38M, and "Sum of Platform_Revenue_INR" showed 16.98M. These added up
   Cancelled and Refunded orders too. After using the measures that count Delivered
   orders only, they showed 47.29M and 15.63M, which match SQL.
2. **The monthly profit line showed a fake drop.** I used month names on the axis, so
   January to August added up two years and September to December only one year.
   I fixed it with a `Year_Month` text label (like 2025-01) and sorted it by time.
3. **A blank group was hidden in a chart.** Orders over Rs 400 never lose money, so the
   measure returned blank and the group disappeared. I wrapped it in COALESCE so it
   shows as 0%.

## Notes

- All numbers come from the cleaned file, `greedy_uber_eats_100k_orders_cleaned.csv`.
- Estimated profit is an estimate, not real accounting.
- The data looks generated (for example, cities have nearly equal order counts), so
  results describe this dataset only.
