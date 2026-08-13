# CORE-EEAT Content Benchmark — Skills Reference

> Based on [CORE-EEAT Content Benchmark](https://github.com/aaron-he-zhu/core-eeat-content-benchmark) **v3.0**
>
> This file is a reference adaptation for the SEO & GEO Skills Library. For the full benchmark with detailed examples, see the source repository.
>
> **Version sync**: When the source spec updates, check: item count references in README (currently "80 items"), skill validation checkpoints, and Sections 2, 3, 7 below. Library-governed refinements — the R10/T04 veto semantics and veto scoring consequences (Sections 2, 3, 7), the Section 5 single-primary schema mapping (including its e-commerce category row, the nesting-is-not-stacking test, and the type-replacement rule), and the C09 Pass criterion (Section 7 — the visible Q&A block earns the Pass; FAQPage markup is conditional on FAQPage being the page's one primary type, per Section 5) — supersede the v3.0 source wording where they differ; do not revert them on a sync.

**8 dimensions × 10 items = 80 evaluation criteria** for optimizing content visibility across AI engines (GEO) and search engines (SEO).

---

## 1. Framework Overview

### Two-System Architecture

| System | Focus | Dimensions | Items | Boundary |
|--------|-------|------------|-------|----------|
| CORE | GEO (AI Engine Optimization) | C, O, R, E | 40 | Content body |
| EEAT | SEO (Search Engine Optimization) | Exp, Ept, A, T | 40 | Author / Organization / Site |

**MECE Boundary Rule:** CORE evaluates the content body itself. EEAT evaluates the source — author, organization, and site credibility. There is no overlap.

### 8 Dimensions

| Abbr | Full Name | Core Question |
|------|-----------|---------------|
| C | Contextual Clarity | Does the content clearly answer the user's intent? |
| O | Organization | Is the content structured for both humans and machines? |
| R | Referenceability | Can AI and readers verify and cite the claims? |
| E | Exclusivity | Does the content offer something unavailable elsewhere? |
| Exp | Experience | Does the author demonstrate real-world experience? |
| Ept | Expertise | Does the author demonstrate professional expertise? |
| A | Authority | Is the author/org recognized as an authority? |
| T | Trust | Does the site meet trust and safety standards? |

### Priority Tags

- **GEO-First** 🎯 = Critical for AI engine citation
- **SEO-First** 🔍 = Critical for traditional search ranking
- **Dual** ⚡ = Important for both

---

## 2. Complete 80-Item Checklist

### CORE — Content Body (40 Items)

| ID | Dim | Check Item | Priority | One-Line Standard |
|----|-----|------------|----------|-------------------|
| C01 | C | Intent Alignment | Dual ⚡ | Title promise = content delivery |
| C02 | C | Direct Answer | GEO 🎯 | Core answer in first 150 words |
| C03 | C | Query Coverage | Dual ⚡ | Covers ≥3 query variants (synonyms, long-tail) |
| C04 | C | Definition First | GEO 🎯 | Key terms defined on first use |
| C05 | C | Topic Scope | GEO 🎯 | Explicitly states what is and isn't covered |
| C06 | C | Audience Targeting | Dual ⚡ | States "this article is for..." |
| C07 | C | Semantic Coherence | GEO 🎯 | Logical flow between paragraphs, no jumps |
| C08 | C | Use Case Mapping | GEO 🎯 | Decision framework: when to choose A vs B |
| C09 | C | FAQ Coverage | GEO 🎯 | Structured FAQ covering long-tail follow-ups |
| C10 | C | Semantic Closure | Dual ⚡ | Conclusion answers the opening question + next steps |
| O01 | O | Heading Hierarchy | Dual ⚡ | H1→H2→H3, no level skipping |
| O02 | O | Summary Box | GEO 🎯 | Has TL;DR or Key Takeaways section |
| O03 | O | Data Tables | GEO 🎯 | Comparisons and specs presented in tables |
| O04 | O | List Formatting | GEO 🎯 | Parallel items use bullet or numbered lists |
| O05 | O | Schema Markup | GEO 🎯 | Appropriate JSON-LD (Article/FAQ/HowTo/etc.) |
| O06 | O | Section Chunking | GEO 🎯 | Each section has single topic; paragraphs 3–5 sentences |
| O07 | O | Visual Hierarchy | SEO 🔍 | Key concepts bolded or highlighted |
| O08 | O | Anchor Navigation | Dual ⚡ | Table of contents with jump links |
| O09 | O | Information Density | GEO 🎯 | No filler; consistent terminology throughout |
| O10 | O | Multimedia Structure | Dual ⚡ | Images/videos have captions and carry information |
| R01 | R | Data Precision | GEO 🎯 | ≥5 precise numbers with units (%, $, ms) |
| R02 | R | Citation Density | GEO 🎯 | ≥1 external citation per 500 words |
| R03 | R | Source Hierarchy | GEO 🎯 | Primary sources first; ≥3 Tier 1–2 sources |
| R04 | R | Evidence-Claim Mapping | GEO 🎯 | Every claim backed by evidence immediately after |
| R05 | R | Methodology Transparency | GEO 🎯 | Sample size, steps, and criteria documented |
| R06 | R | Timestamp & Versioning | Dual ⚡ | Last updated <1 year; version changes noted |
| R07 | R | Entity Precision | GEO 🎯 | Full names for people/orgs/products; no "a company" |
| R08 | R | Internal Link Graph | SEO 🔍 | Descriptive anchor texts forming topic clusters |
| R09 | R | HTML Semantics | GEO 🎯 | Uses `<article>`, `<figure>`, `<time>`, `<cite>` |
| R10 | R | Content Consistency | Dual ⚡ | Material facts/calculations self-consistent; cited links resolve |
| E01 | E | Original Data | GEO 🎯 | First-party surveys, experiments, or statistics |
| E02 | E | Novel Framework | GEO 🎯 | Named, citable original framework or model |
| E03 | E | Primary Research | GEO 🎯 | Original experiments/surveys with documented process |
| E04 | E | Contrarian View | GEO 🎯 | Challenges consensus with evidence |
| E05 | E | Proprietary Visuals | Dual ⚡ | ≥2 original infographics, charts, or diagrams |
| E06 | E | Gap Filling | GEO 🎯 | Covers questions competitors don't |
| E07 | E | Practical Tools | Dual ⚡ | Downloadable templates, checklists, or calculators |
| E08 | E | Depth Advantage | GEO 🎯 | Deeper than competing content on same topic |
| E09 | E | Synthesis Value | GEO 🎯 | Cross-domain knowledge combination (A+B=C) |
| E10 | E | Forward Insights | GEO 🎯 | Data-backed predictions and trend analysis |

### EEAT — Source Credibility (40 Items)

| ID | Dim | Check Item | Priority | One-Line Standard |
|----|-----|------------|----------|-------------------|
| Exp01 | Exp | First-Person Narrative | SEO 🔍 | Contains "I tested" or "We found" + action verbs |
| Exp02 | Exp | Sensory Details | SEO 🔍 | ≥10 sensory words (smooth, heavy, bright) |
| Exp03 | Exp | Process Documentation | Dual ⚡ | Step-by-step process with timeline |
| Exp04 | Exp | Tangible Proof | SEO 🔍 | ≥2 original photos/screenshots with timestamps |
| Exp05 | Exp | Usage Duration | SEO 🔍 | States "after X months of use..." |
| Exp06 | Exp | Problems Encountered | Dual ⚡ | Shares ≥2 real problems + solutions |
| Exp07 | Exp | Before/After Comparison | SEO 🔍 | Shows change, improvement, or difference |
| Exp08 | Exp | Quantified Metrics | Dual ⚡ | Measurable experience data (time, cost, success rate) |
| Exp09 | Exp | Repeated Testing | SEO 🔍 | Multiple tests or long-term tracking |
| Exp10 | Exp | Limitations Acknowledged | GEO 🎯 | States "we only tested X scenario" |
| Ept01 | Ept | Author Identity | SEO 🔍 | Byline + avatar + bio (>30 words) |
| Ept02 | Ept | Credentials Display | SEO 🔍 | Relevant degrees, certs, years of experience |
| Ept03 | Ept | Professional Vocabulary | Dual ⚡ | Accurate industry jargon, no misuse |
| Ept04 | Ept | Technical Depth | Dual ⚡ | Parameters, thresholds, examples are actionable |
| Ept05 | Ept | Methodology Rigor | GEO 🎯 | Analysis method is reproducible |
| Ept06 | Ept | Edge Case Awareness | Dual ⚡ | Discusses ≥2 exceptions or "when this doesn't apply" |
| Ept07 | Ept | Historical Context | SEO 🔍 | Shows knowledge of the field's evolution |
| Ept08 | Ept | Reasoning Transparency | GEO 🎯 | "We chose A over B because..." with tradeoffs |
| Ept09 | Ept | Cross-domain Integration | Dual ⚡ | Connects knowledge across fields |
| Ept10 | Ept | Editorial Process | SEO 🔍 | "Reviewed by" or "Fact-checked by" labels |
| A01 | A | Backlink Profile | SEO 🔍 | Cited by authoritative sites (.edu, .gov, leaders) |
| A02 | A | Media Mentions | SEO 🔍 | "Featured in" with media logos |
| A03 | A | Industry Awards | SEO 🔍 | Displays relevant industry awards or recognition |
| A04 | A | Publishing Record | SEO 🔍 | Conference talks, publications, patents |
| A05 | A | Brand Recognition | Dual ⚡ | Brand has search volume |
| A06 | A | Social Proof | SEO 🔍 | Authentic user testimonials with real details |
| A07 | A | Knowledge Graph Presence | Dual ⚡ | Has Wikipedia entry or Google Knowledge Panel |
| A08 | A | Entity Consistency | GEO 🎯 | Brand/author info consistent across the web |
| A09 | A | Partnership Signals | SEO 🔍 | Shows partnerships with authoritative organizations |
| A10 | A | Community Standing | SEO 🔍 | Active and influential in professional communities |
| T01 | T | Legal Compliance | SEO 🔍 | Privacy Policy + Terms of Service present |
| T02 | T | Contact Transparency | SEO 🔍 | Physical address or ≥2 contact methods |
| T03 | T | Security Standards | SEO 🔍 | Site-wide HTTPS, no security warnings |
| T04 | T | Disclosure Statements | Dual ⚡ | Material connections disclosed (conditional veto; N/A when none exist) |
| T05 | T | Editorial Policy | SEO 🔍 | Content standards and review process published |
| T06 | T | Correction & Update Policy | Dual ⚡ | Has corrections page or changelog |
| T07 | T | Ad Experience | SEO 🔍 | Ads <30% of page; no intrusive popups |
| T08 | T | Risk Disclaimers | Dual ⚡ | YMYL topics have necessary disclaimers |
| T09 | T | Review Authenticity | Dual ⚡ | Reviews show authenticity signals |
| T10 | T | Customer Support | SEO 🔍 | Clear return policy, complaint channels, response SLA |

---

## 3. Scoring System

### Per-Item Scoring

| Result | Score |
|--------|-------|
| Pass | 10 |
| Partial | 5 |
| Fail | 0 |
| N/A (item not applicable, e.g., T04 with no material connection) | Excluded from the dimension average — never converted to Partial or Fail |

Rubric-granted conditionality (currently T04 only) is the sole rubric-level source of N/A: no other item may be judged "not applicable" at the auditor's discretion — for every other item, N/A marks only unobservable evidence (e.g., site-level data not provided), never an applicability call.

### Score Calculation

- **Dimension score** = sum of 10 items (0–100)
- **GEO Score** = (C + O + R + E) / 4
- **SEO Score** = (Exp + Ept + A + T) / 4
- **Total Score** = (GEO + SEO) / 2 — unweighted average for quick comparison
- **Weighted Score** = Σ (dimension_score × content_type_weight) — use this for content-type-specific evaluation (see table below)

### Content-Type Weight Table

| Dim | Product Review | How-to Guide | Comparison | Landing Page | Blog Post | FAQ Page | Alternative | Best-of | Testimonial |
|-----|---------------|--------------|------------|--------------|-----------|----------|-------------|---------|-------------|
| C | 10% | 20% | 10% | 20% | 25% | 25% | 10% | 10% | 10% |
| O | 10% | 20% | 20% | 10% | 10% | 25% | 15% | 25% | 5% |
| R | 15% | 10% | 25% | 5% | 10% | 15% | 25% | 20% | 15% |
| E | 20% | 5% | 10% | 5% | 20% | 5% | 5% | 15% | 10% |
| Exp | 20% | 5% | 5% | 5% | 10% | 5% | 15% | 5% | 30% |
| Ept | 5% | 20% | 15% | 5% | 10% | 10% | 5% | 10% | 5% |
| A | 5% | 5% | 5% | 25% | 5% | 5% | 5% | 5% | 5% |
| T | 15% | 15% | 10% | 25% | 10% | 10% | 20% | 10% | 20% |

A content type with no column here — an e-commerce category page (Section 5) is the current case — has **no library-set weight profile**. Score it with the unweighted **Total Score** and say in the report that no weight profile exists for the type. Never improvise a column: a weight invented per audit makes two audits of the same page incomparable, which is the one thing a weighted score is for.

### Rating Scale

| Score Range | Rating |
|-------------|--------|
| 90–100 | Excellent |
| 75–89 | Good |
| 60–74 | Medium |
| 40–59 | Low |
| 0–39 | Poor |

### Veto Items

Three items act as vetoes — trust failures that override the arithmetic regardless of other scores:

- **T04** — A material connection (sponsorship, ownership, compensated product, affiliate relationship) undisclosed or materially obscured. **Conditional veto**: T04 applies only when a material connection exists; when none exists, T04 is N/A and excluded from scoring — absence of connections is never scored Partial.
- **C01** — Clickbait (title doesn't match content)
- **R10** — Material internal contradiction: two parts of the content make incompatible factual or numerical claims. Isolated broken links, stale non-material references, and wording inconsistencies are remediable Partial-level findings — they never trigger this veto.

**Veto scoring consequences** — framework rule definitions (normative, not empirical thresholds):

| Veto outcome | Effect on the final score |
|--------------|---------------------------|
| One verified veto failure | Final overall score capped at 59 (top of "Low"); the cap is flagged in the report |
| Two or more verified veto failures | BLOCK-class outcome — no final score is reported (dimension scores may still be shown; the final is suppressed) |
| Evidence for a veto item missing or unassessable | No final score is issued at all — a veto item is never guessed past |

---

## 4. AI Engine Citation Preferences

### Engine-Specific Priorities

| Engine | Citation Style | Priority Items |
|--------|---------------|----------------|
| Google AI Overview | Snippet extraction from paragraphs, lists, tables, FAQs | C02, O03, O05, C09 |
| ChatGPT Browse | Conversational with links | C02, R01, R02, E01 |
| Perplexity AI | Multi-source synthesis + inline citations | E01, R03, R05, Ept05 |
| Claude | Precision-first with nuanced arguments | R04, Ept08, Exp10, R03 |

### Top 6 GEO-First Priority Items

| Rank | ID | Name | Why It Matters |
|------|----|------|----------------|
| 1 | C02 | Direct Answer | All engines extract from first paragraph |
| 2 | C09 | FAQ Coverage | FAQ structure directly matches user follow-ups |
| 3 | O03 | Data Tables | Comparison data is most extractable format |
| 4 | O05 | Schema Markup | JSON-LD helps AI understand content type |
| 5 | E01 | Original Data | AI prefers citing exclusive sources |
| 6 | O02 | Summary Box | Key Takeaways often first choice for AI summary |

---

## 5. Schema by Content Type

One primary content type per page (item O05). Documented auxiliaries are legitimate only when each has its own engine-documented, non-citation job and the page data warrants it: BreadcrumbList for a real breadcrumb trail; Organization/Person as publisher/author identity (normally nested inside the primary — top-level only on the entity's own page); WebSite on the homepage. A second full content type on the same page (e.g., FAQPage bolted onto a service page) is not allowed — unless the page genuinely is both things and each type is complete, accurate, and independently justified.

| Content Type | Primary Type (pick ONE) | Documented Auxiliaries (only if warranted) |
|-------------|------------------------|--------------------------------------------|
| Blog (guides) | Article — HowTo instead when the page IS a step-by-step procedure | BreadcrumbList (real trail); author/publisher nested |
| Blog (tools) | Article | BreadcrumbList; author/publisher nested |
| Blog (insights) | Article | BreadcrumbList; author/publisher nested |
| Alternative | Article (comparison editorial) | BreadcrumbList |
| Best-of | ItemList | BreadcrumbList |
| E-commerce category (product listing) | ItemList — the products as `itemListElement` entries | BreadcrumbList (real trail); seller/publisher Organization nested; each product described *inside* the list, never a separate top-level `Product` per item |
| Use-case | WebPage | BreadcrumbList |
| FAQ | FAQPage | BreadcrumbList |
| Landing | SoftwareApplication (or the accurate Product/Service type) | BreadcrumbList |
| Testimonial | Review | BreadcrumbList; reviewed item + reviewer nested inside the Review |

**The e-commerce category row, and `CollectionPage`.** A catalogue listing page is the same shape as Best-of — a page whose content *is* the list — so it takes the same primary type, and the library's schema skill already maps it that way (`build/schema-markup-generator/references/schema-decision-tree.md`, E-commerce row: "category/list pages → ItemList"). `CollectionPage` is also a valid schema.org page type for such a page, and is what an unaided derivation tends to reach for. Rule: **new markup uses `ItemList`**, so that two skills scoring the same page produce the same answer; where a page **already** carries `CollectionPage` as its root with the listing nested as its `mainEntity`, that is one accurate object graph — leave it, do not rewrite it, and never emit both as top-level objects. [VERIFY — the schema.org modelling behind this pair is not owner-read: schema.org and developers.google.com are both refused by this environment's egress (re-tested 2026-08-13). No engine documents a category-page rich result, so this is a type-accuracy call, not a feature call; an owner read of `schema.org/CollectionPage` and `schema.org/ItemList` would settle it.]

**Nesting is not stacking.** A type that appears only as the value of a property of the primary object — `mainEntity`, `itemListElement`, `publisher`, `author`, `about`, `itemReviewed` — describes part of that object. It makes no second claim about what the page *is*, so it is not a second content type and it is not stacking. That is the shape settled ruling R2 already sanctions when it nests Organization as publisher. Stacking is a second content type at the **root** of the graph: two top-level objects, or a second `@type` on the root node, each asserting the page is something. The test in one question: **could this node stand alone as a claim about the page?** A `CollectionPage` whose `mainEntity` is an `ItemList` makes one claim. A page emitting `ItemList` and `FAQPage` side by side makes two. (This states how R2 applies to nesting, which R2 does not mention; it changes no Pass criterion here.)

**When the correct type changes because of the edit.** R2 bans *adding* a second type; it does not freeze the first one. If an optimisation genuinely changes what the page is — a guide rewritten into a step-by-step procedure moves from Article to HowTo under the Blog (guides) row above — the primary type is **replaced** in the same change: the old object goes out as the new one goes in, the page still carries exactly one primary type, and no stacking occurs. R2's "never bolted onto a page that already carries an accurate type" turns on *accurate*, and a type the edit has made wrong is no longer that. Two guards on it. First, the change is reported, naming what in the content moved it, and the replacement is routed through the library's schema skill rather than emitted on a hunch. Second, the bar is what the page now **is**, not how it now looks: a page that gained a numbered list of tips is not a procedure; a page whose purpose is to walk the reader through an ordered process, where the order is load-bearing, is. O05 scores type accuracy, so the only question is ever which type is true of the page.

---

## 6. Content Type Decision Tree

```
What is the primary goal?
├── Teach users how to do something         → Blog (guides)
├── Your product vs one competitor           → Alternative
├── Objective comparison of 3+ products      → Best-of
├── List the products in a catalogue section → E-commerce category
├── Show product fits a persona              → Use-case
├── Show verified customer results           → Testimonial
├── Answer common questions                  → FAQ
├── Describe product features                → Landing
└── Share industry insights or trends        → Blog (insights)
```

---

## 7. Detailed Criteria Reference

### C — Contextual Clarity

**C01: Intent Alignment** | Dual ⚡
- **Pass**: Title promise fully delivered; intent type clear.
- **Partial**: Mostly aligned with minor drift.
- **Fail**: Clickbait; content doesn't match title.

**C02: Direct Answer** | GEO 🎯
- **Pass**: First 150 words contain clear definition or conclusion (directly citable by AI). The count starts at the first body word after the H1 — the H1's own words are not part of the count.
- **Partial**: Answer within first 300 words with lengthy preamble.
- **Fail**: Answer buried in middle or end.

**C03: Query Coverage** | Dual ⚡
- **Pass**: Covers ≥3 query variants; appropriate entity density.
- **Partial**: 1–2 variants.
- **Fail**: Single exact query only.

**C04: Definition First** | GEO 🎯
- **Pass**: All key terms defined on first use.
- **Partial**: Most terms defined.
- **Fail**: Terms used without definition.

**C05: Topic Scope** | GEO 🎯
- **Pass**: Explicitly states "This covers X, not Y"; meets AI completeness threshold.
- **Partial**: Implied boundaries.
- **Fail**: Scope unclear; content sprawls.

**C06: Audience Targeting** | Dual ⚡
- **Pass**: Explicitly states target reader; language matches audience.
- **Partial**: Implied through difficulty.
- **Fail**: Audience unclear; inconsistent difficulty.

**C07: Semantic Coherence** | GEO 🎯
- **Pass**: Logical connectors between paragraphs; no semantic jumps.
- **Partial**: Mostly coherent with occasional jumps.
- **Fail**: Frequent logic breaks.

**C08: Use Case Mapping** | GEO 🎯
- **Pass**: Clearly states applicable/inapplicable scenarios; decision framework provided.
- **Partial**: Some scenarios mentioned.
- **Fail**: No use case guidance.

**C09: FAQ Coverage** | GEO 🎯
- **Pass**: Structured FAQ covering long-tail follow-ups, present as a visible on-page Q&A block. **Markup is not required for the Pass** — engines parse the visible Q&A either way. FAQPage JSON-LD is creditable only where FAQPage is the page's ONE primary type (Section 5); bolting it onto a page that already carries an accurate primary type is stacking and is not allowed, so such a page earns its C09 Pass on the visible FAQ alone and is scored for O05 on the primary type the page actually needs.
- **Partial**: Q&A content but not structured.
- **Fail**: No FAQ or Q&A.

**C10: Semantic Closure** | Dual ⚡
- **Pass**: Conclusion answers opening question + provides next steps.
- **Partial**: Conclusion but doesn't loop back.
- **Fail**: No conclusion or unrelated.

### O — Organization

**O01: Heading Hierarchy** | Dual ⚡
- **Pass**: Single H1; H2→H3 nested; no level skipping.
- **Partial**: Minor skipping but clear.
- **Fail**: Chaotic hierarchy, multiple H1s.

**O02: Summary Box** | GEO 🎯
- **Pass**: Prominent TL;DR or Key Takeaways box.
- **Partial**: Summary but not prominent.
- **Fail**: No summary.

**O03: Data Tables** | GEO 🎯
- **Pass**: HTML tables for comparisons/specs with clear headers.
- **Partial**: Tables but unclear.
- **Fail**: Prose where tables would be better.

**O04: List Formatting** | GEO 🎯
- **Pass**: ~1–2 lists per 500 words; parallel items listed.
- **Partial**: Insufficient or excessive.
- **Fail**: Overused or absent.

**O05: Schema Markup** | GEO 🎯
- **Pass**: Correct JSON-LD matching content type.
- **Partial**: Schema but wrong type.
- **Fail**: No schema.

**O06: Section Chunking** | GEO 🎯
- **Pass**: Each section single topic; paragraphs 3–5 sentences.
- **Partial**: Most clear; some too long.
- **Fail**: Mixed topics; walls of text.

**O07: Visual Hierarchy** | SEO 🔍
- **Pass**: Important content bolded/highlighted; key concepts emphasized.
- **Partial**: Some emphasis.
- **Fail**: No visual hierarchy.

**O08: Anchor Navigation** | Dual ⚡
- **Pass**: Table of contents with anchor links; breadcrumbs.
- **Partial**: TOC but no anchors.
- **Fail**: Long content without navigation.

**O09: Information Density** | GEO 🎯
- **Pass**: High information density; no filler; consistent terminology.
- **Partial**: Minor repetition.
- **Fail**: Significant filler.

**O10: Multimedia Structure** | Dual ⚡
- **Pass**: Images/videos have captions; positioned purposefully.
- **Partial**: Multimedia but lacks descriptions.
- **Fail**: No multimedia or decorative only.

### R — Referenceability

**R01: Data Precision** | GEO 🎯
- **Pass**: ≥5 precise data points with units; directly extractable.
- **Partial**: 2–4 data points.
- **Fail**: No precise data; vague descriptions.

**R02: Citation Density** | GEO 🎯
- **Pass**: ≥1 external citation per 500 words; ≥3 source types.
- **Partial**: ≥1 per 1000 words; 2 types.
- **Fail**: Insufficient citations.

**R03: Source Hierarchy** | GEO 🎯
- **Pass**: Primary sources prioritized; ≥3 Tier 1–2 sources.
- **Partial**: 1–2 Tier 1–2.
- **Fail**: No authoritative sources.

**R04: Evidence-Claim Mapping** | GEO 🎯
- **Pass**: Every core claim immediately followed by evidence.
- **Partial**: Most claims backed.
- **Fail**: Multiple claims without evidence.

**R05: Methodology Transparency** | GEO 🎯
- **Pass**: Sample size, steps, criteria documented; reproducible.
- **Partial**: Partial methodology.
- **Fail**: No methodology.

**R06: Timestamp & Versioning** | Dual ⚡
- **Pass**: Updated <1 year; date visible; version notes.
- **Partial**: 1–3 years old.
- **Fail**: >3 years or no date.

**R07: Entity Precision** | GEO 🎯
- **Pass**: Full names for entities; no vague references.
- **Partial**: Most precise; occasional vagueness.
- **Fail**: Frequent vague references.

**R08: Internal Link Graph** | SEO 🔍
- **Pass**: Descriptive anchors forming topic clusters.
- **Partial**: Links but non-descriptive anchors.
- **Fail**: No internal links or "click here".

**R09: HTML Semantics** | GEO 🎯
- **Pass**: Correct semantic tags (`<article>`, `<figure>`, `<time>`, `<cite>`).
- **Partial**: Some tags.
- **Fail**: Pure `<div>` markup.

**R10: Content Consistency** | Dual ⚡
- **Pass**: Material facts and calculations internally consistent; cited links resolve at the observation date.
- **Partial**: Isolated broken links, stale non-material references, or wording inconsistencies — remediable findings that never trigger the veto.
- **Fail**: Material internal contradiction — two parts of the content make incompatible factual or numerical claims — VETO.

### E — Exclusivity

**E01: Original Data** | GEO 🎯
- **Pass**: First-party data; dataset is citable.
- **Partial**: Some original data.
- **Fail**: All data from others.

**E02: Novel Framework** | GEO 🎯
- **Pass**: Named, citable original framework.
- **Partial**: Innovates on existing.
- **Fail**: No framework innovation.

**E03: Primary Research** | GEO 🎯
- **Pass**: Documented research process (conditions, metrics, controls).
- **Partial**: Some primary research.
- **Fail**: No primary research.

**E04: Contrarian View** | GEO 🎯
- **Pass**: Challenges consensus with data/logic.
- **Partial**: Some differentiated views.
- **Fail**: Entirely follows convention.

**E05: Proprietary Visuals** | Dual ⚡
- **Pass**: ≥2 original infographics/charts/visualizations.
- **Partial**: 1 original.
- **Fail**: No original visuals.

**E06: Gap Filling** | GEO 🎯
- **Pass**: Covers niche questions competitors miss.
- **Partial**: Partially fills gaps.
- **Fail**: Highly similar to competitors.

**E07: Practical Tools** | Dual ⚡
- **Pass**: ≥1 downloadable template/checklist/calculator.
- **Partial**: Examples but not actionable.
- **Fail**: No practical tools.

**E08: Depth Advantage** | GEO 🎯
- **Pass**: Depth clearly exceeds competitors.
- **Partial**: Comparable depth.
- **Fail**: Shallower than competitors.

**E09: Synthesis Value** | GEO 🎯
- **Pass**: Cross-domain knowledge producing new insights.
- **Partial**: Some cross-domain but not novel.
- **Fail**: Single domain only.

**E10: Forward Insights** | GEO 🎯
- **Pass**: Data-backed predictions with clear reasoning.
- **Partial**: Some forward-looking.
- **Fail**: Only past/present.

### Exp — Experience

**Exp01: First-Person Narrative** | SEO 🔍
- **Pass**: First-person + action verb combinations.
- **Partial**: Only one of the two.
- **Fail**: Entirely third-person.

**Exp02: Sensory Details** | SEO 🔍
- **Pass**: ≥10 sensory words.
- **Partial**: 5–9.
- **Fail**: <5.

**Exp03: Process Documentation** | Dual ⚡
- **Pass**: Detailed process with steps, timeline, decision points.
- **Partial**: Partial process.
- **Fail**: None.

**Exp04: Tangible Proof** | SEO 🔍
- **Pass**: ≥2 original images with timestamps/context.
- **Partial**: 1 original.
- **Fail**: None.

**Exp05: Usage Duration** | SEO 🔍
- **Pass**: Explicitly states testing/usage duration.
- **Partial**: Implied.
- **Fail**: None.

**Exp06: Problems Encountered** | Dual ⚡
- **Pass**: ≥2 problems with solutions/workarounds.
- **Partial**: 1 problem.
- **Fail**: All positive.

**Exp07: Before/After Comparison** | SEO 🔍
- **Pass**: Clear before/after or side-by-side comparison.
- **Partial**: Implied.
- **Fail**: None.

**Exp08: Quantified Metrics** | Dual ⚡
- **Pass**: Quantified experience data.
- **Partial**: Some quantified.
- **Fail**: Purely subjective.

**Exp09: Repeated Testing** | SEO 🔍
- **Pass**: Multiple tests or long-term tracking.
- **Partial**: Implied.
- **Fail**: Single test.

**Exp10: Limitations Acknowledged** | GEO 🎯
- **Pass**: Explicitly states experience limitations.
- **Partial**: Partially acknowledges.
- **Fail**: None.

### Ept — Expertise

**Ept01: Author Identity** | SEO 🔍
- **Pass**: Byline + avatar + bio (>30 words).
- **Partial**: 1–2 of these.
- **Fail**: No author info.

**Ept02: Credentials Display** | SEO 🔍
- **Pass**: Relevant professional qualifications displayed.
- **Partial**: Weak relevance.
- **Fail**: None.

**Ept03: Professional Vocabulary** | Dual ⚡
- **Pass**: Accurate industry jargon; no misuse.
- **Partial**: Moderate.
- **Fail**: Too simple or misused.

**Ept04: Technical Depth** | Dual ⚡
- **Pass**: Technical details accurate; parameters/thresholds actionable.
- **Partial**: Shallow.
- **Fail**: Superficial or errors.

**Ept05: Methodology Rigor** | GEO 🎯
- **Pass**: Methodology clear, reproducible, follows standards.
- **Partial**: Not rigorous enough.
- **Fail**: No methodology or flawed.

**Ept06: Edge Case Awareness** | Dual ⚡
- **Pass**: ≥2 edge cases discussed.
- **Partial**: 1 edge case.
- **Fail**: None.

**Ept07: Historical Context** | SEO 🔍
- **Pass**: Demonstrates field's development history.
- **Partial**: Some background.
- **Fail**: No historical perspective.

**Ept08: Reasoning Transparency** | GEO 🎯
- **Pass**: Explicit cause-effect and tradeoffs.
- **Partial**: Some reasoning.
- **Fail**: Conclusions without reasoning.

**Ept09: Cross-domain Integration** | Dual ⚡
- **Pass**: Cross-domain knowledge generating new perspectives.
- **Partial**: Some.
- **Fail**: Single domain.

**Ept10: Editorial Process** | SEO 🔍
- **Pass**: "Reviewed by" or "Fact-checked by" labels visible.
- **Partial**: Review but no labels.
- **Fail**: None.

### A — Authority

**A01: Backlink Profile** | SEO 🔍
- **Pass**: Cited by authoritative sites.
- **Partial**: Some backlinks.
- **Fail**: None notable.

**A02: Media Mentions** | SEO 🔍
- **Pass**: "Featured in" with media logos.
- **Partial**: Minor mentions.
- **Fail**: None.

**A03: Industry Awards** | SEO 🔍
- **Pass**: Relevant industry awards.
- **Partial**: Weakly relevant.
- **Fail**: None.

**A04: Publishing Record** | SEO 🔍
- **Pass**: Conference talks, publications, patents.
- **Partial**: Some.
- **Fail**: None.

**A05: Brand Recognition** | Dual ⚡
- **Pass**: Brand has search volume.
- **Partial**: Some awareness.
- **Fail**: Unknown.

**A06: Social Proof** | SEO 🔍
- **Pass**: Authentic reviews with real details.
- **Partial**: Uncertain credibility.
- **Fail**: None.

**A07: Knowledge Graph Presence** | Dual ⚡
- **Pass**: Wikipedia entry or Knowledge Panel.
- **Partial**: Partially indexed.
- **Fail**: Not in any.

**A08: Entity Consistency** | GEO 🎯
- **Pass**: Brand/author consistent across web.
- **Partial**: Mostly consistent.
- **Fail**: Contradictions.

**A09: Partnership Signals** | SEO 🔍
- **Pass**: Partnerships with authoritative orgs.
- **Partial**: Some signals.
- **Fail**: None.

**A10: Community Standing** | SEO 🔍
- **Pass**: Active and influential in communities.
- **Partial**: Some participation.
- **Fail**: None.

### T — Trust

**T01: Legal Compliance** | SEO 🔍
- **Pass**: Privacy Policy + TOS present + bonus (Cookie, GDPR).
- **Partial**: Required only.
- **Fail**: Missing required.

**T02: Contact Transparency** | SEO 🔍
- **Pass**: Physical address or ≥2 contact methods.
- **Partial**: Email only.
- **Fail**: None.

**T03: Security Standards** | SEO 🔍
- **Pass**: Site-wide HTTPS; no warnings.
- **Partial**: Some pages insecure.
- **Fail**: HTTP.

**T04: Disclosure Statements** | Dual ⚡
- **Applicability**: Conditional veto — assessed only when a material connection exists (sponsorship, ownership, compensated products, affiliate relationships). With no material connection, T04 is N/A and excluded from scoring — never recorded as Partial.
- **Pass**: Every material connection carries a clear, human-readable disclosure placed where readers encounter the connection.
- **Partial**: Disclosure present but contextually weak — buried (e.g., footer-only), ambiguous wording, or placed far from the connection it covers.
- **Fail**: A material connection undisclosed or materially obscured — VETO. Link markup (`rel="sponsored"` etc.) does not substitute for human-readable disclosure.

**T05: Editorial Policy** | SEO 🔍
- **Pass**: Content standards and review process published.
- **Partial**: Some guidelines.
- **Fail**: None.

**T06: Correction & Update Policy** | Dual ⚡
- **Pass**: Corrections page, update principles, revision history.
- **Partial**: Update dates but no formal mechanism.
- **Fail**: None.

**T07: Ad Experience** | SEO 🔍
- **Pass**: Ads <30% of page; no intrusive popups.
- **Partial**: 30–50%.
- **Fail**: >50% or deceptive.

**T08: Risk Disclaimers** | Dual ⚡
- **Pass**: YMYL topics have disclaimers.
- **Partial**: Some coverage.
- **Fail**: YMYL with no disclaimers.

**T09: Review Authenticity** | Dual ⚡
- **Pass**: Reviews show authenticity signals.
- **Partial**: Uncertain.
- **Fail**: Obviously fake or absent.

**T10: Customer Support** | SEO 🔍
- **Pass**: Clear return policy, complaint channels, response SLA.
- **Partial**: Unclear.
- **Fail**: None.

---

## 8. Calibration Examples

Calibration examples for the most subjective CORE items. Use these to anchor scoring consistency. EEAT items are excluded here as they tend to be more clear-cut.

### C — Contextual Clarity

**C05 (Topic Scope)** — Does the content explicitly state what is and isn't covered?

- **Pass**: "This guide covers on-page SEO for WordPress sites running WooCommerce. It does not cover technical server configuration, JavaScript-rendered SPAs, or paid search campaigns." Clear boundaries that set reader expectations and prevent scope creep.
- **Partial**: "We'll look at the main SEO factors for your website." Implies some boundary but never states what is excluded; a reader might expect technical SEO or paid search content.
- **Fail**: Article titled "Complete SEO Guide" that covers only title tags and meta descriptions with no mention of the limited scope. Reader expectation is violated.

**C07 (Semantic Coherence)** — Does the content flow logically between paragraphs?

- **Pass**: Article on database indexing moves from "what indexes are" to "how B-tree indexes work" to "when to add indexes" to "common indexing mistakes," with each section building on the previous. Transition sentences connect ideas explicitly.
- **Partial**: Article covers the same topics but jumps from B-tree internals to a marketing anecdote about database costs, then returns to technical content. The detour is brief but breaks the logical chain.
- **Fail**: Article alternates between beginner explanations and advanced query optimization with no transitions. A paragraph about "what is SQL" is followed by EXPLAIN ANALYZE output with no bridging context.

**C08 (Use Case Mapping)** — Does the content provide a decision framework for when to choose A vs B?

- **Pass**: "Use Redis for session caching and rate limiting where sub-millisecond latency matters and data loss on restart is acceptable. Use PostgreSQL for transactional data requiring ACID guarantees. Use both together when your application needs fast reads with durable writes." Explicit scenarios with selection criteria.
- **Partial**: "Redis is fast and PostgreSQL is reliable. Choose based on your needs." Mentions both options but provides no concrete selection criteria or scenarios.
- **Fail**: Article compares Redis and PostgreSQL features in a table but never states when to choose one over the other. The reader is left to infer applicability.

### O — Organization

**O04 (List Formatting)** — Are parallel items presented as bullet or numbered lists?

- **Pass**: Article on migration strategies presents the 5 steps as a numbered list, each with a bold label and one-sentence description. Comparison of 4 hosting providers uses a consistent bullet format with the same attributes for each.
- **Partial**: Three migration steps are in a numbered list, but two additional steps are buried in a prose paragraph. The reader must parse narrative text to find them.
- **Fail**: Seven distinct recommendations are written as a single run-on paragraph with semicolons separating them. No lists appear in a 2,000-word article despite multiple sequences of parallel items.

**O09 (Information Density)** — Is the content free of filler with consistent terminology?

- **Pass**: Every sentence either introduces a fact, provides evidence, or advances the argument. The term "conversion rate" is used consistently (never alternating with "conversion ratio" or "CR" without definition). No throat-clearing phrases like "It is important to note that."
- **Partial**: Content is mostly dense but includes a 150-word introductory paragraph restating what the reader already knows ("In today's digital landscape, SEO is more important than ever..."). Core terminology is consistent except for one section that switches from "bounce rate" to "exit rate" without clarifying the difference.
- **Fail**: Article pads sections with generic filler ("As we all know, content is king") and uses "CTR," "click-through rate," and "click rate" interchangeably across sections. Approximately 30% of the word count adds no new information.

### R — Referenceability

**R03 (Source Hierarchy)** — Are primary sources prioritized with sufficient Tier 1-2 sourcing?

- **Pass**: Article on search algorithm changes cites Google's official Search Central blog post (Tier 1), a peer-reviewed information retrieval paper (Tier 1), and Ahrefs' 11-million-URL study (Tier 2). Secondary commentary from industry blogs is clearly labeled as interpretation.
- **Partial**: Article cites one Google documentation page but primarily relies on screenshots from unnamed Twitter threads and a single blog post from a mid-tier SEO site. No peer-reviewed or primary research sources.
- **Fail**: All claims reference "experts say" or "studies show" without naming any source. The only link is to another article on the same site that also lacks primary sources.

**R05 (Methodology Transparency)** — Are sample size, steps, and criteria documented?

- **Pass**: "We analyzed 1,200 product pages across 45 e-commerce sites between January and March 2025. Pages were selected by filtering for >1,000 monthly organic sessions. We measured Core Web Vitals using the CrUX API and correlated LCP scores with conversion rates using Pearson's r." Reproducible by another researcher.
- **Partial**: "We looked at several hundred pages and found that faster sites convert better." States a finding but omits sample size, selection criteria, time period, and measurement method.
- **Fail**: "Our research proves that page speed impacts conversions." No methodology of any kind. The word "research" is used but nothing about the process is documented.

### E — Exclusivity

**E04 (Contrarian View)** — Does the content challenge consensus with evidence?

- **Pass**: "The common advice to always compress images to WebP ignores the 12% of global browsers that still lack full WebP support (Can I Use, January 2025). In our test of 50 site migrations to WebP-only, 8 sites saw increased bounce rates from Safari users on older iOS versions. A dual-format approach with `<picture>` fallbacks outperformed WebP-only by 3.2% in our conversion tests."
- **Partial**: "Some people disagree with always using WebP, and there may be compatibility issues to consider." Acknowledges a different viewpoint exists but provides no evidence, data, or specific scenarios.
- **Fail**: No alternative viewpoints are presented. The article treats WebP adoption as universally beneficial without acknowledging any tradeoffs, edge cases, or dissenting perspectives.

**E06 (Gap Filling)** — Does the content cover questions that competitors miss?

- **Pass**: Competitor analysis shows the top 5 ranking articles on "Kubernetes autoscaling" all cover Horizontal Pod Autoscaler. This article additionally covers Vertical Pod Autoscaler, KEDA event-driven scaling, and cluster autoscaler interaction patterns — topics absent from competing content. Includes a decision matrix for choosing between scaling approaches.
- **Partial**: Article covers one subtopic (KEDA) that competitors miss, but the coverage is a single paragraph without enough depth to be useful as a standalone reference.
- **Fail**: Article covers the exact same subtopics as the top 5 competing articles with no additional angles, edge cases, or niche questions addressed.

**E09 (Synthesis Value)** — Does the content combine cross-domain knowledge to produce new insights?

- **Pass**: Article on SaaS pricing combines behavioral economics research (anchoring effect, loss aversion) with B2B sales cycle data and A/B test results from 3 SaaS companies to propose a pricing page framework. The intersection of psychology, sales data, and UX testing produces an insight none of the individual domains would yield alone.
- **Partial**: Article mentions that "psychology plays a role in pricing" and references one anchoring study, but does not synthesize it with domain-specific data or produce a novel framework. The cross-domain mention is surface-level.
- **Fail**: Article discusses SaaS pricing purely from a feature-comparison perspective. No knowledge from adjacent fields (psychology, economics, design) is incorporated.
