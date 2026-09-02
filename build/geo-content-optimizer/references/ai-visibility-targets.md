# AI Visibility Targets — Precedence, the Three Facts, and the No-Promise Rule

Skill-local carrier for three rules this skill runs against, ruled 2026-08-17 with the client
mandate. The library-wide statements live in `references/ai-visibility-measurement.md` (§2, §3,
§7) and `references/prohibited-tactics.md` (entry 9). This file is the version an operator of
*this* skill reads: each rule attached to the step it changes, and nothing restated that the
carrier already says better.

> **Nothing in this file is an engine claim.** No engine publishes its citation-selection
> mechanics, and this library asserts none in either direction (settled ruling R3 amendment 9a).
> An order of work is a decision about where effort goes; a mention or a citation that was
> observed is an observation with a date and an N. Neither is a statement about what an engine
> prefers, rewards, trusts or looks for, and no row below may be reported as one.
>
> **Operator surface.** Framework item IDs, skill slugs, ruling IDs and repo paths are correct
> here and never travel into client prose (root `CLAUDE.md`, the reader test).

---

## 1. Engine Precedence

### 1.1 The order

| # | Surface | Standing | Items this library prioritises when that engine is the named target |
|---|---|---|---|
| 1 | **ChatGPT Search** (and Browse) | Primary | C02, R01, R02, E01 |
| 2 | **Gemini and Google AI surfaces** (AI Mode, AI Overviews) | Primary | C02, O03, O05, C09 |
| 3 | **Perplexity** | Primary | E01, R03, R05, Ept05 |
| 4 | **Google organic search** | Foundation | Measured as ranking, not as prompt response. The technical and authority substrate the three above draw on — the ranking, crawl, index and authority work it needs is not deprioritised by this table |
| 5 | **Other assistants** (Claude, Copilot, and what follows) | Monitored channel | R04, Ept08, Exp10, R03 |

The item columns are this library's judgement about where effort pays off on the page, carried over
from the per-engine map this skill has always had. Two rows changed shape when the order was
applied, and neither change is evidence of anything: the Google AI Mode row now covers **Gemini and
the Google AI surfaces together**, because the precedence order groups them at rank 2, and the
Claude row sits inside rank 5 with the other monitored assistants. The items themselves were not
re-derived, and no engine published anything that would let them be.

### 1.2 Rank 4, written out, because it is the row that gets misread

**Google organic is a different instrument, not a lower priority.** It sits fourth in a
*prompt-level* ordering for one reason: prompts are not how it is measured. A rank is an ordinal
position in a list; an AI answer is generated text. Putting organic fourth in a table of
prompt-level work says nothing about how much of the client's outcome depends on it, and a
deliverable that reads the row as "organic matters less" has misread it. Where a report shows this
order, the clause travels with it — in the client's own words, not as a footnote they can skip.

### 1.3 What the order governs, and what it does not

**Governs**: which engine's evidence is collected first when effort is limited · which engine a
conflict is resolved in favour of · which engine the report leads with · which item column leads
when the user named more than one engine, or named none.

**Does not govern**: what any engine does. The order reflects where this client's audience is
being decided, it is a working priority, and it is revisable on evidence. It also never overrides
a standing rule — the one-primary-type rule (settled ruling R2), the statistics rule, and the
prohibition list outrank every row above. No engine's rank licenses a second schema type, an
invented figure, or a promise.

### 1.4 How precedence lands in this skill's steps

| Step | What precedence changes |
|---|---|
| 1 — load targets | Which engine's item column leads. Where the user named no engine, work ranks 1–3 together and say in the report that you did — a single "AI" bucket is what the order exists to prevent |
| 3 — apply techniques | The conflict rule below |
| 4 — report | Which engine the report leads with. Every figure names its engine; nothing is pooled across engines silently |
| 5 — self-check | Nothing. The checks are page properties, which are the same whoever reads the page |

**The conflict rule.** Where two engine rows point at page changes that cannot both be made, the
higher-ranked row wins **and the trade-off is named in the report** — never silently dropped. The
conflicts that are real are almost always about *placement*, not about substance: the same opening
150 words cannot simultaneously be a standalone definition (C02, the rank 1 and 2 lead) and a
comparison table (O03, the rank 2 lead). Resolve on rank, then state what the other engine's shape
would have wanted and what it would cost to serve both — usually a definition first and the table
immediately under it, which is a real answer rather than a compromise nobody chose.

Where the rows do not conflict — which is most of the time, since precise data, followable sources
and clear structure serve every row — precedence changes nothing about the work and only changes
what the report leads with.

---

## 2. Mentioned, Cited, Recommended — Three Targets, Not Three Words for One

### 2.1 The three facts

| Target | The observation, as it is recorded | Recorded as |
|---|---|---|
| **Mentioned** | The brand name appears in the answer text at all | field 2 |
| **Cited** | A URL on a client property appears in the answer's sources or inline links | field 3, with the verbatim URL in field 5 |
| **Recommended** | The brand sits inside an ordered or enumerated set of options, at a position | field 4 |

Field numbers are `references/ai-visibility-measurement.md` §3. A brand can be recommended first
with nothing of its own cited, cited without being named, or named inside a list the answer then
advises against. Each of those has a different fix, so "get cited" is one of three jobs and is not
a synonym for AI visibility.

### 2.2 Which of this skill's existing techniques serves which target

Nothing new is bolted on. What changes is that a run says which job each change is doing.

| Target | What this skill already does for it |
|---|---|
| **Mentioned** | Entity precision — full names for people, companies and products (R07); the named author with checkable credentials and the sourceable expert quote (authority signals, step 3); first-party data that carries the client's name with it (E01), because a figure that is theirs cannot be restated without them; the byline and credential questions in Data Sources, which exist to make this possible at all |
| **Cited** | The liftability work, all of it: standalone definitions of 25–50 words starting with the term; quotable statements that survive being lifted out of their paragraph; factual density with units; one followable source per claim; one topic per section; the visible Q&A block (C09). And it belongs **on the URL that owns the cluster** — a citation earned by a second property of the client's is an ownership finding, not a win (`references/query-cluster-ownership.md`) |
| **Recommended** | Comparison content: data in tables rather than prose (O03), the "X vs alternative" and "best X for use case" patterns in step 4's AI Query Coverage block, use-case framing, and acknowledged limitations — a comparison that names what the product is *not* for is one a reader can decide from |

### 2.3 Reading a split result

| What was observed | What it says about the page | Where it goes |
|---|---|---|
| Mentioned, never cited | The brand is known; the owning URL carries nothing liftable and sourceable | This skill, steps 3–4 |
| Cited, never mentioned | The page earned its place; the brand does not stick to it | Entity and brand work — `cross-cutting/entity-optimizer/` |
| Cited, but a different URL of the client's than the owner | An ownership collision, not a content gap | `references/query-cluster-ownership.md` |
| Neither, and competitors are both | Cluster-level gap: the coverage does not exist, or it is not liftable | `research/content-gap-analysis/`, then this skill |

### 2.4 What the deliverable says

Each change names the job it serves. «Βελτιώνει την ορατότητα στην AI» names none of the three,
and a report that concludes "AI visibility: present" has thrown away the diagnosis it was bought
to produce. In the client's own words, the three read as: *does the answer say our name*, *does it
send the reader to our page*, and *does it put us in the shortlist* — three questions with three
different answers and three different pieces of work.

---

## 3. What May Never Be Promised

### 3.1 The rule

**No deliverable promises a position, a citation, an inclusion, a recommendation, or a share of
voice on any AI surface, on any timeline.** No engine publishes its citation criteria, none
guarantees determinism, none offers a submission path that binds it, and the same prompt answers
differently twice in one minute. The promise is not optimism — it is a claim about a mechanism
nobody has documented.

This is the client-facing twin of the engine-mechanic ban, and it is not covered by it. Ruling R3
amendment 9a bans asserting what an engine *does*; this bans promising what an engine *will do for
this client*. A deliverable can break either one alone. Enforced as FAIL-grade family 10 in
`build/seo-content-writer/references/anti-slop-ruleset.md` §6, which also carries the greppable
screen; the prohibition itself is `references/prohibited-tactics.md` entry 9.

### 3.2 The three things stated instead — all defensible

1. **The mechanism, as a declared working model, labelled as one.** What the change puts on the
   page, and why this library expects that to help, with the label attached.
2. **A leading indicator with a measurement plan.** Which figure, on which population, at which
   cadence, by which protocol.
3. **The baseline itself, dated, with its N.** Plus comparable evidence where it exists, described
   with its own limits.

### 3.3 Worked substitutions

**English.**

- ✗ "This work will get you cited by Perplexity within three months."
- ✓ "Perplexity displays its sources as a numbered list — that much is visible in its own output.
  Our working model is that a page answering the question in its own opening sentence is easier to
  lift and attribute; no engine publishes its selection rule, so that stays a working model rather
  than documented behaviour. What we measure is mention rate: on 17 August, across 12 prompts × 3
  repeats, the brand appeared in 8 of 36 captures. Same protocol, monthly, from that baseline."

**Greek.**

- ✗ «Εγγυόμαστε ότι θα σας προτείνει το ChatGPT μέσα σε τρεις μήνες.»
- ✓ «Καμία μηχανή δεν δημοσιεύει τα κριτήρια παράθεσης, οπότε δεν υποσχόμαστε ούτε θέση ούτε
  παράθεση. Το μοντέλο εργασίας μας: μια σελίδα που απαντά στην ερώτηση μέσα στην πρώτη της
  παράγραφο δίνει μια πρόταση που μπορεί να αποσπαστεί αυτούσια. Αυτό που μετράμε είναι το ποσοστό
  αναφοράς — στις 17 Αυγούστου, σε 12 ερωτήματα × 3 επαναλήψεις, η μάρκα εμφανίστηκε σε 8 από 36
  καταγραφές — και το ξαναμετράμε κάθε μήνα με το ίδιο πρωτόκολλο.»

Both replacements are longer than the promise they replace. That is the trade: the promise is one
sentence and unfalsifiable, the substitute is three sentences a client can hold you to.

### 3.4 This skill's own numbers are not a forecast

The GEO Readiness score, the before/after table and the lift measure **this deliverable's own page
properties** on this library's own eight-factor instrument, with the count printed behind every
figure. They say the page changed. They say nothing about what any engine will do with it, and
they are never placed beside an engine's name in a way that implies one. Name the instrument and
its denominator when the figure is reported, and keep the two claims apart in the same paragraph
if they have to share one.

Where a run has genuine prompt-level observations to report, they carry their own discipline: one
capture is an observation with a timestamp, `k of N` rather than a bare percentage, N ≥ 3 repeats
before a rate is called a rate, and failed captures recorded rather than dropped
(`references/ai-visibility-measurement.md` §4).

---

## 4. Where This Connects

| For | Read |
|---|---|
| The twelve recorded fields, sampling discipline, derived metrics, the manual zero-tool capture protocol | `references/ai-visibility-measurement.md` |
| The prohibition list in full, and what to do when the client already has one | `references/prohibited-tactics.md` |
| The greppable screen for a promise, and the engine-disposition screen beside it | `build/seo-content-writer/references/anti-slop-ruleset.md` §6, families 10 and 9 |
| Which property and URL should be the cited one | `references/query-cluster-ownership.md` |
| The seven fields in full, with worked criteria and the role list — the rule itself is stated in `SKILL.md` step 5, where the actions are written | `references/action-output-contract.md` |
| The measurement half — running the prompt set and recording the rows | `monitor/rank-tracker/` |
| Carrying an observation to another run | `references/inter-skill-handoff.md` |
