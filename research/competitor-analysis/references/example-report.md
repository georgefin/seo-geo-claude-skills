# Competitor Analysis — Example Report

This is a complete example output showing the expected format for competitor analysis deliverables.

> **Illustrative example — the figures below are not measurements, and the subject is not a real
> company.** The competitor uses the reserved `.example` TLD, and every count, percentage and
> backlink figure is a made-up value chosen to show the output shape. In real output each one
> comes from ~~SEO tool, ~~analytics, or a check you ran yourself, and is reported with that
> source and the date — never assigned to a named business you have no data for (statistics
> rule: sourced, cited, or placeholder, never invented). This file is the one place in the
> library where that rule has a second edge: a competitor report describes a third party, so an
> invented metric — or an unevidenced weakness — is a checkable falsehood about someone else,
> published under your client's letterhead. The `~~` token stays outside the code fence; inside
> the deliverable it resolves to the tool's real name or to the source in plain language.
>
> **Read the confidence labels below as part of the format, not as decoration.** Every concluded
> finding carries **Confirmed** (directly observed) · **Likely** (strong indirect evidence) ·
> **Hypothesis** (unverified — names the check). Notice where they fall: the *counts* are
> Confirmed, and every claim about *why* the competitor wins is Likely or Hypothesis, because a
> ranking function is not visible in any export. Greek reports use **Επιβεβαιωμένο** ·
> **Πιθανό** · **Υπόθεση**. Rules in
> [confidence-and-evidence-rules.md](./confidence-and-evidence-rules.md).

## Prompt

**User**: "Analyze why contentleader.example ranks so well for marketing-related keywords"

## Example Output

```markdown
# Competitive Analysis: contentleader.example

**Data pulled**: 3 August 2026 · rank and link figures from the SEO-tool export; content and
page counts hand-verified against the competitor's own index pages on the same day

## SEO Strategy Overview

contentleader.example holds a top-3 position on 34 of the 50 head terms tracked for this niche
(**Confirmed** — the SEO-tool export, 3 August 2026). Four things in the audit are candidate
explanations of that pattern. None of them is Confirmed: the export shows what they have, never
why the engine ranks it.

1. **Content moat** - ~10,000 indexed blog URLs; at their current 50-100 posts/month that is
   8-17 years of publishing, so the archive is the moat, not the present cadence — **Likely**.
   The URL count and the cadence are Confirmed (export; their dated index). That archive size is
   what earns the positions is the inference, and it is a strong one because the 34 held terms
   map to 31 distinct archive URLs rather than to a handful of pages.
2. **Free tools as linkbait** - site auditor, headline generator (both un-gated) — **Likely**.
   The tools exist and carry the two largest backlink totals on the domain (table below); that
   the links came *because* the tools are free is not observable from a link export.
3. **Educational brand** - academy, certifications, courses — **Hypothesis**. Three named
   programmes are visible on their site; whether brand demand from them feeds search performance
   is untested here. *Would confirm it:* pull their branded-query share from any tool that splits
   branded from non-branded, and compare it against yours.
4. **Topic cluster model** - pillar pages with tightly linked cluster articles — **Confirmed as
   a structure, Hypothesis as a cause**. The internal-link pattern is visible on the pages; that
   it is doing the ranking work needs a test — pick five cluster URLs, check whether the pillar
   outranks them for the head term, and whether the clusters rank at all.

## What Makes Them Successful

### Content Strategy

**Publishing Volume**: 50-100 posts/month
**Average Word Count**: 2,500+ words
**Content Types** (share of the archive; sums to 100%):
- In-depth guides (35%)
- How-to tutorials (25%)
- Templates & examples (20%)
- Data/research (10%)
- Tools & calculators (10%)

**Top Performing Content Pattern**:
1. Ultimate guides on broad topics
2. Free templates with email gate
3. Statistics roundup posts
4. Definition posts ("What is [term]")

### GEO Success Factors

Of the 12 test queries run in step 7, contentleader.example was cited in 9 (**Confirmed** — the
queries and their answers are logged in the appendix, run 3 August 2026). The three patterns
below are **Confirmed** as counts over those 9 answers, and **Likely** as explanations: a
citation log shows which passage was lifted, never why the engine chose that page over another.
The one test that would move them to Confirmed is a before/after — restructure four of your own
pages to the same shape, re-run the same queries in 30 days, and compare.

The pattern across those 9:

1. **Clear definitions** at the start of the cited post - the sentence the engine lifted was the
   first sentence under the H1 in 7 of the 9
   > "Lifecycle marketing is a planning method that maps every message to the stage a buyer is
   > in, so each touch answers the question the buyer actually has."

2. **Quotable statistics** - their roundup posts open with a numbered claim carrying its own
   source line, and that is the form the engines lifted verbatim
   > "Teams that publish weekly get 55% more site visits (contentleader.example benchmark, 2025)"

   Record a competitor's statistic verbatim, with the source *they* cite, exactly as above. The
   audit reports what they published; it does not adopt the number, re-publish it as yours, or
   vouch for it.

3. **Coverage depth** - in 7 of the 9 citations the cited URL was a 2,000+ word guide rather than
   a short post, and the lifted passage was a definition or a numbered list every time, never
   narrative prose

### Linkable Assets

| Asset | Backlinks | Why It Works |
|-------|-----------|--------------|
| Free site auditor | 45,000+ | Free, instant value |
| Annual statistics roundup | 12,000+ | Quotable reference |
| Headline idea generator | 8,500+ | Solves real problem |

## Weaknesses to Exploit

Each item names the observation it rests on and where that observation came from, because this
section describes a third party. A gap you cannot point at is not a finding — leave it out
rather than characterise the competitor.

1. **Archive is not maintained** — **Confirmed**. 6 of the 10 pages the tool export lists as
   their highest-traffic URLs carry a `dateModified` older than three years (dates read off the
   pages themselves, 3 August 2026). The date is a fact on the page; "their content is stale"
   would be a judgement about quality, which this is not.
2. **No vertical-specific coverage** — **Confirmed**. A site: search for the four industry terms
   your buyers use returns 0 URLs on their domain, against 35% of their archive going to broad
   in-depth guides (mix above). What a competitor has *not* published is checkable; "generic
   advice" is not.
3. **No entry point below team-sized accounts** — **Confirmed** as published coverage. Every
   pricing and onboarding page assumes a team of five or more, and a site search for "freelance",
   "solo" and "one-person" returns 3 URLs, all inside one 2022 archive post. This states a gap in
   their published coverage, not a claim about who their customers are or who they choose to
   serve.
4. **Comparison and alternatives queries left open** — **Confirmed** as a coverage count,
   **Hypothesis** as an opening. A site: search for "vs", "alternative" and "comparison" returns
   4 URLs on their domain, each older than two years, while they hold top-3 on 34 head terms;
   countable from their own index in about ten minutes. Whether those queries are winnable is
   untested. *Would confirm it:* run six comparison queries logged-out and record who holds the
   first page — if third-party listicles hold it rather than vendors, the opening is smaller than
   it looks.

Anything you cannot re-check on their public pages — motives, internal priorities, quality
judgements, "slow innovation" — stays out of a document the client may forward.

## Your Opportunities

1. Create more specific, niche content they can't cover (weakness 2)
2. Target long-tail variants of the 16 head terms they do not hold
3. Own the comparison and "alternatives" queries they have left open (weakness 4)
4. Publish original data in the verticals their research posts skip (weakness 2)
5. Match their definition-first structure on terms they have not defined - that shape is what
   the engines lifted in 9 of the 12 test queries
```
