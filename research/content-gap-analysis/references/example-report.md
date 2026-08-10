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

### Quick Wins (Difficulty <40)

| Keyword | Volume | Difficulty | Who Ranks |
|---------|--------|------------|-----------|
| saas marketing metrics | 1,200 | 32 | marketingpro.example #3 |
| b2b email sequences | 890 | 28 | chatvendor.example #5 |
| saas onboarding emails | 720 | 25 | Neither! |
| marketing qualified lead definition | 1,800 | 35 | marketingpro.example #1 |

### Content Format Gaps

**You're missing**:
- [ ] Interactive ROI calculator - the tool estimates ~15,000 monthly visits to
      marketingpro.example's. An estimate, not a measurement: nobody outside the company can
      observe a competitor's traffic
- [ ] Email template library - chatvendor.example's, ~8,000 monthly visits on the same estimate
- [ ] Marketing glossary - marketingpro.example's 120 definition pages rank for 500+ keywords
      between them (a keyword count, which the export does report directly)

## Recommended Content Calendar

**Week 1**: "SaaS Marketing Metrics: Complete Guide" — `saas marketing metrics` (quick win)
**Week 2**: "What is a Marketing Qualified Lead?" — `marketing qualified lead definition` (GEO opportunity)
**Week 3**: "B2B Email Sequences: Templates and Onboarding Flows" — covers both
`b2b email sequences` and `saas onboarding emails`, one intent and one page; the second is the
only gap in the table neither competitor holds
**Week 4**: "[Your Tool] vs marketingpro.example" — comparison gap
```
