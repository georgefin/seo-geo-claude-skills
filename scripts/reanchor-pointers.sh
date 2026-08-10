#!/usr/bin/env bash
# reanchor-pointers.sh — refresh anchor-tagged `file:line` pointers in the live registers.
#
# WHY THIS EXISTS (F12 guard, companion to validate-tracking.sh check (g)):
# Check (g) treats the ("token") as authoritative and the line number as a convenience,
# and tells the operator to "grep it to refresh". Every insertion into VERSIONS.md shifts
# every pointer below it, so that refresh came due six times in two days and was done by
# hand each time. Hand-refreshing a line number is exactly the work a machine should do:
# the token says what the pointer means, so the new line number is derivable, not decided.
#
# WHAT IT WILL AND WILL NOT DO — the distinction is the point:
#   - Pointer's span already contains its token  -> untouched (nothing drifted).
#   - Token found on exactly one other line      -> line number rewritten. Safe: the token
#                                                   is the authority and it is unambiguous.
#   - Token found nowhere in the target          -> REFUSED, reported. The pointer's subject
#                                                   was deleted or reworded; only a human
#                                                   knows what it should now point at.
#   - Token found on several lines               -> REFUSED, reported. Picking one would be
#                                                   a guess wearing a script's authority.
# It never edits a target file, only the pointer's digits inside a register.
#
# USAGE
#   scripts/reanchor-pointers.sh            # check only; exit 1 if anything drifted
#   scripts/reanchor-pointers.sh --fix      # rewrite the drifted ones, report refusals
#
# This is a FIXER, not a gate. It is deliberately NOT wired into pre-push-gate.sh: a push
# must not silently rewrite the registers it is validating. Run it, read what it changed,
# then push and let check (g) confirm.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MODE="check"
[ "${1:-}" = "--fix" ] && MODE="fix"

python3 - "$ROOT" "$MODE" <<'PY'
import re, sys, pathlib

root = pathlib.Path(sys.argv[1])
mode = sys.argv[2]
registers = ["SETTLED-RULINGS.md", "GATED-ITEMS.md", "WATCH-ITEMS.md", "PIPELINE.md"]

# Mirrors check (g)'s grammar: `path:start[-end]`, optional whitespace/newline, then ("token…
# The closing paren is deliberately NOT required. Real pointers carry explanatory prose
# inside the parens after the token — ("schema-markup-generator 4.0.1" — anchor-tagged per
# F12; …) — and check (g) reads from the (" opener to the next double quote and stops there.
# Requiring `")` here silently skipped every annotated pointer, which is most of them.
# Nothing past the token's closing quote is consumed, so that prose is preserved verbatim.
PTR = re.compile(
    r'`(?P<path>[A-Za-z0-9_][A-Za-z0-9_./-]*\.[A-Za-z0-9]+):(?P<start>\d+)(?:-(?P<end>\d+))?`'
    r'(?P<gap>[\s]*)\("(?P<token>[^"]*)"'
)

GREEN, RED, YEL, OFF = "\033[0;32m", "\033[0;31m", "\033[1;33m", "\033[0m"
targets = {}
def lines_of(rel):
    if rel not in targets:
        p = root / rel
        targets[rel] = p.read_text(encoding="utf-8").splitlines() if p.is_file() else None
    return targets[rel]

fixed = drifted = refused = intact = 0
notes = []

for reg in registers:
    rp = root / "docs/loop" / reg
    if not rp.is_file():
        continue
    text = rp.read_text(encoding="utf-8")

    def repl(m):
        global fixed, drifted, refused, intact
        rel, tok = m.group("path"), m.group("token")
        start = int(m.group("start"))
        end = int(m.group("end")) if m.group("end") else start
        tl = lines_of(rel)
        if tl is None:
            refused += 1
            notes.append(f"{RED}REFUSED{OFF} {reg} -> `{rel}:{start}` (\"{tok}\") — target file does not exist")
            return m.group(0)
        if not tok:
            refused += 1
            notes.append(f"{RED}REFUSED{OFF} {reg} -> `{rel}:{start}` — empty anchor token; nothing to grep")
            return m.group(0)
        # Already correct?
        if any(tok in ln for ln in tl[start - 1:end]):
            intact += 1
            return m.group(0)
        hits = [i + 1 for i, ln in enumerate(tl) if tok in ln]
        if not hits:
            refused += 1
            notes.append(f"{RED}REFUSED{OFF} {reg} -> `{rel}:{start}` (\"{tok}\") — token appears nowhere in {rel}; "
                         f"its subject was deleted or reworded, so a human decides the new target")
            return m.group(0)
        if len(hits) > 1:
            refused += 1
            notes.append(f"{RED}REFUSED{OFF} {reg} -> `{rel}:{start}` (\"{tok}\") — token is on {len(hits)} lines "
                         f"({', '.join(map(str, hits[:8]))}{'…' if len(hits) > 8 else ''}); ambiguous, so a human picks")
            return m.group(0)
        new_start = hits[0]
        new_span = str(new_start) if end == start else f"{new_start}-{new_start + (end - start)}"
        drifted += 1
        notes.append(f"{YEL}DRIFTED{OFF} {reg} -> `{rel}:{start}{'' if end == start else '-' + str(end)}` "
                     f"(\"{tok}\") — token now at {rel}:{new_start}")
        if mode != "fix":
            return m.group(0)
        fixed += 1
        return f'`{rel}:{new_span}`{m.group("gap")}("{tok}"'

    new_text = PTR.sub(repl, text)
    if mode == "fix" and new_text != text:
        rp.write_text(new_text, encoding="utf-8")

print("reanchor-pointers: anchor-tagged pointer refresh (F12 companion)")
print("==============================================")
for n in notes:
    print("  " + n)
if not notes:
    print(f"  {GREEN}nothing drifted{OFF} — every anchored pointer's span still contains its token")
print("==============================================")
verb = "re-anchored" if mode == "fix" else "would re-anchor"
print(f"intact: {intact} | {verb}: {fixed if mode == 'fix' else drifted} | refused (need a human): {refused}")
if refused:
    print(f"{RED}Refusals are not failures of this script{OFF} — they are pointers whose meaning changed. "
          f"Grep the token yourself and decide what it should point at.")
sys.exit(1 if (refused or (mode != "fix" and drifted)) else 0)
PY
