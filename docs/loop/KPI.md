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
