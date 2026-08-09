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
done < <(awk -F'|' 'NF>=4 { gsub(/^[ \t]+|[ \t]+$/, "", $2); if ($2 != "" && $2 != "Skill" && $2 !~ /^-+$/) print $2 }' "$VERSIONS")

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
# R3 token class (added 2026-08-09; settled ruling R3): Google retired FAQ rich
# results in 2026 — FAQPage markup stays ONLY for AI-engine/GEO parsing. Live
# files may mention FAQ near "rich result"/"eligibility"/the accordion visual
# ONLY when the same line acknowledges the retirement (a marker in R3_LEGAL,
# e.g. "FAQ rich results retired 2026", "non-FAQ types", "FAQ: none"); a line
# without such a marker is a retired SERP-eligibility claim taught as live.
# Case-insensitive (tables write "Rich Results (FAQ)"). Same scope as the
# tokens above: live trees only — docs/loop legitimately quotes the retired
# state (SETTLED-RULINGS R3 itself) and stays out of the sweep.
R3_TOKENS='faq.*rich[- ]?(result|snippet)|rich[- ]?(result|snippet)s?.*faq|eligib[^.|]*faq|faq[^.|]*eligib|expandable q&a below|faq (accordion|dropdown|drop-down)|serp accordion'
R3_LEGAL='retired|retirement|no longer|non-faq|no faq (support|eligibility)|faq(:| has) none|dropped faq support|do not run it through|"add faq rich results"'
R3_HITS=$(grep -rniE "$R3_TOKENS" \
    research build optimize monitor cross-cutting commands references \
    --include='*.md' 2>/dev/null | grep -v 'evals/' | grep -viE "$R3_LEGAL" || true)
if [ -n "$R3_HITS" ]; then
    while IFS= read -r hit; do
        fail "(f) FAQ rich-result eligibility claim (FAQ rich results retired 2026, ruling R3): $hit"
    done <<< "$R3_HITS"
    F_OK=0
fi
[ "$F_OK" -eq 1 ] && pass "(f) no deprecated tokens (FID / First Input Delay / affiliate-only T04) and no un-acknowledged FAQ rich-result claims (R3) in live skill, command, or framework files"

# ---------------------------------------------------------------------------
# (g) settled-pointer anchor check (F12 guard)
# ---------------------------------------------------------------------------
# F12 (2026-08-09, recurrence 1): bare VERSIONS.md line-number pointers in the
# loop registers break on every changelog insertion, so every live pointer is
# anchor-tagged — `VERSIONS.md:<N>` ("<token>") — and the TOKEN is
# authoritative. This check parses each anchor-tagged pointer in the four LIVE
# registers and fails the gate when VERSIONS.md line N no longer CONTAINS its
# token as a fixed substring (grep -F semantics, not regex).
# Scope (F12 rationale): scan ONLY the live registers — SETTLED-RULINGS.md,
# GATED-ITEMS.md, WATCH-ITEMS.md, PIPELINE.md. FAILURE-LEDGER.md is EXCLUDED:
# it is an append-only ledger that legitimately quotes historical pointer
# examples (its F12 entry keeps `VERSIONS.md:93` ("non-levers") as a worked
# example that was correct at writing time) and must never trip the gate.
# docs/loop/archive/ (frozen snapshots) and docs/loop/eval-baselines/ are
# excluded likewise. GATED-ITEMS' format TEMPLATE (literal <line>/<token>
# placeholders) never matches the digit-requiring pattern below, and bare
# un-anchored refs (e.g. PIPELINE.md's `VERSIONS.md:3`) are ignored by design.
echo ""
echo "[g] settled-pointer anchor check (F12 guard)"
G_OK=1
G_COUNT=0
G_REGISTERS="SETTLED-RULINGS.md GATED-ITEMS.md WATCH-ITEMS.md PIPELINE.md"
G_VLINES=$(awk 'END { print NR }' "$VERSIONS")
for reg in $G_REGISTERS; do
    reg_file="$ROOT/docs/loop/$reg"
    if [ ! -f "$reg_file" ]; then
        warn "(g) live register missing, skipped: docs/loop/$reg"
        continue
    fi
    # Flatten the register to one string first so a pointer whose ("token")
    # wraps onto the next line (R3's does) still parses; emit "N<TAB>token".
    while IFS=$'\t' read -r ptr_line ptr_token; do
        [ -n "$ptr_line" ] || continue
        if [ "$ptr_line" = "PARSE-ERR" ]; then
            fail "(g) docs/loop/$reg: malformed pointer \`VERSIONS.md:$ptr_token\` — no closing double quote after its (\" token opener"
            G_OK=0
            continue
        fi
        G_COUNT=$((G_COUNT + 1))
        if [ -z "$ptr_token" ]; then
            fail "(g) docs/loop/$reg pointer \`VERSIONS.md:$ptr_line\` (\"\") — empty anchor token would match any line; token is authoritative and must be non-empty"
            G_OK=0
            continue
        fi
        if [ "$ptr_line" -lt 1 ] || [ "$ptr_line" -gt "$G_VLINES" ]; then
            fail "(g) docs/loop/$reg pointer \`VERSIONS.md:$ptr_line\` (\"$ptr_token\") — VERSIONS.md line $ptr_line does not exist (file has $G_VLINES lines); grep the token to refresh"
            G_OK=0
            continue
        fi
        actual=$(sed -n "${ptr_line}p" "$VERSIONS")
        if ! printf '%s\n' "$actual" | grep -qF -- "$ptr_token"; then
            fail "(g) docs/loop/$reg pointer \`VERSIONS.md:$ptr_line\` (\"$ptr_token\") — target line lacks its token (token is authoritative; grep it to refresh)"
            printf '      actual VERSIONS.md:%s: %s\n' "$ptr_line" "$actual"
            G_OK=0
        fi
    done < <(awk '
        { buf = buf $0 " " }
        END {
            while (match(buf, /`VERSIONS\.md:[0-9]+`[ \t\r]*\("/)) {
                head = substr(buf, RSTART, RLENGTH)
                buf  = substr(buf, RSTART + RLENGTH)
                n = head; gsub(/[^0-9]/, "", n)
                q = index(buf, "\"")
                if (q == 0) { printf "PARSE-ERR\t%s\n", n; break }
                printf "%s\t%s\n", n, substr(buf, 1, q - 1)
                buf = substr(buf, q + 1)
            }
        }' "$reg_file")
done
if [ "$G_COUNT" -eq 0 ]; then
    fail "(g) parsed ZERO anchor-tagged pointers across the live registers — parser or format drift (at least the six known live pointers should match)"
    G_OK=0
fi
[ "$G_OK" -eq 1 ] && pass "(g) all $G_COUNT anchor-tagged \`VERSIONS.md:<line>\` (\"<token>\") pointers in the live registers verified against their target lines"

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
