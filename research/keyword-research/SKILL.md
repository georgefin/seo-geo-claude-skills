---
name: keyword-research
version: "4.5.1"
description: 'Discover high-value SEO keywords with search intent analysis, difficulty scoring, topic clustering, and AI citation potential. Use when the user asks to "find keywords", "keyword research", "what should I write about", "keyword difficulty score", "identify ranking opportunities", "topic ideas", "what are people searching for", or "long-tail keyword suggestions". For competitor keyword gaps, see competitor-analysis. For topic coverage gaps, see content-gap-analysis.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.5.1"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - keywords
    - ahrefs
    - semrush
    - google-keyword-planner
    - kd-score
    - search-volume
    - cpc
    - topic-clusters
    - pillar-pages
    - long-tail-keywords
    - content-calendar
    - keyword-gap
    - search-intent-classification
  triggers:
    - "find keywords"
    - "keyword research"
    - "what should I write about"
    - "identify ranking opportunities"
    - "topic ideas"
    - "search volume"
    - "content opportunities"
    - "what are people searching for"
    - "which keywords should I target"
    - "give me keyword ideas"
---

# Keyword Research

Discovers, analyzes, and prioritizes keywords for SEO and GEO content strategies. Identifies high-value opportunities based on search volume, competition, intent, and business relevance.

## When to Use This Skill

- Starting a new content strategy or campaign
- Expanding into new topics or markets
- Finding keywords for a specific product or service
- Identifying long-tail keyword opportunities
- Understanding search intent for your industry
- Planning content calendars
- Researching keywords for GEO optimization

## What This Skill Does

1. **Keyword Discovery**: Generates comprehensive keyword lists from seed terms
2. **Intent Classification**: Categorizes keywords by user intent (informational, navigational, commercial, transactional)
3. **Difficulty Assessment**: Evaluates competition level and ranking difficulty
4. **Opportunity Scoring**: Prioritizes keywords by potential ROI
5. **Clustering**: Groups related keywords into topic clusters, and assigns each cluster one owning property and one owning URL
6. **GEO Relevance**: Identifies keywords likely to trigger AI responses

## How to Use

### Basic Keyword Research

```
Research keywords for [topic/product/service]
```

```
Find keyword opportunities for a [industry] business targeting [audience]
```

### With Specific Goals

```
Find low-competition keywords for [topic] with commercial intent
```

```
Identify question-based keywords for [topic] that AI systems might answer
```

### Competitive Context

```
Research keywords for [topic] — my main competitors are [competitor A] and [competitor B]
```

Competitor names are context for seed generation only. Full competitor keyword/gap analysis ("what does [competitor] rank for that I don't?") → hand off to [competitor-analysis](../competitor-analysis/), passing your domain, the competitor domains, and target keywords. Never present guessed competitor rankings, positions, or URLs as observed data — label any competitor-keyword guess explicitly as an assumption or estimate (hedging words like "likely" are not a label). **A characterisation of the set is a claim about the set**: what a competitor's ranking set is mostly about, which topics or query families they own, how many keywords they rank for, or what they would *not* rank for, are all covered — not just the three artefacts an export would contain. The licensed form is a numbered entry in the report's own Assumptions block, so the claim has somewhere to live rather than only somewhere it is banned from. This applies hardest in the paragraph where you argue against the user's plan, because making that argument requires characterising the competitor.

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~search console connected:**
Automatically pull historical search volume data, keyword difficulty scores, SERP analysis, current rankings from ~~search console, and competitor keyword overlap. The skill will fetch seed keyword metrics, related keyword suggestions, and search trend data.

**With manual data only:**
Ask the user to provide:
1. Seed keywords or topic description
2. Target audience and geographic location
3. Business goals (traffic, leads, sales)
4. Current domain authority (if known) or site age
5. Any known keyword performance data or search volume estimates

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests keyword research:

1. **Understand the Context — single turn by default**

   If the request already contains a seed topic plus market/language context, proceed immediately and list the stated assumptions at the top of the report. Ask clarifying questions only when genuinely blocked — no seed topic at all, or contradictory instructions; anything else missing becomes a stated assumption, not a question. Establish (from the prompt, or as a stated assumption):
   - What is your product/service/topic?
   - Who is your target audience?
   - What is your business goal? (traffic, leads, sales)
   - What is your current domain authority? (new site, established, etc.)
   - Any specific geographic targeting?
   - Preferred language?

   **Reply language**: a Greeklish prompt gets its reply in proper Greek (full diacritics); a prompt mixing Greek and English business language follows the language of the user's prose. Greeklish forms belong in keyword-targeting tables only, never in visible deliverable copy — placement rules: [references/greek-keyword-coverage.md](./references/greek-keyword-coverage.md).

2. **Generate Seed Keywords**

   Start with:
   - Core product/service terms
   - Problem-focused keywords (what issues do you solve?)
   - Solution-focused keywords (how do you help?)
   - Audience-specific terms
   - Industry terminology

3. **Expand Keyword List**

   For each seed keyword, generate variations:
   
   ```markdown
   ## Keyword Expansion Patterns
   
   ### Modifiers
   - Best [keyword]
   - Top [keyword]
   - [keyword] for [audience]
   - [keyword] near me
   - [keyword] [year]
   - How to [keyword]
   - What is [keyword]
   - [keyword] vs [alternative]
   - [keyword] examples
   - [keyword] tools
   
   ### Long-tail Variations
   - [keyword] for beginners
   - [keyword] for small business
   - Free [keyword]
   - [keyword] software/tool/service
   - [keyword] template
   - [keyword] checklist
   - [keyword] guide
   ```

4. **Expand Greek Seed Keywords (Dual-Coverage)**

   Greek users search tonos-optional (accents dropped) and often in Greeklish (Latin-script transliteration). Expand every Greek keyword to 4 forms — regardless of how it arrived (typed by the user, brainstormed in Steps 2-3, or imported from a tool export file) — one demand cluster for volume aggregation, distinct forms for placement:

   ```markdown
   ### Greek Dual-Coverage Pattern — what each form is, and where it goes

   | Form | Example | Placement |
   |------|---------|-----------|
   | (a) Accented Greek | κατασκευή ιστοσελίδων | Visible copy — titles, H1s, meta, body |
   | (b) Unaccented Greek | κατασκευη ιστοσελιδων | Search-engine normalization only — do not stuff as visible text |
   | (c) Greeklish | kataskevi istoselidon | Brand terms, domains, paid search |
   | (d) EN equivalent | web development Athens | Bilingual pages, EN-audience content |

   ### The artefact this step ships — ONE table, ONE row per demand

   | Demand | (a) Accented — visible copy | (b) Unaccented — no placement | (c) Greeklish — slugs, domains, paid search | (d) EN equivalent — EN-audience pages |
   |--------|------------------------------|-------------------------------|----------------------------------------------|----------------------------------------|
   | Plumber, Athens | υδραυλικός Αθήνα | υδραυλικος αθηνα | ydravlikos athina | plumber Athens |
   ```

   **The expansion is an artefact, not a transformation you do in your head.** It ships as the second table above — one row per Greek demand, one column per form, every cell a literal keyword string, placement carried in the headers. Never the forms scattered through prose, never one row per form, never a description of the transformation standing in for the string. A grid has visibly empty cells and prose does not, which is the point: a demand missing its Greeklish or its EN equivalent is a gap the reader can see. A form that genuinely does not exist for a demand says so in its own cell and why — no cell is blank. **This includes demands that arrived in a tool export**, which is where the step is most often skipped, because the list already looks finished: fold each export row into the demand it belongs to, then expand that demand like any other.

   Diacritic normalization (a ↔ b) is reliable in search matching; Greeklish (c) is not — target it explicitly (domains, brand terms, paid search bids) rather than relying on organic normalization. More forms and verticals: [references/greek-keyword-coverage.md](./references/greek-keyword-coverage.md).

   Greek keywords also inflect across case and number ("θήκη κινητού" ↔ "θήκες κινητών"): cluster and sum inflected variants the same way — but unlike forms (b)/(c), inflected forms are correct Greek and belong in visible copy, used naturally. See [Inflected Forms](./references/greek-keyword-coverage.md#inflected-forms-case-and-number-as-one-demand-cluster).

5. **Classify Search Intent**

   Categorize **every** keyword — including every GEO/conversational and local row — into one of these four. There is no fifth category:

   | Intent | Signals | Example | Content Type |
   |--------|---------|---------|--------------|
   | Informational | what, how, why, guide, learn | "what is SEO" | Blog posts, guides |
   | Navigational | brand names, specific sites | "google analytics login" | Homepage, product pages |
   | Commercial | best, review, vs, compare | "best SEO tools [current year]" | Comparison posts, reviews |
   | Transactional | buy, price, discount, order | "buy SEO software" | Product pages, pricing |

   **A blended query is labelled primary + secondary, both drawn from the four** — `Commercial (primary) / Informational (secondary)`, or the compound form `Informational → commercial`. Bare `Mixed` is not a classification: it names none of the four, and it tells a writer nothing about what to put on the page. Lead with the primary intent; the secondary decides what the page must also cover. A format or job label ("a download", "a job name") is not an intent either — it may sit beside one, never in place of one. Blended patterns, the primary/secondary tables and the classification-mistake table: [references/keyword-intent-taxonomy.md](./references/keyword-intent-taxonomy.md).

6. **Assess Keyword Difficulty**

   Score each keyword (1-100 scale):

   ```markdown
   ### Difficulty Factors
   
   **High Difficulty (70-100)**
   - Major brands ranking
   - High domain authority competitors
   - Established content (1000+ backlinks)
   - Paid ads dominating SERP
   
   **Medium Difficulty (40-69)**
   - Mix of authority and niche sites
   - Some opportunities for quality content
   - Moderate backlink requirements
   
   **Low Difficulty (1-39)**
   - Few authoritative competitors
   - Thin or outdated content ranking
   - Long-tail variations
   - New or emerging topics
   ```

7. **Calculate Opportunity Score**

   Formula: `Opportunity = (Volume × Intent Value) / Difficulty`

   **Intent Value** assigns a numeric weight by search intent:
   - Informational = 1
   - Navigational = 1
   - Commercial = 2
   - Transactional = 3

   **When an input is unavailable, do not compute the score.** With no tool connected and nothing supplied, Volume and Difficulty do not exist for this run, and inventing either produces a precise-looking ranking with nothing behind it. Instead: state the formula, name which inputs are unavailable and why, leave the Opportunity Score out, and rank on the factors you can actually score — the Priority Score in [references/keyword-prioritization-framework.md](./references/keyword-prioritization-framework.md), renormalised over the scoreable factors, with the rescaling stated (the denominator or the renormalised weights) and with the dropped factors named.

   On a zero-data run that leaves Business Relevance + Search Intent Match (0.30 + 0.15 = 0.45 of the matrix); Search Volume, Keyword Difficulty and Trend Direction (0.55 together) are unscoreable. Never reweight silently, and never label a reduced-factor ranking an Opportunity Score. Where only some keywords have the inputs (a partial export), score those and leave the rest explicitly unscored — do not fill the gap with a guess to make the column look complete.

   ```markdown
   ### Opportunity Matrix
   
   | Scenario | Volume | Difficulty | Intent | Priority |
   |----------|--------|------------|--------|----------|
   | Quick Win | Low-Med | Low | High | ⭐⭐⭐⭐⭐ |
   | Growth | High | Medium | High | ⭐⭐⭐⭐ |
   | Long-term | High | High | High | ⭐⭐⭐ |
   | Research | Low | Low | Low | ⭐⭐ |
   ```

8. **Identify GEO Opportunities**

   Keywords likely to trigger AI responses:
   
   ```markdown
   ### GEO-Relevant Keywords
   
   **High GEO Potential**
   - Question formats: "What is...", "How does...", "Why is..."
   - Definition queries: "[term] meaning", "[term] definition"
   - Comparison queries: "[A] vs [B]", "difference between..."
   - List queries: "best [category]", "top [number] [items]"
   - How-to queries: "how to [action]", "steps to [goal]"
   
   **AI Answer Indicators**
   - Query is factual/definitional
   - Answer can be summarized concisely
   - Topic is well-documented online
   - Low commercial intent
   ```

   **AI Potential stars are counted, not felt**: 1 star for the format match above, +1 per indicator met (1-5), printed as `⭐⭐⭐⭐ 4/5 — <the indicator that failed>` so the rating says what to write. Rules: [references/keyword-prioritization-framework.md](./references/keyword-prioritization-framework.md) → AI Potential Rating.

9. **Create Topic Clusters — and Assign Each One an Owner**

   Group keywords into content clusters, and finish each cluster by naming the property and the URL that will own it. Where the business runs one site that is a one-line answer; where it runs a main site plus other properties, two of its own URLs targeting one cluster is a collision, not coverage. **A cluster nobody has been assigned reads `no owner assigned` — a value and a finding to name in the prose, never a blank cell.** You propose the assignment and the reasoning; the client decides, and a row carrying no decision date is a proposal, not a decision. The owner is the property with the commercial conversion path for that intent, not whichever page currently ranks — tie-breakers, in order: existing authority for the cluster, then audience fit, then which property will actually be kept current.

   ```markdown
   ## Topic Cluster: [Main Topic]

   **Owning property**: [one domain] · **Owning URL**: [one absolute URL, or "to be created" with a date]
   **Language**: [el / en / both] · **Status**: [assigned / contested / no owner assigned]
   **Decided**: [date and who decided — empty means this is still a proposal]
   **Supporting properties**: [domain — the angle it takes], each linking to the owning URL

   **Pillar Content**: [Primary keyword] — volume [X], difficulty [X], comprehensive guide

   **Cluster Content**

   | Sub-topic | Volume | Difficulty | Intent | Links to | Content type |
   |-----------|--------|------------|--------|----------|--------------|
   | [Secondary keyword] | [X] | [X] | [intent] | Pillar | [Blog post / Tutorial] |
   | [Secondary keyword] | [X] | [X] | [intent] | Pillar + sub-topic 1 | [Blog post / Tutorial] |
   ```

   **A bilingual cluster is two rows or one, and the owning URL decides which.** Forms (a)-(c) of the Greek pattern in Step 4 are three ways of typing one demand in one language: they take one owner between them, and none of them justifies a second page or a second row. Form (d), the EN equivalent, serves a different audience — Greek-speaking users on one side, English-speaking residents, visitors, investors and international buyers on the other. Where the two audiences resolve to different URLs that is two rows with two owners; where one URL serves both, it is one row reading `Language: both`. Register columns, how to decide an owner, what to do when this run cannot, and worked bilingual examples: [references/cluster-ownership.md](./references/cluster-ownership.md).

10. **Map Local-Intent Keywords to GBP Surfaces**

    Local-intent keywords ("near me", [service] + city/neighborhood) map to more than website pages — map them to Google Business Profile surfaces too:

    Every keyword referenced here must already carry metrics in an analysis table above; a new target surfacing at this step first gets an analysis row (explained N/A allowed). A row naming a content topic or posting theme rather than a keyword target ("seasonal offers", "opening hours") is a content descriptor, not a new target, and needs no analysis row — but it must not be written as if it were a keyword you are targeting.

    | Keyword Type | Website Surface | GBP Surface |
    |---------------|-----------------|-------------|
    | Service + city ("υδραυλικός Αθήνα") | Service/location page | Products/Services description |
    | Question queries ("πόσο κοστίζει...") | FAQ section | Q&A — seed the top 3-5 |
    | Time-sensitive/offer ("ανοιχτά Κυριακή") | Homepage banner | Posts — refresh weekly, they expire |
    | Brand + Greeklish ("[brand] kataskevi") | Domain, meta title | Business name field |

    GBP fields are indexed and surface in Maps/Local Pack — treat them as a content destination, not a directory listing. Detail: [references/greek-keyword-coverage.md](./references/greek-keyword-coverage.md).

11. **Generate Output Report**

    Produce a report containing: Executive Summary, Top Keyword Opportunities (Quick Wins, Growth, GEO), Topic Clusters, Content Calendar, and Next Steps.

    **Metrics columns are universal in analysis tables**: every keyword analysis table in the deliverable — including GEO/conversational-query tables — carries Volume / Difficulty / Intent columns. When a metric is not tool-reported (typical for GEO conversational queries and GBP-driven local terms), the cell shows an explained N/A (e.g., "N/A — not tool-reported") — never an invented number. Placement/crosswalk tables (like Step 10's GBP mapping) reference keywords already metricized in an analysis table; a keyword target may not appear for the first time in a crosswalk — give it an analysis row (explained N/A allowed) first. "Estimated" is a source label only where the estimate has a stated basis (a range the user gave, a named proxy, a hand-check you describe); with no tool connected and nothing supplied there is nothing to estimate from — the cell carries the explained N/A and the report says so in plain words.

    > **Reference**: See [references/example-report.md](./references/example-report.md) for the full report template and example.

## Validation Checkpoints

### Input Validation
- [ ] Seed keywords or topic description clearly provided
- [ ] Target audience and business goals specified
- [ ] Geographic and language targeting confirmed
- [ ] Domain authority or site maturity level established

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] Every keyword analysis table (incl. GEO/conversational and local) carries volume / difficulty / intent columns — unreported metrics as explained N/A ("N/A — not tool-reported"), never invented; crosswalk tables only reference keywords already metricized above
- [ ] Any score whose inputs are missing is withheld with the formula stated and the missing inputs named — never computed from invented numbers; a reduced-factor ranking states its rescaling (denominator or renormalised weights) and which factors dropped out
- [ ] Every score, star rating and headline total in the report reproduces from the row or column printed beside it — the Opportunity Score from its own Volume/Difficulty/Intent cells, an AI Potential star count from its indicators, a summary total from the column it sums — and any figure that would need an assumption the report has not stated (volume converted to sessions, traffic potential) is either withheld or shipped with that assumption named
- [ ] No unlabelled claim about what a competitor ranks for — including what their ranking set is mostly about, which topics they own, or what they would not rank for. Each such claim is a numbered entry in the Assumptions block, or it is cut
- [ ] Every keyword — including every GEO/conversational and local row — carries one of the four intent categories, and a blended query carries a primary + secondary pair drawn from those four; never a bare `Mixed`, never a format label in place of an intent. Keywords grouped by intent and mapped to content types
- [ ] Topic clusters show clear pillar-to-cluster relationships
- [ ] Every cluster names its owning property and its owning URL, or states `no owner assigned` — and every `no owner assigned` is named in the prose as a finding with what would settle it, never left as a blank cell
- [ ] Every assignment this run proposes states its reasoning (the conversion path for that intent, then the tie-breaker if one was needed) and is described as a proposal until it carries a decision date; a bilingual cluster is one row where one URL serves both audiences and two rows where the URLs differ
- [ ] Greek-market keywords ship the Step-4 artefact (if applicable): ONE table, one row per demand, all four forms — accented, unaccented, Greeklish, EN equivalent — as literal keyword strings with placement stated per form. Demands that arrived in a tool export get a row like any other; a form that does not exist says so in its cell; no cell is blank and no form is left to prose
- [ ] Local-intent keywords mapped to GBP surfaces, not just website pages (if applicable)
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Semrush), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

> **Reference**: See [references/example-report.md](./references/example-report.md) for a complete example report for "project management software for small businesses".

### Advanced Usage

- **Intent Mapping**: `Map all keywords for [topic] by search intent and funnel stage`
- **Seasonal Analysis**: `Identify seasonal keyword trends for [industry]`
- **Competitor Gap → handoff**: competitor keyword/gap analysis belongs to [competitor-analysis](../competitor-analysis/) — refer the user there, passing your domain, the competitor domains, and any target keywords
- **Local Keywords**: `Research local keywords for [business type] in [city/region]`

## Tips for Success

1. **Start with seed keywords** that describe your core offering
2. **Don't ignore long-tail** - they often have highest conversion rates
3. **Match content to intent** - informational queries need guides, not sales pages
4. **Group into clusters** for topical authority
5. **Prioritize quick wins** to build momentum and credibility
6. **Include GEO keywords** in your strategy for AI visibility
7. **Review quarterly** - keyword dynamics change over time

## Reference Materials

- [Keyword Intent Taxonomy](./references/keyword-intent-taxonomy.md) — Complete intent classification with signal words and content strategies
- [Topic Cluster Templates](./references/topic-cluster-templates.md) — Hub-and-spoke architecture templates for pillar and cluster content
- [Keyword Prioritization Framework](./references/keyword-prioritization-framework.md) — Priority scoring matrix, categories, and seasonal keyword patterns
- [Example Report](./references/example-report.md) — Complete example keyword research report for project management software
- [Greek Keyword Coverage](./references/greek-keyword-coverage.md) — Diacritics/Greeklish dual-coverage patterns, inflection-set clustering (case/number), transliteration reference, and GBP surface mapping
- [Cluster Ownership](./references/cluster-ownership.md) — The ownership register's columns, how the owning property is decided (conversion path first, then the three tie-breakers), what to write when this run cannot decide, and how bilingual clusters become one row or two

## Related Skills

- [competitor-analysis](../competitor-analysis/) — See what keywords competitors rank for
- [content-gap-analysis](../content-gap-analysis/) — Find missing keyword opportunities
- [seo-content-writer](../../build/seo-content-writer/) — Create content for target keywords
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Optimize for AI citations
- [rank-tracker](../../monitor/rank-tracker/) — Monitor keyword position changes over time

