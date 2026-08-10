# Performance Report Output Templates

Detailed output templates for each step of the performance reporting workflow. Use these templates when generating reports for stakeholders.

---

## 1. Report Configuration Template

```markdown
## Report Configuration

**Domain**: [domain]
**Report Period**: [start date] to [end date]
**Comparison Period**: [previous period for comparison]
**Report Type**: [Monthly/Quarterly/Annual/Custom]
**Audience**: [Executive/Technical/Client]
**Focus Areas**: [Rankings/Traffic/Content/Backlinks/GEO]
```

---

## 2. Executive Summary Template

```markdown
# SEO Performance Report

**Domain**: [domain]
**Period**: [date range]
**Prepared**: [date]

---

## Executive Summary

### Overall Performance: [Excellent/Good/Needs Attention/Critical]

**Key Highlights**:

Wins:
- [Win 1 - e.g., "Organic traffic increased 25%"]
- [Win 2 - e.g., "3 new #1 rankings achieved"]
- [Win 3 - e.g., "Conversion rate improved 15%"]

Watch Areas:
- [Area 1 - e.g., "Mobile rankings declining slightly"]
- [Area 2 - e.g., "Competitor gaining ground on key terms"]

Action Required:
- [Issue 1 - e.g., "Technical SEO audit needed"]

### Key Metrics at a Glance

| Metric | This Period | Last Period | Change | Target | Status |
|--------|-------------|-------------|--------|--------|--------|
| Organic Traffic | [X] | [Y] | [+/-Z%] | [T] | [status] |
| Keyword Rankings (Top 10) | [X] | [Y] | [+/-Z] | [T] | [status] |
| Organic Conversions | [X] | [Y] | [+/-Z%] | [T] | [status] |
| Domain Authority | [X] | [Y] | [+/-Z] | [T] | [status] |
| AI Citations | [X] | [Y] | [+/-Z%] | [T] | [status] |

### SEO ROI

**Investment**: $[X] (content, tools, effort)
**Organic Revenue**: $[Y]
**ROI**: [Z]%
```

---

## 3. Organic Traffic Analysis Template

```markdown
## Organic Traffic Analysis

### Traffic Overview

| Metric | This Period | vs Last Period | vs Last Year |
|--------|-------------|----------------|--------------|
| Sessions | [X] | [+/-Y%] | [+/-Z%] |
| Users | [X] | [+/-Y%] | [+/-Z%] |
| Pageviews | [X] | [+/-Y%] | [+/-Z%] |
| Avg. Session Duration | [X] | [+/-Y%] | [+/-Z%] |
| Bounce Rate | [X]% | [+/-Y%] | [+/-Z%] |
| Pages per Session | [X] | [+/-Y] | [+/-Z] |

### Traffic Trend

```
[Month 1]  ████████████████████ [X]
[Month 2]  █████████████████████ [Y]
[Month 3]  ███████████████████████ [Z]
[Current]  ████████████████████████ [W]
```

### Traffic by Source

| Channel | Sessions | % of Total | Change |
|---------|----------|------------|--------|
| Organic Search | [X] | [Y]% | [+/-Z%] |
| Direct | [X] | [Y]% | [+/-Z%] |
| Referral | [X] | [Y]% | [+/-Z%] |
| Social | [X] | [Y]% | [+/-Z%] |

### Top Performing Pages

| Page | Sessions | Change | Conversions |
|------|----------|--------|-------------|
| [Page 1] | [X] | [+/-Y%] | [Z] |
| [Page 2] | [X] | [+/-Y%] | [Z] |
| [Page 3] | [X] | [+/-Y%] | [Z] |

### Traffic by Device

| Device | Sessions | Change | Conv. Rate |
|--------|----------|--------|------------|
| Desktop | [X] ([Y]%) | [+/-Z%] | [%] |
| Mobile | [X] ([Y]%) | [+/-Z%] | [%] |
| Tablet | [X] ([Y]%) | [+/-Z%] | [%] |
```

---

## 4. Keyword Ranking Performance Template

Whenever the site-wide CTR or average position moved, the segment block below is filled in
**before** any explanation is written: an aggregate that moves against its own segments is a
mix effect, and the shares are the evidence for saying so (SKILL.md step 4;
`kpi-definitions.md` → "Aggregate vs. segment divergence").

```markdown
## Keyword Ranking Performance

### Search Performance by Segment

| Segment | Clicks (prev → curr) | Impressions (prev → curr) | Share of impressions (prev → curr) | CTR (prev → curr) | Avg. position |
|---------|---------------------|---------------------------|------------------------------------|-------------------|---------------|
| Brand | [X] → [Y] | [X] → [Y] | [X]% → [Y]% | [X]% → [Y]% | [X] → [Y] |
| Non-brand — established | [X] → [Y] | [X] → [Y] | [X]% → [Y]% | [X]% → [Y]% | [X] → [Y] |
| [Any newly launched cluster] | [X] → [Y] | [X] → [Y] | [X]% → [Y]% | [X]% → [Y]% | [X] → [Y] |
| **Site-wide** | **[X] → [Y]** | **[X] → [Y]** | **100%** | **[X]% → [Y]%** | **[X] → [Y]** |

**Mix reading**: [segment] moved from [X]% to [Y]% of impressions, **[+/-Z] pp** — state the
arithmetic (e.g. 40,000/50,000 = 80.0% → 61,000/70,000 = 87.1%). If every segment's CTR held
or rose while the site-wide figure fell, say so plainly: the mix changed, the snippets did
not. Shares here are shares of **impressions**; a share of clicks is a different metric and
does not answer this question.

### Rankings Overview

| Position Range | Keywords | Change | Traffic Impact |
|----------------|----------|--------|----------------|
| Position 1 | [X] | [+/-Y] | [Z] sessions |
| Position 2-3 | [X] | [+/-Y] | [Z] sessions |
| Position 4-10 | [X] | [+/-Y] | [Z] sessions |
| Position 11-20 | [X] | [+/-Y] | [Z] sessions |
| Position 21-50 | [X] | [+/-Y] | [Z] sessions |

### Top Ranking Improvements

| Keyword | Previous | Current | Change | Traffic |
|---------|----------|---------|--------|---------|
| [kw 1] | [X] | [Y] | +[Z] | [sessions] |

### Rankings That Declined

| Keyword | Previous | Current | Change | Impact | Action |
|---------|----------|---------|--------|--------|--------|
| [kw 1] | [X] | [Y] | -[Z] | -[sessions] | [action] |

### SERP Feature Performance

| Feature | Won | Lost | Opportunities |
|---------|-----|------|---------------|
| Featured Snippets | [X] | [Y] | [Z] |
| People Also Ask | [X] | [Y] | [Z] |
| Local Pack | [X] | [Y] | [Z] |
```

---

## 5. GEO/AI Visibility Template

```markdown
## GEO (AI Visibility) Performance

### AI Citation Overview

| Metric | This Period | Last Period | Change |
|--------|-------------|-------------|--------|
| Keywords with AI Overview | [X]/[Y] | [X]/[Y] | [+/-Z] |
| Your AI Citations | [X] | [Y] | [+/-Z%] |
| Citation Rate | [X]% | [Y]% | [+/-Z%] |
| Avg Citation Position | [X] | [Y] | [+/-Z] |

### AI Citation by Topic

| Topic Cluster | Opportunities | Citations | Rate |
|---------------|---------------|-----------|------|
| [Topic 1] | [X] | [Y] | [Z]% |

### GEO Wins This Period

| Query | Citation Status | Source Page | Impact |
|-------|-----------------|-------------|--------|
| [query 1] | New citation | [page] | High visibility |

### GEO Optimization Opportunities

| Query | AI Overview | You Cited? | Gap | Action |
|-------|-------------|------------|-----|--------|
| [query] | Yes | No | [gap] | [action] |
```

### 5b. AI Referral Traffic Template

Use inside the GEO/AI section when AI-referral data exists. Sources: ~~analytics (GA4), ~~search console AI-surface data, server logs — triangulated; hostname roster in [kpi-definitions.md](./kpi-definitions.md).

```markdown
## AI Referral Traffic

**Sources**: [GA4: tool-measured] · [GSC AI-surface: tool-measured or "not exposed"] · [server logs: tool-measured] · [note any user-provided rows]

### Headline: AI Share of Total Sessions

| Metric | This Period | Last Period | Change |
|--------|-------------|-------------|--------|
| AI referral sessions | [X] | [Y] | [+/-Z%] |
| AI share of total sessions | [X]% | [Y]% | [+/-Z pp] |

### Sessions by Assistant

| Assistant hostname | Sessions | Conversions | Conv. Rate |
|--------------------|----------|-------------|------------|
| [hostname 1] | [X] | [Y] | [Z]% |

### Top AI-Landing Pages

| Page | AI Sessions | AI Conv. Rate | Organic Conv. Rate (same page) |
|------|-------------|---------------|--------------------------------|
| [page 1] | [X] | [Y]% | [Z]% |

### AI vs. Organic Gap (same window)

| Metric | AI Referrals | Organic | Gap |
|--------|--------------|---------|-----|
| Engagement rate | [X]% | [Y]% | [+/-Z pp] |
| Conversion rate | [X]% | [Y]% | [+/-Z pp] |

### GSC AI-Surface Corroboration

[What Search Console AI-surface data shows for the same pages/queries, or "not exposed for this property"]

### Control Comparison (required for any attribution claim)

| Cohort | Delta this period | Notes |
|--------|-------------------|-------|
| AI-linked pages | [+/-X%] | |
| Holdout: [unchanged own page / sibling URL / competitor] | [+/-Y%] | |
| **Delta vs. control** | **[+/-Z pp]** | The only figure to attribute |

> Caveat: AI referrals prove an AI answer linked this site — not that it cited it prominently. Queue linked pages for citation checking before claiming citation wins.
```

---

## 6. Domain Authority (CITE Score) Template

**Client-read surface — gloss the framework, drop the machinery.** The block below is read
by the client, so the CITE name is introduced with what it measures before it is used as a
label (anti-slop-ruleset.md §6 family 8 gloss-on-first-use exemption), and two things never
appear in it at all: a framework **item ID** (`T03`, `C01` — a coordinate in a document the
client has never seen) and a **skill or command slug** (`/seo:audit-domain`,
`domain-authority-auditor` — a tool in a library they do not have). Name the finding and the
next step in the client's own words; the routing instruction belongs in the operator note
underneath, not inside the report.

```markdown
## Domain Authority

Domain authority here is the **CITE score**: a 40-check review of how well this domain is
cited elsewhere, how clearly its identity is established, how far it earns trust, and how it
stands against comparable sites — scored out of 100 on each of those four dimensions and
overall.

### CITE Score Summary

| Measure | This Period | Last Period | Change |
|--------|-------------|-------------|--------|
| Overall | [X]/100 | [Y]/100 | [+/-Z] |
| Citation — who cites and links this domain | [X]/100 | [Y]/100 | [+/-Z] |
| Identity — how clearly the business is identified | [X]/100 | [Y]/100 | [+/-Z] |
| Trust — trust signals on the site itself | [X]/100 | [Y]/100 | [+/-Z] |
| Eminence — standing against comparable sites | [X]/100 | [Y]/100 | [+/-Z] |

**Blocking issues**: none / [name each one in plain words — e.g. "no company identity or
contact details anywhere on the site" — never the internal item code]

### Key Changes

- [Notable improvement or concern 1]
- [Notable improvement or concern 2]

_This score summarises a 40-check domain review; the check-by-check detail is available on request._
```

**Note**: If no previous domain audit exists, mark the section in the report as "Not yet
evaluated" in the client's own words and skip it — the report never names the audit tool.
**Operator**: run `domain-authority-auditor` (`/seo:audit-domain`) to establish the baseline.

---

## 7. Content Quality (CORE-EEAT Score) Template

**Client-read surface — same rule as section 6.** Gloss CORE-EEAT on first use, then use the
label; never print a framework item ID (`O05`, `C01`, `Ept03`) or a command slug in the
report body (anti-slop-ruleset.md §6 family 8).

```markdown
## Content Quality

Content quality here is the **CORE-EEAT score**: an 80-check read of each audited page —
how clearly it answers, how it is organised, how quotable and distinctive it is (the parts
AI assistants reward), plus the experience, expertise, authority and trust signals search
engines weigh. Scored out of 100.

### Content Quality Summary

| Metric | Value |
|--------|-------|
| Pages Audited | [count] |
| Average CORE-EEAT Score | [score]/100 ([rating]) |
| Average score on the AI-visibility half (CORE) | [score]/100 |
| Average score on the search-trust half (EEAT) | [score]/100 |
| Blocking issues found | [count] ([name each in plain words — never the internal item code]) |

### Dimension Averages Across Audited Pages

| Dimension | Average Score | Trend |
|-----------|--------------|-------|
| C -- Contextual Clarity | [score] | [up/down/stable] |
| O -- Organization | [score] | [up/down/stable] |
| R -- Referenceability | [score] | [up/down/stable] |
| E -- Exclusivity | [score] | [up/down/stable] |
| Exp -- Experience | [score] | [up/down/stable] |
| Ept -- Expertise | [score] | [up/down/stable] |
| A -- Authority | [score] | [up/down/stable] |
| T -- Trust | [score] | [up/down/stable] |

### Key Content Quality Changes

- [Notable score changes since last report]
- [Pages with significant quality improvements/declines]

_Each page score summarises an 80-check content review; the check-by-check detail for any page is available on request._
```

**Note**: If no content quality audit exists, mark the section in the report as "Content
quality not yet evaluated" in the client's own words and skip it — the report never names
the audit tool or the command. **Operator**: run `content-quality-auditor`
(`/seo:audit-page`) on the key landing pages to establish the baseline.

---

## 8. Backlink Performance Template

```markdown
## Backlink Performance

### Link Profile Summary

| Metric | This Period | Last Period | Change |
|--------|-------------|-------------|--------|
| Total Backlinks | [X] | [Y] | [+/-Z] |
| Referring Domains | [X] | [Y] | [+/-Z] |
| Domain Authority | [X] | [Y] | [+/-Z] |
| Avg. Link DA | [X] | [Y] | [+/-Z] |

### Link Acquisition

| Period | New Links | Lost Links | Net |
|--------|-----------|------------|-----|
| Week 1 | [X] | [Y] | [+/-Z] |
| Week 2 | [X] | [Y] | [+/-Z] |
| Week 3 | [X] | [Y] | [+/-Z] |
| Week 4 | [X] | [Y] | [+/-Z] |
| **Total** | **[X]** | **[Y]** | **[+/-Z]** |

### Notable New Links

| Source | DA | Type | Value |
|--------|-----|------|-------|
| [domain 1] | [DA] | [type] | High |

### Competitive Position

Your referring domains rank #[X] of [Y] competitors.
```

---

## 9. Content Performance Template

```markdown
## Content Performance

### Content Publishing Summary

| Metric | This Period | Last Period | Target |
|--------|-------------|-------------|--------|
| New articles published | [X] | [Y] | [Z] |
| Content updates | [X] | [Y] | [Z] |
| Total word count | [X] | [Y] | - |

### Top Performing Content

| Content | Traffic | Rankings | Conversions | Status |
|---------|---------|----------|-------------|--------|
| [Title 1] | [X] | [Y] keywords | [Z] | Top performer |
| [Title 2] | [X] | [Y] keywords | [Z] | Growing |

### Content Needing Attention

| Content | Issue | Traffic Change | Action |
|---------|-------|----------------|--------|
| [Title] | [issue] | -[X]% | [action] |

### Content ROI

| Content Piece | Investment | Traffic Value | ROI |
|---------------|------------|---------------|-----|
| [Title 1] | $[X] | $[Y] | [Z]% |
```

---

## 10. Recommendations Template

```markdown
## Recommendations & Next Steps

### Immediate Actions (This Week)

| Priority | Action | Expected Impact | Owner |
|----------|--------|-----------------|-------|
| High | [Action 1] | [Impact] | [Owner] |

### Short-term (This Month)

| Priority | Action | Expected Impact | Owner |
|----------|--------|-----------------|-------|
| Medium | [Action 1] | [Impact] | [Owner] |

### Long-term (This Quarter)

| Priority | Action | Expected Impact | Owner |
|----------|--------|-----------------|-------|
| Planned | [Action 1] | [Impact] | [Owner] |

### Goals for Next Period

| Metric | Current | Target | Action to Achieve |
|--------|---------|--------|-------------------|
| Organic Traffic | [X] | [Y] | [action] |
| Keywords Top 10 | [X] | [Y] | [action] |
| AI Citations | [X] | [Y] | [action] |
| Referring Domains | [X] | [Y] | [action] |
```

---

## 11. Full Report Compilation Template

**This is the full-detail assembly, not the default one.** Which sections a given audience
receives is settled by the assembly table in [report-templates.md](./report-templates.md)
§4: a CEO/board pack is the executive template alone, an agency client gets executive plus
marketing sections 1-3 and 6, and only a full-detail reader gets the twelve-section
compilation below. Assemble to that row and drop the rest; the table of contents lists what
the pack actually contains.

The Appendix's Data Sources list is the report's own provenance record, so each entry is
resolved before the report leaves: the connected tool's real name, the export or hand-check
the figures actually came from, or a plain statement that the category was unavailable and
its figures are therefore absent. Never a `~~category` token — that token addresses the
operator, and the founding instance of this defect was a report's own source column (root
`CLAUDE.md` Tool Connector Pattern; anti-slop-ruleset.md §6 family 7).

```markdown
# [Company] SEO & GEO Performance Report

## [Month/Quarter] [Year]

---

### Table of Contents

1. Executive Summary
2. Organic Traffic Performance
3. Keyword Rankings
4. GEO/AI Visibility
5. Domain Authority
6. Content Quality
7. Backlink Analysis
8. Content Performance
9. Technical Health
10. Competitive Landscape
11. Recommendations
12. Appendix

---

[Include all sections from above]

---

## Appendix

### Data Sources
- [analytics platform used, by name] (traffic and conversion data)
- [search console property used, by name] (search performance)
- [SEO platform used, by name] (rankings and backlinks)
- [AI visibility tool used, by name — or "none connected; GEO metrics unavailable this period"]

### Methodology
[Explain how metrics were calculated]

### Glossary
- **GEO**: Generative Engine Optimization
- **DA**: Domain Authority
- [Additional terms]
```
