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

## 2026-08-17 — three suites stopped grading a retracted claim

**Commit**: `dcabd6b`. **Suites**: `build/schema-markup-generator` e3 ·
`monitor/alert-manager` e2 · `optimize/technical-seo-checker` e5.

**What changed.** All three *required* the response to frame FAQPage markup's remaining value as
AI-engine/GEO parsing. Ruling R3 amendment 9a had already retracted exactly that claim, on the
ground that no primary source establishes it in either direction — so a run stating the sourced
position **failed**, and a run stating the retracted one **passed**. `alert-manager` e2
attributed the framing to "the house ruling", meaning it cited the ruling that says the opposite.

**Direction of the change, stated plainly**: FAIL→PASS for a correct response, PASS→FAIL for the
old one. A skill corrected to be truthful was failing its own tests for being right.

**What this does to the records.** Every Mode B record for these three suites taken **before**
`dcabd6b` graded the superseded expectation. Those records:

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
