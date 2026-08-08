# SQL Practice Questions — AWS CUR Billing Dataset

**Tables:**
- `cur_data` — 20 rows of simplified AWS Cost & Usage Report line items
- `accounts` — 6 rows mapping account_id → account_name, team_owner, cost_center
  (Note: account `666666666666` intentionally has ZERO matching rows in `cur_data` — useful for anti-join practice)



---

## Section 1: Basics — SELECT, WHERE, ORDER BY, LIKE, DISTINCT (Easy)

1. Select all columns for line items belonging to product code `EC2`.
2. Find all line items with a cost greater than 100, sorted from highest to lowest cost.
3. Find all distinct `line_item_product_code` values present in the data.
4. Find all line items where `resource_tags_user_team` is `NULL` (untagged spend).
5. Find all line items where the resource ID starts with `i-` (i.e., EC2 instance IDs), using `LIKE`.
6. Find all line items from January 2026 only (use the `line_item_usage_start_date` column).

---

## Section 2: NULL Handling & CASE WHEN (Easy–Medium)

7. Write a query that replaces `NULL` values in `resource_tags_user_team` with the label `'Untagged'`.
8. Count how many rows have a `NULL` team tag vs how many don't.
9. Using `CASE WHEN`, create a new column `cost_category` that labels each row as `'Credit/Refund'` if cost is negative, `'Tax'` if `line_item_line_item_type = 'Tax'`, and `'Usage'` otherwise.
10. Find all rows where `line_item_resource_id` is `NULL` — what does this tell you about which product types tend to lack a specific resource ID?

---

## Section 3: Aggregate Functions & GROUP BY / HAVING (Easy–Medium)

11. Find the total (`SUM`) unblended cost per `line_item_product_code`.
12. Find the average cost per `line_item_line_item_type`.
13. Count how many line items exist per `line_item_usage_account_id`.
14. Find product codes where total cost exceeds 300 (use `HAVING`).
15. Find the total cost per account **per month** (hint: you'll need to extract/truncate the month from the date column).

---

## Section 4: JOINs (Medium)

16. Join `cur_data` with `accounts` to show `account_name` and `team_owner` next to each line item.
17. Find the total cost per `account_name` (joining to get readable names instead of raw account IDs).
18. Find all accounts in the `accounts` table that have **NO** matching rows in `cur_data` (anti-join — hint, there's exactly one).
19. Find the total cost grouped by `cost_center`, using a join between the two tables.
20. Compare `team_owner` (from `accounts`) against `resource_tags_user_team` (from `cur_data`) — find rows where the two DON'T match or the tag is missing (a tagging-compliance style check).

---

## Section 5: Subqueries — Scalar, Correlated, EXISTS (Medium)

21. Find all line items where the cost is above the **overall average cost** (scalar subquery).
22. Find all line items where the cost is above **that specific account's own average cost** (correlated subquery).
23. Using `EXISTS`, find all accounts (from the `accounts` table) that have at least one `RDS` line item.
24. Using `NOT EXISTS`, find all accounts that have never incurred an `EC2` cost.

---

## Section 6: CTEs (Medium)

25. Write a CTE that calculates total cost per account, then filter (in the outer query) to show only accounts with total cost above 300.
26. Write two chained CTEs: first calculate total cost per product code, second rank the product codes by cost and return only the top 2.
27. Using a CTE, calculate each account's total spend in January and total spend in February, then compute the month-over-month change (Feb − Jan) in the final SELECT.

---

## Section 7: Window Functions (Medium–Hard)

28. Using `ROW_NUMBER()`, find the single most expensive line item **per account**.
29. Using `RANK()`, rank all line items by cost (highest = rank 1) — check what happens with tied values.
30. Using `LAG()`, for each account's EC2 usage line items (ordered by date), show the cost of the current line item next to the cost of its previous one.
31. Using `SUM() OVER (...)`, calculate a running total of cost per account, ordered by date.
32. Using `PARTITION BY`, add a column showing each line item's cost as a **percentage of its account's total cost**.

---

## Section 8: ROLLUP / Reporting Style (Medium–Hard)

33. Using `GROUP BY ROLLUP`, produce a report showing cost per account + product code, subtotal per account, and a grand total.
34. Using `CASE WHEN` + `GROUP BY`, produce a summary showing total cost split into `'Usage'`, `'Discount/Savings Plan'`, and `'Tax/Credit'` buckets (based on `line_item_line_item_type`).

---

## Section 9: Views (Medium)

35. Create a `VIEW` called `monthly_account_costs` that shows total cost per account per month (reuse your logic from Q15). Then write a simple `SELECT` against the view.
36. Create a `VIEW` called `untagged_spend` that shows all line items where `resource_tags_user_team` is `NULL`, including the cost. Query the view to find the total untagged spend.

---

## Section 10: Set Operations & Mixed/Harder Challenges (Hard)

37. Find account IDs that had usage in **both** January and February (use `INTERSECT`, or rewrite using a join/EXISTS approach if your DB doesn't support it).
38. Find account IDs that had usage in January but **NOT** in February (use `EXCEPT`, or the anti-join pattern we practiced earlier).
39. Write a query that identifies "cost spikes" — for each account, find line items where the cost is more than double that account's average cost (combine correlated subquery or window function + filtering).
40. Combine everything: write a single query (using CTEs) that produces a final report showing, per account: total cost, % of total cost that is untagged, and the account's rank by total spend — all in one result set.

---

### How to approach these
- Don't jump to Section 10 first — work through in order, since later sections assume comfort with earlier concepts (e.g., Q40 needs CTEs + window functions + CASE WHEN together).
- For each question, try writing it WITHOUT looking back at our earlier conversation first — that's the actual practice. Then compare against the patterns we've covered.
- Send me your queries as you go and I'll check them, same as before.
