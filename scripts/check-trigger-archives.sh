#!/usr/bin/env bash
# check-trigger-archives.sh — F10 archive-on-write verification (gate check (h)
# candidate).
#
# Ledger entry: FAILURE-LEDGER.md F10 (live trigger prompt existed nowhere but
# the trigger store: v2->v4.1 weekly prompts were applied via update_trigger
# without committing the text, and `update_trigger` replaces prompts WHOLESALE —
# amending without the verbatim baseline risks silently destroying prior upgrade
# waves). The standing guard: every create_trigger/update_trigger that sets a
# prompt commits the full text to docs/loop/archive/ in the same wave, and the
# PIPELINE.md trigger-registry row links the file. Spec: MASTER-IMPROVEMENT-PLAN.md
# 1a (F10 conversion, G5): every DURABLE trigger row must map to an existing
# docs/loop/archive/ prompt file.
#
# WHAT IT DOES: parses the '## Trigger registry' table in docs/loop/PIPELINE.md
# (columns: Routine | ID | State | Schedule) and, per row:
#   - EXEMPT: rows whose ID/State name `send_later` cursors — F10's scope-precision
#     note (2026-08-09): one-shot monitor check-in cursors are wholesale-replaced
#     derivations of the in-repo stage-5 policy, never amended, so the
#     amend-without-baseline hazard cannot arise and per-re-arm archives would be
#     noise.
#   - Rows referencing archive files (`docs/loop/archive/<f>`, `archive/<f>`, or
#     the row-abbreviation `…/<f>`): every referenced file must exist — FAIL per
#     missing file, PASS per found file (evidence printed either way).
#   - Durable rows with NO archive reference: FAIL if the trigger can still fire
#     or still holds a prompt in the store (this is exactly the F10 failure);
#     WARN only when the State cell says the trigger is deleted (a deleted
#     trigger holds no amendable prompt, so the recorded hazard cannot recur —
#     pre-guard legacy rows like 'v2 interim test' land here; archiving remains
#     advisable if the prompt is ever recoverable).
#
# Usage:  ./scripts/check-trigger-archives.sh [repo-root]     (default: .)
# Exit:   0 = all checks pass (warnings allowed), 1 = any FAIL, 2 = usage/setup
# No network access (the trigger STORE is unreachable from scripts by design —
# F1 residual; this checks the repo-side contract only). Dependencies: bash,
# grep, sed, awk.

set -u

ROOT="${1:-.}"
if [ ! -d "$ROOT" ]; then
    echo "ERROR: repo root '$ROOT' is not a directory" >&2
    exit 2
fi
ROOT="$(cd "$ROOT" && pwd)"
PIPELINE="$ROOT/docs/loop/PIPELINE.md"
if [ ! -f "$PIPELINE" ]; then
    echo "ERROR: $PIPELINE not found" >&2
    exit 2
fi

PASS_N=0
FAIL_N=0
WARN_N=0
pass() { printf 'PASS: %s\n' "$1"; PASS_N=$((PASS_N + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; FAIL_N=$((FAIL_N + 1)); }
warn() { printf 'WARN: %s\n' "$1"; WARN_N=$((WARN_N + 1)); }

echo "check-trigger-archives: (h) durable trigger rows -> docs/loop/archive/ files (F10 guard)"
echo "Repo root: $ROOT | Table: docs/loop/PIPELINE.md '## Trigger registry'"
echo "=============================================="

# Extract data rows (skip the header row and the |---| separator) as
# routine<TAB>id<TAB>state. Cells contain no tabs or pipes by construction.
ROWS=$(awk -F'|' '
    /^## Trigger registry/ { insec = 1; next }
    insec && /^## /        { insec = 0 }
    insec && /^\|/ {
        if ($0 ~ /^\|[ \t]*-+/) next                 # separator row
        hdr++
        if (hdr == 1) next                            # header row
        r = $2; i = $3; s = $4
        gsub(/^[ \t]+|[ \t]+$/, "", r)
        gsub(/^[ \t]+|[ \t]+$/, "", i)
        gsub(/^[ \t]+|[ \t]+$/, "", s)
        printf "%s\t%s\t%s\n", r, i, s
    }' "$PIPELINE")

NROWS=$(printf '%s\n' "$ROWS" | grep -c . || true)
if [ "$NROWS" -eq 0 ]; then
    fail "(h) parsed ZERO data rows from the '## Trigger registry' table — parser or format drift (the registry held 6 rows when this check shipped)"
    echo ""
    echo "=============================================="
    echo "Results: $PASS_N passed, $WARN_N warnings, $FAIL_N failed"
    echo "check-trigger-archives FAILED"
    exit 1
fi

while IFS=$'\t' read -r routine id state; do
    [ -n "$routine" ] || continue
    lowid=$(printf '%s %s' "$id" "$state" | tr '[:upper:]' '[:lower:]')

    # F10 scope-precision exemption: send_later cursor rows
    case "$lowid" in
        *send_later*)
            pass "(h) row '$routine' — send_later cursor chain: EXEMPT per F10 scope-precision (wholesale-replaced stage-5 derivations, never amended)"
            continue ;;
    esac

    # Archive references in the State cell; `…/` is the row abbreviation for
    # docs/loop/archive/ (used by the weekly row's v4.1 baseline pointer).
    REFS=$(printf '%s\n' "$state" \
        | grep -oE 'docs/loop/archive/[A-Za-z0-9._-]+|…/[A-Za-z0-9._-]+|archive/[A-Za-z0-9._-]+' \
        | sed 's|^…/|docs/loop/archive/|; s|^archive/|docs/loop/archive/|; s|^docs/loop/docs/loop/|docs/loop/|' \
        | sort -u)

    if [ -n "$REFS" ]; then
        while IFS= read -r ref; do
            [ -n "$ref" ] || continue
            if [ -f "$ROOT/$ref" ]; then
                pass "(h) row '$routine' -> $ref exists ($(wc -c < "$ROOT/$ref") bytes)"
            else
                fail "(h) row '$routine' references $ref but the file does not exist — archive the prompt in the same wave (F10 guard)"
                printf '      row State: %s\n' "$state"
            fi
        done <<< "$REFS"
    else
        case "$lowid" in
            *deleted*)
                warn "(h) row '$routine' — no archive reference, but State says deleted (no amendable prompt left in the store; pre-guard legacy — archive if the prompt ever becomes recoverable)"
                printf '      row State: %s\n' "$state"
                ;;
            *)
                fail "(h) row '$routine' — durable trigger with NO docs/loop/archive/ prompt file referenced: the F10 failure itself (prompt would exist nowhere but the trigger store)"
                printf '      row State: %s\n' "$state"
                ;;
        esac
    fi
done <<< "$ROWS"

echo ""
echo "=============================================="
echo "Results: $PASS_N passed, $WARN_N warnings, $FAIL_N failed"
if [ "$FAIL_N" -gt 0 ]; then
    echo "check-trigger-archives FAILED — a durable trigger prompt is not archived (F10)"
    exit 1
fi
if [ "$WARN_N" -gt 0 ]; then
    echo "check-trigger-archives PASSED with warnings"
else
    echo "check-trigger-archives PASSED — every durable trigger row maps to an archived prompt"
fi
exit 0
