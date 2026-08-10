---
name: rank-tracker
version: "4.1.2"
description: 'Track keyword ranking positions and SERP position changes over time in both traditional search and AI-generated responses. Use when the user asks to "track rankings", "check keyword positions", "monitor SERP positions", "how am I ranking", "where do I rank for this keyword", "did my rankings change", "ranking changes", or "keyword position tracking". For automated alerting, see alert-manager. For comprehensive reports, see performance-reporter.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.1.2"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - rank tracking
    - keyword positions
    - serp monitoring
    - ranking trends
    - position tracking
    - ai ranking
    - keyword-rankings
    - position-tracking
    - ranking-changes
    - serp-positions
    - search-visibility
    - ranking-drops
    - ranking-improvements
    - rank-monitoring
  triggers:
    - "track rankings"
    - "check keyword positions"
    - "ranking changes"
    - "monitor SERP positions"
    - "how am I ranking"
    - "keyword tracking"
    - "position monitoring"
    - "where do I rank for this keyword"
    - "did my rankings change"
    - "keyword position tracking"
---

# Rank Tracker


Tracks, analyzes, and reports on keyword ranking positions over time. Monitors both traditional SERP rankings and AI/GEO visibility to provide comprehensive search performance insights.

## When to Use This Skill

- Setting up ranking tracking for new campaigns
- Monitoring keyword position changes
- Analyzing ranking trends over time
- Comparing rankings against competitors
- Tracking SERP feature appearances
- Monitoring AI Overview inclusions
- Creating ranking reports for stakeholders

## What This Skill Does

1. **Position Tracking**: Records and tracks keyword rankings
2. **Trend Analysis**: Identifies ranking patterns over time
3. **Movement Detection**: Flags significant position changes
4. **Competitor Comparison**: Benchmarks against competitors
5. **SERP Feature Tracking**: Monitors featured snippets, PAA
6. **GEO Visibility Tracking**: Tracks AI citation appearances
7. **Report Generation**: Creates ranking performance reports
8. **Striking-Distance Mining**: Surfaces the tracked property's own GSC queries at positions 5-20 as push targets

## How to Use

### Set Up Tracking

```
Set up rank tracking for [domain] targeting these keywords: [keyword list]
```

### Analyze Rankings

```
Analyze ranking changes for [domain] over the past [time period]
```

### Compare to Competitors

```
Compare my rankings to [competitor] for [keywords]
```

### Generate Reports

```
Create a ranking report for [domain/campaign]
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~search console + ~~analytics + ~~AI monitor connected:**
Automatically pull ranking positions from ~~SEO tool, search impressions/clicks from ~~search console, traffic data from ~~analytics, and AI Overview citation tracking from ~~AI monitor. Daily automated rank checks with historical trend data.

**With manual data only:**
Ask the user to provide:
1. Keyword ranking positions (current and historical if available)
2. Target keyword list with search volumes
3. Competitor domains and their ranking positions for key terms
4. SERP feature status (featured snippets, PAA appearances)
5. AI Overview citation data (if tracking GEO metrics)

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests rank tracking or analysis:

1. **Set Up Keyword Tracking** -- Configure domain, location, device, language, update frequency. Add keywords with volume, current rank, type, and priority. Set up competitor tracking and keyword categories (brand/product/informational/commercial).

   **Tracking artifact (persistence contract)** -- Every run produces a dated ranking snapshot: one row per keyword with keyword, position, ranking URL, SERP features, check date, and data source (~~SEO tool, ~~search console, or user-provided). If [memory-management](../../cross-cutting/memory-management/) is active, hand the snapshot to it (hot-cache summary + dated snapshot in cold storage, per its conventions). Otherwise, save the snapshot to a file and confirm the location with the user. On every subsequent run, read the prior snapshot first -- it is the baseline for all change calculations.

2. **Mine Striking-Distance Queries (own GSC data)** -- When ~~search console is connected (or the user exports its query report), pull the tracked property's queries sitting at average positions ~5-20: the page-one tail plus page two, where demand is already proven and one push can move real clicks. Use this GSC-derived list first, before third-party rank data, whenever it is available. API mechanic: the Search Analytics API returns rows sorted by clicks and offers no position filter -- request a high rowLimit and filter the 5-20 window client-side; label the resulting metrics tool-measured. Prioritize by Opportunity = (Volume × Intent Value) / Difficulty where those inputs exist; when volume/difficulty are unavailable (manual tier), degrade gracefully to Impressions × Position Gap (position gap = current average position minus 1). Skip queries below an impression floor -- default 50 impressions in the pull window, a house default to tune per site (upstream defines none). Append the mined rows to the dated snapshot from step 1's persistence contract, and hand queries whose ranking URL needs content work to [content-refresher](../../optimize/content-refresher/) as refresh targets. Boundary: this step only re-reads the tracked property's own Search Console data for positions it already holds -- discovering *new* keywords stays with [keyword-research](../../research/keyword-research/).

   > **Reference**: See [references/tracking-setup-guide.md](./references/tracking-setup-guide.md) Section 9 for the full mining methodology, defaults, and output format.

3. **Record Current Rankings** -- Ranking overview by position range (#1, #2-3, #4-10, #11-20, etc.), position distribution visualization, detailed rankings with URL, SERP features, and change.

4. **Analyze Ranking Changes** -- Overall movement metrics, biggest improvements and declines with hypothesized causes, recommended recovery actions, stable keywords, new rankings, lost rankings.

5. **Track SERP Features** -- Feature ownership comparison vs competitors (snippets, PAA, image/video pack, local pack), featured snippet status, PAA appearances.

6. **Track GEO/AI Visibility** -- AI Overview presence per keyword, citation rate and position, GEO performance trend over time, improvement opportunities.

7. **Compare Against Competitors** -- Share of voice table, head-to-head comparison per keyword, competitor movement alerts with threat level.

8. **Generate Ranking Report** -- Executive summary with overall trend, position distribution, key highlights (wins/concerns/opportunities), detailed analysis, SERP feature report, GEO visibility, competitive position, recommendations.

   > **Reference**: See [references/ranking-analysis-templates.md](./references/ranking-analysis-templates.md) for complete output templates for the seven core steps (setup, snapshot, change analysis, SERP features, GEO visibility, competitor comparison, report); the mining step's output format lives in the tracking setup guide.

## Validation Checkpoints

### Input Validation
- [ ] Keywords list is complete with search volumes
- [ ] Target domain and tracking location are specified
- [ ] Competitor domains identified for comparison
- [ ] Historical baseline data available or initial tracking period set

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Ranking changes include context (vs. previous period)
- [ ] Significant movements have explanations or investigation notes
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Google Search Console), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

**User**: "Analyze my ranking changes for the past month"

**Output**:

```markdown
# Ranking Analysis: [current month, year]

## Summary

Your average position improved from 15.3 to 12.8 (-2.5 positions = better)
Keywords in top 10 increased from 12 to 17 (+5)

## Biggest Wins

| Keyword | Old | New | Change | Possible Cause |
|---------|-----|-----|--------|----------------|
| email marketing tips | 18 | 5 | +13 | Likely driven by content refresh |
| best crm software | 24 | 11 | +13 | Correlates with new backlinks acquired |
| sales automation | 15 | 7 | +8 | Correlates with schema markup addition |

## Needs Attention

| Keyword | Old | New | Change | Action |
|---------|-----|-----|--------|--------|
| marketing automation | 4 | 12 | -8 | Likely displaced by new HubSpot guide |

**Recommended**: Update your marketing automation guide with [current year] statistics and examples.
```

## Tips for Success

1. **Track consistently** - Same time, same device, same location
2. **Include enough keywords** - 50-200 for meaningful data
3. **Segment by intent** - Track brand, commercial, informational separately
4. **Monitor competitors** - Context makes your data meaningful
5. **Track SERP features** - Position 1 without snippet may lose to position 4 with snippet
6. **Include GEO metrics** - AI visibility increasingly important

## Rank Change Quick Reference

### Response Protocol

| Change | Timeframe | Action |
|--------|-----------|--------|
| Drop 1-3 positions | Wait 1-2 weeks | Monitor -- may be normal fluctuation |
| Drop 3-5 positions | Investigate within 1 week | Check for technical issues, competitor changes |
| Drop 5-10 positions | Investigate immediately | Full diagnostic: technical, content, links |
| Drop off page 1 | Emergency response | Comprehensive audit + recovery plan |
| Position gained | Document and learn | What worked? Can you replicate? |

> **Reference**: See [references/tracking-setup-guide.md](./references/tracking-setup-guide.md) for rank fluctuation patterns and their interpretation, position-vs-traffic impact estimates, alert threshold configuration, tracking configuration best practices, keyword selection and grouping strategies, and data interpretation guidelines.

## Reference Materials

- [Tracking Setup Guide](./references/tracking-setup-guide.md) — Configuration best practices, device/location settings, and striking-distance GSC mining methodology (Section 9)
- [Ranking Analysis Templates](./references/ranking-analysis-templates.md) — Complete output templates for the seven core workflow steps (mining step's format is in the setup guide)

## Related Skills

- [keyword-research](../../research/keyword-research/) — Find keywords to track
- [serp-analysis](../../research/serp-analysis/) — Understand SERP composition
- [alert-manager](../alert-manager/) — Set up ranking alerts
- [performance-reporter](../performance-reporter/) — Comprehensive reporting
- [content-refresher](../../optimize/content-refresher/) — Receives striking-distance queries whose URLs need content work as refresh targets
- [memory-management](../../cross-cutting/memory-management/) — Store ranking history in project memory

