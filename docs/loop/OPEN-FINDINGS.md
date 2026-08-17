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
| **B1** | **The 9a retraction was applied in one direction only.** 9a retracted "FAQPage earns AI citations" because *no primary source establishes it either way*, and the mirror claim stayed asserted throughout — both scoring frameworks' Top-6 tables, both frameworks' per-engine tables, and a numbered list in `serp-feature-taxonomy.md`. The finding named 6 sites. | **SWEPT 2026-08-17, and the closure note is now written from the sweep rather than from the fix.** The three earlier numbers, in order: the finding named **6** sites; the first closure claimed **17 across 9 files**; the Mode A reviewer then found **23+ survivors** of the class it declared closed. The dedicated sweep rewrote a **hand-counted ~37 sites across 12 skills and 1 framework file** — 12, not the 11 first recorded, and the site count is a hand tally with no derivation, so read it as an order of magnitude and not a measurement. All 12 validate 15/15. Not deleted (F19 overshoot): relabelled as this library's prioritisation model, each reason restated as what the item puts on the page. **The method is the finding.** Four verb families were each complete against their own vocabulary and still missed six members — `AI systems prioritize informational answers` matched none of them, because `prioritize` was on no list. A fifth family existed only because the sweeper assumed its own list was incomplete and tested that assumption. **A verb-list sweep is bounded by its verb list**, so this class is closed *against five stated patterns*, never absolutely. **Reproducible basis: `scripts/engine-claim-sweep.sh`** — five families, a named adjudication list with a reason per excused class, and a `--probe` mode that fault-injects a known member. **The first number written here was wrong, and Mode A caught it.** It read *"measured at the shell 2026-08-17 at `dcabd6b`: raw 171 → residual 42"* — taken on a dirty working tree mid-edit and labelled with `git rev-parse HEAD`, which still named the previous commit. Re-run at `dcabd6b` the command returns **91**; `171/42` occurs at **no commit in the range** (F16 → 3, F9 → 7). Restated from a **`git archive` of commit `42a1798`**, so the working tree cannot contaminate it: **raw 173 → adjudicated → residual 46**. Verified twice — once on a clean checkout, once against the archive after the commit was amended and its hash changed — because a number tied to a hash goes stale the moment anyone rewrites that commit, which happened here within the hour. One of those was a genuine class member on Mode A's read and is now `[VERIFY]`-tagged (`ai-citation-patterns.md:148`, asserting how a product sources its answers); the remaining 45 read as **non-**members (connector tokens, R3-correct wording, retraction notes quoting withdrawn text per F11-r6, and SERP-surface facts). **Re-read them rather than trusting that sentence — it has been wrong once already, and the reader who re-read it is the reason this row is right.** The one line the sweep escalated for a decision — `link-quality-rubric.md:75`, hedged but justifying a scoring weight — is tagged `[VERIFY]`, with the weight shown not to rest on it. |
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
| **G-G1** | **The new citation-divergence guard fires as designed `[obs:2026-08-13T11:05:00Z bash scripts/citation-divergence-check.sh at f51ca6e — Results: 1 passed, 1 warnings, 6 failed]`, and every one of its six failures is on R3 — the ruling that caused this whole problem.** `scripts/citation-divergence-check.sh` (fault-injected, not wired into the gate) reports: R3 names source URLs but **declares no `S<n>` source list**, so no claim can point at a source; one reference is **elided** (`.../2026/05/a-new-resource-for-optimizing`) and an ellipsis is not a URL a verifier can open; one is **scheme-less**; and **three load-bearing claims carry no source pointer at all**. It fires on no other ruling, which is the evidence it is not noise. Its WARN is honest about its own reach: 4 rulings name no URL and state no evidence grade, so it cannot verify them and does **not** fail them. **This is precisely the check whose absence let R3 cite two documents while drawing its claims from a third** — and the reason it was never caught is that nothing compared the two. | **OPEN and not fixable here.** Every fix is an edit to `SETTLED-RULINGS.md`, which is Sani's gate. Resolves with the R3 verdict. |
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
| 74 | **content-refresher: two templates order the family-8 violation they forbid.** A client-read Quick Score column requires framework item IDs; an example prints item IDs on a client surface and derives an 8-dimension score from a 5-item scan, which the handoff carrier explicitly forbids. **Checked against the 2026-08-13 row-label carve-out on 2026-08-17 and NOT mooted by it.** The carve-out admits an item ID as the *row label* of a scored table with the item's plain-language name beside it in the same row; this template's IDs are a bare list inside a cell — `C02, C03, C05 Pass; C01 Partial; C09 Fail` — with no name against any of them, which is the referent form wearing a table's clothes. The shipped fix (IDs moved to their own operator fence) is the right one and was not reopened. The 5-item-scan half of the row is independent of the carve-out either way. |
| 75 | **alert-manager: 12 template/rule disagreements.** Worst is a **24× conflict inside one guide** — 5xx banded at ">5/hour" in one table, ">5/day" in another; six errors in a day is Critical under one and Warning under the other. Index coverage stated at both −20% and −15%. The skill contradicts itself on `>3` vs `>=3`, its own worked example disagreeing with its own rule. |
| 78 | **geo suite: e1.5 is the unfixed sibling of an expectation we corrected.** e2.5 gained a placement clause confining the gap marker to report sections; e1.5 did not. Satisfied literally inside published copy it instructs a FAIL-grade violation. Did not fire this run; armed for the next. |
| 66 | **content-refresher: 4 R3-rationale surfaces deferred behind a blind run.** Deliberate — a blind executor was reading that skill and editing mid-run is F8. Apply now that the run is complete. |
| 62 | **content-gap grades a handoff convention it never states.** `grep -i handoff` over the skill and all four references returns nothing, yet eval 4 grades the payload across three expectations. The suite is right; the skill needs the pointer. |
| 63 | **schema-markup-generator contradicts itself on `_SKELETON`.** Output Validation bans the marker in emitted JSON-LD; step 2 prescribes it for the bracket route. |
| 69 | **`analysis-templates.md`: an unclosed nested fence truncates the template.** A bare fence inside a `markdown` fence ends the outer one early, so the last lines fall outside it — and a model copies the fence, not the prose around it. Same file: no content-type label exists for a definition/glossary page. |
| 72 | **`core-eeat-benchmark.md` §5 has no e-commerce category row.** A Greek e-shop category page — the first case this library's stated market hits — has no mapping, so every skill scoring O05 handles it by invention. Two unresolved siblings: whether a nested `ItemList` counts as a second type, and what to do when the correct type *changes* because of the optimisation. |
| 71 | **anti-slop §6 still carries measurement history inside rule text**, in the file restructured today to stop exactly that. No suite names or expectations, so not an F18 recurrence — but, in the finding executor's words, "the separation the file claims for itself is not quite the separation it has." |
| 86 | **FIXED 2026-08-17** — carrier written: `docs/loop/eval-baselines/INSTRUMENT-CHANGES.md`, which a reader comparing two numbers reaches before the JSON, with the direction of the change stated (a correct response moved FAIL→PASS) because a reader who does not know the direction cannot even subtract safely. **The re-run it names is still owed.** Original finding: **three eval baselines now measure a different instrument, and no register said so.** `dcabd6b` rewrote e3 in `schema-markup-generator`, e2 in `alert-manager` and e5 in `technical-seo-checker` — all three had *required* the framing ruling R3 amendment 9a retracted, so a run that stated the sourced position used to FAIL. Their prior Mode B baselines therefore grade a question no longer asked, and a later reader comparing old score to new will read an instrument change as a regression or an improvement. **This is open finding C4's shape** (an expectation rewritten between runs in the FAIL→PASS direction) at wave scale rather than line scale. Nothing is wrong with the rewrite; what is missing is the note that the yardstick moved. Needs: a line in `eval-baselines/` marking those three suites' pre-`dcabd6b` records as measuring a superseded expectation, and a re-run before any of them is quoted as evidence. |
| 87 | **CORRECTED IN REGISTER 2026-08-17** — the commit itself cannot be edited without rewriting history five commits now sit on, so the correction lives here, which is where a reader looking for repo state arrives first: **`e76366c` is pushed, superseded by `3d0b592`, and nothing in it is outstanding.** Read its subject as historical as of 2026-08-13T21:00Z. Original finding: **`e76366c` ships a label that is now false.** Its subject reads *"NOT reviewed, NOT pushable yet"* and it has been pushed and superseded by `3d0b592`. The content is fine and nothing is outstanding in it — the defect is a standing claim in the permanent record that contradicts the record around it, which is F11's founding class. The house form for exactly this is F10's *"historical as of that timestamp"* marker, and a commit message cannot be edited after pushing without rewriting history that other work now sits on. Fix belongs in a register that a reader reaches first, not in the commit. |
| 88 | **serp-analysis: the Recommended Content Outline fence is an unlabelled skeleton, and it is armed.** `analysis-templates.md`'s Recommendations block ends with a fenced block that is entirely bracket tokens (`Title: [Optimized title]`, `H2: [Section based on PAA/top results]`) with no in-fence `# SKELETON …` label, and the "Content Requirements to Rank" checklist above it (`Word count: [X]+ words`) is the same shape. Under the Value Rule clause 2 a model copies the fence, not the heading — so a run **with** data ships bracket tokens inside a paste-shaped block. The blind run did not trigger it only because it had no SERP to fill the outline from; the trap is live for every run that does. Same class as the nine command fences fixed earlier, recurring in a skill reference. |
| 89 | **`[VERIFY]` has no stated reader rule.** Three serp-analysis references tag items with it and `SKILL.md` says to report them "tagged unverified", but nothing says whether the literal tag may cross onto a client surface. It is a register handle from an internal queue, so the Reader Test says resolve it into plain language — but the Reader Test names slugs, item IDs, ruling IDs and repo paths, not `[VERIFY]`. A blind run read the instruction both ways and had to rule for itself. Needs one line in the Reader Test naming `[VERIFY]` explicitly. |
| 90 | **serp-analysis: two more no-data holes the difficulty fix does not cover.** (a) Output Validation requires "every recommendation cites specific data points" and "ranking factors identified from actual top 10 analysis", neither satisfiable when nothing arrived, while Data Sources says "proceed with the full analysis using provided data" — the skill has no stated *nothing arrived* mode. (b) The intent breakdown is emphatic that the split is counted and that unclassifiable elements stay in the denominator; N=0 is not addressed. Both were resolved by the blind run inventing a shape the skill neither authorises nor forbids. |
| 91 | **`skroutz-visibility-factors.md` states a number and then forbids citing it.** The BoxNow ~300k locker target and the Skoop per-order fee appear as body facts and are immediately `[VERIFY]`'d with "do not cite a specific number to a client". A figure printed in body prose will be read as usable; the tag arrives after the reader has it. Either the figure moves behind the tag or it goes. |
| 81 | **`geo-score-arithmetic.md` §9 states a locale fact that is wrong under this environment's default, and its prescribed fix has its own silent false positive.** §9 asserts as established in-repo fact that a Greek range `[α-ω]` "fails with `Invalid collation character` and exit status 2". Measured by a blind executor 2026-08-17: the shell default here is **POSIX** (`LANG` empty, `LC_CTYPE=POSIX`), where `[α-ω]` did **not** abort — exit **0**, matching by byte instead. It aborts only under `LC_ALL=C.UTF-8`. So the file's rule is right about the abort and wrong about when, and the dangerous case is the one it does not describe: **a screen that exits 0 having silently matched the wrong thing.** Worse, the prescribed replacement — explicit two-character brackets, `ιδανικ[ηήοό]` — returned **3** of 3 lines under POSIX including a false positive on «ιδανικά», which shares a UTF-8 lead byte, against **2** under `C.UTF-8` and `rg`. §9's *"a screen that exits non-zero has not run"* needs its converse beside it. **Same family, and it feeds a threshold**: POSIX `wc -w` reported **204** words for a Greek deliverable where `LC_ALL=C.UTF-8 wc -w` reported **1116** and a Python token count **1077** — a citation-density threshold read off POSIX `wc` is wrong by roughly 5×. **FIXED 2026-08-17** in geo 4.4.6 and seo-content-writer 4.5.8, after the three measurements were re-taken independently rather than carried from the report. Both files now state the locale dependence, the quiet-failure direction, the workaround's own false positive, and the `wc -w` divergence; the rule is `LC_ALL=C.UTF-8` or `rg`, with the locale recorded beside the result. |
| 82 | **`geo-score-arithmetic.md`: `asked` is undefined for exactly the two factors an optimization run changes.** §3 fixes `asked` once at step 2 "from the content and the brief" and §8 item 5 requires both columns to use it unchanged — but *Clear definitions* derives `asked` from "key terms the content actually uses" and *Quotable statements* from "main sections", and optimizing the page changes both. Read literally, the after-column denominator is capped at the inbound page's vocabulary. The two factors the skill exists to move are the two whose denominator it never says how to fix. **FIXED 2026-08-17** in geo 4.4.7: `asked` for those two factors is set from the **planned** structure, reused unchanged in both columns per §8 item 5, with the gaming risk named and answered by the existing print-the-denominator rule. |
| 83 | **Content-freshness scope is undecidable on a listing page, and both readings satisfy §8 rule 10.** Whether a product grid counts as "≥1 time-sensitive figure" decides between `asked = 1` (10/10, +0) and N/A, and §3.2's "already in scope" argument only reaches figures in a supplied data block. Related: Input Validation wants a date "known — or **confirmed** unavailable", and a blind or client-less run can confirm nothing; there is no branch for "not supplied and cannot be asked". **FIXED 2026-08-17** in geo 4.4.7. Ruled: a time-sensitive figure is one the page **states as a claim**, not one a reader could count off the layout — a 12-item grid renders inventory and changes with no edit, which is the opposite of the staleness the factor measures. The unconfirmable-date branch resolves to *not available*, with the unconfirmed input named in the report. |
| 84 | **Three carrier gaps the blind run hit in one deliverable.** (a) Input Validation accepts a **URL** as content, but *Source citations* needs a claim inventory "taken from the page alone" and the only exit is `asked = 0 → N/A`, written for a different condition — "the page makes no claim" is not "the page could not be read". (b) Step 1's `[VERIFY]`-never-in-the-indicative rule and step 5's structured-data row pull opposite ways: the row asks for "the type the page needs and why", which is the indicative statement, on a client surface. (c) The handoff payload requires the content type **verbatim from the CORE-EEAT weight table**, and that table has **no e-commerce-category column** though §5 and §6 both define the type — so the correct type for a product-listing page cannot be expressed in the payload's required vocabulary, and finding 72's sibling is now blocking a handoff, not just a score. |
| 85 | **Target queries: required, absent, and derivation forbidden.** Data Sources asks the user for target queries; a brief may give a target *term*. Step 4 then requires "the queries the user named, **not a generic set**", with no third branch. The blind run derived five, labelled them, and asked for confirmation — against the letter of that sentence. Same shape as 84(a): a required input with no stated behaviour when it is absent. |
| 61 | Both auditors' report templates violate their own Output Validation. **Partially settled 2026-08-17, and deliberately not closed.** The ID-column half is settled: the 2026-08-13 carve-out admits the scored per-item table's ID column, both auditors' tables are `\| ID \| Check Item \| Score \| Notes \|` with a plain-language name beside every ID, and both checkboxes now state the carve-out. **The operator-block half was checked and is not settled.** `content-quality-auditor` shows the labelled block inline in its own `SKILL.md` (:302); `domain-authority-auditor` shows none and points to `references/example-report.md` (:122) for the shape. An executor there must traverse to satisfy a checkbox its own template gives nowhere to land — the same root shape as the two regressions diagnosed 2026-08-13, in the safer direction. **Operator-block half FIXED 2026-08-17** in domain-authority-auditor 4.3.6 — the labelled fence now ships inline in its own `SKILL.md`, matching its sibling, with a note recording why it moved out of the reference. **The row stays open** for the reason it was opened: both closures so far were reached from a carrier fix rather than from a full sweep of both auditors' full templates, and closing on that basis is the F9 shape that has been the finding three days running. What is owed is one pass reading both templates in full against their own Output Validation, not another spot fix. |
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
