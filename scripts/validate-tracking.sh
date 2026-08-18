#!/usr/bin/env bash
# validate-tracking.sh — Repo-level consistency gate for seo-geo-claude-skills
#
# Complements scripts/validate-skill.sh (which validates ONE skill in isolation)
# by checking the cross-file invariants that CLAUDE.md "Contribution Rules"
# demand but nothing enforces: version sync across the tracking files, the
# plugin.json skills manifest vs the directories on disk, VERSIONS.md rows vs
# SKILL.md frontmatter, the 350-line body cap, and references/ link integrity.
#
# Usage:   ./validate-tracking.sh [repo-root]     (default: .)
#          ./validate-tracking.sh --probe [repo-root]
#              Fault-injection for check (f), against two checked-in corpora: its two allowlists
#              (scripts/fixtures/r3-allowlist/) and its R3-overstatement leg, whose cases are
#              multi-line because the defect that beat it was a phrase with a break inside it
#              (scripts/fixtures/r3-overstate/). Prints caught/missed per corpus and FAILS when a
#              violation is excused. See the probe block below check (f) for why it exists.
#          ./validate-tracking.sh --emit-f-patterns [repo-root]
#              Prints check (f)'s pattern surface as `NAME<TAB>value` lines, for the guards that
#              apply those patterns to surfaces check (f) cannot reach. This is an ACCESSOR, not a
#              verdict: it exits 0 whatever the tree contains and prints nothing else on stdout.
#              See "THE PATTERN SURFACE IS AN EXPORT" below.
# Exit:    0 = all checks pass (warnings allowed), 1 = any FAIL, 2 = usage/setup error
# No network access. Dependencies: bash, coreutils, grep, sed, awk, sort, comm, cmp (diffutils).

set -u

# --probe runs the same script: the point of the probe is to measure the allowlists check (f)
# actually enforces, so it must read the same variables, not a copy of them (engine-claim-sweep's
# own recorded lesson — its hand-copied second pattern list drifted and two canaries walked
# through the gap). Those variables are assigned inside check (f), where their history is
# written, so the probe runs AFTER it and stdout is parked until then. Checks (a)-(f) do execute;
# their output is suppressed, and their FAIL count is printed in the probe header so a probe can
# never report health while the validator it lives in is broken.
#
# THE PATTERN SURFACE IS AN EXPORT (--emit-f-patterns, 2026-08-17, OPEN-FINDINGS 100).
# The lesson above had to be learned a second time, one directory over.
# `scripts/eval-expectation-sweep.sh` applies check (f)'s classes to a surface check (f) cannot
# reach (eval expectations, which `grep -v 'evals/'` removes from every sweep here), and it did
# that by HAND-COPYING the pattern strings under a standing "keep them copied, not re-invented"
# comment. The copy fossilised at the pre-word-bounding spelling. Measured 2026-08-17: the
# sentence "The FAQPage block is eligible for FAQ rich results, as recommended in the brief."
# was CAUGHT here and EXEMPTED there, because `ended` is a substring of *recommended* and the
# sweep still carried the unbounded member this file fixed in 8f69a7a. A copy kept in sync by a
# comment is not kept in sync — it is the third instance of that class in this repo (a duplicated
# positive filter that lost two tokens; a duplicated AG list that drifted; this).
#
# So the patterns are EXPORTED from here and IMPORTED there, and two things make that binding
# rather than aspirational:
#   * `--probe` asserts the export is COMPLETE — every pattern variable in this file's own source
#     is emitted — so a pattern added later cannot be silently left unexported;
#   * the importer FAILS HARD when the export is missing or short, and never falls back to a
#     local copy. A fallback copy is the defect wearing a safety belt.
# What the importer may legitimately do to an imported pattern is documented at its call site: it
# greps 800-character sentences, not 85-character markdown lines, so the token regex is bounded by
# a mechanical, asserted transform. Members are NEVER edited downstream; extra members are added
# in a separately named set so the derived part stays byte-comparable to what is emitted here.
PROBE=0
EMIT=0
case "${1:-}" in
    --probe)           PROBE=1; shift ;;
    --emit-f-patterns) EMIT=1;  shift ;;
esac

ROOT="${1:-.}"

if [ ! -d "$ROOT" ]; then
    echo "ERROR: repo root '$ROOT' is not a directory" >&2
    exit 2
fi
# Normalize to an absolute path so output is unambiguous regardless of caller cwd.
ROOT="$(cd "$ROOT" && pwd)"

PLUGIN_JSON="$ROOT/.claude-plugin/plugin.json"
MARKETPLACE_JSON="$ROOT/marketplace.json"
README="$ROOT/README.md"
VERSIONS="$ROOT/VERSIONS.md"
CATEGORIES="research build optimize monitor cross-cutting"

PASS_N=0
FAIL_N=0
WARN_N=0

pass() { printf 'PASS: %s\n' "$1"; PASS_N=$((PASS_N + 1)); }
fail() { printf 'FAIL: %s\n' "$1"; FAIL_N=$((FAIL_N + 1)); }
warn() { printf 'WARN: %s\n' "$1"; WARN_N=$((WARN_N + 1)); }

for req in "$PLUGIN_JSON" "$MARKETPLACE_JSON" "$README" "$VERSIONS"; do
    if [ ! -f "$req" ]; then
        echo "ERROR: required tracking file missing: $req" >&2
        exit 2
    fi
done

if [ "$PROBE" -eq 1 ] || [ "$EMIT" -eq 1 ]; then
    exec 3>&1 1>/dev/null
fi

echo "validate-tracking: repo-level consistency checks"
echo "Repo root: $ROOT"
echo "=============================================="

# ---------------------------------------------------------------------------
# Check (a): plugin version sync
#   .claude-plugin/plugin.json .version
#   == marketplace.json .metadata.version and .plugins[0].version (exactly 2 fields)
#   == README.md version badge
# ---------------------------------------------------------------------------
echo ""
echo "[a] Plugin version sync (plugin.json / marketplace.json x2 / README badge)"

# Top-level "version" in plugin.json. The pattern requires the quote directly
# before the word, so a field like "schemaVersion" (removed in the G1 pilot
# trim, 2026-08-08) would not match even if reintroduced.
PLUGIN_VER=$(grep -oE '"version"[[:space:]]*:[[:space:]]*"[^"]+"' "$PLUGIN_JSON" | head -1 | sed 's/.*:[[:space:]]*"//; s/"$//')

# marketplace.json carries the plugin version in TWO places: metadata.version and
# plugins[0].version. Collect every "version" occurrence and require exactly 2.
MKT_VERS=$(grep -oE '"version"[[:space:]]*:[[:space:]]*"[^"]+"' "$MARKETPLACE_JSON" | sed 's/.*:[[:space:]]*"//; s/"$//')
MKT_COUNT=$(printf '%s\n' "$MKT_VERS" | grep -c . || true)

# README badge: [![Version](https://img.shields.io/badge/version-X.Y.Z-color)](...)
README_VER=$(grep -oE 'badge/version-[0-9]+\.[0-9]+\.[0-9]+-' "$README" | head -1 | sed 's|badge/version-||; s/-$//')

A_OK=1
if [ -z "$PLUGIN_VER" ]; then
    fail "(a) could not extract top-level version from $PLUGIN_JSON"
    A_OK=0
fi
if [ -z "$README_VER" ]; then
    fail "(a) could not find a version badge (shields.io badge/version-X.Y.Z) in $README"
    A_OK=0
fi
if [ "$MKT_COUNT" -ne 2 ]; then
    fail "(a) expected exactly 2 version fields in $MARKETPLACE_JSON (metadata.version + plugins[0].version), found $MKT_COUNT"
    A_OK=0
fi
if [ "$A_OK" -eq 1 ]; then
    for v in $MKT_VERS; do
        if [ "$v" != "$PLUGIN_VER" ]; then
            fail "(a) marketplace.json version '$v' != plugin.json version '$PLUGIN_VER'"
            A_OK=0
        fi
    done
    if [ "$README_VER" != "$PLUGIN_VER" ]; then
        fail "(a) README badge version '$README_VER' != plugin.json version '$PLUGIN_VER'"
        A_OK=0
    fi
fi
# Marketplace-discovery shim (2026-08-09): Claude Code's `plugin marketplace
# add <owner>/<repo>` resolves .claude-plugin/marketplace.json ONLY — probed
# on this fork: the add fails when the manifest sits at repo root alone. The
# repo therefore carries a byte-identical copy at that path; root
# marketplace.json stays the canonical, hand-edited file.
MKT_SHIM="$ROOT/.claude-plugin/marketplace.json"
if [ ! -f "$MKT_SHIM" ]; then
    fail "(a) marketplace-discovery shim missing: .claude-plugin/marketplace.json (byte-identical copy of root marketplace.json)"
    A_OK=0
elif ! cmp -s "$MARKETPLACE_JSON" "$MKT_SHIM"; then
    fail "(a) .claude-plugin/marketplace.json differs from root marketplace.json — root is canonical; refresh with: cp marketplace.json .claude-plugin/marketplace.json"
    A_OK=0
fi
[ "$A_OK" -eq 1 ] && pass "(a) version '$PLUGIN_VER' consistent across plugin.json, marketplace.json (x$MKT_COUNT), README badge; .claude-plugin/ shim byte-identical"

# ---------------------------------------------------------------------------
# Shared inventory: skill directories on disk (contain a SKILL.md)
# ---------------------------------------------------------------------------
DISK_SKILLS=""   # newline-separated "./category/name"
for cat in $CATEGORIES; do
    [ -d "$ROOT/$cat" ] || continue
    for d in "$ROOT/$cat"/*/; do
        [ -f "${d}SKILL.md" ] || continue
        rel="./${cat}/$(basename "$d")"
        DISK_SKILLS="${DISK_SKILLS}${rel}
"
    done
done
DISK_SORTED=$(printf '%s' "$DISK_SKILLS" | sort)
DISK_COUNT=$(printf '%s\n' "$DISK_SORTED" | grep -c . || true)

# Extract a "skills": [ ... ] string array from a JSON file (grep-based; assumes
# the repo's one-entry-per-line formatting, which both manifests use).
extract_skills_array() {
    # $1 = json file
    sed -n '/"skills"[[:space:]]*:[[:space:]]*\[/,/\]/p' "$1" \
        | grep -oE '"\./[^"]+"' \
        | tr -d '"' \
        | sort
}

# ---------------------------------------------------------------------------
# Check (b): skill directories on disk <-> plugin.json skills array (both ways)
# ---------------------------------------------------------------------------
echo ""
echo "[b] Skill directory <-> manifest parity"

PLUGIN_SKILLS=$(extract_skills_array "$PLUGIN_JSON")
PLUGIN_COUNT=$(printf '%s\n' "$PLUGIN_SKILLS" | grep -c . || true)

B_OK=1
MISSING_IN_PLUGIN=$(comm -23 <(printf '%s\n' "$DISK_SORTED") <(printf '%s\n' "$PLUGIN_SKILLS"))
MISSING_ON_DISK=$(comm -13 <(printf '%s\n' "$DISK_SORTED") <(printf '%s\n' "$PLUGIN_SKILLS"))
if [ -n "$MISSING_IN_PLUGIN" ]; then
    while IFS= read -r s; do
        [ -n "$s" ] && fail "(b) on disk but missing from plugin.json skills array: $s"
    done <<< "$MISSING_IN_PLUGIN"
    B_OK=0
fi
if [ -n "$MISSING_ON_DISK" ]; then
    while IFS= read -r s; do
        [ -n "$s" ] && fail "(b) listed in plugin.json skills array but no $s/SKILL.md on disk"
    done <<< "$MISSING_ON_DISK"
    B_OK=0
fi
[ "$B_OK" -eq 1 ] && pass "(b) plugin.json skills array matches disk exactly ($DISK_COUNT skills)"

# (b2) same parity for marketplace.json plugins[0].skills — it is one of the 5
# tracking files CLAUDE.md requires to stay in sync.
MKT_SKILLS=$(extract_skills_array "$MARKETPLACE_JSON")
B2_OK=1
MKT_DIFF=$(comm -3 <(printf '%s\n' "$DISK_SORTED") <(printf '%s\n' "$MKT_SKILLS"))
if [ -n "$MKT_DIFF" ]; then
    while IFS= read -r s; do
        [ -n "$s" ] && fail "(b2) marketplace.json skills array out of sync with disk near: $(echo "$s" | tr -d '\t')"
    done <<< "$MKT_DIFF"
    B2_OK=0
fi
[ "$B2_OK" -eq 1 ] && pass "(b2) marketplace.json skills array matches disk exactly"

# ---------------------------------------------------------------------------
# Check (c): SKILL.md frontmatter version == VERSIONS.md current row
#   'metadata.version' is the version authority (VERSIONS.md:5; G1 transitional
#   rule, pilot 2026-08-08). Legacy skills may also carry a top-level 'version:'
#   field — then it must stay in lockstep with metadata.version. Spec-aligned
#   skills omit the top-level field entirely; metadata.version alone is compared
#   against the VERSIONS.md row.
# ---------------------------------------------------------------------------
echo ""
echo "[c] SKILL.md frontmatter version == VERSIONS.md row"

C_OK=1
C_CHECKED=0

# Emit "name<TAB>version" for the rows of the skills table ONLY — the pipe table
# that follows the '## Skills' heading, ending at the first non-table line.
#
# WHY BOUNDED (queue #33). This used to be an unbounded `awk -F'|' 'NF>=4'` over
# the whole file, which treats ANY line carrying three pipes as a skill row. The
# changelog is prose in the same file, and prose quotes tables: on 2026-08-10 a
# changelog line describing a report column produced the phantom skill 'Value'
# (from `Metric | Value | Industry Avg | Status`), and a second described a grep
# alternation and produced 'missing data'. Both were "fixed" by rewriting the
# prose to avoid pipes — a workaround the check imposed on every future author.
# The table has a heading; use it.
#
# PROBE, 2026-08-10 (F15 ships a guard with its hit rate, and exercises each
# component separately — a compound pattern can pass because one working part
# covers for a broken one). Fixture: a 2-skill table plus changelog prose
# reproducing both real-world shapes.
#   old extractor -> 4 rows for 2 skills: the phantoms 'Value' and 'bar'. 2 of 2.
#   new extractor -> exactly the 2 real skills. 0 of 2 phantoms survive.
#   heading renamed to '## Skill Inventory' -> 0 rows, and the guard below fires
#   rather than reporting all-clear over an empty set.
vers_table_rows() {
    awk -F'|' '
        /^##[[:space:]]+Skills[[:space:]]*$/ { in_sec = 1; next }
        in_sec && /^##[[:space:]]/           { exit }
        !in_sec                              { next }
        /^[[:space:]]*\|/ {
            started = 1
            name = $2; gsub(/^[ \t]+|[ \t]+$/, "", name)
            ver  = $4; gsub(/^[ \t]+|[ \t]+$/, "", ver)
            if (name == "" || name == "Skill" || name ~ /^:?-+:?$/) next
            print name "\t" ver
            next
        }
        started { exit }
    ' "$VERSIONS"
}
VERS_ROWS=$(vers_table_rows)

# F15 guard: a narrowed matcher can pass by matching nothing. If the heading is
# ever renamed or the table moved, every comparison below would silently compare
# against an empty set and check (c) would report all-clear while checking zero
# rows. That is the failure mode F15 was opened for, so it fails loudly instead.
if [ -z "$VERS_ROWS" ]; then
    fail "(c) no skills table found under a '## Skills' heading in VERSIONS.md — check (c) cannot compare anything (F15: a guard must not pass by matching nothing)"
    C_OK=0
fi
while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    name=$(basename "$rel")
    skill_file="$ROOT/${rel#./}/SKILL.md"

    top_ver=$(awk 'n<2 && /^---[[:space:]]*$/{n++; next} n==1 && /^version:/{sub(/^version:[[:space:]]*/,""); gsub(/["'"'"'\r]/,""); print; exit}' "$skill_file")
    meta_ver=$(awk 'n<2 && /^---[[:space:]]*$/{n++; next} n==1 && /^[[:space:]]+version:/{sub(/^[[:space:]]+version:[[:space:]]*/,""); gsub(/["'"'"'\r]/,""); print; exit}' "$skill_file")

    # VERSIONS.md row: | name | category | version | date | — skills table only.
    row_ver=$(printf '%s\n' "$VERS_ROWS" | awk -F'\t' -v n="$name" '$1 == n { print $2; exit }')

    if [ -z "$meta_ver" ]; then
        if [ -n "$top_ver" ]; then
            fail "(c) $rel/SKILL.md has a top-level 'version:' but no 'metadata.version' (metadata.version is the version authority — G1 transitional rule)"
        else
            fail "(c) $rel/SKILL.md has no 'metadata.version' frontmatter field (version authority)"
        fi
        C_OK=0
        continue
    fi
    if [ -z "$row_ver" ]; then
        fail "(c) $name has no row in VERSIONS.md skills table"
        C_OK=0
        continue
    fi
    if [ "$meta_ver" != "$row_ver" ]; then
        fail "(c) $rel: SKILL.md metadata.version '$meta_ver' != VERSIONS.md row '$row_ver'"
        C_OK=0
    fi
    if [ -n "$top_ver" ] && [ "$top_ver" != "$meta_ver" ]; then
        fail "(c) $rel: top-level version '$top_ver' != metadata.version '$meta_ver' (metadata.version is authoritative — legacy skills keep both in lockstep, or drop the top-level field)"
        C_OK=0
    fi
    C_CHECKED=$((C_CHECKED + 1))
done <<< "$DISK_SORTED"

# Reverse direction: every VERSIONS.md table row must correspond to a skill on disk.
while IFS= read -r row_name; do
    [ -n "$row_name" ] || continue
    case "$row_name" in Skill|:*|-*) continue ;; esac
    if ! printf '%s\n' "$DISK_SORTED" | grep -q "/${row_name}$"; then
        fail "(c) VERSIONS.md row '$row_name' has no matching skill directory on disk"
        C_OK=0
    fi
done < <(printf '%s\n' "$VERS_ROWS" | cut -f1)

[ "$C_OK" -eq 1 ] && pass "(c) all $C_CHECKED SKILL.md metadata.versions match VERSIONS.md (legacy top-level fields in lockstep); no orphan rows"

# ---------------------------------------------------------------------------
# Check (d): SKILL.md body <= 350 lines (body = lines after closing '---' of
#   frontmatter). FAIL above 350 (CLAUDE.md:48), WARN at 330+ (approaching cap).
# ---------------------------------------------------------------------------
echo ""
echo "[d] SKILL.md body line cap (<=350, warn at 330+)"

D_OK=1
D_MAX=0
D_MAX_SKILL=""
while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    skill_file="$ROOT/${rel#./}/SKILL.md"
    body=$(awk 'n<2 && /^---[[:space:]]*$/{n++; next} n>=2{c++} END{print c+0}' "$skill_file")
    if [ "$body" -gt 350 ]; then
        fail "(d) $rel/SKILL.md body is $body lines (cap: 350) — move detail to references/"
        D_OK=0
    elif [ "$body" -ge 330 ]; then
        warn "(d) $rel/SKILL.md body is $body lines (within cap, but 330+ — headroom low)"
    fi
    if [ "$body" -gt "$D_MAX" ]; then D_MAX=$body; D_MAX_SKILL=$rel; fi
done <<< "$DISK_SORTED"
[ "$D_OK" -eq 1 ] && pass "(d) all SKILL.md bodies <=350 lines (largest: $D_MAX_SKILL at $D_MAX)"

# ---------------------------------------------------------------------------
# Check (e): every markdown link from a SKILL.md to a references/ path resolves
#   Covers skill-local ./references/... and repo-root ../../references/...
#   (also bare 'references/...'). Strips #anchors and "title" suffixes.
# ---------------------------------------------------------------------------
echo ""
echo "[e] references/ link integrity from SKILL.md files"

E_OK=1
E_LINKS=0
while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    skill_dir="$ROOT/${rel#./}"
    skill_file="$skill_dir/SKILL.md"
    while IFS= read -r target; do
        [ -n "$target" ] || continue
        clean=${target%%#*}          # strip fragment
        clean=${clean%% \"*}         # strip "title"
        clean=${clean%% }            # strip trailing space
        E_LINKS=$((E_LINKS + 1))
        if [ ! -f "$skill_dir/$clean" ]; then
            shown=$(printf '%s/%s' "$skill_dir" "$clean" | sed 's|/\./|/|g')
            fail "(e) $rel/SKILL.md links to '$target' but $shown does not exist"
            E_OK=0
        fi
    done < <(grep -oE '\]\([^)]*references/[^)]+\)' "$skill_file" 2>/dev/null \
                 | sed 's/^](//; s/)$//' \
                 | grep -E '^(\.\/|\.\.\/|references\/)' \
                 | sort -u)
done <<< "$DISK_SORTED"
[ "$E_OK" -eq 1 ] && pass "(e) all $E_LINKS unique references/ links across SKILL.md files resolve"

# ---------------------------------------------------------------------------
# (f) deprecated-token sweep (ledger F9 guard redesign, 2026-08-08)
# ---------------------------------------------------------------------------
# F9 recurred the same day it was written: a manually-claimed "repo-wide" FID
# sweep missed a fifth file. Sweep completeness is therefore a SCRIPT'S job.
# Each entry: token regex | grep -E flags applied to skill/command/reference
# trees only (docs/loop, VERSIONS.md changelog, and SETTLED-RULINGS legitimately
# quote old states and are excluded). Add a row when a cross-skill concept is
# retired; remove a row only when the concept may legitimately return.
echo ""
echo "[f] deprecated-token sweep (F9 guard)"
F_OK=1
#
# ── HOW AN EXCUSE IS TESTED (2026-08-17, the proximity fix) ────────────────────────────────────
# Both allowlists below used to be WHOLE-LINE exclusions: `grep -viE "$LEGAL"`, so a line was
# excused because the word appeared ON it, wherever it appeared and whatever it was about. Two
# Mode A passes measured the cost. R3 leg: 17 constructed violations, 7 caught; word-bounding the
# generic members raised that to 12 and closed the SUBSTRING channel only (`ended` inside
# *recommended*), leaving 5 riding whole words used about something else — including
# `\bretired\b`, a member that diff had just bounded (OPEN-FINDINGS 92). FID leg: 0 of 8 caught
# before the bounding and 0 after, because the two members it bounded have no English words
# containing them (OPEN-FINDINGS 93). Word-bounding was one channel; this is the other.
#
# The rule now: a marker excuses a line only where it is BOUND TO THE CLAIM.
#   * AFTER the claim, within $F_NEAR_AFTER characters, not crossing `.` or `;` — the predicating
#     form: "FAQ rich results are retired", "First Input Delay was retired in March 2024".
#   * BEFORE the claim, within $F_NEAR_BEFORE characters, not crossing `.` `;` or `,` — the
#     governing form: "Google ended FAQ rich results", "teaching FID". Tight on purpose: amendment
#     9a rewrote nine surfaces into exactly this shape, so it must stay legal, and the one
#     character that separates it from the escape is the comma in "This retired template aside,".
# A marker that is on the line but bound to nothing no longer excuses anything, and the FAIL
# message says so explicitly rather than leaving the author to guess and reword good prose.
#
# THE TWO NUMBERS, and how to change them. $F_NEAR_AFTER is 60 because the worst legitimate line
# in the tree needs 50 (`commands/generate-schema.md:19`, claim to `2023-08-08` with no sentence
# break) — 10 characters of headroom, measured, not guessed. $F_NEAR_BEFORE is 12 because nothing
# in the tree relies on the before-branch alone; it exists so a future "Google ended FAQ rich
# results" cannot become a false positive. If a correct line ever fails here, WIDEN THIS NUMBER
# and re-measure with `--probe`. Do not add a marker: every whole-line marker widens the hole,
# and this file already records three rounds of that lesson below.
#
# The window is ASCII-only by deliberate choice (`[^.;]`, not `[^.;—]`). Excluding the em dash
# would catch one more constructed escape and would exclude its BYTES under this environment's
# POSIX locale — taking Greek Δ (CE 94) and the guillemets with it (OPEN-FINDINGS 81). Measured
# 2026-08-17 under LC_ALL unset, C, C.UTF-8 and en_US.UTF-8: identical verdicts on every live-tree
# line and on all 55 fixture lines. Re-run `--probe` under each locale to reproduce that.
F_NEAR_AFTER=60
F_NEAR_BEFORE=12
# Excuse regex, built the same way for both legs: a NAMED marker anywhere on the line, or a NEAR
# marker bound to a token. $1 = token regex, $2 = NAMED (whole-line) markers, $3 = NEAR markers.
#
# The `^[^:]*:[0-9]+:.*` prefix confines the whole test to the TEXT of the line. Without it the
# excuse also reads the `path:lineno:` grep prepends, and a file *named* for a marker exempts
# every line inside it: measured 2026-08-17, `references/non-faq-notes.md` containing nothing but
# "FAQPage schema is eligible for FAQ rich results on any site." was excused whole, while the
# identical line in `ordinary-notes.md` failed. Pre-existing and inherited — it applied to all 25
# markers before this split — and it is the same defect class as the excuse itself: something
# that is not the claim silencing the check. The probe carries a canary for it.
f_excuse() {
    printf '^[^:]*:[0-9]+:.*((%s)|(%s)[^.;]{0,%s}(%s)|(%s)[^.;,]{0,%s}(%s))' \
        "$2" "$1" "$F_NEAR_AFTER" "$3" "$3" "$F_NEAR_BEFORE" "$1"
}
# f_alts — split a regex on its TOP-LEVEL `|`, one alternative per line. Depth-aware over BOTH
# groups AND character classes: R3_TOKENS contains `eligib[^.|]*faq`, and a paren-only splitter
# cuts that member at the `|` INSIDE the class, yielding two fragments that are not regexes. The
# paren-only version shipped in the member-weight block on 2026-08-17 and survived only because
# the two allowlists happen to contain no brackets; run over the TOKEN lists it raised
# "unterminated character set" on the first try. A splitter that is right by luck about the input
# it is given today is the same shape as the guard this file is full of notes about.
f_alts() {
    printf '%s' "$1" | awk '{
        d = 0; cls = 0; esc = 0; cur = "";
        for (i = 1; i <= length($0); i++) {
            c = substr($0, i, 1);
            if (esc)              { cur = cur c; esc = 0; continue }
            if (c == "\\")        { cur = cur c; esc = 1; continue }
            if (cls)              { if (c == "]") cls = 0; cur = cur c; continue }
            if (c == "[")         cls = 1;
            else if (c == "(")    d++;
            else if (c == ")")    d--;
            if (c == "|" && d == 0) { print cur; cur = ""; } else cur = cur c;
        }
        print cur;
    }'
}
# The two sweeps as functions so `--probe` runs THIS code over the fixture rather than a second
# copy of it. $@ = directories to sweep, relative to the CALLER's cwd — the caller cds, so the
# same function serves the live tree and the probe's temporary one.
f_fid_hits() {
    grep -rnE "$DEPRECATED_TOKENS" "$@" --include='*.md' 2>/dev/null \
        | grep -v 'evals/' | grep -viE "$DEPRECATED_EXCUSE" || true
}
f_r3_hits() {
    grep -rniE "$R3_TOKENS" "$@" --include='*.md' 2>/dev/null \
        | grep -v 'evals/' | grep -viE "$R3_EXCUSE" || true
}
# SWEPT TREES, asserted rather than assumed. Found 2026-08-17 while wiring the probe: all three
# sweeps below were cwd-relative with no cd, so `bash scripts/validate-tracking.sh /path/to/repo`
# from any other directory swept the CALLER's cwd — usually nothing — and printed
# "PASS: (f) no deprecated tokens". A guard that reports success for matching nothing is F15's
# founding shape, and it was reachable here by passing the argument the usage line documents.
# Fixed two ways: every sweep now runs inside `cd "$ROOT"`, and the directories must exist.
F_DIRS="research build optimize monitor cross-cutting commands references"
for d in $F_DIRS; do
    [ -d "$ROOT/$d" ] || { fail "(f) swept directory missing under repo root: $d — this check would otherwise pass by sweeping nothing"; F_OK=0; }
done
DEPRECATED_TOKENS='\bFID\b|First Input Delay|Affiliate links disclosed'
#
# 2026-08-13 — DEPRECATED_LEGAL, and it is the same lesson this file already records
# three times for R3_LEGAL. The sweep bans the token outright, which is right for a
# skill that still *teaches* the metric and wrong for the one sentence that retires it.
# **Three separate workers hit this in a single day** — the coordinator twice (once
# working around it by refusing to name the metric at all, which made the guidance
# vaguer than the truth) and an implementer once, while writing the correction a graded
# run had failed to make. That correction is the highest-value sentence in the skill:
# a run must be able to tell a client "this metric was retired in March 2024 and INP
# replaced it" instead of sending them to look it up (ledger F19, twice recorded).
# A guard that forbids the retirement notice **produces** the abstention it was never
# meant to touch.
#
# So: a line may name the token when the SAME line also retires it. Every marker below
# is a statement this library can source from settled ruling R4 — vetted per the B2 rule
# that an allowlist marker is an assertion the guard now endorses. What still fails is
# the token standing alone, or beside a live threshold, which is the case that matters.
#
# 2026-08-17 — the whole-line hazard, measured on this leg. Word-bounding `dropped` and
# `teaching` was reported as "the same hazard ... bounded too" and was a practical no-op:
# 0 of 8 constructed violations caught before, 0 after (OPEN-FINDINGS 93). Every one of the
# eight rode a marker used about something else on the same line. So the markers below are
# split by whether the marker NAMES its subject or not, and only the first kind stays
# whole-line. On this leg exactly one qualifies: `replaced by inp` is a sentence about the
# metric that replaced FID and cannot be about a stylesheet. Everything else is an ordinary
# English word and is now bound to the token by proximity.
DEPRECATED_LEGAL_NAMED='replaced by inp'
DEPRECATED_LEGAL_NEAR='\bretired\b|superseded|no longer|deprecat|is dead|\bdropped\b|not named here|do not teach|\bteaching\b'
# Union kept for the diagnostic branch below: a line carrying a marker that is merely UNBOUND
# needs a different sentence from a line carrying no marker at all. It is also the name a
# comment in scripts/eval-expectation-sweep.sh points at.
DEPRECATED_LEGAL="$DEPRECATED_LEGAL_NAMED|$DEPRECATED_LEGAL_NEAR"
DEPRECATED_EXCUSE="$(f_excuse "$DEPRECATED_TOKENS" "$DEPRECATED_LEGAL_NAMED" "$DEPRECATED_LEGAL_NEAR")"
F_HITS=$(cd "$ROOT" && f_fid_hits $F_DIRS)
if [ -n "$F_HITS" ]; then
    while IFS= read -r hit; do
        if printf '%s' "$hit" | grep -qiE "$DEPRECATED_LEGAL"; then
            fail "(f) deprecated token still taught — a retirement marker is on this line but is not bound to the metric (it must sit within $F_NEAR_AFTER characters after it, no \`.\` or \`;\` between, or within $F_NEAR_BEFORE immediately before it). Say what is retired where you name it: $hit"
        else
            fail "(f) deprecated token still taught: $hit"
        fi
    done <<< "$F_HITS"
    F_OK=0
fi
# R3 token class (added 2026-08-09; settled ruling R3): Google ended FAQ rich
# results in 2026 — FAQPage markup stays because it is valid and Google says
# there is no need to proactively remove it. Live files may mention FAQ near "rich
# result"/"eligibility"/the accordion visual ONLY when the same line acknowledges
# the ending (a marker in R3_LEGAL, e.g. "FAQ rich results ended 2026",
# "non-FAQ types", "FAQ: none"); a line without such a marker is a dead
# SERP-eligibility claim taught as current.
# Case-insensitive (tables write "Rich Results (FAQ)"). Same scope as the
# tokens above: live trees only — docs/loop legitimately quotes the ended
# state (SETTLED-RULINGS R3 itself) and stays out of the sweep.
#
# 2026-08-11 — WHY THIS ALLOWLIST GREW, and the lesson is about guard design.
# G9 amendment 9a rewrote nine surfaces from "retired" to the more precise
# "ended" (2023 narrowed eligibility; 2026 ended the display — two events this
# library had conflated). Every one of those nine then FAILED check (f),
# because the allowlist tested for the WORD "retired" rather than for the
# CLAIM being denied. The nine most accurate lines in the repository were the
# only ones the guard rejected. **A guard keyed to one vocabulary punishes the
# author who improves the vocabulary**, and the cheap escape — reverting to the
# word the guard likes — is the failure mode that matters, because it teaches
# authors to write for the checker instead of the reader. Markers added for
# "ended", "ceased", "discontinued", "no evidenced citation benefit" and
# "advises against removing", so a line that denies the eligibility claim in
# any of the natural ways passes. If a future rewording fails here again, widen
# this list — do not narrow the prose.
#
# 2026-08-13, THIRD WIDENING, and the same lesson a third time. Option C of the
# R3 decision brief moved the library off the *unsourced* 2026 dates and onto the
# *sourced* 2023-08-08 restriction — "no FAQ rich result for ordinary sites,
# government/health only since Aug 2023". Every one of those corrected lines then
# failed here, because the allowlist tested for the vocabulary of the claim being
# retired rather than for the claim being denied. **Three times now the most
# accurate lines in the repository have been the only ones this guard rejected.**
# Markers added for the sourced phrasing, the date in both forms, the
# tool-does-not-support form, and `unverified` (a line that labels the 2026 dates
# unverified is denying the eligibility claim as firmly as one that calls them
# ended). Vetted per the B2 rule three hours earlier — an allowlist marker is an
# assertion the guard endorses, so each new marker here is a statement this
# library can source, which is exactly why they were chosen over the old ones.
#
# 2026-08-13 — AND THE COST OF THAT WIDENING, which is the other half of the
# lesson. "advises against (proactively )?removing" was added above as a
# convenient marker. It is not a true statement. Google's words are: "While you
# can drop this structured data from your site, there's no need to proactively
# remove it" — a PERMISSION to leave existing markup alone, and an explicit
# permission to drop it. Thirteen shipped surfaces across six skills and one
# command rewrote that as "Google advises against removing it", a
# RECOMMENDATION Google never made, and this allowlist blessed the rewrite for
# two days: the guard could not fail the claim because the claim was its own
# pass condition. **An allowlist marker is an assertion the guard now endorses;
# vet it like shipped prose.** Marker replaced with the faithful phrasing, and
# the overstatement is now a hard fail below.
R3_TOKENS='faq.*rich[- ]?(result|snippet)|rich[- ]?(result|snippet)s?.*faq|eligib[^.|]*faq|faq[^.|]*eligib|expandable q&a below|faq (accordion|dropdown|drop-down)|serp accordion'
# R3_LEGAL WAS a WHOLE-LINE exclusion. Every generic English member therefore exempted any line
# that merely contained the word, whatever the line actually claimed. Measured 2026-08-17 on six
# lines each carrying the exact claim R3 amendment 9a retracted ("FAQPage schema earns AI
# citations"): only 1 of 6 was caught. `ended` is a SUBSTRING of *recommended* — 117 lines in
# the scanned directories contain that word, and every one of them was wholly exempt — and also
# of *extended*, *amended*, *appended*. `unverified` excused a line whose "unverified" was about
# an unrelated figure. Same shape as the two channels found in the citation guard the same day:
# a qualifier that is not about the claim silences the check.
#   FIX 1 (2026-08-17): word-bound the generic members. That closed the SUBSTRING channel and
#   nothing else — Mode A rebuilt the corpus and measured 7/17 -> 12/17, with 5 still escaping,
#   one of them on `\bretired\b`, a member the diff had just bounded (OPEN-FINDINGS 92). The
#   comment written above that fix named the real channel in its own first sentence.
#   FIX 2 (2026-08-17, this one): bind the excuse to the claim. See the mechanism note at the top
#   of check (f). The members split in two, and the split is the whole design:
#     * NAMED — the marker contains "faq" and asserts something about FAQ, so it cannot be about
#       an unrelated subject. Stays whole-line. `do not run it through` is the one member here
#       that does not name FAQ; it is kept whole-line because on the real line it excuses
#       (validation-guide.md:255) the marker sits INSIDE the token span, where no proximity rule
#       can see it. That trade is recorded in the fixture, not hidden.
#     * NEAR — an ordinary English word, a date, or a phrase about some other Google feature.
#       Excuses only where it is bound to the claim. `\bceased\b` is the clearest case: it is
#       TRUE of How-to rich results and false of FAQ, and whole-line it let the true half of a
#       sentence excuse the false half.
#   DO NOT fix a miss here by ADDING a legal marker. Every whole-line marker widens the hole;
#   the direction is narrower excuses, bound to the claim. The corpus that measures both
#   directions is checked in at scripts/fixtures/r3-allowlist/ — run `--probe` after any edit
#   here and report the number it prints, not one from a shell session.
R3_LEGAL_NAMED='non-faq|no faq (support|eligibility)|faq(:| has) none|dropped faq support|do not run it through|"add faq rich results"|no faq rich result|does not (support|test) faqpage|not (the route|supported) for faqpage'
R3_LEGAL_NEAR='\bretired\b|\bretirement\b|\bended\b|\bceased\b|\bdiscontinued\b|no longer|no evidenced citation benefit|no need to (proactively )?remove|scheduled for august 2026|has none since|government and health|government/health|restricted (them )?to|2023-08-08|aug 2023|unverified (dates|magnitudes)'
# Union: the diagnostic branch below, and the name other scripts' comments point at.
R3_LEGAL="$R3_LEGAL_NAMED|$R3_LEGAL_NEAR"
R3_EXCUSE="$(f_excuse "$R3_TOKENS" "$R3_LEGAL_NAMED" "$R3_LEGAL_NEAR")"
R3_HITS=$(cd "$ROOT" && f_r3_hits $F_DIRS)
if [ -n "$R3_HITS" ]; then
    while IFS= read -r hit; do
        if printf '%s' "$hit" | grep -qiE "$R3_LEGAL"; then
            fail "(f) FAQ rich-result eligibility claim (FAQ rich results ended for ordinary sites, ruling R3) — a retraction marker is on this line but is not bound to the claim (it must sit within $F_NEAR_AFTER characters after it, no \`.\` or \`;\` between, or within $F_NEAR_BEFORE immediately before it). Deny the claim where you make it: $hit"
        else
            fail "(f) FAQ rich-result eligibility claim (FAQ rich results retired 2026, ruling R3): $hit"
        fi
    done <<< "$R3_HITS"
    F_OK=0
fi
# R3 overstatement class (added 2026-08-13, same commit that fixed the thirteen
# surfaces). A permission shipped as a recommendation is a claim about Google's
# position that Google did not make, and it reached client-facing skill text.
# Deliberately narrowed to lines ALSO about FAQ/schema/markup: "advises against
# removing" can be true of something else entirely (redirects, canonical tags),
# and a guard that fails a correct sentence about a different subject is the
# same design error the note above is about. The check is an AND of two patterns —
# neither grep -E nor awk's match() has a conjunction.
# Widened 2026-08-13 after a Mode A pass measured the first form at **3 of 8**
# constructed variants — it caught `advises against removing` and two siblings and
# missed `advised against removing` (past tense), `recommends against`, `discourages`,
# `tells you not to remove`, `says you should keep`. That is F15's own root cause: a
# pattern written from its founding instance. The probe recorded with the original
# discharged only guard (a) — it fires on the known defect — and left (b) undone.
R3_OVERSTATE='(advis|recommend|counsel)(es|s|ed)? against ([a-z]+ )?(remov|delet|drop)|discourages? ([a-z]+ )?(remov|delet|drop)|tells you not to (remove|delete|drop)|says you should keep'
# The second half of the conjunction, hoisted out of the pipeline it used to be a literal inside,
# so it is a named part of the pattern surface and travels through --emit-f-patterns like the rest.
R3_OVER_SUBJECT='faq|schema|structured data|markup'
#
# -- WHY THIS LEG IS NOT A LINE-BASED GREP (2026-08-17, ledger F15 recurrence 5) ----------------
# It was one, for four days, and it certified a tree clean while carrying the exact defect it
# exists to catch. `optimize/content-refresher/references/refresh-templates.md`:464-465 read
# "...and Google advises / against proactively removing it" with the phrase straddling the break,
# and `grep -cniE "$R3_OVERSTATE"` over that file returned 0. The class had been recorded FIXED
# across 13 shipped surfaces on 2026-08-13 with THIS check as its guard. The surviving instance
# was found by a human reading the file four days later, and repaired only then (`3ce98c9`).
#
# A guard that treats a line as a semantic unit has encoded an accident of formatting as a rule.
# Prose wraps wherever the author's editor wrapped it; the defect is the claim, not its layout.
# Three concrete shapes beat the line-based form, each of them ordinary markdown rather than an
# adversarial construction, and each is checked in as a case in the fixture below:
#   * the phrase split across a wrap          (the real instance);
#   * an indented list continuation -- joining the raw lines leaves THREE spaces where the phrase
#     needs one, which is why the window is whitespace-flattened and not merely concatenated;
#   * the FAQ/schema conjunct wrapped away onto the neighbouring line, which is the same blindness
#     one step over: fixing only the phrase would leave the qualifier line-bound.
#
# WHAT REPLACED IT, and the two things it deliberately does NOT do.
# Each line is an ANCHOR. The window is that line plus WHOLE neighbouring lines in each direction
# until $F_NEAR_WINDOW characters of context have been added, all of it whitespace-flattened; a
# match is reported at the line where it STARTS, so an instance is reported exactly once and a
# single-line instance still lands on its own line number.
#   * NOT a whole-file flatten. That is the method F15-r5 measured with, and it turns the
#     FAQ/schema conjunct from "near the claim" into "anywhere in the file" -- a real widening,
#     and that conjunct is the only thing keeping a correct sentence about redirects or canonical
#     tags out of this check. Measured over $F_DIRS at HEAD both ways: 0 hits either way, so the
#     flatten buys nothing here and costs the narrowing. The fixture case `subject-past-the-window`
#     is that difference turned into a test -- a whole-file flatten reports it; this must not.
#   * NOT sentence-bounded, though the `[^.;]` idiom above would have been the consistent choice.
#     Measured against the real instance and rejected on the measurement: its subject word is
#     `schema.org`, so splitting the window on `.` cuts the qualifier off the claim and the guard
#     goes blind again on the one line it was built for.
# $F_NEAR_WINDOW is 110 because the swept trees' non-empty lines run p50=58 / p90=116 characters
# [obs:2026-08-17T19:4xZ awk length() over the 121 swept .md files, n=29419 lines; measured twice
# two hours apart and it moved p50 57->58 / p90 115->116 as other lanes edited, so re-run it rather
# than quote it -- what is stable is the shape, not the digits], so 110 characters of
# whole-line context always reaches at least one full neighbouring line and usually two -- which is
# what makes a break bridgeable wherever the author put it. Raising it is free on today's tree
# (0 hits at 60, 110, 200 and 400) but the direction of risk is the conjunct's reach, so it is set
# to the smallest value meeting that guarantee, not the largest that stays green. Widen it and the
# `subject-past-the-window` case will tell you what you bought.
F_NEAR_WINDOW=110
# f_over_hits -- the sweep as a FUNCTION, for the reason f_r3_hits is one: `--probe` runs THIS
# code over the fixture rather than a second copy of it. $@ = directories, relative to the
# CALLER's cwd (the caller cds). Same filters as the other two legs -- `*.md` only, `evals/`
# excluded -- asserted by probe controls rather than assumed.
# The patterns reach awk through ENVIRON, not -v: -v escape-processes its argument, so a `\b`
# added to either pattern later would arrive at the matcher as a backspace. (mawk has no word
# boundary at all; the probe asserts both patterns stay backslash-free rather than leaving that
# to a comment.)
f_over_hits() {
    export R3_OVERSTATE R3_OVER_SUBJECT F_NEAR_WINDOW
    find "$@" -type f -name '*.md' 2>/dev/null | grep -v 'evals/' | sort | while IFS= read -r _f; do
        awk '
            function flat(s) { gsub(/[ \t]+/, " ", s); sub(/^ /, "", s); sub(/ $/, "", s); return s }
            BEGIN { OVER = ENVIRON["R3_OVERSTATE"]; SUBJ = ENVIRON["R3_OVER_SUBJECT"]
                    WIN  = ENVIRON["F_NEAR_WINDOW"] + 0 }
            { L[NR] = flat($0) }
            END {
                for (i = 1; i <= NR; i++) {
                    if (L[i] == "") continue
                    alen = length(L[i]); win = L[i]
                    j = i + 1
                    while (j <= NR && length(win) - alen < WIN) { if (L[j] != "") win = win " " L[j]; j++ }
                    pre = ""; k = i - 1
                    while (k >= 1 && length(pre) < WIN) { if (L[k] != "") pre = L[k] " " pre; k-- }
                    lwin = tolower(win)
                    if (! match(lwin, OVER)) continue
                    # The leftmost match is the one match() returns, so RSTART > alen means no
                    # match starts on this line at all -- it belongs to a later anchor and is
                    # reported there, exactly once.
                    if (RSTART > alen) continue
                    if ((tolower(pre) " " lwin) !~ SUBJ) continue
                    mark = (RSTART + RLENGTH - 1 > alen) ? "   [the phrase straddles a line break]" : ""
                    printf "%s:%d:%s%s\n", FILENAME, i, substr(win, 1, alen + WIN), mark
                }
            }
        ' "$_f"
    done
}

# --emit-f-patterns: THE EXPORT. Every pattern variable check (f) uses, one per line, NAME<TAB>
# value, raw — no quoting, no escaping, because a consumer that has to un-escape is a consumer
# that can get it wrong. Placed here because this is the first point at which all of them exist,
# and it exits immediately: the accessor must not be able to report a verdict, or a caller will
# start reading its exit code as one. `--probe` asserts this list covers every pattern assignment
# in the file (F_EMIT_NAMES vs the source), so the export cannot silently go stale.
F_EMIT_NAMES="F_NEAR_AFTER F_NEAR_BEFORE F_NEAR_WINDOW DEPRECATED_TOKENS DEPRECATED_LEGAL_NAMED DEPRECATED_LEGAL_NEAR DEPRECATED_LEGAL R3_TOKENS R3_LEGAL_NAMED R3_LEGAL_NEAR R3_LEGAL R3_OVERSTATE R3_OVER_SUBJECT"
if [ "$EMIT" -eq 1 ]; then
    exec 1>&3
    for _n in $F_EMIT_NAMES; do
        printf '%s\t%s\n' "$_n" "${!_n}"
    done
    exit 0
fi
R3_OVER_HITS=$(cd "$ROOT" && f_over_hits $F_DIRS)
if [ -n "$R3_OVER_HITS" ]; then
    while IFS= read -r hit; do
        fail "(f) R3 overstatement — Google permits dropping FAQPage markup and says only that there is no need to proactively remove it; it never advised against removal. Write the permission, not a recommendation. The text below is the flattened window, so a phrase marked as straddling a break is quoted joined and sits at the line named: $hit"
    done <<< "$R3_OVER_HITS"
    F_OK=0
fi
[ "$F_OK" -eq 1 ] && pass "(f) no deprecated tokens (FID / First Input Delay / affiliate-only T04) and no un-acknowledged FAQ rich-result claims (R3) in live skill, command, or framework files"

# ---------------------------------------------------------------------------
# i_record_dirs / i_dir_note / i_unreachable_dirs — the measurement behind check (i)
# ---------------------------------------------------------------------------
# Defined here, above --probe, for the same reason f_r3_hits is a function: the probe must run
# THIS code over a temporary tree, not a second copy of it. $1 = baselines root.
#
# REACHABLE means, and this is the entire content of the check: the directory HOLDS
# INSTRUMENT-CHANGES.md itself, or a SIBLING NOTE beside the records — a file at depth 1 of that
# directory which is not itself a record — names it. `ls` is what a grader sent to a record BY
# PATH actually does, and a sibling note is what `ls` shows. Depth 1, never recursive: a note
# buried in a subdirectory is not on that `ls` either.
#
# A RECORD'S OWN PROSE NAMING THE FILE COUNTS FOR NOTHING. Decided here 2026-08-18, after the leg
# was measured blind. The implementation was `grep -rlq 'INSTRUMENT-CHANGES' "$d"` — a recursive
# search of the DIRECTORY — so `blind-2026-08-17/`, twenty records with no README at all, printed
# "PASS: (i) all 54 baseline record(s) sit in a directory that names INSTRUMENT-CHANGES.md",
# because 5 of its 20 records happened to mention the string in their own grader prose. The
# comment this one replaces already said REACHABLE meant a sibling note and explicitly not "a key
# inside each record"; the code asked a question one noun over, and read green while doing it.
# Three reasons a record mention is not reachability, in increasing order of weight:
#   * it is per-record. A grader opening `alert-manager.json` is never shown what
#     `content-refresher.json` happens to say, and 15 of those 20 records say nothing at all.
#   * the records are machine-written, so a mention inside one is erased by the next run that
#     writes it — the original comment's own stated reason for wanting a sibling file.
#   * the mentions are frequently not pointers. Two of the five say INSTRUMENT-CHANGES.md carries
#     NO row for the change that moved their own numbers, which is a reader reporting the file is
#     incomplete, not a reader being told where to look.
# The number is not discarded: check (i) prints it beside the WARN as an explicitly
# non-qualifying signal, because "graders in this wave reached for the file by hand" is worth a
# maintainer's attention even though it closes nothing.
i_record_dirs() {
    find "$1" -type f -name '*.json' 2>/dev/null | while IFS= read -r rec; do
        dirname "$rec"
    done | sort -u
}

# Prints the ONE file that makes $1 reachable, or nothing at all. It prints the file rather than
# returning a boolean so check (i) can show its evidence per directory: coverage that arrived by
# accident is then visible in the output instead of hiding behind a green line (F7's discipline —
# a check prints what it matched, never a bare verdict).
i_dir_note() {
    _d="$1"
    if [ -f "$_d/INSTRUMENT-CHANGES.md" ]; then
        printf '%s\n' "$_d/INSTRUMENT-CHANGES.md"
        return 0
    fi
    find "$_d" -maxdepth 1 -type f ! -name '*.json' -exec grep -l 'INSTRUMENT-CHANGES' {} + 2>/dev/null \
        | sort | sed -n '1p'
}

# Prints one record-holding directory per line that cannot reach INSTRUMENT-CHANGES.md.
i_unreachable_dirs() {
    i_record_dirs "$1" | while IFS= read -r d; do
        [ -n "$(i_dir_note "$d")" ] || printf '%s\n' "$d"
    done
}

# How many records directly in $1 name the file in their own prose. Reported, never counted.
i_self_naming_records() {
    find "$1" -maxdepth 1 -type f -name '*.json' -exec grep -l 'INSTRUMENT-CHANGES' {} + 2>/dev/null \
        | grep -c '.'
}

# ---------------------------------------------------------------------------
# --probe: fault injection for check (f)'s allowlists (OPEN-FINDINGS 92 owed item)
# ---------------------------------------------------------------------------
# WHY THIS EXISTS. Three numbers about this check were published in one day and none could be
# re-derived: "6 of 6 violations caught" (the corpus was never saved), "old 7/17 -> new 12/17"
# (Mode A's corpus was never saved either), and "the same hazard bounded too" on the FID leg
# (measured afterwards at 0/8 -> 0/8). A guard's catch rate is a claim like any other, and a
# claim that cannot be re-run is indistinguishable from a regression the next time someone looks.
# So the corpus is checked in at scripts/fixtures/r3-allowlist/ and the number is a command.
#
# It runs the REAL sweep functions over a materialised copy of the fixture — same token regexes,
# same allowlists, same `evals/` and `--include='*.md'` filters — so it cannot drift from the
# check it measures. It also re-derives the two historical rates from frozen copies of the
# allowlists as they stood at their commits, which is what makes "before and after" checkable at
# any point in the future rather than quoted from a session nobody kept.
if [ "$PROBE" -eq 1 ]; then
    exec 1>&3
    probe_fail=0
    FIXDIR="$ROOT/scripts/fixtures/r3-allowlist"
    [ -d "$FIXDIR" ] || { echo "PROBE ERROR: fixture directory missing: $FIXDIR" >&2; exit 2; }

    # FROZEN HISTORY. Not live allowlists, never used by check (f) — copies of the R3/FID marker
    # strings as they stood at the two commits whose rates were published, so those rates stay
    # re-derivable. They are historical facts and must not be "kept in sync" with anything.
    # Each was verified byte-identical to the committed line when it was frozen, and the check is
    # one command, so a reader never has to take that on trust:
    #   git show 8f69a7a:scripts/validate-tracking.sh  | grep -m1 '^R3_LEGAL='          # _BOUNDED
    #   git show 8f69a7a^:scripts/validate-tracking.sh | grep -m1 '^R3_LEGAL='          # _PRE
    #   git show 8f69a7a:scripts/validate-tracking.sh  | grep -m1 '^DEPRECATED_LEGAL='  # _BOUNDED
    #   git show 8f69a7a^:scripts/validate-tracking.sh | grep -m1 '^DEPRECATED_LEGAL='  # _PRE
    HIST_R3_PRE='retired|retirement|ended|ceased|discontinued|no longer|non-faq|no faq (support|eligibility)|faq(:| has) none|dropped faq support|do not run it through|"add faq rich results"|no evidenced citation benefit|no need to (proactively )?remove|scheduled for august 2026|has none since|no faq rich result|government and health|government/health|restricted (them )?to|2023-08-08|aug 2023|does not (support|test) faqpage|not (the route|supported) for faqpage|unverified'
    HIST_R3_BOUNDED='\bretired\b|\bretirement\b|\bended\b|\bceased\b|\bdiscontinued\b|no longer|non-faq|no faq (support|eligibility)|faq(:| has) none|dropped faq support|do not run it through|"add faq rich results"|no evidenced citation benefit|no need to (proactively )?remove|scheduled for august 2026|has none since|no faq rich result|government and health|government/health|restricted (them )?to|2023-08-08|aug 2023|does not (support|test) faqpage|not (the route|supported) for faqpage|unverified (dates|magnitudes)'
    HIST_FID_PRE='retired|replaced by inp|superseded|no longer|deprecat|is dead|dropped|not named here|do not teach|teaching'
    HIST_FID_BOUNDED='\bretired\b|replaced by inp|superseded|no longer|deprecat|is dead|\bdropped\b|not named here|do not teach|\bteaching\b'
    NEVER='zzz_no_such_marker_zzz'   # an excuse that excuses nothing, for the load-bearing test

    tmp="$(mktemp -d)"; trap 'rm -rf "$tmp"' EXIT
    mkdir -p "$tmp/probe/r3/evals" "$tmp/probe/fid"

    # Fixture parse. `# ` comment, `>>> ` datum, `# EXPECT: MISSED` applying to the next datum.
    # Anything else is a format error, reported rather than skipped: a datum silently demoted to
    # a comment would shrink the denominator, which is the failure this whole file is about.
    probe_parse() {
        awk '
            /^# EXPECT: MISSED/ { pending = "MISSED"; next }
            /^>>> /             { print (pending == "" ? "CAUGHT" : pending) "\t" substr($0, 5); pending = ""; next }
            /^#/                { next }
            /^[[:space:]]*$/    { next }
                                { print "FORMAT-ERROR\t" $0 }
        ' "$1"
    }
    probe_declared_count() { grep -oE '^# COUNT: [0-9]+' "$1" | head -1 | grep -oE '[0-9]+'; }

    # Materialise each corpus: one datum per line, so grep's line number IS the entry number.
    for f in r3-violations r3-violations-extended r3-legitimate r3-token-coverage; do
        probe_parse "$FIXDIR/$f.txt" | cut -f2- > "$tmp/probe/r3/$f.md"
    done
    for f in fid-violations fid-legitimate fid-token-coverage; do
        probe_parse "$FIXDIR/$f.txt" | cut -f2- > "$tmp/probe/fid/$f.md"
    done
    # Two controls that must NOT be reported, proving the filters are part of the net and not
    # decoration: an eval fixture legitimately carries the defect it grades, and a non-markdown
    # file is out of scope by construction.
    printf 'FAQPage schema is eligible for FAQ rich results on any site.\n' > "$tmp/probe/r3/evals/graded.md"
    printf 'FAQPage schema is eligible for FAQ rich results on any site.\n' > "$tmp/probe/r3/notmarkdown.txt"
    # Canary for the path-borne excuse: same violation, in a file whose NAME carries a marker.
    # It must be reported. Before the `^[^:]*:[0-9]+:` anchor in f_excuse it was not.
    printf 'FAQPage schema is eligible for FAQ rich results on any site.\n' > "$tmp/probe/r3/non-faq-notes.md"

    # caught_lines <leg> <corpus-basename> -> the entry numbers the sweep reports as violations
    caught_lines() {
        if [ "$1" = "r3" ]; then ( cd "$tmp" && f_r3_hits probe/r3 ); else ( cd "$tmp" && f_fid_hits probe/fid ); fi \
            | grep -F "probe/$1/$2.md:" | sed "s|^probe/$1/$2\.md:||" | cut -d: -f1 | sort -n -u
    }
    token_lines() {   # entries that match the TOKEN at all — a corpus line that matches no token
        if [ "$1" = "r3" ]; then                  # tests nothing, and must not be counted as a miss
            ( cd "$tmp" && grep -niE "$R3_TOKENS" "probe/r3/$2.md" 2>/dev/null )
        else
            ( cd "$tmp" && grep -nE "$DEPRECATED_TOKENS" "probe/fid/$2.md" 2>/dev/null )
        fi | cut -d: -f1 | sort -n -u
    }

    echo "validate-tracking --probe : check (f) allowlist fault injection"
    echo "Fixture: $FIXDIR"
    echo "Live windows: after=$F_NEAR_AFTER chars (no . or ;), before=$F_NEAR_BEFORE chars (no . ; ,)"
    echo "Checks (a)-(f) ran with output suppressed: $FAIL_N FAIL, $WARN_N WARN, $PASS_N PASS"
    [ "$FAIL_N" -gt 0 ] && echo "  ^ NOT a clean run. Re-run without --probe before trusting anything below."
    echo ""

    probe_corpus() {   # <leg> <corpus> <role: violation|legitimate>
        leg="$1"; corpus="$2"; role="$3"
        declared="$(probe_declared_count "$FIXDIR/$corpus.txt")"
        mapfile -t entries < <(probe_parse "$FIXDIR/$corpus.txt")
        n=${#entries[@]}
        if [ -z "$declared" ] || [ "$declared" -ne "$n" ]; then
            echo "PROBE FAIL — $corpus.txt declares COUNT: ${declared:-<none>} but parses $n data lines"
            probe_fail=1
        fi
        # A denominator that can be walked to zero is not a denominator: with no entries every
        # rate below is 0/0 and the probe reports PASS having measured nothing.
        if [ "$n" -eq 0 ]; then
            echo "PROBE FAIL — $corpus.txt has no data lines; a corpus that measures nothing cannot pass"
            probe_fail=1
        fi
        caught="$(caught_lines "$leg" "$corpus")"
        toks="$(token_lines "$leg" "$corpus")"
        n_caught=0; n_missed=0; n_open=0; n_notoken=0
        miss_report=""; open_report=""; notoken_report=""; stale_report=""
        i=0
        for e in "${entries[@]}"; do
            i=$((i + 1))
            expect="${e%%	*}"; text="${e#*	}"
            is_caught=0; printf '%s\n' "$caught" | grep -qx "$i" && is_caught=1
            has_token=0; printf '%s\n' "$toks" | grep -qx "$i" && has_token=1
            if [ "$expect" = "FORMAT-ERROR" ]; then
                echo "PROBE FAIL — $corpus.txt line is neither comment nor \`>>> \` datum: $text"; probe_fail=1; continue
            fi
            if [ "$has_token" -eq 0 ]; then
                n_notoken=$((n_notoken + 1))
                notoken_report="$notoken_report
    #$i matches no token at all — it tests the token list, not the allowlist: $text"
                continue
            fi
            if [ "$role" = "legitimate" ]; then
                if [ "$is_caught" -eq 1 ]; then
                    n_missed=$((n_missed + 1))
                    miss_report="$miss_report
    #$i FALSE POSITIVE — a line the library wants is now failed: $text"
                else
                    n_caught=$((n_caught + 1))
                fi
            elif [ "$expect" = "MISSED" ]; then
                if [ "$is_caught" -eq 1 ]; then
                    n_caught=$((n_caught + 1))
                    stale_report="$stale_report
    #$i declared MISSED but is CAUGHT — the guard got narrower and the fixture now lies: $text"
                else
                    n_open=$((n_open + 1))
                    open_report="$open_report
    #$i OPEN HOLE (declared): $text"
                fi
            else
                if [ "$is_caught" -eq 1 ]; then
                    n_caught=$((n_caught + 1))
                else
                    n_missed=$((n_missed + 1))
                    miss_report="$miss_report
    #$i EXCUSED but must be caught: $text"
                fi
            fi
        done
        if [ "$role" = "legitimate" ]; then
            printf '  %-28s %2d entries | %2d excused | %2d WRONGLY CAUGHT\n' "$corpus" "$n" "$n_caught" "$n_missed"
        else
            printf '  %-28s %2d entries | %2d caught | %2d MISSED | %2d declared open\n' "$corpus" "$n" "$n_caught" "$n_missed" "$n_open"
        fi
        [ -n "$notoken_report" ] && { echo "  BROKEN FIXTURE LINES:$notoken_report"; probe_fail=1; }
        [ -n "$miss_report" ] && { echo "  UNDECLARED:$miss_report"; probe_fail=1; }
        [ -n "$stale_report" ] && { echo "  STALE DECLARATION (good news, then fix the file):$stale_report"; probe_fail=1; }
        [ -n "$open_report" ] && echo "  DECLARED OPEN HOLES (still holes):$open_report"
    }

    echo "R3 leg — live allowlist"
    probe_corpus r3 r3-violations violation
    probe_corpus r3 r3-violations-extended violation
    probe_corpus r3 r3-legitimate legitimate
    probe_corpus r3 r3-token-coverage violation
    echo ""
    echo "FID leg — live allowlist"
    probe_corpus fid fid-violations violation
    probe_corpus fid fid-legitimate legitimate
    probe_corpus fid fid-token-coverage violation

    # -- R3 OVERSTATEMENT LEG (2026-08-17, ledger F15 recurrence 5) --------------------------
    # G3-C5 measured 3 of 6 gate legs with no fault injection at all. This leg had none: its
    # only recorded probe was "fires on the old wording, passes the corrected tree", every
    # variant of which was written on ONE LINE -- so the probe passed while the guard could not
    # see the wrapped instance sitting in a shipped skill file. A corpus of one-line variants
    # tests the pattern against its own accidental formatting.
    #
    # The corpus is a directory of CASES, not a file of lines, because a datum here has a line
    # break inside it. Cases are materialised as .md files and swept by the REAL f_over_hits.
    echo ""
    echo "R3 overstatement leg — wrapped-phrase cases"
    OVERFIX="$ROOT/scripts/fixtures/r3-overstate/overstate-cases.txt"
    if [ ! -f "$OVERFIX" ]; then
        echo "  PROBE FAIL — overstatement fixture missing: $OVERFIX"
        probe_fail=1
    else
        overdir="$tmp/probe/over"
        mkdir -p "$overdir/evals"
        awk -v out="$overdir" '
            /^=== CASE / { name = $3; flags = ""
                           for (i = 4; i <= NF; i++) flags = flags (flags == "" ? "" : ",") $i
                           print name "\t" flags > (out "/_manifest.tsv")
                           f = out "/" name ".md"; printf "" > f
                           next }
            /^=== NOTE/  { next }
            /^=== /      { print "FORMAT-ERROR\t" $0 > (out "/_manifest.tsv"); next }
                         { if (name != "") print $0 > f }
        ' "$OVERFIX"
        # Two controls that must NOT be reported, the same pair the R3 leg carries: an eval
        # fixture legitimately carries the defect it grades, and a non-markdown file is out of
        # scope by construction. Both are the wrapped form, so they also prove the new code path
        # -- not just the old grep -- honours the filters.
        printf 'FAQPage markup is valid, and Google advises\nagainst removing it.\n' \
            > "$overdir/evals/graded.md"
        printf 'FAQPage markup is valid, and Google advises\nagainst removing it.\n' \
            > "$overdir/notmarkdown.txt"

        over_hits="$( (cd "$tmp" && f_over_hits probe/over) )"
        over_declared="$(probe_declared_count "$OVERFIX")"
        over_n=0; over_ok=0; over_bad=0; over_open=0; over_report=""
        over_bound=""; over_caught_names=""; over_wrapped_names=""
        while IFS="$(printf '\t')" read -r cname cflags; do
            [ -n "$cname" ] || continue
            if [ "$cname" = "FORMAT-ERROR" ]; then
                echo "  PROBE FAIL — overstate-cases.txt line is neither a case, a note, nor case content: $cflags"
                probe_fail=1; continue
            fi
            over_n=$((over_n + 1))
            hit="$(printf '%s\n' "$over_hits" | grep -F "probe/over/$cname.md:" || true)"
            is_caught=0; [ -n "$hit" ] && is_caught=1
            is_wrapmarked=0
            printf '%s' "$hit" | grep -qF 'straddles a line break' && is_wrapmarked=1
            case ",$cflags," in *,SUBJECT-BOUND,*) over_bound="$over_bound $cname" ;; esac
            case ",$cflags," in
                *,CLEAN,*)
                    if [ "$is_caught" -eq 1 ]; then
                        over_bad=$((over_bad + 1))
                        over_report="$over_report
    $cname FALSE POSITIVE — a sentence the library must be able to write is now failed"
                    else
                        over_ok=$((over_ok + 1))
                    fi ;;
                *,MISSED,*)
                    if [ "$is_caught" -eq 1 ]; then
                        over_bad=$((over_bad + 1))
                        over_report="$over_report
    $cname declared MISSED but is CAUGHT — the guard got wider and the fixture now lies"
                    else
                        over_open=$((over_open + 1))
                        over_report="$over_report
    $cname OPEN HOLE (declared): still not caught"
                    fi ;;
                *)
                    if [ "$is_caught" -eq 1 ]; then
                        over_ok=$((over_ok + 1))
                        over_caught_names="$over_caught_names $cname"
                        [ "$is_wrapmarked" -eq 1 ] && over_wrapped_names="$over_wrapped_names $cname"
                    else
                        over_bad=$((over_bad + 1))
                        over_report="$over_report
    $cname MISSED and not declared — this is the blindness, not a note about it"
                    fi ;;
            esac
            # A case that says its phrase straddles a break must BE straddling one. Without this
            # the corpus can be silently disarmed by a reflow: the lines join, every case still
            # passes, and the wrapped variants stop existing while the numbers stay full.
            case ",$cflags," in
                *,WRAPPED,*)
                    if [ "$is_caught" -eq 1 ] && [ "$is_wrapmarked" -eq 0 ]; then
                        over_bad=$((over_bad + 1))
                        over_report="$over_report
    $cname declares WRAPPED but the sweep found the phrase whole on one line — the case was reflowed and now tests the easy form"
                    fi ;;
            esac
        done < "$overdir/_manifest.tsv"
        if [ -z "$over_declared" ] || [ "$over_declared" -ne "$over_n" ]; then
            echo "  PROBE FAIL — overstate-cases.txt declares COUNT: ${over_declared:-<none>} but parses $over_n case(s)"
            probe_fail=1
        fi
        [ "$over_n" -eq 0 ] && { echo "  PROBE FAIL — the overstatement corpus has no cases; a corpus that measures nothing cannot pass"; probe_fail=1; }
        n_wrapped=$(printf '%s' "$over_wrapped_names" | wc -w)
        printf '  %-28s %2d cases | %2d as declared | %2d WRONG | %2d declared open | %2d caught wrapped\n' \
            "overstate-cases" "$over_n" "$over_ok" "$over_bad" "$over_open" "$n_wrapped"
        [ -n "$over_report" ] && echo "  $over_report"
        [ "$over_bad" -gt 0 ] && probe_fail=1

        # Filter controls, asserted the same way the R3 leg asserts its own.
        printf '%s\n' "$over_hits" | grep -q '/evals/' && { echo "  PROBE FAIL — evals/ exclusion not applied on the overstatement leg"; probe_fail=1; }
        printf '%s\n' "$over_hits" | grep -q 'notmarkdown' && { echo "  PROBE FAIL — non-markdown file swept on the overstatement leg"; probe_fail=1; }

        # LOAD-BEARING, in the direction this leg's second pattern actually works. The FAQ/schema
        # conjunct is a REQUIREMENT, not an excuse, so the test is the mirror of the allowlist
        # one: make it trivially true and every case that claims to be clean BECAUSE of it must
        # fire. A "legitimate" case that stays quiet under that substitution is quiet for some
        # reason nobody has tested, and is measuring nothing.
        save="$R3_OVER_SUBJECT"; R3_OVER_SUBJECT='.'
        lb_hits="$( (cd "$tmp" && f_over_hits probe/over) )"
        R3_OVER_SUBJECT="$save"
        lb_n=0; lb_quiet=""
        for cname in $over_bound; do
            lb_n=$((lb_n + 1))
            printf '%s\n' "$lb_hits" | grep -qF "probe/over/$cname.md:" || lb_quiet="$lb_quiet $cname"
        done
        if [ -n "$lb_quiet" ]; then
            echo "  PROBE FAIL — SUBJECT-BOUND case(s) stay clean with the FAQ/schema conjunct made trivial, so nothing about them is being tested:$lb_quiet"
            probe_fail=1
        else
            printf '  Conjunct load-bearing (subject requirement made trivial, every SUBJECT-BOUND case must fire): %d/%d\n' "$lb_n" "$lb_n"
        fi

        # ALTERNATIVE COVERAGE, derived from the live pattern rather than from a list beside it,
        # and with the F15-r5 rule made mechanical: each alternative needs a case that is caught
        # AND a case whose phrase straddles a break. An alternative added tomorrow with only a
        # one-line variant fails here instead of joining the unmeasured set -- which is exactly
        # how this leg came to ship blind.
        echo "  Per-alternative coverage (each needs a caught case AND a wrapped caught case):"
        save_over="$R3_OVERSTATE"; alt_bad=0
        while IFS= read -r alt; do
            [ -n "$alt" ] || continue
            R3_OVERSTATE="$alt"
            a_hits="$( (cd "$tmp" && f_over_hits probe/over) )"
            a_all=0; a_wrap=0
            for cname in $over_caught_names; do
                h="$(printf '%s\n' "$a_hits" | grep -F "probe/over/$cname.md:" || true)"
                [ -n "$h" ] || continue
                a_all=$((a_all + 1))
                printf '%s' "$h" | grep -qF 'straddles a line break' && a_wrap=$((a_wrap + 1))
            done
            if [ "$a_all" -eq 0 ] || [ "$a_wrap" -eq 0 ]; then
                echo "    PROBE FAIL — $a_all caught / $a_wrap wrapped: $alt"
                echo "                 (add a case to scripts/fixtures/r3-overstate/overstate-cases.txt; a wrapped one)"
                alt_bad=1
            else
                printf '    %2d caught, %2d wrapped  %s\n' "$a_all" "$a_wrap" "$alt"
            fi
        done <<< "$(f_alts "$save_over")"
        R3_OVERSTATE="$save_over"
        [ "$alt_bad" -eq 1 ] && probe_fail=1

        # Both patterns reach awk as dynamic regexes. mawk has no word-boundary escape at all,
        # and a backslash in either would be read as an escape rather than as itself, so the
        # constraint is asserted where it can fail loudly instead of living in a comment.
        case "$R3_OVERSTATE$R3_OVER_SUBJECT" in
            *\\*) echo "  PROBE FAIL — R3_OVERSTATE/R3_OVER_SUBJECT contain a backslash; the awk matcher on this leg has no word-boundary escape and will not read it as written"
                  probe_fail=1 ;;
        esac
    fi

    # TOKEN-LIST COVERAGE (2026-08-17). Everything above measures the ALLOWLIST; nothing measured
    # the TOKEN LIST, and an unexercised token alternative can be deleted with every check staying
    # green. Measured when this was written: `serp accordion` and `Affiliate links disclosed` were
    # reached by no line in any corpus. The requirement is DERIVED from the live pattern — split
    # it, demand a line per alternative — so a token added tomorrow without a fixture line fails
    # here rather than joining the unmeasured set.
    echo ""
    echo "Token-list coverage (each alternative must be exercised by a line no allowlist excuses):"
    tok_cover() {   # <leg> <token regex> <corpus .md> <grep flags>
        _leg="$1"; _tokre="$2"; _corp="$3"; _flags="$4"; _miss=0; _n=0
        while IFS= read -r a; do
            [ -n "$a" ] || continue
            _n=$((_n + 1))
            c=$(grep -c $_flags -- "$a" "$_corp" 2>/dev/null || true)
            if [ "${c:-0}" -eq 0 ]; then
                echo "  PROBE FAIL — $_leg token alternative exercised by NO fixture line: $a"
                echo "               (delete it and every check stays green — add a line to $(basename "$_corp" .md).txt)"
                _miss=1
            fi
        done <<< "$(f_alts "$_tokre")"
        [ "$_miss" -eq 1 ] && probe_fail=1
        [ "$_miss" -eq 0 ] && printf '  %-4s all %d token alternative(s) exercised\n' "$_leg" "$_n"
    }
    tok_cover r3  "$R3_TOKENS"          "$tmp/probe/r3/r3-token-coverage.md"    "-iE"
    tok_cover fid "$DEPRECATED_TOKENS"  "$tmp/probe/fid/fid-token-coverage.md"  "-E"

    # Historical rates, re-derived rather than quoted. Same corpora, same code path, the frozen
    # allowlist strings substituted in.
    echo ""
    echo "Same corpora through the two earlier allowlists (frozen copies, for comparability):"
    hist_rate() {   # <leg> <corpus> <label> <frozen whole-line marker string>
        n_total=$(grep -c '^>>> ' "$FIXDIR/$2.txt")
        if [ "$1" = "r3" ]; then
            save="$R3_EXCUSE"; R3_EXCUSE="$4"; c=$(caught_lines r3 "$2" | grep -c '' ); R3_EXCUSE="$save"
        else
            save="$DEPRECATED_EXCUSE"; DEPRECATED_EXCUSE="$4"; c=$(caught_lines fid "$2" | grep -c ''); DEPRECATED_EXCUSE="$save"
        fi
        printf '  %-46s %2d/%d caught\n' "$3" "$c" "$n_total"
    }
    hist_rate r3  r3-violations  "R3, whole-line unbounded (pre 8f69a7a)"   "$HIST_R3_PRE"
    hist_rate r3  r3-violations  "R3, whole-line word-bounded (8f69a7a)"    "$HIST_R3_BOUNDED"
    hist_rate fid fid-violations "FID, whole-line unbounded (pre 8f69a7a)"  "$HIST_FID_PRE"
    hist_rate fid fid-violations "FID, whole-line word-bounded (8f69a7a)"   "$HIST_FID_BOUNDED"

    # Load-bearing test (engine-claim-sweep v3's lesson: a control that never reaches the stage
    # proves nothing). With an excuse that excuses nothing, every legitimate line must be CAUGHT.
    # A legitimate line that stays clean here is passing because it lacks a token, not because
    # the allowlist protected it, and it is measuring nothing.
    echo ""
    save="$R3_EXCUSE"; R3_EXCUSE="$NEVER"
    lb_r3=$(caught_lines r3 r3-legitimate | grep -c ''); R3_EXCUSE="$save"
    save="$DEPRECATED_EXCUSE"; DEPRECATED_EXCUSE="$NEVER"
    lb_fid=$(caught_lines fid fid-legitimate | grep -c ''); DEPRECATED_EXCUSE="$save"
    tot_r3=$(grep -c '^>>> ' "$FIXDIR/r3-legitimate.txt"); tot_fid=$(grep -c '^>>> ' "$FIXDIR/fid-legitimate.txt")
    printf 'Allowlist load-bearing (excuse blanked, every legitimate line must fail): R3 %d/%d, FID %d/%d\n' \
        "$lb_r3" "$tot_r3" "$lb_fid" "$tot_fid"
    [ "$lb_r3" -eq "$tot_r3" ] || { echo "PROBE FAIL — $((tot_r3 - lb_r3)) R3 legitimate line(s) pass without any allowlist; they test nothing"; probe_fail=1; }
    [ "$lb_fid" -eq "$tot_fid" ] || { echo "PROBE FAIL — $((tot_fid - lb_fid)) FID legitimate line(s) pass without any allowlist; they test nothing"; probe_fail=1; }

    # Filter controls — two that must be EXCLUDED, one that must SURVIVE.
    ( cd "$tmp" && f_r3_hits probe/r3 ) | grep -q '/evals/' && { echo "PROBE FAIL — evals/ exclusion not applied"; probe_fail=1; }
    ( cd "$tmp" && f_r3_hits probe/r3 ) | grep -q 'notmarkdown' && { echo "PROBE FAIL — non-markdown file swept"; probe_fail=1; }
    ( cd "$tmp" && f_r3_hits probe/r3 ) | grep -q 'non-faq-notes' || { echo "PROBE FAIL — a violation in a file NAMED for a marker was excused by its own path"; probe_fail=1; }

    # Provenance, ADVISORY. Every line in the two legitimate corpora was copied verbatim from a
    # live file, and the copy carries `path:line`. The tree moves; the corpus is frozen on
    # purpose, so drift is expected and is NOT a failure — but a reader deciding whether these
    # 20 lines still represent the tree should not have to check by hand. Same idea as the F12
    # anchor rule: the TEXT is authoritative and the line number is derivable from it.
    echo ""
    prov_ok=0; prov_moved=0; prov_gone=0; prov_notes=""
    for corpus in r3-legitimate fid-legitimate; do
        while IFS="	" read -r src ln text; do
            [ -n "$src" ] || continue
            if [ ! -f "$ROOT/$src" ]; then
                prov_gone=$((prov_gone + 1)); prov_notes="$prov_notes
    GONE  $src:$ln — file no longer exists"; continue
            fi
            actual="$(sed -n "${ln}p" "$ROOT/$src")"
            if [ "$actual" = "$text" ]; then
                prov_ok=$((prov_ok + 1))
            else
                found="$(grep -nxF "$text" "$ROOT/$src" 2>/dev/null | head -1 | cut -d: -f1)"
                if [ -n "$found" ]; then
                    prov_moved=$((prov_moved + 1)); prov_notes="$prov_notes
    MOVED $src:$ln -> :$found — same text, new line number"
                else
                    prov_gone=$((prov_gone + 1)); prov_notes="$prov_notes
    GONE  $src:$ln — the line was edited or removed; the frozen copy stands, the citation does not"
                fi
            fi
        done < <(awk '
            /^# [^ ]*\.md:[0-9]+$/ { split(substr($0,3), p, ":"); src = p[1]; ln = p[2]; next }
            /^>>> /                { if (src != "") printf "%s\t%s\t%s\n", src, ln, substr($0,5); src=""; next }
        ' "$FIXDIR/$corpus.txt")
    done
    printf 'Fixture provenance (advisory): %d verbatim at the cited line, %d moved, %d gone\n' \
        "$prov_ok" "$prov_moved" "$prov_gone"
    [ -n "$prov_notes" ] && echo "$prov_notes"

    # Per-member weight on the LIVE tree, which is OPEN-FINDINGS 94 made re-runnable. That row
    # published a sole-excuse concentration (`non-faq` x6, `does not (support|test) faqpage` x3,
    # `no faq rich result` x2, `\bretired\b` x1, `\bended\b` x1) and it went stale the same day:
    # a parallel workstream rewrote the one line `\bretired\b` was holding up. A hand-counted
    # concentration is a snapshot; this is the measurement. For each member: remove it, re-sweep,
    # count the lines that stop being excused. Weight 0 means the member carries nothing today —
    # a deletion candidate, and the only kind of allowlist edit that goes in the right direction.
    # Splitting on `|` is depth-aware: several members contain their own alternation groups.
    #
    # TWO COLUMNS, because one column cannot answer the question that gets asked of it
    # (OPEN-FINDINGS 101, which read a single column of zeros as "22 of 35 members carry nothing").
    # `tree` is the live-tree weight. `fixt` is the same measurement against the FROZEN legitimate
    # corpus — the lines this library looked at and decided it wants. The two disagree in the case
    # that matters: a member at tree 0 / fixt >0 is not dead vocabulary, it is the only thing
    # standing between the guard and a line somebody already had to defend, which has merely moved
    # or been reworded since. Only tree 0 AND fixt 0 is a deletion candidate on the evidence here,
    # and even then it is a deletion decision with a cost — every member is also a rewording the
    # library might legitimately write tomorrow, and the check has three recorded instances of
    # rejecting the most accurate line in the repository. State both numbers; do not delete on one.
    echo ""
    echo "Weight per allowlist member — tree = live-tree lines un-excused, fixt = frozen legitimate"
    echo "lines un-excused, if the member is removed (0/0 = deletion candidate, see the note above):"
    member_weights() {   # <leg> <named> <near>
        leg="$1"
        all="$(f_alts "$2|$3")"
        while IFS= read -r m; do
            [ -n "$m" ] || continue
            named_wo=""; near_wo=""
            while IFS= read -r x; do
                [ -n "$x" ] || continue
                [ "$x" = "$m" ] && continue
                case "|$2|" in *"|$x|"*) named_wo="${named_wo:+$named_wo|}$x" ;; *) near_wo="${near_wo:+$near_wo|}$x" ;; esac
            done <<< "$all"
            [ -n "$named_wo" ] || named_wo="$NEVER"
            [ -n "$near_wo" ] || near_wo="$NEVER"
            if [ "$leg" = "r3" ]; then
                save="$R3_EXCUSE"; R3_EXCUSE="$(f_excuse "$R3_TOKENS" "$named_wo" "$near_wo")"
                w=$( (cd "$ROOT" && f_r3_hits $F_DIRS) | grep -c '' )
                wf=$(caught_lines r3 r3-legitimate | grep -c '')
                R3_EXCUSE="$save"
            else
                save="$DEPRECATED_EXCUSE"; DEPRECATED_EXCUSE="$(f_excuse "$DEPRECATED_TOKENS" "$named_wo" "$near_wo")"
                w=$( (cd "$ROOT" && f_fid_hits $F_DIRS) | grep -c '' )
                wf=$(caught_lines fid fid-legitimate | grep -c '')
                DEPRECATED_EXCUSE="$save"
            fi
            wt_s="  ."; [ "$w"  -gt 0 ] && wt_s=$(printf '%3d' "$w")
            wf_s="  ."; [ "$wf" -gt 0 ] && wf_s=$(printf '%3d' "$wf")
            tag=""
            [ "$w" -eq 0 ] && [ "$wf" -eq 0 ] && tag="   (carries nothing here or in the fixture)"
            [ "$w" -eq 0 ] && [ "$wf" -gt 0 ] && tag="   (nothing live, but holds up a frozen legitimate line)"
            printf '  %-4s tree %s  fixt %s  %s%s\n' "$leg" "$wt_s" "$wf_s" "$m" "$tag"
        done <<< "$all"
    }
    member_weights r3 "$R3_LEGAL_NAMED" "$R3_LEGAL_NEAR"
    member_weights fid "$DEPRECATED_LEGAL_NAMED" "$DEPRECATED_LEGAL_NEAR"

    # Live-tree measurement, printed beside the fixture so "green" is never mistaken for "empty".
    # OPEN-FINDINGS 94 made that point with a hand count — "51 lines match the R3 tokens and 0
    # survive" — which was right on 2026-08-17 and drifts with every edit to the tree. The count
    # below is this commit's, taken from the same sweep check (f) just ran.
    r3_seen=$(cd "$ROOT" && grep -rniE "$R3_TOKENS" $F_DIRS --include='*.md' 2>/dev/null | grep -vc 'evals/')
    fid_seen=$(cd "$ROOT" && grep -rnE "$DEPRECATED_TOKENS" $F_DIRS --include='*.md' 2>/dev/null | grep -vc 'evals/')
    r3_surv=$(printf '%s' "$R3_HITS" | grep -c '' ); [ -z "$R3_HITS" ] && r3_surv=0
    fid_surv=$(printf '%s' "$F_HITS" | grep -c '' ); [ -z "$F_HITS" ] && fid_surv=0
    echo ""
    echo "Live tree, this commit: R3 $r3_seen lines match the tokens, $r3_surv survive the allowlist."
    echo "                        FID $fid_seen lines match the tokens, $fid_surv survive the allowlist."
    # CHECK (i) FAULT INJECTION (OPEN-FINDINGS 95). One synthetic tree, five record directories,
    # one shape each: a directory with no way up to INSTRUMENT-CHANGES.md must be REPORTED, and a
    # directory that reaches it must go quiet. A census that cannot go quiet is a nag, and a
    # census that cannot speak is decoration; this asserts both directions, per clause.
    echo ""
    # Each directory is a control for one clause of the reachability rule, and each doubles as
    # the fault injection for the way that clause has been, or could be, broken:
    #   01  record only, nothing else                  -> REPORTED. The baseline shape.
    #   02  record + sibling note naming the file      -> SILENT. Positive control for the note
    #       clause; it must SURVIVE every stage, or a guard that reports everything also passes.
    #   03  two records, ONE of whose prose names the  -> REPORTED. This is the founding
    #       file                                             blindness, and the second record
    #       is there for two reasons: it makes the point that a mention reaches only the record
    #       carrying it, and it is the only directory with more than one record, so a
    #       `sort -u` dropped from the enumeration turns the scope control red instead of
    #       walking free. Measured 2026-08-18: `grep -r` over the directory read a machine-written
    #       record as a directory pointer, and `blind-2026-08-17/` — 20 records, no README —
    #       passed on 5 incidental mentions. A probe without this control passes on that code.
    #   04  record + a note one level DOWN in sub/     -> REPORTED. Recursive descent is not
    #       reachability: `ls` in the record's own directory does not show it.
    #   05  record + its own copy of INSTRUMENT-CHANGES.md whose TEXT never names the file
    #                                                  -> SILENT. Positive control for the
    #       holds-the-file clause specifically; it is the only directory that clause covers, so
    #       deleting the clause turns it red rather than passing unnoticed.
    #   top.json beside INSTRUMENT-CHANGES.md          -> never listed, covered by the same
    #       holds-the-file clause rather than by a hardcoded exemption for the root.
    # And one standing trap kept from the first version of this probe: the synthetic
    # INSTRUMENT-CHANGES.md NAMES ITSELF in its own text, so a reachability test scoped to the
    # baselines ROOT instead of to the record's own directory silences the whole census. That
    # fault was injected on 2026-08-17 and the FIRST version of this probe passed through it,
    # because the synthetic file happened not to contain the token. A probe that passes on a
    # broken guard is the guard's failure mode wearing a rosette.
    # Finally a SCOPE control (F15-r3's rule): the enumeration itself is asserted, so a change
    # that makes the scan find no records at all — a renamed suffix, a wrong root — turns the
    # probe red instead of reporting a perfectly clean census over nothing.
    i_probe="$tmp/icheck"
    rm -rf "$i_probe"
    mkdir -p "$i_probe/blind-1999-01-01" "$i_probe/blind-1999-01-02" "$i_probe/blind-1999-01-03" \
             "$i_probe/blind-1999-01-04/sub" "$i_probe/blind-1999-01-05"
    i_rec='{"summary":{"passed":1,"failed":0,"total":1,"pass_rate":1.0}}'
    i_note='See ../INSTRUMENT-CHANGES.md before differencing any two records here.'
    printf '# Instrument changes\n\nRows in INSTRUMENT-CHANGES.md are one per change.\n' \
        > "$i_probe/INSTRUMENT-CHANGES.md"
    printf '%s\n' "$i_rec"  > "$i_probe/top.json"
    printf '%s\n' "$i_rec"  > "$i_probe/blind-1999-01-01/rec.json"
    printf '%s\n' "$i_rec"  > "$i_probe/blind-1999-01-02/rec.json"
    printf '%s\n' "$i_note" > "$i_probe/blind-1999-01-02/README.md"
    printf '{"summary":{"passed":1,"failed":0,"total":1,"pass_rate":1.0},"note":"docs/loop/eval-baselines/INSTRUMENT-CHANGES.md carries no row for this change"}\n' \
        > "$i_probe/blind-1999-01-03/rec.json"
    printf '%s\n' "$i_rec"  > "$i_probe/blind-1999-01-03/rec2.json"
    printf '%s\n' "$i_rec"  > "$i_probe/blind-1999-01-04/rec.json"
    printf '%s\n' "$i_note" > "$i_probe/blind-1999-01-04/sub/NOTE.md"
    printf '%s\n' "$i_rec"  > "$i_probe/blind-1999-01-05/rec.json"
    printf '# Instrument changes\n\nRows below are one per change; read before differencing.\n' \
        > "$i_probe/blind-1999-01-05/INSTRUMENT-CHANGES.md"
    i_dirs_seen=$(i_record_dirs "$i_probe" | grep -c '.')
    i_want='blind-1999-01-01 blind-1999-01-03 blind-1999-01-04'
    i_got="$(i_unreachable_dirs "$i_probe" | sed "s|^$i_probe/||" | sort | tr '\n' ' ' | sed 's/ *$//')"
    # The advisory count check (i) prints beside its WARN is asserted too: 1 of the 2 records in
    # 03 names the file, 0 of the 1 in 01 does. A number a gate prints and nothing checks is the
    # shape F16 keeps catching.
    i_self3=$(i_self_naming_records "$i_probe/blind-1999-01-03")
    i_self1=$(i_self_naming_records "$i_probe/blind-1999-01-01")
    printf '%s\n' "$i_note" > "$i_probe/blind-1999-01-01/README.md"
    printf '%s\n' "$i_note" > "$i_probe/blind-1999-01-03/README.md"
    printf '%s\n' "$i_note" > "$i_probe/blind-1999-01-04/README.md"
    i_after=$(i_unreachable_dirs "$i_probe" | grep -c '.')
    if [ "$i_dirs_seen" -eq 6 ] && [ "$i_got" = "$i_want" ] && [ "$i_after" -eq 0 ] \
       && [ "$i_self3" -eq 1 ] && [ "$i_self1" -eq 0 ]; then
        echo "check (i) reachability: 6 record dirs enumerated; reported exactly [$i_got] —"
        echo "                        uncovered / record-prose-only / note-in-a-subdirectory;"
        echo "                        silent on the sibling-note and holds-the-file directories"
        echo "                        and on the root; notes added -> silent (0);"
        echo "                        advisory self-naming count 1 of 2 in the mixed dir, 0 of 1 elsewhere"
    else
        echo "PROBE FAIL — check (i) does not measure what it claims."
        echo "             record dirs enumerated: $i_dirs_seen (want 6; a low count means the scan found no records)"
        echo "             reported: [$i_got]"
        echo "             want:     [$i_want]"
        echo "             after adding the missing sibling notes: $i_after (want 0)"
        echo "             advisory self-naming count: $i_self3 in blind-1999-01-03 (want 1), $i_self1 in blind-1999-01-01 (want 0)"
        probe_fail=1
    fi

    # EXPORT COMPLETENESS (OPEN-FINDINGS 100). `--emit-f-patterns` is now the only supply of these
    # patterns to scripts/eval-expectation-sweep.sh, so an unexported pattern is a pattern that
    # silently stops applying over there — the same silence the hand-copy produced, arriving by a
    # tidier route. The check reads this file's OWN SOURCE for pattern assignments rather than a
    # second list: a list of names maintained beside the names is the defect again.
    # Pattern assignment = a column-0 `R3_*`/`DEPRECATED_*` name ending in TOKENS/LEGAL/NAMED/NEAR/
    # OVERSTATE, or an `F_NEAR_*` window. Per-run RESULTS (R3_HITS, R3_OVER_HITS) do not match, and
    # the frozen HIST_* copies in this block are deliberately not exported — they are history.
    echo ""
    src_names="$(grep -oE '^(R3|DEPRECATED)_[A-Z0-9_]*(TOKENS|LEGAL|NAMED|NEAR|OVERSTATE|SUBJECT)=|^F_NEAR_[A-Z]+=' \
                    "${BASH_SOURCE[0]}" | sed 's/=$//' | sort -u)"
    emitted_names="$(bash "${BASH_SOURCE[0]}" --emit-f-patterns "$ROOT" | cut -f1 | sort -u)"
    unexported="$(comm -23 <(printf '%s\n' "$src_names") <(printf '%s\n' "$emitted_names"))"
    phantom="$(comm -13 <(printf '%s\n' "$src_names") <(printf '%s\n' "$emitted_names"))"
    n_emitted=$(printf '%s\n' "$emitted_names" | grep -c '.')
    if [ -n "$unexported" ]; then
        echo "PROBE FAIL — check (f) pattern(s) not carried by --emit-f-patterns, so eval-expectation-sweep.sh cannot see them:"
        printf '    %s\n' $unexported
        probe_fail=1
    elif [ -n "$phantom" ]; then
        echo "PROBE FAIL — --emit-f-patterns names a variable check (f) no longer assigns: $phantom"
        probe_fail=1
    elif [ "$n_emitted" -lt 6 ]; then
        echo "PROBE FAIL — the export carries only $n_emitted name(s); an empty or near-empty export would let the importer's own canaries pass on nothing"
        probe_fail=1
    else
        echo "Export to eval-expectation-sweep.sh: $n_emitted pattern name(s), complete against this file's own assignments."
    fi

    echo ""
    if [ "$probe_fail" -eq 0 ]; then
        echo "PROBE PASS — every corpus matched its declaration. Declared open holes above are still holes."
        exit 0
    fi
    echo "PROBE FAILED"
    exit 1
fi

# ---------------------------------------------------------------------------
# (g) anchor-tagged pointer check (F12 guard)
# ---------------------------------------------------------------------------
# F12 (2026-08-09, recurrence 1): bare VERSIONS.md line-number pointers in the
# loop registers break on every changelog insertion, so every live pointer is
# anchor-tagged — `<file>:<N>` ("<token>") — and the TOKEN is authoritative.
# This check parses each anchor-tagged pointer in the four LIVE registers and
# fails the gate when the target line no longer CONTAINS its token as a fixed
# substring (grep -F semantics, not regex).
#
# TARGET EXTENSION (2026-08-10 — the "check (g) scope-extension question"
# GATED-ITEMS held for the next scripts-touching wave): the target may be ANY
# repo file, not just VERSIONS.md; same contract, same message, same authority
# on the token. The class is not hypothetical — an E3 Mode A round found
# `optimize/technical-seo-checker/SKILL.md:258` resolving to a BLANK line (fixed
# by hand to :259), and PIPELINE's stage-3 `CLAUDE.md` pointers had silently
# drifted before being corrected to :53/:54. Both were invisible to the
# VERSIONS-only parser. A range target (`file.md:309-310`) passes when the token
# appears anywhere inside the span.
#
# Scope (F12 rationale, unchanged): scan ONLY the live registers —
# SETTLED-RULINGS.md, GATED-ITEMS.md, WATCH-ITEMS.md, PIPELINE.md.
# FAILURE-LEDGER.md is EXCLUDED: it is an append-only ledger that legitimately
# quotes historical pointer examples (its F12 entry keeps `VERSIONS.md:93`
# ("non-levers") as a worked example that was correct at writing time) and must
# never trip the gate. docs/loop/archive/ (frozen snapshots) and
# docs/loop/eval-baselines/ are excluded likewise. GATED-ITEMS' format TEMPLATE
# (literal <line>/<token> placeholders) never matches the digit-requiring
# pattern below.
#
# UN-ANCHORED pointers (bare `file.md:123` with no ("token")) are COUNTED and
# LISTED but never failed: failing pointers whose authors never opted into the
# anchor contract would make the check assert more than it can verify (ledger
# F11), and the fix for them is a tagging pass, not a red gate. The census is
# the standing proposal for that pass.
echo ""
echo "[g] anchor-tagged pointer check (F12 guard; any repo-file target)"
G_OK=1
G_COUNT=0
G_VCOUNT=0
G_UNTAG_N=0
G_UNTAG_LIST=""
G_REGISTERS="SETTLED-RULINGS.md GATED-ITEMS.md WATCH-ITEMS.md PIPELINE.md"
for reg in $G_REGISTERS; do
    reg_file="$ROOT/docs/loop/$reg"
    if [ ! -f "$reg_file" ]; then
        warn "(g) live register missing, skipped: docs/loop/$reg"
        continue
    fi
    # Flatten the register to one string first so a pointer whose ("token")
    # wraps onto the next line (R3's does) still parses; emit
    # "path<TAB>start<TAB>end<TAB>token" (end == start for a single line).
    while IFS=$'\t' read -r ptr_path ptr_start ptr_end ptr_token; do
        [ -n "$ptr_path" ] || continue
        if [ "$ptr_path" = "PARSE-ERR" ]; then
            fail "(g) docs/loop/$reg: malformed pointer \`$ptr_start\` — no closing double quote after its (\" token opener"
            G_OK=0
            continue
        fi
        G_COUNT=$((G_COUNT + 1))
        [ "$ptr_path" = "VERSIONS.md" ] && G_VCOUNT=$((G_VCOUNT + 1))
        span="$ptr_start"
        [ "$ptr_end" != "$ptr_start" ] && span="$ptr_start-$ptr_end"
        if [ -z "$ptr_token" ]; then
            fail "(g) docs/loop/$reg pointer \`$ptr_path:$span\` (\"\") — empty anchor token would match any line; token is authoritative and must be non-empty"
            G_OK=0
            continue
        fi
        target="$ROOT/$ptr_path"
        if [ ! -f "$target" ]; then
            fail "(g) docs/loop/$reg pointer \`$ptr_path:$span\` (\"$ptr_token\") — target file does not exist (pointer paths are repo-root-relative); grep the token to refresh"
            G_OK=0
            continue
        fi
        tgt_lines=$(awk 'END { print NR }' "$target")
        if [ "$ptr_start" -lt 1 ] || [ "$ptr_end" -gt "$tgt_lines" ] || [ "$ptr_end" -lt "$ptr_start" ]; then
            fail "(g) docs/loop/$reg pointer \`$ptr_path:$span\` (\"$ptr_token\") — $ptr_path line $span does not exist (file has $tgt_lines lines); grep the token to refresh"
            G_OK=0
            continue
        fi
        if ! sed -n "${ptr_start},${ptr_end}p" "$target" | grep -qF -- "$ptr_token"; then
            fail "(g) docs/loop/$reg pointer \`$ptr_path:$span\` (\"$ptr_token\") — target lacks its token (token is authoritative; grep it to refresh)"
            sed -n "${ptr_start},${ptr_end}p" "$target" | head -6 \
                | awk -v s="$ptr_start" -v p="$ptr_path" '{ printf "      actual %s:%d: %s\n", p, s + NR - 1, $0 }'
            G_OK=0
        fi
    done < <(awk '
        function lastcolon(s,   i) {
            for (i = length(s); i >= 1; i--) if (substr(s, i, 1) == ":") return i
            return 0
        }
        { buf = buf $0 " " }
        END {
            while (match(buf, /`[A-Za-z0-9_][A-Za-z0-9_.\/-]*\.[A-Za-z0-9]+:[0-9]+(-[0-9]+)?`[ \t\r]*\("/)) {
                head = substr(buf, RSTART, RLENGTH)
                buf  = substr(buf, RSTART + RLENGTH)
                core = head; sub(/^`/, "", core); sub(/`.*$/, "", core)
                c = lastcolon(core)
                path = substr(core, 1, c - 1); sp = substr(core, c + 1)
                st = sp; en = sp
                if (index(sp, "-") > 0) {
                    st = substr(sp, 1, index(sp, "-") - 1)
                    en = substr(sp, index(sp, "-") + 1)
                }
                q = index(buf, "\"")
                if (q == 0) { printf "PARSE-ERR\t%s\t\t\n", core; break }
                printf "%s\t%s\t%s\t%s\n", path, st, en, substr(buf, 1, q - 1)
                buf = substr(buf, q + 1)
            }
        }' "$reg_file")

    # Census of pointers this check CANNOT verify. Line-based (the reader needs
    # a line number to grep), reading each line together with the next so a
    # wrapped ("token") is still recognised as an anchor.
    G_CENSUS=$(awk '
        { lines[NR] = $0 }
        END {
            for (i = 1; i <= NR; i++) {
                s = lines[i] " " lines[i + 1]
                rest = s; off = 0
                while (match(rest, /`[A-Za-z0-9_][A-Za-z0-9_.\/-]*\.[A-Za-z0-9]+:[0-9]+[0-9,-]*`/)) {
                    abs  = off + RSTART
                    m    = substr(rest, RSTART, RLENGTH)
                    tail = substr(rest, RSTART + RLENGTH)
                    off  = off + RSTART + RLENGTH - 1
                    rest = tail
                    if (abs > length(lines[i])) break        # belongs to line i+1
                    if (tail ~ /^[ \t]*\("/) {
                        # anchored: supported forms are :N and :N-M
                        if (m !~ /^`[^`]*:[0-9]+(-[0-9]+)?`$/)
                            printf "UNSUPPORTED\t%d\t%s\n", i, m
                    } else printf "UNTAGGED\t%d\t%s\n", i, m
                }
            }
        }' "$reg_file")
    while IFS=$'\t' read -r kind lno match; do
        [ "$kind" = "UNSUPPORTED" ] || continue
        warn "(g) docs/loop/$reg:$lno anchored pointer $match uses a multi-part line list — this check verifies \`file:N\` and \`file:N-M\` only, so its token goes unverified; split it or rewrite it as a range"
    done <<< "$G_CENSUS"
    n_untag=$(printf '%s\n' "$G_CENSUS" | grep -c '^UNTAGGED' || true)
    if [ "$n_untag" -gt 0 ]; then
        G_UNTAG_N=$((G_UNTAG_N + n_untag))
        G_UNTAG_LIST="${G_UNTAG_LIST}      docs/loop/$reg: $n_untag on line(s) $(printf '%s\n' "$G_CENSUS" | awk -F'\t' '$1 == "UNTAGGED" { printf "%s%s", sep, $2; sep = "," }')
"
    fi
done
if [ "$G_COUNT" -eq 0 ]; then
    fail "(g) parsed ZERO anchor-tagged pointers across the live registers — parser or format drift (at least the six known live \`VERSIONS.md\` pointers should match)"
    G_OK=0
fi
if [ "$G_UNTAG_N" -gt 0 ]; then
    warn "(g) $G_UNTAG_N un-anchored \`file:line\` pointer(s) in the live registers — no (\"token\") anchor, so this check cannot verify them and does NOT fail them; anchor-tag them to bring them under the check"
    printf '%s' "$G_UNTAG_LIST"
fi
[ "$G_OK" -eq 1 ] && pass "(g) all $G_COUNT anchor-tagged \`<file>:<line>\` (\"<token>\") pointers in the live registers verified against their target lines ($G_VCOUNT into VERSIONS.md, $((G_COUNT - G_VCOUNT)) into other repo files)"

# ---------------------------------------------------------------------------
# (h) unsourced quotation-attribution sweep (F3 guard)
# ---------------------------------------------------------------------------
# F3 recurrence 1 (2026-08-10) put a verbatim quotation in the mouth of a named,
# living industry figure, credited a tactical claim to a named Google employee,
# and invented a "Dr. Jane Smith, AI Research Director at Stanford University"
# credential to carry an invented quote — each one inside the GOOD half of a
# before/after pair, praised by its own file's bullets and scored "Citation
# likelihood: 9/10". A user following that guidance publishes a false statement
# about a real, identifiable person under their own byline. That is the most
# serious defect class this library has produced, so it gets a script.
#
# This is the QUOTATION half of the F3 redesign's "could a script catch this?"
# answer, and deliberately only that half. It flags an attribution SHAPE
# carrying no source link near it, in four forms:
#   1. `"…," says|explains|notes <Name>`     (speech verb after a closing quote)
#   2. `<First Last> says|explains|noted …`  (same defect, verb before the quote)
#   3. `According to <Capitalised attributee>`
#   4. `— <Name>, <Role> at <Organisation>`  (attribution line)
# A match is EXEMPT when an http(s) URL sits on the same line or within +/-2
# lines: a quotation whose source the reader can open is the shape this library
# teaches, not the shape it forbids.
#
# Two further exemptions, both load-bearing, both verified against the tree:
#   * Bracketed placeholders. `geo-optimization-techniques.md`'s corrected
#     TEMPLATE — `"[Quote]," says [Name], [Role] at [Organisation] — [where and
#     when they said it … with a link]` — teaches the right shape and must stay
#     legal. Requiring a CAPITAL letter where the attributee goes keeps every
#     `[Placeholder]` out of range without needing an allowlist.
#   * The reserved `Example …` attributee (Example Search Institute, Example
#     Marketing Council, Example Analyst Group) — the sanctioned correction from
#     the same fix. Tested against the MATCHED TEXT, not the whole line and not
#     the path, so a file named `example-report.md` is not blanket-exempted.
# Greek copy needs no exemption of its own: it quotes with guillemets « », not
# the ASCII " these patterns key on.
#
# Scope is check (f)'s live trees. `evals/` is excluded because expectations and
# input fixtures legitimately carry these shapes on purpose (verified:
# content-refresher's stale-article fixture opens a paragraph "According to
# <Firm>'s 2022 SMB survey" as the defect the model is graded on finding).
# `docs/loop/` and `VERSIONS.md` sit outside the swept trees by construction —
# the registers and the changelog quote the fabricated text verbatim, which is
# their job as the record.
#
# The library returns ZERO un-exempted hits as of 2026-08-10, so this check
# starts GREEN: any future hit is a genuine regression, not a backlog. Verified
# by fault injection against the four real historical instances (the industry-
# figure quote, the Google-employee attribution, the invented Stanford
# credential, the firm-credited DMA statistic) in a scratch copy of the tree.
#
# WHAT IT CANNOT CATCH, recorded beside the guard in FAILURE-LEDGER F3: the
# statistics half (a figure credited to a real firm with no attribution verb —
# its only practical form is a name deny-list, which flags a legitimate citation
# exactly as loudly as a fabricated one), and any fabrication that carries a
# plausible-looking link. Neither is a verdict this script can honestly reach.
echo ""
echo "[h] unsourced quotation-attribution sweep (F3 guard)"
H_OK=1
H_SEEN=0
H_EX_URL=0
H_EX_FICT=0
QA_QUOTED='"[[:space:]]*(says|said|explains|explained|notes|noted|argues|argued|adds|added|observes|observed|writes|wrote|tells|told|comments|commented)[[:space:]]+((Dr|Mr|Mrs|Ms|Prof|Professor)\.?[[:space:]]+)?[A-Z][A-Za-z.-]*'
QA_NAMED='[A-Z][a-z]+ [A-Z][a-z]+ (says|said|explains|explained|notes|noted|told|argues|argued)\b'
QA_ACCORDING='[Aa]ccording to[[:space:]]+(the[[:space:]]+)?[A-Z][A-Za-z&.-]*'
QA_DASHLINE='(—|–|--)[[:space:]]*[A-Z][A-Za-z.-]+([[:space:]]+[A-Z][A-Za-z.-]+)+,[^,]{2,60}[[:space:]]at[[:space:]]+[A-Z][A-Za-z&.-]*'
QA_TOKENS="$QA_QUOTED|$QA_NAMED|$QA_ACCORDING|$QA_DASHLINE"
while IFS= read -r hit; do
    [ -n "$hit" ] || continue
    h_file=${hit%%:*}; h_rest=${hit#*:}
    h_line=${h_rest%%:*}; h_text=${h_rest#*:}
    H_SEEN=$((H_SEEN + 1))
    # Sanctioned fictional attributee, or a bracketed template placeholder.
    case "$h_text" in
        *Example*|*'['*) H_EX_FICT=$((H_EX_FICT + 1)); continue ;;
    esac
    h_lo=$((h_line - 2))
    [ "$h_lo" -lt 1 ] && h_lo=1
    if sed -n "${h_lo},$((h_line + 2))p" "$ROOT/$h_file" 2>/dev/null | grep -qE 'https?://'; then
        H_EX_URL=$((H_EX_URL + 1))
        continue
    fi
    fail "(h) attribution with no source link within +/-2 lines — $h_file:$h_line \`$h_text…\` — cite a real source you read and can link (put its http(s) URL beside the claim), use a clearly fictional \`Example …\` attribution, or drop the attribution"
    H_OK=0
done < <(cd "$ROOT" && grep -rnoE "$QA_TOKENS" \
    research build optimize monitor cross-cutting commands references \
    --include='*.md' 2>/dev/null | grep -v 'evals/' | awk -F: '!seen[$1":"$2]++')
[ "$H_OK" -eq 1 ] && pass "(h) no unsourced quotation attribution in live skill, command, or framework files ($H_SEEN attribution shape(s) seen: $H_EX_URL carried a source URL within +/-2 lines, $H_EX_FICT used a fictional \`Example …\` attributee or a bracketed placeholder)"

# ---------------------------------------------------------------------------
# (i) instrument-change reachability (OPEN-FINDINGS 95)
# ---------------------------------------------------------------------------
# docs/loop/eval-baselines/INSTRUMENT-CHANGES.md records which baselines stopped being comparable
# to their successors, and it opens "Read this before comparing any two scores in this directory."
# Its own stated mechanism is a hope: "a reader comparing two numbers reaches this directory
# first". They do not. A grader is sent to a record BY PATH — by the skill-reviewer's regression
# instruction and by PIPELINE's stage description — and six of the records it governs sit one
# directory BELOW it, where nothing names it and `ls` shows nothing.
#
# This is a CENSUS, not a gate, and deliberately WARN-only: the fix is a one-line pointer in each
# records directory, which is a docs edit, and failing a push over a missing note would be the
# check asserting more than it can verify (F11). It goes silent the moment the pointer lands.
# Vacuity is reported rather than passed: if the directory or the file is absent, this check
# measured nothing and says so, because "no unreachable records" and "no records" print the same
# green otherwise (F15's founding shape).
#
# WHAT CHECK (i) STILL CANNOT SEE — recorded 2026-08-18 with the repair below, because a green
# (i) is otherwise read as "the instrument record is in good order", and it says nothing of the
# kind. It tests one fact: is there a note beside these records naming the file.
#   * Presence, never accuracy or currency. A note proves a pointer exists, never that
#     INSTRUMENT-CHANGES.md holds a row for the change that made THESE records non-comparable.
#     `blind-2026-08-17/seo-content-writer.json` records that exact gap in its own evidence —
#     no row for `3a8d62c`, the sweep that rewrote one expectation in all 20 suites — and this
#     check would pass that directory the moment any note landed in it.
#   * Presence, never resolvability. It matches the token, not a working link: a note reading
#     "see INSTRUMENT-CHANGES.md" with no path, or with a path that does not resolve, is counted
#     as covered. Whether to promote that to a link check is a deliberate non-decision here —
#     the check's stated semantics are "names it", and widening them silently is how a check
#     ends up measuring something other than what its comment claims.
#   * Presence, never reading. `ls` showing a README is not a grader opening it.
#   * `docs/loop/eval-baselines/` only. A record saved anywhere else — a workspace path handed
#     to a Mode B run, an agent scratchpad — is outside the scan by construction.
#   * It cannot fail the gate. A WARN is skippable, and this one has been skipped before.
echo ""
echo "[i] instrument-change reachability (OPEN-FINDINGS 95; census, never fails the gate)"
I_BASE="$ROOT/docs/loop/eval-baselines"
I_IC="$I_BASE/INSTRUMENT-CHANGES.md"
if [ ! -d "$I_BASE" ]; then
    warn "(i) no docs/loop/eval-baselines/ directory — this check measured nothing"
elif [ ! -f "$I_IC" ]; then
    warn "(i) docs/loop/eval-baselines/INSTRUMENT-CHANGES.md is absent — nothing records which baselines stopped being comparable, and this check measured nothing"
else
    I_RECORDS=$(find "$I_BASE" -type f -name '*.json' 2>/dev/null | grep -c '.')
    I_UNREACH="$(i_unreachable_dirs "$I_BASE")"
    I_UNREACH_N=$(printf '%s\n' "$I_UNREACH" | grep -c '.')
    if [ "$I_RECORDS" -eq 0 ]; then
        warn "(i) INSTRUMENT-CHANGES.md exists but there are no baseline records under it — this check measured nothing"
    elif [ "$I_UNREACH_N" -gt 0 ]; then
        I_BELOW=$(printf '%s\n' "$I_UNREACH" | while IFS= read -r d; do [ -n "$d" ] && find "$d" -maxdepth 1 -name '*.json' | grep -c '.'; done | awk '{s+=$1} END {print s+0}')
        warn "(i) $I_BELOW baseline record(s), in $I_UNREACH_N director$( [ "$I_UNREACH_N" -eq 1 ] && echo y || echo ies) below docs/loop/eval-baselines/, cannot reach INSTRUMENT-CHANGES.md — a grader sent to one of these BY PATH is never shown that its instrument moved; one line naming the file, in a sibling note in each directory, closes it. A record naming the file in its OWN prose does not count and is listed below only as a signal: it reaches the one record that carries it, and the next run that rewrites that record erases it"
        printf '%s\n' "$I_UNREACH" | while IFS= read -r d; do
            [ -z "$d" ] && continue
            printf '      %s — %s of %s record(s) name the file in their own prose (not counted)\n' \
                "${d#$ROOT/}" "$(i_self_naming_records "$d")" "$(find "$d" -maxdepth 1 -type f -name '*.json' | grep -c '.')"
        done
    else
        pass "(i) all $I_RECORDS baseline record(s) sit in a directory carrying a sibling note that names INSTRUMENT-CHANGES.md"
        i_record_dirs "$I_BASE" | while IFS= read -r d; do
            printf '      %s <- %s\n' "${d#$ROOT/}/" "$(i_dir_note "$d" | sed "s|^$ROOT/||")"
        done
    fi
fi

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------
echo ""
echo "=============================================="
echo "Results: $PASS_N passed, $WARN_N warnings, $FAIL_N failed"
if [ "$FAIL_N" -gt 0 ]; then
    echo "validate-tracking FAILED — tracking files are out of sync"
    exit 1
fi
if [ "$WARN_N" -gt 0 ]; then
    echo "validate-tracking PASSED with warnings"
else
    echo "validate-tracking PASSED — repo tracking files are consistent"
fi
exit 0
