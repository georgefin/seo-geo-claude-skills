# Design analysis — what 2 pairs licenses, what widening buys, and what escapes the frame

**State: DRAFTED 2026-08-12 (R76). No design is chosen here.** The owner ruled on
`pair-analysis-2026-08-11.md`: *"two against a floor of three is a finding, not a failure… Do not
manufacture a third."* That ruling stands and nothing below softens it. This file exists to make
the remaining choice **decidable** — to price each option in the currency that actually matters
and to test whether the matched-pair frame is the only frame available.

Companion files: `pair-analysis-2026-08-11.md` (the pool and the widening tiers),
`PRIOR-INTERVENTIONS-2026-08-12.md` (a contamination finding that changes the inputs),
`PRE-REGISTRATION-2026-08-12.md` (the criteria).

---

## 1. What two pairs actually licenses

### 1.1 The hard ceiling

With `n` matched pairs, the smallest one-sided p-value an exact sign test can return — the value
when every single pair moves in the hypothesised direction — is `0.5^n`.

| pairs n | 2 | 3 | 4 | 5 | 6 |
|---|---|---|---|---|---|
| best attainable one-sided p | **0.250** | 0.125 | 0.063 | **0.031** | 0.016 |
| best attainable two-sided p | 0.500 | 0.250 | 0.125 | 0.063 | **0.031** |

Read three things off that table:

1. **At n = 2 no conventional significance threshold is reachable at any effect size.** A perfect
   result — both pairs improving, by a mile — is p = 0.25 one-sided. This is not a statement
   about our data or our treatment. It is arithmetic about the design.
2. **The three-pair floor buys no significance either.** n = 3 tops out at 0.125 one-sided. If the
   floor of 3 is being defended as the point where the result becomes trustworthy in an
   inferential sense, that defence is wrong. Three pairs is a *comparability* heuristic — enough
   pairs that one weird page cannot be the whole result — and it should be argued on that ground.
3. **The first design that can clear a two-sided 0.05 is six pairs.** That number is the real
   price of "conclusive", and it is a fact about the widening decision, not about our ambition.

A Wilcoxon signed-rank test gives the same ceiling (its minimum one-sided p at n = 3 is also
1/8). A paired t-test appears to escape — it can print p < 0.01 at n = 2 — and that appearance is
the trap: at n = 2 it estimates the standard deviation from one degree of freedom, so the
p-value is driven by how close the two pair-deltas happen to land, not by how large they are. Two
null deltas of 0.11 and 0.12 will "significantly" beat zero. It is excluded from the
pre-registration for that reason.

### 1.2 The honest reframe

The correct conclusion is not "the pilot is too small". It is that **at every cluster size
available to us, this pilot is not an inferential experiment and should stop being designed as
one.** Even Tier 2's dehumidifier pool would need essentially all of its pages to pair cleanly to
reach n = 6.

What a 2-pair pilot *can* license, honestly:

- **A directional estimate with a stated magnitude** — "the treated pages moved `X` positions more
  than their controls" — which is a legitimate input to a business decision even when it is not a
  significance claim. Most commercial SEO decisions are made on far less.
- **A sign check with a known false-positive rate.** Both pairs agreeing in direction has a 25%
  chance of happening under no effect. That is a weak signal, and it is quantified, which is
  better than a strong-sounding signal that is not.
- **A capability proof.** Whether the library can carry a page end-to-end — audit → draft →
  CORE-EEAT gate → Greek editor → cp1253 pre-flight → approval → publication → verified live →
  rollback-ready — is a **yes/no about our own process**, and it is fully answered at n = 1. This
  is a real part of what `MASTER-IMPROVEMENT-PLAN.md` §0 is missing, and it is the part the small
  cluster cannot damage.
- **The W10 inflection reading.** Whether el-GR ranks Greek inflected variants distinctly or
  collapses them is a *direct observation* of SERP overlap, not an effect estimate. Pair count is
  irrelevant to it. It may well be the most reliable thing the pilot produces.

### 1.3 The unmeasured axes — what the binding gap does to all of it

`pair-analysis-2026-08-11.md` §2a records that of Sani's four comparability criteria — page type,
current traffic, current rankings, word count — **two are measured and two are not**, because no
GSC data was pulled.

Stated precisely, so the consequence is not overstated or understated:

- The two pairs are **provisional, not invalid**. They may turn out to match on traffic and
  rankings; nobody knows.
- **No claim of the form "these pages are comparable" may be made today.** Comparability on half
  the criteria is not comparability, and asserting it would be exactly the absence-as-evidence
  move the house rules forbid.
- The failure is **silent and directional**. If a treatment page happens to sit at position 4 and
  its control at position 40, the treatment page has far less room to improve — position gains
  compress hard at the top of page one. A pair mismatched on baseline rank produces a systematic
  bias whose *sign is unknown until the data are pulled*, and it would look perfectly matched on
  every axis anybody checked.
- Therefore: **the GSC pull is a prerequisite to the pairing, not a refinement after it** — the
  pair analysis already said this, and nothing since has weakened it. It is also the cheapest
  unblock on the board (see §6, input 2).

---

## 2. What each widening buys and costs

Building on `pair-analysis-2026-08-11.md` §3 and pricing each in pairs, since pairs are the
currency that determines what the result licenses.

| Option | Pairs plausibly reached | Best attainable two-sided p | What it costs |
|---|---|---|---|
| **Stay** — 4 heater pages | 2 (and see §3 — arguably 1) | 0.50 | Nothing new. Result is directional only, permanently. |
| **Tier 1** — towel rails, 8 pages | ~1 marginal | — | Fails on size (148–472 words vs a pool floor of 707) and crosses into Tonon, outside the cluster rule. Does not reach 3. |
| **Tier 2a** — mixed, 2 heater + 1 dehumidifier pair | 3 | 0.25 | The third pair is weakly commensurable with the first two; cross-pair aggregation gets shakier, not sounder. Buys the floor without buying what the floor was for. |
| **Tier 2b** — all pairs from dehumidifiers, 13 pages | 3–6, upper end unverified | 0.25 → 0.031 at n=6 | **The only option on the board that can reach conventional significance** — and only if ~12 of the 13 pages pair cleanly, which is unknown: the dehumidifier pool has never been crawled for word count and never pulled for traffic. Costs the heater cluster entirely and needs Sani to widen the cluster rule. Exclude the Qualis Pro line (being discontinued — a treatment effect there is unactionable). |
| **Tier 3** — ACs, 43 pages | many | low | Disqualified. See §2.1 — the reason matters. |

### 2.1 A precision on the Tier 3 disqualification

`pair-analysis-2026-08-11.md` disqualifies ACs on **inverse seasonality**, and for *AC-paired-
against-heater* that is exactly right: cooling peaks in summer, heating Oct–Mar, and pairing
across them re-imports the confound the design exists to remove — invisibly, because the pair
would look well-matched on every measured axis.

But **AC-against-AC pairing is not disqualified by that argument**: both arms would share one
demand curve, which is all matched-pair requires. The sharper reasons to still not use ACs are
different ones, and stating them correctly makes the ruling more robust rather than less:

- **Timing.** An August start puts the entire 12-week window on the cooling category's *decline*.
  Both arms decline together, so the design survives — but the denominators shrink toward the
  measurement floor exactly as the window gets long, so precision decays through CP3–CP4, when the
  pre-registration reads its verdict.
- **Business relevance.** The programme's own deadline is heating content live by end of August,
  for a season carrying the great majority of the relevant revenue. A pilot that answers a
  question about air conditioners in November answers the wrong question at the wrong time.
- **A recorded channel confound.** 48 products were delisted from Skroutz over 20–28 July —
  Beacon 23/23 and Haier 25/25, i.e. **all** of both (project status banner). Beginning a
  measurement window on AC pages whose marketplace exposure changed wholesale weeks earlier adds a
  channel-mix confound to a category we did not need to enter.

Verdict unchanged; reasoning tightened.

---

## 3. The finding that changes the arithmetic

`PRIOR-INTERVENTIONS-2026-08-12.md` establishes, from dated deploy records already on disk, that
three of the four eligible pages carry content interventions from 2026-07-12, -18 and -26 — and
that the interventions are **different on each page**:

- **823277 (F119)** received a full SEO/GEO optimisation pass on 18-07, audited GEO 77 → 88. That
  is substantially the pilot's own treatment, already applied, three weeks before baseline.
- **823327 (NTL4T)** received a capsule on 12-07 and a copy rewrite on 26-07, and a third pass is
  **staged** awaiting Sani's "save it".
- **965528 (F120)** received net-new JSON-LD on 18-07 on a page that previously had none.
- **823322 (NTL2N)** has no recorded intervention — the only clean page — with an unresolved
  discrepancy about whether its rendered JSON-LD ever shipped.

The consequence for this analysis is direct and unwelcome:

> **Pair 2 (F119 treatment vs NTL2N control) cannot separate the pilot's effect from the residual
> of the 18-07 deploy.** F119 is a recently-optimised page with depleted headroom; NTL2N is
> untouched. The pair will move for reasons the pilot did not cause.
>
> **Pair 1 (F120 treatment vs NTL4T control) has the same problem with the sign reversed** — the
> *control* is the more recently and more heavily worked page, so it should be rising through
> CP1–CP2 on its own, biasing the treatment-minus-control delta downward and creating a
> **false-HARM** risk.

So the working figure is not "two pairs of unknown comparability". It is **two pairs, both with a
known, dated, directional contamination, in a pool where the only uncontaminated page is a
control.** Read strictly, the number of pairs free of a documented recent intervention on either
member is **zero**.

This does not manufacture a third pair and does not overturn the owner's ruling. It does change
what the "stay" option costs, and it strengthens the case for widening in a way that has nothing
to do with wanting a bigger number: a dehumidifier pool would need the same intervention audit
run against it before pairing, and if that pool is clean, its pairs are *genuinely* cleaner rather
than merely more numerous.

**Owed before any pairing is finalised, in either cluster:** the same dated-intervention audit,
run against whichever pool is chosen. It costs a grep over the deploy records and it is the
cheapest validity check available.

---

## 4. Designs that escape the matched-pair frame

The frame's assumption is: one treatment, one moment, page as unit, significance as the goal.
Relaxing each assumption gives a different design. None of them manufactures a pair.

### D1 — Query as the unit of analysis (precision, not independence)

Analyse `d_q` per query rather than per page. The observation count goes from 2 to 10–30.

**What it buys**: a much better-estimated page median, and a *measured* noise floor from the
control arm's own query spread — which the pre-registration already uses (`FLOOR = max(3.0,
IQR_C)`). **What it does not buy**: independence. Queries within a page are correlated by
construction — they share the page. Treating 30 queries as 30 independent observations would
inflate significance by roughly the cluster size and is the most common way small SEO tests lie.
**Verdict**: adopt for precision, already in the pre-registration; never quote a query-level
p-value.

### D2 — Stepped wedge: replication instead of significance

Treat pages in two cohorts — cohort A at W0, cohort B at W0 + 6 weeks — so every page is
eventually treated and each page is its own control before its own onset date.

**The mechanism that makes this interesting**: a seasonal ramp is keyed to the *calendar*; a
treatment effect is keyed to the *publication date*. If cohort B reproduces cohort A's post-onset
trajectory **offset by six weeks**, seasonality cannot explain it, because seasonality does not
know when we pressed save. That is a **within-study replication**, and replication is a different
and in some respects stronger currency than a p-value from four data points.

**What it costs, and the cost is real**: cohort B *is* the control arm. Taking this design means
giving up the 12-week concurrent control in exchange for a 6-week one plus a replication test.
Cohort B also gets only ~6 weeks post-treatment by CP4 — inside the 4–6 week directional band, but
below the ~12-week decision-grade line. It also requires amending `PILOT.md` §5.5 ("control pages
are untouchable") and §5.6 ("single intervention window"), which are Sani's clauses to amend.

**If it is taken, the cohort-B trigger must be pre-registered, not decided at CP2 on the data.**
An adaptive rule fixed in advance is legitimate; the same decision made after looking is
curve-fitting with extra steps. A usable form: *"Cohort B is treated at W0 + 42 days
unconditionally"* — unconditional is safest, because any data-conditional trigger imports the
selection effect it was meant to avoid.

### D3 — Deseasonalised before/after against an untouched index

Use the 11 surfaces excluded from pairing (8 accessories, the towel rail, 2 categories, the blog
post) as a **demand index**, not as pair partners. Their aggregate impressions trace the
category's seasonal curve for free.

**What it buys**: a comparator for the before/after leg that does not require a single extra page,
and — layered on the matched pair — a *third* read whose failure mode differs from the control
arm's. **What it costs**: the index surfaces must stay untouched for the window (they join the
freeze list), and the index is a proxy, not a control: accessories may not track heaters
proportionally. **Verdict**: adopt as supporting evidence. It is already written into
`PRE-REGISTRATION-2026-08-12.md` §5.

### D4 — Retrospective read of the interventions already shipped

Three dated interventions from 12-07 / 18-07 / 26-07 exist on this cluster with byte-level
before-states captured on disk, and they are now 17–31 days old — at or just past the 4–6 week
directional threshold.

**What it buys**: this property's own first real outcome numbers, available as soon as a GSC
export lands, with **no publication, no approval, no live write, and no risk**. It also supplies
realistic magnitudes to calibrate the pre-registration's thresholds against this property instead
of choosing them blind. **What it costs**: nothing operationally — and it must be labelled
observational forever. No control arm, no pre-registration, and the 26-07 category rewrite
overlaps the window. **Verdict**: run it first if input 2 clears; it is strictly dominant over
waiting. Detail in `PRIOR-INTERVENTIONS-2026-08-12.md` §4.

### The composite — and why convergence is the right currency here

The strongest available design on the current 4-page pool is not any one of these. It is
**D3 + D1 layered on the matched pair, with D4 run first and D2 offered as a documented option**:

| Line of evidence | Fails if… |
|---|---|
| Concurrent matched-pair control | seasonality interacts differently with treated vs control pages |
| Onset replication across cohorts (D2, if taken) | the effect is page-specific idiosyncrasy |
| Deseasonalised before/after against the index (D3) | the index does not track the heater pages |

**No one of the three is decision-grade. Their agreement is** — because the three have *different*
failure modes. That distinction is not rhetorical: this repository has a recorded case of the
opposite, where two independent readers on two machines and two networks reached the same wrong
answer because they shared an extraction method
(`g9-owner-read-CORRECTION-2026-08-11.md` §4 — "Convergence between independent readers is **not**
corroboration when they share a method"). Convergence counts as evidence exactly when the
convergent methods can fail in different ways. Three designs with disjoint failure modes qualify.
Two runs of the same design do not.

**Honest limit on the composite**: it does not create statistical power. It creates *robustness*.
The verdict labelling in `PRE-REGISTRATION-2026-08-12.md` §8.5 still applies at whatever n the
pairs deliver, and a composite that agrees is still reported as directional at n = 2.

---

## 5. The honest ceiling — what this pilot can and cannot prove, and by when

### 5.1 The calendar, keyed to anchors rather than to hope

Today is **2026-08-12**. D0 = the date all three inputs clear. W0 = the date the first treatment
change is confirmed **rendered live** (`PRE-REGISTRATION-2026-08-12.md` §9.1). The baseline
(week 0–1) and deployment (week 1–2) windows put W0 at D0 + 7 days on the fastest path, D0 + 14
nominal, D0 + 21 slow. CP4 = W0 + 84 days.

| D0 | path | W0 | CP1 | CP2 | CP3 | **CP4 (verdict)** |
|---|---|---|---|---|---|---|
| 2026-08-17 | fast | 2026-08-24 | 09-07 | 09-21 | 10-19 | **2026-11-16** |
| 2026-08-17 | nominal | 2026-08-31 | 09-14 | 09-28 | 10-26 | **2026-11-23** |
| 2026-08-24 | fast | 2026-08-31 | 09-14 | 09-28 | 10-26 | **2026-11-23** |
| 2026-08-24 | nominal | 2026-09-07 | 09-21 | 10-05 | 11-02 | **2026-11-30** |
| 2026-08-31 | nominal | 2026-09-14 | 09-28 | 10-12 | 11-09 | **2026-12-07** |
| 2026-09-14 | nominal | 2026-09-28 | 10-12 | 10-26 | 11-23 | **2026-12-21** |

Three deadlines fall out of that table:

1. **The end-of-August content deadline.** The programme's hard deadline is content live by end of
   August. For W0 ≤ 2026-08-31 the pilot needs **D0 ≤ 2026-08-24 on the fast path, or D0 ≤
   2026-08-17 on the nominal path.** The slow path already cannot make it. That is **five to
   twelve days from today**, and it is the binding constraint on the whole workstream.
2. **CP4 lands in the season, which is good and dangerous.** On every realistic D0, CP3 and CP4
   fall in late October–November — inside Oct–Mar, and on the steepest part of the demand ramp.
   Business-relevant timing; also the point at which an uncontrolled before/after would return its
   most confidently wrong number.
3. **A December CP4 collides with peak trading.** From D0 ≥ 2026-08-31 the verdict arrives in
   December, when the category is at maximum volatility and Sani's attention is elsewhere.

**If the freeze conflict is resolved by shipping the NOBO fix pack first**
(`PRIOR-INTERVENTIONS-2026-08-12.md` §3 option (a)), add ~28 days to D0 and read the table again:
CP4 moves into January.

### 5.2 What it CAN prove

- **Whether the library's full optimisation pass moves rank and impressions directionally** on
  treated pages relative to held controls over 12 weeks — as a magnitude with a sign, not as a
  significance claim.
- **Whether the AI-citation linked rate moves**, against a real denominator and an exact interval.
  First interpretable read at CP2; this is the fastest-moving metric on the board.
- **Whether el-GR ranks Greek inflected variants distinctly or collapses them** (W10's open leg).
  Descriptive, immune to pair count, and probably the pilot's most reliable single output.
- **Whether the library's pipeline can carry a real page end-to-end on a live property** — audit,
  draft, CORE-EEAT gate, Greek editor, cp1253 pre-flight, HITL approval, verified live render,
  rollback-ready. A yes/no about our own process, answerable at n = 1, and a genuine piece of what
  `MASTER-IMPROVEMENT-PLAN.md` §0 says is missing.

### 5.3 What it CANNOT prove — at any n available to us

- **Statistical significance.** Foreclosed by arithmetic at n ≤ 4 pairs (§1.1). Only a
  ~6-pair widening changes this, and even then only marginally.
- **Generalisation to the revenue core, to other categories, or to other clients.** The cluster
  was selected for *bounded risk*, which is a synonym for *not representative*. A result here
  licenses a decision about pages like these.
- **Immunity to a differential ranking change.** A matched pair defends against category-wide
  shifts. It does not defend against an unannounced Google change that treats optimised and
  unoptimised pages differently — which would look exactly like a treatment effect. That confound
  is unremovable at this scale and is stated, not solved.
- **Revenue or conversion effect.** No revenue metric is pre-registered and none should be added:
  the attribution chain from a rank change to a sale on this property runs through Skroutz, cash
  on delivery and marketplace mix, and no 12-week 4-page study can carry it.
- **A clean read on already-optimised pages.** On 823277 the treatment has largely been applied
  already (§3). Re-applying it measures marginal value on an optimised page — a different question
  from the one the plan asks, and one the report must keep separate.

### 5.4 What the reporting calendar looks like given the two clocks

Metrics 1 and 2 are slow; Metric 3 is fast. They do not share a calendar and pretending otherwise
either delays the citation finding by three months or invites a rank verdict at week 2.

| When | What is reported | Status of the claim |
|---|---|---|
| **CP1 (+2w)** | Pipeline shakedown: did every page publish, render, and verify; confound log opened. First citation sample deltas. | Operational only. **No outcome verdict exists at CP1.** |
| **CP2 (+4w)** | **Interim AI-citation read** (labelled interim) + the first W10 distinctness capture. Rank/traffic monitoring only. | Citation read is interpretable and labelled interim. Rank is not reportable. |
| **CP3 (+8w)** | Directional rank/traffic trend; second W10 capture; citation trend. | Directional. Still no verdict. |
| **CP4 (+12w)** | **The verdict**, per `PRE-REGISTRATION-2026-08-12.md` §8: all three metric states in fixed order, with the design-strength label attached. | The pilot's result, whatever it is. A NULL is filed with the same prominence as a SUCCESS. |
| **~2026-11** | Phase 4.2 quarterly cold review, which rides G8. | Independent of the pilot's verdict. |

**The reporting rule that matters most**: a null or negative CP4 gets written up, filed, and
reported at the same length and in the same place as a positive one. That is not a nicety — it is
the reason the criteria were written before the data.
