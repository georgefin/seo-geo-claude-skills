# Gated Items — Awaiting Sani's Explicit Approval

Changes that are proposed but MUST NOT be implemented without Sani's recorded "yes".
Lifecycle: `proposed → gated (awaiting verdict) → approved | rejected → applied (PR) →
validated`. Record every verdict here with date and wording. A gated item excluded from a
PR must be named in that PR's body as a separate decision (as done in PR #1, 2026-08-08).

**Gated as of 2026-08-10: G8 deployment to a real property only (gated on Sani's
three inputs — named target cluster, data access, publication workflow; per-input
status in `PILOT.md` §0.1, where inputs 1 and 2 carry partial words recorded
2026-08-10 and input 3 has none). G5–G7 and G8's executable scope RELEASED
2026-08-09 (eleventh verdict-log entry): G5 delivered and wired into
`pre-push-gate.sh` (integration commit, 2026-08-09), G6 delivered (`69c5f7e`),
G7 in execution (E1–E4 suites committed; E1–E3 reviews returned with fixes
applied), G8 preparables delivered (`9c6adb4`). The fork-manifest attribution
question was DELEGATED back to the coordinator 2026-08-10 (twelfth verdict-log
entry); the queued list records what was chosen.
G1–G4 resolved: G1 pilot merged (PR #4) + continuation merged (PR #8), G2 EXECUTED
2026-08-09 (Issues enabled by Sani; queue issue #6 live; STEP 6 amendment applied —
prompt v4.2), G3 RETIRED 2026-08-09 (option c — the local loop owns WP vuln
watching), G4 harvest merged (PR #4).**

> **Verdict log — 2026-08-11 (thirteenth entry)**: Sani answered four drafted questions by
> explicit selection. **Decisions, one per question (recorded)**:
> (1) **PR #9 — CONDITIONAL MERGE AUTHORIZED.** Sani selected "Merge after checks pass",
> whose drafted text reads: *"I run the verification tests and a second independent review.
> If both come back clean, I merge it — keeping the full history… If anything fails, I fix it
> and don't merge."* **This supersedes the twelfth entry's "not an order to merge" reading**,
> and the supersession is deliberate rather than inferred: the alternative option "Verify but
> don't merge — leave the merge for you to trigger" was drafted, offered alongside it, and not
> chosen. Sani delegated the trigger knowingly. **The condition is strict and is NOT met as of
> this entry**: the second Mode A pass returned **BLOCK** (F11 recurrence + F9 recurrence 4,
> both in the coordinator's own G9 commit). No merge. The blind re-runs are still in flight and
> Mode A must re-run against the repairs before the condition can be read as satisfied. A
> partial pass is not a pass.
> (2) **G9 — SPLIT VERDICT**: 9a accepted and applied, 9b held pending an owner read. See G9's
> Status line above.
> (3) **G8 input 1 — ADVANCED**, verbatim in `PILOT.md` §0.1: property named
> (`www.sanihellas.gr`), cluster rule given (every NOBO and ATLANTIC page), seed keyword
> `θερμοπομποί`. The URL list itself is still not supplied and the coordinator does not infer
> it. **New blocker recorded the same day**: the environment's egress proxy refuses the
> property, the shared Dropbox folder and `developers.google.com`
> [obs:2026-08-11T03:40:00Z curl + WebFetch, both refused at the gateway]. Sani selected
> "Unblock the site" — an environment allowlist change, his to make, with four other hosts
> named in `PILOT.md` §0.1 for the same pass.
> (4) **Pilot control-page design — DEFERRED by Sani** to "decide once I see the page list",
> which is the correct order: the matched-pair split cannot be proposed before the cluster is
> enumerable, and the cluster is not enumerable until (3) clears.
>
> **Verdict log — 2026-08-10 (twelfth entry, logged 03:18:04Z clock-read)**: Sani, in
> one message, four clauses, verbatim: "I'll follow your suggestion and My suggestion:
> the natural merge point is when the current waves finish and all 20 skills have
> evaluated suites." / "I pick the nobo and Atlantic real pages on a Sani Hellas site
> as a start." / "With your guidance I will authorize the analytics connectors in my
> claude.ai settings." / "3. Fork-manifest attribution: Team choose the best, latest
> and most effective practice". **Decision readings, one per clause (recorded)**:
> (1) **PR #9 merge point AGREED — not an order to merge.** Sani adopts the
> coordinator's proposed timing (waves finished + 20/20 suites carrying evaluated
> suites). The standing rule that only Sani's explicit word merges PR #9 is NOT
> relaxed by an agreed condition: a condition whose satisfaction the coordinator
> itself judges would be self-authorization by the back door. Herbert reports
> "condition met" when it is, and asks for the one-word order then.
> (2) **G8 input 1 — PART-SUPPLIED**, recorded verbatim in `PILOT.md` §0.1 with the
> URL-list gap named; the coordinator does not infer the page list.
> (3) **G8 input 2 — IN PROGRESS**, recorded in §0.1 together with the finding that
> none of this repo's six declared MCP servers is a Google Search Console or GA4
> server, so the export path stays the primary measurement route and connector auth
> complements it on the SEO-tool lanes.
> (4) **Fork-manifest attribution — DELEGATED to the coordinator.** "Team choose the
> best…practice" hands back a decision previously held for Sani precisely because it
> is outward-facing publication class. Herbert takes it under that delegation, records
> the chosen practice and its reasoning in the queued list below, and keeps the change
> to a single revertible commit so Sani can overturn it on sight.
>
> **Verdict log — 2026-08-09 (eleventh entry, logged 16:13:33Z clock-read)**: Sani,
> verbatim: "Herbert did you assign the am to execute in the best possible manner,
> following the best possible practice phase 1, phase 2, phase 3, phase 4?" ("the am"
> read as "the team"). **Decision reading (recorded)**: taken together with the
> directive's own imperative ("Please execute the following Master Improvement
> Directive") and the two same-day "Proceed" messages, this is execute-language
> naming all four phases — recorded as the RELEASE of **G5, G6, G7**, and of **G8's
> executable scope** (pilot protocol, pre-registration templates, sampling protocol,
> KPI persistence). G8's live-site deployment stays blocked on its three FACTUAL
> prerequisites — named target cluster, data access, publication workflow with
> per-change HITL approval — inputs only Sani can supply per the plan's own design
> (and the directive's own Phase 4.2), not a coordinator-imposed gate. **Execution
> order (best practice, recorded)**: the in-flight wave close-out completes first
> (it IS the F13 validation leg); then G5+G6 in one wave — the guard layer ships
> before the volume work so every subsequent wave runs under scripted protection
> (the directive's own "no manual vigilance" principle applied to the rollout
> itself); then G7 eval waves E1→E5; G8 preparables alongside. Staged rather than
> all-at-once fleet launch also bounds the risk demonstrated the same day: the
> weekly API limit froze the entire team 12:20→16:00Z mid-wave.
>
> **Verdict log — 2026-08-09 (tenth entry, logged 12:18:14Z clock-read)**: Sani's
> **Master Improvement Directive** arrived mid-turn (after the 12:05:23Z clock read,
> during the Greek-editor-FAIL fix wave). Verbatim anchors: "Please execute the
> following Master Improvement Directive"; targets "Team Structure (7→10), Skills
> (6.5→10), and Loops (6.5→10)"; Phase 1.1 "Neutralize Coordinator Drafting Risk
> (F11) … No manual vigilance allowed"; Phase 2.1 "Expand Behavioral Evals (3/20 →
> 20/20)"; Phase 3.1 "Any guard currently relying on human or agent vigilance must
> immediately be refactored into a scripted, automated check (like checks f and g)";
> Phase 3.2 "Allow the weekly loop to run fully autonomous ('solo') starting this
> Saturday"; Phase 4.1 "Formally authorize and scope the real-world pilot on a live
> target (e.g., Sani Hellas property)"; closing "REQUIRED RESPONSE & DELIVERABLES:
> Herbert, please respond with a Gated Proposal breaking this down into actionable
> implementation phases" naming three artifacts (script specs, eval roadmap, pilot
> plan). **Decision reading (recorded for Mode A contest)**: the message's own
> REQUIRED RESPONSE clause governs the "execute" verb — the deliverable of this turn
> is the Gated Proposal, delivered as `MASTER-IMPROVEMENT-PLAN.md` with G5–G8
> registered below; each releases only on Sani's explicit per-item words. Two items
> decide now: Phase 3.2 confirms the ALREADY-ARMED solo state (weekly v4.2, first
> solo fire 2026-08-15 ~04:08Z — no trigger change needed or made); Phase 4.1
> authorizes pilot SCOPING (plan §3) — deployment additionally waits on the three
> Sani inputs named there plus per-change HITL approval, which is the directive's
> own Phase 4.2 requirement. Phase 2.2 (watch-item verification) is standing loop
> work, audited in plan §5, not gated. Same-turn context: the directive's
> vigilance-to-code thesis had its first live instance minutes earlier — the binding
> Greek-editor pass returned FAIL on the geo eval-2 output (v2's note-only lesson
> recurred) and the fix landed structurally as geo-content-optimizer 4.1.6 + ledger
> F13.
>
> **Verdict log — 2026-08-09 (ninth entry, ~10:47Z)**: Sani, verbatim: "Merge" —
> answering the coordinator's "PR #8 is the single remaining gate" message.
> Executed as: PR #8 marked ready and MERGED (merge commit `3f22f23`, read from
> the merge response) — library v4.4.0 on main (G1 continuation manifest
> migration + the covering-round fixes through `3738317`). Post-merge transition
> per the pattern: subscription removed (merge webhook concurred), babysit
> one-shot deleted, branch restarted from main. END STATE OBSERVED 10:47Z, full
> remote flow against merged main from this container: `claude plugin
> marketplace add georgefin/seo-geo-claude-skills` → "Successfully added";
> `claude plugin install seo-geo-claude-skills@seo-geo-claude-skills` →
> "Successfully installed"; `claude plugin list` → "Version: 4.4.0 · Scope:
> user · Status: √ enabled"; probe state cleaned up after. The two-command
> install flow the eighth-entry goal required is LIVE on main — per-machine
> adoption is now Sani-side (runbook delivered in-session; each machine's
> `claude plugin list` output is its verification artifact).
>
> **Verdict log — 2026-08-09 (eighth entry, ~10:24Z)**: Sani, verbatim: "1. merge
> PR #7 to main / 2. I want all machines to have the exact same plugins and skills
> and loops installed". Executed #1 as: PR #7 marked ready and MERGED (merge
> commit `8f8b03e`, read from the merge response) — library v4.3.5 on main: the
> v4.3.4 fix-forward wave, the v4.3.5 pending-tasks wave (rank-tracker 4.1.1,
> check (g), marketplace-discovery shim), and the same-day F11-r3 correction.
> Post-merge transition per the pattern: PR-#7 subscription removed (merge
> webhook also confirmed), stale babysit one-shot deleted, branch restarted from
> main (force-with-lease over merged-history only). #2 recorded as the
> **G1-CONTINUATION APPROVAL**: the numbered reply answers the coordinator's
> two-decision message ((a) merge PR #7; (b) G1 continuation yes/no), and its #2
> states the goal whose only recorded path is that continuation — installs
> probe-blocked the same morning on the W8 manifest shapes (evidence in the G1
> block below). Scope as recorded in the pilot-result block: flatten `commands`,
> re-shape `hooks`/`mcpServers` to validator-accepted forms, minimal
> `capabilities`/packaging calls; CLAUDE.md + CONTRIBUTING.md contract lines
> change in the same wave; single-commit revert. The "loops" clause needs no
> per-machine install: the Routines fire in cloud sessions on the account (as
> observed all week — no machine involved), and `docs/loop/` rides with the repo
> clone.
>
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
  Pilot executed and MERGED (PR #4, `db7ebd5`); W8 resolved — see Pilot result
  below; continuation APPROVED + EXECUTED + MERGED 2026-08-09 (PR #8, `3f22f23`;
  v4.4.0 on main — see Continuation notes below).
- **Proposal**: The current spec diverges from this repo's own rules:
  - agentskills.io/specification.md (checked 2026-08-08): SKILL.md frontmatter defines
    **no top-level `version` field** (6 fields only) — repo mandates it (`CLAUDE.md:58`,
    `CONTRIBUTING.md:40`).
  - code.claude.com/docs/en/skills plugin docs (fetched 2026-08-08): documented plugin.json
    schema has **no `schemaVersion`/`id`** (only `name` required), and `commands`/`skills`
    are documented as path strings/arrays, not `{name, description, path}` objects — repo
    mandates the opposite (`CLAUDE.md:59`; fields present at `.claude-plugin/plugin.json:2-3`;
    added deliberately in v3.0.0, `VERSIONS.md:263` ("### v3.0.0" section —
    pointer anchor-tagged per F12, token authoritative on mismatch; had silently
    drifted from :79-88; refreshed 2026-08-10, +2 from the entity-optimizer 4.1.5 /
    backlink-analyzer 4.0.4 bullet)).
  - Sketch if approved: fold `version` into `metadata` (keep `metadata.version`), trim
    non-spec plugin.json fields, run `claude plugin validate --strict` (watch-item W8).
- **Risk**: could break ClawHub / skills.sh marketplace listings (their tolerance of the
  spec-pure format is unproven); contradicts the repo's published contribution contract,
  so `CLAUDE.md:58-59` + the `CONTRIBUTING.md` template must change in the same PR.
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
  (2026-08-09 second re-check, dedicated lane: baseline HOLDS at snippet grade —
  v9.9.5 and the 60.4K figure re-surfaced (snippet grade cannot distinguish
  unchanged from cached), georgefin still zero hits in 5 scoped queries
  (search-absence, not platform proof), no fork-indexing signal; additive at
  snippet grade: a second DEPRECATED ClawHub bundle listing v8.0.1 [VERIFY], a
  third upstream-keyed directory claudepluginhub.com, and a noise guard — the
  unrelated `resciencelab/opc-skills/seo-geo` skill on skills.sh is not this
  library.)
  Effective rollback signals: strict-validator errors + next weekly's contradiction
  check; revert = `git revert 6c10295`.
- **Continuation APPROVED 2026-08-09** (eighth verdict-log entry — Sani's #2,
  answering the two-decision message).
- **Continuation EXECUTED 2026-08-09 (v4.4.0)**: `commands` flattened to bare
  path strings (all 9 descriptions verified present in command-file frontmatter
  before the flatten), `mcpServers` → path string `./.mcp.json`, `hooks` field +
  the empty `hooks/hooks.json` retired, non-spec `capabilities` removed;
  CLAUDE.md contract line updated in lockstep. Validator: the three W8 strict
  ERRORS gone; sole remaining strict finding is the root-CLAUDE.md packaging
  warning (accepted residual). END STATE OBSERVED: directory-source add +
  install on the migrated tree → `claude plugin list` "Version: 4.4.0 · Status:
  √ enabled"; remote `claude plugin marketplace add georgefin/seo-geo-claude-skills`
  now SUCCEEDS against post-merge main — the reviewer's Finding 2 re-probe RUN
  rather than recorded-as-queued (adapted with the review's substance intact:
  the merge landed between the round's freeze and its return); install from
  main's then-current pre-migration 4.3.5 manifest still drew the W8 trio until
  this wave merged (historical as of the PR #8 merge, 2026-08-09 ~10:47Z —
  remote flow complete and probe-verified on main, ninth verdict-log entry).
  Revert = single commit. A `.claude/
  settings.json` team-marketplace addition (extraKnownMarketplaces +
  enabledPlugins) was attempted and DENIED by the session permission classifier
  (that file carries the push-gate hook; diagnosed, not classifier-stated:
  self-edit protection on the gate file — the denial message said only "Blocked
  by classifier"); the 8-line snippet goes to Sani for manual or
  interactive-session addition.
- **Continuation now LOAD-BEARING for installs (2026-08-09, probe evidence)**: the
  fork cannot be installed as a working Claude Code plugin until this decision
  lands. Probed on the v4.3.5 tree: `claude plugin install
  seo-geo-claude-skills@seo-geo-claude-skills` from a directory-source marketplace
  (resolved via the new shim) is REJECTED at install-time validation with exactly
  the recorded W8 trio — "Validation errors: hooks: Invalid input, commands:
  Invalid input, mcpServers: Invalid input". The file-source variant's install
  response reports success, but `claude plugin list` then shows "failed to load:
  cache-miss" (observed in the probe container; load mechanism not further
  diagnosed). The v4.3.5 marketplace-discovery shim fixed manifest DISCOVERY
  only. (Superseded same day: continuation APPROVED (eighth verdict-log entry)
  and EXECUTED (v4.4.0) — see the two notes above; the scope as executed matched
  this recorded scope.)

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

## G5 — Vigilance-to-code wave (claims-gate + archive/fragment checks + KPI persistence)

- **Status**: **RELEASED 2026-08-09** (eleventh verdict-log entry) **+ DELIVERED
  + WIRED 2026-08-09** — scripts + fixtures + `KPI.md` implemented; acceptance
  test per the implementer's report: all five gate-detectable F11 instances
  caught at FAIL, three truth-class instances at WARN (the plan's form/truth
  tiering), negative control clean. Wired into `pre-push-gate.sh` on per-push
  scope (claims-gate resolves `@{upstream}`; pre-gate branch history goes to the
  Mode A covering round rather than being retro-anchored — anchoring pre-gate
  drafting after the fact would fabricate drafting-time evidence)
  [obs:2026-08-09T21:09:18Z integration commit, first gated push].
  Proposed 2026-08-09 (`MASTER-IMPROVEMENT-PLAN.md` §1a–1b; tenth verdict-log
  entry).
- **Proposal**: `scripts/claims-gate.sh` wired into the pre-push gate — rule 1
  anchored-claims lexicon (two tiers: hard-FAIL narrow, WARN broad), rule 2
  flip-manifest whole-register sweep (F11-r5's re-scan, executed by machine), rule 3
  timestamp sanity; plus check (h) trigger-archive presence (F10), Mode B
  fragment-lint (F7 evidence fields), and `docs/loop/KPI.md` (append-only cold rows
  written by the weekly routine — Phase 3.2's KPI persistence).
- **Acceptance test**: the five recorded F11 instances reconstructed as
  fault-injection fixtures — 5/5 caught, clean negative control (F2/F9/(g) precedent).
- **Honest boundary**: enforces form (anchors present, sweeps run), not truth —
  Mode A keeps the truth leg.
- **Risk**: lexicon false positives → two-tier design with weekly tightening +
  allowlist. **Rollback**: unhook from the gate (one commit); checks are additive.

## G6 — Adversarial Sanity Layer (cross-tier contrastive review)

- **Status**: **RELEASED 2026-08-09** (eleventh verdict-log entry) **+ DELIVERED**
  same day — `ADVERSARIAL-LAYER.md` committed (`69c5f7e`); PIPELINE/CLAUDE.md
  pointers added in the G5 integration commit (2026-08-09). Proposed 2026-08-09
  (`MASTER-IMPROVEMENT-PLAN.md` §1c).
- **Proposal**: defined high-stakes outputs (gate/verdict flips, releases,
  Sani-facing numbers, external-world skill rules) get a second review lane on a
  different Claude tier under a contrastive charter (assume-wrong, construct the
  strongest disproof); charter templates + the high-stakes definition land in the
  loop docs. Protocol B: a paste-ready prompt for Sani's ~5-minute monthly
  cross-family check in a non-Anthropic model — the only true cross-family leg
  available (in-environment models are all Claude-family; stated in the plan).
- **Risk**: ~2× review tokens on the ~10–15% of commits that qualify.
- **Rollback**: drop the second lane (procedural; no repo surface beyond docs).

## G7 — Behavioral evals for the remaining 17 skills (3/20 → 20/20)

- **Status**: **RELEASED 2026-08-09** (eleventh verdict-log entry) **+ IN
  EXECUTION** — E1 authored and committed (`7212660`, `262e46a`, `c0e4642`,
  `609a9a2`) with all four Mode A reviews returned (quality-auditor SHIP;
  on-page FIX applied; writer FIX ×2 applied; meta-tags FIX applied — no fresh
  round needed per the fix-application convention); E2 authored and
  committed (`591acfd`, `5559474`, `e0d0c34`) with all three Mode A reviews
  returned (FIX ×2 each; applied `4310d7c`, `c736b64`); E3 authored and
  committed (`28534c4`, `3730ad4`, `783ca4e`, `3bb7970`) with all four Mode A
  reviews returned (technical-seo-checker, content-refresher, and
  domain-authority-auditor SHIP with zero findings; internal-linking FIX ×1
  applied); E1 first Mode B baselines COMPLETE 2026-08-09 — on-page 29/30,
  content-quality-auditor 26/28, meta-tags-optimizer 29/29, seo-content-writer
  30/30 (114/117), six binding editor passes NATIVE ×2 / MINOR-EDITS ×4 /
  FAIL ×0, founding records in `eval-baselines/2026-08-09-e1.json`.
  **COVERAGE COMPLETE 2026-08-10 — 20/20.** E4 (rank-tracker,
  backlink-analyzer, performance-reporter, alert-manager) and E5
  (entity-optimizer, memory-management, the latter carrying the cross-skill
  handoff eval) authored, reviewed and fixed: 41 Mode A findings across the two
  waves, all applied. E2–E5 founding baselines recorded in
  `eval-baselines/2026-08-10-e2345.json` (13 suites).
  **Read that record's method block before quoting any score.** Ten suites were
  graded by an agent that executed AND graded knowing the expectations
  (276/282 = 0.979) and three under a blind-execute method with expectations
  withheld until each deliverable was saved (67/86 = 0.779; memory 86.2%,
  backlink 85.7%, entity 62.1%). The two are NOT comparable and are never
  averaged in the record; the informed-executor figures are an upper bound on
  what the library does, not a floor. The gap surfaced 19 real behavioural
  FAILs — 7 positive errors (invented figures, a banned cost-per-mention
  artefact, counts contradicting the fixture, a quote silently re-cased, a
  disavow sequence that folded under deadline pressure) and 12 omissions. The
  method fix is queued for the next re-baseline wave, and the wave's own
  same-day fixes are stamped in the record (`225a3c4`, `bb6ef16`).
  Proposed 2026-08-09 (`MASTER-IMPROVEMENT-PLAN.md` §2).
- **Proposal**: five waves — E1 score authorities (content-quality-auditor,
  on-page-seo-auditor, seo-content-writer, meta-tags-optimizer; eval-the-scorer
  pattern for CORE-EEAT: veto handling, N/A discipline, cap math), E2 research
  (serp-analysis, competitor-analysis, content-gap-analysis), E3 technical + CITE
  (technical-seo-checker, internal-linking-optimizer, content-refresher,
  domain-authority-auditor), E4 monitor (rank-tracker, backlink-analyzer,
  performance-reporter, alert-manager), E5 cross-cutting + one cross-skill handoff
  eval (entity-optimizer, memory-management). House pattern per suite: 5 evals,
  ~25–30 expectations, no-fab in every eval, zero-data honesty eval, ≥1 Greek eval
  where the skill produces prose, Mode B first baseline, Greek-editor binding.
  Done per skill = suite + baseline + zero-regression protection + VERSIONS sync.
  Cadence: ~one wave/week alongside the loop → 20/20 in ~5 weeks.
- **Risk**: token cost per wave (batch cadence bounds it). **Rollback**: none
  needed — suites are additive.

## G8 — Real-site outcome pilot (execution)

- **Status**: executable scope **RELEASED 2026-08-09** (eleventh verdict-log
  entry) **+ DELIVERED** — `PILOT.md` committed (`9c6adb4`); deployment to a real
  property stays gated on the three Sani inputs below, whose per-input status lives
  in `PILOT.md` §0.1 (inputs 1 and 2 carry partial words recorded 2026-08-10;
  input 3 has none). Scoping was AUTHORIZED by the
  directive (tenth verdict-log entry) and delivered as `MASTER-IMPROVEMENT-PLAN.md`
  §3.
- **Proposal**: matched-pair (control pages held) or before/after pilot on a
  Sani-named non-core cluster (5–15 pages); pre-registered success/null criteria
  BEFORE deployment; three metrics at weeks 2/4/8/12 — rankings on a fixed query
  set including Greek inflected pairs (folds in W10's open inflection leg), GSC
  clicks/impressions, AI-citation rate under a written sampling protocol; every
  published change passes CORE-EEAT threshold + Greek editor (EL) + **Sani approval
  before publication** (HITL); byte-exact pre-change copies for rollback; quarterly
  cold HITL review rides this gate (first ~2026-11, reminder Routine armed on
  approval).
- **Gated on (Sani, all three; §0.1 of `PILOT.md` holds the per-input status and the
  verbatim words received 2026-08-10)**: named target cluster; data access (GSC/GA4
  exports, or connector auth — the session's ahrefs/similarweb MCP servers are
  unauthenticated as of 2026-08-09 and OAuth cannot run in this non-interactive
  session: authorize in claude.ai connector settings or an interactive `/mcp`
  session; CSV exports are a full substitute); publication workflow (who applies
  changes). Finding recorded 2026-08-10 while answering input 2: none of the six MCP
  servers this repo declares (ahrefs, similarweb, hubspot, amplitude, notion, slack)
  is a Google Search Console or GA4 server, so connector authorization alone does not
  satisfy input 2 — the export drop stays the primary measurement route (`PILOT.md`
  §0.1).
- **Risk**: outward-facing changes on a live property — bounded by non-core cluster
  choice, HITL on every publish, stored rollback copies; a null result is reported
  as a finding (pre-registration forecloses curve-fitting).
- **Rollback**: restore stored copies; halt = stop publishing (measurement can
  continue as observation).

---

## G9 — FAQ/HowTo rich-result provenance: R3 amendment + a HowTo ruling with library purge

- **Status**: **SPLIT VERDICT, 2026-08-11 — 9a ACCEPTED and applied; 9b HELD.** Sani's
  decision, given as an explicit selection between drafted options: accept the provenance
  amendment, hold the HowTo ruling and its four-file purge until an owner read of the two
  Google URLs upgrades the evidence grade. 9a landed in `SETTLED-RULINGS.md` R3 (commit
  `f4c9bcf`) with the downstream skill-surface sweep following in the same wave; 9b is
  untouched and its four loci still teach HowTo as a current SERP feature, which is the
  known cost of the hold and is recorded rather than smoothed. The blocker on 9b is
  unchanged and now re-tested: `developers.google.com` is refused by this environment's
  egress proxy [obs:2026-08-11T03:40:00Z curl + WebFetch, both refused at the gateway], so
  the upgrade cannot be done from here — it needs either a browser read or the host added to
  the environment allowlist (`PILOT.md` §0.1 carries the same request for four other hosts).
  **This Status line was itself an F11 recurrence**: 9a was applied to the ruling register
  while this entry still read "GATED, proposed" and still asked Sani to decide something he
  had decided. Caught by the second Mode A pass, not by any gate — the claims-gate's flip
  sweep keys on `Status:`/`Verdict:` field syntax that neither register uses, so a half-moved
  gate entry is structurally invisible to it.
- Originally proposed 2026-08-10. Two related changes, both gate-class because
  they touch settled rulings. Origin: the binding Greek editor, judging an unrelated
  Greek output, flagged out-of-remit that the deliverable's "FAQ rich results were
  retired in 2026" disagreed with its understanding that the deprecation dates to
  August 2023. A research lane was opened the same day; its full record is the
  coordinator's 2026-08-10 transcription (scratchpad `research-r3-faq-timeline.md`).
- **Finding**: both events are real and distinct, so **R3 is not contradicted**.
  2023-08-08 narrowed FAQ rich-result ELIGIBILITY to well-known government and health
  sites; 2026-05-07 ended the display entirely, with the search appearance, rich
  result report and Rich Results Test support dropped June 2026 and Search Console
  API support scheduled for August 2026. Every clause of R3 checked out except two
  precisions (below) [obs:2026-08-10T04:02:00Z research-lane return]. The reopen
  condition is NOT triggered — FAQPage is present in schema.org v30.0, re-read
  2026-08-10.
- **Proposal 9a — R3 provenance amendment (settled-ruling text, so gated)**: append a
  sentence distinguishing the 2023 eligibility narrowing from the 2026 retirement;
  soften "API … cut" to "scheduled August 2026" until completion is observed (today is
  2026-08-10, so that cut is in-month, not confirmed done); and cite Google's own
  "there's no need to proactively remove it" guidance, which is newly-found primary
  support for R3's keep-decision and is currently uncited. Also record honestly that
  R3's rationale clause — "its value is AI-engine/GEO parsing" — has **no primary
  source either way**, and that Google's 2026 AI-optimization guide states no special
  structured data is needed for its own AI surfaces. That does not overturn the
  keep-decision (schema.org validity plus non-Google engines carry it) but it does
  constrain how confidently the library may phrase the benefit.
- **Proposal 9b — HowTo ruling + purge (W12)**: rule that HowTo rich results ended in
  2023 and purge the four library loci still teaching them as a current SERP feature
  (`research/serp-analysis/references/serp-feature-taxonomy.md:30` and `~:291`,
  `research/content-gap-analysis/references/gap-analysis-frameworks.md:150`,
  `build/meta-tags-optimizer/references/ctr-and-social-reference.md:121`), shipping the
  check (f) token row in the same wave per the F9-r2 backfill rule.
- **Why gated rather than applied**: creating a ruling is gate-class by the loop's own
  protocol, and the evidence — while consistent across independent
  domain-restricted queries against Google's own domain — is snippet grade, not
  owner-read verbatim, because WebFetch is egress-restricted for
  `developers.google.com`. The coordinator will not purge four skill files
  library-wide on evidence it could not read directly. W5 and W7 were accepted at
  this same grade, so precedent supports acceptance; that precedent is Sani's to
  apply, not the coordinator's to assume.
- **Risk / rollback**: 9a is text-only in one register, revert = one commit. 9b touches
  four reference files across three skills plus version rows; revert = one commit. The
  eval suites need no change either way — every E2–E5 suite was authored to assert
  nothing about HowTo, which is what the [VERIFY] tag protects.
- **What Sani decides**: (i) accept 9a as drafted, (ii) accept 9b and authorize the
  purge, (iii) hold either pending an owner read of the two Google URLs, which takes
  about two minutes in a browser and would upgrade the evidence grade.

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
  2026-08-08) — **APPLIED 2026-08-09** (`b08253d`, the 11 items as 13 in-place
  rewords; touched indices re-baselined in
  `docs/loop/eval-baselines/2026-08-09-v3.json`): 11 minor items recorded in `docs/loop/eval-baselines/2026-08-08-v2.json`
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
- **Benchmark polish pair** (reviewer advisories, 2026-08-08, verdict-neutral) —
  **APPLIED 2026-08-09** (`29e880c`: benchmark N/A-source clarification +
  emergency-brake Partial-by-design line; content-quality-auditor 4.2.1,
  performance-reporter 4.1.1): (a)
  core-eeat-benchmark scoring-table N/A row could state that rubric-granted
  conditionality (currently T04 only) is the sole rubric-level N/A source, foreclosing
  at-will N/A readings; (b) content-quality-auditor's emergency-brake veto table lists
  no Partial state (by design — full pass handles it) — one clarifying line would stop
  the question recurring. Bundle with the next framework touch.
- **Shared-framework consistency pass** (surfaced 2026-08-08 by the schema
  reconciliation + auditor labels agents) — **VERIFIED ALREADY APPLIED 2026-08-09**
  (the Section 5 R2 alignment shipped in `512b83e` the evening this was queued;
  `29e880c` independently confirmed it and closed the bundled CWV `<`-vs-`≤` leg
  via the bucket-mislabel fix): `references/core-eeat-benchmark.md` Section 5
  (≈ lines 216-226) still teaches the pre-clarification multi-type mapping ("Article,
  Breadcrumb | FAQ, HowTo") — skill text currently states "where they differ, R2
  governs", but the benchmark needs its own scoped pass; bundle the `<`-vs-`≤` CWV
  boundary phrasing nuance (R4 uses ≤; several references use `<`) into the same pass.
  Shared framework files — small, deliberate, own wave.
- **check (g) scope-extension question (covering-round advisory, 2026-08-09)**:
  PIPELINE's stage-3 `CLAUDE.md:49`/`:50` pointers had silently drifted to
  :53/:54 (grep-verified, corrected in the advisory's fix-forward) — check (g)
  verified `VERSIONS.md` targets only. **ANSWERED 2026-08-10 (`4a1d238`) — extended.**
  Check (g) now verifies anchor-tagged pointers into ANY repo file on the same
  contract: the token is authoritative and a line/token mismatch fails. Demonstrated
  before wiring against five deliberate injections in a scratch copy, including this
  advisory's own CLAUDE.md case and the E3 round's `SKILL.md:258` blank-line drift.
  Two honest scope statements travel with it: 35 bare `file:line` pointers carry no
  token, so the check counts and lists them per register but never fails them —
  anchor-tagging those is queued, not assumed; and pointers using a multi-part line
  list are WARNed as unverifiable rather than silently skipped.
- **fork-manifest attribution (flagged 2026-08-09 as a Sani decision; DELEGATED to
  the coordinator 2026-08-10, twelfth verdict-log entry)**: both
  marketplace manifests' `owner`/`metadata.repository` fields and `VERSIONS.md:3`'s
  raw-fetch URL still carry the upstream identity (aaron-he-zhu) — fork
  inheritance, surfaced when the marketplace-discovery shim landed. No functional
  impact on marketplace discovery (probed: the add succeeds with the
  upstream-attributed manifests; installs were blocked separately by the W8
  manifest shapes at flag time (historical as of the PR #8 merge, 2026-08-09
  ~10:47Z — installs from main now succeed, ninth verdict-log entry); see the
  G1 continuation note). **DECIDED 2026-08-10 under Sani's delegation** (twelfth
  verdict-log entry: "Team choose the best, latest and most effective practice").
  Practice chosen, and the principle behind it: machine-readable identity points at
  the artifact people install and file issues against; human-readable credit names
  the upstream project permanently and prominently. Applied in this scope —
  (a) both manifests' `owner` + `metadata.repository` and `VERSIONS.md:3`'s
  raw-fetch URL move to `georgefin/seo-geo-claude-skills`, because those fields
  drive update checks and marketplace resolution, and pointing them upstream means
  a fork user silently reads upstream's files instead of the ones this loop
  maintains; (b) README gains an explicit fork-credit line naming the upstream
  repository and its author, and LICENSE is untouched; (c) the CORE-EEAT and CITE
  framework links keep pointing at their own upstream repositories — separate
  projects, not this fork's content, so re-attributing them would be
  misappropriation rather than a rebrand; (d) the ClawHub and skills.sh install
  commands keep the upstream path, since those resolve published listings this fork
  does not own and rewriting them to `georgefin/...` would hand users a dead
  install, while the Claude Code `/plugin marketplace add` command moves to the
  fork because it resolves straight from GitHub. Deliberately OUT of this scope and
  queued: the 20 `SKILL.md` frontmatter `homepage`/`metadata.author` fields, which
  carry the same upstream identity but would touch every skill and every tracking
  file — its own wave, so an identity change and a 20-skill version bump do not
  ride one commit. Reversal stays cheap: the applied scope is a single commit.
