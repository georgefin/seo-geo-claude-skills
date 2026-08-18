# Tooling assessment — Peec AI, Perplexity Pro, and the alternatives

**Date**: 2026-08-18 · **For**: Sani Hellas pilot · **Status**: research complete, four facts outstanding

---

## 0. EVIDENCE GRADE — read this before any figure below

**No vendor page was read directly.** Every attempt was refused at this environment's gateway:

`peec.ai` · `docs.peec.ai` · `perplexity.ai` (www and docs) · `ahrefs.com` · `semrush.com` ·
`seranking.com` · `otterly.ai` · `tryprofound.com` · `rankscale.ai` · `r.jina.ai` · `web.archive.org`

Eleven attempts, six unrelated vendors — a property of **this environment**, not evidence about any
vendor.

**Therefore every price, limit, engine list, export claim and locale claim in this document carries
`[VERIFY]`.** That tag is an accurate description of the evidence, not a formality. A `site:`
query here still returns third-party results in the same set and the answer is synthesised across
all of them, so a sentence cannot be attributed to the restricted domain.

---

## 1. PEEC AI

### 1.1 The structural finding — its atom is our row shape

Peec's chat endpoint returns **one row per (prompt × engine × date)**. That is
`references/ai-visibility-measurement.md` §3's row shape, one field short. Closest structural match
in the field. `[VERIFY]`

### 1.2 Plans `[VERIFY]`, retrieved 2026-08-18, source pages undated

| Plan | Price | Prompts | Projects | **Models** | Cadence |
|---|---|---|---|---|---|
| Starter | $95/mo | 50 | 1 | **3** | daily |
| Pro | $245/mo | 150 | 2 | **3** | daily |
| Advanced | $495/mo | 350 | 5 | not established | daily |

Annual −15%. No free tier; 7-day trial. **A superseded price set is in circulation** ($89/25,
$199/100, $499/300) traceable to a vendor pricing-update post that is undated in snippet.

### 1.3 The three limits that bite, ranked

1. **Prompts vs our set.** `prompt-set-v1` = 50 rate-feeding + 2 verification = **52**. Starter's
   50 does not hold it; Pro's 150 does; the documented 17-prompt minimum viable subset fits Starter.
2. **THE TRAP — Pro does not raise the model count.** Starter and Pro are **both 3 models**. Extra
   engines are a per-model add-on: Starter **+$35/mo**, Pro **+$85/mo**. Our precedence ranks 1–3
   need **five channels** (ChatGPT · Gemini · AI Overviews · AI Mode · Perplexity). So:
   - Starter + 2 add-ons ≈ **$165/mo** — covers more of the precedence table
   - Pro alone ≈ **$245/mo** — covers less
   **Prompts scale with plan; engines do not.**
3. **No historical backfill** `[VERIFY]`, third-party only. Data exists only from the day tracking
   starts. If true, **this is the deadline in this file** — every untracked day is history that
   cannot be recovered.

### 1.4 Export — the decisive section

| Route | Reported | Status |
|---|---|---|
| CSV export of all chats | Project tab, all plans | `[VERIFY]` |
| **CSV column list** | searched, never returned | **UNKNOWN** |
| **Export date-range cap** | no documented cap, and no documented absence | **UNKNOWN** |
| REST API | JSON, date-range chat listing, archived-prompt lookback | `[VERIFY]`, gating disputed |
| **MCP server** | 32 read / 41 write tools, vendor-published | `[VERIFY]` — **nobody here knew this existed** |

`CONNECTORS.md` lists Peec with no included server. **A vendor-published MCP server is a
materially different integration story from CSV** — reported top-tier-gated, so it is a price
question, not a capability one.

### 1.5 Field coverage against `ai-visibility-measurement.md` §3

**8 of 12 tool-populated · 2 partial · 1 mismatched · 1 outside any tool's reach.**

"Tool" means Peec is reported to hold the fact. It does **not** mean the CSV has a column for it —
see §1.4.

Three that matter:

- **Field 3, cited — Peec is FINER than our spec.** It separates *sources* (all URLs the model
  accessed) from *citations* (URLs referenced in the answer text). Our field 3 is one yes/no. Their
  distinction is better and we should adopt it.
- **Field 4, recommendation position — MISMATCH, stays manual.** Peec's "Position" is *mention
  order*. Ours is ordinal within an enumerated recommendation set, and §3 explicitly forbids
  writing `1` for "the only thing mentioned". Not substitutable.
- **Field 9, sentiment — PARTIAL, quote don't substitute.** Peec gives a 0–100 brand score; ours is
  pos/neu/neg **of the brand-carrying sentence**, counted, feeding `CITE-C08`. A 0–100 score cannot
  produce that count. Root `CLAUDE.md` rule 5 applies: quote a tool's composite with its name
  attached, never recompute or blend it.

### 1.6 Sampling — Peec over-delivers on a *different axis*

§4 requires N ≥ 3 per prompt per engine **captured in one session**. Peec runs each prompt daily —
N ≈ 30 per cycle at no extra prompt cost.

**But that is not §4's N.** One sitting holds the day constant so what varies is run-to-run
nondeterminism. A daily series varies by nondeterminism *and* by world/index/model change. Better
trend instrument; worse "how stable is this answer right now" instrument.

**Practical rule: Peec daily series = trend. Keep a manual same-session N=3 on the representation
prompts.** A deliverable printing a Peec rate must say which one it is.

---

## 2. PERPLEXITY PRO — two uses, opposite answers

### 2.1 As a tracked engine — adds nothing, and is a contamination risk

§4 requires a fresh logged-out session, recorded in field 11. Perplexity **personalises signed-in
answers** — memory carries details across conversations and persists across model switches
`[VERIFY]`. Pro also adds a model picker, so a capture on a hand-picked model measures that model,
not the buyer's surface.

> **Rule to write down: a capture is never taken from a logged-in Perplexity Pro account.**
> Capture logged out or incognito, on the default model. No subscription required.

### 2.2 As an operator research tool — earns its cost

Genuinely useful here: Greek-language market reconnaissance with citations attached; reading long
sources; **reach into pages this environment's gateway refuses** — directly relevant to open items
W6, W9, W11; and the blocking pre-capture product check `prompt-set-v1` names.

What it cannot do, stated as flatly: not a data source (no volume, position, backlinks, Search
Console) · not a measurement instrument (no repeat control, no k-of-N, no exportable row) · **cannot
verify itself** — R64/R71 require the cited page be *read*, and W12 is this repo's own precedent for
a snippet corroboration withdrawn because the named source did not contain the claim.

**$20/mo or $200/yr** `[VERIFY]`.

---

## 3. ALTERNATIVES

### 3.1 The axis that decides it

**A tool that *runs your prompts* can run a Greek prompt from Greece if it exposes locale. A tool
built on a *prompt index* can only show what its corpus contains** — and no corpus has depth on
«ποιος είναι ο επίσημος αντιπρόσωπος της Meaco στην Ελλάδα;». Several products do both and their
marketing does not separate them. For this client the index side is near-worthless.

### 3.2 Verdict — no competitor clearly beats Peec, and one has better *documented* Greek

- **Otterly.AI** — the only credible challenger. Its own help pages name **Greek**; cheaper at entry
  (~$29 Lite / ~$189 Standard); CSV on all plans. Against it: fewer engines, no evidence of AI
  Overviews and AI Mode tracked separately, no source-vs-citation split.
- **Ahrefs Brand Radar — out on price shape.** ~$828/mo floor, and our set consumes the allowance:
  52 prompts × 5 engines × 30 days = **7,800 checks against a 2,500 cap**.
- **Semrush — out on unit economics, not capability.** $99/mo buys 25 tracked prompts; our set is
  52. Best-documented locale story in the field; would matter if the client were already a Semrush
  house.
- **Profound / Scrunch — US-enterprise-shaped.** Profound Starter is **ChatGPT only**, which cannot
  serve a precedence table with five surfaces in its top three ranks.
- **Rankscale / Finseo** — broadest locale claims on the thinnest verifiable record.

**Switching cost belongs in the comparison.** Peec does not backfill `[VERIFY]`. Any existing series
exists in Peec and nowhere else; migration restarts the clock.

---

## 4. THE MANUAL FALLBACK — tool vs operator time, never tool vs nothing

| Scope | Arithmetic | Captures |
|---|---|---|
| Full v1, 3 engines, N=3 | 50 × 3 × 3 | **450** (+18 verification) |
| Minimum viable subset | 17 × 3 × 3 | **153** |
| 5 surfaces, N=3 | 50 × 5 × 3 | **750** |

**Per-capture operator time is `not estimated — no timed baseline exists`.** No timing of the §8
protocol has ever been recorded here. Inventing minutes-per-capture would fabricate the one number
the comparison turns on, so it is left out and the measurement is specified instead (action T3).

A capture is not "paste and read": twelve fields per row including every cited URL verbatim and the
brand-carrying sentence verbatim, a fresh session per capture, and a logged failure row for every
refusal. The cost **scales linearly with captures**; a tool's cost does not scale inside its quota.

And the manual path is **superior in one respect**: it is the only route that captures the surface a
buyer actually meets. That is why the recommendation keeps a manual leg after purchase.

---

## 5. RECOMMENDATION

**Keep Peec. Size the plan to the prompt set, not the feature list.** The upgrade answer is
counterintuitive: Starter → Pro buys prompts and **zero additional engines**. For the 17-prompt
pilot subset, **Starter + 2 model add-ons (~$165/mo) covers more of our engine precedence than Pro
alone (~$245/mo)**. Upgrade to Pro when the full 52-prompt set goes live.

**Perplexity Pro — worth $20/mo as research, worth nothing as measurement, mildly harmful if
confused for one.**

**Alternatives — no clear winner, and that is the finding.** Do not switch. Do run T1 below, which
could invert this.

### Actions (seven-field contract)

| # | Action | Owner | Acceptance criterion | Impact | Effort | Deps | Risk if done wrong |
|---|---|---|---|---|---|---|---|
| T1 | Open Peec's prompt **Location** selector; record whether **Greece** is present | `Client decision` | Dated note + screenshot in `docs/loop/pilot/` | Decides whether Peec is usable at all | S | Peec login | Assuming presence, discovering absence after baseline starts |
| T2 | Export one chats CSV; paste its **header row** into the register | `Client decision` | Header recorded verbatim, each column mapped to the twelve fields | Converts §1.5 from reported to measured | S | login, ≥1 day data | A field assumed present and absent degrades every rate |
| T3 | Time **10** manual captures under §8; record minutes-per-capture | `Agency` | "N=10, median X min, range Y–Z", filed | Supplies the only missing input to tool-vs-operator | S | prompt set, one engine | An invented figure misprices the decision |
| T4 | Record current plan, price paid, renewal date, tracking-start date | `Client decision` | All four in the register | Determines whether "upgrade" is even a change | S | none | Recommending a tier already held |
| T5 | Set the 3 model slots to **ChatGPT · AI Overviews · Perplexity**; price add-ons for **AI Mode** and **Gemini** | `Client decision` | Three channels named with date; add-on quote with price and date | Aligns tool to §2 ranks 1–3 | S | T1, T4 | A slot on a rank-5 channel leaves a rank-2 surface unmeasured |
| T6 | Keep a manual same-session **N=3** on the representation prompts each cycle | `Agency` | 8 prompts × 3 repeats, twelve fields, one sitting, filed beside Peec's series | Preserves the within-session read a daily series cannot give | M | prompt set locked | Reporting a daily rate as a within-session rate |
| T7 | Retain Perplexity Pro as research; write the capture prohibition into the method note | `Client decision` + `Agency` | Method note names incognito + default model as the capture condition | Removes a contamination path before cycle 1 | S | none | A contaminated capture is indistinguishable after the fact |
| T8 | Re-price Otterly **only if** T1 returns "Greece absent" | `Agency` | Either T1 returned present and this closes with that reason, or an Otterly quote is on file | Keeps a fallback live without paying to explore it | S | T1 | Switching on marketing copy rather than confirmed locale |

Nothing above promises an engine outcome. Every AI-surface criterion is a **measurement** criterion.

---

## 6. WHAT MUST BE CONFIRMED BEFORE MONEY IS SPENT — ranked

1. **Is Greece in Peec's prompt Location selector?** Everything else is downstream. **A
   thirty-second check by whoever holds the login, and nobody outside that login can make it.**
2. **What are the columns of the chats CSV?** §1.5 says what Peec *holds*; only the header row says
   what it *exports*.
3. **Current plan and how long tracking has run.** Account state, not researchable. Converts "should
   we upgrade" into arithmetic and prices the switching cost.
4. **Is there a date-range cap on export, and does history really not backfill?** If short, the
   prompt-set lock is a dated deadline, not a task.

---

## 7. REGISTER DELTAS — none applied

| Register | Delta |
|---|---|
| `CLIENT-MANDATE.md` §4 bullet 3 | **Partially answered.** Export exists (CSV, all plans); API exists (gated). **Date range remains open — the bullet does not close** |
| `PILOT.md` 2026-08-17 | Framing confirmed. Add: Peec publishes an MCP server, so a connector route exists at top tier |
| `CONNECTORS.md` `~~AI monitor` | A Peec MCP entry is Sani-gated, not a doc fix |
| Pinned baseline, Google AI Mode in Greek | Independently re-observed this session. **No drift** |
