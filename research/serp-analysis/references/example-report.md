# SERP Analysis — Example Report

This is a complete example output showing the expected format for SERP analysis deliverables.

> **Illustrative example — the figures below are not measurements.** Every domain uses the
> reserved `.example` TLD so no real business is described, and every DA, word count and
> backlink count is a made-up value chosen to show the output shape. In real output each of
> them comes from ~~SEO tool, a user-supplied export, or direct observation of the live SERP,
> and is reported with that source and the date it was pulled — never assigned to a domain you
> have no data for (statistics rule: sourced, cited, or placeholder, never invented). Note
> where the `~~` token sits: on this side of the code fence, where the reader is the operator.
> Inside the deliverable it resolves to the tool's real name or to the source in plain language.

## Prompt

**User**: "Analyze the SERP for 'how to start a podcast'"

## Example Output

```markdown
# SERP Analysis: "how to start a podcast"

## SERP Overview

**Intent**: Informational — 9 of the 9 elements classified (AI Overview, featured snippet, PAA
block, video carousel, and all five organic results in the top 5) point informational; 0 commercial,
0 transactional
**Difficulty**: 75/100 (High) — DA 75 ×5, links 90 ×4, content bar 60 ×4, ÷13 = 75. Page authority
and SERP stability not scored (no page-level pull; single snapshot, so nothing to compare), so
0.35 of the matrix was renormalised away; the working is under Difficulty below
**AI Overview**: Yes - comprehensive guide format
**SERP captured**: desktop, EN/US, 3 August 2026

### SERP Features Present

| Feature | Present | Analysis |
|---------|---------|----------|
| AI Overview | ✅ | Lists steps, cites 3 sources |
| Featured Snippet | ✅ | Step-by-step list from podcasthost.example |
| People Also Ask | ✅ | 4 questions visible, expandable |
| Video Results | ✅ | 3 videos mid-page |
| Image Pack | ❌ | |

### Top 5 Results Analysis

| Pos | Domain | DA | Word Count | Format | Backlinks |
|-----|--------|-----|------------|--------|-----------|
| 1 | podcasthost.example | 71 | 8,500 | Ultimate Guide | 2,400 |
| 2 | musicstreamer.example | 93 | 3,200 | How-to Guide | 890 |
| 3 | podcastblog.example | 58 | 12,000 | Mega Guide | 1,800 |
| 4 | audiotools.example | 62 | 5,500 | Tutorial | 720 |
| 5 | marketingblog.example | 91 | 6,200 | Complete Guide | 1,100 |

### Why #1 Ranks First

podcasthost.example's guide succeeds because:
1. **Comprehensive** - Covers every step in detail
2. **Updated** - Current year in title, recent updates
3. **Structured** - Clear numbered steps (owns featured snippet)
4. **Topically focused** - A podcast hosting company writing about podcasting
5. **Supporting content** - Links to detailed sub-guides

What the table does *not* support: DA does not order this SERP. #1 sits at DA 71 while #2 and
#5 sit at 93 and 91, so domain strength is not what separates them here — do not report it as
the reason.

### Featured Snippet Opportunity

**Current format**: Ordered list (steps)
**Current holder**: podcasthost.example (also the #1 organic result)

**To win snippet**:
- Create cleaner, more scannable list format
- Keep steps to 8-10 items max
- Start each step with action verb
- Include "how to start a podcast" in H2

### AI Overview Analysis

**Sources cited** (3, matching the feature table above):
1. podcasthost.example - "Choose your podcast topic"
2. musicstreamer.example - "Record and edit"
3. encyclopedia.example - Definition of podcasting

**Pattern**: AI pulls step-by-step instructions from guides with clear structure. Two of the
three citations are in the organic top 5 and the third is not, so the citation set and the
ranking set overlap without being the same list.

### Content Requirements

What the current top 5 show — read off the table above, thresholds rather than guarantees:
- **Word count**: 3,200-12,000, median 6,200. The #2 result is the shortest page on the SERP,
  so length is not the gate; match the coverage the top results show rather than a word target.
- **Format**: Step-by-step guide - all five results use one
- **Backlinks**: 720 is the lowest count in the top 5, 2,400 the highest. Treat ~700 as the
  floor observed on this SERP, not a number to reach before publishing.
- **Freshness**: the #1 result carries the current year in its title; check the other four on
  the live SERP rather than assuming
- **Unique angle**: Equipment comparisons, cost breakdowns, or specific niche focus

### Difficulty

| Factor | Measured value | Sub-score /100 | Weight | Weight used |
|--------|----------------|----------------|--------|-------------|
| Domain Authority | mean DA of the five captured results: (71+93+58+62+91) ÷ 5 = 75 | 75 | 25% | 0.25/0.65 |
| Page Authority | not pulled | — | 20% | not scored |
| Backlinks Required | median page backlinks of the five: 720, 890, **1,100**, 1,800, 2,400 → 1,000+ band | 90 | 20% | 0.20/0.65 |
| Content Quality Bar | 3 — thorough coverage across all five, no original data or tooling on any of them | 60 | 20% | 0.20/0.65 |
| SERP Stability | single pull, nothing to compare against | — | 15% | not scored |

`(75 × 5 + 90 × 4 + 60 × 4) ÷ 13 = 975 ÷ 13 = **75** → High (70-100)`. The population is the five
results captured, not ten — a top-10 pull would move the mean DA and could move the score.

### Recommended Strategy

Given high difficulty (75/100), consider:
1. Target long-tail: "how to start a podcast for free" — Ahrefs KD 45; not SERP-scored here, and
   KD is a different instrument from the 75 above, so the two do not belong in one ranking
2. Target niche: "how to start a podcast about [topic]" — Ahrefs KD 30, same caveat
3. Create supporting video content for video carousel
4. Focus on PAA optimization for quick wins
```
