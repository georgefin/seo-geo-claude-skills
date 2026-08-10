# Metric Derivations — Every Figure This Skill Emits

Companion to [SKILL.md](../SKILL.md)'s Metric Derivation Contract. Nothing here changes what the
skill measures; it states, for each number the templates can print, **how it is reached, over
what population, at what precision, and what happens when its input was never collected** — so
any printed figure can be rechecked against the line it sits on.

The rule the whole file serves: *a number goes into a deliverable with its derivation beside it,
or it does not go in.* A figure a reader cannot recompute is an assertion wearing a decimal
point.

---

## 1. The figures this skill can produce

| # | Figure | Formula | Inputs, and where they are collected |
|---|--------|---------|--------------------------------------|
| 1 | Position | observed, not computed | Connected rank tracker, GSC export, or a manual check (step 1) |
| 2 | Change | `new position − old position` | Two dated snapshots (step 1's persistence contract) |
| 3 | Average position | `Σ positions ÷ n` over a named population | Positions from one check, same population on both dates |
| 4 | Band counts (#1, 1-3, 1-10, 11-20 …) | count of tracked keywords in the range, inclusive | One check's positions |
| 5 | Distribution share | `band count ÷ N × 100` | Band counts + N tracked keywords |
| 6 | Stable-keyword count | keywords moving ≤2 positions that stay on the same page | Two snapshots |
| 7 | Position gap | `current average position − 1` | GSC average position (step 2) |
| 8 | Opportunity — primary | `(Volume × Intent Value) ÷ Difficulty` | Volume and Difficulty from a connected SEO tool; Intent Value supplied by the user |
| 9 | Opportunity — fallback | `Impressions × Position Gap` | GSC impressions + average position |
| 10 | Feature ownership count | count of observed SERPs where the feature is held by a tracked URL | Step 5 observations |
| 11 | Feature opportunity | `your count − competitor average` | Feature counts for you and the tracked competitors |
| 12 | AI Overview presence rate | `keywords showing an AI Overview ÷ keywords whose SERP was observed` | Step 6 observations |
| 13 | AI citation rate | `keywords citing you ÷ keywords showing an AI Overview` | Step 6 observations |
| 14 | Average citation slot | `Σ slots ÷ k` over the AI Overviews citing you | Step 6 observations |
| 15 | Top-10 share of voice | `keywords where the domain holds positions 1-10 ÷ N tracked` | Same keyword set and date for every domain (step 7) |

Every other number in a rank-tracker deliverable is one of these, a difference between two of
them, or a figure this skill does not define (§4).

## 2. Rounding and precision

| Figure | Precision | Rule |
|--------|-----------|------|
| Positions from a tracker or manual check | whole number | Positions are ordinals; do not average them into the source column |
| Positions from GSC | 1 decimal | GSC reports an average, so keep its decimal — 18.9 is not 19 |
| Change between whole positions | whole number | Exact by construction |
| Change between averages | 1 decimal | Compute on the unrounded values, then round the result once |
| Average position | 1 decimal | Print the sum and the count beside it: `554/36 = 15.4` |
| Percentages | whole number | Print the fraction beside it: `9/40 = 23%` (exact 22.5, halves away from zero) |
| Opportunity | whole number | Compute unrounded, print the multiplication: `840 × 8.0 = 6,720` |
| Average citation slot | 1 decimal | Only over the AI Overviews that cite you |

Three conventions that stop the common slips:

- **Round once, at the end.** Rounding an input and then computing turns a rounding artefact
  into a reported movement.
- **Banding a rounded value.** Where a decimal change is banded against the response protocol,
  round to the nearest whole position with halves away from zero (a 2.5 drop bands as 3), then
  band. Say which value was banded.
- **Rounded shares need not total 100.** Say so once; the counts are the figure of record.

## 3. Population rules — the failure this skill is most prone to

An average or a count means nothing until its population is named, and the population moves:
keywords enter the tracked set, keywords stop ranking, a check misses a SERP.

1. **Comparing two dates: hold the population constant.** Use the keywords ranked on *both*
   dates, state `n`, and list the entrants and departures separately. A keyword entering at
   position 38 raises the mean by itself; reporting that as a ranking decline describes an
   arithmetic event as a search event.
2. **When a constant population is not available**, either print the all-ranked figure *with*
   the distortion named beside it, or print no average and say the new entrant forced the
   omission. Silently dropping the aggregate is the one move that is never acceptable — the
   reader cannot tell an omission from an oversight.
3. **A keyword with no prior position is a New Ranking**, never a numeric change from an assumed
   baseline (position 50, position 100, "off the chart"). The assumed baseline is invented data
   and it propagates into every average built on it.
4. **Not-checked is not zero.** A SERP that was not observed is outside the denominator of a
   feature or AI-citation rate, not a negative observation inside it.
5. **Counts state their denominator inline**: `6 of the 10 tracked keywords`, not `6 keywords`.

## 4. Figures this skill does not define — and what goes in their place

Naming these is as load-bearing as the formulas above: each is a number a reader expects, and
each is one this skill has no honest way to produce.

| Not defined | Why | What to print instead |
|-------------|-----|-----------------------|
| Visibility score | Needs a position-CTR curve this library cannot source | A connected tool's own visibility figure, labelled with the tool's name — or the countable top-10 share of voice (§1 row 15) |
| Position-CTR curve | The setup guide's position-vs-traffic ranges are unsourced and tagged (§6 of that guide) | The guide's range, cited as the guide's generic estimate, never as this site's measured loss |
| Traffic or clicks impact for a keyword | Requires a measured click baseline for the URL | With a baseline: the baseline, the band applied, and the label. Without: delete the column and name the export that would restore it |
| Revenue, conversions, sales uplift | Requires conversion data this skill never collects | A sentence naming the data that would ground it — never a projection |
| Competitor traffic | Not observable from position data | Their positions, which are observed |

The house move in every row is the same, and it is the one the Output Validation checkpoint
states: where no tool was connected and nothing was supplied, say so plainly and leave the
figure out. An absent number with a named gap is a finding. An invented one is a defect that
survives into every report built on it.

## 5. Bands — house conventions, stated as such

These are conventions of this library, not engine-documented thresholds, and each is written to
be **complete** (every case lands somewhere) and **disjoint** (no case lands twice).

- **Response protocol** (SKILL.md): page-1 exit first and overriding, then drop sizes 1-2 / 3-4 /
  5-10 / 11+, then gains. The precedence matters: a #10 → #11 move is a 1-position drop *and* a
  page-1 exit, and the two rows prescribe opposite responses. The page-1 row wins.
- **Alert thresholds** (setup guide §4): the normal band and the alert threshold do not meet;
  what falls between them is reported in the weekly summary without firing an alert.
- **Winnable** (featured snippets) and **Threat level** (competitor movement): defined in the
  templates file against observable facts, with the observation printed in its own column. A
  band with no stated observation behind it is an opinion in a table cell.

## 6. Pre-send recompute pass

Run this against the finished deliverable, not the working notes:

1. Every average, count and percentage prints its arithmetic and its population, and recomputes
   from the numbers printed beside it.
2. The sign convention is stated once and holds in every table — no report mixes a signed delta
   with a "+13 = improvement" column.
3. Any two-date comparison names its population and lists entrants and departures outside the
   aggregates.
4. Every Opportunity figure reproduces from its own printed multiplication, and one formula
   governs the whole ranked list.
5. No cell holds a bracket token, `TBD` or `XX`: an uncollected input means the row or column is
   gone and the gap is named in prose.
6. Every figure's source is resolved — a tool's real name, the plain-language origin, or an
   explicit statement that nothing was collected. No `~~category` token anywhere the client
   reads, the snapshot's data-source column included.
7. Run handles appear only inside the operator handoff block; the client-facing prose names jobs.
8. Where a sentence and a table disagree, the table wins — fix the sentence.
