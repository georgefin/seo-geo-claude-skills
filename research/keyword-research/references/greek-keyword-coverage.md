# Greek Keyword Coverage: Diacritics, Greeklish, and GBP Mapping

Reference detail for Step 4 (Greek Dual-Coverage Expansion) and Step 10 (GBP Surface Mapping) of the main workflow. Applies whenever the target market or audience is Greek.

## Why It Matters

Greek search behavior fragments a single demand signal into multiple spellings:

- **Tonos-optional**: Many users type without diacritics (tonos) — mobile autocomplete, habit, and older input methods all drop accents.
- **Greeklish**: Latin-script transliteration is common on non-Greek keyboards, in the diaspora, and for brand recall (e.g., typing a brand name from memory).

Treated as separate keywords, these fragment volume and understate real demand. Treated as one cluster with careless placement, they produce spammy, duplicated, or unreadable copy. The dual-coverage pattern solves both.

## The 4-Form Pattern

| Form | Role | Rationale |
|------|------|-----------|
| (a) Accented Greek | The correct, native-reading form | What a literate Greek speaker expects to read |
| (b) Unaccented Greek | A search-matching variant only | Diacritic normalization in search matching is reliable — no separate content needed |
| (c) Greeklish | A search-matching + explicit-targeting variant | Normalization is weaker and less consistent than (a)↔(b) — needs deliberate targeting where it matters |
| (d) EN equivalent | A separate-audience variant | Serves bilingual, expat, or international-facing intent — not a substitute for (a) |

**Volume aggregation**: sum estimated/known volume across all 4 forms when scoring opportunity (Step 7) — they represent one underlying need.

**Placement**: only form (a) goes into visible on-page content. Forms (b)-(d) are covered through normalization, technical fields, and paid search — not through duplicate pages or stuffed text. Do not create one page per spelling variant; that is a thin-content/doorway-page pattern and a ranking risk, not a ranking strategy.

## Worked Examples

| Concept | (a) Accented Greek | (b) Unaccented Greek | (c) Greeklish | (d) EN equivalent |
|---------|--------------------|-----------------------|----------------|--------------------|
| Web development | κατασκευή ιστοσελίδων | κατασκευη ιστοσελιδων | kataskevi istoselidon | web development Athens |
| Plumber (local service) | υδραυλικός Αθήνα | υδραυλικος αθηνα | ydravlikos athina | plumber Athens |
| English tutoring | φροντιστήριο αγγλικών | φροντιστηριο αγγλικων | frontistirio agglikon | English tutoring school |
| Dentist | οδοντίατρος Θεσσαλονίκη | οδοντιατρος θεσσαλονικη | odontiatros thessaloniki | dentist Thessaloniki |
| Lawyer | δικηγόρος ακίνητα | δικηγορος ακινητα | dikigoros akinita | real estate lawyer |
| Car rental | ενοικίαση αυτοκινήτου | ενοικιαση αυτοκινητου | enoikiasi aftokinitou | car rental Greece |

## Where Each Form Belongs

- **Accented Greek (a)** — title tags, H1/H2, body copy, meta description, image alt text, GBP Products/Services descriptions, GBP Posts. This is the only form that should appear as prose.
- **Unaccented Greek (b)** — no dedicated placement. Do not write it into visible copy; it reads as a typo to native speakers and adds no ranking benefit search engines don't already provide by normalizing accented and unaccented forms as equivalent.
- **Greeklish (c)** — rarely placed in visible on-page copy (reads as unprofessional / spam-adjacent to native readers). Where it earns deliberate placement:
  - Domain names and URL slugs, especially legacy ones registered before Greek-script domains were practical
  - Brand name variants, social handles, app store listings
  - Paid search (Google Ads) keyword lists — bid on Greeklish variants explicitly, since organic normalization does not reliably connect a Greeklish query to an all-Greek-script page the way it connects accented-to-unaccented queries
  - GBP business name "also known as" / alternate spellings, where supported
- **EN equivalent (d)** — bilingual site sections, EN-language landing pages, tourist/expat/international-facing content. Not a placement for (a)-(c); it targets a genuinely different audience segment.

**Anti-pattern to avoid**: stuffing multiple spelling variants into a meta keywords tag or as hidden/near-invisible text. The meta keywords tag is ignored by Google; hidden-text variant stuffing is a spam violation. Correct coverage comes from one clean accented-Greek page plus the technical/paid-search levers above — not from more text on the page.

## Greeklish Transliteration Quick Reference

Common renderings for letters that create the most keyword-variant fragmentation:

| Greek | Common Greeklish | Notes |
|-------|-------------------|-------|
| η, ι, υ | i | All three often collapse to "i" — biggest source of Greeklish ambiguity |
| θ | th (informal: 8) | "8" appears in casual chat-speak, rarely in search queries |
| χ | x, h, ch | Varies by user; "x" and "ch" both common |
| ξ | ks, x (informal: 3) | "3" is chat-speak, low SEO priority |
| ω, ο | o | Both collapse to "o" |
| β | v (occasionally b) | "v" dominant |
| ου | ou | Digraph, stable |
| μπ | b, mp | Both seen at word-start ("μπάρα" → "bara"/"mpara") |
| ντ | d, nt | Both seen ("ντομάτα" → "domata"/"ntomata") |

Practical implication: when generating Greeklish forms for paid search or domain checks, generate 2-3 plausible variants per keyword (e.g., both "x" and "h" for χ) rather than assuming one canonical spelling — Greeklish has no single standard.

## GBP Surface Mapping (Local Intent)

Extends Step 10. Local-intent keywords should map to a GBP surface in addition to a website page — GBP fields are indexed and surface directly in Maps and the Local Pack.

| Local-Intent Keyword Type | Example | Primary GBP Surface | Companion Website Surface |
|----------------------------|---------|----------------------|-----------------------------|
| Service + city/area | υδραυλικός Αθήνα (plumber Athens) | Products/Services description | Service or location page |
| Proximity ("near me") | κοντινό φαρμακείο (nearby pharmacy) | Categories + attributes, verified address | Store locator page |
| Question queries | πόσο κοστίζει... (how much does it cost) | Q&A — seed the top 3-5 proactively | FAQ section / FAQ schema |
| Time-sensitive / offers | ανοιχτά Κυριακή (open Sunday) | Posts | Homepage banner |
| Brand + Greeklish | [brand] kataskevi | Business name / alternate spelling field | Domain, meta title |

### GBP Content Cadence

- **Posts** expire (event/offer post types typically stop showing after about a week) — treat as a recurring task, not a one-time setup.
- **Q&A** is public and anyone can answer, including incorrectly — seed accurate answers to the top 3-5 expected questions before users or competitors post wrong ones.
- **Products/Services descriptions** are evergreen — write them like mini landing pages, with the accented-Greek target keyword naturally in the first sentence.

## Quick Checklist

- [ ] Every Greek seed keyword expanded to all 4 forms
- [ ] Volumes aggregated across forms for opportunity scoring (Step 7), not treated as 4 separate keywords
- [ ] Only accented Greek used in visible copy (titles, H1s, body, meta, alt text)
- [ ] Unaccented Greek left to search-engine normalization — not written into content
- [ ] Greeklish captured in domains, brand variants, and paid search bids — not stuffed into body text
- [ ] Local-intent keywords mapped to at least one GBP surface, alongside their website page
