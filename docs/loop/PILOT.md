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

**Day-0 checklist (on receipt of all three inputs — run top to bottom):**

1. [ ] Record all three inputs verbatim above (date + wording reference).
2. [ ] Create the execution tree alongside this file: `docs/loop/pilot/` with
       `baseline/`, `pre-change/`, `data/`, `citations/`, `approvals.md`.
3. [ ] Resolve the public-repo question (below) — anonymized IDs is the default.
4. [ ] Run the §1 decision tree; record design choice + page/pair assignment table here.
5. [ ] Execute the §2 baseline (week 0–1), including the week-0 §3 citation sample.
6. [ ] Fill §4's TBD slots from baseline data → Sani signs → LOCK §4.
7. [ ] Deploy per §5 (week 1–2); anchor W0 = first treatment publication date.
8. [ ] Measure per §6 at +2/+4/+8/+12 weeks; §7 governs rollback/halt throughout.
9. [ ] Arm the Phase 4.2 quarterly cold-review reminder Routine (rides G8; first
       ~2026-11, plan §3).

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

**2026-08-17 — input 1, SUBJECT MATTER EXPANDED AND PRIORITISED; input 2, NEW TOOLING NAMED.**
Sani, verbatim: *"αφυγραντήρες, θερμοπομποί is the most critical and urgent!! Currently we have
peec ai and now I added Perplexity pro."*

What this settles:

- **A second category joins the pilot: αφυγραντήρες (dehumidifiers)**, alongside θερμοπομποί.
  These are the two commercial priorities, stated as urgent. On the brand map already recorded
  here, θερμοπομποί is the Nobo/Atlantic cluster; αφυγραντήρες is a **different brand set —
  Kullhaus and Meaco** — so this is not more pages of the same cluster, it is a second cluster
  with its own competitor set and its own SERP.
- **Priority is stated.** Everything else in the queue yields to these two.
- **Two tools named**: Peec AI (already held) and Perplexity Pro (added). Neither is in
  `.mcp.json`, so neither is reachable as a connector from here. **What is needed to use them is
  an export, not an authorization** — the same CSV/export path input 2 already names as the
  primary measurement route. Open question for Sani, and it is small: what can Peec AI export,
  and over what date range? That answer decides whether the pilot has a real GEO baseline or an
  observational one.

**The blocker is narrower than this file has been recording, and the correction matters.**
The 2026-08-11 entry above concluded that *"every §2 baseline step that reads the property is
unexecutable from here"*. That is still exactly true, and re-tested rather than assumed
[obs:2026-08-17T09:52:58Z `curl -sS --max-time 12 https://www.sanihellas.gr/` from this session
returns `curl: (56) CONNECT tunnel failed, response 403`, identical to the 2026-08-11 record;
`https://sanihellas.gr/robots.txt` fails the same way; a control request to `github.com`
completes the tunnel and returns an HTTP status, so the refusal is host-specific and not a
general network fault]. The egress proxy refuses `sanihellas.gr` at the gateway. But it was allowed to read as though the **whole** pilot were
unexecutable, and it is not. **WebSearch is not subject to that refusal.** Measured this session, a
single search returned the property's own category URLs, its buying-criteria blog post ranking on
a commercial comparison query, and an AI answer that **named Kullhaus alpha Q13L/Q20L and DDQ10L
by model** while citing Testado.gr, DropFix.gr, best10.gr and parathiro.com as sources.

So the pilot splits in two, and only one half is stopped by the gateway:

| Half | Needs | Status |
|---|---|---|
| **Page-side** — crawl the cluster, enumerate NOBO/ATLANTIC/Kullhaus/Meaco pages, capture pre-change copies, audit published pages | reading the property | **STOPPED at the gateway**, unchanged — needs the URL list from Sani, or an export, or a session whose egress reaches the host |
| **Market-side** — keyword landscape, SERP composition, competitor set, AI-answer citation observation | search only | **EXECUTABLE FROM HERE**, and started 2026-08-17 |

This is not a loosening of §0's input bar. The URL list is still owed and the coordinator still
does not infer it — a cluster Herbert guessed would not be Sani's named target, and §1's
matched-pair design turns on which pages are treatment and which are held out. What changes is
that the market-side baseline no longer waits on it, and an AI-citation observation for these two
categories can be taken **today**, which is the one measurement that decays if deferred.

**Still owed by Sani, unchanged and now shorter**: the page URL list (or a selection rule plus a
count, if the cluster exceeds §0's 5–15 band), and input 3 in full — named human publisher,
approval channel, pre-change capture method, turnaround. Nothing publishes without per-change
approval naming the pages; that is unchanged and not negotiable by anything above.

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

2. **"Comparable" means all three, operationally:**
   - **Topic class**: both pages target the same intent family within the cluster's
     topic (same service/topic sub-family in the §2 query-set mapping).
   - **Traffic band**: 12-week GSC clicks within 2× of each other, or both under 10
     clicks (low-traffic band); both with nonzero impressions.
   - **Template**: same page type (service page vs article vs category/listing)
     rendered from the same CMS template.

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
  | CQ1 | to be set at lock | | |

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
- **Recording format** — one row per query × engine × **repeat** per session, append-only at
  `docs/loop/pilot/citations/citations-log.md` (or `.csv`, same columns):

  | Date | CQ id | Engine (+surface) | Sample n of N | AI answer shown? (y/n) | Brand mentioned? (y/n) | Our property cited? (y/n) | Cited URLs (verbatim, full, display order) | Recommendation position (or "not a recommendation answer") | Owning URL matched? (y/n/no owner assigned) | Competitors named (in order) | Sentiment (pos/neu/neg) | Answer excerpt (verbatim) | Capture conditions | Note |
  |---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|

  "No AI module shown" is a valid, required row (`shown = n`, the rest n/a) — absence
  is data. A refused, rate-limited or empty capture is likewise a row with its reason,
  and it **reduces N** rather than disappearing.
- **Metric**: reported per engine, with N and the population beside each figure. Mention
  rate, citation rate and owned-URL citation rate are **three separate figures** and are
  never merged into one. A pooled cross-engine figure may be shown **in addition**, never
  instead, and is labelled as pooled.

**§3 was upgraded 2026-08-17 to match `references/ai-visibility-measurement.md`, which is
now the governing specification** — read it, not this section, for field definitions and the
sampling discipline. Three things this protocol was getting wrong before the reference
existed, each of which would have cost the pilot a real finding:

1. **It recorded cited *domains*.** "They cited us" and "they cited our comparison page
   instead of the product page" are different findings and only the second is actionable.
   URLs are recorded verbatim and in full.
2. **It took one capture per query × engine.** Generated answers vary run to run, so a
   single capture is an observation and not a measurement — N ≥ 3, reported `k of N`, or
   week-to-week movement cannot be distinguished from noise.
3. **It collapsed mention, citation and recommendation into one yes/no.** The pilot's own
   headline observation is exactly the case that collapse hides: products named by model
   while the citations went to four third-party sites and none to the client. Under the old
   columns that logs as "our property cited: n" and the finding disappears.

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

| Metric | Definition (fixed) | Success criterion | Null band | Harm criterion |
|---|---|---|---|---|
| Median rank delta | Median position across the fixed set's queries mapped to T pages vs C pages; matched-pair reads delta-of-deltas: (T_now − T_base) − (C_now − C_base); before/after reads T_now − T_base. Evaluated at week 12. | [AWAITING SANI + BASELINE DATA] | [AWAITING SANI + BASELINE DATA] | [AWAITING SANI + BASELINE DATA] |
| GSC clicks / impressions delta | Full 12-week deployment window vs the 12-week baseline lookback, T vs C (before/after: vs lookback only). | [AWAITING SANI + BASELINE DATA] | [AWAITING SANI + BASELINE DATA] | [AWAITING SANI + BASELINE DATA] |
| AI-citation appearance rate | §3 metric, pooled + per-engine; trailing 4 weeks at week 12 vs the week-0 baseline rate. | [AWAITING SANI + BASELINE DATA] | [AWAITING SANI + BASELINE DATA] | [AWAITING SANI + BASELINE DATA] |

- The harm criterion doubles as a §7 rollback trigger (sustained for 2 consecutive
  checkpoints).
- Lock record: **[UNLOCKED — awaiting Sani + baseline data]** (replace with date +
  Sani's wording reference at lock).

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
3. **Per-page gates, all three BEFORE publication, in order:**
   - CORE-EEAT at the agreed threshold — threshold [TBD — AWAITING SANI; proposed
     default: GEO Score ≥75 AND SEO Score ≥75 with zero verified veto items — note the
     framework math already forecloses vetoes at any threshold ≥60: one verified veto
     caps the final score at 59, two or more = BLOCK].
   - Binding `greek-content-editor` pass for EL pages (register/diacritics/Greeklish
     judgment — the VALIDATE-leg discipline applied to live copy).
   - **Sani's explicit per-change approval**, naming the page — recorded (date +
     wording) in `docs/loop/pilot/approvals.md`. No approval, no publication. TBD
     markers are fine in this internal doc; they are NOT fine in customer copy — no
     page ships with placeholder or TBD text.
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
   Post-window fixes only via the same three gates, logged as deviations in §6.

---

## 6. Measurement checkpoints (append-only)

Anchor: **W0 = date of first treatment publication** [TBD at execution]. Checkpoints at
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
