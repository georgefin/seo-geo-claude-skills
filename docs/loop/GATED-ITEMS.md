# Gated Items — Awaiting Sani's Explicit Approval

Changes that are proposed but MUST NOT be implemented without Sani's recorded "yes".
Lifecycle: `proposed → gated (awaiting verdict) → approved | rejected → applied (PR) →
validated`. Record every verdict here with date and wording. A gated item excluded from a
PR must be named in that PR's body as a separate decision (as done in PR #1, 2026-08-08).

**Currently gated: 3 items.**

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

---

## Queued slow-loop proposals (NOT yet gated — listed for continuity)

From the 08-08-2026 report's slow-loop lane; promote to gated only when concretized:

- **PAST-Bench-style eval for the loop** — benchmark the pipeline's own improvement
  (PAST-Bench: arXiv 2608.04003, found 2026-08-08).
- **Institutionalized [VERIFY] queue** — implemented by this `docs/loop/` structure;
  becomes real when this directory merges.
