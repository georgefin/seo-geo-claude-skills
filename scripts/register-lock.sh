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
# MODEL — an append-only TSV JOURNAL of lock events. The live journal is
# gitignored and never committed (see .gitignore for why); its rows are copied to
# a TRACKED dated archive by `archive`, which is the durable evidence half:
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
#   Every one of those four bounds is asserted by a fixture case under
#   scripts/fixtures/register-lock/, in pairs one second apart where a pair is
#   what separates two readings. Run `--probe`; do not take this table on trust.
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
#   archive
#         Copy journal rows to docs/loop/register-locks-archive/<date>.tsv, filed
#         by each row's own date. Tracked, append-only, idempotent. Evidence only:
#         no command reads it, so a stale row there cannot block anyone.
#   --probe
#         Fault injection over scripts/fixtures/register-lock/ (see below).
#
# A locked path is matched exactly, or as a directory prefix when it ends in "/"
# (e.g. `docs/loop/` covers every register in that directory).
#
# Env: REGISTER_LOCK_FILE (journal path, default <root>/.register-locks — the
#      override is how the acceptance scenarios run without touching the real
#      ledger), REGISTER_LOCK_TTL_MIN (staleness horizon, default 90).
# Exit: 0 = ok/pass, 1 = refused/FAIL, 2 = usage error. No network access.
# Dependencies: bash, git (gate-check only), awk, date; flock(1) when available.
#
# ── FAULT INJECTION (--probe), added for G3-C5 ────────────────────────────────
# Two surfaces, probed two ways, because they fail differently.
#   * The LIFECYCLE (acquire / release / status) is a state machine over a
#     journal file. The probe drives it through the real CLI with
#     REGISTER_LOCK_FILE pointed at a scratch journal, and asserts the refusals
#     as hard as the successes: --force must NOT break a live tenure, and an
#     unrelated path must NOT be refused. A lock that refuses everything is as
#     broken as one that refuses nothing, and only the second is obvious.
#   * GATE-CHECK reads commits, so its fixtures are commits. The probe builds a
#     throwaway git repository, SYMLINKS this script into its scripts/ directory
#     (so `${BASH_SOURCE[0]}` resolves ROOT to the temp repo — nothing is copied
#     and no history is rewritten), materialises a journal fixture, and writes
#     each case's commit at a controlled `GIT_COMMITTER_DATE`.
# Journal fixtures carry OFFSETS FROM NOW, never timestamps: staleness is defined
# relative to now, so a frozen timestamp would decay from live to stale over the
# life of the file and the fixture would stop meaning what it says.
#
# WHAT THIS PROBE DOES NOT PROVE:
#   1. ATTRIBUTION — the same thing the header above already refuses to claim. A
#      commit carrying `Register-Lock: lane-a` passes whether or not lane-a's
#      content is in it. The trailer is an auditable claim; the probe asserts the
#      claim is REQUIRED, never that it is true.
#   2. CONCURRENCY. `with_journal_lock`/flock exists to serialise two acquires
#      issued in the same instant. Every probe case is sequential, so the race is
#      not reproduced — only the code path around it runs.
#   3. The DEFAULT journal path. Every case sets REGISTER_LOCK_FILE, so
#      `<root>/.register-locks` is exercised by real sessions and by nothing here.
#   4. The DEFAULT base ref. The gate calls `gate-check` with no argument and it
#      resolves `@{upstream}`; a temp repo has no upstream, so every case passes an
#      explicit base and that branch is never taken.
#   5. A writer who never runs `acquire`. Invisible to the check by construction,
#      and therefore invisible to any fixture the check could ever be given.
#   6. That a `Register-Lock: <holder>` or `none` declaration is TRUE. It is an
#      auditable claim, not a proof — the same standing as claims-gate's FLIP
#      trailer. The check requires that a claim be made and be well-formed; whether
#      the diff bears it out is a question for a reader, and this leg never asks it.
#      (Until 2026-08-17 this entry read that the `none` escape was not implemented
#      as documented. It now is — ruling M3 — and the two cases that hold it there
#      are gate-bare-none-rejected.txt and gate-none-prose-is-not-a-trailer.txt.)
# ──────────────────────────────────────────────────────────────────────────────

# trailer_region — print the message's TRAILER REGION (stdin -> stdout).
# The region is the trailing run of paragraphs in which every non-blank line is
# trailer-shaped (`Key: value`) or a continuation (leading whitespace). Walking stops
# at the first paragraph containing a line of ordinary prose, which is what makes a
# sentence beginning "Register-Lock: ..." mid-message unable to become a declaration.
# Deliberately NOT `git interpret-trailers --parse`: that honours only the final
# paragraph and, measured against all 45 declarations in this repo's history, saw 4.
trailer_region() {
    awk '
    { L[NR] = $0 }
    END {
      n = NR
      while (n > 0 && L[n] ~ /^[[:space:]]*$/) n--
      end = n
      while (end > 0) {
        start = end
        while (start > 1 && L[start-1] !~ /^[[:space:]]*$/) start--
        ok = 1
        for (i = start; i <= end; i++) {
          if (L[i] ~ /^[[:space:]]*$/) continue
          if (L[i] ~ /^[A-Za-z][A-Za-z0-9_-]*:/) continue
          if (L[i] ~ /^[[:space:]]+[^[:space:]]/) continue
          ok = 0; break
        }
        if (!ok) break
        for (i = start; i <= end; i++) out[++m] = L[i]
        end = start - 1
        while (end > 0 && L[end] ~ /^[[:space:]]*$/) end--
      }
      for (i = m; i >= 1; i--) print out[i]
    }'
}

# do_archive — copy journal rows into a TRACKED, dated, append-only archive.
#
# WHY THIS IS A SEPARATE FILE AND NOT `git add .register-locks`. The journal has
# two jobs and only one of them should be committed:
#   * LIVE STATE — who holds which path right now. `.gitignore` is right that this
#     must never be committed: pulling another session's open ACQUIRE rows makes
#     YOUR `acquire` refuse paths nobody is actually holding, and `status` print
#     phantom tenures. That is a functional break, not untidiness.
#   * EVIDENCE — that a multi-lane wave journalled its disjoint scope at all. This
#     is what GOALS-SCORECARD G1-C5 asks for, and until 2026-08-18 it lived only
#     in the container, so the criterion was unverifiable from a clone: the wave
#     that finally journalled its scope produced evidence nobody could check.
# The archive carries the evidence and none of the hazard, because NOTHING reads
# it as live state — `acquire`, `release`, `status` and `gate-check` all read
# `$LOCKFILE` and never this directory. A stale row here cannot block anyone.
#
# Rows are filed under the date in their own timestamp, so a wave that spans
# midnight lands in two files exactly as it happened. Re-running is safe: existing
# rows are not duplicated. `merge=union` in .gitattributes keeps two sessions
# appending on the same day from conflicting.
do_archive() {
    local dir="$ROOT/docs/loop/register-locks-archive"
    [ -f "$LOCKFILE" ] || { echo "no journal at $LOCKFILE — nothing to archive"; return 0; }
    mkdir -p "$dir"
    local dates added=0 total=0
    dates=$(awk -F'\t' 'NF>=2 { print substr($2,1,10) }' "$LOCKFILE" | sort -u)
    for d in $dates; do
        case "$d" in [0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9]) ;; *) continue ;; esac
        local out="$dir/$d.tsv" n_before=0
        [ -f "$out" ] && n_before=$(wc -l < "$out")
        awk -F'\t' -v D="$d" 'NF>=2 && substr($2,1,10)==D' "$LOCKFILE" \
            | { [ -f "$out" ] && grep -vxF -f "$out" - || cat; } >> "$out" 2>/dev/null || true
        local n_after; n_after=$(wc -l < "$out")
        added=$((added + n_after - n_before)); total=$((total + n_after))
        echo "  $d.tsv — $((n_after - n_before)) new row(s), $n_after total"
    done
    echo "archived to docs/loop/register-locks-archive/ — $added new row(s) across $(echo "$dates" | wc -w) date(s)"
    echo "(evidence only; nothing reads this as live state — the live journal stays gitignored)"
    return 0
}

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

if [ "${1:-}" = "--probe" ]; then
    SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
    FIXDIR="$ROOT/scripts/fixtures/register-lock"
    [ -d "$FIXDIR" ] || { echo "PROBE ERROR: fixture directory missing: $FIXDIR" >&2; exit 2; }
    command -v git >/dev/null 2>&1 || { echo "PROBE ERROR: git is required for gate-check" >&2; exit 2; }

    shopt -s nullglob
    CASES=("$FIXDIR"/gate-*.txt "$FIXDIR"/gap-*.txt)
    JOURNALS=("$FIXDIR"/journal-*.tsv)
    shopt -u nullglob
    # Scope control (F15-r3: a probe that scans nothing must fail, not pass).
    if [ "${#CASES[@]}" -eq 0 ] || [ "${#JOURNALS[@]}" -eq 0 ]; then
        echo "PROBE ERROR: empty corpus (${#CASES[@]} cases, ${#JOURNALS[@]} journals) — a probe" >&2
        echo "             with nothing to run measures nothing and must not report health" >&2
        exit 2
    fi

    PNOW="$(date -u +%s)"
    TR="$(mktemp -d)"; JD="$(mktemp -d)"; trap 'rm -rf "$TR" "$JD"' EXIT
    probe_fail=0; n_pos=0; n_neg=0; n_gap=0; n_life=0; GAPS=""; USED_JOURNALS=""
    export REGISTER_LOCK_HOLDER=""   # so the "holder required" case tests the code, not the env

    head_of() { awk '/^# ---8<---/{exit} {print}' "$1"; }
    body_of() { awk 'f{print} /^# ---8<---/{f=1}' "$1"; }
    dvals()   { head_of "$2" | sed -n "s/^# $1:[[:space:]]*//p"; }

    # A journal fixture's column 2 is an OFFSET IN SECONDS FROM NOW. Materialising it
    # here is what keeps "stale" and "live" meaning the same thing next month.
    materialise_journal() {   # <fixture> <destination>
        local src="$1" dst="$2" ev off holder path victim reason ep iso
        : > "$dst"
        while IFS=$'\t' read -r ev off holder path victim reason || [ -n "$ev" ]; do
            case "$ev" in ''|'#'*) continue ;; esac
            ep=$((PNOW + off))
            iso="$(date -u -d "@$ep" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null || echo "epoch-$ep")"
            if [ -n "${victim:-}" ]; then
                printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' \
                    "$ev" "$iso" "$ep" "$holder" "$path" "$victim" "${reason:-}" >> "$dst"
            else
                printf '%s\t%s\t%s\t%s\t%s\n' "$ev" "$iso" "$ep" "$holder" "$path" >> "$dst"
            fi
        done < "$src"
    }

    # ── throwaway repository; the script is REACHED through a symlink, never copied ──
    mkdir -p "$TR/scripts" "$TR/docs/loop"
    ln -s "$SELF" "$TR/scripts/register-lock.sh"
    RL="$TR/scripts/register-lock.sh"
    git -C "$TR" init -q
    git -C "$TR" config user.email "probe@invalid.example"
    git -C "$TR" config user.name  "probe"
    git -C "$TR" config commit.gpgsign false
    git -C "$TR" config core.hooksPath "$TR/.no-hooks"
    printf 'scripts/register-lock.sh\n.register-locks\n' > "$TR/.git/info/exclude"
    for _p in README.md VERSIONS.md docs/loop/KPI.md docs/loop/PIPELINE.md docs/loop/PILOT.md; do
        printf 'base\n' > "$TR/$_p"
    done
    git -C "$TR" add -A
    git -C "$TR" commit -q -m "base: probe fixture root"
    BASESHA="$(git -C "$TR" rev-parse HEAD)"

    echo "register-lock --probe : fault injection on a scratch journal and synthetic commits"
    echo "Fixture: $FIXDIR"
    echo "Temp repo: $TR (symlinked script, no history rewritten, real ledger untouched)"
    echo "=============================================="
    echo "LIFECYCLE — acquire / release / status against a scratch journal"

    LJ="$JD/lifecycle.journal"
    life() {   # <label> <want-exit> <must-contain> <args...>
        local label="$1" want="$2" must="$3"; shift 3
        local out rc
        out="$(REGISTER_LOCK_FILE="$LJ" bash "$RL" "$@" 2>&1)"; rc=$?
        n_life=$((n_life + 1))
        if [ "$rc" -ne "$want" ]; then
            echo "  PROBE FAIL  $label — expected exit $want, got $rc"
            printf '%s\n' "$out" | sed 's/^/      | /' | head -8; probe_fail=1; return
        fi
        # Exit code AND message: a right exit for the wrong reason is how a probe
        # stops measuring (F15-r3).
        if ! printf '%s\n' "$out" | grep -qF -- "$must"; then
            echo "  PROBE FAIL  $label — exit $rc was right, but the output never says \"$must\""
            printf '%s\n' "$out" | sed 's/^/      | /' | head -8; probe_fail=1; return
        fi
        printf '  ok  %-10s %-52s exit %s\n' "lifecycle" "$label" "$rc"
    }

    life "acquire a free path"                     0 "ACQUIRED"          acquire --as lane-a docs/loop/
    life "re-acquire your own path is a no-op"     0 "already holds"     acquire --as lane-a docs/loop/
    life "another holder, prefix overlap: REFUSED" 1 "held by another writer" acquire --as lane-b docs/loop/KPI.md
    life "another holder, unrelated path: allowed" 0 "ACQUIRED"          acquire --as lane-b README.md
    life "--force does NOT break a LIVE tenure"    1 "held by another writer" acquire --as lane-b --force docs/loop/KPI.md
    life "--steal breaks a LIVE tenure, recorded"  0 "broke steal tenure" acquire --as lane-b --steal docs/loop/KPI.md
    life "status shows the live holder"            0 "holder=lane-b"     status
    life "release ends the tenure"                 0 "RELEASED"          release --as lane-b
    life "release what you never held: exit 0"     0 "holds nothing here" release --as lane-zzz
    life "status after release: nothing open"      0 "no writer has announced a register path" status

    SJ="$JD/stale.journal"
    materialise_journal "$FIXDIR/journal-stale-open.tsv" "$SJ"
    USED_JOURNALS="$USED_JOURNALS journal-stale-open.tsv"
    slife() {   # same, against the stale journal
        local label="$1" want="$2" must="$3"; shift 3
        local out rc
        out="$(REGISTER_LOCK_FILE="$SJ" bash "$RL" "$@" 2>&1)"; rc=$?
        n_life=$((n_life + 1))
        if [ "$rc" -ne "$want" ] || ! printf '%s\n' "$out" | grep -qF -- "$must"; then
            echo "  PROBE FAIL  $label — wanted exit $want containing \"$must\", got exit $rc"
            printf '%s\n' "$out" | sed 's/^/      | /' | head -8; probe_fail=1; return
        fi
        printf '  ok  %-10s %-52s exit %s\n' "lifecycle" "$label" "$rc"
    }
    slife "status marks an over-horizon tenure STALE" 0 "STALE"               status
    slife "a STALE tenure still refuses a plain acquire" 1 "held by another writer" acquire --as lane-y docs/loop/KPI.md
    slife "--force breaks a STALE tenure, recorded"  0 "broke stale tenure"   acquire --as lane-y --force docs/loop/KPI.md

    echo "USAGE — every refusal path exits 2, and says which one"
    life "no holder id at all"            2 "a holder id is required"        acquire docs/loop/KPI.md
    life "holder id with whitespace"      2 "must not contain whitespace"    acquire --as "lane a" docs/loop/KPI.md
    life "path with whitespace (TSV)"     2 "the journal is TSV"             acquire --as lane-a "docs/loop/a b.md"
    life "acquire with no path"           2 "needs at least one path"        acquire --as lane-a
    life "unknown flag"                   2 "unknown flag"                   acquire --as lane-a --bogus x
    life "unknown command"                2 "unknown command"                frobnicate
    ttl_out="$(REGISTER_LOCK_FILE="$LJ" REGISTER_LOCK_TTL_MIN=ninety bash "$RL" status 2>&1)"; ttl_rc=$?
    n_life=$((n_life + 1))
    if [ "$ttl_rc" -eq 2 ] && printf '%s\n' "$ttl_out" | grep -qF "must be whole minutes"; then
        printf '  ok  %-10s %-52s exit %s\n' "lifecycle" "non-numeric REGISTER_LOCK_TTL_MIN" "$ttl_rc"
    else
        echo "  PROBE FAIL  a non-numeric TTL was accepted (exit $ttl_rc) — every derived bound"
        echo "              in this file would then be computed from a garbage horizon"
        probe_fail=1
    fi

    echo ""
    echo "GATE-CHECK — outgoing commits against a materialised tenure ledger"

    for f in "${CASES[@]}"; do
        base_name="$(basename "$f" .txt)"
        while IFS= read -r line; do
            case "$line" in
                '# CASE:'*|'# ROLE:'*|'# JOURNAL:'*|'# COMMIT-AT:'*|'# FILE:'*) ;;
                '# EXPECT-EXIT:'*|'# EXPECT-MATCH:'*|'# EXPECT-ABSENT:'*|'# GAP:'*) ;;
                '# WHY:'*|'# WHY '*) ;;
                '# '[A-Z]*:*) echo "  PROBE FAIL  $base_name — unknown directive: $line"; probe_fail=1 ;;
                '#'*|'') ;;
                *) echo "  PROBE FAIL  $base_name — non-comment line before the message separator"
                   probe_fail=1 ;;
            esac
        done < <(head_of "$f")

        role="$(dvals ROLE "$f" | head -1)"
        want="$(dvals EXPECT-EXIT "$f" | head -1)"
        jname="$(dvals JOURNAL "$f" | head -1)"
        at="$(dvals COMMIT-AT "$f" | head -1)"
        if [ -z "$role" ] || [ -z "$want" ] || [ -z "$jname" ] || [ -z "$(dvals EXPECT-MATCH "$f")" ]; then
            echo "  PROBE FAIL  $base_name — needs ROLE, JOURNAL, EXPECT-EXIT and an EXPECT-MATCH"
            probe_fail=1; continue
        fi
        case "$role" in
            positive)  n_pos=$((n_pos + 1)) ;;
            negative)  n_neg=$((n_neg + 1)) ;;
            known-gap) n_gap=$((n_gap + 1)); GAPS="$GAPS  [$base_name] $(dvals GAP "$f" | head -1)
" ;;
            *) echo "  PROBE FAIL  $base_name — ROLE must be positive|negative|known-gap"; probe_fail=1; continue ;;
        esac

        CJ="$JD/case.journal"; rm -f "$CJ"
        if [ "$jname" != "NONE" ]; then
            if [ ! -f "$FIXDIR/$jname" ]; then
                echo "  PROBE FAIL  $base_name — names a journal that does not exist: $jname"
                echo "              (a case whose ledger is missing would 'pass' on an empty ledger)"
                probe_fail=1; continue
            fi
            materialise_journal "$FIXDIR/$jname" "$CJ"
            USED_JOURNALS="$USED_JOURNALS $jname"
        fi

        git -C "$TR" checkout -q -B probecase "$BASESHA"
        git -C "$TR" clean -qfd
        mapfile -t files < <(dvals FILE "$f")
        for p in ${files[@]+"${files[@]}"}; do
            mkdir -p "$TR/$(dirname "$p")"
            printf 'probe fixture content %s\n' "$base_name" > "$TR/$p"
        done
        cep=$((PNOW + ${at:--450}))
        body_of "$f" > "$JD/msg"
        git -C "$TR" add -A
        GIT_AUTHOR_DATE="@$cep +0000" GIT_COMMITTER_DATE="@$cep +0000" \
            git -C "$TR" commit -q -F "$JD/msg"

        OUT="$(REGISTER_LOCK_FILE="$CJ" bash "$RL" gate-check "$BASESHA" 2>&1)"; RC=$?

        if ! printf '%s\n' "$OUT" | grep -qF "Repo root: $TR"; then
            echo "  PROBE FAIL  $base_name — the run did not resolve its root to the temp repo;"
            echo "              this probe would be measuring the real tree"
            probe_fail=1; continue
        fi
        # Scope control, per case: the commit must have landed. "no outgoing commits"
        # is a pass by emptiness and would make every case below look green.
        if printf '%s\n' "$OUT" | grep -qF "no outgoing commits"; then
            echo "  PROBE FAIL  $base_name — the commit never landed; this case scanned an empty"
            echo "              range and its verdict is about nothing"
            probe_fail=1; continue
        fi
        if [ "$RC" -ne "$want" ]; then
            echo "  PROBE FAIL  $base_name — expected exit $want, got $RC"
            printf '%s\n' "$OUT" | sed 's/^/      | /' | tail -12
            probe_fail=1; continue
        fi
        miss=""
        while IFS= read -r m; do
            [ -n "$m" ] || continue
            printf '%s\n' "$OUT" | grep -qF -- "$m" || miss="$miss
      missing: $m"
        done < <(dvals EXPECT-MATCH "$f")
        while IFS= read -r a; do
            [ -n "$a" ] || continue
            printf '%s\n' "$OUT" | grep -qF -- "$a" && miss="$miss
      present but must be absent: $a"
        done < <(dvals EXPECT-ABSENT "$f")
        if [ -n "$miss" ]; then
            echo "  PROBE FAIL  $base_name — exit $RC was right, the output was not:$miss"
            probe_fail=1; continue
        fi
        printf '  ok  %-10s %-52s exit %s\n' "$role" "$base_name" "$RC"
    done

    # ── the `covers <sha>` vouching branch needs TWO commits, so it lives here ──
    # A trailer may vouch for OTHER commits by naming their short SHAs. That branch is
    # unreachable from a one-commit fixture and is the widest escape the check offers,
    # so leaving it unexercised would leave the widest door unguarded.
    materialise_journal "$FIXDIR/journal-live-two-holders.tsv" "$JD/case.journal"
    git -C "$TR" checkout -q -B probecase "$BASESHA"
    git -C "$TR" clean -qfd
    printf 'first\n' > "$TR/docs/loop/KPI.md"
    git -C "$TR" add -A
    GIT_AUTHOR_DATE="@$((PNOW - 450)) +0000" GIT_COMMITTER_DATE="@$((PNOW - 450)) +0000" \
        git -C "$TR" commit -q -m "docs(loop): weekly numbers"
    VSHA="$(git -C "$TR" rev-parse --short=7 HEAD)"
    printf 'second\n' > "$TR/README.md"
    git -C "$TR" add -A
    printf 'docs: unrelated tidy\n\nRegister-Lock: none -- covers %s: written before lane-a acquired\n' \
        "$VSHA" > "$JD/msg"
    GIT_AUTHOR_DATE="@$((PNOW - 100)) +0000" GIT_COMMITTER_DATE="@$((PNOW - 100)) +0000" \
        git -C "$TR" commit -q -F "$JD/msg"
    OUT="$(REGISTER_LOCK_FILE="$JD/case.journal" bash "$RL" gate-check "$BASESHA" 2>&1)"; RC=$?
    if [ "$RC" -eq 0 ] && printf '%s\n' "$OUT" | grep -qF "vouched by a Register-Lock declaration naming it"; then
        printf '  ok  %-10s %-52s exit %s\n' "negative" "covers <sha> vouches another commit in the push" "$RC"
        n_neg=$((n_neg + 1))
    else
        echo "  PROBE FAIL  the 'covers <sha>' vouching branch did not clear commit $VSHA (exit $RC)"
        printf '%s\n' "$OUT" | sed 's/^/      | /' | tail -12
        probe_fail=1
    fi
    # …and the same two commits with the vouching line REMOVED must fail, or the case
    # above proves only that gate-check passes commits it was always going to pass.
    git -C "$TR" checkout -q -B probecase "$BASESHA"
    git -C "$TR" clean -qfd
    printf 'first\n' > "$TR/docs/loop/KPI.md"
    git -C "$TR" add -A
    GIT_AUTHOR_DATE="@$((PNOW - 450)) +0000" GIT_COMMITTER_DATE="@$((PNOW - 450)) +0000" \
        git -C "$TR" commit -q -m "docs(loop): weekly numbers"
    printf 'second\n' > "$TR/README.md"
    git -C "$TR" add -A
    GIT_AUTHOR_DATE="@$((PNOW - 100)) +0000" GIT_COMMITTER_DATE="@$((PNOW - 100)) +0000" \
        git -C "$TR" commit -q -m "docs: unrelated tidy"
    OUT="$(REGISTER_LOCK_FILE="$JD/case.journal" bash "$RL" gate-check "$BASESHA" 2>&1)"; RC=$?
    if [ "$RC" -eq 1 ]; then
        printf '  ok  %-10s %-52s exit %s\n' "positive" "the same pair, unvouched, is caught" "$RC"
        n_pos=$((n_pos + 1))
    else
        echo "  PROBE FAIL  removing the vouching trailer changed nothing (exit $RC) — the"
        echo "              'covers' control above was passing for some other reason"
        probe_fail=1
    fi

    # ── journal mirror: a checked-in journal nobody runs is decoration ──
    echo ""
    echo "JOURNAL MIRROR — every checked-in ledger fixture must be exercised"
    njr=0; njh=0
    for j in "${JOURNALS[@]}"; do
        jb="$(basename "$j")"; njr=$((njr + 1))
        case " $USED_JOURNALS " in
            *" $jb "*) njh=$((njh + 1)) ;;
            *) echo "  PROBE FAIL  $jb is checked in and no case uses it"; probe_fail=1 ;;
        esac
    done
    echo "  $njh of $njr journal fixtures exercised"

    echo ""
    echo "STATED LIMITS — behaviour this check gets wrong, asserted so it stays measured"
    printf '%s' "$GAPS"
    echo "  (what the probe itself does not prove: sed -n '89,124p' $SELF)"
    echo ""
    if [ "$probe_fail" -eq 0 ]; then
        echo "PROBE PASS — $n_life lifecycle assertions; ${#CASES[@]} ledger cases plus 2 built inline:"
        echo "             $n_pos positive, $n_neg negative controls, $n_gap known-gap, $njr journals."
        exit 0
    fi
    echo "PROBE FAILED"
    exit 1
fi

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
        # A TRAILER IS ONLY A TRAILER IN THE TRAILER BLOCK (ruling M3, 2026-08-17).
        # This read used `grep -i '^Register-Lock:'` over the whole message, so any
        # line of PROSE beginning with those characters became a declaration. Measured
        # on this repo's own history: the commit that documents the bug below contains
        # the sentence "...wave itself past this gated leg with a bare
        # Register-Lock: none. Not fixed here because..." at line-start, and it was
        # matched. It escaped becoming a false `none` declaration only because the
        # author happened to write a full stop after the word — `*" none "*` needs a
        # space on both sides, and "none." has a period. Change one punctuation mark
        # in a commit message and the guard silently waives the commit. That is a coin
        # flip, not a check.
        #   `git interpret-trailers --parse` was the first fix for this AND IT WAS
        #   WRONG. Measured against all 45 Register-Lock declarations in this repo's
        #   history: it saw 4. It honours only the FINAL paragraph, and this repo's
        #   convention puts `Register-Lock:` in its own paragraph above the sign-offs,
        #   so 41 true declarations went unseen — every one of those commits would then
        #   be FAILed for declaring nothing. That is a far worse defect than the one
        #   being fixed, and only measuring against real history caught it.
        #   `trailer_region` keeps the principle and repairs the mechanism: it walks
        #   paragraphs from the end and stops at the first containing a line of ordinary
        #   prose. On the same 45 it preserves 43, and the 2 it drops are the two
        #   revisions of the one commit whose PROSE carries the string — the defect.
        declared=$(git log -1 --format=%B "$sha" | trailer_region | grep -i '^Register-Lock:' | sed 's/^[Rr]egister-[Ll]ock:[[:space:]]*//' | tr ',' ' ')
        # A commit may instead assert that NO holder's content rides in it, with a
        # reason: `Register-Lock: none — <why you know>`. Added 2026-08-10 after the
        # first production block, which was a false positive: this check fails any
        # commit touching a locked path during ANY tenure, whether or not the holder's
        # content is actually present — it cannot tell, as the header states. Without
        # an honest escape the only ways past were a FALSE `Register-Lock: <holder>`
        # or breaking a live lock, so the check taught lying. The `none` form keeps the
        # guard's real value — you cannot push silently, you must state an auditable
        # claim someone can later check against the diff — in the same shape as
        # claims-gate's FLIP trailer, which also declares rather than proves. A bare
        # `none` with no reason is NOT accepted.
        #   MEASURED 2026-08-17: it WAS accepted. `^[^-]*--` can never reach the `--`,
        #   because "Register-Lock" carries a hyphen first, so that sed never fired,
        #   `none_reason` became the whole trailer line, which is non-empty and not
        #   equal to "none", and any commit could wave itself past this gated leg with
        #   a bare `Register-Lock: none`. Fixed below under ruling M3.
        # SEPARATOR IS A CLOSED LIST OF THREE: em dash, en dash, `--`. The em dash is
        # canonical because it is the form this repo's only real `none` declaration
        # actually uses (`Register-Lock: none — new directory, no shared register`);
        # the `--` of the original doc string appears only in a `<holder>` declaration.
        # A guard that rejects the form in use disciplines the repo instead of serving
        # it, so all three are accepted and none is preferred in the error text.
        local none_reason="" none_decl=""
        case "$declared" in
            none|none[[:space:]]*)
                none_decl=$(git log -1 --format=%B "$sha" | trailer_region \
                    | grep -iE '^Register-Lock:[[:space:]]*none([[:space:]]|$)' | head -1)
                none_reason=$(printf '%s' "$none_decl" \
                    | sed -E 's/^[Rr]egister-[Ll]ock:[[:space:]]*none[[:space:]]*(—|–|--)[[:space:]]*//')
                # If no separator matched, the substitution did not fire and the whole
                # declaration is still sitting in the variable. That is a bare `none`.
                case "$none_reason" in
                    [Rr]egister-[Ll]ock:*) none_reason="" ;;
                esac
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
    archive)    do_archive; exit $? ;;
    ""|-h|--help|help) usage ;;
    *)          echo "ERROR: unknown command '$CMD'" >&2; usage ;;
esac
