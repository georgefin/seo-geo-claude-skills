#!/usr/bin/env bash
# eval-expectation-sweep.sh — run the deprecated-token sweep over eval EXPECTATIONS,
# which validate-tracking check (f) cannot see.
#
# WHY THIS EXISTS (2026-08-13, content-refresher).
# check (f) sweeps `research build optimize monitor cross-cutting commands references`
# and pipes the result through `grep -v 'evals/'`. On 2026-08-13, three `expectations`
# entries and two `expected_output` fields in
# `optimize/content-refresher/evals/evals.json` REQUIRED a claim this library had
# just retracted across nine files — the graders demanded "Google retired FAQ rich
# results in 2026" and "kept for AI-engine/GEO parsing only". A skill corrected to
# the sourced position would have FAILED ITS OWN EVAL FOR BEING RIGHT. That is F13's
# shape at suite level: the rule stated in one place and enforced against the
# opposite elsewhere. The retracted claim survived longest in the one place the
# sweep was told not to look.
#
# THE EXCLUSION IS RIGHT FOR FIXTURES AND WRONG FOR EXPECTATIONS.
# A fixture under `evals/files/` is DELIBERATELY a bad page — stale dates, dead
# claims, broken links — because catching them is what the skill is graded on.
# Sweeping fixtures would fire on every defect they were built to contain. An
# expectation is not a page: it is a RULE, in the same normative voice as the skill,
# and a stale rule is a stale rule wherever it is written. So this script reads the
# expectation fields and never opens `evals/files/**`.
#
# HOW THE FIXTURE/RULE DISTINCTION IS HANDLED — the thing that makes this guard
# useful or useless, stated plainly.
# An expectation legitimately QUOTES the fixture's bad claim in order to require
# that the model catch it. content-refresher e1 does exactly that: «the article's
# claim that 'Google displays FAQ rich results as expandable questions right in the
# SERP' is flagged as no longer true». Grepping the file whole cannot tell that from
# the same words asserted as a rule, so this script does not grep the file at all —
# it parses the JSON, then classifies every token hit by ROLE:
#
#   RULE  — the hit is in the expectation's own voice. Legal only if the sentence
#           also denies/qualifies the claim (the marker sets below, which are the
#           same design as check (f)'s R3_LEGAL). Otherwise FAIL.
#   QUOTE — the hit is entirely inside a quoted span ('…', "…", «…», `…`) AND the
#           sentence around it carries a detection verb (flagged, caught, corrected,
#           identified, fails, must not, defect, stale, fixture, no longer). That is
#           fixture text the model is graded on catching. PASS.
#   AMBIGUOUS — quoted, but with no detection verb anywhere in the sentence. The
#           script cannot tell whether the suite is quoting a page or restating a
#           rule, and it says so: WARN, listed, never silently passed and never
#           failed. Guessing in either direction would make the census a lie.
#
# The `prompt` field is NOT swept. It is the user's message — the fictional client
# who believes the stale thing — and sweeping it would fail suites for having a
# realistic premise. `files` is a path list. Everything else in the record is either
# expectations[] or expected_output.
#
# TOKEN CLASSES, AND WHY TWO OF THEM ARE NEW.
# Classes (f1)-(f3) are check (f)'s own patterns, verbatim, applied to a surface it
# cannot reach. Classes (e1)-(e2) exist because a VERBATIM extension of check (f)
# would NOT have caught the 2026-08-13 instance, and that is worth recording:
# check (f)'s R3_LEGAL allowlist contains `retired|retirement`, so the sentence
# "Google retired FAQ rich results in 2026" is EXEMPT from (f) by construction —
# the allowlist blesses the exact claim `r3-supersession-candidate.md` §4 lists as
# U1, the unsourced one. That is the B2 pattern again (a marker that is its own pass
# condition), one allowlist widening later.
#
# (e1) and (e2) do NOT rule on whether the 2026 retirement happened. R3 still says it
# did, R3 is settled, and this script has no standing to contradict a ruling. They
# require only that the claim TRAVEL WITH THE GRADE ITS OWN RULING GIVES IT: R3's
# evidence clause says snippet-grade, not owner-read, and amendment 9a says in terms
# that the AI-parsing rationale "has no primary source either way". An eval that
# demands the bare assertion is demanding more confidence than the ruling has. Every
# qualifier in QUALIFIERS is therefore a statement about EVIDENCE, not about Google —
# vetted against the B2 rule, which is what an allowlist entry now costs.
#
# ANTI-VACUITY (F15, and it recurred today inside a fix for something else).
# A sweep whose regexes have rotted reports a clean tree. Every class below carries a
# CANARY string it MUST match; if any class fails its own canary the script FAILS
# without judging the corpus. It also fails when it finds no suites, or parses no
# expectation fields.
#
# Usage:   scripts/eval-expectation-sweep.sh [repo-root]
#          scripts/eval-expectation-sweep.sh --suite <path/to/evals.json>   (probe mode)
# Exit:    0 = pass (warnings allowed), 1 = any FAIL, 2 = usage/setup error
# No network. Dependencies: bash, python3.

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SUITES=()

while [ "$#" -gt 0 ]; do
    case "$1" in
        --suite)
            [ "${2:-}" ] || { echo "ERROR: --suite needs a file" >&2; exit 2; }
            SUITES+=("$2"); shift 2 ;;
        -h|--help)
            sed -n '2,60p' "${BASH_SOURCE[0]}"; exit 0 ;;
        *)
            [ -d "$1" ] || { echo "ERROR: repo root '$1' is not a directory" >&2; exit 2; }
            ROOT="$(cd "$1" && pwd)"; shift ;;
    esac
done
for s in "${SUITES[@]:-}"; do
    [ -z "$s" ] && continue
    [ -f "$s" ] || { echo "ERROR: suite file not found: $s" >&2; exit 2; }
done

python3 - "$ROOT" "${SUITES[@]:-}" <<'PY'
import json, re, sys, pathlib

root = pathlib.Path(sys.argv[1])
explicit = [pathlib.Path(p) for p in sys.argv[2:] if p]

PASS_N = FAIL_N = WARN_N = 0
def pas(m):
    global PASS_N; PASS_N += 1; print("PASS: " + m)
def fail(m):
    global FAIL_N; FAIL_N += 1; print("FAIL: " + m)
def warn(m):
    global WARN_N; WARN_N += 1; print("WARN: " + m)
def ev(m):
    print("      " + m)

CATEGORIES = ("research", "build", "optimize", "monitor", "cross-cutting")

# --- token classes ---------------------------------------------------------
# (token regex, legal-marker regex, canary that MUST match, canary that must NOT)
# The (f1)-(f3) rows are copied from scripts/validate-tracking.sh check (f). Keep
# them copied, not re-invented: when (f) widens, widen here in the same commit, and
# the canaries below will tell you if a paste went wrong.
#
# NEG is the shared "this expectation is REQUIRING THE ABSENCE of the token" set,
# and every phrase in it was added against a real expectation this sweep first got
# wrong: «nothing in the response treats FID as a live metric», «identified as dead
# sensors», «no FID», «The response nowhere claims the markup is eligible…», «FAQPage
# suggestion framed with no SERP promise». All five are the CORRECT rule, and a guard
# that fails the correct rule is the mistake check (f)'s 2026-08-11 note is about —
# three times over there, once here. Kept narrow on purpose: a bare `\bnot\b` would
# exempt nearly every expectation in the corpus and leave an F15 guard that passes by
# matching nothing.
NEG = (r"nothing in the response|nowhere (claims|states|promises|instructs)|"
       r"does not (instruct|claim|state|promise|treat|report|monitor|use|assert)|"
       r"do not (claim|state|promise|treat|assert)|must not|never|no longer|"
       r"is not (a )?(live|current)|dead (metric|sensor|signal)|as dead|\bno fid\b|"
       r"without fid|zero fires|\bfails\b|flag\w*|caught|catch|correct\w*|identif\w*|"
       r"marked for|stale|outdated|fixture|retracted|withdraw\w*|"
       r"no serp (promise|feature|claim)")

F1_TOK = r"\bFID\b|First Input Delay|Affiliate links disclosed"
F1_LEG = (r"corrected to|replaced by inp|inp[- ]only|retired|deprecated|"
          r"instead of|rather than|" + NEG)
F2_TOK = (r"faq.*rich[- ]?(result|snippet)|rich[- ]?(result|snippet)s?.*faq|eligib[^.|]*faq|"
          r"faq[^.|]*eligib|expandable q&a below|faq (accordion|dropdown|drop-down)|serp accordion")
F2_LEG = (r"retired|retirement|ended|ceased|discontinued|no longer|non-faq|"
          r"no faq (support|eligibility)|faq(:| has) none|dropped faq support|"
          r"do not run it through|no evidenced citation benefit|"
          r"no need to (proactively )?remove|scheduled for august 2026|has none since|"
          r"no faq rich result|government (and|/)health|government and health|"
          r"government/health|restricted (them )?to|2023-08-08|aug 2023|"
          r"does not (support|test) faqpage|not (the route|supported) for faqpage|unverified|"
          r"promis\w* no|no serp feature|" + NEG)
F3_TOK = r"advises against ([a-z]+ )?remov"
F3_LEG = r"(?!x)x"          # never legal: Google made no such recommendation (B2, 2026-08-13)

# (e1) the unsourced 2026 FAQ-ending date, asserted with no evidence qualifier.
E1_TOK = (r"(retire|retired|retirement|ended|ends|dropped|drops|removed|"
          r"discontinued)[^.;]{0,60}\b2026\b|\b2026\b[^.;]{0,60}"
          r"(retire|retired|retirement|ended|dropped|removed|discontinued)")
# (e2) the AI-parsing/citation rationale R3 amendment 9a says has no primary source.
E2_TOK = (r"(ai[- ]engine|geo|ai)[-/ ]?(engine)?[^.;]{0,20}pars\w*|"
          r"earns? (ai )?citations?|for ai[- ]engine")
# Qualifiers legal for (e1)/(e2). EVERY ONE IS A STATEMENT ABOUT EVIDENCE, not about
# Google — an allowlist marker is an assertion the guard endorses (B2), and "this
# claim's evidence is thin" is an assertion this library can source from R3 itself.
QUALIFIERS = (r"\[verify|unverified|unsourced|not owner-read|snippet-grade|snippet grade|"
              r"no primary source|no benefit claimed|neither .{0,40}nor|amendment 9a|"
              r"supersession|in either direction|unestablished|scheduled|"
              r"grade:|not for any|promises? nothing|takes no position|abstain|"
              r"\bruling r3\b|\(r3\)|per r3\b")

# CONTEXT: a second pattern the SENTENCE must also match before a hit counts —
# grep-AND, the same construction check (f) uses for its R3-overstatement class and
# for the same reason. Without it, (e1)'s date pattern fired on «the log ends at
# 2026-08-03» in rank-tracker, an expectation about a rank log with no relation to
# FAQ or to any Google claim. A guard whose first live run is mostly noise is a guard
# somebody turns off.
CONTEXT = {
    "e1": re.compile(r"faq|rich[- ]result|rich results test|search appearance", re.I),
    "e2": re.compile(r"faqpage|markup|schema|structured data", re.I),
}

CLASSES = [
    ("f1", "deprecated metric token (check (f) parity)", F1_TOK, F1_LEG,
     "the page still reports FID as a Core Web Vital",
     "the LCP-2.0/FID line corrected to LCP <=2.5 s and INP <=200 ms"),
    ("f2", "FAQ rich-result eligibility claim (R3, check (f) parity)", F2_TOK, F2_LEG,
     "the plan promises FAQ rich results in the SERP",
     "an ordinary site gets no FAQ rich result, government/health only since 2023-08-08"),
    ("f3", "R3 overstatement: a permission shipped as a recommendation", F3_TOK, F3_LEG,
     "Google advises against removing FAQPage markup",
     None),
    ("e1", "unsourced 2026 FAQ-ending date asserted without its evidence grade", E1_TOK,
     QUALIFIERS,
     "Google retired FAQ rich results in 2026",
     "the 2026 dates are unverified and the sourced position is 2023-08-08"),
    ("e2", "AI-parsing/citation benefit asserted (9a: no primary source either way)", E2_TOK,
     QUALIFIERS,
     "FAQPage markup is kept for AI-engine/GEO parsing only",
     "NOT for any citation or parsing benefit (no primary source establishes one, R3 amendment 9a)"),
]
CLASSES = [(cid, name, re.compile(tok, re.I), re.compile(leg, re.I), yes, no)
           for cid, name, tok, leg, yes, no in CLASSES]

DETECT = re.compile(r"(flag\w*|catch|caught|correct\w*|identif\w*|fails?|must not|never|"
                    r"defect|stale|outdated|no longer|fixture|article's claim|is graded|"
                    r"marked for|dead|withdraw\w*|retracted)", re.I)
QSPAN = re.compile(r"'[^']{4,}'|\"[^\"]{4,}\"|«[^»]{4,}»|`[^`]{4,}`|“[^”]{4,}”")


def sentences(t):
    """Split on sentence enders and newlines only.

    NOT on the em dashes the register style is full of: a legal marker and its token
    routinely sit on either side of one ("flagged as no longer true — Google retired
    FAQ rich results in 2026"), and splitting there would have manufactured a FAIL on
    the corrected text as readily as on the stale text.
    """
    return [s for s in re.split(r"(?<=[.;:])\s+|\n+", t) if s.strip()]


def classify(sent, m):
    """RULE / QUOTE / AMBIGUOUS for one token hit inside one sentence."""
    for q in QSPAN.finditer(sent):
        if q.start() <= m.start() and m.end() <= q.end():
            outside = sent[:q.start()] + sent[q.end():]
            return "QUOTE" if DETECT.search(outside) else "AMBIGUOUS"
    return "RULE"


# --- self-test: every class must still match its own canary (F15) -----------
print("eval-expectation-sweep: deprecated-token sweep over evals.json expectations")
print("==============================================")
print("")
print("[0] class self-test (F15: a sweep whose patterns have rotted reports a clean tree)")
selftest_ok = True
for cid, name, tok, leg, yes, no in CLASSES:
    if not tok.search(yes):
        fail(f"(0) class ({cid}) no longer matches its own canary: \"{yes}\" — pattern drift; "
             f"the corpus below was NOT judged"); selftest_ok = False
    elif leg.search(yes):
        fail(f"(0) class ({cid}) canary \"{yes}\" is exempted by its own legal-marker set — "
             f"the claim would be its own pass condition (B2, 2026-08-13)"); selftest_ok = False
    if no is not None and tok.search(no) and not leg.search(no):
        fail(f"(0) class ({cid}) fails its NEGATIVE canary: \"{no}\" is corrected text and "
             f"would be reported as a violation — a guard that punishes the corrected line "
             f"teaches authors to write for the checker"); selftest_ok = False
if selftest_ok:
    pas(f"(0) all {len(CLASSES)} token classes match their positive canary, are not exempted "
        f"by their own markers, and clear their negative canary")
else:
    print("")
    print("==============================================")
    print(f"Results: {PASS_N} passed, {WARN_N} warnings, {FAIL_N} failed")
    print("eval-expectation-sweep FAILED — self-test; no corpus verdict was reached")
    sys.exit(1)

# --- corpus ----------------------------------------------------------------
if explicit:
    suites = explicit
else:
    suites = sorted(p for c in CATEGORIES for p in (root / c).glob("*/evals/evals.json"))

print("")
print("[1] expectation sweep (expectations[] + expected_output; evals/files/** never opened)")

NFIELD = NHIT = NQUOTE = 0
AMBIG = []
unreadable = []
for path in suites:
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except Exception as e:
        unreadable.append((path, str(e))); continue
    rel = path.relative_to(root) if root in path.parents or str(path).startswith(str(root)) else path
    for ev_rec in data.get("evals", []):
        eid = ev_rec.get("id", "?")
        fields = []
        eo = ev_rec.get("expected_output")
        if isinstance(eo, str):
            fields.append(("expected_output", eo))
        for i, x in enumerate(ev_rec.get("expectations", []) or []):
            if isinstance(x, str):
                fields.append((f"expectations[{i}]", x))
        for fname, text in fields:
            NFIELD += 1
            for sent in sentences(text):
                for cid, cname, tok, leg, _, _ in CLASSES:
                    ctx = CONTEXT.get(cid)
                    if ctx and not ctx.search(sent):
                        continue
                    for m in tok.finditer(sent):
                        role = classify(sent, m)
                        if role == "QUOTE":
                            NQUOTE += 1
                            continue
                        if leg.search(sent):
                            continue
                        snip = sent.strip()
                        snip = (snip[:180] + "…") if len(snip) > 180 else snip
                        if role == "AMBIGUOUS":
                            AMBIG.append((rel, eid, fname, cid, snip))
                            continue
                        NHIT += 1
                        fail(f"({cid}) {rel} eval {eid} {fname} — {cname}: the expectation "
                             f"REQUIRES this claim, so a skill corrected to the current "
                             f"position fails its own eval for being right")
                        ev(f"matched \"{m.group(0)}\" in: {snip}")

for p, why in unreadable:
    fail(f"(1) unparseable suite {p}: {why} — a suite this cannot read is not skipped "
         f"(F15: a smaller corpus that still looks like an answer)")

# --- anti-vacuity ----------------------------------------------------------
print("")
if not suites:
    fail("(2) found NO evals.json under the skill categories — this sweep judged nothing (F15)")
elif NFIELD == 0:
    fail(f"(2) parsed {len(suites)} suite(s) but extracted ZERO expectation/expected_output "
         f"fields — schema drift; the sweep read nothing (F15)")
elif NHIT == 0 and not unreadable:
    pas(f"(2) {NFIELD} expectation/expected_output field(s) across {len(suites)} suite(s) "
        f"swept for {len(CLASSES)} token class(es); no retracted claim required as a rule "
        f"({NQUOTE} hit(s) were fixture text quoted for the model to catch)")
else:
    print(f"      swept {NFIELD} field(s) across {len(suites)} suite(s); {NQUOTE} quoted "
          f"fixture hit(s) exempted")

if AMBIG:
    warn(f"{len(AMBIG)} quoted token hit(s) with no detection verb in the sentence — this "
         f"script cannot tell a fixture quotation from a restated rule here, and does not "
         f"guess in either direction; read them and add the framing (or the correction)")
    for rel, eid, fname, cid, snip in AMBIG:
        ev(f"({cid}) {rel} eval {eid} {fname}: {snip}")

print("")
print("==============================================")
print(f"Results: {PASS_N} passed, {WARN_N} warnings, {FAIL_N} failed")
if FAIL_N:
    print("eval-expectation-sweep FAILED — an eval expectation grades a retracted claim")
    sys.exit(1)
print("eval-expectation-sweep PASSED" + (" with warnings" if WARN_N else ""))
sys.exit(0)
PY
