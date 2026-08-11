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

**Three figures in this block are computed, not judged — print the working beside each.**

- **Status**, per KPI row: compare the period's value with that row's target. **On track** = at or
  above target · **Watch** = below target but at least 90% of it · **Off track** = below 90% of
  target. Exactly at target is On track; exactly 90% is Watch. For a metric where lower is better
  (bounce rate, average position, cost per lead) invert the ratio — target ÷ actual — before
  reading the bands. A row with no target agreed reads "no target set" and is left out of the
  Status column and out of the rating tally below.
- **Overall Performance**, one rating for the pack, is a tally of those statuses and nothing else:
  **Excellent** = every scored row On track · **Good** = no row Off track · **Needs Attention** =
  at least one Off track, but fewer than half the scored rows · **Critical** = half or more of the
  scored rows Off track. Print the tally next to the word: `Overall Performance: Good — 5 KPIs
  scored: 1 on track, 4 watch, 0 off track`. A rating with no tally beside it is an impression,
  and the next report will not reproduce it.
- **ROI** uses the kpi-definitions formula and shows it: `(organic revenue − investment) ÷
  investment × 100`. Print the substituted numbers, because revenue ÷ investment on the same
  figures lands 100 points higher and both are called "ROI" in the wild. Round to the nearest
  whole percent, half up. Same period on both sides, and if attribution covers only part of the
  revenue, say which part.

```markdown
# SEO Performance Report

**Domain**: [domain]
**Period**: [date range]
**Prepared**: [date]

---

## Executive Summary

### Overall Performance: [Excellent/Good/Needs Attention/Critical] — [N] KPIs scored: [X] on track, [Y] watch, [Z] off track

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

| Metric | This Period | Last Period | Change | Target | % of target | Status |
|--------|-------------|-------------|--------|--------|-------------|--------|
| Organic Traffic | [X] | [Y] | [+/-Z%] | [T] | [X÷T as %] | [On track / Watch / Off track] |
| Keyword Rankings (Top 10) | [X] | [Y] | [+/-Z] | [T] | [X÷T as %] | [status] |
| Organic Conversions | [X] | [Y] | [+/-Z%] | [T] | [X÷T as %] | [status] |
| Domain Authority | [X] | [Y] | [+/-Z] | [T] | [X÷T as %] | [status] |
| AI Citations | [X] | [Y] | [+/-Z%] | [T] | [X÷T as %] | [status] |

### SEO ROI

**Investment**: $[X] (content, tools, effort)
**Organic Revenue**: $[Y]
**ROI**: ($[Y] − $[X]) ÷ $[X] = [Z]%
```

---

## 3. Organic Traffic Analysis Template

````markdown
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
````

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
| Citation Rate | [citations] ÷ [queries with an AI answer] = [X]% | [same, last period] | [+/-Z pp] |
| Avg Citation Position | [X] | [Y] | [+/-Z] |

Citation Rate carries both counts in both periods, because its denominator moves on its own: a
rate that rose while the query set shrank is a different story from one that rose on citations
won, and only the two fractions side by side tell them apart. The denominator is queries that
returned an AI answer, not all monitored queries (kpi-definitions, AI Citation Rate). Report the
period-over-period move in **percentage points**, not as a percentage of a percentage. Avg
Citation Position is the mean of the positions of the citations counted above — state how many
citations it averages, and withhold it below three rather than publishing a mean of one.

### AI Citation by Topic

| Topic Cluster | Opportunities | Citations | Rate |
|---------------|---------------|-----------|------|
| [Topic 1] | [X] | [Y] | [Y÷X as %] |

Rate here is the same arithmetic on one cluster's rows; the cluster rates do not average to the
site-wide rate — recompute that one from its own totals.

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
| AI share of total sessions | [X] ÷ [total sessions] = [S]% | [same, last period] | [+/-Z pp] |

Share prints its denominator in both periods: total sessions, all channels, same property and
window as the numerator. A share change is stated in percentage points; the sessions change beside
it is a percentage — the two lines are not the same number said twice.

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
| Average CORE-EEAT Score | [score]/100 — unweighted mean of the [count] page scores — [rating] |
| Average score on the AI-visibility half (CORE) | [score]/100 — mean of the same pages' CORE scores |
| Average score on the search-trust half (EEAT) | [score]/100 — mean of the same pages' EEAT scores |
| Blocking issues found | [count] ([name each in plain words — never the internal item code]) |

Every average here is a plain mean over the pages audited **in this period**, each page counting
once whatever its traffic — say so, because a traffic-weighted average of the same pages is a
different number and a reader will assume whichever one flatters. A page whose audit was blocked
(a veto fired, so it carries no final score) is excluded from the mean and named; averaging in a
capped or absent score misstates both. Two pages is not an average worth printing: below three
audited pages, list the page scores instead. Where a previous period's average is shown for
comparison, it has to cover the same page set or the comparison says which pages entered and left.
The `[rating]` word is read off the content-quality-auditor scale this library already publishes —
90-100 Excellent · 75-89 Good · 60-74 Medium · 40-59 Low · 0-39 Poor — quoted, not re-cut, and
applied to the average exactly as it applies to a page score.

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
| [Title 1] | $[X] | $[Y] | ($[Y] − $[X]) ÷ $[X] = [Z]% |

Same formula as the executive block, and the same warning: this ROI runs on **traffic value**, a
modelled figure (organic clicks × CPC, from the tool that models it — name it), not on booked
revenue. Two rows measured on different bases never share a column; if only some pieces have
revenue attached, split the table rather than blending the two. Content published inside the
reporting period has not had time to earn its traffic — say so beside its row instead of printing
a negative ROI as a verdict.
```

---

## 10. Recommendations Template

**Two columns, two questions — and the Priority column answers only one of them.** The
**priority** (P0 · P1 · P2 · P3) says how much the action matters and who acts first; it is set
from business impact. The **horizon** — which of the three sections below the row sits in — says
when the work is booked; it is set from capacity, dependencies and whoever owns the calendar.
The Priority column carries a P-level and nothing else. A schedule word — "Planned", "Backlog",
"Q2" — is not a priority: it belongs to the horizon, which the section heading already states,
and this skill's own Technical Debt Tracker ([report-templates.md](./report-templates.md) §3,
technical template, table 6) already keeps it in a separate Status column beside a P-level
Priority column. P0-P3 is the library convention — `keyword-research` and `content-gap-analysis`
both read their priority tiers as P0-P3, and `alert-manager` grades response priority on the same
four levels. It is what `kpi-definitions.md` promises this skill's readers ("Action Items — P0-P3
prioritized task list"), and what the Action Items table in report-templates.md §2 already prints.

Default pairing — a work queue, not a pager rota: **P0** starts before anything else, today when
the damage is live (manual action, deindexation, outage, security incident) · **P1** this week or
the current sprint · **P2** this month · **P3** this quarter or the backlog. A row booked past the
end of its priority's default horizon names the reason in the same line — "P0 · ships Feb 15, the
sprint that owns the fix opens Feb 10". Earlier than default needs no note; pulling work
forward surprises nobody. `alert-manager` uses these same four names on this same axis with far
shorter clocks, because an alert is an incident and a recommendation is work: the names carry
across the two skills, the clocks do not.

**Converting a report that graded High / Medium / Planned** — the previous wording of this
template: **High → P1 · Medium → P2 · Planned → P3**, section headings unchanged. Nothing moves,
because those three words were fixed per section: every Immediate row read High, every Short-term
row read Medium, every Long-term row read Planned, so the column restated its own heading and
carried no information of its own. **P0 is new headroom** — no row that read High becomes P0 by
conversion, only by meeting the P0 test above, and then it says why in the same line.

Everywhere a Priority column appears in this skill — here, the action items and exclusion-reason
tables in report-templates.md, the error log, the technical debt tracker — it holds a P-level and
optionally the one-line reason. A row with nothing to do reads **"no action —"** plus why, never
a blank and never a bare word that reads like a level ("Clean", "Verify intentional"): a reader
scanning a Priority column cannot tell a level they do not recognise from a level they missed.

```markdown
## Recommendations & Next Steps

### Immediate Actions (This Week)

| Priority | Action | Expected Impact | Owner |
|----------|--------|-----------------|-------|
| P0 | [Only live damage belongs here — name it] | [Impact] | [Owner] |
| P1 | [Action 1] | [Impact] | [Owner] |

### Short-term (This Month)

| Priority | Action | Expected Impact | Owner |
|----------|--------|-----------------|-------|
| P2 | [Action 1] | [Impact] | [Owner] |

### Long-term (This Quarter)

| Priority | Action | Expected Impact | Owner |
|----------|--------|-----------------|-------|
| P3 | [Action 1] | [Impact] | [Owner] |

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
