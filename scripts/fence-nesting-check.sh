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
#   bash scripts/fence-nesting-check.sh              # whole repo — GATED (pre-push-gate.sh)
#   bash scripts/fence-nesting-check.sh PATH...      # named files or directories
#   bash scripts/fence-nesting-check.sh --bare-inner # ADVISORY: the ambiguous bare-inner class
#   bash scripts/fence-nesting-check.sh --labels     # ADVISORY: in-fence label closed-list check
#   bash scripts/fence-nesting-check.sh --probe      # fault-injection: prove it still fires
#
# Only the default scan is wired into the gate. `--bare-inner` and `--labels` are advisory by
# design (see the note above each function), so a finding there never blocks a push.

set -uo pipefail
cd "$(dirname "$0")/.." || exit 2

# ── default scan ─────────────────────────────────────────────────────────────────────────────
# Two mechanisms, both unambiguous, both FAIL-grade: a TAGGED inner fence that is not shorter
# than its container (so it closes the container instead of nesting), and a fence never closed
# before EOF. It cannot see the third mechanism — a BARE inner fence — because that one is
# genuinely ambiguous and belongs in `--bare-inner`, where the finding can name both readings.
#
# CORRECTED 2026-08-17. The walk previously ended `elif stack: stack.pop()`, which popped the
# container for ANY bare fence, including one SHORTER than the container — i.e. for the
# ````markdown / ```inner form that is this repo's established correct way to nest. The walk
# therefore lost the container at the first correctly-nested inner fence and read the rest of
# the file at top level, where a later defect would be modelled against the wrong depth. A bare
# fence shorter than the open container is CONTENT under CommonMark 4.5 and is now treated as
# content. Measured over all 247 markdown files: 0 problems before the correction, 0 after —
# the corpus had no case where the mis-modelling changed a verdict, so this is a latent hole
# closed, not a finding gained.
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
        elif not stack:
            stack.append((i, ticks, info))
        # else: a BARE fence SHORTER than the open container. Content under CommonMark — the
        # correct ````markdown / ```inner nesting form. Not a close, not an open. See --bare-inner.
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

# ── --bare-inner ─────────────────────────────────────────────────────────────────────────────
# THE HOLE THIS CLOSES (found by a blind grader, 2026-08-17 — F15's signature for the third
# recorded time: a guard must not pass by matching nothing). The default scan reported
# "0 with problems" across 247 files while four real defects of this exact class stood inside
# its remit. Its walk treated a bare fence ONLY as a closer, so it could see a TAGGED inner
# fence and was structurally blind to a BARE one — which is the far commoner authoring mistake,
# because a bare fence is what you type when you want a plain preformatted block inside a
# ```markdown template. The original fault injection used a tagged inner fence, which the
# broken walk could see. That is why the hole survived. The canary below is now BARE.
#
# WHY THIS IS ADVISORY AND NOT A RESOLUTION. A bare fence inside a tagged container is genuinely
# ambiguous. It is the correct closer for that container, AND it is what an author types when
# they mean to open a nested block. The script does not guess intent. It reports the site with
# BOTH readings named and what each costs, and an author says which. Do not "fix" this by
# picking a side in code.
#
# THE THREE CONDITIONS, and why each is a condition rather than a tuning knob:
#   1. The container's info string is a prose/markup language (markdown, md, mdx, text, txt).
#      Only inside a document can a nested code block exist. A bare fence inside ```bash,
#      ```json or ```python is unambiguously the closer — those languages have no fence
#      syntax, so reading (a) is not available and there is nothing to ask an author about.
#      Measured: all 3 non-prose containers among the coherent sites (CONNECTORS.md ```json,
#      README.md ```bash, AGENTS.md ```bash) are correct closes. AGENTS.md:190 was the sole
#      false positive before this condition and the sole one it removes.
#   2. The nesting reading BALANCES. Count the run of consecutive bare fences from the closer
#      to the next tagged fence or EOF. Reading (a) needs "this one opens a nested block, a
#      later one closes it, the last one closes the container" — which requires an ODD run of
#      at least 3. An even run means reading (a) would leave the container open to EOF, which
#      is the default scan's second mechanism, not this one. Measured: 307 bare-closes-tagged
#      sites repo-wide, 18 survive this condition.
#   3. The material CommonMark pushes OUT of the container carries markdown BLOCK syntax — an
#      ATX heading, a table row, a blockquote, a list item, or a leading bold/italic/link. A
#      fence with no info string declares "literal text, no language"; markdown block syntax
#      inside one is the author's own evidence that the region belonged inside the ```markdown
#      container. This is the corroboration that separates a real truncation from a document
#      that simply happens to use several standalone bare blocks in a row.
#
# MEASURED, 2026-08-17, over 247 markdown files, BEFORE the four in-scope repairs:
#   307 bare-closes-tagged sites → 18 pass condition 2 → 11 also pass condition 3
#   → 10 after condition 1. All 10 hand-checked: 10 true positives, 0 false positives.
# A first draft used only {heading, table row} for condition 3 and scored 9 — it MISSED
# backlink-analyzer/references/analysis-templates.md:36, whose escaped block carries a bold
# lead-in and no heading. The wider block-syntax class is what recovered it. Precision is
# therefore measured at 10/10 and recall is NOT claimed to be 1: condition 3 is corroboration,
# and a truncation whose escaped material is plain unformatted prose is invisible to it.
#
# AFTER the four in-scope repairs (outer fence widened to four backticks): 10 → 6 sites in
# 5 files. All 6 are true positives left standing because they are outside the repairing lane's
# file scope, not because they are disputed:
#   monitor/backlink-analyzer/references/analysis-templates.md:36        (§1, another lane's file)
#   optimize/internal-linking-optimizer/references/linking-templates.md:29
#   optimize/on-page-seo-auditor/SKILL.md:268
#   optimize/technical-seo-checker/SKILL.md:147
#   research/serp-analysis/references/analysis-templates.md:18 and :338
# THIS IS WHY THE MODE IS NOT GATED. It is not crying wolf — 0 of 10 findings were false. It is
# not gated because the tree does not yet satisfy it, and a leg wired in while six true findings
# stand would block every lane's push. Wire it into pre-push-gate.sh only when this mode exits 0
# on a clean tree; until then a lane that clears one of the six should re-run and re-count here.
bare_inner() {
  python3 - "$@" <<'PY'
import os, re, sys
targets = sys.argv[1:] or ["."]
SKIP = ("/.git", "/node_modules", "/.venv")
FENCE = re.compile(r'^(\s*)(`{3,})(.*)$')
PROSE = {"markdown", "md", "mdx", "text", "txt"}
# markdown BLOCK syntax — see condition 3 above.
MD = re.compile(r'^\s{0,3}(#{1,6}\s|\|.+\||>\s|[-*+]\s+\S|\d+\.\s+\S|\*\*\S|__\S|!?\[[^\]]*\]\()')

def problems(path):
    try:
        lines = open(path, encoding="utf-8", errors="replace").read().split("\n")
    except OSError:
        return []
    fences = []
    for i, l in enumerate(lines, 1):
        m = FENCE.match(l)
        if m:
            fences.append((i, m.group(2), m.group(3).strip()))
    # CommonMark 4.5 walk: a fence opens; only a BARE fence of >= the open length closes it;
    # every other fence line inside an open block is content.
    pairs, open_at = [], None
    for idx, (i, ticks, info) in enumerate(fences):
        if open_at is None:
            open_at = (idx, i, ticks, info)
        elif not info and len(ticks) >= len(open_at[2]):
            pairs.append((open_at, (idx, i, ticks)))
            open_at = None
    probs = []
    for (oidx, oline, oticks, oinfo), (cidx, cline, cticks) in pairs:
        lang = oinfo.split()[0].lower() if oinfo.split() else ""
        if lang not in PROSE:
            continue                                          # condition 1
        run = [cidx]
        j = cidx + 1
        while j < len(fences) and not fences[j][2]:
            run.append(j); j += 1
        if len(run) < 3 or len(run) % 2 == 0:
            continue                                          # condition 2
        ev = []
        for k in range(1, len(run) - 1, 2):                   # the stray untagged blocks
            a, b = fences[run[k]][0], fences[run[k + 1]][0]
            for ln in range(a, b - 1):
                if MD.match(lines[ln]):
                    ev.append((ln + 1, lines[ln].strip()[:56]))
                    break
        if not ev:
            continue                                          # condition 3
        last = fences[run[-1]][0]
        probs.append((cline,
            "bare fence closes the '%s%s' container opened at line %d — AMBIGUOUS, an author "
            "must say which:\n"
            "         (a) a nested block: widen the OUTER fence at line %d to four backticks;\n"
            "         (b) a deliberate closer: the container ends here, lines %d-%d fall out of "
            "it as a paragraph, and line %d opens a stray second block that runs to line %d.\n"
            "         Evidence the author meant (a): markdown block syntax at line %d — %r — "
            "inside an untagged block, which declares 'literal text, no language'."
            % (oticks, oinfo, oline, oline, cline + 1, fences[run[1]][0] - 1,
               fences[run[1]][0], last, ev[0][0], ev[0][1])))
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

bad = sites = 0
for p in sorted(set(files)):
    pr = problems(p)
    if pr:
        bad += 1
        sites += len(pr)
        print("AMBIGUOUS %s" % p)
        for i, msg in pr:
            print("       line %d: %s" % (i, msg))
print("")
print("fence-nesting-check --bare-inner: scanned %d markdown file(s), %d site(s) in %d file(s)"
      % (len(set(files)), sites, bad))
print("ADVISORY — not wired into the gate. Each site names both readings; a human picks one.")
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

if [ "${1:-}" = "--bare-inner" ]; then
  shift
  bare_inner "$@"
  exit $?
fi

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

  # BARE-INNER canaries (the 2026-08-17 blind-grader hole). The default scan is blind to this
  # class by construction, so these are graded against --bare-inner, not against scan.
  # bi-bad.md is the measured defect shape, reduced: a ```markdown container, a BARE inner
  # fence, preformatted content, the inner close, then the rest of the template — which
  # CommonMark turns into a stray untagged block carrying an ATX heading and a table row.
  printf '# bi-bad\n\n```markdown\n# Report\n\n## Score\n\n```\nBreakdown:\n### x  12/15\n```\n\n## Priority Issues\n\n| A | B |\n|---|---|\n| 1 | 2 |\n```\n\n## After\n' > "$tmp/bi-bad.md"
  # Negative control 1 — the same document written the established correct way (outer widened
  # to four backticks). Must NOT be reported, or the check punishes the repair it asks for.
  printf '# bi-ok\n\n````markdown\n# Report\n\n## Score\n\n```\nBreakdown:\n### x  12/15\n```\n\n## Priority Issues\n\n| A | B |\n|---|---|\n| 1 | 2 |\n````\n\n## After\n' > "$tmp/bi-ok.md"
  # Negative control 2 — a tagged block correctly closed, followed by two ordinary standalone
  # bare blocks. Run length is 3 and the container is prose, so only condition 3 keeps this
  # clean. It is the shape of README.md / CONNECTORS.md / memory-management, i.e. the false
  # positive this mode would produce if condition 3 were dropped.
  printf '# bi-plain\n\n```markdown\n# Report\n```\n\nProse here.\n\n```\nrun this command\n```\n\nMore prose.\n\n```\nand this one\n```\n\n## After\n' > "$tmp/bi-plain.md"
  # Negative control 3 — the same defect shape inside a ```bash container. Reading (a) does not
  # exist there (shell has no fence syntax), so condition 1 must keep it clean. This is
  # AGENTS.md:190, the sole false positive condition 1 removes.
  printf '# bi-bash\n\n```bash\ngit clone x\n```\n\nProse.\n\n```\n- OpenClaw: install\n- Other: add\n```\n\n## After\n' > "$tmp/bi-bash.md"
  # Negative control 4 — an EVEN run. Condition 3 would accept this (the standalone block does
  # carry a heading), and only condition 2 keeps it clean: with an even run, reading (a) would
  # leave the container open to EOF, which is the default scan's mechanism and not an ambiguity
  # for an author to settle. This is the one shape that isolates condition 2 from condition 3.
  printf '# bi-even\n\n```markdown\n# Report\n```\n\nProse.\n\n```\n## Heading\n```\n\n```\n```html\n<p>x</p>\n```\n\n## After\n' > "$tmp/bi-even.md"

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
  bare_inner "$tmp/bi-bad.md" >/dev/null 2>&1 \
    && { echo "PROBE FAIL — a BARE inner fence was not caught (the 2026-08-17 blind-grader hole)"; fail=1; } \
    || echo "  probe: bare inner fence caught"
  bare_inner "$tmp/bi-ok.md" >/dev/null 2>&1 \
    && echo "  probe: the four-backtick repair passes (--bare-inner negative control 1)" \
    || { echo "PROBE FAIL — the correct ````markdown repair was reported as ambiguous"; fail=1; }
  bare_inner "$tmp/bi-plain.md" >/dev/null 2>&1 \
    && echo "  probe: standalone bare blocks pass (--bare-inner negative control 2)" \
    || { echo "PROBE FAIL — ordinary standalone bare blocks were reported as ambiguous"; fail=1; }
  bare_inner "$tmp/bi-bash.md" >/dev/null 2>&1 \
    && echo "  probe: bare fence in a non-prose container passes (--bare-inner negative control 3)" \
    || { echo 'PROBE FAIL — a bare fence inside a ```bash container was reported, where reading (a) cannot exist'; fail=1; }
  bare_inner "$tmp/bi-even.md" >/dev/null 2>&1 \
    && echo "  probe: an even run passes (--bare-inner negative control 4)" \
    || { echo "PROBE FAIL — an even run was reported, where the nesting reading does not balance"; fail=1; }
  labels "$tmp/lbl-ok.md" >/dev/null 2>&1 \
    && echo "  probe: an on-list label passes (--labels negative control)" \
    || { echo "PROBE FAIL — the ruled label OPERATOR BLOCK was reported as off-list"; fail=1; }
  labels "$tmp/lbl-hyphen.md" >/dev/null 2>&1 \
    && { echo "PROBE FAIL — a HYPHENATED off-list label was not caught (the 2026-08-17 hole)"; fail=1; } \
    || echo "  probe: hyphenated off-list label caught"

  [ "$fail" -eq 0 ] && { echo "PROBE PASS — 6 negative controls, 4 mechanisms, each fault-injected."; exit 0; }
  echo "PROBE FAILED"; exit 1
fi

scan "$@"
