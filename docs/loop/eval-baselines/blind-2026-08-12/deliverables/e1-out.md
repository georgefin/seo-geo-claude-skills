# Entity Optimization Report — Pharos Marine Data

**Prepared for:** Marketing Lead, Pharos Marine Data (pharosmarine.example)
**Audit date:** 2026-08-12
**Observation date for every finding below:** 2026-08-06 (the date all three files were hand-checked and pasted)

---

## 0. Scope — what this audit is built from, and what it is not

Three files, all hand-pasted on 2026-08-06. No tool is connected in this session: no crawler, no schema
validator, no rank tracker, no brand monitor, no Knowledge Graph API, no AI-monitoring tool.

| Input | What it settles |
|---|---|
| `evals/files/about-page-pharos-el.md` | The EL and EN company-page copy, the contact blocks, the shared footer, the team block, the blog by-line convention |
| `evals/files/schema-markup-pharos-current.md` | Every JSON-LD block that ships today; a hand-check of each `sameAs` URL; a dated Wikidata search |
| `evals/files/entity-profiles-inventory-pharos.md` | Name/address/phone/description string-by-string across 12 surfaces; profile existence and back-links; Google Business Profile detail; the ΓΕΜΗ publicity extract |

**Not supplied, therefore not assessed anywhere in this report:** any branded-SERP capture, any AI-assistant
test, any brand-mention or press-coverage log, any backlink or referring-domain data, any search-volume,
impression or click data, any `robots.txt` read, any subdomain inventory. Every signal these would have
settled is *excluded and named*, never scored as a failure — scoring a ❌ would claim someone looked.
Section 11 lists all of them with the input that would close each.

---

## 1. Entity Profile

**Entity Name**: the audit's own finding is that there is no single answer to this today — see §4. The
registry strings are `ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΔΙΩΤΙΚΗ ΚΕΦΑΛΑΙΟΥΧΙΚΗ ΕΤΑΙΡΕΙΑ` (επωνυμία) and
`PHAROS MARINE DATA` (διακριτικός τίτλος), per the ΓΕΜΗ extract printed 2026-08-06.
**Entity Type**: Organization (ΙΚΕ / private capital company, ΓΕΜΗ 158234701000)
**Primary Domain**: pharosmarine.example
**Target Topics**: voyage fuel analytics; dry-bulk and tanker fleet operations; maritime software
(taken from the descriptions the company itself publishes on LinkedIn, YouTube, the Green Corridors EU
member entry and the Google Business Profile — not chosen by me)

### Current Entity Presence

| Platform | Status | Details |
|----------|--------|---------|
| Google Knowledge Panel | **Not checked** | No branded-SERP capture was supplied. Settled by: a dated, logged-out capture of `Pharos Marine Data`, «Φάρος» and `Faros`, with location and device recorded |
| Google Business Profile | ⚠️ Claimed, incomplete | Claimed and verified. Primary category *Software company*; **no secondary category**. 6 reviews, average 4,7, last one 2026-03-18; **0 of 6 answered**. Posts: none ever. Q&A: none seeded. Products/Services: empty. Photos: 3, all uploaded 2019. (Opened 2026-08-06) |
| Wikidata | ❌ Not listed | Searched 2026-08-06 on four strings — `Pharos Marine Data`, `Faros Marine`, «Φάρος Ναυτιλιακή Πληροφορική», and the ΓΕΜΗ number. No item for this company. **QID: none exists.** Items do return for the ancient lighthouse and unrelated organisations |
| Wikipedia | ❌ Absent | No article, and no mention of the company inside any existing article (checked 2026-08-06). The notability arm of this signal is *not* assessable from these three files — no coverage inventory was supplied |
| Google Knowledge Graph API | **Not checked** | No API response supplied. Entity ID, types and `resultScore` left empty deliberately — inventing any of the three is the single easiest way for this report to become unusable |
| Schema.org on site | ⚠️ Partial | Two `Organization` blocks, on 2 of 38 pages. They contradict each other on name, address, phone and founding year; neither carries an `@id`; the English page carries no JSON-LD at all. `sameAs` contains three URLs that are false (§5) |

### AI Entity Resolution Test

**No AI system was tested for this audit, so this table has no rows.** Claude cannot query ChatGPT,
Perplexity or Google AI Overview, and cannot run a live web search, without tool access — and no such
tool is connected here. A row per untested system, left blank "to fill in later", would read to the
investor as a check that was run and came back empty, which is a different and much worse claim than
"not run".

To close this gap before the diligence pack goes out, run each of these once per system, logged out,
and record the answer verbatim with the date:

1. "What is Pharos Marine Data?"
2. «Τι είναι η Φάρος Ναυτιλιακή Πληροφορική;»
3. "Who founded Pharos Marine Data?"
4. "Pharos Marine Data vs [the vendor you lose deals to most often]"

Query 2 is the one that matters most here, for the reason in §5: the company's own markup currently
tells every machine that reads it that the company *is* a different entity.

---

## 2. Signal Category Summary

Scored ✅ 1 · ⚠️ 0.5 · ❌ 0 over each category's own signals, `points ÷ signals scored`, printed to one
decimal. **Strong** ≥ 80%, **Gaps** 40–80%, **Missing** < 40%; a boundary value takes the higher status.
Signal numbers are those of `references/entity-signal-checklist.md`. A signal nothing in these three
files can settle is excluded from both sides and named — never scored ❌.

| Category | Status (points ÷ scored = %) | Key Findings |
|----------|------------------------------|--------------|
| Structured Data | ❌ **Missing** — 0.5 of 3 scored = 16.7% | Homepage `Organization` has name, url and logo but **no `description`** (⚠️ s1); `sameAs` ships three URLs that are false, one of them asserting identity with a different entity (❌ s2); **no `@id` anywhere**, and the two blocks disagree, so nothing ties them to one entity (❌ s3). Signal 47 excluded — no subdomain inventory supplied |
| Knowledge Base | ❌ **Missing** — 1.5 of 5 scored = 30.0% | No Wikidata item on a four-string dated search (❌ s6); LinkedIn company page complete and active, post 2026-07-28 (✅ s8); Crunchbase 404, never created (❌ s9); directory presence exists but every listing carries a defect — vrisko.gr the dead phone, xo.gr a transliterated name, Green Corridors EU correct but with an empty link field (⚠️ s10); no Wikipedia article and no mention in one (❌ s17 — see the caveat in §11). Eight excluded: 14, 15, 16 (no SERP capture, so panel status unknown), 18 and 38 (no item to review), 39 (dbpedia.org not searched), 40 (no KG API response), 41 (ISNI/VIAF is a person identifier — not applicable to an ΙΚΕ) |
| Consistency (NAP+E) | ❌ **Missing** — 1.5 of 4 scored = 37.5% | Contact details are published in two irreconcilable versions and 3 of 7 surfaces carry a phone line that has not rung since March 2023 (⚠️ s5, §4.2); **five different name strings on the company's own surfaces** (❌ s35, §4.1); LinkedIn and Facebook link both ways, YouTube links to the site but the site does not list YouTube, and the site links to an X account that was never registered (⚠️ s42); the social bios share a core on LinkedIn and YouTube but Facebook publishes a generic category line instead (⚠️ s43) |
| Content-Based | ⚠️ **Gaps** — 1.5 of 3 scored = 50.0% | The EL company page opens on a belief statement, not a definition — the entity-defining sentence is in paragraph 2, and the EN page's version of it contradicts it (⚠️ s4); no author pages, no by-lines, every post signed «Ομάδα Φάρος», no `Person` markup anywhere (❌ s25); the entity is named naturally through body copy, not only in the chrome (✅ s27). Five excluded: 11 (no SERP capture), 24 (38 CMS pages total, but no breakdown by topic), 26 (nothing states whether original research exists), 45 and 46 (no link data of any kind) |
| Third-Party | ⚠️ **Gaps** — 0.5 of 1 scored = 50.0% | **This status rests on a single signal and should be read as "not yet assessed" rather than as a result.** Reviews exist on one platform — 6 on the Google Business Profile at 4,7 — and no G2/Trustpilot/industry-platform data was supplied (⚠️ s23). Six excluded: 13 (no search-volume figure has ever been pulled), 19, 20, 21, 22 (no mention, award, co-citation or speaking data supplied), 44 (last-activity dates only, no engagement metrics). A dated coverage/mention log would move five of these six in one step |
| AI-Specific | ⚠️ **Gaps** — 1.5 of 3 scored = 50.0% | The EN first paragraph is quotable and self-contained but carries two facts the ΓΕΜΗ extract refutes; the EL page's is accurate but is not the first paragraph (⚠️ s33); the company's Greek-side claims check out against the registry while the English page's city and founding year are refuted by it (⚠️ s34); the EN company page has not been touched since 2024, past the six-month line, and no last-modified date was supplied for the EL page (⚠️ s37). Seven excluded: 12 (no SERP capture), 28, 29, 30, 31, 32 (no AI system was queried), 36 (`robots.txt` not read) |
| Google Business Profile | ❌ **Missing** — 1.5 of 7 scored = 21.4% | Claimed and verified but incomplete (⚠️ s7); completeness ❌ (no Posts, no Q&A, empty Products); category accuracy ⚠️ (primary *Software company* is accurate but generic; **no secondary category**); surface activity ❌ (nothing ever published on any of the three surfaces); photo freshness ❌ (3 photos, all 2019 — seven years old); review velocity ⚠️ (6 lifetime, none since 2026-03-18); response rate ❌ (**0 of 6**). Nothing excluded — every GBP check was settled by the 2026-08-06 read |

---

## 3. Critical Issues

**C1 — The site's structured data asserts that the company is the Lighthouse of Alexandria.** The homepage
`sameAs` list contains `https://el.wikipedia.org/wiki/Φάρος_της_Αλεξάνδρειας`. `sameAs` is an identity
claim; this one hands every machine that parses the homepage an explicit statement that this company and
that monument are the same thing. Two of the other four entries are false in a cheaper way — the X handle
was never registered ("This account doesn't exist") and the Crunchbase URL 404s. Of five published
identity assertions, **two open and resolve to us, three do not** (enumerated in §5). This is the one
finding on the list that actively damages the entity rather than merely failing to help it, and it is a
deletion, not a project.

**C2 — Two `Organization` blocks, no `@id`, and they disagree.** The homepage block says the name is
`Pharos`; the company-page block says `Φάρος Ναυτιλιακή Πληροφορική ΙΚΕ`. One has a logo and `sameAs` and
no address; the other has an address, a phone and a `foundingDate` and no logo or `sameAs`. Neither
carries an `@id`, so there is no assertion anywhere that these are the same organisation. A consumer
reading both pages has been handed two organisations, and the 36 pages that carry no JSON-LD are attached
to neither.

**C3 — A dead telephone number is published on three surfaces.** The line ending **251** stopped reaching
the company when the provider changed in **March 2023**; it rings out. It is currently published on the
English about page, in the company-page JSON-LD, and on the vrisko.gr listing (3 of the 7 surfaces that
publish a phone — §4.2). For a company mid-raise, this is also a diligence artefact: an investor who dials
the number on the English page gets nothing.

**C4 — The company publishes two different founding years and two different cities.** English page:
"Athens-based … founded in 2018". Greek page: «ιδρύθηκε το 2019 στον Πειραιά». The ΓΕΜΗ extract printed
2026-08-06 gives *Ημερομηνία σύστασης 14/03/2019* and *Έδρα Ακτή Μιαούλη 47, Πειραιάς*. The Greek page
agrees with the registry; the English page and the company-page JSON-LD (`"foundingDate": "2018"`) do not.

**C5 — The English page is the company's front door for non-Greek readers and is the least accurate
surface it owns.** It was written by a copywriter in 2024, has not been touched since, carries the wrong
city, the wrong founding year, the wrong street number and the dead phone line, and it is the one page
with no JSON-LD at all.

**C6 — No Wikidata item and no Wikipedia article** (both checked 2026-08-06). Wikidata is the item to
create because it is the entity surface the company can edit directly; see the ruling in §7 for what may
and may not be promised about it.

---

## 4. Where the identity is inconsistent

The counts below are built by enumeration — the rows carrying each value are listed, then the list is
counted, then the per-value counts are reconciled against the population size. **Each figure has exactly
one population and the populations are never merged**, because "how many ways do we write our name" has
three genuinely different answers depending on whether you mean the surfaces the company controls
directly, the profiles it owns off-site, or the listings other parties created.

### 4.1 Name strings

**Population A — name strings on the company's own web surfaces.** Inventory Table 1, rows 1–5, swept
against the about-page paste (same surfaces, full text).

| Name string, character-for-character | Rows / surfaces carrying it | n |
|---|---|---|
| `Φάρος` | inv. row 1 (header logo + H1 area); about-EL body ¶1 | 1 |
| `ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΚΕ` | inv. row 2 (contact block + shared footer legal line); about-page footer | 1 |
| `Pharos Marine Data P.C.` | inv. row 3 (site EN /en/about); about-EN ¶1 | 1 |
| `Pharos` | inv. row 4 (homepage JSON-LD `name`) | 1 |
| `Φάρος Ναυτιλιακή Πληροφορική ΙΚΕ` | inv. row 5 (company-page JSON-LD `name`); about-EL body ¶2 | 1 |

**5 distinct strings over 5 surfaces.** Reconciliation: 1+1+1+1+1 = 5 = population size ✓.

*Folding pass:* if an all-caps and a title-case rendering of the same Greek words are treated as one name
written two ways, rows 2 and 5 fold together and the figure is **4 distinct strings**. Both passes are
given because the convention has to be chosen before the number means anything; this report's default is
the unfolded count, since the two renderings sit on the same page (footer vs JSON-LD) and a machine reading
them does not fold.

*Exclusion shown as its own step:* start 6 candidate strings on own surfaces; **−1 «Ομάδα Φάρος»** (blog
by-line signature, an author string rather than a company-name field) **→ 5**. It is excluded from the
count and flagged separately in §8, because a by-line that names no person is also why signal 25 fails.

**Population B — name strings on off-site profiles the company owns.** Inventory Table 1, rows 6–9.

| Name string | Rows | n |
|---|---|---|
| `Pharos Marine Data` | row 6 (LinkedIn), row 8 (Google Business Profile), row 9 (YouTube) | 3 |
| `Pharos Marine` | row 7 (Facebook) | 1 |

**2 distinct strings over 4 profiles.** Reconciliation: 3+1 = 4 ✓. This population is the closest thing
the company already has to a working convention, and it matches the ΓΕΜΗ διακριτικός τίτλος.

**Population C — name strings on listings created by third parties.** Inventory Table 1, rows 10–12.

| Name string | Row | n |
|---|---|---|
| `ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΚΕ` | row 10 (vrisko.gr) | 1 |
| `Φάρος Μαρίν Ντέιτα` | row 11 (xo.gr) | 1 |
| `Pharos Marine Data PC` | row 12 (Green Corridors EU) | 1 |

**3 distinct strings over 3 listings.** Reconciliation: 1+1+1 = 3 ✓. xo.gr has transliterated the Latin
trading name back into Greek characters — a fourth way of writing the name that exists nowhere else.

**Population D — the registry.** ΓΕΜΗ extract, printed 2026-08-06: `ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΔΙΩΤΙΚΗ
ΚΕΦΑΛΑΙΟΥΧΙΚΗ ΕΤΑΙΡΕΙΑ` (επωνυμία) and `PHAROS MARINE DATA` (διακριτικός τίτλος) — **2 strings**.

**The finding that falls out of D:** the registered επωνυμία spells the legal form out in full, and **no
surface the company owns carries that string** — every one of them abbreviates to `ΙΚΕ`. Separately, the
registered Latin name is `PHAROS MARINE DATA`, which means the Latin form is not a style choice to be
argued about internally: it is on the registry, and Population B is already using it.

### 4.2 Address and telephone

**Population — surfaces in inventory Table 1 that publish a street address:** rows 2, 3, 5, 7, 8, 10, 11 = 7.

| Value | Rows | n |
|---|---|---|
| `Ακτή Μιαούλη 47` (incl. `47` in Latin transcription) | 2, 7, 8, 10, 11 | 5 |
| `Ακτή Μιαούλη 45` / `45 Akti Miaouli` | 3, 5 | 2 |

Reconciliation: 5+2 = 7 ✓. The ΓΕΜΗ extract (separate population — the registry) gives **Ακτή Μιαούλη 47**.
So the two surfaces publishing 45 are the site's English page and the company-page JSON-LD, and both are
wrong against the registry.

**Population — surfaces in inventory Table 1 that publish a phone:** rows 2, 3, 5, 7, 8, 10, 11 = 7.

| Line | Rows | n |
|---|---|---|
| ends **250** (live) | 2, 7, 8, 11 | 4 |
| ends **251** (dead since March 2023) | 3, 5, 10 | 3 |

Reconciliation: 4+3 = 7 ✓.

*Formatting, counted separately because it is a different question:* the same 7 rows publish **5 distinct
phone strings** — `+30 210 4177 250` (rows 2, 7, 8) → 3; `210 4177 250` (row 11) → 1; `+30 210 417 7251`
(row 3) → 1; `+30 210 4177 251` (row 5) → 1; `210 4177 251` (row 10) → 1. Reconciliation: 3+1+1+1+1 = 7 ✓.
Note that row 3 groups the digits differently again (`417 7251`), so even the two surfaces that agree on
the wrong number do not agree on how to write it.

### 4.3 Founding year

**Population — surfaces in inventory Table 1 that state a founding year:** rows 3, 5, 6 = 3.

| Value | Rows | n |
|---|---|---|
| 2018 | 3 (site EN), 5 (company-page JSON-LD) | 2 |
| 2019 | 6 (LinkedIn) | 1 |

Reconciliation: 2+1 = 3 ✓. Two further statements sit outside this population and are reported under their
own: the **EL company page body** states 2019 (about-page paste, and repeated in the note under inventory
Table 1), and the **ΓΕΜΗ extract** gives *14/03/2019*. The registry is the reference the other four are
measured against, and it agrees with the Greek page and LinkedIn.

### 4.4 Description

Six surfaces publish a description line, and no two are identical: LinkedIn *"Voyage fuel analytics for
dry-bulk and tanker operators."* · YouTube *"Pharos Marine Data — voyage fuel analytics."* · Google
Business Profile *"Fuel analytics software for ship managers."* · Green Corridors EU *"voyage fuel
analytics"* · Facebook «Ναυτιλιακή τεχνολογία» · site EN *"an Athens-based maritime software company"*.
Four of the six share a recognisable core ("voyage fuel analytics"); Facebook publishes a generic sector
label, and the English page publishes a description whose only distinguishing fact — the city — is wrong.

---

## 5. Decision: the `sameAs` list

`sameAs` is a claim of identity, so every entry is either true or a published falsehood; there is no
neutral middle. Στέλιος hand-opened all five on 2026-08-06, so this is a settled question and needs no
further checking.

**Population — `sameAs` entries published on the homepage today:** 5.

| Entry | What opened on 2026-08-06 | Ruling |
|---|---|---|
| `linkedin.com/company/pharos-marine-data` | The company's LinkedIn page, active | **KEEP** |
| `facebook.com/pharosmarinedata` | The company's Facebook page, last post 2021-11-03 | **KEEP.** Dormancy is not falsity — the page is ours and it resolves to us. Removing it removes a true identity assertion; the dormancy is a separate, lower-priority question |
| `twitter.com/pharosmarine` | "This account doesn't exist." Handle never registered | **REMOVE.** Do not register the handle in order to save the entry — decide the account on its merits, and let `sameAs` follow reality rather than lead it |
| `crunchbase.com/organization/pharos-marine-data` | 404. Profile never created | **REMOVE now; re-add only if and when the profile exists.** Creating a Crunchbase profile is a reasonable roadmap item for a company raising a seed round; the URL enters the markup on the day the profile is live, not before |
| `el.wikipedia.org/wiki/Φάρος_της_Αλεξάνδρειας` | The Greek Wikipedia article on the ancient Lighthouse of Alexandria | **REMOVE — do this first.** This is not a broken link, it is a true statement about a *different* entity being published as a statement about this one. A dead URL asserts nothing; this one actively merges the company with the monument it is already competing with for its own name |

Enumeration: 2 keep, 3 remove. Reconciliation: 2+3 = 5 ✓.

**Missing from the list, and addable today:** the YouTube channel
(`youtube.com/@pharosmarinedata`) — it exists, it is the company's, and it already links back to the site,
so it is a true assertion the markup is not making. That is 1 addition.

**Not addable today:** the Wikidata URL, because no item exists (searched 2026-08-06 on four strings). It
enters `sameAs` on the day the item exists — the same rule as Crunchbase.

**Conditional:** the Green Corridors EU member entry. If that entry has its own stable per-member URL it
qualifies as a `sameAs` target; the inventory records the entry's existence and that its link field back to
the site is empty, but records no URL for it. Check the URL, then decide.

**Resulting list after the ruling** — 3 entries, all of which open and resolve to this company:

```json
"sameAs": [
  "https://www.linkedin.com/company/pharos-marine-data",
  "https://www.facebook.com/pharosmarinedata",
  "https://www.youtube.com/@pharosmarinedata"
]
```

A three-entry list that is entirely true is worth more to the diligence pack than a five-entry list that is
60% false, and it is the honest answer to "how does the market identify you": today, partly as a monument.

---

## 6. Decision: the previous consultant's two structured-data lines

Στέλιος asked for a ruling before he touches the templates. Here is one for each line, with the reasoning
attached so he can act without re-litigating it.

### Line 1 — "FAQPage, Product, LocalBusiness and Article on every page; the more types a page carries, the more likely AI engines are to cite it"

**Ruling: do not implement. Reject the premise, and reject the instruction even where the premise is set
aside.**

*The premise.* Nothing in the three files measures this, and no AI vendor publishes how it weights a
source or what makes it cite one page over another. A recommendation whose entire justification is an
unpublished mechanism cannot be checked by you, cannot be checked by me, and would go into an investor
diligence pack as a claim the company cannot support. If the consultant has a dated measurement behind it,
ask for it; absent that, it is an assertion.

*The instruction, on its own terms.* Schema types are claims about what a page **is**. Putting all four on
all 38 pages means publishing, at scale, claims that are false for most of them:

- **FAQPage** on a page with no questions and answers on it means inventing questions to justify the
  markup. That is fabricated content shipped in structured data.
- **Product** on the blog index, the about page and the contact page asserts those pages are products.
- **Article** on the pricing page and the about page asserts they are articles.
- **LocalBusiness** is the only one of the four with a legitimate home here — the company has a verified
  Google Business Profile and a real seat at Ακτή Μιαούλη 47 — but it belongs on the contact/company page,
  not on all 38, **and not until §4.2 is fixed**: implementing it today would publish the wrong street
  number and a phone line that has not rung since March 2023 into machine-readable markup, on every page.

*The general form of the rule, which is worth Στέλιος internalising:* this site already demonstrates the
failure mode. Three of its five `sameAs` entries are false, and they were presumably added on the same
logic — more entries look like more signal. False structured data is not weak signal, it is wrong signal,
and it is harder to unwind than an empty field.

*What to do instead, in the same templates and the same sprint:* one `Organization` block with a stable
`@id`, emitted site-wide, referenced by every page. That is the item the consultant's list omits, and it
is the one that fixes C2.

A concrete starting block, built **only** from values in the three files — every one of these is traceable,
and the two fields I have deliberately left for you to decide are marked:

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "@id": "https://pharosmarine.example/#organization",
  "name": "Pharos Marine Data",
  "legalName": "ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΔΙΩΤΙΚΗ ΚΕΦΑΛΑΙΟΥΧΙΚΗ ΕΤΑΙΡΕΙΑ",
  "alternateName": ["Φάρος Ναυτιλιακή Πληροφορική", "Φάρος"],
  "url": "https://pharosmarine.example",
  "logo": "https://pharosmarine.example/img/logo.png",
  "description": "DECIDE — see §4.4; one sentence, then used verbatim on every surface",
  "foundingDate": "2019-03-14",
  "founder": [
    { "@type": "Person", "name": "Δημήτρης Ζαχαρόπουλος" },
    { "@type": "Person", "name": "Ειρήνη Μαυρίδου" }
  ],
  "numberOfEmployees": 14,
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "Ακτή Μιαούλη 47",
    "addressLocality": "Πειραιάς",
    "postalCode": "18536",
    "addressCountry": "GR"
  },
  "telephone": "+30 210 4177 250",
  "email": "info@pharosmarine.example",
  "identifier": {
    "@type": "PropertyValue",
    "propertyID": "ΓΕΜΗ",
    "value": "158234701000"
  },
  "sameAs": [
    "https://www.linkedin.com/company/pharos-marine-data",
    "https://www.facebook.com/pharosmarinedata",
    "https://www.youtube.com/@pharosmarinedata"
  ]
}
```

Provenance for each value: `legalName` and `identifier` and `foundingDate` from the ΓΕΜΗ extract
(*Ημερομηνία σύστασης 14/03/2019*); `address` from the ΓΕΜΗ έδρα, matching the EL contact block, Facebook,
GBP, vrisko and xo.gr (5 of 7 surfaces, §4.2); `telephone` the live 250 line; `numberOfEmployees` from the
EL page («απασχολούμε 14 άτομα») — note this one needs an owner, since it dates the block; founders from
the EL page and the team block; `sameAs` per §5. **`description` is left as a decision**, not filled in by
me: §4.4 shows six competing versions and choosing between them is the company's call, not the auditor's.
Once chosen it goes on all six surfaces unchanged.

Add `Person` markup for the two founders on the company page, with `worksFor` pointing at the
`@id` above — that is the direct fix for the empty founder signal, and the team block already carries the
names, titles and photos it needs.

### Line 2 — "publish an llms.txt at the root so the AI crawlers know what to quote"

**Ruling: not harmful, not a priority, and not something to report as a completed AI-visibility measure.**

No AI vendor publishes that it reads such a file, and nothing in the three inputs establishes that any
system requests it. So the honest position is: publishing it asserts nothing false and costs an hour, but
no effect may be claimed from it, to the board or to the investor.

Two conditions if it does get published:

1. **Not before §4 is settled.** An `llms.txt` written today would restate the same contradictions in a
   fourth place — two founding years, two cities, two phone numbers. The file's whole premise is that it
   is the canonical statement; publishing a canonical statement while the canon is undecided is the exact
   failure this audit is about.
2. **Verify rather than assume.** After publishing, check the server logs for requests to `/llms.txt` and
   record which user agents, if any, fetch it, with dates. That converts an article of faith into a fact
   you own — and it is the only evidence available to anyone on this question.

**The opportunity cost is the real argument.** The same hour spent deleting three false `sameAs` entries
changes what machines are told about the company's identity today, using facts already verified.

---

## 7. Top 5 Priority Actions

Ordered **impact on entity recognition first, then ascending effort**. All five are High impact, so the
order inside them runs Low effort before Medium; where two tie, the one that unblocks the other goes first
and says so. Effort is *the work on your side* — it is not a prediction of when Google, Bing or any
assistant will respond to it, and no such prediction appears anywhere in this report.

1. **Signal 2 (`sameAs`) — delete the three false entries, add the YouTube channel.**
   - Impact: **High** | Effort: **Low** (one JSON block, one deploy)
   - Why: the published list currently asserts that this company is the Lighthouse of Alexandria, and
     names two profiles that do not exist. Disambiguation comes before everything else: while an explicit
     identity claim points at another entity, every other signal you build risks being attributed to it.
     This is the only High/Low action on the list that is pure deletion — nothing has to be decided first.

2. **Signal 5 (contact/NAP) — correct the dead phone, the street number, the city and the founding year on the surfaces you control.**
   - Impact: **High** | Effort: **Low** (four field edits: EN about page, company-page JSON-LD, and a
     correction request each to vrisko.gr and xo.gr)
   - Why: 3 of 7 surfaces publish a phone line that has not reached the company since March 2023, and 2 of
     7 publish a street number the registry contradicts. Consistent NAP across site, GBP and the Greek
     directories is a scored signal in its own right, and every downstream asset — the Wikidata item, the
     rebuilt schema, the investor pack — copies these values. Fixing them after those are built means
     fixing them twice.

3. **Signal 35 (name consistency) — publish one written naming convention and apply it.**
   - Impact: **High** | Effort: **Medium** | **Unblocks actions 4 and 5**
   - Why: five name strings on your own surfaces, two more on your own profiles, three more on directory
     listings. The registry already settles the hard part — επωνυμία `ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ
     ΙΔΙΩΤΙΚΗ ΚΕΦΑΛΑΙΟΥΧΙΚΗ ΕΤΑΙΡΕΙΑ`, διακριτικός τίτλος `PHAROS MARINE DATA` — so this is a decision to
     write down and enforce, not a naming exercise. It goes ahead of the schema rebuild and the Wikidata
     item because both of those have to write a name, and writing the wrong one twice is the cost of
     doing it in the other order.

4. **Signal 3 (`@id` consistency) — one `Organization` block, one `@id`, emitted on all 38 pages, English page included.**
   - Impact: **High** | Effort: **Medium** (template work — the block in §6 is ready to paste once
     action 3 has settled `name` and `description`)
   - Why: two blocks that disagree and share no identifier are two organisations as far as any parser is
     concerned, and 36 of 38 pages are attached to neither. This is also the action that closes C5: the
     English page currently carries no structured data at all.

5. **Signal 6 (Wikidata) — create the item, with a reference on every statement.**
   - Impact: **High** | Effort: **Medium** | Depends on action 3
   - Why: Wikidata is openly editable and CC0, which makes it the one entity surface here you can correct
     directly instead of petitioning; the ΓΕΜΗ extract gives you a serious public reference for the legal
     name, the ΓΕΜΗ number, the inception date and the seat. **What must not be promised alongside it:** a
     knowledge panel, an AI-description change, or any date. Google documents that panels are created
     automatically "when there is enough information available on the open web", describes its sources no
     more precisely than public sources, licensed data and claimant submissions, **names neither Wikidata
     nor Wikipedia, and states no timeframe** (support.google.com/knowledgepanel/answer/9787176). A
     complete referenced item makes the entity machine-resolvable. That is the claim; anything past it is
     invented.

*Just below the cut, and cheap:* the Google Business Profile (Medium impact, Low effort) — answer the 6
reviews, set a secondary category, replace the 2019 photos, seed Q&A. It is a whole category at 21.4% and
every check in it is a same-day fix. It sits at 6 rather than 1 only because the four identity actions
above it decide what the profile should say.

---

## 8. Entity Building Roadmap

Timeframes describe **your work**, not anyone else's response.

### Week 1–2: Foundation (Structured Data + Consistency)
- [ ] Delete the three false `sameAs` entries; add the YouTube channel (action 1)
- [ ] Correct the EN about page: city → Πειραιάς, founding year → 2019, street → 47, phone → the 250 line
- [ ] Correct the company-page JSON-LD: `foundingDate`, `streetAddress`, `telephone`
- [ ] Decide the one canonical description (§4.4) and the naming convention (action 3); write both down
- [ ] Deploy the single `@id`-anchored `Organization` block site-wide, English page included (action 4)
- [ ] Add `Person` markup for both founders on the company page, with `worksFor` → the org `@id`
- [ ] Rewrite the EL company page so paragraph 1 opens with the entity-defining sentence (currently in ¶2)
- [ ] Google Business Profile: answer all 6 reviews, add a secondary category, upload current photos, seed Q&A, fill Products/Services
- [ ] Correction requests to vrisko.gr (phone → 250) and xo.gr (name → the standard, not «Φάρος Μαρίν Ντέιτα»)
- [ ] Ask Green Corridors EU to fill the empty link field on the member entry

### Month 1: Knowledge Bases
- [ ] Create the Wikidata item: label, description, aliases in EL and EN; `instance of`, `official website` (P856), `inception` (P571, 2019-03-14), `country` (P17), `headquarters location` (P159), `industry` (P452), `founded by` (P112). Reference every statement — the ΓΕΜΗ extract carries four of them. Read the current text of `wikidata.org/wiki/Wikidata:Notability` before starting; it is a community policy and the outcome for any given item is the editors' call, not something to predict internally
- [ ] Create the Crunchbase profile (a seed raise is the natural moment); add the URL to `sameAs` **on the day it goes live**
- [ ] Build the coverage inventory the Wikipedia notability question actually needs: every independent, non-trivial piece about the company, dated, with the publication named — excluding anything the company paid for or issued. The article is the last step, never the first, and the company must not write or commission it: Wikipedia's COI policy prohibits organisations from creating articles about themselves, and paid editing without disclosure violates policy
- [ ] Publish a press/fact-sheet page — one place stating the canonical name, legal name, ΓΕΜΗ number, founding date, seat, founders, headcount and the one-line description. The absence of this page is why every third party writes the facts differently

### Month 2–3: Authority Building
- [ ] Give the blog real by-lines and author pages with `Person` schema, replacing «Ομάδα Φάρος» — this is signal 25, currently a flat ❌, and it is also the fix for "who founded this company" being unanswerable from the site
- [ ] Pursue mentions on independent maritime and technology publications; assess each piece against GNG when it lands rather than forecasting its grade
- [ ] Build topical depth on the target topics so the entity–topic association rests on more than the company page
- [ ] Get the founders' LinkedIn profiles linking back to the site (the CEO's headline names the company but carries no link)

### Ongoing: AI-Specific Optimization
- [ ] Run the four AI queries in §1 on a stated cadence, logged out, recording the system, the date and the verbatim answer. Single runs are observations, not a recognition rate — the value is in the same queries repeated
- [ ] Re-read `robots.txt` and confirm the AI crawlers are not blocked (never checked; excluded from this audit)
- [ ] Keep `numberOfEmployees` and the description current, and re-check the Wikidata item for vandalism
- [ ] Re-audit on a stated cadence; report what changed and when you changed it, never when a third party will respond

---

## 9. What to tell the investor

The diligence question was "how does the market identify you". The answerable version of that, from these
three files, is:

- On the qualified Latin name the company already has a coherent presence: it is the name on the registry,
  on LinkedIn, on the Google Business Profile, on YouTube and in the association's member list.
- On the Greek short form the company has no separable identity today, and its own markup makes that worse
  by asserting identity with the Lighthouse of Alexandria.
- Nothing has been checked against a knowledge panel, an AI assistant, or a mention log, because none was
  captured. **That is the honest state, and it is a two-week fix, not a two-quarter one.**

Do not put a knowledge-panel date, an AI-citation figure, or a "typical for a company this size" benchmark
into the pack. There is no measurement behind any of them, and an investor who checks one will discount
the rest of the document.

---

## 10. Cross-Reference

- **CORE-EEAT**: A07 (Knowledge Graph Presence) — Fail: no Wikidata item, no Wikipedia article, panel
  status unchecked. A08 (Entity Consistency) — Fail: five name strings on owned surfaces, two founding
  years, two cities, a dead phone on three surfaces.
- **CITE**: the Identity dimension (I01–I10) is where this work lands; I09 is where the unlinked/linked
  mention split would be scored once a dated mention log exists — none was supplied here.
- Content-level audit: `content-quality-auditor`. Domain-level audit: `domain-authority-auditor`.
- Schema implementation: `schema-markup-generator` for the block in §6.

---

## 11. Checks this audit could not complete

Listed so that nothing here reads as a check that was run and came back clean. Each names the input that
closes it.

| Not assessed | What would settle it |
|---|---|
| Google Knowledge Panel; branded SERP; disambiguation on the branded query (signals 11, 12, 14, 15, 16) | A dated, logged-out branded-SERP capture for `Pharos Marine Data`, «Φάρος» and `Faros`, with location and device recorded |
| AI recognition, description accuracy, topic association (signals 28–32) | The four queries in §1, run once per system, verbatim answers recorded with the date |
| Media mentions, awards, co-citation, speaking, branded search volume (signals 13, 19, 20, 21, 22) | A dated coverage/mention log — one file would move five signals and lift the Third-Party category off a single-signal basis |
| Backlinks, branded anchor text, homepage authority (signals 45, 46) | Any link-tool export; none has ever been run for this domain |
| Topical content depth (signal 24) | A page inventory broken down by topic — the CMS reports 38 pages total, with no breakdown |
| Original research published (signal 26) | A content inventory, or a straight yes/no from the team |
| AI-crawler access (signal 36) | The current `robots.txt` |
| Subdomain consistency (signal 47) | A subdomain list; none was supplied |
| DBpedia, Knowledge Graph ID, Wikidata property depth, ISNI/VIAF (signals 38, 39, 40, 41) | A dbpedia.org search; a Knowledge Graph API response; and for 38/41 — an item to review, and a person to identify (ISNI/VIAF does not apply to an ΙΚΕ) |
| **Wikipedia notability** (the second arm of signal 17) | The coverage inventory above. The signal is scored ❌ on the arm that *was* checked — no article exists, and no existing article mentions the company (2026-08-06). Whether the company clears GNG is a question these three files cannot answer, and the notability arm is recorded here rather than folded silently into the ❌ |
