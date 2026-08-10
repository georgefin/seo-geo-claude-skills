# CITE Domain Authority Report — Example

Full example audit output for reference. See the [SKILL.md](../SKILL.md) for the complete
workflow and [score-arithmetic.md](./score-arithmetic.md) for how each derived figure below
is composed. Every number in this example recomputes from the tables around it — that is
part of what it is demonstrating.

## Example

**User**: "Audit domain authority for cloudhosting.com as a content publisher"

**Output**:

```markdown
## CITE Domain Authority Report

### Overview

- **Domain**: cloudhosting.com
- **Domain Type**: Content Publisher
- **Audit Date**: 2025-02-03
- **CITE Score**: 68.5/100 (Medium)
- **Veto Status**: ✅ No triggers

#### Veto Check (Emergency Brake)

| Veto Item | Status | Action |
|-----------|--------|--------|
| T03: Link-Traffic Coherence | ✅ Pass | Link growth correlates with traffic growth |
| T05: Backlink Profile Uniqueness | ✅ Pass | No PBN patterns detected; diverse link sources |
| T09: Penalty & Deindex History | ✅ Pass | No manual actions; clean penalty history |

### Dimension Scores

| Dimension | Score | Items (Pass/Partial/Fail) | Rating | Weight | Weighted |
|-----------|-------|:-------------------------:|--------|--------|----------|
| C — Citation | 70/100 | 4/6/0 | Medium | 40% | 28.0 |
| I — Identity | 55/100 | 3/5/2 | Low | 15% | 8.25 |
| T — Trust | 80/100 | 6/4/0 | Good | 20% | 16.0 |
| E — Eminence | 65/100 | 5/3/2 | Medium | 25% | 16.25 |
| **CITE Score** | | | | | **68.5/100** |

**Score Calculation**:
- Dimensions from their item tallies (all 40 items scored, no N/A): C = 4×10 + 6×5 = 70 · I = 3×10 + 5×5 = 55 · T = 6×10 + 4×5 = 80 · E = 5×10 + 3×5 = 65
- CITE Score = 70 × 0.40 + 55 × 0.15 + 80 × 0.20 + 65 × 0.25 = 28.0 + 8.25 + 16.0 + 16.25 = 68.5 → **68.5/100 (Medium)**
- Points on the table: 400 raw points available, 270 scored, 130 lost — 18 Pass + 18 Partial + 4 Fail = 40 items, so lost = 18×5 + 4×10 = 130

**Rating Scale**: 90-100 Excellent | 75-89 Good | 60-74 Medium | 40-59 Low | 0-39 Poor

### Top 5 Priority Improvements

Sorted by: weight × points lost (highest impact first). Potential gain = recoverable points
(10 from Fail, 5 from Partial) × that dimension's weight.

1. **C05 AI Citation Volume** — Increase citations in AI-generated answers
   - Current: Partial | Potential gain: 5 × 40% = 2.0 weighted points | Evidence: graded Partial in the dimension table above | Confidence: Likely (sampled AI answers, not exhaustive)
   - Action: Optimize top 10 pages for GEO; add definitive statements AI can quote directly

2. **I01 Knowledge Graph Presence** — Create entity entry in Google Knowledge Graph
   - Current: Fail | Potential gain: 10 × 15% = 1.5 weighted points | Evidence: graded Fail in the dimension table above (no entity entry found) | Confidence: Confirmed
   - Action: Create Wikidata entry for CloudHost Inc. with P856 (website), P452 (industry), P571 (inception)

3. **E04 Content Freshness Cadence** — 40% of content is >12 months without update
   - Current: Partial | Potential gain: 5 × 25% = 1.25 weighted points | Evidence: content inventory, 40% of URLs >12 months old | Confidence: Confirmed
   - Action: Establish monthly content refresh schedule; prioritize top 20 traffic pages

4. **I03 Brand SERP Control** — Branded SERP shows only 4 of 10 results from owned properties
   - Current: Partial | Potential gain: 5 × 15% = 0.75 weighted points | Evidence: branded-SERP scan, 4 of 10 results owned | Confidence: Confirmed
   - Action: Claim Google Business Profile; build out social profiles; create CrunchBase entry

5. **I05 Schema.org Completeness** — Organization schema missing sameAs, founder, foundingDate
   - Current: Partial | Potential gain: 5 × 15% = 0.75 weighted points | Evidence: markup crawl, properties absent from Organization schema | Confidence: Confirmed
   - Action: Add complete Organization schema with sameAs links to Wikidata, LinkedIn, CrunchBase

These five together are worth 2.0 + 1.5 + 1.25 + 0.75 + 0.75 = **6.25 weighted points** — the sum of the individual gains, no more.

### Action Plan

#### Quick Wins (< 1 week)
- [ ] Add sameAs, founder, and foundingDate to Organization schema
- [ ] Claim Google Business Profile for branded SERP control

#### Medium Effort (1-4 weeks)
- [ ] Create Wikidata entry with complete properties and references
- [ ] Optimize top 10 pages with GEO-friendly definitive statements
- [ ] Create or complete CrunchBase, LinkedIn company page profiles

#### Strategic (1-3 months)
- [ ] Launch monthly content refresh program targeting stale pages
- [ ] Build topical authority through 3-4 pillar content clusters
- [ ] Pursue digital PR to earn mentions on industry publications (TechCrunch, G2)

### Cross-Reference with CORE-EEAT

| Assessment | Score | Rating |
|-----------|-------|--------|
| CITE (Domain) | 68.5/100 | Medium |
| CORE-EEAT (Content) | Run content-quality-auditor on sample pages | — |

**Diagnosis**: Medium CITE + unknown CORE-EEAT → Run `/seo:audit-page` on top 5 landing pages to determine whether to prioritize content quality or domain authority first.

### Recommended Next Steps

- For entity building: run [entity-optimizer](../entity-optimizer/) to strengthen I-dimension signals
- For content audit: use [content-quality-auditor](../content-quality-auditor/) on key pages
- For tracking progress: run `/seo:report` with CITE score trends quarterly
```
