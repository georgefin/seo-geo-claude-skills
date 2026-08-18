# RESUME — session handoff

**Written 2026-08-18.** Read this first in a fresh session, then `CLAUDE.md`, then `docs/loop/PIPELINE.md`.
Everything below is state, not advice. The container is ephemeral; this file is the memory.

---

## 1. Standing constraints — binding, and none of them expire with a session

| # | Constraint | Source |
|---|---|---|
| **M1** | **NEVER merge PR #9.** Ruled by Sani 2026-08-17. **A merge condition being met is not an order** — CI green, approvals, a clean gate, none of it authorises the merge. | Sani, 2026-08-17 |
| **HITL** | **Nothing publishes to any live or production site** without Sani's per-change approval **naming the pages**. `[obs:2026-08-18 no create, edit or publish action has been taken against any client property in this engagement]` | standing |
| **Gate** | A general "proceed" or "keep going" **never** decides a gated question. Background events and system notifications carry no user approval. | standing |
| **Manufacturing** | No deliverable, register, report, commit message or internal note states which company **manufactures** a brand in this estate, or any contract-manufacturing relationship. | Sani, 2026-08-18 · `pilot/property-register.md` §6 |
| **Model ID** | The model identifier never appears in commits, PR titles or bodies, code comments, or any pushed artefact. Chat replies only. | environment |
| **Push** | `bash scripts/pre-push-gate.sh` before every push (also enforced by a `PreToolUse` hook). Always `git push -u origin <branch>`. | `CLAUDE.md` |
| **Settings** | `.claude/settings.json` writes are DENIED by the permission classifier. Do not retry them. | measured |

**Branch: `claude/scheduled-skills-web-search-8zaz3j`.** PR #9 is open and draft, tracking it.
Last commit `f13574b`. Worktree clean, all work pushed.

---

## 2. Environment reality — measured, do not re-litigate

`[obs:2026-08-18]` **This container cannot reach any host on the open internet.** The proxy runs an
allow-list admitting package registries and Anthropic's API; everything else gets
`curl: (56) CONNECT tunnel failed, response 403`.

**The control is what makes it conclusive:** `kullhaus.gr` — a site known to be wide open — fails
identically to `sanihellas.gr`. A control failing the same way as the subject proves the refusal is
this container, not any zone. **Retrying a client URL will never succeed** `[obs:2026-08-18 every attempt from this container, across every client host and two unrelated hosts, refused identically at CONNECT]`. No lane should spend time on it.

| Capability | State |
|---|---|
| `curl` / any direct fetch | blocked at `CONNECT`, all hosts `[obs:2026-08-18]` |
| `WebFetch` | `EGRESS_BLOCKED`, all hosts `[obs:2026-08-18]` |
| **`WebSearch`** | **works** `[obs:2026-08-18 returned results while every fetch tool was refused]` — routes through the model API, not this proxy. Snippet-grade evidence only; label `[VERIFY]` and never quote as an observed page. |
| The six `.mcp.json` connectors | gateway `403` to `CONNECT`, **before** any authorisation. Authorising them cannot help; buying a tool cannot help. |
| **Perplexity Computer connector** | `installState: connected`, `connected: true`, **`enabledInChat: false`** — authenticated but **toggled off for the chat**. That switch, not a fault, is why it worked mid-session on 2026-08-18 and then vanished. Sani can re-enable it in the chat's connector settings. |

**When Perplexity is on, it is a second model reporting on a page, not a direct read.** Status codes
and headers are strong evidence; page *contents* are a notch below. It has produced a plausible,
well-formed, entirely wrong page title once (it read a Cloudflare challenge page and reported it as
the page). **Standing rule: a quick fetch of a Cloudflare-fronted host is not evidence about that
page.** Page claims come from a properly rendered read or they are not made.

---

## 3. What is delivered

| Artefact | State |
|---|---|
| `pilot/keyword-research-thermopompoi-afygrantires-2026-08-18.md` | 1,323 lines, Greek. 22 clusters (9 heaters, 10 dehumidifiers, 3 shared), 118 keywords, 27-row ownership register (21 assigned · 4 contested · 2 unowned). Part A client report + Part B operator block carrying both required labels. All 23 actions carry the full seven-field contract. |
| `pilot/crawler-access-finding-2026-08-18.md` | §1–§9. The estate's crawler configuration, the measured probe, and three corrections. **§4 and §8.5 govern how the tables may be used — read them before quoting any row.** |
| `scripts/crawler-access-probe.sh` | 10 agents × 2 paths × both hosts. Runs from any normal connection. Carries a transport-fault guard and a preflight. |
| `pilot/property-register.md`, `pilot/tooling-assessment-2026-08-18.md` | Estate register (§6 = the manufacturing rule); network policy and the Perplexity route with its limits. |
| Decision brief artifact | https://claude.ai/code/artifact/e09bc4b7-db4e-4d4d-beda-9ca74f4cf659 |

### 3.1 Where the crawler question actually stands

**Not an emergency, and not closed.** Measured: the two *training* crawlers (`GPTBot`, `ClaudeBot`)
are hard-blocked; every *search and assistant* agent gets `403 + cf-mitigated: challenge` — **and so
does plain desktop Chrome** `[obs:2026-08-18 client-run eight-agent probe from a working connection, control row included]`. A layer that challenges an ordinary browser is general bot management,
not AI policy.

**Two settings govern this and they are configured separately:** the AI toggle (training block) and
**Verified Bots bypass** (whether a real IP-verified crawler skips the general challenge). Either can
be wrong alone. **"Training-only means nothing to fix" was written, was wrong, and is retracted in
§8.4a.** Do not restate it.

Every probe row is an **unverified** request and says nothing about what a real crawler receives.
That gap cannot be closed from outside by anyone. **Cloudflare Bot Analytics is the only source of
truth**, and it is a dashboard only Sani's zone admin can open.

---

## 4. Pending — Sani-only decisions, ordered by what they block

1. **Cloudflare on the `sanihellas.gr` zone — both settings**, not one: (a) which AI bot setting is
   enabled, training-only or broad; (b) **whether Verified Bots is allowed to bypass** the general
   challenge. Plus 30-day verified-crawler counts by category for `OAI-SearchBot`, `ChatGPT-User`,
   `PerplexityBot`, `Googlebot`.
2. **Return the 27-row ownership table with decision dates.** No row is final without one — that is
   deliberate. **The single biggest unblock for all content work.**
3. **ΘΠ-5:** can the brand-facet URLs be independently edited? Does `noboadvantage.gr` sell?
4. **Peec:** is Greece in the prompt Location selector; CSV column list; plan and renewal date;
   export date-range cap.
5. **Confirm the estate reading** — "one site only" vs the seven listed. Everything downstream
   assumes seven.
6. GLAMOX three-part decision · `kullhaus.com` vs `kullhaus.gr` · English dehumidifier audience ·
   the old WordPress blog.
7. Confirm the `CCBot` exclusion on `kullhaus.gr` and `meaco.gr` was deliberate.
8. **Data:** the 16-month Search Console export; the sales/support inbox questions.
9. **Task #65** (twenty alert thresholds) — deliberately last. Unanswerable without baseline data.

---

## 5. Pending — library work, no gate on it

- **The re-run wave.** All 20 eval records are stale under M2.
- `content-refresher` e2.3 under M6.
- `domain-authority-auditor` reference issues.
- An off-list `OPERATOR-ADDRESSED FORM` label in `competitor-analysis` — the closed list is three
  (`SKELETON`, `ILLUSTRATIVE FILL`, `OPERATOR BLOCK`).
- Task #76 — diagnosed, not fixable from here: the fix is the execution environment's network
  policy, or the Perplexity toggle in §2.

---

## 6. One open item that is the client's call, not the library's

Commit `e610396`'s **message** states a manufacturing relationship and is already pushed. Removing it
needs a history rewrite on this branch. The PR is draft and unmerged so it is safe to do —
**but force-pushing is Sani's decision.** It has been raised twice and not answered.
