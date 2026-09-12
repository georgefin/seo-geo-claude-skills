# Greek Tourism & Seasonality — SERP Analysis Module

> **Note:** This is an audit module of **observable levers and measurement instructions** for Greek tourism/accommodation SERP work — not a table of confirmed ranking weights, and not a description of an assumed SERP layout. Hotel SERP features in the EU are in flux under DMA compliance: capture the live SERP on every audit; never assume a layout. Items tagged **[VERIFY]** lack engine-primary confirmation. Every magnitude here carries its source and date — a number without a source in this file does not exist.
>
> Context snapshot: 2026-08-08. DMA-driven SERP changes and tourism-market figures move — re-verify dated items before client reuse.

Use alongside the Google SERP workflow — see [SKILL.md](../SKILL.md), section "Greek Tourism Vertical (Seasonality & Hotel SERPs)," for trigger conditions.

---

## 1. Why Tourism Dominates Greek Commercial Search

Market context — sourced to INSETE (the research institute of the Greek tourism confederation), treated as solid:

- Direct travel & tourism contribution: **€32.4B**, **13% of Greek GDP** (2025 figures as reported by GTP Headlines 2026-05-27 from INSETE statistics; INSETE's published report edition of 2025-06 covers 2023–2024, so the 2025 actuals are secondary-reported until the primary 2025 edition is checked)
- Total contribution including indirect effects: **28.7–34.6% of GDP** (same GTP-reported INSETE sourcing, 2025 figures)

Implication for SERP work: accommodation, destination, and activity queries are a structurally large commercial battleground in Greek search — expect OTA-grade competition on head terms and plan difficulty assessments accordingly. Do **not** convert these GDP figures into search-volume or SERP-share claims: demand is measured per keyword set (Section 4), never inferred from macro figures.

## 2. Hotel / Accommodation SERP Surfaces Under DMA Flux

What is known (engine-primary): Google's DMA compliance changes affect EU hotel search features, and Google has tested removing hotel SERP features in the EU (Google blog, DMA compliance update, 2024-11). Net effect for audits: **hotel-SERP layout in Greece is unstable — evidence-first, capture per audit, assume nothing.**

- **[VERIFY]** Free-booking-link clicks reportedly down ~30% under DMA-driven changes — vendor-reported figure (collected 2026-08-08), not engine-primary. Directional at best; never quote to a client unverified.

Per-audit checklist — record what IS on the live SERP, not what "should" be there:

- [ ] Hotel unit present? (map + property-list module) — record presence/absence, position, and shape (property count, filters, date-picker)
- [ ] Free booking links present on property panels? Record presence/absence per query — do not assume either state
- [ ] Which OTAs hold top organic slots — record the actual domains per query (e.g., Booking-group, Expedia-group, Airbnb properties); do not assume the lineup
- [ ] Direct hotel/property sites in the top 10? Count them — this measures direct-vs-OTA headroom for the query
- [ ] Paid/comparison modules present (hotel ads, price-comparison units)? Record shape and occupants
- [ ] Repeat per device (mobile/desktop) and per market-language pull (Section 5) — DMA-era features can differ by market

Every hotel-SERP observation must carry capture date, location setting, and language — an undated hotel-SERP snapshot is unusable in this flux period.

## 3. Review Platforms as Parallel Visibility Channels

TripAdvisor and Booking.com review surfaces function as parallel visibility channels for Greek accommodation and activity businesses — a traveler can find, evaluate, and book without touching the client's site. Audit them as separate surfaces alongside Google, in the same discipline as the Skroutz second-SERP pattern (see [skroutz-visibility-factors.md](./skroutz-visibility-factors.md) for the reporting structure): algorithms unpublished, levers observable.

- [ ] Profile ownership/claim status on TripAdvisor and Booking.com
- [ ] Review volume and recency vs. same-destination, same-class competitors
- [ ] Management response rate and response time, especially on negative reviews
- [ ] Position within each platform's own destination list pages for the client's destination + class — observable by browsing; ranking mechanics unpublished
- [ ] Does the platform profile outrank the client's own site on brand-name queries? Record it and feed it into the brand-SERP strategy

No magnitude claims in this section by design: platform ranking weights are unpublished. Observable levers only.

## 4. Seasonal Demand Calendar — Measure, Don't Assume

Greek tourism demand is seasonal, but **month patterns differ by destination, origin market, and product** — do not assert a month curve as fact in any report. Build each calendar from data:

1. Define the destination keyword set (destination + accommodation + activity terms), per language set from Section 5.
2. Pull per-month search volumes for 24+ months per keyword (~~SEO tool; or Google Trends manually if no tool is connected — note its relative-index caveat in the report).
3. Mark measured peak, shoulder, and trough months per keyword cluster and per language.
4. Measure the lead time: how far ahead of the measured stay-season does search demand ramp? Time content publication and refresh from the measured ramp, not an assumed booking window.
5. Note movable dates (e.g., Orthodox Easter shifts year to year) when comparing months year-over-year.
6. Re-pull annually — seasonality curves drift.

Output: a per-destination demand calendar (month × keyword cluster × language) with data source and pull date on every row. A calendar row without a source and date is an assumption, not a finding.

**The rule binds sentences, not just calendar rows.** No month is characterised as peak, shoulder or trough **anywhere in the deliverable** unless it is framed as an assumption still to be measured — not in a heading, not in a caption, and above all not in an aside about the capture window. The shape that gets past this rule is a month named in passing to **discount your own data**: *"the pull was taken in [month], which is peak season, so even the competitive picture is a peak-season one."* It is one month, in an aside, argued **against** your own capture rather than sold to the client as a plan, so it does not feel like a seasonality finding. It is one, and the same sentence lands in the report a month later as a fact nobody measured. Write the observable instead — *"the pull was taken on [date]; whether that month is a demand peak for this destination and origin market is unmeasured here, and a pull from another month could show a different competitive set"* — which makes the identical argument about representativeness and asserts nothing about the curve. Common knowledge is not an exemption: if the month were measured you would have the row, and if you have the row you cite it.

## 5. Inbound-Language Split (EL / EN / DE / measured)

Greek tourism queries split across domestic (EL) and inbound-market languages. Treat them as **separate SERPs**: separate keyword sets, separate SERP pulls, separate difficulty scores.

- [ ] Build at minimum three keyword sets per destination: **EL** (domestic), **EN**, **DE** — the library's standing multi-language example set. Add or reprioritize languages from the client's own measured inbound mix (bookings/arrivals data, ~~analytics); do not assume any origin-market ranking.
- [ ] Pull SERPs per market-language pair, with location + language settings recorded per pull: el-GR from Greece; each inbound language from its origin market.
- [ ] Compare SERP composition across pulls — features and competitors can differ per market; record differences, do not assume parity.
- [ ] hreflang: multi-language destination pages must pass the 6-point hreflang checklist in [meta-tags-optimizer](../../../build/meta-tags-optimizer/SKILL.md) ("Hreflang Checklist (Multi-Language Pages)" — includes an EL/EN/DE example block); confirm implementation via [technical-seo-checker](../../../optimize/technical-seo-checker/SKILL.md) (International SEO check).
- Translation quality: an unverified, watch-listed industry claim says translation-only pages lose AI-engine citations to the strongest-language version — treat thin EL/DE translations as a directional risk, not established fact (the tagged claim lives in [seo-content-writer](../../../build/seo-content-writer/SKILL.md)).

## Using This Module

1. Trigger per [SKILL.md](../SKILL.md) — target market Greece + tourism/accommodation vertical.
2. Run Sections 2–5 per destination/property under audit; every SERP observation carries capture date, device, location, and language.
3. Treat **[VERIFY]** items as open questions, not findings — resolve against engine-primary sources before any client-facing claim.
4. Report as a clearly separated "Tourism Vertical" section alongside the standard Google SERP analysis; review-platform findings (Section 3) get their own sub-section — platform algorithms are separate and unpublished, do not merge factor lists.

## Related

- [SKILL.md](../SKILL.md) — main SERP analysis workflow and trigger conditions
- [serp-feature-taxonomy.md](./serp-feature-taxonomy.md) — Google feature reference; see its "Greece (el-GR) availability" annotations
- [greek-shopping-surfaces.md](./greek-shopping-surfaces.md) — companion Greek-market module (e-commerce surfaces)
- [keyword-research](../../keyword-research/SKILL.md) — building the destination keyword sets
