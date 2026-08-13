# Pairing analysis — NOBO/ATLANTIC cluster, 2026-08-13

**Status: RECOMMENDATION ONLY. No page is assigned treatment or control here.** Assignment is
the owner's decision (Sani deferred it — "decide once I see the page list", `GATED-ITEMS.md` G8
note 4). Nothing was fetched from the property for this document; nothing was published; no
skill, eval, register or crawl file was touched. The sole evidence base is the two crawl records
committed on `origin/claude/pilot-crawl-2026-08-11`, read at this file's date.

Protocol worked to: `docs/loop/PILOT.md` §0 (input bar), §1 (design decision tree), §2 (baseline),
§5 (deployment rules). Where this analysis reaches a conclusion the protocol's literal text does
not license, it says so and routes the question rather than resolving it (§5 below).

---

## 0. The two inputs that decide everything, and their evidence grades

| Input | Grade | Where it comes from |
|---|---|---|
| 17 surfaces, per-page structure (type, words, meta, schema, θερμοπομπ* placement) | **Observed**, reconciled against the site's own rendered `αποτελέσματα` counts | `crawl-2026-08-11-macstudio.md` §1–§2 |
| Traffic and ranking for any of those pages | **Absent — none exists anywhere in the crawl** | that file's own §4: "No traffic or ranking data was pulled" |
| Seasonality: ~91% of this category's demand in Oct–Mar | **Unsourced** — see below | tasking brief, 2026-08-13 |

**[VERIFY: "roughly 91% of θερμοπομπ* category demand falls October–March" — source: the
coordinator's tasking brief of 2026-08-13, which carries no citation; no file in this repository
and no line of either crawl record carries the figure or anything from which it could be
derived.]** It is used below as a *stated input*, never as a finding. Two pulls would settle it,
both of which the pilot needs anyway: a 24-month month-by-month Search Console impressions pull
for these pages (property-owned, exact, but only covers demand that already reaches this site),
or a 24-month Google Trends read on the θερμοπομπ* query set (broader, relative-index only — the
caveat `research/serp-analysis/references/greek-tourism-seasonality.md` §4 attaches to it). That
module's standing rule applies to this document too: *a month curve is measured, never asserted;
a calendar row without a source and date is an assumption.*

**Nothing below depends on the figure being 91%.** Every conclusion here follows from the demand
being *strongly winter-concentrated* — which is a property of the product, not of the number —
and would survive the figure landing anywhere from ~70% to ~95%. What would change the
conclusions is the curve being *flat*, and no one on this task believes that.

---

## 1. The inventory, and what it reconciles to

17 surfaces = 14 product pages + 2 category pages + 1 blog post. The two brand-facet URLs
(`/thermansi-thermopompoi/nobo/`, `…/atlantic/`) were probed for defects C7/C8 but are not
separate surfaces and are not candidates (they are filtered renderings of the category, not
independently editable content).

**Category membership is derived, not stated.** The crawl gives per-category brand-facet counts,
not a per-page category field. The counts close exactly, which pins the membership:

| Category | products | NOBO | ATLANTIC | residue | Resolves to |
|---|---|---|---|---|---|
| `thermansi-thermopompoi` | 5 | 3 | 2 | 0 | the 5 core heaters — **and nothing else** |
| `thermansi-aksesouar` | 9 | 5 | 3 | 1 Tonon | the 8 accessories + 1 un-inventoried Tonon page |
| `thermansi-thermansi-loutrou` | 3 | — | 1 | 2 Tonon | the towel rail + 2 un-inventoried Tonon pages |
| `thermansi-thermansi-loutrou-1` | 4 | — | — | 4 Tonon | 4 un-inventoried Tonon pages |

Totals check: NOBO 3+5 = 8; ATLANTIC 2+3+1 = 6; 14 products — matching the crawl's own header.
Two consequences carry the rest of this document:

1. **The θερμοπομπ* product class on this property contains exactly five pages, with zero
   residue.** Three pairs need six pages. **No selection among the five can reach three pairs** —
   this is arithmetic, not judgement, and it is why the third pair cannot come from the core
   heaters no matter which exclusions are reversed.
2. **The towel rail's only category-mates are the two Tonon pages.** That makes the smallest
   possible widening ask a *single named page*, not a cluster expansion (§4, option W2).

---

## 2. The pairing table

Page IDs (P1…P17) are this pilot's stable handles for §4/§6 rows. `ProductId` is the crawl's own.
Blank cells are **not recorded in the crawl**, never zero — the crawl's accessory and
category/blog tables carry no θερμοπομπ* column at all.

| ID | ProductId / path | Page type | Brand | Words | Meta | θερμοπομπ* placement | JSON-LD `@type`s | Crawl signals bearing on baseline traffic |
|---|---|---|---|---|---|---|---|---|
| P1 | 823327 Nobo NTL4T | product (heater) | NOBO | 1323 | 108 ch | meta, h2 | Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject | canonical present; in sitemap; **name-collision target of C1** |
| P2 | 965262 Nobo NTL4R WiFi | product (heater) | NOBO | 1089 | 220 ch **+ emoji** | meta, h2 | same as P1 | C1 wrong slug; C2 emoji stored as `??`; meta over length |
| P3 | 823322 Nobo NTL2N | product (heater) | NOBO | 707 | 77 ch | meta, h2 | same as P1 | shortest heater; no page-level defect recorded |
| P4 | 823277 Atlantic F119 DESIGN CE | product (heater) | ATLANTIC | 1192 | 162 ch | meta, h2 | P1 set **+ FAQPage, AggregateOffer** | no page-level defect recorded |
| P5 | 965528 Atlantic F120 WiFi Connect | product (heater) | ATLANTIC | 1542 | 160 ch | **h1**, meta, h2 | P1 set **+ FAQPage, AggregateOffer** | only product page with the seed term in H1 — expect the strongest baseline on the seed query |
| P6 | 823257 Nobo Clip on Glass Anthracite | product (accessory) | NOBO | 382 | 121 ch, **dupe of P7** | — | **NONE (C5)** | duplicate meta (C6); zero structured data |
| P7 | 823260 Nobo Clip on Glass Retro Blue | product (accessory) | NOBO | 387 | 121 ch, **dupe of P6** | — | Product | duplicate meta (C6) |
| P8 | 823294 Nobo Βάση Δαπέδου Fs 40 | product (accessory) | NOBO | 297 | 79 ch | — | Product | — |
| P9 | 971036 Καλώδιο Παροχής για Nobo | product (accessory) | NOBO | 156 | boilerplate (C3) | — | Product | byte-identical meta with P10, P12, P13 |
| P10 | 979671 Καλώδιο Παροχής Nobo NTL4R Wi-Fi | product (accessory) | NOBO | 152 | boilerplate (C3) | — | Product | as P9 |
| P11 | 971026 Atlantic Σταθερή Βάση Δαπέδου | product (accessory) | ATLANTIC | 220 | 182 ch unique | — | Product | only accessory with a unique meta |
| P12 | 971027 Atlantic Σχάρα Στήριξης Τοίχου | product (accessory) | ATLANTIC | 213 | boilerplate (C3) | — | Product | as P9 |
| P13 | 823255 Άγκιστρο Πετσετοκρεμάστρας Atlantic | product (accessory) | ATLANTIC | 148 | boilerplate (C3) | — | Product | as P9 |
| P14 | 891227 Atlantic RSS 2012 Anthracite | product (towel rail) | ATLANTIC | 472 | 60 ch | — | Product, WebPage | only ATLANTIC page in `…loutrou`; short meta |
| P15 | `/el-gr/thermansi-thermopompoi/` | category | mixed | 1590 | 161 ch | title, h1, meta, h2 | CollectionPage, FAQPage, ItemList, Organization, WebSite | **no canonical (C7)**; facet duplicates (C8); parent of P1–P5 |
| P16 | `/el-gr/thermansi-aksesouar/` | category | mixed | 313 | **site-wide default (C4)** | — | **0 blocks (C4)** | no canonical (C7); parent of P6–P13 |
| P17 | `/el-gr/blog/post/18567/…NOBO…` | blog article | NOBO topic | 585 | 147 ch | title, h1, meta, h2 | Article, FAQPage, WebPage | in the 52-post blog set, outside the product sitemap segment |

**The traffic column that decides comparability does not exist.** `PILOT.md` §1's definition of
"comparable" has three limbs — topic class, traffic band (12-week Search Console clicks within
2×, or both under 10 clicks with nonzero impressions), and template. The crawl answers two.
Word count is used below as a **page-size proxy** and is labelled as one every time; it is not
the protocol's criterion and cannot be substituted for it.

**Pairs below are matched on baseline comparability only** — page type, template, product family,
size proxy. They are deliberately *not* matched on meta length, schema completeness, or
θερμοπομπ* placement: those are things the optimisation pass changes, and matching on them would
be matching on the treatment.

---

## 3. Honest pair count: **two**

Working the pool after the first-pass exclusions (8 accessories, 1 defect page — both verified in
§7): P1, P3, P4, P5, P14, P15, P16, P17.

| Template class | Members | Pairs formable | Why |
|---|---|---|---|
| Product — panel heater | P1, P3, P4, P5 | **2** | four pages, same template, same intent family |
| Product — towel rail | P14 | 0 | no partner inside NOBO/ATLANTIC (§1 finding 2) |
| Category | P15, P16 | 0 | 1590 vs 313 words (5.08× on the size proxy), different intent family, full schema vs zero blocks, and P16 carries the site-wide default meta |
| Blog article | P17 | 0 | one article — nothing to pair with |

**Two. Against a floor of three.** Stated more precisely, because the difference matters for what
the Search Console pull can still change: **two candidate pairs on the two crawl-checkable limbs
of "comparable", and zero pairs confirmed on all three.** The traffic-band limb is untested for
every page in the inventory. The pull can move the count down as easily as up.

### Recommended pairing of the four heaters, and the alternative I rejected

| Pair | Members | Size proxy | Matches on | Known baseline asymmetry |
|---|---|---|---|---|
| **A1** | P4 ↔ P5 (both ATLANTIC) | 1192 : 1542 = 1.29× | template, brand, category, schema stack (both carry FAQPage + AggregateOffer) | P5 has the seed term in H1, P4 does not — likely a real baseline-performance gap on the seed query, and the one thing that could break this pair when clicks arrive |
| **A2** | P1 ↔ P3 (both NOBO) | 1323 : 707 = 1.87× | template, brand, category, schema stack (neither carries FAQPage/AggregateOffer) | widest size gap of any candidate pair; no other asymmetry recorded |

Rejected alternative — cross-brand size matching, `P1 ↔ P4` (1.11×) and `P5 ↔ P3` (2.18×): it
buys a tighter size proxy on one pair and a worse one on the other, and it pays for that with
brand-demand differences inside every pair plus a schema-stack mismatch (ATLANTIC heaters carry
FAQPage + AggregateOffer, NOBO heaters do not). It also risks a brand-confounded treatment/control
split at assignment. Within-brand pairing keeps the brand balanced on both sides and keeps
seasonality — the whole reason controls exist here — differenced inside a pair that shares one
demand curve.

**Neither pair survives contact with data automatically.** Both are provisional on the Search
Console pull: A1 fails if P5's H1 advantage puts it outside 2× of P4 on in-season clicks; A2 fails
if P1 and P3 land in different bands.

---

## 4. Why the design question is not negotiable this season

The tasking brief's premise checks out, and the crawl plus the seasonality input make the argument
sharper than "seasonality is a confound":

- **The baseline lookback would be taken in the trough.** `PILOT.md` §2 fixes a 12-week Search
  Console lookback at day 0. A day-0 in early September puts that window across roughly mid-June
  to early September — the deepest part of the off-season for a heating category.
- **The measurement window would be taken in the peak.** A 12-week window from mid-September
  reaches into December.
- So a before/after design compares a trough baseline against an in-season window. It will produce
  a large positive delta **whether or not the treatment did anything**. The confound is not merely
  present: it is larger than any plausible treatment effect and points the same way. That design
  cannot return an uninterpretable answer — it returns a confident wrong one, which is worse.
- A matched pair differences the season out, because both members sit in the same category and
  share one demand curve. That is the entire structural argument for controls in `PILOT.md` §1,
  and this cluster is the case it was written for.

**The conflict this creates with the protocol, stated rather than resolved.** `PILOT.md` §1's edge
case reads: at exactly 1–2 formable pairs, run before/after as the pre-registered *primary*
design and keep the pairs as a supplementary read. Applied literally here, that prescribes the one
design this season's seasonality makes uninterpretable. The rule is not wrong in general — it is
written for clusters whose baseline and measurement windows sit at comparable points in the year.
**This is a protocol question for the coordinator and Sani, and `PILOT.md` is not this
document's to edit.** It has to be settled *before* §4 lock, because settling it afterwards is a
post-hoc design change and §4's own discipline demotes the whole result to exploratory when that
happens.

---

## 5. Widening options, costed and ranked

The brief asks how far beyond NOBO and ATLANTIC one must go to reach three pairs. **The honest
answer is: possibly not beyond them at all.** The count of two is produced by the first pass's
accessory exclusion, not by the inventory.

### W1 — Re-test the eight excluded accessories against Search Console, not word count. **RECOMMENDED.**

The eight excluded pages contain at least three structurally exceptional twin pairs:

| Twin pair | Size proxy | Match quality |
|---|---|---|
| P6 ↔ P7 (Clip on Glass, Anthracite / Retro Blue) | 382 : 387 = 1.01× | same product line, same template, near-identical size — the tightest structural match on the property |
| P9 ↔ P10 (Nobo power cables) | 156 : 152 = 1.03× | same product line, same template, both boilerplate meta |
| P11 ↔ P12 (Atlantic floor stand / wall bracket) | 220 : 213 = 1.03× | same template, same brand, adjacent product function |

- **Cost in comparability: none.** These are the best-matched pages in the inventory on type,
  template and size.
- **Cost in relevance: real.** Accessory queries are part-number and brand terms, not θερμοπομπ*.
  A third pair here tests the library's optimisation pass on a different query class than the
  seed keyword — which broadens what the pilot generalises to, and weakens what it says about the
  seed term specifically.
- **Cost in power: the open risk.** A 150-word cable page gives a content pass almost nothing to
  work with, and these pages may carry too few impressions for any change to be visible. Note the
  trap in §1's own band rule: "both under 10 clicks (low-traffic band)" is *permissive*, so a pair
  carrying almost no traffic passes the letter of the comparability test while supplying no
  evidence. **The floor of three exists for power, and a pair that clears the band on near-zero
  traffic does not deliver it.**
- **Mitigation, and the one thing I would ask for at §4 lock:** admit an accessory pair only
  against a stated minimum in-season baseline-impressions floor per member, recorded in §4 before
  assignment. I am not proposing a number — the number comes from the export, and inventing one
  here would be exactly the placeholder-that-reads-like-a-value this pilot forbids.
- **Cost to run: zero.** No cluster change, no owner permission, no re-crawl. It uses the Search
  Console export §2 requires anyway.

### W2 — One non-NOBO/ATLANTIC control partner for the towel rail (P14), from `thermansi-thermansi-loutrou`

The minimal step outside Sani's stated cluster rule: **one page**, not a cluster expansion. P14's
only category-mates are the two Tonon pages (§1). Same category, therefore same intent family;
same product template, subject to confirmation.

- **Cost in comparability**: cross-brand (Atlantic vs a house/secondary brand whose baseline
  demand is unknown), and a different sub-family from the other two pairs — bath heating, not
  panel heaters. Seasonality still differences out *within* that pair, but pooling magnitudes
  across pairs with different demand curves is unsafe; a sign-based read across pairs is not.
- **Needs**: Sani's word (it changes input 1's cluster rule), plus a targeted re-crawl of the two
  Tonon pages to get word count, template, meta and schema — the crawl never enumerated them.
  The Mac Studio client is the route that worked; six URLs including the `…loutrou-1` set.
- **Risk it fails**: if neither Tonon page is a towel rail of comparable size, this option yields
  nothing and the time spent is lost.

### W3 — Widen the cluster rule to the whole θέρμανση tree

More candidate partners (the 7 Tonon pages visible as residue, plus whatever else the tree holds),
at the cost of a page list that exceeds §0's 5–15 bound — which per `PILOT.md` §0.1 requires **a
selection rule that is Sani's to give, not the coordinator's to invent**. Also drags in more
un-enumerated pages and a larger baseline-audit load inside a tight calendar (§8).

### W4 — Pair the EN-locale twins

- The EN cluster is real and **unenumerated** (crawl §4) — a full second crawl on different slugs.
- **EN is absent from both sitemaps (C9)**, so EN baseline impressions are likely negligible,
  which is precisely §0's input-1 bar ("nonzero impressions on most pages").
- **The disqualifying objection**: an EN page and its EL twin are the same product. Treating one
  while holding the other as control contaminates the control through the hreflang pair. And EN
  pages skip §5's binding Greek-editor gate, so the treatment applied there is not the same
  treatment.
- EN carries the same C1 slug collision.

### W5 — Promote the category and blog surfaces into a pair. **Reject.**

Fails §1's template limb outright: CollectionPage, Article and Product are three different
templates. The category's only same-template partner is P16 at 313 words with the site-wide
default meta and zero JSON-LD — 5.08× on the size proxy and a different intent family. The blog
post has no partner at all. **This is the manufactured third pair the brief warns about**: it
would look clean in a table and mean nothing.

### W6 — Reverse the defect-page exclusion to free up a pair. **Reject, on arithmetic.**

Five heater pages yield two pairs and one leftover. Re-admitting P2 cannot produce a third pair —
it only changes which pairs form (it would enable the tighter cross-brand configuration
`P2 ↔ P4` at 1.09× and `P1 ↔ P5` at 1.17×, at the costs listed in §3 and §7).

### Ranking, and the choice

**W1 → W2 → W3 → W4 → (W5, W6 rejected).**

**I would run W1 and prepare W2 in parallel.** W1 is free, needs no permission, and is decided by
an export the pilot must obtain regardless — so it converts the pair-count question from a
judgement call into a measurement. But it can fail on the power test, and if it does, W2 needs
lead time that the treatment-by date (§8) does not leave spare. Asking Sani for the W2 permission
now, while the export is being obtained, costs one question and buys back three weeks.

---

## 6. The fallback: what two pairs can and cannot establish

If widening is refused and W1's accessory pairs do not clear an impressions floor, the strongest
available design is **two matched pairs as the pre-registered primary read**, with the
before/after comparison against the trough baseline demoted to context and explicitly labelled
uninterpretable for effect size (§4). This departs from §1's literal edge-case instruction, which
is why §4 above routes it as a ruling to be made before lock, not after.

**What it can establish**

- A seasonality-adjusted *direction* per pair. The control absorbs the Oct–Mar ramp, so a large,
  same-direction delta-of-deltas on both pairs is a genuine directional signal.
- Whether the pipeline runs from one end to the other — skills producing the content, the
  CORE-EEAT and Greek-editor gates holding, per-change HITL approval and pre-change capture
  operating on a real property. That is the process baseline the plan calls the library's single
  largest gap, and it is not pair-limited.
- The AI-citation read (§3), whose denominator is queries × engines × weeks, not pairs. It is the
  least damaged leg of the whole pilot under a two-pair constraint.
- W10's Greek inflection leg, which needs SERP captures per query pair — also not pair-limited.

**What it cannot establish**

- Any statistical claim. With two pairs, a sign test bottoms out at one-sided p = 0.25
  (two-sided 0.5) even when both pairs move the same way. No conventional significance is
  reachable, at any effect size.
- Any magnitude claim of the form "the optimisation pass produced X%". Two pairs give two numbers,
  not an estimate.
- **A meaningful null.** This is the failure mode most likely to be misread. Two pairs cannot
  exclude a real effect, so a flat result is *uninformative*, not evidence of no effect. §4's
  null-result discipline — a null is reported with the same prominence as a positive — makes this
  urgent rather than academic: without a pre-registered **"underpowered — inconclusive"** band
  alongside the null band, this pilot will report a null it is not entitled to. I recommend that
  band be added to §4 before lock. That is a `PILOT.md` edit and therefore the coordinator's.

**The option of not running this season, assessed honestly**

- *Cost of running underpowered*: it consumes the one Oct–Mar window (the next is a year away),
  spends Sani's approval bandwidth and the webmaster's time, and produces a result that will be
  quoted more confidently than it deserves — a standing risk precisely because this would be the
  library's only real-site evidence.
- *Cost of not running*: the largest gap in the library stays open for another twelve months, and
  the three legs that are **not** pair-limited (pipeline, AI-citation baseline, W10 inflection)
  are lost with it — none of them needed three pairs in the first place.
- *My recommendation, for the owner's decision*: **run it, scoped honestly** — two pairs
  pre-registered as directional-and-underpowered, with the pipeline, citation and W10 legs named
  in advance as the parts that actually deliver this season, and the rank/click read labelled
  supplementary from the start. Not running costs a full year for a gap this pilot exists to
  close. What must not happen is running it as designed and discovering the underpowering at
  week 12.

---

## 7. The two first-pass exclusions, verified against the crawl

### The defect page (P2, 965262 Nobo NTL4R WiFi) — **agree with the exclusion; one stated ground does not check out**

| Stated ground | Verdict against the crawl |
|---|---|
| wrong slug | **Verified.** C1: `/thermopompos-nobo-ntl4t` serves NTL4R WiFi (965262); the real NTL4T is `/thermopompos-ntl4t` (823327). EN repeats it. |
| emoji in a meta description | **Verified.** C2: 965262 carries `🛜`; the CMS stores Windows-1253, so it stores as `??`. |
| a badge | **Not supported.** The token "badge" appears nowhere in either crawl record, and the inventory has no on-page badge column. Unverifiable from this evidence — it should be sourced or corrected. |
| — | A **third verifiable defect does exist** in its place: the same meta is 220 characters, over length (C2, second clause). |

The exclusion's *substance* holds, and I would rest it on stronger grounds than "if it moves you
cannot attribute the movement" — which is an argument about a treatment page, and P2 could in
principle have been a control:

1. **C1's fix is out of scope and pending.** A slug change + 301 is platform-level, not content
   (`PILOT.md` §5 bars it without the webmaster). If the webmaster fixes a 🔴 defect mid-window,
   it lands on a page inside the design — and if that page is a control, §5's "control pages are
   untouchable" is broken by someone who never agreed to the rule.
2. **P2 cannibalises P1 by construction.** A URL containing `ntl4t` serving NTL4R means NTL4T
   queries can land on the wrong page. P1 is in the recommended pool; putting P2 in the same
   design creates a direct query-level contamination channel between two of its pages.
3. **Its baseline is broken in an encoding-dependent way** — a rendered meta description
   containing `??` is not a stable baseline to measure a meta rewrite against.

**What the exclusion costs, stated rather than hidden**: it is not free. Re-admitting P2 would
enable the tightest size-proxy configuration available (`P2 ↔ P4` at 1.09×, `P1 ↔ P5` at 1.17×).
It would still not produce a third pair (§5, W6). I judge the trade worth taking, because the size
proxy is not the protocol's criterion and clicks are — and because points 1 and 2 above are
contamination risks that no amount of size matching compensates for.

### The eight accessories (P6–P13, 148–387 words) — **agree with the exclusion for the primary design; disagree that word count is a sufficient reason**

The count and the range check out exactly: eight pages, 148 to 387 words. Note the towel rail
(P14, 472 words) sits *outside* that band and is therefore not covered by this exclusion — it is
still a candidate with no partner, which is what W2 addresses.

Where I agree: as **primary-design** pairs these eight are rightly set aside. Their queries are
part-number and brand terms, not θερμοπομπ*, so they do not test the seed keyword; a content pass
on a 150-word cable page has very little to work with; and four of the eight (P9, P10, P12, P13)
carry a byte-identical boilerplate meta while two more (P6, P7) share one duplicate string, so
several are near-duplicates of each other in the index before anything is done to them.

Where I disagree: **"too small to carry signal" is a proxy for a bar the crawl cannot test.** The
real bar is impressions (§0's input-1 bar; §1's traffic band), and word count is not evidence
about impressions. The exclusion was decided on the one attribute available rather than the one
that matters — understandable, and it should be re-tested, not settled. That re-test is W1, it is
the top-ranked widening option, and it costs nothing but the export the pilot already needs.

---

## 8. Timing — when treatment has to land

Fixed points: `PILOT.md` §0's own honesty note (first directional signal 4–6 weeks after a change,
decision-grade ~12 weeks), §2's week 0–1 baseline, §5's week 1–2 intervention window, §6's
+2/+4/+8/+12 checkpoints anchored on W0 = first treatment publication. Demand band as supplied
(§0, unverified): October–March.

**Treatment must land between 2026-09-07 and 2026-09-30. Target W0: 2026-09-14. Hard back-stop:
2026-10-15.**

Why that range:

- W0 = 2026-09-14 puts the checkpoints at CP1 2026-09-28, CP2 2026-10-12, CP3 2026-11-09,
  CP4 2026-12-07. CP2 through CP4 sit inside the demand band, and the 4–6 week ranking-response
  lag is spent in late September — *before* the season, which is the point.
- Publishing later spends the lag inside the season. At the 2026-10-15 back-stop, CP4 falls on
  2027-01-07: still in band, but the treated pages spend the first six weeks of real demand not
  yet reflecting the change, which forfeits roughly half the in-season measurement.
- Past roughly 2026-10-31 the season is effectively lost for a 12-week read: the lag consumes
  November and December and the window measures the descending half of the band.

Working backwards, with today at 2026-08-13:

| By | What has to be done |
|---|---|
| **2026-08-31** | Search Console export dropped in `docs/loop/pilot/data/` — request the **full 16-month history**, per page and per query, so the pairing test can be run on *in-season* traffic and a year-over-year read is possible later. W2's permission asked and the two Tonon pages re-crawled, if that hedge is being kept. |
| **2026-09-07** | Day 0: all three §0 inputs cleared; §1 tree run against real clicks; pair set fixed. |
| **2026-09-07 → 09-13** | §2 baseline week — audits, dated el-GR SERP capture, week-0 citation sample. |
| **2026-09-11** | §4 pre-registration locked, including the underpowered-inconclusive band (§6) and the accessory-admission floor (§5, W1). |
| **2026-09-14 → 09-30** | Treatment publications, each through the three §5 gates. |

That leaves 18 days to the first deadline. **The binding constraint is not the pair count — it is
`PILOT.md` §0 input 3, which has no recorded words at all**: no named publisher, no approval
channel, no pre-change capture method, no turnaround expectation. Nothing in §8 can start without
it, and a publication workflow agreed in late September cannot deliver a mid-September W0.

One consequence of the trough timing, for the pairing test itself: a 12-week lookback taken at
day 0 sits in the off-season, where most pages will fall into the "both under 10 clicks" band and
the band test stops discriminating between them. This is why the request above is for 16 months
rather than 12 weeks — the §2 lookback stays exactly as the protocol specifies; the longer pull is
*additional*, and it is what the pairing decision should be read from.

---

## 9. Contamination risks the design has to handle

Not pairing questions, but they change what a pair measures and are cheaper to fix now than to
explain at week 12.

1. **Within-cluster cannibalisation is unavoidable here.** All five heaters compete for the same
   head query, so treatment and control sit in the same SERP. If the treated page gains by
   displacing its own control, the delta-of-deltas is biased *away from null* and a small positive
   result cannot be distinguished from displacement. **Mitigation**: track the category-level
   total (all five heaters plus P15) alongside each pair delta. A positive pair delta with a flat
   cluster total is displacement, not gain — and that comparison costs nothing but a column.
2. **P15 is the parent of every heater in the design.** Any content edit to the category page acts
   on treatment and control alike. Recommend holding P15 and both facet URLs untouched for the
   full window, or logging any change as a shared confound under §6.
3. **Internal linking is in scope under §5 and points at controls.** An internal-linking pass that
   adds links to a control page is a treatment applied to a control. Recommend an explicit rule
   at lock: no internal-link edits targeting control pages for the window.
4. **C1's platform fix must be scheduled outside the window** — before W0 with a fresh pre-change
   capture, or after CP4. Either is fine; mid-window is not.

---

## 10. Gaps — named, not worked around

| # | Gap | What it blocks | What supplies it |
|---|---|---|---|
| G-a | **No traffic or ranking data for any page** (crawl §4) | §1's traffic-band limb, §1's assignment sort (which sorts on 12-week clicks), §0's nonzero-impressions bar, and any statement about current performance | the Search Console export (§0 input 2, IN PROGRESS) — 16 months, page-level and query-level; GA4 sessions alongside. No connector supplies this: none of the six MCP servers this repo declares is a Search Console or GA4 server (`PILOT.md` §0.1). |
| G-b | **θερμοπομπ* placement is not recorded for P6–P14, P16** — the accessory and category tables carry no such column | judging whether any accessory page targets the seed term at all | one re-crawl pass, or a note from whoever ran the crawl |
| G-c | **The 2+4 Tonon pages are un-enumerated** | W2 and W3 entirely | a targeted six-URL re-crawl from the Mac Studio client |
| G-d | **The EN cluster is un-enumerated** (crawl §4) | W4 | a full EN crawl on the EN slug pattern |
| G-e | **CMS template identity is inferred, not confirmed** — from the uniform product-page signature and the `class="single-product"` grid, not from a template field | §1's third limb, strictly read | a one-line confirmation from the CMS owner |
| G-f | **C10 is recorded "UNVERIFIED" by the crawl itself** — the unaccented `Θερμοπομποι` token on eight pages, never checked for ALL-CAPS heading context | nothing in the pairing, but it decides whether eight pages carry a real defect | the context check the crawl already owes |
| G-g | **The Oct–Mar concentration figure has no source** (§0) | nothing structural — the argument runs on winter concentration, not on the number | a 24-month Search Console monthly pull, or a dated Google Trends read with its relative-index caveat |

---

## 11. What this document does not do

- **It does not assign treatment and control.** §1's assignment rule is deterministic and sorts on
  12-week clicks that do not exist yet; once the export lands, running that rule *proposes* a
  split. Proposing is not approving. The assignment is Sani's, and he has already said he will
  make it when he sees the page list.
- It does not name a page list for §0 input 1. The cluster rule is Sani's; this analysis reads the
  inventory the crawl produced from it and recommends which pages the design should use.
- It fetched nothing from the property, published nothing, and edited no other file.
- **Public-repo note, flagged not fixed**: `PILOT.md` §0's default for this public fork is
  anonymized page IDs and banded figures, with the ID→URL map kept Sani-side. The committed crawl
  records already carry raw ProductIds, slugs and defect detail. This document adds no new
  disclosure — it derives from those records and carries no traffic figures — but the question of
  whether that default has already been exceeded is Sani's to settle, and it is not this
  document's to resolve by re-anonymising a map that is already in the repository.
