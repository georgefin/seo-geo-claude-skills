#!/usr/bin/env bash
# check-freshness.sh — staleness check for dated pipeline state.
# The loop's registers and market snapshots carry review dates; when the newest
# date in a tracked file exceeds its re-check window, that file is due a sweep.
#
# ---------------------------------------------------------------------------
# TWO DEFECTS FIXED 2026-08-12 (R-0222 / R-0297). Both are recorded here because
# each one hid the other.
#
# (1) IT COULD NOT FAIL. Every path ended at a single unconditional `exit 0`
#     (the old `:63`), including the bad-repo-root path — so the script was
#     fail-OPEN even on a setup error. `MASTER-IMPROVEMENT-PLAN.md` §1a counted
#     ledger F5 as converted on the strength of it. A check that cannot go red
#     is worse than an honest procedural note, because it retires the concern.
#
# (2) ITS MEASUREMENT WAS WRONG ON THIS PLATFORM, AND (1) HID IT. Age came from
#     `date -d "$newest" +%s 2>/dev/null || echo 0`. `date -d` is a GNU-ism;
#     BSD/macOS `date` rejects it ("illegal option -- d"), the `|| echo 0`
#     fabricated a 1970 epoch, and EVERY tracked file reported
#     `AGED ... (20677d old)` — a file stamped yesterday included. Measured on
#     this repo before the fix: 6 of 6 files AGED, exit 0. A wrong number that
#     always exits 0 produces no complaint, so the arithmetic was never
#     questioned. The `|| echo 0` is the specific sin: a failed measurement must
#     not silently become a measurement.
#
# THE FAIL-vs-WARN SPLIT (the reason this is not simply `exit 1` on staleness).
# The two things this script can find are not the same kind of finding:
#
#   INSTRUMENT FAULTS — a tracked path that no longer exists, a file carrying no
#   ISO date at all, a date that will not parse, or an empty target list. These
#   are deterministic, caused by a change someone made, fixable by the person
#   who made it, and while any of them is true THE CHECK IS NOT MEASURING WHAT
#   IT CLAIMS TO. They FAIL, unconditionally, and they are why this script now
#   has teeth at all.
#
#   STALENESS — newest date older than the window. This is a function of the
#   CALENDAR, not of the push. Nothing in the outgoing diff caused it and
#   nothing in the outgoing diff can honestly clear it: the only edit that turns
#   it green is a date bump, i.e. exactly the fabricated review stamp the repo's
#   own rules ban. A gate that goes red because a Tuesday passed, on a file the
#   pusher never touched, blocks every push until someone fakes a review — the
#   guard would MANUFACTURE the dishonesty it exists to police. So staleness
#   WARNs by default and is what the weekly/quarterly sweep consumes.
#
#   `FRESHNESS_REQUIRE_CURRENT=1` promotes staleness to a failure (exit 1), for
#   the caller who is running the sweep and wants the answer as an exit code.
#   Same shape as `COMMIT_SCOPE_REQUIRE_COMMITS` and `PREPUSH_REQUIRE_SCOPE`.
#
# FAIL-CLOSED ON AN EMPTY SCAN SET: zero resolvable targets is a FAIL, never a
# pass, and the scanned/configured counts are printed on every run.
# ---------------------------------------------------------------------------
#
# Usage: ./scripts/check-freshness.sh [repo-root] [--max-age-days N]
#        ./scripts/check-freshness.sh [repo-root] --print-targets
#          --print-targets is the READ-ONLY scope query: it prints one existing
#          tracked path per line and nothing else, so a caller (pre-push-gate's
#          scope block) can measure this leg's scope from the same list the
#          check itself uses, instead of grepping this script's prose or
#          keeping a second copy of the list that would drift.
# Env:   FRESHNESS_REQUIRE_CURRENT=1 — staleness FAILs (exit 1) instead of WARNing
# Exit:  0 = no instrument fault (staleness, if any, reported as WARN)
#        1 = instrument fault, or staleness under FRESHNESS_REQUIRE_CURRENT=1
#        2 = usage/setup error (unreadable root, unknown flag, unusable `date`)
# No network. Dependencies: bash, grep, sort, awk, date.

set -u

REQUIRE_CURRENT="${FRESHNESS_REQUIRE_CURRENT:-0}"
MAX_AGE=90
ROOT=""
PRINT_TARGETS=0

while [ $# -gt 0 ]; do
    case "$1" in
        --max-age-days)
            [ $# -ge 2 ] || { echo "ERROR: --max-age-days needs a value" >&2; exit 2; }
            case "$2" in
                ''|*[!0-9]*) echo "ERROR: --max-age-days needs a non-negative integer, got '$2'" >&2; exit 2 ;;
            esac
            MAX_AGE="$2"; shift 2 ;;
        --print-targets) PRINT_TARGETS=1; shift ;;
        -h|--help) sed -n '2,60p' "$0"; exit 0 ;;
        # An unknown flag is refused rather than silently absorbed as a repo
        # root. The old hand-rolled parser did absorb it, and a parser that
        # cannot reject what it does not know fails OPEN.
        -*) echo "ERROR: unknown option '$1'" >&2; exit 2 ;;
        *)
            [ -z "$ROOT" ] || { echo "ERROR: more than one repo root given ('$ROOT', '$1')" >&2; exit 2; }
            ROOT="$1"; shift ;;
    esac
done
[ -n "$ROOT" ] || ROOT="."

# exit 2, not 0: an unreadable root means nothing was checked.
ROOT="$(cd "$ROOT" 2>/dev/null && pwd)" || { echo "ERROR: repo root '$ROOT' is not a readable directory" >&2; exit 2; }

# The tracked set. Kept here (not in a sidecar file) so there is exactly one
# copy; --print-targets is how any other tool reads it.
TRACKED="docs/loop/SETTLED-RULINGS.md
docs/loop/WATCH-ITEMS.md
docs/loop/GATED-ITEMS.md
docs/loop/PIPELINE.md
research/serp-analysis/references/skroutz-visibility-factors.md
research/keyword-research/references/greek-keyword-coverage.md"

N_CONFIGURED=$(printf '%s\n' "$TRACKED" | grep -c . || true)

if [ "$PRINT_TARGETS" -eq 1 ]; then
    while IFS= read -r rel; do
        [ -n "$rel" ] || continue
        [ -f "$ROOT/$rel" ] && printf '%s\n' "$rel"
    done <<< "$TRACKED"
    exit 0
fi

# Portable ISO-date -> midnight-local epoch. Returns nonzero when the date
# cannot be parsed; the caller FAILs on that rather than substituting a number.
iso_to_epoch() {
    date -j -f '%Y-%m-%d %H:%M:%S' "$1 00:00:00" '+%s' 2>/dev/null && return 0   # BSD / macOS
    date -d "$1 00:00:00" '+%s' 2>/dev/null && return 0                          # GNU
    return 1
}

TODAY=$(date '+%F')
if ! TODAY_EPOCH=$(iso_to_epoch "$TODAY"); then
    echo "ERROR: neither 'date -j -f' (BSD) nor 'date -d' (GNU) could parse '$TODAY'." >&2
    echo "       Refusing to run: age arithmetic is the whole check." >&2
    exit 2
fi

echo "check-freshness: newest date per tracked file vs ${MAX_AGE}-day window"
echo "Repo root: $ROOT | today: $TODAY | strict: FRESHNESS_REQUIRE_CURRENT=$REQUIRE_CURRENT"
echo "=============================================="

scanned=0
ok_n=0
stale_n=0
fault_n=0

while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    f="$ROOT/$rel"

    # A tracked path that no longer exists is an instrument fault, not a skip:
    # the check silently stops covering that file the moment someone moves it.
    if [ ! -f "$f" ]; then
        echo "FAULT: $rel — tracked but MISSING; this check has silently stopped covering it (fix the path or drop the row)"
        fault_n=$((fault_n + 1))
        continue
    fi
    scanned=$((scanned + 1))

    # Newest date NOT in the future: files legitimately carry forward-looking
    # dates (deadlines, DST flips) which are not review stamps. ISO dates sort
    # lexicographically, so a string compare is a date compare here.
    newest=$(grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}' "$f" | sort | awk -v t="$TODAY" '$0 <= t' | tail -1)
    if [ -z "$newest" ]; then
        echo "FAULT: $rel — carries no non-future ISO date at all; undatable state cannot be aged"
        fault_n=$((fault_n + 1))
        continue
    fi

    if ! newest_epoch=$(iso_to_epoch "$newest"); then
        echo "FAULT: $rel — newest date '$newest' will not parse; a failed measurement is not a measurement"
        fault_n=$((fault_n + 1))
        continue
    fi

    age_days=$(( (TODAY_EPOCH - newest_epoch) / 86400 ))
    if [ "$age_days" -gt "$MAX_AGE" ]; then
        echo "STALE: $rel — newest date $newest (${age_days}d old, window ${MAX_AGE}d) — due a re-check sweep"
        stale_n=$((stale_n + 1))
    else
        echo "OK:    $rel — newest date $newest (${age_days}d old)"
        ok_n=$((ok_n + 1))
    fi
done <<< "$TRACKED"

echo "=============================================="
echo "SCANNED $scanned of $N_CONFIGURED configured target(s) — $ok_n within window, $stale_n stale, $fault_n instrument fault(s)"

# Fail-closed: a run that aged nothing has not verified anything.
if [ "$scanned" -eq 0 ]; then
    echo "check-freshness FAILED — ZERO targets scanned. Scanning nothing is never a pass (R-0222)."
    exit 1
fi

if [ "$fault_n" -gt 0 ]; then
    echo "check-freshness FAILED — $fault_n instrument fault(s): the check is not measuring what it claims to."
    exit 1
fi

if [ "$stale_n" -gt 0 ]; then
    if [ "$REQUIRE_CURRENT" = "1" ]; then
        echo "check-freshness FAILED — $stale_n file(s) past the ${MAX_AGE}-day window (FRESHNESS_REQUIRE_CURRENT=1)."
        exit 1
    fi
    echo "check-freshness PASSED with warnings — $stale_n file(s) due; feed to the next weekly/quarterly sweep."
    echo "  (Staleness is calendar-driven and cannot be cleared by this push without faking a review date,"
    echo "   so it warns by default. Run with FRESHNESS_REQUIRE_CURRENT=1 to make it an exit code.)"
    exit 0
fi

echo "check-freshness PASSED — all $scanned scanned target(s) within the ${MAX_AGE}-day window."
exit 0
