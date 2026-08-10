# Anti-Slop Provenance — do not read as an executor

**Who this is for:** whoever audits, amends, promotes or retires a rule in
[anti-slop-ruleset.md](anti-slop-ruleset.md) — a grader, a rule author, the coordinator. It
holds the evidence each rule was ruled on: which editor pass, which run, how many
occurrences, what was measured. A rule you cannot trace is a rule you cannot argue with, so
this record is what makes the ruleset auditable rather than a list of assertions.

**Who must not read it:** anyone writing a deliverable. The evidence names the run each rule
came from, and that run is usually a graded eval suite — so reading it tells a writer which
classes the last run of their own suite was marked down for. That is a hint, not an
instruction, and it corrupts the next measurement. This is why the record lives in its own
file rather than under a heading in the ruleset: a heading does not stop a skimmer, and the
ruleset is a required read where this file is not. The ruleset carries the rules and nothing
else; if you are producing output, it is the only one of the two you need.

Every block below is blockquoted, so the marker survives being copied out of context: a rule
lifted from the ruleset carries no `>`, and anything carrying `>` is not a rule. Nothing here
adds a requirement, a pattern, or a protected form.

---

## §6 — Ruled Greek Regression Classes

> **PROVENANCE — not a rule.** §6 as a whole comes from the binding greek-content-editor
> passes of 2026-08-08 (v1/v2), 2026-08-09 (v3) and the 2026-08-10 baseline wave. The
> requirement that a ruled lesson live in §6 as a carrier rather than as a note elsewhere is
> ledger F13; the requirement that a new family ship with a measured hit rate against
> constructed variants of its own defect is ledger F15; the statistics rule behind family 2 is
> ledger F3.

> **PROVENANCE — not a rule. Families 1–4.** Family 1's ruled form was «Όλα τα 18 μοντέλα
> συνοδεύονται…», and the 2026-08-10 batch produced the native form unprompted across the
> wave — «και τα 12 μοντέλα φέρουν πιστοποίηση Solar Keymark», «και οι 4 από τον host
> cdn-old», «συμπληρώστε και τα 3 πεδία» — i.e. avoidance plus correct production, zero
> family-1 hits. Family 2's structural carrier is geo-content-optimizer 4.1.6, Statistics-rule
> Placement clause; its ruled instance was «(απαιτούνται στοιχεία προϊόντος)» inside a FAQ
> answer and its JSON-LD. Families 3 and 4 were ruled on «Υποχρεωτικό εκκρεμές» as a form
> label and «παράδοση αεροδρόμιο» as page copy. The §6 examples for all four were rewritten
> to invented instances on 2026-08-10 so that no rule cell reproduces fixture or deliverable
> text.

> **PROVENANCE — not a rule. Families 5 and 6.** Both come from ONE eight-word span of
> paste-ready customer copy — a FAQ answer under «Έτοιμα κείμενα για δημοσίευση» in the
> content-refresher E3 output, i.e. text the client is told to publish unchanged. The editor
> graded the span FAIL on the dropped negator and named the calque as its second defect: a
> translation-shaped clause that also lost its «δεν», not a stray typo. The ruled instance was
> «η εκτίμηση κοστίζει μηδέν και δεσμεύει κανέναν»; §6's example is now an invented clause of
> the same shape.

> **PROVENANCE — not a rule. Family-5 coverage gap, found and closed the same day the carrier
> shipped (2026-08-10).** As first written that morning the entry listed five tokens, all
> lowercase, with no case rule. Two independent blind Mode B runs hit the hole within hours:
> capitalised forms («Κανένα» and the licenser «Δεν», three of them in one run's own Greek
> output) never matched the pattern, so correct Greek passed unseen instead of reaching
> hand-checking, and each run's own lowercase-only licenser alternation read the correct
> sentence «Δεν έγινε καμία νέα μέτρηση» as unlicensed — one line short of a false Greek FAIL
> in both. The nominative «κανείς» was missing from the token list outright. Recorded because
> the record should show this guard tested by the pipeline rather than assumed sound.

> **PROVENANCE — not a rule. Family-6 coverage gap, closed 2026-08-10, the same shape as
> family 5's.** As shipped that morning the pattern was the literal string `κοστίζει μηδέν`:
> the founding instance's exact two words, which is how a pattern written from a single
> example behaves. Probed against constructed variants of its own ruled defect it matched one
> of five, and two of five with `-i`. It missed the derivational accent shift («κοστίζει
> μηδενικά ευρώ»), the inflected verb («κοστίζουν μηδέν») and an intervening adverb
> («κοστίζει απολύτως μηδέν») — none of them exotic Greek, all of them the same calque. The
> replacement splits net from rank so that no single spelling has to carry the family. The two
> gaps together are the argument for §6's governing note: **a pattern lifted from the founding
> instance encodes that instance, not the class**, and reading one back later feels like
> coverage because it still matches the example it was born from. Both were caught within a
> day of shipping, by running them.

> **PROVENANCE — not a rule. Family 7, the library's own convention leaking.** Founding
> instance: the rank-tracker E3 deliverable, 19 occurrences, which is the whole of that pass's
> required-fix count — `~~search console` ×14 (including all 12 rows of the §8 table's «Πηγή
> δεδομένων» column), `~~analytics` ×4, `~~SEO tool` ×1. The same document wrote «Search
> Console» correctly in Greek prose five times, so the class is residue on the way out, not a
> gap in what the skill knows; that is why the resolution rule lives with the convention (root
> `CLAUDE.md`) and its check lives in the ruleset, rather than being handled skill by skill.
> Second editor to raise it: an earlier competitor-analysis pass called the same tokens "worth
> a policy call" without a count. One template cause is on record and fixed in seo-content-writer:
> an Output Validation line that offered `~~SEO tool data` as source-label vocabulary, i.e. the
> placeholder taught as the label a source column should carry (the meta-tags-optimizer 4.1.3
> finding — cause in the template, not in the model). The library-wide sweep of 2026-08-10
> resolved the token on English report surfaces under the identical rule, across 15 skills.
> **Removed from this record on 2026-08-10 and deliberately not restored**: a verbatim
> expectation string from `cross-cutting/domain-authority-auditor/evals/evals.json`, quoted in
> the ruleset to show that step (c) matches what the suites already expect. It did show that,
> and it also handed every reader a graded expectation (ledger F18). The point survives without
> the quotation: a report with no connected tools can always write the sentence, and the suites
> reward it. It stays out of this file too — a companion record is read by graders, and a
> grader who has memorised an expectation string is no better placed than a primed executor.

> **PROVENANCE — not a rule. Family 8.** Promoted from advisory to FAIL-grade on 2026-08-10 at
> Recurrence 2: a founding instance (14 occurrences, 5 files), a same-day recurrence (11
> occurrences, rank-tracker E3), then 5 more across 2 files in the blind wave. Fix-on-touch
> had failed three recorded passes, which is the ruleset's promotion threshold. The gloss
> exemption was dropped in the promotion and restored the same day after two blind runs found
> the gap; the editor's original wording demonstrated it with alert-manager keeping «Tier 1»
> because it cites the client's own file. Net measurements: 90/90 against the real ID set,
> after an earlier `\b[CORET][0-9]{2}\b` caught 50 of 90 — found by a blind run whose own
> deliverable carried `CITE item I09`, an instance the item-ID component would not have
> caught, surfaced only because the same grep carried the `CITE` alternation. The A-label
> false positive was found the same day by the run that used the net: alert-manager's own
> alert IDs `A10` / `A11` / `A12`. Run against the four Greek deliverables the binding editor
> had just judged, the net caught every instance the editor named — 4 in the keyword E2
> handoff list, the `CORE-EEAT O05` line in schema E2, 13 in the rank-tracker E3 recurrence —
> and returned a clean sheet on linking E3, where the editor also found none. Language
> neutrality was ruled on the blind competitor-analysis run: its Greek E3 carried 8
> occurrences and its four English deliverables 5–7 lines each, and that executor read the
> family as not reaching English. It does.

> **PROVENANCE — not a rule. Family 8's reader test, ruled 2026-08-10.** Opened because
> rank-tracker's suite contained two expectations that could not both be satisfied: one
> required the deliverable to hand two blog URLs to `content-refresher` by name, while another
> forbade any §6 FAIL-grade greppable pattern anywhere in the same Greek client-read
> deliverable — and family 8's net greps the 20 slugs. Three independent agents hit the
> contradiction in one day. The ruling resolves it the way family 7 was already resolved, on
> the reader rather than the document: a handoff block is addressed to the operator even when
> it ships inside a client's report. Nothing in the gloss rule moved.

> **PROVENANCE — not a rule. A mandated family-8 violation, opened and closed 2026-08-10.**
> The general lesson is in §6; this is the instance it came from. `research/competitor-analysis`
> ordered the defect in a client-facing template — a Synthesis Report Template that told the
> writer to run `domain-authority-auditor` by slug to get CITE scores, plus a `CITE / C / I /
> T / E` table, in a section its `SKILL.md` required. **Closed later the same day** in
> competitor-analysis 4.1.0: the instruction now sits in an operator-notes block outside the
> report fence, the fence glosses CITE on first use, and the suite expectation that had
> required the slug was rewritten under the eval-edit rule. The line coordinates originally
> recorded in the ruleset (`references/analysis-templates.md:224`, `SKILL.md:166`) no longer
> point at anything and are kept only as a record of where the defect was.

---

## §1.3 — Greek calque patterns

> **PROVENANCE — not a rule.** The "English abstract subject taking a Greek verb" entry was
> ruled on 2026-08-10, on 3 hits across 2 files. The binding editor was asked for a greppable
> pattern for it and declined to propose one, on the grounds that the defect is a semantic
> mismatch with no surface string to match; that refusal is why the entry says in the ruleset
> that no regex exists and none should be written. The count moved here on 2026-08-10 — a
> writer needs the refusal, not the tally.

---

## §4 — Specificity Ladder

> **PROVENANCE — not a rule.** The clause forbidding an invented number as a way of climbing
> the ladder is ledger **F3**, which exists because a worked example inside this skill once
> modelled the opposite: it demonstrated rung 3 with a fabricated statistic, so the skill
> taught the defect in the act of warning against it. The ledger ID and that history moved
> here on 2026-08-10; the ruleset states the statistics rule without them, because a writer
> needs the rule and an auditor needs the reason.

---

## §3, §5 and the file header — nothing to record

> **PROVENANCE — not a rule.** These sections were swept on 2026-08-10 and carry no run
> label, occurrence count, ledger ID or quoted expectation. What they do carry is
> cross-reference: §3 maps the information-gain rule onto E06 / E08 / O09, §5 maps the
> self-check onto content-quality-auditor's audit scans AS-1 to AS-4 and their CORE-EEAT
> items, and the header links the enforcement-side file. Those are statements of where a rule
> is scored, not evidence about how a rule was ruled, and they were deliberately left in the
> ruleset: an executor who cannot see which item a rule feeds cannot apply it.
