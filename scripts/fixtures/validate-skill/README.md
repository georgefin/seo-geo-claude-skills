# Fixture — `validate-skill.sh` branch corpus

The corpus behind `bash scripts/validate-skill.sh --probe`. It exists because on 2026-08-17 the
G3-C5 audit found this leg — the first one every skill edit passes through — with **zero**
occurrences of probe, selftest or fixture. Twenty skills were reported at 15/15/0 by an
instrument nobody had ever watched fail. Ledger F15's standing rule is that such an instrument is
not evidence of anything.

## Format

Directive header, then a separator line, then a verbatim `SKILL.md`:

    # CASE: <id>
    # ROLE: positive | negative | known-gap
    # DIR: <directory name the case is materialised into>
    # EXPECT-EXIT: 0 | 1
    # EXPECT-MATCH: <literal the output must contain>     (repeatable)
    # EXPECT-ABSENT: <literal the output must not contain> (repeatable, optional)
    # PAD-BODY: <n>        append n filler lines to the body (optional)
    # ADD-FILE: <relpath>  create an extra empty file in the skill dir (optional, repeatable)
    # NO-SKILL-FILE        write no SKILL.md at all (optional)
    # GAP: <one line>      required for ROLE: known-gap
    # WHY: <free prose>    optional, and used liberally
    # ---8<--- SKILL.md
    ---
    name: ...

`EXPECT-EXIT` alone is never enough and the probe refuses a case without an `EXPECT-MATCH`: a
right exit code for the wrong reason is how a probe stops measuring (F15-r3). Anything before the
separator that is neither a comment nor a known directive is a format error the probe reports
rather than skips — a case silently demoted to a comment would shrink the denominator.

## Roles

| role | meaning | count |
|---|---|---|
| `positive` | carries a defect; the check must report it | 21 |
| `negative` | looks like a defect, is legitimate; the check must stay quiet | 4 |
| `known-gap` | behaviour the check gets **wrong**, asserted so it is measured | 2 |

The negative controls are the expensive half. A leg that fires wrongly blocks every lane's push
and gets switched off, so `clean-legacy-lockstep` (a legal top-level `version:`),
`clean-openclaw-consistent` (a `primaryEnv` that is legitimately declared) and
`clean-single-letter-name` (the `^[a-z]$` branch) each pin a shape the check must **not** report.

## The two known gaps

Both are real, both are asserted at today's behaviour, and neither was fixed by the lane that
found them, because both are policy changes to a leg the push gate runs.

- `gap-body-360-lines` — this check WARNs at >400 body lines while its own message says
  "recommended: <350 lines" and `validate-tracking.sh` check (d) FAILs at >350. A body of 351–400
  lines is clean here and failed there.
- `gap-folded-description` — a YAML folded description (`description: >-`) is valid YAML and is
  measured as 2 characters, i.e. a **false positive** that would block a legitimate skill. The
  extractor is one line of grep, not a YAML parser.

If either is fixed, its case turns red and says so. That is good news arriving as a failure: move
the case, do not delete it.

## Branch mirror

The probe extracts every `fail "` and `warn "` call site from the script's own source and requires
each distinct message to be exercised by some case (13 of 13, 9 of 9 at the time of writing). A
branch added later without a fixture makes the probe fail rather than passing in silence —
F15-r4's lesson that a canary per family is not a canary per branch. Two warn branches share the
prefix `Skill body is ` and the mirror cannot separate them; the per-case `EXPECT-MATCH` lines do.
