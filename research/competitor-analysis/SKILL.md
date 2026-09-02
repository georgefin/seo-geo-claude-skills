---
name: competitor-analysis
version: "4.3.1"
description: 'Analyze competitor SEO and GEO strategies including ranking keywords, content approaches, backlink profiles, and AI citation patterns. Use when the user asks to "analyze competitors", "competitive analysis", "what are my competitors doing", "why do they rank higher", "competitor keywords", "competitor backlinks", or "spy on competitor SEO". For content-focused gap analysis, see content-gap-analysis. For link profile specifics, see backlink-analyzer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.1"
  geo-relevance: "medium"
  tags:
    - seo
    - geo
    - competitor analysis
    - competitive intelligence
    - benchmarking
    - market analysis
    - ranking analysis
    - competitive-seo
    - competitor-keywords
    - competitor-backlinks
    - market-analysis
    - battlecard
    - serp-competition
    - domain-comparison
    - content-benchmarking
    - gap-analysis
  triggers:
    - "analyze competitors"
    - "competitor SEO"
    - "who ranks for"
    - "competitive analysis"
    - "what are my competitors doing"
    - "competitor keywords"
    - "competitor backlinks"
    - "what are they doing differently"
    - "why do they rank higher"
    - "spy on competitor SEO"
---

# Competitor Analysis


This skill provides comprehensive analysis of competitor SEO and GEO strategies, revealing what's working in your market and identifying opportunities to outperform the competition.

## When to Use This Skill

- Entering a new market or niche
- Planning content strategy based on competitor success
- Understanding why competitors rank higher
- Finding backlink and partnership opportunities
- Identifying content gaps competitors are missing
- Analyzing competitor AI citation strategies
- Benchmarking your SEO performance

## What This Skill Does

1. **Keyword Analysis**: Identifies keywords competitors rank for
2. **Content Audit**: Analyzes competitor content strategies and formats
3. **Backlink Profiling**: Reviews competitor link-building approaches
4. **Technical Assessment**: Evaluates competitor site health
5. **GEO Analysis**: Identifies how competitors appear in AI responses
6. **Gap Identification**: Finds opportunities competitors miss
7. **Strategy Extraction**: Reveals actionable insights from competitor success

## Scope Boundary — When the Request Is Not Competitor Analysis

This skill analyses **competitors**. A request that is really own-site keyword strategy,
own-site content quality, or own-site technical health belongs to a sibling skill, and
producing it here is a failure even when the output is good.

**The common one: "expand my seed topics into a keyword plan."** Keyword discovery from seed
terms, per-keyword volume/difficulty/intent, pillar-and-cluster grouping and opportunity
ranking are `keyword-research`'s documented capabilities — its own *What This Skill Does* list
reads Keyword Discovery, Intent Classification, Difficulty Assessment, Opportunity Scoring,
Clustering, GEO Relevance. Every part of that request maps onto that list. Do not build the
plan here.

At the boundary the response has four parts and no fifth:

1. **Name the skill that owns the work, matched to its documented capabilities** — say which of
   its listed jobs covers which part of the request, so the user can see the fit instead of
   taking your word for it.
2. **State what this skill does cover**, in a line or two: competitor identification, page-level
   and export-level competitor analysis, keyword *gap* work against a named competitor, backlink
   and GEO comparison, the synthesis report.
3. **Offer only in-scope artefacts, framed as in-scope** — the Competitor Identification
   Framework (step 1) as questions or a to-verify shortlist, and the "With manual data only"
   checklist of what to send for the eventual analysis. Say plainly that these are the
   competitor-analysis pieces, not the plan that was asked for.
4. **Do not produce the out-of-scope deliverable** — not as an appendix, not as a "starter
   version", not retitled, not with a disclaimer. A full keyword table carrying the right
   caveats is still the deliverable the user asked the wrong skill for, and shipping it removes
   the reason to run the skill that would have done it properly.

**Keep your own side of the boundary.** Competitor keyword-*gap* analysis ("what do they rank
for that I don't?") stays here — `keyword-research`'s own boundary note hands it back. Refer the
own-site plan; never send the gap work away with it.

**Naming a sibling skill, and the family-8 tension.** A skill slug is an internal library
identifier. In the reply to the person operating this skill, name it plainly — they have the
library and can run it, so the slug denotes something they can hold. In any artefact the client
may forward, a bare slug is a family-8 failure (`anti-slop-ruleset.md` §6): name the **job** in
ordinary language and gloss the method on first use — "a dedicated keyword-research pass: seed
expansion, intent classification, difficulty scoring and clustering" — never a code-formatted
slug the client cannot act on.

## How to Use

### Basic Competitor Analysis

```
Analyze SEO strategy for [competitor URL]
```

```
Compare my site [URL] against [competitor 1], [competitor 2], [competitor 3]
```

### Specific Analysis

```
What content is driving the most traffic for [competitor]?
```

```
Analyze why [competitor] ranks #1 for [keyword]
```

### GEO-Focused Analysis

```
How is [competitor] getting cited in AI responses? What can I learn?
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~analytics + ~~AI monitor connected:**
Automatically pull competitor keyword rankings, backlink profiles, top performing content, domain authority metrics from ~~SEO tool. Compare against your site's metrics from ~~analytics and ~~search console. Check AI citation patterns for both your site and competitors using ~~AI monitor.

**With manual data only:**
Ask the user to provide:
1. Competitor URLs to analyze (2-5 recommended)
2. Your own site URL and current metrics (traffic, rankings if known)
3. Industry or niche context
4. Specific aspects to focus on (keywords, content, backlinks, etc.)
5. Any known competitor strengths or weaknesses

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests competitor analysis:

1. **Identify Competitors**

   If not specified, help identify competitors:
   
   ```markdown
   ### Competitor Identification Framework
   
   **Direct Competitors** (same product/service)
   - Search "[your main keyword]" and note top 5 organic results
   - Check who's advertising for your keywords
   - Ask: Who do customers compare you to?
   
   **Indirect Competitors** (different solution, same problem)
   - Search problem-focused keywords
   - Look at alternative solutions
   
   **Content Competitors** (compete for same keywords)
   - May not sell same product
   - Rank for your target keywords
   - Include media sites, blogs, aggregators
   ```

2. **Gather Competitor Data**

   Collect for each competitor: URL, domain age, estimated traffic, domain authority, business model, target audience, and key offerings.

   **A hard metric the source data does not contain is not reconstructable from the columns
   that are there.** Organic traffic, ranking positions, ranking-keyword counts, domain
   authority/rating, backlink and referring-domain counts are *measurements*. If the export,
   the tool or the user left one blank, the cell stays blank with the pull that would fill it
   named. Do not derive it from another competitor's ratios, do not multiply a keyword count
   by someone else's traffic-per-keyword, do not carry it forward from a sibling row.
   **A number is not made admissible by the label attached to it**: "roughly", "for planning
   only", "a model, not a measurement", a ± band and a range all fail exactly as a bare figure
   does — the reader keeps the number and loses the sentence around it. A cell answered `n/a`
   in the landscape table and then supplied as a range three sections later is one defect, not
   two disclosures.

   **What you may still infer, and it is a different thing.** *Soft quantities* — how many
   pages a section appears to hold, publishing cadence, content-mix share, audience shape —
   may be estimated from what you can actually count, provided the estimate says so in the
   same breath: "this is an inference from ratios, not a measurement — page counts were not in
   the export." The line is not hedged vs. unhedged. It is whether the quantity is something a
   tool *measures* (never reconstruct it) or something you *counted in front of you* (infer
   it, and show the count). Worked cases of each side:
   [references/confidence-and-evidence-rules.md](./references/confidence-and-evidence-rules.md).

3. **Analyze Keyword Rankings**

   Document total keywords ranking, top 10/top 3 counts, top performing keywords (with position, volume, traffic, page URL), keyword distribution by intent, and keyword gaps.

4. **Audit Content Strategy**

   Analyze content volume by type, top performing content, content patterns (word count, frequency, formats), content themes, and success factors.

5. **Analyze Backlink Profile**

   Review total backlinks, referring domains, link quality distribution, top linking domains, link acquisition patterns, and linkable assets.

6. **Technical SEO Assessment**

   Evaluate Core Web Vitals, mobile-friendliness, site architecture, internal linking quality, URL structure, and technical strengths/weaknesses.

7. **GEO/AI Citation Analysis**

   Test competitor content in AI systems: document which queries cite them, GEO strategies observed (definitions, statistics, Q&A, authority signals), and GEO opportunities they are missing.

8. **Synthesize Competitive Intelligence**

   Produce a final report with: Executive Summary, Competitive Landscape comparison table, domain-authority comparison, Strengths to Learn From, Weaknesses to Exploit, Keyword Opportunities, Content Strategy Recommendations, and Action Plan (Immediate / Short-term / Long-term).

   The domain-authority section names its method in the client's own words and glosses it on
   first use — "CITE, the 40-item domain-authority rating covering citation, identity, trust and
   eminence signals" — and never carries a framework **item ID** (`T03`, `I09`) or a skill slug,
   both family-8 failures on a surface the client reads (`anti-slop-ruleset.md` §6). Fill the
   section only from scores that exist; with no domain-level audit run, say so and name the
   audit as the next step rather than filling the table. Naming that next run is a handoff: it
   goes in an operator block with the domains and their domain types, never in the client's
   prose — [inter-skill-handoff.md](../../references/inter-skill-handoff.md).

   > **Reference**: See [references/analysis-templates.md](./references/analysis-templates.md) for detailed templates for each step.

### Confidence Labels — required on every finding

Every finding the report *concludes* — each competitor strength, each own-site gap, each "why
they outrank you" explanation, each action item's premise — carries one of three labels, written
into the report itself:

- **Confirmed** — directly observed in the content or data you were given. Quote or cite the row.
- **Likely** — strong indirect evidence, not observed in the supplied material.
- **Hypothesis** — plausible and unverified. **Name the check that would confirm it**, concretely:
  "run these five terms logged-out and note the positions", "export Search Console queries for
  the last 3 months", "run the six AI test queries in section 5".

Two rules are the reason the labels exist:

1. **A causal ranking explanation is never Confirmed.** Why a competitor outranks you, or why an
   AI engine cites them, is not observable from page copy, a tool export, or an AI answer — those
   show *what* is true, never *why* the engine ordered the results. Such a finding is **Likely**
   at best and usually a **Hypothesis**. Labelling one Confirmed is a defect on its own.
2. **Every Hypothesis names what would confirm it.** A Hypothesis with no verification step is
   not deliverable — either do the check or drop the finding.

Pass-through material (a verbatim fixture quote, an export row reproduced as-is) may omit the
label; anything you concluded from it carries one. Prose caution is not a label: "this cannot be
proven from two saved pages" disciplines the section but leaves every finding in it unlabelled.

**Greek deliverables carry the Greek labels**: **Επιβεβαιωμένο** (άμεσα παρατηρημένο στο υλικό
που δόθηκε) · **Πιθανό** (ισχυρή έμμεση ένδειξη) · **Υπόθεση** (χρειάζεται επαλήθευση —
ονομάστε τον έλεγχο). Same three rules. The label lives in the report frame and never inside
sample copy drafted for the client's own site (the F13 placement guard).

Definitions, worked examples of each label and the full Greek table:
[references/confidence-and-evidence-rules.md](./references/confidence-and-evidence-rules.md).

### The Action Plan — Seven Fields per Action

The Synthesis Report ends in an Action Plan, and **every action in it carries seven fields**:
**action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done
wrong**. Competitor work is where a deliverable most easily degrades into observations about
somebody else's site; the action row is what turns "they publish weekly and you do not" into
something a named role can finish and a stranger can check. Fields 1-3 are **required** — no
action ships without an owner-role and an acceptance criterion — and fields 4-7 take a
stated-absence value where no answer exists (`not estimated — no baseline data`, `not estimated`,
`none`, `low — reversible, no downstream effect`), never a blank and never an invention.

**Owner is a role**, not a person unless the client supplied the name: `Content` ·
`SEO/technical` · `Developer` · `Designer` · `Product/merchandising` · `Customer service` ·
`Legal/compliance` · `Agency` · `Client decision`. `unassigned — needs an owner` is legitimate
and is itself a finding.

**The acceptance-criterion test: could someone who was not part of this engagement check it six
weeks from now, without asking anybody what was meant?** Observable, binary at the moment of
checking, attached to a named artefact or measurement, dated or triggered. **It never requires an
engine to do something** — outranking a competitor, winning a citation or reaching a position is
nobody's to deliver, and writing it turns the action into a promise. The criterion is the work
shipped plus the measurement re-run and recorded beside its dated baseline.

**Two of this skill's own rules bind the cells.** *Expected impact obeys the hard-metric rule*:
where the export, the tool or the user left a measurement blank, the cell reads `not estimated —
no baseline data`, never a reconstructed traffic figure, a modelled range or a "planning only"
number — the label does not make the number admissible. *A Hypothesis premise becomes a
dependency*: where an action rests on a finding labelled Hypothesis, the check that would confirm
it is named in Dependencies and the action sorts below that check.

**Ordering, stated once**: expected impact ÷ effort with dependencies respected, *inside* the
existing Immediate / Short-term / Long-term horizons, which stay this report's only priority
vocabulary. The seven-column layout sits in the Synthesis Report Template:
[references/analysis-templates.md](./references/analysis-templates.md) → Action Plan. Field
definitions, stated-absence values, the closed role list, worked criteria and the three permitted
shapes of expected impact: [Action Output Contract](../../references/action-output-contract.md).

## Validation Checkpoints

### Input Validation
- [ ] Competitor URLs verified as relevant to your niche
- [ ] Analysis scope defined (comprehensive or specific focus area)
- [ ] Your own site metrics available for comparison
- [ ] Minimum 2-3 competitors identified for meaningful patterns

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] Competitor strengths backed by measurable evidence (metrics, rankings) **wherever the source data carries it**. Where it does not, the strength is still backed — by the observation it rests on, shown with the count it was drawn from, and labelled per the confidence item below — and never by a hard metric the source data left empty. A zero-data or manual-only session in which every competitor strength is a **Likely** or a **Hypothesis** (Πιθανό / Υπόθεση) carrying its named confirming check **satisfies this item**; what fails it is a strength with no evidence at all, or one propped up on a reconstructed figure. Scoped 2026-08-18: unscoped, this item and the two below (source-of-each-data-point, hard-metric) could not all be satisfied in the manual-data mode this skill's own Data Sources section permits — the same unsatisfiable-pair shape ruled for the auditors on 2026-08-13, and given the same treatment, the requirement scoped to the tier that can meet it rather than either half deleted
- [ ] Opportunities based on identifiable gaps, not assumptions
- [ ] Action plan items are specific and actionable (not vague strategies)
- [ ] Every Action Plan item carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); none ships without an owner-role and an acceptance criterion, and the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding)
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — checkable six weeks on by someone who was not part of this engagement. **None requires an engine to do something**: outranking a competitor, a citation or a position is never the criterion, only the work shipped plus the measurement re-run and recorded beside its dated baseline
- [ ] No expected-impact cell carries a metric the source data did not contain (hard-metric rule), and every action resting on a **Hypothesis** names that hypothesis's confirming check in its Dependencies cell. Ordering is expected impact ÷ effort with dependencies respected, stated once, inside the Immediate / Short-term / Long-term horizons rather than a second priority vocabulary
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Google Analytics 4, Otterly), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every concluded finding carries a Confirmed / Likely / Hypothesis label (Greek: Επιβεβαιωμένο / Πιθανό / Υπόθεση); no causal ranking or AI-citation explanation is labelled Confirmed; every Hypothesis names the check that would confirm it
- [ ] No hard SEO metric (traffic, positions, ranking-keyword counts, authority score, backlinks, referring domains) appears anywhere the source data left it empty — not as a range, a model, a "planning figure" or a labelled estimate; soft-quantity inferences say in the same breath that they are inferences and show what was counted
- [ ] No skill slug and no framework item ID on a surface the client reads; a framework name is glossed on first use (anti-slop-ruleset.md §6 family 8)
- [ ] If the request was outside this skill's scope, the owning skill was named against its documented capabilities and the out-of-scope deliverable was **not** produced

## Example

> **Reference**: See [references/example-report.md](./references/example-report.md) for a complete example analyzing an illustrative competitor's marketing keyword dominance — fictional subject on the `.example` TLD, figures illustrative rather than measured, and every "weakness" tied to the observation it rests on.

## Advanced Analysis Types

Four narrower request shapes — content gap, link intersection, SERP-feature ownership, historical tracking — with the request wording for each, which templates each one runs, and the two that most often collide with the hard-metric rule (a "sorted by traffic potential" list with no traffic figures; a "how it evolved" narrative with one snapshot): [references/analysis-templates.md](./references/analysis-templates.md) → Advanced Analysis Requests.

## Tips for Success

1. **Analyze 3-5 competitors** for comprehensive view
2. **Include indirect competitors** - they often have innovative approaches
3. **Look beyond rankings** - analyze content quality, user experience
4. **Study their failures** - avoid their mistakes
5. **Monitor regularly** - competitor strategies evolve
6. **Focus on actionable insights** - what can you actually implement?


## Reference Materials

- [Confidence and Evidence Rules](./references/confidence-and-evidence-rules.md) — The Confirmed / Likely / Hypothesis convention with Greek equivalents and worked examples, the hard-metric vs soft-quantity boundary, and the out-of-scope refusal template
- [Analysis Templates](./references/analysis-templates.md) — Detailed templates for each analysis step (profile, keywords, content, backlinks, technical, GEO, synthesis), the four advanced analysis requests, and the Action Plan's seven-column layout
- [Action Output Contract](../../references/action-output-contract.md) — library-wide: the seven fields every Action Plan item carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule
- [Battlecard Template](./references/battlecard-template.md) — Quick-reference competitive battlecard for sales and marketing teams
- [Positioning Frameworks](./references/positioning-frameworks.md) — Positioning maps, messaging matrices, narrative analysis, and differentiation frameworks
- [Example Report](./references/example-report.md) — Complete example analyzing an illustrative competitor's marketing keyword dominance (fictional `.example` subject, illustrative figures, evidence-bound weaknesses)
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — the payload the Synthesis Report's operator notes pass to a domain-level audit, the operator-block placement rule, and the drop-and-name rule for an unavailable field

## Related Skills

- [domain-authority-auditor](../../cross-cutting/domain-authority-auditor/) — Compare CITE domain authority scores across competitors for domain-level benchmarking
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Where the library's Confirmed / Likely / Hypothesis convention is also defined, against CORE-EEAT item notes (this skill states its own copy above; the link is a cross-check, not the carrier)
- [keyword-research](../keyword-research/) — Research keywords competitors rank for
- [content-gap-analysis](../content-gap-analysis/) — Find content opportunities
- [backlink-analyzer](../../monitor/backlink-analyzer/) — Deep-dive into backlinks
- [serp-analysis](../serp-analysis/) — Understand search result composition
- [memory-management](../../cross-cutting/memory-management/) — Store competitor data in project memory
- [entity-optimizer](../../cross-cutting/entity-optimizer/) — Compare entity presence against competitors

