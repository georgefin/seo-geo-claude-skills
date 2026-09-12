# Linking Follows Ownership — Owner Targets, Support Links, Cross-Property Links

Reference detail for Step 4 (Create Topic Cluster Link Strategy) and Step 5 (Find Contextual Link
Opportunities). The library-wide convention — the ownership register, the property roles, the
resolution ladder for a contest — is in
[query-cluster-ownership.md](../../../references/query-cluster-ownership.md). This file states what
a linking plan has to do about it.

**A link is a destination decision.** Where a cluster has one owning URL, every internal link for
that cluster is a vote the client casts for that destination, and casting them at two of their own
pages is how a portfolio ends up with the demand split across its own URLs. A linking plan that
does not know which URL owns a cluster is guessing at the one thing it exists to decide.

---

## 1. The Owner Is the Target

- **A cluster's internal links point to its owning URL.** Not to whichever page currently ranks,
  not to the newest page, not to the one the writer had open.
- **The pillar of a cluster is its owning URL**, unless the register says otherwise and says why.
  Where a plan's pillar and the register's owning URL differ, that is a finding, not a preference:
  raise it, propose which one moves, and do not quietly link to both.
- **One destination per cluster, in every surface this skill touches** — body links, navigation
  entries, breadcrumb targets, related-content modules, and any hub or index page.

---

## 2. The Support Test — All Three, or It Is Competing

A page that does not own a cluster may still cover it, in a support role. It supports when **all
three** of these hold:

| # | Condition | How to check it | Fails when |
|---|---|---|---|
| 1 | **A different angle or intent** | Read the two pages' purposes side by side. One problem-aware guide and one commercial page is a difference; two commercial pages for one demand is not | Both pages serve the same intent for the same audience |
| 2 | **An in-body link to the owning URL, with descriptive anchor text** | The link is in the copy, not only in a template menu or footer, and the anchor names the destination | The link is template-only, absent, or carries a content-free anchor ("read more", "click here", a bare URL) |
| 3 | **It does not target the owner's head query** in its title, H1, or schema | Read the three fields. The head query is the cluster's primary query, as the register records it | The head query, or a near-duplicate of it, appears as the page's own title, H1 or schema target |

**Fail any one of the three and the page is competing, not supporting.** There is no partial
credit: two out of three is a competing page with a courtesy link on it. Report it as a collision
finding with a proposed resolution (§5), not as a linking opportunity — adding more links to a
competing page makes the split worse, and the plan that added them will be read as having endorsed
it.

**Condition 3 does not ban the head query from the supporting page's body**, and it does not ban it
from the anchor text pointing at the owner. A supporting page may say the words and link them to
the owner; what it may not do is claim them in the fields that declare what the page itself is for.

---

## 3. Cross-Property Linking

A portfolio's support relationships cross domains. In HTML terms a link from one of the client's
properties to another is an external link, and a crawler or a backlink tool will report it as one —
but both ends belong to the client, so it is governed by this rule and not by anything to do with
link acquisition. It is not an earned link, it is not reported as one, and it is never part of a
link-building count.

**The pattern**, one row per link, the same four fields every suggestion in this skill carries
(source page, target page, anchor text, placement), plus two more that only cross-property links
need:

| Extra field | Why it exists |
|---|---|
| **Source property / target property** | Both domains named. A reader of the plan has to see at a glance that this link leaves one site and lands on another |
| **Who can implement it** | A cross-property link needs edit access to the *source* property. That is often a different team, a different agency, or a different CMS, and a plan that does not say so produces a task nobody picks up |

**Four rules for the cross-property links themselves:**

1. **They point one way — supporter to owner.** The owner does not link back on the same head
   query. Two properties linking to each other on one demand is the collision, drawn as an arrow in
   both directions.
2. **They are in body copy, with descriptive anchors.** A site-wide footer link between properties
   is a network element, not a support link, and it satisfies no condition in §2.
3. **They are useful to the reader who clicks.** The test is the reader's: someone on the
   supporting page has a reason to want the owner's page next. A link that only exists to move
   equity is the thing entry 4 of
   [prohibited-tactics.md](../../../references/prohibited-tactics.md) is about, and it is not
   improved by both properties being the client's.
4. **They are counted separately** in every figure this skill prints. A page's inbound-link count,
   the average links per page, the orphan test: all of them are per-property populations. State
   which property a count belongs to, and state cross-property links as their own line rather than
   folding them into a site's internal total. Both readings are legitimate; only one of them can be
   printed under an unqualified label.

**Never proposed here**: a second property stood up to hold links, the same content published
across properties with light rewording, or a reciprocal cross-property scheme. The first two are
prohibited tactics; the third is the collision with a handshake.

---

## 4. When the Cluster Has No Owner

Where the register reads `no owner assigned`, or where no register exists:

- **Say so, and plan no cluster links for it.** A link needs a destination the client has settled
  on, and choosing one silently makes an ownership decision inside a linking deliverable — which is
  where nobody will look for it later.
- **Name what would settle it** — the property list, and which page each cluster is meant to reach.
- **Orphan work is not blocked by this.** A page with no inbound links of any kind is a reachability
  defect and is fixed regardless of which cluster it belongs to; the fix links it from somewhere
  sensible and says the cluster assignment is still open.
- **Do not infer the owner from the current link graph.** The page with the most inbound links is
  the page that was linked to most, which is the output of past decisions, not evidence about what
  should own the cluster.

---

## 5. Reporting a Collision Found During a Link Audit

Link audits surface collisions cheaply — two pages with near-duplicate titles, two pages the same
sources link to with the same anchor, a cluster whose links fork. Report it as a finding with a
proposed resolution, an owner-role and an acceptance criterion, the same shape as every other
action ([action-output-contract.md](../../../references/action-output-contract.md)).

The row carries: both URLs · the cluster · which of them the register says owns it (or that none
does) · the evidence seen in the link graph · the proposed ladder step. The ladder runs
**consolidate → differentiate → redirect and retire → canonical**, stopping at the first that
applies, with canonical last because it is a signal rather than a directive and does not resolve a
cross-domain contest reliably
([query-cluster-ownership.md](../../../references/query-cluster-ownership.md) §6).

**This skill proposes; it never alters a live property on its own initiative**, and it does not
recommend leaving both pages live and unchanged — that is the state that produced the finding.

---

## 6. Anchor Text for Owner-Directed Links

The anchor rules in [score-rubric.md](./score-rubric.md) apply unchanged: descriptive, naming the
destination, conversational where that reads better, never content-free. Two additions where the
target is a cluster owner:

- **Vary the anchors across the supporting pages**, and let them name the destination in the
  supporting page's own terms. Ten pages linking to one owner with one identical exact-match string
  is the over-optimisation pattern the Anchor Score already marks down, and it is not made
  acceptable by the target being the correct one.
- **The anchor may use the head query**; the supporting page's own title, H1 and schema may not.
  That is condition 3 of §2, and it is the line between a supporting page and a competing one.

---

## 7. Checklist

- [ ] Every cluster in the plan names its owning URL, or says the owner is unassigned
- [ ] Every cluster link in the plan points at that owning URL
- [ ] Every supporting page is checked against all three conditions, and the check is shown
- [ ] A page failing any one condition is reported as a collision, not as a linking opportunity
- [ ] Cross-property links name both properties and who can implement them
- [ ] Cross-property links are one-way, in body copy, and useful to the reader who clicks
- [ ] Cross-property links are counted on their own line, never folded into a site's internal total
- [ ] Collisions carry both URLs, the evidence, the proposed ladder step and an acceptance criterion
- [ ] No link is planned for a cluster whose destination the client has not settled
