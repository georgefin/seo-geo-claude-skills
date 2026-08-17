# Knowledge Panel & Wikidata Optimization Guide

Detailed instructions for Knowledge Panel optimization, Wikidata entry management, and AI entity resolution.

## Knowledge Panel Optimization

### Claiming and Editing

1. **Google Knowledge Panel**: Claim via Google's verification process (search for entity -> click "Claim this knowledge panel")
2. **Bing Knowledge Panel**: Driven by Wikidata and LinkedIn -- update those sources
3. **AI Knowledge**: Driven by training data -- ensure authoritative sources describe entity correctly

### Common Knowledge Panel Issues

| Issue | Root Cause | Fix |
|-------|-----------|-----|
| No panel appears | Entity not in Knowledge Graph | Build Wikidata entry + structured data + authoritative mentions |
| Wrong image | Image sourced from incorrect page | Update Wikidata image; ensure preferred image on About page and social profiles |
| Wrong description | Description pulled from wrong source | Edit Wikidata description; ensure About page has clear entity description in first paragraph |
| Missing attributes | Incomplete structured data | Add properties to Schema.org markup and Wikidata entry |
| Wrong entity shown | Disambiguation failure | Strengthen unique signals; add qualifiers; resolve Wikidata disambiguation |
| Outdated info | Source data not updated | Update Wikidata, About page, and all profile pages |

## Wikidata Best Practices

### Creating a Wikidata Entry

1. **Check notability**: Entity must have at least one authoritative reference
2. **Create item**: Add label, description, and aliases in relevant languages
3. **Add statements**: instance of, official website, social media links, founding date, founders, industry
4. **Add identifiers**: official website (P856), social media IDs, CrunchBase ID, ISNI, VIAF
5. **Add references**: Every statement should have a reference to an authoritative source

**Important**: Wikipedia's Conflict of Interest (COI) policy prohibits individuals and organizations from creating or editing articles about themselves. Instead of directly editing Wikipedia: (1) Focus on building notability through independent reliable sources (press coverage, industry publications, academic citations); (2) If you believe a Wikipedia article is warranted, consider engaging an independent Wikipedia editor through the Requested Articles process; (3) Ensure all claims about the entity are verifiable through third-party sources before any Wikipedia involvement.

### Key Wikidata Properties by Entity Type

| Property | Code | Person | Org | Brand | Product |
|----------|------|:------:|:---:|:-----:|:-------:|
| instance of | P31 | human | organization type | brand | product type |
| official website | P856 | yes | yes | yes | yes |
| occupation / industry | P106/P452 | yes | yes | -- | -- |
| founded by | P112 | -- | yes | yes | -- |
| inception | P571 | -- | yes | yes | yes |
| country | P17 | yes | yes | -- | -- |
| social media | various | yes | yes | yes | yes |
| employer | P108 | yes | -- | -- | -- |
| developer | P178 | -- | -- | -- | yes |

## AI Entity Optimization

### The Working Model This Library Optimises Against

> **Evidence grade — read before quoting any of this.** What follows is a **mental model
> used to order work**, not documented engine behaviour. No engine publishes how it resolves
> a mention to an entity or how it picks sources. This section previously stated the pipeline
> below as fact ("AI systems follow this pipeline") and tabled "What AI Checks" per signal;
> ruling R3 amendment 9a retracted a claim of that shape on the ground that **no primary
> source establishes it in either direction**. The model is still how this library decides
> what to fix first. It is never written into a client deliverable as a mechanic.

```
User query -> Entity extraction -> Entity resolution -> Knowledge retrieval -> Answer generation
```

Each stage names a way the brand can be got wrong, and that is what makes the model useful:
the name is not recognised as a name; it is recognised but matched to something else; it is
matched correctly but the facts retrieved are stale or contradictory; the answer is right but
attributes it to somebody else's page.

### Where This Library Puts the Work, and What Each Item Actually Fixes

| Area | What the work puts in place, checkable by you | How to Optimize |
|-------------|---------------|-----------------|
| **Presence in widely-read sources** | The brand appears in records that are public, permanent and not yours to write | Get mentioned in high-quality, widely-crawled sources |
| **Live search presence** | The brand's own pages hold page one for its own name | Strong SEO presence for branded queries |
| **Structured data** | The entity carries stable identifiers a machine can match, instead of a name a machine has to guess at | Complete Wikidata + Schema.org |
| **Contextual co-occurrence** | The brand and its topics appear together often enough that the pairing is visible in the record | Build consistent topic associations across content |
| **Source quality** | The sources that describe the entity are named, dated and checkable | Get mentioned by authoritative, well-known sources |
| **Recency** | Every profile states the same current facts, with nothing contradicting anything else | Keep all entity profiles and content updated |

### Entity-Specific GEO Tactics

1. **Define clearly**: The first paragraph of the About page defines the entity in 25-50 words that can be lifted out and still say what the thing is
2. **Be consistent**: Use identical entity description across all platforms
3. **Build associations**: Create content that explicitly connects entity to target topics
4. **Earn mentions**: A third-party mention is a record a competitor cannot rewrite and the client cannot author; a self-description is neither
5. **Stay current**: An outdated profile contradicts the current ones, and the client cannot control which of the two a reader or a machine finds first
