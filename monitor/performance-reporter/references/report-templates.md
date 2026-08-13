# SEO/GEO Report Templates

Copy-ready report templates for executive, marketing, and technical audiences. Copy the
structure, not the contents.

> **Illustrative example — the figures below are not measurements.** Every number,
> domain, publisher and period in these templates was made up to show the shape of a
> report; nobody measured any of it. In real output each figure comes from a named,
> dated source — ~~analytics, ~~search console, ~~SEO tool, ~~link database or a
> user-supplied export — and the report says which. Two rules the templates model on
> purpose, because a report that breaks them is checkable and will be checked:
>
> - **Never assign an authority score, a traffic figure or a link count to a real
>   named company or publication you have no data for.** The linking sites below use
>   the reserved `.example` TLD so no cell describes a real business; replace them with
>   the real domains you measured, each carrying the tool the score came from.
> - **Every derived number states the arithmetic that produces it**, in the report,
>   where the reader can redo it. A ratio whose own inputs sit two columns away is the
>   first thing an executive recomputes.

---

## 1. Executive Report Template

Use this template for C-suite, VP-level, or board reporting. Focuses on business impact, competitive position, and strategic recommendations. Keep to 1 page plus optional appendix.

---

```markdown
<!-- ILLUSTRATIVE FILL — every number, domain and date below is invented to show the
     shape of the report. Replace all of them with measured figures before this goes to
     anyone, and delete this comment. A figure you cannot source comes out of the
     report and is named as unavailable in the Data sources line. -->
# SEO & GEO Performance Summary

**Period:** January 2025
**Prepared for:** Leadership Team
**Prepared by:** [Name], SEO Lead
**Data sources:** [analytics platform, rank tracker and link database used, each with its
pull date] — every figure below traces to one of them, and a metric no source covers is
reported as unavailable rather than estimated

---

## Performance at a Glance

| KPI | Jan 2025 | Dec 2024 | MoM Change | YoY Change | Target | Status |
|-----|----------|----------|------------|------------|--------|--------|
| Organic Revenue | $142,000 | $128,000 | +10.9% | +34% | $130,000 | On track |
| Organic Sessions | 285,000 | 261,000 | +9.2% | +28% | 270,000 | On track |
| Keywords in Top 10 | 187 | 172 | +15 | +62 | 180 | On track |
| AI Citations | 34 | 28 | +21.4% | N/A | 30 | On track |
| Domain Rating | 52 | 51 | +1 | +8 | 55 | Watch (94.5% of target) |
| Organic CVR | 2.8% | 2.6% | +0.2pp | +0.5pp | 2.5% | On track |

## Competitive Position

**Share of Voice Ranking:** #2 of 5 tracked competitors (up from #3 in Q3)

Visibility Share below is each site's share of the tracked visibility across **these five sites on
the 240 tracked keywords** — the rank tracker's own visibility metric, named with its pull date in
the sources line. It is not share of a market: adding a sixth competitor changes every row. The
five shares sum to 100% by construction, so a rise for one site is a fall for another and neither
half of that means growth on its own.

| Rank | Competitor | Visibility Share |
|------|-----------|-----------------|
| 1 | CompetitorA.com | 28% |
| **2** | **YourSite.com** | **24%** |
| 3 | CompetitorB.com | 21% |
| 4 | CompetitorC.com | 16% |
| 5 | CompetitorD.com | 11% |

## Key Wins

1. **Achieved #1 ranking for "project management software"** — $18K/month traffic value, which is the rank-tracking tool's modelled estimate for this keyword at position 1, not booked revenue
2. **AI citations rose from 28 to 34** (+21% MoM) — 34 of the 78 tracked queries returning an AI Overview cited us, a citation rate of 43.6%, up from 28 of 72 (38.9%) in December: **+4.7 percentage points**, on a query set that grew by six
3. **Published research report generated 45 backlinks** — including industrynews.example (DR 94) and businessmagazine.example (DR 95); see the link table for how each DR was sourced

## Risks & Mitigation

1. **Google core update expected in February** — monitoring closely; content quality scores above benchmark
2. **CompetitorA increased content production 2x** — accelerating our editorial calendar in response
3. **Mobile CWV scores degraded** — engineering team addressing LCP issue, fix scheduled for Feb 15

## Investment & ROI

| Item | Jan Spend | Jan Organic Revenue | Jan ROI |
|------|----------|--------------------|---------|
| SEO team | $12,000 | (not split by line item) | (not split by line item) |
| Content production | $8,000 | (not split by line item) | (not split by line item) |
| Tools & data | $2,500 | (not split by line item) | (not split by line item) |
| **Total** | **$22,500** | **$142,000** | **531%** |

ROI = (organic revenue − spend) / spend = ($142,000 − $22,500) / $22,500 = 531%. Both
columns cover the same month, January. State the formula and the period every time: on
the same figures, revenue ÷ spend gives 631%, and a reader who assumes the other
definition is out by 100 points. Revenue is not attributable to individual cost lines,
so no per-line ROI is shown rather than repeating the total in each row.

## Ask for Next Period

- Approve $5,000 budget increase for digital PR campaign targeting Q2 product launch
- Engineering allocation: 20 hours for Core Web Vitals remediation
```

---

## 2. Marketing Team Report Template

Use this template for marketing managers, content teams, and channel leads. Provides detailed performance data with actionable insights.

---

```markdown
<!-- ILLUSTRATIVE FILL — every number, domain and date below is invented to show the
     shape of the report. Replace all of them with measured figures before this goes to
     anyone, and delete this comment. Linking sites stay on the reserved `.example` TLD
     until you have a real, dated export to name. -->
# Monthly SEO & GEO Performance Report

**Domain:** yoursite.com
**Period:** January 1-31, 2025
**Comparison:** vs. December 2024 and January 2024
**Prepared:** February 3, 2025

---

## 1. Traffic Performance

### Overview

| Metric | Jan 2025 | Dec 2024 | MoM | Jan 2024 | YoY |
|--------|----------|----------|-----|----------|-----|
| Organic Sessions | 285,000 | 261,000 | +9.2% | 223,000 | +27.8% |
| Organic Users | 198,000 | 182,000 | +8.8% | 158,000 | +25.3% |
| Organic Pageviews | 412,000 | 378,000 | +9.0% | 318,000 | +29.6% |
| Bounce Rate | 42% | 44% | -2pp | 48% | -6pp |
| Avg Session Duration | 3:12 | 3:05 | +3.8% | 2:48 | +14.3% |
| Pages/Session | 2.4 | 2.3 | +4.3% | 2.1 | +14.3% |

### Traffic by Device

| Device | Sessions | % of Total | MoM Change | CVR |
|--------|----------|------------|------------|-----|
| Desktop | 142,500 (50%) | 50% | +7.1% | 3.2% |
| Mobile | 131,100 (46%) | 46% | +11.5% | 2.1% |
| Tablet | 11,400 (4%) | 4% | +5.6% | 2.8% |

### Non-Brand vs. Brand Split

| Segment | Sessions | % of Organic | MoM Change |
|---------|----------|-------------|------------|
| Non-brand | 184,000 | 64.6% | +12.1% |
| Brand | 101,000 | 35.4% | +4.1% |

**Insight:** Non-brand growth outpacing brand growth indicates SEO is driving new audience discovery effectively.

## 2. Keyword Rankings

### Position Distribution

| Range | Jan 2025 | Dec 2024 | Change |
|-------|----------|----------|--------|
| Position #1 | 23 | 19 | +4 |
| Position #2-3 | 41 | 38 | +3 |
| Position #4-10 | 123 | 115 | +8 |
| Position #11-20 | 89 | 94 | -5 |
| Position #21-50 | 156 | 162 | -6 |
| Not ranking | 68 | 72 | -4 |
| **Total tracked** | **500** | **500** | — |

### Top 5 Ranking Improvements

| Keyword | Volume | Old Rank | New Rank | Change | Est. Traffic |
|---------|--------|----------|----------|--------|-------------|
| project management software | 18,100 | 4 | 1 | +3 | +4,200/mo |
| best CRM for small business | 8,200 | 12 | 6 | +6 | +380/mo |
| team collaboration tools | 6,500 | 8 | 3 | +5 | +420/mo |
| agile methodology guide | 4,400 | 22 | 9 | +13 | +180/mo |
| remote work software | 5,100 | 15 | 7 | +8 | +210/mo |

Est. Traffic is the rank tracker's modelled click estimate for the new position at the
listed volume — a model output, not measured sessions. Name the model or the CTR curve
behind it; an estimate with neither stated does not belong in a column headed with a
number.

### Top 5 Ranking Declines

| Keyword | Volume | Old Rank | New Rank | Change | Action |
|---------|--------|----------|----------|--------|--------|
| kanban board software | 3,600 | 5 | 11 | -6 | Content refresh scheduled Feb 10 |
| project planning template | 2,900 | 7 | 14 | -7 | Competitor published superior template |
| time tracking tools | 4,100 | 9 | 15 | -6 | New SERP features displacing organic |
| workflow automation | 3,200 | 6 | 9 | -3 | Monitoring, within normal fluctuation |
| sprint planning guide | 1,800 | 3 | 8 | -5 | Content update needed with 2025 examples |

## 3. Content Performance

### Top Performing Content (by Organic Traffic)

| Page | Sessions | MoM | Rankings | Conversions |
|------|----------|-----|----------|-------------|
| /blog/project-management-guide | 18,400 | +22% | 12 KWs top 10 | 184 |
| /product/features | 15,200 | +8% | 8 KWs top 10 | 456 |
| /blog/crm-comparison | 12,100 | +15% | 9 KWs top 10 | 121 |
| /resources/templates | 9,800 | +31% | 6 KWs top 10 | 98 |
| /blog/remote-work-tips | 8,600 | +5% | 5 KWs top 10 | 43 |

### Content Needing Refresh (Decaying Traffic)

| Page | Sessions | MoM | Age | Action |
|------|----------|-----|-----|--------|
| /blog/2023-trends | 2,100 | -35% | 14mo | Rewrite as 2025 trends |
| /blog/old-tool-comparison | 1,400 | -28% | 18mo | Update with current pricing/features |
| /guides/beginner-pm | 3,200 | -18% | 10mo | Add interactive elements, update screenshots |

## 4. GEO / AI Visibility

| Metric | Jan 2025 | Dec 2024 | Change |
|--------|----------|----------|--------|
| Queries with AI Overview | 78/500 | 72/500 | +6 |
| Your citations in AI | 34 | 28 | +6 |
| Citation rate | 43.6% | 38.9% | +4.7pp |
| Avg citation position | 2.1 | 2.4 | -0.3 (better — cited higher) |

### New AI Citations Won

- "best project management software" — cited as #1 source
- "how to create a project plan" — cited as #2 source
- "agile vs waterfall" — cited as #3 source

## 5. Backlink Performance

| Metric | Jan 2025 | Dec 2024 | Change |
|--------|----------|----------|--------|
| Total referring domains | 1,847 | 1,812 | +35 |
| New links acquired | 62 | 48 | +14 |
| Links lost | 27 | 31 | -4 (fewer lost) |
| Average new link DR | 41 | 38 | +3 |

### Notable New Links

| Source | DR | DR source | Type |
|--------|-----|-----------|------|
| industrynews.example | 94 | Link database export, Feb 3 | Press mention (research report) |
| businessmagazine.example | 95 | Link database export, Feb 3 | Expert quote in roundup |
| vendorblog.example | 93 | Link database export, Feb 3 | Resource citation |

Linking sites appear on the reserved `.example` TLD here because nobody measured a DR for
a real publication to put in this table. Your own report names the real domains — and
keeps the DR source column: a DR with no named, dated export behind it is not reportable,
and a DR attached to a real publisher on no evidence is a checkable falsehood in a
document the client may forward.

## 6. Action Items

| Priority | Action | Owner | Deadline |
|----------|--------|-------|----------|
| P0 | Fix mobile LCP issue (currently 3.8s) | Engineering | Feb 15 — later than P0 implies: the fix ships with the engineering sprint that opens Feb 10 |
| P1 | Refresh kanban board software article | Content | Feb 10 |
| P1 | Publish 2025 trends article (replace 2023 version) | Content | Feb 14 |
| P2 | Build links to CRM comparison page (target: 5 new) | SEO | Feb 28 |
| P2 | Optimize 3 pages for AI citation (add structured data) | SEO | Feb 21 |
| P3 | Research new keyword opportunities in "AI tools" space | SEO | Feb 28 |

Priority is P0-P3 and only P0-P3 — the single scheme this skill grades actions on
(`report-output-templates.md` §10, which carries the definitions and the default
priority-to-horizon map). The Deadline column is the other axis: when the work is booked, set
from capacity and dependencies rather than from impact. They come apart, and the first row is
why the two columns exist — the highest-priority item here has the latest deadline of the top
three, so it says so in its own cell. A deadline later than its priority's default horizon
carries that reason; earlier needs no note.
```

---

## 3. Technical SEO Report Template

Use this template for engineering teams, dev leads, and technical stakeholders. Focuses on crawlability, indexation, performance, and error resolution.

**Status words here are a movement band, not a target comparison.** These tables have no target
column — a crawl rate or a response time has no agreed number it is supposed to be at — so the
On track / Watch / Off track bands that govern the KPI tables (`report-output-templates.md` §2)
do not reach them and must not be borrowed. What a technical Status word grades is how far the
metric moved from its own baseline and what that movement obliges: the same axis `alert-manager`
calls a threshold band, read three steps coarse for a periodic report rather than as a firing
threshold.

- **Normal** — inside the range this metric normally varies in, or moving in the improving
  direction. Nothing to do.
- **Monitor** — outside normal variation, but no threshold with a known cost has been crossed.
  Name what will be re-checked and when. It does not produce an action item.
- **Investigate** — a threshold with a known cost was crossed, or the cause is unknown and the
  metric gates something downstream (crawl, indexation, rendering). It produces a row in the
  action-items table with a priority and an owner. Investigate is the finding; P0-P3 is what
  happens about it; neither word substitutes for the other.

**Each Status word prints the comparison that produced it, in its own cell** — the same rule the
KPI statuses follow when they print their percentage of target (SKILL.md, Figure Discipline: a
word-rating shows its working where it is printed). That comparison is one of three things and
nothing else: a published band quoted verbatim **with its window** (Core Web Vitals against the
CrUX bands in `kpi-definitions.md`; a band borrowed from the alert configuration keeps the window
it was defined on — `>10 new crawl errors/day` does not grade a period total of 18); or this
site's own observed variation with the span it was measured over; or, where neither exists, no
Status word at all — "no baseline — first measurement" is the honest cell. Where the band is
already printed beside the figure, as in the Core Web Vitals rows, the Status cell restates it
and needs nothing further.

Two neighbouring columns are deliberately **not** this scale, and folding them into it would lose
information: a **workflow state** (Pending · Investigating · Redirect created Jan 8, in the
error-resolution table) says where the work has got to, not how a metric moved; and **Effort and
Impact sized Low · Medium · High** in the technical debt tracker size the job, not its urgency.
Neither is a priority and neither becomes a P-level.

---

```markdown
<!-- ILLUSTRATIVE FILL — every number, domain and date below is invented to show the
     shape of the report. Replace all of them with measured figures before this goes to
     anyone, and delete this comment. Each Status word keeps the comparison that produced
     it in its own cell; a metric with no baseline and no published band gets
     "no baseline — first measurement" rather than a Status word. -->
# Technical SEO Health Report

**Domain:** yoursite.com
**Period:** January 2025
**Prepared:** February 3, 2025

---

## 1. Crawl Health

### Crawl Stats Summary

| Metric | Jan 2025 | Dec 2024 | Change | Status |
|--------|----------|----------|--------|--------|
| Total pages crawled | 12,400 | 11,800 | +5.1% | Normal — inside the ±8% month-to-month range this site has held since Aug |
| Avg crawl rate (pages/day) | 400 | 381 | +5.0% | Normal — same ±8% range, and moving the useful way |
| Avg response time | 320ms | 290ms | +10.3% | Monitor — first move outside that range; re-check on the Mar 3 pull |
| Crawl errors | 18 | 12 | +6 | Investigate — 18 vs 12 is +50%, cause unknown, and crawl errors gate indexation → action item below |

### Crawl Budget Efficiency

| Page Type | Pages Crawled | % of Crawl | Should Crawl? |
|-----------|-------------|-----------|---------------|
| Blog posts | 4,200 | 33.9% | Yes |
| Product pages | 3,100 | 25.0% | Yes |
| Category pages | 2,400 | 19.4% | Yes |
| Parameter URLs | 1,800 | 14.5% | No — block in robots.txt |
| Paginated archives | 900 | 7.3% | Partially — consolidate |

**Action:** Block parameter URLs via robots.txt to reclaim 14.5% of crawl budget.

## 2. Index Coverage

### Index Status

| Status | Count | Change | Action |
|--------|-------|--------|--------|
| Valid (indexed) | 2,847 | +23 | None — healthy growth |
| Valid with warnings | 42 | +3 | Review warnings |
| Excluded (intentional) | 1,204 | +8 | Verify intentional |
| Excluded (error) | 67 | +12 | Fix errors |

### Exclusion Reasons (Top 5)

| Reason | Count | Change | Priority |
|--------|-------|--------|----------|
| Crawled, not indexed | 34 | +8 | P1 — improve content quality |
| Duplicate without canonical | 15 | +2 | P2 — add canonical tags |
| Blocked by robots.txt | 12 | 0 | P3 — confirm the block is still intentional |
| Soft 404 | 6 | +2 | P1 — fix or redirect |
| Server error (5xx) | 0 | 0 | no action — none open |

## 3. Core Web Vitals

### Field Data (CrUX — 28-day rolling)

| Metric | Mobile | Desktop | Status |
|--------|--------|---------|--------|
| LCP | 3.8s (Needs Improvement) | 2.1s (Good) | Mobile needs fix |
| CLS | 0.08 (Good) | 0.05 (Good) | Passing |
| INP | 180ms (Good) | 120ms (Good) | Passing |

### LCP Diagnosis (Mobile)

| Page Group | Mobile LCP | Issue | Fix |
|-----------|-----------|-------|-----|
| /blog/* | 4.2s | Hero images not optimized | Convert to WebP, add lazy loading |
| /product/* | 3.5s | Third-party script blocking render | Defer non-critical scripts |
| /resources/* | 3.1s | Large CSS bundle | Code-split CSS |

**Estimated fix timeline:** 2 weeks (engineering sprint Feb 10-21)

## 4. Error Log

### New Errors This Period

| Error Type | Count | Pages Affected | Priority |
|-----------|-------|---------------|----------|
| 404 Not Found | 8 | /blog/deleted-post-1, /old/page-2, +6 | P1 |
| 500 Server Error | 3 | /api/webhook (intermittent) | P0 |
| Redirect chain (3+ hops) | 5 | /old-url -> /new-url -> /final-url | P2 |
| Mixed content warning | 2 | /resources/old-guide, /tools/calc | P2 |

### Error Resolution Status

| Error | Opened | Status | Owner |
|-------|--------|--------|-------|
| 404 on /blog/deleted-post-1 | Jan 5 | Redirect created Jan 8 | SEO |
| 500 on /api/webhook | Jan 12 | Investigating | Backend |
| Redirect chain on /old-url | Jan 15 | Pending | SEO |

## 5. Schema & Rich Results

### Schema Validation

| Schema Type | Pages | Valid | Warnings | Errors |
|------------|-------|-------|----------|--------|
| Article | 342 | 338 | 4 | 0 |
| Product | 89 | 87 | 0 | 2 |
| FAQ | 56 | 56 | 0 | 0 |
| HowTo | 23 | 23 | 0 | 0 |
| BreadcrumbList | 2,847 | 2,847 | 0 | 0 |

**Action:** Fix 2 Product schema errors (missing "price" property on clearance items).

## 6. Technical Debt Tracker

| Item | Priority | Effort | Impact | Status |
|------|----------|--------|--------|--------|
| Block parameter URLs in robots.txt | P1 | Low | Crawl budget +14% | Scheduled Feb 5 |
| Fix mobile LCP (image optimization) | P0 | Medium | CWV pass rate | Sprint Feb 10-21 |
| Consolidate duplicate pages (42 pages) | P2 | Medium | Index quality | Backlog |
| Implement hreflang for EN-GB pages | P3 | High | International SEO | Q2 planned |
| Migrate HTTP resources to HTTPS | P2 | Low | Security + trust | Scheduled Feb 12 |

## 7. Recommendations for Engineering

1. **Immediate:** Resolve intermittent 500 errors on /api/webhook endpoint
2. **This sprint:** Optimize hero images on blog templates (convert to WebP, implement responsive sizes)
3. **Next sprint:** Defer third-party scripts on product pages (move to async loading)
4. **Backlog:** Implement edge caching for static blog content to improve TTFB
```

---

## 4. Report Assembly Guidelines

### How to Combine Templates

This table decides which sections a pack contains — it governs step 11 of the skill, and the
twelve-section compilation in `report-output-templates.md` §11 is the full-detail assembly
rather than the default. A board pack is the executive template alone: sections its row
excludes are left out, not summarised into it.

| Audience | Include Sections | Exclude |
|----------|-----------------|---------|
| CEO / Board | Executive template only | All technical detail |
| VP Marketing | Executive + Marketing sections 1-4, 6 | Crawl stats, schema details |
| Marketing Manager | Full Marketing template | Deep technical debugging |
| SEO Manager | Marketing + Technical templates | Executive ROI framing |
| Engineering Lead | Technical template only | Revenue, keyword details |
| Client (agency) | Executive + Marketing sections 1-3, 6 | Internal cost data, technical debt |

### Data Freshness Requirements

| Report Type | Maximum Data Age | Reason |
|------------|-----------------|--------|
| Executive monthly | 3 days after period end | Allow for data processing lag |
| Marketing weekly | 1 day after period end | Timely action items |
| Technical | Real-time where possible | Issues need immediate attention |
| Quarterly review | 5 days after quarter end | Allow for data reconciliation |

### Report Delivery Checklist

- [ ] All data sources verified and dated
- [ ] Period-over-period comparisons included
- [ ] Competitor context provided where relevant
- [ ] Action items are specific, assigned, and time-bound
- [ ] Report tailored to audience (no jargon for executives, full detail for technical)
- [ ] Visualizations are clear and labeled
- [ ] Sources cited for all external benchmarks
- [ ] Every band, range or threshold quoted from the KPI reference reproduced verbatim — checked against the reference line, not from memory — with the multiplier shown for any figure derived from it, and the same band stated identically wherever it recurs
- [ ] Every sensitivity or "what if" figure names the exact perturbation it assumes and is computed from it
- [ ] Sections match the audience's row in the assembly table above
- [ ] Draft reviewed for accuracy before distribution
