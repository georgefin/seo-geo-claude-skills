# `baseline/` — week 0–1, executable checklist

**State: DRAFTED 2026-08-12 (R76). Not started — no baseline step may run before D0.**
Baseline is **read-only toward the live site**: nothing changes on any page during week 0–1.

This turns `PILOT.md` §2 into a run order with its dependencies made explicit, so a session that
picks it up cold cannot execute the steps out of sequence.

---

## Run order — the dependencies are the point

Steps 1–3 must finish before step 4, and step 4 must finish before steps 5–7. Running the audits
first and the data pull last is the natural instinct and it is wrong: the query set and the pair
assignment both depend on data, and both are frozen at lock.

| # | Step | Skill / source | Depends on | Output |
|---|---|---|---|---|
| 1 | GSC + GA4 exports land | `data/README.md` | **input 2** | `data/gsc-*.csv` |
| 2 | Apply the Peec exclusion filter | project exclusion list | 1 | `data/*-peec-filtered.csv` |
| 3 | **Dated-intervention audit of the chosen pool** | grep the deploy records | pool named | intervention register per page |
| 4 | **Pair assignment** — page type · traffic band · rankings · word count · intervention status | `PILOT.md` §1 | 1–3 | assignment table → `PILOT.md` §1 |
| 5 | Fixed keyword set, 10–30 rows, ≥3 Greek inflected pairs | `keyword-research` | 2, 4 | `baseline/query-set.md` |
| 6 | Dated el-GR SERP capture for the full set | `serp-analysis` | 5 | `baseline/serp-<date>/` |
| 7 | Per-page CORE-EEAT audit | `on-page-seo-auditor` | 4 | `baseline/eeat-<pageid>.md` |
| 8 | Cluster technical findings — **recorded only** | `technical-seo-checker` | 4 | `baseline/technical-findings.md` |
| 9 | Property CITE score, once | `domain-authority-auditor` | — | `baseline/cite-score.md` |
| 10 | AI-citation session #1 | `citations/sampling-protocol.md` | 5 | rows in `citations/citations-log.md` |
| 11 | AI-citation session #2, a different calendar week | same | 10 | rows in the log |
| 12 | Fill `PILOT.md` §4 from the baseline → Sani signs → **LOCK** | `PRE-REGISTRATION-2026-08-12.md` | 1–11 | §4 locked, date + wording recorded |

**Step 3 is new** relative to `PILOT.md` §2 and is not optional: `PRIOR-INTERVENTIONS-2026-08-12.md`
found three of four candidate pages carrying differing July interventions. A pool that has not
been audited for prior work is a pool whose pairs are matched on the wrong axes.

**Step 11 is also new**: the pre-registration requires **two** pre-deployment citation sessions on
different weeks, because a one-session baseline for a rate metric is one day's weather.

---

## Hard rules for the baseline week

- **Read-only.** No page is edited, no cache is warmed, no URL is submitted for indexing. If a
  defect is found, it is recorded — it is not fixed during baseline. (A fix during baseline is an
  untracked treatment.)
- **Every live read is discriminated against the soft-404 signature.** `www.sanihellas.gr`
  returns **HTTP 200 with the homepage** for any URL that does not exist. Capture a fresh
  fake-URL probe at the start of each session, record its byte size and `<title>`, and compare
  every real fetch against it. A bare 200 proves nothing here in either direction.
- **The `www` host only.** The apex is a known-broken redirect target.
- **SERP captures are dated and localised or they are unusable** — `hl=el`, `gl=GR`, a consistent
  logged-out profile, a fixed device class, capture date recorded in the filename.
- **Anonymisation** while the repository is public: page IDs `P1…Pn` and banded figures in
  anything committed; the ID→URL map stays out of the repo.

---

## What "done" means

Baseline is complete when steps 1–11 have outputs on disk, the §1 assignment table is filled and
recorded, and §4 is ready to lock. **Lock is a separate act needing Sani's recorded words** — not
a consequence of the checklist finishing.
