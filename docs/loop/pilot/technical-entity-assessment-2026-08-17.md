# Sani Hellas — Technical / Entity Assessment (Phase 4 pilot)

**Date:** 2026-08-17 · **Scope:** host and path patterns, duplicate exposure, entity/brand association
**Status:** assessment only. No site change was made, staged, or drafted. Nothing published.

---

## 0. Method, and what it can and cannot establish

Every claim below traces to a web search actually run in this session; each is quoted at the
point it is used. Four limits bound the whole document, and they are not boilerplate — they
decide which findings are conclusions and which are leads.

**No index counts exist in this report.** The search tool available here returns a list of
result links and a prose summary. It returns **no result count at all** — not an exact one, not
an "About N results" estimate. So there is no measured or estimated page count for any pattern,
and none is given. Where a count matters, the check that supplies it is named in §6. (The brief
anticipated that a `site:` count is an estimate rather than a measurement; here the situation is
one step further back — the figure was never surfaced to be estimated from.)

**The `site:` operator was not honoured strictly.** `site:sanihellas.gr` returned six
en.wikipedia.org results among ten. `site:sanihellas.wordpress.com` returned goodreads.com and
Wikipedia. The returned list is therefore a *relevance-ranked set influenced by* the operator,
not a site-restricted enumeration. Consequence: presence in these results is evidence; **absence
is not.** A worked demonstration — `site:sanihellas.gr faq OR locator OR en` returned zero
sanihellas.gr results and the tool's own summary proposed that the pages "may not be indexed."
That inference is wrong, and I can show it is wrong: `/faq/thermopompoi-atlantic`,
`/locator/?product=130` and `/en/heating` had each already appeared as live results in earlier
searches in this same session. **No "not indexed" conclusion is drawn anywhere in this document.**

**Searches run from a US context.** The tool is US-geolocated. Greek-market SERPs seen from
Greece will differ in ranking and in local-pack composition. Ranking observations below are
directional, not the client's actual market position.

**Response-level facts were not observable.** No HTTP status code, redirect chain, `Location`
header, `rel=canonical`, `hreflang`, `robots.txt`, sitemap, or `X-Robots-Tag` was read — the
fetch path is blocked in this environment by design. Every statement about *why* a URL behaves
as it does is therefore labelled, and the settling check is named. This is the single most
important constraint in the document: **the duplicate-title finding in §3 is observed fact; its
cause is not, and four different causes would each produce exactly what I saw.**

Confidence labels used throughout: **Confirmed** (directly observed in a search result I ran) ·
**Likely** (strong indirect evidence, consistent pattern) · **Hypothesis** (plausible, needs the
named check).

---

## 1. The finding, stated plainly

The brief proposed three host/path patterns plus a legacy WordPress property. **The finding
holds, and it is larger than proposed.** What is actually observable is:

- **six** distinct web properties carrying this business's product vocabulary, not two;
- **four** distinct URL patterns *inside* the main domain, not three;
- **two** hostnames (`www.` and bare) both present in results;
- **five** distinct URLs observed serving one identical `<title>` string.

The brief's items (a), (b), (c) and (d) are all confirmed live. Two further properties and two
further in-domain patterns were found that the brief did not list.

---

## 2. Property and pattern inventory (all Confirmed — each URL appeared as a result)

### 2.1 Main domain, Greek locale — pattern (a) `www.sanihellas.gr/el-gr/…`

Confirmed and clearly the primary commercial surface. Examples observed:

| URL | Observed title |
|---|---|
| `https://www.sanihellas.gr/el-gr/` | SANI HELLAS αντιπρόσωποι Kullhaus, Meaco, Nobo, Atlantic |
| `https://www.sanihellas.gr/el-gr/afygrantires` | Αφυγραντήρες Kullhaus & Meaco - Συμπιεστή & Ζεόλιθου \| sani |
| `https://www.sanihellas.gr/el-gr/afygrantires-sympiestis` | Αφυγραντήρες με Συμπιεστή: Κορυφαία Μοντέλα & Οικονομία Sani Hellas \| sani |
| `https://www.sanihellas.gr/el-gr/afygrantires-zeolithos` | Αφυγραντήρες Ζεόλιθου - Kullhaus & Meaco - Sani Hellas |
| `https://www.sanihellas.gr/el-gr/thermansi-thermopompoi` | Θερμοπομποί NOBO & Atlantic χαμηλής κατανάλωσης \| sani |
| `https://www.sanihellas.gr/el-gr/thermansi/nobo` | Ηλεκτρική θέρμανση … NOBO, ATLANTIC, TONON \| sani |
| `https://www.sanihellas.gr/el-gr/anemistires-anemistires-dapedou` | Ανεμιστήρες Δαπέδου MeacoFan Sefte 10 — Αθόρυβοι \| sani |
| `https://www.sanihellas.gr/el-gr/contact/` | SANI HELLAS αντιπρόσωποι Kullhaus, Meaco, Nobo, Atlantic |

Two structural notes inside this one pattern, both Confirmed:

**(i) Category paths mix two grammars.** `thermansi-thermopompoi` joins parent and child with a
hyphen; `thermansi/nobo` joins them with a slash. Both live, both indexed, same section of the
catalogue.

**(ii) The same Greek word is transliterated at least three ways in slugs.** αφυγραντήρες
appears as `afygrantires` (`/el-gr/afygrantires`), as `afugranthres`
(`/el-gr/afugranthres/meaco/`), and as `afygrantiras` (`/afygrantiras-gia-spiti-me-thermansi/`);
blog slugs use a fourth form, `afugranthras`
(`/el-gr/blog/post/18441/Poso-reuma-kaiei-enas-afugranthras;-…`). Two of these resolve to what
is described as the same thing — Meaco dehumidifiers:
`https://www.sanihellas.gr/el-gr/afygrantires/meaco/?pagetype=5&pagesize=100` and
`https://www.sanihellas.gr/el-gr/afugranthres/meaco/`.

**(iii) A degenerate title.** `https://www.sanihellas.gr/el-gr/afugranthres/meaco/` was returned
**twice, in two independent searches**, with the title `sani` — a four-character title on an
indexed commercial page. Confirmed by repetition.

**(iv) Faceted-navigation URLs are indexed.** Observed as results, not inferred:

```
/el-gr/thermansi-thermopompoi/500-1,5,atlantic,tonon/?pagesize=100
/el-gr/thermansi-thermopompoi/1500-1,atlantic,nobo
/el-gr/thermansi-thermopompoi/750-1
/el-gr/afygrantires/40-1,740-1,2000-1,250-1,1400/?pagesize=100
/el-gr/afygrantires/60-1,35,kullhaus/?lastselectionid=19786&pagesize=100
/el-gr/ALL?Title=meaco
/el-gr/ALL/kullhaus/?pagetype=5
/el-gr/ALL/40-1,145-1,2500-1,1500-1,300-1,350,26,60-1,100-1,5,40-60/?lastselectionid=19786&pagesize=100
```

The last of these was returned with the title **`9 - Sani Hellas`**. A filter-combination URL
with a numeral for a title is in the index. How many such combinations are indexed is
**unavailable** — see §6, check 4.

**(v) Percent-encoded combining accents in a slug.** The blog URL named in the brief resolves to:

```
https://www.sanihellas.gr/el-gr/blog/post/17851/Pos-tha-epile%CC%81kso-ton-kata%CC%81llhlo-afugranth%CC%81ra/
```

`%CC%81` is U+0301, COMBINING ACUTE ACCENT. The slug is Latin transliteration carrying decomposed
Unicode diacritics. Two byte-different URLs (composed NFC vs decomposed NFD) can render
identically to a human, which is a normalisation hazard for canonicals, internal links and
analytics keys. **Confirmed** as a string; its consequences are Hypothesis pending check 5.

### 2.2 Main domain, English locale — a pattern the brief did not list

Confirmed live: `/en/`, `/en/heating`, `/en/heating-heating-panels`,
`/en/heating-heating-panels/nobo`, `/en/heating-heating-panels/panel-heater-ntl2n`,
`/en/nobo-convectors/`, and an English blog at `/en/blog/post/18503/…`.

**The locale prefixes are asymmetric**: Greek is `el-gr` (language + region), English is `en`
(language only). This is a live bilingual site with two differently-shaped locale roots.

### 2.3 Main domain, no locale prefix — pattern (c), broader than the brief stated

The brief listed one example. Four distinct no-prefix families are confirmed:

| URL | Kind |
|---|---|
| `https://www.sanihellas.gr/afygrantiras-gia-spiti-me-thermansi/` | article/landing, root level, trailing slash |
| `https://www.sanihellas.gr/faq/thermopompoi-atlantic` | FAQ section, no locale |
| `https://www.sanihellas.gr/locator/?product=130` | dealer locator, query-parameter driven |
| `https://www.sanihellas.gr/thermansi.html` | `.html` suffix, root level |
| `https://www.sanihellas.gr/Files/files/Thermopompoi-Nobo-Prosepctus.pdf` | PDF (filename misspells "Prospectus") |

So three URL grammars coexist on one host: locale-prefixed, root-level-slug, and legacy `.html`.

### 2.4 Bare host + `.html` — pattern (b), confirmed exactly as the brief gave it

`https://sanihellas.gr/thermansi/thermopompoi.html` — **no `www`, `.html` suffix** — was returned
as a live result. Confirmed. Its title is discussed in §3, because that is where it matters.

Both hostnames therefore appear in results: `www.sanihellas.gr` (most URLs) and `sanihellas.gr`
(this one). Whether the bare host serves content or redirects is **not observable here** —
check 1.

### 2.5 `sanihellas.wordpress.com` — pattern (d), confirmed live

Confirmed live, with at least a home page and `/convectors/`:

- `https://sanihellas.wordpress.com/` — title: `ΘΕΡΜΟΠΟΜΠΟΙ ΝΟΡΒΗΓΙΑΣ, ΘΕΡΜΟΠΟΜΠΟΙ ΓΑΛΛΙΑΣ, ΑΦΥΓΡΑΝΤΗΡΕΣ MEACO, ΙΟΝΙΣΤΕΣ HEAVEN FRESH | …`
- `https://sanihellas.wordpress.com/convectors/` — title: `ΘΕΡΜΟΠΟΜΠΟΙ | …` (same suffix)

It carries the same product vocabulary as the main domain — and it carries **stale business
facts**, which is what makes it a live problem rather than a dormant asset. See §4.

### 2.6 Four brand microsites on separate domains — not in the brief at all

All confirmed live, all carrying Sani Hellas representative language:

| Domain | Evidence observed |
|---|---|
| `noboadvantage.gr` | `Contact NOBO Greece \| Sani Hellas Official Distributor` at `/epikoinonia-nobo/?lang=en`; also `/nobo-energy-control/`, `/nobo-bathroom-heating/`, `/odigos-epilogis-thermopompou-nobo/`, `/tips/`, `/nobo-heaters-prices/` |
| `kullhaus.gr` | `Kullhaus Hellas \| Κορυφαίοι Αφυγραντήρες & Καθαριστές Αέρα`; `/afygrantires-kullhaus/` |
| `meaco.gr` | `Meaco στην Ελλάδα. Sani Hellas αποκλειστικοί αντιπρόσωποι`; `/contact-meaco-service/` shows `Τηλ. 210 3236627` |
| `atlantic-heating.gr` | `Επίσημος αντιπρόσωπος Atlantic επικοινωνία, Sani Hellas ΑΕ` |

`noboadvantage.gr` shows a WordPress signature (`?lang=en` for language, and an indexed
**attachment page** at `noboadvantage.gr/?attachment_id=5538&lang=en`). Indexed attachment pages
are a known WordPress crawl-bloat default.

**These are deliberate brand microsites, not accidents.** They are well-titled, current
(2026 dates in titles) and brand-specific. That distinguishes them sharply from the WordPress
property, and the recommendation differs accordingly.

---

## 3. The duplicate exposure — the strongest finding, and the one whose cause is unknown

**Confirmed observation.** One identical title string —
`SANI HELLAS αντιπρόσωποι Kullhaus, Meaco, Nobo, Atlantic` — was returned for **five distinct
URLs**, spanning three URL grammars, two hostnames and two language locales:

| # | URL | Pattern | Host | Locale |
|---|---|---|---|---|
| 1 | `https://www.sanihellas.gr/el-gr/` | locale root | `www` | el |
| 2 | `https://www.sanihellas.gr/el-gr/contact/` | locale path | `www` | el |
| 3 | `https://www.sanihellas.gr/thermansi.html` | legacy `.html` | `www` | none |
| 4 | `https://sanihellas.gr/thermansi/thermopompoi.html` | legacy `.html` | **bare** | none |
| 5 | `https://www.sanihellas.gr/en/nobo-convectors/` | root slug | `www` | **en** |

Also observed: `https://www.sanihellas.gr/en/` carrying the same Greek-language title.

That is the fact. **The cause is not observable from here, and at least four causes would each
produce exactly this result:**

1. The legacy URLs **redirect** to the homepage, and the index still lists the old URL against
   the destination's title. (Would be an acceptable-but-untidy state.)
2. The legacy URLs **200 OK and serve homepage content** via a catch-all rewrite — genuine
   duplicate content on genuinely separate URLs. (Would be the serious case.)
3. The legacy URLs **soft-404** to the homepage. (Serious, and invisible in Search Console's
   error reports.)
4. The pages are distinct but share a **hardcoded site-wide title tag** that was never
   differentiated. (An on-page defect, not a routing one — and it would also explain #2 and #5
   above, which are *not* legacy URLs.)

Case 4 deserves weight: URLs 2 and 5 are current, in-structure pages (`/el-gr/contact/` and an
English-locale page), so at least part of this is a title-templating problem independent of any
legacy routing. **Likely**: the site emits a fallback site-wide title where a page-specific one
is missing. **Hypothesis**: the legacy `.html` paths additionally resolve to homepage content.
Check 1 and check 2 in §6 separate these in about two minutes.

**What is not claimed.** I did not observe a `rel=canonical` anywhere. I did not observe any
status code. I cannot say this is "a canonical problem", because I have not seen a canonical. I
can say: *five URLs, one title, and no visibility into which of them any engine treats as the
original.*

### Does the WordPress property compete with, or dilute, the main domain?

**Observed — it does not currently outrank the main domain on commercial queries.** Two
non-branded commercial searches were run:

- `θερμοπομποί χαμηλής κατανάλωσης τιμές` → returned `www.sanihellas.gr/el-gr/thermansi-thermopompoi`. The WordPress property did **not** appear.
- `αφυγραντήρες Meaco τιμές Ελλάδα` → returned `www.sanihellas.gr/el-gr/afygrantires/meaco/…` and `meaco.gr`. The WordPress property did **not** appear.

The legacy `.html` URLs likewise did not appear on either commercial query. So on the evidence
available, the **ranking-cannibalisation risk is not currently materialising** on these two
queries. This limits the severity of the duplicate finding and should be said plainly rather
than dramatised — but note the absence rule from §0: the WordPress property not appearing in
*these two* result sets is not proof it never appears.

**The dilution that is real is not about rankings — it is about facts.** See §4.

### One positive, worth recording

For the non-branded query `καλύτερος αφυγραντήρας για σπίτι 2026 ποιον να διαλέξω`, the
**first result** was `https://www.sanihellas.gr/el-gr/blog/post/17851/…` — ahead of
`testado.gr`, `dropfix.gr`, `best10.gr` and `toptest.gr`, all of which are review/affiliate
sites competing for exactly that query. The blog is current: titles observed carry dates through
1 August 2026. Whatever the URL-structure problems are, this content is working.

---

## 4. Entity findings

### 4.1 Business facts disagree across the client's own properties (Confirmed)

| Source observed | Address | Phones |
|---|---|---|
| `kullhaus.gr` | Κωστή Παλαμά 5-7, Νέα Χαλκηδόνα | 210 3236627, 3233766 |
| `vrisko.gr` listing | Νέα Χαλκηδόνα, Αττικής, 14343 | 2103236627 |
| `xo.gr`, `11888.gr` listings | Νέα Χαλκηδόνα | — |
| `meaco.gr` `/contact-meaco-service/` | — | 210 3236627 |
| **`sanihellas.wordpress.com`** | **Πραξιτέλους 9, 105 62 Αθήνα** | 210 3236627, 3233766 |

The phone numbers are consistent everywhere. **The WordPress property publishes a different
address from every other source.** Given four independent sources agree on Νέα Χαλκηδόνα,
**Likely**: Πραξιτέλους 9 is a former address still being served. Check 6 confirms which is
current — that is the owner's knowledge, not mine to assert.

The WordPress property also presents a **stale brand portfolio**: it foregrounds
`ΙΟΝΙΣΤΕΣ HEAVEN FRESH` in its own title, a brand absent from the current main-domain brand set
(Kullhaus, Meaco, Nobo, Atlantic, Tonon Evolution). So the legacy property tells a visitor — and
any system reading it — that this business sells a brand line it apparently no longer leads with,
from an address it apparently no longer occupies.

**This is the concrete dilution.** Not stolen rankings: contradicted facts, on a property that
carries the business's own name.

### 4.2 The business name has many forms in public records (Confirmed)

Observed across results: `Sani Hellas` · `SANI HELLAS` · `SaniHellas` · `sani` (as a title) ·
`Sani hellas SA` (YouTube channel `@SanihellasGr`) ·
`SANI HELLAS ΕΙΣΑΓΩΓΙΚΗ ΕΞΑΓΩΓΙΚΗ ΜΟΝΟΠΡΟΣΩΠΗ ΑΕ` (vrisko.gr, 11888.gr) ·
`SANI HELLAS Α.Ε.` (xo.gr) · **`SANI ΕΛΛΑΣ Ε.Π.Ε.`** (vres.gr).

The last is notable twice over: it is the name in **Greek script** rather than Latin, and it
carries a **different legal form** (Ε.Π.Ε. / limited company) from the ΑΕ / Α.Ε. that three other
directories record. Consistent with a legacy directory entry predating a change of legal form.
**Hypothesis** — the company's own filing history settles it, and only the owner has that.

### 4.3 Name-token collision (Confirmed, and consequential)

A search for `"Sani" Ελλάδα brand ξενοδοχείο Χαλκιδική Sani Resort` returned `sani-resort.com`,
`scottdunn.com`, `britishairways.com`, `tripadvisor.com`, `jet2holidays.com` and others — a large,
heavily-linked hospitality entity occupying the bare token "Sani" in a Greek context. Separately,
a Wikidata item exists at `https://www.wikidata.org/wiki/Q2221754` under the label `Sani`; **I
did not open it and make no claim about what it describes.**

The practical consequence is about the *bare* token only. Every brand-plus-category search I ran
resolved correctly to this business (§4.4), so the collision is not currently causing
misattribution on commercial queries. It does mean the bare word "Sani" is not an available
identity for this company, and the full form should be used consistently everywhere.

### 4.4 Brand-plus-category association — the test the brief asked for

Run as four searches. **Three of the four associations hold clearly.**

| Brand + category query | Did this business surface? | Notes |
|---|---|---|
| `Kullhaus αφυγραντήρες Ελλάδα αντιπρόσωπος` | **Yes** — `sanihellas.gr/el-gr/ALL/kullhaus/` and `kullhaus.gr` both returned | Third-party `apothema.gr` ranked first |
| `Meaco αφυγραντήρες Ελλάδα επίσημος αντιπρόσωπος` | **Yes** — `sanihellas.gr/el-gr/ALL/meaco/` and `meaco.gr` returned | **But see below** |
| `Nobo θερμοπομποί Ελλάδα αντιπροσωπεία Atlantic` | **Yes** — multiple `/el-gr/thermansi-thermopompoi/…` results, exclusive-representative language present | Strongest of the four |
| `Kullhaus` (identity) | Kullhaus described as Athens-based, distributed by Sani Hellas | `kullhaus.gr` is a full brand site |

**The Meaco exception is the one to act on.** The generated summary for that search stated:
*"there appear to be other entities also claiming representative status. The company Fragkiadakis
- Zesta.gr is recognized as an official representative/distributor of Meaco in Greece."*
`zesta.gr` product pages (`/meaco-20l-platinum`, `/meaco-dd8l-desiccant`) were returned in the
same result set.

Handle this carefully. What is **Confirmed**: a competing Greek retailer sells Meaco and appears
in the same result set, and a search system produced prose asserting that competitor holds
official representative status. What is **not established**: which party actually holds the Meaco
appointment. That is a contractual fact, and no search result settles it — the client knows it
and I do not. The finding is not "a competitor is lying"; the finding is **"the official-
representative claim for Meaco is contested in what search systems return, and this business's
claim is not winning it outright."** For a business whose commercial position rests on being the
official channel, that is the highest-value entity issue in this document.

### 4.5 Knowledge base presence

No Wikipedia article and no Wikidata item for this company surfaced in the search run for it.
Consistent with absence; **not proof of absence**, per §0. Check 7 settles it in one minute and
requires no tooling.

### 4.6 A brand fact that may differ across the client's own properties (Hypothesis — flagged, not asserted)

Across generated summaries derived from these properties, NOBO's founding year appeared as
**1938** (from `noboadvantage.gr`, whose page title reads `NOBO Νορβηγίας: 85+ Χρόνια
Κατασκευής Θερμοπομπών`), as **1947** (from the WordPress property), and as **1918** (from a
summary referencing `sanihellas.gr/en/`).

**I am deliberately not reporting this as a contradiction.** These are search-engine-generated
summaries, not page reads, and a summariser can garble a date. What I can say is that a
page-level read of those three properties is warranted, because if the pages *do* disagree, a
business claiming exclusive representation is publishing three founding years for the brand it
represents. Check 8.

---

## 5. Why no health score appears in this report

The library's scoring rule is arithmetic over checklist rows, and a row is scored only if it
could actually be checked. I could check essentially none of them: no `robots.txt`, no sitemap,
no canonical tags, no response headers, no crawl, no Core Web Vitals, no mobile test, no
structured-data validation. The one table with observable rows is duplicate content — and even
there I compared **titles in search results**, not page bodies.

The rule for that situation is explicit: a section with nothing checkable reads *not scored — no
data*, never 0/10, and **if no section could be scored the report carries no overall health score
at all**. So: **no health score is given.** A number here would be fabricated, and it would be
fabricated in the direction of looking rigorous. §6 names which check unlocks which section.

Severity, which is independent of scoring, is reportable:

| Finding | Severity | Confidence |
|---|---|---|
| Five URLs sharing one title across two hosts and two locales | 🔴 Critical if cause 2 or 3 (§3); 🟡 High if cause 1 or 4 | Observation Confirmed; cause unknown |
| Meaco representative claim contested in search output | 🔴 Critical (commercial position) | Confirmed as observed; underlying fact unresolved |
| WordPress property publishing a divergent address + retired brand | 🟡 High | Confirmed |
| Faceted URLs indexed, one titled `9 - Sani Hellas` | 🟡 High | Confirmed |
| Bare host and `www` host both present in results | 🟡 High | Confirmed |
| Indexed page titled `sani` | 🟡 High | Confirmed (returned twice) |
| Two transliterations of αφυγραντήρες reaching Meaco listings | 🟡 High | Confirmed |
| Combining-accent percent-encoding in blog slugs | 🟢 Medium | String Confirmed; impact Hypothesis |
| Company name in 8 forms incl. one Greek-script legacy legal form | 🟢 Medium | Confirmed |
| No Wikipedia/Wikidata presence surfaced | 🟢 Medium | Consistent with absence only |

---

## 6. The checks the owner must run — these settle what this assessment cannot

Read-only diagnostics. None changes anything. Run from any terminal.

**Check 1 — What do the two hostnames and the legacy `.html` URLs actually return?**
Settles §3 causes 1/2/3 and the www/non-www question. This is the highest-value check here.

```bash
curl -sSIL -o /dev/null -w '%{url_effective} -> %{http_code}\n' https://sanihellas.gr/
curl -sSIL -o /dev/null -w '%{url_effective} -> %{http_code}\n' https://www.sanihellas.gr/
curl -sSIL -o /dev/null -w '%{url_effective} -> %{http_code}\n' https://sanihellas.gr/thermansi/thermopompoi.html
curl -sSIL -o /dev/null -w '%{url_effective} -> %{http_code}\n' https://www.sanihellas.gr/thermansi.html
```

Reading it: a `301` landing on `https://www.sanihellas.gr/el-gr/` is cause 1 — acceptable. A
`200` at the original `.html` URL is cause 2 — genuine duplicate content, fix first. A `200` that
renders the homepage is cause 3.

**Check 2 — What canonical does each of the five same-title URLs declare?**
Settles whether the duplication is being consolidated, and separates cause 4.

```bash
for u in \
  https://www.sanihellas.gr/el-gr/ \
  https://www.sanihellas.gr/el-gr/contact/ \
  https://www.sanihellas.gr/thermansi.html \
  https://sanihellas.gr/thermansi/thermopompoi.html \
  https://www.sanihellas.gr/en/nobo-convectors/ ; do
  echo "== $u"
  curl -sSL "$u" | grep -iE '<link[^>]+canonical|<title>' | head -3
done
```

If `/el-gr/contact/` returns the homepage title here too, cause 4 is confirmed and the fix is a
title template, not a redirect rule.

**Check 3 — `robots.txt` and sitemaps.** Unlocks the crawlability section entirely.

```bash
curl -sS https://www.sanihellas.gr/robots.txt
curl -sSI https://www.sanihellas.gr/sitemap.xml
curl -sS https://sanihellas.wordpress.com/robots.txt
```

**Check 4 — Real indexed counts per pattern.** The figures this report could not obtain.
In Google Search Console, Indexing → Pages, filter by URL containing each of `/el-gr/`, `/en/`,
`.html`, `?pagesize=`, `?lastselectionid=`. Search Console reports *measured* counts; a `site:`
figure in a browser is an estimate and should not be recorded as a measurement.

**Check 5 — Are the accent-encoded blog URLs duplicated in composed and decomposed form?**
In Search Console, search Pages for `blog/post/17851` and see whether one URL or two appear.

**Check 6 — Confirm the current registered address**, then compare against
`sanihellas.wordpress.com`, and against the `vrisko.gr`, `xo.gr`, `11888.gr` and `vres.gr`
listings — including the Greek-script `SANI ΕΛΛΑΣ Ε.Π.Ε.` entry on `vres.gr`, which records a
different legal form.

**Check 7 — Knowledge base presence.** Search `wikidata.org` for both `Sani Hellas` and
`ΣΑΝΗ ΕΛΛΑΣ`, and check whether a Google Knowledge Panel appears for a branded search performed
**from Greece** (this session's searches were US-geolocated).

**Check 8 — Read the NOBO founding-year claim on all three properties** (`noboadvantage.gr`
history page, `sanihellas.gr/en/`, `sanihellas.wordpress.com`) and confirm against NOBO's own
corporate source. Only act if they genuinely differ.

**Check 9 — The Meaco appointment.** Confirm the current contractual position with Meaco, then
decide how it should be stated publicly. No search result can settle this and none was treated as
if it could.

---

## 7. What is verified vs what stays unproven — one table

| Statement | Status |
|---|---|
| All four properties in the brief are live and indexed | **Verified** |
| Two further properties exist (`noboadvantage.gr`, plus `kullhaus.gr` / `meaco.gr` / `atlantic-heating.gr`) | **Verified** |
| Four URL grammars coexist on the main domain | **Verified** |
| Both `www` and bare hostnames appear in results | **Verified** |
| Five URLs share one identical title | **Verified** |
| *Why* those five share a title | **Unproven** — 4 candidate causes, checks 1–2 |
| Faceted/parameter URLs are indexed | **Verified** |
| *How many* pages are indexed, under any pattern | **Unavailable** — no count was surfaced; check 4 |
| WordPress publishes a divergent address and a retired brand | **Verified** |
| Πραξιτέλους 9 is the *former* address | **Likely** — check 6 |
| WordPress outranks the main domain commercially | **Not observed** on the two queries run; absence is not proof |
| Blog post 17851 ranks first for a competitive non-branded query | **Verified** (US-geolocated) |
| Kullhaus / Nobo / Atlantic associate with this business in search | **Verified** |
| Meaco representative status is contested in search output | **Verified as observed output** |
| Who actually holds the Meaco appointment | **Unproven, and not resolvable by search** — check 9 |
| No Wikipedia/Wikidata entry exists | **Not established** — consistent with absence only; check 7 |
| The three NOBO founding years reflect real page contradictions | **Unproven** — summaries, not page reads; check 8 |
| Any statement about redirects, canonicals, robots.txt, headers, speed | **Not observable in this environment** |

---
---

# ΤΜΗΜΑ ΓΙΑ ΤΟΝ ΠΕΛΑΤΗ

## Σύνοψη ευρημάτων — δομή διευθύνσεων και ταυτότητα επωνυμίας

**Ημερομηνία: 17 Αυγούστου 2026.** Καμία αλλαγή δεν έγινε και καμία δεν προτείνεται προς
εκτέλεση σε αυτό το στάδιο. Το κείμενο είναι αξιολόγηση.

### Τι εξετάστηκε και με ποιον τρόπο

Η αξιολόγηση στηρίχθηκε αποκλειστικά σε αναζητήσεις που εκτελέστηκαν πραγματικά. **Δεν ήταν
δυνατή η ανάγνωση των σελίδων σας σε επίπεδο διακομιστή** — δηλαδή δεν διαβάστηκαν κωδικοί
απόκρισης, ανακατευθύνσεις, δηλώσεις κανονικής διεύθυνσης (canonical) ή το αρχείο `robots.txt`.
Ό,τι αφορά τα παραπάνω διατυπώνεται ως ερώτημα προς επιβεβαίωση, ποτέ ως συμπέρασμα.

**Δεν αναφέρεται κανένας αριθμός σελίδων.** Το εργαλείο αναζήτησης που χρησιμοποιήθηκε δεν
επιστρέφει πλήθος αποτελεσμάτων — ούτε καν κατά προσέγγιση. Επομένως δεν δίνεται εκτίμηση
σελίδων για καμία κατηγορία διευθύνσεων· στο τέλος ορίζεται ο ακριβής έλεγχος που δίνει τον
πραγματικό αριθμό. Σημειώνεται επίσης ότι οι αναζητήσεις εκτελέστηκαν από τοποθεσία εκτός
Ελλάδας, οπότε η σειρά των αποτελεσμάτων που βλέπετε εσείς από την Ελλάδα ενδέχεται να διαφέρει.

### 1. Η επιχείρησή σας εμφανίζεται μέσα από έξι ξεχωριστές ιδιοκτησίες

Επιβεβαιώθηκαν ενεργές και ευρετηριασμένες:

1. **`www.sanihellas.gr`** — το κύριο κατάστημα, στα ελληνικά και στα αγγλικά
2. **`sanihellas.gr`** (χωρίς `www`) — εμφανίστηκε στα αποτελέσματα με τη διεύθυνση `sanihellas.gr/thermansi/thermopompoi.html`
3. **`sanihellas.wordpress.com`** — παλαιό ιστολόγιο, εξακολουθεί να είναι ενεργό
4. **`noboadvantage.gr`** — ιστότοπος επωνυμίας NOBO
5. **`kullhaus.gr`** — ιστότοπος επωνυμίας Kullhaus
6. **`meaco.gr`** και **`atlantic-heating.gr`** — ιστότοποι επωνυμιών Meaco και Atlantic

Οι τέσσερις ιστότοποι επωνυμιών είναι σαφώς σχεδιασμένοι, ενημερωμένοι και με σωστούς τίτλους.
**Δεν αποτελούν πρόβλημα** και δεν προτείνεται καμία ενέργεια γι' αυτούς. Το παλαιό ιστολόγιο
WordPress είναι διαφορετική περίπτωση (σημείο 4 παρακάτω).

### 2. Μέσα στο κύριο site συνυπάρχουν τέσσερις διαφορετικές μορφές διευθύνσεων

| Μορφή | Παράδειγμα |
|---|---|
| Με πρόθεμα γλώσσας | `www.sanihellas.gr/el-gr/afygrantires` |
| Αγγλική έκδοση | `www.sanihellas.gr/en/heating` |
| Χωρίς πρόθεμα γλώσσας | `www.sanihellas.gr/afygrantiras-gia-spiti-me-thermansi/` και `www.sanihellas.gr/faq/thermopompoi-atlantic` |
| Παλαιά μορφή `.html` | `www.sanihellas.gr/thermansi.html` και `sanihellas.gr/thermansi/thermopompoi.html` |

Παρατηρήθηκαν επίσης δύο ζητήματα ονοματοδοσίας:

- Η λέξη «αφυγραντήρες» γράφεται με λατινικούς χαρακτήρες **με τουλάχιστον τρεις διαφορετικούς
  τρόπους** μέσα στις διευθύνσεις σας: `afygrantires`, `afugranthres`, `afygrantiras`. Δύο
  διαφορετικές διευθύνσεις οδηγούν σε προϊόντα Meaco:
  `/el-gr/afygrantires/meaco/` και `/el-gr/afugranthres/meaco/`.
- Η σελίδα `www.sanihellas.gr/el-gr/afugranthres/meaco/` επέστρεψε **δύο φορές** σε αποτελέσματα
  αναζήτησης με τίτλο μόνο τη λέξη `sani`. Πρόκειται για εμπορική σελίδα χωρίς ουσιαστικό τίτλο.

### 3. Πέντε διαφορετικές διευθύνσεις εμφανίζονται με **τον ίδιο ακριβώς τίτλο**

Αυτό είναι το σημαντικότερο τεχνικό εύρημα. Ο τίτλος
*«SANI HELLAS αντιπρόσωποι Kullhaus, Meaco, Nobo, Atlantic»* παρατηρήθηκε σε πέντε διαφορετικές
διευθύνσεις:

1. `www.sanihellas.gr/el-gr/` (αρχική)
2. `www.sanihellas.gr/el-gr/contact/` (επικοινωνία)
3. `www.sanihellas.gr/thermansi.html`
4. `sanihellas.gr/thermansi/thermopompoi.html`
5. `www.sanihellas.gr/en/nobo-convectors/`

**Αυτό που διαπιστώθηκε είναι το γεγονός, όχι η αιτία του.** Τέσσερις διαφορετικές αιτίες θα
παρήγαγαν ακριβώς την ίδια εικόνα: οι παλιές διευθύνσεις να ανακατευθύνουν στην αρχική· να
επιστρέφουν κανονικά το περιεχόμενο της αρχικής· να επιστρέφουν σφάλμα που μοιάζει με κανονική
σελίδα· ή οι σελίδες να είναι διαφορετικές αλλά να μοιράζονται έναν σταθερό τίτλο που δεν
εξατομικεύτηκε ποτέ.

Η τέταρτη εξήγηση είναι ιδιαίτερα πιθανή, επειδή οι διευθύνσεις 2 και 5 **δεν είναι παλαιές** —
είναι ενεργές, τρέχουσες σελίδες. Οι έλεγχοι 1 και 2 στο τέλος ξεχωρίζουν τις περιπτώσεις σε
λίγα λεπτά. Η διόρθωση διαφέρει ριζικά ανάλογα με το ποια ισχύει, γι' αυτό και δεν προτείνεται
καμία ενέργεια πριν από τον έλεγχο.

**Θετικό στοιχείο:** στις δύο εμπορικές αναζητήσεις που έγιναν
(«θερμοπομποί χαμηλής κατανάλωσης τιμές» και «αφυγραντήρες Meaco τιμές Ελλάδα») **δεν** εμφανίστηκε
ούτε το παλαιό ιστολόγιο ούτε οι παλαιές διευθύνσεις `.html`. Εμφανίστηκε το κύριο site.
Δηλαδή, με βάση αυτά τα δύο ερωτήματα, δεν φαίνεται να χάνετε θέσεις από τις παλιές σελίδες.
Επισημαίνεται όμως ότι δύο αναζητήσεις δεν αποδεικνύουν ότι αυτό ισχύει παντού.

### 4. Το παλαιό ιστολόγιο WordPress δημοσιεύει **λανθασμένα στοιχεία επιχείρησης**

Εδώ βρίσκεται η πραγματική ζημιά — και δεν αφορά κατατάξεις, αφορά την ακρίβεια των στοιχείων σας.

Το `sanihellas.wordpress.com` εμφανίζει διεύθυνση **«Πραξιτέλους 9, 105 62 Αθήνα»**. Τέσσερις
άλλες πηγές (ο ιστότοπος `kullhaus.gr` και οι κατάλογοι `vrisko.gr`, `xo.gr`, `11888.gr`)
συμφωνούν σε **Κωστή Παλαμά 5-7, Νέα Χαλκηδόνα**. Τα τηλέφωνα (210 3236627, 210 3233766)
συμφωνούν παντού.

Επιπλέον, το ίδιο ιστολόγιο προβάλλει στον τίτλο του την επωνυμία **«ΙΟΝΙΣΤΕΣ HEAVEN FRESH»** —
μια επωνυμία που δεν εμφανίζεται στο τρέχον χαρτοφυλάκιό σας.

Με απλά λόγια: μια σελίδα με το όνομά σας λέει σήμερα σε επισκέπτες και σε συστήματα αναζήτησης
ότι βρίσκεστε σε άλλη διεύθυνση και ότι εμπορεύεστε άλλη επωνυμία. Αυτό είναι το πιο άμεσα
διορθώσιμο εύρημα της αξιολόγησης.

### 5. Η ταυτότητα της επιχείρησης καταγράφεται με πολλές μορφές

Στα δημόσια αρχεία εντοπίστηκαν, μεταξύ άλλων: `Sani Hellas`, `SANI HELLAS`, `SaniHellas`,
`Sani hellas SA`, `SANI HELLAS ΕΙΣΑΓΩΓΙΚΗ ΕΞΑΓΩΓΙΚΗ ΜΟΝΟΠΡΟΣΩΠΗ ΑΕ`, `SANI HELLAS Α.Ε.` και —
στον κατάλογο `vres.gr` — **`SANI ΕΛΛΑΣ Ε.Π.Ε.`**, δηλαδή με ελληνικούς χαρακτήρες και με
**διαφορετική νομική μορφή**. Το τελευταίο δείχνει παλαιά καταχώριση που δεν ενημερώθηκε.

Σημειώνεται επίσης ότι η σκέτη λέξη «Sani» σε ελληνικό περιβάλλον επιστρέφει κατά κύριο λόγο ένα
μεγάλο ξενοδοχειακό συγκρότημα στη Χαλκιδική. Δεν παρατηρήθηκε σύγχυση στις εμπορικές
αναζητήσεις σας, αλλά είναι λόγος να χρησιμοποιείται πάντα η πλήρης μορφή της επωνυμίας.

### 6. Η σύνδεση με τις επωνυμίες που αντιπροσωπεύετε

Δοκιμάστηκε με αναζητήσεις τύπου «επωνυμία + κατηγορία».

| Αναζήτηση | Αποτέλεσμα |
|---|---|
| Kullhaus + αφυγραντήρες + αντιπρόσωπος | **Εμφανιστήκατε** — τόσο το κύριο site όσο και το `kullhaus.gr` |
| Nobo + θερμοπομποί + Atlantic | **Εμφανιστήκατε** ισχυρά, με σαφή αναφορά σε αποκλειστική αντιπροσώπευση |
| Meaco + αφυγραντήρες + επίσημος αντιπρόσωπος | **Εμφανιστήκατε** — αλλά με σημαντική επιφύλαξη |

**Η επιφύλαξη για τη Meaco.** Στα αποτελέσματα της συγκεκριμένης αναζήτησης, το κείμενο που
επέστρεψε η μηχανή ανέφερε ότι και άλλη εταιρεία (`zesta.gr`) αναγνωρίζεται ως επίσημος
αντιπρόσωπος Meaco στην Ελλάδα, ενώ στα ίδια αποτελέσματα εμφανίστηκαν και σελίδες προϊόντων
Meaco από τον ίδιο ιστότοπο.

Διατυπώνεται με ακρίβεια: **δεν διαπιστώνεται ποιος κατέχει πράγματι την αντιπροσώπευση.** Αυτό
είναι συμβατικό ζήτημα και το γνωρίζετε εσείς, όχι μια μηχανή αναζήτησης. Αυτό που διαπιστώνεται
είναι ότι **η δημόσια εικόνα της αποκλειστικότητας για τη Meaco αμφισβητείται μέσα στα ίδια τα
αποτελέσματα αναζήτησης**. Για επιχείρηση που στηρίζεται στην ιδιότητα του επίσημου καναλιού,
αυτό είναι το εύρημα με τη μεγαλύτερη εμπορική σημασία σε όλο το κείμενο.

### 7. Ένα σαφώς θετικό εύρημα

Στην αναζήτηση «καλύτερος αφυγραντήρας για σπίτι 2026 ποιον να διαλέξω», **πρώτο αποτέλεσμα** ήταν
δικό σας άρθρο: `www.sanihellas.gr/el-gr/blog/post/17851/…`, μπροστά από ιστότοπους συγκριτικών
αξιολογήσεων. Το ιστολόγιο του κύριου site είναι ενεργό και ενημερωμένο, με άρθρα έως και τον
Αύγουστο του 2026. Ό,τι και αν διορθωθεί στη δομή των διευθύνσεων, **αυτό το κομμάτι αποδίδει και
πρέπει να προστατευθεί.**

### 8. Γιατί δεν δίνεται συνολική βαθμολογία υγείας

Δεν ήταν δυνατή η μέτρηση κανενός από τα στοιχεία στα οποία στηρίζεται μια τέτοια βαθμολογία —
ταχύτητα, `robots.txt`, χάρτης ιστότοπου, κανονικές διευθύνσεις, κεφαλίδες απόκρισης. Μια
βαθμολογία χωρίς αυτές τις μετρήσεις θα ήταν κατασκευασμένος αριθμός. Επομένως **δεν δίνεται
βαθμολογία**, και αντ' αυτού ορίζονται ακριβώς οι έλεγχοι που θα την καταστήσουν δυνατή.

### 9. Οι έλεγχοι που πρέπει να γίνουν — με σειρά προτεραιότητας

Όλοι είναι έλεγχοι ανάγνωσης. Κανένας δεν μεταβάλλει τίποτε στον ιστότοπο.

1. **Τι επιστρέφουν οι παλαιές διευθύνσεις `.html` και το `sanihellas.gr` χωρίς `www`.**
   Απαντά στο ερώτημα του σημείου 3 και είναι ο σημαντικότερος έλεγχος.
2. **Ποια κανονική διεύθυνση (canonical) δηλώνει καθεμία από τις πέντε σελίδες** του σημείου 3.
3. **Ανάγνωση του `robots.txt` και του χάρτη ιστότοπου** στο `www.sanihellas.gr`.
4. **Πραγματικός αριθμός σελίδων ανά μορφή διεύθυνσης**, από το Google Search Console
   (Ευρετηρίαση → Σελίδες, με φίλτρο για `/el-gr/`, `/en/`, `.html`, `?pagesize=`).
   Το Search Console δίνει *μετρημένο* αριθμό· ο αριθμός που εμφανίζει μια αναζήτηση `site:` στον
   browser είναι εκτίμηση και δεν πρέπει να καταγράφεται ως μέτρηση.
5. **Επιβεβαίωση της ισχύουσας διεύθυνσης** και σύγκριση με το `sanihellas.wordpress.com` και με
   τις καταχωρίσεις σε `vrisko.gr`, `xo.gr`, `11888.gr` και `vres.gr` — ιδίως με την καταχώριση
   `SANI ΕΛΛΑΣ Ε.Π.Ε.` που αναφέρει διαφορετική νομική μορφή.
6. **Απόφαση για το παλαιό ιστολόγιο WordPress**: διόρθωση των στοιχείων ή απόσυρση. Όσο
   παραμένει ως έχει, δημοσιεύει λανθασμένη διεύθυνση με το όνομά σας.
7. **Έλεγχος παρουσίας σε Wikidata** και αν εμφανίζεται πίνακας γνώσης (Knowledge Panel) σε
   επώνυμη αναζήτηση **από την Ελλάδα**.
8. **Επιβεβαίωση της συμβατικής θέσης σας για τη Meaco** και, στη συνέχεια, απόφαση για τον τρόπο
   που δηλώνεται δημόσια.
