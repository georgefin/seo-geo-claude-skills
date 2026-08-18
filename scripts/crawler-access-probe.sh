#!/usr/bin/env bash
# crawler-access-probe.sh — measure how an edge treats each AI crawler user-agent.
#
# WHY THIS FILE EXISTS. On 2026-08-18 a five-user-agent probe of www.sanihellas.gr found two
# different refusals at the Cloudflare edge: GPTBot and ClaudeBot got a hard 403 with no
# `cf-mitigated` header (no challenge to solve), while PerplexityBot, Googlebot and desktop
# Chrome got a 403 carrying `cf-mitigated: challenge` (a JS interstitial a real browser clears).
# That split is the whole finding, and five agents were not enough to act on it, because the
# agents that govern LIVE CITATION VISIBILITY — the ones that decide whether a brand can be
# quoted in ChatGPT Search, Gemini and Perplexity answers — were not among them.
#
# THE TWO HYPOTHESES THIS SCRIPT DISCRIMINATES. Cloudflare's AI bot controls are scoped BY
# BEHAVIOUR CATEGORY, not by vendor: the training-crawler toggle blocks bots classified as
# crawling to train models, and leaves search and assistant bots alone.
#
#   H1  CATEGORY-SCOPED TRAINING BLOCK. Only GPTBot and ClaudeBot (training) are hard-blocked.
#       OAI-SearchBot, ChatGPT-User, Claude-User, Claude-SearchBot, PerplexityBot and
#       Perplexity-User are merely challenged. The citation path is open and the configuration
#       is defensible — arguably what an operator would choose on purpose.
#
#   H2  BROAD AI BLOCK. The search and assistant agents are ALSO hard-blocked. The citation
#       path is shut on the only property that can take an order, and every content improvement
#       made to it is invisible to the surfaces the engagement is aimed at.
#
# H1 and H2 produce identical results on the original five agents. They differ ONLY on the
# agents this script adds. That is why it exists.
#
# WHAT A RESULT HERE CANNOT TELL YOU. Every request this script sends is UNVERIFIED: it
# carries a claimed user-agent string from an arbitrary IP. Cloudflare's Verified Bots
# allowlist recognises real crawlers by published IP list, reverse DNS, or a Web Bot Auth
# signature — none of which a spoofed request has. So a `challenge` row does NOT prove the real
# crawler is challenged (a verified bot may skip the challenge entirely), and a `hard-blocked`
# row does not prove the real crawler is blocked either. The script measures USER-AGENT-STRING
# MATCHING at the edge. Only the zone's own Bot Analytics, which logs verified crawlers by
# category, measures what real crawlers actually got. The output repeats this, because the
# table gets pasted somewhere the header does not travel.
#
# Usage:
#   bash scripts/crawler-access-probe.sh                        # default targets + control
#   bash scripts/crawler-access-probe.sh HOST [HOST...]         # probe named hosts
#   CONTROL=https://www.example.com bash scripts/crawler-access-probe.sh
#
# Requires: curl. No egress from the library's own execution environment — see
# docs/loop/pilot/tooling-assessment-2026-08-18.md §4.1. Run it from a normal network.

set -uo pipefail

TARGETS=("${@}")
if [ ${#TARGETS[@]} -eq 0 ]; then
  TARGETS=("https://www.sanihellas.gr" "https://www.kullhaus.gr")
fi
PATHS=("/" "/robots.txt")
TIMEOUT="${TIMEOUT:-20}"

# name|tier|user-agent
# Tier is the client's stated citation-visibility priority, not a judgement about the engines.
AGENTS=(
"OAI-SearchBot|1|Mozilla/5.0 (compatible; OAI-SearchBot/1.0; +https://openai.com/searchbot)"
"ChatGPT-User|1|Mozilla/5.0 (compatible; ChatGPT-User/1.0; +https://openai.com/bot)"
"Google-Extended|2|Mozilla/5.0 (compatible; Google-Extended)"
"Googlebot|2|Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)"
"PerplexityBot|3|Mozilla/5.0 (compatible; PerplexityBot/1.0; +https://perplexity.ai/perplexitybot)"
"Perplexity-User|3|Mozilla/5.0 (compatible; Perplexity-User/1.0; +https://perplexity.ai/perplexity-user)"
"Claude-User|4|Mozilla/5.0 (compatible; Claude-User/1.0; +https://www.anthropic.com/claude-user)"
"Claude-SearchBot|4|Mozilla/5.0 (compatible; Claude-SearchBot/1.0; +https://www.anthropic.com/claude-searchbot)"
"GPTBot|training|Mozilla/5.0 (compatible; GPTBot/1.1; +https://openai.com/gptbot)"
"ClaudeBot|training|Mozilla/5.0 (compatible; ClaudeBot/1.0; +claudebot@anthropic.com)"
"Chrome-control|control|Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36"
)

probe() { # $1=url $2=ua -> "status|cf-mitigated|server|bytes|cf-ray|rc"
  local hdr body rc status mitig server bytes ray
  hdr=$(mktemp); body=$(mktemp)
  curl -sS -D "$hdr" -o "$body" --max-time "$TIMEOUT" -A "$2" "$1" >/dev/null 2>"$hdr.err"
  rc=$?
  status=$(grep -m1 -oE '^HTTP/[0-9.]+ [0-9]{3}' "$hdr" 2>/dev/null | grep -oE '[0-9]{3}$')
  mitig=$(grep -i -m1 '^cf-mitigated:' "$hdr" 2>/dev/null | cut -d: -f2- | tr -d ' \r')
  server=$(grep -i -m1 '^server:'      "$hdr" 2>/dev/null | cut -d: -f2- | tr -d ' \r')
  ray=$(grep -i -m1 '^cf-ray:'         "$hdr" 2>/dev/null | cut -d: -f2- | tr -d ' \r')
  bytes=$(wc -c < "$body" 2>/dev/null | tr -d ' ')
  rm -f "$hdr" "$hdr.err" "$body"
  echo "${status:--}|${mitig:--}|${server:--}|${bytes:-0}|${ray:--}|${rc}"
}

# THE CLASSIFICATION GUARD. A refusal by a proxy between you and the origin looks exactly like a
# refusal by the origin: both are a 403 with no `cf-mitigated`. Reporting the first as the second
# invents a site-wide hard block that does not exist — the failure mode this script's own smoke
# test produced before the guard existed. So a row is only ever given an EDGE verdict when the
# response demonstrably came from the origin's edge: curl exited 0, AND the response carries a
# `server:` or `cf-ray:` header. Anything else is reported as a transport fault against the
# operator running the probe, never as a finding about the site.
verdict() { # $1=status $2=cf-mitigated $3=server $4=cf-ray $5=curl-rc
  local st="$1" mt="$2" sv="$3" ray="$4" rc="$5"
  if [ "$rc" != "0" ]; then
    case "$rc" in
      56|35|7) echo "n/a — TRANSPORT FAULT (curl $rc): the request never reached the origin" ;;
      28)      echo "n/a — TIMEOUT after ${TIMEOUT}s" ;;
      6)       echo "n/a — DNS did not resolve" ;;
      *)       echo "n/a — TRANSPORT FAULT (curl $rc)" ;;
    esac
    return
  fi
  if [ "$sv" = "-" ] && [ "$ray" = "-" ]; then
    echo "n/a — no origin headers; response did not come from the site's edge"; return
  fi
  case "$st" in
    200)     echo "clean pass" ;;
    403|429)
      if [ "$mt" = "challenge" ]; then echo "challenged"
      elif [ "$mt" != "-" ] && [ -n "$mt" ]; then echo "mitigated: $mt"
      else echo "**HARD-BLOCKED**"; fi ;;
    30*)     echo "redirect ($st)" ;;
    -)       echo "n/a — no status line" ;;
    *)       echo "other ($st)" ;;
  esac
}

# Preflight: prove the runner can reach the open internet at all before any row is believed.
preflight() {
  local rc
  curl -sS -o /dev/null --max-time "$TIMEOUT" https://www.cloudflare.com/robots.txt >/dev/null 2>&1
  rc=$?
  if [ $rc -ne 0 ]; then
    echo "> **PREFLIGHT FAILED (curl $rc).** This machine cannot reach the open internet, so every"
    echo "> row below is a fact about this machine's network and none of them is a fact about the"
    echo "> sites probed. Run the script from an ordinary connection before reading any verdict."
    echo
  fi
}

echo "# Crawler access probe — $(date -u '+%Y-%m-%d %H:%M UTC')"
echo
preflight
for target in "${TARGETS[@]}"; do
  for p in "${PATHS[@]}"; do
    echo "## \`${target}${p}\`"
    echo
    echo "| Priority | Agent | HTTP | cf-mitigated | server | bytes | Verdict |"
    echo "|---|---|---|---|---|---|---|"
    for row in "${AGENTS[@]}"; do
      IFS='|' read -r name tier ua <<< "$row"
      IFS='|' read -r st mt sv by ray rc <<< "$(probe "${target}${p}" "$ua")"
      printf '| %s | `%s` | %s | %s | %s | %s | %s |\n' \
        "$tier" "$name" "$st" "$mt" "$sv" "$by" "$(verdict "$st" "$mt" "$sv" "$ray" "$rc")"
    done
    echo
  done
done

cat <<'CAVEAT'
> **What this table does and does not establish.** Every request above was UNVERIFIED — a claimed
> user-agent string sent from an ordinary IP. Cloudflare's Verified Bots allowlist recognises real
> crawlers by published IP list, reverse DNS, or Web Bot Auth signature, none of which these
> requests carry. So a `challenged` row does **not** show the real crawler is challenged (a
> verified bot can skip the challenge entirely), and refusing an unverified client that merely
> claims to be Googlebot is correct edge behaviour, not a defect. What the table measures is
> **user-agent-string matching at the edge**, and the finding is the DIFFERENCE BETWEEN THE ROWS:
> agents treated alike are not being matched on; an agent singled out for a harder refusal is.
> The only source of truth for what real crawlers received is the zone's own Cloudflare **Bot
> Analytics**, filtered by verified-bot category — visible solely to whoever administers the zone.
CAVEAT
