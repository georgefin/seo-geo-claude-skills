---
name: geo-content-optimizer
version: "4.4.8"
description: 'Optimize content for AI citation across Google AI Mode (default search surface, incl. AI Overviews), ChatGPT, Perplexity, and Gemini with quotable statements and structured Q&A. Use when the user asks to "optimize for AI", "get cited by ChatGPT", "GEO optimization", "appear in AI answers", "make content AI-quotable", "Google AI Overview optimization", or "Google AI Mode optimization". Adds quotable statements, structured Q&A, precise statistics with sources, expert attribution, and a structured FAQ. Uses CORE-EEAT GEO-First items as optimization targets. For SEO-focused writing, see seo-content-writer. For entity and brand AI presence, see entity-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.4.8"
  geo-relevance: "high"
  tags:
    - geo
    - ai-citations
    - chatgpt
    - perplexity-ai
    - google-ai-overview
    - gemini
    - llm-citations
    - generative-engine-optimization
    - ai-overview-optimization
    - quotable-content
  triggers:
    - "optimize for AI"
    - "get cited by ChatGPT"
    - "AI optimization"
    - "appear in AI answers"
    - "GEO optimization"
    - "AI-friendly content"
    - "LLM citations"
    - "get cited by AI"
    - "show up in ChatGPT answers"
    - "AI doesn't mention my brand"
    - "make content AI-quotable"
---

# GEO Content Optimizer

This skill optimizes content to appear in AI-generated responses. As AI systems increasingly answer user queries directly, getting cited by these systems becomes crucial for visibility.

## When to Use This Skill

- Optimizing existing content for AI citations
- Creating new content designed for both SEO and GEO
- Improving chances of appearing in Google AI Mode (default surface; AI Overviews folded in)
- Making content more quotable by AI systems
- Adding authority signals a reader can check — a named author, a dated source, a linkable credential
- Structuring content for AI comprehension
- Competing for visibility in the AI-first search era

## What This Skill Does

1. **Citation Optimization**: Rewrites statements so they can be lifted and quoted intact
2. **Structure Enhancement**: Formats content for AI comprehension
3. **Authority Building**: Adds signals a reader can check — named author, credentials, dated sources
4. **Factual Enhancement**: Improves accuracy and verifiability
5. **Quote Creation**: Creates memorable, citeable statements
6. **Source Attribution**: Adds citations a reader can follow to a named, dated, locatable source
7. **GEO Scoring**: Evaluates content's AI-friendliness

## How to Use

### Optimize Existing Content

```
Optimize this content for GEO/AI citations: [content or URL]
```

```
Make this article more likely to be cited by AI systems
```

### Create GEO-Optimized Content

```
Write content about [topic] optimized for both SEO and GEO
```

### GEO Audit

```
Audit this content for GEO readiness and suggest improvements
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

> **Note:** All integrations are optional. This skill works without any API keys — users provide data manually when no tools are connected.

**With ~~AI monitor + ~~SEO tool connected:**
Automatically pull AI citation patterns (which content is being cited by ChatGPT, Claude, Perplexity), current AI visibility scores, competitor citation frequency, and AI Mode/AI Overview appearance tracking.

**With manual data only:**
Ask the user to provide:
1. Target queries where they want AI citations
2. Current content URL or full content text
3. Any known instances where competitors are being cited by AI
4. The page's publish/update date, and how old the data on it is — the freshness factor is scored in step 2 and cannot be scored without them
5. What the byline can carry: author name and credentials, and whether a quotable expert is available with a sourceable quote — the authority factor asks for what this client actually has, not for all four elements by default
6. Any structured data already on the page, and which type — the one-primary-type decision (step 1) is made on fact, not assumption

Proceed with the full workflow using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests GEO optimization:

1. **Load CORE-EEAT GEO-First Optimization Targets**

   Before optimizing, load GEO-critical items from the [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md):

   ```markdown
   ### CORE-EEAT GEO-First Targets

   This library's do-first order (`references/core-eeat-benchmark.md` §4) — a prioritisation
   model, **not documented engine behaviour**. Each reason states what the item puts on the
   page, which is checkable by opening it. Never write an engine mechanic into a deliverable:
   no primary source establishes one in either direction (ruling R3 amendment 9a).

   **Top 6 Priority Items**:
   | Rank | ID | Standard | Why this library ranks it here |
   |------|----|----------|---------------|
   | 1 | C02 | Direct Answer in first 150 words | The answer sits where a reader reaches it without scrolling |
   | 2 | C09 | Structured FAQ (visible Q&A) | Answers the follow-ups the query itself raises; the visible block is the deliverable, markup is conditional — see schema below |
   | 3 | O03 | Data in tables, not prose | Comparison values become addressable cells, not sentences to reassemble |
   | 4 | O05 | JSON-LD: one accurate primary type | States page type and entities unambiguously; extra types add nothing (R2) |
   | 5 | E01 | Original first-party data | Content that exists nowhere else — the one thing a competitor cannot also supply |
   | 6 | O02 | Key Takeaways / Summary Box | A self-contained précis, quotable without the surrounding article |

   **All GEO-First Items** (optimize for all when possible):
   C02, C04, C05, C07, C08, C09 | O02, O03, O04, O05, O06, O09
   R01, R02, R03, R04, R05, R07, R09 | E01, E02, E03, E04, E06, E08, E09, E10
   Exp10 | Ept05, Ept08 | A08

   **Per-engine item map** — what this library optimises for when that engine is the named target. The library's judgement; no engine publishes its selection rule, so never report a row as one:
   | Engine | Items this library prioritises |
   |--------|----------------|
   | Google AI Mode (default) | C02, O03, O05, C09 |
   | ChatGPT Browse | C02, R01, R02, E01 |
   | Perplexity AI | E01, R03, R05, Ept05 |
   | Claude | R04, Ept08, Exp10, R03 |

   **Engine Model (2026 baseline)**: Google AI Mode is Google's default search surface (AI Overviews folded in; live for Greek queries since 08-10-2025) — organic CTR baselines shift accordingly. ChatGPT, Perplexity, Gemini, Claude remain separate engines, each with its own selection behavior.

   **Per-Engine Reality Check** [VERIFY – 2026 industry studies]: ~11% ChatGPT↔Perplexity domain overlap; community/UGC content (Reddit-type) ≈40% of citations, cross-engine. Optimize and track citation presence **per engine**, not as one "AI traffic" bucket — community threads (Reddit, niche forums; Greece: insomnia.gr-type where topically relevant) are a first-class AIO/AI Mode quote surface (Google-announced quote-preview module, 2026-05-06; rollout scope [VERIFY] — see ai-citation-patterns.md); the overlap/share magnitudes stay directional. **A `[VERIFY]` tag does not travel, so the claim it sits on does not travel either**: a call this library carries tagged — here, or in a benchmark row you are leaning on for a type mapping — may guide what you do, and never reaches client copy in the indicative. State what the page is and what you did with it, or route the call; where the caveat cannot travel with the claim, the claim stays out. Same test as the engine-mechanic rule above, applied to this library's own open questions.

   **Not citation levers**: llms.txt (dead — do not add it); schema-stacking — piling types onto a page raises no citation odds, and one accurate JSON-LD type per O05 is enough (settled ruling R2). What that ruling does and does not ban:

   - **One PRIMARY content type per page** (O05), chosen by what the page is.
   - **Documented auxiliaries are not stacking**: BreadcrumbList where a real trail exists, Organization/Person nested as publisher or author, WebSite on the homepage. Each has its own engine-documented, non-citation job.
   - **A second full content type is stacking and stays banned** — FAQPage bolted onto a service or product page, Article and Product both as primaries — unless the page genuinely is both things and each type is complete, accurate and independently justified.
   - **FAQ precedence** (the collision this skill used to mandate both sides of): add the visible Q&A whenever the queries warrant it, always. Add FAQPage markup only where FAQPage is the page's one primary type — never bolted onto a page that already carries an accurate type, and never onto one whose accurate type is simply still missing. Both are the same refusal (the page's one primary type is something else), and they are **not the same sentence**: say which of the two this page is, from what the page actually carries. Writing "a page that already has one" about a page with no structured data on it is a false statement about the client's page, in a row whose job is to report that page's state. The bullet above is the only door out of that, and it is a narrow one: a page that genuinely *is* both things, with each type complete, accurate and independently justified. Carrying an FAQ section does not make a page an FAQ page, so on the ordinary page the door stays shut. C09 passes on the visible Q&A block; markup is not required for it (CORE-EEAT C09, Pass criterion). Where a page therefore gets the FAQ but no FAQPage object, say so in the report — the item is not downgraded for it.
   - **What this skill may emit** — the boundary three signals in this repo used to blur. It emits JSON-LD for the page's **one primary type only**, only once that type is settled and named in the report, and only to carry content it just wrote; the FAQPage skeleton in [geo-optimization-techniques.md](./references/geo-optimization-techniques.md) is that case and the only one shipped here. It never emits a second content type, never an auxiliary (BreadcrumbList, publisher/author, WebSite), and never a type it had to guess. Everything else — property completeness, validation, auxiliaries, cross-page consistency, and every uncertain or contested type call — belongs to [schema-markup-generator](../schema-markup-generator/), which carries the same boundary: hand it the page's facts, not a guess. Step 5's `[type emitted, or why none]` row takes exactly three answers: the type this skill emitted, the accurate type already on the page and left alone, or none — routed on, with the type the page needs and why. **A type that moves under the edit is a replacement, not an addition**: if the optimization genuinely changes what the page is, the old object goes out as the new one goes in and the page still carries one primary type (CORE-EEAT benchmark §5, "when the correct type changes because of the edit").

   _Full benchmark: [references/core-eeat-benchmark.md](../../references/core-eeat-benchmark.md)_
   _Per-engine working model (this library's, not engine-published): [references/ai-citation-patterns.md](./references/ai-citation-patterns.md)_
   ```

2. **Analyze Current Content**

   ```markdown
   ## GEO Analysis: [Content Title]
   
   ### Current State Assessment
   
   | GEO Factor | Score (1-10) | What was counted |
   |------------|--------------|------------------|
   | Clear definitions | [X] | [met] of [asked] key terms defined standalone |
   | Quotable statements | [X] | [met] of [asked] sections carry a liftable statement |
   | Factual density | [X] | [met] of 5 precise data points with units |
   | Source citations | [X] | [met] of [asked] claims carrying a checkable source — **before counts sourcing only**; the other three dispositions count in the after table |
   | Q&A format | [X] | [met] of [asked] target queries answered directly |
   | Authority signals | [X] | [met] of [asked] available authority elements |
   | Content freshness | [X] | [met] of [asked]: visible date <12 months · no stale time-sensitive figure |
   | Structure clarity | [X] | [met] of [asked] structure elements present |
   | **GEO Readiness** | **[avg]/10** | **[sum] points ÷ [n] factors scored; N/A: [factors with nothing to count, or none]** |
   
   **Primary Weaknesses**:
   1. [Weakness 1]
   2. [Weakness 2]
   3. [Weakness 3]
   
   **Quick Wins**:
   1. [Quick improvement 1]
   2. [Quick improvement 2]
   ```

   **Every score prints the count it came from, in its own row** — `score = 1 + 9 × (met ÷ asked)`, rounded half up, floor 1. Set each factor's `asked` here, once, and reuse it unchanged in step 4 so the two tables stay comparable. A factor with nothing to count (no comparison on the page, no expert the client can supply) is **N/A** — named, excluded from the sum and the divisor, never scored 1. Scale bands, the reverse check, N/A handling and the pre-send recompute pass: [references/geo-score-arithmetic.md](./references/geo-score-arithmetic.md). **Two of the eight are defined rather than obvious, and counting them by their name gets them wrong.** *Source citations* measures unsourced claims left standing, so a claim counts as met when it carries a checkable source **or** when it was removed, converted to first-party, or hedged — with that disposition named in the report. Obeying the rule that bans an unsourceable claim therefore raises the score instead of leaving it flat, and nobody gains by keeping a claim alive in search of a weak source; `asked` stays the step-2 claim inventory in both columns, so the denominator never shrinks. *Content freshness* scores its staleness half only where the page or the supplied data carries a **time-sensitive** figure — one that could read differently if re-measured today. A founding year is a fact fixed to its date, not stale data. So `asked` is 2, 1 or N/A, and a page with nothing that can go stale no longer collects a meaningless half-mark. **The staleness half is a negative check, and an empty set fails nothing**: in a column whose version never carried a time-sensitive figure there is nothing that could have gone stale, so that half is **met** in that column and the row prints why (a version left empty by *cutting* figures is read by the disposition rule instead — the naming guard still binds) — `0 of 1` under a note reading "the page carries nothing that can go stale" is that half's own N/A condition written out beside a 1, and it is not an attainable count. The "no figures yet" gap belongs to factual density, which counts it in both columns; charging it here as well counts one gap twice and inflates the lift. Both factors in full, with the scope table: [geo-score-arithmetic.md](./references/geo-score-arithmetic.md) §3.1–3.2.

3. **Apply GEO Optimization Techniques**

   > **GEO fundamentals** — this library's do-first order, stated as page properties, because no engine publishes its selection rule (ruling R3 amendment 9a): make the page authoritative (a named expert with checkable credentials, sources a reader can follow), accurate (every figure traceable and current), clear (one topic per section, no ambiguous referents), and quotable (answers that stand alone when lifted out of their paragraph). Each is checkable by opening the page — write the recommendation that way, never as an engine mechanic. See [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md) for detailed before/after examples, templates and checklists for each technique.

   Apply the six core optimization techniques: definition optimization, quotable statement creation, authority signal enhancement, structure optimization, factual density improvement, and FAQ implementation (visible Q&A always; markup only under the one-primary-type rule in step 1).

   > **Reading the reference examples**: the sources, figures and experts in them are fictional stand-ins by design — they teach the *shape* of a cited sentence, not facts. Never carry a name, number or quotation out of a reference file into client copy, and never attribute anything to a real organisation or a real person without a source you have read and can link.

   Key principles:
   - **Definitions**: 25-50 words, standalone, starting with the term
   - **Quotable statements**: Specific statistics with sources, verifiable facts
   - **Authority signals**: Expert quotes you can source (speaker, role, where and when they said it, link) — never one you cannot; proper source citations
   - **Structure**: Q&A format, comparison tables, numbered lists
   - **Factual density**: Replace vague claims with specific data points
   - **FAQ**: Visible Q&A whenever the queries warrant it; FAQPage markup only where FAQPage is the page's one primary type (settled ruling R2, step 1) — and then mirroring the visible text exactly. Anywhere else, the report names what the page carries: an accurate type already there, or none yet. Both refuse FAQPage; only one of them is true of any given page
   - **Claims the page already publishes**: an unsourced claim already on the page is not yours to keep by default — source it, convert it to a first-party statement the client can stand behind and say you did, or hedge/cut it. Never leave a borrowed authority ("most manufacturers recommend…") standing as if verified, and never invent the source. Where the page and the data the client just gave you disagree, the supplied data governs the deliverable and the conflict is named in the report. Detail: [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md)
   - **A supplied datum keeps the scope it arrived with**: a figure given for one service, one area, one product line or one sample is published for that scope and no wider. Repeating it down every row of a table, restating it as a page-wide promise, or turning a description of one figure into a claim about how the client's study was built commits the client to something they never told you — and the number being real is what makes the widening hard to see. Where the scope was not stated, publish the datum with the qualification the client actually gave, or ask before publishing. Naming the widening in the report does not license it: **the report does not travel with the copy the client publishes**, and the claim about their own business is what ships. Detail: [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md)

4. **Generate GEO-Optimized Output**

   ```markdown
   ## GEO Optimization Report

   ### Changes Made

   **Definitions Added/Improved**:
   1. [Definition 1] - [location in content]
   2. [Definition 2] - [location in content]

   **Quotable Statements Created**:
   1. "[Statement 1]"
   2. "[Statement 2]"

   **Authority Signals Added**:
   1. [Expert quote/citation]
   2. [Source attribution]

   **Structural Improvements**:
   1. [Change 1]
   2. [Change 2]

   ### Before/After GEO Score

   | GEO Factor | Before | After | Change | Count behind the after score |
   |------------|--------|-------|--------|------------------------------|
   | Clear definitions | [X] | [X] | +[X] | [met] of [asked] |
   | Quotable statements | [X] | [X] | +[X] | [met] of [asked] |
   | Factual density | [X] | [X] | +[X] | [met] of 5 |
   | Source citations | [X] | [X] | +[X] | [met] of [asked] — sourced, converted to first-party, hedged or cut; each disposition named |
   | Q&A format | [X] | [X] | +[X] | [met] of [asked] |
   | Authority signals | [X] | [X] | +[X] | [met] of [asked] |
   | Content freshness | [X] | [X] | +[X] | [met] of [asked] |
   | Structure clarity | [X] | [X] | +[X] | [met] of [asked] |
   | **GEO Readiness** | **[avg]/10** | **[avg]/10** | **+[X]** | **[sum] ÷ [n] factors scored** |

   **Lift**: ([after] − [before]) ÷ [before] × 100 = [X]%

   ### AI Query Coverage

   One row per target query from step 1 — the queries the user named, not a generic set:
   - "[target query]" ✅ answered by [heading]
   - "[target query]" ⚠️ [what is still missing]

   Patterns worth covering where the topic fits them: "What is [topic]?", "How does [topic] work?", "Why is [topic] important?", "[Topic] vs [alternative]", "Best [topic] for [use case]".
   ```

5. **CORE-EEAT GEO Self-Check**

    After optimization, verify GEO-First items:

    ```markdown
    ### GEO Post-Optimization Check

    | What was checked | Status | Notes |
    |------------------|--------|-------|
    | Core answer within the first 150 words | ✅/⚠️/❌ | [notes] |
    | Key terms defined on first use | ✅/⚠️/❌ | [notes] |
    | Structured FAQ covering follow-up questions | ✅/⚠️/❌ | [notes] |
    | Key-takeaways summary box | ✅/⚠️/❌ | [notes] |
    | Comparisons presented as tables | ✅/⚠️/❌ | [notes] |
    | Structured data: one accurate type for this page | ✅/⚠️/❌ | [type emitted, or why none] |
    | One topic per section, paragraphs of 3–5 sentences | ✅/⚠️/❌ | [notes] |
    | At least 5 precise data points with units | ✅/⚠️/❌ | [count reached, and what data would close the gap] |
    | At least one citation per 500 words | ✅/⚠️/❌ | [notes] |
    | Every claim backed by evidence | ✅/⚠️/❌ | [notes] |
    | Full names for people, companies and products | ✅/⚠️/❌ | [notes] |
    | First-party data used | ✅/⚠️/❌ | [notes] |
    | Limitations acknowledged | ✅/⚠️/❌ | [notes] |
    | Reasoning shown, not just conclusions | ✅/⚠️/❌ | [notes] |

    **Items Needing Attention**: [list every ⚠️/❌ row and what would close it]
    ```

    **Framework item IDs stay off the client's copy.** The rows above are the CORE-EEAT GEO-First items in plain language. An item ID (C02, C09, O05) is a coordinate in a document the client has never seen — never exempt on a client-read surface (`anti-slop-ruleset.md` §6 family 8, ruled on Greek evidence, enforced in every language). Keep the IDs where the reader is the operator: internal audit notes, and the handoff to [content-quality-auditor](../../cross-cutting/content-quality-auditor/), which needs them. The test is the reader, not the section — the ID list itself is in step 1. **And an operator block has to be severable.** Where the deliverable carries one — labelled inside the fence, in that fence's own syntax — no sentence the client reads may point at it: «βλ. σημείωμα ομάδας στο τέλος», "see the team note", "as noted in the handoff below". The block's own label says it is not delivered, so strip it and re-read what is left; every cross-reference in the client's sections must still resolve. Nothing escapes here — this is the inverse of an ID leak — but the client is handed a report that breaks when it is prepared as instructed. Whatever the client needs in order to act (that the structured-data code comes in a separate step, that a figure is still missing) is stated in the client's own sections, in the client's words, and repeated in the operator block if the operator needs it too.

## Validation Checkpoints

### Input Validation
- [ ] Content source identified (URL, full text, or content draft)
- [ ] Target AI queries or topics clearly defined
- [ ] Current GEO baseline assessed (if optimizing existing content)
- [ ] Publish/update date and data ages known — or confirmed unavailable, in which case freshness scores on its other half alone, and is N/A where neither half is in scope; never 1, and never `0 of 1` on the staleness half of a version that carries nothing capable of going stale
- [ ] Byline, credentials and expert availability known — or confirmed unavailable, which sets what the authority factor asks for
- [ ] Structured data already on the page identified (which type, or none)

### Output Validation
- [ ] At least 3 clear, quotable definitions added
- [ ] Factual density improved with at least 5 verifiable statistics
- [ ] All claims have source citations from authoritative sources
- [ ] Q&A format sections cover top 5 user queries
- [ ] GEO score improvement of at least 50% from baseline — "baseline" is the step 2 GEO Readiness figure, the single baseline in the deliverable — with its arithmetic printed beside it: (after − before) ÷ before × 100
- [ ] Every score carries the count behind it, in the same row or the next sentence ([references/geo-score-arithmetic.md](./references/geo-score-arithmetic.md)); scores stay in the report, never inside schema or paste-ready copy
- [ ] Source of each data point stated in the deliverable's own words — the resolved tool name (Otterly, Profound), "user-provided", or "estimated" **only where the client estimated the figure and told you so** (this skill never estimates a number on the client's behalf); where no tool was connected and nothing was supplied, that is stated plainly and the figure stays out. Never a `~~category` token on a surface the client reads (anti-slop-ruleset.md §6 family 7), and no placeholder or provenance note inside schema, meta tags, or paste-ready copy
- [ ] Every screen run over the finished deliverable (bracket tokens, `~~` tokens, a Greek regression net, a numeral census) is reported with its **exit status** as well as its output — a screen that exits non-zero has not run, and a screen that has not run is UNSCREENED, never clean ([references/geo-score-arithmetic.md](./references/geo-score-arithmetic.md) §9)

**When a threshold and the Statistics rule collide, the threshold loses.** The counts above describe what well-sourced content looks like; they are not quotas to fill. If the page and the supplied data yield three precise data points, ship three: mark the item ❌ with the count actually reached and name the data that would close it. Never a fourth number the skill invented to clear a checkbox — and that includes the 50% lift, which is a false report if any factor behind it was scored on invented content.

**Statistics rule**: Every statistic must come from user-supplied data, a cited source, or be marked as a `[CLIENT DATA: …]` placeholder — never invented to satisfy a threshold. **Attribution**: never put a statistic, a claim or a quotation in the name of a real organisation or a real person without a source you have read and can link. A fabricated quote from a named individual, or an invented credential at a named institution, is the most damaging output this skill can produce — it publishes a falsehood about an identifiable third party under the client's byline. A fabricated number that gets repeated anywhere — quoted back by a reader, lifted into a client's own deck, picked up by any consumer — is a liability that outlives the page. **Placement**: placeholders and provenance notes (bracketed or not — e.g. «απαιτούνται στοιχεία προϊόντος») belong in the report/gap-table sections only, never inside ship-ready surfaces: schema/JSON-LD, meta tags, or answer text presented as paste-ready. Write the customer-visible answer complete without the missing datum — honest hedging in customer voice is fine; an agency-perspective aside is not. Draft body copy may carry a bracketed placeholder only when the resolve-before-publication flag sits **inside the same block, in that block's own syntax** — `<!-- SKELETON … -->` for HTML, `"_SKELETON": "…"` as the first member for JSON-LD, `# SKELETON …` for text (root `CLAUDE.md`, the Value Rule). A model copies the fence, not the heading above it, so a note outside the block does not travel with it, and a block introduced as paste-ready is never a skeleton.

## Example

**User**: "Optimize this paragraph for GEO: 'Solar water heaters are very common in Greece. They save energy and need servicing now and then. A technician checks the parts and replaces what is worn.'

Client-provided data:
- Our 2025 service records (1,240 jobs): average service visit costs €85
- Manufacturer manual (2024): annual anode-rod replacement extends tank life by 3-5 years"

**Output**:

```markdown
## GEO-Optimized Version

**Solar water heater servicing** is the scheduled inspection of a solar 
thermal system's collector, tank, anode rod, and safety valve. Across the 
1,240 services we completed in 2025, the average visit cost €85.

### A standard annual service includes:

1. **Anode-rod check**: Annual replacement extends tank life by 3-5 years 
   (manufacturer manual, 2024)
2. **Collector and circuit inspection**: Glass condition, antifreeze 
   concentration, and loop pressure
3. **Safety valve test**: Confirms overpressure protection works correctly

> **Key statistic**: The average solar water heater service visit costs €85 
> (our 2025 service records, n=1,240).

---

### Changes Made

Standalone definition, numbered service list, two quotable facts. Both figures come from the client-provided data block; nothing else was added. The published copy above carries no bracket token — it reads complete without the datum it does not have.

**Claim dropped, not dressed up**: the original sentence "solar water heaters are very common in Greece" carries no source, so it stayed out rather than acquiring an invented percentage.

**Data still needed**: how common solar water heaters are in Greek homes. It is the one sentence that would place this service in a national context for an AI answer about Greek households. Send a sourced figure with its year — a national statistics or energy-agency publication, or your own installed-base count — and the sentence goes back in.

**Structured data**: no extra type was added. The page needs one accurate structured-data type for what it actually is; piling on more types buys no AI citations, and the answers above stand on their own as visible text that any reader or consumer reaches without markup.

**GEO Readiness**: 1.3/10 → 8.0/10 — 10 points ÷ 8 factors scored before, 64 ÷ 8 after; lift (8.0 − 1.3) ÷ 1.3 × 100 = 515%. The per-factor rows and the count behind each one ship in the step 4 table.
```

> Two things the deliverable above deliberately does not say: the name of a skill, and the ID of a ruling or a benchmark item. The schema decision is routed to [schema-markup-generator](../schema-markup-generator/) under ruling R2, and the checks come from CORE-EEAT — but that vocabulary is yours and the operator's, not the client's.

## Tips for Success

Each reason below states what the tip puts on the page, checkable by opening it — never what an engine does with it, which no primary source establishes in either direction (ruling R3 amendment 9a). A model reads this list as instruction, so an engine mechanic written here travels into client copy.

1. **Answer the question first** - Put the answer in the first sentence
2. **Be specific** - A vague sentence contains nothing that can be lifted out of it; a specific one does
3. **Cite sources** - A named, dated, linkable source is one the reader can check without taking your word for it
4. **Stay current** - Update statistics and facts regularly
5. **Match query format** - Questions deserve direct answers
6. **Build authority** - A named expert with checkable credentials is something a competitor cannot also claim

## Reference Materials

- [AI Citation Patterns](./references/ai-citation-patterns.md) - This library's observational working model of Google AI Mode (incl. AI Overviews), ChatGPT, Perplexity and Claude — citation styles visible in their published output, per-engine overlap and community/UGC patterns. Read its evidence-grade block first: none of it is engine-published, and none of it goes into a deliverable as an engine mechanic
- [GEO Optimization Techniques](./references/geo-optimization-techniques.md) - Detailed before/after examples, templates and checklists for the six core optimization techniques, plus the GEO Readiness Checklist (definitions, quotable content, authority, structure, technical)
- [Quotable Content Examples](./references/quotable-content-examples.md) - Before/after examples of content optimized for AI citation
- [GEO Score Arithmetic](./references/geo-score-arithmetic.md) - What every printed number is made of: the 1-10 scale as a ratio, what each factor counts, N/A handling, the lift, the pre-send recompute pass, and how to read a screen you ran over your own deliverable (a screen that exits non-zero has not run)

> The first three files illustrate technique with **fictional sources** (the reserved `Example …` cast) and invented figures. That is demonstration material, not evidence: swap in a source you have read before anything ships, and never attribute data or a quotation to a real organisation or a real person on the strength of an example here.

## Related Skills

- [seo-content-writer](../seo-content-writer/) — Create SEO content to optimize
- [schema-markup-generator](../schema-markup-generator/) — Add structured data
- [content-refresher](../../optimize/content-refresher/) — Update content for freshness
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit
- [serp-analysis](../../research/serp-analysis/) — Analyze AI Mode/AI Overview patterns

