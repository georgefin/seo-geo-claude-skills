# Schema Type Decision Tree

Guidelines for selecting the ONE primary schema type a page needs, what to nest inside it, and when a documented auxiliary type is justified.

**The value rule (applies to every example in this file and to anything generated from it)**: a JSON-LD block handed to a user carries resolved values only. A property whose value cannot be sourced from the page is dropped from the block and named in the report prose — never filled with an invented value or an unbracketed stand-in. Bracket tokens (`[LATITUDE]`) belong only in a block explicitly labelled a skeleton. Full rule: SKILL.md step 2, *Missing data — the value rule*.

**Ground rule (settled ruling R2, CORE-EEAT O05)**: one accurate primary content type per page. Supporting entities are nested properties of that type, not separate top-level objects. A second top-level type is legitimate only when it has its own engine-documented, non-citation job and the page data warrants it. Adding types because "more schema = more AI citations" is citation-lever stacking — banned: no engine documents a citation gain from extra types, and every extra type adds maintenance surface and content-mismatch (spam-policy) risk.

---

## Primary Type by Content

Pick the ONE row that matches the page. The "Nest Inside It" column lists entities that belong as properties of the primary — they are not additional page-level types.

| Your Content | Primary Type (one per page) | Nest Inside It | SERP Note |
|-------------|-----------------------------|----------------|-----------|
| Blog post / article | Article / BlogPosting | author (Person), publisher (Organization + logo), image | Article rich result (date, author) |
| Product page | Product | offers (Offer), brand, aggregateRating, review | Price/rating snippet |
| Service page | Service | provider (Organization/LocalBusiness), areaServed, offers | No dedicated rich result; accurate type still aids entity understanding |
| How-to guide | HowTo | step, totalTime, supply, tool | Unconfirmed — see the [VERIFY] note below; claim no How-to appearance |
| FAQ page | FAQPage | mainEntity (Question → acceptedAnswer) | None — no FAQ rich result for ordinary sites — government/health only, Aug 2023; type kept because it stays valid and Google says there is no need to proactively remove it (ruling R3 + amendment 9a — a permission to leave it, not advice to keep it; no evidenced citation benefit either way) |
| Recipe | Recipe | recipeIngredient, recipeInstructions, nutrition, aggregateRating | Recipe carousel |
| Event | Event | location (Place + PostalAddress), offers, organizer (Organization) | Event snippet with date/location |
| Video page | VideoObject | thumbnailUrl, duration, interactionStatistic | Video carousel, key moments |
| Local business page | LocalBusiness (or subtype: Restaurant, HVACBusiness, HomeAndConstructionBusiness, ...) | address (PostalAddress), geo, openingHoursSpecification, review | Corroborates the business entity — see the [VERIFY] note below; claim no local-pack placement |
| Author/person page | Person | affiliation (Organization), sameAs | Knowledge panel |
| Homepage | Organization (or WebSite) | contactPoint, logo, sameAs | Knowledge panel |
| Course page | Course | provider (Organization), hasCourseInstance | Course rich result |
| Job posting | JobPosting | hiringOrganization, jobLocation | Google for Jobs listing |
| Software/app page | SoftwareApplication | offers, aggregateRating, operatingSystem | App snippet |

**Reading the SERP Note column**: it names the appearance a correctly-marked page becomes *eligible* for where one is offered. None of them is a guarantee — Google decides per query and per device — and two rows are open questions rather than facts:

- `[VERIFY]` **How-To** — a 2023-08-08 Google Search Central post (title: "Changes to HowTo and FAQ rich results"; its FAQ half is superseded here by ruling R3, which has FAQ retired outright) is quoted as taking How-to results desktop-only and then dropping them "as of September 13", with the How-to report and Rich Results Test support withdrawn. Search-snippet grade over the primary domain (2026-08-10), not owner-read; no ruling has issued (WATCH-ITEMS W12 → gated item G9). Keep generating HowTo for genuinely step-by-step pages; promise no appearance either way.
- `[VERIFY]` **LocalBusiness** — this file previously read "Local pack, knowledge panel" with no source behind it. Local-pack placement is widely attributed to the business's Google Business Profile rather than to page JSON-LD, but no Google-primary source is on file that either supports or refutes the old line (searched 2026-08-10, none found), and flatly asserting the reverse would repeat the unsourced move. What the markup demonstrably does is corroborate name, address, phone and hours for entity understanding; say that, and promise no placement.

**"Should it be X or Y — or both?"** Pick the one type that matches what the page IS, and nest the other entity inside it (a workshop page is an Event with the studio nested as `organizer` — not Event + Organization side by side). Two content types as co-primaries are justified only if the page genuinely is both things and each type is complete, accurate, and independently justified.

### Key Properties at a Glance (moved from SKILL.md)

The two or three properties that identify each type, for recognising a mis-typed page quickly.
They are a lookup, not a required-property list — what a type actually requires is in
[validation-guide.md](./validation-guide.md), and a property with no value on the page is dropped
rather than filled.

BlogPosting/Article — `headline`, `datePublished`, `author` · Product — `name`, `price` (inside
`offers`), `availability` · FAQPage — `Question`, `Answer` · HowTo — `step`, `totalTime` ·
LocalBusiness — `address`, `geo`, `openingHours` · Recipe — `recipeIngredient`, `cookTime` ·
Event — `startDate`, `location` · VideoObject — `uploadDate`, `duration` · Course — `provider`,
`name` · Review — `itemReviewed`, `ratingValue`.

---

## Documented Auxiliary Types

These may accompany the primary as a second top-level object — each has its own documented, non-citation job. Add them only when the page data actually exists:

| Auxiliary | Add When | Documented Job |
|-----------|----------|----------------|
| BreadcrumbList | The page has a real breadcrumb trail | Google-documented site-structure feature (breadcrumb display) |
| WebSite | Homepage only | Declares the site entity |
| Organization / Person (top-level) | Only on the entity's own page (homepage, author page); elsewhere nest as publisher/author/organizer | Identity, knowledge panel |

Never add: a second full content type (FAQPage on a service page, Article + Product both as primaries). That is stacking, not auxiliary markup.

---

## Industry Starting Points

Primary type per page across a typical site — NOT a list of types to combine on one page. Add BreadcrumbList wherever a real trail exists.

| Industry | Typical Pages → Primary Type |
|----------|------------------------------|
| E-commerce | Product pages → Product; category/list pages → ItemList; homepage → Organization |
| SaaS | Product/landing pages → SoftwareApplication; docs and guides → Article or HowTo; pricing FAQ → FAQPage |
| Local services | Location/contact pages → LocalBusiness subtype; service pages → Service |
| Publishing/media | Articles → Article/NewsArticle; author pages → Person; homepage → Organization |
| Education | Course pages → Course; homepage → Organization |
| Healthcare | Practice/clinic pages → MedicalClinic or Physician; condition articles → MedicalWebPage |
| Real estate | Listing pages → RealEstateListing; office pages → LocalBusiness |
| Restaurants | Homepage/location pages → Restaurant; menu page → Menu |

---

## Implementation Priority

| Priority | What | Why |
|----------|------|-----|
| P0 — Foundation | Organization or WebSite on the homepage; BreadcrumbList on pages with a real trail | Site identity + documented structure features |
| P1 — Content pages | The ONE primary content type per page (Article, FAQPage, HowTo, Product, Event, ...) | CORE-EEAT O05: correct JSON-LD matching content type |
| P2 — Commercial completeness | Complete nested commerce data: offers.price, priceCurrency, availability; aggregateRating where genuine reviews exist | Price/rating display requires complete nested properties |
| P3 — Identity completeness | Nested author/publisher (Person/Organization) with external sameAs links | E-E-A-T identity disambiguation |
| P4 — Specialized | Industry-specific primary types (JobPosting, Course, Recipe, ...) | Niche features |

---

## Schema Validation Quick Reference

| Issue | Impact | Fix |
|-------|--------|-----|
| Missing required property | Schema ignored by Google | Add all required fields (check schema.org) |
| Invalid date format | Warning, may lose rich result | Use ISO 8601 at the page's own precision: "2026-02-11" when no time is shown; "2026-02-11T09:00:00+02:00" when it is |
| Incorrect @type | Schema misinterpreted | Match @type exactly to schema.org |
| Self-referencing sameAs | Warning | sameAs should link to EXTERNAL profiles |
| Missing image for Article | Loses article rich result | Add image property with valid URL |
| Review without itemReviewed | Review not connected | Nest review inside Product/Service/etc. |
| Second full content type on the page | Citation-lever stacking (ruling R2) — spam-policy risk, no citation gain | Keep ONE primary; nest the entity or drop the extra type |
