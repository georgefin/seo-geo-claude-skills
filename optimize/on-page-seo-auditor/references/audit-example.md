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

### Critical
1. **Internal linking severely underdeveloped** — Evidence: crawl found only 2 internal links in the body. Impact: topical authority does not flow to the review pages this post should feed. Fix: add links to /sony-wh1000xm5-review, /bose-qc-ultra-review and the headphones category page; target 5-8 contextual links. Confidence: Confirmed.
2. **3 product images missing alt text** — Evidence: Sony WH-1000XM5, Bose QC Ultra, and Apple AirPods Max images have empty alt attributes. Impact: lost Google Images ranking signals and weaker accessibility. Fix: add descriptive alt text to all three. Confidence: Confirmed.

### Important
1. **Meta description lacks call-to-action** — Evidence: current description states facts with no click prompt. Impact: depressed SERP CTR against comparison competitors. Fix: add "Compare prices and features" or "See our top picks". Confidence: Likely (CTR effect inferred, not measured on this page).

## Quick Wins

1. **Add alt text to 3 images** (5 min) — Use descriptive text like "Sony WH-1000XM5 noise cancelling headphones on desk" instead of empty attributes.
2. **Rewrite meta description with CTA** (5 min) — Change to: "Compare the 10 best noise cancelling headphones for 2025. Expert-tested picks from Sony, Bose, and Apple with pros, cons, and pricing. See our top picks."
3. **Add 4+ internal links** (10 min) — Link product names to their individual review pages and add a "See all headphones" link to the category hub.
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
- [ ] FAQ section with schema
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
