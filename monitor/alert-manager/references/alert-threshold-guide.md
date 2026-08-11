# Alert Threshold Guide

Complete reference for configuring SEO/GEO alert thresholds. Covers baseline establishment, threshold setting methodology, tuning process, alert routing configuration, notification channel setup, and response playbooks for each alert type.

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
| Keyword positions | >=3 position average drop | >=5 position average drop | Week over week |
| Pages indexed | -5% change | -15% change | Week over week |
| Referring domains | -5% loss | -15% loss | Week over week |
| Crawl error rate | >2x baseline rate | >5x baseline rate | Day over day |
| Conversion rate | -20% drop | -40% drop | Week over week |

### The Absolute Value Method

For binary or count-based metrics, use absolute thresholds.

| Metric | Warning Threshold | Critical Threshold |
|--------|------------------|-------------------|
| New crawl errors | >10 new errors/day | >50 new errors/day |
| Server 5xx errors | >1/day | >5/day |
| Security issues | N/A | Any detection |
| Manual penalties | N/A | Any notification |
| SSL certificate expiry | <30 days to expiry | <7 days to expiry |
| Robots.txt changes | Any unexpected change | Key pages blocked |

**Where a metric also appears in Section 3, Section 3 is the definition and these two tables are
the restatement.** Section 3 carries the full ladder including Emergency, so a value here that
Section 3 contradicts is the copy that drifted, not a second opinion — read the band off Section 3
and fix the copy. (The 5xx row above once carried an **hourly** Critical while Section 3 banded the
same metric **per day**: six errors in a day graded Critical on one table and Warning on the other,
a 24-fold disagreement inside one guide.)

---

## 3. Threshold Configuration by Metric Category

### Traffic Thresholds

| Metric | Comparison | Warning | Critical | Emergency |
|--------|-----------|---------|----------|-----------|
| Total organic sessions | WoW | -15% | -30% | -50% |
| Total organic sessions | DoD | -25% (weekday) | -40% | Site appears down |
| Non-brand sessions | WoW | -20% | -35% | -50% |
| Organic conversions | WoW | -20% | -40% | -60% |
| Organic revenue | WoW | -15% | -30% | -50% |
| Bounce rate | WoW | +10pp | +20pp | +30pp |
| Page-level traffic (top 10 pages) | WoW | -25% | -40% | -60% |

**Note:** Day-over-day traffic thresholds need day-of-week adjustment. Monday traffic typically differs from Saturday traffic. Compare Monday to Monday, not Monday to Sunday.

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
| LCP (mobile) | Moves to "Needs Improvement" | Moves to "Poor" | >6s |
| CLS | >0.1 | >0.25 | >0.5 |
| INP | >200ms | >500ms | >1000ms |
| Robots.txt change | Any unexpected edit | Pages blocked | Entire site blocked |
| Sitemap errors | New errors | Sitemap inaccessible | Sitemap returning 5xx |

### Backlink Thresholds

| Metric | Warning | Critical |
|--------|---------|----------|
| Referring domains lost (weekly) | >5% of total | >15% of total |
| High-authority link lost (DR 60+) | Any loss | Loss of 3+ in one week |
| Toxic link spike | >10 new toxic links/week | >50 new toxic links/week |
| Anchor text over-optimization | Exact match reaches 20% | Exact match reaches 30% |
| Negative SEO pattern | Unusual link velocity from low-DR sites | Massive spam link spike |

### GEO / AI Visibility Thresholds

All GEO/AI thresholds run on a **weekly check window**. The values below are tunable operational defaults, not measured constants — start here, then calibrate against the site's own citation baseline (Section 1).

| Metric | Warning | Critical |
|--------|---------|----------|
| AI citation rate | Down 10+ percentage points vs. baseline | Below a 10% absolute floor |
| Priority-1 citation loss | Any priority-1 query loses its citation | 3+ priority-1 queries lose citations in one window |
| Citation position (within the answer) | Worsens by 2+ slots | Dropped from the answer entirely |
| Competitor gains citation you lost | 1 instance | Pattern across queries |

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

**Optional statistical ladder:** once enough weekly citation history exists for a stable mean and standard deviation (8+ weeks — see the Section 1 baseline periods), the Section 2 standard-deviation method may replace the fixed defaults for citation metrics: deviations from the baseline mean at 1 / 1.5 / 2 / 3 standard deviations map to Info / Warning / Critical / Emergency. This is a statistical option that requires sufficient history, not a requirement — with thin history the fixed defaults above are safer.

**Response path:** every citation-loss alert (rate, priority-1, or position) hands the affected query and its source page to content-refresher's AI Overview recovery playbook.

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

### Routing Matrix

| Alert Category | P0 (Emergency) | P1 (Urgent) | P2 (Important) | P3 (Monitor) |
|---------------|----------------|-------------|----------------|--------------|
| **Traffic** | SEO Lead + Eng Manager + VP | SEO Lead + Marketing Mgr | SEO Team | Weekly digest |
| **Rankings** | SEO Lead + Content Lead | SEO Team | SEO Team | Weekly digest |
| **Technical** | SEO Lead + Eng Lead + DevOps | SEO Lead + Eng Team | SEO Team + Eng | Weekly digest |
| **Backlinks** | SEO Lead | SEO Team | SEO Team | Weekly digest |
| **Competitor** | N/A | SEO Lead | SEO Team | Weekly digest |
| **GEO/AI** | SEO Lead + Content Lead | SEO Team | SEO Team | Weekly digest |
| **Security** | SEO Lead + Eng Manager + VP + Legal | All above | N/A | N/A |

### Role-Based Alert Filtering

| Role | Receives | Does Not Receive |
|------|---------|-----------------|
| SEO Lead | All P0, P1, P2 alerts | P3 (weekly digest only) |
| SEO Analyst | P1, P2 in their area | P0 (escalation only), other areas |
| Content Lead | P0-P1 ranking + GEO alerts | Technical alerts, backlink alerts |
| Engineering Lead | P0-P1 technical alerts | Ranking, content, backlink alerts |
| Marketing VP | P0 only | P1-P3 (receives weekly summary) |
| DevOps | P0 technical + security | All non-infrastructure alerts |

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
| Threshold breached | Yes | "Dropped >=5 positions" |
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

**Trigger:** Organic traffic drops >=50% day-over-day

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

### Playbook: Core Web Vitals Degradation (P1-P2)

**Trigger:** Any CWV metric moves from "Good" to "Needs Improvement" or "Poor"

**Priority:** the trigger spans two bands, so it spans two clocks. A move to "Needs Improvement" is
the Warning band — **P2**, within 48 hours. A move to "Poor" is the Critical band — **P1**,
acknowledged within 4 hours and resolved the same day, which is the templates' "Core Web Vitals
Fail" row. The steps below are the same either way; only the clock changes.

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
