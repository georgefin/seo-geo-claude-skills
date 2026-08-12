#!/usr/bin/env bash
# git-push-guard.sh — PreToolUse[Bash] hook (wired in .claude/settings.json).
# When the Bash command about to run is a `git push`, run scripts/pre-push-gate.sh
# first and BLOCK the push (exit 2) if validation fails. Repo-checked-in hooks
# apply to cloud sessions (code.claude.com/docs/en/hooks.md, 2026-08-08), so this
# gate travels with every clone.
#
# Fail-open by design when: stdin is not parseable, the command is not a git push,
# or the gate script is absent (older checkout) — the guard must never brick
# unrelated Bash calls. A benign false-positive match only costs one gate run.
#
# THREE of those WERE `exit 0` allow-decisions (tagged FAIL-OPEN [no-command],
# [unrecognized-push], [gate-missing] below) and a FOURTH construct degrades
# silently without being an allow-decision itself (tagged DEGRADED
# [root-fallback]). Every one of them now ANNOUNCES ON STDERR, because a silent
# fail-open is indistinguishable from a pass: the transcript of a guard that
# allowed everything and a guard that checked everything used to look identical.
#
# TWO still allow. [no-command] and [unrecognized-push] stand in front of EVERY
# Bash call, so failing closed there would brick unrelated work.
# [gate-missing] no longer allows — ruled 2026-08-12, it now BLOCKS (exit 2).
# By that line the command has already been identified as a git push, so the
# "don't brick unrelated calls" justification does not reach it; allowing there
# was allowing a push with zero validation, scoped to pushes alone.
#
# NOTE on where the announcements land: a PreToolUse hook that exits 0 is
# non-blocking, so its stderr surfaces in transcript mode rather than in the
# default view. Exit 2 (the BLOCK at the end) is the only path whose stderr is
# fed back into the conversation.
#
# ONE narrowing, called out so it can be overruled with a one-line edit:
# [unrecognized-push] would fire on EVERY Bash call if announced
# unconditionally — `ls`, `cat`, everything — which would bury the other three
# and train readers to ignore the tag. By default it announces only when the
# command mentions "push" yet failed the pattern, i.e. the zone where a missed
# push actually lives. Set GIT_PUSH_GUARD_VERBOSE=1 to announce every
# non-matching command instead.

set -u

payload=$(cat 2>/dev/null || true)
cmd=$(printf '%s' "$payload" | python3 -c '
import json, sys
try:
    d = json.load(sys.stdin)
    print(d.get("tool_input", {}).get("command", ""))
except Exception:
    pass
' 2>/dev/null || true)

# FAIL-OPEN [no-command] — nothing could be read out of the hook payload. The
# sub-cause is reported because the three of them fail very differently: an
# absent python3 disarms this guard for the whole session, a malformed payload is
# a one-off, and an empty payload usually means the hook was invoked by hand.
# Established without touching the parse above, so the extraction path is
# byte-identical to what it always was.
if [ -z "$cmd" ]; then
    if [ -z "$payload" ]; then
        why="no payload arrived on stdin"
    elif ! command -v python3 >/dev/null 2>&1; then
        why="python3 is not on PATH, so the payload could not be parsed AT ALL (this guard is disarmed for every call in this environment)"
    else
        why="the payload yielded no tool_input.command (unparseable JSON, or a tool call that carries no command)"
    fi
    echo "git-push-guard: FAIL-OPEN [no-command] — $why; the Bash call proceeds UNGUARDED." >&2
    exit 0
fi

# FAIL-OPEN [unrecognized-push] — the command did not match the push pattern. For
# `ls` that is the guard correctly not applying; for `gitpush`, an alias, an
# `eval`, or a push inside a script it is a real miss, and the two are
# indistinguishable from here. See the header for why the announcement is
# narrowed by default and how to widen it.
if ! printf '%s' "$cmd" | grep -qE '(^|[;&|[:space:]])git[[:space:]]+([^;&|]*[[:space:]])?push([[:space:]]|$)'; then
    if [ "${GIT_PUSH_GUARD_VERBOSE:-0}" = "1" ] || printf '%s' "$cmd" | grep -qiF 'push'; then
        echo "git-push-guard: FAIL-OPEN [unrecognized-push] — command did not match the git-push pattern, so no gate ran: ${cmd:0:200}" >&2
    fi
    exit 0
fi

# DEGRADED [root-fallback] — CLAUDE_PROJECT_DIR unset means the gate is looked up
# relative to whatever the working directory happens to be. That is not the same
# question as "is there a gate in this repo", and it is the usual way
# [gate-missing] fires on a repo that has one. Same substitution as the original
# `${CLAUDE_PROJECT_DIR:-.}`, now audible.
root="${CLAUDE_PROJECT_DIR:-}"
if [ -z "$root" ]; then
    root="."
    echo "git-push-guard: DEGRADED [root-fallback] — CLAUDE_PROJECT_DIR is unset/empty; resolving the gate against the current directory ($(pwd)) instead of the project root." >&2
fi
gate="$root/scripts/pre-push-gate.sh"

# FAIL-CLOSED [gate-missing] — ruled 2026-08-12. Unlike the two allow-decisions
# above, the command HAS been identified as a git push by this line, so "don't
# brick unrelated Bash calls" does not reach it: blocking here blocks pushes and
# nothing else. Allowing was allowing a push with zero validation, and the
# .githooks/pre-push hook fails closed in the identical situation — a guard that
# allowed what its own git-side counterpart blocks was the inconsistency.
# If this fires on a repo that HAS a gate, read the DEGRADED [root-fallback] line
# above it first: a bad root is the usual cause, not a missing gate.
if [ ! -f "$gate" ]; then
    echo "git-push-guard: FAIL-CLOSED [gate-missing] — recognized a git push but found no gate at '$gate'; BLOCKING rather than letting an unvalidated push through." >&2
    exit 2
fi

if bash "$gate"; then
    exit 0
fi
echo "BLOCKED: pre-push gate failed — run scripts/pre-push-gate.sh, fix the FAILs, then push again." >&2
exit 2
