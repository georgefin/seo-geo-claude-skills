# Gap Analysis Frameworks

Complete frameworks for systematic keyword gap identification, content format gap analysis, funnel stage gap mapping, opportunity scoring models, and content calendar integration. Use these frameworks to transform gap analysis from ad-hoc observation into repeatable process.

## Overview

Content gap analysis answers three questions:
1. **What are competitors covering that you are not?** (Keyword and topic gaps)
2. **What content formats are expected but missing?** (Format gaps)
3. **Where in the buyer journey does your content fail?** (Funnel gaps)

This reference provides structured methodologies for each question, plus scoring and prioritization systems.

---

## 1. Systematic Keyword Gap Methodology

### Step-by-Step Process

#### Step 1: Define Your Keyword Universe

Before finding gaps, establish what you already rank for:

| Data Source | What It Provides | How to Collect |
|------------|-----------------|---------------|
| ~~search console | Keywords driving impressions and clicks to your site | Export Performance report (last 6 months) |
| ~~SEO tool | Full keyword profile including positions 1-100 | Domain keyword export |
| Content audit | Topics covered by existing content | Manual or automated URL crawl + categorization |

**Output:** A master list of all keywords you currently rank for (positions 1-100).

#### Step 2: Build Competitor Keyword Profiles

For each competitor (3-5 recommended):

| Competitor | Total Keywords | Keywords in Top 10 | Keywords in Top 3 | Estimated Traffic |
|-----------|---------------|-------------------|-------------------|------------------|
| [Competitor A] | [Count] | [Count] | [Count] | [Monthly est.] |
| [Competitor B] | [Count] | [Count] | [Count] | [Monthly est.] |
| [Competitor C] | [Count] | [Count] | [Count] | [Monthly est.] |
| **You** | [Count] | [Count] | [Count] | [Monthly est.] |

#### Step 3: Calculate Keyword Overlap

Identify four keyword segments:

```
┌──────────────────────────────────────────────────────────┐
│                                                          │
│  A: Keywords ONLY you rank for (your unique advantage)   │
│                                                          │
│  B: Keywords you AND competitors share (competitive)     │
│                                                          │
│  C: Keywords ONLY competitors rank for (your gaps)       │
│                                                          │
│  D: Keywords NO ONE ranks for (market opportunity)       │
│                                                          │
└──────────────────────────────────────────────────────────┘
```

| Segment | Size | Strategic Meaning | Action |
|---------|------|------------------|--------|
| A (Only you) | [Count] | Your content moat | Protect and strengthen |
| B (Shared) | [Count] | Competitive battleground | Improve rankings |
| C (Only them) | [Count] | Your content gaps | Prioritize and create |
| D (No one) | [Count] | Untapped market | Evaluate and pioneer |

#### Step 4: Filter and Categorize Gaps (Segment C)

Not all gaps are worth filling. Filter by:

| Filter | Threshold | Purpose |
|--------|-----------|---------|
| Minimum search volume | >100/month (adjust for niche) | Ensure traffic potential |
| Maximum keyword difficulty | <your domain's competitive range | Ensure you can rank |
| Business relevance | Must relate to your product/service | Ensure strategic fit |
| Intent match | Must match content types you can create | Ensure execution capability |

**Where this run has no volumes, the minimum-volume row is not skipped — the proxy carries it.**
The named demand proxy (§4 below, SKILL.md Step 9) supplies the floor in its own units, chosen and
printed before any gap is scored: "cluster depth ≥ N articles across the competitors counted", with
N stated. **Naming a proxy is a property of the run; a floor is what a single keyword can fail** —
every keyword in a proxied run "carries the named proxy" equally, so a proxy with no floor leaves
this row empty. Nothing downstream refills it: §4's Quick Win Score *adds* Search Demand rather than
gating on it, so a gap at the bottom Demand band still reaches the moderate quick-win band.

**After filtering, categorize remaining gaps:**

| Category | Description | Example |
|----------|-----------|---------|
| Topic gaps | Entire topics you haven't covered | Competitor has 10 articles on "technical SEO"; you have zero |
| Depth gaps | You cover the topic but competitor goes deeper | You have 1 blog post; competitor has a pillar page + 8 cluster articles |
| Angle gaps | Same topic but different perspective or audience | Competitor targets enterprise; you could target SMB |
| Format gaps | Same keyword but different content format | Competitor has a video tutorial; you only have text |
| Freshness gaps | Same topic but their content is more current | Competitor updated in 2026; yours is from 2024 |

#### Step 5: Prioritize Gaps

Use the scoring model from Section 4 below.

---

## 2. Content Format Gap Analysis

### Format Audit Methodology

#### Step 1: Inventory Your Content Formats

Categorize all your published content:

| Format | Count | % of Total | Avg. Traffic/Page | Top Performer |
|--------|-------|-----------|-------------------|--------------|
| Blog posts (text) | [X] | [X]% | [X] | [URL] |
| Long-form guides | [X] | [X]% | [X] | [URL] |
| How-to tutorials | [X] | [X]% | [X] | [URL] |
| Comparison/vs pages | [X] | [X]% | [X] | [URL] |
| Case studies | [X] | [X]% | [X] | [URL] |
| Templates/downloads | [X] | [X]% | [X] | [URL] |
| Interactive tools | [X] | [X]% | [X] | [URL] |
| Video content | [X] | [X]% | [X] | [URL] |
| Infographics | [X] | [X]% | [X] | [URL] |
| Original research/data | [X] | [X]% | [X] | [URL] |
| Glossary/definitions | [X] | [X]% | [X] | [URL] |
| Webinars/recordings | [X] | [X]% | [X] | [URL] |
| Podcasts/audio | [X] | [X]% | [X] | [URL] |

#### Step 2: Benchmark Against Competitors

| Format | You | Comp A | Comp B | Comp C | Competitor Avg | Why the format earns a slot |
|--------|-----|--------|--------|--------|----------------|-----------------------------|
| Blog posts | [X] | [X] | [X] | [X] | [X] | Table stakes |
| Long-form guides | [X] | [X] | [X] | [X] | [X] | Expected for authority |
| How-to tutorials | [X] | [X] | [X] | [X] | [X] | Expected for SEO |
| Comparison pages | [X] | [X] | [X] | [X] | [X] | Required for commercial |
| Case studies | [X] | [X] | [X] | [X] | [X] | Expected for B2B |
| Templates | [X] | [X] | [X] | [X] | [X] | Lead gen standard |
| Interactive tools | [X] | [X] | [X] | [X] | [X] | Differentiator |
| Video | [X] | [X] | [X] | [X] | [X] | Growing expectation |
| Original research | [X] | [X] | [X] | [X] | [X] | Linkbait standard |
| Glossary | [X] | [X] | [X] | [X] | [X] | GEO opportunity |

**Last two columns**: `Competitor Avg` is the mean of the Comp A-C counts on that row — the quantity
this step's own heading names, computable from what you just counted, and reported with its basis
beside it ("mean of the 3 competitor columns"). The right-hand column is this skill's editorial
reason a format earns a slot; it carries no number and is not a measurement, which is why it is no
longer headed "Industry Benchmark". This workflow counts the competitors you named, never an
industry, so an industry column has nothing behind it — and a benchmark cell with nothing behind it
gets filled anyway, because the cell exists (statistics rule: sourced, cited, or placeholder, never
invented). A published industry benchmark may be added as a further column only when you have read
it: name the publisher, the year and the sample, and link it. Same basis, same wording, as the
`Competitor Avg` column in `analysis-templates.md`.

#### Step 3: Identify Format Gaps

For each format you are missing or underrepresenting:

| Missing Format | Competitor Proof | Estimated Effort | Expected Impact | Priority (from the §4 score) |
|---------------|-----------------|-----------------|----------------|---------|
| [Format 1] | [Which competitor succeeds + traffic est.] | [Low/Med/High — High effort is Creation Effort 1, not 5] | [Low/Med/High] | [P0-P3 + the Gap Priority Score it was read from] |
| [Format 2] | [Evidence] | [Effort] | [Impact] | [Tier + score] |

#### Step 4: Format-SERP Feature Alignment

Certain formats unlock specific SERP features:

| Content Format | Unlocks SERP Feature | Schema Required |
|---------------|---------------------|----------------|
| FAQ sections | PAA eligibility; a visible Q&A block answering the query's real follow-ups (no FAQ rich result for ordinary sites — restricted to government/health, Aug 2023) | FAQPage only where the page's one primary type IS FAQPage; claim no citation benefit |
| Step-by-step tutorials | How-To rich results, Featured Snippet (list) | HowTo |
| Review/comparison content | Review stars, AI Overview citations | Review, AggregateRating |
| Video content | Video carousel, Video rich result | VideoObject |
| Product pages | Shopping results, Product rich results | Product |
| Event pages | Event rich results | Event |
| Glossary/definitions | Featured Snippet (paragraph), AI Overview | DefinedTerm (optional) |
| Data tables | Featured Snippet (table), AI Overview | Table (optional) |

---

## 3. Funnel Stage Gap Identification

### Funnel Coverage Mapping

#### Step 1: Define Funnel Stages and Content Expectations

**This skill uses four funnel stages — Awareness, Consideration, Decision, Retention — and uses
them everywhere**: here, in SKILL.md Step 8, and in the Audience Journey template. Four is the
count the deliverable reports against, so a seven-stage split counted here would not fit the
table it feeds. The finer vocabulary is not lost; each of the four absorbs its neighbours, and
the fold is shown in the Mindset and Format columns below so a page written for "Intent" or
"Advocacy" still has an obvious home.

| Funnel Stage | Absorbs | User Mindset | Content Need | Expected Formats | Typical Keywords |
|-------------|---------|-------------|-------------|-----------------|-----------------|
| **Awareness** | Interest | "I have a problem/question" → "I want to learn more" | Educational content, then deeper education | Blog posts, infographics, social content, guides, webinars, email courses | "what is", "how to", "why does", "guide to", "tutorial", "examples" |
| **Consideration** | — | "What are my options?" | Comparison and evaluation | Comparison posts, reviews, case studies, alternatives pages | "best", "vs", "review", "alternatives" |
| **Decision** | Intent, Purchase | "I'm narrowing my choices" → "I'm ready to act" | Decision-support content, then conversion content | Demos, free trials, pricing pages, ROI calculators, product pages, signup forms | "pricing", "demo", "free trial", "buy", "sign up", "get started" |
| **Retention** | Advocacy | "I need help/value" → "I want to share/recommend" | Support and engagement, then shareable and referral content | Help docs, tutorials, community, newsletters, review programs, referral incentives | "[product] how to", "support", "[product] review", "recommend" |

#### Step 2: Audit Content by Funnel Stage

For each stage, count your content and compare to competitors:

| Funnel Stage | Your Content Count | Comp A | Comp B | Competitor Avg | Gap Size | Gap Severity |
|-------------|-------------------|--------|--------|----------------|----------|-------------|
| Awareness | [X] | [X] | [X] | [X] | [+/- X] | [Low/Med/High/Critical] |
| Consideration | [X] | [X] | [X] | [X] | [+/- X] | [Low/Med/High/Critical] |
| Decision | [X] | [X] | [X] | [X] | [+/- X] | [Low/Med/High/Critical] |
| Retention | [X] | [X] | [X] | [X] | [+/- X] | [Low/Med/High/Critical] |

**Gap Size is arithmetic, and the report shows it**: `your count − competitor mean`, with the
mean taken over the competitor columns actually counted in this table and its basis stated
("mean of 2 competitor columns"). A negative figure means they have more. Every page is counted
once, in exactly one stage, so the stage counts sum to the site's total counted pages — state
that total, because a stage table that does not reconcile to it has either double-counted a page
or silently dropped one.

**Gap Severity Criteria:**

| Severity | Definition |
|----------|-----------|
| Critical | Zero content at this stage; users drop off here |
| High | Significantly less content than competitors; measurable conversion drop |
| Medium | Somewhat less content; competitors have advantage but you are present |
| Low | Roughly on par; minor opportunities for improvement |

#### Step 3: Identify Drop-Off Points

Map your analytics data to funnel stages to find where users leave:

| Transition | Metric to Check | Drop-Off Signal | Content Gap Likely |
|-----------|----------------|----------------|-------------------|
| Awareness → Consideration | Bounce rate on blog posts | >70% bounce rate | Missing "next step" content or CTAs |
| Awareness → Consideration | Pages per session | <2 pages/session | Missing comparison/evaluation content |
| Consideration → Decision | Demo/trial requests | Low conversion from comparison pages | Missing trust content (case studies, reviews) |
| Within Decision (to conversion) | Cart/signup abandonment | High abandonment rate | Missing objection-handling content |
| Decision → Retention | Churn rate | High early churn | Missing onboarding/help content |

The two Awareness → Consideration rows are two independent signals on the same transition, not a
double count; the last row sits inside Decision because this skill folds Purchase into Decision
(Step 1). A drop-off row is a **symptom**, and reading it as a content gap is an inference —
label it Likely at best, and name the content that would test it, rather than reporting the
missing page as observed.

---

## 4. Opportunity Scoring Model

### Multi-Factor Gap Scoring

Score each identified gap on 5 factors (1-5 scale each):

| Factor | Weight | Score 1 (Low) | Score 3 (Medium) | Score 5 (High) |
|--------|--------|--------------|-----------------|----------------|
| **Search Demand** | 25% | <100 monthly searches | 500-2,000 searches | >5,000 searches |
| **Competitive Density** | 20% | All competitors cover it well | 1-2 competitors cover it | No competitor covers it |
| **Business Relevance** | 25% | Tangential to your offering | Related to your offering | Core to your offering |
| **Creation Effort** | 15% | Requires new capabilities | Moderate effort | Quick to create |
| **Conversion Potential** | 15% | Pure awareness (top-funnel) | Consideration stage | Decision/transactional stage |

**All five factors point the same way: 5 is always the value most favourable to you.** That is
worth saying out loud for the two that read as costs. **Creation Effort** scores the *ease* of
creation — 5 is "quick to create", 1 is "requires new capabilities". **Competitive Density**
scores the *room* available — 5 is "no competitor covers it", 1 is "all of them cover it well".
Both therefore enter every score in this section **added, never subtracted**. Subtracting either
one inverts the ranking and buries the cheapest, least-contested gaps at the bottom of the list,
which is the opposite of what both scores exist to find. Check the direction of any scoring
column you add against this line before you sum anything.

**Gap Priority Score** = Σ (Factor Weight x Score)

Weights are decimals — 25% is 0.25, and the five sum to 1.00 — so the score lands in 1.0-5.0, the tier range below. Reading them as whole percents gives 100-500 and reaches no tier.

**Every score prints its working next to itself.** A gap's row shows the five factor scores, the
weighted line that produced the total, and the rounded total that the tier was read from —
`0.25×4 + 0.20×5 + 0.25×4 + 0.15×2 + 0.15×3 = 3.75 → P1`. A reader who cannot recompute the
number from the row above it has been handed a ranking, not an analysis, and two runs of the
same data must land on the same figure. Which figures this skill can and cannot produce, what
each one is composed of, and the pre-send recompute pass:
[score-arithmetic.md](./score-arithmetic.md).

**When a factor cannot be scored.** Search Demand is banded in monthly search volume, so with no SEO tool connected and nothing supplied it has no input; the Quick Win Score below consumes the same factor. Do not guess it. Either score it from a **named proxy** and state that basis in the report (competitor cluster depth, the site's own analytics sessions on adjacent pages), or **drop the factor** and renormalise the remaining weights over their own sum. Dropping Search Demand leaves 0.75, so Competitive Density becomes 0.20/0.75 = 0.267, Business Relevance 0.25/0.75 = 0.333, Creation Effort 0.15/0.75 = 0.20 and Conversion Potential 0.15/0.75 = 0.20 — which still sum to 1.00, so the tiers below stay readable. State the rescaling (the denominator or the renormalised weights) and name the dropped factor in the report. A Search Demand score resting on an invented volume figure is not a scored factor; it is a guess wearing a weight.

**Competitor cluster depth is not an independent proxy, and the report says so on every row that
uses it.** Competitive Density is read off the same competitor counts in the opposite direction: a
topic with a deep competitor cluster scores Demand *up* and Density *down*. At 25% and 20% the two
movements largely cancel, so a row scored that way behaves as though it had three factors rather
than five, and the spread between rows narrows. **Do not re-weight to compensate.** A re-weighted
proxy path would score the same gap differently from the published-weight path, and would
invalidate every attainable-value set derived in [score-arithmetic.md](./score-arithmetic.md) §3
and §7. Disclose instead: name the proxy, and state on the row that Density is not independent
evidence there. A reader who knows the two cells came from one count can discount them correctly;
a reader who does not, cannot.

**How far they cancel — worked, in both scores.** Take the mirrored case, where one count is read
one way for Demand and the other way for Density, so `Density = 6 − Demand`. The pair then
contributes `0.25·D + 0.20·(6 − D) = 1.20 + 0.05·D` to the Gap Priority Score — **1.25, 1.30, 1.35,
1.40, 1.45** as Demand runs 1 to 5. That is a **0.20** spread across the whole swing, where two
factors holding 45% of the weight would move the score by **1.80** if they moved independently in
the same direction: about **a ninth** of their nominal leverage, and 5% of the score's own 1.00-5.00
range. In the **Quick Win Score the cancellation is exact**, because there the two are unweighted:
`D + (6 − D) = 6` for every gap, so the screen collapses to `Relevance + Effort − 6` — a −4 to +4
quantity read against bands calibrated for four inputs spanning −8 to +8.

Two gaps at opposite ends of the demand evidence, everything else held at Relevance 4 / Creation
Effort 4 / Conversion Potential 3:

| Gap | Proxy reading | Factors (D/Den/R/E/C) | Gap Priority Score | Tier | Quick Win Score |
|-----|---------------|------------------------|--------------------|------|-----------------|
| Deep cluster | 18 articles across the two competitors | 5/1/4/4/3 | `0.25×5 + 0.20×1 + 0.25×4 + 0.15×4 + 0.15×3 = 3.50` | P1 | `5+4+4+1 − 12 = +2` |
| Shallow cluster | 2 articles across the same two | 1/5/4/4/3 | `0.25×1 + 0.20×5 + 0.25×4 + 0.15×4 + 0.15×3 = 3.30` | P1 | `1+4+4+5 − 12 = +2` |

Same tier, **identical** Quick Win Score, and both land in Tier 1 — on demand evidence as far apart
as this scale goes. **So on the proxy path the screen is not the demand test**; §1 Step 4's proxy
floor is, which is why the proxy has to carry a floor in its own units and not merely a name.

### Priority Tiers

**Rounding convention: round the Gap Priority Score to two decimal places, halves up, and read
the tier off the rounded figure.** Print the unrounded figure beside it so the reader can rerun
the rounding. With the published weights the factors are integers and every weight is a multiple
of 0.05, so a fully scored gap already lands on a multiple of 0.05; renormalised weights (see
above) do not terminate, which is exactly when the convention earns its keep.

| Tier | Score Range (rounded, 2 dp) | Timeline | Action |
|------|-----------|----------|--------|
| **P0 -- Fill Immediately** | 4.00-5.00 | This sprint / this week | High demand + low competition + high relevance |
| **P1 -- Fill This Quarter** | 3.00-3.99 | Next 1-3 months | Good demand + some competition + relevant |
| **P2 -- Plan for Future** | 2.00-2.99 | Next 3-6 months | Moderate opportunity, requires more resources |
| **P3 -- Monitor** | 1.00-1.99 | Track quarterly | Low priority but may become relevant |

The four bands are contiguous across the whole attainable range and no score falls between two
of them. The boundaries themselves are unchanged; what changed is that the old
"3.0-3.9 / 2.0-2.9" wording left the intervals 1.90 < S < 2.00, 2.90 < S < 3.00 and
3.90 < S < 4.00 matching no tier at all — and those are reachable scores, not rounding dust.
Factor scores of 3, 2, 3, 3, 4 in table order give exactly 2.95. A score that used to land in
one of those holes now reads as the **lower** of the two adjacent tiers, which is the
conservative direction: a gap is never promoted a tier on a rounding artefact.

### Quick-Win Identification

A "quick win" is a gap that is wanted, relevant, cheap and uncontested — high on all four of
Search Demand, Business Relevance, Creation Effort (ease) and Competitive Density (room). All
four already point that way on the factor table above, so the score adds all four and re-centres
on the midpoint:

```
Quick Win Score = Search Demand + Business Relevance + Creation Effort + Competitive Density - 12
                   Higher is better · range -8 to +8 · 0 = all four factors at the midpoint 3
```

The `- 12` is four factors x the midpoint score of 3, so it moves the origin and nothing else:
the score reads as the number of scale points the gap sits above or below an all-average gap.
Because the four inputs are integers the score is always an integer, so the bands below have no
gap between them either.

| Quick Win Score | Assessment |
|----------------|-----------|
| 4+ | Strong quick win -- create this content first |
| 2-3 | Moderate quick win -- include in next content sprint |
| 0-1 | Not a quick win -- may still be strategically important |
| Negative | Avoid -- high effort/competition relative to demand |

**This score does not enforce the demand filter — the filter does.** Search Demand is one added
input of four, so a gap in the bottom Demand band still reaches the "moderate quick win" band on
the strength of the other three: `1 + 4 + 4 + 5 - 12 = +2`. The demand condition is enforced
earlier and only there — the minimum-volume filter in §1 Step 4, or, where this run has no volumes,
the floor the named proxy sets in its own units and fixes before scoring (§1 Step 4). **A proxy with
no floor is not a filter**: naming one is a property of the run, and every keyword in that run
satisfies it equally. Filter Segment C first, then score what survives. SKILL.md Step 4's Quick Wins
bucket states the same condition in words; it is a filter restated, not a reading of this formula.

**All four inputs are required, and Search Demand is the one that goes missing.** The screen is a
demand test as much as a cost test: drop Search Demand and the remaining three would crown a gap
nobody searches for simply for being cheap and uncontested. So when the unavailable-input rule
above bites, take one of two routes and name it in the report:

- **Named proxy** — score Search Demand from something the supplied data actually contains
  (competitor cluster depth, own-site sessions on adjacent pages), state that basis, and compute
  the Quick Win Score as normal with the proxy named beside it. Where that basis is the same
  competitor count Competitive Density reads, the two legs cancel exactly (above): print the score,
  say on the row that it read as `Relevance + Effort − 6`, and let §1 Step 4's proxy floor carry the
  demand test the screen no longer carries.
- **Screen not run** — if Search Demand is dropped rather than proxied, no Quick Win Score is
  produced. Write "quick-win screen not run — Search Demand unavailable", order the gaps on the
  renormalised Gap Priority Score, and let the P0 tier do the "start here" job. Do **not** sum the
  three surviving factors and re-centre on `- 9`: the bands above are calibrated to four inputs,
  and a three-input score read against them is a different quantity wearing the same name.

The same rule governs the two "quick win" buckets outside this section — SKILL.md Step 4's
keyword bucket and the Tier 1 list in the report template. Both are the same claim in words, so
both carry the same demand condition: a keyword with no demand evidence is not a quick win,
however cheap it is to write and however empty the SERP looks.

### Where Creation Effort Actually Binds

Creation Effort carries 15% of the Gap Priority Score, the joint-lowest weight, and that is
deliberate: the priority score ranks *opportunity*, and a gap is not worth less because it is
expensive. Execution capacity binds in three other places instead, and that is where SKILL.md
Tips #2 ("prioritize based on ability to execute") is actually carried out:

1. **The Quick Win Score gives Creation Effort a full quarter share** — one of four unweighted
   inputs, against 15% in the priority score. The quick-win list *is* the effort-sensitive
   ordering, which is why the two scores disagree about the same gap and are both right.
2. **The tier's Timeline column** — "this sprint" is a capacity commitment, not a score. A P0 gap
   that needs a capability you do not have is still P0 and still cannot ship this sprint; record
   it with the thing it is waiting on rather than demoting it.
3. **Calendar cadence by team size (§5)** — the monthly-output row is the hard ceiling, and it
   decides how many gaps from the ordered list enter the calendar at all.

If effort must move the priority ranking itself for a particular engagement, change the weight
explicitly and print the changed weight set in the report. Do not compensate by scoring the
factor against its own scale.

---

## 5. Content Calendar Integration

### Gap-to-Calendar Workflow

#### Step 1: Group Gaps by Topic Cluster

Group related gaps into clusters rather than addressing them individually:

| Cluster | Related Gaps | Combined Volume | Pillar Needed? | Cluster Pages Needed |
|---------|-------------|----------------|---------------|---------------------|
| [Cluster A] | Gap 1, Gap 3, Gap 7 | [Sum of volumes] | [Yes/No] | [Count] |
| [Cluster B] | Gap 2, Gap 5 | [Sum of volumes] | [Yes/No] | [Count] |
| [Cluster C] | Gap 4, Gap 6, Gap 8, Gap 9 | [Sum of volumes] | [Yes/No] | [Count] |

`Combined Volume` is the sum of the member gaps' volumes, and the deliverable lists the addends
so the sum can be rerun. Where this run has no volumes, the cell is not filled with a guess:
write "volumes unavailable — clustered on topic, not volume" and let the cluster stand on its
member count.

#### Step 2: Sequence by Priority and Dependencies

| Order | Content Piece | Gap(s) Addressed | Priority | Dependencies | Target Publish |
|-------|-------------|-----------------|---------|-------------|---------------|
| 1 | [Pillar page for Cluster A] | Gap 1, 3, 7 (overview) | P0 | None | Week 1 |
| 2 | [Quick-win article] | Gap 2 | P0 | None | Week 2 |
| 3 | [Cluster A subtopic 1] | Gap 3 (deep dive) | P0 | Pillar published | Week 3 |
| 4 | [Cluster A subtopic 2] | Gap 7 (deep dive) | P1 | Pillar published | Week 4 |
| 5 | [Comparison page] | Gap 5 | P1 | None | Week 5 |

#### Step 3: Assign Resources and Track

| Content Piece | Writer | Reviewer | Target Date | Status | Gap Closed? |
|-------------|--------|---------|------------|--------|------------|
| [Title] | [Name] | [Name] | [Date] | [Draft/Review/Published] | [Yes/No/Partial] |

### Calendar Cadence by Team Size

| Team Size | Monthly Output | Gap Fill Rate | Full Gap Close Timeline |
|-----------|---------------|--------------|----------------------|
| Solo | 4-6 pieces/month | 3-4 gaps/month | 6-12 months for 30 gaps |
| Small (2-3) | 8-15 pieces/month | 6-10 gaps/month | 3-6 months for 30 gaps |
| Medium (4-6) | 15-25 pieces/month | 10-20 gaps/month | 2-3 months for 30 gaps |
| Large (7+) | 25+ pieces/month | 20+ gaps/month | 1-2 months for 30 gaps |

### Post-Publication Gap Validation

After publishing gap-filling content, validate that the gap is actually closed:

| Checkpoint | Timeframe | What to Check | Success Criteria |
|-----------|-----------|--------------|-----------------|
| Indexing | 1-2 weeks | Is the page indexed? | Appears in Google index |
| Initial ranking | 2-4 weeks | Is it ranking for target keyword? | Appears in top 100 |
| Competitive ranking | 2-3 months | Has it reached competitive positions? | Top 20 or improving trend |
| Traffic impact | 3-6 months | Is it driving meaningful traffic? | Clicks and impressions rising against the 90-day baseline recorded at publication — **not** a projection: this skill produces none for unwritten content |
| Gap closure | 6 months | Has the gap been effectively closed? | Ranking comparable to competitors |

**Why that row does not say "meeting traffic projections"** *(corrected 2026-08-13)*: it used to, and
three other surfaces in this skill — SKILL.md's Success Metrics, its Scoring & Derivation section,
`score-arithmetic.md` §6 and `analysis-templates.md` — all state that **no traffic projection is
produced for unwritten content**, because there is no model here that converts a gap into a number.
So the validation table asked the reader to validate against a figure the skill forbids creating.
A success criterion that cannot be met without breaking the skill's own rule is worse than no
criterion: it invites someone to invent the number retrospectively so the row has something to
check against. **Record the baseline at publication and compare to it** — that is a measurement,
and it needs no forecast.

---

## Framework Selection Guide

| Situation | Primary Framework | Secondary Framework |
|-----------|------------------|-------------------|
| "We need more traffic" | Keyword Gap Methodology | Content Calendar Integration |
| "Competitors outrank us everywhere" | Keyword Gap + Format Gap | Opportunity Scoring |
| "Our conversion rate is low" | Funnel Stage Gap | Format Gap (decision-stage formats) |
| "We don't know what to write next" | All three gap types | Opportunity Scoring + Calendar |
| "We have limited resources" | Opportunity Scoring (quick wins) | Keyword Gap (filtered by difficulty) |
| "We're entering a new market" | Keyword Gap (comprehensive) | Format Gap + Funnel Gap |
