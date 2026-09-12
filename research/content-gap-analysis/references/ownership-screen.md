# The Ownership Screen — Is This Gap Actually a Gap?

Reference detail for Step 5 (Map Topic Gaps) of the main workflow, and binding on every finding
that ends in "create a page". The library-wide convention — the register's columns, the property
roles, the resolution ladder — is in
[query-cluster-ownership.md](../../../references/query-cluster-ownership.md).

**A gap is a demand nobody of the client's serves. A cluster an existing URL already owns is not a
gap, whatever the coverage matrix says about the property you were looking at.** Recommending a new
page for an owned cluster puts two of the client's own URLs on one demand: the links, the
behavioural signal and the reporting split, and the client is left without an answer to "which page
is this for?". That recommendation is a collision proposal wearing a gap's clothes, and it is the
most expensive mistake this skill can make, because it is delivered as a plan and executed.

---

## 1. The Screen

Run it on every gap before it becomes a recommendation to create a page. Three questions, in order:

1. **Which cluster would the new page own?** Name it. A recommendation that cannot name the cluster
   it will own is a topic idea, not a gap finding, and it does not enter the prioritised list.
2. **Is that cluster already owned by an existing URL of the client's?** Check the ownership
   register. Where there is no register, see §5.
3. **If it is owned, is this a deliberate reassignment?** A reassignment is legitimate and is
   stated in full (§4). Anything else stops here.

The outcomes, and what each one ships as:

| What the screen finds | It is | What ships |
|---|---|---|
| No client URL owns the cluster | A gap | The gap finding, naming the cluster the new page will own |
| An existing URL owns it and is thin, shallow or off-angle | A **depth gap**, not a missing page | Work on the owning URL — the honest and most common outcome |
| An existing URL owns it and covers it adequately | Not a gap | Drop the finding, or report it as coverage the analysis initially read as missing and why |
| An existing URL owns it and the recommendation is still to build a second one | A **collision proposal** | Rewrite it as a reassignment (§4), or withdraw it |
| Two of the client's URLs already target it | A **collision that already exists** | A collision finding with a proposed resolution (§6) — this is a defect the analysis found, and it outranks most new-page work |

**Depth gaps are the honest answer more often than missing pages are**, and they are cheaper to
act on. A competitor covering a cluster the client's owning URL covers thinly is a brief for that
URL, not a brief for a new one.

---

## 2. The Six Collision Signals

Cheapest first. **No signal is conclusive on its own; two together are.** Each is an observation
from the client's own data or from a check anyone can repeat — none of them is a claim about why
any engine did anything.

| # | Signal | Where to look | What it shows |
|---|---|---|---|
| 1 | Two of the client's URLs returned for one query | Any results check, incognito, locale set | Both pages are in play on that query — direct competition between two of their own |
| 2 | Query overlap between two of their pages | Search Console by page: one query, two pages, both with impressions | Their own data shows the demand split across two of their URLs |
| 3 | Duplicate or near-duplicate titles across properties | A crawl, or a title export from the CMS | Usually the first visible symptom, and the cheapest to see |
| 4 | The recorded ranking URL flips between two of their pages across dates | Their ranking history | The position for that query is moving between two of their own URLs, whatever produced the move |
| 5 | A generated answer's cited URL is on a property that does not own the cluster | The AI visibility record — its verbatim cited URLs, read against the ownership register | The citation landed on one of their properties and not on the owner — the same defect on a generated surface |
| 6 | Two properties carry the same cluster in their content plans | The plans themselves | The cheapest catch there is: neither page exists yet, so the fix costs a conversation |

**Signal 6 is the one this skill is best placed to catch.** A content gap analysis reads plans and
inventories, so it can see a collision before either page is written — which is the only point at
which fixing it is free.

### What is not a collision

Two properties covering **adjacent** clusters with genuinely different intent and different
conversion paths, one linking to the other, is a working portfolio. A portfolio where every
property has a distinct territory shows topical adjacency everywhere and collision nowhere. Do not
report adjacency as a defect: the test is whether the two pages serve one demand, not whether they
share vocabulary.

---

## 3. Recording the Screen in the Report

Every gap that survives the screen carries, in its own row or immediately beside it:

- **The cluster it would own** — named, in the client's vocabulary.
- **Who owns that cluster today** — the owning property and URL, `no owner assigned`, or
  `unverified — no ownership register supplied` (§5).
- **The screen's outcome** — new page, depth work on the owner, reassignment, or withdrawn.

A prioritised gap list whose rows do not carry this cannot be acted on safely: whoever executes it
has no way to tell a genuine gap from a second page on an owned cluster, and the difference is
invisible once the row reaches a content calendar.

---

## 4. Deliberate Reassignment

Moving a cluster from one owner to another is legitimate — a category microsite launches, an
editorial page has been carrying transactional demand it cannot convert, a campaign site is
stranding evergreen demand. It is legitimate **when it is stated as a reassignment**, and a
reassignment states four things:

1. **The current owner** — property and URL.
2. **The proposed owner** — property and URL, with the reason: the commercial conversion path for
   that intent, then the tie-breakers (existing authority for the cluster, audience fit,
   maintenance reality) if the conversion path does not separate them.
3. **What happens to the current owner** — consolidated into the new owner, differentiated to a
   genuinely different intent and linking to it, or redirected and retired. Leaving it live and
   unchanged is not one of the three: that is the state that produces the collision.
4. **That it is the client's decision** — the analysis proposes; the register records the decision
   with a date and who made it.

A "gap" that is really a reassignment and does not say so reads downstream as licence to build a
second page and leave the first one running.

---

## 5. When There Is No Ownership Register

Common, and not a blocker. Say so, and make the smaller claim:

- The gap is reported as **unverified against ownership** — "no ownership register was supplied, so
  we could not confirm that no existing page already owns this cluster".
- **Name what would settle it**: the client's property list, and a page-and-cluster list or crawl
  for each property.
- **Do not silently assume unowned.** "Missing" is a bigger claim than the data supports, and it is
  the claim that produces the duplicate page.
- Where the inventory supplied covers only one property in a portfolio, say which properties were
  *not* looked at. A gap found by looking at one site out of six is a gap in that site's coverage,
  which is a different statement from a gap in the client's coverage.

---

## 6. Reporting a Collision You Found

A collision is a finding with a proposed resolution, an owner-role and an acceptance criterion —
the same shape as every other action this library produces
([action-output-contract.md](../../../references/action-output-contract.md)). The resolution ladder
runs in order, stopping at the first that applies: **consolidate** (one page absorbs the other's
substance, the loser redirects to the owner) → **differentiate** (the non-owner is rewritten to a
genuinely different intent and links to the owner) → **redirect and retire** → **canonical**, which
is ranked last, is a signal rather than a directive, does not resolve a cross-domain contest
reliably, and is never a substitute for the first three. Full ladder and its exclusions:
[query-cluster-ownership.md](../../../references/query-cluster-ownership.md) §6.

**Never proposed**: standing up a further property to target the same cluster, publishing the same
content on both with light rewording, or leaving both live and letting the outcome settle itself —
the last of these is the status quo that produced the collision. The first two are prohibited
tactics ([prohibited-tactics.md](../../../references/prohibited-tactics.md) entries 1 and 2). And
nothing live is altered on this analysis's initiative: it reports and proposes; the client decides.

---

## 7. Checklist

- [ ] Every recommendation to create a page names the cluster that page would own
- [ ] Every such recommendation confirms the cluster is unowned, or states the reassignment in full
- [ ] Every gap row carries the current owner, `no owner assigned`, or `unverified` with the reason
- [ ] Collisions found are reported as findings with a proposed ladder step, not as opportunities
- [ ] No collision is claimed on one signal alone; two independent signals are named
- [ ] Adjacent-but-distinct coverage is not reported as a collision
- [ ] Where no register was supplied, the report says so and names what would settle it
- [ ] Properties not examined are named, so a one-site gap is not reported as a portfolio gap
