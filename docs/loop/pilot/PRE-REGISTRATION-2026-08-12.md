# Pre-registration — full criteria, definitions and decision rule

**State: DRAFTED 2026-08-12 (R76). NOT LOCKED. NOT APPROVED. Nothing here has been executed
against any live property.** This file is the long form of `PILOT.md` §4; §4's table carries the
summary and remains the lock surface. Lock happens once, before the first publication, on Sani's
recorded words plus the baseline data — after which this file is immutable and any change is a
recorded protocol deviation that demotes the result to exploratory.

**Governing discipline** (`MASTER-IMPROVEMENT-PLAN.md` §0, constraint 4, binding): *"A null pilot
result is a finding, not a failure to bury. Success criteria are pre-registered before deployment
… precisely so the result cannot be curve-fit afterward."*

---

## 0. How to read the thresholds — the honesty convention

Every number below carries one of three labels. This is the mechanism that keeps R64/R65 intact
in a document that is necessarily full of numbers nobody has measured yet.

| Label | Means | May be changed |
|---|---|---|
| **CHOSEN** | A decision boundary someone picked. Not derived from data, not an estimate, not a prediction. Its only justification is that it was fixed *before* the data existed. | Only by Sani, only before lock. |
| **MEASURED** | Computed from the pilot's own data by a formula fixed here. Its numeric value is unknown today and that is correct. | Never — the formula is what locks. |
| **DERIVED** | Arithmetic on stated values, checkable in place. | Never. |

No figure in this file is an estimate of what the pilot will find. There is no forecast here and
none should be added: a pre-registration that predicts its own result is a pre-registration
already contaminated.

---

## 1. Outcome states — four, not two

A two-state pre-registration (success / null) is curve-fittable, because every underpowered or
broken measurement has to be pushed into one of the two, and the author picks. Four states:

| State | Meaning |
|---|---|
| **SUCCESS** | The pre-registered success condition for the metric is met *and* its data-sufficiency precondition is met. |
| **NULL** | The effect falls inside the pre-registered region of practical equivalence *and* the data-sufficiency precondition is met. A NULL is a finding and is reported with the prominence a SUCCESS would get. |
| **HARM** | The pre-registered harm condition is met. Also a §7 rollback consideration. |
| **INCONCLUSIVE** | The data-sufficiency precondition is **not** met, or the result falls between the success and null bands. |

**The INCONCLUSIVE state is load-bearing.** Without it, an underpowered measurement gets reported
as NULL, and "we could not measure it" becomes "there was no effect" — the absence-claim error
the house rules already name (a "cannot confirm" is a claim about the observer, not the world).
A pilot that returns INCONCLUSIVE has still produced a finding: that this design at this scale
cannot answer this question, which is itself decision-relevant for whether to run a bigger one.

---

## 2. The analysis set — fixed here so it cannot be chosen later

**2.1 Pages.** T = the treatment page list; C = the control page list. Both are named in
`PILOT.md` §1's assignment table at day 0 and are immutable after lock. A page published late,
rolled back, or found defective mid-window stays in its arm and is reported with its deviation —
it is **not** dropped. Dropping a page after seeing its data is the classic curve-fit.

**2.2 Queries.** The frozen set from `PILOT.md` §2b (10–30 rows). Two additions to the
construction rules, both required before the set can be frozen:

- **Peec filter at construction, not only at pull.** The standing project discipline filters GSC
  pulls against `SEO-GEO/_timeseries/peec-prompt-exclusions.txt` (match prompt AND zero clicks).
  `pair-analysis-2026-08-11.md` §2a applies this to the *baseline pull*. It must also apply to
  **§2b's source rule**, which seeds ≥70% of the set from "top GSC queries by impressions". A
  Peec-probed query is exactly a high-impression / zero-click query, so without the filter it
  ranks near the top of the seed list, enters the frozen set, and then contaminates the primary
  metric permanently — because the set cannot be edited after lock. Filter first, seed second.
- **Every query maps to exactly one page.** A query mapped to two pages is dropped at
  construction; if that leaves fewer than 10 rows, the set is short and the pilot says so.

**2.3 Missing data is missing, never zero.** GSC returns no row for a query with zero
impressions in a window. Such a query is **excluded from that window's median** and its exclusion
is counted. It is never imputed, never set to position 100, never carried forward.

**2.4 Position is read per query, never as a page average.** GSC's page-level average position is
impression-weighted, so a page that gains impressions on weaker long-tail terms can show a
*worse* average position while genuinely improving. Reading position per query and taking a
median over queries removes that artefact. This is why §2b freezes a query set at all.

---

## 3. Metric 1 — median rank delta **(PRIMARY)**

**3.1 Definition (fixed).**

- `B_q` = GSC average position for query `q` over the **baseline window** (§6).
- `N_q` = GSC average position for query `q` over the **evaluation window** (§6).
- `d_q = B_q − N_q`. **Positive = improvement** (a smaller position number is better).
- Page delta `D_p` = median of `d_q` over the queries mapped to page `p` that have data at
  **both** endpoints.
- Pair delta-of-deltas `Δ_i = D_T(i) − D_C(i)` for pair `i`.
- **Study statistic `Δ` = median of `Δ_i` across pairs.** (Before/after design: `Δ = median of
  D_T` across treated pages, and every report of it carries the uncontrolled-seasonality warning
  `PILOT.md` §1 already mandates.)

**3.2 The noise floor is MEASURED, not chosen.** Define `IQR_C` = the interquartile range of
`d_q` pooled across all **control**-page queries in the evaluation window. This is the
pilot's own estimate of how much a query moves when nothing is done to it.

> **`FLOOR = max(3.0 positions [CHOSEN], IQR_C [MEASURED])`**

The formula is fixed now; its value is computed at CP4 from data that does not exist yet. This is
deliberate: it makes the bar automatically harder when the data turn out noisy, and it cannot be
argued about afterwards because nobody chose the number — the control arm did. The 3.0 is a
floor under the floor, so that an implausibly quiet control arm cannot make the bar trivial.

**3.3 Conditions.**

| State | Condition |
|---|---|
| **SUCCESS** | `Δ ≥ FLOOR` **AND** every pair's `Δ_i > 0` (all pairs agree in sign). |
| **NULL** | `−1.0 ≤ Δ ≤ +1.0` positions [CHOSEN band]. |
| **HARM** | `Δ ≤ −FLOOR`, **or** any single treated page's `D_p ≤ −5.0` positions [CHOSEN]. |
| **INCONCLUSIVE** | Anything else, **or** the §3.4 precondition fails. |

**3.4 Data-sufficiency precondition.** ≥60% [CHOSEN] of the queries mapped to T pages, and ≥60%
of those mapped to C pages, must have data at **both** endpoints. Below that, Metric 1 is
INCONCLUSIVE regardless of the value of `Δ`.

**3.5 The significance ceiling, stated in the pre-registration itself so it cannot be forgotten
at write-up.** With `n` matched pairs, the smallest one-sided p-value an exact sign test can
produce — the value when *every* pair agrees in the hypothesised direction — is `0.5^n` [DERIVED]:

| pairs n | 1 | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|---|
| min one-sided p | 0.500 | **0.250** | 0.125 | 0.063 | 0.031 | 0.016 |
| min two-sided p | 1.000 | 0.500 | 0.250 | 0.125 | 0.063 | **0.031** |

Consequences, binding on the final report:

- At **n = 2**, a perfect result carries a one-sided p of 0.25. **No conventional significance
  threshold is reachable at any effect size.** A SUCCESS verdict at n = 2 is therefore recorded
  and reported as **"directional-success"**, never as demonstrated, proven, or significant.
- **The three-pair floor does not fix this** — n = 3 still cannot reach p < 0.05. The floor of 3
  is a comparability heuristic, not a power threshold, and should not be defended as the latter.
- The first n that can reach a two-sided p < 0.05 on a sign test is **n = 6**.
- A paired t-test is **not** pre-registered and must not be substituted. At n = 2 it estimates a
  standard deviation from one degree of freedom, so its p-value is governed by the accident of
  how close the two pair-deltas happen to fall, not by the size of the effect. It can print
  p < 0.01 on a null result and routinely will.

---

## 4. Metric 2 — GSC impressions and clicks **(SECONDARY, always reported)**

**4.1 Impressions are primary within this metric; clicks are reported alongside and never alone.**
On low-traffic pages a click count of 3 → 6 is a "100% lift" and means nothing. Impressions have
the larger denominator and are the less unstable of the two.

**4.2 Definition.** For each arm: `I_base` = summed impressions over the baseline window,
`I_eval` = summed impressions over the evaluation window; `r = (I_eval − I_base) / I_base`,
reported as a percentage. Same for clicks, reported separately. The **difference-in-differences**
statistic is `DiD = r_T − r_C`, in percentage points.

**4.3 The before/after leg of this metric is uninterpretable for this cluster without a
comparator, and the pre-registration says so up front.** The category is θερμοπομποί. A baseline
taken in May–August and an evaluation window running September–November compares the seasonal
trough to the seasonal ramp; the project's own programme spec records **Oct–Mar at 91.1% of
heating/dehumidifier revenue and December alone at 36.0%** (`SHARED/SEO-GEO/PROGRAMME-SPEC_SEO-GEO-Q3_25-07-2026.md`
— project-internal figure, carried here as recorded, not independently re-derived). A raw `r_T`
for this cluster will be large and positive whatever the pilot does. **Quoting `r_T` alone would
be reporting the Greek heating season as a treatment effect.** Only `DiD`, or the deseasonalised
form in §5, may be reported as an effect; `r_T` may appear only beside its comparator.

**4.4 Conditions** (all thresholds CHOSEN unless marked):

| State | Condition |
|---|---|
| **SUCCESS** | `DiD ≥ +15 pp` **AND** absolute impression lift on T ≥ **+100 impressions** (a floor so a tiny base cannot manufacture a percentage). |
| **NULL** | `|DiD| ≤ 10 pp`. |
| **HARM** | `DiD ≤ −25 pp`. |
| **INCONCLUSIVE** | Anything else, or `I_base` for the T arm < **100 impressions** over the baseline window — at which point the metric is under-powered by construction and is reported as counts only, with no rate. |

**4.5 Year-over-year is the preferred comparator where the data exist.** If GSC holds the same
84-day window one year earlier for these pages (retention is 16 months, so autumn 2025 is
retrievable today), pre-register `r_YoY` as an additional comparator: it compares like season to
like season and is far stronger than a summer baseline. Caveats to record with it, both
`[VERIFY]` until checked: whether each page existed and was indexed in the 2025 window, and
whether it has since been materially rewritten. Where a page fails either check, its YoY figure
is omitted rather than caveated into the average.

---

## 5. The seasonality index — a comparator that costs nothing

`pair-analysis-2026-08-11.md` excluded 11 surfaces from *pairing* (8 accessories, the RSS 2012
towel rail, 2 categories, 1 blog post). Excluded from pairing is not excluded from use.

**Index definition (fixed).** `S = (summed impressions of the index surfaces in the evaluation
window) ÷ (summed impressions of the same surfaces in the baseline window)` [MEASURED]. Index
membership is named at lock and frozen; every index surface joins the §3 change freeze
(`PRIOR-INTERVENTIONS-2026-08-12.md` §3) — an index that gets optimised is not an index.

**Seasonal-only prediction.** `I_T_predicted = I_T_base × S`. The deseasonalised effect is
`I_T_eval ÷ I_T_predicted − 1`.

This gives the before/after design a comparator it otherwise lacks, and gives the matched-pair
design a **third, independent** read whose failure mode (index mismatch) differs from the control
arm's (differential seasonality). It is reported as supporting evidence, never as the primary.

---

## 6. Windows — fixed relative to two anchors, so no window can be chosen after the fact

| Anchor | Definition |
|---|---|
| **D0** | The date all three §0 inputs clear their bar in `PILOT.md` §0.1. |
| **W0** | **The date the first treatment change is confirmed RENDERED on the public page** — not the CMS save date. See §9.1; this is a correction to `PILOT.md` §6's wording, which says only "date of first treatment publication". |

- **Baseline window**: the 84 days ending 3 days before D0 (the 3 days absorb GSC's reporting
  lag). Both arms use the identical window.
- **Evaluation window**: W0 → W0 + 84 days. Identical length to the baseline, identical for both
  arms.
- **Checkpoints**: W0 + 14 / 28 / 56 / 84 days = CP1 / CP2 / CP3 / CP4. The §3 and §4 criteria
  are evaluated **once**, at CP4, on the cumulative window. CP1–CP3 are monitoring only and
  **carry no verdict** — a CP2 reading may never be reported as the pilot's result.
- **Baseline-window override** (`PRIOR-INTERVENTIONS-2026-08-12.md`): three of the four eligible
  pages carry content interventions dated 2026-07-12, -18 and -26. If those pages are used, the
  baseline window **must** either end before 2026-07-12 or begin at least 28 days after the last
  intervention on that page — and whichever is chosen applies to **every** page identically. The
  choice is made at lock, recorded, and never revisited.

---

## 7. Metric 3 — AI-citation appearance rate **(SECONDARY, fastest-moving)**

**7.1 What counts as a citation — three columns, not one.** `PILOT.md` §3's log has a single
"Our property cited? (y/n)". That is ambiguous between three genuinely different events and the
ambiguity is curve-fittable. Replace with:

| Column | Counts when |
|---|---|
| **L — linked citation** | The AI answer, or its attached sources/citations panel, contains a clickable link whose host is `www.sanihellas.gr` or `sanihellas.gr`. |
| **M — unlinked mention** | The answer names Sani Hellas (or a brand page of ours) in text with no link to the property. |
| **N — neither** | Neither of the above. |

`L`, `M`, `N` are recorded independently (a row can be both L and M). **The pre-registered
primary is L only.** M is reported separately and never merged into the headline rate — the
house position that unlinked mentions matter for AI visibility is a reason to *measure* M, not a
licence to count it as a citation.

**7.2 Baseline must be ≥2 pre-deployment sessions.** `PILOT.md` §3 takes the citation baseline
from the week-0 sample. A single session is a single day of a volatile surface. Pre-register:
**baseline = all sampling sessions dated strictly before W0, pooled, and there must be at least
two of them on different calendar weeks.** If only one pre-W0 session exists, Metric 3 is
INCONCLUSIVE by construction and says so.

**7.3 Two controls, both cheap, both required per session.**

- **Negative control (personalisation detector).** One query, named at lock, in the cluster's
  topic for which the property has **no** page. If our property is cited on the negative control,
  the session is flagged: the sampler's profile is probably personalised and every L in that
  session is suspect. Sani is in Greece, is the site's owner, and visits it — this is a live risk,
  not a theoretical one.
- **Positive control (surface detector).** One query, named at lock, on which a known Greek
  competitor is expected to appear (the project register names `heatovent.com` as out-citing all
  three of our properties in heaters). If neither the competitor nor any Greek retailer appears
  across a whole session, the sampling surface itself is suspect and the session is flagged.

Flagged sessions are recorded, reported, and **excluded from the pooled rate** — an exclusion
rule fixed here, before any session exists.

**7.4 Conditions.** Rates use the **Clopper–Pearson exact** interval throughout (named so the
computation is reproducible; a normal approximation is invalid at these counts).

| State | Condition |
|---|---|
| **SUCCESS** | The trailing-4-week L-rate at CP4 exceeds the **upper bound of the one-sided 95% Clopper–Pearson interval on the baseline rate** [MEASURED] **AND** there are ≥5 distinct L events spread across ≥2 engines and ≥3 distinct calendar weeks. |
| **NULL** | The CP4 rate lies inside the two-sided 95% interval on the baseline rate. |
| **HARM** | The CP4 rate lies below the lower bound of that interval (we were de-cited). |
| **INCONCLUSIVE** | Fewer than 60 unflagged rows with an AI answer shown in the trailing-4-week pool, or the engine mix changed mid-pilot on >25% of rows. |

**Worked illustration of the SUCCESS rule (arithmetic only, not a prediction).** If the baseline
is 0 linked citations out of 36 rows, the one-sided 95% upper bound is `1 − 0.05^(1/36)` =
**7.98%** [DERIVED], so the CP4 rate would have to exceed 7.98% — with the ≥5-events-across-2-
engines-and-3-weeks condition also met. The same formula at 0/72 gives 4.08% and at 0/144 gives
2.06%: **the more sampling sessions run, the harder the bar becomes, which is the correct
direction.** Nothing here asserts what the baseline will be.

**7.5 Why this metric gets its own calendar.** AI-citation visibility moves in days to weeks
where rankings move in months (`MASTER-IMPROVEMENT-PLAN.md` §0, constraint 3). Metric 3 is
therefore *reportable* at CP2 as an interim read, clearly labelled interim, while Metrics 1 and 2
are not. The CP2 interim read does **not** carry a verdict and cannot change the §7.4 conditions.

---

## 8. The decision rule — written before the data, so the report cannot shop for a headline

1. **The pilot's headline verdict is Metric 1's state.** Full stop.
2. **If Metric 1 is INCONCLUSIVE, the headline verdict is INCONCLUSIVE** — regardless of what
   Metrics 2 and 3 show. This forecloses the standard move of promoting a secondary metric after
   the primary fails to resolve.
3. **All three metric states are reported, in the fixed order 1, 2, 3, every time**, including
   when they disagree. Disagreement is reported as disagreement, not resolved in prose.
4. **Any metric in HARM triggers the §7 rollback consideration** regardless of the others, and
   the harm condition sustained across two consecutive checkpoints is a rollback trigger under
   `PILOT.md` §7(c).
5. **Verdict labelling by design strength**, applied mechanically:
   - n ≥ 6 pairs → the verdict may be stated plainly.
   - 3 ≤ n ≤ 5 pairs → **"directional"**.
   - n ≤ 2 pairs → **"directional, single-cluster, not generalisable"**.
   - before/after with no control arm → **"uncontrolled; seasonality not separated"** on every
     citation of the result, per `PILOT.md` §1.
6. **No subgroup analysis is pre-registered.** Any subgroup, per-brand, per-locale or per-query-
   class cut that appears in the report is labelled **exploratory** and may not appear in the
   headline or the abstract.
7. **The W10 inflection reading is descriptive and is exempt from 1–6.** It is a direct
   observation of SERP overlap (`PILOT.md` §2c), not an effect estimate, so it does not depend on
   pair count and is reportable on its own terms. It is the pilot's most robust deliverable.

---

## 9. Corrections this pre-registration makes to `PILOT.md`, and why

**9.1 W0 must be the live-render date, not the save date.** The platform lags: after an eShopKey
save the public page can take hours to change, the cache is per-locale, there is no republish
control and no reachable purge (recorded in the eshop project's status banner; the 26-07 deploy
observed ~19–27 minutes, the 18-07 deploy ~25 minutes, and the standing rule warns of hours).
If W0 is the save date, the evaluation window opens before the change exists to be crawled, and
CP1 measures a page Google has not seen. **W0 = the timestamp of a fresh public GET that confirms
the change rendered**, recorded per page in the approvals log.

**9.2 Every live verification must be discriminated against the soft-404 signature.**
`www.sanihellas.gr` returns **HTTP 200 with the homepage** for any non-existent URL — measured
twice independently: four nonsense URLs during the 26-07 deploy, and the 2026-08-11 crawl's
negative control (`200`, `81,006 B`, homepage `<title>`). A 200 therefore proves nothing in
either direction. Any fetch used for W0 confirmation or rollback verification must record byte
size and `<title>` and compare them against a freshly captured fake-URL signature from the same
session. This applies to `PILOT.md` §5.4, §7 and the day-0 checklist.

**9.3 A cp1253 pre-flight is required as a fourth per-page gate.** `PILOT.md` §5.3 lists three
gates (CORE-EEAT, Greek editor, Sani's approval). It needs a fourth, and it is scoped precisely:
product `Description_1/2`, the specs slot and `JSON_SCHEMA` round-trip through Windows-1253, and
any non-cp1253 character corrupts silently to `?` **on save** — invisible in a UTF-8 preview,
visible only live. A treatment page that ships with `?` corruption is a degraded treatment arm,
which attacks the pilot's validity directly. **Scope discipline matters here**: the same
project's measurements show `Categorytext_1/2` is a UTF-8 path, and a metadata write preserved an
emoji intact, so the ban is **not** site-wide. The gate runs a codepoint scan on the *new* text of
the cp1253-scoped fields only. Entity escaping is not a shield — `&rarr;` was observed decoding
back to a literal `→` on save; character substitution is the only working defence.

**9.4 Rollback verification needs a wait-and-retry rule.** `PILOT.md` §7 says to verify a restore
by re-fetching and comparing hashes. Under a multi-hour, per-locale cache that will produce false
failures and provoke a re-save — which the platform rule explicitly forbids ("do not re-save to
chase it"). Pre-register: verify the **admin/DB read-back immediately** (authoritative), then
re-fetch the public page at +30 min, +2 h and +6 h, and only escalate if the +6 h fetch still
disagrees. Both locales are checked; a single-locale check gives the wrong answer in either
direction.

---

## 10. Free parameters — everything Sani must fix before lock

Each is a one-line answer. Defaults are the drafted values above and apply if Sani states no
preference; every default is CHOSEN, and once locked, immutable.

| # | Parameter | Default | Where |
|---|---|---|---|
| P1 | Rank-improvement floor | 3.0 positions (under `max()` with the measured control IQR) | §3.2 |
| P2 | Rank null band | ±1.0 position | §3.3 |
| P3 | Single-page rank harm | −5.0 positions | §3.3 |
| P4 | Query-coverage precondition | 60% both arms | §3.4 |
| P5 | Impressions DiD success / null / harm | +15 pp / ±10 pp / −25 pp | §4.4 |
| P6 | Absolute impression floor | +100 impressions; base <100 ⇒ INCONCLUSIVE | §4.4 |
| P7 | Citation event minimum | 5 events, 2 engines, 3 weeks | §7.4 |
| P8 | Citation row minimum | 60 unflagged rows in the trailing 4 weeks | §7.4 |
| P9 | CORE-EEAT publication threshold | GEO ≥75 **and** SEO ≥75, zero verified vetoes | `PILOT.md` §5.3 |
| P10 | Baseline-window rule given the July interventions | end before 2026-07-12 | §6 |
| P11 | Locale scope | GR only, pending the `[VERIFY]` on whether EN product pages render at all | §6 / prior-interventions §5 |

**Note on P9**, so the threshold is chosen with the framework's arithmetic in view rather than
against it: under the CORE-EEAT rules one verified veto (T04, C01, R10) caps the final score at
**59** and two or more are a BLOCK. Any threshold at or above 60 therefore already forecloses
vetoes automatically — the "zero verified vetoes" clause is a restatement, not an extra
constraint, and should not be presented as one.

---

## 11. Deviation protocol

Any departure from this file after lock is written as a dated row in `PILOT.md` §6 naming the
clause departed from, the reason, and who authorised it — **before** the affected measurement is
reported, never in the write-up. A criterion changed after lock demotes the entire result to
exploratory and the final report states that in its first paragraph. A page that fails to publish,
publishes late, or is rolled back stays in its arm with its deviation recorded; it is not removed.
