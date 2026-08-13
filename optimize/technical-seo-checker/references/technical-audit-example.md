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

### 🔴 Critical (Fix Immediately)
1. **/pricing/ blocked in robots.txt** — Evidence: `Disallow: /pricing` in the fetched robots.txt; the sitemap lists /pricing/ and 4 plan pages beneath it. Impact: prevents indexation of the highest-value commercial section (severity framework, Critical row). Fix: remove that line, or narrow it to the specific path that was meant to be private; re-request indexing in Search Console afterwards. Confidence: Confirmed.
2. **Mobile LCP 4.8s (target ≤2.5s)** — Evidence: mobile LCP 4.8s from the PageSpeed Insights run, TTFB 1,240ms, hero image 2.4MB. Impact: fails the CWV Good threshold on the highest-traffic template. Fix: compress hero to WebP (est. save 1.9MB) and add a CDN to bring TTFB <400ms. Confidence: Confirmed.

### 🟡 Important (Fix Soon)
3. **HTTP not redirecting to HTTPS** — Evidence: http:// URLs return 200 without redirect; 7 mixed-content images on /features/. Impact: split signals and browser trust warnings. Fix: add the port-80 server block that 301s both hosts to the canonical HTTPS host, in /etc/nginx/sites-available/cloudhosting.example, above the existing HTTPS block — the canonical block itself gets no redirect (a catch-all there loops the whole site); then HSTS at server level inside the HTTPS block, and update the 7 image URLs. Verify with `nginx -t`, then `curl -sSIL http://cloudhosting.example/` expecting one 301 and a 200. Placement and the paste-ready blocks: [server-config-fixes.md](./server-config-fixes.md). Confidence: Confirmed.

### 🟢 Minor (Optimize)
4. **No Article/FAQPage schema on blog posts** — Evidence: crawl found no structured data on 48 blog posts and 12 FAQ pages. Impact: missed Article rich-result eligibility. Fix: add Article schema to the blog posts; add FAQPage markup to the FAQ pages because it is valid and Google says there is no need to proactively remove it (FAQ rich results ended 2026 — no SERP promise, and ruling R3 amendment 9a records no evidenced citation benefit either way, so claim none). Confidence: Confirmed.
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
