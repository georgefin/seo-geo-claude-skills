#!/usr/bin/env bash
# eval-expectation-sweep.sh — run the deprecated-token sweep over eval EXPECTATIONS,
# which validate-tracking check (f) cannot see.
#
# WHY THIS EXISTS (2026-08-13, content-refresher).
# check (f) sweeps `research build optimize monitor cross-cutting commands references`
# and pipes the result through `grep -v 'evals/'`. On 2026-08-13, three `expectations`
# entries and two `expected_output` fields in
# `optimize/content-refresher/evals/evals.json` REQUIRED a claim this library had
# just retracted across nine files — the graders demanded "Google retired FAQ rich
# results in 2026" and "kept for AI-engine/GEO parsing only". A skill corrected to
# the sourced position would have FAILED ITS OWN EVAL FOR BEING RIGHT. That is F13's
# shape at suite level: the rule stated in one place and enforced against the
# opposite elsewhere. The retracted claim survived longest in the one place the
# sweep was told not to look.
#
# THE EXCLUSION IS RIGHT FOR FIXTURES AND WRONG FOR EXPECTATIONS.
# A fixture under `evals/files/` is DELIBERATELY a bad page — stale dates, dead
# claims, broken links — because catching them is what the skill is graded on.
# Sweeping fixtures would fire on every defect they were built to contain. An
# expectation is not a page: it is a RULE, in the same normative voice as the skill,
# and a stale rule is a stale rule wherever it is written. So this script reads the
# expectation fields and never opens `evals/files/**`.
#
# HOW THE FIXTURE/RULE DISTINCTION IS HANDLED — the thing that makes this guard
# useful or useless, stated plainly.
# An expectation legitimately QUOTES the fixture's bad claim in order to require
# that the model catch it. content-refresher e1 does exactly that: «the article's
# claim that 'Google displays FAQ rich results as expandable questions right in the
# SERP' is flagged as no longer true». Grepping the file whole cannot tell that from
# the same words asserted as a rule, so this script does not grep the file at all —
# it parses the JSON, then classifies every token hit by ROLE:
#
#   RULE  — the hit is in the expectation's own voice. Legal only if a denial or an
#           evidence qualifier sits NEAR it (the marker sets below, same design as
#           check (f)'s R3_LEGAL). Otherwise FAIL.
#   QUOTE — the hit is entirely inside a quoted span ('…', "…", «…», `…`) AND a
#           detection verb (flagged, caught, corrected, identified, fails, must not,
#           defect, stale, fixture, no longer) sits just outside that span. That is
#           fixture text the model is graded on catching. PASS.
#   AMBIGUOUS — quoted, but with no detection verb near it. The script cannot tell
#           whether the suite is quoting a page or restating a rule, and it says so:
#           WARN, listed, never silently passed and never failed. Guessing in either
#           direction would make the census a lie.
#
# "NEAR", not "anywhere in the sentence", and the change is load-bearing — see MISS B
# below. A sentence here is routinely an 800-character comma-spliced paragraph
# covering six subjects, so sentence scope let a qualifier written about one claim
# excuse a different one. Every marker test in this script is bounded by PROXIMITY.
#
# The `prompt` field is NOT swept. It is the user's message — the fictional client
# who believes the stale thing — and sweeping it would fail suites for having a
# realistic premise. `files` is a path list. Everything else in the record is either
# expectations[] or expected_output.
#
# TOKEN CLASSES, AND WHY TWO OF THEM ARE NEW.
# Classes (f1)-(f3) ARE check (f)'s own patterns — read out of
# `scripts/validate-tracking.sh` at run time via `--emit-f-patterns`, never copied
# (OPEN-FINDINGS 100; see "WHERE (f1)-(f3) COME FROM" at the class block below).
# Classes (e1)-(e2) exist because a VERBATIM extension of check (f)
# would NOT have caught the 2026-08-13 instance, and that is worth recording:
# check (f)'s R3_LEGAL allowlist contains `retired|retirement`, so the sentence
# "Google retired FAQ rich results in 2026" is EXEMPT from (f) by construction —
# the allowlist blesses the exact claim `r3-supersession-candidate.md` §4 lists as
# U1, the unsourced one. That is the B2 pattern again (a marker that is its own pass
# condition), one allowlist widening later.
#
# (e1) and (e2) do NOT rule on whether the 2026 retirement happened. R3 still says it
# did, R3 is settled, and this script has no standing to contradict a ruling. They
# require only that the claim TRAVEL WITH THE GRADE ITS OWN RULING GIVES IT: R3's
# evidence clause says snippet-grade, not owner-read, and amendment 9a says in terms
# that the AI-parsing rationale "has no primary source either way". An eval that
# demands the bare assertion is demanding more confidence than the ruling has. Every
# qualifier below is therefore a statement about EVIDENCE, not about Google — vetted
# against the B2 rule, which is what an allowlist entry now costs.
#
# WHY THE QUALIFIER SET IS SPLIT IN TWO — and it is the B2 rule again, found by probe.
# The first draft had ONE qualifier list, and it contained `ruling r3`. That marker is
# right for (e1) and wrong for (e2), and the difference is written in 9a itself:
#   * (e1) is the 2026 DATE. R3's Statement still asserts it, at a grade R3 states.
#     An expectation that writes "…retired in 2026 (settled ruling R3)" has named the
#     warrant, and the warrant exists. `ruling r3` is a legal qualifier here.
#   * (e2) is the AI-PARSING RATIONALE. 9a withdrew R3's warrant from exactly this
#     clause: "No primary source supports that clause, and none refutes it … **A skill
#     may say FAQPage is valid and cheap to keep. It may not say it earns AI
#     citations.**" So citing R3 does not license an AI-parsing benefit claim — and a
#     `ruling r3` marker in the (e2) set is a marker that IS its own pass condition,
#     the B2 failure mode verbatim.
# This was not reasoned out in advance; it was found by running the guard against
# `a76706d^`, the actual pre-fix content-refresher suite, where `(ruling R3)` sitting
# 36 characters from "for AI-engine/GEO parsing only" silently exempted one of the
# five defective fields. See PROBE 1 below.
#
# ANTI-VACUITY (F15, and it recurred on 2026-08-13 inside a fix for something else).
# A sweep whose regexes have rotted reports a clean tree. Every class below carries a
# CANARY string it MUST match; if any class fails its own canary the script FAILS
# without judging the corpus. It also fails when it finds no suites, parses no
# expectation fields, or when an `evals.json` exists in the tree that the category
# glob never reached (check (3) — a smaller corpus that still looks like an answer).
#
# THE CLASSIFIER GETS CANARIES TOO, and that is the hole that mattered.
# The token classes were canaried from the start; `classify()` was not. That is the
# silent direction of F15: if QSPAN or DETECT rot so that everything classifies as
# QUOTE, every hit is exempted and the script prints PASS having judged nothing. The
# token canaries cannot see this, because they never run through the classifier.
# Check (0) now asserts a known RULE string classifies RULE, a known quoted-fixture
# string classifies QUOTE, and the apostrophe case below classifies RULE.
#
# WHAT FAULT INJECTION CHANGED (2026-08-17). The guard was run against `a76706d^` —
# the real defective suite, not a mock-up. It fired, but on only 2 of the 5 fields
# that carried the retracted claim. The three misses were three unrelated bugs, and
# each is now a check (0) canary so it cannot come back:
#
#   MISS A — PHANTOM QUOTE SPANS FROM POSSESSIVE APOSTROPHES. `'[^']{4,}'` treats the
#     apostrophe in "the fixture's single Article block" as an opening quote, so the
#     span ran from `fixture's` to the next apostrophe and swallowed the rule text
#     between them. The hit classified QUOTE and was exempted in silence. English
#     prose is full of possessives, so this was not an edge case: it was a standing
#     false-negative channel through the middle of the guard. QSPAN's single-quote
#     arm now requires a non-letter on the outside of both delimiters.
#
#   MISS B — A LEGAL MARKER 200 CHARACTERS AWAY, ABOUT A DIFFERENT CLAIM. These
#     fields are 800-character comma-spliced paragraphs. The qualifier "in either
#     direction" — written about HowTo abstention under W12 — sat in the same
#     "sentence" as the FAQ claim and exempted it. That is F15-r1's shape exactly
#     ("the ban and its context sat 45 lines apart"), at paragraph scale. Markers are
#     now required within PROXIMITY characters of the token. The number was measured,
#     not chosen: across 30 marker/token pairs in the live corpus plus `a76706d^`,
#     every genuine pairing landed at 0-64 characters and the two accidental ones at
#     142 and 204/216. 120 is the rounded midpoint of that gap. It is a sample of 30
#     and it will need revisiting if the register's sentence style changes.
#
#   MISS C — the `ruling r3` qualifier on (e2), described above.
#
# And two NOISE defects, found by reading the live output rather than the probe:
#   NOISE A — `sentences()` split on `:`, which in this register is a label separator
#     ("per settled ruling R3: …", "Labels and headers are not claims: …"). The split
#     severed three qualifiers from their claims and produced two findings that were
#     fragments beginning mid-clause. Splitting on `:` is now gone for the same reason
#     the docstring already gave for em dashes. `e.g.`/`i.e.` are protected too — the
#     period inside them was orphaning the rest of the clause.
#   NOISE B — (f2) fired on "Validation guidance points to the Schema.org validator,
#     not Google's Rich Results Test or Search Console FAQ reports" — a line that
#     DENIES the eligibility route, flagged for containing the words it denies. That
#     is the mistake check (f)'s 2026-08-11 note records three times over. Marker
#     added, vetted per B2: it endorses only "the Rich Results Test is not the FAQ
#     route", which is R3's own sourced position.
#
# WHAT THIS GUARD CANNOT SEE — read this before trusting a clean run.
#   1. It is a TOKEN sweep, not a reader. It knows five claim shapes. An expectation
#      that requires a retracted claim this library has not yet given a token class
#      passes silently. The classes are the vocabulary of R3 and R4; nothing else.
#   2. It cannot check that a cited ruling SAYS what the expectation says it says.
#      `ruling r3` exempts an (e1) hit, and the guard has no way to tell 9a's
#      corrected phrasing ("ended", plus the 2023-08-08 narrowing) from the
#      superseded one ("retired in 2026") that 9a says hid an earlier event. This is
#      the citation-divergence defect one level down, and the sibling guard
#      `citation-divergence-check.sh` does not reach eval suites either. A live
#      instance is in the report that shipped with this script.
#   3. The AMBIGUOUS bucket is a real gap, not a formality: a quoted token with no
#      detection verb near it is reported and judged by a human. If nobody reads the
#      WARNs, that bucket is where a defect hides.
#   4. It reads `expectations[]` and `expected_output` only. A retracted claim in a
#      `prompt` is by design not a defect (the fictional client is allowed to believe
#      stale things), but a retracted claim in a suite field this script does not know
#      about — a schema addition — is invisible until check (3) or the field census
#      notices the shape changed.
#   5. It never opens `evals/files/**`, so it says nothing about fixtures. That is
#      deliberate and is the whole reason check (f) excluded `evals/` in the first
#      place; it is also a blind spot by construction.
#   6. THE CANARIES PROVE A CLASS STILL FIRES, NOT THAT EVERY ALTERNATIVE IN IT DOES.
#      Each class is canaried through ONE of its alternatives. Mutation-testing on
#      2026-08-17 deleted `expandable q&a below` from (f2) and every check stayed
#      green, because nothing in the canaries or the fixtures exercises that branch.
#      Measured honestly: 5 classes are canaried, ~20 alternatives exist across them,
#      so a silent deletion inside a class is detectable for the canaried alternative
#      only. Adding a canary per alternative is the fix; it has not been done.
#
# Usage:   scripts/eval-expectation-sweep.sh [repo-root]
#          scripts/eval-expectation-sweep.sh --suite <path/to/evals.json>   (single suite)
#          scripts/eval-expectation-sweep.sh --probe [repo-root]
#              Fault injection, four corpora, exit codes asserted rather than eyeballed:
#              the two checked-in fixtures, plus the two synthetic suites that measure the
#              IMPORT (the substring escape that must be reported, the corrected line that
#              must not be). Prints a transcript and FAILS if any of them lands wrong.
# Exit:    0 = pass (warnings allowed), 1 = any FAIL, 2 = usage/setup error
# No network. Dependencies: bash, python3, scripts/validate-tracking.sh (pattern source).

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUITES=()
PROBE=0

while [ "$#" -gt 0 ]; do
    case "$1" in
        --suite)
            [ "${2:-}" ] || { echo "ERROR: --suite needs a file" >&2; exit 2; }
            SUITES+=("$2"); shift 2 ;;
        --probe)
            PROBE=1; shift ;;
        -h|--help)
            # Print the whole header block, not a fixed line range: the range in the
            # first draft stopped at 60 and the header had grown past 130, so --help
            # truncated mid-sentence inside the token-class explanation.
            sed -n '2,/^# No network\./p' "${BASH_SOURCE[0]}"; exit 0 ;;
        *)
            [ -d "$1" ] || { echo "ERROR: repo root '$1' is not a directory" >&2; exit 2; }
            ROOT="$(cd "$1" && pwd)"; shift ;;
    esac
done
for s in "${SUITES[@]:-}"; do
    [ -z "$s" ] && continue
    [ -f "$s" ] || { echo "ERROR: suite file not found: $s" >&2; exit 2; }
done

# --- IMPORT check (f)'s patterns (OPEN-FINDINGS 100) ------------------------
# Classes (f1)-(f3) used to be a hand-copy of check (f)'s pattern strings, kept in step by a
# comment that said "keep them copied". It did not hold. When 8f69a7a word-bounded the generic
# R3 markers, this file kept the unbounded spelling, and on 2026-08-17 the sentence
#   "The FAQPage block is eligible for FAQ rich results, as recommended in the brief."
# was CAUGHT by check (f) and EXEMPTED here — `ended` is a substring of *recommended*. Third
# instance of the class in this repo. So there is now ONE source and this is its importer.
#
# NO FALLBACK ON PURPOSE. If the source is missing or short, this script exits 2 without judging
# the corpus. A guard that degrades to a stale local copy when its source is unavailable is the
# defect with a safety belt on: it would keep printing PASS while measuring the wrong patterns.
VT="$ROOT/scripts/validate-tracking.sh"
if [ ! -f "$VT" ]; then
    echo "ERROR: pattern source not found: $VT" >&2
    echo "       Classes (f1)-(f3) are check (f)'s patterns, read from it at run time." >&2
    echo "       There is deliberately no local copy to fall back on (OPEN-FINDINGS 100)." >&2
    exit 2
fi
if ! F_PATTERNS="$(bash "$VT" --emit-f-patterns "$ROOT")"; then
    echo "ERROR: \`$VT --emit-f-patterns\` failed; classes (f1)-(f3) cannot be built and the" >&2
    echo "       corpus was NOT judged. Fix the pattern source, do not re-copy the patterns." >&2
    exit 2
fi
if [ -z "$F_PATTERNS" ]; then
    echo "ERROR: \`$VT --emit-f-patterns\` printed nothing — an empty import would leave every" >&2
    echo "       (f)-class matching nothing and this sweep printing PASS over an unread corpus." >&2
    exit 2
fi
export F_PATTERNS

# --- --probe: fault injection, exit codes asserted --------------------------
# F15: a probe that has never been shown failing is worth nothing. Each case below has been run
# with the guard deliberately broken. Cases 3 and 4 are the ones that measure the IMPORT: case 3
# is the exact sentence the hand-copy exempted, so re-pasting the fossil member turns it red.
if [ "$PROBE" -eq 1 ]; then
    SELF="${BASH_SOURCE[0]}"
    ptmp="$(mktemp -d)"; trap 'rm -rf "$ptmp"' EXIT
    probe_fail=0
    echo "eval-expectation-sweep --probe : fault injection over four corpora"
    echo "Pattern source: $VT --emit-f-patterns ($(printf '%s\n' "$F_PATTERNS" | grep -c '.') names)"
    echo ""

    # Case 3 corpus — the substring escape. `ended` inside *recommended* excused this sentence
    # here for as long as the copy existed, while check (f) failed the identical line.
    cat > "$ptmp/escape.json" <<'JSON'
{"skill_name": "probe-escape", "evals": [{"id": "p1", "prompt": "x",
 "expected_output": "The report confirms the page is eligible for FAQ rich results, as recommended in the brief.",
 "expectations": ["The FAQPage block is eligible for FAQ rich results, as recommended in the brief."]}]}
JSON
    # Case 4 corpus — the corrected line, in the register the library actually writes. It must
    # stay clean, or the guard punishes the author who fixed the claim (check (f)'s recorded
    # lesson, four times over).
    cat > "$ptmp/corrected.json" <<'JSON'
{"skill_name": "probe-corrected", "evals": [{"id": "p1", "prompt": "x",
 "expected_output": "An ordinary site gets no FAQ rich result; government/health only since 2023-08-08.",
 "expectations": ["The response states that FAQ rich results ended for ordinary sites, so no FAQ rich result is promised."]}]}
JSON

    probe_case() {   # <label> <expected-exit> <suite path> [grep that output must contain]
        label="$1"; want="$2"; suite="$3"; must="${4:-}"
        out="$(bash "$SELF" --suite "$suite" 2>&1)"; got=$?
        if [ "$got" -ne "$want" ]; then
            echo "  PROBE FAIL  $label — expected exit $want, got $got"
            printf '%s\n' "$out" | sed 's/^/      | /' | head -12
            probe_fail=1
            return
        fi
        if [ -n "$must" ] && ! printf '%s\n' "$out" | grep -q "$must"; then
            echo "  PROBE FAIL  $label — exit $got was right but the output never says \"$must\";"
            echo "              a right exit code for the wrong reason is how a probe stops measuring"
            printf '%s\n' "$out" | sed 's/^/      | /' | head -12
            probe_fail=1
            return
        fi
        n_fail="$(printf '%s\n' "$out" | grep -c '^FAIL')"
        echo "  ok          $label — exit $got, $n_fail FAIL line(s)"
    }

    probe_case "stale fixture must be reported     " 1 \
        "$ROOT/scripts/fixtures/eval-expectation-sweep/stale/evals.json" "^FAIL: (f2)"
    probe_case "correct fixture must stay clean    " 0 \
        "$ROOT/scripts/fixtures/eval-expectation-sweep/correct/evals.json"
    probe_case "IMPORT: substring escape reported  " 1 "$ptmp/escape.json" "^FAIL: (f2)"
    probe_case "IMPORT: corrected line stays clean " 0 "$ptmp/corrected.json"

    # The self-test is the always-on half: it holds the derivation parity assertions, so a
    # member edited downstream, an unbounded `.*` surviving the transform, or a re-pasted copy
    # fails HERE on every ordinary run, not only under --probe.
    st="$(bash "$SELF" --suite "$ROOT/scripts/fixtures/eval-expectation-sweep/correct/evals.json" 2>&1 | grep '(0)')"
    if printf '%s\n' "$st" | grep -q '^PASS: (0)'; then
        echo "  ok          self-test (0), including derivation parity and the import canaries"
    else
        echo "  PROBE FAIL  self-test (0) is not passing:"
        printf '%s\n' "$st" | sed 's/^/      | /'
        probe_fail=1
    fi

    echo ""
    if [ "$probe_fail" -eq 0 ]; then
        echo "PROBE PASS — all four corpora landed on their declared exit code."
        exit 0
    fi
    echo "PROBE FAILED"
    exit 1
fi

python3 - "$ROOT" "${SUITES[@]:-}" <<'PY'
import json, os, re, sys, pathlib

root = pathlib.Path(sys.argv[1])
explicit = [pathlib.Path(p) for p in sys.argv[2:] if p]

PASS_N = FAIL_N = WARN_N = 0
def pas(m):
    global PASS_N; PASS_N += 1; print("PASS: " + m)
def fail(m):
    global FAIL_N; FAIL_N += 1; print("FAIL: " + m)
def warn(m):
    global WARN_N; WARN_N += 1; print("WARN: " + m)
def ev(m):
    print("      " + m)

CATEGORIES = ("research", "build", "optimize", "monitor", "cross-cutting")

# --- token classes ---------------------------------------------------------
# (token regex, legal-marker regex, canary that MUST match, canary that must NOT)
# The (f1)-(f3) rows are copied from scripts/validate-tracking.sh check (f). Keep
# them copied, not re-invented: when (f) widens, widen here in the same commit, and
# the canaries below will tell you if a paste went wrong.
#
# NEG is the shared "this expectation is REQUIRING THE ABSENCE of the token" set,
# and every phrase in it was added against a real expectation this sweep first got
# wrong: «nothing in the response treats FID as a live metric», «identified as dead
# sensors», «no FID», «The response nowhere claims the markup is eligible…», «FAQPage
# suggestion framed with no SERP promise». All five are the CORRECT rule, and a guard
# that fails the correct rule is the mistake check (f)'s 2026-08-11 note is about —
# three times over there, once here. Kept narrow on purpose: a bare `\bnot\b` would
# exempt nearly every expectation in the corpus and leave an F15 guard that passes by
# matching nothing.
NEG = (r"nothing in the response|nowhere (claims|states|promises|instructs)|"
       # 2026-08-17: generalised from an enumerated verb list to any negated verb.
       # The negative-control fixture failed on «The response does not SEND the user to
       # the FAQ eligibility report (settled ruling R3)» — a line this library wants
       # written, rejected because `send` was not on a list of nine verbs. That is
       # check (f)'s recorded lesson for the fourth time ("three times now the most
       # accurate lines in the repository have been the only ones this guard
       # rejected"), and the repo's own standing instruction is to widen the list
       # rather than narrow the prose.
       #
       # THE COST, STATED. This is wider than a verb list and narrower than the bare
       # `\bnot\b` the original note rejected. It exempts a contrived double negative
       # ("the response does not stop at listing; it confirms the page is eligible for
       # FAQ rich results") when the two clauses sit inside the same PROXIMITY window.
       # Nothing in the corpus is shaped like that today. The proximity bound is what
       # keeps the exposure to one clause rather than one paragraph.
       r"(does|do|did|must|will|shall|should|may) not \w+|"
       r"must not|never|no longer|"
       r"is not (a )?(live|current)|dead (metric|sensor|signal)|as dead|\bno fid\b|"
       r"without fid|zero fires|\bfails\b|flag\w*|caught|catch|correct\w*|identif\w*|"
       r"marked for|stale|outdated|fixture|retracted|withdraw\w*|"
       # 2026-08-17: the "labels are not claims" carve-out. schema-markup-generator
       # e3 x[6] states the rule «Labels and headers are not claims: a table header …
       # (e.g. a status-table row labeled "FAQ rich results") does not count» — a
       # meta-rule about what counts as a claim, which the guard reported as an
       # AMBIGUOUS token. Safe under B2: it asserts nothing about Google, only about
       # the grading. It cannot rescue a stale DATE or BENEFIT claim, because (e1) and
       # (e2) do not use NEG.
       r"(are|is) not (a |an )?claims?\b|does not count\b|"
       r"no serp (promise|feature|claim)")

# --- WHERE (f1)-(f3) COME FROM (OPEN-FINDINGS 100) --------------------------
# Imported from scripts/validate-tracking.sh check (f) through `--emit-f-patterns`, parsed here.
# The importer in the bash half above exits 2 rather than fall back to a copy; this half fails
# rather than build a class out of a missing name. Between them there is no path on which a
# (f)-class quietly becomes something other than what check (f) enforces.
SRC = {}
for _line in os.environ.get("F_PATTERNS", "").splitlines():
    if "\t" in _line:
        _k, _v = _line.split("\t", 1)
        SRC[_k] = _v
REQUIRED = ("DEPRECATED_TOKENS", "DEPRECATED_LEGAL_NAMED", "DEPRECATED_LEGAL_NEAR",
            "R3_TOKENS", "R3_LEGAL_NAMED", "R3_LEGAL_NEAR", "R3_OVERSTATE")
_missing = [k for k in REQUIRED if not SRC.get(k)]
if _missing:
    print("FAIL: (0) pattern import is short — validate-tracking.sh --emit-f-patterns did not "
          "carry: " + ", ".join(_missing))
    print("      Classes (f1)-(f3) cannot be built. The corpus was NOT judged, and no local copy "
          "of these patterns exists to fall back on (OPEN-FINDINGS 100).")
    sys.exit(1)


def alternatives(pattern):
    """Split a regex on its TOP-LEVEL `|` — depth-aware, because members carry their own groups."""
    out, depth, cur = [], 0, ""
    for ch in pattern:
        if ch == "(":
            depth += 1
        elif ch == ")":
            depth -= 1
        if ch == "|" and depth == 0:
            out.append(cur)
            cur = ""
        else:
            cur += ch
    out.append(cur)
    return [a for a in out if a]


# THE ONE TRANSFORM APPLIED TO AN IMPORTED PATTERN, and why it is mechanical rather than manual.
# check (f) greps MARKDOWN LINES: `.` never crosses a newline and a line is ~85 characters, so
# `faq.*rich-result` can only ever span one line's worth. Here the same regex runs over
# 800-character sentences, where `.*` is greedy across whole clauses — on the negative-control
# fixture it matched «FAQ rich results as expandable questions right in the SERP' is flagged as n»,
# a span that STARTS INSIDE a quotation and ENDS OUTSIDE it. classify() asks whether a match is
# contained in a quoted span, so a match straddling the closing quote can never be classified
# QUOTE: the fixture/rule distinction switches off for the commonest token shape.
#
# So the imported token regex is bounded — but by CODE, with assertions, not by a second copy
# somebody edits. `.*` becomes a non-greedy 60-character run that cannot cross a quote delimiter,
# and any class that already excludes sentence enders also excludes quote delimiters. If check (f)
# ever grows a construct this does not know how to bound, check (0) says so and the sweep stops.
_Q = r"'\"«»`“”"


def quote_bound(tok):
    return tok.replace(".*", "[^%s]{0,60}?" % _Q).replace("[^.|]", "[^.|%s]" % _Q)


# --- (f1)/(f2)/(f3): imported, plus this file's own SEPARATELY NAMED extras --
# The extras are not edits to imported members — they are a second set, unioned in, so the derived
# half stays byte-comparable to the export and check (0) can assert that. Each extra exists
# because an EXPECTATION says a true thing in a register skill prose does not use.
#
# (f1) extras: an expectation routinely describes the correction rather than performing it
# ("the LCP-2.0/FID line corrected to INP <=200 ms"), which check (f) never has to allow.
SWEEP_F1_EXTRA = r"corrected to|inp[- ]only|instead of|rather than"
# (f2) extras: NOISE B (2026-08-17) — "Validation guidance points to the Schema.org validator, NOT
# Google's Rich Results Test or Search Console FAQ reports" is a line that DENIES the eligibility
# route and was flagged for naming what it denies. Vetted per B2: the marker endorses only "the
# Rich Results Test is not the FAQ route", which is R3's own sourced position. The Schema.org
# validator was NOT added — that would endorse a claim about a tool R3 does not source.
SWEEP_F2_EXTRA = (r"promis\w* no|no serp feature|"
                  r"not (google'?s? )?(rich results? test|search console)")

DERIVED_F1_LEG = SRC["DEPRECATED_LEGAL_NAMED"] + "|" + SRC["DEPRECATED_LEGAL_NEAR"]
DERIVED_F2_LEG = SRC["R3_LEGAL_NAMED"] + "|" + SRC["R3_LEGAL_NEAR"]

F1_TOK = SRC["DEPRECATED_TOKENS"]
F1_LEG = DERIVED_F1_LEG + "|" + SWEEP_F1_EXTRA + "|" + NEG
F2_TOK = quote_bound(SRC["R3_TOKENS"])
F2_LEG = DERIVED_F2_LEG + "|" + SWEEP_F2_EXTRA + "|" + NEG
F3_TOK = SRC["R3_OVERSTATE"]
F3_LEG = r"(?!x)x"          # never legal: Google made no such recommendation (B2, 2026-08-13)

# (e1) the unsourced 2026 FAQ-ending date, asserted with no evidence qualifier.
#
# THE VERB LIST IS DELIBERATELY WIDER THAN THE ONE THE INCIDENT USED. The founding
# instance said "retired". The live corpus says "cut" — alert-manager e2 x[2]
# ("Google cut FAQ rich results … in 2026") and schema-markup-generator e3 x[8]
# ("both were cut for FAQ in 2026") — and R3's own 9a text says "Softened from 'cut'".
# A class keyed to the founding instance's single verb is F15's founding shape, so
# every verb this library has actually used for the event is here, plus the obvious
# neighbours. CONTEXT["e1"] keeps the wide verb list from firing on unrelated 2026
# dates (a rank log "ends at 2026-08-03" is not a claim about a search feature).
# The em dash in the second alternative is a SUBJECT BOUNDARY, and leaving it out
# produced the one piece of pure noise in the first live run. alert-manager e2 x[2]
# reads «…in 2026 — the log's zero fires since early 2026 confirm the sensor is dead —
# so the alert is removed». `2026 … removed` matched, but "removed" is what the
# operator does to THEIR OWN ALERT, not what Google did to a search feature. The
# sentence's actual Google claim ("Google cut FAQ rich results … in 2026") does not
# match at all, so the guard reported a real defect's neighbour and pointed at the
# wrong words — the sort of hit that teaches a reader to stop reading the output.
# A claim and its own verb do not straddle an em dash in this register; a legal
# marker does (see sentences()), which is why the dash is excluded here and nowhere
# else.
E1_TOK = (r"(retire|retired|retirement|ended|ends|dropped|drops|removed|cut|cuts|"
          r"kill\w*|sunset|switched off|turned off|withdrew|withdrawn|"
          r"discontinued)[^.;—–]{0,60}\b2026\b|\b2026\b[^.;—–]{0,60}"
          r"(retire|retired|retirement|ended|dropped|removed|cut|kill\w*|sunset|"
          r"switched off|turned off|withdrew|withdrawn|discontinued)")
# (e2) the AI-parsing/citation rationale R3 amendment 9a says has no primary source.
E2_TOK = (r"(ai[- ]engine|geo|ai)[-/ ]?(engine)?[^.;]{0,20}pars\w*|"
          r"earns? (ai )?citations?|for ai[- ]engine")

# Qualifiers legal for (e1)/(e2). EVERY ONE IS A STATEMENT ABOUT EVIDENCE, not about
# Google — an allowlist marker is an assertion the guard endorses (B2), and "this
# claim's evidence is thin" is an assertion this library can source from R3 itself.
QUAL_EVIDENCE = (r"\[verify|unverified|unsourced|not owner-read|snippet-grade|snippet grade|"
                 r"no primary source|no benefit claimed|neither .{0,40}nor|amendment 9a|"
                 r"supersession|in either direction|unestablished|scheduled|"
                 r"grade:|not for any|promises? nothing|takes no position|abstain")
# Naming the ruling that carries the claim is itself an evidence statement — but only
# where the ruling still carries it. See the header: 9a withdrew R3's warrant from the
# AI-parsing clause in terms, so this marker belongs to (e1) and NOT to (e2). Probing
# `a76706d^` is what found this; with `ruling r3` in both sets the guard missed one of
# the five defective fields in the very commit it was written to catch.
QUAL_R3CITE = r"\bruling r3\b|\(r3\)|per r3\b|r3 amendment"
QUAL_E1 = QUAL_EVIDENCE + "|" + QUAL_R3CITE
QUAL_E2 = QUAL_EVIDENCE

# CONTEXT: a second pattern the SENTENCE must also match before a hit counts —
# grep-AND, the same construction check (f) uses for its R3-overstatement class and
# for the same reason. Without it, (e1)'s date pattern fired on «the log ends at
# 2026-08-03» in rank-tracker, an expectation about a rank log with no relation to
# FAQ or to any Google claim. A guard whose first live run is mostly noise is a guard
# somebody turns off.
CONTEXT = {
    "e1": re.compile(r"faq|rich[- ]result|rich results test|search appearance", re.I),
    "e2": re.compile(r"faqpage|markup|schema|structured data", re.I),
}

CLASSES = [
    ("f1", "deprecated metric token (check (f) parity)", F1_TOK, F1_LEG,
     "the page still reports FID as a Core Web Vital",
     "the LCP-2.0/FID line corrected to LCP <=2.5 s and INP <=200 ms"),
    ("f2", "FAQ rich-result eligibility claim (R3, check (f) parity)", F2_TOK, F2_LEG,
     "the plan promises FAQ rich results in the SERP",
     "an ordinary site gets no FAQ rich result, government/health only since 2023-08-08"),
    ("f3", "R3 overstatement: a permission shipped as a recommendation", F3_TOK, F3_LEG,
     "Google advises against removing FAQPage markup",
     None),
    ("e1", "unsourced 2026 FAQ-ending date asserted without its evidence grade", E1_TOK,
     QUAL_E1,
     "Google retired FAQ rich results in 2026",
     "the 2026 dates are unverified and the sourced position is 2023-08-08"),
    ("e2", "AI-parsing/citation benefit asserted (9a: no primary source either way)", E2_TOK,
     QUAL_E2,
     "FAQPage markup is kept for AI-engine/GEO parsing only",
     "NOT for any citation or parsing benefit (no primary source establishes one, R3 amendment 9a)"),
]
CLASSES = [(cid, name, re.compile(tok, re.I), re.compile(leg, re.I), yes, no)
           for cid, name, tok, leg, yes, no in CLASSES]

DETECT = re.compile(r"(flag\w*|catch|caught|correct\w*|identif\w*|fails?|must not|never|"
                    r"defect|stale|outdated|no longer|fixture|article's claim|is graded|"
                    r"marked for|dead|withdraw\w*|retracted)", re.I)

# QSPAN — a quoted span. The single-quote arm is the one that bit.
#
# MISS A (2026-08-17, found against `a76706d^`). `'[^']{4,}'` cannot tell a quotation
# mark from a possessive apostrophe, and English expectation prose is full of
# possessives: "the fixture's single Article block), any markup mention promises
# AI-engine parsing only — 'Google's FAQ rich results are retired…". The naive pattern
# opened a span at `fixture's` and closed it at the apostrophe starting `'Google's`,
# so a RULE assertion sitting between two unrelated possessives was classified QUOTE —
# i.e. exempted as fixture text the model must catch — and vanished from the report in
# silence. That is a false-negative channel running through the middle of the guard,
# not an edge case.
#
# The fix: a real opening quote is not preceded by a letter, and a real closing quote
# is not followed by one. `'Google's FAQ …'` still parses correctly (the inner
# apostrophe fails the closing lookahead, so the span extends to the true close).
QSPAN = re.compile(r"(?<![A-Za-z])'[^']{4,}'(?![A-Za-z])|"
                   r"\"[^\"]{4,}\"|«[^»]{4,}»|`[^`]{4,}`|“[^”]{4,}”")

# PROXIMITY — how close a legal marker must sit to the token it excuses.
#
# MISS B (2026-08-17). `expected_output` fields in this corpus are 800-character
# comma-spliced paragraphs, so "the same sentence" is not a meaningful scope for a
# grep-AND. In `a76706d^` the qualifier "in either direction" — written about HowTo
# abstention under W12, a different subject entirely — sat 204 characters from
# "for AI-engine/GEO parsing only" and exempted it. F15-r1 is the same failure at file
# scale ("the ban and its context sat 45 lines apart").
#
# 120 was MEASURED, not chosen. Over the 30 marker/token pairs in the 20 live suites
# plus `a76706d^`, every genuine pairing landed at 0-64 characters and the only
# accidental ones at 142 and 204/216. 120 is the rounded midpoint of that gap. State
# the sample honestly: n=30, one corpus, one register style. If the register's
# sentence style changes this number is the first thing to re-measure, and check (0)'s
# proximity canary is what will tell you it has drifted.
PROXIMITY = 120


def window(sent, m):
    """The PROXIMITY-character neighbourhood of a token match, clipped to the sentence."""
    return sent[max(0, m.start() - PROXIMITY):m.end() + PROXIMITY]


SPLIT = re.compile(r"(?<!\be\.g)(?<!\bi\.e)(?<!\bcf)(?<!\bet al)(?<!\betc)(?<!\bvs)"
                   r"(?<=[.;])\s+|\n+")


def sentences(t):
    """Split on sentence enders and newlines only.

    NOT on the em dashes the register style is full of: a legal marker and its token
    routinely sit on either side of one ("flagged as no longer true — Google retired
    FAQ rich results in 2026"), and splitting there would have manufactured a FAIL on
    the corrected text as readily as on the stale text.

    NOT on ':' either, for the identical reason and found the same way (NOISE A,
    2026-08-17). In this register a colon is a label separator, and the label is where
    the warrant lives: «The FAQ rich-result alert is retired per settled ruling R3:
    Google cut FAQ rich results … in 2026», «(settled ruling R3: FAQPage is kept
    despite the 2026 rich-result retirement)», «Labels and headers are not claims: a
    table header … does not count». Splitting there decapitated three qualifiers on
    the live tree and turned two of the resulting orphan fragments into findings that
    began mid-clause — a report the reader cannot act on even when the verdict is right.

    'e.g.' and 'i.e.' are protected: the period inside them is not a sentence end, and
    unprotected it orphaned the remainder of the clause ('(e.g.' | 'a status-table row
    labeled "FAQ rich results") does not count;').
    """
    return [s for s in SPLIT.split(t) if s and s.strip()]


def classify(sent, m):
    """RULE / QUOTE / AMBIGUOUS for one token hit inside one sentence.

    The detection verb is looked for in the token's PROXIMITY window rather than
    anywhere in the sentence, for MISS B's reason: in an 800-character paragraph,
    "somewhere in the same sentence" excuses text the marker was never about. Note the
    direction of the risk here — a DETECT miss downgrades QUOTE to AMBIGUOUS, which is
    a listed WARN, never a silent pass. That asymmetry is deliberate.
    """
    for q in QSPAN.finditer(sent):
        if q.start() <= m.start() and m.end() <= q.end():
            # The framing sits OUTSIDE the quotation, on one side or the other, within
            # PROXIMITY of the span's edge. Measuring from the span's edges rather than
            # the token's keeps a long quotation from pushing its own framing out of
            # range — the framing is attached to the quote, not to the word inside it.
            left = sent[max(0, q.start() - PROXIMITY):q.start()]
            right = sent[q.end():q.end() + PROXIMITY]
            return "QUOTE" if DETECT.search(left + " ¶ " + right) else "AMBIGUOUS"
    return "RULE"


# --- self-test: every class must still match its own canary (F15) -----------
print("eval-expectation-sweep: deprecated-token sweep over evals.json expectations")
print("==============================================")
print("")
print("[0] class self-test (F15: a sweep whose patterns have rotted reports a clean tree)")
selftest_ok = True

# --- derivation parity (OPEN-FINDINGS 100) ----------------------------------
# Three assertions, and each one fails on a different way of re-introducing the hand-copy:
#   (i)  a token class edited downstream instead of at the source;
#   (ii) an imported MEMBER missing from the assembled allowlist — the fossil case, where the
#        local spelling of a member survives a source change;
#   (iii) the transform leaving an unbounded `.*`, which switches the QUOTE classifier off.
for _name, _got, _want in (("f1", F1_TOK, SRC["DEPRECATED_TOKENS"]),
                           ("f3", F3_TOK, SRC["R3_OVERSTATE"])):
    if _got != _want:
        fail(f"(0) class ({_name}) token pattern is not what check (f) enforces. This class is "
             f"IMPORTED and must not be edited here — change it in validate-tracking.sh. "
             f"imported: {_want!r} · in use: {_got!r}")
        selftest_ok = False
for _leg_name, _derived, _assembled in (("f1", DERIVED_F1_LEG, F1_LEG),
                                        ("f2", DERIVED_F2_LEG, F2_LEG)):
    _have = set(alternatives(_assembled))
    _lost = [m for m in alternatives(_derived) if m not in _have]
    if _lost:
        fail(f"(0) class ({_leg_name}) allowlist has lost imported member(s): {_lost!r}. Members "
             f"are imported whole; extras belong in SWEEP_{_leg_name.upper()}_EXTRA, never as an "
             f"edit to an imported one (OPEN-FINDINGS 100)")
        selftest_ok = False
if ".*" in F2_TOK or re.search(r"(?<!\\)\.[+{]", F2_TOK):
    fail("(0) the (f2) transform left an unbounded `.` quantifier: over an 800-character sentence "
         "that match can straddle a closing quote, and a straddling match can never classify "
         "QUOTE — the fixture/rule distinction switches off silently. Teach quote_bound() the "
         "new construct; do not hand-write the pattern")
    selftest_ok = False
if len(alternatives(F2_TOK)) != len(alternatives(SRC["R3_TOKENS"])):
    fail(f"(0) the (f2) transform changed the alternative COUNT "
         f"({len(alternatives(SRC['R3_TOKENS']))} imported -> {len(alternatives(F2_TOK))} in use) "
         f"— it is meant to bound each alternative, not add or drop any")
    selftest_ok = False

# --- the import canary, which is the whole finding in one sentence ----------
# This is the line that measured the divergence on 2026-08-17: check (f) failed it, and this
# script exempted it, because `ended` is a substring of *recommended*. It is a canary rather
# than a fixture line because the fixtures cannot see a class that was never assembled — if
# somebody re-hardcodes the fossil list, THIS is what goes red.
_escape = ("The FAQPage block is eligible for FAQ rich results, as recommended in the brief.")
_em = re.compile(F2_TOK, re.I).search(_escape)
if _em is None:
    fail("(0) import canary cannot run — (f2) no longer matches a bare FAQ-eligibility assertion")
    selftest_ok = False
elif re.compile(F2_LEG, re.I).search(_escape[max(0, _em.start() - 120):_em.end() + 120]):
    fail("(0) IMPORT CANARY FAILED — a FAQ-eligibility assertion is excused by a marker that is "
         "only a SUBSTRING of another word (`ended` inside *recommended*). check (f) word-bounded "
         "these members in 8f69a7a; this class is supposed to be reading that fix, not a copy of "
         "the list from before it (OPEN-FINDINGS 100)")
    selftest_ok = False
for cid, name, tok, leg, yes, no in CLASSES:
    ctx = CONTEXT.get(cid)
    if ctx and not ctx.search(yes):
        fail(f"(0) class ({cid}) canary \"{yes}\" does not satisfy the class's own CONTEXT "
             f"requirement — the class can never fire"); selftest_ok = False
    if not tok.search(yes):
        fail(f"(0) class ({cid}) no longer matches its own canary: \"{yes}\" — pattern drift; "
             f"the corpus below was NOT judged"); selftest_ok = False
    elif leg.search(yes):
        fail(f"(0) class ({cid}) canary \"{yes}\" is exempted by its own legal-marker set — "
             f"the claim would be its own pass condition (B2, 2026-08-13)"); selftest_ok = False
    if no is not None:
        nm = tok.search(no)
        if nm and not leg.search(window(no, nm)):
            fail(f"(0) class ({cid}) fails its NEGATIVE canary: \"{no}\" is corrected text and "
                 f"would be reported as a violation — a guard that punishes the corrected line "
                 f"teaches authors to write for the checker"); selftest_ok = False

# --- classifier canaries (the hole the token canaries could not see) --------
# Every case below is a REGRESSION CANARY for a bug fault injection actually found on
# 2026-08-17, not a hypothetical. The token canaries above never run through
# classify(), so none of them could have caught any of these: a classifier that
# over-returns QUOTE exempts the whole corpus and prints PASS. That is F15's silent
# direction, and this block is the only thing standing in it.
_F2 = re.compile(F2_TOK, re.I)
_E2 = re.compile(E2_TOK, re.I)
CLASSIFIER_CANARIES = [
    # (label, sentence, token regex, expected role)
    ("MISS A — possessive apostrophes must not open a quote span",
     "the fixture's single Article block), any markup mention promises AI-engine "
     "parsing only — 'Google's FAQ rich results are retired, so promise no SERP feature'",
     _E2, "RULE"),
    ("a genuine quoted fixture claim, framed by a detection verb, stays exempt",
     "R3 catch: the article's claim that 'Google displays FAQ rich results as expandable "
     "questions right in the SERP' is flagged as no longer true",
     _F2, "QUOTE"),
    ("an unframed quoted token is AMBIGUOUS, never silently passed",
     "the plan mentions 'FAQ rich results' in the summary table",
     _F2, "AMBIGUOUS"),
    ("a bare assertion in the expectation's own voice is a RULE",
     "The response states that Google retired FAQ rich results in 2026",
     _F2, "RULE"),
]
for label, sent, tokre, expect in CLASSIFIER_CANARIES:
    ms = list(tokre.finditer(sent))
    if not ms:
        fail(f"(0) classifier canary token vanished ({label}) — the canary itself no longer "
             f"matches, so it tests nothing"); selftest_ok = False
        continue
    got = classify(sent, ms[0])
    if got != expect:
        fail(f"(0) classifier canary FAILED ({label}): expected {expect}, got {got}. "
             f"classify() is the exemption path — when it over-returns QUOTE the sweep "
             f"passes by exempting everything (F15, silent direction)"); selftest_ok = False

# --- proximity canary -------------------------------------------------------
# MISS B: a qualifier about a different claim, far away in the same run-on paragraph,
# must NOT excuse the token. If PROXIMITY is ever raised past this gap the guard
# quietly re-acquires the bug, and this is where it says so.
_far = ("FAQPage markup is kept for AI-engine/GEO parsing only" + ", " + "x" * 200 +
        ", and HowTo status is unestablished in either direction")
_fm = _E2.search(_far)
if _fm is None or re.compile(QUAL_E2, re.I).search(window(_far, _fm)):
    fail("(0) proximity canary FAILED — a qualifier ~200 chars away about a DIFFERENT claim "
         "still excuses the token. PROXIMITY is too wide, or the window is not being "
         "applied (F15-r1's shape: the ban and its context sat 45 lines apart)")
    selftest_ok = False
# …and the near case must still be excused, or the guard punishes the corrected line.
_near = "no citation or parsing benefit is claimed (unestablished in either direction, 9a)"
_nm = _E2.search(_near)
if _nm is not None and not re.compile(QUAL_E2, re.I).search(window(_near, _nm)):
    fail("(0) proximity canary FAILED the other way — an adjacent, correct qualifier no "
         "longer excuses its token. PROXIMITY is too narrow; this fails corrected text")
    selftest_ok = False

# --- qualifier-asymmetry canary --------------------------------------------
# MISS C, pinned directly rather than left to a transcript diff. Mutation-testing on
# 2026-08-17 showed the other two fixes are caught by the canaries above the moment
# they are reverted, but putting `ruling r3` back into the (e2) set left check (0)
# GREEN — the regression showed up only as 13 fixture FAILs becoming 12, which nobody
# notices unless they are already comparing counts. A design decision this subtle
# needs an assertion, not a diff. Read it as: naming R3 warrants the DATE, because
# R3's Statement asserts the date; it does not warrant the AI-PARSING BENEFIT, because
# amendment 9a withdrew R3's warrant from that clause in terms.
_r3cite = "framed for AI-engine/GEO parsing only with no SERP-feature promise (ruling R3)"
if not re.compile(QUAL_E1, re.I).search(_r3cite):
    fail("(0) qualifier-asymmetry canary FAILED — (e1) no longer accepts a ruling citation "
         "as a warrant for the date claim; this fails suites that correctly cite R3")
    selftest_ok = False
if re.compile(QUAL_E2, re.I).search(_r3cite):
    fail("(0) qualifier-asymmetry canary FAILED — (e2) accepts `ruling R3` as a warrant for "
         "the AI-parsing benefit claim. R3 amendment 9a withdrew that warrant explicitly "
         "('It may not say it earns AI citations'), so this marker IS its own pass "
         "condition — the B2 failure mode, and the miss this guard had against a76706d^")
    selftest_ok = False

if selftest_ok:
    pas(f"(0) all {len(CLASSES)} token classes match their positive canary, are not exempted "
        f"by their own markers, and clear their negative canary; "
        f"{len(CLASSIFIER_CANARIES)} classifier canaries, both proximity canaries and the "
        f"(e1)/(e2) qualifier asymmetry hold; classes (f1)-(f3) imported from check (f) "
        f"({len(alternatives(DERIVED_F1_LEG))}+{len(alternatives(DERIVED_F2_LEG))} allowlist "
        f"members, parity and import canary hold)")
else:
    print("")
    print("==============================================")
    print(f"Results: {PASS_N} passed, {WARN_N} warnings, {FAIL_N} failed")
    print("eval-expectation-sweep FAILED — self-test; no corpus verdict was reached")
    sys.exit(1)

# --- corpus ----------------------------------------------------------------
if explicit:
    suites = explicit
else:
    suites = sorted(p for c in CATEGORIES for p in (root / c).glob("*/evals/evals.json"))

print("")
print("[1] expectation sweep (expectations[] + expected_output; evals/files/** never opened)")

NFIELD = NHIT = NQUOTE = 0
AMBIG = []
unreadable = []
# One sentence, one class, one finding. "…kept for AI-engine/GEO parsing only" trips
# (e2) twice (`for AI-engine` and `GEO parsing`) and printed the identical FAIL line
# twice with a different `matched` string. The reader's next action is the same in
# both cases — rewrite that sentence — so the second line is volume, not information,
# and volume is how a report stops being read. Deduped on the sentence, NOT on the
# field: two different stale sentences in one expectation are two things to fix.
SEEN = set()
for path in suites:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except Exception as e:
        unreadable.append((path, str(e))); continue
    rel = path.relative_to(root) if root in path.parents or str(path).startswith(str(root)) else path
    for ev_rec in data.get("evals", []):
        eid = ev_rec.get("id", "?")
        fields = []
        eo = ev_rec.get("expected_output")
        if isinstance(eo, str):
            fields.append(("expected_output", eo))
        for i, x in enumerate(ev_rec.get("expectations", []) or []):
            if isinstance(x, str):
                fields.append((f"expectations[{i}]", x))
        for fname, text in fields:
            NFIELD += 1
            for sent in sentences(text):
                for cid, cname, tok, leg, _, _ in CLASSES:
                    ctx = CONTEXT.get(cid)
                    if ctx and not ctx.search(sent):
                        continue
                    for m in tok.finditer(sent):
                        role = classify(sent, m)
                        if role == "QUOTE":
                            NQUOTE += 1
                            continue
                        # MISS B: the marker must be NEAR the token, not merely
                        # somewhere in an 800-character paragraph about six subjects.
                        if leg.search(window(sent, m)):
                            continue
                        snip = sent.strip()
                        snip = (snip[:180] + "…") if len(snip) > 180 else snip
                        if role == "AMBIGUOUS":
                            # Deduped on the same key as the FAILs: three tokens in one
                            # quoted sentence are one thing for a human to read, and the
                            # WARN block is only useful if it is short enough to be read.
                            akey = ("A",) + (str(rel), str(eid), fname, cid, sent.strip())
                            if akey not in SEEN:
                                SEEN.add(akey)
                                AMBIG.append((rel, eid, fname, cid, snip))
                            continue
                        key = (str(rel), str(eid), fname, cid, sent.strip())
                        if key in SEEN:
                            continue
                        SEEN.add(key)
                        NHIT += 1
                        # SAY ONLY WHAT WAS FOUND. The founding defect is an
                        # expectation that REQUIRES the retracted claim of the
                        # response — a corrected skill then fails for being right.
                        # But the same token also turns up in a grader's parenthetical
                        # aside ("…(both were cut for FAQ in 2026);"), where the
                        # requirement is something else entirely and a corrected skill
                        # would still pass. Both are defects — an expectation is a
                        # normative document and check (f) would fail the identical
                        # sentence in skill text — but they are not the SAME defect,
                        # and a guard that describes the weaker one in the stronger
                        # one's words is overclaiming in its own output. So the
                        # message follows the evidence.
                        aside = any(a.start() <= m.start() and m.end() <= a.end()
                                    for a in re.finditer(r"\([^()]*\)", sent))
                        if aside:
                            why = ("the expectation asserts this claim as its own "
                                   "rationale, in a parenthetical — a retracted claim "
                                   "stated as fact in a normative document (check (f) "
                                   "parity); cite the ruling or drop the aside")
                        else:
                            why = ("the expectation REQUIRES this claim, so a skill "
                                   "corrected to the current position fails its own "
                                   "eval for being right")
                        fail(f"({cid}) {rel} eval {eid} {fname} — {cname}: {why}")
                        ev(f"matched \"{m.group(0)}\" in: {snip}")

for p, why in unreadable:
    fail(f"(1) unparseable suite {p}: {why} — a suite this cannot read is not skipped "
         f"(F15: a smaller corpus that still looks like an answer)")

# --- anti-vacuity ----------------------------------------------------------
print("")
if not suites:
    fail("(2) found NO evals.json under the skill categories — this sweep judged nothing (F15)")
elif NFIELD == 0:
    fail(f"(2) parsed {len(suites)} suite(s) but extracted ZERO expectation/expected_output "
         f"fields — schema drift; the sweep read nothing (F15)")
elif NHIT == 0 and not unreadable:
    pas(f"(2) {NFIELD} expectation/expected_output field(s) across {len(suites)} suite(s) "
        f"swept for {len(CLASSES)} token class(es); no retracted claim required as a rule "
        f"({NQUOTE} hit(s) were fixture text quoted for the model to catch)")
else:
    print(f"      swept {NFIELD} field(s) across {len(suites)} suite(s); {NQUOTE} quoted "
          f"fixture hit(s) exempted")

# --- (3) corpus-discovery cross-check ---------------------------------------
# The glob above walks five hardcoded category directories. If a sixth category is
# ever added, its suites are swept by nothing and this script still prints PASSED —
# F15's shape again: a smaller corpus that still looks like an answer. So: walk the
# tree for every `evals.json` and fail on any the glob did not reach. Paths only; no
# file outside the swept set is ever opened, and `evals/files/**` is not walked at all.
#
# scripts/ is excluded because this guard's OWN fault-injection fixtures live at
# scripts/fixtures/eval-expectation-sweep/*/evals.json. They are deliberately
# defective — sweeping them would make the live tree permanently red, which is the
# fixture/expectation distinction this whole script is about, applied to itself.
if not explicit:
    swept = {p.resolve() for p in suites}
    stray = sorted(p for p in root.rglob("evals.json")
                   if p.resolve() not in swept
                   and "scripts" not in p.relative_to(root).parts
                   and ".git" not in p.relative_to(root).parts
                   and "node_modules" not in p.relative_to(root).parts)
    if stray:
        for p in stray:
            fail(f"(3) {p.relative_to(root)} is an eval suite the category glob never "
                 f"reached, so nothing swept it. Add its category to CATEGORIES — a guard "
                 f"that silently narrows its own corpus reports a clean tree it never read")
    else:
        pas(f"(3) corpus is complete: every evals.json in the tree ({len(suites)}) was "
            f"reached by the category glob")

if AMBIG:
    warn(f"{len(AMBIG)} quoted token hit(s) with no detection verb near it — this "
         f"script cannot tell a fixture quotation from a restated rule here, and does not "
         f"guess in either direction; read them and add the framing (or the correction)")
    for rel, eid, fname, cid, snip in AMBIG:
        ev(f"({cid}) {rel} eval {eid} {fname}: {snip}")

print("")
print("==============================================")
print(f"Results: {PASS_N} passed, {WARN_N} warnings, {FAIL_N} failed")
if FAIL_N:
    print("eval-expectation-sweep FAILED — an eval expectation grades a retracted claim")
    sys.exit(1)
print("eval-expectation-sweep PASSED" + (" with warnings" if WARN_N else ""))
sys.exit(0)
PY
