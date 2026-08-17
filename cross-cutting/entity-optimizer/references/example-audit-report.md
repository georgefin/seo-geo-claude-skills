# Example: Entity Optimization Report

Full example output for an entity audit request.

**User**: "Audit entity presence for CloudMetrics, our B2B SaaS analytics platform at cloudmetrics.io"

**Output**:

```markdown
## Entity Optimization Report

### Entity Profile

**Entity Name**: CloudMetrics
**Entity Type**: Organization (B2B SaaS)
**Primary Domain**: cloudmetrics.io
**Target Topics**: analytics platform, business intelligence, enterprise analytics

### AI Entity Resolution Test

Queries tested with results reported by user:

| Query | Result | Assessment |
|-------|--------|------------|
| "What is CloudMetrics?" | Described as "an analytics tool" with no further detail | Partial recognition -- generic description, no mention of B2B focus or key features |
| "Best analytics platforms for enterprises" | CloudMetrics not mentioned in any AI response | Not recognized as a player in the enterprise analytics space |
| "CloudMetrics vs Datadog" | Correctly identified as a competitor to Datadog, but feature comparison was incomplete and partially inaccurate | Partial -- entity is associated with the right category but attributes are thin |
| "Who founded CloudMetrics?" | No answer found by any AI system tested | Entity leadership not present in AI knowledge bases |

### Entity Health Summary

Seven categories, each scored over its own signals (✅ 1 · ⚠️ 0.5 · ❌ 0) with the count printed:
Strong at 80%+, Gaps from 40%, Missing below 40%. Signals nothing in the inputs can settle are
excluded and named rather than failed.

| Signal Category | Status | Key Findings |
|-----------------|--------|--------------|
| Structured Data | ⚠️ Gaps — 1.5 of 3 = 50.0% | Organization schema on the homepage carries name, url and logo but no description (⚠️); no sameAs links to any external profile (❌); the same @id on all five pages checked (✅). Signal 47 excluded — no subdomains |
| Knowledge Base | ❌ Missing — 3 of 8 = 37.5% | No Wikidata entry and no Knowledge Panel for any branded query (❌); LinkedIn, Crunchbase and the G2 industry listing complete (✅ ×3); no Wikipedia article and only 2 independent sources, short of the 3 the notability path needs (❌); no DBpedia entry, no Knowledge Graph ID (❌). Five signals excluded — Knowledge Panel attributes and image, Wikidata property depth and language labels (no entry to review), ISNI/VIAF (organisation, not person) |
| Consistency (NAP+E) | ✅ Strong — 3.5 of 4 = 87.5% | Contact details match across LinkedIn, Twitter/X, G2 and Crunchbase (✅); one name format everywhere (✅); the same bio on every platform (✅); links run from the social profiles to cloudmetrics.io but not back from the site (⚠️) |
| Content-Based | ⚠️ Gaps — 3 of 6 = 50.0% | Site is in the branded top 5 but owns no Knowledge Panel (⚠️); About page opens with marketing copy, not an entity-defining sentence (⚠️); 14 pages of depth on the three target topics (✅); the entity is named contextually through the content, not only in the chrome (✅); no author or leadership pages (❌); no original research or data (❌). Backlink profile and branded anchor text excluded — no link data supplied |
| Third-Party | ⚠️ Gaps — 2.0 of 5 = 40.0% | G2 reviews exist with usable volume (✅); AI answers place the entity beside Datadog but the inputs show no published "X vs Y" page, so co-citation is partial (⚠️); 2 press mentions against the 3 the signal asks for (⚠️); no awards, no speaking or contributed publications (❌ ×2). Branded search volume and social engagement excluded — neither was measured. 40.0% sits exactly on a boundary and takes the higher status |
| AI-Specific | ⚠️ Gaps — 3 of 7 = 42.9% | No competing entity dominates the branded query (✅); robots.txt allows the AI crawlers (✅); ChatGPT returns a generic "analytics tool" description (⚠️); topic association is right but thin (⚠️); the Datadog comparison contained factual errors (❌); no quotable definition on the About page (❌); key entity pages last updated 8 months ago, past the 6-month line (❌). Perplexity, AI Overview and claim verification excluded — not tested in this round |
| Google Business Profile | Not applicable | Fully remote B2B SaaS with no public premises; all 7 GBP checks fall away. Recorded so the category is not silently dropped |

### Top 3 Priority Actions

Ordered impact first, then ascending effort — the two High/Low actions precede the High/High one.

1. **Create Wikidata entry** with key properties: instance of (P31: business intelligence software company), official website (P856: cloudmetrics.io), inception (P571), country (P17)
   - Impact: High | Effort: Low
   - Why: a Wikidata entry is a public, structured record of the entity that anyone can read, check and correct — including the client, and including any consumer that chooses to read it. That is true whatever any engine does with it, which is the reason to write one. (What this line used to say — that Wikidata *feeds* Google Knowledge Graph, Bing and AI training pipelines — is withdrawn: see the `[VERIFY]` note in `knowledge-graph-guide.md`. No engine-primary source for that pipeline was read here.)

2. **Add Person schema for leadership team** on the About/Team page, including name, jobTitle, sameAs links to LinkedIn profiles, and worksFor pointing to the Organization entity
   - Impact: High | Effort: Low
   - Why: Addresses the "Who founded CloudMetrics?" gap directly; Person schema for key people creates bidirectional entity associations that strengthen organizational identity

3. **Build Wikipedia notability through independent press coverage** -- target 3-5 articles in industry publications (TechCrunch, VentureBeat, Analytics India Magazine) that mention CloudMetrics by name with verifiable claims
   - Impact: High | Effort: High
   - Why: Wikipedia notability requires coverage in independent reliable sources; press mentions simultaneously feed AI training data, build third-party entity signals, and create the citation foundation for a future Wikipedia article

### Cross-Reference

- **CORE-EEAT**: A07 (Knowledge Graph Presence) scored Fail, A08 (Entity Consistency) scored Pass -- entity optimization should focus on knowledge base gaps rather than consistency
- **CITE**: I-dimension weakest area is I01 (Knowledge Graph Presence) -- completing Wikidata entry and earning Knowledge Panel directly improves domain identity score
```
