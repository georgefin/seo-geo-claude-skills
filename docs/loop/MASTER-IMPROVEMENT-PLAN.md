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

### 1a. Guard inventory (Phase 3.1 audit — performed for this proposal, 2026-08-09)

Ledger `FAILURE-LEDGER.md` F1–F12 plus the F13 entry recorded this wave. Classification:
**scripted** (a gate run executes it), **structural** (the format/rule makes the failure
inexpressible), **procedural** (an agent must remember), **residual** (documented why it stays
procedural).

| Entry | Guard today | Class | Disposition |
|---|---|---|---|
| F1 duplicate routines | cron tripwire + quarterly sweep in weekly prompt | procedural | **Residual**: needs the Routines API at runtime; in-repo scripts cannot see the trigger store. Mitigation stands (STEP 5b + read-back rule). |
| F2 tracking sync | `validate-tracking.sh` check (a) + shim leg | scripted | Done. |
| F3 fabrication modeling | no-fab expectation in every eval of all 3 suites | structural | Extends suite-by-suite via Deliverable 2. |
| F4 state-from-call | never-record-without-response rule + Mode A | procedural | **Partial conversion → G5**: claims-gate lexicon (1b) flags state-change verbs in register diffs lacking evidence anchors. Truth stays Mode A. |
| F5 freshness future-dates | filter in `check-freshness.sh` | scripted | Done. |
| F6 egress mirrors | verify-fallbacks-from-runtime rule | procedural | **Residual**: environment-dependent by nature; each lane re-verifies at use. |
| F7 checker false verdicts | evidence-print + raw-inspection mandate (Mode B) | procedural | **Conversion → G5**: fragment-lint — a scripted check that every Mode B fragment expectation carries non-empty printed evidence, and every FAIL quotes raw output. |
| F8 frozen review target | committed-SHA / manifest launch rule | procedural | **Residual**: launch-time practice; the reviewer's open-vs-close scan is the working catch. |
| F9 concept sweeps | check (f) deprecated-token sweep | scripted | Done. |
| F10 prompt archiving | archive-on-write rule | procedural | **Conversion → G5**: check (h) — every trigger row in `PIPELINE.md`'s table must map to an existing `docs/loop/archive/` file; gate FAILs on a missing archive. |
| F11 drafting integrity | mandatory Mode A + OBSERVED/DIAGNOSIS + whole-register re-scan | procedural | **Conversion → G5**: the claims-gate, 1b — the directive's Phase 1.1 headline. |
| F12 pointer anchors | check (g) anchor verification | scripted | Done. |
| F13 note-only content lessons (recorded this wave) | binding-editor lessons must land as skill-rule text or eval expectations in the same wave | structural-by-rule | First application: geo-content-optimizer 4.1.6 placement rule. |

Score: 4 fully scripted + 2 structural today; 4 conversions specced into G5; 3 residuals with
reasons on record. After G5 ships: 8 scripted/structural, 2 procedural-with-scripted-assist
(F4, F11 truth legs), 3 documented residuals.

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
