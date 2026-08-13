---
name: alert-manager
version: "4.3.2"
description: 'Set up automated monitoring and notifications for SEO ranking drops, traffic changes, technical issues, and competitor movements. Use when the user asks to "set up SEO alerts", "notify me when rankings drop", "traffic alerts", "watch competitor changes", "alert me if rankings drop", "notify me of traffic changes", "monitor rankings", or "watch my keywords for changes". For detailed rank analysis, see rank-tracker. For comprehensive reporting, see performance-reporter.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.2"
  geo-relevance: "low"
  tags:
    - seo
    - geo
    - alerts
    - monitoring
    - ranking alerts
    - traffic monitoring
    - competitor alerts
    - seo notifications
    - proactive monitoring
    - seo-monitoring
    - ranking-drop-alert
    - traffic-drop-alert
    - technical-monitoring
    - seo-alerts
    - automated-monitoring
    - threshold-alerts
    - anomaly-detection
  triggers:
    - "set up SEO alerts"
    - "monitor rankings"
    - "notify me when rankings drop"
    - "traffic alerts"
    - "watch competitor changes"
    - "alert me"
    - "ranking notifications"
    - "alert me if rankings drop"
    - "notify me of traffic changes"
    - "watch my keywords for changes"
---

# Alert Manager


Sets up proactive monitoring alerts for critical SEO and GEO metrics. Triggers notifications when rankings drop, traffic changes significantly, technical issues occur, or competitors make moves.

## When to Use This Skill

- Setting up SEO monitoring systems
- Creating ranking drop alerts
- Monitoring technical SEO health
- Tracking competitor movements
- Alerting on content performance changes
- Monitoring GEO/AI visibility changes
- Setting up brand mention alerts

## What This Skill Does

1. **Alert Configuration**: Sets up custom alert thresholds
2. **Multi-Metric Monitoring**: Tracks rankings, traffic, technical issues
3. **Threshold Management**: Defines when alerts trigger
4. **Priority Classification**: Gives every alert a threshold band (how far the metric moved) and a response priority P0-P3 (who is notified, how fast)
5. **Notification Setup**: Configures how alerts are delivered
6. **Alert Response Plans**: Creates action plans for each alert type
7. **Alert History**: Tracks alert patterns over time

## How to Use

### Set Up Alerts

```
Set up SEO monitoring alerts for [domain]
```

```
Create ranking drop alerts for my top 20 keywords
```

### Configure Specific Alerts

```
Alert me when [specific condition]
```

```
Set up competitor monitoring for [competitor domains]
```

### Review Alert System

```
Review and optimize my current SEO alerts
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~search console + ~~web crawler connected:**
Automatically monitor real-time metric feeds for ranking changes via ~~SEO tool API, indexing and coverage alerts from ~~search console, and technical health alerts from ~~web crawler. Set up automated threshold-based alerts with notification delivery.

**With manual data only:**
Ask the user to provide:
1. Current baseline metrics for alert thresholds (rankings, traffic, backlinks)
2. Critical keywords or pages to monitor
3. Alert priority levels and notification preferences
4. Historical data to understand normal fluctuation ranges
5. Manual reporting on metric changes when they check their tools

Proceed with the alert configuration using provided parameters. User will need to manually check metrics and report changes for alert triggers.

## Instructions

When a user requests alert setup:

1. **Define Alert Categories**

   ```markdown
   ## SEO Alert System Configuration
   
   **Domain**: [domain]
   **Configured Date**: [date]
   
   ### Alert Categories
   
   | Category | Description | Typical Priority |
   |----------|-------------|------------------|
   | Ranking Alerts | Keyword position changes | P1-P2 |
   | Traffic Alerts | Organic traffic fluctuations | P1 |
   | Technical Alerts | Site health issues | P0 |
   | Backlink Alerts | Link profile changes | P2 |
   | Competitor Alerts | Competitor movements | P2-P3 |
   | GEO Alerts | AI visibility changes | P2 |
   | Brand Alerts | Brand mentions and reputation | P2 |
   ```
   
   Typical, not automatic: each individual alert gets its own priority in step 2, and the
   category row is only where to start.

2. **Configure Alert Rules by Category**

   For each relevant category (Rankings, Traffic, Technical, Backlinks, Competitors, GEO/AI, Brand), define alert name, trigger condition, threshold, band, and priority.

   **Two labels per alert, and they are different axes.** The **threshold band** — Info ·
   Warning · Critical · Emergency — says how far the metric moved from its own baseline, and
   comes from the data (1 / 1.5 / 2 / 3 standard deviations, or the percentage and absolute
   tables in the threshold guide). The **response priority** — P0 · P1 · P2 · P3 — says who is
   notified, through which channel, how fast, and comes from the business. Default map:
   Emergency → P0 · Critical → P1 · Warning → P2 · Info → P3; an alert placed above or below its
   default names the reason in the same line ("P1 — raised from P2: priority-1 query set").
   Standing overrides: security issues and manual actions are P0 on any detection, and alerts on
   the priority-1 / Tier-1 keyword set rise one level. Do not grade alerts "High / Medium / Low" —
   that was a third name for the P-axis whose "Critical" collided with the Critical band, one word
   grading a metric in one table and a pager rota in the next. **One observation is graded once**:
   where two rows could fire on the same event, grade it on the row that names it most specifically
   and say which — two rows firing on one event is how a whole band becomes unreachable.

   > **Reference**: See [references/alert-configuration-templates.md](./references/alert-configuration-templates.md) for complete alert tables, threshold examples, and response plan templates for all 7 categories.

3. **Define Alert Response Plans**

   Map each priority (P0 Emergency, P1 Urgent, P2 Important, P3 Monitor) to its response clock and immediate action steps — one clock per priority, never per band.

4. **Set Up Alert Delivery**

   Configure notification channels (Email, SMS, Slack), recipient routing by role, suppression rules (duplicate cooldown, maintenance windows), and escalation paths.

5. **Create Alert Summary**

    ```markdown
    # SEO Alert System Summary
    
    **Domain**: [domain]
    **Configured**: [date]
    **Total Active Alerts**: [X] — the bottom-right cell of the table below, not a separately
    kept number
    
    ## Alert Count by Category
    
    | Category | P0 | P1 | P2 | P3 | Total |
    |----------|----|----|----|----|-------|
    | Rankings | [X] | [X] | [X] | [X] | [X] |
    | Traffic | [X] | [X] | [X] | [X] | [X] |
    | Technical | [X] | [X] | [X] | [X] | [X] |
    | Backlinks | [X] | [X] | [X] | [X] | [X] |
    | Competitors | [X] | [X] | [X] | [X] | [X] |
    | GEO | [X] | [X] | [X] | [X] | [X] |
    | Brand | [X] | [X] | [X] | [X] | [X] |
    | **Total** | **[X]** | **[X]** | **[X]** | **[X]** | **[X]** |
    
    Every alert is counted once, in exactly one cell: each row's Total is the sum of its four
    priority cells, each column's Total is the sum of its seven category cells, and both totals
    meet at the same bottom-right figure. Recount the table against the alert definitions above
    it before sending — a summary that does not add up is the first thing a client checks.
    
    ## Quick Reference
    
    ### If You Get a P0 Alert
    
    1. Don't panic
    2. Check alert details
    3. Follow response plan
    4. Document actions taken
    5. Update stakeholders
    
    ### Weekly Alert Review Checklist
    
    - [ ] Review all alerts triggered
    - [ ] Identify patterns
    - [ ] Adjust thresholds if needed
    - [ ] Update response plans
    - [ ] Clean up false positives
    ```

## Validation Checkpoints

### Input Validation
- [ ] Alert thresholds are based on realistic baseline data
- [ ] Priority-1 keywords and pages clearly identified (one list, shared with the Tier-1 ranking set)
- [ ] Response plans defined for each priority P0-P3
- [ ] Notification channels configured with appropriate recipients

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Alert thresholds account for normal metric fluctuations
- [ ] Response plans are specific and time-bound
- [ ] Every alert carries both labels — the threshold band it fires at (Info / Warning / Critical / Emergency, or "no band — boundary alert") and its response priority (P0-P3) — with no third vocabulary anywhere in the configuration
- [ ] Any priority above or below the band's default map states its reason in the same line. Where the threshold guide defines no ladder for the metric (all brand rows, all competitor-activity rows), "no band — boundary alert" is the correct Band entry and no reason clause is owed — with no band there is no default to depart from, and the Band cell is what says so
- [ ] Roles are drawn from the one role list (threshold guide Section 4) and each is mapped to a named person; no role in a live routing table is unfilled
- [ ] Any threshold derived from a baseline shows the arithmetic: the mean, the standard deviation, the multiple used, and the resulting value (e.g. `8,800 = 10,000 − 1.5 × 800`)
- [ ] The alert-count table adds up both ways and its bottom-right cell equals the stated Total Active Alerts
- [ ] Any alert-effectiveness figure (false-positive rate, MTTA, MTTR) prints its two counts and its window, reported per priority rather than pooled
- [ ] Source of each alert trigger stated in the configuration's own words — the resolved tool name (an Ahrefs API alert, a Search Console notification, a Screaming Frog alert) or "manual user check"; where no tool is connected, the configuration says exactly that and the alert is not written up as automated. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

**User**: "Set up ranking drop alerts for my top keywords"

**Output**:

```markdown
## Ranking Alert Configuration

### Priority-1 Keywords (P1 — same day)

| Keyword | Current | Alert If | Band reached | Priority |
|---------|---------|----------|--------------|----------|
| best project management software | 2 | Drops to 5+ (drop >=3) | Warning — Tier 1 warns at >=3 | 🟠 P1 |
| project management tools | 4 | Drops to 8+ (drop >=4) | Warning — Tier 1 warns at >=3 | 🟠 P1 |
| team collaboration software | 1 | Any drop from #1 | Warning — brand/#1 rule | 🟠 P1 |

Warning band defaults to P2; all three are raised one level because they are priority-1 money
terms. A drop of 5+ on any of them reaches the **Critical** band, which under the same override
fires as **P0** — page, do not queue.

### Wider Tracked Set (P2 — 48 hours)

| Keyword | Current | Alert If | Band reached | Priority |
|---------|---------|----------|--------------|----------|
| agile project management | 7 | Drops out of top 10 (drop >=4) | none — page-1 boundary | 🟡 P2 |
| kanban software | 9 | Drops out of top 10 (drop >=2) | none — page-1 boundary | 🟡 P2 |

These two fire on losing page 1, not on a variance move: a 2-position slip from #9 reaches no
Tier-2 band (that table warns at >=5), so the Band column says so rather than borrowing a band the
trigger never reaches. Colour follows the priority, one marker per level — 🔴 P0 · 🟠 P1 · 🟡 P2 ·
🟢 P3 — because two levels sharing a red dot is a legend nobody can read.

### Alert Response Plan

**If a priority-1 keyword drops (P1 — acknowledge within 4 h, resolved same day)**:
1. Check if page is still indexed (site:url)
2. Look for algorithm update announcements
3. Analyze what changed in SERP
4. Review competitor ranking changes
5. Check for technical issues on page
6. Create recovery action plan within 24 hours

**Notification**: Email + Slack to SEO team immediately
```

## Tips for Success

1. **Start simple** - Don't create too many alerts initially
2. **Tune thresholds** - Adjust based on normal fluctuations
3. **Avoid alert fatigue** - Too many alerts = ignored alerts
4. **Document response plans** - Know what to do when alerts fire
5. **Review regularly** - Alerts need maintenance as your SEO matures
6. **Include positive alerts** - Track wins, not just problems

## Alert Threshold Quick Reference

Both columns are **threshold bands** — how far the metric moved — not priorities. Read the priority
off the default map (Emergency → P0 · Critical → P1 · Warning → P2 · Info → P3) plus any override
the alert definition states, and remember these are generic defaults: a site whose own measured
variance is tighter than -15% WoW should be alerting sooner than this table says.

| Metric | Warning band | Critical band | Frequency |
|--------|--------------|---------------|-----------|
| Organic traffic (WoW) | -15% | -30% (Emergency -50%) | Daily |
| Organic CTR | 1.5 sd below the site's own CTR mean | 2 sd below | Weekly |
| Keyword positions (Tier 1) | Drop >=3 | Drop >=5 | Daily |
| Pages indexed (index coverage) | -5% change | -15% change | Weekly |
| Crawl errors | >10 new/day | >50 new/day | Daily |
| Server 5xx errors | >1/day | >5/day (Emergency >20/day) | Daily |
| Core Web Vitals | "Needs Improvement" | "Poor" | Weekly |
| Backlinks lost | >5% in 1 week | >15% in 1 week | Weekly |
| AI citation rate | Down 10+ pp vs. baseline | Below 10% absolute floor | Weekly |
| AI citation loss (priority-1) | 1 priority-1 query loses its citation, i.e. is dropped from the answer entirely | 3+ priority-1 queries lose citations | Weekly |
| AI citation position | Worsens by 2+ slots, citation retained | not graded here — a citation that leaves the answer is a loss, graded on the row above | Weekly |
| Security issues | Any detected | Any detected | Daily |

Tier 2 keywords warn at a drop >=5 and turn Critical at >=10; Tier 3 warns at >=10. Day-over-day
traffic runs on its own ladder, not the weekly one above (-25% weekday Warning, -40% Critical, -50%
Emergency). The full tier table, the Emergency column, and the ladders for every metric not listed
here are in the threshold guide, which holds **one ladder per metric** — this table quotes that
ladder and never sets a different value, a different unit, or a different comparison period.

**AI citation event alerts** (same weekly window): a citation **won** on a tracked query is logged as a positive, informational alert (Info band, P3); an **AI Overview appearing or disappearing** on a tracked query is a Warning-band event at **P2** — either direction reshapes the click landscape for that query.

**Priority-1 queries** are the client-critical keywords captured during alert setup (the critical-keywords intake, Data Sources item 2): money terms, brand terms, and top-converting queries. This is the same set the threshold guide calls "Tier 1" — maintain one list, not two.

**Response path**: when any citation-loss alert fires (rate, priority-1, or position), hand the affected query and its source page to [content-refresher](../../optimize/content-refresher/) and run its AI Overview recovery playbook. All AI-citation thresholds above are tunable operational defaults, not measured constants — calibrate them against the site's own baseline per the threshold guide.

### Three defaults, so two runs on the same data land on the same numbers

"Calculate the standard deviation" leaves choices open that move every threshold built on it. These
are the defaults; depart from one only with a reason in the same line, and either way say which you
used. Full working in the threshold guide, §1 "Three method choices".

1. **Sample standard deviation (n − 1)** — a spreadsheet's `STDEV` / `STDEV.S`. A baseline is a
   sample of an ongoing process, not a closed population, so this is the estimator; it is also the
   larger of the two, erring towards wider bands rather than false positives. The two forms differ
   by √(n/(n−1)) — about 12% at n = 5, 2% at n = 28 — so the choice moves every bound most on the
   short baselines a new configuration has. Use the population form only where the recorded values
   really are the whole population, and say so.
2. **Split weekday and weekend baselines** before pooling them, for any daily metric with a weekly
   cycle. Pooled, the standard deviation carries the weekday/weekend gap as if it were noise — it
   measures the calendar rather than the variance — so every band widens with it: a genuinely bad
   Tuesday sits inside the everyday range while an ordinary Saturday grades as an anomaly. Pool only
   if the weekend mean falls inside the weekday baseline's `|z| < 1` range. Name the population
   beside every mean and every standard deviation.
3. **CTR has no benchmark in this skill.** Its bands come from the site's own CTR baseline on the
   same standard-deviation ladder. There is no industry, vertical or "typical e-commerce" CTR figure
   anywhere in this library, and none may be supplied from memory when a client asks whether their
   CTR is normal: say there is no baseline yet, say what would supply it, and leave the number out.
   Read every CTR alert with its clicks and impressions beside it — CTR can rise while clicks fall,
   when impressions fall faster — and segment brand from non-brand before alerting on a site-wide
   mean.

> **Reference**: See [references/alert-threshold-guide.md](./references/alert-threshold-guide.md) for baseline establishment, threshold setting methodology, fatigue prevention, escalation paths, and response playbooks.

## Reference Materials

- [Alert Threshold Guide](./references/alert-threshold-guide.md) — Recommended thresholds by metric, fatigue prevention strategies, and escalation path templates
- [Alert Configuration Templates](./references/alert-configuration-templates.md) — Ready-to-use alert definitions per monitoring category, incl. the GEO/AI citation set

## Related Skills

- [rank-tracker](../rank-tracker/) — Ranking data for alerts
- [backlink-analyzer](../backlink-analyzer/) — Backlink monitoring
- [technical-seo-checker](../../optimize/technical-seo-checker/) — Technical monitoring
- [performance-reporter](../performance-reporter/) — Alert summaries in reports
- [memory-management](../../cross-cutting/memory-management/) — Store alert history and thresholds in project memory
- [content-refresher](../../optimize/content-refresher/) — Content decay and AI-citation-loss alerts trigger refresh workflows (AI Overview recovery playbook)

