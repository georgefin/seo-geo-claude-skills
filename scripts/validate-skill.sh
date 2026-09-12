#!/usr/bin/env bash
# validate-skill.sh — Validate a SKILL.md against the ClawHub, Agent Skills, and Vercel Labs skill specs
# Usage: ./scripts/validate-skill.sh <path-to-skill-directory>
#        ./scripts/validate-skill.sh --probe     # fault injection over scripts/fixtures/validate-skill/
# Example: ./scripts/validate-skill.sh research/keyword-research
#
# ── FAULT INJECTION (--probe), added for G3-C5 ───────────────────────────────────────────────
# Ledger F15's standing rule: a guard that has never been watched failing is not evidence of
# anything. This leg is the first one every skill edit passes through and it had no probe at
# all, so nothing anywhere established that it CAN fail. `--probe` materialises the checked-in
# corpus at scripts/fixtures/validate-skill/ into a temp tree and runs THIS script over each
# case — the same file the gate runs, not a helper extracted from it.
#
# Each case declares its own expected exit code AND a literal its output must contain, because
# F15-r3's lesson is that a right exit code for the wrong reason is how a probe stops measuring.
# Three roles: `positive` (carries a defect, must be reported), `negative` (looks like a defect,
# is legitimate, must NOT be reported), `known-gap` (records behaviour this check gets wrong,
# asserted so it is measured rather than remembered).
#
# It also runs a BRANCH MIRROR: every `fail "` and `warn "` call site in this file's own source
# must be exercised by some case. F15-r4 — a canary per family is not a canary per branch — so a
# branch added later without a fixture makes the probe fail rather than passing in silence.
#
# WHAT THIS PROBE DOES NOT PROVE (state the limit; a probe claiming total coverage is worse
# than one stating a gap):
#   1. That the THRESHOLDS are right. It pins each branch's current boundary, it does not
#      endorse it. Two are known wrong and carried as `known-gap` cases: the body-length WARN
#      fires at >400 while its own message and `validate-tracking.sh` check (d) use 350, and a
#      YAML folded description is misread as 2 characters.
#   2. Anything about the real skill tree. Every case is a synthetic directory; a regression
#      that only shows on a shipped skill's frontmatter is invisible here. G3-C2 (all 20 skills
#      at 15/15/0) is the measurement that covers that, and it is a different run.
#   3. That the frontmatter EXTRACTOR is correct — only that its output reaches each branch.
#      The extractor is line-based grep, not a YAML parser; gap-folded-description.txt is the
#      one instance of that class anyone has measured, not a survey of it.
#   4. Attribution for two warn branches. The two body-length warnings both begin
#      `Skill body is `, so the branch mirror cannot tell them apart; the per-case EXPECT-MATCH
#      lines do, and that is where their separation is actually asserted.
#   5. Anything about how the gate CALLS this script beyond one absolute-path control. The gate
#      passes `$ROOT/$s`; the probe runs one case that way and the rest relatively.
# ─────────────────────────────────────────────────────────────────────────────────────────────

if [ "${1:-}" = "--probe" ]; then
    SELF="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
    FIXDIR="$(dirname "$SELF")/fixtures/validate-skill"
    [ -d "$FIXDIR" ] || { echo "PROBE ERROR: fixture directory missing: $FIXDIR" >&2; exit 2; }

    shopt -s nullglob
    CASES=("$FIXDIR"/*.txt)
    shopt -u nullglob
    # Scope control (F15-r3: a probe that scans nothing must fail, not pass).
    if [ "${#CASES[@]}" -eq 0 ]; then
        echo "PROBE ERROR: no cases in $FIXDIR — a probe with an empty corpus measures nothing" >&2
        exit 2
    fi

    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    ALLOUT="$tmp/.probe-all-output"; : > "$ALLOUT"
    probe_fail=0; n_pos=0; n_neg=0; n_gap=0
    GAPS=""

    head_of() { awk '/^# ---8<---/{exit} {print}' "$1"; }
    body_of() { awk 'f{print} /^# ---8<---/{f=1}' "$1"; }
    dvals()   { head_of "$2" | sed -n "s/^# $1:[[:space:]]*//p"; }   # every value of a directive
    strip_ansi() { sed $'s/\033\\[[0-9;]*m//g'; }

    echo "validate-skill --probe : fault injection over the checked-in case corpus"
    echo "Fixture: $FIXDIR"
    echo "=============================================="

    for f in "${CASES[@]}"; do
        base="$(basename "$f" .txt)"

        # A malformed case is reported, never skipped: a case silently demoted to a comment
        # shrinks the denominator, which is the failure this whole file is about.
        while IFS= read -r line; do
            case "$line" in
                '# CASE:'*|'# ROLE:'*|'# DIR:'*|'# EXPECT-EXIT:'*|'# EXPECT-MATCH:'*) ;;
                '# EXPECT-ABSENT:'*|'# PAD-BODY:'*|'# ADD-FILE:'*|'# NO-SKILL-FILE') ;;
                '# WHY:'*|'# WHY '*|'# GAP:'*) ;;
                '# '[A-Z]*:*) echo "  PROBE FAIL  $base — unknown directive: $line"; probe_fail=1 ;;
                '#'*|'') ;;
                *) echo "  PROBE FAIL  $base — non-comment line before the SKILL.md separator: $line"
                   probe_fail=1 ;;
            esac
        done < <(head_of "$f")

        role="$(dvals ROLE "$f" | head -1)"
        dir="$(dvals DIR "$f" | head -1)"
        want="$(dvals EXPECT-EXIT "$f" | head -1)"
        if [ -z "$dir" ] || [ -z "$want" ] || [ -z "$role" ]; then
            echo "  PROBE FAIL  $base — needs ROLE, DIR and EXPECT-EXIT"; probe_fail=1; continue
        fi
        if [ -z "$(dvals EXPECT-MATCH "$f")" ]; then
            echo "  PROBE FAIL  $base — no EXPECT-MATCH: an exit code alone is a right answer"
            echo "              for a possibly wrong reason (F15-r3)"; probe_fail=1; continue
        fi
        case "$role" in
            positive)  n_pos=$((n_pos + 1)) ;;
            negative)  n_neg=$((n_neg + 1)) ;;
            known-gap) n_gap=$((n_gap + 1))
                       GAPS="$GAPS  [$base] $(dvals GAP "$f" | head -1)
" ;;
            *) echo "  PROBE FAIL  $base — ROLE must be positive|negative|known-gap (got: $role)"
               probe_fail=1; continue ;;
        esac

        # ── materialise ──
        mkdir -p "$tmp/$dir"
        if ! head_of "$f" | grep -q '^# NO-SKILL-FILE$'; then
            body_of "$f" > "$tmp/$dir/SKILL.md"
            pad="$(dvals PAD-BODY "$f" | head -1)"
            if [ -n "$pad" ]; then
                for _i in $(seq 1 "$pad"); do
                    echo "Filler line $_i — padding to exercise a body-length branch."
                done >> "$tmp/$dir/SKILL.md"
            fi
        fi
        while IFS= read -r extra; do
            [ -n "$extra" ] || continue
            mkdir -p "$tmp/$dir/$(dirname "$extra")"
            : > "$tmp/$dir/$extra"
        done < <(dvals ADD-FILE "$f")

        # ── run the real script over the case ──
        # NOT `... | strip_ansi)"; got=$?` — $? after a pipeline is the LAST command's
        # status (sed always exits 0), which made every positive control report
        # "expected exit 1, got 0" on its first run. Capture, then strip.
        raw="$(cd "$tmp" && bash "$SELF" "./$dir" 2>&1)"; got=$?
        out="$(printf '%s\n' "$raw" | strip_ansi)"
        printf '%s\n' "$out" >> "$ALLOUT"

        if [ "$got" -ne "$want" ]; then
            echo "  PROBE FAIL  $base — expected exit $want, got $got"
            printf '%s\n' "$out" | sed 's/^/      | /' | tail -8
            probe_fail=1; continue
        fi
        miss=""
        while IFS= read -r m; do
            [ -n "$m" ] || continue
            printf '%s\n' "$out" | grep -qF -- "$m" || miss="$miss
      missing: $m"
        done < <(dvals EXPECT-MATCH "$f")
        while IFS= read -r a; do
            [ -n "$a" ] || continue
            printf '%s\n' "$out" | grep -qF -- "$a" && miss="$miss
      present but must be absent: $a"
        done < <(dvals EXPECT-ABSENT "$f")
        if [ -n "$miss" ]; then
            echo "  PROBE FAIL  $base — exit $got was right, the output was not:$miss"
            probe_fail=1; continue
        fi
        printf '  ok  %-13s %-32s exit %s · %s\n' "$role" "$base" "$got" \
            "$(printf '%s\n' "$out" | grep -m1 '^Results:' || echo 'no Results line (pre-check exit)')"
    done

    # ── absolute-path control: the gate calls this script with "$ROOT/$s" ──
    abs_raw="$(bash "$SELF" "$tmp/probe-clean-skill" 2>&1)"; abs_rc=$?
    abs_out="$(printf '%s\n' "$abs_raw" | strip_ansi)"
    if [ "$abs_rc" -eq 0 ] && printf '%s\n' "$abs_out" | grep -q '15 passed'; then
        echo "  ok  control       absolute-path invocation         exit 0 · same verdict as relative"
    else
        echo "  PROBE FAIL  absolute-path invocation — the gate calls this script with an absolute"
        echo "              path and this run gave exit $abs_rc:"
        printf '%s\n' "$abs_out" | sed 's/^/      | /' | tail -6
        probe_fail=1
    fi

    # ── branch mirror: every fail()/warn() call site must be exercised ──
    mirror_literals() {   # $1 = fail|warn ; prints the static prefix of each message
        grep -oE "^[[:space:]]*$1 \"[^\"\$]*" "$SELF" \
            | sed -e "s/^[[:space:]]*$1 \"//" -e 's/[[:space:]]*\\$//' -e 's/[[:space:]]*$//'
    }
    echo ""
    echo "BRANCH MIRROR — every fail()/warn() call site in this file must be exercised"
    for grade in fail warn; do
        sites=$(mirror_literals "$grade" | grep -c .)
        uniq_n=0; hit=0; uncovered=""; unmirrorable=""
        while IFS= read -r lit; do
            [ -n "$lit" ] || continue
            uniq_n=$((uniq_n + 1))
            if [ "${#lit}" -lt 6 ]; then
                unmirrorable="$unmirrorable
      begins with a variable, cannot be matched: $lit"
                continue
            fi
            if grep -qF -- "$lit" "$ALLOUT"; then
                hit=$((hit + 1))
            else
                uncovered="$uncovered
      NO fixture exercises: $lit"
            fi
        done < <(mirror_literals "$grade" | sort -u)
        printf '  %s branches: %s of %s distinct messages exercised (%s call sites)\n' \
            "$grade" "$hit" "$uniq_n" "$sites"
        [ -n "$unmirrorable" ] && echo "    limit:$unmirrorable"
        if [ -n "$uncovered" ]; then
            echo "  PROBE FAIL  a $grade branch has no fixture:$uncovered"
            probe_fail=1
        fi
    done

    echo ""
    echo "STATED LIMITS — behaviour this check gets wrong, asserted so it stays measured"
    printf '%s' "$GAPS"
    echo "  (what the probe itself does not prove: head -40 $SELF)"
    echo ""
    if [ "$probe_fail" -eq 0 ]; then
        echo "PROBE PASS — ${#CASES[@]} cases: $n_pos positive, $n_neg negative controls, $n_gap known-gap;"
        echo "             every fail/warn branch exercised; absolute-path control clean."
        exit 0
    fi
    echo "PROBE FAILED"
    exit 1
fi

SKILL_DIR="${1:-.}"
SKILL_FILE="$SKILL_DIR/SKILL.md"

RED='\033[0;31m'
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

PASS=0
FAIL=0
WARN=0

pass() { echo -e "${GREEN}  ✅ PASS${NC}: $1"; PASS=$((PASS + 1)); }
fail() { echo -e "${RED}  ❌ FAIL${NC}: $1"; FAIL=$((FAIL + 1)); }
warn() { echo -e "${YELLOW}  ⚠️  WARN${NC}: $1"; WARN=$((WARN + 1)); }

echo ""
echo "Validating: $SKILL_FILE"
echo "Specs: ClawHub · Agent Skills · Vercel Labs skills ecosystem"
echo "=============================================="

# Check file exists
if [ ! -f "$SKILL_FILE" ]; then
    echo -e "${RED}ERROR${NC}: SKILL.md not found at $SKILL_FILE"
    exit 1
fi

# Extract frontmatter (between first --- and second ---)
FRONTMATTER=$(awk '/^---/{if(++n==2)exit} n' "$SKILL_FILE")

# --- Required field: name ---
# Agent Skills: lowercase, hyphens, ≤64 chars, matches dir name
# ClawHub: slug pattern ^[a-z0-9][a-z0-9-]*$ (slightly more permissive — allows leading digit)
# Vercel Labs: same as Agent Skills
NAME=$(echo "$FRONTMATTER" | grep -E '^name:' | sed 's/name: *//' | tr -d '"'"'" | tr -d '\r')
if [ -z "$NAME" ]; then
    fail "Missing required field: name"
else
    # Agent Skills + Vercel Labs: must start with letter
    if echo "$NAME" | grep -qE '^[a-z][a-z0-9-]*[a-z0-9]$' || echo "$NAME" | grep -qE '^[a-z]$'; then
        if echo "$NAME" | grep -q '\-\-'; then
            fail "name contains consecutive hyphens: $NAME"
        elif [ ${#NAME} -gt 64 ]; then
            fail "name exceeds 64 chars: ${#NAME} chars"
        else
            pass "name is valid (Agent Skills + Vercel Labs): $NAME"
        fi
    else
        fail "name must be lowercase letters, numbers, hyphens only (got: $NAME)"
    fi

    # ClawHub slug check: ^[a-z0-9][a-z0-9-]*$ (no consecutive hyphens implied)
    if echo "$NAME" | grep -qE '^[a-z0-9][a-z0-9-]*$' && ! echo "$NAME" | grep -q '\-\-'; then
        pass "name passes ClawHub slug pattern"
    else
        fail "name fails ClawHub slug pattern ^[a-z0-9][a-z0-9-]*$: $NAME"
    fi

    # Check name matches directory
    DIR_NAME=$(basename "$SKILL_DIR")
    if [ "$NAME" != "$DIR_NAME" ]; then
        fail "name '$NAME' does not match directory '$DIR_NAME'"
    else
        pass "name matches directory name"
    fi
fi

# --- Required field: description ---
DESCRIPTION=$(echo "$FRONTMATTER" | grep -E '^description:' | sed "s/description: *//")
if [ -z "$DESCRIPTION" ]; then
    fail "Missing required field: description"
else
    DESC_LEN=${#DESCRIPTION}
    if [ "$DESC_LEN" -gt 1024 ]; then
        fail "description exceeds 1024 chars: $DESC_LEN chars"
    elif [ "$DESC_LEN" -lt 10 ]; then
        fail "description too short: $DESC_LEN chars"
    else
        pass "description is valid ($DESC_LEN chars)"
    fi

    # Check for trigger phrases pattern
    if echo "$DESCRIPTION" | grep -qiE '"[^"]+"|Use when'; then
        pass "description contains trigger phrases"
    else
        warn "description should include trigger phrases (e.g., 'Use when the user asks to \"...\"')"
    fi
fi

# --- Optional but recommended: license ---
if echo "$FRONTMATTER" | grep -qE '^license:'; then
    LICENSE=$(echo "$FRONTMATTER" | grep -E '^license:' | sed 's/license: *//')
    pass "license present: $LICENSE"
else
    warn "Missing recommended field: license"
fi

# --- Optional but recommended: compatibility ---
if echo "$FRONTMATTER" | grep -qE '^compatibility:'; then
    pass "compatibility field present"
else
    warn "Missing recommended field: compatibility"
fi

# --- Optional but recommended: metadata ---
if echo "$FRONTMATTER" | grep -qE '^metadata:'; then
    pass "metadata block present"
    if echo "$FRONTMATTER" | grep -qE '  author:'; then
        pass "metadata.author present"
    else
        warn "metadata.author not found"
    fi
    if echo "$FRONTMATTER" | grep -qE '  version:'; then
        pass "metadata.version present"
    else
        warn "metadata.version not found"
    fi
    # ClawHub: metadata.openclaw (or metadata.clawdbot / metadata.clawdis)
    # Tool-agnostic skills (no hard dependencies) should omit the openclaw block entirely.
    # If present, check for inconsistencies (primaryEnv declared but requires.env empty).
    if echo "$FRONTMATTER" | grep -qE '  openclaw:|  clawdbot:|  clawdis:'; then
        # Check for primaryEnv + empty requires.env inconsistency
        HAS_PRIMARY_ENV=$(echo "$FRONTMATTER" | grep -qE '    primaryEnv:' && echo "yes" || echo "no")
        HAS_EMPTY_REQ_ENV=$(echo "$FRONTMATTER" | grep -qE '      env: \[\]' && echo "yes" || echo "no")
        if [ "$HAS_PRIMARY_ENV" = "yes" ] && [ "$HAS_EMPTY_REQ_ENV" = "yes" ]; then
            fail "ClawHub: metadata.openclaw declares primaryEnv but requires.env is empty — inconsistent (either add the key to requires.env or remove the openclaw block for tool-agnostic skills)"
        else
            pass "ClawHub: metadata.openclaw runtime declaration present and consistent"
        fi
    else
        pass "ClawHub: no metadata.openclaw block (tool-agnostic skill — OK per AGENTS.md)"
    fi
else
    warn "Missing recommended field: metadata"
fi

# --- Version authority (G1 transitional rule, pilot 2026-08-08) ---
# metadata.version is the single version authority. Two compliant shapes:
#   legacy:       top-level 'version:' present AND equal to metadata.version (lockstep)
#   spec-aligned: top-level 'version:' absent, metadata.version present
#   (Agent Skills spec defines no top-level 'version' frontmatter field.)
TOP_VER=$(echo "$FRONTMATTER" | grep -E '^version:' | sed 's/version: *//' | tr -d '"'"'" | tr -d '\r')
META_VER=$(echo "$FRONTMATTER" | grep -E '^  version:' | sed 's/^  version: *//' | tr -d '"'"'" | tr -d '\r')
if [ -n "$META_VER" ]; then
    if [ -z "$TOP_VER" ]; then
        pass "version authority: spec-aligned (no top-level version; metadata.version $META_VER)"
    elif [ "$TOP_VER" = "$META_VER" ]; then
        pass "version authority: legacy lockstep (top-level version == metadata.version $META_VER)"
    else
        fail "version drift: top-level version '$TOP_VER' != metadata.version '$META_VER' (metadata.version is authoritative — keep legacy lockstep or drop the top-level field)"
    fi
else
    if [ -n "$TOP_VER" ]; then
        fail "top-level version '$TOP_VER' present but metadata.version missing (metadata.version is the version authority — G1 transitional rule)"
    else
        fail "no version anywhere: metadata.version required (version authority — G1 transitional rule)"
    fi
fi

# --- Body length check ---
BODY_LINES=$(awk 'BEGIN{n=0} /^---/{n++; next} n>=2{print}' "$SKILL_FILE" | wc -l | tr -d ' ')
if [ "$BODY_LINES" -gt 400 ]; then
    warn "Skill body is $BODY_LINES lines (recommended: <350 lines / ~4000 tokens). Move reference data to references/ subdirectory."
else
    pass "Skill body length OK: $BODY_LINES lines"
fi

# --- Check for references/ directory if body is large ---
if [ "$BODY_LINES" -gt 250 ] && [ ! -d "$SKILL_DIR/references" ]; then
    warn "Skill body is $BODY_LINES lines but no references/ directory found. Consider extracting detailed tables/rubrics."
fi

# --- ClawHub: file type check (text only, no binaries) ---
NON_TEXT=$(find "$SKILL_DIR" -type f ! -name "*.md" ! -name "*.txt" ! -name "*.json" ! -name "*.yaml" ! -name "*.yml" ! -name "*.sh" ! -name "*.csv" ! -name ".clawhubignore" ! -name ".gitignore" 2>/dev/null | grep -v '/\.' | head -5)
if [ -n "$NON_TEXT" ]; then
    warn "ClawHub: non-text files found (ClawHub only supports text-based files): $NON_TEXT"
else
    pass "ClawHub: all files are text-based"
fi

# --- Vercel Labs: description optimized for 'npx skills find' discovery ---
if echo "$FRONTMATTER" | grep -qE '^description:'; then
    VERCEL_DESC=$(echo "$FRONTMATTER" | grep -E '^description:' | sed "s/description: *//")
    VERCEL_LEN=${#VERCEL_DESC}
    if [ "$VERCEL_LEN" -gt 50 ]; then
        pass "Vercel Labs: description suitable for 'npx skills find' discovery ($VERCEL_LEN chars)"
    else
        warn "Vercel Labs: description may be too short for effective 'npx skills find' discovery"
    fi
fi

# --- Summary ---
echo ""
echo "=============================================="
echo -e "Results: ${GREEN}$PASS passed${NC}, ${YELLOW}$WARN warnings${NC}, ${RED}$FAIL failed${NC}"

if [ "$FAIL" -gt 0 ]; then
    echo -e "${RED}Validation FAILED — fix errors above before publishing${NC}"
    exit 1
elif [ "$WARN" -gt 0 ]; then
    echo -e "${YELLOW}Validation PASSED with warnings — review recommendations above${NC}"
    exit 0
else
    echo -e "${GREEN}Validation PASSED — skill is spec-compliant${NC}"
    exit 0
fi
