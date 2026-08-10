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

for sha in $COMMITS; do
  subject=$(git log -1 --format=%s "$sha")
  subject_lc=$(printf '%s' "$subject" | tr '[:upper:]' '[:lower:]')
  files=$(git diff-tree --no-commit-id --name-only -r "$sha")

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
