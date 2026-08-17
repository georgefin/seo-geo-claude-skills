# Technical SEO Checker — Worked Example & Checklist

Referenced from [SKILL.md](../SKILL.md).

The example below is **abridged**: it shows a few tables per section, not the full checklists.
That is why its denominators are small — and why every score states its own denominator. The
arithmetic behind each number is in [score-rubric.md](./score-rubric.md) §8, which recomputes
this example line by line.

---

## Worked Example

**User**: "Check the technical SEO of cloudhosting.example"

**Output**:

```markdown
# Technical SEO Audit Report

**Domain**: cloudhosting.example
**Audit Date**: 2024-09-15
**Pages Analyzed**: 312

## Crawlability Analysis

### Robots.txt Review

**URL**: cloudhosting.example/robots.txt
**Status**: Found

| Check | Status | Notes |
|-------|--------|-------|
| File exists | ✅ | 200 response |
| Valid syntax | ⚠️ | Wildcard pattern `Disallow: /*?` too aggressive — blocks faceted pages |
| Sitemap declared | ❌ | No Sitemap directive in robots.txt |
| Important pages blocked | ❌ | /pricing/ blocked by `Disallow: /pricing` rule — Critical, so ❌ not ⚠️ |
| Assets blocked | ✅ | CSS/JS accessible |

**Issues Found**:
- Sitemap URL not declared in robots.txt
- `/pricing/` inadvertently blocked — high-value commercial page

### XML Sitemap Review

**Sitemap URL**: cloudhosting.example/sitemap.xml
**Status**: Found (not referenced in robots.txt)

| Check | Status | Notes |
|-------|--------|-------|
| Sitemap exists | ✅ | Valid XML, 287 URLs |
| Only indexable URLs | ❌ | 23 noindex URLs included |
| Includes lastmod | ⚠️ | All dates set to 2023-01-01 — not accurate |

**Crawlability Score**: 5/10 (4 pts ÷ 8 scored rows; 11 rows not checked — user-agent handling, AI-crawler stance and the crawl-budget table were not part of this pull) · highest severity: 🔴 Critical (/pricing/ blocked in robots.txt)

## Performance Analysis

### Core Web Vitals

| Metric | Mobile | Desktop | Target | Status |
|--------|--------|---------|--------|--------|
| LCP (Largest Contentful Paint) | 4.8s | 2.1s | ≤2.5s | ❌ Mobile / ✅ Desktop |
| CLS (Cumulative Layout Shift) | 0.24 | 0.08 | ≤0.1 | ❌ Mobile / ✅ Desktop |
| INP (Interaction to Next Paint) | 380ms | 140ms | ≤200ms | ❌ Mobile / ✅ Desktop |

### Additional Performance Metrics

| Metric | Value | Status |
|--------|-------|--------|
| Time to First Byte (TTFB) | 1,240ms | ❌ |
| Page Size | 3.8MB | ❌ |
| Requests | 94 | ⚠️ |

**LCP Issues**:
- Uncompressed hero image (2.4MB PNG): Convert to WebP, est. save 1.9MB
- No CDN detected: TTFB 1,240ms from origin server

**CLS Issues**:
- Ad banner at top of page injects without reserved height (0.18 shift contribution)

**Performance Score**: 1/10 (0.5 pts ÷ 6 scored rows; 3 rows not checked — FCP, Speed Index and Total Blocking Time were not captured. Scored on the mobile verdict; desktop reported, not scored) · highest severity: 🔴 Critical

## Security Analysis

### HTTPS Status

| Check | Status | Notes |
|-------|--------|-------|
| SSL certificate valid | ✅ | Expires: 2025-03-22 |
| HTTPS enforced | ⚠️ | http://cloudhosting.example returns 200 instead of 301 redirect |
| Mixed content | ❌ | 7 images loaded over HTTP on /features/ page |
| HSTS enabled | ❌ | Header not present |

**Security Score**: 4/10 (1.5 pts ÷ 4 scored rows; 6 rows not checked — certificate chain and the five security headers were not pulled) · highest severity: 🟡 High (mixed content on /features/)

## Structured Data Analysis

### Schema Markup Found

| Schema Type | Pages | Valid | Errors |
|-------------|-------|-------|--------|
| Organization | 1 (homepage) | ✅ | None |
| Article | 0 | — | Missing on 48 blog posts |
| Product | 0 | — | Missing on 5 plan pages |
| FAQ | 0 | — | Missing on 12 pages with FAQ content |

**Structured Data Score**: 2/10 (1 pt ÷ 4 types assessed: Organization ✅, Article ❌, Product ❌, FAQPage ❌) · highest severity: 🟢 Medium

## Overall Technical Health: 30/100 (12 ÷ 40 — 4 sections scored; Indexability, Mobile and URL Structure not scored, their tables are outside this abridged example)

```
Score Breakdown (✅1 · ⚠️0.5 · ❌0 per checked row; one █ per point):
█████░░░░░ Crawlability: 5/10        (4 pts ÷ 8 rows)
█░░░░░░░░░ Performance: 1/10         (0.5 pts ÷ 6 rows)
████░░░░░░ Security: 4/10            (1.5 pts ÷ 4 rows)
██░░░░░░░░ Structured Data: 2/10     (1 pt ÷ 4 types)
           Indexability: not scored — no data in this extract
           Mobile: not scored — no data in this extract
           URL Structure: not scored — no data in this extract
```

## Priority Issues

Priority follows severity, not the section score: Crawlability scores 5/10 — mid-table — and
still leads the list, because one of its eight rows keeps a commercial page out of the index.
Inside each band the order is expected impact ÷ effort, with dependencies respected.

### 🔴 Critical (Fix Immediately)
1. **/pricing/ blocked in robots.txt** — Evidence: `Disallow: /pricing` in the fetched robots.txt; the sitemap lists /pricing/ and 4 plan pages beneath it. Impact: prevents indexation of the highest-value commercial section (severity framework, Critical row). Fix: remove that line, or narrow it to the specific path that was meant to be private; re-request indexing in Search Console afterwards. Confidence: Confirmed.
   - Owner: Developer · Effort: S · Depends on: confirmation from the site owner that /pricing/ was never meant to be private
   - Done when: the live `/robots.txt` contains no rule blocking `/pricing`, and `/pricing/` plus the 4 plan pages return "URL is on Google" in a live URL inspection
   - Risk if done wrong: high — widening the rule instead of narrowing it exposes whatever the original `Disallow` was protecting; confirm what it was for before editing
2. **Mobile LCP 4.8s (target ≤2.5s)** — Evidence: mobile LCP 4.8s from the PageSpeed Insights run, TTFB 1,240ms, hero image 2.4MB. Impact: fails the CWV Good threshold on the highest-traffic template. Fix: compress the hero image to WebP (est. save 1.9MB) and put a CDN in front of the origin to bring TTFB under 400ms. Confidence: Confirmed.
   - Owner: Developer, with the CDN contract as Client decision · Effort: L · Depends on: a CDN being procured
   - Done when: a PageSpeed Insights run on this template, dated after the deploy, records mobile LCP and TTFB, and both figures are filed beside the 4.8s / 1,240ms baseline
   - Risk if done wrong: medium — a badly configured CDN can serve stale or wrong-region content; stage it and check cache headers before cutting DNS over

### 🟡 Important (Fix Soon)
3. **HTTP not redirecting to HTTPS** — Evidence: http:// URLs return 200 without redirect; 7 mixed-content images on /features/. Impact: split signals and browser trust warnings. Fix: the port-80 block in /etc/nginx/sites-available/cloudhosting.example serves the site over plain HTTP today, so this is an **edit to that block, not a replacement of it** — print the running config with `nginx -T`, keep every `location` the block already carries, and add the 301 to the canonical HTTPS host inside `location /` beneath them. A `/.well-known/acme-challenge/` location there is the route certificate renewal uses, and a block pasted over the top of it removes that route silently; the same applies to any other `.well-known` path already being served. The canonical HTTPS block itself gets no redirect (a catch-all there loops the whole site); then HSTS at server level inside the HTTPS block, and update the 7 image URLs. Placement and the paste-ready blocks: [server-config-fixes.md](./server-config-fixes.md). Confidence: Confirmed.
   - Owner: Developer · Effort: M · Depends on: none
   - Done when: `nginx -t` passes, `curl -sSIL http://cloudhosting.example/` returns exactly one 301 followed by a 200 with `strict-transport-security` present on the 200, **and** a probe file written into the challenge directory reads back as a plain `200` — not a redirect — at `http://cloudhosting.example/.well-known/acme-challenge/probe` and at the www hostname, with both `curl` outputs filed
   - Risk if done wrong: high — a catch-all redirect placed in the canonical block loops the whole site, and a port-80 block replaced instead of edited takes the certificate-renewal path with it: nothing breaks at deploy and the renewal fails 60-90 days later, when nobody is looking at this change. Copy the file before editing; the rollback is restoring that copy and reloading

### 🟢 Minor (Optimize)
4. **No Article/FAQPage schema on blog posts** — Evidence: crawl found no structured data on 48 blog posts and 12 FAQ pages. Impact: missed Article rich-result eligibility. Fix: add Article schema to the blog posts; add FAQPage markup to the FAQ pages because it is valid and Google says there is no need to proactively remove it (no FAQ rich result for ordinary sites — government/health only, Aug 2023 — no SERP promise, and no evidenced citation benefit either way, so claim none). Confidence: Confirmed.
   - Owner: Developer · Effort: M · Depends on: none
   - Done when: markup on a sample of 5 blog posts and 5 FAQ pages validates with zero errors in a structured-data test, and every property in it corresponds to content visible on the page
   - Risk if done wrong: medium — markup describing anything not visible on the page is a misrepresentation and invalidates the block

## Action Plan

Ordered by expected impact ÷ effort with dependencies respected, inside the severity bands above. Effort: S a config edit or single file, ≤30 min, no deploy window · M ≤2 h or one deploy · L needs planning, a migration, or somebody else's calendar.

| # | Action | Owner | Acceptance criterion | Expected impact | Effort | Depends on | Risk if done wrong |
|---|--------|-------|----------------------|-----------------|--------|------------|--------------------|
| 1 | Remove or narrow the `Disallow: /pricing` rule in robots.txt, then request indexing for the 5 affected URLs | Developer | Live `/robots.txt` contains no rule blocking `/pricing`, and `/pricing/` plus the 4 plan pages return "URL is on Google" in a live URL inspection | The commercial section becomes crawlable at all; nothing else on this list matters while it is blocked | S | Confirmation from the site owner that `/pricing/` was never meant to be private | high — widening the rule instead of narrowing it exposes whatever it was protecting |
| 2 | Edit the existing port-80 block — keeping every `location` in it, the `/.well-known/acme-challenge/` route above all — so both hosts 301 to the canonical HTTPS host from inside `location /`, then enable HSTS and update the 7 mixed-content image URLs | Developer | `nginx -t` passes, `curl -sSIL http://cloudhosting.example/` returns exactly one 301 then a 200 carrying `strict-transport-security`, and a probe file in the challenge directory reads back `200` (not a redirect) over plain HTTP on both hostnames | Removes the split HTTP/HTTPS signal and the browser trust warning; converts 2 of Security's 4 checked rows | M | none | high — a catch-all redirect in the canonical block loops the whole site, and replacing the port-80 block instead of editing it deletes the certificate-renewal route with no symptom until the renewal fails; copy the file first, rollback is restoring that copy and reloading |
| 3 | Add Article schema to the 48 blog posts and FAQPage markup to the 12 FAQ pages — no FAQ rich result for ordinary sites (government/health only, Aug 2023) and no evidenced citation benefit either way, so claim none | Developer | Markup on a sample of 5 posts and 5 FAQ pages validates with zero errors in a structured-data test, and every property corresponds to content visible on the page | Converts 2 of Structured Data's 4 assessed types | M | none | medium — markup describing anything not on the page is a misrepresentation and invalidates the block |
| 4 | Compress the hero image to WebP and put a CDN in front of the origin | Developer (CDN procurement is a Client decision) | A PageSpeed Insights run on this template, dated after the deploy, records mobile LCP and TTFB, and both are filed beside the 4.8s / 1,240ms baseline | Mobile LCP and TTFB are the two measured failures on the highest-traffic template; the hero alone is 2.4MB of the payload | L | a CDN being procured | medium — a misconfigured CDN serves stale or wrong-region content; stage it and check cache headers before cutting DNS over |
| 5 | Supply the crawl and rendering data for Indexability, Mobile and URL Structure so those three sections can be scored | Client decision | Crawl export, mobile test output and URL inventory are delivered, and the three sections carry scores instead of "not scored — no data" | not estimated — no baseline data; three of seven sections are currently unmeasured | S | access to a crawler | low — reversible, no downstream effect |

### Implementation Roadmap

The same actions, cut into windows — no action appears here that is not a row above.

- **Week 1** — rows 1 and 2 (the Critical band, and the redirect block that unblocks nothing else).
- **Week 2-3** — row 3.
- **Week 4+** — row 4, once the CDN is procured, and row 5 whenever the data arrives.
```

---

## Technical SEO Checklist

```markdown
### Crawlability
- [ ] robots.txt is valid and not blocking important content
- [ ] XML sitemap exists and is submitted to Search Console
- [ ] No crawl errors in Search Console
- [ ] No redirect chains or loops

### Indexability
- [ ] Important pages are indexable
- [ ] Canonical tags are correct
- [ ] No duplicate content issues
- [ ] Pagination is handled correctly

### Performance
- [ ] Core Web Vitals pass
- [ ] Page speed under 3 seconds
- [ ] Images are optimized
- [ ] JS/CSS are minified

### Mobile
- [ ] Mobile-friendly test passes
- [ ] Viewport is configured
- [ ] Touch elements are properly sized

### Security
- [ ] HTTPS is enforced
- [ ] SSL certificate is valid
- [ ] No mixed content
- [ ] Security headers present

### Structure
- [ ] URLs are clean and descriptive
- [ ] Site architecture is logical
- [ ] Internal linking is strong
```
