# Meta Tag Code Templates

HTML code templates for Open Graph tags, Twitter cards, additional meta tags, and complete meta tag blocks.

---

## How to read this file (placement rule)

Two kinds of block appear below, and they are not interchangeable:

- **Skeleton** — `[bracket tokens]` mark slots you fill from the page's own data. Scaffolding, never an answer. Every fenced skeleton opens with an inline `<!-- SKELETON ... -->` comment so the marker travels with the code if the fence alone is copied.
- **Filled example** — every value resolved. This is the shape a deliverable takes.

**The value rule**: a tag handed to the user carries a resolved value, or it does not ship at all. When a value cannot be sourced from the input — the image asset does not exist yet, the social handle is unknown, no publish date was supplied — drop that tag from the block and name the gap in the report prose, where the person who has to fix it will read it. What never goes inside a `content=` or `href=` attribute, or between `<title>` tags: a bracket token, `TBD`, `XX`, or a note shaped like a value such as `TO SUPPLY - absolute URL, 1200x630px`. A note in that position leaves the tag present and pointing at nothing, and it hides the gap from the one surface that would have got it fixed.

Provenance: ledger F13 (placement class) and `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 2. This skill's Output Validation checklist and its eval suite both check the same thing.

---

## Open Graph Tags (Facebook, LinkedIn, etc.)

**Required OG Tags** (skeleton):

```html
<!-- SKELETON — fill every [slot] from the page's data; drop any tag you cannot fill -->
<meta property="og:type" content="[article/website/product]">
<meta property="og:url" content="[Full canonical URL]">
<meta property="og:title" content="[OG-optimized title - up to 60 chars]">
<meta property="og:description" content="[OG description - up to 200 chars]">
<meta property="og:image" content="[Absolute image URL - 1200x630px recommended]">

<!-- Optional but Recommended -->
<meta property="og:site_name" content="[Website Name]">
<meta property="og:locale" content="en_US">
```

**OG Type Selection Guide**:

| Page Type | og:type |
|-----------|---------|
| Blog post | article |
| Homepage | website |
| Product | product |
| Video | video.other |
| Profile | profile |

**OG Title Considerations**:
- Can be different from title tag
- Optimize for social sharing context
- More conversational tone acceptable
- Up to 60 characters ideal

**OG Description Considerations**:
- Can be longer than meta description (up to 200 chars)
- Focus on shareability
- What would make someone click when shared?

**OG Image Requirements**:
- Recommended size: 1200x630 pixels
- Minimum size: 600x315 pixels
- Format: JPG or PNG
- Absolute URL, not a site-relative path
- Keep text to less than 20% of image
- Include branding subtly

**When no image asset exists yet**: `og:image` and `twitter:image` come OUT of the delivered block, and the report says what to create ("no OG image on this page — produce a 1200x630 JPG/PNG and add `og:image` pointing at its absolute URL"). The recommendation is the deliverable; a placeholder inside the tag is not.

---

## Twitter Card Tags

**Card Type Selection**:

| Card Type | Best For | Image Size |
|-----------|----------|------------|
| summary | Articles, blogs | 144x144 min |
| summary_large_image | Visual content | 300x157 min |
| player | Video/audio | 640x360 min |
| app | Mobile apps | 800x418 |

**Twitter Card Code** (skeleton):

```html
<!-- SKELETON — fill every [slot]; an unknown handle means the tag is dropped, not guessed -->
<meta name="twitter:card" content="[summary_large_image/summary]">
<meta name="twitter:site" content="@[YourTwitterHandle]">
<meta name="twitter:creator" content="@[AuthorTwitterHandle]">
<meta name="twitter:title" content="[Title - 70 chars max]">
<meta name="twitter:description" content="[Description - 200 chars max]">
<meta name="twitter:image" content="[Absolute image URL]">
<meta name="twitter:image:alt" content="[Image description for accessibility]">
```

**Twitter-Specific Considerations**:
- Shorter titles work better (under 70 chars)
- Include @mentions if relevant
- Hashtag-relevant terms can help discovery
- Test with Twitter Card Validator
- `twitter:site` / `twitter:creator` need the account's real handle — if the input does not carry it, omit both tags and ask for the handle in the report

---

## Additional Recommended Meta Tags

The bracketed blocks below are skeletons — each bracket is a slot, and an unfillable slot means the whole tag is left out. The robots, viewport and `lang` snippets carry real values already and ship as written.

**Canonical URL** (Prevent duplicates):
```html
<!-- SKELETON — fill the [slot] with the page's own absolute URL -->
<link rel="canonical" href="[Preferred absolute URL]">
```

**Robots Tag** (Indexing control):
```html
<meta name="robots" content="index, follow">
```

**Viewport** (Mobile optimization):
```html
<meta name="viewport" content="width=device-width, initial-scale=1">
```

**Author** (For articles):
```html
<!-- SKELETON — an unnamed author means no tag, and a note in the report -->
<meta name="author" content="[Author Name]">
```

**Language**:
```html
<html lang="en">
```

**Article-Specific** (For blog posts):
```html
<!-- SKELETON — ISO 8601 dates come from the CMS; an unknown date means no tag -->
<meta property="article:published_time" content="[ISO 8601 date]">
<meta property="article:modified_time" content="[ISO 8601 date]">
<meta property="article:author" content="[Author URL]">
<meta property="article:section" content="[Category]">
<meta property="article:tag" content="[Tag 1]">
```

---

## Complete Meta Tag Block

### Filled example — copy and paste this block, then swap in the page's own values

Worked from this skill's blog-post example: a 2026 podcast-launch guide. `example.com` is the
reserved documentation domain (RFC 2606) standing in for the real host — every value below is
resolved, which is the property to preserve when producing one of these.

```html
<!-- Primary Meta Tags -->
<title>How to Start a Podcast in 2026: Complete Beginner's Guide</title>
<meta name="title" content="How to Start a Podcast in 2026: Complete Beginner's Guide">
<meta name="description" content="Learn how to start a podcast in 2026 with our step-by-step guide: equipment, hosting, recording, and launching your first episode. Start podcasting today!">
<link rel="canonical" href="https://example.com/blog/how-to-start-a-podcast/">

<!-- Open Graph / Facebook -->
<meta property="og:type" content="article">
<meta property="og:url" content="https://example.com/blog/how-to-start-a-podcast/">
<meta property="og:title" content="How to Start a Podcast in 2026: A Beginner's Guide">
<meta property="og:description" content="Equipment, hosting, recording and launch day - everything a first-time podcaster needs, in one step-by-step guide.">
<meta property="og:image" content="https://example.com/img/start-a-podcast-og-1200x630.jpg">
<meta property="og:site_name" content="Example Media">
<meta property="og:locale" content="en_US">

<!-- Twitter -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:url" content="https://example.com/blog/how-to-start-a-podcast/">
<meta name="twitter:title" content="How to Start a Podcast in 2026: A Beginner's Guide">
<meta name="twitter:description" content="Equipment, hosting, recording and launch day - everything a first-time podcaster needs, in one step-by-step guide.">
<meta name="twitter:image" content="https://example.com/img/start-a-podcast-og-1200x630.jpg">
<meta name="twitter:image:alt" content="USB microphone and laptop on a desk, with the guide title overlaid">

<!-- Additional -->
<meta name="robots" content="index, follow">
<meta name="author" content="Example Media editorial team">
```

Counts for the values above: title 57 chars, meta description 154 chars, og:title 50, og:description 110 — each inside the limits this skill sets. `twitter:site` and `twitter:creator` are absent on purpose: the worked page's account handle was not part of the input, so the tags are left out and the report asks for the handle. That absence is the value rule in action, and it is what a missing OG image should look like too.

### Fill-in skeleton — scaffolding, NOT ship-ready

Do not hand this block to a user. Fill every slot from the page's own data first, then delete any line whose value the input does not support and record it as a gap in the report.

```html
<!-- SKELETON — NOT ship-ready: fill every [slot], delete any tag you cannot fill -->
<!-- Primary Meta Tags -->
<title>[Optimized Title]</title>
<meta name="title" content="[Optimized Title]">
<meta name="description" content="[Optimized Description]">
<link rel="canonical" href="[Canonical URL]">

<!-- Open Graph / Facebook -->
<meta property="og:type" content="[type]">
<meta property="og:url" content="[URL]">
<meta property="og:title" content="[OG Title]">
<meta property="og:description" content="[OG Description]">
<meta property="og:image" content="[Absolute image URL]">
<meta property="og:site_name" content="[Site Name]">

<!-- Twitter -->
<meta name="twitter:card" content="summary_large_image">
<meta name="twitter:url" content="[URL]">
<meta name="twitter:title" content="[Twitter Title]">
<meta name="twitter:description" content="[Twitter Description]">
<meta name="twitter:image" content="[Absolute image URL]">

<!-- Additional -->
<meta name="robots" content="index, follow">
<meta name="author" content="[Author]">
```

**Before delivery**, read the block back: if a `[`, a `TBD`, or any words describing data you do not have survive inside a tag value, the block is not finished. Resolve it or delete the tag, and put the gap in the report.
