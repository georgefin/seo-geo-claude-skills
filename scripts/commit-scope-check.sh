#!/usr/bin/env bash
# commit-scope-check.sh — F14 guard: a commit must not carry skill files its
# subject does not declare.
#
# Why this exists: coordinator sessions run parallel authoring agents, so the
# working tree routinely holds untracked files created by someone else. A
# `git add -A` (or `git add .`) then sweeps those files into whatever commit is
# being written, and the commit message — accurate about its own scope — becomes
# a false record of what landed. Ledger F14, 2026-08-10: four eval fixtures
# written by a parallel agent landed inside `chore(identity): re-attribute fork
# manifests`. Nothing was lost and nothing was wrong in the files; the RECORD was
# wrong, which is the thing this repo's whole review layer depends on.
#
# Rule enforced, per outgoing commit:
#   - collect the skill directories the commit touches
#     (build|research|optimize|monitor|cross-cutting)/<skill>/...
#   - zero touched            -> pass (register/script/root-doc commits)
#   - one touched             -> the subject line must name that skill
#   - two or more touched     -> the subject must name every one of them, or
#                               carry an explicit multi-skill marker
#                               (library-wide | sweep | purge | wave | all skills)
#
# Scope: same as claims-gate — outgoing commits only (<base>...HEAD). Branch
# history that predates the guard is grandfathered by construction: once pushed,
# it is no longer outgoing.
#
# Usage: commit-scope-check.sh [<base-ref>]
#   no arg -> @{upstream} if it resolves, else nothing to check.
#        commit-scope-check.sh --probe
#   fault injection over scripts/fixtures/commit-scope-check/ (see below).
#
# ── FAULT INJECTION (--probe), added for G3-C5 ────────────────────────────────
# This leg reads COMMIT MESSAGES AND CHANGED PATHS, not file contents, so its
# fixtures cannot be files on disk — they have to be commits. `--probe` builds a
# throwaway git repository under $TMPDIR, SYMLINKS this script into its scripts/
# directory, and runs it there. The symlink is the whole mechanism: `ROOT` is
# derived from `${BASH_SOURCE[0]}`, which bash reports as the path used to invoke
# the script, so the symlinked run resolves its root to the temp repo. Nothing is
# copied (a copy is the drift defect this repo has already paid for three times),
# no history is rewritten, and the real repository is never touched.
#
# The probe asserts `Repo root:` names the temp repo before grading anything. If
# root resolution is ever changed to `readlink -f`, the probe would silently start
# measuring the REAL repo and report whatever today's branch happens to contain —
# a guard reporting on the wrong subject, which is F15 wearing a rosette.
#
# WHAT THIS PROBE DOES NOT PROVE:
#   1. Anything about the DEFAULT invocation. The gate calls this with no base ref,
#      so it resolves `@{upstream}`; every probe case passes an explicit base,
#      because a temp repo has no upstream. The `@{upstream}` branch is exercised
#      by the gate itself, never here.
#   2. That the alias vocabulary is right — only that each of the ten registers is
#      reachable through it. Per-WORD coverage of ~40 alias words does not exist;
#      one alias per register is asserted, and gap-alias-substring.txt records what
#      that vocabulary lets through.
#   3. That the leg sees every file that should be declared. Three measured blind
#      spots are carried as `known-gap` cases (scripts/*.txt, docs/loop
#      subdirectories, substring alias matching). The probe measures them; it does
#      not claim they are the only ones.
#   4. Anything about staging. The guard judges what landed, and so does the probe;
#      neither can testify about the `git add -A` that put it there.
# ──────────────────────────────────────────────────────────────────────────────

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

if [ "${1:-}" = "--probe" ]; then
    SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
    FIXDIR="$ROOT/scripts/fixtures/commit-scope-check"
    [ -d "$FIXDIR" ] || { echo "PROBE ERROR: fixture directory missing: $FIXDIR" >&2; exit 2; }
    command -v git >/dev/null 2>&1 || { echo "PROBE ERROR: git is required" >&2; exit 2; }

    shopt -s nullglob
    CASES=("$FIXDIR"/*.txt)
    shopt -u nullglob
    # Scope control (F15-r3: a probe that scans nothing must fail, not pass).
    if [ "${#CASES[@]}" -eq 0 ]; then
        echo "PROBE ERROR: no cases in $FIXDIR — a probe with an empty corpus measures nothing" >&2
        exit 2
    fi

    probe_fail=0; n_pos=0; n_neg=0; n_gap=0; GAPS=""
    head_of() { awk '/^# ---8<---/{exit} {print}' "$1"; }
    body_of() { awk 'f{print} /^# ---8<---/{f=1}' "$1"; }
    dvals()   { head_of "$2" | sed -n "s/^# $1:[[:space:]]*//p"; }

    TR="$(mktemp -d)"; MSGD="$(mktemp -d)"; trap 'rm -rf "$TR" "$MSGD"' EXIT
    # The message file lives OUTSIDE the repo: `git clean -qfd` runs between cases and
    # ate it on the first run, so every commit silently failed and every case then
    # "passed" against an empty range. That is the failure this whole file guards.
    mkdir -p "$TR/scripts"
    ln -s "$SELF" "$TR/scripts/commit-scope-check.sh"
    git -C "$TR" init -q
    git -C "$TR" config user.email "probe@invalid.example"
    git -C "$TR" config user.name  "probe"
    git -C "$TR" config commit.gpgsign false
    git -C "$TR" config core.hooksPath "$TR/.no-hooks"
    # The symlink must never enter a commit: it is the instrument, not a subject.
    printf 'scripts/commit-scope-check.sh\n' > "$TR/.git/info/exclude"
    printf 'probe fixture root\n' > "$TR/README-BASE.md"
    git -C "$TR" add README-BASE.md
    git -C "$TR" commit -q -m "base: probe fixture root"
    BASESHA="$(git -C "$TR" rev-parse HEAD)"

    echo "commit-scope-check --probe : fault injection on synthetic commits"
    echo "Fixture: $FIXDIR"
    echo "Temp repo: $TR (symlinked script, no history rewritten, real repo untouched)"
    echo "=============================================="

    # run_commit <base-ref> <message-file> <path...> -> sets RC and OUT
    run_commit() {
        local base="$1" msgfile="$2"; shift 2
        git -C "$TR" checkout -q -B probecase "$BASESHA"
        git -C "$TR" clean -qfd
        local p
        for p in "$@"; do
            mkdir -p "$TR/$(dirname "$p")"
            printf 'probe fixture content\n' > "$TR/$p"
        done
        if [ "$#" -gt 0 ]; then
            git -C "$TR" add -A
            git -C "$TR" commit -q -F "$msgfile"
        fi
        OUT="$(bash "$TR/scripts/commit-scope-check.sh" "$base" 2>&1)"; RC=$?
        NCOMMIT="$#"
    }

    for f in "${CASES[@]}"; do
        base_name="$(basename "$f" .txt)"
        while IFS= read -r line; do
            case "$line" in
                '# CASE:'*|'# ROLE:'*|'# EXPECT-EXIT:'*|'# EXPECT-MATCH:'*) ;;
                '# EXPECT-ABSENT:'*|'# FILE:'*|'# BASE:'*|'# GAP:'*) ;;
                '# WHY:'*|'# WHY '*) ;;
                '# '[A-Z]*:*) echo "  PROBE FAIL  $base_name — unknown directive: $line"; probe_fail=1 ;;
                '#'*|'') ;;
                *) echo "  PROBE FAIL  $base_name — non-comment line before the message separator"
                   probe_fail=1 ;;
            esac
        done < <(head_of "$f")

        role="$(dvals ROLE "$f" | head -1)"
        want="$(dvals EXPECT-EXIT "$f" | head -1)"
        if [ -z "$role" ] || [ -z "$want" ] || [ -z "$(dvals EXPECT-MATCH "$f")" ]; then
            echo "  PROBE FAIL  $base_name — needs ROLE, EXPECT-EXIT and at least one EXPECT-MATCH"
            echo "              (an exit code alone is a right answer for a possibly wrong reason)"
            probe_fail=1; continue
        fi
        case "$role" in
            positive)  n_pos=$((n_pos + 1)) ;;
            negative)  n_neg=$((n_neg + 1)) ;;
            known-gap) n_gap=$((n_gap + 1)); GAPS="$GAPS  [$base_name] $(dvals GAP "$f" | head -1)
" ;;
            *) echo "  PROBE FAIL  $base_name — ROLE must be positive|negative|known-gap"; probe_fail=1; continue ;;
        esac

        body_of "$f" > "$MSGD/msg"
        casebase="$(dvals BASE "$f" | head -1)"; [ -n "$casebase" ] || casebase="$BASESHA"
        [ "$casebase" = "HEAD" ] && casebase="$BASESHA"
        mapfile -t files < <(dvals FILE "$f")
        run_commit "$casebase" "$MSGD/msg" ${files[@]+"${files[@]}"}

        # The instrument must be pointed at the temp repo. Checked before the verdict
        # is read, so a probe can never grade output produced from the real tree.
        if ! printf '%s\n' "$OUT" | grep -qF "Repo root: $TR"; then
            echo "  PROBE FAIL  $base_name — the run did not resolve its root to the temp repo."
            echo "              Root resolution changed and this probe is measuring the wrong tree."
            printf '%s\n' "$OUT" | sed 's/^/      | /' | head -4
            probe_fail=1; continue
        fi
        # SCOPE CONTROL, per case (F15-r3). A case that made a commit must have had
        # something to scan; "no outgoing commits" is a pass by emptiness and is the
        # only way every one of these cases can look green while measuring nothing.
        # scope-no-outgoing-commits.txt is the one case that asserts it deliberately,
        # and it makes no commit.
        if [ "$NCOMMIT" -gt 0 ] && printf '%s\n' "$OUT" | grep -qF "no outgoing commits"; then
            echo "  PROBE FAIL  $base_name — the commit never landed; this case scanned an"
            echo "              empty range and its verdict is about nothing"
            probe_fail=1; continue
        fi
        if [ "$RC" -ne "$want" ]; then
            echo "  PROBE FAIL  $base_name — expected exit $want, got $RC"
            printf '%s\n' "$OUT" | sed 's/^/      | /' | tail -10
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
        printf '  ok  %-10s %-30s exit %s · %s\n' "$role" "$base_name" "$RC" \
            "$(printf '%s\n' "$OUT" | grep -m1 '^Results:' | sed $'s/\033\\[[0-9;]*m//g' || echo 'no Results line')"
    done

    # ── branch mirror 1: every breadth marker, read out of this file's own source ──
    # F15-r4: a canary per family is not a canary per branch. The markers are not
    # restated here, they are EXTRACTED, so a marker added later is exercised the next
    # time the probe runs instead of shipping unguarded.
    echo ""
    echo "BRANCH MIRROR — multi-skill breadth markers, extracted from this file's source"
    marker_line="$(grep -m1 -- '\*library-wide\*' "$SELF")"
    if [ -z "$marker_line" ]; then
        echo "  PROBE FAIL  the breadth-marker line could not be found — the mirror is broken,"
        echo "              which means the markers are unguarded whatever the rest of this says"
        probe_fail=1
    else
        markers="$(printf '%s' "$marker_line" | tr '|' '\n' \
                   | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/)$//' \
                         -e 's/^\*//' -e 's/\*$//' -e 's/"//g' | grep -v '^$')"
        nmark=0
        printf 'chore(x): tidy-up\n' > "$MSGD/msg"
        run_commit "$BASESHA" "$MSGD/msg" \
            "research/keyword-research/SKILL.md" "research/serp-analysis/SKILL.md"
        if [ "$RC" -eq 1 ]; then
            echo "  ok  positive   two skills, no marker, neither named   exit 1"
        else
            echo "  PROBE FAIL  two undeclared skills passed with no breadth marker (exit $RC)"
            probe_fail=1
        fi
        while IFS= read -r mk; do
            [ -n "$mk" ] || continue
            nmark=$((nmark + 1))
            printf 'chore(x): %s tidy-up\n' "$mk" > "$MSGD/msg"
            run_commit "$BASESHA" "$MSGD/msg" \
                "research/keyword-research/SKILL.md" "research/serp-analysis/SKILL.md"
            if [ "$RC" -eq 0 ] && ! printf '%s\n' "$OUT" | grep -qF "no outgoing commits"; then
                printf '  ok  negative   breadth marker %-24s exit 0\n' "\"$mk\""
            else
                echo "  PROBE FAIL  the declared breadth marker \"$mk\" did not excuse a two-skill commit"
                probe_fail=1
            fi
        done <<< "$markers"
        echo "  $nmark of $nmark breadth markers exercised (extracted, not restated)"
    fi

    # ── branch mirror 2: every register in the alias table has a fixture ──
    echo ""
    echo "BRANCH MIRROR — register_aliases() keys, extracted from this file's source"
    keys="$(sed -n '/^register_aliases()/,/^}/p' "$SELF" \
            | grep -oE '^[[:space:]]+[a-z][a-z-]*\)' | tr -d ' )')"
    fixture_regs="$(grep -h '^# FILE:' "$FIXDIR"/*.txt | sed -e 's/^# FILE:[[:space:]]*//' \
                    | grep -E '^(docs/loop/[^/]+\.md|VERSIONS\.md)$' \
                    | sed -e 's#.*/##' -e 's#\.md$##' | tr '[:upper:]' '[:lower:]' | sort -u)"
    nkey=0; nhit=0
    while IFS= read -r k; do
        [ -n "$k" ] || continue
        nkey=$((nkey + 1))
        if printf '%s\n' "$fixture_regs" | grep -qx "$k"; then
            nhit=$((nhit + 1))
        else
            echo "  PROBE FAIL  register '$k' has an alias list and no fixture touches it"
            probe_fail=1
        fi
    done <<< "$keys"
    echo "  $nhit of $nkey alias-table registers are touched by a fixture case"
    echo "  (register-alias-vocabulary.txt names all ten by ALIAS only — that case is the"
    echo "   only exercise the alias branch has, and it passes or the corpus above fails)"

    echo ""
    echo "STATED LIMITS — measured blind spots, asserted so they stay measured"
    printf '%s' "$GAPS"
    echo "  (what the probe itself does not prove: sed -n '32,62p' $SELF)"
    echo ""
    if [ "$probe_fail" -eq 0 ]; then
        echo "PROBE PASS — ${#CASES[@]} cases: $n_pos positive, $n_neg negative controls, $n_gap known-gap;"
        echo "             plus $nmark breadth-marker branches and $nkey alias-table registers mirrored."
        exit 0
    fi
    echo "PROBE FAILED"
    exit 1
fi

RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; NC=$'\033[0m'
pass=0; fail=0; warn=0

# ---------------------------------------------------------------------------
# DIFF BASE RESOLUTION (2026-08-19). The base is $1, else @{upstream}, else the
# run is REFUSED. It is PRINTED on every run, with the provenance that chose it.
#
# WHAT WENT WRONG WITHOUT IT. This check used to SKIP -- and exit 0 -- when no
# base and no upstream could be found, printing no base at all. On a DETACHED
# HEAD that is every run: the guard read nothing, said so in one yellow line
# among many, and returned success. A sibling gate on the same tree took the
# other branch of the same defect, silently falling back to origin/main (350
# commits behind the real base) and reporting 24 FAILs that vanish against the
# right base, in the same second.
#
# Both shapes are the same fault: a base nobody chose and nothing printed. A
# guessed or absent base is unsound IN BOTH DIRECTIONS -- it can invent findings
# against unrelated history and hide real ones by reading a range that does not
# contain the work. So it refuses rather than proceeds; an unreached verdict
# must never be readable as a pass.
#
# GATE_ALLOW_UNRESOLVED_BASE=1 downgrades the refusal to a loud stderr notice,
# for fixture/probe harnesses that run this file inside a throwaway repository
# where no base can exist. It never silences the disclosure.
# ---------------------------------------------------------------------------
refuse_unresolved_base() {   # <how-to-invoke-this-script>
    if [ "${GATE_ALLOW_UNRESOLVED_BASE:-}" = "1" ]; then
        echo "WARNING: no diff base resolved, and GATE_ALLOW_UNRESOLVED_BASE=1 is set -- proceeding" >&2
        echo "WARNING: WITHOUT a base ref. Fixture/probe harnesses only. Whatever follows is not a" >&2
        echo "WARNING: verdict about any commit; do NOT read it as a pass." >&2
        return 0
    fi
    echo "ERROR: no diff base could be resolved -- refusing to run rather than guessing one." >&2
    echo "ERROR:   No base was given as \$1, and '@{upstream}' does not resolve here (detached" >&2
    echo "ERROR:   HEAD, or a branch with no upstream configured)." >&2
    echo "ERROR:   This check used to SKIP and exit 0 here, which reported success for having" >&2
    echo "ERROR:   read no commits at all." >&2
    echo "ERROR: fix: pass the base explicitly            ->  $1 <base-ref>" >&2
    echo "ERROR:      or run from a branch with an upstream ->  git branch --set-upstream-to=origin/<branch>" >&2
    echo "ERROR: nothing was checked and no verdict was reached; do NOT read this as a pass." >&2
    exit 2
}


echo "commit-scope-check: F14 declared-scope check on outgoing commits"
echo "Repo root: $ROOT"
echo "=============================================="

BASE="${1:-}"
if [ -n "$BASE" ]; then
  BASE_SRC="explicit argument"
elif BASE=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null); then
  BASE_SRC="upstream"
else
  refuse_unresolved_base "scripts/commit-scope-check.sh"
  BASE=""; BASE_SRC="NOTHING -- unresolved, fixture override in force"
fi
echo "Diff base: ${BASE:-(none)} (resolved from: $BASE_SRC)"
if [ -z "$BASE" ]; then
  echo "${YELLOW}  SKIP${NC}: no base ref and no upstream — nothing outgoing to check"
  echo "=============================================="
  echo "Results: ${GREEN}0 passed${NC}, ${YELLOW}1 warning${NC}, ${RED}0 failed${NC}"
  exit 0
fi

# An explicit base that does not resolve is an ERROR, not a skip.
#
# By the time control reaches here the fallback above has already refused when NO
# base could be resolved, so a non-empty $BASE that fails rev-parse means the caller
# named a ref that does not exist -- a typo, a deleted branch, a stale remote name.
# Skipping there and exiting 0 printed a green for a run that compared nothing: the
# same false-green class this script's base guard was written to close, one branch
# over. A caller who names a base is asserting it exists; disagreeing silently is
# the failure mode, not the safe default.
if ! git rev-parse --verify --quiet "$BASE" >/dev/null; then
  echo "ERROR: base ref '$BASE' does not resolve -- refusing to run rather than skipping." >&2
  echo "ERROR:   It was supplied explicitly, so this is a bad ref rather than a missing default:" >&2
  echo "ERROR:   check for a typo, a deleted branch, or a remote-tracking ref that needs a fetch." >&2
  echo "ERROR: no commits were compared and no verdict was reached; do NOT read this as a pass." >&2
  exit 2
fi

COMMITS=$(git rev-list "$BASE..HEAD" 2>/dev/null)
if [ -z "$COMMITS" ]; then
  echo "${GREEN}  PASS${NC}: no outgoing commits — nothing to check"
  echo "=============================================="
  echo "Results: ${GREEN}1 passed${NC}, ${YELLOW}0 warnings${NC}, ${RED}0 failed${NC}"
  exit 0
fi

CATEGORIES='build|research|optimize|monitor|cross-cutting'

# Alias vocabulary for the register leg. A commit that touches a shared register
# must SAY SO somewhere in its message; these are the words that count as saying
# so for each file, beyond the file's own basename.
register_aliases() {
  case "$1" in
    failure-ledger)          echo "ledger f1 f2 f3 f4 f5 f6 f7 f8 f9 recurrence" ;;
    gated-items)             echo "gated gate g1 g2 g3 g4 g5 g6 g7 g8 g9 verdict" ;;
    watch-items)             echo "watch w1 w2 verify" ;;
    settled-rulings)         echo "ruling settled r1 r2 r3 r4 r5 pointer anchor" ;;
    pipeline)                echo "pipeline stage" ;;
    versions)                echo "version changelog bump" ;;
    kpi)                     echo "kpi metric" ;;
    pilot)                   echo "pilot g8 input" ;;
    adversarial-layer)       echo "adversarial protocol" ;;
    master-improvement-plan) echo "directive plan phase" ;;
    *)                       echo "" ;;
  esac
}

for sha in $COMMITS; do
  subject=$(git log -1 --format=%s "$sha")
  subject_lc=$(printf '%s' "$subject" | tr '[:upper:]' '[:lower:]')
  message_lc=$(git log -1 --format='%s%n%b' "$sha" | tr '[:upper:]' '[:lower:]')
  files=$(git diff-tree --no-commit-id --name-only -r "$sha")

  # --- Register leg (added 2026-08-10 after this guard's own author committed
  # register closures inside a commit whose message named only an agent fix).
  # A register file has no owning skill, so the skill leg below is structurally
  # blind to it — that blindness is what let the instance through. The rule here
  # is deliberately weaker than the skill leg: a register need only be MENTIONED
  # somewhere in the message, by basename or by one of its aliases, because
  # registers legitimately ride along with the work they record.
  registers=$(printf '%s\n' "$files" \
    | grep -E '^(docs/loop/[^/]+\.md|VERSIONS\.md)$' \
    | sed 's#.*/##; s#\.md$##' \
    | tr '[:upper:]' '[:lower:]' \
    | sort -u)

  reg_missing=""
  if [ -n "$registers" ]; then
    while IFS= read -r reg; do
      [ -z "$reg" ] && continue
      hit=0
      case "$message_lc" in *"$reg"*) hit=1 ;; esac
      if [ "$hit" -eq 0 ]; then
        for alias in $(register_aliases "$reg"); do
          case "$message_lc" in *"$alias"*) hit=1; break ;; esac
        done
      fi
      [ "$hit" -eq 0 ] && reg_missing="$reg_missing $reg"
    done <<< "$registers"
  fi

  if [ -n "$reg_missing" ]; then
    fail=$((fail+1))
    echo "${RED}  FAIL${NC}: ${sha:0:7} touches register(s) its message never mentions:$reg_missing"
    echo "        subject: $subject"
    echo "        fix: name the register in the subject or body (or one of its"
    echo "             aliases), or split the register change into its own commit."
    continue
  fi

  # --- Gate leg (added 2026-08-13, Mode A finding F9). Same blindness, one
  # directory over and with worse consequences. `71345f3` carried the subject
  # "docs(loop): thirteenth verdict entry" and the body "Registers touched:
  # gated-items, settled-rulings" — and also edited `scripts/validate-tracking.sh`,
  # widening check (f)'s allowlist. Neither leg above could see it: `scripts/` is
  # not a skill directory and not a register. **A commit that changes what the gates
  # accept, while declaring only what it recorded, is the most consequential
  # undeclared scope there is** — the guard's own behaviour changed and its own
  # scope check was structurally unable to say so. One of the tokens added in that
  # commit was the B2 overstatement, which then passed the gate for two days
  # because the gate had been taught to accept it.
  #
  # Same weak form as the register leg — the message need only SAY it touched the
  # code — but it must name **the file**, by basename. The first draft of this leg
  # accepted a vocabulary list including "gate"/"gates", and the probe against
  # `71345f3` (the very commit that motivated the leg) came back clean: its message
  # says "gate" all over, because it is about **G**ATED-ITEMS. The guard would have
  # passed by matching a word that meant something else — F15's exact failure shape,
  # reproduced inside the fix for a different instance of it, and caught only
  # because the probe is mandatory. Basenames cannot collide that way: a commit
  # editing `scripts/validate-tracking.sh` has to write `validate-tracking`.
  # That commit is checked in as scripts/fixtures/commit-scope-check/gate-code-undeclared.txt
  # and `--probe` re-runs it, so the near-miss stays measured rather than remembered.
  gate_files=$(printf '%s\n' "$files" | grep -E '^(scripts/.*\.(sh|py)|\.claude/settings\.json)$' || true)
  gate_missing=""
  if [ -n "$gate_files" ]; then
    while IFS= read -r gf; do
      [ -z "$gf" ] && continue
      base=$(printf '%s' "$gf" | sed 's#.*/##; s#\.\(sh\|py\|json\)$##' | tr '[:upper:]' '[:lower:]')
      case "$message_lc" in *"$base"*) : ;; *) gate_missing="$gate_missing $gf" ;; esac
    done <<< "$gate_files"
  fi
  if [ -n "$gate_missing" ]; then
    fail=$((fail+1))
    echo "${RED}  FAIL${NC}: ${sha:0:7} changes gate/guard code its message never names:"
    printf '        %s\n' $gate_missing
    echo "        subject: $subject"
    echo "        fix: name the file by basename in the subject or body (e.g."
    echo "             'validate-tracking'), or split the code change into its own"
    echo "             commit. A commit that changes what the gates accept must be"
    echo "             visible as one in the log."
    continue
  fi

  skills=$(printf '%s\n' "$files" \
    | grep -E "^($CATEGORIES)/[^/]+/" \
    | cut -d/ -f2 \
    | sort -u)

  if [ -z "$skills" ]; then
    pass=$((pass+1))
    continue
  fi

  count=$(printf '%s\n' "$skills" | grep -c .)
  missing=""
  while IFS= read -r skill; do
    [ -z "$skill" ] && continue
    case "$subject_lc" in
      *"$skill"*) : ;;
      *) missing="$missing $skill" ;;
    esac
  done <<< "$skills"

  if [ -z "$missing" ]; then
    pass=$((pass+1))
    continue
  fi

  # Multi-skill commits may declare breadth instead of naming every skill.
  if [ "$count" -ge 2 ]; then
    case "$subject_lc" in
      *library-wide*|*sweep*|*purge*|*wave*|*"all skills"*)
        pass=$((pass+1))
        continue
        ;;
    esac
  fi

  fail=$((fail+1))
  echo "${RED}  FAIL${NC}: ${sha:0:7} touches skill file(s) its subject does not declare:$missing"
  echo "        subject: $subject"
  printf '%s\n' "$files" | grep -E "^($CATEGORIES)/($(printf '%s' "$missing" | tr -s ' ' '|' | sed 's/^|//'))/" \
    | sed 's/^/        offending: /'
  echo "        fix: stage explicit paths (never 'git add -A' with parallel agents"
  echo "             running), or name the skill(s) in the subject if they belong."
done

echo "=============================================="
if [ "$fail" -gt 0 ]; then
  echo "Results: ${GREEN}${pass} passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}${fail} failed${NC}"
  echo "${RED}commit-scope-check FAILED${NC}"
  exit 1
fi
echo "Results: ${GREEN}${pass} passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}${fail} failed${NC}"
echo "${GREEN}commit-scope-check PASSED${NC}"
exit 0
