# Event Schema — Aerial Yoga for Beginners, Autumn Workshop

**Short answer: Event, not Organization, and not both.** The page IS a workshop — a thing that happens at a time, in a place, for a price. That is what `Event` describes, so `Event` is the one primary type this page needs. Wildbird Yoga does not disappear from the markup; the studio goes *inside* the Event as its `organizer`. You get both entities, but one of them is a property of the other rather than a second object sitting beside it.

**Why not both as separate top-level types.** A page carries one primary type — the type that says what the page is. Two top-level types both making that claim is stacking, and it buys nothing: no engine documents a citation gain from extra types, while every extra type adds maintenance surface and a way for the markup to disagree with the page. A standalone `Organization` block does have a right home — your homepage, where the page genuinely is *about the studio*. On a workshop page it is the wrong claim, because this page is not about Wildbird Yoga; it is about one Saturday in September.

---

### Schema Analysis

**Content Type**: single-occurrence event page (workshop)
**Page URL**: https://www.wildbirdyoga.co.uk/workshops/aerial-beginners-autumn

**Data source**: user-provided — the page copy you wrote up. No crawler connected, no fetch of the live URL; the copy you sent is the source, and it is the thing the schema has to match.

**Eligible Rich Results**:

| Rich Result Type | Eligibility | Impact |
|------------------|-------------|--------|
| Event | ✅ | Medium — shows date, venue and ticket price |

**Recommended Schema**:

- **Primary type (ONE per page)**: `Event` — the page describes a single scheduled occurrence with a date, a start and end time, a physical venue, a price and a booking route. Every one of those is a first-class `Event` property.
- **Nested inside it**: `location` (a `Place` with its `PostalAddress`), `offers` (the £35 ticket and the booking URL), and `organizer` (Wildbird Yoga, with its website). These are properties of the event, not separate page-level types.
- **Auxiliaries (only if page data warrants)**: none in the copy you sent. If the live page has a breadcrumb trail — Home → Workshops → this workshop — send me the labels and URLs and a `BreadcrumbList` goes alongside as a documented second object. Breadcrumb display is a live, separately-documented Google feature, which is what makes it a legitimate auxiliary rather than more stacking.

---

### Schema Markup

```json
{
  "@context": "https://schema.org",
  "@type": "Event",
  "name": "Aerial Yoga for Beginners — Autumn Workshop",
  "description": "A three-hour introduction to aerial yoga, suitable for complete beginners. Mats and hammocks provided. Maximum 12 places per session.",
  "startDate": "2026-09-19T10:00",
  "endDate": "2026-09-19T13:00",
  "eventStatus": "https://schema.org/EventScheduled",
  "eventAttendanceMode": "https://schema.org/OfflineEventAttendanceMode",
  "maximumAttendeeCapacity": 12,
  "location": {
    "@type": "Place",
    "name": "The Loft Studio",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "14 Ropewalk Lane",
      "addressLocality": "Norwich",
      "postalCode": "NR1 3EX",
      "addressCountry": "GB"
    }
  },
  "offers": {
    "@type": "Offer",
    "url": "https://www.wildbirdyoga.co.uk/book/aerial-beginners-autumn",
    "price": "35",
    "priceCurrency": "GBP"
  },
  "organizer": {
    "@type": "Organization",
    "name": "Wildbird Yoga",
    "url": "https://www.wildbirdyoga.co.uk"
  }
}
```

---

### Rich-Result Eligibility

**Eligible for**: the event snippet on your search result — the date, the venue and the ticket price shown alongside the listing. **What feeds it**: the emitted `startDate` and `endDate`, the `location` block (venue name plus street, city and postcode) and `offers` (`price` 35, `priceCurrency` GBP, and the booking `url`); `image` is a recommended property for this type and is missing, so the snippet will render without a picture until you send one. **Caveat**: correct markup makes the page eligible, not guaranteed — Google decides per query and per device — and any change usually surfaces days to weeks after the next crawl, which for a dated event means getting the markup up well before September rather than the week of.

---

### Property Notes — Required vs Optional

| Property | Status | In the block? |
|---|---|---|
| `@type` | Required — `Event` | Yes |
| `name` | Required | Yes |
| `startDate` | Required | Yes |
| `location` | Required | Yes — `Place` with nested `PostalAddress` |
| `endDate` | Recommended | Yes |
| `description` | Recommended | Yes |
| `eventStatus` | Recommended | Yes — `EventScheduled` |
| `eventAttendanceMode` | Recommended | Yes — `OfflineEventAttendanceMode` |
| `offers` | Recommended | Yes |
| `organizer` | Recommended | Yes — this is where the studio lives |
| `image` | Recommended | **No — see below** |
| `performer` | Recommended | **No — see below** |
| `offers.availability` | Recommended | **No, deliberately — see below** |

**Three decisions inside the block that are worth a sentence each:**

- **The times carry no timezone, and that is on purpose.** Your page says "10:00 – 13:00" and does not say which clock. `2026-09-19T10:00` is valid ISO 8601 and means exactly that: the venue's own local clock time, ten in the morning. The alternative is to append an offset — for a Norwich venue in September that would be `+01:00`, giving `2026-09-19T10:00:00+01:00` — but I am not putting a zone in your markup on the strength of my own guess about the venue's clock. If you confirm the offset, say so and I will write it in. A wrong offset is worse than none: it silently moves the workshop by an hour in every consumer that reads it.
- **`addressCountry` is `GB`, not `UK`.** The property takes the ISO 3166-1 alpha-2 code. "UK" is not one — it is a common habit, and validators reject it. `GB` is the code for the United Kingdom.
- **`addressRegion` is absent** because your copy does not state a county. Norfolk would be a reasonable guess and I have not made it; a UK address with a valid postcode resolves without a region. Add `"addressRegion": "Norfolk"` if you want it, but nothing depends on it.

`eventStatus` is set to `EventScheduled`, which is the accurate value today. **It is not a set-and-forget line.** If the workshop is cancelled, postponed, rescheduled or moved online, that property has to change with it (`EventCancelled`, `EventPostponed`, `EventRescheduled`, `EventMovedOnline`) — a cancelled event still publishing `EventScheduled` is the single most visible way this markup can go wrong.

**Missing data — what was left out rather than guessed:**

1. **`image`** — omitted. An event snippet with a photograph of a hammock in your studio is a different proposition from one without. Send me the absolute URL of one image on your own domain (`https://www.wildbirdyoga.co.uk/...`), landscape and at least 1200px wide if you have it, and it becomes one line. I have not put a stand-in URL in the block, because a broken image URL in structured data is an error, not a placeholder.
2. **`performer`** — omitted. If a named instructor is teaching this workshop, they belong here as a nested `Person`, and it is a genuine credibility signal for a beginners' class. Your copy names nobody, so nobody is in the markup. Send the name and it goes in.
3. **`offers.availability`** — omitted deliberately, and this is the one I would push back on if you asked me to add it. You have twelve places. Whether any are left is a fact that changes daily, and static markup cannot track it. Hard-coding `InStock` means a sold-out workshop keeps advertising availability until someone remembers to edit the page. Either leave it out — which is what I have done — or have your booking system write it, in which case it should flip to `https://schema.org/SoldOut` when the twelfth place goes.
4. **`offers.validFrom`** — omitted; your copy does not say when booking opened. Harmless to leave out.

The `maximumAttendeeCapacity` of 12 *is* in the block, because "Maximum 12 places per session" is a fixed fact about the workshop rather than a live inventory count. That is the line between the two.

Everything in the block came off your page. "Three-hour", "complete beginners", "mats and hammocks provided" and the twelve-place cap are all your own words or your own numbers, condensed into `description` without adding a claim.

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

Either location is fine. The block must be in the HTML the server sends, not added by JavaScript after the page loads.

One thing specific to a dated event: **decide now what happens to this page on 20 September.** If the workshop is a one-off and the page comes down, the markup goes with it. If you re-run the workshop and reuse the URL, the `startDate`, `endDate` and `name` all have to be updated in the same edit — an Event block still advertising a date that has passed is the most common structured-data error on studio and venue sites, and it is entirely self-inflicted.

### Validation Steps

1. **Google Rich Results Test** — https://search.google.com/test/rich-results
   Test the live URL or paste the code. Event is fully supported here, so this tool will tell you directly whether the snippet is eligible and what it thinks is missing.

2. **Schema.org Validator** — https://validator.schema.org/
   Validates against the Schema.org specification. Use it to confirm the nesting is right — that `Place`, `PostalAddress`, `Offer` and `Organization` are sitting where they should be rather than floating at the top level.

3. **Google Search Console**
   Watch the Enhancements section for the Events report after the page is recrawled. Errors there are worth acting on quickly, because a dated event has a short window in which the markup is useful at all.

### Validation Checklist

- [ ] JSON syntax is valid (no trailing commas)
- [ ] All required properties present
- [ ] URLs are absolute, not relative
- [ ] Dates are ISO 8601 at the precision the page states
- [ ] Content matches visible page content
- [ ] No policy violations

All six hold in the block as written — I checked the date and time form, both URLs, and every value against your copy. Re-run the list after you paste, and re-run it again if you ever change the date.
