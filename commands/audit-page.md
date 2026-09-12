---
name: audit-page
description: Run a comprehensive on-page SEO + CORE-EEAT content quality audit for a given URL or content
argument-hint: "<URL or paste content>"
allowed-tools: ["WebFetch"]
parameters:
  - name: source
    type: string
    required: true
    description: URL to audit or pasted content
  - name: keyword
    type: string
    required: false
    description: Target keyword for relevance scoring
---

# Audit Page Command

> Content quality scoring based on [CORE-EEAT Content Benchmark](https://github.com/aaron-he-zhu/core-eeat-content-benchmark). Full reference: [references/core-eeat-benchmark.md](../references/core-eeat-benchmark.md)

A combined **on-page SEO** + **CORE-EEAT content quality** audit. For full site-wide technical SEO, use `/seo:check-technical`.

## Usage

```
/seo:audit-page https://example.com/blog-post
/seo:audit-page [paste content here] targeting "keyword"
/seo:audit-page https://example.com/landing-page keyword="primary keyword"
```

**Arguments:**
- URL or pasted content (required)
- `keyword="target keyword"` (optional but recommended for relevance scoring)

## Workflow

1. **Run On-Page SEO Audit** -- Invoke `on-page-seo-auditor` with the URL/content and target keyword. Scores 8 areas (Title, Meta Description, Headers, Content, Keywords, Links, Images, Technical).
2. **Run CORE-EEAT Content Quality Audit** -- Invoke `content-quality-auditor`. Veto check first, then score all 80 items across 8 dimensions. Calculate GEO Score (CORE) and SEO Score (EEAT).
3. **Compile Output** -- Merge both results into the format below. Generate priority-ranked action list by severity (Critical / Important / Minor).

## Output Format

```
# SKELETON -- scaffold, not output. Every [bracket] and XX is a slot filled from this
# audit's own arithmetic; a criterion nobody could verify is named as excluded, never
# shipped as XX and never scored 0.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ON-PAGE SEO AUDIT: [Page Title or URL]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

OVERALL SCORE: XX/100 — XX criterion points awarded of XX scored, XX criteria unverified and excluded from both; the eight section scores below add to this figure, rescaled as round(100 x awarded / points scored) whenever criteria were excluded

[████████████████████░░░░░░░░░░░░░░░░░░░░] XX% — the same figure as the Overall Score

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECTION SCORES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[8 area scores with bar charts, each on its own maximum — Title /15, Meta /5, Headers /10, Content /25, Keywords /15, Links /10, Images /10, Technical /10 — and each printed as awarded points over points scored, with the count of criteria excluded as unverified; the eight sum to the Overall Score]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PRIORITY ACTION LIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CRITICAL / IMPORTANT / MINOR items with specific fixes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CONCRETE ACTION CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ ] [Action items]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CORE-EEAT CONTENT QUALITY
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Content Type: [type]
Veto Status: Pass / Capped — 1 veto failed [item], final score ≤59 / BLOCK — 2+ vetoes failed [items], no final score / T04 N/A (no material connection)
Weighted Score: XX/100 ([rating]) — sum of (dimension score x content-type weight) over the eight rows below, each weight printed beside its row and renormalised to 100% if a dimension is excluded as Insufficient Data; capped at 59 on one verified veto (cap flagged, any uncapped figure labelled as such); suppressed on BLOCK; "no score issued" if veto evidence unassessable

GEO Score (CORE): XX/100 — mean of the C, O, R, E rows    SEO Score (EEAT): XX/100 — mean of the Exp, Ept, A, T rows

Dimension Scores — score = points earned / (10 x scored items) x 100, on the Pass 10 / Partial 5 / Fail 0 item scale; an N/A item leaves the denominator, never scores 0:
C  -- Contextual Clarity  [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
O  -- Organization        [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
R  -- Referenceability    [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
E  -- Exclusivity         [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
Exp -- Experience         [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
Ept -- Expertise          [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
A  -- Authority           [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)
T  -- Trust               [████████░░] XX/100  (XX pts / XX scored, XX N/A, weight XX%)

Top 5 Content Quality Improvements:
1. [ID] [Item] -- [specific action]
...

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
DETAILED FINDINGS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[Section-by-section breakdown + full 80-item score table]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: For technical SEO (speed, crawl, HTTPS), run: /seo:check-technical
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**Every score is printed with its arithmetic beside it.** An on-page section score is the criterion points awarded over the points actually scored on that section's own maximum, and the Overall Score is the plain sum of the eight when every criterion could be scored, or `round(100 x awarded / points scored)` once any were excluded -- a criterion nobody could verify leaves both the numerator and the maximum, and is never scored 0. A CORE-EEAT dimension score is `points earned / (10 x scored items) x 100`; GEO is the mean of the four printed CORE dimensions and SEO the mean of the four printed EEAT dimensions; the Weighted Score reproduces from the printed dimension scores and their weights. A dimension with more than 5 N/A items is flagged Insufficient Data, excluded, and the remaining weights renormalised to 100%. Nothing measurable at all means **no score** -- name which input unlocks which section and stop. Full rules: [scoring-rubric.md](../optimize/on-page-seo-auditor/references/scoring-rubric.md) for the eight on-page sections, [score-arithmetic.md](../cross-cutting/content-quality-auditor/references/score-arithmetic.md) for the CORE-EEAT figures and the veto overrides.

## Tips

- Provide target keyword for accurate relevance scoring
- Use alongside `/seo:check-technical` for full technical + content picture
- Some EEAT items (A01, A05, A07) require site-level data; mark "N/A" if not observable
- Run audits monthly for key pages and compare scores over time

## Related Skills

- [on-page-seo-auditor](../optimize/on-page-seo-auditor/) -- Detailed on-page SEO analysis
- [content-quality-auditor](../cross-cutting/content-quality-auditor/) -- Full CORE-EEAT 80-item content quality audit
