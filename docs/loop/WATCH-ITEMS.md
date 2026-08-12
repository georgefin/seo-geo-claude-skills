# Watch-Item Register — the [VERIFY] Queue

Claims carried in skills (or in the research baseline) with explicit uncertainty markers.
A watch-item is **directional guidance, never fact**, until resolved by a dated primary
source. Tag variants in files: `[VERIFY]`, `[VERIFY – …]`, `[VERIFY, directional]` —
grep with `\[VERIFY` (not `\[VERIFY\]`) to find all of them.

Weekly DETECT runs re-check items at their cadence and report deltas; resolution edits
(dropping a tag, revising a claim) go through normal PR flow.

**Last full inventory: 2026-08-09 (post W5+W10 closures; recount post-E1 suites)** —
55 matching lines in 14 repo files (`grep -rc '\[VERIFY' research build optimize
monitor cross-cutting references VERSIONS.md`); +2 vs the post-closure count are
bookkeeping guard-references in `build/seo-content-writer/evals/evals.json`
(`262e46a`), not claim tags. Delta vs the same-day post-wave count (53 in 15): −2 claim tags (W5
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
- **Where**: `build/geo-content-optimizer/SKILL.md:143` ("Per-Engine Reality Check");
  `build/geo-content-optimizer/references/ai-citation-patterns.md:482-485`
  ("Perplexity domain overlap") — the two magnitudes themselves;
  `build/geo-content-optimizer/references/ai-citation-patterns.md:489`
  ("Community channel");
  `build/geo-content-optimizer/references/ai-citation-patterns.md:511`
  ("Community threads (Reddit, niche forums) that engines cite").
  All anchor-tagged per F12 — token authoritative on mismatch. The 2026-08-09 refresh
  was correct as of `6033c39`; re-resolved 2026-08-12 after the block shifted again
  (+15 lines on the first three loci, +20 on the last), which had left the SKILL.md
  pointer on a blank line at :140 and :467-470,474 on engine-comparison table rows —
  written here without backticked paths so they stay history, not pointers. Split out of the
  old multi-part list because check (g) verifies `file:N` and `file:N-M` only.
- **Partial corroboration 2026-08-09 (W7 lane)**: the community-citation CHANNEL is now
  Google-primary — the 2026-05-06 quote-preview module announcement, encoded at
  `build/geo-content-optimizer/references/ai-citation-patterns.md:491`
  ("AIO/AI Mode quote-preview module"). Bare basename given its repo path,
  anchor-tagged and re-resolved from :476 on 2026-08-12. The ~11% overlap and ≈40%
  share MAGNITUDES remain the open claims; their tags are unchanged and this item
  stays open for them alone.
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
- **Where**: `build/seo-content-writer/SKILL.md:277` ("semantic collapse") — anchor-tagged 2026-08-12 per F12; pointer refreshed 2026-08-10 after the 4.2.5 connector-rule insertion; previously 2026-08-08 after the anti-slop wave.
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
  suspension. Encoded at `cross-cutting/entity-optimizer/SKILL.md:187`
  ("Google review-solicitation policy") — anchor-tagged per F12, re-resolved
  2026-08-12 from :185, which is the adjacent mention-counting note
  (entity-optimizer 4.1.3, tag dropped; wording corrected to evidence-exact in
  4.1.4 after the close-out review). The business/answer/7400114 same-text
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
- **Where**: encoded at `build/geo-content-optimizer/references/ai-citation-patterns.md:491`
  ("AIO/AI Mode quote-preview module") with the label-variability precision
  (geo-content-optimizer 4.1.5). Anchor-tagged per F12 and re-resolved 2026-08-12 from
  :476, which post-4.1.5 insertions turned into the comparison table's source note.
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
- **Addendum 2026-08-09**: G1 continuation approved and executed (v4.4.0) — the
  3 strict errors resolved by the manifest migration; the root-CLAUDE.md
  packaging warning remains as the recorded, accepted residual (see the G1
  execution note in GATED-ITEMS).

## W9 — Greek commerce-surface magnitudes (vendor cluster, 4 claims)

- **Where**: `research/serp-analysis/references/greek-shopping-surfaces.md:17`
  ("BestPrice.gr ~6.9M visits/month") — SimilarWeb: BestPrice ~6.9M visits/mo, #1 in
  price-comparison *category*; Skroutz ~40.8M, Apr/Jun 2026 — plus `:30` (BestPrice
  ranking-effect magnitude — nothing published) and `:45`
  (e-satisfaction claims 100+ Greek e-shop review clients, self-published);
  `research/serp-analysis/references/greek-tourism-seasonality.md:24`
  ("Free-booking-link clicks reportedly down ~30%") — under DMA, vendor-reported.
  Both anchor-tagged 2026-08-12 per F12; the tourism pointer's bare `references/…`
  prefix resolved to no file and now carries its repo path.
- **Resolves when**: engine/primary or first-party data replaces the vendor figure (e.g.
  client Merchant Center/BestPrice merchant data; Google-primary DMA impact numbers).
  Until then: directional only, never client-facing as fact.
- **Cadence**: quarterly with the Skroutz cluster (W6); always before client-facing figures.

## W10 — el-GR feature mechanics — LSA leg RESOLVED-PRIMARY 2026-08-09 (owner read); inflection leg open

- **Where**: `research/serp-analysis/references/serp-feature-taxonomy.md:233`
  ("Local Services Ads (LSA") — LSA resolved, tag dropped, serp-analysis 4.2.2;
  `research/keyword-research/references/greek-keyword-coverage.md:103`
  ("SERP-distinctness magnitude per query class") — the remaining open claim.
  Both anchor-tagged 2026-08-12 per F12.
- **LSA resolution (2026-08-09)**: Sani opened the LSA getting-started page's country
  picker (support.google.com/localservices/answer/6224841) and confirmed in-session:
  "Greece not listed". Claim upgraded multi-vendor + official-domain-structural →
  owner-verified-primary; encoded at `:233` with a migration re-check note (LSA is
  migrating into Google Ads — reported timeline: US from 2026-08, non-US 2027; the
  page and picker may move, re-verify on migration only).
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
  ("scope of the display obligation") — the exact statutory scope of the ΓΕΜΗ display
  obligation, a lawyer question by design; anchor-tagged 2026-08-12 per F12.
- **Resolves when**: verified against the registries themselves at the first YMYL/e-shop
  client build (institutions' existence is settled; only mechanics/scope are open). The
  ΓΕΜΗ statutory question goes to the client's lawyer, never resolved in-repo.
- **Cadence**: on-use — before the first client deliverable that relies on them.

## W12 — HowTo rich results: current Google support — RESOLVED-PRIMARY 2026-08-11 (owner read)

- **Where**: `research/serp-analysis/references/serp-feature-taxonomy.md:30`
  ("How-To, Review Stars, Recipe") — the Rich Results row, plus the How-To playbook
  rows ~:291;
  `research/content-gap-analysis/references/gap-analysis-frameworks.md:161`
  ("Step-by-step tutorials");
  `build/meta-tags-optimizer/references/ctr-and-social-reference.md:155`
  ("promise no How-to appearance"). All three anchor-tagged 2026-08-12 per F12, the
  last two re-resolved from :150 (a table separator) and :121 (a blank line). As read
  on 2026-08-09 all three still taught HowTo rich results as a current SERP feature;
  on the 2026-08-12 re-read the ctr-and-social locus is already hedged by the 4.2.0
  rewrite (`[VERIFY]`-tagged, "promise no How-to appearance"), so the live purge scope [obs:2026-08-12 re-read of the three loci]
  is the first two. Surfaced 2026-08-09 by
  the R3-purge implementer as an out-of-scope observation: training-knowledge
  signal that Google deprecated HowTo rich results in 2023.
  **Historical, as recorded 2026-08-09 and superseded by the verification bullet
  below**: at that point no ruling covered it and no dated primary source was on
  file — **historical** "signal only, not encodable".
- **Verification (2026-08-10 lane, ahead of the scheduled sweep)**: the signal is
  CORROBORATED at primary-domain snippet grade — the same grade W5/W7 were accepted
  on. Source: `https://developers.google.com/search/blog/2023/08/howto-faq-changes`
  ("Changes to HowTo and FAQ rich results", Google Search Central Blog,
  2023-08-08). Returned wording: HowTo rich results *"will only be shown for desktop
  users, and not for users on mobile devices"*; then the same post's September
  update, *"As of September 13, Google Search no longer shows How-to rich results on
  desktop"*, with the How-to search appearance, rich result report and Rich Results
  Test support dropped in 30 days and Search Console API support at 180 days.
  **Grade caveat**: WebFetch is egress-restricted for `developers.google.com`, so
  the quotes are search-index returns over the primary domain, not owner-read
  verbatim; the year on the "As of September 13" note is contextually 2023 but not
  independently pinned. Full lane record: the coordinator's 2026-08-10 research
  transcription (scratchpad `research-r3-faq-timeline.md`).
- **OWNER READ — 2026-08-11, grade caveat DISCHARGED, `[VERIFY]` tag dropped per the
  W5/W10 pattern.** Fetched from `GIORGOSs-Mac-Studio` (no egress proxy),
  `HTTP 200`, 619,516 B. Both caveats above are answered: the quotes are now
  **owner-read verbatim**, not search-index returns, and **the year is pinned by the
  page itself** — the update is headed *"Update on September 14, 2023"*. Full
  verbatim passage, its raw-HTML container, and the effect on 9b:
  `docs/loop/pilot/g9-owner-read-CORRECTION-2026-08-11.md`. The operative sentence,
  owner-read: *"As of September 13, Google Search no longer shows How-to rich results
  on desktop, **which means this result type is now deprecated.**"*
- **⚠️ W12 was right and two owner reads regressed against it.** This entry recorded
  the September update at snippet grade on 2026-08-10. Two later reads of the same URL
  — one from the "Custom 1" cloud environment, one from a local machine, different
  networks and clients — **both missed it** and both concluded that 2023 only
  restricted HowTo to desktop. Cause: both extracted the article *body* and dropped
  `<aside>`, and the update lives in `<aside class="important">`. Convergence between
  independent readers is not corroboration when they share a method — it re-measures
  the method's blind spot. Proposed rule (unnumbered, for the coordinator) in §4 of
  the correction file: when establishing current/deprecated/withdrawn status, never
  strip `aside`/`callout`/`banner`/`admonition`/`note` containers, and grep raw HTML
  for `update|deprecat|no longer|sunset|retired` before concluding.
- **Status**: resolve-condition MET **and owner read COMPLETE**. The ruling draft +
  purge is still routed to Sani as **G9** rather than applied here — creating a ruling
  is gate-class, and a library-wide purge is Sani's call regardless of evidence grade.
  The evidence objection that held 9b is now gone; the gate itself is still Sani's [obs: G9 unresolved in `docs/loop/GATED-ITEMS.md` as of 2026-08-11].
  The E2–E5 eval suites are unaffected: every one was authored to assert nothing
  about HowTo either way, which is what the [VERIFY] tag was for.
- **Resolves when**: Sani's verdict on G9. If retirement is ruled: ruling drafted,
  purge executed, and the check (f) token row ships in the same wave (F9-r2
  backfill rule).
- **Cadence**: next weekly research sweep (2026-08-15 solo fire) — DETECT lane, if
  G9 has not been decided by then.

## W13 — Does an installed plugin carry root `CLAUDE.md`? [VERIFY]

- **Where**: root `CLAUDE.md:36` ("When a skill recommends running another") — the
  inter-skill handoff convention, and by the same
  mechanism every other standing ruling recorded there. Opened by ledger **F17**
  (2026-08-10), which stands on its own without this question: the convention names no
  shipped carrier, while `CLAUDE.md`'s two other standing rulings both do.
- **The question**: whether a session that installs this plugin from a marketplace or a
  directory source has root `CLAUDE.md` in its context. The repo records a strict-validator
  **root-CLAUDE.md packaging warning** as an accepted residual (`GATED-ITEMS.md` G1, :284),
  which is the reason to ask; that warning is recorded fact, the inference from it is not.
- **Why it cannot be settled by the eval sweep**: every run in the 20-suite blind wave
  executed inside this repository, where `CLAUDE.md` auto-loads. For any rule stated only
  there, a blind run scores it carried and cannot do otherwise. The method's coverage of
  this class is zero, in both directions.
- **Status**: unprobed, asserted nowhere. FLIP: W13 -- none
- **Resolves when**: someone installs the plugin from a directory source into a scratch
  session and reports whether the handoff convention text is present in that session's
  context. One probe, one answer, no research lane needed.
- **Cadence**: next weekly sweep (2026-08-15 solo fire) if not answered before.

## W14 — CTR benchmark tables: position curve and per-vertical bands [VERIFY]

- **Where**: THREE carriers, all found on 2026-08-10, each by a different agent that did not
  know about the others:
  1. `build/meta-tags-optimizer/references/meta-tag-formulas.md:210-219`
     ("No source is on file for any figure in this section") — the position-by-CTR
     curve and the per-vertical CTR bands. Tagged in place during the meta-tags-optimizer 4.2.0
     wave by the implementer, which flagged that opening a `[VERIFY]` without a register row
     leaves it where the weekly sweep does not read — the same shape as F17. This row closes that.
  2. `optimize/content-refresher/references/content-decay-signals.md:47-55`
     ("Expected CTR by position") — a position-CTR
     curve, reframed as an illustrative shape rather than a benchmark, with quoting it to a
     client forbidden at the point of use.
  3. `monitor/rank-tracker/references/tracking-setup-guide.md` — the position-versus-traffic
     click-loss table, tagged in place; the row strings its eval suite quotes are byte-identical
     after tagging.
  **That three independent skills carried the same unsourced curve is the finding, not an
  aside.** A figure this widely circulated arrives in a library by many doors at once, so
  resolving it in one file resolves nothing — this row exists so the sweep checks all three.
- **The question**: these figures carry no citation here and none anywhere in the repository
  (grepped 2026-08-10; **no external search was made**, which is stated so the gap is not read
  as a negative finding). They are plausible and widely circulated, and that is exactly what
  makes them the kind of number this library has twice found to be wrong in transit.
- **Why they were left intact rather than removed**, unlike the CTR effect sizes fixed in the
  same wave: those four surfaces **contradicted each other**, so no source was needed to know
  something was wrong. These do not contradict anything. Deleting a figure nobody has sourced is
  a different act from deleting figures that disagree, and the second needs evidence the first
  does not.
- **Status**: tagged in place, not quoted to clients, superseded in practice by the site's own
  Search Console curve wherever one exists. FLIP: W14 -- none
- **Resolves when**: a named study with a year and a sample size is on file, or the figures are
  replaced by measured client data. Either resolves it; neither is urgent while the skill
  instructs the reader to prefer their own curve.
- **Cadence**: next weekly sweep (2026-08-15 solo fire), or on first use in a client build.

---

**Standing weekly discipline (not a register item)**: Google core/spam "update" chatter is
blog-only until the Search Status Dashboard confirms it (last confirmed core update:
2026-05-21 → 2026-06-02). Never encode chatter as fact.
