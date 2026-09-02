# Client Mandate — scope of record

**Stated by Sani, 2026-08-17.** This file is the authoritative record of what the library is being
built for, the measured audit of what it already encoded when the mandate was stated, and the
encode status of each addition. It exists because "is this already in our tasks?" is a question
that deserves a measurement rather than a recollection, and because a scope statement that lives
only in a conversation is a scope statement the next wave cannot check itself against.

**This is an operator register.** Run handles, skill slugs, framework item IDs, ruling IDs and repo
paths are all correct here.

---

## 1. The mandate, as stated

### Primary goals

- Improve qualified brand visibility in ChatGPT Search and Gemini.
- Track and improve citations, recommendations, and source visibility in Perplexity and Google AI
  surfaces.
- Target Greek-language users in Greece **and** English-speaking residents, visitors, investors and
  international buyers in Greece.
- Work across a main brand website and multiple microsites, each with a distinct commercial
  purpose, audience, and query ownership.

### Priority order

1. ChatGPT Search
2. Gemini and Google AI surfaces
3. Perplexity
4. Google organic SEO as the technical and authority foundation
5. Other AI engines as monitored channels

### Operating rules

1. Use Greek and English research when relevant.
2. Separate facts from assumptions and cite sources.
3. Never promise fixed AI-engine rankings.
4. Treat AI visibility as **prompt-level** — brand mentions, recommendation position, citations,
   cited URLs, competitors, sentiment, conversion impact.
5. Do not recommend spam, fake reviews, doorway pages, duplicate microsites, manipulative links,
   fabricated citations, or hidden content.
6. Assign one primary domain and URL to each query cluster to prevent cross-site cannibalization.
7. Ensure content claims have evidence, dates, primary sources, and clear ownership.
8. Keep outputs implementation-ready — prioritized actions, owners, acceptance criteria, expected
   impact, risk, dependencies.
9. Ask clarifying questions whenever business context is missing.
10. Use Dropbox materials, Notion work items, GA4 data, and Peec AI exports/API outputs as evidence
    when available.

---

## 2. The coverage audit, 2026-08-17

Measured by grep over non-eval skill and reference surfaces before anything was written. Counts are
files, not occurrences. The audit's purpose was to avoid re-specifying what the library already had
and to avoid claiming coverage it did not have.

### 2.1 Already encoded — not re-specified

| Mandate item | Measured state |
|---|---|
| ChatGPT | 11 files |
| Perplexity | 11 files |
| AI Overview / AI Mode | 29 files |
| Gemini | 5 files |
| Copilot | 4 files |
| Brand mentions as a signal | 10 files, plus settled ruling **R5** (unlinked mentions are a GEO/entity visibility signal, scored as `CITE-I09`) |
| Sentiment | A scored framework item — `CITE-C08` Citation Sentiment, ≥80% of citations in positive/neutral context — plus `alert-manager`'s Negative Mention alert |
| Greek + English audiences | `research/keyword-research/references/greek-keyword-coverage.md` form (d), "EN equivalent — serves bilingual, expat, or international" |
| Facts vs assumptions, cite sources, evidence/dates/primary sources | The most heavily encoded area in the library — the statistics rule, evidence grades, `[VERIFY]` tags, and ruling R3 with amendment 9a |
| Risk in outputs | 27 files |
| Dependencies in outputs | 9 files |
| Expected impact in outputs | 6 files |
| GA4 | 11 files |
| Ask clarifying questions | 9 files |
| AI-referral → conversion | `monitor/performance-reporter/` AI-referrals cut |

**Operating rules 1, 2, 7 and 9 were already satisfied** and required no new work. Engine
*coverage* was broad before the mandate; what follows is what coverage did not include.

### 2.2 Measured absent

Each returned zero matches, or only false positives, at audit time.

| # | Absent item | Measured |
|---|---|---|
| 1 | Prompt-level tracking | **0.** `monitor/rank-tracker/` returned nothing for "prompt" — the library tracked keyword rankings only |
| 2 | One primary domain + URL per query cluster | **0** for query ownership. Cannibalization appeared in 3–4 scattered places (a duplicate-title check, a decay signal, a KPI footnote), never as a governing assignment rule |
| 3 | Microsite / multi-property architecture | **0** for "microsite" |
| 4 | Engine priority order | **0.** `geo-content-optimizer` carried a per-engine item map with no precedence |
| 5 | "Never promise fixed AI-engine rankings" | **1**, a false positive about backlink profiles. Adjacent to ruling R3 amendment 9a but distinct: 9a governs *mechanism* claims, this governs *outcome promises to a client* |
| 6 | Recommendation position | **0** |
| 7 | Cited URL as a tracked field | **1**, a passing line in an example report — not a field anything recorded |
| 8 | Acceptance criteria; named owners in output | **0** each |
| 9 | Spam / doorway / fake-review / hidden-content prohibitions | Essentially absent — one Google review-solicitation policy note in `entity-optimizer` |
| 10 | Notion, Dropbox, Peec AI as evidence sources | **0**, **0**, and **1** false positive on Greek text |

**The pilot had already hit items 2 and 3 in practice before the mandate stated them** — finding
121 records six properties and four URL grammars, finding 122 records five URLs serving one
identical title. The lane could describe them and could not judge them, because no rule assigned
ownership. That is the clearest evidence in the register that the gap was real rather than
theoretical.

---

## 3. Encode status

All ten landed 2026-08-17 in one wave. Carriers below are the shipped statement; `CLAUDE.md`
sections are the binding rule.

| # | Item | Carrier | Binding rule |
|---|---|---|---|
| 1 | Prompt-level measurement | `references/ai-visibility-measurement.md` | `CLAUDE.md` § AI Visibility Is Measured at the Prompt |
| 4 | Engine precedence | same, §2 | same, rule 4 |
| 6 | Recommendation position | same, §3 field 4 | same, rule 2 |
| 7 | Cited URLs, verbatim | same, §3 field 5 | same, rule 2 |
| 2 | One owner per cluster | `references/query-cluster-ownership.md` | `CLAUDE.md` § One Owner Per Cluster |
| 3 | Property roles / microsites | same, §4 | same, rule 3 |
| 8 | Seven-field action contract | `references/action-output-contract.md` | `CLAUDE.md` § Every Action Is Implementable |
| 9 | Prohibited tactics | `references/prohibited-tactics.md` | `CLAUDE.md` § Prohibited Tactics |
| 5 | No fixed-ranking promises | `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 10 | same |
| 10 | Connector categories | `CONNECTORS.md` — `~~work tracker`, `~~doc store`, Peec AI added to `~~AI monitor` | — |

### 3.1 Two design decisions worth recording

**Engine precedence rank 4 carries an explicit anti-misreading clause.** Google organic sits fourth
in a *prompt-level* ordering because prompts are not the instrument that measures it. Every surface
carrying the order also states that rank 4 is a different instrument, not a lower priority — the
crawl, index, authority and technical work it needs is the substrate the three prompt-level
surfaces draw on. Without that clause the table reads as a deprioritisation of the foundation the
mandate itself calls a foundation.

**Family 10 is separate from family 9, not an extension of it.** Family 9 bans asserting what an
engine *does*; family 10 bans promising a client what an engine *will do for them*. A deliverable
can violate either alone, and collapsing them would have left the client-facing half unenforced —
which is exactly the state the audit found (item 5: one hit, a false positive).

---

## 4. What the mandate does not settle

Open, and needing Sani rather than a further wave:

- **The cluster→property assignments themselves.** The rule and the register format ship; the
  actual assignment of the client's clusters across the main site and the four brand microsites is
  a commercial decision, not a derivable one (`references/query-cluster-ownership.md` §6.1 states
  the tie-breakers a proposal would use).
- **The prompt set.** Its first version needs the client's real buyer questions, which are the
  highest-yield source and the one no tool supplies.
- **What Peec AI can export, and over what date range** — this decides whether the pilot gets a
  measured GEO baseline or an observational one.
- **The alert thresholds** in `docs/loop/decisions/alert-thresholds-proposal-2026-08-17.md`, still a
  proposal.
- **Page URL list** for the two pilot clusters, and the publisher/approval channel/capture method
  for anything that would be published.

Nothing in this wave publishes to any production site, and no page is published without a
per-change approval naming the pages.
