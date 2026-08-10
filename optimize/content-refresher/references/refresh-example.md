# Content Refresher — Worked Example & Checklist

Referenced from [SKILL.md](../SKILL.md).

---

## Worked Example

**User**: "Refresh my blog post about 'best cloud hosting providers'"

**What the user supplied** — no tools were connected in this session, so these four items are the
entire data set. Every figure below traces to one of them, and nothing else is asserted:

1. **GA4 organic-session export** for the URL, monthly, last 12 months
2. **Search Console export** for the URL, monthly over the same 12 months — impressions, CTR,
   average position
3. **CMS record** — published 2023-02-14, never updated since; current word count 2,100
4. **The owner's own note of 8 Aug** — the two competitor guides they read that morning and what
   those pages cover, their re-check of two of the five listed providers' pricing pages, their
   check of the article's own outbound links, and a partner's referring-domain figure

No SERP check was run in this session and none was supplied, so the report makes **no claim about
who outranks this page today**. The competitor lines below are about two pages one person read on
one date, and say so.

**Output**:

```markdown
### CORE-EEAT Quick Assessment

**Content**: "Best Cloud Hosting Providers 2023"
**Content Type**: Commercial comparison / listicle
**Method**: 5 items checked per dimension, graded Pass 10 / Partial 5 / Fail 0 — this skill's own
quick estimate from reading the page, not a tool measurement. Priority follows the score
(🔴 <50 · 🟡 50-74 · 🟢 ≥75).

| Dimension | Quick Score (points ÷ items checked) | Key Weakness | Refresh Priority |
|-----------|-----------|--------------|-----------------|
| C — Contextual Clarity | 70/100 — 35 pts over 5 (C02, C03, C05 Pass; C01 Partial; C09 Fail) | Title still promises 2023; no FAQ coverage | 🟡 |
| O — Organization | 80/100 — 40 pts over 5 (O01, O03, O04, O06 Pass; O02 Fail) | Good comparison tables, no summary box | 🟢 |
| R — Referenceability | 10/100 — 5 pts over 5 (R01 Partial; R02, R03, R06, R10 Fail) | Pricing dated Q1 2023; 3 cited links do not resolve | 🔴 |
| E — Exclusivity | 30/100 — 15 pts over 5 (E06, E08, E09 Partial; E01, E05 Fail) | No original benchmarks or test data | 🔴 |
| Exp — Experience | 10/100 — 5 pts over 5 (Exp10 Partial; Exp01, Exp04, Exp05, Exp08 Fail) | No first-person testing narrative | 🔴 |
| Ept — Expertise | 60/100 — 30 pts over 5 (Ept03, Ept04 Pass; Ept01, Ept08 Partial; Ept02 Fail) | Author bio present but lacks credentials | 🟡 |
| A — Authority | 60/100 — 30 pts over 5 (A05, A08 Pass; A01, A06 Partial; A02 Fail) | Thin backlink profile (12 referring domains — partner figure, 8 Aug); no media mentions | 🟡 |
| T — Trust | 30/100 — 15 pts over 5 (T01 Pass; T02 Partial; T04, T05, T06 Fail) | Affiliate links present, no disclosure | 🔴 |

**Veto flagged — T04**: affiliate links are present with no disclosure, so a material connection
exists and T04's conditional veto applies. The quick pass records it; the full 80-item audit rules
on it and applies the score cap. Disclosure is therefore a publish-blocker for this refresh, not a
nice-to-have. R10 is a Fail here on unresolving cited links; that is not the R10 veto trigger,
which is material self-contradiction.

**Weakest Dimensions** (focus refresh here):
1. **Experience — 10/100** — Add hands-on testing results ("We migrated a test site to each provider")
2. **Referenceability — 10/100** — Re-source every price and uptime figure, fix the 3 dead citations

## Content Refresh Analysis: Best Cloud Hosting Providers 2023

**URL**: cloudhosting.example/best-cloud-hosting
**Published**: 2023-02-14
**Last Updated**: Never
**Word Count**: 2,100

### Performance Metrics

**Source**: user-provided — sessions from the owner's GA4 export, the other three rows from their
12-month Search Console export, comparing the latest month with the month six before it. No tool
was connected in this session.

| Metric | 6 Mo Ago | Current | Change |
|--------|----------|---------|--------|
| Organic Traffic | 3,200/mo | 1,400/mo | -56% |
| Avg Position | 4.2 | 14.8 | ↓ 10.6 |
| Impressions | 18,000 | 9,500 | -47% |
| CTR | 6.1% | 2.3% | -3.8 pp (−62% relative) |

### Composite Decay Score — 91.2/100

Derived from 4 of the 5 signals: traffic −56% (score 75 × 30/85), average position 14.8, off page 1
(100 × 25/85), CTR −62% relative (100 × 15/85), freshness 3.5 years with facts since changed
(100 × 15/85). **Competitive displacement is unscored** — no dated SERP check was run or supplied —
so the four remaining weights were renormalised over their own 85% sum (displayed as 35.3%, 29.4%,
17.6% and 17.6%; the arithmetic runs on the fractions, per content-decay-signals.md):
26.47 + 29.41 + 17.65 + 17.65 = 91.18 → 91.2/100, and the band is read off 91.

Band: terminal decay — **urgency, not disposition**. The disposition comes from the refresh-vs-
rewrite framework below, and it is REFRESH.

### Content Decay Signals Identified

1. **Outdated year in title and H1** — "2023" is three years stale in the title tag and H1
2. **Pricing dated Q1 2023** — the owner re-checked two of the five listed providers' pricing pages
   on 8 Aug and both had changed; the other three are unchecked, so no current price is stated for
   them here. Every price in the article is re-sourced at refresh time or removed
3. **Coverage gap** — both competitor guides the owner read on 8 Aug carry two providers this
   article does not (their note). Two pages read on one date is not a competitor census, and no
   claim is made about how those pages rank
4. **3 dead outbound links** — of the 14 outbound links in this article, 3 returned 404 in the
   owner's own check on 8 Aug. Population: this article's links only; no other page was checked

### Refresh vs. Rewrite Decision

| Factor | Assessment |
|--------|-----------|
| Content quality | Good structure, solid comparison tables — foundation is sound |
| URL equity | 12 referring domains (partner figure, 8 Aug); published 3.5 years ago |
| Scope of changes | ~40% of content needs updating |
| Search intent | Unchanged — still commercial comparison |

**Decision**: **REFRESH** — The URL has earned backlinks, the structure is solid, and less than 50% needs rewriting. Keep the URL, update in place.

## Content Refresh Plan

**Current Title**: "Best Cloud Hosting Providers 2023"
**Refreshed Title**: "Best Cloud Hosting Providers 2026: 7 Platforms Tested & Compared"

### Specific Refresh Actions

1. **Re-source all pricing and specs** (~30 min)
   - Open each of the 5 listed providers' pricing pages, record the price and the date read; a plan
     nobody re-checked keeps no price in the refreshed article
   - Add uptime figures only where a public status page carries them, cited to that page
   - Update feature comparison table with current plan tiers

2. **Add the 2 missing providers + testing narrative** (~600 words)
   - Add the two providers the owner's competitor note names, in the same comparison format
   - Write intro paragraph: "We deployed a WordPress benchmark site to each provider and measured TTFB, uptime, and support response times over 30 days"

3. **Add affiliate disclosure and FAQ section** (~200 words)
   - Add disclosure statement below introduction: "This post contains affiliate links. See our editorial policy." — this clears the T04 veto and ships with the refresh, not after it
   - Add FAQ with 4 questions the article's own queries raise (e.g., "What is the cheapest cloud hosting?", "Is cloud hosting faster than shared hosting?"), 40-60 words each
   - FAQ *content* ships. FAQPage markup does **not**: this page is a commercial comparison, not
     also an FAQ resource, so a second full content type would be stacking (ruling R2). Where a page
     does pass that test, the markup is kept for AI-engine/GEO parsing (FAQ rich results retired 2026 — no SERP feature) and claims nothing else (ruling R3)

4. **Fix dead links and update internal links** (~15 min)
   - Replace the 3 dead outbound links with live sources
   - Add internal links to cloudhosting.example/vps-vs-cloud and cloudhosting.example/hosting-speed-test

### Republishing Strategy

**Recommendation**: Add a "Last Updated" date, keeping the original published date. The scope
assessed above is ~40% new — inside the 20-50% band the date-strategy options put on this option,
below the 50%+ that would justify replacing the published date. Update `dateModified` in Article
schema, resubmit the URL in Search Console, and share on social as "Updated for 2026".

### Expected Outcomes

| Metric | Current (source) | 30-Day | 90-Day |
|--------|------------------|--------|--------|
| Avg Position | 14.8 (latest month, owner's Search Console export) | not projected; to be measured after republishing | as at 30 days |
| Organic Traffic | 1,400/mo (latest month, owner's GA4 export) | not projected; to be measured after republishing | as at 30 days |
| Featured Snippets | not measured — no SERP check was run in this session | not projected; measure alongside the exports | as at 30 days |

This skill carries no model that converts a refresh into a position or a traffic figure, so nothing
above is projected. What is committed to is the measurement: re-pull the same two exports at T+30
and T+90 and compare them against the "Current" column.
```

---

## Content Refresh Checklist

```markdown
### Pre-Refresh
- [ ] Analyze current performance metrics
- [ ] Identify outdated information
- [ ] Research competitor updates
- [ ] Note missing topics

### Content Updates
- [ ] Update year references
- [ ] Refresh statistics with sources
- [ ] Add new examples and case studies
- [ ] Expand thin sections
- [ ] Add new relevant sections
- [ ] Create FAQ section

### SEO Updates
- [ ] Update title tag
- [ ] Refresh meta description
- [ ] Optimize headers
- [ ] Update internal links
- [ ] Add new images with alt text

### GEO Updates
- [ ] Add clear definition
- [ ] Include quotable statements
- [ ] Add Q&A formatted content
- [ ] Update source citations

### Technical
- [ ] Update schema dateModified
- [ ] Clear page cache
- [ ] Update sitemap
- [ ] Test page speed
```
