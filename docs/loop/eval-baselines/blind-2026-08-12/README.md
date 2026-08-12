# blind-2026-08-12 — layout note

Three blind runs landed on this date. The directory layout is not uniform, and that
is deliberate rather than untidy:

| suite | deliverables | grading |
|---|---|---|
| `entity-optimizer` | `deliverables/` | `entity.json` + `grading.json` + `grading/` |
| `schema-markup-generator` | `deliverables-schema/` | **not yet graded** |
| `content-gap-analysis` | `deliverables-content-gap/` | **not yet graded** |

`entity-optimizer`'s deliverables sit at the bare `deliverables/` because it landed
first and its committed grading record cites that path. Moving it would break a
pointer inside a record whose whole purpose is to be re-verifiable, so the later
runs took suffixed directories instead.

**Why the deliverables are here at all.** Every blind run before 2026-08-12 wrote
its deliverables to a session scratchpad, which is why not one of the 20 historical
records can be re-verified — the graded artefact is gone and cannot be recovered.
Ledger F16: a run is not complete until its record has a repo path. These are those
paths.

**Two of the three are ungraded and must be described that way.** Deliverables
without a grading are evidence that the work was done, not evidence that it was
good. Do not read an ungraded run as a passing one.

## Contamination status of these three runs

All three executors declared zero Grep and zero Glob calls and no banned-list opens.
Two made disclosures rather than concealing them: the schema executor `ls`-ed a
directory that displayed `evals.json` as a name (not opened), and the content-gap
executor read `references/core-eeat-benchmark.md`, which its brief had not named,
because an authorised file required a verbatim label from it.

⚠️ **A contamination channel these runs did NOT control for was discovered the same
day**: 23 fixture filenames across 8 suites named the defect planted inside them, so
every blind run in this library's history was blind to the expectations and not to
the traps. The renames landed in `4e70df9`. **`schema-markup-generator` and
`content-gap-analysis` were both verified clean of that defect before their runs
started**, so these two are unaffected — but the historical rates they will be
compared against are not.
