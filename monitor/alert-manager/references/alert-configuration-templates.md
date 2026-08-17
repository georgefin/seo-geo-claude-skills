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

**Both labels ship on every row.** These tables can only fix the priority in advance; the **band**
depends on a baseline this file has never seen, so it is filled in when the alert is configured. The
tables below that already show both columns are the finished shape. **When you copy any other table
into a configuration, add a Band column and fill every row** with one of two things:

- the band from the threshold guide's Section 2-3 ladder for that metric, or
- **"none — boundary alert"**, where the trigger is an event or a boundary rather than a distance
  from a baseline (losing page 1, a certificate expiring, a brand mention) — including every metric
  for which the guide defines no ladder at all, which is all of the brand rows and all of the
  competitor-activity rows.

The two are not interchangeable notes. Where there **is** a band, the default map fixes the
priority and any departure from it names its reason in the same line. Where there is **no** band,
there is no default to depart from: the priority is set directly from the business and owes no
"raised from" clause, and the Band cell saying "none — boundary alert" is what tells the next
reader why none follows. A row that reaches no band and still carries an unexplained off-default
priority is exactly the defect this rule exists to catch — SKILL.md's Output Validation checklist
fails a configuration that ships one.

---

## Ranking Alerts

### Position Drop Alerts

| Alert Name | Condition | Threshold | Band | Priority | Action |
|------------|-----------|-----------|------|----------|--------|
| Critical Drop | Any top 3 keyword drops 5+ positions | Position change >=5 | Critical (Tier 1) | P1 | Same-day investigation |
| Major Drop | Top 10 keyword drops out of top 10 | Position >10 | none — page-1 boundary | P1 | Same-day review |
| Moderate Drop | Any keyword drops 10+ positions | Position change >=10 | Warning (Tier 3) — Critical on a Tier-1 or Tier-2 keyword | P2 | Weekly review |
| Competitor Overtake | Competitor passes you for key term | Comp position < yours | none — boundary alert | P2 | Analysis needed |

Critical Drop takes the Critical band's default, **P1** — a drop of >=5 is Tier 1's Critical
trigger in the threshold guide's Ranking Thresholds table. Ranking in the top 3 is a *position*,
not a priority: it does not by itself put a keyword in the priority-1 / Tier-1 set. Where it does,
the standing override raises this same alert one level to **P0**, which is the "Top-3 Keyword Drop
(priority-1 set)" row in the P0 response plan below — it needs no separate line here. The other
three rows fire on a boundary or a count rather than on a band: Major Drop and Competitor Overtake
have no band to sit above or below, and Moderate Drop's >=10 is Tier 3's Warning trigger, so P2 is
that band's default. On a Tier-1 or Tier-2 keyword a drop of 10+ is already Critical — price it
from the tier table, not from this row.

### Position Improvement Alerts

| Alert Name | Condition | Threshold | Band | Priority |
|------------|-----------|-----------|------|----------|
| New Top 3 | Keyword enters top 3 | Position <=3 | none — boundary alert | P3 (positive) |
| Page 1 Entry | Keyword enters top 10 | Position <=10 | none — boundary alert | P3 (positive) |
| Significant Climb | Keyword improves 10+ positions | Change >=+10 | none — the guide's tier ladders grade drops, not gains | P3 (positive) |

### SERP Feature Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Snippet Lost (priority-1 query) | Featured snippet ownership lost on a priority-1 / Tier-1 query | Warning | P1 — raised from P2: priority-1 / Tier-1 set |
| Snippet Lost (other tracked query) | Featured snippet ownership lost | Warning | P2 |
| Snippet Lost (cluster) | 3 or more featured snippets lost | Critical | P1 |
| Snippet Won | Won new featured snippet | Info (positive) | P3 (positive) |
| AI Overview Change | Appeared/disappeared in AI Overview | Warning | P2 |

The inherited table had one **Snippet Lost** row at P1 with no band and no reason. The guide bands
this metric (any loss = Warning, loss of 3+ = Critical), so a single loss defaults to **P2** and the
only thing that lifted it was the standing priority-1 / Tier-1 override — which covers some tracked
queries and not others. Splitting the row by query set keeps the override where it belongs instead
of applying it to every query silently; the cluster row is the guide's Critical trigger, taking that
band's default.

### Keywords to Monitor

| Keyword | Current Rank | Alert Threshold | Band reached | Priority |
|---------|--------------|-----------------|--------------|----------|
| [keyword 1] | [X] | Drop >=3 | Warning — Tier 1 warns at >=3 | P1 — raised from P2: Tier-1 / priority-1 set |
| [keyword 2] | [X] | Drop >=5 | Warning — Tier 2 warns at >=5 | P2 |
| [keyword 3] | [X] | Drop >=10 | Warning — Tier 3 warns at >=10 | P2 |

Each threshold above is that tier's own Warning trigger, so all three rows are Warning band and
take **P2** by default. Only row 1 moves, by the standing Tier-1 / priority-1 override, and it says
so in its own cell — the reason has to travel when the row is copied. Set a threshold at the tier's
Critical trigger instead (Tier 1 >=5, Tier 2 >=10, Tier 3 off page 3) and the row becomes **P1** —
or **P0** on the Tier-1 line, under the same override.

---

## Traffic Alerts

### Traffic Decline Alerts

| Alert Name | Condition | Threshold | Band | Priority |
|------------|-----------|-----------|------|----------|
| Traffic Crash | Day-over-day decline | >=50% drop | Emergency | P0 |
| Significant Drop | Week-over-week decline | >=30% drop | Critical | P1 |
| Moderate Decline | Month-over-month decline | >=20% drop | none — the guide has no month-over-month traffic ladder | P2 |
| Trend Warning | 3 consecutive weeks decline | Any decline | none — boundary alert (a pattern over time, not a distance from a baseline) | P2 |

Traffic Crash's **P0 is the Emergency band's default, not an override**. The guide's day-over-day
Emergency trigger is a -50% drop — the same figure that fires its P0 organic-traffic-emergency
playbook. That cell used to read "site appears down", a description where the rest of the table
holds thresholds, so this row appeared to carry a P0 the band table could not produce. Significant
Drop's -30% week-over-week is that table's Critical trigger, so P1 is also a default. The bottom two
rows reach no band and their priority is therefore set directly, with nothing to be "raised from".

### Traffic Anomaly Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Traffic Spike | Unusual increase | from the standard-deviation ladder — deviation is unsigned, so a spike bands exactly like a drop | P2 |
| Zero Traffic | Page receiving 0 visits | none — boundary alert (an absolute floor, not a distance from a baseline) | P1 |
| Bot Traffic | Unusual traffic pattern | none — boundary alert | P2 |

### Page-Level Alerts

| Page Type | Alert Condition | Band | Priority |
|-----------|-----------------|------|----------|
| Homepage | Any 20%+ decline | none — comparison period unset (open decision) | P0 |
| Top 10 pages | Any 30%+ decline | none — comparison period unset (open decision) | P1 |
| Conversion pages | Any 25%+ decline | none — comparison period unset (open decision) | P1 |
| Blog posts | Any 40%+ decline | none — comparison period unset (open decision) | P2 |

All four are priced by **page importance**, not off the default map, and each move has its reason:
the homepage is raised because its decline is read as a site-level symptom rather than a page one,
the top-10 pages because they carry most of the traffic, conversion pages because they carry the
revenue; a single blog post is lowered because one post decaying is not an incident. None of these
rows states a comparison period, so no band can be read off them as written — set the period when
you configure them (the guide's page-level traffic bands run week over week: Warning -25%,
Critical -40%, Emergency -60%), and carry the reason clause with the row. Until the period is set,
these four rows are Band "none — boundary alert"; they are rows 3-6 of the guide's **Open threshold
decisions** list, which is where they stay until an operator picks the period rather than a
documentation pass picking one for them.

### Conversion Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Conversion Drop | Organic conversions down 30%+ (WoW) | Warning (guide: -20% Warning, -40% Critical) | P0 — raised two levels from P2: the money line, see the note |
| CVR Decline | Conversion rate drops 20%+ (WoW) | Warning (guide: -20% Warning, -40% Critical) | P1 — raised from P2: the money line, see the note |

Both sit above the default map, and the reason is the same: a conversion metric is the money line.
Read against the guide's bands (organic conversions WoW: Warning -20%, Critical -40%, Emergency
-60%; conversion rate: Warning -20%, Critical -40%) a 30% conversion drop and a 20% rate drop are
both **Warning**, whose default is P2 — so Conversion Drop is two levels up and CVR Decline one.
Keep the priority the business actually wants and keep this clause beside it; a two-level move is
worth re-checking against your own baseline before it goes into production.

---

## Technical SEO Alerts

### Site-Integrity Alerts (P0-P1)

| Alert Name | Condition | Band | Priority | Response Time |
|------------|-----------|------|----------|---------------|
| Site Down | Site unreachable, or 5xx at the guide's Emergency trigger (>20/day) | Emergency | P0 | Acknowledge <15 min, action within 1 h |
| SSL Expiry | Certificate expiring in 14 days | Warning | P1 | Same day |
| Robots.txt Block | Important pages blocked | Critical | P1 | Same day |
| Index Dropped | **A named important page** leaves the index — the money, brand or top-converting URLs, not a count | none — boundary alert (which page, not how many) | P1 — a specific important page out of the index needs a same-day human; stated here because a boundary alert has no band to inherit from | Same day |

SSL Expiry sits one level above its band's default (P2), and the reason travels with it: a
certificate that lapses takes every page down at once, and the fix needs a same-day human.
Robots.txt Block takes the default map unchanged.

**Site Down is coverage, not a row you inherit — a review adds it where the estate has none.** An
alert review reads the rows a client already has, and the commonest real gap is the row that was
never there to be reviewed. Two things are **floor coverage** in any configuration this skill
writes or repairs: **a site-availability row** (this table's *Site Down*) and **the security /
manual-action pair at any detection** (*Security Alerts*, below). A configuration missing either
adds it from these tables, or the deliverable says why it is deliberately out. Closing a coverage
review on the rows that happened to exist is how a site ends up with nothing watching whether it is
up — a gap that costs nothing until the day it costs everything, and that no fire log can show you.

**Adding it does not double-grade the traffic row.** The threshold guide grades an outage's
*traffic consequence* on the day-over-day Emergency rung and says the 5xx count ladder does not
grade outage severity — both still true, and neither is what this row does. Reachability is a
different observation from traffic: *the site did not respond* is a boundary fact an availability
check sees in minutes, *organic sessions fell by half* is a distance from a baseline that a daily
total cannot show until tomorrow. An outage raising both raises **Site Down** on its reachability
and the DoD row on its traffic — two observations of one incident, exactly as *Index Dropped* and
*Index Coverage Drop* split below, not one observation graded twice.

**Index Dropped was rewritten 2026-08-13, and the reason is the rule it was breaking.** It read
"Pages dropping from index → Critical", while *Index Coverage Drop* below reads "Indexed pages
decline 10%+ → Warning". **The same observation was graded at two bands**, which `SKILL.md`'s own
line — *one observation is graded once* — forbids, and the old condition carried no quantity at
all, so a single unimportant URL falling out satisfied a Critical. The two rows now measure
different things, in the idiom this file already uses for *New 404 Pages*: **this row is a boundary
alert about *which* page; the coverage row is the count ladder about *how many*.** A drop that is
both — an important page among a 10% decline — raises the coverage alert on its band and this one
on its named page, which is two observations, not one graded twice. **Site Down's condition** used to read "HTTP 5xx
errors", which a single 5xx satisfies; the 5xx ladder lives in the threshold guide (Warning >1/day,
Critical >5/day, Emergency >20/day) and this row is its Emergency end.

### Crawl & Index Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Crawl Errors Spike | Errors increase 50%+ over baseline | none — 50% is 1.5× baseline, below the guide's Warning trigger of >2× | **unresolved — see the note below** |
| New 404 Pages | 404 errors on important pages | none — boundary alert (which pages, not how many) | P2 |
| Redirect Chains | 3+ redirect hops detected | none — boundary alert | P2 |
| Duplicate Content | New duplicates detected | none — boundary alert | P2 |
| Index Coverage Drop | Indexed pages decline 10%+ | Warning (guide: -5% Warning, -15% Critical) | P1 — raised from P2: a 10% drop is the Warning band, but pages out of the index earn nothing while it is investigated |

**Crawl Errors Spike is an open threshold decision, not a documentation fix** (threshold guide,
"Open threshold decisions", row 2). Its trigger reaches no band — the guide's crawl-error-rate
ladder starts at **>2× baseline** for Warning and >5× for Critical, and 50%+ is 1.5× — while the row
was inherited carrying **P1**: a priority with no band under it and no reason beside it. Two ways to
close it, and the operator picks:

1. Move the trigger to >2× baseline. The row becomes Warning band → **P2** by the default map.
2. Keep 50% deliberately, as an early boundary alert that fires before the band does, and write the
   priority with its reason in the cell ("P2 — early boundary alert, no band").

Do not ship the unexplained P1.

**What this paragraph used to say, and why it is gone**: *"The guide's absolute-count row (>10 new
errors/day Warning, >50 Critical) … is a working alternative trigger for the same alert."* That
offered a second ladder for one metric on purpose — the exact thing the guide's precedence rule
exists to stop — and it is no longer even accurate: that row is now scoped to crawl errors **other
than 4xx and 5xx** (soft 404s, redirect chains, DNS/connectivity failures, robots-blocked URLs),
because 4xx and 5xx each carry their own count ladder. It is a different metric, not an alternative
trigger for this one. Choose between the two closures above; do not add a parallel ladder.

### Performance Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| LCP — Needs Improvement | Field LCP (mobile) above **2.5 s** | Warning | P2 |
| LCP — Poor | Field LCP (mobile) above **4.0 s** | Critical | P1 |
| INP — Needs Improvement | Field INP (mobile) above **200 ms** | Warning | P2 |
| INP — Poor | Field INP (mobile) above **500 ms** | Critical | P1 |
| CLS — Needs Improvement | Field CLS (mobile) above **0.1** | Warning | P2 |
| CLS — Poor | Field CLS (mobile) above **0.25** | Critical | P1 |
| Page Speed Drop | Load time increases 50%+ | none — boundary alert (relative change; the guide's ladder is absolute response time: >500ms / >1000ms / >2000ms) | P2 |
| Mobile Issues | Mobile usability errors | none — boundary alert | P1 |

**Core Web Vitals is three metrics, so it is three ladders — and the status word is the number.**
"Needs Improvement" on LCP *means* field LCP above 2.5 s, so writing the figure states the same
rung in the notation a monitoring tool can evaluate — not a second ladder for the precedence rule
to consolidate away. The Good boundaries — **LCP ≤ 2.5 s · INP ≤ 200 ms · CLS ≤ 0.1** — are settled ruling
**R4** (`docs/loop/SETTLED-RULINGS.md`): fixed definitions that need no baseline, no connected feed
and no confirmation before they go into a configuration. The Poor column is the threshold guide's
own second tier, not part of R4. Cite the ruling handle in operator notes only; the client gets the
number.

**These rows were two until 2026-08-17, and that is what this fix is about.** They read "Core Web
Vitals Warn — a CWV metric drops to *Needs Improvement*" and "Core Web Vitals Fail — … *Poor*": a
complete, self-contained, status-keyed pair, which made a status-only rebuild the faithful reading
of this file. A run repairing an inherited config copied the pair, and "a CWV metric" names no
metric — so **the INP row disappeared entirely**, along with every boundary number, and the run
then offered to confirm the boundaries "when you reconnect the feed", about values no feed
supplies. Metric-named rows are what stop that: there is no INP alert to forget when INP has its
own row.

The six rows are still **one playbook with two entry priorities** — the guide's *Core Web Vitals
Degradation* playbook, whose trigger spans both bands. Its header once read P2 for the whole span
while this table priced the Poor end at P1; both bands are now named on both surfaces, and the
response clock follows the priority, not the band.

**An inherited config carrying a row on the input-delay metric retired in March 2024** is repaired
by replacing that row with the INP rows above — not by retuning its threshold and not by waiting
for data. Quote the client's row verbatim when you name it. And where these rows fire zero times
because the subscription feeding field data lapsed, that is a dead *feed*: rewire the source, do
not edit the numbers (threshold guide, "A row that never fires").

### Security Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Security Issue | GSC security warning | Critical (guide: any detection) | P0 — raised from P1: standing override, any detection is paged |
| Manual Action | Google manual action | Critical (guide: any notification) | P0 — raised from P1: standing override, any detection is paged |
| Malware Detected | Site flagged for malware | Critical (guide: any detection) | P0 — raised from P1: standing override, any detection is paged |

All three are P0 under the standing override — security issues and manual actions are paged on any
detection, whatever band the magnitude would give them, because there is no small manual action.

---

## Backlink Alerts

### Link Loss Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| High-Value Link Lost | A link from a high-authority domain is removed — threshold written in the connected tool's own scale, tool named (see the scale note) | Warning | P1 — raised from P2: a single loss is the Warning band, but recovery outreach is time-limited (the P1 response plan's "Backlink Loss" row) |
| Multiple Links Lost | 10+ links lost in a day | none — boundary alert (a count with no ladder; the guide's ladder is % of referring domains) | P2 |
| Referring Domain Lost | Lost entire domain's links | none — boundary alert | P2 |

**The authority scale is not a detail — name the tool and do not convert.** This row used to read
"DA 70+" while the threshold guide's matching row read "DR 60+". **DA is Moz's Domain Authority and
DR is Ahrefs' Domain Rating**: different vendors, different crawls, different models, both scored
0-100, and **no conversion between them is established anywhere in this repository**. Neither number
is written here as the answer, because picking one silently would hand two clients on two different
tools the same threshold on incomparable scales. Write the cut-off in the scale of whichever
backlink tool feeds the alert, name that tool in the same line ("DR 60+, Ahrefs" / "DA 70+, Moz"),
and if the tool changes, re-derive the number from the new tool's own distribution instead of
translating the old one. Which cut-off suits a given client is row 1 of the guide's **Open threshold
decisions** — an operator's call.

### Link Gain Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| High-Value Link | New link from a high-authority domain — same scale and same tool as the loss row above | Info (positive) | P3 (positive) |
| Suspicious Links | Many low-quality links | none — boundary alert until the guide's toxic-link ladder is used (>10/week Warning, >50/week Critical) | P2 |
| Negative SEO | Spam link attack pattern | Critical (the guide's "massive spam link spike") | P1 |

### Link Profile Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Toxic Score Increase | Toxic score up 20%+ | none — boundary alert (a vendor score with no ladder here; the guide's ladder counts new toxic links) | P1 |
| Anchor Over-Optimization | Exact match anchors >30% | Critical (guide: 20% Warning, 30% Critical) | P2 — lowered from P1: >30% is the Critical band, but an anchor ratio moves slowly and the fix is a link plan, not a same-day action |

---

## Competitor Monitoring Alerts

Every row in this category is a **boundary alert — no band**: the threshold guide defines no
competitor ladder, and these fire on an event (a competitor passing you, publishing, gaining a link)
rather than on a distance from a baseline. With no band there is no default map, so each priority is
set directly and owes no "raised from" clause. The one exception lives in the GEO section below —
"competitor cited where you're not" *is* banded by the guide.

### Ranking Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Competitor Overtake | Competitor passes you | none — boundary alert | P2 |
| Competitor Top 3 | Competitor enters top 3 on key term | none — boundary alert | P2 |
| Competitor Content | Competitor publishes on your topic | none — boundary alert | P3 (info) |

### Activity Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| New Backlinks | Competitor gains a link from a high-authority domain (same scale and tool as the backlink rows above) | none — boundary alert | P3 (info) |
| Content Update | Competitor updates ranking content | none — boundary alert | P3 (info) |
| New Content | Competitor publishes new content | none — boundary alert | P3 (info) |

### Competitors to Monitor

This is the monitoring **roster** — who is watched, on which keywords, and why. It is not an alert
and it carries no priority of its own: the priority comes from the two tables above (ranking
movements P2, activity P3 (info)), and the band from the same place (none — boundary alerts). The
inherited version graded Competitor 1 at P1, Competitor 2 at P2 and Competitor 3 at P3 with no band
and no reason given — three different response clocks assigned by row order, in a skill whose own
rule requires an off-default priority to name its reason in the same line.

| Competitor | Domain | Monitor Keywords | Why monitored | Priority, if not the category default |
|------------|--------|------------------|---------------|----------------------------------------|
| [Competitor 1] | [domain] | [X] keywords | [overlap with the priority-1 set / same commercial intent / recent SERP gains] | [leave blank for the default — or state the priority and its reason in one clause] |
| [Competitor 2] | [domain] | [X] keywords | [why this one is on the list] | [blank = default] |
| [Competitor 3] | [domain] | [X] keywords | [why this one is on the list] | [blank = default] |

A competitor whose alerts genuinely need a faster clock than the category default writes it the way
every other raised row in this file does — "P1 — raised from P2: competes on four of the five
priority-1 terms" — so the reason travels when the row is copied.

---

## GEO (AI Visibility) Alerts

All GEO alerts use a weekly check window; thresholds are tunable operational defaults (see the threshold guide).

### AI Citation Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Priority-1 Citation Lost | A priority-1 query loses its citation — i.e. is dropped from the answer entirely | Warning | P1 — raised from P2: priority-1 / Tier-1 set |
| Priority-1 Loss Cluster | 3+ priority-1 queries lose citations in one window | Critical | P0 — raised from P1: priority-1 / Tier-1 set |
| Dropped From Answer | A tracked query that is **not** on the priority-1 list loses its citation | Warning | P2 |
| Citation Position Slip | Position within the AI answer worsens by 2+ slots, citation retained | Warning | P2 |
| Citation Won | New citation gained on a tracked query | Info (positive) | P3 (positive) |
| AI Overview Change | AI Overview appears or disappears on a tracked query | Warning | P2 |

### GEO Trend Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Citation Rate Slide | Citation rate down 10+ percentage points vs. baseline | Warning | P1 — raised from P2: inherited business call on the site-wide citation-rate line; confirm or drop to P2 (see the note) |
| Citation Rate Floor | Citation rate below 10% absolute | Critical | P0 — raised from P1: same inherited call; confirm or drop to P1 (see the note) |
| GEO Competitor | Competitor cited where you're not | Warning | P2 |

**All nine citation rows above, and where each priority comes from.** Four sit one level above the default map, but
not for the same reason, and the difference matters. **Priority-1 Citation Lost (P1, band Warning)**
and **Priority-1 Loss Cluster (P0, band Critical)** are lifted by the standing priority-1 / Tier-1
override — that query set is the client's money, brand and top-converting terms. **Citation Rate
Slide** (P1, band Warning) and **Citation Rate Floor** (P0, band Critical) are *not*: the citation rate is a
site-wide line across all tracked queries, so the query-level override cannot reach it, and their
lift is an inherited business call that nothing here measures. Confirm it with the operator or drop
both to their band's default — a reason that names the wrong mechanism is worse than a default.
The other five take the default map unchanged: **Dropped From Answer** (Warning → P2), **Citation
Position Slip** (Warning → P2), **AI Overview Change** (Warning → P2), **GEO Competitor** (Warning →
P2) and **Citation Won** (Info → P3, positive). Nothing in this section is unbanded — the guide's
GEO table gives a ladder for every one of these. The earlier version of this paragraph named seven
of the nine; the two it skipped were Dropped From Answer and Citation Won, and a row absent from the
list reads as a row nobody priced.

**One event, one row** (threshold guide, GEO section). Three of these rows once fired together on a
single observation, and the corrections are visible above:

- **Dropped From Answer** is the same event as **Priority-1 Citation Lost** — losing the citation
  entirely — so it is now scoped to the tracked queries the priority-1 override does *not* cover,
  and takes the Warning band's default P2. It carried P1 with no reason, which had the effect of
  applying the priority-1 override to every query, priority-1 or not.
- **Citation Position Slip** grades slot movement *while the citation is retained*. Leaving the
  answer is not a bigger slot move; it is a loss, graded on the two loss rows by how many queries
  lost citations in the window.
- Without that split, one priority-1 loss reached Critical through the position row, became P0 under
  the override, and made the 3-or-more cluster row unreachable — there is nothing above P0.

**Response plan**: citation-loss alerts (loss, position, rate) hand the affected query and page to content-refresher's AI Overview recovery playbook. Priority-1 = the client-critical keywords from alert setup (money, brand, top-converting terms).

### Prompt-Level Answer Alerts — every threshold below is a PROPOSED DEFAULT awaiting the client's confirmation

**These four rows watch what an assistant says, not where a URL sits in a list.** The unit is a
**prompt**, the population is one record per (prompt × engine × capture date), and every row is
defined **per engine and per prompt cluster** — never pooled across engines, because a brand that
has vanished from one engine's answers and holds in another is one finding, not an average.

**The sampling rule is what makes these rows alertable at all, and it is not optional.** Generated
answers vary between runs for the same prompt, on the same day, from the same location. A single
capture is an **observation**, so an alert wired to one capture fires on that variation rather than
on a change, every cycle, until the channel is muted. Every condition below is therefore evaluated
over **`k of N` repeat captures** — N ≥ 3 per prompt per engine per cycle, captured in one session —
with both numbers written into the alert text ("named in 0 of 3 captures", never "not named"), and
**confirmed across two consecutive cycles** before it fires. A `k of N` result standing in one cycle
is a candidate. Failed captures (refusal, rate limit, empty response) are logged with their reason
and reduce N; dropping them silently turns a 1-of-1 into 100%. Where a configuration cannot run the
repeats, these rows ship **off**, and the configuration says so rather than reading one capture as a
measurement.

| Alert Name | Condition (per engine, per cluster, over `k of N` repeats, confirmed across 2 consecutive cycles) | Band | Priority (proposed) |
|------------|---------------------------------------------------------------------------------------------------|------|---------------------|
| Brand Absent From Answers | Brand named in **0 of N** captures for the cluster's head prompts | none — boundary alert | **Proposed P1** where the cluster is on the priority-1 list, **P2** otherwise — awaiting client confirmation |
| Recommendation Position Drop | Average recommendation position for the cluster worsens by **2 or more slots** vs. the previous cycle, computed over captures where a recommendation set existed | none — boundary alert | **Proposed P2** — awaiting client confirmation |
| Competitor Enters Answer Set | A competitor absent from the previous cycle's captures is named in **2 or more of N** captures this cycle | none — boundary alert | **Proposed P2** — awaiting client confirmation |
| Cited URL Flips To Non-Owning Property | The cited client URL for the cluster is **not** the register's owning URL in **2 or more of N** captures | none — boundary alert | **Proposed P2** — awaiting client confirmation |

**Why "none — boundary alert" on all four, and why no number here is presented as settled.** The
threshold guide defines no ladder for prompt-level answer metrics — there is no baseline mean and
no standard deviation for them anywhere in this library — so these fire on an event, exactly like
the brand and competitor-activity rows, and with no band there is no default map to sit above or
below. Their priorities are therefore set directly from the business and owe no "raised from"
clause; the Band cell is what says so. The `k`, the slot count and the cycle count above are
**proposed defaults, not measured constants**, and a configuration that ships one states that it is
awaiting confirmation. A ladder becomes derivable once 8+ cycles of `k of N` history exist, on the
same terms as the optional statistical ladder for citation metrics — until then, no number is
invented to fill the column.

**Row 4 is a cannibalisation signal, not an AI problem.** A cited URL that is not the cluster's
owning URL means the engine picked a property of the client's that does not own the cluster; the
fix is the ownership contest — consolidate, differentiate, retire — and routing it to content work
on the answer wastes the alert. Hand it to the ownership register, not to a refresh playbook
(`references/query-cluster-ownership.md` §5, the AI form of the collision signal).

**One observation, one row, here too.** A cluster whose brand went absent *and* whose competitor
appeared is graded on the row that names it most specifically, and the alert says which. Sentiment
is not one of these four rows: it is recorded once per captured answer and alerts on the Negative
Mention row below.

**Nothing in these alerts promises an outcome.** An alert reports what the captures showed, with
its `k of N` and its timestamp. It never states what an engine prefers or does, and a response plan
built on one never promises that the work will restore a mention, a citation or a position — the
deliverable is the work plus the re-measurement recorded beside its baseline.

---

## Brand Monitoring Alerts

**Every row in this category is a boundary alert — no band.** The threshold guide defines no ladder
for brand and reputation metrics: Sections 2-3 have no brand table, so there is no baseline, no
standard deviation and no percentage step to read these against. They fire on an event. With no band
there is no default map to sit above or below, so each priority below is set directly from the
business and owes no "raised from" clause — the Band cell is what tells the next reader why. Two of
them could carry a ladder once a baseline exists (average review rating and monthly mention volume
are both numbers with a mean); no numbers are invented for them here, and an operator holding that
history can build the ladder with the guide's Section 2 method.

### Mention Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Brand Mention | New brand mention online | none — boundary alert | P3 (info) |
| Negative Mention | Negative sentiment on a recorded mention — including the sentiment recorded on a captured AI answer | none — boundary alert | P1 |
| Review Alert | New review on key platforms | none — boundary alert | P2 |
| Unlinked Mention | Brand mention without link | none — boundary alert | P3 (opportunity) |

**Negative Mention is the alert path for the recorded sentiment field — one field, not two.**
Sentiment on an AI answer is recorded once, on the sentence carrying the brand rather than on the
answer overall (`references/ai-visibility-measurement.md` field 9, scored as CITE item C08), and it
alerts here. No second sentiment metric is defined in the GEO section and none is added there: a
negative-sentiment answer is graded on this row, not also on a prompt-level row — the same
one-observation-one-row rule that governs the citation tables. The row keeps its boundary-alert Band
because a single negative answer is an event, not a distance from a baseline; where enough cycles
exist to make a sentiment split (positive / neutral / negative counts) into a series, that series is
reported, not converted into a score.

### Reputation Alerts

| Alert Name | Condition | Band | Priority |
|------------|-----------|------|----------|
| Review Rating Drop | Average rating drops | none — boundary alert (a ladder is buildable once a rating baseline exists) | P1 |
| Negative Press | Negative news article | none — boundary alert | P1 |
| Competitor Comparison | Named in competitor comparison | none — boundary alert | P2 |

---

## Alert Response Plans

One clock per priority, the same one the threshold guide's routing and SLA tables use. Response
times belong to the **priority**, never to the threshold band: a Critical-band metric on a P2
alert is still a 48-hour job.

**The clock is not the resolution condition, and every plan below needs both.** "Acknowledge
within 15 minutes, target resolution 2 hours" says how fast the response starts and how long it
may run; it does not say what state means *resolved*. So each row carries a **Resolved when**
cell — observable, binary at the moment of checking, expressed in the same metric and window the
alert fired on — and an **Owner**, read off the routing matrix (threshold guide Sec. 4) rather
than from a second role list. The Immediate Actions column is the diagnostic procedure; where it
is entirely diagnostic, the Resolved when cell says what each branch concludes with. These are
the seven action fields on a narrow surface: action (the row's alert type plus its steps), owner,
acceptance criterion (Resolved when), and — where a plan has them — expected impact, effort,
dependencies and risk-if-done-wrong stated beneath the table rather than as four more columns.

### P0 — Emergency

**Response Time**: Acknowledge within 15 minutes, first action within 1 hour, target resolution 2 hours

| Alert Type | Owner (from routing matrix) | Immediate Actions | Resolved when |
|------------|------------------------------|-------------------|---------------|
| Site Down | SEO Lead + Engineering Lead + DevOps | 1. Check server status 2. Contact hosting 3. Check DNS | The site returns 200 on the monitored URL across two consecutive checks and the cause is recorded in the incident note |
| Traffic Crash | SEO Lead + Engineering Lead + Marketing VP | 1. Check for algorithm update 2. Review GSC errors 3. Check competitors | Daily sessions are back inside the site's own normal range for two consecutive days, **or** the drop is attributed in writing to a named cause and the alert is reclassified rather than left open |
| Manual Action | SEO Lead + Engineering Lead + Legal | 1. Review GSC message 2. Identify issue 3. Begin remediation | A reconsideration request has been submitted with the remediation described, and the submission date is recorded |
| Top-3 Keyword Drop (priority-1 set) | SEO Lead + Content Lead | 1. Check if page indexed 2. Review SERP 3. Analyze competitors | The page is confirmed indexed and either the position is back inside its Warning band across two checks, or the SERP change is documented and the query is moved to the planned-work queue with an owner |

<!-- No Resolved when cell may require an engine to do something. A restored position, a
     recovered citation or a return to an AI answer is nobody's to deliver, and writing one here
     turns the alert into a promise (anti-slop families 9 and 10). Where the honest condition is
     "we did the work and re-measured", say that: it is checkable and it is true. A prompt-level
     plan resolves on the work shipped plus the k of N re-measured on the same protocol across
     the confirming cycle and recorded beside its baseline. -->


### P1 — Urgent

**Response Time**: Acknowledge within 4 hours, resolved same day

| Alert Type | Owner (from routing matrix) | Actions | Resolved when |
|------------|------------------------------|---------|---------------|
| Major Rank Drops | SEO Team | Analyze cause, create recovery plan | A recovery plan exists carrying an owner and its own acceptance criterion, and the affected queries are on the tracked list with a re-check date |
| Traffic Decline | SEO Lead + Marketing Manager | Investigate source, check technical issues | The decline is attributed to a named source (segment, channel, technical fault, tracking change) in writing, and either the fault is fixed or the finding is queued with an owner |
| Backlink Loss | SEO Team | Attempt recovery outreach | Outreach is sent and logged with dates and recipients; the outcome is recorded either way — a recovered link is not the condition, since it is not in anyone's gift |
| CWV Failure | SEO Lead + Engineering Team | Diagnose and fix performance issues | The failing field metric is back inside its threshold (LCP ≤2.5s · INP ≤200ms · CLS ≤0.1) in the field data for the affected template, across one full reporting window |

### P2 — Important

**Response Time**: Within 48 hours

| Alert Type | Owner (from routing matrix) | Actions | Resolved when |
|------------|------------------------------|---------|---------------|
| Moderate Rank Changes | SEO Team | Monitor trend, plan content updates | The trend is re-read at the next scheduled check and either returns inside band, or a content update is queued with an owner and its own acceptance criterion |
| Competitor Movement | SEO Team | Analyze competitor changes | What changed is recorded as a dated observation with its observer, and the finding is either closed as no-action-needed or queued with an owner |
| New 404s | SEO Team + Engineering Team | Set up redirects, update internal links | Every listed 404 returns 200 or 301 to a named live URL, and no in-body internal link still points at the dead URL — verified in a re-crawl export |

### P3 — Monitor

**Response Time**: Weekly review

| Alert Type | Owner (from routing matrix) | Actions | Resolved when |
|------------|------------------------------|---------|---------------|
| Positive Changes (wins, new citations, climbs) | SEO Team (weekly digest) | Document wins, understand cause | The win is logged with its date and the leading explanation, labelled as unverified where nothing settles it, and reviewed in the weekly slot |
| Info and opportunity alerts | SEO Team (weekly digest) | Log for trend analysis; work the opportunity queue in the weekly slot | Each item is logged, and each opportunity is either actioned with an owner or closed with a reason — an item left in the queue two reviews running is triaged rather than carried again |

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

Same role vocabulary as the threshold guide Section 4 — one list, not two. This table used to run a
second, shorter one (SEO Manager / Dev Team / Marketing Lead / Executive), so a configuration built
from these templates and a routing matrix built from the guide named different recipients for the
same alert, and neither list said which was authoritative. Rows below are read off the guide's
routing matrix.

These are **roles, not people**: on a small team one person wears several hats. Map every role to a
named person before the configuration goes live, and delete a role nobody holds rather than leaving
it in the table — a role with nobody behind it is not a route.

| Role | P0 | P1 | P2 | P3 |
|------|----|----|----|----|
| SEO Lead | Yes | Yes | Yes | Digest |
| SEO Team (incl. SEO Analyst) | Escalation only | Yes | Yes | Digest |
| Content Lead | Ranking + GEO only | No | No | Digest |
| Engineering Lead | Technical, traffic, security | No | No | No |
| Engineering Team | No | Technical only | Technical only | No |
| DevOps | Technical + security only | No | No | No |
| Marketing Manager | No | Traffic only | No | Digest |
| Marketing VP | Yes | No | No | Weekly summary |
| Legal | Security only | No | No | No |

### Alert Suppression

- Suppress duplicate alerts for 24 hours
- Don't alert on known issues (maintenance windows)
- Batch P2/P3 alerts into digests

### Alert Escalation

Escalation targets come from the same role list as everything else — the guide's Section 4 vocabulary
(SEO Lead · SEO Analyst · SEO Team · Content Lead · Engineering Lead · Engineering Team · DevOps ·
Marketing Manager · Marketing VP · Legal). "Director" and "Manager" appeared here and in no routing
table in the skill, which left the last hop of every escalation pointing at nobody.

| If No Response In | Escalate To |
|-------------------|-------------|
| 15 min (P0) | The rest of that category's P0 route, then Marketing VP |
| 4 hours (P1) | SEO Lead — and Engineering Lead as well, on technical alerts |
| 48 hours (P2) | SEO Lead (the channel table's auto-escalation to P1 after one week still applies) |

---

## Alert summary closing blocks

Append these two blocks to the Alert System Summary the skill produces (SKILL.md step 5), after the
Alert Count by Category table.

```markdown
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
- [ ] For prompt-level rows: confirm each fired on its `k of N` across two consecutive cycles, and record any capture failures that reduced N
```

---

## Worked Example — a ranking alert configuration, end to end

Moved here from `SKILL.md` to keep that file inside its 350-line body cap. It shows the two-label
rule (band and priority) applied to five real rows, the one-level override on the priority-1 set,
and the boundary-alert case where a trigger reaches no band at all.

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

