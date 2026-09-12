# CITE Score Arithmetic — How Every Derived Figure Is Composed

Companion to [SKILL.md](../SKILL.md) Step 2-4. A CITE audit's entire deliverable is numbers,
and most of them are **derived** — computed from the report's own grades and weights rather
than copied from the client's data. This file states how each one is composed so the report
can show its working and so a reader can check it.

Nothing here changes the framework. The 40 items, the 4 dimensions, the domain-type weights,
the three veto items (T03, T05, T09) and the veto consequence (CITE Score capped at 39 /
Poor, plus a **Manipulation Alert**) are as defined in
[references/cite-domain-rating.md](../../../references/cite-domain-rating.md). This file only
makes the existing mechanic show its arithmetic.

## 1. The chain, in order

| # | Figure | Composed from |
|---|--------|---------------|
| 1 | Item points | Pass = 10 · Partial = 5 · Fail = 0 |
| 2 | Dimension score (0-100) | Sum of that dimension's ten item points |
| 3 | Weighted contribution | Dimension score × that dimension's domain-type weight |
| 4 | CITE Score | Sum of the four weighted contributions |
| 5 | Rating label | The CITE Score rounded half up to a **whole number**, read off the rating scale (§2) |
| 6 | Reported score | The CITE Score, or 39 if a veto item Fails (§4) |

Everything else in the report — tallies, points-lost sums, potential gains, projections — is
a further derivation from these six and must reconcile with them.

**Show the tally next to the score.** `C Score: 70/100 — 4 Pass + 6 Partial + 0 Fail =
40 + 30`. The three counts always sum to 10 (or to the scored-item count, §3). A dimension
score with every item graded is therefore always a multiple of 5; a figure like 72/100 cannot
be produced by ten items scored 10/5/0 and signals a slipped tally.

## 2. The weighted total and its rounding

Write the products, then the unrounded sum, then the rounded score:

```
CITE Score = 70 × 0.40 + 55 × 0.15 + 80 × 0.20 + 65 × 0.25
           = 28.0 + 8.25 + 16.0 + 16.25
           = 68.5 → 68.5/100, band read off 69 → (Medium)
```

There are **two roundings here and they do different jobs**. Keep them apart.

- **The reported score is rounded half up at one decimal.** 69.95 → 70.0, not 69.9. Truncation
  is the common slip. This is a presentation precision: it is the figure the client reads and
  reproduces from the products above it.
- **The rating band is read off the score rounded half up to a whole number** — 68.5 → 69,
  Medium — on the scale 90-100 Excellent | 75-89 Good | 60-74 Medium | 40-59 Low | 0-39 Poor.
  The band endpoints are whole numbers, so a one-decimal figure can land in no band at all:
  **39.8 is above Poor's 39 and below Low's 40, and rounding it to one decimal leaves it exactly
  where it was.** Only the whole-number rounding closes those four windows, and it closes them
  without moving an endpoint. The rule is stated once, in
  [references/cite-domain-rating.md](../../../references/cite-domain-rating.md) § 3; this file
  does not hold a second convention.
- **Round once, from the computed figure.** The band comes off the computed sum rounded straight
  to a whole number — never off the one-decimal reported figure rounded a second time. Chaining
  them moves a band: a computed 74.46 rounds to 74, Medium, but via 74.5 it becomes 75, Good.
  This is § 5's chained-rounding warning applied to the band instead of to a gain.
- **Always print the unrounded sum** as well as the rounded score. It is what lets a reader
  reproduce the figure, and it removes any dependence on which rounding convention they hold.
  The rounded band input never replaces it.
- In a Greek-language report the decimal separator is a comma («68,5»). The arithmetic is
  identical and the comma is not a defect.

## 3. N/A items — the denominator shrinks, the item never scores 0

An item that cannot be evaluated is marked `N/A — requires [data source]` and **excluded from
its dimension's average**. Excluding is not the same as scoring zero:

```
dimension score = points earned ÷ (10 × scored items) × 100
```

Worked case — C with C05-C08 N/A (no AI-citation data of any kind), six items scored
1 Pass + 4 Partial + 1 Fail:

| Method | Arithmetic | Result |
|--------|-----------|--------|
| Correct — exclude | (10 + 20 + 0) ÷ (10 × 6) × 100 | **50.0/100** |
| Wrong — N/A as 0 | (10 + 20 + 0) ÷ 100 × 100 | 30/100 (understates by 20) |

State the denominator beside the score: `C Score: 50.0/100 — 30 pts over 6 scored items;
C05-C08 N/A (no AI-citation test run)`. Rescaled dimension scores are usually not multiples
of 5, and that is expected. Report how many of the 40 items were scored and how many were
N/A, and make sure that count matches the item tables (34 + 6 = 40).

**The shrunken denominator rescales every gain in that dimension too**, not just its score — one
raw item point is worth more when fewer items share the denominator. §5 carries the factor.

## 4. Veto cap — an override, not a term in the sum

A Fail on T03, T05, or T09 caps the reported CITE Score at 39 (Poor) and raises a
**Manipulation Alert**. Compute the weighted score normally first, then apply the cap:

- The cap is a ceiling. A weighted figure above 39 is reported as 39; a weighted figure
  already below 39 stands as it is. Either way the Manipulation Alert is raised.
- **Round first, then cap, and read the band off the same rounded figure.** A vetoed weighted
  total of 39.6 rounds to 40, which stands above the cap, so the cap binds and the report says
  **39, Poor**. The defect the order prevents is checking the cap against one figure (39.6,
  already above 39, so "capped") and reading the band off another (40, Low): a vetoed report
  printing 40/Low has breached the cap however it got there.
- The uncapped figure may appear **only** labelled as what the score would have been without
  the veto — never as the score. It still has to recompute from the dimension table.
- Per-item grades and dimension scores are unchanged by a veto. The cap changes the final
  score, not the tables.
- More than one veto still caps at 39. CITE has no BLOCK verdict and no 59 cap — those are
  CORE-EEAT's mechanics and importing them into a CITE report is an error.

## 5. Potential gain, and the sum of several gains

A potential gain is a **score movement**, so it is computed the way the score is computed. §3
makes a dimension score `points earned ÷ (10 × scored items) × 100`, so one raw item point moves
that dimension by `10 ÷ n` score points, where `n` is the dimension's **scored-item count**.
Carry that factor into the weighting:

```
potential gain = recoverable points × (10 ÷ n) × that dimension's weight
  recoverable points = 10 from Fail, 5 from Partial
  n                  = that dimension's scored items — 10 unless N/A shrank it (§3)
```

**Write all three factors, with the denominator named** — `5 × (10 ÷ 6 scored) × 25% = 2.08`.
The middle factor is `(10 ÷ 10 scored) = 1` wherever a dimension has all ten items graded, and
printing it anyway is the visible proof that the scored-item count was checked. Dropping it is
safe **only** at `n = 10`; below that it understates every gain in that dimension — by 20% at
`n = 8`, 40% at `n = 6`, 50% at `n = 5`, 70% at `n = 3`, and without bound as `n` shrinks. It
understates hardest where the data is thinnest, which is exactly where the Top 5 carries the
most weight and where the N/A machinery exists to help.

Worked A — E-commerce weights (C 20% / I 20% / T 35% / E 25%), all 40 items scored:

| Item | Current | Recoverable | n | 10 ÷ n | Weight | Gain |
|------|---------|:-----------:|:-:|:------:|:------:|:----:|
| T06 | Partial | 5 | 10 | 1 | 35% | 1.75 |
| I05 | Fail | 10 | 10 | 1 | 20% | 2.00 |
| T08 | Partial | 5 | 10 | 1 | 35% | 1.75 |

Worked B — **the same three items on a rescaled audit**: T04 is N/A so T has `n = 9`, and I01 is
N/A so I has `n = 9`. Not one grade changed; only the denominators did.

| Item | Current | Recoverable | n | 10 ÷ n | Weight | Gain |
|------|---------|:-----------:|:-:|:------:|:------:|:----:|
| T06 | Partial | 5 | 9 | 1.1111 | 35% | 1.94 |
| I05 | Fail | 10 | 9 | 1.1111 | 20% | 2.22 |
| T08 | Partial | 5 | 9 | 1.1111 | 35% | 1.94 |

Check T06 against the dimension table rather than against the formula: T earning 55 points over
its 9 scored items scores 61.11; flip T06 to Pass and it earns 60 over 9 = 66.67. The move is
`100 × 5 ÷ 90 = 5.5556` dimension points, worth `5.5556 × 0.35 = 1.94` CITE points — the figure
the formula gives. Multiply the *rounded* 5.56 instead and you get 1.95: chain your rounding and
the check stops agreeing with the thing it is checking. The unrescaled form prices that identical
fix at 1.75 and under-sells it by 10%.

**Round each gain half up at two decimals wherever the second decimal carries information.** A
rescaled gain is rarely a round number, and cutting 2.08 to 2.1 breaks the sum below. A gain that
is exact at one decimal — 2.0, 0.75 — needs no padding.

**A combined claim equals the sum of its parts, added as printed.** T06 + I05 is worth **3.75**
on Worked A and **4.16** on Worked B; adding T08 reaches **5.50** and **6.10**. Writing "these
fixes capture more than five points" overstates either pair — and the T08 line holds only if
the action prescribed for T08 can actually flip that item. If the report's own T08 row says the
grade is driven by content age, a footer fix cannot claim T08's gain. Claim the gain of the item
your action actually moves. **Add the printed gains, not a hidden unrounded register**: Worked
B's three gains total 6.1111 unrounded, and 6.11 is a figure no reader can reproduce from the
column above it — `1.94 + 2.22 + 1.94 = 6.10` is.

**An N/A item has no potential gain.** It has no grade to recover from, and measuring it moves
the denominator as well as the numerator — `n` becomes `n + 1` — so no single multiplication
prices it. That is a projection, and §6 recomputes both of its endpoints instead.

The Top 5 is sorted by this same figure, descending. Sort by the numbers after you have
computed them, not by the order you found the items in.

## 6. Projections and sensitivity brackets

If the report projects what the score becomes under a different grade for an item, recompute
**both endpoints** from the dimension table — do not estimate the swing.

Worked case — E06 N/A, E's nine scored items earning 60 points, E weight 25%:

| Scenario | E dimension | CITE contribution | CITE Score |
|----------|-------------|-------------------|------------|
| Reported (E06 N/A) | 60 ÷ 90 × 100 = 66.67 | 16.67 | 70.17 → 70.2 |
| E06 proves Fail | 60 ÷ 100 × 100 = 60.0 | 15.0 | 68.50 |
| E06 proves Pass | 70 ÷ 100 × 100 = 70.0 | 17.5 | 71.00 |

Only E moves, so C + I + T contribute the same 53.50 in all three rows — which is what makes
each CITE Score in the last column checkable. The bracket is **68.50 to 71.00** and its width is **2.50 points** — the difference of the
two endpoints the report itself just stated, which is also 10 E-points × 25%. A stated range
that does not equal the gap between its own endpoints is a defect regardless of how plausible
it sounds.

**Why this is not §5's gain formula, and how the two reconcile.** E06 is *unmeasured*, not
failed. Resolving it moves `n` from 9 to 10 as well as the points earned, and the figure it moves
away from (66.67) is itself a rescaled number — so the move from the reported row to the
E06-proves-Pass row is 70.17 → 71.00, **0.83 CITE points**, not the 2.50 that pricing 10
recoverable points at E's weight would report. §5 prices a **graded** item improving inside a
fixed denominator; §6 prices an **ungraded** item entering the denominator. They are two
operations, not two answers to one. The 2.50 above is the gap between two endpoints that both
have `n = 10`, where §5's `10 ÷ n` factor is 1 — which is exactly why 10 raw item points buys 10
dimension points there and would not at any smaller `n`.

## 7. Counts and tallies in prose

Prose counts are derived figures too, and they fail more often than the score does because
nobody recomputes a sentence.

- **Count the IDs you typed.** "the four C-dimension Partials (C04, C05, C06, C07, C09)" —
  five IDs, called four.
- **Keep one number per fact.** "8 Partials (…nine Partials, 45 points)" contradicts itself
  inside one sentence; and 45 points is 9 × 5, so the list, not the count, was right.
- **Points available, scored and lost must close.** With all 40 items scored the raw pool is
  400. Scored + lost = 400, and lost = (Partials × 5) + (Fails × 10). With N/A items the pool
  is 10 × scored items — say so rather than leaving 400 standing.

## 8. Pre-send recompute pass

Run this after the report is written, against the finished tables:

1. Each dimension score = its own item tally, and the tally counts sum to the scored items.
2. Scored + N/A = 40, and the N/A list in the prose matches the N/A rows in the tables.
3. The weighted sum reproduces from the four dimension scores and the stated weights; the
   unrounded figure is printed; the rating label matches the computed figure rounded once to a
   whole number (§2), not the one-decimal reported figure rounded a second time.
4. If a veto fired: reported score is the cap, the uncapped figure is labelled as such, the cap
   and the band are read off the same rounded number (§4), and the Manipulation Alert is present.
5. Every Top 5 gain = recoverable points × (10 ÷ that dimension's scored items) × weight, with
   all three factors shown; the list is sorted descending; any combined claim equals the sum of
   the gains **as printed**; and no N/A item is priced as a gain — it is projected under §6.
6. Every projection's endpoints and range recompute; every prose count matches its own list.
7. Where a sentence and a table disagree, the table wins — fix the sentence.

## 9. Defect shapes this file exists to prevent

Observed in this skill's own eval deliverables during the 2026-08-10 blind Mode B run and in
the executor-phase correction logged in the preceding informed run — the first four are derived
figures that no source-data check would catch, because every input metric was traced
correctly. The fifth was found in **this file**, on 2026-08-17: §5 stated the gain formula
without its `10 ÷ n` factor, so the rule a writer copied was wrong in any dimension carrying an
N/A item and right in every worked example, all of which scored all ten.

| Shape | What it looked like | Fix |
|-------|--------------------|-----|
| Self-contradicting tally | "60 lost points … 8 Partials (nine listed, 45 points)" | Recount from the table; one number per fact |
| Wrong pool | "400 raw points available; 340 scored" against tables totalling 335 | Scored + lost = pool |
| Miscounted enumeration | "the four C-dimension Partials" followed by five IDs | Count the IDs typed |
| Unrecomputed bracket | A sensitivity range whose endpoints and width were all three wrong | Recompute both endpoints; range = their difference |
| Unrescaled gain | A Top 5 gain priced `recoverable × weight` in a dimension with N/A items | Multiply by `10 ÷ scored items`; at six scored the shortcut loses 40% |
