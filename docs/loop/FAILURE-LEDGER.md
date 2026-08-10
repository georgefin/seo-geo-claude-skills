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
- **Recurrence**: 0 (founding). A new `§6` entry naming a suite, a run label or an occurrence count
  in rule text, or any quoted expectation string appearing on an executor-read surface, increments
  this.
- **Status**: opened; restructure queued behind the in-flight graders, which are reading the file.
  FLIP: F18 -- none
