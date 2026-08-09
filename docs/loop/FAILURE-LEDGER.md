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
- **Recurrence**: 0 — near-miss 2026-08-09, no increment: the verification wave's
  changelog claimed "resolved confirmed-primary / [VERIFY] dropped" for a
  snippet-mechanism read (support.google.com egress-blocked — the primary was never
  opened); skill-reviewer Mode A flagged it under exactly this guard and the wave was
  FIXed pre-commit (tag kept, wording softened to "snippet-corroborated"). Guard
  confirmed live in its designed position. **Status**: rule encoded; reviewer enforces.

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

## F8 — 2026-08-08 · Review target mutated during an in-flight adversarial review

- **Failure**: the coordinator edited `.claude/agents/skill-reviewer.md` (a G4 harvest
  item) while a Mode A reviewer was reviewing the UNCOMMITTED working tree for the G1
  pilot. The reviewer's closing scan found 8 modified files where its opening scan saw
  7 — scope-purity FAIL on an otherwise SHIP-grade diff, and the mid-review edit itself
  carried a semantics error (verdict-cap wording that inverted ledger rule 5) that was
  only caught because the reviewer flagged the intrusion.
- **Root cause**: working-tree reviews have no frozen target; concurrent writers can
  change the reviewable unit mid-review.
- **Guard**: Mode A launches only against a frozen target — a committed SHA (preferred)
  or an explicit file manifest declared at launch; while a working-tree review is in
  flight, coordinator and implementers do not write inside the repo. Caught same-day by
  the reviewer's open-vs-close scan discipline; the offending edit was corrected and
  committed separately with the reviewer's semantic fix applied.
- **Recurrence**: 0. **Status**: guard live (this entry is the standing rule).

## F9 — 2026-08-08 · Deprecated-concept purges scoped per skill left sibling leftovers

- **Failure**: FID (retired 03-2024, ruling R4) survived THREE purges — the 4.0.1
  technical-seo-checker cleanup, the labels wave's two-reference purge, and the R4
  pointer refresh — because each swept only the skill in front of it. A fourth file
  (`build/geo-content-optimizer/references/quotable-content-examples.md`) still taught
  "FID <100ms" until today's repo-wide grep caught it.
- **Root cause**: concept deprecations executed as per-skill edits; shared concepts
  (CWV metrics, veto shorthands, schema patterns) live in MANY skills' references.
- **Guard**: standing rule — retiring or redefining any cross-skill concept requires a
  repo-wide grep sweep for the concept's tokens (all spellings/units) in the same wave,
  with the hit list resolved or explicitly queued; per-skill scoping is only valid for
  skill-local concepts. Applied today: `<2.5|<200ms|<0.1|FID|Affiliate links disclosed`
  swept repo-wide; remaining hits zero.
- **Recurrence**: **1** (2026-08-08, same day — the entry's own founding sweep claimed
  "remaining hits zero" while a FIFTH live FID file survived it:
  `research/competitor-analysis/references/analysis-templates.md:140`, caught by the
  Mode A reviewer's independent grep). Per rule 3 the guard failed and was REDESIGNED
  same day: manual grep claims are no longer the guard — `scripts/validate-tracking.sh`
  check (f) now runs a scripted deprecated-token sweep (FID / First Input Delay /
  affiliate-only T04) on every gate run, fault-injection-tested; retiring any
  cross-skill concept adds a row to its token list.
- **Status**: redesigned guard live (scripted, gate-enforced); recurrence counter at 1
  stands as the permanent record that the manual version failed.

## F10 — 2026-08-09 · Live trigger prompt existed nowhere but the trigger store

- **Failure**: preparing the approved G2 amendment (weekly STEP 6 issue-filing), the
  04:00Z check-in found the routine's current prompt (v4.1) unrecoverable from the
  repo: only superseded v1 is archived (`archive/v1-weekly-prompt-2026-07-18.txt`);
  v2→v4.1 were applied via `update_trigger` without committing the text, no git blob
  carries them, and the Routines API has no prompt-read path (`list_triggers` omits
  prompts). `update_trigger` replaces prompts wholesale, so amending STEP 6 without
  the verbatim baseline risks silently destroying four same-day upgrade waves.
- **Root cause**: prompt upgrades treated the trigger store as the system of record;
  the archiving habit that existed at v1 was dropped mid-cadence and no gate checked.
- **Guard**: standing rule — every `create_trigger`/`update_trigger` that sets a
  prompt commits the full text to `docs/loop/archive/` (versioned filename) in the
  same wave; the PIPELINE.md trigger-table row links the file. Recovery for v4.1:
  Sani pastes it from the Routines UI (claude.ai → Routines → weekly skill-update
  check), or the 2026-08-15 fired session is asked to archive its own opening prompt;
  whichever lands first unblocks the amendment.
- **Status**: gap **CLOSED 2026-08-09** (same day — resolution below); guard remains
  live, adopted from this entry forward.
- **Resolution (2026-08-09, supersedes the recovery plan above)**: a prompt-read path
  EXISTS after all — `list_triggers` returns each trigger's full stored prompt at the
  undocumented nested field `job_config.ccr.events[].data.message.content`. The
  morning's "no prompt-read path / `list_triggers` omits prompts" sub-claim is
  contradicted by today's full-payload read (132KB, sliced); whether the field was
  missed in a partial read or the surface changed is not reconstructible — either way,
  a NEGATIVE capability claim needs the full-payload probe too (PIPELINE.md:184
  spirit; no counter change — signature differs from F4's mutation class). Recovered
  and pinned verbatim: weekly v4.1 (10,818 chars, sha256 `2d16bcb5…`, store
  `updated_at` 2026-08-08T13:39:19Z — after the v4→v4.1 wave; content markers concur:
  Lane 7 RSI additions, openreview fallback, STEP 5b loop-KPIs, and no STEP 6
  issue-filing) at `archive/v4.1-weekly-prompt-2026-08-08.txt`; both DST flip prompts
  (same store-only class, created pre-guard) at
  `archive/dst-flip-{1,2}-prompt-2026-08-08.txt`. Guard UNCHANGED and still binding:
  the nested field is undocumented and may vanish — the repo archive stays the system
  of record. G2's second prerequisite is satisfied; the STEP 6 amendment now waits on
  the Issues toggle alone.
- **Guard scope precision (2026-08-09)**: the archive-on-write rule binds durable/
  recurring prompts (the weekly routine, DST flips, any future routine). One-shot
  monitor check-in cursors (the `send_later` chain) are EXEMPT: they are
  wholesale-replaced derivations of the in-repo monitor policy (PIPELINE.md stage 5),
  never amended — the amend-without-baseline hazard this entry records cannot arise
  for them, and per-re-arm archive files would be noise.
- **Superseded (2026-08-09 ~07:51Z)**: Issues toggle flipped by Sani; G2 executed same
  day (queue issue #6; prompt v4.2 archived per this guard) — see the GATED-ITEMS
  fifth verdict-log entry. The resolution note's closing line ("waits on the Issues
  toggle alone") is historical as of that timestamp.

## F11 — 2026-08-09 · Close-out records drafted in one pass carried small integrity drifts

- **Failure**: three same-morning Mode A rounds on register close-out commits (F10
  closure `b51f65b` SHIP + advisory; G2 execution `000a906` FIX×2; G3 retirement
  `69455b6` FIX×4) found recurring drift classes in coordinator-drafted verdict
  records: a stale sibling field contradicting the new status (G3 "Verdict: _none
  yet_" three fields below "RESOLVED"); a forward-approximated timestamp postdating
  its own commit ("~08:25Z" inside a commit authored 08:17:49Z); attribution glosses
  presenting inference as evidence content ("the five … fall under the same
  site-health process" and "machine-independent" framed as paste facts; the
  `list_issues`-EMPTY behavior stated as a GitHub-wide fact). Six real findings
  total; all caught pre-merge (two commits reviewed pre-push, two fixed forward
  minutes after a hook-driven push); none reached main. This entry satisfies ledger
  rule 1 for both FIX verdicts.
- **Root cause**: single-pass drafting of multi-field register updates — sibling
  fields and evidence-class framing not re-scanned after a status flip; timestamps
  estimated instead of read from the clock.
- **Guard**: (1) Mode A review is MANDATORY for every commit that records a verdict,
  closes a gate, or flips a register status — no longer coordinator-discretionary
  (this morning is the evidence it pays: 6/6 findings real). Applying a review's
  specified fixes verbatim, plus the ledger record of that review, does not itself
  trigger a fresh round — the established fix-application pattern, else review
  recurses forever. (2) Close-out drafting checklist: after any status flip, re-scan
  the SAME entry for stale sibling fields (Status/Verdict/header triplet); read
  verdict-log timestamps from `date -u` at drafting time, never estimate; claims
  inside an attribution frame ("per the paste/response") must be quote-traceable —
  inferences move outside the frame with their real basis named.
- **Recurrence**: **1** (2026-08-09, same day — the W5 close-out placed "graduated"
  enforcement inside BOTH owner-verified frames while the pasted page contains no
  gradation language at all ("may be subject to certain restrictions" + a flat
  example list); "banner" for the page's "warning" fell in the same class. Guard (1)
  — the mandatory close-out review — caught it in its designed position, at BLOCK
  severity per ledger rule 5. Guard (2) — the drafting checklist — FAILED at
  drafting time; per rule 3 it was REDESIGNED same day: quote-traceability is now
  WORD-level — every content word inside a verified/CONFIRMED frame must itself
  appear in the evidence text, or the sentence moves outside the frame with its
  real basis named; the coordinator runs the word check at drafting and Mode A
  repeats it mechanically. Fixes applied verbatim the same hour
  (entity-optimizer 4.1.4).)
- **Recurrence 2** (2026-08-09, hours later — the PR-#5 merge-transition entry
  asserted two failure MECHANISMS ("eaten by HTML sanitization"; "stripped by a
  prior body update") inside its found-on-inspection frame, where the evidence
  attested only the observables: placeholder missing with a dangling arrow; footer
  absent despite having been sent — drop mechanism never established. Guard (1)
  caught it at BLOCK, again in designed position; the word-level checklist
  (redesign 1) failed at drafting a SECOND time. **Redesign 2 (rule 3 —
  structural, since per-word vigilance twice proved insufficient)**: close-out and
  verdict-log records now separate OBSERVED (evidence-traceable statements only)
  from DIAGNOSIS (a labeled, explicitly-unverified clause where mechanisms and
  causes live — e.g. "(diagnosed, not platform-verified: …)"); mechanism words are
  excluded from observed frames by construction, and Mode A enforces the
  separation mechanically. Fix applied with the reviewer's exact wording.)
  **Status**: guard live, twice redesigned; recurrence 2 stands as the record that
  vigilance without structure was insufficient.

## F12 — 2026-08-09 · Settled-ruling line-number pointers break on every changelog insertion

- **Failure**: SETTLED-RULINGS' `VERSIONS.md:<line>` pointers went stale for the
  THIRD time in two days — refreshed after the 2026-08-08 labels wave, re-refreshed
  after the v4.3.1 insertion (2026-08-09 morning), broken again the SAME DAY by the
  v4.3.2 changelog insertion (+6 lines shifted :87/:91/:92 → :93/:97/:98; caught as
  finding 4 of the W5-closure Mode A round). A pre-existing sibling: GATED-ITEMS'
  `VERSIONS.md:79-88` (v3.0.0 content) had silently drifted to :127 at some earlier
  insertion. Bare line numbers into an append-at-top changelog break structurally on
  every release.
- **Root cause**: the pointer format encodes a coordinate that every changelog
  insertion invalidates; freshness depends on remembering a manual refresh pass.
- **Guard**: pointer format changed — every `VERSIONS.md` pointer in the loop
  registers now carries an anchor token beside the line number (e.g.
  `VERSIONS.md:93` ("non-levers")); refreshing = grep the token, and a line/token
  mismatch is self-evident to any reader. Applied this wave to all six affected
  pointers (R1, R2, R3, R4, the pinned-baseline row, GATED-ITEMS G1). Durable
  upgrade QUEUED (GATED-ITEMS slow-loop list): a scripted `validate-tracking.sh`
  check that greps each anchor-tagged pointer's target line for its token,
  fault-injection-tested per the F2/F9 precedent — until it ships, the anchor
  format + Mode A's pointer checks are the live guard.
- **Recurrence**: **1** (2026-08-09, same wave — the founding commit itself shipped
  all six pointers stale at birth: the wave's own v4.3.3 changelog insertion
  (+8 lines) re-shifted every target AFTER the coordinates were grepped and BEFORE
  the register commit; committed :93/:97/:98/:127 vs actual :101/:105/:106/:135 at
  merge — the same shape as F9's founding "remaining hits zero". Caught by the
  wave's own Mode A round: the interim guard DETECTED but did not PREVENT.
  **Redesign (rule 3)**: (i) drafting-sequence rule — pointer coordinates are
  grepped against the FINAL tree, after every changelog/release insertion of the
  wave exists in it; register commits go LAST; (ii) the scripted check (g) is
  PROMOTED from the slow-loop queue to the next wave — detection without
  prevention is not a guard. Fix-forward applied post-merge with a final-tree
  re-grep (current coordinates :108/:112/:113/:142 after the v4.3.4 insertion —
  on any future mismatch the TOKEN is authoritative, never a recorded number).)
  **Status**: anchor format + sequence rule live; scripted check promoted
  (implement next wave).
