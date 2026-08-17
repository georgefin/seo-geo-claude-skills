#!/usr/bin/env bash
# engine-claim-sweep.sh — the reproducible closure check for the engine-claim class
# (ruling R3 amendment 9a: no primary source establishes what an engine cites, in either
# direction, so this library may not assert an engine disposition as fact).
#
# WHY THIS FILE EXISTS. The 2026-08-17 sweep of this class reported "residual: 5" and named a
# script as its runnable basis. Re-run at the same commit, that script returned 134 lines, a
# sibling returned 39, and only 1 of the 5 quoted residual lines appeared in either — the
# number came from a sixth command that was never saved. The fixes were real and validated;
# the closure evidence was not reproducible. A closure number that cannot be re-derived is
# indistinguishable from a regression the next time someone checks, so the number lives here.
#
# ADVISORY. Not wired into pre-push-gate.sh. Its failure mode is punishing a corrected line
# (see the ADJUDICATED list below — every entry is a line this library WANTS), and that has
# been the recorded cost four times in this repo's history. It earns veto power after humans
# have read its output for a week, not before.
#
# Usage:
#   bash scripts/engine-claim-sweep.sh           # report residual
#   bash scripts/engine-claim-sweep.sh --raw     # every hit, pre-adjudication
#   bash scripts/engine-claim-sweep.sh --probe   # fault-injection: prove it still fires

set -uo pipefail
cd "$(dirname "$0")/.." || exit 2

DIRS="build research optimize monitor cross-cutting commands references"

# ── The five shape families ────────────────────────────────────────────────────────────────
# P1-P4 were each complete against their own vocabulary and still missed six class members.
# P5 exists only because the sweeper assumed its list was incomplete and tested that
# assumption: "AI systems prioritize informational answers" matched none of P1-P4, because
# `prioritize` was in no verb list. A verb-list sweep is bounded by its verb list. Widen these
# rather than re-derive them, and expect a widened list to find more.
AG='(AI|LLM|LLMs|engine|engines|systems?|ChatGPT|Perplexity|Gemini|Claude|Google|Copilot|Bing|assistants?)'

P1="\b$AG\b[^.!?]{0,40}\b(extracts?|prefers?|cites?|trusts?|values?|needs?|uses?|selects?|favou?rs?|rewards?|wants?|understands?|parses?|reads?|weighs?|weights?|ranks?|picks?|chooses?|looks? for|recogni[sz]es?|verif(y|ies)|treats?|relies|rely|deems?|judges?|synthesi[sz]es?|pulls?)\b"
P2='(gets? cited|get picked up|is cited|are cited|be cited|being cited|citation likelihood|citation odds|citation chance|likelihood of citation|more likely to (be )?(cite|get|appear|quote)|chances of (being )?cited)'
P3='(increases?|improves?|boosts?|drives?|influences?|raises?|lifts?|maximi[sz]es?|helps?|makes? it (easier|easy)|enables?|signals? (that|which)|so (that )?(AI|engines?|LLMs?)|for (AI|engines?|LLMs?) to|(AI|engines?|LLMs?) (can|will|won.t|can.t|cannot|may|tends?|typically|often|prioriti|consider)) ?[^.!?]{0,50}\b(cite|cited|citation|citations|AI|selection|visibility|trust|extract|parse|understand|recogni)'
P4="(AI'?s? |engines?'? |LLMs?'? )(source selection|selection|preference|preferences|citation (behaviou?r|preference|selection|criteria|factors?)|trust|attention|confidence|ground truth|comprehension|understanding)|(what|which|how) (AI|engines?|LLMs?) (checks?|wants?|looks?|reads?|sees?|does)|signals? (that |which )?(AI|engines?|LLMs?)|(easy|easier|hard|harder) for (AI|engines?|LLMs?)"
P5="\b$AG\b[^.!?|]{0,45}\b(prioriti[sz]es?|prioriti[sz]e|emphasi[sz]es?|discounts?|penali[sz]es?|ignores?|skips?|surfaces?|elevates?|promotes?|demotes?|filters?|requires?|expects?|assumes?|associates?|remembers?|learns?|infers?|matches?|scores?|ingests?|retrieves?|quotes?|lifts?|summari[sz]es?|attributes?)\b"

raw() {
  for p in "$P1" "$P2" "$P3" "$P4" "$P5"; do
    grep -rn -i -E "$p" --include="*.md" $DIRS
  done 2>/dev/null | grep -v "/evals/" | sort -u -t: -k1,1 -k2,2n
}

# ── Adjudication, stage 1: by in-text marker ───────────────────────────────────────────────
# A line carrying one of these is this library retracting, hedging or sourcing a claim rather
# than asserting one. F11-r6 fixed the convention that a withdrawn sentence is QUOTED where it
# stood rather than deleted — so the retraction notes match the very patterns above, by design.
MARKERS='ruling R[0-9]|amendment 9a|\[VERIFY|no engine (publishes|documents)|previously|withdrawn|Renamed|working model|working bet|evidence grade|Evidence grade|observational|never (an|a|by an) asserted|never a prediction|is not a sentence this library|not documented engine'

# ── Adjudication, stage 2: named lines, each with its reason ───────────────────────────────
# Every entry below is a line this library WANTS as written. Keyed by a distinguishing
# substring, not a line number, so an insertion above does not silently un-adjudicate it.
# Reasons are grouped; add to this list only with the reason stated.
#
#   (a) GOOGLE-DOCUMENTED MECHANIC — Google publishes it, so it is not an unsourced engine
#       claim. serp-feature-taxonomy.md:426 states this boundary in-file.
#   (b) QUESTION, not assertion.
#   (c) DENIES observability — the corrected form, the opposite of the defect.
#   (d) THE USER'S OWN WORDS — a trigger phrase or an example prompt in a How-to-Use fence.
#   (e) NAMES A GOAL OR A TEXT PROPERTY, asserts no engine disposition. The line drawn:
#       "for AI comprehension" names what the text is for; "more likely to be quoted by AI"
#       asserts a disposition and was rewritten.
#   (f) NOT ABOUT AN ENGINE — about users, about an article citing sources, or a SERP
#       observation recorded as seen.
ADJUDICATED='
Help Google understand your entity
Helps Google understand site structure
Google needs CSS/JS to render pages properly
Google treats nofollow as a "hint"
Google may treat long-standing 302s as 301s
Google may rewrite your title
Google may pick wrong page
Entity name as Google understands it
documented format requirements
Should AI engines cite this source?
is not observable from page copy
eligibility is not an appearance
Structuring content for AI comprehension
Formats content for AI comprehension
Make this article more likely to be cited by AI systems
AI users clicking sources
Article cites one Google documentation page
Lists steps, cites 3 sources
does BestPrice itself rank in Google
Google manual action or deindexing
the CITE items count where it was actually quoted
AI-Crawler Stances
Search indexing and AI citations wanted
'

# ── Adjudication, stage 3: by line SHAPE ───────────────────────────────────────────────────
# (g) A quoted string, a blockquote, a frontmatter `description:`, or a trigger phrase is
#     example copy or the user's own words — never this library asserting anything. This is
#     the single largest excusing class and the easiest to get wrong, so it is shape-based
#     rather than substring-based.
#     A line-initial quote excuses the line ONLY if the line is wholly quoted. The earlier form
#     excused everything after the closing quote too, so `- "Google prefers X" and that is why
#     you must republish monthly.` passed whole — channel (a), a phantom quote span, the same
#     defect an apostrophe opened in the citation guard on the same day.
SHAPES='^[^:]*:[0-9]+: *(- )?"[^"]*"?[[:space:]]*$|^[^:]*:[0-9]+:> |^[^:]*:[0-9]+:\*\*Citation likelihood\*\*|^[^:]*:[0-9]+: *description: '

# ── Adjudication, stage 4: measurement vocabulary ──────────────────────────────────────────
# (h) COUNTS AND DEFINITIONS, not dispositions. "Percentage of monitored queries where your
#     content is cited" defines a metric you go and measure; it predicts nothing. R3-9a bars
#     asserting what an engine WILL do, never recording what was observed.
MEASURED='citation rate|citation slot|citation frequency|citation checking|citation proof|citation placement|Queries where you are cited|Cited by >=|Cited on 0|Cited by 0|Count distinct engines|cited in AI-generated|no longer being cited|may be cited|is cited to|cite source|cite methodology|cite sources|which queries cite them|queries cite|AI Citation Frequency|Increase citations|cited by the Overview|Cites Entity|recogni[sz]es entity|recognize \[entity|AI recognition|not observable|never Confirmed|cannot prove|why the engine ranks|Can AI and readers'

adjudicate() {
  local out
  out="$(cat)"
  out="$(printf '%s\n' "$out" | grep -v -i -E "$MARKERS")"
  while IFS= read -r sub; do
    [ -z "$sub" ] && continue
    out="$(printf '%s\n' "$out" | grep -vF "$sub")"
  done <<< "$ADJUDICATED"
  out="$(printf '%s\n' "$out" | grep -v -i -E "$SHAPES")"
  out="$(printf '%s\n' "$out" | grep -v -i -E "$MEASURED")"
  # Positive filter last: a hit with no engine token in the line cannot be an engine claim.
  # (P3 can match on "improves ... visibility" alone, which is ordinary SEO prose.)
  # Positive filter reuses $AG rather than restating it. A hand-copied second list drifted
  # from AG and silently dropped `Copilot` and bare `systems` — Mode A walked two canaries
  # through the gap. This is family 8's own lesson: exercise each component, not the whole.
  out="$(printf '%s\n' "$out" | grep -i -E "$AG")"
  printf '%s\n' "$out" | grep -v '^$'
}

case "${1:-}" in
  --raw)
    raw
    printf '\n######## RAW HITS: %d ########\n' "$(raw | grep -c '')"
    ;;
  --probe)
    # F15 discipline, second attempt. The FIRST version of this probe passed on every mutation
    # Mode A threw at it — including `DIRS="nonexistent-dir"`, where the sweep reported
    # `raw 0 -> RESIDUAL: 0` and the probe printed two PASS lines and exited 0, so a scan of
    # zero files read as a perfectly closed class. Two structural reasons, both fixed here:
    #   * it grepped $P5 DIRECTLY instead of running raw(), so it exercised 1 of 5 families and
    #     tested neither DIRS, nor --include, nor the /evals/ exclusion, nor the dedup;
    #   * its only adjudication assertion was a NEGATIVE control, which passes when the stage
    #     prints nothing. Nothing checked that a real member SURVIVES. That is F15's title
    #     sentence — "passed by matching nothing" — inside a script whose header cites F15.
    # Every assertion below runs the FULL pipeline over a temp tree, and the per-family hit
    # rate is printed so a reader sees coverage rather than a bare PASS.
    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    mkdir -p "$tmp/research/probe" "$tmp/build/probe/evals"
    fail=0

    # One canary per family: each is a real class member, phrased to need that family.
    cat > "$tmp/research/probe/canary.md" <<'CANARY'
ChatGPT extracts the first 40 words of any page it answers from.
Well-structured content gets cited far more often than prose.
Adding statistics increases the chance AI will cite the page.
What AI checks first is the opening paragraph.
Copilot prioritizes pages with a clear definition block.
Retrieval systems prefer concise answers over long ones.
CANARY
    # Must be ignored: the /evals/ exclusion and the *.md include are part of the pipeline.
    printf 'Gemini prefers listicles above all else.\n' > "$tmp/build/probe/evals/evals.md"
    printf 'Perplexity trusts .edu domains most.\n'     > "$tmp/build/probe/notmarkdown.txt"

    ORIG_DIRS="$DIRS"; cd "$tmp" || exit 2; DIRS="research build"
    got="$(raw)"
    cd - >/dev/null || exit 2

    n_can=$(printf '%s\n' "$got" | grep -c 'probe/canary\.md' || true)
    echo "  families: 6 canaries planted, $n_can matched by raw() — one per shape family"
    [ "$n_can" -ge 6 ] || { echo "PROBE FAIL — $n_can/6 canaries caught; a family's net is broken"; fail=1; }
    printf '%s\n' "$got" | grep -q '/evals/' && { echo "PROBE FAIL — /evals/ exclusion not applied"; fail=1; }
    printf '%s\n' "$got" | grep -q 'notmarkdown' && { echo "PROBE FAIL — non-markdown file scanned"; fail=1; }

    # POSITIVE CONTROL — the assertion the first probe lacked. A real class member must
    # SURVIVE all four adjudication stages and appear in the final output.
    if printf 'x.md:1:ChatGPT extracts the first 40 words of any page it answers from.\n' \
       | adjudicate | grep -q 'ChatGPT extracts'; then
      echo "  positive control: a class member survives adjudication — PASS"
    else
      echo "PROBE FAIL — adjudication swallowed a known class member; excuses are too broad"; fail=1
    fi

    # NEGATIVE CONTROL — a line this library wants must be excused.
    if printf 'x.md:1:- Helps Google understand site structure\n' | adjudicate | grep -q .; then
      echo "PROBE FAIL — adjudication let a wanted line through as a finding"; fail=1
    else
      echo "  negative control: a Google-documented mechanic is excused — PASS"
    fi

    # SCOPE CONTROL — the DIRS="nonexistent-dir" mutation. raw() over the real tree must
    # return something; zero means the scan found no files, not that the class is closed.
    DIRS="$ORIG_DIRS"
    [ "$(raw | grep -c '')" -gt 0 ] || { echo "PROBE FAIL — raw() returned 0 over the real tree; DIRS is wrong, not the class clean"; fail=1; }
    for d in $DIRS; do [ -d "$d" ] || { echo "PROBE FAIL — DIRS names a missing directory: $d"; fail=1; }; done

    [ "$fail" -eq 0 ] && echo "PROBE PASS — all controls held" || { echo "PROBE FAILED"; exit 1; }
    ;;
  *)
    r="$(raw | grep -c '')"
    res="$(raw | adjudicate)"
    n="$(printf '%s' "$res" | grep -c '' || true)"
    [ -z "$res" ] && n=0
    [ "$n" -gt 0 ] && printf '%s\n' "$res"
    printf '\n######## raw %d → adjudicated → RESIDUAL: %d ########\n' "$r" "$n"
    echo "Every excused line is named in ADJUDICATED above, with its reason. Residual lines are"
    echo "NOT automatically defects — read each one. This script narrows; it does not rule."
    ;;
esac
