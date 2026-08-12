---
name: entity-optimizer
version: "4.2.0"
description: 'Audit and build entity presence across Google Knowledge Graph, Wikidata, and AI systems for brand recognition and AI citations. Use when the user asks to "optimize entity presence", "build knowledge graph", "improve knowledge panel", "entity audit", "establish brand entity", "Google doesn''t know my brand", "no knowledge panel", "establish my brand as an entity". For structured data implementation, see schema-markup-generator. For content-level AI optimization, see geo-content-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.2.0"
  geo-relevance: "high"
  tags:
    - seo
    - geo
    - entity optimization
    - knowledge graph
    - knowledge panel
    - brand entity
    - entity disambiguation
    - wikidata
    - structured entities
    - knowledge-graph
    - google-knowledge-panel
    - entity-seo
    - brand-entity
    - entity-recognition
    - knowledge-base
    - dbpedia
    - brand-presence
  triggers:
    - "optimize entity presence"
    - "build knowledge graph"
    - "improve knowledge panel"
    - "entity audit"
    - "establish brand entity"
    - "knowledge panel"
    - "entity disambiguation"
    - "Google doesn't know my brand"
    - "no knowledge panel"
    - "establish my brand as an entity"
---

# Entity Optimizer


Audits, builds, and maintains entity identity across search engines and AI systems. Entities — the people, organizations, products, and concepts that search engines and AI systems recognize as distinct things — are the foundation of how both Google and LLMs decide *what a brand is* and *whether to cite it*.

**Why entities matter for SEO + GEO:**

- **SEO**: Google's Knowledge Graph powers Knowledge Panels, rich results, and entity-based ranking signals. A well-defined entity earns SERP real estate.
- **GEO**: AI systems resolve queries to entities before generating answers. If an AI cannot identify an entity, it cannot cite it — no matter how good the content is.

## When to Use This Skill

- Establishing a new brand/person/product as a recognized entity
- Auditing current entity presence across Knowledge Graph, Wikidata, and AI systems
- Improving or correcting a Knowledge Panel
- Building entity associations (entity ↔ topic, entity ↔ industry)
- Resolving entity disambiguation issues (your entity confused with another)
- Strengthening entity signals for AI citation
- After launching a new brand, product, or organization
- Preparing for a site migration (preserving entity identity)
- Running periodic entity health checks

## What This Skill Does

1. **Entity Audit**: Evaluates current entity presence across search and AI systems
2. **Knowledge Graph Analysis**: Checks Google Knowledge Graph, Wikidata, and Wikipedia status
3. **AI Entity Resolution Test**: Queries AI systems to see how they identify and describe the entity
4. **Entity Signal Mapping**: Identifies all signals that establish entity identity
5. **Gap Analysis**: Finds missing or weak entity signals
6. **Entity Building Plan**: Creates actionable plan to establish or strengthen entity presence
7. **Disambiguation Strategy**: Resolves confusion with similarly-named entities

## How to Use

### Entity Audit

```
Audit entity presence for [brand/person/organization]
```

```
How well do search engines and AI systems recognize [entity name]?
```

### Build Entity Presence

```
Build entity presence for [new brand] in the [industry] space
```

```
Establish [person name] as a recognized expert in [topic]
```

### Fix Entity Issues

```
My Knowledge Panel shows incorrect information — fix entity signals for [entity]
```

```
AI systems confuse [my entity] with [other entity] — help me disambiguate
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~knowledge graph + ~~SEO tool + ~~AI monitor + ~~brand monitor connected:**
Query Knowledge Graph API for entity status, pull branded search data from ~~SEO tool, test AI citation with ~~AI monitor, track brand mentions with ~~brand monitor.

**With manual data only:**
Ask the user to provide:
1. Entity name, type (Person, Organization, Brand, Product, Creative Work, Event)
2. Primary website / domain
3. Known existing profiles (Wikipedia, Wikidata, social media, industry directories)
4. Top 3-5 topics/industries the entity should be associated with
5. Any known disambiguation issues (other entities with same/similar name)

Without tools, Claude provides entity optimization strategy and recommendations based on information the user provides. The user must run search queries, check Knowledge Panels, and test AI responses to supply the raw data for analysis.

Proceed with the audit using public search results, AI query testing, and SERP analysis. Note which items require tool access for full evaluation.

## Instructions

When a user requests entity optimization:

### Step 1: Entity Discovery

Establish the entity's current state across all systems. **Every cell in the two tables below is filled from an input the user supplied, or not at all** — a cell nothing settles reads `Not checked` with the input that would settle it named, never a guess, an estimate, a hedged verdict or a "typical for an entity this size" figure, and an absence is only reportable as an absence once someone has actually looked and the check is dated. The bracketed slots are where invention happens: the Knowledge Graph entity ID, its types and `resultScore`, and any Wikidata QID stay empty unless the user pasted the API response or the item page carrying them. The AI table's rows are the systems actually tested and no others — delete a row nobody ran rather than leaving its cells blank to be filled in later, and add a row only when the user reports having queried that system.

```markdown
### Entity Profile

**Entity Name**: [name]
**Entity Type**: [Person / Organization / Brand / Product / Creative Work / Event]
**Primary Domain**: [URL]
**Target Topics**: [topic 1, topic 2, topic 3]

#### Current Entity Presence

| Platform | Status | Details |
|----------|--------|---------|
| Google Knowledge Panel | ✅ Present / ❌ Absent / ⚠️ Incorrect | [details] |
| Google Business Profile | ✅ Claimed & complete / ⚠️ Claimed, incomplete / ❌ Unclaimed | [category accuracy, NAP match, review velocity] |
| Wikidata | ✅ Listed / ❌ Not listed | [QID if exists] |
| Wikipedia | ✅ Article / ⚠️ Mentioned only / ❌ Absent | [notability assessment] |
| Google Knowledge Graph API | ✅ Entity found / ❌ Not found | [entity ID, types, score] |
| Schema.org on site | ✅ Complete / ⚠️ Partial / ❌ Missing | [Organization/Person/Product schema] |

#### AI Entity Resolution Test

**Note**: Claude cannot directly query other AI systems or perform real-time web searches without tool access. When running without ~~AI monitor or ~~knowledge graph tools, ask the user to run these test queries and report the results, or use the user-provided information to assess entity presence.

Test how AI systems identify this entity by querying:
- "What is [entity name]?"
- "Who founded [entity name]?" (for organizations)
- "What does [entity name] do?"
- "[entity name] vs [competitor]"

| AI System | Recognizes Entity? | Description Accuracy | Cites Entity's Content? |
|-----------|-------------------|---------------------|------------------------|
| ChatGPT | ✅ / ⚠️ / ❌ | [accuracy notes] | [yes/no/partially] |
| Claude | ✅ / ⚠️ / ❌ | [accuracy notes] | [yes/no/partially] |
| Perplexity | ✅ / ⚠️ / ❌ | [accuracy notes] | [yes/no/partially] |
| Google AI Overview | ✅ / ⚠️ / ❌ | [accuracy notes] | [yes/no/partially] |
```

### Step 2: Entity Signal Audit

Evaluate entity signals across 7 categories. The detailed 47-signal checklist is in [references/entity-signal-checklist.md](./references/entity-signal-checklist.md), which also maps every signal to one of these 7 categories; the Google Business Profile category is the one signal there plus the six checks named below, so a GBP audit does not fall between the two files.

Evaluate each signal as Pass ✅ / Partial ⚠️ / Fail ❌ — the same three marks the category status is counted from — with a specific action for each gap, and exclude rather than fail a signal no input can settle. The 7 categories are:

1. **Structured Data Signals** -- Organization/Person schema, sameAs links, @id consistency, author schema
2. **Knowledge Base Signals** -- Wikidata, Wikipedia, CrunchBase, industry directories
3. **Consistent NAP+E Signals** -- Name, Address, Phone in exact matching format across site, Google Business Profile, and Greek directories (vrisko.gr, xo.gr) — including Greek/Latin script variants of the business name — plus description/logo/social consistency
4. **Content-Based Entity Signals** -- About page, author pages, topical authority, branded backlinks
5. **Third-Party Entity Signals** -- Authoritative mentions, co-citation, reviews, press coverage
6. **AI-Specific Entity Signals** -- Clear definitions, disambiguation, verifiable claims, crawlability
7. **Google Business Profile Signals** -- Profile completeness, primary/secondary category accuracy, Posts/Q&A/Products surface activity, photo freshness, review velocity, review response rate

> **Measuring category 5 mentions — count them, never price them**: report mentions as a count over a stated population, each one resolved to its source and its date, with linked and unlinked mentions counted separately (unlinked mentions are a scored entity signal — CITE I09). Never divide a retainer, an agency fee, or any budget by a mention count to produce a cost-per-mention, cost-per-link, ROI, or payback figure — not even hedged as "a ratio, nothing more", and not when the user's question invites one. The denominator is whatever a monitoring tool happened to catch in one window, so the quotient prices the alert feed rather than the work, and a client handed a €-per-mention number will manage to it: cheap mentions on weak sources raise the count and move no entity signal. Answer a "is this spend worth it" question with what the mentions do and do not do for entity recognition, and name the evidence that would settle it — the money in the brief is not in the mention population, so it never becomes a denominator (Step 3, third rule). Build the counts themselves by the enumeration method in Step 3: list the rows carrying each value, then count the list, sweeping every table the population spans — never by scanning.

> **Google review-solicitation policy (reported addition ~2026-04-17; policy text + enforcement page verified 2026-08-09 by owner live-page read)**: Google's "Prohibited & restricted content" policy (Fake engagement section) bans "Merchants requesting that staff solicit a certain number of reviews" (staff review quotas) and "Merchants requesting that staff solicit reviews that include specific content, including content that identifies a staff member." The ban attaches to the merchant's directive; spontaneous customer mentions of staff remain fine. Never set per-staff review targets; never script customers to include staff names or other specified content. Violations count as fake engagement: removal of the violative reviews + Business Profile restrictions (new-review freeze for a set period, existing reviews unpublished for a set period, public warning telling consumers fake reviews were removed), with email notice and an appeal path — not automatic suspension. Primary: support.google.com/contributionpolicy/answer/7400114 (reported same text at support.google.com/business/answer/7400114 — mirror not separately verified); enforcement: support.google.com/business/answer/14114287.

> **Reference**: Use the audit template in [references/entity-signal-checklist.md](./references/entity-signal-checklist.md) for the full 47-signal checklist with verification methods for categories 1-6.

### Step 3: Report & Action Plan

Three rules apply to every claim the report below will carry. Apply them while writing it, not after.

**Every fact traces to a named input — including facts about entities that are not the client.** A widely-known fact is still an unsourced assertion the moment it enters a client deliverable: a landmark's century, another organisation's founding year, the size of some other entity's content footprint, the year something will matter. Nobody in this audit measured it, the client cannot check it, and it travels to everyone the client forwards the report to. Background knowledge is not a source, and being famous is not a citation. Instead: name a colliding or comparison entity exactly as the supplied input names it, and build the disambiguation finding or the priority argument out of surfaces the audit actually read. If the argument needs a fact no input carries, either make the argument without that fact or state the check that would supply it — never fill the gap from memory to make a recommendation sound stronger.

**Count by enumeration, and give every figure exactly one population.** Four steps, in order, for every count the report carries — mentions per name form, surfaces carrying an address, profiles missing a property; a figure that skipped them is not reportable. **(1) Name the population before counting it** — the exact set, and where in the file it lives — because a count whose population is unstated can be neither checked nor reproduced. **(2) List the items, then count the list.** Write out the row identifiers carrying each value before stating any total, sweeping every table, section and page the population spans. Scanning finds the clustered occurrences and misses the scattered ones, so the values whose rows are split across two tables are precisely the ones that come out short — and a recount performed by scanning again reproduces the same miss. Enumeration is what makes the second pass a check rather than a repeat. **(3) One population per figure — never merge two.** Name strings across the client's own surfaces and name forms across third-party mentions are two counts; linked and unlinked mentions are two counts. A total spanning two populations answers no question and cannot be acted on: report each under its own population and let the reader combine them. **(4) Show every exclusion as its own step** — the starting figure, what each removal takes out and on which rule, and the subtotal after each. One collapsed subtraction hides which rule did the work, so neither the client nor the next auditor can reproduce or dispute it. Where a recount disagrees with the working figure, the recount is the number: a count that contradicts the file it claims to come from carries the authority of a derivation, so the client acts on it and the error surfaces only when someone else opens the file.

**A number may meet only numbers from its own population.** Counts, subtotals, percentages and ratios are built from figures inside the population named for them. A number that arrived from anywhere else — a retainer or fee from the brief, a budget, a headcount, a target date — is never the numerator or the denominator of one, because dividing across that boundary manufactures a per-unit rate nobody measured and the file can neither confirm nor refute. That is the general rule; the cost-per-mention ban in Step 2 is its named instance, and the same reasoning retires every other per-unit figure built by dividing the brief's numbers into the file's, however the question was phrased and however the result is hedged.

```markdown
## Entity Optimization Report

### Overview

- **Entity**: [name]
- **Entity Type**: [type]
- **Audit Date**: [date]

### Signal Category Summary

Three statuses, and each one shows the count it came from: ✅ 1 · ⚠️ 0.5 · ❌ 0 over the category's
own signals, `points ÷ signals scored` — **Strong** at 80% or more, **Gaps** from 40% to 80%,
**Missing** below 40%, with a boundary value taking the higher status. A signal that cannot apply
to this entity, or that no input can settle, is excluded from both sides and named; a category
where nothing could be scored reads `Not applicable` or `Not assessed` with the reason, never a
status. Which of the 47 signals belongs to which category, and the worked derivation:
[references/entity-signal-checklist.md](./references/entity-signal-checklist.md) → "From 47
signals to the report's 7 category statuses".

| Category | Status (points ÷ scored = %) | Key Findings |
|----------|------------------------------|-------------|
| Structured Data | ✅ Strong / ⚠️ Gaps / ❌ Missing — [X] of [N] = [Y]% | [key findings] |
| Knowledge Base | ✅ / ⚠️ / ❌ — [X] of [N] = [Y]% | [key findings] |
| Consistency (NAP+E) | ✅ / ⚠️ / ❌ — [X] of [N] = [Y]% | [key findings] |
| Content-Based | ✅ / ⚠️ / ❌ — [X] of [N] = [Y]% | [key findings] |
| Third-Party | ✅ / ⚠️ / ❌ — [X] of [N] = [Y]% | [key findings] |
| AI-Specific | ✅ / ⚠️ / ❌ — [X] of [N] = [Y]% | [key findings] |
| Google Business Profile | ✅ / ⚠️ / ❌ — [X] of [N] = [Y]% | [key findings] |

### Critical Issues

[List any issues that severely impact entity recognition — disambiguation problems, incorrect Knowledge Panel, missing from Knowledge Graph entirely]

### Top 5 Priority Actions

Ordering rule, so the list reproduces: **impact on entity recognition first, then ascending
effort** — every High-impact action before every Medium, and within one impact level the Low-effort
one first. Effort breaks ties; it never outranks impact, and it is never multiplied by it (that
arithmetic would put the most expensive action on top). Where two actions tie on both, the one
unblocking the other goes first and says so.

1. **[Signal]** — [specific action]
   - Impact: [High/Medium] | Effort: [Low/Medium/High]
   - Why: [explanation of how this improves entity recognition]

2. **[Signal]** — [specific action]
   - Impact: [High/Medium] | Effort: [Low/Medium/High]
   - Why: [explanation]

3–5. [Same format]

### Entity Building Roadmap

#### Week 1-2: Foundation (Structured Data + Consistency)
- [ ] Implement/fix Organization or Person schema with full properties
- [ ] Add sameAs links to all authoritative profiles
- [ ] Audit and fix NAP (Name/Address/Phone) + description/logo/social consistency — exact format across site, Google Business Profile, and Greek directories (vrisko.gr, xo.gr), including Greek/Latin script variants of the business name
- [ ] Claim/complete Google Business Profile — categories, Posts, Q&A, Products, photos
- [ ] Ensure About page is entity-rich and well-structured

#### Month 1: Knowledge Bases
- [ ] Create or update Wikidata entry with complete properties
- [ ] Ensure CrunchBase / industry directory profiles are complete
- [ ] Build Wikipedia notability (or plan path to notability)
- [ ] Submit to relevant authoritative directories

#### Month 2-3: Authority Building
- [ ] Secure mentions on authoritative industry sites
- [ ] Build co-citation signals with established entities
- [ ] Create topical content clusters that reinforce entity-topic associations
- [ ] Pursue PR opportunities that generate entity mentions

#### Ongoing: AI-Specific Optimization
- [ ] Test AI entity resolution quarterly
- [ ] Update factual claims to remain current and verifiable
- [ ] Monitor AI systems for incorrect entity information
- [ ] Ensure new content reinforces entity identity signals

### Cross-Reference

- **CORE-EEAT relevance**: Items A07 (Knowledge Graph Presence) and A08 (Entity Consistency) directly overlap — entity optimization strengthens Authority dimension
- **CITE relevance**: CITE I01-I10 (Identity dimension) measures entity signals at domain level — entity optimization feeds these scores
- For content-level audit: [content-quality-auditor](../content-quality-auditor/)
- For domain-level audit: [domain-authority-auditor](../domain-authority-auditor/)
```

## Validation Checkpoints

### Input Validation
- [ ] Entity name and type identified
- [ ] Primary domain/website confirmed
- [ ] Target topics/industries specified
- [ ] Disambiguation context provided (if entity name is common)

### Output Validation
- [ ] All 7 signal categories evaluated, each under its own name from Step 2 — a category nothing could be scored in still appears, marked Not applicable or Not assessed with the reason
- [ ] Every category status prints the count behind it (points ÷ signals scored = %), uses only the three statuses Strong / Gaps / Missing, and excludes rather than fails the signals no input can settle
- [ ] Priority actions are ordered impact first, then ascending effort, and the order matches the labels printed on them
- [ ] NAP (Name/Address/Phone) checked in exact-matching format across site, GBP, and Greek directories (vrisko.gr, xo.gr), including Greek/Latin script variants
- [ ] Google Business Profile audited as its own category (completeness, categories, Posts/Q&A/Products, photo freshness, review velocity/response rate)
- [ ] AI entity resolution tested with at least 3 queries
- [ ] Knowledge Panel status checked
- [ ] Wikidata/Wikipedia status verified
- [ ] Schema.org markup on primary site audited
- [ ] Every fact and figure traces to a named input — no date, size, or attribute of a non-client entity supplied from background knowledge
- [ ] Every derived count built by enumerating the items and counting the list — not by scanning — sweeping every table and section the population spans, with the population named beside the figure
- [ ] No figure merges two populations, and every exclusion chain is shown step by step with its subtotals, never as one collapsed subtraction
- [ ] No number from the brief (retainer, fee, budget, headcount, target date) appears as the numerator or denominator of any count — no cost-per-mention, cost-per-link, ROI, payback or other per-unit figure
- [ ] No table cell is filled by guess, estimate or hedge: entity IDs, `resultScore` and QIDs empty unless supplied, AI rows limited to the systems actually tested, absences dated and only claimed after a real look
- [ ] Every recommendation is specific and actionable
- [ ] Roadmap includes concrete steps with timeframes
- [ ] Cross-reference with CORE-EEAT A07/A08 and CITE I01-I10 noted

## Example

> **Reference**: See [references/example-audit-report.md](./references/example-audit-report.md) for a complete example entity audit report for a B2B SaaS company (CloudMetrics), including AI entity resolution test results, entity health summary, top 3 priority actions, and CORE-EEAT/CITE cross-references.

## Tips for Success

1. **Start with Wikidata, and promise nothing about panels** (sourced 2026-08-12; the previous unsourced form of this tip is retired) — Wikidata is openly editable and CC0-licensed, so it is one of the few entity surfaces you can correct directly instead of petitioning; do that work first and give every statement a reference. Attach no mechanism and no date to it. Google documents only that knowledge panels are "created automatically by Google Search Algorithm when there is enough information available on the open web"; it describes its sources no more precisely than public sources, licensed data and submissions from panel claimants, **names neither Wikidata nor Wikipedia, states no timeframe of any kind**, and says panel display "isn't something we can or would influence" (primary: support.google.com/knowledgepanel/answer/9787176 — live-page read 2026-08-12). Not verified and not assertable: any causal link from a Wikidata item to a panel, any frequency for it, and any time-to-panel figure — no dated study measuring one was found, so the skill states none. Re-check if Google republishes that page. A complete referenced Wikidata item is groundwork that makes an entity resolvable — never a trigger, never a delivery date
2. **Put `sameAs` to work, and keep it honest** — schema.org defines `sameAs` as a URL that unambiguously indicates the item's identity, which is what makes it the disambiguation lever you control directly; list the Wikidata URL when an item exists, and never list a profile that does not. What any engine does with the property is not published, so claim its purpose, never an effect, and rank it against nothing
3. **Test AI recognition before and after** — run the same queries before optimizing and again after, against whichever systems you can actually reach; name the ones you ran and date each run, because the roster is whatever you tested and single runs on one date are observations, not a measured recognition rate
4. **Entity signals reinforce each other** — one identity asserted consistently across independent surfaces is corroborating evidence in a way that a single surface repeated cannot be, which is why breadth is worth pursuing; nothing published puts a number or an exchange rate on it, so describe the effect and never quantify it
5. **Consistency beats completeness** — one name and one description used identically everywhere resolves an entity better than a richer profile that contradicts its neighbours, because conflicting values leave a resolver nothing to settle on; state it as the principle it is, without a platform count
6. **Don't neglect disambiguation** — If your entity name is shared with anything else, disambiguation is the first priority; all other signals are wasted if they're attributed to the wrong entity
7. **Pair with CITE I-dimension for domain context** — Entity audit tells you how well the entity is recognized; CITE Identity (I01-I10) tells you how well the domain represents that entity; use both together

## Entity Type Reference

> **Reference**: See [references/entity-type-reference.md](./references/entity-type-reference.md) for entity types with key signals, schemas, and disambiguation strategies by situation.

## Knowledge Panel & Wikidata Optimization

> **Reference**: See [references/knowledge-panel-wikidata-guide.md](./references/knowledge-panel-wikidata-guide.md) for Knowledge Panel claiming/editing, common issues and fixes, Wikidata entry creation, key properties by entity type, and AI entity resolution optimization.

## Reference Materials

Detailed guides for entity optimization:
- [references/entity-signal-checklist.md](./references/entity-signal-checklist.md) — Complete signal checklist with verification methods
- [references/knowledge-graph-guide.md](./references/knowledge-graph-guide.md) — Wikidata, Wikipedia, and Knowledge Graph optimization playbook

## Related Skills

- [content-quality-auditor](../content-quality-auditor/) — CORE-EEAT items A07 (Knowledge Graph Presence) and A08 (Entity Consistency) directly relate
- [domain-authority-auditor](../domain-authority-auditor/) — CITE I01-I10 (Identity dimension) measures entity signals at domain level
- [schema-markup-generator](../../build/schema-markup-generator/) — Generate Organization, Person, Product, and other entity schema
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Entity signals feed AI citation probability
- [competitor-analysis](../../research/competitor-analysis/) — Compare entity presence against competitors
- [backlink-analyzer](../../monitor/backlink-analyzer/) — Branded backlinks strengthen entity signals
- [performance-reporter](../../monitor/performance-reporter/) — Track branded search and Knowledge Panel metrics
- [memory-management](../memory-management/) — Store entity audit results for tracking over time
