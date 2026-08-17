---
name: entity-optimizer
version: "4.5.0"
description: 'Audit and build entity presence across Google Knowledge Graph, Wikidata, and AI systems for brand recognition and AI citations. Use when the user asks to "optimize entity presence", "build knowledge graph", "improve knowledge panel", "entity audit", "establish brand entity", "Google doesn''t know my brand", "no knowledge panel", "establish my brand as an entity". For structured data implementation, see schema-markup-generator. For content-level AI optimization, see geo-content-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.5.0"
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


Audits, builds, and maintains entity identity across search engines and AI systems. An entity — a person, organization, product or concept treated as one distinct thing rather than a string of words — is what makes a brand resolvable to a single identity across sources instead of ambiguous.

**Why entities matter for SEO + GEO** — this library's working model, stated as what the work puts in place, because no engine publishes how it resolves or selects entities (ruling R3 amendment 9a):

- **SEO**: Google's Knowledge Graph is what Knowledge Panels are built from, and a claimed, accurate panel is a block of SERP space showing your own facts rather than a competitor's. Whether it is shown, and how, is Google's call and is not promised here.
- **GEO**: a brand whose name, description and identifiers say the same thing on every surface is one an answer can only get right; a brand whose sources disagree is one that can be confused with something else. Testing that is a measurement — ask the engines and record what comes back (step 3) — not a prediction.

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

Establish the entity's current state across all systems.

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

> **Measuring category 5 mentions — count them, never price them**: report mentions as a count over a stated population, each one resolved to its source and its date, with linked and unlinked mentions counted separately (unlinked mentions are a scored entity signal — CITE I09). Never divide a retainer, an agency fee, or any budget by a mention count to produce a cost-per-mention, cost-per-link, ROI, or payback figure — not even hedged as "a ratio, nothing more", and not when the user's question invites one. The denominator is whatever a monitoring tool happened to catch in one window, so the quotient prices the alert feed rather than the work, and a client handed a €-per-mention number will manage to it: cheap mentions on weak sources raise the count and move no entity signal. Answer a "is this spend worth it" question with what the mentions do and do not do for entity recognition, and name the evidence that would settle it.

> **Review integrity — the floor under every review recommendation, and it does not come from a platform.** This skill does not recommend, draft, script or plan written, bought or incentivised reviews — incentivised meaning anything of value attached to leaving one, including a discount, a prize draw or a free month — and it does not recommend review gating: any flow that decides who gets asked on the basis of how happy they are, the satisfaction survey that routes the 5s to the public form and the 1s to a private inbox included. Fake and incentivised reviews misrepresent customer experience to somebody about to spend money, and in many jurisdictions that is **illegal as an unfair commercial practice independent of any platform policy** — the platform's rules are the second exposure, not the first. Platform removal is also retroactive: reviews collected this way can be pulled long after they were counted as an entity signal, taking the rating and the client's credibility with them. What replaces all of it: **ask every customer, reward none, gate nothing, and reply to negatives in public.** Volume comes from asking systematically — every customer, every time, through a channel that pre-selects nobody. Where an audit finds any of this already in place, it is a finding and not a silence (Step 3). Full entry: [prohibited-tactics.md](../../references/prohibited-tactics.md) entry 3; the Google-specific enforcement layer is the note directly below.

> **Google review-solicitation policy (reported addition ~2026-04-17; policy text + enforcement page verified 2026-08-09 by owner live-page read)**: Google's "Prohibited & restricted content" policy (Fake engagement section) bans "Merchants requesting that staff solicit a certain number of reviews" (staff review quotas) and "Merchants requesting that staff solicit reviews that include specific content, including content that identifies a staff member." The ban attaches to the merchant's directive; spontaneous customer mentions of staff remain fine. Never set per-staff review targets; never script customers to include staff names or other specified content. Violations count as fake engagement: removal of the violative reviews + Business Profile restrictions (new-review freeze for a set period, existing reviews unpublished for a set period, public warning telling consumers fake reviews were removed), with email notice and an appeal path — not automatic suspension. Primary: support.google.com/contributionpolicy/answer/7400114 (reported same text at support.google.com/business/answer/7400114 — mirror not separately verified); enforcement: support.google.com/business/answer/14114287.

> **Markup describes what is on the page.** Entity markup states in machine-readable form what a reader can already see. A property with no counterpart in the visible page is not a stronger entity signal — it is a mismatch that invalidates the markup, and it is the entity-work form of hidden content: a founding date, an award, a `sameAs` profile or an `aggregateRating` that exists only inside the JSON-LD. Serving a crawler something a visitor does not get is the same defect one step further. So fix the page first and mark it up second; where a property matters and the page does not carry it, the recommendation is to put it on the page, not into the markup alone. This is [prohibited-tactics.md](../../references/prohibited-tactics.md) entry 6, and it stands beside settled ruling R2's one-accurate-primary-type rule as the other half of "the markup tells the truth about this page". Property-level detail: [knowledge-graph-guide.md](./references/knowledge-graph-guide.md) → "Markup describes what is on the page".

> **Reference**: Use the audit template in [references/entity-signal-checklist.md](./references/entity-signal-checklist.md) for the full 47-signal checklist with verification methods for categories 1-6.

### Step 3: Report & Action Plan

Five rules govern the report below — three on every claim it carries, one on anything prohibited the audit found already in place, and one on the shape of every action it recommends. Apply them while writing it, not after.

**No claim about what a search engine or an assistant does — and none about what it does not.** Entity work is where this breaks first, because every finding is about a system whose insides nobody publishes. State what a **record** says, what the **client controls**, what a **named source** states, or what you **observed and when**. Never what an engine does with any of it. **The prohibition runs in both directions and the negative half is the one that gets written by accident**: *"there is no submission form, no queue and no appeal for absence"*, *"Google does not read directory listings"*, *"assistants never revisit a page after it is corrected"* are the same unsourced assertion as *"Google prefers consistent NAP"* — a claim about the inside of a system, carrying a minus sign. Two replacements do the job and cost the client nothing: say what **is or is not documented** ("no submission interface for the Knowledge Graph is documented"; "no claiming process is documented for that panel"), or say what **was observed and when** ("re-checked 14 August on three brand queries — still no panel"). The same bar applies to timelines: how long a panel, an entry or a corrected fact takes to show up is not published, so it is measured on a stated cadence and reported with dates, never forecast. Withdrawn engine claims are recorded in the reference files, not in the client's report — a client reading a retraction of something they were never told is reading the library's internal history. **All of that is FAIL-grade family 9 in [anti-slop-ruleset.md](../../build/seo-content-writer/references/anti-slop-ruleset.md) §6, and family 10 is a separate rule breaking in a separate place** — family 9 bans asserting what an engine *does*, family 10 bans promising what an engine *will do for this client*, and a deliverable can violate either one alone. Entity work meets family 10 constantly, because the outcome the client wants is a Knowledge Panel, a Knowledge Graph entry or a name in a generated answer, and none of the three is anyone's to deliver: **no panel, entry, citation or assistant answer is promised, scheduled, given a probability, or written into a goal, a roadmap phase or an acceptance criterion, on any timeline.** What the report offers in its place is the work put in place and the client controls, the AI resolution test re-run on the same queries as a dated measurement, and the public records the client can complete and verify themselves. That is [prohibited-tactics.md](../../references/prohibited-tactics.md) entry 9, and the whole of that list is the floor under this skill whether or not an entry is restated here.

**Every fact traces to a named input — including facts about entities that are not the client.** A widely-known fact is still an unsourced assertion the moment it enters a client deliverable: a landmark's century, another organisation's founding year, the size of some other entity's content footprint, the year something will matter. Nobody in this audit measured it, the client cannot check it, and it travels to everyone the client forwards the report to. Background knowledge is not a source, and being famous is not a citation. Instead: name a colliding or comparison entity exactly as the supplied input names it, and build the disambiguation finding or the priority argument out of surfaces the audit actually read. If the argument needs a fact no input carries, either make the argument without that fact or state the check that would supply it — never fill the gap from memory to make a recommendation sound stronger. **That rule is this library's fabrication prohibition ([prohibited-tactics.md](../../references/prohibited-tactics.md) entry 5) in the form entity work needs it**, and the reason it is stated here rather than only there is that entity work invents plausible facts about organisations more readily than anything else this library does: the failure mode is not an invented footnote, it is a founding year, a headcount, a parent company or an award that reads exactly like the sourced facts around it. A fabricated statistic, quote, expert, case study or date is out on the same terms — cite a primary source with its date, or drop the claim and name the check that would settle it.

**Recount every derived count against its source before publishing it.** Any figure presented as read off a supplied file — mentions per name form, surfaces carrying an address, profiles missing a property — is recounted from that file at write-up time, and the report states the population it was counted over. Where the recount disagrees with the working figure, the recount is the number. A count that contradicts the file it claims to come from is worse than a missing count: it carries the authority of a derivation, so the client acts on it and the error is only found by whoever opens the file next.

**A prohibited tactic already in the client's setup is a finding, not a silence.** Bought or incentivised reviews, a gating flow, a per-staff review quota, markup describing content that is not on the page, or an invented fact already published about the entity — each is named plainly in the client's own words, with what it exposes them to, a remediation carrying an owner-role and an acceptance criterion ([action-output-contract.md](../../references/action-output-contract.md) §1–§3), and a rank against everything else in the report. They do not all rank the same: a gating flow still collecting reviews outranks a wrong founding date in a dormant directory profile, and a report where every finding is critical has ranked nothing. Nothing is built on top of one — where a priority action assumes the gated flow keeps producing its current rating, or cites a published claim the audit could not source, that action is withdrawn or restated without it and the dependency is named. This skill reports and proposes; nothing live is removed or altered on the run's own initiative. Handling: [prohibited-tactics.md](../../references/prohibited-tactics.md) §2.

**Every action is implementable, and the fields ride inside the template rather than above it.** Each Top 5 priority action and each remediation carries seven fields: **action** (one imperative sentence naming the artefact and the change), **owner**, **acceptance criterion** (labelled **Done when**), **expected impact** (the **Why** line — what the work puts in place and what it should change), **effort**, **dependencies**, **risk if done wrong**. Fields 1–3 are required: an action with no owner-role and no acceptance criterion does not ship as an action. The other four take a stated-absence value — `not estimated — no baseline data`, `none`, `low — reversible, no downstream effect` — never a blank and never an invention. **Owner is a role**, from the closed list: Content · SEO/technical · Developer · Designer · Product/merchandising · Customer service · Legal/compliance · Agency · Client decision. `Client decision` is a real owner and using it makes a decision visible instead of leaving an action stalled with no explanation; `unassigned — needs an owner` is legitimate and is itself a finding. **The acceptance-criterion test: could someone who was not part of this engagement check it six weeks from now, without asking anybody what was meant?** Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered — "the Wikidata entry is live and resolvable, carries website, industry and inception, and each property cites a public source" rather than "entity presence sorted". **It never requires an engine to do something** — a panel, a Knowledge Graph entry or an assistant's answer as the criterion turns the action into the promise the rule above bans, so an entity-recognition action is accepted on the work shipped *plus* the AI resolution test re-run on the same queries and recorded beside its dated baseline. The **Impact** High/Medium and **Effort** Low/Medium/High labels below stay this report's only impact and effort vocabularies, and the ordering rule under the Top 5 is its only ordering; no third vocabulary is imported beside either. Field table, stated-absence values, the role list and worked criteria: [action-output-contract.md](../../references/action-output-contract.md).

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

1. **[Signal]** — [one imperative sentence naming the artefact and the change]
   - Impact: [High/Medium] | Effort: [Low/Medium/High] | Owner: [role, or "unassigned — needs an owner"]
   - Why: [what this puts in place and what it should change, or "not estimated — no baseline data"]
   - Done when: [observable, binary, attached to a named artefact or measurement, dated or triggered — never an engine doing something]
   - Depends on: [named blocker, or "none"] | Risk if done wrong: [failure mode and cost, or "low — reversible, no downstream effect"]

2–5. [Same format]

### Entity Building Roadmap

Sequencing only — this says *when*, never *whether*. Anything the audit recommends as an action is stated with its seven fields in the Top 5 above; a box that never becomes a Top-5 entry is a standing task under its phase owner. No phase is a date by which an engine will have done anything.

#### Week 1-2: Foundation (Structured Data + Consistency) — owner: Developer + SEO/technical
- [ ] Implement/fix Organization or Person schema with full properties
- [ ] Add sameAs links to all authoritative profiles
- [ ] Audit and fix NAP (Name/Address/Phone) + description/logo/social consistency — exact format across site, Google Business Profile, and Greek directories (vrisko.gr, xo.gr), including Greek/Latin script variants of the business name
- [ ] Claim/complete Google Business Profile — categories, Posts, Q&A, Products, photos
- [ ] Ensure About page is entity-rich and well-structured

#### Month 1: Knowledge Bases — owner: SEO/technical
- [ ] Create or update Wikidata entry with complete properties
- [ ] Ensure CrunchBase / industry directory profiles are complete
- [ ] Build Wikipedia notability (or plan path to notability)
- [ ] Submit to relevant authoritative directories

#### Month 2-3: Authority Building — owner: Content, with Client decision on budget
- [ ] Secure mentions on authoritative industry sites
- [ ] Build co-citation signals with established entities
- [ ] Create topical content clusters that reinforce entity-topic associations
- [ ] Pursue PR opportunities that generate entity mentions

#### Ongoing: AI-Specific Optimization — owner: SEO/technical
- [ ] Test AI entity resolution quarterly
- [ ] Update factual claims to remain current and verifiable
- [ ] Monitor AI systems for incorrect entity information
- [ ] Ensure new content reinforces entity identity signals

```

<!-- OPERATOR BLOCK — lifted OUT of the client fence above, deliberately. Framework item IDs
     and skill slugs are run handles: they name coordinates in registers the client has never
     opened. Keeping this outside the report fence is the preferred form, because a model
     copies the fence and not the prose around it. -->

**Cross-reference — for whoever runs the skill library, not part of the client report**

- **CORE-EEAT**: A07 (Knowledge Graph Presence) and A08 (Entity Consistency) overlap this audit — entity work strengthens the Authority dimension.
- **CITE**: the Identity dimension (I01–I10) measures these same signals at domain level.
- Content-level audit: [content-quality-auditor](../content-quality-auditor/)
- Domain-level audit: [domain-authority-auditor](../domain-authority-auditor/)

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
- [ ] Every priority action and every remediation carries all seven fields (action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong), with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`) and never a blank; none ships without an owner-role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding) and a Done-when criterion that someone outside this engagement could check six weeks on without asking what was meant. **No criterion is an engine appearance** — an entity-recognition action is accepted on the work shipped plus the AI resolution test re-run on the same queries and recorded beside its dated baseline
- [ ] No Knowledge Panel, Knowledge Graph entry, citation or assistant answer is promised, scheduled, given a probability, or written into a goal, a roadmap phase or an acceptance criterion, on any timeline (`build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 10, and [prohibited-tactics.md](../../references/prohibited-tactics.md) entry 9). **This is a separate check from the engine-claim one above and a report can fail either alone**: family 9 is asserting what an engine *does*, family 10 is promising what it *will do for this client*
- [ ] NAP (Name/Address/Phone) checked in exact-matching format across site, GBP, and Greek directories (vrisko.gr, xo.gr), including Greek/Latin script variants
- [ ] Google Business Profile audited as its own category (completeness, categories, Posts/Q&A/Products, photo freshness, review velocity/response rate)
- [ ] AI entity resolution tested with at least 3 queries
- [ ] Knowledge Panel status checked
- [ ] Wikidata/Wikipedia status verified
- [ ] Schema.org markup on primary site audited
- [ ] Every fact and figure traces to a named input — no date, size, or attribute of a non-client entity supplied from background knowledge
- [ ] No sentence states what a search engine or assistant does, prefers, will do, or fails to do — **checked in both directions**, so a bare negative ("there is no queue", "engines do not read X", "it never updates") fails the same as a bare positive; what is documented, what the client controls, and what was observed with its date are the permitted forms, and no timeline is forecast for a panel, an entry or a corrected fact
- [ ] Every derived count recounted against its source file, with the population it was counted over stated
- [ ] No cost-per-mention, cost-per-link, ROI, or payback figure derived from a fee, retainer, or budget
- [ ] No recommendation asks for written, bought or incentivised reviews, sets a per-staff review quota, scripts what a review should say, or filters who gets asked — the review action is ask every customer, reward none, gate nothing, reply to negatives in public
- [ ] Every property recommended for entity markup has a counterpart in content visible on the page it marks up, and nothing is recommended for the markup alone
- [ ] A prohibited tactic found in the client's existing setup is reported as a named finding with its exposure, an owner-role, an acceptance criterion and a priority rank against the rest of the report — never left unstated, and no recommendation left standing that depends on it
- [ ] Every recommendation is specific and actionable
- [ ] Roadmap includes concrete steps with timeframes
- [ ] Cross-reference with CORE-EEAT A07/A08 and CITE I01-I10 noted

## Example

> **Reference**: See [references/example-audit-report.md](./references/example-audit-report.md) for a complete example entity audit report for a B2B SaaS company (CloudMetrics), including AI entity resolution test results, entity health summary, top 3 priority actions, and CORE-EEAT/CITE cross-references.

## Tips for Success

1. **Start with Wikidata** — it is the one public record about the entity that you can edit yourself, and a complete entry with references is checkable by anyone. [VERIFY — 2026-08-17] This tip used to add that such an entry *"often triggers Knowledge Panel creation within weeks"*; no source for that timing was read here, so do not state it to a client and do not plan around it
2. **`sameAs` is the property that ties your markup to public records** — it states, in machine-readable form, which public identifiers refer to this entity, and any consumer that reads structured data can follow them. [VERIFY — 2026-08-17] This tip used to say it *"directly tells search engines 'I am this entity in the Knowledge Graph'"* — an asserted engine mechanic, withdrawn. What is checkable is the markup itself. Put the Wikidata URL first so the most complete public record leads
3. **Test AI recognition before and after** — Query ChatGPT, Claude, Perplexity, and Google AI Overview before optimizing, then again after; this is the most direct GEO metric
4. **Entity signals compound** — Unlike content SEO, entity signals from different sources reinforce each other; 5 weak signals together are stronger than 1 strong signal alone
5. **Consistency beats completeness** — A consistent entity name and description across 10 platforms beats a perfect profile on just 2
6. **Don't neglect disambiguation** — If your entity name is shared with anything else, disambiguation is the first priority; all other signals are wasted if they're attributed to the wrong entity
7. **Pair with CITE I-dimension for domain context** — Entity audit tells you how well the entity is recognized; CITE Identity (I01-I10) tells you how well the domain represents that entity; use both together

## Entity Type Reference

> **Reference**: See [references/entity-type-reference.md](./references/entity-type-reference.md) for entity types with key signals, schemas, and disambiguation strategies by situation.

## Knowledge Panel & Wikidata Optimization

> **Reference**: See [references/knowledge-panel-wikidata-guide.md](./references/knowledge-panel-wikidata-guide.md) for Knowledge Panel claiming/editing, common issues and fixes, Wikidata entry creation, key properties by entity type, and AI entity resolution optimization.

## Reference Materials

Detailed guides for entity optimization:
- [references/entity-signal-checklist.md](./references/entity-signal-checklist.md) — Complete signal checklist with verification methods
- [references/knowledge-graph-guide.md](./references/knowledge-graph-guide.md) — Wikidata, Wikipedia, and Knowledge Graph optimization playbook, plus "Markup describes what is on the page"
- [Prohibited Tactics](../../references/prohibited-tactics.md) — the library-wide floor. Entry 3 (fake or incentivised reviews and review gating), entry 5 (fabricated citations, statistics or quotes), entry 6 (hidden content and cloaking) and entry 9 (guaranteed-outcome promises — the family-10 half) govern this skill's recommendations most directly, and the rest of the list binds it too; §2 is the handling for one already in the client's setup; §3 lists the legitimate practices each is confused with
- [Action Output Contract](../../references/action-output-contract.md) — the seven fields every priority action and remediation carries, and what makes an acceptance criterion checkable

## Related Skills

- [content-quality-auditor](../content-quality-auditor/) — CORE-EEAT items A07 (Knowledge Graph Presence) and A08 (Entity Consistency) directly relate
- [domain-authority-auditor](../domain-authority-auditor/) — CITE I01-I10 (Identity dimension) measures entity signals at domain level
- [schema-markup-generator](../../build/schema-markup-generator/) — Generate Organization, Person, Product, and other entity schema
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Entity work settles who the brand is; that skill makes the page's answers quotable
- [competitor-analysis](../../research/competitor-analysis/) — Compare entity presence against competitors
- [backlink-analyzer](../../monitor/backlink-analyzer/) — Branded backlinks strengthen entity signals
- [performance-reporter](../../monitor/performance-reporter/) — Track branded search and Knowledge Panel metrics
- [memory-management](../memory-management/) — Store entity audit results for tracking over time
