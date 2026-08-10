#!/usr/bin/env bash
# register-lock.sh — advisory write-lock ledger for the shared, un-owned files
# (the loop registers: VERSIONS.md, docs/loop/*.md), plus the pre-push check that
# judges outgoing commits against that ledger.
#
# Why this exists: ledger F14, "second mechanism, same failure family"
# (2026-08-10). An authoring agent's one-line pointer refresh in
# docs/loop/GATED-ITEMS.md landed inside the coordinator's G9/W12 register
# commits, which describe unrelated work. Both actors edit the shared registers,
# so the coordinator staged one explicitly named file it was legitimately
# editing and swept the other workstream's hunk with it.
# `commit-scope-check.sh` cannot see this: its unit is the skill directory and a
# register file has no owning skill. The ledger names the honest mitigation as
# sequencing ("hold register commits while a register-writing agent is in
# flight") and names sequencing as vigilance, which the no-manual-vigilance
# directive rejects as a guard. This script is the code that entry asked for.
#
# MODEL — an append-only TSV JOURNAL of lock events, gitignored, never committed:
#     ACQUIRE <iso> <epoch> <holder> <path>
#     RELEASE <iso> <epoch> <holder> <path>
#     BREAK   <iso> <epoch> <breaker> <path> <victim> <stale|steal>
#   Append-only is the load-bearing choice: a release must not erase the tenure,
#   or the gate could no longer answer "who had this path open at commit time?"
#   AFTER the fact — which is the question F14's queued proposal is about.
#
# TENURE BOUNDS (second resolution; each rule earns its asymmetry):
#   RELEASE-closed  [acquire, release)          — the release proves the holder
#                                                 lived that long, and declares
#                                                 the writing stopped there.
#   BREAK stale     [acquire, min(break, +TTL)) — the horizon, not the break
#                                                 time, is what made it stale.
#   BREAK steal     [acquire, break)            — it was live when taken.
#   never closed    [acquire, min(now, +TTL)]   — a crashed agent's lock decays
#                                                 instead of poisoning every
#                                                 later commit forever.
#
# STALENESS — horizon REGISTER_LOCK_TTL_MIN minutes (default 90; authoring runs
#   in this repo land well inside it). A stale tenure is never silently honoured:
#   `acquire` REFUSES on it and prints it as STALE with the override, `status`
#   prints it as STALE, and `gate-check` WARNs about every stale open tenure it
#   sees. Overrides are recorded as BREAK events, so a steal is auditable rather
#   than invisible.
#
# WHAT THE GATE CAN AND CANNOT PROVE (read this before trusting it — F11):
#   Git records no session identity: every agent in this shared worktree commits
#   with the same author. So "was this commit made by the holder?" is NOT
#   answerable from the commit alone. Two legs close that honestly:
#     (1) PREVENTION at write time — `acquire` refuses a path another live
#         holder already holds, so the concurrent-write window never opens.
#         This leg needs no attribution and is the stronger one.
#     (2) DETECTION at push time — `gate-check` FAILs an outgoing commit that
#         touched a locked path inside a holder's tenure UNLESS the commit
#         message declares that holder in a `Register-Lock: <holder>` trailer.
#         The trailer is what makes the post-hoc question answerable; without
#         it the check would have to guess, and a guessing gate is F11 bait.
#   Consequences, stated plainly: a commit is only checked when the ledger shows
#   a tenure covering it, so a session that never acquires a lock is never
#   blocked (zero friction, by construction) — and equally, a writer that skips
#   `acquire` is invisible to leg 2. The ledger is advisory, not enforced by the
#   filesystem: it constrains actors that use it.
#
# COMMANDS
#   acquire --as <holder> [--force] [--steal] <path>...
#         Announce intent to write the paths. Refuses if a DIFFERENT holder has
#         an overlapping path open: --force breaks STALE holders, --steal breaks
#         live ones (loud, recorded). Re-acquiring your own path is a no-op.
#   release --as <holder> [<path>...]
#         End the tenure (default: every path the holder still holds). Always
#         exits 0 — releasing what you do not hold must never block anyone.
#   status
#         Print open tenures with age and live/stale state.
#   gate-check [<base-ref>]
#         Pre-push check over outgoing commits (base arg, else @{upstream}).
#
# A locked path is matched exactly, or as a directory prefix when it ends in "/"
# (e.g. `docs/loop/` covers every register in that directory).
#
# Env: REGISTER_LOCK_FILE (journal path, default <root>/.register-locks — the
#      override is how the acceptance scenarios run without touching the real
#      ledger), REGISTER_LOCK_TTL_MIN (staleness horizon, default 90).
# Exit: 0 = ok/pass, 1 = refused/FAIL, 2 = usage error. No network access.
# Dependencies: bash, git (gate-check only), awk, date; flock(1) when available.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; NC=$'\033[0m'

LOCKFILE="${REGISTER_LOCK_FILE:-$ROOT/.register-locks}"
TTL_MIN="${REGISTER_LOCK_TTL_MIN:-90}"
case "$TTL_MIN" in
    ''|*[!0-9]*) echo "ERROR: REGISTER_LOCK_TTL_MIN must be whole minutes" >&2; exit 2 ;;
esac
TTL=$((TTL_MIN * 60))
NOW=$(date -u +%s)
NOW_ISO=$(date -u +%Y-%m-%dT%H:%M:%SZ)

usage() {
    sed -n '/^# COMMANDS/,/^#$/p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
    echo "Full contract, including what the gate can and cannot prove: head -82 $0"
    exit 2
}

# ---------------------------------------------------------------------------
# Journal reading: reconstruct tenures as intervals, per the TENURE BOUNDS rules
# in the header. end_epoch is INCLUSIVE, so a close event at T yields T-1: a
# commit written in the same second as the release is on the released side.
# Emits, one per line:
#   holder \t path \t start_epoch \t end_epoch \t start_iso \t state
#   state = live | stale | closed | closed-stale | closed-stolen
# ---------------------------------------------------------------------------
intervals() {
    [ -f "$LOCKFILE" ] || return 0
    awk -F'\t' -v NOW="$NOW" -v TTL="$TTL" '
        function emit(key, endep, state) {
            printf "%s\t%s\t%d\t%d\t%s\t%s\n",
                   oholder[key], opath[key], ostart[key], endep, oiso[key], state
            delete ostart[key]; delete oiso[key]; delete oholder[key]; delete opath[key]
        }
        $1 == "ACQUIRE" {
            key = $4 SUBSEP $5
            if (key in ostart) next               # already open: acquire is idempotent
            ostart[key] = $3 + 0; oiso[key] = $2; oholder[key] = $4; opath[key] = $5
            ord[++n] = key
            next
        }
        $1 == "RELEASE" { key = $4 SUBSEP $5; if (key in ostart) emit(key, $3 - 1, "closed"); next }
        $1 == "BREAK"   {
            key = $6 SUBSEP $5
            if (!(key in ostart)) next
            endep = $3 - 1
            if ($7 == "stale") {                  # the horizon bounds it, not the break
                expiry = ostart[key] + TTL
                if (endep > expiry) endep = expiry
                emit(key, endep, "closed-stale")
            } else emit(key, endep, "closed-stolen")
            next
        }
        END {
            for (i = 1; i <= n; i++) {
                key = ord[i]
                if (!(key in ostart)) continue
                expiry = ostart[key] + TTL
                if (NOW < expiry) emit(key, NOW, "live")
                else              emit(key, expiry, "stale")
            }
        }' "$LOCKFILE"
}

open_tenures() { intervals | awk -F'\t' '$6 !~ /^closed/'; }

# Exact match, or directory-prefix match when the LOCKED path ends in "/".
path_overlap() {   # $1 = locked path, $2 = candidate path
    [ "$1" = "$2" ] && return 0
    case "$1" in */) case "$2" in "$1"*) return 0 ;; esac ;; esac
    case "$2" in */) case "$1" in "$2"*) return 0 ;; esac ;; esac
    return 1
}

norm_path() {      # repo-root-relative, no leading ./
    local p="$1"
    case "$p" in "$ROOT"/*) p="${p#"$ROOT"/}" ;; esac
    printf '%s' "${p#./}"
}

age_min() { echo $(( ($1) / 60 )); }   # $1 = seconds

# Serialize the acquire read-modify-write. Without flock(1) two acquires issued
# in the same instant can both win; the journal still records both tenures, and
# gate-check then reports the overlap after the fact (detect, not prevent).
with_journal_lock() {
    if command -v flock >/dev/null 2>&1; then
        exec 9>>"$LOCKFILE"
        flock 9
        "$@"
        local rc=$?
        exec 9>&-
        return $rc
    fi
    "$@"
}

# ---------------------------------------------------------------------------
# acquire
# ---------------------------------------------------------------------------
do_acquire() {
    local holder="$1" force="$2" steal="$3"; shift 3
    local paths=("$@")
    local conflicts="" p line lholder lpath lstate lstart lstate_iso
    local held_by_me="" to_break="" rc=0

    while IFS= read -r line; do
        [ -n "$line" ] || continue
        IFS=$'\t' read -r lholder lpath lstart _ lstate_iso lstate <<< "$line"
        for p in "${paths[@]}"; do
            path_overlap "$lpath" "$p" || continue
            if [ "$lholder" = "$holder" ]; then
                held_by_me="$held_by_me $p"
                continue
            fi
            if [ "$lstate" = "stale" ] && [ "$force" = "1" ]; then
                to_break="$to_break$lholder	$lpath	stale
"
            elif [ "$lstate" = "live" ] && [ "$steal" = "1" ]; then
                to_break="$to_break$lholder	$lpath	steal
"
            else
                conflicts="$conflicts$lstate	$lholder	$lpath	$lstate_iso	$(age_min $((NOW - lstart)))
"
            fi
        done
    done < <(open_tenures)

    if [ -n "$conflicts" ]; then
        echo "${RED}REFUSED${NC}: cannot acquire — path(s) held by another writer:"
        while IFS=$'\t' read -r st h pth iso ag; do
            [ -n "$st" ] || continue
            if [ "$st" = "stale" ]; then
                echo "  ${YELLOW}STALE${NC}  $pth  holder=$h  open since $iso (${ag}m > ${TTL_MIN}m horizon)"
            else
                echo "  ${RED}LIVE${NC}   $pth  holder=$h  open since $iso (${ag}m)"
            fi
        done <<< "$conflicts"
        echo "  fix: wait for the holder to run 'register-lock.sh release --as <holder>',"
        echo "       or break a STALE tenure with --force (recorded), or a LIVE one with"
        echo "       --steal (recorded, and the stolen tenure still counts against"
        echo "       gate-check for commits made inside it)."
        return 1
    fi

    local records="" broke=""
    while IFS=$'\t' read -r h pth reason; do
        [ -n "$h" ] || continue
        records="${records}BREAK	$NOW_ISO	$NOW	$holder	$pth	$h	$reason
"
        broke="$broke  broke $reason tenure: $pth (was $h)
"
    done <<< "$to_break"

    local fresh=""
    for p in "${paths[@]}"; do
        case " $held_by_me " in *" $p "*) echo "note: $holder already holds $p — no-op"; continue ;; esac
        [ -e "$ROOT/$p" ] || echo "note: $p does not exist yet (locking a path you are about to create is fine)"
        records="${records}ACQUIRE	$NOW_ISO	$NOW	$holder	$p
"
        fresh="$fresh $p"
    done

    if [ -n "$records" ]; then
        printf '%s' "$records" >> "$LOCKFILE" || rc=1
    fi
    [ -n "$broke" ] && printf '%s' "$broke"
    if [ -z "$fresh" ]; then
        echo "${GREEN}HELD${NC} by $holder — nothing new to acquire: ${paths[*]}"
        return $rc
    fi
    echo "${GREEN}ACQUIRED${NC} by $holder at $NOW_ISO (horizon ${TTL_MIN}m):$fresh"
    echo "  release with: scripts/register-lock.sh release --as $holder"
    echo "  commits you make inside this tenure must carry: Register-Lock: $holder"
    return $rc
}

# ---------------------------------------------------------------------------
# release — always exits 0: releasing what you do not hold must not block anyone
# ---------------------------------------------------------------------------
do_release() {
    local holder="$1"; shift
    local want=("$@")
    local line lholder lpath lstart records="" n=0 p keep

    while IFS= read -r line; do
        [ -n "$line" ] || continue
        IFS=$'\t' read -r lholder lpath lstart _ _ _ <<< "$line"
        [ "$lholder" = "$holder" ] || continue
        if [ "${#want[@]}" -gt 0 ]; then
            keep=0
            for p in "${want[@]}"; do [ "$p" = "$lpath" ] && keep=1; done
            [ "$keep" = "1" ] || continue
        fi
        records="${records}RELEASE	$NOW_ISO	$NOW	$holder	$lpath
"
        echo "${GREEN}RELEASED${NC} $lpath (tenure $(age_min $((NOW - lstart)))m)"
        n=$((n + 1))
    done < <(open_tenures)

    if [ "$n" -eq 0 ]; then
        echo "note: $holder holds nothing here — nothing to release"
        return 0
    fi
    printf '%s' "$records" >> "$LOCKFILE"
    return 0
}

# ---------------------------------------------------------------------------
# status
# ---------------------------------------------------------------------------
do_status() {
    echo "register-lock: open tenures"
    echo "Journal: ${LOCKFILE#"$ROOT"/} | staleness horizon: ${TTL_MIN}m | now: $NOW_ISO"
    echo "=============================================="
    local line h pth st iso state n=0
    while IFS= read -r line; do
        [ -n "$line" ] || continue
        IFS=$'\t' read -r h pth st _ iso state <<< "$line"
        n=$((n + 1))
        if [ "$state" = "stale" ]; then
            echo "  ${YELLOW}STALE${NC}  $pth  holder=$h  since $iso ($(age_min $((NOW - st)))m > ${TTL_MIN}m)"
        else
            echo "  ${GREEN}LIVE${NC}   $pth  holder=$h  since $iso ($(age_min $((NOW - st)))m)"
        fi
    done < <(open_tenures)
    [ "$n" -eq 0 ] && echo "  none — no writer has announced a register path"
    echo "=============================================="
    return 0
}

# ---------------------------------------------------------------------------
# gate-check — outgoing commits vs the tenure ledger
# ---------------------------------------------------------------------------
do_gate_check() {
    local base="${1:-}"
    local pass=0 fail=0 warn=0

    echo "register-lock: F14 shared-register write-collision check on outgoing commits"
    echo "Repo root: $ROOT"
    echo "Journal: ${LOCKFILE#"$ROOT"/} | staleness horizon: ${TTL_MIN}m"
    echo "=============================================="

    if [ -z "$base" ]; then
        if ! base=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null); then
            echo "${YELLOW}  SKIP${NC}: no base ref and no upstream — nothing outgoing to check"
            echo "=============================================="
            echo "Results: ${GREEN}0 passed${NC}, ${YELLOW}1 warning${NC}, ${RED}0 failed${NC}"
            return 0
        fi
    fi
    if ! git rev-parse --verify --quiet "$base" >/dev/null; then
        echo "${YELLOW}  SKIP${NC}: base ref '$base' does not resolve"
        return 0
    fi

    local tenures
    tenures=$(intervals)
    if [ -z "$tenures" ]; then
        echo "${GREEN}  PASS${NC}: no lock ledger entries — no writer announced a path, nothing to attribute"
        echo "=============================================="
        echo "Results: ${GREEN}1 passed${NC}, ${YELLOW}0 warnings${NC}, ${RED}0 failed${NC}"
        return 0
    fi

    # Stale open tenures are reported at every push: never silently honoured.
    local h pth st en iso state
    while IFS=$'\t' read -r h pth st en iso state; do
        [ "$state" = "stale" ] || continue
        warn=$((warn + 1))
        echo "${YELLOW}  WARN${NC}: stale tenure — $pth held by $h since $iso, never released"
        echo "        (bounded at +${TTL_MIN}m for this check; release it or break it with --force)"
    done <<< "$tenures"

    local commits
    commits=$(git rev-list "$base..HEAD" 2>/dev/null)
    if [ -z "$commits" ]; then
        echo "${GREEN}  PASS${NC}: no outgoing commits — nothing to check"
        echo "=============================================="
        echo "Results: ${GREEN}$((pass + 1)) passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}0 failed${NC}"
        return 0
    fi

    local ntenure
    ntenure=$(printf '%s\n' "$tenures" | grep -c . || true)
    # A declaration may vouch for OTHER commits by naming their short SHAs:
    #   Register-Lock: none -- covers 5d9befb d7abfb8: <why you know>
    # Why this exists (2026-08-10): per-commit self-declaration is the stronger form,
    # but it cannot be applied to a commit that is already several deep in a branch
    # other agents are still committing to — rewriting that history to add a trailer is
    # more dangerous than the record defect it fixes. Naming the SHAs keeps the claim
    # specific and auditable: you must enumerate exactly which commits you are vouching
    # for, so nobody can wave a whole range through with one sentence.
    # The declaration may name `none` (no holder content) OR name the holder whose work
    # the commit does carry — both are honest answers, and which one is true is exactly
    # what the committer must decide. Any Register-Lock line containing `covers <sha>…`
    # vouches for those SHAs.
    local vouched
    vouched=$(for sha in $commits; do
                  git log -1 --format=%B "$sha" | grep -i '^Register-Lock:.*covers' || true
              done | grep -oE '\b[0-9a-f]{7,40}\b' | cut -c1-7 | sort -u | tr '\n' ' ')
    [ -n "$vouched" ] && echo "  vouched by an explicit Register-Lock declaration: $vouched"

    local sha ct subject files declared hit f
    for sha in $commits; do
        case " $vouched " in
            *" ${sha:0:7} "*)
                pass=$((pass + 1))
                echo "${YELLOW}  DECLARED${NC}: ${sha:0:7} vouched by a Register-Lock declaration naming it in this push"
                continue
                ;;
        esac
        ct=$(git log -1 --format=%ct "$sha")
        subject=$(git log -1 --format=%s "$sha")
        files=$(git diff-tree --no-commit-id --name-only -r "$sha")
        declared=$(git log -1 --format=%B "$sha" | grep -i '^Register-Lock:' | sed 's/^[Rr]egister-[Ll]ock:[[:space:]]*//' | tr ',' ' ')
        # A commit may instead assert that NO holder's content rides in it, with a
        # reason: `Register-Lock: none -- <why you know>`. Added 2026-08-10 after the
        # first production block, which was a false positive: this check fails any
        # commit touching a locked path during ANY tenure, whether or not the holder's
        # content is actually present — it cannot tell, as the header states. Without
        # an honest escape the only ways past were a FALSE `Register-Lock: <holder>`
        # or breaking a live lock, so the check taught lying. The `none` form keeps the
        # guard's real value — you cannot push silently, you must state an auditable
        # claim someone can later check against the diff — in the same shape as
        # claims-gate's FLIP trailer, which also declares rather than proves. A bare
        # `none` with no reason is NOT accepted.
        local none_reason=""
        case " $declared " in
            *" none "*)
                none_reason=$(git log -1 --format=%B "$sha" \
                    | grep -i '^Register-Lock:[[:space:]]*none' \
                    | sed 's/^[^-]*--[[:space:]]*//' )
                ;;
        esac
        if [ -n "$none_reason" ] && [ "$none_reason" != "none" ]; then
            pass=$((pass + 1))
            echo "${YELLOW}  DECLARED${NC}: ${sha:0:7} asserts no holder content — $none_reason"
            echo "            (auditable claim, not a proof; verify against the diff if it matters)"
            continue
        fi
        hit=0
        while IFS=$'\t' read -r h pth st en iso state; do
            [ -n "$h" ] || continue
            [ "$ct" -ge "$st" ] && [ "$ct" -le "$en" ] || continue
            case " $declared " in *" $h "*) continue ;; esac
            while IFS= read -r f; do
                [ -n "$f" ] || continue
                path_overlap "$pth" "$f" || continue
                hit=1
                fail=$((fail + 1))
                echo "${RED}  FAIL${NC}: ${sha:0:7} touched $f inside another holder's tenure"
                echo "        locked: $pth by '$h' from $iso ($(age_min $((en - st)))m, $state)"
                echo "        commit: $subject"
                echo "        commit time $(date -u -d "@$ct" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || echo "epoch $ct") falls inside that tenure and the message declares no 'Register-Lock: $h' trailer"
                echo "        fix: if this commit IS $h's work, declare it with a 'Register-Lock: $h'"
                echo "             trailer; if it is not, that writer's hunk is riding in your commit —"
                echo "             split it out (git reset the path, let the holder commit it)."
            done <<< "$files"
        done <<< "$tenures"
        [ "$hit" -eq 0 ] && pass=$((pass + 1))
    done

    [ "$fail" -eq 0 ] && echo "${GREEN}  PASS${NC}: $pass outgoing commit(s) checked against $ntenure recorded tenure(s) — none landed inside another holder's tenure undeclared"
    echo "=============================================="
    if [ "$fail" -gt 0 ]; then
        echo "Results: ${GREEN}${pass} passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}${fail} failed${NC}"
        echo "${RED}register-lock gate-check FAILED${NC}"
        return 1
    fi
    echo "Results: ${GREEN}${pass} passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}${fail} failed${NC}"
    echo "${GREEN}register-lock gate-check PASSED${NC}"
    return 0
}

# ---------------------------------------------------------------------------
# dispatch
# ---------------------------------------------------------------------------
CMD="${1:-}"; shift 2>/dev/null || true
case "$CMD" in
    acquire|release)
        HOLDER="${REGISTER_LOCK_HOLDER:-}"; FORCE=0; STEAL=0; PATHS=()
        while [ $# -gt 0 ]; do
            case "$1" in
                --as)    HOLDER="${2:-}"; shift 2 || true ;;
                --force) FORCE=1; shift ;;
                --steal) STEAL=1; FORCE=1; shift ;;
                -*)      echo "ERROR: unknown flag '$1'" >&2; usage ;;
                *[[:space:]]*) echo "ERROR: path '$1' contains whitespace — the journal is TSV" >&2; exit 2 ;;
                *)       PATHS+=("$(norm_path "$1")"); shift ;;
            esac
        done
        if [ -z "$HOLDER" ]; then
            echo "ERROR: a holder id is required (--as <holder> or REGISTER_LOCK_HOLDER)." >&2
            echo "       An anonymous tenure cannot be matched to a commit later — the" >&2
            echo "       whole point of the ledger. Use the agent/workstream name." >&2
            exit 2
        fi
        case "$HOLDER" in *[[:space:]]*) echo "ERROR: holder id must not contain whitespace" >&2; exit 2 ;; esac
        if [ "$CMD" = "acquire" ]; then
            [ "${#PATHS[@]}" -gt 0 ] || { echo "ERROR: acquire needs at least one path" >&2; usage; }
            with_journal_lock do_acquire "$HOLDER" "$FORCE" "$STEAL" "${PATHS[@]}"
            exit $?
        fi
        do_release "$HOLDER" ${PATHS[@]+"${PATHS[@]}"}
        exit $?
        ;;
    status)     do_status; exit $? ;;
    gate-check) do_gate_check "${1:-}"; exit $? ;;
    ""|-h|--help|help) usage ;;
    *)          echo "ERROR: unknown command '$CMD'" >&2; usage ;;
esac
