# Keyword Prioritization Framework

Systematic scoring methodology for ranking keywords by strategic value.

## Relationship to Opportunity Score

**Which score to use**: Use the Priority Score (below) for initial keyword triage and shortlisting — it is the five-factor one, and two of its factors (Business Relevance, Trend Direction) are judgment calls that need no tool. Use the Opportunity Score (Step 7 in the main workflow: `Opportunity = (Volume × Intent Value) / Difficulty`) for final content calendar prioritization: three inputs, two of them tool metrics, which makes it sharper for sequencing expected traffic return — and unusable when those two metrics are missing (Step 7's unavailable-input rule, and "When a Factor Cannot Be Scored" below).

Neither score contains a GEO factor or a competitive factor. GEO candidates are identified in Step 8, and competitor keyword gaps belong to [competitor-analysis](../../competitor-analysis/) — do not describe either score as accounting for them.

## Difficulty Bands (SKILL.md Step 6)

Each keyword is scored 1-100 for difficulty and read into one of three bands. The band numbers are
fixed and are shared with `serp-analysis` Step 7, whose weighted SERP difficulty reads into the
same three: a keyword called Medium here and Medium there means the same thing.

| Band | Score | What the SERP looks like |
|------|-------|--------------------------|
| **High** | 70-100 | Major brands ranking · high domain-authority competitors · established content (1000+ backlinks) · paid ads dominating the SERP |
| **Medium** | 40-69 | A mix of authority sites and niche sites · moderate backlink requirement · room for quality content to compete |
| **Low** | 1-39 | Few authoritative competitors · thin or outdated content ranking · long-tail variations · new or emerging topics |

Where a difficulty score comes from a connected tool, the tool is named beside it — a vendor's
Keyword Difficulty is that vendor's instrument, not this one, and the two are never ranked against
each other in one column. Where no tool is connected and nothing was supplied, difficulty is not
scored: the cell carries an explained N/A and the report says so, per Step 11. It is never
estimated into one of the three bands to keep the column looking complete.

## Priority Scoring Matrix

Score each keyword 1-5 on these factors, then calculate weighted total:

| Factor | Weight | Score 1 (Low) | Score 5 (High) |
|--------|--------|---------------|----------------|
| Search Volume | 20% (0.20) | <100/mo | >10,000/mo |
| Keyword Difficulty | 25% (0.25) | KD >80 (hard) | KD <20 (easy) |
| Business Relevance | 30% (0.30) | Tangential to offering | Core to offering |
| Search Intent Match | 15% (0.15) | Informational only | Transactional/commercial |
| Trend Direction | 10% (0.10) | Declining | Growing |

**Priority Score** = Σ(Factor Weight × Score) — weights as decimals (0.20 / 0.25 / 0.30 / 0.15 / 0.10), each Score 1-5. There is no further divisor: the weights already sum to 1.00, so the result lands in **1.0-5.0**, which is the range the bands below are written on.

Worked: Volume 3, Difficulty 4, Relevance 5, Intent 4, Trend 2 →
`0.20×3 + 0.25×4 + 0.30×5 + 0.15×4 + 0.10×2 = 0.60 + 1.00 + 1.50 + 0.60 + 0.20 = 3.90` → **P1**.

**Do not divide by 5.** Dividing maps the whole scale into 0.20-1.00, where P0, P1 and P2 are unreachable and only a straight 5 on all five factors touches the bottom of P3. (Reading the weights as whole percents instead gives 20-100, outside every band.) A Priority Score that cannot land in its own bands is the arithmetic error, not the keyword.

## Priority Categories

| Priority | Score Range | Action |
|----------|------------|--------|
| P0 — Must Target | 4.0-5.0 | Create content immediately |
| P1 — High Value | 3.0-3.9 | Queue for next content sprint |
| P2 — Opportunity | 2.0-2.9 | Plan for future content calendar |
| P3 — Monitor | 1.0-1.9 | Track but don't prioritize |

Round half up to one decimal before reading the band: the factor weights make x.x5 results reachable (0.20×4 + 0.25×4 + 0.30×5 + 0.15×3 + 0.10×2 = 3.95), and the bands are contiguous only on rounded values — 3.95 → 4.0 → P0.

## When a Factor Cannot Be Scored

A factor with no data behind it is not scored 0 (the scale starts at 1) and is not scored 1 — scoring it 1 asserts "low", which is a claim you do not have. **Drop the factor and renormalise the remaining weights over their own sum**, the shrinking-denominator rule this library already applies to N/A items in `cross-cutting/domain-authority-auditor/references/score-arithmetic.md` §3:

```
renormalised weight = factor weight ÷ (sum of the weights that can be scored)
```

Zero-data run (no tool connected, nothing supplied): Search Volume, Keyword Difficulty and Trend Direction cannot be scored — 0.20 + 0.25 + 0.10 = **0.55 of the matrix**. What is left:

| Factor | Original weight | Renormalised weight |
|--------|-----------------|---------------------|
| Business Relevance | 0.30 | 0.30 ÷ 0.45 = **0.667** |
| Search Intent Match | 0.15 | 0.15 ÷ 0.45 = **0.333** |

The renormalised weights sum to 1.00, so the score still lands in 1.0-5.0 and the bands still read. Worked: Relevance 5, Intent 4 → `0.667×5 + 0.333×4 = 3.335 + 1.332 = 4.667` → rounded **4.7 → P0**.

- **State the rescaling beside the score** — the denominator, or the renormalised weights themselves, plus which factors dropped out and why: `P0 — 4.7/5 on 2 of 5 factors (Volume, Difficulty and Trend unscoreable: no tool connected and no data supplied; weights renormalised over 0.45)`. "Relevance 2/3, intent 1/3, the three tool-metric factors dropped" says the same thing and is equally acceptable; a rescaled score with no such note is not.
- **Renormalise once for the whole run**, not per keyword, so the rows stay comparable. If a factor is scoreable for only some keywords — a partial export, say — either score the whole set without it, or say plainly which rows used which denominator.
- **Never fill an unscoreable factor with a guess** to keep the matrix whole. That is the invented number SKILL.md's Output Validation forbids, one level of arithmetic down.

## AI Potential Rating (the stars on GEO rows)

GEO/conversational tables carry an AI Potential rating instead of an Opportunity Score, because
the tools usually report no difficulty for question-shaped queries and the formula's denominator
is missing. A star rating still has to be countable, so it is:

**1 star** for matching one of Step 8's high-GEO query formats (question, definition, comparison,
list, how-to) — every row in a GEO table has this by construction — **plus 1 star for each of
Step 8's four AI answer indicators the keyword meets**: the query is factual or definitional · the
answer can be summarised concisely · the topic is well documented online · commercial intent is
low. Range 1-5, every value reachable.

Print the count and the indicator that failed, beside the stars: `⭐⭐⭐⭐ 4/5 — the answer is a long
list, not a concise one`. Five identical five-star rows tell a client nothing; the failing
indicator is the part that says what to write. The rating orders GEO candidates against each other
only — it is not on the Opportunity Score's scale, and the two never share a ranking.

## Seasonal Keyword Patterns

### Seasonal Analysis Framework

| Season Trigger | Example Keywords | Planning Lead Time | Content Strategy |
|---------------|-----------------|-------------------|-----------------|
| Calendar events | "Black Friday SEO", "New Year marketing plan" | 3-4 months ahead | Publish 6-8 weeks before peak |
| Industry events | "[Conference] takeaways", "Google algorithm update" | 1-2 months / reactive | Pre-plan templates, react quickly |
| Budget cycles | "marketing budget template Q1", "SEO ROI report" | 2-3 months ahead | Target planning season (Oct-Dec) |
| Seasonal demand | "summer marketing ideas", "holiday email campaigns" | 2-3 months ahead | Refresh annually with new data |
