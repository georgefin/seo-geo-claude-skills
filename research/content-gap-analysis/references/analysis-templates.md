# Content Gap Analysis — Analysis Templates

Templates for each step of the content gap analysis workflow. Use these to structure your output.

## Content Inventory Template

```markdown
## Your Content Inventory

**Total Indexed Pages**: [X]
**Content by Type**:
- Blog posts: [X]
- Landing pages: [X]
- Resource pages: [X]
- Tools/calculators: [X]
- Case studies: [X]

**Content by Topic Cluster**:

| Topic | Articles | Keywords Ranking | Traffic |
|-------|----------|------------------|---------|
| [topic 1] | [X] | [X] | [X] |
| [topic 2] | [X] | [X] | [X] |
| [topic 3] | [X] | [X] | [X] |

**Top Performing Content**:
1. [Title] - [traffic] visits - [keywords] keywords
2. [Title] - [traffic] visits - [keywords] keywords
3. [Title] - [traffic] visits - [keywords] keywords

**Content Strengths**:
- [Strength 1]
- [Strength 2]

**Content Weaknesses**:
- [Weakness 1]
- [Weakness 2]
```

## Competitor Content Analysis Template

```markdown
## Competitor Content Analysis

### Competitor 1: [Name/URL]

**Content Volume**: [X] pages
**Monthly Traffic**: [X] visits — [tool name] estimate, [date]

**Content Distribution**:
| Type | Count | Share of their content | Where counted |
|------|-------|------------------------|---------------|
| Blog posts | [X] | [X]% | [section/index URL] |
| Guides | [X] | [X]% | [section/index URL] |
| Tools | [X] | [X]% | [section/index URL] |
| Videos | [X] | [X]% | [section/index URL] |

**Topic Coverage**:
| Topic | Articles | Your Coverage |
|-------|----------|---------------|
| [topic] | [X] | [X or "None"] |

**Unique Content They Have**:
1. [Content piece] - [what it does that yours does not] - [why it works]
2. [Content piece] - [what it does that yours does not] - [why it works]

[Repeat for each competitor]
```

**Why the traffic column left this table.** Step 3 of the workflow collects a competitor's traffic
at site level only, so a per-type traffic cell had no input to fill it from — and the tempting fix,
apportioning the site total across their content types, invents the split. Every competitor traffic
figure is somebody's estimate and is labelled as one with the tool and date named; a tool's own
per-URL estimate may be quoted where the export supplies it, but never derived from a site total.
The columns that replaced it are arithmetic over the Count column — each type's share of their
page total — with the place you counted it named. See
[score-arithmetic.md](./score-arithmetic.md) §6.

Where no tool supplied a site-level figure, the **Monthly Traffic** line is dropped from the
deliverable entirely and its absence noted in the Data Sources section. It is never carried as a
bracket token, a guess or a "n/a" that reappears as a range later on.

## Keyword Gap Analysis Template

This template contains a nested fence (the overlap diagram), so its outer fence is opened with
**four** backticks and closed with four. Three would be closed early by the inner block, and
everything after the diagram — the overlap counts and the Unique Keywords table — would fall
outside the template a model copies.

````markdown
## Keyword Gap Analysis

### Keywords Competitors Rank For (You Don't)

**High Priority Gaps** (High volume, achievable difficulty)

| Keyword | Volume | Difficulty | Competitor | Their Position |
|---------|--------|------------|------------|----------------|
| [kw 1] | [vol] | [diff] | [comp] | [pos] |
| [kw 2] | [vol] | [diff] | [comp] | [pos] |
| [kw 3] | [vol] | [diff] | [comp] | [pos] |

**Quick Win Gaps** (Demand evidence present, lower volume, low difficulty)

A quick win is cheap *and wanted*. Low difficulty on its own does not qualify a keyword: it has
to clear the demand floor set in the gap filters — >100/month by default, adjusted for the niche
— or, where no volume figures exist for this run, carry the named demand proxy the report states
(gap-analysis-frameworks.md §4). A zero-demand keyword in an empty SERP is not a quick win; it is
a page nobody will read.

| Keyword | Volume (or named proxy) | Difficulty | Competitor | Their Position |
|---------|-------------------------|------------|------------|----------------|
| [kw 1] | [vol] | [diff] | [comp] | [pos] |

**Long-term Gaps** (High volume, high difficulty)

| Keyword | Volume | Difficulty | Competitor | Their Position |
|---------|--------|------------|------------|----------------|
| [kw 1] | [vol] | [diff] | [comp] | [pos] |

### Keyword Overlap Analysis

```
Venn Diagram Representation:

       You          Competitor 1
        ○               ○
       / \             / \
      /   \           /   \
     /  A  \ B       / C   \
    /       \       /       \
   ○─────────○─────○─────────○
             Competitor 2

A: Keywords only you rank for: [X]
B: Overlap with Comp 1: [X]
C: Keywords all competitors share: [X]
Gap: Keywords they all have, you don't: [X]
```

**Unique Keywords (Your Advantage)**:
| Keyword | Your Position | Volume |
|---------|---------------|--------|
| [kw] | [pos] | [vol] |
````

## Topic Gap Analysis Template

```markdown
## Topic Gap Analysis

### Topic Coverage Comparison

| Topic Area | You | Comp 1 | Comp 2 | Comp 3 | Gap? |
|------------|-----|--------|--------|--------|------|
| [Topic 1] | ✅ [X] | ✅ [X] | ✅ [X] | ✅ [X] | No |
| [Topic 2] | ❌ 0 | ✅ [X] | ✅ [X] | ✅ [X] | **Yes** |
| [Topic 3] | ✅ [X] | ✅ [X] | ❌ 0 | ✅ [X] | Partial |
| [Topic 4] | ❌ 0 | ✅ [X] | ✅ [X] | ❌ 0 | **Yes** |

### Missing Topic Clusters

#### Gap 1: [Topic Area]

**Why it matters**: [Business relevance]
**Competitor coverage**: [Who covers it and how]
**Opportunity size**: [Traffic/keyword potential]

**Sub-topics to cover**:
1. [Sub-topic] - [X] search volume
2. [Sub-topic] - [X] search volume
3. [Sub-topic] - [X] search volume

**Recommended approach**:
- Pillar content: [topic]
- Cluster articles: [list]
- Supporting content: [list]
```

## Content Format Gap Template

```markdown
## Content Format Gap Analysis

### Format Distribution Comparison

| Format | You | Comp 1 | Comp 2 | Competitor Avg |
|--------|-----|--------|--------|----------------|
| Long-form guides | [X] | [X] | [X] | [X] |
| Tutorials | [X] | [X] | [X] | [X] |
| Comparison posts | [X] | [X] | [X] | [X] |
| Case studies | [X] | [X] | [X] | [X] |
| Tools/calculators | [X] | [X] | [X] | [X] |
| Templates | [X] | [X] | [X] | [X] |
| Video content | [X] | [X] | [X] | [X] |
| Infographics | [X] | [X] | [X] | [X] |
| Original research | [X] | [X] | [X] | [X] |
| Glossary/definitions | [X] | [X] | [X] | [X] |

### Format Gaps to Fill

#### Gap: [Format Type]

**Current state**: You have [X], competitors average [Y]
**Best examples**: [Competitor content examples]
**Opportunity**: [Description]
**Effort to create**: [Low/Medium/High]
**Expected impact**: [Low/Medium/High]

**Recommended first project**:
[Specific content idea]
```

**Last-column provenance**: it is the mean of the competitor columns counted in this table —
the same quantity the Audience Journey template calls "Competitor Avg" and the Format Gaps
block calls "competitors average" — and the deliverable states that basis beside it ("mean of
the competitor columns shown, n=2"). It is deliberately not an industry average: this analysis
counts the competitors you named, not an industry, and a benchmark column with nothing behind
it gets filled anyway, because the cell exists. A published industry benchmark may be added as
an extra column only when you have read it — name the publisher, the year and the sample, and
link it. With no such source, the competitor mean stands alone (statistics rule: sourced,
cited, or placeholder, never invented).

## GEO Content Gap Template

```markdown
## GEO Content Gap Analysis

### AI-Answerable Topics Assessment

**Topics where competitors get AI citations (you don't)**:

| Topic | AI Cites | Why They're Cited | Your Gap |
|-------|----------|-------------------|----------|
| [topic 1] | [Comp] | [reason] | [what you need] |
| [topic 2] | [Comp] | [reason] | [what you need] |

### GEO-Optimized Content Gaps

**Missing Q&A Content**:
| Question | Search Volume | Currently Answered By |
|----------|---------------|----------------------|
| [question] | [vol] | [competitor] |

**Missing Definition/Explanation Content**:
| Term | Search Volume | Best Current Source |
|------|---------------|---------------------|
| [term] | [vol] | [source] |

**Missing Comparison Content**:
| Comparison | Search Volume | Best Current Source |
|------------|---------------|---------------------|
| [A vs B] | [vol] | [source] |

### GEO Opportunity Score

| Topic | Traditional SEO Value | GEO Value (rubric band) | Combined Priority |
|-------|----------------------|-------------------------|-------------------|
| [topic] | [Gap Priority Score + the five factor scores it came from] | [1-5 + the rubric row scored against] | [tier from the SEO score; GEO Value breaks ties inside a tier] |
```

**All three cells are defined arithmetic, not impressions.** Traditional SEO Value *is* the gap's
Gap Priority Score — the same number, printed with the factor row that produced it, never a second
score computed alongside it. GEO Value is a 1-5 judgement against the rubric in
[score-arithmetic.md](./score-arithmetic.md) §4, and the report says in those words that it is a
judgement against a stated rubric, not a measured AI-citation count. Combined Priority is the tier
the gap already carries; inside a tier the order follows the priority score, with GEO Value
breaking ties. No blended SEO+GEO number is computed, because no exchange rate between the two
exists to blend them with.

## Audience Journey Gap Template

```markdown
## Audience Journey Gap Analysis

### Funnel Stage Coverage

Four stages, matching gap-analysis-frameworks.md §3 and SKILL.md Step 8. Awareness absorbs
Interest; Decision absorbs Intent and Purchase; Retention absorbs Advocacy.

| Stage | Your Content | Competitor Avg (mean of [n] columns) | Gap |
|-------|--------------|--------------------------------------|-----|
| Awareness | [X] articles | [X] articles | [+/-X] |
| Consideration | [X] articles | [X] articles | [+/-X] |
| Decision | [X] articles | [X] articles | [+/-X] |
| Retention | [X] articles | [X] articles | [+/-X] |
| **Total counted** | [X] articles | [X] articles | — |

Gap = your count − the competitor mean, so a negative figure means they have more. Every page is
counted once in exactly one stage, and the four rows sum to the Total row — a stage table that
does not reconcile has double-counted a page or dropped one.

### Journey Gap Details

#### Awareness Stage Gaps
- Missing: [topics/content]
- Opportunity: [description]

#### Consideration Stage Gaps
- Missing: [topics/content]
- Opportunity: [description]

#### Decision Stage Gaps
- Missing: [topics/content]
- Opportunity: [description]

#### Retention Stage Gaps
- Missing: [topics/content]
- Opportunity: [description]
```

## Prioritized Report Template

```markdown
# Content Gap Analysis Report

## Executive Summary

**Analysis Date**: [Date]
**Sites Analyzed**: [Your site] vs [Competitors]

**Key Findings**:
1. [Most significant gap]
2. [Second significant gap]
3. [Third significant gap]

**Total Opportunity**:
- Keyword gaps identified: [X]
- Combined search volume across those gaps: [X]/month — search volume, not visits
- Quick wins available: [X] pieces (Quick Win Score 2+)

---

## Prioritized Gap List

**How these tiers were assigned**: Tier 1 = P0 or P1 with a Quick Win Score of 2 or better ·
Tier 2 = P0 or P1 below that bar · Tier 3 = P2 and P3.

### Tier 1: Quick Wins (Do Now)

| Content to Create | Target Keyword | Volume | Difficulty | Factor scores (D/Den/R/E/C) | Gap Priority Score → tier | Quick Win Score |
|-------------------|----------------|--------|------------|------------------------------|---------------------------|-----------------|
| [Title idea] | [keyword] | [vol] | [diff] | [5/4/5/4/3] | [0.25×5 + 0.20×4 + 0.25×5 + 0.15×4 + 0.15×3 = 4.35 → P0] | [5+5+4+4−12 = +6] |
| [Title idea] | [keyword] | [vol] | [diff] | [scores] | [arithmetic → tier] | [arithmetic] |

**Why prioritize**: wanted, relevant, cheap and uncontested — the four inputs of the Quick Win
Score, all of them above midpoint

### Tier 2: Strategic Builds (This Quarter)

| Content to Create | Target Keyword | Volume | Difficulty | Factor scores (D/Den/R/E/C) | Gap Priority Score → tier | Quick Win Score |
|-------------------|----------------|--------|------------|------------------------------|---------------------------|-----------------|
| [Title idea] | [keyword] | [vol] | [diff] | [scores] | [arithmetic → tier] | [arithmetic] |

**Why prioritize**: High value, requires more resources — a P0/P1 score that the quick-win screen
did not clear, usually on Creation Effort

### Tier 3: Long-term Investments (This Year)

| Content to Create | Target Keyword | Volume | Difficulty | Factor scores (D/Den/R/E/C) | Gap Priority Score → tier | Quick Win Score |
|-------------------|----------------|--------|------------|------------------------------|---------------------------|-----------------|
| [Title idea] | [keyword] | [vol] | [diff] | [scores] | [arithmetic → tier] | [arithmetic] |

**Why prioritize**: Builds authority, competitive differentiator

**No traffic projection appears in this report.** Searches are not visits: the share that becomes
sessions depends on the position these pages reach and the click-through rate there, and neither
is known before they rank. The Total Opportunity line above reports combined search volume, and a
traffic target gets set from the first published pages' own rank data after about 90 days.

---

## Content Calendar Recommendation

### Month 1
| Week | Content | Type | Target Keyword | Status |
|------|---------|------|----------------|--------|
| 1 | [Title] | [Type] | [Keyword] | Planned |
| 2 | [Title] | [Type] | [Keyword] | Planned |
| 3 | [Title] | [Type] | [Keyword] | Planned |
| 4 | [Title] | [Type] | [Keyword] | Planned |

### Month 2
[Continue...]

### Month 3
[Continue...]

---

## Success Metrics

Track these to measure gap-filling success:

| Metric | Current | 3-Month Target | 6-Month Target |
|--------|---------|----------------|----------------|
| Keyword coverage | [X] | [X] | [X] |
| Topic clusters complete | [X] | [X] | [X] |
| Traffic from new content | 0 — these pages do not exist yet | target set once the first pages have ~90 days of rank data | target set from the 3-month reading |
| AI citations | [X] | [X] | [X] |
```

**Three things about the report above are the author's job, not the client's reading.** *Tier
assignment* is read from the two scores per SKILL.md Step 9; where the quick-win screen did not
run (Search Demand dropped), say so and read the tiers from the priority score alone. *Total
Opportunity* carries the gap count alone, and says so, when no volumes exist for the run. *No
traffic projection* is a rule, not a stylistic choice — see
[score-arithmetic.md](./score-arithmetic.md) §6.

**Two rows in the Success Metrics table are conditional.** *Traffic from new content* carries no plan-time target
number: the pages do not exist, so a figure there would be a forecast with no baseline and no
counterfactual behind it — the same reason no traffic projection appears in Total Opportunity.
Commit to the measurement date instead, and set the number from real rank and CTR data. *AI
citations* is filled only when an AI monitor supplied a count; with no monitor connected the row
is dropped and its absence noted, never carried as a zero — zero means measured and none found.

## Handoff Block Template

The runs that act on this analysis. The convention and its six payload fields are in
[../../../references/inter-skill-handoff.md](../../../references/inter-skill-handoff.md); this is
the shape the block takes when a gap analysis is the producing run.

**Emit it as its own fence, after the client report's fence has closed** (handoff §3.1, form 1),
because a model copies the fence and not the heading above it. The label below lives inside the
fence for the same reason.

````markdown
<!-- SKELETON · OPERATOR BLOCK — for whoever operates the library, not part of the client report
     above. Replace every bracket with a real value before this block is used; a field this run
     cannot source is deleted from the row and named in the note beneath, never left bracketed. -->
### Next runs

| # | Run | Why | Payload |
|---|-----|-----|---------|
| 1 | `keyword-research` | Demand is unvalidated — this run scored it from [the named proxy] | `"[head term]"` (+ [n] cluster members) · [content type] · `[https://site.example/section-it-would-live-in]` |
| 2 | `seo-content-writer` | Tier 1 build, cleared for writing once demand is confirmed | `"[head term]"` · [content type] · `[https://site.example/section-it-would-live-in]` |
| 3 | `content-refresher` | Depth gap on a page that already exists, not a net-new build | `"[head term]"` · [content type] · `[https://site.example/existing-page]` |

**Fields not sent — CORE-EEAT dimension scores, CITE scores, priority item IDs.** No content audit
and no domain audit has been run on this site, so all three are omitted rather than estimated. Run
`content-quality-auditor` on the pages once they publish if the next run needs them.
````

**Two things this block must not do.** It must not carry a bracket token, `TBD` or a
`~~category` token in a payload value position once it is filled — an unsourceable field is deleted
from the row and named in the note (handoff §4.2, §4.4). And no line of it belongs in client prose:
skill slugs and framework item IDs are operator handles, and the client-facing version of the same
recommendation names the *work* in the client's own language (handoff §3.3).
