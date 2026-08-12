# FAQ Schema — TidyBooks Pricing FAQ

**Before the markup, the thing you need to know**: the FAQ dropdowns are gone, and no markup brings them back. Google ended FAQ rich results in 2026 — the search appearance, the Search Console report, the Enhancements appearance filter and Rich Results Test support for FAQ were all withdrawn. That is why your competitors *used to* have them and no longer do. It is not something they lost and you can win; the feature itself was retired for everyone.

The markup below is still worth shipping, but for a smaller and more honest reason than the one you came in with. I have set that out under **Rich-Result Eligibility**, and I would rather you read it before you paste anything than after.

---

### Schema Analysis

**Content Type**: dedicated FAQ page (SaaS pricing FAQ)
**Page URL**: https://www.tidybooks.app/pricing/faq

**Data source**: user-provided — the visible page copy you sent. No crawler was connected and the live URL was not fetched; you supplied the text, which is the thing the content-match rule has to be checked against.

**Eligible Rich Results**:

| Rich Result Type | Eligibility | Impact |
|------------------|-------------|--------|
| FAQ | ❌ (ended 2026) | No SERP result. The markup is valid and cheap to keep; no evidenced citation benefit either way |

**Recommended Schema**:

- **Primary type (ONE per page)**: `FAQPage`. This page is a Q&A page and nothing else — four questions, four answers, no product pitch or feature tour wrapped around them. That is the narrow case where FAQPage is the type the page IS, rather than a type bolted onto a page that already has one. (Had these four questions sat inside your main pricing page, the primary type would be the pricing page's own type, `FAQPage` on top of it would be stacking, and the visible Q&A block would carry the value on its own.)
- **Auxiliaries**: none. There is no breadcrumb trail in the copy you sent. If the live page has one — Home → Pricing → FAQ — send me the labels and URLs and a `BreadcrumbList` goes alongside as a second top-level object; breadcrumb display is a separate, still-live Google feature and is the one auxiliary worth having here.

---

### Schema Markup

```json
{
  "@context": "https://schema.org",
  "@type": "FAQPage",
  "mainEntity": [
    {
      "@type": "Question",
      "name": "How much does TidyBooks cost?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "TidyBooks starts at $12 per month for the Solo plan. The Team plan is $29 per month for up to 10 users, and the Firm plan is $79 per month with unlimited users and priority support. All prices are billed in USD."
      }
    },
    {
      "@type": "Question",
      "name": "Is there a free trial?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Yes. Every plan includes a 30-day free trial with full access to all features. No credit card is required to start, and you can export your data at any time."
      }
    },
    {
      "@type": "Question",
      "name": "Can I cancel my subscription at any time?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Yes, you can cancel from your account settings at any time. Your plan stays active until the end of the current billing period, and we do not charge cancellation fees."
      }
    },
    {
      "@type": "Question",
      "name": "Do you offer a discount for annual billing?",
      "acceptedAnswer": {
        "@type": "Answer",
        "text": "Yes. Paying annually saves 20% compared with monthly billing on every plan. The discount is applied automatically at checkout when you choose annual billing."
      }
    }
  ]
}
```

Every question and every answer is your page's own wording, transcribed exactly — the wrapped lines are joined, nothing is paraphrased, shortened or smoothed. That is deliberate: if the schema text and the visible text drift apart, the markup becomes a content-mismatch problem instead of a neutral one.

---

### Rich-Result Eligibility

**Eligible for**: nothing in Google Search. FAQ rich results ended in 2026 — the appearance, Search Console reporting, the Enhancements appearance filter and Rich Results Test support went with them, and Search Console API support is scheduled to end in August 2026. There is no accordion to earn here and I am not going to imply otherwise. **What feeds it**: the four `Question` / `acceptedAnswer` pairs are valid schema.org and machine-readable by any consumer that chooses to read them. **Caveat**: eligibility is not an appearance, and in this case there is no appearance to be eligible for — no engine promises to use this markup, and no primary source establishes a citation benefit for it either way.

**So why ship it at all?** Three reasons, and only these three:

1. It is valid schema.org and describes the page accurately.
2. It costs essentially nothing to keep — one script tag, no runtime, no maintenance beyond keeping the four answers in sync with the page.
3. Google's own guidance is that there is no need to proactively remove existing FAQ markup. Ripping it out is work that buys nothing; leaving it in place is the cheaper default.

**What I am not claiming.** You will see it argued that FAQ markup now pays off through AI answer engines instead — that they parse the clean Q&A pairs and cite you more often. I am not going to tell you that, because there is no primary source establishing it either way. Google's own 2026 AI-optimization guidance says structured data is not required for generative AI search and that there is no special schema.org markup you need to add for it — which supports the "not required" half and is not evidence that the pairs get parsed. Treat this markup as machine-readable input, not as a lever.

**Where the value actually is on this page.** It is in the visible Q&A block itself, and you already have it: four real questions in your buyers' own words, each answered completely, in neutral informational language, on a page a buyer can read. That is what serves the reader and what any engine reading the page actually consumes. If you had to choose between the markup and the visible block, you would keep the block without hesitating. You do not have to choose — but that is the ranking.

---

### Property Notes — Required vs Optional

| Property | Status | In the block? |
|---|---|---|
| `@type` | Required — must be `FAQPage` | Yes |
| `mainEntity` | Required — array of `Question` objects, one per visible Q&A pair | Yes, all four |
| `Question.name` | Required — the question text | Yes ×4 |
| `Answer.text` | Required — the answer text | Yes ×4 |

`FAQPage` has no other required or recommended properties, so there is nothing missing from this block and no gap to name. That is unusual — most types come with a shopping list attached — and it is one of the few advantages of a type with no rich result behind it.

Two quality conditions the block already meets, worth stating because they are the ones that get pages into trouble:

- **Questions are real questions and answers are complete.** No teaser answers that make the reader click to find out.
- **The wording is informational, not promotional.** "How much does TidyBooks cost?" is a question. "Why is TidyBooks the best value?" would be an ad in a question's clothing, and that is a documented policy violation for FAQ markup. Keep new questions on the first side of that line.

One standing maintenance job: **three of these four answers contain prices.** When the Solo, Team or Firm price changes, the answer text changes in two places — the visible page and this block — and they must change together. A stale $12 in the markup after the page says $14 is exactly the content mismatch this type is otherwise free of.

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

Either is fine. What matters is that it is in the server-rendered source, not injected by JavaScript after load, and that all four Q&A pairs remain visible to users on the page — answers that exist only in the markup are a hidden-content violation.

If the page's FAQ is built as a collapsed accordion, that is still visible content for this purpose: the text is in the HTML and a user can open it. A tab or accordion is fine; `display:none` with no way to reveal it is not.

### Validation Steps

1. **Schema.org Validator** — https://validator.schema.org/
   Paste the block or test the live URL. For `FAQPage` this is the whole check: syntax plus Schema.org semantics. If it comes back clean, the markup is correct.

2. **Google Rich Results Test** — **skip it for this page.** FAQ support was removed from that tool in 2026. It will not report your FAQ markup, and a blank result there means the tool no longer looks, not that your markup is broken. Running it and panicking at the empty result is the predictable failure mode here.

3. **Google Search Console** — nothing to monitor for this type. FAQ reporting and the Enhancements appearance filter were dropped in 2026 and API support is scheduled to end in August 2026. Do not go looking for an FAQ row; its absence is expected, not a bug. Search Console remains useful for this page's ordinary indexing and performance data — just not for FAQ enhancement reporting.

### Validation Checklist

- [ ] JSON syntax is valid (no trailing commas)
- [ ] All required properties present
- [ ] URLs are absolute, not relative *(not applicable — this block contains no URLs)*
- [ ] Dates are ISO 8601 at the precision the page states *(not applicable — this block contains no dates)*
- [ ] Content matches visible page content
- [ ] No policy violations

The applicable items hold in the block as written; I checked each of the four answers character by character against the copy you sent. Re-run the list after pasting — that is where a curly quote or a lost brace gets in.
