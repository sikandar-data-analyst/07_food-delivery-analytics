# Recommendations

These recommendations come from my analysis of 100,000 orders (Jan 2025 to Aug 2026).
All money numbers use delivered orders only. Profit is an estimate, not real accounting.
I only suggest things the data actually supports. Where the data is not enough, I say so.

## Quick summary

| Priority | What I would do | Why (short) |
|---|---|---|
| High | Stop losing money on small orders | 13% of orders up to Rs 200 lose money |
| High | Review the discount plan | Discounts cost Rs 4.2M and do not make baskets bigger |
| Medium | Look at the low profit restaurants and items | Burger places earn Rs 45 per order, Popeyes earns Rs 152 |
| Medium | Fix the gaps in the data | Customer IDs, promo codes and discount costs are unreliable or missing |
| Low | Keep an eye on rainy day delivery | Rain adds 8 minutes, but customers do not seem to mind |
| None | No action on cities, payment methods or channels | They all look about the same |

---

## 1. Stop losing money on small orders (High)

**What I found**
- 13.0% of delivered orders up to Rs 200 lost money (1,564 of 12,002).
- About 76% of all loss-making orders came from this smallest group.
- Orders over Rs 400 never lost money.
- Every loss-making order had a discount.

**What I would try**
- Test a minimum order value, a small order fee, or no discount on orders under Rs 200.
- Try it in one or two cities for a month and compare with the others.

**What to watch**
- Loss rate on small orders, and the number of small orders (do people stop ordering?).

**Limits**
- Cost is an estimate, so some of these losses may be smaller or bigger in real life.
- I cannot tell from this data how customers would react to a fee.

---

## 2. Review the discount plan (High)

**What I found**
- 57.3% of delivered orders got a discount, Rs 4,217,719 in total.
- That is the same size as 45% of the total estimated profit.
- A discounted order earns about Rs 83 profit. An order without a discount earns Rs 126.
- The basket size is the same with or without a discount (about Rs 473, 1.7 items).
- The three promo codes (SAVE50, FOODIE75, WEEKEND100) all give about Rs 80 off and
  earn about the same, so none of them works better than the others.

**What I would try**
- Run a test where one group of customers gets no discount and compare their order count.
- If three codes do the same thing, keep one and drop the rest.

**Limits**
- I cannot see if a discount brings in orders that would not have happened otherwise.
  Only a test can answer that.
- The data does not say who pays for the discount, the platform or the restaurant.
  The Rs 4.2M is the size of the discount bill, not the money lost.

---

## 3. Look at the low profit restaurants and items (Medium)

**What I found**
- Profit per order goes from Rs 152 (Popeyes) down to Rs 45 (McDonald's).
- The weakest are McDonald's (45), Burger King (46), WOW! Momo (51), Sagar Ratna (51)
  and Chinese Wok (71).
- They get about the same number of orders as the top restaurants, so it is not about volume.
- Items are cheaper there (about Rs 154 average against Rs 378 at Popeyes), while the cost
  per order stays around Rs 60 to 72. So cheap items leave little profit.
- Weakest items: Veg Burger (Rs 35), Idli Sambar (Rs 41) and Brownie (Rs 43).

**What I would try**
- Check the commission or fee terms with these restaurants.
- Push combos and add-ons (a drink, a dessert) to make each order bigger.

**Limits**
- These restaurants may still bring customers who also order elsewhere.
  I cannot see that in this data.

---

## 4. Fix the gaps in the data (Medium)

- **Customer_ID is unreliable.** The same ID shows up with different names, ages and
  cities. Because of this, I could not study repeat customers. This needs fixing first.
- **14,593 orders have a discount but no promo code.** Record the code, or the reason.
- **Add who pays for each discount**, so we can see real profit.
- **Add real costs** instead of estimated ones.
- **Add cancellation and refund reasons.** I can see how many orders failed, not why.
- **Add marketing spend per channel.** Without it I cannot say which channel is worth
  the money.

---

## 5. Keep an eye on rainy day delivery (Low)

**What I found**
- Delivery takes about 45 minutes in rain and heavy rain, against about 37 in other weather.
- But cancellations stay at about 5% in every weather type, and ratings are about 4.36
  whatever the delivery time.

**What I would do**
- Nothing urgent. Maybe show a more honest delivery estimate on rainy days.
- Do not spend a lot of money on this until there is proof customers are affected.

---

## 6. Things I would not change

- **Cities.** The best city (Mumbai) beats the weakest (Gurugram) by only about 4%.
- **Payment methods.** About 8% of orders fail in every method, and the order value is the same.
- **Acquisition channels.** Referral earns about Rs 2 more per order, which is too small
  to act on. Organic brings about half of all orders.
- **Peak hours.** The busiest time is 8 PM and dinner is the busiest meal, but delivery
  time stays at about 39 minutes at all hours, so the current setup seems to cope.

---

## One more thing to think about

Orders have been flat at about 150 a day for 20 months. Since volume is not growing, I would
focus first on making each order more profitable (points 1 to 3) before spending to
get more orders.

## About this analysis

- The data looks generated, not real (for example, cities have almost equal order counts),
  so these results apply to this dataset only.
- Everything here shows patterns, not proof of cause. Where I suggest a test, that is
  how we would find out.
