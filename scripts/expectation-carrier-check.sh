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
#   HOLE FOUND BY USE, 2026-08-10 — and closed: the extractor read only "double" and
#           `backtick` quotes, while this repo's suites quote in 'single' quotes as house
#           style. Three stale anchors in keyword-research went unseen for that reason.
#           Single quotes are now extracted, word-boundary guarded so apostrophes inside
#           words do not match. A guard's own coverage is itself a measured quantity.
# So: a clean line here means "no uncarried VOCABULARY was found". It says nothing about an
# uncarried behaviour, which is the more damaging half of the class and needs a human reading
# the suite beside the skill. Reporting this as "the class is closed" would be F15 again with
# a new instrument.
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
    def norm(x): return re.sub(r"[*_`]", "", x)
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
            for phrase in re.findall(r'"([^"]{3,60})"|`([^`]{3,60})`|(?<![\w])\'([^\']{3,60})\'(?![\w])', text):
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
print(f"rule its suite grades.{OFF} This check greps quoted phrases, so it cannot see an uncarried")
print(f"BEHAVIOUR. entity-optimizer reports clean here and is the worst known instance of the class")
print(f"(suite graded fabrication, skill said nothing about it, 62.1%). Read the suite beside the")
print(f"skill; this tool only removes the phrase-shaped half of that job.")
sys.exit(0)
PY
