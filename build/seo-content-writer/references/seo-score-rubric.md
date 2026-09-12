# Overall SEO Score — Rubric and Arithmetic

Companion to [SKILL.md](../SKILL.md) step 10. Step 10 emits one number, the **Overall SEO
Score**, and this file is what makes that number reproducible: what each of the ten factors is
graded on, how the ten grades compose into the score, what happens when a factor cannot be
checked, and how this score relates to the on-page checklist and to the CORE-EEAT scores it is
easily confused with.

**The convention here is borrowed, not invented.** The grade-per-item / plain-sum / print-the-
derivation shape is the one already used by
[`optimize/on-page-seo-auditor/references/scoring-rubric.md`](../../../optimize/on-page-seo-auditor/references/scoring-rubric.md)
and the N/A and rounding mechanics are those of
[`cross-cutting/domain-authority-auditor/references/score-arithmetic.md`](../../../cross-cutting/domain-authority-auditor/references/score-arithmetic.md).
Three scoring skills using one convention is the point; a fourth convention would not be.

**What is house convention and what is not.** Every *criterion* below is a requirement the
skill already states somewhere else (step 4, step 5, step 6, step 7, step 8, the Input and
Output Validation checkpoints) — this file adds no new SEO requirement. The *bands* — where
the line between 1, 0.5 and 0 falls — are this library's convention, chosen so two people
scoring the same draft land on the same number. They are not engine-published thresholds and
must never be reported to a client as if a search engine set them.

---

## 1. The chain, in order

| # | Figure | Composed from |
|---|--------|---------------|
| 1 | Factor grade | met = **1** · partly met = **0.5** · not met = **0** |
| 2 | Overall SEO Score | the plain sum of the ten factor grades, **out of 10** |
| 3 | Reported score | that sum, printed as arithmetic, on the denominator actually scored |

One point per factor, ten factors, no weights and no conversion step — a reader checks the
score by adding the ten numbers the review already printed. Print the sum as arithmetic:

```
Overall SEO Score = 1 + 1 + 1 + 0.5 + 1 + 0.5 + 0 + 1 + 1 + 1 = 8.0/10
```

A score with no arithmetic beside it is an assertion, not a derivation. Every factor also
prints the one-line reason it earned its grade, because "0.5" without a reason cannot be acted
on and cannot be checked.

---

## 2. The ten factors and what each is graded on

| # | Factor | 1 — met | 0.5 — partly met | 0 — not met |
|---|--------|---------|------------------|-------------|
| 1 | **Title** | Recommended title contains the primary keyword **and** is ≤60 characters | One of the two holds | Neither holds |
| 2 | **Meta description** | Contains the primary keyword, carries a CTA or value element, **and** measures 150–160 characters | Keyword present but length outside the band, or CTA missing | No meta description, or no keyword in it |
| 3 | **H1** | Exactly one H1, and it contains the primary keyword | One H1 without the keyword, or the keyword present but more than one H1 | No H1, or several H1s none of which carries the keyword |
| 4 | **Keyword placement** | The primary keyword appears in all five required positions — title, H1, first 100 words, at least one H2, conclusion | Three or four of the five | Two or fewer |
| 5 | **H2 structure** | Hierarchy runs H1→H2→H3 with no level skipped (O01), at least one H2 carries a secondary keyword or a real query, **and** every H2 passes the information-gain test | Hierarchy clean but one of the other two legs fails | A heading level is skipped, or no H2 carries a secondary keyword or query |
| 6 | **Internal links** | 2–5 internal links, each with its relevance stated | Exactly 1, or more than 5, or links present with no stated relevance | 0 |
| 7 | **External links** | 2–3 links to authoritative sources that resolve, each supporting a named claim | Exactly 1 | 0 |
| 8 | **FAQ** | ≥3 questions taken from real query variants, answers in the 40–60-word band | ≥3 questions but answers outside the band | Fewer than 3 questions, or no FAQ |
| 9 | **Readability** | All four hold: paragraphs of 3–5 sentences, varied sentence length, bullets/lists used, key phrases bolded | Two or three hold | One or none holds |
| 10 | **Word count** | Meets the agreed target range **and** the 800-word floor for substantive content | Clears the 800-word floor but misses the agreed target range | Below the 800-word floor, or below an agreed floor that is higher |

Three standing clarifications, because each of them has to be decided the same way every time:

- **Keyword density is not a scoring input.** The Output Validation note is explicit that the
  1–2% band is a guideline, not a rule; semantic coverage is what factor 4 grades, through
  placement rather than frequency. Do not convert a density figure into a grade.
- **A bracketed placeholder is not a citation and not a link.** A draft whose sources are all
  `[SOURCED STAT: …]` scores **0** on factor 7 and says so in one line — the placeholders are
  the honest form for an unsourced figure, and they are also the evidence that the citation bar
  is unmet. The same holds for factor 6 against `[/your-page-url]`-style targets that do not
  exist yet. Scoring a placeholder as though the link were live inflates the score in exactly
  the place a reader most relies on it.
- **Grade the deliverable in front of you.** Factor 3 grades the H1 in the draft, not the H1
  you intend to write; factor 7 grades links that resolve, not link *recommendations*. If the
  deliverable is a draft plus a set of recommendations, the recommendations are not scored.

---

## 3. A factor you cannot check — the denominator shrinks, the factor never scores 0

An unscoreable factor is marked `N/A — requires [input]` and **excluded from the numerator and
from the denominator**. Zero means measured and failing; blank means unmeasured, and collapsing
the two destroys the reader's ability to tell a bad page from an unseen one.

```
Overall SEO Score: 7.5/9 factors scored — internal links N/A (single-page pre-launch site,
no other pages to link to)
```

The exclusion path is narrow, and it is not an escape hatch:

- **Legitimately excluded**: internal links on a site that has no second page yet; meta
  description when the deliverable is a section rewrite that ships no meta tag; word count when
  the commissioned unit is a fixed-length component rather than an article.
- **Not excluded — this is a 0**: external links missing because nothing could be sourced; an
  FAQ absent because the brief carried no questions; a word count short because the draft ran
  out of material. Absence of the thing being graded is a measurable fail.

**If no factor can be scored, the deliverable carries no Overall SEO Score at all** — it
carries the list of what is missing and which input unlocks which factor. A score for content
nobody has read is a fabricated figure, whatever the requester says about the deadline.

---

## 4. Rescaling to /10 when a factor was excluded

Only if a /10 figure is genuinely wanted alongside the honest denominator:

```
awarded ÷ factors scored × 10 = 7.5 ÷ 9 × 10 = 8.333… → 8.3/10 (9 factors scored)
```

Round half up at one decimal, and print the unrounded value beside the rounded one — it is what
lets a reader reproduce the figure regardless of which rounding convention they hold. In a
Greek-language deliverable the decimal separator is a comma («8,3»); the arithmetic is
identical and the comma is not a defect. Never print the rescaled figure without the
`(N factors scored)` label: `8.3/10` alone claims ten factors were checked when nine were.

---

## 5. Worked shape — print this

```markdown
### Final SEO Review

| # | Factor | Grade | Why |
|---|--------|:-----:|-----|
| 1 | Title | 1 | Keyword at front, 54 characters |
| 2 | Meta description | 1 | Keyword + CTA, 157 characters |
| 3 | H1 | 1 | Single H1, carries the primary keyword |
| 4 | Keyword placement | 0.5 | Present in title, H1, first 100 words, one H2 — absent from the conclusion |
| 5 | H2 structure | 1 | H1→H2→H3 clean; every H2 carries a datum, example or decision rule |
| 6 | Internal links | 0.5 | 1 internal link only (2–5 required) |
| 7 | External links | 0 | Every citation is a [SOURCED STAT: …] placeholder — no source is live |
| 8 | FAQ | 1 | 4 questions, answers 44–58 words |
| 9 | Readability | 1 | 3–5-sentence paragraphs, varied length, lists and bolding present |
| 10 | Word count | 1 | 1,340 words against a 1,200–1,500 target |

**Overall SEO Score** = 1 + 1 + 1 + 0.5 + 1 + 0.5 + 0 + 1 + 1 + 1 = **8.0/10**

**Unmet and how to close**: factor 4 — add the primary keyword to the conclusion; factor 6 —
add 1–4 internal links; factor 7 — source or license the three placeholder figures.
```

The figures in that block are the illustration's own, not defaults: recompute every one of them
from the draft in front of you.

---

## 6. The ten factors and the 23-box checklist are two different instruments

They are, and a reader cannot currently tell — so state it in the deliverable if you print
both.

- **The on-page checklist** in [seo-writing-checklist.md](./seo-writing-checklist.md) is **23
  unweighted boxes in four groups** (Keyword Placement 8 · Content Quality 6 · Readability 5 ·
  Technical 4). It is a **pre-flight list ticked while drafting**. It has no scale, no weights,
  and no aggregation rule, and a tally of ticked boxes is **not** an SEO score.
- **The ten factors** are the **scoring instrument**, and only they produce the Overall SEO
  Score.

Neither is a subset of the other:

| Checklist group | Feeds factor | Boxes that feed no factor |
|-----------------|--------------|---------------------------|
| Keyword Placement (8) | 1 Title · 2 Meta · 3 H1 · 4 Keyword placement · 5 H2 structure | related terms throughout body (factor 4 grades the five *primary*-keyword positions only) |
| Content Quality (6) | 7 External links (via the citations box) | comprehensive coverage · original insights or data · actionable takeaways · examples and illustrations · anti-slop pass |
| Readability (5) | 9 Readability | — |
| Technical (4) | 6 Internal links · 7 External links | image alt text · URL slug |

**Eight of the 23 boxes feed no factor** — they are drafting quality gates that the ten-factor
score does not see. **Two factors have no box at all**: FAQ (8) and word count (10); so do the
hierarchy and information-gain legs of factor 5. A high score therefore does not mean the
checklist is clean, and a clean checklist does not produce a score. Run both, report both, and
never present one as the other.

---

## 7. Not the same number as the CORE-EEAT scores

Three different numbers in this library are called some version of "SEO score", and merging
them is a reporting error:

| Number | Scale | Where it comes from |
|--------|-------|---------------------|
| **Overall SEO Score** (this file) | 0–10 | the ten factors above, in this skill's step 10 |
| CORE-EEAT **SEO Score** | 0–100 | the EEAT dimension average of the 80-item benchmark |
| CORE-EEAT **GEO Score** | 0–100 | the CORE dimension average of the same benchmark |

Step 10's self-check covers 16 CORE-EEAT items as pass/warning/fail; **16 items are not a
CORE-EEAT score** and must not be averaged into one. A CORE-EEAT SEO/GEO score comes from the
full 80-item audit in
[content-quality-auditor](../../../cross-cutting/content-quality-auditor/) — if the deliverable
prints one, it says which instrument produced it.

---

## 8. Pre-send recompute pass

Run this against the finished review, not from memory:

1. Ten factor rows are present; each prints a grade **and** the reason it earned that grade.
2. Every grade is 1, 0.5, 0 or an explicit `N/A — requires [input]`. Nothing else.
3. The sum recomputes from the rows as printed, and the arithmetic line is in the deliverable.
4. Excluded factors are named, and the denominator equals the number of factors actually
   scored. No excluded factor is silently carried as a 0.
5. No factor is scored on a placeholder, a recommendation, or an intention.
6. If a rescaled /10 figure appears, it recomputes and carries its `(N factors scored)` label.
7. Where the prose and the factor table disagree, the table wins — fix the prose.
