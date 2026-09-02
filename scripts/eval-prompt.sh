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
#   scripts/eval-prompt.sh --selftest                # prove both guarantees below still hold
#
# <eval-id> accepts BOTH the printed form and the bare form: `e1` and `1` are the same eval.
# `--grade` may sit in either argument position.
#
# THE ID FORMS, AND WHY BOTH ARE ACCEPTED (fixed 2026-08-17). `--ids` printed `e1`, and the
# lookup compared against the bare integer, so the listing's own output could not be pasted
# back into the tool that produced it: `eval-prompt.sh <skill> e1` exited 2 with "no eval with
# id e1". THREE separate blind agents hit it on 2026-08-17 and each recorded it independently
# in its grader record — monitor/alert-manager ("reproduced twice ... a trap for a blind
# executor working under a no-browse rule, since the obvious next command errors"),
# monitor/performance-reporter, monitor/rank-tracker. One of the three concluded it was "not a
# script defect - other suites use eN ids". Measured: no suite does. All 20 suites and both
# fixtures carry bare integer ids, so the `e` prefix existed only in this script's own output.
# The lookup now normalises both sides, which makes the listing pasteable and leaves every
# working invocation working.
#
# The `--grade` mode exists so the grader has one command too, and so that the two roles are
# visibly different calls in a transcript. A run where the executor's transcript contains a
# `--grade` call is not a blind run, and that is now checkable after the fact.
#
# NOT wired into any gate: it serves content, it judges nothing. `--selftest` is likewise
# unwired, for two reasons and not one: the same "judges nothing" posture, and cost — it takes
# 12s against a whole gate that takes 2s, and a gate 7x slower is a gate people start skipping.
# Run it by hand after touching this file.
#
# WHAT `--selftest` ASSERTS, and that it has been watched failing (F15). Two legs over all 20
# live suites, 100 evals:
#   1. every id `--ids` prints is accepted by the lookup that produced it, in BOTH forms
#      (200 assertions). This is the 2026-08-17 defect. It had no test, which is why it shipped.
#   2. the blind path's output contains nothing but the header, the prompt verbatim, the
#      fixture paths and fixed footer text — a line WHITELIST, so any other line fails whatever
#      it holds. Not a fragment search over expectation words: the first draft was, and it
#      raised 95 false alarms on a clean tree because "deliverable" and "expectations" are
#      words in this script's own footer.
# Both legs fault-injected on 2026-08-17 and both fired, each without disturbing the other:
#   plant a bad `--ids` prefix -> 200 id failures, blindness still 100/100 clean
#   print `expectations` on the blind path -> 100 blindness failures, ids still 200/200
# Clean tree: 200/200 and 100/100, zero false alarms. The blindness leg had to be fixed to get
# there — see the pipe note below, which fault injection is the only reason anyone knows about.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

usage() {
    cat >&2 <<'USAGE'
usage: scripts/eval-prompt.sh <skill-dir> <eval-id|--ids> [--grade]
       scripts/eval-prompt.sh --selftest

  <eval-id>   either form: `e1` (as --ids prints it) or `1` (as evals.json stores it)
  --ids       list this suite's eval ids and the first sentence of each prompt
  --grade     ALSO print expectations + expected_output. For the GRADER, never the executor.
              Without it, those two fields are removed from the record before anything prints.
USAGE
    exit 2
}

if [ "${1:-}" = "--selftest" ]; then
    # F15 discipline: a guarantee nobody has watched fail is not evidence. Two assertions,
    # over every live suite: (1) every id `--ids` prints is accepted by the lookup that
    # produced it — the defect fixed on 2026-08-17, which had no test and so shipped;
    # (2) no expectation string reaches stdout on the non-`--grade` path.
    fails=0; suites=0; ids_ok=0; blind_ok=0
    # The blind output goes to a FILE, and the file's path is passed as argv. It must not go
    # through a pipe: `python3 - ... <<'PY'` takes its program from the heredoc, so the heredoc
    # owns stdin and a piped-in stdout is silently discarded. Written that way first, this leg
    # counted 0 leaks for every eval because it was reading nothing, and fault injection is the
    # only reason that is known — a leak was planted, the leg reported 100/100 clean, and the
    # test was the thing at fault. That is the exact failure this whole file exists to prevent,
    # reproduced inside its own test. Do not reintroduce the pipe.
    capture="$(mktemp)"
    trap 'rm -f "$capture"' EXIT
    while IFS= read -r suite; do
        skill="${suite#"$ROOT"/}"; skill="${skill%/evals/evals.json}"
        suites=$((suites + 1))
        while IFS= read -r pid; do
            for form in "$pid" "${pid#e}"; do
                if bash "${BASH_SOURCE[0]}" "$skill" "$form" >/dev/null 2>&1; then
                    ids_ok=$((ids_ok + 1))
                else
                    echo "SELFTEST FAIL — $skill: --ids printed '$pid' but form '$form' is rejected"
                    fails=$((fails + 1))
                fi
            done
            bash "${BASH_SOURCE[0]}" "$skill" "$pid" >"$capture" 2>/dev/null
            leaked=$(python3 - "$suite" "$pid" "$capture" "$skill" <<'PY'
import json, sys
# WHITELIST, not a fragment search. The blind path's output is fully determined: a header,
# the prompt verbatim, the fixture paths, and a fixed footer. So every line of it must be one
# of those four things, and ANY other line is a leak — whatever it contains. Written first as
# a fragment search over expectation tokens, it produced 95 false alarms on a clean tree,
# because "deliverable" and "expectations" are words in this script's OWN footer. A signature
# that fires on the thing being tested is not a signature.
d = json.load(open(sys.argv[1], encoding="utf-8"))
want = str(sys.argv[2]).lstrip("eE")
out = open(sys.argv[3], encoding="utf-8").read()
skill = sys.argv[4]
FIXED = {"",
         "--- fixtures (read these; they are the data set) ---",
         "--- fixtures: none. Any data must come from the prompt itself. ---",
         "--- expectations WITHHELD (blind execution) ---",
         "Write the deliverable the prompt asks for, to the standard the skill itself states.",
         "Do not guess what is being graded; that is the point of the exercise."}
leaks = []
for ev in d.get("evals", []):
    if str(ev.get("id")) != want:
        continue
    ok = set(FIXED)
    ok.add(f"=== {skill} · eval {ev.get('id')} ===")
    ok |= set(str(ev.get("prompt", "")).split("\n"))
    ok |= {f"  {skill}/{f}" for f in (ev.get("files") or [])}
    leaks = [l for l in out.split("\n") if l not in ok]
print(len(leaks))
for l in leaks[:3]:
    print("      unexpected line: " + l[:110], file=sys.stderr)
PY
            )
            if [ "${leaked:-1}" -eq 0 ]; then
                blind_ok=$((blind_ok + 1))
            else
                echo "SELFTEST FAIL — $skill $pid: $leaked line(s) on stdout that are neither the prompt, a fixture path, nor fixed footer text"
                fails=$((fails + 1))
            fi
        done < <(bash "${BASH_SOURCE[0]}" "$skill" --ids 2>/dev/null | sed -n 's/^  \(e[0-9][0-9]*\)  .*/\1/p')
    done < <(find "$ROOT" -path "$ROOT/.git" -prune -o -path "$ROOT/scripts" -prune -o -name evals.json -print | sort)
    echo ""
    echo "  suites scanned: $suites"
    echo "  id round-trip:  $ids_ok accepted (each printed id tried in both the eN and bare form)"
    echo "  blindness:      $blind_ok eval(s) whose blind output is ONLY prompt + fixture paths + fixed footer"
    [ "$fails" -eq 0 ] && { echo "SELFTEST PASS"; exit 0; }
    echo "SELFTEST FAILED — $fails assertion(s)"; exit 1
fi

SKILL="${1:-}"
[ -n "$SKILL" ] || usage
shift

ARG=""; MODE=""
for a in "$@"; do
    case "$a" in
        --grade) MODE="--grade" ;;
        --ids)   ARG="--ids" ;;
        --help|-h) usage ;;
        -*)      echo "unknown flag: $a" >&2; usage ;;
        *)       [ -n "$ARG" ] || ARG="$a" ;;
    esac
done
[ -n "$ARG" ] || usage

SUITE="$ROOT/$SKILL/evals/evals.json"
[ -f "$SUITE" ] || { echo "no evals.json under $SKILL" >&2; exit 2; }

python3 - "$SUITE" "$ARG" "$MODE" "$SKILL" <<'PY'
import json, re, sys

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
    print()
    print("Ask for one by id, in either form — these are the same eval:")
    first = evals[0].get("id") if evals else 1
    print(f"  scripts/eval-prompt.sh {skill} e{first}       scripts/eval-prompt.sh {skill} {first}")
    print("Expectations are withheld unless you add --grade, which is the grader's call.")
    sys.exit(0)

# Normalise BOTH sides, so `e1`, `E1` and `1` all reach the eval stored as 1 — and so a suite
# that one day stores its ids as "e1" keeps working too. Symmetry is the point: the listing and
# the lookup now run the same function over the same value.
def key(x):
    s = str(x).strip()
    m = re.fullmatch(r'[eE]?0*([0-9]+)', s)
    return m.group(1) if m else s.lower()

match = [e for e in evals if key(e.get("id")) == key(arg)]
if not match:
    avail = ", ".join(f"e{e.get('id')}" for e in evals)
    msg = [f"no eval with id {arg!r} in {skill}",
           f"  available: {avail}   (the bare form — {', '.join(str(e.get('id')) for e in evals)} — works too)"]
    dotted = re.fullmatch(r'[eE]?([0-9]+)\.([0-9]+)', str(arg).strip())
    if dotted:
        msg.append(f"  {arg!r} is EXPECTATION notation: expectation {dotted.group(2)} of eval {dotted.group(1)}.")
        msg.append(f"  Ask for the eval itself: e{dotted.group(1)}. Expectations print only under --grade.")
    print("\n".join(msg), file=sys.stderr); sys.exit(2)
e = dict(match[0])

if mode != "--grade":
    # The header claims `expectations` and `expected_output` are "dropped before anything is
    # printed". Make that structurally true rather than a property of which keys the print
    # statements below happen to name: on the blind path the two fields do not exist on the
    # record at all, so a future edit that prints the record wholesale still cannot leak them.
    e.pop("expectations", None)
    e.pop("expected_output", None)

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
