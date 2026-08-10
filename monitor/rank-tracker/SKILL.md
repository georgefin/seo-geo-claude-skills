---
name: rank-tracker
version: "4.2.0"
description: 'Track keyword ranking positions and SERP position changes over time in both traditional search and AI-generated responses. Use when the user asks to "track rankings", "check keyword positions", "monitor SERP positions", "how am I ranking", "where do I rank for this keyword", "did my rankings change", "ranking changes", or "keyword position tracking". For automated alerting, see alert-manager. For comprehensive reports, see performance-reporter.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.2.0"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - rank tracking
    - keyword positions
    - serp monitoring
    - ranking trends
    - position tracking
    - ai ranking
    - keyword-rankings
    - position-tracking
    - ranking-changes
    - serp-positions
    - search-visibility
    - ranking-drops
    - ranking-improvements
    - rank-monitoring
  triggers:
    - "track rankings"
    - "check keyword positions"
    - "ranking changes"
    - "monitor SERP positions"
    - "how am I ranking"
    - "keyword tracking"
    - "position monitoring"
    - "where do I rank for this keyword"
    - "did my rankings change"
    - "keyword position tracking"
---

# Rank Tracker


Tracks, analyzes, and reports on keyword ranking positions over time. Monitors both traditional SERP rankings and AI/GEO visibility to provide comprehensive search performance insights.

## When to Use This Skill

- Setting up ranking tracking for new campaigns
- Monitoring keyword position changes
- Analyzing ranking trends over time
- Comparing rankings against competitors
- Tracking SERP feature appearances
- Monitoring AI Overview inclusions
- Creating ranking reports for stakeholders

## What This Skill Does

1. **Position Tracking**: Records and tracks keyword rankings
2. **Trend Analysis**: Identifies ranking patterns over time
3. **Movement Detection**: Flags significant position changes
4. **Competitor Comparison**: Benchmarks against competitors
5. **SERP Feature Tracking**: Monitors featured snippets, PAA
6. **GEO Visibility Tracking**: Tracks AI citation appearances
7. **Report Generation**: Creates ranking performance reports, each closing with the run's operator handoff block
8. **Striking-Distance Mining**: Surfaces the tracked property's own GSC queries at positions 5-20 as push targets

## How to Use

### Set Up Tracking

```
Set up rank tracking for [domain] targeting these keywords: [keyword list]
```

### Analyze Rankings

```
Analyze ranking changes for [domain] over the past [time period]
```

### Compare to Competitors

```
Compare my rankings to [competitor] for [keywords]
```

### Generate Reports

```
Create a ranking report for [domain/campaign]
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~search console + ~~analytics + ~~AI monitor connected:**
Automatically pull ranking positions from ~~SEO tool, search impressions/clicks from ~~search console, traffic data from ~~analytics, and AI Overview citation tracking from ~~AI monitor. Daily automated rank checks with historical trend data.

**With manual data only:**
Ask the user to provide:
1. Keyword ranking positions (current and historical if available)
2. Target keyword list with search volumes
3. Competitor domains and their ranking positions for key terms
4. SERP feature status (featured snippets, PAA appearances)
5. AI Overview citation data (if tracking GEO metrics)

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data, naming each source by its resolved name per the Output Validation source rule below — the connected tool's own name, or the plain-language source ("your 28-day Search Console export", "hand check, 10 Aug"), never a `~~category` token on a surface the client reads.

## Instructions

When a user requests rank tracking or analysis:

1. **Set Up Keyword Tracking** -- Configure domain, location, device, language, update frequency. Add keywords with volume, current rank, type, and priority. Set up competitor tracking and keyword categories (brand/product/informational/commercial).

   **Tracking artifact (persistence contract)** -- Every run produces a dated ranking snapshot: one row per keyword with keyword, position, ranking URL, SERP features, check date, and data source. The snapshot is a client-read surface, so its data-source cell carries a **resolved** source and never a `~~category` token: the connected tool's own name ("Ahrefs", "Google Search Console"), or the plain-language origin of a manual figure ("user-provided hand check, 2026-08-10"), or -- where nothing was collected -- the cell is left empty and the absence is stated in prose. If [memory-management](../../cross-cutting/memory-management/) is active, hand the snapshot to it (hot-cache summary + dated snapshot in cold storage, per its conventions). Otherwise, save the snapshot to a file and confirm the location with the user. On every subsequent run, read the prior snapshot first -- it is the baseline for all change calculations.

2. **Mine Striking-Distance Queries (own GSC data)** -- When ~~search console is connected (or the user exports its query report), pull the tracked property's queries sitting at average positions ~5-20: the page-one tail plus page two, where demand is already proven and one push can move real clicks. Use this GSC-derived list first, before third-party rank data, whenever it is available. API mechanic: the Search Analytics API returns rows sorted by clicks and offers no position filter -- request a high rowLimit and filter the 5-20 window client-side; label the resulting metrics tool-measured. Prioritize by Opportunity = (Volume × Intent Value) / Difficulty where those inputs exist; when volume/difficulty are unavailable (manual tier), degrade gracefully to Impressions × Position Gap (position gap = current average position minus 1). Skip queries below an impression floor -- default 50 impressions in the pull window, a house default to tune per site (upstream defines none). Compute the Opportunity figure from the export's own unrounded values and print the multiplication beside the result. Append the mined rows to the dated snapshot from step 1's persistence contract. Queries whose ranking URL needs content work become [content-refresher](../../optimize/content-refresher/) refresh targets -- they are listed in the run's **operator handoff block** (step 8), not in client prose, and the client-facing action column names the job ("refresh this page") rather than the run handle. Boundary: this step only re-reads the tracked property's own Search Console data for positions it already holds -- discovering *new* keywords is a [keyword-research](../../research/keyword-research/) job, routed through the same block.

   > **Reference**: See [references/tracking-setup-guide.md](./references/tracking-setup-guide.md) Section 9 for the full mining methodology, defaults, and output format.

3. **Record Current Rankings** -- Ranking overview by position range (#1, #2-3, #4-10, #11-20, etc.), position distribution visualization, detailed rankings with URL, SERP features, and change.

4. **Analyze Ranking Changes** -- Overall movement metrics, biggest improvements and declines with hypothesized causes, recommended recovery actions, stable keywords, new rankings, lost rankings.

5. **Track SERP Features** -- Feature ownership comparison vs competitors (snippets, PAA, image/video pack, local pack), featured snippet status, PAA appearances.

6. **Track GEO/AI Visibility** -- AI Overview presence per keyword, citation rate and position, GEO performance trend over time, improvement opportunities.

7. **Compare Against Competitors** -- Share of voice table, head-to-head comparison per keyword, competitor movement alerts with threat level.

8. **Generate Ranking Report** -- Executive summary with overall trend, position distribution, key highlights (wins/concerns/opportunities), detailed analysis, SERP feature report, GEO visibility, competitive position, recommendations.

   **Operator handoff block (handoff contract)** -- Every report closes with one block carrying **two** labels: a visible one a reader sees rendered (`**Next steps for your team** -- *operator block; not part of the client report*`) and an in-fence comment that survives being copied (`<!-- OPERATOR HANDOFF -- for whoever runs the skill library; not client copy -->`). Two labels because the two failure modes differ: a comment alone is invisible in a rendered report, and a heading alone is lost when a model copies the fence and not the heading above it. It is the **only** place in the deliverable where a run handle appears -- a skill name, a framework item ID, an internal artefact name. Client prose above it names the job instead ("refresh the boiler guide", "re-check that SERP"), because a handle names a tool the client does not have. One row per follow-up run, carrying what the receiving skill needs: target keyword, content type, the ranking URL, current and previous position with the check date and resolved source, the reason for the handoff, and any framework scores already on file (this skill computes no CORE-EEAT or CITE score, so those fields read "not computed by this skill" rather than being invented). The block is addressed to the operator, so it is an operator surface wherever it sits -- inside a client deliverable included.

   > **Reference**: See [references/ranking-analysis-templates.md](./references/ranking-analysis-templates.md) for output templates covering seven of these eight steps: its templates 1-7 map to steps 1, 3, 4, 5, 6, 7 and 8 in that order, and its template 8 is the operator handoff block. Step 2's mining output format lives in the tracking setup guide §9 instead -- the templates file covers no step 2.

## Metric Derivation Contract

Every number this skill prints into a deliverable shows how it was reached, **beside the number** — not in a footnote, not only in a reference file. Three rules cover the whole set:

1. **Show the arithmetic next to the figure.** `Average position 15.4 → 12.8 (554/36 → 461/36)`; `positions 1-10: 17 of the 36 keywords ranked on both dates`; `Opportunity 6,720 = 840 impressions × 8.0 position gap`. A reader who cannot recompute a figure from the line it sits on has been handed an assertion, not a measurement.
2. **Define the population, then compare like with like.** Every average, count and percentage states which keywords it covers and over how many. Across two dates, hold the population constant or say why not: a keyword that entered or left the tracked set moves an average without any ranking having changed, and reporting that movement as a trend is the most common way this skill goes wrong.
3. **No input, no figure.** A metric whose input was never collected is not estimated into existence — the cell is dropped and the prose names what to send so the next run can state it. **This skill defines no visibility score, no position-CTR curve and no traffic or revenue model of its own.** A visibility or traffic figure appears only when a connected tool or the client's own analytics reports it, carrying that source's name; a bare position→traffic claim about *this* site never appears.

**Sign convention** (state it once per deliverable, then keep it): `Change = new position − old position`, so a negative change is an improvement and a positive change is a decline. Where a table instead labels movement in words ("improved 11"), it uses words throughout — the two conventions are never mixed inside one report.

> **Reference**: See [references/metric-derivations.md](./references/metric-derivations.md) for every figure the templates emit, its formula, its rounding convention, its population rule, and the fallback when its input is missing.

## Validation Checkpoints

### Input Validation
- [ ] Keywords list is complete with search volumes
- [ ] Target domain and tracking location are specified
- [ ] Competitor domains identified for comparison
- [ ] Historical baseline data available or initial tracking period set

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Ranking changes include context (vs. previous period)
- [ ] Significant movements have explanations or investigation notes
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Google Search Console), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads, the dated snapshot's data-source column included (anti-slop-ruleset.md §6 family 7)
- [ ] Every score, average, count and percentage carries its derivation beside it, with its population named and the sign convention stated (Metric Derivation Contract)
- [ ] No cell holds a bracket token, `TBD` or `XX` where a value belongs: in a findings table an uncollected input means the row or column is dropped, or left empty with the absence stated, and the gap is named in prose (a setup template instead marks a not-yet-collected slot "to collect" — a stated status, not a value)
- [ ] Run handles (skill names, framework item IDs, internal artefact names) appear only inside the operator handoff block; client prose names the job instead (anti-slop-ruleset.md §6 family 8)

## Example

**User**: "Analyze my ranking changes for the past month"

**Output** (every figure resolved and derived; the closing block is the operator surface):

```markdown
# Ranking Analysis — 12 March to 9 April 2026

**Source**: Ahrefs Rank Tracker, daily checks, last pull 9 April 2026 · 40 keywords tracked
**Change convention**: Change = new position − old position, so a negative number is an improvement.

## Summary

- **Average position 15.4 → 12.8 (change −2.6).** Mean over the 36 keywords ranked on both
  dates: 554/36 = 15.4 on 12 March, 461/36 = 12.8 on 9 April. The 4 keywords that entered the
  set this period are excluded from both means, so the comparison is like-for-like; they are
  listed under New Rankings.
- **Keywords in positions 1-10: 12 → 17 (change +5).** Counted over the same 36 keywords.

## Biggest Wins

| Keyword | Old | New | Change | Possible cause — hypothesis, not confirmed |
|---------|-----|-----|--------|--------------------------------------------|
| email marketing tips | 18 | 5 | −13 | Guide rewritten 3 March; timing correlates |
| best crm software | 24 | 11 | −13 | 6 new referring domains in the window |
| sales automation | 15 | 7 | −8 | FAQ block and schema added 11 March |

## Needs Attention

| Keyword | Old | New | Change | Protocol row | Action |
|---------|-----|-----|--------|--------------|--------|
| marketing automation | 4 | 12 | +8 | Page-1 exit (overrides the 5-10 size row) | Full diagnostic, then rewrite the guide |
| pipeline reporting | 9 | 11 | +2 | Page-1 exit (overrides the 1-2 size row) | Re-check the SERP, then refresh the page |

No traffic figures appear above: no click baseline was supplied for these URLs, so the loss is
not quantified here. Send a Search Console clicks export for the two URLs and the next report
will state it.

<!-- OPERATOR HANDOFF — for whoever runs the skill library; not client copy -->
**Next steps for your team** — *operator block; not part of the client report*

| Follow-up run | Payload |
|---------------|---------|
| content-refresher | kw: marketing automation · type: guide · URL: /guide/marketing-automation · pos 4 → 12 (Ahrefs, 9 Apr 2026) · reason: page-1 exit · CORE-EEAT/CITE: not computed by this skill |
| serp-analysis | kw: pipeline reporting · type: feature page · URL: /features/reporting · pos 9 → 11 (Ahrefs, 9 Apr 2026) · reason: confirm SERP composition change · CORE-EEAT/CITE: not computed by this skill |
```

## Tips for Success

1. **Track consistently** - Same time, same device, same location
2. **Include enough keywords** - 50-200 for meaningful data
3. **Segment by intent** - Track brand, commercial, informational separately
4. **Monitor competitors** - Context makes your data meaningful
5. **Track SERP features** - Position 1 without snippet may lose to position 4 with snippet
6. **Include GEO metrics** - AI visibility increasingly important

## Rank Change Quick Reference

### Response Protocol

Bands are inclusive at both ends and do not overlap. Drop size = new position − old position; where positions are decimal averages, round the drop to the nearest whole position (halves away from zero) and band the rounded value.

| Change | Timeframe | Action |
|--------|-----------|--------|
| Drop off page 1 — old position 1-10, new position 11 or worse, **any** drop size | Emergency response | Comprehensive audit + recovery plan |
| Drop 1-2 positions | Wait 1-2 weeks | Monitor -- may be normal fluctuation |
| Drop 3-4 positions | Investigate within 1 week | Check for technical issues, competitor changes |
| Drop 5-10 positions | Investigate immediately | Full diagnostic: technical, content, links |
| Drop 11+ positions, still on page 1 | Investigate immediately | Full diagnostic + confirm the position with a manual check |
| Position gained (any size) | Document and learn | What worked? Can you replicate? |

**Precedence**: read the page-1 exit row first — it overrides every size row, so a 1-position drop from #10 to #11 is a page-1 exit and not a monitor case (the setup guide's position-vs-traffic table puts the largest single click loss on exactly that step). Every other drop, including one that starts on page 2 or lower, bands by size.

> **Reference**: See [references/tracking-setup-guide.md](./references/tracking-setup-guide.md) for rank fluctuation patterns and their interpretation, position-vs-traffic impact estimates, alert threshold configuration, tracking configuration best practices, keyword selection and grouping strategies, and data interpretation guidelines.

## Reference Materials

- [Tracking Setup Guide](./references/tracking-setup-guide.md) — Configuration best practices, device/location settings, and striking-distance GSC mining methodology (Section 9)
- [Ranking Analysis Templates](./references/ranking-analysis-templates.md) — Output templates for seven of the eight workflow steps, plus the operator handoff block (step 2's mining format is in the setup guide §9)
- [Metric Derivations](./references/metric-derivations.md) — Every figure this skill emits: formula, inputs, rounding, population rule, and what to do when the input is missing

## Related Skills

The names below are run handles for the operator. In a deliverable they appear only inside the operator handoff block (step 8); client prose names the job instead.

- [keyword-research](../../research/keyword-research/) — Find keywords to track
- [serp-analysis](../../research/serp-analysis/) — Understand SERP composition
- [alert-manager](../alert-manager/) — Set up ranking alerts
- [performance-reporter](../performance-reporter/) — Comprehensive reporting
- [content-refresher](../../optimize/content-refresher/) — Receives striking-distance queries whose URLs need content work as refresh targets
- [memory-management](../../cross-cutting/memory-management/) — Store ranking history in project memory

