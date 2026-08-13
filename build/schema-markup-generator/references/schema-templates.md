# Schema.org JSON-LD Templates

Structured-data **skeletons** for all major schema types. Nothing in this file is a deliverable.

---

## How to read this file (the value rule)

Every JSON block below is a skeleton: `[BRACKET SLOTS]` mark values you fill from the page's own data. Each one opens with a `"_SKELETON"` member so the marker travels with the code when only the fence is copied — a JSON-LD processor ignores an unmapped term, so it stays valid JSON, and if a validator ever flags `_SKELETON` on a live page, that is the marker doing its job: the block shipped unfilled. Delete that line when you fill the template.

**What a deliverable looks like instead**: every value resolved from the page or the supplied data, and no bracket token anywhere in it. When a value cannot be sourced — the image asset does not exist yet, no coordinates were supplied, the logo URL is unknown — **drop that property from the block and name the gap in the report prose**, where the person who can fix it will read it: which property, what it costs, and exactly what to send. What never goes inside a JSON-LD value in a deliverable: a bracket token, `TBD`, `XX`, a note shaped like a value (`"your-logo.png"`), or a plausible-looking invented number.

**The one exception**: when the user asked for a fill-in template rather than finished markup, brackets are correct — and then the block keeps its `"_SKELETON"` line, so it is unmistakably not ship-ready. Bracket notation is SCREAMING-KEBAB inside square brackets: `[LATITUDE]`, `[PRICE-RANGE]`, `[IMAGE-URL]`, `[EVENT-IMAGE-URL]`, `[PUBLISHER-LOGO-URL]`.

**Dates**: ISO 8601 at the precision the page states — `2025-03-12` where the page shows a date and no time, `2025-03-12T09:00:00+02:00` where it states a time. Never invent a time to reach the longer form.

Provenance: SKILL.md step 2 (*Missing data — the value rule*), ledger F13 (placement class), and `build/seo-content-writer/references/anti-slop-ruleset.md` §6. The same split is applied to HTML tags in meta-tags-optimizer.

---

## FAQPage Schema

For a page whose one primary type is FAQPage — a dedicated FAQ or Q&A page, not an FAQ section inside a page that already carries an accurate type (that is stacking, settled ruling R2). One Question object per visible Q&A pair. No Google rich result (FAQ rich results retired 2026); still generated because it is valid schema.org, costs nothing to keep, and Google says there is no need to proactively remove it (settled ruling R3 + amendment 9a). **Not** because engines extract from it — 9a records that no primary source establishes a citation benefit in either direction, so never sell it as one. Validate with the Schema.org validator — the Rich Results Test no longer supports FAQ.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "[Question text - exactly as shown on page]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Complete answer text - must match visible content]"
      }
    },
    {
      "@type": "Question",
      "name": "[Question 2]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer 2]"
      }
    },
    {
      "@type": "Question",
      "name": "[Question 3]",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "[Answer 3]"
      }
    }
  ]
}
```

**Requirements**: Questions must be complete questions, answers must be comprehensive, content must match visible page content.

---

## HowTo Schema

For step-by-step instructional content.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "HowTo",
  "name": "[How-to title - what will users learn]",
  "description": "[Brief description of what this tutorial teaches]",
  "image": {
    "@type": "ImageObject",
    "url": "[Main image URL]",
    "height": "[height in pixels]",
    "width": "[width in pixels]"
  },
  "totalTime": "PT[X]H[Y]M",
  "estimatedCost": {
    "@type": "MonetaryAmount",
    "currency": "USD",
    "value": "[estimated cost or 0]"
  },
  "supply": [
    {
      "@type": "HowToSupply",
      "name": "[Supply item 1]"
    },
    {
      "@type": "HowToSupply",
      "name": "[Supply item 2]"
    }
  ],
  "tool": [
    {
      "@type": "HowToTool",
      "name": "[Tool 1]"
    },
    {
      "@type": "HowToTool",
      "name": "[Tool 2]"
    }
  ],
  "step": [
    {
      "@type": "HowToStep",
      "position": 1,
      "name": "[Step 1 title]",
      "text": "[Step 1 detailed instructions]",
      "url": "[Page URL]#step1",
      "image": "[Step 1 image URL - optional]"
    },
    {
      "@type": "HowToStep",
      "position": 2,
      "name": "[Step 2 title]",
      "text": "[Step 2 detailed instructions]",
      "url": "[Page URL]#step2",
      "image": "[Step 2 image URL - optional]"
    },
    {
      "@type": "HowToStep",
      "position": 3,
      "name": "[Step 3 title]",
      "text": "[Step 3 detailed instructions]",
      "url": "[Page URL]#step3",
      "image": "[Step 3 image URL - optional]"
    }
  ]
}
```

**Time format**: PT[X]H[Y]M where X = hours, Y = minutes. Example: PT1H30M = 1 hour 30 minutes.

---

## Article / BlogPosting / NewsArticle Schema

For blog posts, articles, and news content.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "BlogPosting",
  "headline": "[Article title - max 110 characters for best display]",
  "description": "[Article summary or excerpt]",
  "image": [
    "[Featured image URL - 1200px wide recommended]",
    "[Alternative image URL - 4:3 ratio]",
    "[Alternative image URL - 16:9 ratio]"
  ],
  "datePublished": "[ISO 8601 at the page's own precision: 2024-01-15, or 2024-01-15T08:00:00+00:00 only if the page states a time]",
  "dateModified": "[ISO 8601, same precision rule - same value as published if never modified]",
  "author": {
    "@type": "Person",
    "name": "[Author Full Name]",
    "url": "[Author profile URL]",
    "jobTitle": "[Author job title - optional]"
  },
  "publisher": {
    "@type": "Organization",
    "name": "[Publisher/Company Name]",
    "logo": {
      "@type": "ImageObject",
      "url": "[Publisher logo URL - max 600px wide, 60px high]",
      "width": "[width]",
      "height": "[height]"
    }
  },
  "mainEntityOfPage": {
    "@type": "WebPage",
    "@id": "[Canonical URL of this article]"
  },
  "articleBody": "[Full article text - optional but recommended]",
  "wordCount": "[word count - optional]"
}
```

**Type variants**: Use `Article` for general articles, `BlogPosting` for blog posts, `NewsArticle` for news content, `TechArticle` for technical documentation.

---

## Product Schema

For e-commerce product pages.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "Product",
  "name": "[Product Name]",
  "image": [
    "[Product image URL 1]",
    "[Product image URL 2]",
    "[Product image URL 3]"
  ],
  "description": "[Product description]",
  "sku": "[SKU code]",
  "mpn": "[Manufacturer Part Number - optional]",
  "brand": {
    "@type": "Brand",
    "name": "[Brand Name]"
  },
  "offers": {
    "@type": "Offer",
    "url": "[Product page URL]",
    "priceCurrency": "USD",
    "price": "[Price as number: 29.99]",
    "priceValidUntil": "[Date price is valid until: 2024-12-31]",
    "availability": "https://schema.org/InStock",
    "seller": {
      "@type": "Organization",
      "name": "[Seller/Store Name]"
    },
    "shippingDetails": {
      "@type": "OfferShippingDetails",
      "shippingRate": {
        "@type": "MonetaryAmount",
        "value": "[shipping cost]",
        "currency": "USD"
      },
      "shippingDestination": {
        "@type": "DefinedRegion",
        "addressCountry": "US"
      }
    }
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[4.5]",
    "reviewCount": "[89]",
    "bestRating": "5",
    "worstRating": "1"
  },
  "review": [
    {
      "@type": "Review",
      "reviewRating": {
        "@type": "Rating",
        "ratingValue": "[5]",
        "bestRating": "5"
      },
      "author": {
        "@type": "Person",
        "name": "[Reviewer Name]"
      },
      "reviewBody": "[Review text]",
      "datePublished": "[Review date: 2024-01-15]"
    }
  ]
}
```

**Availability options**: `InStock`, `OutOfStock`, `PreOrder`, `Discontinued`, `LimitedAvailability`, `OnlineOnly`, `InStoreOnly`, `SoldOut`

---

## LocalBusiness Schema

For local business pages with physical locations.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "LocalBusiness",
  "name": "[Business Name]",
  "image": "[Business image or logo URL]",
  "@id": "[Business page URL]",
  "url": "[Website URL]",
  "telephone": "[Phone number: +1-555-555-5555]",
  "priceRange": "[$$$ or price range like $10-$50]",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "[Street address]",
    "addressLocality": "[City]",
    "addressRegion": "[State/Province]",
    "postalCode": "[ZIP/Postal code]",
    "addressCountry": "US"
  },
  "geo": {
    "@type": "GeoCoordinates",
    "latitude": "[latitude as number: 40.7128]",
    "longitude": "[longitude as number: -74.0060]"
  },
  "openingHoursSpecification": [
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"],
      "opens": "09:00",
      "closes": "17:00"
    },
    {
      "@type": "OpeningHoursSpecification",
      "dayOfWeek": "Saturday",
      "opens": "10:00",
      "closes": "15:00"
    }
  ],
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[4.5]",
    "reviewCount": "[123]"
  },
  "servesCuisine": "[Cuisine type - for restaurants only]"
}
```

**Type variants**: Use more specific types when applicable: `Restaurant`, `Store`, `AutoRepair`, `HealthAndBeautyBusiness`, `HomeAndConstructionBusiness`, `HVACBusiness`, `LegalService`, etc.

**Country and currency codes**: `addressCountry` takes the ISO 3166-1 alpha-2 code (`GR`, `GB`, `US`, `DE`) — not a country name, and not `UK`, which is not an alpha-2 code. `priceCurrency` takes the ISO 4217 code (`EUR`, `GBP`, `USD`), never the symbol.

**`aggregateRating` and `review`**: include only where the page itself shows genuine ratings or reviews. No ratings on the page means the property is dropped, not filled — a rating that is not visible is a content-mismatch violation, and it puts rich results across the site at risk.

---

## Organization Schema

For brand/company homepage.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "[Organization Name]",
  "url": "[Website URL]",
  "logo": "[Logo URL - recommended 112x112px or larger]",
  "description": "[Company description]",
  "sameAs": [
    "[Facebook URL]",
    "[Twitter URL]",
    "[LinkedIn URL]",
    "[Instagram URL]",
    "[YouTube URL]"
  ],
  "contactPoint": {
    "@type": "ContactPoint",
    "telephone": "[Phone number]",
    "contactType": "customer service",
    "email": "[Email address]",
    "availableLanguage": ["English", "Spanish"],
    "areaServed": "US"
  },
  "founder": {
    "@type": "Person",
    "name": "[Founder name - optional]"
  },
  "foundingDate": "[YYYY-MM-DD - optional]",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "[Street address]",
    "addressLocality": "[City]",
    "addressRegion": "[State]",
    "postalCode": "[ZIP]",
    "addressCountry": "US"
  }
}
```

---

## BreadcrumbList Schema

For navigation breadcrumbs.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "BreadcrumbList",
  "itemListElement": [
    {
      "@type": "ListItem",
      "position": 1,
      "name": "Home",
      "item": "[Homepage URL]"
    },
    {
      "@type": "ListItem",
      "position": 2,
      "name": "[Category Name]",
      "item": "[Category URL]"
    },
    {
      "@type": "ListItem",
      "position": 3,
      "name": "[Subcategory Name]",
      "item": "[Subcategory URL]"
    },
    {
      "@type": "ListItem",
      "position": 4,
      "name": "[Current Page Name]",
      "item": "[Current Page URL]"
    }
  ]
}
```

**Important**: Position numbers must be sequential starting from 1. Last item should be the current page.

---

## VideoObject Schema

For video content.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "VideoObject",
  "name": "[Video title]",
  "description": "[Video description]",
  "thumbnailUrl": "[Video thumbnail URL - minimum 160x90px]",
  "uploadDate": "[ISO 8601 at the source's own precision: 2024-01-15, or 2024-01-15T08:00:00+00:00 if a time is stated]",
  "duration": "PT[X]M[Y]S",
  "contentUrl": "[Video file URL]",
  "embedUrl": "[Video embed URL]",
  "interactionStatistic": {
    "@type": "InteractionCounter",
    "interactionType": { "@type": "WatchAction" },
    "userInteractionCount": "[view count]"
  }
}
```

**Duration format**: PT[X]M[Y]S where X = minutes, Y = seconds. Example: PT5M30S = 5 minutes 30 seconds.

---

## Event Schema

For events, conferences, concerts, etc.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "Event",
  "name": "[Event Name]",
  "description": "[Event description]",
  "image": "[Event image URL]",
  "startDate": "[ISO 8601: 2024-06-15T19:00:00-05:00 when a start time is stated; 2024-06-15 for an all-day event]",
  "endDate": "[ISO 8601, same form as startDate; drop this property if the page states no end]",
  "eventStatus": "https://schema.org/EventScheduled",
  "eventAttendanceMode": "https://schema.org/OfflineEventAttendanceMode",
  "location": {
    "@type": "Place",
    "name": "[Venue Name]",
    "address": {
      "@type": "PostalAddress",
      "streetAddress": "[Street address]",
      "addressLocality": "[City]",
      "addressRegion": "[State]",
      "postalCode": "[ZIP]",
      "addressCountry": "US"
    }
  },
  "offers": {
    "@type": "Offer",
    "url": "[Ticket purchase URL]",
    "price": "[ticket price]",
    "priceCurrency": "USD",
    "availability": "https://schema.org/InStock",
    "validFrom": "[Sale start date]"
  },
  "organizer": {
    "@type": "Organization",
    "name": "[Organizer name]",
    "url": "[Organizer website]"
  }
}
```

**Event status options**: `EventScheduled`, `EventCancelled`, `EventPostponed`, `EventRescheduled`, `EventMovedOnline`

**Attendance mode**: `OfflineEventAttendanceMode`, `OnlineEventAttendanceMode`, `MixedEventAttendanceMode`

---

## Course Schema

For online courses and educational content.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "Course",
  "name": "[Course Name]",
  "description": "[Course description]",
  "provider": {
    "@type": "Organization",
    "name": "[Provider name]",
    "sameAs": "[Provider URL]"
  },
  "offers": {
    "@type": "Offer",
    "category": "Paid",
    "price": "[price]",
    "priceCurrency": "USD"
  },
  "hasCourseInstance": {
    "@type": "CourseInstance",
    "courseMode": "online",
    "courseWorkload": "PT[X]H",
    "instructor": {
      "@type": "Person",
      "name": "[Instructor name]"
    }
  }
}
```

---

## Recipe Schema

For cooking recipes.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "Recipe",
  "name": "[Recipe name]",
  "image": "[Recipe image URL]",
  "author": {
    "@type": "Person",
    "name": "[Author name]"
  },
  "datePublished": "[ISO 8601 at the page's own precision]",
  "description": "[Recipe description]",
  "prepTime": "PT[X]M",
  "cookTime": "PT[X]M",
  "totalTime": "PT[X]M",
  "recipeYield": "[Servings: e.g., '4 servings']",
  "recipeCategory": "[Category: e.g., 'Dinner']",
  "recipeCuisine": "[Cuisine: e.g., 'Italian']",
  "keywords": "[comma, separated, keywords]",
  "nutrition": {
    "@type": "NutritionInformation",
    "calories": "[calories per serving]"
  },
  "recipeIngredient": [
    "[Ingredient 1 with quantity]",
    "[Ingredient 2 with quantity]",
    "[Ingredient 3 with quantity]"
  ],
  "recipeInstructions": [
    {
      "@type": "HowToStep",
      "text": "[Step 1 instructions]"
    },
    {
      "@type": "HowToStep",
      "text": "[Step 2 instructions]"
    }
  ],
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[4.5]",
    "reviewCount": "[number of reviews]"
  }
}
```

---

## SoftwareApplication Schema

For software, apps, and tools.

```json
{
  "_SKELETON": "not ship-ready — fill every [SLOT] from the page's own data, drop any property you cannot fill, then delete this line",
  "@context": "https://schema.org",
  "@type": "SoftwareApplication",
  "name": "[Software name]",
  "operatingSystem": "[Windows, macOS, iOS, Android, Web]",
  "applicationCategory": "BusinessApplication",
  "offers": {
    "@type": "Offer",
    "price": "[price or 0 for free]",
    "priceCurrency": "USD"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "[4.5]",
    "reviewCount": "[number of reviews]"
  },
  "screenshot": "[Screenshot URL - optional]",
  "softwareVersion": "[version number]",
  "fileSize": "[file size with units: e.g., '50MB']",
  "datePublished": "[Release date]",
  "downloadUrl": "[Download URL - optional]"
}
```

---

## Primary Type + Documented Auxiliary (Combined Array)

Default output is ONE primary type per page (settled ruling R2). Use the array form only when a documented auxiliary legitimately accompanies the primary — e.g., BreadcrumbList for a real breadcrumb trail:

```html
<!-- SKELETON — fill every [slot] from the page's own data; drop any property you cannot fill and name the gap in the report -->
<script type="application/ld+json">
[
  {
    "@context": "https://schema.org",
    "@type": "Article",
    "headline": "[Article title]",
    "author": {
      "@type": "Person",
      "name": "[Author]"
    }
  },
  {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
      {
        "@type": "ListItem",
        "position": 1,
        "name": "Home",
        "item": "[URL]"
      }
    ]
  }
]
</script>
```

Do NOT use the array form to stack a second full content type onto the page (e.g., FAQPage added to an Article or service page hoping more types raise AI-citation odds). No engine documents a citation gain from extra types, and extra markup that mismatches the page risks spam-policy trouble. A page carries two content types only when it genuinely is both things and each type is complete, accurate, and independently justified (ruling R2 boundary).

---

## Implementation Notes

- ONE primary type per page; nest supporting entities inside it — see the array note above (settled ruling R2)
- Always validate at https://validator.schema.org/; additionally test non-FAQ types at https://search.google.com/test/rich-results (FAQ support was cut in 2026)
- Fill every bracketed slot from the page's own data and delete the `"_SKELETON"` line; a property whose value cannot be sourced is DROPPED from the block and named in the report prose, never stood in for (see *How to read this file*)
- Use absolute URLs, not relative paths
- Dates in ISO 8601 at the precision the page states — date-only where no time is shown; never invent a time to reach the longer form
- Schema must match visible page content (Google policy requirement)
- No trailing commas in JSON (invalid syntax)
