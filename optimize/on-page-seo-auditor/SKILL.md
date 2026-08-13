---
name: on-page-seo-auditor
version: "4.3.2"
description: 'Audit on-page HTML elements including title tags, headers, image alt text, and internal links with a scored SEO report. Use when the user asks to "audit page SEO", "on-page SEO check", "SEO score", "page optimization", "what SEO issues does this page have", "score my page", "why is this page not ranking", or "check my page". For server, speed, and crawl issues, see technical-seo-checker. For full EEAT content quality scoring, see content-quality-auditor.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
allowed-tools: WebFetch
metadata:
  author: aaron-he-zhu
  version: "4.3.2"
  geo-relevance: "medium"
  tags:
    - seo
    - on-page audit
    - page optimization
    - seo audit
    - content optimization
    - header tags
    - image optimization
    - seo score
    - page-audit
    - seo-score
    - on-page-optimization
    - optimization-checklist
    - seo-checklist
    - page-score
    - h1-optimization
    - meta-audit
    - content-audit
  triggers:
    - "audit page SEO"
    - "on-page SEO check"
    - "SEO score"
    - "page optimization"
    - "what SEO issues"
    - "check my page"
    - "on-page audit"
    - "what's wrong with this page's SEO"
    - "score my page"
    - "why isn't this page ranking"
---

# On-Page SEO Auditor


This skill performs detailed on-page SEO audits to identify issues and optimization opportunities. It analyzes all on-page elements that affect search rankings and provides actionable recommendations.

## When to Use This Skill

- Auditing pages before or after publishing
- Identifying why a page isn't ranking well
- Optimizing existing content for better performance
- Creating pre-publish SEO checklists
- Comparing your on-page SEO to competitors
- Systematic site-wide SEO improvements
- Training team members on SEO best practices

## What This Skill Does

1. **Title Tag Analysis**: Evaluates title optimization and CTR potential
2. **Meta Description Review**: Checks description quality and length
3. **Header Structure Audit**: Analyzes H1-H6 hierarchy
4. **Content Quality Assessment**: Reviews content depth and optimization
5. **Keyword Usage Analysis**: Checks keyword placement and density
6. **Internal Link Review**: Evaluates internal linking structure
7. **Image Optimization Check**: Audits alt text and file optimization
8. **Technical On-Page Review**: Checks URL, canonical, and mobile factors

## How to Use

### Audit a Single Page

```
Audit the on-page SEO of [URL]
```

```
Check SEO issues on this page targeting [keyword]: [URL/content]
```

### Compare Against Competitors

```
Compare on-page SEO of [your URL] vs [competitor URL] for [keyword]
```

### Audit Content Before Publishing

```
Pre-publish SEO audit for this content targeting [keyword]: [content]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~web crawler connected:**
Claude can automatically pull page HTML via ~~web crawler, fetch keyword search volume and difficulty from ~~SEO tool, retrieve click-through rate data from ~~search console, and download competitor pages for comparison. This enables fully automated audits with live data.

**With manual data only:**
Ask the user to provide:
1. Page URL or complete HTML content
2. Target primary and secondary keywords
3. Competitor page URLs for comparison (optional)

Proceed with the full audit using provided data. Note in the output which findings are from automated crawl vs. manual review.

**Resolve every `~~category` token before the audit leaves.** The token addresses you and the operator, never the person reading the report: write the connected tool's real name (Google Search Console, Ahrefs, Screaming Frog), or name the actual source in plain language ("the HTML you pasted", "hand-checked in incognito, 10 Aug"), or state plainly that no tool was connected and the figure is therefore unavailable. Never a token where a source or a number belongs — an unobtainable metric is reported as unobtainable, which is what the Hypothesis label and the "what would confirm it" rule below already require. Internal surfaces keep the token (this skill's own text and references, operator notes). Rule: root `CLAUDE.md` Tool Connector Pattern; check: `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 7.

## Instructions

When a user requests an on-page SEO audit:

### Finding Format & Confidence Labels

Every finding in the audit output carries **Finding** (what is wrong, with the specific
element or location), **Evidence** (the observed data behind it), **Impact** (why it
matters), and **Fix** (the specific change), plus a **Confidence** label:

- **Confirmed** — directly observed in provided data or crawl output (e.g., the fetched HTML)
- **Likely** — strong indirect evidence (e.g., a pattern consistent across the elements sampled)
- **Hypothesis** — plausible but needs verification (e.g., anything inferred without crawl or tool access)

**Rule**: every Hypothesis finding must name what would confirm it (the specific check,
tool, or data source). Use the labels in each step's "Issues Found" list and carry them
into the Step 11 Priority Issues summary.

**Quote discipline**: the E-E-A-T signals row and the "Expert quotes" element in Step 5, and
the Ept01/R02 rows of the Step 10 quick scan, all push a Fix toward "add an expert quote".
Recommend the quote; never write one. A quotation attributed to a named person or
organisation ships only with a real, checkable source in the same breath — speaker, role,
where and when they said it, and a link that opens. Without one, do not attribute it:
paraphrase it unattributed, or drop it, and never invent a name, credential or institution to
carry a line (statistics rule: sourced, cited, or placeholder, never invented). The audit's
own Evidence follows the same rule: quote the page verbatim from the HTML or content in front
of you, never from memory or reconstruction.

**Section scores and the overall score.** Every section score is arithmetic over the criterion
table printed above it, scored on **that section's own maximum** — Title Tag /15 · Meta
Description /5 · Header Structure /10 · Content Quality /25 · Keyword Optimization /15 ·
Internal/External Links /10 · Image Optimization /10 · Page-Level Technical /10. Those eight
maxima *are* the section weights (15%, 5%, 10%, 25%, 15%, 10%, 10%, 10%), so the **Overall Score
is the plain sum of the eight section scores, out of 100** — no conversion step, no rounding
drift, and a client can check it by adding the eight numbers the report already printed. Per
criterion: ✅ full points · ⚠️ half · ❌ 0. **A criterion you could not verify is excluded from
both the numerator and the section maximum** — never scored 0, never guessed (the rubric's own
rule: "note it as unverified rather than guessing"), because zero means measured and failing
while blank means unmeasured. The overall is then `round(100 × awarded ÷ points scored)`, and
every score prints its numerator, its denominator, and how many criteria were excluded. **If no
section could be scored, the report carries no overall score at all** — name which input unlocks
which section and stop; a score for a page nobody has seen is a fabricated figure, whatever the
requester says about the deadline. Criterion point tables, calibration examples, the
unverified-criterion worked case and the grade bands:
[references/scoring-rubric.md](./references/scoring-rubric.md).

1. **Gather Page Information**

   ```markdown
   ### Audit Setup
   
   **Page URL**: [URL]
   **Target Keyword**: [primary keyword]
   **Secondary Keywords**: [additional keywords]
   **Page Type**: [blog/product/landing/service]
   **Business Goal**: [traffic/conversions/authority]
   ```

2. **Audit Title Tag**

   ```markdown
   ## Title Tag Analysis
   
   **Current Title**: [title]
   **Character Count**: [X] characters
   
   | Criterion | Status | Points | Notes |
   |-----------|--------|--------|-------|
   | Keyword included | ✅/⚠️/❌ | [X]/3 | Position: [front/middle/end] |
   | Keyword at front | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Length (50-60 chars) | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Unique across site | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Compelling/clickable | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Matches intent | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Brand at end | ✅/⚠️/❌ | [X]/1 | [notes] |
   | No truncation risk | ✅/⚠️/❌ | [X]/1 | [notes] |
   
   **Title Score**: [X]/15 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)
   
   **Issues Found**:
   - [Issue 1] — Confidence: [Confirmed/Likely/Hypothesis; a Hypothesis names what would confirm it]
   - [Issue 2] — Confidence: [Confirmed/Likely/Hypothesis; a Hypothesis names what would confirm it]
   
   **Recommended Title**:
   "[Optimized title suggestion]"
   
   **Why**: [Explanation of improvements]
   ```

3. **Audit Meta Description**

   ```markdown
   ## Meta Description Analysis
   
   **Current Description**: [description]
   **Character Count**: [X] characters
   
   | Criterion | Status | Points | Notes |
   |-----------|--------|--------|-------|
   | Keyword included | ✅/⚠️/❌ | [X]/1 | [notes] |
   | Length (150-160 chars) | ✅/⚠️/❌ | [X]/1 | [notes] |
   | Call-to-action present | ✅/⚠️/❌ | [X]/1 | [notes] |
   | Unique across site | ✅/⚠️/❌ | [X]/1 | [notes] |
   | Accurately describes page | ✅/⚠️/❌ | [X]/1 | [notes] |
   | Compelling copy | ✅/⚠️/❌ | — | Observed, not scored: the 5-point scale has no point for it. It drives the rewrite below |
   
   **Description Score**: [X]/5 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)
   
   **Issues Found**:
   - [Issue 1] — Confidence: [Confirmed/Likely/Hypothesis; a Hypothesis names what would confirm it]
   
   **Recommended Description**:
   "[Optimized description suggestion]" ([X] chars)
   ```

4. **Audit Header Structure**

   ```markdown
   ## Header Structure Analysis
   
   ### Current Header Hierarchy
   
   ```
   H1: [H1 text]
     H2: [H2 text]
       H3: [H3 text]
       H3: [H3 text]
     H2: [H2 text]
       H3: [H3 text]
     H2: [H2 text]
   ```
   
   | Criterion | Status | Points | Notes |
   |-----------|--------|--------|-------|
   | Single H1 | ✅/⚠️/❌ | [X]/2 | Found: [X] H1s |
   | H1 includes keyword | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Logical hierarchy — no skipped levels | ✅/⚠️/❌ | [X]/2 | [notes] |
   | H2s cover key subtopics | ✅/⚠️/❌ | [X]/2 | [notes] |
   | Descriptive headers | ✅/⚠️/❌ | [X]/1 | [notes] |
   | Keyword variations in H2s | ✅/⚠️/❌ | [X]/1 | [X]/[Y] contain keywords |
   
   **Header Score**: [X]/10 ([awarded] ÷ [points scored]; [N] criteria unverified and excluded)
   
   **Issues Found**:
   - [Issue 1] — Confidence: [Confirmed/Likely/Hypothesis; a Hypothesis names what would confirm it]
   - [Issue 2] — Confidence: [Confirmed/Likely/Hypothesis; a Hypothesis names what would confirm it]
   
   **Recommended Changes**:
   - H1: [suggestion]
   - H2s: [suggestions]
   ```

5. **Audit Content Quality** — Word count, reading level, comprehensiveness, formatting, E-E-A-T signals, content elements checklist, gap identification

   > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the content quality template (Step 5).

6. **Audit Keyword Usage** — Primary/secondary keyword placement across all page elements, LSI/related terms, density analysis

   > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the keyword optimization template (Step 6).

7. **Audit Internal Links** — Link count, anchor text relevance, broken links, recommended additions

   > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the internal linking template (Step 7).

8. **Audit Images** — Alt text, file names, sizes, formats, lazy loading

   > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the image optimization template (Step 8).

9. **Audit Technical On-Page Elements** — URL, canonical, mobile, speed, HTTPS, schema

   > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the technical on-page template (Step 9).

10. **CORE-EEAT Content Quality Quick Scan** — 17 on-page-relevant items from the 80-item CORE-EEAT benchmark. **An operator triage step, not a client report section**: its pass count never enters the /100 overall, its item IDs are the input to the escalation payload, and the scan therefore ships as an operator block whose label sits inside its own fence. The client sees these findings as Step 11 Priority Issues, in plain words.

    > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the CORE-EEAT quick scan template (Step 10). Full benchmark: [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md).

11. **Generate Audit Summary** — Overall score with visual breakdown, priority issues (critical/important/minor), quick wins, detailed recommendations, competitor comparison, action checklist, expected results

    > **Reference**: See [references/audit-templates.md](./references/audit-templates.md) for the full audit summary template (Step 11).

## Validation Checkpoints

### Input Validation
- [ ] Target keyword(s) clearly specified by user
- [ ] Page content accessible (either via URL or provided HTML)
- [ ] If competitor comparison requested, competitor URL provided

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] Scores based on measurable criteria, not subjective opinion
- [ ] Every section score is printed on its own maximum (Title /15, Meta /5, Headers /10, Content /25, Keywords /15, Links /10, Images /10, Technical /10) with its derivation — [awarded] ÷ [points scored] and the count of unverified criteria excluded; the Overall Score is the sum of the eight and recomputes from them; nothing measurable at all means no overall score in the report
- [ ] No unverified criterion is scored 0 or guessed; it is named unverified and left out of both the numerator and that section's maximum
- [ ] No ranking, CTR or traffic outcome is predicted as a number for this page — expected results are stated as what to re-measure and when, not as a forecast
- [ ] All suggested changes include specific locations (title tag, H2 #3, paragraph 5, etc.)
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Google Search Console, Ahrefs, Screaming Frog), "the HTML you provided", or "manual review"; where no tool was connected and nothing was supplied, the report says exactly that and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every finding carries a Confidence label (Confirmed / Likely / Hypothesis); Hypothesis findings name what would confirm them
- [ ] No quotation attributes words to a named person or organisation without a checkable source beside it; page quotes are verbatim from the audited HTML/content, and no Fix drafts an expert quote for the writer
- [ ] The Step 10 quick scan and the follow-up-run block are each their own fence carrying `<!-- OPERATOR BLOCK … -->` as the first line inside it, and no framework item ID or skill slug appears in the client report — a reader who copies only a fence must be able to tell who it is for
- [ ] Schema recommendations name **one primary type** for the page; no second content type is recommended or scored as extra credit, and FAQ credit rests on the visible on-page Q&A block rather than on FAQPage markup

## Example

> **Reference**: See [references/audit-example.md](./references/audit-example.md) for a full worked example (noise-cancelling headphones audit) and page-type checklists (blog post, product page, landing page).

## Tips for Success

1. **Prioritize issues by impact** - Fix critical issues first
2. **Compare to competitors** - See what's working for top rankings
3. **Balance optimization and readability** - Don't over-optimize
4. **Audit regularly** - Content degrades over time
5. **Test changes** - Track ranking changes after updates

> **Scoring details**: For the per-criterion point tables, the unverified-criterion rule, calibration examples, weight distribution, issue resolution playbook, and industry benchmarks, see [references/scoring-rubric.md](./references/scoring-rubric.md).

## Reference Materials

- [Scoring Rubric](./references/scoring-rubric.md) — Per-criterion points for all eight sections and their maxima, how ✅/⚠️/❌ becomes points, what an unverified criterion does to the denominator, the overall-score arithmetic and grade bands, plus calibration examples
- [Audit Templates](./references/audit-templates.md) — Detailed output templates for steps 5-11 (content quality, keywords, links, images, technical, CORE-EEAT scan, audit summary)
- [Audit Example & Checklists](./references/audit-example.md) — Full worked example and page-type checklists (blog, product, landing page)
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — what to pass when this audit names a follow-up run (step 10's escalation to the full 80-item audit is the standing one), the operator-block placement rule, and the drop-and-name rule for an unavailable field

## Related Skills

- [seo-content-writer](../../build/seo-content-writer/) — Create optimized content
- [technical-seo-checker](../technical-seo-checker/) — Technical SEO audit
- [meta-tags-optimizer](../../build/meta-tags-optimizer/) — Optimize meta tags
- [serp-analysis](../../research/serp-analysis/) — SERP context for audit findings
- [content-refresher](../content-refresher/) — Update existing content
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit
- [internal-linking-optimizer](../internal-linking-optimizer/) — Optimize internal link structure
- [schema-markup-generator](../../build/schema-markup-generator/) — Validate and generate schema markup

