# Matched-pair analysis — NOBO/ATLANTIC pilot, 2026-08-11

**Headline: three genuine pairs do not exist in this cluster. Two do.** No third was
manufactured. This file states the pool, the two pairs, what cannot currently be certified about
them, and what each widening option costs — so the choice between *widen* and *accept a
directional result* is Sani's, made on stated costs.

## 0. The design constraint, restated because it governs everything below

Matched-pair is not the better design here; it is the **only** one that can produce a trustworthy
result this season. Oct–Mar carries ~91% of demand, so a before/after comparison would measure the
seasonal ramp and hand back a confident wrong answer. That reasoning **only holds while both arms
share one demand curve.** Every widening option below is therefore scored primarily on
seasonality, and only then on page type and size — pairing across different seasonality re-imports
the exact confound the design exists to remove.

**The treatment is the full optimisation pass** — content, meta, schema, internal links and Greek
review, applied together. It is not a single-variable test, so pages pair on **baseline
comparability**, never on the intervention. (An earlier draft paired on θερμοπομπ\* form; that was
diagnostic inventory, not the thing under test. The word-count pairing it produced happens to be
right; the reasoning is replaced.)

## 1. The eligible pool: 4 pages

From 17 crawled surfaces (`crawl-2026-08-11-macstudio.md`), after the exclusions Sani upheld:

| ProductId | Page | Brand | Words | Schema |
|---|---|---|---|---|
| 965528 | Atlantic F120 WiFi Connect | ATLANTIC | 1542 | Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject, FAQPage, AggregateOffer |
| 823327 | Nobo NTL4T | NOBO | 1323 | Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject |
| 823277 | Atlantic F119 DESIGN CE | ATLANTIC | 1192 | + FAQPage, AggregateOffer |
| 823322 | Nobo NTL2N | NOBO | 707 | Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject |

**Excluded, with the reason:**

| Excluded | n | Why |
|---|---|---|
| Nobo NTL4R WiFi (965262) | 1 | Carries three defects (C1 slug collision, C2 emoji in live meta, over-length meta). Stays out of **both** arms and is fixed separately — a page with known defects contaminates whichever arm it lands in. |
| Accessories | 8 | 148–387 words. Cannot carry a full optimisation pass; the treatment would be a rewrite, not an optimisation. |
| Atlantic RSS 2012 towel rail (891227) | 1 | 472 words, and a different product category and query cluster — same template, not the same page. |
| Category pages | 2 | n=1 each, structurally unique. A category page has no comparable sibling in this cluster. |
| Blog post (18567) | 1 | n=1, unique. |

**4 pages → 2 pairs. The protocol floor is 3.**

## 2. The two pairs

| Pair | Treatment candidate | Control candidate | Δ words | Note |
|---|---|---|---|---|
| **1** | Atlantic F120 WiFi Connect (1542) | Nobo NTL4T (1323) | 219 | Both top-of-range, both carry the fullest schema set in the cluster |
| **2** | Atlantic F119 DESIGN CE (1192) | Nobo NTL2N (707) | 485 | Δ is large; see the caveat |

Both pairs are **cross-brand by construction**, which is a virtue: it balances brand across arms
instead of confounding brand with treatment. Whichever arm each page is assigned to, neither arm
is all-NOBO or all-ATLANTIC.

**Pair 2's Δ of 485 words is the weakest link.** 707 vs 1192 is a 69% difference in body length;
these are not obviously "similar word count". If only one pair can be run well, **pair 1 is the
sound one.**

### 2a. What cannot currently be certified — the binding gap

Sani's criteria are page type, **current traffic**, **current rankings**, and word count.

- Page type ✅ measured
- Word count ✅ measured
- Current traffic ❌ **not measured**
- Current rankings ❌ **not measured**

**No GSC data was pulled.** Two of four comparability axes are unmeasured, so even the two pairs
above are **provisional**. A GSC baseline pull (clicks, impressions, average position, per URL,
matched window) is a prerequisite before any pairing is final — not a refinement afterwards.
Access exists: the service account was re-verified 2026-07-30 and returned 8 properties.

⚠️ **Filter the pull against `SEO-GEO/_timeseries/peec-prompt-exclusions.txt`** (match prompt AND
zero clicks) or Peec's own probes will inflate the baseline of whichever pages it happens to have
probed — which would bias the pairing in an unknown direction.

## 3. Widening options, costed

Ranked by what each costs in comparability. **Recommendation: Tier 2.**

### Tier 1 — θέρμανση λουτρού / towel rails · 8 pages
- **Gains**: same demand curve (heating, Oct–Mar), same broad tree, no seasonality cost.
- **Costs**: 148–472 words — only 891227 (472w) approaches the pool's floor of 707, and even that
  is 33% below it. Also crosses into **Tonon**, outside the NOBO/ATLANTIC cluster rule.
- **Yield**: ~1 marginal pair, and a weak one.
- **Verdict**: cheapest on seasonality, **fails on size**. Does not reliably reach three.

### Tier 2 — αφυγραντήρες · 13 product pages (10 συμπιεστής + 3 ζεόλιθος) ✅ **RECOMMENDED**
- **Gains**: the deepest pool available; **31.4% of turnover**, the single largest category; shares
  the Oct–Mar concentration that makes matched-pair necessary, so **no seasonality cost**. Deep
  enough to match on word count *and*, once GSC is pulled, on traffic — the first option where the
  unmeasured axes can actually be satisfied rather than hoped for.
- **Costs**: leaves the NOBO/ATLANTIC cluster, so brand is no longer balanced by construction and
  must be balanced deliberately. Requires Sani to widen the cluster rule.
- **Yield**: 3+ pairs plausible **within** dehumidifiers alone.
- **Two shapes to choose between**:
  - **2a — mixed**: 2 heater pairs + 1 dehumidifier pair. Keeps the heater cluster central; the
    third pair sits in a different category, so cross-pair aggregation is weaker.
  - **2b — clean (preferred)**: all 3 pairs drawn from dehumidifiers, where the pool supports
    matching on both measured and unmeasured axes. Costs the heater cluster entirely, but is the
    only option that reaches three *genuine* pairs rather than three *available* ones.
- ⚠️ Exclude the Qualis Pro line from either shape — [kullhaus-qualis-pro-phaseout]: the line is
  being discontinued, so a treatment effect there is unactionable.

### Tier 3 — κλιματιστικά · 43 pages ❌ **DO NOT USE**
- **Gains**: by far the largest pool.
- **Costs**: **inverse seasonality.** Cooling peaks in summer; heating peaks Oct–Mar. Pairing a
  heater against an AC re-imports precisely the confound matched-pair exists to remove, and does
  so invisibly — the pairs would look well-matched on every measured axis.
- **Verdict**: disqualified on the design constraint, not on availability.

## 4. The decision in front of Sani

The finding underneath all of this: **the NOBO/ATLANTIC cluster is too small for the three-pair
floor.** One of the two parameters has to give.

| Option | What it costs |
|---|---|
| **Widen to Tier 2b** (recommended) | The pilot is no longer about heaters. Buys a trustworthy result. |
| **Widen to Tier 2a** | Keeps heaters central; the third pair is weakly commensurable with the first two. |
| **Accept a directional result on 2 pairs** | Legitimate if labelled — but it is **directional, not conclusive**, and must be reported as such every time it is cited. Two pairs cannot separate a real effect from ordinary page-level variance. |
| **Relax the three-pair floor** | Not recommended. Three pairs is what makes the result trustworthy; relaxing it converts the pilot into an expensive anecdote. |

**Prerequisite under every option**: pull the GSC baseline first. Until then, "similar current
traffic and rankings" is an assumption, and a pair matched on assumption is not a matched pair.

## 5. Owed from the crawl, unrelated to pairing

- **EN cluster unenumerated.** EN uses different slugs (`heating-panel-heaters/…-panel-heater`) and
  was only spot-probed. If the pilot is to measure both locales, the EN inventory is a
  prerequisite; if GR-only, state that as a scope decision rather than leaving it implicit.
- **C10 unverified** — the unaccented `Θερμοπομποι` token on eight pages was recorded as a lead,
  not a defect, and its ALL-CAPS context was never checked.
