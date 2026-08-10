# CORE-EEAT Item Reference

Quick reference for all 80 CORE-EEAT audit items. Full scoring criteria in [core-eeat-benchmark.md](../../../references/core-eeat-benchmark.md).

## Complete Item Reference

| ID | Item | ID | Item |
|----|------|----|------|
| C01 | Intent Alignment | Exp01 | First-Person Narrative |
| C02 | Direct Answer | Exp02 | Sensory Details |
| C03 | Query Coverage | Exp03 | Process Documentation |
| C04 | Definition First | Exp04 | Tangible Proof |
| C05 | Topic Scope | Exp05 | Usage Duration |
| C06 | Audience Targeting | Exp06 | Problems Encountered |
| C07 | Semantic Coherence | Exp07 | Before/After Comparison |
| C08 | Use Case Mapping | Exp08 | Quantified Metrics |
| C09 | FAQ Coverage | Exp09 | Repeated Testing |
| C10 | Semantic Closure | Exp10 | Limitations Acknowledged |
| O01 | Heading Hierarchy | Ept01 | Author Identity |
| O02 | Summary Box | Ept02 | Credentials Display |
| O03 | Data Tables | Ept03 | Professional Vocabulary |
| O04 | List Formatting | Ept04 | Technical Depth |
| O05 | Schema Markup | Ept05 | Methodology Rigor |
| O06 | Section Chunking | Ept06 | Edge Case Awareness |
| O07 | Visual Hierarchy | Ept07 | Historical Context |
| O08 | Anchor Navigation | Ept08 | Reasoning Transparency |
| O09 | Information Density | Ept09 | Cross-domain Integration |
| O10 | Multimedia Structure | Ept10 | Editorial Process |
| R01 | Data Precision | A01 | Backlink Profile |
| R02 | Citation Density | A02 | Media Mentions |
| R03 | Source Hierarchy | A03 | Industry Awards |
| R04 | Evidence-Claim Mapping | A04 | Publishing Record |
| R05 | Methodology Transparency | A05 | Brand Recognition |
| R06 | Timestamp & Versioning | A06 | Social Proof |
| R07 | Entity Precision | A07 | Knowledge Graph Presence |
| R08 | Internal Link Graph | A08 | Entity Consistency |
| R09 | HTML Semantics | A09 | Partnership Signals |
| R10 | Content Consistency | A10 | Community Standing |
| E01 | Original Data | T01 | Legal Compliance |
| E02 | Novel Framework | T02 | Contact Transparency |
| E03 | Primary Research | T03 | Security Standards |
| E04 | Contrarian View | T04 | Disclosure Statements |
| E05 | Proprietary Visuals | T05 | Editorial Policy |
| E06 | Gap Filling | T06 | Correction & Update Policy |
| E07 | Practical Tools | T07 | Ad Experience |
| E08 | Depth Advantage | T08 | Risk Disclaimers |
| E09 | Synthesis Value | T09 | Review Authenticity |
| E10 | Forward Insights | T10 | Customer Support |

**Note on site-level items**: Most Authority items (A01-A10) and several Trust items (T01-T03, T05, T07, T10) require site-level or organization-level data that may not be observable from a single page. When auditing a standalone page without site context, mark these as "N/A — requires site-level data" and exclude from the dimension average.

## Example Audit Report

**User**: "Audit this blog post against CORE-EEAT: [paste of 'Best Project Management Tools for Remote Teams 2025']"

**Output** (partial — showing one dimension to demonstrate format):

```markdown
## CORE-EEAT Audit Report

### Overview

- **Content**: "Best Project Management Tools for Remote Teams 2025"
- **Content Type**: Blog Post / Comparison
- **Audit Date**: 2025-06-15
- **Veto Status**: No triggers

### C -- Contextual Clarity (scored dimension example)

| ID  | Check Item         | Score   | Points | Notes                                                       |
|-----|--------------------|---------|--------|-------------------------------------------------------------|
| C01 | Intent Alignment   | Pass    | 10     | Matches "best X" comparison intent; title and body aligned  |
| C02 | Direct Answer      | Partial | 5      | Answer appears in first 300 words but no summary box — Confirmed |
| C03 | Query Coverage     | Pass    | 10     | Covers "project management tools", "remote team software", "best PM tools" |
| C04 | Definition First   | Pass    | 10     | Key terms ("PM tool", "async collaboration") defined on first use |
| C05 | Topic Scope        | Partial | 5      | States what's covered but not what's excluded — Confirmed   |
| C06 | Audience Targeting | Pass    | 10     | Explicitly targets "remote team leads and managers"         |
| C07 | Semantic Coherence | Pass    | 10     | Logical flow: intro > criteria > tools > comparison > verdict |
| C08 | Use Case Mapping   | Pass    | 10     | Decision matrix for team size, budget, and features         |
| C09 | FAQ Coverage       | Fail    | 0      | No FAQ section despite long-tail potential ("free PM tools for small teams") — Confirmed |
| C10 | Semantic Closure   | Partial | 5      | Conclusion present but doesn't loop back to opening promise — Confirmed |

**C Dimension Score**: 75/100 (Good)
**Blog Post weight for C**: 25%
**Weighted contribution**: 18.75

#### Priority Improvements from C Dimension

1. **C09 FAQ Coverage** -- Confirmed
   - **Finding**: No FAQ section despite clear long-tail potential
   - **Evidence**: no FAQ/Q&A block anywhere on the page; uncovered long-tail queries such as "free PM tools for small remote teams"
   - **Impact**: Fail (0) -> potential gain of 2.5 weighted points
   - **Fix**: Add FAQ with "Are there free PM tools for small remote teams?", "How to migrate between PM tools?", etc.

2. **C02 Direct Answer** -- Confirmed
   - **Finding**: Core answer not delivered in the first 150 words
   - **Evidence**: answer first appears in the first 300 words; no summary box above the fold
   - **Impact**: Partial (5) -> potential gain of 1.25 weighted points
   - **Fix**: Insert a "Top 3 Picks" callout box in the first 150 words

[... remaining 7 dimensions (O, R, E, Exp, Ept, A, T) follow the same per-item format ...]
[... anti-slop scan hits (AS-1 to AS-4) are recorded in the notes of the items they evidence: O09, O06, C02, E06, E08, R01, R02, R04, Ept03 ...]
[... then: Dimension Scores table, Top 5 Priority Improvements (Finding / Evidence / Impact / Fix + confidence label), Action Plan ...]

The follow-up runs are not part of that report — they go in a separate operator block whose
label sits inside its own fence (SKILL.md, after the report template).
```
