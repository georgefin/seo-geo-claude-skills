# Schema Audit and Correction — "How Mid-Market Retailers Can Cut Fulfilment Costs by 18%"

**The headline finding: right now this page has no working structured data at all.** There is a trailing comma after `"name": "Dana Okafor"`, and a trailing comma is invalid JSON. It does not break one property — it breaks the parse, and because both objects live inside a single `<script>` tag, the whole tag is discarded. Your BlogPosting and your Product block are equally invisible. Pasting the block into a parser fails at the closing brace immediately after that comma.

So your crawler is not reporting a list of small problems. It is reporting one fatal one, with several more waiting behind it that will only surface once the parse succeeds. Those are fixed below too.

**The second finding, which matters more in the long run: the `Product` object has to go, not be repaired.** This page is an article. A `Product` block asserting that the page is a consulting product is a second content type claiming to be what the page is, and it is a claim the page does not support. Product markup on a blog post is a named example of spammy markup in Google's own framing, and it carries policy risk for the whole site rather than just this URL. It also would not have worked on its own terms — it has no `offers`, no `price` and no `image`, so it fails Product's own requirements before anyone gets to the question of whether it is honest.

Northbeam Retail Ops Consulting deserves markup. It deserves it on its own service page, as a `Service` with Northbeam nested as `provider`. Not on an article about fulfilment costs.

---

### Schema Analysis

**Content Type**: blog post / editorial guide
**Page URL (canonical)**: https://www.northbeam-consulting.com/blog/cut-fulfilment-costs

**Data source**: user-provided — the visible page excerpt and the current JSON-LD you copied from the page source. No crawler was connected and the live URL was not fetched. That has one consequence I want to be explicit about: I audited the block you pasted, so if the live page source differs from what you sent, the audit describes your paste rather than your page.

**Eligible Rich Results**:

| Rich Result Type | Eligibility | Impact |
|------------------|-------------|--------|
| Article | ❌ today — blocked on `publisher.logo` | Medium — shows publish date and author |

**Recommended Schema**:

- **Primary type (ONE per page)**: `BlogPosting`. That was already the right call — the type was correct, the execution was not. `BlogPosting` is the Article variant for a blog post and is what an editorial guide on a company blog should carry.
- **Nested inside it**: `author` (Person), `publisher` (Organization), `mainEntityOfPage`. These are properties of the article, not page-level types of their own.
- **Removed**: the top-level `Product` object. See above.
- **Auxiliaries (only if page data warrants)**: none in what you sent. If the live page has a breadcrumb trail — Home → Blog → this post — send the labels and URLs and a `BreadcrumbList` goes alongside as a genuine second object. That is the one extra top-level type this page could legitimately carry, and it is a very different thing from the Product block, because breadcrumb display is a live, separately documented Google feature and the trail actually exists on the page.

---

### Defect List

| # | What is wrong | Severity | What I did |
|---|---|---|---|
| 1 | Trailing comma after `"name": "Dana Okafor"` | **Fatal** — invalidates the entire script tag; nothing is read | Removed |
| 2 | Top-level `Product` object on an article | **Critical** — false content type, stacking, spam-policy exposure; also incomplete as a Product | Deleted entirely |
| 3 | `datePublished` is `"03/12/2025"` | **Error** — not ISO 8601, and ambiguous between 12 March and 3 December | Corrected to `2025-03-12` |
| 4 | `image` is `/img/fulfilment-hero.jpg` | **Error** — relative URLs are not permitted in structured data | Resolved to the absolute URL against your canonical origin |
| 5 | `publisher` absent | **Error** — required for Article/BlogPosting | Added as `Organization` with name and url; `logo` still missing, see below |
| 6 | `description` absent | Warning — recommended, improves display | Added from your visible intro |
| 7 | `mainEntityOfPage` absent | Warning — recommended, ties the markup to the canonical URL | Added |
| 8 | `dateModified` absent | Warning — recommended | Left out, named below |
| 9 | `author.url` absent | Warning — weakens author identity | Left out, named below |
| 10 | Array wrapper around a single object | Cleanup | Unwrapped — with one object there is nothing to make an array of |

On **#3**, the ambiguity is worth dwelling on for a second, because it is the kind of error that quietly survives a fix. `03/12/2025` reads as 12 March 2025 to an American parser and 3 December 2025 to a British one. Your visible byline says "Published 12 March 2025", so 12 March is the true date and `2025-03-12` is the correct value. Had the byline not been on the page, I would have had to ask rather than pick — a coin-flip on a nine-month error is not a fix.

Note the corrected date carries **no time**. Your page shows a date and no clock time, so date-only is the right precision — reduced precision is valid ISO 8601, and adding `T00:00:00` or a timezone offset would be inventing information the page does not carry.

---

### Corrected Schema Markup

```json
{
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "How Mid-Market Retailers Can Cut Fulfilment Costs by 18%",
  "description": "Fulfilment now eats 12–20% of revenue for most mid-market retailers. In this guide we break down the six cost drivers we audit first, with benchmark ranges drawn from 40 client engagements.",
  "image": "https://www.northbeam-consulting.com/img/fulfilment-hero.jpg",
  "datePublished": "2025-03-12",
  "author": {
    "@type": "Person",
    "name": "Dana Okafor"
  },
  "publisher": {
    "@type": "Organization",
    "name": "Northbeam Consulting",
    "url": "https://www.northbeam-consulting.com"
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "https://www.northbeam-consulting.com/blog/cut-fulfilment-costs"
  }
}
```

The `description` is your own intro text, with the excerpt's trailing ellipsis removed so the value is a complete sentence rather than a visibly cut one. If the live intro differs from the excerpt you sent, send me the real opening and I will swap it — the value has to match what a reader sees.

---

### Rich-Result Eligibility

**Eligible for**: the Article rich result — your publish date and Dana Okafor's byline shown with the search listing. **What feeds it**: the emitted `headline`, `datePublished`, `author`, `image` and `publisher`; `publisher.logo` is a required property for this result and is still missing, so the rich result stays blocked until you send the URL, and `image` needs to be at least 1200px wide to qualify — I cannot check the dimensions of `fulfilment-hero.jpg` from here, so please confirm it. **Caveat**: correct markup makes the page eligible, not guaranteed — Google decides per query and per device, and any change usually surfaces days to weeks after the next crawl.

---

### Property Notes — Required vs Optional

| Property | Status | In the block? |
|---|---|---|
| `@type` | Required — `BlogPosting` | Yes |
| `headline` | Required — max 110 characters | Yes (56 characters) |
| `image` | Required — minimum 1200px wide | Yes, now absolute — **dimensions unverified** |
| `datePublished` | Required — ISO 8601 at the page's precision | Yes — `2025-03-12` |
| `author` | Required — Person or Organization | Yes |
| `publisher` | Required — Organization with logo | Partly — organization yes, **logo missing** |
| `publisher.logo` | Required — max 600px wide, 60px high | **No — see below** |
| `dateModified` | Recommended | **No — see below** |
| `description` | Recommended | Yes |
| `mainEntityOfPage` | Recommended | Yes |
| `author.url` | Recommended | **No — see below** |

**Missing data — four properties left out rather than guessed:**

1. **`publisher.logo`** — this is the one still blocking your Article rich result. Send the absolute URL of a logo image no wider than 600px and no taller than 60px, hosted on your own domain, and it becomes a four-line nested `ImageObject` inside `publisher`. I have not put a plausible-looking path such as `https://www.northbeam-consulting.com/logo.png` into the block, because a logo URL that 404s is an error in the markup rather than a placeholder in it — and it is the kind of error that looks fixed in Search Console right up until you check the image.
2. **`dateModified`** — omitted. Your page shows a publish date and no revision date. This property matters more than it looks for a guide with benchmark numbers in it: when you refresh the 12–20% range or the 40-engagement figure, `dateModified` is how you signal the refresh. Add it as `2025-03-12` today only if the post genuinely has never been edited since publication; otherwise send the real revision date. Do not set it to today's date as a freshness trick — a modification date with no modification behind it is exactly the signal that gets discounted.
3. **`author.url`** — omitted. If Dana Okafor has an author page on your site, or a LinkedIn profile you are happy to point at, that URL turns a name into an identifiable person and is one of the cheaper credibility signals available on a consulting blog. Send it and it becomes one line inside `author`.
4. **`articleBody` / `wordCount`** — optional, omitted. You sent an excerpt rather than the full text, and I am not going to reconstruct an article body from three sentences.

**One thing to verify that I could not:** `image` now points at `https://www.northbeam-consulting.com/img/fulfilment-hero.jpg`, resolved from the relative path in your original block against your canonical origin. That resolution is mechanical and safe, but two things about the asset are not: whether it actually exists at that URL, and whether it is at least 1200px wide. Open the URL and check both before you ship.

---

## Implementation Guide

### Adding Schema to Your Page

Replace the entire existing `<script type="application/ld+json">` tag — both objects, the array brackets, all of it — with this one:

**Option 1: In HTML `<head>`**

```html
<head>
  <script type="application/ld+json">
    ...the full corrected JSON-LD block from above, pasted verbatim...
  </script>
</head>
```

**Option 2: Before closing `</body>`**

```html
  <script type="application/ld+json">
    ...the full corrected JSON-LD block from above, pasted verbatim...
  </script>
</body>
```

Do not leave the old block in place alongside the new one. Two BlogPosting objects with different `datePublished` values is a worse state than the one you are in now.

Worth asking while you are in there: **where did the Product block come from?** A hand-written article template does not usually grow a Product object by accident. If it came from a plugin, a theme setting, or a "add schema to every post" toggle, that switch is emitting the same block on every blog post you have, and fixing this one URL fixes one instance of a site-wide problem. Check a second post before you close the ticket.

### Validation Steps

1. **Google Rich Results Test** — https://search.google.com/test/rich-results
   Test the live URL or paste the corrected code. Article is fully supported here. Expect it to flag the missing `publisher.logo` — that is the tool working, not a new bug.

2. **Schema.org Validator** — https://validator.schema.org/
   Validates against the Schema.org specification. Run the corrected block through this **first**, before it goes near the page: it is the fastest way to confirm the trailing comma is genuinely gone. Paste the old block in too if you want to see the parse failure for yourself.

3. **Google Search Console**
   Watch the Enhancements section after the page is recrawled. The existing errors should clear; give it days to weeks rather than hours, and re-request indexing through URL Inspection if you want to push it along.

### Validation Checklist

- [ ] JSON syntax is valid (no trailing commas)
- [ ] All required properties present
- [ ] URLs are absolute, not relative
- [ ] Dates are ISO 8601 at the precision the page states
- [ ] Content matches visible page content
- [ ] No policy violations

Five of the six hold in the corrected block as written. **The second one does not yet** — `publisher.logo` is required for this type and is still missing, and that is the single item standing between you and a working Article rich result. Send the logo URL and the block is complete.
