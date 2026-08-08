# Failure Ledger — the Anti-Repetition Memory

The recursive loop is only learning if it stops repeating its own mistakes. This ledger
is that memory: every pipeline failure becomes a dated entry, and **every entry must add
a guard** — an eval expectation, a validator check, a prompt rule — so the same failure
class cannot silently recur. Mirrors the team's local learning-ledger discipline.

**Rules**
1. APPEND an entry for: any skill-reviewer FIX/BLOCK verdict, any eval regression, any
   reverted commit, any operational incident (wrong trigger state, broken gate, bad
   push), any fabrication caught anywhere.
2. Every entry names its GUARD and where the guard lives. An entry without a guard is
   open work, not a record.
3. RECURRENCE: if a failure matches an existing entry's signature, increment that
   entry's recurrence count instead of writing a new one — a recurrence means the guard
   FAILED and its redesign becomes a mandatory finding. Repeat-failure count is a
   quarterly loop-KPI (PIPELINE.md hygiene §8); the target is zero.
4. Entries are append-only and dated (ISO). Never delete; supersede with a note.
5. skill-reviewer (Mode A) checks every reviewed diff against this ledger: a diff
   reintroducing a ledgered failure pattern is a BLOCK.

**Learning metrics this ledger feeds** (definitions in PIPELINE.md § Learning metrics):
regression rate · repeat-failure count · tool-correctness rate.

---

## F1 — 2026-08-08 · Duplicate weekly routines both enabled (near double-fire)

- **Failure**: v1 and v2 weekly routines both `enabled=true` on identical cron
  `0 4 * * 6`; would have double-fired 2026-08-15 (04:00:47Z and 04:08:36Z).
- **Root cause**: routine state assumed from a UI action instead of verified via API.
- **Guard**: duplicate-cron tripwire (PIPELINE.md hygiene §5) + quarterly trigger sweep
  (weekly prompt STEP 5b) + read-back verification rule (see F4 — it caught two failed
  UI disable attempts before Sani's successful deletion).
- **Recurrence**: 0. **Status**: CLOSED 2026-08-08 — v1 deleted by Sani (UI pause
  unavailable; delete-only), absence API-verified; prompt archived in
  `docs/loop/archive/`. Guards remain live for future duplicates.

## F2 — 2026-08-08 · Stale README version badge survived multiple releases

- **Failure**: README badge sat at 3.0.1 while the library shipped 4.x — tracking-file
  drift invisible to every existing check.
- **Root cause**: 5-file tracking sync was manual with no consistency checker anywhere.
- **Guard**: `scripts/validate-tracking.sh` check (a) (fault-injection-tested) enforced
  by `scripts/pre-push-gate.sh` + the PreToolUse push hook.
- **Recurrence**: 0. **Status**: guard live.

## F3 — 2026-08-08 · Skill worked-example modeled statistic fabrication

- **Failure**: geo-content-optimizer's worked example demonstrated inserting named
  third-party statistics absent from the input and self-awarding a score lift — teaching
  the exact failure the skill's rules forbid.
- **Root cause**: example authored for impressiveness; numeric thresholds (≥5 stats)
  create an incentive to invent numbers when input data is thin.
- **Guard**: statistics rule in the skill (sourced/cited/placeholder — never invented) +
  a no-fabrication expectation in EVERY eval of all three pilot suites + the zero-data
  eval that rewards honest threshold misses.
- **Recurrence**: 0. **Status**: guard live.

## F4 — 2026-08-08 · State change recorded from the call, not the response

- **Failure**: an audit draft recorded v1 as "disabled 2026-08-08" because the transcript
  showed the disable CALL — the response was actually a refusal (http_api-created
  routine; agents cannot modify it). Nearly committed a false registry row.
- **Root cause**: mutation assumed successful without reading the API response.
- **Guard**: standing rule — never record a state change without the confirming
  response; verify post-mutation state via a read call. skill-reviewer Mode A treats
  unverified state claims in diffs as a FIX finding. (Caught pre-commit by coordinator
  review — this ledger entry makes the rule durable.)
- **Recurrence**: 0. **Status**: rule encoded; reviewer enforces.

## F5 — 2026-08-08 · Freshness checker counted future dates as review stamps

- **Failure**: first run of `check-freshness.sh` reported negative ages — deadline dates
  (DST 2027, myDATA 2026-09) were taken as "newest review date".
- **Root cause**: "newest date in file" semantic never examined against forward-looking
  dates the files legitimately contain.
- **Guard**: non-future-date filter in the script + verified rerun; failure documented
  in the script header comment.
- **Recurrence**: 0. **Status**: fixed same day, guard live.

## F6 — 2026-08-08 · Designated egress mirrors were themselves egress-blocked

- **Failure**: the weekly prompt designated semanticscholar.org and huggingface.co as
  arXiv fallback mirrors; both are blocked from this environment — lanes would have
  burned attempts exactly as the rule meant to prevent.
- **Root cause**: fallback paths written from general knowledge, never tested from the
  actual runtime environment.
- **Guard**: mirror reality verified 2026-08-08 (openreview.net + WebSearch-snippet
  triangulation is the working fallback); prompt v4 + PIPELINE constraints corrected;
  standing rule: fallback paths must be verified from the environment that will use them.
- **Recurrence**: 0. **Status**: guard live.

## F7 — 2026-08-08 · Grading scripts produced false verdicts on real evidence

- **Failure**: two same-day instances during the v2 Mode B wave: (1) schema run — a
  claim-scan regex missed markdown-bold negations and reported protected item e3.9 as
  FAIL, which would have been recorded as a regression; (2) keyword eval-1 rerun — a
  table parser matched the literal "| G1" data row as a header, silently skipped two
  rows, and produced a false E5 failure. In both cases the DELIVERABLE was correct;
  the checker was wrong.
- **Root cause**: scripted checks trusted as verdict-authoritative without inspecting
  the evidence they claimed to have matched; regex/parser assumptions never tested
  against the actual output format.
- **Guard**: standing Mode B rule — before ANY failure (especially a would-be
  regression) is reported, the grader must inspect the raw output at the flagged
  location and quote it; grading scripts must print the matched/unmatched evidence,
  not bare booleans. Both instances were caught by exactly this evidence-inspection
  step working as designed — this entry makes the step mandatory rather than habitual.
- **Recurrence**: 0 (two instances in one wave counted as the founding pattern; a
  future false verdict that ESCAPES into a report increments this).
- **Status**: guard live; encoded in the skill-reviewer Mode B discipline.
