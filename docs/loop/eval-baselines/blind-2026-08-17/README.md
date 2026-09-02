# Records in this directory

**Before comparing any score here against any other score, read
[`../INSTRUMENT-CHANGES.md`](../INSTRUMENT-CHANGES.md).**

It records which baselines stopped measuring what their successors measure. When an expectation
is rewritten, a record taken before the rewrite graded a **different instrument**, and the
difference between the two numbers is the yardstick moving — not a regression and not an
improvement. Nothing inside a JSON record says which expectations it graded, so without that file
the change is invisible and reads as skill drift.

This note exists because a grader is sent to a record **by path**. It arrives in this directory,
runs `ls`, and never sees the file one level up. That was measured, not assumed: `validate-tracking.sh`
check (i) counted 20 record(s) here that could not reach it. The note is the fix check (i) asks for.

The pointer is a sibling file rather than a key inside each record because the records are
machine-written — a hand-added JSON key would be erased by the next run that writes the record.

**This directory is why check (i) was repaired, and the repair is the reason the count above is
20 rather than 0.** Until 2026-08-18 the leg tested whether the string `INSTRUMENT-CHANGES`
appeared *anywhere beneath* the directory, so these 20 records passed as covered on the strength
of 5 of them mentioning the file in their own grader prose — while no note existed and `ls` showed
nothing. Two of those five mentions say the file carries **no row** for the change that moved
their own numbers, which is a reader reporting the register incomplete, not a reader being told
where to look.

## What is in here

20 records, one per skill, all run 2026-08-17: 18 blind, and 2 split-role (blind executor,
informed grader) — `entity-optimizer` and `geo-content-optimizer`, each saying so in its own
`method` field. They were **not all graded against one tree**: `repo_head_at_open` takes 7
distinct values across the 20, so two records here can disagree about the skill as legitimately
as they can about the run.

## Which rows in `../INSTRUMENT-CHANGES.md` reach into this directory

Read the file, not this list — but these are the rows that name records here, so a reader who
opens only one row knows which:

- **`research/content-gap-analysis` — 30 → 34 expectations (2026-08-17)**: `content-gap-analysis.json`
  is on the **new** 34-expectation instrument. Its rate may not be differenced against the three
  prior records, which graded 30.
- **2026-08-17 — three suites stopped grading a retracted claim (`dcabd6b`)**: affects
  `schema-markup-generator.json` and `technical-seo-checker.json`; `alert-manager.json` is the
  row's explicit **exception** — its e2.3 did not move, so a drop there is real.
- **2026-08-18 — three expectation texts repaired; no denominator moved**: `serp-analysis.json`,
  `entity-optimizer.json`, `performance-reporter.json`. For serp the row is not a footnote — it
  states *"the 08-17 record's printed lenient alternative: 27/29 is void, 26/29 is the only
  reading."* The published `summary` here is already 26/29.
- **`optimize/internal-linking-optimizer` — the id `e1.6` was reused (2026-08-10)**: comparing
  `internal-linking-optimizer.json` against `blind-2026-08-10b/linking.json` **by id** mis-maps
  two slots. The row gives the valid mapping.
- **2026-08-18 — the editor-pending slot was encoded two ways; normalised. NOT an instrument
  change**: `geo-content-optimizer.json`, `memory-management.json` and `performance-reporter.json`
  were touched by that normalisation. No verdict and no rate moved.

## Two things the pointer does not tell you, and both bite here

**A note beside the records does not mean the register has your row.** Check (i) tests presence,
never coverage. This directory is its own counterexample: `seo-content-writer.json` records that
`../INSTRUMENT-CHANGES.md` carries **no row of its own for `3a8d62c`** — the library-wide sweep
that rewrote one expectation in every one of the 20 suites — and supplies the direction the
register is missing. The file names that commit twice, inside the `internal-linking-optimizer`
row, describing what it did to *that* suite; there is no row for the wave. Re-check with
`grep -n 3a8d62c ../INSTRUMENT-CHANGES.md` before assuming either way.

**These records are not current, and the rule is not a judgement call.** Settled ruling **M2**:
a blind record whose graded version is behind the skill's `metadata.version` at HEAD is stale, and
no lane may clear it by deciding the intervening bump was behaviourally empty. Every record here
carries `skill_version_under_test`; compare it against the skill's current frontmatter yourself
rather than trusting a number frozen in this note. The sharpest case is `technical-seo-checker.json`,
whose `summary.total` is 28 against a suite that now holds 29 expectations
`[obs:2026-08-18 python count of optimize/technical-seo-checker/evals/evals.json → 29]` — so it is
short an expectation as well as behind a version.

## Reading the summaries

Every record counts the greek-content-editor slot **inside `total`** and in neither `passed` nor
`failed`, and every one carries a `summary.editor_slot_convention` object saying so in its own
words (ledger F16-r1(d)). So `passed + failed` is deliberately short of `total` — by 1 in 17
records, by 2 in `geo-content-optimizer`, by 3 in `keyword-research` and `seo-content-writer`;
25 slots across the wave. The published `pass_rate` treats a pending slot as **not passed**, the
conservative direction. `scripts/eval-corpus-report.sh` reads that convention off the records and
refuses to print one pooled figure across a corpus that encodes it two ways — quote a suite, or
quote the pair it prints.
