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

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT" || exit 1

RED=$'\033[0;31m'; GREEN=$'\033[0;32m'; YELLOW=$'\033[1;33m'; NC=$'\033[0m'
pass=0; fail=0; warn=0

echo "commit-scope-check: F14 declared-scope check on outgoing commits"
echo "Repo root: $ROOT"
echo "=============================================="

BASE="${1:-}"
if [ -z "$BASE" ]; then
  if BASE=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null); then
    :
  else
    echo "${YELLOW}  SKIP${NC}: no base ref and no upstream — nothing outgoing to check"
    echo "=============================================="
    echo "Results: ${GREEN}0 passed${NC}, ${YELLOW}1 warning${NC}, ${RED}0 failed${NC}"
    exit 0
  fi
fi

if ! git rev-parse --verify --quiet "$BASE" >/dev/null; then
  echo "${YELLOW}  SKIP${NC}: base ref '$BASE' does not resolve"
  exit 0
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
