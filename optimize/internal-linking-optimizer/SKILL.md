---
name: internal-linking-optimizer
version: "4.3.0"
description: 'Analyze and optimize internal link structure to improve site architecture, distribute page authority, and fix orphan pages. Use when the user asks to "fix internal links", "improve site architecture", "link structure", "distribute page authority", "internal linking strategy", "orphan pages", "site architecture is messy", or "pages have no links pointing to them". For a broader on-page audit, see on-page-seo-auditor. For external link analysis, see backlink-analyzer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.0"
  geo-relevance: "low"
  tags:
    - seo
    - internal linking
    - site architecture
    - link structure
    - page authority
    - link equity
    - content silos
    - navigation optimization
    - internal-links
    - site-architecture
    - link-equity
    - orphan-pages
    - topical-authority
    - hub-and-spoke
    - pillar-cluster
    - anchor-text
    - crawl-depth
  triggers:
    - "fix internal links"
    - "improve site architecture"
    - "link structure"
    - "distribute page authority"
    - "internal linking strategy"
    - "site navigation"
    - "link equity"
    - "orphan pages"
    - "site architecture is messy"
    - "pages have no links pointing to them"
---

# Internal Linking Optimizer


This skill analyzes your site's internal link structure and provides recommendations to improve SEO through strategic internal linking. It helps distribute authority, establish topical relevance, and improve crawlability.

## When to Use This Skill

- Improving site architecture for SEO
- Distributing authority to important pages
- Fixing orphan pages with no internal links
- Creating topic cluster internal link strategies
- Optimizing anchor text for SEO
- Recovering pages that have lost rankings
- Planning internal links for new content

## What This Skill Does

1. **Link Structure Analysis**: Maps current internal linking patterns
2. **Authority Flow Mapping**: Shows how PageRank flows through site
3. **Orphan Page Detection**: Finds pages with no internal links
4. **Anchor Text Optimization**: Improves anchor text diversity
5. **Topic Cluster Linking**: Creates pillar-cluster link strategies
6. **Link Opportunity Finding**: Identifies where to add links
7. **Navigation Optimization**: Improves site-wide link elements

## How to Use

### Analyze Current Structure

```
Analyze internal linking structure for [domain/sitemap]
```

```
Find internal linking opportunities for [URL]
```

### Create Linking Strategy

```
Create internal linking plan for topic cluster about [topic]
```

```
Suggest internal links for this new article: [content/URL]
```

### Fix Issues

```
Find orphan pages on [domain]
```

```
Optimize anchor text across the site
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~web crawler + ~~analytics connected:**
Claude can automatically perform a full site crawl via ~~web crawler to map the complete link graph, fetch page performance metrics from ~~analytics to identify high-value pages, and analyze link flow throughout the site. This enables data-driven internal linking strategies.

**With manual data only:**
Ask the user to provide:
1. Sitemap URL or list of important pages
2. Key page URLs that need more internal links
3. Content categories or topic clusters
4. Any existing link structure documentation

Proceed with the analysis using provided data. Note in the output which findings are from automated crawl vs. manual review.

## Instructions

**The suggestion contract, binding on every step below.** A concrete link suggestion carries four
fields — source page, target page, **anchor text**, placement. A bare count ("add links from 3
pages", "add the two missing cluster links") is a finding, not a suggestion: expand it into one
row per link, each with its own anchor, or cite the table row that carries them. A redirect or a
deletion is not a link suggestion; a navigation entry's anchor is its menu label. **Anchors ship
as final copy**: bracket tokens in the templates below are slots you fill, and a client-pasted
string carries no bracket token, no `TBD`, no provenance note and no workflow marker — where a
value cannot be sourced, drop that field and name the gap in report prose *outside* the string.

When a user requests internal linking optimization:

1. **Analyze Current Internal Link Structure**

   ```markdown
   ## Internal Link Structure Analysis
   
   ### Overview
   
   **Domain**: [domain]
   **Total Pages Analyzed**: [X]
   **Total Internal Links**: [X] — [n] in body copy ([b] of them broken) and [m] template links
   **Average Links per Page**: [links] ÷ [pages] = [X] (counting [which population])
   
   ### Link Distribution
   
   Rows count **inbound** links per page — the axis orphan status is read off — and separate
   in-body links from template ones, because only the first kind is editorial.
   
   | Inbound links per page | Page Count | Percentage |
   |------------------------|------------|------------|
   | 0 in-body **and** 0 template — orphan | [X] | [X]% |
   | 0 in-body, template/nav inbound only — not an orphan | [X] | [X]% |
   | 1-5 | [X] | [X]% |
   | 6-10 | [X] | [X]% |
   | 11-20 | [X] | [X]% |
   | 21+ | [X] | [X]% |
   
   ### Top Linked Pages
   
   | Page | Internal Links | Authority | Notes |
   |------|----------------|-----------|-------|
   | [URL 1] | [X] | High | [notes] |
   | [URL 2] | [X] | High | [notes] |
   | [URL 3] | [X] | Medium | [notes] |
   
   ### Under-Linked Important Pages
   
   | Page | Current Links | Traffic | Recommended Links (a count — the links themselves are in Steps 4-5) |
   |------|---------------|---------|-------------------|
   | [URL 1] | [X] | [X]/mo | [X]+ |
   | [URL 2] | [X] | [X]/mo | [X]+ |
   
   **Structure Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked — [why]; scored against the [model] targets)
   ```

   > **Deriving it**: six rows — orphan pages, average links per page, under-linked important
   > pages, click depth, broken internal links, cluster bidirectionality — each ✅ 1 · ⚠️ 0.5 ·
   > ❌ 0, then `round(10 × points ÷ rows scored)` with an exact half rounding down. Rows you
   > could not check leave the denominator; they are never scored 0. The tables above the score
   > are evidence, not scored rows. Row definitions, targets and a worked derivation:
   > [references/score-rubric.md](./references/score-rubric.md).
   >
   > **Authority** in the Top Linked Pages table is a within-site relative label read off that
   > row's own inbound-link count, and the cut is stated ("High = 5+ inbound in-body links on
   > this 8-page site"). It is never an external metric — no DA, DR, PA or vendor authority
   > score appears unless a named connected tool supplied it.

2. **Identify Orphan Pages**

   ```markdown
   ## Orphan Page Analysis
   
   ### Definition
   Orphan pages have no internal links pointing to them — **none of any kind**: none in body
   copy and none from a template (menu, footer, logo) — making them hard for users and search
   engines to discover. A page whose only inbound links are template links is reachable and is
   **not** an orphan: report it as template-only inbound. The site root is never an orphan.
   
   ### Orphan Pages Found: [X]
   
   | Page | Inbound (in-body / template) | Traffic | Priority | Action class |
   |------|------------------------------|---------|----------|--------------|
   | [URL 1] | 0 / 0 | [X]/mo | High | Add contextual links |
   | [URL 2] | 0 / 0 | [X]/mo | Medium | Add to navigation |
   | [URL 3] | 0 / 0 | 0 | Low | Redirect or delete |
   
   ### Fix Strategy
   
   Priority: **High** where the orphan pages have traffic/rankings, **Medium** where they are
   potentially valuable, **Low** where you would consider removing them. Each fix below is a link
   suggestion, so it carries the contract's four fields: source page, target page, anchor text,
   placement — one row per link, and the anchor is the string that ships.
   
   | Orphan (target) | Priority | Link from (source) | Anchor text | Placement on source |
   |-----------------|----------|--------------------|-------------|---------------------|
   | [URL] | High | [source URL] | "[anchor]" | [section or paragraph] |
   | [URL] | High | [source URL] | "[anchor]" | [section or paragraph] |
   | [URL] | Medium | [category or tag page] | "[anchor]" | [listing or section] |
   
   **Low Priority Orphans** (consider removing) — a redirect or a deletion is not a link
   suggestion, so no anchor is required:
   1. [URL] - Redirect to [better page]
   2. [URL] - Delete or noindex
   ```

3. **Analyze Anchor Text Distribution**

   > **CORE-EEAT alignment**: Internal linking quality maps to R08 (Internal Link Graph) in the CORE-EEAT benchmark -- use descriptive anchors, ensure links support topical authority. See [content-quality-auditor](../../cross-cutting/content-quality-auditor/) for full audit.

   ```markdown
   ## Anchor Text Analysis
   
   ### Current Anchor Text Patterns
   
   **Most Used Anchors**:
   
   | Anchor Text | Count | Target Pages | Assessment |
   |-------------|-------|--------------|------------|
   | "click here" | [X] | [X] pages | ❌ Not descriptive |
   | "read more" | [X] | [X] pages | ❌ Not descriptive |
   | "this article" / "learn more" | [X] | [X] pages | ❌ Content-free — names no destination |
   | "[exact keyword]" | [X] | [page] | ⚠️ May be over-optimized |
   | "[descriptive phrase]" | [X] | [page] | ✅ Good |
   | "this guide to [subtopic]" | [X] | [page] | ✅ Good — conversational and descriptive |
   
   ### Anchor Text Distribution by Page
   
   **Page: [Important URL]**
   
   | Anchor Text | Source Page | Status |
   |-------------|-------------|--------|
   | "[anchor 1]" | [source URL] | ✅/⚠️/❌ |
   | "[anchor 2]" | [source URL] | ✅/⚠️/❌ |
   
   **Issues Found**:
   - Over-optimized anchors: [X] instances
   - Generic anchors: [X] instances
   - Same anchor to multiple pages: [X] instances
   
   ### Anchor Text Recommendations
   
   **For Page: [URL]**
   
   Current: "[current anchor]" used [X] times
   
   Recommended variety — each line names the source page the anchor goes on; the string ships as written:
   - "[variation 1]" - on [source URL], [section]
   - "[variation 2]" - on [source URL], [section]
   - "[variation 3]" - on [source URL], [section]
   
   **Anchor Score**: [X]/10 ([points] ÷ [N] in-body link instances; [M] template links excluded)
   ```

   > **Deriving it**: one row per internal link instance you inventoried, graded by the
   > Assessment column above — ✅ 1 descriptive, which includes a conversational anchor that
   > still names its destination ("this guide to brake adjustment") · ⚠️ 0.5 exact-match
   > repetition into one target, or the same anchor on two different targets · ❌ 0
   > **content-free** — an anchor naming neither the destination nor its topic ("click here",
   > "read more", "this article", "learn more", a bare URL) — then
   > `round(10 × points ÷ instances graded)`, halves down. **The population is printed with the
   > score**: 6/10 over 14 links and 6/10 over 1,400 are different findings, and a reader who
   > cannot see which cannot check either. Template links repeated site-wide are excluded (or
   > graded once) and the report says which rule it applied. Grades, the Natural-band ruling
   > and a worked derivation: [references/score-rubric.md](./references/score-rubric.md).
   >
   > **The Natural band is descriptive, not content-free** (ruled 2026-08-10, resolving the
   > conflict between this table and the Anchor Text Guidelines in linking-templates.md). The
   > Natural row's 20-30% share is for anchors that are *conversational but still name what is
   > on the other side* — "this guide to brake adjustment". Content-free strings are in no band
   > at any percentage: they tell a reader nothing and give an engine nothing, so they are ❌
   > here, 0% of the target mix, and never a recommended anchor.

4. **Create Topic Cluster Link Strategy** — Map current pillar/cluster links, recommend link structure, list specific links to add

   > **Reference**: See [references/linking-templates.md](./references/linking-templates.md) for the topic cluster link strategy template (Step 4) — its Links to Add table carries the From Page / To Page / Anchor Text / Location columns every suggestion needs.

5. **Find Contextual Link Opportunities** — Analyze each page for topic-relevant link opportunities, prioritize high-impact additions

   > **Reference**: See [references/linking-templates.md](./references/linking-templates.md) for the contextual link opportunities template (Step 5) — same four fields per suggestion.

6. **Optimize Navigation and Footer Links** — Analyze main/footer/sidebar/breadcrumb navigation, recommend pages to add or remove

   > **Reference**: See [references/linking-templates.md](./references/linking-templates.md) for the navigation optimization template (Step 6).

7. **Generate Link Implementation Plan** — Executive summary, current state metrics, phased priority actions (weeks 1-4+), implementation guide, tracking plan

   > **Reference**: See [references/linking-templates.md](./references/linking-templates.md) for the full implementation plan template (Step 7). This is the what-to-fix-first surface, so the contract applies hardest here: every phase checkbox that adds a link is one checkbox per link, written `[source] → [target] · "[anchor]" · [placement]` — never "add links from [X] pages" or "add the [X] missing cluster links". A checkbox may cite the row that already carries the four fields instead of repeating them.

## Scoring & Impact-Figure Rules

Three rules that bind every step above.

**Every number shows its working.** Both scores are arithmetic over rows the analysis already
printed (Steps 1 and 3 above), and so is everything else: a total names its population before
it is stated — "21 link instances — 14 in body copy, 1 of them broken, plus 7 template logo
links" — and every derived figure prints its arithmetic, `14 ÷ 8 = 1.75`, `3/5 = 60%`. A
percentage or a score without a visible base is not deliverable. A row, or a whole score, that
the data could not settle is written `not scored — no link data`, never `0/10`: zero means
measured and failing, blank means unmeasured. **With no site data at all, neither score is
printed** — name the input that unlocks each one and stop. Full rubric:
[references/score-rubric.md](./references/score-rubric.md).

**An after-state figure is derived too, and derived from this report's own proposals.** A
projected link count, average, inbound total or authority share may assume **only** the link
changes this report itself lists, and it shows the addition that gets there — "13 live in-body
links + the 10 additions above = 23". Borrowing changes recommended in another report, or in
another conversation, makes the figure unreproducible for the reader holding this one. A figure
produced by a named model rather than by arithmetic — a PageRank-style authority share — counts
as shown only when the model, its parameters and the exact graph it ran on are all printed
here ("damped random-surfer, damping 0.85, on the 8-page graph above, logo links included, the
broken link excluded"); otherwise show the arithmetic or leave the figure out. This is
link-graph arithmetic, not a forecast: it says how the links would sit, never what traffic
would follow.

**No site-specific traffic or ranking forecast.** Predicting "+18% traffic" for a named site
needs a ranking and traffic baseline plus a counterfactual, and an internal-link analysis has
neither — so the Step 7 executive summary reports what was measured (link opportunities found,
orphans to fix, pages gaining inbound links) and stops. The ROI Estimation ranges in
[references/link-architecture-patterns.md](./references/link-architecture-patterns.md) are
uncited practitioner estimates carrying a `[VERIFY]` tag; they may be quoted only with that
attribution in the same sentence, never in the summary's metrics list, never multiplied by the
site's sessions, never as "expected". When a client wants a number, offer the measurement that
would produce one — baseline the affected pages now, re-measure 4-8 weeks after implementation.

## Validation Checkpoints

### Input Validation
- [ ] Site structure or sitemap provided (URL or file)
- [ ] Target pages or topic clusters clearly defined
- [ ] If optimizing specific page, page URL or content provided

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] All link suggestions include source page, target page, and recommended anchor text — orphan fixes included, since a fix for an orphan is a link suggestion (Step 2's Fix Strategy table carries the same four fields as Step 4's)
- [ ] Orphan page lists include URLs and recommended actions, and list only pages with no inbound link of any kind; a page reachable through template/nav links only is reported as template-only inbound, not as an orphan
- [ ] No recommended anchor is content-free ("click here", "read more", "this article", "learn more", a bare URL) — the Natural band means conversational *and* descriptive
- [ ] Every paste-ready string — a recommended anchor, the sentence carrying it, any link markup — is final copy: no bracket token, no `TBD`/`XX`, no provenance note ("client data needed", "per the export") and no agency-workflow marker inside it. Gaps, assumptions and source labels live in the report and recommendation-table frame around it, never in the string the client copies
- [ ] Every projected or after-state figure is re-derivable from the changes this report itself proposes, with the addition shown; a model-produced figure prints its model, parameters and input graph
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Screaming Frog, Google Analytics 4), "user-provided", or "manual analysis"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Each score prints its derivation — Structure Score as [points] ÷ [rows scored] with the model it was scored against and the unchecked rows named; Anchor Score as [points] ÷ [link instances graded] with the excluded template links named. A score with nothing checkable reads "not scored — no link data", never 0/10; no site data at all means no score in the report
- [ ] Every total names its population and every derived figure shows its arithmetic (`14 ÷ 8 = 1.75`, `3/5 = 60%`); the Authority column states its cut and carries no external DA/DR/PA figure unless a named tool supplied it
- [ ] No traffic or ranking outcome is stated as this site's expected number; the reference's ROI ranges appear only with their "typical ranges, not a projection for your site" attribution attached, and never in the executive summary's metrics list

## Example

> **Reference**: See [references/linking-example.md](./references/linking-example.md) for a full worked example (email marketing best practices internal linking opportunities).

## Tips for Success

1. **Quality over quantity** - Add relevant links, not random ones
2. **User-first thinking** - Links should help users navigate
3. **Vary anchor text** - Avoid over-optimization
4. **Link to important pages** - Distribute authority strategically
5. **Regular audits** - Internal links need maintenance as content grows

## Reference Materials

- [Score Rubric & Impact-Figure Rule](./references/score-rubric.md) — How the Structure Score and Anchor Score are derived: the six structure rows and their targets, one row per link instance for anchors, population and rounding rules, when a score is withheld, and what the plan may say about traffic impact
- [Link Architecture Patterns](./references/link-architecture-patterns.md) — Architecture models (hub-and-spoke, silo, flat, pyramid, mesh) with their link rules, migration paths, the Key Metrics by Architecture Model targets the Structure Score is scored against, the Monthly Monitoring Checklist, the `[VERIFY]`-tagged ROI ranges, and the Implementation Priority Order
- [Linking Templates](./references/linking-templates.md) — Detailed output templates for **steps 4-7**: topic cluster strategy (Step 4) and contextual opportunities (Step 5), both carrying the From Page / To Page / Anchor Text / Location columns, plus navigation optimization (Step 6), the implementation plan (Step 7) and the Anchor Text Guidelines bands
- [Linking Example](./references/linking-example.md) — Full worked example for internal linking opportunities

## Related Skills

- [content-gap-analysis](../../research/content-gap-analysis/) — Find content to link to
- [seo-content-writer](../../build/seo-content-writer/) — Create linkable content
- [on-page-seo-auditor](../on-page-seo-auditor/) — Audit overall on-page SEO
- [technical-seo-checker](../technical-seo-checker/) — Check crawlability
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit
- [schema-markup-generator](../../build/schema-markup-generator/) — Breadcrumb and navigation schema
