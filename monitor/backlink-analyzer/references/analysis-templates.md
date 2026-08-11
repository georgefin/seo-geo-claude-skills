# Backlink Analysis Output Templates

Detailed output templates for each step of the backlink analysis workflow. Use these templates when generating analysis deliverables.

---

## 1. Profile Overview Template

````markdown
## Backlink Profile Overview

**Domain**: [domain]
**Analysis Date**: [date]

### Key Metrics

| Metric | Value | Reference band (source) | Status |
|--------|-------|------------------------|--------|
| Total Backlinks | [X] | no band in this library | Not benchmarked |
| Referring Domains | [X] | [typical range for your vertical, rubric §5] | [inside / below / above band] |
| Domain Authority | [X] | no band — §5's ranges are DR, not DA | Not benchmarked |
| Domain Rating | [X] | [typical DR range, rubric §5 — top-10 sites] | [inside / below / above band] |
| Dofollow Links | [X] ([Y]%) | 60-80% healthy, >90% warning (rubric §5) | [healthy / warning / critical] |
| Nofollow Links | [X] ([Y]%) | derived from the dofollow row, no separate band | Read with the row above |

### Link Velocity

| Period | New Links | Lost Links | Net Change |
|--------|-----------|------------|------------|
| Last 30 days | [X] | [Y] | [+/-Z] |
| Last 90 days | [X] | [Y] | [+/-Z] |
| Last year | [X] | [Y] | [+/-Z] |

### Authority Distribution

```
DA 80-100: [X]%
DA 60-79:  [X]%
DA 40-59:  [X]%
DA 20-39:  [X]%
DA 0-19:   [X]%
```

**Profile Health Score**: [X]/100 ([points] ÷ [rows scored] × 100; [N] rows not scored: [which and why])
````

**How the Profile Health Score is computed** — it is a tally of the eight benchmark rows in
[link-quality-rubric.md](./link-quality-rubric.md) §5, not a judgement about the profile. Score
each row against its own band: **Healthy = 1 · Warning = 0.5 · Critical = 0**, then
`round(100 × points ÷ rows scored)`, an exact half rounding down. A row you have no data for
(no topical-relevance sample, no growth history) is left out of both sides and named beside the
score — never scored 0, which says "measured and failing". With all eight rows scored the
attainable values are the multiples of 6.25 rounded to whole numbers — 100, 94, 87, 81, 75, 69,
62, 56, 50 and down — so a score between two of them did not come from this table. **If fewer than four rows could
be scored, print no health score** — name what is missing instead; a health figure standing on two
rows reads as a verdict on the whole profile. Worked: 5 Healthy + 2 Warning + 1 Critical =
`100 × 6 ÷ 8` = **75/100**.

**Third-column provenance**: it is a band you look up and cite, not an average you supply. Every
filled cell names its source — `references/link-quality-rubric.md` §5, this library's own general
ranges — and you carry the band's population into the reading: §5's DR and referring-domain ranges
describe the **top 10 sites** in a vertical, so a site under them is behind that vertical's leaders,
not "below average". Where §5 has no band, the cell says so and Status reads "Not benchmarked":
that is the finished answer, not a cell awaiting a number. Domain Authority is the standing example
— §5 bands DR, and borrowing a DR band for a DA figure compares two vendors' scales.

The column was headed "Industry Avg" until 2026-08-10. Nothing this skill collects, and nothing in
this library, supplies a single industry mean for backlink counts, referring domains or DA/DR — so
the only way to fill that cell was to invent the number, and a benchmark cell with nothing behind it
gets filled anyway, because the cell exists (statistics rule: sourced, cited, or placeholder, never
invented). Renaming keeps the comparison the table is for and removes the invitation: a band cannot
be filled without naming where it came from. A published third-party benchmark may replace a band
only when you have read it — name the publisher, the year and the sample, and link it. The same
discipline governs the competitive template in §4: those columns are measured per named competitor,
so their mean is a competitor mean, never an industry one.

---

## 2. Link Quality Analysis Template

```markdown
## Link Quality Analysis

### Top Quality Backlinks

| Source Domain | DA | Link Type | Anchor | Target Page |
|---------------|-----|-----------|--------|-------------|
| [domain 1] | [DA] | Editorial | [anchor] | [page] |
| [domain 2] | [DA] | Guest Post | [anchor] | [page] |
| [domain 3] | [DA] | Resource | [anchor] | [page] |

### Link Type Distribution

| Type | Count | Percentage | Assessment |
|------|-------|------------|------------|
| Editorial | [X] | [Y]% | High quality |
| Guest posts | [X] | [Y]% | Good |
| Resource pages | [X] | [Y]% | Good |
| Directory | [X] | [Y]% | Moderate |
| Forum/Comments | [X] | [Y]% | Low quality |
| Sponsored/Paid | [X] | [Y]% | Risky |

### Anchor Text Analysis

| Anchor Type | Count | Percentage | Status |
|-------------|-------|------------|--------|
| Brand name | [X] | [Y]% | Natural |
| Exact match | [X] | [Y]% | [Warning if >30%] |
| Partial match | [X] | [Y]% | Natural |
| URL/Naked | [X] | [Y]% | Natural |
| Generic | [X] | [Y]% | Natural |

**Top Anchor Texts**:
1. "[anchor 1]" - [X] links
2. "[anchor 2]" - [X] links
3. "[anchor 3]" - [X] links

### Geographic Distribution

| Country | Links | Percentage |
|---------|-------|------------|
| [Country 1] | [X] | [Y]% |
| [Country 2] | [X] | [Y]% |
| [Country 3] | [X] | [Y]% |
```

---

## 3. Toxic Link Analysis Template

````markdown
## Toxic Link Analysis

### Risk Summary

**Toxic Score**: [X]% — [toxic referring domains] of [referring domains reviewed]
**High Risk Links**: [X]
**Medium Risk Links**: [X]
**Action Required**: [Yes/No]

### Toxic Link Indicators

| Risk Type | Count | Examples |
|-----------|-------|----------|
| Spammy domains | [X] | [domains] |
| Link farms | [X] | [domains] |
| PBN suspected | [X] | [domains] |
| Irrelevant sites | [X] | [domains] |
| Foreign language spam | [X] | [domains] |
| Penalized domains | [X] | [domains] |

### High-Risk Links to Review

| Source Domain | Risk Score | Issue | Recommendation |
|---------------|------------|-------|----------------|
| [domain 1] | [score]/100 | Link farm | Disavow |
| [domain 2] | [score]/100 | Spam site | Disavow |
| [domain 3] | [score]/100 | PBN | Investigate |

### Disavow Recommendations

**Domains to disavow** ([X] total):
```
domain:[spam-site-1.com]
domain:[spam-site-2.com]
domain:[link-farm.com]
```

**Individual URLs to disavow** ([X] total):
```
[specific-url-1]
[specific-url-2]
```
````

**Risk Score provenance**: `[score]` is filled from the toxicity/spam score reported by
~~link database or the user's export, with that tool named beside it. This skill defines no
risk-score scale of its own, so a link with no tool-reported score gets "N/A — not
tool-reported" plus a written justification in the Issue column — never a number assigned
to fit the recommendation.

**Toxic Score provenance and arithmetic**: the same rule one level up. This skill defines no
profile-level toxicity scale either, so the Toxic Score line is a **share you counted**, not an
index: toxic referring domains ÷ referring domains reviewed × 100, both counts printed, one
decimal, half up. "Reviewed" is the population you actually looked at — say so when it is a sample
(`18.2% — 4 of 22 referring domains reviewed; the full profile was not exported`), because a share
of a 22-domain sample is not a share of the profile. A domain counts once however many links it
carries; if links matter more than domains for this profile, report the link share as a second
figure with its own two counts rather than blending them. Where the backlink index reports its own
profile-level toxicity number, print **that** instead, named and dated as the tool's figure
(`Ahrefs Spam Score 34/100, pulled 12 Aug`) — never averaged or reconciled with the counted share,
which is a different measurement. Both bands come from
[link-quality-rubric.md](./link-quality-rubric.md) §5: under 5% healthy, 5-10% warning, above 10%
critical.

---

## 4. Competitive Backlink Analysis Template

```markdown
## Competitive Backlink Analysis

### Profile Comparison

| Metric | You | Competitor 1 | Competitor 2 | Competitor 3 |
|--------|-----|--------------|--------------|--------------|
| Referring Domains | [X] | [X] | [X] | [X] |
| Domain Authority | [X] | [X] | [X] | [X] |
| Domain Rating | [X] | [X] | [X] | [X] |
| Link Velocity (30d) | [X] | [X] | [X] | [X] |
| Avg Link DA | [X] | [X] | [X] | [X] |

### Unique Referring Domains

**Links only you have**: [X] domains
**Links competitors share**: [X] domains
**Links competitors have, you don't**: [X] domains -- Opportunity

### Link Intersection Analysis

**Sites linking to competitors but not you**:

| Domain | DA | Links to Comp 1 | Comp 2 | Comp 3 | Opportunity |
|--------|-----|-----------------|--------|--------|-------------|
| [domain 1] | [DA] | Yes | Yes | Yes | High - All competitors |
| [domain 2] | [DA] | Yes | Yes | No | High - 2 competitors |
| [domain 3] | [DA] | Yes | No | No | Medium - 1 competitor |

### Content Getting Most Links (Competitor Analysis)

| Competitor | Content | Backlinks | Content Type |
|------------|---------|-----------|--------------|
| [Comp 1] | [Title/URL] | [X] | [Type] |
| [Comp 2] | [Title/URL] | [X] | [Type] |
| [Comp 3] | [Title/URL] | [X] | [Type] |

**Insight**: [What content types attract most links in this niche]
```

---

## 5. Link Building Opportunities Template

```markdown
## Link Building Opportunities

### High-Priority Opportunities

#### 1. Link Intersection Prospects

Sites linking to multiple competitors but not you:

| Domain | DA | Why Link | Contact Approach |
|--------|-----|----------|------------------|
| [domain 1] | [DA] | [resource page about X] | Suggest your resource |
| [domain 2] | [DA] | [links to similar tools] | Pitch your tool |
| [domain 3] | [DA] | [industry roundup] | Request inclusion |

#### 2. Broken Link Opportunities

| Source Page | Broken Link | Suggested Replacement |
|-------------|-------------|----------------------|
| [URL] | [broken URL] | [your relevant page] |

#### 3. Unlinked Mentions

| Site | Mention | Your Page to Link |
|------|---------|-------------------|
| [domain] | Mentioned your brand | [homepage] |
| [domain] | Referenced your data | [research page] |

#### 4. Resource Page Opportunities

| Resource Page | Topic | Your Relevant Content |
|---------------|-------|----------------------|
| [URL] | [topic] | [your content] |

#### 5. Guest Post Prospects

| Site | DA | Topic Fit | Contact |
|------|-----|-----------|---------|
| [domain] | [DA] | [relevance] | [contact info/page] |

### Link Building Priority Matrix

| Opportunity Type | Effort | Impact | Priority |
|------------------|--------|--------|----------|
| Link intersection | Medium | High | Highest |
| Broken links | Low | Medium | High |
| Unlinked mentions | Low | Medium | High |
| Resource pages | Medium | High | High |
| Guest posts | High | High | Medium |
```

---

## 6. Link Change Tracking Template

```markdown
## Link Change Tracking

### New Links (Last 30 Days)

| Source | DA | Type | Anchor | Date |
|--------|-----|------|--------|------|
| [domain 1] | [DA] | [type] | [anchor] | [date] |

**Total new links**: [X]
**Average DA of new links**: [X] — mean of the [N] new links that carry a DA (name the source); if some do not, say how many were left out
**Best new link**: [domain] (DA [X])

### Lost Links (Last 30 Days)

| Source | DA | Reason | Action |
|--------|-----|--------|--------|
| [domain 1] | [DA] | Page removed | Reach out |
| [domain 2] | [DA] | Link removed | Investigate |

**Total lost links**: [X]
**Net change**: [+/-X]

### Links to Recover

| Lost Link | Value | Recovery Strategy |
|-----------|-------|-------------------|
| [domain 1] | High | Contact webmaster |
| [domain 2] | High | Update content they linked to |
```

---

## 7. Backlink Report Template

```markdown
# Backlink Analysis Report

**Domain**: [domain]
**Report Date**: [date]
**Period Analyzed**: [period]

## Executive Summary

Your backlink profile is [healthy/needs attention/concerning].

**Key Stats** — each figure carries the count it was taken over:
- Referring domains: [X] ([+/-Y] vs last month)
- Average link authority: [X] DA — mean over the [N] links carrying a DA from [named source]; links with no DA are excluded and counted here
- Link velocity: [X] new links/month — [total new] ÷ [months in the window]
- Toxic link percentage: [X]% — [toxic] of [reviewed] referring domains

## Profile Strengths

1. [Strength 1]
2. [Strength 2]
3. [Strength 3]

## Areas of Concern

1. [Concern 1]
2. [Concern 2]

## Opportunities Identified

| Opportunity | Potential Links | Effort | Priority |
|-------------|-----------------|--------|----------|
| Link intersection | [X] sites | Medium | High |
| Broken links | [X] sites | Low | High |
| Resource pages | [X] sites | Medium | Medium |

## Competitive Position

Your referring domains rank #[X] among [Y] competitors.

| Rank | Domain | Referring Domains |
|------|--------|-------------------|
| 1 | [domain] | [X] |
| 2 | [domain] | [X] |
| 3 | [domain] | [X] |

## Recommended Actions

### Immediate (This Week)
- [ ] Disavow [X] toxic links identified
- [ ] Reach out to [X] unlinked mentions

### Short-term (This Month)
- [ ] Pursue [X] link intersection opportunities
- [ ] Fix [X] broken link opportunities
- [ ] Recover [X] recently lost links

### Long-term (This Quarter)
- [ ] Create linkable asset targeting [topic]
- [ ] Launch guest posting campaign
- [ ] Build [X] resource page links

## KPIs to Track

| Metric | Current | 3-Month Target |
|--------|---------|----------------|
| Referring domains | [X] | [Y] |
| Average DA of new links | [X] | [Y] |
| Link velocity | [X]/mo | [Y]/mo |
| Toxic link % | [X]% | <5% |
```
