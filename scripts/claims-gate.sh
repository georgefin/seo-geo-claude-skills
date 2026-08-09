#!/usr/bin/env bash
# claims-gate.sh — F11 drafting-integrity gate on the outgoing register diff.
#
# Ledger entry: FAILURE-LEDGER.md F11 (founding classes: stale sibling field,
# forward-approximated timestamp, attribution gloss; recurrences r1-r5 — word-level
# frame drift, mechanism-in-observed-frame, "end-to-end" overclaim, post-flip stale
# sibling, register-wide stale live-state claims). Spec: MASTER-IMPROVEMENT-PLAN.md
# 1b (G5). This gate enforces FORM, not truth: it forces live-state claims to carry
# evidence anchors and executes F11-r5's whole-register re-scan by machine. The
# truth leg stays with the mandatory Mode A review (plan 0.1).
#
# SCOPE (what is scanned): ADDED lines of the register files — docs/loop/*.md at
# the top level (archive/, eval-baselines/, reports/ excluded: frozen snapshots and
# dated records) plus VERSIONS.md. PR bodies and GitHub comments are outside a repo
# gate's reach (limitation on record, plan 1b).
#
# DIFF BASE (the "outgoing diff"): committed outgoing work `<base>...HEAD` (base =
# $1, else @{upstream}, else origin/main, else skipped with a note) PLUS staged +
# worktree changes (`git diff HEAD`). Untracked files enter the scan once staged.
#
# RULES
#   (1) anchored claims — an added line matching the risk lexicon must carry, on
#       the line or within +/-2 lines of the same hunk: an `[obs:<ISO> <token>]`
#       anchor, a quoted-output fence (``` line; lines INSIDE fences are treated as
#       quoted evidence and skipped entirely), or a "historical as of" marker.
#       Hard-FAIL tier (built from the recorded F11 instances): end-to-end, works,
#       live, blocked, succeed(s), remains, "until this … merge[s/d]".
#       WARN tier (broader frame; tighten weekly): verified/probe-verified,
#       confirmed, in flight, awaiting, currently. WARNs do not fail the gate
#       unless CLAIMS_GATE_WARN_AS_FAIL=1. Text inside straight double quotes or
#       backticks is masked first (a quoted phrase is a citation, not a claim), as
#       are the stable phrases in scripts/claims-gate-allowlist.txt.
#   (2) flip-manifest sweep — a diff that changes a Status:/Verdict: field or adds
#       a verdict-log entry requires a FLIP: trailer in an outgoing commit message
#       (or in a flip-manifest file, $CLAIMS_GATE_FLIP_MANIFEST, default
#       docs/loop/flip-manifest.txt — for pre-commit runs). Grammar, one per line:
#           FLIP: <entity> [@ <ISO-timestamp>] -- <token> [;; <token>]...
#           FLIP: <entity> -- none          (explicit "no touched claims")
#       Every named token is grepped (case-insensitive, fixed string) across the
#       WHOLE register set; a hit FAILs unless it is quoted/backticked, inside a
#       fence, within +/-2 lines of a "historical as of" / [obs:] marker, or (when
#       the trailer carries @ <ISO>) the hit line itself carries a post-flip
#       timestamp (full timestamp >= flip time, or date-only strictly after the
#       flip date — an equal bare date does not prove post-flip). Pick tokens
#       short enough to survive the registers' ~85-char line wrap (<=4 words is
#       safe): the sweep is line-based and cannot match across a wrap.
#   (3) timestamp sanity — added ISO timestamps must not postdate the gate clock
#       (fixture mode: now.txt). Forward-looking dates are legitimate when the
#       +/-2-line window carries a schedule/deadline marker (expected, scheduled,
#       deadline, due, before, first, armed, once, until, re-check, "by 20NN", …)
#       — the F5 lesson: deadline dates are not event records. Tilde-approximated
#       times (~HH:MMZ) FAIL when presented as the record of an event; they are
#       tolerated inside **bold** entry-header labels (the house form:
#       `**Verdict log — … (ninth entry, ~10:47Z)**:`, `**Superseded (… ~07:51Z)**`)
#       and on schedule-marked lines (a "~04:08Z expected fire" is an estimate of
#       the future, not a record of the past). Exact-form future timestamps are
#       compared against the GATE clock, not each commit's own time; the founding
#       forward-approximation class ("~08:25Z" written at 08:17Z) is caught by the
#       tilde rule by form, clock-independently.
#
# FIXTURE MODE (fault-injection, F2/F9/(g) precedent):
#   claims-gate.sh --fixture <dir>   with <dir> containing:
#     diff.patch      unified diff standing in for the outgoing diff (required)
#     commit-msg.txt  commit message(s), FLIP: trailers included (optional)
#     registers/      post-state register tree for the rule-2 sweep:
#                     registers/docs/loop/*.md, registers/VERSIONS.md (optional)
#     now.txt         frozen gate clock, full ISO `YYYY-MM-DDTHH:MM:SSZ` (optional)
#     expect.txt      human-readable expected outcome (not read by this script)
#   Fixtures for every recorded F11 instance live in scripts/fixtures/claims-gate/.
#
# EVERY failure prints the offending line (house evidence-print rule, ledger F7 —
# no bare booleans). Exit: 0 = pass (warnings allowed), 1 = any FAIL, 2 = usage.
# No network access. Dependencies: bash, git (repo mode), grep, sed, awk, date.

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
ALLOWF="$ROOT/scripts/claims-gate-allowlist.txt"

FIXTURE=""
BASE_ARG=""
if [ "${1:-}" = "--fixture" ]; then
    FIXTURE="${2:-}"
    if [ -z "$FIXTURE" ] || [ ! -d "$FIXTURE" ]; then
        echo "ERROR: --fixture requires an existing directory" >&2
        exit 2
    fi
    FIXTURE="$(cd "$FIXTURE" && pwd)"
    if [ ! -f "$FIXTURE/diff.patch" ]; then
        echo "ERROR: fixture $FIXTURE has no diff.patch" >&2
        exit 2
    fi
else
    BASE_ARG="${1:-}"
fi

PASS_N=0
FAIL_N=0
WARN_N=0
pass() { printf 'PASS: %s\n' "$1"; PASS_N=$((PASS_N + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; FAIL_N=$((FAIL_N + 1)); }
warn() { printf 'WARN: %s\n' "$1"; WARN_N=$((WARN_N + 1)); }
evline() { printf '      + %s\n' "$1"; }   # offending-line evidence print

# ---------------------------------------------------------------------------
# Gather: the diff text, the commit-message/trailer source, the clock, and the
# register set the rule-2 sweep runs over.
# ---------------------------------------------------------------------------
if [ -n "$FIXTURE" ]; then
    DIFF_TEXT=$(cat "$FIXTURE/diff.patch")
    MSG_TEXT=""
    [ -f "$FIXTURE/commit-msg.txt" ] && MSG_TEXT=$(cat "$FIXTURE/commit-msg.txt")
    if [ -f "$FIXTURE/now.txt" ]; then
        NOW=$(tr -d '[:space:]' < "$FIXTURE/now.txt")
    else
        NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    fi
    REGROOT="$FIXTURE/registers"
    BASE_DESC="fixture diff.patch"
else
    if [ -n "$BASE_ARG" ]; then
        BASE="$BASE_ARG"
    elif git -C "$ROOT" rev-parse --verify --quiet '@{upstream}' >/dev/null 2>&1; then
        BASE='@{upstream}'
    elif git -C "$ROOT" rev-parse --verify --quiet origin/main >/dev/null 2>&1; then
        BASE='origin/main'
    else
        BASE=""
    fi
    DIFF_TEXT=""
    MSG_TEXT=""
    if [ -n "$BASE" ] && git -C "$ROOT" rev-parse --verify --quiet "$BASE" >/dev/null 2>&1; then
        DIFF_TEXT=$(git -C "$ROOT" diff --no-color -U3 "$BASE...HEAD" 2>/dev/null)
        MSG_TEXT=$(git -C "$ROOT" log --format=%B "$BASE..HEAD" 2>/dev/null)
        BASE_DESC="$BASE...HEAD + staged/worktree"
    else
        BASE_DESC="staged/worktree only (no base ref resolvable)"
    fi
    WT_DIFF=$(git -C "$ROOT" diff --no-color -U3 HEAD 2>/dev/null || true)
    DIFF_TEXT="$DIFF_TEXT
$WT_DIFF"
    MANIFEST="${CLAIMS_GATE_FLIP_MANIFEST:-$ROOT/docs/loop/flip-manifest.txt}"
    if [ -f "$MANIFEST" ]; then
        MSG_TEXT="$MSG_TEXT
$(cat "$MANIFEST")"
    fi
    NOW=$(date -u +%Y-%m-%dT%H:%M:%SZ)
    REGROOT="$ROOT"
fi
NOWD=${NOW:0:10}
NOWT=${NOW:11:8}
[ -n "$NOWT" ] || NOWT="00:00:00"

echo "claims-gate: F11 drafting-integrity checks on the outgoing register diff"
if [ -n "$FIXTURE" ]; then
    echo "Fixture: $FIXTURE"
else
    echo "Repo root: $ROOT"
fi
echo "Diff source: $BASE_DESC | Gate clock: $NOW"
echo "=============================================="

# ---------------------------------------------------------------------------
# Single scan pass over the diff (rules 1 and 3 + rule-2 flip detection).
# Emits tab-separated records:  SCAN<TAB>n | H1/W1<TAB>loc<TAB>tokens<TAB>line
# | T3<TAB>loc<TAB>line | F3<TAB>loc<TAB>ts<TAB>line | FLIP<TAB>loc<TAB>line
# ---------------------------------------------------------------------------
AWKPROG='
function futm(t) {
    # schedule/deadline context markers (F5 lesson: forward-looking dates are
    # legitimate when the text says so)
    if (t ~ /(^|[^a-z0-9])(expected|scheduled|deadline|due|next|upcoming|re-?check|before|window|first|fires?|armed|arms|once|resets?|planned|expires?|expiry|until|target|reminder|quarterly)([^a-z0-9]|$)/) return 1
    if (t ~ /by 20[0-9][0-9]/) return 1
    return 0
}
function hardhits(s,   out) {
    out = ""
    if (s ~ /(^|[^a-z0-9])end-to-end([^a-z0-9]|$)/)      out = out "end-to-end,"
    if (s ~ /(^|[^a-z0-9])works([^a-z0-9]|$)/)           out = out "works,"
    if (s ~ /(^|[^a-z0-9])live([^a-z0-9]|$)/)            out = out "live,"
    if (s ~ /(^|[^a-z0-9])blocked([^a-z0-9]|$)/)         out = out "blocked,"
    if (s ~ /(^|[^a-z0-9])succeeds?([^a-z0-9]|$)/)       out = out "succeed(s),"
    if (s ~ /(^|[^a-z0-9])remains([^a-z0-9]|$)/)         out = out "remains,"
    if (s ~ /until this[^.]*merge/)                      out = out "until-this-...-merges,"
    sub(/,$/, "", out); return out
}
function warnhits(s,   out) {
    out = ""
    if (s ~ /(^|[^a-z0-9])verified([^a-z0-9]|$)/)        out = out "verified,"
    if (s ~ /(^|[^a-z0-9])confirmed([^a-z0-9]|$)/)       out = out "confirmed,"
    if (s ~ /(^|[^a-z0-9])in[- ]flight([^a-z0-9]|$)/)    out = out "in-flight,"
    if (s ~ /(^|[^a-z0-9])awaiting([^a-z0-9]|$)/)        out = out "awaiting,"
    if (s ~ /(^|[^a-z0-9])currently([^a-z0-9]|$)/)       out = out "currently,"
    sub(/,$/, "", out); return out
}
function isfuture(ts,   d, tm) {
    d = substr(ts, 1, 10)
    if (d > NOWD) return 1
    if (d < NOWD) return 0
    if (length(ts) < 12) return 0          # bare same-day date: not future
    tm = substr(ts, 12); sub(/Z$/, "", tm)
    if (length(tm) == 5) tm = tm ":00"
    return (tm > NOWT) ? 1 : 0             # lexicographic, both zero-padded
}
function flushhunk(   i, j, k, fences, t, raw, low, exempt, fmark, bm, toks, rest, ts, pos) {
    if (hn == 0) return
    fences = 0
    for (i = 1; i <= hn; i++) {            # fence parity within the hunk
        infence[i] = fences % 2
        if (htext[i] ~ /^```/) fences++
    }
    for (i = 1; i <= hn; i++) {
        if (hkind[i] != "+") continue
        scanned++
        if (infence[i]) continue           # quoted-output fence: evidence, skip
        raw = htext[i]
        exempt = 0; fmark = 0              # +/-2-line window (new-file lines only)
        for (j = i - 2; j <= i + 2; j++) {
            if (j < 1 || j > hn) continue
            if (hkind[j] == "-") continue
            t = tolower(htext[j])
            if (t ~ /\[obs:[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]/) exempt = 1
            if (index(t, "historical as of") > 0) exempt = 1
            if (htext[j] ~ /^```/) exempt = 1
            if (futm(t)) fmark = 1
        }
        # masked-lowered copy: quoted spans, backtick spans, allowlist phrases
        low = tolower(raw)
        gsub(/"[^"]*"/, " % ", low)
        gsub(/`[^`]*`/, " % ", low)
        for (k = 1; k <= na; k++)
            while ((pos = index(low, allow[k])) > 0)
                low = substr(low, 1, pos - 1) " % " substr(low, pos + length(allow[k]))
        # rule-2 input: Status:/Verdict: field or verdict-log entry added
        if (low ~ /(\*\*)?(status|verdict)(\*\*)?[ \t]*:/ || index(low, "**verdict log") > 0)
            printf "FLIP\t%s:%d\t%s\n", file, hline[i], raw
        if (!exempt) {
            toks = hardhits(low)
            if (toks != "") printf "H1\t%s:%d\t%s\t%s\n", file, hline[i], toks, raw
            else {
                toks = warnhits(low)
                if (toks != "") printf "W1\t%s:%d\t%s\t%s\n", file, hline[i], toks, raw
            }
            # rule 3a: exact ISO timestamps vs the gate clock
            if (!fmark) {
                rest = raw
                while (match(rest, /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9](T[0-9][0-9]:[0-9][0-9](:[0-9][0-9])?Z?)?/)) {
                    ts = substr(rest, RSTART, RLENGTH)
                    rest = substr(rest, RSTART + RLENGTH)
                    if (isfuture(ts)) printf "F3\t%s:%d\t%s\t%s\n", file, hline[i], ts, raw
                }
            }
            # rule 3b: tilde times in prose (bold header labels masked out)
            bm = raw
            gsub(/\*\*[^*]+\*\*/, " B ", bm)   # closed bold spans
            sub(/\*\*.*$/, " B", bm)           # dangling opener: bold to EOL
            if (bm ~ /~[0-9][0-9]?:[0-9][0-9]/ && !fmark)
                printf "T3\t%s:%d\t%s\n", file, hline[i], raw
        }
    }
    hn = 0
}
BEGIN {
    na = 0
    while ((getline al < ALLOWF) > 0) {
        sub(/\r$/, "", al)
        if (al ~ /^[ \t]*(#|$)/) continue
        na++; allow[na] = tolower(al)
    }
    close(ALLOWF)
    scanned = 0; hn = 0; file = ""; inscope = 0; newno = 0
}
/^\+\+\+ /  { flushhunk()
              file = $0; sub(/^\+\+\+ /, "", file); sub(/^b\//, "", file)
              inscope = (file ~ /^docs\/loop\/[^\/]+\.md$/ || file == "VERSIONS.md")
              next }
/^--- /     { next }
/^diff /    { flushhunk(); inscope = 0; next }
/^(index |new file|deleted file|similarity |rename |old mode|new mode|Binary files)/ { next }
/^@@/       { flushhunk()
              match($0, /\+[0-9]+/)
              newno = substr($0, RSTART + 1, RLENGTH - 1) + 0
              next }
/^\\/       { next }
{
    if (!inscope) next
    c = substr($0, 1, 1)
    if (c == "+")      { hn++; hkind[hn] = "+"; hline[hn] = newno; htext[hn] = substr($0, 2); newno++ }
    else if (c == "-") { hn++; hkind[hn] = "-"; hline[hn] = 0;     htext[hn] = substr($0, 2) }
    else               { hn++; hkind[hn] = " "; hline[hn] = newno; htext[hn] = substr($0, 2); newno++ }
}
END { flushhunk(); printf "SCAN\t%d\n", scanned }
'

SCANOUT=$(printf '%s\n' "$DIFF_TEXT" | awk -v ALLOWF="$ALLOWF" -v NOWD="$NOWD" -v NOWT="$NOWT" "$AWKPROG")
SCANNED=$(printf '%s\n' "$SCANOUT" | awk -F'\t' '$1 == "SCAN" { print $2; exit }')
[ -n "$SCANNED" ] || SCANNED=0

# ---------------------------------------------------------------------------
# [1] anchored-claims lexicon
# ---------------------------------------------------------------------------
echo ""
echo "[1] anchored-claims lexicon (rule 1)"
R1_OK=1
while IFS=$'\t' read -r tag loc toks raw; do
    [ "$tag" = "H1" ] || continue
    fail "(1) $loc hard-lexicon token(s) [$toks] with no [obs:] anchor, output fence, or 'historical as of' marker in reach"
    evline "$raw"
    R1_OK=0
done <<< "$SCANOUT"
while IFS=$'\t' read -r tag loc toks raw; do
    [ "$tag" = "W1" ] || continue
    if [ "${CLAIMS_GATE_WARN_AS_FAIL:-0}" = "1" ]; then
        fail "(1) $loc WARN-tier token(s) [$toks] unanchored (promoted: CLAIMS_GATE_WARN_AS_FAIL=1)"
        R1_OK=0
    else
        warn "(1) $loc WARN-tier token(s) [$toks] unanchored — anchor it, allowlist the stable phrase, or leave for Mode A"
    fi
    evline "$raw"
done <<< "$SCANOUT"
if [ "$R1_OK" -eq 1 ]; then
    if [ "$SCANNED" -eq 0 ]; then
        pass "(1) no added lines in scoped register files (docs/loop/*.md, VERSIONS.md) — nothing to scan"
    else
        pass "(1) $SCANNED added register line(s) scanned; every hard-lexicon hit anchored, quoted, or allowlisted"
    fi
fi

# ---------------------------------------------------------------------------
# [2] flip-manifest sweep
# ---------------------------------------------------------------------------
echo ""
echo "[2] flip-manifest sweep (rule 2)"

# helpers ------------------------------------------------------------------
token_live_outside_quotes() {  # $1=line $2=token(lowered); exit 0 = live hit
    printf '%s\n' "$1" | awk -v TOK="$2" '
        { s = tolower($0)
          gsub(/"[^"]*"/, " % ", s)
          gsub(/`[^`]*`/, " % ", s)
          exit (index(s, TOK) > 0) ? 0 : 1 }'
}
inside_fence() {               # $1=file $2=lineno; exit 0 = inside ``` fence
    awk -v N="$2" 'NR >= N { exit } /^```/ { c++ } END { exit (c % 2) ? 0 : 1 }' "$1"
}
window_has_marker() {          # $1=file $2=lineno; +/-2 lines in the file
    local s=$(( $2 > 2 ? $2 - 2 : 1 ))
    sed -n "${s},$(( $2 + 2 ))p" "$1" | grep -qiE 'historical as of|\[obs:[0-9]{4}-[0-9]{2}-[0-9]{2}'
}
line_has_postflip_ts() {       # $1=line $2=flip-ISO (may be empty)
    [ -n "$2" ] || return 1
    printf '%s\n' "$1" | awk -v F="$2" '
        BEGIN { fd = substr(F, 1, 10); ft = substr(F, 12); sub(/Z$/, "", ft)
                if (length(ft) == 5) ft = ft ":00"; if (ft == "") ft = "00:00:00" }
        { rest = $0; ok = 0
          while (match(rest, /[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9](T[0-9][0-9]:[0-9][0-9](:[0-9][0-9])?Z?)?/)) {
              ts = substr(rest, RSTART, RLENGTH); rest = substr(rest, RSTART + RLENGTH)
              d = substr(ts, 1, 10)
              if (d > fd) ok = 1
              else if (d == fd && length(ts) >= 12) {
                  tm = substr(ts, 12); sub(/Z$/, "", tm)
                  if (length(tm) == 5) tm = tm ":00"
                  if (tm >= ft) ok = 1
              }
          }
          exit ok ? 0 : 1 }'
}

FLIPS=$(printf '%s\n' "$SCANOUT" | grep '^FLIP' || true)
if [ -z "$FLIPS" ]; then
    pass "(2) no Status:/Verdict: field changes or verdict-log additions in the outgoing diff — flip sweep not required"
else
    NFLIP=$(printf '%s\n' "$FLIPS" | grep -c . || true)
    TRAILERS=$(printf '%s\n' "$MSG_TEXT" | grep '^FLIP:' || true)
    if [ -z "$TRAILERS" ]; then
        fail "(2) $NFLIP Status/Verdict/verdict-log line(s) added but NO 'FLIP:' trailer in outgoing commit messages or flip-manifest — declare the flipped entity and its touched-claim tokens (or '-- none')"
        while IFS=$'\t' read -r tag loc raw; do
            [ "$tag" = "FLIP" ] || continue
            evline "$loc: $raw"
        done <<< "$FLIPS"
    else
        # register set the sweep runs over
        REG_FILES=""
        if [ -d "$REGROOT/docs/loop" ] || [ -f "$REGROOT/VERSIONS.md" ]; then
            REG_FILES=$( { find "$REGROOT/docs/loop" -maxdepth 1 -name '*.md' 2>/dev/null | sort
                           [ -f "$REGROOT/VERSIONS.md" ] && echo "$REGROOT/VERSIONS.md"; } )
        fi
        NREG=$(printf '%s\n' "$REG_FILES" | grep -c . || true)
        R2_OK=1
        ENTITIES=""
        NTOK=0
        NHIT=0
        while IFS= read -r tline; do
            [ -n "$tline" ] || continue
            body=${tline#FLIP:}
            body=$(printf '%s' "$body" | sed 's/^[ \t]*//; s/[ \t]*$//')
            case "$body" in
                *" -- "*) : ;;
                *) fail "(2) malformed FLIP trailer (need 'FLIP: <entity> [@ <ISO>] -- <token>[ ;; <token>]…' or '-- none')"
                   evline "$tline"; R2_OK=0; continue ;;
            esac
            fliphead=${body%% -- *}
            toks=${body#* -- }
            flipiso=""
            case "$fliphead" in
                *" @ "*) entity=${fliphead%% @ *}; flipiso=${fliphead#* @ } ;;
                *)       entity=$fliphead ;;
            esac
            ENTITIES="$ENTITIES$entity, "
            while IFS= read -r tok; do
                tok=$(printf '%s' "$tok" | sed 's/^[ \t]*//; s/[ \t]*$//')
                [ -n "$tok" ] || continue
                [ "$tok" = "none" ] && continue
                NTOK=$((NTOK + 1))
                tokl=$(printf '%s' "$tok" | tr '[:upper:]' '[:lower:]')
                while IFS= read -r rf; do
                    [ -n "$rf" ] || continue
                    while IFS= read -r hit; do
                        [ -n "$hit" ] || continue
                        hno=${hit%%:*}
                        htx=${hit#*:}
                        NHIT=$((NHIT + 1))
                        token_live_outside_quotes "$htx" "$tokl" || continue   # quoted citation
                        inside_fence "$rf" "$hno" && continue                  # quoted output
                        window_has_marker "$rf" "$hno" && continue             # historical/[obs:]
                        line_has_postflip_ts "$htx" "$flipiso" && continue     # post-flip stamp
                        fail "(2) ${rf#"$REGROOT"/}:$hno stale claim — token \"$tok\" (flip: $entity${flipiso:+ @ $flipiso}) with no post-flip timestamp or historical marker"
                        evline "$htx"
                        R2_OK=0
                    done < <(grep -inF -- "$tok" "$rf" || true)
                done <<< "$REG_FILES"
            done < <(printf '%s\n' "$toks" | sed 's/[ \t]*;;[ \t]*/\n/g')
        done <<< "$TRAILERS"
        if [ "$R2_OK" -eq 1 ]; then
            if [ "$NTOK" -eq 0 ]; then
                pass "(2) flip declared (${ENTITIES%, }) with explicit '-- none' touched-claim tokens — nothing to sweep"
            elif [ "$NREG" -eq 0 ]; then
                warn "(2) flip declared (${ENTITIES%, }) naming $NTOK token(s) but no register tree to sweep at $REGROOT — sweep skipped"
            else
                pass "(2) flip declared (${ENTITIES%, }); $NTOK token(s) swept across $NREG register file(s), $NHIT hit(s) — all quoted, marked historical, or post-flip-stamped"
            fi
        fi
    fi
fi

# ---------------------------------------------------------------------------
# [3] timestamp sanity
# ---------------------------------------------------------------------------
echo ""
echo "[3] timestamp sanity (rule 3)"
R3_OK=1
while IFS=$'\t' read -r tag loc ts raw; do
    [ "$tag" = "F3" ] || continue
    fail "(3) $loc ISO timestamp '$ts' postdates the gate clock $NOW and carries no schedule/deadline marker — event records cannot be future-dated"
    evline "$raw"
    R3_OK=0
done <<< "$SCANOUT"
while IFS=$'\t' read -r tag loc raw; do
    [ "$tag" = "T3" ] || continue
    fail "(3) $loc tilde-approximated time presented as the record of an event — read the clock (date -u) instead; '~HH:MMZ' is tolerated only inside **bold** entry-header labels or schedule-marked lines"
    evline "$raw"
    R3_OK=0
done <<< "$SCANOUT"
if [ "$R3_OK" -eq 1 ]; then
    if [ "$SCANNED" -eq 0 ]; then
        pass "(3) no added register lines — no timestamps to check"
    else
        pass "(3) all added-line timestamps at or before the gate clock; no tilde-approximated event records"
    fi
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo ""
echo "=============================================="
echo "Results: $PASS_N passed, $WARN_N warnings, $FAIL_N failed"
if [ "$FAIL_N" -gt 0 ]; then
    echo "claims-gate FAILED — anchor the claims, declare the flip, or fix the timestamps before pushing"
    exit 1
fi
if [ "$WARN_N" -gt 0 ]; then
    echo "claims-gate PASSED with warnings (WARN-tier lexicon; Mode A owns the truth leg)"
else
    echo "claims-gate PASSED"
fi
exit 0
