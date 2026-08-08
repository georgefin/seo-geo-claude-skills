# Gated Items — Awaiting Sani's Explicit Approval

Changes that are proposed but MUST NOT be implemented without Sani's recorded "yes".
Lifecycle: `proposed → gated (awaiting verdict) → approved | rejected → applied (PR) →
validated`. Record every verdict here with date and wording. A gated item excluded from a
PR must be named in that PR's body as a separate decision (as done in PR #1, 2026-08-08).

**Currently gated: 3 items awaiting verdict (G1–G3) + 1 under investigation (G4).**

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

- **Status**: GATED — awaiting Sani's verdict (requested for Mon 2026-08-10 in the
  08-08-2026 weekly report's 7-day plan). Deliberately excluded from PR #1.
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
- **Verdict**: _none yet_.

## G2 — Publish weekly reports as GitHub Issues on the fork

- **Status**: GATED — proposed 2026-08-08 (loop audit). Awaiting Sani's yes/no.
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
- **Verdict**: _none yet_.

## G3 — WordPress/CVE security lane: restore, relocate, or retire

- **Status**: GATED — surfaced by the 2026-08-08 loop audit (v1→v2 prompt diff). Awaiting
  Sani's decision.
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

- **Status**: INVESTIGATED 2026-08-08 (read-only P2) — awaiting Sani's verdict.
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
- **Verdict**: _none yet_.

---

## Queued slow-loop proposals (NOT yet gated — listed for continuity)

From the 08-08-2026 report's slow-loop lane; promote to gated only when concretized:

- **PAST-Bench-style eval for the loop** — partially realized 2026-08-08: skill-level
  eval suites (VALIDATE leg ii) + quarterly loop-KPIs (PIPELINE hygiene §8). Remaining
  ambition: benchmark the pipeline's own improvement run-over-run (PAST-Bench: arXiv
  2608.04003).
- **Institutionalized [VERIFY] queue** — implemented by this `docs/loop/` structure;
  becomes real when this directory merges.
- **Ruling-vs-body reconciliation inside schema-markup-generator** (surfaced by eval
  authoring, 2026-08-08): the skill's own step 2 / O05 mapping table / decision-tree
  reference still teach multi-type output, and `references/schema-decision-tree.md` +
  `references/validation-guide.md` still carry pre-retirement FAQ rich-result guidance —
  tension with rulings R2/R3. Needs a careful pass (R2 targets citation-lever stacking,
  not every legitimate multi-schema page — e.g. Article+Breadcrumb is Google-documented),
  so the reconciliation must define R2's precise boundary, then align body, references,
  and the new eval expectations together. Not a quick fix; own small APPLY wave.
- **keyword-research trigger-boundary contradiction** (surfaced by eval authoring,
  2026-08-08): the body's "How to Use → Competitive Research" and "Advanced Usage →
  Competitor Gap" sections invite exactly the prompts the description routes to
  competitor-analysis. Align body sections with the description boundary (or add an
  explicit handoff note). Small; bundle with the P4 remainder.
