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
#      announced a path);
#   6. scripts/register-lock.sh archive — G1-C5 evidence durability (this leg is
#      itself fault-injected: `bash scripts/register-lock.sh --probe`): runs the
#      archive automatically at wave end and REFUSES the push while
#      docs/loop/register-locks-archive/ is dirty. It writes, which no other leg
#      does, so it never lets the push proceed on its own writes -- the rows must
#      land in a commit or they die with the container. Passes silently when the
#      archive is clean, which is every push that journalled nothing.
# Push only when all six pass. With Actions disabled on this fork, this gate
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

echo "== fence-nesting-check (rendered-shape integrity)"
# Wired in immediately rather than run advisory for a week, unlike engine-claim-sweep.sh.
# The distinction is the failure mode. That sweep's risk is punishing a corrected line — it
# needs human eyes on its output before it gets a veto. This one has no judgment in it: a
# fence is either closed by CommonMark's rule or it is not, the probe carries a negative
# control, and it returned 0 findings across all 230 files once the two real defects were
# fixed. It found those two in SKILL.md files that passed validate-skill.sh at 15/15.
bash "$ROOT/scripts/fence-nesting-check.sh" >/dev/null 2>&1 || {
    bash "$ROOT/scripts/fence-nesting-check.sh"
    overall=1
}

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
echo "== register-lock archive (G1-C5 evidence durability)"
# Runs the archive automatically at wave end, then REFUSES the push if it produced
# rows that are not in a commit. It does not "fix and continue", for the reason
# root CLAUDE.md gives about reanchor-pointers: a push must not silently rewrite
# what it is validating. Writing the rows and letting the push succeed would leave
# them dirty in a worktree the container is about to reclaim — which is the exact
# failure this leg exists to prevent, dressed as a pass.
#
# Why here and not only on `release`: the 2026-08-17 wave was journalled by the
# coordinator appending rows to the file directly, never calling the CLI, so a
# release-only hook would have archived nothing for the very wave that motivated
# this. `release` archives too (its natural wave-end point); this is the backstop
# for hand-journalled rows.
#
# Zero friction when there is nothing to do: with no journal, or no new rows, it
# prints one line and passes.
#
# THE CONDITION IS "IS THE ARCHIVE COMMITTED", NOT "DID THIS RUN WRITE ANYTHING".
# The first draft asked the second question and was caught by its own selftest: run
# one wrote the rows and FAILed correctly, run two found nothing new to write and
# PASSED — with the rows still sitting uncommitted in the worktree, and printing
# "evidence already committed" while that was false. A check that clears itself on
# a second look is worse than no check. `git status --porcelain` is asked instead,
# so the verdict is the same however many times the leg runs.
#   THAT SENTENCE IS NOW MEASURED, not reasoned. `scripts/register-lock.sh --probe`
#   runs THIS FILE whole in a throwaway git repository, with legs 1-5 stubbed to
#   exit 0 so the gate's exit code is this leg's verdict, and asserts three
#   CONSECUTIVE runs with rows uncommitted (the old defect cleared itself on run
#   two), the flip to pass once they are committed, and the `M `-status shape a
#   second wave produces once the archive is tracked
#   `[obs:2026-08-18 probe section "GATE LEG 6": 6 assertions, and the reverted
#   "did this run write anything" condition is one of the mutations the probe
#   catches — the mutant FAILs run 1 correctly and then clears itself on runs 2
#   and 3, which is the original defect exactly]`.
#
# LEG 6 CAN DEMAND A COMMIT LEG 5 REFUSES, and an operator hitting it should not
# have to rediscover why. Leg 5 FAILs a commit that touches a path inside another
# holder's tenure undeclared; a lane holding the `docs/loop/` PREFIX holds
# docs/loop/register-locks-archive/ with it, so the archive commit this leg demands
# is exactly the commit leg 5 blocks
# `[obs:2026-08-18 temp repo, lane-b holding docs/loop/, commit adding only
# docs/loop/register-locks-archive/<date>.tsv inside that tenure -> gate-check exit
# 1]`. It is escapable, not deadlocked: the archive rows are evidence, not that
# holder's content, which is precisely the auditable claim `Register-Lock: none --
# <reason>` exists to make. Which escape is right is a coordination call, so it is
# named here instead of being decided by whichever leg happens to run first.
_arch_out=$(bash "$ROOT/scripts/register-lock.sh" archive 2>&1) || true
_arch_dirty=$(cd "$ROOT" && git status --porcelain -- docs/loop/register-locks-archive/ 2>/dev/null)
if [ -n "$_arch_dirty" ]; then
    printf '%s\n' "$_arch_out"
    echo "  FAIL: lock-journal evidence is not committed:"
    printf '%s\n' "$_arch_dirty" | sed 's/^/        /'
    echo "        G1-C5 is checked against docs/loop/register-locks-archive/, not the"
    echo "        gitignored journal, so uncommitted rows die with this container."
    echo "        Stage them into this push, then re-run:"
    echo "            git add docs/loop/register-locks-archive/ && git commit --amend --no-edit"
    overall=1
else
    echo "register-lock archive: up to date and committed"
fi

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
