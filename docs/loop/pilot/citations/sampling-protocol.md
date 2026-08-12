# AI-citation sampling — the executable protocol

**State: DRAFTED 2026-08-12 (R76). No session has been run.** This is `PILOT.md` §3 turned into
something a person can execute without re-deciding anything, plus the four hardenings the
pre-registration requires (`PRE-REGISTRATION-2026-08-12.md` §7). Sampling is **manual and
Sani-side** — no engine APIs are available here, which is exactly why the protocol has to be
written down: the written procedure is what makes a manual sample reproducible.

---

## 1. Before the first session — fix these once, then never again

| Setting | Value | Recorded where |
|---|---|---|
| Sampling weekday | *[pick one at lock]* — the same weekday every week | this file, at lock |
| Approximate time of day | *[pick one]* — same each week, ±2 h | this file, at lock |
| Browser profile | A dedicated profile used for nothing else. Logged out wherever the engine allows. | this file |
| ChatGPT account | An account is unavoidable there. Name which one, use only it. | this file |
| Locale | Greek interface, Greece location, mobile viewport class | this file |
| Query list | 8–15 rows, frozen at §4 lock | `query-list.md` |

**Consistency beats purity.** A slightly imperfect setup used identically every week produces a
comparable series; a perfect setup that changes halfway does not. Any forced deviation is written
into the row it affected, not fixed silently.

---

## 2. Per session — the running order

1. Open the fixed browser profile. Clear nothing else, change nothing else.
2. **Run the negative control first** (§3). Record the result before doing anything else — running
   it after the real queries lets the session's own history bias it.
3. Run each `CQ` row in `query-list.md`, in list order, on each engine in the order:
   **Google (AI Mode / AI Overviews) → ChatGPT (search enabled) → Perplexity.**
4. **Run the positive control last** (§3).
5. Append every row to `citations-log.md` in the same sitting. A row written from memory the next
   day is not a measurement.

**"No AI module shown" is a required row**, not a skipped one (`shown = n`, domains n/a). Absence
is data, and a missing row is indistinguishable from a forgotten one.

**Record which surface answered** on Google — AI Mode and AI Overviews are different surfaces and
must not be pooled silently.

**If the quote-preview module appears on an el-GR SERP**, that is a W7 finding — its el-GR rollout
scope is the open leg of that watch item. Note it in the row and report it to the weekly loop.

---

## 3. The two controls — cheap, and both required every session

**Negative control — the personalisation detector.**
One query, named at lock, inside the cluster's topic, for which our property has **no page**.

> If our property is cited on the negative control, the session is **FLAGGED**. The profile is
> probably personalised and every citation in that session is suspect.

This is not a theoretical risk. The sampler is the site's owner, in Greece, who visits the
property. Without this control there is no way to tell a genuine citation from a personalised one,
and the whole metric becomes unfalsifiable.

**Positive control — the surface detector.**
One query, named at lock, on which a known Greek competitor should plausibly appear. The project
register names `heatovent.com` as out-citing all three of our properties in heaters.

> If neither that competitor nor **any** Greek retailer appears anywhere in a session, the session
> is **FLAGGED** — the sampling surface itself is behaving unusually (wrong locale, an outage, a
> logged-in state).

**Flagged sessions are recorded, reported, and excluded from the pooled rate.** That exclusion
rule is fixed here, before any session exists, so it can never be applied selectively.

---

## 4. What gets recorded — three citation columns, not one

`PILOT.md` §3's single "Our property cited? (y/n)" collapses three different events. Record them
separately; a row may be both **L** and **M**:

| Column | Counts when |
|---|---|
| **L — linked citation** | A clickable link to `sanihellas.gr` / `www.sanihellas.gr` appears in the answer or in its attached sources panel |
| **M — unlinked mention** | The answer names Sani Hellas or one of our pages in text, with no link |
| **N — neither** | Neither |

**The pre-registered primary metric is L only.** M is measured because unlinked mentions are a
real AI-visibility signal — that is a reason to count them in their own column, not a licence to
fold them into the headline rate.

Full column set: see the header row of `citations-log.md`. Append-only; corrections append a new
row referencing the corrected one rather than editing it.

---

## 5. Cadence, and the two clocks

Weekly, same weekday, from week 0 through week 12.

**The baseline needs at least two pre-deployment sessions on different calendar weeks.** A
one-session baseline on a surface this volatile is a single day's weather. If only one pre-W0
session exists when deployment happens, Metric 3 is INCONCLUSIVE by construction and the report
says so rather than quietly comparing against n = 1.

**This metric reports on its own calendar.** AI-citation visibility moves in days to weeks;
rankings move in months. An interim citation read is legitimate at CP2 and is labelled interim.
Rank and traffic have no reportable read before CP4.

---

## 6. How the rate is computed

`citation-appearance rate = (rows where L = yes) ÷ (unflagged rows where an AI answer was shown)`

Reported **per engine and pooled**, always with both raw counts beside the percentage. Intervals
are **Clopper–Pearson exact** — a normal approximation is invalid at these counts and will produce
intervals that run below zero.

The success, null, harm and inconclusive conditions are in
`PRE-REGISTRATION-2026-08-12.md` §7.4 and are not restated here, so there is exactly one copy of
them to lock.
