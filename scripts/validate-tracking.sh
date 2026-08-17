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
#              Fault-injection for check (f)'s two allowlists against the checked-in corpus in
#              scripts/fixtures/r3-allowlist/. Prints caught/missed per corpus and FAILS when a
#              violation is excused. See the probe block below check (f) for why it exists.
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
PROBE=0
if [ "${1:-}" = "--probe" ]; then
    PROBE=1
    shift
fi

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

if [ "$PROBE" -eq 1 ]; then
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
# same design error the note above is about. The check is grep-AND by pipe —
# grep -E has no conjunction.
# Widened 2026-08-13 after a Mode A pass measured the first form at **3 of 8**
# constructed variants — it caught `advises against removing` and two siblings and
# missed `advised against removing` (past tense), `recommends against`, `discourages`,
# `tells you not to remove`, `says you should keep`. That is F15's own root cause: a
# pattern written from its founding instance. The probe recorded with the original
# discharged only guard (a) — it fires on the known defect — and left (b) undone.
R3_OVERSTATE='(advis|recommend|counsel)(es|s|ed)? against ([a-z]+ )?(remov|delet|drop)|discourages? ([a-z]+ )?(remov|delet|drop)|tells you not to (remove|delete|drop)|says you should keep'
R3_OVER_HITS=$(cd "$ROOT" && grep -rniE "$R3_OVERSTATE" $F_DIRS \
    --include='*.md' 2>/dev/null | grep -v 'evals/' \
    | grep -iE 'faq|schema|structured data|markup' || true)
if [ -n "$R3_OVER_HITS" ]; then
    while IFS= read -r hit; do
        fail "(f) R3 overstatement — Google permits dropping FAQPage markup and says only that there is no need to proactively remove it; it never advised against removal. Write the permission, not a recommendation: $hit"
    done <<< "$R3_OVER_HITS"
    F_OK=0
fi
[ "$F_OK" -eq 1 ] && pass "(f) no deprecated tokens (FID / First Input Delay / affiliate-only T04) and no un-acknowledged FAQ rich-result claims (R3) in live skill, command, or framework files"

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
    for f in r3-violations r3-violations-extended r3-legitimate; do
        probe_parse "$FIXDIR/$f.txt" | cut -f2- > "$tmp/probe/r3/$f.md"
    done
    for f in fid-violations fid-legitimate; do
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
    echo ""
    echo "FID leg — live allowlist"
    probe_corpus fid fid-violations violation
    probe_corpus fid fid-legitimate legitimate

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
    echo ""
    echo "Live-tree weight per allowlist member (lines un-excused if the member is removed):"
    member_weights() {   # <leg> <named> <near>
        leg="$1"
        all="$(printf '%s|%s' "$2" "$3" | awk '{
            d = 0; cur = "";
            for (i = 1; i <= length($0); i++) {
                c = substr($0, i, 1);
                if (c == "(") d++;
                else if (c == ")") d--;
                if (c == "|" && d == 0) { print cur; cur = ""; } else cur = cur c;
            }
            print cur;
        }')"
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
                R3_EXCUSE="$save"
            else
                save="$DEPRECATED_EXCUSE"; DEPRECATED_EXCUSE="$(f_excuse "$DEPRECATED_TOKENS" "$named_wo" "$near_wo")"
                w=$( (cd "$ROOT" && f_fid_hits $F_DIRS) | grep -c '' )
                DEPRECATED_EXCUSE="$save"
            fi
            [ "$w" -gt 0 ] && printf '  %-4s %3d  %s\n' "$leg" "$w" "$m"
            [ "$w" -eq 0 ] && printf '  %-4s   .  %s   (carries nothing today)\n' "$leg" "$m"
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
