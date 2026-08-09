# PIPELINE — Weekly Self-Improvement Loop (SANI HELLAS AI R&D)

One-read orientation for ANY fresh session or fired routine. Coordinator: Herbert.
Approver: Sani. Repo: fork `georgefin/seo-geo-claude-skills` (upstream:
`aaron-he-zhu/seo-geo-claude-skills`). Last updated: 2026-08-09 (F10 prompt recovery).

**GROUNDING RULE — do this first**: before researching or proposing anything, read the
five files in `docs/loop/`: `PIPELINE.md` (this file), `SETTLED-RULINGS.md`,
`WATCH-ITEMS.md`, `GATED-ITEMS.md`, `FAILURE-LEDGER.md`. Local checkout preferred; else
fetch raw from the fork (same pattern as `VERSIONS.md:3`). Rulings are non-relitigable
without new primary evidence; gated items are untouchable without Sani's recorded
verdict; ledgered failures must not be repeated — repeating one is an incident.

## The 5 stages

1. **DETECT** — Saturdays 07:00 Athens, the weekly routine fires a fresh session
   ("Herbert Skill Update Check — R&D Team"). 7 parallel research lanes (technical SEO +
   confirmed Google updates + accessibility, local/GBP, GEO/AEO, Greek e-commerce/Skroutz,
   multilingual, backlinks/authority, AI skills & RSI). Discipline (Sani standing rules
   R64/R71): dated PRIMARY sources for every claim; blog-only/unconfirmed ⇒ `[VERIFY]`;
   unreachable-by-egress ⇒ `[BLOCKED-EGRESS]` (a different epistemic state); never
   fabricate a paper, version, CVE, or finding; "quiet lane" is a valid result.
   **Detect + propose + nudge ONLY — the fired run never edits files, never pushes, never
   sends email.** Output: bilingual GR/EN 8-section report ≤1500 words, VERDICT line with
   the loop-closure metric ("X of Y findings already applied"), plus a fenced
   machine-readable `proposals:` block (id/lane/target_skills/files/change/loop/priority/
   status/evidence) that GATE approves by id and APPLY fans out on.
2. **GATE** — Sani approves/rejects proposals (by id). Anything touching a settled ruling
   is labeled "supersession candidate for Sani's gate". Risky/spec-level changes are
   parked in `GATED-ITEMS.md` until an explicit verdict.
3. **APPLY** — Herbert (interactive session) implements approved items via parallel
   `skill-implementer` subagents on disjoint file scopes; per-skill commits for clean
   revert. Before commit, `skill-reviewer` (Mode A) makes an adversarial pass over each
   diff — SHIP / FIX / BLOCK on ruling compliance, `[VERIFY]`-tag preservation, contract
   integrity, scope. Self-review by the implementing agent does not count. Branch naming
   per `CLAUDE.md:50` (`feature/…`, `fix/…`, `docs/…`); cloud sessions use their assigned
   `claude/*` branch. Skill edits trigger the 5-tracking-file sync (`CLAUDE.md:49`);
   docs-only changes (this directory) do NOT.
4. **VALIDATE** — two legs, both required:
   (i) STRUCTURAL: `scripts/pre-push-gate.sh` before EVERY push — runs
   `scripts/validate-skill.sh` on each touched skill plus `scripts/validate-tracking.sh`
   (version tri-sync, manifest↔disk parity, VERSIONS.md↔frontmatter, 350-line body cap,
   references/ link integrity). A `PreToolUse` hook in `.claude/settings.json` enforces
   the gate on `git push` in cloud sessions. Fork Actions disabled → local gate is the
   effective gate (enabling Actions on the same scripts is the recommended follow-up).
   (ii) BEHAVIORAL: skills carrying an `evals/` suite (pilot 2026-08-08:
   schema-markup-generator, keyword-research, geo-content-optimizer) must pass their
   suite — `skill-reviewer` (Mode B) executes and grades per skill-creator conventions;
   an eval regression is a do-not-merge finding. Greek-language outputs additionally go
   to `greek-content-editor` for register/diacritics/Greeklish-placement judgment.
   `scripts/check-freshness.sh` (advisory, non-blocking) flags dated baselines and
   snapshots older than their re-check window.
5. **MONITOR** — `subscribe_pr_activity` on open PRs (webhook events wake the session)
   PLUS a self-re-arming `send_later` check-in chain. The two are complementary: webhooks
   deliver comments fast; only polling sees merged/closed/conflict transitions. Check-in
   policy: 60 min while active → 120 after 2 quiet checks → cap 240; quiet hours
   23:00–07:00 Athens (re-arm to next 07:00); each re-arm message carries cursor state
   {head SHA, last comment timestamp, consecutive-quiet count}; **on merged/closed:
   unsubscribe, do NOT re-arm, report final status**. Next Saturday's DETECT run then
   verifies the merged deltas landed (loop-closure metric).

## Learning metrics (the loop's own report card)

A recursive loop is learning only if it stops repeating its own mistakes. Raw average
scores can rise while old failures recur — so these three metrics OUTRANK any raw
pass-rate when judging the loop (maintainer directive, 2026-08-08):

1. **Eval regression rate** — of expectations that PASSED in the previous recorded
   baseline, the share now failing on the same-or-newer skill version. Computed at every
   VALIDATE run of a suite against `docs/loop/eval-baselines/` (dated, append-only).
   Target: 0. ANY regression = do-not-merge + a FAILURE-LEDGER entry.
2. **Repeat-failure count** — recurrences recorded in `FAILURE-LEDGER.md` (a failure
   matching an existing entry's signature). A recurrence means the guard failed; guard
   redesign becomes mandatory work. Target: 0.
3. **Tool-correctness rate** — share of agent runs clean of tool misuse: zero tool
   errors, zero scope violations, zero fabricated results, expectations gradeable as
   written. Recorded per eval/review run in the baseline files.

Raw pass-rates are still recorded (they catch absolute quality drift) but are read AFTER
the three above: a 90% average with one regression is worse than a stable 75% — the
first is a loop forgetting, the second is a loop that has not yet learned. First
baselines: `docs/loop/eval-baselines/2026-08-08.json`.

## Trigger registry

| Routine | ID | State | Schedule (UTC) |
|---|---|---|---|
| weekly skill-update check (current, prompt v4.1) | `trig_012FupQL9hy8p9FPeBHo9Lee` | enabled; created 2026-08-08, prompt upgraded v2→v3→v4→v4.1 same day (audit + RSI waves); push+email notifications ON; first solo fire expected 2026-08-15; prompt pinned at `docs/loop/archive/v4.1-weekly-prompt-2026-08-08.txt` (recovered from the trigger store 2026-08-09, F10) | `0 4 * * 6` (~04:08 actual) |
| v1 (retired) | `trig_01TEakvC4M948KZwaGiMZVDR` | **DELETED by Sani 2026-08-08, API-verified** (UI offered delete-only; agent writes ownership-refused). Prompt archived at `docs/loop/archive/v1-weekly-prompt-2026-07-18.txt`; its past run sessions survive in the account's session list. Double-fire risk closed. | was `0 4 * * 6` |
| DST flip 1/2 | `trig_01HsA9dHtk5Vo4nhBDV7AbsE` | armed one-shot; prompt pinned at `docs/loop/archive/dst-flip-1-prompt-2026-08-08.txt` | once 2026-10-24T09:00Z |
| DST flip 2/2 | `trig_01UDJeyM9xHvbHs2DoYurTZU` | armed one-shot; prompt pinned at `docs/loop/archive/dst-flip-2-prompt-2026-08-08.txt` | once 2027-03-27T09:00Z |
| PR monitor check-ins | (rotating `send_later` one-shots) | self-re-arming while a PR is open; cursor prompts exempt from F10 archiving (wholesale-replaced derivations of the stage-5 policy) | per monitor policy above |
| v2 interim test | `trig_011r86dkH91sfNUurCXrrJrJ` | deleted 2026-08-08 (replaced to add notifications) | — |

**DST**: Europe/Athens leaves EEST (UTC+3) on Sun 2026-10-25 and returns Sun 2027-03-28.
Platform cron is UTC-only, so the armed flips update the weekly cron `0 4 * * 6` →
`0 5 * * 6` (winter) → back. Each flip self-degrades to a notify-Sani reminder if its
session cannot call `update_trigger`. **If the weekly routine is ever recreated under a
new ID, update both flip prompts (or delete+recreate the flips) to target it.**
FYI (foreign trigger, not ours to touch): Sani's "Morning brief" (`0 4 * * 1-5`) has the
same winter drift — its fix would be `0 5 * * 1-5`.

## Report delivery & archive

- Primary delivery: the report is the fired run's **final message** (Routines UI) plus
  push/email completion notifications. Routine-fired sessions carry no connectors in this
  org (in-session `create_trigger` limitation), so no Gmail draft on scheduled runs; docs
  (code.claude.com/docs/en/routines.md, 2026-08-08) say connectors attach by default in
  the claude.ai Routines UI creation form — recreating the routine there (with Gmail) is
  the known upgrade path, Sani's call.
- **Durable archive — GATED (G2 in `GATED-ITEMS.md`)**: file each weekly report as a
  GitHub Issue on the fork (`weekly-report` label) + one rolling `verify-queue` issue
  mirroring WATCH-ITEMS.md. Filing issues violates neither the no-edit nor the no-push
  rule, but the fork is public, so recurring publication awaits Sani's yes.
- Optional mirror: `docs/loop/reports/YYYY-MM-DD_skill-update-check.md`, committed by
  APPLY-stage sessions. Sani's local Dropbox tree (`skill-update-checks/…`, `_INDEX.md`,
  `STANDING-LOOPS.md` row 5) is a separate, unchanged surface for local runs.

## State files (single source of truth)

| File | Holds | Changed by |
|---|---|---|
| `SETTLED-RULINGS.md` | non-relitigable research rulings + pinned baselines | rulings: gated PR only; baselines: normal PR on verified drift |
| `WATCH-ITEMS.md` | [VERIFY] queue: claim, file:line, source, cadence, owner action | PR after verification |
| `GATED-ITEMS.md` | proposals awaiting Sani, risk/rollback, verdicts | Sani's verdict via PR |
| `FAILURE-LEDGER.md` | append-only failure entries + guards + recurrence counts | every FIX/BLOCK, regression, revert, incident |
| `eval-baselines/` | dated eval-run records (per-expectation outcomes, tool-correctness) — regression-rate denominator | skill-reviewer runs via APPLY sessions |
| `reports/` (optional) | dated weekly report mirrors | APPLY-stage sessions |

## Trigger hygiene policy (standing)

1. Ownership at mint: `RND:` name prefix where `create_trigger` is used; `send_later`
   names are auto-generated — treat only triggers documented in this registry (or its
   history) as pipeline-owned. `created_via` is NOT a safe ownership discriminator.
2. Spent pipeline one-shots (`ended_reason=run_once_fired` — permanently disabled, zero
   re-fire risk) are deletable QUARTERLY once >30 days old with outcome recorded; always
   retain the 3 most recent.
3. **Foreign triggers** (other projects: "Morning brief", "MeacoFan Pedestal", meaco.gr /
   Mitsubishi / Seraphinite / Arete one-shots): inventory-only, NEVER modified or deleted
   without Sani — including spent ones (their prompts are the only surviving record).
4. Retired loops: pause + rename `[RETIRED <date> - superseded by <id>]`; delete only
   after a quarter with sign-off.
5. Duplicate-cron tripwire: two enabled triggers with the same cron and overlapping scope
   = incident, report immediately (the v1/v2 2026-08-15 near-miss).
6. `next_run_at` is meaningful only when `enabled=true` AND `ended_reason` is empty
   (spent one-shots display a bogus +24h value).
7. Vehicle: the weekly prompt's STEP 5b runs this sweep on the first Saturday of
   Jan/Apr/Jul/Oct — no separate loop.
8. The same quarterly STEP 5b reports the **loop-KPIs** (meta-loop measurement,
   2026-08-08; learning metrics FIRST per maintainer directive): eval regression rate ·
   repeat-failure count (FAILURE-LEDGER recurrences) · tool-correctness rate · then
   proposal→merge latency · reverts this quarter · watch-item resolution rate · ruling
   stability (supersession candidates raised). Trend, not ceremony: two lines per KPI.
9. **Quarterly upstream harvest lane** (G4 verdict 2026-08-08: HARVEST, quarterly not
   weekly): in the same quarterly STEP 5b pass, diff `aaron-he-zhu/aaron-marketing-skills`'s
   SEO/GEO line against the last-harvested state (baseline: v19.1.0, harvested
   2026-08-08 — items 1-7 recorded in GATED-ITEMS G4) and report NEW harvest candidates
   as proposals for the gate. Read-only lane; topology stays 20 skills; llms.txt
   enthusiasm upstream never ports (R1); parasite/borrowed-authority plays never port
   (O4 verdict). First run: first Saturday of 2026-10.

## Deferred by decision (not omission)

- **Event-driven DETECT** (e.g., Google-update webhook → immediate sweep): assessed
  2026-08-08, deferred. Confirmed core updates run ~2–4×/year; the weekly cadence caps
  reaction latency at 6 days, immaterial for library edits (client-facing immediacy is
  `alert-manager`'s job, not this loop's). If ever built: the Google Search Status
  Dashboard has an official RSS feed — a daily poll is S effort.
- **Real-site A/B / holdout for content-skill changes**: aspirational rigor ceiling;
  requires client-site inventory and months of window. Output-level blind A/B (old skill
  vs new skill on fixed eval prompts) is the feasible substitute and part of VALIDATE (ii).

## Known constraints

- Cloud egress: arxiv.org blocked; many domains WebFetch-blocked — use the
  `[BLOCKED-EGRESS]` rule (2 attempts, then a mirror, then tag and move on). Mirror
  reality check (2026-08-08): semanticscholar.org and huggingface.co are ALSO blocked
  from this environment; openreview.net plus WebSearch snippets are the working
  fallback (snippet-verified 4/4 pinned RSI papers). AREX existence confirmed
  2026-08-08 (W1 — Sani re-verify now optional).
- Fork GitHub Actions disabled (local gate is authoritative). GitHub Issues DISABLED —
  410 on issue-create verified 2026-08-08 and re-verified twice 2026-08-09; the durable
  report archive (G2) waits on the toggle. This line previously said "enabled" — never
  assert a repo capability without a verified probe (F4/F10 spirit).
- Routine-fired sessions: no connectors (org limitation on in-session `create_trigger`).
- The rulings/watch-items digest inside the routine prompt is a FALLBACK only — this
  directory is authoritative.
