---
name: content-quality-auditor
version: "4.7.0"
description: 'Run the full 80-item CORE-EEAT audit across 8 dimensions with content-type weighted scoring, veto checks, and prioritized fix plans. Use when the user asks to "audit content quality", "EEAT score", "CORE-EEAT audit", "content quality check", "how good is my content", "content improvement plan", "is my content AI-citation worthy", "GEO quality score". For SEO page element audits, see on-page-seo-auditor. For domain-level authority, see domain-authority-auditor.'
license: Apache-2.0
allowed-tools: WebFetch
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.7.0"
  geo-relevance: "high"
  tags:
    - seo
    - geo
    - e-e-a-t
    - helpful-content
    - content-quality
    - content-scoring
    - ai-quality
    - core-eeat
    - experience-expertise-authoritativeness-trust
    - helpful-content-update
  triggers:
    - "audit content quality"
    - "EEAT score"
    - "content quality check"
    - "CORE-EEAT audit"
    - "how good is my content"
    - "content assessment"
    - "quality score"
    - "is my content good enough to rank"
    - "EEAT check"
    - "rate my content quality"
---

# Content Quality Auditor

> Based on [CORE-EEAT Content Benchmark](https://github.com/aaron-he-zhu/core-eeat-content-benchmark). Full benchmark reference: [references/core-eeat-benchmark.md](../../references/core-eeat-benchmark.md)


This skill evaluates content quality across 80 standardized criteria organized in 8 dimensions. It produces a comprehensive audit report with per-item scoring, dimension and system scores, weighted totals by content type, and a prioritized action plan.

## When to Use This Skill

- Auditing content quality before publishing
- Evaluating existing content for improvement opportunities
- Benchmarking content against CORE-EEAT standards
- Comparing content quality against competitors
- Assessing both GEO readiness (AI citation potential) and SEO strength (source credibility)
- Running periodic content quality checks as part of a content maintenance program
- After writing or optimizing content with seo-content-writer or geo-content-optimizer

## What This Skill Does

1. **Full 80-Item Audit**: Scores every CORE-EEAT check item as Pass/Partial/Fail
2. **Dimension Scoring**: Calculates scores for all 8 dimensions (0-100 each)
3. **System Scoring**: Computes GEO Score (CORE) and SEO Score (EEAT)
4. **Weighted Totals**: Applies content-type-specific weights for final score
5. **Veto Detection**: Flags critical trust violations (T04, C01, R10) and applies the benchmark's veto scoring consequences (cap / BLOCK / no-score)
6. **Priority Ranking**: Identifies Top 5 improvements sorted by impact
7. **Action Plan**: Generates specific, actionable improvement steps

## How to Use

### Audit Content

```
Audit this content against CORE-EEAT: [content text or URL]
```

```
Run a content quality audit on [URL] as a [content type]
```

### Audit with Content Type

```
CORE-EEAT audit for this product review: [content]
```

```
Score this how-to guide against the 80-item benchmark: [content]
```

### Comparative Audit

```
Audit my content vs competitor: [your content] vs [competitor content]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~web crawler + ~~SEO tool connected:**
Automatically fetch page content, extract HTML structure, check schema markup, verify internal/external links, and pull competitor content for comparison.

**With manual data only:**
Ask the user to provide:
1. Content text, URL, or file path
2. Content type (if not auto-detectable): Product Review, How-to Guide, Comparison, Landing Page, Blog Post, FAQ Page, Alternative, Best-of, or Testimonial
3. Optional: competitor content for benchmarking

Proceed with the full 80-item audit using provided data. Note in the output which items could not be fully evaluated due to missing access (e.g., backlink data, schema markup, site-level signals).

## Instructions

When a user requests a content quality audit:

### Step 1: Preparation

```markdown
<!-- SKELETON — every [bracket] is a slot filled from the content you were given; a slot with no
     value means the line is dropped and the gap named in prose. Delete this line when filled. -->
### Audit Setup

**Content**: [title or URL]
**Content Type**: [auto-detected or user-specified]
**Dimension Weights**: [loaded from content-type weight table]

#### Veto Check (Emergency Brake)

| Veto Item | Status | Action |
|-----------|--------|--------|
| T04: Disclosure Statements | ✅ Pass / N/A (no material connection) / ⚠️ VETO | [If VETO: "Add human-readable disclosure where readers encounter the connection — immediately"] |
| C01: Intent Alignment | ✅ Pass / ⚠️ VETO | [If VETO: "Rewrite title and first paragraph"] |
| R10: Content Consistency | ✅ Pass / ⚠️ VETO | [If VETO: "Resolve the contradictory claims before publishing"] |
```

Veto semantics (benchmark Section 3): T04 is a **conditional veto** — assessed only when a material connection (sponsorship, ownership, compensated product, affiliate relationship) exists; with none, mark N/A and exclude from scoring, never Partial. R10's veto fires only on **material internal contradiction** (incompatible factual/numerical claims); isolated broken links, stale non-material references, and wording inconsistencies are remediable Partial-level findings, never veto.

By design, this emergency-brake table lists no Partial state: it screens only for veto-grade failures — Partial-grade findings on these same items (e.g., a present-but-buried disclosure) are scored normally in the full 80-item pass (Steps 2–3).

If any veto item triggers, flag it prominently at the top of the report and recommend immediate action before continuing the full audit. Scoring consequences (framework rules, benchmark Section 3): one verified veto failure caps the final overall score at 59, with the cap flagged in the report; two or more verified veto failures = BLOCK — show dimension scores but suppress the final score; if a veto item's evidence is missing or unassessable, issue no final score at all — never guess past a veto item.

### Step 2: CORE Audit (40 items)

Evaluate each item against the criteria in [references/core-eeat-benchmark.md](../../references/core-eeat-benchmark.md).

Score each item:
- **Pass** = 10 points (fully meets criteria)
- **Partial** = 5 points (partially meets criteria)
- **Fail** = 0 points (does not meet criteria)

**Confidence labels** — every Partial/Fail note carries one: **Confirmed** (directly observed in the provided content/data) · **Likely** (strong indirect evidence) · **Hypothesis** (plausible, needs verification — name the verification step). Pass and N/A notes may omit the label. This extends the library's `[VERIFY]` discipline into client deliverables: a guess presented as an observation is a defect.

```markdown
<!-- SKELETON — one dimension's shape. Repeat it per dimension, scoring every item; a slot
     with no grade behind it is not printed. Delete this comment when the table is filled. -->
### C — Contextual Clarity

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| C01 | Intent Alignment | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| C02 | Direct Answer | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |
| C10 | Semantic Closure | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |

[P] Pass · [Q] Partial · [F] Fail = [points] over [n] scored items → **C Score**: [X]/100
```

Count that tally line off the rows you just wrote, every time — never off the tally you expected to write. Where a tally line and its table disagree, **the table wins**: fix the line, then re-derive everything downstream of it (the dimension score, GEO, SEO, the weighted total, and the rating band beside the total). Repeat the same table format for **O** (Organization), **R** (Referenceability), and **E** (Exclusivity), scoring all 10 items per dimension.

### Step 3: EEAT Audit (40 items)

```markdown
<!-- SKELETON — one dimension's shape, as in Step 2. Delete this comment when filled. -->
### Exp — Experience

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| Exp01 | First-Person Narrative | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |

[P] Pass · [Q] Partial · [F] Fail = [points] over [n] scored items → **Exp Score**: [X]/100
```

Repeat the same table format for **Ept** (Expertise), **A** (Authority), and **T** (Trust), scoring all 10 items per dimension.

See [references/item-reference.md](./references/item-reference.md) for the complete 80-item ID lookup table and site-level item handling notes.

### Step 3b: Anti-Slop Scans (evidence for existing items)

Run four scans and record hits in the Notes column of the items they evidence — the scans add no new items and change no weights:

| Scan | Detects | Evidences (primary → secondary) |
|------|---------|--------------------------------|
| AS-1 Slop-vocabulary density | Tier-1/Tier-2 AI-tell vocabulary, EN + EL calques | O09 → Ept03 |
| AS-2 Structural patterns | uniform paragraph lengths, per-section summaries, rhetorical-question openers, padding lines | O06 → O09, C02 |
| AS-3 Per-section information gain | sentences that could sit on any competitor page; sections adding nothing beyond their heading | E06 → E08, O09 |
| AS-4 Specificity rungs | vague claims (rung 1) that provided data could have quantified (rung 2) or sourced (rung 3) | R01 → R04, R02 |

A text with Tier-1 vocabulary hits cannot honestly score O09 Pass ("no filler"). Scan procedures, EN + EL ban lists, thresholds, and per-scan confidence guidance: [references/anti-slop-audit-checks.md](./references/anti-slop-audit-checks.md).

### Step 4: Scoring & Report

Calculate scores and generate the final report. Every finding — each Partial/Fail note and each priority improvement — carries its confidence label (defined in Step 2); priority improvements use the Finding / Evidence / Impact / Fix structure:

**Every action is implementable.** A finding diagnoses; an action gets done. Every action this audit recommends — each **Fix** in the Top 5 and every Action Plan row — carries seven fields: **action** (one imperative sentence naming the artefact and the change), **owner**, **acceptance criterion** (labelled **Done when** in a per-action block and **Acceptance criterion** as a table column — one field, two labels, no third), **expected impact**, **effort**, **dependencies**, **risk if done wrong**. The **Fix** line *is* the action field and the **Impact** line *is* the expected-impact field, so an entry adds the other five rather than restating those two. Fields 1–3 are required — an action with no owner-role and no acceptance criterion does not ship as an action — and 4–7 take a stated-absence value (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`), never a blank and never an invention. **Owner is a role** from a closed list — Content · SEO/technical · Developer · Designer · Product/merchandising · Customer service · Legal/compliance · Agency · Client decision — never a person unless the client supplied the name; `Client decision` is a real owner and assigning it makes a decision visible instead of leaving the action stalled, and `unassigned — needs an owner` is legitimate and is itself a finding. **The acceptance-criterion test: could someone who was not part of this engagement check it six weeks from now, without asking anybody what was meant?** Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered — "the page carries a named author with a stated credential and a visible publication date, live on the production URL" rather than "author signals improved". **It never requires an engine to do something**: an appearance in a generated answer is nobody's to deliver, and writing it turns the action into a promise, so an AI-surface action is accepted on the work shipped plus the measurement re-run and recorded beside its dated baseline. Effort uses this report's own bands — Quick (<30 min) · Medium (1–2 h) · Strategic (needs planning) — and priority stays the existing weight × points-lost sort; no second vocabulary is invented beside either. Field table, stated-absence values, worked criteria and the permitted shapes of expected impact: [Action Output Contract](../../references/action-output-contract.md). A prohibited tactic found in the audited content is reported the same way — named, exposure stated, remediation owned and accepted, ranked against everything else: [Prohibited Tactics](../../references/prohibited-tactics.md) §2.

**Quote discipline** — R02 and R03 (citation density, source hierarchy) and the Ept/A items (Ept01 Author Identity, Ept02 Credentials Display, A06 Social Proof) are where this report asks for citations, credentials and expert quotes, and the count thresholds (≥1 citation per 500 words; ≥3 Tier 1–2 sources) are exactly the pressure that invents one. A quotation attributed to a named person or organisation needs a real, checkable source in the same breath: speaker, role, where and when they said it, and a link that opens. Without one, do not attribute it — paraphrase it unattributed, or drop it. This governs both quote surfaces below. The **Evidence** field quotes the audited content verbatim (copied from the content, never reconstructed). A **Fix** or Action Plan step tells the writer to *source* a quote — it never drafts one, and never invents a name, credential or institution to carry it (statistics rule: sourced, cited, or placeholder, never invented). A fabricated statistic is an unverifiable claim; a fabricated quotation is a false statement about an identifiable person, published under the client's byline.

#### N/A Item Handling

**Method, not report content** — it sits outside the report fence below because a model copies
the fence, so anything addressed to whoever runs the audit stays out of what the client is
handed. The report carries the outcome — the item, its reason, the denominator it was scored
against — never this procedure and never a bare item ID.

When an item cannot be evaluated (e.g. Backlink Profile, `CORE-EEAT-A01`, needs site-level data
you were not given):

1. Mark the item as "N/A" with reason
2. Exclude N/A items from the dimension score calculation
3. Dimension Score = (sum of scored items) / (number of scored items x 10) x 100
4. If more than 50% of a dimension's items are N/A, flag the dimension as "Insufficient Data" and exclude it from the weighted total
5. Recalculate weighted total using only dimensions with sufficient data, re-normalizing weights to sum to 100%

The worked case — an Authority dimension with 8 items N/A and 2 scored, the correct denominator against the wrong one, and what "Insufficient Data" then does to the weighted total — is in [references/score-arithmetic.md](./references/score-arithmetic.md) § 4.

**Attainable dimension scores — check before printing.** Every scored item earns 10, 5, or 0, so a dimension score is always an exact multiple of `50 / (number of scored items)` — a multiple of 5 over 10 scored items (0, 5, 10 … 100), of 10 over 5 scored items, of 25 over 2 (0, 25, 50, 75, 100). No value between two of those steps can be produced by any tally. The full step table for every scored-item count is in [references/score-arithmetic.md](./references/score-arithmetic.md) § 2. Reverse check on a printed score: `score x scored items / 50` must be a whole number, and that number equals (2 x Passes) + Partials. A dimension with 2 scored items printing 75 checks out — 75 x 2 / 50 = 3 = (2 x 1 Pass) + 1 Partial. A fractional result means the tally slipped: 65 over 2 scored items gives 2.6, so 65 is not a score this scale can produce. Rounding is the one legitimate exception (50 / scored items does not always give a terminating decimal — 9, 7, 6 and 3 scored items do not), and the full derivation, the same check for GEO/SEO and weighted figures, and the veto outcomes that sit outside the arithmetic are in [references/score-arithmetic.md](./references/score-arithmetic.md). **But both checks above are screens, and neither is the recount.** A miscounted tally is almost always itself a *possible* tally, so its score is attainable, the reverse check returns a whole number, and both screens pass it — 55.56 over 9 scored items is exactly what 4 Pass + 2 Partial gives, and says nothing about whether the table beneath it holds 4 Passes. **Step 4 is not finished until the pre-send recompute pass has been run against the finished report**, not against the working notes ([references/score-arithmetic.md](./references/score-arithmetic.md) § 7): every dimension score recounted off the Pass/Partial/Fail rows of its own item table; every tally line agreeing with the table it summarises; GEO and SEO each the mean of the four dimension scores as printed; the weighted total reproduced from the printed dimension scores and printed weights, with renormalised weights summing to 100%; and the rating beside the total being the band that the total, **rounded to a whole number half up**, falls in on the scale the report itself prints — with the computed total still printed beside it. Where a sentence and a table disagree, **the table wins** — fix the sentence, then re-derive everything downstream of it, because one dimension moving carries GEO, the weighted total and its rating band with it.

**Potential gain** = the dimension points an item recovers × that dimension's weight. Recovering an item is worth 10 dimension points only when the dimension has all ten items scored; with `n` scored items a Fail→Pass flip moves the dimension score by `100/n` and a Partial→Pass flip by `50/n`. **Show all three factors on the Impact line** — the 100 or 50, the scored-item count it is divided by, and the weight it is multiplied by — so the rescale is visible where the number is written. A dimension excluded as Insufficient Data has no gain to show at all: nothing inside it moves the weighted total, and the fix that pays there is supplying the missing data, not raising an item.

```markdown
<!-- SKELETON — the client's report. Every [bracket] is a slot: fill it from this audit's own
     tables, or drop the line and name the gap. No bracket, no "TBD", and nothing addressed to
     whoever ran the audit survives in what the client is handed. Delete this line when filled. -->
## Content Quality Audit

### Overview

- **Scored against**: CORE-EEAT — our 80-item content-quality benchmark: how clearly the page answers, how it is organised, how reliable and current it is, and the experience, expertise, authority and trust it shows
- **Content**: [title]
- **Content Type**: [type]
- **Audit Date**: [date]
- **Total Score**: [computed score, e.g. 39.80] → **[rounded score]/100** ([rating]) — the rating word is read off the rounded figure; the computed figure stays beside it
- **GEO Score**: [score]/100 | **SEO Score**: [score]/100
- **Veto Status**: ✅ No triggers / ⚠️ [item] triggered — final score capped at 59 / ⛔ BLOCK ([items]) — final score suppressed / ❓ [item] unassessable — no final score issued

### Dimension Scores

| Dimension | Score | Rating | Weight | Weighted |
|-----------|-------|--------|--------|----------|
| C — Contextual Clarity | [X]/100 | [rating] | [X]% | [X] |
| O — Organization | [X]/100 | [rating] | [X]% | [X] |
| R — Referenceability | [X]/100 | [rating] | [X]% | [X] |
| E — Exclusivity | [X]/100 | [rating] | [X]% | [X] |
| Exp — Experience | [X]/100 | [rating] | [X]% | [X] |
| Ept — Expertise | [X]/100 | [rating] | [X]% | [X] |
| A — Authority | [X]/100 | [rating] | [X]% | [X] |
| T — Trust | [X]/100 | [rating] | [X]% | [X] |
| **Weighted Total** | | | | **[X]/100** |

**Score Calculation**:
- Dimension score = points earned ÷ (10 × scored items) × 100, counted from that dimension's own rows above
- GEO Score = (C + O + R + E) / 4
- SEO Score = (Exp + Ept + A + T) / 4
- Weighted Score = Σ (dimension_score × content_type_weight)
- Rating band = the score **rounded to a whole number, half up**. The band endpoints are whole numbers and a weighted mean is not, so the rounding is what puts every possible score in exactly one band: 39.80 → 40, Low

**Rating Scale**: 90-100 Excellent | 75-89 Good | 60-74 Medium | 40-59 Low | 0-39 Poor — read off the rounded score, with the computed score shown beside it

**Items not evaluated**: named in the per-item tables with their reason, excluded from that dimension's denominator rather than scored zero; a dimension with more than half its items unevaluated is reported as Insufficient Data instead of carrying a score.

### Per-Item Scores

#### CORE — Content Body (40 Items)

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| C01 | Intent Alignment | [Pass/Partial/Fail] | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| C02 | Direct Answer | [Pass/Partial/Fail] | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |

#### EEAT — Source Credibility (40 Items)

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| Exp01 | First-Person Narrative | [Pass/Partial/Fail] | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |

### Top 5 Priority Improvements

Sorted by: weight × points lost (highest impact first), with dependencies respected — an entry whose dependency is unmet sits below the thing it waits on. Every entry carries all four parts plus its confidence label — **Confirmed** (directly observed in the provided content/data) · **Likely** (strong indirect evidence) · **Hypothesis** (plausible, needs verification) — and the five implementation fields beneath them.

1. **[Name]** — [Confirmed / Likely / Hypothesis]
   - **Finding**: [what is wrong, one sentence]
   - **Evidence**: [verbatim quote or measurement from the content; for Likely/Hypothesis, the indirect signal plus the step that would confirm it]
   - **Impact**: [Fail/Partial] → [100 for a Fail, 50 for a Partial] ÷ [that dimension's scored-item count] × [that dimension's weight] = potential gain of [X] weighted points
   - **Fix**: [one imperative sentence naming the artefact and the change]
   - **Owner**: [role] · **Effort**: [Quick / Medium / Strategic] · **Depends on**: [named blocker, or "none"]
   - **Done when**: [observable, binary, attached to a named artefact or measurement, dated or triggered]
   - **Risk if done wrong**: [realistic failure mode and its cost, or "low — reversible, no downstream effect"]

2–5. [Same format]

### Action Plan

Every action this audit recommends, in one place, ordered by weighted gain ÷ effort with dependencies respected. Effort bands: Quick (<30 min) · Medium (1–2 h) · Strategic (needs planning). A field with no answer carries its stated-absence value, never a blank.

| # | Action | Owner | Acceptance criterion | Expected gain | Effort | Depends on | Risk if done wrong |
|---|--------|-------|----------------------|---------------|--------|------------|--------------------|
| 1 | [imperative sentence naming the artefact and the change] | [role, or "unassigned — needs an owner"] | [observable, binary, dated or triggered — checkable by someone who was not part of this audit] | [weighted points, from the tables above, or "not estimated — no baseline data"] | [band] | [named blocker, or "none"] | [failure mode and cost, or "low — reversible, no downstream effect"] |
| 2 | [next action] | … | … | … | … | … | … |
```

The client's report ends there. Follow-up runs go in a **separate fence of their own**, carrying **two labels**: the in-fence comment, because a model copies the fence and not the heading above it, and a visible line the client actually sees, because an HTML comment renders to nothing in the delivered report (`CLAUDE.md` § The Reader Test, clause 2; the handoff sub-rule is [inter-skill-handoff.md § 3.1](../../references/inter-skill-handoff.md)). Payload fields, the hyphenated framework-first ID form, and the drop-and-name rule for a field you cannot source are all in that file.

```markdown
<!-- OPERATOR BLOCK — for the client's team, not part of the report above. Every row names a
     library run and carries its payload. Nothing in this fence goes to the client as written. -->
**Next steps for your team** — *operator block; not part of the client report*

| Run | Why | Payload |
|-----|-----|---------|
| `seo-content-writer` | Full rewrite against CORE-EEAT constraints | [keyword] · [content type] · [URL] · `CORE-EEAT C:… O:… R:… E:… Exp:… Ept:… A:… T:…` · vetoes · audited [date] |
| `geo-content-optimizer` | Targets the failed GEO-First items | Same payload, priority `CORE-EEAT-[ID], …` |
| `content-refresher` | Refreshes against the weak dimensions | Same payload, weak dimensions as the focus set |
| `/seo:check-technical` | Site-level issues a page-level audit cannot see | [domain] |
```

Drop any row whose run this audit did not actually motivate; a standing list of four is not a handoff. When a payload field cannot be sourced, the field is omitted from the row and named beneath the block — never a bracket token left in a value position.

## Validation Checkpoints

### Input Validation
- [ ] Content source identified (text, URL, or file path)
- [ ] Content type confirmed (auto-detected or user-specified)
- [ ] Content is substantial enough for meaningful audit (≥300 words)
- [ ] If comparative audit, competitor content also provided

### Output Validation
- [ ] All 80 items scored (or marked N/A with reason)
- [ ] **Pre-send recompute pass run against the finished report** (Step 4; § 7 of the score-arithmetic reference): every one of the 8 dimension scores recounted off the Pass/Partial/Fail rows of its own item table, and every tally line agreeing with the table it summarises. **The attainable-value screen does not stand in for this recount** — each score is also an exact multiple of 50 / scored items (see N/A Item Handling), but a miscounted tally is usually itself a possible tally, so it clears that screen and only the recount catches it
- [ ] Weighted total matches content-type weight configuration and reproduces from the printed dimension scores and printed weights (renormalised weights sum to 100%); GEO and SEO are each the mean of the four dimension scores as printed; the rating beside the total is the band that total falls in on the scale the report prints. The published bands have whole-number endpoints and a weighted mean is not a whole number, so **the band is read off the total rounded to a whole number, half up** — 39.80 reads 40, Low. Both figures are printed: the computed total with its derivation, at enough precision that a reader can see which side of the boundary it fell on and reproduce the rounding, and the rounded total carrying the rating word. Rounding is a reading step for the band only and never replaces the computed figure
- [ ] Every prose statement of how many items were not evaluated, and why, matches the N/A rows in the tables it describes — a count and a reason, never a list of item IDs
- [ ] Veto items checked and flagged if triggered; consequence applied (one veto = cap at 59, two+ = BLOCK, unassessable = no final score); T04 marked N/A when no material connection exists. **Round first, then cap, and read the band off the same rounded figure**: a vetoed 59.6 rounds to 60, which is above the cap, so the reported score is 59, Low — a vetoed report printing 60/Medium has breached the cap however it got there
- [ ] Top 5 improvements sorted by weighted impact, not arbitrary, and every potential gain shows all three factors and recomputes from them — `100/n` for a Fail→Pass or `50/n` for a Partial→Pass, where `n` is that dimension's scored-item count, × that dimension's weight; a combined claim equals the sum of the gains it aggregates, and a dimension excluded as Insufficient Data carries no gain at all
- [ ] Every recommendation is specific and actionable (not generic advice)
- [ ] Action plan includes concrete steps with effort estimates
- [ ] Every recommended action — each Top 5 entry and every Action Plan row — carries all seven fields (action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong), with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); no action ships without an owner-role and an acceptance criterion, the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding), and where an action appears in both views its fields say the same thing
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — checkable by someone who was not part of this engagement, six weeks on, without asking what was meant. **None of them requires an engine to do something**: an AI-surface action is accepted on the work shipped plus the measurement re-run and recorded beside its dated baseline, never on an appearance in a generated answer. The ordering rule is stated once, and the existing weight × points-lost sort and the Quick/Medium/Strategic effort bands are the only priority and effort vocabularies used
- [ ] Every Partial/Fail note and every priority improvement carries a confidence label (Confirmed / Likely / Hypothesis); each Hypothesis names its verification step
- [ ] No quotation in the report attributes words to a named person or organisation without a checkable source beside it; Evidence quotes are verbatim from the audited content, and no Fix or Action Plan step drafts a quote in a real person's name
- [ ] Anti-slop scans (AS-1 to AS-4) run, with hits recorded in the evidenced items' notes (O09, O06, C02, E06, E08, R01, R02, R04, Ept03)
- [ ] The client report fence carries its own label as its FIRST line — `<!-- SKELETON … -->` while slots are unfilled, `<!-- ILLUSTRATIVE FILL … -->` once demo numbers are in — and the follow-up-run block is a separate fence carrying **both** labels: `<!-- OPERATOR BLOCK … -->` as its first line **and** a visible `**Next steps for your team** — *operator block; not part of the client report*` line directly under it. Both, because a comment alone renders to nothing in the delivered report and a heading alone is lost when a model copies the fence; **no skill slug or command slug appears anywhere inside the client report fence**, and **no framework item ID appears in the client-facing prose** — a reader who copies only that fence must be able to tell it is not for the client. **The scored per-item table keeps its ID column** (ruled 2026-08-13): there the ID is a row label sitting beside the item's plain-language name, so the client reads "Intent Alignment" and the ID is only a stable handle for the row. In prose the ID *is* the referent — "Items R02 and R03 failed" tells a client nothing — and that is the form the rule bans. **A bare list of IDs inside a cell does not qualify either**: "C02, C03 Pass; C01 Partial" is the referent form wearing a table's clothes, because no plain-language name sits against any of them. The earlier fence-wide wording was unsatisfiable: the checkbox above it requires every item scored, and the per-item table is the instrument the client bought.

## Example

See [references/item-reference.md](./references/item-reference.md) for a complete scored example showing the C dimension with all 10 items, priority improvements, and weighted scoring.

## Tips for Success

1. **Start with veto items** — T04 (conditional: only when a material connection exists), C01, and R10 override the arithmetic: one verified veto failure caps the final score at 59, two or more = BLOCK (no final score), unassessable veto evidence = no score issued
   > These veto items and their scoring consequences follow the CORE-EEAT benchmark (Section 3), which defines them as framework rules that override the overall score.
2. **Focus on high-weight dimensions** — Different content types prioritize different dimensions
3. **GEO-First items are this library's do-first order when AI citation is the goal** — Prioritize items tagged GEO 🎯. That order is the library's judgement (benchmark §4), not documented engine behaviour; each item's reason states what it puts on the page, checkable by opening it
4. **Some EEAT items need site-level data** — Don't penalize content for things only observable at the site level (backlinks, brand recognition)
5. **Use the weighted score, not just the raw average** — A product review with strong Exclusivity matters more than strong Authority
6. **Re-audit after improvements** — Run again to verify score improvements and catch regressions
7. **Pair with CITE for domain-level context** — A high content score on a low-authority domain signals a different priority than the reverse; run [domain-authority-auditor](../domain-authority-auditor/) for the full 120-item picture
8. **Label your confidence honestly** — Confirmed beats Likely beats Hypothesis; a Hypothesis finding without a named verification step is not deliverable
9. **Slop hits are evidence, not a verdict** — record AS-scan hits with verbatim quotes in the evidenced items' notes; the benchmark criteria still decide each score

## Reference Materials

- [CORE-EEAT Content Benchmark](../../references/core-eeat-benchmark.md) — Full 80-item benchmark with dimension definitions, scoring criteria, and GEO-First item markers
- [references/item-reference.md](./references/item-reference.md) — All 80 item IDs in a compact lookup table + site-level item handling notes + scored example report
- [references/anti-slop-audit-checks.md](./references/anti-slop-audit-checks.md) — AS-1 to AS-4 scan procedures, EN + EL ban lists, thresholds, and item mappings (O09, O06, C02, E06, E08, R01, R02, R04, Ept03)
- [references/score-arithmetic.md](./references/score-arithmetic.md) — which dimension, GEO/SEO and weighted figures the 10/5/0 scale can produce, the N/A denominator, rounding, and the veto outcomes that override the arithmetic
- [Action Output Contract](../../references/action-output-contract.md) — the seven fields every recommended action carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule
- [Prohibited Tactics](../../references/prohibited-tactics.md) — what an action may never be, and §2 for how an existing instance found in the audited content is named, costed, remediated, owned and ranked
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — the payload every follow-up-run row passes to the run it names, the label-inside-the-fence rule for an operator block, the hyphenated framework-first item-ID form, and the drop-and-name rule for an unavailable field

## Related Skills

- [domain-authority-auditor](../domain-authority-auditor/) — Domain-level CITE audit (40 items) — the sister skill for full 120-item assessment
- [seo-content-writer](../../build/seo-content-writer/) — Write content that scores high on CORE dimensions
- [geo-content-optimizer](../../build/geo-content-optimizer/) — Optimize for GEO-First items
- [content-refresher](../../optimize/content-refresher/) — Update content to improve weak dimensions
- [on-page-seo-auditor](../../optimize/on-page-seo-auditor/) — Technical on-page audit (complements this skill)
