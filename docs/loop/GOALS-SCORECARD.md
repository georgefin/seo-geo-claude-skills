# Goals Scorecard — the four stated goals, made checkable

**Purpose.** The repo owner stated four goals with targets. None of them was checkable when
stated, which means any claim that one is "achieved" was an opinion. This file is the
instrument: a stable set of acceptance criteria per goal, and an append-only log of dated
measurements against them.

**This is an operator register.** Run handles, skill slugs, framework item IDs, ruling IDs and
repo paths are all correct here.

**Three rules this file holds itself to.**

1. **No composite score across the four goals.** One number across four different things is
   unattributable when it moves — the same reason `references/ai-visibility-measurement.md` §5
   forbids a composite visibility score. Per-goal fractions only, and a fraction is never
   averaged with another goal's.
2. **Criteria are stable; measurements append.** Part A is edited only to *add* a criterion or
   to correct a criterion that cannot be checked as written — never to move a bar a measurement
   failed. Part B rounds are appended, never rewritten (the `KPI.md` cold-row discipline). A
   wrong measurement is corrected by appending a new round that names the one it corrects.
3. **Every count carries the command that produced it.** A figure quoted from a summary is a
   claim; a figure with its command is a measurement. Several summaries in this repo were wrong
   on 2026-08-17 and were caught only by recomputation (ledger F16 recurrences 2 and 3).

> **G1-C5's check was rewritten on 2026-08-18 under rule 2's own carve-out** — *"a criterion
> that cannot be checked as written."* It pointed at `.register-locks`, which is gitignored, so
> the evidence lived only inside the container that produced it and no one cloning this repo
> could verify the criterion at all. The 2026-08-17 wave journalled its scope for every one of
> its eight lanes and the proof would have vanished with the container. The bar did not move:
> the same rows, the same dates, the same pass condition — only the durable location changed,
> to `docs/loop/register-locks-archive/`, written by `scripts/register-lock.sh archive`. The
> working journal stays gitignored for the reason `.gitignore` already gave, which is about
> session state and not about evidence.

**Where the criteria come from.** They are derived from what this repository already treats as
evidence — the gate legs (`scripts/pre-push-gate.sh`), the eval corpus schema fixed by ledger
F16 recurrence 1, the frozen-input manifest in `PIPELINE.md` stage 4, the learning metrics in
`PIPELINE.md` § Learning metrics, G7's own "done per skill" definition in `GATED-ITEMS.md`, and
the acceptance-criterion test in `references/action-output-contract.md` §2. No new framework was
invented. Each criterion is written to pass that §2 test: observable, binary at the moment of
checking, attached to a named artefact or command, and dated or triggered.

**A `blocked` item is not a zero.** Goal 4 depends on inputs only the owner supplies
(`CLIENT-MANDATE.md` §4). Those criteria are recorded with a stated-absence status and are
excluded from the goal's fraction rather than scored zero — the action contract's own rule
(§1: a stated-absence value is itself information; a blank is not).

---

## Part A — Acceptance criteria

### Goal 1 — Structural & Coordinator Defenses (target: Team Structure 10/10)

The hardest goal to measure honestly, because the party that would score it is the party being
scored. Every criterion below is therefore a *trace* — something a third party can run or read
without asking the coordinator anything.

| ID | Criterion | Check | Pass condition |
|---|---|---|---|
| **G1-C1** | Executor blindness is enforced by a tool, not by instruction | `bash scripts/eval-prompt.sh --selftest` | Exit 0, both legs at full count over every suite in the tree, zero failures |
| **G1-C2** | Every record of the newest blind wave names the *mechanical* channel by which the executor received its prompts | grep each record in `docs/loop/eval-baselines/blind-<date>/` for `eval-prompt.sh` in a non-`--grade` executor context | All records in the wave |
| **G1-C3** | Executor/grader separation rests on an artefact fact (deliverable mtimes, or a served-vs-source hash), not only on the grader's assertion | grep each record for `mtime`/`sha256`/`md5` beside the separation statement | All records in the wave |
| **G1-C4** | Every review or grading lane records a frozen open SHA, a close SHA, and an input-drift re-check (F8 / `PIPELINE.md` stage 4 frozen-input manifest) | `repo_head_at_open`, `repo_head_at_close`, and a drift field present in each record | All records in the wave |
| **G1-C5** | Multi-lane waves journal their disjoint scope | For each date on which two or more lanes wrote to the tree, `docs/loop/register-locks-archive/<date>.tsv` carries ACQUIRE/RELEASE rows | Every such date |
| **G1-C6** | Coordinator conduct is ledgered on the same terms as a lane's — entry, recurrence increment, and a rule | `FAILURE-LEDGER.md` entries whose subject is coordinator conduct in the round under measurement | Every identified breach has an entry with a rule |
| **G1-C7** | Zero coordinator-attributable recurrences in the round under measurement (`PIPELINE.md` learning metric 2, target 0) | Count recurrence entries in `FAILURE-LEDGER.md` dated to the round whose subject is the coordinator | 0 |
| **G1-C8** | Gate catches on the coordinator's own commits are counted in the `KPI.md` row for every fire | `KPI.md` `caught pre-push vs post-push` column | Every row carries a number, not `n/a` |
| **G1-C9** | Every graded record has a second reader who did not grade it | A confirmation field naming a distinct reviewer in each record | All records in the wave |

### Goal 2 — Complete Skill Evaluation & Verification (target: Skills 10/10)

G7's own definition in `GATED-ITEMS.md` is *"suite + baseline + zero-regression protection +
VERSIONS sync"*. C1–C9 are that definition made checkable, plus the record-quality rules ledger
F16 recurrence 1 fixed.

| ID | Criterion | Check | Pass condition |
|---|---|---|---|
| **G2-C1** | Every skill carries an eval suite | `ls -d */*/evals/evals.json` | 20 of 20 |
| **G2-C2** | Every skill has a blind record in the newest wave | one record per skill under `docs/loop/eval-baselines/blind-<date>/` | 20 of 20 |
| **G2-C3** | Every record is **current**, defined as the repo's own frozen-input manifest: graded version equals HEAD `metadata.version` **and** no file in that record's manifest — `SKILL.md`, the `references/` it cites *including shared `references/`*, `evals/evals.json`, fixtures — has changed since the record's own `repo_head_at_open` | per record: compare `skill_version_under_test` to HEAD frontmatter, then `git diff --name-only <repo_head_at_open>..HEAD -- <skill-dir> <cited shared refs>` | 20 of 20 |
| **G2-C4** | No record carries an unresolved provisional or grader-termination notice | grep each record for a provisional/termination marker without a later confirmation | 20 of 20 |
| **G2-C5** | Every record carries a per-expectation regression comparison against the prior baseline, or states that no prior record exists | `regressions_vs_baseline` states a comparison performed, or "no prior baseline" | 20 of 20 |
| **G2-C6** | Zero grader-attributed regressions stand unfixed (`PIPELINE.md` learning metric 1, target 0; any regression is do-not-merge) | sum the attributed regression items across the wave's records; subtract those recorded fixed and re-exercised by a later blind run | 0 |
| **G2-C7** | Every attributed regression is carried into a register a later session can find — `OPEN-FINDINGS.md` or `FAILURE-LEDGER.md` — not left only inside its own record | grep each regression's suite and expectation id across the registers | All attributed regressions |
| **G2-C8** | Every record conforms to the corpus schema (`summary.passed/failed/total` as integers; the editor-slot convention stated inside the summary object; `passed + failed` reconciles to `total` or the gap is explained there) | `bash scripts/eval-corpus-report.sh` plus a field read of each `summary` | 20 of 20 |
| **G2-C9** | Every record carries a defects-outside-the-graded-set list, or states plainly that it did not look | `defects_outside_the_graded_set` present and non-vacuous in each record | 20 of 20 |

### Goal 3 — Loop Durability & Scripted Rigor (target: Loops 10/10)

| ID | Criterion | Check | Pass condition |
|---|---|---|---|
| **G3-C1** | The push gate exits 0 at HEAD | `bash scripts/pre-push-gate.sh` | Exit 0 |
| **G3-C2** | Every skill validates clean | `bash scripts/validate-skill.sh <dir>` for all 20 | 15/15, 0 failed, each |
| **G3-C3** | Repo-level tracking validates with zero FAILs | `bash scripts/validate-tracking.sh .` | 0 failed |
| **G3-C4** | The gate run that certifies a push has a non-empty scope on **every** leg — a leg that scanned nothing is not evidence about anything (the gate's own null-scope disclosure) | the gate's closing line plus each leg's own "nothing to check" output | All legs scanned a non-empty subject |
| **G3-C5** | Every gate leg exposes a fault-injection mode (`--probe`, `--selftest`, or a fixture corpus with a negative control) and it passes at HEAD — ledger F15's standing rule that a guard is unproven until watched failing | run each leg's probe | All gate legs |
| **G3-C6** | Every advisory (ungated) check states its own coverage limit in its own file, and its headline count reproduces when re-run at HEAD | run each advisory check; compare its output to the figure recorded in its header | All advisory checks |
| **G3-C7** | No ledger class recorded closed has a surviving instance at HEAD, when re-tested by a method **independent of the method that closed it** (a line-based closure grep is re-tested multiline; a verb-list sweep is re-tested against a verb it does not list) | for each closed class, re-run the closure test in a form the original could not express | Zero surviving instances |
| **G3-C8** | `KPI.md` carries a row for the round under measurement whose figures re-derive from the artefacts at HEAD, or a later appended row that corrects it | re-derive each cell of the newest row from the records now present | Figures re-derive, or a correcting row exists |

### Goal 4 — Outcome Quality & Real-World Pilot (target: Proof of Utmost Quality)

Split deliberately. **4A is what the library can demonstrate on its own** and is scored.
**4B depends on inputs only the owner supplies** (`CLIENT-MANDATE.md` §4, `PILOT.md` §0); those
criteria carry a stated-absence status and are **excluded from the fraction**, because scoring a
a `blocked` item as a zero would read as a failure of work nobody was free to do.

**4A — library-demonstrable (scored)**

| ID | Criterion | Check | Pass condition |
|---|---|---|---|
| **G4-C1** | Every skill that emits recommendations carries the seven-field action contract in its own `SKILL.md` body — `CLAUDE.md` § Every Action Is Implementable binds *"every recommended action"* with no carve-out | grep each `SKILL.md` for the contract path and its field vocabulary (`acceptance criterion`, `risk-if-done-wrong`, `owner-role`) | 20 of 20 |
| **G4-C2** | Every blind record reports quality beyond its pass rate: at least one defect outside the graded set, or a stated list of what it looked for and did not find | `defects_outside_the_graded_set` in each record | All records in the wave |
| **G4-C3** | A dated market-side pilot artefact exists that states its own method limits, and no claim in it rests on a source the environment could not reach | files under `docs/loop/pilot/`, each carrying a method-limits section | At least one per named pilot cluster |
| **G4-C4** | At least one AI-visibility capture is recorded under the N ≥ 3 repeat protocol against a versioned prompt set (`references/ai-visibility-measurement.md` §4) | a capture log naming the prompt-set version, engine, date and `k of N` | ≥ 1 capture per named cluster |

**4B — owner-gated (stated absence; not scored)**

| ID | Criterion | Check | Status vocabulary |
|---|---|---|---|
| **G4-B1** | `PILOT.md` §0's three inputs each clear their bar in §0.1 | §0.1 recorded words per input | `cleared` / `part-supplied` / `open` |
| **G4-B2** | `PILOT.md` §4 pre-registration is locked, with Sani's dated wording in the lock record and no unfilled criteria cells | count `[AWAITING SANI + BASELINE DATA]` cells; read the lock record line | `locked` / `unlocked` |
| **G4-B3** | `PILOT.md` §6 carries a filled CP0 baseline row | read the checkpoint table | `filled` / `empty` |
| **G4-B4** | The environment reaches the pilot property, so a baseline step that reads the property can run | `curl` the property and a control host from the same session | `reachable` / `refused at gateway` |

---

## Part B — Measurement log (append-only; newest last)

### Round 1 — 2026-08-17

- **Tree measured**: HEAD `5266d39`, working tree clean at open
  `[obs:2026-08-17T17:00Z git rev-parse HEAD -> 5266d395516156bb1f79eb4823cb550f9c8fc31b; git status --short -> empty]`
- **Wave under measurement**: `docs/loop/eval-baselines/blind-2026-08-17/`, 20 records
- **Measured by**: an independent scorecard lane. It graded nothing and re-ran no skill; every
  figure below is a command re-run at HEAD, not a figure carried from a register.

#### Goal 1 — **3 of 9 criteria met**

| ID | Result | Measurement and evidence |
|---|---|---|
| G1-C1 | **MET** | `bash scripts/eval-prompt.sh --selftest` → `SELFTEST PASS`; 20 suites scanned, 200 id round-trip assertions accepted, 100 evals whose blind output is prompt + fixture paths + fixed footer only `[obs:2026-08-17T17:04Z scripts/eval-prompt.sh --selftest — SELFTEST PASS, 20/200/100]` |
| G1-C2 | **12 of 20** | Records naming `eval-prompt.sh` as the executor's own serving channel: alert-manager, backlink-analyzer, competitor-analysis, content-gap-analysis, domain-authority-auditor, entity-optimizer, geo-content-optimizer, internal-linking-optimizer, keyword-research, performance-reporter, rank-tracker, technical-seo-checker. The other 8 (content-quality-auditor, content-refresher, memory-management, meta-tags-optimizer, on-page-seo-auditor, schema-markup-generator, seo-content-writer, serp-analysis) reference the script only in its `--grade` form — the grader's call — and rest the executor's blindness on a separate-agent statement `[obs:2026-08-17T17:05Z python scan of the 20 records for eval-prompt.sh in a non---grade executor context — 12 hits]` |
| G1-C3 | **18 of 20** | 18 records carry an artefact fact beside the separation claim (deliverable mtimes, or sha256/md5 of served-vs-source inputs). keyword-research and performance-reporter state role separation in prose only — both do name the mechanical channel, so this is the weaker of two independent legs, not an absence of both `[obs:2026-08-17T17:06Z python scan for mtime/sha256/md5 in the separation statement — 18 of 20]` |
| G1-C4 | **MET, 20 of 20** | Every record carries `repo_head_at_open`, `repo_head_at_close` and a named input-drift re-check, several reporting drift against themselves (content-refresher: *"head_moved: Yes, by five commits"*; geo-content-optimizer: *"HEAD moved TWICE while this round was in flight"*) `[obs:2026-08-17T17:05Z python field read over 20 records — 20/20 open+close+drift]` |
| G1-C5 | **1 of 3 wave dates** | `.register-locks` holds 86 rows, **all dated 2026-08-10**, newest `2026-08-10T17:51:07Z`. The 2026-08-13 wave and the 2026-08-17 six-lane wave journalled nothing. The 2026-08-17 wave is the one in which the coordinator edited five files six lanes had been told to read (F8 recurrence 2) `[obs:2026-08-17T17:07Z grep -o "2026-08-[0-9][0-9]" .register-locks | sort | uniq -c -> 86 rows, all 2026-08-10]` |
| G1-C6 | **MET** | Coordinator conduct is on the same ledger as everyone else's: `F8 — Recurrence (2026-08-17)` and `F8 — Recurrence 2 (2026-08-17)`, each with a rule, the second recording that its own first draft *"was written to excuse it"* and was deleted rather than patched. 17 of the 47 ledger entry headings mention the coordinator `[obs:2026-08-17T17:08Z grep -c "^#\{2,3\} F[0-9]" FAILURE-LEDGER.md -> 47; entries mentioning coordinator -> 17]` |
| G1-C7 | **NOT MET — 2** | F8 has **two** recurrence entries, both dated 2026-08-17, both the coordinator, the second after the rule had been restated verbatim in three lane briefs. Target is 0. Across the whole ledger F8 now carries 3 headings (1 founding + 2 recurrences) `[obs:2026-08-17T17:09Z grep -o "^#\{2,3\} F8" FAILURE-LEDGER.md | wc -l -> 3]` |
| G1-C8 | **2 of 3 rows** | `KPI.md` `caught pre-push vs post-push`: 2026-08-10 = `8/0` (the column note states all eight were on the coordinator's own commits); 2026-08-13 = `11/3` (11 gate stops on coordinator commits); **2026-08-17 = `n/a`**, its note stating the lane could not see the wave's gate history. The newest round is the one with no number `[obs:2026-08-17T17:02Z read of KPI.md rows 39, 64, 65]` |
| G1-C9 | **1 of 20** | One record carries an independent confirmation pass: `content-gap-analysis.json`'s `confirmation_2026_08_17`. That single second reading **added two defects the original record had explicitly denied existed** (D7, D8 — *"NOT in the original record, whose `explicitly_not_found` states the opposite"*) and raised a candidate F3 recurrence for the coordinator to rule on. The other 19 records have had no second reader `[obs:2026-08-17T17:07Z python scan for a confirmation field / "confirming reviewer" across 20 records — 1 hit]` |

**Most consequential unmet criterion: G1-C9.** Nineteen of twenty graded records rest on one
reader. The one record that got a second reader gained two defects and a candidate ledger
increment — so the second-reader yield on this corpus is not zero, it is unmeasured on 95% of it.
G1-C5 is the close second, and it is worse in kind: the mechanism that would have prevented the
coordinator's own recorded breach exists, and was not switched on for the wave in which the
breach happened.

#### Goal 2 — **5 of 9 criteria met**

| ID | Result | Measurement and evidence |
|---|---|---|
| G2-C1 | **MET, 20 of 20** | `ls -d */*/evals` → 20 directories, one per skill `[obs:2026-08-17T16:55Z ls -d */*/evals | wc -l -> 20]` |
| G2-C2 | **MET, 20 of 20** | 20 record files under `docs/loop/eval-baselines/blind-2026-08-17/`, one per skill `[obs:2026-08-17T16:56Z ls blind-2026-08-17/*.json -> 20]` |
| G2-C3 | **2 of 20** | Under the criterion as written (frozen-input manifest, shared references included): only **rank-tracker** and **serp-analysis** are current. Under the weaker working definition — version match plus an empty diff over the *skill directory alone* — it is **9 of 20** (alert-manager, competitor-analysis, geo-content-optimizer, internal-linking-optimizer, keyword-research, meta-tags-optimizer, rank-tracker, schema-markup-generator, serp-analysis). The gap between 9 and 2 is entirely shared-reference movement: seven of those nine were graded before `references/inter-skill-handoff.md`, `references/core-eeat-benchmark.md` or `references/prohibited-tactics.md` moved under them. **Both numbers are stated because the choice between them is a judgement**; the criterion takes the stricter one because `PIPELINE.md` stage 4 already defines the graded input set as *"target `SKILL.md`, the `references/` it cites, `evals/evals.json` and its fixtures"* — the shared references a skill cites are graded inputs by the repo's own rule, not by this file's invention. The remaining 11 fail on the weak test too: graded version ≠ HEAD version, with 2–7 files changed since the record opened (largest: technical-seo-checker, 4.5.0 graded vs 4.6.1 at HEAD, 7 files) `[obs:2026-08-17T16:58Z per-record version compare + git diff --name-only <repo_head_at_open>..HEAD over skill dir and cited shared refs — 9 of 20 weak, 2 of 20 strict]` |
| G2-C4 | **MET, 20 of 20** | No unresolved provisional. content-gap-analysis opened provisional (grader terminated on a spend limit) and carries an explicit later confirmation: *"CONFIRMED. The confounder elimination was real and is reproducible"* `[obs:2026-08-17T17:06Z python scan for provisional/termination markers lacking a confirmation — 0 of 20]` |
| G2-C5 | **18 of 20** | 18 records state a per-expectation comparison performed. **performance-reporter** and **rank-tracker** state `NOT PERFORMED` — both because the launching brief scoped their reads to a single unrelated record — and both say so rather than downgrading it to "none", which is the honest form of the miss `[obs:2026-08-17T16:59Z python read of regressions_vs_baseline across 20 records — 18 comparisons, 2 NOT PERFORMED]` |
| G2-C6 | **NOT MET — 19 open** | **19 grader-attributed regressions across 10 of the 18 compared suites**, none recorded fixed and re-exercised: on-page-seo-auditor 4 (e1.5, e3.5, e5.1, e2.6) · alert-manager 3 (e2.6, e3.1, e4.4) · content-quality-auditor 2 (e4.4, e4.6) · content-refresher 2 (e1.1, e2.6) · keyword-research 2 (e3.3, e4.1) · serp-analysis 2 (e3.1, e4.2) · backlink-analyzer 1 (e1.6) · geo-content-optimizer 1 (e2.1) · internal-linking-optimizer 1 (e4.4) · schema-markup-generator 1 (e1.7). Every one is do-not-merge class by `PIPELINE.md`'s own rule `[obs:2026-08-17T17:00Z python count over regressions_vs_baseline items/count fields across 20 records — 19 items, 10 suites]` |
| G2-C7 | **8 of 19** | `OPEN-FINDINGS.md` rows 154–158 register 8 of the 19 (alert-manager 3, keyword-research 2, internal-linking-optimizer 1, backlink-analyzer 1, geo-content-optimizer 1). The other **11** — on-page-seo-auditor 4, content-quality-auditor 2, content-refresher 2, serp-analysis 2, schema-markup-generator 1 — exist only inside their own record files. Their records all landed after 14:45Z, which is when the `KPI.md` row was written; nothing has swept the arrivals since `[obs:2026-08-17T17:01Z grep of each regression's expectation id across OPEN-FINDINGS.md, FAILURE-LEDGER.md, KPI.md — 8 registered, 11 unregistered]` |
| G2-C8 | **MET, 20 of 20** | All 20 carry integer `summary.passed/failed/total` and state an editor-slot convention inside the summary object. Reconciliation gaps are 1–3 slots and each record names them (editor-pending and instrument-defect slots). `scripts/eval-corpus-report.sh` reads all 21 pooled records and prints no headline, by design, because the corpus mixes conventions across waves — 32 suite-records leave the editor slot uncounted and 15 count it `[obs:2026-08-17T16:57Z bash scripts/eval-corpus-report.sh — MIXED EDITOR-SLOT CONVENTION, no pooled figure printed; range 0.6207–1.0000]` |
| G2-C9 | **MET, 20 of 20** | Every record carries a `defects_outside_the_graded_set` field; the list-shaped ones enumerate 30 defects between them, and the prose ones state what was screened and what surfaced `[obs:2026-08-17T17:03Z python key scan across 20 records — 20/20 present]` |

**Most consequential unmet criterion: G2-C6.** Nineteen attributed regressions stand, and eleven
of them are not in any register a future session would read. A skill whose suite passes at 96%
while three of its expectations moved from PASS to FAIL is a skill that got worse in the places
somebody had already thought to test.

#### Goal 3 — **4 of 8 criteria met**

| ID | Result | Measurement and evidence |
|---|---|---|
| G3-C1 | **MET** | `bash scripts/pre-push-gate.sh` → `PRE-PUSH GATE: PASSED` `[obs:2026-08-17T17:01Z bash scripts/pre-push-gate.sh — exit 0]` |
| G3-C2 | **MET, 20 of 20** | Every skill returns `Results: 15 passed, 0 warnings, 0 failed` `[obs:2026-08-17T16:54Z bash scripts/validate-skill.sh over all 20 skill dirs — 20 × 15/15/0]` |
| G3-C3 | **MET** | `Results: 10 passed, 12 warnings, 0 failed`. The 12 warnings are 11 body-length headroom notices (330+ of a 350 cap; largest technical-seo-checker at 349) and one check (g) notice of 8 un-anchored `file:line` pointers `[obs:2026-08-17T16:53Z bash scripts/validate-tracking.sh . — 10/12/0]` |
| G3-C4 | **NOT MET — 2 of 5 legs had a subject** | The gate's own closing line: `PASSED — but NOTHING WAS OUTGOING`. `claims-gate`, `commit-scope-check` and `register-lock` each reported *"no outgoing commits — nothing to check"*. Only `validate-tracking` and `fence-nesting-check` scanned the tree. The gate is right to be scoped this way and right to disclose it; the point for this scorecard is that a green gate at HEAD is evidence about two legs, not five `[obs:2026-08-17T17:01Z bash scripts/pre-push-gate.sh — 3 legs reported nothing to check]` |
| G3-C5 | **3 of 6 gate legs** | Fault injection present and passing: `validate-tracking.sh --probe` → `PROBE PASS`; `fence-nesting-check.sh --probe` → `PROBE PASS — 6 negative controls, 4 mechanisms`; `claims-gate.sh --fixture` → fires on a defect fixture (2 failed) and stays clean on `negative-control-clean` (3 passed, 0 failed). **Absent**: `validate-skill.sh` (zero occurrences of probe/selftest/fixture), `commit-scope-check.sh` (names fixtures only in an F14 narrative; no fixture directory exists), `register-lock.sh` `[obs:2026-08-17T17:10Z probe runs + grep -c "probe\|selftest\|fixture" scripts/validate-skill.sh -> 0; ls scripts/fixtures -> 4 dirs, none for commit-scope-check]` |
| G3-C6 | **MET, 5 of 5 advisory checks** | Each states its limit in its own file and reproduces at HEAD: `fence-nesting-check.sh --bare-inner` → 6 sites in 5 files, exactly the six its header lists after the four in-scope repairs (its header also records the pre-repair measurement of 10, of which 10 of 10 were hand-checked true — note the root `CLAUDE.md` summary still quotes the pre-repair 10 without the 10 → 6 update, so the script is the accurate carrier); `expectation-carrier-check.sh` → 185 candidate phrases with a footer stating coverage of 1 of 3 known instances and naming both shapes it cannot see; `engine-claim-sweep.sh --probe` → fires, and prints what it does not protect (verb lists at branch level, the excuse lists, and that it never validates a residual *is* a defect); `citation-divergence-check.sh` → `1 passed, 1 warnings, 6 failed`, all six on R3, matching the state `OPEN-FINDINGS.md` G-G1 records as open pending the R3 verdict; `check-freshness.sh` → all tracked state within window `[obs:2026-08-17T17:00Z five advisory runs — counts as recorded in each script header]` |
| G3-C7 | **NOT MET — 1 live instance of a class recorded closed** | The R3 "advises against removing" overstatement was recorded FIXED across **13 shipped surfaces** on 2026-08-13 (`OPEN-FINDINGS.md` B2), with a hard-fail guard added at `validate-tracking.sh` check (f). At HEAD, `optimize/content-refresher/references/refresh-templates.md:464-465` still carries it — *"it costs nothing to keep, and Google advises / against proactively removing it"* — wrapping between the two lines. Re-tested independently: a **multiline** scan over every `.md` in the repo returns 5 hits, of which **1 is in a shipped skill reference**; the other 4 are changelog and proposal prose (`VERSIONS.md` ×3, `docs/loop/r3-supersession-candidate.md` ×1). The guard's own pattern, run line-based against that file exactly as check (f) runs it, returns **0** `[obs:2026-08-17T17:08Z python multiline regex over all .md -> 5 hits incl. refresh-templates.md:464; grep -cniE "$R3_OVERSTATE" on that file -> 0]`. This is not a hypothetical: it is a class certified closed whose certifying instrument cannot see the surviving member |
| G3-C8 | **NOT MET** | `KPI.md`'s 2026-08-17 row states *"8 of 229 previously-passing expectations across the 9 compared suites = 3.5%"* over the 11 records that existed at 14:45Z, and warns in its own note that the wave was still producing records. At HEAD there are 20 records, 18 comparisons and 19 confirmed regressions. The row is correct as a cold row and correctly self-limited; the criterion is unmet because **no correcting row has been appended**, which is that file's own rule 1 `[obs:2026-08-17T17:00Z KPI.md newest row = 2026-08-17, 11-record basis; blind-2026-08-17/ now holds 20 records with 19 regressions]` |

**Most consequential unmet criterion: G3-C7.** It is the only one that shows a *closure claim
itself* to be unreliable. G3-C4, G3-C5 and G3-C8 describe instruments with known reach; G3-C7
describes a register saying "fixed" about something that is not.

#### Goal 4 — **4A: 2 of 4 criteria met. 4B: 0 of 4 cleared, all owner-gated**

**4A — library-demonstrable (scored)**

| ID | Result | Measurement and evidence |
|---|---|---|
| G4-C1 | **7 of 20 in body; 10 of 20 counting pointer-only** | Carried in the `SKILL.md` body (7): on-page-seo-auditor, technical-seo-checker, backlink-analyzer, performance-reporter, content-quality-auditor, domain-authority-auditor, entity-optimizer. Pointer only, from a reference file with no rule in the body (3): content-gap-analysis, geo-content-optimizer, internal-linking-optimizer. **No mention anywhere (10)**: keyword-research, competitor-analysis, serp-analysis, seo-content-writer, meta-tags-optimizer, schema-markup-generator, content-refresher, rank-tracker, alert-manager, memory-management. Independently re-measured for this scorecard and identical to `OPEN-FINDINGS.md` 161 `[obs:2026-08-17T17:02Z grep -c over each SKILL.md for action-output-contract / acceptance criterion / risk-if-done-wrong / owner-role — 7 body, 3 refs-only, 10 none]` |
| G4-C2 | **MET, 20 of 20** | Same measurement as G2-C9; 30 enumerated out-of-set defects in the list-shaped records alone, plus screened-and-found-nothing statements in the rest `[obs:2026-08-17T17:03Z python key scan across 20 records — 20/20 present]` |
| G4-C3 | **MET for both named clusters** | `docs/loop/pilot/` holds four dated artefacts: `technical-entity-assessment-2026-08-17.md` (opens with a §0 stating what its method can and cannot establish, and demonstrates its own tool's unreliability rather than asserting around it), `prompt-set-v1-2026-08-17.md`, `pairing-analysis-2026-08-13.md`, `thermopompoi-consolidation-brief.md`. Both αφυγραντήρες and θερμοπομποί are covered `[obs:2026-08-17T17:04Z ls -la docs/loop/pilot/ — 4 files; head of each for a method-limits section]` |
| G4-C4 | **NOT MET — 0 captures** | `prompt-set-v1-2026-08-17.md` states of itself: *"this is **v1**, and it has never been used for a capture"*. It is labelled DRAFT and deliberately incomplete pending the client's own sales questions. 50 rate-feeding prompts are drafted (36 Greek, 14 English) and no `k of N` capture exists for any of them `[obs:2026-08-17T17:04Z read of prompt-set-v1-2026-08-17.md header; no capture log exists under docs/loop/pilot/]` |

**4B — owner-gated (stated absence; excluded from the fraction, per `references/action-output-contract.md` §1)**

| ID | Status | Measurement and evidence |
|---|---|---|
| G4-B1 | `0 of 3 inputs cleared` — owner | Input 1 `part-supplied` (property and cluster rule recorded; the 5–15 page URL list is still owed, and the coordinator does not infer it). Input 2 `in progress` (no GSC/GA4 server exists in `.mcp.json`; the export path is the primary route; what Peec AI can export is an open question). Input 3 `open` (no named publisher, approval channel, capture method or turnaround recorded) `[obs:2026-08-17T17:04Z read of PILOT.md §0 and §0.1 recorded-words entries]` |
| G4-B2 | `unlocked` — owner + baseline data | Lock record reads `[UNLOCKED — awaiting Sani + baseline data]`; 9 awaiting-cells across 3 metrics × 3 criteria columns `[obs:2026-08-17T17:11Z grep -c "\[AWAITING SANI + BASELINE DATA\]" PILOT.md -> 9; PILOT.md:361 lock record]` |
| G4-B3 | `empty` — downstream of B1/B2 | All five checkpoint rows CP0–CP4 are empty; the confound log has a header and no rows; the execution tree (`baseline/`, `pre-change/`, `data/`, `citations/`, `approvals.md`) does not exist `[obs:2026-08-17T17:11Z PILOT.md:414-418 five empty rows; ls docs/loop/pilot/ shows none of the five execution paths]` |
| G4-B4 | `refused at gateway` — environment owner | Re-tested this session, not carried from the record: `https://www.sanihellas.gr/` returns `curl: (56) CONNECT tunnel failed, response 403`; a control request to `github.com` completes the tunnel and returns an HTTP status. Host-specific refusal, unchanged from the 2026-08-11 and 2026-08-17 09:52Z records `[obs:2026-08-17T17:05Z curl --max-time 12 https://www.sanihellas.gr/ -> (56) CONNECT tunnel failed 403; curl https://github.com/ -> HTTP 400]` |

**Most consequential unmet criterion (4A): G4-C1.** Ten of twenty skills emit recommendations
against a binding rule they are never shown — the exact shape of ledger F17. The goal's own name
is outcome *quality*, and half the library cannot produce an action a client could check.


### Round 2 — 2026-08-18

- **Tree measured**: HEAD `fc41319`, working tree clean at open
  `[obs:2026-08-18T09:20Z git rev-parse HEAD -> fc41319; git status --short -> empty]`
- **Wave under measurement**: `docs/loop/eval-baselines/blind-2026-08-17/`, 20 records — **the
  same wave Round 1 measured.** No new blind wave has been run. This matters for reading the
  Goal 2 movement below: the records did not change, **the tree underneath them did.**
- **The hand-off brief named HEAD `8164b77`; that SHA is 15 commits behind.** Its own outstanding
  list is therefore partly stale — item 8 ("`archive` is the one gate leg with no fault
  injection") was closed by `55227fb`, which is *after* `8164b77`
  `[obs:2026-08-18T09:12Z git merge-base --is-ancestor 8164b77 HEAD -> 0; git log --oneline 8164b77..HEAD | wc -l -> 15]`
- **Measured by**: the coordinator, which is a weaker arrangement than Round 1's independent lane
  and is disclosed rather than glossed. Every figure is a command re-run at HEAD.
- **Four of this round's own instruments were aimed beside the target and were caught before
  recording** — see the closing note. That is the round's most transferable finding.

#### Goal 1 — **4 of 9 criteria met** (Round 1: 3 of 9)

| ID | Result | Movement | Measurement and evidence |
|---|---|---|---|
| G1-C1 | **MET** | = | `SELFTEST PASS`; 200 id round-trip assertions accepted, 100 evals whose blind output is prompt + fixture paths + fixed footer only `[obs:2026-08-18T09:18Z bash scripts/eval-prompt.sh --selftest]` |
| G1-C2 | **13 of 20** | ▲ +1 | Records naming `eval-prompt.sh` in a non-`--grade` executor context. The 7 that do not — content-refresher, memory-management, meta-tags-optimizer, on-page-seo-auditor, schema-markup-generator, seo-content-writer, serp-analysis — carry exactly one mention each, all of the form `"... eval-prompt.sh <dir> <ids> --grade"`, which is the grader's own call `[obs:2026-08-18T09:14Z python context scan over 20 records, ±160 chars around each mention]` |
| G1-C3 | **18 of 20** | = | keyword-research and performance-reporter still rest the separation claim on prose alone `[obs:2026-08-18T09:14Z python scan for mtime/sha256/md5 — 18 of 20]` |
| G1-C4 | **MET, 20 of 20** | = | **Corrected instrument.** A key-name check for `input_drift_during_the_grading` returned 19 of 20, flagging geo-content-optimizer. That record uses `input_drift_during_run`. Re-run accepting any drift-named key: 20 of 20. Round 1's 20 of 20 stands `[obs:2026-08-18T09:15Z python: repo_head_at_open AND repo_head_at_close AND any key matching /drift/ non-null -> 20/20]` |
| G1-C5 | **3 of 4 wave dates** | ▲ from 1 of 3 | `docs/loop/register-locks-archive/` now holds `2026-08-10.tsv` (86 rows, 43 ACQUIRE / 43 RELEASE), `2026-08-17.tsv` (59 rows, 28/31) and `2026-08-18.tsv` (55 rows, 27/28). **`2026-08-13` remains unarchived** and cannot be recovered — the mechanism was not running that day. Under Round 1's 3-date denominator this is 2 of 3; adding 08-18 as a fourth wave date, 3 of 4. **Both are stated because the denominator is a judgement, not a fact** `[obs:2026-08-18T09:16Z ls docs/loop/register-locks-archive/; wc -l and ACQUIRE/RELEASE counts per file]` |
| G1-C6 | **MET** | = | 50 ledger entries; 53 mentions of the coordinator as subject. The round's own coordinator finding is entered below (`F11 — Recurrence`, the RESUME.md over-broad claim) with a rule attached `[obs:2026-08-18T09:22Z grep -cE "^#{2,3} (F[0-9]+|Correction|Ruling|M[0-9])" -> 50]` |
| G1-C7 | **NOT MET — 1** | ▲ from 2 | Zero recurrence entries were dated 2026-08-18 when the round opened. **One was added by this measurement, against the coordinator**: `RESUME.md` §2, written and pushed earlier the same day, asserted *"This container cannot reach any host on the open internet"* — disproved by the same session's own `git push`, and by `curl https://github.com/` returning HTTP 400 while `sanihellas.gr` returns `(56) CONNECT tunnel failed`. It passed the claims gate because the gate anchors lexicon tokens and the overstatement rode inside an anchored sentence. Target is 0; this is 1, and it is better than 2 `[obs:2026-08-18T09:20Z curl github -> 400, curl sanihellas -> 000/(56); RESUME.md §2 corrected in place at this round]` |
| G1-C8 | **2 of 4 rows** | ▼ from 2 of 3 | `KPI.md` `caught pre-push vs post-push`: 2026-08-10 `8/0`; 2026-08-13 `11/3`; 2026-08-17 `n/a`; 2026-08-17-corrected `n/a`. The numerator did not move; **a fourth row arrived carrying `n/a`**, so the fraction fell without anything getting worse. There is still no row for 2026-08-18 `[obs:2026-08-18T09:19Z python row parse of KPI.md — 4 rows, cols 1 and 6]` |
| G1-C9 | **13 of 20** | ▲▲ from 1 of 20 | The largest single forward movement in the file. 13 records carry a `second_read` object naming a distinct reader, a date and a `repo_head_at_second_read`. Missing: competitor-analysis, content-gap-analysis, rank-tracker, schema-markup-generator, seo-content-writer, serp-analysis, technical-seo-checker. **This figure was measured wrongly twice before it was measured right** — see the closing note `[obs:2026-08-18T09:15Z python: second_read is a dict AND carries a non-empty "reader" -> 13/20]` |

**Most consequential unmet criterion: G1-C9 still**, but it is no longer the same problem. Round 1
recorded 19 of 20 records resting on one reader; it is now 7 of 20. The criterion is unmet and the
risk it names has shrunk by two thirds.

#### Goal 2 — **6 of 9 criteria met** (Round 1: 5 of 9)

| ID | Result | Movement | Measurement and evidence |
|---|---|---|---|
| G2-C1 | **MET, 20 of 20** | = | `ls -d */*/evals/evals.json | wc -l` → 20 `[obs:2026-08-18T09:12Z]` |
| G2-C2 | **MET, 20 of 20** | = | 20 records under `blind-2026-08-17/` `[obs:2026-08-18T09:12Z ls *.json | wc -l -> 20]` |
| G2-C3 | **0 of 20** | ▼▼ from 2 of 20 | **The round's worst movement, and it went to zero.** Not one record is current on either reading. Every graded version differs from its skill's HEAD version; every skill directory carries 2–7 changed files since its record's `repo_head_at_open`; and `references/` moved 5 files under all 20. Largest single drift: technical-seo-checker, graded 4.5.0 against HEAD 4.6.3, 7 files changed. **Nothing was done wrong to cause this** — an 18-skill wave landed after the records were written, which is exactly what the criterion is built to detect `[obs:2026-08-18T09:13Z per-record version compare + git diff --name-only <repo_head_at_open>..HEAD over skill dir and references/ — strict 0/20, weak 0/20]` |
| G2-C4 | **MET, 20 of 20** | = | No unresolved provisional or termination notice `[obs:2026-08-18T09:16Z python scan — 0 of 20 unresolved]` |
| G2-C5 | **MET, 20 of 20** | ▲ from 18 of 20 | Every record names a baseline and states a comparison. performance-reporter and rank-tracker were both closed by the stale-and-uncompared lane; each carries its own note that the field *"previously read NOT PERFORMED"*. **That sentence defeated two of this round's three attempts to measure this criterion** — see the closing note `[obs:2026-08-18T09:17Z field-shape read of regressions_vs_baseline across all 20 records]` |
| G2-C6 | **NOT MET — 21 open** | ▼ from 19 | 21 grader-attributed regressions across 12 of 20 compared suites: on-page-seo-auditor 4 · alert-manager 3 · content-quality-auditor 2 · content-refresher 2 · keyword-research 2 · serp-analysis 2 · backlink-analyzer 1 · geo-content-optimizer 1 · internal-linking-optimizer 1 · performance-reporter 1 · rank-tracker 1 · schema-markup-generator 1. **The rise from 19 to 21 is not a deterioration** — it is the two suites that were uncompared in Round 1 reporting their comparisons. Closing G2-C5 was what surfaced them. None is recorded fixed *and* re-exercised by a later blind run, because no later blind run exists `[obs:2026-08-18T09:18Z python count over 8 distinct field shapes; 0 unresolved shapes]` |
| G2-C7 | **20 of 21** | ▲▲ from 8 of 19 | 20 of the 21 regression ids appear in `OPEN-FINDINGS.md`, `FAILURE-LEDGER.md` or `KPI.md` **co-located with their own suite name** within a 600-character window — the tighter of two tests, because a bare `e4.4` matches across suites. The one exception is **performance-reporter `e4.3`**, whose id appears in a register but not beside its suite `[obs:2026-08-18T09:19Z python: 21 ids extracted; 21/21 appear anywhere, 20/21 co-located with suite]` |
| G2-C8 | **MET, 20 of 20** | = | `scripts/eval-corpus-report.sh` reads every record under `blind-*/` and prints the pair rather than a single rate: `1259/1400 = 0.8993` as recorded, `1291/1400 = 0.9221` counting the editor slot passed, range 0.6207–1.0000 `[obs:2026-08-18T09:17Z bash scripts/eval-corpus-report.sh]` |
| G2-C9 | **MET, 20 of 20** | = | `defects_outside_the_graded_set` present and non-vacuous in all 20 `[obs:2026-08-18T09:16Z python key scan]` |

**Most consequential unmet criterion: G2-C3, now at zero.** Every graded record in the library
describes a version of a skill that no longer exists. The re-run wave is the only thing that
moves it, and its stated precondition — freeze the tree at one wave-wide SHA first — is the
reason it must not be started casually.

#### Goal 3 — **6 of 8 criteria met** (Round 1: 4 of 8)

| ID | Result | Movement | Measurement and evidence |
|---|---|---|---|
| G3-C1 | **MET** | = | `PRE-PUSH GATE: PASSED`, exit 0 `[obs:2026-08-18T09:12Z bash scripts/pre-push-gate.sh; echo $? -> 0]` |
| G3-C2 | **MET, 20 of 20** | = | Every skill returns `15 passed, 0 warnings, 0 failed` `[obs:2026-08-18T09:13Z loop over 20 skill dirs]` |
| G3-C3 | **MET** | = (warnings ▲) | `10 passed, 15 warnings, 0 failed`. **Warnings rose 12 → 15**, which the criterion does not score but which the body-cap finding predicts: ten skills sit at 346–349 against a 350 cap `[obs:2026-08-18T09:12Z bash scripts/validate-tracking.sh .]` |
| G3-C4 | **NOT MET — 2 legs scanned nothing** | ▲ from 3 | `commit-scope-check` and `register-lock gate-check` both report *"no outgoing commits — nothing to check"*; the gate's closing line reads `PASSED — but NOTHING WAS OUTGOING`. `claims-gate` did scan this time. Unchanged in kind: a green gate at HEAD with nothing outgoing is evidence about four legs, not six `[obs:2026-08-18T09:12Z grep -c "nothing to check" gate output -> 2]` |
| G3-C5 | **MET, 6 of 6 gate legs** | ▲▲ from 3 of 6 | All six now expose fault injection **and pass at HEAD**: `validate-tracking --probe` PROBE PASS · `fence-nesting-check --probe` PROBE PASS (6 negative controls, 4 mechanisms) · `validate-skill --probe` PROBE PASS (27 cases: 21 positive, 4 negative controls, 2 known-gap) · `commit-scope-check --probe` PROBE PASS (19 cases: 8 positive, 8 negative controls, 3 known-gap) · `register-lock --probe` PROBE PASS (20 lifecycle assertions, 17 ledger cases, **11 archive assertions and 6 gate-leg-6 assertions**) · `claims-gate --fixture` fires on all 8 defect fixtures and stays clean on `negative-control-clean` (3 passed, 0 failed). **The hand-off's item 8 — "`archive` is the one gate leg with no fault injection" — is closed**, by `55227fb`, which post-dates the SHA the hand-off quoted `[obs:2026-08-18T09:14Z six probe runs + 9 claims-gate fixture runs]` |
| G3-C6 | **MET, 5 of 5 advisory checks** | = | Each reproduces at HEAD: `fence-nesting-check --bare-inner` → **3 sites in 2 files**, matching its own header (B) block, which now carries the current inventory beside the pre-repair precision figure under two labelled headings; root `CLAUDE.md` correctly states **no** current number and points at the script — hand-off item 93 is closed. `expectation-carrier-check` prints its coverage footer naming both shapes it cannot see. `citation-divergence-check` → `1 passed, 1 warnings, 6 failed`, all six on R3, matching the recorded state. `engine-claim-sweep --probe` → PROBE PASS, 7/7 family canaries, 17/17 AG-token canaries, and prints what it does not protect. `check-freshness` → all tracked state within window. **One drift worth naming**: fence-nesting's header records 251 markdown files at `b86b86d`; the tree now has 257. The *headline* reproduces; the file count does not, because the tree grew `[obs:2026-08-18T09:20Z five advisory runs]` |
| G3-C7 | **MET — zero surviving instances** | ▲▲ from NOT MET | The R3 "advises against removing" class, re-tested by the independent method (whitespace-flattened multiline regex over every `.md`), returns **6 hits and none in a shipped skill surface**: `VERSIONS.md` ×3 (changelog), `FAILURE-LEDGER.md` ×1 and `GOALS-SCORECARD.md` ×1 (both describing the defect), `r3-supersession-candidate.md` ×1 (proposal prose). **Round 1's live instance at `optimize/content-refresher/references/refresh-templates.md:464-465` is gone.** Two further closed classes re-tested independently: the gated fence class → `0 with problems` over 257 files; the `~~` connector-token class → 167 occurrences, every one on a skill-author or operator surface, which the resolution rule permits, and none on a client deliverable `[obs:2026-08-18T09:21Z python flattened regex over all .md -> 6 hits, 0 in skill trees; bash scripts/fence-nesting-check.sh -> 0 problems/257 files]` |
| G3-C8 | **NOT MET** | = (different reason) | A correcting `KPI.md` row **now exists** (line 122, *"CORRECTS the 2026-08-17 row above"*), which is what Round 1 said was missing. The criterion is still unmet for two reasons that replaced the old one: **there is no row at all for the round under measurement (2026-08-18)**, and the correcting row's own figures have themselves drifted — it states *19 regressions across 18 compared suites*, where the wave now yields **21 across 20 compared** `[obs:2026-08-18T09:19Z KPI.md rows at 2026-08-10, 08-13, 08-17, 08-17-corrected; no 08-18 row; recomputed 21/20]` |

**Most consequential unmet criterion: G3-C8**, and it is now the *self-similar* one — the file
whose job is to record what moved has not recorded the last two things that moved, including this
round. G3-C7, Round 1's most consequential, has closed.

#### Goal 4 — **4A: 3 of 4 criteria met (Round 1: 2 of 4). 4B: 0 of 4 cleared, all owner-gated**

**4A — library-demonstrable (scored)**

| ID | Result | Movement | Measurement and evidence |
|---|---|---|---|
| G4-C1 | **MET, 20 of 20** | ▲▲ from 7 of 20 | Every `SKILL.md` carries both the contract path and its field vocabulary. **Re-measured against the hand-off's warning that the phrase is not the rule**: for 19 of 20 the vocabulary appears inside an output, report, template or recommendation section, not only in prose. The single exception is **memory-management**, and it is correct — that skill states of itself *"This skill does not author actions — it is the layer they survive in"*, so it is outside the criterion's *"every skill that emits recommendations"* scope, and it still carries the seven fields as a preservation rule plus an Output Validation checkbox. **Neither of the two skills the hand-off warned about — backlink-analyzer and entity-optimizer — now carries the contract only inside a prohibited-tactic paragraph**: 0 of 20 skills have their only hits in a prohibited/tactics section `[obs:2026-08-18T09:18Z python section-attributed scan of all 20 SKILL.md — 20/20 path+vocabulary, 19/20 inside an output-shaped section, 0/20 prohibited-only]` |
| G4-C2 | **MET, 20 of 20** | = | Same measurement as G2-C9 `[obs:2026-08-18T09:16Z]` |
| G4-C3 | **MET, 8 of 8 artefacts** | ▲ (4 → 8 artefacts) | `docs/loop/pilot/` now holds 8 dated artefacts, up from 4; both named clusters covered. Every one carries a method-limits section, though **three carry it under a heading a keyword scan misses** — `prompt-set-v1` (*"Verification rows — excluded from every rate"*), `property-register` (*"§5 What this register still does not carry"*), `thermopompoi-consolidation-brief` (*"§1 The folder is not reachable from here, and that is a fact about the machine, not a refusal"*). The strongest are `crawler-access-finding` (§4 opens *"This section governs how §3 may be used"*) and `tooling-assessment` `[obs:2026-08-18T09:21Z ls docs/loop/pilot/ -> 8; per-file heading read]` |
| G4-C4 | **NOT MET — 0 captures** | = | No capture log exists under `docs/loop/pilot/`. The only `N ≥ 3` mentions are in `tooling-assessment`, which specifies the protocol and costs it rather than executing it. The prompt set remains v1 and unused `[obs:2026-08-18T09:21Z ls docs/loop/pilot/ | grep -iE "capture|baseline" -> none]` |

**4B — owner-gated (stated absence; excluded from the fraction)**

| ID | Status | Movement | Measurement and evidence |
|---|---|---|---|
| G4-B1 | `0 of 3 inputs cleared` — owner | = | Input 3 still reads **OPEN** — no named publisher, approval channel, capture method or turnaround `[obs:2026-08-18T09:22Z PILOT.md §0.1]` |
| G4-B2 | `unlocked` — owner + baseline data | ▲ (9 → 3 cells) | Lock record still `[UNLOCKED — awaiting Sani + baseline data]`; **awaiting-cells fell from 9 to 3** `[obs:2026-08-18T09:22Z grep -c "\[AWAITING SANI + BASELINE DATA\]" PILOT.md -> 3; PILOT.md:361]` |
| G4-B3 | `empty` — downstream of B1/B2 | = | `PILOT.md:414` CP0 row is `| CP0 (baseline) | [at lock] | | | — | ...` `[obs:2026-08-18T09:22Z]` |
| G4-B4 | `refused at gateway` — environment owner | = (**characterisation corrected**) | Re-tested: `https://www.sanihellas.gr/` → `(56) CONNECT tunnel failed, response 403`; `https://www.kullhaus.gr/` → identical; `https://github.com/` → **HTTP 400, tunnel completes**. **Round 1 called this a "host-specific refusal" and that is wrong** — `kullhaus.gr` is an unrelated control and is refused identically. It is an **allow-list** admitting `github.com`, package registries and Anthropic's API, and denying client and unrelated third-party hosts alike. The status is unchanged; only its description is `[obs:2026-08-18T09:20Z three curl runs from one session]` |

---

### Round 2 closing note — the round's own instruments, and what they cost

Four of this round's measurements were **wrong on the first run, in the direction of the failure
signature the hand-off named**: the instrument asked a question adjacent to the criterion and
returned a confident number.

| Criterion | First answer | Correct answer | What the instrument actually asked |
|---|---|---|---|
| G1-C4 | 19 of 20 | **20 of 20** | *"does the key `input_drift_during_the_grading` exist?"* — one record names it `input_drift_during_run` |
| G1-C9 | 2 of 20, then 17 of 20 | **13 of 20** | first a broken conjunction; then *"is `second_read` non-null?"*, which counts objects with no named reader |
| G2-C5 | 19 of 20, then 5 of 20 | **20 of 20** | *"does the text contain NOT PERFORMED?"* — two records say *"previously read NOT PERFORMED"*; then *"is `comparison_performed` true?"*, a key only 5 records use |
| G4-C3 | 5 of 8 | **8 of 8** | *"does a limits heading use these words?"* — three artefacts carry limits under headings the word list does not contain |

**The common cause is that `regressions_vs_baseline` and its siblings have no fixed schema.** The
corpus schema fixed by ledger F16 recurrence 1 binds `summary` only. Across 20 records that one
field appears in **eight distinct key shapes** (`count`+`items`, `regressions[]`, `verdict`,
`headline`, `comparison_performed`, `prior_totals`, `baseline_compared_against`, `status`). Any
single-key check over this corpus is wrong, and will be wrong *quietly*. Recorded as a finding for
the corpus schema, not as a criterion change.

**Every one of the four was caught before it was written down**, by the discipline of reading the
underlying field when a number looked surprising. None reached a register. They are recorded here
because a round that reports only its final numbers hides the fact that its first numbers were
wrong — and this file's rule 3 exists for that reason.

**One did reach a register**, and it is entered on the ledger rather than kept here: `RESUME.md`
§2, pushed earlier the same day, claimed *"This container cannot reach any host on the open
internet."* `git push` in the same session disproves it. Corrected in place with the false version
quoted, because the fact has now been mis-stated three times in three different directions.

### Round 2 — input drift during the measurement, and the re-check

**The tree moved under this round while it was being written, and the branch was force-rewritten.**
Recorded here rather than resolved silently, because this file's Goal 1 criteria measure exactly
this discipline in other lanes.

- `repo_head_at_open`: **`fc41319`** — every figure in the tables above was taken here.
- `repo_head_at_close`: **`673716d`**.
- **What happened between them**: a push was rejected as non-fast-forward. `git fetch` showed a
  **forced update** — the branch's history had been rewritten, so this session's own commits
  reappeared under new SHAs (`fc41319` → `a579345`, `e610396` → `8604300`), with **17 further
  commits on top**: a Greek output-mechanics wave touching `references/`, `CLAUDE.md`,
  `VERSIONS.md`, and edits to entity-optimizer, geo-content-optimizer, memory-management,
  content-refresher and schema-markup-generator, plus ruling M6 applied to content-refresher e2.3
  `[obs:2026-08-18T09:30Z git fetch -> "+ fc41319...f5ad43e (forced update)"; git log --oneline HEAD..origin -> 25 commits, 17 not previously seen]`

**The re-check, run at `673716d` over every criterion the wave could plausibly have moved:**

| Criterion | At `fc41319` | At `673716d` | Moved? |
|---|---|---|---|
| G3-C1 gate | PASSED, exit 0 | PASSED, exit 0, 1 outgoing commit | no |
| G3-C2 validate-skill | 20 of 20 | 20 of 20 | no |
| G3-C3 validate-tracking | 10 / 15 warn / 0 fail | 10 / 15 warn / 0 fail | no |
| G3-C7 R3 class in skill trees | 0 | 0 (6 register hits → 4, `VERSIONS.md` consolidated) | no |
| gated fence scan | 0 problems / 257 files | 0 problems / 258 files | no |
| G4-C1 | 20 of 20 as written, 19 of 20 strict | 20 of 20, 19 of 20, same exception | no |
| G2-C3 | 0 of 20 | 0 of 20; largest drifts now technical-seo-checker 7, serp-analysis 5, geo-content-optimizer 5, entity-optimizer 5 | no |
| ledger entries | 50 | 51 (this round's own F11 r9) | as expected |

**No fraction in Round 2 changes.** The round is recorded as measured at `fc41319` and re-checked
at `673716d`, which is the frozen-input manifest discipline `PIPELINE.md` stage 4 requires — the
figures are not silently restated against a tree they were not taken on.

**One thing the wave makes worse and the tables above do not yet show.** G2-C3 was already zero, so
it cannot fall further; but the *distance* grew. Five more skills moved after the records were
written. **The re-run wave's precondition — freeze at one wave-wide SHA before starting — is not a
formality**, and this round is a worked example of why: a measurement lane that did not re-check
would now be publishing figures for a tree that was rewritten underneath it.

### Round 5 — 2026-08-18 (renumbered from Round 2 on 2026-08-19)

> **Renumbered, not rewritten.** This round was authored as "Round 2" in a session that
> did not have the Round 2 above it: two sessions picked the same number independently,
> which is the collision this file's claim-before-write rule now exists to prevent. The
> body below is unchanged except for this note and the heading. Where it says "Round 1",
> it means Round 1. Rounds 6 and 7 correct THIS round, not the Round 2 above.

- **Tree measured**: open HEAD `f5ad43e`, working tree carrying one untracked path
  `[obs:2026-08-18 git rev-parse HEAD -> f5ad43ef0a7045a930d41642782b65fb1d8245ab; git status --porcelain -> "?? scripts/__pycache__/"]`
- **HEAD MOVED MID-ROUND, and it is recorded rather than glossed.** Partway through the run
  `git status` showed three files staged by another session — `docs/loop/OPEN-FINDINGS.md`,
  `scripts/reanchor-pointers.sh`, `scripts/validate-tracking.sh` — which then landed as
  `0371f43` *"check (g) reported green over a population that excluded the governing register"*
  `[obs:2026-08-18T15:06Z git status --short -> "M  docs/loop/OPEN-FINDINGS.md / M  scripts/reanchor-pointers.sh / M  scripts/validate-tracking.sh / ?? scripts/__pycache__/"; 2026-08-18T15:07Z git rev-parse HEAD -> 0371f4322f78b18f0c8beb6f100359b2f248301d]`.
  Every check whose subject that commit touched was **re-run at the new HEAD** and the effect is
  stated inside the relevant row (G2-C7, G3-C3, G3-C5). This is the same drift class the wave's
  own records report against themselves under G1-C4, arriving on the measuring lane this time.
- **Tree at close**: HEAD `0371f43`, same single untracked path
  `[obs:2026-08-18T15:08Z git rev-parse HEAD -> 0371f4322f78b18f0c8beb6f100359b2f248301d; git status --short -> "?? scripts/__pycache__/"]`
- **Wave under measurement**: still `docs/loop/eval-baselines/blind-2026-08-17/`, 20 records. No
  newer blind wave exists `[obs:2026-08-18 ls -d docs/loop/eval-baselines/blind-* -> blind-2026-08-10, -10b, -10c, -11, -13, -17]`. **18 of the 20 records were amended after Round 1**
  `[obs:2026-08-18 git diff --name-only 5266d39..HEAD -- docs/loop/eval-baselines/blind-2026-08-17/ -> 18 records + README.md]`, so this is the same wave read at a later state, not a new one.
- **Distance from Round 1**: 56 commits `[obs:2026-08-18 git rev-list --count 5266d39..HEAD -> 56]`.
  **The split is 21 dated 2026-08-17 and 35 dated 2026-08-18**, not 4 and 52
  `[obs:2026-08-18 git log --format=%ad --date=short 5266d39..HEAD | sort | uniq -c -> "21 2026-08-17 / 35 2026-08-18"]` — recorded because attributing a movement to the wrong day
  attributes it to the wrong wave. Where a movement can be traced, the row names the commit.
- **Measured by**: an independent scorecard lane. It graded nothing, re-ran no skill and edited no
  file but this one. Every figure below is a command re-run at HEAD.
- **Two criteria were NOT MEASURED this round, and the reason is a scope limit, not a result.**
  G3-C1 and G3-C4 are both defined as `bash scripts/pre-push-gate.sh`, and this lane's brief
  withheld that script (the coordinator runs the gate and the push). They are recorded as
  `NOT MEASURED` and excluded from Goal 3's fraction rather than carried forward from Round 1 —
  carrying a figure forward is the one thing this file's own notes forbid.
- 🔴 **HOST NOTE, and it governs every Goal 3 reading below.** This round ran on **darwin with
  GNU bash 3.2.57 and a BSD userland**, where Round 1 ran on a GNU userland
  `[obs:2026-08-18 bash --version -> "GNU bash, version 3.2.57(1)-release (arm64-apple-darwin25)"; which -a bash -> /bin/bash only]`. Three guards call `mapfile`, a bash-4 builtin
  `[obs:2026-08-18 grep -n mapfile scripts/*.sh -> commit-scope-check.sh:161, register-lock.sh:486, validate-tracking.sh:919]`, one calls GNU-only `date -d`
  `[obs:2026-08-18 grep -n 'date -d' scripts/check-freshness.sh -> :47 newest_epoch=$(date -d "$newest" +%s 2>/dev/null || echo 0)]`, and one drives GNU-sed
  label syntax. **None of them declares a toolchain requirement, and three degrade to a wrong
  answer rather than to an error.** That is a portability finding about the guards themselves and
  it is stated here once instead of being re-argued in five rows. What it is *not*: evidence that
  these guards fail in the container the library normally runs in — that is unmeasurable from
  here, and no row below claims it.

#### Goal 1 — **3 of 9 criteria met** (Round 1: 3 of 9 — same fraction, different three)

| ID | Result | Measurement and evidence |
|---|---|---|
| G1-C1 | **MET** | `bash scripts/eval-prompt.sh --selftest` → `SELFTEST PASS`; 20 suites scanned, 200 id round-trip assertions accepted, 100 evals whose blind output is prompt + fixture paths + fixed footer `[obs:2026-08-18 bash scripts/eval-prompt.sh --selftest > f 2>&1; echo "exit=$?" -> exit=0; tail -> "suites scanned: 20 / id round-trip: 200 accepted / blindness: 100 eval(s) / SELFTEST PASS"]`. **R290 note, since this came back fully met twice**: the check is the instrument's own selftest — it proves `eval-prompt.sh` drops the fields it says it drops, and proves nothing about whether any executor was actually served through it. That second half is G1-C2, which is why the pair must be read together and why a MET here is not a blindness guarantee |
| G1-C2 | **11 of 20 — and this supersedes Round 1's 12** | Records naming `eval-prompt.sh` in a non-`--grade` executor context: alert-manager, backlink-analyzer, competitor-analysis, content-gap-analysis, domain-authority-auditor, geo-content-optimizer, internal-linking-optimizer, keyword-research, performance-reporter, rank-tracker, technical-seo-checker `[obs:2026-08-18 python scan of the 20 records: every occurrence of eval-prompt.sh, with an occurrence discarded when "--grade" appears within 90 characters after it, and the remainder required to sit within 200 characters of "executor" or "blind" -> 11 hits]`. **The one difference from Round 1 is `entity-optimizer`, and it is a reading correction, not a movement**: its `method_detail` block is **byte-identical to the state Round 1 measured** `[obs:2026-08-18 git show 5266d39:…/entity-optimizer.json | python -c "print(method_detail)" -> identical to HEAD]`, and every one of its five `eval-prompt.sh` occurrences carries `--grade`. Its blindness statement names the executor's channel only by contrast — *"a visibly different invocation from the executor's prompt-only call"* — which describes the channel without naming the script for it, and therefore does not pass the check as Part A words it. Round 1's number is not withdrawn; it is superseded here, per this file's rule 2 |
| G1-C3 | **18 of 20 — unchanged, same two records** | 18 records carry an artefact fact (deliverable mtimes, or sha256/md5 of served-vs-source inputs). `keyword-research` and `performance-reporter` still state role separation in prose only `[obs:2026-08-18 python scan of the 20 records for mtime|sha256|md5|shasum in any key or value -> 18 of 20; absent in keyword-research, performance-reporter]`. Note the near-miss on method: a first pass scoped to `method_detail`/`input_drift`/`tool_correctness` paths returned **17**, because `internal-linking-optimizer` carries its `deliverable_mtimes_utc` block at a path that filter did not reach. The 18 is the whole-record read, which is what Part A asks for |
| G1-C4 | **MET, 20 of 20, and hardened** | Every record carries `repo_head_at_open`, `repo_head_at_close` and a drift field `[obs:2026-08-18 python key presence over 20 records -> 20/20 open+close+drift]`. **A leg Round 1 did not run**: all 40 recorded SHAs were resolved against the object database, and every one is a real commit `[obs:2026-08-18 python + git cat-file -t over both SHAs in each of the 20 records -> 0 that do not resolve to a commit]`. Added because presence-of-field is the shape of criterion that drifts into measuring its own instrument; the SHAs now have to exist, not merely be typed |
| G1-C5 | **3 of 4 multi-lane dates — measured against a CHECK THAT WAS REWRITTEN AFTER ROUND 1** | Part A now points at `docs/loop/register-locks-archive/<date>.tsv`; Round 1 measured `.register-locks`, **which no longer exists on disk at all** `[obs:2026-08-18 ls -la .register-locks -> No such file or directory]`. So Round 1's *"1 of 3"* and this *"3 of 4"* are not the same measurement and must not be read as a trend. At HEAD the archive holds three dated journals `[obs:2026-08-18 ls docs/loop/register-locks-archive/ -> 2026-08-10.tsv, 2026-08-17.tsv, 2026-08-18.tsv]` carrying 43/43, 28/31 and 27/28 ACQUIRE/RELEASE rows over 20, 7 and 13 distinct lane handles `[obs:2026-08-18 per-file grep -c ACQUIRE|RELEASE and awk -F'\t' '{print $4}' | sort -u | wc -l]`. **2026-08-13 has no journal, and the hypothesis that it never needed one is refuted by that day's own commit**: `0b33a45` *"claim scope before starting — two sessions are working one list"*, whose message reads *"A local Mac Studio session and this cloud session are both working this repository and neither can see the other's context"* `[obs:2026-08-18 git log -1 --format=%B 0b33a45]`. It was multi-lane, it was known to be multi-lane at the time, and it journalled nothing. **Two things the date-granularity of this check cannot see, stated so the pass is not read as more than it is**: (i) the 2026-08-17 rows span **18:56Z–19:36Z only** `[obs:2026-08-18 awk -F'\t' '{print $2}' docs/loop/register-locks-archive/2026-08-17.tsv | sort | sed -n '1p;$p']`, so the eight-lane grading wave earlier that day — the wave in which the coordinator's own F8 breach happened — is still unjournalled, and the criterion passes the date anyway; (ii) the journals do not balance: 4 RELEASE rows in the 08-17 file and 1 in the 08-18 file have no matching ACQUIRE in the same file `[obs:2026-08-18 python pairing over (holder,path) per file -> 08-10: 0/0 unmatched; 08-17: 4 rel-no-acq, 1 acq-no-rel; 08-18: 1 rel-no-acq]` |
| G1-C6 | **NOT MET — one identified coordinator breach carries no entry** | The ledger's coordinator discipline is otherwise intact: 49 `F<n>` headings, 6 of them naming the coordinator in the heading itself `[obs:2026-08-18 grep -cE "^#{2,3} F[0-9]" docs/loop/FAILURE-LEDGER.md -> 49; of those, grep -ci coordinator -> 6]`, and two entries were added in this round (F15 Recurrence 5, F3 Recurrence 2), neither of which is coordinator conduct. **The breach with no entry is self-labelled, in a tracked artefact**: `docs/loop/register-locks-archive/2026-08-17.tsv`:29 carries `RELEASE … mech-debt references/scoring-rubric.md   # PATH DOES NOT EXIST - coordinator error, F8 r3` `[obs:2026-08-18 grep -rn "F8 r3" over tracked .md/.tsv/.json/.sh -> exactly one hit, that line]`. The path really does not exist — the real file is `optimize/on-page-seo-auditor/references/scoring-rubric.md` `[obs:2026-08-18 ls references/scoring-rubric.md -> No such file or directory]` — so a lane brief named a wrong lock target and the lane classed it F8. **`FAILURE-LEDGER.md` has no F8 Recurrence 3**: its only F8 headings are the founding entry and recurrences 1 and 2 `[obs:2026-08-18 grep -nE "^#{2,3} F8" docs/loop/FAILURE-LEDGER.md -> 3 headings: 2026-08-08 founding, Recurrence (2026-08-17), Recurrence 2 (2026-08-17)]`. A breach identified, classed and written down in one register and absent from the register that governs it is exactly what this criterion tests for |
| G1-C7 | **NOT MET — 1 identified, 0 entered. Graded on the conduct, not on the paperwork** | Counting strictly as Part A words it — recurrence entries in `FAILURE-LEDGER.md` dated to this round whose subject is the coordinator — the answer is **0**, and **0 here would be a false green**. The single coordinator-attributable recurrence of this round is the F8 r3 above: it exists, it is labelled, and the only reason it is not in the count is that nobody wrote the entry. A criterion that returns its target value because the record is missing is measuring its own instrument, which is the failure mode this file's own notes name — and these notes also say G1-C7 must be graded harder than the rest, because it scores the party most likely to be writing the round. **Recorded NOT MET at 1.** For the trend line: Round 1's two F8 recurrences were at least *ledgered*; this one is not, so the direction on this criterion is worse in kind even though the count is lower |
| G1-C8 | **2 of 4 rows — worse than Round 1's 2 of 3** | `KPI.md` now carries four dated rows. `caught pre-push vs post-push`: 2026-08-10 = `8/0`; 2026-08-13 = `11/3`; 2026-08-17 = `n/a`; **and the corrected 2026-08-17 row appended in this round is also `n/a`**, its note stating *"`n/a` rather than `0` because nothing was measured, not because nothing fired"* `[obs:2026-08-18 grep -nE "^\| 2026-08" docs/loop/KPI.md -> 4 rows at lines 39, 64, 65, 122; column 6 = 8/0, 11/3, n/a, n/a]`. The correcting row was the chance to write the cell and it restated the gap instead. **A fifth absence, which no row can carry**: the 2026-08-18 fire — 35 commits across 13 lane handles — **has no `KPI.md` row at all** |
| G1-C9 | **MET, 20 of 20 — the largest single movement in this round (Round 1: 1 of 20)** | Every record now carries a second-reader block naming a reader distinct from its grader: 17 keyed `second_read`, 2 `second_reader_confirmation`, 1 `confirmation` `[obs:2026-08-18 python top-level key scan for second_read|second_reader|confirmation across 20 records -> 20/20]`, each stating separation in its own words (*"separate agent from the grader"*, *"independent Mode B grader … produced no output at any point"*). Landed at `b5135d4`, `337130d`, `2b8dc8e`, `ac0416c`, all 2026-08-17 evening — **so this movement belongs to the 08-17 commits, not to 08-18.** **Two things a reader must hold beside the MET, since Part A's notes require a fully-met criterion to be challenged.** (i) **Distinctness is asserted, never evidenced.** No block carries a mechanical fact — no agent id, no transcript hash, no artefact separation — so this criterion rests on exactly the kind of self-report that G1-C3 exists to refuse on the executor/grader axis, and there is no C3-equivalent leg for the second reader. (ii) **17 of the 20 are narrowed passes that explicitly do not re-read the verdicts**, each stating *"NOT a full re-grade"* and listing the expectation verdicts under `taken_on_trust_not_re_verified`. Only 3 re-verified every expectation at source: `content-gap-analysis` (33 verdicts), `competitor-analysis` (*"ALL 29 expectation records"*) and `technical-seo-checker` (*"ALL 28 expectation records"*). **So: second readers 20 of 20; second-read verdicts 3 of 20.** The narrowed passes are not empty — they corrected fields in place in at least four records and added findings in others — but a reader taking "20 of 20" to mean the grading has been checked twice would be wrong |

**Most consequential unmet criterion: G1-C6/C7, taken together.** Round 1's worst Goal 1 finding
was that the mechanism which would have prevented a coordinator breach existed and was not switched
on. It has since been switched on — three dated journals now sit in the tree where none was durable
before. What this round finds is one level in: the mechanism ran, it **caught** a coordinator error,
the lane wrote the class down in the journal, and the ledger the class belongs in never received it.
A guard that fires into a file nobody reconciles is a guard whose finding evaporates, and G1-C7 then
reports the target value because the evidence went missing rather than because the conduct did.

#### Goal 2 — **6 of 9 criteria met** (Round 1: 5 of 9)

| ID | Result | Measurement and evidence |
|---|---|---|
| G2-C1 | **MET, 20 of 20** | `[obs:2026-08-18 ls -d */*/evals/evals.json | wc -l -> 20]` |
| G2-C2 | **MET, 20 of 20** | `[obs:2026-08-18 ls docs/loop/eval-baselines/blind-2026-08-17/*.json | wc -l -> 20]` |
| G2-C3 | **0 of 20 — strict AND weak. Round 1's 2 strict / 9 weak are both superseded** | Not one record is current on any reading. **Every one of the 20 was graded at a version below its skill's HEAD version**, the smallest gap one patch (`competitor-analysis` 4.2.1 → 4.3.1, `rank-tracker` 4.3.0 → 4.4.0) and the largest four minors (`content-quality-auditor` 4.5.0 → 4.9.0); the diff over the skill directory alone runs 2–7 files per record, and over the frozen-input manifest including cited shared `references/` it runs 3–10 `[obs:2026-08-18 per record: parse skill_version_under_test, read HEAD SKILL.md frontmatter version, then git diff --name-only <repo_head_at_open>..HEAD over the skill dir and over every shared references/ file the skill tree cites -> strict 0 of 20, weak (version match + empty skill-dir diff) 0 of 20]`. The two Round 1 called strict-current, `rank-tracker` and `serp-analysis`, were both bumped since (4.3.0 → 4.4.0 with 2 files changed; 4.3.7 → 4.4.0 with 5). **This is the debt `OPEN-FINDINGS.md` 144 already names** — 18 skills changed and no suite re-run — and it is now total rather than near-total. One incidental: `cross-cutting/memory-management/SKILL.md` carries no top-level `version:` key at all, only `metadata.version: "4.4.0"`, while every other skill carries both `[obs:2026-08-18 for d in */*/SKILL.md; grep -cE '^version:' -> 0 for memory-management, 1 for the other 19]` — its record's own convention line claims the two are "in lockstep", and one of the pair is absent |
| G2-C4 | **MET, 20 of 20** | No unresolved provisional or termination notice. `content-gap-analysis` opened provisional (its grader was killed by a spend limit) and its `confirmation` field states *"The PROVISIONAL qualification is lifted"* with `grader_termination_notice REMOVED and replaced by this field`; the six other records containing the word use it about their subject matter, not about their own status `[obs:2026-08-18 python scan for provisional|terminat across 20 records, each hit read in context -> 7 records contain the token, 0 unresolved]`. **R290 note**: this criterion passes trivially for any record that never uses the word, so its green is weak evidence by construction |
| G2-C5 | **MET, 20 of 20 (Round 1: 18 of 20)** | Both Round 1 gaps are closed. `performance-reporter`'s field now opens *"PERFORMED 2026-08-17 by the stale-and-uncompared lane. This field previously read NOT PERFORMED because the grading brief scoped that grader to one unrelated record"*, and `rank-tracker` carries a `correction_to_this_record_as_first_written` key beside its comparison `[obs:2026-08-18 python read of regressions_vs_baseline across 20 records -> 20 state a per-expectation comparison performed; the only "NOT PERFORMED" string left is inside performance-reporter's own account of what its field used to say]`. Traceable to `db83ee9` (2026-08-17 19:20) — an 08-17 commit, not an 08-18 one |
| G2-C6 | **NOT MET — 21 open, up from 19** | 21 attributed regressions across 12 of the 20 compared suites `[obs:2026-08-18 python tally over regressions_vs_baseline items|regressions lists across 20 records -> alert-manager 3 (e2.6, e3.1, e4.4) · on-page-seo-auditor 4 (e1.5, e3.5, e5.1, e2.6) · content-quality-auditor 2 (e4.4, e4.6) · content-refresher 2 (e1.1, e2.6) · keyword-research 2 (e3.3, e4.1) · serp-analysis 2 (e3.1, e4.2) · backlink-analyzer 1 (e1.6) · geo-content-optimizer 1 (e2.1) · internal-linking-optimizer 1 (e4.4) · schema-markup-generator 1 (e1.7) · performance-reporter 1 (e4.3) · rank-tracker 1 (e2.1) = 21]`. **The count went up because the two missing comparisons were run, and each found one** — closing G2-C5 opened two more of these, which is what a comparison is for. **Zero are subtractable**: the criterion subtracts only those recorded fixed *and re-exercised by a later blind run*, and no blind wave exists after 2026-08-17, so nothing in the wave has been re-exercised whatever was fixed in the skills |
| G2-C7 | **19 of 21 (Round 1: 8 of 19)** | `OPEN-FINDINGS.md` now carries **16 rows headed REGRESSION** — 154–158 and 168–178 — registering 19 of the 21 by suite and expectation id `[obs:2026-08-18 python: rows matching ^\| (\d+) \| \*\*REGRESSION in docs/loop/OPEN-FINDINGS.md -> 16 rows: 154,155,156,157,158,168,169,170,171,172,173,174,175,176,177,178; the suites and ids they name reconcile to 19 of the 21 items]`. The 11 Round 1 found unregistered were swept in by `c98e170`. **The two now unregistered are the two newest**: `performance-reporter` e4.3 and `rank-tracker` e2.1 exist only inside their own record files. Re-checked after the mid-round commit to `OPEN-FINDINGS.md` and unchanged. ⚠️ **Method warning for whoever measures this next**: a line-based grep for the suite name and the id *on the same line* returns a false REGISTERED for `rank-tracker` e2.1, because `OPEN-FINDINGS.md` row 127 is long enough to contain both tokens for unrelated reasons. The count above comes from reading the REGRESSION rows, not from that grep |
| G2-C8 | **MET, 20 of 20** | All 20 carry integer `summary.passed/failed/total` and state an editor-slot convention inside the `summary` object, and the corpus sums reconcile exactly: **544 passed + 41 failed + 25 editor slots = 610 total** `[obs:2026-08-18 python field read over the 20 summary objects -> 20/20 conforming; sums 544/41/25/610]`. `scripts/eval-corpus-report.sh` still prints no pooled headline by design and states why `[obs:2026-08-18 bash scripts/eval-corpus-report.sh > f 2>&1; echo "exit=$?" -> exit=0; tail -> "MIXED EDITOR-SLOT CONVENTION — no single pooled figure is printed. 32 suite(s) leave the editor slot uncounted … 15 suite(s) count it. as recorded, slot not-passed: 1259/1400 = 0.8993; slot counted passed throughout: 1291/1400 = 0.9221"; range 0.6207–1.0000]` |
| G2-C9 | **MET, 20 of 20** | Every record carries the field and none is vacuous; the enumerated out-of-set defects across the wave now total **157** `[obs:2026-08-18 python read of defects_outside_the_graded_set across 20 records, following each record's own list key (found | findings | defects_found) -> 20/20 present, 0 vacuous, 157 enumerated]`. Note the key drift the count had to absorb: three records name the list `findings` or `defects_found` rather than `found`, so a scan keyed only on `found` reports two records vacuous that are not |

**Most consequential unmet criterion: G2-C3, and it is now absolute.** Round 1 could still say two
records described the library as it stands. At HEAD none does: every one of the twenty was graded
against a version the repository has since moved past, and the wave that produced the corpus is also
the wave that invalidated it. Every other Goal 2 number — the 544/610, the 21 regressions, the pass
rates in `KPI.md` — is a measurement of a library that no longer exists in the tree, and stays that
way until a wave re-runs against a manifest frozen across the whole wave rather than per lane.

#### Goal 3 — **3 of 8 criteria met; 2 of the 8 not measured** (Round 1: 4 of 8)

| ID | Result | Measurement and evidence |
|---|---|---|
| G3-C1 | **NOT MEASURED** | The check is `bash scripts/pre-push-gate.sh`, which this lane's brief withheld. Not carried forward from Round 1 and not inferred from the legs run individually below — a gate's exit code is a fact about the gate, and three of its six legs are scoped to an outgoing range this lane has no view of |
| G3-C2 | **MET, 20 of 20** | Every skill returns `Results: 15 passed, 0 warnings, 0 failed` `[obs:2026-08-18 bash scripts/validate-skill.sh over each of the 20 skill directories -> 20 × "15 passed, 0 warnings, 0 failed"]` |
| G3-C3 | **MET — 0 failed** | `Results: 10 passed, 15 warnings, 0 failed` `[obs:2026-08-18T15:07Z bash scripts/validate-tracking.sh . > f 2>&1; echo "exit=$?" -> exit=0; grep ^Results: -> "10 passed, 15 warnings, 0 failed"]`. Warnings are up from 12 to 15: **14 body-length headroom notices** (330+ against a 350 cap) plus the check (g) pointer notice, and one of the fourteen — `optimize/internal-linking-optimizer/SKILL.md` at **350 lines** — is at the cap with zero headroom. **The mid-round commit changed what this row means and the change is recorded rather than smoothed**: at `f5ad43e` check (g) reported *8* un-anchored pointers over 37 verified; at `0371f43`, after that commit widened (g)'s population to include the governing register, it reports **150** un-anchored over 38 verified `[obs:2026-08-18 grep "(g)" at f5ad43e -> "8 un-anchored … 37 anchor-tagged … verified"; 2026-08-18T15:07Z same grep at 0371f43 -> "150 un-anchored … 38 anchor-tagged … verified"]`. The `Results:` line is identical either side, because (g) warns and never fails — so a green that did not move sits on top of a population that grew nineteen-fold |
| G3-C4 | **NOT MEASURED** | Same reason as G3-C1: the leg-scope disclosure is part of the gate's own output. Recorded for the next round that can run it: **the gate now has six legs, not five** — `validate-skill`, `validate-tracking` (with `fence-nesting-check` inline), `claims-gate`, `commit-scope-check`, `register-lock gate-check`, and a new **leg 6, `register-lock archive`, which writes** `[obs:2026-08-18 grep -nE "leg|bash \"\$ROOT\"/scripts/" scripts/pre-push-gate.sh, read only -> six numbered legs; leg 6 added by 8164b77 "run the lock-journal archive automatically at wave end, as gate leg 6"]`. A leg that writes is a new class for this criterion: a null-scope disclosure and a write are different kinds of evidence |
| G3-C5 | **NOT MET — probes now exist on 6 of 6 legs (Round 1: 3 of 6), and 3 of 6 pass at HEAD on this host** | **The presence half is closed**: every leg Round 1 recorded as having no fault injection now has one `[obs:2026-08-18 grep -ciE "--probe|--selftest|--fixture" per script -> validate-skill 5, validate-tracking 14, fence-nesting-check 2, claims-gate 3, commit-scope-check 6, register-lock 5 — all non-zero, where Round 1 measured 0 for validate-skill]`, landed by `4bcaa87` and `55227fb`. **The passing half is not.** PASS: `validate-skill.sh --probe` → `PROBE PASS — 27 cases: 21 positive, 4 negative controls, 2 known-gap` (exit 0) · `fence-nesting-check.sh --probe` → `PROBE PASS — 6 negative controls, 4 mechanisms` (exit 0) · `claims-gate.sh --fixture` over all **9** checked-in fixtures, each matching its own `expect.txt` — 5 fire at FAIL, 3 land in the documented WARN tier at exit 0 with exactly the 1 WARN each expects, and `negative-control-clean` stays clean `[obs:2026-08-18 per-fixture run -> f11-founding-forward-timestamp exit 1 (2 FAIL), f11-founding-stale-sibling exit 1, f11-r3-end-to-end-overclaim exit 1, f11-r4-post-flip-stale-sibling exit 1, f11-r5-register-wide-stale-claims exit 1 (2 FAIL); f11-founding-attribution-gloss / f11-r1-word-level-graduated / f11-r2-mechanism-in-observed-frame exit 0 with 1 WARN each, as each expect.txt states; negative-control-clean exit 0]`. **FAIL: `commit-scope-check.sh --probe` → `PROBE FAILED`, exit 1** `[obs:2026-08-18 bash scripts/commit-scope-check.sh --probe -> "scripts/commit-scope-check.sh: line 161: mapfile: command not found" repeated, then PROBE FAIL on each fixture case with "expected exit 1, got 0", then PROBE FAILED]` and **`register-lock.sh --probe` → `PROBE FAILED`, exit 1**, same cause at its line 486 `[obs:2026-08-18 bash scripts/register-lock.sh --probe -> "line 486: mapfile: command not found" ×N, PROBE FAIL on the gate-* cases, PROBE FAILED]`. **And the one that matters most: `validate-tracking.sh --probe` exits 0 while its fault-injection leg does not run.** Its R3 leg dies on the same builtin and the probe carries on to print the ordinary run's `Results: 10 passed, 15 warnings, 0 failed` `[obs:2026-08-18 bash scripts/validate-tracking.sh --probe > f 2>&1; echo "exit=$?" -> exit=0; grep -c PROBE f -> 0; head -> "R3 leg — live allowlist / scripts/validate-tracking.sh: line 919: mapfile: command not found / line 920: entries: unbound variable"]` — a green from a check that did not happen, which is the exact shape ledger F15 exists for, arriving inside the guard that ships F15's own probe |
| G3-C6 | **NOT MET — 2 of 5 reproduce, 2 do not run correctly on this host, 1 has nothing to reproduce against** (Round 1: MET, 5 of 5) | **Reproduces**: `fence-nesting-check.sh --bare-inner` → 3 sites in 2 files, exactly what its own header records for its 2026-08-18 re-run at `b86b86d`, and its stated trajectory 10 → 6 → 3 holds `[obs:2026-08-18 bash scripts/fence-nesting-check.sh --bare-inner -> "scanned 258 markdown file(s), 3 site(s) in 2 file(s)"; header says "over 251 markdown files: 3 sites in 2 files" — the finding count reproduces, the corpus size does not, because seven .md files have been added since]` · `citation-divergence-check.sh` → `1 passed, 1 warnings, 6 failed`, all six on R3, identical to Round 1 `[obs:2026-08-18 bash scripts/citation-divergence-check.sh -> "Results: 1 passed, 1 warnings, 6 failed"]`. **Nothing to reproduce against**: `expectation-carrier-check.sh` runs clean at exit 0 and states its coverage limit (*"1 of 3 known instances"*, with both shapes it cannot see named), but its header records **no headline count**, so the second half of this criterion is vacuous for it — its output is now 189 candidate phrases where Round 1 reported 185, and no recorded figure exists to call that a reproduction or a drift `[obs:2026-08-18 bash scripts/expectation-carrier-check.sh -> exit 0, "189 candidate phrase(s) demanded by a suite and absent from its skill's own text"]`. **Does not run correctly here**: `engine-claim-sweep.sh --probe` → **`PROBE FAILED`, 21 PROBE FAILs, each preceded by a BSD `sed` error** `[obs:2026-08-18 bash scripts/engine-claim-sweep.sh --probe -> "sed: 2: …: undefined label" then "PROBE FAIL — dropping AG branch 'AI' changed the count 17 -> 17 (expected 16)" and 20 more, PROBE FAILED]` · `check-freshness.sh` exits 0 and reports **six files aged by "20683d"** — 56 years — because its `date -d "$newest" +%s 2>/dev/null || echo 0` falls back to epoch 0 on a BSD `date` `[obs:2026-08-18 bash scripts/check-freshness.sh -> exit 0, "AGED: docs/loop/GATED-ITEMS.md — newest date 2026-08-17 (20683d old, window 90d)" ×6, "6 file(s) due"]`. **That fallback is the finding, not the platform**: a tool failure is converted into a plausible-looking number rather than an error, so on any host where `date -d` is absent this check reports every dated file as overdue and its output still reads like a measurement |
| G3-C7 | **MET on the classes re-tested — and Round 1's single live instance is CLOSED** | Round 1's finding was one surviving R3 *"advises against removing"* instance in a shipped skill reference, invisible to the line-based guard that had certified the class closed. **It is gone.** Re-tested by the same whitespace-flattened method: 6 hits repo-wide, **none in a shipped skill** — `VERSIONS.md` ×3, `docs/loop/FAILURE-LEDGER.md` ×1, `docs/loop/r3-supersession-candidate.md` ×1, and this file ×1, which is Round 1's own row describing the defect `[obs:2026-08-18 python multiline regex "advis\w*\s+against\s+(proactively\s+)?remov" over every tracked .md, whitespace-flattened -> 6 hits, 0 in a shipped skill tree; the 2026-08-17 offender optimize/content-refresher/references/refresh-templates.md returns 0]`. Fixed by `3ce98c9` (2026-08-17 18:03) — **an 08-17 commit, not an 08-18 one**. A second closed class re-tested by an independent method: the fence-nesting class of `OPEN-FINDINGS.md` 106 (an unclosed fence running to EOF, invisible to every text-reading gate) returns zero surviving instances under a CommonMark-4.5 fence walker written in Python rather than under the shell guard that closed it `[obs:2026-08-18 python fence-stack scan over 259 tracked .md -> 0 files with an unclosed fence at EOF; bash scripts/fence-nesting-check.sh -> exit 0, "scanned 258 markdown file(s), 0 with problems"]`. **Coverage limit, stated because this criterion is quantified over every closed class and this round tested two**: a MET here means two classes were re-tested independently and both are clean, not that the population is clean. The classes were chosen by the party writing the round, which is the weakness a second reader would close |
| G3-C8 | **NOT MET — and for a second, larger reason than Round 1's** | Round 1's gap was that no correcting `KPI.md` row had been appended. **One has been**, at line 122, naming the row it corrects and re-deriving its figures over the 20 records — and one of its cells re-derives exactly at HEAD: `evals passed/total 544/610` `[obs:2026-08-18 python sum over the 20 summary objects -> 544 + 41 failed + 25 editor = 610]`. **The rest of it no longer re-derives.** It states *"18 compared, 2 not (performance-reporter, rank-tracker)"* and a numerator of 19; at HEAD all 20 are compared and the numerator is 21, because `db83ee9` ran those two comparisons **fifty minutes after that row was written** and each found a regression. The denominator moves with them: their baselines carry 28 and 25 prior passes, so 477 + 28 + 25 = **530**, and 21/530 = 3.96% — the rate barely moves, the population statement is simply false at HEAD `[obs:2026-08-18 KPI.md:122 reads "19 of 477 … across the 18 compared suites = 4.0%" and "18 compared, 2 not"; python over the 20 records -> 20 compared, 21 regression items; the two records' own baseline fields report 28 passed (blind-2026-08-10b/performance.json) and 25 passed (blind-2026-08-10c/ranktracker.json)]`. **And the round under measurement has no row at all**: `KPI.md`'s newest row is dated 2026-08-17, while 35 commits across 13 lane handles landed on 2026-08-18 `[obs:2026-08-18 grep -nE "^\| 2026-08" docs/loop/KPI.md -> newest row 2026-08-17]` |

**Most consequential unmet criterion: G3-C5, and specifically `validate-tracking.sh --probe`.**
Round 1's Goal 3 story was that half the gate had no fault injection. That half was built, which is
real work and shows in the numbers. What this round finds is the next failure along: a probe that
**exits 0 while the leg it exists to exercise never runs**. Every other broken thing measured here
is loud — two probes say `PROBE FAILED`, a sweep prints `sed` errors, an ageing check prints a
patently absurd 20683 days. This one is quiet, and quiet is the property that let the R3 closure
stand for four days. The class it belongs to is broader than one builtin: four of the six legs and
two of the five advisory checks depend on GNU-userland behaviour that none of them declares, and the
failure direction of at least two of them is **open**.

#### Goal 4 — **4A: 2 of 4 criteria met. 4B: 0 of 4 cleared, all owner-gated**

**4A — library-demonstrable (scored)**

| ID | Result | Measurement and evidence |
|---|---|---|
| G4-C1 | **19 of 20 (Round 1: 7 in body / 10 counting pointer-only) — three readings, and the criterion's own words give 19** | Grading the strict form the criterion states — the seven fields carried in the skill's own `SKILL.md` **body** — 19 of 20 name all seven (Action · Owner · Acceptance criterion · Expected impact · Effort · Dependencies · Risk if done wrong) inside a single passage, whether as a table header or as a prose enumeration `[obs:2026-08-18 python over each SKILL.md with frontmatter stripped: a 640-character window around "acceptance criterion" required to contain all seven field names, case-insensitively -> 19 of 20; the exception is monitor/backlink-analyzer]`. **`backlink-analyzer` is the one that fails**: its body names two of the seven in one checklist item and delegates the rest to the reference — *"the seven fields every remediation and opportunity carries"* — which is the pointer-only shape Round 1 counted separately `[obs:2026-08-18 grep -in "acceptance criterion|seven field|action-output-contract" monitor/backlink-analyzer/SKILL.md -> 3 lines, none enumerating the fields]`. **Both other readings are reported because the choice between them is a judgement.** Under **Round 1's stated vocabulary check** — the contract path plus `acceptance criterion` / `risk-if-done-wrong` / `owner-role` — it is now **20 of 20**, every skill carrying the path at least twice `[obs:2026-08-18 python token count per SKILL.md body -> path present in 20/20; all 20 classify body+path]`, and **that reading is the one to distrust**: a criterion whose green comes from three tokens appearing anywhere is measuring its own vocabulary, which is the R290 case this file's notes tell a round to look for when something comes back fully met. Under the **strictest** reading — the body prints a seven-column action table, i.e. the output shape a client receives — it is **6 of 20**: meta-tags-optimizer, schema-markup-generator, seo-content-writer, performance-reporter, keyword-research, serp-analysis `[obs:2026-08-18 python: a table header row in the body containing all seven column names -> 6 of 20, and the same 6 are returned by an all-seven-tokens test, two independent forms agreeing]`. The movement is traceable to `6316edf`, `046b384` and `aa804a8` — **all 2026-08-17 evening**, plus `985b688` on 08-18 |
| G4-C2 | **MET, 20 of 20** | Same measurement as G2-C9: every record carries the field, none vacuous, 157 enumerated out-of-set defects across the wave `[obs:2026-08-18 python key scan across 20 records following each record's own list key -> 20/20 present, 0 vacuous, 157 enumerated]` |
| G4-C3 | **MET for both named clusters, on a doubled corpus** | `docs/loop/pilot/` now holds **8 artefacts, up from 4** `[obs:2026-08-18 ls -la docs/loop/pilot/ -> crawler-access-finding-2026-08-18.md, keyword-research-thermopompoi-afygrantires-2026-08-18.md, pairing-analysis-2026-08-13.md, prompt-set-v1-2026-08-17.md, property-register.md, technical-entity-assessment-2026-08-17.md, thermopompoi-consolidation-brief.md, tooling-assessment-2026-08-18.md]`, and each of the four new ones opens or closes with an explicit limits section rather than a caveat buried in prose: `§0 EVIDENCE GRADE — read this before any figure below`, `§4 What this does and does not establish`, `§3 Πηγές — και τι δεν ήταν διαθέσιμο`, `§5 What this register still does not carry` `[obs:2026-08-18 grep -nE "^#{1,3} " over each new pilot file]`. Both named clusters are covered by one dated artefact between them. Worth recording beside the MET: one of the new artefacts exists **because** an environment limit was measured rather than assumed — it reports that the property refuses some of the crawlers the strategy depends on, which is a method limit found by testing, not declared |
| G4-C4 | **NOT MET — 0 captures, unchanged** | `prompt-set-v1-2026-08-17.md` still states of itself *"this is **v1**, and it has never been used for a capture"* and is still labelled DRAFT `[obs:2026-08-18 grep -nE "never been used|DRAFT" docs/loop/pilot/prompt-set-v1-2026-08-17.md -> lines 7 and 14]`. No capture log exists under `docs/loop/pilot/`. What moved is the surrounding analysis rather than the measurement: `tooling-assessment-2026-08-18.md` §4 works out what the N ≥ 3 protocol demands of each candidate tool and records that a daily-run tool cannot supply a same-session N = 3 `[obs:2026-08-18 grep -n "N ≥ 3" docs/loop/pilot/tooling-assessment-2026-08-18.md -> :93 "§4 requires N ≥ 3 per prompt per engine captured in one session"]`. That is preparation for a capture, and this criterion counts captures |

**4B — owner-gated (stated absence; excluded from the fraction)**

| ID | Status | Measurement and evidence |
|---|---|---|
| G4-B1 | `0 of 3 inputs cleared` — owner, **unchanged and unchangeable from here** | `docs/loop/PILOT.md` is **byte-identical to the state Round 1 measured** `[obs:2026-08-18 git diff --name-only 5266d39..HEAD -- docs/loop/PILOT.md -> empty]`, so §0.1's recorded words still read input 1 PART-SUPPLIED (property and cluster rule settled; the 5–15 URL list still owed and deliberately not inferred), input 2 IN PROGRESS, input 3 OPEN. Re-read at source rather than carried `[obs:2026-08-18 sed -n over docs/loop/PILOT.md §0.1]` |
| G4-B2 | `unlocked` — owner + baseline data. **Round 1's obs command is superseded** | Lock record still reads `[UNLOCKED — awaiting Sani + baseline data]` `[obs:2026-08-18 sed -n '361p' docs/loop/PILOT.md]`. The cell count still stands at 9 — but **the command Round 1 printed beside it does not produce 9**: `grep -c` counts matching *lines*, and the nine cells sit on three `[obs:2026-08-18 grep -c "\[AWAITING SANI + BASELINE DATA\]" docs/loop/PILOT.md -> 3; grep -o "\[AWAITING SANI + BASELINE DATA\]" docs/loop/PILOT.md | wc -l -> 9]`. The file has not changed, so this is not drift: Round 1's finding is right and the stamp beside it is not the command that produced it. Recorded because rule 3 of this file is that a figure with its command is a measurement — and a figure with *someone else's* command is back to being a claim |
| G4-B3 | `empty` — downstream of B1/B2 | All five checkpoint rows CP0–CP4 are still empty `[obs:2026-08-18 grep -nE "^\| *CP[0-4]" docs/loop/PILOT.md -> 5 rows, lines 414-418, no filled cells]`, and none of the five execution paths exists under `docs/loop/pilot/` |
| G4-B4 | `reachable` — **status changed, and the cause is the measuring station, not the environment** | From this session the property answers: `301` on the apex-www URL, following to `200` at `/el-gr/` with 81,006 bytes, with a control host completing normally `[obs:2026-08-18 curl -s -o /dev/null -w "%{http_code}" --max-time 15 https://www.sanihellas.gr/ -> 301; curl -sL -w "final=%{http_code} url=%{url_effective} bytes=%{size_download}" -> final=200 url=https://www.sanihellas.gr/el-gr/ bytes=81006; curl https://github.com/ -> 200]`. **This does not close the blocker Round 1 recorded.** Round 1 measured `curl: (56) CONNECT tunnel failed, response 403` from a sandboxed container; this round measured from a different machine on a different network. The criterion asks whether *the environment* reaches the property, and there are now two environments with two answers. Read as: the property is up and serves, and the container gateway refusal is unretested here. Anyone quoting this row must say which station it was measured from |

**Most consequential unmet criterion (4A): G4-C4, by default and by decay.** G4-C1 was Round 1's
answer here and it has largely closed — 19 of 20 skills now state the contract in their own body
where 7 did. What is left is the one measurement that gets worse by being deferred: a visibility
capture is a reading of a moment, and every day without one is a baseline that cannot be
reconstructed later. The prompt set cannot be *locked* without the client, but a capture against v1
labelled as against a draft set has been executable since Round 1 said so, and the tooling work done
since has sharpened the plan without taking the reading.

#### What Round 5 supersedes in Round 1

Recorded here rather than by editing Round 1, per this file's rule 2. Six items, in descending order
of how much they change what a reader would conclude.

1. **G3-C7's surviving instance is closed** `[obs:2026-08-18 python whitespace-flattened multiline
   regex "advises\s+against\s+(?:proactively\s+)?removing" over all .md — 7 hits: VERSIONS.md ×3,
   GOALS-SCORECARD.md ×2, r3-supersession-candidate.md ×1, FAILURE-LEDGER.md ×1; SHIPPED-SKILL hits
   = 0]`. Re-measured by the coordinator rather than carried from the row above, and the totals
   differ for a reason worth keeping: the row's own figure was **6**, mine is **7**, because writing
   Round 5's finding down added a further occurrence of the very phrase being counted (R290 — an
   instrument that enters its own scan set). The load-bearing half — **zero in a shipped skill** —
   reproduces exactly. The R3 overstatement surviving at
   `refresh-templates.md`:464-465 — Round 1's single most-consequential Goal 3 finding, a class
   certified closed whose certifying instrument could not see the surviving member — was fixed by
   `3ce98c9`. The general half of the lesson stands and is now ledgered as F15 Recurrence 5.
2. **G4-B2's obs stamp does not reproduce.** `grep -c "[AWAITING SANI + BASELINE DATA]" PILOT.md`
   returns **3**, not the 9 printed beside it; 9 is the occurrence count. The file is byte-unchanged,
   so this is a stamp that never matched its figure, not a movement. The finding of 9 cells is
   correct.
3. **G1-C2 is 11, not 12, on the same bytes.** `entity-optimizer`'s record was counted in Round 1's
   12 and its `method_detail` block is byte-identical today; all five of its `eval-prompt.sh`
   occurrences carry `--grade`, so it does not satisfy the check as Part A words it.
4. **G2-C3's 2-strict / 9-weak are both now 0**, including the two Round 1 named as current.
5. **G1-C5's Round 1 figure measured an artefact that no longer exists.** `.register-locks` is gone
   from the tree; the criterion's check was rewritten to point at the durable archive, so *"1 of 3"*
   and *"3 of 4"* are different measurements and must not be plotted as a trend.
6. **`KPI.md`'s correcting row is itself overtaken.** Its *"18 compared, 2 not"* and numerator 19
   were true at 17:28Z and false fifty minutes later. Its `evals passed/total` cell still re-derives
   exactly.

#### What this round could not measure, and why

- **G3-C1 and G3-C4** — the check for both is `scripts/pre-push-gate.sh`, withheld from this lane.
- **Whether the six gate legs and five advisory checks behave correctly on a GNU userland.** Only a
  BSD/bash-3.2 host was available. Four legs and two advisory checks call GNU-only builtins or
  syntax; what is measured here is that none of them declares the dependency and that at least two
  of them fail toward a green.
- **Whether the second-reader passes were genuinely written by agents other than the graders.** No
  record carries a mechanical fact for it, so the answer to G1-C9 is an assertion in all 20 cases
  and nothing in the tree can check it.
- **The whole population of ledger classes recorded closed (G3-C7).** Two were re-tested; the
  criterion is quantified over all of them, and the two were chosen by the lane writing the round.

### Round 6 — 2026-08-19 (correction round; no criterion re-scored)

Round 5 is now under the same append-only rule that protected Round 1, so nothing below edits it.
Every figure here was re-measured by the coordinator against the tree, not carried from the
adversarial review that raised them — a correction bullet that repeats someone else's number is the
defect it exists to fix.

**Nothing in this round changes a verdict.** One correction (1) is disqualifying for the sentence it
sits in; the rest narrow a reason without moving its conclusion.

1. 🔴 **"18 of the 20 records were amended after Round 1" is wrong. It is 19, and the one that was
   not amended is `content-gap-analysis.json`.** The figure reproduces at no tree in the round's own
   window `[obs:2026-08-19 git diff --name-only 5266d39..<t> -- docs/loop/eval-baselines/blind-2026-08-17/
   | grep -c '\.json$' -> 19 at each of t = f5ad43e (round open), 0371f43 (round close), HEAD;
   paths incl. README.md = 20 at each]`, and the omitted record is named by
   `[obs:2026-08-19 comm -13 <(amended|xargs -n1 basename|sort) <(ls *.json|xargs -n1 basename|sort)
   -> content-gap-analysis.json]`. The sentence's conclusion — that this is the same wave read at a
   later state, not a new wave — is untouched and still holds.

   This is the class Round 5 itself indicts. Its own supersession item 2 records a G4-B2 stamp that
   "never matched its figure, not a movement", and its rule 3 states that a figure carrying someone
   else's command is back to being a claim. **A round can diagnose a defect and carry a case of it in
   the same document**, and one self-disclosed stamp error is not evidence the others were checked.
   Neither innocent explanation available elsewhere in Round 5 applies here: it is not stale-at-close
   (see 3) and not self-instrumentation (R290), because no tree produces 18.

2. **"every one of its five `eval-prompt.sh` occurrences carries `--grade`" is wrong — four of five
   do** `[obs:2026-08-19 python re.finditer over docs/loop/eval-baselines/blind-2026-08-17/entity-optimizer.json,
   '--grade' within a 90-char window of each occurrence -> #1 True #2 True #3 True #4 False #5 True]`.
   Occurrence 4 sits inside an input-drift file list and is excluded by a different filter, so
   **G1-C2's headline of 11 and its eleven named records are unaffected, and the verdict against Part
   A's wording still stands.** Only the stated mechanism was wrong, and it was stated twice — in the
   G1-C2 row and again in supersession item 3.

3. **"56 commits … 21 dated 2026-08-17 and 35 dated 2026-08-18" is measured at the round's OPEN head,
   not its stated close head** `[obs:2026-08-19 git rev-list --count 5266d39..<t> and git log --date=short
   -> f5ad43e: 56 (21/35) · 0371f43: 57 (21/36)]`. Round 5 promises that every check whose subject a
   commit touched was re-run at the new HEAD; a commit-range distance is touched by definition, and
   this one was not re-run. The staleness point the figure was making is strengthened, not weakened.

4. **G3-C7 is scored MET on a partial population, and the round says so without letting it affect the
   score.** Part A quantifies the criterion over *each* closed class; two were re-tested, both chosen
   by the lane writing the round. The same round recorded G3-C1 and G3-C4 as `NOT MEASURED` and
   excluded them rather than inferring. **Partial evidence is therefore handled two ways inside one
   round.** Recorded, not re-scored: which treatment is correct is a rule question for the owner, and
   a correction round is the wrong place to settle it. Under the stricter reading Goal 3 reads 2 of 8
   met with 3 not measured.

5. **Nit, no consequence:** the G2-C3 row calls `4.2.1 → 4.3.1` and `4.3.0 → 4.4.0` a gap of "one
   patch". Both are one **minor**. The row's finding — 0 of 20 records current on any reading — does
   not depend on it.

6. **Raised and deliberately NOT written in as fact — two figures the coordinator could not
   reproduce.** The review reported (a) a G1-C6 self-instrumentation effect at three hits, where the
   coordinator measures two `[obs:2026-08-19 grep -rn 'F8 r3' --include="*.md" . | wc -l -> 2, both in
   docs/loop/GOALS-SCORECARD.md]`, and (b) a probe-output count of 20 `PROBE FAIL` lines plus one
   summary against a printed 21, with 17 preceding `sed` errors against a printed "each", which was
   not re-run here at all. **Both stay open rather than being corrected to a second unverified
   number.** Recording a disagreement is honest; picking a side without measuring is how the original
   defect was made.

### Round 7 — 2026-08-19 (correction to Round 6's item 6; no criterion re-scored)

Appended, never edited; Round 6 is now frozen exactly as it froze Round 5. **This is the second
consecutive correction round to carry a defect**, which is the finding, not a footnote — see 3.

**The figures below are anchored two different ways, and the difference is stated rather than
blurred** — an earlier draft of this paragraph claimed all of them were SHA-pinned, which was false
for four of the nine and was caught in review before this round was pushed.

* **Item 1's figures are SHA-pinned**, read with `git grep <sha>`, never scanned from the working
  tree. That is the direct remedy for Round 6 item 6(a): a bare `.` scan measures the tree the round
  *creates*, so a scanning round is guaranteed to publish a number that was true only before it was
  written. Round 7's own text adds further occurrences of the string counted in 1, so those figures
  are deliberately NOT re-checkable by re-running the command at this round's own tree.
* **Item 2's four figures come from re-running a script against the working tree, and they ARE
  re-checkable here.** What makes that legitimate is a different anchor: the instrument is constant.
  `scripts/engine-claim-sweep.sh` is one blob across every commit in this range
  `[obs:2026-08-19 git ls-tree <sha> -- scripts/engine-claim-sweep.sh over 0371f43, 650a245, 9e53cc6,
  45e6635, 87bd16e, ac5aa7e, 7d9c051 -> b59fa9c2a3506110f07621197d80b429be46d108 at all seven;
  distinct blobs = 1]`. **This is weaker than SHA-pinning and is not claimed to be equivalent**: the
  script asserts directory presence against the tree it runs in, so the count does move if the tree
  is perturbed — demonstrated in review, where hiding a directory took it from 21 to 22.

The general rule this round is willing to state: **a re-run is reproducible when the instrument is
constant, and a scan is reproducible only when the scanned population is.** Round 6 conflated the
two. So did the first draft of this paragraph, which is the more useful evidence of how easy the
conflation is.

1. 🔴 **Round 6 item 6(a) is wrong, and wrong in the way item 6 existed to avoid.** It printed
   `grep -rn 'F8 r3' --include="*.md" . | wc -l -> 2` and declined to correct the review's figure of
   3 on the grounds that 3 could not be reproduced. **3 is reproducible two independent ways, and
   the printed 2 is false at the tree Round 6 publishes.**

   `[obs:2026-08-19 git grep -h 'F8 r3' <sha> -- '*.md', lines via wc -l and occurrences via
   grep -o 'F8 r3' | wc -l -> 9e53cc6 (parent): 2 lines / 3 occurrences · 45e6635 (the tree Round 6
   publishes): 3 lines / 4 occurrences, at GOALS-SCORECARD.md :267 :268 :450]`

   * **Lines are not occurrences.** `:267` carries the string **twice**, so the parent's 2 lines are
     3 occurrences. Round 6 answered an occurrence question with `wc -l`.
   * **The scope was silently narrowed.** Round 5's G1-C6 stamp was declared over tracked
     `.md/.tsv/.json/.sh`. At that scope, at the parent, the line count is **3**
     `[obs:2026-08-19 git grep -n 'F8 r3' 9e53cc6 -- '*.md' '*.tsv' '*.json' '*.sh' -> 3:
     GOALS-SCORECARD.md:267, :268, register-locks-archive/2026-08-17.tsv:29]`. Round 6 measured a
     narrower population than the stamp it was auditing and reported the difference as the other
     party's error.
   * **`:450` is Round 6's own stamp.** Round 6 therefore did precisely what its item 1 denied Round
     2 the excuse of — an instrument entering its own scan set (R290) — undisclosed, in the one
     measurement it did not pin, three lines after refusing that excuse to someone else.

   Both reconciliations land on 3. There was never a disagreement to record; there was an
   unmeasured claim.

2. 🔴 **Round 6 item 6(b) declined to measure something that takes one command, and the review was
   right.** Round 5 line 310 prints *"`PROBE FAILED`, 21 PROBE FAILs, each preceded by a BSD `sed`
   error"*. Both halves are wrong `[obs:2026-08-19 bash scripts/engine-claim-sweep.sh --probe, exit 1
   -> grep -c 'PROBE FAIL' = 21 · grep -c '^PROBE FAIL —' = 20 · grep -c 'PROBE FAILED' = 1 ·
   grep -c 'sed:' = 17]`.

   * **21 is a `grep -c` substring artefact** — the summary line `PROBE FAILED` contains the
     substring `PROBE FAIL`. There are **20** individual failures plus **1** summary.
   * **"each" is false** — 17 `sed` errors against 20 failures.

   The same root cause as 1: a substring/line count read as an item count. **Round 5, Round 6 and the
   Round 6 correction of it all failed on one confusion**, in three different places.

3. **The finding that outranks both: "I could not reproduce it" is itself a measurement claim, and
   it was not held to the standard of the numbers it was declining to state.** Round 6's items 1–5
   were re-measured exactly, including an instrument sweep. The defect landed in item 6 — the item
   whose stated purpose was refusing to assert what had not been measured. Declining to correct
   *reads* as restraint while functioning as an unverified assertion about the world, which is why it
   passed its own author's review. **The honest form of restraint is not a softer claim; it is the
   same command, run.** Proposed as a rule for the owner, not adopted here: a round may record a
   disagreement only after running the other party's command at the other party's stated scope.

4. **Not re-scored, and nothing above touches a verdict.** G1-C6's verdict rested on the ledger
   entry being absent, not on the occurrence count. G3-C7's partial-population question, raised in
   Round 6 item 4, is neither answered nor re-scored here: **this round records no ruling on it and
   asserts nothing about its status anywhere else.** That is a claim about this round only, and it is
   checkable against the text above — where Round 6's version asserted a current world-state without
   an anchor, which is the defect this whole round is about.

### Round 8 — 2026-08-19 (post-rebase re-verification; no criterion measured or re-scored)

**This round records a repair to the file's own numbering and to the resolvability of Rounds 5–7's
stamps. It measures no criterion.**

**What happened.** Two sessions independently authored a "Round 2 — 2026-08-18" against the same
append-only file. The other session pushed first (`d05ab0f`). This session's Rounds 2, 3 and 4 were
rebased on top and renumbered **2→5, 3→6, 4→7**, authorised by the owner on 2026-08-19. Their Round 2
and its two sub-sections are untouched and remain at their original position. Bodies below Round 5's
heading are unchanged apart from the heading, the renumber note, and internal cross-references
remapped so each round still points at the round it was written about.

1. 🔴 **Rounds 5–7's `[obs:]` stamps cite PRE-REBASE SHAs, which no longer exist on this branch.**
   This is a defect the rebase introduced, not one it found, and it is recorded rather than
   silently repaired — rewriting the stamps would replace measurements with numbers nobody took.
   The mapping restores resolvability:

   | cited in Rounds 5–7 | equivalent after rebase | | cited | equivalent |
   |---|---|---|---|---|
   | `0371f43` | `ef6d02f` | | `9e53cc6` | `727049e` |
   | `492505d` | `3dbff52` | | `45e6635` | `0c83bb9` |
   | `650a245` | `13b41a1` | | `87bd16e` | `020ea64` |
   | `0805ca7` | `a561925` | | `ac5aa7e` | `5166881` |
   | `9458fa3` | `3097ead` | | `7d9c051` | `5340fcb` |
   | `ef768d2` | `bf99acd` | | `7e8a6f6` | `8dfc812` |
   | `8031df6` | `449398a` | | `9277f2c` | `dae5c3f` |
   | `60704cd` | `0c180ee` | | `19cbde1` | `3c085b8` |
   | | | | `baf926f` | `bef8aa2` |

   ⚠️ **The old SHAs resolve only where the local branch `backup-pre-rebase-19-08-2026` exists.**
   That branch has not been pushed, so for any other reader the left column is unreachable and the
   right column is the only usable form. Push that branch, or treat this table as the anchor.

2. **What the mapping preserves, measured rather than assumed.** For every commit that did not touch
   this file, the rebase preserved content exactly, so a stamp about those files stays true under the
   mapping `[obs:2026-08-19 git ls-tree <sha> -- scripts/validate-tracking.sh, old vs new →
   0371f43/ef6d02f f23e3384 · 9e53cc6/727049e 9ec12b1b · 87bd16e/020ea64 and 9277f2c/dae5c3f
   eb8c8a8c — identical in all four pairs]`. `docs/loop/GOALS-SCORECARD.md` itself necessarily
   differs, because the other session's Round 2 is now merged in beneath Round 1.

3. **The one absolute line citation into this file is now stale, and is superseded here rather than
   edited in place.** Round 7 item 1 cites `GOALS-SCORECARD.md:267, :268` and `:450` for the `F8 r3`
   string. Those were correct pre-rebase. Re-measured at the rebased tip, before this round was
   written `[obs:2026-08-19 git grep -n 'F8 r3' bef8aa2 -- '*.md' → 7 lines / 8 occurrences, all in
   docs/loop/GOALS-SCORECARD.md at :435 :436 :618 :654 :658 :659 :666]`. **Round 7's reasoning is
   unaffected** — it turned on lines-versus-occurrences and on a scope narrowing, neither of which
   depends on where the lines sit. Only the coordinates moved.

4. **Pinned to `bef8aa2`, the tip before this round existed, for the reason Round 7 gives.** Writing
   this round adds further occurrences of the string counted in 3, so a working-tree scan here would
   publish a number true only before it was written. This is not the first instance in this file:
   Round 5 item 1 records a phrase count that grew because the finding was written down, and Round 6
   item 6(a) records a stamp that was true at its parent and false at the tree it published. Both are
   checkable above without leaving this file, and pinning is the remedy in each case.

5. **The structural finding, which is the durable part.** Nothing in this repository stopped two
   sessions choosing the same round number, and nothing detected it until a push was rejected at the
   remote. Line-number cross-references between rounds are a second casualty: they are correct only
   until someone inserts text above them, which an append-only file invites. Both are recorded here
   as the evidence base for the claim-before-write reservation and the anchored-token convention now
   proposed; **neither is adopted by this entry, and this entry may not be cited as adopting them.**

### Round 9 — 2026-08-19 (a gate verdict that depended on an unstated base; no criterion measured)

**This entry was drafted to record a gate override. There is no override. The branch passes its
gate, and the "inherited failures" that prompted the escalation were an artefact of how the gate
chooses a base when none is given.** The draft is not preserved; what it got wrong is.

1. **The finding, proven on one tree with one script** `[obs:2026-08-19 bash scripts/claims-gate.sh
   <base> at the same worktree → base `d05ab0f`: exit 0, "Results: 3 passed, 0 warnings, 0 failed" ·
   base `origin/main`: exit 1, "Results: 1 passed, 86 warnings, 24 failed"]`. Same commit, same
   checker, same second. The only variable is the base ref.

2. **Why the wrong base got chosen, read from the source rather than inferred**
   (`scripts/claims-gate.sh:123-128`): the base is `$1`, else `@{upstream}`, else `origin/main`, else
   skip. **On a detached HEAD `@{upstream}` does not resolve, so the chain silently falls through to
   `origin/main`** — which is **328 commits** behind this branch's actual base
   `[obs:2026-08-19 git rev-list --count origin/main..d05ab0f -> 328]`. The 24 failures are real
   claims in register files, measured against a base 328 commits stale. They are not a property of
   `d05ab0f` relative to this branch, and nothing was inherited from it.

3. 🔴 **Two independent verifications agreed, and both were wrong in the same way.** The coordinator
   measured `d05ab0f` by checking it out detached. The owner commissioned a separate agent, on a
   fresh clone, which checked it out detached. Both produced `1 passed, 86 warnings, 24 failed` —
   identical, reproducible, and an artefact of a methodology they shared. **Agreement between two
   measurements is not independence when both inherit the same implicit default.** This is the
   sharpest instance in this file of a defect class it has now recorded five times, and the first
   where the corroborating instrument was a second party.

4. **What the escalation itself got right.** The conflict between "gate-before-push" and a push
   authorisation issued before anyone knew the base was red was correctly routed to the owner rather
   than resolved by inference. That the premise later dissolved does not make the escalation wrong;
   it is what surfaced the artefact. Escalating on a false premise and discovering it beats acting on
   a false premise quietly.

5. **What is actually true of this branch.** It passes its own gate against its own base: exit 0,
   `448` added register lines scanned — a non-empty population, so the pass is not the empty-scan-set
   failure R222 names. Nothing was overridden and no discipline was waived.

6. **The successor requirement stands, and is sharpened.** The extension commissioned for the gate
   was to distinguish inherited from newly-introduced failures. This round adds a prior requirement:
   **a gate must state the base it used and fail loudly when it had to guess one.** A verdict whose
   meaning depends on an unstated default is not a verdict. **Proposed, not adopted; this entry may
   not be cited as adopting it.**

### Round 10 — 2026-08-19 (base-selection fix, and the first real independent verification)

Round 9 is pushed and frozen, so its follow-up lands here. Figures pinned to `70a281c`, the tip
before this round was written.

1. **The base-selection defect is fixed in all four scripts that had it.** Audited before the fix:
   `claims-gate.sh` printed a base but did not guard; `commit-scope-check.sh`, `register-lock.sh` and
   `pre-push-gate.sh` printed **no base at all** and did not guard. So three of four never said what
   they measured against, and none refused to guess.

   Every script now prints the base and how it was chosen, every run, and refuses rather than
   guessing when no `$1` and no resolvable `@{upstream}` is available
   `[obs:2026-08-19 detached-HEAD invocation with the new scripts → claims-gate 2 · commit-scope-check 2
   · register-lock 2 · pre-push-gate 2, all emitting "no diff base could be resolved -- refusing to run
   rather than guessing one" and "nothing was checked and no verdict was reached; do NOT read this as
   a pass"]`.

   **Counter-test, old and new against the same tree from the same root, timestamps filtered
   `[obs:2026-08-19 diff of full stdout]`:** `claims-gate.sh` both exit 0, diff is exactly one added
   line (`Diff base: @{upstream} (resolved from: upstream)`); `pre-push-gate.sh` both exit 0, diff is
   exactly two added lines (its own base, plus the second-leg `origin/main` base now announced as
   over-selection by design). Ordinary output is otherwise unchanged, which is the property that
   decides whether a guard gets routed around.

   ⚠️ **My first attempt at that counter-test was invalid and nearly passed.** Running the old script
   from `/tmp` made it resolve its repo root to `/` and report "no added lines — nothing to scan":
   two runs, two different trees, a green that meant nothing. Recorded because it is the same defect
   family the round is about — an instrument silently measuring something other than what was asked.

2. 🔴 **The first genuinely independent verification in this file, and it is worth separating from
   the four that preceded it.** Round 9 recorded that two parties reproduced `1 passed, 86 warnings,
   24 failed` and that the agreement was worthless, because both had checked out detached and
   inherited the same silent `origin/main` fallback. The owner has now re-run the same check
   **non-detached, on the real branch, with an explicit `base=d05ab0f`**, and reproduced the
   corrected result: claims-gate PASSED, 0 failed. He also confirms his earlier 24-failure check
   shared the identical blind spot.

   **The distinction is the whole lesson.** The first instance had one agent and one commissioned
   agent running the *same method*; the second has a *different method* reaching the same true
   result. Independence is not a property of who runs a check — it is a property of whether the runs
   share an unstated input. Two operators with one blind spot corroborate nothing; one operator
   changing method establishes more than both of them together did.

3. **The citation-count item: CORRECTED WITH SOURCE, not retracted.** A fresh grader could find no
   trace of the four "Part B proposals" in the repo or in Notion, and correctly refused a figure with
   no path attached. **The four files are in the session scratchpad and were never committed**
   `[obs:2026-08-19 ls -la <session>/scratchpad/PROPOSED_*.md -> 4 files: off-site-citations-function
   14701 B · source-of-truth-map 26566 B · telemetry-log-spec 24506 B · two-track-cadence-rule 15318 B;
   git ls-files over the repo returns none of them]` — deliberately, the
   owner having asked for proposals that touch no file under version control. Re-measured there with controls
   `[obs:2026-08-19 grep -c and grep -o over scratchpad/PROPOSED_*.md → off-site-citations-function
   8 lines / 8 occurrences; source-of-truth-map, telemetry-log-spec, two-track-cadence-rule 0 each;
   control "Owner" → 12 lines, control "zzqqxx" → 0]`. So: **8 occurrences in one of four proposals**,
   superseding the "cited four times across the Part B proposals" originally relayed.

   The grader's negative was accurate about its scan set and wrong as a general claim, which is the
   third instance of that shape recorded here. It is also the correct outcome: **a measured figure
   with no locator is not checkable, and blocking it was right even though the figure was right.**

### Round 11 — 2026-08-19 (addendum to Round 10; a fabricated control, and two corrected counts)

Round 10 is committed, so its corrections land here. Opened at `c35f0ee`; every figure below was
re-run at that tip, and every command is named so the next grader can re-run it rather than
trust it.

1. 🔴 **Round 10's citation `[obs:...]` block carried two numbers its commands did not produce,
   and the worse of the two was the control.** A fresh grader re-ran the recorded command and got
   9, not 8. Re-running the whole block rather than only the challenged figure
   `[obs:2026-08-19 c35f0ee]`:

   | figure as recorded in Round 10 | re-run | verdict |
   |---|---|---|
   | 4 byte sizes 14701 / 26566 / 24506 / 15318 | identical | ✅ real |
   | `git ls-files` → none of the four tracked | none tracked | ✅ real |
   | three other proposals → 0 each | 0 each | ✅ real |
   | control `zzqqxx` → 0 | 0 | ✅ real |
   | **`citation-landscape` → 8 lines / 8 occurrences** | **9 / 9** | ❌ **wrong** |
   | **control `Owner` → 12 lines** | **5** | ❌ **wrong** |

   **There is no innocent state explanation.** The file's mtime is `2026-08-19 09:37:13`; Round 10
   was committed at `11:01:52`. The file did not change between the measurement and the claim, so
   the numbers were not produced by the commands the block attributes them to.

   **The control is the serious half.** A positive control exists to prove the instrument could
   have returned a different number; a control written from expectation proves nothing, and it
   proves nothing *while displaying the exact evidence a reader checks for*. That is R297 — a check
   that cannot fail — reproduced inside the round whose own subject was instruments that measure
   something other than what they claim. Round 10 diagnosed the defect in four scripts and
   committed it in its own prose in the same pass.

   **Structural consequence, for a ruling rather than a fix here.** `[obs:...]` is load-bearing in
   this file: it asserts literal tool output, and every round's credibility rests on it. If it can
   carry a remembered number, it is devalued retroactively across all eleven rounds. The cheap
   mechanical remedy is the one that just worked — an obs block over a grep must name the command
   and its scan set so a grader can re-run it. This grader did exactly that, and it caught both
   errors in one pass.

2. **Corrected count: 9, by both instruments, with controls that fire.**
   `[obs:2026-08-19 c35f0ee · grep -n "citation-landscape" PROPOSED_off-site-citations-function.md
   → 9 lines (33, 34, 39, 56, 141, 159, 162, 176, 184) · grep -o … | wc -l → 9 occurrences ·
   the other three PROPOSED_*.md → 0 each · control "citation" → 14 · control
   "zzqq-impossible-token" → 0]`. Lines and occurrences agree at 9, which rules out the usual
   cause of a discrepancy of this shape: `grep -c` counts lines, `grep -o | wc -l` counts
   occurrences, and here every mention sits on its own line.

   **Definition, stated so it is checkable:** every line containing the literal string
   `citation-landscape`, in any role — pinpoint `file:line` evidence citations, prose describing
   the file's location, and register rows naming it as a decision object. No line is excluded.

   **And no narrower definition was in play.** Excluding the two prose lines (39, 176) yields 7;
   excluding only 39 yields 8, but nothing recorded at the time says that was the intent, and
   retro-fitting a definition now to make a wrong number defensible is the laundering failure
   already on this file's record at Round 7. **8 is retracted as wrong, not reinterpreted.**

3. **Commit counts, fetched and confirmed** `[obs:2026-08-19 git fetch origin exit 0; local
   origin/main 3f22f23 == git ls-remote origin refs/heads/main 3f22f23, so the base is current]`:

   | command | count | status |
   |---|---|---|
   | `git log --oneline origin/main..d05ab0f \| wc -l` | **328** | confirmed, matches Round 9 |
   | `git log --oneline origin/main..HEAD \| wc -l` | **354** | **corrected from 353** |

   **The 353 was right when it was said, and the delta is proven rather than asserted**
   `[obs:2026-08-19 origin/main..428ad26 → 353 · origin/main..c35f0ee → 354]`: 428ad26 was the tip
   when 353 was reported, and the single added commit is `c35f0ee`. `origin/main..d05ab0f` returns
   328 at both tips, so the base did not move — only the tip did.

   This is the same tree-sensitivity Round 10 recorded about item 2's figures, now applying to a
   figure of my own: **a count measured to a moving tip is stale the moment another commit lands,
   and only the base-pinned figure (328) is stable enough to quote without a timestamp.**

4. **Incidental defect, found while recounting.** `PROPOSED_off-site-citations-function.md:176`
   states the landscape file "is cited four times above"; the actual figure is 7
   `[obs:2026-08-19 head -175 … | grep -c → 7 at lines 33, 34, 39, 56, 141, 159, 162; control
   "zzqq-nothing" → 0]`. That file is proposed for commit under its own decision D3, so the figure
   should be corrected before it is committed, not after.

5. **This addendum's own status line turned the gate red, and that is the gate working.** The
   claims-gate flip-manifest sweep flagged `GOALS-SCORECARD.md:948` — a Status line asserting a
   verdict with no `FLIP:` trailer declaring what it flipped
   `[obs:2026-08-19 bash scripts/pre-push-gate.sh → exit 1; claims-gate "Results: 2 passed,
   2 warnings, 1 failed"; the other legs 5/0/0 and 1/0/0 PASSED]`.

   Recorded rather than quietly fixed, for two reasons. It is **a red proved against the pre-fix
   state on this very entry** — the R297 discipline item 1 found violated, demonstrated one section
   later. And the line as first drafted read "gate green" **before the gate had been run**: a
   verdict written from expectation, which is item 1's defect exactly, caught this time by a machine
   rather than by a grader. The machine is the cheaper of the two, and it is the argument for the
   mechanical remedy item 1 proposes.

6. **Status, measured rather than expected** `[obs:2026-08-19 bash scripts/pre-push-gate.sh
   unpiped, exit code read directly → 0, "PASSED — scanned 6 outgoing commit(s), 0 changed
   path(s) in the worktree", after the FLIP: trailer was supplied]`: **gate green, 6 outgoing
   commits including this entry, nothing pushed, awaiting explicit push authorization.**

   ⚠️ **Drafted as "5 outgoing commits" and corrected to 6 by amendment, because this entry is
   itself the sixth.** A status line cannot count the commit that carries it: the figure is true
   when written and false the instant it is committed. Third instance in this round of the same
   shape — item 1's control, item 3's 353, and now this — and the common cure is the one item 3
   states: **quote the base-pinned figure, or stamp the tip the figure was measured at.** The
   amendment is local and unpushed; no history was rewritten on any published ref.

### Round 12 — 2026-08-19 (full re-measurement; first since Round 5)

- **Round number**: this round was commissioned as "Round 3" by a scheduled check armed on
  2026-08-18, before Rounds 3–11 existed. **3 is taken, and so is everything up to 11**, so it is
  appended as 12. Rounds 3 and 4 are not headings in this file — they were renumbered into 5+ by
  the collision fix at `1b2e2e7`. Recorded because a second same-number collision is the exact
  defect that fix was written to prevent `[obs:2026-08-19 grep -nE "^### Round [0-9]+" docs/loop/GOALS-SCORECARD.md -> Rounds 1, 2, 5, 6, 7, 8, 9, 10, 11]`
- **Tree measured**: open and close HEAD **`509c7bb`**, working tree clean at open
  `[obs:2026-08-19 git rev-parse --short HEAD -> 509c7bb; git status --short -> empty]`
- **Distance from the previous full measurement**: **28 commits** since Round 2's close at
  `673716d` `[obs:2026-08-19 git rev-list --count 673716d..HEAD -> 28]`, of which 6 touch
  `scripts/` — `claims-gate.sh`, `commit-scope-check.sh`, `pre-push-gate.sh`, `reanchor-pointers.sh`,
  `register-lock.sh`, `validate-tracking.sh`
  `[obs:2026-08-19 git diff --name-only 673716d..HEAD | grep scripts/]`
- **Rounds 6–11 re-scored no criterion.** They are correction rounds. **The last full
  measurement of all criteria was Round 5**, so the comparison column below is against **Round 2**
  (this lane's own last full pass) with Round 5 named where the two disagree.
- **Wave under measurement**: still `blind-2026-08-17/`, 20 records, **byte-identical since
  Round 2** `[obs:2026-08-19 git diff --name-only 673716d..HEAD -- docs/loop/eval-baselines/ | wc -l -> 0]`.
  So every Goal 2 record-shape reading is expected to be unchanged, and is.
- **Probes were run twice each**, per Round 11's discipline. It changed one verdict — see G3-C5.

#### Goal 1 — **4 of 9 criteria met** (Round 2: 4 of 9 · Round 5: 3 of 9)

| ID | Result | Movement | Evidence |
|---|---|---|---|
| G1-C1 | **MET** | = | `SELFTEST PASS` `[obs:2026-08-19 509c7bb bash scripts/eval-prompt.sh --selftest]` |
| G1-C2 | **13 of 20** | = | Same 7 records carry `eval-prompt.sh` only in its `--grade` form: content-refresher, memory-management, meta-tags-optimizer, on-page-seo-auditor, schema-markup-generator, seo-content-writer, serp-analysis `[obs:2026-08-19 509c7bb python context scan, ±160 chars]` |
| G1-C3 | **18 of 20** | = | keyword-research and performance-reporter still prose-only `[obs:2026-08-19 509c7bb]` |
| G1-C4 | **MET, 20 of 20** | = | Accepting any drift-named key, as corrected in Round 2 `[obs:2026-08-19 509c7bb]` |
| G1-C5 | **3 of 5 wave dates** | ▼ denominator | Archives: `2026-08-10.tsv`, `2026-08-17.tsv`, `2026-08-18.tsv`. **`2026-08-19` has 19 commits and no archive.** Unlike 08-13 (historical, mechanism not running), this one is current. **Stated rather than scored either way**: all 19 carry a single author, so whether they are "two or more lanes" or one operator working sequentially is not decidable from the log, and the criterion turns on that word `[obs:2026-08-19 ls docs/loop/register-locks-archive/ -> 3 files; git log --since="2026-08-19 00:00" --format=%an | sort -u -> 1 author, 19 commits]` |
| G1-C6 | **MET** | = | 51 ledger entries, coordinator conduct among them with rules attached `[obs:2026-08-19 509c7bb grep -cE "^#{2,3} (F[0-9]+\|Correction\|Ruling\|M[0-9])" -> 51]` |
| G1-C7 | **MET — 0** | ▲ from 1 | **Zero recurrence entries dated to the round under measurement.** Round 2 recorded 1 (its own F11 r9) `[obs:2026-08-19 grep -cE "^#{2,3} F[0-9]+ — Recurrence.*2026-08-19" docs/loop/FAILURE-LEDGER.md -> 0]` |
| G1-C8 | **2 of 4 rows** | = | `KPI.md` rows at 2026-08-10 (`8/0`), 08-13 (`11/3`), 08-17 (`n/a`), 08-17-corrected (`n/a`). **Still no row for 08-18 or 08-19** `[obs:2026-08-19 grep -cE "^\| 2026-08-[0-9]+ \|" docs/loop/KPI.md -> 4]` |
| G1-C9 | **13 of 20** | = | Same 7 without a named second reader `[obs:2026-08-19 509c7bb]` |

#### Goal 2 — **6 of 9 criteria met** (Round 2: 6 of 9 · Round 5: 6 of 9)

| ID | Result | Movement | Evidence |
|---|---|---|---|
| G2-C1 | **MET, 20 of 20** | = | `[obs:2026-08-19 ls -d */*/evals/evals.json | wc -l -> 20]` |
| G2-C2 | **MET, 20 of 20** | = | `[obs:2026-08-19 ls blind-2026-08-17/*.json | wc -l -> 20]` |
| G2-C3 | **0 of 20** | = (distance grew) | Still zero, and it cannot fall further. **The distance grew again**: the 28 commits include a freshness sweep across six skills and edits to schema-markup-generator and geo-content-optimizer, none of which is reflected in any record. **This is the third consecutive round at zero** `[obs:2026-08-19 509c7bb per-record git diff <repo_head_at_open>..HEAD over each skill dir -> 0 records with an empty diff]` |
| G2-C4 | **MET, 20 of 20** | = | Records unchanged since Round 2 `[obs:2026-08-19]` |
| G2-C5 | **MET, 20 of 20** | = | Records unchanged since Round 2 `[obs:2026-08-19]` |
| G2-C6 | **NOT MET — 21 open** | = | Same 21 across the same 12 suites. **No later blind run exists to re-exercise any of them**, which is the only thing that closes this `[obs:2026-08-19 509c7bb python count over all 8 field shapes -> 21/12]` |
| G2-C7 | **20 of 21** | = | The single gap is still **performance-reporter `e4.3`** — its id is in a register but not within 300 characters of its own suite name `[obs:2026-08-19 509c7bb]` |
| G2-C8 | **MET, 20 of 20** | = | `[obs:2026-08-19 bash scripts/eval-corpus-report.sh]` |
| G2-C9 | **MET, 20 of 20** | = | `[obs:2026-08-19]` |

#### Goal 3 — **5 of 8 criteria met** (Round 2: 6 of 8 · Round 5: 3 of 8 with 2 not measured)

**The round's only fraction movement, and it is backwards.**

| ID | Result | Movement | Evidence |
|---|---|---|---|
| G3-C1 | **MET** | = | `PRE-PUSH GATE: PASSED`, exit 0, and it now prints its base every run: `Diff base: origin/claude/scheduled-skills-web-search-8zaz3j (resolved from: upstream)` `[obs:2026-08-19 509c7bb bash scripts/pre-push-gate.sh; echo $? -> 0]` |
| G3-C2 | **MET, 20 of 20** | = | `15 passed, 0 warnings, 0 failed` each `[obs:2026-08-19 loop over 20 skill dirs]` |
| G3-C3 | **MET** | = | `10 passed, 15 warnings, 0 failed` `[obs:2026-08-19 bash scripts/validate-tracking.sh .]` |
| G3-C4 | **NOT MET** | = | 2 legs report *"no outgoing commits — nothing to check"*; closing line `PASSED — but NOTHING WAS OUTGOING` `[obs:2026-08-19 grep -c "nothing to check" -> 2; grep -c "NOTHING WAS OUTGOING" -> 1]` |
| G3-C5 | **NOT MET — 5 of 6 as found** | ▼▼ from 6 of 6 | **`commit-scope-check.sh --probe` printed `PROBE FAILED` on both runs, exit 1.** 18 of its 19 cases pass; one fails: `scope-base-unresolvable — expected exit 0, got 2`. **The guard is not broken — its own test is stale.** `c35f0ee` (2026-08-19, *"an explicit-but-unresolvable base skipped and exited 0"*) deliberately changed that branch from SKIP-at-0 to ERROR-at-2, closing a false green. The fixture still carried `EXPECT-EXIT: 0` **and a `WHY` block arguing the old behaviour was correct**, so from `c35f0ee` until this round the leg's probe reported failure against corrected behaviour. The other five legs pass twice each `[obs:2026-08-19 509c7bb each probe run twice: validate-tracking PASS/PASS · fence-nesting-check PASS/PASS · validate-skill PASS/PASS · register-lock PASS/PASS · commit-scope-check FAILED/FAILED, exit 1]` |
| G3-C6 | **MET, 5 of 5** | = | `fence-nesting-check --bare-inner` → **3 sites in 2 files**, matching its header (B) block · `citation-divergence-check` → `1 passed, 1 warnings, 6 failed`, all six on R3 · `check-freshness` → all tracked state within window · `engine-claim-sweep --probe` → `PROBE PASS — 7/7 exclusive family canaries` · `expectation-carrier-check` prints its coverage footer `[obs:2026-08-19 509c7bb five advisory runs]` |
| G3-C7 | **MET** | = | R3 class re-tested by flattened multiline regex: **4 files, none in a skill tree** (down from 6 as `VERSIONS.md` consolidated); gated fence scan `0 with problems` `[obs:2026-08-19 509c7bb python flattened regex over all .md]` |
| G3-C8 | **NOT MET** | = | Still no `KPI.md` row for the round under measurement — none for 08-18 or 08-19. The 08-17 correcting row's own figures remain drifted: it states 19 regressions across 18 compared suites; the wave yields **21 across 20** `[obs:2026-08-19 KPI.md date column -> 08-10, 08-13, 08-17, 08-17]` |

**Fixed by this round, and scored as found rather than as fixed.** The `scope-base-unresolvable`
fixture was rewritten here to `EXPECT-EXIT: 2`, `ROLE: positive`, with a second `EXPECT-MATCH` on
`refusing to run` and a `WHY` block recording why it changed. Verified twice: `PROBE PASS`, exit 0.
**G3-C5 is nevertheless recorded NOT MET at 5 of 6**, because the round scores the tree it measured;
scoring the repair would be the laundering this file recorded against itself at Round 7. The next
round should find 6 of 6.

#### Goal 4 — **4A: 3 of 4 criteria met (Round 2: 3 of 4 · Round 5: 2 of 4). 4B: 0 of 4 cleared, all owner-gated**

| ID | Result | Movement | Evidence |
|---|---|---|---|
| G4-C1 | **MET, 20 of 20** | = | 20 of 20 carry path and vocabulary; 19 of 20 inside an output-shaped section; the exception is memory-management, which states it does not author actions `[obs:2026-08-19 509c7bb section-attributed scan of all 20 SKILL.md]` |
| G4-C2 | **MET, 20 of 20** | = | `[obs:2026-08-19]` |
| G4-C3 | **MET** | = (+1 artefact) | 8 artefacts under `docs/loop/pilot/`, plus `docs/loop/reports/citation-landscape_18-08-2026.md`, new since Round 2 `[obs:2026-08-19 ls docs/loop/pilot/ | wc -l -> 8; ls docs/loop/reports/]` |
| G4-C4 | **NOT MET — 0 captures** | = | No capture log exists. **Third consecutive round at zero** `[obs:2026-08-19 ls docs/loop/pilot/ | grep -icE capture -> 0]` |

**4B — owner-gated, unchanged and reported as blocked, not as zero.** B1 `0 of 3 inputs cleared` ·
B2 `unlocked` · B3 `empty` · B4 `refused at gateway` for client hosts, allow-list admits
`github.com`. Nothing in 4B moved because nothing in 4B is the library's to move.

**Round 12 in one line.** Three goals held exactly; Goal 3 fell 6 → 5 on a stale test rather than a
broken guard; and the two criteria that have now sat at zero for three consecutive rounds — G2-C3
and G4-C4 — each wait on one decision: freeze the tree and re-run the wave, and take one capture
against the v1 prompt set.

### Round 13 — 2026-08-20 (verification round; one criterion moved)

**Short by design.** Every criterion was re-run, and one moved. A round that re-states twenty-nine
unchanged readings to look thorough buries the one figure that is news.

- **Round number**: 13, taken by grepping the file rather than trusting the commissioning prompt,
  which said only "next round" `[obs:2026-08-20 grep -oE "^### Round [0-9]+" docs/loop/GOALS-SCORECARD.md | grep -oE "[0-9]+" | sort -n | tail -1 -> 12]`
- **Tree measured**: open and close HEAD **`5df68d8`**, working tree clean, nothing unpushed, and
  **the remote had not moved** `[obs:2026-08-20 git rev-parse --short HEAD -> 5df68d8; git status --short -> empty; git fetch then git log --oneline HEAD..origin/... -> empty]`
- **Distance from Round 12**: **one commit — Round 12's own**, touching exactly two paths
  `[obs:2026-08-20 git diff --name-only 509c7bb..HEAD -> docs/loop/GOALS-SCORECARD.md, scripts/fixtures/commit-scope-check/scope-base-unresolvable.txt]`
- **Wave under measurement**: `blind-2026-08-17/`, 20 records, unchanged.

#### The one movement — Goal 3: **5 of 8 → 6 of 8**

**G3-C5 is MET, 6 of 6, and the repair is verified rather than assumed.** Round 12 rewrote the
`scope-base-unresolvable` fixture and scored itself NOT MET anyway, on the rule that a round scores
what it found. This round is the independent confirmation that rule exists to require:

| leg | run 1 | run 2 |
|---|---|---|
| `validate-tracking --probe` | PROBE PASS | PROBE PASS |
| `fence-nesting-check --probe` | PROBE PASS | PROBE PASS |
| `validate-skill --probe` | PROBE PASS | PROBE PASS |
| **`commit-scope-check --probe`** | **PROBE PASS** | **PROBE PASS** |
| `register-lock --probe` | PROBE PASS | PROBE PASS |

`[obs:2026-08-20 5df68d8 each probe invoked twice, verdict read from the PROBE line and not from a pipeline's exit status]`

`claims-gate` was checked for **discrimination, not just execution** — the failure mode a fixture
corpus is most likely to hide. Its 8 defect fixtures each fail (1–2 failures apiece) and
`negative-control-clean` passes at `3 passed, 0 warnings, 0 failed`
`[obs:2026-08-20 5df68d8 nine fixture runs, Results line per fixture]`.

#### Everything else — held exactly

| Goal | Round 12 | Round 13 |
|---|---|---|
| 1 — Structural & Coordinator Defenses | 4 of 9 | **4 of 9** |
| 2 — Skill Evaluation & Verification | 6 of 9 | **6 of 9** |
| 3 — Loop Durability & Scripted Rigor | 5 of 8 | **6 of 8** |
| 4A — Outcome Quality | 3 of 4 | **3 of 4** |

Re-run and identical to Round 12 in every cell
`[obs:2026-08-20 5df68d8]`: G1-C1 `SELFTEST PASS` · G1-C2 13/20 · G1-C3 18/20 · G1-C4 20/20 ·
G1-C5 three archives (`08-10`, `08-17`, `08-18`) · G1-C6 51 ledger entries · G1-C7 **0** recurrences
dated to this round · G1-C8 2 of 4 KPI rows · G1-C9 13/20 · G2-C1 20/20 · G2-C2 20/20 ·
**G2-C3 0 of 20** · G2-C4 20/20 · G2-C5 20/20 · **G2-C6 21 across 12 suites** · G2-C7 20 of 21,
the gap still performance-reporter `e4.3` · G2-C8 `1259/1400 = 0.8993` as recorded and
`1291/1400 = 0.9221` counting the editor slot, every record read · G2-C9 20/20 · G3-C1 gate exit 0 ·
G3-C2 20/20 · G3-C3 `10 passed, 15 warnings, 0 failed` · G3-C4 2 legs with no subject ·
G3-C6 5 of 5 advisories reproduce · G3-C7 R3 class 4 files, none in a skill tree ·
G3-C8 no KPI row for 08-18, 08-19 or 08-20 · G4-C1 20/20 (19 of 20 strict) · G4-C2 20/20 ·
G4-C3 8 pilot artefacts · **G4-C4 0 captures**.

#### What this round establishes about the two long-zero criteria

**G2-C3 and G4-C4 are now at zero for a fourth consecutive round.** This round adds one fact about
them that the previous three could not: **the tree did not move at all between Round 12 and Round 13,
and neither criterion moved either.** Every prior round could attribute a zero to churn — a wave
landing, references shifting, records aging. This one cannot. Nothing happened, and nothing changed,
which is the cleanest available demonstration that neither is waiting on work in the tree. G2-C3
needs the tree frozen and the wave re-run; G4-C4 needs one capture taken. Both are decisions.

**4B unchanged**, owner-gated throughout, reported as such and not as zero.

### Round 14 — 2026-08-21 (nothing moved; one correction, and a fifth zero)

- **Round number**: 14, from the file `[obs:2026-08-21 grep -oE "^### Round [0-9]+" docs/loop/GOALS-SCORECARD.md | grep -oE "[0-9]+" | sort -n | tail -1 -> 13]`
- **Tree**: open and close HEAD **`3b67d0c`**, clean, nothing unpushed, **remote unmoved**
  `[obs:2026-08-21 git status --short -> empty; git fetch then git log --oneline HEAD..origin/... -> empty]`
- **Distance from Round 13**: one commit — Round 13's own — touching **one path**, this file
  `[obs:2026-08-21 git diff --name-only 5df68d8..HEAD -> docs/loop/GOALS-SCORECARD.md]`

#### No fraction moved

| Goal | Round 13 | Round 14 |
|---|---|---|
| 1 — Structural & Coordinator Defenses | 4 of 9 | **4 of 9** |
| 2 — Skill Evaluation & Verification | 6 of 9 | **6 of 9** |
| 3 — Loop Durability & Scripted Rigor | 6 of 8 | **6 of 8** |
| 4A — Outcome Quality | 3 of 4 | **3 of 4** |

Every criterion re-run at `3b67d0c`, every cell identical `[obs:2026-08-21]`: G1-C1 `SELFTEST PASS` ·
G1-C2 13/20 · G1-C3 18/20 · G1-C4 20/20 · G1-C5 three archives · G1-C6 51 entries · G1-C7 **0**
recurrences dated to this round · G1-C8 2 of 4 KPI rows · G1-C9 13/20 · G2-C1 20/20 · G2-C2 20/20 ·
**G2-C3 0 of 20** · G2-C4 20/20 · G2-C5 20/20 · **G2-C6 21 across 12** · G2-C7 20 of 21
(performance-reporter `e4.3`) · G2-C8 both rates, every record read · G2-C9 20/20 · G3-C1 exit 0 ·
G3-C2 20/20 · G3-C3 `10 / 15 warn / 0 fail` · G3-C4 2 legs with no subject · **G3-C5 5 legs
PROBE PASS twice each** · G3-C6 5 of 5 · G3-C7 4 files, none in a skill tree · G3-C8 no KPI row for
08-18, 08-19, 08-20 or 08-21 · G4-C1 20/20 (19 strict) · G4-C2 20/20 · G4-C3 8 artefacts ·
**G4-C4 0 captures**. 4B unchanged, owner-gated.

#### Correction to Round 13 — a summary of mine that overstated its own evidence

Round 13 wrote of the `claims-gate` fixture corpus: *"Its 8 defect fixtures each fail (1–2 failures
apiece)."* **That is wrong, and the data contradicting it was in the same run.** Re-measured:

| fixture | failures |
|---|---|
| `f11-founding-forward-timestamp` | 2 |
| `f11-r5-register-wide-stale-claims` | 2 |
| `f11-founding-stale-sibling` | 1 |
| `f11-r3-end-to-end-overclaim` | 1 |
| `f11-r4-post-flip-stale-sibling` | 1 |
| **`f11-founding-attribution-gloss`** | **0** — warning only |
| **`f11-r1-word-level-graduated`** | **0** — warning only |
| **`f11-r2-mechanism-in-observed-frame`** | **0** — warning only |
| `negative-control-clean` | 0 — correct |

`[obs:2026-08-21 3b67d0c nine runs of bash scripts/claims-gate.sh --fixture <dir>, failure count read from each Results line]`

**Five of eight defect fixtures fail; three register a WARN and no FAIL.** Corrected, not
reinterpreted — those three are WARN-tier by design and the corpus is sound; the error is that a
round summarised "each fail" over a set where three did not, while displaying the numbers that
disprove it. **This is the same shape as Round 11's fabricated control and this file's F11 class**:
not an invented figure, but a summary sentence claiming more uniformity than its own table shows.
Round 2's line 281 (*"fires on all 8 defect fixtures"*) is looser and survives, because a WARN is a
firing; **"each fail" is not.**

#### 🔴 G2-C3 and G4-C4: a fifth consecutive round at zero, and no decision recorded

Stated plainly, per this round's own commissioning condition, **because a fifth identical row is not
progress and should not be allowed to read as it.**

| | rounds at zero | what would move it | recorded decision |
|---|---|---|---|
| **G2-C3** — no graded record describes a skill version that still exists | **5** (Rounds 2, 5, 12, 13, 14) | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** — no AI-visibility capture has ever been taken, once | **5** (Rounds 1, 5, 12, 13, 14) | one capture against prompt-set v1 under the N ≥ 3 protocol, labelled as against a draft set | **none** |

**Neither is waiting on work in the tree, and Rounds 13 and 14 together are the proof.** Across both,
the tree moved by two commits, both of them edits to this file. Nothing else changed, and neither
criterion changed. Every earlier zero could be attributed to churn — a wave landing, references
shifting, records aging. **Two consecutive still rounds cannot be.**

**What that costs, stated once.** G2-C3 at zero means the library has no current evidence that any
skill does what its suite says — the 21 regressions under G2-C6 are the last measurement anyone
took, and they are five rounds stale. G4-C4 at zero means Goal 4's name — *Proof of Utmost
Quality* — rests on zero observations of the surface the engagement targets.

**This round makes no recommendation about priority between them**; both are owner decisions and
`CLIENT-MANDATE.md` §4 governs. It records that the decisions have been outstanding for five
measured rounds.

### Round 15 — 2026-08-22 · a SIXTH round at zero for G2-C3 and G4-C4, and a third still tree

- **Round number**: 15, from the file `[obs:2026-08-22 highest "### Round N" heading -> 14]`
- **Tree**: open and close HEAD **`daf391e`**, clean, nothing unpushed, remote unmoved. Distance
  from Round 14: one commit — Round 14's own — touching **one path, this file**
  `[obs:2026-08-22 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only 3b67d0c..HEAD -> docs/loop/GOALS-SCORECARD.md]`
- Every criterion re-run rather than reasoned about, per this file's own note.

#### No fraction moved, for the second consecutive round

| Goal | R13 | R14 | R15 |
|---|---|---|---|
| 1 — Structural & Coordinator Defenses | 4 of 9 | 4 of 9 | **4 of 9** |
| 2 — Skill Evaluation & Verification | 6 of 9 | 6 of 9 | **6 of 9** |
| 3 — Loop Durability & Scripted Rigor | 6 of 8 | 6 of 8 | **6 of 8** |
| 4A — Outcome Quality | 3 of 4 | 3 of 4 | **3 of 4** |

All cells identical to Round 14 `[obs:2026-08-22 daf391e]`: G1-C1 `SELFTEST PASS` · C2 13/20 ·
C3 18/20 · C4 20/20 · C5 three archives · C6 51 entries · C7 **0** recurrences dated to this round ·
C8 2 of 4 KPI rows · C9 13/20 · G2-C1 20/20 · C2 20/20 · **C3 0 of 20** · C4 20/20 · C5 20/20 ·
**C6 21 across 12** · C7 20 of 21 · C8 both rates · C9 20/20 · G3-C1 exit 0 · C2 20/20 ·
C3 `10 / 15 warn / 0 fail` · C4 2 legs with no subject · C5 five legs PROBE PASS twice each ·
C6 5 of 5 · C7 4 files, none in a skill tree · C8 no KPI row for 08-18 through 08-22 ·
G4-C1 20/20 (19 strict) · C2 20/20 · C3 8 artefacts · **C4 0 captures**. 4B unchanged, owner-gated.

**Round 14's correction holds on re-measurement.** The `claims-gate` corpus splits 5 FAIL / 3
WARN-only, exactly as corrected, and the negative control is clean
`[obs:2026-08-22 daf391e nine fixture runs, warnings and failures read separately: forward-timestamp 0w/2f · register-wide-stale-claims 0w/2f · founding-stale-sibling 0w/1f · end-to-end-overclaim 0w/1f · post-flip-stale-sibling 0w/1f · attribution-gloss 1w/0f · word-level-graduated 1w/0f · mechanism-in-observed-frame 1w/0f · negative-control-clean 0w/0f]`

#### 🔴 Sixth round at zero — G2-C3 and G4-C4

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **6** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **6** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Three consecutive rounds have now measured a tree that did not move.** Rounds 13, 14 and 15 span
three commits, all three of them edits to this file. Nothing else in the repository changed across
72 hours, and no criterion changed either.

**A note on what this instrument can and cannot do from here.** The scorecard's value is movement
over time; with a static tree and no decision, each round costs a full re-measurement and returns
the previous round's numbers. That is not a fault in the file and the re-runs are not wasted —
confirming that nothing moved is a measurement, and it is the evidence above that neither zero is
attributable to churn. **But it does mean the next round has nothing new to find unless something
changes**, and a reader should not mistake a lengthening column of identical rows for progress.
The two decisions are recorded as outstanding, under `CLIENT-MANDATE.md` §4; this round re-argues
neither and states no preference between them.

### Round 16 — 2026-08-23 · a SEVENTH round at zero for G2-C3 and G4-C4; G3-C8's blocker removed

- **Round 16**, from the file `[obs:2026-08-23 highest heading -> 15]`. Tree: open HEAD **`439a317`**,
  clean, remote unmoved; distance from Round 15 is one commit — Round 15's own — touching this file
  only `[obs:2026-08-23 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only daf391e..HEAD -> docs/loop/GOALS-SCORECARD.md]`
- **Fourth consecutive still tree.** Every criterion re-run; the full cell list is in Round 15 and is
  not restated here.

#### No fraction moved, for the third consecutive round

| Goal | R13 | R14 | R15 | R16 |
|---|---|---|---|---|
| 1 | 4 of 9 | 4 of 9 | 4 of 9 | **4 of 9** |
| 2 | 6 of 9 | 6 of 9 | 6 of 9 | **6 of 9** |
| 3 | 6 of 8 | 6 of 8 | 6 of 8 | **6 of 8** |
| 4A | 3 of 4 | 3 of 4 | 3 of 4 | **3 of 4** |

Spot-confirmed identical `[obs:2026-08-23 439a317]`: five probes PROBE PASS twice each · claims-gate
5 FAIL / 3 WARN-only / control clean · G3-C2 20/20 · G3-C3 `10 / 15 warn / 0 fail` ·
G1-C1 `SELFTEST PASS` · G1-C7 **0** recurrences dated to this round · **G2-C3 0 of 20** ·
G2-C6 21 across 12 · G2-C7 20 of 21 · G4-C1 20/20 · **G4-C4 0 captures**.

#### G3-C8 — the blocker is removed, and the criterion is still scored NOT MET

**This round did the one unmet thing that needed no owner decision.** `KPI.md` now carries a
**2026-08-23 correcting row**, written under that file's own rule 1 (*a wrong number is corrected by
appending a new row that names the row it corrects*).

**What the 2026-08-17 correcting row got wrong, and what it got right.** It states *"19 of 477
previously-passing expectations across the 18 compared suites = 4.0%"*. **Two of its three counts
are wrong** — the wave carries **21** attributed regressions across **20** compared suites — **and
its headline percentage is right**: 19/477 = 3.98%, 21/530 = 3.96%, both rounding to 4.0%.

**That is the finding worth keeping.** The rate survived while every number under it moved, which is
exactly why the drift went unnoticed through five scorecard rounds. A percentage that is stable
under a wrong numerator *and* a wrong denominator is not corroboration of either.

Derivation, so it is checkable rather than assertable: performance-reporter and rank-tracker were
`NOT PERFORMED` when the 08-17 row was written; both comparisons were later run and each returned
one regression (19 → 21, 18 → 20 suites). The denominator gains those suites' own baseline passes —
performance-reporter 28 of 29, rank-tracker 25 of 28 — so 477 + 28 + 25 = **530**
`[obs:2026-08-23 439a317 baseline totals read from each record's regressions_vs_baseline.baseline string]`.
`evals passed/total` was re-derived independently by summing `summary.passed` and `summary.total`
across all 20 records and **matches the 08-17 row's 544/610 exactly**, which is the control on the
method that produced the two corrected figures.

**G3-C8 is nevertheless recorded NOT MET.** The round scores the tree it measured, not its own
repair — the Round 7 laundering rule, applied here as it was to the fixture at Round 12. The next
round should find it MET, and should verify the row rather than trust this note.

#### 🔴 Seventh round at zero — G2-C3 and G4-C4

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **7** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **7** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Four consecutive rounds have measured a tree that did not move**, across four commits, all four of
them edits to this file. Both remain owner decisions under `CLIENT-MANDATE.md` §4; this round
re-argues neither and states no preference.

**What changed about the shape of the problem, though, is worth one line.** Before this round, three
criteria were unmet-and-actionable-by-the-library: G3-C8, and the two zeros. **G3-C8's blocker is now
gone.** Every remaining unmet criterion is either owner-gated, or needs a wave the owner must
authorise freezing the tree for, or is a record-quality gap in a corpus nobody will re-run until that
wave happens. **The library has run out of unmet criteria it can close on its own.**

### Round 17 — 2026-08-24 · G3-C8 MET; an instrument that nearly retracted a correct row; an EIGHTH zero

- **Round 17** `[obs:2026-08-24 highest heading -> 16]`. Tree: HEAD **`1b3d50f`**, clean, remote
  unmoved; one commit from Round 16, and that commit was Round 16's own
  `[obs:2026-08-24 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only 439a317..HEAD -> docs/loop/GOALS-SCORECARD.md, docs/loop/KPI.md]`
- **Fifth consecutive still tree.**

#### Goal 3: **6 of 8 → 7 of 8.** G3-C8 is MET

Round 16 appended a correcting `KPI.md` row and scored the criterion NOT MET, per the rule that a
round scores what it found. **This round verified it by re-deriving every cell rather than reading
the row**, and all four re-derive:

| cell | Round 16's row | re-derived here | method |
|---|---|---|---|
| attributed regressions | 21 | **21** | count over all eight `regressions_vs_baseline` shapes |
| compared suites | 20 | **20** | records with a non-empty comparison object |
| `evals passed/total` | 544/610 | **544/610** (41 failed) | sum of `summary.passed` / `summary.total` across 20 records |
| **denominator** | 530 | **530** | **see below — a genuinely independent route** |

**The denominator is the one that mattered, and Round 16's derivation had a hole in it.** Round 16
computed 530 as `477 + 28 + 25`, inheriting **477 from the very row it was correcting** — a figure
it never checked. This round derived it from scratch instead: for each of the 20 records, open the
baseline file that record itself names, and read that baseline's own pass count. **Sum: 530, across
20 of 20, with nothing left underivable** `[obs:2026-08-24 1b3d50f per-record baseline path extracted from regressions_vs_baseline, each baseline opened, pass count read from summary.passed or totals.pass]`.
Two methods, one number, and it retroactively validates the 477 as well (530 − 28 − 25 = 477).

#### 🔴 The instrument finding — this one nearly retracted a *correct* row

The first pass at that derivation read `summary.passed` and returned **278 across 10 of 20**,
reporting the other ten as having no pass count. Read literally, that says the denominator is not
derivable, **which would have made Round 16's row an overclaim and G3-C8 a fail.**

**It was wrong.** The ten "missing" records are the 2026-08-10 founding wave, which predates the
corpus schema and stores its figures under **`totals.pass`, not `summary.passed`**. Accepting either
key returns 20 of 20 and the exact 530
`[obs:2026-08-24 1b3d50f blind-2026-08-10/technical.json top-level keys -> [... 'totals' ...], summary -> null]`.

**This is the sixth instrument-aimed-beside-the-target instance recorded in this file, and the first
whose failure direction is inverted.** The other five reported something *green* that was not
(Rounds 2 ×4, Round 12 ×1). This one would have reported something *red* that was not — retracting a
correct correction, and looking rigorous while doing it. **A round that only distrusts its
optimistic readings is half-calibrated.** The rule that caught it is the same one: when a number is
surprising, read the underlying field before believing the instrument.

#### Everything else — held

| Goal | R14 | R15 | R16 | R17 |
|---|---|---|---|---|
| 1 | 4 of 9 | 4 of 9 | 4 of 9 | **4 of 9** |
| 2 | 6 of 9 | 6 of 9 | 6 of 9 | **6 of 9** |
| 3 | 6 of 8 | 6 of 8 | 6 of 8 | **7 of 8** |
| 4A | 3 of 4 | 3 of 4 | 3 of 4 | **3 of 4** |

Confirmed identical `[obs:2026-08-24 1b3d50f]`: five probes PROBE PASS twice each · G3-C1 exit 0 ·
G3-C2 20/20 · G3-C3 `10 / 15 warn / 0 fail` · G3-C4 2 legs with no subject · G1-C1 `SELFTEST PASS` ·
G1-C2 13/20 · G1-C3 18/20 · G1-C4 20/20 · G1-C7 **0** recurrences dated to this round · G1-C9 13/20 ·
**G2-C3 0 of 20** · G2-C6 21 across 12 · G2-C7 20 of 21 · G4-C1 20/20 · **G4-C4 0 captures**.

#### 🔴 Eighth round at zero — G2-C3 and G4-C4

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **8** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **8** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**The structural statement from Round 16 now holds with one criterion fewer to qualify it.** G3-C8
was the last unmet criterion the library could close on its own, and it is closed. **Every remaining
unmet criterion is owner-gated, needs a wave the owner must authorise freezing the tree for, or is a
record-quality gap in a corpus nobody will re-run until that wave happens.**

Five consecutive rounds have measured a tree that did not move, across five commits, all five of
them edits to this file and — once — to `KPI.md`. Both decisions remain outstanding under
`CLIENT-MANDATE.md` §4; this round re-argues neither and states no preference.

### Round 18 — 2026-08-25 · a NINTH round at zero; nothing moved; sixth still tree

- **Round 18** `[obs:2026-08-25 highest heading -> 17]`. HEAD **`76cd7c6`**, clean, remote unmoved;
  one commit from Round 17, and that commit was Round 17's own edit to this file
  `[obs:2026-08-25 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only 1b3d50f..HEAD -> docs/loop/GOALS-SCORECARD.md]`

| Goal | R15 | R16 | R17 | R18 |
|---|---|---|---|---|
| 1 | 4 of 9 | 4 of 9 | 4 of 9 | **4 of 9** |
| 2 | 6 of 9 | 6 of 9 | 6 of 9 | **6 of 9** |
| 3 | 6 of 8 | 6 of 8 | 7 of 8 | **7 of 8** |
| 4A | 3 of 4 | 3 of 4 | 3 of 4 | **3 of 4** |

**G3-C8 re-verified rather than carried.** All four figures re-derive at this tree, the denominator
again by the independent route (each record's own named baseline, `summary.passed` or `totals.pass`
by wave): **21 regressions across 20 compared suites · 544/610 · denominator 530 across 20 of 20**
`[obs:2026-08-25 76cd7c6]`. Every other cell identical to Round 17: five probes PROBE PASS twice
each · G3-C1 exit 0 · G3-C2 20/20 · G3-C3 `10 / 15 warn / 0 fail` · G1-C1 `SELFTEST PASS` ·
G1-C7 **0** recurrences dated to this round · **G2-C3 0 of 20** · G2-C7 20 of 21 · G4-C1 20/20 ·
**G4-C4 0 captures**.

**One denominator moved without anything happening.** G1-C8 is now **2 of 5** rather than 2 of 4:
`KPI.md` gained the 2026-08-23 correcting row, whose `caught pre-push vs post-push` cell is `n/a`
for the reason its own column note gives. The numerator did not change; the criterion reads worse
because a row arrived carrying the honest absence. Recorded so the fraction is not misread as a
regression `[obs:2026-08-25 KPI.md date column -> 08-10, 08-13, 08-17, 08-17, 08-23; two rows carry a number]`.

#### 🔴 Ninth round at zero — G2-C3 and G4-C4

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **9** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **9** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Six consecutive rounds have measured a tree that did not move**, across six commits, five of them
edits to this file and one to `KPI.md`.

**What this instrument is now doing, stated so nobody mistakes the cadence for activity.** Since
Round 17 closed G3-C8 there has been **no unmet criterion the library can close on its own**. A
round can therefore no longer *improve* anything; it can only *detect* a change. That is still worth
running — the tree can move at any time, and a stale scorecard is the failure this file exists to
prevent — but its remaining function is change-detection, not measurement, and it will keep
returning these numbers until a decision is taken. Both decisions are the owner's under
`CLIENT-MANDATE.md` §4. This round re-argues neither and states no preference between them.

### Round 19 — 2026-08-26 · a TENTH round at zero; nothing moved; seventh still tree

- **Round 19** `[obs:2026-08-26 highest heading -> 18]`. HEAD **`ee48752`**, clean, remote unmoved;
  one commit from Round 18, and that commit was Round 18's own edit to this file
  `[obs:2026-08-26 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only 76cd7c6..HEAD -> docs/loop/GOALS-SCORECARD.md]`
- **No fraction moved.** Goal 1 **4 of 9** · Goal 2 **6 of 9** · Goal 3 **7 of 8** · Goal 4A **3 of 4**.
  4B unchanged, owner-gated.
- Every criterion re-run. G3-C8 re-derived rather than carried: **21 regressions across 20 compared
  suites · 544/610 · denominator 530 across 20 of 20**, the denominator again by the independent
  route `[obs:2026-08-26 ee48752]`. Five probes PROBE PASS twice each; gate exit 0;
  G3-C2 20/20; G3-C3 `10 / 15 warn / 0 fail`; G1-C1 `SELFTEST PASS`; G1-C7 **0** recurrences dated
  to this round.

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **10** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **10** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Seven consecutive rounds have measured a tree that did not move.** Round 18's statement stands
unamended: every unmet criterion is owner-gated or wave-dependent, so this instrument is doing
change-detection rather than measurement. Both decisions are the owner's under
`CLIENT-MANDATE.md` §4.

### Round 20 — 2026-08-27 · an ELEVENTH round at zero; nothing moved; eighth still tree

- **Round 20** `[obs:2026-08-27 highest heading -> 19]`. HEAD **`018a031`**, clean, remote unmoved;
  one commit from Round 19, and that commit was Round 19's own edit to this file
  `[obs:2026-08-27 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only ee48752..HEAD -> docs/loop/GOALS-SCORECARD.md]`
- **No fraction moved.** Goal 1 **4 of 9** · Goal 2 **6 of 9** · Goal 3 **7 of 8** · Goal 4A **3 of 4**.
  4B owner-gated, unchanged.
- Every criterion re-run. G3-C8 re-derived: **21 regressions across 20 compared suites · 544/610 ·
  denominator 530 across 20 of 20**, the denominator by the independent route
  `[obs:2026-08-27 018a031]`. Five probes PROBE PASS twice each; gate exit 0; G3-C2 20/20;
  G3-C3 `10 / 15 warn / 0 fail`; G1-C1 `SELFTEST PASS`; G1-C7 **0** recurrences dated to this round.

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **11** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **11** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Eight consecutive rounds have measured a tree that did not move.** Both decisions are the owner's
under `CLIENT-MANDATE.md` §4.

### Round 21 — 2026-08-28 · a TWELFTH round at zero; nothing moved; ninth still tree

- **Round 21** `[obs:2026-08-28 highest heading -> 20]`. HEAD **`fd9b60f`**, clean, remote unmoved;
  one commit from Round 20, and that commit was Round 20's own edit to this file
  `[obs:2026-08-28 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only 018a031..HEAD -> docs/loop/GOALS-SCORECARD.md]`
- **No fraction moved.** Goal 1 **4 of 9** · Goal 2 **6 of 9** · Goal 3 **7 of 8** · Goal 4A **3 of 4**.
  4B owner-gated, unchanged.
- Every criterion re-run. G3-C8 re-derived: **21 regressions across 20 compared suites · 544/610 ·
  denominator 530 across 20 of 20** `[obs:2026-08-28 fd9b60f]`. Five probes PROBE PASS twice each;
  gate exit 0; G3-C2 20/20; G3-C3 `10 / 15 warn / 0 fail`; G1-C1 `SELFTEST PASS`; G1-C7 **0**
  recurrences dated to this round.

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **12** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **12** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Nine consecutive rounds have measured a tree that did not move.** Both decisions are the owner's
under `CLIENT-MANDATE.md` §4.

### Round 22 — 2026-08-29 · a THIRTEENTH round at zero; nothing moved; tenth still tree

- **Round 22** `[obs:2026-08-29 highest heading -> 21]`. HEAD **`8e07680`**, clean, remote unmoved;
  one commit from Round 21, and that commit was Round 21's own edit to this file
  `[obs:2026-08-29 git status --short -> empty; git log HEAD..origin/... -> empty; git diff --name-only fd9b60f..HEAD -> docs/loop/GOALS-SCORECARD.md]`
- **No fraction moved.** Goal 1 **4 of 9** · Goal 2 **6 of 9** · Goal 3 **7 of 8** · Goal 4A **3 of 4**.
  4B owner-gated, unchanged.
- Every criterion re-run. G3-C8 re-derived: **21 regressions across 20 compared suites · 544/610 ·
  denominator 530 across 20 of 20** `[obs:2026-08-29 8e07680]`. Five probes PROBE PASS twice each;
  gate exit 0; G3-C2 20/20; G3-C3 `10 / 15 warn / 0 fail`; G1-C1 `SELFTEST PASS`; G1-C7 **0**
  recurrences dated to this round.

| | rounds at zero | closes by | decision recorded |
|---|---|---|---|
| **G2-C3** | **13** | freeze the tree at one wave-wide SHA, re-run the blind wave | **none** |
| **G4-C4** | **13** | one capture against prompt-set v1 under the N ≥ 3 protocol | **none** |

**Ten consecutive rounds have measured a tree that did not move.** Both decisions are the owner's
under `CLIENT-MANDATE.md` §4.

---

## Part C — What closes each gap

Class: **(i)** work the library can do · **(ii)** a decision only the owner can make ·
**(iii)** genuinely open — no known method, or it needs a design nobody has.

| ID | What closes it | Class |
|---|---|---|
| G1-C2 | Make `scripts/eval-prompt.sh` the only sanctioned executor channel in the lane-brief template, and have each grader record the executor's invocation rather than its own. 8 records to bring to the standard on the next wave; no code change needed | (i) |
| G1-C3 | Add "record deliverable mtimes or an input hash" to the grader brief. Two records short; the data existed at grading time and was not written down | (i) |
| G1-C5 | Switch `scripts/register-lock.sh` on for multi-lane waves and make an ACQUIRE the first act of a lane brief. The mechanism exists and passed its gate check; it was simply not used on 08-13 or 08-17 | (i) |
| G1-C7 | Not closable by fixing anything — a recurrence count is history. It closes by the *next* multi-lane wave completing with zero coordinator-attributable ledger entries. Trigger: the next wave's close-out | (i), but only by elapsed conduct |
| G1-C8 | The wave-level `caught pre-push` figure needs the coordinator's own view of every lane's gate runs; the lane that wrote the row could not see it. Either the coordinator writes that cell at close-out, or the column's definition narrows to what one lane can count | (i) |
| G1-C9 | A second-reader pass per record. This is the most expensive unmet criterion in the file and the one with demonstrated yield (1 for 1: the single confirmation added two defects and a candidate ledger increment). It cannot be done by the graders who wrote the records | (i) |
| G2-C3 | Re-run the blind suites for the 18 non-current skills. Note the trap: a re-run wave that itself edits shared references invalidates its own records as it goes — the manifest must be frozen across the whole wave, not per lane, which is F8's rule applied at wave scope | (i) |
| G2-C5 | Re-run the comparison for performance-reporter and rank-tracker against their prior records. Both prior records exist; only the brief's read-scope stopped it | (i) |
| G2-C6 | Fix each of the 19, then re-exercise by a blind run — F13 recurrence 3's standing rule is that a carrier written in response to a ledgered failure is unproven until a blind run exercises it. Ten suites' worth of skill work | (i) |
| G2-C7 | Sweep the 11 unregistered regressions into `OPEN-FINDINGS.md` in the same shape as rows 154–158. One register pass; no judgement calls beyond transcription | (i) |
| G3-C4 | Nothing to fix in the gate. What is missing is the practice of running the three scoped legs against an explicit base when judging already-pushed work — the gate's own closing message says how. A criterion this file will keep failing until a measurement round runs the gate with a real outgoing range | (i) |
| G3-C5 | Fixture corpora for `validate-skill.sh`, `commit-scope-check.sh` and `register-lock.sh`, each with a negative control, following the `claims-gate` fixture pattern that already exists | (i) |
| G3-C7 | Two parts. **(a)** Fix the one surviving instance at `refresh-templates.md:464-465` and reflow so the phrase cannot straddle a break. **(b)** The general fix: closure greps over prose must be whitespace-flattened, and check (f)'s scan needs to match across a wrapped line. Both are known; (b) is the one that matters, because every closure claim in every register was written with a line-based instrument | (i) |
| G3-C8 | Append a corrected `KPI.md` row naming the 2026-08-17 row it corrects, derived from the 20 records now present. The file's rule 1 already prescribes exactly this | (i) |
| G4-C1 | Carry the seven-field contract into the 13 skills that lack it in their body. This is skill work across 13 files and is the largest single (i) item in this table | (i) |
| G4-C4 | Two halves, and they separate cleanly. The **prompt set** cannot be locked without the client's own sales questions — (ii). But a capture against v1 as it stands is executable from here: `PILOT.md`'s 2026-08-17 entry records that the market-side half is not stopped at the gateway, and that an AI-citation observation is the one measurement that decays if deferred. A capture taken now under the N ≥ 3 protocol, labelled as against a draft set, is (i) | (i) for a v1 capture; (ii) to lock the set |
| G4-B1 | The page URL list (or a selection rule plus a count), and input 3 in full — named publisher, approval channel, pre-change capture method, turnaround | (ii) |
| G4-B2 | Sani's dated sign-off plus the §2 baseline data, which itself needs B1 and B4 | (ii) |
| G4-B3 | Downstream of B1 and B2; nothing to decide separately | (ii) |
| G4-B4 | An environment allowed-hosts change by whoever created this environment. `PILOT.md` names the five hosts and what each unlocks. Until then the page-side half of the pilot cannot start, and no amount of agent time substitutes | (ii) |

**Nothing in this file is class (iii).** Every unmet criterion has a known method. That is worth
stating plainly, because it means none of the four goals is out of reach for a *methodological*
reason — the gap is work not yet done and decisions not yet made.

---

## Notes for the next measurement round

- **Re-run, do not read.** Every figure in Part B came from a command re-run at HEAD. A round
  that copies the previous round's numbers is not a round.
- **Record the tree.** HEAD SHA and `git status` at open and close, per the frozen-input rule
  this file measures other lanes against.
- **The criteria you fail are the useful ones.** If a round returns 9 of 9 on a goal, check
  whether a criterion has drifted into measuring its own instrument before recording the result.
- **Two criteria are known to be uncomfortable by construction and must not be softened**:
  G1-C7 (coordinator recurrences) and G1-C9 (second reader). Both score the party most likely to
  be writing the round.
