# CITE Domain Authority Report — Example

Full example audit output for reference. See the [SKILL.md](../SKILL.md) for the complete
workflow and [score-arithmetic.md](./score-arithmetic.md) for how each derived figure below
is composed. Every number in this example recomputes from the tables around it — that is
part of what it is demonstrating.

## Example

**User**: "Audit domain authority for cloudhosting.example as a content publisher"

**Output**:

```markdown
<!-- ILLUSTRATIVE FILL — cloudhosting.example is invented and so is every figure below; nobody
     measured any of it. It is here to show the shape of a finished report and what each
     derived number has to recompute from. Replace all of it with the audited domain's own
     measured data, and delete this comment. -->
## Domain Authority Audit

*Scored against CITE — our 40-item domain-authority benchmark. Gloss it on first use like this; the bare acronym names a document the client has never seen.*

### Overview

- **Domain**: cloudhosting.example
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

1. **AI Citation Frequency** — Increase citations in AI-generated answers
   - Current: Partial | Potential gain: 5 × 40% = 2.0 weighted points | Evidence: graded Partial in the dimension table above | Confidence: Likely (sampled AI answers, not exhaustive)
   - Action: Optimize top 10 pages for GEO; add definitive statements that still say something true when lifted out of their paragraph

2. **Knowledge Graph Presence** — Create entity entry in Google Knowledge Graph
   - Current: Fail | Potential gain: 10 × 15% = 1.5 weighted points | Evidence: graded Fail in the dimension table above (no entity entry found) | Confidence: Confirmed
   - Action: Create Wikidata entry for CloudHost Inc. with P856 (website), P452 (industry), P571 (inception)

3. **Content Freshness Signal** — 40% of content is >12 months without update
   - Current: Partial | Potential gain: 5 × 20% = 1.0 weighted points | Evidence: content inventory, 40% of URLs >12 months old | Confidence: Confirmed
   - Action: Establish monthly content refresh schedule; prioritize top 20 traffic pages

4. **Brand SERP Ownership** — Branded SERP shows only 4 of 10 results from owned properties
   - Current: Partial | Potential gain: 5 × 15% = 0.75 weighted points | Evidence: branded-SERP scan, 4 of 10 results owned | Confidence: Confirmed
   - Action: Claim Google Business Profile; build out social profiles; create CrunchBase entry

5. **Schema.org Coverage** — Organization schema present but incomplete: sameAs, founder and foundingDate absent
   - Current: Partial | Potential gain: 5 × 15% = 0.75 weighted points | Evidence: markup crawl, properties absent from Organization schema | Confidence: Confirmed
   - Action: Add complete Organization schema with sameAs links to Wikidata, LinkedIn, CrunchBase

These five together are worth 2.0 + 1.5 + 1.0 + 0.75 + 0.75 = **6.0 weighted points** — the sum of the individual gains, no more.

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
| CORE-EEAT (Content) | Not yet evaluated | — |

**Diagnosis**: domain authority is mid-range, and page-level content quality has not been measured
yet, so we cannot say which of the two is holding the site back. A content review of the top five
landing pages settles it, and is the cheaper of the two to run first.
```

The client's report ends at that fence.

**Why row 3 of the Top 5 is worth 1.0 and not 1.25** — a note for whoever runs this audit, not
part of the report above. Each potential gain takes the weight of the dimension its item belongs
to, and freshness is `CITE-T08`, a Trust item at 20%, not an Eminence item at 25%. Read the item
ID off [cite-domain-rating.md](../../../references/cite-domain-rating.md) § 2 before multiplying:
the dimension letter in the ID *is* the weight selector, so a mis-attributed item prices the fix
wrongly even when the grade behind it is right. The Top 5 stays sorted by the gains as computed —
2.0 · 1.5 · 1.0 · 0.75 · 0.75 — and the closing sum equals those five numbers added, nothing else.

The follow-up runs go in a **separate fence of their own**, and the label lives **inside** it —
a model copies the fence, not the heading above it
(`CLAUDE.md` § The Value Rule, clause 2; the handoff sub-rule is
[inter-skill-handoff.md § 3.1](../../../references/inter-skill-handoff.md)). Continuing the same
example:

```markdown
<!-- OPERATOR BLOCK — for the client's team, not part of the report above. Every row names a
     library run and carries its payload. Nothing in this fence goes to the client as written. -->
### Next steps for your team

| Run | Why | Payload |
|-----|-----|---------|
| `content-quality-auditor` | Settles the diagnosis above — domain authority is mid-range and content is unmeasured | cloudhosting.example, Content Publisher · the 5 landing pages, one row each · `CITE C:70 I:55 T:80 E:65` · vetoes `CITE-T03` pass, `CITE-T05` pass, `CITE-T09` pass · audited 2025-02-03 |
| `entity-optimizer` | Identity is the weakest dimension (55/100) and carries three of the top 5 priorities | cloudhosting.example, Content Publisher · priority `CITE-I01, CITE-I03, CITE-I04` · `CITE C:70 I:55 T:80 E:65` · audited 2025-02-03 |
| `/seo:report` | Quarterly trend tracking against this baseline | cloudhosting.example · baseline `CITE C:70 I:55 T:80 E:65`, audited 2025-02-03 |
```

The CORE-EEAT field is absent from every row because no content audit exists yet — that absence is
the reason for row 1, and it is named rather than estimated.
