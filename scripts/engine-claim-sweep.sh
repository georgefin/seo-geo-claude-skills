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

# SCOPE — state it, because "library-wide" reads as literal and this is not.
# SCANNED: the seven directories below, `*.md` only.
# NOT SCANNED: `docs/**` (registers and loop state — they QUOTE withdrawn claims by design,
# per F11-r6, so scanning them would fight the convention), `evals/**` (excluded in raw() —
# a blind executor must never have expectations surfaced to it), root `README.md`,
# `CLAUDE.md` and `CONNECTORS.md`, and every non-markdown file.
# The three root files were re-checked 2026-08-17 with **all seven families**, scripted rather
# than by hand — the first note here recorded a P1+P5-only check, which is 2 of 5 and prescribed
# a 2-of-5 re-check forever. P7 adds no root-file hit; the count below is unchanged by it.
# All seven over `README.md`, `CLAUDE.md` and `CONNECTORS.md` return **three** hits, none a class
# member: `CONNECTORS.md:61` (P1), `README.md:278` (P2, a trigger-phrase table row), and
# `CONNECTORS.md:24` — `| Reporting | ~~reporting | Google Data Studio, Tableau, Power BI | — |`,
# which **P6 matches as a false positive**: `Google` … then `Power` inside `\bpowers?\b` 29
# characters later. It survives all four adjudication stages. Recorded rather than patterned
# away, because narrowing SUP to miss "Power BI" would also miss "powers". The first version of
# this note said TWO hits — it reported the P1 and P5 hits it had looked for and missed the one
# the new family introduced, which is what a hand-check does when it knows what it expects.
# `CLAUDE.md` returns zero. Re-check with ALL families
# when any of the three grows, or add them to DIRS and re-baseline the residual.
DIRS="build research optimize monitor cross-cutting commands references"

# ── The shape families (seven; P6 added 2026-08-17, P7 the same day) ───────────────────────
# P1-P4 were each complete against their own vocabulary and still missed six class members.
# P5 exists only because the sweeper assumed its list was incomplete and tested that
# assumption: "AI systems prioritize informational answers" matched none of P1-P4, because
# `prioritize` was in no verb list. A verb-list sweep is bounded by its verb list. Widen these
# rather than re-derive them, and expect a widened list to find more.
AG='(AI|LLM|LLMs|engine|engines|systems?|ChatGPT|Perplexity|Gemini|Claude|Google|Copilot|Bing|assistants?|Knowledge Graph|Knowledge Panel|Satori)'

# AG_TOKENS mirrors the alternation above, one entry per branch. It exists so the probe can
# exercise each token INDIVIDUALLY (F15-r4). Kept in lockstep by an assertion in --probe, not
# by discipline — a second hand-maintained copy of AG is precisely what drifted before.
AG_TOKENS='AI LLM LLMs engine engines systems? ChatGPT Perplexity Gemini Claude Google Copilot Bing assistants? Knowledge_Graph Knowledge_Panel Satori'

# Families are built by a FUNCTION rather than assigned once, so that anything needing to vary
# AG (the probe's token-drop check) rebuilds them from the real definitions. The alternative —
# restating P1/P5/P6/P7 at the call site — is the hand-copied-list defect this file already
# paid for once, when a duplicated positive filter silently lost `Copilot` and bare `systems`.
build_families() {

P1="\b$AG\b[^.!?]{0,40}\b(extracts?|prefers?|cites?|trusts?|values?|needs?|uses?|selects?|favou?rs?|rewards?|wants?|understands?|parses?|reads?|weighs?|weights?|ranks?|picks?|chooses?|looks? for|recogni[sz]es?|verif(y|ies)|treats?|relies|rely|deems?|judges?|synthesi[sz]es?|pulls?)\b"
P2='(gets? cited|get picked up|is cited|are cited|be cited|being cited|citation likelihood|citation odds|citation chance|likelihood of citation|more likely to (be )?(cite|get|appear|quote)|chances of (being )?cited)'
P3='(increases?|improves?|boosts?|drives?|influences?|raises?|lifts?|maximi[sz]es?|helps?|makes? it (easier|easy)|enables?|signals? (that|which)|so (that )?(AI|engines?|LLMs?)|for (AI|engines?|LLMs?) to|(AI|engines?|LLMs?) (can|will|won.t|can.t|cannot|may|tends?|typically|often|prioriti|consider)) ?[^.!?]{0,50}\b(cite|cited|citation|citations|AI|selection|visibility|trust|extract|parse|understand|recogni)'
P4="(AI'?s? |engines?'? |LLMs?'? )(source selection|selection|preference|preferences|citation (behaviou?r|preference|selection|criteria|factors?)|trust|attention|confidence|ground truth|comprehension|understanding)|(what|which|how) (AI|engines?|LLMs?) (checks?|wants?|looks?|reads?|sees?|does)|signals? (that |which )?(AI|engines?|LLMs?)|(easy|easier|hard|harder) for (AI|engines?|LLMs?)"
P5="\b$AG\b[^.!?|]{0,45}\b(prioriti[sz]es?|prioriti[sz]e|emphasi[sz]es?|discounts?|penali[sz]es?|ignores?|skips?|surfaces?|elevates?|promotes?|demotes?|filters?|requires?|expects?|assumes?|associates?|remembers?|learns?|infers?|matches?|scores?|ingests?|retrieves?|quotes?|lifts?|summari[sz]es?|attributes?)\b"

# ── P6: the engine as OBJECT, supply arrow reversed ────────────────────────────────────────
# P1-P5 all assume the engine is the grammatical SUBJECT ("Google prefers X"). A class member can
# put it in the object: "Wikidata FEEDS Google Knowledge Graph", "Bing Knowledge Panel: DRIVEN BY
# Wikidata". Same assertion about an undocumented internal mechanic, invisible to all five.
# Found 2026-08-17 by a blind run, exactly where the closure note said to look.
# NOTE it does NOT exclude `|`, unlike P5. Three of its real hits are table rows where the claim
# spans cells — a two-column "source -> what it powers" table IS the supply claim. Excluding the
# pipe is the difference between catching 3 of 4 and 4 of 4.
# Its three alternatives are NAMED, not inlined, so --probe can blank them one at a time.
# F15-r4 measured that two of the four sites P6 was built to catch sat behind alternatives with
# no canary: deleting alternative 2 or 3 passed the probe and silently lost three real hits.
# A canary per family is not a canary per branch.
SUP='(feeds?|powers?|underpins?|backs?|supplies|supply|fuels?|populates?|trains?|informs?|drives?)'
P6a="\b$SUP\b[^.!?]{0,35}\b$AG\b"
P6b="\b$AG\b[^.!?]{0,35}\b$SUP\b"
P6c="\b$AG\b[^.!?]{0,25}(is |are )?(driven|powered|fed|trained|built|backed) by\b"
P6="$P6a|$P6b|$P6c"

# ── P7: the engine inside a FRAMING ADJUNCT, no predicate verb at all ──────────────────────
# P1-P6 all need the engine to be an argument of a verb — subject (P1-P5) or object (P6). A
# class member can put it in a sentence-initial adjunct and make the claim in the main clause,
# where no engine verb ever appears: "According to Google, definition blocks matter most",
# "To an LLM, an unsourced number is worthless", "In Perplexity's view, tables outrank prose".
# Same assertion about an undocumented internal mechanic, invisible to all six.
# NARROWED DELIBERATELY to a comma-closed adjunct. The first draft allowed a bare preposition
# and returned 75 raw hits, almost all "content optimized for AI citation" — which names a GOAL
# (adjudication reason (e)) and is exactly the corrected form this library wants. Requiring the
# comma took it to 2 raw hits, both frontmatter `description:` lines already excused at stage 3.
# MEASURED 2026-08-17 over the seven DIRS: raw +2, **residual +0**, and it catches 6 of 6
# constructed prepositional shapes. A family that adds no noise is the only kind worth adding.
P7="(^|[.!?] +|^[^:]*:[0-9]+: *(- |\* |[0-9]+\. )?)(According to|In|To|For|Within|Among|From) (an? |the )?[^,.!?]{0,20}\b$AG\b('s)?[^,.!?]{0,20}, +[a-z]"

# ── KNOWN ESCAPES — shapes ruled ON and DECLINED, each with the measurement that declined it ─
# Recorded here, not omitted, because the next sweeper will re-derive them and needs to know
# they were considered. A shape absent from this file reads as a shape nobody thought of.
#
#   (i) COPULAR / NOMINAL PREDICATION — "Schema is how engines know what your page is about",
#       "Statistics are a strong citation signal for LLMs", "A quotable sentence is the unit of
#       AI citation". Real class members: they assert an engine disposition with no engine verb.
#       Of four shapes constructed for this ruling, ONE — "Definition blocks are what Google
#       rewards" — turns out to be caught already, by P1, because `rewards` is in P1's verb
#       list. The header first recorded all four as escaping; the probe's declined-shape check
#       contradicted it on its first run. Three genuinely escape, and those three are the
#       declined set.
#       DECLINED 2026-08-17 on measurement, not on principle. The drafted regex caught 2 of the
#       3 genuine escapes and contributed **+1 to the residual over the real tree — a false
#       positive**: `analysis-templates.md:171`, "Add FAQPage markup only where FAQPage is the
#       page's one primary type", which is ruling-R2 guidance the library wants. A broader form
#       fired on the DEFINITION OF SEO ("Search Engine Optimization **is a** practice…", 17 hits)
#       because `engine` sits inside the term this whole library is about. True-to-false on the
#       real tree was 0:4. This file's stated failure mode is punishing a corrected line, at a
#       recorded cost four times in this repo's history; a family whose only measured effect is
#       to do that is not an improvement. Re-open it when a real instance appears — the four
#       shapes are in the probe's DECLINED canary block, so the day one lands, the
#       shapes are already written.
#
#  (ii) GREEK — every verb list above is English-only, so all six pre-P7 families and P7 itself
#       miss «Η Google προτιμά σελίδες με σαφή ορισμό στην αρχή.», which is P1's exact defect in
#       the language half this library's deliverables are written in. ROUTED, not declined:
#       measured 2026-08-17, the seven DIRS contain **7 Greek-carrying files outside evals/ and
#       zero Greek engine-claims** — the Greek there is anti-slop vocabulary rows, keyword
#       transliteration tables and label examples. Greek engine-claims are not in the repo
#       because Greek deliverables are not in the repo: they are produced at run time. Scanning
#       repo text for them would report a clean residual for a surface this instrument never
#       sees, which is the exact failure the header above was written to prevent. The rule is
#       carried where the Greek surface is actually governed — anti-slop-ruleset.md §6, which
#       is already bilingual and is graded by the Greek editor. See that file's family 9.
#       A Greek branch here would additionally have no locale it could run in: measured in this
#       environment (GNU grep 3.11), `grep -P '[\x{0370}-\x{03FF}]'` **exits 2** under C, POSIX
#       *and* en_US.UTF-8, working only under C.UTF-8, while the POSIX range `[α-ω]` does the
#       exact opposite — matches by byte under C/POSIX/en_US.UTF-8 and aborts under C.UTF-8.
#       The two methods fail in complementary locales and **there is no locale in which both
#       work**. The first Greek census run for this ruling used the PCRE form and reported
#       "0 files carry Greek" when 30 do; it was caught only by cross-checking with fixed
#       strings. Any Greek matching in this repo uses fixed literals. Never a range.

FAMILIES=("$P1" "$P2" "$P3" "$P4" "$P5" "$P6" "$P7")
}
build_families

raw() {
  local i
  for i in "${!FAMILIES[@]}"; do
    [ -z "${FAMILIES[$i]}" ] && continue
    grep -rn -i -E "${FAMILIES[$i]}" --include="*.md" $DIRS
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
    # F15 discipline, THIRD attempt, and the history is the specification.
    #   v1 passed on all 7 of a reviewer's mutations, including DIRS="nonexistent".
    #   v2 caught those 7 and still missed 10 of 26 on a wider set. Two structural causes,
    #     both named by Mode A and both fixed here:
    #     (a) the canaries were NOT exclusive — L3 matched P1 *and* P3, so P3 had no canary of
    #         its own and gutting P3 still left the count at 6;
    #     (b) NO canary traversed the full pipeline — they were counted in raw()'s output,
    #         BEFORE adjudicate(), so any widening of an excuse that missed one synthetic
    #         line was invisible. Re-introducing the historical positive-filter defect
    #         collapsed the residual to 1 while the probe printed PASS.
    # So: every canary is exclusive to one family, every canary is checked in the FINAL
    # output, and each family is blanked in turn to prove it is load-bearing.
    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    mkdir -p "$tmp/research/probe" "$tmp/build/probe/evals"
    fail=0

    # One canary per family, each verified to match EXACTLY ONE family AND to carry an engine
    # token. The token is not decoration: the final positive filter drops any line without one,
    # so a canary lacking it never reaches the output and the exclusivity check reads as a
    # broken family. v3's first draft used "content gets cited far more often" and "improves the
    # chance of citation" for P2 and P3 — both perfectly good class shapes, both tokenless, both
    # silently swallowed. The probe caught that on its first run, which is the point of checking
    # the FINAL output rather than raw().
    cat > "$tmp/research/probe/canary.md" <<'CANARY'
ChatGPT extracts the first 40 words of the page.
Content in this shape is cited by Perplexity far more often than prose.
Adding statistics improves the chance of AI citation.
What AI checks first is the opening paragraph.
Copilot prioritizes pages with a clear definition block.
Wikidata feeds the Knowledge Graph.
According to Google, definition blocks matter most.
CANARY

    # AG-TOKEN CANARIES (F15-r4). The family canaries above exercise five of AG's seventeen
    # branches. Measured 2026-08-17 over the real tree, dropping `Google` from AG takes the
    # residual 59 -> 48, dropping `AI` takes it to 39, dropping `engine` to 51 — and the probe
    # passed through every one of those, because no canary named those tokens. A component list
    # gets the same treatment as a family list: one canary per branch, each load-bearing.
    # Five branches (ChatGPT, Perplexity, Gemini, LLM, LLMs) contribute 0 to the real residual
    # and are canaried anyway — a token carrying nothing today is exactly the token a future
    # narrowing deletes without noticing.
    : > "$tmp/research/probe/agcanary.md"
    for t in $AG_TOKENS; do
      printf '%s prefers tables over prose.\n' "$(printf '%s' "$t" | tr '_' ' ' | sed 's/?$//')" \
        >> "$tmp/research/probe/agcanary.md"
    done

    # P6 BRANCH CANARIES (F15-r4, second half). One line per named alternative, each matching
    # exactly one of them and no other family.
    cat > "$tmp/research/probe/branchcanary.md" <<'BRANCH'
Structured data populates the Knowledge Panel.
The Knowledge Graph informs the answer box.
The Knowledge Panel is powered by Wikidata.
BRANCH

    # DECLINED SHAPES (see "KNOWN ESCAPES" (i) above). These are real class members that no
    # family catches, recorded so the shapes are not re-derived from scratch. The probe does not
    # fail on them — it NOTES if one starts being caught, which means a new family landed and
    # the header's declined-with-measurement note is now stale and must be rewritten.
    cat > "$tmp/research/probe/declined.md" <<'DECLINED'
Schema is how engines know what your page is about.
Statistics are a strong citation signal for LLMs.
A quotable sentence is the unit of AI citation.
DECLINED
    ndecw=3
    printf 'Gemini prefers listicles above all else.\n' > "$tmp/build/probe/evals/evals.md"
    printf 'Perplexity trusts .edu domains most.\n'     > "$tmp/build/probe/notmarkdown.txt"

    ORIG_DIRS="$DIRS"; ORIG=("${FAMILIES[@]}")
    cd "$tmp" || exit 2; DIRS="research build"

    # (1) EXCLUSIVITY + LOAD-BEARING: blanking family N must drop EXACTLY ONE canary from the
    #     FINAL output. Fewer means that family had no canary of its own (v2's P3 bug);
    #     more means a canary is not exclusive and the count cannot localise a break.
    nfam=${#ORIG[@]}
    base=$(raw | adjudicate | grep -c 'probe/canary\.md' || true)
    [ "$base" -eq "$nfam" ] || { echo "PROBE FAIL — $base/$nfam canaries reach the FINAL output"; fail=1; }
    for n in $(seq 0 $((nfam - 1))); do
      FAMILIES=("${ORIG[@]}"); FAMILIES[$n]=""
      got=$(raw | adjudicate | grep -c 'probe/canary\.md' || true)
      if [ "$got" -ne $((base - 1)) ]; then
        echo "PROBE FAIL — blanking P$((n+1)) changed the count $base -> $got (expected $((base-1))); that family has no exclusive canary"
        fail=1
      fi
    done
    FAMILIES=("${ORIG[@]}")

    # (1b) AG-TOKEN LOAD-BEARING (F15-r4). Same treatment for the shared token list: drop each
    #      branch of AG in turn and require exactly one AG-canary to fall out. Families are
    #      REBUILT from the modified AG via build_families() rather than restated here.
    AG_ORIG="$AG"
    ntok=$(printf '%s\n' $AG_TOKENS | grep -c '')
    agbase=$(raw | adjudicate | grep -c 'probe/agcanary\.md' || true)
    if [ "$agbase" -ne "$ntok" ]; then
      echo "PROBE FAIL — $agbase/$ntok AG-token canaries reach the FINAL output; AG_TOKENS and AG disagree"
      fail=1
    fi
    for t in $AG_TOKENS; do
      lit="$(printf '%s' "$t" | tr '_' ' ')"
      # `?` is an ERE quantifier, so an unescaped `systems?` asks sed for "system"/"systems" —
      # neither of which is in AG, whose literal text is `systems?`. The probe's own first run
      # reported both optional-plural branches as drift. Escape before matching.
      esc="$(printf '%s' "$lit" | sed 's/[^A-Za-z0-9 ]/\\&/g')"
      AG="$(printf '%s' "$AG_ORIG" | sed -E "s/\|${esc}\|/|/; t; s/\(${esc}\|/(/; t; s/\|${esc}\)/)/")"
      if [ "$AG" = "$AG_ORIG" ]; then
        echo "PROBE FAIL — AG_TOKENS lists '$lit' but it is not a branch of AG; the mirror has drifted"
        fail=1; AG="$AG_ORIG"; build_families; continue
      fi
      build_families
      got=$(raw | adjudicate | grep -c 'probe/agcanary\.md' || true)
      [ "$got" -eq $((agbase - 1)) ] || {
        echo "PROBE FAIL — dropping AG branch '$lit' changed the count $agbase -> $got (expected $((agbase-1))); that token has no exclusive canary"
        fail=1; }
      AG="$AG_ORIG"; build_families
    done
    ORIG=("${FAMILIES[@]}")

    # (1b2) P6 BRANCH LOAD-BEARING (F15-r4, second half): blank each named alternative in turn
    #       and require exactly one branch canary to fall out.
    brbase=$(raw | adjudicate | grep -c 'probe/branchcanary\.md' || true)
    [ "$brbase" -eq 3 ] || { echo "PROBE FAIL — $brbase/3 P6 branch canaries reach the FINAL output"; fail=1; }
    P6a_O="$P6a"; P6b_O="$P6b"; P6c_O="$P6c"
    for b in a b c; do
      P6a="$P6a_O"; P6b="$P6b_O"; P6c="$P6c_O"
      case "$b" in a) P6a="(?!)x^" ;; b) P6b="(?!)x^" ;; c) P6c="(?!)x^" ;; esac
      FAMILIES[5]="$P6a|$P6b|$P6c"
      got=$(raw | adjudicate | grep -c 'probe/branchcanary\.md' || true)
      [ "$got" -eq $((brbase - 1)) ] || {
        echo "PROBE FAIL — neutering P6 alternative $b changed the count $brbase -> $got (expected $((brbase-1))); that alternative has no exclusive canary"
        fail=1; }
    done
    P6a="$P6a_O"; P6b="$P6b_O"; P6c="$P6c_O"; FAMILIES=("${ORIG[@]}")

    # (1c) DECLINED SHAPES: advisory. Not a failure either way — a NOTE that the header is stale.
    ndec=$(raw | adjudicate | grep -c 'probe/declined\.md' || true)
    [ "$ndec" -eq 0 ] && dec_msg="0/$ndecw declined shapes caught (matches the KNOWN ESCAPES (i) note)" \
                      || dec_msg="NOTE — $ndec/$ndecw declined shapes are now CAUGHT; rewrite the KNOWN ESCAPES (i) note, it is stale"

    # (2) PIPELINE INTEGRITY: the exclusions are part of the net, not decoration.
    raw | grep -q '/evals/'   && { echo "PROBE FAIL — /evals/ exclusion not applied"; fail=1; }
    raw | grep -q 'notmarkdown' && { echo "PROBE FAIL — non-markdown file scanned"; fail=1; }
    cd - >/dev/null || exit 2

    # (3) NEGATIVE CONTROL: a line this library WANTS must be excused.
    if printf 'x.md:1:- Helps Google understand site structure\n' | adjudicate | grep -q .; then
      echo "PROBE FAIL — adjudication let a wanted line through as a finding"; fail=1
    fi

    # (4) SCOPE CONTROL: DIRS must be the intended set, not merely a set that exists.
    #     v2 asserted only that each entry was a directory, so DIRS="scripts" passed while the
    #     sweep reported raw 1 -> RESIDUAL 1, and DIRS="build research" passed at residual 24.
    DIRS="$ORIG_DIRS"
    [ "$DIRS" = "build research optimize monitor cross-cutting commands references" ] || {
      echo "PROBE FAIL — DIRS is not the declared scope; the header's scope note is now false"; fail=1; }
    for d in $DIRS; do [ -d "$d" ] || { echo "PROBE FAIL — DIRS names a missing directory: $d"; fail=1; }; done
    [ "$(raw | grep -c '')" -gt 0 ] || { echo "PROBE FAIL — raw() returned 0 over the real tree"; fail=1; }

    if [ "$fail" -eq 0 ]; then
      echo "PROBE PASS — $base/$nfam exclusive family canaries, $agbase/$ntok exclusive AG-token canaries"
      echo "             and $brbase/3 exclusive P6-alternative canaries through the full pipeline, each"
      echo "             load-bearing; exclusions applied, wanted line excused, DIRS equals the scope."
      echo "             $dec_msg"
      echo
      echo "WHAT THIS PROBE DOES NOT PROTECT (state it, per F15-r4):"
      echo "  · The VERB LISTS inside P1, P3, P4 and P5 are unguarded at branch level. Each family"
      echo "    has one canary exercising one verb; deleting any other verb passes. P6 is guarded"
      echo "    per alternative because it has three structurally distinct ones, not because verb"
      echo "    coverage was solved. A canary per verb would be ~90 canaries testing a list that is"
      echo "    known-incomplete by construction — P5 exists only because P1-P4's lists were."
      echo "  · The ADJUDICATED / MARKERS / SHAPES / MEASURED excuse lists are guarded by exactly"
      echo "    one negative control. Widening any of them to swallow a real finding passes."
      echo "  · Nothing here validates that a residual line IS a defect. This script narrows."
    else
      echo "PROBE FAILED"; exit 1
    fi
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
