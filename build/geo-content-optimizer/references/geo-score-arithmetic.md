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
| 1 | 1, 10 |
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
| Source citations | claims **resolved**: carrying a named, dated, checkable source — or removed, converted to first-party, or hedged, with the disposition named in the report (§3.1) | claims that need one (your own claim inventory) |
| Q&A format | target queries answered by a matching heading plus a direct standalone answer | target queries from step 1, capped at 5 |
| Authority signals | authority elements actually present: byline with credentials · sourced expert quote · first-party data · named methodology | the ones this client can genuinely supply — not all four by default |
| Content freshness | visible publish/update date within 12 months · no **time-sensitive** figure older than 24 months (§3.2) | 2 — or 1 where the staleness half does not apply, or N/A where neither half does (§3.2) |
| Structure clarity | headings matching query phrasing · 3–5-sentence chunks · a table wherever a comparison exists · a numbered list for any process · a summary box | 5, minus any element the page has no occasion for (see N/A below) |

**A factor with nothing to count is N/A, not a 1.** If `asked` would be 0 — the page makes no
comparison, so no table is owed; the client has no first-party data and no expert to quote —
mark the factor N/A, name the reason in the row, and exclude it from both the sum and the
divisor. Scoring an inapplicable factor 1 understates the page and inflates the lift.

### 3.1 Source citations — it measures unsourced claims left standing

**What the factor is for**: whether the page still asserts something no reader can check. It is
sourcing hygiene, not citation volume — the count of citations is a different instrument's job
(factual density counts data points; the ≥1-citation-per-500-words threshold is a step 5 check
row).

**The defect this replaces.** `met` used to count sourced claims only, against an `asked` fixed
at step 2. The skill *mandates* removing a claim it cannot source, and removing one moved
neither operand: the claim left the page but stayed in the denominator, and the score sat at 1
in both columns. Obeying the rule scored nothing, and the only way to move the number was to
keep the claim and hang a source on it — the behaviour the Statistics rule bans. **A scoring
rule that rewards the banned behaviour is worse than no rule.**

**The fix widens `met`; it does not shrink `asked`.** That choice is deliberate — shrinking the
denominator would break §8 item 5 (both columns must use the same `asked`) and would open a
worse hole, where cutting every claim drives `asked` to 0 and the factor to N/A.

A claim counts as **met** when it is *resolved*, by any of the four dispositions the skill's
claims ladder allows, in its order:

1. it carries a named, dated, checkable source;
2. it was converted to a first-party statement the client can stand behind;
3. it was kept explicitly unquantified — hedged, with no number attached;
4. it was cut.

The **before** column counts route 1 only: at step 2 nothing has been done yet. The **after**
column counts all four.

Two guards, and the factor does not work without them:

- **A disposition counts only when the report names it** — which claim, which route, and for a
  cut, the data that would put it back. An unrecorded deletion is not met; otherwise deleting
  quietly is free points, and the client never learns a claim left their page.
- **`asked` stays the step-2 claim inventory in both columns.** It never shrinks because
  claims were removed.

The factor is now **indifferent between sourcing a claim and disposing of it properly** — both
are compliant outcomes, and the indifference is the whole point: an operator optimising the
number gains nothing by keeping a claim alive in search of a weak source. The counter-pressure
against gutting the page lives where it belongs — cut too much and factual density, quotable
statements, clear definitions and Q&A coverage all fall.

If the page makes no claim needing a source at all, `asked` is 0 and the factor is N/A per the
rule above.

### 3.2 Content freshness — it measures currency signals, not the age of every number

**What the factor is for**: whether a reader (or an engine) can tell the content is current,
and whether anything on it has since gone out of date.

**The two defects this replaces.** "No data point older than 24 months" was **vacuously true on
a page with no data points at all** — nothing to go stale scored half the factor, producing a 6
that meant nothing. And a **founding year is a data point older than 24 months that is not
stale data**: the old wording flagged it, which is why the check was unusable as written.

**Time-sensitive is the distinction.** A figure is time-sensitive when re-measuring it today
could produce a different answer: prices, counts, volumes, rates, shares, performance
measurements, anything with an implied "as of". A figure is **not** time-sensitive when it is a
historical fact fixed to its date — a founding year, the date of an event, the year a
regulation took effect, a model year, the start of a tenure. Those do not age; the date *is*
the fact. Only time-sensitive figures are checked for staleness.

**Scope, which sets `asked`:**

| The page **or the supplied data** carries | `asked` | The factor scores |
|---|---|---|
| a visible date **and** ≥1 time-sensitive figure | 2 | date within 12 months · no time-sensitive figure older than 24 months |
| a visible date, **no** time-sensitive figure anywhere | 1 | the date alone — the staleness half is N/A and the row says so |
| ≥1 time-sensitive figure, **no** date available (or confirmed unavailable per the skill's Input Validation) | 1 | the staleness half alone — the date half is N/A and the row says so |
| neither | N/A | nothing — excluded from sum and divisor, never scored 1 |

At `asked = 1` the factor is pass/fail: 1 or 10, nothing between (§2). That is honest — one
signal can only tell you one thing.

**Counting the staleness half, per column.** It is met when the version being scored carries at
least one time-sensitive figure **and** none of them is older than 24 months. A version
carrying none does **not** meet it — that is the second place the old vacuity hid. The half is
only ever in scope because figures exist or are about to; "no figures yet" is the gap the
optimization closes, not a pass. Where the page genuinely has nothing that can go stale, the
scope table above has already taken the half out.

**`asked` is still fixed once.** The scope test reads the inbound page **and** the data block
the client supplied, both of which are known at step 2, so a time-sensitive figure the
optimization is about to add was already in scope. The denominator does not move between the
columns.

**Print the scope, not just the count**: "1 of 1 — update date visible; the page carries no
time-sensitive figure, so the staleness check does not apply."

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
| Source citations | 1 | 10 | +9 | 3 of 3 claims resolved — 2 now name a checkable source, 1 was cut with the missing data named (was 0 of 3) |
| Q&A format | 1 | 10 | +9 | 4 of 4 target queries have a heading and a direct answer |
| Authority signals | 4 | 7 | +3 | 2 of 3 available: byline with credentials, first-party job data; no sourced expert quote exists |
| Content freshness | 1 | 10 | +9 | 2 of 2: update date visible; no time-sensitive figure older than 24 months |
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
5. Before and after use the same factor set, the same `asked` values and the same divisor.
6. The lift reproduces from the two printed averages.
7. Any claimed threshold ("at least 50% from baseline") is stated against the one baseline in
   the deliverable, with the arithmetic that produces it.
8. Where a sentence and a table disagree, the table wins — fix the sentence.
9. The two factors with a definition (§3.1, §3.2): every Source-citations claim counted as met
   by disposition rather than by a source has that disposition named in the report, and the
   Content-freshness row states which of its two halves were in scope.
