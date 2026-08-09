# Gated Items — Awaiting Sani's Explicit Approval

Changes that are proposed but MUST NOT be implemented without Sani's recorded "yes".
Lifecycle: `proposed → gated (awaiting verdict) → approved | rejected → applied (PR) →
validated`. Record every verdict here with date and wording. A gated item excluded from a
PR must be named in that PR's body as a separate decision (as done in PR #1, 2026-08-08).

**Currently gated: NONE awaiting Sani — all four items resolved. G1 pilot merged
(PR #4), G2 EXECUTED 2026-08-09 (Issues enabled by Sani; queue issue #6 live; STEP 6
amendment applied — prompt v4.2), G3 RETIRED 2026-08-09 (option c — the local loop
owns WP vuln watching), G4 harvest merged (PR #4).**

> **Verdict log — 2026-08-09 (seventh entry, 09:28Z)**: Sani, verbatim: "#5 merge
> now. Fix Issue #6". Executed as: PR #5 marked ready and MERGED (merge commit
> `676ae74`, 2026-08-09T09:28:09Z) — library v4.3.3 on main: the v4.3.1 verification
> wave, F10 closure, G2 execution, G3 retirement, the W5 + W10-LSA owner-verified
> closures, and the F11/F12 guards (20 commits). Issue #6 repaired in the same pass —
> two real defects found on inspection: the how-to line's angle-bracket placeholder
> was missing from the stored body, a dangling arrow left behind (diagnosed, not
> platform-verified: angle-bracket content eaten by sanitization), and the
> attribution footer was absent despite having been sent in the prior body update
> (drop mechanism not established); both fixed (placeholder rewritten without angle
> brackets, footer re-appended), and the body now notes the register is current on
> main. Post-merge transition per the recorded pattern:
> PR-#5 subscription removed (merge webhook also confirmed), branch restarted from
> main, fresh accumulator PR opened for follow-on work (W2 fold-back, Saturday-fire
> follow-ups, and the still-in-flight W10+F12 Mode A round's findings if any), monitor
> chain re-pointed. First solo weekly fire Sat 2026-08-15 ~04:08Z now reads all of
> this from main — the loop-closure metric's designed test.
>
> **Verdict log — 2026-08-09 (sixth entry, ~08:10Z)**: G3 resolved by evidence. After
> the coordinator's guide mapped the recorded fact question to its pre-approved
> branches, Sani answered by pasting their canonical local `STANDING-LOOPS.md`
> registry (R168) in-session. Its row 3 — "WP plugin-update + vuln check" — shows the
> loop ALIVE and registry-driven per that paste: cadence Weekly (Mon/overdue), fired
> by the Learn Protocol Step 6 hook ("NOT machine-local cron" per the paste), state file
> `RESUME_PROMPTS/web-tasks/site-health/WP-WEEKLY-UPDATE-STATE.md`, runbook
> `protocols/site-health-audit-process.md` point 4b, `last_run: 31-07-2026 PARTIAL
> (authenticated lane ran on 3 of 6…)` — and the registry's own convention #1 keeps a
> PARTIAL run due until a full pass rewrites a bare date; log destinations include a
> `wp-vulnerability-monitor` Step 4 report. Per the pre-approved map ("yes → option
> (c) retire"), executed as: the v1 cloud CVE-advisory feed retired DELIBERATELY —
> the concern is owned local-side. Residual delta + reopen path recorded in the G3
> status block. No trigger changes; register-only close-out.
>
> **Verdict log — 2026-08-09 (fifth entry, ~07:50Z)**: Sani enabled GitHub Issues on
> the fork and confirmed verbatim: "Done" (answering the coordinator's how-to for
> G2's last blocker). Executed as the G2 completion pass: the rolling [VERIFY]-queue
> issue created — #6, label `verify-queue` (the create itself was the truthful probe;
> first non-410 write after three 410s across 08-08→09) — then ONE `update_trigger`
> STEP 6 amendment on the weekly routine against the pinned v4.1 baseline → prompt
> v4.2 (+1,324 chars across exactly 3 lines, word-diff-proven surgical; cron
> `0 4 * * 6`, next_run 2026-08-15T04:08Z, push+email notifications all unchanged in
> the response's stored-object echo — an independent `list_triggers` re-read was
> denied by tool permissions this call, noted). v4.2 archived per F10. G2 lifecycle:
> approved → applied; validation leg = the 2026-08-15 fire files the first report
> issue and next week's DETECT confirms it.
>
> **Verdict log — 2026-08-08 (fourth entry, ~21:51Z)**: Sani, mid-session, verbatim:
> "merge PR #4" — the merge gate on the gate-execution release. Executed as: PR #4
> marked ready and MERGED (merge commit `db7ebd5`, 21:51Z) — library v4.3.0 on main
> (G1 pilot + all seven G4 harvest ports + F8/F9 guards). Post-merge: the PR-#4
> subscription and check-in trigger were removed, the working branch restarted from
> main, and a fresh accumulator PR opened for the remaining work. The G1 rollback
> watch is now LIVE (ClawHub / skills.sh listings). Still open: G2 (waiting on the
> Issues toggle), G3 (waiting on the WP-loop fact answer). Weekly routine's first
> solo fire: Saturday 2026-08-15 ~04:08Z (it was created after the 08-08 slot passed).
>
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
  Pilot executed and MERGED (PR #4, `db7ebd5`); W8 resolved — see Pilot result below.
- **Proposal**: The current spec diverges from this repo's own rules:
  - agentskills.io/specification.md (checked 2026-08-08): SKILL.md frontmatter defines
    **no top-level `version` field** (6 fields only) — repo mandates it (`CLAUDE.md:46`,
    `CONTRIBUTING.md:40`).
  - code.claude.com/docs/en/skills plugin docs (fetched 2026-08-08): documented plugin.json
    schema has **no `schemaVersion`/`id`** (only `name` required), and `commands`/`skills`
    are documented as path strings/arrays, not `{name, description, path}` objects — repo
    mandates the opposite (`CLAUDE.md:47`; fields present at `.claude-plugin/plugin.json:2-3`;
    added deliberately in v3.0.0, `VERSIONS.md:149` ("### v3.0.0" section —
    pointer anchor-tagged per F12, token authoritative on mismatch; had silently
    drifted from :79-88)).
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
  root-CLAUDE.md packaging. Rollback triggers: first post-merge check 2026-08-09 =
  **CLEAR**, and the marketplace leg is structurally DEAD — both marketplaces index the
  upstream namespace only (ClawHub: vendored openclaw/skills snapshots, bundle v9.9.5;
  skills.sh: `aaron-he-zhu/...` path, 20 skills / 60.4K installs baseline; "georgefin"
  zero hits on either; both sites [BLOCKED-EGRESS] from cloud, snippet-verified).
  Effective rollback signals: strict-validator errors + next weekly's contradiction
  check; revert = `git revert 6c10295`.

## G2 — Publish weekly reports as GitHub Issues on the fork

- **Status**: **EXECUTED 2026-08-09 ~07:51Z** (fifth verdict-log entry). History: 410
  on issue-create 2026-08-08, re-verified twice 2026-08-09 (the fully prepared
  queue-issue create drew the same 410); F10 second prerequisite (v4.1 prompt pinning)
  discovered and satisfied same day via the trigger-store recovery. Sani enabled
  Issues and confirmed "Done" → queue issue **#6** created on first attempt (label
  `verify-queue` — the create doubled as the probe), then the STEP 6 amendment applied
  as ONE `update_trigger` against the pinned v4.1 baseline → **prompt v4.2**, archived
  at `docs/loop/archive/v4.2-weekly-prompt-2026-08-09.txt` (F10). Three surgical
  touches only (mission-line clarifier, STEP 6 issue-archive block, closing-line
  addendum; +1,324 chars, word-diff-proven). Read-back: the update response's
  stored-object echo shows all three edits live with cron/next-run/notifications
  unchanged. Remaining validation leg: the 2026-08-15 fire files the first
  `weekly-report` issue; next week's DETECT verifies (loop-closure).
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

- **Status**: **RESOLVED 2026-08-09 — option (c) RETIRE** (sixth verdict-log entry).
  History: Sani requested the explanation 2026-08-08 ("4. Please explain"), delivered
  same day; the recorded fact question — does the local WP vuln loop still run and
  cover the 5 production sites? yes → (c) retire; no/unsure → (b) Monday routine —
  was answered 2026-08-09 by Sani's pasted canonical `STANDING-LOOPS.md`: row 3 is a
  live, registry-driven weekly loop with a `wp-vulnerability-monitor` report among
  its log destinations (its own scope counts 6 targets where v1 named 5 WP sites —
  the paste does not enumerate them; coverage of the five rests on Sani answering
  the recorded coverage question with this registry; `last_run: 31-07-2026 PARTIAL`,
  still-due by the registry's PARTIAL convention until the pass completes). The v1
  cloud advisory feed is therefore retired deliberately. **Residual delta, recorded**:
  the v1 lane's external advisory-watch angle (Patchstack/Wordfence CVE feeds,
  WP-core/WooCommerce/Rank Math version watch, fake-mu-plugin campaign chatter) is
  covered only to the extent the local runbook includes it — ownership of that angle
  now rests wholly with the local loop. **Reopen path**: one `create_trigger` Monday
  routine reconstructed from the archived v1 lane
  (`docs/loop/archive/v1-weekly-prompt-2026-07-18.txt`, STEP 1 area 5) + F10 archive
  — nothing was lost.
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
- **Verdict**: option (c) RETIRE — resolved 2026-08-09 by Sani's pasted
  `STANDING-LOOPS.md` registry (sixth verdict-log entry above).

## G4 — Upstream reconciliation (aaron-marketing-skills v19.1.0)

- **Status**: **DECIDED by Sani 2026-08-08: HARVEST** ("5. harvest"). Topology stays 20;
  quarterly upstream lane; no parasite port; NDJSON deferred. All seven harvest ports
  applied and MERGED (PR #4, `db7ebd5`).
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
- **Scripted settled-pointer check — SHIPPED 2026-08-09** (was PROMOTED same day,
  F12 recurrence 1): `validate-tracking.sh` check (g) live — parses the
  anchor-tagged `` `VERSIONS.md:<line>` ("<token>") `` pointers in the four live
  registers and fails the gate on any token mismatch (FAILURE-LEDGER.md, archive/,
  eval-baselines/ excluded by design — the append-only ledger legitimately quotes
  historical pointer examples). Fault-injection-tested like (a)/(f), with a
  negative control verified load-bearing at implementation. First live gate run
  the same day caught all six pointers shifted by the v4.3.5 changelog insertion
  and BLOCKED the push until the register re-anchor commit — detection AND
  prevention. The F12 drafting-sequence rule (final-tree grep, registers last)
  remains standing discipline.
- **Weekly-prompt v4.3 wording backlog** (Mode A advisories, 2026-08-09,
  verdict-neutral): disambiguate STEP 6's "first filing verified 2026-08-09" (it means
  the first successful issue WRITE — queue issue #6 — not the first weekly-report
  filing, which lands 2026-08-15); reconcile "sole permitted write" with the retained
  Gmail-DRAFT clause (a draft is arguably a write; fired sessions lack Gmail anyway).
  Bundle into the NEXT prompt amendment (one `update_trigger`, F10 archive) — never a
  solo respin.
- **rank-tracker reference gap** (flagged by the H1 harvest implementer,
  2026-08-08) — **APPLIED 2026-08-09** (4.1.1, this wave), trim-to-what-exists
  resolution: the SKILL.md blockquote and Reference Materials bullet now promise
  only sections tracking-setup-guide.md actually contains, and the guide's
  Section 6 dangling "Root Cause Taxonomy" pointer is dropped; nothing was
  written into the reference (F3 rule — no invented taxonomies/benchmarks). The
  bullet's "SERP feature tracking setup" phrase was a SECOND same-class instance,
  found by the implementer at the scope boundary and fixed in-wave as a declared
  coordinator extension (the guide covers SERP features only as a pitfalls row
  and reporting-cadence lines, not a setup section).
- **Benchmark polish pair** (reviewer advisories, 2026-08-08, verdict-neutral): (a)
  core-eeat-benchmark scoring-table N/A row could state that rubric-granted
  conditionality (currently T04 only) is the sole rubric-level N/A source, foreclosing
  at-will N/A readings; (b) content-quality-auditor's emergency-brake veto table lists
  no Partial state (by design — full pass handles it) — one clarifying line would stop
  the question recurring. Bundle with the next framework touch.
- **NEW — shared-framework consistency pass** (surfaced 2026-08-08 by the schema
  reconciliation + auditor labels agents): `references/core-eeat-benchmark.md` Section 5
  (≈ lines 216-226) still teaches the pre-clarification multi-type mapping ("Article,
  Breadcrumb | FAQ, HowTo") — skill text currently states "where they differ, R2
  governs", but the benchmark needs its own scoped pass; bundle the `<`-vs-`≤` CWV
  boundary phrasing nuance (R4 uses ≤; several references use `<`) into the same pass.
  Shared framework files — small, deliberate, own wave.
- **NEW — fork-manifest attribution (Sani decision, flagged 2026-08-09)**: both
  marketplace manifests' `owner`/`metadata.repository` fields and `VERSIONS.md:3`'s
  raw-fetch URL still carry the upstream identity (aaron-he-zhu) — fork
  inheritance, surfaced when the marketplace-discovery shim landed. No functional
  impact on installs (probed: local path-add + install succeed with the
  upstream-attributed manifests). Whether to re-attribute the fork's outward-facing
  identity (and which fields) is Sani's call — outward-facing publication class,
  never a coordinator default.
