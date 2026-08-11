# Internal Linking Optimizer — Output Templates

Detailed output templates for internal-linking-optimizer steps 4-7. Referenced from [SKILL.md](../SKILL.md).

**The suggestion contract applies to every template in this file** (SKILL.md § Instructions).
Each of these templates emits link suggestions, and a suggestion carries four fields — source
page, target page, **anchor text**, placement. One row or checkbox per link: a bare count ("add
links from 3 pages", "add the 2 missing cluster links") is a finding, not a suggestion — the site
owner still has no words to put on the page. Every `"[anchor]"` below is a slot you fill with the
string that ships; a client-read string never carries a bracket token, `TBD`, a provenance note
or an agency-workflow marker. An anchor you cannot source — because the
target page's own wording is not in front of you — means that suggestion is left out and the gap
is named in the report prose, never shipped as `"[anchor TBD]"`.

---

## Step 4: Create Topic Cluster Link Strategy

````markdown
## Topic Cluster Internal Linking

### Cluster: [Main Topic]

**Pillar Page**: [URL]
**Cluster Articles**: [X]

### Current Link Map

```
[Pillar Page]
   ├── [Cluster Article 1] ←→ [linked?]
   ├── [Cluster Article 2] ←→ [linked?]
   ├── [Cluster Article 3] ←→ [linked?]
   └── [Cluster Article 4] ←→ [linked?]
```

### Recommended Link Structure

```
[Pillar Page]
   ├── Links TO all cluster articles ✅
   │
   ├── [Cluster Article 1]
   │   ├── Link TO pillar ✅
   │   └── Link TO related cluster articles
   │
   ├── [Cluster Article 2]
   │   ├── Link TO pillar ✅
   │   └── Link TO related cluster articles
   │
   └── [etc.]
```

### Links to Add

| From Page | To Page | Anchor Text | Location |
|-----------|---------|-------------|----------|
| [URL 1] | [URL 2] | "[anchor]" | [paragraph/section] |
| [URL 2] | [URL 3] | "[anchor]" | [paragraph/section] |
| [Pillar] | [Cluster 1] | "[anchor]" | [section] |

One row per missing link — every pillar→cluster and cluster→pillar gap the map above shows gets
its own row here, so "the cluster is incomplete" never travels as a summary. The Anchor Text cell
holds the exact words that will appear on the source page; if the source page's own wording is
not in front of you, leave the row out and say which page's text you need.
````

---

## Step 5: Find Contextual Link Opportunities

```markdown
## Contextual Link Opportunities

### Link Opportunity Analysis

For each page, find relevant pages to link to based on:
- Topic relevance
- Keyword overlap
- User journey logic
- Authority distribution needs

### Opportunities Found

**Page: [URL 1]**
**Topic**: [topic]
**Current internal links**: [X]

| Opportunity | Target Page | Anchor Text | Why Link |
|-------------|-------------|-------------|----------|
| Paragraph 2 mentions "[topic]" | [URL] | "[topic phrase]" | Topic match |
| Section on "[subject]" | [URL] | "[anchor]" | Related guide |
| CTA at end | [URL] | "[anchor]" | User journey |

**Page: [URL 2]**
[Continue for each page...]

### Priority Link Additions

**High Impact Links** (add these first):

1. **From**: [Source URL]
   **To**: [Target URL]
   **Anchor**: "[anchor text]"
   **Why**: [reason - e.g., "Target page needs authority boost"]
   **Where to add**: [specific location in content]

2. **From**: [Source URL]
   **To**: [Target URL]
   [etc.]
```

---

## Step 6: Optimize Navigation and Footer Links

```markdown
## Site-Wide Link Optimization

### Current Navigation Analysis

**Main Navigation**:
- Links present: [list]
- Missing important pages: [list]
- Too many links: [Yes/No]

**Footer Navigation**:
- Links present: [list]
- SEO value: [assessment]

### Navigation Recommendations

| Element | Current | Recommended | Reason |
|---------|---------|-------------|--------|
| Main nav | [X] links | [Y] links | [reason] |
| Footer | [X] links | [Y] links | [reason] |
| Sidebar | [status] | [recommendation] | [reason] |
| Breadcrumbs | [status] | [recommendation] | [reason] |

### Pages to Add to Navigation

A navigation entry's anchor is its menu label, so name the label you propose.

1. [Page] - Add to [location] with the label "[label]" because [reason]
2. [Page] - Add to [location] with the label "[label]" because [reason]

### Pages to Remove from Navigation

1. [Page] - Move to [footer/remove] because [reason]
```

---

## Step 7: Generate Link Implementation Plan

```markdown
# Internal Linking Optimization Plan

**Site**: [domain]
**Analysis Date**: [date]

## Executive Summary

- Total link opportunities found: [X]
- Orphan pages to fix: [X]
- Pages gaining inbound links under this plan: [X]
- Priority actions: [X]

*No traffic or ranking forecast appears here.* Every line above is a count this analysis
produced. A "+X% traffic" figure would need a ranking and traffic baseline plus a
counterfactual, and this analysis has neither — see [score-rubric.md](./score-rubric.md) §6,
and offer the baseline-then-re-measure plan instead of a number.

## Current State

| Metric | Current | Target | Gap |
|--------|---------|--------|-----|
| Avg links per page | [X] ([links] ÷ [pages]) | [X] | [X] |
| Orphan pages | [X] | 0 | [X] |
| Over-optimized anchors | [X]% ([n]/[base]) | <10% | [X]% |
| Topic cluster coverage | [X]% ([n]/[base]) | 100% | [X]% |

Current is the measurement with its base shown; Target is the target; Gap is their difference.

## After This Plan

Optional — print it only if you state projected figures at all, and only for the link graph.

| Metric | Now | After these changes | How it gets there |
|--------|-----|---------------------|-------------------|
| Live in-body internal links | [X] | [Y] | [X] + [n] additions listed above = [Y] |
| Avg links per page | [X] | [Y] | [after-state links] ÷ [pages] = [Y] |
| Orphan pages | [X] | [Y] | [which listed fix removes which orphan] |
| Inbound links to [priority page] | [X] | [Y] | [X] + [n] of the additions target it = [Y] |

The last column is the check: every projection assumes **only** the changes this plan lists,
and the reader can re-run it from the tables above. Drop a row whose arithmetic will not fit
there, and drop the table entirely rather than carry one borrowed figure. No traffic or ranking
row belongs here — see [score-rubric.md](./score-rubric.md) §5 (after-state figures) and §6.

## Priority Actions

Phases follow the Implementation Priority Order (structural fixes, then architecture, then
cross-linking, then anchors). Every checkbox that adds or rewrites a link is a link suggestion,
so it is written one link per checkbox as `[source] → [target] · "[anchor]" · [placement]`. A
checkbox may cite the row that already carries those fields ("Links to Add, row 3") instead of
repeating them; it may not replace them with a count.

### Phase 1: Critical Fixes (Week 1)

**Fix Orphan Pages** — one checkbox per inbound link, not one per orphan:
- [ ] [source URL] → [orphan URL] · "[anchor]" · [section on the source page]
- [ ] [source URL] → [orphan URL] · "[anchor]" · [section on the source page]

**Fix Broken Internal Links**:
- [ ] [source URL] → [broken URL] · repoint to [live URL], anchor "[anchor]" · [section] (or remove the link and say so)

**High-Value Link Additions**:
- [ ] [Page A] → [Page B] · "[anchor]" · [section]
- [ ] [Page A] → [Page C] · "[anchor]" · [section]

### Phase 2: Topic Clusters (Week 2-3)

**Cluster 1: [Topic]** — one checkbox per missing link; "complete the cluster" is not a task:
- [ ] [Pillar] → [Cluster article 1] · "[anchor]" · [section]
- [ ] [Cluster article 2] → [Pillar] · "[anchor]" · [section]
- [ ] [Cluster article 1] → [Cluster article 2] · "[anchor]" · [section] — cross-link

**Cluster 2: [Topic]**
- [ ] [same shape, one checkbox per link]

### Phase 3: Optimization (Week 4+)

**Anchor Text Diversity** — a rewrite names the link it rewrites and both strings:
- [ ] [source URL] → [target URL] · "[current anchor]" → "[replacement anchor]" ([n] of [base] inbound anchors are exact match, [X]%)
- [ ] [source URL] → [target URL] · "[current anchor]" → "[replacement anchor]"

**Navigation Updates** (template links — the menu label is the anchor):
- [ ] Add [Page] to main navigation with the label "[label]"
- [ ] Update footer links

## Implementation Guide

### Adding Internal Links

Best practices:
1. Add links contextually within content
2. Use descriptive anchor text (not "click here")
3. Link to relevant, helpful pages
4. Aim for 3-10 internal links per 1,000 words
5. Vary anchor text for the same target

### Anchor Text Guidelines

| Type | Example | Usage |
|------|---------|-------|
| Exact match | "keyword research" | 10-20% |
| Partial match | "tips for keyword research" | 30-40% |
| Branded | "Brand's guide to..." | 10-20% |
| Natural (conversational, still names the destination) | "this guide to brake adjustment", "how we true a wheel" | 20-30% |
| Content-free | "this article", "learn more", "click here", "read more", a bare URL | 0% |

**Natural means conversational, not content-free** (ruled 2026-08-10, resolving this table's
conflict with SKILL.md Step 3, which marks content-free anchors ❌ Not descriptive). A
Natural-band anchor is relaxed phrasing that still tells the reader what is on the other side —
"this guide to brake adjustment", not "this article". A content-free string names neither the
destination nor its topic, so it gives a reader nothing to decide on and an engine nothing to
index; it is in no band at any percentage, and it is never a recommended anchor. Score-side
consequence in [score-rubric.md](./score-rubric.md) §3: descriptive-conversational scores ✅ 1,
content-free scores ❌ 0.

## Tracking Success

Baselined from this analysis (measurable today, re-measurable after each phase):
- [ ] Inbound in-body link count per priority page — baseline: [X]
- [ ] Orphan page count — baseline: [X]
- [ ] Anchor distribution for the over-optimized targets — baseline: [n]/[base]

Needs data not yet connected (list the connector, do not report a baseline):
- [ ] Rankings for target keywords — requires rank-tracking data
- [ ] Traffic to previously orphan pages — requires analytics
- [ ] Crawl stats — requires Search Console
```

**Split the tracking list.** Metrics this analysis can baseline get a number now; metrics that
need a tool nobody connected are listed with the connector they need and no baseline beside
them. A tracking row with an invented starting figure poisons every later comparison.
