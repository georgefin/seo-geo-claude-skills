# Crawlability capture — fieldharvest.co.uk (manual collection)

**Client:** FieldHarvest — fieldharvest.co.uk (organic veg-box delivery, UK; the /recipes/ section is the main organic-traffic content hub)
**Collected by:** in-house marketer — browser fetches and hand checks, transcribed by hand
**Capture date:** 2026-08-06
**Tools:** none connected. No crawler has run. No Search Console export is available — our developer remembers "Blocked by robots.txt" warnings appearing in Search Console since mid-July, but we have no screenshot or export (memory only). This file is the complete data set.

## robots.txt — fetched in a browser at https://www.fieldharvest.co.uk/robots.txt (returned HTTP 200, plain text)

Rewritten by an outside contractor in early July 2026. Company policy, deliberate and to keep: we refuse AI model-training use of our content, but we DO want AI search/assistant answers to be able to cite us.

```
User-agent: *
Disallow: /checkout/
Disallow: /account/
Disallow: /recipes
Disallow: /assets/
Crawl-delay: 5

User-agent: GPTBot
Disallow: /

User-agent: ClaudeBot
Disallow: /

User-agent: CCBot
Disallow: /

User-agent: Google-Extended
Disallow: /
```

## Homepage HTML head (extract from the saved page source)

```
<link rel="stylesheet" href="/assets/css/main.css">
<link rel="stylesheet" href="/assets/css/product-grid.css">
<script src="/assets/js/menu.js" defer></script>
```

## sitemap.xml — fetched at https://www.fieldharvest.co.uk/sitemap.xml (valid XML; NOT referenced anywhere in the robots.txt above)

| Section | URL count |
|---------|-----------|
| /recipes/… | 62 |
| /boxes/… | 14 |
| Other (home, about, delivery-areas, faq, contact, gift-cards, sustainability, blog index) | 8 |
| **Total** | **84** |

Every one of the 84 `<lastmod>` values reads exactly `2024-05-01`. (New recipes have been published monthly through 2026 — the site footer currently shows "Latest recipes: July 2026".)

## Hand-checked sitemap URLs (12 of the 84, opened in a browser on 2026-08-06)

| URL | Result |
|-----|--------|
| /recipes/summer-salads-2024 | 404 |
| /boxes/office-fruit-large | 404 |
| /recipes/foraging-guide | 404 |
| /recipes/roast-squash-traybake | 200 |
| /recipes/beetroot-brownies | 200 |
| /recipes/leek-potato-soup | 200 |
| /recipes/spring-greens-pasta | 200 |
| /recipes/tomato-galette | 200 |
| /boxes/family-veg-medium | 200 |
| /boxes/fruit-solo | 200 |
| /about | 200 |
| /delivery-areas | 200 |

We only checked these 12 — nobody has checked the other 72 sitemap URLs.
