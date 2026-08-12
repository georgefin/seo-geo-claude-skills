#!/usr/bin/env bash
# pre-push-gate.sh — the APPLY-stage validation gate. Run (or let the
# .claude/settings.json PreToolUse hook run it) before ANY git push:
#   1. scripts/validate-skill.sh on every skill touched vs the base ref
#      (committed or uncommitted) — localizes errors per skill;
#   2. scripts/validate-tracking.sh once — repo-level consistency
#      (version sync, manifest parity, VERSIONS.md rows, 350-line cap,
#      references/ links);
#   3. scripts/check-template-fences.py — finding #80's detector: a ```markdown
#      template block truncated by a nested 3-backtick opener, so the template a
#      model copies ends early. Repo-level like check 2, and whole-tree rather
#      than per-push on purpose: the defect is a property of the file as it now
#      stands, not of who last touched it, and its 13 instances were spread over
#      8 files nobody's subject line named. Its corpus is 205 of the repo's 224
#      .md files (docs/ and dot-directories excluded, both printed every run) and
#      its detection signature is narrow — a green means "nothing matched that
#      signature", never "no truncated templates". Both scopes are documented in
#      the script's own docstrings; quote them with any green;
#   4. scripts/claims-gate.sh — F11 drafting-integrity rules on the outgoing
#      register diff (per-push @{upstream} scope; wired 2026-08-09, G5);
#   5. scripts/commit-scope-check.sh — F14 declared-scope integrity: no commit
#      may carry skill files its subject does not name (same per-push scope);
#   6. scripts/register-lock.sh gate-check — F14 second mechanism: no commit may
#      touch a path another writer had open in the register write-lock ledger
#      without declaring that holder (same per-push scope; silent when nobody
#      announced a path).
#   7. scripts/check-freshness.sh — F5 dated-state staleness. Whole-tree, fixed
#      target list. WIRED 2026-08-12, after the script was given the ability to
#      fail at all: it used to end in an unconditional `exit 0` while the plan
#      counted F5 as converted. What FAILS here is an instrument fault — a
#      tracked path gone missing, an undatable file, a date that will not parse,
#      an empty target set. Staleness itself WARNs, because it is driven by the
#      calendar rather than by this push and the only edit that clears it is a
#      faked review date; the reasoning is argued in full in that script's
#      header. FRESHNESS_REQUIRE_CURRENT=1 promotes staleness to a failure for a
#      caller running the sweep.
#   8. scripts/check-trigger-archives.sh — F10 archive-on-write: every durable
#      row in PIPELINE.md's trigger registry maps to an archived prompt file.
#      Whole-tree. WIRED 2026-08-12; it had been written and called by nothing
#      while the plan recorded F10 as converted into "check (h)" — an id that
#      belongs to validate-tracking's F3 sweep, not to this guard.
# Push only when all eight pass AND all eight had something to evaluate. Those are two
# different statements and this gate used to make only the first — the sentence here
# read "Push only when all six pass", which a reader converts into "six checks
# examined this push". Measured 2026-08-12 on branch section-b: `@{upstream}`
# resolved to HEAD itself, so `rev-list @{upstream}..HEAD` was EMPTY and checks 5 and
# 6 returned early passes having judged zero commits, while the summary line printed
# an unqualified PASSED. Check 4 has a second, worktree-side diff source and so was
# only partly affected. That is R-0222 / R-0297: a check that cannot fail is not a
# check, and a green from a check that evaluated nothing is a fabricated verification.
# The scope block below measures every leg's scope BEFORE the legs run and re-states
# any empty leg with the verdict, so a reduced-scope green can never be read as an
# eight-check green.
#
# Check 1 was ALSO unaccounted until 2026-08-12: with no skill directory touched it
# prints "no skill directories touched" and validates nothing, yet sat inside the
# denominator as though it had. Bumping that denominator from 6 to 8 would have
# inherited the hole, so it is measured and flagged too. Checks 2 and 3 are whole-tree
# over a fixed corpus and 3 documents its own empty-scan-set fail-closed (exit 2);
# checks 7 and 8 likewise FAIL rather than pass on an empty scan set, so for those
# three the accounting and the script agree by construction rather than by assertion.
#
# With Actions disabled on this fork, this gate is the effective CI
# (docs/loop/PIPELINE.md stage 4).
#
# Usage: ./scripts/pre-push-gate.sh [base-ref]   (default: origin/main)
#        base-ref governs check 1 ONLY. Checks 4-6 take no base argument by design
#        (see the notes at each call) and resolve @{upstream} themselves, so passing
#        a base here does NOT widen them — a fact the scope block prints rather than
#        leaving to be inferred. Checks 2, 3, 7 and 8 are whole-tree and ignore it.
# Env:   PREPUSH_REQUIRE_SCOPE=1 — treat a reduced scope as a FAILURE (exit 1)
#        instead of a qualified pass. For a caller that believes there IS outgoing
#        work and wants the gate to say so when there is not.
#        FRESHNESS_REQUIRE_CURRENT=1 — passed through to check 7 by the environment;
#        makes dated-state staleness a failure instead of a warning.
# Exit:  0 = gate passed, 1 = gate failed

set -u

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BASE="${1:-origin/main}"
overall=0
REQUIRE_SCOPE="${PREPUSH_REQUIRE_SCOPE:-0}"

skill_dirs_from() { grep -oE '^(research|build|optimize|monitor|cross-cutting)/[^/]+' | sort -u; }

# ---------------------------------------------------------------------------
# Per-push scope measurement (R-0222/R-0297) — runs BEFORE the legs.
#
# What is measured here is a git fact (a commit count, a diff line count), never a
# sibling script's prose. Detecting "this leg was vacuous" by grepping its output
# for a phrase would be a check that stops firing the moment someone rewords the
# phrase, i.e. a check that cannot fail. The cost of using git facts is that this
# block encodes a little knowledge of each leg's own scope resolution; each such
# assumption is named below against the line that establishes it, so a drift is
# findable rather than silent.
#
#   check 1 validate-skill.sh       base: "$BASE" (this script's $1) committed diff
#                                   PLUS `git status --porcelain`; unit is the skill
#                                   directory, and a dir without a SKILL.md is skipped
#                                   at ":skip" below, so the scope is dirs WITH one
#   check 4 claims-gate.sh          base: $1 -> @{upstream} -> origin/main -> skip
#                                   sources: committed <base>...HEAD  PLUS the
#                                   staged+worktree diff (its header, "DIFF BASE")
#   check 5 commit-scope-check.sh   base: @{upstream} only (":41-51"), commits only
#   check 6 register-lock.sh        base: @{upstream} only (":330-337"), commits only,
#                                   and silent with no journal (":344-350")
#   check 7 check-freshness.sh      whole-tree, fixed target list OWNED BY THAT SCRIPT.
#                                   Counted by asking it — `--print-targets` prints one
#                                   existing target per line — rather than keeping a
#                                   second copy of the list here, which would drift,
#                                   or grepping its report prose, which would stop
#                                   working the moment someone rewords it
#   check 8 check-trigger-archives  whole-tree; unit is a data row in PIPELINE.md's
#                                   '## Trigger registry'. Counted here with an
#                                   INDEPENDENT, deliberately loose section scan (any
#                                   `|`-leading line, less header and separator): a
#                                   copy of that script's cell parser could drift into
#                                   agreeing with it about nothing
# ---------------------------------------------------------------------------
REGISTER_RE='^(docs/loop/[^/]+\.md|VERSIONS\.md)$'
register_adds() {   # $* = git diff args; prints the added-line count over register files
    local files
    files=$(git -C "$ROOT" diff --name-only "$@" 2>/dev/null | grep -E "$REGISTER_RE" || true)
    [ -n "$files" ] || { echo 0; return; }
    # shellcheck disable=SC2086
    git -C "$ROOT" diff "$@" -- $files 2>/dev/null | grep -c '^+[^+]' || true
}

PUSH_BASE=$(git -C "$ROOT" rev-parse --abbrev-ref --symbolic-full-name '@{upstream}' 2>/dev/null || true)
if [ -n "$PUSH_BASE" ]; then
    OUTGOING=$(git -C "$ROOT" rev-list --count "$PUSH_BASE..HEAD" 2>/dev/null || echo 0)
    CG_BASE="$PUSH_BASE"
else
    OUTGOING=0
    CG_BASE="origin/main"
fi
if git -C "$ROOT" rev-parse --verify --quiet "$CG_BASE" >/dev/null; then
    CG_COMMITTED=$(register_adds "$CG_BASE...HEAD")
else
    CG_COMMITTED=0
fi
CG_WORKTREE=$(register_adds HEAD)
LOCK_JOURNAL="${REGISTER_LOCK_FILE:-$ROOT/.register-locks}"

# --- check 1 scope. Computed here rather than at the leg, so the summary's
# denominator covers it. Before 2026-08-12 this ran below the scope block and an
# empty `touched` produced "no skill directories touched" plus a silent slot in
# "N of 6" — the same unaccounted-green the block was written to expose.
if git -C "$ROOT" rev-parse --verify --quiet "$BASE" >/dev/null; then
    committed=$(git -C "$ROOT" diff --name-only "$BASE"...HEAD 2>/dev/null | skill_dirs_from || true)
    BASE_NOTE=""
else
    BASE_NOTE=" (base ref '$BASE' not found — uncommitted changes only)"
    committed=""
fi
uncommitted=$(git -C "$ROOT" status --porcelain 2>/dev/null | awk '{print $NF}' | skill_dirs_from || true)
touched=$(printf '%s\n%s\n' "$committed" "$uncommitted" | grep . | sort -u || true)
VS_N=0
if [ -n "$touched" ]; then
    while IFS= read -r s; do
        [ -n "$s" ] || continue
        [ -f "$ROOT/$s/SKILL.md" ] && VS_N=$((VS_N + 1))
    done <<< "$touched"
fi

# --- check 7 scope, asked of the script that owns the list (see note above).
FRESH_TARGETS=$(bash "$ROOT/scripts/check-freshness.sh" "$ROOT" --print-targets 2>/dev/null || true)
FRESH_N=$(printf '%s\n' "$FRESH_TARGETS" | grep -c . || true)

# --- check 8 scope, measured independently of that script's own parser.
TRIG_N=$(awk '
    /^## Trigger registry/ { insec = 1; next }
    insec && /^## /        { insec = 0 }
    insec && /^\|/         { if ($0 ~ /^\|[ \t]*-+/) next; n++ }
    END { print (n > 1 ? n - 1 : 0) }' "$ROOT/docs/loop/PIPELINE.md" 2>/dev/null || echo 0)

echo "== scope (checks 4-6 resolve their own base; check 1 uses '$BASE'; 2,3,7,8 whole-tree)"
if [ -n "$PUSH_BASE" ]; then
    echo "   upstream: $PUSH_BASE ($(git -C "$ROOT" rev-parse --short "$PUSH_BASE" 2>/dev/null || echo '?')) | HEAD: $(git -C "$ROOT" rev-parse --short HEAD) | outgoing commits: $OUTGOING"
else
    echo "   upstream: NONE configured | HEAD: $(git -C "$ROOT" rev-parse --short HEAD) | outgoing commits: n/a"
fi
echo "   register added-lines — committed ($CG_BASE...HEAD): $CG_COMMITTED | staged+worktree: $CG_WORKTREE"
echo "   whole-tree units — check 1 skills: $VS_N$BASE_NOTE | check 7 freshness targets: $FRESH_N | check 8 trigger rows: $TRIG_N"

EMPTY_LEGS=""
add_empty() { EMPTY_LEGS="${EMPTY_LEGS}   - $1
"; }
[ "$VS_N" -eq 0 ] && \
    add_empty "check 1 validate-skill: 0 skill directories with a SKILL.md touched vs '$BASE' — no skill was validated"
[ "$((CG_COMMITTED + CG_WORKTREE))" -eq 0 ] && \
    add_empty "check 4 claims-gate: 0 added register lines in either source — no claim was examined"
# Checks 7 and 8 fail closed at zero, so a zero here is reported AND red; the two
# statements are made by different mechanisms on purpose.
[ "$FRESH_N" -eq 0 ] && \
    add_empty "check 7 check-freshness: 0 tracked targets resolved — the leg will also FAIL (it fails closed on an empty scan set)"
[ "$TRIG_N" -eq 0 ] && \
    add_empty "check 8 check-trigger-archives: 0 rows in PIPELINE.md's trigger registry — the leg will also FAIL (zero parsed rows is a FAIL there, not a pass)"
if [ -z "$PUSH_BASE" ]; then
    add_empty "check 5 commit-scope-check: no upstream — the check skips outright"
    add_empty "check 6 register-lock gate-check: no upstream — the check skips outright"
elif [ "$OUTGOING" -eq 0 ]; then
    add_empty "check 5 commit-scope-check: 0 outgoing commits — no commit's declared scope was judged"
    add_empty "check 6 register-lock gate-check: 0 outgoing commits — no commit was attributed"
elif [ ! -s "$LOCK_JOURNAL" ]; then
    add_empty "check 6 register-lock gate-check: no lock journal at ${LOCK_JOURNAL#"$ROOT"/} — nothing was announced, so nothing can collide"
fi
if [ -n "$EMPTY_LEGS" ]; then
    echo "   REDUCED SCOPE — the following leg(s) will evaluate NOTHING:"
    printf '%s' "$EMPTY_LEGS"
else
    echo "   full scope: every per-push leg has something to evaluate"
fi

# $touched / $VS_N were resolved in the scope block above; do not recompute them here
# or the number the summary counted and the number the leg runs could diverge.
[ -n "$BASE_NOTE" ] && echo "note: base ref '$BASE' not found — checking uncommitted changes only"

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

echo '== check-template-fences (finding #80: truncated markdown-labelled template fences)'
# Run from $ROOT: unlike its shell siblings the detector does not cd itself, and its
# no-argument corpus is a CWD-relative glob — invoked from anywhere else it would scan
# the wrong tree, or nothing and exit 2. Invoked via python3 explicitly; the file
# carries no shebang, so ./scripts/check-template-fences.py is NOT an equivalent call.
# Exit 1 = a truncated template found, exit 2 = fail-closed (unreadable target, or an
# empty scan set — R-0222: scanning zero files is never a pass). Both fail this gate.
( cd "$ROOT" && python3 scripts/check-template-fences.py ) || overall=1

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
# Scope decision: same per-push @{upstream} scope as checks 4 and 5, for the
# same reason — the question is about THIS push's new commits, and the
# .register-locks journal is gitignored session state that can say nothing about
# history pushed before it existed. Second scope decision, specific to this
# check: its unit is the paths writers actually announced, not a hardcoded
# register list. With no journal (or none covering an outgoing commit) it has
# nothing to assert and passes, so a solo session pays zero friction; it only
# speaks when two workstreams overlapped on one file.
bash "$ROOT/scripts/register-lock.sh" gate-check || overall=1

echo "== check-freshness (F5 dated-state staleness)"
# Wired 2026-08-12. Scope decision: whole-tree and base-independent, like checks 2
# and 3 — a tracked register is stale or not regardless of who is pushing, and the
# target list is a property of the repo, not of the diff. FAILURE here means an
# INSTRUMENT fault (missing target, undatable file, unparseable date, empty scan
# set), never staleness on its own; the argument for that split, and for why a
# calendar-driven hard fail would push people to fake review dates, is in the
# script's header. FRESHNESS_REQUIRE_CURRENT=1 in the environment flips staleness
# to a failure and is passed through untouched.
bash "$ROOT/scripts/check-freshness.sh" "$ROOT" || overall=1

echo "== check-trigger-archives (F10: durable trigger rows -> archived prompt files)"
# Wired 2026-08-12. Whole-tree for the same reason as check 3: the defect is a
# property of the registry as it now stands, not of who last touched it — the F10
# instance shipped in a wave whose subject line named no trigger at all. Zero parsed
# rows is a FAIL there, so a format drift that hides the table cannot pass this leg.
bash "$ROOT/scripts/check-trigger-archives.sh" "$ROOT" || overall=1

echo ""
if [ "$overall" -ne 0 ]; then
    echo "PRE-PUSH GATE: FAILED — fix the FAILs above before pushing."
    exit 1
fi
N_CHECKS=8
if [ -n "$EMPTY_LEGS" ]; then
    n_empty=$(printf '%s' "$EMPTY_LEGS" | grep -c '^   - ' || true)
    echo "PRE-PUSH GATE: PASSED WITH REDUCED SCOPE — $n_empty of $N_CHECKS checks evaluated an EMPTY scope:"
    printf '%s' "$EMPTY_LEGS"
    echo "This is NOT an ${N_CHECKS}-check green. Quote it as \"$((N_CHECKS - n_empty)) of $N_CHECKS checks evaluated, all passed\"."
    if [ "$REQUIRE_SCOPE" = "1" ]; then
        echo "PREPUSH_REQUIRE_SCOPE=1 — a reduced scope is a failure in this mode."
        exit 1
    fi
    exit 0
fi
echo "PRE-PUSH GATE: PASSED — all $N_CHECKS checks evaluated a non-empty scope and passed."
exit 0
