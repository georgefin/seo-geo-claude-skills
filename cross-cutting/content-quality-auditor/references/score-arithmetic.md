# CORE-EEAT Score Arithmetic — Which Figures Are Possible

Companion to [SKILL.md](../SKILL.md) Steps 2–4 and its N/A Item Handling rules. Nothing here
changes the framework: the 80 items, the 8 dimensions, the Pass 10 / Partial 5 / Fail 0 item
scale, the content-type weights and the three veto items (T04, C01, R10) are as defined in
[core-eeat-benchmark.md](../../../references/core-eeat-benchmark.md). This file states which
numbers that machinery can and cannot produce, so any printed figure can be checked against
the scale it claims to come from.

## 1. The chain of figures

| # | Figure | Composed from |
|---|--------|---------------|
| 1 | Item points | Pass = 10 · Partial = 5 · Fail = 0 · N/A = excluded, never converted to 0 |
| 2 | Dimension score (0–100) | points earned ÷ (10 × scored items) × 100 |
| 3 | GEO Score | (C + O + R + E) ÷ 4 |
| 4 | SEO Score | (Exp + Ept + A + T) ÷ 4 |
| 5 | Weighted total | Σ (dimension score × content-type weight) |
| 6 | Reported final score | the weighted total, unless a veto outcome overrides it (§6) |

Every other number in the report — points lost, potential gains, the Top 5 ordering — derives
from these six and has to reconcile with them.

## 2. The attainable-value rule

Each scored item contributes 10, 5 or 0, so the points earned by `n` scored items are always a
multiple of 5. Write them as `5k`, where `k = (2 × Passes) + Partials` and `0 ≤ k ≤ 2n`. Then

```
dimension score = 5k ÷ (10 × n) × 100 = 50k / n
```

A dimension score is possible **if and only if it is an exact multiple of 50/n**. Every such
multiple between 0 and 100 is reachable by some tally, and no value between two consecutive
multiples is reachable by any tally.

| Scored items n | Step 50/n | Attainable scores |
|---|---|---|
| 10 (none N/A) | 5 | the 21 multiples of 5: 0, 5, 10 … 100 |
| 9 | 5.55… | 0, 5.56, 11.11, 16.67 … 100 |
| 8 | 6.25 | 0, 6.25, 12.5, 18.75 … 100 |
| 7 | 7.142857… | 0, 7.14, 14.29, 21.43 … 100 |
| 6 | 8.33… | 0, 8.33, 16.67, 25 … 100 |
| 5 | 10 | 0, 10, 20 … 100 |
| 4 | 12.5 | 0, 12.5, 25 … 100 — flagged Insufficient Data |
| 3 | 16.67… | 0, 16.67, 33.33 … 100 — flagged Insufficient Data |
| 2 | 25 | 0, 25, 50, 75, 100 — flagged Insufficient Data |
| 1 | 50 | 0, 50, 100 — flagged Insufficient Data |

Rows with fewer than 5 scored items are past the >50%-N/A line, so the dimension is flagged
"Insufficient Data" and excluded from the weighted total (SKILL.md N/A Item Handling, rule 4 —
a house rule of this skill, not a benchmark rule). The attainable-value rule still governs
whatever score is shown beside the flag.

## 3. The reverse check

Given a printed dimension score `S` over `n` scored items, compute `k = S × n / 50`. A whole
number means the score is reachable, and `k` is the tally that produced it. A fraction means
something slipped between the item table and the score line.

| Printed | n | k = S × n / 50 | Verdict |
|---|---|---|---|
| 75 | 2 | 3 | possible — 1 Pass + 1 Partial (15 points over 20) |
| 65 | 2 | 2.6 | impossible — two items on a 10/5/0 scale give only 0, 25, 50, 75, 100 |
| 72 | 10 | 14.4 | impossible — no ten-item tally produces 72 |
| 87.5 | 8 | 14 | possible — 7 Pass + 1 Fail, or 6 Pass + 2 Partial (70 points over 80) |
| 66.67 | 9 | 12.0006 → 12 within rounding | possible — 6 Pass + 3 Fail (60 points over 90) |
| 55.56 | 9 | 10.0008 → 10 within rounding | possible — 4 Pass + 2 Partial (50 points over 90) — **and still wrong** if the table beneath it shows 3 Pass + 2 Partial + 4 Fail, which is 40 points over 90 = 44.44 |

`k` fixes the point total, not the split: the 87.5 row shows two different tallies behind one
score. Confirm the split against the item table, not against `k`.

**The last row is the reason §7 opens with a recount and not with this check.** A tally that
miscounts one grade almost always lands on some *other* reachable tally, so its score is
attainable, `k` is a whole number, and this screen passes it. Only counting the rows catches it.
The cost of not counting is not a decimal: in a measured blind run of this skill on 2026-08-17,
that single 44.44-for-55.56 substitution in one 11.76%-weighted dimension carried a weighted
total of 39.80 up to 41.11 — across the 40 floor of the Low band, so the report printed a
rating its own item tables did not reach.

**Rounding is the one legitimate exception.** 50/n does not terminate for n = 3, 6, 7 or 9, so
an exact score such as 200/3 prints as 66.67 and fails a strict whole-number test. Run the
check on the exact value, and print the unrounded figure or the fraction beside the rounded
score so a reader can run it too. A figure a whole step away from every attainable value is a
defect; a figure a rounding unit away is a rounding artefact. If in doubt, recompute the score
from the item table rather than arguing about the decimal.

## 4. N/A shrinks the denominator; it never scores 0

**This is the only copy of the worked case.** It stood in both files until 2026-08-17, when the
duplicate came out of `SKILL.md` — two copies of one derivation are two places for it to drift,
and the rule it demonstrates (N/A Item Handling, steps 1–5) still sits there where the auditor
reads it. Authority dimension, 8 items N/A for want of site-level data, Brand Recognition
(`CORE-EEAT-A05`) Pass = 10 and Knowledge Graph Presence (`CORE-EEAT-A07`) Partial = 5:

| Method | Arithmetic | Result |
|--------|-----------|--------|
| Correct — exclude the 8 N/A items | (10 + 5) ÷ (10 × 2) × 100 | **75.0/100** |
| Wrong — N/A treated as Fail | (10 + 5) ÷ (10 × 10) × 100 | 15.0/100 (understates by 60) |

8 of the 10 items are N/A — past the >50% line — so Authority is additionally flagged
"Insufficient Data", excluded from the weighted total, and the remaining dimensions' weights are
re-normalised to sum to 100% (SKILL.md N/A Item Handling, rules 4–5). The 75.0 above is the
dimension score; it is not carried into the weighted total.

State the denominator beside the score, so the reader can apply §3 without reconstructing it —
**as a count and a reason, never as a list of item IDs**:

`Authority: 75/100 — 15 points over 2 scored items; the other 8 could not be evaluated (they
need site-level data we were not given)`

The reader learns how many items were scored, how many were excluded and why, which is what the
line exists to do. *Which* eight is already on the page: each sits in its own row of the tables
above, beside its plain-language name. A bare run of IDs in prose — `A01–A04, A06, A08–A10` —
is the referent form SKILL.md's Output Validation bans, because no plain-language name sits
against any of them and a client cannot act on it. Where the operator needs the IDs themselves,
to hand the run on or to hold the same denominators next quarter, they go in the labelled
`<!-- OPERATOR BLOCK … -->` fence in the hyphenated framework-first form (`CORE-EEAT-A01`),
never in the client's prose.

Scored + N/A = 10 in every dimension and 80 across the report, and the count and reason in the
prose have to match the N/A rows in the tables — same number of rows, same reason.

## 5. GEO, SEO and weighted figures

- **GEO and SEO scores** are means of four dimension scores. When all 40 items of that system
  are scored, each dimension is a multiple of 5, so the mean is a multiple of **1.25**. One
  renormalised dimension ends that property — from then on, check the mean by recomputing it
  from the four printed dimension scores.
- **Weighted contributions**: every published content-type weight is a multiple of 5%, so a
  fully scored dimension contributes a multiple of **0.25**, and the weighted total is a
  multiple of 0.25 when all eight dimensions are fully scored. Renormalised weights (N/A
  handling rule 5) end that property too; recompute from the printed weights instead, and
  check that the renormalised weights sum to 100%.
- **Potential gain** = the dimension points an item recovers × that dimension's weight.
  Recovering an item is worth 10 dimension points only when the dimension has all ten items
  scored; with `n` scored items a Fail→Pass flip moves the dimension score by `100/n` and a
  Partial→Pass flip by `50/n`. **Show all three factors on the Impact line** — the 100 or 50,
  the scored-item count it is divided by, and the weight it is multiplied by — so the rescale is
  visible where the number is written rather than only here. In the Authority example above, no
  fix inside that dimension moves the weighted total at all while it is excluded as Insufficient
  Data — the fix that pays there is supplying the missing site-level data, not raising an item.
- **The rating band is read off the final figure rounded to a whole number, half up.** The
  published bands have whole-number endpoints (90–100 Excellent · 75–89 Good · 60–74 Medium ·
  40–59 Low · 0–39 Poor) and a weighted mean is not a whole number, so unrounded there are four
  windows a computed total can land in that belong to no band — 39.80 is above the Poor range's
  39 and below the Low range's 40. Rounding closes all four **without moving an endpoint**: 39.80
  reads 40, Low. The rule and its worked veto case live in
  [references/core-eeat-benchmark.md](../../../references/core-eeat-benchmark.md) § 3; this file
  does not state a second convention.
- **Both figures are printed, and the rounded one never replaces the computed one.** Print the
  computed total with its derivation, at enough precision that a reader can see which side of the
  boundary it fell on and reproduce the rounding, and print the rounded total carrying the rating
  word — `39.80 → 40/100, Low`. The band is a label on the arithmetic, never a way of nudging it,
  and rounding is a reading step for the band alone: every check in § 7 runs against the computed
  figure, not the rounded one.
- **Precision follows the band's own endpoints.** These bands round to a whole number because
  their endpoints are whole numbers. The Link Quality Score in
  [monitor/backlink-analyzer/references/link-quality-rubric.md](../../../monitor/backlink-analyzer/references/link-quality-rubric.md)
  § 1 rounds to one decimal because its endpoints carry one. Do not harmonise them — one decimal
  here leaves 39.8 in no band, and a whole number there collapses three bands into two.
- These multiples are screens, not verdicts. They catch a slipped figure; they never certify
  one. The check that always applies is recomputing each figure from the numbers printed above
  it.

## 6. Veto outcomes override the arithmetic — do not "correct" them

- **One verified veto**: the final overall score is capped at 59 and the cap is flagged. 59 is
  a ceiling imposed on the arithmetic, not a figure the arithmetic produced — it will often
  not be an attainable value under §2 or §5, and that is correct. The uncapped figure may
  appear only labelled as what the score would have been without the veto.
  **Round first, then cap, and read the band off the same rounded figure.** A vetoed weighted
  total of 59.6 rounds to 60, which stands above the cap, so the cap binds and the report says
  **59, Low**. The defect the order prevents is checking the cap against one figure (59.6,
  already at or above 59, so "capped") and reading the band off another (60, Medium): a vetoed
  report printing 60/Medium has breached the cap however it got there.
- **Two or more verified vetoes**: BLOCK. Dimension scores may still be shown; there is no
  final score to check.
- **A veto item whose evidence is missing or unassessable**: no final score is issued at all.
- Per-item grades and dimension scores are unchanged by a veto. The cap moves the final
  figure only, so every table above it still has to satisfy §2–§5.

## 7. Pre-send recompute pass

Run this against the finished report, not against the working notes:

1. Each dimension score recomputes from its own item table — **count the Pass/Partial/Fail rows,
   never read the tally sentence beside them** — and any tally line agrees with the table it
   summarises. The score is then an attainable value for its scored-item count (§2–§3).
   **The attainability screen does not stand in for the recount**: a miscounted tally is usually
   itself a possible tally, so its score is attainable and the screen passes it (§3, last row).
2. Scored + N/A = 10 in each dimension and 80 in the report; every prose statement of how many
   items were not evaluated, and why, matches the N/A rows in the tables it describes — a count
   and a reason, not a list of item IDs (§4).
3. Every dimension with more than 5 N/A items is flagged Insufficient Data, excluded from the
   weighted total, and the remaining weights are renormalised to 100%.
4. GEO = mean of the four printed CORE scores; SEO = mean of the four printed EEAT scores; the
   weighted total reproduces from the printed dimension scores and weights. The computed total
   and its rounded form are both printed, and the rating word sits on the rounded one (§5).
5. If a veto fired: the reported final is the cap or is suppressed, and any uncapped figure is
   labelled as such. The cap and the band are read off the same rounded number (§6).
6. Every Top 5 gain equals `100/n × weight` for a Fail→Pass and `50/n × weight` for a
   Partial→Pass, where `n` is that dimension's scored-item count (§5) — **all three factors
   shown on the Impact line**, so the rescale is visible where the number is written and the
   abbreviation "recovered dimension points × weight" cannot be read as the flat form. The list
   is sorted descending by that figure, and a combined claim equals the sum of the gains it
   aggregates.
7. Where a sentence and a table disagree, the table wins — fix the sentence, and check whether
   the figures downstream of it (the dimension score, GEO, SEO, the weighted total and the
   rating band beside it) moved when it changed.
