---
name: optimize-meta
description: Optimize title tags, meta descriptions, and Open Graph tags for a page
argument-hint: "<URL or page details>"
parameters:
  - name: source
    type: string
    required: true
    description: URL or page details to optimize
  - name: keyword
    type: string
    required: false
    description: Target keyword
  - name: mode
    type: string
    required: false
    description: "Set to 'a/b-test' to generate multiple variants for testing"
---

# Optimize Meta Command

Analyzes and enhances **title tags, meta descriptions, and social media tags** to maximize click-through rates and search visibility.

## Usage

```
/seo:optimize-meta https://example.com/landing-page
/seo:optimize-meta title="Current Title" keyword="target keyword"
/seo:optimize-meta https://example.com/blog-post target="best practices"
/seo:optimize-meta url="..." mode="a/b-test"
```

**Arguments:**
- URL or page details (required)
- `keyword="target keyword"` (optional but recommended)
- `target="focus topic"` (alternative to keyword)
- `mode="a/b-test"` (generates multiple variants for testing)

## Workflow

1. **Analyze Current Meta Tags** -- Invoke `meta-tags-optimizer` with URL/details and target keyword. Evaluates title tag, meta description, and Open Graph/Twitter Card tags for length, keyword placement, CTR appeal, and completeness.
2. **Generate Optimized Variants** -- Produce 3-5 title tag variants and 3-5 meta description variants, each carrying its character count and the length band that count falls in. Optionally invoke `seo-content-writer` title formula methodology for additional CTR-optimized variants.
3. **Compile Output** -- Format results with before/after comparison, implementation code, and A/B test recommendations (if mode="a/b-test").

## Output Format

```
# SKELETON -- scaffold, not output. Every [bracket] and <N> is a slot; the implementation
# code ships as finished HTML with real values, and a tag that cannot be filled is dropped
# and named in prose.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
META TAG OPTIMIZATION REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PAGE: [URL or Title]
TARGET KEYWORD: [keyword]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CURRENT META TAGS ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

TITLE TAG: <N> chars -- band per the skill's length table (<30 thin / 30-50 all
  devices / 50-60 desktop / 60-65 truncates on some / >65 truncates everywhere);
  keyword in the first half? yes/no; issues named from Common Title Tag Mistakes
META DESCRIPTION: <N> chars (or MISSING) -- inside/outside the 150-160 display
  band; keyword present yes/no; CTA present yes/no
SOCIAL TAGS: <n> of 5 required OG tags present (og:title, og:description,
  og:image, og:url, og:type); Twitter card present yes/no -- each absent tag named

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OPTIMIZED TITLE TAG VARIANTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RECOMMENDED + 2-3 variants, each with its character count, its length band, and
the rationale for the change

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OPTIMIZED META DESCRIPTION VARIANTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

RECOMMENDED + 1-2 variants, each with its character count and whether it lands
inside the 150-160 display band

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
IMPLEMENTATION CODE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Copy-paste HTML: title, meta description, OG tags, Twitter Card tags]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
A/B TEST RECOMMENDATIONS (when mode="a/b-test")
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Test setup, control vs variant, hypothesis]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**No 0-10 score is emitted, and none should be added back.** `meta-tags-optimizer` defines no
10-point rubric anywhere, so an `X/10` printed here would be a number with no scale behind it and
no way for the reader — or the next run — to reproduce it. Every line of the analysis block above
is derivable from what the skill does define: character counts, the length bands in its Title Tag
Length Optimization table, the 150-160 description display rule, the required-OG-tag list, and the
named rows of its Common Title Tag Mistakes table. If a rubric is ever wanted, it lands in the
skill first and this scaffold cites it.

## Tips

- Front-load primary keyword in the first half of the title tag
- Include one clear call-to-action in every meta description
- Add the current year to title tags for recurring topics — it signals recency where staleness is the reader's main risk. No CTR percentage is quoted for this or any other technique: `meta-tags-optimizer` has no sourced effect size on file, and the single carrier for what each technique does is `build/meta-tags-optimizer/references/ctr-and-social-reference.md`
- Test title variants for at least 4 weeks before declaring a winner

## Related Skills

- [meta-tags-optimizer](../build/meta-tags-optimizer/) -- Full meta tag optimization workflow
- [seo-content-writer](../build/seo-content-writer/) -- SEO-optimized content creation
