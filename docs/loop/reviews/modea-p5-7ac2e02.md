# Mode A — pass 5 review

**Target (frozen):** `7ac2e02f077df46422952b48de07953c7a3ecf77`
**Range:** `95ba7d6..7ac2e02` — `7b03e91` (gates + guard re-audit) · `7ac2e02` (pilot preparables)
**Repo:** `/Users/georgefinetis/seo-geo-claude-skills-georgefin` (branch `section-b`)
**Reviewer:** Mode A, pass 5. Nothing in this repo was edited. Only this note was written.

## VERDICT: **BLOCK**

Two BLOCK-class defects. One is the fourth consecutive recurrence of the pass-4 defect class,
and it is inside the commit whose headline deliverable is the checker built to catch it.
**The pattern holds.** These commits were new build rather than repair, and it made no difference.

---

## Drift statement

At open: HEAD `7ac2e02`, working tree **clean**.
At close: HEAD `7ac2e02` (unchanged), working tree **14 modified files** — siblings editing
`cross-cutting/entity-optimizer/`, `docs/loop/eval-baselines/`, `docs/loop/OPEN-FINDINGS.md`,
`scripts/{check-freshness,check-trigger-archives,pre-push-gate,register-lock}.sh`.
Re-diff at close is byte-identical to open: `28 files changed, 3341 insertions(+), 79 deletions(-)`.
**Every measurement below was taken from `git show <sha>:<path>` or a `git archive` materialisation
of a frozen SHA, never the working tree.** Fault injection ran in throwaway clones
(`scratchpad/c1`–`c4`); the real repo was never written to.

---

# BLOCKING

## B1 — A false `[obs:]` anchor shipped in `7b03e91`. Asserted 34, the tree holds 36.

**File:** `docs/loop/OPEN-FINDINGS.md:18` (introduced by `7b03e91`; `7ac2e02` did not touch the file).

The anchor, verbatim at the frozen SHA:

```
[obs: `grep -cE '^\| [0-9]+ \|' docs/loop/OPEN-FINDINGS.md` = 34 · `grep -oE '^\| [0-9]+ \|'
docs/loop/OPEN-FINDINGS.md | grep -oE '[0-9]+' | sort -un | wc -l` = 34 · A=6 B=16 C=1 D=9 E=2 ·
range 60–93, 2026-08-12 — measured AFTER the last row was added, then written]
```

Running the anchor's **own two quoted commands** against the tree at `7ac2e02`, by hand:

| Anchor asserts | Measured | |
|---|---|---|
| `grep -cE '^\| [0-9]+ \|' …` = **34** | **36** | RED |
| `grep -oE … \| sort -un \| wc -l` = **34** | **36** | RED |
| ids "60–93 contiguous" | ids run **60–95** | RED |
| section **E=2** | section E holds **4** rows (92, 93, 94, 95) | RED |
| "measured AFTER the last row was added" | contradicted by all of the above | RED |

Per-section census at `7ac2e02`: A=6 · B=16 · C=1 · D=9 · **E=4** · **total 36**.

**How it happened, from the diff itself.** At `95ba7d6` the header read **32** and the tree held
32 (ids 60–91) — pass 4's fix was correct. `7b03e91` added **four** rows (92–95) and moved the
anchor **32 → 34**. 32 + 4 = 36. The breakdown line was updated to `E=2` for a section that
shipped with 4 rows.

**Why this is BLOCK-class, not a nitpick.**

1. It is the **fourth recurrence** of the class the register itself documents at `OPEN-FINDINGS.md`
   #92, and the same shape as pass 4's BLOCK (asserted 31 / observed 32).
2. The prose **two lines above the anchor**, added by the same commit, reads: *"This number has now
   gone stale three times in one session (20→23→31→32→34), each time because a row was added after
   the count was written."* It shipped stale a fourth time in the sentence announcing the pattern.
3. **The commit's own test suite catches it.** `bash scripts/obs-anchor-selftest.sh` run in a clean
   clone at `7ac2e02`: **14 passed, 1 failed, exit 1** — the failing case is `head-green`, the
   negative control asserting the committed state is clean, and it fails on precisely these two
   anchor claims. Running the suite before committing would have stopped this.
4. `python3 scripts/obs-anchor-check.py --at 7ac2e02` → **exit 1**, 2 MISMATCH.

**On the checker's trustworthiness** (the task required proving its green is worth something before
trusting its red):

- R297 red proof reproduces: `--at ceddc85` → **exit 1**, `asserted 31 / observed 32`. The primary
  RED is a real historical defect, not synthetic.
- Negative control passes: `--at 95ba7d6` → **exit 0**, GREEN, 4 matched / 0 mismatch.
- Its own §1a-bis claim verifies exactly: at `95ba7d6`, `SCANNED 11 file(s), 30 anchor(s)` and
  `SPLIT 4 checkable … 31 uncheckable` — the doc says "4 checkable claims against 31 uncheckable
  across 30 anchors in 11 files". Exact.
- I read its argument parsing before invoking it (R291). It is read-only by construction: no shell,
  allowlisted read-only heads, `sed`/`awk` deliberately excluded, `--at` materialises via
  `git archive` into a temp dir. Hostile-anchor sentinels: 0 of 4 side-effect files created.

**I did not take the checker's word for B1.** The 36/60–95/E=4 figures above are hand-run.

---

## B2 — `pre-push-gate.sh` prints "all 6 checks evaluated a non-empty scope" while check 1 evaluated nothing.

**File:** `scripts/pre-push-gate.sh` — scope block at `:100-132`, verdict at `:200-211`, check 1 at
`:134-155`.

The new scope block assesses **only checks 4, 5 and 6**. Checks 1–3 have no branch. The header
justifies this at `:31`: *"Checks 1-3 are whole-tree and were unaffected."* That is true of checks 2
and 3. **It is false of check 1**, which is diff-scoped:

```
committed=$(git -C "$ROOT" diff --name-only "$BASE"...HEAD 2>/dev/null | skill_dirs_from || true)
...
else
    echo "== no skill directories touched vs $BASE"
fi
```

**Reproduced** (clone `scratchpad/c4`, branch with upstream 1 commit behind, one docs-only commit
touching a register, non-empty `.register-locks`, invoked as `pre-push-gate.sh basebr`):

```
== per-push scope (checks 4-6 resolve their own base; check 1 uses 'basebr')
   upstream: basebr (7ac2e02) | HEAD: 8d6932f | outgoing commits: 1
   register added-lines — committed (basebr...HEAD): 1 | staged+worktree: 0
   full scope: every per-push leg has something to evaluate      <-- CLAIM
== no skill directories touched vs basebr                         <-- CONTRADICTION, 2 lines later
...
PRE-PUSH GATE: PASSED — all 6 checks evaluated a non-empty scope and passed.
```
Exit 0.

The gate asserts a specific fact — *all 6 checks evaluated a non-empty scope* — that is false on the
same run, with the refuting line printed in its own output. This is R-0222/R-0297 exactly, and it is
the identical failure the commit set out to close: *"a green from a check that evaluated nothing is
a fabricated verification"* (`:33-34`). The mechanism built to stop the false green emits one.

**Not hypothetical for this diff:** `7ac2e02` is itself a docs-only commit touching zero skill
directories — the precise shape that triggers it.

**Answering the question as posed:** the scope block does have teeth for checks 4–6 (I confirmed it
correctly flags check 6 with no lock journal, and checks 5/6 on a zero-outgoing branch). It has
**none** for check 1, and it reports full scope while check 1 evaluates nothing.

---

# NON-BLOCKING (FIX)

## N1 — `7b03e91`'s headline partition is not reconcilable with the table it summarises.

Commit message: *"Headline structural finding: 5 scripted-and-wired · 2 scripted-but-unwired ·
3 structural · 1 mixed · 9 procedural."* Sums to 20, so it reads as a partition of F1–F20.

Extracted Class column from `MASTER-IMPROVEMENT-PLAN.md` §1a at `7ac2e02` (20 rows):

| Commit message | Table actually shows |
|---|---|
| 5 scripted-and-wired | **9** entries carry a gated leg (F2·F3·F4·F5·F8·F9·F11·F12·F14), via **4** distinct scripts. No 5 anywhere. |
| 2 scripted-but-unwired | **4** entries classed `scripted-unwired` (F7·F10·F13·F16); **6** unwired *scripts* |
| 3 structural | **1** (`structural + gated`, F3 only) |
| 1 mixed | **9** rows carry a compound class |
| 9 procedural | 9 have a procedural *leg*; **3** are pure `procedural` |

Four of five terms do not reconcile. The file's own scoring paragraph is correct and self-aware
(*"the first draft of this paragraph said '8' over a list of nine … which is the F20 class committed
inside the F20 audit"*) — the error survives only in the commit message. F20 class.

## N2 — "Four guard scripts exist that nothing calls" misstates the register.

`MASTER-IMPROVEMENT-PLAN.md:104-108` says **"6 scripts exist and nothing calls them"** and separately
that **four** of those six are *wiring debt*. The commit message collapses the two into a flat
count of four.

I measured independently. `pre-push-gate.sh` invokes exactly 6 scripts (`validate-skill.sh`,
`validate-tracking.sh`, `check-template-fences.py`, `claims-gate.sh`, `commit-scope-check.sh`,
`register-lock.sh`). Uninvoked by any gate, hook or `PIPELINE.md`: `fragment-lint.sh`,
`check-trigger-archives.sh`, `expectation-carrier-check.sh`, `eval-corpus-report.sh`,
`reanchor-pointers.sh`, `obs-anchor-check.py` — **6**, matching the register, not the message.

## N3 — Sign-test arithmetic in the commit message (docs are correct).

`7ac2e02` message: *"best one-sided exact sign-test p at n pairs is 0.5^n; n=2 → 0.25, n=3 → 0.125,
n=6 → 0.031."* Under its own stated formula, `0.5^6 = 0.015625`. **0.031 is the two-sided value at
n=6, or one-sided at n=5.** The series silently switches convention on its third term.

**The artifacts are right.** `PRE-REGISTRATION-2026-08-12.md:126-128` and
`DESIGN-ANALYSIS-2026-08-12.md:22-25` both carry correct one-sided *and* two-sided rows
(one-sided n=1..6: 0.500/0.250/0.125/0.063/0.031/0.016 — every cell verified), and
`PRE-REGISTRATION:137` correctly states *"The first n that can reach a two-sided p < 0.05 … is
n = 6."* Confined to the commit message.

## N4 — `FAILURE-LEDGER.md:326-327` carries a self-falsifying anchor.

Anchor: `` grep -rn check-trigger-archives `` *"over the repo returned only lines inside that script
itself"*. At `7ac2e02` that grep also returns `MASTER-IMPROVEMENT-PLAN.md:49,82,106` and
`FAILURE-LEDGER.md:313,326,327` — **including the anchor line itself**, so the claim cannot be true
of any tree containing it. All six lines were added by the same commit.

The other half of the same anchor is exact: `bash scripts/check-trigger-archives.sh .` → **exit 0,
"6 passed, 1 warnings, 0 failed"**, verified. And the load-bearing conclusion — nothing invokes it —
is independently **TRUE**. FIX, not BLOCK: the evidence overstates, the finding stands.

## N5 — check (i) is base-relative and is now structurally unable to fire on this branch.

Proven in clone `c1`: appending a body line to `monitor/alert-manager/SKILL.md` **with no version
bump** left check (i) at `PASS: (i) 20 skill(s) changed vs origin/main: 20 carry a new
metadata.version … 0 changed without a bump`, exit 0. It only fires when a skill's version equals
its version *at the base*; forcing that (setting metadata.version back to 4.1.1) makes it FAIL
correctly, exit 1 — so **the check does go RED** and is not inert.

But all 20 skills are already bumped vs `origin/main`, so for the remainder of `section-b`
**no further unbumped edit to any skill can trip it.** The check's own scope note is honest about
comparing against the base; the commit message's *"detects a skill edited WITHOUT a version bump"*
over-reads it.

Related, and worth stating precisely: **check (i) does not detect the alert-manager finding it is
credited with.** Run against the real tree it passes. The finding came from the fault-injection
exercise, which is what the commit message actually says ("its RED proof surfaced a real finding") —
accurate as written, but easily misread as the check guarding the class. It does not.

---

# Verified TRUE — the attacks that failed

I tried to break each of these and could not.

**The alert-manager 4.3.0 claim — CONFIRMED.** Traced every commit touching the shipped surface:
`82d9db7` bumped metadata.version to **4.3.0** (SKILL.md only); the later `8c94d04` modified
`monitor/alert-manager/references/alert-configuration-templates.md` **and**
`alert-threshold-guide.md` with **no further bump**. The shipped 4.3.0 is not the 4.3.0 it was
bumped for. A second instance exists: `a877786` edited SKILL.md + both references under an
unchanged 4.2.1.

**`705 → 590` — CONFIRMED exactly.** Corpus is byte-identical across the diff, so the comparison is
clean. Old script at `95ba7d6`: `639/705 = 0.9064` and `648/705 = 0.9191` — both published figures,
reproduced. New script at `7ac2e02`: `pooling 20 current record(s) for 20 suite(s); 4 superseded
record(s) excluded` → `530/590` and `540/590`. The four double-counted suites are exactly
alertmanager, gap, geo, refresher. The arithmetic sub-claim also holds: `(10 uncounted slot(s)
across 9 suite(s))` — geo leaves two, which is the off-by-one that produced 648 where the corpus
says 649.

**`check-freshness.sh` ends in unconditional `exit 0` — CONFIRMED.** `tail -1` = `exit 0`; the only
other `exit` is `exit 0` on the bad-root error path at `:18`. It cannot fail. Finding #94's anchor
is true.

**check (g) ratchet has teeth in both directions — CONFIRMED, three ways.**
`TRACKING_UNANCHORED_ALLOWANCE=""` → **exit 1**, FAIL naming lines 125,138,142,155,156 (matching the
script's own census comment). A 6th injected un-anchored pointer at the default allowance → **exit
1**. Allowance above actual → the paired counter-test WARN fires (*"the debt shrank; lower it"*),
so the ratchet cannot silently stop ratcheting. This leg is sound.

**The F12 pointer defect — CONFIRMED.** `grep -n I09 references/cite-domain-rating.md` → 74, 309,
449, 498; `sed -n 447p` → the **I07** Cross-Platform Consistency row; `SETTLED-RULINGS.md:156` does
label `:447` "(I09 measurement)". The pointer is genuinely wrong and correctly left unfixed —
`SETTLED-RULINGS.md` is owner-gated and **the diff does not touch it**, which is the right call.

**Other anchors added by these commits, hand-checked:** `grep -c archive
scripts/validate-tracking.sh` = 1, at `:435`, an exclusion comment — TRUE; check (h) at `:613` is
the F3 attribution sweep, not F10 — TRUE; `PIPELINE.md` names exactly 4 scripts — TRUE;
claims-gate's second diff source is real (`claims-gate.sh:17-19`, "PLUS staged + worktree changes"),
so the correction from "three collapsing legs" to two is right.

**The pilot's load-bearing claim — CONFIRMED against primary records.** I located and read every
cited deploy manifest in the eshop tree. All exist; all say what is claimed:

| Page | Claim | Record |
|---|---|---|
| **965528** F120 | 12-07 capsule "ATTEMPTED and BLOCKED, page unchanged, nothing corrupted" | `capsule-deploy-12-07-2026/MANIFEST.md:11` — *"BLOCKED. Two clean prepend+save attempts did NOT persist … page UNCHANGED … NOT deployed; nothing corrupted"* ✓ |
| **965528** | 18-07 net-new JSON-LD on a zero-JSON-LD page, 6 valid items / 4 merchant listings | `F120-WiFi/_deploy-log/DEPLOY-MANIFEST_18-07-2026.md:5,33` — *"had ZERO JSON-LD"*, *"6 valid items … Merchant listings 4 VALID"* ✓ |
| **823327** NTL4T | 12-07 capsule DEPLOYED, `Description_1` 15,913 → 16,504 B | same MANIFEST `:10` — *"len 15913→16504"* ✓ |
| **823327** | 26-07 wave-2 rewrite, all six surfaces LIVE-VERIFIED 12:07 | `07_VERIFICATION-SAFETY-LOCK_PRE-07-08-2026.md:98` — *"ALL 6 SURFACES LIVE-VERIFIED 26-07-2026 12:07"* ✓ |
| **823277** F119 | 18-07 full pass; rename driving title+h1; FAQPage moved from dead slot; warranty claim corrected; **GEO 77→88, SEO 81→86, Greek 88→93** | `F119/_deploy-log/DEPLOY-MANIFEST_safe-subset_18-07-2026.md:9,10,13,33` — *"Greek 88→93 · SEO 81→86 · GEO 77(FAIL)→88"* ✓ verbatim |
| **823322** NTL2N | clean; README built 26-06 says "0 ld+json", UPLOAD-READY, deploy gated | `thermopompos-ntl2n/Schema/README.md:3,8` ✓ — and the crawl discrepancy is correctly flagged `[VERIFY]` rather than resolved by assertion |

Cluster claim also verified: categories 132676/132671 `Categorytext_1/2` rewritten 26-07,
LIVE-VERIFIED **09:35**, fifth corrective write same session (`:97`).

**The zero-clean-pairs conclusion is VALID.** Pair 1 = 965528 + 823327 (both intervened); Pair 2 =
823277 (intervened) + 823322 (clean). With 3 of 4 pages carrying dated interventions and only two
pairs, every pair contains an intervened member ⇒ **zero**. The doc does not overclaim: it records
965528's 12-07 capsule as *blocked and non-persisting* rather than counting it as an intervention.
This section is the best-sourced work in the diff.

**Scope — CLEAN.** `git diff --name-only 95ba7d6..7ac2e02` touches only `.gitignore`, `docs/loop/`,
and `scripts/`. **Zero skill or reference files.** Consequently no version bump is owed by this diff
and `validate-skill.sh` has no skill to run against — I confirmed the skill-path grep returns empty
rather than assuming it. `7ac2e02` stays inside `docs/loop/pilot/` + `PILOT.md` + one `.gitignore`
line (`docs/loop/pilot/data/*.csv`), matching its declared T4 territory.

**Ruling compliance — CLEAN.** No diff line contradicts R1–R5. `SETTLED-RULINGS.md` is untouched.
Pilot files are R76-correct: 10 of 14 carry an explicit `DRAFTED`/`R76` token, and
`SANI-DECISION-BRIEF-2026-08-12.md` states the same thing in words at `:3` (*"Nothing has been
published. Nothing is staged against any live page. No live page was fetched to write this."*) —
substantively compliant, not a defect.

---

# What has to happen

1. **B1** — recompute `OPEN-FINDINGS.md:18` from the tree: **36 rows, ids 60–95, A=6 B=16 C=1 D=9
   E=4**. Then run `bash scripts/obs-anchor-selftest.sh` and require `head-green` to pass before the
   commit, and wire `obs-anchor-check.py --at HEAD --min-checkable 6` into the gate. The tool that
   catches this already exists in the same commit and was not run.
2. **B2** — give the scope block a branch for check 1 (`touched` empty ⇒ empty leg), or stop
   printing "all 6 checks evaluated a non-empty scope" and correct the `:31` claim that checks 1–3
   are whole-tree.
3. **N1–N3** — correct the three commit-message figures, or record them as F20 instances.
4. **N4** — re-scope or re-date the `check-trigger-archives` anchor so it is reproducible.
5. **N5** — decide whether check (i) should compare against the last bump rather than the branch
   base; as built it is inert for this branch's remaining life.

**Note for the loop's exit criterion (#93):** pass 5 was run and BLOCKed, making it **5 for 5**. The
mechanism named in #92 — *"the guard's scope, the neighbouring surface, and the freshly-changed
count all fall outside the author's attention"* — describes B1 and B2 precisely. B1 is a
freshly-changed count; B2 is a guard's scope. Both were self-verified and believed. The one thing
that would have caught B1 was already sitting in the same commit, unrun.
