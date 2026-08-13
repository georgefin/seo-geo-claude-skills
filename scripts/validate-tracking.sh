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
# Exit:    0 = all checks pass (warnings allowed), 1 = any FAIL, 2 = usage/setup error
# No network access. Dependencies: bash, coreutils, grep, sed, awk, sort, comm, cmp (diffutils).

set -u

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
DEPRECATED_TOKENS='\bFID\b|First Input Delay|Affiliate links disclosed'
F_HITS=$(grep -rnE "$DEPRECATED_TOKENS" \
    research build optimize monitor cross-cutting commands references \
    --include='*.md' 2>/dev/null | grep -v 'evals/' || true)
if [ -n "$F_HITS" ]; then
    while IFS= read -r hit; do
        fail "(f) deprecated token still taught: $hit"
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
R3_LEGAL='retired|retirement|ended|ceased|discontinued|no longer|non-faq|no faq (support|eligibility)|faq(:| has) none|dropped faq support|do not run it through|"add faq rich results"|no evidenced citation benefit|no need to (proactively )?remove|scheduled for august 2026|has none since|no faq rich result|government (and|/)ted?health|government and health|government/health|restricted (them )?to|2023-08-08|aug 2023|does not (support|test) faqpage|not (the route|supported) for faqpage|unverified'
R3_HITS=$(grep -rniE "$R3_TOKENS" \
    research build optimize monitor cross-cutting commands references \
    --include='*.md' 2>/dev/null | grep -v 'evals/' | grep -viE "$R3_LEGAL" || true)
if [ -n "$R3_HITS" ]; then
    while IFS= read -r hit; do
        fail "(f) FAQ rich-result eligibility claim (FAQ rich results retired 2026, ruling R3): $hit"
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
R3_OVERSTATE='advises against ([a-z]+ )?remov'
R3_OVER_HITS=$(grep -rniE "$R3_OVERSTATE" \
    research build optimize monitor cross-cutting commands references \
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
