# The shop may be closed to the crawlers the strategy depends on

**Observed 2026-08-18.** First live reads of the estate since the pilot began. This file is the
record; `technical-entity-assessment-2026-08-17.md` and `keyword-research-thermopompoi-afygrantires-2026-08-18.md`
are unchanged by it except where §5 says so.

**How these pages were reached.** Not from this environment — every client domain is
`EGRESS_BLOCKED` here (`tooling-assessment-2026-08-18.md` §4.1). They were read through an agent
running on a third party's infrastructure (§4.2), which is a second model reporting on a page rather
than a direct crawl. Grade accordingly: HTTP status codes and response headers are strong evidence;
"what the page contains" is one notch below a direct read.

---

## 1. The asymmetry, stated first

| Property | Sells? | `robots.txt` on AI crawlers | Edge behaviour observed |
|---|---|---|---|
| `noboadvantage.gr` | No | **explicit `Allow: /`** for GPTBot, ChatGPT-User, ClaudeBot, PerplexityBot, Google-Extended, Applebot-Extended, cohere-ai | reachable |
| `kullhaus.gr` | No | **explicit `Allow: /`** for ~16 named agents incl. GPTBot, ClaudeBot, OAI-SearchBot, PerplexityBot | reachable |
| `meaco.gr` | No | **explicit `Allow: /`** incl. Claude-User, Claude-SearchBot, OAI-SearchBot | reachable |
| `atlantic-heating.gr` | No | **explicit `Allow: /`** for 14 named agents | reachable |
| **`www.sanihellas.gr`** | **Yes — the only one** | permissive, but **names no AI crawler at all** | **every test request refused at the edge** |

Somebody deliberately configured four brand sites to welcome AI crawlers by name. That work was done
and it is good work. **The property it was done to support is the one that refused every request.**

---

## 2. What `sanihellas.gr/robots.txt` actually says

Retrieved through a browser after clearing a Cloudflare challenge — a plain fetch of this file
returns 403, so the file itself is behind the challenge.

```
Sitemap: https://www.sanihellas.gr/Files/sitemap.xml
Sitemap: https://www.sanihellas.gr/Files/blog-sitemap.xml

User-agent: *
Disallow: /*orderby=
Disallow: /*direction=
```

**Nothing here blocks anything.** The two `Disallow` lines suppress sort-order facet parameters, which
is ordinary good practice and unrelated. No AI crawler is named, so all of them fall under `*` and are
permitted.

**So permission is not the problem, and no robots.txt edit fixes this.** The refusal happens at a
bot-management layer *in front of* the origin, which robots.txt does not govern.

---

## 3. The edge test, and its result

Five requests to `https://www.sanihellas.gr/el-gr/thermansi-thermopompoi`, varying only the
`User-Agent` header. All five carried `server: cloudflare` and a `cf-ray:` header.

| User-Agent sent | HTTP | `cf-mitigated` | What came back |
|---|---|---|---|
| `GPTBot/1.0` | 403 | *absent* | **Hard block** — "Attention Required! \| Cloudflare". No challenge to solve. |
| `ClaudeBot/1.0` | 403 | *absent* | **Hard block** — same firewall page. |
| `PerplexityBot/1.0` | 403 | `challenge` | JS/Turnstile interstitial — "Just a moment…" |
| `Googlebot/2.1` | 403 | `challenge` | JS/Turnstile interstitial |
| Desktop Chrome | 403 | `challenge` | JS/Turnstile interstitial |

**Two different refusals, and the difference is the finding.** A challenge is a door with a lock — a
client that runs JavaScript can open it, which is how the page was eventually read. A hard block is a
wall: there is no challenge to solve, so no amount of capability gets through.

**GPTBot and ClaudeBot got the wall. Everything else got the door.**

---

## 4. What this does and does not establish

**This section governs how §3 may be used. Read it before quoting any of it.**

### It does not show that Google or OpenAI are blocked from the site

A request that merely *claims* in a header to be Googlebot is not Googlebot. Real GPTBot, ClaudeBot
and Googlebot originate from published IP ranges, and Cloudflare verifies them by address and reverse
DNS. **Refusing an unverified client that claims to be Googlebot is correct behaviour, not a defect** —
it is most of what a bot-management layer is for. Every row in §3 is an unverified claim, so every row
is a plausible legitimate block.

There is also direct counter-evidence for Googlebot specifically: the pilot has repeatedly observed
`sanihellas.gr` pages ranking in Greek search results. **A site Googlebot could not fetch would not
rank.** So Googlebot is getting through, and the `challenge` row above is the system working.

### What it does show

**The differential.** A layer that simply distrusts unverified clients would treat all five identically
— they are equally unverified. It did not. Two user-agent strings, both belonging to AI crawlers, were
singled out for a harder refusal than an unverified client claiming to be Googlebot.

That pattern is what a **user-agent-matching rule against AI crawlers** produces, and Cloudflare ships
exactly such a control. **The material question is whether that control is switched on, because if it
is, it applies to verified GPTBot and ClaudeBot too** — not only to the spoofed ones tested here.

**Confidence: this is a strong signal and it is not a measurement.** It is written down because the
check that settles it takes about a minute, not because it is settled.

### The check that settles it

In the Cloudflare dashboard for the `sanihellas.gr` zone: **Security → Bots**, and whether
**"Block AI Scrapers and Crawlers"** (or an equivalent custom WAF rule matching AI user-agents) is
enabled. The dashboard also carries per-crawler request and block counts, which turn all of the above
from inference into a number. **Nobody outside the account can see this**; it needs Sani or whoever
administers the zone.

---

## 5. Why this outranks everything else on the list

The engagement's goal is to be cited in generated answers. §8.7 of the keyword deliverable already
named the structural risk: one cited source per answer, so a brand site can win the citation and lose
the sale, and the in-body link is the control.

**If the AI-crawler block is on, that risk stops being a risk and becomes the arrangement.** The four
brand sites are readable by name. The shop is not. An assistant asked which dehumidifier to buy can
read `kullhaus.gr` and cannot read the page that sells one — so the brand site does not merely *win*
the citation, it is the only candidate. Every content improvement made to the shop would be invisible
to the surface the work is aimed at, and the measurement in action 8 would record the resulting zero
without being able to explain it.

**This does not change the ownership decisions.** `sanihellas.gr` still owns every commercial cluster —
it is still the only property that can take an order, and moving ownership to a property that can be
cited but cannot sell would be optimising the metric instead of the business. What changes is
sequence: **fixing crawler access comes before writing anything new**, because content the engines
cannot fetch cannot be cited no matter how good it is.

---

## 6. Two other things the same reads turned up

**`noboadvantage.gr` — the prices page fails the support test, and its URL is misspelled.**

`/nobo-heaters-prices/` redirects to `/thermompompoi-times/`. That slug reads `thermompompoi`;
«θερμοπομποί» transliterates as `thermopompoi`. **The correctly-spelled URL returns 404**, so any
citation or link using the correct spelling breaks.

Observed on the page: title «Τιμές Θερμοπομπών NOBO 2026 | Αποκλειστικός Τιμοκατάλογος» ·
**zero `<h1>` elements**, the top heading is an `<h2>` · real prices (259€, 285€, 305€, 26,50€) ·
no cart, but «Αγορά !» and «ΑΓΟΡΑ» links pointing to `sanihellas.gr` product pages.

Against rule 4's three support conditions:

| Condition | Verdict |
|---|---|
| 1. Different angle or intent from the owner | **FAILS** — a titled price list with buy buttons is transactional intent, which is the shop's |
| 2. In-body link to the owning URL | **PASSES**, and well — several descriptive links to specific shop product pages |
| 3. No claim on the owner's head term in title, H1 or schema | **FAILS** — «Τιμές Θερμοπομπών NOBO» is the head term of the brand cluster |

**Two of three fail, so by rule 4 this page competes rather than supports.** The judgement is not
that it should be deleted — it converts, which condition 2 shows it was built to do. It is that the
page should stop claiming the commercial head term in its title while the shop's own page targets it,
and that a page with no `<h1>` is under-specified regardless.

**`kullhaus.gr` and `meaco.gr` both `Disallow: /` for CCBot.** Common Crawl, which feeds many training
corpora. Legitimate as a deliberate choice; worth confirming it was one, since the same files allow
every other AI agent by name and this is the single exception.

---

## 7. What to do, in order

| # | Action | Owner | Acceptance criterion |
|---|---|---|---|
| 1 | Check whether Cloudflare's AI-crawler blocking is enabled on the `sanihellas.gr` zone, and report the per-crawler request/block counts | Client decision — needs zone admin | A dated screenshot or written statement of the Bots setting, and the block counts for GPTBot and ClaudeBot over the last 30 days, by 2026-08-25 |
| 2 | If it is enabled: decide whether to allow AI crawlers, knowing the trade — being citable requires being readable | Client decision | A dated written decision, with the setting's state after it, by 2026-08-29 |
| 3 | Re-run the five-user-agent test after any change and record it beside this one | Library operator | This file gains a second dated table; a hard block on GPTBot/ClaudeBot has become a challenge or a 200 |
| 4 | Fix the misspelled slug: serve `/thermopompoi-times/` and redirect the misspelling to it | Client web team | Both URLs resolve, the correct one returns 200, the misspelling 301s to it, by 2026-09-14 |
| 5 | Give the prices page an `<h1>`, and take the commercial head term out of its `<title>` | Client web team | The page has exactly one `<h1>`; its `<title>` no longer leads with «Τιμές Θερμοπομπών NOBO», by 2026-09-14 |
| 6 | Confirm the CCBot exclusion on the two dehumidifier brand sites was deliberate | Client decision | A written yes or no, by 2026-09-14 |

**Nothing above has been changed.** No setting was altered, no page edited, no property touched. These
are reads and a recommendation.
