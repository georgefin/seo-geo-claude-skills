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

Carrier: `references/inter-skill-handoff.md` — payload fields and the exact score-string notation (framework-labelled: `CORE-EEAT C:75 O:60 R:80 E:45 …`, `CITE C:62 I:45 T:80 E:55`), the operator-block placement rule, the drop-and-name rule for an unavailable field, and the grep-derived producer/consumer map. **Item IDs travel in one form only: hyphenated, framework-first — `CITE-C01`, `CORE-EEAT-R02`.** CORE-EEAT and CITE share C, E and T, so a bare `C01` is ambiguous between two frameworks, and a receiving run must be able to act without asking a human which one it came from. Score strings keep the framework as a single leading token rather than hyphenating each pair, because the pairs are one reading of one instrument and never travel individually.

## Pipeline Loop State

State for the weekly self-improvement loop lives in `docs/loop/` — `PIPELINE.md` (the 5-stage loop), `SETTLED-RULINGS.md` (non-relitigable research rulings + pinned baselines), `WATCH-ITEMS.md` (the `[VERIFY]` queue), `GATED-ITEMS.md` (proposals awaiting Sani), plus `PILOT.md` (real-site pilot scope), `ADVERSARIAL-LAYER.md` (second-lane review protocols), and `KPI.md` (cold weekly KPI rows). Read them before research or skill edits. Before any `git push`, run `scripts/pre-push-gate.sh` (also enforced by a `PreToolUse` hook in `.claude/settings.json`).

If the gate's `validate-tracking` check (g) reports anchored pointers whose target "lacks its token", run `scripts/reanchor-pointers.sh` (check-only) then `--fix`. Any insertion into `VERSIONS.md` shifts every pointer below it, and the anchor token — not the line number — is what the pointer means, so the new line is derivable. The fixer re-anchors an unambiguous token and **refuses** the two cases only a human can settle: a token that appears nowhere (its subject was deleted or reworded) and a token on several lines (ambiguous). It is deliberately not wired into the gate — a push must not rewrite the registers it is validating.

`scripts/expectation-carrier-check.sh` (advisory, also not wired into the gate) finds the opposite problem: an eval expectation that grades a rule the skill never states, so the skill fails a test it was never told about. It greps each suite's quoted expectation phrases against the skill's own text. **Read its footer before trusting a clean line** — it sees uncarried *vocabulary* only, and misses an uncarried *behaviour* (its measured coverage is 1 of the 2 known instances).

## Tool Connector Pattern

Skills use `~~category` placeholders (e.g., `~~SEO tool`, `~~analytics`). Every skill works without any integrations (Tier 1). MCP servers in `.mcp.json` add Ahrefs, SimilarWeb, HubSpot, Amplitude, Notion, Slack.

**Resolution rule (binding, ruled 2026-08-10 after a second binding-editor pass found the tokens in client-facing output — 19 occurrences in one Greek report):** a `~~category` token is a template artefact addressed to the **skill author and the operator**. It names a tool *category* so skill text stays tool-agnostic; it is not a word in any deliverable language and must never survive onto a surface a client reads. Resolve it when the output is written:

1. **Tool connected** → write the tool's real name — "Google Search Console", "Ahrefs".
2. **No tool, data from elsewhere** → name that source in plain language, in the deliverable's language — "your 28-day Search Console export", «από το αρχείο που στείλατε», "hand-checked in incognito, 10 Aug".
3. **No tool and no data** → say exactly that and leave the figure out: no tool was connected, so the number is unavailable. Never a token standing in for a number (statistics rule; matches the honest zero-data eval expectations).

The rule resolves the **word**, never the workflow — Tier 1 operation with zero connectors is unaffected. **The test is the reader, not the section**: surfaces read only by the author or the operator keep the token (skill text and references, eval expectations, `CONNECTORS.md`, in-house gap tables and operator notes — the reader there holds the mapping). Anything handed to the client resolves it, including a client-read report's data-source column, gap table, and limitation notes. Carrier: `build/seo-content-writer/references/anti-slop-ruleset.md` §6, FAIL-grade family 7 (greppable `~~`).

## The Value Rule (binding, ruled 2026-08-10)

Ruled after a blind run exposed that two skills gave opposite instructions about the same thing: bracket tokens inside paste-ready values were a FAIL class in `meta-tags-optimizer` (ledger F13-r2) and simultaneously the *only* accepted marking in `schema-markup-generator`'s eval suite. Both surfaces are pasted by a client, so an executor working across both received contradictory rules.

1. **Any block a user is told to paste carries resolved values only** — meta tags, JSON-LD, `robots.txt`, redirects, server config. A value that cannot be sourced means the property or tag is **dropped**, and the gap is named in the report prose: which property, what its absence costs, exactly what to send. A bracket token, `TBD`, `XX`, or a note shaped like a value never appears in a value position of a paste-ready block.
2. **The skeleton exception** — bracket tokens are the correct notation inside a block explicitly labelled a skeleton. The label lives **inside the fence, in that fence's own syntax**: `<!-- SKELETON … -->` for HTML, `"_SKELETON": "…"` as the first member for JSON-LD, `# SKELETON …` for text formats. This is not a style preference: **a model copies the fence, not the heading above it** (the meta-tags-optimizer 4.1.3 finding). A skeleton is never introduced with paste-ready framing.

Carriers: `build/schema-markup-generator/references/schema-templates.md` (12 JSON fences + the HTML array fence), `build/meta-tags-optimizer/references/meta-tag-code-templates.md` (the filled/skeleton split that solved this first).

## The Reader Test (binding, ruled 2026-08-10)

Ruled after a blind run hit **two expectations inside a single eval that could not both be satisfied**: rank-tracker's e3.6 required handing URLs to `content-refresher` — naming the skill — on a Greek client-read surface, while e3.4 forbade a skill slug on that same surface under anti-slop family 8. Neither expectation was wrong. The rule they both pointed at had a gap. Three agents hit it independently and asked for a ruling rather than picking a side.

1. **A run handle** — a skill slug, a framework item ID, an internal artefact name, a settled-ruling ID (`ruling R2`, `ruling R3 + amendment 9a`) or a repo path — **survives on a surface addressed to whoever operates the library, and never in client prose.** Ruling IDs and repo paths were added 2026-08-13 (finding 80): the substantive statement stays in the client's own terms, and "(ruling R2)" adds nothing they can act on while naming a register they cannot read. This is family 7's existing test ("the test is the reader, not the section") extended to family 8. It does not loosen the gloss rule: framework *names* are still glossed on first use, framework *item IDs* and *slugs* are still never glossed into client prose.

2. **An operator block inside a client deliverable is an operator surface — but only if it is labelled inside the fence, in that fence's own syntax.** Found while wiring the handoff carrier: both auditors' *Recommended Next Steps* blocks sat inside the client-read report fence carrying bare slugs, with the operator framing in prose *outside* the fence. That framing is worthless, for the Value Rule's founding reason — **a model copies the fence, not the heading above it.** Two forms satisfy this, and lifting the block out of the client fence entirely is preferred over labelling it in place. An unlabelled operator block inside a client fence is family 8.

3. **A framework item ID may be a row label in a scored table; it may never be the referent in prose** (ruled 2026-08-13). Where the item's plain-language name sits beside it in the same row, the client reads "Intent Alignment" and the ID is only a stable handle for the row — that is a pass on a client surface. *"Items R02 and R03 failed"* is the banned form, and a bare list of IDs inside a cell (*"C02, C03 Pass; C01 Partial"*) is the banned form wearing a table's clothes. **Scoped 2026-08-17: a column the reader can skip, not an ID prefixed to prose.** `**[ID] [Name]** — [suggestion]` heading a Top-5 priority entry is *not* a row label — the reader passes through the ID to reach the name, and nothing requires an ID in a five-item list, where the table's ID column is the row's stable identity across an instrument the client bought. **The ruling was forced by an unsatisfiable pair inside both auditors' own Output Validation** — every one of the 80 (or 40) items scored, **and** no item ID inside the client fence — and the scored table is the instrument the client bought. The implementer stopped and asked rather than delete the column or reword a stated rule; an agent that edits a rule to fit its own diff has removed the thing that would have caught it. Skill slugs, command slugs, ruling IDs and repo paths get no equivalent carve-out and stay banned fence-wide.

The test to apply, in one question: **could a reader who copies only the fence tell this block is not for the client?** If no, it is not fixed.

Carriers: `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 8 and its "reader test, worked both ways" section; `references/inter-skill-handoff.md` §3.1 (the in-fence label rule, with the four fence-syntax label forms). Provenance for every §6 rule lives in `build/seo-content-writer/references/anti-slop-provenance.md`, which is **not** an executor's read — see ledger F18.

## Contribution Rules

- All `SKILL.md` files must include: `name`, `description`, `license`, `compatibility`, `metadata` frontmatter. `metadata.version` is the version authority (G1 pilot, 2026-08-08): a top-level `version` field is tolerated on legacy skills (must stay in lockstep with `metadata.version`) and absent on spec-aligned ones — full migration pending the pilot verdict (`docs/loop/GATED-ITEMS.md` G1)
- `plugin.json` carries no `schemaVersion`/`id` (`name` is the identity — trimmed in the G1 pilot, 2026-08-08); `commands` and `skills` are bare path strings and command descriptions live in each command file's frontmatter (G1 continuation, 2026-08-09); `mcpServers` is a path string to `./.mcp.json`; no `hooks`/`capabilities` fields (empty hooks retired — the strict validator's sole remaining finding is the recorded root-CLAUDE.md packaging warning, accepted residual per `docs/loop/GATED-ITEMS.md` G1)
- Keep `SKILL.md` body under 350 lines — move detail to `references/` subdirectories
- After updating a skill: update all 5 tracking files — `VERSIONS.md`, `.claude-plugin/plugin.json`, `marketplace.json` (repo root), `README.md` skills table, and this `CLAUDE.md` category table
- Branch naming: `feature/skill-name`, `fix/skill-name`, `docs/description`

> [AGENTS.md](./AGENTS.md) · [README.md](./README.md) · Install: [ClawHub](https://clawhub.ai/u/aaron-he-zhu) · [skills.sh](https://skills.sh/aaron-he-zhu/seo-geo-claude-skills)
