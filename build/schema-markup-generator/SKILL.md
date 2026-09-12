---
name: schema-markup-generator
version: "4.3.3"
description: 'Generate Schema.org JSON-LD structured data — one accurate primary type per page (FAQPage, HowTo, Article, Product, LocalBusiness, and 6 other types) plus documented auxiliaries only where warranted. Use when the user asks to "add schema markup", "generate structured data", "JSON-LD", "FAQ schema", "rich snippets", "I want star ratings in Google", or "structured data validation errors". Produces validated markup for Google rich results where still offered (no FAQ rich result for ordinary sites — government/health only, Aug 2023 — FAQPage is kept because it stays valid and Google says there is no need to proactively remove it), Bing structured data, and machine-readable input for any consumer that reads it. Validates via the Schema.org validator, plus Rich Results Test for non-FAQ types. For broader technical SEO, see technical-seo-checker. For meta tag optimization, see meta-tags-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
allowed-tools: WebFetch
metadata:
  author: aaron-he-zhu
  version: "4.3.3"
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

- Adding FAQ schema where FAQPage is the page's one primary type — valid markup, kept because it costs nothing and Google's guidance is that you *can* drop it but there is no need to proactively remove it (ruling R3 + 9a — a permission, never reported to a client as a Google recommendation); not claimed as a citation lever
- Creating How-To schema for step-by-step content
- Adding Product schema for e-commerce pages
- Implementing Article schema for blog posts
- Adding Local Business schema for location pages
- Creating Review/Rating schema
- Implementing Organization schema for brand presence
- Any page where a non-FAQ rich result is available, or where stating the page's type and entities unambiguously is worth doing on its own

## What This Skill Does

1. **Schema Type Selection**: Recommends the ONE primary type that matches the page
2. **JSON-LD Generation**: Creates valid structured data markup
3. **Property Mapping**: Maps your content to schema properties
4. **Validation Guidance**: Ensures schema meets requirements
5. **Nested Entities**: Nests supporting entities (Offer, author, publisher, organizer, provider) inside the primary type instead of emitting extra top-level objects
6. **Rich Result Eligibility**: Flags which rich results still exist for the chosen type (no FAQ rich result for ordinary sites — Aug 2023)

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

**With manual data only — generate first, ask second.**
Whatever the user supplied on turn one (pasted copy, an attached file, a URL, existing JSON-LD) is the input: produce the markup that data supports, then name what is missing under the **Missing data** rule in step 2. Opening with a checklist against data already in front of you is a stall. A question is the right first move only when the page's subject is genuinely unknown — no content, no URL, no type.

What the workflow needs, in priority order:
1. Page URL or full HTML content
2. Page type (article, product, FAQ, how-to, local business, etc.)
3. Specific data needed for schema (prices, dates, author info, Q&A pairs, etc.)
4. Current schema markup (if optimizing existing)

**When to fetch** (WebFetch — declared in this skill's `allowed-tools`): fetch when the user gives a URL and no page copy, because the content-match rule can only be checked against text actually read. Do not fetch when the copy is supplied, and do not fetch a URL that is merely where the markup will be installed. If the fetch fails, is blocked, or returns something that is not the page, say so and ask for pasted copy or HTML — never generate schema from an assumption about what the page says.

Note in the output which data is from automated extraction, from a fetch, or user-provided.

## Instructions

When a user requests schema markup:

1. **Identify Content Type and Select ONE Primary Schema Type**

   Reference the [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md) item **O05 (Schema Markup)** — its Pass criterion is *correct JSON-LD matching the content type*: one accurate primary type per page. The benchmark's Section 5 table and settled ruling R2 (`docs/loop/SETTLED-RULINGS.md`) state one boundary, not two, so a page mapped here maps the same way there. The table below is that boundary on this skill's supported types, plus the homepage row Section 5 does not carry:

   ```markdown
   <!-- OPERATOR BLOCK — a lookup table you read to pick the primary type. It is NOT emitted:
        nothing here goes into the deliverable, and the framework item ID below is a run handle
        that must not reach the client. The emitted block is the next fence down. -->
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
   <!-- SKELETON — every [bracket] is a slot filled from the page you were given; a slot with
        no value means the line is dropped and the gap named in prose. Delete this comment
        when the block is filled. -->
   ### Schema Analysis

   **Content Type**: [blog/product/FAQ/how-to/local business/etc.]
   **Page URL**: [URL]

   **Eligible Rich Results**:
   
   | Rich Result Type | Eligibility | Impact |
   |------------------|-------------|--------|
   | FAQ | ❌ (none for an ordinary site — government/health only since Aug 2023) | No SERP result. Valid markup, and no citation benefit is claimed either way — nothing establishes one |
   | How-To | ❌ (not a Google-documented feature — absent from the structured-data gallery, checked 2026-08-18) | No SERP result. HowTo still generated for genuinely step-by-step content on schema.org validity alone |
   | Product | ✅/❌ | High - Shows price, availability |
   | Review | ✅/❌ | High - Shows star ratings |
   | Article | ✅/❌ | Medium - Shows publish date, author |
   | LocalBusiness | Supports the business entity | Corroborates name, address, phone and hours; placement is not promised from page markup |
   | Event | ✅/❌ | Medium - Shows date, venue, ticket price |
   | Breadcrumb | ✅/❌ | Medium - Shows navigation path |
   | Video | ✅/❌ | High - Shows video thumbnail |

   **Recommended Schema**:
   - **Primary type (ONE per page)**: [type] — [why it matches the content]
   - **Auxiliaries (only if page data warrants)**: [e.g., BreadcrumbList — real trail provided | none]
   ```

   Keep only the rows that bear on this page and add a row for any other type you emit — LocalBusiness and Event are as common here as Article. Every row reports an *eligibility*, never an appearance: Google decides per query whether to show anything. The two rows below are worded the way they are for reasons that stay in this file; `[VERIFY]` is an in-repo tag and never appears in a deliverable.

   - **How-To rich results — settled on the gallery, not on the 2023 post.** HowTo is absent from Google's current structured-data gallery ("Structured data markup that Google Search supports", `developers.google.com/search/docs/appearance/structured-data/search-gallery`, read 2026-08-18), so there is no How-to SERP appearance to promise. The older account of *how* it ended — desktop-only, then dropped "as of September 13", per the 2023-08-08 Search Central post — remains **not owner-read** and is not repeated to clients. Behaviour is unchanged: still generate HowTo for genuinely step-by-step pages, on schema.org validity alone, and promise no appearance.
   - `[VERIFY]` **LocalBusiness SERP effect** — unsettled here. Local-pack placement is widely attributed to the business's Google Business Profile rather than to page JSON-LD, and no Google-primary source is on file that either supports or refutes the "Local pack, knowledge panel" line this library has carried (searched 2026-08-10, none found). Asserting the opposite would be the same unsourced move in reverse. Say what the markup demonstrably does — corroborates NAP and hours for entity understanding — and promise no placement.

2. **Generate Schema Markup**

   Generate JSON-LD for the ONE primary type selected in step 1. Supported types: FAQPage, HowTo, Article/BlogPosting/NewsArticle, Product, LocalBusiness, Organization, BreadcrumbList, Event, Recipe, SoftwareApplication.

   > **Reference**: See [references/schema-templates.md](./references/schema-templates.md) for JSON-LD skeletons of every supported type, with required and optional properties marked. They are skeletons, not deliverables: every `[SLOT]` is filled from the page's own data or the property is dropped.

   **One primary type per page (settled ruling R2).** Default output is a single JSON-LD object. Supporting entities belong NESTED inside it as properties (`offers`, `author`, `publisher`, `organizer`, `provider`, `location`) — not as separate top-level objects.

   - **Legitimate auxiliaries** — a second top-level object is justified only when it has its own engine-documented, non-citation job AND the page data warrants it: BreadcrumbList for a real breadcrumb trail (Google-documented site-structure feature); Organization/Person as publisher/author identity (normally nested — top-level only on the entity's own page); WebSite on the homepage.
   - **Banned — citation-lever stacking**: adding schema types on the theory that more types raise AI-citation odds. No engine documents a citation gain from extra types; stacking only adds maintenance surface and content-mismatch (spam-policy) risk. A second full content type on one page (e.g., FAQPage bolted onto a service page, Article + Product both as primaries) IS stacking — banned unless the page genuinely is both things and each type is complete, accurate, and independently justified.
   - When the user asks "type X or type Y — or both?", pick the one type the page IS and nest the other entity inside it (e.g., an Event with the organizer nested — not Event + Organization side by side).

   For each schema generated, include:
   - All required properties for the chosen type
   - A **rich-result eligibility note** — three sentences in a fixed shape, never a SERP mock-up: which rich result the type is eligible for (FAQ: none for an ordinary site — government/health only since Aug 2023 — say the markup is valid and kept, and do not substitute a citation-benefit claim, which R3 amendment 9a records as unsourced either way); which of the emitted properties feed it; and the standing caveat that eligibility is not an appearance, because Google decides per query and per device. Shape, worked examples and the no-mock-up reasoning: [validation-guide.md → Rich-result eligibility note](./references/validation-guide.md#rich-result-eligibility-note). Do not draw a mock SERP listing: a picture of the result reads as a promise of the result, which this skill does not make.
   - Notes on which properties are required vs. optional

   **Missing data — the value rule.** The JSON-LD you hand over is paste-ready, so every value inside it is a real value taken from the page or from what the user supplied. When a required or recommended property has no value available:

   1. **Omit the property and name the gap in prose** — preferred, and what a finished deliverable does. Name the property, say what leaving it out costs, and state exactly what to send back: "`publisher.logo` is missing — send the absolute URL of a logo no wider than 600px and it becomes one more line in the block." An illustrative URL belongs in that prose; it never goes inside the emitted block.
   2. **Or emit a labelled skeleton** — permitted **only** when the user asked for a fill-in template, and then the block is a skeleton and says so **inside its own fence**: `"_SKELETON": "…"` as the JSON object's **first member**, because a model copies the fence and not the sentence above it (root `CLAUDE.md`, the Value Rule). Slots are `[LATITUDE]`, `[PRICE-RANGE]`, `[IMAGE-URL]`, `[PUBLISHER-LOGO-URL]` — SCREAMING-KEBAB inside square brackets, never any other stand-in shape. **A skeleton is never introduced with paste-ready framing**, and a paste-ready block never carries a slot: those are the two halves of one rule, and mixing them is what the Output Validation checkbox below catches.
   3. **Never invent a value, and never use an unbracketed stand-in** — no plausible-looking coordinates, no `TBD`/`XX`, no `your-logo.png` or `your latitude here`, no note shaped like a value. An invented value is a content-mismatch (spam-policy) risk; an unbracketed stand-in hides the gap from the one person who could close it.

   Same rule one skill over: meta-tags-optimizer applies it to `content=` attributes and `<title>` (ledger F13). Paste-ready values are resolved values, brackets belong only in a labelled skeleton, and the remedy for missing data is drop-it-and-name-the-gap in both.

   When a documented auxiliary legitimately accompanies the primary (e.g., BreadcrumbList), wrap the objects in a JSON array inside a single `<script type="application/ld+json">` tag — only then.

3. **Provide Implementation and Validation**

    ````markdown
    ## Implementation Guide

    ### Adding Schema to Your Page

    **Option 1: In HTML <head>**
    ```html
    <!-- SKELETON — placement only, not paste-ready. [JSON-LD-BLOCK] is a slot: paste the
         finished block from above in its place and delete this comment. A page that ships
         with the bracket still in it ships no schema at all. -->
    <head>
      <script type="application/ld+json">
        [JSON-LD-BLOCK]
      </script>
    </head>
    ```

    **Option 2: Before closing </body>**
    ```html
    <!-- SKELETON — placement only, not paste-ready. Same slot, same rule as Option 1. -->
      <script type="application/ld+json">
        [JSON-LD-BLOCK]
      </script>
    </body>
    ```

    ### Validation Steps

    1. **Rich Results Test**
       - Test your live URL or paste code
       - Check for errors and warnings

    2. **Schema.org Validator**
       - URL: https://validator.schema.org/
       - Validates against Schema.org spec

    3. **Search Console**
       - Monitor rich results in Search Console
       - Check Enhancements reports for issues
       - FAQ exception: **sourced** — Google restricted FAQ rich results to well-known government and health websites on 2023-08-08, and has since ended the feature outright: it stopped appearing in Google Search on 2026-05-07, and the documentation was removed in June 2026. Both dates read on Google's own changelog (`developers.google.com/search/updates`, the May 8 and June 15 2026 entries; re-read 2026-08-18), and FAQ is absent from the current structured-data gallery. So an ordinary site gets no FAQ rich result and there is nothing to monitor. **Reported, not owner-read** — Google's staged-retirement note ("We will be dropping the FAQ search appearance, rich result report, and support in the Rich results test in June 2026. To allow time for adjusting your API calls, support for the FAQ rich result in the Search Console API will be removed in August 2026.") is quoted identically by two independent outlets citing `developers.google.com/search/docs/appearance/structured-data/faqpage`, a page Google has since removed — quote it as reported, never as read. FAQPage still generates: basis is schema.org validity, not a citation benefit — no primary source establishes one either way.

    ### Validation Checklist

    - [ ] JSON syntax is valid (no trailing commas)
    - [ ] All required properties present
    - [ ] URLs are absolute, not relative
    - [ ] Dates are ISO 8601 at the precision the page states
    - [ ] Content matches visible page content — the same fact, in the notation each property requires
    - [ ] No policy violations
    ````

## Recommended Actions — the Seven Fields

The JSON-LD is the artefact; the prose around it is where somebody is told to install it, supply what is missing, and fix what does not match. **Every one of those recommendations carries seven fields**: **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**. It covers installing the block at a named URL, each property dropped for want of a value under step 2's missing-data rule, each content mismatch found, and each stacked second type to remove.

**The fields live in the report, never inside the block.** A paste-ready JSON-LD object carries resolved values only, so an owner or a due date as a member of it is the same failure as an invented value. What *does* ride inside a fence is only the condition on that fence's own safe use — the `SKELETON` marker, the "delete this comment when filled" line — because the block is copied out and the report stays behind.

Fields 1-3 are **required**: no action ships without an owner-role and an acceptance criterion. Fields 4-7 take a stated-absence value where no answer exists (`not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect`), never a blank and never an invention. **Owner is a role**, not a person unless the client supplied the name: `Content` · `SEO/technical` · `Developer` · `Designer` · `Product/merchandising` · `Customer service` · `Legal/compliance` · `Agency` · `Client decision`. Installing a block is usually `Developer` (it is a template or CMS edit); supplying a missing `publisher.logo` or a price is usually `Content` or `Product/merchandising`; whether a page should carry a commercial type at all is a `Client decision`. `unassigned — needs an owner` is legitimate and is itself a finding.

**The acceptance criterion here is about as checkable as they get, and that is the standard**: the block is live in the page source at the named URL, the Schema.org validator returns zero errors for it, every property in it corresponds to content visible on that page, and all three were checked on a stated date. The test is whether someone who was not part of this engagement could confirm that six weeks from now without asking what was meant — so not "fix the schema".

**A criterion never requires an engine to do something.** A rich result appearing, a knowledge panel, a local-pack placement or a citation is nobody's to deliver — Google decides per query and per device, which is exactly why this skill's eligibility note promises no appearance and draws no mock SERP. Writing an appearance as an acceptance criterion re-introduces, as a test, the promise the note refuses to make.

**Ordering, stated once**: expected impact ÷ effort with dependencies respected, *inside* the existing P0-P4 implementation priority tiers, which stay this skill's only priority vocabulary. A block that waits on a value the client has not sent sorts below the request for that value.

```markdown
<!-- SKELETON — the implementation action table, which sits in the report beside the JSON-LD and
     never inside it. Every [slot] is filled from this run; fields 4-7 take their stated-absence
     value where no answer exists. Delete this comment when the table is filled. -->
| Tier | Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
|------|--------|-------|----------------------|-----------------|--------|--------------|--------------------|
| [P0-P4] | [one imperative sentence naming the page and the change] | [role] | [block live in source at the named URL · validator returns zero errors · every property matches visible content · checked when] | [what the markup demonstrably does, or `not estimated — no baseline data`] | [S/M/L, or `not estimated`] | [named, or `none`] | [failure mode and cost — a content mismatch is a spam-policy risk, not a cosmetic one] |
```

Field definitions, stated-absence values, the closed role list, worked criteria and the three permitted shapes of expected impact: [Action Output Contract](../../references/action-output-contract.md).

## Validation Checkpoints

### Input Validation
- [ ] Page URL or content provided
- [ ] Schema type appropriate for content (Article for blog, Product for e-commerce, etc.)
- [ ] All required data available (author, dates, prices, etc. depending on schema type)
- [ ] Rich-result expectations honest for the type (FAQ has none for an ordinary site — government/health only since Aug 2023)

### Output Validation
- [ ] Exactly ONE primary type emitted; any auxiliary has a documented job and real page data behind it (R2)
- [ ] JSON syntax validates (no trailing commas, proper quotes)
- [ ] All required properties present for chosen schema type
- [ ] URLs are absolute, not relative
- [ ] Dates in ISO 8601 **at the precision the page states** — date-only `2025-03-12` when the page shows no time (reduced precision is valid ISO 8601 and correct here); `2025-03-12T09:00:00+02:00` only when the page states a time, and a zone offset only when the page or the client supplies one. Never invent a time, a zone, or a day to reach a longer form
- [ ] **In paste-ready JSON-LD** — the default, and anything not explicitly labelled a skeleton — no unfilled slot survives: no `[BRACKET]` token, no `_SKELETON` marker, no `TBD`/`XX`, no invented value. A value that cannot be sourced means the property is **dropped** and the gap is named in prose (missing-data rule, step 2). **In a skeleton the user asked for**, brackets are the correct notation and `"_SKELETON"` must be the object's first member — the marker is what makes the block a skeleton, so banning it there would leave an unlabelled block full of brackets, which is the worse of the two failures. *(Scoped 2026-08-13: this read "no unfilled slot survives in the emitted JSON-LD" flat, which contradicted step 2's own fill-in-template route — the skill banned what it prescribed one screen earlier.)*
- [ ] Schema content matches visible page content exactly — **the same fact, not necessarily the same spelling**. Properties with a documented notation are written in it even where the page prints another form: `addressCountry` as an ISO 3166-1 alpha-2 code, `offers.priceCurrency` as an ISO 4217 code, dates as ISO 8601, `telephone` in international dialling format with the country code (`+30 2310 555 000`). Re-notating a fact the page states is not a mismatch; adding a fact it does not state is, so where the page does not establish what the notation needs, the property is dropped and the gap named ([validation-guide.md → Required vs Recommended Properties](./references/validation-guide.md#required-vs-recommended-properties))
- [ ] Passes ~~schema validator with no errors
- [ ] Source of each data point stated in the deliverable's own words — the resolved tool name (a Screaming Frog extraction), "user-provided", or "manual entry"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Greek prose carries its mechanics: final sigma and τόνοι correct in the deliverable's OWN new Greek — the report prose, implementation notes and price-display explanation (ALL-CAPS unaccented, no transliteration into Latin script, no Latin homoglyph inside a Greek word) — while values carried over from the fixture or the page stay character-for-character verbatim, defects included: a product name, brand name or description reproduced from source is a fidelity obligation, not a string to correct. Spec-notated values stay in their own notation rather than the prose's, and anti-slop-ruleset.md §6 **families 1 and 2** are screened alongside family 7 — [Greek Output Mechanics](../../references/greek-output-mechanics.md)
- [ ] Every recommendation carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist; none ships without an owner-role and an acceptance criterion, the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding), and every field sits in the report rather than as a member of the emitted JSON-LD
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — block live in source at the named URL, validator returns zero errors, every property matches visible content, all checked on a stated date. **None requires an engine to do something**: a rich result, a knowledge panel, a local-pack placement or a citation is never the criterion. Ordering is expected impact ÷ effort with dependencies respected, stated once, inside the P0-P4 tiers rather than a second priority vocabulary

## Example

**User**: "Generate FAQ schema for a page about SEO with 3 questions"

**Primary-type check first (step 1)**: the page here is a dedicated Q&A page, so FAQPage is the one type it needs. Had the same three questions sat in the FAQ section of an SEO guide, the primary type would be Article, FAQPage on top of it would be stacking (settled ruling R2), and the visible Q&A block would carry the value — it earns CORE-EEAT C09 with no markup at all.

**Output**:

````markdown
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

_Implementation: Wrap the above JSON-LD in `<script type="application/ld+json">...</script>` and place in `<head>` or before `</body>`. Validate syntax with Schema.org Validator — Google's Rich Results Test does not support FAQPage._

### Rich-Result Eligibility

**Eligible for**: nothing in Google Search for an ordinary site. Google restricted FAQ rich results to well-known, authoritative government and health websites on 2023-08-08; for every other site the rich result "will no longer be shown regularly" (Google's words). So this markup produces no SERP accordion here. **What the emitted properties do**: state each question and its answer in a machine-readable form alongside the visible text. **What they do not do**: earn a citation anywhere — no primary source establishes that in either direction, so promise nothing (settled ruling R3 + amendment 9a). The markup ships because it is valid, costs nothing, and Google says there is no need to proactively remove it — not because it is a lever.
````

## Schema Type Quick Reference

Content type → primary type, what nests inside each, the SERP note per type, and the two or three key properties that identify it: [references/schema-decision-tree.md](./references/schema-decision-tree.md) → Primary Type by Content, and Key Properties at a Glance.

## Tips for Success

1. **One primary type per page** - Nest supporting entities; auxiliaries only with a documented job (R2)
2. **Match visible content** - Schema must reflect what users see
3. **Don't spam** - Only add schema for relevant content; more types is not more citations
4. **Keep updated** - Update dates and prices when they change
5. **Test thoroughly** - Validate before deploying
6. **Monitor Search Console** - Watch for errors and warnings (non-FAQ types — an ordinary site has no FAQ rich result to report on since the 2023-08-08 restriction)

## Reference Materials

- [Schema Templates](./references/schema-templates.md) - JSON-LD skeletons for every supported type (fill each `[SLOT]` or drop the property), plus the primary + auxiliary array form
- [Schema Decision Tree](./references/schema-decision-tree.md) - Primary-type selection by content, key properties at a glance, the nested-vs-auxiliary boundary (R2), industry starting points, implementation priority tiers (P0-P4), validation quick reference
- [Action Output Contract](../../references/action-output-contract.md) - Library-wide: the seven fields every implementation action carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule
- [Validation Guide](./references/validation-guide.md) - Common errors, required properties, the rich-result eligibility note (FAQ: none for an ordinary site — government/health only since Aug 2023), testing workflow (FAQPage: Schema.org validator only)

## Related Skills

- [seo-content-writer](../seo-content-writer/) — Create content worth marking up
- [on-page-seo-auditor](../../optimize/on-page-seo-auditor/) — Audit existing schema
- [technical-seo-checker](../../optimize/technical-seo-checker/) — Technical validation
- [entity-optimizer](../../cross-cutting/entity-optimizer/) — Entity audit informs Organization, Person, Product schema

