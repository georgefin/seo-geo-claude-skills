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

## One measured gap

`gap-bare-none-accepted` — the script header states *"A bare `none` with no reason is NOT
accepted"*. It is accepted. The reason is extracted with `sed 's/^[^-]*--[[:space:]]*//'`, and
`[^-]*` can never reach the `--` because "Register-Lock" carries a hyphen first, so the
substitution never fires and the whole trailer line becomes the "reason". The case asserts the
behaviour that ships and prints the untouched trailer as its evidence. It was not fixed by the
lane that found it: this repo's own history writes the trailer with an **em dash**
(`Register-Lock: none — new directory, no shared register`), so requiring `--` would reject the
form actually in use, and choosing between them is a contract decision, not a typo repair.
