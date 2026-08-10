# Competitor Analysis — Confidence and Evidence Rules

Three rules govern every competitor deliverable this skill produces. They are stated in
`SKILL.md` (step 2 and the *Confidence Labels* block) and repeated here in full with worked
examples, because a rule that lives only in the skill body is not a carrier for the file the
model actually copies from.

**Standing rule for every example in this directory** — an illustrative example never attributes
data or a quotation to a real organisation or a real person. Use a clearly fictional attribution
on the reserved `.example` TLD, or cite something genuinely verifiable with its link.

---

## 1. The confidence convention: Confirmed · Likely · Hypothesis

Every finding the report **concludes** carries one of three labels, written into the report.

| Label | Means | Evidence it must show |
|---|---|---|
| **Confirmed** | Directly observed in the content or data you were given | The verbatim quote, the export row, the count you ran |
| **Likely** | Strong indirect evidence; not observed in the supplied material | The indirect signal, named — and why it is indirect |
| **Hypothesis** | Plausible, unverified | **The check that would confirm it**, concretely enough to do this week |

Pass-through material — a fixture quote reproduced verbatim, an export row copied as-is — may
omit the label. Anything you concluded from that material carries one.

### The two rules the labels exist for

**(a) A causal ranking explanation is never Confirmed.** Page copy, a tool export and an AI
answer all show *what* is true. None of them shows *why* an engine ordered the results, because
the ranking function is not in any of them. So "they outrank you because their guide carries
first-party test data" is a **Likely** at best and usually a **Hypothesis** — however solid the
underlying observation is. The observation may be Confirmed; the causal step never is.

**(b) Every Hypothesis names what would confirm it.** A Hypothesis with no verification step is
not deliverable: either run the check or drop the finding. "Verify in Search Console" is not yet
a step; "export Search Console → Performance → Queries → last 3 months and look for these five
terms" is.

### Prose caution is not a label

A section that opens "two saved pages cannot prove *why* Google ranks them above you", or a
closing *What This Analysis Does Not Claim*, is good practice and does **not** satisfy the
convention. The convention is per-finding. A report can be epistemically careful in every
paragraph and still ship twenty unlabelled findings.

Hedging words are not labels either — "likely", "probably", "arguably", "seems to" inside a
sentence are register, not epistemics. The label is a discrete token attached to the finding.

### Worked examples

```markdown
**Their opening paragraph is a standalone definition.** — Confirmed
*Evidence:* "A standing desk is a height-adjustable work surface…" (their guide, opening line);
your equivalent page opens "Welcome to DeskNord!".

**That definition-first shape is part of why they win the query.** — Hypothesis
*Would confirm it:* run the head term logged-out on three days this week and record which
passage the featured snippet lifts. If it lifts their opening sentence, the shape is doing work.

**They publish more often than you.** — Likely
*Indirect signal:* their index page lists 14 dated posts in the last 90 days; yours lists 2.
*Not Confirmed:* the index may be paginated or partial — a full crawl would settle it.
```

### Greek deliverables — Ελληνικές ετικέτες

Use the Greek labels in Greek reports; the three rules are identical.

| English | Greek label | Definition to state on first use |
|---|---|---|
| Confirmed | **Επιβεβαιωμένο** | άμεσα παρατηρημένο στο υλικό που δόθηκε |
| Likely | **Πιθανό** | ισχυρή έμμεση ένδειξη, όχι άμεση παρατήρηση |
| Hypothesis | **Υπόθεση** | χρειάζεται επαλήθευση — ονομάστε τον έλεγχο |

```markdown
**Η εισαγωγή τους είναι αυτοτελής ορισμός.** — Επιβεβαιωμένο
*Τεκμηρίωση:* «Η αποκατάσταση γόνατος είναι…» (οδηγός τους, πρώτη πρόταση).

**Αυτό εξηγεί γιατί εμφανίζονται πάνω από εσάς.** — Υπόθεση
*Τι θα το επιβεβαίωνε:* τρέξτε τους έξι όρους σε ανώνυμη περιήγηση τρεις διαφορετικές μέρες και
σημειώστε ποιο απόσπασμα ανεβάζει η Google.
```

The label belongs to the report frame. It never appears inside sample copy drafted for the
client's own website — that is the F13 placement guard, and «Υπόθεση» sitting in a proposed FAQ
answer is the same defect as an agency provenance marker sitting there.

---

## 2. Hard metric vs soft quantity

### Hard metrics — never reconstructed

Organic traffic · ranking positions · ranking-keyword counts · domain authority or rating ·
backlink counts · referring-domain counts · search volume · keyword difficulty.

These are **measurements**. A tool measures them against an index you do not have. If the
export, the tool or the user left one empty, it stays empty, with the pull that would fill it
named. Specifically forbidden, because each has been shipped at least once:

- deriving one competitor's traffic from another competitor's traffic-per-keyword ratio;
- multiplying a keyword count by any per-keyword figure to produce visits;
- carrying a figure sideways from a sibling row "as a working assumption";
- presenting the result as a **range** (a range is two fabricated numbers, not a hedge);
- presenting it "for planning only", "explicitly a model, not a measurement", or with a ± band.

**A number is not made admissible by the label attached to it.** The reader keeps the number and
loses the sentence around it. And a report that answers a landscape cell `n/a — not shown by the
expired trial` and then supplies a figure for that same cell three sections later has produced
one defect, not two disclosures — it contradicts itself, which is worse than either half.

The honest form:

```markdown
| Metric | You | Competitor A |
|---|---|---|
| Organic traffic / month | n/a — the trial did not return it | 19,600 (your Semrush export, 2026-08-06) |

Your own traffic is not in the export and cannot be derived from it. Two free ways to fill it:
Search Console → Performance → last 28 days (clicks), or GA4 → Acquisition → Organic Search.
Either one takes five minutes and the number is then real.
```

### Soft quantities — inferable, if you show the count

How many pages a section appears to hold · publishing cadence · content-mix share · audience
shape · how long an archive would take to build at an observed rate.

These may be **estimated from what you can count**, provided the estimate says so in the same
breath and shows the count it rests on:

```markdown
Their guides section lists 14 dated posts across the last 90 days, so roughly one a week.
(This is an inference from what their index page lists, not a measurement — publishing cadence
was not in the export, and a paginated index would change it.)
```

**The line is not hedged vs. unhedged.** It is whether the quantity is something a tool
*measures* — never reconstruct it — or something you *counted in front of you* — infer it, show
the count, label the inference. When in doubt: could a competent person reproduce your number
from material the client already has? If yes it is a soft quantity; if it needs a tool the
client does not have, it is a hard metric and it stays out.

### Arithmetic you do publish

Any ratio, multiple, share or per-unit figure you compute must be consistent with the rows it
came from *and* with your own appendix. Recompute it rather than restating it from memory: a
summary sentence that contradicts the appendix two hundred lines below is the failure mode this
paragraph exists for, and it is invisible to every source-labelling rule above because both
halves are honestly sourced.

---

## 3. Out-of-scope requests — the refusal branch

When the request is really own-site keyword strategy, own-site content quality or own-site
technical health, this skill does not build it. The reply has four parts and no fifth:

```markdown
## What you asked for, and where it belongs

Expanding your five seed topics into a keyword set with per-keyword volume, difficulty and
intent, grouping them into pillars and clusters, and ranking them by opportunity is a dedicated
keyword-research job — seed expansion, intent classification, difficulty assessment, opportunity
scoring and clustering are its five documented capabilities, and your request maps onto all
five. Run `keyword-research` with these seeds and it will come back with the plan.

## What competitor analysis covers, so you know what you can get from me

Competitor identification, page-level and export-level competitor analysis, keyword *gap* work
against a named competitor, backlink and GEO comparison, and the synthesis report.

## What I can usefully give you now — competitor-analysis pieces, not the keyword plan

1. The Competitor Identification Framework as three questions to answer this week …
2. The manual-data checklist: what to send so the competitor analysis can run …

## What I am not doing

I am not producing the keyword plan here, even in outline. A keyword table built without the
tool that measures volume looks like the deliverable and is not one, and shipping it would
remove your reason to run the skill that does it properly. Your competitor *gap* analysis does
stay with me — send 2–3 saved competitor pages and it becomes runnable.
```

**Family-8 note.** The slug `keyword-research` above addresses the person operating the library;
they can act on it. In an artefact the client may forward, name the **job** and gloss the method
on first use — "a dedicated keyword-research pass: seed expansion, intent classification,
difficulty scoring and clustering" — never a bare code-formatted slug, and never a framework
item ID (`T03`, `O05`). See `build/seo-content-writer/references/anti-slop-ruleset.md` §6
family 8.
