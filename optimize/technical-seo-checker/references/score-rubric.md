# Technical SEO Checker — Score Rubric (how every number in the report is derived)

Referenced from [SKILL.md](../SKILL.md) and from each score line in
[technical-audit-templates.md](./technical-audit-templates.md).

The audit emits eight section scores out of 10 (Crawlability, Indexability, Performance,
Mobile, Security, URL Structure, Structured Data, International) and one overall health score
out of 100. **Every one of them is arithmetic over the section's own checklist rows** — not a
judgment call, not an impression. Two audits of the same data must produce the same numbers,
and a client must be able to recompute any score from the tables printed above it.

---

## 1. The arithmetic

1. **Scored rows.** A row is scored only if you could actually check it with the data you have.
   A row you could not check is written `— not checked (no crawl data)` and is left out of both
   the numerator and the denominator. Never score an unchecked row as ✅ or ❌.
2. **Points.** ✅ = 1 · ⚠️ = 0.5 · ❌ = 0.
3. **Section score** = `round(10 × points ÷ scored rows)`, to the nearest whole number, with an
   exact half rounding **down** (2.5 → 2). The score is a whole number out of 10.
4. **Overall health score** = `round(100 × Σ section scores ÷ (10 × sections scored))`, same
   rounding. Unweighted: every scored section counts once. Sections that were not scored are
   excluded from both sides and named under the breakdown.

## 2. Show the working, always

Each score prints its own derivation inline. The format is fixed:

```
**Security Score**: 4/10 (1.5 pts ÷ 4 scored rows; 6 rows not checked — headers pulled for the homepage only)
```

```
## Overall Technical Health: 32/100 (13 ÷ 40 — 4 sections scored; Indexability, Mobile, URL Structure not scored — no data)
```

A score printed without its derivation is not deliverable: the reader cannot check it, and the
next audit cannot reproduce it.

## 3. Turning count rows into statuses

Several tables record counts rather than ✅/⚠️/❌ (Crawl Budget Analysis, Index Blockers Check,
Duplicate Content Issues, URL Issues Found, Redirect Analysis). Convert each row using the
severity framework in [http-status-codes.md](./http-status-codes.md):

| Row state | Status | Points |
|---|---|---|
| 0 findings | ✅ | 1 |
| findings whose highest severity is Low or Medium | ⚠️ | 0.5 |
| findings whose highest severity is High or Critical | ❌ | 0 |

The same severity alignment governs ordinary status rows: **a row whose finding is High or
Critical is ❌, not ⚠️.** ⚠️ is for Low/Medium — partial, suboptimal, cosmetic. A row marked ⚠️
while the report calls its finding Critical is an internal contradiction a client will spot.

**Deliberate configuration is not a finding.** Utility-page `noindex` (checkout, basket,
account, internal search), variant-to-parent canonicals, and blocks the user has stated are
intentional are noted in the table and excluded from both numerator and denominator — scoring
an intentional block as a defect makes the score wrong in the client's favour and wrong on the
facts.

**Pure population figures are evidence, not scored rows**: pages analyzed, pages in sitemap,
pages indexed, sitemap URL count, resource counts and sizes. They ground findings; they do not
carry points.

## 4. What counts as a scored row, section by section

| Section | Scored rows (maximum, when all data is available) |
|---|---|
| **Crawlability** | Robots.txt Review (7 status rows) + XML Sitemap Review (7 status rows; "URLs count" is a population figure) + Crawl Budget Analysis (5, count rule) = 19 |
| **Indexability** | Index coverage ratio (1: ✅ >90% per the template's own note · ⚠️ 70–90% · ❌ <70%) + Index Blockers Check (6, count rule) + Canonical Tags Audit (5) + Duplicate Content Issues (5, count rule) = 17 |
| **Performance** | Core Web Vitals (3 — see §5) + Additional Performance Metrics (6) = 9. The Resource Loading table is evidence. |
| **Mobile** | Mobile-Friendly Test (6) + Responsive Design Check (5, scored only for elements you actually observed) + Mobile-First Indexing (4) = 15 |
| **Security** | HTTPS Status (5) + Security Headers (5: ✅ present with the recommended value · ⚠️ present with a weaker or partial value · ❌ absent) = 10 |
| **URL Structure** | URL Pattern Review (7) + URL Issues Found (5, count rule) + Redirect Analysis (4, count rule) = 16 |
| **Structured Data** | One row per schema type the site's page types call for: ✅ present and valid · ⚠️ present with errors or warnings · ❌ called for and absent. The denominator is the number of types assessed, and the report names them. |
| **International** | Hreflang Implementation (5) + one row per language/region pair checked. **Excluded entirely** — not scored 0 — when the site is single-locale; say so under the breakdown. |

## 5. Core Web Vitals rows

The CWV table reports a mobile value and a desktop value against one target
(LCP ≤2.5s · INP ≤200ms · CLS ≤0.1 — settled ruling R4; the targets are inclusive, so a value
exactly at the threshold meets it). Report both verdicts in the row, and **score the mobile
verdict**: Google indexes mobile-first, and a site that passes on desktop while failing on
mobile is failing. Say which verdict was scored — one clause does it: "scored on the mobile
verdict; desktop reported, not scored".

Field data (real-user) and lab data (Lighthouse/PageSpeed run) are both scorable, but never mix
them inside one row: score whichever source you have, and label it in the row. If both exist,
score the field values and report the lab values beside them.

## 6. When there is no score

- **A section where no row could be checked** is written `not scored — no data`, never `0/10`.
  Zero means measured and failing; blank means unmeasured. Confusing them is how an audit
  invents a finding.
- **If no section could be scored, the report carries no overall health score at all.** State
  what data would produce one (which input unlocks which section) and stop. A health score for
  a site nothing was measured on is a fabricated figure, whatever the client says about who
  will check it.
- **Scores are never carried over** from a previous audit, borrowed from a competitor, or
  estimated from "typical" sites of that kind. A score is the arithmetic above or it is absent.
- **Partial sections are scored on what was checked**, with the unchecked count stated in the
  derivation. A 3-row denominator is honest; a 3-row denominator presented as a full audit is
  not.

## 7. The score never replaces the severity

Print the section's highest severity next to its score:

```
**Crawlability Score**: 6/10 · highest severity in section: 🔴 Critical (robots.txt blocks /recipes)
```

A section average can look survivable while the section contains a site-killer — one Critical
row among eighteen healthy ones still costs the site its indexation. The score answers "how
much of this section is in good shape"; the severity answers "what happens next". Both ship.
Priority order in the report follows severity, never the score.

---

## 8. Worked derivation (the cloudhosting.com example)

From [technical-audit-example.md](./technical-audit-example.md), whose tables are abridged —
which is exactly why the denominators are small and stated:

| Section | Rows scored | Points | Derivation | Score |
|---|---|---|---|---|
| Crawlability | 8 | 4.0 | ✅1 ⚠️0.5 ❌0 ❌0 ✅1 (robots — the blocked /pricing/ row is ❌, not ⚠️: its finding is Critical) + ✅1 ❌0 ⚠️0.5 (sitemap) | `10 × 4 ÷ 8 = 5.0` → **5/10** |
| Performance | 6 | 0.5 | LCP/CLS/INP mobile all ❌ + TTFB ❌ + Page Size ❌ + Requests ⚠️0.5 | `10 × 0.5 ÷ 6 = 0.83` → **1/10** |
| Security | 4 | 1.5 | ✅1 (SSL) + ⚠️0.5 (HTTPS enforced) + ❌0 (mixed content) + ❌0 (HSTS) | `10 × 1.5 ÷ 4 = 3.75` → **4/10** |
| Structured Data | 4 | 1.0 | ✅1 Organization + ❌0 Article + ❌0 Product + ❌0 FAQ | `10 × 1 ÷ 4 = 2.5` → **2/10** (half rounds down) |

Overall: `100 × (5 + 1 + 4 + 2) ÷ (10 × 4) = 100 × 12 ÷ 40 = 30` → **30/100**, with
Indexability, Mobile and URL Structure named as not scored because that example omits their
tables.
