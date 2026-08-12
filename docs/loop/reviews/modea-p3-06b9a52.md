# MODE A — ADVERSARIAL DIFF REVIEW, PASS 3

**Repo**: `/Users/georgefinetis/seo-geo-claude-skills-georgefin` · branch `section-b`
**Frozen target**: `06b9a52506ec1fbe4600abb6f6c6b722712cc880` — confirmed at open **and** at close.
**Scope reviewed**: `git diff f2c6b10..06b9a52` (14 files) + the surrounding skills.
**Gate run**: `scripts/validate-skill.sh` on all four touched skills; `scripts/validate-tracking.sh`; `scripts/commit-scope-check.sh` (read first, R291).

---

# VERDICT: **BLOCK**

One BLOCK-class violation: **F9 recurrence 5**, committed inside the commit whose entire subject is *"F9 sweep my own F5 repair skipped"*. Per charter this is a BLOCK on its own and is not averaged against the four claims that verified clean.

Three of the five commit-message claims I was asked to test verify **TRUE**. One verifies **FALSE** (the sweep count). One verifies **substantively true but with a non-reproducing citation**.

---

## SCOPE CORRECTION (before the findings)

The task states *"14 files across commits `98d309a`, `8c94d04`, `a9fbd7c`, `06b9a52`"*. The range contains **five** commits:

```
06b9a52  18:58:25   F9 sweep my own F5 repair skipped
a9fbd7c  18:34:16   Mode A F5 — the client fence was shipping its own scoring derivation
8c94d04  18:33:16   Mode A F2/F3/F6
98d309a  18:30:41   clear Mode A B1 + B2
cb665a5  18:09:30   contrastive lane refuted the R3 candidate — rewritten, §2 withdrawn   ← NOT NAMED
```

`cb665a5` contributes the single largest file change in the diff — `docs/loop/pilot/r3-supersession-candidate.md`, **325 lines, 152 insertions / 173 deletions**, i.e. a near-total rewrite of a gate-routed supersession candidate. I reviewed it as part of primary scope. **It is clean and is the best artefact in the range** (see Non-blocking note N-6). Recording the mis-attribution because a briefing that names four commits and hands over five is exactly how a whole-file rewrite gets reviewed by nobody.

---

# BLOCKING

## B-1 — F9 recurrence 5: the scoring method the sweep claims to have removed is still inside the client fence, in the sentence the sweep edited

**Rule violated**: `docs/loop/FAILURE-LEDGER.md:253` **F9** (guard: *"retiring or redefining any cross-skill concept requires a repo-wide grep sweep for the concept's tokens … with the hit list resolved or explicitly queued"*), most recently at `FAILURE-LEDGER.md:1430` **F9 Recurrence 4** (*"a class fixed where it was noticed is a class not fixed"*).

**The claim under test** (`06b9a52`):
> "All seven now swept. Only SKILL.md:124 remains — a field DESCRIPTION ("Impact (weighted points at stake)"), not an instruction to compute."

**This is false.** My own repo-wide sweep — run on four independent token families (`weighted point`, `potential gain`, `recoverable points` / `10 from Fail` / `5 from Partial`, `multiplication|multiply`) — returns two live loci the commit does not account for, both **inside a client report fence**.

### (a) `cross-cutting/domain-authority-auditor/SKILL.md:295-298`

Fence boundaries verified: the client report fence opens at `:259` (` ```markdown ` after *"Calculate scores and generate the final report:"*) and closes at `:336`. Lines 295–298 are inside it:

```
Sorted by: weight × points lost (highest impact first). Potential gain = recoverable points
(10 from Fail, 5 from Partial) weighted by that dimension's share. Print the RESULT only —
the multiplication is scoring method and belongs in the operator block, never in the client
fence (Output Validation, first checkbox).
```

Three separate problems, all chargeable:

1. **The method survives.** The operands (`10 from Fail, 5 from Partial`) and the operation (`weighted by that dimension's share`) are both still there. The dimension weights are printed in the report's own Dimension Scores table. Every `+[X] points on the CITE score` cell the commit sanitised is therefore still fully reconstructible — **which is the exact test the coordinator himself applied in B-2 to condemn `example-report.md:52-53`**: *"I removed the method's OUTPUTS and left the METHOD two lines above them … from which every cell I sanitised is reconstructible. Removed."* Here the method sits **five lines above** the outputs, in the sentence he was editing, and was not removed. This is item #2 on his own seven-item list.

2. **The newly added text is itself the banned construct.** `06b9a52` added two net lines here (`8 +++++---` = 5 ins / 3 del). The added sentence *"the multiplication is scoring method and belongs in the operator block, never in the client fence (Output Validation, first checkbox)"* is a **scoring-method instruction, plus an internal apparatus pointer**, placed inside the client report fence. The skill's own first Output Validation checkbox — `cross-cutting/domain-authority-auditor/SKILL.md:358` — bans exactly that:

   > "no skill slug, command slug, internal file path or **scoring-method instruction** appears inside the client report fence — a reader who copies only a fence must be able to tell whose it is"

   That checkbox is the one `a9fbd7c` invoked to justify the F5 fix in the first place (*"the SIBLING checkbox one line above bans 'scoring-method instruction' inside the client report fence absolutely"*). The repair breaches the rule it cites, in the fence it names.

3. **`SKILL.md:124` is not merely "exempt" — it is now stale.** The exemption reasoning (a field description, not an instruction to compute) is sound *as far as it goes*, and I do not dispute it. But `:124` reads **"Impact (weighted points at stake)"** while the templates it describes now read `+[X] points on the CITE score` (`:301`, `:305`) and `+[X] points on the overall score` (`content-quality-auditor/SKILL.md:281`). The line no longer describes its own templates. Leaving it needed a different justification from the one given.

### (b) `cross-cutting/domain-authority-auditor/references/example-report.md:44-47`

Fence boundaries verified: client fence opens `:14`, closes `:102`. Lines 44–47 are inside it:

```
**Score Calculation**:
- Dimensions from their item tallies (all 40 items scored, no N/A): C = 4×10 + 6×5 = 70 · I = 3×10 + 5×5 = 55 · T = 6×10 + 4×5 = 80 · E = 5×10 + 3×5 = 65
- CITE Score = 70 × 0.40 + 55 × 0.15 + 80 × 0.20 + 65 × 0.25 = 28.0 + 8.25 + 16.0 + 16.25 = 68.5 → **68.5/100 (Medium)**
- Points on the table: 400 raw points available, 270 scored, 130 lost — 18 Pass + 18 Partial + 4 Fail = 40 items, so lost = 18×5 + 4×10 = 130
```

This publishes, inside the client fence, **the per-grade point values (10 / 5 / 0) and all four dimension weights** — the complete method — **ten lines above** the Top 5 that `a9fbd7c` sanitised. The F5 repair is therefore cosmetic in the skill's own cited complete example: a reader who copies the fence gets the derivation anyway.

The coordinator knows this locus exists — he raised it as OPEN-FINDINGS **#82**. But he excluded it from the sweep and then stated a residual of exactly one. **A known hit excluded from the count without being declared is the F9 signature**, not a philosophical question: F9's guard says the hit list is *"resolved or explicitly queued"* — queuing it in #82 is fine, **omitting it from "only :124 remains" is not.**

**Net**: the residual is at minimum **three** (`SKILL.md:124`, `SKILL.md:295-296`, `example-report.md:44-47`), not one, and two of the three are inside client fences. Increment F9 to **recurrence 5**.

---

# CLAIM-BY-CLAIM VERIFICATION

| # | Claim | Verdict | Evidence |
|---|---|---|---|
| 1 | `06b9a52`: "All seven now swept. Only SKILL.md:124 remains." | 🔴 **FALSE** | See B-1. Residual ≥ 3; two inside client fences. The seven he *did* sweep all verify swept — `example-report.md:75`, `SKILL.md:296/299/303`, `content-quality-auditor/SKILL.md:281`, `item-reference.md:92/98`. The count of what remains is what is wrong. |
| 2 | `06b9a52`: "the paired gate a877786 claims exists nowhere in the repo (`grep -rl must_absent` -> zero files)" | 🟡 **substance TRUE, citation FALSE** | See FIX-1. Substance independently confirmed three ways. The stated grep returns **one** file at HEAD. |
| 3 | `8c94d04`: F2 coverage "base 1 -> HEAD 0", restored 27 → 28, "deleting the feature cannot pass" | 🟢 **TRUE, all three parts** | Counted by parsing the JSON, not by eye: `f2c6b10` = **27**, `06b9a52` = **28**. Coverage: pre-`eaccaf8` e1.6 carried `([item IDs])` — **1** occurrence; at `f2c6b10` the whole suite has **0** occurrences of `item ID` **or** `operator block`; at HEAD, **4**. **R297 counter-test present and real**: the new e1.7 asserts positive presence (*"Operator block present … carrying items checked and graded by dimension with their IDs, failing veto items by ID … and the explicit disclaimer"*) **and** names absence as a FAIL (*"OR the operator block being absent altogether"*). Deleting the feature fails. |
| 4 | `8c94d04`: fence detector is 755 and "documents its true scope"; dead `check()` removal orphaned nothing | 🟡 **2 of 3 TRUE** | **Mode**: `-rwxr-xr-x`, `755` — matches all 13 siblings. ✅ **Orphans**: `check()` and `blocks()` are both gone; `confirm()` inlines its own fence walk; no caller anywhere. ✅ **Scope**: the docstring's *signature* scope matches the code line-for-line (`(a)`→ code `:28`+`:32`, `(b)`→ code `:33`). But it documents **only the signature, not the corpus** — see FIX-2. |
| 5 | `98d309a`: reanchor run, "6 re-anchored, 0 refused, validate-tracking back to 9 passed / 0 failed" | 🟢 **TRUE** | Re-ran `bash scripts/validate-tracking.sh .` with **`$?` read directly, never through a pipe** (R297): **exit code 0**, `Results: 9 passed, 8 warnings, 0 failed`, `grep -c FAIL` = 0. Re-anchor count verified: exactly **6** changed pointer occurrences. `git diff --word-diff` over `SETTLED-RULINGS.md` + `GATED-ITEMS.md` returns **only** `VERSIONS.md:259→277`, `:225→243` ×3, `:229→247`, `:230→248` — **zero ruling text touched**, exactly as the commit claims. |

---

# NON-BLOCKING — ORDERED FIX LIST

### FIX-1 — the `must_absent` grep does not reproduce; third consecutive commit message false about its own diff
`06b9a52` offers *"`grep -rl must_absent` -> zero files"* as the reproducible evidence for an **absence claim**. Re-run at HEAD:

```
$ grep -rl must_absent .
docs/loop/OPEN-FINDINGS.md
exit=0
```

**One file, not zero** — because the same commit's own diff wrote the token into `docs/loop/OPEN-FINDINGS.md`. The measurement was already false at the moment it was written.

**I verified the substance independently and it holds** (which is why this is FIX, not BLOCK): `git log -S'must_absent' --all` → only `06b9a52`; `git grep -l must_absent` across all reachable revs → only `06b9a52:docs/loop/OPEN-FINDINGS.md`; a case/separator-variant regex over the untrimmed tree → same single hit; `a877786`'s own diffstat adds no script. **No paired-gate harness has ever existed in this repository.** The R195 grounding is adequate — `grep -r` from the repo root respects no ignore file and so searches *wider* than git, and the commit is honest that the harness lived in a scratchpad.

**Why it still matters, and the recommendation.** Both prior BLOCKs were issued for a commit message false about its own diff. This is the third instance, and it is being **re-discovered by review every round rather than guarded**. `F16` does not cover it (the record here is durable — it is in OPEN-FINDINGS). `F11` does not cover it (this is not an inference inside a verified frame). **The class has no ledger entry.** Open one, or the fourth instance costs another review round. Fix in-place: replace the grep with one that reproduces, e.g. `git log -S'must_absent' --all` → `06b9a52` only.

### FIX-2 — the fence detector documents its signature scope and hides its corpus scope, in a docstring that cites F15-r1
`scripts/check-template-fences.py:54-55`:

```python
targets = [q for q in sorted(glob.glob('**/*.md', recursive=True))
           if '.git' not in q and not q.startswith('docs/')]
```

Measured: repo has **224** `.md` files; the default run scans **205**. The 19 skipped are undocumented:

* **14 dropped by `not q.startswith('docs/')`** — the entire `docs/loop/` tree including `SETTLED-RULINGS.md`, `FAILURE-LEDGER.md`, `OPEN-FINDINGS.md`, `PILOT.md`, `PIPELINE.md` and `pilot/r3-supersession-candidate.md` (which contains ` ```markdown ` blocks).
* **5 dropped silently by Python `glob`**, which does not match dot-directories: all four `.claude/agents/*.md` (**including `skill-reviewer.md`, the file that defines this review**) and `.github/PULL_REQUEST_TEMPLATE.md`.

`'.git' not in q` is also a **substring test on the whole path**, not an anchored one — precisely the shape CRITICAL.md R297 names (*"a substring match against a namespace you don't own is not a test … anchor on the thing's own label"*). It currently bites nothing only because `glob` already dropped the dot-dirs; it is a latent trap the moment anyone switches to `pathlib.rglob` or `find`.

The docstring's own closing line is *"F15-r1: an undocumented scope gets read as total."* An undocumented **corpus** exclusion is the same failure as an undocumented **signature** exclusion. `OPEN-FINDINGS.md:80` quotes *"GREEN, 205 files scanned, exit 0"* — the 205 is printed, but nothing anywhere says what the other 19 are.

### FIX-3 — normative skill text changed with no version bump and no changelog row
`06b9a52` rewrote normative template text in **two** SKILL.md files and a reference; `a9fbd7c` rewrote a third reference. Versions are **unchanged from `f2c6b10`**:

| file | `f2c6b10` | HEAD |
|---|---|---|
| `cross-cutting/domain-authority-auditor/SKILL.md` | `version: "4.4.0"` | `version: "4.4.0"` |
| `cross-cutting/content-quality-auditor/SKILL.md` | `version: "4.5.0"` | `version: "4.5.0"` |

No `VERSIONS.md` row was added by any of the four commits. This breaches `CLAUDE.md:88` (*"After updating a skill: update all 5 tracking files"*) and the coordinator's own documented practice — `f7c7610`'s message explicitly records *"content-quality-auditor 4.4.0 -> 4.5.0, domain-authority-auditor 4.3.2 -> 4.4.0"* for a comparable edit. **`validate-tracking` cannot catch this**: it checks that the three version carriers *agree with each other*, never that a bump *happened*. Registry rows at `VERSIONS.md:27-28` still read `4.5.0 / 2026-08-11` and `4.4.0 / 2026-08-11`.

### FIX-4 — `VERSIONS.md:97` now describes a behaviour the tree no longer has
The v4.2.0 changelog bullet lists among that release's fixes: *"**the gain multiplication shown in the Top 5 template**"*. At HEAD, `SKILL.md:296-298` forbids exactly that. A changelog entry about a past release is legitimately historical, so this is not a falsification on its own — but with FIX-3 (no new entry recording the reversal) the register set now asserts, with nothing contradicting it, that the current template shows the multiplication. One line in the next changelog entry closes it.

### FIX-5 — `domain-authority-auditor/SKILL.md` is one line from a hard gate failure
Body (post-frontmatter) = **349** lines against `validate-tracking` check (d)'s hard cap of **350** (`scripts/validate-tracking.sh:299`). `06b9a52` took it from 347 → 349. Not a defect now; the next two-line insertion turns a WARN into a FAIL. Flagging because the wave's direction of travel on this file is additive.

---

# CARRIED FORWARD FROM PASS 2

## FIX #9 — stale un-anchored register pointers: the FULL list

Pass 2 sampled 5 and found 2 wrong. Here are **all 35**, machine-extracted with the same pointer grammar `validate-tracking` check (g) uses, then each one resolved against its target. Check (g) *warns* on these and explicitly **does not fail them** (`validate-tracking.sh:552`), so the gate is green with all of them in the tree.

**Result: 18 wrong / 15 correct / 2 structurally unresolvable.** A sample of 5 was not the shape of this problem — **more than half are wrong.**

### ❌ WRONG — 18

| Register | → pointer | Target actually says | Should be |
|---|---|---|---|
| `SETTLED-RULINGS.md:125` | `build/schema-markup-generator/SKILL.md:223` | `2. **Schema.org Validator**` | R3's FAQ-retirement encoding is elsewhere |
| `SETTLED-RULINGS.md:156` | `references/cite-domain-rating.md:447` — labelled *"(I09 measurement)"* | `\| I07 Cross-Platform Consistency \|…` | resolves to **I07**, not I09 |
| `GATED-ITEMS.md:263` | `CLAUDE.md:58` — cited as mandating the `version` field | Tool-Connector rule 3, *"No tool and no data →…"* | `CLAUDE.md:85` |
| `GATED-ITEMS.md:264` | `CONTRIBUTING.md:40` — same claim | the `description:` line of the frontmatter template | the `metadata:` block, `:44+` |
| `GATED-ITEMS.md:268` | `CLAUDE.md:59` | **blank line** | `CLAUDE.md:85` |
| `GATED-ITEMS.md:277` | `CLAUDE.md:58-59` | wrong section + blank | `CLAUDE.md:85` |
| `GATED-ITEMS.md:614` | `gap-analysis-frameworks.md:150` | a table separator row `\|---\|---\|` | the HowTo row |
| `GATED-ITEMS.md:615` | `ctr-and-social-reference.md:121` | **blank line** | the HowTo CTR row |
| `GATED-ITEMS.md:716` | `CLAUDE.md:49` | **blank line** | — |
| `WATCH-ITEMS.md:63` | `geo-content-optimizer/SKILL.md:140` | **blank line** | `:143` (*"Per-Engine Reality Check … ~11% … ≈40%"*) |
| `WATCH-ITEMS.md:64` | `ai-citation-patterns.md:467-470,474,491` | `:467-470` are engine-comparison table rows (Freshness bias / Authority weight / Structure importance / Citation count) — not the ~11% / ≈40% claim | — |
| `WATCH-ITEMS.md:101` | `entity-optimizer/SKILL.md:185` — cited for the **review-solicitation policy** | the *"Measuring category 5 mentions"* note | the next block |
| `WATCH-ITEMS.md:135` | `ai-citation-patterns.md:476` — cited for the **2026-05-06 quote-preview announcement** | a `[VERIFY]` source note for the comparison table | **`:491`** (verified: that is where the announcement is) |
| `WATCH-ITEMS.md:167` | `references/greek-tourism-seasonality.md:24` | no such path | file is at `research/serp-analysis/references/greek-tourism-seasonality.md` |
| `WATCH-ITEMS.md:210` | `gap-analysis-frameworks.md:150` | table separator | same as GATED:614 |
| `WATCH-ITEMS.md:211` | `ctr-and-social-reference.md:121` | **blank line** | same as GATED:615 |
| `PIPELINE.md:49` | `CLAUDE.md:62` — cited for branch naming `feature/… fix/… docs/…` | `## The Value Rule (binding, ruled 2026-08-10)` | **`CLAUDE.md:89`** |
| `PIPELINE.md:50` | `CLAUDE.md:61` — cited for the 5-tracking-file sync | **blank line** | **`CLAUDE.md:88`** |

### ⚠️ STRUCTURALLY UNRESOLVABLE — 2
`GATED-ITEMS.md:722` → `` `SKILL.md:258` `` (bare basename, no repo path — resolves to nothing) · `WATCH-ITEMS.md:69` → `` `ai-citation-patterns.md:476` `` (bare basename; `:135` carries the full path for the same target, and is itself wrong)

### ✅ CORRECT — 15
`SETTLED-RULINGS.md:138` (`kpi-definitions.md:300-306` → *"### Core Web Vitals"* table) · `:142` (`technical-seo-checker/SKILL.md:259` → CWV audit step) · `:155` (`cite-domain-rating.md:309-310` → *"I09: Unlinked Brand Mentions"*) · `GATED-ITEMS.md:613` (`serp-feature-taxonomy.md:30` → the Rich Results / How-To row) · `:729`, `:741` (both `VERSIONS.md:3`) · `WATCH-ITEMS.md:83`, `:163`, `:176`, `:178`, `:199`, `:266`, `:288`, `:292` · `PIPELINE.md:17`

**Systemic reading, not a list of typos.** The wrong ones cluster hard: **every pointer into root `CLAUDE.md` is wrong** (6 of 6 — the file has been restructured and nothing followed), and **every pointer that resolves to a blank line or a table separator** (7) is a line-shift, which is precisely the F12 mechanism `scripts/reanchor-pointers.sh` exists to repair. The tool cannot help these because **an un-anchored pointer carries no token to grep** — `reanchor-pointers.sh` only fixes `file:line ("token")` form. The durable fix is to anchor-tag all 35 and let the fixer run; anchoring is the work, re-anchoring is then free forever.

## FIX #10 — the 4 eval expectations still requiring the retracted R3 rationale

The retracted clause (amendment 9a) is *"FAQPage's value is AI-engine/GEO parsing"*. Four suite surfaces still **require** an executor to assert it. All four are **base-present** — none is chargeable to this wave, and none was touched by `f2c6b10..06b9a52`.

| # | Location | Exact text | Introduced by | Base-present? |
|---|---|---|---|---|
| 1 | `build/schema-markup-generator/evals/evals.json` — **eval 3 `expected_output`** | *"…the markup's remaining value is **AI-engine/GEO parsing** (answer engines extract clean Q&A pairs)"* | `2054b94` | **YES** — present on `main` (`3f22f23`) |
| 2 | `build/schema-markup-generator/evals/evals.json` — **e3.8** | *"…frames the markup's remaining value as **AI-engine/GEO parsing** (answer engines extracting clean Q&A pairs)"* | `2054b94` | **YES** — present on `main` |
| 3 | `monitor/alert-manager/evals/evals.json` — **e2.3** | *"…does NOT extend the retirement into advising removal of FAQPage markup itself (**its AI-engine/GEO parsing value stands per the house ruling**)"* | `e3cc7dc` (founding E4 suite) | pre-wave branch history; **0 on `main`, 1 at `f2c6b10`** |
| 4 | `optimize/technical-seo-checker/evals/evals.json` — **e5.4** | *"…framed exactly as the worked example frames it — **AI-engine/GEO parsing value** with no SERP promise"* | `3730ad4` (founding E3 suite) | pre-wave branch history; **0 on `main`, 1 at `f2c6b10`** |

**#3 is the sharpest of the four**: it does not merely repeat the retracted rationale, it attributes it — *"per the house ruling"* — to the very ruling that disowned it. That is the `F9 Recurrence 4` signature verbatim (*"a skill citing a ruling for a claim that ruling had just disowned"*), surviving in a **grading** surface rather than a shipped one, which is worse: it rewards the retracted claim on every future run.

For contrast, `content-refresher` e1.2 / e2.4 / e3.6 all **negate** it correctly (*"no AI-parsing benefit is claimed for it"*, *"R3's rationale clause was retracted by amendment 9a"*). The remediation wording already exists in-repo and can be lifted.

---

# THE TWO DELIBERATELY-OPEN ITEMS — judged, not fixed

## #81 — is leaving the relaxation standing in the tree correct?

**No — not as it currently stands.** The defect is not *that* it stands pending a ruling; it is that it stands **unmarked**, which is a state the coordinator himself ruled insufficient **in this same wave**.

The facts check out. `f7c7610` (17:55:59) split the flat ban into a permissive pair; `a9fbd7c` (18:34:16) cited it as proof of compliance. **Gap = 38m17s** — the finding's own figure is accurate. And the contradiction is real and verbatim: `references/inter-skill-handoff.md:241` reads *"A framework **item ID** and a **skill slug** are never exempt, in any language."* while `domain-authority-auditor/SKILL.md:359` states the exemption **and cites that same file in the same sentence** (`[inter-skill-handoff.md § 3.4](../../references/inter-skill-handoff.md)`). The tree currently carries a skill that points at its carrier and contradicts it in one breath, with **no marker on either side** saying the point is contested.

**The decisive comparison is internal.** `8c94d04`'s F6 fix, committed 61 seconds before `a9fbd7c`, established the standard for exactly this situation:

> "all four REFUSED decisions were live in the files with zero markers, so a model picks a side silently … Each now carries an in-file `⚠️ UNRESOLVED — owner ruling owed` note **at the point of use**, naming both sides and ending 'until it is ruled, cite the row you used'."

He applied that remedy to `alert-manager`'s four refusals (verified live at `alert-threshold-guide.md` ×3 and `alert-configuration-templates.md` ×1). He did **not** apply it to #81 — the one contested item where **he authored the contested side**. The inconsistency runs in the direction that favours his own edit, which is the R71 problem stated structurally.

**Answer**: the tree should carry the **documented cross-skill rule** (`inter-skill-handoff.md:241`), with the relaxation granted deliberately afterwards if the ruling goes that way. Failing that, the **minimum** acceptable pending state is the coordinator's own remedy — an in-file `⚠️ UNRESOLVED — owner ruling owed` marker at `SKILL.md:359` **and** at `inter-skill-handoff.md:241`, naming both sides. The current unmarked state is the only option that is definitely wrong, because it is indistinguishable from a settled relaxation to every future reader. Note also that neither the exemption nor its contradiction is graded by any eval in either auditor suite — so nothing would surface it if the ruling never came.

## #82 — is "move the derivation to the operator block" compliance rather than relaxation?

**Yes. It is compliance with the rule exactly as written, it costs nothing, and it therefore does not need a ruling — say so and fix it.**

* The checkbox (`SKILL.md:358`) bans *"scoring-method instruction … inside the client report fence"*. `example-report.md:44-47` is inside the fence (`:14`–`:102`, verified). Moving it out satisfies the rule **literally**, with no reinterpretation of any word.
* The transparency counter-argument — which is the only thing that made this look like a dilemma — is **fully answered by the destination**. The operator block's own label reads: `<!-- OPERATOR BLOCK — for the client's team, not part of the report above …` (`example-report.md:121`). **The client's own team still receives the derivation.** Nothing is withheld from anyone; only the fence boundary changes.
* A ruling is only required for the *other* candidate resolution — *"the checkbox is over-broad"* — and nobody needs that resolution, because resolution (1) loses nothing. The finding's framing (*"picking the second would be relaxing a rule to fit an artifact"*) is correct about resolution (2) and is the reason to simply take resolution (1).

**Two things to carry into that fix**, both from B-1: the same move is owed at `SKILL.md:295-296`, and until `:44-47` moves, the `a9fbd7c` F5 repair has no effect on what a fence-copier receives.

---

# `scripts/pre-push-gate.sh` — the F14 failure needs **no** history rewrite and **no** exception

**R291 discharged first**: I read `scripts/commit-scope-check.sh` in full before invoking it and confirmed it is read-only — its only external calls are `git log`, `git rev-list`, `git diff-tree`, `git rev-parse`, plus `grep`/`sed`/`tr`/`sort`/`printf`. No write path, no flag parsing that could fail open.

**Root cause: a misconfigured upstream, not bad history.**

```
$ git rev-parse --abbrev-ref '@{upstream}'
origin/claude/scheduled-skills-web-search-8zaz3j     ← unrelated branch, 17 commits behind

$ git branch -avv | grep section-b
  remotes/origin/claude/section-b-fixes-2026-08-11   06b9a52   ← identical to HEAD
```

`commit-scope-check.sh` takes no base arg from `pre-push-gate.sh` (deliberately — `pre-push-gate.sh:65-69`) and resolves `@{upstream}`. Because the upstream points at an unrelated branch, **17 already-pushed commits are treated as outgoing** and 10 of them fail.

**Proved both directions** (R297 — the check goes RED and GREEN for the right reason):

```
$ bash scripts/commit-scope-check.sh                                        # current upstream
EXIT=1 — 10 commit FAILs (a9fbd7c, 8c94d04, f2c6b10, f7c7610, 82d9db7,
         31cd464, 8234fae, e814827, fe6d62b, 8889ac3)

$ bash scripts/commit-scope-check.sh origin/claude/section-b-fixes-2026-08-11
PASS: no outgoing commits — nothing to check
Results: 1 passed, 0 warnings, 0 failed
EXIT=0
```

**This is the guard's own documented design, not a workaround.** `commit-scope-check.sh:23-25`:

> "Scope: same as claims-gate — outgoing commits only (`<base>...HEAD`). **Branch history that predates the guard is grandfathered by construction: once pushed, it is no longer outgoing.**"

Those 10 commits **are** pushed — `origin/claude/section-b-fixes-2026-08-11` is byte-identical to HEAD. They are outgoing only under a base ref that is factually wrong about where this branch lives.

**Recommendation**: `git branch --set-upstream-to=origin/claude/section-b-fixes-2026-08-11 section-b`. One command, no history touched, no allowlist, no documented exception, no base-commit floor to invent — the floor already exists and is simply pointed at the wrong branch. **Do not rewrite 10 pushed commits.**

⚠️ **The same mis-set upstream silently mis-scopes two more gate legs.** `claims-gate.sh` (`pre-push-gate.sh:62`) and `register-lock.sh gate-check` (`:81`) also resolve `@{upstream}` with no base arg, for the same stated reason. Whatever they have been reporting on this branch has been computed against the wrong base too. Re-run the whole gate after fixing the upstream before trusting any of its legs — including any leg that has been **passing**.

---

# GATE TALLY

`bash scripts/validate-skill.sh <skill>` — every skill touched by the diff:

| Skill | Result | Exit |
|---|---|---|
| `cross-cutting/content-quality-auditor` | 15 passed, 0 warnings, 0 failed | 0 |
| `cross-cutting/domain-authority-auditor` | 15 passed, 0 warnings, 0 failed | 0 |
| `monitor/alert-manager` | 15 passed, 0 warnings, 0 failed | 0 |
| `optimize/content-refresher` | 15 passed, 0 warnings, 0 failed | 0 |

**Totals: 60 passed / 0 warnings / 0 failed.** Contract integrity otherwise intact — frontmatter complete in both edited SKILL.md files, bodies within the 350-line cap (349 and 336, measured post-frontmatter as check (d) does), and the Reference Materials indexes match the files actually cited. The one contract gap the scripts structurally cannot see is FIX-3 (no bump on edit).

`bash scripts/validate-tracking.sh .` — **9 passed, 8 warnings, 0 failed, exit 0** (read directly, not through a pipe).

---

# NOTES THAT ARE NOT FINDINGS

* **N-6 — `cb665a5` is exemplary and should be held up as the standard.** The unnamed fifth commit rewrites its own prior conclusion after the contrastive lane refuted it, records **every** withdrawn claim in a table rather than deleting it (`§5`), states its negative control with the pre/post counts that prove the probe could go RED (`0/0/0/0` → `1/1/1/1`), corrects its own tally **against** its author's earlier position (3-supported → 9-supported), and closes with `§8 "Named, not skipped — what this round could not establish"`. It also self-reports the most damaging detail against itself (*"S2 contains zero occurrences of FAQ" is false at raw-HTML grade*). Nothing in it needs a fix. It is also the only commit in the range whose message I could not falsify on any point.
* **N-7** — the eval-baseline records at `docs/loop/eval-baselines/blind-2026-08-10/domain.json:82,175` still contain `weighted points` strings. These are **historical records of what a past run produced** and are correctly out of F9's scope; I checked them so the sweep is complete, not to charge them.
* **N-8** — `references/score-arithmetic.md` (both auditors) still carries the full derivation. That is the correct home for it and is exactly the destination `a9fbd7c` named. Not a finding.

---

# INPUT RE-CHECK AT CLOSE (charter requirement)

| | Open | Close |
|---|---|---|
| HEAD | `06b9a52506ec…` | `06b9a52506ec…` — **unchanged** |
| Working tree | clean | **clean** (`git status --porcelain` empty) |
| `docs/loop/SETTLED-RULINGS.md` | `b0270e4585ec9fbd61e93cc1949b0adb` | **identical** |
| `docs/loop/FAILURE-LEDGER.md` | `57bfcdbb550f5baf79c49ff9f41a11f7` | **identical** |
| `docs/loop/OPEN-FINDINGS.md` | `4ebd6fbc0793f3bdd38988302004978c` | **identical** |
| `references/inter-skill-handoff.md` | *(hashed at close only — my open-time path was wrong; tree clean + HEAD unchanged ⇒ no drift possible)* | `5c0429d382b04b0a3152037c750f6fdf` |

`git reflog` shows no ref movement during this review. **The concurrently-running contrastive-lane reviewer has edited nothing** — verified, not assumed. **No drift; no verdict is affected.**

I made no edits to any SKILL.md, reference, script or tracking file. All my artefacts are prefixed `modea-p3-` and confined to the scratchpad: `modea-p3-report.md`, `modea-p3-full-diff.txt`, `modea-p3-head-sha.txt`, `modea-p3-status-open.txt`, `modea-p3-input-md5-{open,close}.txt`, `modea-p3-validate-tracking.txt`, `modea-p3-pointer-audit.{py,txt}`.

---

## WHAT CLEARS THE BLOCK

1. Sweep `SKILL.md:295-296` — remove the operands and the operation from inside the client report fence, and move the new "belongs in the operator block" sentence **out** of the fence it forbids things in.
2. Move `example-report.md:44-47` to the operator block (this is #82, and it is compliance, not a ruling — see above).
3. Restate the residual honestly, or mark what stays with the reason it stays. `SKILL.md:124` also needs re-wording to match the templates it describes.
4. Mark #81 in-file with the coordinator's own `⚠️ UNRESOLVED — owner ruling owed` pattern, or revert to `inter-skill-handoff.md:241`.

FIX-1 through FIX-5 and both carried items should land in the same wave, since three of them (FIX-3, FIX #9, FIX #10) are register-wide and will otherwise be swept per-locus — which is the finding this review is about.
