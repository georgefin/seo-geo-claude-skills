# Competitor Analysis — Analysis Templates

Templates for each step of the competitor analysis workflow. Use these to structure your output.

## Three rules that travel with every template below

Stated here as well as in `SKILL.md`, because a model copies the fence, not the heading above
it — and these templates are what gets copied.

1. **Confidence label on every concluded finding.** **Confirmed** (directly observed in the
   supplied content or data) · **Likely** (strong indirect evidence) · **Hypothesis** (plausible,
   unverified — *name the check that would confirm it*). A causal explanation of why a competitor
   ranks or gets cited is **never Confirmed**; a Hypothesis with no named verification step is
   not deliverable. Greek deliverables: **Επιβεβαιωμένο** · **Πιθανό** · **Υπόθεση**, same rules.
   Every `[Confirmed / Likely / Hypothesis]` slot below is a required field, not decoration.
2. **A bracketed `[X]` in a metric cell is a slot, never a licence to fill it with an estimate.**
   Hard metrics — traffic, positions, ranking-keyword counts, authority scores, backlinks,
   referring domains, volume, difficulty — come from an export or a tool or they stay unfilled,
   written as `unknown — <the pull that would fill it>`. They are never derived from another
   row's ratios and never softened into a range, a model or a "planning figure". Soft quantities
   (page counts, cadence, content mix) may be inferred if the inference says so and shows the
   count it rests on.
3. **Nothing internal survives into a client's copy.** No skill slug, no framework item ID
   (`T03`, `O05`), no `~~category` token. A framework *name* the client is buying (CITE,
   CORE-EEAT) is allowed once glossed on first use. Instructions addressed to you, the operator,
   stay outside the fenced block — see the Synthesis Report Template for the pattern.

Full versions with worked examples:
[confidence-and-evidence-rules.md](./confidence-and-evidence-rules.md).

## Advanced Analysis Requests (moved from SKILL.md)

Four request shapes this skill supports beyond the standard workflow. Each runs the templates
below with a narrower scope; none of them relaxes the three rules above, and each still ends in a
seven-field Action Plan.

| Request | What it runs | Ask |
|---------|--------------|-----|
| **Content gap** | Content Analysis Template, scoped to what the competitor has and you do not | `Show me content [competitor] has that I don't, sorted by traffic potential` |
| **Link intersection** | Backlink Analysis Template across two competitors, intersected | `Find sites linking to [competitor 1] AND [competitor 2] but not me` |
| **SERP feature** | GEO/AI Citation + Keyword Analysis Templates, scoped to feature ownership | `What SERP features do competitors win? (Featured snippets, PAA, etc.)` |
| **Historical** | Competitor Profile + Content Analysis Templates across two dated snapshots | `How has [competitor]'s SEO strategy evolved over the past year?` |

Two of the four are especially exposed to the hard-metric rule. "Sorted by traffic potential"
needs a traffic figure the export must actually contain — with none, the sort is stated as
unavailable and the list is ordered on something you counted instead. "How the strategy evolved"
needs two snapshots that both exist; a single snapshot supports no trend, and describing one as a
trajectory is a characterisation of the set, which belongs in the Assumptions block or nowhere.

## Competitor Profile Template

```markdown
## Competitor Profile: [Name]

**Basic Info**
- URL: [website]
- Domain Age: [years]
- Estimated Traffic: [monthly visits]
- Domain Authority/Rating: [score]

**Business Model**
- Type: [SaaS/E-commerce/Content/etc.]
- Target Audience: [description]
- Key Offerings: [products/services]
```

## Keyword Analysis Template

```markdown
### Keyword Analysis: [Competitor]

**Total Keywords Ranking**: [X]
**Keywords in Top 10**: [X]
**Keywords in Top 3**: [X]

#### Top Performing Keywords

| Keyword | Position | Volume | Traffic Est. | Page |
|---------|----------|--------|--------------|------|
| [kw 1] | [pos] | [vol] | [traffic] | [url] |
| [kw 2] | [pos] | [vol] | [traffic] | [url] |

#### Keyword Distribution by Intent

- Informational: [X]% ([keywords])
- Commercial: [X]% ([keywords])
- Transactional: [X]% ([keywords])
- Navigational: [X]% ([keywords])

#### Keyword Gaps (They rank, you don't)

| Keyword | Their Position | Your Position | Volume | Opportunity |
|---------|----------------|---------------|--------|-------------|
| [kw 1] | [pos] | [pos, or "unverified — check Search Console"] | [vol] | [analysis] |

<!-- Both sides of a "gap" need evidence. Where your own positions were not supplied, every row
     is a CANDIDATE gap, not a confirmed one — say so above the table, in those words. -->
```

## Content Analysis Template

```markdown
### Content Analysis: [Competitor]

**Content Volume**
- Total Pages: [X]
- Blog Posts: [X]
- Landing Pages: [X]
- Resource Pages: [X]

**Content Performance**

#### Top Performing Content

| Title | URL | Est. Traffic | Keywords | Backlinks |
|-------|-----|--------------|----------|-----------|
| [title 1] | [url] | [traffic] | [X] | [X] |

**Content Patterns**

- Average word count: [X] words
- Publishing frequency: [X] posts/month
- Content formats used:
  - Blog posts: [X]%
  - Guides/tutorials: [X]%
  - Case studies: [X]%
  - Tools/calculators: [X]%
  - Videos: [X]%

**Content Themes**

| Theme | # Articles | Combined Traffic |
|-------|------------|------------------|
| [theme 1] | [X] | [traffic] |
| [theme 2] | [X] | [traffic] |

**What Makes Their Content Successful**

1. [Success factor 1 with example] — [Confirmed / Likely / Hypothesis]
2. [Success factor 2 with example] — [Confirmed / Likely / Hypothesis]
3. [Success factor 3 with example] — [Confirmed / Likely / Hypothesis]

<!-- "Successful" is a causal claim about ranking or engagement. The FORMAT you observed can be
     Confirmed; the claim that it is what works cannot. Likely or Hypothesis, with the check. -->
```

## Backlink Analysis Template

```markdown
### Backlink Analysis: [Competitor]

**Overview**
- Total Backlinks: [X]
- Referring Domains: [X]
- Domain Rating: [X]

**Link Quality Distribution**
- High Authority (DR 70+): [X]%
- Medium Authority (DR 30-69): [X]%
- Low Authority (DR <30): [X]%

**Top Linking Domains**

| Domain | DR | Link Type | Target Page |
|--------|-----|-----------|-------------|
| [domain 1] | [DR] | [type] | [page] |

**Link Acquisition Patterns**

- Guest posts: [X]%
- Editorial/organic: [X]%
- Resource pages: [X]%
- Directories: [X]%
- Other: [X]%

**Linkable Assets (Content attracting links)**

| Asset | Type | Backlinks | Why It Works |
|-------|------|-----------|--------------|
| [asset 1] | [type] | [X] | [reason] |
```

## Technical SEO Assessment Template

```markdown
### Technical Analysis: [Competitor]

**Site Performance**
- Core Web Vitals: [Pass/Fail]
- LCP: [X]s
- INP: [X]ms
- CLS: [X]
- Mobile-friendly: [Yes/No]

**Site Structure**
- Site architecture depth: [X] levels
- Internal linking quality: [Rating]
- URL structure: [Clean/Messy]
- Sitemap present: [Yes/No]

**Technical Strengths**
1. [Strength 1] — [Confirmed / Likely / Hypothesis]
2. [Strength 2] — [Confirmed / Likely / Hypothesis]

**Technical Weaknesses**
1. [Weakness 1] — [Confirmed / Likely / Hypothesis]
2. [Weakness 2] — [Confirmed / Likely / Hypothesis]

<!-- None of the fields above is readable from saved page copy. Without a measurement run
     (field data, a crawl, a device check) every row here is unknown — delete the block and say
     which measurement would fill it, rather than scoring a page you did not measure. -->
```

## GEO/AI Citation Analysis Template

```markdown
### GEO Analysis: [Competitor]

**AI Visibility Assessment**

Test competitor content in AI systems for relevant queries:

| Query | AI Mentions Competitor? | What's Cited | Why |
|-------|------------------------|--------------|-----|
| [query 1] | Yes/No | [content] | [reason] |
| [query 2] | Yes/No | [content] | [reason] |

**GEO Strategies Observed**

1. **Clear Definitions**
   - Example: [quote from their content]
   - Effectiveness: [rating]

2. **Quotable Statistics**
   - Example: [quote from their content]
   - Effectiveness: [rating]

3. **Q&A Format Content**
   - Examples found: [X] pages
   - Topics covered: [list]

4. **Authority Signals**
   - Expert authorship: [Yes/No]
   - Citations to sources: [Yes/No]
   - Original research: [Yes/No]

**GEO Opportunities They're Missing**

| Topic | Why Missing | Confidence | Your Opportunity |
|-------|-------------|-----------|------------------|
| [topic 1] | [reason] | [Confirmed / Likely / Hypothesis + the check] | [action] |

<!-- "They do not cover X" is checkable and can be Confirmed (say how you checked). "Why" they
     do not, and whether covering it would earn citations, cannot be — Likely or Hypothesis. -->
```

## Synthesis Report Template

**Operator notes — these stay out of the fence below, and out of the client's copy.**

- The Domain Authority Comparison block is filled from a run of
  [domain-authority-auditor](../../cross-cutting/domain-authority-auditor/), one per domain,
  passing the domains along per the library handoff convention — carried in
  [references/inter-skill-handoff.md](../../../references/inter-skill-handoff.md), which also
  records that the convention's "content URL" field is page-level and singular, so a multi-domain
  handoff sends one labelled row per domain. Inside the report, name the
  *work* ("a domain-level authority audit of the three domains") and gloss CITE on first use, as
  the fence does. A skill slug on a surface the client reads is a family-8 failure
  (`build/seo-content-writer/references/anti-slop-ruleset.md` §6), and so is a bare framework
  item ID.
- If no such audit has been run, **delete the block** and say so in prose: which comparison is
  missing, what it would tell them, and that the audit is the next step. Never emit the table
  with invented C/I/T/E scores, and never relabel a vendor's own metric (Semrush "Authority
  Score", Moz DA, Ahrefs DR) as a CITE score — they are different instruments and are not
  interchangeable.
- Every `[Confirmed / Likely / Hypothesis]` slot in the fence is required output. Fill it or
  delete the finding.

```markdown
<!-- SKELETON — every [bracket] below is a slot to fill from real data or to delete with the
     gap named in prose. A hard metric with no source is deleted, never estimated. Remove this
     comment and any unfilled block before the report goes out. -->
# Competitive Analysis Report

**Analysis Date**: [Date]
**Competitors Analyzed**: [List]
**Your Site**: [URL]

## Executive Summary

[2-3 paragraph overview of key findings and recommendations]

## Competitive Landscape

Every figure carries its source and the date it was pulled. A cell reading "unknown" is a cell
we could not source; it names the pull that would fill it and holds no estimate.

| Metric | Source & date | You | Competitor 1 | Competitor 2 | Competitor 3 |
|--------|---------------|-----|--------------|--------------|--------------|
| Domain Authority | [tool, date] | [X] | [X] | [X] | [X] |
| Organic Traffic | [tool, date] | [X] | [X] | [X] | [X] |
| Keywords Top 10 | [tool, date] | [X] | [X] | [X] | [X] |
| Backlinks | [tool, date] | [X] | [X] | [X] | [X] |
| Content Pages | [counted from their index, date] | [X] | [X] | [X] | [X] |

**Domain Authority Comparison**

We rated each domain with CITE — a 40-item domain-authority rating covering citation, identity, trust and eminence signals.
Scores are out of 100; "veto" flags an item that caps the rating regardless of the arithmetic.

| Domain | CITE score | Citation | Identity | Trust | Eminence | Veto |
|--------|-----------|----------|----------|-------|----------|------|
| Your domain | [score] | [score] | [score] | [score] | [score] | [pass/fail] |
| Competitor 1 | [score] | [score] | [score] | [score] | [score] | [pass/fail] |
| Competitor 2 | [score] | [score] | [score] | [score] | [score] | [pass/fail] |

This reveals domain authority gaps that inform link building and brand strategy beyond keyword-level competition.

## Competitor Strengths to Learn From

### [Competitor 1]
- **Strength**: [description] — [Confirmed / Likely / Hypothesis]
- **Evidence**: [the quote, export row or count this rests on; for Hypothesis, the check that would confirm it]
- **Why It Works**: [analysis] — [Likely / Hypothesis; a causal claim is never Confirmed]
- **How to Apply**: [action item]

[Repeat for each competitor]

## Competitor Weaknesses to Exploit

### Gap 1: [Description] — [Confirmed / Likely / Hypothesis]
- Who's weak: [competitors]
- Evidence: [what you observed, quoted or counted; for Hypothesis, the check that would confirm it]
- Opportunity size: [only if measurable from data you hold — otherwise "not sized: needs [the pull]"]
- Recommended action: [specific steps]

[Repeat for each gap]

## Keyword Opportunities

### Keywords to Target (Competitor overlap)
| Keyword | Volume | Avg Position | Best Strategy |
|---------|--------|--------------|---------------|
| [kw] | [vol] | [pos] | [strategy] |

### Untapped Keywords (No competitor coverage)
| Keyword | Volume | Difficulty | Opportunity |
|---------|--------|------------|-------------|
| [kw] | [vol] | [diff] | [description] |

## Content Strategy Recommendations

Based on competitor analysis:

1. **Create**: [Content type] about [topic] because [reason]
2. **Improve**: [Existing content] to match/exceed [competitor content]
3. **Promote**: [Content] to sites like [competitor's link sources]

## Action Plan

Ordered within each horizon by expected impact ÷ effort, with dependencies respected.

### Immediate (This Week)

| Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
|--------|-------|----------------------|-----------------|--------|--------------|--------------------|
| [one imperative sentence naming the artefact and the change] | [role] | [observable · binary · named artefact or measurement · dated or triggered] | [derived from a figure printed above, or `not estimated — no baseline data`] | [S/M/L, or `not estimated`] | [named — including the check that would confirm a Hypothesis premise — or `none`] | [failure mode and cost, or `low — reversible, no downstream effect`] |

### Short-term (This Month)

| Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
|--------|-------|----------------------|-----------------|--------|--------------|--------------------|
| [as above] | [role] | [criterion] | [impact or stated absence] | [band] | [named, or `none`] | [risk or stated absence] |

### Long-term (This Quarter)

| Action | Owner | Acceptance criterion | Expected impact | Effort | Dependencies | Risk if done wrong |
|--------|-------|----------------------|-----------------|--------|--------------|--------------------|
| [as above] | [role] | [criterion] | [impact or stated absence] | [band] | [named, or `none`] | [risk or stated absence] |
```

**The Action Plan's seven columns are not optional and the horizons are not a substitute for
them.** Immediate / Short-term / Long-term says *when*; the seven fields say *who, how it is
checked, and what it costs to get wrong*. A bare `[Action item]` line — the shape this template
used to carry — is a suggestion, and suggestions do not get done. Fields 1-3 (action, owner,
acceptance criterion) are required; fields 4-7 take a stated-absence value rather than a blank or
an invention. Two rules from this skill bind the cells directly:

- **Expected impact obeys the hard-metric rule.** Where the export or the user left a measurement
  blank, expected impact reads `not estimated — no baseline data`. It is never a reconstructed
  traffic figure, a modelled range or a "for planning only" number — the label does not make the
  number admissible (SKILL.md step 2).
- **A Hypothesis premise becomes a dependency.** Where an action rests on a finding labelled
  Hypothesis, the check that would confirm it is named in the Dependencies cell, and the action
  sorts below that check. An action built on an unverified causal ranking explanation, with
  nothing in Dependencies, is the defect the confidence labels exist to catch.

Full field table, stated-absence values, the closed owner-role list and worked acceptance
criteria: [Action Output Contract](../../../references/action-output-contract.md).
