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
quick estimate from reading the page, not a tool measurement, and not the dimension scores a full
audit produces. Priority follows the score (🔴 <50 · 🟡 50-74 · 🟢 ≥75).

| Dimension | Quick Score (points ÷ items checked) | Key Weakness | Refresh Priority |
|-----------|-----------|--------------|-----------------|
| C — Contextual Clarity | 70/100 — 35 pts over 5 | Title still promises 2023; no FAQ coverage | 🟡 |
| O — Organization | 80/100 — 40 pts over 5 | Good comparison tables, no summary box | 🟢 |
| R — Referenceability | 10/100 — 5 pts over 5 | Pricing dated Q1 2023; 3 cited links do not resolve | 🔴 |
| E — Exclusivity | 30/100 — 15 pts over 5 | No original benchmarks or test data | 🔴 |
| Exp — Experience | 10/100 — 5 pts over 5 | No first-person testing narrative | 🔴 |
| Ept — Expertise | 60/100 — 30 pts over 5 | Author bio present but lacks credentials | 🟡 |
| A — Authority | 60/100 — 30 pts over 5 | Thin backlink profile (12 referring domains — partner figure, 8 Aug); no media mentions | 🟡 |
| T — Trust | 30/100 — 15 pts over 5 | Affiliate links present, no disclosure | 🔴 |

**Publish-blocker — undisclosed affiliate links**: the page carries affiliate links and no
disclosure statement. Under the trust rules this audit scores against, that is a blocking defect
rather than a nice-to-have, so the disclosure ships with the refresh and not after it.

**Weakest Dimensions** (focus refresh here):
1. **Experience — 10/100** — Add hands-on testing results ("We migrated a test site to each provider")
2. **Referenceability — 10/100** — Re-source every price and uptime figure, fix the 3 dead citations
```

The item IDs behind those eight scores are a coordinate into the 80-item benchmark, so they stay off
the client's table (anti-slop family 8) and travel in a fence of their own, labelled inside it:

```markdown
<!-- OPERATOR BLOCK — for whoever ran this refresh, not part of the client report above. The ID
     column is a coordinate into the 80-item benchmark and is what a handoff carries. Nothing in
     this fence goes to the client as written. -->
### CORE-EEAT quick scan — operator triage

| Dimension | Score | Items graded (Pass 10 / Partial 5 / Fail 0 · N/A held out) |
|---|---|---|
| C — Contextual Clarity | 70/100 — 35 pts over 5 | C02, C03, C05 Pass; C01 Partial; C09 Fail |
| O — Organization | 80/100 — 40 pts over 5 | O01, O03, O04, O06 Pass; O02 Fail |
| R — Referenceability | 10/100 — 5 pts over 5 | R01 Partial; R02, R03, R06, R10 Fail |
| E — Exclusivity | 30/100 — 15 pts over 5 | E06, E08, E09 Partial; E01, E05 Fail |
| Exp — Experience | 10/100 — 5 pts over 5 | Exp10 Partial; Exp01, Exp04, Exp05, Exp08 Fail |
| Ept — Expertise | 60/100 — 30 pts over 5 | Ept03, Ept04 Pass; Ept01, Ept08 Partial; Ept02 Fail |
| A — Authority | 60/100 — 30 pts over 5 | A05, A08 Pass; A01, A06 Partial; A02 Fail |
| T — Trust | 30/100 — 15 pts over 5 | T01 Pass; T02 Partial; T04, T05, T06 Fail |

**Veto flagged — `CORE-EEAT-T04`**: affiliate links present with no disclosure, so a material
connection exists and the conditional veto applies. The quick pass records it; the full 80-item
audit rules on it and applies the score cap. `CORE-EEAT-R10` is a Fail here on unresolving cited
links — that is not the R10 veto trigger, which is material self-contradiction.
```

**Eight dimensions scored over 5 items each is triage, not a dimension score.** It is this skill's
estimate over the items it checked, so it never travels to another run as a `CORE-EEAT C:70 O:80 …`
string; what travels is the failing item IDs and the count of items checked
([inter-skill-handoff.md §4.3](../../../references/inter-skill-handoff.md)). The client's version of
these findings is the plain-language weakness column above.

```markdown
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

Derived from 4 of the 5 signals — four products printed, four weights in the divisor: traffic −56%
scores 75 at weight 30, average position 4.2 → 14.8, now off page 1 (the state rung, which overrides
the 10.6-position delta) scores 100 at weight 25, CTR −62% relative scores 100 at weight 15, and
freshness 3.5 years with facts since changed scores 100 at weight 15. **Competitive displacement is
unscored**: no dated SERP check was run or supplied, and the owner's 8 Aug notes record what those
two guides *cover*, not what outranks this page, so they cannot score that row. The four remaining
weights were therefore renormalised over their own 85% sum (displayed as 35.3%, 29.4%, 17.6% and
17.6% — no arithmetic runs on those displayed figures; the products are summed and divided once, per
content-decay-signals.md): (2,250 + 2,500 + 1,500 + 1,500) / 85 = 7,750/85 = 91.17… → **91.2**/100,
rounded once at the end, and the band is read off 91.

**Both gates on the position state rung are met here** — a drop is on file, *and* the earlier
position (4.2) was itself on page 1. Without the second gate a keyword going 25 → 26 would score
the same 100 as this one, which is why the rung carries two conditions and not one.

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
   - Add disclosure statement below introduction: "This post contains affiliate links. See our editorial policy." — this clears the publish-blocker flagged above and ships with the refresh, not after it
   - Add FAQ with 4 questions the article's own queries raise (e.g., "What is the cheapest cloud hosting?", "Is cloud hosting faster than shared hosting?"), 40-60 words each
   - FAQ *content* ships. FAQPage markup does **not**: this page is a commercial comparison, it is
     not also an FAQ resource, and a page carries one primary content type — so adding a second
     would be stacking. Where a page genuinely is both things, each complete and independently
     justified, the markup is kept because it is valid schema.org, costs nothing to keep, and
     Google says there is no need to proactively remove it (a permission to leave it, not advice to
     keep it). An ordinary site gets no FAQ rich result: since 2023-08-08 Google shows those only
     for well-known, authoritative government and health websites (Google Search Central blog,
     "Changes to HowTo and FAQ rich results", 2023-08-08 —
     https://developers.google.com/search/blog/2023/08/howto-faq-changes), so no SERP feature is
     promised; and no primary source establishes an AI-citation benefit either way, so none is
     claimed

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
