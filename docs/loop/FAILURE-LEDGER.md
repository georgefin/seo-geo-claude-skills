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
- **Recurrence 2** (2026-08-09 — the same per-skill-scoping signature with R3's
  tokens: the 2026-08-08 FAQ-rich-results retirement was purged only inside
  schema-markup-generator, and the redesign's own closing rule ("retiring any
  cross-skill concept adds a row to its token list") was never executed for R3 —
  ruled the very day the rule was written. Nine live eligibility claims survived
  in five sibling skills (serp taxonomy ×4, content-gap frameworks, writer
  templates ×2, content-refresher example, meta-tags CTR reference), surfaced
  2026-08-09 by two independent E2 Mode A reviewers (designed position).
  **Redesign (rule 3)**: the token-list rule gains the F13-r1 BACKFILL shape —
  it binds retroactively to every previously ruled retirement, not only future
  ones. Executed same wave: check (f) R3 sub-sweep (fault-injection: injected
  claim FAILs printing file:line:text, restore PASSes, docs/loop exclusion
  verified load-bearing — SETTLED-RULINGS' own R3 text stays legal); all nine
  instances rewritten to post-R3 truth with five patch bumps; retirement audit
  confirms R3+R4 are the complete set of ruled retirements and both carry token
  rows. A ruled retirement shipping without its same-wave token row, or a
  backfill gap found later, increments this counter.)

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
- **Recurrence 3** (2026-08-09, hours later — the v4.3.5 changelog bullet, PR #7
  body, and one GATED-ITEMS queued row stated "local path-add + install succeed
  end-to-end" inside a probed frame. The observed evidence was two success
  RESPONSES (marketplace add; plugin install); "end-to-end" was an unlabeled
  extrapolation to a working end state. The coordinator's own deeper probe
  minutes later showed the file-source install in "failed to load: cache-miss"
  state and the directory-source install rejected outright at manifest
  validation (the recorded W8 trio) — pushed 10:10–10:12Z, contradicted 10:17Z,
  corrected in the same session before anyone relied on it, but it REACHED the
  pushed branch (unlike recurrences 1–2, caught pre-reliance in review). Guard
  scope EXTENDED per rule 3: the OBSERVED/DIAGNOSIS separation and word-level
  traceability bind EVERY probed/verified frame in pushed prose — changelogs,
  PR bodies, queued rows — not close-out records alone; "works"/"end-to-end"
  claims require the END STATE observed (e.g. `claude plugin list` status, a
  loaded skill), never a mutation response alone. Mode A enforces this on the
  same frames.)
- **Recurrence-3 confirmation (2026-08-09)**: the delayed Mode A round on
  b888110..b3e4ca9 independently reproduced the install-rejection probe and
  returned BLOCK on exactly this instance — the corrected wordings verified
  response-exact, the counter increment stands, no further fix on those
  locations. The BLOCK landed as fix-forward confirmation rather than a
  pre-merge stop because Sani's merge order executed while the round was in
  flight; the ordering rule is now recorded (PIPELINE stage 3): the review is
  never skipped, only its landing point moves.
- **Recurrence-3 record precision (2026-08-09, covering Mode A)**: the quoted
  phrase appeared verbatim in the changelog bullet (and PR #7 body per the
  correcting session); the GATED-ITEMS queued row's actual wording was "local
  path-add + install succeed with the upstream-attributed manifests" — same
  class, variant wording; match the signature on the class, not the string.
- **Recurrence 4** (2026-08-09, covering Mode A round on 39745fb + f719ada +
  f5e64fe + c8330d7 — verdict BLOCK: the G1 continuation note's closing
  sentence "The decision itself remains Sani's…" was written pre-approval
  (39745fb, 10:20Z) and left standing while f719ada (+APPROVED) and c8330d7
  (+EXECUTED) flipped the entry's status directly above it — a stale
  status-bearing sibling in the gate-authority register, the entry's founding
  class. Guard (2) REDESIGNED per rule 3: the post-flip re-scan covers EVERY
  bullet and sentence of the flipped entry — not the Status/Verdict/header
  triplet alone — and the F10 house pattern ("historical as of that
  timestamp" supersession notes) is the required form for prose left behind
  by a same-entry flip. Fixes applied with the reviewer's exact wording, same
  hour; also applied: the recurrence-3 quote-precision note above and the
  Finding-3 relabel of the classifier-denial gloss.)
- **Recurrence 5** (2026-08-09, ninth-entry Mode A round — the entry itself
  verified clean on all 16 lines (probe reproduced byte-exact, git facts
  confirmed), but the PR #8 merge it records had falsified two live-state
  claims ELSEWHERE in the same register, left unmarked: the attribution queued
  row's "installs are blocked" and the G1 note's "still draws the W8 trio
  until this wave merges" — both true pre-merge, both false against main at
  commit time; the G1 Status field also stopped at EXECUTED where the
  register's own convention records MERGED. Guard REDESIGNED per rule 3
  (third scope widening: word → entry → REGISTER): a recorded flip triggers a
  re-scan of the WHOLE register for every live-state claim the event touches —
  the scope the catching round itself had to use — with the F10 "historical
  as of" note remaining the required form for prose a flip leaves behind.
  Fixes applied with the reviewer's exact wording, same hour.)
- **Recurrence 6** (2026-08-09 — the eleventh verdict-log entry, 16:13:33Z,
  recorded the RELEASE of G5/G6/G7 + G8's executable scope while the four
  G-blocks written ~30 minutes earlier kept Status "GATED … Releases on Sani's
  words" and the register header kept "Currently gated: G5–G8" — the founding
  stale-sibling class at register scale; the r5 whole-register re-scan was
  skipped at drafting time. Caught OUT-OF-DIFF by the E1 on-page suite's Mode A
  reviewer (designed position: every round checks the registers against the
  ledger). Fixes applied same hour: four Status flips + header rewrite.
  **Redesign (rule 3)**: the vigilance form of this guard is retired as
  primary — the scripted claims-gate (G5 delivery; its fixtures
  f11-r4/f11-r5 reproduce exactly this class and its acceptance test caught
  5/5 gate-detectable instances) becomes the guard when wired into
  `pre-push-gate.sh`, planned as the first commit after the in-flight wave
  close-out push; until that wiring lands, every register commit message must
  carry the flip re-scan as a written checklist line — evidence of the scan,
  not memory of it.)
- **Wired (2026-08-09 [obs:2026-08-09T21:09:18Z integration commit])**: the
  claims-gate runs inside `pre-push-gate.sh` on per-push scope from this commit
  forward — the r6 interim rule (written checklist line) retires, replaced by
  the machine form: a `FLIP:` trailer in the register commit message drives the
  whole-register sweep. The commit landing this note carries both forms as the
  crossover record. Pre-gate branch history goes to the Mode A covering round
  rather than being retro-anchored. Its first run, the same hour, held
  the integration push itself — a v4.4.1 changelog edit had re-added a line
  whose untouched tail carried unanchored hard-lexicon tokens
  (`VERSIONS.md:38`); the line was reworded before the push went through
  [obs:2026-08-09T21:10:37Z gate output, integration-push run]. The guard
  PREVENTS from its first invocation, closing the same gap F12's check (g)
  closed for pointer drift.

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
- **Shipped (2026-08-09, same day — supersedes "implement next wave" above)**:
  check (g) live in `validate-tracking.sh` (implementation commit `fdedb6c`;
  check (a) shim extension in `fd6f289`). Fault-injection evidence at
  implementation: wrong-line and broken-token injections FAIL printing the
  pointer and the actual target line; restored copy passes 6/6; negative
  control verified load-bearing (the ledger's own historical `:93` example
  would have tripped if this file were scanned — it produced zero findings,
  proving the scope exclusion). First live gate run the same day: the v4.3.5
  changelog insertion shifted all six pointers and the gate BLOCKED the push
  until the register re-anchor commit landed — the guard now PREVENTS, closing
  the detection-without-prevention gap this entry records. Recurrence counter
  stays 1 as the permanent record.

## F13 — 2026-08-09 · Binding-editor content lesson stored note-only recurred in the next run's outputs

- **Failure**: the v2 baseline recorded "agency-perspective provenance labels must not
  leak into customer-visible copy" as a lesson in its `greek_quality_summary` — fed to
  notes, carried by no skill rule and no eval expectation. The v3 geo run (skill 4.1.5)
  reproduced the class: unbracketed «απαιτούνται στοιχεία προϊόντος» inside a published
  FAQ answer, mirrored verbatim into the paste-ready FAQPage JSON-LD, plus an
  unbracketed publishable table cell (greek-out-geo-2.md lines 40/66/125). Mode B
  graded the run 29/29 — eval e2.5's own wording steered the marker INTO the answer
  ("the answer hedges or marks …"), so the structural layer rewarded the failure — and
  the class was caught only by the binding greek-content-editor pass (FAIL verdict, its
  designed position; the editor charter makes v2-ruled-class regressions FAIL-grade).
- **Root cause**: content-class lessons recorded as baseline prose have no enforcement
  carrier; and an eval expectation written placement-blind taught the failure (kin to
  F3's example-taught fabrication).
- **Guard** (structural, adopted this wave): every content-class lesson from a binding
  editor pass must land in the SAME wave as a skill-rule line or an eval expectation —
  note-only recording is open work, not a guard (mirrors ledger rule 2). First
  application: geo-content-optimizer 4.1.6 placement rule (Statistics rule + Output
  Validation checklist) + the e2.5 placement rework, commit `b411592`.
- **Recurrence**: 0 — the v2→v3 recurrence IS the founding observation (the class
  predates the entry; F7/F11 founding-count convention). A future note-only lesson, or
  this class re-leaking with the carrier in place, increments it.
- **Status**: skill fix committed (`b411592`). Validation leg: the first re-run agent
  (launched ~12:1xZ) terminated at start on the account's weekly API limit ("You've
  hit your weekly limit · resets 4pm (UTC)" — the stall also froze the coordinator
  session ~12:20→16:05Z); relaunched after the 16:00Z reset (clock-read 16:05:55Z) —
  full geo re-run at 4.1.6 + editor re-judge of the fresh outputs; the v3 baseline
  records the arc whichever way the re-run lands.
- **Recurrence 1** (2026-08-09, the validation leg itself — the post-reset r2
  re-run at 4.1.6 came back provenance-clean (the founding carrier held; Mode B
  29/29 with a zero-violation placement scan), but the editor re-judge FAILed
  geo-2-r2 on «Όλα τα 18 μοντέλα» — the totality calque ruled FAIL-grade in the
  v1 editor pass, whose ruling had lived note-only in baseline prose ever since.
  Signature match, not a new entry: a ruled content class with no enforcement
  carrier recurred in the next run; the founding fix carried ONE class and left
  every earlier ruling uncarried. **Redesign (rule 3)**: the guard gains a
  BACKFILL obligation — same-wave carriage applies retroactively to ALL
  previously issued FAIL-grade rulings, not only new ones. Executed this wave as
  `anti-slop-ruleset.md` §6 "Ruled Greek Regression Classes": every FAIL-grade
  family from the v1/v2/v3 editor passes tabled with greppable signatures
  (e.g. `Όλα τα [0-9]` → «και τα [N]»), advisory families listed beneath, new
  rulings append in the same wave they are issued; carried by seo-content-writer
  4.2.1 (the ruleset's owning skill). Validation leg: geo eval-2-only r3 at
  unchanged 4.1.6 + ruled-families scan of the fresh output + editor re-judge;
  the v3 baseline records the full three-iteration arc.)

- **Recurrence 2** (2026-08-10, blind Mode B run of the meta-tags-optimizer suite —
  the placement class re-leaked, and this time the skill's own reference file taught
  it). **Instance**: the deliverable shipped
  `content="TO SUPPLY — absolute URL, 1200x630px JPG/PNG"` inside `og:image` and
  `twitter:image` — the exact shape four expectations of that suite forbid ("no
  bracketed tokens ('[Brand]', '[Number]', '[Year]'), no 'TBD'/'XX', and no
  data-needed markers appear inside a proposed <title>, meta description, or social
  tag value"). Matched on class, not string. Recorded from the blind run's grader
  report (2026-08-10); that deliverable is not in the repo tree, so this entry states
  the grader's finding, not a file this author read (F4 discipline).
  **Root cause**: the grader traced the behaviour to the skill, not the model —
  `build/meta-tags-optimizer/references/meta-tag-code-templates.md` introduced its
  complete block with "Copy and paste this complete meta tag block:" and then put a
  bracket token in every value, `content="[Image URL - 1200x630px recommended]"`
  included, so a model with no image asset produced what the paste-ready example
  modelled. F3's shape (a worked example modelling the behaviour the rule forbids)
  applied to F13's placement class. The founding carrier never reached here: the
  2026-08-09 fix put the rule in geo-content-optimizer's Statistics clause and in this
  suite's expectations, i.e. on the grader's side, while meta-tags-optimizer's own
  SKILL.md and references — the surfaces the executor reads — said nothing. An
  expectation is a carrier for whoever grades, not for whoever writes.
  **Redesign (rule 3)**: same-wave carriage now has to land on the surface the executor
  reads, and specifically on every paste-ready worked example, not only in rules prose.
  Applied as meta-tags-optimizer 4.1.3 — the reference file splits into a filled
  illustrative block (every value resolved on the reserved `example.com` host, and the
  only place the "copy and paste" framing sits) and a fill-in skeleton labelled NOT
  ship-ready, with the value rule stated at the top of the file and an inline
  `<!-- SKELETON ... -->` first line inside every bracketed fence so the marker travels
  with the code when only the fence is copied; the filled example leaves out
  `twitter:site` on purpose, demonstrating the drop-the-tag-and-name-the-gap remedy for
  an unavailable value; SKILL.md step 4 gains the placement rule and Output Validation a
  matching checkbox; the two sibling references get the same one-line rule; and the
  skill's own worked example stopped putting `[current year]` inside a `<title>` and a
  `content=` attribute (same F3 shape, one file over).
  **Could a script catch this class?** Half of it, and the split is the useful part. On
  the deliverable side, yes and cheaply: a scan for a `[`…`]` token, `TBD`, `XX`, or "to
  supply" inside `content="…"` / `href="…"` / between `<title>` tags would have caught
  this instance outright, because the offending text sits inside quoted attribute values
  in a known syntax. What it cannot decide is intent — the CTR device
  `[Equipment + Software + Tips]` is a legitimate shipped bracket in a title — so it is a
  review trigger, not a verdict (§6 family-5 precedent). On the cause side it is weaker:
  a deliverable scan flags the output and never names the template that taught it. That
  needs a repo-side lint — paste-ready framing within a few lines above a fence whose tag
  values carry bracket tokens — which is expressible as a grep pair and would have fired
  on this file, but which also has to exempt files whose whole subject is skeletons.
  Neither is bolted on inside this fix; both are proposed as a scripts-wave item, and
  this note records the gap as a tooling gap rather than an unknown. Counter reading with
  this entry: 2.

## F14 — 2026-08-10 · Parallel agents' untracked files swept into a coordinator commit by `git add -A`

- **Failure**: the identity commit `67ecad7` ("chore(identity): re-attribute fork
  manifests to georgefin, keep upstream credit") also carried four eval fixtures
  under `monitor/backlink-analyzer/evals/files/` — written by a parallel authoring
  agent whose first attempt had died mid-run from an API credit error, leaving its
  fixtures untracked in the shared working tree. The coordinator staged with
  `git add -A`. Nothing was lost and no file was wrong; the RECORD was wrong. A
  commit message that accurately describes its own scope, sitting on top of files
  from an unrelated workstream, is precisely the kind of false provenance the whole
  Mode A review layer depends on being able to trust. Detected by the backlink
  author's own scope-boundary report on its second attempt, which found its
  "untracked" fixtures already committed by someone else — not by any gate.
- **Root cause**: coordinator sessions run authoring agents concurrently, so the
  working tree routinely holds another actor's untracked output. `git add -A` and
  `git add .` stage by tree state, not by intent, and the committer never sees what
  it swept. Every prior wave got away with it only because the timing never
  overlapped a commit.
- **Guard**: `scripts/commit-scope-check.sh`, wired as check 4 of
  `pre-push-gate.sh` (same per-push `@{upstream}` scope as claims-gate). Per
  outgoing commit it collects the skill directories touched under
  `build|research|optimize|monitor|cross-cutting/<skill>/` and FAILs when the
  subject line does not name them; a genuine multi-skill commit declares breadth
  instead (`library-wide`, `sweep`, `purge`, `wave`, `all skills`). Verified
  against the founding instance before wiring: run on the breach it prints the
  four offending paths and exits 1; run on the clean tree it passes. History
  pushed before the guard existed is grandfathered by construction — it is no
  longer outgoing — which is the honest treatment, since the guard cannot testify
  about staging decisions it never observed.
- **Not repaired by history rewrite**: `67ecad7` is already pushed to an open PR
  branch. Force-pushing to correct a provenance label would trade a small
  documented inaccuracy for a rewritten shared history, and the ledger entry plus
  the backlink suite's own commit body already carry the correction. The four
  files are in the right place and are covered by the backlink-analyzer suite's
  Mode A review regardless of which commit introduced them.
- **Recurrence rule**: a second instance of another actor's files landing in a
  commit that does not declare them means this guard failed and needs redesign
  (ledger rule 3) — not a reminder to stage more carefully.

- **Second mechanism, same failure family (2026-08-10, hours after the founding
  instance)**: the §6-carrier agent's one-line pointer refresh in
  `docs/loop/GATED-ITEMS.md` (`VERSIONS.md:173→175`) landed inside the coordinator's
  G9/W12 register commits, which describe unrelated work. Reported by that agent, not
  caught by any gate. **This is NOT a recurrence of the guarded failure**, and the
  distinction is load-bearing rather than an excuse: the founding instance was
  `git add -A` sweeping files the committer never looked at, and the guard closes
  exactly that. Here the coordinator staged one explicitly named file it was
  legitimately editing — the other workstream's change was already inside that file,
  because both actors edit the shared registers. `commit-scope-check.sh` cannot see it:
  its unit is the skill directory, and a register file has no owning skill.
  **Why no bolt-on fix was attempted**: the honest mitigation is sequencing (hold
  register commits while a register-writing agent is in flight), and sequencing is
  vigilance, which the directive's own "no manual vigilance" principle rejects as a
  guard. Converting it to code needs an advisory lock protocol — a writer records
  its held register paths, and the gate refuses a commit touching a path another
  holder had open — which is a scripts-wave proposal, not something to bolt on
  mid-wave. Queued as such. Until it exists, this residual is ACCEPTED and named:
  register commits made while parallel agents are running may carry a stray
  correct-but-undeclared hunk. Consequence is record accuracy, never content loss,
  since every such hunk is itself a verified fix.
- **Residual CLOSED 2026-08-10 (`4a1d238`)**: the lock protocol described above as "a
  scripts-wave proposal" was built and wired the same day as pre-push check 5 —
  `scripts/register-lock.sh`, an append-only gitignored journal of ACQUIRE / RELEASE /
  BREAK tenures. Two legs, because one is not enough: **prevention** refuses an
  `acquire` on a path another holder still has open, and **detection** fails an
  outgoing commit that touched a locked path inside another holder's tenure without a
  `Register-Lock: <holder>` trailer. Stale tenures are bounded by a 90-minute horizon,
  reported rather than silently honoured, and overridable with the break recorded — a
  crashed agent cannot deadlock the repo. Acceptance was demonstrated before wiring,
  in a scratch repo, against this entry's own failure shape.
  **What it still cannot answer, stated because the guard would otherwise overclaim**:
  git carries no session identity in a shared worktree, so "was this commit made by
  the holder?" is not decidable from the commit alone. Attribution therefore rests on
  the declaration trailer — which means a commit made inside your OWN tenure without
  the trailer also fails, and must declare itself. A writer that never calls `acquire`
  is outside the ledger entirely; the mechanism is advisory at the write end and
  enforcing only at the push end. Zero friction when nobody announced a path: no
  journal covering a commit means nothing is asserted, so a solo session pays nothing.
- **Third mechanism — and this one IS the guarded failure, by the guard's own author
  (2026-08-10, `c1845e8`)**: the coordinator's register closures for F14 and the
  check (g) question landed inside a commit whose message describes only an
  agent-definition fix. Chain: commit, gate and push were issued as one compound
  shell command; the push-guard hook refused the whole command before the commit ran;
  the staged register files therefore stayed staged; a later `--amend` intended only
  to reword one ledger line swept them into the preceding commit. Caught by reading
  `git show --stat` after the push, not by any check.
  **Unlike the second mechanism, this is not a scope-gap excuse.** Content landed in a
  commit that does not declare it — the exact statement of this entry's failure — so
  under rule 3 the guard needed redesign, and got one the same hour.
  **Redesign**: `commit-scope-check.sh` gains a register leg. Its skill leg was
  structurally blind here because a register file has no owning skill; the new leg
  requires any commit touching `docs/loop/*.md` or `VERSIONS.md` to MENTION that
  register somewhere in its message, by basename or by a documented alias. The rule is
  deliberately weaker than the skill leg — mention, not declaration in the subject —
  because registers legitimately ride along with the work they record, and a strict
  rule would train the writer to split commits that belong together.
  **Verified against this instance before wiring**: pointed at `c1845e8` it fails and
  prints the undeclared register; pointed at the wave's legitimate register commits it
  passes. **Stated limit**: the alias vocabulary can absorb an incidental word — this
  very instance's message contained "verdict", which cleared `gated-items` while
  `failure-ledger` was still caught. The leg therefore reduces the failure rate rather
  than eliminating it, and a commit whose message happens to contain an alias for every
  register it touches will pass undeclared. Two process lessons recorded with it, both
  cheap: never compound commit with push in one command, since a hook that refuses the
  command leaves the tree in a state the next command inherits; and never `--amend`
  without reading `git show --stat` first.
