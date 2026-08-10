---
name: write-content
description: Write SEO and GEO optimized content from a topic and target keyword
argument-hint: "<topic> keyword=\"<target keyword>\" type=\"<content type>\""
parameters:
  - name: topic
    type: string
    required: true
    description: Content topic
  - name: keyword
    type: string
    required: true
    description: Primary SEO target keyword
  - name: type
    type: string
    required: false
    description: "Content type (default: blog post). Options: blog post, how-to guide, comparison, listicle, landing page, ultimate guide"
---

# Write Content Command

Writes search-engine-optimized content, then applies a GEO optimization pass for AI citability. Delivers final content with SEO metadata and quality scores.

## Usage

```
/seo:write-content "email marketing for SaaS" keyword="saas email marketing" type="how-to guide"
/seo:write-content "cloud hosting comparison" keyword="best cloud hosting"
/seo:write-content "React performance tips" keyword="react performance optimization" type="blog post"
```

**Arguments:**
- Topic (required)
- `keyword="target keyword"` (required) -- primary SEO keyword
- `type="content type"` (optional, default: blog post) -- blog post, how-to guide, comparison, listicle, landing page, ultimate guide

## Workflow

1. **Run SEO Content Writer** -- Invoke `seo-content-writer` with topic, keyword, and type. Executes full workflow: SERP analysis, keyword map, title options, meta description, SEO headers, full content draft, featured snippet optimization, link recommendations, SEO review, and CORE-EEAT self-check.
2. **Run GEO Content Optimizer** -- Pass draft to `geo-content-optimizer` for a GEO enhancement pass: optimize for clear definitions, quotable statements with data, authority signals, AI-friendly structure (Q&A, tables, lists), factual density, and a structured FAQ -- the visible Q&A block always, FAQPage markup only where FAQPage is the page's one primary type (settled ruling R2).
3. **Compile Final Output** -- Assemble deliverables into the format below.

## Output Format

```markdown
<!-- SKELETON -- scaffold, not the deliverable. Every [bracket] and X is a slot filled from
     the draft and its own arithmetic; the content that ships carries no bracket token. -->
# [Final Optimized Title]

**Meta Description**: "[description]" ([X] chars)
**Primary Keyword**: [keyword] | **Content Type**: [type]

---

[Full written content with GEO enhancements applied]

---

## SEO Metadata
| Element | Value |
| Title Tag, Meta Description, URL Slug, Keywords, Word Count |

## CORE Self-Check Scores (Content Body)
| Dimension | Score | Points over scored items | Key Notes |
| C / O / R / E dimensions, each score carrying the points and the scored-item count it came from; GEO Score = (C + O + R + E) / 4, printed with its four operands |

## GEO Optimization Notes
| GEO Factor | Score (1-10) | What was counted |
| The eight factors from the GEO optimizer's assessment -- Clear definitions, Quotable statements, Factual density, Source citations, Q&A format, Authority signals, Content freshness, Structure clarity -- each row carrying its own met-of-asked count |
**GEO Readiness**: X/10 -- [sum] points / [n] factors scored
```

**Every score is printed with its arithmetic beside it.** A GEO factor score is `1 + 9 x (met / asked)`, rounded half up, floor 1, and the row prints the met-of-asked count that produced it; GEO Readiness is the sum over the number of factors scored, printed with both operands. A factor with nothing to count is N/A -- excluded from the sum and the divisor, never scored 1. Full rules: [geo-score-arithmetic.md](../build/geo-content-optimizer/references/geo-score-arithmetic.md) for the GEO factors, [score-arithmetic.md](../cross-cutting/content-quality-auditor/references/score-arithmetic.md) for the CORE dimension scores.

## Tips

- Specify content type explicitly -- it affects CORE-EEAT weight profiles and content structure
- For competitive keywords, run `/seo:keyword-research` first to inform the content angle
- After publishing, run `/seo:audit-page` to verify on-page optimization
- Provide secondary keywords and target audience in your prompt for better results

## Related Skills

- [seo-content-writer](../build/seo-content-writer/) -- SEO content creation
- [geo-content-optimizer](../build/geo-content-optimizer/) -- GEO optimization
- [keyword-research](../research/keyword-research/) -- Research keywords before writing
- [content-quality-auditor](../cross-cutting/content-quality-auditor/) -- Full 80-item CORE-EEAT audit
