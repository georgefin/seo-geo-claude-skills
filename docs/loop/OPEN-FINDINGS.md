# Open Findings — verified, unfixed, as of 2026-08-13

> ## ⚠ WORK CLAIM — two sessions are working this list. Read before editing anything.
>
> **A local (Mac Studio) session and this cloud session are both working.** Neither can see the
> other's context, and editing a file another session is mid-way through is ledger **F8** —
> which cost a reviewer its entire pass earlier today. The split below is the whole
> coordination mechanism; there is no other channel.
>
> **CLOUD SESSION HAS CLAIMED (2026-08-11, do not edit these):**
> `optimize/content-refresher/**` · `monitor/alert-manager/**` · `build/geo-content-optimizer/**` ·
> `references/core-eeat-benchmark.md` · `docs/loop/SETTLED-RULINGS.md` ·
> `docs/loop/FAILURE-LEDGER.md` · `docs/loop/OPEN-FINDINGS.md`
> — covering findings **66, 70, 71, 72, 73, 74, 75**, plus the section-A rulings.
>
> **LOCAL SESSION HOLDS:** everything else in section B, the pilot tree
> (`docs/loop/pilot/**`), the R3 supersession candidate, and the two gates. Findings
> **60, 62, 63, 69** are reported done by it.
>
> **If you are the local session**: pull before you start, take from section B outside the
> claimed paths, and add your own claim line here in the same commit that starts the work —
> not the one that finishes it. A claim written afterwards protects nobody.
>
> **Neither session merges PR #9.** The condition is unmet and the gates are unrun.

**Why this file exists.** These lived only in a session-local task list, which no other session
and no file could read. A Mac Studio session asked which set "the 18 open findings" meant, could
not find them anywhere in the repository, and was right: they had never been written down. That
is the same defect class as ledger **F17** — a thing that governs work, carried nowhere a worker
can reach it. Fixed here.

**The count moved.** "18" was accurate when said and is **20** now; three were opened after.
A count quoted from a running list is a timestamp, not a fact — this file supersedes any number
quoted in conversation.

**Status vocabulary — corrected 2026-08-13, and the correction is the point.** This read
*"every row below is OPEN. Nothing here is applied."* It was falsified four sections down by
`## A0. RULED` and by finding 77's *"RULED, and applied"* — a stale sibling left standing when a
status flipped, which is ledger **F11**'s founding class. **The rule F11 recurrence 5 widened the
guard to is that a recorded flip triggers a re-scan of the whole register**, not just the row that
flipped; this header was the row nobody re-read. What is true now:

- **Section A0** — ruled, and where the ruling could be applied here, applied. Each says which.
- **Section A1** — the merge gate's findings, each marked FIXED or OPEN in its own row.
- **Sections A, B, C** — open. Where a row needs a decision rather than an edit, it says so and
  names who decides.

Rows that have moved between sections are **not** left behind in their old one: a finding
appearing twice is a finding that can be closed once and stay open elsewhere.

---

## A0. RULED 2026-08-13 — decisions made, application named

**77, 79 and 68 were section A rows; 80 was opened straight into this section** and never sat in
A — stated because the previous wording ("These were section A") was false for it, and a reader
checking A for 80's history would have found nothing and doubted the record rather than the
sentence. All four are now decided, and their rows have been **removed from section A** rather
than duplicated there. Where the file to change belongs to the other session, the ruling says
so — **a ruling and its application are different jobs, and the second one belongs to whoever
holds the file.**

### 77 — RULED, and applied to C09. **The heading below was wrong when written — see B1.**

> **Correction, 2026-08-13.** This section originally read *"The benchmark no longer asserts
> engine behaviour."* That was false at the moment it was written. C09 had been fixed; §4 of
> the same file still stated "All engines extract from first paragraph", and sixteen more
> instances stood across eight other files. The merge gate found it. **A closure note is a
> claim, and one written from the instance you just fixed rather than from a sweep is the F9
> shape in prose** — the register said the class was closed on the evidence of one member.
> Finding **B1** below records the sweep and its result; the sentence here is left in place,
> corrected rather than deleted, so the next reader sees what it used to claim.

`references/core-eeat-benchmark.md` C09 read *"Markup is not required for the Pass — **engines
parse the visible Q&A either way**"*. That is an engine-behaviour claim asserted as fact, and it
is the exact mirror of the one R3 amendment 9a retracted this week for having **no primary source
in either direction**. It had also reached client-facing prose in three of five blind
deliverables, in both languages, because the benchmark carried it.

**Ruling: the criterion rests on what the page contains, not on what an engine does with it.**
The Pass is earned by the visible Q&A block — which is what a reader gets and what any consumer
can read without markup. That is true without needing to know how any engine behaves. Applied in
the same commit as this ruling; the correction is dated in place rather than rewritten, so the
next reader sees what it used to say.

**Why not simply source it**: nobody here can. `developers.google.com` and `schema.org` are both
refused by this environment's egress. Sourcing it would be the better fix and stays available to
anyone who can read those pages.

### 68 — RULED. State the anti-correlation; do not re-weight.
Scoring Search Demand from competitor cluster depth forces Competitive Density from the same
evidence, so at 25% and 20% the two largely cancel and five factors behave as three.

**Ruling: warn at the proxy site, and require the report to say so — do not change the weights.**
Re-weighting would make the published-weight and proxy paths score differently for the same gap,
which is a worse defect than the one being fixed, and it would invalidate every attainable-value
set already derived. When cluster depth is the Demand proxy, the report states that Density is
not independent evidence on that row. **A named limitation the reader can see beats a silent
correction they cannot.**

**Application belongs to the session holding `research/content-gap-analysis/`.**

### 79 — RULED. The rule exists; make it reachable where prose is written.
Three deliverables in one suite carried prose contradicting their own tables — a superlative
against a figure printed twenty lines below it, and two count errors in one paragraph. The rule
already exists: *where a sentence and a table disagree, the table wins — fix the sentence.*

**Ruling: this is a placement failure, not a missing rule, and it is fixed by placement, not by
adding an expectation per instance.** The rule sits in a derivation reference that a writer
consults while computing, and is breached later while writing prose about the result. It must
appear where the prose is written — in the output-format section, as a pre-send check.
**No ledger increment**: the existing entry is scoped to the loop's own reporting, and stretching
it to cover deliverable prose would make the counter mean two things.

**Application belongs to the session holding `research/content-gap-analysis/`.**

### 80 — RULED. A ruling ID is a run handle. The reason it carries is not.
`ruling R2`, `ruling R3 + amendment 9a` and cross-file pointers sit inside client report fences,
uncaught by §6's pattern.

**Ruling: the ID is a handle and goes; the substantive statement stays, in the client's own
terms.** "One accurate schema type per page, so the markup describes what the page is" says
everything a client needs. "(ruling R2)" adds nothing they can act on and names a register they
cannot read. This is the same test family 8 already applies to framework item IDs, and the
gloss-on-first-use exemption does not reach it: that exemption covers framework **names**, which
a client may meet again in their own analytics, not internal register IDs.

**The cross-file pointer is the same class** — a path into this repository is meaningless on a
client surface. It moves to the operator block with the handles.

**Carrier**: §6 family 8, extended to name ruling IDs and repo paths alongside item IDs and
slugs. **Application belongs to the session holding `build/seo-content-writer/`** for the rule
text, and to each skill's holder for the residue.

---

## A1. Merge-gate findings, 2026-08-13 — what the gate returned and what has been done

The merge gate ran both lanes. **Mode A returned BLOCK.** The contrastive lane issued no
verdict, by design, and additionally declared its own lack of independence — same agent, same
tier, same context as Mode A — which is itself a finding about the layer, not about PR #9.

**As of 2026-08-13 every finding Mode A raised has been fixed except the three contrastive ones,
and those cannot be fixed by editing anything.** C1/C2/C4 are about *measurements*, not defects:
the blind records describe skill versions the tree has moved past. Retaking them needs a **fresh,
uncontaminated executor** — an agent that has not read these skills, this file, or the ledger.
This session cannot supply one, and cannot be one: it wrote the fixes. **A re-run by a contaminated
reader is not a blind run**, and recording one as if it were would poison the baseline every later
comparison rests on. So C1 stays open by construction until a clean session runs it.

**Mode A itself has not re-reviewed the fixes.** Its BLOCK was answered, not withdrawn — a verdict
belongs to the reviewer, and the author of a fix cannot clear it. That is a second thing a fresh
session owes this PR.

| ID | Finding | State |
|---|---|---|
| **B2** | **A permission shipped as a recommendation.** Google's words: *"While you can drop this structured data from your site, there's no need to proactively remove it."* Thirteen shipped surfaces across six skills and one command said "Google **advises against** removing it" — advice never given, in text a client reads. `validate-tracking.sh`'s `R3_LEGAL` allowlist had gained the same phrase as a marker, so the guard could not fail the claim: it *was* the pass condition. | **FIXED** 2026-08-13. All 13 surfaces rewritten; allowlist marker replaced with the faithful phrasing; the overstatement is now a hard fail in check (f), narrowed to lines also mentioning FAQ/schema/markup. Guard probed at the shell per F15 — fires on the old wording, passes the corrected tree. |
| **B1** | **The 9a retraction was applied in one direction only.** 9a retracted "FAQPage earns AI citations" because *no primary source establishes it either way*, and the mirror claim stayed asserted throughout — both scoring frameworks' Top-6 tables, both frameworks' per-engine tables, and a numbered list in `serp-feature-taxonomy.md`. The finding named 6 sites. | **FIXED** 2026-08-13. The sweep found **17 across 9 files**. Not deleted (F19 overshoot): relabelled as this library's prioritisation model, each reason restated as what the item puts on the page — checkable by opening it. Both frameworks carry an explicit evidence-grade note. |
| **B3** | **"Nothing now alerts later than before" is false.** The 5xx Warning band moved `Any occurrence` → `>1/day`, so a single daily 5xx now raises nothing. Third false superlative found in one day. | **FIXED** 2026-08-13 (the claim). The paragraph now states the loss plainly and quotes the old sentence as the example. **The band decision itself is row 8 of the skill's own *Open threshold decisions* table** — it needs a measurement of this site's 5xx floor, which nobody here has. Fixing it surfaced a second defect: that table was headed "seven rows" over six, the seventh having been written up in prose and never carried into the list. Now eight rows, heading counted from the table. |
| **F1–F9** | Nine Mode A FIX items, incl. `Referring domains` compared across two different periods, crawl errors on three ladders, geo's before-table carrying the after-definition, Content Freshness penalising the Statistics rule, a position ladder that still overlaps (25→26 scores 100), and `claims-gate.sh` failing on this file's own line 33. | **ALL NINE FIXED** 2026-08-13. F1/F6 in alert-manager 4.3.2; F2/F3/F4 in geo 4.4.2; F5 in content-refresher 4.3.2; F7/F8 here and in `pre-push-gate.sh`; F9 in `commit-scope-check.sh`. Ledger: **F9 → 5, F11 → 6, F15 → 2**. F15-r2 was caught **in flight** — the first draft of F9's own fix would have passed `71345f3`, the commit it was written to catch, because that message says "gate" (about **G**ATED-ITEMS). |
| **C1** | **The blind records test skill versions that no longer ship.** geo 4.3.1, content-refresher 4.2.1, alert-manager 4.2.1 — only `gap` matched its subject. This was the decisive reason PR #9 could not proceed: a clean result on a superseded version is not evidence about the current one. | **RE-RUN 2026-08-13; two of three CLOSED.** Three blind executors ran from `8fdb629`. Each verified per-file that nothing it read changed mid-run, and all three came back empty. Version alignment checked at the shell, not asserted: **geo run-at 4.4.2 = now 4.4.2, 0 files changed** · **alert-manager run-at 4.3.2 = now 4.3.2, 0 files changed** · **content-refresher run-at 4.3.2, now 4.3.3, 4 files changed** — that skill was swept *after* its run, so its record is one version behind by construction and is being graded in two states. Graders dispatched for all three. |
| **C2** | `alertmanager.json` misstates its own subject version. | **OPEN.** |
| **C4** | An expectation was rewritten between runs in the FAIL→PASS direction, on 3 of 29. | **OPEN.** |

## A2. From the 2026-08-13 grading wave — three regressions, and a divergence I failed to record

| ID | Finding | State |
|---|---|---|
| **G-R1** | **REGRESSION, do-not-merge class. content-refresher e4.4 PASS at 4.2.1 → FAIL at 4.3.2.** The clause requires a blog page to be scheduled *on the tool-comparisons cadence* ("Every 3-6 months", last updated ~9 months before the export). The page is scheduled and its stale title year is flagged, but the cadence is invoked nowhere — a scan for `3-6`, `cadence`, `tool comparison` and every content-type word returns zero hits for it, and the audit table carries **no content-type column at all** though the CSV supplies one for all eight rows. **Explicitly checked and not attributable to the R3 sweep**: `git diff c3c9ab4 8fdb629 -- optimize/content-refresher/` touches neither the *Update Strategy by Content Type* table nor the SKILL.md line routing to it. A real capability loss between versions. | **OPEN.** Outranks the pass rate; blocks a clean merge claim on this suite. |
| **G-D9** | **The ruling register and the skills now disagree about R3, and I did not write that down.** Option C moved nine files off the unverified 2026 FAQ dates. `SETTLED-RULINGS.md` R3's Statement **still asserts them, unmarked** — "ended FAQ rich results in 2026 … dropped June 2026 … API scheduled for August 2026". The skills are deliberately *narrower* than the ruling, not contradicting it, and silence is not contradiction — but a future run reading R3 would re-assert what the skills now decline to. **I planned to record this when applying Option C and did not.** The grader found it; a `grep` for it in this file returned nothing. That is the same shape as finding 77's closure note: the intention existed, the record did not, and only an outside reader closed the gap. | **OPEN by design, but now recorded.** The register edit is Sani's gate and is not touched here. It resolves with the R3 verdict — see `r3-decision-brief.md`. |
| **G-S1** | **CONFIRMED AND CLOSED. A suite expectation quoted skill text that no longer existed.** content-refresher run-start `e1.2` required FAQPage kept *"for AI-engine/GEO parsing only"* and cited that as the skill's own line — but at run start the skill read *"…no primary source establishes an AI-citation benefit either way, so none is claimed"*. Satisfying the expectation literally would have **breached R3 amendment 9a**. `e2.4` and `e3.6` carried it too. Same class as **F9 recurrence 2** — a sweep rewrote skill text and the suite kept quoting the old text. | **FIXED** by `a76706d`, before the grader reached it. Recorded because the ledger counter should move, not because any work is outstanding. |
| **G-R2** | **REGRESSION, do-not-merge class. alert-manager e2.1 PASS at 4.2.0 → FAIL at 4.3.2.** The prior run replaced the dead FID row with `INP degraded | INP above 200 ms | Warning | P2`. This run kills FID correctly and then writes **no INP rule and no 200 ms boundary anywhere** — `INP` appears once as prose context, and a scan for `200` returns zero hits. Checked, not assumed: the guide's own `\| INP \| >200ms \| >500ms \| >1000ms \|` row is **byte-identical** at 4.2.0 and 4.3.2, so nothing in the wave removed the source. | **OPEN.** |
| **G-R3** | **REGRESSION + F19 recurrence. alert-manager e2.2 PASS → FAIL, and this one is partly my wave's doing.** LCP is never corrected to 2.5 s; the deliverable says *"confirm the current boundary numbers … when you reconnect the feed"* and the figure appears nowhere. That is F19's exact ledgered pattern — abstention where a settled ruling holds the answer — **on the same values as F19's founding instance** (content-refresher refusing R4's thresholds). **The contributing cause is skill-side and was introduced by the 4.3.x wave under test**: it added a second status-based CWV row and the one-ladder-per-metric precedence rule, which makes a status-only rebuild the *faithful* reading of the surface. **Root cause: `alert-threshold-guide.md` bands LCP by status word and states 2.5 s nowhere.** R4 appears zero times in `monitor/alert-manager/`, so the number is unreachable from inside the skill — an **F17 shape**, a rule with no carrier. | **ROOT CAUSE FIXED** 2026-08-13 (numeric boundaries now sit beside the status words, citing R4). The regression itself stands until a re-run. |
| **G-M1** | **Two suites are at their measurement ceiling.** geo scored **93.10% at 4.2.2, 4.3.1 and 4.4.2** — identical rate *and* identical composition — while four out-of-set defects were fixed and six new ones found. content-refresher's headline is identical to baseline (25/1/27) with **one expectation fixed and one broken**. A measurement that cannot separate its subjects cannot say what to fix next. Both graders proposed cheap additions that restore discrimination without inventing a bar. | **OPEN.** Suite-improvement work, not a defect. |

## A. Needs a ruling, not an edit — coordinator or Sani

**77, 79 and 68 have moved to A0 (ruled).** They are not repeated here. One row is left, and it
is the one nobody in this repository can settle:

| # | Finding | Who decides |
|---|---|---|
| 65 | **alert-manager: eight rows need a threshold decision, not a doc fix.** Includes a row banding **DA 70+** where the guide bands **DR 60+** — different vendors' instruments, not interchangeable; a P1 on a trigger that reaches no band; four page-level rows with no comparison period stated, so their band is underivable; the two citation-*rate* rows shipping one priority above their band default on an override that cannot structurally reach them; and (new, 2026-08-13) whether a single daily 5xx should raise a boundary alert. **All eight are carried in the skill itself**, in `alert-threshold-guide.md` → *Open threshold decisions*, which is a better home than this file: an operator configuring alerts reads the guide, not the loop register. This row exists to say the decision is outstanding, not to hold it. | Sani / operator |

## B. Confirmed defects with a known fix

| # | Finding |
|---|---|
| 67 | **content-gap: a false equivalence claim introduced by this wave's own fix.** Step 4 says the demand rule "is the same condition the Quick Win Score enforces, stated in words". It is not: `1+4+4+5−12 = +2` clears the bar with Demand at its floor. Either gate Demand before scoring, or drop the equivalence sentence. |
| 73 | **content-refresher: the displacement fix is half-done.** The criterion no longer instructs fabrication — proven, the blind run invented nothing — but the input column names competitor *coverage* notes as sufficient while every rung is worded as what ranks *above* the page. The commonest real input can never score it. Unscoreable was not the intent. |
| 70 | **geo: two scoring factors that cannot reward correct behaviour.** Source Citations leaves the score unchanged when you remove an unsourceable claim — which the skill *mandates* — so compliance scores zero and an optimiser is pushed to keep the claim. Freshness passes vacuously on a page with no data points at all. |
| 74 | **content-refresher: two templates order the family-8 violation they forbid.** A client-read Quick Score column requires framework item IDs; an example prints item IDs on a client surface and derives an 8-dimension score from a 5-item scan, which the handoff carrier explicitly forbids. |
| 75 | **alert-manager: 12 template/rule disagreements.** Worst is a **24× conflict inside one guide** — 5xx banded at ">5/hour" in one table, ">5/day" in another; six errors in a day is Critical under one and Warning under the other. Index coverage stated at both −20% and −15%. The skill contradicts itself on `>3` vs `>=3`, its own worked example disagreeing with its own rule. |
| 78 | **geo suite: e1.5 is the unfixed sibling of an expectation we corrected.** e2.5 gained a placement clause confining the gap marker to report sections; e1.5 did not. Satisfied literally inside published copy it instructs a FAIL-grade violation. Did not fire this run; armed for the next. |
| 66 | **content-refresher: 4 R3-rationale surfaces deferred behind a blind run.** Deliberate — a blind executor was reading that skill and editing mid-run is F8. Apply now that the run is complete. |
| 62 | **content-gap grades a handoff convention it never states.** `grep -i handoff` over the skill and all four references returns nothing, yet eval 4 grades the payload across three expectations. The suite is right; the skill needs the pointer. |
| 63 | **schema-markup-generator contradicts itself on `_SKELETON`.** Output Validation bans the marker in emitted JSON-LD; step 2 prescribes it for the bracket route. |
| 69 | **`analysis-templates.md`: an unclosed nested fence truncates the template.** A bare fence inside a `markdown` fence ends the outer one early, so the last lines fall outside it — and a model copies the fence, not the prose around it. Same file: no content-type label exists for a definition/glossary page. |
| 72 | **`core-eeat-benchmark.md` §5 has no e-commerce category row.** A Greek e-shop category page — the first case this library's stated market hits — has no mapping, so every skill scoring O05 handles it by invention. Two unresolved siblings: whether a nested `ItemList` counts as a second type, and what to do when the correct type *changes* because of the optimisation. |
| 71 | **anti-slop §6 still carries measurement history inside rule text**, in the file restructured today to stop exactly that. No suite names or expectations, so not an F18 recurrence — but, in the finding executor's words, "the separation the file claims for itself is not quite the separation it has." |
| 61 | Both auditors' report templates violate their own Output Validation. |
| 60 | `report-templates.md` §3 fence lacks the in-fence label its two siblings carry. |
| 64 | Mode A advisories A3 and A4 — provenance reachable by a correctly-scoped executor grep; the editor slot leaves `passed + failed ≠ total` unexplained on the `failed` side. |

## C. Process, not defects

| # | Item |
|---|---|
| 76 | Site-access resolution and the crawl dispatch. Superseded 2026-08-11: the account owner created a **"Custom 1"** environment; sessions spawned from here inherit the caller's environment and never saw it. A local machine's own network sidesteps this entirely. |

---

## The merge gate — stated once, precisely

Sani authorised a **conditional** merge on 2026-08-11 (thirteenth verdict entry): merge **if
both** the blind re-runs and an independent review come back clean; fix and do not merge if
anything fails.

**The condition is NOT met.** Four independent reasons, and they are not interchangeable:

1. **Mode A's second pass returned BLOCK** — F11 recurrence and F9 recurrence 4, both in the
   coordinator's own commit. The repairs landed afterwards and **have never been reviewed**.
2. **Two suites carry a contested regression** (content-refresher e2.6, alert-manager e2.5),
   each with both readings stated rather than resolved.
3. **PR #9 is a draft.** It must be marked ready before GitHub will merge it.
4. **The re-runs are evidence about skills that no longer exist** (finding C1, 2026-08-13).
   Sani's condition names *"the blind re-runs"* as one of its two legs. Three of the four blind
   records were taken against versions the tree has since moved past — and this commit moves
   two of them again. **A clean run against a superseded version cannot satisfy a condition
   about the current one**, so the verification leg is unmet no matter how the FIX list
   resolves. This is the reason the merge cannot proceed even on a day when everything else
   clears: it is not a defect to fix but a measurement to retake.

**And the standing constraint above all of these**: the merge needs **Sani's explicit order**.
A condition the coordinator itself judges satisfied is self-authorization, not authorization.
Even with all four reasons above cleared, the correct action is to report that they are cleared
and wait.

**On which gate re-runs**: `docs/loop/ADVERSARIAL-LAYER.md` separates **Mode A** — rule
checklist, holds verdict authority SHIP/FIX/BLOCK/UNDECIDED — from the **contrastive lane**,
which gets no checklist and no verdict. They are different gates with deliberately different
vocabularies, and "the Mode A adversarial review" wrongly merged them in an earlier instruction.
**Both must run.** Mode A because it holds the verdict and its BLOCK stands unanswered; the
contrastive lane because the layer fires it unconditionally on a class (i)+(ii)+(iii) artefact,
which PR #9 is.

**On write access**: GitHub write reaches this repository through the session proxy that has
been pushing all day. A local session holding no token cannot and should not execute the merge —
**it is not a missing capability to work around.** The merge is executed from an authorised
session, or by Sani in the GitHub UI, and only once both gates return clean.
