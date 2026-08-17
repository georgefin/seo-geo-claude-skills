---
name: rank-tracker
version: "4.3.0"
description: 'Track keyword ranking positions and SERP position changes over time, and track prompt-level AI visibility — what a generative engine actually says when a buyer asks a question. Use when the user asks to "track rankings", "check keyword positions", "monitor SERP positions", "how am I ranking", "where do I rank for this keyword", "did my rankings change", "ranking changes", "keyword position tracking", "track AI visibility", "am I cited by ChatGPT", or "prompt tracking". For automated alerting, see alert-manager. For comprehensive reports, see performance-reporter.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.0"
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
    - ai-visibility
    - prompt-tracking
    - prompt-set
    - citation-tracking
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
    - "track AI visibility"
    - "am I cited by ChatGPT"
    - "prompt tracking"
---

# Rank Tracker


Tracks, analyzes, and reports on keyword ranking positions over time, and separately tracks prompt-level AI visibility. Two instruments, two units: a **rank** is an ordinal position in a list an engine assembles from an index; an **AI answer** is generated text that may name a brand without citing it, cite a page without naming the brand, or answer the same prompt differently twice in one minute. Neither measurement stands in for the other, and this skill never converts one into the other.

## When to Use This Skill

- Setting up ranking tracking for new campaigns
- Monitoring keyword position changes
- Analyzing ranking trends over time
- Comparing rankings against competitors
- Tracking SERP feature appearances
- Monitoring AI Overview inclusions
- Measuring what a generative engine says when a buyer asks — prompt-level mention, citation and recommendation
- Building or re-versioning a tracked prompt set
- Creating ranking reports for stakeholders

## What This Skill Does

1. **Position Tracking**: Records and tracks keyword rankings
2. **Trend Analysis**: Identifies ranking patterns over time
3. **Movement Detection**: Flags significant position changes
4. **Competitor Comparison**: Benchmarks against competitors
5. **SERP Feature Tracking**: Monitors featured snippets, PAA
6. **AI Visibility Tracking (prompt-level)**: Runs a versioned prompt set across generative engines and records mention, citation and recommendation as three separate facts
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

### Track AI Visibility at the Prompt Level

```
Track AI visibility for [domain]: run our prompt set across ChatGPT, Gemini and Perplexity
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
Automatically pull ranking positions from ~~SEO tool, search impressions/clicks from ~~search console, traffic data from ~~analytics, and prompt-level visibility captures from ~~AI monitor. Daily automated rank checks with historical trend data.

**Before relying on a connected ~~AI monitor** (Peec AI, Otterly, Profound and Scrunch AI are the category's named examples in CONNECTORS.md), ask it four questions and record the answers beside the data: **which engines** it covers · **which of the twelve step-6 fields** it actually returns (whether cited URLs come back verbatim or collapsed to domains is the one that most often disappoints) · **how many repeats** per prompt per cycle it runs · **what date range** it can export. A platform that reports a mention rate without exposing N cannot satisfy step 6's N ≥ 3 rule on its own — state that gap rather than papering over it. Its own composite figure is quoted under its own name and never recomputed or blended.

**With no AI tool — the manual capture protocol** (sufficient for a 30-prompt set, and the zero-tier default):
1. Fresh logged-out session per engine; record locale and language.
2. Paste the prompt verbatim. No follow-up, and no rephrase after a poor answer — a rephrase is a different prompt and earns its own row.
3. Record all twelve step-6 fields, including the verbatim excerpt and every cited URL in full.
4. Repeat ×3 per prompt per engine, in one sitting.
5. Log failures with their reason; a failed capture is a row, not a deletion.

With neither tool nor capture: say exactly that and leave the figures out — no AI visibility data was collected, so no rate is stated, and the deliverable names what to collect so the next cycle can state it.

**With manual data only:**
Ask the user to provide:
1. Keyword ranking positions (current and historical if available)
2. Target keyword list with search volumes
3. Competitor domains and their ranking positions for key terms
4. SERP feature status (featured snippets, PAA appearances)
5. AI Overview citation data (if tracking GEO metrics)
6. Prompt-level AI captures (if tracking AI visibility) — the prompt set with its version, plus the step-6 fields per prompt × engine × date, failed captures included

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data, naming each source by its resolved name per the Output Validation source rule below — the connected tool's own name, or the plain-language source ("your 28-day Search Console export", "hand check, 10 Aug"), never a `~~category` token on a surface the client reads.

## Instructions

When a user requests rank tracking or analysis:

1. **Set Up Keyword Tracking** -- Configure domain, location, device, language, update frequency. Add keywords with volume, current rank, type, and priority. Set up competitor tracking and keyword categories (brand/product/informational/commercial). **Set the AI-visibility scope in the same pass**: which engines are in cycle and at what cadence, in the step-6 precedence order (1 ChatGPT Search · 2 Gemini and Google AI surfaces · 3 Perplexity on the full prompt set every cycle · 4 Google organic, which is tracked as ranking by steps 1-5 and is **a different instrument, not a lower priority** · 5 other assistants on a reduced head-prompt set at a lower cadence), plus the prompt-set version this cycle runs and the repeat count N.

   **Tracking artifact (persistence contract)** -- Every run produces a dated snapshot with **two kinds of row, stored side by side and never averaged together**. *Keyword rows*: keyword, position, ranking URL, SERP features, check date, data source. *Prompt rows*: one per prompt × engine × capture date, carrying the twelve step-6 fields plus the prompt-set version, and including the failed captures. The snapshot is a client-read surface, so **every** data-source cell -- keyword rows and prompt rows alike -- carries a **resolved** source and never a `~~category` token: the connected tool's own name ("Ahrefs", "Google Search Console", "Peec AI"), or the plain-language origin of a manual figure or capture ("user-provided hand check, 2026-08-10"; "hand capture, logged out, el-GR, 17 Aug 2026"), or -- where nothing was collected -- the cell is left empty and the absence is stated in prose. If [memory-management](../../cross-cutting/memory-management/) is active, hand the snapshot to it (hot-cache summary + dated snapshot in cold storage, per its conventions). Otherwise, save the snapshot to a file and confirm the location with the user. On every subsequent run, read the prior snapshot first -- it is the baseline for all change calculations, and for prompt rows it is also the record of which prompt-set version the prior figures covered.

2. **Mine Striking-Distance Queries (own GSC data)** -- When ~~search console is connected (or the user exports its query report), pull the tracked property's queries sitting at average positions ~5-20: the page-one tail plus page two, where demand is already proven and one push can move real clicks. Use this GSC-derived list first, before third-party rank data, whenever it is available. API mechanic: the Search Analytics API returns rows sorted by clicks and offers no position filter -- request a high rowLimit and filter the 5-20 window client-side; label the resulting metrics tool-measured. Prioritize by Opportunity = (Volume × Intent Value) / Difficulty where those inputs exist; when volume/difficulty are unavailable (manual tier), degrade gracefully to Impressions × Position Gap (position gap = current average position minus 1). Skip queries below an impression floor -- default 50 impressions in the pull window, a house default to tune per site (upstream defines none). Compute the Opportunity figure from the export's own unrounded values and print the multiplication beside the result. Append the mined rows to the dated snapshot from step 1's persistence contract. Queries whose ranking URL needs content work become [content-refresher](../../optimize/content-refresher/) refresh targets -- they are listed in the run's **operator handoff block** (step 8), not in client prose, and the client-facing action column names the job ("refresh this page") rather than the run handle. Boundary: this step only re-reads the tracked property's own Search Console data for positions it already holds -- discovering *new* keywords is a [keyword-research](../../research/keyword-research/) job, routed through the same block.

   > **Reference**: See [references/tracking-setup-guide.md](./references/tracking-setup-guide.md) Section 9 for the full mining methodology, defaults, and output format.

3. **Record Current Rankings** -- Ranking overview by position range (#1, #2-3, #4-10, #11-20, etc.), position distribution visualization, detailed rankings with URL, SERP features, and change.

4. **Analyze Ranking Changes** -- Overall movement metrics, biggest improvements and declines with hypothesized causes, recommended recovery actions, stable keywords, new rankings, lost rankings.

5. **Track SERP Features** -- Feature ownership comparison vs competitors (snippets, PAA, image/video pack, local pack), featured snippet status, PAA appearances.

6. **Track AI Visibility at the Prompt Level** -- the AI-visibility half of this skill, parallel in weight to steps 1-5 rather than a footnote to them. **The unit is a prompt, not a keyword.** "Position 4 for *dehumidifiers*" says nothing about what an assistant tells a buyer who describes their damp basement, and a per-keyword yes/no citation flag is not a substitute for asking.

   **6a -- Prompt set (a versioned artefact).** Build 30-60 prompts from: the client's own sales questions in the buyer's words (highest yield, needs no tool); ~~search console queries for the owning URLs, rewritten from query form into request form; the buying-stage ladder, one prompt per stage per cluster (problem-aware, solution-aware, brand-aware, decision); comparison prompts naming the client and each competitor, both directions; the [four Greek keyword forms](../../research/keyword-research/references/greek-keyword-coverage.md) where the site is Greek-language, since a prompt in one form is not a proxy for the others; and both languages where the audience is bilingual, as separate rows. Write prompts the way a person writes them -- no operators, no stuffing, no brand name unless a real user would include one, because a prompt engineered to produce a mention measures the engineering. Below ~20 prompts the rates have too small a denominator to move meaningfully. **Version the set, date each version, and state which version a figure covers**; the Metric Derivation Contract's rule 2 governs the prompt set exactly as it governs the tracked keyword list.

   **6b -- Engine precedence.** Work and report in this order: **1** ChatGPT Search · **2** Gemini and Google AI surfaces (AI Mode, AI Overviews) · **3** Perplexity · **4** Google organic search · **5** other assistants (Copilot, Claude, Bing Chat) on a reduced head-prompt set at a lower cadence, reported as a channel. Ranks 1-3 take the full prompt set every cycle and lead the report in that order; Perplexity's citation list is the most legible of the three, so it is the cheapest place to read *which URL* was used. **Rank 4 is a different instrument, not a lower priority** -- organic sits fourth in *prompt-level* work because prompts are not how it is measured. It is tracked as ranking in steps 1-5, it is the technical and authority substrate the other surfaces draw on, and the crawl, index, content and authority work it needs is not deprioritised by this ordering. **Say that in the deliverable wherever the order appears**, so no reader concludes organic was demoted. The order is a working priority for this audience, revisable on evidence -- never a claim about the engines.

   **6c -- What is recorded.** One row per **prompt × engine × capture date**, twelve fields: prompt (verbatim, with its set version) · brand mentioned · brand cited · recommendation position · cited URLs · owning property matched · competitors named · competitor citations · sentiment · answer excerpt · capture conditions · sample index. **Mentioned, cited and recommended are three separate tracked facts and are never merged.** Recommended first with nothing of the client's cited is an authority result with a content gap; cited without the brand named is an entity problem; mentioned inside a list the answer then advises against is a sentiment problem. Each has a different fix, so a report that says "AI visibility: present" has thrown away the diagnosis. **Cited URLs are recorded verbatim, full URL, never the domain** -- "they cited us" and "they cited our comparison page instead of our product page" are different findings and only the second is actionable. A row with no verbatim excerpt cannot be audited.

   **6d -- Sampling: one run is an observation, not a measurement.** Generated answers vary between runs for the same prompt, same day, same location. **N ≥ 3** repeats per prompt per engine per cycle, captured in one session, before any figure is reported as a rate; report **`k of N`** (2 of 3), never a bare percentage from one run. A single capture is reported as an **observation** carrying that word and its timestamp, never as what the engine does. Use a fresh session per capture where the surface personalises, and record which in the capture-conditions field. **Failed captures are recorded with their reason, not dropped** -- a refusal, a rate limit, an empty response: each is a row and each reduces N, and silently dropping them inflates every rate. A change between cycles is a **candidate**, not a result, until a second cycle repeats it.

   **6e -- Where each finding goes.** Cited but the wrong property of the client's = a cluster-ownership conflict. Mentioned but never cited = content and authority work on the owning URL. Cited but not mentioned = entity and brand work. Neither, with competitors present = a cluster-level gap. Negative sentiment routes to [alert-manager](../alert-manager/). Each leaves this skill as a row in the operator handoff block (step 8), with the client-facing prose naming the job instead.

   > **Reference**: See [../../references/ai-visibility-measurement.md](../../references/ai-visibility-measurement.md) for the twelve fields in full, the prompt-set sources, the sampling protocol, the derived metrics with their population rules, the manual capture protocol, and the conversion-linkage limits (assistant referral figures are a **floor**, labelled as one). Output formats: [references/ranking-analysis-templates.md](./references/ranking-analysis-templates.md) template 9 (prompt-level) and template 5 (the SERP-level AI Overview view) -- both belong to this step and record different observations, so neither is filled from the other.

7. **Compare Against Competitors** -- Share of voice table, head-to-head comparison per keyword, competitor movement alerts with threat level.

8. **Generate Ranking Report** -- Executive summary with overall trend, position distribution, key highlights (wins/concerns/opportunities), detailed analysis, SERP feature report, AI visibility (the prompt-level section, engines in precedence order, and the SERP-level AI Overview section as a separate read), competitive position, recommendations. Where the engine order appears, the report also says that organic search is measured with a different instrument rather than demoted.

   **Operator block (handoff contract)** -- Every report closes with one block carrying **two** labels: a visible one a reader sees rendered (`**Next steps for your team** -- *operator block; not part of the client report*`) and an in-fence comment that survives being copied (`<!-- OPERATOR BLOCK -- for whoever runs the skill library; not client copy -->`). Two labels because the two failure modes differ: a comment alone is invisible in a rendered report, and a heading alone is lost when a model copies the fence and not the heading above it. It is the **only** place in the deliverable where a run handle appears -- a skill name, a framework item ID, an internal artefact name. Client prose above it names the job instead ("refresh the boiler guide", "re-check that SERP"), because a handle names a tool the client does not have. One row per follow-up run, carrying what the receiving skill needs: target keyword, content type, the ranking URL, current and previous position with the check date and resolved source, the reason for the handoff, and any framework scores already on file (this skill computes no CORE-EEAT or CITE score, so those fields read "not computed by this skill" rather than being invented). The block is addressed to the operator, so it is an operator surface wherever it sits -- inside a client deliverable included.

   > **Reference**: See [references/ranking-analysis-templates.md](./references/ranking-analysis-templates.md) for output templates covering seven of these eight steps: its templates 1-7 map to steps 1, 3, 4, 5, 6, 7 and 8 in that order, its template 8 is the operator handoff block, and its template 9 is step 6's prompt-level half (template 5 stays step 6's SERP-level AI Overview view). Step 2's mining output format lives in the tracking setup guide §9 instead -- the templates file covers no step 2.

## Metric Derivation Contract

Every number this skill prints into a deliverable shows how it was reached, **beside the number** — not in a footnote, not only in a reference file. Three rules cover the whole set:

1. **Show the arithmetic next to the figure.** `Average position 15.4 → 12.8 (554/36 → 461/36)`; `positions 1-10: 17 of the 36 keywords ranked on both dates`; `Opportunity 6,720 = 840 impressions × 8.0 position gap`. A reader who cannot recompute a figure from the line it sits on has been handed an assertion, not a measurement.
2. **Define the population, then compare like with like.** Every average, count and percentage states which keywords it covers and over how many. Across two dates, hold the population constant or say why not: a keyword that entered or left the tracked set moves an average without any ranking having changed, and reporting that movement as a trend is the most common way this skill goes wrong. **This rule governs the prompt set identically** — a prompt added or reworded mid-cycle moves every step-6 rate with nothing having happened in the world, so each prompt-level figure names its prompt-set version and two compared cycles either hold that version constant or state the change and what it moved.
3. **No input, no figure.** A metric whose input was never collected is not estimated into existence — the cell is dropped and the prose names what to send so the next run can state it. **This skill defines no visibility score, no position-CTR curve and no traffic or revenue model of its own.** A visibility or traffic figure appears only when a connected tool or the client's own analytics reports it, carrying that source's name; a bare position→traffic claim about *this* site never appears. **No composite "AI visibility score" is defined either, and none is invented**: one number spanning engines, prompts and three different facts (mention, citation, recommendation) cannot be attributed when it moves. Where a connected tool publishes its own composite, it is quoted with that tool's name attached and is never recomputed, rescaled or blended with anything.

**Prompt-level figures (step 6)** obey all three rules and add one of their own: **each states N and its population beside the figure, per engine, and nothing is pooled across engines silently** — pooling hides the engine that is failing. Six derived rates, with the denominator that is easiest to get wrong named in each: *mention rate* = captures naming the brand ÷ successful captures · *citation rate* = captures citing any client URL ÷ successful captures, always printed **beside** mention rate and never instead of it · *owned-URL citation rate* = captures citing the cluster's owning URL ÷ captures citing **any** client URL · *average recommendation position* = mean of the recommendation-position field over **recommendation answers only** (stating it over all captures is the commonest error here) · *prompt-level share of voice* = client mentions ÷ (client + all named competitors' mentions), with the competitor set named because it sets the denominator · *cluster coverage* = clusters with ≥1 client citation ÷ clusters in the prompt set. The seventh figure in the reference, the *sentiment split*, is positive/neutral/negative **counts** and never a score; it is an input to the domain-authority instrument (item CITE-C08), which this skill does not compute. House format: `Mention rate 45% (23 of 51 successful captures — 17 prompts × 3 repeats, minus 0 failed), ChatGPT Search, prompt set v2`.

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
- [ ] Mentioned, cited and recommended are reported as three separate facts on three lines — never merged into one "AI visibility" verdict
- [ ] Every prompt-level rate carries N and its named population beside the figure, the engine is named on every figure, and nothing is pooled across engines silently
- [ ] Cited URLs are quoted verbatim and in full — never reduced to a domain
- [ ] The prompt-set version is stated once per deliverable
- [ ] A single capture is reported as an **observation**, carrying that word and its timestamp, never as what an engine does
- [ ] No promise of a position, a citation, an inclusion, a recommendation or a share of voice on any AI surface, on any timeline; what a deliverable states instead is the mechanism as a labelled working model, a leading indicator with its measurement plan, and the dated baseline with its N (anti-slop-ruleset.md §6 family 10)
- [ ] Where the engine order is shown, the deliverable also says that organic search is a different instrument rather than a demoted one

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

## AI Visibility — prompt set v2 (17 prompts), captured 9 April 2026

**Source**: hand capture, logged-out Chrome, en-GB, London, 3 repeats per prompt per engine.
153 captures attempted (17 prompts × 3 repeats × 3 engines), 149 successful, 4 failed — 2 rate
limits and 2 refusals. The 4 failures sit outside every denominator below and are listed with
their reasons in the capture log.
Engine order below is our working priority for your buyers; **Google organic search is measured
with a different instrument — the ranking sections above — and is not deprioritised by it.**

### ChatGPT Search

- **Mentioned in 23 of 51 successful captures (45%)** — 17 prompts × 3 repeats, 0 failed.
- **Cited in 9 of 51 (18%).** Reported beside the mention rate, not instead of it: the brand is
  named roughly two and a half times as often as any page of yours is used as a source.
- **Of the 9 citing captures, 5 cited** `https://example.com/blog/crm-comparison-2026` **and 4
  cited** `https://example.com/crm/pricing`. The pricing page is the one carrying the buying
  journey for this cluster, so the comparison post is absorbing more than half the citations
  that reach you.
- **Average recommendation position 2.4** — mean over the 8 captures that presented an ordered
  set of options (19/8 = 2.375, rounded to 1 decimal). The other 43 captures presented no
  recommendation set and are outside this figure.

### Gemini / Google AI surfaces

- **Mentioned in 11 of 49 successful captures (22%)** — 17 prompts × 3 repeats, minus 2 refusals.
- **Cited in 3 of 49 (6%).** For "best crm for small teams" specifically: mentioned in 2 of 3,
  cited in 0 of 3 — named, but nothing of yours used as a source.

### Perplexity

- **Mentioned in 19 of 49 successful captures (39%)**; **cited in 14 of 49 (29%)** — 17 prompts ×
  3 repeats, minus 2 rate limits.
- **Observation**, 9 April 2026 14:20 UTC: the one successful capture for "crm with quote builder"
  cited `https://example.com/features/quotes` second of five sources. One capture is an
  observation, not a rate — the other two repeats hit the rate limit, so N is 1 for this prompt
  and no percentage is stated for it.

No single AI visibility figure appears above, because one number across three engines and three
different facts could not be traced back to anything you could act on. Next cycle re-measures the
same 17 prompts on the same 3-repeat protocol against this baseline.

<!-- OPERATOR BLOCK — for whoever runs the skill library; not client copy -->
**Next steps for your team** — *operator block; not part of the client report*

| Follow-up run | Payload |
|---------------|---------|
| content-refresher | kw: marketing automation · type: guide · URL: /guide/marketing-automation · pos 4 → 12 (Ahrefs, 9 Apr 2026) · reason: page-1 exit · CORE-EEAT/CITE: not computed by this skill |
| serp-analysis | kw: pipeline reporting · type: feature page · URL: /features/reporting · pos 9 → 11 (Ahrefs, 9 Apr 2026) · reason: confirm SERP composition change · CORE-EEAT/CITE: not computed by this skill |
| content-refresher | prompt cluster: small-team CRM selection (prompt set v2) · type: comparison post · URL: /blog/crm-comparison-2026 · 5 of 9 citing captures on ChatGPT Search hit this post, owning URL /crm/pricing (hand capture, 9 Apr 2026) · reason: cluster-ownership conflict on an AI surface — non-owning property absorbing the citation · CORE-EEAT/CITE: not computed by this skill |
```

## Tips for Success

1. **Track consistently** - Same time, same device, same location
2. **Include enough keywords** - 50-200 for meaningful data
3. **Segment by intent** - Track brand, commercial, informational separately
4. **Monitor competitors** - Context makes your data meaningful
5. **Track SERP features** - Position 1 without snippet may lose to position 4 with snippet
6. **Measure AI visibility at the prompt** - A versioned prompt set, 3 repeats, `k of N`, and mention / citation / recommendation kept apart
7. **Re-run the same prompt set** - A reworded prompt moves every rate; version the set and say which version a figure covers

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

- [AI Visibility Measurement](../../references/ai-visibility-measurement.md) — The binding statement behind step 6: the prompt as the unit, the twelve recorded fields, the sampling discipline, the derived metrics and their population rules, the zero-tool capture protocol, and what may never be promised
- [Tracking Setup Guide](./references/tracking-setup-guide.md) — Configuration best practices, device/location settings, and striking-distance GSC mining methodology (Section 9)
- [Ranking Analysis Templates](./references/ranking-analysis-templates.md) — Output templates for seven of the eight workflow steps, the operator handoff block, and the prompt-level AI visibility template (template 9); step 2's mining format is in the setup guide §9
- [Metric Derivations](./references/metric-derivations.md) — Every figure this skill emits: formula, inputs, rounding, population rule, and what to do when the input is missing

## Related Skills

The names below are run handles for the operator. In a deliverable they appear only inside the operator handoff block (step 8); client prose names the job instead. Which skill a prompt-level finding routes to is set by [ai-visibility-measurement.md](../../references/ai-visibility-measurement.md) §6.

- [keyword-research](../../research/keyword-research/) — Find keywords to track
- [serp-analysis](../../research/serp-analysis/) — Understand SERP composition
- [alert-manager](../alert-manager/) — Set up ranking alerts
- [performance-reporter](../performance-reporter/) — Comprehensive reporting
- [content-refresher](../../optimize/content-refresher/) — Receives striking-distance queries whose URLs need content work as refresh targets
- [memory-management](../../cross-cutting/memory-management/) — Store ranking history in project memory

