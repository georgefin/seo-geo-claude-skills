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

> **Read §8.4 before acting on this section.** A later check found Cloudflare's AI controls
> are scoped by behaviour *category* — training crawlers separately from search and assistant
> crawlers. The alarm below is correct under a broad block (H2) and **does not hold** under a
> training-only block (H1), which is a configuration somebody may have chosen deliberately.
> §3's five agents cannot tell the two apart.

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

---

## 8. Follow-up, same day: the five agents tested were the wrong five

Commissioned by the client after §1–§7 were read, on a correct observation: **the probe in §3
tested no agent that governs live citation visibility.** GPTBot and ClaudeBot are *training*
crawlers. Whether this business is quotable in a generated answer is governed by different agents
entirely, and none of them was in the table.

### 8.1 The re-test, and what its control proves

Attempted again from this environment 2026-08-18. Both hosts refused at the same layer:

```
curl -A "…OAI-SearchBot…" https://www.sanihellas.gr/robots.txt
  -> curl: (56) CONNECT tunnel failed, response 403
curl                       https://www.kullhaus.gr/robots.txt
  -> curl: (56) CONNECT tunnel failed, response 403
```

**`kullhaus.gr` is the known-open control, and it failed identically.** A control that fails the
same way as the subject is the cleanest possible proof that the refusal is not about either site:
it is this container's egress proxy, denying `CONNECT` before a packet leaves. `WebFetch` returns
`EGRESS_BLOCKED` on the same hosts. Web *search* still works, so anything below sourced that way
is snippet-grade and marked `[VERIFY]`.

**So the eight-row table cannot be produced from here, and no amount of retrying changes that.**
What is deliverable is everything that makes the test correct when it is run on a normal network,
and that is what §8.2–§8.6 are.

### 8.2 Two of the requested user-agent strings need changing before anyone runs this

Checked against the operators' own published documentation.

| Agent | Status of the requested string | Note |
|---|---|---|
| `OAI-SearchBot` | use as given | OpenAI publishes its IP list at `openai.com/searchbot.json` |
| `ChatGPT-User` | use as given | IP list at `openai.com/chatgpt-user.json` |
| `PerplexityBot` | use as given | IP list at `perplexity.com/perplexitybot.json` |
| `Perplexity-User` | use as given | IP list at `perplexity.com/perplexity-user.json` |
| `Googlebot` | use as given | verified by reverse DNS, not a published range |
| `Claude-User`, `Claude-SearchBot` | use as given | **but see 8.3 — no published IP ranges** |
| **`Google-Extended`** | **probably untestable — `[VERIFY]`** | see below |
| — | **`OAI-AdsBot` is missing** | a fourth OpenAI agent, for ad-safety validation on ChatGPT (`openai.com/adsbot.json`). Not a citation agent; worth a row only if the client advertises there. |

**`Google-Extended` is the one to be careful with.** It is a robots.txt *product token* that
controls whether content may be used by Gemini apps and the Vertex AI Gemini API. The open
question is whether any HTTP request is ever actually sent carrying `Google-Extended` in its
User-Agent header, or whether the fetching is done under ordinary Google user agents with the
token used only as a control. **This could not be settled from here** — the page that would settle
it (`developers.google.com/crawling/...`) is `EGRESS_BLOCKED`, and a search-snippet synthesis
contradicted itself on the point. It matters practically: **if no request ever carries that
string, a row for it measures nothing, and a "clean pass" on it would be a false reassurance
about Gemini access.** Whoever runs the probe should open that page first. Gemini/Google access
is better read off the `Googlebot` row and off Search Console until this is resolved.

### 8.3 Anthropic publishes no IP ranges — which changes what "verified" can mean

The brief assumed all four operators publish crawler IP ranges. OpenAI and Perplexity do.
**Anthropic states it does not currently publish IP ranges, because its crawlers use service
provider public IPs** (its own help-centre article; `[VERIFY]` — snippet-grade, page not opened).

This is not pedantry. Cloudflare's Verified Bots allowlist admits a crawler on one of three
grounds: a published IP list, reverse DNS, or a cryptographic Web Bot Auth signature. An operator
that publishes no IP list must qualify by one of the other two. So **for the tier-4 agents, an
IP-allowlist remedy of the kind Perplexity documents for AWS WAF is not available** — the fix, if
one is wanted, is a user-agent rule or Cloudflare's own verified-bot category controls.

### 8.4 The reframe: this is a two-hypothesis test, and H1 is not an emergency

The single most useful thing found in the follow-up. **Cloudflare's AI bot controls are scoped by
behaviour category, not by vendor** — the settings block bots classified as crawling *for
training*, distinctly from bots classified as *search* or *assistant* agents (`[VERIFY]`,
Cloudflare's own bots documentation, snippet-grade).

That makes §3's result consistent with two very different worlds:

| | H1 — category-scoped training block | H2 — broad AI block |
|---|---|---|
| GPTBot, ClaudeBot (training) | hard-blocked | hard-blocked |
| OAI-SearchBot, ChatGPT-User | **challenged** | **hard-blocked** |
| PerplexityBot, Perplexity-User | challenged | hard-blocked |
| Claude-User, Claude-SearchBot | challenged | hard-blocked |
| What it means | training opted out, citation path open — **a defensible configuration somebody may have chosen deliberately** | the only property that can take an order is shut to the surfaces this engagement targets |
| What to do | confirm and leave it; possibly nothing | §7 action 2 becomes urgent |

**§3's five agents cannot tell H1 from H2** — they produce identical rows under both. The one
observed row that leans is `PerplexityBot`, an indexing agent for a *search* product, which got a
challenge rather than a wall. That is the H1 pattern. It is one row and it is not enough.

**This tempers §5.** §5 says that if the AI-crawler block is on, the citation risk "becomes the
arrangement". That holds under H2. **Under H1 it does not hold at all**, and §5 should be read as
conditional on which control is enabled, not on whether any is. The alarm in §5 was pitched at the
worse of two readings before the category distinction was known.

### 8.5 What no probe run from anywhere can settle

Every request in §3, and every request the script in §8.6 will send, is **unverified**: a claimed
user-agent string from an arbitrary IP, carrying no published-range address, no matching reverse
DNS and no Web Bot Auth signature. Cloudflare's Verified Bots allowlist exists precisely to
distinguish those from real crawlers, and **a verified bot can be waved past a challenge that
every unverified impostor receives.**

So, stated plainly, and this governs every row of every table in this file:

- A `challenged` row **does not show** that the real OAI-SearchBot, ChatGPT-User, PerplexityBot
  or Claude-User is challenged. It may well not be.
- A `hard-blocked` row does not show the real crawler is blocked either — though a user-agent
  string match is the likelier mechanism there, since the string is the only thing that varied.
- **What the table measures is user-agent-string matching at the edge**, and the finding is always
  the *difference between rows*, never a row on its own.

**The gap cannot be closed from outside**, because nobody outside those operators can originate
traffic from their addresses. **Cloudflare's Bot Analytics is the only source of truth**, because
it logs verified crawlers, by category, as they actually arrive. That is a dashboard the zone
administrator can open; it is not a thing this library can measure, now or later.

### 8.6 The probe is written and committed, ready to run elsewhere

`scripts/crawler-access-probe.sh` — 11 agents × 2 paths × both hosts, emitting exactly the
requested table with the priority tier on each row, plus `cf-mitigated`, `server`, byte count and
a verdict. `kullhaus.gr` runs as the control in the same pass.

**Its smoke test found a defect worth naming, because it is the defect the client would have hit.**
Run from this container, the first version reported **`HARD-BLOCKED` on all eleven agents** — a
catastrophic-looking false finding, produced entirely by our own proxy's `403` to `CONNECT` being
parsed as the origin's `403`. A second row returned a stray `200` and read as `clean pass`. Both
are now caught by two guards: a verdict is only ever given when curl exits 0 **and** the response
carries a `server:` or `cf-ray:` header proving it came from the origin's edge; anything else is
reported as a transport fault against the machine running the probe. A preflight line at the top
of the output says so outright when the runner has no internet at all.

**Anyone running it from behind a corporate proxy or VPN would have got the same page of false
alarms.** The guard is the reason the script is worth having rather than a liability.

The caveat in §8.5 is printed by the script as part of its own output, beneath the table, so that
a table pasted into a report cannot arrive without it.

### 8.7 Actions

| # | Action | Owner | Acceptance criterion |
|---|---|---|---|
| 7 | Run `scripts/crawler-access-probe.sh` from an ordinary connection; confirm the preflight line is absent before reading any verdict | Library operator, or client web team | The 4 output tables are pasted into this file as §9, dated, with the preflight banner absent |
| 8 | Open Cloudflare **Bot Analytics** for the `sanihellas.gr` zone and read verified-bot traffic by category over 30 days | Client decision — needs zone admin | Request and block counts for OAI-SearchBot, ChatGPT-User, PerplexityBot, Claude-User and Googlebot, dated, by 2026-08-25 |
| 9 | Settle whether `Google-Extended` is ever sent as an HTTP User-Agent, or is control-only | Library operator | The Google crawler documentation page is read and quoted here; the probe row is kept or struck accordingly |
| 10 | Decide H1 vs H2 from actions 7 + 8 together, and record which | Client decision | A dated line in this file naming H1 or H2, and whether §7 action 2 is now urgent or closed |

**Nothing has been changed on any property.** §8 is a re-test that failed for network reasons, a
documentation check, and a script. No setting was altered and no page edited.
