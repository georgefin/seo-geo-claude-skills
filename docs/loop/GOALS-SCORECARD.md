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
