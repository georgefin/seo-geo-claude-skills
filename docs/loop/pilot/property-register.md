# Property register — Sani Hellas

**Stated by the client 2026-08-18.** This is the estate of record. It supersedes any earlier
reading, including the "six properties, four URL grammars" note in the pilot files and any
assumption that the estate is a single site.

`references/query-cluster-ownership.md` is the governing rule. This file is the register that rule
requires and that `CLIENT-MANDATE.md` §4 recorded as missing.

---

## 1. The estate

| Property | Role | Sells? | Conversion path |
|---|---|---|---|
| **`www.sanihellas.gr`** | **eshop — the commercial property** | **Yes** | **Yes — the only one** |
| `www.noboadvantage.gr` | brand site | No | No |
| `www.atlantic-heating.gr` | brand site | No | No |
| `www.kullhaus.gr` | brand site | No | No |
| `www.kullhaus.com` | brand site — **status undecided, see §4** | No | No |
| `www.glamoxheating.gr` | **proposed, not yet created — see §4** | No | No |
| `www.meaco.gr` | brand site | No | No |

**The client's own words for the brand sites**: *"micro sites or brand websites, not selling, not
eshops. They are there for branding, for brand authority, knowledge authority and they have to
bring traffic to www.sanihellas.gr."*

---

## 2. What this determines — ownership is now settled, not proposed

`query-cluster-ownership.md` rule 5: *"where two properties both have a claim, the owner is the one
with the commercial conversion path for that intent, not the one that currently ranks."*

**Exactly one property has a conversion path. Therefore `sanihellas.gr` owns every commercial
cluster.** This is determined by the estate's structure, not by a judgement call, and it does not
need re-litigating per cluster.

**Informational and brand-authority clusters may legitimately be owned by a brand site** — where
the intent is genuinely not commercial. Those are assigned per cluster and each assignment states
why the intent is not commercial.

### The brand sites are support properties, and that is a legitimate structure

They are **not** the prohibited "duplicate microsite". `query-cluster-ownership.md` rule 3's test —
*what can a buyer do here that they cannot do on the main site?* — is met: a brand site carries
manufacturer-level depth, brand authority and knowledge authority that a category page on an eshop
cannot carry without becoming a different kind of page.

**But rule 4 binds them, and it has three conditions, all of which must hold:**

1. a different angle or intent from the owner's;
2. an in-body link to the owning URL;
3. **no targeting of the owner's head query in title, H1 or schema.**

**Fail any one and the property is competing, not supporting.** That is the audit every brand site
needs, and it has not been run.

---

## 3. The consequence nobody has costed — authority is what gets cited

These sites exist to build authority. **On an AI surface, authority is exactly what gets cited.**

`query-cluster-ownership.md` rule 2: in a generated answer there is typically **one** cited source,
so one property takes the citation and the other takes nothing — **and the winner may be the
property with no conversion path.**

So the structural risk is specific and it is the inverse of the usual one: **a brand site doing its
job perfectly could win the citation and lose the sale.** A buyer asking an assistant which
dehumidifier to buy gets an answer citing `kullhaus.gr`, which cannot sell them one.

This is not an argument against the structure. It is an argument for two things the register must
carry:

- **every brand site links in-body to the owning `sanihellas.gr` URL** — rule 4 condition 2 is not
  bureaucracy here, it is the only mechanism that converts a brand-site citation into a sale;
- **the AI-visibility measurement records which property was cited** — field 5 of
  `references/ai-visibility-measurement.md` requires cited URLs verbatim, not domains, precisely so
  *"they cited our brand site instead of our product page"* is visible as a finding rather than
  averaged away.

---

## 4. Open — two decisions the client still owes

**`kullhaus.com` vs `kullhaus.gr`.** Two properties on one brand name, both indexable, is the
collision case. The resolution ladder is *consolidate → differentiate → retire → canonical*, with
canonical ranked **last** because it looks like a fix while leaving both properties competing.
Three real options: `.com` becomes the international/English property with its own territory ·
`.com` redirects to `.gr` and the equity consolidates · `.com` is parked and de-indexed. **What it
cannot be is left running as a second Greek-language brand site.**

**`glamoxheating.gr` — not yet created, and the prior question is whether it should be.** Rule 3's
test applies before the domain choice: what can a buyer do there that they cannot do on an existing
property?

**The brand-ownership check this section asked for has now been run, and it corrected the premise.**
The earlier note here said *"Nobo is a Glamox brand"*. That is wrong, and it was recall, which is
why it was flagged. What the check returned:

| Brand | Group | Evidence grade |
|---|---|---|
| Nobo | **Glen Dimplex**, acquired 2002 (NOBO Electro, Stjørdal) | `[VERIFY]` — four independent 2002 press reports |
| Glamox Heating | manufactured by **Adax AS**; Adax acquired by **Glen Dimplex in 2023** | `[VERIFY]` — Adax's own about page; Glen Dimplex lists both brands |

`[obs:2026-08-18 web search only — glamox.com, gdhv.com and en.wikipedia.org are all
EGRESS_BLOCKED from this environment, so no source page was opened. Snippet-grade, not primary.]`

**The conclusion survives; the reasoning does not.** Nobo and Glamox Heating do sit in one group —
but that group is **Glen Dimplex, not Glamox** — so the original worry (two properties splitting
one group's authority in one product category) still stands, and now stands on a fact rather than
on a misremembered one. Both brands make electric panel heaters, which is the actual overlap.

**And the check surfaced a second problem the earlier note did not see.** "Glamox" as a search term
principally denotes **Glamox ASA, a large Norwegian lighting company** — a different business from
the heating brand. A property at `glamoxheating.gr` would be competing for an entity name it does
not own, against an established company in another category. That is an entity-disambiguation
problem, not a keyword problem, and it does not exist for Nobo, Kullhaus, Atlantic or Meaco.

So the decision now has three parts, in order: **(a)** does Glamox Heating cover a product line
Nobo does not — if not, a section on `noboadvantage.gr` is the better structure and no domain is
needed; **(b)** if it does, is the entity collision with Glamox ASA acceptable; **(c)** only then
the URL. *(Both rows above should be confirmed against the manufacturers' own pages before money is
spent — this environment cannot open them.)*

---

## 5. What this register still does not carry

Per cluster: the owning URL, the support property, and the support property's non-competing angle.
Those are produced by the keyword research now in flight and land here when it does.

**And the rule-4 audit has not been run on any brand site.** Until it has, we know the structure is
sound in intent and nothing about whether it holds in the markup.

**It cannot be run from here.** Every client domain is `EGRESS_BLOCKED` from this environment —
`www.noboadvantage.gr` was tried on 2026-08-18 and refused at the network layer, same as
`www.sanihellas.gr`. The audit needs either a browser on the client's side or an execution
environment with a wider network policy. See `tooling-assessment-2026-08-18.md` §4.1.

**One URL already in our evidence should be first in the queue when it can be run.** The 17 August
inventory recorded `noboadvantage.gr/nobo-heaters-prices/` — a **prices** path on a property with
no conversion path. Prices are commercial intent, and rule 4 condition 3 forbids a supporting
property from claiming the owner's head query in title, H1 or schema.

*What we are not saying:* we have not opened that page and do not know what is on it. A page named
for prices may carry an RRP table, a "where to buy" pointer, or nothing of the kind. The finding is
that **this is the single most likely condition-3 breach in the estate and it is checkable in two
minutes**, not that a breach has occurred. It is also the exact shape §3 warns about: the property
that wins the citation is the one that cannot take the order.
