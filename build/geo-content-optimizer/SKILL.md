---
name: geo-content-optimizer
version: "4.6.0"
description: 'Optimize content for AI citation across Google AI Mode (default search surface, incl. AI Overviews), ChatGPT, Perplexity, and Gemini with quotable statements and structured Q&A. Use when the user asks to "optimize for AI", "get cited by ChatGPT", "GEO optimization", "appear in AI answers", "make content AI-quotable", "Google AI Overview optimization", or "Google AI Mode optimization". Adds quotable statements, structured Q&A, precise statistics with sources, expert attribution, and a structured FAQ. Uses CORE-EEAT GEO-First items as optimization targets. For SEO-focused writing, see seo-content-writer. For entity and brand AI presence, see entity-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.6.0"
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

**Optimize existing content:**

```
Optimize this content for GEO/AI citations: [content or URL]
Make this article more likely to be cited by AI systems
```

**Create GEO-optimized content, or audit a page for GEO readiness:**

```
Write content about [topic] optimized for both SEO and GEO
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

   **Engine precedence, and the per-engine item map** — the order engines are worked in when effort is limited, when two recommendations conflict, and when the report has to lead with one ([AI Visibility Measurement](../../references/ai-visibility-measurement.md) §2). **Rank 4 is a different instrument, not a lower priority**: organic sits fourth in *prompt-level* work because prompts are not how it is measured, and the ranking, crawl, index and authority work it needs is the substrate the three above it draw on — say that wherever the order is shown to a client. The order is this client's working priority and is revisable on evidence, never a claim about the engines; the item column is this library's judgement, and no engine publishes its selection rule, so never report a row as one. Precedence in full, the conflict rule, and where it lands in each step: [references/ai-visibility-targets.md](./references/ai-visibility-targets.md) §1.
   | # | Engine | Standing | Items this library prioritises |
   |---|--------|----------|----------------|
   | 1 | ChatGPT Search (and Browse) | Primary | C02, R01, R02, E01 |
   | 2 | Gemini and Google AI surfaces (AI Mode, AI Overviews) | Primary | C02, O03, O05, C09 |
   | 3 | Perplexity | Primary | E01, R03, R05, Ept05 |
   | 4 | Google organic search | Foundation | Measured as ranking, not as prompt response — the technical and authority substrate, not deprioritised by this table |
   | 5 | Other assistants (Claude, Copilot, and what follows) | Monitored channel | R04, Ept08, Exp10, R03 |

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
   - **Three targets, not one — "get cited" is one job of three**: being *mentioned* (the answer names the brand), being *cited* (a client URL appears in the answer's sources) and being *recommended* (the brand sits inside an ordered set of options) are three separate facts with three different fixes, and the techniques below do not serve them equally. Quotable statements, definitions, factual density, followable sources and structure make the owning URL **liftable and sourceable** — the citation job. Full entity names, a named author with checkable credentials and first-party data are the **mention** job. Comparison tables, "X vs alternative" and "best X for use case" coverage, and acknowledged limitations are the **recommendation** job. Name which of the three each change serves: a page can win one and not the others, and a report that concludes "AI visibility: present" has thrown the diagnosis away. Mapping, the split-result reads and where each routes: [references/ai-visibility-targets.md](./references/ai-visibility-targets.md) §2 · fields: [AI Visibility Measurement](../../references/ai-visibility-measurement.md) §3
   - **Definitions**: 25-50 words, standalone, starting with the term — and **where the page's target query is definitional ("what is X", «τι είναι X»), that definition is the first body sentence**, not merely somewhere inside the first 150 words. The 150 words are C02's *ceiling*, not the target: a definition at word 118, under its own H2, has a hundred-odd words of something else in front of it, and what a reader meets at the top of the page — and what any extractive consumer lifts from it — is that other thing. This is checkable by opening the page, which is the only kind of reason this skill gives. Rewriting the page's existing opener (a category frame, a welcome line) does not discharge it: a frame sentence with figures poured into it is still a frame sentence, and the definition has to displace it rather than follow it
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
   **Denominators this run chose**: Clear definitions [met]→[met] of [asked] · Quotable statements [met]→[met] of [asked] — these two `asked` values are set by this run from the plan (`max(inbound, planned)`), so they are printed beside the lift they influence

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
    | Core answer within the first 150 words — and, on a definitional target query, in the first body sentence | ✅/⚠️/❌ | [word position of the answer; what the page opens with instead, if not the answer] |
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

    **Items Needing Attention** — one row per ⚠️/❌ above, ordered by expected impact ÷ effort:

    | Action | Owner | Done when | Expected impact | Effort | Depends on | Risk if done wrong |
    |--------|-------|-----------|-----------------|--------|------------|--------------------|
    | [one imperative sentence naming the element and the change] | [role] | [observable, binary, attached to a named artefact or measurement, dated or triggered] | [what it puts on the page, as a labelled working model — never a citation, position or inclusion] | [S / M / L, or `not estimated`] | [named blocker, or `none`] | [failure mode, or `low — reversible, no downstream effect`] |

    <!-- Owner and Done when are required; a row missing either is a suggestion, not an action.
         No criterion may require an engine to do something — "the brand appears in the answer"
         is nobody's to deliver and turns the row into a promise (no-promise rule below). An
         AI-surface row is accepted on the work shipped plus the mention or citation rate
         re-measured on the same N >= 3 repeat protocol and recorded beside its dated baseline.
         This table is client-read: no framework item ID, no skill slug, and no unresolved
         tool-category placeholder — name the tool, name the plain-language source, or say no
         tool was connected and leave the figure out. -->
    ```

    **Every item needing attention leaves as an implementable action, not a note.** The check above diagnoses; the table beside it is what gets done, and each row carries seven fields — **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**. The first three are required: a ⚠️ row restated as "add more data points" has no owner-role and nothing checkable, so nobody can be held to it and it does not ship as an action. The other four take a stated-absence value — `not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect` — never a blank and never an invention, which matters most here because this skill's honest answer to "what will this gain?" is usually that no baseline exists yet. **Owner is a role** from a closed list (Content · SEO/technical · Developer · Designer · Product/merchandising · Customer service · Legal/compliance · Agency · Client decision), never a person unless the client supplied the name; `Client decision` is the right owner where the blocker is the client's — supplying first-party data, naming an expert, approving a byline — and `unassigned — needs an owner` is legitimate and is itself a finding. This skill's Quick Wins and Primary Weaknesses in step 2 become rows in this same table; they are not a second, looser action format.

    **The acceptance-criterion test: could someone who was not part of this engagement check it six weeks from now, without asking anybody what was meant?** Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered — "the definition is the first body sentence on the production URL and runs 25-50 words starting with the term" rather than "improve the definition". A GEO score, a factor score and this deliverable's own lift are none of them criteria: they say how the page was graded, not what state proves the work shipped. **And no criterion may require an engine to do something** — a citation, an inclusion, a recommendation position or a share of any AI answer is nobody's to deliver, and writing one into a criterion is the no-promise rule broken in the one place it is easiest to miss, because a criterion reads like a plan rather than a claim. An AI-surface action is accepted on the work shipped **plus** the mention or citation rate re-measured on the same N ≥ 3 repeat protocol and recorded beside its dated baseline with its prompt-set version. Expected impact takes one of three shapes only — this page's own measured before/after, a mechanism labelled a working model, or comparable evidence with its limits — and never a forecast. Field table, stated-absence values, worked criteria and the role list: [Action Output Contract](../../references/action-output-contract.md).

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
- [ ] No promise of a citation, an inclusion, a recommendation position or a share of any AI answer, on any timeline — the deliverable states the mechanism as a declared working model, a leading indicator with its measurement plan, and the dated baseline with its N ([AI Visibility Measurement](../../references/ai-visibility-measurement.md) §7); the step 4 lift is this deliverable's own before/after, never a forecast
- [ ] Each change names which of the three jobs it serves — mentioned, cited, or recommended — since a page can win one and not the others ([references/ai-visibility-targets.md](./references/ai-visibility-targets.md) §2)
- [ ] Where the run names a target engine, the step 1 precedence order decided which one led, any conflict it resolved is named as a trade-off rather than dropped, and anything said about Google organic says it is a different instrument, not a lower priority
- [ ] Every screen run over the finished deliverable (bracket tokens, `~~` tokens, a Greek regression net, a numeral census) is reported with its **exit status** as well as its output — a screen that exits non-zero has not run, and a screen that has not run is UNSCREENED, never clean ([references/geo-score-arithmetic.md](./references/geo-score-arithmetic.md) §9)
- [ ] Every item needing attention leaves as an action carrying all seven fields — action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong — with a stated-absence value wherever an answer does not exist (`not estimated — no baseline data`, `none`, `low — reversible, no downstream effect`); no action ships without an owner-role and an acceptance criterion, the owner is a role from the closed list (`Client decision` where the blocker is the client's — first-party data, a named expert, a byline — and `unassigned — needs an owner` where there is genuinely nowhere for it to go, the second being itself a finding), and step 2's Quick Wins and Primary Weaknesses use this same format rather than a looser one
- [ ] Every acceptance criterion is observable, binary at the moment of checking, attached to a named artefact or measurement, and dated or triggered — a GEO score, a factor score and this deliverable's own lift are none of them criteria. **None requires an engine to do something**: an AI-surface action is accepted on the work shipped plus the mention or citation rate re-measured on the same N ≥ 3 repeat protocol and recorded beside its dated baseline, never on a citation, an inclusion or a recommendation position, which would break the no-promise rule in the one place it reads like a plan instead of a claim

**When a threshold and the Statistics rule collide, the threshold loses.** The counts above describe what well-sourced content looks like; they are not quotas to fill. If the page and the supplied data yield three precise data points, ship three: mark the item ❌ with the count actually reached and name the data that would close it. Never a fourth number the skill invented to clear a checkbox — and that includes the 50% lift, which is a false report if any factor behind it was scored on invented content.

**No-promise rule.** A GEO deliverable never promises a citation, an inclusion, a recommendation position, or a share of any AI answer, on any timeline: no engine publishes its citation criteria, none guarantees determinism, and the same prompt answers differently twice in one minute. Three things are stated instead, and all three are defensible — **the mechanism as a declared working model** ("an explicit room-size answer in the opening paragraph gives an assistant a directly liftable sentence; that is our working model, not documented engine behaviour"), **a leading indicator with its measurement plan** ("mention rate, re-measured across 3 repeats on 40 prompts, monthly"), and **the dated baseline with its N** ("8 of 36 captures, 17 August"). This is the client-facing twin of the engine-mechanic ban and is not covered by it: ruling R3 amendment 9a bans asserting what an engine *does*, this bans promising what an engine *will do for this client*, and a deliverable can break either alone. Carriers: [prohibited-tactics.md](../../references/prohibited-tactics.md) entry 9 · [AI Visibility Measurement](../../references/ai-visibility-measurement.md) §7 · substitutions worked in EN and EL, and why this skill's own GEO score is not a forecast, [references/ai-visibility-targets.md](./references/ai-visibility-targets.md) §3.

**Statistics rule**: Every statistic must come from user-supplied data, a cited source, or be marked as a `[CLIENT DATA: …]` placeholder — never invented to satisfy a threshold. **Attribution**: never put a statistic, a claim or a quotation in the name of a real organisation or a real person without a source you have read and can link. A fabricated quote from a named individual, or an invented credential at a named institution, is the most damaging output this skill can produce — it publishes a falsehood about an identifiable third party under the client's byline. A fabricated number that gets repeated anywhere — quoted back by a reader, lifted into a client's own deck, picked up by any consumer — is a liability that outlives the page. **Placement**: placeholders and provenance notes (bracketed or not — e.g. «απαιτούνται στοιχεία προϊόντος») belong in the report/gap-table sections only, never inside ship-ready surfaces: schema/JSON-LD, meta tags, or answer text presented as paste-ready. Write the customer-visible answer complete without the missing datum — honest hedging in customer voice is fine; an agency-perspective aside is not. Draft body copy may carry a bracketed placeholder only when the resolve-before-publication flag sits **inside the same block, in that block's own syntax** — `<!-- SKELETON … -->` for HTML, `"_SKELETON": "…"` as the first member for JSON-LD, `# SKELETON …` for text (root `CLAUDE.md`, the Value Rule). A model copies the fence, not the heading above it, so a note outside the block does not travel with it, and a block introduced as paste-ready is never a skeleton.

## Example

> **Reference**: See [references/quotable-content-examples.md](./references/quotable-content-examples.md) § Worked Example for a full run end to end — a Greek solar-water-heater paragraph rewritten from a client-provided data block, with the claim that had no source dropped rather than dressed up, the missing datum named as a request, the structured-data decision left to its own step, and the GEO Readiness lift printed with the arithmetic behind it.

## Tips for Success

> **Reference**: The six working rules — answer first, be specific, cite sources, stay current, match query format, build authority — are in [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md) § Tips for Success, each stated as what it puts on the page rather than what an engine does with it. Read them there before writing a tip of your own: a model reads a tip list as instruction, so an engine mechanic written into one travels straight into client copy (ruling R3 amendment 9a).

## Reference Materials

- [AI Citation Patterns](./references/ai-citation-patterns.md) - This library's observational working model of Google AI Mode (incl. AI Overviews), ChatGPT, Perplexity and Claude — citation styles visible in their published output, per-engine overlap and community/UGC patterns. Read its evidence-grade block first: none of it is engine-published, and none of it goes into a deliverable as an engine mechanic
- [GEO Optimization Techniques](./references/geo-optimization-techniques.md) - Detailed before/after examples, templates and checklists for the six core optimization techniques, plus the GEO Readiness Checklist (definitions, quotable content, authority, structure, technical)
- [Quotable Content Examples](./references/quotable-content-examples.md) - Before/after examples of content optimized for AI citation, and § Worked Example — the one section in it built from a client-provided data block rather than the fictional cast
- [AI Visibility Targets](./references/ai-visibility-targets.md) - Engine precedence and what it governs (with rank 4 written out); mentioned / cited / recommended as three jobs with three different fixes, mapped onto this skill's own techniques; and what a deliverable states instead of a promise
- [Action Output Contract](../../references/action-output-contract.md) - library-wide: the seven fields every item-needing-attention row carries, their stated-absence values, the closed owner-role list, worked acceptance criteria (and why an AI-surface criterion is a measurement criterion, not an outcome one), the three permitted shapes of expected impact, and the ordering rule
- [GEO Score Arithmetic](./references/geo-score-arithmetic.md) - What every printed number is made of: the 1-10 scale as a ratio, what each factor counts, N/A handling, the lift, the pre-send recompute pass, and how to read a screen you ran over your own deliverable (a screen that exits non-zero has not run)

> The first three files illustrate technique with **fictional sources** (the reserved `Example …` cast) and invented figures — the one exception being § Worked Example at the end of the quotable-content file, whose figures come from a client-provided data block and are labelled as such where they sit. That is demonstration material, not evidence: swap in a source you have read before anything ships, and never attribute data or a quotation to a real organisation or a real person on the strength of an example here.

## Related Skills

- [seo-content-writer](../seo-content-writer/) — Create SEO content to optimize
- [schema-markup-generator](../schema-markup-generator/) — Add structured data
- [content-refresher](../../optimize/content-refresher/) — Update content for freshness
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit
- [serp-analysis](../../research/serp-analysis/) — Analyze AI Mode/AI Overview patterns

