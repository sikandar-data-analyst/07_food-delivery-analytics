# Business Insights

I looked at 100,000 food delivery orders from Jan 2025 to Aug 2026, using Python, SQL and Power BI.
Money numbers use delivered orders only, as I decided at the start. All profit numbers are
estimates, not real accounting.

## The numbers in short

- 100,000 orders, and 91,976 were delivered (92.0%)
- 4,927 orders were cancelled and 3,097 were refunded
- Platform revenue: Rs 15,625,814
- Estimated profit: Rs 9,367,045
- Average order value: Rs 514.1
- I left out about Rs 1.36M of platform revenue that is recorded on the 8,024 cancelled
  and refunded orders, because those orders were not completed.

## What stood out

1. Small orders lose money, and almost all losses come from them.
2. Discounts cut profit per order, and do not make baskets bigger.
3. Restaurants earn very different profit per order, mostly because of item price.
4. Rain slows deliveries by about 8 minutes, but customers do not seem to react.
5. Orders are flat, with no growth over 20 months.
6. Cities, channels, payment methods and meal periods all look about the same.
7. The data has gaps, mainly the customer columns.

---

## Insight 1: Small orders are where the business loses money

**What happened?**
2,070 delivered orders had negative estimated profit.

**What does the data show?**
- 13.0% of orders up to Rs 200 lost money (1,564 of 12,002).
- 2.1% of orders from Rs 201 to 300 lost money.
- 0.1% of orders from Rs 301 to 400 lost money.
- Orders over Rs 400 never lost money.
- About 76% of all loss-making orders came from the smallest group.
- Every loss-making order had a discount. Orders without a discount never lost money.

**Why might it be happening?**
My guess is that a small order brings in little revenue, but the cost of the order stays
about the same. A discount then pushes the profit below zero.

**What supports this?**
Across all orders, the loss-making ones had a much smaller basket (about Rs 180 against
Rs 480) and a higher cost (about Rs 94 against Rs 67).

**What could the business do?**
Look at a minimum order value, a small order fee, or fewer discounts on small orders.

**Limits**
Cost is an estimate. The data does not say who pays for a discount. This shows a pattern,
not proof of the cause.

---

## Insight 2: Discounts cut profit and do not make baskets bigger

**What happened?**
More than half of the delivered orders got a discount.

**What does the data show?**
- 57.3% of delivered orders had a discount, Rs 4,217,719 in total. That is the same size
  as 45% of the estimated profit.
- An order without a discount earns Rs 126.5 profit. An order with a discount earns
  about Rs 83.
- About 4% of discounted orders lose money, and none of the full price orders do.
- The basket is the same size in all groups: about Rs 473 and 1.7 items before the discount.
- The three promo codes (SAVE50, FOODIE75, WEEKEND100) each give about Rs 80 off and earn
  about Rs 83 per order. None is better than the others.
- 14,593 orders have a discount but no promo code. They look just like the promo code orders.

**Why might it be happening?**
The discount comes straight off the price, and the cost of the order does not change.
So profit per order goes down.

**What supports this?**
The basket value before the discount is the same with and without a promo. So the discount
is not pulling in bigger orders.

**What could the business do?**
Test a group with no discount and compare order counts. Keep one promo code instead of three.

**Limits**
I cannot see if a discount brings in orders that would not have happened anyway. Only a test can
show that. The Rs 4.2M is the size of the discount bill, not money lost, because I do not know
if the platform or the restaurant pays for it.

---

## Insight 3: Restaurants earn very different profit per order

**What happened?**
Some restaurants earn three times more per order than others.

**What does the data show?**
- Profit per order: Popeyes Rs 152, KFC Rs 148, Bakingo Rs 140. The lowest are McDonald's
  Rs 45, Burger King Rs 46, WOW! Momo Rs 51, Sagar Ratna Rs 51 and Chinese Wok Rs 71.
- Total profit: Popeyes Rs 477,580 against McDonald's Rs 142,796.
- Every restaurant gets about 3,100 to 3,300 delivered orders, so it is not about volume.
- By cuisine, chicken (about Rs 150), bakery (138) and biryani (135) earn the most. Burgers
  (46), momos (51) and South Indian (51) earn the least.
- Weakest items: Veg Burger Rs 35, Idli Sambar Rs 41, Brownie Rs 43. Strongest: Chocolate Cake
  Rs 235 and Chicken Bucket Rs 209.

**Why might it be happening?**
Revenue per order grows with the price of the item, but the cost per order stays about the same.

**What supports this?**
The top restaurants average about Rs 350 to 378 per item, and the bottom ones about Rs 154
to 164. Revenue per order is about Rs 210 against Rs 117, while cost is Rs 60 to 62 against
about Rs 72. Discounts are not the reason: the bottom restaurants actually give smaller discounts.

**What could the business do?**
Look at the fee terms with low profit restaurants, and push combos and add-ons.

**Limits**
Cost is an estimate. Cheap restaurants may bring customers who order elsewhere too.

---

## Insight 4: Rain slows delivery, but customers do not seem to mind

**What happened?**
Deliveries take longer when it rains.

**What does the data show?**
- Average delivery time is about 45 minutes in rain and heavy rain, and about 37 minutes in
  clear, cloudy and hot weather. That is about 8 minutes more.
- Cancellations stay between 4.7% and 5.4% in every weather type.
- The average rating is about 4.36 whether delivery took under 30 minutes or over 60.

**Why might it be happening?**
Rain probably slows riders down. The data does not show why.

**What supports this?**
The gap shows only in rain and heavy rain, and it is the same size for both.

**What could the business do?**
Nothing urgent. Maybe show a more honest delivery estimate on rainy days.

**Limits**
Ratings exist for only 82% of delivered orders. I expected slow deliveries to get lower ratings,
and that did not show up. In real data I would expect some link, so this may be because
the data is generated.

---

## Insight 5: Orders are flat, with no growth

**What happened?**
The number of orders did not grow in 20 months.

**What does the data show?**
- Delivered orders stay between 4,173 and 4,750 a month.
- Per day, it is about 150 (lowest 148.7, highest 156.5).
- February looks low (profit fell 9.5% in Feb 2025 and 8.9% in Feb 2026), then jumps back in
  March (up 9.5% in 2025 and 11.1% in 2026).
- August 2026 is down 7.6% on July, and its data stops on 30 August.

**Why might it be happening?**
The February dips are just a shorter month. Per day, February is normal.

**What supports this?**
Orders per day for February were 149.0 and 156.2, which is in line with the other months.

**What could the business do?**
Since volume is flat, focus on profit per order before spending to get more orders.

**Limits**
I do not have marketing spend or new customer data I can trust, so I cannot say why there is
no growth.

---

## Insight 6: Cities, channels, payment methods and meal periods are all similar

**What happened?**
I looked for a clear winner and loser in each group, and did not find one.

**What does the data show?**
- **Cities:** Mumbai earns the most (Rs 797,738) and Gurugram the least (Rs 764,547), a gap of
  about 4%. Profit per order is Rs 100 to 103 everywhere. Cancel rates are 4.6% to 5.3%.
- **Channels:** Organic brings about half of the orders (48,105). Referral earns the most per
  order (Rs 103.4) but also has the highest cancel rate (5.35%). The gap between channels is
  about Rs 2 per order.
- **Payment methods:** about 8% of orders fail in each method (7.77% for UPI to 8.23% for
  wallet). Order value is about Rs 513 for all.
- **Meal periods:** dinner is the busiest (37,093 orders), and 8 PM is the busiest hour
  (9,171 orders). Profit per order (about Rs 101 to 103) and delivery time (about 39 minutes)
  are the same in all periods.

**Why might it be happening?**
The differences are small. Some of it may just be chance, and the data looks generated.

**What could the business do?**
No action from this data. I would not change anything because of these gaps.

**Limits**
Mumbai leads mostly because it has more orders, not because it earns more per order.

---

## Insight 7: The data has gaps

**What happened?**
Some columns cannot be trusted, and some useful information is missing.

**What does the data show?**
- **Customer_ID is unreliable.** 25,375 of 28,915 IDs show more than one name, age or city.
  There are only 320 different names in the whole file. So I did not study repeat customers.
- **New_Customer is inconsistent.** 3,066 customer IDs are marked as new on more than one order.
- Cancelled and refunded orders still carry full revenue and profit numbers.
- 14,593 orders have a discount but no promo code.
- 24,629 orders have no rating (all cancelled and refunded orders, and 18% of delivered ones).

**What is missing?**
Real costs, who pays for discounts, refund amounts, cancellation reasons and marketing spend.

**Limits**
- The data looks generated (for example, cities have nearly equal order counts), so what I
  found describes this dataset only.
- Everything here shows patterns, not proven causes.
