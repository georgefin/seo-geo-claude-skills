# Open Findings — verified, unfixed, as of 2026-08-11

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

**The condition is NOT met.** Three independent blockers, and they are not interchangeable:

1. **Mode A's second pass returned BLOCK** — F11 recurrence and F9 recurrence 4, both in the
   coordinator's own commit. The repairs landed afterwards and **have never been reviewed**.
2. **Two suites carry a contested regression** (content-refresher e2.6, alert-manager e2.5),
   each with both readings stated rather than resolved.
3. **PR #9 is a draft.** It must be marked ready before GitHub will merge it.

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
