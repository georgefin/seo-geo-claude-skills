# CITE Domain Authority Report — Example

Full example audit output for reference. See the [SKILL.md](../SKILL.md) for the complete
workflow and [score-arithmetic.md](./score-arithmetic.md) for how each derived figure below
is composed. Every number in this example recomputes from the tables around it — that is
part of what it is demonstrating.

## Example

**User**: "Audit domain authority for cloudhosting.example as a content publisher"

**Output**:

```markdown
<!-- ILLUSTRATIVE FILL — cloudhosting.example is invented and so is every figure below; nobody
     measured any of it. It is here to show the shape of a finished report and what each
     derived number has to recompute from. Replace all of it with the audited domain's own
     measured data, and delete this comment. -->
## Domain Authority Audit

*Scored against CITE — our 40-item domain-authority benchmark, covering citations and links, the domain's identity signals, its trust signals, and its expertise footprint.*

### Overview

- **Domain**: cloudhosting.example
- **Domain Type**: Content Publisher
- **Audit Date**: 2025-02-03
- **CITE Score**: 68.5/100 (Medium)
- **Veto Status**: ✅ No triggers

#### Veto Check (Emergency Brake)

| Veto Item | Status | Action |
|-----------|--------|--------|
| T03: Link-Traffic Coherence | ✅ Pass | Link growth correlates with traffic growth |
| T05: Backlink Profile Uniqueness | ✅ Pass | No PBN patterns detected; diverse link sources |
| T09: Penalty & Deindex History | ✅ Pass | No manual actions; clean penalty history |

### Dimension Scores

| Dimension | Score | Items (Pass/Partial/Fail/N/A) | Rating | Weight | Weighted |
|-----------|-------|:-----------------------------:|--------|--------|----------|
| C — Citation | 70/100 over 10 scored | 4/6/0/0 | Medium | 40% | 28.0 |
| I — Identity | 55/100 over 10 scored | 3/5/2/0 | Low | 15% | 8.25 |
| T — Trust | 80/100 over 10 scored | 6/4/0/0 | Good | 20% | 16.0 |
| E — Eminence | 65/100 over 10 scored | 5/3/2/0 | Medium | 25% | 16.25 |
| **CITE Score** | | | | | **68.5/100** |

**Score Calculation**:
- Dimensions from their item tallies (all 40 items scored, no N/A): C = 4×10 + 6×5 = 70 · I = 3×10 + 5×5 = 55 · T = 6×10 + 4×5 = 80 · E = 5×10 + 3×5 = 65
- CITE Score = 70 × 0.40 + 55 × 0.15 + 80 × 0.20 + 65 × 0.25 = 28.0 + 8.25 + 16.0 + 16.25 = 68.5 → **68.5/100**, band read off 69 → **Medium**
- Points on the table: 400 raw points available, 270 scored, 130 lost — 18 Pass + 18 Partial + 4 Fail = 40 items, so lost = 18×5 + 4×10 = 130

**Rating Scale**: 90-100 Excellent | 75-89 Good | 60-74 Medium | 40-59 Low | 0-39 Poor — the band endpoints are whole numbers, so the rating word is read off the computed score rounded once to a whole number, half up

### Top 5 Priority Improvements

Sorted by: weight × points lost (highest impact first), with dependencies respected. Potential
gain = recoverable points (10 from Fail, 5 from Partial) × (10 ÷ that dimension's scored-item
count) × that dimension's weight. Every item here is scored, so each count is 10 and the middle
factor is 1 — it is written out anyway, because a dimension carrying unmeasurable items has a
count below 10 and the factor stops being 1 there.

1. **AI Citation Frequency** — the site is cited in assistant answers less often than its link profile would suggest
   - Current: Partial | Potential gain: 5 × (10 ÷ 10 scored) × 40% = 2.0 weighted points | Evidence: graded Partial in the dimension table above | Confidence: Likely (sampled AI answers, not exhaustive)
   - Action: Rewrite the opening of the top 10 pages so each leads with a statement that still says something true when lifted out of its paragraph
   - Owner: Content | Effort: Medium | Depends on: none
   - Done when: all 10 pages are live with the rewritten openings, and the citation sample is re-run on the same prompt set and repeat count, with the new figure and its N recorded beside the 2025-02-03 baseline
   - Risk if done wrong: low — reversible; openings compressed into slogans lose the substance that made them liftable, so keep every claim checkable on the page

2. **Knowledge Graph Presence** — no entity record exists for the publisher
   - Current: Fail | Potential gain: 10 × (10 ÷ 10 scored) × 15% = 1.5 weighted points | Evidence: graded Fail in the dimension table above (no entity entry found) | Confidence: Confirmed
   - Action: Create a Wikidata entry for CloudHost Inc. carrying website, industry and inception properties
   - Owner: SEO/technical | Effort: Medium | Depends on: a public, citable source for each property — incorporation record, About page, press coverage
   - Done when: the entry is live and resolvable, carries all three properties, and each property cites a source; recorded with its identifier and the date created
   - Risk if done wrong: medium — an entry with unsourced or promotional properties is edited or deleted by the community, and re-creating it is harder than getting it right once

3. **Content Freshness Signal** — 40% of content is >12 months without update
   - Current: Partial | Potential gain: 5 × (10 ÷ 10 scored) × 20% = 1.0 weighted points | Evidence: content inventory, 40% of URLs >12 months old | Confidence: Confirmed
   - Action: Stand up a monthly refresh schedule and work it through the top 20 traffic pages first
   - Owner: Content | Effort: Strategic | Depends on: none
   - Done when: a dated schedule exists naming the pages and the month each is due, and three consecutive months have shipped with the updated pages carrying visible revision dates
   - Risk if done wrong: medium — bumping a date without changing the content is a false freshness signal and a misrepresentation to the reader

4. **Brand SERP Ownership** — the branded results page shows only 4 of 10 results from owned properties
   - Current: Partial | Potential gain: 5 × (10 ÷ 10 scored) × 15% = 0.75 weighted points | Evidence: branded-SERP scan, 4 of 10 results owned | Confidence: Confirmed
   - Action: Claim the Google Business Profile, complete the social profiles and create a CrunchBase entry
   - Owner: Client decision (profile ownership sits with the client's accounts) | Effort: Quick | Depends on: access to the company accounts and a verification address
   - Done when: all four profiles are live and verified under the company name, listed with their URLs, and the branded-SERP scan is re-run and its owned-result count recorded beside the 4 of 10 baseline
   - Risk if done wrong: medium — inconsistent names, addresses or descriptions across profiles weaken the identity signal instead of strengthening it

5. **Schema.org Coverage** — Organization schema present but incomplete: sameAs, founder and foundingDate absent
   - Current: Partial | Potential gain: 5 × (10 ÷ 10 scored) × 15% = 0.75 weighted points | Evidence: markup crawl, properties absent from Organization schema | Confidence: Confirmed
   - Action: Add sameAs, founder and foundingDate to the existing Organization block
   - Owner: Developer | Effort: Quick | Depends on: the Wikidata entry from row 2 existing, so sameAs has something to point at
   - Done when: the live Organization block validates with zero errors in a structured-data test and carries all three properties, each matching information published on the site
   - Risk if done wrong: low — reversible; properties describing anything not published on the site are a misrepresentation, so add only what the site states

These five together are worth 2.0 + 1.5 + 1.0 + 0.75 + 0.75 = **6.0 weighted points** — the sum of the individual gains, no more.

### Action Plan

Every action above, ordered by weighted gain ÷ effort with dependencies respected. The schema completion is Quick and would otherwise sit at the top beside row 1; it sorts to row 4 because it waits on the entity record in row 3. Effort bands: Quick (<1 week) · Medium (1-4 weeks) · Strategic (1-3 months).

| # | Action | Owner | Acceptance criterion | Expected gain | Effort | Depends on | Risk if done wrong |
|---|--------|-------|----------------------|---------------|--------|------------|--------------------|
| 1 | Claim the Google Business Profile, complete the social profiles and create a CrunchBase entry | Client decision | All four profiles live and verified under the company name, and the branded-SERP scan re-run with its owned-result count recorded beside the 4 of 10 baseline | 0.75 weighted points | Quick | access to the company accounts and a verification address | medium — inconsistent name, address or description across profiles weakens the identity signal instead of strengthening it |
| 2 | Rewrite the opening of the top 10 pages to lead with a statement that stands alone | Content | All 10 pages live with the rewritten openings, and the citation sample re-run on the same prompt set and repeat count, with the new figure and its N recorded beside the 2025-02-03 baseline | 2.0 weighted points | Medium | none | low — reversible; openings compressed into slogans lose the substance that made them liftable |
| 3 | Create a Wikidata entry for CloudHost Inc. carrying website, industry and inception properties | SEO/technical | The entry is live and resolvable, carries all three properties, and each cites a public source; recorded with its identifier and creation date | 1.5 weighted points | Medium | a public, citable source for each property | medium — unsourced or promotional properties get edited or deleted, and re-creating the entry is harder than getting it right once |
| 4 | Add sameAs, founder and foundingDate to the existing Organization block | Developer | The live Organization block validates with zero errors in a structured-data test and carries all three properties, each matching information published on the site | 0.75 weighted points | Quick | row 3 — sameAs needs the entity record to point at | low — reversible; add only properties the site itself states |
| 5 | Stand up a monthly refresh schedule and work it through the top 20 traffic pages | Content | A dated schedule naming the pages and the month each is due, and three consecutive months shipped with the updated pages carrying visible revision dates | 1.0 weighted points | Strategic | none | medium — bumping a date without changing the content is a false freshness signal and a misrepresentation to the reader |
| 6 | Commission digital PR aimed at earning mentions on industry publications | Client decision | A dated outreach plan exists with named targets, and earned mentions are logged with their URLs and dates as they land | not estimated — no baseline data; this audit measured referring domains, not campaign response | Strategic | budget, and a story worth covering | high — paid placements and reciprocal schemes are not earned mentions and carry a retraction risk that outlives the spend |

### Cross-Reference with the Content Audit

For a complete assessment, pair this domain audit with a content audit scored against CORE-EEAT — our 80-item content-quality benchmark for the pages themselves, covering how clearly each one answers, how it is organised, how reliable and current it is, and the experience, expertise, authority and trust it shows:

| Assessment | Score | Rating |
|-----------|-------|--------|
| CITE (Domain) | 68.5/100 | Medium |
| CORE-EEAT (Content) | Not yet evaluated | — |

**Diagnosis**: domain authority is mid-range, and page-level content quality has not been measured
yet, so we cannot say which of the two is holding the site back. A content review of the top five
landing pages settles it, and is the cheaper of the two to run first.
```

The client's report ends at that fence.

**Two things above are written for whoever runs the audit, and neither is an annotation on the
example — both are how the report itself has to read.** (1) Each framework name is glossed the
first time the client meets it: `CITE` at the top and `CORE-EEAT` in the cross-reference. The bare
acronym names a document the client has never seen, and glossing is what the Reader Test asks for a
framework *name*; it never rescues an item ID or a skill slug (`CLAUDE.md` § The Reader Test, clause
1). (2) Every dimension prints its scored-item denominator — `70/100 over 10 scored` — and its N/A
count, even where nothing is N/A and the denominator is the obvious 10. That is the only figure a
reader can check the Top-5 `(10 ÷ n scored)` rescale against, and a template that prints it only
when it is interesting teaches the writer to omit it exactly where it starts to matter.

**Why row 3 of the Top 5 is worth 1.0 and not 1.25** — a note for whoever runs this audit, not
part of the report above. Each potential gain takes the weight of the dimension its item belongs
to, and freshness is `CITE-T08`, a Trust item at 20%, not an Eminence item at 25%. Read the item
ID off [cite-domain-rating.md](../../../references/cite-domain-rating.md) § 2 before multiplying:
the dimension letter in the ID *is* the weight selector, so a mis-attributed item prices the fix
wrongly even when the grade behind it is right. The Top 5 stays sorted by the gains as computed —
2.0 · 1.5 · 1.0 · 0.75 · 0.75 — and the closing sum equals those five numbers added, nothing else.

**Why every gain above carries a `(10 ÷ 10 scored)` that changes nothing** — also for whoever runs
the audit. Each dimension here has all ten items graded, so the factor is 1 and each multiplication
gives the same answer with or without it. That is precisely why an example like this one cannot
teach the rule on its own: on an audit with N/A items the dimension's scored-item count drops, one
raw point buys more score, and the factor rescales every gain in that dimension —
`5 × (10 ÷ 6 scored) × 25% = 2.08`, not 1.25.
[score-arithmetic.md](./score-arithmetic.md) § 5 works that case as Worked B beside this one, and
§ 6 covers the different operation of an N/A item becoming measurable, which is a projection with
two recomputed endpoints and not a gain at all.

The follow-up runs go in a **separate fence of their own**, carrying **two labels**: the in-fence
comment, because a model copies the fence and not the heading above it, and a visible line the
client actually sees, because an HTML comment renders to nothing in the delivered report
(`CLAUDE.md` § The Reader Test, clause 2; the handoff sub-rule is
[inter-skill-handoff.md § 3.1](../../../references/inter-skill-handoff.md)). Continuing the same
example:

```markdown
<!-- OPERATOR BLOCK — for the client's team, not part of the report above. Every row names a
     library run and carries its payload. Nothing in this fence goes to the client as written. -->
**Next steps for your team** — *operator block; not part of the client report*

| Run | Why | Payload |
|-----|-----|---------|
| `content-quality-auditor` | Settles the diagnosis above — domain authority is mid-range and content is unmeasured | cloudhosting.example, Content Publisher · the 5 landing pages, one row each · `CITE C:70 I:55 T:80 E:65` · vetoes `CITE-T03` pass, `CITE-T05` pass, `CITE-T09` pass · audited 2025-02-03 |
| `entity-optimizer` | Identity is the weakest dimension (55/100) and carries three of the top 5 priorities | cloudhosting.example, Content Publisher · priority `CITE-I01, CITE-I03, CITE-I04` · `CITE C:70 I:55 T:80 E:65` · audited 2025-02-03 |
| `/seo:report` | Quarterly trend tracking against this baseline | cloudhosting.example · baseline `CITE C:70 I:55 T:80 E:65`, audited 2025-02-03 |
```

The CORE-EEAT field is absent from every row because no content audit exists yet — that absence is
the reason for row 1, and it is named rather than estimated.
