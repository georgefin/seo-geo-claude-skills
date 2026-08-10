---
name: check-technical
description: Run a quick technical SEO health check for a given URL or domain
argument-hint: "<URL or domain>"
allowed-tools: ["WebFetch"]
parameters:
  - name: target
    type: string
    required: true
    description: URL or domain to check
---

# Check Technical Command

A focused **technical SEO health check** covering infrastructure, performance, and crawlability. Complements `/seo:audit-page` which covers content quality + on-page SEO.

## Usage

```
/seo:check-technical https://example.com
/seo:check-technical https://example.com/specific-page
/seo:check-technical example.com
```

**Arguments:**
- URL or domain (required)

## Workflow

1. **Determine Scope** -- Single page vs site-wide check based on input (full URL vs bare domain).
2. **Run Technical SEO Audit** -- Invoke `technical-seo-checker`. It scores eight sections: Crawlability, Indexability, Performance (page speed / Core Web Vitals), Mobile, Security (HTTPS), URL Structure, Structured Data, International.
3. **Compile Output** -- Report all eight section scores plus the overall health score, each printing its own arithmetic, and a prioritized action list ordered by severity, not by score.

## Output Format

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
TECHNICAL SEO CHECK: [URL or Domain]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

OVERALL TECHNICAL SCORE: 63/100 (44 ÷ 70 — 7 sections scored; International
not scored: single-language site)

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
SECTION SCORES
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[8 section scores, each /10 with its own derivation: Crawlability, Indexability,
Performance, Mobile, Security, URL Structure, Structured Data, International —
e.g. "Security: 4/10 (1.5 pts ÷ 4 scored rows; 6 rows not checked)"]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
CORE WEB VITALS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

LCP / INP / CLS / TTFB with pass/fail status

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
PRIORITY ACTION LIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

CRITICAL / IMPORTANT / MINOR items with specific fixes

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
ACTION CHECKLIST
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[ ] [Action items]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NOTE: For content quality + on-page SEO, run: /seo:audit-page
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Scoring

Both figures are arithmetic, taken straight from `technical-seo-checker`'s rubric — this command defines no scale of its own. Rows: ✅ 1 · ⚠️ 0.5 · ❌ 0. Section = `round(10 × points ÷ rows scored)`, exact half rounds down. Overall = `round(100 × Σ section scores ÷ (10 × sections scored))`, unweighted. A row that could not be checked leaves both sides of its section's fraction; a section with no checkable row reads `not scored — no data`, never `0/10`. With International SEO out of scope the denominator is 7 sections, not 8 — say which sections it covers. **If nothing could be scored, print no overall score**: name the input that unlocks each section instead. Full rules: [score-rubric.md](../optimize/technical-seo-checker/references/score-rubric.md).

## Tips

- Prioritize Core Web Vitals -- they directly impact rankings
- Use Google PageSpeed Insights and Search Console for data without integrations
- Re-run after infrastructure changes

## Related Skills

- [technical-seo-checker](../optimize/technical-seo-checker/) -- Comprehensive technical SEO audit
