# Pilot — everything waiting on you, 2026-08-12

**Nothing has been published. Nothing is staged against any live page. No live page was fetched
to write this.** Every preparable the plan names is now written and executable; what is left is
seven decisions, all yours. They are drafted as selections because that is how the last four were
answered.

**Read this first: the clock.** The programme's hard deadline is content live by **end of August**.
For the pilot's treatment pages to make that, all three inputs must clear by **2026-08-24 at the
very latest, 2026-08-17 realistically**. That is five to twelve days from today. After that the
verdict slides into December and then January.

---

## Part 1 — The three gated inputs: exactly where each one stands

### Input 1 — Named target cluster · **PART-SUPPLIED**

**Recorded and settled:** the property (`www.sanihellas.gr`), the cluster rule (every NOBO and
ATLANTIC page), the seed keyword (`θερμοπομποί`).

**What "partial" means, concretely, today** — and it has changed since the last entry:

- The cluster **has now been enumerated**: 17 GR surfaces, 0 errors, every count reconciled
  against the site's own «αποτελέσματα» figure (crawl of 2026-08-11 from the Mac Studio). The
  §0 note that "the count is unknown and matters" is stale — the count is 14 products + 2
  categories + 1 blog.
- After the exclusions, **4 pages are eligible**, forming **2 matched pairs against a floor of 3**.
- **The gap is no longer enumeration. It is that nobody has named the pilot set.** The pair
  analysis relies on "the exclusions Sani upheld", and I can find no verbatim record of that
  ruling in `PILOT.md` §0.1 or the verdict log. Under the standing rule that inputs are supplied
  only by recorded words, an exclusion set that exists only as a reference is not on the record.
- **A new problem found today, and it is the serious one.** Three of those four pages were
  already worked on in July, differently, and one of them received essentially the pilot's own
  treatment on 18-07 (F119: GEO 77 → 88). Details and sources in
  `PRIOR-INTERVENTIONS-2026-08-12.md`. Read strictly, **the number of pairs where neither page
  carries a recent documented intervention is zero.**

> ### ❓ QUESTION 1 — pick one
>
> **A.** Run on the four heater pages as they stand — 965528, 823327, 823277, 823322 — accepting
> a directional-only result on 2 contaminated pairs.
> **B.** Widen to dehumidifiers and draw all pairs from there (Tier 2b). The only option that can
> reach conventional significance; costs the heater cluster.
> **C.** Mixed — 2 heater pairs + 1 dehumidifier pair (Tier 2a).
> **D.** Four heater pages with a staggered rollout (stepped wedge) — buys a replication test
> instead of a 12-week control arm.
>
> *If A, C or D: reply with the page list so it is on the record — "the pilot set is exactly
> 965528, 823327, 823277, 823322".*

---

### Input 2 — Data access · **IN PROGRESS**

**Recorded:** *"With your guidance I will authorize the analytics connectors in my claude.ai
settings."* Guidance was issued the same day.

**What "in progress" means, concretely:** nothing has arrived. There are zero rows of GSC data in
the repository and the `data/` folder existed only as a plan until today. The finding that none of
the six declared MCP servers is a Google Search Console or GA4 server still holds, so **authorising
connectors will not by itself deliver this** — the export drop is the route. Meanwhile the service
account was re-verified 2026-07-30 and returned 8 properties, so the *access* exists; only the
*delivery* is missing.

**What it is blocking, in order of cost:**

1. The pairing itself. Two of your four comparability criteria — current traffic, current rankings
   — are unmeasured, so the two pairs are provisional. A pair matched on assumption is not a
   matched pair.
2. The pre-registration's thresholds, which are currently chosen in the dark rather than
   calibrated against this property.
3. **A free result you can have almost immediately.** F119 and F120 were both optimised on 18-07
   and the before-states are on disk. That is a before/after already 25 days old — just entering
   the window where an effect becomes visible. **One export turns it into this property's first
   real outcome numbers, with no publication and no risk.**

> ### ❓ QUESTION 2 — one export, one folder
>
> In Google Search Console for `www.sanihellas.gr`, export **two CSVs** — the **Pages** table and
> the **Queries** table — for **2025-04-12 → 2026-08-11** (the full 16-month retention, so no
> second ask is needed), with all four metrics (clicks, impressions, CTR, average position), and
> drop them in `docs/loop/pilot/data/`.
>
> Exact click-path, filename and filter rules: **`docs/loop/pilot/data/README.md`**.
> Reply "exports are in" when done.

---

### Input 3 — Publication workflow · **OPEN — no words recorded at all**

Four sub-parts, none supplied: named human publisher · approval channel · pre-change capture
method · approval-to-publish turnaround.

**What "open" means here is narrower than it sounds.** The workflow already exists in practice —
you paste into the eShopKey admin yourself, after your own per-page "save it", and the deploy
records show backups being captured before every write. It has simply never been written down
against the pilot's four sub-parts. So the smallest question is not "design a workflow", it is
"confirm the one you already use".

**Two platform facts that must be inside the answer, because they change the measurement:**

- **After a save the public page can lag hours**, per locale, with no purge and no republish
  control. So the pilot's week-0 anchor must be **the moment the change is confirmed rendered
  live**, not the moment you save. Otherwise the clock starts before Google can see anything.
- **A 200 response proves nothing on this site** — a fake URL returns 200 with the homepage
  (81,006 bytes). Every live verification has to be checked against that signature.

> ### ❓ QUESTION 3 — confirm or correct, one line
>
> *"Publication = I paste it into eShopKey admin myself, per page, after my own 'save it'.
> Approvals recorded in-session. Pre-change capture = admin source export **plus** a rendered-HTML
> fetch, both stored before any edit. Target turnaround ≤3 working days."*
>
> Reply **"confirmed"**, or name what changes.

---

## Part 2 — Four more decisions, all short

> ### ❓ QUESTION 4 — the staged NOBO fix pack collides with the pilot
>
> The pack awaiting your "save it" (`DEPLOY-RUNBOOK_06-08-2026.md`) touches exactly four records:
> **823327** (a pilot page), **965262**, **132676** and **132671** (the pilot's parent categories).
> It cannot ship inside the pilot's window without contaminating it. Pick:
>
> **A.** Ship the pack now, start the pilot baseline 28 days later. Costs ~4 weeks; verdict slips
> to January.
> **B.** Freeze the pack for ~14 weeks. Known spec defects stay live that long — a real cost, not
> a free one.
> **C.** Ship the pack and drop 823327 from the pilot. This destroys pair 1 and makes widening
> effectively mandatory.

> ### ❓ QUESTION 5 — the C1 slug fix, same question
>
> The NTL4T/NTL4R slug collision is still live (re-confirmed 2026-08-12) and its fix needs a slug
> change plus a 301 — platform-level, your call. A 301 landing mid-window next to two pilot pages
> is a confound. **Before the baseline, or frozen until after CP4?**

> ### ❓ QUESTION 6 — where the data may live
>
> This fork is **public**. Page URLs, traffic figures and baseline scores are property data.
> Default unless you say otherwise: anonymised page IDs (P1…Pn) and banded figures in the repo,
> with the ID→URL map and raw exports kept out of it. **Confirm the default, or approve raw
> in-repo data.**

> ### ❓ QUESTION 7 — the thresholds
>
> Eleven numeric parameters set the success, null and harm bars. All are drafted with defaults and
> listed in one table at `PRE-REGISTRATION-2026-08-12.md` §10. **Reply "defaults are fine", or
> name the ones you want moved.** They lock before the first page publishes and cannot move
> afterwards — that is the whole point of them.

---

## Part 3 — What is ready and waiting

| Preparable | State |
|---|---|
| Pilot protocol, design tree, deployment/rollback rules | Written (`PILOT.md`), amended today for the live-render anchor, the soft-404 check, the cp1253 gate and the cache-lag retry rule |
| Pre-registered success / null / harm / inconclusive criteria, in full | **Written** — `PRE-REGISTRATION-2026-08-12.md`. Drafted, not locked. |
| Design analysis: what 2 pairs licenses, widening priced, escape designs | **Written** — `DESIGN-ANALYSIS-2026-08-12.md` |
| Prior-intervention register + change-freeze list | **Written** — `PRIOR-INTERVENTIONS-2026-08-12.md` |
| GSC/GA4 export specification | **Written** — `data/README.md` |
| AI-citation sampling protocol, hardened, with query-list and log templates | **Written** — `citations/` |
| Baseline checklist, pre-change manifest, approvals log | **Written** — `baseline/`, `pre-change/`, `approvals.md` |

**One honest number about all of it:** the strongest result this pilot can produce at four pages
is *directional*. Statistical significance is arithmetically out of reach below six matched pairs
— three does not reach it either. Anyone who tells you a 2-pair or 3-pair pilot "proved" something
is describing a different pilot. What it can genuinely deliver is a signed magnitude, an
AI-citation reading that moves fast enough to see inside a month, a first answer on Greek inflected
keywords, and proof that our pipeline can carry a real page from audit to verified-live without
breaking anything. Whether that is worth the deadline pressure is Question 1.
