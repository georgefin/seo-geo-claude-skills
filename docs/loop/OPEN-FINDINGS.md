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
A count quoted from a live list is a timestamp, not a fact — this file supersedes any number
quoted in conversation.

**Status vocabulary**: every row below is OPEN. Nothing here is applied. Where a row needs a
decision rather than an edit, it says so and names who decides.

---

## A0. RULED 2026-08-13 — decisions made, application named

These were section A. Each is now decided. Where the file to change belongs to the other
session, the ruling says so — **a ruling and its application are different jobs, and the second
one belongs to whoever holds the file.**

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

| ID | Finding | State |
|---|---|---|
| **B2** | **A permission shipped as a recommendation.** Google's words: *"While you can drop this structured data from your site, there's no need to proactively remove it."* Thirteen shipped surfaces across six skills and one command said "Google **advises against** removing it" — advice never given, in text a client reads. `validate-tracking.sh`'s `R3_LEGAL` allowlist had gained the same phrase as a marker, so the guard could not fail the claim: it *was* the pass condition. | **FIXED** 2026-08-13. All 13 surfaces rewritten; allowlist marker replaced with the faithful phrasing; the overstatement is now a hard fail in check (f), narrowed to lines also mentioning FAQ/schema/markup. Guard probed at the shell per F15 — fires on the old wording, passes the corrected tree. |
| **B1** | **The 9a retraction was applied in one direction only.** 9a retracted "FAQPage earns AI citations" because *no primary source establishes it either way*, and the mirror claim stayed asserted throughout — both scoring frameworks' Top-6 tables, both frameworks' per-engine tables, and a numbered list in `serp-feature-taxonomy.md`. The finding named 6 sites. | **FIXED** 2026-08-13. The sweep found **17 across 9 files**. Not deleted (F19 overshoot): relabelled as this library's prioritisation model, each reason restated as what the item puts on the page — checkable by opening it. Both frameworks carry an explicit evidence-grade note. |
| **B3** | **"Nothing now alerts later than before" is false.** The 5xx Warning band moved `Any occurrence` → `>1/day`, so a single daily 5xx now raises nothing. Third false superlative found in one day. | **FIXED** 2026-08-13 (the claim). The paragraph now states the loss plainly and quotes the old sentence as the example. **The band decision itself is row 8 of the skill's own *Open threshold decisions* table** — it needs a measurement of this site's 5xx floor, which nobody here has. Fixing it surfaced a second defect: that table was headed "seven rows" over six, the seventh having been written up in prose and never carried into the list. Now eight rows, heading counted from the table. |
| **F1–F9** | Nine Mode A FIX items, incl. `Referring domains` compared across two different periods, crawl errors on three ladders, geo's before-table carrying the after-definition, Content Freshness penalising the Statistics rule, a position ladder that still overlaps (25→26 scores 100), and `claims-gate.sh` failing on this file's own line 33. | **OPEN.** |
| **C1** | **The blind records test skill versions that no longer ship.** geo 4.3.1 (now 4.4.1), content-refresher 4.2.1 (now 4.3.1), alert-manager 4.2.1 (now 4.3.0). Only `gap` matches its subject. | **OPEN, and decisive** — see the merge gate below. |
| **C2** | `alertmanager.json` misstates its own subject version. | **OPEN.** |
| **C4** | An expectation was rewritten between runs in the FAIL→PASS direction, on 3 of 29. | **OPEN.** |

## A. Needs a ruling, not an edit — coordinator or Sani

| # | Finding | Who decides |
|---|---|---|
| 77 | **The benchmark asserts the mirror of what R3-9a retracted.** 9a removed "FAQPage's value is AI-engine parsing" because no primary source establishes it either way. `references/core-eeat-benchmark.md:304` asserts the symmetric claim as fact — "engines parse the visible Q&A either way" — and it reached **client prose in 3 of 5 blind deliverables**, both languages. Retracting one and leaving its twin in the shared framework is indefensible. | Coordinator |
| 65 | **alert-manager: 6 rows need a threshold decision, not a doc fix.** Includes a row banding **DA 70+** where the guide bands **DR 60+** — different vendors' instruments, not interchangeable; a P1 on a trigger that reaches no band; and four page-level rows with no comparison period stated, so their band is underivable. | Sani / operator |
| 79 | **Derived-figure class, third appearance.** Prose restating a table and disagreeing with it. The skill's own rule already governs it ("where a sentence and a table disagree, the table wins"), so this is a rule breached, not missing. Whether it increments a ledger entry is a separate call. | Coordinator |
| 68 | **content-gap: the recommended proxy cancels itself.** Scoring Search Demand from competitor cluster depth forces Competitive Density from the same evidence; at 25% and 20% weight they largely cancel, so five factors behave as three. Needs a judgement about the framework, not a patch. | Coordinator |

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
