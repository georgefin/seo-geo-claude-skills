# Schema Markup Validation Guide

Complete reference for validating, testing, and troubleshooting structured data.

**The value rule (applies to every example in this file and to anything generated from it)**: a JSON-LD block handed to a user carries resolved values only. A property whose value cannot be sourced from the page is dropped from the block and named in the report prose — never filled with an invented value or an unbracketed stand-in. Bracket tokens (`[PUBLISHER-LOGO-URL]`) belong only in a block explicitly labelled a skeleton. Full rule: SKILL.md step 2, *Missing data — the value rule*.

**Date precision**: ISO 8601 includes reduced-precision forms. Match the precision the page states — `2025-03-12` when the page shows a date and no time, `2025-03-12T09:00:00+02:00` when it states a time. Inventing a time (or a zone) to reach the longer form manufactures data the page does not carry, which is the content-match policy's own failure mode.

**Time and zone forms**: where the page states a time, three writings are equally valid ISO 8601 and mean the page's own clock time — the bare local form `2026-09-19T10:00` (seconds optional) when no zone is known, the same instant with a UTC offset `2026-09-19T10:00:00+01:00`, and the equivalent UTC instant with the Z designator `2026-09-19T09:00:00Z`. Prefer whichever the source actually supports; never derive an offset by guessing the venue's zone.

## Validation Tools

### Google Rich Results Test
- **URL**: https://search.google.com/test/rich-results
- **Purpose**: Check if your schema is eligible for Google rich results
- **Tests**: Live URL or code snippet
- **Output**: Errors, warnings, eligible rich result types
- **FAQ exception**: this tool does not test FAQPage — validate FAQPage with the Schema.org Validator instead. *(The library dates that cut to 2026; that date is unverified, the 2023-08-08 eligibility restriction is not. Either way the tool is not the route for FAQPage.)*

### Schema.org Validator
- **URL**: https://validator.schema.org/
- **Purpose**: Validate against official Schema.org specification
- **Tests**: URL, code snippet, or microdata
- **Output**: Technical validation errors
- **Note**: The primary (and only) validator this library uses for FAQPage

### Google Search Console
- **Location**: Search Console → Enhancements section
- **Purpose**: Monitor rich results performance and errors at scale
- **Reports**: Rich results status, coverage, issues over time
- **FAQ exception**: an ordinary site has no FAQ rich result to monitor — Google restricted them to well-known government and health websites on 2023-08-08. *(This library also carried a set of 2026 dates for reporting, the appearance filter and an August 2026 API cut. Those are **unverified**: the two URLs ruling R3 cites do not contain them. Do not state them — see `docs/loop/r3-decision-brief.md`.)*

---

## Common JSON-LD Syntax Errors

### Trailing Commas

**Error**: Invalid JSON syntax
```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Title",  ← Trailing comma here
}
```

**Fix**: Remove the comma after the last property
```json
{
  "@context": "https://schema.org",
  "@type": "Article",
  "headline": "Title"
}
```

### Missing Required Quotes

**Error**: Property names must be quoted
```json
{
  @context: "https://schema.org"
}
```

**Fix**: Quote all property names
```json
{
  "@context": "https://schema.org"
}
```

### Incorrect Date Format

**Error**: Invalid date format
```json
{
  "datePublished": "01/15/2024"
}
```

**Fix**: Use ISO 8601 at the precision the source states. The page above shows a date and no time, so the date-only form is the correct fix — reduced precision is valid ISO 8601:
```json
{
  "datePublished": "2024-01-15"
}
```

Add time and offset only when the page (or the CMS) actually states them — `"datePublished": "2024-01-15T08:00:00+00:00"`. A time invented to fill out the longer form is fabricated data.

### Relative URLs Instead of Absolute

**Error**: Relative URLs are not allowed
```json
{
  "image": "/images/photo.jpg"
}
```

**Fix**: Use absolute URLs
```json
{
  "image": "https://example.com/images/photo.jpg"
}
```

### Incorrect Array Syntax

**Error**: Multiple values not in array
```json
{
  "image": "url1.jpg", "url2.jpg"
}
```

**Fix**: Use array brackets for multiple values
```json
{
  "image": ["url1.jpg", "url2.jpg"]
}
```

---

## Required vs Recommended Properties

### FAQPage Schema

| Property | Status | Notes |
|----------|--------|-------|
| @type | Required | Must be "FAQPage" |
| mainEntity | Required | Array of Question objects — one per visible Q&A pair |
| Question.name | Required | The question text |
| Answer.text | Required | The answer text |

**Status note**: FAQPage produces no Google rich result (none for an ordinary site — government/health only since Aug 2023). It is still generated because it is valid, cheap to keep, and Google's own guidance is that you *can* drop it but there is no need to proactively remove it (settled ruling R3 + amendment 9a — which also records that no primary source establishes a citation benefit either way). That is a permission to leave existing markup alone, not advice to keep it; do not report it to a client as a Google recommendation. It validates against Schema.org semantics only.

### HowTo Schema

| Property | Status | Notes |
|----------|--------|-------|
| @type | Required | Must be "HowTo" |
| name | Required | Title of the how-to |
| step | Required | Array of HowToStep objects |
| step.text | Required | Step instructions |
| image | Recommended | Improves visibility |
| totalTime | Recommended | Shows duration in results |
| supply | Recommended | Lists materials needed |
| tool | Recommended | Lists tools needed |

**Minimum**: 2 steps with text

### Article Schema

| Property | Status | Notes |
|----------|--------|-------|
| @type | Required | Article/BlogPosting/NewsArticle |
| headline | Required | Max 110 characters |
| image | Required | Minimum 1200px wide |
| datePublished | Required | ISO 8601 at the page's own precision — date-only when no time is shown |
| author | Required | Person or Organization |
| publisher | Required | Organization with logo |
| publisher.logo | Required | Max 600px wide, 60px high |
| dateModified | Recommended | Update when content changes |
| description | Recommended | Improves display |

### Product Schema

| Property | Status | Notes |
|----------|--------|-------|
| @type | Required | Must be "Product" |
| name | Required | Product name |
| image | Required | Product images |
| description | Recommended | Product description |
| offers | Recommended | Required for price display |
| offers.price | Recommended | Required for price display |
| offers.priceCurrency | Recommended | Required for price display; ISO 4217 code — USD, EUR, GBP — never the symbol |
| offers.availability | Recommended | Stock status |
| aggregateRating | Recommended | Required for star ratings — only where the page shows genuine ratings; never assembled from nothing |
| review | Recommended | Individual reviews |
| sku | Recommended | Product identifier |
| brand | Recommended | Brand information |

### LocalBusiness Schema

| Property | Status | Notes |
|----------|--------|-------|
| @type | Required | LocalBusiness or subtype |
| name | Required | Business name |
| address | Required | PostalAddress object |
| address.streetAddress | Required | Street address |
| address.addressLocality | Required | City |
| address.addressRegion | Required | State/province |
| address.postalCode | Required | ZIP/postal code |
| address.addressCountry | Required | ISO 3166-1 alpha-2 code — GR, GB, US, DE. Not a country name, and not "UK" (not an alpha-2 code) |
| geo | Recommended | Latitude/longitude |
| telephone | Recommended | Phone number |
| openingHoursSpecification | Recommended | Business hours |
| priceRange | Recommended | Price range indicator |
| aggregateRating | Recommended | Customer ratings — only where the page shows genuine ratings; a rating not visible on the page is a content-mismatch violation |

### Organization Schema

| Property | Status | Notes |
|----------|--------|-------|
| @type | Required | Must be "Organization" |
| name | Required | Organization name |
| url | Required | Website URL |
| logo | Recommended | Brand logo |
| sameAs | Recommended | Social media profiles |
| contactPoint | Recommended | Contact information |

---

## Rich-Result Eligibility Note

The per-schema element SKILL.md step 2 requires in every deliverable. It is a **note, not a mock-up**: no drawn SERP listing, no ASCII box imitating a Google result, no screenshot-shaped illustration. A picture of a result reads as a promise of the result, and this skill promises eligibility only — Google decides per query and per device whether to show anything, and for some types there is nothing left to show.

**Shape — three parts, in this order:**

1. **Eligible for** — the rich result the type can qualify for, or "nothing in Google Search" where the feature is retired or none exists for the type.
2. **What feeds it** — which of the properties you actually emitted supply that result, plus any required property still missing and therefore blocking it.
3. **Caveat** — eligibility is not an appearance: Google chooses per query and per device, and display typically lags the next crawl by days to weeks.

**Worked example — Product (price snippet)**

> **Eligible for**: the price/availability snippet on your product result. **What feeds it**: the emitted `offers.price` (12.90), `offers.priceCurrency` (EUR) and `offers.availability` (InStock); `image` is a required property for this type and is still missing, so the snippet stays blocked until you send the URL. **Caveat**: correct markup makes the page eligible, not guaranteed — Google decides per query and per device, and any change usually surfaces days to weeks after the next crawl.

**Worked example — FAQPage (retired feature)**

> **Eligible for**: nothing in Google Search for an ordinary site — Google restricted FAQ rich results to well-known, authoritative government and health websites on 2023-08-08, and for everyone else the result "will no longer be shown regularly" (Google's words). **What feeds it**: the four `Question`/`acceptedAnswer` pairs are valid schema.org and machine-readable by any consumer that chooses to read them. **Caveat**: no engine promises to use it and no primary source establishes a citation benefit either way (ruling R3, amendment 9a) — this is machine-readable input, not a placement and not a lever.

**Worked example — LocalBusiness (no result of its own)**

> **Eligible for**: no rich result of its own that we would promise you. **What feeds it**: `name`, `address`, `telephone` and `openingHoursSpecification` corroborate the business entity where Google reads the page. **Caveat**: this markup supports how the business is understood; it does not by itself place you in the local pack, and no placement is promised. (Skill-side note, not for the deliverable: the mechanism behind local-pack placement is `[VERIFY]`-tagged in schema-decision-tree.md — write the caveat as above and assert nothing either way.)

---

## Google Rich Result Eligibility Requirements

### FAQPage — No Rich Result for an Ordinary Site (government/health only since Aug 2023)

**What is sourced**: on 2023-08-08 Google restricted FAQ rich results to well-known, authoritative government and health websites; for all other sites *"this rich result will no longer be shown regularly."* So for an ordinary client there is no FAQ eligibility to test and no SERP accordion to earn — promise neither.

**What is not sourced, and must not be written as fact**: a further set of 2026 events — search appearance, Search Console reporting, the Enhancements appearance filter and Rich Results Test support all dropped, plus an August 2026 API cut. Ruling R3 asserts these, but the two URLs it cites as its sources were read in a browser on 2026-08-11 and contain none of them; the page they actually came from has never been read by anyone. They may well be true. Until an owner check settles it (`docs/loop/r3-decision-brief.md`), state the 2023 restriction and stop there.

FAQPage stays in the library (settled ruling R3) because it is valid schema.org, costs nothing to keep, and Google's own guidance is that there is no need to proactively remove it. **State that basis and no more.** R3 amendment 9a records that its former rationale — that the value is AI-engine parsing — has **no primary source either way**, and that Google's 2026 AI-optimization guide says no special structured data is needed for its own AI surfaces. So a deliverable may say the markup is valid and cheap to keep; it may not say it earns AI citations. The quality bar that still applies:

- FAQPage is the page's ONE primary type — a dedicated FAQ page, not an FAQ block bolted onto a page that already carries an accurate type (settled ruling R2), unless the page genuinely is both things and each type is complete, accurate, and independently justified. That carve-out is the same one the pre-launch check below applies to every type, and it is narrow: having an FAQ section does not make a page an FAQ page, so the ordinary case is still the ban. The visible Q&A earns CORE-EEAT C09 on its own, so a page that keeps the Q&A and drops the markup loses nothing on that item
- Q&A pairs match the visible page content exactly (general structured-data content-match policy)
- Questions are actual questions; answers are complete
- Neutral, informational wording — not promotional copy
- User-generated Q&A belongs in QAPage, not FAQPage

Validate FAQPage at https://validator.schema.org/ (syntax + Schema.org semantics). Do not run it through the Rich Results Test or look for it in Search Console.

### How-To Rich Results

`[VERIFY]` **Whether this rich result is still offered is an open question in this library.** A 2023-08-08 Google Search Central post (title: "Changes to HowTo and FAQ rich results"; its FAQ half is superseded here by ruling R3, which has FAQ retired outright) is quoted as taking How-to results desktop-only and then dropping them "as of September 13", with the How-to report and Rich Results Test support withdrawn — read at search-snippet grade over the primary domain (2026-08-10), not owner-read, and no ruling has issued (WATCH-ITEMS W12 → gated item G9). Keep generating HowTo where the content genuinely is step-by-step; the content checklist below is what makes the markup honest either way. Promise no How-to SERP appearance until this resolves.

**Content checklist** (also the eligibility checklist if the feature is still offered):
- [ ] Minimum 2 steps with clear instructions
- [ ] Complete process from start to finish
- [ ] Each step has meaningful text (not just a title)
- [ ] Not advertising or promotional
- [ ] Not harmful or dangerous content
- [ ] Steps are actionable and practical

**Ineligible content**:
- Single-step processes
- Recipes (use Recipe schema instead)
- Promotional tutorials

### Product Rich Results

**For price display**:
- [ ] Valid Product schema
- [ ] `offers` with `price` property
- [ ] `priceCurrency` specified
- [ ] `availability` status

**For review stars**:
- [ ] Valid `aggregateRating` OR individual `review`
- [ ] Minimum 1 review for individual review display
- [ ] Honest, unbiased reviews (not paid/incentivized)

**For product markup**:
- [ ] `name` property present
- [ ] At least one `image`
- [ ] Valid product type (not person, organization, etc.)

### Article Rich Results

**Eligibility checklist**:
- [ ] Valid Article/BlogPosting/NewsArticle schema
- [ ] High-quality, original content
- [ ] Proper `publisher` with valid logo
- [ ] Valid `author` information
- [ ] Images meet size requirements (1200px wide)
- [ ] Not short-form content (minimum ~300 words)

---

## Testing Workflow

### Initial Implementation

1. **Add schema to development/staging environment**
2. **Validate syntax at validator.schema.org**
   - Paste code or test URL
   - Fix all errors before proceeding
3. **Test at Google Rich Results Test (non-FAQ types only)**
   - Check for Google-specific issues
   - Verify eligible rich result types
   - FAQPage: skip this step — this tool does not test FAQPage; the Schema.org validation in step 2 is the whole check
4. **Visual inspection**
   - View page source to confirm schema is present
   - Check JSON formatting in browser

### Pre-Launch Testing

1. **Test on staging URL with Rich Results Test** (non-FAQ types)
2. **Verify all required properties present**
3. **Confirm content matches visible page content**
4. **Check for policy violations**
5. **Confirm ONE primary type** — if a documented auxiliary accompanies it (e.g., BreadcrumbList for a real trail), validate each object; a second full content type is stacking (settled ruling R2), unless the page genuinely is both things and each type is complete, accurate, and independently justified
6. **Validate images are accessible and meet size requirements**

### Post-Launch Monitoring

1. **Submit sitemap to Google Search Console**
2. **Monitor Enhancements reports** (non-FAQ types — an ordinary site has no FAQ rich result to report on since the 2023-08-08 restriction)
   - Check for validation errors
   - Watch for policy violations
   - Track rich result impressions
3. **Re-test pages if content changes**
4. **Update `dateModified` when updating content**
5. **Fix errors within 30 days to avoid rich result removal**

---

## Common Policy Violations

### Content Mismatch

**Violation**: Schema content doesn't match visible page content

**Example**: FAQ schema includes Q&A pairs not visible on page

**Fix**: Ensure all structured data reflects actual page content exactly

### Deceptive Content

**Violation**: Schema contains misleading information

**Example**: Product reviews that are fake or incentivized

**Fix**: Only include genuine, verifiable information

### Spammy Markup

**Violation**: Excessive or irrelevant schema

**Example**: Adding Product schema to every blog post; bolting a second full content type (e.g., FAQPage) onto a page on the theory that more types raise AI-citation odds — that is citation-lever stacking (settled ruling R2), and no engine documents a citation gain from extra types

**Fix**: ONE accurate primary type per page; nest supporting entities; documented auxiliaries (BreadcrumbList, WebSite on the homepage) only where the page data warrants

### Hidden Content

**Violation**: Schema references content hidden from users

**Example**: FAQ answers only in schema, not visible on page

**Fix**: Make all schema content visible to users

### Promotional Content in FAQ

**Violation**: Using FAQ schema for promotional purposes

**Example**: Questions like "Why is [Brand] the best?"

**Fix**: Use neutral, informational questions

---

## Debugging Common Issues

### Schema Not Appearing in Rich Results Test

**Possible causes**:
- JSON syntax error (validate at validator.schema.org)
- Schema in incorrect location (should be in `<head>` or `<body>`)
- Script tag missing `type="application/ld+json"`
- Content served dynamically after page load (bot can't see it)

**Debug steps**:
1. View page source (not inspect element)
2. Search for `"@type"`
3. Copy JSON to validator.schema.org
4. Fix syntax errors

### Rich Results Not Showing in Search

**Possible causes**:
- The type no longer has a rich result (no FAQ rich result for ordinary sites since Aug 2023 — nothing will show; that is expected, not a bug)
- Schema is new (can take days/weeks to appear)
- Page not indexed by Google
- Schema has errors in Search Console
- Content doesn't meet quality guidelines
- Competition for rich results is high

**Debug steps**:
1. Check Search Console → Enhancements
2. Use URL Inspection tool to request indexing
3. Verify schema passes Rich Results Test
4. Check for manual actions

### Warnings vs Errors

**Errors** (must fix):
- Invalid syntax
- Missing required properties
- Invalid property values
- Schema type doesn't exist

**Warnings** (should fix when possible):
- Missing recommended properties
- Suboptimal property values
- Non-standard extensions
- Property not recognized for this type

---

## Schema Maintenance Checklist

### Monthly
- [ ] Check Search Console for new errors
- [ ] Verify rich results are still appearing (non-FAQ types)
- [ ] Update `dateModified` on changed content

### Quarterly
- [ ] Audit all schema implementations (one primary type per page — flag stacked types, ruling R2)
- [ ] Test key pages with Rich Results Test (non-FAQ types); FAQPage via Schema.org validator
- [ ] Update any outdated information (prices, dates, etc.)
- [ ] Check for new schema types relevant to your content

### After Content Changes
- [ ] Update schema to match new content
- [ ] Update `dateModified` timestamp
- [ ] Re-validate: Schema.org validator; Rich Results Test for non-FAQ types
- [ ] Request re-indexing in Search Console if major changes

### After Site Migration
- [ ] Verify schema preserved on new URLs
- [ ] Update all absolute URLs in schema
- [ ] Submit new sitemap
- [ ] Monitor for errors in new domain's Search Console

---

## Quick Reference: Error Messages and Fixes

| Error Message | Cause | Fix |
|---------------|-------|-----|
| "Missing required field" | Required property not included | Add the required property |
| "Invalid date format" | Date not in ISO 8601 | Use 2024-01-15 when the page states no time; 2024-01-15T08:00:00+00:00 when it does |
| "URL is not absolute" | Relative URL used | Add full URL with https:// |
| "Unexpected token" | JSON syntax error | Check for missing quotes, brackets, commas |
| "This markup is not eligible for rich results" | Schema type or content doesn't qualify | Review eligibility requirements |
| "Image too small" | Image doesn't meet size requirements | Use image at least 1200px wide |
| "The attribute price is required" | Product missing price | Add offers.price property |
| "Logo must be 600x60 or smaller" | Publisher logo too large | Resize logo to meet requirements |

---

## Resources

- **Schema.org Documentation**: https://schema.org/
- **Google Search Central**: https://developers.google.com/search/docs/appearance/structured-data
- **Rich Results Test**: https://search.google.com/test/rich-results (no FAQ support since 2026)
- **Schema Validator**: https://validator.schema.org/ (use this for FAQPage)
- **JSON-LD Playground**: https://json-ld.org/playground/
