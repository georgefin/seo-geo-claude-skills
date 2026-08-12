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
#           tool cannot see that expectation and never will: it demanded a BEHAVIOUR, not a
#           phrase, so there is no quoted string to grep. 1 of 2 known instances.
#           NOT the same as "the suite reports clean" — it does not, and this line used to
#           say it did. The suite shows candidates for unrelated phrases (23 on 2026-08-12)
#           and that count moves with every edit. What is invisible is the ONE expectation.
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
#   FOURTH HOLE, 2026-08-12 — Greek guillemets « ». The standard Greek quotation mark, in a
#           Greek-first corpus, unread since the tool was written: 86 expectations across 18
#           of the 20 suites quote in them. Closed; measured 912 -> 1101 phrases extracted
#           (+189, 151 unique, 0 lost). Note the pattern across all four holes — every one was
#           the extractor not seeing a quoting convention or length the corpus actually uses,
#           and every one presented as a CLEAN line. See the regex for the detail.
# So: a clean line here means "no uncarried VOCABULARY was found". It says nothing about an
# uncarried behaviour, which is the more damaging half of the class and needs a human reading
# the suite beside the skill. Reporting this as "the class is closed" would be F15 again with
# a new instrument.
#
# EXIT CODES — read this before wiring it anywhere (R-0297: a check that cannot FAIL is not a
# check). Until 2026-08-12 this script had no red path at all: the only non-zero exit was the
# usage error at the target lookup, and every completed run ended `sys.exit(0)` regardless of
# what it found — so its greens meant nothing. Two different things live in here and they get
# different codes, because conflating them is what produced the unconditional 0.
#
#   0  the check RAN and the instrument was working. Candidates may have been printed.
#   1  the check COULD NOT BE TRUSTED. One of:
#        - a suite's evals.json did not parse (UNREADABLE) — the suite was never checked;
#        - a skill has an evals suite but no readable skill text (NO SKILL TEXT) — the
#          comparison corpus is empty, so that skill silently contributes zero candidates
#          and drags the run green. This is the most dangerous shape in the whole script;
#        - zero suites were discovered on a full run — wrong cwd, a repo restructure, or a
#          rename of evals.json. Scanning nothing and reporting "0 candidates" is the
#          `Files scanned: 0` false-PASS;
#        - the extractor produced zero phrases across a full run that had expectations to
#          read — the regex is dead and every suite would report clean;
#        - FAIL_ON_CANDIDATES=1 was set and candidates were found (opt-in, off by default).
#   2  usage error: the path argument matched no evals/evals.json.
#
# CANDIDATES STAY ADVISORY, and that is a design decision this file already argued for, not a
# softening. A candidate is explicitly one of three things (see WHAT A HIT MEANS above) and
# only two of them are defects; the tool cannot tell which. Failing on them would be asserting
# a defect the tool did not establish. So the default remains: candidates print, exit stays 0,
# and `FAIL_ON_CANDIDATES=1` exists for whoever eventually wires this into a gate against a
# corpus they have already driven to zero. What DOES go red is the instrument failing — which
# is a fact about the run, not a judgement about a phrase.
#
# Not wired into pre-push-gate.sh. That remains true and remains deliberate for the candidate
# half; the red paths above are what a future wiring would rest on.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGET="${1:-}"
MIN_WORDS="${MIN_WORDS:-1}"

python3 - "$ROOT" "$TARGET" "$MIN_WORDS" <<'PY'
import json, re, sys, pathlib

import os

root = pathlib.Path(sys.argv[1]); target = sys.argv[2]; min_words = int(sys.argv[3])
GREEN, RED, YEL, DIM, OFF = "\033[0;32m", "\033[0;31m", "\033[1;33m", "\033[2m", "\033[0m"
FAIL_ON_CANDIDATES = os.environ.get("FAIL_ON_CANDIDATES", "") == "1"

suites = sorted(root.glob("*/*/evals/evals.json"))
if target:
    t = (root / target).resolve()
    suites = [s for s in suites if t in s.parents]
    if not suites:
        print(f"no evals/evals.json under {target}"); sys.exit(2)
elif not suites:
    # A full run that discovered nothing. Falling through prints the banner and
    # "0 candidate phrase(s)" — a green earned by scanning zero files, which is the same
    # false-PASS shape as a scanner reporting "Files scanned: 0" and calling it clean.
    print(f"{RED}BROKEN{OFF} no */*/evals/evals.json found under {root}.")
    print("Nothing was scanned, so a clean result would be meaningless. Wrong root, a repo")
    print("restructure, or evals.json renamed. Exit 1 rather than a green over an empty set.")
    sys.exit(1)

# Phrases that are demands about the WORLD, not about the skill's vocabulary. Matching these
# against skill text produces noise in every suite, so they never become candidates.
STOP = re.compile(r'^(?:[0-9\W]+|https?://.*|[A-Za-z]:\\.*)$')

total_hits = 0
# Instrument-health counters. These are what makes a green mean something: they record that
# the check was actually PERFORMED, not merely that it found nothing.
unreadable = []       # suites whose JSON did not parse — never checked at all
no_skill_text = []    # skills with a suite but an empty comparison corpus — silently clean
expectations_read = 0 # how many expectation strings the extractor was handed
phrases_extracted = 0 # how many quoted phrases came back out of them

print("expectation-carrier-check: eval phrases the skill never states (F13-r2 / #29)")
print("=" * 78)

for suite in suites:
    skill_dir = suite.parent.parent
    rel = skill_dir.relative_to(root)
    try:
        data = json.load(open(suite, encoding="utf-8"))
    except Exception as e:
        unreadable.append((str(suite.relative_to(root)), str(e)))
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
        no_skill_text.append(str(rel))
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
            expectations_read += 1
            # Single quotes are included because this repo's suites use them as house style.
            # Omitting them was a measured coverage hole: three stale anchors in
            # keyword-research (e1.6, e3.1, e4.4) quoting an Output Validation line that
            # ceased to exist at df560ae were invisible to this check until 2026-08-10.
            # Apostrophes inside words ("don't") are excluded by requiring the opening quote
            # to follow a non-word character and the closing quote to precede one.
            #
            # FOURTH HOLE, 2026-08-12 — Greek guillemets « ». They are the standard Greek
            # quotation mark and this is a Greek-first corpus: 86 expectations across 18 of
            # the 20 suites quote in them, and the extractor read none of it. Measured on the
            # tree at the time of the fix: total extraction 912 -> 1101 phrases (+189, 151
            # unique), zero previously-found phrases lost. Among the newly visible are the
            # anti-slop banned Greek openers the suites quote verbatim («Ας δούμε…»,
            # «Ας εξερευνήσουμε…») and the Greek placeholder tokens («[ΜΑΡΚΑ]»,
            # «απαιτούνται στοιχεία») — the exact uncarried-vocabulary shape this tool exists
            # to find, in the language most of this library's deliverables are written in.
            #
            # The capture-group selection below is generic on purpose. It used to be
            # `phrase[0] or phrase[1] or phrase[2]`, a positional form that silently ignores
            # any alternative added after the third — so adding the guillemet branch without
            # also fixing this line would have changed the regex and changed nothing else,
            # and the patch would have looked applied while doing no work.
            for phrase in re.findall(r'"([^"]{3,140})"|`([^`]{3,140})`|(?<![\w])\'([^\']{3,140})\'(?![\w])|«([^»]{3,140})»', text):
                phrases_extracted += 1
                ph = next((g for g in phrase if g), "").strip()
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
print(f"BEHAVIOUR. entity-optimizer is the worst known instance of the class (suite graded")
print(f"fabrication, skill said nothing about it, 62.1%), and this tool cannot see that")
print(f"expectation — it demanded a behaviour, so there is no quoted string to grep. Any")
print(f"candidate count printed above for that suite is unrelated phrases, NOT that defect.")
print(f"Read the suite beside the skill; this tool only removes the phrase-shaped half.")

# ---------------------------------------------------------------------------------------
# INSTRUMENT HEALTH. Everything above is a finding; everything below is whether the finding
# is worth anything. Ordered loudest-first so a broken run cannot be read as a clean one.
# ---------------------------------------------------------------------------------------
fatal = []

if unreadable:
    fatal.append(f"{len(unreadable)} suite(s) did not parse and were NEVER CHECKED")
if no_skill_text:
    fatal.append(f"{len(no_skill_text)} skill(s) have an eval suite but no readable skill text")
# The extractor's own liveness. If expectations were read and not one quoted phrase came back,
# the regex is dead and every suite reports clean — the failure this whole file is about, one
# level up. Scoped to full runs: a single targeted suite may legitimately quote nothing.
extractor_dead = (not target) and expectations_read > 0 and phrases_extracted == 0
if extractor_dead:
    fatal.append(f"extractor returned 0 phrases from {expectations_read} expectation(s) — regex is dead")

print()
print(f"{DIM}instrument: {len(suites)} suite(s) discovered · {expectations_read} expectation(s) read · "
      f"{phrases_extracted} quoted phrase(s) extracted{OFF}")

if fatal:
    print(f"{RED}FAIL{OFF} — this run cannot be trusted:")
    for f in fatal:
        print(f"  - {f}")
    for s, e in unreadable:
        print(f"  UNREADABLE {s}: {e}")
    for s in no_skill_text:
        print(f"  NO SKILL TEXT {s} — empty comparison corpus, so it reported clean by default")
    print("A skill whose text cannot be read contributes zero candidates and turns the whole")
    print("run green for free. That is the defect this check was written to find, so it may")
    print("not be the shape the check itself exits 0 on.")
    sys.exit(1)

if total_hits and FAIL_ON_CANDIDATES:
    print(f"{RED}FAIL{OFF} — FAIL_ON_CANDIDATES=1 and {total_hits} candidate(s) were found.")
    print("Each is a candidate, not an established defect. This mode is for a corpus already")
    print("driven to zero; if you are seeing this on a corpus that was never triaged, triage it")
    print("rather than unsetting the variable.")
    sys.exit(1)

sys.exit(0)
PY
