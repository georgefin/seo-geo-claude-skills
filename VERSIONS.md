# SEO & GEO Skills Library — Versions

Current versions of all skills. Agents can fetch this file from `https://raw.githubusercontent.com/georgefin/seo-geo-claude-skills/main/VERSIONS.md` once per session to check for updates.

**Versioning**: Skill versions (`metadata.version` in SKILL.md) track skill content changes independently. Plugin version (in `plugin.json`) tracks manifest and infrastructure changes.

## Skills

| Skill | Category | Version | Last Updated |
|-------|----------|---------|--------------|
| keyword-research | research | 4.2.1 | 2026-08-08 |
| competitor-analysis | research | 4.0.2 | 2026-08-08 |
| serp-analysis | research | 4.2.4 | 2026-08-09 |
| content-gap-analysis | research | 4.0.2 | 2026-08-09 |
| seo-content-writer | build | 4.2.5 | 2026-08-10 |
| geo-content-optimizer | build | 4.1.6 | 2026-08-09 |
| meta-tags-optimizer | build | 4.1.3 | 2026-08-10 |
| schema-markup-generator | build | 4.1.0 | 2026-08-08 |
| on-page-seo-auditor | optimize | 4.1.1 | 2026-08-08 |
| technical-seo-checker | optimize | 4.2.1 | 2026-08-08 |
| internal-linking-optimizer | optimize | 4.0.1 | 2026-08-08 |
| content-refresher | optimize | 4.1.1 | 2026-08-09 |
| rank-tracker | monitor | 4.1.1 | 2026-08-09 |
| backlink-analyzer | monitor | 4.0.2 | 2026-08-10 |
| performance-reporter | monitor | 4.1.1 | 2026-08-09 |
| alert-manager | monitor | 4.1.1 | 2026-08-08 |
| content-quality-auditor | cross-cutting | 4.2.1 | 2026-08-09 |
| domain-authority-auditor | cross-cutting | 4.1.0 | 2026-08-08 |
| entity-optimizer | cross-cutting | 4.1.4 | 2026-08-09 |
| memory-management | cross-cutting | 4.0.2 | 2026-08-08 |

## Changelog

### v4.4.1 (2026-08-09)

Master-directive wave (tenth/eleventh verdict-log entries): G5–G7 and G8's executable scope released and executed; the binding Greek-editor gate closed the F13 arc.

- **Loop hardening (G5/G6/G8)**: `MASTER-IMPROVEMENT-PLAN.md`; claims-gate + allowlist + 9 fixtures, fragment-lint, trigger-archive check, `KPI.md` (claims-gate wired into `pre-push-gate.sh` in the integration commit directly after this wave's push); `ADVERSARIAL-LAYER.md`; `PILOT.md` (deployment gated on the three Sani inputs per G8)
- **G7 evals, waves E1–E3**: 11 behavioral suites authored — E1+E2 (meta-tags-optimizer, seo-content-writer, content-quality-auditor, on-page-seo-auditor, competitor-analysis, content-gap-analysis, serp-analysis — 205 expectations) and E3 the same day (internal-linking-optimizer, technical-seo-checker, content-refresher, domain-authority-auditor — 109 expectations); 11 Mode A reviews returned 11 findings, all applied with the reviewers' exact wording; first Mode B baselines: E1 complete at 114/117 with binding-editor verdicts NATIVE ×2 / MINOR-EDITS ×4 / FAIL ×0 (`eval-baselines/2026-08-09-e1.json`); E2/E3 first baselines follow per the G7 done-definition
- **geo-content-optimizer 4.1.6**: Statistics-rule Placement clause — provenance notes and placeholders confined to report/gap-table surfaces, never ship-ready copy or JSON-LD (first editor-FAIL fix)
- **seo-content-writer 4.2.1→4.2.2**: anti-slop-ruleset §6 "Ruled Greek Regression Classes" — every FAIL-grade editor ruling now has a greppable carrier (F13-r1 backfill); 4.2.2 via the R3 purge
- **R3 completion purge (F9-r2)**: FAQ rich-result eligibility claims purged library-wide (9 instances, 5 skills) — serp-analysis 4.2.4, content-gap-analysis 4.0.2, meta-tags-optimizer 4.1.2, content-refresher 4.1.1; gate check (f) gains the R3 token sub-sweep, fault-injection-tested
- **Baseline v3** (`eval-baselines/2026-08-09-v3.json`): schema 44/44, keyword 31/31, geo 29/29 through the three-iteration arc (r1 editor FAIL provenance → r2 editor FAIL totality calque/F13-r1 → r3 MINOR-EDITS, arc closed); zero structural regressions; three ledgered recurrences this window (F11-r6, F13-r1, F9-r2), each caught by a designed position and redesigned same-wave
- **Pre-directive close-out riders (same release)**: content-quality-auditor 4.2.1 + performance-reporter 4.1.1 (`29e880c` — benchmark N/A-source clarification, emergency-brake Partial-by-design line, CWV bucket-label fix) and the core-eeat-benchmark C02 count-start alignment (`5cac3e9`); eval-suite v3 wording wave — the 11 backlog items applied as 13 in-place rewords across the three pilot suites (`b08253d`), touched indices re-baselined in `eval-baselines/2026-08-09-v3.json`
- **Registers**: G5–G8 blocks + release flips; FAILURE-LEDGER F11-r6/F13+r1/F9-r2; WATCH-ITEMS W12 (HowTo rich-result status → 2026-08-15 DETECT lane)

- **Fork identity (attribution decision, 2026-08-10)**: machine-readable identity moved to the fork — `plugin.json` author/homepage/repository, both marketplace manifests' `owner`/`metadata.repository`, this file's raw-fetch URL, and the CONTRIBUTING issue link now name `georgefin/seo-geo-claude-skills`; README carries an explicit fork notice crediting the upstream project and its author. The published ClawHub and skills.sh listings keep upstream paths (the fork does not own those listings, so rewriting them would hand users a dead install), and the CORE-EEAT/CITE framework links keep their own attribution as separate upstream projects. Delegated by Sani (twelfth verdict-log entry, `GATED-ITEMS.md`); the 20 `SKILL.md` frontmatter identity fields stay queued for their own wave so an identity change and a 20-skill version bump do not ride one commit. Plugin version held at 4.4.1 — this change rides the same unmerged accumulator.

- **backlink-analyzer 4.0.2 (F3 class, 2026-08-10)**: the link-intersection worked example assigned Domain Authority figures to real named companies (g2.com 91, capterra.com 89, entrepreneur.com 92, techcrunch.com 94, MarketingProfs 75) and averaged them into "82" — quantitative claims about third-party businesses that nobody measured, carrying F3's unlabeled-figure signature. Prospect domains re-cast to the reserved `.example` TLD under an explicit illustrative-figures label restating the statistics rule; the impact block's basis-free "+2-5 positions for competitive keywords" projection replaced by a stated non-projection that hands the measurement to rank-tracker, and the average DA now names its arithmetic. Sibling in `references/analysis-templates.md`: the three literal Risk Scores (95/85/72 per 100) turned into `[score]` placeholders with a tool-provenance note; the "Industry Avg" column ruled out — its cells are already bracket placeholders, so there was no figure to remove.

- **seo-content-writer 4.2.3 (F13 backfill, 2026-08-10)**: `anti-slop-ruleset.md` §6 gains carriers for the 2026-08-10 binding-editor wave, so the rulings stop living in report prose. FAIL-grade family 5 — negative-concord violation, an n-word beside a finite verb with no preverbal «δεν»; founding instance «η εκτίμηση κοστίζει μηδέν και δεσμεύει κανέναν» inside paste-ready FAQ copy, which a Greek reader resolves as the affirmative "it commits somebody" and so inverts a commercial promise (native: «δεν σας δεσμεύει σε τίποτα»); its grep is written down as an approximation with its limits listed, since no plain-text pattern decides clause-scope. Family 6 — the same span's «κοστίζει μηδέν» calque → «δεν κοστίζει τίποτα» / «είναι δωρεάν». Two advisory register classes: English artefact names in Greek client-visible prose (`το skill` / `του skill` / `το template`, 14 occurrences across 5 files, ruled distinct from family 2) and unfinished English residue in Greek copy, the latter carrying its keep-verbatim exemption list (configuration values and identifiers, nginx directives, URLs, brand names). Seven terminology rulings (τομέας→domain, προμηθευτής→πάροχος, απο-ευρετηρίαση→αποευρετηρίαση, μακριάς→μακράς ουράς, πάνελ→σετ, εφευρίσκω→επινοώ, Γρήγορη νίκη→Άμεσο όφελος folded into the existing quick-wins entry). New "Not errors — do not correct" block so the added patterns cannot flag correct Greek («νομό Ηρακλείου», «Μη αυτόματες ενέργειες», «Γρήγορες διορθώσεις», enclitic double accents, synizesis monosyllables). Family 1's existing carrier recorded with its evidence: the same batch produced the ruled native form unprompted («και τα 12 μοντέλα…», «και οι 4 από τον host…») at zero family-1 hits.

- **seo-content-writer 4.2.4 (§6 family-5 coverage gap, 2026-08-10)**: the negative-concord carrier shipped that morning omitted the nominative n-word «κανείς» and documented a case-sensitive pattern, so sentence-initial «Κανένα» — and, sharper, the capitalised licenser «Δεν» — could not match it. Two independent blind Mode B runs found the hole hours later: three capitalised forms sat unmatched in one run's own Greek output, all correct Greek, none surfaced for hand-checking; and each run's own lowercase-only licenser alternation read the correct «Δεν έγινε καμία νέα μέτρηση» as unlicensed, one line short of a false Greek FAIL in both. Applied: «κανείς» added to the token list, both the token grep and the licenser grep documented as case-insensitive, and the entry's limits paragraph extended with the Greek non-case-folding trap and its check (`grep -i 'δεν'` misses «Δεν» under `LC_CTYPE=POSIX` and matches it under `LC_ALL=C.UTF-8` — GNU grep 3.11, this environment, 2026-08-10), so an implementer rebuilding the check handles capitals deliberately. A coverage-gap provenance note records who found it, since the point of the record is that the pipeline tested this guard rather than assumed it sound. No existing family weakened; no banned phrasing required anywhere.

- **G7 evals COMPLETE — 20/20 behavioral coverage (2026-08-10)**: waves E4 (rank-tracker, backlink-analyzer, performance-reporter, alert-manager) and E5 (entity-optimizer, memory-management, carrying the cross-skill handoff eval) authored, adversarially reviewed and fixed — 41 Mode A findings across the two waves, all applied. Founding Mode B baselines for the 13 E2–E5 suites recorded in `eval-baselines/2026-08-10-e2345.json`. That record splits its results by method and does not average across them: ten suites graded by an agent that executed and graded already knowing the expectations (276/282), three under a blind-execute method with expectations withheld until each deliverable was saved (67/86 — 86.2% / 85.7% / 62.1%). The informed-executor figures are an upper bound, not a floor; the blind runs surfaced 19 behavioural FAILs, 7 of them positive errors rather than omissions. Same-wave corrections: backlink-analyzer 4.0.2 (invented DA figures for real named companies removed from the worked example), seo-content-writer 4.2.3→4.2.4 (§6 carriers for the 2026-08-10 editor rulings, then the nominative «κανείς» and case-insensitive matching the pipeline found missing hours later), and two mutually unsatisfiable expectation pairs resolved.

- **meta-tags-optimizer 4.1.3 (F13 recurrence 2, 2026-08-10)**: `references/meta-tag-code-templates.md` introduced its complete tag block with "Copy and paste this complete meta tag block:" and then put a bracket token in every value — teaching the placeholder four of this skill's own eval expectations forbid. A blind Mode B run produced exactly that (`og:image` and `twitter:image` carrying a "TO SUPPLY" note inside `content=`), and its grader traced the cause to the template rather than to the model: F3's example-taught shape applied to F13's placement class. The file now separates two surfaces — a filled illustrative block with every value resolved on the reserved `example.com` host, which alone carries the copy-paste framing, and a fill-in skeleton labelled NOT ship-ready. Every bracketed fence opens with an inline `<!-- SKELETON ... -->` comment so the marker travels with the code when only the fence is copied, and the filled example leaves out `twitter:site` on purpose to demonstrate the drop-the-tag-and-name-the-gap remedy for a value the input cannot supply. Carriers added on the executor's side, where the founding F13 fix had put none: SKILL.md step 4 placement rule plus an Output Validation checkbox, a one-line rule each in `ctr-and-social-reference.md` and `meta-tag-formulas.md`, and the skill's own worked example stops putting `[current year]` inside a `<title>` and a `content=` attribute (its length label corrected from "~163" to the resolved string's actual 154 characters).

- **seo-content-writer 4.2.5 + connector-placeholder resolution rule (policy gap closed, 2026-08-10)**: the `~~category` connector convention said what the tokens are for and never said what happens to them when a skill writes something a client reads. A second binding Greek-editor pass found the answer being improvised — 19 occurrences in one deliverable (`~~search console` ×14, including all 12 rows of a «Πηγή δεδομένων» column, `~~analytics` ×4, `~~SEO tool` ×1), the whole of that pass's required-fix count, in a document that also wrote «Search Console» correctly in Greek prose five times: residue on the way out, not a gap in what the skill knows. An earlier competitor-analysis pass had called the same class "worth a policy call" without a count. Rule written into the root `CLAUDE.md` Tool Connector Pattern section, beside the convention it governs: the token addresses the skill author and the operator, and at output time it resolves to (a) the connected tool's real name, (b) the actual source named in plain language in the deliverable's language, or (c) a plain statement that no tool was connected and the figure is therefore unavailable — never a token in a source's or a number's place. Zero-connector operation is untouched, since (c) is a sentence any deliverable can write and is the move the eval suites already expect. Carried in `anti-slop-ruleset.md` §6 as FAIL-grade family 7, `~~` as its greppable signature, with the reader as its exemption test rather than the section: author/operator surfaces keep the token (skill text, references, eval expectations, `CONNECTORS.md`, in-house gap tables and operator notes), client-read surfaces resolve it, report tables included — the founding instance was itself a report table, so a section-based exemption would have missed it. Executor-side carriers added in SKILL.md (Data Sources resolution paragraph; Output Validation source line, which had itself offered `~~SEO tool data` as source-label vocabulary — the meta-tags-optimizer 4.1.3 cause-in-the-template finding). Second §6 carrier, advisory: **process machinery as client vocabulary** — «σε αυτή την εκτέλεση» ×4, «το βήμα εξόρυξης» ×2, «(χειροκίνητη βαθμίδα)», greppable `εκτέλεση` · `το βήμα` · `βαθμίδα` and hand-checked, against the same document's own «ανάλυση» / «κύκλος»; recorded as a sibling of the English-artefact-name class (same shape, different token set). That artefact-name entry gains its first recurrence, the same day it was ruled: 11 occurrences including «τρέξτε τη δεξιότητα keyword-research» — «δεξιότητα» in Greek is a personal competence, so a client has nothing to act on — with `δεξιότητ` added to its hand-checked grep.

### v4.4.0 (2026-08-09)

G1 continuation executed (approved in the eighth verdict-log entry — Sani: "I want all machines to have the exact same plugins and skills and loops installed"): the manifest-shape migration that unblocks fork installs.

- **plugin.json spec migration**: `commands` flattened to bare path strings (all 9 descriptions verified present in the command files' frontmatter before the flatten); `mcpServers` re-shaped to the path string `./.mcp.json`; `hooks` field dropped and the empty `hooks/hooks.json` (content `{"hooks": {}}`) retired with it; non-spec `capabilities` block removed; validator: the three W8 strict ERRORS gone, sole remaining strict finding is the recorded root-CLAUDE.md packaging warning (accepted residual)
- **End state observed (the F11-r3 standard)**: directory-source add + install on the migrated tree → `claude plugin list` reports "Version: 4.4.0 · Status: √ enabled"; remote flow against post-merge main → `claude plugin marketplace add georgefin/seo-geo-claude-skills` SUCCEEDS (the same command that failed pre-shim — remote discovery leg now verified), while install from main's pre-migration 4.3.5 manifest still draws the W8 validation trio as expected; the remote flow completes when this wave reaches main

### v4.3.5 (2026-08-09)

Pending-tasks wave (Sani proceed order): both agent-doable register items closed, plus the marketplace-discovery fix surfaced by Sani's same-day "other computers" question.

- **rank-tracker 4.1.1**: reference promises trimmed to what the guide contains — SKILL.md blockquote and Reference Materials bullet now list only real sections of tracking-setup-guide.md (the bullet's "SERP feature tracking setup" was a second same-class phrase, caught in-wave); guide Section 6's dangling "Root Cause Taxonomy" pointer dropped; nothing invented (F3 rule)
- Infrastructure (no version bump): validate-tracking check (g) — settled-pointer anchor verification (F12 promoted guard; scans the four live registers, ledger/archive/eval-baselines excluded; fault-injection-tested incl. a load-bearing negative control) — and check (a) extended for the new `.claude-plugin/marketplace.json` marketplace-discovery shim: probed 2026-08-09, `claude plugin marketplace add georgefin/seo-geo-claude-skills` fails with a root-only manifest while a directory-source add via the shim succeeds (add + marketplace-update responses observed), so a byte-identical copy now lives at the path Claude Code resolves (root stays canonical; identity gate-enforced); CORRECTED same day — this bullet's earlier "install succeed end-to-end" wording overclaimed two success responses (F11 recurrence 3): the deeper probe shows plugin INSTALL rejected at manifest validation ("hooks: Invalid input, commands: Invalid input, mcpServers: Invalid input" — the recorded W8 backlog), so working fork installs wait on the G1 continuation decision

### v4.3.4 (2026-08-09)

Review fix-forward pass — the two Mode A rounds on the merged v4.3.3 wave and on the merge-transition commit returned FIX and BLOCK; all findings applied with the reviewers' wording:

- **serp-analysis 4.2.3**: LSA migration timeline hedged as reported ("reported timeline: US from 2026-08, non-US 2027") — the owner verification covered the country picker only, never the migration dates
- **Registers**: all six anchor-tagged pointers re-grepped against the final tree (F12 recurrence 1 — the founding wave's own changelog insertion had re-shifted them +8 at birth; drafting-sequence rule adopted, scripted check promoted to next wave); the seventh verdict-log entry's issue-repair sentence rebuilt observed-vs-diagnosis (F11 recurrence 2 — structural OBSERVED/DIAGNOSIS template adopted for close-out records)

### v4.3.3 (2026-08-09)

W10's LSA leg closed at primary grade (second watch-item through the owner-verdict flow) + the W5 close-out's Mode A BLOCK corrected:

- **serp-analysis 4.2.2**: LSA Greece-absence upgraded to owner-verified — Sani opened the LSA country picker (answer/6224841) and confirmed Greece absent; `[VERIFY]` tag dropped at `serp-feature-taxonomy.md:233` with a migration re-check note (LSA→Google Ads: US 2026-08, non-US 2027)
- **entity-optimizer 4.1.4**: three evidence-fidelity corrections from the W5 review's BLOCK (F11 recurrence 1): "graduated" deleted (the enforcement page states discretionary restrictions with no progression language), "banner" → the page's own word "warning", quote B now carries the paste's terminal period
- **Registers**: five SETTLED-RULINGS pointers + one GATED-ITEMS pointer refreshed and anchor-tagged (new ledger entry F12 — bare line numbers into an append-at-top changelog break on every release; scripted gate check queued)

### v4.3.2 (2026-08-09)

W5 closed at primary grade — the first watch-item resolved through the new G2 verdict flow (owner live-page read, verbatim text pasted in-session):

- **entity-optimizer 4.1.3**: review-solicitation callout upgraded to owner-verified wording — both banned behaviors now carry Google's full "Merchants requesting…" phrasing (confirming the merchant-directive reading from the primary source); enforcement enriched with the set-period qualifiers, the public warning banner, and the email-notice + appeal path; the `[VERIFY]` tag dropped (W5 resolved-primary; the business/answer/7400114 same-text mirror stays a hedged pointer — not separately opened)

### v4.3.1 (2026-08-09)

Verification wave (2026-08-09, Sani proceed order): three evidence upgrades from the weekly sweep — all three encoded with explicit [VERIFY] scope pending Sani-local primary checks (support.google.com + blog.google egress-blocked from cloud).

- **serp-analysis 4.2.1**: LSA Greece-absence claim upgraded from single-vendor to multi-vendor + official-domain-structural corroboration (2026-08-09 sweep); [VERIFY] kept pending Sani-local primary check (support.google.com egress-blocked from cloud)
- **geo-content-optimizer 4.1.5**: AIO/AI Mode quote-preview module encoded (Google-primary 2026-05-06) in ai-citation-patterns.md with rollout-scope [VERIFY]; community-channel framing updated (channel Google-primary, magnitudes stay W3-tagged)
- **entity-optimizer 4.1.2**: review-solicitation claim upgraded from blog-sourced to Google-policy verbatim wording (snippet-corroborated 2026-08-09, ~2026-04-17 addition) — staff-quota + staff-naming bans, spontaneous-mention exemption; enforcement corrected from "suspension risk" to the documented restrictions ladder; [VERIFY] kept pending Sani-local primary check (W5 stays open)

### v4.3.0 (2026-08-08)

Gate execution wave (Sani's verdicts: "1. merge 2. Yes 3. Yes 4. Please explain 5. harvest"). G1 spec pilot + all seven G4 upstream harvest ports (aaron-marketing-skills v19.1.0 concepts, original wording, Apache-2.0) + shared-framework veto refinements. Every commit group adversarially reviewed against frozen targets; two new ledger guards (F8 frozen-review-target, F9 scripted deprecated-token sweep — recurrence 1 recorded honestly, guard redesigned same day).

- **G1 pilot**: memory-management 4.0.2 is the one spec-aligned skill (top-level `version` removed; `metadata.version` is the authority); plugin.json drops `schemaVersion`/`id` (official validator: two warnings removed, zero new findings; W8 resolved); both gate scripts learn the transitional rule; CLAUDE.md + CONTRIBUTING.md updated in lockstep; full migration (command/hook/mcpServer shapes) remains a separate decision
- **content-refresher 4.1.0**: AI Overview recovery playbook (`references/ai-overview-recovery.md` — trigger profile, 28-day GSC diagnostics, four-case segmentation, T+7/14/28 verification, stop rules with entity-optimizer handoffs; FAQ markup conditioned on the R2 both-things test)
- **technical-seo-checker 4.2.1**: 12-agent AI-crawler bot-role roster [VERIFY at sweep], three deliberate stances with own-composition split example, never-block-the-pair audit rule, edge-override + log-verification checks; CWV example/template boundaries made R4-inclusive
- **alert-manager 4.1.1**: citation-loss three-metric weekly block (rate −10pp warn / 10% floor critical; priority-1 loss any/≥3 — priority-1 now defined; position ≥2 slots/dropped), won-citation + AI-Overview event alerts, optional SD severity ladder, response path to the recovery playbook; configuration templates harmonized
- **performance-reporter 4.1.0**: AI-referrals reporting cut (three-source triangulation, hostname roster [VERIFY — churns], AI-share headline, AI-vs-organic gap, delta-vs-control rule, linked≠cited caveat)
- **rank-tracker 4.1.0**: striking-distance GSC mining (~5–20 band, client-side position filtering, opportunity formula with manual-tier fallback, 50-impression house floor; keyword-research boundary intact)
- **CORE-EEAT framework + content-quality-auditor 4.2.0**: R10 veto narrowed to material internal contradiction (broken links = remediable Partial, never veto); T04 broadened to all material connections as a true conditional veto (no connection = N/A excluded, never Partial; link markup insufficient); veto scoring consequences stated (1 veto = cap 59 flagged; 2+ = BLOCK, no final score; unassessable = no score); Section 5 mapping aligned to the R2 boundary; `commands/audit-page.md` scaffold aligned
- **skill-reviewer roster**: UNDECIDED verdict for missing evidence (rule-based Mode A preserved: one BLOCK-class violation = BLOCK)
- **Consistency sweep**: FID purged from a fourth AND fifth live file (geo quotable-examples 4.1.4, competitor-analysis 4.0.2 — the fifth found by the reviewer after a "complete" manual sweep → F9 recurrence 1, guard now scripted as validate-tracking check (f), fault-injection-tested); geo's misattributed CWV statistic corrected (24% = lower abandonment, 2020 Chrome data — not "more clicks"); on-page-seo-auditor 4.1.1 T04 template row
- **Loop records**: verdict log third entry; G2 approved, blocked on the fork's disabled Issues feature; G3 explanation delivered (fact question open); quarterly upstream harvest lane (PIPELINE hygiene §9, first run 2026-10); W8 resolved; F8/F9 ledgered

### v4.2.0 (2026-08-08)

Greek depth wave (P3) + P4 remainder + rulings reconciliation, maintainer-approved ("proceed with the pending tasks"). Eval-verified: zero regressions on the 85 protected expectations; 104/104 on suite v2; learning metrics in `docs/loop/eval-baselines/2026-08-08-v2.json`.

- **All 20 skills (patch)**: cross-catalog "Browse all 20 skills" blocks stripped from every SKILL.md (catalog lives in README/CLAUDE.md; curated Related Skills footers stay)
- **keyword-research 4.2.0→4.2.1**: Greek inflection clustering module (case/number variants as one demand cluster; inflected forms belong in visible copy — placement asymmetry vs unaccented forms); trigger boundary aligned to description (competitor-gap handoff); single-turn default with stated assumptions; universal Volume/Difficulty/Intent columns in analysis tables with explained-N/A (never invented) and the Step-10 crosswalk-reference rule (4.2.1, surfaced by the eval re-run); Step-4 expansion applies to tool-export arrivals; Greeklish prompts answered in proper Greek
- **serp-analysis 4.2.0**: new `references/greek-tourism-seasonality.md` (INSETE-sourced market context, DMA-flux hotel checklists, measured seasonal calendar, EL/EN/DE split) and `references/greek-shopping-surfaces.md` (BestPrice.gr + Google Shopping free listings as check-and-verify surfaces); el-GR availability census in the SERP-feature taxonomy (only evidenced asymmetries annotated)
- **schema-markup-generator 4.1.0**: R2/R3 reconciliation — one primary type per page with documented auxiliaries (BreadcrumbList / nested identity / homepage WebSite), citation-lever stacking banned with the genuinely-both-things exception; all FAQ rich-result guidance purged (FAQPage kept for AI-engine parsing, Schema.org validation)
- **seo-content-writer 4.2.0**: anti-slop ruleset (`references/anti-slop-ruleset.md` — tiered EN+EL vocabulary bans incl. Greek calque patterns, structural bans, information-gain test, specificity ladder); Greek YMYL credential conventions (`references/greek-ymyl-credentials.md` — registry-verifiable bios or omission, never approximation)
- **content-quality-auditor 4.1.0**: anti-slop audit scans AS-1..AS-4 mapped onto existing CORE-EEAT items; findings carry Finding/Evidence/Impact/Fix + Confirmed/Likely/Hypothesis labels
- **domain-authority-auditor 4.1.0**: `references/greek-eshop-compliance.md` (ODR platform discontinued 2025-07-20 → stale footer links are a staleness finding; ΓΕΜΗ/ΑΦΜ display, withdrawal right, ToS transparency — mapped to CITE T06/T08/T10, not-legal-advice disclaimer); confidence-labeled findings
- **on-page-seo-auditor 4.1.0 / technical-seo-checker 4.1.0**: confidence-labeled finding formats; R4 leftovers purged (FID rows removed from references incl. the scoring rubric)
- **Eval infrastructure**: suite v2 wording wave (14 grader refinements as 17 in-place rewords, one deliberate re-baselining wave); Mode B re-runs with regression check — 0 regressions, 2 fixed failures at unchanged wording, both grading-checker defects self-caught (ledger F7, evidence-inspection guard now mandatory); binding greek-content-editor pass on all fresh outputs (3 NATIVE / 4 MINOR-EDITS / 0 FAIL-class); new baseline `docs/loop/eval-baselines/2026-08-08-v2.json`

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
