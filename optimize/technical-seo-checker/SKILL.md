---
name: technical-seo-checker
version: "4.6.0"
description: 'Run technical SEO audits covering Core Web Vitals, crawlability, indexing, mobile-friendliness, and site architecture. Use when the user asks to "technical SEO audit", "check page speed", "Core Web Vitals", "crawl errors", "indexing problems", "site health check". For content element issues, see on-page-seo-auditor. For link architecture, see internal-linking-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
allowed-tools: WebFetch
metadata:
  author: aaron-he-zhu
  version: "4.6.0"
  geo-relevance: "low"
  tags:
    - seo
    - technical seo
    - page speed
    - core web vitals
    - crawlability
    - indexability
    - mobile-friendly
    - site speed
    - security audit
    - core-web-vitals
    - page-speed
    - lcp
    - cls
    - inp
    - ttfb
    - crawl-errors
    - robots-txt
    - xml-sitemap
    - hreflang
    - canonicalization
    - https
    - mobile-seo
    - redirect-chains
    - javascript-rendering
    - site-health
  triggers:
    - "technical SEO audit"
    - "check page speed"
    - "crawl issues"
    - "Core Web Vitals"
    - "site indexing problems"
    - "mobile-friendly check"
    - "site speed"
    - "my site is slow"
    - "Google can't crawl my site"
    - "mobile issues"
    - "indexing problems"
---

# Technical SEO Checker

This skill performs comprehensive technical SEO audits to identify issues that may prevent search engines from properly crawling, indexing, and ranking your site.

## When to Use This Skill

- Launching a new website
- Diagnosing ranking drops
- Pre-migration SEO audits
- Regular technical health checks
- Identifying crawl and index issues
- Improving site performance
- Fixing Core Web Vitals issues

## What This Skill Does

1. **Crawlability Audit**: Checks robots.txt, sitemaps, crawl issues
2. **Indexability Review**: Analyzes index status and blockers
3. **Site Speed Analysis**: Evaluates Core Web Vitals and performance
4. **Mobile-Friendliness**: Checks mobile optimization
5. **Security Check**: Reviews HTTPS and security headers
6. **Structured Data Audit**: Validates schema markup
7. **URL Structure Analysis**: Reviews URL patterns and redirects
8. **International SEO**: Checks hreflang and localization

## How to Use

### Full Technical Audit

```
Perform a technical SEO audit for [URL/domain]
```

### Specific Issue Check

```
Check Core Web Vitals for [URL]
```

```
Audit crawlability and indexability for [domain]
```

### Pre-Migration Audit

```
Technical SEO checklist for migrating [old domain] to [new domain]
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~web crawler + ~~page speed tool + ~~CDN connected:**
Claude can automatically crawl the entire site structure via ~~web crawler, pull Core Web Vitals and performance metrics from ~~page speed tool, analyze caching headers from ~~CDN, and fetch mobile-friendliness data. This enables comprehensive automated technical audits.

**With manual data only:**
Ask the user to provide:
1. Site URL(s) to audit
2. PageSpeed Insights screenshots or reports
3. robots.txt file content
4. sitemap.xml URL or file

Proceed with the full audit using provided data. Note in the output which findings are from automated crawl vs. manual review.

## Instructions

When a user requests a technical SEO audit:

### Finding Format & Confidence Labels

Every issue in the audit output carries **Finding** (what is wrong, with affected URLs or
scope), **Evidence** (the observed data behind it — crawl line, response header, metric),
**Impact** (what it costs), and **Fix** (the specific change), plus a **Confidence** label:

- **Confirmed** — directly observed in provided data or crawl output (e.g., fetched robots.txt, ~~page speed tool report)
- **Likely** — strong indirect evidence (e.g., a pattern seen across the URLs sampled)
- **Hypothesis** — plausible but needs verification (e.g., anything inferred without crawl or tool access)

**Rule**: every Hypothesis finding must name what would confirm it (the specific check,
tool, or data source). Carry the labels through each step's "Issues Found" list into the
Step 9 audit summary.

1. **Audit Crawlability**

   ```markdown
   ## Crawlability Analysis
   
   ### Robots.txt Review
   
   **URL**: [domain]/robots.txt
   **Status**: [Found/Not Found/Error]
   
   **Current Content**:
   ```
   [robots.txt content]
   ```
   
   | Check | Status | Notes |
   |-------|--------|-------|
   | File exists | ✅/❌ | [notes] |
   | Valid syntax | ✅/⚠️/❌ | [errors found] |
   | Sitemap declared | ✅/❌ | [sitemap URL] |
   | Important pages blocked | ✅/⚠️/❌ | [blocked paths] |
   | Assets blocked | ✅/⚠️/❌ | [CSS/JS blocked?] |
   | Correct user-agents | ✅/⚠️/❌ | [notes] |
   | AI-crawler stance consistent | ✅/⚠️/❌ | [stance: open/closed/split; flag any vendor with training bot blocked but sibling search bot not explicitly allowed] |
   
   **Issues Found**:
   - [Issue 1]
   - [Issue 2]
   
   **Recommended robots.txt**:
   ```
   User-agent: *
   Allow: /
   Disallow: /admin/
   Disallow: /private/
   
   Sitemap: https://example.com/sitemap.xml
   ```
   
   ---
   
   ### XML Sitemap Review
   
   **Sitemap URL**: [URL]
   **Status**: [Found/Not Found/Error]
   
   | Check | Status | Notes |
   |-------|--------|-------|
   | Sitemap exists | ✅/❌ | [notes] |
   | Valid XML format | ✅/⚠️/❌ | [errors] |
   | In robots.txt | ✅/❌ | [notes] |
   | Submitted to Search Console | ✅/⚠️/❌ | [notes] |
   | URLs count | [X] | [appropriate?] |
   | Only indexable URLs | ✅/⚠️/❌ | [notes] |
   | Includes priority | ✅/⚠️ | [notes] |
   | Includes lastmod | ✅/⚠️ | [accurate?] |
   
   **Issues Found**:
   - [Issue 1]
   
   ---
   
   ### Crawl Budget Analysis
   
   | Factor | Status | Impact |
   |--------|--------|--------|
   | Crawl errors | [X] errors | [Low/Med/High] |
   | Duplicate content | [X] pages | [Low/Med/High] |
   | Thin content | [X] pages | [Low/Med/High] |
   | Redirect chains | [X] found | [Low/Med/High] |
   | Orphan pages | [X] found | [Low/Med/High] |
   
   **Crawlability Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
   ```

2. **Audit Indexability**

   ```markdown
   ## Indexability Analysis
   
   ### Index Status Overview
   
   | Metric | Count | Notes |
   |--------|-------|-------|
   | Pages in sitemap | [X] | |
   | Pages indexed | [X] | [source: site: search] |
   | Index coverage ratio | [X]% | [good if >90%] |
   
   ### Index Blockers Check
   
   | Blocker Type | Found | Pages Affected |
   |--------------|-------|----------------|
   | noindex meta tag | [X] | [list or "none"] |
   | noindex X-Robots | [X] | [list or "none"] |
   | Robots.txt blocked | [X] | [list or "none"] |
   | Canonical to other | [X] | [list or "none"] |
   | 4xx/5xx errors | [X] | [list or "none"] |
   | Redirect loops | [X] | [list or "none"] |
   
   ### Canonical Tags Audit
   
   | Check | Status | Notes |
   |-------|--------|-------|
   | Canonicals present | ✅/⚠️/❌ | [X]% of pages |
   | Self-referencing | ✅/⚠️/❌ | [notes] |
   | Consistent (HTTP/HTTPS) | ✅/⚠️/❌ | [notes] |
   | Consistent (www/non-www) | ✅/⚠️/❌ | [notes] |
   | No conflicting signals | ✅/⚠️/❌ | [notes] |
   
   ### Duplicate Content Issues
   
   | Issue Type | Count | Examples |
   |------------|-------|----------|
   | Exact duplicates | [X] | [URLs] |
   | Near duplicates | [X] | [URLs] |
   | Parameter duplicates | [X] | [URLs] |
   | WWW/non-WWW | [X] | [notes] |
   | HTTP/HTTPS | [X] | [notes] |
   
   **Indexability Score**: [X]/10 ([points] ÷ [rows scored]; [N] rows not checked) · highest severity: [🔴 Critical / 🟡 High / 🟢 Medium-Low]
   ```

3. **Audit Site Speed & Core Web Vitals** — CWV metrics (LCP/CLS/INP), additional performance metrics (TTFB/FCP/Speed Index/TBT), resource loading breakdown, optimization recommendations

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the performance analysis template (Step 3).

4. **Audit Mobile-Friendliness** — Mobile-friendly test, responsive design check, mobile-first indexing verification

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the mobile optimization template (Step 4).

5. **Audit Security & HTTPS** — SSL certificate, HTTPS enforcement, mixed content, HSTS, security headers (CSP, X-Frame-Options, etc.)

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the security analysis template (Step 5).

6. **Audit URL Structure** — URL patterns, issues (dynamic params, session IDs, uppercase), redirect analysis (chains, loops, 302s)

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the URL structure template (Step 6).

7. **Audit Structured Data** — Schema markup validation, missing schema opportunities. CORE-EEAT alignment: maps to O05.

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the structured data template (Step 7).

8. **Audit International SEO (if applicable)** — Hreflang implementation, language/region targeting

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the international SEO template (Step 8).

9. **Generate Technical Audit Summary** — Overall health score with visual breakdown, critical/high/medium issues, quick wins, implementation roadmap (weeks 1-4+), monitoring recommendations

   > **Reference**: See [references/technical-audit-templates.md](./references/technical-audit-templates.md) for the audit summary template (Step 9).

## Scoring, Action & Config-Snippet Rules

Three rules that bind every step above.

**Every score shows its working.** The eight section scores (/10) and the overall health score
(/100) are arithmetic, not impression: ✅ 1 · ⚠️ 0.5 · ❌ 0 over the section's own checklist rows,
`round(10 × points ÷ rows scored)` with an exact half rounding down; the overall is
`round(100 × Σ section scores ÷ (10 × sections scored))`, unweighted. Each score prints its
numerator, its denominator and the number of rows that could not be checked — a score the client
cannot recompute from the tables above it is not deliverable, and two runs of the same data must
land on the same number. A row you could not check is excluded from the denominator, never
recorded as a pass or a fail. A section with no checkable row is written `not scored — no data`,
never `0/10` (zero means measured and failing). **If no section could be scored, the report
carries no health score at all** — name which input unlocks which section and stop; a health
score for a site nothing was measured on is a fabricated figure, whatever the requester says
about who will check it. Per-section row definitions, the count-row conversion, the CWV rule and
the worked derivation: [references/score-rubric.md](./references/score-rubric.md). Priority
follows severity, never the score — print each section's highest severity beside its number,
because one Critical row among eighteen healthy ones still costs the site its indexation.

**Every action is implementable.** A finding diagnoses; an action gets done. Every action this
audit recommends — each **Solution**, every quick win, every Action Plan row — carries seven
fields: **action** (one imperative sentence naming the artefact and the change), **owner**,
**acceptance criterion** (labelled **Done when** in a per-action block and **Acceptance
criterion** as a table column — one field, two labels, no third), **expected impact**,
**effort**, **dependencies**, **risk if done wrong**. Fields 1–3 are required — an action with no owner-role and no acceptance criterion does
not ship as an action — and 4–7 take a stated-absence value (`not estimated — no baseline data`,
`none`, `low — reversible, no downstream effect`), never a blank and never an invention. **Owner
is a role** from a closed list, never a person unless the client supplied the name; `Client
decision` is a real owner and assigning it makes a decision visible instead of leaving the action
stalled, and `unassigned — needs an owner` is legitimate and is itself a finding. **The
acceptance-criterion test: could someone who was not part of this engagement check it six weeks
from now, without asking anybody what was meant?** Observable, binary at the moment of checking,
attached to a named artefact or measurement, dated or triggered — where a config snippet is the
action, its own stated verification command is the criterion. **It never requires an engine to do
something**: an appearance in a generated answer is nobody's to deliver, so an AI-surface action
is accepted on the work shipped plus the measurement re-run and recorded beside its dated
baseline. **Ordering, stated once per report**: by expected
impact ÷ effort with dependencies respected — an unmet dependency sinks an action below the thing
it waits on — *inside* the existing 🔴 Critical / 🟡 High / 🟢 Medium-Low severity bands, which
stay this skill's only priority vocabulary because priority follows severity and never the score.
Role list, effort bands, worked criteria and the stated-absence values:
[references/technical-audit-templates.md](./references/technical-audit-templates.md) §
Recommended Actions, and [Action Output Contract](../../references/action-output-contract.md).

**Paste-ready means placement-complete — and operationally safe.** Every config artefact the
report hands over — nginx or Apache rules, response headers, `robots.txt` — carries the file it
goes in, the block it goes inside, its position relative to the directives already there, the
audited site's real values (no bracketed placeholders, no data-needed slots, and no confidence or
provenance annotations inside the code fence — those live in the prose around it), the command
that verifies it, and the rollback. A rule without placement is not a fix: the same three lines
can redirect one URL, never run at all, or take the whole site down, depending only on which file
and which block they land in. **Never hand over a wholesale replacement for a live block** — read
it first, keep every `location` exception it carries, state which ones were preserved and why,
and where the existing config cannot be read, say so and hand over an addition to be merged by
whoever holds it. **A port-80 or HTTP → HTTPS redirect carries the `/.well-known/acme-challenge/`
exception inside the fence**: that path is how an HTTP-01 certificate renewal reaches its token,
a blanket redirect over it breaks renewal 60-90 days later rather than at deploy, and a check
requesting only `/` reports success while it does — so verify such a block against a challenge
path, never the site root. Blocks, the five ways a pasted redirect breaks a site, and the
verification commands: [references/server-config-fixes.md](./references/server-config-fixes.md).

## Validation Checkpoints

### Input Validation
- [ ] Site URL or domain clearly specified
- [ ] Access to technical data (robots.txt, sitemap, or crawl results)
- [ ] Performance metrics available (via ~~page speed tool or screenshots)

### Output Validation
- [ ] Every recommendation cites specific data points (not generic advice)
- [ ] All issues include affected URLs or page counts
- [ ] Performance metrics include actual numbers with units (seconds, KB, etc.)
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Screaming Frog, PageSpeed Insights), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)
- [ ] Every finding carries a Confidence label (Confirmed / Likely / Hypothesis); Hypothesis findings name what would confirm them
- [ ] Every score prints its derivation ([points] ÷ [rows scored], with the unchecked rows counted) and its section's highest severity; a section with nothing checkable reads "not scored — no data", never 0/10; nothing measured at all means no health score in the report
- [ ] Every config snippet handed over states its file, its block and its position relative to the directives already there, uses the audited site's real values with no placeholders or provenance markers inside the fence, and names its verification command and rollback. **No snippet replaces a live block wholesale** — the existing block is read first, every `location` exception in it is kept, the report names which were preserved and why, and a config that could not be read yields an addition to be merged by whoever holds it, never a replacement. **Every port-80 / HTTP → HTTPS redirect carries its `/.well-known/acme-challenge/` exception inside the fence**, and its verification requests a path under `/.well-known/acme-challenge/` and states that a correct response is a plain 200, not a 301 to HTTPS — a check that only requests `/` passes while certificate renewal is broken
- [ ] Every recommended action carries all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); no action ships without an owner-role and an acceptance criterion, and the owner is a role from the closed list (`Client decision` and `unassigned — needs an owner` both count, the second being itself a finding)
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — checkable by someone who was not part of this engagement, six weeks on, without asking what was meant; where a config snippet is the action, its stated verification command is the criterion. **None of them requires an engine to do something**: an AI-surface action is accepted on the work shipped plus the measurement re-run and recorded beside its dated baseline, never on an appearance in a generated answer
- [ ] The ordering rule is stated once in the report, and actions run by expected impact ÷ effort with dependencies respected inside the existing 🔴 Critical / 🟡 High / 🟢 Medium-Low severity bands — no second priority vocabulary appears beside them

## Example

> **Reference**: See [references/technical-audit-example.md](./references/technical-audit-example.md) for a full worked example (cloudhosting.example technical audit) and the comprehensive technical SEO checklist.

## Tips for Success

1. **Prioritize by impact** - Fix critical issues first
2. **Monitor continuously** - Use ~~search console alerts
3. **Test changes** - Verify fixes work before deploying widely
4. **Document everything** - Track changes for troubleshooting
5. **Regular audits** - Schedule quarterly technical reviews

> **Technical reference**: For issue severity framework, prioritization matrix, and Core Web Vitals optimization quick reference, see [references/http-status-codes.md](./references/http-status-codes.md).

## Reference Materials

- [robots.txt Reference](./references/robots-txt-reference.md) — Syntax guide, templates, common configurations, AI-crawler bot-role roster and the three access stances (open/closed/split)
- [HTTP Status Codes](./references/http-status-codes.md) — SEO impact of each status code, redirect best practices
- [Technical Audit Templates](./references/technical-audit-templates.md) — Detailed output templates for steps 3-9 (CWV, mobile, security, URL structure, structured data, international, audit summary)
- [Score Rubric](./references/score-rubric.md) — How every /10 section score and the /100 overall are derived: scored rows per section, count-row conversion, CWV mobile rule, rounding, and when a score must be withheld
- [Server-Config Fix Snippets](./references/server-config-fixes.md) — Placement-complete nginx/Apache redirect and header blocks with the `/.well-known/acme-challenge/` carve-out inside the fence, the five ways a pasted redirect takes a site down, the read-before-you-replace rule, verification (challenge path included) and rollback
- [Technical Audit Example & Checklist](./references/technical-audit-example.md) — Full worked example and comprehensive technical SEO checklist
- [Action Output Contract](../../references/action-output-contract.md) — the seven fields every recommended action carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and the AI-surface measurement rule), the three permitted shapes of expected impact, and the ordering rule
- [Prohibited Tactics](../../references/prohibited-tactics.md) — what an action may never be, and §2 for how an existing instance found in the audited setup is named, costed, remediated, owned and ranked
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — what to pass when this audit names a follow-up run (step 7's escalation to a content audit is the standing one), the operator-block placement rule, and the drop-and-name rule for an unavailable field. An alerting or monitoring handoff carries thresholds and metrics instead — see the uncovered-shapes list there

## Related Skills

- [on-page-seo-auditor](../on-page-seo-auditor/) — On-page SEO audit
- [schema-markup-generator](../../build/schema-markup-generator/) — Fix schema issues
- [performance-reporter](../../monitor/performance-reporter/) — Monitor improvements
- [internal-linking-optimizer](../internal-linking-optimizer/) — Fix link issues
- [alert-manager](../../monitor/alert-manager/) — Set up alerts for technical issues found
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit
