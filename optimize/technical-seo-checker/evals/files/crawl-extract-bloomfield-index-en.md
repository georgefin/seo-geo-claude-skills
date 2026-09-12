# Crawl and index extract — bloomfield-nurseries.co.uk (user-provided)

**Client:** Bloomfield Nurseries — bloomfield-nurseries.co.uk (garden plants and pots e-shop with a /guides/ article hub, UK)
**Sources:** (1) a desktop-crawler export run by a colleague on 2026-08-04, before the licence lapsed — an internal-link crawl starting from the homepage; (2) a `site:` search the marketing lead ran by hand on 2026-08-07. Both transcribed/summarized here by hand.
**Tools connected now:** none. No Search Console access. This extract is the complete data set.

## Crawl vs sitemap cross-reference

| Population | Count | Detail |
|------------|-------|--------|
| URLs in sitemap.xml (https://www.bloomfield-nurseries.co.uk/sitemap.xml — valid XML, referenced in robots.txt) | 48 | |
| URLs found by the internal-link crawl from the homepage | 60 | every one returned 200 |
| In both (sitemap AND crawl) | 46 | |
| Sitemap-only — in the sitemap but linked from no crawled page | 2 | /guides/rose-care-2019 and /events/open-day-2024 (each opens fine with 200 when visited directly) |
| Crawl-only — reachable by internal links but absent from the sitemap | 14 | the 4 noindexed utility pages, the 2 parameter URLs, the 4 variant pages (all listed below) and 4 of the category pages |

## Crawled page types (the 60 crawled URLs)

| Type | Count |
|------|-------|
| Homepage | 1 |
| Product pages | 20 |
| Colour/size variant pages | 4 |
| Guide articles (under /guides/) | 12 |
| Interactive quiz page (/guides/plant-finder-quiz — a tool page, separate from the 12 articles) | 1 |
| Offers page (/offers/spring-2025) | 1 |
| FAQ page (/faq) | 1 |
| Utility pages (/checkout, /basket, /account/login, /search) | 4 |
| Parameter URLs | 2 |
| Category pages | 8 |
| Info pages (about, contact, delivery, sustainability, gift-vouchers, planting-calendar) | 6 |
| **Total crawled** | **60** |

## Robots meta (from the crawler's "Meta Robots" column)

6 of the 60 crawled URLs carry `<meta name="robots" content="noindex,follow">`:

| URL | In the sitemap? |
|-----|-----------------|
| /checkout | no |
| /basket | no |
| /account/login | no |
| /search | no |
| /guides/plant-finder-quiz | **yes** |
| /offers/spring-2025 | **yes** |

(So 2 of the 48 sitemap URLs are noindexed; the other 4 noindexed URLs are utility pages that are not in the sitemap.)

## Canonicals (from the crawler's "Canonical" column, across the 60 crawled URLs)

| Canonical state | Count | Notes |
|-----------------|-------|-------|
| Self-referencing https canonical | 44 | |
| No canonical tag at all | 9 | includes the 2 parameter URLs below |
| Canonical points to a DIFFERENT URL | 7 | breakdown below |

Breakdown of the 7 pointing elsewhere:

- 3 product pages canonicalize to the `http://` version of themselves (protocol mismatch):
  - /plants/lavender-hidcote → http://www.bloomfield-nurseries.co.uk/plants/lavender-hidcote
  - /plants/rosemary-tuscan-blue → http://www.bloomfield-nurseries.co.uk/plants/rosemary-tuscan-blue
  - /plants/hydrangea-annabelle → http://www.bloomfield-nurseries.co.uk/plants/hydrangea-annabelle
- 4 colour/size variant pages canonicalize to their parent product page (set up on purpose last year):
  - /plants/acer-palmatum-red → /plants/acer-palmatum
  - /plants/acer-palmatum-green → /plants/acer-palmatum
  - /pots/glazed-pot-large-blue → /pots/glazed-pot-large
  - /pots/glazed-pot-large-grey → /pots/glazed-pot-large

## Parameter URLs (crawled, returned 200, no canonical tag)

- /plants/wisteria-alba?src=email — same rendered content as /plants/wisteria-alba
- /seeds/tomato-heritage?sort=price — same rendered content as /seeds/tomato-heritage

## site: search (hand-run 2026-08-07 — approximate by nature)

`site:bloomfield-nurseries.co.uk` → Google showed "about 31 results".

## Structured data (from the crawler's "Structured Data" column)

| Pages | Markup found | Validation |
|-------|--------------|------------|
| Homepage | Organization JSON-LD | valid, no errors |
| 20 product pages | Product JSON-LD | valid, no errors |
| 12 guide articles | none | — (one of the 12, /guides/how-to-plant-a-hedge, is a step-by-step how-to guide) |
| /faq | none | — (the page shows 6 visible question-and-answer pairs) |
| All other crawled pages | none | — |
