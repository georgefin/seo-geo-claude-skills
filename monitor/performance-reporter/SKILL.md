---
name: performance-reporter
version: "4.3.0"
description: 'Generate consolidated SEO and GEO performance dashboards combining rankings, traffic, backlinks, and AI visibility metrics for stakeholders. Use when the user asks to "generate SEO report", "performance report", "SEO dashboard", "report to stakeholders", "show me the numbers", "monthly SEO report", "traffic report", or "present SEO results to my boss". For detailed rank tracking, see rank-tracker. For link-specific analysis, see backlink-analyzer.'
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
    - performance report
    - seo report
    - traffic analysis
    - seo dashboard
    - executive summary
    - analytics report
    - kpi tracking
    - seo-reporting
    - kpi-dashboard
    - monthly-report
    - traffic-report
    - analytics-report
    - stakeholder-report
    - seo-metrics
    - organic-traffic
    - ctr-report
  triggers:
    - "generate SEO report"
    - "performance report"
    - "traffic report"
    - "SEO dashboard"
    - "report to stakeholders"
    - "monthly report"
    - "SEO analytics"
    - "show me the numbers"
    - "monthly SEO report"
    - "present SEO results to my boss"
---

# Performance Reporter


This skill creates comprehensive SEO and GEO performance reports that combine multiple metrics into actionable insights. It produces executive summaries, detailed analyses, and visual data presentations for stakeholder communication.

## When to Use This Skill

- Monthly/quarterly SEO reporting
- Executive stakeholder updates
- Client reporting for agencies
- Tracking campaign performance
- Combining multiple SEO metrics
- Creating GEO visibility reports
- Documenting ROI from SEO efforts

## What This Skill Does

1. **Data Aggregation**: Combines multiple SEO data sources
2. **Trend Analysis**: Identifies patterns across metrics
3. **Executive Summaries**: Creates high-level overviews
4. **Visual Reports**: Presents data in clear formats
5. **Benchmark Comparison**: Tracks against goals and competitors
6. **Content Quality Tracking**: Integrates CORE-EEAT scores across audited pages
7. **ROI Calculation**: Measures SEO investment returns
8. **Recommendations**: Suggests actions based on data

## How to Use

### Generate Performance Report

```
Create an SEO performance report for [domain] for [time period]
```

### Executive Summary

```
Generate an executive summary of SEO performance for [month/quarter]
```

### Specific Report Types

```
Create a GEO visibility report for [domain]
```

```
Generate a content performance report
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~analytics + ~~search console + ~~SEO tool + ~~AI monitor connected:**
Automatically aggregate traffic metrics from ~~analytics, search performance data from ~~search console, ranking and backlink data from ~~SEO tool, and GEO visibility metrics from ~~AI monitor. Creates comprehensive multi-source reports with historical trends.

**With manual data only:**
Ask the user to provide:
1. Analytics screenshots or traffic data export (sessions, users, conversions)
2. Search Console data (impressions, clicks, average position)
3. Keyword ranking data for the reporting period
4. Backlink metrics (referring domains, new/lost links)
5. Key performance indicators and goals for comparison
6. AI citation data if tracking GEO metrics

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests a performance report:

1. **Define Report Parameters** -- Domain, report period, comparison period, report type (Monthly/Quarterly/Annual), audience (Executive/Technical/Client), focus areas.

2. **Create Executive Summary** -- Overall performance rating, key wins/watch areas/action required, metrics at a glance table (traffic, rankings, conversions, DA, AI citations), SEO ROI calculation.

3. **Report Organic Traffic Performance** -- Traffic overview (sessions, users, pageviews, bounce rate), traffic trend visualization, traffic by source/device, top performing pages.

4. **Report Keyword Rankings** -- Rankings overview by position range, distribution change visualization, top improvements and declines, SERP feature performance.

   **Explaining a CTR or average-position move -- mix before mechanism.** Before offering any snippet, title, SERP-feature or AI-Overview explanation, test whether the aggregate moved against its own segments. Split clicks and impressions by segment (brand vs. non-brand at minimum, plus any newly launched cluster), compute each segment's **share of total impressions** in both periods, and state the shift in percentage points -- e.g. non-brand 40,000/50,000 = 80.0% to 61,000/70,000 = 87.1%, **+7.1 pp**. If every segment that existed in the prior period held or improved its CTR while the site-wide CTR fell, the cause is the impression mix and saying so *is* the finding; a "snippets got worse" diagnosis in that case contradicts the data in front of you. Average position needs the same test, because Search Console weights it by impressions -- a new cluster entering deep in the results raises the site-wide average without any existing ranking moving. Segment shares are reported as shares of **impressions**; a share of clicks answers a different question and does not substitute. Worked arithmetic in [references/kpi-definitions.md](./references/kpi-definitions.md) under "Aggregate vs. segment divergence".

5. **Report GEO/AI Performance** -- AI citation overview, citations by topic, GEO wins, optimization opportunities.

   **AI-referrals cut** -- Also report the traffic AI assistants actually send. Triangulate three sources: ~~analytics referral source/medium plus conversions (GA4), ~~search console AI-surface query/click data where the property exposes it, and server-log referrer + user-agent rows. Match referrers against the AI hostname roster in [references/kpi-definitions.md](./references/kpi-definitions.md) (operational config — it churns). Report four cuts: AI share of total sessions period-over-period (the headline), top AI-landing pages with sessions and conversion rate, the AI-vs-organic engagement/conversion gap for the same window, and GSC AI-surface corroboration. **Control rule**: any attribution claim needs a parallel holdout (an unchanged own page, a sibling URL, or a competitor) — report delta-vs-control, never a raw delta. **Caveat to state in the report**: AI referral traffic proves an AI answer *linked* the site, not that it cited it prominently — treat referrals as leads for citation checking, not citation proof. Label every figure per this skill's source discipline (tool-measured / user-provided / estimated).

6. **Report Domain Authority (CITE Score)** -- If a CITE audit has been run, include CITE dimension scores (C/I/T/E) with period-over-period trends and veto status. If no audit exists, note as "Not yet evaluated."

7. **Content Quality (CORE-EEAT Score)** -- If content-quality-auditor has been run, include average scores across all 8 CORE-EEAT dimensions with trends. If no audit exists, note as "Not yet evaluated."

8. **Report Backlink Performance** -- Link profile summary, weekly link acquisition, notable new links, competitive position.

9. **Report Content Performance** -- Publishing summary, top performing content, content needing attention, content ROI.

10. **Generate Recommendations** -- Immediate/short-term/long-term actions with priority, expected impact, and owner. Goals for next period.

11. **Compile to the Audience's Section Set** -- Assemble only the sections this report's audience actually receives, per the assembly table in [references/report-templates.md](./references/report-templates.md) §4: a CEO/board pack is the executive template alone (one page plus optional appendix, technical detail excluded); an agency client gets executive plus marketing sections 1-3 and 6; only a full-detail reader gets every section. Sections outside that audience's row are left out, not compressed into the pack. Whatever is assembled carries a table of contents and the appendix (data sources, methodology, glossary).

   > **Reference**: See [references/report-output-templates.md](./references/report-output-templates.md) for complete output templates for all 11 report sections, and [references/report-templates.md](./references/report-templates.md) §4 for which of them each audience gets.

### Figure Discipline

Three rules that bind every step above. The first two come from defects found in this
skill's own graded output, and both describe a number that is *traceable* but wrong about
where it came from — the reader can redo the arithmetic and still be misled about what it
means.

- **A benchmark is reproduced verbatim.** Any band, range or threshold attributed to this
  skill's references is quoted exactly as that reference states it -- re-read the line
  before typing it; never narrow, widen or round it in transit, and if the same band appears
  twice in one report the two statements must agree. Every figure derived from a band prints
  the arithmetic that produced it, multiplier included, so a reader can reconcile figure with
  band: "the 3-10% MoM band our KPI reference calls healthy gives 2,890 x 1.03 = 2,977 to
  2,890 x 1.10 = 3,179 for August", never a bare range whose lower bound reconstructs to a
  band nobody stated. A goal or proposal table is not an exemption -- a misquoted band is
  wrong wherever it is printed.
- **A counterfactual states the perturbation it assumes.** A sensitivity, small-base or
  "what if" figure names the exact change it models and is computed from that change: on
  15 → 20 sessions (+33.3%), "one session either way" means moving the base to 16 or 14,
  which gives +25.0% or +42.9% -- not "+20% or +47%", which is 3/15 and 7/15, a *two*-session
  move with the base frozen. If the named perturbation and the printed number do not
  reconcile, the number is not printed.
- **Every rate, ratio and rating shows its working where it is printed.** A percentage carries
  both counts (`34 of 78 queries = 43.6%`), a mean names what it averages and over how many
  items, an ROI prints its subtraction, and a word-rating -- Overall Performance, a status,
  a content-quality band -- prints the tally or the comparison that produced it. The rule is
  the placement as much as the arithmetic: a formula living in a reference file the client
  never opens does not make the figure in the report checkable. Two derivations that need
  saying out loud because both are routinely guessed wrong: **ROI** is
  `(revenue − investment) ÷ investment`, not revenue ÷ investment, which reads 100 points
  higher; and a **share** moves in percentage points, while the underlying count moves in
  percent -- 43.6% from 38.9% is +4.7 pp, not +12%.

## Validation Checkpoints

### Input Validation
- [ ] Reporting period clearly defined with comparison period
- [ ] All required data sources available or alternatives noted
- [ ] Target audience identified (executive/technical/client)
- [ ] Performance goals and KPIs established for benchmarking

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Trends include period-over-period comparisons
- [ ] Recommendations are specific, prioritized, and actionable
- [ ] Every band, range or threshold quoted from the references matches that reference exactly (checked against the line, not from memory), and every figure derived from one shows its multiplier
- [ ] Every sensitivity or counterfactual figure names the exact perturbation it assumes and reconciles with it
- [ ] Every rate, mean, ROI and word-rating in the report prints its derivation beside itself — both counts for a rate, the population for a mean, the subtraction for an ROI, the status tally for the Overall Performance rating — and each status follows the stated target bands (at or above target = On track · 90-99% = Watch · below 90% = Off track)
- [ ] Any aggregate that moved against its own segments (site-wide CTR, average position) is explained as a mix effect, with the impression-share shift stated in percentage points
- [ ] Sections included match the audience's row in report-templates.md §4 — a board pack is the executive template alone
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Google Analytics 4, Google Search Console, Ahrefs), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

**User**: "Create a monthly SEO report for cloudhosting.com for January 2025"

**Output** (abbreviated -- full report uses templates from all 11 steps):

```markdown
# CloudHosting SEO & GEO Performance Report — January 2025

## Executive Summary — Overall Performance: Good
_5 KPIs scored: 1 on track, 4 watch, 0 off track — no metric fell below 90% of its target._

| Metric | Jan 2025 | Dec 2024 | Change | Target | % of target | Status |
|--------|----------|----------|--------|--------|-------------|--------|
| Organic Traffic | 52,100 | 45,200 | +15.3% | 50,000 | 104.2% | On track |
| Keywords Top 10 | 87 | 79 | +8 | 90 | 96.7% | Watch |
| Organic Conversions | 684 | 612 | +11.8% | 700 | 97.7% | Watch |
| Domain Rating | 54 | 53 | +1 | 55 | 98.2% | Watch |
| AI Citations | 18 | 12 | +50.0% | 20 | 90.0% | Watch |

**SEO ROI**: ($41,000 organic revenue − $8,200 invested) ÷ $8,200 = **400%** for January

**Immediate**: Fix 37 crawl errors on /pricing/ pages
**This Month**: Optimize mobile LCP; publish 3 AI Overview comparison pages
**This Quarter**: Build Wikidata entry for CloudHost Inc.
```

## Tips for Success

1. **Lead with insights** - Start with what matters, not raw data
2. **Visualize data** - Charts and graphs improve comprehension
3. **Compare periods** - Context makes data meaningful
4. **Include actions** - Every report should drive decisions
5. **Customize for audience** - Executives need different info than technical teams
6. **Track GEO metrics** - AI visibility is increasingly important

## Reference Materials

- [Report Output Templates](./references/report-output-templates.md) — Complete output templates for all 11 report sections, including the search-performance segment block (4), the AI referral traffic cut (5b), and the client-read wording for the domain-authority and content-quality sections
- [KPI Definitions](./references/kpi-definitions.md) — SEO/GEO metric definitions with benchmarks, good ranges, warning thresholds, the rule for quoting a benchmark verbatim, mix-shift decomposition, small-base and counterfactual arithmetic, attribution guidance, and the AI referral KPI with its hostname roster
- [Report Templates by Audience](./references/report-templates.md) — Copy-ready templates for executive, marketing, technical, and client audiences, plus the §4 assembly table that decides which sections each audience receives

## Related Skills

- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Include CORE-EEAT scores as page-level content quality KPIs
- [domain-authority-auditor](../../cross-cutting/domain-authority-auditor/) — Include CITE score as a domain-level KPI in periodic reports
- [rank-tracker](../rank-tracker/) — Detailed ranking data
- [backlink-analyzer](../backlink-analyzer/) — Link profile data
- [alert-manager](../alert-manager/) — Set up report triggers
- [serp-analysis](../../research/serp-analysis/) — SERP composition data
- [memory-management](../../cross-cutting/memory-management/) — Archive reports in project memory
- [entity-optimizer](../../cross-cutting/entity-optimizer/) — Track branded search and Knowledge Panel metrics
- [technical-seo-checker](../../optimize/technical-seo-checker/) — Technical health data feeds into reports

