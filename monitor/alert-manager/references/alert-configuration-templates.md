# Alert Configuration Templates

Detailed alert configuration templates for each alert category. Use these templates when setting up a new alert system for a domain.

**The Priority column is P0-P3 throughout** — the response-priority axis (who is notified, through
which channel, how fast), defined with its response clock in
[alert-threshold-guide.md](./alert-threshold-guide.md) Section 4. It is not the threshold band
(Info / Warning / Critical / Emergency), which says how far the metric moved and is set from the
data in Sections 2-3 of that guide. Default map: Emergency → P0 · Critical → P1 · Warning → P2 ·
Info → P3, and an alert placed above or below its default carries the reason beside it. Positive,
informational and opportunity alerts are P3 with the kind in brackets — they still need a priority,
because the priority is what decides delivery.

---

## Ranking Alerts

### Position Drop Alerts

| Alert Name | Condition | Threshold | Priority | Action |
|------------|-----------|-----------|----------|--------|
| Critical Drop | Any top 3 keyword drops 5+ positions | Position change >=5 | P0 | Immediate investigation |
| Major Drop | Top 10 keyword drops out of top 10 | Position >10 | P1 | Same-day review |
| Moderate Drop | Any keyword drops 10+ positions | Position change >=10 | P2 | Weekly review |
| Competitor Overtake | Competitor passes you for key term | Comp position < yours | P2 | Analysis needed |

### Position Improvement Alerts

| Alert Name | Condition | Threshold | Priority |
|------------|-----------|-----------|----------|
| New Top 3 | Keyword enters top 3 | Position <=3 | P3 (positive) |
| Page 1 Entry | Keyword enters top 10 | Position <=10 | P3 (positive) |
| Significant Climb | Keyword improves 10+ positions | Change >=+10 | P3 (positive) |

### SERP Feature Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Snippet Lost | Lost featured snippet ownership | P1 |
| Snippet Won | Won new featured snippet | P3 (positive) |
| AI Overview Change | Appeared/disappeared in AI Overview | P2 |

### Keywords to Monitor

| Keyword | Current Rank | Alert Threshold | Priority |
|---------|--------------|-----------------|----------|
| [keyword 1] | [X] | Drop >=3 | P0 |
| [keyword 2] | [X] | Drop >=5 | P1 |
| [keyword 3] | [X] | Drop >=10 | P2 |

---

## Traffic Alerts

### Traffic Decline Alerts

| Alert Name | Condition | Threshold | Priority |
|------------|-----------|-----------|----------|
| Traffic Crash | Day-over-day decline | >=50% drop | P0 |
| Significant Drop | Week-over-week decline | >=30% drop | P1 |
| Moderate Decline | Month-over-month decline | >=20% drop | P2 |
| Trend Warning | 3 consecutive weeks decline | Any decline | P2 |

### Traffic Anomaly Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Traffic Spike | Unusual increase | P2 |
| Zero Traffic | Page receiving 0 visits | P1 |
| Bot Traffic | Unusual traffic pattern | P2 |

### Page-Level Alerts

| Page Type | Alert Condition | Priority |
|-----------|-----------------|----------|
| Homepage | Any 20%+ decline | P0 |
| Top 10 pages | Any 30%+ decline | P1 |
| Conversion pages | Any 25%+ decline | P1 |
| Blog posts | Any 40%+ decline | P2 |

### Conversion Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Conversion Drop | Organic conversions down 30%+ | P0 |
| CVR Decline | Conversion rate drops 20%+ | P1 |

---

## Technical SEO Alerts

### Site-Integrity Alerts (P0-P1)

| Alert Name | Condition | Band | Priority | Response Time |
|------------|-----------|------|----------|---------------|
| Site Down | HTTP 5xx errors | Emergency | P0 | Acknowledge <15 min, action within 1 h |
| SSL Expiry | Certificate expiring in 14 days | Warning | P1 | Same day |
| Robots.txt Block | Important pages blocked | Critical | P1 | Same day |
| Index Dropped | Pages dropping from index | Critical | P1 | Same day |

SSL Expiry sits one level above its band's default (P2), and the reason travels with it: a
certificate that lapses takes every page down at once, and the fix needs a same-day human. The
other three rows take the default map unchanged.

### Crawl & Index Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Crawl Errors Spike | Errors increase 50%+ | P1 |
| New 404 Pages | 404 errors on important pages | P2 |
| Redirect Chains | 3+ redirect hops detected | P2 |
| Duplicate Content | New duplicates detected | P2 |
| Index Coverage Drop | Indexed pages decline 10%+ | P1 |

### Performance Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Core Web Vitals Fail | CWV drops to "Poor" | P1 |
| Page Speed Drop | Load time increases 50%+ | P2 |
| Mobile Issues | Mobile usability errors | P1 |

### Security Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Security Issue | GSC security warning | P0 |
| Manual Action | Google manual action | P0 |
| Malware Detected | Site flagged for malware | P0 |

---

## Backlink Alerts

### Link Loss Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| High-Value Link Lost | DA 70+ link removed | P1 |
| Multiple Links Lost | 10+ links lost in a day | P2 |
| Referring Domain Lost | Lost entire domain's links | P2 |

### Link Gain Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| High-Value Link | New DA 70+ link | P3 (positive) |
| Suspicious Links | Many low-quality links | P2 |
| Negative SEO | Spam link attack pattern | P1 |

### Link Profile Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Toxic Score Increase | Toxic score up 20%+ | P1 |
| Anchor Over-Optimization | Exact match anchors >30% | P2 |

---

## Competitor Monitoring Alerts

### Ranking Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Competitor Overtake | Competitor passes you | P2 |
| Competitor Top 3 | Competitor enters top 3 on key term | P2 |
| Competitor Content | Competitor publishes on your topic | P3 (info) |

### Activity Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| New Backlinks | Competitor gains high-DA link | P3 (info) |
| Content Update | Competitor updates ranking content | P3 (info) |
| New Content | Competitor publishes new content | P3 (info) |

### Competitors to Monitor

| Competitor | Domain | Monitor Keywords | Alert Priority |
|------------|--------|------------------|----------------|
| [Competitor 1] | [domain] | [X] keywords | P1 |
| [Competitor 2] | [domain] | [X] keywords | P2 |
| [Competitor 3] | [domain] | [X] keywords | P3 |

---

## GEO (AI Visibility) Alerts

All GEO alerts use a weekly check window; thresholds are tunable operational defaults (see the threshold guide).

### AI Citation Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Priority-1 Citation Lost | Any priority-1 query loses its citation | P1 |
| Priority-1 Loss Cluster | 3+ priority-1 queries lose citations in one window | P0 |
| Citation Position Slip | Position within the AI answer worsens by 2+ slots | P2 |
| Dropped From Answer | Removed from the AI answer entirely | P1 |
| Citation Won | New citation gained on a tracked query | P3 (positive) |
| AI Overview Change | AI Overview appears or disappears on a tracked query | P2 |

### GEO Trend Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Citation Rate Slide | Citation rate down 10+ percentage points vs. baseline | P1 |
| Citation Rate Floor | Citation rate below 10% absolute | P0 |
| GEO Competitor | Competitor cited where you're not | P2 |

**Priorities above the default, with their reason**: the four rows on the priority-1 query set —
Citation Lost (P1, band Warning), Loss Cluster (P0, band Critical), Rate Slide (P1, band Warning)
and Rate Floor (P0, band Critical) — each sit one level above the default map because that set is
the client's money, brand and top-converting terms. Position Slip, AI Overview Change and GEO
Competitor take the default.

**Response plan**: citation-loss alerts (loss, position, rate) hand the affected query and page to content-refresher's AI Overview recovery playbook. Priority-1 = the client-critical keywords from alert setup (money, brand, top-converting terms).

---

## Brand Monitoring Alerts

### Mention Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Brand Mention | New brand mention online | P3 (info) |
| Negative Mention | Negative sentiment mention | P1 |
| Review Alert | New review on key platforms | P2 |
| Unlinked Mention | Brand mention without link | P3 (opportunity) |

### Reputation Alerts

| Alert Name | Condition | Priority |
|------------|-----------|----------|
| Review Rating Drop | Average rating drops | P1 |
| Negative Press | Negative news article | P1 |
| Competitor Comparison | Named in competitor comparison | P2 |

---

## Alert Response Plans

One clock per priority, the same one the threshold guide's routing and SLA tables use. Response
times belong to the **priority**, never to the threshold band: a Critical-band metric on a P2
alert is still a 48-hour job.

### P0 — Emergency

**Response Time**: Acknowledge within 15 minutes, first action within 1 hour, target resolution 2 hours

| Alert Type | Immediate Actions |
|------------|-------------------|
| Site Down | 1. Check server status 2. Contact hosting 3. Check DNS |
| Traffic Crash | 1. Check for algorithm update 2. Review GSC errors 3. Check competitors |
| Manual Action | 1. Review GSC message 2. Identify issue 3. Begin remediation |
| Top-3 Keyword Drop (priority-1 set) | 1. Check if page indexed 2. Review SERP 3. Analyze competitors |

### P1 — Urgent

**Response Time**: Acknowledge within 4 hours, resolved same day

| Alert Type | Actions |
|------------|---------|
| Major Rank Drops | Analyze cause, create recovery plan |
| Traffic Decline | Investigate source, check technical issues |
| Backlink Loss | Attempt recovery outreach |
| CWV Failure | Diagnose and fix performance issues |

### P2 — Important

**Response Time**: Within 48 hours

| Alert Type | Actions |
|------------|---------|
| Moderate Rank Changes | Monitor trend, plan content updates |
| Competitor Movement | Analyze competitor changes |
| New 404s | Set up redirects, update internal links |

### P3 — Monitor

**Response Time**: Weekly review

| Alert Type | Actions |
|------------|---------|
| Positive Changes (wins, new citations, climbs) | Document wins, understand cause |
| Info and opportunity alerts | Log for trend analysis; work the opportunity queue in the weekly slot |

---

## Alert Notification Setup

### Notification Channels

Same channel ladder as the threshold guide Section 5 — one statement, not two.

| Priority | Primary | Secondary | Escalation |
|----------|---------|-----------|------------|
| P0 | SMS + phone call | Slack (#seo-emergencies) | On-call rotation |
| P1 | Slack (#seo-alerts) | Email | SMS if not acknowledged in 4 h |
| P2 | Email | Slack (#seo-daily) | Auto-escalate to P1 after 1 week |
| P3 | Weekly digest email | Dashboard | Auto-escalate to P2 after 1 month |

### Alert Recipients

| Role | P0 | P1 | P2 | P3 |
|------|----|----|----|----|
| SEO Manager | Yes | Yes | Yes | Digest |
| Dev Team | Yes | Yes (tech only) | No | No |
| Marketing Lead | Yes | Yes | No | No |
| Executive | Yes | No | No | Digest |

### Alert Suppression

- Suppress duplicate alerts for 24 hours
- Don't alert on known issues (maintenance windows)
- Batch P2/P3 alerts into digests

### Alert Escalation

| If No Response In | Escalate To |
|-------------------|-------------|
| 15 min (P0) | SEO Manager -> Director |
| 4 hours (P1) | Team Lead -> Manager |
| 48 hours (P2) | Team -> Lead |
