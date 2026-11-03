
-- 01
-- WHAT: profit for each restaurant, ranked from best to worst
-- WHY: business question 3, which restaurants earn the most
-- HAVING filters the groups after they are made (WHERE filters rows before)
-- RANK gives the position, 1 = most profit
SELECT
    Restaurant,
    Cuisine,
    COUNT(*) AS orders,
    ROUND(SUM(Estimated_Profit_INR)) AS profit,
    ROUND(AVG(Estimated_Profit_INR), 1) AS profit_per_order,
    RANK() OVER (ORDER BY SUM(Estimated_Profit_INR) DESC) AS profit_rank
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Restaurant, Cuisine
HAVING COUNT(*) >= 1000
ORDER BY profit_rank;
-- ============================================================
-- BUSINESS INSIGHT 1: Restaurant profit
-- About: which restaurants earn the most and the least profit
-- ============================================================
-- Popeyes earns the most profit (Rs 477,580), then KFC and Bakingo.
-- McDonald's earns the least (Rs 142,796), and Burger King is just above it.
-- Every restaurant gets about 3,100 to 3,300 delivered orders,
-- so the gap is not about how many orders they get.
-- The difference is profit per order: Rs 152 at Popeyes, only Rs 45 at McDonald's.
-- Higher priced items bring more revenue, but the cost per order stays similar.
-- Note: cost is an estimate, so this is estimated profit.



-- ================================================= 
-- 02
-- Query A
-- WHAT: compare the three promo groups
-- WHY: business question 6, do discounts bring profit or just cost money?
-- The CASE WHEN inside AVG turns each order into 1 (lost money) or 0 (did not)
-- so the average is the share of loss-making orders
SELECT
    Promo_Status,
    COUNT(*) AS orders,
    ROUND(AVG(Final_Order_Value_INR), 1) AS avg_order_value,
    ROUND(AVG(Discount_INR), 1) AS avg_discount,
    ROUND(AVG(Estimated_Profit_INR), 1) AS avg_profit,
    ROUND(AVG(CASE WHEN Estimated_Profit_INR < 0 THEN 1 ELSE 0 END) * 100, 1) AS loss_rate
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Promo_Status
ORDER BY avg_profit DESC;

-- Query B
-- WHAT: the same idea for each promo code
-- WHY: do the three codes behave differently?
-- COALESCE replaces NULL with the word 'None', so blank codes show up as a group
SELECT
    COALESCE(Promo_Code, 'None') AS promo_code,
    COUNT(*) AS orders,
    ROUND(AVG(Discount_INR), 1) AS avg_discount,
    ROUND(AVG(Estimated_Profit_INR), 1) AS avg_profit
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY COALESCE(Promo_Code, 'None')
ORDER BY avg_profit DESC;
-- ============================================================
-- BUSINESS INSIGHT 2: Promotions and discounts
-- About: do discounts bring more profit or just cost money
-- ============================================================
-- Orders without a discount make Rs 126.5 profit per order.
-- Orders with a discount make about Rs 83, which is about Rs 43 less.
-- About 4% of discounted orders lose money. Orders without a discount never do.
-- Query B: all three promo codes give about Rs 80 off and about Rs 83 profit,
-- so no promo code works better than the others.
-- Orders with a discount but no code look the same as orders with a code.
-- Limit: the data cannot show if a discount brought extra orders.



-- =================================================
-- 03
-- WHAT: compare the 5 acquisition channels
-- WHY: business question 10, which channels bring good orders?
-- cancel_rate uses all orders, profit_per_order uses delivered orders only
-- AVG ignores NULL, so avg_rating only counts orders that have a rating
SELECT
    Acquisition_Channel,
    COUNT(*) AS all_orders,
    ROUND(AVG(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) * 100, 2) AS cancel_rate,
    ROUND(AVG(CASE WHEN Order_Status = 'Delivered' THEN Estimated_Profit_INR END), 1) AS profit_per_order,
    ROUND(AVG(Customer_Rating), 2) AS avg_rating
FROM orders
GROUP BY Acquisition_Channel
ORDER BY all_orders DESC;
-- ============================================================
-- BUSINESS INSIGHT 3: Acquisition channels
-- About: which channels bring good orders
-- ============================================================
-- Organic brings about half of all orders (48,105 out of 100,000).
-- Referral earns the most per order (Rs 103.4) but also has the most cancels (5.35%).
-- The gap between the best and worst channel is only about Rs 2 per order.
-- Ratings are about 4.36 for every channel.
-- No channel is clearly better, so I would not decide anything from this alone.


-- =======================================================
-- 04
-- Query A
-- WHAT: orders, profit and delivery time for each meal period
-- WHY: business question 11, when is the business busiest?
SELECT
    Meal_Period,
    COUNT(*) AS delivered_orders,
    ROUND(AVG(Estimated_Profit_INR), 1) AS profit_per_order,
    ROUND(AVG(Delivery_Time_Min), 1) AS avg_delivery_min
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Meal_Period
ORDER BY delivered_orders DESC;

-- Query B
-- WHAT: the 5 busiest hours of the day
-- WHY: peak hours decide how many delivery partners are needed
-- LIMIT 5 keeps only the first 5 rows
SELECT
    Order_Hour,
    COUNT(*) AS delivered_orders
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Order_Hour
ORDER BY delivered_orders DESC
LIMIT 5;

-- ============================================================
-- BUSINESS INSIGHT 4: Meal periods and peak hours
-- About: when the business is busiest
-- ============================================================
-- Dinner is the busiest meal period (37,093 delivered orders).
-- The busiest hours are 8 PM, 7 PM and 9 PM.
-- Profit per order (about Rs 101 to 103) and delivery time (about 39 minutes)
-- are the same in every meal period.
-- So busy hours do not seem to slow down delivery in this data.


-- ==================================================
-- 05
-- WHAT: compare the 5 payment methods
-- WHY: business question 12, do payment methods differ in failed orders or order value?
-- failed_rate = cancelled + refunded orders as a % of all orders
SELECT
    Payment_Method,
    COUNT(*) AS all_orders,
    ROUND(AVG(CASE WHEN Order_Status <> 'Delivered' THEN 1 ELSE 0 END) * 100, 2) AS failed_rate,
    ROUND(AVG(CASE WHEN Order_Status = 'Delivered' THEN Final_Order_Value_INR END), 1) AS avg_order_value,
    ROUND(AVG(CASE WHEN Order_Status = 'Delivered' THEN Estimated_Profit_INR END), 1) AS profit_per_order
FROM orders
GROUP BY Payment_Method
ORDER BY all_orders DESC;
-- ============================================================
-- BUSINESS INSIGHT 5: Payment methods
-- About: do payment methods differ in failed orders or order value
-- ============================================================
-- About 8% of orders fail (cancelled or refunded) for every payment method.
-- Wallet is highest (8.23%) and UPI is lowest (7.77%), a gap of less than half a point.
-- Average order value (about Rs 513) and profit per order (about Rs 102)
-- are almost the same for all five methods.
-- Payment method does not seem to matter here.


-- ===================================================
-- 06
-- WHAT: how often orders lose money, by order size
-- WHY: business question 7, we saw in Python that small orders seem to lose money
-- CASE WHEN builds the size groups, in order from the smallest
SELECT
    CASE
        WHEN Gross_Value_INR <= 200 THEN '1: up to 200'
        WHEN Gross_Value_INR <= 300 THEN '2: 201-300'
        WHEN Gross_Value_INR <= 400 THEN '3: 301-400'
        ELSE '4: over 400'
    END AS order_size,
    COUNT(*) AS delivered_orders,
    SUM(CASE WHEN Estimated_Profit_INR < 0 THEN 1 ELSE 0 END) AS loss_orders,
    ROUND(AVG(CASE WHEN Estimated_Profit_INR < 0 THEN 1 ELSE 0 END) * 100, 1) AS loss_rate
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY order_size
ORDER BY order_size;

-- ============================================================
-- BUSINESS INSIGHT 6: Loss-making orders
-- About: which orders lose money, by order size
-- ============================================================
-- Small orders are the problem.
-- 13.0% of orders up to Rs 200 lose money, 2.1% of orders from Rs 201 to 300,
-- and 0.1% from Rs 301 to 400.
-- Orders over Rs 400 never lose money.
-- About 76% of all loss-making orders come from the smallest group.
-- All loss-making orders had a discount.
-- My guess: a small order brings little revenue, but the cost stays about the same.
-- This is a guess, the data cannot prove the cause.

-- ==========================================================
-- 07
-- WHAT: items that earn less profit per order than the overall average
-- WHY: business question 4, which items are weak?
-- The part in brackets is a subquery: it first works out the overall average,
-- then the main query keeps only items below it
SELECT
    Item_Name,
    Cuisine,
    COUNT(*) AS orders,
    ROUND(AVG(Estimated_Profit_INR), 1) AS profit_per_order
FROM orders
WHERE Order_Status = 'Delivered'
GROUP BY Item_Name, Cuisine
HAVING AVG(Estimated_Profit_INR) < (
    SELECT AVG(Estimated_Profit_INR)
    FROM orders
    WHERE Order_Status = 'Delivered'
)
ORDER BY profit_per_order;

-- ============================================================
-- BUSINESS INSIGHT 7: Weak food items
-- About: which items earn less than the average profit per order
-- ============================================================
-- 21 items earn less per order than the average of about Rs 102.
-- The weakest are Veg Burger (Rs 35.4), Idli Sambar (Rs 41.1) and Brownie (Rs 43.1).
-- The weak items are mostly the low priced ones.
-- This matches the restaurant result: cheaper items earn less per order.



-- =========================================================
-- 08
-- WHAT: orders, cancel rate, refund rate and profit for each city
-- WHY: business questions 2 and 5, which cities earn the most, and where do orders fail?
-- rates use all orders, profit uses delivered orders only (CASE WHEN inside SUM)
SELECT
    City,
    COUNT(*) AS all_orders,
    ROUND(AVG(CASE WHEN Order_Status = 'Cancelled' THEN 1 ELSE 0 END) * 100, 2) AS cancel_rate,
    ROUND(AVG(CASE WHEN Order_Status = 'Refunded' THEN 1 ELSE 0 END) * 100, 2) AS refund_rate,
    ROUND(SUM(CASE WHEN Order_Status = 'Delivered' THEN Estimated_Profit_INR END)) AS profit
FROM orders
GROUP BY City
ORDER BY profit DESC;

-- ============================================================
-- BUSINESS INSIGHT 8: City performance
-- About: which cities earn the most, and where orders fail
-- ============================================================
-- Mumbai earns the most profit (Rs 797,738) and Gurugram the least (Rs 764,547).
-- That is a gap of only about 4%.
-- Mumbai leads mainly because it has more orders, not higher profit per order.
-- Cancel rates are between 4.6% (Greater Noida) and 5.3% (Gurugram).
-- Gurugram is highest in cancels and lowest in profit, but the gaps are small.
-- I would not call any city a problem city.