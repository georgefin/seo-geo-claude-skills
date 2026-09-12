# Alert configuration + 30-day fire log — petshop-mikroulis.gr

**Client:** Petshop Mikroulis — petshop-mikroulis.gr (Greek online pet-supplies shop)
**Source:** the alert configuration exactly as the previous agency left it (set up autumn 2024, untouched since), copied from the tool's settings screen by Nikos on 2026-08-04; the fire log is the alert email folder for 2026-07-05 – 2026-08-03 (30 days), counted by hand. "Marked actionable by us" is our own judgment: the fire pointed at something we actually had to do.
**Tools connected now:** none in this session. The agency's monitoring service still sends the emails; the separate subscription that fed the Core Web Vitals rows lapsed in March 2026 (see log notes).

## 1. Alert configuration (as left by the agency, autumn 2024)

| # | Alert | Trigger condition | Priority | Delivery |
|---|-------|-------------------|----------|----------|
| 1 | Ranking move | any of the 140 tracked keywords moves >=1 position (daily check) | High | Email per keyword, immediate |
| 2 | Traffic day drop | organic sessions down >=10% vs the previous day | High | Email, immediate |
| 3 | Core Web Vitals — FID | FID > 100 ms | Warning | Email |
| 4 | Core Web Vitals — LCP | LCP > 2.0 s | Critical | Email |
| 5 | Core Web Vitals — CLS | CLS > 0.1 | Warning | Email |
| 6 | FAQ rich results | FAQ rich result lost on any tracked page | High | Email |
| 7 | SSL expiry | certificate less than 14 days from expiry | Critical | Email |
| 8 | Backlink lost | any lost backlink | Medium | Email per link |
| 9 | Unlinked brand mention | new mention of "petshop mikroulis" without a link | Low | Email |

## 2. Fire log, 2026-07-05 – 2026-08-03 (30 days, counted from the alert email folder)

| # | Alert | Fires | Marked actionable by us | Notes |
|---|-------|------:|------------------------:|-------|
| 1 | Ranking move | 118 | 6 | fires spread across 47 of the 140 keywords; the 6 actionable ones were all moves of 4+ positions |
| 2 | Traffic day drop | 9 | 1 | 8 of the 9 fell on Saturdays or Sundays (11–12/07, 18–19/07, 25–26/07, 01–02/08); the 1 actionable was Wed 08/07 — our confirmed hosting outage (provider incident, service credit received) |
| 3 | CWV — FID | 0 | 0 | not one FID email in the window; the FID column disappeared from the tools a long time ago |
| 4 | CWV — LCP | 0 | 0 | fed by the separate CWV subscription, which lapsed in March 2026 — no data arriving since |
| 5 | CWV — CLS | 0 | 0 | same lapsed feed as #4 |
| 6 | FAQ rich results | 0 | 0 | these stopped arriving in early 2026, around when the FAQ report disappeared from Search Console |
| 7 | SSL expiry | 1 | 1 | fired 14/07; we renewed the certificate the same day |
| 8 | Backlink lost | 28 | 2 | the 2 actionable were links lost from two high-authority sites; the rest were forum/profile churn |
| 9 | Unlinked brand mention | 4 | 0 | four mentions of the shop with no link; we did nothing with them |

**Totals: 160 fires, 10 marked actionable.**

**Note from Katerina (owner):** Nikos has stopped opening the alert folder entirely — he says whatever is in there is almost never real. That worries me more than any single alert.
