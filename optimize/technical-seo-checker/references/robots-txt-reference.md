# Robots.txt Reference Guide

Complete reference for creating, testing, and troubleshooting robots.txt files.

## Syntax Guide

### Basic Structure

```
# SKELETON — directive syntax only, not a deployable file. Every [bracket] is a slot; a
# path or agent you cannot name is left out of the file rather than guessed at, and this
# comment goes when you write the real directives.

User-agent: [bot name]
Disallow: [path to block]
Allow: [path to allow]
Sitemap: [sitemap URL]
Crawl-delay: [seconds]
```

---

## Core Directives

### User-agent

Specifies which bot the rules apply to.

**Syntax**: `User-agent: [bot-name]`

**Bot-role roster** — every AI vendor ships more than one agent, and each agent has a
different job (training vs. search/citation discovery vs. user-triggered fetching).
Decide access **per role**, never per vendor name alone.
`[VERIFY vendor-primary at next sweep — bot rosters churn]` (roster compiled 2026-08-08).

| User-agent token | Operator | Role |
|------------------|----------|------|
| `Googlebot` | Google | Search indexing |
| `Google-Extended` | Google | AI-training opt-out control |
| `Bingbot` | Microsoft | Search indexing (feeds the Copilot ecosystem) |
| `GPTBot` | OpenAI | Model training |
| `OAI-SearchBot` | OpenAI | Search / citation discovery |
| `ChatGPT-User` | OpenAI | User-triggered fetching |
| `ClaudeBot` | Anthropic | Crawling / training |
| `anthropic-ai` | Anthropic | Crawling / training (second Anthropic token — address both) |
| `Claude-SearchBot` | Anthropic | Search / citation discovery |
| `Claude-User` | Anthropic | User-triggered fetching |
| `PerplexityBot` | Perplexity | Answer retrieval / citation |
| `Perplexity-User` | Perplexity | User-triggered fetching |
| `CCBot` | Common Crawl | Open corpus widely used for AI training |
| `*` | — | Every bot not matched by a named group |

**Multiple user-agents**: Group rules by leaving no blank lines between user-agent declarations.

```
User-agent: Googlebot
User-agent: Bingbot
Disallow: /admin/
```

---

### Disallow

Blocks bots from crawling specified paths.

**Syntax**: `Disallow: [path]`

**Examples**:
```
Disallow: /                      # Block entire site
Disallow: /admin/                # Block admin directory
Disallow: /private               # Block private directory (and subdirectories)
Disallow: /*.pdf$                # Block all PDF files
Disallow: /*?                    # Block all URLs with parameters
Disallow:                        # Allow everything (empty disallow)
```

**Path matching**:
- `/` at end = block directory and all subdirectories
- Without `/` at end = block all paths starting with string
- `*` = wildcard, matches any sequence
- `$` = end of URL

---

### Allow

Explicitly allows crawling (overrides Disallow).

**Syntax**: `Allow: [path]`

**Common use**: Allow specific subdirectories within blocked parent.

```
User-agent: *
Disallow: /admin/
Allow: /admin/public/
```

**Note**: Allow is not standard but supported by Google, Bing, and most major crawlers.

---

### Sitemap

Specifies location of XML sitemap.

**Syntax**: `Sitemap: [absolute URL]`

**Examples**:
```
Sitemap: https://example.com/sitemap.xml
Sitemap: https://example.com/sitemap_index.xml
Sitemap: https://example.com/blog/sitemap.xml
```

**Best practices**:
- Use absolute URLs (not relative)
- Can include multiple Sitemap directives
- Place at end of file
- Submit same sitemap(s) to Google Search Console

---

### Crawl-delay

Adds delay between requests (seconds).

**Syntax**: `Crawl-delay: [seconds]`

**Example**:
```
User-agent: *
Crawl-delay: 10
```

**Warning**: Not supported by Googlebot (use Search Console rate limiting instead). Supported by Bing, Yandex, and others.

---

## Common Configurations

### 1. Allow All Bots (Default)

```
User-agent: *
Disallow:

Sitemap: https://example.com/sitemap.xml
```

Use when you want all bots to crawl entire site.

---

### 2. Block All Bots

```
User-agent: *
Disallow: /
```

Use for development/staging sites or private content.

---

### 3. Block Specific Directories

```
User-agent: *
Disallow: /admin/
Disallow: /private/
Disallow: /temp/
Disallow: /cgi-bin/

Sitemap: https://example.com/sitemap.xml
```

Standard configuration blocking admin and utility directories.

---

### 4. AI-Crawler Stances (Pick One Deliberately)

AI-crawler access is a policy decision with three coherent stances. The common failure
mode is an accidental fourth: pasting whatever block list a blog post supplied, with no
stance behind it.

**The bot-pair rule (core of this section)**: every AI vendor ships a bot pair or triple —
one agent for model *training*, one for *search/citation discovery*, and often one for
*user-triggered* fetching (see the bot-role roster above). Each role must be decided
**separately**. Blocking a vendor's training bot while never naming its search bot leaves
that agent's access to whatever `User-agent: *` happens to grant — inherited, not decided,
and it changes the next time somebody edits the wildcard group.

**Audit finding to flag**: *"training bot blocked but sibling search bot not explicitly
allowed."* Raise it whenever a robots.txt disallows any training agent (GPTBot, ClaudeBot,
anthropic-ai, CCBot, Google-Extended) without a matching explicit group for the same
vendor's search/citation and user-triggered agents.

| Stance | Choose when | Shape |
|--------|-------------|-------|
| **Default-open** | AI visibility and citation discovery are goals (typical marketing site) | No AI-specific groups; `User-agent: *` allows; only normal directory blocks |
| **Default-closed** | Licensed/paid/private content, or a deliberate text-and-data-mining reservation | All AI agents (training AND search/citation AND user-triggered) disallowed; the site accepts losing AI citations |
| **Split (search yes, training no)** | Search indexing and AI citations wanted; model-training use refused | Training agents disallowed; search/citation and user-triggered agents explicitly allowed |

> **Read this before editing any multi-group file below — a crawler obeys ONE group, and
> groups are NOT merged.** Per RFC 9309, a crawler selects the single most specific group whose
> user-agent matches it and follows only that group. It never falls back to `User-agent: *` for
> rules it did not find there. **Consequence: every directory you want kept out of a named
> agent's reach must be repeated inside that agent's own group.** Utility blocks placed only in
> the `*` group protect the site from unnamed crawlers and from nobody else.
>
> This is not a style note. It is why the split-stance example below repeats
> `Disallow: /admin/` and `Disallow: /private/` in four groups instead of writing them once —
> and the repetition must not be "tidied" away. **The earlier form of this example put them in
> the `*` group alone, which left Googlebot, Bingbot and six named AI agents free to crawl both
> paths while appearing to block them.** Found 2026-08-17 by a blind executor that declined to
> paste a block it could not verify.

**Split-stance example** (search + citations kept, training refused):

```
# ILLUSTRATIVE FILL — every value below is invented. Replace example.com and the
# directory list with the site's own before this file is deployed.

# --- AI model training: refused ---
# Disallow: / covers everything, so the utility paths need no repeat here.
User-agent: GPTBot
User-agent: ClaudeBot
User-agent: anthropic-ai
User-agent: CCBot
User-agent: Google-Extended
Disallow: /

# --- AI search / citation discovery: allowed, minus the utility paths ---
User-agent: OAI-SearchBot
User-agent: Claude-SearchBot
User-agent: PerplexityBot
Disallow: /admin/
Disallow: /private/

# --- User-triggered fetchers: allowed, minus the utility paths ---
User-agent: ChatGPT-User
User-agent: Claude-User
User-agent: Perplexity-User
Disallow: /admin/
Disallow: /private/

# --- Search engines: allowed, minus the utility paths ---
User-agent: Googlebot
User-agent: Bingbot
Disallow: /admin/
Disallow: /private/

# --- Everyone else ---
User-agent: *
Disallow: /admin/
Disallow: /private/

Sitemap: https://example.com/sitemap.xml
```

**Verify after deploying any multi-group file**, per group rather than per file — a whole-file
test answers the wrong question. In Search Console's robots.txt report, test `/admin/` as
Googlebot specifically; for the rest, confirm by reading that each named group carries the
utility lines. A file that tests clean as `*` and was never tested as a named agent has not
been tested.

**Ops checks (run for ANY stance)**:

- **Edge can override origin.** CDN/WAF layers (bot-management toggles, edge rules) can
  serve a different robots.txt or block user agents before the origin file is ever
  reached — verify the edge configuration separately from the origin file.
- **File health.** Confirm robots.txt returns HTTP 200 (not 403/404, not a redirect to an
  error page) and parses cleanly.
- **Logs are the truth.** Check the declared policy against actual bot visits in server
  logs: a "blocked" bot still fetching pages, or an "allowed" bot never visiting, means
  the policy is not doing what the file claims.

---

### 5. Allow Search Engines, Block Everything Else

```
# Block all by default
User-agent: *
Disallow: /

# Allow Google
User-agent: Googlebot
Disallow:

# Allow Bing
User-agent: Bingbot
Disallow:

# Allow DuckDuckGo
User-agent: DuckDuckBot
Disallow:

Sitemap: https://example.com/sitemap.xml
```

---

### 6. Block URL Parameters

```
User-agent: *
Disallow: /*?                    # Block all URLs with parameters
Allow: /?                        # Allow homepage with parameters

Sitemap: https://example.com/sitemap.xml
```

Prevents duplicate content from parameter variations.

---

### 7. Block File Types

```
User-agent: *
Disallow: /*.pdf$
Disallow: /*.doc$
Disallow: /*.xls$
Disallow: /*.zip$

Sitemap: https://example.com/sitemap.xml
```

---

### 8. E-commerce Configuration

```
User-agent: *
# Block search/filter pages
Disallow: /*?q=
Disallow: /*?sort=
Disallow: /*?filter=

# Block account pages
Disallow: /account/
Disallow: /cart/
Disallow: /checkout/

# Block admin
Disallow: /admin/

# Allow product pages
Allow: /products/

Sitemap: https://example.com/sitemap.xml
```

---

### 9. WordPress Configuration

```
User-agent: *
# WordPress core
Disallow: /wp-admin/
Allow: /wp-admin/admin-ajax.php

# WordPress directories
Disallow: /wp-includes/
Disallow: /wp-content/plugins/
Disallow: /wp-content/themes/

# Allow uploads
Allow: /wp-content/uploads/

# Block parameter pages
Disallow: /?s=
Disallow: /feed/
Disallow: /trackback/

Sitemap: https://example.com/sitemap_index.xml
```

---

### 10. Shopify Configuration

```
User-agent: *
# Block admin and account
Disallow: /admin
Disallow: /account
Disallow: /cart
Disallow: /checkout

# Block search
Disallow: /search

# Block collections with filters
Disallow: /collections/*+*
Disallow: /collections/*?*

Sitemap: https://example.com/sitemap.xml
```

---

## Platform-Specific Templates

### Wix

```
User-agent: *
Disallow: /_api/
Disallow: /_partials/

Sitemap: https://example.com/sitemap.xml
```

### Squarespace

```
User-agent: *
Disallow: /config/
Disallow: /search

Sitemap: https://example.com/sitemap.xml
```

### Webflow

```
User-agent: *
Allow: /

Sitemap: https://example.com/sitemap.xml
```

### Drupal

```
User-agent: *
Disallow: /admin/
Disallow: /user/
Disallow: /node/add/
Disallow: /?q=

Sitemap: https://example.com/sitemap.xml
```

---

## Testing and Validation

### Google Search Console Robots.txt Tester

1. Go to: Search Console → Settings → robots.txt
2. View current robots.txt
3. Test specific URLs
4. See which user-agents are affected

### Manual Testing

Test URL pattern: `https://example.com/robots.txt`

Check file is:
- Accessible (returns 200 status)
- Plain text format
- UTF-8 encoded
- Located at root domain
- No more than 500KB (Google limit)

### Common Testing Scenarios

Test these URLs in tester:
- Homepage: `/`
- Product page: `/products/example`
- Admin page: `/admin/`
- Parameter page: `/search?q=test`
- File: `/document.pdf`

---

## Common Mistakes and Fixes

### Mistake 1: Blocking CSS/JS Files

**Wrong**:
```
User-agent: *
Disallow: /css/
Disallow: /js/
```

**Why it's wrong**: Google needs CSS/JS to render pages properly.

**Fix**:
```
User-agent: *
Allow: /css/
Allow: /js/
```

---

### Mistake 2: Using Relative URLs for Sitemap

**Wrong**:
```
Sitemap: /sitemap.xml
```

**Fix**:
```
Sitemap: https://example.com/sitemap.xml
```

---

### Mistake 3: Spaces in Directives

**Wrong**:
```
User-agent : Googlebot
Disallow : /admin/
```

**Fix** (no spaces before colons):
```
User-agent: Googlebot
Disallow: /admin/
```

---

### Mistake 4: Forgetting Trailing Slash

**Intention**: Block /admin directory

**Wrong**:
```
Disallow: /admin
```

**Result**: Also blocks /admin-panel, /administrator, etc.

**Fix**:
```
Disallow: /admin/
```

---

### Mistake 5: Blocking Entire Site Accidentally

**Wrong**:
```
User-agent: *
Disallow: /
Allow: /blog/
```

**Why it's wrong**: Many bots don't support Allow directive.

**Fix**: Use noindex meta tags for pages you don't want indexed, not robots.txt.

---

### Mistake 6: Not Blocking Development Environments

**Wrong**: No robots.txt on staging.example.com

**Result**: Staging site gets indexed.

**Fix**:
```
User-agent: *
Disallow: /
```

On all non-production environments.

---

### Mistake 7: Case Sensitivity Errors

**Note**: Directives are case-insensitive, but paths are case-sensitive.

**Example**:
```
Disallow: /Admin/        # Blocks /Admin/ but not /admin/
```

**Fix**: Block both if needed:
```
Disallow: /admin/
Disallow: /Admin/
```

---

## Advanced Patterns

### Wildcard Examples

```
# Block all PDFs
Disallow: /*.pdf$

# Block all URLs with parameters
Disallow: /*?

# Block all URLs ending in .php
Disallow: /*.php$

# Block all admin paths regardless of location
Disallow: /*/admin/
```

### Multiple Sitemaps

```
Sitemap: https://example.com/sitemap-pages.xml
Sitemap: https://example.com/sitemap-posts.xml
Sitemap: https://example.com/sitemap-products.xml
```

### Bot-Specific Rules

```
# Aggressive bot - slow it down
User-agent: BadBot
Crawl-delay: 60
Disallow: /

# Good bots - full access except the utility paths.
# /admin/ is repeated here on purpose: this group is the only one Googlebot and
# Bingbot read, so omitting it leaves both free to crawl /admin/. See the
# one-group rule above.
User-agent: Googlebot
User-agent: Bingbot
Disallow: /admin/

# Default for others
User-agent: *
Crawl-delay: 10
Disallow: /admin/
```

---

## Robots.txt vs Meta Robots vs X-Robots-Tag

### When to use each:

**Robots.txt**:
- Block crawling of entire directories
- Reduce crawl budget waste
- Block parameter variations
- Does NOT prevent indexing if page is linked from elsewhere

**Meta robots tag**:
- Prevent specific pages from being indexed
- Control snippet display
- Control following links
- Example: `<meta name="robots" content="noindex,follow">`

**X-Robots-Tag HTTP header**:
- Control non-HTML files (PDFs, images)
- Server-level control
- Example: `X-Robots-Tag: noindex`

**Important**: If you don't want a page indexed, use noindex (meta tag or header), NOT robots.txt.

---

## Monitoring and Maintenance

### Regular Checks

**Monthly**:
- [ ] Verify robots.txt is accessible
- [ ] Check Search Console for blocked URLs
- [ ] Review crawl stats for blocked resources

**Quarterly**:
- [ ] Audit blocked paths - still relevant?
- [ ] Check for new admin/private sections to block
- [ ] Review AI crawler landscape (new bots?)

**After site changes**:
- [ ] Update robots.txt if URL structure changed
- [ ] Test new sections (should they be blocked?)
- [ ] Verify sitemaps still referenced

### Search Console Monitoring

Check these reports:
- **Coverage** → Excluded by robots.txt
- **Settings** → Crawl stats
- **URL Inspection** → Test specific URLs

---

## Robots.txt Checklist

Before deploying:

- [ ] File is named exactly `robots.txt` (lowercase)
- [ ] Located at root domain (`example.com/robots.txt`)
- [ ] Plain text format (not HTML or PDF)
- [ ] UTF-8 encoding
- [ ] No HTML tags in file
- [ ] All paths start with `/`
- [ ] Sitemap URLs are absolute
- [ ] No spaces before colons
- [ ] Tested in Search Console robots.txt tester
- [ ] Not blocking important CSS/JS/images
- [ ] Not blocking content you want indexed
- [ ] Trailing slashes used correctly for directories
- [ ] Wildcard patterns tested
- [ ] File size under 500KB

---

## Emergency Fixes

### Accidentally Blocked Entire Site

**Symptom**: All pages blocked in Search Console

**Fix**:
1. Edit robots.txt to:
```
User-agent: *
Disallow:

Sitemap: https://example.com/sitemap.xml
```
2. Test in Search Console
3. Request urgent recrawl for key pages
4. Monitor Coverage report for recovery

**Recovery time**: 1-7 days

---

### Blocked CSS/JS Files

**Symptom**: "Blocked by robots.txt" in Mobile-Friendly Test

**Fix**:
1. Add Allow directives:
```
User-agent: *
Allow: /css/
Allow: /js/
Allow: /wp-content/uploads/
```
2. Test in robots.txt tester
3. Request re-render in URL Inspection tool

---

### Staging Site Indexed

**Symptom**: staging.example.com appears in search results

**Fix**:
1. Add to staging robots.txt:
```
User-agent: *
Disallow: /
```
2. Add noindex meta tag to all staging pages
3. Remove staging URLs in Search Console (Removals tool)

---

## Resources and Tools

**Testing**:
- Google Search Console robots.txt tester
- Bing Webmaster Tools robots.txt analyzer
- Technical SEO browser extensions

**Validation**:
- https://www.google.com/webmasters/tools/robots-testing-tool
- https://en.ryte.com/free-tools/robots-txt/
- https://technicalseo.com/tools/robots-txt/

**Documentation**:
- Google: https://developers.google.com/search/docs/crawling-indexing/robots/intro
- Bing: https://www.bing.com/webmasters/help/robots-txt-validation
- Robots.txt spec: https://www.robotstxt.org/
