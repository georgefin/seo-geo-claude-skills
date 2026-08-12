# Knowledge Graph Optimization Guide

> Part of [entity-optimizer](../SKILL.md). See also: [entity-signal-checklist.md](./entity-signal-checklist.md)

Comprehensive playbook for establishing and maintaining entity presence across Google Knowledge Graph, Wikidata, Wikipedia, and other knowledge bases.

> **No timelines and no rankings in this file (rule, applied 2026-08-12).** Two claim shapes are
> banned here because nothing measures either and both travel into client deliverables as
> commitments: **(a) a timescale for something another party decides** — when Google creates,
> restores or corrects a panel, when an AI system refreshes — and **(b) a ranking or superlative
> among entity signals** ("most direct path", "strongest single signal", "most impactful"). A
> timescale for work *you* perform is a different thing and is allowed, labelled as effort.
> What Google actually documents: panels are "created automatically by Google Search Algorithm
> when there is enough information available on the open web", the sources are described no more
> precisely than public sources, licensed data and submissions from claimants, **Wikidata and
> Wikipedia are not named, no timeframe is stated**, and display "isn't something we can or would
> influence" (primary: support.google.com/knowledgepanel/answer/9787176 — live-page read
> 2026-08-12; re-check if Google republishes the page). Sequence advice — do Wikidata first
> because you can edit it directly — survives all of this; the numbers and the rankings do not.

## How Knowledge Graphs Work

### The Entity Web

Knowledge graphs are interconnected databases of entities and their relationships. Search engines and AI systems use them as ground truth for entity understanding.

```
Your Entity
├── is described by → Wikidata entry
├── is described by → Wikipedia article
├── is described by → Schema.org markup on your site
├── is linked to → Social profiles (LinkedIn, X, etc.)
├── is mentioned by → News articles, industry sites
├── is associated with → Topics, industries, other entities
└── is recognized by → Google Knowledge Graph, Bing Satori, AI training data
```

### Which Knowledge Graphs Matter

| Knowledge Graph | Who Uses It | Impact |
|----------------|-------------|--------|
| **Google Knowledge Graph** | Google Search, Google AI | Powers Knowledge Panels, rich results, entity understanding in search |
| **Wikidata** | Google, Bing, Apple, Amazon, AI systems | Open data feeds multiple knowledge graphs; primary structured data source |
| **Wikipedia** | Widely reused by search and AI systems | Openly licensed and heavily reused as reference text; its role in panel descriptions is not documented by Google and is not assertable |
| **Bing Satori** | Bing, Copilot | Powers Bing's entity understanding and Microsoft Copilot |
| **Schema.org (your site)** | All search engines, AI crawlers | First-party structured data you control directly |
| **DBpedia** | Research, some AI systems | Auto-extracted from Wikipedia; relevant for academic/research entities |

### Data Flow

```
Your Website (Schema.org) ─┐
Wikidata ──────────────────┤
Wikipedia ─────────────────┼──→ Google Knowledge Graph ──→ Knowledge Panel
Industry Directories ──────┤                              AI Search Results
News/Media Mentions ───────┤                              Rich Results
Social Profiles ───────────┘
```

Understanding this flow is key: you influence the Knowledge Graph by controlling the **source signals** that feed it.

## Google Knowledge Graph

### Getting Into the Knowledge Graph

There is no "submit to Knowledge Graph" form, and Google states that panel display is not something it influences on request. Google describes its sources only in the abstract, so the list below is **not ranked** — nothing published supports an ordering, and any "strongest signal" claim is invented. Work them in the order of what you can control:

1. **Have a Wikidata entry** — openly editable by you, so it is the fastest to act on
2. **Earn a Wikipedia article** — not directly actionable; reached only through independent coverage (see COI policy below)
3. **Implement Schema.org markup** — first-party structured self-description you control outright
4. **Get mentioned on authoritative sites** — third-party validation you can influence but not author
5. **Build branded search demand** — evidence that people look for the entity by name

### Checking Your Knowledge Graph Status

**Method 1: Google Search**
Search for your entity name in quotes. If a Knowledge Panel appears on the right, you're in the Knowledge Graph.

**Method 2: Knowledge Graph API**
```
GET https://kgsearch.googleapis.com/v1/entities:search?query=[entity]&key=[API_KEY]
```

Response includes:
- `@id`: Your Knowledge Graph ID (e.g., `kg:/m/0wrt4g`)
- `name`: Entity name as Google understands it
- `description`: Short entity description
- `detailedDescription`: Longer description — read its own `url` and `license` sub-fields to see where that text came from, rather than assuming a source
- `resultScore`: Confidence score (higher = more established entity)

**Method 3: ~~knowledge graph**
If connected, query directly for entity status and attributes.

### Claiming Your Knowledge Panel

1. Search for your entity on Google
2. If Knowledge Panel appears, look for "Claim this knowledge panel" link at bottom
3. Verify via official website, Search Console, YouTube, or other Google property
4. Once claimed, you can suggest edits (but Google has final say)

### Common Knowledge Panel Fixes

| Problem | Solution |
|---------|----------|
| **No Knowledge Panel** | Build Wikidata entry + Schema.org + authoritative mentions. **No timeline** — creation is Google's automated decision, it publishes no expected window, and any date you give a client is invented. Report the work done and the signals now in place, never an ETA. |
| **Wrong image** | Update preferred image on: Wikidata (P18), About page, social profiles. Claim panel and suggest preferred image. |
| **Wrong description** | Edit Wikidata description. Update first paragraph of About page and Wikipedia article. |
| **Missing attributes** | Add properties to Wikidata and Schema.org. Claim panel and suggest additions. |
| **Outdated information** | Update Wikidata, About page, Wikipedia, and social profiles. Request refresh via claimed panel. |
| **Wrong entity shown** | Disambiguation needed. See Wikidata section below for disambiguation strategy. |

## Wikidata

### Why Wikidata Is Critical

Wikidata earns first place in the work order for one checkable reason: **it is openly editable and CC0-licensed, so it is the entity surface you can correct directly rather than petition.** Everything else on the list is someone else's property.

What is *not* established, and must not be written into a deliverable: that Google, Bing or any assistant uses Wikidata as a panel or answer source, in what weight, or with what effect. Google names no sources beyond "public sources" plus licensed data plus claimant submissions, and names Wikidata nowhere. Reuse of Wikidata dumps is real and public, but no published measurement connects an item to a panel — so the honest framing is that a complete, referenced item makes the entity machine-resolvable, with what any engine then does with it left unclaimed.

### Creating a Wikidata Entry

#### Step 1: Check Eligibility

Wikidata has its own notability policy, and it is a different and looser test than Wikipedia's — read the current text at wikidata.org/wiki/Wikidata:Notability before advising, since it is a community policy that can change. In outline it turns on the item being identifiable by at least one serious, publicly available reference. Do not predict the outcome for a given entity: whether a particular company, product or person clears it is a call editors make on the item, and a client told they "typically qualify" will treat a deletion as your error.

#### Step 2: Create the Item

1. Go to https://www.wikidata.org/wiki/Special:NewItem
2. Fill in:
   - **Label**: Official entity name
   - **Description**: Short description (e.g., "American software company" or "SEO optimization tool")
   - **Aliases**: Alternative names, abbreviations, former names

#### Step 3: Add Core Statements

Essential properties for each entity type:

**Organizations:**
| Property | Code | Example |
|----------|------|---------|
| instance of | P31 | business (Q4830453) or specific type |
| official website | P856 | https://example.com |
| inception | P571 | 2020-01-15 |
| country | P17 | United States (Q30) |
| headquarters location | P159 | San Francisco (Q62) |
| industry | P452 | software industry (Q638608) |
| founded by | P112 | [founder's Wikidata item] |
| CEO | P169 | [CEO's Wikidata item] |

**Persons:**
| Property | Code | Example |
|----------|------|---------|
| instance of | P31 | human (Q5) |
| occupation | P106 | software engineer (Q183888) |
| employer | P108 | [company Wikidata item] |
| educated at | P69 | [university Wikidata item] |
| country of citizenship | P27 | [country item] |
| official website | P856 | https://example.com |

**Products/Software:**
| Property | Code | Example |
|----------|------|---------|
| instance of | P31 | software (Q7397) or web application (Q189210) |
| developer | P178 | [company Wikidata item] |
| official website | P856 | https://example.com |
| programming language | P277 | Python (Q28865) |
| operating system | P306 | Linux (Q388) |
| software license | P275 | Apache-2.0 (Q13785927) |
| inception | P571 | 2023-06-01 |

#### Step 4: Add External Identifiers

These link your Wikidata item to other knowledge bases:

| Identifier | Code | Purpose |
|-----------|------|---------|
| official website | P856 | Primary web presence |
| X (Twitter) username | P2002 | Social presence |
| LinkedIn organization ID | P4264 | Professional presence |
| GitHub username | P2037 | Technical presence |
| CrunchBase ID | P2087 | Business data |
| Google Knowledge Graph ID | P2671 | Google entity link |
| App Store ID | P3861 | Mobile presence |

#### Step 5: Add References

**Every statement must have a reference.** Unreferenced statements may be removed.

Good reference sources:
- Official website (for factual claims like founding date)
- News articles (for events, milestones)
- Industry reports (for market position)
- Government registries (for legal entity information)

### Wikidata Maintenance

| Task | Frequency | Why |
|------|-----------|-----|
| Review existing statements | Quarterly | Ensure accuracy; update changed information |
| Add new properties | When new information available | Keep entry comprehensive |
| Check for vandalism | Monthly | Others can edit your entry |
| Add new references | When new coverage appears | Strengthen statement credibility |
| Update identifiers | When new profiles created | Keep links current |

## Wikipedia

### Notability Requirements

Wikipedia requires entities to meet "general notability guidelines" (GNG):
- **Significant coverage** in **reliable, independent sources**
- Coverage must be **non-trivial** (not just a mention or directory listing)
- Sources must be **independent** of the entity (not press releases, not entity's own content)

### Building Toward Notability

If the entity doesn't have a Wikipedia article yet:

1. **Audit existing coverage**: Search Google News, academic databases, and industry publications for mentions
2. **Identify gaps**: What kinds of coverage are missing?
3. **Build coverage first, then article**: The article is the last step, not the first

Coverage-building strategies. The old version of this table carried a lead time and a notability
grade for each row; both were invented, so they are gone. What a strategy is worth against GNG
depends on the specific piece that results — its independence, its depth, and the publication —
which is knowable only once it exists. Assess each piece against GNG when it lands; forecast
neither its arrival date nor its grade.

| Strategy | What GNG will actually turn on |
|----------|-------------------------------|
| Industry report mentions | Whether the report is independent of the entity, and whether the entity gets substantive treatment rather than a listing |
| News article coverage | Whether it is genuinely independent — not a press release, not a contributed piece — and whether coverage is non-trivial |
| Conference speaking + coverage | Only the third-party write-ups count; the speaking slot itself is not independent coverage |
| Academic paper citations | Independence is normally straightforward to establish; depth of treatment of the entity is the open question |
| Award recognition | Who confers it and whether independent sources reported it |
| Book publication or feature | Whether the entity is the subject rather than a passing reference, and whether the publisher is independent |

### Wikipedia Article Best Practices

**DO:**
- Write in neutral, encyclopedic tone
- Use only independent, reliable sources as references
- Follow Wikipedia's Manual of Style
- Disclose any conflict of interest on your Talk page
- Let the community review and improve the article

**DO NOT:**
- Write promotional content
- Use the entity's own website as a primary source
- Create the article from a company account without disclosure
- Remove criticism or negative but sourced information
- Pay someone to write the article without disclosure (violates Wikipedia policy)

### Wikipedia's Impact on AI

Wikipedia is openly licensed, heavily mirrored, and structured in a way that makes entity facts easy to extract — which is why it is worth pursuing where notability genuinely exists. Beyond that, be careful what you assert: which corpora a given model trained on, how it weights a source, and whether a lead paragraph becomes an assistant's definition are not published by the model vendors and are not measurable from outside. State the reason to pursue Wikipedia as access and structure, not as a quantified effect on any assistant, and never grade it against other actions — no published measurement ranks entity-optimization actions by impact.

## Schema.org Entity Markup

### Minimum Viable Entity Schema

Every entity should have at minimum this markup on the homepage:

**Organization:**
```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "@id": "https://example.com/#organization",
  "name": "Example Corp",
  "url": "https://example.com",
  "logo": "https://example.com/logo.png",
  "description": "Example Corp is a [what it is] that [what it does].",
  "foundingDate": "2020-01-15",
  "founder": {
    "@type": "Person",
    "name": "Jane Smith",
    "@id": "https://example.com/about/jane-smith#person"
  },
  "sameAs": [
    "https://www.wikidata.org/wiki/Q12345678",
    "https://en.wikipedia.org/wiki/Example_Corp",
    "https://www.linkedin.com/company/example-corp",
    "https://x.com/examplecorp",
    "https://www.crunchbase.com/organization/example-corp"
  ]
}
```

**Person:**
```json
{
  "@context": "https://schema.org",
  "@type": "Person",
  "@id": "https://example.com/about/jane-smith#person",
  "name": "Jane Smith",
  "url": "https://example.com/about/jane-smith",
  "image": "https://example.com/photos/jane-smith.jpg",
  "jobTitle": "CEO",
  "worksFor": {
    "@type": "Organization",
    "@id": "https://example.com/#organization"
  },
  "description": "Jane Smith is [who they are] specializing in [expertise areas].",
  "sameAs": [
    "https://www.wikidata.org/wiki/Q87654321",
    "https://www.linkedin.com/in/janesmith",
    "https://x.com/janesmith"
  ]
}
```

### sameAs Best Practices

The `sameAs` property is the **primary entity disambiguation signal** in Schema.org. It tells search engines "this is the same entity as the one on these other platforms."

**Include only profiles that exist right now, each one opened and confirmed to resolve to this entity.** `sameAs` is an assertion of identity, so a URL for a profile that is planned, was never registered, or 404s is a false statement in structured data — and a URL pointing at a *different* entity that happens to share the name is worse, because it actively merges the two. Creating a missing profile is a roadmap action; nothing enters `sameAs` until it exists. The list below is unordered — no published measurement ranks these by effect:

- Wikidata URL
- Wikipedia URL
- LinkedIn URL
- Official social media profiles

**Include when relevant:**
5. CrunchBase URL
6. GitHub URL
7. IMDb URL (for people in entertainment)
8. Industry directory URLs

**Common mistakes:**
- Linking to generic pages instead of entity-specific URLs
- Inconsistent: Schema says "Example Corp" but LinkedIn says "Example Corporation"
- Missing the Wikidata link when an item exists
- Including dead, redirecting, or never-registered URLs — or one that resolves to a same-named but different entity

### Cross-Page Entity Consistency

Every page on the site should reference the same entity with the same `@id`:

```json
{
  "@type": "WebPage",
  "publisher": {
    "@type": "Organization",
    "@id": "https://example.com/#organization"
  }
}
```

For articles:
```json
{
  "@type": "Article",
  "author": {
    "@type": "Person",
    "@id": "https://example.com/about/jane-smith#person"
  },
  "publisher": {
    "@type": "Organization",
    "@id": "https://example.com/#organization"
  }
}
```

This creates a consistent entity graph that search engines can confidently map to Knowledge Graph entries.

## Monitoring Entity Health

### Quarterly Entity Health Check

| Check | How | What to Look For |
|-------|-----|-----------------|
| Knowledge Panel accuracy | Google entity name | Correct info, image, attributes |
| Wikidata entry | Visit Wikidata page | No vandalism, info still current |
| AI entity resolution | Query 3+ AI systems | Accurate recognition and description |
| Schema.org validation | Google Rich Results Test | No errors, complete entity data |
| Branded search SERP | Google "[entity name]" | Clean SERP, no disambiguation issues |
| Social profile consistency | Visit all profiles | Same name, description, links |

### Entity Health Metrics to Track

| Metric | Tool | Target |
|--------|------|--------|
| Knowledge Panel presence | Google Search | Present and accurate |
| Branded search CTR | Search Console | Your own trend against your own first reading — no external benchmark is published for this, so a fixed target figure would be invented |
| AI recognition | Manual testing | Recognised, with the correct description, by every system you actually tested — name them and date the run; the count of systems is whatever you ran, not a fixed roster |
| Wikidata completeness | Wikidata | Per signal 18 in [entity-signal-checklist.md](./entity-signal-checklist.md), the single authority for this threshold — do not restate a number here, where it drifted out of step once already |
| Schema.org error count | Google Search Console | 0 errors |
| Brand mention volume | Brand-monitoring tool (name the one used) | Stable or growing trend |

Mention volume is tracked as a count with its window and its source named, split into linked and unlinked. Do not turn it into a rate against money: dividing a retainer, fee, or budget by the mention count yields a cost-per-mention, ROI, or payback figure that prices whatever the alert feed caught rather than the entity work, and it becomes the client's target the moment they see it. Same rule, executor side: SKILL.md Step 2.

### Recovery Playbooks

**Entity disappeared from Knowledge Graph:**
1. Check if Wikidata entry was deleted or merged
2. Verify Schema.org markup hasn't changed
3. Look for major algorithm updates that might have affected entity recognition
4. Rebuild signals: start with Wikidata, then Schema.org, then external mentions
5. No recovery timeline — restoration is Google's automated decision and it publishes no window. Report what you rebuilt and when, and re-check on a stated cadence

**AI systems giving incorrect entity info:**
1. Identify which sources have incorrect information
2. Correct information at source (Wikidata, Wikipedia, About page)
3. AI systems will update over time (training data refresh + live search)
4. For urgent issues, some AI systems have feedback mechanisms
5. No timeline — vendors do not publish refresh or retraining schedules. Fix the source, record the date you fixed it, and re-test on a stated cadence

**Knowledge Panel showing wrong entity:**
1. Claim the Knowledge Panel (if you haven't already)
2. Strengthen disambiguation signals (see SKILL.md Disambiguation Strategy)
3. Add qualifier to entity name if needed
4. Build more unique entity signals (original content, specific topic associations)
5. No timeline — which entity a query resolves to is Google's call, and no window is published. Track the branded SERP on a stated cadence and report what changed, not when it will
