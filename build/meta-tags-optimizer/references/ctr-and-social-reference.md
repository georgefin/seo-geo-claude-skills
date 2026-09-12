# CTR Optimization, Social Tags, and Page-Type Templates

Reference tables for click-through rate optimization, Open Graph best practices, meta description copywriting frameworks, and page-type meta tag templates.

---

## Page-Type Meta Tag Templates

Skeletons, not deliverables: `[bracket tokens]` are slots to fill from the page's own data. A delivered tag carries a resolved value or is omitted with the gap named in the report prose — never a bracket, `TBD`, or a data-needed note inside `content=` (ledger F13 placement rule; see `meta-tag-code-templates.md` for the filled example).

### Homepage

```html
<!-- SKELETON — fill every [slot] from the page's data; never deliver a bracket -->
<title>[Brand Name] - [Primary Value Proposition]</title>
<meta name="description" content="[Brand] helps [audience] [achieve goal]. [Key feature/benefit]. [CTA]">
```

### Product Page

```html
<!-- SKELETON — fill every [slot] from the page's data; never deliver a bracket -->
<title>[Product Name] - [Key Benefit] | [Brand]</title>
<meta name="description" content="[Product] [key features]. [Price/offer if applicable]. [Social proof]. [CTA]">
```

### Blog Post

```html
<!-- SKELETON — fill every [slot] from the page's data; never deliver a bracket -->
<title>[How to/What is/Number] [Keyword] [Benefit/Year]</title>
<meta name="description" content="[What they'll learn]. [Key points covered]. [CTA]">
```

### Service Page

```html
<!-- SKELETON — fill every [slot] from the page's data; never deliver a bracket -->
<title>[Service] in [Location] - [Brand] | [Differentiator]</title>
<meta name="description" content="[Service description]. [Experience/credentials]. [Key benefit]. [CTA]">
```

---

## Title Tag Formula Patterns

### Proven Title Formulas

| Formula | Template | Example | Best For |
|---------|----------|---------|---------|
| How-To | How to [Achieve Result] ([Year]) | How to Improve SEO Rankings (2026) | Informational guides |
| Number List | [Number] [Adjective] [Topic] for [Audience] | 15 Proven SEO Strategies for E-commerce | Listicles |
| Question | [Question]? Here's [Answer Preview] | What Is Technical SEO? Complete Guide | Definition content |
| Comparison | [Option A] vs [Option B]: [Differentiator] | Ahrefs vs SEMrush: Which SEO Tool Wins? | Comparison pages |
| Year-Based | Best [Topic] in [Year] ([Tested/Ranked]) | Best SEO Tools in 2026 (Expert Tested) | Evergreen + fresh |
| Benefit-Driven | [Benefit]: [How to Achieve It] | Rank #1 on Google: 10-Step SEO Checklist | High-CTR pages |
| Parenthetical | [Topic] ([Modifier]) | Link Building Guide (With Templates) | Adding value signal |
| Negative | [Number] [Topic] Mistakes [Consequence] | 7 SEO Mistakes That Kill Your Rankings | Problem-awareness content |

### Title Tag Power Words

| Category | Power Words | Use Sparingly |
|----------|-----------|---------------|
| Urgency | Now, Today, Quick, Fast, Instant, 2026 | Don't overuse; pair with substance |
| Value | Free, Proven, Complete, Essential, Ultimate | Avoid hyperbole without backing |
| Specificity | [Exact number], Step-by-Step, Checklist, Template | More specific = more clicks |
| Curiosity | Secret, Little-Known, Surprising, Actually | Must deliver on the promise |
| Authority | Expert, Research-Backed, Data-Driven, Tested | Only use when genuinely expert content |
| Emotional | Best, Worst, Mistakes, Warning, Powerful | Balance emotion with credibility |

### Title Tag Length Optimization

| Length Range | SERP Behavior | Recommendation |
|-------------|--------------|----------------|
| <30 characters | May appear thin | Expand with modifier or brand |
| 30-50 characters | Fully displayed on all devices | Ideal for mobile-first |
| 50-60 characters | Full display on desktop, may truncate mobile | Sweet spot for desktop |
| 60-65 characters | Truncated on some devices | Front-load keywords |
| >65 characters | Truncated everywhere | Avoid — key info gets cut |

---

## Meta Description Copywriting Frameworks

### AIDA Framework

| Element | What It Does | Example |
|---------|-------------|---------|
| **A**ttention | Hook with a bold claim or question | "Want to double your organic traffic?" |
| **I**nterest | Build relevance | "This guide covers 15 proven strategies..." |
| **D**esire | Show benefit | "...used by top-ranking sites to increase traffic by 200%." |
| **A**ction | CTA | "Read the full guide now." |

**Full Example**: "Want to double your organic traffic? This guide covers 15 proven SEO strategies used by top-ranking sites to increase traffic by 200%. Read the full guide now." (158 chars)

### PAS Framework

| Element | What It Does | Example |
|---------|-------------|---------|
| **P**roblem | Identify pain point | "Struggling to rank on Google?" |
| **A**gitate | Amplify the problem | "Most SEO guides are outdated and miss key ranking factors." |
| **S**olution | Offer the solution | "Our 2026 guide covers what actually works. Read now." |

### Benefit-Proof-CTA Framework

| Element | Example |
|---------|---------|
| Benefit | "Learn the exact SEO process that grew our traffic 5x" |
| Proof | "— with real data from 200+ audits." |
| CTA | "Get the free checklist." |

---

## CTR Techniques — the single carrier

**This section is this skill's only carrier for what raises click-through rate.** `SKILL.md` step 9,
the test-priority table in `meta-tag-formulas.md`, and the `/seo:optimize-meta` scaffold all point
here and none of them restates it. A change to the guidance is made here, once.

### Why no percentage appears below

Through 4.1.4 this skill quoted CTR uplift percentages on four surfaces — the report table in
`SKILL.md`, this file, the A/B test-priority table, and the command scaffold — and **they
contradicted each other**. Three techniques carried three different ranges apiece; on one of them
the largest figure was roughly four times the smallest, and the outlier was the one printed in the
client's report. **Not one of the four surfaces named a publisher, a year, or a sample size**, so
there was no internal way to tell which was authoritative — and no reason to believe any of them
was. They were removed rather than reconciled: choosing a survivor from four unsourced numbers
manufactures an authority instead of citing one.

The rule that replaces them binds every surface of this skill:

1. **A CTR effect size is quoted only with its source** — publisher, year, and what was measured.
   No such source is on file here for any title or description technique, so no percentage is
   quoted for any of them.
2. **A client-facing surface carries no unsourced number.** An uplift figure reads to a client as a
   forecast; inventing one is the fabrication class this library already rules on (ledger F3, and
   the statistics rule in the root `CLAUDE.md`). If the number cannot be sourced, the sentence says
   so and the figure stays out.
3. **Direction is a weaker claim than size, and this skill can stand behind it.** The table states
   what a technique does to a SERP entry. It states no magnitude, because magnitude depends on the
   query, the position, and what the other nine results look like — which is what the A/B protocol
   in `meta-tag-formulas.md` measures on the page in front of you.

### Factors associated with higher organic CTR

| Factor | What it does to the SERP entry | Implementation |
|--------|--------------------------------|----------------|
| Match search intent | Structural, not cosmetic — decides whether the result answers the query at all | Align the title with the intent the live SERP's existing results serve |
| Number in title | Commits to a concrete scope before the click; the reader knows the size of the read | "7 Ways", "15 Tips" |
| Current year | Signals recency where staleness is the reader's main risk | "Best SEO Tools 2026" |
| Brackets/parentheses | Adds a second, visually separated information unit without lengthening the main clause | "[Guide]", "(With Examples)" |
| Question in title | Mirrors the query's own wording when the query is itself a question | Start with How, What, Why |
| Power words / emotional words | Tone only — differentiates a title otherwise interchangeable with its neighbours | "Proven", "Essential", "Mistake"; see Power Words table above |
| Rich results (schema) | Changes the listing's size and visual weight rather than its wording | Review stars. Google restricted FAQ rich results to government and health sites in Aug 2023, and whether How-to results are still offered is `[VERIFY]`-tagged in `schema-markup-generator` — promise no How-to appearance |

**The order is this skill's judgement, not a measured ranking**: intent match first because it is the
only structural change in the list; then the elements that change what the entry promises (number,
year, brackets, question); tone last, because a title that promises the wrong thing is not rescued
by a power word. When two candidate changes compete for one test slot, test the higher one.

---

## Open Graph Best Practices by Platform

### Platform-Specific OG Optimization

| Platform | Image Size | Title Length | Description Length | Special Tags |
|----------|-----------|-------------|-------------------|-------------|
| Facebook | 1200x630px | 40-60 chars | 125-155 chars | og:type, og:locale |
| Twitter/X | 1200x600px | 70 chars max | 200 chars | twitter:card, twitter:site |
| LinkedIn | 1200x627px | 70 chars | 150 chars | Standard OG tags |
| Pinterest | 1000x1500px (2:3) | 100 chars | 500 chars | og:type=article preferred |
| Slack | 500x500px min | Full title | First ~300 chars | Standard OG tags |

### OG Tag Checklist

| Tag | Required? | Notes |
|-----|----------|-------|
| og:title | Yes | Can differ from HTML title; optimize for social sharing |
| og:description | Yes | Social-optimized; can differ from meta description |
| og:image | Yes | Must be absolute URL; minimum 200x200px, ideal 1200x630px |
| og:url | Yes | Canonical URL |
| og:type | Yes | "website" for homepage, "article" for blog posts |
| og:site_name | Recommended | Your brand name |
| og:locale | Recommended | e.g., "en_US" |
| twitter:card | Recommended | "summary_large_image" for articles |
| twitter:site | Recommended | @yourbrand |
