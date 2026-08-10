# SERP Analysis — Analysis Templates

Templates for each step of the SERP analysis workflow. Use these to structure your output.

## SERP Composition Template

```markdown
## SERP Analysis: "[keyword]"

**Search Details**
- Keyword: [keyword]
- Location: [location]
- Device: [mobile/desktop]
- Date: [date]

### SERP Layout Overview

```
┌─────────────────────────────────────────┐
│ [AI Overview / SGE] (if present)        │
├─────────────────────────────────────────┤
│ [Ads] - [X] ads above fold              │
├─────────────────────────────────────────┤
│ [Featured Snippet] (if present)         │
├─────────────────────────────────────────┤
│ [Organic Result #1]                     │
│ [Organic Result #2]                     │
│ [People Also Ask] (if present)          │
│ [Organic Result #3]                     │
│ ...                                     │
├─────────────────────────────────────────┤
│ [Related Searches]                      │
└─────────────────────────────────────────┘
```

### SERP Features Present

| Feature | Present | Position | Opportunity |
|---------|---------|----------|-------------|
| AI Overview | Yes/No | Top | [analysis] |
| Featured Snippet | Yes/No | [pos] | [analysis] |
| People Also Ask | Yes/No | [pos] | [analysis] |
| Knowledge Panel | Yes/No | Right | [analysis] |
| Image Pack | Yes/No | [pos] | [analysis] |
| Video Results | Yes/No | [pos] | [analysis] |
| Local Pack | Yes/No | [pos] | [analysis] |
| Shopping Results | Yes/No | [pos] | [analysis] |
| News Results | Yes/No | [pos] | [analysis] |
| Sitelinks | Yes/No | [pos] | [analysis] |
```

## Top Results Analysis Template

```markdown
### Top 10 Organic Results Analysis

#### Position #1: [Title]

**URL**: [url]
**Domain**: [domain]
**Domain Authority**: [DA]

**Content Analysis**:
- Type: [Blog/Product/Guide/etc.]
- Word Count: [X] words
- Publish Date: [date]
- Last Updated: [date]

**On-Page Factors**:
- Title: [exact title]
- Title contains keyword: Yes/No
- Meta description: [description]
- H1: [heading]
- URL structure: [clean/keyword-rich/etc.]

**Content Structure**:
- Headings (H2s): [list key sections]
- Media: [X] images, [X] videos
- Tables/Lists: Yes/No
- FAQ section: Yes/No

**Estimated Metrics**:
- Page backlinks: [X]
- Referring domains: [X]
- Social shares: [X]

**Why It Ranks #1**:
1. [Factor 1]
2. [Factor 2]
3. [Factor 3]

[Repeat for positions #2-10]
```

## Ranking Patterns Template

```markdown
### Ranking Patterns Analysis

**Common Characteristics of Top 5 Results**:

| Factor | Avg/Common Value | Importance |
|--------|-----------------|------------|
| Word Count | [X] words | High/Med/Low |
| Domain Authority | [X] | High/Med/Low |
| Page Backlinks | [X] | High/Med/Low |
| Content Freshness | [timeframe] | High/Med/Low |
| HTTPS | [X]% | High/Med/Low |
| Mobile Optimized | [X]% | High/Med/Low |

**Content Format Distribution** (denominator = organic results you actually classified; if you
captured 8, write /8 — every result falls in exactly one bucket and the buckets sum to the
denominator):
- How-to guides: [X]/10
- Listicles: [X]/10
- In-depth articles: [X]/10
- Product pages: [X]/10
- Other: [X]/10

**Domain Type Distribution** (same denominator, same one-bucket-each rule):
- Brand/Company sites: [X]/10
- Media/News sites: [X]/10
- Niche blogs: [X]/10
- Aggregators: [X]/10

**Key Success Factors Identified**:

1. **[Factor 1]**: [Explanation + evidence]
2. **[Factor 2]**: [Explanation + evidence]
3. **[Factor 3]**: [Explanation + evidence]
```

## SERP Features Analysis Template

```markdown
### Featured Snippet Analysis

**Current Snippet Holder**: [URL]
**Snippet Type**: [Paragraph/List/Table/Video]
**Snippet Content**:
> [Exact text/description of snippet]

**How to Win This Snippet**:
1. [Strategy based on current snippet]
2. [Content format recommendation]
3. [Structure recommendation]

---

### People Also Ask (PAA) Analysis

**Questions Appearing**:
1. [Question 1] → Currently answered by: [URL]
2. [Question 2] → Currently answered by: [URL]
3. [Question 3] → Currently answered by: [URL]
4. [Question 4] → Currently answered by: [URL]

**PAA Optimization Strategy**:
- Include these questions as H2/H3 headings
- Provide direct, concise answers (40-60 words)
- Answer them in a visible on-page Q&A block — that block is what AI engines parse, and markup is not required for it
- Add FAQPage markup only where FAQPage is the page's one primary type. On a page that already carries an accurate type (Article, Product, LocalBusiness), a second content type is schema stacking and adds no citation signal — and FAQ rich results were retired in 2026, so there is no SERP result to win either

---

### AI Overview Analysis

**AI Overview Present**: Yes/No
**AI Overview Type**: [Summary/List/Comparison/etc.]

**Sources Cited in AI Overview**:
1. [Source 1] - [Why cited]
2. [Source 2] - [Why cited]
3. [Source 3] - [Why cited]

**AI Overview Content Patterns**:
- Pulls definitions from: [source type]
- Lists information as: [format]
- Cites statistics from: [source type]

**How to Get Cited in AI Overview**:
1. [Specific recommendation]
2. [Specific recommendation]
3. [Specific recommendation]
```

## Search Intent Template

```markdown
### Search Intent Analysis

**Primary Intent**: [Informational/Commercial/Transactional/Navigational]

**Evidence**:
- SERP features suggest: [analysis]
- Top results are: [content types]
- User likely wants: [description]

**Intent Breakdown** — count the SERP elements you classified, do not estimate the split. List
every element on the page (each organic result, each feature, the ad block if present), give each
one intent, then print counts before percentages:
- Informational signals: [X] of [N] elements = [X/N]%
- Commercial signals: [X] of [N] elements = [X/N]%
- Transactional signals: [X] of [N] elements = [X/N]%

The three lines add to the element count and to 100%. An element you cannot classify is listed as
unclassified and stays in the denominator — dropping it inflates whichever intent you were already
leaning towards. 100% for one intent is a legitimate result on a uniform SERP; it just has to be
9 of 9, not a feeling.

**Content Format Implication**:
Based on intent, your content should:
- Format: [recommendation]
- Tone: [recommendation]
- CTA: [recommendation]
```

## Difficulty Assessment Template

### How the difficulty score is built

Five factors, each converted to the **same 1-100 scale** before anything is weighted — a mean DA,
a link count and a judged quality bar cannot be added together in their own units. Convert first,
then weight.

| Factor | Weight | Sub-score on 1-100 |
|--------|--------|--------------------|
| Top 10 Domain Authority | 25% | the mean DA of the results you captured (already 0-100 — name the tool it came from) |
| Top 10 Page Authority | 20% | the mean page-level authority of the same results |
| Backlinks Required | 20% | median link count of those results, banded: 0-9 → **10** · 10-49 → **30** · 50-199 → **50** · 200-999 → **70** · 1,000+ → **90**. Say which count you used (referring domains or page backlinks) — they are not interchangeable |
| Content Quality Bar | 20% | what the top 5 pages actually show, 1-5 then × 20: **1** thin or outdated · **2** ordinary blog depth · **3** thorough coverage, nothing original · **4** thorough plus original data, media or tooling · **5** category-defining, cited by others |
| SERP Stability | 15% | share of top-10 URLs unchanged since your previous pull, as a percentage. Needs two pulls; with one pull it is not scored |

**Difficulty** = Σ(sub-score × weight) ÷ Σ(weights of the factors you could score), rounded to a
whole number with a half rounding up. The division renormalises: when a factor has no data, drop
it and divide by what is left — never score it 0, which claims the SERP is easy on that axis.
State the renormalisation beside the number, with the dropped factors named.

**Bands** — the same cut `keyword-research` Step 6 uses, so one number means one thing across the
library: **70-100 High · 40-69 Medium · 1-39 Low**. Read the band off the rounded score, so the
bands stay contiguous. The scale starts at 1: a live SERP with ten results in it never scores 0.

Worked, on a single pull of five captured results with no page-authority pull and no history:

```
DA        mean 75          weight 0.25 → renormalised 0.25/0.65 = 0.385
Links     median 1,100 → 90  weight 0.20 → renormalised 0.20/0.65 = 0.308
Bar       3 → 60           weight 0.20 → renormalised 0.20/0.65 = 0.308
Page authority and SERP stability not scored (no PA pull, single snapshot) — 0.35 dropped

(75 × 5 + 90 × 4 + 60 × 4) ÷ 13 = 975 ÷ 13 = 75 → High
```

```markdown
### Difficulty Assessment

**Overall Difficulty Score**: [X]/100 ([band]) — [weights and sub-scores substituted, e.g.
"(75×5 + 90×4 + 60×4) ÷ 13"; name any factor not scored and the weight renormalised away]

**Difficulty Factors**:

| Factor | Measured value | Sub-score /100 | Weight | Weight used |
|--------|----------------|----------------|--------|-------------|
| Top 10 Domain Authority | [mean DA, source] | [X] | 25% | [renormalised or 25%] |
| Top 10 Page Authority | [mean PA, source] | [X] | 20% | [or "not scored — no PA data"] |
| Backlinks Required | [median count, which count] | [X] | 20% | [ ] |
| Content Quality Bar | [1-5 with the one-line reason] | [X] | 20% | [ ] |
| SERP Stability | [% URLs unchanged, vs which pull] | [X] | 15% | [or "not scored — single pull"] |

**Realistic Assessment**:

- **New site (DA <20)**: [Can rank?] [Timeframe]
- **Growing site (DA 20-40)**: [Can rank?] [Timeframe]
- **Established site (DA 40+)**: [Can rank?] [Timeframe]

**Easier Alternatives**:
If too difficult, consider:
- [Alternative keyword 1] - [tool-reported Keyword Difficulty, tool named — a different
  instrument from the SERP score above, so do not rank the two in one list]
- [Alternative keyword 2] - [same, or "not scored — needs its own SERP pull"]
```

## Recommendations Template

```markdown
## SERP Analysis Summary & Recommendations

### Key Findings

1. [Most important finding]
2. [Second important finding]
3. [Third important finding]

### Content Requirements to Rank

To compete for "[keyword]", you need:

**Minimum Requirements**:
- [ ] Word count: [X]+ words
- [ ] Backlinks: [X]+ referring domains
- [ ] Domain Authority: [X]+
- [ ] Content format: [type]
- [ ] Include: [specific elements]

**Differentiators to Win**:
- [ ] [Unique angle from analysis]
- [ ] [Missing element in current results]
- [ ] [SERP feature opportunity]

### SERP Feature Strategy

| Feature | Winnable? | Strategy |
|---------|-----------|----------|
| Featured Snippet | Yes/No | [strategy] |
| PAA | Yes/No | [strategy] |
| AI Overview | Yes/No | [strategy] |

### Recommended Content Outline

Based on SERP analysis:

```
Title: [Optimized title]

H1: [Main heading]

[Introduction - address intent immediately]

H2: [Section based on PAA/top results]
H2: [Section based on PAA/top results]
H2: [Section based on PAA/top results]

[FAQ section for PAA optimization]

[Conclusion with CTA]
```

### Next Steps

1. [Immediate action]
2. [Content creation action]
3. [Optimization action]
```
