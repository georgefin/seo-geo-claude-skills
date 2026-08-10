# SEO & GEO Skills Library — Claude Code Context

This plugin provides **20 skills and 9 commands** for Search Engine Optimization (SEO) and Generative Engine Optimization (GEO). Skills are auto-loaded by context; commands are invoked with `/seo:`.

## Skills by Phase

| Phase | Skills |
|-------|--------|
| **Research** | `keyword-research`, `competitor-analysis`, `serp-analysis`, `content-gap-analysis` |
| **Build** | `seo-content-writer`, `geo-content-optimizer`, `meta-tags-optimizer`, `schema-markup-generator` |
| **Optimize** | `on-page-seo-auditor`, `technical-seo-checker`, `internal-linking-optimizer`, `content-refresher` |
| **Monitor** | `rank-tracker`, `backlink-analyzer`, `performance-reporter`, `alert-manager` |
| **Cross-cutting** | `content-quality-auditor`, `domain-authority-auditor`, `entity-optimizer`, `memory-management` |

## One-Shot Commands

```
/seo:audit-page      — On-page SEO + CORE-EEAT audit
/seo:audit-domain    — CITE domain authority audit
/seo:check-technical — Technical SEO health check
/seo:write-content   — SEO + GEO optimized content
/seo:keyword-research — Keyword discovery and clustering
/seo:optimize-meta   — Title tags and meta descriptions
/seo:generate-schema — JSON-LD structured data
/seo:report          — Performance report
/seo:setup-alert     — Monitoring alert configuration
```

## Quality Frameworks

- **CORE-EEAT** (`references/core-eeat-benchmark.md`): 80-item content quality framework (8 dimensions). GEO Score = CORE avg; SEO Score = EEAT avg. Three veto items: T04 (conditional — applies only when a material connection exists), C01, R10 (material self-contradiction, not broken links). One verified veto caps the final score at 59; two or more = BLOCK (no final score).
- **CITE** (`references/cite-domain-rating.md`): 40-item domain authority framework (4 dimensions). Three veto items: T03, T05, T09.

## Inter-Skill Handoff

When a skill recommends running another, pass: target keyword, content type, CORE-EEAT dimension scores (e.g., `C:75 O:60 R:80 E:45`), CITE scores, priority item IDs, and content URL.

If `memory-management` is active, prior audit results load automatically from the hot cache in this `CLAUDE.md` file.

## Pipeline Loop State

State for the weekly self-improvement loop lives in `docs/loop/` — `PIPELINE.md` (the 5-stage loop), `SETTLED-RULINGS.md` (non-relitigable research rulings + pinned baselines), `WATCH-ITEMS.md` (the `[VERIFY]` queue), `GATED-ITEMS.md` (proposals awaiting Sani), plus `PILOT.md` (real-site pilot scope), `ADVERSARIAL-LAYER.md` (second-lane review protocols), and `KPI.md` (cold weekly KPI rows). Read them before research or skill edits. Before any `git push`, run `scripts/pre-push-gate.sh` (also enforced by a `PreToolUse` hook in `.claude/settings.json`).

If the gate's `validate-tracking` check (g) reports anchored pointers whose target "lacks its token", run `scripts/reanchor-pointers.sh` (check-only) then `--fix`. Any insertion into `VERSIONS.md` shifts every pointer below it, and the anchor token — not the line number — is what the pointer means, so the new line is derivable. The fixer re-anchors an unambiguous token and **refuses** the two cases only a human can settle: a token that appears nowhere (its subject was deleted or reworded) and a token on several lines (ambiguous). It is deliberately not wired into the gate — a push must not rewrite the registers it is validating.

## Tool Connector Pattern

Skills use `~~category` placeholders (e.g., `~~SEO tool`, `~~analytics`). Every skill works without any integrations (Tier 1). MCP servers in `.mcp.json` add Ahrefs, SimilarWeb, HubSpot, Amplitude, Notion, Slack.

**Resolution rule (binding, ruled 2026-08-10 after a second binding-editor pass found the tokens in client-facing output — 19 occurrences in one Greek report):** a `~~category` token is a template artefact addressed to the **skill author and the operator**. It names a tool *category* so skill text stays tool-agnostic; it is not a word in any deliverable language and must never survive onto a surface a client reads. Resolve it when the output is written:

1. **Tool connected** → write the tool's real name — "Google Search Console", "Ahrefs".
2. **No tool, data from elsewhere** → name that source in plain language, in the deliverable's language — "your 28-day Search Console export", «από το αρχείο που στείλατε», "hand-checked in incognito, 10 Aug".
3. **No tool and no data** → say exactly that and leave the figure out: no tool was connected, so the number is unavailable. Never a token standing in for a number (statistics rule; matches the honest zero-data eval expectations).

The rule resolves the **word**, never the workflow — Tier 1 operation with zero connectors is unaffected. **The test is the reader, not the section**: surfaces read only by the author or the operator keep the token (skill text and references, eval expectations, `CONNECTORS.md`, in-house gap tables and operator notes — the reader there holds the mapping). Anything handed to the client resolves it, including a client-read report's data-source column, gap table, and limitation notes. Carrier: `build/seo-content-writer/references/anti-slop-ruleset.md` §6, FAIL-grade family 7 (greppable `~~`).

## Contribution Rules

- All `SKILL.md` files must include: `name`, `description`, `license`, `compatibility`, `metadata` frontmatter. `metadata.version` is the version authority (G1 pilot, 2026-08-08): a top-level `version` field is tolerated on legacy skills (must stay in lockstep with `metadata.version`) and absent on spec-aligned ones — full migration pending the pilot verdict (`docs/loop/GATED-ITEMS.md` G1)
- `plugin.json` carries no `schemaVersion`/`id` (`name` is the identity — trimmed in the G1 pilot, 2026-08-08); `commands` and `skills` are bare path strings and command descriptions live in each command file's frontmatter (G1 continuation, 2026-08-09); `mcpServers` is a path string to `./.mcp.json`; no `hooks`/`capabilities` fields (empty hooks retired — the strict validator's sole remaining finding is the recorded root-CLAUDE.md packaging warning, accepted residual per `docs/loop/GATED-ITEMS.md` G1)
- Keep `SKILL.md` body under 350 lines — move detail to `references/` subdirectories
- After updating a skill: update all 5 tracking files — `VERSIONS.md`, `.claude-plugin/plugin.json`, `marketplace.json` (repo root), `README.md` skills table, and this `CLAUDE.md` category table
- Branch naming: `feature/skill-name`, `fix/skill-name`, `docs/description`

> [AGENTS.md](./AGENTS.md) · [README.md](./README.md) · Install: [ClawHub](https://clawhub.ai/u/aaron-he-zhu) · [skills.sh](https://skills.sh/aaron-he-zhu/seo-geo-claude-skills)
