#!/usr/bin/env bash
# fence-nesting-check.sh — catch code fences that silently swallow the rest of a file.
#
# WHY THIS FILE EXISTS. Finding 69 recorded one instance: a bare fence inside a ```markdown
# fence ended the outer one early and truncated a template. It was fixed in place, as a typo.
# It was not a typo — it is a class, and on 2026-08-17 a sweep of all 230 markdown files in
# this repository found the same defect standing in **two SKILL.md files**, both of which
# passed `validate-skill.sh` at 15/15, both of which every other gate leg passed:
#
#   build/schema-markup-generator/SKILL.md — 3 sites. The Implementation Guide template was cut
#     at its first inner close; the Output Validation checklist, Validation Checkpoints and
#     Example rendered as literal preformatted text.
#   build/meta-tags-optimizer/SKILL.md — an UNCLOSED fence from line 344 to EOF, swallowing
#     `## Tips for Success`, `## Reference Materials` and `## Related Skills` whole.
#
# Three published sections of a shipped skill rendered as a code block, and nothing noticed,
# because every existing check reads the file as text and this defect only exists in the render.
#
# THE RULE IT ENFORCES (CommonMark 4.5). A fenced block opened with N backticks is closed by a
# line of N-or-more backticks carrying NO info string. Two consequences the authors here kept
# tripping over:
#   · To nest a fence, the OUTER must be LONGER — ````markdown containing ```html. Equal
#     lengths do not nest; the inner line is either swallowed as content or closes the outer.
#   · A line like ```html inside an open block is CONTENT, not a closer. So the outer block
#     runs on to the next BARE fence — which is usually the inner block's closer — and every
#     fence after that is off by one. That is the mechanism behind the unclosed-to-EOF case.
#
# Usage:
#   bash scripts/fence-nesting-check.sh            # whole repo — GATED (pre-push-gate.sh)
#   bash scripts/fence-nesting-check.sh PATH...    # named files or directories
#   bash scripts/fence-nesting-check.sh --labels   # ADVISORY: in-fence label closed-list check
#   bash scripts/fence-nesting-check.sh --probe    # fault-injection: prove it still fires
#
# Only the default scan is wired into the gate. `--labels` is advisory by design (see the note
# above the labels() function), so a finding there never blocks a push.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 2

scan() {
  python3 - "$@" <<'PY'
import os, re, sys
targets = sys.argv[1:] or ["."]
SKIP = ("/.git", "/node_modules", "/.venv")

def problems(path):
    try:
        lines = open(path, encoding="utf-8", errors="replace").read().split("\n")
    except OSError:
        return []
    stack, probs = [], []
    for i, l in enumerate(lines, 1):
        m = re.match(r'^(\s*)(`{3,})(.*)$', l)
        if not m:
            continue
        ticks, info = m.group(2), m.group(3).strip()
        # A bare fence of >= the open length closes the innermost open block.
        if stack and len(ticks) >= len(stack[-1][1]) and not info:
            stack.pop()
            continue
        if info:
            if stack and len(ticks) >= len(stack[-1][1]):
                probs.append((i, "inner fence '%s%s' is not shorter than the outer opened at line %d — "
                                 "it closes that block instead of nesting inside it"
                                 % (ticks, info, stack[-1][0])))
            stack.append((i, ticks, info))
        elif stack:
            stack.pop()
    for (i, t, inf) in stack:
        probs.append((i, "fence '%s%s' is never closed — everything to EOF renders as code" % (t, inf)))
    return probs

files = []
for t in targets:
    if os.path.isfile(t):
        files.append(t)
    else:
        for root, _d, fs in os.walk(t):
            if any(s in root for s in SKIP):
                continue
            files += [os.path.join(root, f) for f in fs if f.endswith(".md")]

bad = 0
for p in sorted(set(files)):
    pr = problems(p)
    if pr:
        bad += 1
        print("FAIL %s" % p)
        for i, msg in pr:
            print("       line %d: %s" % (i, msg))
print("")
print("fence-nesting-check: scanned %d markdown file(s), %d with problems" % (len(set(files)), bad))
sys.exit(1 if bad else 0)
PY
}

# Closed-list check for in-fence labels (finding 112, ruled 2026-08-17). Advisory, not gated:
# it reports a label word outside the ruled three, and only a human can say whether a given
# fence needed a label at all. It exists because the ruling that closed the list is worthless
# without something that can see the list being reopened — which is finding 112's own point.
#
# MEASURED HOLE, FOUND AND CLOSED 2026-08-17. The label pattern's character class was `[A-Z ]`,
# which does not contain a hyphen, so a label whose words are HYPHENATED was invisible to it —
# and a reopened list is most likely to be reopened by exactly that: a fourth spelling built by
# hyphenating onto an approved word. One such label was standing in the tree the whole time:
#   research/competitor-analysis/references/confidence-and-evidence-rules.md:161
#   `<!-- OPERATOR-ADDRESSED FORM — ... -->`  (a fourth spelling of OPERATOR BLOCK)
# Measured over all 217 markdown files this mode scans:
#   shipped `[A-Z ]`  → 115 raw regex matches, 0 label sites reported, 0 files flagged
#   fixed   `[A-Z -]` → 116 raw regex matches, 1 label site reported,  1 file flagged
# The widening is one raw match across the whole corpus. Every capture the shipped pattern made
# is byte-identical under the fixed one (diffed: 0 captures lost, 0 changed, 1 added), so this
# is not a looser net that happens to catch more — it is the same net with the hole sewn up.
# The `^(SKELETON|ILLUSTRATIVE|OPERATOR)\b` guard below is what keeps it that tight: `\b` before
# a hyphen is a word boundary, so a hyphenated variant of an approved word still has to START
# with one of the three to be reported at all, and ordinary hyphenated prose in caps does not.
labels() {
  python3 - "$@" <<'PY'
import os, re, sys
ALLOWED = {"SKELETON", "ILLUSTRATIVE FILL", "OPERATOR BLOCK"}
targets = sys.argv[1:] or ["."]
SKIP = ("/.git", "/node_modules", "/.venv", "/docs/loop")
# A label is an all-caps run opening a comment-style or hash-style in-fence marker.
# The hyphen in the class is load-bearing: without it `OPERATOR-ADDRESSED FORM` reads as the
# allowed bare word `OPERATOR` followed by punctuation the terminator alternation rejects, and
# the whole site is skipped silently. See the measurement in the block above this function.
PAT = re.compile(r'(?:<!--|#|"_)\s*([A-Z][A-Z -]{3,30}?)\s*(?:—|-{2}|:|")')
files = []
for t in targets:
    if os.path.isfile(t): files.append(t)
    else:
        for root, _d, fs in os.walk(t):
            if any(s in root for s in SKIP): continue
            files += [os.path.join(root, f) for f in fs if f.endswith(".md")]
off = {}
for p in sorted(set(files)):
    for i, l in enumerate(open(p, encoding="utf-8", errors="replace"), 1):
        for m in PAT.finditer(l):
            w = m.group(1).strip()
            if w in ALLOWED or w == "OPERATOR":   # "_OPERATOR" is the ruled JSON member form
                continue
            if not re.match(r'^(SKELETON|ILLUSTRATIVE|OPERATOR)\b', w):
                continue                          # not a label at all — ordinary prose in caps
            off.setdefault(w, []).append("%s:%d" % (p, i))
if off:
    print("Label words outside the ruled closed list {SKELETON, ILLUSTRATIVE FILL, OPERATOR BLOCK}:")
    for w, locs in sorted(off.items()):
        print("  %-24s %d site(s): %s" % (w, len(locs), ", ".join(locs[:4])))
else:
    print("All in-fence label words are on the ruled closed list of three.")
print("")
print("scanned %d markdown file(s)" % len(set(files)))
sys.exit(1 if off else 0)
PY
}

if [ "${1:-}" = "--labels" ]; then
  shift
  labels "$@"
  exit $?
fi

if [ "${1:-}" = "--probe" ]; then
  # F15 discipline: a checker that has never been shown failing is not evidence of anything.
  # Each canary reproduces one of the mechanisms measured in the real tree.
  tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT; fail=0

  printf '# ok\n\n````markdown\n## t\n```html\n<p>x</p>\n```\n````\n\n## After\n' > "$tmp/good.md"
  printf '# bad1\n\n```markdown\n## t\n```html\n<p>x</p>\n```\n```\n\n## After\n'  > "$tmp/equal.md"
  printf '# bad2\n\n```markdown\n## t\n\n## Tips\n'                              > "$tmp/unclosed.md"

  # Label canaries. The hyphen hole shipped undetected because --labels had no probe at all:
  # it had only ever been observed printing "All in-fence label words are on the ruled closed
  # list of three", which is exactly what a blind checker prints. These two make the difference
  # between "found nothing" and "can see something" observable.
  printf '# lbl-ok\n\n```\n<!-- OPERATOR BLOCK — for whoever runs the library. -->\nx\n```\n'   > "$tmp/lbl-ok.md"
  printf '# lbl-bad\n\n```\n<!-- OPERATOR-ADDRESSED FORM — a fourth spelling. -->\nx\n```\n'    > "$tmp/lbl-hyphen.md"

  scan "$tmp/good.md" >/dev/null 2>&1 \
    && echo "  probe: clean file passes" \
    || { echo "PROBE FAIL — a correctly nested file was reported as a problem"; fail=1; }
  scan "$tmp/equal.md" >/dev/null 2>&1 \
    && { echo "PROBE FAIL — equal-length nesting was not caught"; fail=1; } \
    || echo "  probe: equal-length nesting caught"
  scan "$tmp/unclosed.md" >/dev/null 2>&1 \
    && { echo "PROBE FAIL — unclosed-to-EOF was not caught"; fail=1; } \
    || echo "  probe: unclosed-to-EOF caught"
  labels "$tmp/lbl-ok.md" >/dev/null 2>&1 \
    && echo "  probe: an on-list label passes (--labels negative control)" \
    || { echo "PROBE FAIL — the ruled label OPERATOR BLOCK was reported as off-list"; fail=1; }
  labels "$tmp/lbl-hyphen.md" >/dev/null 2>&1 \
    && { echo "PROBE FAIL — a HYPHENATED off-list label was not caught (the 2026-08-17 hole)"; fail=1; } \
    || echo "  probe: hyphenated off-list label caught"

  [ "$fail" -eq 0 ] && { echo "PROBE PASS — 2 negative controls, 3 mechanisms, each fault-injected."; exit 0; }
  echo "PROBE FAILED"; exit 1
fi

scan "$@"
