---
name: memory-management
description: 'Persist SEO/GEO project context, brand guidelines, and target keywords across sessions so your agent remembers strategy without re-explaining. Use when the user asks to "remember project context", "save SEO data", "track campaign progress", "store keyword data", "manage project memory", "remember this for next time", "save my keyword data", "keep track of this campaign". Manages a two-layer memory system (hot cache + cold storage) with intelligent promotion/demotion.'
license: Apache-2.0
compatibility: "Claude Code ≥1.0, skills.sh marketplace, ClawHub marketplace, Vercel Labs skills ecosystem. No system packages required. Optional: MCP network access for SEO tool integrations."
homepage: "https://github.com/aaron-he-zhu/seo-geo-claude-skills"
metadata:
  author: aaron-he-zhu
  version: "4.3.0"
  geo-relevance: "low"
  tags:
    - seo
    - geo
    - project memory
    - context management
    - campaign tracking
    - data persistence
    - keyword tracking
    - project context
    - context-memory
    - project-memory
    - seo-tracking
    - campaign-tracking
    - session-context
    - hot-cache
    - project-continuity
  triggers:
    - "remember project context"
    - "save SEO data"
    - "track campaign progress"
    - "store keyword data"
    - "manage project memory"
    - "save progress"
    - "project context"
    - "remember this for next time"
    - "save my keyword data"
    - "keep track of this campaign"
---

# Memory Management


This skill implements a two-layer memory system for SEO and GEO projects, maintaining a hot cache for active context and cold storage for detailed historical data. It automatically promotes frequently referenced items and demotes stale data, ensuring optimal context loading and efficient project memory.

## When to Use This Skill

- Setting up memory structure for a new SEO project
- After completing audits, ranking checks, or performance reports
- When starting a new campaign or optimization initiative
- When project context needs updating (new keywords, competitors, priorities)
- When you need to look up historical data or project-specific terminology
- After 30+ days of work to clean up and archive stale data
- When context retrieval feels slow or cluttered

## What This Skill Does

1. **Hot Cache Management**: Maintains CLAUDE.md (~100 lines) with active context that's always loaded
2. **Cold Storage Organization**: Structures detailed archives in memory/ subdirectories
3. **Context Lookup**: Implements efficient lookup flow from hot cache to cold storage
4. **Promotion/Demotion**: Moves items between layers based on reference frequency
5. **Glossary Maintenance**: Manages project-specific terminology and shorthand
6. **Update Triggers**: Refreshes memory after audits, reports, or ranking checks
7. **Archive Management**: Time-stamps and archives old data systematically

## How to Use

### Initialize Memory Structure

```
Set up SEO memory for [project name]
```

```
Initialize memory structure for a new [industry] website optimization project
```

### Update After Analysis

```
Update memory after ranking check for [keyword group]
```

```
Refresh hot cache with latest competitor analysis findings
```

### Query Stored Context

```
What are our hero keywords?
```

```
Show me the last ranking update date for [keyword category]
```

```
Look up our primary competitors and their domain authority
```

### Promotion and Demotion

```
Promote [keyword] to hot cache
```

```
Archive stale data that hasn't been referenced in 30+ days
```

### Glossary Management

```
Add [term] to project glossary: [definition]
```

```
What does [internal jargon] mean in this project?
```

## Data Sources

> See [CONNECTORS.md](../../CONNECTORS.md) for tool category placeholders.

**With ~~SEO tool + ~~analytics + ~~search console connected:**
Automatically populate memory from historical data: keyword rankings over time, competitor domain authority changes, traffic metrics, conversion data, backlink profile evolution. The skill will fetch current rankings, alert on significant changes, and update both hot cache and cold storage.

**With manual data only:**
Ask the user to provide:
1. Current target keywords with priority levels
2. Primary competitors (3-5 domains)
3. Key performance metrics and last update date
4. Active campaigns and their status
5. Any project-specific terminology or abbreviations

Proceed with memory structure creation using provided data. Note in CLAUDE.md which data requires manual updates vs. automated refresh.

## Instructions

When a user requests SEO memory management:

### 1. Initialize Memory Structure

For new projects, create the following structure:

```markdown
## Directory Structure

project-root/
├── CLAUDE.md                           # Hot cache (~100 lines)
└── memory/
    ├── glossary.md                     # Project terminology
    ├── keywords/
    │   ├── hero-keywords.md           # Top priority keywords
    │   ├── secondary-keywords.md      # Medium priority
    │   ├── long-tail-keywords.md      # Long-tail opportunities
    │   └── historical-rankings.csv    # Dated ranking data
    ├── competitors/
    │   ├── primary-competitors.md     # Top 3-5 competitors
    │   ├── [competitor-domain].md     # Individual reports
    │   └── analysis-history/          # Dated analyses
    ├── audits/
    │   ├── technical/                 # Technical SEO audits
    │   ├── content/                   # Content audits
    │   ├── domain/                    # Domain authority (CITE) audits
    │   └── backlink/                  # Backlink audits
    ├── content-calendar/
    │   ├── active-calendar.md         # Current quarter
    │   ├── published-content.md       # Performance tracking
    │   └── archive/                   # Past calendars
    └── reports/
        ├── monthly/                   # Monthly reports
        ├── quarterly/                 # Quarterly reports
        └── campaign/                  # Campaign-specific reports
```

> **Templates**: See [references/hot-cache-template.md](./references/hot-cache-template.md) for the complete CLAUDE.md hot cache template and [references/glossary-template.md](./references/glossary-template.md) for the project glossary template.

### Data-Handling Floor — governs every write in this skill

**No secret value is ever written into a file this skill controls** — not the hot cache, not any
`memory/` file, not a report, and not a `.env` or a gitignored file. API keys, service-account
private keys, OAuth tokens, passwords and shared admin logins are refused a place, and
**relocating one to a quieter file is not compliance**: the rule is that the value is not written
anywhere. Refuse in the same reply, give the reason, and offer the pointer form below.

Three reasons, each sufficient alone: (1) **the hot cache auto-loads on every run, for everyone on
the project** — not a file someone opens deliberately, so it reaches sessions run by people the
credential was never issued to; (2) **the memory tree is version-controlled, so a secret committed
once survives its deletion** — a later commit does not remove it from history, and from the moment
it lands rotation is the only real remediation; (3) **a shared login destroys the audit trail** —
with one account between several people no change in the CMS, the analytics property or the search
console can be attributed to a person, a loss that outlasts the engagement.

**Record the fact, never the value**: that the credential exists, who holds it, which secret store or password manager it lives in, and who grants access. `Search Console access — held by the marketing lead, in the company password manager` is a complete entry. Never reproduce a value the user has pasted, not even to confirm what you are declining to store. **A value already pasted is already exposed** — say so plainly and record that it needs rotating, because quietly declining to store it leaves the user believing it is safe.

**Personal data is a judgement, not a bright line.** A work contact for a role is ordinary project context; a home address, personal mobile, ID number, or any health or financial detail is not, and convenience is not a reason to hold it. Name what was asked for, say why you are questioning it, and leave the decision with the person the data belongs to — it is not this skill's to make.

> Library-wide statement of this floor: [Prohibited Tactics](../../references/prohibited-tactics.md) entry 11.

### 4. Context Lookup Flow

When a user references something unclear, follow this lookup sequence:

**Step 1: Check CLAUDE.md (Hot Cache)**
- Is it in active keywords?
- Is it in primary competitors?
- Is it in current priorities or campaigns?

**Step 2: Check memory/glossary.md**
- Is it defined as project terminology?
- Is it a custom segment or shorthand?

**Step 3: Check Cold Storage**
- Search memory/keywords/ for historical data
- Search memory/competitors/ for past analyses
- Search memory/reports/ for archived mentions

**Step 4: Ask User**
- If not found in any layer, ask for clarification
- Log the new term in glossary if it's project-specific

Example lookup:

```markdown
User: "Update rankings for our hero KWs"

Step 1: Check CLAUDE.md → Found "Hero Keywords (Priority 1)" section
Step 2: Extract keyword list from hot cache
Step 3: Execute ranking check
Step 4: Update both CLAUDE.md and memory/keywords/historical-rankings.csv
```

### 5. Promotion & Demotion Logic

> **Reference**: See [references/promotion-demotion-rules.md](./references/promotion-demotion-rules.md) for detailed promotion/demotion triggers (keywords, competitors, metrics, campaigns) and the action procedures for each.

### 6. Update Triggers, Archive Management & Cross-Skill Integration

> **Reference**: See [references/update-triggers-integration.md](./references/update-triggers-integration.md) for the complete update procedures after ranking checks, competitor analyses, audits, and reports; monthly/quarterly archive routines; and integration points with all 8 connected skills (keyword-research, rank-tracker, competitor-analysis, content-gap-analysis, seo-content-writer, content-quality-auditor, domain-authority-auditor).

Memory is where a handoff payload is stored and re-read, so store the payload's fields in the payload's own notation — the framework-labelled score strings (`CORE-EEAT C:… O:… R:…`, `CITE C:… I:… T:… E:…`), prefixed item IDs, veto status and audit date — rather than paraphrasing them into a summary the next run has to re-parse. Field list and notation: [inter-skill-handoff.md](../../references/inter-skill-handoff.md). Everything promoted to the hot cache is operator-read, so run handles are correct there and never in a client deliverable drawn from it.

### A stored action keeps all seven fields — the round trip is where they get lost

**An action written into memory is stored with the seven fields it shipped with, and read back with them.** Every recommended action in this library carries **action · owner · acceptance criterion · expected impact · effort · dependencies · risk if done wrong**, the first three required and the rest holding a stated-absence value (`not estimated — no baseline data`, `not estimated`, `none`, `low — reversible, no downstream effect`) rather than a blank ([Action Output Contract](../../references/action-output-contract.md)). This skill does not author actions — it is the layer they survive in, and **a field this layer drops is a field the next run silently reinvents**. Promoting "top 3-5 action items" as bare one-line priorities is exactly that loss: it discards the owner and the acceptance criterion, which are the two fields that make an action implementable, and a later run re-emits the item into a client deliverable with a plausible owner nobody agreed to and nothing checkable. Store the row, not the headline.

**Three consequences.** (1) The hot cache's *Current Optimization Priorities* block carries **Owner** and **Done when** alongside status and expected impact — the template in [hot-cache-template.md](./references/hot-cache-template.md) is the shape, and its ~100-line budget is met by holding fewer actions, never by holding them with fields stripped. (2) **Demotion to cold storage moves the whole row**; an archived action that lost its criterion cannot be checked, so the archive stops answering "was this ever done?", which is the question archives exist for. (3) A stored action whose owner reads `unassigned — needs an owner` **keeps that value on promotion and is surfaced in the weekly hot-cache review** — it is a legitimate value and a finding, and quietly filling it in during a memory update makes an assignment nobody made. Where a stored action predates this rule and its owner or criterion genuinely was never recorded, write `not recorded at capture — re-derive before re-issuing` rather than inventing one; a run that re-issues it names that gap in its own output.

## Validation Checkpoints

### Structure Validation
- [ ] CLAUDE.md exists and is under 150 lines (aim for ~100)
- [ ] memory/ directory structure matches template
- [ ] glossary.md exists and is populated with project basics
- [ ] All historical data files include timestamps in filename or metadata

### Content Validation
- [ ] CLAUDE.md "Last Updated" date is current
- [ ] Every keyword in hot cache has current rank, target rank, and status
- [ ] Every competitor has domain authority and position assessment
- [ ] Every active campaign has status percentage and expected completion date
- [ ] Key Metrics Snapshot shows "Previous" values for comparison

### Lookup Validation
- [ ] Test lookup flow: reference a term → verify it finds it in correct layer
- [ ] Test promotion: manually promote item → verify it appears in CLAUDE.md
- [ ] Test demotion: manually archive item → verify removed from CLAUDE.md
- [ ] Glossary contains all custom segments and shorthand used in CLAUDE.md

### Update Validation
- [ ] After ranking check, historical-rankings.csv has new row with today's date
- [ ] After competitor analysis, analysis-history/ has dated file
- [ ] After audit, top action items appear in CLAUDE.md priorities — each with all seven fields it arrived with (action, owner, acceptance criterion, expected impact, effort, dependencies, risk if done wrong), not compressed to a one-line headline; `unassigned — needs an owner` is carried through as written, never filled in during the update
- [ ] Every action demoted to cold storage moved as a whole row, criterion included, so the archive can still answer "was this done?"; and any action stored without an owner or a criterion carries `not recorded at capture — re-derive before re-issuing` rather than a value this run supplied
- [ ] After monthly report, metrics snapshot reflects new data

### Data-Handling Validation
- [ ] No secret value in any file this run wrote — hot cache, `memory/`, reports, config. Check the files written, not the intent: a key moved from the hot cache into `memory/` still fails
- [ ] Nothing relocated to a `.env`, a gitignored file, or "a different file" as a workaround
- [ ] No value the user pasted is reproduced anywhere in the run's own output
- [ ] Every credential referenced is recorded fact-only — exists, who holds it, which secret store — with the value absent
- [ ] Any already-pasted value is flagged as exposed, with rotation stated as the remedy
- [ ] Personal data beyond a work contact for a role was named and referred back to its owner, not stored on the run's own judgement

## Examples

> **Reference**: See [references/examples.md](./references/examples.md) for three complete examples: (1) updating hero keyword rankings with memory refresh, (2) glossary lookup flow, and (3) initializing memory for a new e-commerce project.

## Advanced Features

### Smart Context Loading

```
Load full context for [campaign name]
```

Retrieves hot cache + all cold storage files related to campaign.

### Memory Health Check

```
Run memory health check
```

Audits memory structure: finds orphaned files, missing timestamps, stale hot cache items, broken references.

### Bulk Promotion/Demotion

```
Promote all keywords ranking in top 10 to hot cache
```

```
Demote all completed campaigns from Q3 2024
```

### Memory Snapshot

```
Create memory snapshot for [date/milestone]
```

Takes point-in-time copy of entire memory structure for major milestones (site launches, algorithm updates, etc.).

### Cross-Project Memory

```
Compare memory with [other project name]
```

Identifies keyword overlaps, competitor intersections, and strategy similarities across multiple projects.

## Practical Limitations

- **Concurrent access**: If multiple Claude sessions update memory simultaneously, later writes may overwrite earlier ones. Mitigate by using timestamped filenames for audit reports rather than overwriting a single file.
- **Cold storage retrieval**: Files in `memory/` subdirectories are only loaded when explicitly requested. They do not appear in Claude's context automatically. The hot cache (`CLAUDE.md`) is the primary cross-session mechanism.
- **CLAUDE.md size**: The hot cache should stay concise (<200 lines). If it grows too large, archive older metrics to cold storage.
- **Data freshness**: Memory reflects the last time each skill was run. Stale data (>90 days) should be flagged for refresh.

## Tips for Success

1. **Keep hot cache lean** - CLAUDE.md should never exceed 150 lines. If it grows larger, aggressively demote.
2. **Date everything** - Every file in cold storage should have YYYY-MM-DD in filename or prominent metadata.
3. **Update after every significant action** - Don't let memory drift from reality. Update immediately after ranking checks, audits, or reports.
4. **Use glossary liberally** - If you find yourself explaining a term twice, add it to glossary.
5. **Review hot cache weekly** - Quick scan to ensure everything there is still relevant and active.
6. **Automate where possible** - If ~~SEO tool or ~~search console connected, set up automatic updates to historical-rankings.csv.
7. **Archive aggressively** - Better to have data in cold storage and not need it than clutter hot cache.
8. **Link between layers** - CLAUDE.md should always reference where detailed data lives ("Full data: memory/keywords/").
9. **Timestamp changes** - When updating CLAUDE.md, always update "Last Updated" date.
10. **Use memory for continuity** - If you switch between different analysis sessions, memory ensures nothing is forgotten.

## Reference Materials

- [CORE-EEAT Content Benchmark](../../references/core-eeat-benchmark.md) — Content quality scoring stored in memory
- [CITE Domain Rating](../../references/cite-domain-rating.md) — Domain authority scoring stored in memory
- [Inter-Skill Handoff](../../references/inter-skill-handoff.md) — the payload fields and score-string notation to store verbatim, so a later run reads them without re-parsing
- [Action Output Contract](../../references/action-output-contract.md) — the seven fields an action arrives with and must leave with: their stated-absence values, the closed owner-role list, and what makes an acceptance criterion checkable six weeks later by someone who was not there

## Related Skills

- [rank-tracker](../../monitor/rank-tracker/) — Provides ranking data to update memory
- [competitor-analysis](../../research/competitor-analysis/) — Generates competitor reports for storage
- [keyword-research](../../research/keyword-research/) — Discovers keywords to add to memory
- [performance-reporter](../../monitor/performance-reporter/) — Creates reports that trigger memory updates
- [content-gap-analysis](../../research/content-gap-analysis/) — Identifies optimization priorities for hot cache
- [seo-content-writer](../../build/seo-content-writer/) — Logs published content to memory calendar
- [content-quality-auditor](../content-quality-auditor/) — Content audit results stored in memory for tracking
- [domain-authority-auditor](../domain-authority-auditor/) — CITE domain audit results stored in memory for tracking
- [entity-optimizer](../entity-optimizer/) — Store entity audit results for tracking over time
