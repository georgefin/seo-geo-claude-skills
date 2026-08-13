# Content Decay Signals

Comprehensive decay detection system with automated monitoring setup, severity scoring, refresh playbooks by content type, and ROI estimation for content refresh investments.

## Decay Signal Detection System

### Primary Signals (High Reliability)

These signals directly indicate content performance decline and should trigger immediate investigation.

#### 1. Organic Traffic Decline

| Severity | Threshold | Detection Window | Action |
|----------|-----------|-----------------|--------|
| Watch | 10-20% decline | Month-over-month | Add to monitoring list |
| Warning | 20-40% decline | Month-over-month | Schedule refresh within 2 weeks |
| Critical | 40-60% decline | Month-over-month | Refresh this week |
| Emergency | >60% decline | Month-over-month | Investigate immediately (may be technical issue) |

**Detection method**: Compare current month's organic sessions to same month previous year (to account for seasonality) and to previous month (for trend detection).

**False positive check**: Before attributing traffic decline to content decay, rule out:
- Seasonal variations (compare year-over-year, not just month-over-month)
- Algorithm updates (check if decline coincides with known Google updates)
- Technical issues (crawl errors, indexation problems, site speed regression)
- Tracking code changes (analytics misconfiguration)

#### 2. Ranking Position Drops

| Severity | Threshold | Detection Window | Action |
|----------|-----------|-----------------|--------|
| Watch | 1-3 positions lost | 2-week average | Monitor |
| Warning | 3-5 positions lost | 2-week average | Investigate cause |
| Critical | 5-10 positions lost | 2-week average | Schedule immediate refresh |
| Emergency | Dropped off page 1 to page 3+ | Any timeframe | Priority refresh or rewrite |

**Detection method**: Track primary keyword positions weekly. Use 2-week rolling averages to smooth daily fluctuations.

#### 3. Click-Through Rate Decline

| Severity | Threshold | Context | Action |
|----------|-----------|---------|--------|
| Watch | CTR below expected for position | Position stable, CTR dropping | Review title and meta description |
| Warning | CTR dropped 20%+ vs. baseline | With stable impressions | Rewrite title tag and meta description |
| Critical | CTR dropped 40%+ vs. baseline | May indicate stale SERP appearance | Full refresh of title, description, and structured data |

**Expected CTR by position — an illustrative shape, not a benchmark**

`[VERIFY]` **No source is on file for this curve.** The ranges below carry no publisher, year,
methodology or sample size; a repository-wide grep on 2026-08-10 found no citation for them here
or anywhere else in the library. They are the same class of unsourced position-CTR table already
registered as **W14** (`docs/loop/WATCH-ITEMS.md`, opened 2026-08-10 against
`build/meta-tags-optimizer/references/meta-tag-formulas.md`) — plausible, widely circulated, and
exactly the kind of figure this library has found wrong in transit. Use them only as an internal
sense of the curve's *shape*: **never quote a number from this table to a client, and never make
one the baseline a client's CTR is judged against.** The honest baseline is the page's own
position-versus-CTR history from its Search Console export, which carries that site's queries and
SERP features. With no export and nothing supplied, say so and skip the comparison rather than
borrowing a number from here (see "When a signal has no input" below). **Resolves when**: a named
study with its year and sample replaces these ranges, or measured client data does.

| Position | Illustrative CTR Range (unsourced) | Shape suggests investigating below |
|----------|------------------------------------|------------------------------------|
| 1 | 25-35% | <20% |
| 2 | 12-18% | <10% |
| 3 | 8-12% | <6% |
| 4-5 | 5-8% | <4% |
| 6-10 | 2-5% | <2% |

---

### Secondary Signals (Moderate Reliability)

These signals suggest potential decay but may have other causes. Use them to corroborate primary signals.

#### 4. Engagement Metric Decline

| Metric | Decay Indicator | Possible Cause |
|--------|----------------|---------------|
| Bounce rate increase >15% | Content no longer satisfies intent | Outdated information, better competitor content |
| Time on page decrease >20% | Users leaving faster | Content not comprehensive enough |
| Scroll depth decrease | Users not reading full content | Front-loading outdated info, losing interest |
| Pages per session decrease | Users not exploring further | Poor internal linking, irrelevant content |

#### 5. Content Freshness Indicators

| Indicator | Decay Risk | Detection |
|-----------|-----------|-----------|
| Published >12 months ago, never updated | High | CMS date audit |
| Contains year references 2+ years old | High | Text search for year patterns |
| Statistics from 3+ years ago | Medium | Manual review or text search for "20XX" |
| Broken external links (>10% of total) | Medium | Monthly crawl report |
| Screenshots of outdated UI | Medium | Manual visual review |
| References to discontinued products/tools | High | Manual review |

#### 6. Competitive Displacement Signals

| Signal | Detection Method | Severity |
|--------|-----------------|----------|
| New competitor content ranking above you | SERP monitoring | High |
| Competitor content is longer and more comprehensive | Manual comparison | Medium |
| Competitor has more recent publication date displayed in SERP | SERP monitoring | Medium |
| Featured snippet lost to competitor | SERP monitoring | High |
| AI overview now answers query without click | SERP monitoring | High |

"SERP monitoring" here means a tracker's history **or** one SERP check somebody ran and dated — an
incognito check on a stated date, in the target market and language, is a legitimate detection
method at Tier 1 and the only one available with no connector. What it cannot produce is *change*:
one check shows today's SERP, not who ranked there before. Every row above is therefore reported as
an observation with its date and observer, and "new" is claimed only against an earlier record
somebody actually holds. No check and no supplied notes means this whole signal group is unassessed
and the report says so — it does not become an inference about what competitors have published.

**Which rows supplied notes can carry**: the one whose detection method is a manual comparison —
competitor content longer or more comprehensive than yours. The four SERP-monitoring rows need the
check itself, because a note on what a page *covers* says nothing about where it *ranks*. Same
division governs the weighted Competitive displacement signal below.

---

### Tertiary Signals (Low Reliability, Supporting Evidence)

These signals alone do not indicate decay but strengthen the case when combined with primary or secondary signals.

| Signal | What It Suggests |
|--------|-----------------|
| Fewer social shares over time | Content less share-worthy (may be stale) |
| Decrease in backlink acquisition | Content no longer being cited as a resource |
| Fewer comments or engagement | Community interest waning |
| Content not appearing in AI responses | Not structured for GEO or information is outdated |

---

## Automated Monitoring Setup

### Monitoring Dashboard Configuration

Set up these automated checks to catch decay early.

#### Weekly Checks

| Check | Data Source | Alert Threshold |
|-------|-----------|----------------|
| Keyword position changes | Rank tracker | Any target keyword drops >3 positions |
| Crawl errors on key pages | Search Console | Any new crawl error on monitored pages |
| Index coverage changes | Search Console | Any page drops from index |

#### Monthly Checks

| Check | Data Source | Alert Threshold |
|-------|-----------|----------------|
| Traffic comparison (MoM) | Analytics | >15% decline on any monitored page |
| CTR comparison | Search Console | >20% CTR decline for any target keyword |
| Broken link scan | Crawler | Any new broken links on monitored pages |
| Competitor SERP changes | SERP tracker | New competitor enters top 5 |

#### Quarterly Checks

| Check | Data Source | Process |
|-------|-----------|---------|
| Content freshness audit | CMS + manual | Review all content older than 6 months |
| Statistics accuracy check | Manual | Verify top 20 pages have current data |
| Engagement trend review | Analytics | Compare engagement metrics across quarters |
| Full competitive content gap | SEO tool | Identify new competitor content opportunities |

### Alert Priority Matrix

When multiple signals fire simultaneously, use this matrix to determine response urgency.

| Primary Signal + Secondary Signal | Priority | Response |
|----------------------------------|----------|----------|
| Traffic decline + Position drop | P1 (Critical) | Refresh within 48 hours |
| Traffic decline + CTR decline | P1 (Critical) | Rewrite title/description immediately, schedule content refresh |
| Position drop + Competitor displacement | P2 (High) | Refresh within 1 week |
| Traffic decline + Engagement decline | P2 (High) | Refresh within 1 week |
| CTR decline only | P3 (Medium) | Rewrite title and meta description this week |
| Freshness indicators only | P3 (Medium) | Schedule refresh within 2 weeks |
| Engagement decline only | P4 (Low) | Investigate and schedule if confirmed |

---

## Decay Severity Scoring

### Composite Decay Score

Calculate a 0-100 decay severity score by summing weighted signal scores. Every figure in it is
derived from an input you hold, and the derivation ships beside the score in the deliverable: a
composite score printed without its signal scores, the observation behind each one and the weights
used is not reportable (library derivation rule, ledger F9-r3).

**Step 1 — score each signal on the 0/25/50/75/100 ladder, from the input named in the last column.**

| Signal (weight) | 0 | 25 | 50 | 75 | 100 | Input it needs |
|---|---|---|---|---|---|---|
| Traffic decline (30%) | no decline | 10-20% | 20-40% | 40-60% | >60% | two comparable traffic periods (same month year-over-year preferred) from an analytics export or the user's own figures |
| Position drops (25%) | stable | 1-3 lost | 3-5 lost | 5-10 lost | now off page 1 — a state, not a delta; it overrides | a before/after position for the same keyword, from a rank export, a Search Console export, or the user's records |
| CTR decline (15%) | stable | under 20% | 20-30% | 30-40% | over 40% | CTR for the same queries across two comparable windows — Search Console, or the user's own figures |
| Content freshness (15%) | updated this quarter | updated 3-12 months ago | 12-24 months | over 24 months | over 24 months **and** the page states facts that have since changed | the CMS publish/update date plus a read of the page |
| Competitive displacement (15%) | your page is the top organic result in the check | 1-2 results above it, none carrying material yours lacks | 1-2 above it carrying material yours lacks, or showing a more recent date | 3 or more above it, at least one carrying material yours lacks | your page is off the first screen of organic results for its own target query | **one dated SERP check for the target query** (incognito, market and language stated) plus a read of the pages returned above yours. Competitor *coverage* notes are not a substitute — see "Coverage notes cannot score displacement" below |

**Boundaries read upward**, so one input never yields two scores: a 20% traffic decline scores 50, a
3-position loss scores 50, a page 24 months since its last update scores 75.

**Position drops mixes a delta with a state, and the state wins.** Rungs 25 / 50 / 75 count
positions lost between two records of the same keyword; rung 100 is a state — the page's current
average position is off page 1. Where both apply the row scores **100**: a page now sitting at
average position 12 after losing 8 scores 100, not the 75 its delta alone reads. Leaving page 1 is a
step change in clicks that a count of positions does not capture, and "boundaries read upward"
settles band edges within one measurement, not a collision between two different ones. A page still
on page 1 is scored on its delta alone. The state rung reads only where a drop is on file at all:
with no earlier position for the keyword, the row is **N/A**, because a page that has always sat on
page 2 has not dropped there.

The displacement row scores **what one dated check shows today**, not a change over time. Nobody can
reconstruct who ranked above a page six months ago without a stored SERP record, so the criterion
never asks for one: it asks who is above the page in a check somebody actually ran, and whether
reading those pages shows material this one lacks. Every competitor fact that reaches the report —
a rank, a publication date, a section they cover — travels with its observer and its date ("SERP
checked in incognito, 10 Aug", "from your note of 7 Aug"), never as bare indicative fact.

**Coverage notes cannot score displacement.** Every rung above is a position relative to your page —
who is above it, and how many. Dated notes on what two competitor guides cover establish that the
material exists, not that those pages outrank yours, so no rung is satisfiable from them and this
row is **N/A** in a session holding coverage notes alone: mark it N/A, name the missing input, and
renormalise, exactly as the worked example in [refresh-example.md](./refresh-example.md) does. That
is the commonest Tier 1 case and it is not a failure of the input — the unlock is one incognito SERP
check for the target query, dated, which needs no connector. The notes are not wasted either: they
score **Competitive opportunity** in Refresh Priority Scoring and fill the missing-topics table in
[SKILL.md](../SKILL.md) Step 4, both of which measure coverage rather than rank.

### When a signal has no input

A signal you cannot observe is **N/A**, never a number. N/A is not zero: zero means "checked, no
decay", so writing zero for an unchecked signal understates the score exactly as inventing a figure
inflates it.

1. **Mark the row N/A and name the missing input in the report** — "no SERP check was run for this
   query, so competitive displacement is unscored; the coverage notes supplied establish what those
   pages cover, not what outranks this one".
2. **Renormalise the remaining weights over their own sum** and state the renormalisation beside the
   score, so the reader can recompute it.
3. **Fewer than three scored signals → no composite score is issued at all.** Report the signals you
   could score, each with its input, and say plainly that the composite needs at least three.
4. **Never fill an N/A row from an assumption, a typical case, or "the industry".** No tool and no
   data means the figure stays out of the deliverable — the criterion is not softened into a guess
   (root `CLAUDE.md`, Tool Connector Pattern, resolution branch 3).

**Worked derivation** (illustrative figures): the owner supplied a GA4 export, a rank-tracker export
and CMS dates — no Search Console access, and no SERP check was run.

```
Traffic decline    2,050 → 1,230 sessions/mo, comparable 30-day windows = −40%   → 75  (weight 30%)
Position drops     rank export: keyword 6 → 10, 4 lost, still on page 1          → 50  (weight 25%)
Content freshness  last updated 26 months ago; stated facts still accurate       → 75  (weight 15%)
CTR decline        N/A — no Search Console export supplied
Competitive displ. N/A — no dated SERP check was run (coverage notes cannot score this row)

Scored weight = 30 + 25 + 15 = 70%  → renormalised weights 30/70, 25/70, 15/70 (42.9%, 35.7%, 21.4%)
Composite = 75(30/70) + 50(25/70) + 75(15/70) = 32.1 + 17.9 + 16.1 = 66.1 / 100  → band read at 66
```

**The multiplier in a printed derivation is the exact fraction, never the rounded percentage.** The
percentages are how the renormalised weights are *displayed*; the arithmetic runs on 30/70, 25/70
and 15/70. Multiply by the rounded weight instead and the line stops reproducing — 75 × 0.429 =
32.175, which prints as 32.2, not the 32.1 above. A derivation is printed so the reader can
recompute it from the operands beside it, so the operands shown are the ones the arithmetic used —
with each addend and the total displayed to one decimal, halves up.

Printed in the deliverable as: *"Composite decay score 66.1/100 — significant decay. Derived from 3
of 5 signals: traffic −40% (75 × 30/70 = 32.1), positions −4 (50 × 25/70 = 17.9), freshness 26
months (75 × 15/70 = 16.1). CTR decline and competitive displacement are unscored — no Search
Console export and no dated SERP check were available — and the three remaining weights were
renormalised over their own 70% sum, i.e. 42.9%, 35.7% and 21.4%."*

### Score Interpretation

**Rounding convention: the composite is printed to one decimal, and the band is read off that figure
rounded to the nearest whole number, halves up.** The rounding step is what makes the bands
contiguous. It is a reading device only — the score itself stays as computed, and anything derived
from it downstream (the decay-severity factor in Refresh Priority Scoring) consumes the printed
score, not the band-read integer.

With all five signals scored the step changes nothing: every weight is a multiple of 5 and every
ladder value a multiple of 25, so a fully scored composite is always a multiple of 1.25, and no
multiple of 1.25 falls between two bands. **The renormalisation rule above breaks that guarantee** —
a scored-weight sum of 45, 55, 60, 70, 75 or 85 rather than 100 puts values on a finer grid, most of
which do not terminate as decimals, and **seven attainable values fall strictly between two bands**:
each of 20 < S < 21, 40 < S < 41, 60 < S < 61 and 80 < S < 81 contains at least one. Traffic 50 and
positions 50 with freshness 100, the other two signals unscored, gives 4250/70 = 60.714…, which sits
in no band at all unrounded and reads as **61 — significant decay** once rounded. Halves up sends a
score to whichever band it is nearer, in both directions: a renormalised 60.294… (the four-signal,
85% path) reads as 60, active decay. Print the unrounded figure beside the band so the reader can
rerun the rounding.

| Composite Score (rounded) | Decay Stage | Urgency |
|----------------|-------------|---------|
| 0-20 | Healthy | Continue monitoring |
| 21-40 | Early decay | Add to refresh queue (next month) |
| 41-60 | Active decay | Schedule refresh (this week) |
| 61-80 | Significant decay | Act now |
| 81-100 | Terminal decay | Highest urgency — act this week |

**The band sets urgency, never disposition.** How much a page has decayed does not decide whether it
is refreshed, rewritten, redirected or retired: that comes from the Refresh vs. Rewrite Decision
Framework and the Content Retirement Decision checklist below, both of which weigh backlinks,
residual traffic and search intent — things this score does not measure. A page with earned
backlinks that was once ranking is a REFRESH at any composite score, and a top score never orders a
retirement on its own.

Read the band against the renormalised score and say how many signals it rests on: a stage read off
three signals is a narrower claim than one read off five, and the reader is entitled to know which
they were given. A score landing on a band boundary is reported with both the figure and the band it
was read into — the arithmetic decides, not the preference.

---

## Refresh Playbooks by Content Type

Every time estimate below is a **house planning default**, not a measured figure — no timing study
backs them. Each total is the sum of its own rows, so a changed row changes the total; a total that
does not reconcile with the rows above it is a defect, not a rounding.

### Blog Post / Article Refresh Playbook

| Step | Action | Time Estimate |
|------|--------|--------------|
| 1 | Update title with current year or hook | 10 min |
| 2 | Rewrite introduction with fresh angle | 20 min |
| 3 | Update all statistics with current sources | 30-60 min |
| 4 | Add 1-2 new sections covering gaps | 60-90 min |
| 5 | Update screenshots and images | 30 min |
| 6 | Add or update FAQ section | 20 min |
| 7 | Refresh internal links | 15 min |
| 8 | Update meta description | 5 min |
| 9 | Add/update schema markup | 10 min |
| 10 | Update dateModified and republish | 5 min |
| **Total** | | **205-265 min (3.5-4.5 hours)** |

### Product/Service Page Refresh Playbook

| Step | Action | Time Estimate |
|------|--------|--------------|
| 1 | Update pricing, features, specifications | 30 min |
| 2 | Add new customer testimonials/reviews | 20 min |
| 3 | Update product images | 30 min |
| 4 | Refresh comparison tables | 20 min |
| 5 | Update internal links to related products | 15 min |
| 6 | Verify and update schema markup | 10 min |
| **Total** | | **125 min (about 2 hours)** |

### Statistics/Data Roundup Refresh Playbook

| Step | Action | Time Estimate |
|------|--------|--------------|
| 1 | Verify every statistic is still current | 60-90 min |
| 2 | Replace outdated stats with current data | 60 min |
| 3 | Add new statistics from recent studies | 30 min |
| 4 | Update source links and citations | 30 min |
| 5 | Update year references throughout | 15 min |
| 6 | Add new visualization if data changed significantly | 30 min |
| 7 | Update title, meta description with year | 10 min |
| **Total** | | **235-265 min (4-4.5 hours)** |

### How-To Guide Refresh Playbook

| Step | Action | Time Estimate |
|------|--------|--------------|
| 1 | Verify all steps are still accurate | 30 min |
| 2 | Update screenshots for UI changes | 60 min |
| 3 | Add new methods or alternative approaches | 30 min |
| 4 | Update tool recommendations | 15 min |
| 5 | Add troubleshooting section if missing | 20 min |
| 6 | Update FAQ with new common questions | 15 min |
| 7 | Test all links and embedded resources | 15 min |
| **Total** | | **185 min (about 3 hours)** |

---

## ROI Estimation for Content Refresh

### Cost-Benefit Framework

| Factor | Measurement |
|--------|------------|
| **Cost of refresh** | Writer hours x hourly rate + tool costs |
| **Current monthly traffic value** | Organic sessions x conversion rate x avg order value |
| **Projected traffic recovery** | Based on decay stage and content potential |
| **Time to recover** | Typically 4-8 weeks for rankings to respond |

### Traffic Recovery Benchmarks

`[VERIFY]` **"Industry data" names no publisher, year or sample, and none is on file.** These bands
were carried here as an attribution without a source; a repository-wide grep on 2026-08-10 found no
study behind them. They are **house planning defaults for internal sequencing only** — the same
unsourced-figure class as W14. A recovery percentage from this table never reaches a client
deliverable as an expectation, a target or an ROI input presented as fact; when a client asks what
recovery to expect, the answer is that this skill carries no model that converts a refresh into a
traffic figure, and the measurement comes after republishing. **Resolves when**: a named study with
its year and sample replaces the bands, or the site's own before/after refresh history does.

| Decay Stage at Refresh | House planning band (unsourced) | Timeline (unsourced) |
|------------------------|---------------------------------|----------------------|
| Early decay | 90-110% of peak | 2-4 weeks |
| Active decay | 70-90% of peak | 4-8 weeks |
| Significant decay | 40-70% of peak | 6-12 weeks |
| Terminal decay | 10-40% of peak (rewrite may be better) | 8-16 weeks |

### ROI Calculation Template

```
Refresh Cost:
  Writer time: [X hours] x [$Y/hour] = $[Z]
  Tool costs: $[A] (one-time crawl, research tools)
  Total cost: $[Z + A]

Monthly Traffic Value (before decay):
  Peak monthly organic sessions: [N]
  Conversion rate: [X]%
  Average conversion value: $[Y]
  Peak monthly value: [N] x [X]% x $[Y] = $[V]

Expected Recovery:
  Projected recovery: [%] of peak = $[V x %] per month   <- states its basis on the next line
  Basis for that [%]: [this page's own recovery after its last refresh | the client's stated
                       assumption | the unsourced house band above, named as unsourced]
  Current monthly value: $[current]
  Monthly value increase: $[V x % - current]

ROI:
  Payback period: $[total cost] / $[monthly value increase] = [months]
  12-month ROI: ($[monthly value increase] x 12 - $[total cost]) / $[total cost] x 100 = [X]%
```

The whole ROI block is an **input-conditional** calculation: every dollar figure in it descends from
the recovery percentage, so a recovery percentage with no stated basis makes the ROI, the payback
period and the 12-month figure unreportable. With no conversion rate and no order value supplied,
the cost half still runs and the value half does not — publish the cost, say which inputs are
missing, and leave the ROI line out rather than filling it from a typical case.

### Refresh Priority Scoring

When choosing which content to refresh first, score each candidate 1-10 per factor. Each score is
read off an input you hold, and the figure it came from is printed beside it.

| Factor | Weight | How the 1-10 score is read | Input it needs |
|--------|--------|----------------------------|----------------|
| Current traffic value | 25% | Rank the candidates in this batch on the traffic figure you hold: highest = 10, lowest = 1, the rest interpolated on the same figure | the traffic column of the inventory you were given |
| Decay severity | 20% | Composite decay score ÷ 10, rounded to the nearest whole number (66.1 → 7) | a composite score that was actually issued (§Decay Severity Scoring) |
| Competitive opportunity | 20% | Read against the competitor pages actually compared, named with the date they were read: 10 = they are thinner or older than yours · 5 = comparable · 1 = materially stronger. This factor scores **content strength, not rank** — so unlike displacement it is scoreable from coverage notes, and it claims no ranking relationship they do not carry | the dated SERP check the displacement signal needs, **or** the user's own dated competitor notes — either one supplies pages to compare |
| Refresh difficulty | 15% | 10 = under 2 hours on the matching playbook · 5 = 3-4 hours · 1 = the decision framework says rewrite | the content type plus the playbook estimate above |
| Strategic importance | 10% | 10 = the owner names it a priority page for a current goal · 5 = ordinary · 1 = no stated goal | the owner saying so; not inferable from traffic |
| Backlink equity | 10% | Rank the candidates on referring domains: highest = 10, lowest = 1 | a supplied backlink figure |

**Priority formula**: `priority = Σ (factor score × factor weight)`, on the same 1-10 scale. Print
every factor score with the figure behind it, then the total. A factor with no input is **dropped,
not guessed and not scored 5 as a middle**: renormalise the remaining weights over their own sum,
name the dropped factor and why, exactly as the composite score does. Refresh highest-scoring
content first.

**Worked derivation** (illustrative figures): *"Priority 7.4/10 — traffic 8 (1,900 sessions/mo, the
highest in this batch) × 25%, decay severity 7 (composite 66.1) × 20%, refresh difficulty 6
(blog-post playbook, about 3.5 h) × 15%, strategic importance 9 (owner named it the lead page) ×
10%. Competitive opportunity and backlink equity are unscored — no SERP check and no backlink data
were supplied — so the four remaining weights were renormalised over their own 70% sum:
8(25/70) + 7(20/70) + 6(15/70) + 9(10/70) = 7.4."*

---

## Content Retirement Decision

Not all decaying content should be refreshed. Use this checklist to decide when to retire content instead.

### Retire When

- [ ] Content targets a keyword with zero search volume
- [ ] Topic is no longer relevant to your business
- [ ] No backlinks worth preserving
- [ ] Content never ranked well even when fresh
- [ ] Cost to refresh exceeds projected 12-month value recovery
- [ ] Content cannibalizes a better-performing page on the same topic

### Retirement Options

| Option | When to Use | Implementation |
|--------|------------|---------------|
| 301 redirect | Content has backlinks or residual traffic | Redirect to best related page |
| Consolidate | Multiple weak pages on same topic | Merge into one strong page, redirect others |
| Noindex | Page has internal utility but should not rank | Add noindex, keep page accessible |
| Delete (410) | Content has no value, no links, no traffic | Return 410 Gone status |

### Post-Retirement Monitoring

After retiring content, monitor for 4 weeks:
- Verify redirects are working (no 404 errors)
- Check that target pages are receiving redirected traffic
- Monitor rankings of consolidated/target pages
- Ensure no orphan pages were created by removing internal links

---

## Content Decay Signal Taxonomy

### Decay Indicators

| Signal | Source | Severity | Detection Method |
|--------|--------|----------|-----------------|
| Traffic decline >20% MoM | Analytics | High | Monthly traffic comparison |
| Position drop >5 positions | Rank tracker | High | Weekly rank monitoring |
| Outdated statistics/dates | Manual review | Medium | Annual content audit |
| Broken external links | Crawler | Medium | Monthly crawl reports |
| Decreased CTR | Search Console | Medium | Quarterly CTR analysis |
| AI Overview displacement (CTR down 20-60% on ≥5 queries over 2-4 weeks, impressions and rankings held) | Search Console + live SERP | High | 28-day GSC compare → [AI Overview recovery playbook](./ai-overview-recovery.md) |
| Competitor new content | SERP monitoring | Medium | Monthly SERP checks |
| User engagement drop | Analytics | Low | Quarterly engagement review |
| Index coverage issues | Search Console | High | Weekly coverage monitoring |

### Content Decay Stages

| Stage | Symptoms | Urgency | Recommended Action |
|-------|---------|---------|-------------------|
| **Early decay** | Slight traffic/position dip | Low | Monitor for 2-4 weeks |
| **Active decay** | Consistent decline across 2+ months | Medium | Schedule refresh within 2 weeks |
| **Significant decay** | 50%+ traffic loss, page 2+ | High | Immediate refresh or rewrite |
| **Terminal decay** | No organic traffic, deindexed | Critical | Rewrite, redirect, or retire |

## Refresh vs. Rewrite Decision Framework

| Factor | Refresh (Update) | Rewrite (New version) |
|--------|-----------------|---------------------|
| Content quality | Good foundation, needs updating | Fundamentally flawed or outdated approach |
| Position | Was ranking well, now dropping | Never ranked well despite optimization |
| URL age | 1+ years, has earned backlinks | Young URL with no backlink equity |
| Backlinks | Has external links pointing to it | No backlinks worth preserving |
| Scope of changes needed | <50% of content changing | >50% needs rewriting |
| Search intent | Intent hasn't changed | Search intent has evolved |

**Decision rule:** If the URL has backlinks and was ranking, REFRESH. If not, consider REWRITE at a new URL (with 301 redirect if old URL has any equity).

## Content Lifecycle Model

```
CREATE → PROMOTE → MAINTAIN → REFRESH → [REFRESH again] or RETIRE
  │         │          │          │                          │
  │      Month 1    Month 2-6   Month 6-12              When terminal
  │    Social,      Monitor     Update facts,            301 redirect
  │    outreach,    rankings,   add new sections,         to related
  │    email        fix issues  improve depth              content
```

### Lifecycle Actions by Phase

| Phase | Duration | Key Actions | Metrics to Track |
|-------|----------|------------|-----------------|
| Create | Week 1 | Publish, submit to Search Console | Indexation |
| Promote | Month 1 | Social shares, email, outreach | Referral traffic, backlinks |
| Maintain | Months 2-6 | Monitor, fix broken links, respond to comments | Rankings, traffic trend |
| Refresh | Months 6-12+ | Update data, add sections, improve structure | Traffic recovery, new keywords |
| Retire | When terminal | 301 redirect to best alternative | Redirect traffic recovery |

## Update Strategy by Content Type

| Content Type | Refresh Frequency | Key Updates | Shelf Life |
|-------------|-------------------|------------|-----------|
| Statistics roundups | Every 6 months | Replace old stats, add new sources | 6-12 months |
| Tool comparisons | Every 3-6 months | Update pricing, features, screenshots | 3-6 months |
| How-to guides | Annually | Update steps, screenshots, links | 12-18 months |
| Evergreen guides | Every 12-18 months | Add new sections, update examples | 18-24 months |
| News/trend content | Don't refresh | Archive or redirect | 1-3 months |
| Case studies | Rarely | Update results if available | 2-3 years |
| Glossary/definitions | As needed | Update when definitions evolve | 2-5 years |

