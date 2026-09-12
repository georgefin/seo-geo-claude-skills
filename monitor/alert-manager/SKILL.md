---
name: alert-manager
version: "4.6.0"
description: 'Set up automated monitoring and notifications for SEO ranking drops, traffic changes, technical issues, and competitor movements. Use when the user asks to "set up SEO alerts", "notify me when rankings drop", "traffic alerts", "watch competitor changes", "alert me if rankings drop", "notify me of traffic changes", "monitor rankings", or "watch my keywords for changes". For detailed rank analysis, see rank-tracker. For comprehensive reporting, see performance-reporter.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.6.0"
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
    - ai-visibility-alerts
    - prompt-level-monitoring
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
    - "alert me if we stop appearing in AI answers"
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

```
Set up SEO monitoring alerts for [domain]
Create ranking drop alerts for my top 20 keywords
Alert me when [specific condition]
Set up competitor monitoring for [competitor domains]
Alert me if we stop appearing in AI answers for [topic]
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
   | GEO Alerts | AI answer and citation changes, measured at the prompt | P1-P2 |
   | Brand Alerts | Brand mentions and reputation (incl. answer sentiment) | P2 |
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

   **Prompt-level answer alerts, and the sampling rule they all depend on.** Ranking alerts watch a
   position in a list; these watch what an assistant *says* in a generated answer, and the unit is a
   **prompt**, not a keyword. Four rows sit beside the citation rows in the GEO category, each
   defined **per engine** and per prompt cluster: **brand absent from the answers** for a cluster's
   head prompts · **recommendation position drops** · **a competitor enters the answer set** ·
   **the cited URL flips to a non-owning property of the client's** — that last one a cannibalisation
   signal, whose fix is the ownership contest (`references/query-cluster-ownership.md` §5), so
   routing it to content work wastes the alert.

   **No prompt-level alert ever fires on a single capture — the whole category rests on this.**
   Generated answers vary between runs for the same prompt, on the same day, from the same location,
   so one capture is an *observation*, and an alert wired to one fires on that variation rather than
   on a change, every cycle, until the client mutes the channel and the rest of the alerts with it.
   Every condition above is therefore evaluated over **`k of N` repeat captures**: N ≥ 3 per prompt
   per engine per cycle, captured in one session, both numbers written into the alert — "named in 0
   of 3 captures", never "not named" — and **confirmed across two consecutive cycles** before it
   fires, since a `k of N` standing in one cycle is a candidate. Failed captures (refusal, rate
   limit, empty response) are logged with their reason and reduce N; dropping them turns a 1-of-1
   into 100%. A configuration that cannot run the repeats ships these rows **off** and says so.
   **Every threshold on the four rows is a proposed default awaiting the client's confirmation**,
   marked as such wherever written: none is a measured constant, and this skill already carries
   threshold rows waiting on the same decision (threshold guide, *Open threshold decisions*).

   **The existing Negative Mention alert is the sentiment field's alert path — one field, not two.**
   Sentiment is recorded once per captured answer, on the sentence carrying the brand rather than the
   answer overall (`references/ai-visibility-measurement.md` field 9, scored as CITE item C08), and
   the Negative Mention row in the Brand category fires on it. No second sentiment metric is defined
   here: a negative-sentiment answer is graded on that row, not also on a prompt-level row above —
   one observation, one row, as everywhere else in this skill.

   > **Reference**: See [references/alert-configuration-templates.md](./references/alert-configuration-templates.md) for complete alert tables, threshold examples, and response plan templates for all 7 categories — including the four prompt-level rows with their `k of N` conditions, bands and priorities.

3. **Define Alert Response Plans**

   Map each priority (P0 Emergency, P1 Urgent, P2 Important, P3 Monitor) to its response clock and immediate action steps — one clock per priority, never per band.

   **A response plan is an action, and it carries the seven fields.** Every plan this skill writes — and every remediation a review recommends — carries **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**, with fields 1-3 required and 4-7 taking a stated-absence value (`not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect`) rather than a blank or an invention. **The clock is not the criterion.** "Acknowledge within 4 hours, resolved same day" says how fast the response starts and how long it may take; it does not say what state means *resolved*, and at 2 a.m. that is the sentence that is missing. So every plan states its **resolution condition** in the same terms the alert fired in — "the 5xx rate is back under 1/day for two consecutive daily checks and the cause is recorded in the incident note", "the priority-1 query is back inside its Warning band and has held there across two checks" — observable, binary at the moment of checking, attached to the same metric and window the trigger used, and checkable six weeks later by someone who was not on the call. A plan whose steps are all diagnostic ("check indexing, review the SERP, analyse competitors") ends by naming what happens next in each branch; a diagnosis that resolves nothing is not a resolution condition. **No condition may require an engine to do something**: a restored position, a recovered citation or a return to an AI answer is nobody's to deliver, and writing one into a plan turns the alert into a promise (Output Validation, families 9 and 10). What a prompt-level plan is accepted on is the work shipped plus the `k of N` re-measured on the same protocol across the confirming cycle and recorded beside its baseline.

   **The owner field is the routing role — one vocabulary, not a second.** This skill already carries a closed role list mapped to named people (threshold guide Sec. 4: SEO Lead · SEO Analyst · SEO Team · Content Lead · Engineering Lead · Engineering Team · DevOps · Marketing Manager · Marketing VP · Legal), and the routing matrix already assigns one per category per priority. That assignment **is** the action contract's owner field, so read it off the routing table rather than introducing the library-wide role list beside it — a second list here would recreate exactly the defect this skill fixed when the templates file ran its own shorter list and named different recipients for the same alert. A role nobody holds is deleted from the routing table, not carried as an owner, and where a remediation leaves the alerting system entirely (handed to content or development work as a piece of project work) it takes the library-wide role list at that hand-off point. Field table, stated-absence values and the acceptance-criterion test in full: [Action Output Contract](../../references/action-output-contract.md).

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
    ```

    Append the summary's two closing blocks — the P0 quick-reference steps and the weekly alert
    review checklist — from [references/alert-configuration-templates.md](./references/alert-configuration-templates.md), "Alert summary closing blocks".

## Validation Checkpoints

### Input Validation
- [ ] Alert thresholds are based on realistic baseline data
- [ ] Priority-1 keywords and pages clearly identified (one list, shared with the Tier-1 ranking set)
- [ ] Response plans defined for each priority P0-P3
- [ ] Notification channels configured with appropriate recipients

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Alert thresholds account for normal metric fluctuations
- [ ] Response plans are specific and time-bound, and every plan carries all seven action fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`). The owner is the routing role already assigned in the routing matrix, from the one role list (threshold guide Sec. 4) — never a second role vocabulary introduced beside it
- [ ] Every plan states a **resolution condition** as well as its clock: observable, binary at the moment of checking, expressed in the same metric and window the alert fired on, and checkable by someone who was not on the call. "Acknowledge within 4 hours, resolved same day" is a clock, not a condition. An all-diagnostic plan names what happens next in each branch, and no condition requires an engine to do something — a prompt-level plan is accepted on the work shipped plus the `k of N` re-measured on the same protocol across the confirming cycle and recorded beside its baseline
- [ ] Every alert carries both labels — the threshold band it fires at (Info / Warning / Critical / Emergency, or "no band — boundary alert") and its response priority (P0-P3) — with no third vocabulary anywhere in the configuration
- [ ] Any priority above or below the band's default map states its reason in the same line. Where the threshold guide defines no ladder for the metric (all brand rows, all competitor-activity rows), "no band — boundary alert" is the correct Band entry and no reason clause is owed — with no band there is no default to depart from, and the Band cell is what says so
- [ ] No alert condition anywhere in the configuration can fire on a single capture of a generated answer: every prompt-level row states its `k of N` (N ≥ 3 repeats per prompt per engine per cycle) and its two-consecutive-cycle confirmation, and a configuration that cannot run the repeats ships those rows off and says so
- [ ] Prompt-level rows are defined per engine and per prompt cluster, never pooled across engines, and each fires on a prompt-set version that is named; failed captures are logged with their reason and reduce N rather than being dropped
- [ ] Every new prompt-level threshold is written as a **proposed default awaiting the client's confirmation** and is labelled as such in the configuration — no new AI-answer threshold ships as a settled number
- [ ] Sentiment is alerted once, on the Negative Mention row, from the recorded sentiment field — no second sentiment metric, and no negative-sentiment answer graded twice
- [ ] No alert, response plan or summary line promises a position, citation, inclusion, recommendation or share of voice on any AI surface, and none asserts what an engine does or prefers — an alert reports what the captures showed (anti-slop-ruleset.md §6 families 9 and 10)
- [ ] Roles are drawn from the one role list (threshold guide Section 4) and each is mapped to a named person; no role in a live routing table is unfilled
- [ ] Any threshold derived from a baseline shows the arithmetic: the mean, the standard deviation, the multiple used, and the resulting value (e.g. `8,800 = 10,000 − 1.5 × 800`)
- [ ] The alert-count table adds up both ways and its bottom-right cell equals the stated Total Active Alerts
- [ ] Any alert-effectiveness figure (false-positive rate, MTTA, MTTR) prints its two counts and its window, reported per priority rather than pooled
- [ ] A threshold fixed here or by a settled ruling — 4xx/5xx counts per day, SSL days to expiry,
  index coverage -5%/-15%, the tier drops, brand top-3, LCP 2.5s · INP 200ms · CLS 0.1 — is stated
  plainly with no tool connected and no data in hand; only a number describing *this* site (mean,
  standard deviation, normal range, expected position) is derived or absent, and a generic default
  is labelled as one. Withholding a settled figure is the same defect as inventing a baseline
- [ ] Every "N of M" lists its N and names both populations; nothing is called "named" that the source does not name; a quoted definition is
  quoted once, not re-glossed, and never overridden — the client's own file is the authority on its own notation, and a missing measurement is a
  gap in the data, not a measurement; an explanation the run has not verified is the leading explanation and never settled fact, above all where
  the same document prescribes the check that would settle it; a claim about what other sites do is labelled a generic assumption or cut; a handoff
  payload copies each identifier — domain, `www.` or not, scheme, path — exactly as the source wrote it (threshold guide Sec. 9)
- [ ] A row that never fired is diagnosed before it is tuned — dead metric (replace it), dead feed (rewire it), dead report (retire the alert), quiet
  guard (keep it); retiring an alert never becomes advice to remove the markup or page element it watched; and the review names the rows that are not
  there — no configuration ships without a site-availability row and the security / manual-action pair, or says why (threshold guide Section 6)
- [ ] Source of each alert trigger stated in the configuration's own words — the resolved tool name (an Ahrefs API alert, a Search Console notification, a Screaming Frog alert) or "manual user check"; where no tool is connected, the configuration says exactly that and the alert is not written up as automated. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

> **Reference**: See [references/alert-configuration-templates.md](./references/alert-configuration-templates.md) § Worked Example for a full ranking-alert configuration — five rows carrying both labels, the one-level override applied to the priority-1 money terms, the boundary-alert case where a page-1 trigger reaches no band at all, and the response plan that follows it.

## Tips for Success

> **Reference**: The six working rules — start simple, tune against the site's own variance, avoid alert fatigue, document response plans with an owner and a resolution condition, review regularly, include positive alerts — are in [references/alert-threshold-guide.md](./references/alert-threshold-guide.md) §10, each tied to the section of that guide which enforces it.

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
| LCP (field, mobile) | >2.5s — "Needs Improvement" | >4.0s — "Poor" | Weekly |
| INP (field, mobile) | >200ms — "Needs Improvement" | >500ms — "Poor" | Weekly |
| CLS (field, mobile) | >0.1 — "Needs Improvement" | >0.25 — "Poor" | Weekly |
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

**Core Web Vitals enter a configuration as three metrics with three numbers, never as one
status-banded row.** "Needs Improvement" *is* the number — LCP above 2.5 s — so word and figure are
one rung written twice, not two rows on one event, and both stay. **LCP ≤2.5s · INP ≤200ms · CLS
≤0.1** is settled (`docs/loop/SETTLED-RULINGS.md` R4, which also records the input-delay metric INP
replaced as retired in March 2024): fixed definitions owing no baseline, no connected feed and no
confirmation before they are written down. Ruling handles stay in operator notes; the client gets
the number.

**AI citation event alerts** (same weekly window): a citation **won** on a tracked query is logged as a positive, informational alert (Info band, P3); an **AI Overview appearing or disappearing** on a tracked query is a Warning-band event at **P2** — either direction reshapes the click landscape for that query.

**Priority-1 queries** are the client-critical keywords captured during alert setup (the critical-keywords intake, Data Sources item 2): money terms, brand terms, and top-converting queries. This is the same set the threshold guide calls "Tier 1" — maintain one list, not two.

**Response path**: when any citation-loss alert fires (rate, priority-1, or position), hand the affected query and its source page to [content-refresher](../../optimize/content-refresher/) and run its AI Overview recovery playbook. Copy the query string and the URL into that payload exactly as the client's own file wrote them — the receiving run pastes the payload, so an added `www.`, scheme or trailing slash sends it to a host nobody established (threshold guide Sec. 9.5). All AI-citation thresholds above are tunable operational defaults, not measured constants — calibrate them against the site's own baseline per the threshold guide.

### Three defaults, so two runs on the same data land on the same numbers

"Calculate the standard deviation" leaves choices open that move every threshold built on it. These
are the defaults; depart from one only with a reason in the same line, and either way say which you
used. Full working in the threshold guide, §1 "Three method choices".

1. **Sample standard deviation (n − 1)** — a spreadsheet's `STDEV` / `STDEV.S`. A baseline is a
   sample of an ongoing process, not a closed population, so this is the estimator, and it is the
   larger of the two, erring towards wider bands rather than false positives. Use the population
   form only where the recorded values really are the whole population, and say so.
2. **Split weekday and weekend baselines** before pooling them, for any daily metric with a weekly
   cycle. Pooled, the standard deviation measures the calendar rather than the variance and every
   band widens with it. Pool only if the weekend mean falls inside the weekday baseline's `|z| < 1`
   range. Name the population beside every mean and every standard deviation.
3. **CTR has no benchmark in this skill.** Its bands come from the site's own CTR baseline on the
   same standard-deviation ladder. There is no industry, vertical or "typical e-commerce" CTR figure
   anywhere in this library, and none may be supplied from memory when a client asks whether their
   CTR is normal: say there is no baseline yet, say what would supply it, and leave the number out.
   Read every CTR alert with its clicks and impressions beside it — CTR can rise while clicks fall,
   when impressions fall faster — and segment brand from non-brand before alerting on a site-wide
   mean.

> **Reference**: See [references/alert-threshold-guide.md](./references/alert-threshold-guide.md) for baseline establishment, threshold setting methodology, fatigue prevention, escalation paths, and response playbooks.

## Reference Materials

- [Alert Threshold Guide](./references/alert-threshold-guide.md) — Recommended thresholds by metric (fixed absolutes vs. baseline-derived), fatigue prevention, escalation paths, the never-fired-row triage and the absent-row pass beside it (Sec. 6), the write-up rules for counts, quotes, generics, payloads and unverified explanations (Sec. 9), and the prompt-level answer thresholds with their sampling rule and their four open decisions
- [Alert Configuration Templates](./references/alert-configuration-templates.md) — Ready-to-use alert definitions per monitoring category, incl. the site-integrity floor coverage a review adds where an estate has none, the GEO/AI citation set, the four prompt-level answer rows with their `k of N` conditions, and the alert-summary closing blocks
- [AI Visibility Measurement](../../references/ai-visibility-measurement.md) — library-wide: the prompt as the unit, the twelve recorded fields (sentiment is field 9), the N >= 3 sampling protocol these alerts are built on, and what may never be promised (§7)
- [Action Output Contract](../../references/action-output-contract.md) — library-wide: the seven fields every response plan and remediation carries, their stated-absence values, and the acceptance-criterion test that separates a resolution condition from a response clock. Its role list governs a remediation handed out of the alerting system; inside a configuration the owner is the routing role from threshold guide Sec. 4

## Related Skills

- [rank-tracker](../rank-tracker/) — Ranking data for alerts
- [backlink-analyzer](../backlink-analyzer/) — Backlink monitoring
- [technical-seo-checker](../../optimize/technical-seo-checker/) — Technical monitoring
- [performance-reporter](../performance-reporter/) — Alert summaries in reports
- [memory-management](../../cross-cutting/memory-management/) — Store alert history and thresholds in project memory
- [content-refresher](../../optimize/content-refresher/) — Content decay and AI-citation-loss alerts trigger refresh workflows (AI Overview recovery playbook)

