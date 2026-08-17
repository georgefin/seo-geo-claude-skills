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

`k` fixes the point total, not the split: the 87.5 row shows two different tallies behind one
score. Confirm the split against the item table, not against `k`.

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

State the denominator beside the score, so the reader can apply §3 without reconstructing it:
`A Score: 75/100 — 15 points over 2 scored items; A01–A04, A06, A08–A10 N/A (requires
site-level data)`. Scored + N/A = 10 in every dimension and 80 across the report, and the N/A
list in the prose has to match the N/A rows in the tables.

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
  Partial→Pass flip by `50/n`. In the Authority example above, no fix inside A moves the
  weighted total at all while A is excluded as Insufficient Data — the fix that pays there is
  supplying the missing site-level data, not raising an item.
- These multiples are screens, not verdicts. They catch a slipped figure; they never certify
  one. The check that always applies is recomputing each figure from the numbers printed above
  it.

## 6. Veto outcomes override the arithmetic — do not "correct" them

- **One verified veto**: the final overall score is capped at 59 and the cap is flagged. 59 is
  a ceiling imposed on the arithmetic, not a figure the arithmetic produced — it will often
  not be an attainable value under §2 or §5, and that is correct. The uncapped figure may
  appear only labelled as what the score would have been without the veto.
- **Two or more verified vetoes**: BLOCK. Dimension scores may still be shown; there is no
  final score to check.
- **A veto item whose evidence is missing or unassessable**: no final score is issued at all.
- Per-item grades and dimension scores are unchanged by a veto. The cap moves the final
  figure only, so every table above it still has to satisfy §2–§5.

## 7. Pre-send recompute pass

Run this against the finished report, not against the working notes:

1. Each dimension score recomputes from its own item table and is an attainable value for its
   scored-item count (§2–§3).
2. Scored + N/A = 10 in each dimension and 80 in the report; the prose N/A list matches the
   tables.
3. Every dimension with more than 5 N/A items is flagged Insufficient Data, excluded from the
   weighted total, and the remaining weights are renormalised to 100%.
4. GEO = mean of the four printed CORE scores; SEO = mean of the four printed EEAT scores; the
   weighted total reproduces from the printed dimension scores and weights.
5. If a veto fired: the reported final is the cap or is suppressed, and any uncapped figure is
   labelled as such.
6. Every Top 5 gain equals recovered dimension points × weight, the list is sorted descending
   by that figure, and a combined claim equals the sum of the gains it aggregates.
7. Where a sentence and a table disagree, the table wins — fix the sentence.
