# Brand mentions, June–July 2026 — what the log actually contains

**For:** Δημήτρης Ζαχαρόπουλος, CEO, Pharos Marine Data
**Date:** 2026-08-12
**Single input:** `evals/files/brand-mentions-export-pharos-jun-jul.md` — the freelancer's own log, every row
hand-opened on 2026-08-06. Nothing else is connected: no brand-monitoring tool, no SEO tool, no analytics,
no link tool. Every figure below is enumerated from that file and reconciles against it.

---

## The three answers, up front

1. **29 alert rows fired. 24 of them are third-party pages that mention this company.** Five were correctly
   excluded, for three different reasons — the chain is in §1 and it holds.
2. **Of those 24: 7 link to you, 17 do not.** These are two separate figures and this report never adds
   them into one "mentions" number, because they answer different questions and the split is the whole
   point. The unlinked 17 are **not** worthless — but what they are worth is not a search-ranking effect,
   and anyone who tells you it is should be asked for the measurement.
3. **What to do with them: the log itself shows that nothing has been done with any of them.** "No outreach
   has been attempted on any row in Table B" — the freelancer's own note. That is the actionable finding of
   this review, and it is about the work, not about the money.

---

## 1. How many mentions you really got

**Population: alert rows in the window 1 June – 31 July 2026.** Stated in the file header as 29, and all
29 appear in the file across three tables. Enumerated, then counted:

- **Table A** (mentions with a link): A1, A2, A3, A4, A5, A6, A7 → **7**
- **Table B** (mentions with no link): B1, B2, B3, B4, B5, B6, B7, B8, B9, B10, B11, B12, B13, B14, B15,
  B16, B17 → **17**
- **Table C** (excluded by the freelancer): C1, C2, C3, C4, C5 → **5**

Reconciliation: 7 + 17 + 5 = **29** = the stated raw alert volume ✓. The log is internally consistent; the
freelancer did not quietly drop rows.

### The exclusion chain, one rule at a time

Your own reading was "29 fired, seven linked, the rest is people talking about us". The 29 is right, the 7
is right, and the middle needs one correction: **five of the 29 are not mentions of this company at all**,
so "the rest" is 17, not 22.

| Step | Rule | Rows | Subtotal |
|---|---|---|---|
| Start — alert rows in the window | — | — | **29** |
| −1 | Owned channel — this is us posting about us | C1 (our LinkedIn post) | **28** |
| −1 | Paid distribution — our own press release republished verbatim | C2 (Δελτίο Τύπου Wire) | **27** |
| −2 | Different entity — **Faros Logistics ΑΕ**, the Thessaloniki freight forwarder | C3, C4 | **25** |
| −1 | Different entity — the **ancient Lighthouse of Alexandria** | C5 | **24** |
| **Third-party pages mentioning this company** | | | **24** |

Each removal is shown separately on purpose. Two of them are the same size and one of them is not the same
kind: C3 and C4 are one name collision (a Greek company whose Latin name reads like yours), C5 is a
different collision entirely (the monument). If those three were collapsed into "−3 not us", you would lose
the finding that **your alert terms are catching two distinct other things**, which is a fixable problem
and appears again in §4.

**A note on the 24.** It reconciles the alert feed; it is not a number to manage to. The two figures that
mean something are the 7 and the 17, and they are reported separately below precisely because a combined
"24 mentions this period" invites a trend line that would move for reasons that have nothing to do with the
company — a single conference programme, one podcast running two episodes.

---

## 2. The 7 with links

**Population: Table A, 7 rows.**

Link attribute, enumerated: dofollow → A1, A2, A3, A5, A6, A7 → **6**; nofollow → A4 → **1**.
Reconciliation: 6 + 1 = 7 ✓. All seven point at `pharosmarine.example`.

Sources: Ναυτιλιακή Επιθεώρηση (2026-06-04) · Λιμάνι News (06-11) · TechStartup GR (06-19) · Επιχειρείν
Τώρα (06-30, nofollow) · GreenShip Review (07-08) · Maritime Digital Weekly (07-16) · Ακαδημία Ναυτιλίας
(07-23).

**What the log cannot tell you about them:** nothing about the authority, traffic or referring-domain
profile of any of these seven. The file says so itself — no link tool has ever been run for this client, and
no traffic or click data exists for any of the pages. So "we got seven links" is a count of links, and any
statement about what those links are worth would be invented. That is a gap in the measurement, not
necessarily in the work.

---

## 3. The 17 without links — are they worth anything?

**Yes, but not for the reason you are measuring against.** Your framing is "no link, so it does nothing for
search". Two separate things are being conflated there.

**What an unlinked mention is not:** it is not a link, and nothing in this file measures any ranking effect
from one. I am not going to tell you unlinked mentions raise rankings — nobody in this session has data
that would support it, and you would be right to discount it if I did.

**What an unlinked mention is:** third-party, independent evidence that this company exists, is based in
Piraeus, and does voyage fuel analytics — published on a surface you do not control. That is the raw
material of entity recognition: it is what a directory, a search engine or an assistant has to work from
when it decides whether "Pharos Marine Data" is a thing it knows, and it is what a Wikipedia notability
assessment is built from later. Unlinked mentions are counted as their own entity signal for exactly this
reason, separately from links, and they are the category where this company is otherwise very thin.

**And in this specific log, several of the 17 are structurally more valuable than a link would have been:**

| Row | Source | Why it is worth more than its link status suggests |
|---|---|---|
| B12 | Green Corridors EU member list | An industry-association directory entry — independent, durable, and the **link field is simply empty**. This is not outreach, it is an email to an association you already belong to |
| B14, B16 | Ship Efficiency Blog; Sea Cargo Review | A comparison post and a market map — these place you *alongside* named competitors, which is the association you cannot manufacture on your own site |
| B2 | Ελληνική Ναυτιλιακή Λέσχη | A speaker listing in an event programme — independent evidence of participation, and it dates |
| B5, B6 | Shipping Ops Podcast, two episodes | Published transcripts, so the mention is text a crawler can read, not audio |
| B13 | Ναυτιλιακά Καθημερινά | A ship captain quoting your tool in an interview — a customer voice on someone else's masthead |

**And one is actively costing you:**

| Row | Source | Problem |
|---|---|---|
| **B9** | Marine Tech Digest, 2026-06-23 | Published verbatim: *"Pharos Marine Data, founded in 2015, sits in the same bracket as the larger noon-report vendors."* **You were not founded in 2015.** This is a wrong fact about your company, sitting on an independent trade page, indexed and quotable |

B9 is the single highest-value row in Table B and it is the one the retainer has not touched. A published
wrong founding year is not a missing opportunity, it is a competing fact.

**Also worth knowing:**

| Row | Source | Note |
|---|---|---|
| B4 | Forum Ναυτιλίας, 2026-07-14 | The one negative row: «η ενσωμάτωση με το ERP μας πήρε τρεις μήνες». No response has been posted |

**Sentiment across the 24** (the freelancer's own reading — no sentiment tool was used, and she says so):
Positive → A1, A2, A3, A5, A7, B1, B3, B5, B6, B8, B10, B11, B13, B14, B16, B17 = **16**; Neutral → A4, A6,
B2, B7, B9, B12, B15 = **7**; Negative → B4 = **1**. Reconciliation: 16 + 7 + 1 = 24 ✓.

**Distribution across the two months** (population: the same 24): June → A1, A2, A3, A4, B1, B2, B3, B5, B7,
B8, B9, B10 = **12**; July → A5, A6, A7, B4, B6, B11, B12, B13, B14, B15, B16, B17 = **12**.
Reconciliation: 12 + 12 = 24 ✓. Coverage is not front-loaded or tailing off; it is flat across the window.

---

## 4. The finding you did not ask for: your name is fragmenting

This one comes out of the same file and it is the reason several of these mentions are doing less for you
than they should.

**Population: the name form used in the text of the 24 third-party mentions — Table A and Table B together.**
Both tables are swept, because the two commonest forms appear in each and counting either table alone
undercounts them.

| Name form as printed | Rows | n |
|---|---|---|
| `Pharos Marine Data` | A2, A3, A6, B5, B9, B11, B14, B17 | 8 |
| `Φάρος` | A4, B3, B4, B8, B13 | 5 |
| `Pharos` | A5, B6, B7, B16 | 4 |
| `Φάρος Ναυτιλιακή Πληροφορική` | A1, A7, B2 | 3 |
| `Faros Marine Data` | B10, B15 | 2 |
| `Φάρος Marine Data` | B1 | 1 |
| `Pharos Marine Data PC` | B12 | 1 |

**7 distinct name forms across 24 mentions.** Reconciliation: 8 + 5 + 4 + 3 + 2 + 1 + 1 = 24 ✓.

Three things follow directly:

- **Five mentions call you simply «Φάρος»** — the bare Greek word. Table C shows what else answers to a
  name like that: two alert rows about **Faros Logistics ΑΕ** and one about the **ancient Lighthouse of
  Alexandria**. A mention that names you «Φάρος» and does not link is a mention that may not resolve to you
  at all.
- **Two mentions spell it `Faros Marine Data`** and one writes `Φάρος Marine Data` — mixed script. Neither
  matches anything you publish.
- **Nobody is doing this to you deliberately.** Journalists write what they are given, and no fact sheet or
  naming guidance exists to give them. This is a one-page fix on your side, not a PR problem.

---

## 5. On the €1,100

**I am not going to divide €1,100 by 24, or by 7, or by anything else in this log, and I would push back on
any report that does.** The reason is not delicacy about the number, it is that the quotient would be
meaningless and then dangerous:

- The denominator is whatever Google Alerts happened to catch on three search terms in a nine-week window,
  with the alerts only set up on 29 May 2026. It is a property of the alert feed, not of the work.
- The moment a cost-per-mention exists, it becomes the target. The cheapest way to move it is more low-value
  mentions on weak sources — which raises the count and changes nothing about how the market identifies
  this company. You would be paying for a metric to improve while the thing it stands for got worse.

**What you can hold the retainer against instead** — all of it visible in the freelancer's own file:

| Observable, from the log | Reading |
|---|---|
| 24 third-party mentions in nine weeks, flat across both months, 16 of them positive | Coverage is genuinely happening; this is not a dead account |
| 7 of 24 carry a link | A real ratio, from one population |
| **0 outreach attempts on any of the 17 unlinked rows** (her own note) | The gap. Link reclamation on rows like B12 — an association you belong to, with an empty link field — is the cheapest work in this document and none of it has been attempted |
| **B9's wrong founding year, published 2026-06-23, still standing on 2026-08-06** | Six weeks, uncorrected, on an independent trade page |
| **7 distinct name forms** and no fact sheet in circulation | Nothing is being handed to journalists to write from |
| No link tool, no analytics, no baseline of any kind ever run for this client | Nobody can currently say whether the coverage is doing anything, in either direction |

**The question that would actually settle it**, and it is answerable in a fortnight: *what is in her scope?*
If the engagement is "monitor and report", then this log is the deliverable and it is competently done — the
tables reconcile, every row was hand-opened, the exclusions are correct and reasoned, and the wrong-fact row
is flagged. If the engagement is "earn and place coverage", then 0 of 17 unlinked rows worked and 1 published
factual error uncorrected is the shortfall to put in front of her.

**One meeting, three asks, before you cancel anything:**

1. Take B9 to Marine Tech Digest with the ΓΕΜΗ date and get the founding year corrected.
2. Email Green Corridors EU (B12) and get the empty link field on your member entry filled.
3. Come back with a written scope and a list of which of the 17 unlinked pages are still editable.

If those three land inside a month, you have an outreach function and the €1,100 is buying something you can
name. If they do not, you have an alerts subscription with a person attached, and you will know that from the
work rather than from a ratio.

---

## 6. What this log does not contain

Stated so nothing above reads as more than it is:

- No referring-domain, backlink or authority figure for any of the 7 linking sources.
- No traffic, impression or click data from any of the 24 pages.
- No mention history before 1 June 2026 — the alerts were set up on 29 May 2026, so this is the entire
  recorded history, **not** a lifetime count and not a baseline you can compare a future period against yet.
  The second window is the one that becomes comparable.
- No AI-assistant test, no branded-SERP capture — so nothing here says how these mentions are being read by
  search engines or assistants. If you want that, it is a separate, cheap capture and it is worth doing
  before the next review, particularly given B9.
- Sentiment is one person's reading of each page, not a tool output.
