# Rank Tracking Setup Guide

Comprehensive reference for configuring rank tracking systems. Covers tool configuration, keyword selection, grouping strategies, alert thresholds, reporting cadences, and data interpretation.

---

## 1. Tracking Tool Configuration

### Initial Setup Checklist

| Step | Action | Notes |
|------|--------|-------|
| 1 | Select tracking tool | ~~SEO tool with rank tracking capability |
| 2 | Add target domain | Primary domain + any subdomains |
| 3 | Set tracking location | Country, state/region, or city level |
| 4 | Configure device settings | Mobile, desktop, or both (recommended: both) |
| 5 | Set search engine | Google (primary), Bing (optional), local engines |
| 6 | Set language | Match target audience language |
| 7 | Configure update frequency | Daily for priority keywords, weekly for long-tail |
| 8 | Add competitor domains | 3-5 direct competitors |
| 9 | Import keyword list | From keyword research or existing tracking |
| 10 | Verify initial data pull | Confirm positions match manual spot checks |

### Location Configuration

Rank tracking results vary dramatically by location. Configure tracking to match your actual target market.

| Scenario | Location Setting | Example |
|----------|-----------------|---------|
| National business | Country level | United States |
| Regional business | State/region level | California, US |
| Local business | City level | San Francisco, CA, US |
| Multi-location | Separate project per location | NYC + LA + Chicago |
| International | Separate project per country | US + UK + Canada |

**Common mistake**: Tracking from a single location when your audience is distributed. If you serve multiple cities, track key terms in each city separately.

### Device Configuration

| Device | When to Track | Why |
|--------|--------------|-----|
| Desktop | Always | Baseline reference, still significant traffic |
| Mobile | Always | 60%+ of searches are mobile; rankings differ from desktop |
| Both separately | Recommended | Identify device-specific ranking issues |
| Tablet | Optional | Usually mirrors desktop closely |

### Update Frequency Recommendations

| Keyword Tier | Frequency | Rationale |
|-------------|-----------|-----------|
| Top 20 revenue keywords | Daily | Catch drops immediately |
| Brand keywords | Daily | Protect brand presence |
| Page 1 keywords (21-50) | 2-3x per week | Monitor competitive positions |
| Page 2 keywords (51-100) | Weekly | Track progress without excessive API usage |
| Long-tail / monitoring (100+) | Weekly | Cost-efficient tracking |
| New/experimental keywords | Daily for first 30 days, then adjust | Establish baseline quickly |

---

## 2. Keyword Selection for Tracking

### How Many Keywords to Track

| Site Size | Recommended Keywords | Breakdown |
|-----------|---------------------|-----------|
| Small (< 50 pages) | 50-100 | 10 brand + 20 primary + 20 secondary + rest long-tail |
| Medium (50-500 pages) | 100-500 | 20 brand + 50 primary + 100 secondary + rest long-tail |
| Large (500+ pages) | 500-2000+ | Scale proportionally; focus on revenue pages |
| Enterprise | 2000-10000+ | Comprehensive coverage with automated management |

### Keyword Selection Criteria

Select keywords for tracking based on these factors:

| Factor | Weight | Selection Rule |
|--------|--------|---------------|
| Revenue impact | High | Always track keywords that drive conversions |
| Search volume | Medium | Track keywords with meaningful volume for your niche |
| Current ranking | Medium | Track keywords where you rank (pages 1-3) plus targets |
| Competitive value | Medium | Track keywords your competitors target |
| Strategic importance | High | Track keywords aligned with business goals |
| Content investment | Medium | Track keywords for pages you invested in creating |

### Keyword Types to Include

| Type | % of Tracked Keywords | Examples |
|------|----------------------|---------|
| Brand keywords | 5-10% | "[brand name]", "[brand] + product", "[brand] reviews" |
| Primary commercial | 15-25% | "[product category]", "best [product]", "buy [product]" |
| Secondary commercial | 15-25% | "[product] for [use case]", "[product] vs [competitor]" |
| Informational | 20-30% | "how to [topic]", "what is [concept]", "[topic] guide" |
| Long-tail | 15-25% | Specific queries with 3+ words, lower volume |
| Local (if applicable) | 5-10% | "[service] near me", "[service] in [city]" |

### Keywords You Should NOT Track

| Skip These | Why |
|-----------|-----|
| Zero-volume keywords (unless strategic) | No measurable impact |
| Keywords you have no content for | Track only when you create targeting content |
| Extremely broad single-word terms | Too volatile, hard to rank, misleading data |
| Misspellings (unless significant volume) | Clutters reporting |

---

## 3. Keyword Grouping Strategies

Effective grouping transforms raw keyword data into strategic insights.

### Grouping Dimensions

| Dimension | Examples | Insight Gained |
|-----------|---------|----------------|
| **Topic cluster** | "email marketing", "email automation", "email templates" | Content hub performance |
| **Search intent** | Informational, commercial, transactional, navigational | Funnel stage performance |
| **Funnel stage** | Awareness, consideration, decision, retention | Buyer journey alignment |
| **Product/service** | Product A, Product B, Service C | Product line performance |
| **Content type** | Blog, landing page, product page, guide | Format effectiveness |
| **Priority tier** | Tier 1 (revenue), Tier 2 (growth), Tier 3 (monitor) | Resource allocation |
| **Page** | URL-level grouping | Page-specific performance |
| **Competitor overlap** | Keywords where you compete with specific rivals | Competitive intelligence |

### Recommended Group Hierarchy

```
Level 1: Business Unit / Product Line
  └── Level 2: Topic Cluster / Category
       └── Level 3: Search Intent
            └── Level 4: Priority Tier
```

**Example:**

```
SaaS Product
  └── Project Management
       └── Commercial Intent
            └── Tier 1: "project management software", "best PM tools"
            └── Tier 2: "PM software for small teams", "agile PM tools"
       └── Informational Intent
            └── Tier 1: "what is project management", "PM methodologies"
  └── Collaboration
       └── Commercial Intent
            └── Tier 1: "team collaboration software", "best collab tools"
```

### Group Naming Conventions

Use consistent, descriptive names:

| Pattern | Example | Benefit |
|---------|---------|---------|
| `[Category] - [Intent]` | "Email Marketing - Commercial" | Clear context |
| `[Product] / [Feature]` | "CRM / Lead Scoring" | Product-line clarity |
| `T1: [Topic]` | "T1: Core Product Terms" | Priority at a glance |

---

## 4. Alert Threshold Configuration

### Setting Baseline Thresholds

Before setting alerts, establish a baseline by tracking for 2-4 weeks without alerts to understand normal fluctuation ranges.

| Metric | Baseline Period | Normal Fluctuation | Alert When |
|--------|----------------|-------------------|------------|
| Individual keyword position | 2-4 weeks | +/- 2-3 positions | Exceeds normal range |
| Average position (all keywords) | 4 weeks | +/- 1-2 positions | Exceeds normal range |
| Keywords in top 10 | 4 weeks | +/- 5% | Drops >10% |
| Keywords in top 3 | 4 weeks | +/- 3% | Drops >5% |

**The band between the two columns is not a gap in the data — it is a reporting zone, and saying
so is the point.** A 7% fall in the top-10 count is past the +/- 5% normal band and under the
>10% alert threshold; a 4% fall in the top-3 count sits the same way. Neither fires an alert.
Both are listed in the weekly summary with the movement stated, so the change is on the record
before it reaches an alerting size. Without this row an operator reads the two columns as
exhaustive and silently drops everything in between.

### Alert Configuration by Keyword Tier

| Keyword Tier | Drop Alert | Gain Alert | Competitor Alert |
|-------------|-----------|-----------|-----------------|
| Tier 1 (revenue) | Drop >= 3 positions | Gain >= 3 positions | Competitor enters top 5 |
| Tier 2 (growth) | Drop >= 5 positions | Enters top 10 | Competitor overtakes you |
| Tier 3 (monitor) | Drop >= 10 positions | Enters top 20 | None |
| Brand | Any drop from #1 | N/A | Competitor ranks for your brand |

### Alert Delivery Preferences

| Alert Type | Channel | Frequency |
|-----------|---------|-----------|
| Critical drops (Tier 1) | Email + Slack | Immediate |
| Significant changes | Email | Daily digest |
| Weekly summary | Email | Every Monday |
| Monthly report | Email + dashboard | 1st of month |

---

## 5. Reporting Cadences

### Recommended Report Schedule

| Report Type | Audience | Frequency | Key Metrics |
|------------|----------|-----------|-------------|
| Quick pulse | SEO team | Daily | Major movements, alerts fired |
| Weekly summary | Marketing team | Weekly | Position changes, trends, actions taken |
| Monthly report | Stakeholders | Monthly | Full performance analysis, MoM comparisons |
| Quarterly review | Leadership | Quarterly | Strategic trends, ROI, competitive position |
| Annual review | Executive | Annually | YoY growth, strategic recommendations |

### Report Content by Cadence

**Daily Pulse (1-2 minutes to review):**
- Keywords with biggest position changes
- Alerts triggered
- Competitor movements

**Weekly Summary (5-10 minutes to review):**
- Position distribution changes
- Top 5 improvements and declines
- SERP feature wins/losses
- AI citation changes
- Week-over-week trend

**Monthly Report (15-30 minutes to review):**
- Full position distribution analysis
- Month-over-month trends
- Competitor share of voice
- SERP feature ownership
- GEO visibility trends
- Content performance by keyword group
- Recommendations for next month

**Quarterly Review (30-60 minutes to review):**
- Quarter-over-quarter trends
- Progress against annual goals
- Competitive landscape shifts
- Strategic keyword opportunities
- Budget and resource recommendations

---

## 6. Data Interpretation Guidelines

### Understanding Rank Fluctuations

| Pattern | Meaning | Action |
|---------|---------|--------|
| Daily +/- 1-2 positions | Normal fluctuation | Ignore; track weekly trend |
| Sudden drop 5+ positions, recovers in 2-3 days | Google testing / data center variation | Monitor, no action needed |
| Steady decline over 2+ weeks | Real ranking loss | Investigate cause |
| Sudden drop affecting many keywords | Algorithm update or technical issue | Check Search Status Dashboard + technical health |
| One keyword drops, others stable | Page-specific or competitor-specific issue | Analyze that specific SERP |
| All keywords for one URL drop | Page-level issue (noindex, 404, slow) | Check page technical health |
| Gradual improvement over weeks | SEO efforts working | Document what worked, continue strategy |

### Position vs. Traffic Relationship

Position changes do not translate linearly to traffic changes.

**[VERIFY — the click-loss ranges in the table below carry no citation here and none elsewhere
in this repository (grepped 2026-08-10; no external search was made, which is stated so the gap
is not read as a negative finding). They are a position-CTR curve of exactly the class already
tagged as watch-item W14 on `build/meta-tags-optimizer/references/meta-tag-formulas.md:210-219`
— plausible, widely circulated, and unsourced, which is the kind of number this library has
twice found to be wrong in transit. Left in place rather than deleted: unlike the figures W14
was opened beside, these contradict nothing, and deleting an unsourced figure is a different act
from deleting figures that disagree. Resolves on a named study with a year and a sample size, or
on replacement by the site's own measured curve. This tag has no register row of its own —
report it to the coordinator for W14's "Where" list rather than treating it as covered.]**

Two limits on how this table may be used:

1. **It is a generic estimate, never this site's measured loss.** Cite it as the guide's range
   and label it as such. A figure attributed to a specific site needs that site's own clicks
   data behind it — see the Traffic Impact rule in the change-analysis template.
2. **It covers the listed transitions only.** A move it does not list (e.g. #1 to #4, or
   anything past #20) is not interpolated into a number here: describe the direction, or chain
   the adjacent rows and say that is what you did.

| Position Change | Estimated Traffic Impact |
|----------------|------------------------|
| #1 to #2 | -50% to -60% click loss |
| #2 to #3 | -25% to -30% click loss |
| #3 to #5 | -30% to -40% click loss |
| #5 to #10 | -50% to -60% click loss |
| #10 to #11 | -60% to -80% click loss (page 2 cliff) |
| #11 to #20 | Minimal additional loss (already low) |

**Key insight**: Moving from position #10 to #11 (page 1 to page 2) has a far greater impact than moving from #20 to #30. Prioritize keeping keywords on page 1.

### Interpreting Visibility Score

A visibility score combines position and search volume into a single metric. **This skill defines
no visibility score of its own**, because any such score needs a position-CTR curve and this
library has none it can source (see the tag above). So a visibility figure appears in a
deliverable only when a connected tool reports it, carrying that tool's name — different tools
compute it differently, and two tools' figures never share a column or a trend line. Where no
tool reports one, use the countable substitutes the workflow already collects: keywords in the
top 3 and top 10, and the top-10 share of voice defined in the competitor template.

The table below reads a tool-reported visibility trend; it is not a way to produce one.

| Visibility Change | Interpretation |
|-------------------|---------------|
| Increasing visibility, stable positions | Seasonal search volume increase |
| Decreasing visibility, stable positions | Seasonal search volume decrease |
| Increasing visibility, improving positions | SEO strategy is working |
| Decreasing visibility, declining positions | Ranking loss causing traffic decline |
| Stable visibility, mixed position changes | Gains offsetting losses |

### Comparing Against Competitors

| Competitive Signal | Meaning | Response |
|-------------------|---------|----------|
| Competitor visibility rising, yours stable | They are gaining, you may lose ground | Analyze their strategy, accelerate efforts |
| Your visibility rising faster than competitors | You are winning share of voice | Continue strategy, identify what is working |
| All competitors dropping simultaneously | Algorithm update affecting the niche | Focus on quality, wait for dust to settle |
| One competitor surging | They made a significant change | Analyze what they did (content? links? technical?) |

### Data Quality Checks

Always verify your tracking data quality.

| Check | How | Frequency |
|-------|-----|-----------|
| Spot-check positions manually | Incognito search for 5-10 keywords | Weekly |
| Compare with Search Console | Match tracked positions with GSC average position | Monthly |
| Check for tracking errors | Look for keywords showing "not found" or position 0 | Weekly |
| Verify competitor data | Spot-check competitor rankings manually | Monthly |
| Confirm location accuracy | Search from target location (VPN if needed) | Quarterly |

---

## 7. Common Pitfalls and How to Avoid Them

| Pitfall | Problem | Solution |
|---------|---------|----------|
| Tracking too many keywords | Dilutes focus, increases cost | Focus on keywords with business impact |
| Checking rankings too frequently | Obsessing over daily noise | Focus on weekly and monthly trends |
| Not segmenting data | Averages hide important patterns | Group by intent, topic, priority |
| Ignoring SERP features | Position alone does not tell the whole story | Track featured snippets, AI Overviews, PAA |
| Not tracking competitors | Your data lacks context | Always track 3-5 competitors |
| Single location tracking | Misses local variations | Track each target market separately |
| Forgetting mobile | Mobile and desktop rankings differ | Always track both devices |
| Not documenting changes | Cannot correlate changes to actions | Log all content updates, technical changes, link building |

---

## 8. Migration and Tool Switching

If you need to switch rank tracking tools, follow this process to preserve data continuity.

| Step | Action |
|------|--------|
| 1 | Export all historical data from current tool |
| 2 | Run both tools in parallel for 2-4 weeks |
| 3 | Compare data between tools to understand differences |
| 4 | Document any systematic position differences |
| 5 | Import historical data into new tool if supported |
| 6 | Reconfigure all alerts and reports in new tool |
| 7 | Decommission old tool after confidence in new data |

**Important**: Different tools may report slightly different positions due to data center sampling, timing, and methodology. A 1-2 position variance between tools is normal.

---

## 9. Striking-Distance Query Mining (GSC)

Methodology for the mining step in SKILL.md. Scope guard first: this section works exclusively with the **tracked property's own Search Console data** — queries the site already ranks for at near-page-one positions. Net-new keyword discovery is a different job and belongs to keyword-research.

### Why Positions ~5-20

Queries at average positions ~5-20 (page-one tail plus page two) combine two properties no other candidate pool offers: the demand is proven (the property already earns impressions on them), and the distance to top-of-page-one click rates is short. The position-vs-traffic table in Section 6 shows why the payoff concentrates here — crossing from page two onto page one, or from the page-one tail into the top 5, moves far more clicks than equivalent movement lower down.

### Pull Mechanics

| Aspect | Practice |
|--------|----------|
| Source | Search Console Search Analytics (API or UI export) for the tracked property only — named by its real name wherever a report repeats it, never as a `~~category` token |
| Ordering | GSC-first: when the connector or an export is available, mine this list before consulting third-party rank data |
| API behavior | The Search Analytics API returns rows sorted by clicks and exposes no position filter — request a high rowLimit and apply the 5-20 position window client-side |
| Manual path | No connector: ask the user for a GSC Performance export (queries + position + impressions + clicks) and apply the same window |
| Pull window | Last 28 days by default; widen to 90 days for low-traffic properties (house default, tunable) |
| Labeling | Positions, impressions, and clicks from this pull are tool-measured |

### Filtering Defaults

| Rule | Default | Status |
|------|---------|--------|
| Position window | Average position 5-20 | Core striking-distance definition (page-one tail + page two) |
| Impression floor | Skip queries with fewer than 50 impressions in the pull window | House default — upstream defines no floor; tune per site size and window length |
| Dedup | Collapse near-duplicate queries onto their shared ranking URL | Keeps the action list page-shaped, not query-shaped |
| Brand queries | Exclude | Brand terms move on brand signals, not content pushes |

### Prioritization

**Primary score — when volume/difficulty inputs exist:**

```
Opportunity = (Volume × Intent Value) / Difficulty
```

- Volume: monthly searches from ~~SEO tool (tool-measured)
- Intent Value: business weighting supplied by the user (e.g., transactional 3, commercial 2, informational 1) — user-provided
- Difficulty: keyword difficulty from ~~SEO tool (tool-measured)

**Fallback score — manual tier, no volume/difficulty available:**

```
Opportunity = Impressions × Position Gap        (Position Gap = current average position − 1)
```

Both formulas order the same work queue. Never mix the two scales in one ranked list — state which formula produced each ranking.

**Rounding and precision.** Compute from the export's own values, unrounded: a position of 18.9 gives a gap of 17.9, not 18. Print the multiplication beside the result (`840 × 8.0 = 6,720`) so the row can be rechecked, round the printed Opportunity to a whole number, and print average positions to the export's own precision (1 decimal). Rank on the unrounded value; where two rows round to the same figure, keep their unrounded order and say so.

### Output Format

```markdown
<!-- SKELETON — fill every [slot] from the export; a slot with no value means the column is dropped and the gap named in prose -->
| Query | Ranking URL | Avg Position | Impressions | Clicks | Opportunity (formula) | Source | Action |
|-------|-------------|--------------|-------------|--------|-----------------------|--------|--------|
| [query, verbatim as exported] | [url] | [5-20] | [X] | [Y] | [X × gap = Z] ([primary/fallback]) | [resolved source] | [refresh / on-page / internal links] |
```

Query strings are reproduced character-exact from the export — unaccented and article-less if that is how they were exported — because the table is a keyword-list surface; the prose around it is written as ordinary sentences and does not adopt query-style forms. The Source cell names the export in the deliverable's own language ("Search Console, 28-day export"), never a `~~category` token: this table is read by the client.

Persist the mined table as part of the dated snapshot required by SKILL.md step 1's persistence contract, so the next run can measure movement on mined queries against a baseline. Queries whose URL needs content work go into the run's operator handoff block as content-refresher targets; the client-facing Action cell names the job ("refresh this page"), not the run handle.
