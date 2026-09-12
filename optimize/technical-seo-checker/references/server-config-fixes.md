# Technical SEO Checker — Server-Config Fix Snippets (placement included)

Referenced from [SKILL.md](../SKILL.md). Use this file whenever the audit hands the reader a
config block — nginx, Apache, `robots.txt`, response headers.

A redirect rule with no placement is not a fix. The same three lines can redirect one URL,
never run at all, or take the whole site down, depending only on which file and which block
they land in. This file states the placement for the snippets this skill emits, and the five
mechanisms by which a pasted block breaks a site.

Every snippet below is written out on the reserved `example.com` host so it is complete as
shown. **Before delivery, substitute the audited site's real host and paths** — a snippet
handed to a client carries that site's values, never `example.com` and never a bracketed slot.

---

## 1. The paste-ready rule

A config block is deliverable only when all seven are true (placement discipline,
`docs/loop/FAILURE-LEDGER.md` F13):

- [ ] **File** — which file it goes in, with the distro path (`/etc/nginx/sites-available/<site>`
      on Debian/Ubuntu, `/etc/nginx/conf.d/<site>.conf` on RHEL/Alma; `.htaccess` at the
      document root or the `<VirtualHost>` for Apache).
- [ ] **Block** — which block it goes *inside* (which `server { }`, which `location { }`), or
      that it is a new top-level `server` block in the `http` context.
- [ ] **What is already there** — where a block for that listener already exists, the audit
      reads it first and the delivered version keeps every `location` exception it carries,
      naming each preserved exception and why in the report prose. Where the existing config
      could not be read, the deliverable says so and hands over an **addition to be merged by
      whoever holds the config — never a replacement**. See §3E: the exception that made
      certificate renewal work is the one most often deleted this way.
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

## 3. Five ways a pasted redirect takes a site down

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

### E. A port-80 block replaced wholesale, taking the certificate-renewal path with it

```nginx
# BROKEN EXAMPLE — DO NOT DEPLOY as a replacement for a live port-80 block.
# Nothing here is wrong as nginx. What is wrong is what it does not carry.
server {
    listen 80;
    server_name example.com www.example.com;
    return 301 https://www.example.com$request_uri;
}
```

**Mechanism**: this is the block an audit reaches for when HTTP does not redirect to HTTPS, and
handed over as *"replace your existing port-80 block with this"* it deletes every `location` the
old block carried. The one that matters is the ACME challenge exception. A certificate issued
over the HTTP-01 challenge is renewed by the same route: the certificate authority requests
`http://<each name on the certificate>/.well-known/acme-challenge/<token>` on port 80, and a
webroot-mode client (`certbot --webroot`, `acme.sh -w`, most panel integrations) answers by
writing the token file into a directory the port-80 block serves. Delete the `location` that
served it and the token is no longer reachable at that path.

State the failure precisely, because overclaiming it is its own defect: **the 301 is not itself
the break.** On the record this library holds, Let's Encrypt follows redirects during HTTP-01
validation, which would mean a challenge request redirected to HTTPS still validates *if the
token is served at the end of the redirect*
`[VERIFY vendor-primary at next sweep — redirect-following during HTTP-01 recorded from the
blind-run analysis of 2026-08-17, docs/loop/eval-baselines/blind-2026-08-17, not re-checked
against a CA-primary source]`. The break is that it usually is not: the redirect sends the
challenge path to the HTTPS application block, which serves the site's own document root and
answers `404` for a token the ACME client wrote somewhere else entirely. Note what this means for
the fix — the carve-out below is correct whichever way that verification lands, because it keeps
the token reachable without depending on redirect-following at all.

Two properties make this the worst item in this section. It is **silent** — nothing changes at
deploy, the site serves normally, and the failure surfaces at the next renewal: on a 90-day
certificate, 60–90 days later, long after anyone connects it to this change. And it is
**invisible to the ordinary verification step** — `curl -sSIL https://example.com/` returns
exactly the one 301 and the 200 the audit asked for, so the report says the fix landed. Where the
same audit also reports the certificate's expiry date, or asks the client to confirm that renewal
is automatic, it is asking about the mechanism the block it just handed over may have removed.

**Correct form**: three things, and the first two are not substitutes for each other.

1. **Read the existing port-80 block before writing a new one** and keep every `location` it
   carries — challenge paths, health checks, `.well-known` endpoints of any kind (`security.txt`,
   Apple and Android app-association files), ACL blocks. Name each preserved exception in the
   report prose. Where you cannot read it, hand over an addition to be merged by whoever holds
   the config and say plainly that it is not a replacement (§1).
2. **Ship the challenge exception inside the block itself**, above the redirect — §4, block 1.
   A warning in the prose around the fence does not survive the paste.
3. **Verify against a challenge path, not the site root** — §8, step 5. A check that only
   requests `/` cannot see this failure mode.

---

## 4. Placement-complete redirect skeleton (nginx)

Three server blocks: one for HTTP, one for the non-canonical HTTPS host, one for the canonical
host that serves the site. Per-URL redirects live in the third.

**Step 0, before any of them — read what is on the server now.** `nginx -T` prints the whole
running configuration, included files and all; `grep -n 'listen .*80' -A30` over its output shows
every port-80 block and what each one contains. The blocks below are written as if none exists.
**Where one already exists, this is an edit to that block, not a second block beside it** — two
`server` blocks with the same `listen` and `server_name` leave nginx serving the first and
logging a conflict, and deleting the old one loses whatever it carried (§3E).

```nginx
# FILE: /etc/nginx/sites-available/example.com   (RHEL/Alma: /etc/nginx/conf.d/example.com.conf)
# This snippet ADDS blocks 1 and 2 and ADDS the marked lines to block 3.
# It does not replace the application config already inside block 3.
# NOR does it replace a port-80 block that already exists: read that block first
# (`nginx -T`), keep every `location` in it, and change only the redirect line.

# --- Block 1: HTTP, both hosts -> one hop to canonical HTTPS, with the certificate
#     challenge path served rather than redirected. Nothing else belongs here. ---
server {
    listen 80;
    listen [::]:80;
    server_name example.com www.example.com;

    # KEEP THIS, AND KEEP IT FIRST. HTTP-01 certificate renewal fetches its token from
    # this path on port 80; a block-wide redirect over it is how a renewal breaks 60-90
    # days after this paste (see this file's section 3E). `^~` so no regex location can
    # take the path back. The `root` is COPIED from the port-80 block already on the
    # server, or from the ACME client's own webroot setting (`certbot --webroot -w ...`,
    # `acme.sh -w ...`) — it is a value to read off the server, never one to guess.
    # Harmless when renewal runs some other way (DNS-01, TLS-ALPN-01, a proxy in front).
    location ^~ /.well-known/acme-challenge/ {
        root /var/www/example.com/public;
    }

    # The redirect sits in `location /`, NOT at server level: a server-level `return`
    # runs before nginx selects a location (section 3C) and the exception above would
    # never be reached.
    location / {
        return 301 https://www.example.com$request_uri;
    }
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

- **The challenge `root` in block 1 is read off the server, never chosen.** It has to be the
  directory the ACME client writes into, which is the existing block's own challenge `location`
  or the client's `-w` / `--webroot-path` setting. If that value cannot be read, the block-1
  redirect is not deliverable as a replacement at all: hand over the exception as an addition to
  merge into the existing block, and say in the prose which value you need back (§1, §3E).
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

### The Apache HTTP → HTTPS redirect, with the same carve-out

§3E is not an nginx property — it is a property of any blanket port-80 redirect, so the Apache
form carries the exception too, in the same fence:

```apache
# FILE: .htaccess at the document root (or the site's <VirtualHost *:80>).
# Position: at the top of the rewrite rules, above any other RewriteRule.
# Read the file first: keep any rule already there that exempts a path, and keep any
# existing Alias for the challenge directory. This ADDS rules; it replaces nothing.
RewriteEngine On

# KEEP THIS CONDITION. HTTP-01 certificate renewal fetches its token from this path over
# plain HTTP; without the exemption the redirect below takes it (see section 3E). The
# condition is evaluated with the ones under it, so it stays directly above the rule.
RewriteCond %{REQUEST_URI} !^/\.well-known/acme-challenge/
RewriteCond %{HTTPS} off
RewriteRule ^ https://www.example.com%{REQUEST_URI} [R=301,L]
```

- `mod_alias`'s `Redirect / https://www.example.com/` has **no exemption syntax** — it matches by
  prefix and takes every path under it, challenge path included. Where a site-wide HTTP → HTTPS
  redirect is the fix, it is a `mod_rewrite` job for that reason alone.
- `%{HTTPS}` needs `mod_ssl` loaded to be meaningful; behind a terminating proxy or load balancer
  the value to test is the forwarded-protocol header the proxy sets, and which header that is has
  to be read off the proxy rather than assumed.

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

# 5. THE CERTIFICATE-RENEWAL PATH (§3E). Run wherever a port-80 block was added or edited.
#    Steps 1-4 all pass while this one fails, which is the whole reason it is written down.
#    Drop a probe file in the challenge directory, on the server, then read it back over
#    plain HTTP on every hostname the certificate covers:
mkdir -p /var/www/example.com/public/.well-known/acme-challenge
echo renewal-probe > /var/www/example.com/public/.well-known/acme-challenge/probe
curl -sSi http://example.com/.well-known/acme-challenge/probe     | head -1
curl -sSi http://www.example.com/.well-known/acme-challenge/probe | head -1
rm /var/www/example.com/public/.well-known/acme-challenge/probe
```

Expected in step 3: exactly one `301` line followed by the final `200`. Two or more `301`s means
the chain survived; a repeating `location:` means §3A or §3D.

Expected in step 5: **`HTTP/1.1 200 OK` from both hostnames, no `-L`, no redirect.** A `301` or
`302` on either line is the §3E failure sitting in the config right now — the one failure in this
section that costs a certificate rather than a redirect, and the only one the other four steps
cannot see. Put the exception in before going further. Two things it does not settle, both worth
saying in the report: a `200` on the probe shows the path is served, not that the ACME client writes into that
same directory; and where `certbot` is the client, `certbot renew --dry-run` exercises the real
validation against the staging endpoint and is the check that settles both at once — name it as
the acceptance criterion when certbot is what the site runs, and where renewal is handled by a
panel, a proxy or a host you cannot see, say that the step-5 probe is as far as the check reaches
and hand the renewal check to whoever holds that system.

**Rollback**: keep the previous file (`cp example.com example.com.bak` before editing), and roll
back with `cp example.com.bak example.com && nginx -t && systemctl reload nginx`. For Apache,
rename `.htaccess` back. State this line in the report — the developer who pastes at 18:00 on a
Friday is the reader this file is written for.

---

## 9. What goes in the prose, not in the fence

Inside the code fence: the site's real hosts, paths and targets, and `#` comments that state
file, block and position. Nothing else.

In the report prose around the fence: the confidence label for each finding the block fixes,
what was not checked, which existing lines have to be deleted, **which `location` exceptions the
delivered block preserves from the block already on the server and what each one is for** (§3E),
whether the block is an edit or an addition to be merged by whoever holds the config, and what
the developer should send back after deploying (the `curl` output from §8, step 5 included) so
the audit can confirm the fix landed.
