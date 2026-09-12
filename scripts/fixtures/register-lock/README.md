# Fixture — `register-lock.sh` ledgers and commits

The corpus behind `bash scripts/register-lock.sh --probe`. Until 2026-08-17 this leg — the second
F14 mechanism, and the one that decides whether an outgoing commit is blocked — had no fault
injection of any kind. Its header carried a four-line TENURE BOUNDS table that nothing checked.

## Journals carry OFFSETS, not timestamps

A lock ledger fixture cannot hold absolute times. Staleness is defined relative to *now*, so a
frozen timestamp would decay from live to stale to ancient over the life of the file and the
fixture would stop meaning what it says. Column 2 of every `journal-*.tsv` is a **signed offset in
seconds from now**, expanded at probe time:

    EVENT <TAB> OFFSET <TAB> HOLDER-OR-BREAKER <TAB> PATH [<TAB> VICTIM <TAB> REASON]

| journal | shape |
|---|---|
| `journal-live-two-holders.tsv` | lane-a holds a directory **prefix**, lane-b an exact file; both live |
| `journal-stale-open.tsv` | one tenure opened 3h ago, never released, past the 90m horizon |
| `journal-closed.tsv` | an acquire/release pair, for the `[acquire, release)` bound |
| `journal-broken-steal.tsv` | a live tenure **stolen**, bounded at the break |
| `journal-broken-stale.tsv` | a stale tenure **forced**, bounded at the horizon, not the break |
| `journal-archive-three-dates.tsv` | three rows exactly 86400s apart — the archive must file by each row's OWN date, not "today" |
| `journal-archive-same-day-later.tsv` | a second wave into a date already archived — append, never overwrite |
| `journal-archive-identical-rows.tsv` | two byte-identical rows — the measured dedup limit, not a defect to repair |
| `rawjournal-archive-unfilable-dates.tsv` | eight rows whose field 2 is not a date, incl. a path-traversal shape. **`rawjournal-` prefix, not `journal-`**: the offset loader rewrites column 2 into a timestamp, which would destroy the very malformation under test, so this one is copied verbatim |

The probe fails if a checked-in journal is used by no case: a ledger nobody runs is decoration.

## The bounds are asserted in pairs one second apart

Three of the four bounds in the script header are only distinguishable from a wrong reading by a
one-second difference, so each is a pair of cases that must land on **opposite** verdicts:

- `gate-boundary-one-second-before-release` FAILs and `gate-boundary-at-release-second` PASSes —
  the release second belongs to the released side.
- `gate-steal-inside-stolen-tenure` FAILs and `gate-steal-at-break-second` PASSes — which is what
  makes `acquire --steal`'s own promise ("the stolen tenure still counts against gate-check for
  commits made inside it") a checkable statement rather than help text.
- `gate-break-stale-bounded-by-horizon` PASSes at a moment **after the horizon and before the
  break**. It is the only case that separates "bounded by the horizon" from "bounded by the break
  time"; the two readings agree everywhere else.

## Case format

    # CASE / # ROLE / # JOURNAL / # COMMIT-AT / # FILE / # EXPECT-EXIT / # EXPECT-MATCH
    # EXPECT-ABSENT / # GAP / # WHY
    # ---8<--- commit message

`JOURNAL: NONE` runs with no ledger at all (the zero-friction branch). `COMMIT-AT` is an offset in
seconds from now, written into `GIT_COMMITTER_DATE`. A case naming a journal that does not exist
is a probe failure, not a skip — it would otherwise "pass" against an empty ledger.

## The lifecycle half

Twenty assertions drive the real CLI against a scratch journal, and the **refusals are asserted as
hard as the successes**: `--force` must not break a LIVE tenure, an unrelated path must not be
refused, `release` of something you never held must still exit 0. A lock that refuses everything is
as broken as one that refuses nothing, and only the second failure is obvious.

## Measured gaps — currently none

This section held `gap-bare-none-accepted` until **2026-08-18**. That case asserted the shipped
behaviour of a defect: the script header promised *"a bare `none` with no reason is NOT accepted"*
and it **was** accepted, because `sed 's/^[^-]*--…'` can never reach the `--` past the hyphen in
"Register-Lock" itself. **Ruling M3 fixed it and the fixture flipped** to
`gate-bare-none-rejected.txt`, which asserts the opposite. That flip is the point of a known-gap
case: it turns red the moment the gap closes, and the red is the evidence the fix landed.

The probe now reports `0 known-gap`. If you add one, add it here in the same shape — what is
promised, what actually happens, and why it was not fixed by the lane that found it.

## Limits that are asserted rather than fixed

Distinct from a known gap: these are behaviours ruled *acceptable*, held by cases so they turn red
if they silently change.

- **The date guard is a 10-character shape glob, not a calendar** — `9999-99-99` files happily.
  Tightening it would make the archive drop *more* rows in silence, which is worse for a tool whose
  only job is that rows do not disappear, and a junk file is loud in gate leg 6.
- **Dedup is byte equality**, so two genuinely distinct events that serialise identically become one
  row. Reachable rather than theoretical: `release` archives at wave end, so acquire/release/acquire
  inside one clock second produces it. Asymmetric, too — both rows survive when archived in the same
  run. The repair is a row-format change, i.e. a contract decision.

## The archive directory is never covered by a tenure (ruling M4, 2026-08-18)

`gate-archive-dir-never-locked` asserts it, and it pairs with `gate-inside-tenure-undeclared`, which
uses the **same** journal and the **same** `docs/loop/` prefix lock on a non-archive file and must
still FAIL. Only the pair separates "the archive is carved out" from "the prefix branch stopped
working."

Before the carve-out, a lane holding `docs/loop/` held `docs/loop/register-locks-archive/` with it,
so the commit gate **leg 6 requires** was the commit **leg 5 refuses** — two legs deadlocked,
measured in a temp repo rather than argued. The carve-out is about what the directory *is*: nobody
authors an archive row, `do_archive` copies them mechanically out of the journal, so there is no
author's hunk to sweep and F14's defect cannot occur there. The rejected alternative was routing it
through `Register-Lock: none`, which asserts *"no holder's content rides in this commit"* — **false**
for an archive commit, where the holder's rows are exactly what is being committed.

