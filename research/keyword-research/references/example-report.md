# Keyword Research — Example Report

This is a complete example output showing the expected format for keyword research deliverables.

> **Note on the source label below**: the example names Ahrefs because a deliverable names the
> tool its figures actually came from. Substitute whichever tool was connected, or the export
> or hand-check the numbers came from; where nothing supplied them, say so and leave the figure
> out. A `~~category` token addresses the operator and never appears inside the report (root
> `CLAUDE.md` Tool Connector Pattern; anti-slop-ruleset.md §6 family 7).

## Prompt

**User**: "Research keywords for a project management software company targeting small businesses"

## Example Output

```markdown
# Keyword Research Report: Project Management Software

**Generated**: [current month and year]
**Target Audience**: Small business owners and teams
**Business Goal**: Software signups and trials
**Assumptions (stated up front — single-turn rule)**: EN/US market assumed; business goal assumed to be signups/trials (not stated in the prompt); no site-maturity data provided
**Data sources**: volume and difficulty figures are Ahrefs estimates; intent is analyst-classified; metrics the tool does not report appear as "N/A — not tool-reported"

## Executive Summary

- Total keywords screened: 150+
- Opportunities scored below: 8 (5 quick wins + 3 growth), plus 5 GEO candidates carried without an Opportunity score because Ahrefs reports no difficulty for them
- Combined monthly search volume of those 8: 44,190 — the sum of the Volume column below (5,690 quick wins + 38,500 growth), not a traffic forecast: turning volume into sessions needs a position and a click-share assumption this report does not make
- Recommended focus areas:
  - Task management workflows
  - Team collaboration
  - Small business productivity

## Top Keyword Opportunities

**Opportunity = (Volume × Intent Value) ÷ Difficulty**, with Intent Value 1 informational and
navigational, 2 commercial, 3 transactional (Step 7). Volume and difficulty are the Ahrefs figures
in each row, so every score below reproduces from its own line — the top one is
(2,400 × 2) ÷ 35 = 137.1. It is a **ratio, not a mark out of 100**: it has no ceiling, and 137.1
means "better return per unit of difficulty than 85.7", nothing more. One decimal, half up.

The two sections group by how soon a site can realistically rank, which is not the same ordering
as the score: the formula is driven by volume, so the head terms in Growth score far higher than
the Quick Wins above them. Read the score within a section.

### Quick Wins (Priority: Immediate)

| Keyword | Volume | Difficulty | Intent | Opportunity |
|---------|--------|------------|--------|-------------|
| best free project management tool | 2,400 | 35 | Commercial | 137.1 |
| project management for small teams | 1,200 | 28 | Commercial | 85.7 |
| simple task management software | 890 | 25 | Commercial | 71.2 |
| project tracking spreadsheet alternative | 480 | 18 | Commercial | 53.3 |
| how to manage remote team projects | 720 | 22 | Informational | 32.7 |

### Growth Keywords (Priority: 3-6 months)

| Keyword | Volume | Difficulty | Intent | Opportunity |
|---------|--------|------------|--------|-------------|
| project management software | 18,000 | 72 | Commercial | 500.0 |
| project management app | 12,000 | 68 | Commercial | 352.9 |
| best project management tools [current year] | 8,500 | 65 | Commercial | 261.5 |

### GEO Opportunities (AI-citation potential)

AI Potential is 1 star for matching a high-GEO query format plus 1 star for each of the four AI
answer indicators the keyword meets (Step 8) — 5 stars maximum, and the count and the missing
indicator are printed so the rating can be argued with.

| Keyword | Type | Volume | Difficulty | Intent | AI Potential | Recommended Format |
|---------|------|--------|------------|--------|--------------|-------------------|
| what is project management | Definition | 2,200 | N/A — not tool-reported | Informational | ⭐⭐⭐⭐⭐ 5/5 | Clear definition + methodology |
| agile vs waterfall | Comparison | N/A — not tool-reported | N/A — not tool-reported | Informational | ⭐⭐⭐⭐⭐ 5/5 | Side-by-side comparison table |
| project management methodologies | List | N/A — not tool-reported | N/A — not tool-reported | Informational | ⭐⭐⭐⭐ 4/5 — the answer is a long list, not a concise one | Comprehensive list with pros/cons |
| how to create a project plan | How-to | 1,400 | N/A — not tool-reported | Informational | ⭐⭐⭐⭐ 4/5 — procedural, not factual/definitional | Step-by-step guide |
| project management best practices | List | 1,200 | N/A — not tool-reported | Informational | ⭐⭐⭐⭐ 4/5 — the answer is a long list, not a concise one | Numbered best practices |

*GEO/conversational tables keep the Volume / Difficulty / Intent columns. Tool-reported metrics are shown where they exist (these volumes match the cluster data below); unreported metrics — typical for conversational phrasings, and true of difficulty for these question-format keywords in this example — get an explained N/A, never an invented number.*

## Topic Clusters

### Cluster 1: Project Management Fundamentals

**Pillar**: "Complete Guide to Project Management" (8,500 volume)

Cluster articles:
1. What is project management? (2,200 volume)
2. Project management methodologies explained (1,800 volume)
3. How to create a project plan (1,400 volume)
4. Project management best practices (1,200 volume)
5. Project management roles and responsibilities (890 volume)

### Cluster 2: Team Collaboration

**Pillar**: "Team Collaboration Tools Guide" (4,200 volume)

Cluster articles:
1. How to improve team communication (1,600 volume)
2. Remote team management tips (1,400 volume)
3. Best practices for distributed teams (920 volume)
4. Team productivity tools comparison (780 volume)

## Content Calendar Recommendations

| Month | Content | Target Keyword | Type |
|-------|---------|----------------|------|
| Week 1 | Simple Task Management Guide | simple task management software | Blog + Demo |
| Week 2 | Project Management for Small Teams | project management for small teams | Pillar Page |
| Week 3 | Agile vs Waterfall: Complete Comparison | agile vs waterfall | Comparison |
| Week 4 | Free PM Tools Roundup | best free project management tool | Listicle |

## Next Steps

1. **Immediate**: Create landing pages for top 5 quick-win keywords
2. **Week 1-2**: Write pillar content for "Project Management Fundamentals"
3. **Week 3-4**: Build out cluster content with internal linking
4. **Ongoing**: Track rankings and adjust strategy based on performance
```
