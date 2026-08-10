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

Generates valid **Schema.org JSON-LD** structured data markup to enhance search visibility and enable rich results.

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
2. **Generate Schema Markup** -- Invoke `schema-markup-generator`. Select most specific type, collect required + recommended properties, generate valid JSON-LD, validate against Google rich result requirements.
3. **Compile Output** -- Format markup with validation results and implementation instructions.

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SCHEMA.ORG MARKUP GENERATOR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PRIMARY TYPE (ONE per page): [SchemaType]
AUXILIARIES: [BreadcrumbList -- real trail | none]
RICH RESULT ELIGIBLE: [Yes/No]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
GENERATED MARKUP
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Complete JSON-LD markup]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
VALIDATION RESULTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[JSON syntax, required properties, data types, Google requirements]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
IMPLEMENTATION INSTRUCTIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Add JSON-LD to page <head> in a <script type="application/ld+json"> tag
2. Test: https://search.google.com/test/rich-results
3. Submit URL in Google Search Console; allow 2-4 weeks for rich results

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
