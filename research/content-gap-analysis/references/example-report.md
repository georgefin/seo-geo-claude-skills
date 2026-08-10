# Content Gap Analysis — Example Report

This is a complete example output showing the expected format for content gap analysis deliverables.

> **Illustrative example — the figures below are not measurements, and the competitors are not
> real companies.** Both use the reserved `.example` TLD, and every volume, difficulty, ranking
> position and traffic figure is a made-up value chosen to show the output shape. In real output
> each one comes from ~~SEO tool or a check you ran yourself, reported with that source and the
> date — never assigned to a named business you have no data for (statistics rule: sourced,
> cited, or placeholder, never invented). One class is worth naming twice, because this report
> invites it: a competitor's traffic is not observable from outside their analytics, so it is
> reported as a tool estimate labelled as an estimate, or not at all. The `~~` token stays
> outside the code fence; inside the deliverable it resolves to the tool's real name or to the
> source in plain language.

## Prompt

**User**: "Find content gaps for my SaaS marketing blog compared to marketingpro.example and chatvendor.example"

## Example Output

```markdown
# Content Gap Analysis: SaaS Marketing Blog

**Data pulled**: 3 August 2026 · volume, difficulty and competitor positions from the SEO-tool
export; page and tool counts hand-counted from the competitors' own index pages

## Executive Summary

Compared to marketingpro.example and chatvendor.example, your blog has significant gaps in:
1. **Interactive tools** - 15 between the two of them (counted from their tool index pages),
   0 on your site
2. **Comparison content** - Missing "[Your Tool] vs [Competitor]" pages
3. **GEO-optimized definitions** - No glossary or term definitions

**Opportunity size**: 45 keyword gaps carrying 38,400 monthly searches in total, of which the
four quick wins below are 4,610. Searches are not visits: what share becomes sessions depends on
the position you reach and the click-through rate at that position, and neither is known before
you rank. No traffic figure is projected here — set a target once the first three pages have 90
days of rank-tracker data behind them.

## Top Keyword Gaps

### Quick Wins (volume above the 100/month floor AND difficulty <40)

Both conditions, not either: a keyword nobody searches for is not a quick win however easy it is
to write.

| Keyword | Volume | Difficulty | Who Ranks |
|---------|--------|------------|-----------|
| saas marketing metrics | 1,200 | 32 | marketingpro.example #3 |
| b2b email sequences | 890 | 28 | chatvendor.example #5 |
| saas onboarding emails | 720 | 25 | Neither! |
| marketing qualified lead definition | 1,800 | 35 | marketingpro.example #1 |

### How These Were Scored

Factor scores in table order — Search Demand / Competitive Density / Business Relevance /
Creation Effort / Conversion Potential — with the arithmetic that produced each figure. All five
run the same way: 5 is the value that favours us, including Creation Effort (5 = quick to create)
and Competitive Density (5 = nobody holds it).

| Gap | Factors | Gap Priority Score | Tier | Quick Win Score |
|-----|---------|--------------------|------|-----------------|
| saas onboarding emails | 3/5/5/5/3 | 0.25×3 + 0.20×5 + 0.25×5 + 0.15×5 + 0.15×3 = **4.20** | P0 | 3+5+5+5 − 12 = **+6** strong |
| b2b email sequences | 3/3/5/4/3 | 0.25×3 + 0.20×3 + 0.25×5 + 0.15×4 + 0.15×3 = **3.65** | P1 | 3+5+4+3 − 12 = **+3** moderate |
| saas marketing metrics | 3/3/5/4/2 | 0.25×3 + 0.20×3 + 0.25×5 + 0.15×4 + 0.15×2 = **3.50** | P1 | 3+5+4+3 − 12 = **+3** moderate |
| marketing qualified lead definition | 3/2/5/5/2 | 0.25×3 + 0.20×2 + 0.25×5 + 0.15×5 + 0.15×2 = **3.45** | P1 | 3+5+5+2 − 12 = **+3** moderate |

All four are P0 or P1 with a Quick Win Score of 2 or better, so all four are Tier 1 and the
calendar below runs in this order.

`saas onboarding emails` carries the lowest volume of the four and still tops the list: neither
competitor holds it, it sits on our own product's ground, and it is a single article we can write
from support tickets. That is what the model is for — ordering on volume alone would have put it
last. `marketing qualified lead definition` scores GEO Value 5 (a definition — the shape an engine
lifts whole, per the rubric). That does not move it up the order — GEO Value breaks ties, and 3.45
is third among the P1s on its own merits — but it is the GEO play of the four, so its brief gets
written for answerability. The two numbers stay side by side rather than blended into one.

### Content Format Gaps

**You're missing**:
- [ ] Interactive ROI calculator - the tool estimates ~15,000 monthly visits to
      marketingpro.example's. An estimate, not a measurement: nobody outside the company can
      observe a competitor's traffic
- [ ] Email template library - chatvendor.example's, ~8,000 monthly visits on the same estimate
- [ ] Marketing glossary - marketingpro.example's 120 definition pages rank for 500+ keywords
      between them (a keyword count, which the export does report directly)

## Recommended Content Calendar

Sequenced by the scores above, not by volume.

**Week 1**: "B2B Email Sequences: Templates and Onboarding Flows" — covers both
`saas onboarding emails` (4.20, P0) and `b2b email sequences` (3.65, P1), one intent and one page;
the first is the only gap in the table neither competitor holds
**Week 2**: "SaaS Marketing Metrics: Complete Guide" — `saas marketing metrics` (3.50, P1)
**Week 3**: "What is a Marketing Qualified Lead?" — `marketing qualified lead definition`
(3.45, P1; GEO Value 5 — a definition page)
**Week 4**: "[Your Tool] vs marketingpro.example" — comparison gap
```
