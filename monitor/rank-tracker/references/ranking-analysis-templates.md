# Ranking Analysis Output Templates

Output templates for seven of SKILL.md's eight workflow steps, plus the operator handoff block. Step 2 (striking-distance mining) has no template here — its output format lives in [tracking-setup-guide.md](./tracking-setup-guide.md) §9.

| Template | SKILL.md step |
|---|---|
| 1. Rank Tracking Setup | Step 1 |
| 2. Current Ranking Snapshot | Step 3 |
| 3. Ranking Change Analysis | Step 4 |
| 4. SERP Feature Tracking | Step 5 |
| 5. GEO/AI Visibility Tracking (SERP-level: AI Overviews inside a Google result page) | Step 6 |
| 6. Competitor Ranking Comparison | Step 7 |
| 7. Ranking Performance Report | Step 8 |
| 8. Operator Handoff Block | Step 8 (closing block) |
| 9. Prompt-Level AI Visibility (what an assistant answers) | Step 6 |

**Step 6 has two templates and they record different observations.** Template 5 is a per-keyword
SERP fact: an AI Overview appeared inside a Google result page for a tracked keyword, and a URL
of ours was or was not in its source list. Template 9 is a per-prompt fact: an assistant was
asked a buyer's question and this is what it said. Neither is filled from the other, neither
substitutes for the other, and no figure is carried across between them.

**Every fence below is a skeleton, and says so inside itself.** The label is the first line *inside* the fence, in that fence's own syntax (`<!-- SKELETON … -->`, which is a comment in Markdown as in HTML), because a model copies the fence and not the heading above it. A bracket token is correct notation inside a skeleton and is a defect in anything handed to a client: fill every slot from collected data, and where an input was never collected, **delete the row or column and name the gap in prose** — never ship `[X]`, `TBD` or `XX` where a value belongs. Delete the skeleton comment when the block is filled.

**Two conventions apply to every template here.** Sign: `Change = new position − old position`, so negative is an improvement; state it once in the deliverable. Derivation: every average, count and percentage prints its arithmetic and its population beside it — see [metric-derivations.md](./metric-derivations.md) for each figure's formula, rounding and missing-input fallback.

---

## 1. Rank Tracking Setup Template

```markdown
<!-- SKELETON — fill every [slot] from collected inputs; drop what was not collected and name the gap in prose -->
## Rank Tracking Setup

### Tracking Configuration

**Domain**: [domain]
**Tracking Location**: [country/city]
**Device**: [Mobile/Desktop/Both]
**Language**: [language]
**Update Frequency**: [Daily/Weekly/Monthly]

### Keywords to Track

| Keyword | Volume | Current Rank | Type | Priority | Source |
|---------|--------|--------------|------|----------|--------|
| [keyword 1] | [vol] | [rank] | Primary | High | [resolved source] |
| [keyword 2] | [vol] | [rank] | Primary | High | [resolved source] |
| [keyword 3] | [vol] | [rank] | Secondary | Medium | [resolved source] |
| [keyword 4] | [vol] | [rank] | Long-tail | Medium | [resolved source] |
| [keyword 5] | [vol] | [rank] | Brand | High | [resolved source] |

<!-- This is a configuration artefact, not a findings table, and the two follow different rules.
     Here a value not yet collected is marked "to collect" — that is a stated status, not an
     invented number, and naming what will be collected is this template's job. In a findings
     table the rule is stricter: an uncollected input means the row or column is dropped and the
     gap named in prose. Priority is the user's business weighting; with none given, mark it to
     collect rather than assigning one. Source carries the connected tool's real name or the
     plain-language origin — never a connector-category placeholder. -->


### Competitor Tracking

Track these competitors for benchmark:
1. [Competitor 1] - [domain]
2. [Competitor 2] - [domain]
3. [Competitor 3] - [domain]

### Tracking Categories

| Category | Keywords | Description |
|----------|----------|-------------|
| Brand | [X] | Brand name variations |
| Product | [X] | Product-related terms |
| Informational | [X] | Educational queries |
| Commercial | [X] | Buying intent terms |
```

---

## 2. Current Ranking Snapshot Template

```markdown
<!-- SKELETON — fill every [slot] from the dated check; drop what was not collected and name the gap in prose -->
## Current Ranking Snapshot

**Date**: [check date]
**Domain**: [domain]
**Keywords tracked**: [N] — every count and percentage below is over this N
**Change convention**: Change = new position − old position (negative = improvement)

### Ranking Overview

Ranges are inclusive and cover positions 1-100 plus "not ranking" with no gap and no overlap.
Percentages are counts ÷ [N] × 100, rounded to whole numbers, so rounded shares may not total
exactly 100 — the counts are the figure of record.

| Position Range | Keyword Count | % of Total ([count]/[N]) |
|----------------|---------------|--------------------------|
| #1 | [X] | [X]% |
| #2-3 | [X] | [X]% |
| #4-10 | [X] | [X]% |
| #11-20 | [X] | [X]% |
| #21-50 | [X] | [X]% |
| #51-100 | [X] | [X]% |
| Not ranking (no position in the top 100 on this check) | [X] | [X]% |

### Position Distribution

Same seven ranges, same counts, drawn as bars — one block per keyword, so the shape is readable
without re-reading the table. Do not introduce a different banding here: a distribution that
bands differently from the overview table above tells two stories about one check.

- `#1`      [bars] [X]
- `#2-3`    [bars] [X]
- `#4-10`   [bars] [X]
- `#11-20`  [bars] [X]
- `#21-50`  [bars] [X]
- `#51-100` [bars] [X]
- `none`    [bars] [X]

### Detailed Rankings

One row per tracked keyword — the persistence contract's snapshot row.

| Keyword | Position | URL | SERP Features | Change | Check date | Source |
|---------|----------|-----|---------------|--------|------------|--------|
| [kw 1] | 3 | [url] | Featured snippet | −2 | [date] | [resolved source] |
| [kw 2] | 7 | [url] | PAA | +1 | [date] | [resolved source] |
| [kw 3] | 12 | [url] | Not checked | New ranking | [date] | [resolved source] |
| [kw 4] | 1 | [url] | Featured snippet | Stable | [date] | [resolved source] |

<!-- A keyword with no prior position is a New Ranking, never a numeric change computed from an
     assumed baseline. SERP Features reads "not checked" where features were not observed —
     never blank-as-if-none. Source is the resolved tool name or plain-language origin. -->
```

---

## 3. Ranking Change Analysis Template

```markdown
<!-- SKELETON — fill every [slot] from the two dated checks; drop what was not collected and name the gap in prose -->
## Ranking Change Analysis

**Period**: [start date] to [end date]
**Change convention**: Change = new position − old position (negative = improvement)
**Population**: the [n] keywords ranked on both dates; keywords that entered or left the set are
listed under New Rankings / Lost Rankings and are excluded from the averages and counts below.

### Overall Movement

| Metric | Start | End | Change | Derivation |
|--------|-------|-----|--------|------------|
| Avg position | [X] | [Y] | [+/-Z] | [sum]/[n] → [sum]/[n] |
| Keywords in positions 1-10 | [X] | [Y] | [+/-Z] | count over the same [n] |
| Keywords in positions 1-3 | [X] | [Y] | [+/-Z] | count over the same [n] |
| Keywords at #1 | [X] | [Y] | [+/-Z] | count over the same [n] |

<!-- If the tracked set changed and a constant population is not available, either state the
     distortion beside the average or present no average and say why. A silent average over a
     changed population reports movement that no ranking made. -->

### Biggest Improvements

| Keyword | Old Rank | New Rank | Change |
|---------|----------|----------|--------|
| [kw 1] | 15 | 4 | −11 |
| [kw 2] | 25 | 9 | −16 |

**Possible causes**:
- [kw 1]: [hypothesis - e.g., content refresh may have improved relevance]

### Biggest Declines

| Keyword | Old Rank | New Rank | Change | Protocol row |
|---------|----------|----------|--------|--------------|
| [kw 1] | 3 | 12 | +9 | [page-1 exit / size row] |

**Likely factors**:
- [kw 1]: [hypothesis - e.g., competitor may have published updated guide]

> These are hypotheses based on available signals, not confirmed causes. Investigate each with the relevant skill to confirm.

**Recommended actions**:
- [kw 1]: [action to recover]

### Traffic Impact

<!-- This section carries a figure only when a measured click baseline for the URL is on file (a
     Search Console or analytics export). With a baseline: state it, apply the setup guide §6
     band, and label the result the guide's generic band applied to your measured baseline —
     e.g. "412 clicks/mo before the drop; the guide's page-2 band (−60% to −80%) puts the loss
     at roughly 250-330 clicks/mo". With no baseline: delete the section, or keep the column with
     its cells empty and the absence stated in prose, and name the export that would fill it.
     Never a visits/mo figure with nothing behind it, and never a generic band presented as this
     site's measured loss. -->

### Stable Keywords

[X] of the [n] keywords moved 2 positions or fewer in either direction and stayed on the same
page (stable). Bands here match the response protocol in SKILL.md — a 1-2 position move that
crosses off page 1 is a page-1 exit, not a stable keyword.

### New Rankings

Keywords with no position on the start date. Reported as new entries, never as a numeric change
computed from an assumed baseline.

| Keyword | Position | URL | Notes |
|---------|----------|-----|-------|
| [kw 1] | [pos] | [url] | [notes] |

### Lost Rankings

| Keyword | Last Position | URL | Action |
|---------|---------------|-----|--------|
| [kw 1] | [pos] | [url] | [investigate/refresh] |
```

---

## 4. SERP Feature Tracking Template

```markdown
<!-- SKELETON — fill every [slot] from the observed SERPs; drop what was not checked and name the gap in prose -->
## SERP Feature Tracking

### Feature Ownership

Counted over the [N] tracked keywords whose SERP was actually observed on [check date]; a
keyword whose SERP was not checked is outside the count, not a zero. Competitor Avg is the mean
count across the [c] tracked competitors **on those same observed SERPs** — it needs the
competitors' feature holdings, which the manual-data intake does not ask for, so with nothing
observed for them the column and the Opportunity column are dropped and the report says which
competitor SERPs to check. Opportunity = your count − competitor avg.

| Feature | Your Count | Competitor Avg ([sum]/[c]) | Opportunity |
|---------|------------|----------------------------|-------------|
| Featured snippets | [X] | [Y] | [+/-Z] |
| People Also Ask answers | [X] | [Y] | [+/-Z] |
| Image pack | [X] | [Y] | [+/-Z] |
| Video results | [X] | [Y] | [+/-Z] |
| Local pack | [X] | [Y] | [+/-Z] |

<!-- Feature presence is a separate fact from organic position. Never fold a feature gain or loss
     into a position delta, and never convert a citation or feature into a position claim. -->

### Featured Snippet Status

Winnable is a house band read off observable facts, not an engine-documented probability —
state the observation that put each row in its band.

| Band | Read it when |
|------|--------------|
| Maintain | You hold the snippet today |
| High | You rank 1-5 organically and the current snippet is a short answer your page already answers |
| Medium | You rank 6-10, or you rank 1-5 but the snippet needs a format your page does not have |
| Low | You rank 11+, or the holder is the query's primary/official source |
| Not assessed | The SERP was not observed — the honest entry when no check was run |

| Keyword | You Own? | Current Owner | Winnable? | Why |
|---------|----------|---------------|-----------|-----|
| [kw 1] | Yes | You | Maintain | [observation] |
| [kw 2] | No | [competitor domain] | High | [observation] |

### PAA Appearances

| Question | Your Answer? | Sourced URL | Action |
|----------|--------------|-------------|--------|
| [Question 1] | Yes/No | [url or "not sourced from us"] | [action] |
```

---

## 5. GEO/AI Visibility Tracking Template

**Scope: SERP-level.** Every row here is a Google result page observed for a tracked keyword —
whether an AI Overview appeared in it, and whether one of our URLs was in its source list. What
an assistant *answers* when asked a buyer's question is a different observation with a different
unit, and it goes in template 9. Neither template is filled from the other.

```markdown
<!-- SKELETON — fill every [slot] from the observed AI answers; drop what was not checked and name the gap in prose -->
## AI/GEO Visibility Tracking

### AI Overview Presence

A citation is a visibility fact, not a position. Report both; never restate a citation as an
organic rank, and never let a citation slot substitute for the organic position of that keyword.

| Keyword | AI Overview | You Cited? | Citation Position | Organic Position |
|---------|-------------|------------|-------------------|------------------|
| [kw 1] | Yes | Yes | 1st of [n] sources | [pos] |
| [kw 2] | Yes | Yes | 3rd of [n] sources | [pos] |
| [kw 3] | Yes | No | Not cited | [pos] |
| [kw 4] | No | Not applicable | Not applicable | [pos] |

### AI Citation Rate

Denominators differ by row and are printed with the figure. Percentages round to whole numbers.

| Metric | Value | Denominator |
|--------|-------|-------------|
| Keywords whose SERP showed an AI Overview | [X]/[N] ([Y]%) | [N] = tracked keywords whose SERP was observed on [date] |
| Of those, keywords citing you | [X]/[M] ([Z]%) | [M] = keywords that showed an AI Overview |
| Avg citation slot where cited | [X] | mean over the [k] AI Overviews citing you: [sum]/[k], 1 decimal |

### GEO Performance Trend

Every prior row comes from that period's dated snapshot, where the AI Overview citation was
recorded in the SERP-features column. Where earlier snapshots do not record it, the trend starts
with this run: show the row for this period only and state that the earlier periods were not
tracked — a period is never back-filled from memory or from a plausible-looking rate.

| Period | AI Overviews Tracked | Your Citations | Rate ([citations]/[tracked]) |
|--------|---------------------|----------------|------------------------------|
| This check ([date]) | [X] | [Y] | [Z]% |
| Prior check ([date]) | [X] | [Y] | [Z]% |
| [earlier check ([date]) — or "not tracked before [date]"] | [X] | [Y] | [Z]% |

### GEO Improvement Opportunities

The Content Gap cell states what was observed in the answer that cited someone else — not a
guess about ranking factors.

| Keyword | Has AI Overview | You Cited? | Content Gap (observed) |
|---------|-----------------|------------|------------------------|
| [kw 1] | Yes | No | [what the cited sources gave that the page does not] |
| [kw 2] | Yes | No | [what the cited sources gave that the page does not] |
```

---

## 6. Competitor Ranking Comparison Template

```markdown
<!-- SKELETON — fill every [slot] from the same dated check for every domain; drop what was not collected and name the gap -->
## Competitor Ranking Comparison

### Share of Voice

Share of voice here is a **count**, not a proprietary visibility score: the share of the [N]
tracked keywords where the domain holds a position in the top 10 on [check date], printed as
[count]/[N]. Every domain in the table is measured on the same keyword set and the same date.
A tool's own visibility index may be shown *as well*, in its own column, labelled with the
tool's name — the two are different metrics and never share a column.

| Domain | Keywords Ranked | Avg Position ([sum]/[n]) | Top-10 Share ([count]/[N]) |
|--------|-----------------|--------------------------|----------------------------|
| [your domain] | [X] | [Y] | [Z]% |
| [competitor 1] | [X] | [Y] | [Z]% |
| [competitor 2] | [X] | [Y] | [Z]% |

### Head-to-Head Comparison

**You vs [Competitor 1]**:

| Keyword | Your Rank | Their Rank | Winner |
|---------|-----------|------------|--------|
| [kw 1] | 3 | 7 | You |
| [kw 2] | 12 | 5 | Them |

**Summary**: You win [X]/[Y] keywords vs [Competitor 1]

### Competitor Movement Alerts

Threat level is a house band read off two observable facts — where they landed and whether they
passed you. State both.

| Band | Read it when |
|------|--------------|
| High | They entered the top 5 on a keyword you rank for, or overtook you on a Tier 1 keyword |
| Medium | They improved 5+ positions and are now within 3 positions of you |
| Low | They moved on a keyword you do not rank for, or remain 4+ positions behind you |

| Competitor | Keyword | Their Change | Their New Position | Yours | Threat Level |
|------------|---------|--------------|--------------------|-------|--------------|
| [comp 1] | [kw] | −15 | [pos] | [pos] | High |
| [comp 2] | [kw] | −8 | [pos] | [pos] | Medium |
```

---

## 7. Ranking Performance Report Template

```markdown
<!-- SKELETON — fill every [slot] from the run's own figures; drop what was not collected and name the gap in prose -->
# Ranking Performance Report

**Domain**: [domain]
**Report Period**: [start] to [end]
**Generated**: [date]
**Data sources**: [resolved source per metric family — tool name, or plain-language origin]
**Change convention**: Change = new position − old position (negative = improvement)
**Prompt set**: [version] ([n] prompts), [N] repeats per prompt per engine — stated once here and
governing every AI-visibility figure below. [Delete this line where no prompt-level capture was
made this cycle, and say so in the AI visibility section.]

## Executive Summary

**Overall Trend**: [Improving/Stable/Declining] — read off the metrics below, with the one that
decides it named.

| Metric | Value | vs Last Period | Derivation | Status |
|--------|-------|----------------|------------|--------|
| Total keywords tracked | [X] | [+/-Y] | count | [status] |
| Keywords in positions 1-10 | [X] | [+/-Y] | [count]/[n] over the constant population | [status] |
| Keywords in positions 1-3 | [X] | [+/-Y] | [count]/[n] over the constant population | [status] |
| Average position | [X] | [+/-Y] | [sum]/[n], 1 decimal | [status] |

<!-- An "estimated traffic" row belongs here only when clicks or sessions were supplied by a
     named source; then it is that source's measured figure, labelled with the source, not an
     estimate. With no such source the row is deleted and the prose says which export would
     restore it. This skill models no relationship between position and traffic for a given
     site. -->


## Key Highlights

### Wins
- [Achievement 1]
- [Achievement 2]

### Concerns
- [Issue 1]
- [Issue 2]

### Opportunities
- [Opportunity 1]

## Detailed Analysis

[Include top performing keywords, keywords needing attention, SERP features, then AI visibility as
two separate reads — the prompt-level section from template 9, engines in precedence order, and
the SERP-level AI Overview section from template 5 — then competitive position. Where the engine
order is shown, say that Google organic search is measured with a different instrument (the
ranking sections above) rather than demoted.]

## Recommendations

Each recommendation names the job in the client's own vocabulary — "rewrite the boiler guide",
"re-check that SERP" — never a run handle. Handles belong in the closing operator block.

### Immediate Actions
1. [Action] for [keyword] - [what it is expected to change, stated as an expectation not a number]

### This Month
1. [Action]

### Next Quarter
1. [Strategic action]

## Next Report

Scheduled: [date]
Focus areas: [areas to monitor]

<!-- OPERATOR BLOCK — for whoever runs the skill library; not client copy -->
**Next steps for your team** — *operator block; not part of the client report*

| Follow-up run | Payload |
|---------------|---------|
| [skill name] | kw: [keyword] · type: [content type] · URL: [url] · pos [old] → [new] ([source], [check date]) · reason: [why this run] · CORE-EEAT/CITE: not computed by this skill |
```

---

## 8. Operator Handoff Block

The closing block of every deliverable, and the **only** place in it where a run handle appears.

**Why it is separated.** A skill name, a framework item ID and an internal artefact name are
addressed to whoever operates the skill library. They give a client nothing to act on — a
handle names a tool they do not have, in a library they have never seen, and translating it
does not help (it names a competence, not a job). The rule is not "keep handles out of
deliverables"; it is **the test is the reader**. This block is addressed to the operator, so
the handle belongs here even when the block travels inside a client's report. Everything above
it is addressed to the client, so there the same follow-up is named as a job.

**Why it carries two labels.** The visible line (`**Next steps for your team** — *operator block;
not part of the client report*`) is what a reader sees in the rendered report, so the block is
never an unexplained table of slugs. The HTML comment is the Markdown fence's own comment syntax,
so the label survives a model copying the fence rather than the heading above it. A comment alone
is invisible when rendered; a heading alone is lost on copy. Ship both, and the block's reader is
decidable rather than a matter of interpretation.

```markdown
<!-- SKELETON — fill every [slot]; delete this line when filled, keep the two labels below -->
<!-- OPERATOR BLOCK — for whoever runs the skill library; not client copy -->
**Next steps for your team** — *operator block; not part of the client report*

### Follow-up runs

| Follow-up run | Payload |
|---------------|---------|
| content-refresher | kw: [keyword] · type: [content type] · URL: [ranking url] · pos [old] → [new] ([resolved source], [check date]) · reason: [page-1 exit / striking-distance push / decay] · CORE-EEAT/CITE: not computed by this skill |
| serp-analysis | kw: [keyword] · type: [content type] · URL: [ranking url] · pos [old] → [new] ([resolved source], [check date]) · reason: [SERP composition change to confirm] · CORE-EEAT/CITE: not computed by this skill |
| keyword-research | scope: net-new discovery — out of this skill's boundary · seed: [topic/URL] · reason: [request logged in this run] |
```

**Payload rules.**

- One row per follow-up run; a run with no payload is not listed.
- Carry what the receiving skill needs: target keyword, content type, ranking URL, current and
  previous position with the check date and the **resolved** source name, and the reason.
- Framework scores travel only if they exist. This skill computes no CORE-EEAT and no CITE
  score, so those fields read "not computed by this skill" — an invented score in a handoff is
  a fabrication that the receiving skill will treat as an input.
- A handle in the payload is a handle, not a citation: it is never introduced with client-facing
  framing ("we will run…") in the prose above the block.

---

## 9. Prompt-Level AI Visibility Template

Step 6's other half. The unit here is a **prompt**, not a keyword, and the governing statement is
[ai-visibility-measurement.md](../../../references/ai-visibility-measurement.md) — the twelve
recorded fields (§3), the sampling rule (§4), the derived metrics (§5) and the no-promise rule
(§7). This template is only their output shape.

Three things this fence gets wrong most often, so they are built into it: **mention, citation and
recommendation are three rows, never one**; **every rate carries N and its population, per
engine**; and **cited URLs are printed in full**, because "they cited us" and "they cited our
comparison page instead of our product page" are different findings.

```markdown
<!-- SKELETON — fill every [slot] from the capture log; drop what was not captured and name the gap in prose -->
## AI Visibility — prompt set [version] ([n] prompts), captured [date]

**Source**: [resolved source — the platform's own name, or "hand capture, logged out, [locale],
[date]"] · [N] repeats per prompt per engine · [attempted] captures attempted, [successful]
successful, [failed] failed ([reasons]). Failed captures sit outside every denominator below and
are listed with their reasons in the capture log.

**Engine order** below is a working priority for this audience, not a claim about the engines.
**Google organic search is measured with a different instrument — the ranking sections of this
report — and is not deprioritised by this ordering.**

### [Engine 1 — ChatGPT Search]

| Fact | Figure | Population |
|------|--------|------------|
| Mentioned | [k] of [N] successful captures ([p]%) | [n] prompts × [r] repeats, minus [f] failed |
| Cited (any of our URLs) | [k] of [N] ([p]%) | same population as the row above |
| Cited the owning URL | [k] of [the citing captures] | denominator is citing captures, not all captures |
| Average recommendation position | [x.x] ([sum]/[k]) | the [k] captures presenting an ordered set; the other [m] presented none and are outside this figure |
| Share of voice | [k] of [k + competitor mentions] ([p]%) | competitor set: [named competitors] |

**Cited URLs, verbatim** — [count] citing captures:

| URL as cited | Times cited | Owning URL for this cluster | Match? |
|--------------|-------------|-----------------------------|--------|
| `[full url exactly as the answer gave it]` | [k] | `[full owning url]` | Yes / No / no owner assigned |

**Answer excerpt** (the sentence carrying the brand, verbatim): "[excerpt]" — [engine], [timestamp]

### [Engine 2 — name it]

### [Engine 3 — name it]

Repeat the same three blocks per engine, in the precedence order. Nothing is pooled across
engines: a combined figure appears only where the deliverable says it is combined and names
which engines it combines.

### Single captures

Where only one capture exists, it is an **observation** and carries that word plus its timestamp,
in this shape:

> Observation, [date] [time]: the answer to [prompt, verbatim] cited `[full url]` [nth] of [m]
> sources. One capture, so no rate is stated for this prompt — [reason the other repeats are
> missing].

### What is not stated here

No composite AI visibility score: one number across engines, prompts and three different facts
could not be traced back to anything actionable. [Where a connected platform reports its own
composite: "[Platform name] reports its own visibility index at [value] — that is [platform]'s
figure on [platform]'s method, quoted as-is."]
```

**Rules this fence enforces, restated so a filled copy can be checked against them.**

- **No promise of a position, a citation, an inclusion, a recommendation or a share of voice**,
  on any surface or timeline. The forward-looking sentence a deliverable *may* carry is the
  measurement plan: the same prompt set, the same repeat count, the same cadence, against the
  dated baseline above.
- **The prompt-set version is stated once** per deliverable and every figure belongs to it. Two
  cycles compared under different versions say so and say what moved.
- **Failed captures appear as a count with reasons**, never as silence — they reduce N, and
  dropping them inflates every rate above.
- **A change between cycles is a candidate** until a second cycle repeats it; the word "candidate"
  or an equivalent hedge belongs in the sentence.
- Client prose names jobs; skill names, framework item IDs and repo paths stay in the operator
  handoff block (template 8). `~~category` tokens never reach this surface — the source line
  above resolves to a real name or to a plain-language origin.
