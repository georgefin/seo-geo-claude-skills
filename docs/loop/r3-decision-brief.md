# R3 — the decision, in plain language

**For Sani. Two pages. The full forensic version is `r3-supersession-candidate.md` (369 lines);
you should not need it to decide.**

---

## What happened

Settled ruling **R3** says Google ended FAQ rich results in 2026, and gives specific dates — the
search appearance dropped in June, the testing tool dropped in June, the API cut scheduled for
August.

R3 names two Google blog posts as its sources. On 11 August you opened both in a browser.
**Neither one contains any of it.**

The claims came from a **third** page — Google's Search Central changelog — which R3 never
mentions and **nobody has ever opened**. The ruling offered two URLs for checking and the
disputed claims came from somewhere else, so the check you ran verified the wrong documents.
It found nothing wrong with them because there was nothing wrong with them.

## What this does *not* mean

**It does not mean Google kept FAQ rich results.** They may well have ended them exactly as
described. What we lost is not the fact — it is our ability to show the fact.

That distinction is the whole issue. We were printing those dates in text clients read, as
things we knew. We did not know them.

## What we *do* solidly know

Three things, all from documents you read yourself, all quoted verbatim:

1. **August 2023** — Google narrowed FAQ rich results to "well-known, authoritative government
   and health websites". For everyone else: *"this rich result will no longer be shown
   regularly."* This is dated, quoted, and certain.
2. **Google's position on removal** — *"While you can drop this structured data from your site,
   there's no need to proactively remove it."* Permission to leave it alone, and explicit
   permission to drop it.
3. **On AI citations** — nothing establishes that FAQ markup earns them, and nothing refutes it
   either. Two documents cannot prove a universal negative, and we say so rather than pretending.

## What changes in practice: almost nothing

Our actual instructions to skills stay as they are. We keep generating FAQ markup where the page
genuinely is an FAQ. We promise no Google search feature. We never claim it earns AI citations.

**What changes is the reasons we print.** "Ended in 2026" becomes "restricted to government and
health sites since August 2023" — which is better, because it is sourced and it is also *more
useful*: it tells a client why their FAQ markup shows nothing, rather than just that it doesn't.

---

## Your decision — three options

### Option A — Rule now, on what is sourced
Replace R3 with a version carrying only the three certain facts, and mark the 2026 dates
"claimed, unverified".

*Cost*: if the 2026 events did happen, we have weakened a true ruling and will restore it later.

### Option B — Check first, then rule once
The verification pack is written and waiting: `r3-owner-verification-pack.md`. Five checks, about
ten minutes, and it names the single one worth doing if you only have three. Open a page, press
Ctrl-F, write down what you see.

*Cost*: the unsourced dates stay in client-facing skill text until you get to it.

### How much text this actually touches

Measured at the shell on 2026-08-13, because the forensic document's own estimate ("~14 places
across 6 skills") turned out to be **about half the real figure**, and a decision sized off a
stale count is a bad decision:

| Tier | Extent | What it says | If the check comes back empty |
|---|---|---|---|
| **Broad claim** | **28 lines, 14 files** | some form of "FAQ rich results ended in 2026" | Softens to the sourced fact — restricted to government and health sites since August 2023 |
| **Dated events** | **5 lines, 3 files** | the appearance dropped, the report dropped, the testing tool dropped, the API cut scheduled August 2026 | These come out. They are the load-bearing unsourced claims |

The concentration is the useful part: the sharp edges sit in three files
(`schema-markup-generator`'s validation guide and SKILL.md, and `commands/generate-schema.md`),
not spread across fourteen. **A "not there" answer is a morning's work, not a week's.**

### Option C — Split it *(recommended)*

Do the safe half immediately, hold the rest for your check:

- **Now** — stop *asserting* the 2026 dates anywhere a client reads. This is the same rule the
  library applied to itself today in two other places: an unsourced claim does not go in front of
  a client. It costs nothing if the dates turn out to be true.
- **Now** — keep R3's operating instruction exactly as it stands. No skill behaviour changes.
- **Held** — the formal supersession waits for your browser check.

This ends the exposure today and keeps every option open. It is the only one of the three where
being wrong is cheap in both directions.

---

## What I need from you

One line back, either:

> **"Do C — I'll run the checks when I get to them."**

or

> **"Wait for me — I'll check tonight."**

Anything else you want to say instead is fine too; these two are just the fast paths.

---

## One more thing, and it is the part that will matter longest

This was not a bad source. It was a **substituted** source: a ruling cited two documents while
its load-bearing claims came from a third.

**No check anywhere in this loop compares a ruling's cited sources against where its claims
actually came from.** Not the pre-push gate, not the claims gate, not the adversarial review. The
only reason we caught it is that you happened to open the two named URLs and found them empty.

That is a new failure class and it has no ledger entry yet. It is worth one regardless of how the
FAQ question resolves, because the next substituted citation will not have an owner reading the
wrong pages by luck.

---

*Prepared 2026-08-13. Neither `SETTLED-RULINGS.md` nor `GATED-ITEMS.md` has been touched — both
are reserved to your gate. Nothing in this brief has been applied.*
