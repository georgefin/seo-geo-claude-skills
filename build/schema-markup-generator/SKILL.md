---
name: schema-markup-generator
version: "4.1.0"
description: 'Generate Schema.org JSON-LD structured data — one accurate primary type per page (FAQPage, HowTo, Article, Product, LocalBusiness, and 6 other types) plus documented auxiliaries only where warranted. Use when the user asks to "add schema markup", "generate structured data", "JSON-LD", "FAQ schema", "rich snippets", "I want star ratings in Google", or "structured data validation errors". Produces validated markup for Google rich results where still offered (FAQ rich results retired 2026 — FAQPage is kept for AI-engine/GEO parsing), Bing structured data, and AI system understanding. Validates via the Schema.org validator, plus Rich Results Test for non-FAQ types. For broader technical SEO, see technical-seo-checker. For meta tag optimization, see meta-tags-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
allowed-tools: WebFetch
metadata:
  author: aaron-he-zhu
  version: "4.1.0"
  geo-relevance: "medium"
  tags:
    - seo
    - structured-data
    - json-ld
    - rich-results
    - rich-snippets
    - faq-schema
    - howto-schema
    - product-schema
    - article-schema
    - localbusiness-schema
    - schema-org
  triggers:
    - "add schema markup"
    - "generate structured data"
    - "JSON-LD"
    - "rich snippets"
    - "FAQ schema"
    - "schema.org"
    - "structured data markup"
    - "add FAQ rich results"
    - "I want star ratings in Google"
    - "product markup"
    - "recipe schema"
---

# Schema Markup Generator

This skill creates Schema.org structured data markup in JSON-LD format — ONE accurate primary type per page (settled ruling R2, CORE-EEAT O05) — to help search and AI engines understand your content and enable rich results where Google still offers them.

## When to Use This Skill

- Adding FAQ schema for AI-engine/GEO parsing value
- Creating How-To schema for step-by-step content
- Adding Product schema for e-commerce pages
- Implementing Article schema for blog posts
- Adding Local Business schema for location pages
- Creating Review/Rating schema
- Implementing Organization schema for brand presence
- Any page where rich results (non-FAQ) or AI-engine parsing would improve visibility

## What This Skill Does

1. **Schema Type Selection**: Recommends the ONE primary type that matches the page
2. **JSON-LD Generation**: Creates valid structured data markup
3. **Property Mapping**: Maps your content to schema properties
4. **Validation Guidance**: Ensures schema meets requirements
5. **Nested Entities**: Nests supporting entities (Offer, author, publisher, organizer, provider) inside the primary type instead of emitting extra top-level objects
6. **Rich Result Eligibility**: Flags which rich results still exist for the chosen type (FAQ retired 2026)

## How to Use

### Generate Schema for Content

```
Generate schema markup for this [content type]: [content/URL]
```

```
Create FAQ schema for these questions and answers: [Q&A list]
```

### Specific Schema Types

```
Create Product schema for [product name] with [details]
```

```
Generate LocalBusiness schema for [business name and details]
```

### Audit Existing Schema

```
Review and improve this schema markup: [existing schema]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~web crawler connected:**
Automatically crawl and extract page content (visible text, headings, lists, tables), existing schema markup, page metadata, and structured content elements that map to schema properties.

**With manual data only:**
Ask the user to provide:
1. Page URL or full HTML content
2. Page type (article, product, FAQ, how-to, local business, etc.)
3. Specific data needed for schema (prices, dates, author info, Q&A pairs, etc.)
4. Current schema markup (if optimizing existing)

Proceed with the full workflow using provided data. Note in the output which data is from automated extraction vs. user-provided data.

## Instructions

When a user requests schema markup:

1. **Identify Content Type and Select ONE Primary Schema Type**

   Reference the [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md) item **O05 (Schema Markup)** — its Pass criterion is *correct JSON-LD matching the content type*: one accurate primary type per page. The mapping below applies the settled ruling R2 boundary (`docs/loop/SETTLED-RULINGS.md`) to the O05 content-type list; the benchmark's own Section 5 table predates the R2 boundary clarification — where they differ, R2 governs:

   ```markdown
   ### CORE-EEAT Schema Mapping (O05, single-primary form)

   | Content Type | Primary Type (pick ONE) | Documented Auxiliaries (only if page data warrants) |
   |-------------|-------------------------|-----------------------------------------------------|
   | Blog (guides/tools/insights) | Article / BlogPosting | BreadcrumbList (real trail); author + publisher nested inside the Article |
   | Alternative (X vs Y) | Article (comparison editorial) | BreadcrumbList |
   | Best-of / list | ItemList | BreadcrumbList |
   | Use-case | WebPage | BreadcrumbList |
   | FAQ | FAQPage | BreadcrumbList |
   | Landing (software) | SoftwareApplication | BreadcrumbList |
   | Testimonial | Review | BreadcrumbList; reviewed item + reviewer nested inside the Review |
   | Homepage | Organization (or WebSite) | — |

   *ONE primary type satisfies O05. Auxiliaries are extras with their own documented job — never a way to "add more types".*
   ```

   ```markdown
   ### Schema Analysis

   **Content Type**: [blog/product/FAQ/how-to/local business/etc.]
   **Page URL**: [URL]

   **Eligible Rich Results**:
   
   | Rich Result Type | Eligibility | Impact |
   |------------------|-------------|--------|
   | FAQ | ❌ (retired 2026) | AI-engine/GEO parsing only — no SERP result |
   | How-To | ✅/❌ | Medium - Shows steps in SERP |
   | Product | ✅/❌ | High - Shows price, availability |
   | Review | ✅/❌ | High - Shows star ratings |
   | Article | ✅/❌ | Medium - Shows publish date, author |
   | Breadcrumb | ✅/❌ | Medium - Shows navigation path |
   | Video | ✅/❌ | High - Shows video thumbnail |
   
   **Recommended Schema**:
   - **Primary type (ONE per page)**: [type] — [why it matches the content]
   - **Auxiliaries (only if page data warrants)**: [e.g., BreadcrumbList — real trail provided | none]
   ```

2. **Generate Schema Markup**

   Generate JSON-LD for the ONE primary type selected in step 1. Supported types: FAQPage, HowTo, Article/BlogPosting/NewsArticle, Product, LocalBusiness, Organization, BreadcrumbList, Event, Recipe, SoftwareApplication.

   > **Reference**: See [references/schema-templates.md](./references/schema-templates.md) for complete, copy-ready JSON-LD templates for all schema types with required and optional properties.

   **One primary type per page (settled ruling R2).** Default output is a single JSON-LD object. Supporting entities belong NESTED inside it as properties (`offers`, `author`, `publisher`, `organizer`, `provider`, `location`) — not as separate top-level objects.

   - **Legitimate auxiliaries** — a second top-level object is justified only when it has its own engine-documented, non-citation job AND the page data warrants it: BreadcrumbList for a real breadcrumb trail (Google-documented site-structure feature); Organization/Person as publisher/author identity (normally nested — top-level only on the entity's own page); WebSite on the homepage.
   - **Banned — citation-lever stacking**: adding schema types on the theory that more types raise AI-citation odds. No engine documents a citation gain from extra types; stacking only adds maintenance surface and content-mismatch (spam-policy) risk. A second full content type on one page (e.g., FAQPage bolted onto a service page, Article + Product both as primaries) IS stacking — banned unless the page genuinely is both things and each type is complete, accurate, and independently justified.
   - When the user asks "type X or type Y — or both?", pick the one type the page IS and nest the other entity inside it (e.g., an Event with the organizer nested — not Event + Organization side by side).

   For each schema generated, include:
   - All required properties for the chosen type
   - Rich result preview where the type still has one (FAQ: none — state the AI-engine/GEO parsing value instead)
   - Notes on which properties are required vs. optional

   When a documented auxiliary legitimately accompanies the primary (e.g., BreadcrumbList), wrap the objects in a JSON array inside a single `<script type="application/ld+json">` tag — only then.

3. **Provide Implementation and Validation**

    ```markdown
    ## Implementation Guide

    ### Adding Schema to Your Page

    **Option 1: In HTML <head>**
    ```html
    <head>
      <script type="application/ld+json">
        [Your JSON-LD schema here]
      </script>
    </head>
    ```

    **Option 2: Before closing </body>**
    ```html
      <script type="application/ld+json">
        [Your JSON-LD schema here]
      </script>
    </body>
    ```

    ### Validation Steps

    1. **~~schema validator**
       - Test your live URL or paste code
       - Check for errors and warnings

    2. **Schema.org Validator**
       - URL: https://validator.schema.org/
       - Validates against Schema.org spec

    3. **~~search console**
       - Monitor rich results in ~~search console
       - Check Enhancements reports for issues
       - FAQ exception: Google retired FAQ rich results in 2026 — reporting, API, appearance filter, and Rich Results Test support all cut. FAQPage still generates; value is AI-engine/GEO parsing, not SERP monitoring.

    ### Validation Checklist

    - [ ] JSON syntax is valid (no trailing commas)
    - [ ] All required properties present
    - [ ] URLs are absolute, not relative
    - [ ] Dates are in ISO 8601 format
    - [ ] Content matches visible page content
    - [ ] No policy violations
    ```

## Validation Checkpoints

### Input Validation
- [ ] Page URL or content provided
- [ ] Schema type appropriate for content (Article for blog, Product for e-commerce, etc.)
- [ ] All required data available (author, dates, prices, etc. depending on schema type)
- [ ] Rich-result expectations honest for the type (FAQ has none — retired 2026)

### Output Validation
- [ ] Exactly ONE primary type emitted; any auxiliary has a documented job and real page data behind it (R2)
- [ ] JSON syntax validates (no trailing commas, proper quotes)
- [ ] All required properties present for chosen schema type
- [ ] URLs are absolute, not relative
- [ ] Dates in ISO 8601 format (YYYY-MM-DDTHH:MM:SS+00:00)
- [ ] Schema content matches visible page content exactly
- [ ] Passes ~~schema validator with no errors
- [ ] Source of each data point clearly stated (~~web crawler extraction, user-provided, or manual entry)

## Example

**User**: "Generate FAQ schema for a page about SEO with 3 questions"

**Output**:

```markdown
## FAQ Schema for SEO Page

### Schema Markup

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "What is SEO?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "SEO (Search Engine Optimization) is the practice of optimizing websites and content to rank higher in search engine results pages (SERPs). It involves technical optimizations, content creation, and link building to increase organic visibility and drive qualified traffic to your website."
      }
    },
    {
      "@type": "Question",
      "name": "How long does SEO take to work?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "SEO typically takes 3-6 months to show significant results, though this varies based on competition, domain authority, and effort invested. New websites may take 6-12 months, while established sites with existing authority can see improvements in 1-3 months for less competitive keywords."
      }
    },
    {
      "@type": "Question",
      "name": "Is SEO better than paid advertising?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "SEO and paid advertising serve different purposes. SEO provides sustainable, long-term traffic without per-click costs but takes time to build. Paid advertising delivers immediate results but stops when you stop paying. Most successful businesses use both: paid ads for immediate leads and SEO for long-term growth."
      }
    }
  ]
}
```

_Implementation: Wrap the above JSON-LD in `<script type="application/ld+json">...</script>` and place in `<head>` or before `</body>`. Validate syntax with Schema.org Validator — Google's Rich Results Test dropped FAQ support in 2026._

### SERP Status

FAQ rich results are retired — Google pulled Search Console reporting/API, the Enhancements appearance filter, and Rich Results Test support for FAQ in 2026. This markup no longer produces a SERP accordion. Still generated for AI-engine/GEO parsing: answer engines can extract clean Q&A pairs from it regardless.
```

## Schema Type Quick Reference

| Content Type | Schema Type | Key Properties |
|--------------|-------------|----------------|
| Blog Post | BlogPosting/Article | headline, datePublished, author |
| Product | Product | name, price, availability |
| FAQ | FAQPage | Question, Answer |
| How-To | HowTo | step, totalTime |
| Local Business | LocalBusiness | address, geo, openingHours |
| Recipe | Recipe | ingredients, cookTime |
| Event | Event | startDate, location |
| Video | VideoObject | uploadDate, duration |
| Course | Course | provider, name |
| Review | Review | itemReviewed, ratingValue |

## Tips for Success

1. **One primary type per page** - Nest supporting entities; auxiliaries only with a documented job (R2)
2. **Match visible content** - Schema must reflect what users see
3. **Don't spam** - Only add schema for relevant content; more types is not more citations
4. **Keep updated** - Update dates and prices when they change
5. **Test thoroughly** - Validate before deploying
6. **Monitor Search Console** - Watch for errors and warnings (non-FAQ types — FAQ reporting was cut in 2026)

## Schema Type Decision Tree

> **Reference**: See [references/schema-decision-tree.md](./references/schema-decision-tree.md) for primary-type selection by content, the nested-vs-auxiliary boundary (R2), industry starting points, implementation priority tiers (P0-P4), and validation quick reference.

## Reference Materials

- [Schema Templates](./references/schema-templates.md) - Copy-ready JSON-LD templates for all schema types, plus the primary + auxiliary array form
- [Schema Decision Tree](./references/schema-decision-tree.md) - Primary-type selection, nested-vs-auxiliary boundary, industry starting points, priority tiers (P0-P4)
- [Validation Guide](./references/validation-guide.md) - Common errors, required properties, testing workflow (FAQPage: Schema.org validator only)

## Related Skills

- [seo-content-writer](../seo-content-writer/) — Create content worth marking up
- [on-page-seo-auditor](../../optimize/on-page-seo-auditor/) — Audit existing schema
- [technical-seo-checker](../../optimize/technical-seo-checker/) — Technical validation
- [entity-optimizer](../../cross-cutting/entity-optimizer/) — Entity audit informs Organization, Person, Product schema

