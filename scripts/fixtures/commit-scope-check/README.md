# Fixture — `commit-scope-check.sh` synthetic commits

The corpus behind `bash scripts/commit-scope-check.sh --probe`. This leg caught the coordinator
four separate times in one day omitting a register from a commit subject, and until 2026-08-17 it
had no fixture directory at all — its only mention of fixtures was inside the F14 narrative that
motivated it.

## Why the fixtures are commits, not files

This check reads **commit messages and changed paths**. It never opens a file, so a corpus of
files could not exercise it. `--probe` builds a throwaway git repository under `$TMPDIR` and
**symlinks** the script into its `scripts/` directory: `ROOT` comes from `${BASH_SOURCE[0]}`,
which bash reports as the invocation path, so the symlinked run resolves its root to the temp
repo. Nothing is copied — a hand-kept copy is the drift defect this repo has already paid for
three times — and no history is rewritten anywhere.

The probe asserts `Repo root: <temp>` **before** reading any verdict. If root resolution ever
changes to `readlink -f`, the probe would silently start measuring the real repository and report
whatever today's branch happens to contain.

## Format

    # CASE: <id>
    # ROLE: positive | negative | known-gap
    # EXPECT-EXIT: 0 | 1
    # EXPECT-MATCH: <literal>              (repeatable)
    # EXPECT-ABSENT: <literal>             (repeatable, optional)
    # FILE: <path>                         (repeatable; created and committed)
    # BASE: <ref>                          (optional; default is the fixture base commit)
    # GAP: <one line>                      (required for ROLE: known-gap)
    # ---8<--- commit message
    <subject>

    <body>

A case with no `FILE:` line makes no commit — that is how `scope-no-outgoing-commits` reaches the
empty-range branch. Every case that **does** commit is checked against `no outgoing commits`
before its verdict is read: on this probe's first run the message file was being deleted by
`git clean` between cases, every commit silently failed, and all nineteen cases "passed" against
an empty range. That is the failure this whole script exists to catch, reproduced inside its own
probe on day one.

## What the corpus covers

| leg | positive | negative |
|---|---|---|
| register (`docs/loop/*.md`, `VERSIONS.md`) | undeclared ledger, undeclared VERSIONS.md | basename, alias-only (all ten registers), body-only |
| gate code (`scripts/*.sh`, `*.py`, `.claude/settings.json`) | the `71345f3` shape, a `.py` file, `settings.json` | named by basename |
| skill directory | one undeclared, named in body only, two skills with one named | named in subject, root-doc-only commit |
| scope | — | empty range, unresolvable base |

`gate-code-undeclared.txt` is the recorded F15 near-miss, kept as a case rather than a story: its
message says "gate" throughout (inside "gated-items"), so the leg's *first draft* — which accepted
a "gate" vocabulary — passed the very commit it was written for. Only the basename rule catches
it. If that case ever passes, the leg has been widened back to a vocabulary.

`register-alias-vocabulary.txt` names all ten registers by **alias only**, never by basename, so
one commit exercises all ten alias branches. Verify by hand before editing its subject: a basename
appearing there would make the case pass for the wrong reason.

## Three measured blind spots

Asserted as `known-gap` cases at today's behaviour, and reported rather than fixed — each is a
live behaviour change to a **gated** leg, and a leg that starts failing in-flight commits blocks
every lane's push.

- `gap-gate-allowlist-txt` — the gate leg matches `scripts/.*\.(sh|py)` only, so
  `scripts/claims-gate-allowlist.txt` (a file whose whole function is to widen what a gate
  accepts) and everything under `scripts/fixtures/` pass undeclared.
- `gap-register-subdirectory` — the register pattern is `docs/loop/[^/]+\.md`: one level, markdown
  only. `docs/loop/eval-baselines/*.json` and `docs/loop/pilot/*.md` are invisible.
- `gap-alias-substring` — aliases match as substrings of the whole message, and the
  settled-rulings list contains `r1`..`r5`. A subject reading "rename error1 to parse-error"
  satisfies a `SETTLED-RULINGS.md` edit, because `error1` contains `r1`.
