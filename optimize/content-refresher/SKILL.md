---
name: content-refresher
version: "4.5.0"
description: 'Refresh old blog posts and outdated content with current statistics, new information, and freshness signals to restore search rankings. Use when the user asks to "update old content", "refresh content", "content is outdated", "improve declining rankings", "revive old blog posts", "traffic is declining on this page", "rankings dropped for this article", or "this post is outdated". For writing new content from scratch, see seo-content-writer. For auditing without rewriting, see on-page-seo-auditor.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.5.0"
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
   checked — and the IDs, the per-item grades and any failing veto travel in a fence of their own
   under **two labels, neither of which stands in for the other** — an in-fence comment (a model copies the fence, not the heading above it) and a visible line (an HTML comment resolves to nothing when the report is rendered, leaving the block unlabelled exactly where the client reads it):

   ```markdown
   <!-- OPERATOR BLOCK — for whoever runs this refresh, not part of the client report above. The
        ID column is a coordinate into the 80-item benchmark and is what a handoff carries.
        Nothing in this fence goes to the client as written. -->
   **CORE-EEAT quick scan** — *operator triage; not part of the client report*

   | Dimension | Score | Items graded (Pass 10 / Partial 5 / Fail 0 · N/A held out of the denominator) |
   |---|---|---|
   | [dimension] | [X]/100 — [P] pts over [n] | [IDs with their grades, e.g. C02, C03 Pass; C01 Partial; C09 Fail] |

   **Veto flagged**: [`CORE-EEAT-C01` / `CORE-EEAT-R10` / `CORE-EEAT-T04` where a material
   connection exists · `CORE-EEAT-T04 unassessable` where one may exist and nothing here settles
   whether it is disclosed · or "none"]. The quick pass flags; the full 80-item audit rules and
   applies the score cap — except after an unassessable veto, where it issues no final score at all.
   ```

   One row per dimension scored. **This scan is not a dimension score and never becomes one**: it is
   an estimate over the handful of items it checked, so it never travels to another run as a
   `CORE-EEAT C:… O:…` string — what travels is the failing item IDs and how many items were checked
   ([inter-skill-handoff.md §4.3](../../references/inter-skill-handoff.md)). What the client gets
   from the scan is the plain-language weakness column above. For the full 80-item audit, hand off to
   [content-quality-auditor](../../cross-cutting/content-quality-auditor/).

   **Three rules the template cannot hold, in full in
   [refresh-templates.md](./references/refresh-templates.md) §"Step 1".** (a) `"none"` on the veto
   line is a finding — it asserts that no material connection exists — so where one plausibly exists
   and nothing you hold settles disclosure, write `CORE-EEAT-T04 unassessable` and name what would
   settle it; never "none", never a label of your own. (b) A title, a URL, an inventory row or
   somebody's summary is **not the page**: dimensions that miss the three-item bar read "not
   assessed", and where none of the eight reaches it there is no quick scan to issue. (c) **Content
   Type** here is plain description that routes nothing — the scan applies no weight profile, so it
   needs no content-type column from the benchmark and improvises none.

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
   | Tool mentions | "[old tool]" | Name the tool's current status, the vendor notice that establishes it, and the replacement the vendor names; where the status cannot be established, flag the line for confirmation rather than dropping the tool and leaving the section with no product in it |
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
   - [ ] Add an FAQ section answering the query's real follow-ups — FAQ *content* is the deliverable; FAQPage markup only where the page genuinely is both its primary type and an FAQ resource, each complete and independently justified, and then claiming nothing for it: it is valid schema.org, costs nothing to keep, and Google says there is no need to proactively remove it — a permission to leave existing markup alone, not advice to keep it. No AI-citation benefit is established either way, and an ordinary site gets no FAQ rich result: since 2023-08-08 Google shows those only for well-known, authoritative government and health websites (source: Google Search Central blog, "Changes to HowTo and FAQ rich results", 2023-08-08, `developers.google.com/search/blog/2023/08/howto-faq-changes`), so no SERP feature is promised
   - [ ] Refresh images and add new alt text
   
   ### GEO Updates Needed
   
   - [ ] Add clear definition at start
   - [ ] Include quotable statistics with sources
   - [ ] Add Q&A formatted sections
   - [ ] Update sources with current citations
   - [ ] Create standalone factual statements
   ```

   > **On the three claim rows** — SERP-feature claims, Core Web Vitals figures, Tool mentions (author's rule, not report copy). The first two are engine claims: correct what `docs/loop/SETTLED-RULINGS.md` settles — the Core Web Vitals thresholds above are ruling R4, and the FAQ checkbox is ruling R2's both-things test plus R3 amendment 9a — and flag for verification only what it does not. **Ruling handles are operator vocabulary**: cite R2/R3/R4 in working notes, and give the client the figure and, where one is on file, the source (root `CLAUDE.md` § The Reader Test). Declining to state a figure the register already holds is the abstention overshoot (ledger F19). **The third row is not an engine claim and the register is not its stopping condition** — a vendor's product status is settled by that vendor, never by `SETTLED-RULINGS.md`, so reading the engine rule onto it silences the run permanently on a decay signal this skill grades High risk. The rules, their stopping conditions, how far each one's backing actually goes, and how a product-status correction ships are in [refresh-templates.md](./references/refresh-templates.md) §"Correcting claims about SERP features" and §"Correcting stale technical claims".

5. **Create Refresh Plan** — Structural changes, content additions, statistics/links/images to update

   **The plan is the action surface, so every line of it is an action and carries seven fields**: **action** (one imperative sentence naming the section or element and the change), **owner**, **acceptance criterion**, **expected impact**, **effort**, **dependencies**, **risk if done wrong**. Fields 1-3 are required — a plan line with no owner-role and nothing checkable is a suggestion, and the step-4 checkboxes above ("Update title tag with current year", "Add clear definition at start") are exactly that until this step gives them the other six. Fields 4-7 take a stated-absence value: `not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect` — never a blank and never an invention. **Owner is a role** from a closed list (Content · SEO/technical · Developer · Designer · Product/merchandising · Customer service · Legal/compliance · Agency · Client decision), never a person unless the client supplied the name; `Client decision` is a real owner — the right one for the republish-date call and for retiring a page — and `unassigned — needs an owner` is legitimate and is itself a finding.

   **The acceptance-criterion test: could someone who was not part of this engagement check it six weeks from now, without asking anybody what was meant?** Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered — "the intro is rewritten and live on the production URL, leading with the room-size answer, and the two retired FID figures are gone from the page" rather than "content refreshed". **A refresh priority, a decay score and a next-review date are none of them criteria**: the first two say how it ranked, the third says when to look again, and neither says what state proves the work finished. **And no criterion may require an engine to do something** — a position, a snippet, an AI Overview citation or an appearance in a generated answer is nobody's to deliver, and writing one turns the action into a promise (the same rule the AI Overview recovery playbook's verification ladder already runs on). An AI-surface line is accepted on the work shipped plus the measurement re-run at T+7/T+14/T+28 and recorded beside its dated baseline. **Expected impact obeys this skill's own derivation rule**: this page's own measured figures with the arithmetic shown, or a mechanism labelled a working model — never a position or traffic target, which step 9's Expected Outcomes table already refuses. **Ordering** is the existing refresh prioritisation (🔴/🟡/🟢 and the priority score), stated once; no second impact ÷ effort vocabulary beside it. Field table, stated-absence values, worked criteria and the role list: [Action Output Contract](../../references/action-output-contract.md).

   > **Reference**: See [references/refresh-templates.md](./references/refresh-templates.md) for the full refresh plan template (Step 5), whose Refresh Actions table carries the seven columns.

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
- [ ] The page's own text is in hand — pasted, fetched or supplied as a file. A title, a URL or a description of the page is not the page, and Step 1 reports which dimensions that leaves unassessed rather than estimating them
- [ ] If comparing to competitors, competitor URLs provided — or a dated SERP check the operator ran; with neither, competitive findings are reported as unassessed, not inferred

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] Outdated elements identified with specific examples and replacement data
- [ ] All suggested additions include word counts and section locations
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Google Analytics 4, Google Search Console, Ahrefs), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every score in the deliverable carries its derivation beside it — the inputs, the arithmetic, the weights — for all four this skill emits: CORE-EEAT quick scores (Step 1), the composite decay score, the refresh priority score, and any ROI figure. A signal or factor with no input is shown N/A with the missing input named and the remaining weights renormalised; it is never estimated into a number (ledger F9-r3, [references/content-decay-signals.md](./references/content-decay-signals.md) "When a signal has no input")
- [ ] No third-party claim — a competitor's rank, publication date, coverage or "newer guide" — appears without the dated observation it came from
- [ ] Every line of the refresh plan carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); no line ships without an owner-role and an acceptance criterion, and the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding). The step-4 update checkboxes are not actions until this plan gives them the other six fields
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — a refresh priority, a decay score and a next-review date are none of them criteria. **None requires an engine to do something**: an AI-surface line is accepted on the work shipped plus the T+7/T+14/T+28 re-measurement recorded beside its dated baseline, never on a citation or a position. The existing refresh prioritisation is the report's one ordering vocabulary, stated once
- [ ] No framework item ID inside the client report fence: the quick-score IDs and the veto flags sit in their own fence carrying **both** labels — `<!-- OPERATOR BLOCK … -->` as its first line **and** a visible `**CORE-EEAT quick scan** — *operator triage; not part of the client report*` line directly under it — so that a reader who copies only a fence **and** a reader handed only the rendered report can each tell who it is for. A comment alone renders to nothing; a heading alone is lost on copy (anti-slop family 8; root `CLAUDE.md` § The Reader Test, clause 2)

## Example

> **Reference**: See [references/refresh-example.md](./references/refresh-example.md) for a full worked example (cloud hosting refresh) and the comprehensive content refresh checklist.

## Tips for Success

> **Reference**: The six working rules for a refresh run — prioritise by ROI, substantive change rather than a new date, cover what the reviewed competitor pages cover, track results after republishing, audit content health quarterly, and treat every refresh as a GEO opportunity — are in [references/content-decay-signals.md](./references/content-decay-signals.md) § Tips for Success, beside the reference data they rest on: decay signal taxonomy, lifecycle stages, the refresh vs. rewrite decision framework, and update strategy by content type.

## Reference Materials

- [Content Decay Signals](./references/content-decay-signals.md) — Decay indicators, lifecycle stages, and refresh triggers by content type
- [AI Overview Recovery Playbook](./references/ai-overview-recovery.md) — Trigger profile, four-case query segmentation, answer-first remediation, T+7/T+14/T+28 verification ladder, stop rules with entity-optimizer handoff
- [Refresh Templates](./references/refresh-templates.md) — Step 1's three quick-scan rules (unassessable veto, no page text, content-type label), plus the detailed output templates for steps 5-9 (refresh plan, content writing, GEO enhancement, republishing, report) and the two claim-correction rules
- [Refresh Example & Checklist](./references/refresh-example.md) — Full worked example and pre/post-refresh checklist
- [Action Output Contract](../../references/action-output-contract.md) — library-wide: the seven fields every refresh-plan line carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and why an AI-surface criterion is a measurement criterion), and the ordering rule

## Related Skills

- [content-gap-analysis](../../research/content-gap-analysis/) — Find what to add
- [seo-content-writer](../../build/seo-content-writer/) — Write new sections
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Enhance for AI
- [on-page-seo-auditor](../on-page-seo-auditor/) — Audit refreshed content
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit

