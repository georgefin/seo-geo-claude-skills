# FIXTURE — correct rulings register (citation-divergence-check.sh)

The negative control. Same two rulings as `../diverged/`, with the citation defect repaired and
nothing else changed: every load-bearing claim names the source it came from, every declared
source is cited by at least one claim, and every source is an absolute URL carrying its own read
grade and read date. Expected: exit 0, no FAIL, no WARN.

A guard that only ever fires proves nothing about the tree it guards (ledger F15). This file is
the other half of the probe.

---

## RX1 — Fixture ruling with its sources reconciled

- **Statement**: Google ended the widget rich result in 2026 [S2] — the search appearance and
  the widget report were dropped June 2026 [S2], and Search Console API support is scheduled
  for August 2026 [S2] — but widget markup generation stays in the library.
- **Sources**:
  - `S1` https://developers.example.com/search/blog/2023/08/widget-changes — grade: owner-read, 2026-08-11
  - `S2` https://developers.example.com/search/updates — grade: snippet, 2026-08-10
- **Boundary**: Google restricted widget eligibility to well-known government and health sites
  on 2023-08-08 [S1]; that is a separate, earlier event and the two must not be conflated.
- **Decided**: 2026-08-08 sweep.
- **Reopens on**: schema.org deprecating the type itself.

## RX2 — Fixture ruling with one source, honestly graded

- **Statement**: Google restricted widget eligibility to well-known government and health sites
  on 2023-08-08 [S1].
- **Sources**:
  - `S1` https://developers.example.com/search/blog/2023/08/widget-changes — grade: snippet, 2026-08-10
- **Decided**: 2026-08-08 sweep.
