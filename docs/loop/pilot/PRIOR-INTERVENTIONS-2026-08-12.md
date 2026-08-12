# Prior interventions on the eligible pool — and the change-freeze the pilot needs

**State: DRAFTED (R76). Nothing here is applied, staged, or published. No live page was fetched
or written to produce it.** Every row below comes from dated deploy records already on disk in
the eshop project tree; each cites its file. The pilot's own crawl
(`crawl-2026-08-11-macstudio.md`, branch `pilot-crawl`) supplies the page inventory.

**Why this file exists.** `pair-analysis-2026-08-11.md` matched the four eligible pages on page
type and word count, and recorded that traffic and rankings were unmeasured. It did not check a
third axis that turns out to be decisive: **what has already been done to each page, and when.**
Three of the four eligible pages received content interventions in the four weeks before this
date, they received *different* interventions, and one of them received substantially the
treatment the pilot proposes to apply. A fourth intervention is staged and awaiting Sani's
"save it" on a page that would be inside the pilot.

---

## 1. The register

Four eligible pages (`pair-analysis-2026-08-11.md` §1). Dated interventions found:

| Page | ProductId | Dated interventions on record | Source |
|---|---|---|---|
| Atlantic F120 WiFi Connect | 965528 | **2026-07-12** answer-capsule prepend **ATTEMPTED and BLOCKED** — two saves did not persist, page unchanged, nothing corrupted. **2026-07-18** net-new `ProductGroup` + `FAQPage` JSON-LD added to a previously **zero-JSON-LD** page; LIVE-VERIFIED same day; Google Rich Results Test returned 6 valid items (4 merchant listings). | `_backups/products/capsule-deploy-12-07-2026/MANIFEST.md`; `products/atlantic/F120-WiFi/_deploy-log/DEPLOY-MANIFEST_18-07-2026.md` |
| Nobo NTL4T | 823327 | **2026-07-12** answer capsule **DEPLOYED**, admin read-back verified (`Description_1` 15,913 → 16,504 B). **2026-07-26** wave-2 in-place rewrite of `Description_1/2` (tolerance figures, savings claim re-bound to its mechanism, multiplier restated); all six surfaces LIVE-VERIFIED 12:07 the same day. | same MANIFEST; `_backups/07_VERIFICATION-SAFETY-LOCK_PRE-07-08-2026.md` rows for 26-07 |
| Atlantic F119 DESIGN CE | 823277 | **2026-07-18 — a full SEO/GEO optimisation pass.** `Description_1/2` rewrite + FAQ accordion; `FAQPage` JSON-LD relocated from a dead slot into a rendering slot; **product RENAME driving `<title>` and `<h1>` in both locales**; meta description and keywords replaced; a false whole-device warranty claim corrected. Confirming audit by a fresh agent: **GEO 77 → 88, SEO 81 → 86, Greek 88 → 93.** | `products/atlantic/F119/_deploy-log/DEPLOY-MANIFEST_safe-subset_18-07-2026.md` |
| Nobo NTL2N | 823322 | **No dated live-deploy record found** in the eshop tree. **Unresolved discrepancy**: its schema workshop README (built 2026-06-26) states "Live page had 0 ld+json" and marks the JSON-LD **UPLOAD-READY, deploy gated (Sani Chrome)** — yet the 2026-08-11 crawl records the page rendering `Product, ProductGroup, Offer, Breadcrumb, WebPage, ImageObject`. Either something shipped at an unrecorded date, or the rendered types come from a template. `[VERIFY]` — an admin read of 823322's `Desc2_1/2` slots settles it. | `products/thermopompos-ntl2n/Schema/README.md`; crawl §2 |

**Cluster-level, affecting all four equally:** categories **132676 (Θερμοπομποί)** and **132671
(Θέρμανση)** — the pool's parent and grandparent categories — had their `Categorytext_1/2`
rewritten **2026-07-26**, LIVE-VERIFIED 09:35 that day, with a fifth corrective write the same
session (`_backups/07_VERIFICATION-SAFETY-LOCK_PRE-07-08-2026.md`).

---

## 2. What this does to the design

**2.1 The baseline window is not a clean baseline.** SEO effects have a 4–6 week directional
latency (`MASTER-IMPROVEMENT-PLAN.md` §0, constraint 3). Interventions dated 12-07, 18-07 and
26-07 are 2–5 weeks old as of today. Any 12-week lookback ending in August therefore averages
pre- and post-intervention states on three of the four pages, and those pages are still moving
under changes nobody in the pilot made. A pre-registered baseline computed over such a window
is not wrong arithmetically; it is **measuring a different thing on each page**.

**2.2 The contamination is differential, not common-mode — and it is worst exactly where the
pair analysis said the design was soundest.** A confound that hits every page equally is
absorbed by a matched pair (the 26-07 category rewrite is of that kind, and is harmless here).
These are not of that kind:

| Pair | Treatment candidate | Control candidate | Prior-intervention asymmetry |
|---|---|---|---|
| **1** (called "the sound one") | F120 965528 — schema-only, 18-07 | NTL4T 823327 — capsule 12-07 **+** copy rewrite 26-07 **+ a third pass STAGED** | The control has had *more* done to it than the treatment, most recently, and is due for more. |
| **2** | F119 823277 — **full optimisation pass 18-07**, audited GEO 77→88 | NTL2N 823322 — no recorded intervention (status unresolved) | The treatment page has already received the pilot's treatment. The control is the only untouched page in the pool. |

Pair 2 cannot separate the pilot's effect from the residual of the 18-07 deploy: F119 will very
likely out-perform NTL2N across the window whether or not the pilot touches it. Pair 1 has the
same problem with the sign reversed — a control that was optimised twice in July should be
*rising* through CP1–CP2, which biases the treatment-minus-control delta **downward** and
creates a false-HARM risk rather than a false-success one.

**2.3 Headroom on F119 is largely spent.** The pilot's treatment is "the full optimisation pass"
(`pair-analysis-2026-08-11.md` §0). On 823277 that pass ran on 18-07 and a fresh-agent audit
scored the result GEO 88 / SEO 86 / Greek 93. Applying it again measures *the marginal value of
re-optimising an already-optimised page* — a legitimate question, but **not the question §0 of
the plan asks**, and the two must not be reported as if they were the same.

**2.4 It is not all cost — there is a natural experiment already running.** See §4.

---

## 3. The change freeze the pilot requires

The staged **NOBO spec-defect fix pack** (`products/nobo/DEPLOY-RUNBOOK_06-08-2026.md`,
fresh-agent pre-flight 07-08: 8 core fixes PASS, awaiting Sani's "save it") references exactly
four records, by ProductId, across the whole runbook:

| Record | Mentions in runbook | Relationship to the pilot |
|---|---|---|
| **823327** Nobo NTL4T | 11 | **A pilot page.** Tolerance fix, Class II row delete, 3× schema `PropertyValue` removal. |
| **965262** Nobo NTL4R WiFi | 10 | Excluded from the pool (C1/C2 defects) — but shares the cluster and the category. |
| **132676** Θερμοπομποί | 9 | The pool's parent category (±0.5°C typo fix). |
| **132671** Θέρμανση | 8 | The grandparent category. |

No accessory record appears (exhaustive 6-digit ID scan of the runbook: those four IDs only).

**The conflict, stated plainly: the staged pack and the pilot cannot both run on these records in
the same window without one contaminating the other.** Three dispositions exist and they are
Sani's to choose, not the coordinator's:

- **(a) Ship the pack first, then start the pilot's baseline no earlier than 28 days after the
  pack's live-verify date.** Costs ~4 weeks of calendar (see the deadline arithmetic in
  `DESIGN-ANALYSIS-2026-08-12.md` §5) and pushes CP4 into January.
- **(b) Freeze the pack for the pilot's full window (baseline + 12 weeks).** Costs: known,
  gate-passed spec defects stay live on a NOBO page for ~14 more weeks. That is a real
  correctness cost and should not be described as free.
- **(c) Ship the pack and drop 823327 from the pool.** The pool falls from 4 pages to 3, and
  pair 1 — the only pair the analysis called sound — is destroyed. This makes widening
  effectively mandatory.

**Freeze list, if (b) is chosen.** For the whole window, no non-pilot content change to:
965528 · 823327 · 823277 · 823322 · 132676 · 132671 — plus, if the deseasonalisation index of
`PRE-REGISTRATION-2026-08-12.md` §5 is used, the eight accessory pages, 891227 and the blog post
18567 that make up that index. Anything that changes anyway is a `site-change` confound row in
`PILOT.md` §6, recorded on the day it happens rather than reconstructed at CP4.

**Also inside the freeze question, decided separately:** the C1 NTL4T/NTL4R slug collision is
still live as of 2026-08-12 and its fix needs a slug change plus a 301 (platform-level, Sani's
call, recorded in the eshop project's status banner). A 301 landing mid-window on a URL adjacent
to two pilot pages is a confound; landing it *before* the baseline is clean. It should be
sequenced with the same ruling as the fix pack, not left to happen.

---

## 4. The retrospective read this makes available — the fastest route to real outcome data

**This is the single highest-value consequence of the register above, and it needs nothing from
input 1 or input 3.**

The property already contains dated, documented, live-verified content interventions with
before-states captured at byte level:

| Intervention | Date | Before-state artifact on disk | Age at 2026-08-12 |
|---|---|---|---|
| F119 823277 — full optimisation pass | 2026-07-18 | `products/atlantic/F119/_backups/LIVE-{GR,EN}_823277_2026-07-18_115708.html` + meta backup | 25 days |
| F120 965528 — zero-JSON-LD → ProductGroup + FAQPage | 2026-07-18 | slot-2 was empty (additive; DB read-back lengths recorded in the manifest) | 25 days |
| NTL4T 823327 — capsule | 2026-07-12 | `Description_1` length fingerprint 15,913 recorded pre-capsule | 31 days |
| NTL4T 823327 + categories — wave-2 rewrite | 2026-07-26 | `_backups/categories/thermansi-heating_26-07-2026/` render snapshots | 17 days |

Each of these is a **before/after already in flight**, at or just past the 4–6 week directional
threshold. Reading them requires **only input 2 (a GSC export)** — no publication, no approval,
no live write, zero risk to the property.

What the retrospective read can and cannot do:

- **Can**: produce this property's *own* first real outcome numbers, weeks before any pilot could;
  supply realistic magnitudes so the pilot's pre-registered thresholds are calibrated against
  this property rather than chosen in the dark; and tell us whether F119's 18-07 pass moved
  anything at all — which is directly informative about whether the pilot's treatment is worth
  running.
- **Cannot**: support a causal claim. There is no control arm, no pre-registration, and the
  26-07 category rewrite overlaps the window. It is **observational and must be labelled so on
  every read.** It does not replace the pilot and must never be reported as the pilot's result.

Recommended sequence, offered for Sani's selection and not acted on: **pull the GSC export →
run the retrospective read → set the pre-registration thresholds from what it shows → then run
the pilot.** The export needed is the same one the pilot needs; the spec is at
`docs/loop/pilot/data/README.md`.

---

## 5. What was not checked

- Whether 823322's rendered JSON-LD arrived by deploy or by template (§1, `[VERIFY]`).
- Whether the four pages carry interventions recorded **only** outside the eshop project tree
  (e.g. an admin change made without a deploy record). A page's admin `Modified` timestamp would
  settle it; that is an admin read, gated.
- The EN locale. The 26-07 record notes **no English product pages exist at all** on this
  property (EN categories do), so `Description_2` on products has no rendering surface. If that
  still holds, the pilot is GR-only in fact whatever it says on paper — and the EN-inventory
  item owed by `pair-analysis-2026-08-11.md` §5 may be moot. `[VERIFY]` before scoping locales.
