# Alert thresholds — proposal for Sani, row by row

**Nothing here is applied.** Approve, adjust or reject per row. Produced 2026-08-17.

**Evidence grade, stated up front**: every external source below is a **primary-domain search
snippet, not an owner read** — this container's egress refuses direct fetches. That is the same
grade W5/W7 were accepted on, and this repo has been burned once by a snippet chain. **Open the
named URL once before any SOURCED row is applied.** Two minutes each.

## The count — a register disagreement, resolved

Four registers gave four counts. **Nine is right for the listed rows**; a full read found
**11 more needing a number that are on no list**. Proposed total: **20**.

| Register | Says | Verdict |
|---|---|---|
| `alert-threshold-guide.md:439` | 9 | **Correct at HEAD** |
| `OPEN-FINDINGS.md` finding 65 | 8 | **Stale by one** — omits row 9, added in alert-manager 4.3.2 the same day |
| `alert-threshold-decisions-2026-08-13.md` | 7 | Correct for its date (4.3.1-era) |
| `VERSIONS.md:134` | 5 | Correct, different population — rows *reported*, not rows *open* |

**Process finding**: `docs/loop/alert-threshold-decisions-2026-08-13.md` put 7 of these to Sani on
2026-08-13 and **no answer is recorded**. This proposal carries those recommendations forward
unchanged rather than restarting the question.

## Both named conflicts were already fixed — the brief described a pre-4.3.0 state

- **DA 70+ vs DR 60+**: removed as live thresholds by 4.3.0. Both files now say "the connected
  tool's own scale, tool named". The numbers survive only inside notes, quoted as the retired
  conflict. **Leave them.** What remains open is *which tool*, below.
- **5xx >5/hour vs >5/day**: resolved by 4.3.0. The wrong table was §2 ("Absolute Value Method",
  >5/hour = 120/day = **24×** the daily Critical). The surviving ladder is §3: **>1 / >5 / >20 per
  day**.

## THE THREE DECISIONS THAT MATTER MOST

1. **Rows 3 and 20 — the two P0s.** Homepage traffic and Conversion Drop both promise a
   15-minute human response on a signal that is *structurally* days old (weekly window). Everything
   else is tuning; these two decide whether the loudest channel still means anything. Recommend
   dropping Conversion Drop to P1; keep homepage P0 only if a same-night call is genuinely wanted,
   in which case it needs a day-over-day trigger added so the signal can actually be that fresh.
2. **Row 1 — Ahrefs or Moz?** A tool-of-record question, not a threshold question, and it sits
   upstream of four rows across two files. Answer it and the numbers derive themselves from one
   export. Note `.mcp.json` declares Ahrefs and **no Moz connector**.
3. **Row 10 — SSL expiry.** The only row with a moving external deadline: CA/Browser Forum
   Ballot SC081v3 cuts max certificate validity to **200 days from March 2026, 100 from March 2027,
   47 from March 2029**, and Let's Encrypt has announced 45-day certificates. A fixed 30-day warning
   becomes a third of the certificate's life. Whatever is set needs a **review date attached**.

## Table A — the nine listed rows

HOUSE = a rubric definition, not an empirical claim. SOURCED = dated primary source named.

| # | Row | Proposed number | Window | Priority | Grade |
|---|---|---|---|---|---|
| 1 | High-value link lost/gained | DR at 90th percentile of our own referring domains, dated | quarterly re-derive | P1 loss / P3 gain | SOURCED rationale + HOUSE rule |
| 2 | Crawl errors spike | >2× baseline Warning, >5× Critical | day-over-day | P2 | HOUSE |
| 3 | Homepage traffic | −25 / −40 / −60% | week-over-week | **P0 — your call** | HOUSE |
| 4 | Top-10 pages | −25 / −40 / −60% | week-over-week | P1 | HOUSE |
| 5 | Conversion pages | sessions −25/−40/−60% **plus** conversions −20/−40/−60% | week-over-week | P1 | HOUSE |
| 6 | Blog posts | −25/−40/−60% **on the blog as a group** | week-over-week | P2 | HOUSE |
| 7 | Citation rate slide / floor | values unchanged | weekly | **drop P0 → P2/P1** | HOUSE |
| 8 | Single 5xx in a day | stay OFF; add **5xx on 2 consecutive days → Emergency → P0** | 2-day span | P0 | **SOURCED** |
| 9 | Monthly referring-domain erosion | no monthly row — weekly only (>5% / >15%) | week-over-week | P1 | HOUSE |

**Row 7 is worth reading twice.** Its P0 justification is a priority-1 override that
*structurally cannot reach it* — the override covers a query set, citation rate is site-wide. P0
means SMS plus phone plus on-call, on a weekly window: fastest possible detection is 7 days late.
Also, the rows state **no denominator**, and the denominator moves on its own — the 10% floor can
be crossed because AI Overviews spread, not because anything on the site changed.

**Row 8's rung is the one genuinely new sourced number.** Google Search Central states that
returning 5xx responses *"for more than 2 days will cause Google to drop those URLs from the
index"*. That is the first primary evidence that the unit here is **days, not hours** — the
documented risk is a duration — and it independently ratifies 4.3.0's choice.

## Table B — eleven rows on no list

| # | Row | Problem | Proposal | Grade |
|---|---|---|---|---|
| 10 | SSL expiry | **Live conflict**: templates say 14 days, guide says <30/<7 | Branch on renewal method: manual **30/7**, ACME-automated **14/7** | **SOURCED** |
| 11 | Index coverage drop | Fires at 10%+, ladder Warning is 5% — 5-10% drops raise nothing | Fire at −5/−15/−30% week-over-week | HOUSE |
| 12 | Moderate decline | Month-over-month ≥20% with no ladder anywhere | Retire — the weekly ladder catches it sooner | HOUSE |
| 13 | Page speed drop | "+50%", no period, against an absolute ladder | Google TTFB bands: **>800 ms** Warning, **>1800 ms** Critical | **SOURCED** |
| 14 | Zero traffic | No observation window — zero *today* is normal | **7 consecutive days** at zero organic sessions | HOUSE |
| 15 | Trend warning | 3 consecutive weeks, no source | Keep, label house | HOUSE |
| 16 | Multiple links lost | Raw count "10+/day" against a percentage ladder | Retire — the % ladder scales, a flat count cannot | HOUSE |
| 17 | Toxic score increase | Vendor composite, **no vendor named**, highest priority of any unbanded row | Retire; keep the guide's toxic-link count ladder | HOUSE |
| 18 | Negative-SEO playbook trigger | **A fourth number on one metric** (>100/wk vs ladder >10/>50) | Set to the ladder's Critical, >50/week | HOUSE |
| 19 | Weekend adjustment | Unsourced +20%, and an *alternative* to the split baseline the same file rules as default | Retire; keep only as a labelled fallback | HOUSE |
| 20 | Conversion drop | **P0 on a Warning band — two levels up**, with the file's own note saying to re-check it | **Recommend P1.** Keep P0 only against a stated revenue-per-week figure — that number is yours | HOUSE |

## Free upgrades — sourced numbers the skill currently calls house

No decision needed; these only relabel or add a citation.

- **Core Web Vitals "Poor" boundaries** (LCP >4s, INP >500ms, CLS >0.25) are **Google-published**,
  not house. This is an **addition beside ruling R4, not a supersession** — R4 fixes the *Good*
  boundaries only.
- **CWV is assessed at the 75th percentile, segmented by device.** An alert on a mean fires on a
  different event from the one Google grades.
- **"Redirect chains 3+ hops" is Google's own recommendation** — currently indistinguishable from
  an invented number.
- The CWV **Emergency** column has no source and should say so.
- Two carrier gaps in `SKILL.md`: `:317` drops `excluding 4xx and 5xx` from the crawl-error row,
  silently reopening an overlap 4.3.2 closed; `:322` says "backlinks lost" where the guide's metric
  is "referring domains lost" — different quantities.

## What this deliberately does not do

No number was invented to fill a row. Where no source exists the row is labelled HOUSE; where no
honest default exists (row 1's cut-off, row 6's traffic floor) the recommendation is a
**construction rule defined in our own data**, not a figure. No industry benchmark was supplied
from memory — no "typical" CTR, conversion-drop or AI-citation figure. The library holds none and
its own rules forbid inventing them.
