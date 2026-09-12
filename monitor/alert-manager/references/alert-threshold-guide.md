# Alert Threshold Guide

Complete reference for configuring SEO/GEO alert thresholds. Covers baseline establishment, threshold setting methodology, tuning process, alert routing configuration, notification channel setup, response playbooks for each alert type, and (Section 9) the write-up rules for counts, quotes, generics, handoff payloads and unverified explanations.

---

## 1. Baseline Establishment Process

Before setting any alert thresholds, you must establish a baseline that represents normal metric behavior for your site. Without a baseline, you will either set thresholds too tight (causing alert fatigue) or too loose (missing real problems).

### Baseline Collection Timeline

| Metric Category | Minimum Baseline Period | Ideal Baseline Period | Why |
|----------------|------------------------|----------------------|-----|
| Organic traffic | 4 weeks | 8-12 weeks | Accounts for weekly cycles and monthly patterns |
| Keyword rankings | 2-4 weeks | 4-8 weeks | Rankings fluctuate daily; need to establish normal range |
| Backlink metrics | 4 weeks | 8 weeks | Link acquisition is lumpy; need to see natural cadence |
| Technical metrics | 2 weeks | 4 weeks | Most technical metrics are relatively stable |
| Core Web Vitals | 4 weeks (28-day rolling) | 8 weeks | CrUX data is 28-day rolling average |
| AI citations | 4 weeks | 8 weeks | AI answer composition changes frequently |

### Baseline Data Collection Steps

| Step | Action | Output |
|------|--------|--------|
| 1 | Record daily metric values for the baseline period | Raw data spreadsheet |
| 2 | Calculate mean (average) for each metric | Central tendency |
| 3 | Calculate standard deviation for each metric | Normal variation range |
| 4 | Identify outliers (values > 2 standard deviations from mean) | Anomaly list |
| 5 | Remove known outliers (holidays, outages, one-time events) | Clean baseline |
| 6 | Recalculate mean and standard deviation on clean data | Final baseline values |
| 7 | Document seasonal patterns if baseline covers enough time | Seasonal adjustment notes |

### Baseline Metrics to Record

| Metric | Daily | Weekly | Monthly |
|--------|-------|--------|---------|
| Organic sessions | Record | Calculate WoW % change | Calculate MoM % change |
| Keyword positions (top 20) | Record | Calculate average movement | Calculate net position change |
| Keywords in top 10 | Record | Calculate weekly count | Calculate monthly trend |
| Crawl errors | Record | Calculate weekly new errors | Calculate monthly trend |
| New backlinks | N/A | Record weekly count | Calculate monthly velocity |
| Lost backlinks | N/A | Record weekly count | Calculate monthly velocity |
| Core Web Vitals | N/A | Record from CrUX | Calculate monthly trend |
| AI citations | N/A | Record weekly count | Calculate monthly trend |
| Pages indexed | N/A | Record weekly count | Calculate monthly change |
| Server response time | Record | Calculate weekly average | Calculate monthly average |

### Three method choices, fixed here so two runs on the same data agree

"Calculate standard deviation" (step 3 above) does not by itself determine a number. Three
choices sit under it, each of which moves every threshold that follows. Each has a default below;
use it unless you have a reason, and state which you used either way.

**1. Sample standard deviation (n − 1) is the default.** A baseline period is a *sample* of an
ongoing process, not a closed population — you are estimating how much the metric varies in
general from the days you happened to record. Bessel's correction (dividing by n − 1) is the
estimator for that, it is what a spreadsheet gives you by default (`STDEV`, `STDEV.S`), and it is
the slightly larger of the two, so it errs towards wider bands and fewer false positives. The two
forms differ by the factor √(n/(n−1)) — about **12% at n = 5, 2% at n = 28, under 1% at n = 60** —
so the choice moves every bound most on exactly the short baselines a new configuration has. Use
the population form (`STDEVP`, `STDEV.P`) only where the recorded values genuinely are the whole
population of interest, and say so in the line.

**2. Split weekday and weekend baselines before pooling them.** For any daily metric with a weekly
cycle (sessions, clicks, conversions), compute the mean and standard deviation for weekdays and
for weekend days separately, and grade each day against its own baseline. Pooled, the standard
deviation carries the gap between the two groups as if it were day-to-day noise — total variance
is within-group plus between-group — so on a site with a real weekend dip the pooled figure runs
several times the true variation. Every band widens with it: a genuinely bad Tuesday sits inside
the 1-sigma "everyday range" while an ordinary Saturday grades as an anomaly. The deviation then
measures the calendar rather than the variance, which makes every threshold built on it wrong.
**The test for pooling**, using this guide's own everyday range: pool only if the weekend mean
falls inside the weekday baseline's `|z| < 1` band. If it falls outside, split — the cycle is
bigger than the noise. The same test governs any other structural split you can see (a country, a
device class, a page group with its own cadence). Name the population beside every mean and every
standard deviation: "weekday baseline, Mon-Fri, 29 clean days".

**3. Comparison stays like-for-like.** With split baselines a day-over-day comparison compares
Monday to Monday, not Monday to Sunday (Section 3's traffic note). The Section 5 weekend
adjustment is an *alternative* to splitting, not a second correction stacked on top of it — apply
one of the two and name which.

---

## 2. Threshold Setting Methodology

### The Standard Deviation Method

For most metrics, set thresholds based on standard deviations from your baseline mean. These four
names are the **threshold band** — a statement about the metric, not about who gets woken up. The
people-side label is the response priority (P0-P3, Section 4), and the two are not the same axis:
see "Two axes, two vocabularies" below.

| Threshold band | Trigger | Meaning |
|----------------|---------|---------|
| **Info** | Deviation reaches 1 standard deviation | Normal fluctuation range; log but do not alert |
| **Warning** | Deviation reaches 1.5 standard deviations | Unusual but not necessarily problematic |
| **Critical** | Deviation reaches 2 standard deviations | Statistically significant anomaly; investigate |
| **Emergency** | Deviation reaches 3 standard deviations | Extreme anomaly; immediate action required |

**Reading a value into a band.** Write the deviation as `z = (value - mean) / standard deviation`
and take its size, ignoring direction. A value carries the band of the highest trigger it reaches,
so the bands are contiguous and nothing falls between two of them: `|z| < 1` inside the everyday
range · `1 <= |z| < 1.5` Info · `1.5 <= |z| < 2` Warning · `2 <= |z| < 3` Critical · `|z| >= 3`
Emergency. **A value exactly on a trigger takes the higher band** — z = 2.00 is Critical, not
Warning. Print the z beside the figure so the band can be checked: `8,600 sessions (z = -1.75) —
Warning`.

**Example calculation** — mean and standard deviation from 28 clean days (Section 1, steps 1-6):

```
Metric: Daily organic sessions
Baseline mean:      10,000 sessions/day
Standard deviation:    800 sessions/day   → 1 sd = 800, 1.5 sd = 1,200, 2 sd = 1,600, 3 sd = 2,400

Everyday range   9,200 - 10,800   |z| < 1     10,000 -/+ 800     no alert, no log entry
Info             8,800 - 9,200 or 10,800 - 11,200   log only, do not alert
Warning          8,400 - 8,800 or 11,200 - 11,600
Critical         7,600 - 8,400 or 11,600 - 12,400
Emergency        <= 7,600 or >= 12,400
```

Each bound is the mean plus or minus its own multiple of 800 — 8,800 is 10,000 - 1.5 x 800, 11,600
is 10,000 + 2 x 800 — and where two rows share a bound the higher band takes it. An earlier
revision of this file printed the Info range as 8,200 - 11,800, which is 2.25 standard deviations
and reachable from no line in the table above it.

### The Percentage Method

For metrics where standard deviation is not practical, use percentage-based thresholds.

| Metric | Warning Threshold | Critical Threshold | Comparison Period |
|--------|------------------|-------------------|-------------------|
| Organic traffic | -15% vs. comparison | -30% vs. comparison | Week over week |
| Keyword positions (Tier 1, individual keyword) | Drop >= 3 | Drop >= 5 | Week over week |
| Pages indexed (index coverage) | -5% change | -15% change | Week over week |
| Referring domains | >5% of total lost | >15% of total lost | Week over week |
| Crawl error rate (relative to baseline — not a count) | >2x baseline rate | >5x baseline rate | Day over day |
| Conversion rate | -20% drop | -40% drop | Week over week |

### The Absolute Value Method

For binary or count-based metrics, use absolute thresholds.

| Metric | Warning Threshold | Critical Threshold |
|--------|------------------|-------------------|
| New crawl errors, **excluding 4xx and 5xx** (soft 404s, redirect chains, DNS/connectivity failures, robots-blocked URLs) | >10 new errors/day | >50 new errors/day |
| Server 5xx errors | >1/day | >5/day |
| Security issues | N/A | Any detection |
| Manual penalties | N/A | Any notification |
| SSL certificate expiry | <30 days to expiry | <7 days to expiry |
| Robots.txt changes | Any unexpected change | Key pages blocked |

### A fixed threshold needs no baseline — state it, even with nothing connected

Every value in the table above is fixed by definition rather than computed from the client's
history: a count of 5xx responses in a day, days to certificate expiry, "any detection". So are the
percentage steps above it (index coverage -5% / -15%), the ranking-tier drops, the brand-position
and top-3 count rows, and the Core Web Vitals boundaries in Section 3. A run with no tool connected
and no export in hand can write every one of them down. What it cannot do is state *this site's*
mean, standard deviation, normal range or expected position. **Evaluating a percentage step needs
last week's number; stating the threshold does not** — that is the whole distinction. Keep the
three kinds apart in the deliverable:

| Kind of number | Needs this client's history to *state*? | With no data in hand |
|----------------|-----------------------------------------|----------------------|
| **Fixed threshold** — 5xx/day, 4xx/day, SSL days, index-coverage %, tier drops, brand position and top-3 counts, LCP 2.5 s · INP 200 ms · CLS 0.1 | No — the value is set here or by a settled ruling | Stated plainly, as itself |
| **Generic default** — the -15% / -30% WoW traffic steps | No, but it is a starting guess, not this site's behaviour | Stated, **labelled** a generic default to recalibrate |
| **Derived value** — mean, standard deviation, band bounds, normal range, expected position | Yes | **Absent**, with the collection plan that would produce it |

Withholding a fixed threshold because no tool is connected is the same defect as inventing a
baseline: both replace what is known with what the run wishes it could say. The abstention form is
ledger **F19** — "confirm the boundary when you reconnect the feed", about a number the feed was
never going to supply.

### Precedence: one ladder per metric

Sections 2 and 3 both carry thresholds, and where they disagreed a run picked whichever unit
matched the data in front of it — which is how the same day's data graded Warning on one table and
Critical on another. They no longer disagree, and the rule that keeps them in line is: **the
Section 3 per-category ladder is the one ladder for its metric.** Section 3 is the complete one —
it carries the Emergency band, which no Section 2 table has — and it is what the templates and the
SKILL.md quick reference quote. Section 2's tables teach the three methods and repeat Section 3's
Warning/Critical values for the metrics they name; they never set a different value, a different
unit, or a different comparison period.

**Two notations for one ladder are not two ladders.** The Core Web Vitals rows carry a status word
*and* a figure — "Needs Improvement" **is** "above 2.5 s" — and a row quoting both is one rung
written twice, not a duplicate to consolidate away. This rule forbids a second *value*; it does not
forbid a second *notation* for the same value. The test: could a reader grade one observation two
different ways off these two rows? With a status word and its own boundary they cannot, so both
stay, and the numeric form is the one a monitoring tool can actually evaluate. Consolidating them
is how a run ends up shipping a CWV alert set that names no metric and no number — see Section 3.

**Five rows were corrected to this rule** — three on 2026-08-12, two more on 2026-08-13 after an
adversarial pass read the rule's own sentence back against the tables and found survivors. The
sentence above says Section 2 never sets *"a different value, a different unit, or a different
comparison period"*; the first sweep checked values and units and did not systematically check
periods. **A rule that names three tests is not applied until all three have been run**, which is
the transferable lesson here — the two survivors were both period conflicts.

The values in the two tables above are the corrected ones:

| Metric | Was, in Section 2 | Now, from Section 3 | Why it mattered |
|--------|-------------------|---------------------|-----------------|
| Server 5xx errors | Warning "any occurrence", Critical ">5 occurrences/hour" | Warning >1/day, Critical >5/day (Emergency >20/day) | >5 per hour is 120 per day — **24×** the daily Critical trigger. A day showing 6 responses read as Warning on the daily ladder and Critical on the hourly one. There is one 5xx ladder and its unit is per day. |
| Pages indexed | Critical -20% | Critical -15% (Emergency -30%) | A 17% drop was Critical on one table and Warning on the other. |
| Keyword positions | ">3 position average drop" / ">5 …" | Drop >= 3 / >= 5 (Tier 1, individual keyword) | `>3` excludes a drop of exactly 3, which Section 3's tier table and this skill's own worked example both grade Warning. "Average" also read as the aggregate metric, which has its own row in Section 3 (+2.0 / +5.0 worsening) on different numbers — that row, not this one, is the aggregate. |
| **Referring domains** (2026-08-13) | "-5% / -15% loss, **Month over month**" | ">5% / >15% of total lost, **Week over week**" (Section 3, Backlink Thresholds) | Same two numbers, different window — the exact form the rule forbids, missed because the first sweep compared values and not periods. 5% lost in a week is roughly 20% lost in a month: the two rows fire on materially different events, and a run picked whichever window its export happened to cover. |
| **New crawl errors** (2026-08-13) | "New crawl errors >10/day / >50/day", covering every error type | "New crawl errors **other than 4xx and 5xx** >10/day / >50/day" | 4xx and 5xx each have their own Section 3 count ladder (`>5/day` and `>1/day` Warning), so the old row was a superset with a looser trigger: a day with 8 new 4xx errors was Warning on the 4xx ladder and below any band on this one. Scoping it to the remainder — soft 404s, redirect chains, DNS and connectivity failures, robots-blocked URLs — makes it one metric instead of an overlapping second opinion on two others. |

**Two of the three retained values are the tighter of their pair**, so a 15% index drop and a
3-position drop now raise what they previously did not.

**The 5xx row is the exception, and it is a real loss of coverage — say so rather than round it
off.** Section 2's Warning was "any occurrence": one 5xx in a day raised a Warning. The Section 3
ladder starts at `>1/day`, so **a single 5xx in a day now raises nothing.** That is what having
one ladder in one unit costs here, and it is not free. An earlier draft of this paragraph claimed
"nothing alerts later than it did before the correction" — false in exactly this row, and the kind
of tidy summary that is worth distrusting on sight: a change touching three rows in two directions
rarely improves all of them, and a sentence saying it did is usually the writer's wish rather than
the table's content.

**If you want a signal on the very first 5xx of the day**, configure it as a boundary alert — no
band, priority stated with its reason — not as the Warning band: "any occurrence" is an event, not
a distance from a baseline, and never was one. Whether that boundary alert should be on by default
is an operator decision, not a documentation one — it turns on how noisy this specific site's 5xx
floor is, which nobody here has measured. It is listed with the others in **"Open threshold
decisions"** below.

**Referring domains has the same shape, and is named here rather than discovered later.** The
retired Section 2 row fired on 5% lost *month over month*; the Section 3 ladder fires on 5% lost
*week over week*. A site shedding 1.5% of its referring domains every week for a month loses ~6%
and raises nothing, where the monthly row would have raised a Warning. **Consolidating on the
weekly ladder trades slow-erosion coverage for a single unit.** That is the right default — a
weekly window is what the backlink section reports on and what an export supplies — but whether a
monthly erosion row should sit beside it is a business call about how much slow link decay costs
this client. Row 9 of the open decisions.

---

## 3. Threshold Configuration by Metric Category

### Traffic Thresholds

| Metric | Comparison | Warning | Critical | Emergency |
|--------|-----------|---------|----------|-----------|
| Total organic sessions | WoW | -15% | -30% | -50% |
| Total organic sessions | DoD | -25% (weekday) | -40% | -50% (site-down class) |
| Non-brand sessions | WoW | -20% | -35% | -50% |
| Organic conversions | WoW | -20% | -40% | -60% |
| Organic revenue | WoW | -15% | -30% | -50% |
| Bounce rate | WoW | +10pp | +20pp | +30pp |
| Page-level traffic (top 10 pages) | WoW | -25% | -40% | -60% |
| Organic CTR (site or query group) | WoW | 1.5 sd below the site's own CTR mean | 2 sd below | 3 sd below |

**Note:** Day-over-day traffic thresholds need day-of-week adjustment. Monday traffic typically differs from Saturday traffic. Compare Monday to Monday, not Monday to Sunday.

**The DoD Emergency cell is a number now.** It read "Site appears down" — a description, where every
other cell in the table is a threshold — so a template row triggering at a -50% day-over-day drop
appeared to carry a P0 that this band table could not produce. -50% DoD is the trigger Section 7's
**P0 Organic Traffic Emergency playbook** already states; the cell now says so. "Site-down class"
names what that magnitude usually means, and the playbook's step 1 is to check whether the site is
in fact down.

**CTR carries no benchmark in this skill, by design.** Its bands come from the site's own CTR
baseline on the Section 2 ladder, like any other measured series — there is no industry, vertical
or "typical e-commerce" CTR figure anywhere in this library, and one must not be supplied from
memory when a client asks whether their CTR is normal. If no CTR baseline exists yet, say that, say
what would supply it (the same 4-8 week collection as any other metric), and leave the number out.
Two further rules, because CTR is a ratio and its components move independently: read every CTR
alert with its clicks and its impressions beside it — CTR can *rise* on falling clicks when
impressions fall faster — and segment before alerting, since a site-wide CTR mean pools branded and
non-branded queries whose normal levels are nothing like each other (the Section 1 splitting test
applies to query groups exactly as it does to weekdays).

### Ranking Thresholds

| Metric | Scope | Warning | Critical |
|--------|-------|---------|----------|
| Position change (Tier 1 keywords) | Individual keyword | Drop >= 3 | Drop >= 5 |
| Position change (Tier 2 keywords) | Individual keyword | Drop >= 5 | Drop >= 10 |
| Position change (Tier 3 keywords) | Individual keyword | Drop >= 10 | Drop off page 3 |
| Average position (all keywords) | Aggregate | +2.0 (worsening) | +5.0 (worsening) |
| Keywords in top 10 | Count | -10% of count | -20% of count |
| Keywords in top 3 | Count | Any decrease | -3 or more |
| Brand keyword position | Individual | Any drop from #1 | Drops below #3 |
| Featured snippet lost | Individual | Any loss | Loss of 3+ snippets |

### Technical Thresholds

| Metric | Warning | Critical | Emergency |
|--------|---------|----------|-----------|
| New 4xx errors | >5/day | >20/day | >100/day |
| New 5xx errors | >1/day | >5/day | >20/day |
| Crawl rate change | -30% vs. baseline | -60% vs. baseline | Near-zero crawl |
| Index coverage drop | -5% | -15% | -30% |
| Average server response time | >500ms | >1000ms | >2000ms |
| LCP (field, mobile) | above **2.5 s** — "Needs Improvement" | above **4.0 s** — "Poor" | >6s |
| INP (field, mobile) | above **200 ms** — "Needs Improvement" | above **500 ms** — "Poor" | >1000ms |
| CLS (field, mobile) | above **0.1** — "Needs Improvement" | above **0.25** — "Poor" | >0.5 |
| Robots.txt change | Any unexpected edit | Pages blocked | Entire site blocked |
| Sitemap errors | New errors | Sitemap inaccessible | Sitemap returning 5xx |

**The Core Web Vitals numbers are settled, so state them — do not send a client to look them up.**
"Good" is **LCP ≤ 2.5 s · INP ≤ 200 ms · CLS ≤ 0.1** — settled ruling **R4**
(`docs/loop/SETTLED-RULINGS.md`), which also records that the input-delay metric INP replaced was
retired in **March 2024**. These are fixed definitions, not this site's baseline: they need no
history, no connected feed and no confirmation before they are written down, and a configuration
that withholds them because a tool is disconnected has withheld something it already knows. The
"Poor" ends in the Critical column are this guide's own second tier, not part of R4. Ruling handles
are operator vocabulary — cite R4 in working notes, give the client the number.

**Three metrics, three ladders, and the status word *is* the number.** "Needs Improvement" on LCP
means field LCP above 2.5 s: the words and the figures are one ladder written twice, not two
ladders, so Section 2's precedence rule has nothing to consolidate here and the one-observation rule
does not delete the figure. Every Core Web Vitals alert therefore ships **the metric name and its
numeric boundary** — "LCP (field, mobile) > 2.5 s", never "a CWV metric drops to Needs
Improvement". A status word is not a trigger a monitoring tool can evaluate, and a client cannot
check a boundary nobody wrote down. A rebuild that collapses these into one status-banded "Core Web
Vitals" row is the defect this paragraph exists to stop: it silently drops INP, which is exactly
the row a configuration inherited from before March 2024 is missing.

**Naming a retired metric in a review is not teaching it.** This library's own files never write
the retired input-delay token — a repo-level deprecated-token sweep fails the string — but that is
an authoring rule for these files, not a gag on the deliverable. Where a client's inherited config
carries a row on that metric, quote their row verbatim, say it monitors a metric retired in March
2024, and replace it with the INP row above at 200 ms. You cannot ask someone to delete a row you
refuse to name.

*(Numbers added to the LCP row 2026-08-13; INP and CLS given the same treatment and this note moved
out of the table on 2026-08-17. The 2026-08-13 fix had placed its explanation **inside** the table,
which orphaned the Robots.txt and Sitemap rows below a paragraph and stopped the table rendering as
one table. Original cause, unchanged: two blind runs in a row rebuilt the CWV rows **status-only**
and declined to give the numbers — one writing "confirm the current boundary numbers when you
reconnect the feed" about values that were never in question. Ledger **F17**, a rule with no
carrier, producing ledger **F19**, abstention where a settled ruling holds the answer. The third
run wrote no INP row at all: with the templates file shipping a complete status-keyed CWV pair, a
status-only rebuild had become the faithful reading of the skill, and "a CWV metric" names no
metric.)*

**The 5xx and index-coverage rows above are the single ladder for each of those metrics** — Section
2 quotes them, it does not set them (see "Precedence: one ladder per metric"). A whole-site outage
is graded by the traffic DoD Emergency row and Section 7's P0 playbook, not by counting 5xx
responses; the count ladder here is for the errors a crawl or a log review turns up.

**That sentence assigns the ladder, not the coverage.** It says where an outage's *severity* is
read from; it does not say that the traffic row is the only row watching for one, and reading it
that way is how a review ships a configuration with nothing watching whether the site is up. A
configuration still carries a site-availability row (templates, *Site Down*), because reachability
is a different observation from traffic: *the site did not respond* is a boundary fact an
availability check sees in minutes, *organic sessions fell by half* is a distance from a baseline
that a daily total cannot show until tomorrow. An outage raising both is two observations of one
incident, not one graded twice — the same split the templates already make between *Index Dropped*
and *Index Coverage Drop*.

### Backlink Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| Referring domains lost (weekly) | >5% of total | >15% of total |
| High-authority link lost (authority scale set by the connected tool — see the note) | Any loss | Loss of 3+ in one week |
| Toxic link spike | >10 new toxic links/week | >50 new toxic links/week |
| Anchor text over-optimization | Exact match reaches 20% | Exact match reaches 30% |
| Negative SEO pattern | Unusual link velocity from low-authority sites | Massive spam link spike |

**Which authority scale — name the tool, do not convert between them.** The rows above and the
templates' backlink rows have carried two different instruments: **DR 60+** (Ahrefs Domain Rating)
here and **DA 70+** (Moz Domain Authority) there. Both run 0-100, both are vendor models built on
that vendor's own crawl, and **nothing in this repository establishes a conversion between them** —
no "DR 60 ≈ DA 70" equivalence is asserted here, because nobody here has verified one, and the two
numbers were never calibrated against each other. So this alert is conditional on the tool that
feeds it: write the threshold in the scale of whichever backlink tool is connected, name that tool
in the same line ("DR 60+, Ahrefs"), and if the tool changes, re-set the number from the new tool's
own distribution rather than translating the old one. Which cut-off is right for a given client is
an operator decision, not a documentation fix — see "Open threshold decisions" below.

### GEO / AI Visibility Thresholds

All GEO/AI thresholds run on a **weekly check window**. The values below are tunable operational defaults, not measured constants — start here, then calibrate against the site's own citation baseline (Section 1).

**Every count band here states both ends.** The priority-1 loss row used to read "1" against "3+", which left **2** in neither label — the count this skill's own eval turns on. Section 2's "boundaries read upward" convention would have resolved it, but this section never cited that convention and a reader following the rungs literally had nothing to apply. **A band that needs a convention stated in another section to be readable is not a band**, so the rungs are written closed here instead of leaning on it.

| Metric | Warning | Critical |
|--------|---------|----------|
| AI citation rate | Down 10+ percentage points vs. baseline | Below a 10% absolute floor |
| Priority-1 citation loss (count in the window) | **1 or 2** priority-1 queries lose their citation — i.e. are dropped from the answer entirely | **3 or more** priority-1 queries lose citations in one window |
| Citation position, citation retained (slots moved) | Worsens by 2+ slots | not graded here — see the one-event rule below |
| Competitor gains citation you lost | 1 instance | Pattern across queries |

**One event, one row.** These two rows used to grade a single observation twice. A priority-1 query
that lost its citation fired the loss row (Warning) *and* the position row's Critical, which read
"dropped from the answer entirely" — the same event. Under Section 2's "highest trigger wins"
reading, every single loss then became Critical, and therefore **P0** under the standing priority-1
override, which left the 3-or-more cluster row unreachable: there is nothing above P0 to escalate
to. The rows are now disjoint, and each grades a different quantity:

- **The loss rows count queries.** How many tracked priority-1 queries lost their citation in this
  window — 1 = Warning, 3+ = Critical. "Dropped from the answer entirely" *is* one query losing its
  citation, so it is graded here, not as a position move.
- **The position row measures slots**, and only while the citation is retained: how far a citation
  the site still holds has moved inside the answer. It has a Warning trigger and no Critical.
  Leaving the answer is not a larger slot move, it is a different event; and a Critical trigger for
  slot movement would need a number nobody here has measured, so none is invented.

Where two rows still look like they describe one observation, grade it on the row that names it
most specifically, and say in the alert which row you graded it on.

**Priority-1 definition:** the client-critical keywords collected at alert setup — money terms, brand terms, and top-converting queries. Identical to "Tier 1" in the keyword-tier tables above; keep a single list so ranking alerts and citation alerts fire on the same queries.

**Event alerts (same weekly window):**

| Event | Band | Priority | Handling |
|-------|------|----------|----------|
| Citation won on a tracked query | Info (positive) | P3 | Log the win and note which page earned it — replicable patterns matter |
| AI Overview appears or disappears on a tracked query | Warning | P2 | Re-assess expected CTR for that query; both directions shift the click landscape |

The two GEO alerts that carry the priority-1 query set are raised one level above their band's
default, and say so where they are defined: a single priority-1 citation loss is **P1** (band
Warning) and a 3-or-more cluster is **P0** (band Critical), because that keyword set is the
client's money, brand and top-converting terms. Every other row in this section takes the default
map in Section 4.

**One caveat on the two citation-*rate* rows**, which the templates file also ships one level above
default (Rate Slide P1, Rate Floor P0): the standing override is not what lifts them. It covers the
priority-1 query set, and the citation *rate* is a site-wide line across all tracked queries, not a
query-level row — so the override cannot reach it. Their raised priority is an inherited business
call about how much a falling citation rate matters, which no measurement here establishes.
Confirm it with the operator or drop both rows to their band's default (P2 / P1); either way, the
reason written beside them must be the real one.

**Optional statistical ladder:** once enough weekly citation history exists for a stable mean and standard deviation (8+ weeks — see the Section 1 baseline periods), the Section 2 standard-deviation method may replace the fixed defaults for citation metrics: deviations from the baseline mean at 1 / 1.5 / 2 / 3 standard deviations map to Info / Warning / Critical / Emergency. This is a statistical option that requires sufficient history, not a requirement — with thin history the fixed defaults above are safer.

**Response path:** every citation-loss alert (rate, priority-1, or position) hands the affected query and its source page to content-refresher's AI Overview recovery playbook.

### Prompt-Level Answer Thresholds — proposed defaults, not settled numbers

**Everything in this subsection is a proposed default awaiting the client's confirmation.** No
baseline for prompt-level answer metrics exists anywhere in this library, so no measured constant
is available and none is invented; the values below are starting points that a configuration marks
as proposed when it ships them, on the same terms as the rows in *Open threshold decisions* below.

**The sampling rule comes before any threshold, and without it none of these rows is alertable.**
Generated answers vary between runs for the same prompt, on the same day, from the same location.
A single capture is an **observation**, never a measurement, so:

- **N ≥ 3 repeats** per prompt per engine per cycle, captured in one session, before any prompt-level
  condition is evaluated at all.
- **The condition is a `k of N`**, and both numbers appear in the alert: "named in 0 of 3 captures",
  never "not named". A bare yes/no on one capture is not an alert condition, it is noise with a
  pager attached.
- **Two consecutive cycles** confirm before firing. A `k of N` standing in one cycle is a candidate;
  a change that has not survived a second cycle has not measurably happened.
- **Failed captures** — refusal, rate limit, empty response — are logged with their reason and
  reduce N. Dropping them silently turns a 1-of-1 into 100%.
- **Per engine, never pooled.** A brand absent from one engine's answers and present in another's is
  one finding on one row, not an average across two.
- **Where the repeats cannot be run**, these rows ship **off** and the configuration says so. An
  alerting system that reads one capture as a measurement pages the client on the engine's own
  variation until they mute the channel — which takes the rest of the alerts with it.

| Metric | Proposed trigger (per engine, per cluster, confirmed across 2 cycles) | Band |
|--------|----------------------------------------------------------------------|------|
| Brand absent from answers | Brand named in **0 of N** captures for the cluster's head prompts | none — boundary alert |
| Recommendation position | Cluster mean worsens by **2 or more slots** vs. the previous cycle, over captures where a recommendation set existed | none — boundary alert |
| Competitor enters answer set | A competitor absent last cycle is named in **2 or more of N** captures | none — boundary alert |
| Cited URL is a non-owning property | The cited client URL is not the register's owning URL in **2 or more of N** captures | none — boundary alert |

**Why every band reads "none — boundary alert".** Sections 2-3 define no ladder for prompt-level
answer metrics — no baseline mean, no standard deviation — so these fire on an event, exactly like
the brand and competitor-activity rows, and with no band there is no default map to sit above or
below. Priorities are set directly from the business and owe no "raised from" clause. Once 8+ cycles
of `k of N` history exist, the Section 2 method can build a ladder from the site's own record, on
the same terms as the optional statistical ladder above; until then nothing is invented to fill the
column.

**The non-owning-property row is a cannibalisation signal.** Its fix is the ownership contest —
consolidate, differentiate, retire — not content work on the answer. Route it to the ownership
register (`references/query-cluster-ownership.md` §5), and do not hand it to the AI Overview
recovery playbook, which will not resolve a contest between two of the client's own URLs.

### Metrics with no ladder — these are boundary alerts

Sections 2-3 define no ladder for **brand and reputation metrics** (mentions, sentiment, reviews,
press) and none for **competitor activity** (a competitor publishing, updating a page, or gaining a
link). That is not a gap to be filled by inventing one: those alerts fire on an event, and an event
has no distance from a baseline. Every alert on them carries **"none — boundary alert"** in its Band
column, and — because with no band there is no default map to sit above or below — its priority is
set directly from the business and owes no "raised from" clause. Two of them could carry a ladder
once a baseline exists (average review rating and monthly mention volume are both numbers with a
mean); this file sets no numbers for them, and an operator holding that history can build the ladder
with the Section 2 method.

### Open threshold decisions — thirteen rows, for the operator

Each of these needs a business judgement about the right *value*. They are deliberately left open
rather than filled with a number nobody chose; a configuration that ships one of them states the
choice it made.

**The count is the table.** This heading previously read "seven" over six rows, because the seventh
— the citation-*rate* pair — was written up in prose two sections above and never carried down
here. A decision an operator cannot find in the list of decisions is not open, it is lost; so every
row now sits in this table, and anything added to the list moves this number with it. **Rows 10-13
were added with the prompt-level answer thresholds** and moved the count from nine, per that same
rule — a register elsewhere still quoting nine is quoting a superseded count, not a disagreement to
be split.

| # | Row | The decision |
|---|-----|--------------|
| 1 | High-value link lost / gained | Which authority scale feeds it (DR from Ahrefs, DA from Moz, or another) and the cut-off on that scale. The scales are different instruments and are not converted here. |
| 2 | Crawl Errors Spike, "errors increase 50%+" | 50% is 1.5× baseline, below this guide's Warning trigger of >2×, so the trigger reaches no band at all — while the templates give the row P1. Either move the trigger to >2× baseline (then Warning → P2 by the default map) or keep 50% as a deliberate early boundary alert and state the priority's reason in the row. |
| 3-6 | The four page-level traffic rows — homepage 20%+, top-10 pages 30%+, conversion pages 25%+, blog posts 40%+ | Each states a percentage with no comparison period, so no band can be read off it. Setting the period (DoD / WoW / MoM) settles the band; this guide's page-level bands run week over week (Warning -25%, Critical -40%, Emergency -60%). |
| 7 | The two citation-*rate* rows — Rate Slide (P1) and Rate Floor (P0) | Both ship one level above their band's default, and the standing priority-1 override does **not** reach them: that override covers a query set, and citation rate is a site-wide line across all tracked queries. Confirm the raised priorities as a deliberate business call, or drop both to their band defaults (P2 / P1). Either way the reason written beside them has to be the real one. Full statement in the citation-metrics section above. |
| 8 | A single 5xx in a day — boundary alert, or nothing? | Consolidating onto the Section 3 per-day ladder moved the 5xx Warning from "any occurrence" to `>1/day`, so one 5xx in a day now raises nothing. Restoring it means a boundary alert (no band, priority stated with its reason), and whether that is worth its noise depends on this site's 5xx floor, which nobody here has measured. Default off, deliberately, until someone measures it. |
| 9 | Slow referring-domain erosion — a monthly row beside the weekly one? | The weekly ladder (>5% / >15% of total) does not see 1.5%/week sustained for a month. Adding a month-over-month row restores that coverage and doubles the rows watching one metric, which is what the precedence rule exists to prevent — so it is only worth it if slow link decay is a real cost for this client. Default: weekly only. |
| 10 | Brand absent from answers — the `k` and the priority | Proposed: fires at **0 of N** captures for the cluster's head prompts, confirmed across two cycles, at **P1** where the cluster is on the priority-1 list and **P2** otherwise. Nothing measured supports either the `k` or the priority; both are the client's call. Sampling discipline (N ≥ 3, `k of N`, two-cycle confirmation, per engine) is **not** on this list — it is a method rule, not a value, and it does not ship off. |
| 11 | Recommendation position drop — how many slots, over what | Proposed: cluster mean worsens by **2 or more slots** vs. the previous cycle, over captures where a recommendation set existed. The 2-slot figure mirrors the citation-position row and is not independently measured; a client who wants only large moves raises it. Confirm the slot count and the priority (proposed P2). |
| 12 | Competitor enters the answer set — how many captures | Proposed: a competitor absent last cycle named in **2 or more of N** captures this cycle. At `k` = 1 the row fires on a single capture's variation, which is the failure this category's sampling rule exists to prevent; at `k` = N it will miss real entries. Confirm `k` and the priority (proposed P2). |
| 13 | Cited URL is a non-owning property — how many captures, and who owns the response | Proposed: **2 or more of N** captures cite a client URL that is not the register's owning URL. Two decisions, not one: the `k`, and whether the alert routes to the ownership contest (recommended — it is a cannibalisation signal) or to content work. It also presumes an ownership register exists; where the cluster has no assigned owner the row records `no owner assigned` and that is the finding. |

---

## 4. Alert Routing Configuration

### Two axes, two vocabularies — keep them apart

An alert carries two labels, and they answer different questions. Writing one where the other
belongs is how a metric that moved 1.6 standard deviations ends up on someone's phone at 02:00.

| Axis | Vocabulary | Answers | Set by |
|------|-----------|---------|--------|
| **Threshold band** | Info · Warning · Critical · Emergency | How far did the metric move from its own baseline? | Sections 2-3, from the data |
| **Response priority** | P0 · P1 · P2 · P3 | Who is notified, through which channel, how fast? | This section, from the business |

**Default map** — band to priority, used unless the alert definition says otherwise:

| Band | Default priority | Response clock |
|------|-----------------|----------------|
| Emergency | **P0** — Emergency | Acknowledge <15 min, first action within 1 hour |
| Critical | **P1** — Urgent | Acknowledge <4 h, resolved same day |
| Warning | **P2** — Important | Within 48 hours |
| Info | **P3** — Monitor | Weekly review / digest |

An alert may sit above or below its default, and then the definition states the reason in one
clause: *"P0 — raised from P1: any security detection is paged regardless of magnitude"*,
*"P1 — raised from P2: priority-1 query set"*. Two standing overrides: **security issues and
manual actions are P0 on any detection** (there is no small manual action), and **alerts on the
priority-1 / Tier-1 keyword set rise one level**.

The words "High", "Medium" and "Low" are not priority labels in this skill. They were a third
name for the P0-P3 axis, and their "Critical" collided with the Critical *band* — the same word
grading a metric in one table and a pager rota in the next. Positive and opportunity alerts still
carry a priority, because a priority is what decides delivery: they are P3 unless someone has
asked to hear about wins sooner.

### Roles — one vocabulary, and they are hats, not headcount

Every route in this skill names a role from this list, and no other name is used anywhere — here or
in the templates file:

**SEO Lead · SEO Analyst · SEO Team · Content Lead · Engineering Lead · Engineering Team · DevOps ·
Marketing Manager · Marketing VP · Legal**

"SEO Team" and "Engineering Team" are the group forms — the analysts and the engineers — not extra
people. Two spellings of one role ("Eng Lead" / "Engineering Lead", "VP" / "Marketing VP") are one
role, and the canonical spelling above is the one to write.

A role is a hat. On a small team one person wears several, so the configuration **maps every role
to a named person before it goes live**, and a role nobody holds is deleted from the routing table
rather than left in it: a role with nobody behind it is not a route, and an inherited template
listing staff the client does not employ is the commonest way an escalation path fails on the night
it is needed. The templates file previously ran a second, shorter list (SEO Manager / Dev Team /
Marketing Lead / Executive), so a configuration built from the templates and a routing matrix built
from this guide named different recipients for the same alert. There is one list, and it is this
one.

### Routing Matrix

| Alert Category | P0 (Emergency) | P1 (Urgent) | P2 (Important) | P3 (Monitor) |
|---------------|----------------|-------------|----------------|--------------|
| **Traffic** | SEO Lead + Engineering Lead + Marketing VP | SEO Lead + Marketing Manager | SEO Team | Weekly digest |
| **Rankings** | SEO Lead + Content Lead | SEO Team | SEO Team | Weekly digest |
| **Technical** | SEO Lead + Engineering Lead + DevOps | SEO Lead + Engineering Team | SEO Team + Engineering Team | Weekly digest |
| **Backlinks** | SEO Lead | SEO Team | SEO Team | Weekly digest |
| **Competitor** | N/A | SEO Lead | SEO Team | Weekly digest |
| **GEO/AI** | SEO Lead + Content Lead | SEO Team | SEO Team | Weekly digest |
| **Security** | SEO Lead + Engineering Lead + Marketing VP + Legal | All above | N/A | N/A |

### Role-Based Alert Filtering

One row per role in the list above, and each row is **read off the routing matrix** rather than set
separately — if you change a cell in the matrix, this table changes with it.

| Role | Receives | Does Not Receive |
|------|---------|-----------------|
| SEO Lead | Every P0 and P1; P2 through the team queue | P3 (weekly digest only) |
| SEO Analyst | P1, P2 in their area (as part of SEO Team) | P0 (escalation only), other areas |
| SEO Team | P1 and P2 in every category | P0 (routed to the named leads), P3 beyond the digest |
| Content Lead | P0 ranking + GEO alerts | Technical, traffic, backlink alerts |
| Engineering Lead | P0 technical, traffic and security | Ranking, content, backlink alerts |
| Engineering Team | P1 and P2 technical | Every non-technical category |
| DevOps | P0 technical + security | All non-infrastructure alerts |
| Marketing Manager | P1 traffic | Everything else — traffic P0 goes to the VP |
| Marketing VP | P0 traffic + security only | P1-P3 (receives weekly summary) |
| Legal | P0 security only | Everything else |

---

## 5. Notification Channel Setup

### Channel Selection by Priority

| Priority | Primary Channel | Secondary Channel | Escalation Channel |
|----------|----------------|-------------------|-------------------|
| P0 | SMS + Phone call | Slack (#seo-emergencies) | PagerDuty / on-call rotation |
| P1 | Slack (#seo-alerts) | Email | SMS (if not acknowledged in 4h) |
| P2 | Email | Slack (#seo-daily) | Auto-escalate to P1 after 1 week |
| P3 | Weekly digest email | Dashboard | Auto-escalate to P2 after 1 month |

### Notification Content Requirements

Every alert notification should include:

| Field | Required | Example |
|-------|----------|---------|
| Alert name | Yes | "Critical Ranking Drop" |
| Priority level | Yes | "P0 — Emergency" |
| Metric affected | Yes | "Position for 'project management software'" |
| Current value | Yes | "Position 12" |
| Previous value | Yes | "Position 3 (yesterday)" |
| Threshold breached | Yes | "Dropped 9 positions — Tier 1 Critical trigger is a drop >= 5" |
| Timestamp | Yes | "2025-01-15 09:00 UTC" |
| Affected URL | Yes (if applicable) | "yoursite.com/blog/pm-guide" |
| Quick action link | Yes | Link to relevant tool/dashboard |
| Suggested first step | Recommended | "Check if page is still indexed: site:yoursite.com/blog/pm-guide" |

### Notification Suppression Rules

| Rule | Configuration | Reason |
|------|-------------|--------|
| Duplicate cooldown | Do not re-alert on same metric for 24 hours | Prevent alert storms |
| Maintenance window | Suppress non-security alerts during scheduled maintenance | Avoid known-cause alerts |
| Weekend adjustment | Increase traffic thresholds by 20% on weekends | Weekend traffic naturally lower |
| Holiday adjustment | Suppress traffic alerts on major holidays | Known seasonal impact |
| Recovery auto-close | Auto-close alert if metric returns to normal within 48h | Reduce stale alerts |
| Batch related alerts | Group multiple ranking drops into single "Ranking Alert" | Reduce notification volume |

---

## 6. Threshold Tuning Guide

### When to Tune Thresholds

| Signal | Action |
|--------|--------|
| Too many false positives (>30% of alerts are noise) | Widen thresholds by 0.5 standard deviations |
| Missed a real problem | Tighten the specific threshold that should have caught it |
| Seasonal change approaching | Adjust baselines for known seasonal patterns |
| Major site change (redesign, migration) | Re-establish baseline from scratch (2-4 week observation) |
| New competitor enters market | Add competitor monitoring, adjust ranking sensitivity |
| After algorithm update | Let metrics stabilize for 2-4 weeks, then recalibrate |

### Monthly Threshold Review Checklist

| Check | Action |
|-------|--------|
| Review all alerts fired in the past month | Count true positives vs. false positives |
| Calculate false positive rate | If >30%, thresholds are too tight |
| Check for missed events | If a real issue was not alerted, threshold is too loose |
| Review metric baselines | Recalculate mean and standard deviation with latest data |
| Adjust seasonal baselines | Incorporate seasonal patterns from year-over-year data |
| Update keyword tiers | Promote/demote keywords based on current business priority |
| Verify notification routing | Confirm all recipients are still in the correct roles |
| Test alert delivery | Send a test alert through each channel to verify delivery |

### A row that never fires — four diagnoses, and only one of them is tuning

Zero fires across a review window is a finding, not a clean bill. Say which of these it is before
touching a number, because the fixes differ and only the last row is a threshold problem:

| Diagnosis | What it looks like | Fix |
|-----------|--------------------|-----|
| **Dead metric** — the thing measured no longer exists | The metric was retired by the platform; its column vanished from the tools | Replace the metric, do not retune the row. The input-delay metric retired in March 2024 becomes an INP row at **200 ms** (ruling R4) |
| **Dead feed** — the metric lives, the data stopped | A subscription lapsed, a key expired, an export stopped arriving | Rewire the source, then keep the row. Until the source is back the row is not coverage, and no threshold edit changes that |
| **Dead report** — the surface the alert watched was withdrawn | The report or search feature that fed it is gone, so nothing can fire | Retire the alert. Do not propose a replacement sensor for a surface that no longer exists |
| **Quiet guard** — nothing has gone wrong yet | A security or site-down row on a healthy site | Keep it, and test-fire it. Silence here is the alert working |

**The FAQ rich-result alert is the dead-report case: those rich results ended in 2026**, per
settled ruling **R3** (`docs/loop/SETTLED-RULINGS.md`). The search appearance and the rich-result
report were dropped; Search Console API support was scheduled for August 2026, and this guide does
not assert that cut as complete. An alert watching for the loss of that result has no sensor left,
so it is removed rather than retuned, and no replacement monitor is proposed for it.

**The retirement stops at the alert.** R3 keeps FAQPage markup in this library: it stays valid, and
per that ruling Google's own guidance is that there is no need to proactively remove it. A review
that turns "this alert is dead" into "delete your FAQPage markup" has extended a monitoring finding
into a site change nobody ruled on. R3 constrains the other direction too — this library does not
claim that markup earns AI citations, so a review does not sell it back to the client on that
ground either.

### The row that is not there

All four diagnoses above start from a row you can read. The gap none of them can see is the metric
with **no row at all**: nothing fired, nothing is silent, and neither a fire log nor a config export
contains anything to notice. A review that triages only the rows it inherited will report a
healthier estate than it found, and will do it in good faith — **"nothing fired here" and "nothing
watches this" are the same line in a fire log**, which is why the question can only be asked from
the template side.

So a review runs one more pass, over the templates' category tables rather than over the client's
config: which categories have no row, and is each absence deliberate? Two are **floor coverage**,
named rather than left to judgement — **a site-availability row** and **the security /
manual-action pair at any detection**. A configuration missing either adds it from the templates, or
the deliverable says why it is out. Every other absence is reported as an absence rather than
quietly accepted; an incident that got noticed only because some *other* row happened to move is the
case this pass exists for, and it reads in the log as a working alert rather than as a gap.

This is not the single-5xx question in "Open threshold decisions" (row 8), which asks whether one
5xx in a day earns a boundary alert and is deliberately defaulted off. The floor here is
availability, and its row already carries its trigger — nothing on this list needs a number set.

### Threshold Evolution Over Time

| Site Maturity | Threshold Approach | Rationale |
|-------------|-------------------|-----------|
| New site (0-6 months) | Wide thresholds, few alerts | Metrics are volatile; avoid noise |
| Growing (6-18 months) | Moderate thresholds, expand coverage | Enough data for meaningful baselines |
| Established (18+ months) | Tight thresholds, comprehensive | Stable baselines, can detect subtle changes |
| Post-migration | Reset to wide, re-tighten over 4-8 weeks | Old baselines are invalid |

---

## 7. Playbook Templates by Alert Type

### Playbook: Organic Traffic Emergency (P0)

**Trigger:** Organic traffic drops >50% day-over-day

| Step | Time | Action | Tool |
|------|------|--------|------|
| 1 | 0 min | Verify site is accessible from multiple locations | Manual browser check, uptime monitor |
| 2 | 5 min | Check Google Search Status Dashboard for outages | Google Status Dashboard |
| 3 | 10 min | Check Search Console for manual actions or security issues | Search Console |
| 4 | 15 min | Check robots.txt for accidental blocking | Direct URL check |
| 5 | 20 min | Check for noindex tags added to key pages | Crawl or manual page inspection |
| 6 | 30 min | Review recent deployments or CMS changes | Deploy log, git history |
| 7 | 45 min | Check server logs for unusual patterns | Server access logs |
| 8 | 60 min | If unresolved, escalate to Engineering Manager | Slack/phone |

### Playbook: Security Alert (P0)

**Trigger:** Google Search Console security issue or manual action

| Step | Time | Action |
|------|------|--------|
| 1 | 0 min | Read the exact message in Search Console |
| 2 | 5 min | Notify Engineering Manager and VP Marketing |
| 3 | 15 min | Scan site for malware or injected content |
| 4 | 30 min | If compromised: take affected pages offline, rotate all credentials |
| 5 | 1 hour | Identify attack vector and patch vulnerability |
| 6 | 2 hours | Clean all affected pages, submit for re-review |
| 7 | 24 hours | Verify resolution in Search Console |
| 8 | 1 week | Post-incident review and security hardening |

### Playbook: Algorithm Update Impact (P1-P2)

**Trigger:** Confirmed Google algorithm update + ranking/traffic changes

| Step | Time | Action |
|------|------|--------|
| 1 | Day 0 | Confirm update via Google Search Status Dashboard or official channels |
| 2 | Day 0 | Document pre-update baseline metrics (rankings, traffic, visibility) |
| 3 | Day 1-3 | Monitor daily — do not make changes while update is rolling out |
| 4 | Day 7 | First analysis: which pages/keywords improved, which declined |
| 5 | Day 7 | Analyze pattern: content quality? link profile? technical? YMYL? |
| 6 | Day 14 | Develop action plan based on analysis |
| 7 | Day 14-60 | Implement improvements (content quality, E-E-A-T signals, technical fixes) |
| 8 | Next update | Re-evaluate impact after next core update |

### Playbook: Backlink Attack / Negative SEO (P1)

**Trigger:** Unusual spike in low-quality backlinks (>100 new links from spam domains in one week)

| Step | Time | Action |
|------|------|--------|
| 1 | Day 0 | Verify the spike in the backlink index (name the tool used) |
| 2 | Day 0 | Identify the pattern (same anchor text? same link network? same country?) |
| 3 | Day 1 | Export all new toxic links |
| 4 | Day 1 | Create disavow file with identified spam domains |
| 5 | Day 2 | Upload disavow to Google Search Console |
| 6 | Day 2 | Document the attack pattern for future reference |
| 7 | Day 7 | Re-check for continued spam link activity |
| 8 | Day 14 | Verify disavow processed, monitor rankings for impact |

### Playbook: Core Web Vitals Degradation (P2 at "Needs Improvement" · P1 at "Poor")

**Trigger:** one named metric leaves "Good" — **LCP above 2.5 s · INP above 200 ms · CLS above
0.1** — either into **"Needs Improvement"** (Warning band → **P2**, the default map) or straight
into **"Poor"**: LCP above 4.0 s, INP above 500 ms, CLS above 0.25 (Critical band → **P1**, the
default map, and the templates' "— Poor" rows). Which metric moved is part of the trigger; "a CWV
metric degraded" is not an alert anyone can act on, and it is how the INP row goes missing. The
header used to say P2 for a trigger that spans both bands, while the templates priced the Poor end
at P1.

One playbook, two entry priorities: the steps below are the same either way, but the clock belongs
to the priority, never to the band — P2 is within 48 hours, P1 is acknowledged within 4 hours and
resolved the same day. The day numbers in the table are the P2 pace; compress them for a P1 entry.
Only the last step is fixed by physics rather than by priority: field data (CrUX) is a 28-day
rolling window and will not confirm a fix sooner.

| Step | Time | Action |
|------|------|--------|
| 1 | Day 0 | Identify which metric degraded and which page groups are affected |
| 2 | Day 1 | Run PageSpeed Insights on representative pages |
| 3 | Day 1 | Check recent deployments for potential cause (new scripts, images, layout changes) |
| 4 | Day 2 | Create engineering ticket with diagnosis and fix recommendations |
| 5 | Day 3-14 | Engineering implements fix |
| 6 | Day 14 | Verify improvement in lab data (PageSpeed Insights) |
| 7 | Day 42 | Verify improvement in field data (CrUX — 28-day rolling window) |

---

## 8. Alert System Maintenance

### Quarterly System Review

| Task | Frequency | Owner |
|------|-----------|-------|
| Recalculate all baselines with latest data | Quarterly | SEO Lead |
| Review and update keyword tier assignments | Quarterly | SEO Team |
| Audit notification routing (team changes, role changes) | Quarterly | SEO Lead |
| Test all notification channels (SMS, Slack, email) | Quarterly | SEO Lead |
| Review alert response times (are SLAs being met?) | Quarterly | SEO Lead |
| Archive resolved alerts older than 90 days | Quarterly | SEO Analyst |
| Update playbooks based on lessons learned | Quarterly | SEO Team |

### Alert Effectiveness Metrics

Track these metrics about your alerting system itself:

| Metric | How it is computed | Target |
|--------|--------------------|--------|
| False positive rate | alerts closed with no action taken ÷ alerts fired in the window × 100 | <30% |
| Mean time to acknowledge (MTTA) | Σ (first human response − fire time) ÷ alerts acknowledged, per priority | P0: <15min, P1: <4h |
| Mean time to resolve (MTTR) | Σ (resolution − fire time) ÷ alerts resolved, per priority | P0: <2h, P1: <24h |
| Missed incident rate | incidents found by other means ÷ (those + alerted incidents) × 100 | 0% |
| Alert volume per week | count of alerts fired ÷ weeks in the window | Manageable for team size |

Each of these is reported with its two counts, not as a bare percentage: `false positive rate 22%
(7 of 32 alerts in October)`. An alert still open at the end of the window is excluded from MTTR
and named — averaging it in as if it resolved at the window edge flatters the number. Report MTTA
and MTTR per priority, never pooled: one P0 in a month of P3s moves a pooled mean far more than it
means anything.

---

## 9. Writing the configuration up — counts, quotes, generics, payloads and unverified explanations

The thresholds are half the deliverable; the prose around them is where the recorded defects have
landed. Six rules, each of them from a shipped review that a client could have checked.

### 9.1 Every "N of M" enumerates its members

A count inside the sentence carrying your central risk claim is the first thing a reader checks
against the table above it, so write it derivably: name the M, name the N, and list the N — "six of
the eleven rows (2, 3, 5, 8, 10, 11)", not "most of them". The usual error is two populations that
are not the same set: rows that exist, rows a given service feeds, rows that fired zero times, rows
already dark for a different reason. **A row already silent because its own feed lapsed is not among
the rows that "go quiet" when a shared service stops** — it is outside that N, and counting it in
makes the claim off by one against a table the client can read for themselves. Same rule for a set
you rebuilt: if the traffic rows become three, list the three.

### 9.2 Nothing is "named" that the source does not name

"Two named competitors" asserts that names exist. If the source records only that a competitor was
cited, write "two competitors, not named in the sheet" — and never both forms in one deliverable,
which is how a document contradicts itself between page one and page four. The unknown travels in
the same phrase as the fact, not in a caveat three sections away.

### 9.3 A quoted definition is quoted once

Where the client's own file defines a term, quote it verbatim and then use those words. Re-glossing
it a clause later — "i.e. …", "meaning …" — in your own words leaves two definitions of one term in
one paragraph, and which one binds is now the reader's guess. If the source's definition needs a
comment, comment on it; do not restate it.

### 9.4 A claim about other sites is labelled or cut

"Most shops run…", "it almost always falls outside…", "what most businesses of this size see" are
generalisations with no source in the client's data and none in this library. Either label the
sentence a generic assumption not derived from this site's data, or cut it. **A hedge is not a
label**: "probably", "typically around" and "usually" carry no provenance. This is Section 3's
CTR-benchmark rule generalised — this skill holds no industry norms, and a run may not supply them
from memory.

### 9.5 A handoff payload copies identifiers character-for-character

The receiving run pastes the payload, so a host written `www.example.gr` where the brief says
`example.gr` sends the next run to a host nobody established — and a deliverable using the bare
domain in its prose and the `www.` form in its payload has already disagreed with itself. Copy the
domain, the path and the casing as the source wrote them: add no scheme, no `www.`, no trailing
slash that was not there. Where the source gives only a path, join it to the domain in the source's
own form and say the absolute form was not supplied. The carrier's rule is the reason —
an incomplete row that names its gap is a working handoff, and a complete-looking row with one
guessed field is a defect that propagates (`references/inter-skill-handoff.md` Section 4.4).

### 9.6 An unverified explanation is the leading explanation, not a fact

A monitoring write-up is mostly explanations of readings, and the explanation is normally arrived at
before anything has been checked. Write it at the confidence you actually hold: the **reading** is
the fact, the **explanation** is the leading one, and the sentence says which is which. The tell is
internal — **a document that prescribes a verification and states the conclusion as settled has
contradicted itself in two paragraphs.** If the check could not change the answer it is not a
check; if it could, the answer is not settled yet. Hedging the *worry level* ("almost nothing to
worry about here") is not hedging the *diagnosis*: the diagnosis needs its own words, and a
plausible explanation stated in bold is still a stated one.

Two shapes, both from shipped reviews:

- **A missing measurement is a gap in the data, not a measurement.** Where a log carries no value
  for a day, what is established is that no value was recorded. "The metric did not move" and "the
  metric was not measured" are different claims, and the second never licenses the first.
- **The source's own definition of its own notation is the fact; your reading of it is the
  hypothesis.** Where the client's file states what its dash, blank or zero means, that is what it
  means. Section 9.3 forbids re-glossing that definition; this forbids **overriding** it. Answering
  «it does not mean X, it means Y» to a file that said X is what converts a probable explanation
  into a stated one, on the strength of nothing — and it is the step a reader cannot check, because
  the file they hold says X. If their definition looks wrong, say it looks wrong, say what would
  settle it, and leave both readings standing until it is settled.

---

## 10. Tips for Success

Moved here from `SKILL.md` to keep that file inside its 350-line body cap. Operator guidance, not
configuration copy.

1. **Start simple** — do not create too many alerts initially. An estate with six alerts that fire
   correctly beats one with sixty nobody reads.
2. **Tune thresholds** — adjust against the site's own measured variance, not against this guide's
   generic defaults, and say which you used (Sec. 1, "Three method choices").
3. **Avoid alert fatigue** — too many alerts means ignored alerts, and an ignored channel takes the
   good alerts down with it. This is the whole reason no prompt-level row may fire on one capture.
4. **Document response plans** — know what to do when an alert fires, and who does it. A plan with
   no owner and no resolution condition is a list of things somebody might try.
5. **Review regularly** — alerts need maintenance as the SEO programme matures; run the never-fired
   triage and the absent-row pass together (Sec. 6).
6. **Include positive alerts** — track wins, not just problems. A citation won is an Info-band P3
   row and it is worth having.
