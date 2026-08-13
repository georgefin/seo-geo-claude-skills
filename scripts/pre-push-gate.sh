#!/usr/bin/env bash
# pre-push-gate.sh — the APPLY-stage validation gate. Run (or let the
# .claude/settings.json PreToolUse hook run it) before ANY git push:
#   1. scripts/validate-skill.sh on every skill touched vs the base ref
#      (committed or uncommitted) — localizes errors per skill;
#   2. scripts/validate-tracking.sh once — repo-level consistency
#      (version sync, manifest parity, VERSIONS.md rows, 350-line cap,
#      references/ links);
#   3. scripts/claims-gate.sh — F11 drafting-integrity rules on the outgoing
#      register diff (per-push @{upstream} scope; wired 2026-08-09, G5);
#   4. scripts/commit-scope-check.sh — F14 declared-scope integrity: no commit
#      may carry skill files its subject does not name (same per-push scope);
#   5. scripts/register-lock.sh gate-check — F14 second mechanism: no commit may
#      touch a path another writer had open in the register write-lock ledger
#      without declaring that holder (same per-push scope; silent when nobody
#      announced a path).
# Push only when all five pass. With Actions disabled on this fork, this gate
# is the effective CI (docs/loop/PIPELINE.md stage 4).
#
# Usage: ./scripts/pre-push-gate.sh [base-ref]   (default: origin/main)
# Exit:  0 = gate passed, 1 = gate failed

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE="${1:-origin/main}"
overall=0

skill_dirs_from() { grep -oE '^(research|build|optimize|monitor|cross-cutting)/[^/]+' | sort -u; }

if git -C "$ROOT" rev-parse --verify --quiet "$BASE" >/dev/null; then
    committed=$(git -C "$ROOT" diff --name-only "$BASE"...HEAD 2>/dev/null | skill_dirs_from || true)
else
    echo "note: base ref '$BASE' not found — checking uncommitted changes only"
    committed=""
fi
uncommitted=$(git -C "$ROOT" status --porcelain 2>/dev/null | awk '{print $NF}' | skill_dirs_from || true)
touched=$(printf '%s\n%s\n' "$committed" "$uncommitted" | grep . | sort -u || true)

if [ -n "$touched" ]; then
    while IFS= read -r s; do
        [ -n "$s" ] || continue
        if [ ! -f "$ROOT/$s/SKILL.md" ]; then
            echo "== skip $s (no SKILL.md here — deletion or non-skill path; parity is covered by validate-tracking)"
            continue
        fi
        echo "== validate-skill: $s"
        bash "$ROOT/scripts/validate-skill.sh" "$ROOT/$s" || overall=1
    done <<< "$touched"
else
    echo "== no skill directories touched vs $BASE"
fi

echo "== validate-tracking (repo-level)"
bash "$ROOT/scripts/validate-tracking.sh" "$ROOT" || overall=1

echo "== claims-gate (F11 register drafting integrity)"
# Scope decision (G5 wiring, 2026-08-09): no base arg — claims-gate resolves
# @{upstream}, gating each push's NEW outgoing register drafting. Pre-gate
# branch history is grandfathered to the Mode A covering round; retro-anchoring
# pre-gate text would fabricate drafting-time evidence.
bash "$ROOT/scripts/claims-gate.sh" || overall=1

echo "== commit-scope-check (F14 declared-scope integrity)"
# Same per-push scope decision as claims-gate: no base arg, so the check
# resolves @{upstream} and judges only this push's NEW commits. History pushed
# before the guard existed is grandfathered by construction — it is no longer
# outgoing — which is the honest treatment: the guard cannot testify about
# staging decisions it never observed.
bash "$ROOT/scripts/commit-scope-check.sh" || overall=1

echo "== register-lock gate-check (F14 second mechanism: shared-register write collisions)"
# Scope decision: same per-push @{upstream} scope as checks 3 and 4, for the
# same reason — the question is about THIS push's new commits, and the
# .register-locks journal is gitignored session state that can say nothing about
# history pushed before it existed. Second scope decision, specific to this
# check: its unit is the paths writers actually announced, not a hardcoded
# register list. With no journal (or none covering an outgoing commit) it has
# nothing to assert and passes, so a solo session pays zero friction; it only
# speaks when two workstreams overlapped on one file.
bash "$ROOT/scripts/register-lock.sh" gate-check || overall=1

echo ""
if [ "$overall" -ne 0 ]; then
    echo "PRE-PUSH GATE: FAILED — fix the FAILs above before pushing."
    exit 1
fi

# Null-scope disclosure (added 2026-08-13, Mode A finding F8). Checks 3-5 are
# scoped to @{upstream}..HEAD. When everything is already pushed that range is
# empty, they each report "nothing to check" and pass, and the gate printed a
# bare PASSED — a clean bill of health from three checks that read nothing.
# That is F15's shape at the summary line: a guard reporting success for
# matching nothing. The checks are right to be scoped this way; the summary was
# wrong to hide it. State what was actually scanned.
outgoing_n=0
if up=$(git rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null); then
    outgoing_n=$(git rev-list --count "$up..HEAD" 2>/dev/null || echo 0)
fi
dirty_n=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

if [ "$outgoing_n" -eq 0 ] && [ "$dirty_n" -eq 0 ]; then
    echo "PRE-PUSH GATE: PASSED — but NOTHING WAS OUTGOING."
    echo "  The commit-scope, register-lock and claims legs are scoped to"
    echo "  @{upstream}..HEAD, which is empty, so they scanned no commits. This is"
    echo "  not evidence about any commit; it is the absence of a subject. Re-run"
    echo "  against an explicit base to judge already-pushed work, e.g."
    echo "    bash scripts/claims-gate.sh <base>   bash scripts/commit-scope-check.sh <base>"
    exit 0
fi
echo "PRE-PUSH GATE: PASSED — scanned $outgoing_n outgoing commit(s), $dirty_n changed path(s) in the worktree"
exit 0
