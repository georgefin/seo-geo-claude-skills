# On-Page SEO Auditor — Output Templates

Detailed output templates for on-page-seo-auditor steps 5-11. Referenced from [SKILL.md](../SKILL.md).

**Every score below is scored on its own maximum** — Content Quality /25, Keyword Optimization
/15, Internal/External Links /10, Image Optimization /10, Page-Level Technical /10 — from the
per-criterion point tables in [scoring-rubric.md](./scoring-rubric.md): ✅ full points · ⚠️ half ·
❌ 0, with any criterion you could not verify named as unverified and excluded from both the
numerator and that section's maximum rather than scored 0. Each score prints its numerator, its
denominator and the count of excluded criteria; the Overall Score in Step 11 is the sum of the
eight section scores.

---

## Step 5: Audit Content Quality

```markdown
## Content Quality Analysis

**Word Count**: [X] words (visible body text; navigation, footer and boilerplate excluded)
**Reading Level**: [Grade level]
**Estimated Read Time**: [X] minutes ([word count] ÷ [words per minute you divided by])

| Criterion | Status | Notes |
|-----------|--------|-------|
| Sufficient length | ✅/⚠️/❌ | [comparison to ranking content] |
| Comprehensive coverage | ✅/⚠️/❌ | [notes] |
| Unique value/insights | ✅/⚠️/❌ | [notes] |
| Up-to-date information | ✅/⚠️/❌ | [notes] |
| Proper formatting | ✅/⚠️/❌ | [notes] |
| Readability | ✅/⚠️/❌ | [notes] |
| E-E-A-T signals | ✅/⚠️/❌ | [notes] |

**Content Elements Present**:
- [ ] Introduction with keyword
- [ ] Clear sections/structure
- [ ] Bullet points/lists
- [ ] Tables where appropriate
- [ ] Images/visuals
- [ ] Examples/case studies
- [ ] Statistics with sources
- [ ] Expert quotes, each with a checkable source
- [ ] FAQ section
- [ ] Conclusion with CTA

**Content Score**: [X]/25 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)

**Gaps Identified**:
- [Missing topic/section 1]
- [Missing topic/section 2]

**Recommendations**:
1. [Specific improvement]
2. [Specific improvement]
```

**Quote discipline**: the two elements above are things to *observe* on the page, not things
to write for the client. When a missing quote becomes a Recommendation, ask the writer to
source one — never draft it. A quotation attributed to a named person or organisation needs a
real, checkable source in the same breath: speaker, role, where and when they said it, and a
link that opens. Without one, do not attribute it — paraphrase it unattributed, or drop it,
and never invent a name, credential or institution to carry a line (statistics rule: sourced,
cited, or placeholder, never invented). Applies again at the Step 10 Ept01/R02 rows and the
Step 11 recommendations; same rule as SKILL.md "Finding Format & Confidence Labels".

---

## Step 6: Audit Keyword Usage

```markdown
## Keyword Optimization Analysis

**Primary Keyword**: "[keyword]"
**Keyword Density**: [X]% ([occurrences] ÷ [words in the base], counting [what counted as an occurrence] over [which words are the base])

### Keyword Placement

| Location | Present | Notes |
|----------|---------|-------|
| Title tag | ✅/❌ | Position: [X] |
| Meta description | ✅/❌ | [notes] |
| H1 | ✅/❌ | [notes] |
| First 100 words | ✅/❌ | Word position: [X] |
| H2 headings | ✅/❌ | In [X]/[Y] H2s |
| Body content | ✅/❌ | [X] occurrences |
| URL slug | ✅/❌ | [notes] |
| Image alt text | ✅/❌ | In [X]/[Y] images |
| Conclusion | ✅/❌ | [notes] |

### Secondary Keywords

| Keyword | Occurrences | Status |
|---------|-------------|--------|
| [keyword 1] | [X] | ✅/⚠️/❌ |
| [keyword 2] | [X] | ✅/⚠️/❌ |

### LSI/Related Terms

**Present**: [list of related terms found]
**Missing**: [important related terms not found]

**Keyword Score**: [X]/15 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)

**Issues**:
- [Issue 1]

**Recommendations**:
- [Suggestion 1]
```

**Density has no single convention, so the report states the one it used.** Two choices move the
number: what counts as an occurrence (the exact phrase only, or inflections and near-matches too;
headings and alt text in, or body paragraphs only) and which words form the base (visible body
text, or every word in the HTML). Print both alongside the percentage — "15 exact-phrase
occurrences including headings ÷ 229 visible words = 6.6%" — so the density bands in
[scoring-rubric.md](./scoring-rubric.md) are applied to a number the reader can reproduce. A bare
percentage is unusable: the same page yields wildly different figures under different counts.

---

## Step 7: Audit Internal Links

```markdown
## Internal Linking Analysis

**Total Internal Links**: [X]
**Unique Internal Links**: [X]

| Criterion | Status | Notes |
|-----------|--------|-------|
| Number of internal links | ✅/⚠️/❌ | [X] (recommend 3-5+) |
| Relevant anchor text | ✅/⚠️/❌ | [notes] |
| Links to related content | ✅/⚠️/❌ | [notes] |
| Links to important pages | ✅/⚠️/❌ | [notes] |
| No broken links | ✅/⚠️/❌ | [X] broken found |
| Natural placement | ✅/⚠️/❌ | [notes] |

**Current Internal Links**:
1. "[Anchor text]" → [URL]
2. "[Anchor text]" → [URL]
3. "[Anchor text]" → [URL]

**Internal Linking Score**: [X]/10 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)

**Recommended Additional Links**:
1. Add link to "[Related page]" with anchor "[suggested anchor]"
2. Add link to "[Related page]" with anchor "[suggested anchor]"

**Anchor Text Improvements**:
- Change "[current anchor]" to "[improved anchor]"
```

---

## Step 8: Audit Images

```markdown
## Image Optimization Analysis

**Total Images**: [X]

### Image Audit Table

| Image | Alt Text | File Name | Size | Status |
|-------|----------|-----------|------|--------|
| [img1] | [alt or "missing"] | [filename] | [KB] | ✅/⚠️/❌ |
| [img2] | [alt or "missing"] | [filename] | [KB] | ✅/⚠️/❌ |

| Criterion | Status | Notes |
|-----------|--------|-------|
| All images have alt text | ✅/⚠️/❌ | [X]/[Y] have alt |
| Alt text includes keywords | ✅/⚠️/❌ | [notes] |
| Descriptive file names | ✅/⚠️/❌ | [notes] |
| Appropriate file sizes | ✅/⚠️/❌ | [notes] |
| Modern formats (WebP) | ✅/⚠️/❌ | [notes] |
| Lazy loading enabled | ✅/⚠️/❌ | [notes] |

**Image Score**: [X]/10 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)

**Recommendations**:
1. Add alt text to image [X]: "[suggested alt text]"
2. Compress image [Y]: Currently [X]KB, should be under [Y]KB
3. Rename [filename] to [better-filename]
```

---

## Step 9: Audit Technical On-Page Elements

```markdown
## Technical On-Page Analysis

| Element | Current Value | Status | Recommendation |
|---------|---------------|--------|----------------|
| URL | [URL] | ✅/⚠️/❌ | [notes] |
| URL length | [X] chars | ✅/⚠️/❌ | [notes] |
| URL keywords | [present/absent] | ✅/⚠️/❌ | [notes] |
| Canonical tag | [URL or "missing"] | ✅/⚠️/❌ | [notes] |
| Mobile-friendly | [yes/no] | ✅/⚠️/❌ | [notes] |
| Page speed | [X]s | ✅/⚠️/❌ | [notes] |
| HTTPS | [yes/no] | ✅/⚠️/❌ | [notes] |
| Schema markup | [types or "none"] | ✅/⚠️/❌ | [notes] |

**Technical Score**: [X]/10 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)
```

---

## Step 10: CORE-EEAT Content Quality Quick Scan

Run a quick scan of on-page-relevant CORE-EEAT items. Reference: [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md)

**This scan is an operator surface, and its fence says so.** It is triage, not a report section:
its pass count never enters the /100 overall, the client's worked report does not print it
([audit-example.md](./audit-example.md)), and its ID column is the input the escalation payload
below is built from — a 17-item scan travels as failing item IDs and never as a dimension score
([inter-skill-handoff.md § 4.3](../../../references/inter-skill-handoff.md)). A framework item ID
is a coordinate in a document the client has never opened, so the label goes **inside** the fence,
in that fence's own syntax — a model copies the fence, not the heading above it (`CLAUDE.md`
§ The Reader Test, clause 2). What the client gets from this scan is Step 11's Priority Issues,
in plain words.

```markdown
<!-- OPERATOR BLOCK — for whoever runs this audit, not part of the client report. The ID column
     is a coordinate into the 80-item benchmark and feeds the escalation payload below. Nothing
     in this fence goes to the client as written: its findings reach them as plain-language
     Priority Issues in Step 11. -->
### CORE-EEAT quick scan — operator triage

Content-relevant items from the 80-item benchmark:

| ID | Check Item | Status | Notes |
|----|-----------|--------|-------|
| C01 | Intent Alignment | ✅/⚠️/❌ | Title promise = content delivery |
| C02 | Direct Answer | ✅/⚠️/❌ | Core answer in first 150 words |
| C09 | FAQ Coverage | ✅/⚠️/❌ | Visible Q&A block covering long-tail follow-ups; markup not required for the Pass |
| C10 | Semantic Closure | ✅/⚠️/❌ | Conclusion answers opening |
| O01 | Heading Hierarchy | ✅/⚠️/❌ | H1→H2→H3, no skipping |
| O02 | Summary Box | ✅/⚠️/❌ | TL;DR or Key Takeaways |
| O03 | Data Tables | ✅/⚠️/❌ | Comparisons in tables |
| O05 | Schema Markup | ✅/⚠️/❌ | Appropriate JSON-LD |
| O06 | Section Chunking | ✅/⚠️/❌ | Single topic per section |
| R01 | Data Precision | ✅/⚠️/❌ | ≥5 precise numbers |
| R02 | Citation Density | ✅/⚠️/❌ | ≥1 per 500 words |
| R06 | Timestamp | ✅/⚠️/❌ | Updated <1 year |
| R08 | Internal Link Graph | ✅/⚠️/❌ | Descriptive anchors |
| R10 | Content Consistency | ✅/⚠️/❌ | No contradictions |
| Exp01 | First-Person Narrative | ✅/⚠️/❌ | "I tested" or "We found" |
| Ept01 | Author Identity | ✅/⚠️/❌ | Byline + bio present |
| T04 | Disclosure Statements | ✅/⚠️/❌/N/A | Material connections disclosed (conditional veto; N/A when none exist) |

**CORE-EEAT Quick Score**: [X]/[Y] items passing ([Z] N/A or unverifiable, excluded)
```

The escalation to a full audit is a **handoff** carrying its own payload, so it stays in a fence
of its own rather than folded into the scan above — separately copyable, separately labelled,
with the label **inside** it. A model copies the fence, not the sentence beneath it (`CLAUDE.md`
§ The Value Rule, clause 2; handoff sub-rule:
[inter-skill-handoff.md § 3.1](../../../references/inter-skill-handoff.md)).

```markdown
<!-- OPERATOR BLOCK — for the client's team, not part of the report above. Nothing in this fence
     goes to the client as written. -->
### Next steps for your team

| Run | Why | Payload |
|-----|-----|---------|
| `content-quality-auditor` | Full 80-item audit with weighted scoring; this scan covers 17 on-page-visible items | [keyword] · [content type] · [URL] · quick-scan items that failed, as `CORE-EEAT-[ID]` |
```

**This quick scan is not a dimension score and never travels as one** — it is a pass count over 17
items, so it goes into the payload as the failing item IDs, never as a `CORE-EEAT C:… O:…` string.
Payload fields and the drop-and-name rule for a field you cannot source are in the same file.

**Counting the quick score.** Only ✅ counts as passing; ⚠️ and ❌ do not. The denominator starts
at 17 and shrinks: T04 is N/A when no material connection exists, and any item you could not
settle from the content in front of you is excluded rather than marked ❌. So `14/16 items
passing (1 N/A)` is a complete answer and `14/17` would be a different, wrong one. This quick
score is a separate count from the eight section scores — it never enters the /100 overall.

---

## Step 11: Generate Audit Summary

````markdown
# On-Page SEO Audit Report

**Page**: [URL]
**Target Keyword**: [keyword]
**Audit Date**: [date]

## Overall Score: [X]/100 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)

```
Score Breakdown (bar = share of that section's scored maximum):
████████░░ Title Tag:        12/15
████████░░ Meta Description:  4/5
█████████░ Headers:           9/10
████████░░ Content:          20/25
████████░░ Keywords:         12/15
█████░░░░░ Internal Links:    5/10
██████░░░░ Images:            6/10
███████░░░ Technical:         7/10
                      Total: 75/100
```

The eight section scores add up to the overall — print the addition if the summary table does
not make it obvious. If a section could not be scored at all, its row reads
`not scored — no data` and it leaves the total on both sides; if no section could be scored,
there is no Overall Score line in the report.

## Priority Issues

Each issue carries Finding / Evidence / Impact / Fix plus a Confidence label
(Confirmed = directly observed in provided data or crawl · Likely = strong indirect
evidence · Hypothesis = plausible, needs verification — name what would confirm it).

### 🔴 Critical (Fix Immediately)
1. **[Finding]** — Evidence: [observed data] · Impact: [effect] · Fix: [specific change] · Confidence: [Confirmed/Likely/Hypothesis]
2. **[Finding]** — Evidence: [observed data] · Impact: [effect] · Fix: [specific change] · Confidence: [Confirmed/Likely/Hypothesis]

### 🟡 Important (Fix Soon)
1. [Important issue 1 — same format]
2. [Important issue 2 — same format]

### 🟢 Minor (Nice to Have)
1. [Minor issue 1 — same format]
2. [Minor issue 2 — same format]

## Quick Wins

These changes will have immediate impact:

1. **[Change 1]**: [Why and how]
2. **[Change 2]**: [Why and how]
3. **[Change 3]**: [Why and how]

## Detailed Recommendations

### Title Tag
- **Current**: [current title]
- **Recommended**: [new title]
- **Impact**: [expected improvement]

### Meta Description
- **Current**: [current description]
- **Recommended**: [new description]
- **Impact**: [expected improvement]

### Content Improvements
1. [Specific content change with location]
2. [Specific content change with location]

### Internal Linking
1. Add link: "[anchor]" → [destination]
2. Add link: "[anchor]" → [destination]

### Image Optimization
1. [Image 1]: [change needed]
2. [Image 2]: [change needed]

## Competitor Comparison

| Element | Your Page | Top Competitor | Gap |
|---------|-----------|----------------|-----|
| Word count | [X] | [Y] | [+/-Z] |
| Internal links | [X] | [Y] | [+/-Z] |
| Images | [X] | [Y] | [+/-Z] |
| H2 headings | [X] | [Y] | [+/-Z] |

## Action Checklist

- [ ] Update title tag
- [ ] Rewrite meta description
- [ ] Add keyword to H1
- [ ] Add [X] more internal links
- [ ] Add alt text to [X] images
- [ ] Add [X] more content sections
- [ ] Add the page's one primary schema type, where it is missing
- [ ] [Additional action items]

## Expected Results

After implementing these changes, re-measure — this audit predicts no numbers:
- Criteria this plan converts: [N] of the [M] currently failing (name them, with the points they
  return: e.g. "alt text on 3 images returns 1.5 of Image Optimization's 10")
- Projected score after the fixes: [X]/100, computed by re-scoring only the criteria the plan
  changes and leaving every other criterion where it is
- What to re-measure, and when: impressions, average position and CTR for this page in Search
  Console, 4-8 weeks after the changes ship, against the 28 days before them
````

**No ranking, CTR or traffic forecast appears here.** A "+18% traffic" or "+4 positions" figure
for a named page needs a baseline plus a counterfactual, and an on-page audit has neither — the
number would be invented, which is precisely what the Confidence labels and the statistics rule
exist to prevent. The projected score above is the one legitimate forward-looking figure,
because it recomputes from this report's own rubric and a reader can check it. Say what the
client should watch and when, and let the re-measure produce the number.
