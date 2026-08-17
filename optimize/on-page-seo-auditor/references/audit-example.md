# On-Page SEO Auditor — Worked Example & Page Type Checklists

Referenced from [SKILL.md](../SKILL.md).

---

## Worked Example

**User**: "Audit the on-page SEO of https://example.com/best-noise-cancelling-headphones targeting 'best noise cancelling headphones'"

**Output**:

```markdown
# On-Page SEO Audit Report

**Page**: https://example.com/best-noise-cancelling-headphones
**Target Keyword**: best noise cancelling headphones
**Secondary Keywords**: wireless noise cancelling headphones, ANC headphones, noise cancelling headphones review
**Page Type**: commercial (reviews/roundup)
**Audit Date**: 2025-01-15

## Summary

| Audit Area | Score | Key Finding |
|------------|-------|-------------|
| Title Tag | 12/15 | Keyword present and at the front; 63 chars costs the length and truncation points |
| Meta Description | 4/5 | Keyword, length, uniqueness and accuracy all pass; no CTA costs the fifth point. The copy is generic — observed, not scored |
| Header Structure | 9/10 | Clean hierarchy; H2s cover all major products; no keyword variations in the H2s |
| Content Quality | 20/25 | 2,400 words and full subtopic coverage; no original test data, thin author credentials |
| Keyword Optimization | 12/15 | Strong placement, density 1.2%; secondary and LSI terms thin, no keyword in any alt |
| Internal/External Links | 5/10 | Only 2 internal links; no external sources cited |
| Image Optimization | 6/10 | 3/8 images missing alt text; no WebP format |
| Page-Level Technical | 7/8 | Missing Product schema; good URL, canonical and mobile. Page speed unverified — no speed tool ran, so its 2 points leave the section maximum |

## Overall Score: 77/100 (75 awarded ÷ 98 points scored; 1 criterion unverified — page speed, no speed tool ran)

Calculation: 12 + 4 + 9 + 20 + 12 + 5 + 6 + 7 = 75 awarded, over 98 points scored (100 minus the
2 points of the unverified page-speed criterion); `round(100 × 75 ÷ 98)` = 77. Each section is
scored on its own maximum, and the maxima are the section weights, so no separate weighting step
applies — see [scoring-rubric.md](./scoring-rubric.md). Page speed is left out of both sides
rather than scored 0: nothing measured it, and a 0 would have read as a measured failure.

Score Breakdown (bar = share of that section's scored maximum):
████████░░ Title Tag:        12/15  (15%)
████████░░ Meta Description:  4/5   ( 5%)
█████████░ Headers:           9/10  (10%)
████████░░ Content:          20/25  (25%)
████████░░ Keywords:         12/15  (15%)
█████░░░░░ Internal Links:    5/10  (10%)
██████░░░░ Images:            6/10  (10%)
█████████░ Technical:         7/8   (10%, LCP excluded)

## Priority Issues

Ordered inside each severity band by expected impact ÷ effort, with dependencies respected.

### Critical
1. **Internal linking severely underdeveloped** — Evidence: crawl found only 2 internal links in the body. Impact: topical authority does not flow to the review pages this post should feed. Fix: add contextual links to /sony-wh1000xm5-review, /bose-qc-ultra-review and the headphones category page, targeting 5-8 in total. Confidence: Confirmed.
   - Owner: Content · Effort: S · Depends on: none
   - Done when: at least 5 in-body links with descriptive anchor text point from this page to review or category URLs, visible in view-source on the live page
   - Risk if done wrong: low — reversible; over-linking with repeated exact-match anchors reads as manipulation, so vary the anchor text
2. **3 product images missing alt text** — Evidence: Sony WH-1000XM5, Bose QC Ultra, and Apple AirPods Max images have empty alt attributes. Impact: lost Google Images ranking signals and weaker accessibility. Fix: write descriptive alt text for all three images. Confidence: Confirmed.
   - Owner: Content · Effort: S · Depends on: none
   - Done when: all 8 `<img>` elements in the article body carry non-empty alt text describing the image, checked in view-source on the live page
   - Risk if done wrong: low — reversible, no downstream effect

### Important
1. **Meta description lacks call-to-action** — Evidence: current description states facts with no click prompt. Impact: depressed SERP CTR against comparison competitors. Fix: rewrite the meta description to close with a call to action. Confidence: Likely (CTR effect inferred, not measured on this page).
   - Owner: Content · Effort: S · Depends on: none
   - Done when: the live meta description is 150–160 characters, contains the head term, and ends on a call to action
   - Risk if done wrong: low — reversible; a description that oversells what the page delivers costs trust, so keep it accurate to the content

## Quick Wins

The S-effort rows of the Action Plan below, whose dependencies are already met. Owner, acceptance criterion and risk are stated once, in that table.

1. **Add alt text to 3 images** — the cheapest scored points on the page.
2. **Rewrite the meta description with a call to action** — one field, one edit, no release.
3. **Add 4+ internal links** — the largest single score gain available at S effort.

## Action Plan

Ordered by expected impact ÷ effort with dependencies respected. Effort: S ≤30 min, one element, no release · M ≤2 h or a content pass · L needs planning, a release, or somebody else's calendar.

| # | Action | Owner | Acceptance criterion | Expected impact | Effort | Depends on | Risk if done wrong |
|---|--------|-------|----------------------|-----------------|--------|------------|--------------------|
| 1 | Add 4 contextual internal links to the two review pages and the headphones category hub | Content | At least 5 in-body links with descriptive anchor text point from this page to review or category URLs, visible in view-source on the live page | Converts the Internal Links criteria this page fails — returns up to 4 of Internal/External Links' 10 | S | none | low — reversible; repeated exact-match anchors read as manipulation, so vary the anchor text |
| 2 | Write descriptive alt text for the Sony, Bose and Apple product images | Content | All 8 `<img>` elements in the article body carry non-empty descriptive alt text, checked in view-source | Converts the alt-text criterion — returns 2 of Image Optimization's 10 | S | none | low — reversible, no downstream effect |
| 3 | Rewrite the meta description to close with a call to action | Content | Live meta description is 150–160 characters, contains the head term, and ends on a call to action | Converts the CTA criterion — returns 1 of Meta Description's 5 | S | none | low — reversible; keep it accurate to the content |
| 4 | Add Product schema describing the products already on the page | Developer | Product markup on the live URL validates with zero errors in a structured-data test, and every property in it corresponds to content visible on the page | Converts the schema criterion — returns 2 of Page-Level Technical's 8 scored points | M | none | medium — markup describing anything not visible on the page is a misrepresentation and invalidates the block; describe only what is there |
| 5 | Commission original listening-test data for the three lead products | Client decision | A dated test note with the tester named, the method stated and the results published on the page | Converts the original-data criterion — returns 3 of Content Quality's 25 | L | budget and a tester with the hardware | medium — results published without a stated method are not evidence and invite a correction |
| 6 | Run a speed measurement so the unverified page-speed criterion can be scored | unassigned — needs an owner | A page-speed report for this URL exists, dated, and its figures are recorded against the criterion | not estimated — no baseline data; the criterion is currently excluded from both sides of the score | S | access to a speed-testing tool | low — reversible, no downstream effect |
```

---

## Audit Checklists by Page Type

### Blog Post Checklist

```markdown
- [ ] Title includes keyword and is compelling
- [ ] Meta description has keyword and CTA
- [ ] Single H1 with keyword
- [ ] H2s cover main topics
- [ ] Keyword in first 100 words
- [ ] 1,500+ words for competitive topics
- [ ] 3+ internal links with varied anchors
- [ ] Images with descriptive alt text
- [ ] Visible FAQ section covering long-tail follow-ups (markup not required)
- [ ] Author bio with credentials
```

### Product Page Checklist

```markdown
- [ ] Product name in title
- [ ] Price and availability in description
- [ ] H1 is product name
- [ ] Product features in H2s
- [ ] Multiple product images with alt text
- [ ] Customer reviews visible
- [ ] Product schema implemented
- [ ] Related products linked
- [ ] Clear CTA button
```

### Landing Page Checklist

```markdown
- [ ] Keyword-optimized title
- [ ] Benefit-focused meta description
- [ ] Clear H1 value proposition
- [ ] Supporting H2 sections
- [ ] Trust signals (testimonials, logos)
- [ ] Single clear CTA
- [ ] Fast page load speed
- [ ] Mobile-optimized layout
```
