# Technical SEO Checker — Server-Config Fix Snippets (placement included)

Referenced from [SKILL.md](../SKILL.md). Use this file whenever the audit hands the reader a
config block — nginx, Apache, `robots.txt`, response headers.

A redirect rule with no placement is not a fix. The same three lines can redirect one URL,
never run at all, or take the whole site down, depending only on which file and which block
they land in. This file states the placement for the snippets this skill emits, and the four
mechanisms by which a pasted block breaks a site.

Every snippet below is written out on the reserved `example.com` host so it is complete as
shown. **Before delivery, substitute the audited site's real host and paths** — a snippet
handed to a client carries that site's values, never `example.com` and never a bracketed slot.

---

## 1. The paste-ready rule

A config block is deliverable only when all six are true (placement discipline,
`docs/loop/FAILURE-LEDGER.md` F13):

- [ ] **File** — which file it goes in, with the distro path (`/etc/nginx/sites-available/<site>`
      on Debian/Ubuntu, `/etc/nginx/conf.d/<site>.conf` on RHEL/Alma; `.htaccess` at the
      document root or the `<VirtualHost>` for Apache).
- [ ] **Block** — which block it goes *inside* (which `server { }`, which `location { }`), or
      that it is a new top-level `server` block in the `http` context.
- [ ] **Position** — where it sits relative to the directives already there (see §3C: order
      decides whether the rule ever runs).
- [ ] **Real values** — the audited site's hosts, paths and targets. No bracketed placeholders,
      no `TBD`, no data-needed slots, and **no confidence or provenance annotations inside the
      fence** — open questions live in the report prose around the block, never in the config.
- [ ] **Verification** — the command that proves it loaded and works (§8).
- [ ] **Rollback** — how to undo it if it does not (§8).

If a value is genuinely unknown, do not fill it with a guess and do not ship a slot: leave the
rule out of the block and name the missing input in the prose ("the redirect for the third URL
needs its current destination — send it and it drops straight in").

---

## 2. Where an nginx directive is allowed to sit

| Directive | Valid contexts | Invalid — config refuses to load |
|---|---|---|
| `server` | `http` | top level of `nginx.conf`, inside `server`, inside `location` |
| `location` | `server`, `location` | `http`, top level |
| `return` | `server`, `location`, `if` | `http`, top level |
| `rewrite` | `server`, `location`, `if` | `http`, top level |
| `add_header` | `http`, `server`, `location`, `if` in `location` | top level |

**Mechanism when the context is wrong**: nginx parses the whole configuration before it serves
anything, and a directive outside its allowed context is a parse error, not a warning —
`nginx: [emerg] "rewrite" directive is not allowed here in /etc/nginx/nginx.conf:14`. Two
different outcomes follow, and both are worth telling the reader:

- `nginx -s reload` / `systemctl reload nginx` — the master process reads the new config,
  rejects it, and **keeps running the old one**. The site stays up and the fix silently did not
  happen. The reader believes it is deployed.
- `systemctl restart nginx`, a container restart, or a host reboot — there is no old config to
  fall back to. nginx **does not start** and the site is down until someone edits the file.

This is why a bare directive is never a deliverable. A line like
`rewrite ^/old-page$ /new-page permanent;` is valid nginx and does what it says *inside a
`server` or `location` block* — handed over without that sentence, it is a coin flip between a
working redirect, a dead rule, and a server that will not come back up on its next deploy.

---

## 3. Four ways a pasted redirect takes a site down

### A. A catch-all redirect inside the block that serves the canonical host

```nginx
# BROKEN EXAMPLE — DO NOT DEPLOY. This block redirects the canonical host to itself.
server {
    listen 443 ssl;
    server_name www.example.com;
    return 301 https://www.example.com$request_uri;
}
```

**Mechanism**: every request to `www.example.com` is answered with a 301 back to
`www.example.com` — the same URL, because `$request_uri` is unchanged. The browser follows,
gets the same 301, and stops at its redirect limit: `ERR_TOO_MANY_REDIRECTS` on every page of
the site, including the homepage. Crawlers see an infinite redirect and drop the URLs.
**Correct form**: the host/scheme redirect belongs in the blocks that serve the *other* hosts
(§4, blocks 1 and 2); the canonical block never redirects itself.

### B. The right directive in the wrong context

```nginx
# BROKEN EXAMPLE — DO NOT DEPLOY. `rewrite` is not allowed at the http/top level.
http {
    rewrite ^/old-page$ /new-page permanent;
}
```

**Mechanism**: §2 — `[emerg] "rewrite" directive is not allowed here`; the config does not load,
and the next restart leaves nginx down. **Correct form**: §4 — an exact-match `location` inside
the canonical `server` block.

### C. A rule placed below a block-wide `return`

```nginx
# BROKEN EXAMPLE — DO NOT DEPLOY. The location below is unreachable.
server {
    listen 80;
    server_name example.com www.example.com;
    return 301 https://www.example.com$request_uri;
    location = /old-page { return 301 https://www.example.com/new-page; }
}
```

**Mechanism**: `return` in `server` context executes during the rewrite phase, before nginx
selects a location, and it ends request processing there. The `location` block is never
reached — the per-URL redirect never fires, and the reader concludes the URL map is wrong.
**Correct form**: per-URL redirects go in the canonical HTTPS block (§4, block 3), where there
is no block-wide `return` above them. Within one block, rewrite-module directives run
top-to-bottom in the order written, so position is part of the instruction.

### D. A loop "fixed" from one side only

```nginx
# BROKEN EXAMPLE — DO NOT DEPLOY. The opposite rule is still in the file.
location = /returns  { return 301 https://www.example.com/returns-policy; }
# ...and 40 lines further down, from last year:
location = /returns-policy { return 301 https://www.example.com/returns; }
```

**Mechanism**: A→B while B→A survives is still A→B→A→B — the loop the audit reported, moved,
not removed. **Correct form**: delete the opposite-direction rule in the same change, and say
in the report which existing line has to go. Then confirm with the chain check in §8 that the
final URL answers `200`.

---

## 4. Placement-complete redirect skeleton (nginx)

Three server blocks: one for HTTP, one for the non-canonical HTTPS host, one for the canonical
host that serves the site. Per-URL redirects live in the third.

```nginx
# FILE: /etc/nginx/sites-available/example.com   (RHEL/Alma: /etc/nginx/conf.d/example.com.conf)
# This snippet ADDS blocks 1 and 2 and ADDS the marked lines to block 3.
# It does not replace the application config already inside block 3.

# --- Block 1: HTTP, both hosts -> one hop to canonical HTTPS. Nothing else belongs here. ---
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;
    return 301 https://www.example.com$request_uri;
}

# --- Block 2: HTTPS on the non-canonical host -> one hop to the canonical host. ---
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name example.com;
    ssl_certificate     /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;
    return 301 https://www.example.com$request_uri;
}

# --- Block 3: HTTPS on the canonical host — the site itself. ---
server {
    listen 443 ssl;
    listen [::]:443 ssl;
    server_name www.example.com;
    ssl_certificate     /etc/letsencrypt/live/example.com/fullchain.pem;
    ssl_certificate_key /etc/letsencrypt/live/example.com/privkey.pem;

    # ADD: audited per-URL redirects, above the existing location / block.
    # One exact-match location per moved URL. Absolute target on the canonical
    # host, so the visitor lands on the final URL in a single hop.
    location = /old-page { return 301 https://www.example.com/new-page; }

    # KEEP: the site's existing root, index, location / and application blocks, unchanged.
}
```

Notes that decide whether this works on a given site:

- **Exact match.** `location = /old-page` matches that one URL. `location /old-page` (no `=`)
  is a prefix match and would also move `/old-page-archive` and `/old-page/sub`.
- **Absolute target on the canonical host.** A relative target (`return 301 /new-page;`) keeps
  the scheme and host of the block it fired in — from a non-canonical block that produces a
  second hop, which is the redirect chain the audit exists to remove.
- **`$request_uri` carries the original path and query string.** Use it for host/scheme
  redirects; never append anything to it.
- **Query strings on per-URL redirects.** `return 301 https://www.example.com/new-page;` drops
  the query string. Keep it with `return 301 https://www.example.com/new-page$is_args$args;`
  when the old URL is linked with tracking parameters.
- **`rewrite` vs `return`.** Prefer `return` in an exact-match `location`. Use `rewrite` only
  for pattern moves (a whole directory, a slug scheme), inside a `server` or `location` block,
  with the `$` anchor so it cannot broad-match siblings.

### Collapsing an audited chain

A chain (`http://example.com/x` → `https://example.com/x` → `https://www.example.com/x` →
final) is not fixed by adding a rule; it is fixed by making the first hop point at the final
URL. Blocks 1 and 2 above already do that for host/scheme chains — one hop from any entry
point. Where the final destination is a *different path*, add its exact-match location to block
3 as well, so the old printed URL reaches the final page in one redirect.

---

## 5. Security headers (nginx) — placement and two cautions

```nginx
# FILE: same file, INSIDE block 3 (the canonical HTTPS server), at server level,
# above the location blocks. HTTPS blocks only — never in the port-80 block.
add_header Strict-Transport-Security "max-age=31536000" always;
add_header X-Content-Type-Options    "nosniff"          always;
add_header Referrer-Policy           "strict-origin-when-cross-origin" always;
```

- **Inheritance gotcha**: nginx inherits `add_header` from the enclosing level *only if the
  current level declares no `add_header` of its own*. A `location` block that sets any single
  header therefore loses all the server-level ones for that path — repeat them there. Check
  every `location` in the file before reporting the headers as deployed.
- **HSTS is hard to undo**: browsers cache `max-age` and will refuse plain HTTP for the whole
  period. Confirm HTTPS works on every path first; add `includeSubDomains` only once every
  subdomain is HTTPS; if unsure, ship a short `max-age` (e.g. `300`), verify, then raise it.
  Never send HSTS over plain HTTP — it is ignored there by specification.
- `X-XSS-Protection` is a legacy control: the browser XSS auditors it drove were withdrawn, and
  current guidance is to omit the header or send `0`, with Content-Security-Policy as the live
  protection `[VERIFY vendor-primary at next sweep — browser-support status compiled 2026-08-10
  from the author's knowledge, not re-checked against a browser-vendor source]`. Report a missing
  CSP as its own finding rather than folding it into a header list — a CSP has to be built
  against the site's own asset hosts, so it is never a paste-ready line.

---

## 6. Apache equivalents

```apache
# FILE: .htaccess at the document root (or the site's <VirtualHost> block).
# Position: above any RewriteRule that already rewrites the same path.
RedirectMatch 301 ^/old-page$ https://www.example.com/new-page
```

- `Redirect 301 /old-page https://www.example.com/new-page` (mod_alias) matches by **prefix**:
  it also moves `/old-page-archive` and everything under `/old-page/`. Use `RedirectMatch` with
  `^...$` when the audit found exactly one moved URL.
- `.htaccess` is read per request and only where `AllowOverride` permits it; if the host
  disables it, the same lines go in the `<VirtualHost>` and need a reload.
- A syntax error in `.htaccess` returns **500 on every page under that directory** — Apache's
  equivalent of §2's breakage, and the reason §8's verification step is not optional.

---

## 7. robots.txt and meta-robots snippets

The same rule applies to non-config artefacts: state the file (`/robots.txt` at the domain
root, not in a subdirectory), state that it replaces the current file in full or names the
lines to change, and keep provenance out of the file body — a `#` comment explaining a
Disallow is fine; "Confidence: Hypothesis" inside a delivered `robots.txt` is not.
See [robots-txt-reference.md](./robots-txt-reference.md) for the directive syntax and the
AI-crawler stances.

---

## 8. Verify, then roll back if needed

```bash
# 1. Before any reload — parses the config and checks every directive's context.
nginx -t

# 2. Graceful reload; a failed config leaves the running one in place (see §2).
systemctl reload nginx        # or: nginx -s reload

# 3. One hop or a chain? Follow it and read only the status and location lines.
curl -sSIL https://example.com/old-page | grep -iE '^HTTP/|^location:'

# 4. Headers actually sent by the canonical host.
curl -sSI https://www.example.com/ | grep -iE 'strict-transport|x-content-type|referrer-policy'
```

Expected in step 3: exactly one `301` line followed by the final `200`. Two or more `301`s means
the chain survived; a repeating `location:` means §3A or §3D.

**Rollback**: keep the previous file (`cp example.com example.com.bak` before editing), and roll
back with `cp example.com.bak example.com && nginx -t && systemctl reload nginx`. For Apache,
rename `.htaccess` back. State this line in the report — the developer who pastes at 18:00 on a
Friday is the reader this file is written for.

---

## 9. What goes in the prose, not in the fence

Inside the code fence: the site's real hosts, paths and targets, and `#` comments that state
file, block and position. Nothing else.

In the report prose around the fence: the confidence label for each finding the block fixes,
what was not checked, which existing lines have to be deleted, and what the developer should
send back after deploying (the `curl` output from §8) so the audit can confirm the fix landed.
