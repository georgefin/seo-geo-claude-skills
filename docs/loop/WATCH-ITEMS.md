# Watch-Item Register — the [VERIFY] Queue

Claims carried in skills (or in the research baseline) with explicit uncertainty markers.
A watch-item is **directional guidance, never fact**, until resolved by a dated primary
source. Tag variants in files: `[VERIFY]`, `[VERIFY – …]`, `[VERIFY, directional]` —
grep with `\[VERIFY` (not `\[VERIFY\]`) to find all of them.

Weekly DETECT runs re-check items at their cadence and report deltas; resolution edits
(dropping a tag, revising a claim) go through normal PR flow.

**Last full inventory: 2026-08-09 (post W5+W10 closures)** — 53 matching lines in 13
repo files (`grep -rc '\[VERIFY' research build optimize monitor cross-cutting references
VERSIONS.md`). Delta vs the same-day post-wave count (53 in 15): −2 claim tags (W5
dropped at entity-optimizer SKILL.md:185, W10-LSA dropped at
serp-feature-taxonomy.md:233 — both resolved-primary by owner reads), +2 changelog
bookkeeping mentions in `VERSIONS.md` (v4.3.2, v4.3.3); entity-optimizer's SKILL.md
and the taxonomy file now carry no tags, hence 15→13 files. The post-wave note
stands: the v4.3.x changelog prose mentions in `VERSIONS.md` are bookkeeping
references, not new claims. The 2026-08-08 note stands:
13 Greek-wave claim tags registered as W9–W11; legend/discipline lines are not claims
(tourism `:3`/`:76`, shopping `:3`/`:13`/`:58`, ymyl-credentials intro,
content-quality-auditor discipline note).

**GitHub mirror (G2, live 2026-08-09)**: rolling issue
[#6](https://github.com/georgefin/seo-geo-claude-skills/issues/6) (label
`verify-queue`) mirrors this register — Sani posts local-verification verdicts there
as comments; weekly runs read them as findings and comment their deltas; APPLY
sessions fold verdicts back into this file and refresh the issue. This file stays
authoritative.

---

## W1 — AREX paper (arXiv 2607.21461) — EXISTENCE CONFIRMED 2026-08-08

- **Claim**: arXiv 2607.21461, corrected title **"AREX: Towards a Recursively
  Self-Improving Agent for Deep Research"** (BAAI, submitted 2026-07-23) — part of the
  routine's Lane 7 (RSI/skill-evolution) baseline.
- **Status**: Existence CONFIRMED by the 2026-08-08 loop assessment (supersedes the same
  morning's zero-hits status): web search surfaced the arXiv listing (v1 AND v2), an
  alphaXiv page, and Hugging Face model cards `BAAI/AREX-Base` / `BAAI/AREX-Turbo`.
  Snippet-level design (inner research loop + outer constraint-wise audit loop) is
  consistent across sources; the paper itself remains unfetchable from cloud
  (arxiv.org + huggingface.co + semanticscholar.org all egress-blocked).
- **Action / owner**: Sani local re-verify **downgraded to OPTIONAL** — abstract-level
  confirmation of the design claims if ever needed for encoding them into skills.
- **Cadence**: baseline row updated; drops off the weekly nudge list.

## W2 — AADE myDATA e-invoicing dates

- **Claim**: Phase 2 mandatory for ALL businesses by 01-10-2026; Phase 1 (>€1M turnover)
  live since 02-03-2026 → 8-week ops flag for every Greek e-shop client.
- **Where**: claim dates NOT in repo (2026-08-08 weekly report only, tagged `[VERIFY — AADE primary blocked]`); referenced do-not-assert-only in `cross-cutting/domain-authority-auditor/references/greek-eshop-compliance.md` §6 since 2026-08-08.
- **Action / owner**: **Sani, local re-verify vs aade.gr/myDATA** before any client advice.
- **Cadence**: hard re-check by 2026-09-01 (deadline is 8 weeks out from 2026-08-08).

## W3 — Per-engine citation overlap ~11% / Reddit ≈40% share

- **Claim**: ~11% ChatGPT↔Perplexity domain overlap; Reddit-type community/UGC content
  ≈40% of citations cross-engine (transcript also carried a 46x brand-citation-rate gap,
  0.59% vs 13.05% — not encoded in repo).
- **Where**: `build/geo-content-optimizer/SKILL.md:140`;
  `build/geo-content-optimizer/references/ai-citation-patterns.md:467-470,474,491`
  (pointers refreshed 2026-08-09 — SKILL.md ref was stale, file refs shifted by the
  4.1.5 module insertion).
- **Partial corroboration 2026-08-09 (W7 lane)**: the community-citation CHANNEL is now
  Google-primary — the 2026-05-06 quote-preview module announcement, encoded at
  `ai-citation-patterns.md:476`. The ~11% overlap and ≈40% share MAGNITUDES remain the
  open claims; their tags are unchanged and this item stays open for them alone.
- **Source**: "680M-citation study", machinerelations.ai (2026, undated, methodology
  unverified).
- **Resolves when**: independent second study replicates (drop tag) or contradicts (revise).
- **Cadence**: quarterly, or on any new large citation study.
- **Tooling note (2026-08-08)**: per-engine citation share is now productized (SE Ranking
  AI share-of-voice, Profound and similar AI-visibility trackers) — measurement tooling
  for future verification, not itself evidence for the claim.

## W4 — Semantic collapse in multilingual E-E-A-T

- **Claim**: Translation-only pages lose AI-engine citations to the strongest-language
  version (often EN) — treat thin EL/DE translations as a citation risk.
- **Where**: `build/seo-content-writer/SKILL.md:275` (pointer refreshed 2026-08-08 after the anti-slop wave).
- **Source**: searchengineland.com/multilingual-regions-ai-search-future-478282 (2026, day n/a).
- **Resolves when**: engine-primary documentation or a robust multilingual citation study.
- **Cadence**: quarterly.

## W5 — Greek review-compliance rules — RESOLVED-PRIMARY 2026-08-09 (owner read)

- **Claim (as resolved)**: Review solicitation naming individual staff, and staff
  review quotas, banned under "Prohibited & restricted content" (Fake engagement) —
  reported policy addition ~2026-04-17.
- **Resolution (2026-08-09)**: Sani opened both pages live (English versions — the
  policy page auto-served Greek first, so an el localization of the page exists;
  its content was not separately checked) and pasted the verbatim text in-session:
  both phrases CONFIRMED with the fuller live prefix "Merchants requesting…" —
  nailing the merchant-directive reading from the primary source — and
  business/answer/14114287 CONFIRMED: removal of violative reviews + set-period
  new-review freeze, set-period unpublishing of existing reviews, public warning
  displayed to consumers, email notice, appeal path; no automatic
  suspension. Encoded at `cross-cutting/entity-optimizer/SKILL.md:185`
  (entity-optimizer 4.1.3, tag dropped). The business/answer/7400114 same-text
  mirror was NOT separately opened — kept in the callout as a hedged pointer only.
- **History**: 2026-08-09 sweep had reached snippet-corroborated via
  `site:support.google.com` probes (cloud egress-blocked from the domain); Mode A
  held the tag per the F4 guard class until this owner read.
- **Residual (untagged, immaterial for use)**: the "~2026-04-17 addition" date stays
  vendor-reported — current presence is what was verified, not the addition date.
- **Cadence**: CLOSED. Re-opens only on policy-page drift (normal weekly sweep watch).

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

## W7 — AI Overviews "Expert Advice" quotes forum UGC directly — SURVIVED, ENCODED 2026-08-09

- **Claim**: AIO/AI Mode quote-preview module ("Expert Advice" is ONE of several
  query-dependent labels — also "Community Perspectives"/"Perspectives") previews
  verbatim quotes from forum/social UGC with creator attribution + source link.
- **Verification (2026-08-09 sweep)**: PRIMARY grade — Google's own announcement
  (blog.google "How AI Mode and AI Overviews help you explore the web", Hema Budaraju,
  2026-05-06; snippet-verified, direct fetch egress-blocked) + 4 independent same-day
  outlets (TechCrunch, Engadget, MacRumors, TechRadar) describing identical behavior.
  Production rollout, not a Labs test; no retirement coverage through 2026-08-09.
- **Where**: encoded at `build/geo-content-optimizer/references/ai-citation-patterns.md:476`
  (geo-content-optimizer 4.1.5) with the label-variability precision.
- **Remaining open leg**: rollout scope only — US/English-first is vendor-reported;
  el-GR availability unconfirmed and matters for Sani Hellas clients. The encoded tag's
  resolves-when: local read of the blog.google post AND/OR first el-GR SERP sighting.
- **Cadence**: el-GR scope-check at the next quarterly sweep or first client AIO
  sighting, whichever first.

## W8 — Plugin validator tolerance of extra manifest fields — RESOLVED 2026-08-08

- **Resolution** (G1 pilot run, `claude` CLI 2.1.226 present in the cloud environment):
  extra fields are TOLERATED as warnings and ignored at load time ("Unknown field …
  Claude Code ignores it at load time"; `id` "belongs in the marketplace entry"). The
  pilot's trim removed exactly those two warnings with zero new findings — official-
  validator confirmation of the G1 direction.
- **Remaining backlog surfaced** (pre-existing at HEAD, NOT pilot-caused): 3 strict
  errors — `hooks`/`commands`/`mcpServers` carry v3.0.0 object shapes the validator
  rejects — plus a `capabilities` unknown-field warning and a root-CLAUDE.md packaging
  warning. These define the full-migration scope and sit BEYOND G1's recorded scope;
  full migration is a separate Sani decision (see G1 pilot-result block).
- **Cadence**: closed; folds into the G1 continuation decision.

## W9 — Greek commerce-surface magnitudes (vendor cluster, 4 claims)

- **Where**: `research/serp-analysis/references/greek-shopping-surfaces.md:17` (SimilarWeb:
  BestPrice ~6.9M visits/mo, #1 in price-comparison *category*; Skroutz ~40.8M, Apr/Jun
  2026), `:30` (BestPrice ranking-effect magnitude — nothing published), `:45`
  (e-satisfaction claims 100+ Greek e-shop review clients, self-published);
  `references/greek-tourism-seasonality.md:24` (free-booking-link clicks −30% under DMA,
  vendor-reported).
- **Resolves when**: engine/primary or first-party data replaces the vendor figure (e.g.
  client Merchant Center/BestPrice merchant data; Google-primary DMA impact numbers).
  Until then: directional only, never client-facing as fact.
- **Cadence**: quarterly with the Skroutz cluster (W6); always before client-facing figures.

## W10 — el-GR feature mechanics — LSA leg RESOLVED-PRIMARY 2026-08-09 (owner read); inflection leg open

- **Where**: `research/serp-analysis/references/serp-feature-taxonomy.md:233` (LSA —
  resolved, tag dropped, serp-analysis 4.2.2);
  `research/keyword-research/references/greek-keyword-coverage.md:103`
  (SERP-distinctness magnitude of inflected forms per query class — the remaining
  open claim).
- **LSA resolution (2026-08-09)**: Sani opened the LSA getting-started page's country
  picker (support.google.com/localservices/answer/6224841) and confirmed in-session:
  "Greece not listed". Claim upgraded multi-vendor + official-domain-structural →
  owner-verified-primary; encoded at `:233` with a migration re-check note (LSA is
  migrating into Google Ads — US from 2026-08, non-US 2027; the page and picker may
  move, re-verify on migration only).
- **History**: the 2026-08-09 sweep had upgraded single-vendor → three unanimous
  vendor guides + Google's per-country help-variant structure; `support.google.com`
  egress-blocked from cloud (permanent) — Mode A held the tag until this owner read.
- **Inflection leg — resolves when**: el-GR SERP sampling at the first Greek keyword
  engagement (Sani local or client data).
- **Cadence**: LSA leg CLOSED (re-check on migration only); inflection on-use.

## W11 — Greek registry/compliance lookup specifics (7 claims)

- **Where**: `build/seo-content-writer/references/greek-ymyl-credentials.md` — six
  `[VERIFY at build time]` tags on lookup portal/search mechanics (ΠΙΣ + regional medical
  associations, bar associations, ΤΕΕ, ΟΕΕ incl. license classes, ΓΕΜΗ, other health
  bodies); `cross-cutting/domain-authority-auditor/references/greek-eshop-compliance.md:46`
  (exact statutory scope of the ΓΕΜΗ display obligation — a lawyer question by design).
- **Resolves when**: verified against the registries themselves at the first YMYL/e-shop
  client build (institutions' existence is settled; only mechanics/scope are open). The
  ΓΕΜΗ statutory question goes to the client's lawyer, never resolved in-repo.
- **Cadence**: on-use — before the first client deliverable that relies on them.

---

**Standing weekly discipline (not a register item)**: Google core/spam "update" chatter is
blog-only until the Search Status Dashboard confirms it (last confirmed core update:
2026-05-21 → 2026-06-02). Never encode chatter as fact.
