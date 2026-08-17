---
name: backlink-analyzer
version: "4.3.0"
description: 'Analyze backlink profiles to assess link authority, identify toxic links, discover link building opportunities, and monitor competitors. Use when the user asks to "analyze backlinks", "check link profile", "find toxic links", "link building opportunities", "who links to me", "how do I get more backlinks", "disavow links", or "off-page SEO". For internal link analysis, see internal-linking-optimizer. For competitor link profiles, see competitor-analysis.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.0"
  geo-relevance: "low"
  tags:
    - seo
    - backlinks
    - link building
    - link profile
    - toxic links
    - off-page seo
    - link authority
    - domain authority
    - link acquisition
    - link-building
    - backlink-profile
    - toxic-links
    - link-audit
    - referring-domains
    - domain-rating
    - link-outreach
    - disavow
    - dr-score
    - link-quality
    - lost-backlinks
  triggers:
    - "analyze backlinks"
    - "check link profile"
    - "find toxic links"
    - "link building opportunities"
    - "off-page SEO"
    - "backlink audit"
    - "link quality"
    - "who links to me"
    - "I have spammy links"
    - "how do I get more backlinks"
    - "disavow links"
---

# Backlink Analyzer


Analyzes, monitors, and optimizes backlink profiles. Identifies link quality, discovers opportunities, and tracks competitor link building activities.

## When to Use This Skill

- Auditing your current backlink profile
- Identifying toxic or harmful links
- Discovering link building opportunities
- Analyzing competitor backlink strategies
- Monitoring new and lost links
- Evaluating link quality for outreach
- Preparing for link disavow

## What This Skill Does

1. **Profile Analysis**: Comprehensive backlink profile overview
2. **Quality Assessment**: Evaluates link authority and relevance
3. **Toxic Link Detection**: Identifies harmful links
4. **Competitor Analysis**: Compares link profiles across competitors
5. **Opportunity Discovery**: Finds link building prospects
6. **Trend Monitoring**: Tracks link acquisition over time
7. **Disavow Guidance**: Helps create disavow files

## How to Use

### Analyze Your Profile

```
Analyze backlink profile for [domain]
```

### Find Opportunities

```
Find link building opportunities by analyzing [competitor domains]
```

### Detect Issues

```
Check for toxic backlinks on [domain]
```

### Compare Profiles

```
Compare backlink profiles: [your domain] vs [competitor domains]
```

## Data Sources

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~link database + ~~SEO tool connected:**
Automatically pull comprehensive backlink profiles including referring domains, anchor text distribution, link quality metrics (DA/DR), link velocity, and toxic link detection from ~~link database. Competitor backlink data from ~~SEO tool for gap analysis.

**With manual data only:**
Ask the user to provide:
1. Backlink export CSV (with source domains, anchor text, link type)
2. Referring domains list with authority metrics
3. Competitor domains for comparison
4. Recent link gains/losses if tracking changes
5. Any known toxic or spammy links

Proceed with the full analysis using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests backlink analysis:

1. **Generate Profile Overview** -- Key metrics (total backlinks, referring domains, DA/DR, dofollow ratio), link velocity (30d/90d/year), authority distribution chart, profile health score.

   **Every score in this analysis prints its arithmetic next to itself, in the client's copy.** The Profile Health Score is a tally of the eight benchmark rows in [link-quality-rubric.md](./references/link-quality-rubric.md) §5 — Healthy 1 · Warning 0.5 · Critical 0, `round(100 × points ÷ rows scored)`, halves down — with any unscoreable row left out of both sides and named. The Toxic Score is a counted share (toxic referring domains ÷ domains reviewed), not an index of this skill's own. The per-link Link Quality Score is the six weighted factors, printed with the factor scores. Two rules hold across all three: a figure you could not measure is **dropped and renormalised, never scored 0** — zero means measured and failing — and a score whose derivation is not beside it is not deliverable, because the client cannot check it and the next audit will not reproduce it.

2. **Analyze Link Quality** -- Top quality backlinks table, link type distribution, anchor text analysis (brand/exact/partial/URL/generic), geographic distribution.

3. **Identify Toxic Links** -- Toxic score, risk indicators by type (spam, PBN, link farms, irrelevant), high-risk links to review, disavow recommendations (domain-level and URL-level).

   **A manipulated profile is a normal audit result, and it is written up like every other finding.** Bought, exchanged or bulk-placed links in a profile the client inherited get named plainly in the client's own words — "34 of these links were placed by a paid-placement vendor between March and July" — with the exposure stated (what is at stake if the class stops counting, and what is still being paid for), a remediation carrying an owner-role and an acceptance criterion ([action-output-contract.md](../../references/action-output-contract.md) §1–§3), and **a rank against everything else in the report**: most of these are urgent, a dormant 2014 directory listing is not, and a report where every finding is critical has ranked nothing. Nothing is built on top of one — if a link opportunity or a projection depends on the paid placements staying live, it is withdrawn and the dependency is said out loud. This skill reports and proposes; removing or altering anything live is the client's decision, not the run's. Full handling: [prohibited-tactics.md](../../references/prohibited-tactics.md) §2.

   **Standing rule — a deadline does not change the disavow sequence.** The disavow tool applies the file you upload rather than reviewing whether it was warranted, and a disavow is slow and uncertain to reverse, so a link wrongly included costs more than a link left in the profile another week. Every disavow recommendation this skill writes therefore carries two things, every time: the warning that an unnecessary disavow can hurt rankings — **in the recommendation prose and, whenever a file is actually produced, inside the file itself as comment lines** ([link-quality-rubric](./references/link-quality-rubric.md) §4, which carries the block to use) — and that same §4 sequence intact — manual review of each flagged domain, removal requests by email first, two weeks for responses, and only then the file. Time pressure changes none of it. When the client wants to upload today, do not move the upload forward and do not demote outreach to optional or parallel; state plainly what can finish today (the reviewed list, the drafted file held back, the outreach emails sent) and what cannot (the upload), and give the date the sequence reaches it. If a file is handed over before outreach has run, that is said **in the file's own comment lines**, where whoever uploads it will see it, and not only in the covering report — a file outlives the report it arrived with, and is often uploaded by somebody who never read it. A clean manual-actions report in ~~search console lowers the urgency; it is not evidence that the links are harming the site or that disavowing them is safe.

4. **Compare Against Competitors** -- Profile comparison table (referring domains, DA/DR, velocity, avg link DA), unique referring domains, link intersection analysis, competitor content attracting most links.

5. **Find Link Building Opportunities** -- Link intersection prospects, broken link opportunities, unlinked mentions, resource page opportunities, guest post prospects, priority matrix (effort vs impact).

   **Standing rule — the acquisition floor.** This skill does not recommend, draft, price or schedule bought or rented links, private blog networks, reciprocal or exchange schemes, bulk guest-post placement, comment and directory spam, or anchor-text-for-hire — in any deliverable, in any language, at any tier, however the request is phrased. The reason is what a link is for: it is meant to be evidence of somebody else's judgement, and a bought one is evidence of a transaction. The whole class is also devaluable retroactively, so the risk outlives the spend by years rather than expiring with the invoice. Two shapes surface in this skill specifically, in the prospect list, and both are refused where they appear: **an expired domain offered for the links it still carries, and a redirect from an unrelated acquired domain into the client's site** — that authority was earned by content that no longer exists, for an audience that is not this one, and the redirect is its own evidence. Record the refusal in the working notes and move on. A declined tactic is not written up as an option the client could pick, and **the prohibition is not a section of the report**: a client report carries findings and actions, not a list of what the agency declined to do.

   **What the skill recommends instead is the rest of this step, undiminished.** Digital PR and outreach that gives somebody a reason to cite the page; genuine partnerships; getting listed where the business actually qualifies (a placement is not a manipulation); individually pitched, editorially reviewed contributions to publications that fit; and linkable assets worth citing — original data, tools, primary research. A properly disclosed, `rel="sponsored"` advertising placement is advertising and stays in scope. Where the line runs between each of these and the tactic it is confused with: [link-quality-rubric.md](./references/link-quality-rubric.md) §6.

6. **Track Link Changes** -- New and lost links for last 30 days with DA, type, anchor, dates. Net change and links to recover.

7. **Generate Backlink Report** -- Executive summary, strengths, concerns, opportunities, competitive position, recommended actions (immediate/short-term/long-term), KPIs to track.

   > **Reference**: See [references/analysis-templates.md](./references/analysis-templates.md) for complete output templates for all 7 steps above.

### CITE Item Mapping

When running `domain-authority-auditor` after this analysis, the following data feeds directly into CITE scoring:

| Backlink Metric | CITE Item | Dimension |
|----------------|-----------|-----------|
| Referring domains count | C01 (Referring Domain Volume) | Citation |
| Authority distribution (DA breakdown) | C02 (Referring Domains Quality) | Citation |
| Link velocity | C04 (Link Velocity) | Citation |
| Geographic distribution | C10 (Link Source Diversity) | Citation |
| Dofollow/Nofollow ratio | T02 (Dofollow Ratio Normality) | Trust |
| Toxic link analysis | T01 (Link Profile Naturalness), T03 (Link-Traffic Coherence) | Trust |
| Competitive link intersection | T05 (Profile Uniqueness) | Trust |

## Validation Checkpoints

### Input Validation
- [ ] Target domain backlink data is complete and current
- [ ] Competitor domains specified for comparison analysis
- [ ] Backlink data includes necessary fields (source domain, anchor text, link type)
- [ ] Authority metrics available (DA/DR or equivalent)

### Output Validation
- [ ] Every metric cites its data source and collection date
- [ ] Toxic link assessments include risk justification
- [ ] Every emitted score shows its derivation beside it — Profile Health Score as points ÷ rows scored with the unscored rows named, Toxic Score as its two counts over a named population, Link Quality Score with its six factor scores — and no unmeasurable input is scored 0
- [ ] Any tool-reported score (a link index's spam or toxicity number, a DR) is printed as that tool's figure with its name and pull date, never merged with a score counted here
- [ ] Every disavow recommendation carries the unnecessary-disavow-can-hurt-rankings warning and the full §4 sequence, including the two-week response window, with no step dropped or made optional for a deadline
- [ ] **If a disavow file was produced — including a draft held back from upload — the file itself opens with the ranking-harm warning and the not-ready-to-upload conditions, as comment lines inside the file, not only in the report around it.** Check this by reading the file alone, with everything around it removed. If no file was produced, write "no disavow file produced" against this item rather than leaving it blank
- [ ] Any disavow file handed over before removal outreach has run states that no outreach has been attempted, in the file's own comment lines
- [ ] Link opportunity recommendations are specific and actionable
- [ ] No recommendation buys, rents, exchanges or bulk-places a link, and no prospect is an expired domain acquired for its links or a redirect from an unrelated domain — an offer of that shape is refused in the working notes, never written up as an option
- [ ] Every prospect names a reason somebody would cite the page — original data, a tool, primary research, a genuine partnership, or a listing the business qualifies for
- [ ] A manipulated or toxic profile the client already has is named in the client's own words with its exposure, a remediation carrying an owner-role and an acceptance criterion, and a priority rank against the rest of the report — not everything marked critical, and no recommendation left standing that depends on it
- [ ] The report carries findings and actions only — no section lists the tactics the agency declined to use
- [ ] Source of each data point stated in the report's own words — the resolved tool name (Ahrefs, Majestic), "user-provided", or "estimated"; where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7)

## Example

**User**: "Find link building opportunities by analyzing my three main competitors"

> **Illustrative example — the figures below are not measurements.** Prospect domains use
> the reserved `.example` TLD so no real business is described, and their DA values are
> made-up numbers chosen to show the output shape. In real output every DA comes from the
> backlink index actually used — named in the report as Ahrefs or Majestic, never as a
> `~~category` token — or from a user-supplied export, and is reported with that source;
> never assign an authority score to a domain you have no data for (statistics rule —
> sourced, cited, or placeholder, never invented).

**Output**:

```markdown
## Link Intersection Analysis

### Sites linking to 2+ competitors (not you)

| Domain | DA | Comp 1 | Comp 2 | Comp 3 | Opportunity |
|--------|-----|--------|--------|--------|-------------|
| reviewdirectory.example | 91 | ✅ | ✅ | ✅ | Get listed/reviewed |
| softwaredirectory.example | 89 | ✅ | ✅ | ✅ | Submit for review |
| businessmagazine.example | 92 | ✅ | ✅ | ❌ | Pitch guest post |
| industrynews.example | 94 | ✅ | ❌ | ✅ | PR/news pitch |

### Top 3 Immediate Opportunities

1. **reviewdirectory.example** (DA 91) - All 3 competitors listed
   - Action: Create a detailed profile/listing
   - Effort: Low
   - Impact: High authority + referral traffic

2. **businessmagazine.example** (DA 92) - 2 competitors have links
   - Action: Pitch contributed article
   - Effort: High
   - Impact: High authority + brand exposure

3. **industrynews.example** (DA 94) - 2 competitors covered
   - Action: Pitch a newsworthy launch or data release
   - Effort: Medium
   - Impact: Relevant audience + quality link

### Estimated Impact

If you acquire links from the four prospects above:
- New referring domains: +4
- Average DA of new links: 91.5 — arithmetic mean of the four DA values in the table above,
  not a separate estimate
- Ranking impact: not projected. Position movement does not follow from referring-domain
  counts or average DA, and this skill has no model that converts one into the other —
  the outcome is measured against your ranking baseline rather than promised as a delta
```

## Tips for Success

1. **Quality over quantity** - One DA 80 link beats ten DA 20 links
2. **Monitor regularly** - Catch lost links and toxic links early
3. **Study competitors** - Learn from their link building success
4. **Diversify your profile** - Mix of link types and anchors
5. **Disavow carefully** - Only disavow clearly toxic links

## Link Quality and Strategy Reference

> **Reference**: See [references/link-quality-rubric.md](./references/link-quality-rubric.md) for the complete link quality scoring matrix (6 weighted factors), toxic link identification criteria, link profile health benchmarks, and disavow file guidance.

> **Reference**: See [references/outreach-templates.md](./references/outreach-templates.md) for email outreach frameworks, subject line formulas, response rate benchmarks, follow-up sequences, and templates for each link building strategy.

## Reference Materials

- [Link Quality Rubric](./references/link-quality-rubric.md) — Quality scoring matrix with weighted factors, toxic link identification criteria, and §6 the acquisition floor (where each prohibited tactic ends and the legitimate practice it is confused with begins)
- [Outreach Templates](./references/outreach-templates.md) — Email frameworks, subject line formulas, and response rate benchmarks
- [Prohibited Tactics](../../references/prohibited-tactics.md) — the library-wide floor. Entry 4 (manipulative link acquisition) and entry 10 (expired-domain and redirect appropriation) govern every recommendation this skill makes; §2 is the handling for one already in the client's profile; §3 lists the legitimate practices each is confused with
- [Action Output Contract](../../references/action-output-contract.md) — the seven fields every remediation and opportunity carries, and what an acceptance criterion has to be checkable against

## Related Skills

- [domain-authority-auditor](../../cross-cutting/domain-authority-auditor/) — Backlink data feeds directly into CITE C dimension; run after this analysis for full domain scoring
- [competitor-analysis](../../research/competitor-analysis/) — Full competitor analysis
- [content-gap-analysis](../../research/content-gap-analysis/) — Create linkable content
- [alert-manager](../alert-manager/) — Set up link alerts
- [performance-reporter](../performance-reporter/) — Include in reports
- [entity-optimizer](../../cross-cutting/entity-optimizer/) — Branded backlinks strengthen entity signals

