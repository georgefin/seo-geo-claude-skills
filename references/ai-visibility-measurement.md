# AI Visibility Measurement — Skills Reference

> The convention is stated in the repo's root `CLAUDE.md`, section **AI Visibility Is Measured at
> the Prompt**. This file is its carrier — the shipped statement a skill can read at run time.
> `CLAUDE.md` is a repo context file, not part of the installed skill surface, so a rule that lives
> only there is a rule the running library does not carry.
>
> **Sister references**: [Query-Cluster Ownership](./query-cluster-ownership.md) — which property
> owns a cluster, and therefore which URL an engine *should* be citing ·
> [Action Output Contract](./action-output-contract.md) — how a finding here becomes an action with
> an owner and an acceptance criterion · [CITE Domain Rating](./cite-domain-rating.md) — item C08
> (Citation Sentiment) and item I09 (Unlinked Brand Mentions) are the scored homes of two fields
> recorded here · [Inter-Skill Handoff](./inter-skill-handoff.md) — how an observation travels.

**A keyword ranking and an AI answer are not the same measurement, and one does not stand in for
the other.** A rank is an ordinal position in a list the engine assembles from an index. An AI
answer is generated text: it may name a brand without citing it, cite a page without naming the
brand, recommend three products in an order that is not a ranking, or answer the same prompt
differently twice in one minute. Recording "position 4 for *αφυγραντήρες*" says nothing about
whether ChatGPT recommends the client when a buyer describes their basement.

This file defines the unit, the fields, the sampling discipline, and the derived metrics.

---

## 1. The Unit Is a Prompt, Not a Keyword

| | Keyword | Prompt |
|---|---|---|
| **What it is** | The string a user types into a ranked-list engine | The natural-language request a user makes of an assistant |
| **What comes back** | An ordered list of URLs | Generated prose, sometimes with citations, sometimes with a recommendation set |
| **Stable across repeats?** | Substantially — same query, same day, same locale gives near-identical results | **No.** See §4 |
| **Unit of measurement** | Position | The fields in §3 — no single number |
| **Tracked by** | `rank-tracker` steps 1–5, 7 | `rank-tracker` step 6 and this file |

A prompt set is a **versioned artefact**, exactly like a tracked keyword list. Adding or rewording
a prompt changes the population, and a population change moves every average without anything
having happened in the world — the same trap `rank-tracker`'s Metric Derivation Contract rule 2
names for keywords. Version the set, date each version, and state which version a figure covers.

### 1.1 Building the prompt set

Six sources, in the order they pay off. A set of 30–60 prompts is workable by hand; below ~20 the
derived rates in §5 have too small a denominator to move meaningfully.

1. **The client's own sales questions.** What buyers actually ask the sales team, in the buyer's
   words. This is the highest-yield source and needs no tool.
2. **Search Console queries** for the owning URLs, rewritten from query form into request form —
   `αφυγραντήρες υπογείου` becomes «ποιον αφυγραντήρα να πάρω για υπόγειο 60 τ.μ. με υγρασία;».
3. **The buying-stage ladder** — for each cluster, one prompt per stage: problem-aware
   («γιατί έχω υγρασία στο υπόγειο;»), solution-aware («αφυγραντήρας ή ανακαίνιση;»),
   brand-aware («ποια μάρκα αφυγραντήρα είναι αξιόπιστη;»), and decision
   («Kullhaus Q13L ή Meaco Arete;»).
4. **Comparison and alternative prompts** naming the client's brands and each named competitor,
   both directions.
5. **The four Greek keyword forms** where the site is Greek-language — see
   `research/keyword-research/references/greek-keyword-coverage.md`. A prompt written in one form
   is not a proxy for the others; where a form is a genuine user behaviour, it earns its own prompt.
6. **Language pairs.** A bilingual audience is two populations, not one. Where the site serves both
   Greek-speaking and English-speaking users, each cluster's head prompts exist in both languages,
   recorded as separate rows — an engine answering in English draws on a different source pool, and
   collapsing the two hides exactly the gap the client is paying to find.

Prompts are written the way a person writes them: no keyword stuffing, no operators, no brand name
unless a real user would include one. A prompt engineered to produce a mention measures the
engineering.

---

## 2. Engine Precedence

Engines are worked in this order. The order governs which engine's evidence is collected first
when effort is limited, which engine a conflict is resolved in favour of, and which engine a
report leads with. It does **not** mean lower-priority engines are unmonitored.

| Rank | Surface | Standing | What it earns |
|---|---|---|---|
| 1 | **ChatGPT Search** | Primary | Prompt set run in full, every cycle. Leads the report. |
| 2 | **Gemini and Google AI surfaces** (AI Mode, AI Overviews) | Primary | Prompt set run in full, every cycle. Reported beside ChatGPT. |
| 3 | **Perplexity** | Primary | Prompt set run in full, every cycle. Its citation list is the most legible of the three, so it is the cheapest place to read *which URL* was used. |
| 4 | **Google organic search** | Foundation | Tracked as ranking, not as prompt response — `rank-tracker` steps 1–5. It is the technical and authority substrate the three above draw on, and it is measured with the instruments that fit it. |
| 5 | **Other assistants** (Copilot, Claude, Bing Chat, and whatever is next) | Monitored channel | A reduced prompt set — the cluster head prompts only — at a lower cadence. Reported as a channel, not as a target. |

**Rank 4 is a different instrument, not a lower priority.** Organic search is listed fourth in
*prompt-level* work because prompts are not how it is measured; the ranking, crawl, index and
authority work it needs is not deprioritised by this table and is the foundation the other four
depend on. A deliverable that reads this row as "organic matters less" has misread it.

**The order is a working priority, not a claim about the engines.** Nothing here asserts that one
engine sends more traffic, is more influential, or is easier to win. It reflects where this
client's audience is being decided, and it is revisable on evidence.

---

## 3. What Is Recorded

One row per **(prompt × engine × capture date)**. Twelve fields. Fields 2, 3 and 4 are the three
that are most often collapsed into one and must not be.

| # | Field | Values | Notes |
|---|---|---|---|
| 1 | **Prompt** | Verbatim, in its own language | Plus the prompt-set version it belongs to |
| 2 | **Brand mentioned** | yes / no | The brand name appears in the answer text at all |
| 3 | **Brand cited** | yes / no | A URL on a client property appears in the answer's sources or inline links |
| 4 | **Recommendation position** | integer, or `not a recommendation answer` | Where the answer presents an ordered or enumerated set of options, the client's ordinal within it. An answer that recommends nothing has no position, and `1` is never written for "the only thing mentioned" — that is a different fact, recorded in field 2 |
| 5 | **Cited URLs** | The exact URLs, verbatim, in the order given | Full URL, not the domain. This is the field that connects to cluster ownership (§6) |
| 6 | **Owning property matched** | yes / no / `no owner assigned` | Whether the cited URL is the one the ownership register assigns to this cluster |
| 7 | **Competitors named** | Ordered list | In the order the answer names them |
| 8 | **Competitor citations** | URLs | Which competitor URLs were cited, if the surface shows them |
| 9 | **Sentiment** | positive / neutral / negative | Of the sentence carrying the brand, not of the answer overall. Scored as CITE item C08 |
| 10 | **Answer excerpt** | The sentence(s) carrying the brand, verbatim | The evidence. A row with no excerpt cannot be audited |
| 11 | **Capture conditions** | Method, timestamp, locale, language, logged-in state, personalisation state | Every one of these changes the answer. A row missing them is not comparable to any other row |
| 12 | **Sample index** | `n of N` | Which repeat this is — see §4 |

**Mentioned, cited and recommended are three facts, not three words for one.** A brand can be
recommended first while nothing on its own site is cited — the brand surfaced, the site was not
used as a source. A site can be cited while the brand is not named. A brand can be mentioned inside
a list the answer then advises against, which is why field 9 exists. Each of the three points at a
different fix, so a report that says "AI visibility: present" has thrown away the diagnosis.

Read those as **descriptions of the record, not inferences about the engine.** "The site was not
used as a source" is what the capture shows; *why* it was not is unknown, and no engine publishes
enough to settle it. Where a deliverable offers a cause, it is labelled a working model.

**Field 5 is verbatim URLs, not domains.** "They cited us" and "they cited our comparison page
instead of our product page" are different findings, and only the second is actionable.

**Field 5's ordering carries a second fact — the citation slot — and it is not field 4.** Where an
answer lists its sources, the client URL's ordinal in that list ("second of five sources") is read
off field 5's recorded order and needs no column of its own. It is a different measurement from
field 4: **recommendation position is where the client sits among the options the answer proposes;
citation slot is where the client's URL sits among the sources the answer drew on.** An answer can
recommend a competitor first while citing the client first, and the reverse. A skill that already
emits a citation-slot figure keeps it distinct from recommendation position and labels which it
means — collapsing the two produces a number nobody can act on.

---

## 4. Sampling — One Run Is an Observation, Not a Measurement

Generated answers vary between runs for the same prompt, on the same day, from the same location.
Any single capture is therefore a **sample**, and this library reports it as one.

**Minimum discipline:**

- **N ≥ 3** repeats per prompt per engine per cycle, captured in one session, before any rate in
  §5 is reported as a rate. Report `k of N` (2 of 3), never a bare percentage from one run.
- **A single capture** is reported as an observation with its timestamp and the word *observation*:
  «στις 17 Αυγούστου, η απάντηση ανέφερε…». It never becomes «η μηχανή αναφέρει…».
- **Fresh session per capture** where the surface personalises: logged out, history cleared, or a
  clean profile. Field 11 records which.
- **A change between cycles is a candidate**, not a result, until it survives a second cycle. A
  brand that appears in 1 of 3 samples this month and 2 of 3 next month has not measurably improved.
- **State N beside every derived figure.** `Mention rate 62% (23 of 37 captures, 13 prompts × 3
  repeats, minus 2 failed captures)` is a measurement; `Mention rate 62%` is an assertion.

**Failed captures are recorded, not dropped.** A refused answer, a rate limit, a surface that
returned nothing — each is a row with its reason, and each reduces N. Silently dropping them
inflates every rate.

---

## 5. Derived Metrics

Each figure below states its population and shows its arithmetic beside itself, per the derivation
contract that governs every number this library prints.

| Metric | Formula | Population rule |
|---|---|---|
| **Mention rate** | captures naming the brand ÷ total successful captures | Per engine. Never pooled across engines without saying so — pooling hides the engine that is failing |
| **Citation rate** | captures citing any client URL ÷ total successful captures | Per engine. Always reported beside mention rate, never instead of it |
| **Owned-URL citation rate** | captures citing the cluster's *owning* URL ÷ captures citing any client URL | The cannibalisation read. A low figure with a high citation rate means the engine is citing the wrong property of yours (§6) |
| **Average recommendation position** | mean of field 4 over captures where a recommendation set existed | Denominator is recommendation answers only. Stating it over all captures is the most common error here |
| **Prompt-level share of voice** | client mentions ÷ (client + all named competitors' mentions) | Per engine, per cluster. Names the competitor set explicitly — it changes the denominator |
| **Sentiment split** | positive / neutral / negative counts of field 9 | Counts, not a score. Feeds CITE C08 |
| **Cluster coverage** | clusters with ≥1 client citation ÷ clusters in the prompt set | The gap map |

**No composite "AI visibility score" is defined here, and no skill invents one.** A single number
across engines, prompts and three different facts (mention, citation, recommendation) is not
recoverable into any action, and its movement cannot be attributed. Where a connected tool reports
its own composite, it is quoted with that tool's name attached and is never recomputed or blended.

### 5.1 Conversion linkage

AI-surface visibility connects to commercial outcome through referral traffic and assisted
conversions, and that link is reported with its known limits stated:

- AI-assistant referrals are identifiable in analytics by referrer host, and that identification is
  **partial** — some surfaces send no referrer, some strip it, and some traffic arrives as direct.
- A figure is therefore a **floor**, labelled as one: "at least 340 sessions from assistant
  referrers in the window; the true figure is higher by an unmeasured amount".
- Attribution from an AI answer to a conversion is stated as **correlation with a named window**,
  never as a causal claim, and never as a per-mention value.

---

## 6. What the Findings Connect To

| Finding shape | Where it goes |
|---|---|
| Cited, but the wrong property or URL of the client's | [Query-Cluster Ownership](./query-cluster-ownership.md) — an ownership conflict |
| Mentioned but never cited | Content and authority work on the owning URL |
| Cited but not mentioned | Entity and brand work — the page earns its place, the brand does not stick |
| Neither, and competitors are | Cluster-level gap: the coverage does not exist, or it is not liftable |
| Negative sentiment | CITE C08, and the alert path in `monitor/alert-manager/` |
| Cited from a third-party page about the client | An unlinked-mention and PR lever — settled ruling R5 |
| Competitor cited from a comparison or review site | A placement target, not a displacement target |

---

## 7. What May Never Be Promised

**No deliverable promises a position, a citation, an inclusion, a recommendation, or a share of
voice on any AI surface, on any timeline.** No engine publishes its citation criteria, none
guarantees determinism, and none offers a submission path that binds it. A promise here is not
optimism — it is a claim about a mechanism nobody has documented.

What a deliverable states instead, and what is genuinely defensible:

- **The mechanism being worked**, as a working model, labelled as one.
- **A leading indicator with a measurement plan** — "we will be measuring mention rate across 3
  repeats on 40 prompts, monthly, from this baseline".
- **The baseline itself**, dated, with its N.
- **Comparable evidence** where it exists, described with its own limits.

This is FAIL-grade family 10 in
[the anti-slop ruleset](../build/seo-content-writer/references/anti-slop-ruleset.md) §6, and it is
distinct from family 9. Family 9 bans asserting what an engine *does* («η Google προτιμά…»);
family 10 bans promising a client what an engine *will do for them*. A deliverable can violate
either one alone.

---

## 8. Data Sources and the Zero-Data Path

**With `~~AI monitor` connected** — a prompt-level visibility platform runs the set on a schedule
and exports the fields in §3. Confirm before relying on it: which engines it covers, which of the
twelve fields it actually returns, how many repeats it runs, and what date range it can export.
A platform that reports a mention rate without exposing N cannot satisfy §4 on its own, and the
gap is stated rather than papered over.

**With no tool** — the manual capture protocol, which is fully sufficient for a 30-prompt set:

1. Fresh logged-out session per engine; record locale and language.
2. Paste the prompt verbatim. Do not follow up, and do not rephrase after a poor answer — the
   rephrase is a different prompt and gets its own row.
3. Record all twelve fields, including the verbatim excerpt and every cited URL.
4. Repeat ×3 per prompt per engine, in one sitting.
5. Log failures with reasons.

**With neither tool nor capture** — say exactly that and leave the figures out: no AI visibility
data was collected, so no rate is stated. A `~~category` token never stands in a number's place on
a client surface, and neither does an estimate. The deliverable names what to collect and what it
would cost so the next cycle can state it.

---

## 9. Output Rules

- Every rate carries N and its population, beside the figure.
- Every single-capture claim carries the word *observation* and its timestamp.
- Every cited-URL finding carries the verbatim URL.
- Mention, citation and recommendation are reported as three lines, never merged into one.
- The engine is named on every figure; nothing is pooled across engines silently.
- No promise of position, inclusion or share of voice (§7).
- The prompt-set version is stated once per deliverable.
- Run handles, framework item IDs and `~~category` tokens stay off client prose — the reader test,
  root `CLAUDE.md`.
