# SEO & GEO Skills Library — Versions

Current versions of all skills. Agents can fetch this file from `https://raw.githubusercontent.com/aaron-he-zhu/seo-geo-claude-skills/main/VERSIONS.md` once per session to check for updates.

**Versioning**: Skill versions (`metadata.version` in SKILL.md) track skill content changes independently. Plugin version (in `plugin.json`) tracks manifest and infrastructure changes.

## Skills

| Skill | Category | Version | Last Updated |
|-------|----------|---------|--------------|
| keyword-research | research | 4.1.2 | 2026-08-08 |
| competitor-analysis | research | 4.0.1 | 2026-08-08 |
| serp-analysis | research | 4.2.0 | 2026-08-08 |
| content-gap-analysis | research | 4.0.1 | 2026-08-08 |
| seo-content-writer | build | 4.1.1 | 2026-08-08 |
| geo-content-optimizer | build | 4.1.2 | 2026-08-08 |
| meta-tags-optimizer | build | 4.1.1 | 2026-08-08 |
| schema-markup-generator | build | 4.0.3 | 2026-08-08 |
| on-page-seo-auditor | optimize | 4.0.1 | 2026-08-08 |
| technical-seo-checker | optimize | 4.0.2 | 2026-08-08 |
| internal-linking-optimizer | optimize | 4.0.1 | 2026-08-08 |
| content-refresher | optimize | 4.0.1 | 2026-08-08 |
| rank-tracker | monitor | 4.0.2 | 2026-08-08 |
| backlink-analyzer | monitor | 4.0.1 | 2026-08-08 |
| performance-reporter | monitor | 4.0.1 | 2026-08-08 |
| alert-manager | monitor | 4.0.1 | 2026-08-08 |
| content-quality-auditor | cross-cutting | 4.0.1 | 2026-08-08 |
| domain-authority-auditor | cross-cutting | 4.0.1 | 2026-08-08 |
| entity-optimizer | cross-cutting | 4.1.1 | 2026-08-08 |
| memory-management | cross-cutting | 4.0.1 | 2026-08-08 |

## Changelog

### v4.1.1 (2026-08-08)

Measurement package + surgical craft fixes (loop assessment of 2026-08-08, maintainer-approved):

- **geo-content-optimizer 4.1.1**: worked example reworked to model sourced-data-only statistics with `[CLIENT DATA: ...]` placeholders (was demonstrating unsourced named stats); statistics rule added under Output Validation; missing Reference Materials row for `references/geo-optimization-techniques.md`; behavioral eval suite added (`evals/`, 5 evals / 29 expectations / 2 Greek)
- **keyword-research 4.1.1**: behavioral eval suite added (`evals/`, 5 evals / 31 expectations / 3 Greek-market incl. Greeklish-prompt case)
- **schema-markup-generator 4.0.2**: behavioral eval suite added (`evals/`, 5 evals / 44 expectations / 2 Greek incl. EUR/availability mapping)
- **rank-tracker 4.0.1**: tracking-artifact persistence contract (dated ranking snapshot + memory-management handoff); missing Reference Materials row for `references/ranking-analysis-templates.md`
- Infrastructure (no version bump): `.claude/agents/` roster +2 judge roles (`skill-reviewer` adversarial review + eval runner, `greek-content-editor` native EL judge); `docs/loop/PIPELINE.md` VALIDATE gains a behavioral leg (eval regression = do-not-merge) and APPLY gains adversarial diff review; quarterly loop-KPIs; `scripts/check-freshness.sh` (advisory staleness check); AREX (arXiv 2607.21461) existence confirmed with corrected title, W1 downgraded to optional; RSI baseline extended (GRASP / SEA-Eval / feedback-dynamics / OpenSkillEval); CITE acronym disambiguation note in `references/cite-domain-rating.md`

### v4.1.0 (2026-08-08)

Weekly skill-update-check findings applied (7-lane research sweep of 2026-08-08). Unverified claims carried as explicit [VERIFY] watch-items, never as fact.

- **keyword-research 4.1.0**: Greek dual-coverage step (accented/unaccented/Greeklish/EN as one demand cluster with per-form placement rules); GBP surface mapping; new `references/greek-keyword-coverage.md`
- **serp-analysis 4.1.0**: Skroutz second-SERP module for Greek e-commerce; new `references/skroutz-visibility-factors.md` (observable levers, algorithm framed as unpublished)
- **geo-content-optimizer 4.1.0**: Google AI Mode re-baselined as default search surface (Greek live since 2025-10-08); per-engine citation split; llms.txt/schema-stacking encoded as non-levers
- **meta-tags-optimizer 4.1.0**: six-point hreflang checklist with EL/EN/DE example
- **seo-content-writer 4.1.0**: per-locale E-E-A-T adaptation step for EL/EN/DE variants
- **entity-optimizer 4.1.0**: full NAP restored (Address/Phone, Greek directories, script variants); Google Business Profile added as seventh signal category
- **schema-markup-generator 4.0.1**: FAQ rich-result retirement (2026) reflected; FAQPage generation kept for AI-engine/GEO parsing
- **technical-seo-checker 4.0.1**: FID removed from live CWV metrics (INP-only)

### v4.0.0 (2026-03-24)

ClawHub-first marketplace optimization: security fixes, vector search descriptions, multi-ecosystem install documentation.

**Security & metadata fixes**:
- Removed self-contradictory `metadata.openclaw` blocks from 9 skills (soft dependencies incorrectly declared as hard requirements)
- Fixed copy-paste error: alert-manager and performance-reporter had `primaryEnv: AMPLITUDE_API_KEY` (unrelated to their function)
- Added credential-optional statements to 11 skills with external tool integrations
- Added `homepage` field to all 20 SKILL.md frontmatters

**ClawHub search optimization**:
- Rewrote all 20 skill descriptions with natural language summaries prepended for vector search discovery
- Streamlined trigger phrases to 6-8 highest-frequency per skill
- Updated footer links to include GitHub, ClawHub, and skills.sh

**Documentation migration**:
- README: Replaced single-recommendation install with tool-based routing table (OpenClaw / Claude Code / Cursor+Codex+Windsurf)
- AGENTS.md: ClawHub moved to first position in ecosystem table; install section uses routing table
- CONTRIBUTING.md: Fixed template missing ClawHub and Vercel Labs in compatibility field; added `clawhub publish` / `clawhub sync` commands
- CLAUDE.md: Added ClawHub and skills.sh marketplace links
- config.yml: Added ClawHub Marketplace as issue template contact link

**Infrastructure**:
- plugin.json: homepage changed from skills.sh to GitHub repo URL (neutral)
- marketplace.json: version synced to 4.0.0
- validate-skill.sh: Updated openclaw check from WARN-if-missing to PASS-if-missing (pure instruction skills don't need runtime declarations)

### v3.0.0 (2026-03-04)

Consolidates all post-2.0.0 changes into a single major release aligned with plugin-dev, skill-creator, and financial-services-plugins standards.

**Plugin manifest (plugin-dev spec)**:
- Added `schemaVersion: "1.0.0"` and `id` fields
- Added `description` to all 9 commands and 20 skills in plugin.json and marketplace.json
- Restructured `hooks` from object to array format `[{event, path}]`
- Restructured `mcpServers` from object to array format `[{id, path}]`
- Added `displayName`, `capabilities`, `metadata` blocks
- Added typed `parameters` to all 9 command files

**Skill format (skill-creator spec)**:
- Added top-level `version` field to all 20 SKILL.md frontmatters
- Added `compatibility` field to all 20 skills
- Added `allowed-tools: WebFetch` to 5 skills with live URL fetching
- Added `allowed-tools: ["WebFetch"]` to 3 commands (audit-page, check-technical, generate-schema)
- Trimmed 7 SKILL.md files to ≤350 lines (deduplicated tags, condensed verbose sections)

**Infrastructure (financial-services-plugins patterns)**:
- Added `CLAUDE.md` for Claude Code auto-loading context
- Added `hooks/hooks.json` scaffold
- Added `scripts/validate-skill.sh` CLI validation tool
- Added disclaimer section to README.md
- Moved `marketplace.json` from `.claude-plugin/` to repo root
- Extracted reference data from 5 oversized skills into `references/` subdirectories

**Fixes**:
- Fixed `marketplace.json` name mismatch
- Fixed step numbering bug in `geo-content-optimizer`
- Updated CONTRIBUTING.md with 5-file sync requirement

### v2.0.0 (2026-02-08)
- CORE-EEAT content quality benchmark (80 items, 8 dimensions, veto system)
- CITE domain authority rating (40 items, 4 dimensions, veto system)
- Content-type weighted scoring and domain-type weighted scoring
- Entity optimizer with Knowledge Graph + Wikidata + AI resolution
- Memory management with two-layer hot/cold storage
- Tool-agnostic ~~placeholder connector system with progressive enhancement tiers
- 9 one-shot commands (`/seo:audit-page`, `/seo:audit-domain`, etc.)
- Inter-skill handoff protocol with score passthrough
- skills.sh marketplace and Claude Code plugin distribution

### v1.0.0 (2026-01-28)
- 20 skills across 5 categories (research, build, optimize, monitor, cross-cutting)
- Basic SEO and GEO content optimization workflows
