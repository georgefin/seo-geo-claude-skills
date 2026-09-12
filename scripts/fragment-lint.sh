#!/usr/bin/env bash
# fragment-lint.sh — F7 evidence-discipline checks on a Mode B fragment JSON.
#
# Ledger entry: FAILURE-LEDGER.md F7 (grading scripts produced false verdicts on
# real evidence; the standing guard: graders must PRINT matched/unmatched
# evidence, never bare booleans, and every reported failure must QUOTE the raw
# output at the flagged location). Spec: MASTER-IMPROVEMENT-PLAN.md 1a (F7
# conversion, G5). This script makes the fragment side of that guard scripted:
# a Mode B result fragment whose entries lack printed evidence, whose failures
# lack raw-output quotes, or whose totals do not add up is rejected BEFORE it
# can be recorded as a baseline.
#
# WHAT IT CHECKS (per violation, the offending entry/values are printed):
#   (1) the file parses as JSON;
#   (2) `expectations` is a non-empty array and every entry carries a boolean
#       `passed` and an `index` or `id`;
#   (3) every expectations[] entry has non-empty string `evidence`;
#   (4) every `passed:false` entry's evidence contains a raw-output quote
#       marker — a straight double quote ("), a backtick (`), or a guillemet
#       («/»): the F7 rule that a failure verdict must quote what it saw
#       (pass-entries may summarize; fail-entries must quote);
#   (5) totals arithmetic is consistent with the entries. Both fragment shapes
#       in use are accepted: top-level `passed`/`total`/`pass_rate` (schema
#       fragment shape) and nested `totals.{passed,failed,total,pass_rate}`
#       (keyword fragment shape). Checked: total == entry count; passed ==
#       count of passed:true; failed (when present) == count of passed:false;
#       pass_rate (when present) == passed/total within 0.005; a per-eval
#       `evals[]` breakdown (when present with numeric passed/total) must
#       cross-foot to the same passed/total;
#   (6) regression bookkeeping: `regression_count` (when present) == length of
#       `regressions[]` (when present).
#
# Usage:  ./scripts/fragment-lint.sh <fragment.json>
# Exit:   0 = all checks pass, 1 = any FAIL, 2 = usage/setup error
# No network access. Dependencies: bash, jq.

set -u

if [ $# -ne 1 ]; then
    echo "Usage: $0 <mode-b-fragment.json>" >&2
    exit 2
fi
FRAG="$1"
if [ ! -f "$FRAG" ]; then
    echo "ERROR: fragment file not found: $FRAG" >&2
    exit 2
fi
if ! command -v jq >/dev/null 2>&1; then
    echo "ERROR: jq is required but not installed" >&2
    exit 2
fi

PASS_N=0
FAIL_N=0
WARN_N=0
pass() { printf 'PASS: %s\n' "$1"; PASS_N=$((PASS_N + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; FAIL_N=$((FAIL_N + 1)); }
warn() { printf 'WARN: %s\n' "$1"; WARN_N=$((WARN_N + 1)); }
evline() { printf '      > %s\n' "$1"; }

echo "fragment-lint: F7 evidence-discipline checks on a Mode B fragment"
echo "Fragment: $FRAG"
echo "=============================================="

# (1) JSON validity ---------------------------------------------------------
if ! JQERR=$(jq empty "$FRAG" 2>&1); then
    fail "(1) not valid JSON: $JQERR"
    echo ""
    echo "=============================================="
    echo "Results: $PASS_N passed, $WARN_N warnings, $FAIL_N failed"
    echo "fragment-lint FAILED — fragment unreadable, nothing else checkable"
    exit 1
fi
pass "(1) file parses as valid JSON"

# (2) expectations array + entry shape --------------------------------------
ETYPE=$(jq -r '.expectations | type' "$FRAG" 2>/dev/null)
N=$(jq -r '.expectations | if type == "array" then length else 0 end' "$FRAG")
if [ "$ETYPE" != "array" ] || [ "$N" -eq 0 ]; then
    fail "(2) 'expectations' is not a non-empty array (type: $ETYPE, length: $N) — a fragment without per-expectation records is ungradeable"
else
    BADSHAPE=$(jq -r '.expectations[] | select(((.passed | type) != "boolean") or (((.index // .id) // "") == "")) | @json' "$FRAG")
    if [ -n "$BADSHAPE" ]; then
        while IFS= read -r e; do
            [ -n "$e" ] || continue
            fail "(2) entry lacks a boolean 'passed' and/or an 'index'/'id':"
            evline "$e"
        done <<< "$BADSHAPE"
    else
        pass "(2) expectations array present: $N entries, each with boolean 'passed' and an index/id"
    fi
fi

# (3) non-empty evidence on every entry -------------------------------------
NOEV=$(jq -r '.expectations // [] | .[] | select(((.evidence // "") | if type == "string" then (gsub("^[[:space:]]+|[[:space:]]+$"; "") == "") else true end)) | ((.index // .id // "?") | tostring)' "$FRAG")
if [ -n "$NOEV" ]; then
    while IFS= read -r idx; do
        [ -n "$idx" ] || continue
        fail "(3) expectation '$idx' has empty/missing 'evidence' — verdicts without printed evidence are the F7 failure mode"
        evline "$(jq -c --arg i "$idx" '.expectations[] | select(((.index // .id) | tostring) == $i)' "$FRAG")"
    done <<< "$NOEV"
else
    pass "(3) all $N expectation entries carry non-empty evidence"
fi

# (4) failed entries must QUOTE raw output ----------------------------------
NFAILED=$(jq -r '[.expectations // [] | .[] | select(.passed == false)] | length' "$FRAG")
if [ "$NFAILED" -eq 0 ]; then
    pass "(4) 0 passed:false entries — raw-output quote requirement not exercised on this fragment"
else
    NOQUOTE=$(jq -r '.expectations[] | select(.passed == false) | select(((.evidence // "") | tostring | test("[\"`«»]")) | not) | ((.index // .id // "?") | tostring)' "$FRAG")
    if [ -n "$NOQUOTE" ]; then
        while IFS= read -r idx; do
            [ -n "$idx" ] || continue
            fail "(4) FAILED expectation '$idx' evidence has no raw-output quote marker (\" \` « ») — F7: inspect and QUOTE the raw output before reporting any failure"
            evline "$(jq -c --arg i "$idx" '.expectations[] | select(((.index // .id) | tostring) == $i) | .evidence' "$FRAG")"
        done <<< "$NOQUOTE"
    else
        pass "(4) all $NFAILED passed:false entries quote raw output in their evidence"
    fi
fi

# (5) totals arithmetic ------------------------------------------------------
NTRUE=$(jq -r '[.expectations // [] | .[] | select(.passed == true)] | length' "$FRAG")
REP_PASSED=$(jq -r '(.totals.passed // .passed) // "absent"' "$FRAG")
REP_TOTAL=$(jq -r '(.totals.total // .total) // "absent"' "$FRAG")
REP_FAILED=$(jq -r '(.totals.failed // .failed) // "absent"' "$FRAG")
REP_RATE=$(jq -r '(.totals.pass_rate // .pass_rate) // "absent"' "$FRAG")
T5_OK=1
if [ "$REP_PASSED" = "absent" ] || [ "$REP_TOTAL" = "absent" ]; then
    fail "(5) fragment reports no passed/total (top-level or totals.*) — a fragment must state its own tally"
    T5_OK=0
else
    if [ "$REP_TOTAL" != "$N" ]; then
        fail "(5) reported total $REP_TOTAL != $N expectations[] entries"
        T5_OK=0
    fi
    if [ "$REP_PASSED" != "$NTRUE" ]; then
        fail "(5) reported passed $REP_PASSED != $NTRUE entries with passed:true"
        T5_OK=0
    fi
    if [ "$REP_FAILED" != "absent" ] && [ "$REP_FAILED" != "$NFAILED" ]; then
        fail "(5) reported failed $REP_FAILED != $NFAILED entries with passed:false"
        T5_OK=0
    fi
    if [ "$REP_RATE" != "absent" ]; then
        RATE_OK=$(jq -r --argjson p "$NTRUE" --argjson t "$N" '
            ((.totals.pass_rate // .pass_rate) - (if $t == 0 then 0 else ($p / $t) end)) | fabs | (. <= 0.005)' "$FRAG")
        if [ "$RATE_OK" != "true" ]; then
            fail "(5) reported pass_rate $REP_RATE inconsistent with counted $NTRUE/$N (tolerance 0.005)"
            T5_OK=0
        fi
    fi
fi
EVALS_SHAPE=$(jq -r '(.evals | type) == "array" and ((.evals // []) | length > 0) and ([.evals[] | (has("passed") and has("total"))] | all)' "$FRAG" 2>/dev/null)
if [ "$EVALS_SHAPE" = "true" ]; then
    ESUM_P=$(jq -r '[.evals[].passed] | add' "$FRAG")
    ESUM_T=$(jq -r '[.evals[].total] | add' "$FRAG")
    if [ "$REP_PASSED" != "absent" ] && [ "$ESUM_P" != "$REP_PASSED" ]; then
        fail "(5) evals[] breakdown sums to passed=$ESUM_P but fragment reports passed=$REP_PASSED"
        T5_OK=0
    fi
    if [ "$REP_TOTAL" != "absent" ] && [ "$ESUM_T" != "$REP_TOTAL" ]; then
        fail "(5) evals[] breakdown sums to total=$ESUM_T but fragment reports total=$REP_TOTAL"
        T5_OK=0
    fi
    EVNOTE="; evals[] breakdown cross-foots ($ESUM_P/$ESUM_T)"
else
    EVNOTE=""
fi
if [ "$T5_OK" -eq 1 ]; then
    RATE_NOTE=""
    [ "$REP_RATE" != "absent" ] && RATE_NOTE="; pass_rate $REP_RATE consistent"
    pass "(5) totals arithmetic consistent: reported $REP_PASSED/$REP_TOTAL == counted $NTRUE true of $N entries (failed: ${REP_FAILED})${RATE_NOTE}${EVNOTE}"
fi

# (6) regression bookkeeping -------------------------------------------------
RC=$(jq -r '.regression_count // "absent"' "$FRAG")
RL=$(jq -r 'if (.regressions | type) == "array" then (.regressions | length) else "absent" end' "$FRAG")
if [ "$RC" = "absent" ] && [ "$RL" = "absent" ]; then
    warn "(6) fragment carries neither regression_count nor regressions[] — regression rate is the FIRST learning metric (PIPELINE.md); record it"
elif [ "$RC" != "absent" ] && [ "$RL" != "absent" ] && [ "$RC" != "$RL" ]; then
    fail "(6) regression_count $RC != regressions[] length $RL"
    evline "$(jq -c '.regressions' "$FRAG")"
else
    pass "(6) regression bookkeeping consistent (regression_count: $RC, regressions[] length: $RL)"
fi

# Summary --------------------------------------------------------------------
echo ""
echo "=============================================="
echo "Results: $PASS_N passed, $WARN_N warnings, $FAIL_N failed"
if [ "$FAIL_N" -gt 0 ]; then
    echo "fragment-lint FAILED — fragment is not baseline-grade (F7 evidence discipline)"
    exit 1
fi
if [ "$WARN_N" -gt 0 ]; then
    echo "fragment-lint PASSED with warnings"
else
    echo "fragment-lint PASSED — fragment meets the F7 evidence discipline"
fi
exit 0
