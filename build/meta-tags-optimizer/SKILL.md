---
name: meta-tags-optimizer
version: "4.3.1"
description: 'Create and optimize title tags, meta descriptions, Open Graph tags, and Twitter cards for maximum click-through rates. Use when the user asks to "optimize title tag", "write meta description", "improve CTR", "Open Graph tags", "social media preview", "fix my meta tags", or "OG tags not showing". Produces optimized meta tags with character counting, A/B test variations, and CTR analysis. For a broader on-page audit, see on-page-seo-auditor. For structured data markup, see schema-markup-generator.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.1"
  geo-relevance: "low"
  tags:
    - seo
    - meta-tags
    - title-tag
    - meta-description
    - open-graph
    - twitter-card
    - ctr
    - social-sharing
  triggers:
    - "optimize title tag"
    - "write meta description"
    - "improve CTR"
    - "Open Graph tags"
    - "social media preview"
    - "title optimization"
    - "meta tags"
    - "my title tag needs work"
    - "low click-through rate"
    - "fix my meta tags"
    - "OG tags not showing"
---

# Meta Tags Optimizer

This skill creates compelling, optimized meta tags that improve click-through rates from search results and enhance social media sharing. It covers title tags, meta descriptions, and social meta tags.

## When to Use This Skill

- Creating meta tags for new pages
- Optimizing existing meta tags for better CTR
- Preparing pages for social media sharing
- Fixing duplicate or missing meta tags
- A/B testing title and description variations
- Optimizing for specific SERP features
- Creating meta tags for different page types

## What This Skill Does

1. **Title Tag Creation**: Writes compelling, keyword-optimized titles
2. **Meta Description Writing**: Creates click-worthy descriptions
3. **Open Graph Optimization**: Prepares pages for social sharing
4. **Twitter Card Setup**: Optimizes Twitter-specific meta tags
5. **CTR Analysis**: Suggests improvements for better click rates
6. **Character Counting**: Ensures proper length for SERP display
7. **A/B Test Suggestions**: Provides variations for testing

## How to Use

### Create Meta Tags

```
Create meta tags for a page about [topic] targeting [keyword]
```

```
Write title and meta description for this content: [content/URL]
```

### Optimize Existing Tags

```
Improve these meta tags for better CTR: [current tags]
```

### Social Media Tags

```
Create Open Graph and Twitter card tags for [page/URL]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~search console + ~~SEO tool connected:**
Automatically pull current meta tags, CTR data by query, competitor title/description patterns, SERP preview data, and impression/click metrics to identify optimization opportunities.

**With manual data only:**
Ask the user to provide:
1. Current title and meta description (if optimizing existing)
2. Target primary keyword and 2-3 secondary keywords
3. Page URL and main content/value proposition
4. Competitor URLs or examples of well-performing titles in the SERP

Proceed with the full workflow using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests meta tag optimization:

1. **Gather Page Information**

   ```markdown
   ### Page Analysis
   
   **Page URL**: [URL]
   **Page Type**: [blog/product/landing/service/homepage]
   **Primary Keyword**: [keyword]
   **Secondary Keywords**: [keywords]
   **Target Audience**: [audience]
   **Primary CTA**: [action you want users to take]
   **Unique Value Prop**: [what makes this page special]
   ```

2. **Create Optimized Title Tag**

   **Pick the formula from the page's content type before drafting** — 32 formulas across informational, listicle, comparison, commercial, local and problem-awareness pages, each with a worked example: [references/meta-tag-formulas.md](./references/meta-tag-formulas.md) → Title Tag Formulas by Content Type. The formula is how you draft; it is not deliverable content. What ships is the options table below and the reasoning for the pick.

   ````markdown
   ### Title Tag Optimization
   
   **Requirements**:
   - Length: 50-60 characters — a house working range, not an engine limit. Google states "there's no limit on how long a `<title>` element can be" and truncates the title link "typically to fit the device width", so the target is a title that survives a narrow viewport, never a character count that guarantees display
   - Include primary keyword (preferably near front)
   - Make it compelling and click-worthy
   - Match search intent
   - Include brand name if appropriate
   
   **Generated Title Options**:
   
   | Option | Title | Length | Power Words | Keyword Position |
   |--------|-------|--------|-------------|------------------|
   | 1 | [Title] | [X] chars | [words] | [Front/Middle] |
   | 2 | [Title] | [X] chars | [words] | [Front/Middle] |
   | 3 | [Title] | [X] chars | [words] | [Front/Middle] |
   
   **Recommended**: Option [X]
   **Reasoning**: [Why this option is best]
   
   **Title Tag Code**:
   ```html
   <title>[Selected Title]</title>
   ```
   ````

3. **Write Meta Description**

   **Draft to the shape `[what the page offers] + [benefit to user] + [call-to-action]`**, using the power elements that fit the page — numbers and statistics, the current year, emotional triggers, action verbs, the unique value proposition. Per-content-type description templates, and the rule that every slot resolves before shipping: [references/meta-tag-formulas.md](./references/meta-tag-formulas.md) → Meta Description Templates. As with titles, the shape is drafting guidance and does not appear in the deliverable.

   ````markdown
   ### Meta Description Optimization
   
   **Requirements**:
   - Length: 150-160 characters — a house working range, not an engine limit. Google states "There's no limit on how long a meta description can be" and truncates "typically to fit the device width"; it also creates snippets "primarily from the page content itself" and uses the meta description only where it judges it more accurate
   - Include primary keyword naturally
   - Include clear call-to-action
   - Match page content accurately
   - Create urgency or curiosity
   - Avoid duplicate descriptions
   
   **Generated Description Options**:
   
   | Option | Description | Length | CTA | Emotional Trigger |
   |--------|-------------|--------|-----|-------------------|
   | 1 | [Description] | [X] chars | [CTA] | [Trigger] |
   | 2 | [Description] | [X] chars | [CTA] | [Trigger] |
   | 3 | [Description] | [X] chars | [CTA] | [Trigger] |
   
   **Recommended**: Option [X]
   **Reasoning**: [Why this option is best]
   
   **Meta Description Code**:
   ```html
   <meta name="description" content="[Selected Description]">
   ```
   ````

4. **Create Open Graph, Twitter Card, and Additional Meta Tags**

   Generate OG tags (og:type, og:url, og:title, og:description, og:image), Twitter Card tags, canonical URL, robots, viewport, author, and article-specific tags. Then combine into a complete meta tag block.

   **Placement rule (ledger F13)**: every tag you hand the user carries a resolved value. A value the input cannot support — an image asset that does not exist, an unknown social handle, a missing publish date — means that tag is **omitted** and the gap named in the report prose. Never put a bracket token, `TBD`, `XX`, or a note like "to supply" inside a `content=`/`href=` attribute or between `<title>` tags. In the reference file, the bracketed blocks are labelled skeletons (scaffolding); only the filled example is paste-ready.

   > **Reference**: See [references/meta-tag-code-templates.md](./references/meta-tag-code-templates.md) for OG type selection guide, Twitter card type selection, all HTML code templates, and the complete meta tag block template.

5. **CORE-EEAT Alignment Check**

   Verify meta tags align with content quality standards. Reference: [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md)

   ```markdown
   ### CORE-EEAT Meta Tag Alignment

   | Check | Status | Notes |
   |-------|--------|-------|
   | **C01 Intent Alignment**: Title promise matches actual content delivery | ✅/⚠️/❌ | [Does the title accurately represent what the page delivers?] |
   | **C02 Direct Answer**: Meta description reflects the core answer available in first 150 words | ✅/⚠️/❌ | [Does the description preview the direct answer?] |

   **If C01 fails**: Title is misleading — rewrite to match actual content.
   **If C02 fails**: Content may need restructuring to front-load the answer, or description should better reflect available content.
   ```

9. **Provide CTR Optimization Tips**

   The third column carries no percentage, and must not be given one back: this skill has no sourced effect size for any of these elements, and an unsourced uplift number in a client's report reads as a forecast. Single carrier for what each element does and for the order below: [references/ctr-and-social-reference.md](./references/ctr-and-social-reference.md). The measurement protocol the block sends the client to is in [references/meta-tag-formulas.md](./references/meta-tag-formulas.md).

   ```markdown
   ## CTR Optimization Analysis

   ### Power Words Used
   - [Word 1] - Creates [emotion/action]
   - [Word 2] - Creates [emotion/action]

   ### CTR Boosting Elements

   | Element | Present | What it does to the SERP entry |
   |---------|---------|--------------------------------|
   | Match search intent | Yes/No | Structural — decides whether the result answers the query at all |
   | Numbers | Yes/No | Commits to a concrete scope before the click |
   | Current Year | Yes/No | Signals recency where staleness is the reader's risk |
   | Brackets | Yes/No | Adds a separate information unit without lengthening the main clause |
   | Question | Yes/No | Mirrors the query's own wording when the query is itself a question |
   | Power Words | Yes/No | Tone only — differentiates an otherwise interchangeable title |

   **Expected uplift: not quoted.** No effect size for these elements comes from a named source, so this report puts no percentage on any of them. The number that matters is this page's own: change one element, wait for the re-crawl, then compare 30 days of click-through rate against the 30 days before it at a comparable average position.

   ### A/B Test Suggestions

   Test these variations:

   **Version A** (Current):
   - Title: [Title]
   - Description: [Description]

   **Version B** (Test):
   - Title: [Alternative title]
   - Description: [Alternative description]
   - Hypothesis: [Why this might perform better]
   ```

## Recommended Actions — the Seven Fields

The tags are the artefact; the report around them is where somebody is told to install them. **Every recommendation in that report carries seven fields**: **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**. That covers the recommended title and description, each tag omitted for want of a value (an OG image that does not exist, an unknown social handle), each hreflang repair from the checklist below, and each A/B variation proposed.

**The fields live in the report, never inside a tag.** A `content=` attribute carries a resolved value and nothing else — an owner or a due date inside one is the same ledger F13 failure as a bracket token there. The block is what gets pasted; the table is what gets assigned.

Fields 1-3 are **required**: no action ships without an owner-role and an acceptance criterion. Fields 4-7 take a stated-absence value where no answer exists (`not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect`), never a blank and never an invention. **Owner is a role**, not a person unless the client supplied the name: `Content` · `SEO/technical` · `Developer` · `Designer` · `Product/merchandising` · `Customer service` · `Legal/compliance` · `Agency` · `Client decision`. Commissioning a missing OG image is often a `Client decision` or a `Designer` job, and naming it is what stops the gap sitting in the report for a quarter; `unassigned — needs an owner` is legitimate and is itself a finding.

**The acceptance criterion is unusually easy to make checkable here, and that is the standard**: the exact string is in the page source at the named URL, its character count is inside the stated range, and it was verified by view-source or a re-crawl on a stated date. The test is whether someone who was not part of this engagement could check it six weeks from now without asking what was meant — so "meta description on `/pricing/` is 140-158 characters and live in the production source, checked 24 Sep", not "improve the description".

**A criterion never requires an engine to do something.** A CTR figure, a position, or the tag appearing verbatim in the SERP is nobody's to deliver — Google rewrites titles and descriptions at its own discretion, which is exactly why this skill quotes no uplift percentage. The A/B test's criterion is the variant live from a dated deploy plus the 30-day click-through comparison run at a comparable average position and recorded beside the 30 days before it, never a number it must reach.

**Ordering, stated once**: expected impact ÷ effort with dependencies respected — a description rewrite that waits on an asset the client has not sent sorts below the request for that asset.

```markdown
<!-- SKELETON — the recommendation table, which sits in the report beside the tag blocks and
     never inside one. Every [slot] is filled from this run; fields 4-7 take their stated-absence
     value where no answer exists. Delete this comment when the table is filled. -->
| # | Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
|---|--------|-------|----------------------|-----------------|--------|--------------|--------------------|
| 1 | [one imperative sentence naming the page and the tag] | [role] | [exact string live in source at the named URL · character count in range · verified how, by when] | [derived from a figure printed in this report, or `not estimated — no baseline data`] | [S/M/L, or `not estimated`] | [named, or `none`] | [failure mode and cost, or `low — reversible, no downstream effect`] |
```

Field definitions, stated-absence values, the closed role list, worked criteria and the three permitted shapes of expected impact: [Action Output Contract](../../references/action-output-contract.md).

## Hreflang Checklist (Multi-Language Pages)

For EL/EN/DE (or any multi-language) page sets. Hreflang implementations commonly fail on a handful of classic errors — verify all six before shipping.

| # | Check | Rule | Fails When |
|---|-------|------|------------|
| a | **Return links** | Every variant's tag block lists ALL variants, including itself (bidirectional) | Page A → B exists but B → A is missing |
| b | **x-default** | Exactly one `hreflang="x-default"` per cluster | Zero, or more than one, x-default declared |
| c | **Self-referential canonical** | Each variant's `<link rel="canonical">` points to itself — never to another language version | EL/DE canonical points to the EN "master" page |
| d | **ISO codes** | Language only: `el`, `en`, `de`. Language-region: `el-GR`, `en-US`, `de-DE`. Never a bare region/country code as the language | `hreflang="gr"` used instead of `el` |
| e | **Sitemap match** | hreflang set matches sitemap `<xhtml:link>` entries 1:1 | Page declares 3 variants; sitemap lists 2 |
| f | **3-language example** | See block below | — |

**EL/EN/DE example** — identical block on all three pages (canonical self-referential, href swapped per page):
```html
<link rel="canonical" href="https://example.com/el/page/" />
<link rel="alternate" hreflang="el" href="https://example.com/el/page/" />
<link rel="alternate" hreflang="en" href="https://example.com/en/page/" />
<link rel="alternate" hreflang="de" href="https://example.com/de/page/" />
<link rel="alternate" hreflang="x-default" href="https://example.com/en/page/" />
```

## Validation Checkpoints

### Input Validation
- [ ] Primary keyword confirmed and matches page content
- [ ] Page type identified (blog/product/landing/service/homepage)
- [ ] Target audience and search intent clearly defined
- [ ] Unique value proposition articulated

### Output Validation
- [ ] Title length inside the 50-60 character house range, stated as a house range and never as "displays fully in SERP" (Google publishes no length limit; truncation is by device width)
- [ ] Meta description length 150-160 characters
- [ ] Primary keyword appears in both title and description
- [ ] Open Graph image specified as a real absolute URL (1200x630px recommended) — if no asset exists, the tag is omitted and the gap noted in the report, never filled with a placeholder
- [ ] No bracket token, `TBD`/`XX`, or data-needed note inside any delivered tag value (ledger F13 placement rule)
- [ ] All HTML syntax valid (no unclosed quotes or tags)
- [ ] Source of each data point stated in the deliverable's own words — the resolved tool name (Google Search Console CTR data, Ahrefs competitor data), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every recommendation carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist; none ships without an owner-role and an acceptance criterion, the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding), and every field sits in the report rather than inside a tag value
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — the exact string live in the page source at the named URL, its character count in range, and how and when that was verified. **None requires an engine to do something**: a CTR figure, a position, or the tag appearing verbatim in the SERP is never the criterion. The ordering rule (expected impact ÷ effort, dependencies respected) is stated once

## Example

**User**: "Create meta tags for a blog post about 'how to start a podcast in 2026'"

*(The year is resolved to the run's actual year — 2026 in this example. A year token never stays inside a tag value.)*

**Output**:

````markdown
## Meta Tags: How to Start a Podcast (2026)

### Title Tag
```html
<title>How to Start a Podcast in 2026: Complete Beginner's Guide</title>
```
**Length**: 57 characters ✅
**Keyword**: "how to start a podcast" at front ✅
**Power Words**: "Complete", "Beginner's" ✅

### Meta Description
```html
<meta name="description" content="Learn how to start a podcast in 2026 with our step-by-step guide: equipment, hosting, recording, and launching your first episode. Start podcasting today!">
```
**Length**: 154 characters ✅
**Keyword**: Included naturally ✅
**CTA**: "Start podcasting today!" ✅

_Complete meta tag block (with OG, Twitter, Article tags) generated using template from [references/meta-tag-code-templates.md](./references/meta-tag-code-templates.md)._

### A/B Test Variations

**Title Variation B**:
"Start a Podcast in 2026: Step-by-Step Guide (+ Free Checklist)"

**Title Variation C** (the square brackets here are the literal CTR device from the power-words table — a shipped character, not a slot to fill):
"How to Start a Podcast: 2026 Guide [Equipment + Software + Tips]"

**Description Variation B**:
"Want to start a podcast in 2026? This guide covers everything: equipment ($100 budget option), best hosting platforms, recording tips, and how to get your first 1,000 listeners."
````

## Tips for Success

1. **Front-load keywords** - Put important terms at the beginning
2. **Match intent** - Description should preview what page delivers
3. **Be specific** - Vague descriptions get ignored
4. **Test variations** - Small changes can significantly impact CTR
5. **Update regularly** - Add current year, refresh messaging
6. **Check competitors** - See what's working in your SERP

## Reference Materials

- [Meta Tag Formulas](./references/meta-tag-formulas.md) — Proven title and description formulas: five generic patterns plus 32 typed by content type, description templates, A/B methodology, multi-language guidance
- [Action Output Contract](../../references/action-output-contract.md) — Library-wide: the seven fields every recommendation carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule
- [CTR and Social Reference](./references/ctr-and-social-reference.md) — Page-type templates, the single carrier for CTR technique guidance (no unsourced percentages anywhere in this skill), OG best practices

## Related Skills

- [seo-content-writer](../seo-content-writer/) — Create content for meta tags
- [schema-markup-generator](../schema-markup-generator/) — Add structured data
- [on-page-seo-auditor](../../optimize/on-page-seo-auditor/) — Audit all meta tags
- [serp-analysis](../../research/serp-analysis/) — Analyze competitor meta tags

