# Open Findings — as of 2026-08-12 (B closed; A and C open; D mixed, per-row states)

**Why this file exists.** These lived only in a session-local task list, which no other session
and no file could read. A Mac Studio session asked which set "the 18 open findings" meant, could
not find them anywhere in the repository, and was right: they had never been written down. That
is the same defect class as ledger **F17** — a thing that governs work, carried nowhere a worker
can reach it. Fixed here.

**The count moved, and this line proved its own point.** "18" was accurate when said; the note
then said **20**, and stood at 20 while #80, #81 and #82 were opened beneath it. The true figure
was **23 rows** when this paragraph was rewritten on 2026-08-12 — and section D was appended
minutes later, making it **31**. The line went stale inside one editing session, which is the
whole point: a count quoted from a live list is a timestamp, not a fact (R317 — a count is
evidence about the *report*, never about the objects it summarises). This file supersedes any
number quoted in conversation, **including this one the moment a row is added.** Current:
**31 rows — 6 in A, 16 in B, 1 in C, 8 in D**, 31 distinct ids, no duplicates; #80 is resolved.
[obs: `grep -cE '^\| [0-9]+ \|'` = 31 and `sort -un` over the ids = 31, 2026-08-12]

**Status vocabulary**: rows are OPEN unless the row or its section header says otherwise.
**Section B is CLOSED (2026-08-11) — see its header.** Sections A and C remain open. **Section D
(added 2026-08-12) is mixed and every row carries its own state**, because that round both
raised and closed items in the same wave; read the State column, never the section. Where a row
needs a decision rather than an edit, it says so and names who decides.

---

## A. Needs a ruling, not an edit — coordinator or Sani

| # | Finding | Who decides |
|---|---|---|
| 77 | 🔴 **REVISED 2026-08-12 — the scope was recorded as one line and is ELEVEN, and a primary source now exists.** 9a removed "FAQPage's value is AI-engine parsing" because no primary source establishes it either way. **The old text of this row cited `core-eeat-benchmark.md:304`; the line is `:312`** — the finding complaining about unsourced claims carried a stale pointer. **Sweep (own search terms, not the row's):** 7 rule surfaces — `references/core-eeat-benchmark.md:312` · `geo-content-optimizer/references/ai-citation-patterns.md:498` · `schema-markup-generator/SKILL.md:52` · `schema-markup-generator/references/validation-guide.md:245` · `content-gap-analysis/references/gap-analysis-frameworks.md:160` · `keyword-research/references/greek-keyword-coverage.md:117` · `serp-analysis/references/analysis-templates.md:161` — plus **4 eval expectations that GRADE executors on asserting it** (see FIX #10 row below). Live, not theoretical: `eval-baselines/blind-2026-08-11/geo.json:278` records three deliverables asserting engine behaviour to the client in the indicative, in Greek. **NEW PRIMARY SOURCE**, fetched from raw HTML with asides preserved, negative control passed (a fake URL on the same host returns a true 404, so the 200 is meaningful) — `developers.google.com/search/docs/fundamentals/ai-optimization-guide`: *"Overfocusing on structured data: Structured data isn't required for generative AI search, and there's no special schema.org markup you need to add."* **This splits the sentence.** "Markup is not required for the Pass" is now **primary-sourced** and must be KEPT and cited (R238). "Engines parse the visible Q&A either way" remains **unsourced** — the guide says markup is not needed and is silent on whether visible text is parsed; **absence of a markup requirement is not evidence of a parsing mechanism**, and that inference is this finding in miniature. **NOTHING APPLIED.** Fixing 1 of 11 is F9; fixing all 11 implements an R3 supersession, which Sani reserved. The complete sweep is delivered as a ready-to-apply proposal and the tree is unchanged. [obs:2026-08-12 sweep = 12 surfaces; tree unchanged] | **Sani** (was: Coordinator — escalated, it is R3-scoped) |
| 65 | **alert-manager: 6 rows need a threshold decision, not a doc fix.** Includes a row banding **DA 70+** where the guide bands **DR 60+** — different vendors' instruments, not interchangeable; a P1 on a trigger that reaches no band; and four page-level rows with no comparison period stated, so their band is underivable. | Sani / operator |
| 79 | ⚠️ **NOT ACTIONABLE AS WRITTEN — the finding has no locus (noted 2026-08-12).** "Prose restating a table and disagreeing with it" names a class and cites the governing rule ("where a sentence and a table disagree, the table wins" — live in 7 files) but gives **no file:line for the instance**. A finding with no locus can be neither fixed nor verified, and guessing an instance would fabricate the defect. The rule is breached *somewhere*; nothing here says where. **Owed: the locus, from whoever observed it** — that is a smaller ask than a re-derivation, and re-deriving it would be inventing a second finding and calling it the first. The ledger-increment question stays open behind it, since an increment needs an instance. [obs:2026-08-12 `grep "the table wins"` = 7 files; row carries no file:line] | Coordinator (blocked on its own evidence) |
| 81 | 🔴 **A skill-local relaxation of a cross-skill FAIL-grade rule, authored inside the wave that then cited it.** `f7c7610` split `domain-authority-auditor/SKILL.md:356`'s flat ban on item IDs in the client fence into a permissive pair; `a9fbd7c` then cited that pair as proof the example was compliant. It contradicts **`references/inter-skill-handoff.md:241`** — *"A framework **item ID** and a **skill slug** are never exempt, in any language"* — and anti-slop family 8, whose handle carve-out requires a **labelled operator block**, which `example-report.md:105` places *outside* the client fence. Caught by Mode A's second pass. **The relaxation stands in the tree pending this ruling and should be reverted if the ruling goes the other way.** 🔴 **Mode A pass 3 judged the handling and found it wrong (2026-08-12):** the defect is not *that* it stands pending a ruling, it is that it stood **unmarked** — a state this same wave had already ruled insufficient. `8c94d04`, committed **61 seconds before** the commit that cited the relaxation, established the remedy for exactly this situation (*"all four REFUSED decisions were live in the files with zero markers, so a model picks a side silently … each now carries an in-file `⚠️ UNRESOLVED — owner ruling owed` note at the point of use"*) and applied it to alert-manager's four refusals — **but not to the one contested item whose contested side the coordinator had authored.** The inconsistency ran in the direction favouring his own edit, which is the R71 problem stated structurally. Mode A also confirmed `SKILL.md:359` states the exemption **while citing `inter-skill-handoff.md` in the same sentence**, the file that denies it, and that **no eval in either auditor suite grades the exemption or its contradiction** — so nothing would have surfaced it if the ruling never came. ✅ **Markers APPLIED 2026-08-12** at `SKILL.md:356-359` and `references/inter-skill-handoff.md:243-248`, each naming both sides with locations and closing *"Until it is ruled, cite the side you used."* Shape copied from the live `alert-threshold-guide.md:120` example; marker census 4 → 6, the four `#75-*` untouched. Neither side deleted, no winner picked. The ruling itself is still owed and the relaxation is still unratified.** [obs:2026-08-12 marker census 4 -> 6] | Coordinator / **Sani** |
| 82 | **Is a client entitled to the derivation of their own score?** `domain-authority-auditor/references/example-report.md:43-46` prints the full CITE computation (`70 × 0.40 + 55 × 0.15 + … = 68.5`) inside the client fence, which the same skill's first Output Validation checkbox bans as a "scoring-method instruction". Transparency argues for keeping it; the checkbox as written forbids it. Not resolved when raised, because the resolution is either "move it to the operator block" or "the checkbox is over-broad", and picking the second would be relaxing a rule to fit an artifact. ✅ **PARTLY RESOLVED 2026-08-12 — Mode A pass 3 dissolved the dilemma.** Moving the derivation **is compliance with the rule exactly as written, not a relaxation**, and needs no ruling: the destination's own label reads `<!-- OPERATOR BLOCK — for the client's team, not part of the report above …`, so **the client's own team still receives the derivation** — nothing is withheld from anyone, only the fence boundary changes. The transparency argument was the only thing making this look like a dilemma and the destination answers it in full. A ruling would be needed *only* for the second reading, and nobody needs that reading because the first loses nothing. ✅ **APPLIED 2026-08-12**: `example-report.md:43-47` moved into the existing operator fence at `:129-133` under *"How the score above was derived"*, with an out-of-fence note at `:99` saying why, so a later pass does not helpfully move it back; `SKILL.md:295-298` → `Sorted by impact on the CITE score, highest first.`; `content-quality-auditor/SKILL.md:276` likewise. R238 discharged before deleting — the operands survive in their canonical home at `references/score-arithmetic.md:91-92`. 🔴 **RESIDUAL — and it is FOUR loci in this skill plus a whole unexamined sibling, not the one this row recorded.** The conflict: `SKILL.md:176` **instructs** *"Publish the tally beside the score so a reader can check it"* and `:350` mandates the score *"shown unrounded then rounded"*, while `:353` **bans** scoring method in the client fence. Two rules in one file that cannot both be obeyed; picking either is a ruling. Loci: **(1)** `SKILL.md:278` — `CITE Score = C × [w_C] + …` inside the main client report fence, **the template that GENERATES the block just moved out of `example-report.md`, so skill and example now DIVERGE until this is ruled**; **(2)+(3)** `SKILL.md:213`/`:222` — the same `= [p]×10 + [q]×5` construct in the Step 3 fence, which this row never named; **(4)** `SKILL.md:189`/`:198` in the `:180-200` fence. **And `content-quality-auditor/SKILL.md:250-253` is the sibling case, strictly worse — it prints `Σ` and the weight variable — in a skill this finding never examined at all.** All left untouched and queued. | Coordinator (the fence-boundary question — resolved) + **Sani** (the mandate-vs-ban conflict, all 5 loci, both auditors) |
| 68 | ✅ **RULED 2026-08-12 (Coordinator) — no framework redesign needed; the skill already owns the machinery.** Confirmed and quantified: `gap-analysis-frameworks.md:342` and `SKILL.md:166` name **competitor cluster depth** as an acceptable Search Demand proxy, while Competitive Density is scored from the same competitor data and is **inverted** (`score-arithmetic.md:33` — "Competitive Density 5 means 'no competition'"). One piece of evidence therefore drives Demand up and Density down at 0.25 vs 0.20: a deep cluster scores `25·5 + 20·1 = 145`, a shallow one `25·1 + 20·5 = 125` — a **20-point swing where those two factors alone span 180**. They largely cancel; five factors behave as three, exactly as recorded. **Ruling: bar cluster depth as the Demand proxy whenever Competitive Density is scored from the same competitor data**, and route that case to the drop-and-renormalise path the framework already fully specifies (`gap-analysis-frameworks.md:273` — 0.20/0.75, 0.25/0.75, 0.15/0.75). The sibling proxy (own-site sessions on adjacent pages) is independent of competitor data and survives untouched. Nothing is invented and no weight changes. ✅ **APPLIED 2026-08-12** at `SKILL.md:144` (the named-proxy paragraph — note its worked example *uses* cluster depth, so the caveat sits at the point of use) and `gap-analysis-frameworks.md:341+`, with **content-gap-analysis 4.3.0 → 4.4.0** in G1 lockstep and the registry row updated. [obs: `validate-skill.sh research/content-gap-analysis` → 15 passed / 0 failed, `TRUE_EXIT=0` read without a pipe, 2026-08-12] | Coordinator — ruled + applied |

## B. Confirmed defects with a known fix

> ✅ **ALL 15 CLOSED 2026-08-11**, local branch `section-b`, pushed as `claude/section-b-fixes-2026-08-11`. Section A is
> untouched by design — those need rulings, not edits.
>
> **Three findings were larger than recorded, and the revised count is stated against the
> number it revises (R317):** **#69** was 1 defect, actually **13** (all fixed; new finding
> #80). **#75** recorded 12 contradictions, actually **16 enumerated items = 15 distinct
> contradictions** — the two GEO citation-rate rows share one root cause and count as one.
> 12 fixed, **4 refused** as threshold decisions rather than typos. The four refusals now carry
> **in-file `⚠️ UNRESOLVED — owner ruling owed` markers at the point of use** (#75-A crawl-errors
> vs 4xx · #75-B toxic-link spike vs playbook · #75-C SSL 14 vs 30 days · #75-D Major Drop P1 vs
> P2), because leaving both sides present and unmarked lets a model pick one silently [obs: `grep -c "UNRESOLVED — owner ruling owed"` = 3 in alert-threshold-guide.md, 1 in alert-configuration-templates.md, 2026-08-11]. **#66** recorded 4
> surfaces, actually **5** — the prescribed guard grep *structurally could not see* the fifth,
> because the phrase wraps a newline and the check is line-based (R319: coverage = surface ×
> detector).
>
> **#67 — corrected record.** An earlier version of this note said the fix "gated Demand
> **rather than** dropping the equivalence sentence". That was false about this wave's own
> change, and Mode A caught it: the sentence is present at base and **absent at HEAD**, replaced
> by its explicit negation. What actually happened is **both** — the false equivalence claim was
> removed *and* Demand was gated. The R238 concern was never about that sentence (it was false,
> and a false sentence is deleted, not protected); it was about the **five other statements of
> conjunctive intent**, which were kept. #61 separately concluded the *rule* over-reached rather
> than the template. **That relaxation is now itself an open ruling — see #81.**
>
> **Owner rulings opened by this wave, none invented:** #75's four threshold decisions;
> #72's "which state is O05 scored against when the optimisation changes the type"; and the
> content-refresher eval reconciliation (8 fossilized clauses that would have graded a
> *correct* run as a failure) — reconciled in place, flagged as the commit to split if a
> deliberate re-baseline is preferred.
>
> ⚠️ **#75's verification is UNREPRODUCIBLE and the claim is downgraded accordingly.** Commit
> `a877786` claims "a PAIRED gate — must_absent AND must_present … 15/15 FAIL against pre-fix
> blobs, 15/15 PASS after". No such harness exists in the repository — the harness lived in an
> agent scratchpad and is gone.
>
> 🔴 **The evidence originally offered for that was itself false, and is corrected here (F20,
> 2026-08-12).** The commit cited `grep -rl must_absent` → *"zero files"*. Re-run at HEAD it
> returns **one** — this register — **because the same commit's own diff wrote the token here.
> The measurement was already false at the moment it was written**: a working-tree grep run
> before a commit measures a tree that ceases to exist the instant the commit lands. Use a form
> that reproduces *after* the fact: `git log -S'must_absent' --all` → `06b9a52` only, and
> `git grep -l must_absent $(git rev-list --all)` → the same single hit. **The substance holds**
> — Mode A confirmed it three independent ways and `a877786`'s own diffstat adds no script — so
> the downgrade below stands on verified ground; only its citation was wrong. The twelve fixes are individually
> inspectable in the diff and the four refusals are now marked in-file, but **the 16→15
> reconciliation rests on a check nobody can re-run** (R297). Treat it as author-asserted, not
> verified, until a committed gate reproduces it.
>
> **A defect in the verification tooling itself, found by an agent and not by its author:**
> `scripts/check-template-fences.py` printed GREEN having scanned **zero files** when given a
> directory argument (`IsADirectoryError` caught as `OSError` and skipped). R-0222. It now
> fails closed on an empty scan set and prints the file count every run.
>
> **Its detection scope is narrow and is now documented in the file (F15-r1).** It fires only
> when a `markdown` block's last line ends on `:` or a heading AND the next block is unlabelled.
> A truncated template ending on ordinary prose is **missed**. A green means "nothing matched
> this signature", never "no truncated templates" — quote it that way. A dead `check()` function
> carrying a stale description of a different heuristic has been removed, and the file is 755
> like its siblings. **No gate runs it yet** — that is still owed.

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
| 80 | **RESOLVED 2026-08-11 — all 13 fixed** [obs: `scripts/check-template-fences.py` GREEN, 205 files scanned, exit 0]. #69 is not one defect, it is thirteen. Original text follows. **#69 is not one defect, it is thirteen — ten are still open.** Same mechanism throughout: a `` ```markdown `` template block containing a nested 3-backtick block, so the nested *opener* closes the template and everything after it falls outside the fence a model copies. Detector shipped: `scripts/check-template-fences.py` (R297-validated, RED on the pre-fix files via `git stash`, GREEN after). Three fixed 2026-08-11; **ten remain** in 8 files — `performance-reporter/references/report-output-templates.md:92`, `content-refresher/SKILL.md:158`, `internal-linking-optimizer/references/linking-templates.md:19`, `on-page-seo-auditor/SKILL.md:228`, `on-page-seo-auditor/references/audit-templates.md:285`, `technical-seo-checker/SKILL.md:139`, `technical-seo-checker/references/technical-audit-example.md:18`, `technical-seo-checker/references/technical-audit-templates.md:302`, `serp-analysis/references/analysis-templates.md:7` and `:285`. Worst is `technical-seo-checker/SKILL.md:139`, where the copied template stops at `**Current Content**:` and loses the entire crawlability checklist. **Not batch-fixed deliberately**: an auto-fixer was written and rejected at dry-run — it resolved three separate openers in `geo-content-optimizer` to one close at L280, because these SKILL.md templates sit inside numbered list items that match neither of its section-break signals, and applying it would have corrupted 10 files. Each needs its intended close identified by reading. |

## D. Raised by the 2026-08-12 double-gate round (Mode A pass 3 + Protocol A contrastive lane)

Both lanes ran against the same frozen SHA `06b9a52`, on split tiers, neither seeing the other's
reasoning. **They converged on the same F9 survivors from different token families** — which is
the tier-split working as designed, not redundancy.

| # | Finding | State |
|---|---|---|
| 83 | **The F9 token mechanism cannot express a context-scoped retirement, and that gap was never declared.** F9 Recurrence-2 ruled sweep completeness "a SCRIPT'S job" and made a `DEPRECATED_TOKENS` row mandatory (`validate-tracking.sh:344-345`), backfilled to prior retirements. No row was added and the script was untouched across the whole range. **But a flat row cannot work here**: `grep -rn "weight × points lost"` over the guard's own scan set returns **three** hits — the two client-fence violations **and `references/inter-skill-handoff.md:117`, which is legitimate operator text**. A flat row would fail a correct line. The mechanism assumes a *globally* banned concept; this one is banned in a client fence and legal in an operator spec (R319). **Detector is specified** — a ```markdown fence whose first content line is not `<!-- OPERATOR BLOCK` is client-facing — **but building it is blocked on #82**, because the rule it would enforce is the thing #82 disputes. [obs:2026-08-12 OPEN-FINDINGS.md #82 unresolved] | OPEN — blocked on #82 |
| 84 | 🔴 **Normative skill text was rewritten with no version bump, and `validate-tracking` structurally cannot catch that.** `06b9a52` rewrote normative template text in two SKILL.md files and a reference; `a9fbd7c` a third. Both auditors' `version:` fields are unchanged from `f2c6b10`. The gate checks that the three version carriers **agree with each other**, never that a bump **happened** — so a silent no-bump edit is invisible to it forever. This is a guard gap, not a typo. | ⏳ bumps IN FLIGHT (not yet verified); **the guard gap is OPEN** |
| 85 | **`VERSIONS.md:97` now describes behaviour the tree no longer has** — the v4.2.0 bullet lists "the gain multiplication shown in the Top 5 template" among that release's fixes, which HEAD now forbids. Historical changelog text is legitimately historical, so this is not a falsification alone — but combined with #84 (no entry recording the reversal) the register set asserts, unopposed, that the current template shows the multiplication. | ⏳ changelog row IN FLIGHT (not yet written) |
| 86 | **`domain-authority-auditor/SKILL.md` sits at 349 lines against a hard cap of 350** (`validate-tracking.sh:299`, measured post-frontmatter). The wave's direction of travel on this file is additive; the next two-line insertion converts a WARN into a FAIL. | OPEN — headroom 1 line |
| 87 | 🔴 **18 of 35 register pointers resolve to the wrong line — more than half — and check (g) only WARNS.** Pass 2 sampled five and found two wrong; the full audit found 18 wrong / 15 correct / 2 structurally unresolvable, with the gate green throughout (`validate-tracking.sh:552` explicitly does not fail them). Two clusters: **every pointer into root `CLAUDE.md` is wrong (6 of 6)** — the file was restructured and nothing followed — and 7 resolve to a blank line or a table separator, the F12 line-shift signature. `reanchor-pointers.sh` cannot repair any of them: it only fixes `file:line ("token")` form, and **an un-anchored pointer carries no token to grep**. Anchoring is the durable fix; re-anchoring is free forever after. | ⏳ repair + anchoring IN FLIGHT (excl. `SETTLED-RULINGS.md`, owner-reserved — **2 wrong pointers there remain, deliberately untouched**) |
| 88 | **Four eval expectations require an executor to assert the retracted R3 rationale**, so the suites *reward* the retracted claim on every future run. All four base-present, none chargeable to this wave. Sharpest is `alert-manager` e2.3, which attributes the rationale *"per the house ruling"* — **to the very ruling that disowned it**, the F9-r4 signature surviving in a grading surface rather than a shipped one. `schema-markup-generator`'s own `validation-guide.md:245` already forbids what its own eval demands. | ✅ **Fixed + independently verified 2026-08-12** — all 3 files valid JSON; all four surfaces now NEGATE the rationale with paired MUST-APPEAR / MUST-NOT-APPEAR legs (R297), and e5.4's quoted anchor confirmed real at `technical-audit-example.md:136` |
| 89 | 🔴 **The pre-push gate's F14 failure was a misconfigured upstream, not bad history — and the same misconfiguration silently mis-scoped two other gate legs.** `section-b` tracked `origin/claude/scheduled-skills-web-search-8zaz3j`, an unrelated branch, while its real remote is byte-identical to HEAD, so 17 already-pushed commits were judged outgoing. The guard's own header grandfathers pushed history by construction. **`claims-gate.sh` and `register-lock.sh gate-check` resolve the same `@{upstream}`** — every leg's result on this branch was computed against the wrong base, **including the legs that were passing**. ⚠️ Earlier coordinator reports of "10 historical commits requiring a history rewrite" were wrong on both count and remedy: it is 11 against the live-rule window, 15 against `main`, and no rewrite is required (R317). | ⏳ upstream fix + full gate re-run IN FLIGHT |
| 90 | **Two guard-vocabulary holes in `commit-scope-check.sh`.** (a) `register_aliases()` gives every register an alias family except **`open-findings`, which has none** — it falls through to the empty default, so a commit subject like `fix(#80):` is transparently about that register and the guard structurally cannot see it (4 commits fail for exactly this). (b) The multi-skill breadth escape is a fixed five-word list; `chore(versions): bump 11 skills in G1 lockstep` declares its breadth **more precisely than any accepted word would** and is rejected anyway. F14's harm is a *false record*; that subject is a true one. | (a) ⏳ IN FLIGHT; (b) OPEN — needs a call on whether to widen the vocabulary |
| 91 | 🔴 **ROOT CAUSE of the whole F9 recurrence chain on this concept: the rule never defines which fences it governs.** The checkbox says *"inside **the** client report fence"* — definite singular — but `domain-authority-auditor/SKILL.md` contains **several** ```markdown fences, and nothing says which are client-facing. Step 1's Audit Setup fence carries an internal path (`:145` *"Canonical source: references/cite-domain-rating.md"*) and weight text (`:141`, and `content-quality-auditor:118`); the Step 3 fence carries `[p]×10 + [q]×5`. **That undefined scope is why three consecutive sweeps under-counted** — each swept the fence it was looking at and each was defensible. The only mechanical discriminator that exists is the operator-block label (`<!-- OPERATOR BLOCK` as a fence's first content line), and it is a convention the rule never invokes. **Owed: define the governed set, then the detector in #83 becomes writable.** Until then every sweep of this concept is a judgement call wearing a grep. | OPEN — **Sani/Coordinator**; blocks #83, and #82 sits on top of it |

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

1. 🔴 **Mode A's THIRD pass returned BLOCK (2026-08-12, frozen SHA `06b9a52`).** Pass 2's repairs
   were reviewed and pass 2's findings verified cleared — but the repair commit introduced
   **F9 recurrence 5**: the commit whose subject is *"F9 sweep my own F5 repair skipped"* claimed
   *"all seven now swept, only :124 remains"* when the residual was at least three, two of them
   inside client report fences, and the two lines it *added* were themselves the banned construct
   inside the fence that bans it. Of the five commit-message claims tested, three verified TRUE,
   one substantively true with a non-reproducing citation, **one FALSE**. Repairs landed
   2026-08-12 and **have not themselves been reviewed** — a fourth pass is owed before this
   blocker can be called cleared. *(Contrastive round on `06b9a52`: primary Opus-class / second
   Sonnet-class — **CONTESTED, 5 findings**, 2 HIGH. The two lanes converged on the same survivors
   from different token families, independently. `ADVERSARIAL-LAYER.md` §4.4 recording rule.)*
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
