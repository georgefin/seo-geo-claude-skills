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
# No network access. Dependencies: bash, coreutils, grep, sed, awk, sort, comm.

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

# Top-level "version" in plugin.json. The manifest also contains "schemaVersion",
# which does NOT match '"version"' (quote must directly precede the word).
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
[ "$A_OK" -eq 1 ] && pass "(a) version '$PLUGIN_VER' consistent across plugin.json, marketplace.json (x$MKT_COUNT), README badge"

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
#   Compares the top-level 'version:' frontmatter field. Also cross-checks the
#   nested 'metadata.version' field, since VERSIONS.md:5 declares THAT field
#   authoritative — the two must not drift from each other.
# ---------------------------------------------------------------------------
echo ""
echo "[c] SKILL.md frontmatter version == VERSIONS.md row"

C_OK=1
C_CHECKED=0
while IFS= read -r rel; do
    [ -n "$rel" ] || continue
    name=$(basename "$rel")
    skill_file="$ROOT/${rel#./}/SKILL.md"

    top_ver=$(awk 'n<2 && /^---[[:space:]]*$/{n++; next} n==1 && /^version:/{sub(/^version:[[:space:]]*/,""); gsub(/["'"'"'\r]/,""); print; exit}' "$skill_file")
    meta_ver=$(awk 'n<2 && /^---[[:space:]]*$/{n++; next} n==1 && /^[[:space:]]+version:/{sub(/^[[:space:]]+version:[[:space:]]*/,""); gsub(/["'"'"'\r]/,""); print; exit}' "$skill_file")

    # VERSIONS.md row: | name | category | version | date |
    row_ver=$(awk -F'|' -v n="$name" '{
        gsub(/^[ \t]+|[ \t]+$/, "", $2); gsub(/^[ \t]+|[ \t]+$/, "", $4);
        if ($2 == n) { print $4; exit }
    }' "$VERSIONS")

    if [ -z "$top_ver" ]; then
        fail "(c) $rel/SKILL.md has no top-level 'version:' frontmatter field"
        C_OK=0
        continue
    fi
    if [ -z "$row_ver" ]; then
        fail "(c) $name has no row in VERSIONS.md skills table"
        C_OK=0
        continue
    fi
    if [ "$top_ver" != "$row_ver" ]; then
        fail "(c) $rel: SKILL.md version '$top_ver' != VERSIONS.md row '$row_ver'"
        C_OK=0
    fi
    if [ -n "$meta_ver" ] && [ "$meta_ver" != "$top_ver" ]; then
        fail "(c) $rel: frontmatter version '$top_ver' != metadata.version '$meta_ver' (VERSIONS.md:5 declares metadata.version authoritative — keep both in lockstep)"
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
done < <(awk -F'|' 'NF>=4 { gsub(/^[ \t]+|[ \t]+$/, "", $2); if ($2 != "" && $2 != "Skill" && $2 !~ /^-+$/) print $2 }' "$VERSIONS")

[ "$C_OK" -eq 1 ] && pass "(c) all $C_CHECKED SKILL.md versions match VERSIONS.md (and metadata.version in lockstep); no orphan rows"

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
