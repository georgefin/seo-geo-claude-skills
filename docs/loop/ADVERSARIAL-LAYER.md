# Adversarial Sanity Layer — Cross-Tier Contrastive Review (G6)

Released by Sani 2026-08-09 (eleventh verdict-log entry, `GATED-ITEMS.md`). Spec:
`MASTER-IMPROVEMENT-PLAN.md` §1c, under §0 constraint 2 — in-environment cross-model
means **Claude-family tiers only**; the sole true cross-family leg is Protocol B
(Sani, manual, monthly). Failure family targeted: `FAILURE-LEDGER.md` F11 — five
recurrences of drafting-integrity drift in high-stakes records, each caught by a
review lane, three only after widening the reviewer's scan scope. This layer adds a
second, differently-tiered lane so the catch does not hang on one reviewer's pass.

Single home for the G6 deliverables: plan §1c sketched the charter into `.claude/`
tasking docs and the high-stakes definition into `PIPELINE.md`; the G6 build order
consolidates all of it here. PIPELINE/agent-doc pointers to this file are wired by
the coordinator after delivery — this file claims no wiring of its own.

**What this layer is NOT**: it does not replace Mode A
(`.claude/agents/skill-reviewer.md`), which stays mandatory on every
verdict/close-out commit per F11 guard (1). Mode A runs a rule checklist (rulings,
tags, contract, scope) and holds verdict authority (SHIP/FIX/BLOCK/UNDECIDED). The
contrastive lane gets no checklist and no verdict: one conclusion, a license to
attack it, findings out. Two Claude lanes agreeing is raised confidence, not proof.

---

## 1. High-stakes output — four classes, mechanical tests

The trigger must be classification, not judgment. An output is high-stakes if it
matches ANY class below. Each class carries the recorded precedent that put it on
the list — the classes are not hypothetical risk categories.

**(i) Gate/verdict/register-flip commits.** Test: the diff appends a verdict-log
entry or changes a `Status:`/`Verdict:` field (APPROVED / EXECUTED / RESOLVED /
RETIRED / CLOSED / MERGED) in any `docs/loop/` register. Precedent: `69455b6`
(G3 → RESOLVED, option (c) RETIRE) drew Mode A FIX×4 — one of the three
same-morning close-out rounds (`b51f65b` SHIP+advisory, `000a906` FIX×2) that
founded ledger F11.

**(ii) Release commits.** Test: the diff creates a new top `VERSIONS.md` changelog
entry and/or bumps manifest `version` fields. Precedent: the v4.3.5 release wave
(`fd6f289` + close-out) carried F11-r3's "local path-add + install succeed
end-to-end" overclaim onto the pushed branch (corrected `39745fb`; the delayed
Mode A round on `b888110..b3e4ca9` confirmed it at BLOCK). `f5e64fe` (release:
v4.4.0 — "installs unblocked") is the same shape done right: its end-state claim
was probe-verified on main the same day (ninth verdict-log entry).

**(iii) Sani-facing deliverables carrying numbers or capability claims.** Test: the
artifact is addressed to Sani for a decision or as a report (weekly report, gated
proposal, PR body under a merge decision, runbook) AND contains a
quantity/score/date commitment or a works / succeeds / verified / blocked-class
claim. Precedent: the PR #7 body carried the same F11-r3 "end-to-end" claim —
falsified minutes after push by the coordinator's own probe (file-source install
"failed to load: cache-miss"; directory-source rejected on the W8 trio). Standing
instance of the class: `MASTER-IMPROVEMENT-PLAN.md` (7/10 · 6.5/10 · 8/10 ratings;
"20/20 in ~5 weeks").

**(iv) Skill rules encoding external-world claims.** Test: the diff adds or changes
`SKILL.md`/`references/` lines asserting facts outside the repo — engine or
platform policy/behavior, thresholds, dates, market figures. Precedent:
entity-optimizer 4.1.3's review-solicitation callout (`aa3535f`, Google "Fake
engagement" policy): the same-wave close-out placed "graduated" enforcement inside
owner-verified frames whose pasted evidence contains no gradation language — F11
recurrence 1, BLOCK severity, corrected evidence-exact in 4.1.4 (`7c270ab`).
Slow-burn form of the class: F9 — retired-FID guidance survived three per-skill
purges; a fourth, then a fifth live file fell only to repo-wide sweeps.

Classification edge: (i) and (ii) fire the lane unconditionally; (iii) and (iv)
fire at coordinator judgment — with the judgment LOGGED either way (§4), so a skip
is a recorded decision, never a silence.

## 2. Protocol A — contrastive second lane (tasking template)

Charter in one line: **assume the primary conclusion is wrong; construct the
strongest disproof the same evidence permits; report disagreement as findings with
quoted evidence.** This is not Mode A re-run on a different model.

Slot-filling rules (coordinator, before launch):

- Freeze the target first — committed SHA or explicit file manifest (F8 rule; a
  moving working tree voids the round).
- `<<PRIMARY-CONCLUSION>>` is quoted VERBATIM from the artifact (the changelog
  sentence, the verdict-entry decision reading, the callout's policy claim, the
  release's end-state line) — 1–3 sentences. Do NOT include the primary reviewer's
  reasoning or report: the lane argues from the evidence, not against a brief
  (anchoring guard — see §5 note on this resolved design point).
- `<<EVIDENCE-SET>>` names everything the conclusion claims to rest on: files,
  quoted responses/pastes, probe outputs. The lane attacks the evidence-to-claim
  step, so it must see all of it.
- Launch as a PLAIN subagent with read-only tools and this template as its entire
  tasking, model overridden to the second-lane tier — not as a `skill-reviewer`
  subagent (that would load the Mode A checklist and re-anchor the lane).
- Name both tiers in the launch and in the round record (§4).

Paste-ready block — fill every `<<…>>`, copy verbatim:

```text
You are the CONTRASTIVE SECOND LANE of the adversarial sanity layer
(docs/loop/ADVERSARIAL-LAYER.md, Protocol A) — SANI HELLAS AI R&D, coordinator
Herbert. You are running on <<SECOND-LANE-TIER + MODEL-ID>>; the primary review
ran on <<PRIMARY-TIER + MODEL-ID>>. You exist because same-tier passes can share
blind spots.

CHARTER — single purpose: ASSUME THE PRIMARY CONCLUSION BELOW IS WRONG.
Construct the strongest disproof the evidence permits. You are not running the
Mode A checklist; you are attacking one conclusion.

TARGET (frozen — never a moving tree):
- SHA / SHA-range: <<TARGET-SHA-OR-RANGE>>
- Files in scope: <<FILE-MANIFEST>>
- Evidence set the conclusion rests on: <<EVIDENCE-SET: files, quoted
  responses/pastes, probe outputs>>

PRIMARY CONCLUSION UNDER ATTACK (verbatim from the artifact; you are
deliberately not given the primary reviewer's reasoning):
<<PRIMARY-CONCLUSION — 1–3 sentences, quoted verbatim>>

METHOD:
1. Read the target and evidence cold. Build the strongest case that the
   conclusion is false, overstated, or under-evidenced: alternative readings of
   the same evidence; the claim's reach vs what the evidence actually attests
   (mutation response vs end state; snippet vs primary; call vs confirmed
   effect); contradictions elsewhere in the touched files; arithmetic; missing
   negative controls; a quieter hypothesis fitting the same facts.
2. docs/loop/SETTLED-RULINGS.md and docs/loop/FAILURE-LEDGER.md are ammunition —
   a conclusion re-walking a ledgered failure signature (F4 state-from-call, F11
   frame overreach, F9 partial sweep) is a finding citing the entry. They are
   never attack targets themselves.
3. Every finding carries quoted evidence: file:line or output of a command you
   ran. Read-only — edit nothing; probes must change no state. A finding you
   cannot anchor is not a finding; manufactured disagreement to look useful is
   a failed round (house rule — Mode A's no-failure-mode-nitpick standard).

RETURN (findings, not verdicts — verdict authority stays with Mode A):
- CONTESTED, strongest first — per finding: {claim attacked · the disproof ·
  quoted evidence · severity: HIGH = conclusion falsified or unsupported at its
  core / MEDIUM = material overreach, or a live alternative not excluded /
  LOW = edge erosion}.
- or UPHELD-AFTER-CONTEST — name the strongest attack you constructed and quote
  exactly where the evidence defeats it. Upheld = raised confidence, NOT proof:
  you share a model family with the primary lane.
- Close with: probes/commands run · anything unverifiable from the frozen
  target (name it — never silently skip it).
```

**Disagreement handling (binding)**

- Disagreement = finding → the same fix-forward flow as Mode A findings: resolved
  before push when caught pre-push; if the round is in flight when a merge order
  executes, the landing point moves to the successor accumulator (PIPELINE
  stage-3 ordering rule — the review is never skipped, only its landing point
  moves).
- Agreement after genuine contest = **raised confidence, explicitly NOT proof** —
  both lanes are Claude-family and can share blind spots (plan §0 constraint 2).
  Recorded as UPHELD-AFTER-CONTEST with the strongest failed attack shown; an
  upheld round that shows no attack is a failed round.
- Confirmed findings follow ledger rules unchanged: signature match → recurrence
  increment; new class → new F-entry (`FAILURE-LEDGER.md` rules 1/3).

**Cost bound (accepted at G6 release)**: roughly 2× review tokens on the ~10–15%
of commits that qualify. If the observed qualifying share drifts materially above
that band, report the drift to Sani; never silently narrow the classes to fit it.

## 3. Protocol B — monthly cross-family check (Sani, ~5 minutes)

The only true cross-family leg available: every in-environment reviewer is
Claude-family. Once a month, Sani pastes the prompt below plus ONE high-stakes
deliverable into a non-Anthropic model, then returns the findings to the loop —
preferably in-session to the coordinator; else as a comment on the [VERIFY]-queue
issue (#6), which the weekly run already reads as a finding source. Protocol B
output enters the loop as a FINDING SOURCE, never as verdicts: EXTERNAL-KNOWLEDGE
findings get primary-source verification before any register or skill change
(standing R64/R71 discipline); document-internal findings route through the normal
fix-forward flow.

Deliverable selection: the month's highest-stakes artifact — a release changelog +
PR body, a verdict-log entry, the numbers section of a gated proposal, or one
external-claim skill section. First candidate on record:
`MASTER-IMPROVEMENT-PLAN.md` §0–§2 (the ratings and the 20/20 cadence claim).

Paste-ready prompt (self-contained by design — no repo shorthand; use as-is):

```text
You are an external red-team reviewer. Below is one working document from my
team. The team builds and checks its work with AI agents from a single model
family, so its internal reviews can share blind spots. You are a different
system; your job is to find what they cannot.

Assume the document's conclusions are WRONG until its own contents prove
otherwise. Work contrastively:

1. List the document's load-bearing claims — numbers, scores, deadlines,
   "X works / is verified / is complete / is blocked", and cause-effect
   statements.
2. Attack each: Is it supported by evidence actually shown in the document, or
   only asserted? Does another part of the document contradict it? Do the
   numbers add up? Does the shown evidence support only a weaker claim than
   the one made? Is there an equally plausible alternative explanation the
   document ignores?
3. If a finding relies on your own general knowledge rather than the document,
   label it EXTERNAL-KNOWLEDGE and note it may be outdated — the team will
   verify it against primary sources rather than trust it.
4. The document may use internal shorthand or references you cannot resolve.
   Never guess their meaning; if a claim rests on one, report it as
   "unverifiable from the document".

OUTPUT — findings only, strongest first. No rewrite, no summary, no praise.

FINDING <n>: <one sentence — what is wrong or unproven>
EVIDENCE: <exact quote(s) from the document / the arithmetic / the labeled
external knowledge>
SEVERITY: HIGH = a core conclusion is false or unsupported · MEDIUM = a claim
materially overreaches its evidence · LOW = minor looseness

Close with two lines:
- The single claim most likely to be wrong, and the cheapest concrete check
  that would settle it.
- If a genuine attempt found no real faults, say exactly that — do not invent
  findings to fill space.

DOCUMENT UNDER REVIEW (pasted below this line):
```

## 4. Firing rules

1. **When.** Class (i) and (ii): EVERY commit, no discretion. Class (iii) and
   (iv): coordinator judgment per item, logged in the round record either way —
   "adversarial lane: run (primary <tier>, second <tier>)" or "adversarial lane:
   skipped — <reason>". Scope boundary: this is an APPLY/close-out-session
   mechanism; routine-fired DETECT reports (class iii) enter only via Protocol B
   selection or when an interactive session acts on them — a prompt-side
   integration would be a separate `update_trigger` decision under the F10
   archive rule, not made by this file.
2. **Tier.** The second lane runs on a DIFFERENT Claude tier from the primary
   Mode A reviewer's (subagent model override), both named explicitly at launch:
   tier class (Haiku-class / Sonnet-class / Opus-class) plus the exact model ID
   used. Coordinator-drafted artifact reviewed once on a single tier is the
   configuration F11 proved insufficient; the tier split is the point.
3. **Sequencing.** Both lanes launch against the same frozen SHA/manifest (F8);
   parallel launch is fine. The two outputs are independent inputs: a Mode A
   SHIP does not close a CONTESTED round, and an UPHELD-AFTER-CONTEST does not
   soften a Mode A FIX/BLOCK.
4. **Recording.** The round is named in the commit/PR record like existing Mode A
   rounds — e.g. "contrastive round on `<SHA>`: primary <tier> / second <tier> —
   CONTESTED, n findings" or "— UPHELD-AFTER-CONTEST". Findings land fix-forward
   per §2. Protocol B rounds are recorded the same way with "cross-family (Sani,
   <model family>)" in place of the tier pair.
5. **Standing limitation (restated so no record overstates this layer).**
   Protocol A raises confidence within one model family; only Protocol B reaches
   outside it, at a one-deliverable-per-month sample. Neither is outcome
   verification — that remains the G8 pilot's job.

## 5. Resolved design points (recorded so they are not relitigated by accident)

- **The second lane sees the conclusion + evidence, never the primary reviewer's
  reasoning.** Plan §1c specifies "the strongest disproof from the same evidence";
  handing over the primary's brief would anchor the lane on it. Independence is
  the mechanism; the conclusion slot is verbatim-quote-only.
- **The lane returns findings, not verdicts.** Verdict vocabulary
  (SHIP/FIX/BLOCK/UNDECIDED) stays with Mode A — two verdict authorities on one
  commit would need a precedence rule this layer does not want to exist.
  CONTESTED / UPHELD-AFTER-CONTEST is deliberately a different vocabulary.
- **Tier names are class names.** Dated model IDs go in each launch record, not
  in this file — the file stays true across model refreshes.
