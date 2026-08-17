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
