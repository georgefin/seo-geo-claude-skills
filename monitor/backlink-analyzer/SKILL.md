---
name: backlink-analyzer
version: "4.0.3"
description: 'Analyze backlink profiles to assess link authority, identify toxic links, discover link building opportunities, and monitor competitors. Use when the user asks to "analyze backlinks", "check link profile", "find toxic links", "link building opportunities", "who links to me", "how do I get more backlinks", "disavow links", or "off-page SEO". For internal link analysis, see internal-linking-optimizer. For competitor link profiles, see competitor-analysis.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.0.3"
  geo-relevance: "low"
  tags:
    - seo
    - backlinks
    - link building
    - link profile
    - toxic links
    - off-page seo
    - link authority
    - domain authority
    - link acquisition
    - link-building
    - backlink-profile
    - toxic-links
    - link-audit
    - referring-domains
    - domain-rating
    - link-outreach
    - disavow
    - dr-score
    - link-quality
    - lost-backlinks
  triggers:
    - "analyze backlinks"
    - "check link profile"
    - "find toxic links"
    - "link building opportunities"
    - "off-page SEO"
    - "backlink audit"
    - "link quality"
    - "who links to me"
    - "I have spammy links"
    - "how do I get more backlinks"
    - "disavow links"
---

# Backlink Analyzer


Analyzes, monitors, and optimizes backlink profiles. Identifies link quality, discovers opportunities, and tracks competitor link building activities.

## When to Use This Skill

- Auditing your current backlink profile
- Identifying toxic or harmful links
- Discovering link building opportunities
- Analyzing competitor backlink strategies
- Monitoring new and lost links
- Evaluating link quality for outreach
- Preparing for link disavow

## What This Skill Does

1. **Profile Analysis**: Comprehensive backlink profile overview
2. **Quality Assessment**: Evaluates link authority and relevance
3. **Toxic Link Detection**: Identifies harmful links
4. **Competitor Analysis**: Compares link profiles across competitors
5. **Opportunity Discovery**: Finds link building prospects
6. **Trend Monitoring**: Tracks link acquisition over time
7. **Disavow Guidance**: Helps create disavow files

## How to Use

### Analyze Your Profile

```
Analyze backlink profile for [domain]
```

### Find Opportunities

```
Find link building opportunities by analyzing [competitor domains]
```

### Detect Issues

```
Check for toxic backlinks on [domain]
```

### Compare Profiles

```
Compare backlink profiles: [your domain] vs [competitor domains]
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~link database + ~~SEO tool connected:**
Automatically pull comprehensive backlink profiles including referring domains, anchor text distribution, link quality metrics (DA/DR), link velocity, and toxic link detection from ~~link database. Competitor backlink data from ~~SEO tool for gap analysis.

**With manual data only:**
Ask the user to provide:
1. Backlink export CSV (with source domains, anchor text, link type)
2. Referring domains list with authority metrics
3. Competitor domains for comparison
4. Recent link gains/losses if tracking changes
5. Any known toxic or spammy links

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests backlink analysis:

1. **Generate Profile Overview** -- Key metrics (total backlinks, referring domains, DA/DR, dofollow ratio), link velocity (30d/90d/year), authority distribution chart, profile health score.

2. **Analyze Link Quality** -- Top quality backlinks table, link type distribution, anchor text analysis (brand/exact/partial/URL/generic), geographic distribution.

3. **Identify Toxic Links** -- Toxic score, risk indicators by type (spam, PBN, link farms, irrelevant), high-risk links to review, disavow recommendations (domain-level and URL-level).

4. **Compare Against Competitors** -- Profile comparison table (referring domains, DA/DR, velocity, avg link DA), unique referring domains, link intersection analysis, competitor content attracting most links.

5. **Find Link Building Opportunities** -- Link intersection prospects, broken link opportunities, unlinked mentions, resource page opportunities, guest post prospects, priority matrix (effort vs impact).

6. **Track Link Changes** -- New and lost links for last 30 days with DA, type, anchor, dates. Net change and links to recover.

7. **Generate Backlink Report** -- Executive summary, strengths, concerns, opportunities, competitive position, recommended actions (immediate/short-term/long-term), KPIs to track.

   > **Reference**: See [references/analysis-templates.md](./references/analysis-templates.md) for complete output templates for all 7 steps above.

### CITE Item Mapping

When running `domain-authority-auditor` after this analysis, the following data feeds directly into CITE scoring:

| Backlink Metric | CITE Item | Dimension |
|----------------|-----------|-----------|
| Referring domains count | C01 (Referring Domain Volume) | Citation |
| Authority distribution (DA breakdown) | C02 (Referring Domains Quality) | Citation |
| Link velocity | C04 (Link Velocity) | Citation |
| Geographic distribution | C10 (Link Source Diversity) | Citation |
| Dofollow/Nofollow ratio | T02 (Dofollow Ratio Normality) | Trust |
| Toxic link analysis | T01 (Link Profile Naturalness), T03 (Link-Traffic Coherence) | Trust |
| Competitive link intersection | T05 (Profile Uniqueness) | Trust |

## Validation Checkpoints

### Input Validation
- [ ] Target domain backlink data is complete and current
- [ ] Competitor domains specified for comparison analysis
- [ ] Backlink data includes necessary fields (source domain, anchor text, link type)
- [ ] Authority metrics available (DA/DR or equivalent)

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Toxic link assessments include risk justification
- [ ] Link opportunity recommendations are specific and actionable
- [ ] Source of each data point clearly stated (~~link database data, ~~SEO tool data, user-provided, or estimated)

## Example

**User**: "Find link building opportunities by analyzing my three main competitors"

> **Illustrative example — the figures below are not measurements.** Prospect domains use
> the reserved `.example` TLD so no real business is described, and their DA values are
> made-up numbers chosen to show the output shape. In real output every DA comes from
> ~~link database or a user-supplied export and is reported with that source; never assign
> an authority score to a domain you have no data for (statistics rule — sourced, cited, or
> placeholder, never invented).

**Output**:

```markdown
## Link Intersection Analysis

### Sites linking to 2+ competitors (not you)

| Domain | DA | Comp 1 | Comp 2 | Comp 3 | Opportunity |
|--------|-----|--------|--------|--------|-------------|
| reviewdirectory.example | 91 | ✅ | ✅ | ✅ | Get listed/reviewed |
| softwaredirectory.example | 89 | ✅ | ✅ | ✅ | Submit for review |
| businessmagazine.example | 92 | ✅ | ✅ | ❌ | Pitch guest post |
| industrynews.example | 94 | ✅ | ❌ | ✅ | PR/news pitch |

### Top 3 Immediate Opportunities

1. **reviewdirectory.example** (DA 91) - All 3 competitors listed
   - Action: Create a detailed profile/listing
   - Effort: Low
   - Impact: High authority + referral traffic

2. **businessmagazine.example** (DA 92) - 2 competitors have links
   - Action: Pitch contributed article
   - Effort: High
   - Impact: High authority + brand exposure

3. **industrynews.example** (DA 94) - 2 competitors covered
   - Action: Pitch a newsworthy launch or data release
   - Effort: Medium
   - Impact: Relevant audience + quality link

### Estimated Impact

If you acquire links from the four prospects above:
- New referring domains: +4
- Average DA of new links: 91.5 — arithmetic mean of the four DA values in the table above,
  not a separate estimate
- Ranking impact: not projected. Position movement does not follow from referring-domain
  counts or average DA, and this skill has no model that converts one into the other —
  measure the outcome with rank-tracker rather than promising a delta
```

## Tips for Success

1. **Quality over quantity** - One DA 80 link beats ten DA 20 links
2. **Monitor regularly** - Catch lost links and toxic links early
3. **Study competitors** - Learn from their link building success
4. **Diversify your profile** - Mix of link types and anchors
5. **Disavow carefully** - Only disavow clearly toxic links

## Link Quality and Strategy Reference

> **Reference**: See [references/link-quality-rubric.md](./references/link-quality-rubric.md) for the complete link quality scoring matrix (6 weighted factors), toxic link identification criteria, link profile health benchmarks, and disavow file guidance.

> **Reference**: See [references/outreach-templates.md](./references/outreach-templates.md) for email outreach frameworks, subject line formulas, response rate benchmarks, follow-up sequences, and templates for each link building strategy.

## Reference Materials

- [Link Quality Rubric](./references/link-quality-rubric.md) — Quality scoring matrix with weighted factors and toxic link identification criteria
- [Outreach Templates](./references/outreach-templates.md) — Email frameworks, subject line formulas, and response rate benchmarks

## Related Skills

- [domain-authority-auditor](../../cross-cutting/domain-authority-auditor/) — Backlink data feeds directly into CITE C dimension; run after this analysis for full domain scoring
- [competitor-analysis](../../research/competitor-analysis/) — Full competitor analysis
- [content-gap-analysis](../../research/content-gap-analysis/) — Create linkable content
- [alert-manager](../alert-manager/) — Set up link alerts
- [performance-reporter](../performance-reporter/) — Include in reports
- [entity-optimizer](../../cross-cutting/entity-optimizer/) — Branded backlinks strengthen entity signals

