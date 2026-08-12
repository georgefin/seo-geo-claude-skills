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
#
# EVALUATED SCOPE IS PRINTED ON EVERY EXIT (added 2026-08-12; R-0222/R-0297).
# The three early exits below each used to print a Results line whose counts were
# STRING LITERALS rather than evaluations — the no-outgoing branch printed
# `Results: 1 passed` having judged nothing at all. Measured on this branch the
# same day: `@{upstream}` resolved to HEAD itself, so `rev-list @{upstream}..HEAD`
# was empty and that literal `1` was the only thing pre-push-gate's "all six pass"
# summary had to go on. A green from a check that evaluated nothing is a
# fabricated verification, so every exit now states the commit count it judged and
# no zero-work exit is allowed to call itself a PASS.
#
# Exit policy on an empty scope: 0 by default. "Nothing outgoing" is a legitimate
# and common state — a branch level with its upstream — and failing it would make
# the gate unrunnable in the minutes after a push. It is reported as NOT RUN, never
# as passed. Set COMMIT_SCOPE_REQUIRE_COMMITS=1 to fail closed instead (exit 2):
# that is the mode for a caller that believes there IS outgoing work, and it is the
# mode this guard's own empty-scope path is proved RED with.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; NC=$'\033[0m'
pass=0; fail=0; warn=0
evaluated=0
STRICT="${COMMIT_SCOPE_REQUIRE_COMMITS:-0}"

# Single exit path for "this run judged no commits". Never prints PASS and never
# prints a nonzero count: the two things that made the old literals readable as a
# clean result.
empty_scope_exit() {   # $1 = why the scope is empty
    echo "${YELLOW}  EMPTY SCOPE${NC}: $1"
    echo "=============================================="
    echo "Scope: 0 commit(s) evaluated — this run judged NOTHING"
    echo "Results: ${GREEN}0 passed${NC}, ${YELLOW}1 warning${NC}, ${RED}0 failed${NC}"
    if [ "$STRICT" = "1" ]; then
        echo "${RED}commit-scope-check FAILED${NC} (COMMIT_SCOPE_REQUIRE_COMMITS=1 — an empty scope is not a pass)"
        exit 2
    fi
    echo "${YELLOW}commit-scope-check NOT RUN${NC} — empty scope is not a pass; re-run against a base with outgoing commits to get a verdict"
    exit 0
}

echo "commit-scope-check: F14 declared-scope check on outgoing commits"
echo "Repo root: $ROOT"
echo "=============================================="

BASE="${1:-}"
if [ -z "$BASE" ]; then
  if BASE=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null); then
    :
  else
    empty_scope_exit "no base ref given and no upstream configured — nothing outgoing to check"
  fi
fi

if ! git rev-parse --verify --quiet "$BASE" >/dev/null; then
  empty_scope_exit "base ref '$BASE' does not resolve"
fi

echo "Base: $BASE ($(git rev-parse --short "$BASE")) | HEAD: $(git rev-parse --short HEAD)"

COMMITS=$(git rev-list "$BASE..HEAD" 2>/dev/null)
if [ -z "$COMMITS" ]; then
  # Reached whenever HEAD is an ancestor of the base — including the case that
  # produced this rewrite, an @{upstream} that resolves to HEAD itself.
  empty_scope_exit "0 commits in $BASE..HEAD (HEAD is contained in the base — nothing is outgoing)"
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
    # open-findings fell through to the empty default until 2026-08-12, so a commit whose
    # subject was transparently about this register — `fix(#80): …` — was structurally
    # invisible to the guard and failed. Its items have no letter-prefixed IDs like the
    # siblings' f1/g1/w1/r1; they are bare numbers, and this branch's own convention for
    # citing one is the conventional-commit scope: `fix(#80)`, `fix(#63,#62,#60)`. Eight
    # subjects use that form, six of them on commits that fix a finding without touching
    # the register at all — so `(#` is this register's real item-ID vocabulary, measured
    # rather than assumed, and `finding` (which also covers "findings") is its noun.
    # Deliberately NOT included: a bare `#`, which matches almost any message and would
    # blanket-pass the leg; `f#`-shaped tokens, which are the FAILURE-LEDGER's vocabulary
    # (F9, F14) and would cross-pass a different register's mentions; and `section a|b|c`,
    # which are this register's own headings but too generic to tell a real reference from
    # prose about any document's sections.
    open-findings)           echo "finding (#" ;;
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
  # Counted before any branch of the body so that every `continue` below is still
  # represented in the scope line. The count is what was JUDGED, not what passed.
  evaluated=$((evaluated+1))
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
echo "Scope: ${evaluated} commit(s) evaluated in $BASE..HEAD"
if [ "$fail" -gt 0 ]; then
  echo "Results: ${GREEN}${pass} passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}${fail} failed${NC}"
  echo "${RED}commit-scope-check FAILED${NC}"
  exit 1
fi
# Internal consistency: the per-commit legs are exhaustive (every commit either
# increments pass or increments fail), so pass+fail must equal the count judged.
# If they ever diverge, a branch was added that silently drops a commit — the
# report would then be about a subset while reading as about the whole scope.
if [ "$((pass + fail))" -ne "$evaluated" ]; then
  echo "${RED}  FAIL${NC}: internal accounting error — ${pass} passed + ${fail} failed != ${evaluated} evaluated"
  echo "        a commit was judged by no leg; the verdict does not cover the scope"
  echo "${RED}commit-scope-check FAILED${NC}"
  exit 1
fi
echo "Results: ${GREEN}${pass} passed${NC}, ${YELLOW}${warn} warnings${NC}, ${RED}${fail} failed${NC}"
echo "${GREEN}commit-scope-check PASSED${NC}"
exit 0
