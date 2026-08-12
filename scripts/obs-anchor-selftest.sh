#!/usr/bin/env bash
# obs-anchor-selftest.sh — the R297 acceptance suite for scripts/obs-anchor-check.py.
#
# R297: a check that cannot FAIL is not a check. This suite proves the checker goes RED
# against known-bad states before any of its greens are worth quoting. It follows the
# F2/F9/check-(g)/claims-gate precedent: fault-injection fixtures, plus a negative control
# so "everything fails" cannot masquerade as "the detector works".
#
# THE PRIMARY RED IS NOT SYNTHETIC. Case R1 replays the actual defect from this repo's own
# history: `ceddc85` shipped docs/loop/OPEN-FINDINGS.md claiming "31 rows" under the anchor
# `[obs: `grep -cE '^\| [0-9]+ \|'` = 31 ...]`, and the anchor's own quoted command returns
# 32 against that same blob. Mode A pass 4 caught it by hand; the checker must catch it by
# machine. If that revision ever becomes unreachable this suite FAILS rather than skips —
# an R297 proof that silently stops running is worse than one that was never written.
#
# Exit: 0 all cases behaved, 1 any case did not.
# Every case reads the exit status DIRECTLY off the command, never through a pipe: in
# `cmd | tail; echo $?` the status is the pipe's LAST STAGE, not the tool's.

set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CHECK="$ROOT/scripts/obs-anchor-check.py"
FX="$ROOT/scripts/fixtures/obs-anchor"
HIST_REV="ceddc85"          # the commit that shipped the false anchor
OUT="$(mktemp -d)"
trap 'rm -rf "$OUT"' EXIT

PASS=0; FAIL=0
ok()   { printf 'PASS  %s\n' "$1"; PASS=$((PASS+1)); }
bad()  { printf 'FAIL  %s\n' "$1"; FAIL=$((FAIL+1)); }

# run <name> <expected-exit> <must-contain> -- <args...>
run() {
    local name=$1 want=$2 needle=$3; shift 4
    "$CHECK" "$@" > "$OUT/$name.txt" 2>&1
    local got=$?                       # read directly, no pipe in between
    if [ "$got" != "$want" ]; then
        bad "$name: exit $got, expected $want"
        sed -n '1,12p' "$OUT/$name.txt" | sed 's/^/      | /'
        return
    fi
    if [ -n "$needle" ] && ! grep -qF -- "$needle" "$OUT/$name.txt"; then
        bad "$name: exit $want as expected but output lacks $needle"
        sed -n '1,12p' "$OUT/$name.txt" | sed 's/^/      | /'
        return
    fi
    ok "$name (exit $got${needle:+, found $needle})"
}

echo "== R297 RED cases: the checker must fail on these =="

# R1 — the real historical defect. Unreachable history FAILS, never skips.
if git -C "$ROOT" rev-parse --verify --quiet "$HIST_REV^{commit}" >/dev/null; then
    run hist-red 1 "asserted 31" -- --at "$HIST_REV"
    if grep -qF "observed 32" "$OUT/hist-red.txt"; then
        ok "hist-red: observed 32 against the asserted 31 (the ceddc85 defect, by machine)"
    else
        bad "hist-red: no 'observed 32' line — the mismatch was not measured"
    fi
else
    bad "hist-red: revision $HIST_REV unreachable; the primary R297 proof CANNOT BE RUN."
fi

run synth-mismatch 1 "observed 3"      -- "$FX/mismatch"
run bad-provenance 1 "UNRESOLVABLE"    -- "$FX/provenance"
run floor-collapse 1 "--min-checkable" -- --min-checkable 1 "$FX/unsafe"

echo
echo "== Fail-closed cases: exit 2, never a green =="
# git cannot track an empty directory, so this fixture is made at run time rather than
# shipped — a shipped one would silently vanish on clone and the case would stop testing.
mkdir -p "$OUT/empty-dir"
run empty-corpus  2 "directory contains no .md" -- "$OUT/empty-dir"
run missing-path  2 "(not found)"               -- "$FX/no-such-path"
run zero-anchors  2 "0 [obs:] anchors parsed"   -- "$FX/noanchor"
run unparseable   2 "unparseable anchor"        -- "$FX/broken"

echo
echo "== Negative controls: these must NOT fail, or the RED cases prove nothing =="
run clean-green   0 "1 checkable anchor claim"  -- "$FX/clean"
run zero-allowed  0 ""                          -- --allow-zero-anchors "$FX/noanchor"
run head-green    0 "GREEN"                     -- --at HEAD

echo
echo "== Safety: hostile anchor content must be REFUSED, and provably not executed =="
rm -f /tmp/obs-anchor-PWNED-A /tmp/obs-anchor-PWNED-B \
      /tmp/obs-anchor-PWNED-C /tmp/obs-anchor-PWNED-D
run hostile-refused 0 "unsafe-syntax" -- "$FX/unsafe"
SENTINELS=0
for s in A B C D; do
    [ -e "/tmp/obs-anchor-PWNED-$s" ] && { SENTINELS=$((SENTINELS+1)); rm -f "/tmp/obs-anchor-PWNED-$s"; }
done
if [ "$SENTINELS" -eq 0 ]; then
    ok "hostile-sentinels: 0 of 4 side-effect files created (no shell interpreted the anchors)"
else
    bad "hostile-sentinels: $SENTINELS of 4 side-effect files WERE created — anchor content executed"
fi
if grep -qF "head-not-allowlisted" "$OUT/hostile-refused.txt"; then
    ok "hostile-refused: non-allowlisted heads (curl, sed) rejected by whitelist"
else
    bad "hostile-refused: curl/sed were not rejected as head-not-allowlisted"
fi

echo
echo "----------------------------------------------------------------"
echo "$PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1
# The category counts are NOT restated here. A hand-written "4 RED, 3 fail-closed" in a
# summary is a claim about the run above it, and this file's first version got it wrong
# (4 fail-closed cases, summarised as 3) — the F20 class, in the acceptance suite for a
# tool built to catch it. The case list above is the record; the total is derived.
echo "GREEN - all $PASS cases behaved: the RED cases went red (one of them the real"
echo "        $HIST_REV defect, replayed from history), the fail-closed cases exited 2,"
echo "        the negative controls passed, and no hostile anchor executed."
exit 0
