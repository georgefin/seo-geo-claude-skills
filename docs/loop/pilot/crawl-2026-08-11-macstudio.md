# Sani Hellas NOBO/ATLANTIC crawl — 2026-08-11, Mac Studio

**Status: COMPLETE. 17 GR surfaces enumerated, 0 errors.** This supplies what
`crawl-2026-08-11.md` could not: that record is a **true** record of a blocked attempt from the
"Custom 1" cloud environment (403, Cloudflare bot management), and is **not superseded as
evidence** — it documents a real client-side block that still exists for that environment. This
run was executed from a local machine (`GIORGOSs-Mac-Studio`) on its own network, where the same
origin returns 200. Two different clients, two true measurements, ~5h apart (R323: a measurement
is evidence about the moment it was taken).

Run: local Mac Studio, no egress proxy. Read-only HTTP GET throughout. **Nothing was written to
any live site.**

---

## 0 — Reachability, with a negative control

The control is the load-bearing part. `www.sanihellas.gr` **soft-404s**: a nonexistent URL returns
`200` with the homepage. A bare 200 therefore proves nothing, in either direction.

```
https://www.sanihellas.gr/                    200  81,006 B  1 redirect -> /el-gr/
https://www.sanihellas.gr/el-gr/this-page-cannot-exist-herbert-probe-9471/
                                              200  81,006 B  <title> = homepage   <- SOFT-404 SIGNATURE
https://www.google.com/                       200
https://developers.google.com/search/docs     200  188,436 B
```

Every result below was discriminated against that signature (`size == 81006` + homepage `<title>`
= page does not exist).

## 1 — Enumeration, and three instrument failures caught before they became findings

Recorded because each would have produced a confident wrong inventory, and two are ledgered
signatures.

1. **CDATA sitemap (ledger: the R320 signature, reproduced exactly).** `grep -o
   '<loc>[^<]*</loc>'` returned **0** on the 28,770 B sitemap — eShopKey wraps
   `<loc><![CDATA[…]]></loc>`. CDATA-aware extraction returned **133**; 133 + 52 blog = **185**,
   matching the recorded GSC `url_count`.
2. **Relative-vs-absolute `href`.** The first link extractor required `href="/el-gr/…"`; the site
   emits absolute `href="https://www.sanihellas.gr/el-gr/…"`. Result was **0 products across four
   category pages of 59–107 KB** — a zero from a non-empty source, treated as an instrument alarm,
   not a finding.
3. **Wrong aperture.** The corrected extractor scraped the whole document, so a cross-sell block
   made all four facet surfaces return an identical 5 products, and "brand-tagged: 14" was an
   artifact of tagging the same pages as both brands. The rendered `αποτελέσματα` count disproved
   it (`5` unfiltered vs `3` on `/nobo/`). Final extractor is scoped to `class="single-product"`
   grid blocks.

**Reconciliation — every count checked against the site's own rendered figure:**

| Category | site `αποτελέσματα` | grid parsed | NOBO facet | ATLANTIC facet | residue |
|---|---|---|---|---|---|
| `thermansi-thermopompoi` | 5 | 5 ✅ | 3 | 2 | 0 |
| `thermansi-aksesouar` | 9 | 9 ✅ | 5 | 3 | 1 Tonon |
| `thermansi-thermansi-loutrou` | 3 | 3 ✅ | — | 1 | 2 Tonon |
| `thermansi-thermansi-loutrou-1` | 4 | 4 ✅ | — | — | 4 Tonon |

**17 surfaces scanned OK, 0 errors** (count is scanned **minus** errors, not a loop counter).

## 2 — Inventory: 14 products (8 NOBO / 6 ATLANTIC) + 2 categories + 1 blog

### Core heaters — the revenue pages

| ProductId | Product | Brand | words | title ch | meta ch | θερμοπομπ* in | schema types |
|---|---|---|---|---|---|---|---|
| 823327 | Nobo NTL4T | NOBO | 1323 | 24 | 108 | meta, h2 | Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject |
| 965262 | Nobo NTL4R WiFi | NOBO | 1089 | 29 | **220 + emoji** | meta, h2 | same |
| 823322 | Nobo NTL2N | NOBO | 707 | 24 | 77 | meta, h2 | same |
| 823277 | Atlantic F119 DESIGN CE | ATLANTIC | 1192 | 37 | 162 | meta, h2 | + FAQPage, AggregateOffer |
| 965528 | Atlantic F120 WiFi Connect | ATLANTIC | 1542 | 40 | 160 | **h1**, meta, h2 | + FAQPage, AggregateOffer |

### Accessories + towel rail

| ProductId | Product | Brand | words | meta | schema |
|---|---|---|---|---|---|
| 823257 | Nobo Clip on Glass Anthracite | NOBO | 382 | 121 ch (dupe) | **NONE** |
| 823260 | Nobo Clip on Glass Retro Blue | NOBO | 387 | 121 ch (dupe) | Product |
| 823294 | Nobo Βάση Δαπέδου Fs 40 | NOBO | 297 | 79 ch | Product |
| 971036 | Καλώδιο Παροχής για Nobo | NOBO | 156 | boilerplate | Product |
| 979671 | Καλώδιο Παροχής Nobo NTL4R Wi-Fi | NOBO | 152 | boilerplate | Product |
| 971026 | Atlantic Σταθερή Βάση Δαπέδου | ATLANTIC | 220 | 182 ch unique | Product |
| 971027 | Atlantic Σχάρα Στήριξης Τοίχου | ATLANTIC | 213 | boilerplate | Product |
| 823255 | Άγκιστρο Πετσετοκρεμάστρας Atlantic | ATLANTIC | 148 | boilerplate | Product |
| 891227 | Atlantic RSS 2012 Anthracite (towel rail) | ATLANTIC | 472 | 60 ch | Product, WebPage |

### Category + blog

| Surface | words | meta | schema |
|---|---|---|---|
| `/el-gr/thermansi-thermopompoi/` — H1 «Θερμοπομποί» | 1590 | 161 ch, θερμοπομπ* in title+h1+meta+h2 | CollectionPage, FAQPage, ItemList, Organization, WebSite |
| `/el-gr/thermansi-aksesouar/` — H1 «Αξεσουάρ» | 313 | **site-wide default** | **0 blocks** |
| `/el-gr/blog/post/18567/…NOBO…` | 585 | 147 ch, θερμοπομπ* in title+h1+meta+h2 | Article, FAQPage, WebPage |

## 3 — Nine defects. DETECTED only; nothing edited, nothing staged, nothing published.

| # | Sev | Finding |
|---|---|---|
| C1 | 🔴 | **NTL4T/NTL4R slug collision, both locales.** `/thermopompos-nobo-ntl4t` serves **NTL4R WiFi** (965262); the real NTL4T is `/thermopompos-ntl4t` (823327). EN repeats it: `/en/heating-panel-heaters/nobo-ntl4t-panel-heater` → `<title>Nobo NTL4R WiFi`. Needs a slug change + 301 — platform-level, not content. |
| C2 | 🔴 | **Emoji in a live meta description.** 965262 carries `🛜`. eShopKey stores Windows-1253 → stores as `??`. Meta also 220 ch, over length. |
| C3 | 🔴 | **Boilerplate meta on 4 products** — byte-identical category string on 971027, 823255, 971036, 979671. Distinct from the site-wide-default fallback repaired 2026-08-08. |
| C4 | 🔴 | **`/thermansi-aksesouar/` category** carries the generic site-wide default meta and renders **0** JSON-LD. |
| C5 | 🔴 | **823257 renders zero structured data** while its near-identical sibling 823260 renders full `Product/Brand/Offer/Organization`. |
| C6 | 🟡 | **Duplicate meta pair** — 823257 and 823260 share one 121-char string. |
| C7 | 🔴 | **No `rel=canonical` on category templates** (verified on the category and both facet variants). Product templates do carry them. |
| C8 | 🔴 | **Brand-facet URLs are crawlable duplicates** — `/thermansi-thermopompoi/nobo/?lastselectionid=19789&pagesize=100` returns genuinely filtered content under the **same `<title>`** as the unfiltered category, with **no canonical**. `og:url` is emitted as a **relative path**, not absolute. |
| C9 | 🟡 | **EN locale absent from both sitemaps** (0 `/en/` URLs) though EN pages render. `/en/category/132676/` without `/ALL/` falls back to the Greek homepage. |
| C10 | ⚪ | **UNVERIFIED.** Token `Θερμοπομποι` (no tonos, not ALL-CAPS) appears 1–4× on eight pages. **Not** verified whether these sit inside ALL-CAPS headings, where omission is correct. Recorded as a lead, explicitly not as a defect. |

## 4 — Not done / owed

- **EN page-by-page inventory.** EN uses different slugs (`heating-panel-heaters/…-panel-heater`); only spot-probed. The EN cluster is real and unenumerated.
- **C10 context check.**
- **No traffic or ranking data was pulled.** This inventory carries structure, not performance — see the pair analysis, where that absence is the binding constraint.
