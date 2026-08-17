#!/usr/bin/env bash
# eval-prompt.sh — serve ONE eval's prompt to a blind executor, and nothing else.
#
# WHY THIS EXISTS. Mode B's whole value is that the executor writes the deliverable without
# having seen what it will be graded on. Until now that was a matter of agent discipline: the
# founding baseline records the method as *"I read ONLY that eval's `prompt` (extracted with jq
# so no sibling field was on screen)"*. That is the right method and it is **unverifiable** — a
# reader of the artefact cannot tell a genuinely blind run from one that glanced at the
# expectations, and neither can the executor's own report, which is written after the fact by
# the party with the incentive. An eval suite whose blindness rests on self-report measures
# compliance, not capability.
#
# This makes it mechanical. The executor is given a command, not a file. `expectations` and
# `expected_output` are dropped before anything is printed, so the blind half of the protocol
# holds by construction rather than by intention.
#
#   scripts/eval-prompt.sh <skill-dir> <eval-id>     # prompt + fixture paths ONLY
#   scripts/eval-prompt.sh <skill-dir> --ids         # list eval ids (no content)
#   scripts/eval-prompt.sh <skill-dir> <id> --grade  # prompt + expectations, for the GRADER
#
# The `--grade` mode exists so the grader has one command too, and so that the two roles are
# visibly different calls in a transcript. A run where the executor's transcript contains a
# `--grade` call is not a blind run, and that is now checkable after the fact.
#
# NOT wired into any gate: it serves content, it judges nothing.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="${1:-}"
ARG="${2:-}"

if [ -z "$SKILL" ] || [ -z "$ARG" ]; then
    echo "usage: scripts/eval-prompt.sh <skill-dir> <eval-id|--ids> [--grade]" >&2
    exit 2
fi

SUITE="$ROOT/$SKILL/evals/evals.json"
[ -f "$SUITE" ] || { echo "no evals.json under $SKILL" >&2; exit 2; }

MODE="${3:-}"

python3 - "$SUITE" "$ARG" "$MODE" "$SKILL" <<'PY'
import json, sys

suite, arg, mode, skill = sys.argv[1], sys.argv[2], sys.argv[3], sys.argv[4]
d = json.load(open(suite, encoding="utf-8"))
evals = d.get("evals", [])

if arg == "--ids":
    print(f"suite: {d.get('skill_name', skill)}  ({len(evals)} evals)")
    for e in evals:
        p = str(e.get("prompt", ""))
        # First sentence only — enough to tell the evals apart, not enough to work from.
        head = p.split(".")[0][:90]
        print(f"  e{e.get('id')}  {head}…")
    sys.exit(0)

match = [e for e in evals if str(e.get("id")) == str(arg)]
if not match:
    print(f"no eval with id {arg} in {skill}", file=sys.stderr); sys.exit(2)
e = match[0]

print(f"=== {skill} · eval {e.get('id')} ===")
print()
print(e.get("prompt", ""))
print()
files = e.get("files") or []
if files:
    print("--- fixtures (read these; they are the data set) ---")
    for f in files:
        print(f"  {skill}/{f}")
else:
    print("--- fixtures: none. Any data must come from the prompt itself. ---")

if mode == "--grade":
    print()
    print("=== GRADING CRITERIA — not for the executor ===")
    print()
    exp = e.get("expectations", [])
    for i, x in enumerate(exp, 1):
        t = x if isinstance(x, str) else (x.get("text") or json.dumps(x, ensure_ascii=False))
        print(f"  e{e.get('id')}.{i}  {t}")
    eo = e.get("expected_output")
    if eo:
        print()
        print("--- expected_output (shape guidance, not a rubric) ---")
        print(eo if isinstance(eo, str) else json.dumps(eo, ensure_ascii=False, indent=2))
else:
    print()
    print("--- expectations WITHHELD (blind execution) ---")
    print("Write the deliverable the prompt asks for, to the standard the skill itself states.")
    print("Do not guess what is being graded; that is the point of the exercise.")
PY
