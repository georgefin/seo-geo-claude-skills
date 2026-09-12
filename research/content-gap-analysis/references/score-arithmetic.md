# Gap Score Arithmetic — Which Figures Are Possible

Companion to [SKILL.md](../SKILL.md) Steps 4-9 and to §4 of
[gap-analysis-frameworks.md](./gap-analysis-frameworks.md). Nothing here changes the model: the
five factors, their 1-5 scales, the published weights, the P0-P3 tiers and the quick-win bands
are as defined there. This file states which numbers that machinery can and cannot produce, and
what each number has to show beside it, so any printed figure can be checked against the scale it
claims to come from.

**The rule this whole file serves:** every score in the deliverable prints its derivation next to
itself, in the deliverable, not in a working note. A ranked list whose order the reader cannot
reproduce from the rows above it is an assertion wearing a decimal point.

## 1. The chain of figures

| # | Figure | Composed from | Where defined |
|---|--------|--------------|---------------|
| 1 | Factor score (1-5) | One judgement per factor against its own band row, five per gap | frameworks §4 table |
| 2 | Gap Priority Score (1.00-5.00) | Σ (weight × factor score) over the five factors | frameworks §4 |
| 3 | Priority tier (P0-P3) | Read off figure 2, rounded to 2 dp | frameworks §4 |
| 4 | Quick Win Score (-8 to +8) | Demand + Relevance + Effort + Density − 12 | frameworks §4 |
| 5 | Competitor mean | Sum of the competitor columns ÷ number of competitor columns | frameworks §2/§3, templates |
| 6 | Gap Size | Your count − figure 5 | frameworks §3 |
| 7 | GEO Opportunity row | Figure 2, plus a GEO Value band, plus a tie-broken tier | §4 below |
| 8 | Combined cluster volume | Sum of the member gaps' volumes | frameworks §5 |
| 9 | Report tier (Tier 1/2/3) | Figures 3 and 4 together | §5 below |

Every other number in the report derives from these nine and has to reconcile with them.

## 2. Both scores add all their inputs

All five factors are scored so that **5 is the value most favourable to you**, including the two
that read as costs: Creation Effort 5 means "quick to create", Competitive Density 5 means "no
competitor covers it". Neither score subtracts anything.

The failure this prevents is not hypothetical. A Quick Win Score written as
`(Demand + Relevance) − (Effort + Density)` reads as if it penalises cost, but with these scales
it penalises *cheapness* and *emptiness* — the cheapest, least-contested gap on the list scores
the same as the most expensive, most-contested one, and a gap that is expensive and crowded
outscores both. The screen then ranks quick wins last. Before summing any scoring column of your
own, state in one line what a 5 means in each of its inputs and check that all of them mean the
same thing.

If a table elsewhere in the deliverable expresses a factor in the opposite direction — an
"Estimated Effort: High" column, for instance — say which score it maps to in the same row:
**High effort is Creation Effort 1, not 5.**

**One gloss changes on the proxy path.** Where Search Demand is proxied from competitor cluster
depth and Density is mirrored against it (`Density = 6 − Demand`), Density is no longer a count of
competitors: its top band arrives where they have published the fewest articles, never where none
has, so **"no competitor covers it" is not what the cell means there**. It reads as room left given
the depth already published, and the row says so. The figure itself is not adjusted — under
mirroring it is derived, so overriding it would change the score and not the gloss (frameworks §4).
The direction is unchanged: 5 is still the favourable value and the factor is still added, never
subtracted.

## 3. Gap Priority Score: attainable values and rounding

With the published weights (0.25 / 0.20 / 0.25 / 0.15 / 0.15) and integer factor scores:

```
Score × 100 = 25·Demand + 20·Density + 25·Relevance + 15·Effort + 15·Conversion
```

Every coefficient is a multiple of 5, so **the score is always a multiple of 0.05** in the range
1.00-5.00. The smallest step any single factor can make is 0.15, so nothing is attainable between
1.00 and 1.15 or between 4.85 and 5.00: **1.05, 1.10, 4.90 and 4.95 are unreachable**, and a
printed score at one of those values means a slip between the factor row and the total. Every
other multiple of 0.05 in the range is reachable.

**Rounding convention: round to two decimal places, halves up, read the tier off the rounded
figure, and print the unrounded figure beside it.** With the published weights the two agree; the
convention exists for the renormalised case, where the exact score does not terminate.

**Renormalised (Search Demand dropped, per frameworks §4):**

```
Score = (20·Density + 25·Relevance + 15·Effort + 15·Conversion) ÷ 75
```

a multiple of 1/15 ≈ 0.0667, still spanning 1.00-5.00 — and most of those values do not terminate
as decimals, since only the numerators divisible by 3 do. Print the fraction, or the unrounded
value, beside the rounded one — exactly as you would print the numerator and denominator of a
mean. The 0.15 boundary effect has an analogue here: the smallest step is 3/15 = 0.20, so nothing
is attainable between 1.00 and 1.20 or between 4.80 and 5.00.

**The reverse check.** Given a printed score `S` and its five factor scores, recompute
`Σ (weight × factor)` and compare. A disagreement of more than one rounding unit is a defect, not
a rounding artefact; recompute from the factor row rather than arguing about the decimal. A score
printed with no factor row beside it cannot be checked at all and is not deliverable.

## 4. GEO Opportunity Score: the three cells, defined

The GEO Opportunity table in [analysis-templates.md](./analysis-templates.md) carries three cells
that would otherwise be numbers with no scale behind them. They are:

**Traditional SEO Value** — the gap's own Gap Priority Score (§3 above), 1.00-5.00, printed with
its factor row. It is not a second, parallel score, and computing one would put two different
numbers on the same gap.

**GEO Value (1-5)** — a judgement against this rubric, scored from the content shapes in
frameworks §2 Step 4:

| GEO Value | The gap is | Why |
|-----------|-----------|-----|
| 5 | A definition, a direct question, or a head-to-head comparison | These shapes are already self-contained — the passage answers on its own and survives being lifted whole |
| 3 | Explainable in a self-contained passage, but scoped as a general article rather than a definition, Q&A or comparison | Liftable after restructuring, not as scoped |
| 1 | Useful only with the reader's own account, a login, a transaction or a physical visit | There is nothing for an engine to lift |

Score 2 and 4 by interpolation and say which neighbour you leaned toward. **This is an editorial
judgement against a stated rubric, not a measurement.** Say so in the report, in those words. It
is not an AI-citation count, and with no AI monitor connected no citation figure appears at all
(SKILL.md Step 7).

**Combined Priority** — the tier the gap already carries from its Gap Priority Score. Inside a
tier, order by that score; **where two scores tie, the higher GEO Value goes first**, and where
one gap is the tier's GEO play, say so in the row so the brief can be written for answerability.
GEO Value breaks ties; it does not overturn a score difference. **No blended number is computed.** There is no published exchange rate between a
point of SEO value and a point of GEO value, so any weighted blend would be a precise-looking
figure resting on an invented conversion (statistics rule: sourced, cited, or placeholder, never
invented). Two orderable numbers and a stated tie-break rule do the job a fake third number would
pretend to do.

## 5. Counts, means and the report tiers

- **Competitor mean** — the arithmetic mean of the competitor columns *actually counted in that
  table*, with n stated beside it ("mean of 2 competitor columns"). Never an industry average:
  this workflow counts the competitors you named and collects no industry population.
- **Gap Size** — `your count − competitor mean`, negative when they have more. Print both inputs
  on the same row so the subtraction is visible.
- **Funnel stage counts** — every page counted once, in exactly one of the four stages, and the
  stage counts sum to the total pages counted. State that total; a stage table that does not
  reconcile to it has double-counted a page or dropped one.
- **Combined cluster volume** — the sum of the member gaps' volumes, listed. When volumes do not
  exist for this run, the cell is not filled with a guess: write "volumes unavailable — clustered
  on topic, not volume" and let the cluster stand on its member count.
- **Report tiers** — Tier 1 Quick Wins, Tier 2 Strategic Builds, Tier 3 Long-term (SKILL.md Step
  9) are read from figures 3 and 4 together, and each tier states the rule it used: Tier 1 = P0 or
  P1 with a Quick Win Score of 2+; Tier 2 = P0 or P1 that missed the quick-win bar; Tier 3 = P2
  and P3. Where the quick-win screen did not run (Search Demand dropped), say so and read the
  tiers from the priority score alone.

## 6. Figures this skill cannot produce

Two numbers look like they belong in a gap report and are not derivable from anything the
workflow collects. Neither gets a cell.

- **A traffic projection for gap-filling content.** Searches are not sessions: what share of a
  keyword's volume becomes visits depends on the position you reach and the click-through rate at
  that position, and neither is known before you rank. Report the **combined search volume across
  the gap keywords** — a sum you can show — and say in the same breath that it is search volume,
  not traffic. Set a traffic target from the first published pages' own rank-tracker data instead,
  after roughly 90 days.
- **A competitor's traffic that you derived rather than read.** A competitor's traffic is not
  observable from outside their analytics, so every such figure is somebody's estimate and is
  labelled as one, with the tool and the date named. A tool's own per-URL estimate may be quoted
  that way; a site-level estimate may be quoted that way. What may never happen is **deriving one
  from the other** — apportioning a site total across their content types, dividing it by their
  page count, or attributing a share of it to an individual page. No export reports that split, so
  producing it invents it. Where the workflow collected only a site-level figure, report what you
  can count on their site instead — pages per section, articles per cluster, videos in a series,
  each type's share of their page total — and say it is a count.

The absence is stated in the report in plain words. A cell whose only honest value is a
bracket token does not survive into a deliverable (the Value Rule): drop the cell, name what it
would have taken to fill it, and say what the client would have to send.

## 7. Pre-send recompute pass

Run this against the finished report, not the working notes.

1. Every Gap Priority Score recomputes from the factor scores printed on its own row, and is an
   attainable value under §3 **for the weight set that row actually used**. The two sets have
   different attainable values, so a score tested against the wrong one reads as an arithmetic
   error when it is correct:
   - **All five factors scored, published weights** — a multiple of 0.05, and not 1.05, 1.10, 4.90
     or 4.95.
   - **Search Demand dropped, renormalised weights** — a multiple of 1/15 ≈ 0.0667, and not 16/15,
     17/15, 73/15 or 74/15 (1.07, 1.13, 4.87 and 4.93 rounded). Most of these are not multiples of
     0.05: the renormalised 19/15, printed 1.27, is a correct score that the published-weight test
     would reject. Check the fraction or the unrounded value printed beside the rounded figure,
     never the 2 dp figure alone.
   - **Any other factor dropped** — a third attainable set, on its own denominator: drop either
     0.25 factor and the step is 1/15, drop Competitive Density and it is 1/16, drop either 0.15
     factor and it is 1/17. Derive the step from the renormalised weights before testing anything
     against it.
2. Every tier reads correctly off its rounded score under the §4 tier table; no gap sits in a
   tier its score does not support.
3. Every Quick Win Score is an integer in -8 to +8 and equals the sum of its four factors minus
   12; where Search Demand was dropped rather than proxied, no Quick Win Score appears and the
   report says the screen did not run. Where it was **proxied from the same competitor count
   Competitive Density reads**, the row says so and says the two legs cancelled — with mirrored
   bands `D + (6 − D) = 6`, leaving `Relevance + Effort − 6`, a −4 to +4 quantity read against
   bands built for −8 to +8 (frameworks §4).
4. Where a factor was dropped, the renormalised weights are printed, they sum to 1.00, and the
   dropped factor is named. Where a factor was proxied, the proxy's basis is named **and the demand
   floor that proxy set is printed in the proxy's own units** — a proxy with no floor left the gap
   filter empty, and neither score re-applies it (frameworks §1 Step 4, §4). Every row scoped
   narrower than the floor's unit prints **both readings** — the cluster's, which the Demand cell
   was scored from, and its own subject's — and names which one cleared the floor, so no row passes
   on inherited demand evidence unseen. And on a mirrored proxy path no Competitive Density cell is
   reported as "no competitor covers it": every scored gap cleared a floor that guarantees
   competitor coverage, so a row printing Density 5 prints the re-glossed reading beside it rather
   than suppressing the value, which would change the score (§2 above).
5. Every mean states its n; every Gap Size shows both inputs; the funnel stage counts sum to the
   stated total. **Every count in prose names the rows it counted, and every superlative or "the two
   lowest / the largest" claim names each row tied at the extreme** — "three depth gaps: A, C, F",
   "the lowest Conversion Potential: B, D and G at 1 each". This is the derivation half of item 8:
   the check below catches a sentence that already disagrees with its table, and this stops it being
   writable, because a writer who has to list the rows counts them. It is the same rule the Gap
   Priority Score obeys when it prints its factor row — a count over the report's own rows is a
   derived figure, and a derived figure carries its derivation.
6. Every GEO Value carries the rubric band it was scored against and is labelled a judgement; no
   blended SEO+GEO number appears.
7. No traffic projection and no competitor per-page or per-type traffic figure appears anywhere.
8. Where a sentence and a table disagree, the table wins — fix the sentence. This one is repeated
   deliberately, because this pass runs while the scores are computed and the breach happens later,
   while the prose about them is written. It therefore stands at **four** sites and they are one
   rule — change them together: here; SKILL.md → **Content Gap Report**, as a pre-send check in the
   output-format section; `analysis-templates.md` → **Prioritized Report Template**, against the
   two prose slots that fail it most often, *Key Findings* and *Why prioritize*; and, since 4.5.0,
   inside that template's own *Key Findings* block as an HTML comment, because the check has to
   reach the writer at the moment the sentence is drafted and a model copies the fence, not the
   prose beside it. Two further instances of the class shipped after the three-site placement —
   which is why item 5 now carries the derivation half: a count that names its rows is the part
   a re-read cannot be relied on to catch.
