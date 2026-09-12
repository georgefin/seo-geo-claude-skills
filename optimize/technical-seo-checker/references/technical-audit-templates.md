# Technical SEO Checker — Output Templates

Detailed output templates for technical-seo-checker steps 3-9. Referenced from [SKILL.md](../SKILL.md).

**Every score in these templates is arithmetic over the rows above it** — ✅ 1 · ⚠️ 0.5 · ❌ 0,
`round(10 × points ÷ rows scored)`, halves rounding down — and prints its own derivation. Rows
you could not check are excluded from the denominator and counted in the derivation; a section
with no checkable row is written `not scored — no data`, never `0/10`. The per-section row
definitions, the count-row conversion and the overall /100 arithmetic are in
[score-rubric.md](./score-rubric.md). **Config snippets** the report hands over carry their file,
block and position — [server-config-fixes.md](./server-config-fixes.md).

---

## Recommended Actions — the Seven Fields

The rule is stated in [SKILL.md](../SKILL.md) § Scoring, Action & Config-Snippet Rules. This is
the working detail every template below draws on. Full field table, the three permitted shapes of
expected impact and more worked criteria:
[Action Output Contract](../../../references/action-output-contract.md).

| # | Field | In these templates | Stated-absence value |
|---|---|---|---|
| 1 | Action | the **Solution** line, or the Action column | — (an action with no action is not a row) |
| 2 | Owner | Owner | `unassigned — needs an owner` |
| 3 | Acceptance criterion | **Done when** in a per-action block, **Acceptance criterion** as a table column — one field, two labels, no third | — (an action with no criterion is not a row) |
| 4 | Expected impact | the **Impact** line, or the Expected impact column | `not estimated — no baseline data` |
| 5 | Effort | Effort | `not estimated` |
| 6 | Dependencies | Depends on | `none` |
| 7 | Risk if done wrong | Risk if done wrong | `low — reversible, no downstream effect` |

**Owner roles — the closed list.** `Content` · `SEO/technical` · `Developer` · `Designer` ·
`Product/merchandising` · `Customer service` · `Legal/compliance` · `Agency` · `Client decision`.
A person's name appears only where the client supplied one, beside the role. Most of this audit's
actions land on `Developer` or `SEO/technical`; a hosting change, a CDN contract or taking a
property offline is `Client decision`, and assigning it makes the decision visible instead of
leaving the action stalled with no explanation. `unassigned — needs an owner` surfaces work with
nowhere to go — a common and useful result where a site has no maintainer — and is never used to
dodge an obvious assignment.

**Effort bands.** **S** — a config edit or a single file, ≤30 min, no deploy window. **M** — ≤2 h,
or one deploy. **L** — needs planning, a migration, a release train, or somebody else's calendar.
Hours instead of bands where the client works that way.

**Acceptance criteria — this skill's shapes.** Where the action hands over a config snippet, the
snippet's own **verification command** is the criterion: it is observable, binary, and runnable
by anyone. That is the cheapest criterion in this library and it is already required by the
paste-ready rule.

| Not a criterion | A criterion |
|---|---|
| "HSTS sorted" | "`curl -I` on the production host returns `strict-transport-security` with a max-age of at least 31536000" |
| "Fix the redirect chains" | "Each of the 5 listed legacy URLs returns a single 301 straight to its final destination — no second hop — checked with `curl -IL`" |
| "Improve LCP" | "A page-speed report for the 3 template URLs, run after the deploy, records mobile LCP for each; the figures are filed beside the dated baseline" |
| "Fix the sitemap" | "`/sitemap.xml` returns 200, parses as valid XML, contains only indexable URLs, and is declared in `robots.txt`" |
| "Get cited by AI assistants" | Not a criterion at all — rewrite as the work shipped plus the measurement re-run and recorded |

**An AI-surface criterion is a measurement criterion, never an outcome criterion.** An appearance
in a generated answer is not in anyone's gift to deliver, and writing it turns the action into a
promise. A crawler-access change is accepted on the directive shipped and verified, never on a
citation appearing.

**Ordering.** Expected impact ÷ effort, dependencies respected, *inside* the 🔴 Critical / 🟡 High
/ 🟢 Medium-Low severity bands this skill already uses — priority follows severity, never the
score. An action whose dependency is unmet sits below the thing it waits on, whatever its score.
No second priority vocabulary is invented beside severity, and the ordering rule is stated once
per report.

**The action table is client-read.** No framework item IDs, no skill or command slugs, no repo
paths, no ruling IDs, no `~~category` tokens in it. Anything addressed to whoever runs the
library goes in an operator block, labelled inside its own fence.

---

## Step 3: Audit Site Speed & Core Web Vitals

```markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from what
     you measured; a row you could not check is excluded from the denominator and counted in
     the derivation, never entered as a fail, and a section with no checkable row is written
     "not scored — no data". Delete this comment before the section goes to the client. -->
## Performance Analysis

### Core Web Vitals

| Metric | Mobile | Desktop | Target | Status |
|--------|--------|---------|--------|--------|
| LCP (Largest Contentful Paint) | [X]s | [X]s | ≤2.5s | ✅/⚠️/❌ |
| CLS (Cumulative Layout Shift) | [X] | [X] | ≤0.1 | ✅/⚠️/❌ |
| INP (Interaction to Next Paint) | [X]ms | [X]ms | ≤200ms | ✅/⚠️/❌ |

### Additional Performance Metrics

| Metric | Value | Status |
|--------|-------|--------|
| Time to First Byte (TTFB) | [X]ms | ✅/⚠️/❌ |
| First Contentful Paint (FCP) | [X]s | ✅/⚠️/❌ |
| Speed Index | [X] | ✅/⚠️/❌ |
| Total Blocking Time | [X]ms | ✅/⚠️/❌ |
| Page Size | [X]MB | ✅/⚠️/❌ |
| Requests | [X] | ✅/⚠️/❌ |

### Performance Issues

**LCP Issues**:
- [Issue]: [Impact] - [Solution]
- [Issue]: [Impact] - [Solution]

**CLS Issues**:
- [Issue]: [Impact] - [Solution]

**Resource Loading**:
| Resource Type | Count | Size | Issues |
|---------------|-------|------|--------|
| Images | [X] | [X]MB | [notes] |
| JavaScript | [X] | [X]MB | [notes] |
| CSS | [X] | [X]KB | [notes] |
| Fonts | [X] | [X]KB | [notes] |

### Optimization Recommendations

**High Impact**:
1. [Recommendation] - Est. improvement: [X]s
2. [Recommendation] - Est. improvement: [X]s

**Medium Impact**:
1. [Recommendation]
2. [Recommendation]

**Performance Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
```

> **How this number is derived** — the 3 Core Web Vitals rows (scored on the **mobile** verdict;
> the desktop verdict is reported in the row, not scored separately) plus the 6 Additional
> Performance Metrics rows: ✅ 1 · ⚠️ 0.5 · ❌ 0, then `round(10 × points ÷ rows scored)`, halves
> down. The Resource Loading table is evidence, not scored rows. CWV targets are inclusive —
> LCP ≤2.5s, INP ≤200ms, CLS ≤0.1 — so a value exactly at the threshold passes. Never mix field
> and lab values in one row; label which you scored. Rules: [score-rubric.md](./score-rubric.md).

---

## Step 4: Audit Mobile-Friendliness

```markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from what
     you measured; a row you could not check is excluded from the denominator and counted in
     the derivation, never entered as a fail, and a section with no checkable row is written
     "not scored — no data". Delete this comment before the section goes to the client. -->
## Mobile Optimization Analysis

### Mobile-Friendly Test

| Check | Status | Notes |
|-------|--------|-------|
| Mobile-friendly overall | ✅/❌ | [notes] |
| Viewport configured | ✅/❌ | [viewport tag] |
| Text readable | ✅/⚠️/❌ | Font size: [X]px |
| Tap targets sized | ✅/⚠️/❌ | [notes] |
| Content fits viewport | ✅/❌ | [notes] |
| No horizontal scroll | ✅/❌ | [notes] |

### Responsive Design Check

| Element | Desktop | Mobile | Issues |
|---------|---------|--------|--------|
| Navigation | [status] | [status] | [notes] |
| Images | [status] | [status] | [notes] |
| Forms | [status] | [status] | [notes] |
| Tables | [status] | [status] | [notes] |
| Videos | [status] | [status] | [notes] |

### Mobile-First Indexing

| Check | Status | Notes |
|-------|--------|-------|
| Mobile version has all content | ✅/⚠️/❌ | [notes] |
| Mobile has same structured data | ✅/⚠️/❌ | [notes] |
| Mobile has same meta tags | ✅/⚠️/❌ | [notes] |
| Mobile images have alt text | ✅/⚠️/❌ | [notes] |

**Mobile Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
```

> **How this number is derived** — the 6 Mobile-Friendly Test rows + the 4 Mobile-First Indexing
> rows + the Responsive Design Check rows for elements you actually observed: ✅ 1 · ⚠️ 0.5 · ❌ 0,
> then `round(10 × points ÷ rows scored)`, halves down. An element you did not view on a mobile
> viewport is "not checked", not a pass. Rules: [score-rubric.md](./score-rubric.md).

---

## Step 5: Audit Security & HTTPS

```markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from what
     you measured; a row you could not check is excluded from the denominator and counted in
     the derivation, never entered as a fail, and a section with no checkable row is written
     "not scored — no data". Delete this comment before the section goes to the client. -->
## Security Analysis

### HTTPS Status

| Check | Status | Notes |
|-------|--------|-------|
| SSL certificate valid | ✅/❌ | Expires: [date] |
| HTTPS enforced | ✅/❌ | [redirects properly?] |
| Mixed content | ✅/⚠️/❌ | [X] issues |
| HSTS enabled | ✅/⚠️ | [notes] |
| Certificate chain | ✅/⚠️/❌ | [notes] |

### Security Headers

| Header | Present | Value | Recommended |
|--------|---------|-------|-------------|
| Content-Security-Policy | ✅/❌ | [value] | [recommendation] |
| X-Frame-Options | ✅/❌ | [value] | DENY or SAMEORIGIN |
| X-Content-Type-Options | ✅/❌ | [value] | nosniff |
| X-XSS-Protection | ✅/❌ | [value] | 1; mode=block |
| Referrer-Policy | ✅/❌ | [value] | [recommendation] |

**Security Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
```

> **How this number is derived** — the 5 HTTPS Status rows + the 5 Security Headers rows
> (✅ present with the recommended value · ⚠️ present but weaker/partial · ❌ absent): ✅ 1 ·
> ⚠️ 0.5 · ❌ 0, then `round(10 × points ÷ rows scored)`, halves down. Headers pulled for one URL
> are scored for that URL and the scope is stated — a homepage header pull is not a site-wide
> header state. Rules: [score-rubric.md](./score-rubric.md).
>
> **Header fixes**: any `add_header` block the report hands over names its file, its server block
> and its position, and carries the HSTS and inheritance cautions —
> [server-config-fixes.md](./server-config-fixes.md) §5.
>
> **A failing "HTTPS enforced" row is the highest-risk fix in this whole audit.** The port-80
> redirect that closes it is an edit to whatever block is already listening on 80, never a
> replacement of it, and the block carries the `/.well-known/acme-challenge/` exception *inside
> the fence* — that path is how an HTTP-01 certificate renewal reaches its token, and a blanket
> redirect over it fails at the next renewal rather than at deploy. Never pair this fix with an
> acceptance criterion that only requests `/`: it passes while the site is broken. The block, the
> Apache form, and the probe-file check that sees it: [server-config-fixes.md](./server-config-fixes.md)
> §3E, §4 block 1, §8 step 5.

---

## Step 6: Audit URL Structure

```markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from what
     you measured; a row you could not check is excluded from the denominator and counted in
     the derivation, never entered as a fail, and a section with no checkable row is written
     "not scored — no data". Delete this comment before the section goes to the client. -->
## URL Structure Analysis

### URL Pattern Review

| Check | Status | Notes |
|-------|--------|-------|
| HTTPS URLs | ✅/⚠️/❌ | [X]% HTTPS |
| Lowercase URLs | ✅/⚠️/❌ | [notes] |
| No special characters | ✅/⚠️/❌ | [notes] |
| Readable/descriptive | ✅/⚠️/❌ | [notes] |
| Appropriate length | ✅/⚠️/❌ | Avg: [X] chars |
| Keywords in URLs | ✅/⚠️/❌ | [notes] |
| Consistent structure | ✅/⚠️/❌ | [notes] |

### URL Issues Found

| Issue Type | Count | Examples |
|------------|-------|----------|
| Dynamic parameters | [X] | [URLs] |
| Session IDs in URLs | [X] | [URLs] |
| Uppercase characters | [X] | [URLs] |
| Special characters | [X] | [URLs] |
| Very long URLs (>100) | [X] | [URLs] |

### Redirect Analysis

| Check | Status | Notes |
|-------|--------|-------|
| Redirect chains | [X] found | [max chain length] |
| Redirect loops | [X] found | [URLs] |
| 302 → 301 needed | [X] found | [URLs] |
| Broken redirects | [X] found | [URLs] |

**URL Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
```

> **How this number is derived** — the 7 URL Pattern Review rows + the 5 URL Issues Found rows +
> the 4 Redirect Analysis rows. The count rows convert by severity: 0 findings → ✅ 1 · highest
> severity Low/Medium → ⚠️ 0.5 · highest severity High/Critical → ❌ 0. Then
> `round(10 × points ÷ rows scored)`, halves down. Rules: [score-rubric.md](./score-rubric.md).
>
> **Redirect fixes**: every rule handed over states the file, the server block, its position
> relative to the directives already there, and the `nginx -t` / `curl -sSIL` check that proves
> it landed — [server-config-fixes.md](./server-config-fixes.md). A redirect pasted into the
> wrong block either never fires or takes the site down (§3 there) — and a site-wide HTTP → HTTPS
> redirect carries §3E's certificate-renewal carve-out in the fence with it.

---

## Step 7: Audit Structured Data

> **CORE-EEAT alignment**: Schema markup quality maps to O05 (Schema Markup) in the CORE-EEAT benchmark. See [content-quality-auditor](../../../cross-cutting/content-quality-auditor/) for full content quality audit.
>
> That recommendation is a handoff, and both the slug and the item ID make it operator-addressed — it belongs in the report's operator block, not in a client-read paragraph. Pass the URLs to audit and their content types. Payload format, placement and the drop-and-name rule for a field you cannot source: [inter-skill-handoff.md](../../../references/inter-skill-handoff.md).

```markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from what
     you measured; a row you could not check is excluded from the denominator and counted in
     the derivation, never entered as a fail, and a section with no checkable row is written
     "not scored — no data". Delete this comment before the section goes to the client. -->
## Structured Data Analysis

### Schema Markup Found

| Schema Type | Pages | Valid | Errors |
|-------------|-------|-------|--------|
| [Type 1] | [X] | ✅/❌ | [errors] |
| [Type 2] | [X] | ✅/❌ | [errors] |

### Validation Results

**Errors**:
- [Error 1]: [affected pages] - [solution]
- [Error 2]: [affected pages] - [solution]

**Warnings**:
- [Warning 1]: [notes]

### Missing Schema Opportunities

| Page Type | Current Schema | Recommended |
|-----------|----------------|-------------|
| Blog posts | [current] | Article + FAQ |
| Products | [current] | Product + Review |
| Homepage | [current] | Organization |

**Structured Data Score**: [X]/10 ([points] ÷ [types assessed]; types assessed: [list]) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
```

> **How this number is derived** — one row per schema type the site's page types call for:
> ✅ 1 present and valid · ⚠️ 0.5 present with errors or warnings · ❌ 0 called for and absent.
> Then `round(10 × points ÷ types assessed)`, halves down. Name the types in the derivation —
> the denominator is a judgment about what the site needs, so it has to be visible for the
> client to argue with. Rules: [score-rubric.md](./score-rubric.md).

---

## Step 8: Audit International SEO (if applicable)

```markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from what
     you measured; a row you could not check is excluded from the denominator and counted in
     the derivation, never entered as a fail, and a section with no checkable row is written
     "not scored — no data". Delete this comment before the section goes to the client. -->
## International SEO Analysis

### Hreflang Implementation

| Check | Status | Notes |
|-------|--------|-------|
| Hreflang tags present | ✅/❌ | [notes] |
| Self-referencing | ✅/⚠️/❌ | [notes] |
| Return tags present | ✅/⚠️/❌ | [notes] |
| Valid language codes | ✅/⚠️/❌ | [notes] |
| x-default tag | ✅/⚠️ | [notes] |

### Language/Region Targeting

| Language | URL | Hreflang | Status |
|----------|-----|----------|--------|
| [en-US] | [URL] | [tag] | ✅/⚠️/❌ |
| [es-ES] | [URL] | [tag] | ✅/⚠️/❌ |

**International Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
```

> **How this number is derived** — the 5 Hreflang Implementation rows + one row per
> language/region pair checked: ✅ 1 · ⚠️ 0.5 · ❌ 0, then `round(10 × points ÷ rows scored)`,
> halves down. A single-locale site does not score this section at all: leave it out and say so
> under the breakdown — 0/10 would read as a failure the site cannot have.
> Rules: [score-rubric.md](./score-rubric.md).

---

## Step 9: Generate Technical Audit Summary

> **How the overall score is derived** — `round(100 × Σ section scores ÷ (10 × sections scored))`,
> halves down. Unweighted: every scored section counts once. Sections that could not be scored
> (no data) and sections that do not apply (International on a single-locale site) are excluded
> from both sides and **named under the breakdown** — they are never entered as 0/10.
> **If no section could be scored, the report carries no health score at all**: say which input
> unlocks which section and stop. A health score for a site nothing was measured on is a
> fabricated figure, whatever the requester says about who will check it.
> Rules: [score-rubric.md](./score-rubric.md).

````markdown
<!-- SKELETON — structure only, not paste-ready. Every [bracket] is a slot filled from this
     audit's own findings. Sections that could not be scored are named under the breakdown,
     never entered as 0/10, and if no section could be scored this block carries no health
     score at all. Delete this comment before the report goes to the client. -->
# Technical SEO Audit Report

**Domain**: [domain]
**Audit Date**: [date]
**Pages Analyzed**: [X]

## Overall Technical Health: [X]/100 ([Σ section scores] ÷ [10 × sections scored] — [N] sections scored; [sections not scored, with the reason])

```
Score Breakdown (✅1 · ⚠️0.5 · ❌0 per checked row; one █ per point):
[bar] Crawlability: [X]/10        ([points] ÷ [rows scored])
[bar] Indexability: [X]/10        ([points] ÷ [rows scored])
[bar] Performance: [X]/10         ([points] ÷ [rows scored])
[bar] Mobile: [X]/10              ([points] ÷ [rows scored])
[bar] Security: [X]/10            ([points] ÷ [rows scored])
[bar] URL Structure: [X]/10       ([points] ÷ [rows scored])
[bar] Structured Data: [X]/10     ([points] ÷ [types assessed])
      International: [X]/10 or "not scored — [reason]"
```

## Critical Issues (Fix Immediately)

Each issue carries Finding / Evidence / Impact / Fix plus a Confidence label
(Confirmed = directly observed in provided data or crawl · Likely = strong indirect
evidence · Hypothesis = plausible, needs verification — name what would confirm it).
The Solution is the action and the Impact is its expected impact; each issue adds the owner,
the acceptance criterion, the effort, the dependencies and the risk of getting it wrong, so it
can be picked up and proved done by somebody who was not in the room. Issues are ordered inside
each severity band by expected impact ÷ effort with dependencies respected — an action whose
dependency is unmet sits below the thing it waits on.

1. **[Issue]**: [Impact]
   - Evidence: [observed data — crawl line, response header, metric]
   - Affected: [pages/scope]
   - Solution: [one imperative sentence naming the artefact and the change]
   - Owner: [role] · Effort: [S / M / L] · Depends on: [named blocker, or "none"]
   - Done when: [observable, binary, attached to a named artefact or measurement, dated or triggered — for a config snippet, its own verification command]
   - Risk if done wrong: [realistic failure mode and its cost, or "low — reversible, no downstream effect"]
   - Priority: 🔴 Critical · Confidence: [Confirmed/Likely/Hypothesis]

2. **[Issue]**: [same format]

## High Priority Issues

1. **[Issue]**: [Solution] — Evidence: [observed data] · Confidence: [label]
   - Owner: [role] · Effort: [S / M / L] · Depends on: [named blocker, or "none"] · Risk if done wrong: [failure mode and cost, or "low — reversible, no downstream effect"]
   - Done when: [observable, binary, dated or triggered]
2. **[Issue]**: [same format]

## Medium Priority Issues

1. **[Issue]**: [Solution] — Evidence: [observed data] · Confidence: [label]
   - Owner: [role] · Effort: [S / M / L] · Depends on: [named blocker, or "none"] · Risk if done wrong: [failure mode and cost, or "low — reversible, no downstream effect"]
   - Done when: [observable, binary, dated or triggered]
2. **[Issue]**: [same format]

## Quick Wins

The S-effort rows of the Action Plan below, whose dependencies are already met. Owner,
acceptance criterion and risk are stated once, in that table.

1. [Quick fix 1 — why it is worth doing first]
2. [Quick fix 2 — why it is worth doing first]
3. [Quick fix 3 — why it is worth doing first]

## Action Plan

Every action this audit recommends, in one place. **Ordered by expected impact ÷ effort with
dependencies respected, inside the severity bands above** — an action whose dependency is unmet
sits below the thing it waits on. Effort: S a config edit or single file, ≤30 min, no deploy
window · M ≤2 h or one deploy · L needs planning, a migration, or somebody else's calendar. A
field with no answer carries its stated-absence value, never a blank.

| # | Action | Owner | Acceptance criterion | Expected impact | Effort | Depends on | Risk if done wrong |
|---|--------|-------|----------------------|-----------------|--------|------------|--------------------|
| 1 | [imperative sentence naming the artefact and the change] | [role, or "unassigned — needs an owner"] | [observable, binary, dated or triggered — for a config snippet, its own verification command] | [what should change and why, with its basis, or "not estimated — no baseline data"] | [S/M/L] | [named blocker, or "none"] | [failure mode and cost, or "low — reversible, no downstream effect"] |
| 2 | [next action] | … | … | … | … | … | … |

### Implementation Roadmap

The same actions, cut into windows — **no action appears here that is not a row above**, and no
field is restated, so the two views cannot drift apart.

- **Week 1** — the 🔴 Critical rows.
- **Week 2-3** — the 🟡 High rows.
- **Week 4+** — the 🟢 Medium-Low rows and anything waiting on an unmet dependency.

## Monitoring Recommendations

Set up alerts for:
- Core Web Vitals drops
- Crawl error spikes
- Index coverage changes
- Security issues
````
