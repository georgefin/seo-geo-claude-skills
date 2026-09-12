# Hot Cache (CLAUDE.md) Template

Use this template when initializing memory for a new SEO project.

### 2. Hot Cache (CLAUDE.md) Structure

**Before writing: no secret value goes in this file, and none goes in a substitute file either.**
The hot cache auto-loads into every session for everyone on the project, and it is
version-controlled, so a credential committed once survives its deletion. Record that a credential
exists, who holds it and which secret store it lives in — never the value, and never a value the
user has pasted. Moving one to `memory/`, a `.env` or a gitignored file is not compliance. Full
rule, including the personal-data judgement: `SKILL.md` → **Data-Handling Floor**.

Create or update CLAUDE.md with this template:

```markdown
# [Project Name] - SEO Memory (Hot Cache)

<!-- No credentials, API keys, passwords, tokens or personal data in this file. It auto-loads into
     every session and is version-controlled, so a secret committed once survives its deletion.
     Record who holds a credential and which secret store it is in — never the value. -->

**Last Updated**: [Date]
**Project Status**: [Active/Maintenance/Growth]

## Active Target Keywords (Top 10-20)

### Hero Keywords (Priority 1)
| Keyword | Current Rank | Target Rank | Volume | Status |
|---------|--------------|-------------|--------|--------|
| [keyword 1] | #[X] | #[Y] | [vol] | [tracking/optimizing/achieved] |
| [keyword 2] | #[X] | #[Y] | [vol] | [tracking/optimizing/achieved] |

### Secondary Keywords (Priority 2)
| Keyword | Current Rank | Target Rank | Volume | Status |
|---------|--------------|-------------|--------|--------|
| [keyword 1] | #[X] | #[Y] | [vol] | [tracking/optimizing/achieved] |

_Full keyword database: memory/keywords/_

## Primary Competitors (Top 3-5)

1. **[Competitor 1]** (DA: [X])
   - Main strengths: [brief]
   - Our position vs. them: [ahead/behind/competitive]

2. **[Competitor 2]** (DA: [X])
   - Main strengths: [brief]
   - Our position vs. them: [ahead/behind/competitive]

_Detailed analyses: memory/competitors/_

## Current Optimization Priorities

<!-- Each entry is a stored action and keeps the seven fields it arrived with. Owner and
     "Done when" are the two that make it implementable and the two a one-line summary drops;
     without them a later run re-issues this item with an owner nobody agreed to and nothing
     checkable. Where a field has no answer, write its stated-absence value — `unassigned —
     needs an owner`, `not estimated — no baseline data`, `not estimated`, `none`, `low —
     reversible, no downstream effect` — never a blank and never a guess. Hold fewer actions
     to stay inside the ~100-line budget; never hold them with fields stripped. -->

1. **[Priority 1]** — [one imperative sentence naming the artefact and the change]
   - Owner: [role from the closed list, or `unassigned — needs an owner`]
   - Done when: [observable, binary at the moment of checking, attached to a named artefact or
     measurement, dated or triggered]
   - Status: [not started/in progress/completed]
   - Expected impact: [what should change and on what basis, or `not estimated — no baseline data`]
   - Effort: [S / M / L, or `not estimated`] · Depends on: [named blocker, or `none`] ·
     Risk if done wrong: [failure mode, or `low — reversible, no downstream effect`]
   - Deadline: [date]

2. **[Priority 2]** — [action sentence]
   - Owner: [role] · Done when: [criterion]
   - Status: [not started/in progress/completed]
   - Expected impact: [with its basis] · Effort: [band] · Depends on: [blocker or `none`] ·
     Risk if done wrong: [failure mode or the stated-absence value]
   - Deadline: [date]

## Key Metrics Snapshot

**Last Metrics Update**: [Date]

| Metric | Current | Previous | Change | Target |
|--------|---------|----------|--------|--------|
| Organic Traffic | [X] | [X] | [+/-X%] | [target] |
| Avg. Position | [X] | [X] | [+/-X] | [target] |
| Total Keywords Ranking | [X] | [X] | [+/-X] | [target] |
| Page 1 Rankings | [X] | [X] | [+/-X] | [target] |
| Domain Authority | [X] | [X] | [+/-X] | [target] |
| CITE Score | [X] | [X] | [+/-X] | [target] |
| Last Content Audit Score | [score]/100 | ([rating]) | — [date] | [page audited] |
| Total Backlinks | [X] | [X] | [+/-X%] | [target] |

_Historical data: memory/reports/_

## Active Campaigns

### [Campaign Name 1]
- **Duration**: [Start date] - [End date]
- **Goal**: [Specific goal]
- **Status**: [planning/active/completed]
- **Progress**: [X]%
- **Key activities**: [brief list]

### [Campaign Name 2]
- **Duration**: [Start date] - [End date]
- **Goal**: [Specific goal]
- **Status**: [planning/active/completed]
- **Progress**: [X]%
- **Key activities**: [brief list]

_Campaign archives: memory/reports/campaign/_

## Quick Reference Notes

- [Important note 1]
- [Important note 2]
- [Important note 3]

_For project terminology, see: memory/glossary.md_
```

