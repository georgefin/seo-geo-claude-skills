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
  eval that rewards honest threshold misses + `scripts/validate-tracking.sh` check (h),
  the scripted quotation-attribution guard added 2026-08-10 (what it catches, and what it
  explicitly does not, in the redesign below).
- **Recurrence**: **1** (2026-08-10 — detailed below). **Status**: guard redesigned; the
  carrier now reaches the skill's reference files, not the skill body alone.
- **Recurrence 1** (2026-08-10 — geo-content-optimizer, the entry's own skill, with the
  founding guard sitting in that skill's `SKILL.md` the whole time).
  **Instance**: the skill's three reference files carried 13 statistics credited to real
  named organisations (BrightEdge; the Data & Marketing Association ×3; Hootsuite;
  Ahrefs; Backlinko; Gartner; Forrester; Wyzowl; Statista; HubSpot ×2) and three
  attributions to a person — a verbatim quotation placed in the mouth of a named,
  living industry figure (`quotable-content-examples.md:166`); a "Dr. Jane Smith, AI
  Research Director at Stanford University" credential, an invented person in an
  invented post at a real university, carrying an invented quote
  (`geo-optimization-techniques.md:78-79`); and an unsourced tactical claim credited to
  a named Google employee (`ai-citation-patterns.md:331`). Each sat in the GOOD half of
  a before/after pair, was named as the improvement by the file's own bullets ("Expert
  quote with credentials", "Research data with source"), and was scored "Citation
  likelihood: 9/10". Surfaced by the library-wide "examples that teach what the rules
  forbid" audit (findings C1/C2, 2026-08-10); the third file's two instances were found
  by this fix's own grep sweep rather than by the audit, which is itself evidence for
  the redesign below.
  **Why this class is the most serious in the library**: the output is published web copy
  under a client's byline, and two of the three personal attributions name real, living
  individuals. A fabricated statistic is an unverifiable claim; a fabricated quotation is
  a false statement about an identifiable person, published by someone who trusted this
  library. The damage lands on the user and on the person quoted, not on us.
  **Root cause**: the founding guard landed in `build/geo-content-optimizer/SKILL.md`
  (the statistics rule) and in the eval expectations, and never reached the three
  reference files the same `SKILL.md` routes the model into
  (`SKILL.md:183/323/337/338`). F13-r2 states the general form — an expectation is a
  carrier for whoever grades, not for whoever writes — and this is its sibling: a rule in
  the skill BODY is not a carrier for an example in a reference FILE. F9's
  per-skill-scoping signature, one level down, inside a single skill's own directory.
  **Redesign (rule 3)**: the carriage obligation gains a file-scope leg. (i) A content
  rule that governs examples is restated at the top of EVERY file that holds examples the
  skill routes to — executed this wave: the standing rule (*an illustrative example never
  attributes data or a quotation to a real organisation or a real person; use a clearly
  fictional attribution, or cite something genuinely verifiable*) opens all three
  reference files, with the executor-side clause added to the SKILL.md statistics rule,
  the routing line into the references, and the Reference Materials index. (ii) A fix to
  an example class sweeps the skill's whole `references/` directory in the same wave, by
  grep, not by memory (F9's redesign shape applied to this class) — the sweep here was a
  real-organisation and real-person name list run across the skill's four files, and it
  is what found the two instances the audit had not listed.
  **Could a script catch this class? Half of it, and the halves are worth separating.**
  The quotation half is tractable and cheap: a pattern for `"…," says|explains` or
  `according to <Capitalised Name>` inside a skill or reference file, with no URL on the
  line or within ±2 lines, has near-zero legitimate hits in this library (after this fix,
  zero), so it is buildable as a hard FAIL on the check-(f) model — a scripted token
  sweep plus an exclusion rule, fault-injection-testable. The statistics half is weaker:
  its practical form is a deny-list of real vendor/analyst/publisher names (Gartner,
  Forrester, HubSpot, Ahrefs, Statista, Semrush, Moz, BrightEdge, …) scanned across skill
  and reference files, which flags a legitimate citation exactly as loudly as a
  fabricated one — it cannot decide whether the author read the source, or whether the
  claim is true. That makes it a review trigger, not a verdict (§6 family-5 and F13-r2
  precedent), and its list needs the same maintenance check (f)'s does. Neither is built
  here: `scripts/` sat outside this fix's scope, so both are recorded as a tooling gap
  with a known shape rather than an unknown, and proposed as a scripts-wave item.
  **Guard built — `validate-tracking.sh` check (h), the quotation half, as a hard FAIL**
  (2026-08-10, scripts wave; the paragraph above is the design it was built to, on the
  check-(f) model). It sweeps the shipping skill, command and framework trees for four
  attribution shapes — a speech verb after a closing quote (`"…," says|explains|notes
  <Name>`), the same defect with the verb first (`<First Last> says|noted …`), `According
  to <Capitalised attributee>`, and a `— <Name>, <Role> at <Organisation>` attribution
  line — and FAILS any match with no `http(s)` URL on its line or within ±2 lines. The
  failure message names the three ways out rather than only the offence: cite a real
  source you read and can link, use a clearly fictional `Example …` attribution, or drop
  the attribution. Three exemptions, each checked by running the finished check against the
  current tree rather than assumed [obs:2026-08-10 `validate-tracking.sh` check (h): 1
  attribution shape seen, 1 exempt, 0 failures]: a URL inside the window; the reserved
  `Example …` attributee, tested against
  the MATCHED TEXT and not the line or the path, so a file named `example-report.md` is
  not blanket-exempted; and bracketed placeholders, which keep this skill's corrected
  TEMPLATE (`"[Quote]," says [Name], [Role] at [Organisation] — [… with a link]`) legal by
  requiring a capital letter where the attributee goes — the right shape stays teachable
  with no allowlist to maintain. Greek copy needs no exemption of its own: it quotes with
  guillemets « », not the ASCII `"` the patterns key on. `evals/` is excluded and that
  exclusion is load-bearing rather than cosmetic — content-refresher's stale-article
  fixture opens a paragraph "According to <Firm>'s 2022 SMB survey" as the defect the
  model is graded on finding; `docs/loop/` and `VERSIONS.md` sit outside the swept trees
  by construction, because the registers and the changelog quote the fabricated text
  verbatim, which is their job as the record. The library returns ZERO un-exempted hits,
  so the check starts GREEN and any future hit is a genuine regression, not a backlog —
  that property is the whole reason it is worth having, and it is the reason the
  statistics half below was not bolted on beside it. Fault-injection-tested in a scratch
  copy (never the real tree) against all four real historical instances — the Fishkin
  quotation, the Mueller attribution, the "Dr. Jane Smith … Stanford University"
  credential and the DMA `$42 for every $1` statistic, each taken verbatim from the commit
  diffs — with all four named individually, plus a correctly-linked quotation injected as
  a control and correctly not flagged.
  **What check (h) does NOT catch — stated plainly, so a green gate is never read as a
  clean bill of health.** (i) *The statistics half is not built, and that is a decision,
  not an omission.* Its only practical form is a vendor/analyst name deny-list, and run
  across the current CLEAN tree it returns 37 hits in 16 files — nearly all of them
  keyword-research examples where the firm name IS the subject matter ("Ahrefs vs SEMrush"
  as a comparison keyword, "download Screaming Frog" as a transactional one), which are
  not attributions at all. A permanent 37-line WARN on a green tree destroys the one
  property that makes (h) trustworthy, and would sit beside check (g)'s existing standing
  census; two large standing WARNs train a reader to skip the block, which costs more than
  the deny-list buys. It also flags a legitimate, linked, actually-read citation exactly as
  loudly as a fabricated one, so the only ways to quiet it are deleting correct content or
  growing an allowlist — a check that punishes the behaviour the library is trying to
  teach. Narrowing it to a firm name beside a numeric figure drops it to one hit today,
  but that is a property of this week's tree rather than of the design, and tuning a
  deny-list until the current sample goes quiet is fitting the guard to the sample. (That
  single hit is real and is left for whoever sweeps the file:
  `build/meta-tags-optimizer/references/meta-tag-formulas.md:49` ("Semrush Pricing") — an
  unsourced price for a real vendor inside a formula example, the same family as the
  `battlecard-template.md` sibling `5d9befb` named and left.) The statistics half
  therefore stays where redesign leg (i) put it: the standing rule at the top of every
  example-bearing reference file, the SKILL.md statistics rule, and the eval expectations —
  carriers that can ask *did you read it?*, which is the actual question and one no regex
  can ask. (ii) *Any fabrication carrying a plausible-looking link.* Check (h) tests only
  that a URL is PRESENT within the window — never that it resolves, that the page says what
  the sentence claims, or that the named person said the quoted words. An invented quote
  published beside a real-looking link passes it silently. That residual belongs to the
  reviewer and to skill-reviewer Mode A, not to the script, and the script's comment header
  says so where a maintainer will read it.

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

**Scripted guard added 2026-08-10 (F13-r2's phrase-shaped half)** — `scripts/expectation-carrier-check.sh`.
For every suite it extracts each "double-quoted" and `backticked` phrase from the expectations
and greps the skill's own text (SKILL.md + its `references/` + the shared frameworks and the
anti-slop ruleset) for it; a phrase the suite demands and the skill never states is reported as
a candidate. Advisory, never wired into the gate — its hits need judgement, and a gate failing
on candidates trains people to ignore it. **Measured coverage, per F15's ship-with-a-probe
rule: 1 of the 2 known instances.** It CATCHES technical-seo-checker at `df560ae`, where
"paste-ready" appeared 4× in `evals.json` and 0× in the skill. It MISSES entity-optimizer and
always will — that suite graded fabrication while the skill said nothing about it, a demand for
a BEHAVIOUR with no quoted string to grep, and it was the library's floor at 62.1%. So a clean
line means *no uncarried vocabulary was found*, never *the skill states every rule its suite
grades*; the behaviour-shaped half still needs a human reading the suite beside the skill. First
library-wide run: 5 candidates across 20 suites, all adjudicated false positives — two fragments
the extractor split across a quote boundary (meta-tags names `hreflang` 9 times), a Latin
transliteration of a Greek fixture name, and two client-prompt phrasings. The extractor was
deliberately NOT tightened to suppress them: a screen that over-generates is recoverable, one
that under-generates is F15 again.

**F13 Recurrence 3 — 2026-08-10 · a carrier that passes informed and fails blind was never
a working carrier.** `keyword-research` e5.2 (no fabricated competitor data) failed the blind
run 29/31: the deliverable asserted in the indicative what monday.com and asana.com rank for
— "Most of the keywords they rank for … will be marketing-team workflows, HR onboarding
templates, software-sprint boards" — with no assumption label, in a document that states at
L82 "Nothing here asserts what monday.com or asana.com rank for." It refutes itself.
**What makes this a new mechanism rather than a plain repeat**: the carrier was already
there. `SKILL.md:93` — *"label any competitor-keyword guess explicitly as an assumption or
estimate (hedging words like 'likely' are not a label)"* — landed in `0ce67fc` at 4.2.0,
BEFORE both of the informed runs that scored this suite 31/31. So the class stayed away
while the executor could read the expectation, and returned the moment it could not. Two
informed passes certified a carrier that does not hold on its own.
**Consequence for how carriers are validated**: "the rule is now stated in the skill" is not
evidence the rule works [obs:2026-08-10 blind run of research/keyword-research, e5.2 FAIL at
29/31, against the same carrier `SKILL.md:93` that was present and unchanged during both
prior informed runs recorded at 31/31 in eval-baselines/2026-08-08-v2.json and
2026-08-09-v3.json]. An informed run cannot distinguish a carrier that guides the writer
from an expectation the writer is reading anyway; only a blind run separates them. Any
carrier added in response to a ledgered failure is unproven until a blind run exercises it,
and this ledger's own guard lines should be read that way — as claims awaiting a blind test,
not as closures. Related: F16(b), where the informed method's inability to discriminate was
measured; this is the same blindness seen from the carrier's side rather than the score's.
**Guard**: recorded here, and in the blind record at
`docs/loop/eval-baselines/blind-2026-08-10b/keyword.json`. The strengthening of SKILL.md:93
itself is deliberately held for a diagnosis-before-edit pass — whether it is weakly placed,
weakly worded, or simply hard is the question, and guessing would repeat the mistake of
declaring a carrier sound because it exists.

**F13 Recurrence 4 — 2026-08-10 · three expectations graded a convention the skill never names, and the
informed run passed all three.** `research/competitor-analysis` e1.5, e2.6 and e3.5 each require the
Confirmed / Likely / Hypothesis confidence convention. The strings appear **zero times** in that
skill's `SKILL.md` and zero times anywhere in its `references/`, in English or Greek
(`[εΕ]πιβεβαιωμ` · `[πΠ]ιθαν` · `[υΥ]πόθεσ` all zero, checked in both cases because `grep -i` does
not fold Greek). The convention is defined in a different skill — `cross-cutting/content-quality-auditor`
— and this skill carries **no routing link to it**. The informed baseline passed all three; the blind
run failed all three, and they are 3 of its 7 failures.
**Why this is the sharpest instance yet**: the other recorded instances left the rule unstated. Here the
rule exists, is written down, and lives in a skill the executor was never pointed at — so the expectation
is not merely uncarried, it is carried somewhere the writer cannot reach. An informed executor reads the
convention out of the expectation itself and complies; a cold session cannot, because nothing in its
loaded context contains it.
**Second finding in the same run, recorded because it inverts the usual shape**: expectation e2.5 actively
**rewards** a family-8 violation — it passes a response that recommends running `domain-authority-auditor`
per the report template's own note. The suite requires on one surface what `anti-slop-ruleset.md` §6 now
forbids on another, and both compliant deliverables produced family-8 occurrences by doing exactly what
e2.5 asks. A suite can enforce a defect, not only fail to carry a rule.
**Guard**: the carrier fix (state the convention in the skill, or route to where it lives) is queued behind
this suite's grading rather than applied under it. `scripts/expectation-carrier-check.sh` did NOT surface
this class — the convention words appear in the expectations as ordinary prose, not as quoted phrases —
which is the behaviour-shaped half its own header already declares it cannot see.

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

- **Recurrence 1 (2026-08-10, the coordinator, twice in one wave) — the guard checks
  WHICH SKILL, not WHOSE FILE, and a directory add defeats it silently.** Staging three
  finished skills, `git add research/content-gap-analysis/` swept in that skill's
  `evals/evals.json`, which a different agent was concurrently editing in another lane. Caught
  by reading `git diff --cached --name-only` before committing, and unstaged. It had
  already happened once earlier the same day with a directory add of an eval-baselines
  folder, recorded then as "luck, not care" — so this is the second instance and the
  recurrence rule above says the guard failed rather than the operator did.
  **Why `commit-scope-check` cannot see it**: the guard's question is whether a commit
  carries skill files its subject does not name. Here the subject named
  content-gap-analysis and the swept file lives inside content-gap-analysis, so the
  file is in declared scope and the check passes correctly. The guard was built for a
  commit reaching into an *unnamed* skill; this is a commit reaching into an unfinished
  file inside a *named* one. Same family, different axis, and no amount of tightening
  the subject-matching would catch it.
  **What actually holds**: `git add <explicit file paths>` and a mandatory read of
  `git diff --cached --name-only` before every commit made while any agent is running.
  Both are vigilance, which ledger rule 3 says is not a fix — so this is recorded as a
  known open scope gap, not as closed. A real guard would need to know which paths are
  under an agent's open tenure; `.register-locks` already models exactly that for registers,
  and extending its tenure model to agent file scopes is the shape a fix would take.
  Not attempted here: designing it mid-wave, while eight agents hold file scopes, is how
  the first instance happened.

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

- **Recurrence 2 (2026-08-10) — a lesson stored where no later agent could reach it, twice
  over.** Two separate instances in one wave, same signature: (a) a blind Mode B run's
  extracted-prompts file, generically named `blind-prompts.json`, was overwritten mid-run by a
  different skill's blind run sharing the scratchpad — caught only because the fixture it named
  did not exist in the skill under test; (b) an earlier run's checker script was overwritten by
  a sibling's script of the same name. The mitigation for (a) had ALREADY been learned: the
  2026-08-09 baseline records "suite-prefixed grading filenames after a shared-scratchpad
  collision". **It lived only as prose inside a baseline JSON**, which no subsequent agent
  reads — so the next agent could not apply it, and did not. That is F13's thesis restated
  against the pipeline's own tooling rather than against content: a ruling with no carrier on
  the surface the actor reads is not a ruling, it is a memory.
  **Redesign (rule 3)**: carried into `.claude/agents/skill-reviewer.md` as a HARD RULE — every
  scratchpad file prefixed with its suite or review name, generic names named and banned, with
  both collisions cited so the rule carries its own evidence. The same edit carries the second
  lesson the wave produced: re-check your own inputs at close, because a skill's references are
  simultaneously the executor's instructions and the grader's rubric, and two runs had a
  ruleset gain a FAIL-grade family mid-run.
  **Stated limit**: agent definitions load at session start, so this carrier takes effect in
  the NEXT session, not the one that wrote it. The same lag applies to the `Write` tool added
  to `greek-content-editor` earlier today, which a pass launched minutes later still did not
  have. Recorded so a future reader does not mistake the lag for a failed fix.
- **Third mechanism, and the one that explains the other two (2026-08-10)**: commit
  `5d9befb` carries five `VERSIONS.md` rows and two changelog bullets belonging to three
  other agents, and its message names none of them. Two separate agents reported it
  independently, and one of them explained the mechanism precisely: it built its index
  entry surgically — HEAD plus its own four changes, no whole-file `git add` — and
  verified with `git diff --cached VERSIONS.md` immediately before committing. **Between
  that check and the `git commit`, another agent ran `git add VERSIONS.md`.** The git
  index is a single file in a shared worktree, so their add replaced the verified entry
  and the commit consumed it.
  **What this retires**: "stage only your own paths with an explicit pathspec", the
  instruction given to every authoring agent in this wave and written into two earlier
  entries here, is **insufficient by construction**. It cannot survive a concurrent
  `git add` from another actor, because the thing it protects is not per-agent. No amount
  of care at the pathspec level closes it.
  **What actually closes it**: `register-lock.sh`'s PREVENTION leg — refusing the second
  writer at announce time, so the concurrent window never opens. Its detection leg cannot
  substitute, and the agent that skipped acquiring said so plainly in hindsight: it
  reasoned that detection would fail the push for commits by agents who never acquired,
  and it traded a record collision for a push block. On the evidence that was the wrong
  trade — the block happened anyway, and the collision happened too.
  **Redesign (rule 3)**: acquiring the lock before touching a shared register becomes a
  standing rule for authoring agents, not a coordinator suggestion, and the wave that
  writes it is the next agent-definition wave. Recorded as the open item; until it lands,
  the prevention leg protects only actors that opt in, which is the honest description of
  its reach.

---

**F9 Recurrence 2 — 2026-08-10 · a carrier sweep rewrote skill text and left the eval suites
quoting the old text.** The library-wide connector sweep (`df560ae`) resolved `~~category`
tokens across 14 skills, rewriting an identical Output Validation line in each. Eval
expectations that QUOTE that line were not in the sweep's scope and were not updated. Result,
measured 2026-08-10: the string `Source of each data point clearly stated` appears in **seven**
suites' `evals.json` and survives in exactly **one** skill's `SKILL.md` — 12 stale anchors
across 6 suites (rank-tracker 3, content-refresher 3, internal-linking-optimizer 2,
content-gap-analysis 2, geo-content-optimizer 1, backlink-analyzer 1).
**Why it is F9 and not a new entry**: F9 is "deprecated-concept purges scoped per skill left
sibling leftovers". Same shape, one level up — the sweep's scope was *skill text*, and the
sibling it left behind was the *suite that quotes it*. A skill's evals are part of the skill's
surface for any change to text an expectation cites verbatim.
**How it was found, which matters**: not by review. `scripts/expectation-carrier-check.sh` was
extended to extract single-quoted phrases (this repo's suites quote in single quotes as house
style, and the tool had only read double quotes and backticks). The first run after that change
surfaced the string in a suite nobody was looking at. Before the extension the tool reported 5
candidates library-wide and called every affected suite clean — a guard's coverage hole hiding
the very class it was built for, F15's shape applied to F15's own remedy.
**Cost so far**: one confirmed unsatisfiable expectation (`keyword-research` e4.3, which no
longer matched what the skill instructs and could not be satisfied without violating it) plus
three stale quotes in the same suite, all fixed in 4.3.0. The remaining 12 are queued.
**Guard**: any sweep that rewrites text an expectation may quote must grep the suites for the
old string before it closes; the extended carrier check now surfaces this class, and a sweep's
done-definition includes running it.

## F15 — 2026-08-10 · Pattern guards written from their founding instance passed by matching nothing

- **Failure**: two `anti-slop-ruleset.md` §6 FAIL-grade families shipped with greppable
  patterns that could not catch their own ruled defect. (1) **Family 5** (negative concord)
  shipped a five-token, all-lowercase list with no case rule; two independent blind Mode B
  runs hit the hole within hours — capitalised «Κανένα» and the licenser «Δεν» never
  matched, so correct Greek passed unseen and each run's own lowercase-only licenser test
  read the correct sentence «Δεν έγινε καμία νέα μέτρηση» as unlicensed, one line short of a
  false Greek FAIL in both; the nominative «κανείς» was absent from the token list outright.
  (2) **Family 6** ("costs-zero" calque) shipped the literal string `κοστίζει μηδέν` —
  measured against constructed variants of its own defect it matched **1 of 5** (2 of 5 with
  `-i`), missing the derivational accent shift «κοστίζει μηδενικά ευρώ», the inflected verb
  «κοστίζουν μηδέν», and an intervening adverb «κοστίζει απολύτως μηδέν».
- **Root cause**: a pattern authored from the one example that motivated it encodes **that
  example, not the class**. Re-reading it later confirms nothing, because it still matches
  the instance it was born from — which is why both holes survived review and were found
  only by running the check. Greek sharpens it three ways at once: `grep -i` case-folds Greek
  only under a UTF-8 locale, the tonos moves under inflection and derivation, and the surface
  form varies (verbs inflect, adverbs intervene, digits substitute for words).
- **Direction, and why F7's guard does not cover this**: F7 governs scripted checks producing
  false FAILs, and its guard is "inspect the raw output before reporting a failure" — a
  discipline that fires only when there is a hit to inspect. This entry is the opposite
  direction: a **false PASS**, where the pattern matches nothing and the silence is read as
  a clean sheet. Nothing in the pipeline was watching that direction. Siblings F5 (freshness
  checker counted future dates), F6 (designated egress mirrors were themselves unreachable
  from this environment [obs:2026-08-08 F6 entry, verified at the time of that entry]) and
  F7 make this the fourth entry whose subject is **the instrument rather than the
  deliverable** — the single most common failure class in this ledger.
- **Guard**: (a) `anti-slop-ruleset.md` §6 governing note over the whole pattern column —
  every pattern is a screen, never a verdict; a reviewer reports "screened, nothing
  surfaced" in those words, and a FAIL or clean sheet on any Greek family is the binding
  editor's call on hand-checked evidence. (b) **Ship-with-a-probe rule**, same section: a
  family may not land until 3–6 constructed variants of its own defect have been run against
  the pattern and the hit rate recorded in the entry. Both instances above would have been
  caught by five minutes of this. (c) Family 6's replacement splits net (`μηδ[εέ]ν`) from
  rank (`κοστίζ`) so no single spelling carries the family, and names the digit-zero escape
  as hand-checked rather than pretending to cover it.
- **Recurrence**: 0 (two instances in one day counted as the founding pattern, per F7's
  precedent; a future pattern shipping without its probe increments this).
- **Status**: guard in `build/seo-content-writer/references/anti-slop-ruleset.md` §6
  [obs:2026-08-10T15:52Z probe, GNU grep 3.11 under `LC_ALL=C.UTF-8` on a 9-line constructed
  file: shipped pattern `κοστίζει μηδέν` matched 1 of the 5 defect lines, 2 with `-i`; the
  replacement net `μηδ[εέ]ν` surfaced all 5, plus 3 further candidates the editor rules on,
  and missed only the digit form named in the entry as a hand-checked escape].

---

## F16 — 2026-08-10 · Measurements quoted as fact were weaker than their record in two different ways

- **Failure**, two mechanisms found in one audit, both in the blind-eval evidence base:
  **(a) Evidence durability.** Ten blind Mode B runs were executed and their headline rates
  were quoted in `PIPELINE.md`, in `.claude/agents/skill-reviewer.md` and in reports to the
  maintainer. **Seven of the ten existed only as JSON in the session scratchpad** — an
  ephemeral directory reclaimed when the session ends. Only backlink, entity and memory had
  reached a baseline record. Every figure was accurate; none of the seven was reproducible
  from the repository, and nothing would have announced that when the directory vanished.
  **(b) A confounded aggregate quoted as a causal effect.** The same carriers stated
  "informed 97.9% vs blind 88.1%" and read the 9.8-point difference as the method effect.
  The two suite sets are **almost disjoint — only 3 of 10 suites (domain, serp, technical)
  were measured both ways** — so the pooled gap mixes the method with which skills each
  method happened to cover. The paired comparison is 97.6% → 92.8%, a **4.8-point** effect:
  real, same-signed in all three suites, and half the size claimed. A third statement,
  "no informed run had ever surfaced entity-optimizer's 62.1%", was true only vacuously —
  entity-optimizer was never run informed.
- **Root cause**: a number that has been computed feels established. Neither mechanism is
  about the number being wrong — every rate above reproduces exactly. Both are about the
  **record being weaker than the claim built on it**: (a) persisted nowhere durable, (b)
  compared across groups that were never checked for overlap. Nothing in the pipeline asked
  either question, because both look like bookkeeping after the interesting work is done.
- **Aggravating, and the reason this entry is worth its space**: mechanism (b) was committed
  **within the hour** of shipping `domain-authority-auditor` 4.2.0, whose entire content is a
  derived-figure discipline — recompute every figure you compute rather than copy, and
  reconcile it against the tables above it. The rule was written for the skills and not
  applied to the loop's own reporting. A rule the pipeline enforces on its outputs and not
  on itself is half a rule.
- **Guard**: (a) a blind or informed run is not complete until its record is committed under
  `docs/loop/eval-baselines/`; the scratchpad is a workspace, never a record, and a rate may
  not be quoted in a carrier or a report until its record has a repo path. The ten records
  are now at `eval-baselines/blind-2026-08-10/<suite>.json` with the index at
  `2026-08-10-blind.json`. (b) Any cross-method or cross-window comparison states which
  subjects are in both groups before it states a difference; where the groups are not the
  same, the paired figure is the headline and the pooled figure is labelled confounded.
  Both carriers were corrected in the same commit that opened this entry.
- **Recurrence**: **1** — see the recurrence block appended below this entry (2026-08-10,
  the corpus is not comparable across itself). A rate quoted from an uncommitted record, or a pooled gap
  presented as a method effect without a pairing check, increments this.
- **Status**: guards in `PIPELINE.md` VALIDATE (ii) and `2026-08-10-blind.json`
  [obs:2026-08-10T16:0Z audit — 10 blind records enumerated from the session scratchpad and
  copied programmatically to `docs/loop/eval-baselines/blind-2026-08-10/`; totals recomputed
  from those files reproduce the quoted rates exactly (252/286 pooled), and the pairing check
  that produced the 4.8-point figure is rerunnable from the two committed index files].


### F16 Recurrence 1 — 2026-08-10 · the 16-record blind corpus is not comparable across itself

Found by trying to recompute the pooled rate from the committed files rather than from the
tally that produced it. The rate reproduces exactly — **427/476 = 0.8971** — and two things
underneath it do not hold.

**(c) Two record schemas in one day.** The ten wave-a records key their numbers under
`totals.pass / totals.fail / totals.total`; the six wave-b records use
`summary.passed / summary.failed / summary.total`. No single reader parses the corpus, and
`blind-2026-08-10/metatags.json` carries no `pass_rate` field at all. The first extractor
written against the corpus silently returned 209 of 476 expectations — it found only the
wave-b schema and reported the rest as having no summary. A corpus that needs bespoke handling
per file is one where the next pooled figure is computed by hand, which is how F16(b) happened.

**(d) The editor-pending slot is counted two ways, and the wording does not explain it.**
Five of sixteen suites — domain, metatags, technical, competitor, linking — record
`passed + failed = total - 1`, leaving the Greek editor slot uncounted so the published rate
treats it as not-passed. The other eleven count it. This is not a difference in what the
expectations ask:

- `internal-linking-optimizer` e3.4 — *"mechanically checkable layer only … fluency,
  idiomatic naturalness, register … are NOT graded by this expectation"* → counted NOT-passed.
- `performance-reporter` e5.3 — *"mechanically checkable layer only … fluency, idiomatic
  naturalness, translation-ese, and register are judged by the binding greek-content-editor"*
  → counted PASSED, on the ground that the mechanical layer was checked and was clean.

The two texts are the same instruction. Linking's is the more explicit of the pair about
grading only the mechanical layer, and it is the one counted more conservatively.

**Effect.** Pooled, the corpus reads **427/476 = 89.71%** as recorded and **432/476 = 90.76%**
if the five uncounted slots are counted the way the other eleven were — about one point. At
suite level it is ~3.5 points, which is the number that matters: internal-linking-optimizer is
published at 92.86% and would read 96.43%, moving it above alert-manager (93.10%) and
keyword-research (93.50%). **The ranking is what the blind method exists to produce** — the
finding that ten informed runs fit inside a 3.8-point band while ten blind runs spread over
37.9 points is a claim about ordering skills by where the work is. A bookkeeping choice that
reorders neighbouring suites degrades exactly the property being claimed.

**Root cause**: no convention was ever stated for the editor slot, so each grader chose one and
documented it. Every one of the five did so explicitly and several printed the alternative
figure beside their own — the local records are honest and complete. That is precisely why
nothing surfaced it: there was no disagreement to notice, because no two graders were ever
compared. A convention that lives in each grader's judgement is not a convention.

**Guard**: (c) one schema for eval records, and a reader in the repo that parses every
committed record or fails loudly — a pooled figure may not be quoted from a hand tally again.
(d) the editor slot stops being a special case: the binding editor's verdict becomes a scored
expectation with a stated pass band, which is queue item #25 and now has this as its
motivating evidence. Until that lands, a record stating a rate also states which convention it
used, in the summary object rather than in prose.

**Not claimed**: that any grader was careless, or that any published suite rate is wrong under
its own stated convention. Each is correct as recorded. What fails is the set.

**Status**: recorded, both guards queued under #25. FLIP: F16-r1 -- none


### F9 Recurrence 3 — 2026-08-10 · the derivation discipline was applied where each defect was found and nowhere else

A read-only survey of all twenty skills, commissioned as queue item #35 after a grep proxy of my
own gave a false clean (it reported `content-refresher` as stating no derivation when the skill
says *"Calculate a 0-100 decay severity score by summing weighted signal scores"* — my regex simply
did not contain the author's phrasing, which is F15's shape in the coordinator's own instrument).
Thirteen skills emit a score, rating, band or percentage into a deliverable with no stated way to
arrive at it.

**The finding is not the count. It is that the same skill often does both.**

- `content-refresher` derives its Composite Decay Score completely (`content-decay-signals.md:158-180`)
  and its CORE-EEAT Quick Score not at all — and that second score's own worked example is
  non-monotonic against its own flag (`refresh-example.md:21-28`: 55 → green, 60 → red, 60 → red,
  50 → amber), so the flag is demonstrably not a function of the number it sits beside.
- `backlink-analyzer` governs the per-domain Risk Score explicitly — *"This skill defines no
  risk-score scale of its own, so a link with no tool-reported score gets N/A"* — and forty lines
  above leaves `Profile Health Score: [X]/100` and `Toxic Score: [X]/100` with no formula at all.
- `content-gap-analysis` derives its Gap Priority Score fully and leaves the GEO Opportunity table
  with no scale, no rubric and no combination rule.
- `keyword-research` is exemplary on Priority Score, renormalisation and its explicit
  do-not-divide-by-5 note, while the Score column in the file its own SKILL.md calls "the full
  report template" reproduces from no stated formula — the published figures do not follow from
  the stated one and do not even preserve its ordering.

**Root cause, and why it is F9's mechanism rather than a new one**: every one of these disciplines
was written in response to a specific defect, in the skill where that defect surfaced. F9's founding
entry is a deprecated token purged where it was noticed and left standing in its siblings. This is
the same motion applied to a rule instead of a deletion — a positive discipline landing at the site
of discovery and nowhere else. The distinction worth recording is that F9's earlier recurrences were
about the same *token*, which greps; this is about the same *discipline*, which does not. No pattern
would have found it. A person read twenty skills.

**Two figures that cannot be produced at all**, both verified at source before this entry:
`cross-cutting/content-quality-auditor/SKILL.md:240-241` carries an example with an item score of **8**
on a scale that admits only 10, 5 and 0, printing a dimension score of 65 that no legal pair of
inputs can reach — in the skill that defines the library's content-quality framework. And
`commands/check-technical.md` compiles **six** area scores where the skill it invokes scores
**eight**; since the overall is a sum over sections scored, the command's denominator differs from
the skill's and so does the number.

**One defect from the survey is graver than the scoring class and is being fixed separately**:
`build/seo-content-writer/references/content-structure-templates.md:547` and `:644` carry
`**Rating**: ★★★★☆ (4/5)` as a **hardcoded value inside a paste-ready Product Review template**,
where every neighbouring field is a bracket slot. A model copies the fence, so a fixed rating ships
for whatever product is reviewed, under the client's byline, and feeds `Review`/`AggregateRating`
structured data. It is the Value Rule inverted — that rule forbids an unsourceable token in a value
position, and a fixed value in a slot position is worse, because nothing signals it needs replacing.

**Guard**: the derivation rule becomes library-wide rather than per-skill — a number emitted into a
deliverable states how it was reached, or is not emitted. `domain-authority-auditor`'s
`references/score-arithmetic.md` and `on-page-seo-auditor` are the two working models and the
remaining skills copy one of them rather than each inventing a third convention. Recorded with the
survey's own denominator so the coverage is auditable: roughly 30 quoted figures across 14 files
were checked against their sources and found faithful, including the 3-10% band fixed hours earlier.

**Recurrence**: F9 → 3. A discipline applied at one site while an identical sibling is left
untouched increments this.

**Status**: surveyed, three fixes dispatched, remainder queued. FLIP: F9-r3 -- none


### F3 Recurrence — 2026-08-10 · a suite scored 100% on a run that shipped an unlabelled third-party ranking claim

`content-refresher`'s founding blind record is **27/27 = 100.0%**, and the same grading found
three defects no expectation reaches. The rate is accurate. It is also not a statement about
the skill, and this entry exists so nobody later reads it as one.

**The fabrication.** The e1 deliverable states *"2 newer competitor guides now outrank you"* and
the Greek e3 states «Δύο νεότεροι οδηγοί … προηγούνται» — a third-party ranking asserted in the
indicative, unlabelled, in a scored cell carrying 12.75 of e1's 89 points. Neither fixture
supplies any competitor position.

**The root cause is the skill, not the executor.** `content-decay-signals.md:168` scores
displacement as *"displaced from top 3"* — a criterion that demands an input the fixtures cannot
provide, so an executor scoring the item honestly has nowhere to go but invention. F13-r3's
signature: the rule is stated, and following it produces the defect.

**The grader declined to fail it, and was right to.** No expectation covers the class, and its
reasoning is worth preserving verbatim in substance: manufacturing coverage at grading time is
the F13/F17 defect committed from the grader's side. A grader that invents a bar to catch a
defect it can see is no longer measuring the suite. It reported the finding first-class instead,
which is how the defect reached this entry at all.

**Two more the same grading surfaced and the suite structurally cannot see:**
- e1 states the W12 HowTo retirement as **settled fact in client-facing FAQ copy**, while that
  claim is an open `[VERIFY]` awaiting Sani's G9 verdict. Expectation e1.2 rules the topic
  ungraded **by name** — so the suite is not merely silent here, it is designed to look away, and
  a deliverable asserting an unresolved claim as fact passes by construction.
- `content-decay-signals.md:47-55` carries an unsourced position-CTR curve of exactly the class
  tagged as W14 in `meta-tags-optimizer` hours earlier. F9's signature again: the tag landed
  where the defect was noticed and not in its sibling.

**What this changes about reading rates.** The pooled blind corpus is quoted in two conventions
already (F16-r1). This adds a third caveat that applies to every suite: **a pass rate is a lower
bound on defects, never a measure of quality.** 100% here means every graded expectation passed,
on a run carrying an unlabelled competitor claim, a `[VERIFY]` asserted as fact in client copy,
and a rubric that maps a page earning 1,530 sessions a month to "retire". The blind method's
claim was discrimination between skills; it does not and cannot discriminate between *graded* and
*ungraded* defect classes. Only a reader does that, and on this suite a reader found three.

**Guard**: a record whose rate is 100% carries an explicit `defects_found_outside_graded_set`
field, populated or stated empty. An unqualified 100% is not reportable. The refresher record
carries the three above.

**Recurrence**: F3 → recurrence recorded. A deliverable asserting an unsourced third-party
metric, or an expectation excluding an open `[VERIFY]` topic by name, increments this.

**Status**: recorded; skill fix for `:168` queued, e1.2's exclusion routed to the suite owner.
FLIP: F3-r-2026-08-10 -- none


### F18 Recurrence 1 — 2026-08-10 · a skill's own worked example was written from the eval fixture

F18's founding entry named the anti-slop ruleset as the leak surface and listed
`content-gap-analysis` among the suites unaffected. That is true of the ruleset vector and false
of the skill, and the second carrier is worse than the first.

**Established by commit archaeology, not inference.** `SKILL.md:164` states its named-proxy
example as *"Search Demand scored from competitor cluster depth (9 + 4 articles across the two
competitors)"*. The e1 fixtures give Summitline's winter cluster as **9** articles and PeakPath's
as **4**. The order of events settles it: the fixtures land in `5559474` (2026-08-09 16:53Z)
already carrying those counts; Step 9 at that commit carried no unavailable-input rule at all;
the phrase *"competitor cluster depth"* first appears in `3e63967` (2026-08-10 17:02Z), whose own
commit message records that the fix was authored while reading these fixtures. The example was
written **from** the test.

**Why this is worse than the ruleset vector.** A provenance sentence in `§6` tells an executor
which defect classes a prior run was marked down for — a hint. A worked example fitted to the
fixture hands every executor of that eval the route, the basis wording **and** the arithmetic for
the fixture's headline gap. The e1 deliverable reproduces all three. The eval retains no power to
discriminate on that clause: `e1.5`'s Search-Demand requirement can be satisfied by copying the
skill, which is what the skill is for. Executor B's independently constructed band table still
discriminates; that clause does not.

**Not a reason to stop grounding examples in real data.** An example built from a plausible
scenario is what makes a rule followable, and the 2026-08-10 fix it belongs to was a genuine
improvement. The defect is the **coincidence of surfaces**: the same numbers serve as the skill's
teaching example and as the eval's ground truth, so the test measures recall of the example
rather than application of the rule. Two artefacts, one number, opposite purposes.

**Guard**: an eval fixture and its skill's worked examples do not share figures. When a rule needs
a worked example, the example uses numbers that appear in no fixture for that skill; when a
fixture needs a scenario, it is not the one the skill walks through. Cheap to check at authoring
time and invisible afterwards — which is why it is a rule and not a habit.

**Recurrence**: F18 → 1. A shared figure between a skill's example and its own suite's fixtures
increments this.

**Status**: recorded; the content-gap-analysis example and fixture are queued for divergence with
that skill's other fixes. FLIP: F18-r1 -- none

---

## F17 — 2026-08-10 · A cross-skill rule was ruled in the coordination documents and given no carrier in any shipped skill

- **What happened**: four eval suites grade the library's **inter-skill handoff convention** —
  `cross-cutting/memory-management` e1, `research/competitor-analysis` e4,
  `research/content-gap-analysis` e4 (three expectations), `research/keyword-research` e5.
  Three of them name the source in the expectation text: *"per the library's inter-skill
  handoff convention (CLAUDE.md)"*. The convention's only statement in the repository is in
  the three coordination documents — root `CLAUDE.md:36`, `README.md:244`, `AGENTS.md:218`.
  A sweep of all 20 `SKILL.md` files for any handoff convention returns **2**:
  `content-quality-auditor` and `domain-authority-auditor`. The 18 others, including all four
  whose suites grade it, state none.
- **Why it is not F13**: F13 is a rule stored where the writer never meets it. Here the rule
  IS met by the writer — every session in this repository auto-loads `CLAUDE.md`, so an
  in-repo executor, blind or informed, reads the convention before it writes. The defect is
  not that the executor cannot see the rule. It is that **the rule is carried by the
  repository rather than by the product**, and no measurement the pipeline owns can tell the
  two apart, because every measurement runs inside the repository.
- **The blind method's residual blind spot, stated plainly**: splitting executor from grader
  removed the grader's knowledge of the expectations. It did not remove the executor's access
  to the coordination documents. For this one class of rule — anything ruled in `CLAUDE.md`
  and not restated in a skill — a blind run scores it as carried and cannot do otherwise.
  The 20-suite blind sweep is therefore evidence about skills-as-run-here, and is silent on
  skills-as-installed for this class. That is not a defect in the runs; it is a boundary on
  what they measure, and it was not stated anywhere until now.
- **The repository already knows the fix and applied it twice.** `CLAUDE.md`'s other two
  standing rulings each name skill-side carriers in the ruling itself: the `~~category`
  resolution rule carries at `build/seo-content-writer/references/anti-slop-ruleset.md` §6
  family 7, and the Value Rule at `schema-templates.md` plus `meta-tag-code-templates.md`.
  Both were ruled the same day as this entry. The handoff convention is the one standing
  cross-skill ruling that names no carrier — so this is a gap in applying an existing
  convention, not a missing convention.
- **Root cause**: a rule written into the document that coordinates the work reads as
  delivered, because the coordinator can see it from where the coordinator sits. Naming a
  carrier is the step that converts a ruling into something a user receives, and it is
  invisible to skip — nothing fails, and in-repo tests keep passing.
- **Guard**: a ruling recorded in `CLAUDE.md` names its shipped carrier **in the ruling**, in
  the form the other two already use ("Carrier: `<path>` §<n>"). A ruling with no carrier line
  is incomplete. Applying this to the handoff convention is queued, not done in this entry —
  two of the four affected skills are under edit by other agents as this is written, and
  editing a skill during another agent's run is ledger F8.
- **Recurrence**: 0 (founding). A standing ruling landing in `CLAUDE.md` without a carrier
  line, or another suite found grading a convention no shipped skill states, increments this.
- **[VERIFY] — the amplifier, deliberately not asserted**: whether an installed user's
  session loads a plugin's root `CLAUDE.md` at all. The repo records a strict-validator
  **root-CLAUDE.md packaging warning** as an accepted residual (`GATED-ITEMS.md` G1, :284),
  which is why this is worth asking; but the entry above stands without it, on the carrier
  convention alone. If the warning does mean the file is not delivered, the convention is
  carried for no installed user whatsoever and the four suites grade a rule the product never
  states. **Resolves when**: a probe installs the plugin from a directory source and reports
  whether the handoff convention is in the session's context. Not probed here.
- **Status**: opened, carrier fix queued, amplifier unprobed. FLIP: F17 -- none

---

## F18 — 2026-08-10 · The evidence that grounds a rule identifies the run it came from, and that identification is a hint to the next run of the same suite

- **What happened**: three of the four blind executors in one wave independently reported, unprompted,
  that a **required read** had told them which defect classes their own suite's previous run was
  marked down for. None of them had contact with the others. Verified at source, not taken on
  report — `build/seo-content-writer/references/anti-slop-ruleset.md`:
  - `:174` cites `rank-tracker E3`, `keyword E2`, `schema E2` and `linking E3` with occurrence
    counts; `:255`, `:286` and `:287` cite the rank-tracker E3 deliverable again at 19, 11 and 7
    occurrences, naming the exact classes.
  - `:177-181` describes the content-refresher E3 output down to **the section heading its
    defective span sat under** («Έτοιμα κείμενα για δημοσίευση») and both of the editor's ruled
    defects. The executor running content-refresher read this before writing its own E3.
  - `:269` cites competitor-analysis's Greek E3 at 8 occurrences.
  - `:265` quotes *"absent tools mean absent numbers"* — a **verbatim expectation string** from
    `cross-cutting/domain-authority-auditor/evals/evals.json`, where it appears in two
    expectations. Every blind executor reading the ruleset has been reading an eval expectation.
  At least six suites are affected. The ruleset is on the required-read list for every blind run,
  because it is skill instruction the deliverable must obey.
- **Why this is a new mechanism and not a recurrence of F13 or F8**: nothing here is stale, and
  nothing changed mid-run. Every cited line is accurate, current, and load-bearing — the citations
  are what make the rules auditable rather than assertions. The defect is that **the same sentence
  that grounds a rule for its author is a hint for the next executor of the named suite.** One
  artefact serves two readers with opposite information needs, and the pipeline never noticed
  because both readers were being served correctly.
- **The tension is real and must not be resolved by deleting the evidence.** F13's fix is to state
  a rule where the executor meets it; F15's is to ship a guard with its measured hit rate. Both
  push toward citing the founding instance, and citing it is why `§6` can be audited at all. The
  answer is not less provenance — it is that provenance and rule have different audiences and
  should not share a file the executor is required to read.
- **Effect on this wave, stated rather than smoothed**: rank-tracker is worst affected — its
  executor wrote E3 knowing a prior E3 leaked `~~` tokens and skill slugs, which are exactly what
  several expectations grade. content-refresher's e3 is primed on families 5 and 6 specifically.
  Both records are being labelled **primed, not blind** at the expectation level rather than
  discarded: a labelled run is evidence, an unlabelled one is contamination. geo-content-optimizer
  and content-gap-analysis are unaffected by this vector.
  → **Both halves of that last sentence were later corrected, by two different mechanisms.** The
  geo half is corrected in the CORRECTION block immediately below. The content-gap half is
  corrected by `### F18 Recurrence 1`, which found the same skill compromised through a second
  carrier — its worked example fitted to its own fixture. Neither correction is visible from the
  other, which is why both are pointed at from here: **an entry that gets corrected twice needs one
  place a reader can stand and see both.** Nothing on the clean list survived contact with a
  grader; the honest reading is that "unaffected" meant "not yet checked for this vector".
- **CORRECTION, 2026-08-10, same day, found by the geo grader and verified at source before
  amending**: the sentence above is **wrong about geo-content-optimizer**, and the error is mine.
  `§6`'s family-1 cell (`:168`) states its ruled form as «Όλα τα 18 μοντέλα συνοδεύονται…» →
  «Και τα 18 μοντέλα συνοδεύονται…», and family 2 (`:169`) states its example as
  «(απαιτούνται στοιχεία προϊόντος)» inside a FAQ answer or JSON-LD, citing geo-content-optimizer
  by version. Eval 2 of that suite supplies «18 μοντέλα» in its prompt and asks for exactly a
  category text with a Greek FAQ and its FAQPage markup. So the required read hands that
  executor the ruled sentence for its own scenario, with the same numeral. One correction to the
  grader's wording, checked rather than copied: the 18 is in the **eval 2 prompt**, not in the
  fixture file — no geo fixture contains the string at all. The substance holds either way.
  **Effect**: e2's three productions of the ruled native form and its zero family-2 leaks are
  **primed, not cold carrier evidence**, and the geo record labels them so. Priming can only
  assist a pass, so no verdict moves. Five suites are now known-affected, not four, and the
  original sentence stands corrected rather than rewritten — a register that edits away its own
  errors teaches nobody what the error was.
- **Root cause**: a rule's provenance was written for the person deciding whether the rule is
  justified. That reader needs the suite name, the count and the date. The executor needs the rule
  and nothing else. Putting both in one file was never a decision — the provenance accreted into
  the carrier because the carrier is where the rule lives.
- **Guard**: split the surface. `§6`'s rule text carries the ruled form, the pattern and the
  protected list, and **no suite identifier, run label, occurrence count or quoted expectation**.
  The provenance — which suite, which run, how many, which editor verdict — moves to a companion
  record that graders and authors read and the executor's required-read list does not include.
  A rule that cannot be stated without naming the run it came from is a rule that is not yet
  general enough to ship.
- **A second observation from the same wave, recorded because it is unanimous**: all four executors
  independently declined to read `FAILURE-LEDGER.md`, each giving the same reasoning — the hard rule
  conditions it on *"before judging anything"*, and an EXECUTOR judges nothing, while the ledger
  indexes suite-specific failure patterns that would function as expectations. Four for four, with
  no contact between them. They were right, and this entry is the proof: the ledger has exactly the
  property F18 describes, more so than the ruleset. The rule is now explicit rather than inferred.
- **Recurrence**: 1. A new `§6` entry naming a suite, a run label or an occurrence count in rule
  text, or any quoted expectation string appearing on an executor-read surface, increments this —
  as does a shared figure between a skill's worked example and its own suite's fixtures, which is
  what the first recurrence was.
- **Where the recurrence is written, and why that matters**: `### F18 Recurrence 1` sits ABOVE this
  entry in the file, not below it — appended into the block that was open at the time rather than
  at the end. So a reader arriving here reaches the counter before the instance, and for part of
  2026-08-10 this line read `0` while the instance was already a hundred lines away in the same
  file. It is corrected in place rather than relocated: moving an entry in an append-only register
  is a worse defect than an out-of-order one, and the counter's job is to make the instance
  findable, which a pointer does. **A recurrence count is only trustworthy if incrementing it is
  part of writing the recurrence, not a separate step someone remembers.**
- **Status**: opened; §6 restructure dispatched 2026-08-10 once the graders had finished reading
  the file. The split ships with the family-8 reader-test ruling in the same edit, per F9's lesson
  that a class fixed in halves is a class fixed nowhere.
  FLIP: F18 -- none


### F15 Recurrence 1 — 2026-08-10 · a guard passed on a file that taught the banned instruction, because the ban and its context sat 45 lines apart

F15's founding entry is about guards that pass by matching nothing. This is the same outcome
reached by a different road, and the road is the part worth recording.

**What happened.** `scripts/validate-tracking.sh` check (f) enforces settled ruling **R3** across
the command tree by matching a token regex line by line. `commands/generate-schema.md` had
**zero** lines matching that regex, so check (f) passed on every run — while the file's step 2
told the reader to test every page with Google's Rich Results Test and its step 3 to wait 2-4
weeks for rich results, unconditionally, in a command whose own first usage example is an FAQ.
For FAQPage both instructions are dead: support was cut in 2026, and the skill's own
`validation-guide.md` already says to skip that step for that type.

**Why the regex could not see it.** The guard is line-local. The FAQ context is at line 24 (the
usage example) and the banned instruction at line 69 — **45 lines apart, in different sections**.
Neither line is wrong in isolation. "Test with the Rich Results Test" is correct advice for the
types that still have a rich result; "generate FAQ schema" is a legitimate request. The defect is
that one file says both without a condition joining them, and a line-oriented matcher has no way
to represent "these two lines are fine apart and wrong together".

**This is not a call to widen the regex.** A token list long enough to catch this would fire on
every legitimate mention of the Rich Results Test in the library, and the last two false-positive
nets we fixed (`νίκη` inside «Θεσσαλονίκη», `CITE` inside "cited") cost more trust than they
bought. The honest statement is that **check (f) verifies no line states the retired claim, and
nothing more** — it does not and cannot verify that a document's instructions are jointly
consistent with R3.

**Guard**: check (f)'s own header comment must state that limit, so the next reader does not
take a pass as evidence of R3 compliance. A guard whose scope is undocumented gets quoted as
though its scope were total — which is exactly what happened here, since this file sat clean
under (f) through every gate run of the last three days.

**How it was actually found**: not by a guard, by an agent sent to fix a different ruling in the
same file and reading around the site it was given. Three separate sweeps this day found more
sites than their brief named. That is a pattern about briefs, not about luck: **a brief that
names line numbers gets line numbers fixed; a brief that names the class gets the class fixed.**

**Recurrence**: F15 → 1. A guard reported as passing where the defect it names is present in the
scanned file increments this.

**Status**: recorded; the check (f) scope note is queued. No regex change proposed.
FLIP: F15-r1 -- none

---

### F11 Recurrence — 2026-08-11 · a gate was closed in one register and left open in the other

**What happened.** Sani accepted G9 proposal 9a and held 9b. The acceptance was written into
`SETTLED-RULINGS.md` R3 — which now reads "Sani-accepted 2026-08-11" — while `GATED-ITEMS.md`
G9 still read `**Status**: GATED, proposed 2026-08-10` and still carried a
`**What Sani decides**` list asking him to decide a thing he had decided. **Half the entry
moved.** A reader arriving at either register would have been correctly informed and
incorrectly informed at the same time, with no way to tell which half was current. Separately,
`SETTLED-RULINGS.md`'s own change protocol mandates that *"each edit updates 'Last review'"*,
and the amendment did not: that line still read 2026-08-08 after two rulings had changed.

**Why no gate caught it.** `claims-gate` rule 2 sweeps for flips by keying on `Status:` and
`Verdict:` **field syntax**, and neither register writes its status that way — `GATED-ITEMS.md`
uses a bolded markdown list item. So a half-moved gate entry is not a case the sweep misses by
accident; it is structurally outside what the sweep can see. Recorded as a scope gap rather
than patched, because widening the pattern to bolded prose would fire on ordinary sentences and
teach authors to route around it.

**Root cause, and it is not forgetfulness.** The coordinator wrote the amendment while holding
the ruling text in view and the gate record out of view. A register pair where one side is the
*decision* and the other is the *ledger of decisions* has exactly this failure mode built in,
and the protocol line that would have caught it lives at the bottom of the file the author was
already editing.

**Guard.** A gate verdict is not applied until **both** registers name it: the ruling carries
the amended text, and the gate entry carries the verdict, the date, what was held, and what the
hold costs. Whichever is written second cites the first. `Last review` updates in the same edit.

**Recurrence**: F11 → increments. A ruling amended without its gate entry moving, or a
`SETTLED-RULINGS.md` edit that leaves `Last review` stale, increments this.

**Status**: recorded; both registers reconciled in the same commit that records this.
FLIP: G9 -- none (this entry records the desync, not the verdict; the verdict flip is
declared where it belongs — `GATED-ITEMS.md`, thirteenth verdict entry, 2026-08-11)


### F9 Recurrence 4 — 2026-08-11 · a ruling was softened in the register and asserted unchanged in ten shipped surfaces

**What happened.** G9 9a recorded two retractions: the Search Console API cut is *scheduled*
rather than observed, and R3's rationale — that FAQPage's value is AI-engine parsing — has **no
primary source either way**. Both landed in `SETTLED-RULINGS.md` and in no skill. The second
Mode A pass found seven surfaces in `schema-markup-generator` still asserting the retracted
text and cited two of them **to R3 by name** — a skill citing a ruling for a claim that ruling
had just disowned.

**The count was worse than the review's.** A residual grep after the named fixes found **ten
surfaces across six skills**: `schema-markup-generator` (5), `content-refresher` (4),
`seo-content-writer`, `technical-seo-checker`, `serp-analysis`, and `commands/generate-schema.md`
(2). Two were surfaces no reviewer had named and only a whole-repo residual sweep reaches —
**the skill's own `description` frontmatter**, which is the first text a model reads and the
basis on which the skill is selected at all, and a decision-tree table cell. The command file
was the sharpest: it instructed the operator that "the payoff is AI-engine/GEO parsing", which
is a claim made to a client.

**Why this is F9 and not a new mechanism.** F9's whole content is that a class fixed where it
was noticed is a class not fixed. The novelty is only the direction: previous recurrences
swept skills and left the register behind, this one amended the register and left the skills
behind. **The lesson is symmetric and was not stated symmetrically before** — a retraction
propagates exactly as far as an assertion does, and needs the same hit list.

**Why check (f) cannot catch it.** Its `R3_LEGAL` allowlist passes any line containing
"retired", which is precisely the vocabulary every stale surface used.

**Guard.** When a ruling is amended, the amending commit carries a grep of the retracted
claim's own vocabulary across the whole repository, and every hit is fixed or explicitly
queued with its reason. The grep goes in the commit message so the next author can re-run it.

**Recurrence**: F9 → 4. A ruling amended without a residual sweep of the retracted wording
increments this.

**Status**: recorded; six of the ten surfaces fixed in the same commit, four in
`content-refresher` deferred with a named reason — a blind executor was reading that skill and
editing it mid-run is F8. FLIP: R3 -- 9a applied downstream

---

### F19 — 2026-08-11 · the abstention overshoot: a rule against asserting the unsourced, applied one step past where the library already holds the answer

**Found by the grader of two suites at once, as a cross-suite observation neither suite could
have produced alone.** Both skills had been ledgered for the opposite defect — F3, asserting
what no input supplied — and both were fixed. This is what the fix produced next.

**The two instances.**
- `content-refresher` e1 routes Core Web Vitals thresholds back to the client as something
  *"we have not checked in this session and will not assert"*, and never prints them. **The
  library settled those thresholds — ruling R4** (LCP ≤2.5s, INP ≤200ms, CLS 0.1). The client
  republishes an unresolved section that the skill's own repo could have closed.
- `monitor/alert-manager` e5 declines to ask the client who should be notified — Data Sources
  item 3 — **while assigning thirteen priorities itself**. It abstained on the input it was
  told to collect and did not abstain on the judgement built from it.

**Why this is not F3 inverted, and not merely caution.** Both deliverables are arithmetically
immaculate: across ten deliverables and 27 scored expectations of arithmetic and provenance,
**not one fabricated figure**. The executors learned "do not assert what you cannot source"
completely. The defect is that **the rule has no stopping condition**: it does not say *"unless
the library has settled it"*, so a settled ruling and an unknown look identical at the point of
writing. Refusing to state R4 is not epistemic caution — R4 IS the source.

**The cost is asymmetric and that is why it needs a guard.** A fabricated figure is visible and
gets caught. An unnecessary abstention looks like rigour, reads as thoroughness, and passes
every fabrication net in the library. Nothing in the eval suites could see either instance.

**Guard.** A refusal to state a figure must first check the settled registers. Where
`SETTLED-RULINGS.md` holds the answer, the answer is stated and cited to the ruling — abstention
there is a defect, not diligence. Skills that instruct hedging carry the carve-out at the point
of the instruction, not in a distant reference.

**Recurrence**: 0 (founding). A deliverable that declines to state something a settled ruling
establishes, or that abstains on an input while acting on the judgement drawn from it,
increments this.

**Status**: recorded. FLIP: F19 -- none


### F13 Recurrence 5 — 2026-08-11 · an expectation rewarded the fabrication its own suite was ledgered for

**`optimize/content-refresher` e2.6 requires the paste-ready deliverables to "ship complete — no
bracketed placeholders". The e2 fixture supplies no answer to fill them with** — only a
transcriber's note that the timing answer "first appears in the fifth paragraph", with the
paragraph itself withheld. The only way to satisfy the expectation literally is to invent
horticultural advice and hand it to a client to publish.

**The prior blind run did exactly that, and e2.6 passed it.** That run's deliverable published
*"Aerate a UK lawn in early autumn, September to October, while the soil is damp and the grass
is still growing"* plus six specific 40-60 word answers, none of it in the fixture. **That is
the 27/27 record.** e2.6's own fabrication clause is scoped to "no statistic attributed to a
named source" and cannot see invented domain advice, so the suite scored the invention as a
pass and would have again.

**This run failed e2.6 by obeying the Value Rule.** It shipped both blocks as skeletons with
`<!-- SKELETON -->` inside the fence and the blocker named in prose — which root `CLAUDE.md`
explicitly sanctions: *"bracket tokens are the correct notation inside a block explicitly
labelled a skeleton."* **The one regression in this suite is the skill behaving correctly.**

**Why it belongs to F13 rather than F3.** F3 is a deliverable asserting the unsupported. Here
the *expectation* requires it: the suite is the carrier of the defect, and the skill's own
governing rule contradicts it. That is F13's shape — a rule stated in one place and enforced
against in another.

**Guard.** An expectation demanding complete paste-ready output must be satisfiable from its own
fixture. Where it is not, either the fixture supplies the missing input or the expectation
carries the Value Rule's skeleton carve-out. **A pass rate that can only be earned by inventing
client-facing content is measuring the wrong thing**, and a suite cannot be trusted to notice
this about itself — both instances here were found by comparing two runs, not by reading either.

**Recurrence**: F13 → 5.

**Status**: recorded; e2.6 needs the carve-out or the fixture needs paragraph 5 — coordinator
ruling, suite not edited. FLIP: F13-r5 -- none

---

## F9 — Recurrence 5 (2026-08-13) · A closure note written from the instance, not from a sweep

Finding 77 was ruled and applied: `references/core-eeat-benchmark.md` C09 stopped asserting
"engines parse the visible Q&A either way". The register then recorded the closure as **"The
benchmark no longer asserts engine behaviour."** That sentence was false at the moment it was
written. §4 of the same file, seventy lines above the fix, was headed *AI Engine Citation
Preferences* and stated *"All engines extract from first paragraph"*; `references/cite-domain-rating.md`
§5 tabled per-engine *"Preferred Domain Signals"*; **seventeen instances stood across nine files**,
including the Top-6 tables of both scoring frameworks — the surfaces every skill scores against.

**The signature is F9's exactly, in prose rather than in a purge**: the class was declared closed
on the evidence of the one member somebody had just touched. What makes it a distinct recurrence
worth counting is *where* it happened — not in a skill, but in the **closure note**, which is the
artefact a later reader trusts instead of re-checking. A purge that misses siblings leaves the
siblings findable. A closure note that misses siblings tells the next reader not to look.

**Rule added**: *a closure note is a claim about a class, and it is written from the sweep's output,
never from the fix.* If no sweep was run, the note says what was fixed — "C09 no longer asserts
engine behaviour" — and not what the class now is.

- **Found by**: the PR #9 merge gate (Mode A), as BLOCKING finding B1.
- **Recurrence**: F9 → 5.
- **Status**: superseded by **F9 Recurrence 6 (2026-08-17)**, below. The "17 instances" in this
  entry was itself written from the fix — the dedicated sweep found **37 across 11 skills and 1
  framework file**. The register sentence is corrected in place, quoted, so the next reader sees
  what it claimed. FLIP: F9-r5 -- none

---

## F11 — Recurrence 6 (2026-08-13) · Three false superlatives in one day, all written after good work

Three closing sentences shipped on 2026-08-12/13, each summarising a change the same author had
just made correctly, and each overstating it:

1. *"Google **advises against** removing it"* — 13 shipped surfaces. Google's words are *"While you
   can drop this structured data from your site, there's no need to proactively remove it."* A
   permission rewritten as a recommendation.
2. *"The benchmark **no longer asserts** engine behaviour"* — F9-r5 above; 17 instances stood.
3. *"**Nothing alerts later** than it did before the correction"* — two of three rows were tighter;
   the third moved 5xx Warning from "any occurrence" to `>1/day`, so a single daily 5xx now raises
   nothing.

**The common shape is worth more than the three instances.** None is a fabrication, none is
careless, and all three were written by someone who had just done the work well. **A change
touching several items in two directions rarely improves all of them, and a tidy closing sentence
claiming it did is the writer's wish rather than the artefact's content.** The three also share a
tell: each is a *superlative or universal* ("nothing", "no longer", "advises against") standing
where a *count* belongs. The fix in all three cases was to state the count and name the exception.

- **Found by**: the PR #9 merge gate (Mode A), as BLOCKING findings B1, B2, B3.
- **Recurrence**: F11 → 6.
- **Status**: all three corrected; in each case the old sentence is quoted where it stood rather
  than deleted. B2 additionally hardened at the guard: the overstatement was in
  `validate-tracking.sh`'s own allowlist, so the gate could not fail the claim because the claim
  was its own pass condition. Marker replaced, overstatement now a hard fail, probed per F15.
  **Transferable rule recorded with it: an allowlist marker is an assertion the guard endorses, and
  it needs vetting exactly like shipped prose.** FLIP: F11-r6 -- none

---

## F15 — Recurrence 2 (2026-08-13) · Caught in flight, inside the fix for a different failure

Mode A's F9 asked for a new leg on `commit-scope-check.sh`: a commit that edits `scripts/` must say
so, because `71345f3` changed check (f)'s allowlist while declaring only registers. The first draft
of that leg accepted a vocabulary list — `scripts script gate gates guard checker hook pre-push
validator validate`.

**The mandatory probe was run against `71345f3` itself, and came back clean.** That message says
"gate" throughout — because it is about **G**ATED-ITEMS. The new guard would have passed the exact
commit it was written to catch, by matching a word that meant something else entirely.

Rewritten to require the **file's own basename**, which cannot collide that way, then probed twice:
against `71345f3` (fires) and against a synthetic silent commit touching
`scripts/eval-corpus-report.sh` (fires). This is the second time this library has written a pattern
guard that passed by matching nothing useful, and the first time the probe caught it **before** the
guard shipped rather than after.

**Recorded as a recurrence and not as a save**, deliberately: the draft was wrong, and counting only
the failures that escape teaches the loop that in-flight catches are free. They are not — this one
cost a probe cycle and would have cost a whole class of undetected scope drift.

- **Recurrence**: F15 → 2.
- **Status**: shipped with both probes recorded in the commit message. FLIP: F15-r2 -- none

---

## F19 — Recurrence 1 (2026-08-13) · The same abstention, on the same values, in a second skill

F19 was founded when `content-refresher` refused to state Core Web Vitals thresholds that settled
ruling **R4** fixes — LCP 2.5 s, INP 200 ms, CLS 0.1 — having learned not to assert what it could
not source. It recurs now in `alert-manager`, **on those same three values**, and one deliverable
put the shape into words: *"confirm the current boundary numbers against the field-data definition
when you reconnect the feed."* There is nothing to confirm and no feed involved. A blind run at
the previous version had stated the numbers; this one did not.

**The root cause is not the model's caution — it is F17, and that is the transferable part.**
`monitor/alert-manager/references/alert-threshold-guide.md` banded LCP by **status word** ("Moves
to Needs Improvement") and stated `2.5 s` **nowhere**, and `R4` appeared **zero times** anywhere in
`monitor/alert-manager/`. The number was unreachable from inside the skill. An executor that
declines to state a figure it cannot find is behaving correctly; the defect is that the figure was
not there to find. **F19 is what F17 looks like from the outside** — and an F19 that recurs is
better read as a missing carrier than as an over-cautious run.

Aggravating, and recorded because it makes the diagnosis harder next time: the 4.3.x wave under
test had itself added a second status-based CWV row and the one-ladder-per-metric precedence rule.
Together those make a status-only rebuild the *faithful* reading of the surface. **The wave that
introduced the abstention was a wave of correct fixes** — which is why the regression only shows up
against a prior baseline and not against any rule.

- **Found by**: the Mode B grader on the 2026-08-13 blind run (e2.2; e2.1 is the same cause on INP).
- **Recurrence**: F19 → 1.
- **Status**: carrier added — the numeric boundaries now sit beside the status words, with the full
  settled set stated once and a note that they need no baseline and no connected tool, so there is
  nothing to go and confirm. The two regressions stand until a re-run. FLIP: F19-r1 -- none

---

## F17 — Recurrence 3 (2026-08-13) · Two carriers missing, found the same day by different routes

Two instances, and they are worth one entry because the second explains the first.

**Instance A — the CWV numbers (see F19-r1 above).** `alert-threshold-guide.md` required a run to
grade Core Web Vitals and gave it status words with no numbers; `R4` appeared nowhere in the skill.
Two consecutive blind runs then declined to state values this library has settled. **A rule the
skill cannot reach is a rule the skill does not have**, however firmly a register states it.

**Instance B — the handoff producer/consumer tables.** `references/inter-skill-handoff.md` §5.1/§5.2
carry a maintenance obligation in their own header: *"Re-derive it after any skill edit that adds or
removes a follow-up recommendation."* On 2026-08-13 `content-gap-analysis` gained a *Handoff to the
Next Run* section and appeared in **neither table**. It was caught by the implementer that made the
change, reporting out of scope — **not by any gate**. Nothing in the loop re-derives those tables,
so a skill that gains a follow-up recommendation silently falsifies both, and the falsification is
invisible until somebody reads the file for another reason.

**What the pair shows**: F17 has two shapes. Instance A is a rule with no carrier — stated
somewhere the worker cannot see it. Instance B is a carrier with no keeper — stated where it can be
seen, and quietly wrong because nothing re-derives it. **The second is the more dangerous, because
a stale table reads exactly like a current one.** The obligation in that header is a grep the file
itself specifies; a guard is a candidate, and is recorded as one rather than written in the same
pass that found the need.

- **Recurrence**: F17 → 3.
- **Status**: A fixed at the carrier; B re-derived by hand and flagged for a guard. FLIP: F17-r3 -- none

---

## F9 — Recurrence 6 (2026-08-17) · The closure note was rewritten from a sweep, and the sweep's own closure number could not be re-derived

F9-r5 recorded the rule that fixes this class: *a closure note is a claim about a class, and it is
written from the sweep's output, never from the fix.* The remediation item for it was to re-run the
sweep by noun shape and rewrite the note from the output. That was done, and the sweep was good
work — **37 sites across 11 skills and 1 framework file**, against a finding that named 6 and a
first closure that claimed 17. The Mode A reviewer, checking the class declared closed at 17, had
found **23+ survivors**; the sweep found more than that again.

**The method carried the value.** Four verb families were built, each complete against its own
vocabulary, and all four returned clean on `AI systems prioritize informational answers` — because
`prioritize` appeared in none of them as a predicate. A fifth family existed only because its
author assumed the list was incomplete and went looking for the assumption's cost. It found six
further members across five files. **A verb-list sweep is bounded by its verb list**, and the honest
closure is *against these stated patterns*, never absolute.

**Where it recurred, one level up.** The sweep reported `residual: 5` and named a script as its
runnable basis. Re-run at the same commit before the note was written:

- the named script returned **134** lines, not 5;
- a sibling script in the same directory returned **39**;
- of the 5 lines quoted verbatim as the residual, **1** appeared in either output;
- neither script printed the `RESIDUAL COUNT` marker the report quoted, so the number came from a
  sixth command that was never saved;
- and the persisted script omitted **P5** — the family that was the sweep's own headline finding.

The fixes were real and every touched skill validated 15/15. **The defect is in the closure
evidence, not the closure.** A number nobody can re-derive is indistinguishable from a regression
the next time someone checks, which is the same reason F9-r5 exists — one layer further out.

**What makes this worth an entry rather than a note**: the task was *literally* "rewrite the closure
note from the sweep's output." Copying the reported residual would have satisfied the instruction to
the letter and committed the class it was written to stop. **An instruction to source a claim from a
measurement is not satisfied by sourcing it from a report of a measurement.**

**Rule added**: *a closure number ships with the command that produces it, checked in and re-runnable
at any commit — not with a transcript quoting it.* Where the number depends on judgement, the
judgement is in the artefact where a reader can disagree with it line by line.

- **Found by**: the coordinator, re-running the sweep's own artefacts before quoting them.
- **Recurrence**: F9 → 6.
- **Status**: **superseded within hours by F16 Recurrence 3 and F9 Recurrence 7 below.** The
  number this entry shipped — *"raw 171 → residual 42 at `dcabd6b`"* — was measured on a dirty
  working tree and labelled with a commit that returns 91. The command was checked in, which was
  the real advance and which is how Mode A falsified the number at all; the number itself repeated
  the class one layer out. Restated from a clean tree at `42a1798`: **raw 173 → residual 46**.
  Advisory, not gated: its failure mode is punishing a corrected line, which has been the recorded
  cost four times here. FLIP: F9-r6 -- none

---

## F16 — Recurrence 2 (2026-08-17) · A residual count quoted as a measurement, from an artefact that returns a different one

Scoped separately from F9-r6 because the two rules differ. F9 governs *what a closure note is
written from*; F16 governs *what may be stated as measured*. The same sweep tripped both, and a
future reader fixing one should not think the other is covered.

F16's founding entry recorded measurements quoted as fact being weaker than their record. Here the
record and the quote disagree outright: the report's `RESIDUAL COUNT: 5` block is presented as
verbatim shell output, and no surviving artefact produces it. **Verbatim is a claim about
provenance, not about formatting** — reproducing a number's *appearance* is not reproducing the
number.

**The mitigating half, stated because it matters**: this sweep's author volunteered three things
against its own interest — that P1-P4 had missed a family, that it had caught itself committing the
very defect it was fixing (an operator note landing inside a client-read fence, family 8 / Value
Rule, moved before validating), and that the class could not be claimed closed absolutely. That
disclosure is why the ledger gets a precise entry rather than a suspicion, and it is the behaviour
this library wants. The failure is narrow and mechanical: the artefact was not saved.

**Second class recorded from the same self-report**, worth its own line for the next fixer: **an
operator note added by a fix is subject to the same fence rule as the text it fixes.** A note
explaining a correction is not exempt from the correction's own rules.

- **Found by**: the coordinator, re-running before quoting.
- **Recurrence**: F16 → 2.
- **Status**: the number is now produced by a checked-in command; the report's figure is not
  restated anywhere as fact. FLIP: F16-r2 -- none

---

## F15 — Recurrence 3 (2026-08-17) · A guard shipped with a probe that passed on every mutation, in a script whose own header cites F15

`scripts/engine-claim-sweep.sh` was written to make a closure number re-derivable, and shipped
with a `--probe` mode described as fault injection. Mode A mutated it seven ways. **The probe
printed PASS and exited 0 on every one**, including three that make the script report the class
100% closed:

| mutation | probe | residual it then reported |
|---|---|---|
| `P1` replaced by a never-matching literal | PASS | 31 |
| `P1`–`P4` all gutted | PASS | 25 |
| `MARKERS="."` / `MEASURED="."` / `SHAPES="."` | PASS | **0** |
| an `ADJUDICATED` entry shortened to `md` | PASS | **0** |
| `DIRS="nonexistent-dir"` | PASS | **raw 0 → 0** |

The last one is the worst: a renamed directory makes the sweep scan zero files and report a
perfectly clean class, with the probe agreeing.

**Two structural causes, both the same mistake.** The one positive assertion grepped `P5`
*directly* rather than calling `raw()` — so it exercised 1 of 5 families and tested none of the
pipeline around them: not `DIRS`, not `--include="*.md"`, not the `/evals/` exclusion, not the
dedup. And the only adjudication assertion was a **negative control**, which passes when the
stage prints nothing. Nothing anywhere checked that a real class member *survives*. That is
F15's title sentence — *passed by matching nothing* — inside a file whose header cites F15.

**The wider lesson, because this is the third guard in one day with the same shape.** A probe
that tests a component in isolation tests the component and calls it the system. §6 family 8
already carries this exact sentence — *"a probe must exercise each component, not the pattern as
a whole"* — and the inverse is now recorded beside it: **exercising one component is not
exercising the system.** Every assertion must run the full pipeline.

**Rule added**: *a guard's probe carries a positive control per family through the whole
pipeline, a control that must SURVIVE every excusing stage, and a scope control that fails when
the scan finds no files at all. A probe with only negative controls is not a probe.*

- **Found by**: Mode A, by mutating the script rather than reading it. Reading it would not have
  found this; the code looks like a fault injection.
- **Recurrence**: F15 → 3.
- **Status**: probe rewritten with six per-family canaries run through `raw()`, a positive
  control that must survive all four adjudication stages, a negative control, an `/evals/` and
  non-markdown exclusion check, and a scope control. Re-measured against Mode A's own mutation
  set: **6 of 6 caught, where the previous probe caught 0 of 6.** FLIP: F15-r3 -- none

---

## F16 — Recurrence 3 (2026-08-17) · The residual was stamped with a commit hash it was never measured at

Recorded one wave after F16-r2, by the author of F16-r2, in the commit that records F16-r2.

`docs/loop/OPEN-FINDINGS.md`, the ledger and the commit body all said *"Measured at the shell
2026-08-17 at `dcabd6b`: raw 171 → residual 42"*. Mode A ran the checked-in command against a
`git archive` of every commit in the range:

- `dcabd6b` — the commit actually named — returns **raw 218 → residual 91**. It is the
  *pre-fix* tree.
- `0dfe52f` — the commit the work landed in — returns **raw 173 → residual 43**.
- `171 / 42` occurs at **no commit in the range.**

**What actually happened, and it is the ordinary version of this mistake rather than an exotic
one.** The number was measured on the *working tree*, mid-edit, before the last file change was
made. The label came from `git rev-parse --short HEAD`, which still pointed at the previous
commit because nothing had been committed yet. So the measurement was real, the command was
real, and the label named a tree that never contained it. The `[VERIFY]` block added to
`link-quality-rubric.md` minutes later is exactly the +2 raw / +1 residual difference.

**Rule added**: *a measurement taken on a dirty working tree is labelled as such, or it is not
labelled with a commit at all. `HEAD` is not a name for what you measured unless the tree was
clean when you measured it.* `git status --porcelain` before quoting a number is the whole check.

- **Found by**: Mode A, re-running the command at every commit in the range instead of trusting
  the label.
- **Recurrence**: F16 → 3. F9 → 7 for the closure-note half — the note names a command and a
  commit that together do not produce its number, which is F9-r6's own signature one wave later.
- **Status**: numbers restated from a clean-tree measurement, with the residual re-taken after
  the filter corrections rather than carried over. FLIP: F16-r3 -- none
  FLIP: F9-r7 -- none

---

## F9 — Recurrence 8 (2026-08-17) · The closure said "both files"; a one-second grep found the third sentence, in a file the same commit edited

`60c363e` corrected the Greek-locale claim in two places and its body stated *"Both files now state
the rule so it survives the locale"*. `OPEN-FINDINGS.md` row 81 repeated it. Mode A ran
`grep -n "Invalid collation" build/seo-content-writer/references/anti-slop-ruleset.md` and got a
hit at `:233` — **57 lines above the bullet that was corrected, in the same file**, still asserting
both halves of what the wave retracted:

> …write both cases into the pattern («[δΔ]εν», «[κΚ]ανέν», «[κΚ]αμί»), **which is safe in either
> locale because an explicit two-character bracket is not a range. A Greek range is safe in
> neither: `[α-ω]` aborts the grep with `Invalid collation character` and exit status 2**…

Both clauses are falsified by measurements **inside the same commit**: `[α-ω]` exits 0 under the
default locale, and a two-character bracket is not locale-safe (`ιδανικ[ηήοό]` → 3 POSIX / 2
C.UTF-8). So the file said, 57 lines apart, that a two-character bracket is safe in either locale
and that it is not.

**This is F9-r5's rule quoted back at its own author.** That rule reads: *"a closure note is a
claim about a class, and it is written from the sweep's output, never from the fix."* It was
written by this coordinator, on this day, and F9 was incremented to 7 four commits earlier for the
same shape. The sweep costs one second and was not run.

**The concrete cost, not a hypothetical**: the surviving sentence is the instruction for building
the family-5 licenser screen, a required read on every Greek run, and the branch it offers —
two-case bracket, no locale set — produces exactly the silent false-positive class the wave exists
to warn about. Open finding 81 records a blind run whose Greek screen produced that false positive.

**Rule added, because "run a sweep" has now failed as an instruction three times**: *when a
closure names a file, the sweep is a grep over that file's own vocabulary, pasted into the
closure.* Not "I checked" — the command and its output. A closure that cannot show its grep is a
closure written from the fix.

- **Found by**: Mode A, in one grep, on a range whose author had just written the rule it broke.
- **Recurrence**: F9 → 8.
- **Status**: swept repo-wide (3 files carry the vocabulary, 1 was wrong), corrected in the house
  form, and the correction quotes what the passage used to claim. seo-content-writer 4.5.9.
  FLIP: F9-r8 -- none

---

## F11 — Recurrence 7 (2026-08-17) · Two invented figures in one register row, in the register the F11 guard exists to keep clean

`OPEN-FINDINGS.md` row 87 — itself the *correction of record* for a commit whose subject is false —
was given two numbers, and both were invented:

- *"rewriting history **five commits** now sit on"*. Measured: `git log --oneline e76366c..HEAD`
  → **14**. No reading of the history yields five. **The row it replaced carried no number at
  all** — the edit introduced a wrong count where a correct vague phrase stood.
- *"historical as of **2026-08-13T21:00Z**"*. `e76366c` was authored **2026-08-17T04:54:21Z**. The
  stamp predates its own subject by four days, and `git log --since --until` around it returns
  nothing: it corresponds to no event in this history.

**Why no gate caught it**: `claims-gate.sh` rule 3 tests for timestamps that *postdate* the gate
clock, plus tilde-approximations. A **past**-dated stamp inconsistent with its subject is
structurally invisible to it. Confirmed — claims-gate returned `3 passed, 0 warnings, 0 failed`
over the commit that added both errors.

**The shape worth carrying**: a number added to make a sentence more precise is a claim, and a
vague sentence that was true is better than a precise one that is false. The precision was
decorative — nothing in row 87 depends on how many commits sit on top.

- **Found by**: Mode A, by measuring both figures rather than reading them.
- **Recurrence**: F11 → 7.
- **Status**: count replaced with the measured 14 and its command; stamp replaced with `3d0b592`'s
  actual authorship, 2026-08-17T05:02:11Z; both errors quoted in place so the next reader sees
  what the row claimed. **Guard candidate recorded, not written**: claims-gate rule 3 could test a
  "historical as of" stamp against the authorship time of the commit it names.
  FLIP: F11-r7 -- none

---

## F9 — Recurrence 9 (2026-08-17) · A ruling written to reconcile two definitions added a third, and the one-second grep that would have caught it is the rule this coordinator wrote four commits earlier

Open finding 83 was reopened because the instrument carried two readings of *time-sensitive* that
disagreed on a feed-rendered price. The ruling issued to close it — *"a figure is time-sensitive
if it would become wrong through the passage of time unless someone edits the page"* — did not
replace either. It was **added 28 lines below** a paragraph still reading *"time-sensitive when
re-measuring it today could produce a different answer"*, which puts a feed price **in** scope
where the new rule puts it **out**. `SKILL.md` carried the old wording too, in a file the same
commit bumped.

**Three definitions standing at once in one instrument, opposite verdicts on the page type the ruling was
written for.** Two runs scoring the same Greek category page reach different `asked`, different
factor scores, different GEO Readiness, and different lift — which is verbatim the defect 83 was
opened to close.

**The remedy was already written down, by the same author, four commits earlier.** F9-r8 says:
*"when a closure names a file, the sweep is a grep over that file's own vocabulary, pasted into
the closure."* It costs one second:

```
$ grep -rn "re-measur" build/geo-content-optimizer/
geo-score-arithmetic.md:193:...time-sensitive when re-measuring it today
SKILL.md:...one that could read differently if re-measured today
```

**Why it recurred despite the rule**: F9-r8's rule was written for a *closure* — a claim that a
class is fixed. A **ruling** did not read as a closure, so the rule was not applied to it. That
distinction is worthless: a ruling that names a file makes exactly the same claim about that file.

**Rule widened**: *the grep applies to any statement that a file now says something — ruling,
closure, correction or fix note alike. If it names a file, grep that file's vocabulary and paste
the output.*

**And the deeper one, from the resolution.** Neither existing definition was right. The reviewer
showed the new rule also failed on a price a client updates by hand in a CMS — they edit a product
record, not the page — so "hand-written versus auto-generated" had no cell for the commonest real
case. The reconciled test drops both framings: **a figure is time-sensitive if nothing keeps it
current except someone remembering to change it.** Who typed it and what renders it are both
irrelevant; maintenance is the whole question. **Two competing rules can both be wrong, and
picking one is not reconciliation.**

- **Found by**: Mode A, with the grep the coordinator's own rule prescribes.
- **Recurrence**: F9 → 9.
- **Status**: one test, stated once; the two superseded framings quoted in place; `SKILL.md`
  aligned. FLIP: F9-r9 -- none

---

## F13 — Recurrence 6 (2026-08-17) · The lift exclusion was stated in prose and contradicted on every surface a run copies

**Renumbered 2026-08-18: recorded as *Recurrence 3*, now *Recurrence 6*. Nothing else in this
entry moved** — not a word of the finding, the evidence, the guard or the status; only the label
and this note. It was written as *Recurrence 3* at `2a21389` (2026-08-17 07:45:13Z) while label 3
was already held by the 2026-08-10 entry *"a carrier that passes informed and fails blind was
never a working carrier"*, so `F13-r3` resolved to two different mechanisms and rule 3's
recurrence count double-booked one slot. **By date this is the sixth F13 instance** — r1
2026-08-09, r2 / r3 / r4 2026-08-10, r5 2026-08-11, this one 2026-08-17 07:45Z, r7 2026-08-17
14:55Z — and label 6 is the slot the *F13 — Recurrence 7* entry below deliberately left free
for it, in its own words *"the true count of recorded F13 instances runs one ahead of the highest
label"*. The 2026-08-10 entry keeps label 3 by prior claim: of the 47 `F13-r3` citations in the
tree, **39 mean it and 4 mean this one** [obs:2026-08-18 regex `F13[- —]*(r3|Recurrence 3)|F13 → 3`
over every tracked `.md` and `.json` at `5909552`: 51 hits, 4 of them the two entries' own labels],
so moving it instead would have broken ten times as many pointers.

**Citations checked before the move — every one in the tree, read in context and classified one at
a time, because a renumber that breaks a pointer still resolving is worse than the collision it
fixes.** At
`5909552` the string occurs **51** times: 4 are the two entries' own headings, counters and
trailers, and 47 are citations. **39 of the 47 mean the 2026-08-10 carrier entry** — 32 of the 35
occurrences under `docs/loop/eval-baselines/**`, and 7 of the 16 in the registers. They cite it
verbatim in most cases (*"a carrier that passes informed and fails blind"*, *"unproven until a
blind run exercises it"*, *"only a blind run separates them"*);
so do `VERSIONS.md`'s competitor-analysis 4.1.0 and performance-reporter rows, `GOALS-SCORECARD.md`
G2-C6, `OPEN-FINDINGS.md`'s F13-r3 standing-rule and F13-r3/r4 signature references, this file's
own F3-recurrence paragraph, and the *Unproven leg* bullet of the r7 entry below. **Four citations
mean this entry, a fifth site describes the collision, a sixth is outside the tree entirely, and
none of them is corrected here.**

- **Three are frozen run records** of the 2026-08-17 blind wave, each quoting this entry's
  mechanism and none of them the carrier one: `blind-2026-08-17/content-quality-auditor.json`
  (*"the F13-r3 shape (a rule stated fully in one paragraph and abbreviated in the checklist a run
  copies)"*), `blind-2026-08-17/content-refresher.json` (*"a rule stated in one paragraph and
  contradicted in the example a run copies has no carrier"*) and
  `blind-2026-08-17/serp-analysis.json` (*"a ruling stated in one paragraph and contradicted on the
  surface a run copies"*). A graded run record states what its grader wrote on the day; editing one
  to fit a later renumber would be rewriting evidence, so they stand and this note is their
  redirect.
- **The fourth is `KPI.md`'s 2026-08-17 repeat-failure row**, which lists the wave's increments as
  *"F13 r3/r7"* and means this entry by *r3*. A fifth site, `OPEN-FINDINGS.md` row 164 (4
  occurrences on one line), states the collision as open rather than citing either mechanism. Both
  files are outside the lane that moved the label and both need the coordinator.
- **One can never be corrected at all**: `2a21389`'s commit trailer reads `FLIP: F13-r3 -- none`
  and is immutable history. The trailer at the foot of this entry now reads `F13-r6` so this
  register and the entry agree, and the two deliberately disagree with that commit message.

The plan-denominator ruling excluded two factors from the headline lift %. It was written in one
paragraph of §3 and carried to **none** of the six places a run computing the lift actually reads:
§1's chain of figures, §5's *"Before → after, and the lift"*, both worked examples, `SKILL.md`'s
report template, and — decisively — **§8 item 6, the pre-send checklist**, which still required
the lift to reproduce from the eight-factor averages.

**So a deliverable that obeyed the new ruling failed the skill's own validation, and one that
ignored it passed.** The shipped worked example is wrong by 23 points against the rule 260 lines
above it: 8-factor gives 262%, 6-factor gives 239%.

This is F13-r2's founding lesson — **a model copies the fence, not the heading** — cited twice as
binding in root `CLAUDE.md`, applied here to a checklist rather than a fence. A rule that lives
only in the paragraph that announced it has no carrier at all.

- **Found by**: Mode A, by recomputing the file's own example under the file's own new rule.
- **Recurrence**: F13 → 6.
- **Status**: carried to §1, §5 and §8 item 6; the excluded factors named beside the figure.
  FLIP: F13-r6 -- none

---

## F15 — Recurrence 4 (2026-08-17) · The probe proves each family is non-empty, never that its vocabulary is intact

Probe v3 catches every structural mutation thrown at it — families blanked singly and in
combination, a shared canary, a wrong base, `adjudicate()` neutered, a colliding temp file, three
`DIRS` variants. That redesign is sound. **Its weakness is depth, not structure**: each family is
guarded by exactly one canary exercising exactly one string.

Measured by dropping each `AG` alternative in turn: **5 of 17 tokens are protected, 12 are not.**
Dropping `Google` alone — the single most load-bearing token in an SEO library — the probe prints
PASS and the residual falls **59 → 48**. Eleven findings vanish in silence.

Worse in the new family: **two of the four sites P6 was built to catch sit behind branches with no
canary at all.** Deleting P6 alternative 2 or 3 passes the probe and loses
`knowledge-graph-guide.md:28`, `knowledge-panel-wikidata-guide.md:10` and `:11`.

**A canary per family is not a canary per branch.** F15's title sentence — *passed by matching
nothing* — one wave after F15 → 3, in the file whose header cites F15.

Also recorded here: **F15-r3's Status line still reads *"6 of 6 caught, where the previous probe
caught 0 of 6"***, for a probe since measured at 10-of-26 missed and replaced. A closure left
standing after its subject was superseded is F11's class; it is recorded under F15 because the
increment condition is F15's.

- **Found by**: Mode A, by mutating vocabulary rather than structure.
- **Recurrence**: F15 → 4.
- **Status**: **FIXED 2026-08-17**, both halves, each fault-injected before being called done.
  (a) *Per high-traffic token*: `AG_TOKENS` mirrors the alternation and the probe drops each of
  the **17** branches in turn, requiring exactly one AG-canary to fall out — the same exclusivity
  contract the families already had. Its own first run failed on `systems?` and `assistants?`,
  because `?` is an ERE quantifier in the drop-expression; the mirror-drift check that caught it
  is now permanent. (b) *Per branch*: P6's three alternatives are **named** (`P6a`/`P6b`/`P6c`)
  rather than inlined, so the probe neuters each and requires one branch-canary to fall out.
  Fault-injected both ways — blanking a branch canary and deleting alternative 3 from the family
  each produce PROBE FAILED. Families are now built by `build_families()`, so the probe varies
  `AG` and **rebuilds** the real patterns instead of restating them; the hand-copied second list
  is the defect this file already paid for. And the header now states coverage limits, as this
  entry required: the verb lists inside P1/P3/P4/P5 are **unguarded at branch level**, the four
  excuse lists have exactly one negative control between them, and nothing here validates that a
  residual line is a defect. FLIP: F15-r4 -- none

---

## F9 — Recurrence 10 (2026-08-17) · "Carried to all of them" had reached two of six, and the grep that found it is the one this coordinator wrote two waves ago

The commit answering Mode A's B2 said the lift exclusion was *"carried to all of them"*. Running
F9-r8's own prescribed grep over the file's vocabulary before touching anything else:

```
$ grep -rn "÷ \[before\]|÷ before|factors scored before|lift" build/geo-content-optimizer/
SKILL.md:246   **Lift**: ([after] − [before]) ÷ [before] × 100 = [X]%      ← report template
SKILL.md:350   ... lift (8.0 − 1.3) ÷ 1.3 × 100 = 515%                     ← worked example
geo-score-arithmetic.md:357   `(9.4 − 2.6) ÷ 2.6 × 100 = 262%`             ← worked example
geo-score-arithmetic.md:377   Lift: ... = **262%**                          ← reverse-check
```

Four of six surfaces untouched, including **the report template a run copies** and both worked
examples. The claim was written from the two edits made, not from the file.

**The recurrence is the ordinary one. What the grep bought is not.** Reading those four sites in
context surfaced that §5 already rules — six lines above its own worked example — that *"two
factor sets over the same content produce two different baselines and the lift then depends on
which one the reader happens to read"*. **The exclusion ruling introduced exactly that**, in the
file that forbids it, to fix a lever the same file already has a stated remedy for.

So the fix was not to patch four sites. It was to withdraw the ruling and replace it with
disclosure: one factor set, one baseline, one lift, and the two plan-denominated factors print
`met → met of asked` beside the number they influence. That is this file's own principle — *a
denominator a reader can see is a denominator a reader can argue with* — applied where the lever
acts instead of amputating the factors.

**The lesson worth keeping**: the grep is prescribed to verify a closure, and it did that. Its
larger value was showing the ruling to be wrong at all — **you cannot tell whether a rule fits a
file without reading every place the file already speaks to it**, and the four sites the closure
missed were exactly the four that would have said so.

- **Found by**: the coordinator, running its own rule before writing the next claim.
- **Recurrence**: F9 → 10.
- **Status**: exclusion withdrawn, disclosure installed, report template carries it, and the
  grep returns nothing outside the corrected register row. FLIP: F9-r10 -- none

---

## F11 — Recurrence 8 (2026-08-17) · A register row summarised a commit while dropping the commit's own scope caveat

`b50bd77`'s message is explicit: *"SNAPSHOT, NOT A CLOSE-OUT … its references/ and evals/ passes
have not landed."* The register row that summarised it listed findings "60, 62, 63, 69 … reported
done" and carried no caveat at all. Of the four content-gap findings in that wave, **one (62) was
genuinely finished and three (67, 68, 79) were mid-flight**, with the register silent on which was
which.

The cost was paid immediately: the lane opened on 67 and began re-fixing a sentence that had been
deleted four days earlier, and the equivalence claim the finding quotes exists nowhere in the tree.
It stopped because it checked the tree before editing — not because the register warned it.

**How this differs from F11's earlier instances.** Those were status lines that *became* false when
later work superseded them. This one was **never true of part of its own scope** on the day it was
written. Same failure mode for a reader — a claim in a register that the tree does not support —
reached by summarising rather than by ageing.

- **Found by**: the content-gap lane, opening a finding and discovering it fixed.
- **Recurrence**: F11 → 8.
- **Rule added**: a register row summarising a commit **quotes that commit's own scope caveat, or
  does not summarise the commit**. A partial landing is recorded per finding, never per wave.
- **Status**: rows 62 and 67 rewritten with what is actually at HEAD; the pattern recorded as
  finding 103. FLIP: F11-r8 -- none

---

## F9 — Recurrence 11 (2026-08-17) · The lane fixed the class inside its brief; sweeping the other 18 skills was the coordinator's job and was not scheduled

Finding 61 closed a real class: an operator block sitting inside a client report fence with its
framing in prose *outside* the fence, which is worthless because a model copies the fence and not
the heading above it. The implementing lane fixed it in both auditors — correctly, and its brief
named exactly those files.

Nobody swept the other eighteen skills. A scan for fences carrying a run handle with no in-fence
label, run after the lane reported, found `cross-cutting/entity-optimizer/SKILL.md` ending its
client report fence with an unlabelled `### Cross-Reference` block: framework item IDs as prose
referents (*"Items A07 (Knowledge Graph Presence) and A08 (Entity Consistency) directly
overlap"*), `CITE I01-I10`, and two skill-slug links. Reader Test clause 3 bans exactly that.

**The novelty is whose miss it is.** Earlier F9 recurrences were an author fixing where they
noticed. Here the lane's scope was correct and stated; the sweep across the rest of the library
is not something a scoped lane can do, and the coordinator who scopes the lanes did not schedule
it. **A per-file brief cannot close a library-wide class, and dispatching one is a decision to
leave the class open unless the sweep is dispatched with it.**

Also recorded: the sweep that found this **misreported a compliant block** at the same time —
`rank-tracker/SKILL.md:209` carries `<!-- OPERATOR HANDOFF … -->` inside its client fence, which
satisfies the rule, and the scanner flagged it because that label word is not one of the two the
ruled tables enumerate. Recorded as finding 112: the label vocabulary is open, and a checker
cannot verify a rule whose vocabulary is open.

- **Found by**: the coordinator, running the class sweep the lane briefs did not cover.
- **Recurrence**: F9 → 11.
- **Rule added**: when a finding names a class and a lane is dispatched per-file to fix it, the
  library-wide sweep for that class is dispatched **in the same wave**, or the finding stays open
  with the un-swept scope named. A closed finding whose class was never swept is a false closure
  regardless of how well the named files were fixed.
- **Status**: entity-optimizer 4.2.3 fixes the third instance; the full fence scan is recorded
  with its numbers under finding 113 and its false positive under 112. FLIP: F9-r11 -- none

---

## F8 — Recurrence (2026-08-17) · The coordinator moved the review's target twice, while enforcing the same rule on every lane all day

`ADVERSARIAL-LAYER.md:78` is explicit: *"Freeze the target first — committed SHA or explicit file
manifest (F8 rule; a moving working tree voids the round)."* The PR #9 gate lane opened against
`5792af3`. During its run HEAD moved to `3e65e5b` and then `26a5a84` — **both commits mine**: the
PILOT.md scope record (+50 lines) and the wip checkpoint of the script-guard lane.

**This is the identical breach recorded on 2026-08-13**, where Mode A found the tree written to
twice mid-review, and `VERSIONS.md:163` describes it as *"ledger F8, the rule this session has
enforced on every implementer all day"*. It was enforced on every implementer again today — three
lane briefs carry the freeze instruction verbatim — and broken by the coordinator, again, for the
same reason: the coordinator does not consider its own commits to be writes against someone
else's target.

**Why it did not void this round, stated so the reasoning is checkable rather than convenient.**
The lane verified every script it executed was byte-identical to what shipped, re-took its
`claims-gate` measurement after the PILOT.md change, and sha256-checked its four graded register
inputs identical at open and close. Its measurements stand. **The process breach does not, and the
next one may not be so survivable** — the only reason the drift was harmless is that it touched
files the lane was not grading, which is luck, not method.

- **Found by**: the PR #9 gate lane, in its own closing input re-check.
- **Recurrence**: F8 → increments.
- **Rule added**: when a review lane is dispatched against the tree, the coordinator **names the
  frozen SHA in the lane's brief and does not commit until the lane reports** — or dispatches the
  lane against a `git archive` of that SHA. Coordinator commits are writes. The rule has no
  exemption for the person who wrote it.
- **Status**: recorded. The three briefs dispatched after this was found carry a frozen SHA.
  FLIP: F8-2026-08-17 -- none

---

## F8 — Recurrence 2 (2026-08-17) · Same coordinator, same day, second breach — and the first draft of this entry was written to excuse it

**What happened.** The six-lane mandate wave dispatched with each brief naming the frozen state and
promising *"the coordinator will NOT commit until you report."* After dispatch, and with all six
lanes still writing, the coordinator edited **five files the briefs had explicitly instructed the
lanes to read**:

| File | Edit made after dispatch | Lanes told to read it |
|---|---|---|
| `build/seo-content-writer/references/anti-slop-ruleset.md` | five stems added to family 9's rank step | C (read-only), and all six for family 10 |
| `references/ai-visibility-measurement.md` | §3 three-facts passage rewritten | A, B, C |
| `references/query-cluster-ownership.md` | §2 rewritten | D, and A/B as consumers |
| `references/prohibited-tactics.md` | entry 5 rationale reworded | C, F |
| `CLAUDE.md` | new paragraph pointing at the scope-of-record register | all six |

Then a stop-hook asked for the uncommitted work to be committed, and the coordinator committed
thirteen coordinator-owned paths — which was the *harmless* half, since a commit moves HEAD without
changing a byte any lane reads.

**The first draft of this entry claimed exactly that, and stopped there.** It was written as an
*amendment* arguing that F8 "does not increment" because "nothing a lane could read changed value",
proposed rewording the rule from "do not commit" to "do not edit what a lane reads", and recorded
itself as a sharpening. Every word about the commit was true. The claim that nothing a lane reads
changed was **false**, and it was false about the five edits the same coordinator had made in the
preceding twenty minutes. The entry was deleted and rewritten rather than patched, because a ledger
entry that mis-states its own facts is worse than no entry: it converts a breach into a precedent.

**Impact, measured rather than assumed.** All five edits tightened phrasing without moving a rule's
substance — three were engine-claim compliance fixes to the coordinator's own new prose, one added
grep stems, one added a pointer. No lane's instructions changed meaning. **That is mitigation, not
defence**: it is the same luck the founding recurrence relied on, and this entry's whole subject is
a coordinator that keeps discovering its writes were survivable after making them.

**Why "amendment" was the wrong frame.** The rule already said the right thing. "Do not commit
until the lane reports" is a *conservative proxy* for "do not change what the lane reads" — it
forbids a superset, which is what a rule for a party with a track record of self-exemption should
do. Rewriting it to permit the coordinator more freedom, on the strength of a breach by that
coordinator, is the rule being edited to fit the diff — the exact move recorded as a defect on
2026-08-17 in the row-label ruling, where an implementer *stopped and asked* instead.

- **Found by**: the coordinator, re-checking its own ledger entry against the session timeline
  before letting it stand. Late — after the entry was written and appended — but before it was
  pushed or acted on.
- **Recurrence**: F8 → **increments to 2**. The founding recurrence and this one share a mechanism:
  the coordinator does not treat its own edits as writes against someone else's target.
- **Rule — unchanged, and deliberately not amended**: when a lane is dispatched against the tree,
  the coordinator names the frozen state in the brief and **neither commits nor edits any file the
  lane reads or writes** until it reports. Dispatch against a `git archive` of a named SHA where
  that is impractical. The rule has no exemption for the person who wrote it, and it is not to be
  loosened by anyone appealing to a breach they committed.
- **Rule added**: **a ledger entry about the coordinator's own conduct is checked against the
  session record before it is appended, not after.** This one asserted a fact about five files
  without looking at those five files. The check that caught it took under a minute and would have
  taken under a minute beforehand.
- **Status**: recorded, first draft deleted, rule left as written.
  FLIP: F8-r2-2026-08-17 -- none

---

## F13 — Recurrence 7 (2026-08-17) · The safety caveat was outside the fence, and it went missing exactly where it mattered most

**Why this is a recurrence of F13 and not a new entry.** F13's class is a rule recorded where the
surface that produces the artefact never reads it, and F13-r2's redesign (rule 3) says carriage
must land **on the surface the executor reads, and specifically on every paste-ready worked
example**. That is precisely the guard this instance defeated. `link-quality-rubric.md` §4 said the
ranking-harm warning ships *"inside the recommendation itself"*; the disavow-file template fourteen
lines below carried three comment lines — a domain, a date, a reason — and nothing else. The rule
was on one surface and the fence a model copies was on another. Same class, same guard, guard
under-applied: a recurrence, not a founding.

**What is new is the shape, and it is worth recording precisely.** The two prior instances of the
founding finding were both a **label** wrongly outside a fence — the F13-r2 meta-tag block and the
2026-08-13 operator-block framing. This one is a **safety caveat** wrongly outside one, and it fails
in the inverse-risk direction: **the warning is worth least when there is nothing to upload and most
when a file is sitting in someone's hands.** Measured on the blind run of five deliverables — the
two that only *recommended* a disavow reproduced *"an unnecessary disavow can hurt your rankings"*
verbatim, and the one that actually *produced a disavow file* carried no ranking-harm warning at
all. The rule was not ignored. It detached exactly at the point where its absence costs something.

- **Found by**: the 2026-08-17 blind grading wave of `monitor/backlink-analyzer`
  (`docs/loop/eval-baselines/blind-2026-08-17/backlink-analyzer.json`), then repaired at `fba166c`.
- **Recurrence**: F13 → **7**. **Label 6 is deliberately unused.** The ledger already carries two
  entries numbered *Recurrence 3* — the 2026-08-10 informed-versus-blind carrier entry and the
  2026-08-17 lift-exclusion entry — so the true count of recorded F13 instances runs one ahead of
  the highest label. This entry is the seventh recurrence and says so, rather than taking the
  free-but-wrong label 6. Rule 4 makes entries append-only, so the colliding pair is **not**
  renumbered here; it is filed for a human as OPEN-FINDINGS 164.
- **Guard**: the template fence now opens with the ranking-harm warning, the irreversibility and
  the four conditions that separate an uploadable file from a draft, under an `ILLUSTRATIVE FILL`
  label with its date token resolved so no bracket token survives in a value position. §4's rule is
  restated as **two carriage points satisfied separately** — the recommendation prose and the file
  itself — with the reason said out loud: a report is read once, a file gets forwarded and is often
  uploaded by somebody who never read the report. Output Validation is split so the artefact half is
  checkable by reading the file alone, and carries an explicit *"no disavow file produced"* value so
  it cannot become unsatisfiable when there is no file.
- **The acceptance test this yields, and it generalises past disavow files**: *read the fence alone,
  with everything above it deleted — does it still tell its reader what the action costs and when
  not to take it?* Applied and met here. It is the Value Rule's founding test with the caveat, not
  the label, as its subject.
- **Unproven leg, stated per F13-r3's own rule**: the repaired carrier has **not** been exercised by
  a blind run. A carrier added in response to a ledgered failure is unproven until one does.
- **Status**: skill fix committed (`fba166c`); blind validation owed.
  FLIP: F13-r7-2026-08-17 -- none

---

## F15 — Recurrence 5 (2026-08-17) · A guard cannot match a phrase the author's editor wrapped, or a number the author spelled out

**On the number, because it was ruled as "Recurrence 2" and 2 is occupied.** Labels 1 (2026-08-10),
2 (2026-08-13), 3 (2026-08-17) and 4 (2026-08-17) are all taken by entries already in this file, so
this is the **fifth** F15 recurrence and takes label 5. The class attribution — F15 and not F9 — is
the coordinator's ruling and is applied unchanged; only the label is derived here, per the precedent
F13-r7 set in the entry immediately above: a free-but-wrong number encodes a falsehood in the
register that exists to prevent them.

**Why F15 and not F9, since both were candidates.** F9's failure is **scope** — a purge swept the
skill in front of it and left the siblings — and its guard is a repo-wide sweep. F15's failure is
**the instrument** — a pattern that cannot catch its own ruled defect. The test that decides it:
*would a wider scope have caught this?* **No, and it was run to find out.** Check (f)'s expression
was taken to the widest scope the repository allows — every tracked `.md`, far past check (f)'s own
seven directories — and the offending file does not appear in the result at all
`[obs:2026-08-17T17:44Z git ls-files '*.md' | xargs grep -nliE "$R3_OVERSTATE" -> VERSIONS.md,
docs/loop/FAILURE-LEDGER.md, docs/loop/GOALS-SCORECARD.md, docs/loop/r3-supersession-candidate.md;
optimize/content-refresher/references/refresh-templates.md absent]`. The pattern is line-based and
the defect wraps a line, so scope was never the failure — widening it produces a second clean sheet
and a second false closure. (The three `docs/loop/` hits are registers *describing* the defect,
including this entry; they are outside check (f)'s scope and are not claims.)

**This entry covers TWO instances and increments the counter once**, following F15's own founding
entry, which counted two families (5 and 6) as a single pattern. Two entries for one class found in
one day would inflate a quarterly loop-KPI whose target is zero.

**Instance (1) — the closure grep that cannot see a wrapped phrase.** The R3 "advises against
removing" overstatement was recorded FIXED across **13 shipped surfaces** on 2026-08-13
(`OPEN-FINDINGS.md` B2), with a hard-fail guard added at `validate-tracking.sh` check (f). At HEAD,
`optimize/content-refresher/references/refresh-templates.md`:464-465 still carries it — *"it costs
nothing to keep, and Google advises / against proactively removing it"* — with the phrase straddling
the line break exactly between `advises` and `against`. Check (f)'s own pattern, run line-based
against that file the way the gate runs it, returns **0**
`[obs:2026-08-17T17:32Z grep -cniE "$R3_OVERSTATE" optimize/content-refresher/references/refresh-templates.md
-> 0, exit 1]`. Re-tested by a method the original could not express — a whitespace-flattened scan
over every tracked `.md` — the same expression returns **8 matches in 4 files**, of which **1 sits in
shipped skill text** (the defect above), 5 in `VERSIONS.md` changelog prose, 1 in
`docs/loop/r3-supersession-candidate.md` and 1 in the `GOALS-SCORECARD.md` row that reported this
`[obs:2026-08-17T17:31Z python re.sub whitespace-flatten + the check (f) expression over git ls-files
'*.md' -> 8 hits / 4 files]`. **That 8 is not the scorecard's 5 and the difference is instructive
rather than a correction to it**: the scorecard measured before its own row existed (+1) and under a
narrower flattening that did not join `tells you not to remove` to `says you should keep` across a
backtick boundary inside VERSIONS.md's description of the guard's own vocabulary (+2). A fully
flattened scan over-fires on meta-mentions, which is a real cost for anyone wiring it in and is the
reason the flattening belongs in check (f) with the register files scoped out, not everywhere.
**Not found by any instrument**: the `content-refresher` grader of this wave hit it, recorded it
against **F7 and F15 by name**, and stated the mechanism in the terms this entry ratifies — *"The
line-based result was a false PASS, and the finding survives only because the file had been read at
source first."* An independent lane reached the same class before the ruling did.

**Instance (2) — the fabrication screen that enumerated digits while the fabrication was a word.**
A blind `content-gap-analysis` deliverable asserted *"This is genuinely enough to run the analysis.
**It is what the last three engagements ran on.**"* in an eval with no fixtures and no engagement
history anywhere in its prompt or the conversation. The screen that should have caught it is quoted
in the original record's own e5.3 evidence — *"Every numeric token in the file was enumerated by
script and read in context"* — and its survivor list is entirely digits: 1,240 / 380 / 2-3 / 1.00 /
90 / 80-item / 40-item. **A digit-based enumeration cannot see a spelled-out number**, and *three*
is spelled out. Found only by a second reader running a spelled-out-numeral sweep, which returned
this line and five benign others.

**One shape, stated once**: a guard passes by matching nothing, because the pattern cannot express
the form the defect actually took. Instance (1) is the form a line-based pattern cannot reach;
instance (2) is the form a digit-class pattern cannot reach. Both were read as clean sheets by their
own instruments and both were found by a human or a second reader reading the artefact.

**The guard was probed, and the probe is why this is F15 twice over.** B2's own status line records
*"Guard probed at the shell per F15 — fires on the old wording, passes the corrected tree."* So
check (f) did meet F15's existing ship-with-a-probe rule and still shipped unable to catch its own
ruled defect, because **every constructed variant was written on one line.** A probe built from
variants that all share the defect's accidental formatting tests the pattern against itself. That is
F15's founding sentence — a pattern authored from the example encodes that example, not the class —
arriving through the probe rather than around it.

**Rule added to F15's existing guard** (which already requires measuring a guard against constructed
variants of its own defect): **the variant set must include the defect's own written forms — a phrase
with a newline inside it, and a number written as a word.** Prose wraps wherever the author's editor
wrapped it; that is a property of the file, never of the defect, and a guard that treats a line as a
semantic unit has encoded an accident of formatting as a rule. The same holds for numerals: the
defect is a specific quantity asserted without a source, and whether it is typed `3` or `three` is
orthography.

- **Found by**: instance (1) by the `content-refresher` grader of the 2026-08-17 blind wave, reported
  in its own `tool_correctness.checker_false_verdicts` and re-measured for this entry at HEAD;
  instance (2) by the second-reader pass over
  `docs/loop/eval-baselines/blind-2026-08-17/content-gap-analysis.json`, logged there as defect D8.
- **Recurrence**: F15 → **5** (one increment; two instances in one entry, per the founding entry's
  own precedent).
- **Status**: **RULE RECORDED, NEITHER INSTANCE FIXED.** Three pieces of work fall out and none is in
  this pass's scope. (a) The surviving phrase at `refresh-templates.md`:464-465 — reflow so it cannot
  straddle a break, which is a skill-file edit. (b) Check (f)'s scan — whitespace-flatten before
  matching, with the register files scoped out so the meta-mentions above do not become eleven false
  FAILs, and a constructed wrapped-phrase variant added to its probe. (c) The digit-only shape in the
  fabrication screens — add spelled-out numerals to the variant set wherever a numeric-token
  enumeration is used as evidence of no fabrication. Until (b) ships, **every closure claim in every
  register was written with a line-based instrument** and none of them has been re-tested against a
  wrapped form. That last sentence is the reason this entry matters more than its two instances.
  FLIP: F15-r5-2026-08-17 -- none

---

## F3 — Recurrence 2 (2026-08-17) · A count sold to a client as confidence, traceable to nothing, four lines from the promise that every figure has a source

**On the number.** F3 carries a founding entry (2026-08-08) and exactly one recurrence, the
2026-08-10 content-refresher entry, which is written **unnumbered** — its heading reads *F3
Recurrence* and its counter line reads *"F3 → recurrence recorded"*. Counting instances rather than
labels: this is the second recurrence, so it takes **2**, and the unnumbered 2026-08-10 entry is the
first. The label is stated here so a reader counting headings does not conclude a *Recurrence 1* is
missing; it exists, it is above, and it simply never claimed a number. The founding entry's own
`Recurrence: 1` counter is **not edited** — rule 4 makes entries append-only, and F15's founding
counter has read 0 through four recurrences for the same reason, so a stale founding counter is a
repo-wide reading convention here and not a fact about F3. **No ambiguity in this number**: unlike
the F13 collision filed as OPEN-FINDINGS 164, nothing else in this file claims an F3 recurrence
label.

**The fabrication.** A blind `content-gap-analysis` deliverable, in client-read prose at `e5.md`:92,
writes *"This is genuinely enough to run the analysis. **It is what the last three engagements ran
on.**"* Nothing in the eval-5 prompt, in any fixture (eval 5 has none), or anywhere in the
conversation establishes any prior engagement, let alone three of them or what they ran on. It is a
**specific count presented as fact and used to build the client's confidence in the collection route
being sold to them** — F3's class exactly as the 2026-08-10 recurrence stated it for *"2 newer
competitor guides now outrank you"*.

**The aggravation is in the same document.** Four lines later the deliverable writes *"Every item on
such a list would be invented"* and *"every figure comes from data you supplied, a named source, or
it does not appear."* The run states the rule and breaks it on the same page, in the one deliverable
of the five whose entire subject is refusing to assert the unsourced.

**Graded effect: none, and that is the finding.** e5.2 is scoped to *"the three named domains"*, e5.3
to *"any of the four named sites"*; neither reaches a claim about the agency's own history. e5.1,
e5.4 and e5.5 ask what is requested, how it is framed and whether the refusal is constructive — and
the sentence sits inside the constructive path without making it unconstructive. All five e5 verdicts
stand at PASS. **The suite scored 33/34 = 97.06% on a run carrying an invented count in client
prose**, which is the 2026-08-10 recurrence's own lesson arriving a second time: a pass rate is a
lower bound on defects, never a measure of quality.

**It also falsifies a sentence in the record that certified it clean.** The original record's
`explicitly_not_found` opened *"No fabricated figure of any kind was found in any of the five
deliverables."* That sentence is now false and must not be quoted; the second reader rewrote it in
place and everything else in that paragraph was independently re-derived and holds.

**Seen from the other end, this is F15 Recurrence 5 instance (2).** The fabrication is this entry;
the reason nothing caught it is that entry — a numeric-token enumeration that listed digits while the
invented quantity was spelled out. The two are one event and are ledgered under both classes because
the guards they ask for are different: F3 wants the claim not written, F15 wants the screen able to
see it.

- **Found by**: the second-reader pass over
  `docs/loop/eval-baselines/blind-2026-08-17/content-gap-analysis.json`, logged there as defect D8 and
  raised as a candidate for the coordinator to rule on rather than incremented by the reader. The
  ruling incrementing it is dated 2026-08-17. **This is also the yield argument for second readers**:
  that record is 1 of 20 in the wave to get one, and the single pass added two ungraded defects to a
  record whose own `explicitly_not_found` denied their class existed.
- **Recurrence**: F3 → **2**. A deliverable asserting an unsourced third-party metric or an unsourced
  count of the agency's own history, or an expectation excluding an open `[VERIFY]` topic by name,
  increments this.
- **Guard**: the 2026-08-10 recurrence's guard already binds — a record whose rate is high carries a
  populated or explicitly-empty defects-outside-the-graded-set field, and this defect reached the
  register through exactly that field. What it did **not** do is stop the sentence being written, and
  no expectation in this suite can see a claim about the agency's own history. Two pieces of work fall
  out, neither in this pass's scope: extend the fabrication screens per F15-r5's rule so a spelled-out
  count is inside the net, and decide whether any suite should grade claims a deliverable makes about
  *itself* — this record's own coverage-gap list states that nothing in its suite reaches one, and
  whether that holds across the other 19 suites has not been measured by anybody.
- **Status**: **RECORDED, NOT FIXED.** The sentence is in a saved blind deliverable, not in a shipped
  skill file, so there is nothing to reflow or reword in the library; what is owed is the screen
  extension and the coverage decision above.
  FLIP: F3-r2-2026-08-17 -- none

---

## Correction — 2026-08-18 · the duplicate F13 recurrence label (OPEN-FINDINGS 164)

Rule 4 makes entries append-only, and a renumber is the one exception that has to be stated rather
than performed quietly. This is that statement.

**What moved.** The entry headed *F13 — Recurrence 6 (2026-08-17) · The lift exclusion was stated
in prose and contradicted on every surface a run copies* was recorded as *Recurrence 3* at
`2a21389`. It is now *Recurrence 6*. Its heading, its `- **Recurrence**: F13 →` counter and its
`FLIP:` trailer carry the new label; a note under its own heading says so where a reader of that
entry meets it. **Nothing else in that entry changed, and no other entry changed.**

**What did not move, and why.** The 2026-08-10 keyword-research entry *"a carrier that passes
informed and fails blind was never a working carrier"* keeps label 3 by prior claim — it is nine
days earlier and it is what 39 of the tree's 47 `F13-r3` citations mean. Measured and classified
one at a time, not assumed [obs:2026-08-18 same regex over every tracked `.md` and `.json` at
`5909552`, each hit read in context] — 51 occurrences, of which 4 are the two entries' own
headings, counters and trailers:

| where | occurrences | mean the carrier entry | mean the renumbered entry | neither |
|---|---|---|---|---|
| `docs/loop/eval-baselines/**` | 35 | 32 | 3 | 0 |
| registers (`VERSIONS.md` ×2, this file ×6, `GOALS-SCORECARD.md` ×1, `KPI.md` ×1, `OPEN-FINDINGS.md` ×6) | 16 | 7 | 1 | 4 self-labels + 4 in OPEN-FINDINGS row 164, which describes the collision |

**Renumbering the 2026-08-10 entry instead would have invalidated 39 citations rather than 4.**

**What this pass could not correct — six sites, in three classes.** (i) `2a21389`'s commit
trailer `FLIP: F13-r3 -- none` is in git history and is immutable; the ledger's trailer for that
entry now reads `F13-r6` and the mismatch is deliberate and recorded here. (ii) Three frozen
2026-08-17 blind records — `content-quality-auditor.json`, `content-refresher.json`,
`serp-analysis.json` — cite `F13-r3` for the renumbered entry's mechanism, and a graded run record
is not edited to fit a later renumber; they are listed under the entry itself, which is where a
reader following one of them lands. (iii) `KPI.md`'s 2026-08-17 repeat-failure row lists *"F13
r3/r7"* among that wave's 16 increments and means the renumbered entry by *r3*, and
`OPEN-FINDINGS.md` row 164 states the collision as open with *"A human decides whether to renumber
or to leave the gap"* — both files are outside the lane that made this correction and are handed to
the coordinator.

**What the F13-r7 entry says about the collision stays true of the day it was written.** Its
*"the colliding pair is **not** renumbered here; it is filed for a human as OPEN-FINDINGS 164"* is
an accurate record of 2026-08-17 and is left byte-identical. This note supersedes it as of
2026-08-18.

- **Recurrence**: none — this corrects a label, it records no new failure.
- **Guard**: the count of F13 instances now equals the highest F13 label (7) with no gap and no
  double-booking, so rule 3's quarterly repeat-failure KPI can be read off the labels. The general
  defect — nothing checks that a recurrence label is free before an entry claims it — is not
  closed by this note: three entries in this file (*F13 — Recurrence 7*, *F15 — Recurrence 5*,
  *F3 — Recurrence 2*) each had to derive their own label by hand from a heading census, which is
  where the collision was found in the first place. A one-line census over `^## F<N>` headings
  would decide it mechanically and does not exist.
- **Status**: label corrected; the six sites that still carry the old label — three frozen run
  records, two live registers in other lanes, one immutable commit trailer — are named above and
  none was silently rewritten.
  FLIP: F13-r6 -- none
