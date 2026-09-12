# Cluster Ownership — Assigning Every Cluster a Property and a URL

Reference detail for Step 9 (Create Topic Clusters — and Assign Each One an Owner) of the main
workflow. The library-wide convention, including the five property roles in full, the collision
signals and the resolution ladder, is in
[query-cluster-ownership.md](../../../references/query-cluster-ownership.md); this file states
what the *keyword research* run has to produce.

**Clustering without assignment produces a plan two properties can both act on.** A cluster is a
demand; an owner is the single page that demand is meant to reach. Where a business runs one site
the assignment is a one-line answer and takes a few seconds. Where it runs a main brand site plus
microsites, leaving the cell empty is how two of its own URLs end up on one query — splitting the
links, the behavioural signal and the reporting, and leaving the client without a stated answer to
"which page is this for?".

---

## 1. What This Run Owes

Every cluster this skill produces carries three things before it leaves the report:

1. **An owning property** — one domain.
2. **An owning URL** — one absolute URL, or `to be created` with a date.
3. **A status** — `assigned`, `contested`, or `no owner assigned`.

`no owner assigned` is a legitimate value and a **finding**: it is written into the cell *and*
named in the report prose, with what it would take to settle it. A blank cell is neither a value
nor a finding — it is the reader assuming somebody else handled it.

**This run proposes; the client decides.** The skill states the assignment it recommends and the
reasoning behind it. An assignment with no decision date is a proposal, and the report says so in
those words rather than presenting a recommendation as a settled fact. Once the client decides,
the date and the decider go in the register and the assignment stops being this run's opinion.

---

## 2. The Ownership Register

One row per cluster. It is read by the operator and by the client, so it carries no internal run
handles, no framework item IDs, no repository paths and no tool-category placeholders — only
things the client can act on.

| Column | Content | Rule |
|---|---|---|
| **Cluster ID** | Short stable handle | Never changes once assigned; briefs and reports refer to it |
| **Cluster name** | Plain language, the client's own vocabulary | What a person in the business would call this demand |
| **Representative queries** | 3–8 head and torso queries or prompts | The cluster's extent, not its whole tail |
| **Language** | el / en / both | Two rows where the owning URL differs by language, one row where it does not (§4) |
| **Intent** | informational / commercial / transactional / navigational | Drives which property should own it |
| **Buying stage** | problem-aware / solution-aware / brand-aware / decision | Drives the content type |
| **Owning property** | One domain | Exactly one |
| **Owning URL** | One absolute URL | Exactly one. `to be created` is a valid value and carries a date |
| **Supporting properties** | Domains plus the angle each takes | May be empty |
| **Status** | assigned / contested / `no owner assigned` | `contested` is a defect and is reported as a finding |
| **Decided** | Date and who decided | Empty means this row is a proposal, not a decision |

A cluster whose owning URL does not exist yet is **assigned and pending** — that is a plan, and it
is the normal output of keyword research feeding a content programme. A cluster with two owners is
**contested**, which is a defect and does not ship as a plan.

### Where the register sits in the deliverable

The register is a section of the keyword research report, not an annex. Every other table that
names a cluster — the opportunity table, the cluster breakdowns, the content calendar — carries
the owning property and URL beside the cluster, or the words `no owner assigned`. A keyword list
that names a cluster and not its destination has moved the hardest decision downstream to whoever
writes the brief.

---

## 3. Deciding Which Property Should Own It

**The owner is the property with the commercial conversion path for that intent — not the one that
currently ranks.** A page that ranks and cannot convert is winning the wrong race, and moving a
ranking is a smaller job than building a conversion path where none exists. This is the whole of
the primary test; the tie-breakers below only run when two properties both clear it.

Tie-breakers, in order. Stop at the first that separates them:

1. **Existing authority for the cluster** — links, citations, coverage already published, history.
2. **Audience fit** — the property this cluster's buyers already use.
3. **Maintenance reality** — the property that will actually be kept current. A cluster assigned
   to a site nobody updates is assigned to a page that will decay.

The property roles decide most assignments before the tie-breakers are needed: a category or
product microsite owns its category's commercial and transactional clusters; an editorial or
advice property owns problem-aware and informational clusters and never transactional ones,
because a citation landing where a buyer cannot buy is a dead end; a campaign site owns only
offer-specific and campaign-navigational queries and never evergreen demand, which it strands when
the campaign closes; the main brand site owns brand and company-entity queries, cross-category
comparison, and anything with no better-fitting property. The full table, including what each role
may never own: [query-cluster-ownership.md](../../../references/query-cluster-ownership.md) §4.

**Where a property has no distinct commercial purpose, audience and query territory, do not assign
it a cluster and do not propose standing one up.** The test is one sentence: *what can a buyer do
here that they cannot do on the main site?* "Rank for a second set of the same keywords" is not an
answer to it, and building on that answer is a prohibited tactic —
[prohibited-tactics.md](../../../references/prohibited-tactics.md) entries 1 and 2.

### When this run cannot decide

Three honest outcomes, all better than a guess:

| Situation | What the row says | What the prose says |
|---|---|---|
| No property list was supplied | `no owner assigned` | Which properties would have to be listed for the assignment to be made |
| Two properties both have a claim and the conversion path is not visible from the data supplied | `no owner assigned`, with both candidates named | The two candidates, the test that separates them, and what to send — the conversion path on each |
| Two properties are already targeting it | `contested` | Both URLs, the signals that show it, and the proposed resolution as a finding for the client to approve |

---

## 4. Bilingual Clusters

The Greek market served here has two audiences, not one language with two spellings: Greek-speaking
users, and English-speaking residents, visitors, investors and international buyers in Greece. The
register's **Language** column carries that distinction, and it interacts with the four-form Greek
pattern in [greek-keyword-coverage.md](./greek-keyword-coverage.md) in exactly one way:

- **Forms (a) accented Greek, (b) unaccented Greek and (c) Greeklish are three ways of typing one
  demand in one language.** They are one cluster and they take one owner between them. None of the
  three is a reason for a second page, a second row in the register, or a second property — where
  each form may be placed is decided by that file's placement rules, and none of those placements
  is a separate destination.
- **Form (d), the EN equivalent, is the one that can be a second row**, because it serves a
  different audience rather than a different keyboard.

Whether (d) becomes a second row is decided by the URL, not by the language:

| Case | Rows | Register |
|---|---|---|
| The el audience and the en audience are served by **different URLs** | Two | Two rows, same cluster name, `Language: el` and `Language: en`, each with its own owning URL. Each row's supporting-properties cell names the other where they link |
| **One URL** serves both audiences — a single bilingual page, or a brand or navigational query where there is only one destination | One | One row, `Language: both`, one owning URL |

**Worked example — two rows.** Cluster *holiday-home buying, Crete*. The Greek row's
representative queries are «αγορά εξοχικού στην Κρήτη» and «εξοχικές κατοικίες Κρήτη»; the English
row's are "buying a holiday home in Crete" and "Crete property for foreign buyers". The two
audiences need different evidence — one needs the legal and tax path for a resident buyer, the
other the process for a non-resident — so they resolve to different URLs, and that is two rows with
two owning URLs, each linking to the other as a language alternate.

**Worked example — one row.** Cluster *company name, navigational*. Greek and English searchers
who type the company name are both going to the same place; there is one destination, so there is
one row, `Language: both`, owned by the main brand site's homepage.

**The trap this closes**: a bilingual cluster split into two rows whose owning URL is the same page
is not two clusters — it is one cluster written twice, and the second row will be read downstream
as licence to build a second page. If the URL is the same, the row is the same.

---

## 5. What This Run Does Not Do

- **It does not decide.** It proposes, with reasoning, and the register carries the decision only
  once the client has made it.
- **It does not run the full collision screen.** Detecting that two properties are already on one
  cluster is a coverage question with its own six signals; keyword research raises the flag when
  the evidence is in front of it — two properties with the same cluster in their plans, or two of
  the client's URLs known to be targeting one query — and the finding routes on for the screen.
- **It does not touch anything live.** No property is retired, redirected or altered on this run's
  initiative. A contested cluster ships as a finding with a proposed resolution for the client to
  approve.

---

## 6. Checklist

- [ ] Every cluster has an owning property and an owning URL, or `no owner assigned`
- [ ] Every `no owner assigned` appears in the prose as a finding, with what would settle it
- [ ] Every proposed assignment states its reasoning: the conversion path, then the tie-breaker
      that decided it if one was needed
- [ ] Every row with no decision date is described as a proposal, not as a decision
- [ ] Bilingual clusters are one row where one URL serves both audiences, two where the URLs differ
- [ ] Greek forms (a)–(c) never split a cluster and never justify a second page
- [ ] No cluster is assigned to a property that has no distinct purpose, audience and territory
- [ ] The register carries nothing the client cannot read and act on
