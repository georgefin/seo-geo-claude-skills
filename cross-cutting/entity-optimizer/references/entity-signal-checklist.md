# Entity Signal Checklist

> Part of [entity-optimizer](../SKILL.md). See also: [knowledge-graph-guide.md](./knowledge-graph-guide.md)

Complete checklist of entity signals organized by priority and verification method. Use this as a systematic audit guide — work through each signal, verify its status, and note actions needed.

## Priority 1: Foundation Signals (Must-Have)

These signals form the minimum viable entity identity. Without them, search engines and AI systems cannot reliably identify the entity.

### On-Site Structured Data

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 1 | Organization or Person schema on homepage | Run Google Rich Results Test on homepage | Schema present with name, url, logo, description |
| 2 | sameAs property links to all authoritative profiles | Inspect schema markup | Links to Wikipedia, Wikidata, LinkedIn, social profiles |
| 3 | Consistent @id used across all pages | Inspect schema on 5+ pages | Same @id (typically homepage URL + #organization) on every page |
| 4 | About page exists with entity-rich content | Manual review | First paragraph defines entity clearly; includes founding date, key people, mission |
| 5 | Contact page with verifiable information | Manual review | Physical address, phone, email — matches other directory listings |

### Key External Profiles

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 6 | Wikidata entry exists | Search wikidata.org | Entry with label, description, key properties, and references |
| 7 | Google Business Profile (if applicable) | Search "[entity] Google Business" | Claimed, verified, complete profile |
| 8 | LinkedIn company/person page | Search LinkedIn | Complete profile matching entity name and description |
| 9 | CrunchBase profile (for companies/products) | Search crunchbase.com | Entry with description, founding info, key people |
| 10 | Primary industry directory listing | Search top 3 industry directories | Listed with correct entity information |

### Branded Search Presence

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 11 | Branded search returns correct entity | Google "[entity name]" | Entity's website is #1; Knowledge Panel appears or SERP clearly identifies entity |
| 12 | No disambiguation confusion | Google "[entity name]" | No other prominent entity dominates results for the same name |
| 13 | Branded search volume exists | Keyword-volume check (name the tool used) | Measurable branded search volume (any amount > 0) |

## Priority 2: Authority Signals (Should-Have)

These signals establish the entity as recognized and authoritative. They separate a "registered entity" from a "known entity."

### Knowledge Graph Depth

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 14 | Google Knowledge Panel present | Google "[entity name]" | Knowledge Panel displayed with correct information |
| 15 | Knowledge Panel attributes complete | Review Knowledge Panel | Key attributes filled (founded, CEO, location, industry, etc.) |
| 16 | Knowledge Panel image correct | Review Knowledge Panel | Preferred image displayed |
| 17 | Wikipedia article (or strong notability path) | Search Wikipedia | Article exists, or entity has 3+ independent reliable sources for future article |
| 18 | Wikidata properties complete | Review Wikidata entry | 10+ properties with references |

### Third-Party Validation

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 19 | Authoritative media mentions | Google News search for entity | 3+ mentions in recognized publications |
| 20 | Industry awards or recognitions | Search "[entity] award" | At least 1 verifiable award or recognition |
| 21 | Co-citation with established entities | Search for entity alongside competitors | Appears in "X vs Y" comparisons, listicles, or industry roundups |
| 22 | Speaking engagements or publications | Search event/conference sites | Appears as speaker, author, or contributor |
| 23 | Reviews on third-party platforms | Check G2, Trustpilot, Yelp, etc. | Reviews exist with reasonable volume and rating, collected without reward and without gating — see the integrity note below |

**Review integrity — how signal 23 is passed, and how it is never passed.** The library-wide
statement is [prohibited-tactics.md](../../../references/prohibited-tactics.md) entry 3. Written,
bought or incentivised reviews and review gating are out of scope for every recommendation this
skill makes, whatever the volume gap looks like. Two exposures, and the order matters: in many
jurisdictions this is **illegal as an unfair commercial practice independent of any platform
policy**, and platform enforcement is the second one — retroactive removal, which pulls the reviews
out of the entity signal long after they were counted into it.

| Legitimate | The test | Prohibited |
|---|---|---|
| Asking every customer, every time, through the same channel | Nobody is pre-selected by how happy they are | Asking only the customers a survey scored highly (gating, whatever it is called) |
| A review request in the standard post-purchase flow | The request is the same for everyone | A discount, prize draw, free month, or loyalty points attached to leaving one |
| Replying to negative reviews in public, and fixing what they name | The record stays complete | Suppressing, burying, or routing negatives to a private inbox instead of the platform |
| A staff-wide push to remember to ask | No target attaches to an individual | Per-staff review quotas, or scripting customers to name a staff member (Google policy, SKILL.md Step 2) |
| Reporting review volume as a count with its window and platform | It is a measurement | Reporting a rating whose collection method the audit did not check |

Where the audit finds any of these already running, it is handled the way
[prohibited-tactics.md](../../../references/prohibited-tactics.md) §2 sets out — named, exposure
stated, remediation with an owner-role and an acceptance criterion, ranked against the rest of the
report.
A criterion that works here is observable: "from the changeover date recorded in the plan, the
review request goes to every completed order through one template, with no pre-survey and no
incentive — verified in the sending tool's audit log". Signal 23 is then scored on what the honest
flow produces, and a volume gap it exposes is reported as a gap.

### Content Authority

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 24 | Topical content depth in target areas | Site search for target topics | 10+ pages covering target topics in depth |
| 25 | Author pages with credentials | Review author pages | Author schema, credentials, sameAs to external profiles |
| 26 | Original research or data published | Review content | At least 1 piece of original data/research cited by others |
| 27 | Entity mentioned in own content naturally | Search site for entity name | Entity name appears contextually (not just in header/footer) |

## Priority 3: AI-Specific Signals (Must-Have for GEO)

These are the signals this library puts in place first when GEO is the goal, and the items
below **test** the result by asking the engines directly rather than predicting it. What any
engine does internally is not published and is not claimed here (ruling R3 amendment 9a).

### AI Recognition

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 28 | ChatGPT recognizes entity | Ask "What is [entity]?" | Correct description returned |
| 29 | Perplexity recognizes entity | Ask "What is [entity]?" | Correct description with source citations |
| 30 | Google AI Overview mentions entity | Search branded + topical queries | Entity appears in AI-generated overview |
| 31 | AI description is accurate | Compare AI output to entity's self-description | No factual errors in AI's response |
| 32 | AI associates entity with correct topics | Ask "[entity] expertise areas" | Correct topic associations returned |

### AI Optimization

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 33 | Entity definition quotable in first paragraph | Review About page and key pages | Clear, factual, self-contained definition suitable for AI quotation |
| 34 | Factual claims are verifiable | Cross-reference claims with external sources | All claims about entity can be verified via third-party sources |
| 35 | Entity name used consistently | Audit all platforms | Identical name format everywhere (no abbreviations in some places, full name in others) |
| 36 | Content is crawlable by AI systems | Check robots.txt for AI bot access | Not blocking GPTBot, ClaudeBot, or other AI crawlers (unless intentional) |
| 37 | Fresh information available | Check update dates | Key entity pages updated within last 6 months |

## Priority 4: Advanced Signals (Nice-to-Have)

These signals provide marginal gains but demonstrate thoroughness and maturity.

### Extended Knowledge Base Presence

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 38 | Multiple language entries in Wikidata | Check Wikidata labels | Labels and descriptions in languages matching target markets |
| 39 | DBpedia entry | Search dbpedia.org | Entry exists (auto-generated from Wikipedia) |
| 40 | Google Knowledge Graph ID known | Search Google Knowledge Graph API | Entity has a kg: identifier |
| 41 | ISNI or VIAF identifier (for persons) | Search isni.org or viaf.org | Identifier exists and links correctly |

### Social Entity Signals

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 42 | Social profiles bidirectionally linked | Check website links to social AND social links to website | Both directions verified on all platforms |
| 43 | Consistent entity description across social | Compare bios on all platforms | Same core description, adapted for platform length limits |
| 44 | Social engagement demonstrates real audience | Review engagement metrics | Engagement patterns consistent with genuine audience (not bot-like) |

### Technical Entity Signals

| # | Signal | Verification Method | Pass Criteria |
|---|--------|-------------------|---------------|
| 45 | Entity homepage has strong backlink profile | Backlink-profile check (name the tool used) | Homepage DR/DA above industry median |
| 46 | Branded anchor text in backlinks | Analyze anchor text distribution | Entity name appears naturally in inbound link anchor text |
| 47 | Entity subdomain consistency | Check all subdomains | Same entity schema and branding across all subdomains |

## How to Use This Checklist

Work through signals by priority tier. For each signal, mark status as ✅ (present and correct), ⚠️ (present but incomplete), or ❌ (absent). Focus on completing each priority tier before moving to the next.

## From 47 signals to the report's 7 category statuses

The tiers above are the working order — what to fix first. The report summarises the same signals
in the seven categories of SKILL.md Step 2, which is a different cut of one list. Each signal
belongs to exactly one category:

| Report category | Signals | Count |
|-----------------|---------|-------|
| 1. Structured Data | 1, 2, 3, 47 | 4 |
| 2. Knowledge Base | 6, 8, 9, 10, 14, 15, 16, 17, 18, 38, 39, 40, 41 | 13 |
| 3. Consistency (NAP+E) | 5, 35, 42, 43 | 4 |
| 4. Content-Based | 4, 11, 24, 25, 26, 27, 45, 46 | 8 |
| 5. Third-Party | 13, 19, 20, 21, 22, 23, 44 | 7 |
| 6. AI-Specific | 12, 28, 29, 30, 31, 32, 33, 34, 36, 37 | 10 |
| 7. Google Business Profile | signal 7, plus the six GBP checks named in SKILL.md Step 2 (completeness, category accuracy, Posts/Q&A/Products activity, photo freshness, review velocity, review response rate) | 7 |

4 + 13 + 4 + 8 + 7 + 10 + 7 = 53 rows: the 47 numbered signals plus the six GBP checks that live
in SKILL.md rather than in this list.

### Deriving each category's status

**✅ 1 · ⚠️ 0.5 · ❌ 0**, then `points ÷ signals scored`, printed as a percentage to one decimal,
half up.

| Status | Share of the category's scored signals |
|--------|----------------------------------------|
| ✅ Strong | 80% or more |
| ⚠️ Gaps | 40% up to 80% |
| ❌ Missing | below 40% — nothing there, or so little the category does not function |

A boundary value takes the higher status: exactly 80.0% is Strong, exactly 40.0% is Gaps. A signal
that cannot apply to this entity (ISNI for an organisation, a Google Business Profile for a
company with no public premises) or that nothing in the inputs can settle is **excluded from both
sides and named** — never scored ❌, which claims you looked and it was absent. Where **no** signal
in a category could be scored, the row reads `Not applicable` or `Not assessed` with the reason,
never a status.

Print the working in the report, beside the status: `⚠️ Gaps — 3.0 of 6 scored signals = 50.0%;
signals 45, 46 excluded (no backlink data)`. Two audits of the same inputs then land on the same
seven words, and the client can see which signal moves which status.

### Priority Action Matrix

| Current State | Focus Area | Expected Timeline |
|--------------|-----------|-------------------|
| Most Priority 1 signals ❌ | Priority 1 foundation signals only | 2-4 weeks |
| Priority 1 mostly ✅, Priority 2 mixed | Priority 2 authority signals | 1-2 months |
| Priority 1-2 mostly ✅ | Priority 3 AI-specific signals | 2-3 months |
| Priority 1-3 mostly ✅ | Selective Priority 4 for completeness | Ongoing |
| All tiers mostly ✅ | Maintenance + quarterly re-audit | Quarterly review |
