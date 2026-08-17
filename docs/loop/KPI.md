# KPI — Loop Learning Metrics (append-only cold rows)

Phase 3.2 KPI persistence (Master Improvement Directive 2026-08-09; ships with G5 —
spec in `MASTER-IMPROVEMENT-PLAN.md` §1b). The weekly routine appends **one cold row
per fire**; trends are read QUARTERLY at the STEP 5b sweep (`PIPELINE.md` hygiene §8),
never row-by-row. Metric definitions belong to `PIPELINE.md` § Learning metrics —
this file is the data, not the definition.

**Cold-row discipline**

- **Append-only.** Rows are never edited or deleted. A wrong number is corrected by
  appending a NEW row whose notes cell names the row it corrects (the ledger's
  rule-4 pattern: supersede, never rewrite).
- **One row per fire**, written at reporting time from that fire's own artifacts
  (eval fragments, gate output, `FAILURE-LEDGER.md` recurrence counters) — never
  reconstructed later from memory.
- **Uneditorialized.** The notes cell holds terse factual pointers ("F11 r5",
  "baseline 2026-08-08-v2.json", "PR #8") — no narrative, no judgment, no
  smoothing. Interpretation happens at the quarterly read, with the numbers cold.
- A fire with nothing to report in a cell writes `0` or `n/a` — an empty cell is
  indistinguishable from a forgotten one.

**Columns**

| column | meaning |
|---|---|
| date | fire date, ISO |
| regression rate | of expectations passing in the previous recorded baseline, the share now failing (target 0; any nonzero = do-not-merge + ledger entry) |
| repeat-failure count | `FAILURE-LEDGER.md` recurrence increments recorded since the previous row (target 0) |
| tool-correctness rate | agent runs clean of tool misuse / total agent runs this cycle |
| evals passed/total | aggregate across all suites run this cycle (e.g. 104/104) |
| caught pre-push vs post-push | findings stopped by gates/review before push vs found only after (e.g. 6/1) |
| notes | terse pointers only (ledger entries, baseline files, PR numbers) |

<!-- Data rows below. APPEND ONLY — one row per fire, newest last. -->

| date | regression rate | repeat-failure count | tool-correctness rate | evals passed/total | caught pre-push vs post-push | notes |
|---|---|---|---|---|---|---|
| 2026-08-10 | n/a — no suite run | 1 | 12/12 agent, 10/12 incl. coordinator | n/a — no suite run | 8/0 | directed wave, not a routine fire; F14-r1; corpus unchanged 534/590 rec + 539/590 maj; suite totals 596→602; 16 skills bumped; PR #9 |

**Column notes for the 2026-08-10 row** (kept here rather than in the notes cell, which the
discipline holds to terse pointers):

- **`evals passed/total` is `n/a`, and that is not an empty cell.** This fire ran no suite —
  it applied fixes found by the previous fire's blind runs. The corpus is unchanged at
  `534/590` as recorded and `539/590` under the majority convention. **Two figures, because
  this column's schema assumes one**, and `scripts/eval-corpus-report.sh` refuses to print a
  headline while five suites of twenty leave the Greek editor's slot uncounted and fifteen
  count it. The structural fix landed this fire (the slot now stays in `total` and never in
  `passed`), so the column becomes single-valued on the next re-run, not now. Four suites'
  totals shifted, so those rebaseline rather than compare.
- **`repeat-failure count` is scoped to this fire, not to the day.** One recurrence was
  recorded here: F14 Recurrence 1. The day carried more across earlier waves; counting those
  here would double-count them against the first routine fire's row.
- **`tool-correctness` is given twice on purpose.** Twelve agent runs (nine dispatches, three
  resumed) reported no tool misuse and clean validators. The coordinator made two errors in
  the same class: a directory `git add` swept an agent's in-flight file into the stage, and
  the explicit-path correction then omitted a finished file. A single blended rate would have
  hidden that every defect in this cell was mine.
- **`caught pre-push` counts gate FAILs only** — two claims-gate lexicon hits and six
  commit-scope-check failures, all on the coordinator's own commits. It does not count the
  defects agents found in skills, which are the fire's actual output, nor the four stale
  ruling pointers an agent found that no gate looks for.
| 2026-08-13 | 3 of 76 previously-passing expectations across 3 suites = 3.9% | 5 ledgered (F9 r5, F11 r6, F15 r2, F19 r1, F17 r3) | 11/11 agent runs clean of tool misuse; 2 self-caught checker false verdicts pre-report (geo sigma lookbehind, refresher non-DOTALL fence scan); 1 agent terminated on account spend limit, not tool error | 76/85 (geo 27/29, refresher 25/27 primary, alertmgr 24/29) | 11/3 — 11 gate stops on coordinator commits (commit-scope x3, claims-gate x6, check-f x2); 3 regressions found only at grading | directed wave, not a routine fire; blind-2026-08-13/{geo,refresher,alertmanager}.json; refresher graded 2-state (run-start suite 25/27, HEAD suite 24/27); geo 93.10% identical at 4.2.2/4.3.1/4.4.2 = suite at measurement ceiling; F15 r2 caught in flight; citation-divergence-check.sh 6 fails all on R3; W12 corroboration withdrawn; PR #9 not merged |
| 2026-08-17 | 8 of 229 previously-passing expectations across the 9 compared suites = 3.5% | 16 increments across 15 entries (F9 r6/r7/r8/r9/r10/r11, F11 r7/r8, F13 r3/r7, F15 r3/r4, F16 r2/r3, F8 r1/r2) | 11/11 grader runs clean of tool misuse; lane + coordinator runs not countable from this lane | 299/332 across 11 suites | n/a — not countable from this lane; see column note | directed wave, not a routine fire; blind-2026-08-17/*.json, 11 records as of 14:45Z with graders still running; 2 suites uncompared (performance-reporter, rank-tracker); content-gap-analysis record PROVISIONAL; 8 checker false verdicts self-caught pre-report; F13 r7 (backlink disavow); OPEN-FINDINGS 153-167; PR #9 ruled not to be merged (SETTLED-RULINGS M1) |

**Column notes for the 2026-08-17 row** (same convention as the two rows above — the notes cell
stays terse, the method lives here so the number can be re-derived).

- **READ FIRST — every number in this row is over the 11 records that existed at 14:45Z, and the
  wave was still producing records when it was written.** A twelfth (`content-quality-auditor`)
  landed minutes later and three more graders were running. The row is **not** re-derived for each
  arrival: this file's own discipline is one cold row per fire written from that fire's artifacts,
  and a row rewritten as records trickle in stops being cold. The correction path is this file's
  rule 1 — append a new row naming this one — not an edit here. The reason this warning exists at
  all is OPEN-FINDINGS 127, where a present-tense count in a register was falsified by eleven
  records landing after it was written.

- **`regression rate` denominator is the 9 suites where a per-expectation comparison was actually
  run**, summed from each prior record's own `passed`/`pass` field: alert-manager 24,
  backlink-analyzer 24, competitor-analysis 21, content-gap-analysis 29, domain-authority-auditor
  24, geo-content-optimizer 27, internal-linking-optimizer 26, keyword-research 29,
  technical-seo-checker 25 = **229**. Numerator is the 8 expectations each grader recorded as a
  genuine regression after eliminating the confounders: alert-manager e2.6/e3.1/e4.4 (3),
  keyword-research e3.3/e4.1 (2), internal-linking-optimizer e4.4 (1), backlink-analyzer e1.6 (1),
  geo-content-optimizer e2.1 (1). **`performance-reporter` and `rank-tracker` are in neither
  numerator nor denominator** — both records state the comparison was not performed because the
  brief scoped their reads away from the prior baseline, so their expectations are unmeasured
  rather than clean. **Second figure, because one record is provisional**: excluding
  content-gap-analysis (grader terminated on a spend limit before reporting; its own
  `grader_termination_notice` forbids citing its rate as a graded baseline) the denominator is
  **200** and the rate is **4.0%**. Both are given because the choice between them is a judgement
  and hiding it inside one number would be the thing this column exists to prevent.
- **`repeat-failure count` counts increments, not entries, and the two differ this fire.** Fifteen
  ledger entries dated 2026-08-17 carry sixteen increments: the F16 Recurrence 3 entry increments
  F16 → 3 *and* F9 → 7 in one entry. One of the fifteen, the F13 entry labelled *Recurrence 3*,
  is the sixth F13 recurrence wearing the third's label; it is counted once here regardless, and
  the numbering collision is filed as OPEN-FINDINGS 164.
- **`tool-correctness` is a grader-run rate only, and the gap is stated rather than filled.** All
  11 grading runs of this wave reported no tool error that reached a verdict. Three records report
  the same `scripts/eval-prompt.sh` id-prefix mismatch (the `--ids` listing prints `e1` while the
  lookup wants the bare integer), which is a script defect and not misuse, and none of the three
  let it touch a verdict. Separately, **8 checker false verdicts were self-caught before reporting**
  — 6 with an explicit count field (backlink-analyzer 2, domain-authority-auditor 2,
  geo-content-optimizer 1, internal-linking-optimizer 1) and 2 stated in prose (content-gap-analysis,
  technical-seo-checker) — which is the F7 inspect-before-recording discipline working, and is
  reported beside the rate rather than inside it. The skill lanes and the coordinator ran outside
  this lane's sight; one misuse incident from the same day is already on record as OPEN-FINDINGS 152
  and is deliberately not folded into a rate this lane cannot compute.
- **`evals passed/total` is `299/332` and carries two qualifications.** 14 of the 332 are
  greek-content-editor slots that sit inside `total` and in neither `passed` nor `failed`, per the
  convention F16-r1(d) fixed. One of the 11 records (content-gap-analysis, 33/34) is provisional and
  unconfirmed by its author. Nine of the twenty skills have no record of this date at all, so this
  is not a corpus figure.
- **`caught pre-push vs post-push` is `n/a` because this lane cannot see the wave's gate history**,
  not because nothing was caught. What this lane can count is its own: **7 gate stops on its own
  in-flight work before any push** — 3 `claims-gate` hard-lexicon hits, 1 `claims-gate` flip-manifest
  stop, 2 check (g) FAILs from anchor tokens that wrapped across a line, and 1 check (g) FAIL from a
  pointer whose target line moved under it mid-pass. A wave-level figure needs the coordinator's
  view of every lane and is left to the fire that has it.
