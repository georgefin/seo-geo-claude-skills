# Gated Items — Awaiting Sani's Explicit Approval

Changes that are proposed but MUST NOT be implemented without Sani's recorded "yes".
Lifecycle: `proposed → gated (awaiting verdict) → approved | rejected → applied (PR) →
validated`. Record every verdict here with date and wording. A gated item excluded from a
PR must be named in that PR's body as a separate decision (as done in PR #1, 2026-08-08).

**Currently gated: 1 item awaiting Sani (G3 — explanation requested, fact question open).
G1 approved (pilot executing), G2 approved (implemented), G4 decided (harvest).**

> **Verdict log — 2026-08-08 (third entry, ~19:30Z)**: against the numbered five-item
> recommendation sheet (1 merge PR #3 · 2 G1 pilot · 3 G2 Issues · 4 G3 explain · 5 G4
> harvest), Sani replied verbatim: "1. merge 2. Yes 3. Yes 4. Please explain 5. harvest".
> Executed as: PR #3 MERGED (`e2d7e22`, merge commit); **G1 APPROVED** — one-skill pilot
> per the recorded plan; **G2 APPROVED** — weekly routine STEP 6 gains the single
> issue-filing write action + rolling [VERIFY]-queue issue; **G3 still open** —
> explanation delivered, waiting on Sani's one fact (does the local WP vuln loop still
> cover the 5 production sites?); **G4 DECIDED: HARVEST** — keep the 20-skill topology,
> port features only (O2); upstream tracked as a quarterly harvest lane, not weekly
> (O1); no parasite/borrowed-authority port (O4, per the recommendation Sani adopted);
> NDJSON entity registry deferred until a client engagement needs it (O5). The 7-item
> harvest wave moves to APPLY.
>
> **Verdict log — 2026-08-08 (second entry, ~16:00Z)**: Sani: "1. Merge 2. … proceed with
> the best skills agents for the pending tasks … Do not stop until everything is done
> without my help." Executed as: PR #2 MERGED (merge commit `04a980a`); then the parked
> work waves proceeded — P3 Greek depth (inflection, tourism/seasonality,
> BestPrice/Shopping, el-GR SERP census, e-shop compliance, YMYL credentials), P4
> remainder (all-20 catalog strip, anti-slop ruleset, evidence/confidence labels,
> keyword-research trigger-boundary + 4 ambiguities), the schema R2/R3 reconciliation
> (R2 boundary clarified in SETTLED-RULINGS first), and the eval-suite v2 wording wave
> with re-baseline. This instruction does NOT decide G1, G2, G3, or G4: those are
> decision gates whose content is a choice only Sani can make (spec pilot yes/no; public
> Issues yes/no; WP/CVE restore-vs-relocate-vs-retire; upstream track-vs-independent) —
> a general "proceed with tasks" cannot answer them, so all four remain gated below.
>
> **Verdict log — 2026-08-08**: Sani approved the assessment's measurement package and
> loop upgrades ("assign team to proceed with the best skills agents for the pending
> tasks … upgrade this recurring loop … to the top quality level, by adding missing
> elements") — applied as: eval-suite pilot on 3 skills, `skill-reviewer` +
> `greek-content-editor` roster additions, VALIDATE behavioral leg, loop-KPIs, baseline/
> W1 corrections, surgical craft fixes (geo worked example, rank-tracker contract), and
> the P2 upstream investigation (G4). This approval does NOT cover G1, G2, or G3 — each
> still needs its own explicit verdict. Also still parked awaiting a go: the Greek depth
> wave (P3: inflection, tourism, BestPrice/Shopping, SERP census, compliance, YMYL
> credentials) and the all-20 catalog-block strip (P4 remainder).

---

## G1 — Align SKILL.md frontmatter + plugin.json with current Agent Skills spec ("#8")

- **Status**: **APPROVED by Sani 2026-08-08** ("2. Yes" on the recommendation sheet).
  Pilot executing per the plan below; W8 validator question resolves inside the pilot.
- **Proposal**: The current spec diverges from this repo's own rules:
  - agentskills.io/specification.md (checked 2026-08-08): SKILL.md frontmatter defines
    **no top-level `version` field** (6 fields only) — repo mandates it (`CLAUDE.md:46`,
    `CONTRIBUTING.md:40`).
  - code.claude.com/docs/en/skills plugin docs (fetched 2026-08-08): documented plugin.json
    schema has **no `schemaVersion`/`id`** (only `name` required), and `commands`/`skills`
    are documented as path strings/arrays, not `{name, description, path}` objects — repo
    mandates the opposite (`CLAUDE.md:47`; fields present at `.claude-plugin/plugin.json:2-3`;
    added deliberately in v3.0.0, `VERSIONS.md:79-88`).
  - Sketch if approved: fold `version` into `metadata` (keep `metadata.version`), trim
    non-spec plugin.json fields, run `claude plugin validate --strict` (watch-item W8).
- **Risk**: could break ClawHub / skills.sh marketplace listings (their tolerance of the
  spec-pure format is unproven); contradicts the repo's published contribution contract,
  so `CLAUDE.md:46-47` + the `CONTRIBUTING.md` template must change in the same PR.
- **Plan**: pilot on **one** skill first; single commit so **rollback = one `git revert`**.
- **Rollback triggers**: validator errors post-merge; marketplace listing breakage; CI red;
  contradiction reported by the next weekly run.
- **Verdict**: APPROVED 2026-08-08 ("2. Yes") — see the third verdict-log entry.
- **Pilot result (2026-08-08, commit `6c10295`)**: executed and SHIP-verdicted after
  scope separation (Mode A; 6/6 gate fault-injections caught). memory-management is the
  one spec-aligned skill (metadata.version authority); plugin.json carries no
  schemaVersion/id; official validator confirms a strict warning-reduction with zero
  new findings. W8 RESOLVED. **Remaining full-migration scope — a NEW decision for
  Sani, not covered by this approval**: flatten `commands` entries, re-shape
  `hooks`/`mcpServers` to validator-accepted forms, decide the `capabilities` field and
  root-CLAUDE.md packaging. Rollback triggers stay armed: watch ClawHub/skills.sh
  listings after merge; revert = `git revert 6c10295`.

## G2 — Publish weekly reports as GitHub Issues on the fork

- **Status**: **APPROVED by Sani 2026-08-08** ("3. Yes") — implementation **BLOCKED on a
  repo setting**: GitHub returned `410 Issues has been disabled in this repository` on
  the first issue-create. Sani must enable Issues (repo → Settings → General → Features
  → check "Issues"); then the coordinator creates the rolling [VERIFY]-queue issue and
  amends the weekly routine's STEP 6 in one pass. Holding the trigger amendment until
  then so the routine never ships a half-working step.
- **Proposal**: amend the weekly routine (STEP 6) to allow exactly one write action: file
  each report as an issue titled `Weekly skill-update-check — YYYY-MM-DD` (label
  `weekly-report`), plus maintain one rolling `[VERIFY] queue` issue (label `verify-queue`)
  mirroring `WATCH-ITEMS.md` as a checklist where Sani posts local-verification verdicts
  (AREX, myDATA) for the next APPLY session to fold back into the file. Filing issues
  violates neither the no-edit nor the no-push rule; every report gets a permalink and the
  archive gap closes (today a report survives only in the Routines UI + notifications).
- **Risk**: the fork is PUBLIC — reports become world-readable. They contain market
  research and pipeline process, no client data, and PR #1 already exposes equivalent
  content; still, this is *recurring outward-facing publication*, hence gated.
- **Rollback**: remove the STEP 6 instruction (one `update_trigger`); close the issues.
- **Verdict**: APPROVED 2026-08-08 ("3. Yes") — see the third verdict-log entry.

## G3 — WordPress/CVE security lane: restore, relocate, or retire

- **Status**: GATED — Sani requested the explanation 2026-08-08 ("4. Please explain");
  delivered same day. Open fact question: does the local WP vuln loop still run and
  cover the 5 production sites? yes → option (c) retire; no/unsure → option (b) Monday
  routine (team recommendation).
- **Context**: the superseded v1 weekly carried a WordPress + security lane (WP
  core/WooCommerce/Rank Math version watch; ACTIVE plugin CVEs from Patchstack/Wordfence
  with CVE IDs, affected ranges, fixed-in versions; fake-mu-plugin backdoor patterns)
  whose output section explicitly fed "the weekly WP vuln loop" — apparently a loop on
  Sani's local side covering 5 production WP sites. The current weekly dropped this lane,
  so retiring v1 silently kills that feed. The skills library has no WP-security skill:
  this is an ops feed, not library research — which is exactly why it needs an owner
  decision rather than a coordinator default.
- **Options**: (a) restore as lane 8 of the weekly (one `update_trigger`); (b) a separate
  weekly routine on its own schedule (e.g. Monday, matching patch-Tuesday-adjacent
  advisories); (c) confirm the local loop covers it independently → retire the feed
  deliberately.
- **Risk of inaction**: 5 production sites lose a CVE early-warning feed without anyone
  having decided that.
- **Verdict**: _none yet_.

## G4 — Upstream reconciliation (aaron-marketing-skills v19.1.0)

- **Status**: **DECIDED by Sani 2026-08-08: HARVEST** ("5. harvest"). Topology stays 20;
  quarterly upstream lane; no parasite port; NDJSON deferred. Harvest wave in APPLY.
- **Facts established** (raw-file inspection, accessed 2026-08-08): ancestor frozen at
  v9.9.12 "receives no updates"; successor bundle v19.1.0 (2026-08-01, hot cadence — 5
  major versions since 2026-06-28). 20→16 = 3 pairwise merges (writer+refresher,
  meta-tags+schema→serp-markup-builder, reporter+alerts→performance-monitor) + 2 moves
  to a protocol layer (entity split, memory) + 1 new skill (page-play-builder:
  programmatic/comparison/local/parasite modes); **nothing dropped**. Their "8 auditor
  gates" = hybrid scored+categorical verdicts (SHIP / FIX / BLOCK / UNDECIDED; one veto
  caps score at 59; two vetoes = BLOCK with no score; missing evidence = no score). Their
  "protocol layer" = append-only operational NDJSON registries (entity/offer/consent…) —
  NOT research-truth governance; **our docs/loop/ has no upstream equivalent**. CITE
  unchanged upstream; CORE-EEAT identical structure with REFINED veto wording (R10
  material-contradiction not broken-links; T04 conditional N/A). **Zero Greek content
  anywhere in their line** (second language axis: Chinese) — wholesale topology adoption
  would orphan all 6 of our Greek modules. They recommend llms.txt (skill-file evidence
  only — ruling R1 STANDS, not a supersession). Their plugin.json: no `schemaVersion`,
  bare path strings → supporting evidence for G1's trim direction.
- **Top harvest candidates** (full 11-item list in the 2026-08-08 investigation report):
  gate verdict typing (S), veto wording refinements (S, [VERIFY source-repo version]),
  AI Overview recovery playbook (M), ai-referrals analytics mode (M), AI-citation-loss
  alert threshold (S), striking-distance GSC mining (S), AI-crawler stance templates (S).
- **Questions only Sani can answer**: O1 track upstream as a recurring harvest lane vs
  declare independent lineage (tracking has real weekly cost); O2 keep 20-skill topology
  and harvest features only (recommended by the conflict scan) vs converge to 16 with a
  Greek re-port; O4 whether the parasite/borrowed-authority play is brand-acceptable
  before any port; O5 whether an NDJSON entity-registry pattern is wanted for client ops.
- **Verdict**: HARVEST — recorded in the 2026-08-08 third verdict-log entry above.

---

## Queued slow-loop proposals (NOT yet gated — listed for continuity)

From the 08-08-2026 report's slow-loop lane; promote to gated only when concretized:

- **PAST-Bench-style eval for the loop** — partially realized 2026-08-08: skill-level
  eval suites (VALIDATE leg ii) + quarterly loop-KPIs (PIPELINE hygiene §8). Remaining
  ambition: benchmark the pipeline's own improvement run-over-run (PAST-Bench: arXiv
  2608.04003).
- **Institutionalized [VERIFY] queue** — implemented by this `docs/loop/` structure;
  becomes real when this directory merges.
- **Ruling-vs-body reconciliation inside schema-markup-generator** — **APPLIED
  2026-08-08** (4.1.0, this wave): R2 boundary first clarified in SETTLED-RULINGS
  (precision, not reversal), then body + all three references aligned; FAQ rich-result
  guidance purged per R3. Residue queued separately below (core-eeat-benchmark §5).
- **keyword-research trigger-boundary contradiction** — **APPLIED 2026-08-08** (4.2.0,
  this wave): body sections aligned with the description boundary; explicit handoff to
  competitor-analysis with payload.
- **keyword-research execution ambiguities (a)–(d)** — **APPLIED 2026-08-08** (4.2.0,
  this wave): single-turn default with stated assumptions; example-report GEO table
  fixed to the metrics-columns + explained-N/A resolution; Step-4 expansion stated
  universal incl. tool-export arrivals; Greeklish reply-language rule encoded.
- **Eval-suite v2 wording refinements** — **APPLIED 2026-08-08** (commit `cb47ac8`):
  all 14 items as 17 in-place rewords, counts/structure byte-identical elsewhere;
  re-baselining map preserved (changed indices: schema e1.9/e2.9/e3.7/e4.4/e4.5/e4.8/
  e5.9; keyword e1.5/e2.6/e3.3/e4.1/e4.5/e5.2; geo e2.2/e3.1/e3.7/e5.4); Mode B
  re-baseline runs follow in the same wave.
- **Eval-suite v3 wording backlog** (from the v2 Mode B graders + focused rerun,
  2026-08-08): 11 minor items recorded in `docs/loop/eval-baselines/2026-08-08-v2.json`
  `eval_feedback_v3_backlog` fields (Z-designator, placeholder prose scope, threshold-
  reference exemptions, e1.5 anywhere→above alignment, 150-word count start, etc.).
  Same one-wave rule: apply together, never piecemeal, re-baselining the touched items.
- **NEW — shared-framework consistency pass** (surfaced 2026-08-08 by the schema
  reconciliation + auditor labels agents): `references/core-eeat-benchmark.md` Section 5
  (≈ lines 216-226) still teaches the pre-clarification multi-type mapping ("Article,
  Breadcrumb | FAQ, HowTo") — skill text currently states "where they differ, R2
  governs", but the benchmark needs its own scoped pass; bundle the `<`-vs-`≤` CWV
  boundary phrasing nuance (R4 uses ≤; several references use `<`) into the same pass.
  Shared framework files — small, deliberate, own wave.
