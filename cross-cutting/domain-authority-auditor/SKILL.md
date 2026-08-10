---
name: domain-authority-auditor
version: "4.3.0"
description: 'Run the full 40-item CITE domain authority audit across 4 dimensions with domain-type weighting and veto checks. Use when the user asks to "audit domain authority", "domain trust score", "CITE audit", "how authoritative is my site", "domain credibility check", "is my domain trustworthy", "domain credibility score", "domain rating". For content-level assessment, see content-quality-auditor. For link profile details, see backlink-analyzer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.0"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - domain audit
    - credibility
    - domain scoring
    - domain-authority
    - domain-rating
    - domain-trust
    - trust-signals
    - site-authority
    - da-checker
    - ahrefs-dr
    - moz-da
    - cite-framework
    - domain-strength
  triggers:
    - "audit domain authority"
    - "domain trust score"
    - "CITE audit"
    - "how authoritative is my site"
    - "domain credibility check"
    - "domain rating"
    - "site authority"
    - "is my domain trustworthy"
    - "domain credibility score"
---

# Domain Authority Auditor

> Based on [CITE Domain Rating](https://github.com/aaron-he-zhu/cite-domain-rating). Full benchmark reference: [references/cite-domain-rating.md](../../references/cite-domain-rating.md)

This skill evaluates domain authority across 40 standardized criteria organized in 4 dimensions. It produces a comprehensive audit report with per-item scoring, dimension and weighted scores by domain type, veto item checks, and a prioritized action plan.

**Sister skill**: [content-quality-auditor](../content-quality-auditor/) evaluates content at the page level (80 items). This skill evaluates the domain behind the content (40 items). Together they provide a complete 120-item assessment.

> **Namespace note**: CITE uses C01-C10 for Citation items; CORE-EEAT uses C01-C10 for Contextual Clarity items — and the two frameworks also share E and T. Every item ID carries its own hyphenated framework-first prefix, in a combined 120-item assessment and in any handoff payload alike: `CITE-C01` vs `CORE-EEAT-C01`, `CITE-T09`, `CORE-EEAT-R02`. One form, one prefix per framework — see [inter-skill-handoff.md § 2.3](../../references/inter-skill-handoff.md).

## When to Use This Skill

- Evaluating domain authority before a GEO campaign
- Benchmarking your domain against competitors
- Assessing whether a domain is trustworthy as a citation source
- Running periodic domain health checks or after link building campaigns
- Identifying manipulation red flags (PBNs, link farms, penalty history)
- Cross-referencing with content-quality-auditor for full 120-item assessment

## What This Skill Does

1. **Full 40-Item Audit**: Scores every CITE check item as Pass/Partial/Fail
2. **Dimension Scoring**: Calculates scores for all 4 dimensions (0-100 each)
3. **Weighted Totals**: Applies domain-type-specific weights for CITE Score
4. **Veto Detection**: Flags critical manipulation signals (T03, T05, T09)
5. **Priority Ranking**: Identifies Top 5 improvements sorted by impact
6. **Action Plan**: Generates specific, actionable improvement steps
7. **Cross-Reference**: Optionally pairs with CORE-EEAT for combined diagnosis

## How to Use

### Audit Your Domain

```
Audit domain authority for [domain]
Run a CITE domain audit on [domain] as a [domain type]
```

### Audit with Domain Type

```
CITE audit for example.com as an e-commerce site
Score this SaaS domain against the 40-item benchmark: [domain]
```

### Comparative Audit

```
Compare domain authority: [your domain] vs [competitor 1] vs [competitor 2]
```

### Combined Assessment

```
Run full 120-item assessment on [domain]: CITE domain audit + CORE-EEAT content audit on [sample pages]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

**With ~~link database + ~~SEO tool + ~~AI monitor + ~~knowledge graph + ~~brand monitor connected:**
Automatically pull backlink profiles and link quality metrics from ~~link database, domain authority scores and keyword rankings from ~~SEO tool, AI citation data from ~~AI monitor, entity presence from ~~knowledge graph, and brand mention data from ~~brand monitor.

**With manual data only:**
Ask the user to provide:
1. Domain to evaluate
2. Domain type (if not auto-detectable): Content Publisher, Product & Service, E-commerce, Community & UGC, Tool & Utility, or Authority & Institutional
3. Backlink data: referring domains count, domain authority, top linking domains
4. Traffic estimates (from any SEO tool or SimilarWeb)
5. Competitor domains for comparison (optional)

Proceed with the full 40-item audit using provided data. Note in the output which items could not be fully evaluated due to missing access (e.g., AI citation data, knowledge graph queries, WHOIS history).

## Instructions

When a user requests a domain authority audit:

### Finding Format & Confidence Labels

Findings surface in two places — per-item **Notes** and the **Top 5 Priority
Improvements**. Report each with **Finding** (the item and what falls short), **Evidence**
(the observed data behind the score), **Impact** (weighted points at stake), and **Fix**
(the concrete action), plus a **Confidence** label:

- **Confirmed** — directly observed in provided data or crawl output
- **Likely** — strong indirect evidence (e.g., a consistent pattern across sampled pages or tool exports)
- **Hypothesis** — plausible but needs verification (e.g., anything inferred without crawl/tool access)

**Rule**: every Hypothesis finding must name what would confirm it (the specific tool,
query, or data source). Items that cannot be evaluated at all stay "N/A — requires [data
source]" (see Step 3) — do not downgrade them into Hypothesis scores.

### Step 1: Preparation

```markdown
### Audit Setup

**Domain**: [domain]
**Domain Type**: [auto-detected or user-specified]
**Dimension Weights**: [from domain-type weight table below]

#### Domain-Type Weight Table

> Canonical source: `references/cite-domain-rating.md`. This inline copy is for convenience.

| Dim | Default | Content Publisher | Product & Service | E-commerce | Community & UGC | Tool & Utility | Authority & Institutional |
|-----|:-------:|:-:|:-:|:-:|:-:|:-:|:-:|
| C | 35% | **40%** | 25% | 20% | 35% | 25% | **45%** |
| I | 20% | 15% | **30%** | 20% | 10% | **30%** | 20% |
| T | 25% | 20% | 25% | **35%** | 25% | 25% | 20% |
| E | 20% | 25% | 20% | 25% | **30%** | 20% | 15% |

#### Veto Check (Emergency Brake)

| Veto Item | Status | Action |
|-----------|--------|--------|
| T03: Link-Traffic Coherence | ✅ Pass / ⚠️ VETO | [If VETO: "Audit backlink profile; disavow toxic links"] |
| T05: Backlink Profile Uniqueness | ✅ Pass / ⚠️ VETO | [If VETO: "Flag as manipulation network; investigate link sources"] |
| T09: Penalty & Deindex History | ✅ Pass / ⚠️ VETO | [If VETO: "Address penalty first; all other optimization is futile"] |
```

If any veto item triggers, flag it prominently at the top of the report. CITE Score is capped at 39 (Poor) regardless of other scores.

### Step 2: C + I Audit (20 items)

Evaluate each item against the criteria in [references/cite-domain-rating.md](../../references/cite-domain-rating.md).

Score each item:
- **Pass** = 10 points (fully meets criteria)
- **Partial** = 5 points (partially meets criteria)
- **Fail** = 0 points (does not meet criteria)

**A dimension score is the sum of that dimension's ten item points** — so with all ten items
scored it is always a multiple of 5 (N/A items rescale it; see Step 3). Publish the tally
beside the score so a reader can check it. If tally and score disagree, the item table is
right and the sentence is wrong: recount before publishing.

```markdown
### C — Citation

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| C01 | Referring Domains Volume | Pass/Partial/Fail | [specific observation] |
| C02 | Referring Domains Quality | Pass/Partial/Fail | [specific observation] |
| ... | ... | ... | ... |
| C10 | Link Source Diversity | Pass/Partial/Fail | [specific observation] |

**C Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)

### I — Identity

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| I01 | Knowledge Graph Presence | Pass/Partial/Fail | [specific observation] |
| ... | ... | ... | ... |

**I Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)
```

### Step 3: T + E Audit (20 items)

Same format for Trust and Eminence dimensions.

```markdown
### T — Trust

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| T01 | Link Profile Naturalness | Pass/Partial/Fail | [specific observation] |
| ... | ... | ... | ... |

**T Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)

### E — Eminence

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| E01 | Organic Search Visibility | Pass/Partial/Fail | [specific observation] |
| ... | ... | ... | ... |

**E Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)
```

**Note**: Some items require specialized data (C05-C08 AI citation data, I01 knowledge graph queries, T04-T05 IP/profile analysis). Score what is observable; mark unverifiable items as "N/A — requires [data source]" and exclude from dimension average.

Excluded means the denominator shrinks, never that the item scores 0: **dimension score =
points earned ÷ (10 × scored items) × 100**. State the denominator beside the score —
`C Score: 58/100 — 35 pts over 6 scored items; C05-C08 N/A`. Worked N/A cases:
[references/score-arithmetic.md](./references/score-arithmetic.md).

**Greek e-commerce domains**: apply the supplementary trust/staleness checks in [references/greek-eshop-compliance.md](./references/greek-eshop-compliance.md) when scoring T06, T08, and T10 (stale ODR link, ΓΕΜΗ/ΑΦΜ and entity transparency, withdrawal/returns and policy furniture). These are audit signals only — never legal advice; compliance conclusions go to the client's lawyer.

### Step 4: Scoring & Report

**Derived figures — recompute every one before you publish.** Any number not copied from the
input is derived from the report's own per-item grades and stated weights: dimension scores,
the weighted CITE Score, item tallies, points-scored/points-lost sums, Top 5 potential gains,
and any "what the score would be if X" projection. Three rules carry most of the defects:

1. **A count matches the list it names** — "the four C Partials (C04, C05, C06, C07, C09)"
   is wrong: five IDs, called four. Count the IDs you just typed.
2. **A total equals its parts** — points scored + points lost = points available; a combined
   gain claim equals the sum of the gains it aggregates; a projected range equals the
   difference of its own two endpoints.
3. **The tables win** — if a sentence disagrees with the table above it, fix the sentence.

Formulas, N/A rescaling, veto-cap handling, and worked gain/projection examples:
[references/score-arithmetic.md](./references/score-arithmetic.md).

Calculate scores and generate the final report:

```markdown
## CITE Domain Authority Report

### Overview

- **Domain**: [domain]
- **Domain Type**: [type]
- **Audit Date**: [date]
- **CITE Score**: [score]/100 ([rating])
- **Veto Status**: ✅ No triggers / ⚠️ [item] triggered — Score capped at 39

### Dimension Scores

| Dimension | Score | Items (Pass/Partial/Fail) | Rating | Weight | Weighted |
|-----------|-------|:-------------------------:|--------|--------|----------|
| C — Citation | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| I — Identity | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| T — Trust | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| E — Eminence | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| **CITE Score** | | | | | **[X]/100** |

**Score Calculation**: CITE Score = C × [w_C] + I × [w_I] + T × [w_T] + E × [w_E] = [each product] = [unrounded sum] → **[rounded]/100** (one decimal, half up; the rating label follows the rounded number)

**Rating Scale**: 90-100 Excellent | 75-89 Good | 60-74 Medium | 40-59 Low | 0-39 Poor

### Per-Item Scores

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| C01 | Referring Domains Volume | [Pass/Partial/Fail] | [observation] |
| C02 | Referring Domains Quality | [Pass/Partial/Fail] | [observation] |
| ... | ... | ... | ... |
| E10 | Industry Share of Voice | [Pass/Partial/Fail] | [observation] |

### Top 5 Priority Improvements

Sorted by: weight × points lost (highest impact first). Potential gain = recoverable points
(10 from Fail, 5 from Partial) × that dimension's weight — show the multiplication.

1. **[ID] [Name]** — [specific modification suggestion]
   - Current: [Fail/Partial] | Potential gain: [10 or 5] × [dim weight] = [X] weighted points
   - Evidence: [observed data behind the score] | Confidence: [Confirmed/Likely/Hypothesis — if Hypothesis, name what would confirm it]
   - Action: [concrete step]
2. **[ID] [Name]** — [specific modification suggestion]
   - Current: [Fail/Partial] | Potential gain: [10 or 5] × [dim weight] = [X] weighted points
   - Evidence: [observed data behind the score] | Confidence: [Confirmed/Likely/Hypothesis — if Hypothesis, name what would confirm it]
   - Action: [concrete step]
3–5. [Same format]

### Action Plan

#### Quick Wins (< 1 week)
- [ ] [Action 1]
- [ ] [Action 2]
#### Medium Effort (1-4 weeks)
- [ ] [Action 3]
- [ ] [Action 4]
#### Strategic (1-3 months)
- [ ] [Action 5]
- [ ] [Action 6]

### Cross-Reference with CORE-EEAT

For a complete assessment, pair this CITE audit with a CORE-EEAT content audit:

| Assessment | Score | Rating |
|-----------|-------|--------|
| CITE (Domain) | [X]/100 | [rating] |
| CORE-EEAT (Content) | [X]/100 — or "Not yet evaluated" where no content audit has been run | [rating] |

**Diagnosis Matrix**:
- High CITE + High CORE-EEAT → Maintain and expand
- High CITE + Low CORE-EEAT → Prioritize content quality
- Low CITE + High CORE-EEAT → Build domain authority
- Low CITE + Low CORE-EEAT → Start with content, then domain
```

The client's report ends there. Follow-up runs — a content audit on key pages, a backlink deep-dive, competitor benchmarking, trend tracking — go in a **separate fence of their own**, carrying the label **inside** the fence, because a model copies the fence and not the heading above it (`CLAUDE.md` § The Value Rule, clause 2). Block shape: [references/example-report.md](./references/example-report.md). Payload fields, the hyphenated framework-first ID form, and the drop-and-name rule for a field you cannot source: [inter-skill-handoff.md § 2–3](../../references/inter-skill-handoff.md). Each row carries the domain and its domain type, the `CITE C:… I:… T:… E:…` string with its veto status and audit date, the priority item IDs, and the pages to audit where the next run is page-level.

## Validation Checkpoints

### Input Validation
- [ ] Domain identified and accessible
- [ ] Domain type confirmed (auto-detected or user-specified)
- [ ] Backlink data available (at minimum: referring domains count, DA/DR)
- [ ] If comparative audit, competitor domains also specified

### Output Validation
- [ ] All 40 items scored (or marked N/A with reason)
- [ ] All 4 dimension scores calculated correctly — each equals its own item tally (N/A items rescale the denominator, they never score 0)
- [ ] Weighted CITE Score matches domain-type weight configuration, shown unrounded then rounded
- [ ] Every other derived figure (item tallies, points-lost sums, potential gains, projections) recomputes from the report's own tables, and every stated count matches the number of items it enumerates
- [ ] All 3 veto items checked first and flagged if triggered
- [ ] Top 5 improvements sorted by weighted impact, not arbitrary
- [ ] Every recommendation is specific and actionable (not generic advice)
- [ ] Every finding carries a Confidence label (Confirmed / Likely / Hypothesis); Hypothesis findings name what would confirm them
- [ ] Action plan includes concrete steps with effort estimates
- [ ] The follow-up-run block is a separate fence carrying `<!-- OPERATOR BLOCK … -->` as its first line, and no skill slug, command slug or item ID appears inside the client report fence — a reader who copies only that fence must be able to tell it is not for the client

## Example

See [references/example-report.md](./references/example-report.md) for a complete CITE audit of cloudhosting.com showing veto check, dimension scores, top 5 improvements, action plan, and cross-reference with CORE-EEAT.

## Tips for Success

1. **Start with veto items** — T03, T05, T09 can invalidate the entire score
2. **Identify domain type first** — Different types have very different weight profiles
3. **AI citation items (C05-C08) matter most for GEO** — Test by querying AI engines with niche-relevant questions
4. **Some items need specialized tools** — Knowledge graph queries, AI citation monitoring, and IP diversity analysis may require manual research if tools aren't connected
5. **Pair with CORE-EEAT for full picture** — Domain authority without content quality (or vice versa) tells only half the story

## Reference Materials

- [CITE Domain Rating](../../references/cite-domain-rating.md) — Full 40-item benchmark with dimension definitions, scoring criteria, domain-type weight tables, and veto items
- [references/score-arithmetic.md](./references/score-arithmetic.md) — How every derived figure is composed: dimension tallies, N/A rescaling, the weighted total and its rounding, veto-cap presentation, potential-gain and projection formulas, plus the pre-send recompute pass
- [references/example-report.md](./references/example-report.md) — Complete CITE audit example with scored dimensions, top 5 improvements, action plan, and CORE-EEAT cross-reference
- [references/greek-eshop-compliance.md](./references/greek-eshop-compliance.md) — Greek e-shop trust/compliance audit items mapped onto `CITE-T06` / `CITE-T08` / `CITE-T10` (stale ODR link, ΓΕΜΗ/ΑΦΜ transparency, withdrawal/returns and policy furniture) — audit signals, not legal advice
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — the payload every follow-up-run row passes to the run it names, the label-inside-the-fence rule for an operator block, the hyphenated framework-first item-ID form, and the drop-and-name rule for an unavailable field

## Related Skills

- [content-quality-auditor](../content-quality-auditor/) — Page-level content audit (CORE-EEAT 80 items) — the sister skill
- [backlink-analyzer](../../monitor/backlink-analyzer/) — Deep-dive into backlink profile (feeds C dimension data)
- [competitor-analysis](../../research/competitor-analysis/) — Compare CITE scores across competitors
- [performance-reporter](../../monitor/performance-reporter/) — Track CITE score trends over time
- [entity-optimizer](../entity-optimizer/) — Entity presence audit; complements CITE I dimension
