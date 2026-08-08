# Watch-Item Register — the [VERIFY] Queue

Claims carried in skills (or in the research baseline) with explicit uncertainty markers.
A watch-item is **directional guidance, never fact**, until resolved by a dated primary
source. Tag variants in files: `[VERIFY]`, `[VERIFY – …]`, `[VERIFY, directional]` —
grep with `\[VERIFY` (not `\[VERIFY\]`) to find all of them.

Weekly DETECT runs re-check items at their cadence and report deltas; resolution edits
(dropping a tag, revising a claim) go through normal PR flow.

**Last full inventory: 2026-08-08** — 23 tag instances in 5 repo files (20 claim-bearing;
skroutz `:3`/`:85` are legend/instructions, `VERSIONS.md:36` is prose).

---

## W1 — AREX paper (arXiv 2607.21461)

- **Claim**: "AREX: Recursively Self-Improving Agent", arXiv 2607.21461 (Jul 2026) — part
  of the routine's Lane 7 (RSI/skill-evolution) baseline.
- **Where**: NOT in repo. Routine prompt Lane 7 baseline only ("flagged unverified 08-08-2026").
- **Status**: Unverifiable from cloud — arxiv.org egress-blocked; web search returned zero
  hits for "AREX" (2026-08-08).
- **Action / owner**: **Sani, local machine re-verify** (unblocked network). Resolves when
  title/authors confirmed (keep in baseline) or declared nonexistent (drop from Lane 7).
- **Cadence**: weekly nudge until resolved.

## W2 — AADE myDATA e-invoicing dates

- **Claim**: Phase 2 mandatory for ALL businesses by 01-10-2026; Phase 1 (>€1M turnover)
  live since 02-03-2026 → 8-week ops flag for every Greek e-shop client.
- **Where**: NOT in repo. 2026-08-08 weekly report only, tagged `[VERIFY — AADE primary blocked]`.
- **Action / owner**: **Sani, local re-verify vs aade.gr/myDATA** before any client advice.
- **Cadence**: hard re-check by 2026-09-01 (deadline is 8 weeks out from 2026-08-08).

## W3 — Per-engine citation overlap ~11% / Reddit ≈40% share

- **Claim**: ~11% ChatGPT↔Perplexity domain overlap; Reddit-type community/UGC content
  ≈40% of citations cross-engine (transcript also carried a 46x brand-citation-rate gap,
  0.59% vs 13.05% — not encoded in repo).
- **Where**: `build/geo-content-optimizer/SKILL.md:157`;
  `build/geo-content-optimizer/references/ai-citation-patterns.md:467-470,474,489`.
- **Source**: "680M-citation study", machinerelations.ai (2026, undated, methodology
  unverified).
- **Resolves when**: independent second study replicates (drop tag) or contradicts (revise).
- **Cadence**: quarterly, or on any new large citation study.

## W4 — Semantic collapse in multilingual E-E-A-T

- **Claim**: Translation-only pages lose AI-engine citations to the strongest-language
  version (often EN) — treat thin EL/DE translations as a citation risk.
- **Where**: `build/seo-content-writer/SKILL.md:286`.
- **Source**: searchengineland.com/multilingual-regions-ai-search-future-478282 (2026, day n/a).
- **Resolves when**: engine-primary documentation or a robust multilingual citation study.
- **Cadence**: quarterly.

## W5 — Greek review-compliance rules

- **Claim**: Review solicitation naming individual staff, and staff review quotas,
  reportedly banned (04-2026, blog-sourced); suspension risk if true.
- **Where**: `cross-cutting/entity-optimizer/SKILL.md:202`.
- **Resolves when**: confirmed against Google's review policy page (primary).
- **Cadence**: next sweep; always before client advice.

## W6 — Skroutz visibility levers (cluster, 8 claims)

- **Where**: `research/serp-analysis/references/skroutz-visibility-factors.md`
  (snapshot 2026-08-08; claim tags at `:15-21,31,39,47,48,56,63,70,78`; re-verify rule `:85-87`).
- **Open claims**: (1) ranking-effect magnitude of misfiling/attribute gaps `:31`;
  (2) price rank inside default/relevance sort `:39`; (3) BoxNow 300k-locker target `:47`;
  (4) delivery-badge as ranking input vs trust signal `:48`; (5) Trusted Reviews ranking
  weight `:56`; (6) 2026 returns-rule tightening `:63`; (7) Skoop fee amount/thresholds/scope
  (fee exists since 01-12-2025) `:70`; (8) exact fulfillment-SLA thresholds `:78`.
- **Resolves when**: confirmed on help.skroutz.gr / Skroutz seller panel (primary).
- **Cadence**: quarterly ("fast-moving market", file `:87`); always before client-facing
  figures (fees, locker counts, SLA, returns terms).

## W7 — AI Overviews "Expert Advice" quotes forum UGC directly

- **Claim**: AIO "Expert Advice" module quotes Reddit/forum UGC directly.
- **Where**: NOT in repo; 2026-08-08 weekly report only, tagged [VERIFY].
- **Action**: encode into `ai-citation-patterns.md` (with tag) only if it survives next
  sweep's verification; otherwise drop.
- **Cadence**: next sweep.

## W8 — Plugin validator tolerance of extra manifest fields

- **Claim**: Unknown whether `claude plugin validate` tolerates the repo's extra
  `schemaVersion`/`id`/`version` fields (tagged `[VERIFY tolerance]` in the 08-08 report).
- **Where**: NOT in repo; belongs to gated item **G1** (see `GATED-ITEMS.md`).
- **Action**: run `claude plugin validate --strict` during the G1 pilot.
- **Cadence**: resolved by G1 pilot; blocked on Sani's gate verdict.

---

**Standing weekly discipline (not a register item)**: Google core/spam "update" chatter is
blog-only until the Search Status Dashboard confirms it (last confirmed core update:
2026-05-21 → 2026-06-02). Never encode chatter as fact.
