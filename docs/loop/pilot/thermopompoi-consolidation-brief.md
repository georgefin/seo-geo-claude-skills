# θερμοπομποί — audit consolidation brief

**For Sani. Two things: what is already known from the crawl we hold, and how the Dropbox audit
folder gets merged into it.**

---

## 1. The folder is not reachable from here, and that is a fact about the machine, not a refusal

Requested: `…/SHARED/SEO-GEO-AUDITS/_by-category/thermopompoi`

That is a macOS path in a Dropbox tree. This session runs in a Linux container in the cloud —
there is no `/Users` directory on it at all, so the folder cannot be opened, listed, or read from
here. No setting changes that; it is not a permissions problem.

**Two routes, either works:**

| Route | What you do | What happens |
|---|---|---|
| **A — run it where the files are** *(recommended)* | Paste §4's prompt into a Claude Code session on the Mac Studio, in a clone of this repository | The consolidation runs against the real folder, with this library's skills loaded |
| **B — bring the files here** | Attach the audit files to this conversation, or commit them into the repo under `docs/loop/pilot/thermopompoi-audits/` | I run the consolidation in this session |

Route A is better for a folder of any size, and it keeps client audit material off a public
repository — which `PILOT.md`'s own default asks for.

---

## 2. What is already established, before any audit file is read

The pilot crawl (`pairing-analysis-2026-08-13.md`) covers **17 surfaces** on the live category:
5 heater product pages, 8 accessories, 1 towel rail, 2 category pages, 1 blog post. Five findings
below are derivable from that crawl alone and do not wait on the folder.

### 2.1 The seed term is in the H1 of exactly one of five heater pages

`θερμοπομπ*` appears in **title, meta and an H2** across the heater set — and in an **H1 only on
P5** (Atlantic F120 WiFi Connect). P1, P2, P3 and P4 do not carry it in their H1 at all.

This is the single highest-value structural finding in the crawl, and it is cheap to fix. The H1
is the page's one unambiguous statement of what it is about; four of five pages currently answer a
different question than the one people search.

### 2.2 Four pages stack a second schema type, which this library bans

| Page | Types emitted | The problem |
|---|---|---|
| P4 Atlantic F119 | Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject **+ FAQPage, AggregateOffer** | FAQPage on a page whose accurate type is Product |
| P5 Atlantic F120 | same **+ FAQPage, AggregateOffer** | same |
| P15 category | CollectionPage, **FAQPage**, ItemList, Organization, WebSite | three plausible primaries competing |
| P17 blog post | Article, **FAQPage**, WebPage | FAQPage on an article |

**Ruling R2**: one accurate primary type per page. A second full content type is stacking, and it
adds nothing — the extra type does not make the page eligible for anything it was not already
eligible for.

**And after today's R3 correction, the FAQPage on these pages earns nothing on the SERP either.**
Google restricted FAQ rich results to well-known government and health websites on **2023-08-08**;
for every other site, in Google's words, *"this rich result will no longer be shown regularly."*
Sani Hellas is not a government or health site. So the stacked FAQPage on P4, P5, P15 and P17 is
neither a rich-result play nor a permitted second type.

**What to do**: keep the visible Q&A — it answers real customer questions and earns the content
credit on its own. Drop the FAQPage object from these four. For **P15 the category page**, the one
primary type is **`ItemList`** with the five products as `itemListElement` (the e-commerce row
added to the benchmark on 2026-08-13), with a real BreadcrumbList and the seller Organization
nested inside — not sitting beside it as a competing top-level object.

### 2.3 Two category pages have no canonical tag

P15 (`/el-gr/thermansi-thermopompoi/`) and P16 (`/el-gr/thermansi-aksesouar/`) both lack a
canonical, and P15 additionally has **facet duplicates** — filter combinations generating separate
URLs for the same set of products. A category with facets and no canonical is the classic way a
five-product class turns into dozens of competing URLs.

### 2.4 Four accessory pages ship byte-identical meta descriptions

P9, P10, P12 and P13 carry the same boilerplate meta. P6 and P7 carry a different meta, duplicated
between the two of them. **P11 is the only accessory with a unique one** — which shows the fix is
routine, not blocked.

P16 goes further: it carries the **site-wide default meta and zero structured data**.

### 2.5 Two defects that will look like nothing and cost real clicks

- **P2's meta description stores an emoji as `??`** — the client's own database is mangling the
  character, so the mangled form is what a searcher sees. It is also **over length** at 220
  characters.
- **P1/P2 carry a name collision and a wrong slug.** Two distinct NOBO products are not cleanly
  distinguished, and a wrong slug is a permanent wrong address.

### 2.6 What the crawl deliberately does NOT answer

**Traffic.** `PILOT.md` defines "comparable" with three limbs — topic class, traffic band, and
template. The crawl answers two. **Word count is used as a page-size proxy and is labelled as one
every time; it is not the protocol's criterion and cannot substitute for it.** Any ranking of
these findings by *business* value needs a 12-week Search Console export, which only you can pull.

---

## 3. How the audit files get merged — the method, so the result is reproducible

When the folder is reachable, the consolidation runs this way. This is written down so the answer
does not depend on which session runs it.

**Step 1 — inventory before judgement.** List every file, its date, and what it claims to cover.
Do not read for findings yet. A folder of audits usually contains several passes over the same
pages at different dates, and the merge is worthless if a stale finding outranks a fresh one
because it was read first.

**Step 2 — extract findings atomically.** One finding per row: page/URL, what is wrong, the
evidence given, the date, and the source file. **A finding with no stated evidence is recorded as
a claim, not a finding** — that distinction is what this library spent today learning the hard
way.

**Step 3 — reconcile against the crawl, not against each other.** The 17-surface crawl is observed
data with a date. Where an audit file disagrees with it, the crawl wins for anything structural
(schema types, canonicals, meta length, H1 content) unless the audit is more recent *and* says how
it looked. Where an audit asserts something the crawl cannot see — traffic, rankings, competitor
positions — it is kept only with its source named.

**Step 4 — deduplicate by (page × defect class), not by wording.** The same defect described three
ways is one finding. Keep the clearest statement, carry the earliest date it was observed and the
latest date it was confirmed.

**Step 5 — rank, and state the ranking's basis.** Two axes only:
- **Confidence**: observed in the crawl / stated with evidence / asserted without evidence.
- **Reach**: how many of the 17 surfaces it touches.

Anything ranked by expected traffic gain must name where the traffic figure came from. **If there
is no figure, the finding is ranked by reach and confidence and says so** — no invented uplift
percentages.

**Step 6 — cut hard.** The instruction is *keep the most important*. A consolidated list of 60
findings is a list nobody will act on. Target the top 10–15, with everything else preserved in an
appendix rather than deleted, so nothing is lost and the top of the list is actionable.

**Step 7 — two outputs, different readers.** A client-facing summary in plain Greek with no
framework item IDs, no skill names, no repo paths; and an operator sheet carrying the IDs and
provenance. Root `CLAUDE.md`'s Reader Test governs the split.

---

## 4. Prompt for the Mac Studio (Route A) — paste this verbatim

> In a clone of `seo-geo-claude-skills`, with the SEO/GEO skills available, consolidate the audit
> folder at
> `~/Library/CloudStorage/Dropbox/Dropbox docs/WEBSITES/Claude/MASTER_PROJECT/SHARED/SEO-GEO-AUDITS/_by-category/thermopompoi`
>
> Follow `docs/loop/pilot/thermopompoi-consolidation-brief.md` §3 exactly — inventory first,
> extract findings atomically, reconcile against `docs/loop/pilot/pairing-analysis-2026-08-13.md`
> (17 crawled surfaces, observed 2026-08-13), deduplicate by page × defect class, rank by
> confidence and reach, cut to a top 10–15 with the rest in an appendix.
>
> Binding rules from this repo, which override anything the audit files say:
> - **Ruling R2** — one accurate primary type per page. Flag every stacked type.
> - **Ruling R3 as corrected 2026-08-13** — Google restricted FAQ rich results to government and
>   health sites on 2023-08-08. Claim no FAQ rich result for this site. Claim **no** AI-citation
>   benefit for FAQPage markup in either direction; no primary source establishes one.
> - **Never assert engine behaviour as fact.** Say what a change puts on the page.
> - **No invented figures.** A traffic or uplift number with no named source does not ship; name
>   the missing input instead.
> - **Two outputs** — a Greek client summary carrying no framework IDs, skill names or repo
>   paths, and an operator sheet carrying them.
>
> Write the result to `docs/loop/pilot/thermopompoi-consolidated-<date>.md`, do not push, and
> report what you dropped and why.

---

## 5. What this brief cannot tell you

Nothing here has read a single file in that folder. §2's findings come from the crawl, not from
the audits, and the audits may contain findings that overturn them — **§3 step 3 exists precisely
so that a fresher, evidenced audit can win.** If the consolidation contradicts §2, the
consolidation is probably right and §2 should be corrected rather than defended.

---

*Prepared 2026-08-13. No live page was touched and nothing was published. No register was
modified. `PILOT.md`'s publication gate is unaffected: nothing goes live without a per-change
approval naming the pages.*
