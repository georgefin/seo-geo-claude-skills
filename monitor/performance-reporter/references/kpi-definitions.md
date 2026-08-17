# SEO/GEO KPI Definitions

Complete glossary of SEO and GEO key performance indicators with calculation formulas, data sources, benchmark ranges by industry, and interpretation guidance.

**Reading the Data Source rows**: they name a tool *category* (`~~analytics`, `~~search console`, …), because which product measures a KPI differs by organisation — see [CONNECTORS.md](../../../CONNECTORS.md). The category is for you, not for the reader of a report: when a Data Source row is carried into a deliverable, it resolves to the tool actually used, by name, or to the export or hand-check the figure came from, or to a plain statement that nothing supplied it and the figure is absent. A report's own source column is where this defect was first found (root `CLAUDE.md` Tool Connector Pattern; anti-slop-ruleset.md §6 family 7).

---

## 1. Organic Search KPIs

### Organic Sessions

| Attribute | Detail |
|-----------|--------|
| **Definition** | Number of visits to your site originating from organic (unpaid) search engine results |
| **Formula** | Count of sessions where medium = "organic" |
| **Data Source** | ~~analytics (Google Analytics, Adobe Analytics, or equivalent) |
| **Good Range** | Growing month-over-month; 3-10% MoM growth is healthy |
| **Warning** | Decline >10% MoM without known seasonal cause |
| **Segmentation** | Always separate brand vs. non-brand organic sessions |

**Interpretation:**
- Growing organic sessions with stable conversion rate = SEO strategy is working.
- Growing sessions but declining conversions = traffic quality issue; check keyword targeting.
- Flat sessions despite new content = content not ranking or cannibalizing existing pages.

---

### Organic Click-Through Rate (CTR)

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of search impressions that result in a click to your site |
| **Formula** | (Organic Clicks / Organic Impressions) x 100 |
| **Data Source** | ~~search console |
| **Good Range** | >3% overall; varies significantly by position and query type |
| **Warning** | <1.5% overall or declining trend |
| **Segmentation** | By query type (brand vs. non-brand), by page, by position range |

**Benchmarks by Position:**

| Position | Expected CTR Range |
|----------|-------------------|
| #1 | 25-35% |
| #2 | 12-18% |
| #3 | 8-13% |
| #4-5 | 4-8% |
| #6-10 | 2-5% |
| #11-20 | 0.5-2% |

**Interpretation:**
- High impressions but low CTR = title tags and meta descriptions need optimization.
- Site-wide CTR falling while every segment's CTR holds or rises = an impression-mix shift, not a snippet problem — decompose by share of impressions before blaming titles (see "Aggregate vs. segment divergence" under Trend Analysis Framework). Only where the segments themselves fell at stable positions is SERP features (AI Overview, PAA) stealing clicks the live hypothesis.
- CTR higher than position benchmarks = strong brand recognition or compelling snippets.

---

### Average Position

| Attribute | Detail |
|-----------|--------|
| **Definition** | Mean ranking position across all tracked keywords or queries |
| **Formula** | Sum of all positions / count of keywords |
| **Data Source** | ~~search console (query-level), ~~SEO tool (keyword-level) |
| **Good Range** | <20 for tracked keywords; improving trend |
| **Warning** | >30 or rising (worsening) trend |
| **Segmentation** | By keyword group, by page, by intent type |

**Interpretation:**
- Average position is a directional indicator, not an absolute measure. A few very low-ranking keywords can drag the average down significantly.
- Always pair with keyword distribution (how many keywords in top 10, top 20, etc.) for a complete picture.

---

### Keyword Visibility Score

| Attribute | Detail |
|-----------|--------|
| **Definition** | Weighted score combining keyword positions and search volumes into a single index |
| **Formula** | Sum of (estimated CTR at position x monthly search volume) for each keyword |
| **Data Source** | ~~SEO tool |
| **Good Range** | Growing over time; absolute value depends on niche |
| **Warning** | Declining trend for 3+ consecutive weeks |
| **Segmentation** | By topic cluster, by competitor |

**Interpretation:**
- Visibility score accounts for both ranking position and keyword importance (volume).
- A single high-volume keyword moving from #1 to #5 can cause a larger visibility drop than 20 low-volume keywords dropping off page 1.

---

### Pages Indexed

| Attribute | Detail |
|-----------|--------|
| **Definition** | Number of your pages included in Google's search index |
| **Formula** | Count of valid indexed pages in Index Coverage report |
| **Data Source** | ~~search console (Index Coverage / Pages report) |
| **Good Range** | Indexed count close to total intended indexable pages; growing with new content |
| **Warning** | Indexed count dropping without intentional removal; large gap between submitted and indexed |
| **Segmentation** | By sitemap, by content type, by subdirectory |

**Interpretation:**
- Indexed < submitted = quality or technical issues preventing indexing.
- Sudden drop in indexed pages = possible noindex tag, robots.txt change, or manual action.
- Indexed > intended = duplicate content, parameter URLs, or faceted navigation issues.

---

### Organic Conversion Rate

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of organic sessions that complete a defined conversion goal |
| **Formula** | (Organic Conversions / Organic Sessions) x 100 |
| **Data Source** | ~~analytics |
| **Good Range** | >2% for lead generation; >1% for e-commerce (varies by industry) |
| **Warning** | <0.5% or declining while traffic grows |
| **Segmentation** | By landing page, by keyword intent, by device |

**Industry Benchmarks:**

| Industry | Typical Organic CVR |
|----------|-------------------|
| SaaS / Software | 2-5% |
| E-commerce | 1-3% |
| Finance | 3-6% |
| Healthcare | 2-4% |
| B2B Services | 2-5% |
| Media / Publishing | 0.5-2% (ad-supported) |
| Education | 2-5% |

---

### Non-Brand Organic Traffic Share

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of organic traffic coming from non-branded search queries |
| **Formula** | (Organic sessions - brand query sessions) / Organic sessions x 100 |
| **Data Source** | ~~search console + ~~analytics |
| **Good Range** | >50% of total organic; growing |
| **Warning** | <30% (over-reliance on brand awareness, not SEO) |
| **Segmentation** | Trend over time |

**Interpretation:**
- High non-brand share = SEO is driving new audience discovery.
- Low non-brand share = organic traffic is mostly people who already know your brand; SEO is underperforming for acquisition.

---

## 2. GEO / AI Visibility KPIs

**The unit of every metric in this section is a prompt, not a keyword**, and the population is one
row per (prompt × engine × capture date). A rank is an ordinal position in a list an engine
assembles from an index; an AI answer is generated text that may name the brand without citing it,
cite a page without naming the brand, or answer the same prompt differently twice. The fields, the
prompt-set sources, the sampling protocol and the manual zero-tool capture protocol live in
[ai-visibility-measurement.md](../../../references/ai-visibility-measurement.md); the definitions
below are this skill's reporting forms of its §5 derived metrics.

**Three rules bind every figure in this section:**

1. **Per engine, never pooled.** Each rate is reported for one named engine. Pooling hides the
   engine that is failing, and the fix differs by engine.
2. **N and its population print beside the figure.** `62% (23 of 37 successful captures, 13 prompts
   × 3 repeats, 2 failed captures excluded from N)` is a measurement; `62%` is an assertion. N ≥ 3
   repeats per prompt per engine per cycle before any rate is reported as a rate; a single capture
   is an **observation**, reported with the word and its timestamp. Failed captures — refusals,
   rate limits, empty responses — are logged with their reason and reduce N; dropping them silently
   inflates every rate.
3. **No composite.** This library defines no "AI visibility score", and none is computed here. One
   number across engines, prompts and three different facts (mention, citation, recommendation)
   cannot be attributed when it moves and recovers no action. Where a connected tool reports its
   own composite, quote it with that tool's name attached, unchanged, and never recompute or blend
   it into a figure of ours.

**The prompt set is a versioned artefact.** Adding or rewording a prompt changes the population and
moves every rate below without anything having happened in the world — the same trap the keyword
population rule names for tracked keywords. Version the set, date each version, and state which
version a figure covers.

---

### Mention Rate (prompt-level)

| Attribute | Detail |
|-----------|--------|
| **Definition** | Share of successful captures, for one engine, in which the brand name appears in the answer text at all |
| **Formula** | Captures naming the brand ÷ total successful captures, reported as `k of N` alongside the percentage |
| **Data Source** | ~~AI monitor, or the manual capture protocol (fully sufficient for a 30-prompt set) |
| **Good Range** | No published benchmark exists and none is supplied from memory — the reference point is this site's own dated baseline |
| **Warning** | Falling across two consecutive cycles; a fall inside one cycle is a candidate, not a result |
| **Segmentation** | By engine (always), by cluster, by language where the audience is bilingual |

**Mentioned is not cited.** A brand can be recommended first with nothing of its own cited — that
is an authority result with a content gap, and it is a different finding with a different fix.

---

### Citation Rate (prompt-level)

| Attribute | Detail |
|-----------|--------|
| **Definition** | Share of successful captures, for one engine, in which a URL on a client property appears in the answer's sources or inline links |
| **Formula** | Captures citing any client URL ÷ total successful captures, as `k of N` plus the percentage |
| **Data Source** | ~~AI monitor, or the manual capture protocol |
| **Good Range** | This site's own dated baseline; no industry figure is held by this library |
| **Warning** | Citation rate holding while mention rate falls, or the reverse — the two are separate facts and diverge |
| **Segmentation** | By engine, by cluster |

**Always reported beside mention rate, never instead of it.** Cited-but-not-mentioned is an entity
and brand problem (the page earned its place, the brand did not stick); mentioned-but-not-cited is
a content and authority problem on the owning URL.

**Cited URLs are recorded verbatim, not as domains.** "They cited us" and "they cited our
comparison page instead of our product page" are different findings and only the second is
actionable.

---

### Owned-URL Citation Rate

| Attribute | Detail |
|-----------|--------|
| **Definition** | Of the captures that cited any client URL, the share that cited the URL the ownership register assigns to that cluster |
| **Formula** | Captures citing the cluster's owning URL ÷ captures citing any client URL |
| **Data Source** | The captured citation URLs, matched against the client's cluster-ownership register |
| **Good Range** | This site's own baseline; the figure is diagnostic rather than benchmarked |
| **Warning** | **A low figure against a high citation rate** — the engine is citing the wrong property of the client's. That is a cannibalisation finding, not an AI one, and it routes to the ownership contest |
| **Segmentation** | By cluster (always — the metric is meaningless site-wide), by engine |

Where no owner has been assigned for the cluster, the value is `no owner assigned` and that is
itself the finding — not a blank, and not a zero.

---

### Average Recommendation Position

| Attribute | Detail |
|-----------|--------|
| **Definition** | Where an answer presents an ordered or enumerated set of options, the client's ordinal within it, averaged over the captures where such a set existed |
| **Formula** | Mean of the recorded positions ÷ **count of recommendation answers only** |
| **Data Source** | ~~AI monitor, or the manual capture protocol |
| **Good Range** | This site's own baseline |
| **Warning** | Worsening across two consecutive cycles, or a shrinking count of recommendation answers underneath a stable mean |
| **Segmentation** | By engine, by cluster |

**The denominator is recommendation answers, not all captures** — computing it over all captures is
the most common error on this metric, and it silently rewards answers that recommended nothing.
Two further rules: an answer that recommends nothing has **no position** (not a zero, not a blank),
and `1` is never written for "the only brand mentioned" — that is a mention, recorded as one. State
the count the mean averages, and withhold a mean of fewer than three positions rather than printing
it.

**This is not a ranking and is never compared to one.** A recommendation ordinal and a search
position are different measurements on different instruments.

---

### Prompt-Level Share of Voice

| Attribute | Detail |
|-----------|--------|
| **Definition** | The client's share of all brand mentions across the captures for a cluster, on one engine |
| **Formula** | Client mentions ÷ (client mentions + all named competitors' mentions) |
| **Data Source** | The captured answers — the competitors the answers actually named, in the order named |
| **Good Range** | This site's own baseline |
| **Warning** | Falling while mention rate holds — the answer set is widening around the client |
| **Segmentation** | By engine and by cluster (both, always) |

**The competitor set is named wherever the figure appears**, because it *is* the denominator:
adding one competitor to the count moves the share without anything changing in the answers.

---

### Query-level AI-surface metrics — a different population, kept separate

The four definitions below measure **tracked keywords on AI answer surfaces**: does an AI Overview
appear for this query, and is the site cited in it. That is a SERP-feature reading of a keyword
list. The five prompt-level metrics above measure **generated answers to prompts**, captured with
repeats. Two populations, two instruments, and near-identical names — so every figure says which
one it is ("prompt-level mention rate", "tracked-query citation rate"), and **the two are never
averaged, blended, or compared as though they moved the same quantity.** A report may carry both;
it may not carry one under the other's name.

---

### AI Citation Rate

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of monitored queries where your content is cited in AI-generated answers |
| **Formula** | (Queries where you are cited / Total monitored queries with AI answers) x 100 |
| **Data Source** | ~~AI monitor |
| **Good Range** | >20% of monitored queries |
| **Warning** | <5% or declining trend |
| **Segmentation** | By topic cluster, by content type |

---

### AI Citation Position

| Attribute | Detail |
|-----------|--------|
| **Definition** | Your average position among cited sources in AI-generated responses |
| **Formula** | Sum of citation positions / count of citations |
| **Data Source** | ~~AI monitor |
| **Good Range** | Top 3 sources on average |
| **Warning** | Not cited or consistently cited in position 5+ |
| **Segmentation** | By query, by topic |

---

### AI Answer Coverage

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of your target topics that appear in AI-generated answers |
| **Formula** | (Topics with AI answers / Total target topics) x 100 |
| **Data Source** | ~~AI monitor |
| **Good Range** | Growing over time as AI answers expand |
| **Warning** | Declining coverage may indicate content quality issues |
| **Segmentation** | By topic cluster |

---

### Brand Mention in AI Responses

| Attribute | Detail |
|-----------|--------|
| **Definition** | Number of times your brand is mentioned in AI-generated responses across monitored queries |
| **Formula** | Count of AI responses containing your brand name |
| **Data Source** | ~~AI monitor |
| **Good Range** | Growing; present in responses for your key topics |
| **Warning** | Zero mentions for topics where you are an authority |
| **Segmentation** | By query category |

---

### AI Referral Sessions & Share

| Attribute | Detail |
|-----------|--------|
| **Definition** | Sessions arriving via a link inside an AI assistant's answer, identified by referral hostname. **A floor, not a total** — see the rule below |
| **Formula** | Count of sessions whose referral source matches the hostname roster below; Share = (AI referral sessions / total sessions) x 100. Both are lower bounds |
| **Data Source** | Three-source triangulation: ~~analytics (GA4 session source/medium + conversions), ~~search console AI-surface query/click data where exposed, server-log referrer + user-agent rows |
| **Good Range** | Share growing period-over-period |
| **Warning** | Share falling while AI citation metrics hold steady (the answer may still cite you but no longer link you) |
| **Segmentation** | By assistant hostname, by landing page, vs. organic sessions in the same window |

**AI referral hostname roster** — operational matching config, not a stable fact: assistant referrer hostnames churn, so re-check this list against current logs at the next weekly sweep before relying on it. **[VERIFY – roster ported 2026-08-08 via the G4 upstream harvest (aaron-marketing-skills v19.1.0, Apache-2.0); re-confirm hostnames each sweep]**

| Group | Hostnames |
|-------|-----------|
| Core roster | chatgpt.com, openai.com, perplexity.ai, copilot.microsoft.com, copilot.com, gemini.google, claude.ai, anthropic.com, edgeservices.bing.com |
| Legacy alias | bard.google.com |
| Optional (non-EL/EN markets) | deepseek.com, doubao.com, chat.qwen.ai, poe.com |

**Measurement rules:**

- **Every figure here is a floor, labelled as one.** Referrer-host identification is **partial by
  construction**: some assistant surfaces send no referrer, some strip it, and some of that traffic
  arrives as direct. The count is therefore a lower bound and is written as one — "at least 340
  sessions from assistant referrers in the window; the true figure is higher by an unmeasured
  amount" — never "340 sessions came from AI answers", which claims a total this method cannot
  produce. The label travels: a share whose numerator is a floor is itself a floor, and a
  period-over-period change between two floors is a change between two lower bounds, not a measured
  delta.
- **Conversion linkage is a correlation inside a named window, never causation and never a
  per-mention value.** "The 41 conversions on those landing pages fall in the same 28-day window as
  the referral sessions" is reportable. "Each AI mention is worth EUR X", "AI answers drove EUR Y",
  and any per-mention or per-citation revenue figure are not — nothing in this method measures a
  single answer's contribution
  ([ai-visibility-measurement.md](../../../references/ai-visibility-measurement.md) §5.1).
- **Control rule**: never attribute a traffic movement to AI answers from a raw delta. Keep a parallel holdout — an unchanged page of your own, a sibling URL, or a competitor page — and report delta-vs-control.
- **Caveat**: AI referral traffic proves an AI answer *linked* the site; it does not prove a prominent citation. Treat referral spikes as leads for citation checking (~~AI monitor or rank-tracker's GEO step), not as citation proof.
- **Labels**: GA4/GSC/log-derived counts are tool-measured; figures the client pastes in are user-provided; projections are estimated.

---

## 3. Domain Authority KPIs

### Domain Rating / Domain Authority

| Attribute | Detail |
|-----------|--------|
| **Definition** | Proprietary metric estimating the overall strength of a domain's backlink profile (0-100 scale) |
| **Formula** | Varies by tool (logarithmic scale based on backlink quantity and quality) |
| **Data Source** | ~~SEO tool (Ahrefs DR, Moz DA, or equivalent) |
| **Good Range** | Growing; competitive with top-ranking sites in your niche |
| **Warning** | Declining or significantly below competitors |
| **Segmentation** | Compare against competitors |

**Benchmarks by Site Stage:**

| Site Stage | Typical DR/DA |
|-----------|--------------|
| Brand new (0-6 months) | 0-15 |
| Early growth (6-18 months) | 15-30 |
| Established (18-36 months) | 25-50 |
| Mature (3+ years) | 40-70+ |
| Industry leader | 70-90+ |

---

### Referring Domains

| Attribute | Detail |
|-----------|--------|
| **Definition** | Count of unique domains that link to your site |
| **Formula** | Count of distinct root domains with at least one dofollow or nofollow link |
| **Data Source** | ~~link database |
| **Good Range** | Growing MoM; higher than primary competitors |
| **Warning** | Net loss of referring domains for 2+ consecutive months |
| **Segmentation** | By authority tier (DR 0-20, 20-40, 40-60, 60+) |

---

### Backlink Growth Rate

| Attribute | Detail |
|-----------|--------|
| **Definition** | Net new backlinks acquired per month |
| **Formula** | New backlinks gained - backlinks lost in the period |
| **Data Source** | ~~link database |
| **Good Range** | Positive and steady; proportional to content output |
| **Warning** | Negative for 2+ months; sudden spikes (may indicate spam) |
| **Segmentation** | By link quality tier |

---

### Toxic Link Ratio

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of your backlinks classified as toxic or spammy |
| **Formula** | (Toxic backlinks / Total backlinks) x 100 |
| **Data Source** | ~~link database (toxic score/spam score) |
| **Good Range** | <5% |
| **Warning** | 5-10% (monitor and clean up) |
| **Critical** | >10% (immediate disavow action needed) |
| **Segmentation** | By toxic type (PBN, spam, irrelevant) |

---

## 4. Technical SEO KPIs

### Core Web Vitals

| Metric | Definition | Good | Needs Improvement | Poor |
|--------|-----------|------|-------------------|------|
| **LCP** (Largest Contentful Paint) | Time to render largest content element | <=2.5s | 2.5-4.0s | >4.0s |
| **CLS** (Cumulative Layout Shift) | Visual stability during page load | <=0.1 | 0.1-0.25 | >0.25 |
| **INP** (Interaction to Next Paint) | Responsiveness to user interactions | <=200ms | 200-500ms | >500ms |

**Data Source:** ~~search console (Core Web Vitals report), Chrome UX Report, PageSpeed Insights

---

### Crawl Budget Utilization

| Attribute | Detail |
|-----------|--------|
| **Definition** | How efficiently search engine crawlers are spending their crawl budget on your site |
| **Formula** | (Useful pages crawled / Total pages crawled) x 100 |
| **Data Source** | ~~search console (Crawl Stats), server logs |
| **Good Range** | >80% of crawled pages are indexable, valuable pages |
| **Warning** | High crawl of non-indexable or low-value pages |
| **Segmentation** | By content type, by HTTP status code |

---

### Index Coverage Rate

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of submitted pages that are successfully indexed |
| **Formula** | (Indexed pages / Submitted pages) x 100 |
| **Data Source** | ~~search console |
| **Good Range** | >90% for sites with curated sitemaps |
| **Warning** | <80% or declining |
| **Segmentation** | By sitemap, by exclusion reason |

---

## 5. Content Performance KPIs

### Content Efficiency Score

| Attribute | Detail |
|-----------|--------|
| **Definition** | Ratio of content investment to organic traffic generated |
| **Formula** | Organic sessions per content piece / cost per content piece |
| **Data Source** | ~~analytics + internal cost tracking |
| **Good Range** | Improving over time; varies by content type |
| **Warning** | Declining efficiency despite continued investment |
| **Segmentation** | By content type, by topic, by author |

---

### Content Decay Rate

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of existing content losing organic traffic over a defined period |
| **Formula** | (Pages with >20% traffic decline over 6 months / Total pages with traffic) x 100 |
| **Data Source** | ~~analytics |
| **Good Range** | <20% of pages decaying per 6-month period |
| **Warning** | >30% of pages decaying |
| **Segmentation** | By content age, by topic, by content type |

---

### Organic Revenue Per Session

| Attribute | Detail |
|-----------|--------|
| **Definition** | Average revenue generated per organic search session |
| **Formula** | Total organic revenue / Total organic sessions |
| **Data Source** | ~~analytics (e-commerce tracking or goal values) |
| **Good Range** | Stable or growing; varies hugely by industry |
| **Warning** | Declining while traffic grows (traffic quality deteriorating) |
| **Segmentation** | By landing page, by keyword intent, by device |

---

## 6. Competitive KPIs

### Share of Voice (SOV)

| Attribute | Detail |
|-----------|--------|
| **Definition** | Your visibility as a percentage of total visibility across tracked keywords |
| **Formula** | (Your visibility score / Sum of all tracked competitors' visibility scores) x 100 |
| **Data Source** | ~~SEO tool |
| **Good Range** | Growing; leading in your core topic areas |
| **Warning** | Declining for 3+ consecutive months |
| **Segmentation** | By topic cluster, by competitor |

---

### Competitive Keyword Overlap

| Attribute | Detail |
|-----------|--------|
| **Definition** | Percentage of your tracked keywords where a specific competitor also ranks in the top 20 |
| **Formula** | (Keywords where both rank in top 20 / Your total tracked keywords) x 100 |
| **Data Source** | ~~SEO tool |
| **Good Range** | Context-dependent; high overlap for direct competitors is expected |
| **Warning** | New competitor appearing with high overlap indicates emerging threat |
| **Segmentation** | By competitor, by keyword group |

---

## 7. ROI and Business Impact KPIs

### SEO ROI

| Attribute | Detail |
|-----------|--------|
| **Definition** | Return on investment from SEO activities |
| **Formula** | ((Organic Revenue - SEO Investment) / SEO Investment) x 100 |
| **Data Source** | ~~analytics + internal cost tracking |
| **Good Range** | >200% annually (SEO compounds over time) |
| **Warning** | <100% after 12+ months of investment |
| **Segmentation** | By content type, by campaign |

**Note:** SEO ROI should be measured over 12+ month horizons. Short-term ROI calculations are misleading because SEO benefits compound over time.

---

### Organic Traffic Value

| Attribute | Detail |
|-----------|--------|
| **Definition** | Estimated cost to acquire equivalent traffic through paid search |
| **Formula** | Sum of (monthly organic clicks per keyword x CPC for that keyword) |
| **Data Source** | ~~SEO tool (traffic value calculation) |
| **Good Range** | Growing; significantly higher than SEO investment |
| **Warning** | Declining traffic value despite stable traffic (keywords losing CPC value) |
| **Segmentation** | By keyword group, by page |

**Interpretation:**
- Organic traffic value represents how much you would need to spend on PPC to get the same traffic.
- Useful for communicating SEO value to stakeholders who understand paid media budgets.
- A site with $50K/month organic traffic value that spends $10K/month on SEO is getting a 5:1 return.

---

## Quoting a Benchmark From This File

Every band, range and threshold in this file — the per-KPI **Good Range** and **Warning**
rows above as much as the summary tables below — is quoted into a report **verbatim**. Copy
it from the line, do not retype it from memory, and do not narrow, widen or round it on the
way: "3-10% MoM growth is healthy" is not "4-10%", and a report that states the band
correctly in one section and differently in another has contradicted itself in front of the
client.

Any figure **derived** from a band prints the arithmetic that produced it, multiplier
included, in the report where the reader can redo it:

> Our KPI reference calls 3-10% month-over-month growth healthy. From July's 2,890 sessions
> that is 2,890 × 1.03 = **2,977** at the low end and 2,890 × 1.10 = **3,179** at the high
> end for August.

A bare "3,006-3,179" fails this twice over: the reader cannot check it, and 3,006 is
2,890 × 1.04 — a band this file does not state. The rule holds inside goal tables and
proposal tables, which is exactly where the observed defect landed; a band that is being
*proposed* as a target is still being *quoted* as a benchmark.

---

## SEO/GEO Metric Definitions and Benchmarks

### Organic Search Metrics

| Metric | Definition | Good Range | Warning | Source |
|--------|-----------|-----------|---------|--------|
| Organic sessions | Visits from organic search | Growing MoM | >10% decline | ~~analytics |
| Keyword visibility | % of target keywords in top 100 | >60% | <40% | ~~SEO tool |
| Average position | Mean position across tracked keywords | <20 | >30 | ~~search console |
| Organic CTR | Clicks / impressions from search | >3% | <1.5% | ~~search console |
| Pages indexed | Pages in Google index | Growing | Dropping | ~~search console |
| Organic conversion rate | Conversions / organic sessions | >2% | <0.5% | ~~analytics |
| Non-brand organic traffic | Organic traffic minus brand searches | >50% of total organic | <30% | ~~analytics |

### GEO/AI Visibility Metrics

| Metric | Definition | Good Range | Warning | Source |
|--------|-----------|-----------|---------|--------|
| AI citation rate | % of monitored queries citing your content | >20% | <5% | ~~AI monitor |
| AI citation position | Average position in AI response citations | Top 3 sources | Not cited | ~~AI monitor |
| AI answer coverage | % of your topics appearing in AI answers | Growing | Declining | ~~AI monitor |
| Brand mention in AI | Times your brand is mentioned in AI responses | Growing | Zero | ~~AI monitor |
| AI referral sessions/share | Sessions referred from AI assistant hostnames; % of total sessions | Share growing PoP | Share falling with stable citations | ~~analytics + server logs |

### Domain Authority Metrics

| Metric | Definition | Good Range | Warning | Source |
|--------|-----------|-----------|---------|--------|
| Domain Rating/Authority | Overall domain strength | Growing | Declining | ~~SEO tool |
| Referring domains | Unique domains linking to you | Growing MoM | Loss >10% MoM | ~~link database |
| Backlink growth rate | Net new backlinks per month | Positive | Negative trend | ~~link database |
| Toxic link ratio | Toxic links / total links | <5% | >10% | ~~link database |

## Reporting Templates by Audience

### Executive Report (C-Suite / Leadership)

**Focus:** Business outcomes, ROI, competitive position
**Length:** 1 page + appendix
**Frequency:** Monthly or Quarterly

| Section | Content |
|---------|---------|
| Traffic & Revenue | Organic traffic trend + attributed revenue |
| Competitive Position | Visibility share vs. top 3 competitors |
| AI Visibility | AI citation trend and coverage |
| Key Wins | Top 3 achievements with business impact |
| Risks | Top 3 concerns with proposed mitigation |
| Investment Ask | Resources needed for next period |

### Marketing Team Report

**Focus:** Channel performance, content effectiveness, technical health
**Length:** 2-3 pages
**Frequency:** Monthly

| Section | Content |
|---------|---------|
| Keyword Performance | Rankings gained/lost, new keywords discovered |
| Content Performance | Top pages by traffic, engagement, conversions |
| Technical Health | Crawl errors, speed scores, indexation |
| Backlink Profile | New links, lost links, quality assessment |
| GEO Performance | AI citation changes, new citations |
| Action Items | P0-P3 prioritized task list |

### Technical SEO Report

**Focus:** Crawlability, indexation, speed, errors
**Length:** Detailed
**Frequency:** Weekly or Bi-weekly

| Section | Content |
|---------|---------|
| Crawl Stats | Pages crawled, errors, crawl budget usage |
| Index Coverage | Indexed/excluded/errored pages |
| Core Web Vitals | LCP, CLS, INP trends |
| Error Log | New 4xx/5xx errors with resolution status |
| Schema Validation | New warnings, rich result eligibility |
| Technical Debt | Outstanding issues by priority |

## Trend Analysis Framework

### Period-Over-Period Analysis

| Comparison | Best For | Limitation |
|-----------|---------|-----------|
| Week over week (WoW) | Detecting sudden changes | Noisy, affected by day-of-week patterns |
| Month over month (MoM) | Identifying trends | Seasonal bias |
| Year over year (YoY) | Accounting for seasonality | Does not reflect recent trajectory |
| Rolling 30-day average | Smoothing noise | Lags behind real changes |

### Trend Interpretation Guidelines

| Pattern | Likely Cause | Recommended Action |
|---------|-------------|-------------------|
| Steady growth | Strategy is working | Continue, optimize high performers |
| Sudden spike then drop | Viral content or algorithm volatility | Investigate cause, build on if repeatable |
| Gradual decline | Content decay, competition, technical debt | Comprehensive audit needed |
| Flat line | Plateau — existing strategy maxed out | New content areas, new link strategies |
| Seasonal pattern | Industry/demand cycles | Plan content calendar around peaks |

### Aggregate vs. Segment Divergence (Mix Shift)

A site-wide ratio can fall while every one of its parts rises, because the aggregate is
weighted by the size of each part. Whenever a site-wide CTR, conversion rate or average
position moves against the segments underneath it, the mix is the first explanation to test
and usually the right one — **run this decomposition before offering any mechanism**
(snippets, titles, SERP features, AI Overviews, an algorithm update).

The decomposition, on the ratio's own denominator — for CTR that denominator is
**impressions**, and a share of clicks answers a different question:

| Step | Prior period | Current period |
|------|--------------|----------------|
| 1. Segment the denominator (brand / non-brand / any new cluster) | 10,000 + 40,000 = 50,000 | 9,000 + 43,000 + 18,000 = 70,000 |
| 2. Each segment's share of it | non-brand 40,000/50,000 = **80.0%** | non-brand 61,000/70,000 = **87.1%** |
| 3. State the shift in percentage points | — | **+7.1 pp toward non-brand** |
| 4. Check each segment's own ratio | brand CTR 12.0%, established non-brand 2.0% | brand 13.0%, established non-brand 2.3%, new cluster 1.96% |

Read: every segment improved, and the site-wide CTR still fell, because a structurally
lower-CTR segment took 7.1 pp more of the impressions. That sentence — with the shares and
the pp shift printed — *is* the finding, and "our snippets got worse" is refuted by the same
table rather than merely left unsaid.

Average position takes the same treatment: Search Console weights it by impressions, so a
new cluster entering at position 14.9 raises the site-wide average with no existing ranking
having moved. Report the weighted arithmetic, not the site-wide number alone.

### Small Bases and Counterfactual Figures

A percentage computed on a small base moves violently, and saying so is worth a line — but
the line has to be arithmetically true. State the **exact perturbation** you are modelling
and compute the figure from it:

- Correct: "15 → 20 sessions is +33.3%, and one session either way moves it a long way: a
  June base of 16 gives +25.0% and 14 gives +42.9%; a July figure of 21 gives +40.0% and 19
  gives +26.7%."
- Wrong, and shipped once: "its own +33.3% is five sessions and would read as +20% or +47%
  if one session had fallen either way." Those two figures are 3/15 and 7/15 — a **two**-unit
  move with the base frozen. The arithmetic is reconstructible and the stated cause is still
  false by a factor of two.

If the perturbation you named and the number you printed do not reconcile, the number does
not go in the report. The same applies to run-rates, break-evens and any other "what if"
figure: name the assumption, then derive from it.

## SEO Attribution Guidance

### Attribution Challenges in SEO

| Challenge | Impact | Mitigation |
|----------|--------|-----------|
| Long conversion paths | SEO rarely gets last-touch credit | Use assisted conversions report |
| Brand vs. non-brand | Brand searches inflate organic metrics | Always separate brand/non-brand |
| Cross-device journeys | Mobile search to desktop conversion | Enable cross-device tracking |
| SEO + paid overlap | Cannibalization or lift? | Test turning off paid for branded terms |
| Content assists sales | Hard to attribute | Track content touches in CRM |

