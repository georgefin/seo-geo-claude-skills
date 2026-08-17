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

## How to add a row here

One heading per change, carrying: the commit, the suites, what the expectation used to require,
what it requires now, **the direction** (which way a correct response moved), and what is owed.
A row with no direction is not usable — the direction is the whole reason a reader cannot just
subtract.
