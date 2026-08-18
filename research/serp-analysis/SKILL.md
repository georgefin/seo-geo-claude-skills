---
name: serp-analysis
version: "4.4.1"
description: 'Analyze search engine results pages to understand ranking factors, SERP features, user intent patterns, and AI overview triggers. Use when the user asks to "analyze search results", "SERP analysis", "what ranks for", "SERP features", "why does this page rank", "featured snippets", "AI overviews", or "what does Google show for". For tracking rankings over time, see rank-tracker. For keyword discovery, see keyword-research.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
allowed-tools: WebFetch
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.4.1"
  geo-relevance: "high"
  tags:
    - seo
    - geo
    - serp
    - search results
    - ranking factors
    - serp features
    - ai overviews
    - featured snippets
    - search intent
    - serp-features
    - featured-snippet
    - google-ai-overview
    - ai-overview
    - people-also-ask
    - knowledge-panel
    - serp-composition
    - position-zero
    - serp-intent
  triggers:
    - "analyze search results"
    - "SERP analysis"
    - "what ranks for"
    - "SERP features"
    - "why does this page rank"
    - "featured snippets"
    - "AI overviews"
    - "what's on page one for this query"
    - "who ranks for this keyword"
    - "what does Google show for"
---

# SERP Analysis


This skill analyzes Search Engine Results Pages to reveal what's working for ranking content, which SERP features appear, and what triggers AI-generated answers. Understand the battlefield before creating content.

## When to Use This Skill

- Before creating content for a target keyword
- Understanding why certain pages rank #1
- Identifying SERP feature opportunities (featured snippets, PAA)
- Analyzing AI Overviews and AI Mode patterns
- Evaluating keyword difficulty more accurately
- Planning content format based on what ranks
- Identifying ranking factors for specific queries

## What This Skill Does

1. **SERP Composition Analysis**: Maps what appears on the results page
2. **Ranking Factor Identification**: Reveals why top results rank
3. **SERP Feature Mapping**: Identifies featured snippets, PAA, knowledge panels
4. **AI Overview Analysis**: Examines when and how AI answers appear
5. **Intent Signal Detection**: Confirms user intent from SERP composition
6. **Content Format Recommendations**: Suggests optimal format based on SERP
7. **Difficulty Assessment**: Evaluates realistic ranking potential

## How to Use

### Basic SERP Analysis

```
Analyze the SERP for [keyword]
```

```
What does it take to rank for [keyword]?
```

### Feature-Specific Analysis

```
Analyze featured snippet opportunities for [keyword list]
```

```
Which of these keywords trigger AI Overviews? [keyword list]
```

### Competitive SERP Analysis

```
Why does [URL] rank #1 for [keyword]?
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~search console + ~~AI monitor connected:**
Automatically fetch SERP snapshots for target keywords, extract ranking page metrics (domain authority, backlinks, content length), pull SERP feature data, and check AI Overview presence using ~~AI monitor. Historical SERP change data and mobile vs. desktop variations can be retrieved automatically.

**With manual data only:**
Ask the user to provide:
1. Target keyword(s) to analyze
2. SERP screenshots or detailed descriptions of search results
3. URLs of top 10 ranking pages
4. Search location and device type (mobile/desktop)
5. Any observations about SERP features (featured snippets, PAA, AI Overviews)

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests SERP analysis:

1. **Understand the Query**

   Clarify if needed:
   - Target keyword(s) to analyze
   - Search location/language
   - Device type (mobile/desktop)
   - Specific questions about the SERP

2. **Map SERP Composition**

   Document all elements appearing on the results page: AI Overview, ads, featured snippet, organic results, PAA, knowledge panel, image pack, video results, local pack, shopping results, news results, sitelinks, and related searches.

3. **Analyze Top Ranking Pages**

   For each of the top 10 results, document: URL, domain, domain authority, content type, word count, publish/update dates, on-page factors (title, meta description, H1, URL structure), content structure (headings, media, tables, FAQ), estimated metrics (backlinks, referring domains), and why it ranks.

4. **Identify Ranking Patterns**

   Analyze common characteristics across top 5 results: word count, domain authority, backlinks, content freshness, HTTPS, mobile optimization. Document content format distribution, domain type distribution, and key success factors.

5. **Analyze SERP Features**

   For each present SERP feature: analyze the current holder, content format, and strategy to win. Cover Featured Snippet (type, content, winning strategy), PAA (questions, current answers, optimization approach), and AI Overview (sources cited, content patterns, citation strategy).

   **Then read the features together, not only one at a time.** Which features co-occur is a finding in its own right, and it goes in the deliverable *before* the per-feature strategies, so a reader knows why two surfaces are being worked at once instead of meeting two strategies with no stated connection. Name the pairing you actually observed, say what this library reads it as, and say what it implies — the combination table in [references/serp-feature-taxonomy.md](./references/serp-feature-taxonomy.md) ("SERP Feature Combination Patterns") gives the read for the common pairings. It states what the composition tells *you*; it never states what an engine wants (ruling R3 amendment 9a).

6. **Determine Search Intent**

   Confirm primary intent from SERP composition. Document evidence, intent breakdown percentages, and content format implications (format, tone, CTA).

7. **Calculate True Difficulty**

   Score overall difficulty (1-100) from five factors — top 10 domain authority (25%), page authority (20%), backlinks required (20%), content quality bar (20%), SERP stability (15%). Each factor is converted to the same 1-100 sub-scale *before* it is weighted; the score is the weighted mean, rounded to a whole number, halves up. **A factor you cannot measure is dropped and the remaining weights are renormalised over their own sum — never scored 0**, which would claim the SERP is easy on that axis. Bands are `keyword-research` Step 6's: 70-100 High · 40-69 Medium · 1-39 Low. **When every factor drops, the renormalisation divides by zero and there is no score** — added 2026-08-17 after a blind run reached exactly that state and found the rule undefined. Emit **no number and no band**, print the five factors with the input each one needs, and say plainly that difficulty was not assessed. Do not reach for 0, for 50, or for a band: the instrument has no vocabulary for *unscored*, and inventing one inside the 1-100 scale would make an unmeasured SERP indistinguishable from a measured easy one.

   **Print the arithmetic beside the score**, in the deliverable: the sub-scores, the weights actually used, and any factor dropped with its reason (`75/100 (High) — DA 75 ×5, links 90 ×4, content bar 60 ×4, ÷13; page authority and stability not scored: no PA pull, single snapshot`). A difficulty a reader cannot recompute from the table above it is an opinion with a decimal point, and the next pull will not reproduce it. Conversion ladders, the quality-bar rubric and a worked renormalisation: [references/analysis-templates.md](./references/analysis-templates.md) → "How the difficulty score is built". Provide realistic assessments for new, growing, and established sites, plus easier alternatives — a tool's own Keyword Difficulty may stand in for an unanalysed alternative only if the tool is named and the figure is not ranked against this score, which is a different instrument.

8. **Generate Recommendations**

   Produce a summary with: Key Findings, Content Requirements to Rank (minimum requirements + differentiators), SERP Feature Strategy, Recommended Content Outline, and Next Steps.

   **Next Steps is an action table, and every action in it carries seven fields**: **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**. A SERP analysis ends in things somebody has to build — a page in the format the SERP rewards, a snippet-shaped answer block, an outline handed to a writer — and a finding with nobody to do it and nothing checkable is a suggestion. Fields 1-3 are **required**: no action ships without an owner-role and an acceptance criterion. Fields 4-7 take a stated-absence value where no answer exists (`not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect`) — never a blank and never an invention, because the absence is itself something the client can close.

   **Owner is a role**, not a person unless the client supplied the name: `Content` · `SEO/technical` · `Developer` · `Designer` · `Product/merchandising` · `Customer service` · `Legal/compliance` · `Agency` · `Client decision`. Which format to commit to is often a `Client decision` and assigning it makes that visible instead of leaving the action stalled; `unassigned — needs an owner` is legitimate and is itself a finding.

   **The acceptance-criterion test: could someone who was not part of this engagement check it six weeks from now, without asking anybody what was meant?** Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered — "the comparison table is live at the named URL carrying the five columns all three top results carry, checked by 30 Sep", not "match the SERP better". This is also where step 7's honesty has to carry through: a difficulty this run did **not** assess cannot become an acceptance criterion, and the action's dependency names the pull that would settle it.

   **A criterion never requires an engine to do something.** Winning a featured snippet, entering an AI Overview or reaching a position is nobody's to deliver, so none of them is ever the criterion. The criterion is the work shipped plus the re-capture recorded beside its dated baseline: "the 40-60 word answer block is live above the first H2, and the SERP was re-captured on the same location and device with the result recorded beside the [date] snapshot."

   **Ordering, stated once in the deliverable**: expected impact ÷ effort, with dependencies respected — an action whose dependency is unmet sorts below the thing it waits on, whatever its score.

   ```markdown
   <!-- SKELETON — the Next Steps table's seven columns. Every [slot] is filled from this run's
        own findings; fields 4-7 take their stated-absence value where no answer exists. Delete
        this comment when the table is filled. -->
   | # | Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
   |---|--------|-------|----------------------|-----------------|--------|--------------|--------------------|
   | 1 | [one imperative sentence naming the artefact and the change] | [role] | [observable · binary · named artefact or measurement · dated or triggered] | [measured from this SERP, or a working model labelled as one] | [S/M/L, or `not estimated`] | [named, or `none`] | [failure mode and cost, or `low — reversible, no downstream effect`] |
   ```

   The table is client-read: no skill slug, no `~~category` token, and none of this file's in-repo verification tags. Field definitions, the stated-absence values, worked criteria and the three permitted shapes of expected impact: [Action Output Contract](../../references/action-output-contract.md).

   > **Reference**: See [references/analysis-templates.md](./references/analysis-templates.md) for detailed templates for each step.

## Validation Checkpoints

### Input Validation
- [ ] Target keyword(s) clearly specified
- [ ] Search location and device type confirmed
- [ ] SERP data is current (date confirmed)
- [ ] Top 10 ranking URLs identified or provided

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] SERP composition mapped with all features documented
- [ ] Where two or more features co-occur, the combination is read as a signal in its own right — the pairing named, this library's read of it stated, and the implication drawn — before the per-feature strategies, never left implicit in the fact that both features got a strategy
- [ ] Ranking factors identified from actual top 10 analysis (not assumptions)
- [ ] Content requirements based on observed patterns in current SERP
- [ ] Difficulty is in exactly one of two states, and both are pass states. **Scored** — the sub-scores, the weights actually used and any dropped factor with its reason are printed beside the number, and the band is read off the rounded score. **Not assessed** (every factor dropped — the normal outcome on a single capture with no authority pull, not an edge case) — no number and no band anywhere in the deliverable, the five factors printed with the input each one needs, and the report says plainly that difficulty was not assessed. Either way, no factor is scored 0 for want of data, and neither 0, 50 nor a band stands in for the absent score
- [ ] Every share or distribution states its denominator — the intent breakdown counts classified SERP elements (`9 of 9`), the format and domain-type distributions use the number of results actually classified, and each set sums to its own denominator
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Otterly), "user-provided", or "manual observation"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every recommended action carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); none ships without an owner-role and an acceptance criterion, and the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding)
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — checkable six weeks on by someone who was not part of this engagement. **None requires an engine to do something**: a snippet win, an AI Overview appearance or a position is never the criterion, only the work shipped plus the re-capture recorded beside its dated baseline. The ordering rule (expected impact ÷ effort, dependencies respected) is stated once

## Greek Comparison-Shopping Surfaces (Skroutz, BestPrice, Google Shopping)

When the target market is Greek e-commerce, Skroutz.gr is a second SERP for this market and is audited alongside Google. [VERIFY — 2026-08-17] This line used to add that it is *"often the first stop for Greek shoppers on purchase-intent queries, ahead of Google"* — a consumer-behaviour claim with no source and no date, in a module whose own two reference files open with *"a number without a source in this file does not exist"*. Withdrawn; do not state it to a client. What stands without it: comparison platforms are a second search surface for this category, which is the reason to audit them. Audit Skroutz visibility alongside the Google workflow above; it supplements, not replaces, the Google analysis. Two further surfaces complete the Greek comparison-shopping picture: BestPrice.gr, a second comparison surface (**its vendor-measured magnitudes are not client-quotable** — the reference requires them resolved against a current primary source *before any client-facing claim*, which is stricter than "tagged unverified" and was being read here as permission to cite with a caveat), and Google's Shopping tab with free listings — live for Greece via Merchant Center (engine-primary), a zero-cost surface. See [references/greek-shopping-surfaces.md](./references/greek-shopping-surfaces.md); it cross-references the Skroutz checklist rather than duplicating it.

**Trigger conditions** (any of):
- Target market/locale is Greece and content type is product, category, or commercial-investigation
- Client sells through, or competes against sellers listed on, Skroutz
- User explicitly asks about Skroutz, BestPrice, or Google Shopping visibility in Greece

**What to audit** (full checklist in reference file):
1. Category/taxonomy placement accuracy
2. Price competitiveness vs. same-product (identical SKU) listings
3. Delivery-speed expectations — locker network coverage, speed badges
4. Trusted Reviews standing — volume, recency, response rate
5. Returns-policy compliance
6. Marketplace fee context (e.g., Skoop per-order fee) as a competitive-cost input, not a ranking factor
7. Shop rating and fulfillment SLA adherence

Report Skroutz findings as a clearly separated section alongside the Google SERP analysis — they are different, independently unpublished algorithms; do not merge their ranking-factor lists.

> **Reference**: See [references/skroutz-visibility-factors.md](./references/skroutz-visibility-factors.md) for the full factor checklist. Skroutz does not publish its ranking algorithm — every item is an observable lever to audit, not a confirmed weight.

## Greek Tourism Vertical (Seasonality & Hotel SERPs)

When the target market is Greece and the vertical is tourism/accommodation (hotel, destination, activity, or travel queries), load [references/greek-tourism-seasonality.md](./references/greek-tourism-seasonality.md) alongside the standard workflow. Tourism directly contributes 13% of Greek GDP (INSETE, 2025 figures), hotel SERP features are in DMA-driven flux (capture live SERPs — assume no layout), TripAdvisor/Booking review surfaces act as parallel visibility channels, and demand is seasonal in destination-specific patterns that must be measured, not assumed. Includes EL/EN/DE inbound-language keyword-set guidance with hreflang tie-ins.

## Example

> **Reference**: See [references/example-report.md](./references/example-report.md) for a complete example analyzing the SERP for "how to start a podcast".

## Advanced Analysis

### Multi-Keyword SERP Comparison

```
Compare SERPs for [keyword 1], [keyword 2], [keyword 3]
```

### Historical SERP Changes

```
How has the SERP for [keyword] changed over time?
```

### Local SERP Variations

```
Compare SERP for [keyword] in [location 1] vs [location 2]
```

### Mobile vs Desktop SERP

```
Analyze mobile vs desktop SERP differences for [keyword]
```

## Tips for Success

1. **Always check SERP before writing** - Don't assume, verify
2. **Match content format to SERP** - If lists rank, write lists
3. **Identify SERP feature opportunities** - Lower competition than #1
4. **Note SERP volatility** - Stable SERPs are harder to break into
5. **Study the outliers** - Why does a weaker site rank? Opportunity!
6. **Consider AI Overview optimization** - Growing importance


## Reference Materials

- [Analysis Templates](./references/analysis-templates.md) — Detailed templates for each analysis step (SERP composition, top results, ranking patterns, features, intent, difficulty, recommendations)
- [SERP Feature Taxonomy](./references/serp-feature-taxonomy.md) — Complete taxonomy of SERP features with trigger conditions, AI overview framework, intent signals, and volatility assessment
- [Example Report](./references/example-report.md) — Complete example analyzing the SERP for "how to start a podcast"
- [Skroutz Visibility Factors](./references/skroutz-visibility-factors.md) — Telegraphic checklist of observable Skroutz ranking levers for Greek e-commerce audits (algorithm unpublished — checklist, not confirmed weights)
- [Greek Shopping Surfaces](./references/greek-shopping-surfaces.md) — Comparison-shopping surfaces beyond Skroutz: BestPrice.gr levers, Google Shopping free listings for Greece (engine-primary), domestic review-platform indicator (companion to the Skroutz checklist)
- [Greek Tourism & Seasonality](./references/greek-tourism-seasonality.md) — Tourism-vertical module for Greek SERP audits: INSETE market context, hotel-SERP checks under DMA flux, review-surface levers, measured seasonality calendars, EL/EN/DE language splits
- [Action Output Contract](../../references/action-output-contract.md) — library-wide: the seven fields every Next Steps action carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule

## Related Skills

- [keyword-research](../keyword-research/) — Find keywords to analyze
- [competitor-analysis](../competitor-analysis/) — Deep dive on ranking competitors
- [on-page-seo-auditor](../../optimize/on-page-seo-auditor/) — Optimize based on findings
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Optimize for AI citations
- [meta-tags-optimizer](../../build/meta-tags-optimizer/) — Optimize SERP appearance with meta tags
- [rank-tracker](../../monitor/rank-tracker/) — Track keyword position changes in SERPs
- [performance-reporter](../../monitor/performance-reporter/) — Track SERP visibility metrics over time

