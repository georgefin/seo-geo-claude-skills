# Anti-Slop Provenance — do not read as an executor

**Who this is for:** whoever audits, amends, promotes or retires a rule in
[anti-slop-ruleset.md](anti-slop-ruleset.md) — a grader, a rule author, the coordinator. It
holds the evidence each rule was ruled on: which editor pass, which run, how many
occurrences, and the probe behind a hit rate the ruleset states bare. A rule you cannot trace
is a rule you cannot argue with, so this record is what makes the ruleset auditable rather than
a list of assertions.

**Who must not read it:** anyone writing a deliverable. The evidence names the run each rule
came from, and that run is usually a graded eval suite — so reading it tells a writer which
classes the last run of their own suite was marked down for. That is a hint, not an
instruction, and it corrupts the next measurement. This is why the record lives in its own
file rather than under a heading in the ruleset: a heading does not stop a skimmer, and the
ruleset is a required read where this file is not. The ruleset carries the rules and the
measured reach of the screens they hand you — a hit rate is calibration, and a writer who
cannot see it over-trusts a clean grep — and nothing that identifies the run a rule came from.
If you are producing output, the ruleset is the only one of the two you need.

**Every line below carries `[PROVENANCE — not a rule]`, and that is not decoration.** This
file sits inside the skill's `references/` directory, so a search scoped to the skill with the
test material excluded — the search an executor is instructed to run — reaches it, and a grep
returns one line with no heading in view. A leading `>` only says "quoted": it means "not a
rule" solely by a convention stated in the file the accidental reader has not read. The
per-line marker says it in the hit itself. Blockquoting stays as the second signal, since a
rule lifted from the ruleset carries no `>`. Nothing here adds a requirement, a pattern, or a
protected form.

---

## Provenance for §6 — Ruled Greek Regression Classes

> [PROVENANCE — not a rule] §6 as a whole comes from the binding greek-content-editor
> [PROVENANCE — not a rule] passes of 2026-08-08 (v1/v2), 2026-08-09 (v3) and the 2026-08-10 baseline wave. The
> [PROVENANCE — not a rule] requirement that a ruled lesson live in §6 as a carrier rather than as a note elsewhere is
> [PROVENANCE — not a rule] ledger F13; the requirement that a new family ship with a measured hit rate against
> [PROVENANCE — not a rule] constructed variants of its own defect is ledger F15; the statistics rule behind family 2 is
> [PROVENANCE — not a rule] ledger F3.

> [PROVENANCE — not a rule] **Families 1–4.** Family 1's ruled form was «Όλα τα 18 μοντέλα
> [PROVENANCE — not a rule] συνοδεύονται…», and the 2026-08-10 batch produced the native form unprompted across the
> [PROVENANCE — not a rule] wave — «και τα 12 μοντέλα φέρουν πιστοποίηση Solar Keymark», «και οι 4 από τον host
> [PROVENANCE — not a rule] cdn-old», «συμπληρώστε και τα 3 πεδία» — i.e. avoidance plus correct production, zero
> [PROVENANCE — not a rule] family-1 hits. Family 2's structural carrier is geo-content-optimizer 4.1.6, Statistics-rule
> [PROVENANCE — not a rule] Placement clause; its ruled instance was «(απαιτούνται στοιχεία προϊόντος)» inside a FAQ
> [PROVENANCE — not a rule] answer and its JSON-LD. Families 3 and 4 were ruled on «Υποχρεωτικό εκκρεμές» as a form
> [PROVENANCE — not a rule] label and «παράδοση αεροδρόμιο» as page copy. The §6 examples for all four were rewritten
> [PROVENANCE — not a rule] to invented instances on 2026-08-10 so that no rule cell reproduces fixture or deliverable
> [PROVENANCE — not a rule] text.

> [PROVENANCE — not a rule] **Families 5 and 6.** Both come from ONE eight-word span of
> [PROVENANCE — not a rule] paste-ready customer copy — a FAQ answer under «Έτοιμα κείμενα για δημοσίευση» in the
> [PROVENANCE — not a rule] content-refresher E3 output, i.e. text the client is told to publish unchanged. The editor
> [PROVENANCE — not a rule] graded the span FAIL on the dropped negator and named the calque as its second defect: a
> [PROVENANCE — not a rule] translation-shaped clause that also lost its «δεν», not a stray typo. The ruled instance was
> [PROVENANCE — not a rule] «η εκτίμηση κοστίζει μηδέν και δεσμεύει κανέναν»; §6's example is now an invented clause of
> [PROVENANCE — not a rule] the same shape.

> [PROVENANCE — not a rule] **Family-5 coverage gap, found and closed the same day the carrier
> [PROVENANCE — not a rule] shipped (2026-08-10).** As first written that morning the entry listed five tokens, all
> [PROVENANCE — not a rule] lowercase, with no case rule. Two independent blind Mode B runs hit the hole within hours:
> [PROVENANCE — not a rule] capitalised forms («Κανένα» and the licenser «Δεν», three of them in one run's own Greek
> [PROVENANCE — not a rule] output) never matched the pattern, so correct Greek passed unseen instead of reaching
> [PROVENANCE — not a rule] hand-checking, and each run's own lowercase-only licenser alternation read the correct
> [PROVENANCE — not a rule] sentence «Δεν έγινε καμία νέα μέτρηση» as unlicensed — one line short of a false Greek FAIL
> [PROVENANCE — not a rule] in both. The nominative «κανείς» was missing from the token list outright. Recorded because
> [PROVENANCE — not a rule] the record should show this guard tested by the pipeline rather than assumed sound.

> [PROVENANCE — not a rule] **Family-6 coverage gap, closed 2026-08-10, the same shape as
> [PROVENANCE — not a rule] family 5's.** As shipped that morning the pattern was the literal string `κοστίζει μηδέν`:
> [PROVENANCE — not a rule] the founding instance's exact two words, which is how a pattern written from a single
> [PROVENANCE — not a rule] example behaves. Probed against constructed variants of its own ruled defect it matched one
> [PROVENANCE — not a rule] of five, and two of five with `-i`. It missed the derivational accent shift («κοστίζει
> [PROVENANCE — not a rule] μηδενικά ευρώ»), the inflected verb («κοστίζουν μηδέν») and an intervening adverb
> [PROVENANCE — not a rule] («κοστίζει απολύτως μηδέν») — none of them exotic Greek, all of them the same calque. The
> [PROVENANCE — not a rule] replacement splits net from rank so that no single spelling has to carry the family. The two
> [PROVENANCE — not a rule] gaps together are the argument for §6's governing note: **a pattern lifted from the founding
> [PROVENANCE — not a rule] instance encodes that instance, not the class**, and reading one back later feels like
> [PROVENANCE — not a rule] coverage because it still matches the example it was born from. Both were caught within a
> [PROVENANCE — not a rule] day of shipping, by running them.

> [PROVENANCE — not a rule] **Family 7, the library's own convention leaking.** Founding
> [PROVENANCE — not a rule] instance: the rank-tracker E3 deliverable, 19 occurrences, which is the whole of that pass's
> [PROVENANCE — not a rule] required-fix count — `~~search console` ×14 (including all 12 rows of the §8 table's «Πηγή
> [PROVENANCE — not a rule] δεδομένων» column), `~~analytics` ×4, `~~SEO tool` ×1. The same document wrote «Search
> [PROVENANCE — not a rule] Console» correctly in Greek prose five times, so the class is residue on the way out, not a
> [PROVENANCE — not a rule] gap in what the skill knows; that is why the resolution rule lives with the convention (root
> [PROVENANCE — not a rule] `CLAUDE.md`) and its check lives in the ruleset, rather than being handled skill by skill.
> [PROVENANCE — not a rule] Second editor to raise it: an earlier competitor-analysis pass called the same tokens "worth
> [PROVENANCE — not a rule] a policy call" without a count. One template cause is on record and fixed in seo-content-writer:
> [PROVENANCE — not a rule] an Output Validation line that offered `~~SEO tool data` as source-label vocabulary, i.e. the
> [PROVENANCE — not a rule] placeholder taught as the label a source column should carry (the meta-tags-optimizer 4.1.3
> [PROVENANCE — not a rule] finding — cause in the template, not in the model). The library-wide sweep of 2026-08-10
> [PROVENANCE — not a rule] resolved the token on English report surfaces under the identical rule, across 15 skills.
> [PROVENANCE — not a rule] **Removed from this record on 2026-08-10 and deliberately not restored**: a verbatim
> [PROVENANCE — not a rule] expectation string from `cross-cutting/domain-authority-auditor/evals/evals.json`, quoted in
> [PROVENANCE — not a rule] the ruleset to show that step (c) matches what the suites already expect. It did show that,
> [PROVENANCE — not a rule] and it also handed every reader a graded expectation (ledger F18). The point survives without
> [PROVENANCE — not a rule] the quotation: a report with no connected tools can always write the sentence, and the suites
> [PROVENANCE — not a rule] reward it. It stays out of this file too — a companion record is read by graders, and a
> [PROVENANCE — not a rule] grader who has memorised an expectation string is no better placed than a primed executor.

> [PROVENANCE — not a rule] **Family 8.** Promoted from advisory to FAIL-grade on 2026-08-10 at
> [PROVENANCE — not a rule] Recurrence 2: a founding instance (14 occurrences, 5 files), a same-day recurrence (11
> [PROVENANCE — not a rule] occurrences, rank-tracker E3), then 5 more across 2 files in the blind wave. Fix-on-touch
> [PROVENANCE — not a rule] had failed three recorded passes, which is the ruleset's promotion threshold. The gloss
> [PROVENANCE — not a rule] exemption was dropped in the promotion and restored the same day after two blind runs found
> [PROVENANCE — not a rule] the gap; the editor's original wording demonstrated it with alert-manager keeping «Tier 1»
> [PROVENANCE — not a rule] because it cites the client's own file. Net measurements: 90/90 against the real ID set,
> [PROVENANCE — not a rule] after an earlier `\b[CORET][0-9]{2}\b` caught 50 of 90 — found by a blind run whose own
> [PROVENANCE — not a rule] deliverable carried `CITE item I09`, an instance the item-ID component would not have
> [PROVENANCE — not a rule] caught, surfaced only because the same grep carried the `CITE` alternation. The A-label
> [PROVENANCE — not a rule] false positive was found the same day by the run that used the net: alert-manager's own
> [PROVENANCE — not a rule] alert IDs `A10` / `A11` / `A12`. Run against the four Greek deliverables the binding editor
> [PROVENANCE — not a rule] had just judged, the net caught every instance the editor named — 4 in the keyword E2
> [PROVENANCE — not a rule] handoff list, the `CORE-EEAT O05` line in schema E2, 13 in the rank-tracker E3 recurrence —
> [PROVENANCE — not a rule] and returned a clean sheet on linking E3, where the editor also found none. Language
> [PROVENANCE — not a rule] neutrality was ruled on the blind competitor-analysis run: its Greek E3 carried 8
> [PROVENANCE — not a rule] occurrences and its four English deliverables 5–7 lines each, and that executor read the
> [PROVENANCE — not a rule] family as not reaching English. It does.

> [PROVENANCE — not a rule] **Family 8's reader test, ruled 2026-08-10.** Opened because
> [PROVENANCE — not a rule] rank-tracker's suite contained two expectations that could not both be satisfied: one
> [PROVENANCE — not a rule] required the deliverable to hand two blog URLs to `content-refresher` by name, while another
> [PROVENANCE — not a rule] forbade any §6 FAIL-grade greppable pattern anywhere in the same Greek client-read
> [PROVENANCE — not a rule] deliverable — and family 8's net greps the 20 slugs. Three independent agents hit the
> [PROVENANCE — not a rule] contradiction in one day. The ruling resolves it the way family 7 was already resolved, on
> [PROVENANCE — not a rule] the reader rather than the document: a handoff block is addressed to the operator even when
> [PROVENANCE — not a rule] it ships inside a client's report. Nothing in the gloss rule moved.

> [PROVENANCE — not a rule] **A mandated family-8 violation, opened and closed 2026-08-10.**
> [PROVENANCE — not a rule] The general lesson is in §6; this is the instance it came from. `research/competitor-analysis`
> [PROVENANCE — not a rule] ordered the defect in a client-facing template — a Synthesis Report Template that told the
> [PROVENANCE — not a rule] writer to run `domain-authority-auditor` by slug to get CITE scores, plus a `CITE / C / I /
> [PROVENANCE — not a rule] T / E` table, in a section its `SKILL.md` required. **Closed later the same day** in
> [PROVENANCE — not a rule] competitor-analysis 4.1.0: the instruction now sits in an operator-notes block outside the
> [PROVENANCE — not a rule] report fence, the fence glosses CITE on first use, and the suite expectation that had
> [PROVENANCE — not a rule] required the slug was rewritten under the eval-edit rule. The line coordinates originally
> [PROVENANCE — not a rule] recorded in the ruleset (`references/analysis-templates.md:224`, `SKILL.md:166`) no longer
> [PROVENANCE — not a rule] point at anything and are kept only as a record of where the defect was.

---

## Provenance for §1.3 — Greek calque patterns

> [PROVENANCE — not a rule] The "English abstract subject taking a Greek verb" entry was
> [PROVENANCE — not a rule] ruled on 2026-08-10, on 3 hits across 2 files. The binding editor was asked for a greppable
> [PROVENANCE — not a rule] pattern for it and declined to propose one, on the grounds that the defect is a semantic
> [PROVENANCE — not a rule] mismatch with no surface string to match; that refusal is why the entry says in the ruleset
> [PROVENANCE — not a rule] that no regex exists and none should be written. The count moved here on 2026-08-10 — a
> [PROVENANCE — not a rule] writer needs the refusal, not the tally.

---

## Provenance for §4 — Specificity Ladder

> [PROVENANCE — not a rule] The clause forbidding an invented number as a way of climbing
> [PROVENANCE — not a rule] the ladder is ledger **F3**, which exists because a worked example inside this skill once
> [PROVENANCE — not a rule] modelled the opposite: it demonstrated rung 3 with a fabricated statistic, so the skill
> [PROVENANCE — not a rule] taught the defect in the act of warning against it. The ledger ID and that history moved
> [PROVENANCE — not a rule] here on 2026-08-10; the ruleset states the statistics rule without them, because a writer
> [PROVENANCE — not a rule] needs the rule and an auditor needs the reason.

---

## Provenance for §3, §5 and the file header — nothing to record

> [PROVENANCE — not a rule] These sections were swept on 2026-08-10 and carry no run
> [PROVENANCE — not a rule] label, occurrence count, ledger ID or quoted expectation. What they do carry is
> [PROVENANCE — not a rule] cross-reference: §3 maps the information-gain rule onto E06 / E08 / O09, §5 maps the
> [PROVENANCE — not a rule] self-check onto content-quality-auditor's audit scans AS-1 to AS-4 and their CORE-EEAT
> [PROVENANCE — not a rule] items, and the header links the enforcement-side file. Those are statements of where a rule
> [PROVENANCE — not a rule] is scored, not evidence about how a rule was ruled, and they were deliberately left in the
> [PROVENANCE — not a rule] ruleset: an executor who cannot see which item a rule feeds cannot apply it.
