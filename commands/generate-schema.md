---
name: generate-schema
description: Generate Schema.org JSON-LD structured data markup for a page
argument-hint: "<schema type> for <content description>"
allowed-tools: ["WebFetch"]
parameters:
  - name: schema_type
    type: string
    required: true
    description: "Schema type: FAQ, HowTo, Article, Product, LocalBusiness, Organization, Breadcrumb, Review, Event, Video"
  - name: source
    type: string
    required: false
    description: URL, pasted content, or description of the content
---

# Generate Schema Command

Generates valid **Schema.org JSON-LD** structured data markup so search and answer engines can parse the page's entities. Rich-result eligibility depends on the type -- FAQPage has none since Google's 2026 change and is generated because it stays valid and Google advises against removing it (settled ruling R3 + amendment 9a; no evidenced citation benefit either way, so claim none).

## Usage

```
/seo:generate-schema FAQ for our support FAQ page
/seo:generate-schema Product for [product details]
/seo:generate-schema Article for https://example.com/blog-post
/seo:generate-schema LocalBusiness for our main location page
/seo:generate-schema HowTo for installation guide
```

**Arguments:**
- Schema type (required): FAQ, HowTo, Article, Product, LocalBusiness, Organization, Breadcrumb, Review, Event, Video
- Content source: URL, pasted content, or description

## Workflow

1. **Identify Schema Requirements** -- Parse schema type, fetch URL content if provided, settle the ONE primary type the page actually is, and note any documented auxiliary the page data warrants (BreadcrumbList for a real trail).
2. **Generate Schema Markup** -- Invoke `schema-markup-generator`. Select most specific type, collect required + recommended properties, generate valid JSON-LD, validate syntax at the Schema.org validator, and check Google's rich-result requirements for the types that still have one.
3. **Compile Output** -- Format markup with validation results and implementation instructions.

## Output Format

```
# SKELETON -- scaffold, not output. Every [bracket] is a slot filled from the page's own
# data; the JSON-LD itself ships resolved values only, any unsourceable property dropped
# and the gap named in prose.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SCHEMA.ORG MARKUP GENERATOR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PRIMARY TYPE (ONE per page): [SchemaType]
AUXILIARIES: [BreadcrumbList -- real trail | none]
RICH RESULT ELIGIBILITY: [prose per type emitted -- what Google is eligible to show, never
  Yes/No, never an appearance promise. FAQPage: none, retired 2026; value is AI-engine/GEO
  parsing (settled ruling R3)]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GENERATED MARKUP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Complete JSON-LD markup]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VALIDATION RESULTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[JSON syntax, required properties, data types; Google rich-result requirements only for the
types that still have one]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
IMPLEMENTATION INSTRUCTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Add JSON-LD to page <head> in a <script type="application/ld+json"> tag
2. Validate syntax at https://validator.schema.org -- every type, always
3. Types that still have a Google rich result: also run
   https://search.google.com/test/rich-results, then submit the URL in Search Console and
   allow 2-4 weeks for the result to appear if Google chooses to show one
4. FAQPage: stop after step 2. Google ended FAQ rich results in 2026 -- Rich Results Test
   support and Search Console reporting are both gone (API support scheduled August 2026,
   not yet observed), so there is nothing to test and nothing to wait for. Keep the markup
   because it stays valid and Google advises against proactively removing it. Do NOT tell
   the user it earns AI citations: ruling R3 amendment 9a records that no primary source
   establishes that either way (settled ruling R3)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Tips

- One primary content type per page (settled ruling R2, CORE-EEAT O05) -- pick the type the page IS and nest supporting entities inside it as properties: a product page is Product with `review`/`aggregateRating` nested, not Product + Review side by side
- Documented auxiliaries are not stacking and stay welcome -- BreadcrumbList where a real trail exists, Organization/Person as publisher or author identity, WebSite on the homepage. A second full content type IS stacking and is not allowed (FAQPage bolted onto a service or pricing page, Article + Product both as primaries), unless the page genuinely is both things and each type is complete, accurate and independently justified
- A visible on-page Q&A block earns CORE-EEAT C09 on its own -- markup is not required for it. Generate FAQPage only where FAQPage is the page's one primary type
- Do not mark up content not visible on the page (violates Google guidelines)
- Update schema when content changes (prices, dates, addresses)

## Related Skills

- [schema-markup-generator](../build/schema-markup-generator/) -- Full schema markup generation workflow
