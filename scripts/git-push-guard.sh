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

[ -n "$cmd" ] || exit 0
printf '%s' "$cmd" | grep -qE '(^|[;&|[:space:]])git[[:space:]]+([^;&|]*[[:space:]])?push([[:space:]]|$)' || exit 0

root="${CLAUDE_PROJECT_DIR:-.}"
gate="$root/scripts/pre-push-gate.sh"
[ -f "$gate" ] || exit 0

if bash "$gate"; then
    exit 0
fi
echo "BLOCKED: pre-push gate failed — run scripts/pre-push-gate.sh, fix the FAILs, then push again." >&2
exit 2
