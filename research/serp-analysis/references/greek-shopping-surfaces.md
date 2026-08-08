# Greek Comparison-Shopping Surfaces Beyond Skroutz

> **Note:** Companion to [skroutz-visibility-factors.md](./skroutz-visibility-factors.md) — that file owns the Skroutz checklist and stays authoritative for it; this file covers the rest of the Greek comparison-shopping landscape and does not duplicate it. Same discipline: **observable levers**, not confirmed ranking weights — none of these surfaces publish their algorithms. Items tagged **[VERIFY]** lack primary-source confirmation. Every magnitude here carries its source and date — a number without a source in this file does not exist.
>
> Context snapshot: 2026-08-08. Vendor traffic figures and program availability change — re-verify dated items before client reuse.

---

## Surface Map

| Surface | Type | Status / magnitude | Checklist |
|---|---|---|---|
| **Skroutz.gr** | Comparison + marketplace | ~40.8M visits/mo (vendor data — see [VERIFY] bullet below) | [skroutz-visibility-factors.md](./skroutz-visibility-factors.md) — not re-derived here |
| **BestPrice.gr** | Price comparison | ~6.9M visits/mo; listed #1 in SimilarWeb's Greek price-comparison category (same vendor snapshot) | Section 1 below |
| **Google Shopping tab + free listings** | Engine surface | Live/supported for Greece — engine-primary (Google Merchant Center Help) | Section 2 below |

- **[VERIFY]** SimilarWeb magnitudes: BestPrice.gr ~6.9M visits/month and the #1 slot in SimilarWeb's Greek **price-comparison category** listing; Skroutz.gr ~40.8M visits/month (SimilarWeb, Apr/Jun 2026 snapshots — vendor-measured traffic estimates, not audited figures). Category quirk: "#1" is a category-listing label — on the same vendor's numbers Skroutz's traffic is roughly 6× larger; Skroutz is simply not listed in that SimilarWeb category. Do not tell a client BestPrice out-trafficks Skroutz.

Reading for audits: Skroutz remains the primary non-Google surface for Greek e-commerce; BestPrice.gr is a second comparison surface worth a presence-and-quality check; the Google Shopping tab with free listings is a zero-cost engine surface gated only by a Merchant Center feed.

## 1. BestPrice.gr — Audit Checklist

BestPrice does not publish its ranking algorithm. These are check-and-verify items observable on the live site and merchant tooling — presence/quality checks, not confirmed weights:

- [ ] **Feed presence** — is the merchant listed on BestPrice at all? Which product lines have live listings vs. gaps?
- [ ] **Category coverage** — the client's categories exist and are populated in BestPrice's taxonomy; listings sit in the correct category with filter attributes populated (same failure mode as Skroutz checklist §1: incomplete data = fewer eligible filtered searches — direction observable, magnitude unpublished)
- [ ] **Price competitiveness** — benchmarked vs. identical-SKU listings on BestPrice, on the same price basis (incl./excl. shipping) as competing listings; reuse the identical-SKU benchmark data collected for the Skroutz audit (§2 there) — same products, second surface
- [ ] **Merchant reviews** — volume, recency, and score vs. category-comparable merchants on BestPrice; seller response practice on negatives
- [ ] **Presence in Google SERPs** — does BestPrice itself rank in Google's top 10 for the client's commercial queries? If yes, a BestPrice listing is indirect Google visibility; record which comparison site holds which slot per query
- **[VERIFY]** Any ranking-effect magnitude on BestPrice — nothing is published; treat every lever above as an observable check, never a weight, until BestPrice-primary documentation says otherwise.

## 2. Google Shopping Tab + Free Listings (Greece)

Status (engine-primary): free product listings via Google Merchant Center are live/supported for Greece — Google Merchant Center Help; Greece appears in the shipping-attribute-required country list (checked 2026-08-08). This makes the Shopping tab a **zero-cost surface** for Greek merchants: the gate is a Merchant Center account and product feed, not ad spend.

- [ ] Merchant Center account + product feed live? (no feed = invisible on this surface, regardless of site SEO)
- [ ] Feed completeness/health: titles with key attributes, identifiers (GTIN/barcode), availability, and shipping data (required for Greece)
- [ ] Price accuracy feed-vs-landing-page — mismatches cause disapproval
- [ ] Product structured data on landing pages consistent with the feed — one accurate primary type per page, per the library's schema rules; do not stack types
- [ ] Shopping-tab presence spot-checked from a Greek location for the client's head commercial queries — record what actually appears
- General Shopping optimization playbook: [serp-feature-taxonomy.md](./serp-feature-taxonomy.md) §8 — this file adds only the Greece-specific status and checks.

## 3. Greek Review-Platform Landscape (Indicator Only)

- **[VERIFY]** e-satisfaction.com (Greek review platform) claims **100+ Greek e-shops** as review clients — self-published claim (collected 2026-08-08). Usable only as a labeled indicator that a domestic review-platform layer exists alongside Skroutz/BestPrice merchant reviews — not as a reach or market-share figure.
- [ ] Check whether the client and top competitors surface domestic review-platform widgets/scores (e-satisfaction or similar) — record which platforms appear where; never infer a platform's reach from its own marketing.

## 4. Interaction with the Skroutz Module

1. **The Skroutz checklist stays authoritative** — run [skroutz-visibility-factors.md](./skroutz-visibility-factors.md) unchanged; nothing in this file overrides it.
2. **Share data collection** — the identical-SKU price benchmark and category-mapping work done for the Skroutz audit feeds the BestPrice checks directly (same SKUs, second surface): collect once, audit per surface.
3. **Report per surface, separately** — Google organic, Google Shopping, Skroutz, and BestPrice are separately governed surfaces with independent, unpublished algorithms. Separate report sections; never merge factor lists (same rule as the Skroutz file's "Using This Checklist").
4. **Effort ordering under time constraints** — Google organic + Skroutz first (the established primary surfaces), then the zero-cost Merchant Center feed check, then the BestPrice presence check. This is an effort-ordering heuristic, not a traffic-share claim.

## Using This Checklist

1. Run for Greek e-commerce audits alongside the Skroutz module — trigger conditions in [SKILL.md](../SKILL.md), section "Greek Comparison-Shopping Surfaces (Skroutz, BestPrice, Google Shopping)".
2. Treat **[VERIFY]** items as open questions, not findings — resolve vendor figures against current primary sources before any client-facing claim.
3. Re-verify dated items (traffic snapshots, program availability, country lists) before reuse — vendor data drifts.

## Related

- [SKILL.md](../SKILL.md) — trigger conditions and reporting structure
- [skroutz-visibility-factors.md](./skroutz-visibility-factors.md) — the Skroutz checklist (authoritative, unmodified)
- [serp-feature-taxonomy.md](./serp-feature-taxonomy.md) — §8 Shopping Results playbook + "Greece (el-GR) availability" annotations
- [greek-tourism-seasonality.md](./greek-tourism-seasonality.md) — companion Greek-market module (tourism vertical)
