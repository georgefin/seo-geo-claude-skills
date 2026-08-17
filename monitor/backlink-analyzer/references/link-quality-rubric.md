# Link Quality Rubric

Comprehensive reference for evaluating backlink quality. Use this rubric to assess individual links, audit entire link profiles, perform competitive link gap analysis, and prepare disavow files.

---

## 1. Individual Link Quality Evaluation

### Scoring Methodology

Evaluate each link across six factors. Score each factor 1-5, multiply by that factor's weight as
a decimal (0.25 · 0.25 · 0.15 · 0.15 · 0.10 · 0.10), and sum the six products for the Link Quality
Score (LQS). The weights already total 1.00, so **there is no further divisor** and the LQS lands
in 1.00-5.00. Print the six factor scores beside the LQS — a link graded 3.4 with no factor row
behind it cannot be argued with, improved, or reproduced by the next analyst.

Round to one decimal, half up, and read the band off the rounded figure. That rounding step is
what makes the bands contiguous: the weights make x.x5 results reachable — a 5 on authority and a
4 on traffic with 1s on the other four factors gives exactly 2.45 — and an unrounded 2.45 sits in
no band below, while 2.45 rounded is 2.5, Acceptable.

**Rating Scale** (rounded LQS):
- **4.0-5.0**: Premium link — high authority, topically relevant, editorial placement
- **2.5-3.9**: Acceptable link — provides value, typical of healthy profiles
- **1.0-2.4**: Low quality — minimal value, review for potential risk

Worked: authority 5, relevance 4, traffic 3, position 5, anchor 3, follow 5 →
`0.25×5 + 0.25×4 + 0.15×3 + 0.15×5 + 0.10×3 + 0.10×5` = `1.25 + 1.00 + 0.45 + 0.75 + 0.30 + 0.50`
= **4.25 → 4.3, Premium**. A factor you could not check is dropped and the remaining weights are
renormalised over their own sum (state which, and the sum) — scoring it 1 asserts "poor", which is
a claim you do not have.

### Factor 1: Domain Authority (25% weight)

| Score | DR / DA Range | Characteristics | Examples |
|-------|-------------|-----------------|---------|
| 5 | DR 70+ | Major publication, established authority | NYTimes, Forbes, BBC, major university sites |
| 4 | DR 50-69 | Strong domain, recognized in industry | Industry publications, large blogs, government sites |
| 3 | DR 30-49 | Moderate authority, established site | Mid-tier blogs, regional publications, niche authorities |
| 2 | DR 15-29 | Low authority, newer or smaller site | Small blogs, newer companies, personal sites |
| 1 | DR <15 | Very low authority | New sites, abandoned sites, thin content sites |

**Notes:**
- DR/DA is a proxy, not the sole indicator. A DR 30 site that is highly relevant to your niche may be more valuable than a DR 70 site in an unrelated field.
- Check if the domain's authority is organic (earned over time) or inflated (bought links, PBN).

### Factor 2: Topical Relevance (25% weight)

| Score | Relevance Level | Description |
|-------|----------------|-------------|
| 5 | Exact match | Same niche, same subtopic. A link from a CRM review site to your CRM product. |
| 4 | Closely related | Same industry, adjacent topic. A marketing blog linking to your email tool. |
| 3 | Broadly related | Same general field. A business blog linking to your SaaS product. |
| 2 | Tangentially related | Loose connection. A general news site mentioning your product in a tech roundup. |
| 1 | Unrelated | No topical connection. A cooking blog linking to your B2B software. |

**How to assess relevance:**
1. Read the linking page content. Is it about your topic?
2. Check the linking site's overall focus. Is it in your industry?
3. Look at the surrounding content. Does the link make editorial sense?
4. Check the site's other outbound links. Are they topically coherent?

### Factor 3: Traffic to Linking Page (15% weight)

| Score | Estimated Monthly Traffic | Characteristics |
|-------|--------------------------|-----------------|
| 5 | 10,000+ visits/month | High-traffic page, likely drives referral traffic |
| 4 | 1,000-9,999 visits/month | Solid traffic, some referral value |
| 3 | 100-999 visits/month | Moderate traffic, primarily SEO value |
| 2 | 10-99 visits/month | Low traffic, SEO value only |
| 1 | <10 visits/month | No meaningful traffic, minimal value |

**Why traffic matters:**
- Links from pages with real traffic are more likely to be genuine editorial placements — an
  inference about how publishers behave, not about how an engine scores.
- Referral traffic from the link provides direct business value beyond SEO, measurable in
  analytics whatever any engine does with the link.
- [VERIFY — 2026-08-17] This library has also carried "Google likely weights links from pages
  that receive traffic more highly." No engine-primary source for it was read here. It is
  hedged rather than asserted, which is why it stood; it is tagged now because it was helping
  justify a **scoring weight**, and a load-bearing claim needs a source or a tag. **The 15%
  weight does not rest on it** — the two observable bullets above carry the factor on their
  own. Do not state it to a client. Resolves on an owner read of Google's own link-quality
  documentation.

### Factor 4: Link Position (15% weight)

| Score | Position | Description |
|-------|----------|-------------|
| 5 | In-content, editorial | Naturally placed within the article body as a citation or resource |
| 4 | In-content, contextual | Within the body text but in a "resources" or "further reading" section |
| 3 | Author bio or about section | Part of a contributor's bio or about page |
| 2 | Sidebar or dedicated links section | Widget, blogroll, or sidebar placement |
| 1 | Footer, sitewide, or hidden | Footer link, sitewide template link, or visually obscured |

**Key principle:** Editorial in-content links carry the most weight because they represent a genuine endorsement. Footer and sitewide links are devalued by search engines.

### Factor 5: Anchor Text (10% weight)

| Score | Anchor Type | Example (for a CRM product) |
|-------|------------|----------------------------|
| 5 | Descriptive, natural | "this customer relationship management platform" |
| 4 | Partial match, natural | "CRM tools for small businesses" |
| 3 | Brand name | "Acme CRM" |
| 2 | Naked URL | "https://acmecrm.com" |
| 1 | Generic | "click here", "read more", "this website" |

**Important nuance:** A natural link profile has a MIX of all anchor types. Too many exact-match anchors (score 5) can signal manipulation. The ideal distribution is:
- Brand anchors: 30-40%
- Naked URLs: 15-25%
- Generic anchors: 10-20%
- Descriptive/partial match: 15-25%
- Exact match: 5-15%

### Factor 6: Follow Status (10% weight)

| Score | Status | Description |
|-------|--------|-------------|
| 5 | Dofollow, editorial | Standard followed link from editorial content |
| 4 | Dofollow, non-editorial | Followed link from directory, profile, or user-generated content |
| 3 | Sponsored (rel="sponsored") | Properly disclosed sponsored/paid link |
| 2 | UGC (rel="ugc") | User-generated content link (forums, comments) |
| 1 | Nofollow (rel="nofollow") | Explicitly nofollowed link |

**Notes:**
- Google treats nofollow as a "hint" rather than a directive since 2019.
- Nofollow links from high-authority sites (e.g., Wikipedia) still provide brand value and referral traffic.
- A healthy profile naturally includes a mix of followed and nofollowed links. Typical ratio: 60-80% dofollow, 20-40% nofollow.

---

## 2. Example Link Profile Assessments

### Example A: Strong Link Profile

| Characteristic | Value | Assessment |
|---------------|-------|-----------|
| Total referring domains | 1,200 | Healthy for a mid-size SaaS company |
| Dofollow ratio | 72% | Natural distribution |
| Average linking domain DR | 38 | Solid average authority |
| Top anchor: brand name | 35% | Natural brand dominance |
| Exact match anchors | 8% | Within safe range |
| Topical relevance (sampled) | 75% related | Strong relevance signal |
| Link velocity | +25/month net | Steady organic growth |
| Toxic link estimate | 3% | Below 5% threshold — healthy |

**Verdict:** Healthy profile with natural link distribution. Continue current strategy.

### Example B: At-Risk Link Profile

| Characteristic | Value | Assessment |
|---------------|-------|-----------|
| Total referring domains | 800 | Adequate but thin for competitive niche |
| Dofollow ratio | 92% | Suspiciously high — may indicate link manipulation |
| Average linking domain DR | 18 | Low average authority |
| Top anchor: exact match keyword | 42% | Over-optimized — risk of penalty |
| Exact match anchors | 42% | Far above safe threshold (>15%) |
| Topical relevance (sampled) | 30% related | Many irrelevant links |
| Link velocity | +80/month net | Unnaturally high — investigate |
| Toxic link estimate | 18% | Above 10% threshold — action needed |

**Verdict:** Profile shows signs of manipulation. Immediate actions needed: disavow toxic links, diversify anchor text, slow down link acquisition pace.

### Example C: New Site Link Profile

| Characteristic | Value | Assessment |
|---------------|-------|-----------|
| Total referring domains | 45 | Expected for a 6-month-old site |
| Dofollow ratio | 65% | Natural |
| Average linking domain DR | 28 | Reasonable for early-stage outreach |
| Top anchor: brand name | 40% | Healthy |
| Exact match anchors | 5% | Conservative and safe |
| Topical relevance (sampled) | 80% related | Well-targeted outreach |
| Link velocity | +8/month net | Appropriate for new site |
| Toxic link estimate | 1% | Clean profile |

**Verdict:** Healthy foundation. Focus on scaling link acquisition while maintaining quality standards.

---

## 3. Competitive Link Gap Analysis Methodology

### Step-by-Step Process

**Step 1: Identify competitors**
Select 3-5 direct competitors who rank for your target keywords.

**Step 2: Pull referring domain data**
Export the full referring domain list for each competitor from ~~link database.

**Step 3: Create intersection matrix**

| Referring Domain | You | Comp 1 | Comp 2 | Comp 3 | Overlap Count |
|-----------------|-----|--------|--------|--------|---------------|
| example-a.com | No | Yes | Yes | Yes | 3 |
| example-b.com | No | Yes | Yes | No | 2 |
| example-c.com | No | Yes | No | No | 1 |
| example-d.com | Yes | Yes | Yes | Yes | 3 (already have) |

**Step 4: Prioritize opportunities**

| Priority | Criteria | Rationale |
|----------|---------|-----------|
| Highest | Links to 3+ competitors, DR 50+, relevant | If all competitors have it, it is likely linkable |
| High | Links to 2+ competitors, DR 30+, relevant | Strong signal of willingness to link in niche |
| Medium | Links to 1 competitor, DR 50+, relevant | May be less accessible but high value |
| Lower | Links to 1 competitor, DR <30, or low relevance | Diminishing returns |

**Step 5: Analyze link context**
For each high-priority opportunity, visit the actual linking page to understand:
- Why did they link to your competitor? (resource page, mention, guest post, etc.)
- What content on your site could replace or complement that link?
- What outreach angle would work? (broken link, better resource, relationship)

**Step 6: Create outreach plan**
Build a prioritized list with contact information, outreach angle, and template selection.

---

## 4. Disavow File Format Guide

### When to Disavow

Only disavow links when you have clear evidence of risk. Unnecessary disavow can hurt your rankings.

That warning is not background for the analyst, and it has **two carriage points which are satisfied separately** — one never stands in for the other:

1. **In the recommendation prose**, in the client's copy, every time a disavow is proposed.
2. **Inside the disavow file**, as comment lines in the file itself, every time a file is produced — including a draft handed over to be uploaded later.

The second is the one that gets dropped, and it is the one that matters more. A report is read once, by whoever commissioned it. The file outlives the report, gets forwarded, and is often uploaded by somebody who never read it. A warning that lives only in the report is missing at the moment of the irreversible action.

The comment block at the top of the §4 template below is therefore **part of the deliverable, not an annotation on the example**. It travels with every file this skill produces.

| Situation | Disavow? | Reasoning |
|-----------|----------|-----------|
| Obvious PBN links | Yes | Clear manipulation signal |
| Paid links you cannot get removed | Yes | After attempting removal |
| Spam attack (negative SEO) | Yes | Protect from third-party manipulation |
| Low-quality directory links | Maybe | Only if pattern is excessive |
| Foreign language spam | Yes | If clearly unnatural |
| Low-DA sites with real content | No | Low quality is not toxic |
| Nofollow links from any source | No | Already nofollowed; no risk |

### Disavow File Format

The disavow file is a plain text file (.txt) uploaded to Google Search Console.

```
# ILLUSTRATIVE FILL — every domain and date below is invented. Replace all of them.
#
# WARNING — READ BEFORE UPLOADING. An unnecessary disavow can hurt your rankings.
# Google applies this file as submitted; it does not check whether the entries were
# warranted, and reversing a disavow is slow and uncertain. A good link wrongly listed
# here costs more than a bad link left in the profile another month.
#
# This file is NOT ready to upload unless all four are true:
#   1. every domain below was reviewed by hand, not selected by score alone
#   2. removal was requested by email first
#   3. two weeks were allowed for replies
#   4. someone accountable has approved this exact file
# If any one of the four is false, this is a draft. Do not upload it.

# Disavow file for example.com
# Generated: 2026-03-14
# Reason: Toxic link cleanup

# Individual URLs to disavow
https://spam-site.com/page-with-link
https://another-spam.com/toxic-page

# Entire domains to disavow (use for sites with multiple toxic links)
domain:link-farm-example.com
domain:pbn-network-site.com
domain:spam-directory.net
```

### Disavow File Best Practices

| Practice | Why |
|----------|-----|
| Keep the warning block at the top of the file | Whoever uploads it may never have read the report it came with |
| Comment every entry or group | Future auditors need to understand why |
| Use `domain:` for sites with multiple bad links | More thorough than individual URLs |
| Use individual URLs when only one page is toxic | Avoid disavowing good links from the same domain |
| Keep a changelog | Track what was added and when |
| Review quarterly | Remove entries if domains have been cleaned up |
| Never disavow your own domain | Common mistake that causes severe damage |
| Back up before uploading | Keep previous version in case of errors |

### Disavow Review Workflow

| Step | Action | Tool |
|------|--------|------|
| 1 | Export full backlink profile | Backlink index (name the tool used) |
| 2 | Filter for known toxic patterns | Spam score, DR <10, foreign spam |
| 3 | Manual review of flagged links | Visit each flagged domain |
| 4 | Attempt removal via email first | Contact webmasters |
| 5 | Wait 2 weeks for removal responses | Track outreach results |
| 6 | Add non-removed toxic links to disavow | Format as .txt file |
| 7 | Upload to Google Search Console | Disavow Links tool |
| 8 | Document all actions and dates | Internal records |
| 9 | Re-check in 4-6 weeks | Verify processing |

**The sequence does not compress under a deadline.** Steps 4 and 5 are what keep good links out of the file, and they are exactly the two a same-day request asks you to skip. The two-week window at step 5 is real waiting time, not a formality to mention and then step over: the tool applies the file you upload rather than reviewing whether it was warranted, and a disavow is slow and uncertain to reverse, so a link wrongly included costs more than a link left in the profile another week. When a client wants the upload today, the deliverable says what can finish today — steps 1-4, plus the file drafted and held — and what cannot, with the date the sequence reaches the upload. Removal outreach is never described as optional or parallel to the upload; it is the step the upload waits on. A file that leaves your hands before outreach has run carries a plain statement that no removal outreach was attempted, and a clean manual-actions report is recorded as lower urgency rather than as evidence that disavowing is safe.

---

## 5. Link Profile Health Benchmarks

### Healthy Profile Indicators

| Metric | Healthy Range | Warning Sign | Critical |
|--------|-------------|--------------|----------|
| Dofollow ratio | 60-80% | >90% | >95% |
| Exact match anchor % | <15% | 15-25% | >25% |
| Brand anchor % | 25-45% | <15% | <5% |
| Toxic link % | <5% | 5-10% | >10% |
| Referring domain growth | Positive, steady | Flat | Declining |
| Average linking DR | 25+ | 15-25 | <15 |
| Link diversity (unique domains / total links) | >0.3 | 0.1-0.3 | <0.1 |
| Topical relevance (sampled) | >60% | 40-60% | <40% |

### Industry-Specific Benchmarks — see §6 for what may never be recommended to close a gap

Authority expectations vary significantly by industry vertical.

| Industry | Typical DR Range (Top 10 Sites) | Typical Referring Domains | Link Difficulty |
|----------|-------------------------------|--------------------------|----------------|
| Finance / Insurance | DR 60-90 | 5,000-50,000+ | Very High |
| Health / Medical | DR 50-85 | 3,000-30,000+ | Very High |
| Technology / SaaS | DR 40-80 | 1,000-20,000+ | High |
| E-commerce (general) | DR 35-75 | 500-15,000+ | High |
| Legal | DR 40-70 | 1,000-10,000+ | High |
| Education | DR 50-90 | 2,000-25,000+ | Medium-High |
| Local services | DR 15-45 | 50-500 | Medium |
| B2B niche | DR 25-60 | 200-5,000+ | Medium |
| Blog / Content site | DR 20-70 | 100-10,000+ | Medium |
| New startup | DR 5-25 | 10-200 | Starting point |

_Note: These are general ranges. Actual requirements depend on your specific keyword competition._

---

## 6. The Acquisition Floor

The library-wide statement is [prohibited-tactics.md](../../../references/prohibited-tactics.md),
entries **4** (manipulative link acquisition) and **10** (expired-domain and redirect
appropriation). This section is that floor applied to link work: the shapes that get refused, the
ordinary practice each one is confused with, and how an instance already in the client's profile is
written up.

### 6.1 What this skill never recommends

Bought or rented links · private blog networks · reciprocal and exchange schemes ("we'll link to
you if you link to us", three-way swaps, link-exchange marketplaces) · bulk guest-post placement
bought from a vendor list · comment and forum-signature spam · mass low-quality directory
submission · anchor-text-for-hire · buying an expired domain for the links it carries · redirecting
an unrelated acquired domain into the money site · parasite hosting on a borrowed authority domain.

Two reasons, both of which hold whatever any engine does about it:

1. **A link is meant to be evidence of somebody else's judgement.** A bought one is evidence of a
   transaction. The signal the client is paying for is the thing the purchase destroys.
2. **The whole class is devaluable retroactively.** The spend is immediate and the exposure is
   open-ended, so "it has worked so far" is not evidence that it is safe — it is the sentence the
   At-Risk profile in §2 above could have written the month before it became one.

Refusal is recorded in the working notes and the run moves on. A refused tactic does not become a
declined option in the client's report, and the report never carries a list of what was declined —
it carries findings and actions ([prohibited-tactics.md](../../../references/prohibited-tactics.md)
§4).

### 6.2 Where the line runs

A rule that over-fires on ordinary competitive work gets ignored, so the distinction is stated in
both directions. Each row below is legitimate on the left and prohibited on the right, and the test
in the middle is the one that separates them.

| Legitimate | The test | Prohibited |
|---|---|---|
| A contributed article pitched individually to a publication that fits, written for its readers and edited by them | Would this publication have taken the pitch on its merits, and does the editor decide what runs? | Bulk guest-post placement bought per-URL from a vendor list, anchor text specified in the order |
| Digital PR: original data, a tool, primary research, a story a journalist wants | The link follows from something worth citing | Paying for the mention, or paying a "PR" vendor per placed link |
| A genuine partnership, supplier, association, or customer relationship that both sides describe on their own sites | The relationship exists off the link | Reciprocal linking arranged for the links themselves, at scale or via a swap group |
| Getting listed on comparison, review, industry and local platforms the business actually qualifies for | The listing is a placement the business is eligible for, and a human would find it useful | Mass submission to directories nobody reads, built to be submitted to |
| A disclosed advertising or sponsorship placement carrying `rel="sponsored"` | The paid relationship is declared in the markup and to the reader | The same placement with the disclosure removed so it passes as editorial |
| Buying a domain for its brand, its traffic, or its business, and redirecting it because the business genuinely moved | The redirect describes something that actually happened | Buying an expired domain for its link profile; redirecting an unrelated domain into the money site |
| Reclaiming a lost link, fixing a broken one, converting an unlinked mention | The publisher already chose to write about the client | Buying the placement back when the publisher says no |

**Sponsored is not a loophole and not a dirty word.** Factor 6 scores `rel="sponsored"` at 3, below
editorial and above nofollow, precisely because it is honest paid placement: the reader and any
consumer of the markup both see what it is. What entry 4 prohibits is a paid link dressed as an
earned one.

### 6.3 An instance already in the profile

A manipulated profile is a normal audit result, and it is handled like every other risk finding —
named, costed, remediated, owned, ranked
([prohibited-tactics.md](../../../references/prohibited-tactics.md) §2). The remediation carries
the seven fields in [action-output-contract.md](../../../references/action-output-contract.md); the
three that are not optional are the action, the owner-role, and an acceptance criterion somebody
outside the engagement could check in six weeks without asking what was meant.

Worked shapes — the criteria, not the numbers, are the point:

| Finding | Owner | Acceptance criterion |
|---|---|---|
| 34 links from a paid-placement vendor, still live | `Agency` (outreach) → `Client decision` (spend stops) | Each of the 34 URLs re-checked on a dated crawl export: link removed, or `rel="sponsored"` added, or listed in the disavow file version dated in that export's week — with which of the three recorded per URL |
| Reciprocal swap block in the site footer, 12 partners | `Developer` | The footer block is gone from the live template on every URL type, verified in a crawl of the production site; the 12 partner relationships that are real appear in body content instead, or nowhere |
| An unrelated domain redirecting into the money site | `Client decision`, then `SEO/technical` | The redirect is removed or repointed to a holding page; a crawl dated after the change shows no 3xx chain from that host into the primary domain |
| 400 directory listings from a 2014 submission run, dormant | `SEO/technical` | The reviewed list exists with a keep/disavow decision per domain and a date; the disavow file reflects it |

**Rank them against the rest of the report, and expect the ranking to split them.** The first three
are usually urgent. The fourth is usually not — a dormant 2014 directory listing is not more urgent
than a broken conversion path, and a report where everything is critical has ranked nothing. The
ordering rule already in force is expected impact ÷ effort with dependencies respected; nothing
about a finding being a prohibited tactic exempts it from that.

**Do not build on it.** Any recommendation elsewhere in the report that depends on the prohibited
links staying live — an authority projection, a "we already have X referring domains" baseline, a
competitive-position rank — is withdrawn or restated without them, and the dependency is named. And
the skill reports and proposes: it never removes or alters a client's live property on its own
initiative.
