---
name: performance-reporter
version: "4.6.0"
description: 'Generate consolidated SEO and GEO performance dashboards combining rankings, traffic, backlinks, and AI visibility metrics for stakeholders. Use when the user asks to "generate SEO report", "performance report", "SEO dashboard", "report to stakeholders", "show me the numbers", "monthly SEO report", "traffic report", or "present SEO results to my boss". For detailed rank tracking, see rank-tracker. For link-specific analysis, see backlink-analyzer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.6.0"
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

5. **Report AI Visibility and GEO Performance** -- AI citation overview, citations by topic, GEO wins, optimization opportunities.

   **The unit is a prompt, not a keyword, and every figure names its engine.** A rank is an ordinal position in a list an engine assembles from an index; an AI answer is generated text that may name the brand without citing it, cite a page without naming the brand, or answer the same prompt differently twice in a minute. Five figures, each printing **N and its population beside itself** and each **reported per engine, never silently pooled** — pooling hides the engine that is failing: **mention rate** (captures naming the brand ÷ successful captures) · **citation rate** (captures citing any client URL ÷ successful captures, always beside mention rate and never instead of it) · **owned-URL citation rate** (captures citing the cluster's owning URL ÷ captures citing any client URL — a low figure against a high citation rate is the engine citing the wrong property of the client's, which is an ownership finding, not an AI one) · **average recommendation position** (mean over captures where a recommendation set existed; the denominator is recommendation answers only, and stating it over all captures is the standard error here) · **prompt-level share of voice** (client mentions ÷ client plus all named competitors' mentions, per cluster, with the competitor set named because it moves the denominator). **Mention, citation and recommendation are three facts and print as three lines** — merged into "AI visibility: present" the diagnosis is gone, and each of the three has a different fix. State the prompt-set version once per report: adding or rewording a prompt moves every rate with nothing having happened in the world. Definitions and formulas in [references/kpi-definitions.md](./references/kpi-definitions.md) §2, the report block in [references/report-output-templates.md](./references/report-output-templates.md) §5a, the fields and sampling protocol in [../../references/ai-visibility-measurement.md](../../references/ai-visibility-measurement.md).

   **One capture is an observation, not a measurement.** N >= 3 repeats per prompt per engine per cycle before any rate is printed as a rate; `k of N` (2 of 3) rather than a bare percentage off one run; a single capture reported with the word *observation* and its timestamp, never as what the engine does. Failed captures — a refusal, a rate limit, an empty response — are counted with their reason and reduce N; dropping them silently inflates every rate. A change between cycles is a candidate until it survives a second cycle.

   **No composite AI visibility score is computed here.** One number spanning engines, prompts and three different facts cannot be attributed when it moves and recovers no action, so this report defines none and blends none. Where a connected tool publishes its own composite, quote it with that tool's name attached, unchanged, and never recompute or merge it into a figure of ours.

   **AI-referrals cut** -- Also report the traffic AI assistants actually send. Triangulate three sources: ~~analytics referral source/medium plus conversions (GA4), ~~search console AI-surface query/click data where the property exposes it, and server-log referrer + user-agent rows. Match referrers against the AI hostname roster in [references/kpi-definitions.md](./references/kpi-definitions.md) (operational config — it churns). Report four cuts: AI share of total sessions period-over-period (the headline), top AI-landing pages with sessions and conversion rate, the AI-vs-organic engagement/conversion gap for the same window, and GSC AI-surface corroboration. **Control rule**: any attribution claim needs a parallel holdout (an unchanged own page, a sibling URL, or a competitor) — report delta-vs-control, never a raw delta. **Caveat to state in the report**: AI referral traffic proves an AI answer *linked* the site, not that it cited it prominently — treat referrals as leads for citation checking, not citation proof. Label every figure per this skill's source discipline (tool-measured / user-provided / estimated).

   **Every assistant-referral figure is a floor, and is labelled as one.** Identification by referrer host is **partial by construction**: some surfaces send no referrer, some strip it, and some of that traffic arrives as direct. So the count is a lower bound and reads as one — "at least 340 sessions from assistant referrers in the 28-day window; the true figure is higher by an unmeasured amount" — never "340 sessions came from AI answers", which states a total the method cannot produce. The floor label travels with the share too: a share computed from a floor numerator is itself a floor. **Any link to conversions is stated as correlation inside a named window** — "the 41 conversions on those pages fell in the same 28-day window as the referral sessions" — never as causation, and never as a per-mention value: there is no "each mention is worth EUR X" line in this report, because nothing in this method measures one. Full statement in [../../references/ai-visibility-measurement.md](../../references/ai-visibility-measurement.md) §5.1.

6. **Report Domain Authority (CITE Score)** -- If a CITE audit has been run, include CITE dimension scores (C/I/T/E) with period-over-period trends and veto status. If no audit exists, note as "Not yet evaluated."

7. **Content Quality (CORE-EEAT Score)** -- If content-quality-auditor has been run, include average scores across all 8 CORE-EEAT dimensions with trends. If no audit exists, note as "Not yet evaluated."

8. **Report Backlink Performance** -- Link profile summary, weekly link acquisition, notable new links, competitive position.

9. **Report Content Performance** -- Publishing summary, top performing content, content needing attention, content ROI.

10. **Generate Recommendations** -- Immediate/short-term/long-term actions with priority, expected impact, and owner. Goals for next period.

    **Seven fields per action, and three of them are not optional.** Every recommendation this report emits carries **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**, laid out as seven columns or, where the surface is too narrow, as a labelled block per action with the same seven fields. Action, owner and acceptance criterion are **required**: a recommendation with no owner-role and nothing checkable is a suggestion, and suggestions do not get done. The remaining four carry a **stated-absence value** where no answer exists — `not estimated — no baseline data` for impact, `not estimated` for effort, `none` for dependencies, `low — reversible, no downstream effect` for risk — never a blank and never an invented figure, because the absence is itself a finding the client can close. Ordering is by **expected impact ÷ effort with dependencies respected** (an action whose dependency is unmet sorts below the thing it waits on, whatever its score), and the ordering rule is stated once in the report rather than left implied. The priority band already computed above is the band used; no second priority vocabulary is invented beside it. Field table, worked criteria and the role list: [../../references/action-output-contract.md](../../references/action-output-contract.md); the seven-column report block: [references/report-output-templates.md](./references/report-output-templates.md) §10.

    **The owner is a role, not a person** — `Content` · `SEO/technical` · `Developer` · `Designer` · `Product/merchandising` · `Customer service` · `Legal/compliance` · `Agency` · `Client decision` — with a name beside the role where the client has supplied names. `Client decision` **is** an owner and is the right one for anything the agency cannot decide (which property owns a cluster, whether a page goes live, what a price is); assigning it makes the decision visible instead of leaving the row stalled with no explanation. `unassigned — needs an owner` is a legitimate value and a finding — it surfaces work with nowhere to go, which is more useful than a plausible guess nobody actually owns — and it is never used to dodge an obvious assignment.

    **The acceptance criterion is what makes the row checkable**: observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered. The test is whether someone who was not part of this engagement could check it six weeks from now without asking anybody what was meant — "the intro is rewritten and live on the named category URL, its meta description is 140-158 characters, and both are verified on the production URL", not "page is better optimised". **An AI-surface criterion is a measurement criterion, never an outcome criterion**: "the rewrite is live and mention rate is re-measured on the same 3-repeat protocol and recorded beside the 17 Aug baseline with its N" is deliverable; "the brand appears in the assistant's answer" is not in anyone's gift, and writing it turns the action into a promise.

    **Priority and horizon are two columns, not one.** Actions are graded **P0 · P1 · P2 · P3** — the library's scheme, and the one [references/kpi-definitions.md](./references/kpi-definitions.md) already promises this report's readers ("Action Items — P0-P3 prioritized task list"). A Priority column holds a P-level and nothing else. *When* the work is booked is the other axis, carried by the section heading (Immediate / Short-term / Long-term) and by any deadline column; a schedule word — "Planned", "Backlog", "Q2" — is never a priority. Default pairing: **P0** starts before anything else, today when the damage is live (manual action, deindexation, outage, security) · **P1** this week or the current sprint · **P2** this month · **P3** this quarter or the backlog. A row booked past the end of its priority's default horizon states the reason in the same line; earlier than default needs no note. Converting a report that graded High / Medium / Planned: **High → P1 · Medium → P2 · Planned → P3**, section headings unchanged — those three words were fixed per section, so the column only restated its own heading. Full rule, the "no action" convention, and why `alert-manager`'s identical P-names carry much shorter clocks: [references/report-output-templates.md](./references/report-output-templates.md) §10.

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

### What This Report Never Promises

**No section of this report promises a position, a citation, an inclusion, a recommendation, or
a share of voice on any search or AI surface, on any timeline** — not in the executive summary,
not in Goals for Next Period, and not in an action's expected impact. No engine publishes its
citation criteria, none guarantees determinism, and none offers a submission path that binds it,
so a promise here is a claim about a mechanism nobody has documented rather than optimism. What
this report states instead: the **mechanism being worked**, labelled as a working model; a
**leading indicator with a measurement plan** ("mention rate across 3 repeats on 40 prompts,
monthly, from this baseline"); the **baseline itself, dated, with its N**; and **comparable
evidence** with its own limits named. The same bar governs a Goals table — a target is a target,
written as one, not a commitment that an engine will do something. This is FAIL-grade family 10
in `build/seo-content-writer/references/anti-slop-ruleset.md` §6, and it is distinct from family
9: family 9 bans asserting what an engine *does*, family 10 bans promising what an engine *will
do for this client*, and a report can violate either one alone.

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
- [ ] Every rate, mean, ROI and word-rating in the report prints its derivation beside itself — both counts for a rate, the population for a mean, the subtraction for an ROI, the status tally for the Overall Performance rating — and each KPI status follows the stated target bands (at or above target = On track · 90-99% = Watch · below 90% = Off track)
- [ ] Every action is graded P0-P3 in every table — never High / Medium / Planned, never a schedule word in a Priority column, and a row with no work reads "no action —" plus the reason; any deadline later than its priority's default horizon states why in the same line
- [ ] Technical Status words (Normal / Monitor / Investigate) read the movement band, not the KPI target bands, and print the comparison behind them — a published band quoted with its own window, or the site's observed variation with the span it was measured over, or no word at all where neither exists
- [ ] Any aggregate that moved against its own segments (site-wide CTR, average position) is explained as a mix effect, with the impression-share shift stated in percentage points
- [ ] Every AI visibility figure names its engine and prints N with its population beside it (`mention rate 62% — 23 of 37 successful captures, 13 prompts × 3 repeats, 2 failed captures excluded from N`); nothing is pooled across engines without saying so; the prompt-set version is stated once in the report
- [ ] Mention, citation and recommendation appear as three separate figures and are never merged into one verdict; owned-URL citation rate is reported beside citation rate; average recommendation position is computed over recommendation answers only and says so; any single capture carries the word *observation* and its timestamp
- [ ] No composite AI visibility score appears anywhere in the report — none is defined, computed or blended. A connected tool's own composite is quoted with that tool's name attached and left unrecomputed
- [ ] Every assistant-referral figure is labelled a floor ("at least N sessions in the window; the true figure is higher by an unmeasured amount"), the floor label travels to any share derived from it, and any conversion link is stated as correlation inside a named window — never causally, never as a per-mention value
- [ ] Every recommendation carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with stated-absence values (`unassigned — needs an owner`, `not estimated — no baseline data`, `none`) where an answer does not exist; no action ships without an owner-role and an acceptance criterion; the ordering rule is stated once
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — and no criterion requires an engine to do something: an AI-surface criterion names the work shipped plus the re-measurement recorded beside its baseline
- [ ] Nothing in the report — summary, goals, expected impact, next steps — promises a position, citation, inclusion, recommendation or share of voice on any surface, on any timeline (anti-slop-ruleset.md §6 family 10)
- [ ] Sections included match the audience's row in report-templates.md §4 — a board pack is the executive template alone
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Google Analytics 4, Google Search Console, Ahrefs), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

**User**: "Create a monthly SEO report for cloudhosting.example for January 2025"

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

## AI Visibility — prompt set v3 (36 prompts), captured 3–5 Jan, 3 repeats per prompt per engine

| Engine | Mention rate | Citation rate | Owned-URL citation rate | Avg. recommendation position | Share of voice |
|--------|--------------|---------------|-------------------------|------------------------------|----------------|
| ChatGPT Search | 58% (62 of 107 successful captures; 1 refusal logged, excluded from N) | 21% (22 of 107) | 64% (14 of 22 cited captures) | 2.8 (mean of 19 recommendation answers) | 24% (62 of 258 mentions) |
| Google AI surfaces | 41% (44 of 108) | 33% (36 of 108) | 39% (14 of 36 cited captures) | 3.4 (mean of 12 recommendation answers) | 18% (44 of 244 mentions) |
| Perplexity | 47% (51 of 108) | 44% (48 of 108) | 71% (34 of 48 cited captures) | no recommendation set in any of the 108 captures — no position to average | 21% (51 of 243 mentions) |

Share of voice counts the client against three competitors named in the answers: Hostplex, NimbusHost, Rackfleet. The three engines are reported separately and not pooled — on Google AI surfaces the comparison page was cited instead of the product page in 22 of 36 cited captures, which is a different problem from ChatGPT's lower citation rate and has a different fix. No single AI visibility number is reported, because one figure across three engines and three different facts cannot be traced back to either.

**AI referral traffic**: at least 310 sessions from assistant referrers in January; the true figure is higher by an unmeasured amount, since some surfaces send no referrer and that traffic arrives as direct. The 24 conversions on those landing pages fall inside the same January window — stated as a correlation with the window named, not as a value per answer.

## Recommendations — ordered by expected impact ÷ effort, with dependencies respected

| Priority | Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
|---|---|---|---|---|---|---|---|
| P1 | Fix the 37 crawl errors on the /pricing/ pages | Developer (Marta R.) | All 37 URLs return 200 and show as indexed in Search Console; re-crawl export attached, by 24 Jan | Those 37 URLs carried 2,100 impressions in the 28 days before they broke — restoring them recovers that surface. From the January export | S — one developer day | Staging access | low — reversible, no downstream effect |
| P2 | Rewrite the /pricing/ intro so the first paragraph answers "how much for 10 seats" | Content | New intro live on /pricing/; mention rate for the 9 pricing prompts re-measured on the same 3-repeat protocol and recorded beside the January baseline with its N, by 28 Feb | Working model, not documented engine behaviour: an explicit price-band sentence in the opening paragraph is directly liftable by an assistant | M | Price band signed off | low — reversible |
| P3 | Decide which property owns the "managed hosting" cluster | Client decision | One property and one URL recorded as the owner in the ownership register, dated and signed off | not estimated — no baseline data | not estimated | none | Medium — assigning it to a property with no checkout moves the work away from the conversion path |
```

## Tips for Success

1. **Lead with insights** - Start with what matters, not raw data
2. **Visualize data** - Charts and graphs improve comprehension
3. **Compare periods** - Context makes data meaningful
4. **Include actions** - Every report should drive decisions
5. **Customize for audience** - Executives need different info than technical teams
6. **Track GEO metrics** - AI visibility is increasingly important

## Reference Materials

- [Report Output Templates](./references/report-output-templates.md) — Complete output templates for all 11 report sections, including the search-performance segment block (4), the AI referral traffic cut (5b), the client-read wording for the domain-authority and content-quality sections, and the P0-P3 action-priority scheme with its priority-to-horizon map (10)
- [KPI Definitions](./references/kpi-definitions.md) — SEO/GEO metric definitions with benchmarks, good ranges, warning thresholds, the rule for quoting a benchmark verbatim, mix-shift decomposition, small-base and counterfactual arithmetic, attribution guidance, and the AI referral KPI with its hostname roster
- [Report Templates by Audience](./references/report-templates.md) — Copy-ready templates for executive, marketing, technical, and client audiences, the movement-band rule for the technical Status words (Normal / Monitor / Investigate), plus the §4 assembly table that decides which sections each audience receives
- [AI Visibility Measurement](../../references/ai-visibility-measurement.md) — library-wide: the prompt as the unit, the twelve recorded fields, engine precedence, the N >= 3 sampling protocol, the derived metrics with their population rules, the conversion-linkage limits (§5.1), and what may never be promised (§7)
- [Action Output Contract](../../references/action-output-contract.md) — library-wide: the seven fields with their stated-absence values, the acceptance-criterion test with worked examples, the owner-role list, the three permitted shapes of expected impact, and the ordering rule

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

