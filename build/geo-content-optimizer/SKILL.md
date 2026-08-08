---
name: geo-content-optimizer
version: "4.1.3"
description: 'Optimize content for AI citation across Google AI Mode (default search surface, incl. AI Overviews), ChatGPT, Perplexity, and Gemini with quotable statements and structured Q&A. Use when the user asks to "optimize for AI", "get cited by ChatGPT", "GEO optimization", "appear in AI answers", "make content AI-quotable", "Google AI Overview optimization", or "Google AI Mode optimization". Adds quotable statements, structured Q&A, precise statistics with sources, expert attribution, and FAQ schema. Uses CORE-EEAT GEO-First items as optimization targets. For SEO-focused writing, see seo-content-writer. For entity and brand AI presence, see entity-optimizer.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.1.3"
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
- Adding authority signals that AI systems trust
- Structuring content for AI comprehension
- Competing for visibility in the AI-first search era

## What This Skill Does

1. **Citation Optimization**: Makes content more likely to be quoted by AI
2. **Structure Enhancement**: Formats content for AI comprehension
3. **Authority Building**: Adds signals that AI systems trust
4. **Factual Enhancement**: Improves accuracy and verifiability
5. **Quote Creation**: Creates memorable, citeable statements
6. **Source Attribution**: Adds proper citations that AI can verify
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

Proceed with the full workflow using provided data. Note in the output which metrics are from automated collection vs. user-provided data.

## Instructions

When a user requests GEO optimization:

1. **Load CORE-EEAT GEO-First Optimization Targets**

   Before optimizing, load GEO-critical items from the [CORE-EEAT Benchmark](../../references/core-eeat-benchmark.md):

   ```markdown
   ### CORE-EEAT GEO-First Targets

   These items have the highest impact on AI engine citation. Use as optimization checklist:

   **Top 6 Priority Items**:
   | Rank | ID | Standard | Why It Matters |
   |------|----|----------|---------------|
   | 1 | C02 | Direct Answer in first 150 words | All engines extract from first paragraph |
   | 2 | C09 | Structured FAQ with Schema | Directly matches AI follow-up queries |
   | 3 | O03 | Data in tables, not prose | Most extractable structured format |
   | 4 | O05 | JSON-LD Schema Markup | Helps AI understand content type |
   | 5 | E01 | Original first-party data | AI prefers exclusive, verifiable sources |
   | 6 | O02 | Key Takeaways / Summary Box | First choice for AI summary citations |

   **All GEO-First Items** (optimize for all when possible):
   C02, C04, C05, C07, C08, C09 | O02, O03, O04, O05, O06, O09
   R01, R02, R03, R04, R05, R07, R09 | E01, E02, E03, E04, E06, E08, E09, E10
   Exp10 | Ept05, Ept08 | A08

   **AI Engine Preferences**:
   | Engine | Priority Items |
   |--------|----------------|
   | Google AI Mode (default) | C02, O03, O05, C09 |
   | ChatGPT Browse | C02, R01, R02, E01 |
   | Perplexity AI | E01, R03, R05, Ept05 |
   | Claude | R04, Ept08, Exp10, R03 |

   **Engine Model (2026 baseline)**: Google AI Mode is Google's default search surface (AI Overviews folded in; live for Greek queries since 08-10-2025) — organic CTR baselines shift accordingly. ChatGPT, Perplexity, Gemini, Claude remain separate engines, each with its own selection behavior.

   **Per-Engine Reality Check** [VERIFY – 2026 industry studies]: ~11% ChatGPT↔Perplexity domain overlap; community/UGC content (Reddit-type) ≈40% of citations, cross-engine. Optimize and track citation presence **per engine**, not as one "AI traffic" bucket — community threads (Reddit, niche forums; Greece: insomnia.gr-type where topically relevant) are a citation channel too, directional only.

   **Not citation levers**: llms.txt (dead — do not add it); schema-stacking (not a signal — one accurate JSON-LD type per O05 is enough).

   _Full benchmark: [references/core-eeat-benchmark.md](../../references/core-eeat-benchmark.md)_
   _Engine behavior detail: [references/ai-citation-patterns.md](./references/ai-citation-patterns.md)_
   ```

2. **Analyze Current Content**

   ```markdown
   ## GEO Analysis: [Content Title]
   
   ### Current State Assessment
   
   | GEO Factor | Current Score (1-10) | Notes |
   |------------|---------------------|-------|
   | Clear definitions | [X] | [notes] |
   | Quotable statements | [X] | [notes] |
   | Factual density | [X] | [notes] |
   | Source citations | [X] | [notes] |
   | Q&A format | [X] | [notes] |
   | Authority signals | [X] | [notes] |
   | Content freshness | [X] | [notes] |
   | Structure clarity | [X] | [notes] |
   | **GEO Readiness** | **[avg]/10** | **Average across factors** |
   
   **Primary Weaknesses**:
   1. [Weakness 1]
   2. [Weakness 2]
   3. [Weakness 3]
   
   **Quick Wins**:
   1. [Quick improvement 1]
   2. [Quick improvement 2]
   ```

3. **Apply GEO Optimization Techniques**

   > **GEO fundamentals**: AI systems prioritize content that is authoritative (expert credentials, proper citations), accurate (verifiable, up-to-date), clear (well-structured, unambiguous), and quotable (standalone answers, specific data). See [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md) for details.

   Apply the six core optimization techniques: definition optimization, quotable statement creation, authority signal enhancement, structure optimization, factual density improvement, and FAQ schema implementation.

   > **Reference**: See [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md) for detailed before/after examples, templates, and checklists for each technique.

   Key principles:
   - **Definitions**: 25-50 words, standalone, starting with the term
   - **Quotable statements**: Specific statistics with sources, verifiable facts
   - **Authority signals**: Expert quotes with credentials, proper source citations
   - **Structure**: Q&A format, comparison tables, numbered lists
   - **Factual density**: Replace vague claims with specific data points
   - **FAQ schema**: JSON-LD FAQPage markup matching visible content

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

   | GEO Factor | Before (1-10) | After (1-10) | Change |
   |------------|---------------|--------------|--------|
   | Clear definitions | [X] | [X] | +[X] |
   | Quotable statements | [X] | [X] | +[X] |
   | Factual density | [X] | [X] | +[X] |
   | Source citations | [X] | [X] | +[X] |
   | Q&A format | [X] | [X] | +[X] |
   | Authority signals | [X] | [X] | +[X] |
   | **Overall GEO Score** | **[avg]/10** | **[avg]/10** | **+[X]** |

   ### AI Query Coverage

   This content is now optimized to answer:
   - "What is [topic]?" ✅
   - "How does [topic] work?" ✅
   - "Why is [topic] important?" ✅
   - "[Topic] vs [alternative]" ✅
   - "Best [topic] for [use case]" ✅
   ```

5. **CORE-EEAT GEO Self-Check**

    After optimization, verify GEO-First items:

    ```markdown
    ### CORE-EEAT GEO Post-Optimization Check

    | ID | Standard | Status | Notes |
    |----|----------|--------|-------|
    | C02 | Direct Answer in first 150 words | ✅/⚠️/❌ | [notes] |
    | C04 | Key terms defined on first use | ✅/⚠️/❌ | [notes] |
    | C09 | Structured FAQ with Schema | ✅/⚠️/❌ | [notes] |
    | O02 | Summary Box / Key Takeaways | ✅/⚠️/❌ | [notes] |
    | O03 | Comparisons in tables | ✅/⚠️/❌ | [notes] |
    | O05 | JSON-LD Schema Markup | ✅/⚠️/❌ | [notes] |
    | O06 | Section chunking (3–5 sentences) | ✅/⚠️/❌ | [notes] |
    | R01 | ≥5 precise data points with units | ✅/⚠️/❌ | [notes] |
    | R02 | ≥1 citation per 500 words | ✅/⚠️/❌ | [notes] |
    | R04 | Claims backed by evidence | ✅/⚠️/❌ | [notes] |
    | R07 | Full entity names | ✅/⚠️/❌ | [notes] |
    | E01 | Original first-party data | ✅/⚠️/❌ | [notes] |
    | Exp10 | Limitations acknowledged | ✅/⚠️/❌ | [notes] |
    | Ept08 | Reasoning transparency | ✅/⚠️/❌ | [notes] |

    **Items Needing Attention**: [list any ⚠️/❌ items]

    _For full 80-item audit, use [content-quality-auditor](../../cross-cutting/content-quality-auditor/)_
    ```

## Validation Checkpoints

### Input Validation
- [ ] Content source identified (URL, full text, or content draft)
- [ ] Target AI queries or topics clearly defined
- [ ] Current GEO baseline assessed (if optimizing existing content)

### Output Validation
- [ ] At least 3 clear, quotable definitions added
- [ ] Factual density improved with at least 5 verifiable statistics
- [ ] All claims have source citations from authoritative sources
- [ ] Q&A format sections cover top 5 user queries
- [ ] GEO score improvement of at least 50% from baseline
- [ ] Source of each data point clearly stated (~~AI monitor data, user-provided, or estimated)

**Statistics rule**: Every statistic must come from user-supplied data, a cited source, or be marked as a `[CLIENT DATA: …]` placeholder — never invented to satisfy a threshold. AI engines cite verifiable content; a fabricated number that gets cited is a liability.

## Example

**User**: "Optimize this paragraph for GEO: 'Solar water heaters are very common in Greece. They save energy and need servicing now and then. A technician checks the parts and replaces what is worn.'

Client-provided data:
- Our 2025 service records (1,240 jobs): average service visit costs €85
- Manufacturer manual (2024): annual anode-rod replacement extends tank life by 3-5 years"

**Output**:

```markdown
## GEO-Optimized Version

**Solar water heater servicing** is the scheduled inspection of a solar 
thermal system's collector, tank, anode rod, and safety valve. In Greece — 
where solar water heaters are installed in [CLIENT DATA: share of Greek 
households — no source provided] of homes — the average service visit costs 
€85 (client 2025 service records, 1,240 jobs).

### A standard annual service includes:

1. **Anode-rod check**: Annual replacement extends tank life by 3-5 years 
   (manufacturer manual, 2024)
2. **Collector and circuit inspection**: Glass condition, antifreeze 
   concentration, and loop pressure
3. **Safety valve test**: Confirms overpressure protection works correctly

> **Key statistic**: The average solar water heater service visit in Greece 
> costs €85 (client 2025 service records, n=1,240).

---

### Changes Made:

Changes: added clear definition, 2 stats used only from the client-provided data block, 1 explicit `[CLIENT DATA]` placeholder where no figure was supplied (no number invented), structured list, 2 quotable facts. **GEO Score**: 1/10 → 7/10 (8/10 once the placeholder is filled with a sourced figure).
```

## GEO Optimization Checklist

> **Reference**: See the GEO Readiness Checklist in [references/geo-optimization-techniques.md](./references/geo-optimization-techniques.md) for the full checklist covering definitions, quotable content, authority, structure, and technical elements.

## Tips for Success

1. **Answer the question first** - Put the answer in the first sentence
2. **Be specific** - Vague content doesn't get cited
3. **Cite sources** - AI systems trust verifiable information
4. **Stay current** - Update statistics and facts regularly
5. **Match query format** - Questions deserve direct answers
6. **Build authority** - Expert credentials increase citation likelihood

## Reference Materials

- [AI Citation Patterns](./references/ai-citation-patterns.md) - How Google AI Mode (incl. AI Overviews), ChatGPT, Perplexity, and Claude select and cite sources, plus per-engine overlap and community/UGC citation patterns
- [GEO Optimization Techniques](./references/geo-optimization-techniques.md) - Detailed before/after examples, templates, and checklists for the six core optimization techniques
- [Quotable Content Examples](./references/quotable-content-examples.md) - Before/after examples of content optimized for AI citation

## Related Skills

- [seo-content-writer](../seo-content-writer/) — Create SEO content to optimize
- [schema-markup-generator](../schema-markup-generator/) — Add structured data
- [content-refresher](../../optimize/content-refresher/) — Update content for freshness
- [content-quality-auditor](../../cross-cutting/content-quality-auditor/) — Full 80-item CORE-EEAT audit
- [serp-analysis](../../research/serp-analysis/) — Analyze AI Mode/AI Overview patterns

