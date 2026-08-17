# Query-Cluster Ownership — Skills Reference

> The convention is stated in the repo's root `CLAUDE.md`, section **One Owner Per Cluster**. This
> file is its carrier — the shipped statement a skill can read at run time. `CLAUDE.md` is a repo
> context file, not part of the installed skill surface, so a rule that lives only there is a rule
> the running library does not carry.
>
> **Sister references**: [AI Visibility Measurement](./ai-visibility-measurement.md) — field 6
> ("owning property matched") is read against the register defined here ·
> [Prohibited Tactics](./prohibited-tactics.md) — duplicate microsites are the failure mode this
> file's rule prevents · [Action Output Contract](./action-output-contract.md) — how a conflict
> becomes an owned action.

**A property portfolio without an ownership register does not have a strategy; it has a
collision.** When a brand runs a main site plus microsites, the same buyer intent is reachable from
several of its own properties. Left unassigned, two of the client's own URLs compete for one
demand — they split link equity, split behavioural signal, and give a generative engine two
candidate sources for one answer, from which it picks one and the client does not control which.

---

## 1. The Rule

**Every query cluster has exactly one owning property and exactly one owning URL.** The assignment
is written into the register (§3) **before** content is commissioned, not inferred afterwards from
whatever happens to rank.

Three consequences, all binding:

1. **One URL is the target.** Other pages may cover the topic; only one is optimised to win it,
   linked to as the destination, and named in schema, internal links and outreach.
2. **Non-owning properties may cover the cluster only in a support role** (§4) — a different angle,
   a different intent, and an internal link to the owner.
3. **Ownership is stated in every deliverable that touches the cluster** — audits, content briefs,
   keyword lists, and the AI-visibility rows in `references/ai-visibility-measurement.md` §3.

**The register is the client's decision, recorded.** A skill proposes an assignment with its
reasoning; it does not invent one silently, and where the client has not decided, the cell reads
`no owner assigned` and the gap is named in prose. That value is a finding, not a blank.

---

## 2. Why This Matters More on AI Surfaces Than in Ranked Lists

In a ranked list, two of your own URLs competing costs you a position and some equity — bad, and
survivable. A generated answer has room for far fewer sources than a results page has rows, so two
competing properties do not split a position the way they split a ranking: **whichever one is used
takes the citation and the other takes nothing** — and the one that is used may be the property
with no conversion path.

That is an argument from the shape of the output, not a claim about how any engine chooses. Nothing
here asserts a selection mechanism; the observable fact is that the client's own record shows a
citation landing on one property and not the other (field 6 of the visibility record), and the
remedy is the same whatever the mechanism turns out to be.

This is why field 6 of the visibility record exists: "cited, but the wrong property" is a distinct
and common finding, invisible to any metric that only asks whether the client was cited at all.

---

## 3. The Ownership Register

One row per cluster. This is an operator and client-strategy artefact; it is legible to both.

| Column | Content | Rule |
|---|---|---|
| **Cluster ID** | Short stable handle | Never changes once assigned; content and reports refer to it |
| **Cluster name** | Plain language, client's vocabulary | What a person would call this demand |
| **Representative queries** | 3–8 head and torso queries or prompts | The cluster's extent, not its whole tail |
| **Language** | el / en / both | A bilingual cluster is two rows where the owning URL differs, one row where it does not |
| **Intent** | informational / commercial / transactional / navigational | Drives which property should own it |
| **Buying stage** | problem-aware / solution-aware / brand-aware / decision | Drives the content type |
| **Owning property** | One domain | Exactly one |
| **Owning URL** | One absolute URL | Exactly one. `to be created` is a valid, dated value; a bracket token is not |
| **Supporting properties** | Domains + their angle | May be empty |
| **Status** | assigned / contested / `no owner assigned` | `contested` triggers §6 |
| **Decided** | Date + who decided | An assignment with no decision date is a proposal |

A cluster whose owning URL does not yet exist is **assigned and pending**, which is a plan. A
cluster with two owners is **contested**, which is a defect.

---

## 4. Property Roles

Multi-property portfolios are not a set of equals. Each property has a commercial purpose, an
audience, and a query territory, and the role determines what it is allowed to own.

| Role | Commercial purpose | Owns | Never owns |
|---|---|---|---|
| **Main brand site** | Trust, breadth, conversion for the full catalogue | Brand queries, company entity queries, cross-category comparison, anything with no better-fitting property | — |
| **Category / product microsite** | Depth and conversion in one category | That category's commercial and transactional clusters, its product and model queries, its spec long-tail | Brand-entity queries; another category's clusters |
| **Campaign / seasonal site** | One offer, one window | Offer-specific and campaign-navigational queries only | Any evergreen cluster — a campaign site owning evergreen demand strands it when the campaign ends |
| **Editorial / advice site** | Problem-aware demand, authority, citation surface | Informational and problem-aware clusters | Transactional clusters — it has no conversion path, so a citation there is a dead end |
| **Local / store site** | Geographic demand, footfall, service | Location-qualified clusters | Non-local clusters of any kind |

**A property with no distinct commercial purpose, audience and query territory is not a microsite.**
It is a duplicate, and standing one up is a prohibited tactic — see
[Prohibited Tactics](./prohibited-tactics.md). The test is answerable in one sentence: *what can a
buyer do here that they cannot do on the main site?* "Rank for a second set of the same keywords"
is not an answer.

### 4.1 The support relationship

A non-owning property covering an owned cluster satisfies all three:

1. **A different angle or intent** — the editorial site's «πώς διαλέγω αφυγραντήρα» supports, and
   does not compete with, the category site's «αφυγραντήρες — αγορά».
2. **An internal link to the owning URL**, in the body, with descriptive anchor text.
3. **It does not target the owner's head query** in its title, H1, or schema.

Fail any of the three and it is competing, not supporting.

---

## 5. Detecting a Collision

Six signals, cheapest first. None is conclusive alone; two together are.

| Signal | Where to look | What it means |
|---|---|---|
| Two client URLs for one query | Any SERP check, incognito | Direct competition |
| Search Console query overlap | GSC by page, two pages, same query, both with impressions | The engine is undecided between them |
| Duplicate or near-duplicate titles across properties | Crawl or title export | Usually the first visible symptom |
| The ranking URL flips between two of the client's pages across dates | Ranking history | Classic split signal |
| An AI answer cites the non-owning property | Visibility record field 6 | The GEO form of the same defect |
| Two properties both have the cluster in their content plan | The plans themselves | Cheapest catch of all — before either is built |

**What is not a collision**: two properties covering adjacent clusters with genuinely different
intent and different conversion paths, one linking to the other. A portfolio where every property
has a distinct territory will show topical adjacency everywhere and collision nowhere.

---

## 6. Resolving a Contest

In order. Stop at the first that applies.

1. **Consolidate** — one page absorbs the other's substance; the loser 301s to the owner. Default
   where both pages serve the same intent for the same audience.
2. **Differentiate** — the non-owner is rewritten to a genuinely different intent or stage, and
   links to the owner. Only where a real distinct demand exists; rewriting a title while keeping
   the same target is not differentiation.
3. **Redirect and retire** — where the non-owner has no distinct purpose and nothing worth
   absorbing.
4. **Canonical** — only where both URLs must exist for a non-SEO reason (a syndication, a
   partner requirement). It is a signal, not a directive, and it does not resolve a cross-domain
   contest reliably. Ranked last for that reason, and never used as a substitute for 1–3.

**Never**: stand up a further property to target the same cluster; publish the same content on both
with light rewording; or leave both live and "let the engine decide". The third is the status quo
that produced the contest.

### 6.1 Deciding the owner

Where two properties both have a plausible claim, the owner is the one with **the commercial
conversion path for that intent** — not the one that currently ranks better. A page that ranks and
cannot convert is winning the wrong race, and moving the ranking is a smaller job than building a
conversion path where none exists.

Tie-breakers, in order: existing authority for the cluster (links, citations, history) → audience
fit (the property this cluster's buyers already use) → maintenance reality (which property will
actually be kept current).

---

## 7. Output Rules

- Every keyword list, content brief, gap analysis and audit that names a cluster names its owning
  property and URL, or states `no owner assigned` and flags it.
- A recommendation to create a page states which cluster it will own and confirms that cluster is
  unowned or is being deliberately reassigned.
- A contested cluster is reported as a finding with the resolution ladder step proposed, an owner,
  and an acceptance criterion — see [Action Output Contract](./action-output-contract.md).
- The register itself is client-read: it carries no run handles, no framework item IDs and no
  `~~category` tokens.
