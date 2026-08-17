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

State for the weekly self-improvement loop lives in `docs/loop/` — `PIPELINE.md` (the 5-stage loop), `SETTLED-RULINGS.md` (non-relitigable research rulings + pinned baselines), `WATCH-ITEMS.md` (the `[VERIFY]` queue), `GATED-ITEMS.md` (proposals awaiting Sani), plus `PILOT.md` (real-site pilot scope), `ADVERSARIAL-LAYER.md` (second-lane review protocols), and `KPI.md` (cold weekly KPI rows). Read them before research or skill edits.

**`CLIENT-MANDATE.md` is the scope of record** — what the library is being built for, stated 2026-08-17, with the measured coverage audit behind it and the encode status of each addition. Read it before proposing scope: §2.1 lists what was already encoded and should not be re-specified, §2.2 the ten measured absences this wave closed, and §4 what only Sani can settle (the cluster→property assignments, the first prompt set, the alert thresholds). A wave that re-derives §2.1 from memory instead of reading it will re-specify work the library already does. Before any `git push`, run `scripts/pre-push-gate.sh` (also enforced by a `PreToolUse` hook in `.claude/settings.json`).

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
2. **The skeleton exception** — bracket tokens are the correct notation inside a block explicitly labelled a skeleton. The label lives **inside the fence, in that fence's own syntax**: `<!-- SKELETON … -->` for HTML, `"_SKELETON": "…"` as the first member for JSON-LD, `# SKELETON …` for text formats. The label vocabulary is a **closed list of three**, ruled 2026-08-17: `SKELETON` (structure only, nothing paste-ready), `ILLUSTRATIVE FILL` (filled, but every value invented), `OPERATOR BLOCK` (addressed to whoever runs the library, not the client). Nothing else — `OPERATOR HANDOFF` was a fourth spelling of the third and is retired, because a checker cannot verify a rule whose vocabulary is open. This is not a style preference: **a model copies the fence, not the heading above it** (the meta-tags-optimizer 4.1.3 finding). A skeleton is never introduced with paste-ready framing.

Carriers: `build/schema-markup-generator/references/schema-templates.md` (12 JSON fences + the HTML array fence), `build/meta-tags-optimizer/references/meta-tag-code-templates.md` (the filled/skeleton split that solved this first).

## The Reader Test (binding, ruled 2026-08-10)

Ruled after a blind run hit **two expectations inside a single eval that could not both be satisfied**: rank-tracker's e3.6 required handing URLs to `content-refresher` — naming the skill — on a Greek client-read surface, while e3.4 forbade a skill slug on that same surface under anti-slop family 8. Neither expectation was wrong. The rule they both pointed at had a gap. Three agents hit it independently and asked for a ruling rather than picking a side.

1. **A run handle** — a skill slug, a framework item ID, an internal artefact name, a settled-ruling ID (`ruling R2`, `ruling R3 + amendment 9a`) or a repo path — **survives on a surface addressed to whoever operates the library, and never in client prose.** Ruling IDs and repo paths were added 2026-08-13 (finding 80): the substantive statement stays in the client's own terms, and "(ruling R2)" adds nothing they can act on while naming a register they cannot read. This is family 7's existing test ("the test is the reader, not the section") extended to family 8. It does not loosen the gloss rule: framework *names* are still glossed on first use, framework *item IDs* and *slugs* are still never glossed into client prose.

2. **An operator block inside a client deliverable is an operator surface — but only if it is labelled inside the fence, in that fence's own syntax.** Found while wiring the handoff carrier: both auditors' *Recommended Next Steps* blocks sat inside the client-read report fence carrying bare slugs, with the operator framing in prose *outside* the fence. That framing is worthless, for the Value Rule's founding reason — **a model copies the fence, not the heading above it.** Two forms satisfy this, and lifting the block out of the client fence entirely is preferred over labelling it in place. An unlabelled operator block inside a client fence is family 8.

3. **A framework item ID may be a row label in a scored table; it may never be the referent in prose** (ruled 2026-08-13). Where the item's plain-language name sits beside it in the same row, the client reads "Intent Alignment" and the ID is only a stable handle for the row — that is a pass on a client surface. *"Items R02 and R03 failed"* is the banned form, and a bare list of IDs inside a cell (*"C02, C03 Pass; C01 Partial"*) is the banned form wearing a table's clothes. **Scoped 2026-08-17: a column the reader can skip, not an ID prefixed to prose.** `**[ID] [Name]** — [suggestion]` heading a Top-5 priority entry is *not* a row label — the reader passes through the ID to reach the name, and nothing requires an ID in a five-item list, where the table's ID column is the row's stable identity across an instrument the client bought. **The ruling was forced by an unsatisfiable pair inside both auditors' own Output Validation** — every one of the 80 (or 40) items scored, **and** no item ID inside the client fence — and the scored table is the instrument the client bought. The implementer stopped and asked rather than delete the column or reword a stated rule; an agent that edits a rule to fit its own diff has removed the thing that would have caught it. Skill slugs, command slugs, ruling IDs and repo paths get no equivalent carve-out and stay banned fence-wide.

The test to apply, in one question: **could a reader who copies only the fence tell this block is not for the client?** If no, it is not fixed.

Carriers: `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 8 and its "reader test, worked both ways" section; `references/inter-skill-handoff.md` §3.1 (the in-fence label rule, with the four fence-syntax label forms). Provenance for every §6 rule lives in `build/seo-content-writer/references/anti-slop-provenance.md`, which is **not** an executor's read — see ledger F18.

## AI Visibility Is Measured at the Prompt (binding, ruled 2026-08-17)

Ruled from the client mandate of 2026-08-17, after a grep audit measured what the library already encoded against what the mandate asked for. Engine *coverage* was already broad — ChatGPT in 11 skill files, Perplexity in 11, AI Overview/AI Mode in 29, Gemini in 5 — and sentiment was already a scored framework item (`CITE-C08`). What did not exist anywhere was the **unit of measurement**: `rank-tracker` returned zero matches for "prompt", and the library tracked keyword *rankings* only. A mandate to improve citations and recommendation position in generated answers cannot be executed by an instrument that measures ordinal positions in a list.

1. **The unit of AI visibility is a prompt, not a keyword.** A prompt set is a versioned artefact with the same population discipline a tracked keyword list has: adding or rewording a prompt moves every derived rate without anything having happened in the world.
2. **Mentioned, cited and recommended are three facts, tracked separately** — a brand recommended first with nothing of its own cited is an authority result with a content gap, and reporting either as "AI visibility: present" throws away the diagnosis. **Cited URLs are recorded verbatim, not as domains**: "they cited our comparison page instead of our product page" is the actionable half.
3. **One capture is an observation, not a measurement.** Generated answers vary run to run, so N ≥ 3 repeats before any rate is reported as a rate, `k of N` never a bare percentage, and failed captures recorded rather than dropped.
4. **Engine precedence**: 1 ChatGPT Search · 2 Gemini and Google AI surfaces · 3 Perplexity · 4 Google organic as the technical and authority foundation · 5 other assistants as monitored channels. **Rank 4 is a different instrument, not a lower priority** — organic is fourth in *prompt-level* work because prompts are not how it is measured, and the crawl, index and authority work it needs is not deprioritised by that ordering. The order is a working priority for this client's audience, never a claim about the engines (ruling R3 amendment 9a still governs those).
5. **No composite "AI visibility score."** One number across engines, prompts and three different facts is unattributable when it moves. A connected tool's own composite is quoted with that tool's name attached, never recomputed or blended.

Carrier: `references/ai-visibility-measurement.md` — the twelve recorded fields, the prompt-set sources, the sampling protocol, the derived metrics with their population rules, the manual zero-tool capture protocol, and the conversion-linkage limits (assistant referral figures are a **floor**, labelled as one).

## One Owner Per Cluster (binding, ruled 2026-08-17)

Ruled from the same mandate and the same audit, which found **zero** matches for query-cluster ownership and **zero** for "microsite". Cannibalization appeared in three or four scattered places — a duplicate-title check, a decay signal, a KPI footnote — and nowhere as a governing assignment rule. The pilot had already hit the gap in practice before the mandate stated it: six of the client's properties, four URL grammars, and five URLs serving one identical title, with no rule in the library to judge them against.

1. **Every query cluster has exactly one owning property and exactly one owning URL**, written into the ownership register *before* content is commissioned — not inferred afterwards from whatever happens to rank. `no owner assigned` is a legitimate value and a finding; a blank is neither.
2. **This binds harder on AI surfaces than in ranked lists.** Two competing URLs in a ranked list split a position and some equity. In a generated answer there is typically one cited source, so one property takes the citation and the other takes nothing — and the winner may be the property with no conversion path.
3. **A property earns its place by having a distinct commercial purpose, audience and query territory.** The test is one sentence: *what can a buyer do here that they cannot do on the main site?* "Rank for a second set of the same keywords" is not an answer, and standing up a property on that basis is a prohibited tactic.
4. **Non-owning properties may cover a cluster only in support** — different angle or intent, an in-body link to the owner, and no targeting of the owner's head query in title, H1 or schema. Fail any of the three and it is competing.
5. **Where two properties both have a claim, the owner is the one with the commercial conversion path for that intent**, not the one that currently ranks. Moving a ranking is a smaller job than building a conversion path where none exists.

Carrier: `references/query-cluster-ownership.md` — the register columns, the five property roles and what each may never own, the six collision signals, and the resolution ladder (consolidate → differentiate → retire → canonical, with canonical ranked last and never a substitute for the first three).

## Every Action Is Implementable (binding, ruled 2026-08-17)

Ruled from the same mandate. The audit found **zero** matches for acceptance criteria and **zero** for named owners across the library; outputs already carried priority, effort, risk (27 files), dependencies (9) and expected impact (6), so five of the seven fields existed and the two that make an action checkable did not.

1. **Every recommended action carries seven fields**: action, owner, acceptance criterion, expected impact, effort, dependencies, risk-if-done-wrong. Fields 1–3 are required — an action with no owner-role and no acceptance criterion does not ship as an action. The rest carry a **stated-absence value** (`not estimated — no baseline data`) rather than a blank or an invention, because the absence is itself information the client can act on.
2. **The acceptance-criterion test**: could someone who was not part of this engagement check it, six weeks from now, without asking anybody what was meant? Observable, binary at the moment of checking, attached to a named artefact or measurement, dated or triggered.
3. **An AI-surface criterion is a measurement criterion, never an outcome criterion.** "Brand appears in ChatGPT's answer" is not in anyone's gift to deliver; "the work shipped and the mention rate was re-measured on the same 3-repeat protocol and recorded beside the baseline" is.
4. **The owner is a role, not a person**, from a closed list. **`Client decision` is an owner** — using it makes a decision visible instead of leaving an action stalled with no explanation. `unassigned — needs an owner` is legitimate and is a finding.

Carrier: `references/action-output-contract.md` — the field table with stated-absence values, the criterion worked examples, the role list, the three permitted shapes of expected impact, and the ordering rule.

## Prohibited Tactics (binding, ruled 2026-08-17)

Ruled from the same mandate, which named eight tactics by hand. The audit found the prohibition essentially absent from the library — a single review-solicitation policy note in `entity-optimizer` was the whole of it. A library that produces recommendations needs a stated floor under them, or the floor is whatever the run improvises.

**No skill recommends, drafts or implements any of these — in any deliverable, in any language, at any tier, however the request is phrased**: doorway pages · duplicate microsites · fake or incentivised reviews (and review gating) · manipulative link acquisition · fabricated citations, statistics or quotes · hidden content and cloaking · undisclosed AI-generated content at scale · scraped, spun or unreviewed machine-translated content · guaranteed-outcome promises · expired-domain and redirect appropriation.

Where a client's existing setup already contains one, the skill **names it, states the exposure, gives the remediation with an owner and an acceptance criterion, and ranks it against everything else** — it does not quietly leave it, and it does not build a recommendation on top of it. A skill never removes or alters a client's live property on its own initiative.

**The no-promise half is language-surface and is enforced as FAIL-grade family 10.** It is distinct from family 9: family 9 bans asserting what an engine *does* («η Google προτιμά…»), family 10 bans promising a client what an engine *will do for them*. A deliverable can violate either alone.

Carriers: `references/prohibited-tactics.md` — the ten entries with what each looks like, why it is out, and what to do instead; §3 lists the legitimate practices each is confused with, so the rule does not over-fire on ordinary competitive work. `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 10 (the greppable promise net).

## Contribution Rules

- All `SKILL.md` files must include: `name`, `description`, `license`, `compatibility`, `metadata` frontmatter. `metadata.version` is the version authority (G1 pilot, 2026-08-08): a top-level `version` field is tolerated on legacy skills (must stay in lockstep with `metadata.version`) and absent on spec-aligned ones — full migration pending the pilot verdict (`docs/loop/GATED-ITEMS.md` G1)
- `plugin.json` carries no `schemaVersion`/`id` (`name` is the identity — trimmed in the G1 pilot, 2026-08-08); `commands` and `skills` are bare path strings and command descriptions live in each command file's frontmatter (G1 continuation, 2026-08-09); `mcpServers` is a path string to `./.mcp.json`; no `hooks`/`capabilities` fields (empty hooks retired — the strict validator's sole remaining finding is the recorded root-CLAUDE.md packaging warning, accepted residual per `docs/loop/GATED-ITEMS.md` G1)
- Keep `SKILL.md` body under 350 lines — move detail to `references/` subdirectories
- After updating a skill: update all 5 tracking files — `VERSIONS.md`, `.claude-plugin/plugin.json`, `marketplace.json` (repo root), `README.md` skills table, and this `CLAUDE.md` category table
- Branch naming: `feature/skill-name`, `fix/skill-name`, `docs/description`

> [AGENTS.md](./AGENTS.md) · [README.md](./README.md) · Install: [ClawHub](https://clawhub.ai/u/aaron-he-zhu) · [skills.sh](https://skills.sh/aaron-he-zhu/seo-geo-claude-skills)
