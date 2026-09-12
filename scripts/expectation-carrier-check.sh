#!/usr/bin/env bash
# expectation-carrier-check.sh — find eval expectations that grade a rule the skill never states.
#
# WHY THIS EXISTS (ledger F13-r2 / queue #29):
# An eval expectation is a carrier for whoever GRADES, not for whoever WRITES. When a rule
# lives only in evals.json, the skill fails a test whose rule it was never told. Three
# separate blind Mode B runs hit this in one day:
#   - technical-seo-checker: expectations e1.5/e3.4 graded "paste-ready ... no bracketed
#     placeholders"; `grep -i "paste-ready"` over the skill returned NOTHING. The phrase
#     existed only in the suite.
#   - entity-optimizer: its suite graded fabrication while the skill carried no
#     no-fabrication guidance at all. It scored 62.1%, the library's floor.
#   - domain-authority-auditor: the suite graded derived-figure arithmetic the skill never
#     described how to perform.
# Each was found by hand, by one reviewer who thought to grep. This does it for every suite.
#
# METHOD — deliberately narrow, to stay useful rather than noisy:
# Expectations state demands two ways. Prose ("the report should be well organised") is
# unmatchable by any script and is ignored here. But a demand for SPECIFIC vocabulary is
# almost always written as a quoted or backticked phrase inside the expectation — and that
# is exactly the shape that turns into an uncarried rule. So: extract every "double-quoted"
# and `backticked` phrase from each expectation, then grep the skill's own text for it.
# A phrase the suite demands and the skill never mentions is a CANDIDATE, not a defect —
# see the false-positive classes below.
#
# WHAT A HIT MEANS. Three readings, and only a human can pick:
#   1. A genuine uncarried rule -> state it in the skill, where the executor meets it.
#   2. A fixture value or client-supplied string the deliverable must echo (a phone number,
#      a URL, a Greek page title). Correctly absent from the skill. Most common FP.
#   3. Deliberately-absent vocabulary — the suite testing that the skill does NOT say a
#      thing, or naming a competitor/anti-pattern. Correctly absent.
#
# USAGE
#   scripts/expectation-carrier-check.sh              # all skills with an evals/ suite
#   scripts/expectation-carrier-check.sh <skill-path> # one skill
#   MIN_WORDS=2 scripts/expectation-carrier-check.sh  # only multi-word phrases (default 1)
#
# MEASURED COVERAGE — read this before trusting a "clean" line (ledger F15's rule: a guard
# ships with a probe against constructed or known instances, and its hit rate is recorded).
# Probed against the two documented instances of the class:
#   CAUGHT  technical-seo-checker at df560ae — "paste-ready" appeared 4x in evals.json and
#           0x in the skill's text. Exactly the shape this tool is built for.
#   MISSED  entity-optimizer — its suite graded fabrication while the skill carried NO
#           no-fabrication guidance at all, and it scored 62.1%, the library's floor. This
#           tool reports it CLEAN, and always will: the expectation demanded a BEHAVIOUR, not
#           a phrase, so there is no quoted string to grep. 1 of 2 known instances.
#   THIRD HOLE, 2026-08-10 — the phrase-length cap. It was {3,60}; the anchor that founded
#           F9 recurrence 2 is 87 characters, so the tool missed all ten instances of the very
#           class it was extended to catch, twice over. Raised to {3,140}. Diagnosed precisely:
#           a reviewing agent attributed the miss to parentheses with inner quotes; the real
#           cause was length alone, which is why the fix is a number and not a regex rewrite.
#   HOLE FOUND BY USE, 2026-08-10 — and closed: the extractor read only "double" and
#           `backtick` quotes, while this repo's suites quote in 'single' quotes as house
#           style. Three stale anchors in keyword-research went unseen for that reason.
#           Single quotes are now extracted, word-boundary guarded so apostrophes inside
#           words do not match. A guard's own coverage is itself a measured quantity.
#   MISSED, AND WORSE THAN MISSED — 2026-08-17, monitor/backlink-analyzer. THIRD known
#           instance; coverage is therefore 1 of 3, not 1 of 2. This one is not a hole to
#           close. It is the shape of the question this tool asks, and it is why no version
#           of this tool will ever see the class:
#
#             link-quality-rubric.md §4 stated the rule — the unnecessary-disavow-can-hurt-
#             rankings warning "ships inside the recommendation itself ... every time a
#             disavow is proposed". Fourteen lines below it, the disavow-file template fence
#             carried a filename, a date and a reason, and no warning. A blind run measured
#             the consequence: the two deliverables that only RECOMMENDED a disavow
#             reproduced the warning verbatim; the one that actually PRODUCED a file carried
#             no ranking-harm warning anywhere in it.
#
#           Measured against the corpus as it stood with the defect live (fba166c^, suite
#           byte-identical before and after the fix, so this tool's input never changed):
#             'unnecessary disavow can hurt' -> present    'inside the recommendation itself' -> present
#             'hurt your rankings'           -> present    'two weeks'                        -> present
#           9 disavow-related quoted phrases tested, 4 reported uncarried — and not one of
#           the four was the missing rule. So the tool did not merely fail to see this. It
#           scored the rule CARRIED, correctly, by its own question. The question it asks is
#           "does this phrase appear ANYWHERE in the skill's text?" It never asks "is the rule
#           IMPLEMENTED in the artefact the rule governs?" A rule stated in prose and absent
#           from the template that prose governs is, to this tool, indistinguishable from a
#           rule that is honoured. That is the second shape of uncarried behaviour, and it is
#           the more dangerous one, because the first shape at least reports nothing while
#           this one contributes to a clean line.
#
#   EXTENSION ATTEMPTED AND REJECTED ON ITS OWN NUMBERS, 2026-08-17. The obvious mechanical
#           catch was tried before this note was written: flag a fenced block in a
#           comment-capable format, carrying NO comment line, sitting under prose with a
#           warning word nearby. Measured over the 514 fenced blocks in skill text and shared
#           references (evals excluded): 310 comment-capable, 248 of those comment-free, 11
#           surviving the warning-word filter. All 11 hand-checked: 11 false positives, 0 true
#           — ASCII flowcharts, canonical robots.txt examples, a deliberately-broken JSON
#           sample, one-line invocation snippets, and 2 that were the fence parser mis-reading
#           bodies inside a ````markdown wrapper, which is precisely the structure this class
#           lives in. Then the decisive test: run it against the known instance. The defective
#           §4 fence contained SIX comment lines. The heuristic would have scored it clean.
#           Precision 0/11, recall 0/1. It is not a check, it is a noise generator that also
#           misses what it was built for, so it was not written. Do not rebuild it without
#           beating those numbers.
# So: a clean line here means "no uncarried VOCABULARY was found". It says nothing about an
# uncarried behaviour, in either of its two shapes — the rule with no quotable phrase
# (entity-optimizer) or the rule quoted in prose and unimplemented in the artefact it governs
# (backlink-analyzer). Both need a human reading the suite beside the skill, and the second
# needs that human to read the FENCE, not the prose above it. Reporting this as "the class is
# closed" would be F15 again with a new instrument.
#
# ADVISORY ONLY. Never wired into pre-push-gate.sh: its hits need judgement, and a gate that
# fails on candidates trains people to ignore it.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-}"
MIN_WORDS="${MIN_WORDS:-1}"

python3 - "$ROOT" "$TARGET" "$MIN_WORDS" <<'PY'
import json, re, sys, pathlib

root = pathlib.Path(sys.argv[1]); target = sys.argv[2]; min_words = int(sys.argv[3])
GREEN, RED, YEL, DIM, OFF = "\033[0;32m", "\033[0;31m", "\033[1;33m", "\033[2m", "\033[0m"

suites = sorted(root.glob("*/*/evals/evals.json"))
if target:
    t = (root / target).resolve()
    suites = [s for s in suites if t in s.parents]
    if not suites:
        print(f"no evals/evals.json under {target}"); sys.exit(2)

# Phrases that are demands about the WORLD, not about the skill's vocabulary. Matching these
# against skill text produces noise in every suite, so they never become candidates.
STOP = re.compile(r'^(?:[0-9\W]+|https?://.*|[A-Za-z]:\\.*)$')

total_hits = 0
print("expectation-carrier-check: eval phrases the skill never states (F13-r2 / #29)")
print("=" * 78)

for suite in suites:
    skill_dir = suite.parent.parent
    rel = skill_dir.relative_to(root)
    try:
        data = json.load(open(suite, encoding="utf-8"))
    except Exception as e:
        print(f"{RED}UNREADABLE{OFF} {suite.relative_to(root)}: {e}"); continue

    # The skill's own text: SKILL.md + everything under references/. NOT evals/.
    # The skill's own text PLUS the shared references skills legitimately cite: the repo-root
    # frameworks (core-eeat-benchmark, cite-domain-rating) and the anti-slop ruleset, which
    # lives under seo-content-writer but is cited library-wide. Without these, a suite quoting
    # a shared rule (e.g. anti-slop family 1's pattern) reports as uncarried when it is
    # carried, one directory over.
    shared = [root / "build/seo-content-writer/references/anti-slop-ruleset.md",
              *sorted((root / "references").glob("**/*.md"))]
    corpus = []
    for p in [skill_dir / "SKILL.md", *sorted((skill_dir / "references").glob("**/*")), *shared]:
        if p.is_file():
            try: corpus.append(p.read_text(encoding="utf-8").lower())
            except Exception: pass
    # Strip markdown emphasis and backticks before comparing. A rule written as
    # "Decide access **per role**, never per vendor name alone" does not literally contain
    # the phrase an expectation quotes without the asterisks — that produced a false
    # "uncarried rule" for technical-seo-checker on 2026-08-10. Normalise both sides.
    # Strip markdown emphasis AND collapse whitespace. The collapse closes a FOURTH
    # false-positive hole, found 2026-08-17 and measured: a quoted phrase that WRAPS a line in
    # the skill's source could never match, because the corpus is joined with newlines intact
    # while the expectation quotes it as one line. Both multi-line quotes in the content-gap
    # lane's new expectations hit it — `**A proxy with` / `no floor is not a filter**` at
    # gap-analysis-frameworks.md:367-368, and the worked Quick-Win string wrapped across
    # analysis-templates.md:434-435 — and both were reported as uncarried rules that are in
    # fact carried verbatim. Measured effect on that suite: 11 candidates -> 9, both removals
    # confirmed false positives by hand. The three holes already in the footer (length cap,
    # quote style, behaviour-blindness) are unaffected; this is a fourth, now closed.
    def norm(x): return re.sub(r"\s+", " ", re.sub(r"[*_`]", "", x)).strip()
    blob = norm("\n".join(corpus))
    if not blob:
        print(f"{RED}NO SKILL TEXT{OFF} {rel}"); continue

    # Fixture text is a legitimate source for echoed strings (FP class 2) — collect it so we
    # can label those hits instead of reporting them as uncarried rules.
    fixtures = []
    for p in sorted((skill_dir / "evals" / "files").glob("**/*")):
        if p.is_file():
            try: fixtures.append(p.read_text(encoding="utf-8").lower())
            except Exception: pass
    fixblob = "\n".join(fixtures)

    misses = []
    for ev in data.get("evals", []):
        for exp in ev.get("expectations", []):
            text = exp if isinstance(exp, str) else (exp.get("text") or "")
            # Single quotes are included because this repo's suites use them as house style.
            # Omitting them was a measured coverage hole: three stale anchors in
            # keyword-research (e1.6, e3.1, e4.4) quoting an Output Validation line that
            # ceased to exist at df560ae were invisible to this check until 2026-08-10.
            # Apostrophes inside words ("don't") are excluded by requiring the opening quote
            # to follow a non-word character and the closing quote to precede one.
            for phrase in re.findall(r'"([^"]{3,140})"|`([^`]{3,140})`|(?<![\w])\'([^\']{3,140})\'(?![\w])', text):
                ph = (phrase[0] or phrase[1] or phrase[2]).strip()
                if not ph or STOP.match(ph): continue
                if len(ph.split()) < min_words: continue
                low = ph.lower()
                if norm(low) in blob: continue
                where = "in fixture" if norm(low) in norm(fixblob) else "NOWHERE"
                misses.append((ev.get("id"), ph, where))

    if not misses:
        print(f"{GREEN}  clean{OFF}  {rel}  {DIM}(every quoted expectation phrase appears in the skill's own text){OFF}")
        continue

    uncarried = [m for m in misses if m[2] == "NOWHERE"]
    echoed = len(misses) - len(uncarried)
    total_hits += len(uncarried)
    print(f"{YEL}  {len(uncarried):>3} candidate(s){OFF}  {rel}" + (f"  {DIM}(+{echoed} fixture-echo, not reported){OFF}" if echoed else ""))
    seen = set()
    for eid, ph, _ in uncarried:
        if ph in seen: continue
        seen.add(ph)
        print(f"         e{eid}: {ph!r}")

print("=" * 78)
print(f"{total_hits} candidate phrase(s) demanded by a suite and absent from its skill's own text.")
print(f"{DIM}Candidates, not defects. Each is one of: an uncarried rule (fix the skill), a value the")
print(f"deliverable echoes from somewhere other than a fixture, or vocabulary deliberately absent.{OFF}")
print(f"{YEL}A 'clean' line means no uncarried VOCABULARY was found — not that the skill states every")
print(f"rule its suite grades.{OFF} This check asks ONE question: does the phrase appear ANYWHERE in")
print(f"the skill's text? It never asks whether the rule is IMPLEMENTED where it has to act. So it is")
print(f"blind to uncarried BEHAVIOUR, in both measured shapes — coverage 1 of 3 known instances:")
print(f"  {YEL}no quotable phrase{OFF} — entity-optimizer: the suite graded fabrication, the skill said")
print(f"    nothing about it, it scored 62.1%. Reports clean here, and always will.")
print(f"  {YEL}phrase present, rule unimplemented{OFF} — backlink-analyzer at fba166c^: the rubric said the")
print(f"    disavow warning 'ships inside the recommendation itself'; the disavow-file template")
print(f"    fourteen lines below carried a filename, a date and a reason. Every phrase naming the")
print(f"    rule was present, so this tool scored it CARRIED. A blind run found the file shipped bare.")
print(f"The second shape does not merely evade this check — it contributes to a clean line. Read the")
print(f"suite beside the skill, and where a skill produces an artefact read the FENCE, not the prose")
print(f"above it: a model copies the fence, not the heading above it.")
sys.exit(0)
PY
