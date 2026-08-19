# AI Citation Patterns

This library's working model of how different AI systems present and attribute the content
they quote, and what to put on a page in response.

> **Evidence grade — read before quoting anything in this file.** No engine publishes its
> citation-selection mechanics. What is genuinely observable is the **citation style** each
> product visibly uses in its own output — inline numbers, a footnoted Sources list, named
> attribution — and that is what the per-engine sections below record. The **"what gets
> cited" / "prefers" / "values" lists beside them are this library's judgement about where to
> spend effort**, not a preference any engine has stated. Ruling R3 amendment 9a retracted a
> claim of exactly this shape — that FAQPage markup earns AI citations — on the ground that
> **no primary source establishes it in either direction**; that absence is not narrower here.
>
> **In a deliverable**: use these sections to order work, and justify every recommendation by
> what it puts on the page — a standalone definition that can be lifted and quoted intact, a
> comparison a reader can scan, a source a reader can follow. Never by an asserted engine
> mechanic. "Engines extract from the first paragraph" is not a sentence this library can
> source; "the answer is in the first 150 words, where a reader and any extractive consumer
> both reach it without scrolling" is.

> **Standing rule for every example in this file.** The per-engine sections below
> describe real systems and carry `[VERIFY]` tags where the evidence is weak — read those
> tags as written. The **worked examples** are a different genre and follow a different rule:
> an illustrative example never attributes data or a quotation to a real organisation or a
> real person. Their sources are fictional stand-ins built on the reserved `Example` name,
> and the figures beside them are invented to show the *shape* of a citable sentence. The
> only alternative is to cite something genuinely verifiable — a named, dated, locatable
> publication you have read. Never copy a source name, figure or quote out of an example into
> client copy, and **never attribute a statement to a real named individual without a record
> of them making it**.

## Google AI Surfaces (AI Mode and AI Overviews)

**Baseline shift**: Google's AI surfaces are AI Mode and AI Overviews. What Google actually said at I/O 2026 is narrower than the claim this line used to carry: Gemini 3.5 Flash is "the new default model in AI Mode for everyone globally" — a default *model within* AI Mode, not a statement that AI Mode is the default search surface — and the same post says "You'll continue to get a range of results from Search, just like you do today" (blog.google, Search I/O 2026, read 2026-08-18). Google's AI-features documentation adds that AI Overviews "are only shown when our systems determine that it is additive to classic Search, and as such, often don't trigger". Live for Greek-language queries since 08-10-2025. So optimize for in-surface citation as well as ranking position — but do not baseline CTR on a claim no Google source states.

### Citation Behavior

**Format preferences**:
- Prefers structured, factual content
- Cites multiple sources per overview
- Shows source links as footnotes
- Displays "Sources" section at bottom

**What gets cited**:
- Clear, direct answers to queries
- Statistics with recent dates
- Step-by-step instructions
- Comparison tables
- Definition blocks
- List-formatted content

**Content structure preferences**:
- Short paragraphs (2-3 sentences)
- Bullet points and numbered lists
- Clear headings matching query intent
- Tables for comparison data
- FAQ formats

**Authority signals**:
- Domain authority (trusted sites favored)
- E-E-A-T signals (expertise, authoritativeness, trustworthiness)
- Recent publication/update dates
- Author credentials visible
- Citations to other authoritative sources

**Citation frequency**: Typically cites 3-8 sources per AI Overview [VERIFY — no engine-published figure; an observed range with no stated methodology, unverified as of 2026-08-10]

---

## ChatGPT (with Browsing)

### Citation Behavior

**Format preferences**:
- Inline citations with numbers [1], [2]
- "Sources" list at end of response
- Clickable source links
- Sometimes quotes directly with quotation marks

**What gets cited**:
- Specific facts and statistics
- Expert quotes
- Technical explanations
- Recent information (prioritizes freshness)
- Authoritative domain content
- Well-structured, scannable content

**Source selection patterns**:
- Favors .edu, .gov, .org domains
- Prioritizes recognized brands/publishers
- Values comprehensive content over thin pages
- Prefers content with clear attribution
- Looks for consensus across multiple sources

**Quoting behavior**:
- Pulls exact quotes when information is distinctive
- Paraphrases general information
- Combines information from multiple sources
- Attributes specific claims to sources

**Citation frequency**: 1-6 sources per response depending on complexity [VERIFY — same status as the AI Mode figure above: observed, no published source, unverified as of 2026-08-10]

---

## Perplexity AI

### Citation Behavior

**Format preferences**:
- Superscript numbers [1] inline
- Numbered source list with snippets
- Shows brief excerpt from each source
- Displays domain name and publish date

**What gets cited**:
- Recent content (strong freshness bias)
- Authoritative sources
- Content with clear, quotable statements
- Statistical data with sources
- Primary sources over secondary
- Content matching query intent precisely

**Content structure preferences**:
- Extremely well-structured content
- Clear topic sentences
- Quotable, standalone statements
- Factual density (stats, data, specifics)
- Headings that match question formats

**Authority signals**:
- Domain credibility
- Author expertise
- Publication reputation
- Recency of content
- Depth of coverage

**Citation frequency**: Typically 5-10 sources per response (more than others) [VERIFY — observed, no published source, unverified as of 2026-08-10]

**Unique behavior**: Often shows "Follow-up Questions" that can reveal additional citation opportunities

---

## Claude (Knowledge-Based Responses)

### Citation Behavior

**Note**: [VERIFY — 2026-08-17] This library has carried "Claude typically relies on training data rather than live web access, but understanding preferences helps create citeable content." Both halves are withdrawn from assertion: **how a product sources its answers** is an engine mechanic no primary source read here establishes, and the second clause claims a benefit from "understanding preferences" that this file's own head note says no engine has stated. Web access varies by product surface and configuration in any case, so a single disposition is the wrong shape of claim. Do not state either to a client. What survives is the observable: **what a page puts on the page.** A standalone definition can be lifted and quoted intact whether or not anything fetched it, and that is the reason to write one.

**Format preferences**:
- When citing, uses clear attribution phrases
- "According to [source]..."
- "Research from [source] shows..."
- May reference general knowledge without specific citations

**What gets remembered/prioritized**:
- Clear, authoritative definitions
- Widely-accepted facts and statistics
- Well-established methodologies
- Consensus information
- Content from recognized authorities

**Content characteristics valued**:
- Factual accuracy and precision
- Logical structure and clarity
- Comprehensive explanations
- Technical accuracy
- Unambiguous language

---

## Common Traits Across All AI Systems

### Universal Citation Factors

**Content quality**:
- Factual accuracy (an incorrect figure is a liability wherever it is repeated)
- Clear, unambiguous language
- Proper grammar and spelling
- Comprehensive coverage
- Up-to-date information

**Structure**:
- Scannable format (headings, lists, tables)
- Logical organization
- Clear topic segmentation
- Short paragraphs
- Visual hierarchy

**Authority**:
- Domain credibility
- Author credentials
- Source citations in content
- Expertise signals
- Editorial quality

**Relevance**:
- Precise match to query intent
- Topic focus (not meandering)
- Keyword-topic alignment
- Depth of coverage on specific topic

---

## Optimal Content Structures for Citation

### 1. Definition Blocks

AI systems love clear, quotable definitions.

**Structure**:
```markdown
**[Term]** is [clear category] that [primary function], [key characteristic].
```

**Example**:
> **Search Engine Optimization (SEO)** is a digital marketing practice that improves website visibility in organic search results by optimizing content, technical elements, and authority signals.

**Why it works**: Standalone, complete, unambiguous, proper scope.

---

### 2. Statistic Blocks

Facts with sources are highly citeable.

**Structure**:
```markdown
According to [Source], [specific statistic] as of [timeframe].
```

**Example**:
> According to the Example Marketing Council's 2026 State of Marketing survey (2,300 marketers), 82% of respondents actively invest in content marketing — the most widely adopted strategy in the sample.

**Why it works**: Specific, attributed, dated, scoped to what the survey actually measured, and checkable because the source is named. (`Example Marketing Council` is a fictional stand-in per the standing rule above — in real copy, name a survey you have read and link it.)

---

### 3. Q&A Pairs

Question-answer formats match AI query patterns.

**Structure**:
```markdown
### [Question matching common query]?

[Direct answer in 40-60 words]

[Optional supporting detail]
```

**Example**:
> ### How long does SEO take to show results?
>
> SEO typically takes 3-6 months to show significant results for new websites, though this varies based on competition, domain authority, and strategy. Established sites may see improvements in 1-3 months for less competitive keywords.

**Why it works**: Matches query format, provides concise answer, includes qualifiers.

**On the 40-60 words**: 40 is a floor, not an average. A shorter answer is a fragment an engine cannot lift on its own — count the words.

---

### 4. Comparison Tables

A structured comparison turns values into addressable cells instead of prose a reader has to reassemble.

**Structure**:
```markdown
| Feature | Option A | Option B |
|---------|----------|----------|
| [Factor 1] | [Specific value] | [Specific value] |
| [Factor 2] | [Specific value] | [Specific value] |
| **Best for** | [Use case] | [Use case] |
```

**Example**:
| Factor | Technical SEO | On-Page SEO |
|--------|---------------|-------------|
| Focus | Site infrastructure | Content optimization |
| Timeframe | 1-3 months | Ongoing |
| Complexity | High | Medium |
| **Best for** | Site-wide issues | Individual page improvements |

**Why it works**: Clear comparison, specific values, scannable format.

---

### 5. Step-by-Step Processes

Numbered lists for "how to" queries.

**Structure**:
```markdown
1. **[Action]** - [Brief explanation]
2. **[Action]** - [Brief explanation]
3. **[Action]** - [Brief explanation]
```

**Example**:
> To conduct keyword research:
> 1. **Identify seed keywords** - List 5-10 topics your audience searches for
> 2. **Use keyword research tools** - Expand seed keywords into hundreds of variations
> 3. **Analyze search intent** - Determine what content format each keyword requires
> 4. **Evaluate competition** - Assess ranking difficulty for each keyword
> 5. **Prioritize keywords** - Choose based on volume, difficulty, and relevance

**Why it works**: Clear process, actionable steps, logical sequence.

---

### 6. List-Based Content

Curated lists with brief explanations.

**Structure**:
```markdown
**[Item name]**: [Clear description with key benefit]
```

**Example**:
> Top on-page SEO factors:
> - **Title tags**: Most important on-page element; include primary keyword within first 60 characters
> - **Header tags**: Structure content hierarchically; use one H1, multiple H2s for main sections
> - **Meta descriptions**: Don't directly impact rankings but affect CTR; keep under 160 characters
> - **URL structure**: Use descriptive, keyword-rich URLs without unnecessary parameters

**Why it works**: Scannable, specific, actionable.

---

### 7. Before/After Examples

Concrete examples showing transformation.

**Structure**:
```markdown
**Before**: [Weak example]
**After**: [Strong example]
**Why it's better**: [Explanation]
```

**Example**:
> **Before**: "Email marketing is pretty effective."
> **After**: "Email marketing returned an average of $36 for every $1 spent across 620 small-business campaigns (Example Marketing Council, 2026 channel benchmark)."
> **Why it's better**: Specific statistic, attributed source with a year and a sample size, quantifiable claim.

**Why it works**: Shows concrete improvement, demonstrates principle.

---

### 8. Key Insight Callouts

Highlighted important points.

**Structure**:
```markdown
> **Key insight**: [Memorable, quotable statement]
```

**Example**:
> **Key insight**: Internal linking is the authority lever you own outright — every page you publish can be linked, on the day it ships, from the pages that already rank, without asking anyone's permission.

**Why it works**: Visually distinct, quotable, and it needs no borrowed authority. A callout that opens "according to [well-known name]" without a link to where that person said it is a fabrication wearing a citation's clothes — and it is the shape this file used to model here.

---

## Content Optimization by Query Type

### Informational Queries ("What is...", "How does...", "Why...")

**AI citation priorities**:
1. Clear definitions
2. Comprehensive explanations
3. Expert perspectives
4. Supporting statistics
5. Real-world examples

**Optimal structure**:
- Definition in first paragraph
- "Why it matters" section
- How it works explanation
- Common use cases
- Expert quotes or citations

---

### Comparison Queries ("[A] vs [B]", "Best [category]")

**AI citation priorities**:
1. Comparison tables
2. Clear pros/cons lists
3. Use case recommendations
4. Specific differentiators
5. Verdict or recommendation

**Optimal structure**:
- Quick comparison table upfront
- Individual descriptions
- Feature-by-feature comparison
- "Choose X if..." recommendations
- Summary verdict

---

### How-To Queries ("How to...", "Steps to...")

**AI citation priorities**:
1. Numbered step-by-step processes
2. Required tools/prerequisites
3. Time estimates
4. Success indicators
5. Troubleshooting tips

**Optimal structure**:
- Prerequisites listed first
- Clear numbered steps
- Sub-steps where needed
- Visual indicators of progress
- Common problems and solutions

---

### Statistical Queries ("How much...", "How many...", "Statistics about...")

**AI citation priorities**:
1. Specific numbers with sources
2. Recent data (within 1-2 years)
3. Multiple data points
4. Context for statistics
5. Trend information

**Optimal structure**:
- Lead with key statistic
- Source attribution immediately after
- Context and interpretation
- Related statistics
- Takeaways from data

---

## Citation-Readiness Factors

> **Renamed 2026-08-17, and the rename is the point.** These tiers previously read *High /
> Medium / Low Citation Likelihood*, which states a probability that an engine will cite the
> page — a claim about engine behaviour that no primary source establishes in either
> direction (ruling R3 amendment 9a), and one that
> [geo-score-arithmetic.md](./geo-score-arithmetic.md) §6 lets a run **print in a client
> report**. Every factor below is unchanged and still right; each is a property of the page a
> reader can confirm by opening it. What the count reports is how far the page is set up to
> be quoted — not how likely any engine is to quote it. Whether it was quoted is **measured**
> (CITE C05-C08, rank-tracker's citation counts), never predicted.

### Full readiness — the ten-factor set

- [ ] Content from recognized authority domains
- [ ] Published or updated within 12 months
- [ ] Clear, standalone statements
- [ ] Proper source attribution
- [ ] Specific statistics with dates
- [ ] Structured with headings/lists/tables
- [ ] Comprehensive topic coverage
- [ ] Author credentials visible
- [ ] Technical accuracy verified
- [ ] Consensus with other sources

### Partial readiness

- [ ] Content from less-known but quality domains
- [ ] Published 1-2 years ago
- [ ] Clear but requires slight context
- [ ] General industry claims
- [ ] Good structure but less scannable
- [ ] Moderate depth of coverage
- [ ] No author listed but quality content
- [ ] Some supporting evidence

### Low readiness

- [ ] Content from unknown/low-authority domains
- [ ] Published 3+ years ago without updates
- [ ] Vague or ambiguous statements
- [ ] No sources cited
- [ ] Poor content structure (walls of text)
- [ ] Thin or superficial coverage
- [ ] Promotional or biased tone
- [ ] Factual inconsistencies
- [ ] No expertise signals

---

## AI System Comparison Summary

| Factor | Google AI Mode | ChatGPT | Perplexity | Claude |
|--------|---------------------|---------|------------|--------|
| **Freshness bias** | High | Medium | Very high | N/A (training data) |
| **Authority weight** | Very high | High | High | High |
| **Structure importance** | High | Medium | Very high | Medium |
| **Citation count** | 3-8 | 1-6 | 5-10 | N/A |
| **Quotable focus** | High | Medium | Very high | High |
| **Domain trust** | Very high | High | Medium | High |
| **Factual density** | High | High | Very high | Very high |

**Source note** [VERIFY — 2026-08-10]: every cell above is an observational summary, not an engine-published metric. No engine documents how it weights freshness, authority, structure or domain trust, and none publishes its citation counts — the numbers repeat the ranges tagged in the sections above and inherit their status. Treat the whole table as a directional prior to test per engine on your own pages, never as a specification to quote to a client.

---

## Per-Engine Overlap & Community Citations

Engines don't share sources as much as "AI traffic" framing assumes. [VERIFY – 2026 industry studies, unverified methodology]:

- **ChatGPT ↔ Perplexity domain overlap**: ~11%. Citation on one engine doesn't predict citation on the other for the same query.
- **Community/UGC citation share**: Reddit-type community content ≈40% of citations across engines — forums and discussion threads are a real, non-brand citation channel.

**Implication**: optimize and track citation presence per engine — separate rows per engine in any visibility report, not one combined "AI traffic" metric.

**Community channel** [VERIFY, directional]: where topically relevant, monitor (and, if genuinely useful, participate in) relevant community threads — Reddit, niche forums; for Greek-market queries, insomnia.gr-type communities where relevant. Presence is a citation channel, never a guaranteed placement.

**AIO/AI Mode quote-preview module** (Google-announced 2026-05-06, blog.google "How AI Mode and AI Overviews help you explore the web"): AI responses can include a section — labeled "Expert Advice", "Community Perspectives", or similar depending on the query — that previews verbatim quotes from forum/social UGC (Reddit, niche forums, blogs) with the creator's name/handle/community and a link to the source thread. Being the quoted voice in a relevant thread is therefore a direct AIO/AI Mode surface, not just a background citation signal. [VERIFY – rollout scope: US/English first (2026-05-06/07, vendor-reported); el-GR availability unconfirmed; Google post full text unread from cloud (blog.google egress-blocked). Resolves when: local read of the blog.google post confirms wording/scope AND/OR first el-GR SERP sighting of the module.]

**Not citation levers**: llms.txt is a dead lever — do not add one expecting citation gains (settled ruling R1). Schema stacking is not a citation lever either (settled ruling R2): adding types on the theory that more types raise citation odds buys nothing, and no engine documents a gain from extra markup. The boundary that ruling draws — teach it, not "pile on types" and not "one object, never two":

- **One PRIMARY content type per page** (O05), chosen by what the page is.
- **Documented auxiliaries are not stacking**: BreadcrumbList where a real breadcrumb trail exists (a Google-documented site-structure feature), Organization/Person nested as publisher or author, WebSite on the homepage. Each has its own engine-documented, non-citation job — none of them is added for citations, which is why the ruling permits them.
- **A second full content type is stacking and stays banned**: FAQPage bolted onto a service or product page, Article and Product both as primaries. The one exception is narrow — the page genuinely is both things and each type is complete, accurate and independently justified.
- **FAQ**: the visible Q&A block stands on its own — it is readable text on the page, reachable by any consumer with or without markup, and the markup adds no wording a reader or a parser cannot already see. (Not "engines parse it": no primary source establishes what any engine does with either form — ruling R3 amendment 9a.) FAQPage markup is emitted only where FAQPage is the page's one primary type. Type selection and emission live in `build/schema-markup-generator/`, which carries the same boundary — hand the decision there.

---

## Tracking AI Citations

### Manual Monitoring

**Check if your content appears in**:
- Google AI Mode / AI Overviews for target keywords
- ChatGPT responses (search your domain in ChatGPT)
- Perplexity results for relevant queries
- Other AI search engines
- Community threads (Reddit, niche forums) that engines cite [VERIFY, directional]

**Test queries**:
- Exact-match questions from your FAQ
- Definitions of terms you've defined
- Statistics you've cited with attribution
- Processes you've documented

### Indicators of AI Visibility

- Increased direct traffic (AI users clicking sources)
- Traffic spikes from unusual referrers
- Engagement metrics: low bounce rate, high time-on-page
- Return visitors (AI users coming back for more depth)

---

## Optimization Checklist for AI Citations

Content ready for AI citation should have:

- [ ] At least 3 clear, quotable definitions
- [ ] 5+ specific statistics with sources and dates
- [ ] Q&A format sections covering top queries
- [ ] Comparison tables where relevant
- [ ] Numbered lists for processes
- [ ] Content published or updated within 12 months
- [ ] Author credentials visible
- [ ] External citations to authoritative sources
- [ ] Structured with clear H2/H3 headings
- [ ] Short paragraphs (2-4 sentences)
- [ ] No promotional language
- [ ] Technical accuracy verified
- [ ] Mobile-friendly formatting
