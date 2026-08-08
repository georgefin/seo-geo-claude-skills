#!/usr/bin/env bash
# check-freshness.sh — advisory staleness check for dated pipeline state.
# The loop's registries and market snapshots carry review dates; when the newest
# date in a tracked file exceeds its re-check window, that file is due a sweep.
# Inspired by reference-freshness CI patterns surveyed 2026-08-08; ADVISORY ONLY:
# always exits 0 — staleness is a finding for the weekly/quarterly sweep, not a
# push blocker.
#
# Usage: ./scripts/check-freshness.sh [repo-root] [--max-age-days N]   (default: ., 90)

set -u

ROOT="${1:-.}"
MAX_AGE=90
if [ "${2:-}" = "--max-age-days" ] && [ -n "${3:-}" ]; then MAX_AGE="$3"; fi
[ "${1:-}" = "--max-age-days" ] && { MAX_AGE="${2:-90}"; ROOT="."; }

ROOT="$(cd "$ROOT" 2>/dev/null && pwd)" || { echo "ERROR: bad repo root" >&2; exit 0; }
TODAY_EPOCH=$(date +%s)

TRACKED="docs/loop/SETTLED-RULINGS.md
docs/loop/WATCH-ITEMS.md
docs/loop/GATED-ITEMS.md
docs/loop/PIPELINE.md
research/serp-analysis/references/skroutz-visibility-factors.md
research/keyword-research/references/greek-keyword-coverage.md"

echo "check-freshness: newest date per tracked file vs ${MAX_AGE}-day window"
echo "=============================================="
aged=0
while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    f="$ROOT/$rel"
    if [ ! -f "$f" ]; then
        echo "SKIP: $rel (missing)"
        continue
    fi
    # Newest date NOT in the future: files legitimately carry forward-looking dates
    # (deadlines, DST flips) which are not review stamps.
    today=$(date +%F)
    newest=$(grep -oE '20[0-9]{2}-[0-9]{2}-[0-9]{2}' "$f" | sort | awk -v t="$today" '$0 <= t' | tail -1)
    if [ -z "$newest" ]; then
        echo "WARN: $rel carries no ISO date at all — undatable state"
        aged=$((aged + 1))
        continue
    fi
    newest_epoch=$(date -d "$newest" +%s 2>/dev/null || echo 0)
    age_days=$(( (TODAY_EPOCH - newest_epoch) / 86400 ))
    if [ "$age_days" -gt "$MAX_AGE" ]; then
        echo "AGED: $rel — newest date $newest (${age_days}d old, window ${MAX_AGE}d) — due a re-check sweep"
        aged=$((aged + 1))
    else
        echo "OK:   $rel — newest date $newest (${age_days}d old)"
    fi
done <<< "$TRACKED"

echo "=============================================="
if [ "$aged" -gt 0 ]; then
    echo "check-freshness: $aged file(s) due — feed to the next weekly/quarterly sweep (advisory, not blocking)"
else
    echo "check-freshness: all tracked state within window"
fi
exit 0
