# FIXTURE — diverged rulings register (citation-divergence-check.sh)

Not a register. A fault-injection fixture reproducing the R3 defect class in miniature, so the
guard can be shown FIRING rather than asserted to work. Expected: exit 1.

`RX1` is the R3 shape exactly — the ruling cites **URL A** while its load-bearing claims came
from **URL B**, a URL that appears in the block only as an orphan `[S2]` tag. `RX2` carries the
two unfetchable-reference shapes R3 also has.

Expected FAILs: (3) unattributed claim x2 · (4) S1 declared, cited by nothing · (5) [S2] cited,
never declared · (1) no source list in RX2 · (2) elided reference · (2) scheme-less reference.

---

## RX1 — Fixture ruling with a substituted source

- **Statement**: Google ended the widget rich result in 2026 — the search appearance and the
  widget report were dropped June 2026, and Search Console API support is scheduled for
  August 2026 — but widget markup generation stays in the library.
- **Sources**:
  - `S1` https://developers.example.com/search/blog/2023/08/widget-changes — grade: owner-read, 2026-08-11
- **Note**: the June 2026 timeline above was transcribed from the documentation changelog
  [S2] and never reconciled with the blog post this ruling cites.
- **Decided**: 2026-08-08 sweep.
- **Reopens on**: schema.org deprecating the type itself.

## RX2 — Fixture ruling with unfetchable references

- **Statement**: Google restricted widget eligibility to well-known government and health
  sites on 2023-08-08.
- **Evidence**: snippet-grade, not owner-read. The source URLs are
  `developers.example.com/search/blog/2023/08/widget-changes` and
  `.../2026/05/a-new-resource-for-optimizing`.
- **Decided**: 2026-08-08 sweep.
