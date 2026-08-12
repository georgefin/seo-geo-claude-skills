# Master Improvement Plan — Gated Proposal (2026-08-09)

**Provenance**: Sani's Master Improvement Directive, received in-session 2026-08-09 (verdict-log
entry 10 in `GATED-ITEMS.md` carries the timestamp and decision reading). The directive's
REQUIRED RESPONSE is this document: (1) architectural script specs for the remaining unscripted
guards and the coordinator (F11) checks, (2) an evaluation roadmap to 20/20 behavioral suites,
(3) a real-site pilot execution plan.

**Status**: PROPOSED. Execution is gated per item as **G5–G8** in `GATED-ITEMS.md`; each releases
only on Sani's explicit recorded words (per the standing gate rule — a general "proceed" never
decides a gate). Two directive items are not gated because they are already true or already
standing work — see §4. This file is not yet listed in `CLAUDE.md`'s loop-state index; it earns
that listing if and when its gates release and it becomes standing state.

---

## 0. Baseline and honest constraints

Ratings this plan starts from (given to Sani 2026-08-09, unchanged): team structure 7/10,
skills 6.5/10, loops 8/10 design vs ~6.5 proven. The single largest gap: **zero real-site
outcome data** — every quality claim so far is process-internal (evals, reviews, gates), not
market-verified. Deliverable 3 exists to close exactly that.

Constraints this plan will not pretend away:

1. **Scripts enforce form, not truth.** A gate can force every live-state claim to carry an
   evidence anchor and can sweep registers after a status flip; it cannot verify the evidence
   supports the claim. Truth-checking stays with the mandatory Mode A review — the scripted
   layer removes the *forgot-to-re-scan* failure mode, which is what actually recurred
   (F11 r4 and r5 were both missed re-scans, not fabrications).
2. **Cross-model here means Claude-family tiers only.** This environment can run subagents on
   different Claude tiers (contrastive second lane, §1c); it has no access to non-Anthropic
   models. A true cross-family check requires a small manual step by Sani (§1c, Protocol B).
3. **SEO outcomes are slow.** First directional signal 4–6 weeks, decision-grade ~12 weeks.
   AI-citation visibility can move in days-to-weeks and is tracked separately for that reason.
4. **A null pilot result is a finding, not a failure to bury.** Success criteria are
   pre-registered before deployment (§3) precisely so the result cannot be curve-fit afterward.

---

## 1. Deliverable 1 — Architectural script specs (Phases 1.1, 1.2, 3.1)

### 1a. Guard inventory (Phase 3.1 audit — **re-audited 2026-08-12 against the tree**, F1–F20)

> **Why this table was rewritten.** The 2026-08-09 version classified F1–F13 and scored
> "4 fully scripted". Two things have since made that reading wrong. (1) Seven more ledger
> entries landed (F14–F20) and were never inventoried. (2) The four-class vocabulary cannot
> express the state most of this repo's guards are actually in: **a script exists and
> nothing runs it.** `fragment-lint.sh`, `check-trigger-archives.sh`,
> `expectation-carrier-check.sh`, `eval-corpus-report.sh` and `reanchor-pointers.sh` are all
> present in `scripts/`, and none is invoked by `pre-push-gate.sh`, by the one
> `.claude/settings.json` hook (`git-push-guard.sh`), or named in `PIPELINE.md` — which
> names exactly four scripts, and all four are the gate itself, two of its own legs, or the
> advisory freshness tool
> [obs:2026-08-12 `grep -oE 'scripts/[a-z-]+\.(sh|py)' docs/loop/PIPELINE.md | sort -u | wc -l` = 4].
> Under the old vocabulary each of the five reads as **scripted / Done**. A guard nobody runs
> is procedural with extra steps, and calling it scripted is how a 7/10 gets reported as a 10.

Classification used below:

- **gated** — a leg of `pre-push-gate.sh` (or a check inside one) executes it on every push.
  This is the only class that stops a defect without anyone remembering to act.
- **scripted-unwired** — a script implements it; no gate, hook or pipeline step calls it.
- **advisory** — it runs and reports but cannot fail anything (`check-freshness.sh` ends in
  `exit 0` unconditionally, `check-freshness.sh:63`).
- **structural** — the format or rule makes the failure inexpressible.
- **procedural** — an agent must remember.
- **residual** — procedural *with a stated reason it cannot be scripted*. A residual with a
  reason is an answer; a residual without one is the gap this workstream exists to close.

| Entry | Guard today (and what runs it) | Class | Disposition, 2026-08-12 |
|---|---|---|---|
| F1 duplicate routines | cron tripwire + quarterly sweep in the weekly prompt | residual | **Unchanged and correct.** Cannot be scripted here: the trigger store is an external runtime service reachable only through the Routines API; no in-repo script has a handle to it, so a repo gate cannot see a duplicate trigger at all. Mitigation stands (STEP 5b + read-back). |
| F2 tracking sync | `validate-tracking.sh` check (a) + shim leg — **pre-push check 2** | gated | Done, and still the cleanest conversion in the table. |
| F3 fabrication modeling | no-fab expectation in every suite **+** `validate-tracking.sh` check (h), the unsourced quotation-attribution sweep — **pre-push check 2** | structural + gated | **Downgraded from "structural / Done".** F3 Recurrence (2026-08-10) shipped an unlabelled third-party ranking claim on a run that scored 100%, so the expectation leg is demonstrably not sufficient alone. Check (h) is the scripted backstop added since; the expectation leg still extends suite-by-suite via Deliverable 2. |
| F4 state-from-call | never-record-without-response rule + Mode A + claims-gate rule 1 — **pre-push check 4** | gated (form) + procedural (truth) | As specced. The gate forces an anchor onto a state-change verb; it never asked whether the anchor was true. `obs-anchor-check.py` now closes part of that for anchors that quote a command (below). |
| F5 freshness future-dates | future-date filter in `check-freshness.sh` **+** claims-gate rule 3 (timestamp sanity) — **pre-push check 4** | advisory + gated | **Corrected from "scripted / Done".** `check-freshness.sh` is advisory by design and always exits 0, so the filter cannot fail a push; what actually enforces the class today is claims-gate rule 3 on the register diff. Both legs are real; only one can stop anything. |
| F6 egress mirrors | verify-fallbacks-from-runtime rule | residual | **Unchanged and correct.** Cannot be scripted: reachability is a property of the runtime the *next* session gets, not of the repo. A committed script cannot testify about a network it will not be on. Each lane re-verifies at use, and the register records the verification (`GATED-ITEMS.md:43`, `PILOT.md:80`). |
| F7 checker false verdicts | `fragment-lint.sh` — **written, called by nothing** | scripted-unwired | **Regression against the 2026-08-09 plan, which specced this as a G5 conversion.** The script shipped; the wiring did not. Owed: one leg in `pre-push-gate.sh`, or an explicit ruling that it is an operator tool. Until then the guard is the Mode B raw-inspection mandate, i.e. procedural. |
| F8 frozen review target | committed-SHA / manifest launch rule **+** `register-lock.sh gate-check` — **pre-push check 6** | gated (registers) + residual (skill files) | **Partially converted since 2026-08-09.** The lock journal models write tenure for `docs/loop/*.md` + `VERSIONS.md`, so a collision on those is now caught by machine. It stays residual for skill files because the repo has no representation of "a review is in flight over this path" — `.register-locks` models file tenure, not review tenure. F14-r1 names extending that model as the shape of the fix, so this is a *specified* residual, not an open-ended one. |
| F9 concept sweeps | `validate-tracking.sh` check (f) `DEPRECATED_TOKENS` + the `R3_TOKENS`/`R3_LEGAL` context-scoped pair — **pre-push check 2** | gated + **procedural row-mandate** | **Downgraded from "Done". F9 has recurred five times, most recently 2026-08-12.** The sweep works; what fails is the *mandate* that every retirement gets a row — r5's root cause was that no row was added and the script was untouched across the whole range. **Conversion specified, and per r5's own guard it may not be called impossible without a demonstrated collision:** a `RETIRE:` commit trailer on the `FLIP:` precedent (`claims-gate.sh` rule 2 already parses trailers), FAILing when a commit declaring a retirement adds no token row in the same diff. |
| F10 prompt archiving | `check-trigger-archives.sh` — **written, called by nothing** | scripted-unwired | **The 2026-08-09 row is factually wrong about where this landed.** It says the conversion is "check (h)"; check (h) in `validate-tracking.sh:613` is the **F3** attribution sweep. "archive" occurs exactly once in that whole script, at `:435`, and it is an exclusion comment, not a check [obs:2026-08-12 `grep -c archive scripts/validate-tracking.sh` = 1]. F10's check exists as a standalone unwired script instead. Owed: wire it, or correct the claim. |
| F11 drafting integrity | `claims-gate.sh` rules 1–3 — **pre-push check 4** | gated (form) + procedural (truth) | Shipped as specced, and the gate's own header states the boundary: it "enforces FORM, not truth" (`claims-gate.sh:8-10`). The truth leg produced the sharpest failure of this session — see F20. |
| F12 pointer anchors | `validate-tracking.sh` check (g) — **pre-push check 2**; `reanchor-pointers.sh` is an unwired helper | gated | Done. The check is gated; only the convenience refresher is unwired, which is the correct division. |
| F13 note-only content lessons | rule: a binding-editor lesson lands as skill-rule text or an eval expectation in the same wave; `expectation-carrier-check.sh` — **written, called by nothing** | procedural + scripted-unwired | **Downgraded from "structural-by-rule". F13 has recurred five times** (r5, 2026-08-11: an expectation rewarded the fabrication its own suite was ledgered for). A rule that has been breached five times is not making the failure inexpressible; it is being remembered, or not. The one script aimed at it is unwired. |
| F14 `git add -A` scope | `commit-scope-check.sh` — **pre-push check 5**; `register-lock.sh gate-check` — **pre-push check 6** | gated (one axis) + **open gap (the other)** | **New row.** Gated for the founding axis: a commit carrying files from a skill its subject does not name. F14-r1 establishes the guard is blind to the other axis — a directory add sweeping another agent's unfinished file *inside a named skill* — and that "no amount of tightening the subject-matching would catch it", because the file is in declared scope. Fix shape is named in the ledger (extend `.register-locks` tenure to agent file scopes); not built. |
| F15 patterns that match nothing | `anti-slop-ruleset.md` §6 governing note + the ship-with-a-probe rule | procedural | **New row. Conversion is specifiable and should not be left procedural:** every §6 family row is a table cell, so a script can require a recorded hit rate ("n of m constructed variants") on every family and FAIL a family shipped without one. That is a text-shape check on a known table, not a semantic judgement. F15-r1 (a ban and its context 45 lines apart) is a *detector-window* problem and is why every new detector in this repo now prints its own scope — `check-template-fences.py` and `obs-anchor-check.py` both do. |
| F16 record weaker than the claim | rule: no rate quoted before its record is committed under `eval-baselines/`; `eval-corpus-report.sh` — **written, called by nothing** (referenced only in `.claude/agents/skill-reviewer.md:135`) | procedural + scripted-unwired | **New row.** Leg (a), record durability, is mechanisable and half-built: the script recomputes from committed records, so the missing piece is a gate leg, not an algorithm. Leg (b), a pooled figure presented as a method effect without a pairing check, is **residual** — deciding whether two groups are comparable is a judgement about study design, and no token match reaches it. |
| F17 ruling with no shipped carrier | rule: a `CLAUDE.md` ruling names its carrier *in the ruling* ("Carrier: `<path>` §n") | procedural | **New row. Cheaply scriptable and it should be built:** every standing-ruling block in `CLAUDE.md` must contain a `Carrier:` line whose path exists on disk. Pure text + filesystem, no semantics. The adjacent case — an eval expectation grading a rule no shipped skill states — already has `expectation-carrier-check.sh`, unwired. The entry's `[VERIFY]` amplifier (whether an installed session loads the plugin's root `CLAUDE.md` at all) stays unprobed and is Sani-side. |
| F18 provenance is a hint | rule: provenance and rule have different audiences and should not share a required-read file | procedural | **New row. One leg is mechanical and worth building:** every expectation string in each `evals/*.json` can be substring-matched against the blind-run required-read set, FAILing on a verbatim leak — that is exactly how `:265` was found (a verbatim `domain-authority-auditor` expectation sitting in the ruleset). The weaker leg — a citation that *identifies a suite* without quoting it — needs a suite-name lexicon and will carry false positives; ship the verbatim leg first and measure. |
| F19 abstention overshoot | rule: a refusal to state a figure checks `SETTLED-RULINGS.md` first | residual | **New row.** The checkable half (a refusal phrase appears in a deliverable) is trivial and near-worthless: most refusals are correct, so it would fire constantly. The half that matters — whether a settled ruling answers *this particular* refusal — is a semantic join between a hedge and a register entry, and nothing in a token match reaches it. Stated as a residual **with** its reason, and the reason is the join, not the detection. |
| F20 commit message false about its own diff | none automated — the ledger says so outright ("neither is automated yet, and that gap is on record rather than closed") | procedural → **partially converted 2026-08-12** | **New row, and the sharpest one.** Its founding wave produced three instances, and it was breached *inside its own founding commit*: `ceddc85` shipped "31 rows / 8 in D" under an anchor whose own quoted command returns 32. `scripts/obs-anchor-check.py` (below) closes the durable-artefact half of this class. The commit-message half is the same machinery pointed at a different surface — parse the message's backticked commands, re-run them against the **post**-commit tree — and is specified, not built. The "names the surviving neighbours it checked" leg for removal claims stays procedural: it asserts what the author looked at, which leaves no trace to check. |

**Score, counted rather than characterised.** Twenty entries, and each figure below is the
length of a list printed in this table — the first draft of this paragraph said "8" over a
list of nine and "4 residuals" over a list of five, which is the F20 class committed inside
the F20 audit.

- **9 of 20 entries carry at least one gate-wired leg**: F2 · F3 (check h) · F4 (form) ·
  F5 (claims-gate rule 3) · F8 (registers only) · F9 (check f) · F11 · F12 · F14 (one axis).
  Those nine are delivered by **four distinct scripts** — `validate-tracking.sh`,
  `claims-gate.sh`, `commit-scope-check.sh`, `register-lock.sh` — sitting in pre-push checks
  2, 4, 5 and 6. Three of the nine ride the same script, so nine entries do not mean nine
  independent guards.
- **6 scripts exist and nothing calls them**: `fragment-lint.sh` (F7) ·
  `check-trigger-archives.sh` (F10) · `expectation-carrier-check.sh` (F13) ·
  `eval-corpus-report.sh` (F16) · `reanchor-pointers.sh` (F12 helper, correctly unwired) ·
  `obs-anchor-check.py` (F20, new this wave). Mine is in this list, not the gated one.
- **1 advisory-only**: `check-freshness.sh` (F5), unconditional `exit 0`.
- **5 residuals, each with its reason in the row**: F1 (external trigger store) · F6
  (runtime-dependent) · F8 skill-file axis (no review-tenure model) · F16 leg (b)
  (study-design judgement) · F19 (semantic join between a hedge and a register).
- **6 procedural entries whose conversion is now specified rather than wished for**: F9's
  `RETIRE:` row-mandate · F14's named-skill axis · F15's probe-rate column · F17's `Carrier:`
  line · F18's verbatim-leak match · F20's commit-message leg.

The honest reading: the gap to 10 is **not** mostly "we have not thought of a guard". Of the
six unwired scripts, one is a helper that should stay unwired and one landed this wave, so
**four are wiring debt against guards the plan already counted as converted** — F7, F10, F13,
F16 — and six more entries have a concrete, buildable specification in the rows above.
**Wiring, not invention, is the binding constraint**, which is a different and much cheaper
problem than the 2026-08-09 table implied. It is also the one the 7/10 rating is measuring:
every one of those four was reported as done.

### 1a-bis. `scripts/obs-anchor-check.py` — the anchor-truth leg (added 2026-08-12)

`claims-gate.sh` forces a live-state claim to carry an `[obs:…]` anchor and says of itself
that it "enforces FORM, not truth" (`claims-gate.sh:8-10`). Where an anchor's content is a
runnable command *and its asserted output*, that truth leg is machine-dischargeable, and
leaving it to a reviewer is what let `ceddc85` ship a false anchor into `OPEN-FINDINGS.md`.
**A false `[obs:]` anchor is worse than an unanchored claim, because it retires the reader's
obligation to check.**

- **What it checks**: `docs/loop/*.md` (top level) + `VERSIONS.md`; every `[obs:…]` anchor;
  every backticked command in one followed by `= <int>` or `= <int> in <file.md>`. It re-runs
  the command and compares stdout. `--at <rev>` runs against a revision materialised
  read-only by `git archive`, which is what separates "the anchor was false when written"
  from "the register moved on since".
- **What it provably cannot check**: everything else, reported per-claim with a reason code
  and never folded into the pass count. Measured on the register set at the immutable commit
  `95ba7d6` — deliberately a SHA and not "today", because this very edit adds claims to the
  corpus and a live count would go stale inside its own paragraph — the split was **4
  checkable claims against 31 uncheckable across 30 anchors in 11 files**
  [obs:2026-08-12 `scripts/obs-anchor-check.py --at 95ba7d6`, SPLIT line]. The corpus is
  overwhelmingly prose observation and every run says so. Deeper: it verifies a number still
  reproduces, never that the number supports the sentence built on it. "32 rows" reproducing
  says nothing about whether "8 in D" was ever true.
- **Safety**: anchor text is untrusted input — a register is a file an attacker can write to.
  No shell, ever; pipelines are split quote-aware and chained as argv lists; every stage head
  must be in a read-only whitelist; unquoted shell metacharacters or unexpanded globs refuse
  the claim outright. The acceptance suite proves four side-effect sentinels are never
  created.
- **R297**: `scripts/obs-anchor-selftest.sh`, 15 cases. The primary RED is not synthetic — it
  replays `ceddc85` and must report `asserted 31 / observed 32`. Unreachable history FAILs the
  suite rather than skipping it.
- **Owed**: gate wiring. It is deliberately not added to `pre-push-gate.sh` here — that file
  is another workstream's territory this wave. Recommended leg: `--at HEAD --min-checkable 4`,
  the floor being what the register set meets today, so a collapse in the checkable population
  fails instead of passing silently.

### 1b. The F11 claims-gate — `scripts/claims-gate.sh`, wired into the pre-push gate (G5)

Scope: the diff of register files (`docs/loop/*.md`) and `VERSIONS.md` at gate time. PR bodies
and GitHub comments are outside a repo gate's reach — those stay under the drafting checklist +
Mode A (limitation on record).

- **Rule 1 — anchored claims.** Added/modified lines matching a risk lexicon must carry, on the
  line or in adjacent context: an `[obs:<ISO-timestamp> <evidence-token>]` anchor, a quoted
  command-output fence, or a "historical as of <timestamp>" marker. Two tiers: a narrow
  hard-FAIL lexicon built from the five recorded F11 instances (`end-to-end`, `works`, `live`,
  `blocked`, `succeed(s)`, `remains`, `until this … merges`) and a WARN tier for the broader
  frame (`verified`, `probe-verified`, `confirmed`, `in flight`, `awaiting`, `currently`),
  tightened weekly as false-positive data accumulates. An allowlist file holds stable phrases;
  every FAIL prints the offending line (house evidence-print rule).
- **Rule 2 — flip-manifest sweep.** Any diff that changes a `Status:`/`Verdict:` field or
  appends a verdict-log entry requires a `FLIP:` trailer in the commit message naming the
  flipped entity and its touched-claim tokens; the script greps the WHOLE register set for
  those tokens and FAILs on hits lacking a post-flip timestamp or historical marker. This is
  F11-r5's whole-register re-scan, executed by machine instead of memory.
- **Rule 3 — timestamp sanity.** ISO timestamps in added register lines must not postdate the
  clock at gate time; `~HH:MMZ` approximations inside verdict-log entries FAIL outright
  (the F11-founding forward-approximation class).
- **Acceptance test (required before the check counts as live, per the F2/F9/(g) precedent):**
  the five recorded F11 instances reconstructed as fault-injection fixtures; the gate must
  catch 5/5, and a clean-tree negative control must pass.

Also in G5: **check (h)** (F10 archive presence), **fragment-lint** (F7), and
**`docs/loop/KPI.md`** — an append-only table the weekly routine writes one cold row per fire:
date · regression rate · repeat-failure count · tool-correctness rate · evals passed/total ·
findings caught pre-push vs post-push · notes (uneditorialized). This is Phase 3.2's KPI
persistence; trends read quarterly.

Effort: one wave (scripts + fixtures + gate wiring + PIPELINE/VALIDATE doc rows).

### 1c. Adversarial Sanity Layer (Phase 1.2 → G6)

**High-stakes output, defined**: (i) any commit that flips a gate/verdict/register status,
(ii) release commits, (iii) Sani-facing deliverables carrying numbers or capability claims,
(iv) skill rules encoding external-world claims.

- **Protocol A — available now.** Every high-stakes item gets a second review lane on a
  *different Claude tier* (subagent model override) under a **contrastive charter**: the
  reviewer is instructed to assume the primary conclusion is wrong and construct the strongest
  disproof from the same evidence. Disagreement = finding; agreement after genuine contest =
  raised confidence — explicitly *not* proof, since both reviewers share a model family and can
  share blind spots. Cost: roughly doubles review tokens on the ~10–15% of commits that qualify.
- **Protocol B — needs Sani, 5 minutes monthly.** The only true cross-family check available:
  Sani pastes one high-stakes deliverable per month into a non-Anthropic model using the
  contrastive charter prompt (template ships with G6) and returns the output to the loop as a
  finding source. Catches correlated blind spots no in-family arrangement can see.
- G6 deliverables: charter templates in `.claude/` tasking docs, the high-stakes definition in
  `PIPELINE.md`, Protocol B's paste-ready prompt for Sani.

---

## 2. Deliverable 2 — Evaluation roadmap: 3/20 → 20/20 (Phase 2.1 → G7)

Today: geo-content-optimizer (29 expectations), schema-markup-generator (44), keyword-research
(31) — 104 expectations, fixtures, no-fab guard in every eval, zero-data honesty evals,
Mode B baselining in `docs/loop/eval-baselines/`, binding Greek-editor pass on Greek outputs.
That house pattern is the template; every new suite follows it (5 evals, ~25–30 expectations,
≥1 Greek eval wherever the skill produces prose).

| Wave | Skills | Rationale |
|---|---|---|
| E1 | content-quality-auditor · on-page-seo-auditor · seo-content-writer · meta-tags-optimizer | Score authorities first — every other skill's quality claims route through CORE-EEAT scoring, so **eval the scorer**: grading-consistency fixtures, veto handling (T04 conditionality, C01, R10), N/A discipline, score-cap math. |
| E2 | serp-analysis · competitor-analysis · content-gap-analysis | Research phase complete (keyword-research done). Fixture-driven; no-fab probes on competitor claims (the v2 boundary-trap pattern generalizes). |
| E3 | technical-seo-checker · internal-linking-optimizer · content-refresher · domain-authority-auditor | CITE scorer gets the eval-the-scorer pattern; technical checks get fixture sites with known defects. |
| E4 | rank-tracker · backlink-analyzer · performance-reporter · alert-manager | Report/process skills: eval report structure honesty, threshold math, no invented metrics, honest-gap behavior (the 4.1.1 trim lessons become expectations). |
| E5 | entity-optimizer · memory-management + one cross-skill handoff eval | The handoff eval tests the `CLAUDE.md` inter-skill contract end to end (dimension scores passed and consumed correctly). |

Definition of done per skill: suite committed · first Mode B baseline recorded · zero-regression
protection extended to it · VERSIONS bump + 5-file sync. Realistic cadence: one wave per week
alongside the weekly loop → **20/20 in ~5 weeks**; compressible with dedicated directed waves.
Every suite lands through the standard gate: implementer → Mode A diff review → Mode B first
run → Greek editor where applicable.

---

## 3. Deliverable 3 — Real-site pilot execution plan (Phase 4.1 → G8)

The directive authorizes scoping now; **deployment additionally needs three Sani inputs** —
(1) the named target, (2) data access, (3) per-change publication approval. Nothing publishes
autonomously at any point in this plan.

- **Target (Sani picks)**: one property — a section of a Sani Hellas site or one consenting
  client site — ideally a 5–15 page service/content cluster with existing traffic (enough
  signal) that is not the revenue-critical core (bounded risk).
- **Design**: matched-pair where the cluster allows — optimize half (treatment), hold
  comparable pages (control) over the same window; before/after single-cluster if too small.
  Controls exist because Greek tourism/services seasonality (W9) would otherwise masquerade as
  treatment effect.
- **Baseline, week 0–1**: full library audit of the cluster (on-page, technical, CORE-EEAT and
  CITE scores recorded as the process baseline); a fixed keyword set of 10–30 queries
  *including Greek inflected-form pairs* — this makes the pilot double as W10's open
  inflection-leg verification; rank capture for the set; 12-week traffic lookback (GSC/GA4);
  **AI-citation baseline**: a written sampling protocol — fixed query set × engines (Google AI
  Mode/AIO, ChatGPT, Perplexity), weekly, recording cited/linked domains. Honest note: with no
  engine APIs available here, sampling is manual (Sani-side browser or an agreed export);
  the written protocol is what makes it reproducible either way.
- **Data access (Sani, any mix)**: GSC + GA4 via export files into the pilot dir, or
  connectors. As of drafting, the session's ahrefs/similarweb (and hubspot/notion/slack/
  amplitude) MCP servers are unauthenticated and OAuth cannot run in this non-interactive
  session — authorization happens in Sani's claude.ai connector settings (or `/mcp` in an
  interactive session). CSV exports are a full substitute if connectors stay closed.
- **Deployment, week 1–2**: content produced by the library's own skills; every page must pass
  CORE-EEAT at the agreed threshold + the binding Greek editor (EL pages) + **Sani's explicit
  approval before publication** (the HITL gate). Byte-exact pre-change copies stored for
  one-command rollback. Content-only edits; no technical-infrastructure changes without Sani's
  webmaster.
- **Measurement**: checkpoints at weeks 2/4/8/12. Three metrics, pre-registered success/null
  criteria BEFORE deployment (e.g. median rank delta vs control, GSC clicks/impressions delta,
  AI-citation appearance rate for the query set). Core-update confound watch stays on the
  Search Status Dashboard discipline; seasonality noted at each checkpoint.
- **Artifacts**: `docs/loop/PILOT.md` — protocol, pre-registered criteria, append-only
  measurement rows; pilot content and pre-change copies in a dedicated dir.
- **Phase 4.2 HITL cadence**: quarterly cold review — Sani (or a designated expert) picks
  sample deliverables blind, reviews cold, findings feed `FAILURE-LEDGER.md` and the eval
  backlog. First one ~2026-11. On approval, a quarterly Routine reminder gets armed so the
  cadence cannot silently lapse.

---

## 4. Phase-to-gate mapping

| Directive item | Gate | State |
|---|---|---|
| 1.1 F11 claims-gate + 3.1 vigilance-to-code (checks h, fragment-lint, KPI.md) | **G5** | Specced (§1a–1b); agent-doable on release, one wave |
| 1.2 Adversarial Sanity Layer | **G6** | Specced (§1c); agent-doable on release; Protocol B needs Sani's 5-min monthly step |
| 2.1 Eval expansion E1–E5 | **G7** | Specced (§2); ~5 weekly waves on release |
| 4.1 Real-site pilot | **G8** | Scoped (§3); execution blocked on Sani's three inputs, then wave-by-wave with HITL |
| 2.2 Watch-item verification | *no gate* | Standing loop work — audit in §5; agent lanes run at the next sweeps, Sani-side items already tracked |
| 3.2 Solo Saturday + KPI trends | *no gate* | Already armed: weekly routine v4.2, first solo fire 2026-08-15 ~04:08Z (trigger store read via `list_triggers`, 2026-08-09). KPI persistence file ships with G5 |
| 4.2 Quarterly HITL | rides **G8** | Cadence + reminder Routine armed on approval |

**Release rule**: each of G5–G8 releases individually on Sani's explicit words naming the item
(e.g. "release G5" / "approve the eval roadmap"). Order recommendation if approved together:
G5 → G6 in one wave, G7 as the standing weekly cadence, G8 as soon as its three inputs land —
the pilot's 12-week clock is the longest pole and starts latest.

---

## 5. Watch-item verification audit (Phase 2.2 — performed for this proposal)

All open items already carry the register's standing bounding rule — "directional guidance,
never fact; never client-facing as fact" — so the directive's re-classification requirement is
satisfied by construction; what remains per item is the verification action:

| Item | Open leg | Next action | Owner |
|---|---|---|---|
| W2 AADE myDATA dates | both dates | hard re-check vs aade.gr before 2026-09-01 | **Sani** (tracked, issue #6) |
| W3 ~11% overlap / ≈40% UGC share | magnitudes only | replication-study lane at next quarterly sweep | agent lane |
| W4 multilingual semantic collapse | whole claim | engine-primary/study lane, quarterly | agent lane |
| W6 Skroutz cluster (8 claims) | all 8 | help.skroutz.gr lane where egress allows; fees/SLA/returns need seller-panel reads | agent lane + **Sani** |
| W7 AIO quote-preview | el-GR rollout scope | first el-GR sighting or quarterly re-check | **Sani** sighting / agent lane |
| W9 Greek commerce magnitudes | 4 vendor figures | quarterly with W6; replaced only by primary/first-party data | agent lane |
| W10 inflection leg | SERP-distinctness magnitude | **folds into the pilot's keyword set** (§3) | pilot (G8) |
| W11 registry mechanics (7 claims) | lookup mechanics | on-use at first YMYL/e-shop build — possibly the pilot | on-use |

Summary: two Sani-blocked, four agent-lane at scheduled sweeps, two on-use/pilot-folded.
No item needs emergency verification: none is currently load-bearing for a client deliverable.
