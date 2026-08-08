# Skroutz Visibility Factors — Audit Checklist

> **Note:** Skroutz does not publish its ranking algorithm. This is an audit checklist of **observable levers** — things you can check on the live site, seller panel, or Skroutz help docs — not a table of confirmed ranking weights. Items tagged **[VERIFY]** lack primary-source (Skroutz / help.skroutz.gr / seller-panel) confirmation. Confirm current terms before giving clients specific figures or policy claims.
>
> Context snapshot: 2026-08-08. Marketplace fees, delivery infrastructure, and returns rules change — re-verify dated items before reuse.

Use alongside the Google SERP workflow — see [SKILL.md](../SKILL.md), section "Greek Comparison-Shopping Surfaces (Skroutz, BestPrice, Google Shopping)," for when to trigger this audit and how to report findings.

---

## Quick-Reference Summary

| # | Factor | Primary Check | Confirmation Status |
|---|--------|---------------|---------------------|
| 1 | Category/Taxonomy Placement | Correct category + complete filter attributes | Placement observable on-site; ranking-effect magnitude [VERIFY] |
| 2 | Price Competitiveness | Rank vs. identical-SKU listings, not category average | Price-sort mechanics observable; relevance-sort weight [VERIFY] |
| 3 | Delivery-Speed Expectations | Locker/speed badges accurate vs. competing listings | Badge display observable; ranking effect [VERIFY] |
| 4 | Trusted Reviews Standing | Volume, recency, seller response rate vs. category | Program confirmed to exist; ranking weight [VERIFY] |
| 5 | Returns-Policy Compliance | Returns window/process meets current marketplace rules | [VERIFY] — 2026 rule tightening reportedly in effect |
| 6 | Marketplace Fee Context | Fee model as input to price competitiveness, not a ranking lever itself | Fee existence reported; current schedule/scope [VERIFY] |
| 7 | Shop Rating & Fulfillment SLA | Shop-level rating + SLA adherence vs. category competitors | Rating observable; exact SLA thresholds [VERIFY] |

---

## 1. Category & Taxonomy Placement

- [ ] Product listed in the correct Skroutz category/subcategory — not just the merchant's internal category
- [ ] Breadcrumb path matches Skroutz's own taxonomy tree, not the merchant site's taxonomy
- [ ] All applicable filter/facet attributes populated (brand, size, color, material, capacity, etc.) — incomplete attributes drop a listing out of filtered searches
- [ ] Product title and spec fields match how shoppers actually filter the category (check the category's "compare products" attribute table)
- **[VERIFY]** Exact visibility impact of misfiling or attribute gaps — direction is well understood (incomplete data = fewer eligible searches), magnitude is not published

## 2. Price Competitiveness

- [ ] Price benchmarked against same-product (identical SKU/barcode/model) listings, not general category average
- [ ] Price basis (incl./excl. shipping) matches how competing listings present price — mismatched basis skews perceived competitiveness
- [ ] Position checked specifically within default/"value" sort, not only within manual "price: low to high" sort
- [ ] Price-change frequency reviewed — stable pricing vs. frequent swings
- **[VERIFY]** Whether price rank influences Skroutz's default/relevance sort beyond the explicit price-sort views — not confirmed by Skroutz

## 3. Delivery-Speed Expectations

- [ ] Locker/delivery options listed accurately (BoxNow, ACS, ELTA Courier, home delivery) and match real fulfillment capability
- [ ] Speed/availability badges present and accurate ("άμεσα διαθέσιμο" / express-delivery indicators)
- [ ] Stated delivery time cross-checked against actual fulfillment history — mismatches risk shop-rating damage, which does feed buyer trust
- Locker network context: BoxNow reportedly targeting ~300k lockers by end-2026 (reported 12 Jul 2026) — locker access is trending from "nice to have" toward a default buyer expectation, and speed badges feed buyer trust accordingly
- **[VERIFY]** BoxNow's 300k-locker target against current BoxNow/Skroutz communications before citing a specific number to a client — infrastructure targets shift
- **[VERIFY]** Whether delivery-speed badges function as a Skroutz ranking input, or purely a buyer-facing trust/conversion signal — not confirmed either way

## 4. Trusted Reviews Standing

- [ ] Review volume vs. category-comparable competing shops
- [ ] Review recency — active recent flow vs. a stale/dormant review base
- [ ] Seller response rate and response time, especially on negative reviews
- [ ] Overall Trusted Reviews score vs. category median
- **[VERIFY]** Exact weight, if any, Trusted Reviews standing carries in Skroutz's shop/listing ranking — the program is confirmed to exist and gates "Trusted Shop" status; its ranking-algorithm weight is not published

## 5. Returns-Policy Compliance

- [ ] Published returns window meets or exceeds the current Skroutz marketplace minimum
- [ ] Returns process (cost, method, timeline) benchmarked against top-of-category sellers
- [ ] Returns-policy text on the merchant site matches what's declared in the Skroutz seller panel — mismatches are a compliance red flag, not just an SEO one
- **[VERIFY]** Tightened 2026 returns rules reportedly affect seller trust standing — confirm current help.skroutz.gr policy before client advice

## 6. Marketplace Fee Context

- [ ] Fee model treated as a competitive-cost input feeding price competitiveness (Section 2), not as a direct ranking factor
- Skoop per-order fee reported in effect since 01 Dec 2025 — primarily affects casual/individual-seller pricing headroom; largely does not apply to professional/B2B Skroutz listings
- [ ] Fee delta vs. competing sellers' cost structure factored into the price-competitiveness audit (Section 2) where relevant
- **[VERIFY]** Current Skoop fee amount, thresholds, and seller-tier scope — fee schedules change; confirm against current Skroutz/Skoop terms before quoting a figure to a client

## 7. Shop Rating & Fulfillment SLA

- [ ] Shop-level rating (distinct from per-product Trusted Reviews) benchmarked vs. category competitors
- [ ] Order-cancellation rate and stock-accuracy rate reviewed
- [ ] On-time dispatch rate vs. the seller's own stated processing time
- [ ] Account standing checked for active penalties, warnings, or suspensions
- **[VERIFY]** Exact SLA thresholds Skroutz enforces (cancellation-rate caps, stock-accuracy minimums, dispatch-time limits) — not publicly detailed; confirm via current seller-panel guidance

---

## Using This Checklist

1. Run all 7 sections per product line / client under audit.
2. Treat **[VERIFY]** items as open questions, not audit failures — resolve against current help.skroutz.gr or Skroutz seller-panel documentation before making client-facing claims, especially on figures (fees, locker counts, SLA thresholds) and policy terms (returns rules).
3. Report findings in the same output structure as the Google SERP analysis, but as a clearly separated "Skroutz Visibility" section — Google and Skroutz are different, independently unpublished algorithms. Do not merge their ranking-factor lists or imply one explains the other.
4. Re-verify all dated items (locker counts, fee schedules, policy terms) periodically — this is a fast-moving market.

---

## Related

- [SKILL.md](../SKILL.md) — main SERP analysis workflow; see "Greek Comparison-Shopping Surfaces (Skroutz, BestPrice, Google Shopping)"
- [SERP Feature Taxonomy](./serp-feature-taxonomy.md) — Google SERP feature reference, for contrast with Skroutz's non-Google surface
