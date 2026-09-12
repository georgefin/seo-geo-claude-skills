# Instrument changes — baselines that no longer measure what their successors measure

**Read this before comparing any two scores in this directory.**

A baseline is only comparable to another baseline if both graded the same expectations. When an
expectation is rewritten, every record taken before the rewrite measures a **different
instrument**, and the difference between old score and new score is not a regression or an
improvement — it is the yardstick moving. Nothing in a JSON record says which expectations it
graded, so without this file the change is invisible and reads as skill drift.

Open finding **C4** is the line-scale version of this (an expectation rewritten between runs in
the FAIL→PASS direction, 3 of 29). Finding **86** is the wave-scale version, recorded below.

---


## research/content-gap-analysis — 30 → 34 expectations (2026-08-17)

**Change**: four expectations **appended** — e1.7, e1.8 (English) and e3.8, e3.9 (Greek) — grading
the two behaviours content-gap-analysis 4.2.7 shipped and nothing measured: the demand floor on the
proxy path, and the Competitive-Density non-independence disclosure. Per-eval totals e1 6→8,
e3 7→9. e2, e4, e5 untouched.

**DIRECTION: addition, not rewrite.** Every pre-existing expectation is byte-identical and in its
original position — verified programmatically against `ecab362`, not asserted. This matters more
than the totals, and it is the half a reader is most likely to get wrong:

- **Per-expectation regression comparison against all three prior records stays VALID.** That is
  the comparison that outranks the pass rate, and it is unaffected.
- **Raw pass-rate comparison across this boundary is NOT valid.** Old denominator 30, new 34, and
  the two new behaviours *could not have been failed* by any run graded before 2026-08-17. A move
  from 0.9667 to 0.9412 (32/34) across this boundary is not evidence of skill drift.

**Records made non-comparable on totals** (all three graded a 30-expectation instrument):

| record | method | skill version | as recorded |
|---|---|---|---|
| `blind-2026-08-11/gap.json` | blind | 4.2.2 | 29 passed / 1 editor-pending / 30 = 0.9667 |
| `blind-2026-08-10c/gap.json` | blind, founding | 4.1.0 | 28 / 2 / 30 = 0.9333 |
| `2026-08-10-e2345.json` (suite `contentgap`) | informed-executor | not recorded | 29 / 0 / 30 = 0.9667 |

**A re-run is owed before either number is quoted as evidence**, because the skill under test also
moved — 4.2.2 → 4.2.7 — so the instrument and the subject both changed between the last record and
now. Two moving parts, one number: that is exactly the confusion this file exists to prevent.

---

## 2026-08-17 — three suites stopped grading a retracted claim

**Commit**: `dcabd6b`. **Suites**: `build/schema-markup-generator` e3 ·
`monitor/alert-manager` e2 · `optimize/technical-seo-checker` e5.

**What changed — and it is NOT the same in all three. The first version of this row said "all
three required" and gave one direction for the wave; a Mode A pass falsified it for
`alert-manager`, and a wrong direction is worse than the absent direction this file's own closing
rule calls unusable.** Per suite:

| suite | what the old expectation actually did | direction for a 9a-compliant response |
|---|---|---|
| `schema-markup-generator` e3 | **required** the AI-engine/GEO parsing framing outright | **FAIL → PASS.** A correct response used to fail. |
| `technical-seo-checker` e5 | required it **conditionally** — *"if FAQPage markup is recommended…"* | **FAIL → PASS, but only on runs that recommend the markup.** A run that does not never met the condition. |
| `alert-manager` e2.3 | did **not** require it. The framing sat in a **parenthetical rationale** — *"(its AI-engine/GEO parsing value stands per the house ruling)"* — attached to a requirement that is really *"does NOT extend the retirement into advising removal of FAQPage markup itself"*. The four graded requirements are satisfiable without ever mentioning parsing value. | **No movement.** Verified: `blind-2026-08-13/alertmanager.json` e2.3 is `"passed": true`, and the whole record contains **0** occurrences of `parsing` and **0** of `AI-engine`. |

**Consequence for alert-manager specifically**: its pre-`dcabd6b` records are **comparable** with
post-`dcabd6b` ones on e2.3, so a score drop there is a real regression and must not be discounted
as yardstick movement. That is the exact misreading this file was written to prevent, and the
first version of this row would have caused it.

**What this does to the records.** Mode B records for `schema-markup-generator` and
`technical-seo-checker` taken **before** `dcabd6b` graded the superseded expectation.
`alert-manager` is the exception above. For the two affected suites, those records:

- **may not be quoted as evidence** for the current skill without a re-run;
- **may not be differenced** against a post-`dcabd6b` record — a score drop there is the
  expectation change, not the skill;
- remain valid as history of what the suite used to ask.

**Owed**: a Mode B re-run of all three against the current suites before any of them is cited in
a merge decision. Not yet done.

**Why this file exists rather than a note in each JSON.** The records are machine-written and a
hand-added key would not survive the next write. A reader comparing two numbers reaches this
directory first, and the comparison is where the harm happens.

---

## 2026-08-18 — three expectation texts repaired; no denominator moved

Suites: `serp-analysis` e3.1, `entity-optimizer` e3.2, `performance-reporter` e1.5. Written by the
`suite-contradictions` lane; the commit is the one that changed exactly those three `evals.json`
files on this date. **Expectation counts unchanged in all four suites examined** — 29 / 33 / 29 / 29,
each still matching its `blind-2026-08-17` record's `summary.total`, so per-expectation comparison
against that wave stays valid. Three texts moved, which is not a denominator change, but a later
reader must not mistake it for skill drift.

**`serp-analysis` e3.1.** Used to anchor on the taxonomy cell *"Google sees this as high-information
query"*. Now anchors on the cell's current text, requires the read to be present in the deliverable
in its own words, and fails a response that asserts an engine disposition. The old text was deleted
at `1675e11` under settled ruling **R3 amendment 9a**; the expectation still graded it.
**Direction**: no recorded verdict moves — the 08-17 FAIL stands, the 08-10 PASS stands. What closes
is the 08-17 record's printed lenient alternative: **27/29 is void, 26/29 is the only reading.** A
response writing the retracted sentence now moves PASS → FAIL.

**`entity-optimizer` e3.2.** Used to *license* repeating, untimed and attributed, the claim that a
complete Wikidata entry "often precedes panel creation". The skill retracted that claim at `f944d24`
under the same ruling and makes no such observation anywhere at HEAD — so the expectation
**licensed a deliverable to tell a client an unsourced claim about what Google does.** Now the
prohibition is kept and widened (not untimed, not attributed, not as a general observation, not as a
retraction) and the licence is replaced with what the skill does say. All five original graded
demands survive. **Direction**: both recorded runs stay PASS; neither deliverable used the licence.

**`performance-reporter` e1.5.** Used to write the Core Web Vitals middle band inclusively
(`2.5–4.0 s`) in the same sentence that opens `LCP ≤2.5s` — **double-grading 2.5 s against itself**,
independently of any reference. Now exclusive, matching `kpi-definitions.md:453-455` as repaired at
`db83ee9` under settled ruling **R4**. **Direction**: zero movement on any record — fixture values
are 3.1 s, 2.8 s, 205 ms, 190 ms, 0.08, none on a boundary.

**Owed**: re-runs of all four suites once the tree is frozen. Three findings registered alongside
these did **not** hold at HEAD and nothing was changed for them — `serp-analysis` e4.2,
`geo-content-optimizer` e2.1 and e1.5.

---

## optimize/internal-linking-optimizer — the id `e1.6` was reused for a different question (2026-08-10)

**Commit**: `ebc1ca1` *"close the anchor contradiction and the projection gap"*, 2026-08-10
16:55:08Z, with follow-ups `ccbee26` (17:04:53Z) and `3a8d62c` (21:40:26Z, the library-wide
editor-slot sweep). **Suite**: `optimize/internal-linking-optimizer`, eval e1. **Expectation
count 28 → 30** (e1 6→7, e2 6→7; e3, e4, e5 unchanged in count).

**What changed.** `ebc1ca1` split the old `e1.5` — which graded fix ORDER and the suggestion
PAYLOAD in one conjunction — into two expectations, and everything after the split shifted down
one position inside e1. Ids are positional, so the shift silently rebound one of them:

| id | before `ebc1ca1` | at HEAD | text similarity |
|---|---|---|---|
| `e1.5` | *"What-to-fix-first follows the Implementation Priority Order **AND** every concrete link suggestion carries source page, target page and recommended anchor text"* | ordering only — *"this expectation grades ordering only — the suggestion payload is graded by the next one, so a FAIL here always means the order"* | 0.66 |
| **`e1.6`** | **no fabrication (ledger F3 guard)** — every URL, count and session figure traces to the fixture | **suggestion payload** — source page, target page and anchor text on every suggestion, orphan fixes included | **0.04** |
| `e1.7` | *did not exist* | no fabrication — the old `e1.6` verbatim but for one quoted phrase, *"Source of each data point clearly stated (`~~web crawler data`, `~~analytics`, user-provided, or manual analysis)"* → *"Source of each data point stated in the report's own words"* | 0.92 against old `e1.6` |

`e2.7` (after-state re-derivability) is genuinely new. `e1.3`, `e2.4`, `e3.4`, `e4.6` and `e5.1`
were reworded in place at their own ids; `e3.4`'s is the editor-slot rewrite at `3a8d62c`.
**Twenty-one ids are byte-identical across the boundary.** Every figure here was produced by
extracting both trees' `evals.json` and comparing them, not asserted.

**DIRECTION — the misreading is not where the id changed, it is one row above.**

- **`e1.6` compared by id reads PASS → PASS and looks stable.** It is two different questions:
  the `blind-2026-08-10b/linking.json` PASS is *no fabrication*, the
  `blind-2026-08-17/internal-linking-optimizer.json` PASS is *suggestion payload*. The valid
  mapping is **old `e1.6` → new `e1.7`**, which is also PASS → PASS. So no verdict moves here —
  the damage is that a reader believes it checked the fabrication guard when it checked the
  payload rule.
- **`e1.5` compared by id reads FAIL → PASS, and that movement did not happen.** The 08-10b
  record fails old `e1.5` on the payload half and says which half in terms: *"First conjunct
  PASSES … Second conjunct FAILS. Ten concrete link suggestions carry source and target but no
  recommended anchor text."* The failing half is today's `e1.6`. Read by id, the suite looks like
  it fixed its fix-ordering; **fix-ordering never failed.**
- Net across the boundary, and the arithmetic closes on 30: **1 id changed question** (`e1.6`),
  **1 comparison is actively misleading because of it** (`e1.5`), **21** are byte-identical and
  compare cleanly, **5** were reworded in place and compare only with the caution flagged above,
  and **2** (`e1.7`, `e2.7`) have no counterpart on the old instrument at all.

**Records on either side.** `blind-2026-08-10b/linking.json` — blind, skill 4.0.2, 26 passed /
1 failed / 1 editor-pending / 28 = 0.9286 — was committed at `092afce`, 2026-08-10 16:38:25Z, and
`evals.json` at that commit carries 28 expectations: it graded the pre-split instrument, sixteen
minutes and forty-three seconds before `ebc1ca1` landed. `blind-2026-08-17/internal-linking-optimizer.json`
— blind, skill 4.5.0, 28 / 1 / 1 / 30 = 0.9333 — graded the post-split one. **A third record is
on the old instrument and is the most exposed of the three**: the `linking` suite entry inside
`2026-08-10-e2345.json` (informed-executor, 27 pass / 0 fail / 1 editor-pending / 28 = 0.9643)
records its verdicts as **positional arrays** — `per_eval["1"].verdicts` is six strings with no
ids at all — so nothing in it can even be remapped by hand without counting positions against the
pre-`ebc1ca1` file. Its e1 positions 5 and 6 are the old combined fix-order expectation and the
old no-fabrication expectation, not today's `e1.5` and `e1.6`.

**The suite was not renumbered, and should not be.** `e1.6` is cited by id in both records and in
their prose; renumbering it now would break every citation that already resolves, which is the
same harm one step later. The grader of the 08-17 run caught the reuse and wrote it into that
record — *"ANY READER COMPARING THE TWO RECORDS BY ID ALONE WILL MIS-MAP THIS ONE"* — which is
the only reason it is known, and it is buried in a JSON key that a reader comparing two numbers
never opens. This row is that warning moved to where the comparison happens.

**Owed.** (i) The general defect is unaddressed: expectation ids are positional, an insertion
renumbers every id after it, and no record states which question an id held. Nothing in the repo
prevents this and nothing detects it. A checker is derivable — compare each suite's
`evals.json` against the tree a record was graded at and report ids whose text similarity is
below a threshold — and does not exist. (ii) The other 19 suites have not been audited for the
same shape; `internal-linking-optimizer` was audited only because a grader happened to say so.

---

## 2026-08-18 — the editor-pending slot was encoded two ways; normalised. NOT an instrument change

**Read this one for what it is not**: no expectation was rewritten, no denominator moved, no
verdict changed. It is here because it lands in the same place an instrument change lands — a
reader differencing two records — and a reader who mistakes it for skill drift will go looking
for movement that never happened.

**The defect.** Nine records encoded the editor-pending state as `"passed": false` — with a sibling
`"status": "editor-pending"`, or (in `blind-2026-08-13/alertmanager.json`) with nothing but the
evidence text saying so — while the 2026-08-17 wave encodes it as `"verdict": "EDITOR-PENDING"`
with `"passed": null`. **A differ reading only `passed` therefore reported `alert-manager` e3.5 as
moving FAIL → not-FAIL between `blind-2026-08-13` and `blind-2026-08-17`. It did not move** — it
has been editor-pending in every record, awaiting the same binding-editor report that has never
been written. This is ledger **F16 recurrence 1**'s two-schemas-in-one-corpus problem at
expectation granularity instead of summary granularity.

**Which encoding is canonical, and why it is not a coin toss.** `verdict: "EDITOR-PENDING"` +
`passed: null` — and the corpus settles it against itself rather than by anyone's preference. All
ten records touched here carry the `editor_slot_convention` object F16-r1(d) requires, and each
one already describes this encoding: *"which is inside the total and is neither passed nor
failed"* (`blind-2026-08-11/alertmanager.json`), *"COUNTED IN THE TOTAL, NOT COUNTED AS PASSED,
AND NOT COUNTED AS FAILED … sit inside `total` and outside `passed`"* (`blind-2026-08-11/geo.json`),
and, naming the field outright, *"e3.1 is recorded `passed: null` / EDITOR-PENDING"*
(`blind-2026-08-11/gap.json`). `passed: false` contradicted the summary it sat inside. The
arithmetic said the same thing before anything was touched: in every one of the nine, the array's
`false` count was exactly `summary.failed` **plus** that record's number of editor-pending slots —
the summary was already excluding them and the array was not. Two records
(`blind-2026-08-17/memory-management.json` e4.5, `blind-2026-08-17/performance-reporter.json`
e5.3) carried `verdict: "EDITOR-PENDING"` and `passed: false` **in the same entry**.

**What changed**: 10 records, 13 entries. `passed: false → null` (12 entries); `status` folded into
`verdict` where it carried only the marker (10 entries, one of them already `passed: null`);
`verdict: "EDITOR-PENDING"` inserted where the entry carried no marker key at all (1 entry,
`blind-2026-08-13/alertmanager.json` e3.5). Files: `blind-2026-08-11/`{`alertmanager`, `gap`,
`geo`, `refresher`}, `blind-2026-08-13/`{`alertmanager`, `geo`, `refresher`},
`blind-2026-08-17/`{`geo-content-optimizer`, `memory-management`, `performance-reporter`}.

**DIRECTION: none. No verdict moved and no rate moved.** Asserted mechanically, not claimed:
`scripts/eval-corpus-report.sh` output is **byte-identical before and after** (pooled 1259/1400 =
0.8993 as recorded, 1291/1400 = 0.9221 slot-counted, 47 records read, exit 0); every `summary` and
`totals` object was diffed against `git HEAD` and none changed; every changed file re-parses; and
the per-record deep-diff refused any change whose leaf was not `passed`/`status`/`verdict` on an
entry whose own `id` was a target.

**What was deliberately NOT normalised, because doing it would be a re-grade.** Two 2026-08-10b
records use a **third** shape — `"passed": true` with a sibling `"editor_pending": true` — and
they disagree with each other about what it means. `blind-2026-08-10b/performance.json` counts it
in `summary.passed` (*"orthogonal flag, not a 30th expectation and not deducted from passed"*);
`blind-2026-08-10b/linking.json` does not (*"COUNTED AS EDITOR-PENDING RATHER THAN PASSED,
mirroring the baseline's treatment"*), so that record is the one record in the corpus whose
expectation array does not reconcile with its own summary — array 27 true / 1 false against
`summary.passed` 26. **That is F16-r1(d)'s unresolved convention question still sitting in the
corpus, and it is the same differ hazard in the opposite direction**: `internal-linking-optimizer`
e3.4 reads `passed: true` at 08-10b and `EDITOR-PENDING` at 08-17, so a mechanical differ reports
PASS → not-PASS on a slot that never moved either. Resolving it means deciding whether a clean
mechanical layer is a `passed: true`, which changes that suite's published rate (26/28 vs 27/28,
the ~3.5-point swing F16-r1(d) already measured on this exact record) — a coordinator's ruling,
not a normalisation.

---

## 2026-08-18 — `content-refresher` e2.3 gains the same carve-out its sibling already had; the verdict does not move, and the re-grade is NOT issued here

Suite: `optimize/content-refresher` e2.3, plus eval 2's `expected_output`. Denominator **unchanged
at 27** — text rewritten inside an existing expectation, none added.

**Used to require** the remediation ship a bolded direct answer of roughly 30 words, an expansion
carrying a specific anchor, jump-linked H2s, quotable sentences and a 40-60-word FAQ — with no
carve-out, against a fixture that withholds the page's own timing answer. **Now requires** the
same, with ruling M6's skeleton carve-out reaching the four slots that answer the withheld
question, and an explicit statement that the jump-linked H2s get **no** carve-out (the fixture
records the current H2s and the query list, so that slot is fillable). The forbidden-widening
clause travels verbatim from e2.6: the carve-out never reaches a value the fixture does carry and
never excuses inventing the substance.

Eval 2's `expected_output` is repaired in the same commit. It read *"ships complete — no
placeholders"*, which flatly contradicted the carve-out e2.6 has held since `d135129` and would
pull a grader back to the pre-repair reading. It now bans **unlabelled** placeholders and names the
labelled-skeleton route, keeping "no invented statistics" and "no fabricated recovery numbers"
intact.

**Direction: PASS → PASS on `blind-2026-08-17`** `[obs:2026-08-18 that record's e2.3 carries
"verdict": "PASS"]`. The carve-out is permissive on the one slot at issue, so it cannot turn a
recorded PASS into a FAIL, and the added H2 exclusion restates what that artefact already did.
**This is the weaker of the two claims a direction can make**: the verdict does not move, but the
graded text did, so a strict reading still makes pre-`53dcc29` records non-comparable on this
expectation. Every *other* expectation in the suite is unaffected.

**The re-grade is deliberately not issued**, on the same ground as the e2.6 row below: the lane
that repairs an instrument does not grade against it. **The record stands at 24/27 = 0.8889** —
unchanged by this row, because a PASS → PASS direction moves no number. What this row exists to
prevent is a later reader inferring from the unchanged total that the instrument also went
unchanged.

**Why `memory-management` gets no row here despite shipping the same day** (`d8a44c9`): that change
edits the SKILL, not the instrument — no expectation, fixture or denominator moved. Its record is
stale for the ordinary reason ruling M2 already covers, the graded version being behind HEAD, which
is true of all 20 records and is not an instrument change.

## 2026-08-18 — `content-refresher` e2.6 rewritten; a standing FAIL is now a PASS, and the re-grade is NOT issued here

Suite: `optimize/content-refresher` e2.6. Denominator **unchanged at 27** — the edit rewrites text
inside an existing expectation and adds none.

**Used to require** a remediation shipped complete, with a fabrication clause scoped to attributed
statistics. **Now requires** the same, with two changes pulling in opposite directions: the Value
Rule's skeleton carve-out is opened for a slot the fixture cannot fill (a labelled skeleton whose
label sits *inside* its own fence PASSES; a bracket slot with no in-fence label, or a skeleton
labelled only in prose outside the fence, FAILS), and the blind spot ledger **F13 recurrence 5**
identified is closed — inventing the substantive answer the fixture withholds and shipping it as
client copy FAILS, bracketed or not, attributed or not.

**Direction: FAIL → PASS on `blind-2026-08-17`.** That record's graded artefact carries the
skeleton label inside its fence, so it satisfies the repaired text. **Records made non-comparable
on this expectation**: `blind-2026-08-17`, `blind-2026-08-13`, `blind-2026-08-11`,
`blind-2026-08-10c`. Per-expectation comparison stays valid for every *other* expectation in the
suite — only e2.6's verdict is affected.

**The re-grade is deliberately not issued.** The lane that repaired the instrument declined to
grade against it, on the ground that authoring and grading the same instrument is self-review —
the bias the executor/grader split exists to remove, and the same discipline ruling M3 records for
a fix written by the party that wrote the rule. **The record stands at 24/27 = 0.8889 until a
fresh grader issues it.** A summary that quietly advanced the number would be the defect this file
exists to make visible.

**Why the fixture leg was not taken.** F13-r5 offered two remedies — supply the missing input, or
carry the carve-out in the expectation. Filling the fixture would have deleted the test: the
withholding is precisely what exposes invention. F13-r5's own words, *"a pass rate that can only
be earned by inventing client-facing content is measuring the wrong thing."*

## How to add a row here

One heading per change, carrying: the commit, the suites, what the expectation used to require,
what it requires now, **the direction** (which way a correct response moved), and what is owed.
A row with no direction is not usable — the direction is the whole reason a reader cannot just
subtract.
