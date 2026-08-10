---
name: content-gap-analysis
version: "4.2.2"
description: 'Find content opportunities by identifying topics and keywords your competitors cover that you don''t. Use when the user asks to "find content gaps", "what am I missing", "topics to cover", "content opportunities", "what topics am I missing", "where are my content blind spots", "untapped topics", or "content strategy gaps". For broader competitive intelligence, see competitor-analysis. For general keyword discovery, see keyword-research.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.2.2"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - content gaps
    - content opportunities
    - topic analysis
    - content strategy
    - competitive content
    - content-gaps
    - topic-gaps
    - missing-content
    - content-opportunities
    - competitive-gap
    - topic-coverage
    - editorial-calendar
    - content-strategy
  triggers:
    - "find content gaps"
    - "what am I missing"
    - "topics to cover"
    - "content opportunities"
    - "what do competitors write about"
    - "untapped topics"
    - "content strategy gaps"
    - "what topics am I missing"
    - "they cover this but I don't"
    - "where are my content blind spots"
---

# Content Gap Analysis


Identifies content opportunities by analyzing gaps between a site's content and competitors'. Surfaces missing topics, untapped keywords, and content formats worth creating.

## When to Use This Skill

- Planning content strategy and editorial calendar
- Finding quick-win content opportunities
- Understanding where competitors outperform you
- Identifying underserved topics in your niche
- Expanding into adjacent topic areas
- Prioritizing content creation efforts
- Finding GEO opportunities competitors miss

## What This Skill Does

1. **Keyword Gap Analysis**: Finds keywords competitors rank for that you don't
2. **Topic Coverage Mapping**: Identifies topic areas needing more content
3. **Content Format Gaps**: Reveals missing content types (videos, tools, guides)
4. **Audience Need Mapping**: Matches gaps to audience journey stages
5. **GEO Opportunity Detection**: Finds AI-answerable topics you're missing
6. **Priority Scoring**: Ranks gaps by impact and effort
7. **Content Calendar Creation**: Plans gap-filling content schedule

## How to Use

### Basic Gap Analysis

```
Find content gaps between my site [URL] and [competitor URLs]
```

```
What content am I missing compared to my top 3 competitors?
```

### Topic-Specific Analysis

```
Find content gaps in [topic area] compared to industry leaders
```

```
What [content type] do competitors have that I don't?
```

### Audience-Focused

```
What content gaps exist for [audience segment] in my niche?
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~search console + ~~analytics + ~~AI monitor connected:**
Automatically pull your site's content inventory from ~~search console and ~~analytics (indexed pages, traffic per page, keywords ranking), competitor content data from ~~SEO tool (ranking keywords, top pages, backlink counts), and AI citation patterns from ~~AI monitor. Keyword overlap analysis and gap identification can be automated.

**With manual data only:**
Ask the user to provide:
1. Your site URL and content inventory (list of published content with topics)
2. Competitor URLs (3-5 sites)
3. Your current traffic and keyword performance (if available)
4. Known content strengths and weaknesses
5. Industry context and business goals

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests content gap analysis:

1. **Define Analysis Scope**

   Clarify parameters:
   
   ```markdown
   ### Analysis Parameters
   
   **Your Site**: [URL]
   **Competitors to Analyze**: [URLs or "identify for me"]
   **Topic Focus**: [specific area or "all"]
   **Content Types**: [blogs, guides, tools, videos, or "all"]
   **Audience**: [target audience]
   **Business Goals**: [traffic, leads, authority, etc.]
   ```

2. **Audit Your Existing Content**

   Document total indexed pages, content by type and topic cluster, top performing content, and content strengths/weaknesses.

3. **Analyze Competitor Content**

   For each competitor: document content volume, monthly traffic, content distribution by type, topic coverage vs. yours, and unique content they have.

4. **Identify Keyword Gaps**

   Find keywords competitors rank for that you do not. Categorize into High Priority (high volume, achievable difficulty), Quick Wins (lower volume, low difficulty), and Long-term (high volume, high difficulty). Include keyword overlap analysis.

   **A quick win is cheap *and* wanted.** Low difficulty alone does not qualify a keyword for the Quick Wins bucket: it must also clear the demand floor in the gap filters (>100/month by default, adjusted for the niche) or carry the named demand proxy this run is using per Step 9. This is the same condition the Quick Win Score enforces, stated in words — a keyword with no demand evidence is not a quick win however easy it looks and however empty the SERP is.

5. **Map Topic Gaps**

   Create a topic coverage comparison matrix across all competitors. For each missing topic cluster, document business relevance, competitor coverage, opportunity size, sub-topics, and recommended pillar/cluster approach.

6. **Identify Content Format Gaps**

   Compare format distribution (guides, tutorials, comparisons, case studies, tools, templates, video, infographics, research) against each competitor and against the competitor mean — the average of the competitors you counted. Not against an industry average: this workflow counts the competitors you named and collects no industry population, so that number would have to be invented (statistics rule: sourced, cited, or placeholder, never invented). A published benchmark may sit beside the competitor mean only when you have read it — publisher, year, sample, link. For each gap, assess effort and expected impact.

7. **Analyze GEO/AI Gaps**

   Identify topics where competitors get AI citations but you do not. Document missing Q&A content, definition/explanation content, and comparison content. Score each by traditional SEO value and GEO value — Traditional SEO Value is the gap's own Gap Priority Score printed with its factor row, GEO Value is a 1-5 judgement against the rubric in [references/score-arithmetic.md](./references/score-arithmetic.md) §4, and the two are never blended into a third number. With no ~~AI monitor connected there is no citation count to report: say so and frame the GEO angle as an opportunity type, not as measured citations.

8. **Map to Audience Journey**

   Compare funnel stage coverage against competitor averages, and detail specific gaps at each stage. **The funnel has four stages throughout this skill — Awareness, Consideration, Decision, Retention.** The seven-stage vocabulary some models use folds into them: Interest into Awareness, Intent and Purchase into Decision, Advocacy into Retention; the fold is tabulated in [references/gap-analysis-frameworks.md](./references/gap-analysis-frameworks.md) §3. Count every page once, in exactly one stage, and state the total the four rows sum to.

9. **Prioritize and Create Action Plan**

   Produce a final report in the shape set out under **Content Gap Report** below. The three tiers are read from the two scores, and each tier states the rule it used: **Tier 1** = P0 or P1 with a Quick Win Score of 2+; **Tier 2** = P0 or P1 that missed the quick-win bar; **Tier 3** = P2 and P3.

   **When a factor cannot be scored, do not invent its input.** The Gap Priority Score bands Search Demand in monthly search volume, and Step 4's categories need difficulty. With no SEO tool connected and nothing supplied, neither figure exists for this run — and guessing one produces a precise-looking ranking with nothing behind it. Two routes are honest, and the report states which it took. **Named proxy**: score the factor from something the supplied data actually contains and name that basis in the report — e.g. "Search Demand scored from competitor cluster depth (23 + 41 articles across the two competitors); a coverage proxy, not a volume measurement". **Drop it**: leave the factor unscored, renormalise the remaining weights over their own sum, and state the rescaling — the denominator or the renormalised weights — together with which factor dropped out and why. Read the P0-P3 tiers against the renormalised score; see [references/gap-analysis-frameworks.md](./references/gap-analysis-frameworks.md) §4. **Dropping Search Demand also stops the quick-win screen**: the Quick Win Score needs all four of its inputs, so write "quick-win screen not run — Search Demand unavailable", order the gaps on the renormalised priority score, and let P0 carry the "start here" job. Score Search Demand from a named proxy instead and the screen runs as normal, labelled with that proxy. The same discipline governs the label: "estimated" is a source label only where the estimate has a stated basis — a range the user gave, a named proxy, a hand-check you describe. With no tool and nothing supplied there is nothing to estimate from, so the cell carries an explained N/A and the report says so in plain words.

   > **Reference**: See [references/analysis-templates.md](./references/analysis-templates.md) for detailed templates for each step.

## Content Gap Report

The deliverable, in this order. Cell-level templates for every block live in
[references/analysis-templates.md](./references/analysis-templates.md); this is the shape the
report takes and what each section must carry.

```markdown
# Content Gap Analysis: [Site]

**Data pulled**: [date] · [what came from which source, in plain words — the resolved tool name,
"your CMS export", "hand-counted from their index pages"]

## Executive Summary

- Sites compared: [your site] vs [competitors, named]
- The three findings that change what gets written next
- **Total opportunity**: [X] keyword gaps · combined search volume [X]/month where volumes exist
  (search volume, not visits) · [X] quick wins
- **What could not be scored this run**, and what it would take to score it

## Coverage Comparison

Topic-level matrix, your counts against each competitor's, with covered rows marked covered.
Depth gaps and angle gaps distinguished from wholly missing topics.

## Gap Findings

Grouped as: missing topics · depth gaps · format gaps · funnel gaps (four stages) · GEO
opportunities. Each finding cites both sides — the competitor coverage as observed and the
absence from your own inventory — and names where it was counted.

## Prioritized Gap List

Tier 1 Quick Wins · Tier 2 Strategic Builds · Tier 3 Long-term, with the tier rule stated
(Step 9). Every row shows its five factor scores, the weighted arithmetic, the resulting Gap
Priority Score and tier, and the Quick Win Score where the screen ran.

## Content Calendar

Sequenced by priority and dependency, capped by the team's real monthly output.

## Success Metrics

Baselines that exist today and the date each target gets set from real data. No traffic
projection.

## Data Sources and Limitations

Every figure's source, and every figure that is missing, named with what would supply it.
```

Greek and other non-English engagements carry this same shape with native headings — the
structure is the deliverable's, the language is the client's.

## Scoring & Derivation Rules

Three rules that bind every step above.

**Every score prints its working beside itself.** The Gap Priority Score, the Quick Win Score,
the P0-P3 tier, the GEO Value and every count, mean and difference in the report are arithmetic
over rows the analysis already printed. A gap's row carries its five factor scores, the weighted
line that produced the total and the rounded total the tier was read from. A mean states its n; a
difference shows both inputs. A ranked list the reader cannot reproduce from the rows above it is
an assertion wearing a decimal point, and two runs of the same data must land on the same number.
Attainable values, the rounding convention, the GEO Value rubric and the pre-send recompute pass:
[references/score-arithmetic.md](./references/score-arithmetic.md).

**All five factors point the same way, and nothing is subtracted.** A 5 is always the value most
favourable to you — Creation Effort 5 means "quick to create", Competitive Density 5 means "no
competitor covers it". Both scores therefore add all their inputs. Where a table elsewhere in the
report runs the other way ("Estimated Effort: High"), map it in the same row: high effort is
Creation Effort 1, not 5.

**A factor with no input is not scored into existence.** Follow Step 9 — name a proxy or drop the
factor and renormalise — and where a whole score cannot be produced, write which one and why
rather than printing a weaker number under the same name. No score at all is printed for a gap
whose factors could not be judged: `not scored — no coverage data`, never `1.00`, because 1.00
means judged and lowest.

## Validation Checkpoints

### Input Validation
- [ ] Your content inventory is complete or representative sample provided
- [ ] Competitor URLs identified (minimum 2-3 competitors)
- [ ] Analysis scope defined (specific topics or comprehensive)
- [ ] Business goals and priorities clarified

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] Gap analysis compares like-to-like content (topic clusters to topic clusters)
- [ ] Priority scoring based on measurable criteria (volume, difficulty, business fit) — and where an input is unavailable, on the factors that can be scored, with the named proxy or the renormalisation stated per Step 9 rather than a guessed volume
- [ ] Every score prints its derivation beside it — factor scores, the weighted line, the rounded total, the tier read from it; every mean states its n and every difference shows both inputs
- [ ] No score subtracts a factor: Creation Effort and Competitive Density are added like the rest, because 5 is the favourable value in both
- [ ] Every gap in Tier 1 / the Quick Wins bucket clears the demand condition as well as the difficulty one, or the report says the quick-win screen did not run
- [ ] Funnel coverage uses the four stages (Awareness, Consideration, Decision, Retention), each page counted once, and the stage counts sum to the stated total
- [ ] No traffic projection for unwritten content, and no competitor traffic figure that was derived rather than read — a tool's own estimate may be quoted as an estimate, but a site total is never split across their content types or pages
- [ ] Content calendar maps gaps to realistic timeframes
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Google Analytics 4, Otterly), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

> **Reference**: See [references/example-report.md](./references/example-report.md) for a complete example analyzing SaaS marketing blog gaps vs. two illustrative competitors — fictional subjects on the `.example` TLD, figures illustrative rather than measured, and competitor traffic labelled as a tool estimate.

## Advanced Analysis

### Competitive Cluster Comparison

```
Compare our topic cluster coverage for [topic] vs top 5 competitors
```

### Temporal Gap Analysis

```
What content have competitors published in the last 6 months that we haven't covered?
```

### Intent-Based Gaps

```
Find gaps in our [commercial/informational] intent content
```

## Tips for Success

1. **Focus on actionable gaps** - Not all gaps are worth filling
2. **Consider your resources** - Capacity decides what gets *scheduled*, not what scores well. The Gap Priority Score ranks opportunity and gives Creation Effort only 15%, deliberately: a gap is not worth less because it is expensive. Execution capacity binds in three other places instead — the Quick Win Score, where Creation Effort is a full quarter share; the tier's timeline column, which is a commitment rather than a score; and the calendar cadence for your team size, which caps how many gaps enter the plan at all. If effort must move the ranking itself, change the weight and print the changed weight set (gap-analysis-frameworks.md §4)
3. **Quality over quantity** - Better to fill 5 gaps well than 20 poorly
4. **Track what works** - Measure gap-filling success
5. **Update regularly** - Gaps change as competitors publish
6. **Include GEO opportunities** - Don't just optimize for traditional search


## Reference Materials

- [Analysis Templates](./references/analysis-templates.md) — Detailed templates for each analysis step (inventory, competitor content, keyword gaps, topic gaps, format gaps, GEO gaps, journey, prioritized report)
- [Gap Analysis Frameworks](./references/gap-analysis-frameworks.md) — Content audit matrices, four-stage funnel mapping, and gap prioritization scoring methodologies
- [Score Arithmetic](./references/score-arithmetic.md) — Which figures the scoring model can and cannot produce: attainable values, the rounding convention, the GEO Value rubric, and the pre-send recompute pass
- [Example Report](./references/example-report.md) — Complete example analyzing SaaS marketing blog gaps vs. two illustrative `.example` competitors (illustrative figures; competitor traffic labelled as a tool estimate)

## Related Skills

- [keyword-research](../keyword-research/) — Deep-dive on gap keywords
- [competitor-analysis](../competitor-analysis/) — Understand competitor strategies
- [seo-content-writer](../../build/seo-content-writer/) — Create gap-filling content
- [content-refresher](../../optimize/content-refresher/) — Refresh existing content to fill identified gaps
- [internal-linking-optimizer](../../optimize/internal-linking-optimizer/) — Identify and fix internal linking gaps
- [backlink-analyzer](../../monitor/backlink-analyzer/) — Analyze link gap opportunities
- [memory-management](../../cross-cutting/memory-management/) — Track content gaps over time

