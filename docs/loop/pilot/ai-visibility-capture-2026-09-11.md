# AI-visibility capture attempt — 2026-09-11 · **no capture was obtained**

**Against prompt-set v1 (`prompt-set-v1-2026-08-17.md`), which is a DRAFT** — it is labelled so by
its own header and has never been locked, pending the client's own sales questions
(`CLIENT-MANDATE.md` §4). Any capture against it is labelled as against a draft set.

**This file exists because `references/ai-visibility-measurement.md` §4 requires it.** *"Failed
captures are recorded, not dropped. A refused answer, a rate limit, a surface that returned
nothing — each is a row with its reason, and each reduces N. Silently dropping them inflates every
rate."* Two attempts were made and both failed. **No rate is reported anywhere in this file,
because no capture succeeded and there is nothing to take a rate over.**

---

## 1. The attempt

| # | Prompt ID | Prompt (verbatim) | Cluster | Engine / surface | Intended N | Obtained | Outcome |
|---|---|---|---|---|---|---|---|
| 1 | **B13** | πού αγοράζω θερμοπομπό Nobo στην Ελλάδα με εγγύηση; | B — θερμοπομποί | Perplexity Computer (agent) | 3 | **0** | **FAILED — `insufficient_credits`** |
| 2 | **A10** | ποια μάρκα αφυγραντήρα είναι αξιόπιστη και έχει σέρβις στην Ελλάδα; | A — αφυγραντήρες | Perplexity Computer (agent) | 3 | **0** | **FAILED — `insufficient_credits`** |

`[obs:2026-09-11 two independent mcp__Perplexity_Computer__call_perplexity_computer calls, one with
a returned thread_id (3a7da24a-bb8a-4210-91e5-284311dc20a2) and one without, both returning
event "insufficient_credits", text "To use Computer, add credits to your account or upgrade your
plan."]`

**Both prompts are brand- or decision-stage**, chosen because they are where a citation is
commercially at stake: B13 asks where to buy with a warranty, A10 asks which brand is reliable and
serviced in Greece. Neither reached an engine.

**Twelve fields, none recorded.** `ai-visibility-measurement.md` §3 specifies twelve fields per row.
This file records none of them for either prompt, because there is no answer text to record them
from. A row of twelve blanks is not a capture.

---

## 2. What this establishes, and the correction it forces

**The toggle and the capability are two different facts, and one was read as the other.**

`GOALS-SCORECARD.md` Round 34 (2026-09-10) recorded `Perplexity Computer` at `enabledInChat: true`
and concluded that the class-(i) half of G4-C4 was executable. **The toggle reading was correct and
the conclusion was wrong.** `enabledInChat: true` licenses exactly one statement — *the connector is
enabled in this chat* — and does not license *a capture can be taken*. The account has no Computer
credits, which is a second and independent gate that the connector listing does not expose.

**This is the F11 recurrence-9 class again**, in a new place: an observation used to support a
sentence that reaches further than the observation does. The anchor was real; the quantifier was
not. Round 34 should have written *"the connector toggle is on; whether a capture can actually be
taken is untested"* and then tested it.

**What is now known that was not known before:** the obstacle to a capture is no longer *"no route
from this container"*. It is **credits on the Perplexity account**. That is a smaller, more specific
and more actionable obstacle than the one it replaces — but it is an owner decision, not a library
one, so G4-C4's class-(i) half is **owner-gated again, for a new reason**.

---

## 3. What would close it

| # | Action | Owner | Acceptance criterion |
|---|---|---|---|
| 1 | Add Computer credits to the Perplexity account, or confirm a plan that includes them | **Client decision** — account holder | A subsequent `call_perplexity_computer` returns an answer rather than `insufficient_credits`, dated, by 2026-09-25 |
| 2 | Re-run this attempt at N ≥ 3 per prompt, fresh session per repeat, recording all twelve fields and every failed row | Library operator | This file gains a §4 with ≥ 1 completed capture per named cluster, `k of N` stated, no bare percentage |
| 3 | Before quoting any result, state the surface honestly | Library operator | Every row names the method as *Perplexity Computer (agent)* — see §4 below |

---

## 4. A fidelity limit that applies even when credits exist

**Perplexity Computer is an agent, not the standard Perplexity answer surface.** A buyer typing a
question into perplexity.ai meets a different product from an agentic research run, and the two can
cite differently. A capture taken this way is evidence about *an* AI surface, and it is **not**
evidence about what a Greek consumer sees on perplexity.ai.

This does not make the capture worthless — it is the only route this environment has, and §4's
`[obs:]` discipline lets it be quoted for what it is. It means the method field is load-bearing:
**every row records the method as `Perplexity Computer (agent)`**, and no derived figure is ever
described as "Perplexity's answer" without that qualifier.

Engine precedence (`ai-visibility-measurement.md` §4, ruling of 2026-08-17) puts ChatGPT Search
first and Perplexity third. **Nothing in this file touches ranks 1 or 2**, which remain unmeasured.

---

**Nothing was published and no property was touched.** This is a record of two refused requests.
