# AI-citation log — APPEND-ONLY

**State: TEMPLATE, no sessions run. DRAFTED 2026-08-12 (R76).**

Rules, in force from the first row:

- **Append only.** A row is never edited after the session that wrote it. A correction is a **new**
  row whose `Note` names the row it corrects.
- **One row per query × engine per session**, including the two controls.
- **"No AI answer shown" is a required row** (`Shown = n`, domains `n/a`). Absence is data; a
  missing row and a forgotten row look identical.
- Rows are written in the same sitting as the session. A row reconstructed later says so in `Note`.
- If the session is flagged (see `sampling-protocol.md` §3), **every row of that session** carries
  `Flag = NEG` or `Flag = POS`, and the whole session is excluded from the pooled rate.

## Columns

| Date | Session id | CQ id | Engine | Surface (AI Mode / AIO / n-a) | Shown (y/n) | Cited/linked domains, display order, ≤10 | **L** (linked, y/n) | **M** (mention, y/n) | Flag (— / NEG / POS) | Note |
|---|---|---|---|---|---|---|---|---|---|---|
| | | | | | | | | | | |

## Session header — write one before the rows of each session

```
SESSION <id>  date=<YYYY-MM-DD>  weekday=<...>  time=<HH:MM local>
profile=<fixed profile name>   chatgpt-account=<the one fixed at lock>
locale=el-GR  location=Greece  viewport=mobile
deviations: <none | describe>
NEG result: <cited us? y/n>      POS result: <competitor or GR retailer seen? y/n>
session status: OK | FLAGGED-NEG | FLAGGED-POS
```

## Derived figures

None are computed in this file. Rates, intervals and the metric verdict are computed at each
checkpoint from these rows and written into `PILOT.md` §6, so there is exactly one place where a
number is produced and one place where it is judged.
