# Fixture — check (f)'s two allowlists

The corpus behind `bash scripts/validate-tracking.sh --probe`. It exists because three numbers
about check (f) were published on 2026-08-17 and none of them could be re-derived:

| claim | where | what it turned out to be |
|---|---|---|
| "fault-injected both ways — 6 of 6 violations caught" | commit message | corpus never saved |
| "old 7/17 → new 12/17, 0/9 false positives" | Mode A, OPEN-FINDINGS 92 | corpus never saved |
| "the same hazard … bounded too" (FID leg) | commit message | measured afterwards at 0/8 → 0/8 |

Each was honest work. None was checkable. A guard's catch rate is a claim like any other, and this
directory is that claim's evidence: the numbers are now a command, and the command names the lines
it could not catch.

## Files

| file | role | on failure |
|---|---|---|
| `r3-violations.txt` | 17 constructed FAQ-eligibility claims. **Frozen** — it is the denominator of a published number | any miss FAILS the probe |
| `r3-violations-extended.txt` | 10 further channels found while fixing, each declaring `CAUGHT` or `MISSED — reason` | an undeclared miss FAILS; a declared miss is printed as an OPEN HOLE |
| `r3-legitimate.txt` | 17 real lines from the live tree that the library **wants** | any one caught FAILS the probe |
| `fid-violations.txt` | 8 constructed live-FID lines, same declaration rules | same as above |
| `fid-legitimate.txt` | all 3 real FID lines in the tree | same as above |
| `r3-token-coverage.txt` | one bare violation per **top-level alternative of `R3_TOKENS`** — measures the TOKEN LIST, which nothing else here does | an unexercised alternative FAILS the probe; so does a line matching no token |
| `fid-token-coverage.txt` | the same for `DEPRECATED_TOKENS`, **case-sensitive** (that leg greps without `-i`) | same as above |

The two coverage files are separate from the violation corpora above because those corpora are
denominators of published numbers (17, and the 0/8 → 0/8 FID rate) and cannot grow without moving
a figure other records quote. These grow with the token list instead: `--probe` splits the live
token regex and demands a line per alternative, so a token added without one fails on the next
run. Added 2026-08-17, when that measurement found `serp accordion` and `Affiliate links
disclosed` reached by no line in any corpus — either could have been deleted from check (f) with
every probe, gate and canary staying green.

## Format

`# ` comment, `>>> ` datum (everything after the 4-character prefix is the line, verbatim,
including leading whitespace), `# EXPECT: MISSED — reason` applying to the next datum. Every file
declares `# COUNT: N` and the probe checks it: a datum silently demoted to a comment would shrink
a denominator, which is the exact failure this directory exists to prevent. Anything that is
neither comment nor datum is a format error and the probe says so rather than skipping it.

## Reading the probe

Four things it prints that are easy to walk past:

1. **DECLARED OPEN HOLES are still holes.** A declaration records a hole, it does not close one.
   They are printed on every run so nobody can read a PASS as "no violations escape".
2. **A declared miss that becomes CAUGHT fails the probe.** That is good news arriving as a
   failure: the guard got narrower and this register is now lying about it. Move the line into the
   caught set, do not delete it.
3. **Load-bearing.** With the excuse blanked, every legitimate line must fail. One that stays clean
   is passing because it lacks a token, not because the allowlist protected it — it measures
   nothing, and the probe would otherwise count it as evidence.
4. **Provenance is advisory.** The legitimate corpora are verbatim copies with `path:line`
   citations. The tree moves and the corpus is frozen on purpose, so `MOVED`/`GONE` is information,
   not failure. One entry was `GONE` within the hour it was written.

## Adding to it

New channel → `r3-violations-extended.txt`, never the frozen file. New marker → don't; the
direction is narrower excuses bound to the claim, and the per-member weight table the probe prints
shows how many live lines each marker is actually holding up. A marker at weight 0 carries nothing
today, which is the only kind of allowlist edit that goes in the safe direction.
