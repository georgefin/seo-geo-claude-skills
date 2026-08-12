# PILOT — Real-Site Outcome Pilot (G8): Operating Protocol

**Provenance**: G8's executable scope RELEASED 2026-08-09 (eleventh verdict-log entry,
`GATED-ITEMS.md`) — the preparable leg of the Master Improvement Directive's Phase 4.
Authoritative spec: `MASTER-IMPROVEMENT-PLAN.md` §3; this file operationalizes that spec
and does not extend it. It is written so that the day Sani supplies the three open
inputs, execution starts with zero further design work. **Live-site deployment stays
blocked on those inputs. Nothing publishes autonomously at any point (plan §3); every
publication needs Sani's per-change approval — the directive's own Phase 4.2
requirement.**

Owner: Herbert (coordinator). Approver: Sani. Changed by: APPLY-stage sessions via
normal PR — EXCEPT §4 (immutable once locked) and §6 (append-only rows). Why the pilot
exists: the library's single largest gap is zero real-site outcome data — every quality
claim so far is process-internal (plan §0). This pilot closes exactly that.

---

## 0. Status — preparables COMPLETE; input 1 PART-SUPPLIED, input 2 IN PROGRESS, input 3 OPEN

> **Companion files added 2026-08-12** (all DRAFTED, none applied, nothing published):
> `pilot/SANI-DECISION-BRIEF-2026-08-12.md` — the seven open decisions, one question each ·
> `pilot/PRE-REGISTRATION-2026-08-12.md` — §4 in full, with definitions and the decision rule ·
> `pilot/DESIGN-ANALYSIS-2026-08-12.md` — what 2 pairs licenses, widening priced, escape designs,
> the honest ceiling and the calendar · `pilot/PRIOR-INTERVENTIONS-2026-08-12.md` — dated prior
> work on the candidate pages and the change freeze the pilot needs. Execution tree now exists:
> `pilot/baseline/`, `pilot/pre-change/`, `pilot/data/`, `pilot/citations/`, `pilot/approvals.md`.

Preparables (this protocol: design tree, baseline checklist, sampling protocol,
pre-registration template, deployment/rollback rules) are complete as of 2026-08-09.
Each input is supplied only by Sani's explicit recorded words (standing gate rule — a
general "proceed" never decides one). Recorded words land verbatim in §0.1 below with
date and per-input status; §0.1 is append-only. Day-0 starts when all three clear their
bar in §0.1 — partial receipt does not start it.

| # | Input (per-input status in §0.1) | What good looks like |
|---|---|---|
| 1 | **Named target cluster** | One property — a section of a Sani Hellas site or one consenting client site: a named URL list of 5–15 pages forming one topical service/content cluster, with existing traffic (nonzero GSC impressions on most pages over the trailing 12 weeks) and NOT the revenue-critical core (bounded risk). Matched-pair becomes viable when ≥3 comparable pairs form (§1) — prefer such a cluster when choosing. |
| 2 | **Data access** | GSC (query- and page-level clicks / impressions / average position) + GA4 (sessions) covering the cluster, supporting BOTH the 12-week lookback pull and per-checkpoint pulls. Either connector auth — the session's ahrefs / similarweb / analytics MCP servers are unauthenticated as of 2026-08-09 and OAuth cannot run in a non-interactive session; authorize in claude.ai connector settings or an interactive `/mcp` session — or CSV/export files dropped per checkpoint into `docs/loop/pilot/data/` (a full substitute, plan §3). |
| 3 | **Publication workflow with per-change HITL approval** | A named human publisher (Sani or his webmaster) with CMS access; an approval channel where Sani's per-change wording is recorded (in-session message or issue comment) — an approval must NAME the page(s) it covers (a list of named pages in one message counts per-page; an unnamed blanket "publish" does not satisfy per-change HITL); the pre-change capture method agreed (CMS source export and/or rendered-HTML fetch, §5); an approval→publish turnaround expectation (target ≤3 working days, so deployment stays inside week 1–2). |

### 0.1 Recorded input words (append-only)

**2026-08-10 — input 1, PART-SUPPLIED.** Sani, verbatim: "I pick the nobo and Atlantic
real pages on a Sani Hellas site as a start." Reading: two brand families (Nobo,
Atlantic) on a Sani Hellas property are named as the pilot's subject matter — the
substantive half of input 1. Still needed against §0's input-1 bar: the property's
domain, and the explicit list of 5–15 page URLs in that cluster. The coordinator does
not infer those URLs — a cluster Herbert guessed would not be Sani's named target, and
§1's matched-pair design turns on exactly which pages are treatment and which are held
out. A trailing-12-week GSC impression check per page (§0 bar) runs once the list lands.

**2026-08-10 — input 2, IN PROGRESS.** Sani, verbatim: "With your guidance I will
authorize the analytics connectors in my claude.ai settings." Guidance issued the same
day. Material finding recorded alongside it: the six MCP servers this repo declares
(`.mcp.json` — ahrefs, similarweb, hubspot, amplitude, notion, slack) include no Google
Search Console server and no GA4 server, so authorizing all six would not by itself
deliver the GSC/GA4 fields input 2 names. Consequence for the design: the CSV/export
path (plan §3, already a full substitute) is the primary measurement route, and
connector auth complements it on the SEO-tool lanes (Ahrefs/SimilarWeb) rather than
replacing the export drop. Input 2 clears its bar when either the exports land in
`docs/loop/pilot/data/` or a GSC/GA4 access route is established.

**Input 3 — OPEN.** No publication-workflow words recorded yet: named human publisher,
approval channel, pre-change capture method, and turnaround expectation all pending.

**2026-08-11 — input 1, ADVANCED but still PART-SUPPLIED.** Sani, verbatim: "I was thinking
to test the θερμοπομποί keyword [Dropbox folder link] I thought we could test all the NOBO &
ATLANTIC webpages in www.sanihellas.gr."

What this settles, and what it does not:

- **Property: `www.sanihellas.gr`** — settled. The domain input 1 was missing.
- **Cluster rule: every NOBO and ATLANTIC page on that property** — this is a *derivation
  rule*, not the URL list the §0 bar asks for, and the distinction is load-bearing rather
  than pedantic. A rule the coordinator resolves by crawling produces a list nobody has
  approved; §0's bar exists because §1's matched-pair design turns on which specific pages
  are treatment and which are held out. The rule is a large step toward input 1 and does not
  complete it.
- **Seed keyword: `θερμοπομποί`** — recorded. Note it is the plural nominative; the fixed
  query set (§2) must carry the inflected forms too, which is exactly W10's open inflection
  leg riding this pilot.
- **The count is unknown and matters.** §0 asks for 5–15 pages. Nobody here knows how many
  NOBO and ATLANTIC pages exist. If the real number exceeds 15, a selection rule is needed
  and it is Sani's to give, not the coordinator's to invent.

**BLOCKER — this environment cannot reach the property**
[obs:2026-08-11T03:40:00Z curl + WebFetch from this session, both refused at the gateway].
`https://www.sanihellas.gr/` returns `curl: (56) CONNECT tunnel failed, response 403` — the
network egress proxy refuses the host at the gateway, before any request reaches the site.
`/robots.txt` and `/sitemap.xml` fail identically. The Dropbox folder link fails the same way.
So does `developers.google.com` (the G9 evidence-upgrade route, re-tested the same day through
both the HTTP client and WebFetch). This is the environment's allowlist, **not** a fault of the
site, the link, or the credentials — the proxy's own status endpoint shows the same
`connect_rejected` treatment applied to every declared MCP host.

**Consequence, stated plainly**: the coordinator cannot crawl the cluster, cannot enumerate the
NOBO/ATLANTIC pages, cannot capture pre-change copies, cannot audit a single published page,
and cannot sample AI citations. **Every §2 baseline step that reads the property is unexecutable
from here.** This is not a scheduling problem that more agent time solves.

**Resolution, Sani-chosen 2026-08-11 ("Unblock the site")**: add `www.sanihellas.gr` to the
allowed-hosts list of the Claude Code environment this session runs in — an environment
setting, changed by whoever created it, documented at
`https://code.claude.com/docs/en/claude-code-on-the-web`. Worth adding in the same pass, since
each is a separate host and each unlocks a distinct capability:

| Host | What it unlocks |
|---|---|
| `www.sanihellas.gr` | the cluster crawl, page audits, pre-change capture, on-page scoring |
| `sanihellas.gr` (apex, if it serves separately) | redirect and canonical checks |
| `www.dropbox.com` + `dl.dropboxusercontent.com` | the θερμοπομποί folder Sani shared |
| `developers.google.com` | upgrades G9's evidence from snippet-grade to owner-read, unblocking 9b |
| `www.google.com` | AI-citation and SERP sampling under §3 — **the sampling protocol is unexecutable without it** |

Until then: input 1 stays PART-SUPPLIED, day-0 does not start, and no §2 baseline step that
touches the property can run. Skill-library work (Phases 1–3) is unaffected — it reads nothing
outside this repository.

**2026-08-12 — input 1, still PART-SUPPLIED; the gap has CHANGED SHAPE. No new Sani words.**
The 2026-08-11 entry above says "the count is unknown and matters". **That sentence is now
stale and is superseded here rather than edited** (this section is append-only): the cluster was
enumerated the same day from an unblocked machine — **17 GR surfaces, 0 errors**, every count
reconciled against the site's own «αποτελέσματα» figure (`pilot/crawl-2026-08-11-macstudio.md`,
branch `pilot-crawl`): 14 products + 2 categories + 1 blog. So the count is known, and it exceeds
§0's 5–15 bar at the product level. What input 1 still lacks is different and smaller:

- **Nobody has NAMED the pilot set.** `pilot/pair-analysis-2026-08-11.md` narrows to 4 eligible
  pages "after the exclusions Sani upheld", but **no verbatim record of that exclusion ruling
  exists** in this section or in `GATED-ITEMS.md`'s verdict log. Under the standing rule that an
  input is supplied only by recorded words, a ruling that exists only as a reference is not on
  the record. It needs either a verbatim entry or a re-confirmation.
- **The 4-page pool yields 2 matched pairs against a floor of 3.** Sani's ruling stands: two is a
  finding, not a failure; do not manufacture a third. The widening choice is costed in
  `pilot/DESIGN-ANALYSIS-2026-08-12.md` §2 and drafted as a selection in the decision brief.
- 🔴 **New, and it changes the pairing inputs**: three of the four eligible pages carry dated
  content interventions from 2026-07-12, -18 and -26, **differing page by page**, and 823277
  received substantially the pilot's own treatment on 18-07 (audited GEO 77 → 88). Read strictly,
  the number of pairs free of a documented recent intervention on either member is **zero**.
  Register, sources and the required change freeze: `pilot/PRIOR-INTERVENTIONS-2026-08-12.md`.

**2026-08-12 — input 2, still IN PROGRESS. No new Sani words. Delivery, not authorisation, is
the binding gap.** Zero rows of GSC data exist in the repository. The finding that none of the six
declared MCP servers is a GSC or GA4 server is unchanged, so connector authorisation alone will
not clear this input; the export drop is the route, and the plan already treats it as a full
substitute. The *access* is not in question — the service account was re-verified 2026-07-30 and
returned 8 properties [obs:2026-08-12T06:40:00Z `pilot/pair-analysis-2026-08-11.md` §2a, which
records that re-verification; not independently re-run from here]. **The exact export specification is now written** and is a copy-paste
instruction: `pilot/data/README.md` (six GSC exports over the full 16-month retention window, one
GA4 export, and the Peec exclusion filter applied at query-set construction as well as at pull —
the second application is new and is load-bearing, since a Peec-probed query is precisely the
high-impression zero-click kind that would otherwise sort into the frozen set and stay there).
**One consequence worth stating separately**: the same export also enables a zero-risk
retrospective read of three content deploys this cluster received on 2026-07-12, -18 and -26,
each recorded as "LIVE-VERIFIED" in its own dated deploy manifest with a byte-level before-state
captured [obs:2026-08-12T06:55:00Z read of `products/atlantic/F119/_deploy-log/DEPLOY-MANIFEST_safe-subset_18-07-2026.md`,
`products/atlantic/F120-WiFi/_deploy-log/DEPLOY-MANIFEST_18-07-2026.md`,
`_backups/products/capsule-deploy-12-07-2026/MANIFEST.md` — the manifests are the evidence; the
current public state of those pages was not re-checked from here]. That yields real outcome
numbers for this property weeks before any pilot could produce them, with no publication and no
approval (`pilot/PRIOR-INTERVENTIONS-2026-08-12.md` §4).

**2026-08-12 — input 3, still OPEN. No words recorded.** The four sub-parts remain unsupplied.
Narrowing recorded so the ask is one line rather than a design exercise: a publication workflow
already exists in practice on this property — Sani pastes into the eShopKey admin himself after
his own per-page "save it", and the deploy records show pre-write backups being captured — it has
simply never been written against these four sub-parts. A **proposed default** is drafted in
`pilot/SANI-DECISION-BRIEF-2026-08-12.md` Question 3 for confirmation or correction; it is
labelled a proposal drawn from standing practice and is **not** a Sani word about the pilot.
Two platform facts belong inside whatever answer arrives, because they change the measurement:
**W0 must be the `live-render` confirmation, not the CMS save** — the public page can lag behind a
save, per locale, with no purge and no republish control — and **a 200 response proves nothing on
this property**, since a URL that does not exist returns 200 with the homepage
[obs:2026-08-12T06:50:00Z `pilot/crawl-2026-08-11-macstudio.md` §0 negative control: fake URL →
`200`, `81,006 B`, homepage `<title>`; same signature recorded independently against four nonsense
URLs in the 26-07 deploy record]. Both are now written into §5 and §7 below.

**Day-0 checklist (on receipt of all three inputs — run top to bottom):**

1. [ ] Record all three inputs verbatim above (date + wording reference).
2. [x] ~~Create the execution tree~~ — **DONE 2026-08-12**: `pilot/baseline/`, `pilot/pre-change/`,
       `pilot/data/`, `pilot/citations/`, `pilot/approvals.md` all exist, each with its template
       and its rules. Nothing in them has been executed.
3. [ ] Resolve the public-repo question (below) — anonymized IDs is the default.
4. [ ] Settle the change freeze (`pilot/PRIOR-INTERVENTIONS-2026-08-12.md` §3) **before** the
       baseline window opens — the staged NOBO pack and the C1 slug fix both touch the cluster,
       and the disposition changes the baseline window's start date.
5. [ ] Run the §1 decision tree; record design choice + page/pair assignment table here. Include
       the **dated-intervention audit** of the chosen pool as a pairing axis (`baseline/README.md`
       step 3) — matching on type and word count alone was shown insufficient on 2026-08-12.
6. [ ] Execute the §2 baseline (week 0–1) per `pilot/baseline/README.md`, including **two**
       pre-deployment §3 citation sessions on different calendar weeks.
7. [ ] Fill §4's parameters from baseline data (`pilot/PRE-REGISTRATION-2026-08-12.md` §10 is the
       one-table ask) → Sani signs → LOCK §4.
8. [ ] Deploy per §5 (week 1–2); anchor W0 = the first confirmed `live-render` timestamp.
9. [ ] Measure per §6 at +2/+4/+8/+12 weeks; §7 governs rollback/halt throughout. Reporting runs
       on **two clocks**: the AI-citation read is interpretable at CP2 (labelled interim); rank
       and traffic carry no reportable verdict before CP4
       (`pilot/DESIGN-ANALYSIS-2026-08-12.md` §5.4).
10. [ ] Arm the Phase 4.2 quarterly cold-review reminder Routine (rides G8; first
       ~2026-11, plan §3).

**Runnable before D0, and worth running first** (needs input 2 only — no publication, no approval,
no write of any kind against the property): the **retrospective read** of the three dated July
interventions on this cluster, whose before-states are captured on disk and whose deploy manifests
each record a `LIVE-VERIFIED` result [obs:2026-08-12T06:55:00Z read of the three manifests named in
§0.1's input-2 entry]. It yields this property's first real
outcome numbers weeks earlier than the pilot can, and calibrates §4's thresholds against this
property instead of leaving them chosen in the dark. It is observational and is labelled so
permanently — it does not replace the pilot and is never reported as its result.
`pilot/PRIOR-INTERVENTIONS-2026-08-12.md` §4.

**Public-repo caution**: this fork is PUBLIC (G2 risk note, `GATED-ITEMS.md`). The
named target's URLs, traffic figures, and baseline scores are client/property data —
a new class versus anything published so far. Default until Sani's explicit word says
otherwise: this file and `docs/loop/pilot/` carry anonymized page IDs (P1…Pn) and
banded figures; the ID→URL map and raw exports stay Sani-side (or in a private
channel). Sani may instead approve in-repo raw data — his call, recorded here.

**Timeline honesty (plan §0, constraint 3)**: SEO outcomes are slow — first directional
signal 4–6 weeks, decision-grade ~12 weeks. AI-citation visibility can move in
days-to-weeks and is tracked separately (§3) for that reason. The week-2 checkpoint is
a pipeline shakedown and early citation read, NOT a rankings verdict.

---

## 1. Design decision tree

Run once at day 0, after the cluster is named; record the outcome and the full
assignment table in this section before §4 lock.

1. **Can ≥3 comparable pairs be formed from the cluster?**
   - **YES → matched-pair design**: within each pair, one page is treatment (optimized),
     one is control (held untouched) over the same window. Controls exist because Greek
     tourism/services seasonality (W9 discipline, `WATCH-ITEMS.md`) would otherwise
     masquerade as treatment effect (plan §3).
   - **NO → before/after single-cluster design**: all pages treated; the 12-week
     baseline lookback is the comparator. Seasonality is then UNCONTROLLED — the §6
     confound log and the final report must say so on every read of the result.
   - Edge case — exactly 1–2 pairs formable: run before/after as the pre-registered
     primary design; keep the formable pairs as a SUPPLEMENTARY internal-control read,
     labeled supplementary in every report, never promoted to primary after the fact.
   - 🔴 **The edge-case rule inverts for a strongly seasonal cluster, and this cluster is one**
     (contradiction found and resolved 2026-08-12). Demoting the pairs to supplementary and
     promoting before/after to primary assumes the uncontrolled comparator is the safer default.
     For θερμοπομποί it is the opposite: a baseline in the summer trough against an evaluation
     window on the autumn ramp produces a large positive number no matter what we do, so
     before/after would return a **confident wrong answer** rather than a weak one
     (`pilot/pair-analysis-2026-08-11.md` §0). **Rule for a cluster whose demand is
     season-concentrated: keep the formable pairs as PRIMARY, label the verdict by pair count
     per `pilot/PRE-REGISTRATION-2026-08-12.md` §8.5, and run before/after only in the
     deseasonalised form of that file's §5 — never raw.** The generic edge-case rule above still
     governs clusters with flat demand.

2. **"Comparable" means all four, operationally** (a fourth axis was added 2026-08-12 after the
   first three passed two pairs that a prior-work check then disqualified —
   `pilot/PRIOR-INTERVENTIONS-2026-08-12.md`):
   - **Topic class**: both pages target the same intent family within the cluster's
     topic (same service/topic sub-family in the §2 query-set mapping).
   - **Traffic band**: 12-week GSC clicks within 2× of each other, or both under 10
     clicks (low-traffic band); both with nonzero impressions.
   - **Template**: same page type (service page vs article vs category/listing)
     rendered from the same CMS template.
   - 🆕 **Prior-intervention record** — both members carry comparable recent content history.
     Run a dated-intervention audit over the deploy records for every candidate page
     (`pilot/baseline/README.md` step 3) and record, per page, what was changed and when. A page
     optimised in the last ~8 weeks has depleted headroom and is still settling; pairing one
     against an untouched page measures the earlier deploy, not the pilot. Where the pool cannot
     supply a match on this axis, say so — it is a **finding about the pool**, exactly as the
     pair count was, and it is not fixed by ignoring the axis.

3. **Assignment rule (deterministic, no cherry-picking)**: sort pairs by combined
   12-week clicks, descending. Pair 1: higher-traffic member → treatment. Pair 2:
   higher-traffic member → control. Alternate down the list. Record the table
   (pair id · page IDs · band · template · T/C assignment) here before lock; the
   assignment is immutable after §4 lock.

---

## 2. Baseline procedure (week 0–1) — checklist

All outputs land in `docs/loop/pilot/baseline/` (anonymization rule per §0). Baseline
is read-only toward the live site: nothing changes on any page during week 0–1.

**2a. Library audit (the process baseline — plan §3):**

- [ ] `keyword-research` — build the fixed query set per 2b; store the set + clustering.
- [ ] `serp-analysis` — dated el-GR SERP capture for the full set (top-10 organic
      domains + features per query; locale/device recorded). Doubles as the first W10
      distinctness read (2c). House rule from the Greek SERP modules: an undated,
      unlocalized snapshot is unusable.
- [ ] `on-page-seo-auditor` — per page: CORE-EEAT dimension scores in the handoff
      format (`C:.. O:.. R:.. E:..`), GEO Score (CORE avg) + SEO Score (EEAT avg),
      veto flags, priority item IDs.
- [ ] `technical-seo-checker` — cluster-level findings, RECORDED ONLY (content-only
      pilot; infra findings go to Sani's webmaster as a list, §5).
- [ ] `domain-authority-auditor` — CITE score for the property, once.
- [ ] GSC/GA4 **12-week lookback pull** (per the data-access input): per page — clicks,
      impressions, average position, sessions; per query (fixed set) — clicks,
      impressions, position. Exports stored as delivered, never edited.
- [ ] §3 AI-citation **week-0 sample** (the citation baseline precedes deployment).

**2b. Fixed keyword set — construction rules (frozen at §4 lock):**

1. Size **10–30 queries**, each row: id · query text · mapped page ID · intent class ·
   source (GSC / aspirational) · inflection-pair id (if any).
2. Source mix: majority (≥70%) from the GSC lookback's top queries by impressions for
   cluster pages (cap ≤4 per page so one page cannot dominate); remainder aspirational
   target terms from the audit (not yet ranking — headroom).
3. **MUST include ≥3 Greek inflected-form pairs** — a pair = two grammatical variants
   of one head term (case or number, e.g. singular/plural or nominative/genitive per
   the inflection workflow in
   `research/keyword-research/references/greek-keyword-coverage.md`). Both variants
   count toward the 10–30 and are tracked as separate queries. **This is W10's open
   inflection-leg verification riding the pilot** (plan §3): whether el-GR collapses
   inflected variants into one SERP or ranks them distinctly is the open question
   carrying the `[VERIFY: SERP-distinctness magnitude per query class]` tag in that
   reference — the pilot IS the "first Greek keyword engagement" W10's resolves-when
   names. Treat distinctness as an open question, never as settled, until the data
   lands back in `WATCH-ITEMS.md` W10 via normal PR.
4. After lock: no additions, removals, or rewording. A later exploratory set may be
   tracked as a separate appendix, never merged into the pre-registered metrics.

**2c. Rank capture method:**

- **Primary**: GSC average position per query per checkpoint window. Stated limitation:
  impression-weighted, and absent when a query draws zero impressions — recorded as
  "no data", never imputed.
- **Secondary (required for the W10 pairs; recommended for all queries)**: manual el-GR
  SERP capture — logged-out/consistent browser profile, `hl=el` + `gl=GR`, fixed device
  class (mobile), capture date recorded; top-10 organic domains per query.
- **W10 distinctness measure**, per pair per capture: top-10 overlap count →
  collapsed (≥8 shared), mixed (6–7), distinct (≤5); logged per query class.
- **Optional**: a rank-tracking tool export if Sani supplies one (the ahrefs MCP server
  is unauthenticated as of 2026-08-09 — §0 input 2); it slots in without protocol
  change and is recorded as a distinct method column, never silently mixed.

---

## 3. AI-citation sampling protocol (reproducible, written)

**Honest note first (plan §3)**: no engine APIs are available here — sampling is
MANUAL, Sani-side browser (or an agreed export), executed per this written protocol.
The written protocol is what makes it reproducible either way.

- **Query list**: 8–15 entries drawn from the fixed keyword set, each optionally paired
  with ONE conversational reformulation (recorded verbatim). Frozen at §4 lock.
  Template (stored at `docs/loop/pilot/citations/query-list.md`):

  | CQ id | Query text (verbatim) | Base keyword id | Form (keyword / conversational) |
  |---|---|---|---|
  | CQ1 | [TBD at lock] | | |

- **Engines**: Google AI Mode and/or AI Overviews (record WHICH surface answered),
  ChatGPT (search-enabled), Perplexity. Greek locale where applicable — AI Mode in
  Greek is live since 2025-10-08 (pinned baseline, `SETTLED-RULINGS.md`). If the
  quote-preview module is ever sighted on an el-GR SERP during sampling, that is a W7
  finding (its el-GR rollout scope is the open leg) — report it to the weekly loop.
- **Cadence**: weekly, same weekday each week (pick at lock), starting week 0 (the
  pre-deployment citation baseline) and running through week 12.
- **Consistency rules**: same browser profile and account state every session (clean /
  logged-out where the engine allows; ChatGPT requires an account — use the same one
  throughout and record it). Consistency matters more than purity; note any forced
  deviation in the row.
- **Recording format** — one row per query × engine per session, append-only at
  `docs/loop/pilot/citations/citations-log.md` (or `.csv`, same columns):

  | Date | CQ id | Engine (+surface) | AI answer shown? (y/n) | Cited/linked domains (display order, ≤10) | Our property cited? (y/n) | Note |
  |---|---|---|---|---|---|---|

  "No AI module shown" is a valid, required row (`shown = n`, domains n/a) — absence
  is data.
- **Metric**: citation-appearance rate = our-property-yes rows ÷ rows with an AI answer
  shown, reported per engine AND pooled, always with both raw counts alongside the rate.

---

## 4. Pre-registration — success/null criteria (LOCK BEFORE DEPLOYMENT)

**Lock rule**: this section locks BEFORE the first publication. Filling the TBD slots
requires the §2 baseline data plus Sani's recorded sign-off (wording + date, entered
below). After lock the table is IMMUTABLE: any deviation is recorded as a protocol
deviation in §6 and reported — never silently rewritten. A criterion changed after
lock demotes the whole result to exploratory, and the final report must say so.

**Null-result discipline** (plan §0, constraint 4, carried here as binding): "A null
pilot result is a finding, not a failure to bury. Success criteria are pre-registered
before deployment … precisely so the result cannot be curve-fit afterward." A null or
negative result is reported with the same prominence a positive one would get.

**Criteria DRAFTED IN FULL 2026-08-12 — `pilot/PRE-REGISTRATION-2026-08-12.md`.** That file
carries the operational definitions, the four outcome states, the data-sufficiency preconditions,
the decision rule and the eleven free parameters with defaults. The table below is the summary
and is the lock surface. **Every threshold shown is DRAFTED, not locked**; Sani fixes or
overrides each one before the first publication (`PRE-REGISTRATION` §10 is the one-table form of
that ask). No figure below is a forecast: `CHOSEN` marks a decision boundary someone picked,
`MEASURED` a value the pilot's own data will compute from a formula fixed now.

**Four outcome states, not two** — SUCCESS · NULL · HARM · **INCONCLUSIVE**. The fourth is
load-bearing: without it an underpowered measurement gets reported as NULL, and "we could not
measure it" silently becomes "there was no effect".

| Metric | Definition (fixed) | Success criterion | Null band | Harm criterion |
|---|---|---|---|---|
| **1. Median rank delta** *(PRIMARY)* | Per query, `d_q = position_base − position_eval` (positive = better). Page delta = median over that page's queries with data at both endpoints. Pair `Δ_i = D_T − D_C`. Study statistic `Δ` = median of `Δ_i`. Before/after reads `median(D_T)`. Evaluated once, at CP4. | `Δ ≥ FLOOR` **and** every pair's `Δ_i > 0`, where **`FLOOR = max(3.0 positions [CHOSEN], IQR of control-arm query deltas [MEASURED])`** | `−1.0 ≤ Δ ≤ +1.0` positions [CHOSEN] | `Δ ≤ −FLOOR`, or any treated page's `D_p ≤ −5.0` [CHOSEN] |
| **2. GSC impressions / clicks** *(secondary)* | Impressions primary, clicks always reported beside them. `r = (eval − base)/base` per arm; `DiD = r_T − r_C` in pp. Raw `r_T` may **never** be reported alone — see the seasonality warning in `PRE-REGISTRATION` §4.3. | `DiD ≥ +15 pp` **and** absolute T lift ≥ +100 impressions [both CHOSEN] | `\|DiD\| ≤ 10 pp` [CHOSEN] | `DiD ≤ −25 pp` [CHOSEN] |
| **3. AI-citation appearance rate** *(secondary, fastest)* | **Linked** citations only (L); unlinked mentions (M) counted separately and never merged. Trailing 4 weeks at CP4 vs the pooled pre-W0 baseline (**≥2 sessions, different weeks**). Clopper–Pearson exact intervals. | CP4 rate exceeds the one-sided 95% upper bound on the baseline rate [MEASURED] **and** ≥5 L events across ≥2 engines and ≥3 calendar weeks [CHOSEN] | CP4 rate inside the two-sided 95% interval on the baseline [MEASURED] | CP4 rate below its lower bound — we were de-cited |

**INCONCLUSIVE conditions** (per metric, `PRE-REGISTRATION` §3.4 / §4.4 / §7.4): rank — <60% of
either arm's queries have data at both endpoints; impressions — T-arm baseline <100 impressions;
citations — <60 unflagged rows in the trailing 4 weeks, or an engine-mix change on >25% of rows.

**Decision rule** (`PRE-REGISTRATION` §8, in force from lock): the headline verdict **is** Metric
1's state; **if Metric 1 is INCONCLUSIVE the headline is INCONCLUSIVE**, whatever Metrics 2 and 3
show — no secondary is ever promoted after the primary fails to resolve. All three states are
reported in fixed order every time, including when they disagree.

**Verdict labelling is mechanical, by pair count**: n ≥ 6 → stated plainly · 3–5 → *directional* ·
n ≤ 2 → *directional, single-cluster, not generalisable* · no control arm → *uncontrolled;
seasonality not separated*. The arithmetic behind that ladder: with `n` pairs the best one-sided
p an exact sign test can return is `0.5^n`, so **n = 2 tops out at p = 0.25 and n = 3 at 0.125 —
the three-pair floor buys comparability, not significance**, and n = 6 is the first design that
can clear a two-sided 0.05.

- The harm criterion doubles as a §7 rollback trigger (sustained for 2 consecutive
  checkpoints).
- Lock record: **[UNLOCKED — criteria DRAFTED 2026-08-12; awaiting Sani's parameter ruling +
  baseline data]** (replace with date + Sani's wording reference at lock).

---

## 5. Deployment rules (week 1–2)

1. **Content-only edits.** In scope: body copy, headings, title/meta, image alt,
   internal links among cluster pages, and on-page JSON-LD where the CMS exposes it as
   a content field. OUT of scope without Sani's webmaster: redirects, robots.txt,
   sitemaps, server/CDN/theme/template code, CWV interventions — no
   technical-infrastructure changes, period (plan §3). Baseline technical findings are
   handed to the webmaster as a list, not acted on.
2. **Production**: content produced by the library's own skills (`seo-content-writer`,
   `content-refresher`, `geo-content-optimizer`, `meta-tags-optimizer`,
   `schema-markup-generator` as applicable) — the pilot tests the library, so no
   off-library shortcuts.
3. **Per-page gates — FOUR, not three (a cp1253 pre-flight was added 2026-08-12), all BEFORE
   publication, in order:**
   - CORE-EEAT at the agreed threshold — threshold [TBD — AWAITING SANI; proposed
     default: GEO Score ≥75 AND SEO Score ≥75 with zero verified veto items — note the
     framework math already forecloses vetoes at any threshold ≥60: one verified veto
     caps the final score at 59, two or more = BLOCK].
   - Binding `greek-content-editor` pass for EL pages (register/diacritics/Greeklish
     judgment — the VALIDATE-leg discipline applied to live copy).
   - 🆕 **cp1253 pre-flight** — a codepoint scan on the **new** text, scoped to the fields that
     round-trip through Windows-1253 on this platform: product `Description_1/2`, the specs slot
     and `JSON_SCHEMA`. Any non-cp1253 character corrupts silently to `?` **on save** — it renders
     correctly in a UTF-8 preview and shows the corruption only on the public page, so a treatment
     page can ship degraded and nobody sees it until the measurement is already running. **Scope discipline matters**: the
     same property's measurements show `Categorytext_1/2` behaving as a UTF-8 path and a metadata
     write preserving an emoji intact, so this is a field-scoped rule, not a site-wide one — apply
     it where it bites and nowhere else. **Entity escaping is not a shield**: `&rarr;` was observed
     decoding back to a literal `→` on save. Character substitution is the only working defence.
   - **Sani's explicit per-change approval**, naming the page — recorded (date +
     wording) in `docs/loop/pilot/approvals.md`. No approval, no publication. TBD
     markers are fine in this internal doc; they are NOT fine in customer copy — no
     page ships with placeholder or TBD text.
   - 🆕 **After publication, before the clock starts**: confirm the change **rendered** on the
     public page with a fresh GET, and record that timestamp — it, not the CMS save, is the page's
     W0 (§6). Discriminate the fetch against the soft-404 signature: a non-existent URL on this
     property returns **HTTP 200 with the homepage** (~81,006 B), so capture a fake-URL probe in
     the same session and compare byte size and `<title>`. A bare 200 proves nothing here.
4. **Byte-exact pre-change copies BEFORE any edit ships**, stored in
   `docs/loop/pilot/pre-change/` (created at execution time, day-0 checklist): per
   page, the CMS source export and/or a dated rendered-HTML fetch — whichever the
   publication workflow provides; record WHICH in `pre-change/manifest.md`
   (page ID · URL · capture date · method · file · sha256). Where the CMS is the
   publish surface, the CMS-source copy is the authoritative restore artifact and the
   rendered fetch is the checksum witness. This is the one-command-rollback store (§7).
5. **Control pages are untouchable** for the full window — no edits, no targeted
   promotion; anything that happens to them anyway goes in the §6 confound log.
6. **Single intervention window**: treatment edits land in week 1–2, then hands off.
   Post-window fixes only via the same gates, logged as deviations in §6.
7. 🆕 **A change freeze covers more than the treatment and control pages** (added 2026-08-12).
   Non-pilot work already staged against this cluster would contaminate it: the NOBO
   spec-defect fix pack awaiting Sani's "save it" references exactly **823327** (a candidate
   pilot page), **965262**, and the pool's parent categories **132676** and **132671**; the C1
   slug fix would land a 301 next to two candidate pages. The freeze list, the three
   dispositions and their costs are in `pilot/PRIOR-INTERVENTIONS-2026-08-12.md` §3 — **Sani's
   ruling, not the coordinator's.** If the §5 seasonality index of
   `pilot/PRE-REGISTRATION-2026-08-12.md` is used, its member surfaces join the freeze: an index
   that gets optimised is not an index.

---

## 6. Measurement checkpoints (append-only)

Anchor: **W0 = the date the first treatment change is confirmed RENDERED on the public page**
[TBD at execution] — *not* the CMS save date (precision added 2026-08-12; the earlier wording,
"date of first treatment publication", was ambiguous between the two and the gap between them is
hours on this platform, per locale, with no purge and no republish control). Anchoring to the
save date opens the evaluation window before the change exists to be crawled, so CP1 would
measure a page Google has not seen. Per-page render timestamps are recorded in
`pilot/approvals.md`; W0 for the pilot is the earliest of them. Checkpoints at
+2 / +4 / +8 / +12 weeks. Rows are appended at each checkpoint and never edited
afterward; corrections append a new row referencing the corrected one. Per-checkpoint
windows: CP1 covers W0→+2w, CP2 +2→+4, CP3 +4→+8, CP4 +8→+12; the §4 criteria read the
cumulative 12-week window. Expectation-setting per plan §0.3: CP1 is a shakedown +
citation read; rank/traffic verdicts firm up CP3→CP4.

| CP | Target date | Median rank T | Median rank C | Δ vs baseline (per §4 def) | GSC clicks T / C | GSC impr T / C | AI-cite rate (pooled, n) | Confound IDs | Seasonal position note | Recorder |
|---|---|---|---|---|---|---|---|---|---|---|
| CP0 (baseline) | [at lock] | | | — | | | | | | |
| CP1 (+2w) | | | | | | | | | | |
| CP2 (+4w) | | | | | | | | | | |
| CP3 (+8w) | | | | | | | | | | |
| CP4 (+12w) | | | | | | | | | | |

(Before/after design: C columns read "n/a — before/after"; the W10 distinctness log
from §2c is appended below this table per checkpoint.)

**Confound log** (append-only; every checkpoint row must cite the confound IDs it ran
under, or "none"):

| ID | Date observed | Class | Evidence (source + date) | Checkpoints touched | Note |
|---|---|---|---|---|---|

Classes:

- `core-update` — ONLY when the Google Search Status Dashboard lists it (standing
  discipline, `WATCH-ITEMS.md` footer + the pinned baseline in `SETTLED-RULINGS.md`;
  last confirmed core update 2026-05-21 → 2026-06-02 as of 2026-08-09). Blog/chatter
  "updates" NEVER enter under this class — unconfirmed chatter may be noted under
  `other`, labeled unconfirmed.
- `seasonality` — the W9 discipline: Greek tourism/services demand swings seasonally;
  the control leg is the structural defense (plan §3), and every checkpoint row carries
  a seasonal-position note regardless of design (for tourism/services clusters see
  `research/serp-analysis/references/greek-tourism-seasonality.md`).
- `site-change` — any non-pilot change to the property or cluster (ask the publisher at
  every checkpoint; "none" is an answer to record).
- `measurement` — data-access gaps, GSC anomalies, missed sampling sessions.
- `other` — anything else, described.

---

## 7. Rollback and halt

- **Single-page rollback**: restore that page's stored pre-change artifact
  (`docs/loop/pilot/pre-change/`, manifest row) via the same publication workflow.
  Recorded like any change (date + trigger + who); Sani's word is required unless the
  rollback IS Sani's directive.
- **Full rollback**: restore all treatment pages from the store; verify live state
  against the manifest (re-fetch hash where rendering allows, else CMS-source
  comparison); record date + trigger here.
- 🆕 **Verification order and a wait-and-retry rule** (added 2026-08-12, because the naive form of
  the line above produces false failures on this platform): verify the **admin/DB read-back
  immediately** — that is authoritative and instant — then re-fetch the public page at **+30 min,
  +2 h and +6 h**, and escalate only if the +6 h fetch still disagrees. Check **both locales**; the
  cache is per-locale and a single-locale check gives the wrong answer in either direction.
  **Do not re-save to chase the cache** (standing platform rule). Every re-fetch is discriminated
  against the soft-404 signature — a 200 on this property proves nothing on its own.
- **Triggers**: (a) Sani's directive — immediate, no debate; (b) a factual, legal, or
  compliance defect discovered in a published page — single-page, same day;
  (c) sustained material harm — the §4 harm criterion breached for 2 consecutive
  checkpoints.
- **Halt semantics**: "halt" = STOP PUBLISHING immediately; **measurement may continue
  as observation** (plan §3 / G8 rollback line). A halted or rolled-back pilot still
  files its report: which pages shipped when, what was measured, what the confound log
  says — a null or negative result is a finding (§4 discipline), and a partial
  deployment is reported as partial, never presented as the designed experiment.
- **Post-mortem routing**: if a process failure caused the rollback, it gets a
  `FAILURE-LEDGER.md` entry; measurement-design lessons feed the eval backlog and the
  quarterly cold review (Phase 4.2, rides G8).

---

*Index note (build time, 2026-08-09): this file is not yet listed in `CLAUDE.md`'s
loop-state index, `PIPELINE.md`'s state-files table, or `check-freshness.sh`'s tracked
list — those are coordinator-scope tracking edits, flagged in the build report.*
