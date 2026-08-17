---
name: content-refresher
version: "4.3.5"
description: 'Refresh old blog posts and outdated content with current statistics, new information, and freshness signals to restore search rankings. Use when the user asks to "update old content", "refresh content", "content is outdated", "improve declining rankings", "revive old blog posts", "traffic is declining on this page", "rankings dropped for this article", or "this post is outdated". For writing new content from scratch, see seo-content-writer. For auditing without rewriting, see on-page-seo-auditor.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.5"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - content refresh
    - content update
    - outdated content
    - content decay
    - ranking recovery
    - content optimization
    - content-update
    - content-decay
    - evergreen-content
    - content-freshness
    - content-revival
    - refresh-content
    - update-statistics
    - republishing
    - content-lifecycle
  triggers:
    - "update old content"
    - "refresh content"
    - "content is outdated"
    - "improve declining rankings"
    - "revive old blog posts"
    - "content decay"
    - "ranking dropped"
    - "this post is outdated"
    - "traffic is declining on this page"
    - "rankings dropped for this article"
---

# Content Refresher


This skill helps identify and revitalize outdated content to reclaim lost rankings and traffic. It analyzes content freshness, identifies update opportunities, and guides the refresh process for maximum SEO and GEO impact.

## When to Use This Skill

- Content has lost rankings or traffic over time
- Statistics and information are outdated
- Competitors have published better content
- Content needs updating for a new year
- Industry changes require content updates
- Adding new sections to existing content
- Converting old content for GEO optimization

## What This Skill Does

1. **Freshness Analysis**: Identifies outdated content needing updates
2. **Performance Tracking**: Finds content with declining traffic
3. **Gap Identification**: Spots missing information competitors have
4. **Update Prioritization**: Ranks content by refresh potential
5. **Refresh Recommendations**: Provides specific update guidance
6. **GEO Enhancement**: Updates content for AI citation potential
7. **Republishing Strategy**: Advises on date and promotion tactics

## How to Use

### Identify Content to Refresh

```
Find content on [domain] that needs refreshing
```

```
Which of my blog posts have lost the most traffic?
```

### Refresh Specific Content

```
Refresh this article for [current year]: [URL/content]
```

```
Update this content to outrank [competitor URL]: [your URL]
```

### Content Refresh Strategy

```
Create a content refresh strategy for [domain/topic]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~analytics + ~~search console + ~~SEO tool connected:**
Claude can automatically pull historical traffic trends from ~~analytics, fetch impression and ranking data from ~~search console, retrieve keyword position history from ~~SEO tool, and identify content with declining performance. This enables data-driven refresh prioritization.

**With manual data only:**
Ask the user to provide:
1. Traffic data or screenshots showing performance trends
2. Ranking screenshots or history for key pages
3. Content publish dates and last update dates
4. List of pages the user suspects need refreshing
5. Competitor URLs, or their own dated notes on what the pages ranking above theirs cover — at Tier 1 the only competitor input there is, and what every "competitors now cover X" line rests on

Proceed with the analysis using provided data. Note in the output which findings are from automated data vs. manual review. **An input nobody supplied is not filled in from a typical case**: name the missing input, leave the figure out, and say what supplying it would unlock (root `CLAUDE.md`, Tool Connector Pattern, resolution branch 3).

## Instructions

When a user requests content refresh help:

1. **CORE-EEAT Quick Score — Identify Weak Dimensions**

   Before refreshing, run a quick CORE-EEAT assessment to focus effort on the weakest areas. Reference: [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md)

   ```markdown
   ### CORE-EEAT Quick Assessment

   **Content**: [title or URL]
   **Content Type**: [type]

   Rapidly score each dimension (estimate 0-100) and print the derivation beside every score, so a
   reader can recompute it: check at least 3 items of that dimension in the benchmark, grade each
   Pass 10 / Partial 5 / Fail 0 (an unassessable item is N/A — out of the denominator, never a 0),
   then `score = points ÷ (10 × items checked) × 100` — **rounded once, at the end, to one decimal,
   halves up, and the `.0` dropped when it lands whole**: 5 pts over 3 items is 16.7, never 17, or
   the tally printed beside it stops reproducing. Under 3 checkable items the dimension reads
   "not assessed", not a number. Refresh Priority follows the score, not a separate impression:
   🔴 below 50 · 🟡 50-74 · 🟢 75 and above. A quick score is this skill's own estimate over the
   items it checked, never a tool measurement.

   | Dimension | Quick Score (points ÷ items checked) | Key Weakness | Refresh Priority |
   |-----------|-----------|--------------|-----------------|
   | C — Contextual Clarity | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | O — Organization | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | R — Referenceability | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | E — Exclusivity | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | Exp — Experience | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | Ept — Expertise | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | A — Authority | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |
   | T — Trust | [X]/100 — [P] pts over [n] items | [main issue] | 🔴/🟡/🟢 |

   **Weakest Dimensions** (focus refresh here):
   1. [Dimension] — [what needs fixing]
   2. [Dimension] — [what needs fixing]

   **Refresh Strategy**: Focus on 🔴 dimensions first, then 🟡.
   ```

   **The item IDs do not go in that table.** It is client-read, and a framework item ID is a
   coordinate in a document the client has never opened (anti-slop family 8; root `CLAUDE.md`
   § The Reader Test). The client column stays recomputable without them — points over items
   checked — and the IDs, the per-item grades and any failing veto travel in a fence of their own,
   labelled **inside** it, because a model copies the fence and not the heading above it:

   ```markdown
   <!-- OPERATOR BLOCK — for whoever runs this refresh, not part of the client report above. The
        ID column is a coordinate into the 80-item benchmark and is what a handoff carries.
        Nothing in this fence goes to the client as written. -->
   ### CORE-EEAT quick scan — operator triage

   | Dimension | Score | Items graded (Pass 10 / Partial 5 / Fail 0 · N/A held out of the denominator) |
   |---|---|---|
   | [dimension] | [X]/100 — [P] pts over [n] | [IDs with their grades, e.g. C02, C03 Pass; C01 Partial; C09 Fail] |

   **Veto flagged**: [`CORE-EEAT-C01` / `CORE-EEAT-R10` / `CORE-EEAT-T04` where a material
   connection exists — or "none"]. The quick pass flags; the full 80-item audit rules and
   applies the score cap.
   ```

   One row per dimension scored. **This scan is not a dimension score and never becomes one**: it is
   an estimate over the handful of items it checked, so it never travels to another run as a
   `CORE-EEAT C:… O:…` string — what travels is the failing item IDs and how many items were checked
   ([inter-skill-handoff.md §4.3](../../references/inter-skill-handoff.md)). What the client gets
   from the scan is the plain-language weakness column above. For the full 80-item audit, hand off to
   [content-quality-auditor](../../cross-cutting/content-quality-auditor/).

2. **Identify Content Refresh Candidates**

   ```markdown
   ## Content Refresh Analysis
   
   ### Refresh Candidate Identification
   
   **Criteria for Content Refresh**:
   - Published more than 6 months ago
   - Contains dated information (years, statistics)
   - Declining traffic trend
   - Lost keyword rankings
   - Outdated references or broken links
   - Missing topics competitors now cover — assessable only where competitor pages were supplied or reviewed
   - No GEO optimization
   
   ### Content Audit Results
   
   | Content | Type | Published | Last Updated | Traffic Trend (periods compared) | Cadence check | Priority |
   |---------|------|-----------|--------------|----------------------------------|---------------|----------|
   | [Title 1] | [content type] | [date] | [date] | [+/-X]% ([period A] vs [period B]) | [that type's refresh frequency] — [gap since last update] | [matrix cell below] |
   | [Title 2] | [content type] | [date] | [date or "never"] | [+/-X]% ([period A] vs [period B]) | [that type's refresh frequency] — [gap since last update] | [matrix cell below] |
   
   ### Refresh Prioritization Matrix
   
   Not declining (flat or improving) = 🟢 Healthy — leave alone; does not enter the matrix
   High Traffic + High Decline = 🔴 Refresh Immediately
   High Traffic + Low Decline = 🟡 Schedule Refresh
   Low Traffic + High Decline = 🟡 Evaluate & Decide
   Low Traffic + Low Decline = 🟢 Low Priority
   ```

   **Filling that table** (author's rules, not report copy). Every cell comes from the inventory supplied, and the trend cell names the two periods it compares. A page the data does not cover keeps its row and carries "not supplied" there — stated, never interpolated, never converted into a priority.

   **The Type cell is not optional — it is what routes the row.** Fill it from the inventory's own content-type field where there is one, and from reading the page where there is not; then look that type up in *Update Strategy by Content Type* ([content-decay-signals.md](./references/content-decay-signals.md)), print that type's refresh frequency in the Cadence check cell beside the gap since the last update, and **schedule any page past that frequency on it, quoting the frequency**, whatever the traffic trend shows — a cadence nobody quotes is a cadence nobody applied. Two types leave the loop here: news/trend content is archived or redirected rather than refreshed, and a page the Content Retirement checklist catches is routed to retirement with a named option. The same Type cell picks the refresh-difficulty playbook when the batch is priority-scored. **A page scheduled on cadence is scheduled as maintenance and is reported that way** — being due on the calendar is not evidence of decay, and it never overrides what the numbers say: a page the evidence shows healthy, seasonal or awaiting tracking verification keeps that verdict and carries its cadence note beside it.

   **The matrix ranks declines, so a page that is not declining never enters it**: traffic flat or up on the comparison that governs the page (year-over-year where seasonality is in play), or a position that improved, reads 🟢 Healthy and is reported as healthy — growth is not a small decline and never becomes "Schedule Refresh". Hold the false positives out before splitting too: a month-over-month drop that the same-month year-over-year figure shows flat or up is seasonal (monitor, do not schedule), and a collapse alongside a near-stable position and a tracking-migration note goes to tracking verification before any decay diagnosis. High and low are then relative to the pages that remain: split their traffic figures at their median and their declines likewise, then say which figures and which split produced each quadrant. A page held out of the matrix still carries its Cadence check cell.

3. **Analyze Individual Content for Refresh**

   ```markdown
   ## Content Refresh Analysis: [Title]
   
   **URL**: [URL]
   **Published**: [date]
   **Last Updated**: [date]
   **Word Count**: [X]
   
   ### Performance Metrics
   
   | Metric | 6 Mo Ago | Current | Change |
   |--------|----------|---------|--------|
   | Organic Traffic | [X]/mo | [X]/mo | [+/-X]% |
   | Avg Position | [X] | [X] | [+/-X] |
   | Impressions | [X] | [X] | [+/-X]% |
   | CTR | [X]% | [X]% | [+/-X]% |
   
   ### Keywords Analysis
   
   | Keyword | Old Position | Current Position | Change |
   |---------|--------------|------------------|--------|
   | [kw 1] | [X] | [X] | ↓ [X] |
   | [kw 2] | [X] | [X] | ↓ [X] |
   | [kw 3] | [X] | [X] | ↓ [X] |
   
   ### Why This Content Needs Refresh
   
   1. **Outdated information**: [specific examples]
   2. **Competitive gap**: [what a dated SERP check or the user's competitor notes actually show, with that date and observer — notes carry coverage, a rank claim needs the check; if neither exists, this line reads "no competitor data was available" and carries no claim about what competitors have published]
   3. **Missing topics**: [new subtopics to cover]
   4. **SEO issues**: [current optimization problems]
   5. **GEO potential**: [AI citation opportunities]
   ```

   > **Branch — AI Overview displacement**: if the metrics above show CTR down 20-60% on ≥5 queries over 2-4 weeks while impressions hold (flat or rising) and rankings stay top-3, suspect an AI Overview above the organic results rather than ordinary decay. Run the diagnostic sequence, remediation order, verification ladder, and stop rules in [references/ai-overview-recovery.md](./references/ai-overview-recovery.md) before writing a generic refresh plan.

4. **Identify Specific Updates Needed**

   ```markdown
   ## Refresh Requirements
   
   ### Outdated Elements
   
   | Element | Current | Update Needed |
   |---------|---------|---------------|
   | Year references | "[old year]" | Update to [current year] |
   | Statistics | "[old stat]" | Find current data |
   | Tool mentions | "[old tool]" | Add newer tools |
   | Links | [X] broken | Fix or replace |
   | Screenshots | Outdated UI | Recapture |
   | SERP-feature claims | "[what the article promises Google shows]" | Correct only what is settled; open items are flagged for verification, never asserted either way — [refresh-templates.md](./references/refresh-templates.md) §"Correcting claims about SERP features" |
   | Core Web Vitals figures | "[old metric or threshold — e.g. FID, LCP 2.0 s]" | **Correct in place, do not route it back for verification**: "Good" is LCP ≤2.5 s, INP ≤200 ms, CLS ≤0.1. First Input Delay was retired in March 2024 and INP replaced it as the responsiveness metric; the 2.0-second LCP figure carried in older posts is a vendor number, not Google's |
   
   ### Missing Information
   
   **Topics covered by the competitor pages reviewed in this session** — the denominator is the
   number of pages actually read, named in the report; it is never a standing "out of 5":
   
   | Topic | Coverage | Words Needed | Priority |
   |-------|----------|--------------|----------|
   | [Topic 1] | [n] of [m] pages reviewed ([which ones]) | ~[X] words | [High/Med/Low] |
   | [Topic 2] | [n] of [m] pages reviewed ([which ones]) | ~[X] words | [High/Med/Low] |
   
   **No competitor pages reviewed and none supplied?** The table is not produced. Write exactly that
   — no competitor set was available, so missing-topic gaps are unassessed — say what two or three
   URLs would unlock, and leave the rows out. A competitor's rank, publication date or coverage
   reaches the report only as a dated observation with its observer ("checked in incognito, 10 Aug",
   "from your note of 7 Aug") — never as bare fact, never as a count nobody counted.
   
   ### SEO Updates Needed
   
   - [ ] Update title tag with current year
   - [ ] Refresh meta description
   - [ ] Add new H2 sections for [topics]
   - [ ] Update internal links to newer content
   - [ ] Add an FAQ section answering the query's real follow-ups — FAQ *content* is the deliverable; FAQPage markup only where the page passes the R2 both-things test, and then on the basis the ruling actually supports: it is valid schema.org, costs nothing to keep, and Google says there is no need to proactively remove it — a permission to leave existing markup alone, not Google advising anyone to keep it. Not that it earns AI citations — no primary source establishes that either way; and an ordinary site gets no FAQ rich result (Google restricted them to government/health sites, Aug 2023), so no SERP feature either (ruling R3 + amendment 9a)
   - [ ] Refresh images and add new alt text
   
   ### GEO Updates Needed
   
   - [ ] Add clear definition at start
   - [ ] Include quotable statistics with sources
   - [ ] Add Q&A formatted sections
   - [ ] Update sources with current citations
   - [ ] Create standalone factual statements
   ```

   > **On the two claim rows** (author's rule, not report copy): correct what `docs/loop/SETTLED-RULINGS.md` settles — the Core Web Vitals thresholds above are ruling R4 — and flag for verification only what it does not. Declining to state a figure the register already holds is the abstention overshoot (ledger F19); the rule, its stopping condition and its provenance are in [refresh-templates.md](./references/refresh-templates.md) §"Correcting stale technical claims".

5. **Create Refresh Plan** — Structural changes, content additions, statistics/links/images to update

   > **Reference**: See [references/refresh-templates.md](./references/refresh-templates.md) for the full refresh plan template (Step 5).

6. **Write Refresh Content** — Updated introduction, new sections, refreshed statistics, new FAQ section

   > **Reference**: See [references/refresh-templates.md](./references/refresh-templates.md) for the refresh content writing template (Step 6).

7. **Optimize for GEO During Refresh** — Clear definitions, quotable statements, Q&A sections, updated citations

   > **Reference**: See [references/refresh-templates.md](./references/refresh-templates.md) for the GEO enhancement template (Step 7).

8. **Generate Republishing Strategy** — Date strategy (update/add "last updated"/keep original), technical implementation, promotion plan

   > **Reference**: See [references/refresh-templates.md](./references/refresh-templates.md) for the republishing strategy template (Step 8).

9. **Create Refresh Report** — Summary of changes, updates completed, expected outcomes, next review date

   > **Reference**: See [references/refresh-templates.md](./references/refresh-templates.md) for the refresh report template (Step 9).

## Validation Checkpoints

### Input Validation
- [ ] Target content URL or title clearly identified
- [ ] Historical performance data available (traffic trends, rankings)
- [ ] Content publish/update dates known
- [ ] If comparing to competitors, competitor URLs provided — or a dated SERP check the operator ran; with neither, competitive findings are reported as unassessed, not inferred

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] Outdated elements identified with specific examples and replacement data
- [ ] All suggested additions include word counts and section locations
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Google Analytics 4, Google Search Console, Ahrefs), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every score in the deliverable carries its derivation beside it — the inputs, the arithmetic, the weights — for all four this skill emits: CORE-EEAT quick scores (Step 1), the composite decay score, the refresh priority score, and any ROI figure. A signal or factor with no input is shown N/A with the missing input named and the remaining weights renormalised; it is never estimated into a number (ledger F9-r3, [references/content-decay-signals.md](./references/content-decay-signals.md) "When a signal has no input")
- [ ] No third-party claim — a competitor's rank, publication date, coverage or "newer guide" — appears without the dated observation it came from
- [ ] No framework item ID inside the client report fence: the quick-score IDs and the veto flags sit in their own fence whose first line is `<!-- OPERATOR BLOCK … -->`, and a reader who copies only a fence can tell who it is for (anti-slop family 8; root `CLAUDE.md` § The Reader Test)

## Example

> **Reference**: See [references/refresh-example.md](./references/refresh-example.md) for a full worked example (cloud hosting refresh) and the comprehensive content refresh checklist.

## Tips for Success

1. **Prioritize by ROI** - Refresh high-potential content first
2. **Don't just add dates** - Make substantial improvements
3. **Beat competitors** - Add what they have and more
4. **Track results** - Monitor ranking changes post-refresh
5. **Schedule regular audits** - Check content health quarterly
6. **Optimize for GEO** - Every refresh is a GEO opportunity

> **Reference data**: For content decay signal taxonomy, lifecycle stages, refresh vs. rewrite decision framework, and update strategy by content type, see [references/content-decay-signals.md](./references/content-decay-signals.md).

## Reference Materials

- [Content Decay Signals](./references/content-decay-signals.md) — Decay indicators, lifecycle stages, and refresh triggers by content type
- [AI Overview Recovery Playbook](./references/ai-overview-recovery.md) — Trigger profile, four-case query segmentation, answer-first remediation, T+7/T+14/T+28 verification ladder, stop rules with entity-optimizer handoff
- [Refresh Templates](./references/refresh-templates.md) — Detailed output templates for steps 5-9 (refresh plan, content writing, GEO enhancement, republishing, report)
- [Refresh Example & Checklist](./references/refresh-example.md) — Full worked example and pre/post-refresh checklist

## Related Skills

- [content-gap-analysis](../../research/content-gap-analysis/) — Find what to add
- [seo-content-writer](../../build/seo-content-writer/) — Write new sections
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Enhance for AI
- [on-page-seo-auditor](../on-page-seo-auditor/) — Audit refreshed content
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit

