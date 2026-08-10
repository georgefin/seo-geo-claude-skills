# Settled Rulings — SEO/GEO Research Baseline

Decisions the weekly skill-update-check must NOT relitigate without **new primary evidence**
(engine-official or Google-official documentation — never blog/vendor claims). If superseding
primary evidence appears, do not edit here directly: label it a **"supersession candidate for
Sani's gate"** in the weekly report and route it through `GATED-ITEMS.md`.

All five rulings were baked into the v1 routine prompt (created 2026-07-18) and re-affirmed by
the 2026-08-08 sweep ("no new evidence found this cycle — all stand"). Origin decision dates
before 2026-07-18 are not recoverable from the current session transcript.

**Last review: 2026-08-08** (weekly sweep, all rulings stand)

---

## R1 — llms.txt is a dead lever

- **Statement**: Do not add an `llms.txt` file expecting AI-citation gains; no engine is
  confirmed honoring it.
- **Decided**: on/before 2026-07-18 (in v1 routine prompt); re-affirmed 2026-08-08.
- **Evidence**: No engine-official adoption found; absence re-confirmed each weekly sweep.
- **Encoded in repo**: `build/geo-content-optimizer/SKILL.md:159`;
  `build/geo-content-optimizer/references/ai-citation-patterns.md:478`; `VERSIONS.md:159` ("non-levers")
  (pointers refreshed 2026-08-09 — 4.1.5 module insertion + v4.3.1 changelog shifted both;
  VERSIONS pointer re-refreshed 2026-08-10, +2 from the seo-content-writer 4.2.5 bullet,
  then +2 again from the entity-optimizer 4.1.5 / backlink-analyzer 4.0.4 bullet).
- **Reopens on**: engine-official (Google/OpenAI/Perplexity) primary documentation of
  llms.txt ingestion.

## R2 — Schema-stacking is not an AI-citation lever

- **Statement**: Piling multiple schema types on a page adds no citation signal. One accurate
  JSON-LD type per page (CORE-EEAT item O05) is enough.
- **Decided**: on/before 2026-07-18; re-affirmed 2026-08-08.
- **Boundary (clarified 2026-08-08 — precision, not reversal)**: R2 bans *citation-lever
  stacking*: adding schema types on the theory that more types raise AI-citation odds. It
  does NOT ban multi-type markup where each extra type has its own engine-documented,
  non-citation job. Concretely: (a) one PRIMARY content type per page (O05) remains the
  rule; (b) documented auxiliary types alongside it are legitimate — BreadcrumbList
  (Google-documented site-structure feature), Organization/Person nested as
  publisher/author identity, WebSite on the homepage; (c) a second full content type on
  the same page (e.g., FAQPage bolted onto a service page, Article + Product both as
  primaries) IS stacking and stays banned — unless the page genuinely is both things and
  each type is complete, accurate, and independently justified. Skill text and references
  must teach this boundary, not the pre-clarification "pile types" pattern.
- **Encoded in repo**: `build/geo-content-optimizer/SKILL.md:159`;
  `build/geo-content-optimizer/references/ai-citation-patterns.md:478`; `VERSIONS.md:159` ("non-levers")
  (pointers refreshed 2026-08-09, same shift as R1; VERSIONS pointer re-refreshed twice on
  2026-08-10, same two changelog insertions as R1);
  boundary alignment in `build/schema-markup-generator/` v4.1.0 (2026-08-08 wave).
- **Reopens on**: primary evidence (Google/engine docs or engine-published research) that
  multiple types per page raise citation odds.

## R3 — FAQPage schema is KEPT despite Google rich-result retirement

- **Statement**: Google retired FAQ rich results in 2026 (Search Console reporting, API,
  Enhancements appearance filter, and Rich Results Test support all cut) — but FAQPage
  generation stays in the library. Its value is AI-engine/GEO parsing, not SERP monitoring.
- **Decided**: 2026-08-08 sweep (retirement reflected in schema-markup-generator 4.0.1).
- **Encoded in repo**: `build/schema-markup-generator/SKILL.md:223`; `VERSIONS.md:163`
  ("schema-markup-generator 4.0.1" — anchor-tagged per F12; on any line/token
  mismatch, grep the token — the token is authoritative; VERSIONS pointer refreshed
  2026-08-10, +2 from the entity-optimizer 4.1.5 / backlink-analyzer 4.0.4 bullet).
- **Reopens on**: schema.org deprecating the FAQPage type itself, or primary evidence that
  AI engines stopped parsing it.

## R4 — Core Web Vitals "Good" = LCP 2.5s / INP 200ms / CLS 0.1; FID is dead

- **Statement**: Thresholds remain LCP ≤2.5s, INP ≤200ms, CLS ≤0.1. FID retired 03-2024
  (INP-only). The circulating "2.0s LCP" figure is vendor-blog, not Google.
- **Decided**: on/before 2026-07-18; FID cleanup applied 2026-08-08
  (technical-seo-checker 4.0.1).
- **Encoded in repo**: `monitor/performance-reporter/references/kpi-definitions.md:298-304`
  (pointer refreshed 2026-08-08 after the AI-referrals insertion shifted the table);
  `VERSIONS.md:164` ("technical-seo-checker 4.0.1", anchor-tagged per F12 — token
  authoritative on mismatch; refreshed 2026-08-10, +2 from the entity-optimizer 4.1.5 /
  backlink-analyzer 4.0.4 bullet); `optimize/technical-seo-checker/SKILL.md:259`
  (pointer refreshed 2026-08-09 — an E3 Mode A round found :258 resolving to a
  blank line, a pointer class check (g) does not cover; previously refreshed
  2026-08-08 after the labels wave; FID rows also purged from that skill's two
  reference files the same day — the 4.0.1 cleanup had missed them).
- **Reopens on**: Google-primary threshold change only (web.dev / Google Search Central).

## R5 — Unlinked brand mentions are a GEO/entity visibility signal

- **Statement**: Unlinked brand mentions count as an entity/GEO visibility signal and are
  scored (CITE item I09).
- **Decided**: on/before 2026-07-18 (I09 dates to CITE v2.0.0, 2026-02-08); re-affirmed
  2026-08-08 ("no Google-primary contradiction; not reopened").
- **Encoded in repo**: `references/cite-domain-rating.md:309-310` (scoring),
  `references/cite-domain-rating.md:447` (I09 measurement).
- **Reopens on**: Google-official primary evidence only — explicitly **not** blog evidence.

---

## Pinned baselines (drift watch — not rulings)

Last-known-verified states the weekly sweep uses as cheap change-detectors. Drift here is a
FINDING to report (and this section is then updated via normal PR — facts, not decisions, so
no gate needed).

| Baseline | Last verified state | As of |
|---|---|---|
| schema.org release | v30.0 | 2026-03-19 |
| Google Search Quality Rater Guidelines | last known active version dated 2025-09-11 | 2026-08-08 |
| Google AI Mode in Greek | live since 2025-10-08 (`VERSIONS.md:159` ("non-levers")) | 2026-08-09 |
| awesome-generative-engine-optimization (GitHub) | last commit 2026-04-14 (quiet) | 2026-08-08 |
| RSI paper baseline | MetaSkill-Evolve arXiv 2607.05297 · RSI survey arXiv 2607.07663 · AREX arXiv 2607.21461 ("AREX: Towards a Recursively Self-Improving Agent for Deep Research", BAAI, v1/v2 — existence confirmed 2026-08-08, see W1) · PAST-Bench arXiv 2608.04003 | 2026-08-08 |
| Skill-loop literature (2026-08-08 assessment additions) | GRASP arXiv 2605.29668 · SEA-Eval arXiv 2604.08988 · feedback-dynamics arXiv 2608.02636 · OpenSkillEval arXiv 2605.23657 (titles search-verified; contents beyond abstracts [VERIFY]) | 2026-08-08 |
| Last confirmed Google core update | 2026-05-21 → 2026-06-02 (Search Status Dashboard) | 2026-08-08 |

---

*Change protocol: edits to the rulings above land only via a gated PR after Sani's verdict;
each edit updates "Last review" and cites the superseding primary source with its date.
Pinned-baseline rows update via normal PR whenever the weekly sweep verifies a change.*
