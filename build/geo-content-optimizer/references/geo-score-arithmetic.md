# GEO Score Arithmetic — What Every Printed Number Is Made Of

Companion to [SKILL.md](../SKILL.md) steps 2 and 4. Nothing here changes what the skill
optimizes. It states how each number this skill prints is produced, so a reader can recompute
it from the deliverable alone, without seeing the working notes.

> **The rule this file exists to enforce**: no score ships without its derivation beside it —
> same table row, or the sentence immediately after the number. A GEO score with nothing to
> check it against is an opinion wearing a number's clothes, and the reader cannot tell which
> one they were handed.

Derivations are written in the deliverable's own language and in plain words — "4 of the 5
key terms now carry a standalone definition", «5 από τα 5 αριθμητικά στοιχεία έχουν μονάδα».
Never a framework item ID or a skill slug on a surface the client reads
(`anti-slop-ruleset.md` §6 family 8); the ID mapping is an operator artefact.

## 1. The chain of figures

| # | Figure | Composed from |
|---|--------|---------------|
| 1 | Factor score (1–10) | the factor's own count (§3), mapped through §2 |
| 2 | GEO Readiness (step 2 baseline) | sum of the factor scores ÷ factors scored |
| 3 | Overall GEO Score (step 4, after) | the same factors, the same count rules, re-counted on the optimized text |
| 4 | Change per factor | after − before |
| 5 | Lift % | (after − before) ÷ before × 100 |
| 6 | Citation-likelihood rating, if one is printed | count of the high-likelihood factors met (§6) |

Every other figure in the report derives from these six and has to reconcile with them.

## 2. The 1–10 scale is a ratio, not a feeling

Each factor asks for a countable number of things (`asked`) and the content delivers some of
them (`met`). The score is that ratio stretched onto the 1–10 scale:

```
score = 1 + 9 × (met ÷ asked), rounded half up, floor 1, ceiling 10
```

So `met = 0` scores **1**, never 0 — the scale has no zero — and `met = asked` scores **10**.
Both `met` and `asked` are printed beside the score; a ratio whose denominator is invisible is
not a derivation.

**Reverse check.** Given a printed score `S` over `asked = n`, compute `met = (S − 1) × n ÷ 9`.
A whole number (within one rounding unit) means the score is reachable and names the tally
behind it. A figure a whole step away from every attainable value is a defect.

| asked n | Attainable scores |
|---|---|
| 2 | 1, 6, 10 |
| 3 | 1, 4, 7, 10 |
| 4 | 1, 3, 6, 8, 10 |
| 5 | 1, 3, 5, 6, 8, 10 |
| 10 | 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 |

A score between two attainable values means the count and the number disagree — recompute
from the count, do not argue about the decimal.

## 3. What each factor counts

The eight factors are the ones in SKILL.md step 2. `asked` is set **once**, at step 2, from
the content and the brief — and reused unchanged at step 4, so the two columns are comparable.

| Factor | met | asked |
|--------|-----|-------|
| Clear definitions | key terms carrying a standalone 25–50-word definition that starts with the term | key terms the content actually uses |
| Quotable statements | statements a reader could lift unchanged — specific, self-contained, no "as mentioned above" | main sections (one per section is the target) |
| Factual density | precise data points with units | 5 — the Output Validation floor; a page with more than 5 caps the ratio at 1 |
| Source citations | claims from the inventory that no longer publish unsourced authority — sourced, converted to first-party, hedged, or removed (§3a) | claims that needed a source at step 2 (your own claim inventory) |
| Q&A format | target queries answered by a matching heading plus a direct standalone answer | target queries from step 1, capped at 5 |
| Authority signals | authority elements actually present: byline with credentials · sourced expert quote · first-party data · named methodology | the ones this client can genuinely supply — not all four by default |
| Content freshness | visible publish/update date within 12 months · no data point older than 24 months | 2, minus either check the page gives nothing to measure (§3b) |
| Structure clarity | headings matching query phrasing · 3–5-sentence chunks · a table wherever a comparison exists · a numbered list for any process · a summary box | 5, minus any element the page has no occasion for (see N/A below) |

**A factor with nothing to count is N/A, not a 1.** If `asked` would be 0 — the page makes no
comparison, so no table is owed; the client has no first-party data and no expert to quote —
mark the factor N/A, name the reason in the row, and exclude it from both the sum and the
divisor. Scoring an inapplicable factor 1 understates the page and inflates the lift.

### 3a. Source citations counts resolutions, not survivors

SKILL.md step 3 makes this mandatory: an unsourced claim already on the page "is not yours to
keep by default — source it, convert it to a first-party statement the client can stand behind
and say you did, or hedge/cut it." The factor scores the claim inventory against that mandate.
A claim is **resolved** when the text being scored does one of those four things:

- it carries a named, dated, checkable source;
- it is stated as first-party fact with the basis named ("across the 1,240 services we
  completed in 2025");
- it is hedged so it no longer asserts what it cannot support, borrowing no authority it
  cannot name;
- or it does not appear at all.

`met` is the count of resolved claims. `asked` is the step-2 inventory, frozen for both columns
so they stay comparable. **Removing an unsourceable claim moves it from unresolved to resolved,
so compliance can only raise this score, never leave it flat and never lower it.** Counting only
the sourced survivors pays nothing for the removal the skill requires, and hands the higher
score to whoever kept the claim — a scoring model arguing against its own rule.

The same test runs on the before column: at step 2 nothing has been sourced, converted, hedged
or cut yet, so a page of flat unsourced assertions scores `met = 0` there.

**Worked check.** Three claims need a source; the client can source none of them. Baseline
`met = 0 of 3` → `1 + 9 × (0 ÷ 3) = 1`. Cut all three, and the page publishes no unsourced
claim: `met = 3 of 3` → `1 + 9 × (3 ÷ 3) = 10`, printed as "3 of 3 claims resolved — none
sourceable, all three removed". Keep them and the score stays 1, which is the whole point.

Hedging is a resolution, not an escape hatch. "Most manufacturers recommend…" softened to "many
manufacturers appear to recommend…" still borrows an authority it cannot name: unresolved.

### 3b. Content freshness scores only what the page gives it to measure

The two checks are independent, and either can be inapplicable:

- **No visible publish/update date, and the client cannot supply one** → the date check leaves
  the denominator (SKILL.md Input Validation already treats an unavailable date this way).
- **The page carries no dated data point at all** → the data-age check leaves the denominator.
  "No data point older than 24 months" is otherwise trivially true of a page with no data
  points, and the page collects a mark for recency it never demonstrated.

`asked` is 2 minus the excluded checks, and the row names the exclusion. Excluded on both sides
→ the whole factor is N/A and leaves the divisor, per the rule above.

**Worked check.** A page whose visible date is 18 months old and which carries no data point at
all. Score both checks and the data-age half passes on absence: `met = 1 of 2` →
`1 + 9 × (1 ÷ 2) = 5.5 → 6`. That is an attainable value for `n = 2`, so §2's reverse check
clears it and a stale page with no data keeps a mid-scale mark. Exclude the data-age check and
`met = 0 of 1` → `1 + 9 × (0 ÷ 1) = 1`, which is what the page has earned. A page whose date
*is* fresh scores `1 of 1` → 10 on the strength of the date alone, with the exclusion printed
beside it — full marks for one measured check, never for an unmeasured one.

## 4. The averages

```
GEO Readiness = (sum of the printed factor scores) ÷ (number of factors scored)
```

Print both operands: `GEO Readiness: 2.6/10 — 21 points ÷ 8 factors scored`. Round to one
decimal. Factors scored + factors N/A = 8 in every deliverable, and the N/A list in the prose
has to match the N/A rows in the table.

With all eight factors scored the mean is a multiple of 0.125 — a screen that catches a
slipped figure, never a certificate that the figure is right. The check that always applies is
re-adding the column.

## 5. Before → after, and the lift

- The **before** column is the step 2 assessment verbatim. One baseline per deliverable: the
  step 4 table repeats the step 2 factor set rather than introducing a shorter one, because
  two factor sets over the same content produce two different baselines and the lift then
  depends on which one the reader happens to read.
- **Change** per factor = after − before. **Lift** = (after − before) ÷ before × 100, computed
  from the two printed averages and printed with both operands:
  `(9.4 − 2.6) ÷ 2.6 × 100 = 262%`.
- The scale floors at 1, so the baseline is never 0 and the lift is always defined.
- A factor that is N/A at baseline stays out of **both** columns, and the row says so. Letting
  it in after optimization changes the divisor mid-report and the lift stops meaning anything.

**Worked example** (invented figures — a bicycle-repair workshop page, before any client data
arrives):

| Factor | Before | After | Change | Count behind the after score |
|--------|--------|-------|--------|------------------------------|
| Clear definitions | 3 | 10 | +7 | 4 of 4 key terms defined standalone (was 1 of 4) |
| Quotable statements | 1 | 8 | +7 | 4 of 5 sections carry a liftable statement |
| Factual density | 5 | 10 | +5 | 5 of 5 data points carry units |
| Source citations | 1 | 10 | +9 | 3 of 3 claims name a checkable source |
| Q&A format | 1 | 10 | +9 | 4 of 4 target queries have a heading and a direct answer |
| Authority signals | 4 | 7 | +3 | 2 of 3 available: byline with credentials, first-party job data; no sourced expert quote exists |
| Content freshness | 1 | 10 | +9 | 2 of 2: update date visible, no datum older than 24 months |
| Structure clarity | 5 | 10 | +5 | 5 of 5 structure elements present |
| **GEO Readiness** | **2.6/10** | **9.4/10** | **+6.8** | **21 ÷ 8 → 75 ÷ 8, all 8 factors scored** |

Lift: (9.4 − 2.6) ÷ 2.6 × 100 = **262%**. Reverse-check one row: definitions after, `S = 10`,
`n = 4` → `met = (10 − 1) × 4 ÷ 9 = 4`, which is the count printed beside it.

## 6. Citation-likelihood ratings

If a deliverable prints one, it is a count, not an impression: the number of **High Citation
Likelihood** factors met from the ten listed in
[ai-citation-patterns.md](./ai-citation-patterns.md), printed as
`7/10 — 7 of the 10 high-likelihood factors met; the three missing are …`.

The `Citation likelihood: X/10` labels in
[quotable-content-examples.md](./quotable-content-examples.md) are illustrative judgements
about example text written to teach a contrast. They are not deliverable scores and carry no
derivation; do not copy the habit into a client report.

## 7. Scores never leave the report

A score is analysis, not copy. No GEO score, factor count or derivation appears inside a
paste-ready block, inside JSON-LD, or in body text the client is told to publish — the same
placement rule the Statistics rule applies to provenance notes (SKILL.md, Statistics rule,
**Placement**).

## 8. Pre-send recompute pass

Run this against the finished deliverable, not the working notes:

1. Every printed score carries its count in the same row or the next sentence — including the
   averages, which carry their sum and their divisor.
2. Each factor score reproduces from its own count through §2, and is an attainable value for
   that `asked`.
3. Sum of the printed factor scores ÷ the printed divisor = the printed average, to one decimal.
4. Factors scored + factors N/A = 8; the prose N/A list matches the N/A rows.
5. Any factor whose `asked` sits below its stated default names the check it excluded and why
   (§3b). A denominator that shrank silently is a score the reader cannot reproduce.
6. Source citations counts resolved claims, not sourced ones (§3a) — a claim the optimisation
   removed is resolved, and the row says so. A `met` that dropped because correct content was
   cut is the defect this check exists to catch.
7. Before and after use the same factor set, the same `asked` values and the same divisor.
8. The lift reproduces from the two printed averages.
9. Any claimed threshold ("at least 50% from baseline") is stated against the one baseline in
   the deliverable, with the arithmetic that produces it.
10. Where a sentence and a table disagree, the table wins — fix the sentence.
