# Action Output Contract — Skills Reference

> The convention is stated in the repo's root `CLAUDE.md`, section **Every Action Is Implementable**.
> This file is its carrier — the shipped statement a skill can read at run time. `CLAUDE.md` is a
> repo context file, not part of the installed skill surface, so a rule that lives only there is a
> rule the running library does not carry.
>
> **Sister references**: [Inter-Skill Handoff](./inter-skill-handoff.md) — what travels between
> runs, as distinct from what is handed to a human · [Prohibited Tactics](./prohibited-tactics.md)
> — what an action may never be · [AI Visibility Measurement](./ai-visibility-measurement.md) §7 —
> what an expected impact may never claim.

**A recommendation nobody can be held to is a suggestion, and suggestions do not get done.** This
library's deliverables end in actions, and an action is only finished when someone could pick it
up, do it, and prove afterwards that it was done — without the person who wrote it in the room.

---

## 1. The Seven Fields

Every recommended action, in every deliverable, carries all seven. A field with no answer is
written as its stated-absence value, never left blank and never invented.

| # | Field | What it is | Stated-absence value |
|---|---|---|---|
| 1 | **Action** | One imperative sentence naming the artefact and the change. "Rewrite the dehumidifier category page intro to lead with the room-size answer" — not "improve the category page" | — (an action with no action is not a row) |
| 2 | **Owner** | The role that will do it — §3 | `unassigned — needs an owner` |
| 3 | **Acceptance criterion** | The observable state that proves it is done — §2 | — (an action with no criterion is not a row) |
| 4 | **Expected impact** | What should change, with the basis for saying so — §4 | `not estimated — no baseline data` |
| 5 | **Effort** | A band (S / M / L) with what it covers, or hours where the client works that way | `not estimated` |
| 6 | **Dependencies** | What must be true or done first, named specifically | `none` |
| 7 | **Risk if done wrong** | The realistic failure mode and its cost | `low — reversible, no downstream effect` |

Fields 1–3 are **required**: an action with no owner-role and no acceptance criterion is not
implementable and does not ship as an action. Fields 4–7 may carry a stated-absence value; that
value is itself information, and `not estimated — no baseline data` names a gap the client can
close.

---

## 2. The Acceptance Criterion

**The test: could someone who was not part of this engagement check it, six weeks from now,
without asking anybody what was meant?**

A criterion is:

- **Observable** — it names a thing that can be looked at, run, or measured.
- **Binary at the moment of checking** — done or not done. Not "improved".
- **Attached to an artefact or a measurement**, with the URL, file, or metric named.
- **Dated or triggered** — by when, or after what.

| Not a criterion | A criterion |
|---|---|
| "Page is better optimised" | "`/el-gr/afygrantires` H1 contains the head term; meta description is 140–158 characters; both live on the production URL" |
| "Improve internal linking" | "At least 6 in-body links from category and guide pages point to `/el-gr/afygrantires` with descriptive anchor text; verified in a crawl export" |
| "Increase AI visibility" | "Mention rate for the 12 dehumidifier prompts is re-measured on the same 3-repeat protocol, and the new figure with its N is recorded beside the 17 Aug baseline" |
| "Fix schema" | "Product schema on the 8 model pages validates with zero errors in a structured-data test, and every property in it corresponds to content visible on the page" |
| "Publish the comparison article" | "Comparison page is live at an agreed URL, carries a named author and a publication date, and is linked from both parent category pages" |

**An AI-surface criterion is a measurement criterion, never an outcome criterion.** "Brand appears
in ChatGPT's answer" is not acceptable as a criterion — it is not in anyone's gift to deliver, and
writing it makes the action a promise (§4, and [Prohibited Tactics](./prohibited-tactics.md) entry
9). What *is* acceptable: the work shipped, and the measurement re-run and recorded.

---

## 3. The Owner

**A role, not a person** — unless the client has supplied names, in which case the name goes beside
the role. Roles come from a short list so that a plan can be read across deliverables:

`Content` · `SEO/technical` · `Developer` · `Designer` · `Product/merchandising` ·
`Customer service` · `Legal/compliance` · `Agency` · `Client decision`

Two rules:

1. **`Client decision` is an owner**, and it is the right one for anything the agency cannot decide
   — which property owns a cluster, whether a page goes live, what a price is. Assigning it makes
   the decision visible instead of leaving the action stalled with no explanation.
2. **`unassigned — needs an owner` is a legitimate value and a finding.** It surfaces work that has
   nowhere to go, which is more useful than a plausible guess that quietly nobody owns. It is never
   used to avoid making an obvious assignment.

---

## 4. Expected Impact

Expected impact states **what should change and why that is expected**, at a confidence the
evidence supports. Three permitted shapes:

1. **Measured, from this site's own data** — "the 3 URLs sit at average position 7.4 with 2,100
   impressions in the 28-day window; moving them into the top 3 is the largest available click
   gain in this set". Show the arithmetic.
2. **Mechanism, labelled as a working model** — "an explicit room-size answer in the opening
   paragraph gives an assistant a directly liftable sentence for the most common buying question.
   This is our working model, not documented engine behaviour."
3. **Comparable evidence, with its limits** — "a comparable category on this site gained X after
   the same change; different demand, so treat as indicative".

**Never**: a promised position, a promised citation, a promised inclusion in any AI answer, a
per-action traffic or revenue figure with no baseline, or a percentage with no derivation. See
[AI Visibility Measurement](./ai-visibility-measurement.md) §7 — this is anti-slop family 10.

---

## 5. Ordering

Actions are ordered by **expected impact ÷ effort**, with dependencies respected — an action whose
dependency is unmet sorts below the thing it waits on, whatever its score. Where the library has
already computed a priority band, that band is used rather than a second vocabulary invented beside
it.

The order is stated, not implied: a numbered list is ordered by priority, and that is said once.

---

## 6. Where the Fields Live in a Deliverable

A table is the default — seven columns, one action per row, ordered. Where a table would be too
wide for the surface, the same seven fields become a labelled block per action; the fields do not
change, only the layout.

**The action table is client-read.** It carries no run handles, no framework item IDs, no skill
slugs and no `~~category` tokens. An action that exists because of a framework item names the job
("the page has no author and no date"), not the item ID. Anything addressed to whoever runs the
library goes in the operator block, labelled inside its own fence — the reader test in root
`CLAUDE.md`.

---

## 7. Output Rules

- Every action carries all seven fields, with stated-absence values where an answer does not exist.
- No action without an owner-role and an acceptance criterion.
- No acceptance criterion that requires an engine to do something.
- Every expected-impact figure carries its derivation and its basis.
- The ordering rule is stated once per deliverable.
- Prohibited tactics never appear as actions — [Prohibited Tactics](./prohibited-tactics.md).
