#!/usr/bin/env bash
# citation-divergence-check.sh — does a ruling's CITED source carry the ruling's CLAIM?
#
# WHY THIS EXISTS (R3, 2026-08-11 — and it is not hypothetical).
# Settled ruling R3 names two URLs as its sources. Both were read in a browser on
# 2026-08-11, at HTTP 200, and they contain NONE of R3's load-bearing claims: the
# 2026 dates came from a third URL (`developers.google.com/search/updates`) that
# appears nowhere in R3, in G9, or in W12. The reconstruction is
# `docs/loop/r3-supersession-candidate.md` §4, and its one-sentence verdict is the
# spec for this script:
#
#   "the citation and the evidence came apart: a ruling named two URLs as its
#    sources while its load-bearing claims came from a third, and no check in the
#    loop compares a ruling's cited URLs against the URLs its claims were actually
#    drawn from."
#
# It was caught by luck. The owner fetched what he was told to fetch and found it
# empty. Nothing in pre-push-gate.sh, claims-gate.sh or validate-tracking.sh looks
# at the relation between a claim and the source printed beside it.
#
# WHAT THIS CAN AND CANNOT BE.
# It cannot fetch. `developers.google.com` is refused by this environment's egress
# policy (re-tested 2026-08-11 through both the HTTP client and WebFetch), and a
# gate that needs the network is not a gate. So this script never asks "is the
# claim IN the source" — that is an owner read, and it stays one. It asks the
# strictly weaker, fully offline question that would still have caught R3:
#
#   Is the ruling's evidence STRUCTURALLY ACCOUNTABLE? Does every load-bearing
#   claim point at WHICH named source carries it, is every named source pointed at
#   by something, and is every pointer a URL a human could actually open?
#
# An unattributed claim sitting under a "sources" list is the exact defect: the
# list makes the block look sourced, and nothing in it says which sentence came
# from where. Once each claim names its source, an owner read of source S2 either
# finds the three claims tagged [S2] or does not, and the divergence surfaces in
# two minutes instead of by accident.
#
# THE CONTRACT (the form the checks below enforce)
#   - **Sources**:
#     - `S1` https://developers.google.com/search/blog/2023/08/howto-faq-changes — grade: owner-read, 2026-08-11
#     - `S2` https://developers.google.com/search/updates — grade: snippet, 2026-08-10
# and every load-bearing sentence in the ruling carries `[S1]`, `[S2]`, `[VERIFY …]`,
# `[obs:…]`, or the explicit `[no-source]`.
#
# Three details of that contract are load-bearing, each paid for by the R3 chain:
#   * ABSOLUTE URLs. R3 cites `developers.google.com/search/blog/…` with no scheme
#     and `.../2026/05/a-new-resource-for-optimizing` with the host ELIDED. The
#     second is not a URL at all — nobody can fetch an ellipsis — and the person
#     asked to verify it has to reconstruct it by guessing. Check (2) fails both.
#   * A READ GRADE PER SOURCE, from a closed vocabulary. R3 states its grade once,
#     for the ruling; but the ruling drew on sources of different grades, and the
#     single grade averaged them into something no individual source had.
#   * A READ DATE PER SOURCE. The R3 chain lost the fetch time at hop 1 and never
#     recovered it, which is why §4 cannot say today whether a real snippet ever
#     returned those strings.
#
# WHY THE GRADE VOCABULARY IS SAFE TO HARDCODE (B2 rule, 2026-08-13).
# validate-tracking's (f) allowlist was once given "advises against removing" as a
# convenience marker — a claim Google never made — so the guard could not fail that
# claim, because the claim was its own pass condition. An allowlist marker is an
# assertion the guard endorses. Every token in GRADES below names HOW A TEXT WAS
# OBTAINED (owner-read, snippet, search-summary, secondary, absence, none). None of
# them asserts anything about Google, about the web, or about any claim's truth, so
# the B2 failure mode cannot arise here: endorsing "snippet" endorses no fact.
# Keep it that way — if a future grade token would assert something about the
# world, it is not a grade.
#
# TIERING, and why it is not a way of passing quietly.
# Checks 1-6 FAIL only for rulings that OPTED IN to evidence citation — a ruling
# that names a URL or states an evidence grade. That is the population design
# target 1 names, and today it is R3 alone. A ruling with no source at all (R1's
# "no engine-official adoption found" is an absence claim, and honest as one) is
# not failed; it is COUNTED and LISTED as a census WARN, the same treatment
# check (g) gives un-anchored pointers. The census is the standing proposal for a
# sourcing pass, and it is what stops this script from being F15's "guard that
# passes by matching nothing": check 7 fails loudly when zero rulings parse, or
# when the whole register declares no source anywhere.
#
# Usage:   scripts/citation-divergence-check.sh [repo-root]
#          scripts/citation-divergence-check.sh --register <file> [--register <file>]…
# Exit:    0 = pass (warnings allowed), 1 = any FAIL, 2 = usage/setup error
# No network. Dependencies: bash, python3.

set -u

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
REGISTERS=()

while [ "$#" -gt 0 ]; do
    case "$1" in
        --register)
            [ "${2:-}" ] || { echo "ERROR: --register needs a file" >&2; exit 2; }
            REGISTERS+=("$2"); shift 2 ;;
        -h|--help)
            sed -n '2,40p' "${BASH_SOURCE[0]}"; exit 0 ;;
        *)
            [ -d "$1" ] || { echo "ERROR: repo root '$1' is not a directory" >&2; exit 2; }
            ROOT="$(cd "$1" && pwd)"; shift ;;
    esac
done

if [ "${#REGISTERS[@]}" -eq 0 ]; then
    REGISTERS=("$ROOT/docs/loop/SETTLED-RULINGS.md")
fi
for r in "${REGISTERS[@]}"; do
    [ -f "$r" ] || { echo "ERROR: register file not found: $r" >&2; exit 2; }
done

python3 - "${REGISTERS[@]}" <<'PY'
import re, sys, pathlib

PASS_N = FAIL_N = WARN_N = 0
def pas(m):
    global PASS_N; PASS_N += 1; print("PASS: " + m)
def fail(m):
    global FAIL_N; FAIL_N += 1; print("FAIL: " + m)
def warn(m):
    global WARN_N; WARN_N += 1; print("WARN: " + m)
def ev(m):
    print("      " + m)

# Read grades: HOW a text was obtained. Never a claim about the world (see header).
GRADES = ("owner-read", "snippet", "search-summary", "secondary", "absence", "none")

# A sentence is load-bearing when it asserts something about the world outside this
# repository. Three shapes, drawn from the U1-U9 list in r3-supersession-candidate §4:
#   (i)  a named external actor plus an assertion verb  ("Google ended…", "schema.org deprecated…")
#   (ii) a bare calendar year or ISO date presented as fact ("in 2026", "2023-08-08")
#   (iii) a numeric threshold with a unit ("2.5s", "200ms", "0.1")
ACTOR = r"(Google|Bing|OpenAI|Perplexity|Anthropic|schema\.org|Search Console|Rich Results Test|the engines?)"
VERB  = (r"(ended?|ends|dropped?|drops|retired?|restrict(ed|s)?|announced?|states?|said|says|"
         r"confirmed?|document(ed|s)?|removed?|schedul(ed|es)|supports?|honou?rs?|deprecat\w*|"
         r"launched?|narrowed?|advis(es|ed)|recommends?|requires?|treats?|ignores?)")
CLAIM_ACTOR = re.compile(ACTOR + r"[^.]{0,80}?\b" + VERB + r"\b", re.I)
CLAIM_DATE  = re.compile(r"\b(20[0-9]{2}-[0-9]{2}-[0-9]{2}|(19|20)[0-9]{2})\b")
CLAIM_NUM   = re.compile(r"\b\d+(\.\d+)?\s?(s|ms|%)\b")

# A sentence about THIS repository, THIS environment or THIS loop's own process is
# not an external claim and needs no external source.
#
# THE SKIP IS SUBORDINATE TO THE CLAIM TEST, and that ordering is the whole point.
# The first draft of this check skipped any sentence carrying an internal marker,
# and R3's Statement — "Google ended FAQ rich results in 2026 … but FAQPage
# generation stays in the library" — escaped through the words "the library". The
# most load-bearing sentence in the register was the one the guard excused, because
# a claim about Google and a note about our own repo shared a sentence. So an
# internal marker never rescues a sentence that also names an external actor doing
# something: see the `and not CLAIM_ACTOR` in the loop below.
INTERNAL = re.compile(
    r"(VERSIONS\.md|SKILL\.md|references/|docs/loop|this environment|egress|WebFetch|"
    r"pointer|anchor|re-?affirmed|sweep|amendment|proposal \d|held, per|routine prompt|"
    r"check \([a-h]\)|scripts/|CORE-EEAT|CITE item|benchmark|commit [0-9a-f]{7})", re.I)

# Clause labels that record the loop's own bookkeeping rather than a claim about
# the world. "Decided" and "Last review" are dates of OUR meetings; "Encoded in
# repo" is a pointer list; "Reopens on" is a future condition, not an assertion.
SKIP_LABELS = ("decided", "encoded in repo", "reopens on", "last review", "sources",
               "carrier", "carriers")

ATTRIB = re.compile(r"\[(S\d+|VERIFY\b[^\]]*|obs:[^\]]*|no-source)\]")
SREF   = re.compile(r"\[S(\d+)\]")
# Matched against the clause BODY (clauses() has already stripped the bullet's own
# '- '), so a source entry reads: `S1` https://… — grade: snippet, 2026-08-10
SDECL  = re.compile(r"^\s*`?S(\d+)`?[\s:—–-]+(.*)$")

# A URL-shaped token: host with a real TLD plus a path. Requires the path so that
# `VERSIONS.md` and `schema.org` on their own are not mistaken for citations.
URLTOK = re.compile(
    r"(?<![\w/.])((?:https?://)?(?:[a-z0-9][a-z0-9-]*\.)+(?:com|org|net|dev|io|ai|gov|edu|uk)"
    r"(?:/[^\s`,)\"'\]]+))", re.I)
# An ELIDED reference: an ellipsis standing where a host or a path segment belongs.
ELIDED = re.compile(r"(\.\.\.|…)/[\w./%-]+")
WEAK   = re.compile(r"(snippet-grade|snippet grade|not owner-read|unverified|"
                    r"no primary source|\[VERIFY)", re.I)
# Two grade patterns, deliberately not one.
#   GRADECLAUSE — the canonical per-source form `grade: snippet`. Check (1) requires
#     it on every declared source, because a single ruling-level grade averages
#     sources of different grades into one that no individual source has (R3 states
#     one grade and drew on an owner-readable blog post and an unfetched changelog).
#   GRADEANY — the ruling-level greppability test of design target 2. R3's own
#     "snippet-grade … not owner-read" clause satisfies this and is meant to: the
#     target asks that weak evidence be FINDABLE, and that clause is. Failing R3
#     here as well would tell the reader nothing check (1) has not already told
#     them, and a guard that fails the same defect twice trains people to skim it.
GRADECLAUSE = re.compile(r"grade\s*:?\s*\**\s*(" + "|".join(GRADES) + r")\b", re.I)
GRADEANY = re.compile(r"(grade\s*:?\s*\**\s*(" + "|".join(GRADES) + r")\b"
                      r"|\b(owner-read|snippet-grade|snippet grade|search-summary|"
                      r"secondary source|absence of evidence)\b)", re.I)


def blocks(text):
    """Split a rulings register into (id, title, startline, lines[]) per '## R<n>' heading.

    The id pattern is `[A-Z]+<digits>` rather than a literal `R\\d+` so the fixtures
    under scripts/fixtures/citation-divergence/ (RX1, RX2) parse through the same
    reader as the live register — a probe that runs a different parser proves
    nothing about the guard. Non-ruling headings ('## Pinned baselines') do not
    match, and check (7) fails loudly if the pattern ever stops matching anything.
    """
    out, cur = [], None
    for i, line in enumerate(text.splitlines(), 1):
        m = re.match(r"^##\s+([A-Z][A-Z0-9]*[0-9])\s*[—–-]\s*(.*)$", line)
        if m:
            if cur: out.append(cur)
            cur = [m.group(1), m.group(2).strip(), i, []]
            continue
        if re.match(r"^##\s+", line) and cur:
            out.append(cur); cur = None
            continue
        if cur:
            cur[3].append((i, line))
    if cur: out.append(cur)
    return out


def clauses(lines):
    """Join each bullet with its wrapped continuation lines.

    The registers wrap at ~85 chars, so a claim and its attribution routinely sit on
    different physical lines. A line-based check would report a false divergence on
    every wrapped sentence, which is how a guard earns its way out of the gate.
    Returns (startline, label, text) with fenced code dropped.
    """
    out, cur, fence = [], None, False
    for n, raw in lines:
        if raw.strip().startswith("```"):
            fence = not fence
            continue
        if fence:
            continue
        m = re.match(r"^(\s*)[-*]\s+(.*)$", raw)
        if m:
            if cur: out.append(cur)
            body = m.group(2)
            lm = re.match(r"^\*\*([^*]+?)\*\*\s*:?\s*(.*)$", body)
            label = lm.group(1).strip().lower() if lm else ""
            cur = [n, label, body]
        elif raw.strip() == "":
            if cur: out.append(cur); cur = None
        elif cur:
            cur[2] += " " + raw.strip()
        else:
            cur = [n, "", raw.strip()]
    if cur: out.append(cur)
    return [c for c in out if c[2].strip()]


def sentences(t):
    return [s for s in re.split(r"(?<=[.;])\s+(?=[A-Z\*`\[“\"(])", t) if s.strip()]


targets = [pathlib.Path(p) for p in sys.argv[1:]]
print("citation-divergence-check: does each ruling's cited source carry its claims?")
print("Registers: " + ", ".join(str(p) for p in targets))
print("==============================================")

TOTAL_BLOCKS = TOTAL_OPTED = TOTAL_SRC = TOTAL_REF = 0
CENSUS = []

for path in targets:
    text = path.read_text(encoding="utf-8")
    name = path.name
    for rid, title, hline, lines in blocks(text):
        TOTAL_BLOCKS += 1
        body = "\n".join(l for _, l in lines)
        cls = clauses(lines)

        # URLs and elisions are read from PHYSICAL lines so the reported line number
        # is the one to open; claims are read from joined clauses (below) because a
        # claim and its attribution routinely straddle the register's ~85-char wrap.
        urls = [(n, m.group(1)) for n, l in lines for m in URLTOK.finditer(l)]
        elis = [(n, m.group(0)) for n, l in lines for m in ELIDED.finditer(l)]
        decls = {}
        for n, _, t in cls:
            m = SDECL.match(t)
            if m: decls[int(m.group(1))] = (n, m.group(2))
        refs = {}
        for n, lab, t in cls:
            if SDECL.match(t): continue
            for k in SREF.findall(t):
                refs.setdefault(int(k), []).append(n)

        opted = bool(urls) or bool(decls) or bool(WEAK.search(body)) or bool(GRADEANY.search(body))
        if not opted:
            # Census, not a failure. An absence claim ("no engine-official adoption
            # found") is honest with no URL; a ruling that never cites is a
            # sourcing-pass candidate, not a push blocker.
            nclaims = sum(
                1 for n, lab, t in cls if lab not in SKIP_LABELS
                for s in sentences(t)
                if (CLAIM_ACTOR.search(s) or (CLAIM_NUM.search(s) and not INTERNAL.search(s)))
            )
            CENSUS.append((name, rid, hline, nclaims))
            continue

        TOTAL_OPTED += 1
        TOTAL_SRC += len(decls)
        TOTAL_REF += len(refs)
        ok = True
        loc = f"{name} {rid} (line {hline})"

        # (1) source-list grammar --------------------------------------------
        if not decls:
            ok = False
            fail(f"(1) {loc} names {len(urls)} source URL(s) / states an evidence grade but "
                 f"declares no `S<n>` source list — a URL under a prose sentence cannot be "
                 f"pointed at by a claim, which is how R3's two cited URLs went unused. Add:")
            ev("- **Sources**:")
            ev("  - `S1` https://host/path — grade: snippet, 2026-08-10")
            for n, u in urls[:4]:
                ev(f"named at {name}:{n}: {u}")
        for k in sorted(decls):
            n, rest = decls[k]
            u = URLTOK.search(rest)
            if not u:
                fail(f"(1) {loc} source `S{k}` ({name}:{n}) carries no absolute URL — "
                     f"the reader asked to verify it has nothing to open"); ok = False
            elif not u.group(1).lower().startswith("http"):
                fail(f"(1) {loc} source `S{k}` ({name}:{n}) URL has no scheme: {u.group(1)} — "
                     f"write it as an https:// URL that can be pasted into a browser"); ok = False
            if not GRADECLAUSE.search(rest):
                fail(f"(1) {loc} source `S{k}` ({name}:{n}) states no read grade — "
                     f"append '— grade: <{'|'.join(GRADES)}>'; the ruling-level grade "
                     f"averages sources of different grades into one no source has"); ok = False
            if not re.search(r"\b20\d\d-\d\d-\d\d\b", rest):
                fail(f"(1) {loc} source `S{k}` ({name}:{n}) states no read date (YYYY-MM-DD) — "
                     f"the R3 chain lost its fetch time at hop 1 and never recovered it"); ok = False

        # (2) elided / unfetchable references --------------------------------
        for n, e in elis:
            fail(f"(2) {loc} elided source reference at {name}:{n}: `{e}` — an ellipsis is not "
                 f"a URL; the verifier has to guess the host. Write it in full"); ok = False
        for n, u in urls:
            if not u.lower().startswith("http") and not any(
                    u in d[1] for d in decls.values()):
                fail(f"(2) {loc} scheme-less source reference at {name}:{n}: {u} — write the "
                     f"full https:// URL"); ok = False

        # (3) unattributed load-bearing claims -------------------------------
        unattributed = []
        for n, lab, t in cls:
            if lab in SKIP_LABELS or SDECL.match(t): continue
            for s in sentences(t):
                external = CLAIM_ACTOR.search(s)
                if not external and INTERNAL.search(s): continue
                if not (external or CLAIM_NUM.search(s)
                        or (CLAIM_DATE.search(s) and CLAIM_ACTOR.search(t))):
                    continue
                if ATTRIB.search(s): continue
                unattributed.append((n, s.strip()))
        for n, s in unattributed:
            fail(f"(3) {loc} load-bearing claim with no source pointer at {name}:{n} — tag it "
                 f"[S<n>], [VERIFY …], [obs:…] or [no-source]; an unattributed claim under a "
                 f"sources list is the R3 defect exactly")
            ev("claim: " + (s[:150] + ("…" if len(s) > 150 else "")))
            ok = False

        # (4) named but uncited ----------------------------------------------
        for k in sorted(decls):
            if k not in refs:
                n, rest = decls[k]
                fail(f"(4) {loc} source `S{k}` is declared but NO claim cites it "
                     f"({name}:{n}) — either a claim is missing its pointer, or this source "
                     f"carries nothing this ruling says. R3 named two such URLs and an owner "
                     f"read of both returned none of its claims"); ok = False

        # (5) cited but never named ------------------------------------------
        for k in sorted(refs):
            if k not in decls:
                fail(f"(5) {loc} claim(s) at {name}:{','.join(str(x) for x in refs[k])} cite "
                     f"`[S{k}]` but no `S{k}` is declared in the source list — the ruling "
                     f"points at a source it never names"); ok = False

        # (6) weak evidence must be greppable --------------------------------
        if WEAK.search(body) and not GRADEANY.search(body):
            m = WEAK.search(body)
            fail(f"(6) {loc} uses weak-evidence language ('{m.group(1)}') but declares no "
                 f"canonical read grade — downstream claims drawn from it cannot be found by "
                 f"grep. State 'grade: <{'|'.join(GRADES)}>'"); ok = False

        if ok:
            pas(f"{loc}: {len(decls)} source(s) declared with grade+date, all cited; "
                f"{len(refs)} cited key(s) all declared; no unattributed load-bearing claim")

# (7) anti-vacuity (F15) -----------------------------------------------------
print("")
if TOTAL_BLOCKS == 0:
    fail("(7) parsed ZERO ruling blocks ('## R<n> — …') from the register(s) — format drift or "
         "wrong file; this check compared nothing (F15: a guard must not pass by matching nothing)")
elif TOTAL_OPTED == 0:
    fail(f"(7) {TOTAL_BLOCKS} ruling(s) parsed and NOT ONE names a source URL or states an "
         f"evidence grade — checks 1-6 had no population, so a clean result here would mean "
         f"only that nothing was checked (F15)")
else:
    pas(f"(7) {TOTAL_OPTED} of {TOTAL_BLOCKS} ruling(s) opted into evidence citation and were "
        f"checked; {TOTAL_SRC} source(s) declared, {TOTAL_REF} distinct key(s) cited")

if CENSUS:
    warn(f"{len(CENSUS)} ruling(s) name no source URL and state no evidence grade — this check "
         f"cannot verify them and does NOT fail them (an absence claim is honest with no URL); "
         f"the count is the standing proposal for a sourcing pass")
    for nm, rid, hl, nc in CENSUS:
        ev(f"{nm} {rid} (line {hl}): {nc} load-bearing claim sentence(s), 0 sources")

print("")
print("==============================================")
print(f"Results: {PASS_N} passed, {WARN_N} warnings, {FAIL_N} failed")
if FAIL_N:
    print("citation-divergence-check FAILED — a ruling's claims and its citations have come apart")
    sys.exit(1)
print("citation-divergence-check PASSED" + (" with warnings" if WARN_N else ""))
sys.exit(0)
PY
