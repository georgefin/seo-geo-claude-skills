---
name: domain-authority-auditor
version: "4.5.1"
description: 'Run the full 40-item CITE domain authority audit across 4 dimensions with domain-type weighting and veto checks. Use when the user asks to "audit domain authority", "domain trust score", "CITE audit", "how authoritative is my site", "domain credibility check", "is my domain trustworthy", "domain credibility score", "domain rating". For content-level assessment, see content-quality-auditor. For link profile details, see backlink-analyzer.'
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
    - domain audit
    - credibility
    - domain scoring
    - domain-authority
    - domain-rating
    - domain-trust
    - trust-signals
    - site-authority
    - da-checker
    - ahrefs-dr
    - moz-da
    - cite-framework
    - domain-strength
  triggers:
    - "audit domain authority"
    - "domain trust score"
    - "CITE audit"
    - "how authoritative is my site"
    - "domain credibility check"
    - "domain rating"
    - "site authority"
    - "is my domain trustworthy"
    - "domain credibility score"
---

# Domain Authority Auditor

> Based on [CITE Domain Rating](https://github.com/aaron-he-zhu/cite-domain-rating). Full benchmark reference: [references/cite-domain-rating.md](../../references/cite-domain-rating.md)

This skill evaluates domain authority across 40 standardized criteria organized in 4 dimensions. It produces a comprehensive audit report with per-item scoring, dimension and weighted scores by domain type, veto item checks, and a prioritized action plan.

**Sister skill**: [content-quality-auditor](../content-quality-auditor/) evaluates content at the page level (80 items). This skill evaluates the domain behind the content (40 items). Together they provide a complete 120-item assessment.

> **Namespace note**: CITE uses C01-C10 for Citation items; CORE-EEAT uses C01-C10 for Contextual Clarity items — and the two frameworks also share E and T. Every item ID carries its own hyphenated framework-first prefix, in a combined 120-item assessment and in any handoff payload alike: `CITE-C01` vs `CORE-EEAT-C01`, `CITE-T09`, `CORE-EEAT-R02`. One form, one prefix per framework — see [inter-skill-handoff.md § 2.3](../../references/inter-skill-handoff.md).

## When to Use This Skill

- Evaluating domain authority before a GEO campaign
- Benchmarking your domain against competitors
- Assessing whether a domain is trustworthy as a citation source
- Running periodic domain health checks or after link building campaigns
- Identifying manipulation red flags (PBNs, link farms, penalty history)
- Cross-referencing with content-quality-auditor for full 120-item assessment

## What This Skill Does

1. **Full 40-Item Audit**: Scores every CITE check item as Pass/Partial/Fail
2. **Dimension Scoring**: Calculates scores for all 4 dimensions (0-100 each)
3. **Weighted Totals**: Applies domain-type-specific weights for CITE Score
4. **Veto Detection**: Flags critical manipulation signals (T03, T05, T09)
5. **Priority Ranking**: Identifies Top 5 improvements sorted by impact
6. **Action Plan**: Generates specific, actionable improvement steps
7. **Cross-Reference**: Optionally pairs with CORE-EEAT for combined diagnosis

## How to Use

```
Audit domain authority for [domain]
Run a CITE domain audit on [domain] as a [domain type]
CITE audit for example.com as an e-commerce site
Score this SaaS domain against the 40-item benchmark: [domain]
Compare domain authority: [your domain] vs [competitor 1] vs [competitor 2]
Run full 120-item assessment on [domain]: CITE domain audit + CORE-EEAT content audit on [sample pages]
```

Lines 1–2 audit a single domain (type auto-detected or stated), 3–4 pin the domain type explicitly, 5 runs the comparative audit, 6 pairs this with the content audit for the full 120 items.

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

**With ~~link database + ~~SEO tool + ~~AI monitor + ~~knowledge graph + ~~brand monitor connected:**
Automatically pull backlink profiles and link quality metrics from ~~link database, domain authority scores and keyword rankings from ~~SEO tool, AI citation data from ~~AI monitor, entity presence from ~~knowledge graph, and brand mention data from ~~brand monitor.

**With manual data only:**
Ask the user to provide:
1. Domain to evaluate
2. Domain type (if not auto-detectable): Content Publisher, Product & Service, E-commerce, Community & UGC, Tool & Utility, or Authority & Institutional
3. Backlink data: referring domains count, domain authority, top linking domains
4. Traffic estimates (from any SEO tool or SimilarWeb)
5. Competitor domains for comparison (optional)

Proceed with the full 40-item audit using provided data. Note in the output which items could not be fully evaluated due to missing access (e.g., AI citation data, knowledge graph queries, WHOIS history).

## Instructions

When a user requests a domain authority audit:

### Finding Format & Confidence Labels

Findings surface in two places — per-item **Notes** and the **Top 5 Priority
Improvements**. Report each with **Finding** (the item and what falls short), **Evidence**
(the observed data behind the score), **Impact** (weighted points at stake), and **Fix**
(the concrete action), plus a **Confidence** label:

- **Confirmed** — directly observed in provided data or crawl output
- **Likely** — strong indirect evidence (e.g., a consistent pattern across sampled pages or tool exports)
- **Hypothesis** — plausible but needs verification (e.g., anything inferred without crawl/tool access)

**Rule**: every Hypothesis finding must name what would confirm it (the specific tool,
query, or data source). Items that cannot be evaluated at all stay "N/A — requires [data
source]" (see Step 3) — do not downgrade them into Hypothesis scores.

### Step 1: Preparation

```markdown
<!-- SKELETON — every [bracket] is a slot filled from the domain and data you were given; a
     slot with no value means the line is dropped and the gap named in prose. Delete this
     comment when the block is filled. -->
### Audit Setup

**Domain**: [domain]
**Domain Type**: [auto-detected or user-specified]
**Dimension Weights**: [from domain-type weight table below]

#### Domain-Type Weight Table

> **Read the weights from [`references/cite-domain-rating.md`](../../references/cite-domain-rating.md) § domain-type weights.** The inline copy that stood here was labelled "for convenience" and was a second place for the same numbers to drift — the defect class this library has already paid for twice. One source, traversed.

#### Veto Check (Emergency Brake)

| Veto Item | Status | Action |
|-----------|--------|--------|
| T03: Link-Traffic Coherence | ✅ Pass / ⚠️ VETO | [If VETO: "Audit backlink profile; disavow toxic links"] |
| T05: Backlink Profile Uniqueness | ✅ Pass / ⚠️ VETO | [If VETO: "Flag as manipulation network; investigate link sources"] |
| T09: Penalty & Deindex History | ✅ Pass / ⚠️ VETO | [If VETO: "Address penalty first; all other optimization is futile"] |
```

If any veto item triggers, flag it at the top of the report; CITE Score caps at 39 (Poor) regardless of other scores.

### Step 2: C + I Audit (20 items)

Evaluate each item against the criteria in [references/cite-domain-rating.md](../../references/cite-domain-rating.md).

Score each item:
- **Pass** = 10 points (fully meets criteria)
- **Partial** = 5 points (partially meets criteria)
- **Fail** = 0 points (does not meet criteria)

**A dimension score is the sum of that dimension's ten item points** — so with all ten items
scored it is always a multiple of 5 (N/A items rescale it; see Step 3). Publish the tally
beside the score so a reader can check it. If tally and score disagree, the item table is
right and the sentence is wrong: recount before publishing.

```markdown
<!-- SKELETON — one dimension's shape. Repeat it per dimension, scoring every item; a slot
     with no grade behind it is not printed. Delete this comment when the tables are filled. -->
### C — Citation

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| C01 | Referring Domains Volume | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| C02 | Referring Domains Quality | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |
| C10 | Link Source Diversity | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |

**C Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)

### I — Identity

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| I01 | Knowledge Graph Presence | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |

**I Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)
```

### Step 3: T + E Audit (20 items)

Same format for Trust and Eminence dimensions.

```markdown
<!-- SKELETON — one dimension's shape, as in Step 2. Delete this comment when filled. -->
### T — Trust

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| T01 | Link Profile Naturalness | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |

**T Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)

### E — Eminence

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| E01 | Organic Search Visibility | Pass/Partial/Fail | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |

**E Score**: [X]/100 — [p] Pass + [q] Partial + [r] Fail = [p]×10 + [q]×5 (p + q + r = 10)
```

**Note**: Some items require specialized data (C05-C08 AI citation data, I01 knowledge graph queries, T04-T05 IP/profile analysis). Score what is observable; mark unverifiable items as "N/A — requires [data source]" and exclude them from the dimension average. Excluded means the denominator shrinks, never that the item scores 0: **dimension score = points earned ÷ (10 × scored items) × 100**. State the denominator beside the score — `C Score: 58/100 — 35 pts over 6 scored items; C05-C08 N/A`. **The shrunken denominator rescales that dimension's potential gains too** (Step 4, rule 4), not just its score. Worked N/A cases: [references/score-arithmetic.md](./references/score-arithmetic.md).

**Greek e-commerce domains**: apply the supplementary trust/staleness checks in [references/greek-eshop-compliance.md](./references/greek-eshop-compliance.md) when scoring T06, T08, and T10 (stale ODR link, ΓΕΜΗ/ΑΦΜ and entity transparency, withdrawal/returns and policy furniture). These are audit signals only — never legal advice; compliance conclusions go to the client's lawyer.

### Step 4: Scoring & Report

**Derived figures — recompute every one before you publish.** Any number not copied from the
input is derived from the report's own per-item grades and stated weights: dimension scores,
the weighted CITE Score, item tallies, points-scored/points-lost sums, Top 5 potential gains,
and any "what the score would be if X" projection. Five rules carry most of the defects:

1. **A count matches the list it names** — "the four C Partials (C04, C05, C06, C07, C09)"
   is wrong: five IDs, called four. Count the IDs you just typed.
2. **A total equals its parts** — points scored + points lost = points available; a combined gain
   claim equals the sum of the gains it aggregates; a projected range equals the difference of its own endpoints.
3. **The tables win** — if a sentence disagrees with the table above it, fix the sentence.
4. **A gain is a score movement, so compute it the way the score is computed** — recoverable
   points × (10 ÷ that dimension's **scored-item count**) × *that item's own dimension* weight.
   The middle factor is 1 only where all ten of that dimension's items are scored; where N/A
   shrank the count it is not, and leaving it out understates every gain in that dimension — 40%
   at six scored items. An N/A item has no gain at all: it is projected, not priced.
5. **The item ID selects the weight** — the dimension letter in the ID is what picks it. Check
   the ID and its name against `references/cite-domain-rating.md` § 2 before multiplying:
   freshness is `T08` (Trust), not `E04` (Technical Crawlability), and those two weights differ,
   so a mis-attributed item prices the fix wrongly even when the grade behind it is right.

Formulas, N/A rescaling, veto-cap handling, and worked gain/projection examples (both a full and a rescaled dimension): [references/score-arithmetic.md](./references/score-arithmetic.md).

**Every action is implementable.** A finding diagnoses; an action gets done. Every action this audit recommends — each Top 5 entry and every Action Plan row — carries seven fields: **action** (one imperative sentence naming the artefact and the change), **owner**, **acceptance criterion** (labelled **Done when** in a per-action block and **Acceptance criterion** as a table column — one field, two labels, no third), **expected impact**, **effort**, **dependencies**, **risk if done wrong**. The **Action** line *is* the action field and the **Potential gain** line *is* the expected-impact field, so an entry adds the other five rather than restating those two. Fields 1–3 are required — an action with no owner-role and no acceptance criterion does not ship as an action — and 4–7 take a stated-absence value (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`), never a blank and never an invention. **Owner is a role** from a closed list — Content · SEO/technical · Developer · Designer · Product/merchandising · Customer service · Legal/compliance · Agency · Client decision — never a person unless the client supplied the name; `Client decision` is a real owner and assigning it makes a decision visible instead of leaving the action stalled, and `unassigned — needs an owner` is legitimate and is itself a finding. **The acceptance-criterion test: could someone who was not part of this engagement check it six weeks from now, without asking anybody what was meant?** Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered — "the entity record exists with website, industry and inception properties, each carrying a source" rather than "knowledge graph sorted". **It never requires an engine to do something**: an appearance in a generated answer, a knowledge panel or a citation is nobody's to deliver, and writing it turns the action into a promise, so an AI-surface action is accepted on the work shipped plus the measurement re-run and recorded beside its dated baseline. Effort uses this report's own bands — Quick (<1 week) · Medium (1–4 weeks) · Strategic (1–3 months) — and priority stays the existing weight × points-lost sort; no second vocabulary is invented beside either. Field table, stated-absence values, worked criteria and the permitted shapes of expected impact: [Action Output Contract](../../references/action-output-contract.md). A prohibited tactic found in the audited setup — a bought-link pattern, a duplicate microsite, review gating — is reported the same way and never left quietly in place: named, exposure stated, remediation owned and accepted, ranked against everything else, with any recommendation that depended on it withdrawn. This skill never removes or alters a client's live property on its own initiative: it reports and proposes, the client decides. [Prohibited Tactics](../../references/prohibited-tactics.md) §2.

Calculate scores and generate the final report:

```markdown
<!-- SKELETON — the client's report. Every [bracket] is a slot: fill it from this audit's own
     tables, or drop the line and name the gap. No bracket, no "TBD", and nothing addressed to
     whoever ran the audit survives in what the client is handed. Delete this line when filled. -->
## Domain Authority Audit

*Scored against CITE — our 40-item domain-authority benchmark, covering citations and links, the domain's identity signals, its trust signals, and its expertise footprint.*

### Overview

- **Domain**: [domain]
- **Domain Type**: [type]
- **Audit Date**: [date]
- **CITE Score**: [score]/100 ([rating])
- **Veto Status**: ✅ No triggers / ⚠️ [item] triggered — Score capped at 39

### Dimension Scores

| Dimension | Score | Items (Pass/Partial/Fail) | Rating | Weight | Weighted |
|-----------|-------|:-------------------------:|--------|--------|----------|
| C — Citation | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| I — Identity | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| T — Trust | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| E — Eminence | [X]/100 | [p]/[q]/[r] | [rating] | [X]% | [X] |
| **CITE Score** | | | | | **[X]/100** |

**Score Calculation**: CITE Score = C × [w_C] + I × [w_I] + T × [w_T] + E × [w_E] = [each product] = [unrounded sum] → **[rounded]/100** (one decimal, half up; the rating label follows the rounded number)

**Rating Scale**: 90-100 Excellent | 75-89 Good | 60-74 Medium | 40-59 Low | 0-39 Poor

### Per-Item Scores

| ID | Check Item | Score | Notes |
|----|-----------|-------|-------|
| C01 | Referring Domains Volume | [Pass/Partial/Fail] | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| C02 | Referring Domains Quality | [Pass/Partial/Fail] | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |
| ... | ... | ... | ... |
| E10 | Industry Share of Voice | [Pass/Partial/Fail] | [observation — on Partial/Fail add Confirmed/Likely/Hypothesis; a Hypothesis names its check] |

### Top 5 Priority Improvements

Sorted by: weight × points lost (highest impact first), with dependencies respected — an entry whose dependency is unmet sits below the thing it waits on. Potential gain = recoverable points (10 from Fail, 5 from Partial) × (10 ÷ that dimension's scored-item count) × that dimension's weight — show all three factors. The middle factor is 1 only where all ten of that dimension's items are scored; where N/A shrank the count it is not.

1. **[Name]** — [specific modification suggestion]
   - Current: [Fail/Partial] | Potential gain: [10 or 5] × (10 ÷ [scored items in that dimension] scored) × [dim weight] = [X] weighted points
   - Evidence: [observed data behind the score] | Confidence: [Confirmed/Likely/Hypothesis — if Hypothesis, name what would confirm it]
   - Action: [one imperative sentence naming the artefact and the change]
   - Owner: [role] | Effort: [Quick / Medium / Strategic] | Depends on: [named blocker, or "none"]
   - Done when: [observable, binary, attached to a named artefact or measurement, dated or triggered]
   - Risk if done wrong: [realistic failure mode and its cost, or "low — reversible, no downstream effect"]
2–5. [Same format]

### Action Plan

Every action this audit recommends, in one place, ordered by weighted gain ÷ effort with dependencies respected. Effort bands: Quick (<1 week) · Medium (1–4 weeks) · Strategic (1–3 months). A field with no answer carries its stated-absence value, never a blank.

| # | Action | Owner | Acceptance criterion | Expected gain | Effort | Depends on | Risk if done wrong |
|---|--------|-------|----------------------|---------------|--------|------------|--------------------|
| 1 | [imperative sentence naming the artefact and the change] | [role, or "unassigned — needs an owner"] | [observable, binary, dated or triggered — checkable by someone who was not part of this audit] | [weighted points, from the tables above, or "not estimated — no baseline data"] | [band] | [named blocker, or "none"] | [failure mode and cost, or "low — reversible, no downstream effect"] |
| 2 | [next action] | … | … | … | … | … | … |

### Cross-Reference with CORE-EEAT

For a complete assessment, pair this CITE audit with a CORE-EEAT content audit:

| Assessment | Score | Rating |
|-----------|-------|--------|
| CITE (Domain) | [X]/100 | [rating] |
| CORE-EEAT (Content) | [X]/100 — or "Not yet evaluated" where no content audit has been run | [rating] |

**Diagnosis Matrix**:
- High CITE + High CORE-EEAT → Maintain and expand
- High CITE + Low CORE-EEAT → Prioritize content quality
- Low CITE + High CORE-EEAT → Build domain authority
- Low CITE + Low CORE-EEAT → Start with content, then domain
```

The client's report ends there. Follow-up runs go in a **separate fence of their own**, carrying **two labels** — the in-fence comment, because a model copies the fence and not the heading above it, and a visible line the client actually sees, because an HTML comment renders to nothing in the delivered report (`CLAUDE.md` § The Reader Test, clause 2):

```markdown
<!-- OPERATOR BLOCK — for the client's team, not part of the report above. Every row names a
     library run and carries its payload. Nothing in this fence goes to the client as written. -->
**Next steps for your team** — *operator block; not part of the client report*

| Run | Why | Payload |
|-----|-----|---------|
| `content-quality-auditor` | Page-level content quality the domain audit cannot see | [domain] · [domain type] · [key page URLs] · `CITE C:… I:… T:… E:…` · vetoes · audited [date] |
| `backlink-analyzer` | Deep-dive on the referring-domain profile behind the I score | Same payload, priority `CITE-[ID], …` |
| `competitor-analysis` | Benchmarks the domain against the named competitor set | Same payload, competitor domains |
```

Drop any row whose run this audit did not actually motivate; a standing list of four is not a handoff. A payload field that cannot be sourced is omitted and named beneath the block — never a bracket token in a value position. **This block ships here, not one file over**: it lived only in [references/example-report.md](./references/example-report.md) while the checkbox below required the labelled fence — a rule stated where the writer reads it, and a template giving it nowhere to land. Payload fields, the hyphenated framework-first ID form and the drop-and-name rule: [inter-skill-handoff.md § 2–3](../../references/inter-skill-handoff.md).

## Validation Checkpoints

### Input Validation
- [ ] Domain identified and accessible
- [ ] Domain type confirmed (auto-detected or user-specified)
- [ ] Backlink data available (at minimum: referring domains count, DA/DR)
- [ ] If comparative audit, competitor domains also specified

### Output Validation
- [ ] All 40 items scored (or marked N/A with reason)
- [ ] All 4 dimension scores calculated correctly — each equals its own item tally (N/A items rescale the denominator, they never score 0)
- [ ] Weighted CITE Score matches domain-type weight configuration, shown unrounded then rounded
- [ ] Every other derived figure (item tallies, points-lost sums, potential gains, projections) recomputes from the report's own tables, and every stated count matches the number of items it enumerates — a gain carries the same `10 ÷ scored items` rescale its dimension score carries, so one method computes both and never two
- [ ] All 3 veto items checked first and flagged if triggered
- [ ] Top 5 improvements sorted by weighted impact, not arbitrary
- [ ] Every recommendation is specific and actionable (not generic advice)
- [ ] Every finding carries a Confidence label (Confirmed / Likely / Hypothesis); Hypothesis findings name what would confirm them
- [ ] Action plan includes concrete steps with effort estimates
- [ ] Every recommended action — each Top 5 entry and every Action Plan row — carries all seven fields (action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong), with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); no action ships without an owner-role and an acceptance criterion, the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding), and where an action appears in both views its fields say the same thing
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — checkable by someone who was not part of this engagement, six weeks on, without asking what was meant. **None of them requires an engine to do something**: an appearance in a generated answer, a knowledge panel or a citation is never the criterion, and an AI-surface action is accepted on the work shipped plus the measurement re-run and recorded beside its dated baseline. The ordering rule is stated once, and the existing weight × points-lost sort and the Quick/Medium/Strategic effort bands are the only priority and effort vocabularies used
- [ ] Any prohibited tactic found in the audited setup is named plainly, its exposure stated, its remediation given with an owner and an acceptance criterion, and ranked against everything else — never quietly left in place, never built on, and never removed or altered on this skill's own initiative
- [ ] The client report fence carries its own label as its FIRST line — `<!-- SKELETON … -->` while slots are unfilled, `<!-- ILLUSTRATIVE FILL … -->` once demo numbers are in — and the follow-up-run block is a separate fence carrying **both** labels: `<!-- OPERATOR BLOCK … -->` as its first line **and** a visible `**Next steps for your team** — *operator block; not part of the client report*` line directly under it. Both, because a comment alone renders to nothing in the delivered report and a heading alone is lost when a model copies the fence; **no skill slug or command slug appears anywhere inside the client report fence**, and **no framework item ID appears in the client-facing prose** — a reader who copies only that fence must be able to tell it is not for the client. **The scored per-item table keeps its ID column** (ruled 2026-08-13): there the ID is a row label sitting beside the item's plain-language name, so the client reads "Intent Alignment" and the ID is only a stable handle for the row. In prose the ID *is* the referent — "Items R02 and R03 failed" tells a client nothing — and that is the form the rule bans. **A bare list of IDs inside a cell does not qualify either**: "C02, C03 Pass; C01 Partial" is the referent form wearing a table's clothes, because no plain-language name sits against any of them. The earlier fence-wide wording was unsatisfiable: the checkbox above it requires every item scored, and the per-item table is the instrument the client bought.

## Example

See [references/example-report.md](./references/example-report.md) for a complete CITE audit of cloudhosting.example showing veto check, dimension scores, top 5 improvements, action plan, and cross-reference with CORE-EEAT.

## Tips for Success

1. **Start with veto items** — T03, T05, T09 can invalidate the entire score
2. **Identify domain type first** — Different types have very different weight profiles
3. **AI citation items (C05-C08) matter most for GEO** — Test by querying AI engines with niche-relevant questions
4. **Some items need specialized tools** — Knowledge graph queries, AI citation monitoring, and IP diversity analysis may require manual research if tools aren't connected
5. **Pair with CORE-EEAT for full picture** — Domain authority without content quality (or vice versa) tells only half the story

## Reference Materials

- [CITE Domain Rating](../../references/cite-domain-rating.md) — Full 40-item benchmark with dimension definitions, scoring criteria, domain-type weight tables, and veto items
- [references/score-arithmetic.md](./references/score-arithmetic.md) — How every derived figure is composed: dimension tallies, N/A rescaling, the weighted total and its rounding, veto-cap presentation, potential-gain and projection formulas, plus the pre-send recompute pass
- [references/example-report.md](./references/example-report.md) — Complete CITE audit example with scored dimensions, top 5 improvements, action plan, and CORE-EEAT cross-reference
- [references/greek-eshop-compliance.md](./references/greek-eshop-compliance.md) — Greek e-shop trust/compliance audit items mapped onto `CITE-T06` / `CITE-T08` / `CITE-T10` (stale ODR link, ΓΕΜΗ/ΑΦΜ transparency, withdrawal/returns and policy furniture) — audit signals, not legal advice
- [Action Output Contract](../../references/action-output-contract.md) — the seven fields every recommended action carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule
- [Prohibited Tactics](../../references/prohibited-tactics.md) — what an action may never be, and §2 for how an existing instance found in the audited setup is named, costed, remediated, owned and ranked
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — the payload every follow-up-run row passes to the run it names, the label-inside-the-fence rule for an operator block, the hyphenated framework-first item-ID form, and the drop-and-name rule for an unavailable field

## Related Skills

- [content-quality-auditor](../content-quality-auditor/) — Page-level content audit (CORE-EEAT 80 items) — the sister skill
- [backlink-analyzer](../../monitor/backlink-analyzer/) — Deep-dive into backlink profile (feeds C dimension data)
- [competitor-analysis](../../research/competitor-analysis/) — Compare CITE scores across competitors
- [performance-reporter](../../monitor/performance-reporter/) — Track CITE score trends over time
- [entity-optimizer](../entity-optimizer/) — Entity presence audit; complements CITE I dimension
