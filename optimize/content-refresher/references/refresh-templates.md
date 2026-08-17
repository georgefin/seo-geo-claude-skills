# Content Refresh Templates

Step 1's three quick-scan rules, and the detailed output templates for content-refresher
steps 5-9. Referenced from [SKILL.md](../SKILL.md).

---

## Step 1: CORE-EEAT Quick Scan — the three rules the template cannot hold

Author's rules, not report copy. [SKILL.md](../SKILL.md) Step 1 states them in one paragraph;
this is the full form, with the consequence each one carries.

### The veto line has three answers, not two

`"none"` is itself a finding. It asserts that no material connection exists on this page, so write
it only where you looked for one and there was none.

The third answer is the case this library's stated market hits by default: a retailer scoring its
own buying guide, where a material connection plainly may exist and nothing you were given settles
whether it is disclosed. That is neither Pass, nor Fail, nor "none". Write it as
`CORE-EEAT-T04 unassessable`, and beside it the single input that would settle it — a look at the
live page for a disclosure line, one question to the owner, the affiliate agreement itself. Do not
guess past it, do not round it down to "none", and do not coin a label of your own: a state this
skill does not define cannot be acted on by whoever receives it.

**It is consequential, which is why it may not be smoothed over.**
[core-eeat-benchmark.md](../../../references/core-eeat-benchmark.md) § Veto Items rules that where
evidence for a veto item is missing or unassessable, **no final score is issued at all** — not a
capped score, not a score with a caveat. This quick pass issues no final score either way, so
nothing changes for its own output; what changes is what the full 80-item audit may do with it, and
[inter-skill-handoff.md §4.3](../../../references/inter-skill-handoff.md) (*Veto status* row)
requires the handoff to transmit that state rather than a number. So it travels verbatim. T04's
other two answers are unchanged: a material connection undisclosed or materially obscured is the
veto, flagged by ID; no material connection at all is N/A, held out of the dimension average and
never recorded as Partial.

### A description of the page is not the page

Most of the eight dimensions are checkable only against the text itself — how a claim is sourced,
whether two passages contradict each other, whether a disclosure line exists, whether anybody
tested anything, whether the opening delivers what the title promises. A session holding a title, a
URL, one row of an inventory or somebody's summary of the page will therefore miss the three-item
bar in most of them, and each of those dimensions reads "not assessed". **That is the rule working,
not a failure to try harder** — estimating past it is the same defect as filling an N/A decay
signal from a typical case.

What the skill did not say before is how to report that outcome, and whether to start at all:

1. **Say what the scan ran on, once.** One line above the table — "scored from the inventory row
   and the title; the page text was not supplied" — rather than eight unexplained dashes.
2. **Count the assessed dimensions and name the rest together.** "Two of the eight assessed" is a
   claim a reader can weigh; a column of blanks is not.
3. **Name the one input that unlocks the rest** — the page's own text, pasted or fetched. Same
   drop-and-name rule the missing-topics table and the composite decay score already follow.
4. **Where no dimension reaches three checkable items, issue no quick scan at all.** Say that in
   one line with the input needed, skip Step 1, and run the refresh on the decay signals, which
   score from the inventory and the exports rather than from the prose. A Weakest Dimensions list
   is a ranking, and a ranking drawn from one assessed dimension out of eight is a sentence wearing
   a score — every refresh priority read off it would inherit that.
5. **The Weakest Dimensions list ranks assessed dimensions only, and says how many of the eight it
   drew from.** An unassessed dimension is never "the weakest"; it is unmeasured, and in a bare
   list the two look identical.

None of this licenses hedging on what you *can* read. A page supplied in full is scored normally —
the rule is about the input, never about confidence.

### Content Type here is description, not a routing key

The quick scan applies **no weight profile**. It is an unweighted read of the handful of items it
checked — `points ÷ (10 × items checked) × 100` — so it never needs a content-type column from the
benchmark's weight table, and it never improvises one for a type that has no column. Write the
Content Type field in the words the client would use: "retailer's buying guide", "how-to",
"product listing page".

Two questions inside this skill *do* route on a type, and both are looked up in
[content-decay-signals.md](./content-decay-signals.md):

| Question | Table | Where a buying guide lands |
|---|---|---|
| How often is this type refreshed? (Step 2's Cadence check) | *Update Strategy by Content Type* | No row of its own. That file's stated fallback reads it onto *Tool comparisons* — prices and models move under it — and the report names the borrowed row and why |
| How many hours does a refresh take? (refresh-difficulty scoring) | *Which playbook a content type uses* | Named outright in the first row: *Blog post, article, listicle, buying guide, evergreen guide* → Blog Post / Article |

The two need not land on the same row, and that file says so directly: a buying guide takes
blog-post hours and a tool-comparison cadence. They are two different questions, not a conflict.

---

## Step 5: Create Refresh Plan

```markdown
## Content Refresh Plan

### Title/URL
**Current**: [current title]
**Refreshed**: [updated title with year/hook]

### Structural Changes

**Keep As-Is**:
- [Section 1] - Still relevant and accurate
- [Section 2] - Still relevant and accurate

**Update/Expand**:
- [Section 3] - Update statistics, add [X] words
- [Section 4] - Add new examples from [current year]

**Add New Sections**:
- [New Section 1] - [description, ~X words]
- [New Section 2] - [description, ~X words]
- FAQ Section - [X questions the page's own queries actually raise; FAQ content, not markup]

**Remove/Consolidate**:
- [Section 5] - Outdated, remove or redirect topic

### Content Additions

**New Word Count Target**: [X] words (+[Y] from current)

| Section | Current | After Refresh | Notes |
|---------|---------|---------------|-------|
| Introduction | [X] | [X] | Add hook, update context |
| [Section 1] | [X] | [X] | Keep |
| [Section 2] | [X] | [X] | Update stats |
| [New Section] | 0 | [X] | Add entirely |
| FAQ | 0 | [X] | Add for GEO |
| Conclusion | [X] | [X] | Update CTA |
| **Total** | **[sum of Current]** | **[sum of After]** | [After ÷ Current]× the length; [new + rewritten] of [After] words is new |

### Specific Updates

**Statistics to Update**:

| Old Statistic | New Statistic | Source |
|---------------|---------------|--------|
| "[old stat]" | "[find current]" | [source] |
| "[old stat]" | "[find current]" | [source] |

**Links to Update**:

| Anchor Text | Old URL | New URL | Reason |
|-------------|---------|---------|--------|
| "[anchor]" | [old] | [new] | Broken |
| "[anchor]" | [old] | [new] | Better resource |

**Images to Update**:

| Image | Action | New Alt Text |
|-------|--------|--------------|
| [img 1] | Replace | "[keyword-rich alt]" |
| [img 2] | Keep | Update alt text |
```

### The word-count table is arithmetic, not an impression (author's rule, not template copy)

Both columns are sums of the rows above them, and the **Current** column must also reconcile with the
page's measured word count printed at the top of the analysis. Where they disagree the section list
is wrong — a section missing, or one counted twice — and the fix is to find it: a Current column
summing to 282 under a Total row reading 231 is a defect, not a rounding, and it is load-bearing
because Step 8's date decision is computed from these totals.

**State the change as arithmetic, never as an adjective.** The multiple is `After total ÷ Current
total`, printed to one decimal: 231 → ~2,240 words is **9.7×**, not "roughly triples". The
new-content share is `(new + rewritten words) ÷ After total`. Where an adjective and the table
disagree, the table is right — and the adjective is what carries a wrong republish-date
recommendation into the report.

---

## Step 6: Write Refresh Content

```markdown
## Refreshed Content Sections

### Updated Introduction

[Write new introduction with:]
- Updated hook for current year
- Fresh statistics
- Clear value proposition
- Primary keyword in first 100 words

### New Section: [Title]

[Write new section covering:]
- [Topic competitors now cover]
- Current information and examples
- GEO-optimized with quotable statements

### Updated Statistics Section

<!-- SKELETON — not publishable copy. The replacement figure comes from a source you
     have open right now, and the citation carries THAT SOURCE'S OWN publication year.
     Never stamp the year you are writing in onto a citation. If no source can be
     found, the statistic comes out of the article rather than being restated with a
     fresher-looking date. -->

**Replace**:
> "[Old statement with outdated stat]"

**With**:
> "[SOURCED STAT: what this sentence needs to claim --- cite the source by name and
> its own publication year]"

### New FAQ Section

## Frequently Asked Questions

### [Question matching PAA/common query]?

[Direct answer in 40-60 words — answer the question in the first sentence, then qualify]

### [Question 2]?

[Direct answer]

### [Question 3]?

[Direct answer]
```

### A caveat outside the copy does not travel with it (author's rule, not template copy)

Publish-ready copy is pasted into a CMS on its own. The report frame around it — the gap list, the
flags, the "we could not verify this" note — stays behind on somebody's screen, so a claim the
inputs do not support must never ship inside the fence with its warning outside it. That asymmetric
placement is ledger F13, and the warning loses every time.

Two ways out, and only two. **Drop the claim from the copy** and name the gap in the plan prose —
which fact, what its absence costs the reader, exactly what to send — per the Value Rule that a
paste-ready block carries resolved values only. Or, where the reader genuinely needs the point,
**write it in the customer's own voice with the hedge inside the sentence** — "the right capacity
depends on how many people draw hot water at once, so ask us for a sizing check before you order",
in the deliverable's own language. That carries the caution into the CMS because it *is* the copy. A
specific figure has no hedged form: a capacity, a price, a percentage ships sourced or not at all.

### Correcting claims about SERP features (author's rule, not template copy)

An old article often states what Google *shows* — rich results, snippets, panels. Correct only what
this library has settled, and only that far. The rule governs the refreshed copy the client
publishes, where an unresolved claim reads as fact:

- **No FAQ rich result for an ordinary site — no SERP feature to promise** (settled ruling R3).
  **What is sourced, and where** — Google Search Central blog, *"Changes to HowTo and FAQ rich
  results"*, dated **2023-08-08**, at
  `https://developers.google.com/search/blog/2023/08/howto-faq-changes`: FAQ rich results *"will
  only be shown for well-known, authoritative government and health websites"*, and *"For all other
  sites, this rich result will no longer be shown regularly."* That post was read in a browser by
  the owner on 2026-08-11 (`docs/loop/WATCH-ITEMS.md` W12), which is why this is the
  best-evidenced sentence in this section; `developers.google.com` is refused by this environment's
  own egress, so it cannot be re-read from a run. Give the client the date and the URL, never the
  ruling handle. What is **not** sourced and must not be written into copy: this library's further
  claim of a full 2026 end (`docs/loop/r3-decision-brief.md`). An article promising them
  is wrong, and the line is rewritten. FAQPage markup, where a page justifies it under R2, is kept
  because it is valid schema.org, costs nothing to keep, and Google says there is no need to
  proactively remove it — a permission to leave existing markup alone, never written up as Google
  advising anyone to keep it. It promises nothing on the SERP, and the refreshed copy does not claim
  it earns AI citations either: no primary source establishes that in either direction (R3
  amendment 9a).
- **Every other feature's status is open until this library settles it.** HowTo rich results are the
  live case: that question is an open `[VERIFY]` item in the watch register (W12,
  `docs/loop/WATCH-ITEMS.md`), so refreshed copy asserts nothing about them in either direction —
  not that they still appear, not that they are gone. Flag the sentence for verification against
  Google Search Central before publication and write what is actually known: as of this run, the
  claim is unverified.
- **A retirement one type underwent is not evidence about another type.** Do not generalise from the
  FAQ line to any other feature; each is settled or it is not.

### Correcting stale technical claims (author's rule, not template copy)

**Check the settled register before hedging.** "Correct only what is settled" has a second half that
binds just as hard: **where this library has settled it, correct it — do not hand it back to the
client as unverified.** Declining to state a figure `docs/loop/SETTLED-RULINGS.md` establishes is not
caution, it is the abstention overshoot (ledger F19), and its cost is invisible in review: the
client republishes a section this repository had already closed, and nothing in the deliverable looks
wrong.

- **Core Web Vitals — settled, ruling R4.** "Good" is **LCP ≤2.5 s, INP ≤200 ms, CLS ≤0.1**. **First
  Input Delay was retired in March 2024** and INP is the responsiveness metric that replaced it. The
  circulating **2.0-second LCP** figure is a vendor-blog number, not Google's. An old article
  teaching FID, or 2.0 s as "Google's LCP benchmark", is corrected in place with those figures, and
  the correction names which metric replaced which. Re-teaching FID as live fails; so does sending
  the reader to Google's documentation for a threshold printed right here.
- **They are cited as this library's settled ruling**, which is what they are (R4; reopens only on a
  Google-primary threshold change) — not as a fresh reading of Google's documentation that nobody in
  this session performed.
- **How far R4's backing goes, so "settled" is not taken on trust.** The entry is
  `docs/loop/SETTLED-RULINGS.md` R4 — a register an operator can open and a fresh session cannot.
  It records the thresholds as Google's own, and records that it reopens only on a Google-primary
  change (web.dev / Google Search Central); it names **no source URL and states no evidence grade**,
  so what this skill holds is the ruling, not a document anyone read here. **That governs
  attribution, never disclosure.** The figures ship in the corrected copy either way: they are fixed
  definitions that need no connected tool, no client baseline and no confirmation before they are
  written down, and withholding them is the abstention overshoot this skill's own case founded
  (ledger F19). Where a client asks where the numbers come from, send them to Google's Core Web
  Vitals documentation — not to this register, whose handles are operator vocabulary.
- **Anything not in the register stays open** and the SERP-feature rule above governs it: flag it for
  verification, assert nothing in either direction. The register is the stopping condition, not a
  licence to correct by memory.

---

## Step 7: Optimize for GEO During Refresh

```markdown
## GEO Enhancement Opportunities

### Add Clear Definitions

**Add at start of article**:
> **[Topic]** is [clear definition in 40-60 words that still says what the
> thing is when lifted out of the article on its own].

### Add Quotable Statements

<!-- SKELETON — not publishable copy. What makes a statement quotable is a real figure
     with a real source, so the slot below stays a slot until you have consulted one.
     A statement that cannot be filled from a source you have read gets cut, not
     guessed. -->

**Transform**:
> "Email marketing is effective for businesses."

**Into**:
> "Email marketing remains one of the highest-ROI channels available to
> small businesses ([SOURCED STAT: average email ROI --- cite the source
> by name and its own publication year])."

### Add Q&A Sections

Structure content with questions AI might answer:
- What is [topic]?
- How does [topic] work?
- Why is [topic] important?
- What are the benefits of [topic]?

### Update Citations

- Every statistic names the source it came from, and links to it where a public URL exists
- The date in a citation is the **publication year printed on the source you actually
  consulted** — never the current year, and never a year inferred to make a source look
  recent. A citation date is a fact about the source, not a freshness lever
- Prefer sources published in the last 2 years; when the best available source is older,
  cite its real date and say in the sentence how old the figure is
- A statistic with no consultable source does not ship: cut the claim, or leave the
  `[SOURCED STAT: ...]` slot open in the draft so the gap is visible before publication
```

---

## Step 8: Generate Republishing Strategy

```markdown
## Republishing Strategy

### Date Strategy

**Options**:

1. **Update Published Date**
   - Use when: Major overhaul (50%+ new content)
   - Pros: Signals freshness to Google
   - Cons: Loses "original" authority

2. **Add "Last Updated" Date**
   - Use when: Moderate updates (20-50% new)
   - Pros: Shows both original and fresh
   - Cons: Original date visible

3. **Keep Original Date**
   - Use when: Minor updates (<20% new)
   - Pros: Maintains authority
   - Cons: Doesn't signal update

**Recommendation**: [Option X] because [reason]

### Technical Implementation

- [ ] Update `dateModified` in schema
- [ ] Update sitemap lastmod
- [ ] Clear cache after publishing
- [ ] Resubmit to Search Console

### Promotion Strategy

**Immediately after refresh**:
- [ ] Share on social media as "updated for [current year]"
- [ ] Send to email list if significant update
- [ ] Update internal links with fresh anchors
- [ ] Reach out for new backlinks

**Track Results**:
- [ ] Monitor rankings for 4-6 weeks
- [ ] Track traffic changes
- [ ] Watch for featured snippet capture
- [ ] Check AI citation improvements
```

**Which date option applies is computed, not judged (author's rule, not report copy).** The three
options are bands of one fraction — `(new + rewritten words) ÷ post-refresh total`, both figures
taken from the Step 5 word-count table — so compute it and print it beside the recommendation. A
plan taking a page from 231 to ~2,240 words is 9.7× the length and **at least 89.7% new** — 2,009 of
2,240 words, even if every existing word survives untouched. That is option 1, a major overhaul, and
no adjective in the prose ("roughly triples", "a moderate update") moves it into option 2. Where the
sentence and the fraction disagree, the fraction decides.

---

## Step 9: Create Refresh Report

```markdown
# Content Refresh Report

## Summary

**Content**: [Title]
**Refresh Date**: [Date]
**Refresh Level**: [Major/Moderate/Minor]

## Changes Made

| Element | Before | After |
|---------|--------|-------|
| Word count | [X] | [Y] (+[Z]%) |
| Sections | [X] | [Y] |
| Statistics | [X] outdated | [Y] current |
| Internal links | [X] | [Y] |
| Images | [X] | [Y] |
| FAQ questions | 0 | [X] |

## Updates Completed

- [x] Updated title with current year
- [x] Refreshed meta description
- [x] Added [X] new sections
- [x] Updated [X] statistics with sources
- [x] Fixed [X] broken links
- [x] Added FAQ section for GEO
- [ ] FAQPage markup — added only where the page justifies it; unchanged otherwise
- [x] Updated images and alt text

## Expected Outcomes

| Metric | Current | 30-Day Target | 90-Day Target |
|--------|---------|---------------|---------------|
| Avg Position | [X] | [Y] | [Z] |
| Organic Traffic | [X]/mo | [Y]/mo | [Z]/mo |
| Featured Snippets | [X] | [Y] | [Z] |

Every target in this table states the assumption it rests on, in the sentence
underneath it — otherwise write "not projected; to be measured after republishing".
A refresh does not convert into a position or a traffic figure by any model this
skill carries, so a bare number here is a guess wearing a target.

## Next Review

Schedule next refresh review: [Date - 6 months from now]
```

**On the FAQPage line** (author's rule, not report copy): the box is ticked only where the page
passes ruling R2's both-things test — it genuinely is both its primary type and an FAQ resource,
each complete and independently justified. Otherwise the FAQ content ships and the schema is left
alone, and the report says so. Either way, what may be claimed for the markup is the basis the
ruling supports and no more: it is valid schema.org, it costs nothing to keep, and Google advises
against proactively removing it. An ordinary site gets no FAQ rich result — since 2023-08-08 Google
shows those only for well-known, authoritative government and health websites
(`https://developers.google.com/search/blog/2023/08/howto-faq-changes`, 2023-08-08) — so no SERP
feature is promised; and no primary source establishes an AI-citation benefit either way, so the
markup is never sold as earning AI citations (ruling R3 + amendment 9a; the source and its reading
grade are in §"Correcting claims about SERP features" above, and the handle stays out of the
report — the client gets the date and the URL).

**On every score this report prints** — a CORE-EEAT quick score, the composite decay score, the
refresh priority score, an ROI figure: the derivation sits beside the number, and a signal or factor
with no input is shown N/A with its missing input named, never estimated into a value. The rules and
worked derivations are in [content-decay-signals.md](./content-decay-signals.md).
