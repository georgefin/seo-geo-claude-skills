# LocalBusiness Schema — Κλιματισμός Οικονόμου Ο.Ε.

### Schema Analysis

**Content Type**: Local business contact page
**Page URL**: https://www.klimatismos-oikonomou.gr/epikoinonia

**Data source**: everything below is user-provided — the contact page copy you attached. No web crawler was connected and no page fetch was made (you supplied the copy, and the URL you gave is where the markup gets installed, not a source to read). Nothing in the block comes from anywhere else.

**Eligible Rich Results**:

| Rich Result Type | Eligibility | Impact |
|------------------|-------------|--------|
| LocalBusiness | Supports the business entity | Corroborates name, address, phone and hours; placement is not promised from page markup |

**Recommended Schema**:

- **Primary type (ONE per page)**: `HVACBusiness` — the schema.org subtype of LocalBusiness for heating, ventilation and air-conditioning contractors. The page is the business's own contact page and the services listed (εγκατάσταση, συντήρηση, αντλίες θερμότητας, ψυκτικοί θάλαμοι) are exactly what that type describes. A plain `LocalBusiness` would also validate; the subtype is strictly more accurate, and every LocalBusiness property still applies to it.
- **Auxiliaries (only if page data warrants)**: none. There is no breadcrumb trail in the copy you sent, so no BreadcrumbList. The services are nested inside the business as an offer catalogue rather than emitted as separate top-level objects.

---

### Schema Markup

```json
{
  "@context": "https://schema.org",
  "@type": "HVACBusiness",
  "@id": "https://www.klimatismos-oikonomou.gr/epikoinonia",
  "name": "Κλιματισμός Οικονόμου Ο.Ε.",
  "description": "Εγκατάσταση, συντήρηση και επισκευή κλιματιστικών και αντλιών θερμότητας στην Αθήνα και σε όλη την Αττική από το 1998.",
  "url": "https://www.klimatismos-oikonomou.gr",
  "telephone": "210 976 5432",
  "email": "info@klimatismos-oikonomou.gr",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "Λεωφόρος Βουλιαγμένης 274",
    "addressLocality": "Άγιος Δημήτριος",
    "addressRegion": "Αττική",
    "postalCode": "173 43",
    "addressCountry": "GR"
  },
  "areaServed": {
    "@type": "AdministrativeArea",
    "name": "Αττική"
  },
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      "opens": "08:00",
      "closes": "16:00"
    },
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": "Saturday",
      "opens": "09:00",
      "closes": "14:00"
    }
  ],
  "hasOfferCatalog": {
    "@type": "OfferCatalog",
    "name": "Υπηρεσίες",
    "itemListElement": [
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Εγκατάσταση κλιματιστικών (οικιακά και επαγγελματικά συστήματα)"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Συντήρηση και καθαρισμός μονάδων κλιματισμού"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Αντλίες θερμότητας"
        }
      },
      {
        "@type": "Offer",
        "itemOffered": {
          "@type": "Service",
          "name": "Ψυκτικοί θάλαμοι για επαγγελματικούς χώρους"
        }
      }
    ]
  }
}
```

---

### Rich-Result Eligibility

**Eligible for**: no rich result of its own that we would promise you. **What feeds it**: the emitted `name`, `address`, `telephone` and `openingHoursSpecification` corroborate the business entity — same name, same street, same phone, same hours — wherever Google reads this page. **Caveat**: this markup supports how the business is understood; it does not by itself place you in the local pack, no placement is promised, and any effect follows the next crawl rather than the save.

---

### Property Notes — Required vs Optional

| Property | Status for this type | In the block? |
|---|---|---|
| `@type` | Required | Yes — `HVACBusiness` |
| `name` | Required | Yes |
| `address` (PostalAddress) | Required | Yes |
| `address.streetAddress` | Required | Yes |
| `address.addressLocality` | Required | Yes |
| `address.addressRegion` | Required | Yes |
| `address.postalCode` | Required | Yes |
| `address.addressCountry` | Required | Yes — `GR` |
| `telephone` | Recommended | Yes |
| `openingHoursSpecification` | Recommended | Yes |
| `geo` | Recommended | **No — see below** |
| `priceRange` | Recommended | **No — see below** |
| `image` | Recommended | **No — see below** |
| `aggregateRating` | Recommended | **No, deliberately** — your page shows no ratings, and a rating that is not visible on the page is a content-mismatch violation that puts rich results at risk across the whole site. Add it only when real reviews are published on the page |

Three decisions inside the block worth knowing about, because each one is a place where I used your page's own wording rather than a tidier form:

- **`addressCountry` is `GR`, not "Ελλάδα" or "Greece".** The property takes the ISO 3166-1 alpha-2 code, so the country you state as Αττική is written `GR`. This is the one place a value is transcoded rather than copied.
- **`telephone` is the page's exact string, `210 976 5432`.** You asked for exactly the details listed, so that is what is in the block. If you would rather have the international form, the correct value is `+30 210 976 5432` — it parses more reliably for non-Greek crawlers and click-to-call. Swap the string if you want it; nothing else changes.
- **Sunday is not in `openingHoursSpecification` at all.** Days omitted from the specification are read as closed, which is what «Κυριακή — Κλειστά» says. The alternative encoding is a Sunday entry with `opens` and `closes` both set to `00:00`; I did not use it because it writes clock times your page never states.

The page's «από το 1998» is carried in `description` rather than in a `foundingDate` property. "Serving Attica since 1998" and "founded in 1998" are not the same claim, and the page only makes the first one. If 1998 genuinely is the founding year, say so and `"foundingDate": "1998"` goes in.

**Missing data — three properties dropped rather than guessed:**

1. **`geo` (latitude/longitude)** — omitted. Coordinates are the one property that pins the business to a point rather than to a string, and Λεωφόρος Βουλιαγμένης is long enough that the number matters. Send me the decimal latitude and longitude of the shop entrance — the pair Google Maps shows in the URL when you drop a pin on it, e.g. two numbers of the shape `37.9…` and `23.7…` — and it becomes a four-line `geo` block. I have not put an approximate pair in: a coordinate that is nearly right is worse than none, because it silently disagrees with your address.
2. **`priceRange`** — omitted. It is a coarse affordability signal (`€€`, or a range like `€50-€300`). Nothing on the contact page states one, and inventing a band would be a claim about your pricing that you never made. Tell me the band you would put on a callout and it becomes one line.
3. **`image`** — omitted. A photo of the premises or the van, or the company logo, helps disambiguate the entity. Send the absolute URL of one image hosted on your own domain (`https://www.klimatismos-oikonomou.gr/...`) and it becomes one line.

Everything else on the page is in the block. Nothing in the block is anywhere but on the page.

---

## Implementation Guide

### Adding Schema to Your Page

**Option 1: In HTML `<head>`**

```html
<head>
  <script type="application/ld+json">
    ...the full JSON-LD block from above, pasted verbatim...
  </script>
</head>
```

**Option 2: Before closing `</body>`**

```html
  <script type="application/ld+json">
    ...the full JSON-LD block from above, pasted verbatim...
  </script>
</body>
```

Either location works. Put it in `<head>` if your template makes that easy; the only thing that matters is that it is in the server-rendered HTML source, not injected by JavaScript after load.

Serve the page as UTF-8 (`<meta charset="utf-8">`). The block is full of Greek characters and an encoding mismatch will corrupt them into question marks in the source, which breaks the content match even though the visible page looks fine.

### Validation Steps

1. **Google Rich Results Test** — https://search.google.com/test/rich-results
   Test the live URL or paste the code. Check for errors and warnings.

2. **Schema.org Validator** — https://validator.schema.org/
   Validates against the Schema.org specification. This is the one that will confirm `HVACBusiness` is a real type and that every property you used is defined on it.

3. **Google Search Console**
   Monitor the Enhancements reports for issues once the page is recrawled. There is no LocalBusiness-specific enhancement report, so what you are watching for here is errors, not a new appearance.

### Validation Checklist

- [ ] JSON syntax is valid (no trailing commas)
- [ ] All required properties present
- [ ] URLs are absolute, not relative
- [ ] Dates are ISO 8601 at the precision the page states
- [ ] Content matches visible page content
- [ ] No policy violations

The first five hold in the block exactly as written above — I checked each against the copy you sent. Re-run the list yourself after you paste it, because the paste is where things break: a smart-quote substitution or a dropped brace is the usual cause of a block that validated in an email and fails on the page.
