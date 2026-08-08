# Schema Type Decision Tree

Guidelines for selecting the ONE primary schema type a page needs, what to nest inside it, and when a documented auxiliary type is justified.

**Ground rule (settled ruling R2, CORE-EEAT O05)**: one accurate primary content type per page. Supporting entities are nested properties of that type, not separate top-level objects. A second top-level type is legitimate only when it has its own engine-documented, non-citation job and the page data warrants it. Adding types because "more schema = more AI citations" is citation-lever stacking — banned: no engine documents a citation gain from extra types, and every extra type adds maintenance surface and content-mismatch (spam-policy) risk.

---

## Primary Type by Content

Pick the ONE row that matches the page. The "Nest Inside It" column lists entities that belong as properties of the primary — they are not additional page-level types.

| Your Content | Primary Type (one per page) | Nest Inside It | SERP Note |
|-------------|-----------------------------|----------------|-----------|
| Blog post / article | Article / BlogPosting | author (Person), publisher (Organization + logo), image | Article rich result (date, author) |
| Product page | Product | offers (Offer), brand, aggregateRating, review | Price/rating snippet |
| Service page | Service | provider (Organization/LocalBusiness), areaServed, offers | No dedicated rich result; accurate type still aids entity understanding |
| How-to guide | HowTo | step, totalTime, supply, tool | How-to rich result with steps |
| FAQ page | FAQPage | mainEntity (Question → acceptedAnswer) | None — FAQ rich results retired 2026; type kept for AI-engine/GEO parsing (ruling R3) |
| Recipe | Recipe | recipeIngredient, recipeInstructions, nutrition, aggregateRating | Recipe carousel |
| Event | Event | location (Place + PostalAddress), offers, organizer (Organization) | Event snippet with date/location |
| Video page | VideoObject | thumbnailUrl, duration, interactionStatistic | Video carousel, key moments |
| Local business page | LocalBusiness (or subtype: Restaurant, HVACBusiness, ...) | address (PostalAddress), geo, openingHoursSpecification, review | Local pack, knowledge panel |
| Author/person page | Person | affiliation (Organization), sameAs | Knowledge panel |
| Homepage | Organization (or WebSite) | contactPoint, logo, sameAs | Knowledge panel |
| Course page | Course | provider (Organization), hasCourseInstance | Course rich result |
| Job posting | JobPosting | hiringOrganization, jobLocation | Google for Jobs listing |
| Software/app page | SoftwareApplication | offers, aggregateRating, operatingSystem | App snippet |

**"Should it be X or Y — or both?"** Pick the one type that matches what the page IS, and nest the other entity inside it (a workshop page is an Event with the studio nested as `organizer` — not Event + Organization side by side). Two content types as co-primaries are justified only if the page genuinely is both things and each type is complete, accurate, and independently justified.

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
| Invalid date format | Warning, may lose rich result | Use ISO 8601: "2026-02-11" |
| Incorrect @type | Schema misinterpreted | Match @type exactly to schema.org |
| Self-referencing sameAs | Warning | sameAs should link to EXTERNAL profiles |
| Missing image for Article | Loses article rich result | Add image property with valid URL |
| Review without itemReviewed | Review not connected | Nest review inside Product/Service/etc. |
| Second full content type on the page | Citation-lever stacking (ruling R2) — spam-policy risk, no citation gain | Keep ONE primary; nest the entity or drop the extra type |
