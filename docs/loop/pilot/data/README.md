# `data/` — the measurement drop. What to export, exactly.

**State: DRAFTED 2026-08-12 (R76).** This folder is empty until the exports land. It is the
delivery route for **G8 input 2**, and the plan already treats CSV exports as a **full
substitute** for connector access — so nothing else has to work for the pilot to be measurable.

**Do not edit an export after it lands.** Exports are stored exactly as delivered. Every
derived table is a separate file that names its source. An edited export cannot be re-checked.

---

## 1. Google Search Console — six exports, one sitting

Property: **`www.sanihellas.gr`** (the `www` host; the apex is a known-broken redirect target and
must not be used).

**Date range: `2025-04-12` → `2026-08-11`.** That is the full 16-month retention window as of
today. It is deliberately much wider than the 12-week lookback the protocol needs, because one
wide export supports the 12-week baseline, the year-over-year autumn comparator, **and** the
retrospective read of the July deploys — while a narrow export would force a second ask, and the
2025 autumn window ages out of retention around January 2027.

Path in the GSC UI: **Performance → Search results → Date: Custom → set the range → set the
filters below → the table tabs at the bottom → Export → CSV/Google Sheets.**

| # | File name to save as | Table / filter | Why |
|---|---|---|---|
| 1 | `gsc-pages_2025-04-12_2026-08-11.csv` | **Pages** tab, no filters | Per-URL clicks, impressions, CTR, average position |
| 2 | `gsc-queries_2025-04-12_2026-08-11.csv` | **Queries** tab, no filters | The seed pool for the frozen query set |
| 3 | `gsc-pages-GR_2025-04-12_2026-08-11.csv` | **Pages** tab, Country = Greece | el-GR is the pilot's market; a UI export cannot be re-segmented later |
| 4 | `gsc-queries-GR_2025-04-12_2026-08-11.csv` | **Queries** tab, Country = Greece | same |
| 5 | `gsc-queries-by-page_<pageid>_2025-04-12_2026-08-11.csv` — **one per candidate page** | **Queries** tab with a **Page = exact URL** filter applied | The protocol needs each query mapped to one page, and the UI cannot export Page × Query in a single table. This is the only way to get the mapping. |
| 6 | `gsc-dates_2025-04-12_2026-08-11.csv` | **Dates** tab, no filters | The daily series — needed for the seasonality index and to see whether the July deploys show an inflection |

**Export #5 is the one that matters most and the one most likely to be skipped.** Without it, the
frozen query set cannot be mapped to pages and the primary metric has no analysis unit. Run it for
each page in whichever pilot set Question 1 selects — 4 pages if the heater cluster, more if
widened.

**A caveat to check rather than assume**: the GSC UI export has historically capped at a fixed row
count (commonly reported as 1,000). If exports #2 or #4 come back at exactly a round number of
rows, they are truncated — say so, and the per-page exports (#5) become the authoritative source.
The Search Console API returns far more rows per request and is the fallback; the service account
`gsc-reader@…` was re-verified 2026-07-30 and returned 8 properties.

### 1.1 The Peec filter — apply it before anything is read, not after

Peec's monitoring probes contaminate this property's GSC data. The standing project rule is to
filter every pull against `SEO-GEO/_timeseries/peec-prompt-exclusions.txt`, matching **prompt AND
zero clicks**.

Two places it must be applied, and the second is routinely missed:

1. **The baseline figures** — otherwise whichever pages Peec happened to probe get inflated
   baselines and the pairing is biased in an unknown direction.
2. **The construction of the frozen query set.** The protocol seeds ≥70% of that set from the top
   GSC queries by impressions — and a Peec-probed query is precisely a high-impression, zero-click
   query, so it sorts near the top. Once it enters the frozen set it cannot be removed, because
   the set is immutable after lock. **Filter first, then seed.**

The filtered result is written to a **separate** file (`*-peec-filtered.csv`) naming its source
export and the exclusion-list version used. The raw export is never overwritten.

---

## 2. Google Analytics 4 — one export

Sessions per landing page, same date range, for the candidate pages. Save as
`ga4-sessions_2025-04-12_2026-08-11.csv`. GA4 is a supporting metric only: nothing in the
pre-registration depends on it, and the pilot proceeds without it if it is inconvenient.

---

## 3. Naming, provenance and the public-repo rule

- **This fork is public.** Until Sani rules otherwise, raw exports carrying URLs and traffic
  figures **do not get committed**. They live in this folder locally; the repository carries only
  the derived, anonymised tables (page IDs `P1…Pn`, banded figures). A `.gitignore` entry for
  `docs/loop/pilot/data/*.csv` is the mechanical form of that rule and should be added by the
  session that first handles real data. See Question 6 of the decision brief.
- Every file added here gets a row in `manifest.md` beside it: file · source · date range ·
  filters applied · export timestamp · sha256.
- A derived table names its source file in its own header. A number that cannot be traced back to
  an export row does not appear in any report.

---

## 4. What lands here later, during execution

| File | When |
|---|---|
| `gsc-*.csv` (§1) | On input 2 clearing |
| `*-peec-filtered.csv` | Immediately after, same session |
| `baseline-table.md` | Week 0–1, derived, anonymised |
| `cp1/…`, `cp2/…`, `cp3/…`, `cp4/…` | One per checkpoint, per `PILOT.md` §6 |
| `manifest.md` | Grows with every file |
