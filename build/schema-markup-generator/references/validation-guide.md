# Schema Markup Validation Guide

Complete reference for validating, testing, and troubleshooting structured data.

## Validation Tools

### Google Rich Results Test
- **URL**: https://search.google.com/test/rich-results
- **Purpose**: Check if your schema is eligible for Google rich results
- **Tests**: Live URL or code snippet
- **Output**: Errors, warnings, eligible rich result types
- **FAQ exception**: FAQ support was cut in 2026 — do not use this tool for FAQPage; validate FAQPage with the Schema.org Validator instead

### Schema.org Validator
- **URL**: https://validator.schema.org/
- **Purpose**: Validate against official Schema.org specification
- **Tests**: URL, code snippet, or microdata
- **Output**: Technical validation errors
- **Note**: The primary (and only) validator for FAQPage since the 2026 FAQ rich-result retirement

### Google Search Console
- **Location**: Search Console → Enhancements section
- **Purpose**: Monitor rich results performance and errors at scale
- **Reports**: Rich results status, coverage, issues over time
- **FAQ exception**: FAQ reporting, the API, and the Enhancements appearance filter were cut in 2026 — there is nothing to monitor here for FAQPage

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

**Fix**: Use ISO 8601 format
```json
{
  "datePublished": "2024-01-15T08:00:00+00:00"
}
```

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

**Status note**: FAQPage produces no Google rich result (retired 2026). It is still generated for AI-engine/GEO parsing (settled ruling R3) and validates against Schema.org semantics only.

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
| datePublished | Required | ISO 8601 format |
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
| offers.priceCurrency | Recommended | Required for price display |
| offers.availability | Recommended | Stock status |
| aggregateRating | Recommended | Required for star ratings |
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
| address.addressCountry | Required | Country code |
| geo | Recommended | Latitude/longitude |
| telephone | Recommended | Phone number |
| openingHoursSpecification | Recommended | Business hours |
| priceRange | Recommended | Price range indicator |
| aggregateRating | Recommended | Customer ratings |

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

## Google Rich Result Eligibility Requirements

### FAQPage — No Rich Result (Retired 2026)

Google retired FAQ rich results in 2026: Search Console reporting, the API, the Enhancements appearance filter, and Rich Results Test support were all cut. There is no FAQ eligibility to test and no SERP accordion to earn — promise neither.

FAQPage stays in the library (settled ruling R3): its value is AI-engine/GEO parsing — answer engines extract clean Q&A pairs from it. The quality bar that still applies:

- Q&A pairs match the visible page content exactly (general structured-data content-match policy)
- Questions are actual questions; answers are complete
- Neutral, informational wording — not promotional copy
- User-generated Q&A belongs in QAPage, not FAQPage

Validate FAQPage at https://validator.schema.org/ (syntax + Schema.org semantics). Do not run it through the Rich Results Test or look for it in Search Console.

### How-To Rich Results

**Eligibility checklist**:
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
   - FAQPage: skip this step — FAQ support was cut in 2026; the Schema.org validation in step 2 is the whole check
4. **Visual inspection**
   - View page source to confirm schema is present
   - Check JSON formatting in browser

### Pre-Launch Testing

1. **Test on staging URL with Rich Results Test** (non-FAQ types)
2. **Verify all required properties present**
3. **Confirm content matches visible page content**
4. **Check for policy violations**
5. **Confirm ONE primary type** — if a documented auxiliary accompanies it (e.g., BreadcrumbList for a real trail), validate each object; a second full content type is stacking (settled ruling R2)
6. **Validate images are accessible and meet size requirements**

### Post-Launch Monitoring

1. **Submit sitemap to Google Search Console**
2. **Monitor Enhancements reports** (non-FAQ types — FAQ reporting was cut in 2026)
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
- The type no longer has a rich result (FAQ retired in 2026 — nothing will show; that is expected, not a bug)
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
| "Invalid date format" | Date not in ISO 8601 | Use format: 2024-01-15T08:00:00+00:00 |
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
