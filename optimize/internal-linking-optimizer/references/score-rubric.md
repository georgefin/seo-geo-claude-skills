# Internal Linking Optimizer — Score Rubric & Impact-Figure Rule

Referenced from [SKILL.md](../SKILL.md) Steps 1, 3 and 7, and from
[linking-templates.md](./linking-templates.md) Step 7.

The skill emits two scores out of 10 — a **Structure Score** (Step 1) and an **Anchor Score**
(Step 3) — plus counts, percentages, and an executive-summary impact line. **Every one of them
is arithmetic over rows the analysis already produced**, not a judgment call. Two analyses of
the same link export must land on the same numbers, and the client must be able to recompute
either score from the tables printed above it.

---

## 1. The arithmetic

Same mechanic as the sibling audit skill ([technical-seo-checker score-rubric](../../technical-seo-checker/references/score-rubric.md)) — one library, one way to score a checklist.

1. **Scored rows only.** A row is scored only if the data in hand could actually settle it. A
   row you could not check is written `— not checked (no crawl data)` and is left out of both
   the numerator and the denominator. Never score an unchecked row as ✅ or ❌.
2. **Points.** ✅ = 1 · ⚠️ = 0.5 · ❌ = 0.
3. **Score** = `round(10 × points ÷ scored rows)`, to the nearest whole number, with an exact
   half rounding **down** (2.5 → 2).
4. **Show the working inline.** Fixed format, numerator then denominator then what was left out:

```
**Structure Score**: 4/10 (2.0 pts ÷ 5 scored rows; click depth not checked — no crawl export)
```

A score printed without its derivation is not deliverable: the reader cannot check it and the
next analysis cannot reproduce it.

## 2. Structure Score — the six rows

Each row is settled from a table the analysis already printed, against a target this skill's
architecture reference already publishes.

| # | Row | ✅ 1 | ⚠️ 0.5 | ❌ 0 | Settled from |
|---|-----|------|--------|------|--------------|
| 1 | Orphan pages | zero orphans | orphans exist, none in the high-priority class | one or more high-priority orphans (traffic or rankings) | Step 2's own orphan list; target "Orphan pages 0" in [link-architecture-patterns.md](./link-architecture-patterns.md) Key Metrics |
| 2 | Average internal links per page | inside the model's band | within 2 links of the band | further outside | Step 1 Overview vs Key Metrics by Architecture Model — name the model you scored against |
| 3 | Under-linked important pages | table is empty | rows present, none a money or conversion page | a money page is under-linked | Step 1's Under-Linked Important Pages table |
| 4 | Click depth from the homepage | every page inside the model's target | only low-priority pages outside it | a priority page outside it | Key Metrics "Avg click depth"; state the convention (homepage = depth 0) |
| 5 | Broken internal links | none found | some found, none touching a priority page | a priority page is affected | the link inventory; Monthly Monitoring Checklist row |
| 6 | Topic cluster bidirectionality | every cluster links to its pillar and every pillar to all its clusters | one direction incomplete | both incomplete | Step 4's cluster map; the reference's bidirectional rule |

**Row 6 is not scored when no cluster is defined** — excluded from both sides, and said so
under the score. Excluding is not the same as scoring 0.

**Model-dependent targets** (rows 2 and 4) come from the Key Metrics by Architecture Model
table: click depth ≤2 flat, ≤3 hub-and-spoke and mesh, ≤4 silo and pyramid; links per page
5-10 hub-and-spoke, 3-7 silo, 8-15 flat, 3-5 pyramid, 8-15 mesh. **Name the model in the
derivation** — the same site scores differently against a silo target than a flat one, and a
reader who cannot see which target was used cannot check the row.

**Population figures are evidence, not scored rows**: total pages, total internal links, the
Link Distribution table, the Top Linked Pages table. They ground the rows above; they carry no
points of their own.

## 3. Anchor Score — one row per link instance

The denominator is **the internal link instances whose anchors you inventoried**, and Step 3's
own Assessment column is the grade:

| Grade | Points | The class |
|-------|--------|-----------|
| ✅ | 1 | Descriptive — names the destination's topic or type, and distinguishes it from the page's other links |
| ⚠️ | 0.5 | Exact-match keyword repeated across a target's inbound links beyond the 10-20% exact-match band in [linking-templates.md](./linking-templates.md); or the same anchor string pointing at two different targets (Step 3's own "Same anchor to multiple pages"); or a Natural-band anchor that names no destination (see below) |
| ❌ | 0 | Generic — "click here", "read more", a bare URL, or an anchor naming neither the destination nor its topic. These are the two strings Step 3's table already marks "❌ Not descriptive", and their class |

**The Natural-band tension is stated, not resolved.** "this article" and "learn more" are
sanctioned at 20-30% by the Anchor Text Guidelines in linking-templates.md and are
non-descriptive by Step 3's table. The skill does not resolve which surface wins, so a Natural
anchor scores ⚠️ — between the two — and the derivation says so. Do not silently promote it to
✅ or demote it to ❌.

**Print the population.** An anchor score without its base is not deliverable — the reader
cannot tell whether 6/10 describes 14 links or 1,400:

```
**Anchor Score**: 6/10 (8.5 pts ÷ 14 in-body link instances; 7 template logo links excluded)
```

**What stays out of the denominator**, and the report says which rule it applied:

- **Template link instances** repeated site-wide (logo, main menu, footer). Either exclude them
  and say so, or grade the template once as a single row. Grading the same logo anchor on 200
  pages makes the score a function of page count rather than of anchor quality.
- **External outbound links** — this score is about internal anchors.
- **Links whose anchor text you never saw** (a URL list without anchors). Not checked, not
  scored, named in the derivation.

## 4. When a score is withheld

- **No row could be scored → the score is withheld**, written `not scored — no link data`,
  never `0/10`. Zero means measured and failing; blank means unmeasured. Confusing the two is
  how an analysis invents a finding.
- **No site data at all → neither score is printed.** Name the input that unlocks each one — a
  crawl export or a hand link inventory for the Structure Score, the anchor text of each link
  for the Anchor Score — and stop. A structure score for a site nobody has looked at is a
  fabricated figure, whatever the requester says about the deadline.
- **Scores are never carried over** from a previous analysis, borrowed from a competitor, or
  estimated from "typical" sites of that size. A score is the arithmetic above or it is absent.
- **Partial data is scored on what was checked**, with the unchecked rows counted in the
  derivation. A 3-row denominator is honest; a 3-row denominator presented as a full audit is
  not.

## 5. Counts and percentages carry their population

Every other number in the report is derived too, and derived numbers fail more often than
scores because nobody recomputes them.

- **Name the population before stating a total.** "Total Internal Links: 21" is unreadable
  until the reader knows whether template links and broken links are inside it. Write
  "21 total link instances — 14 in body copy (1 of them broken) and 7 template logo links".
- **Show the arithmetic of every derived number.** `Average links per page: 14 ÷ 8 = 1.75`.
  Every percentage prints its numerator and denominator: `3/5 = 60% of that page's inbound
  anchors`. A percentage without a visible base is not checkable.
- **The Authority column** in Step 1's Top Linked Pages table is a *within-site relative label*
  read off that row's own inbound-link count, and the cut is stated — "High = 5 or more inbound
  in-body links on this 8-page site". It is never an external metric: no DA, DR, PA or vendor
  authority score appears unless a named connected tool supplied it, in which case the tool is
  named beside the number.
- **Targets are targets, not measurements.** The Step 7 Current State table sets "Over-optimized
  anchors <10%" and "Topic cluster coverage 100%" as targets; the Current column is the
  fixture-derived measurement with its base shown, and the Gap column is their difference.

## 6. The impact figure — what Step 7 may and may not say

**The plan carries no site-specific traffic or ranking forecast.** A number like "+18% traffic"
for a named site needs a ranking and traffic baseline plus a counterfactual; an internal-link
analysis has neither. Step 7's executive summary reports what the analysis measured — link
opportunities found, orphan pages to fix, pages gaining inbound links, priority actions — and
stops there.

The ROI Estimation ranges in
[link-architecture-patterns.md](./link-architecture-patterns.md) may be cited **only** with
their attribution in the same sentence — "typical ranges published in this skill's architecture
reference, not a projection for your site" — and never:

- in the executive summary's metrics list, where a figure reads as this site's number;
- multiplied by the site's sessions to produce a projected figure;
- restated as "expected", "you will see", or a single point value drawn from a range.

Those ranges carry no primary source of their own
`[VERIFY no primary source — the ROI Estimation ranges in link-architecture-patterns.md are
uncited practitioner estimates; checked 2026-08-10, no engine-official or study-backed origin
found]`. Treat them as illustrative magnitudes, not evidence.

**When the client asks for a number**, answer with the measurement that would produce one: a
baseline of sessions and positions for the affected pages taken before implementation, then a
re-measure 4-8 weeks after, per the reference's own timeline column. Offer the measurement
plan; do not offer the forecast.

## 7. Worked derivation

An 8-page site, hand-compiled link inventory, no crawler: 14 in-body link instances (1 broken)
plus 7 template logo links; one orphan with 210 sessions in 90 days; one money page with a
single inbound link on the anchor "click here"; the pillar links to 2 of its 5 cluster
articles; no click-depth data beyond the inventory.

**Structure Score** — model scored against: hub-and-spoke.

| Row | Grade | Why |
|-----|-------|-----|
| Orphan pages | ❌ 0 | one orphan, and its 210 sessions put it in the high-priority class |
| Avg links per page | ❌ 0 | 14 ÷ 8 = 1.75, against a 5-10 band — more than 2 outside |
| Under-linked important pages | ❌ 0 | the money page has 1 inbound link |
| Click depth | ⚠️ 0.5 | derivable from the inventory: every page at ≤3 except the orphan, which is unreachable |
| Broken internal links | ⚠️ 0.5 | 1 broken link, not on a priority page |
| Cluster bidirectionality | ❌ 0 | pillar links to 2 of 5; two clusters never link back |

`10 × 1.0 ÷ 6 = 1.67` → **`**Structure Score**: 2/10 (1.0 pts ÷ 6 scored rows; scored against
the hub-and-spoke targets)`**

**Anchor Score** — 14 in-body instances graded, 7 template logo links excluded: 8 descriptive
(✅ 8.0), 3 exact-match repeats of the same phrase into the pillar (⚠️ 1.5), 2 uses of the same
anchor pointing at two different targets (⚠️ 1.0), 1 "click here" (❌ 0).

`8.0 + 1.5 + 1.0 + 0 = 10.5`, and `10 × 10.5 ÷ 14 = 7.5` → rounds **down** →
**`**Anchor Score**: 7/10 (10.5 pts ÷ 14 in-body link instances; 7 template logo links
excluded)`**

The executive summary that follows reports "1 orphan page to fix · 5 link opportunities found ·
4 pages gaining inbound links" and **no traffic figure at all**, because nothing in this data
set measures traffic outcomes.
