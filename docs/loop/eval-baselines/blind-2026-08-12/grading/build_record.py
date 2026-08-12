#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Companion record for the entity-optimizer blind run of 2026-08-12.
Written in the `summary` schema so scripts/eval-corpus-report.sh reads it once committed
under docs/loop/eval-baselines/blind-2026-08-12/entity.json."""
import json, os

OUT = "/private/tmp/claude-501/-Users-georgefinetis-Library-CloudStorage-Dropbox-Dropbox-docs-WEBSITES-eshop-sanihellas-gr-CLAUDE/5bbd7e38-3461-4d58-956c-5cd67d109b2e/scratchpad/blind-entity-2026-08-12"
grading = json.load(open(os.path.join(OUT, "grading.json"), encoding="utf-8"))

rec = {
  "suite": "entity",
  "skill": "entity-optimizer",
  "run": "2026-08-12 blind execute + INFORMED Mode B grade (split author/grader)",
  "method": (
    "Mode B split. A blind executor ran the five evals and saved e1-out.md … e5-out.md before any "
    "grading began. This grader wrote none of them and NEVER RE-RAN THE SKILL — no deliverable was "
    "reproduced to 'check' another, which is the bias the split exists to remove. Grading was done "
    "against evals.json at HEAD, with every programmatically checkable clause (counts, populations, "
    "verbatim quotes, banned artefacts, ALL-CAPS accents, final sigma, anti-slop §6 families, skill-slug "
    "and framework-ID nets) checked by a script that prints matched or unmatched text rather than "
    "booleans: grading/check.py. Every flagged failure was then opened in the raw deliverable and quoted "
    "before being recorded (ledger F7). That step overturned five checker verdicts — see "
    "checker_false_verdicts_caught."
  ),
  "grader_independence": (
    "Grader did not author the deliverables, did not invoke entity-optimizer, and produced no competing "
    "output of its own. All fixture recounts were done from cross-cutting/entity-optimizer/evals/files/, "
    "not from any regenerated deliverable."
  ),
  "skill_version_under_test": "entity-optimizer 4.2.0 (frontmatter version and metadata.version both 4.2.0)",
  "eval_suite_revision_graded": "HEAD bd6963c; evals.json last modified at b306ec0",
  "baseline": grading["summary"]["baseline"],

  "summary": grading["summary"],
  "expectations": grading["expectations"],

  "comparability_ruling": {
    "why_it_matters": (
      "Both sides moved on 2026-08-12: the skill was substantially rewritten and one expectation was "
      "superseded. A per-expectation regression check is valid only where the expectation text is "
      "unchanged, so comparability was established BEFORE any comparison was made."
    ),
    "how_established": (
      "git show dad411c:…/evals.json (the baseline's grading revision, per the baseline record's own "
      "`run` field) versus git show HEAD:…/evals.json, compared expectation object by expectation "
      "object, then attributed to commits by walking dad411c → bb6ef16 → 3a8d62c → b306ec0 → HEAD."
    ),
    "comparable_26": ["1.1","1.2","1.3","1.4","1.5","1.6","2.1","2.2","2.3","2.4","2.6",
                      "3.1","3.2","3.3","3.4","3.5","3.6","4.1","4.3","4.5","4.6",
                      "5.1","5.2","5.3","5.4","5.5"],
    "not_comparable_3": {
      "2.5": "bb6ef16 — 'resolve two mutually unsatisfiable expectation pairs'. The clause about the "
             "founding-date correction was rewritten to require that NO replacement date be asserted, "
             "because this eval's single fixture carries no registry record.",
      "4.4": "3a8d62c — 'the Greek editor's verdict becomes a scored slot in all 20 suites'. Baseline "
             "graded the mechanical layer alone and recorded PASS; the current text makes the binding "
             "editor's grade the verdict and mandates EDITOR-PENDING in its absence. A baseline PASS and "
             "a current EDITOR-PENDING are not the same measurement and must not be differenced.",
      "4.2": "b306ec0 — entity R64 sweep; the record carries expectation_superseded_2026_08_12. The "
             "baseline version required routing to `legalName`/`alternateName`, strings a 2026-08-12 grep "
             "showed appear nowhere in the skill tree outside evals.json itself."
    }
  },

  "prior_diagnosis_tested": {
    "claim_1": "9 of 11 baseline failures were real skill defects, 1 a grading artefact, 0 defective expectations.",
    "verdict_1": (
      "Substantially upheld, with one correction. Seven of the 11 are now fixed by a rewritten skill, which "
      "is the signature of a real defect. But the 'zero defective expectations' half does not survive: 2.1 "
      "now prescribes an exclusion grouping that the skill's own newly added counting method drives a "
      "correct deliverable away from (see suite_level_findings.SF1), and 1.4's fail list does not catch the "
      "wave-through it exists to catch (SF3)."
    ),
    "claim_2": "The skill's judgement passed in all 11; every failure was arithmetic, omission or quote hygiene.",
    "verdict_2": (
      "Upheld again this run, and it is the most stable result in the record. No settled ruling was "
      "contradicted anywhere in the five deliverables: R2 refused (1.3), R5 affirmed (2.2), no action "
      "proposed against the Lighthouse of Alexandria or Faros Logistics ΑΕ (3.3), no panel promised (3.2), "
      "no paid-Wikipedia route offered (3.4), nothing invented for an unseen brand (5.1/5.2). All six of "
      "this run's failures are again arithmetic, omission or quote hygiene — with ONE exception, 1.4, which "
      "is a judgement failure: the response declines to refuse a lever R1 says not to add."
    ),
    "cluster_A_fabrication_guards": {
      "baseline": "4 of 4 F3 fabrication guards failed (1.6, 2.6, 3.6, 4.6).",
      "this_run": "4 of 4 PASS. CLOSED.",
      "what_closed_it": (
        "The specific baseline artefacts are gone and their absence is measured, not assumed: the invented "
        "'3rd-century-BC' monument date (1.6), the '3,000-strong corpus' (3.6), the '€92 per recorded "
        "mention' quotient (2.6) and the two wrong per-form mention counts (4.6). The per-form table was "
        "recounted row by row against the log and is now exact on all seven forms, and the cost-per-mention "
        "is refused in terms: «I am not going to divide €1,100 by 24, or by 7, or by anything else in this "
        "log». Full digit scans of all five deliverables found no QID, no Knowledge Graph entity ID, no "
        "search volume, no DA/DR, no numeric entity score."
      )
    },
    "cluster_B_population_arithmetic": {
      "baseline": "3 of 4 population slots failed (1.1, 2.1, 3.5 FAIL; 4.1 PASS).",
      "this_run": "3 of 4 fail again (1.1, 2.1, 4.1 FAIL; 3.5 PASS). NOT CLOSED — MOVED.",
      "what_moved": (
        "3.5 was fixed outright — the 9-cell count rule and the missing ChatGPT cell are both present and "
        "reconciled. 4.1 broke: the baseline stated «Σε αυτές τις 12 επιφάνειες … **εννέα διαφορετικές "
        "γραφές**» and this run does not. Inside the two that failed both times, the failing sub-clause "
        "changed hands: 1.1 lost the name-string denominator while gaining the address (5 of 7) and phone "
        "(4 of 7) denominators it previously lacked; 2.1 lost the '15 distinct sources' refinement AND the "
        "26 intermediate it previously carried, and now reports no domain figure at all."
      ),
      "common_root": (
        "The counting method added to SKILL.md Step 3 this cycle. Rule (3), 'one population per figure — "
        "never merge two … Name strings across the client's own surfaces and name forms across third-party "
        "mentions are two counts', was read as licence to split the twelve inventoried surfaces into three "
        "sub-populations (own pages / own profiles / third-party listings). That reading is defensible — "
        "rows 10–12 are vrisko.gr, xo.gr and an association entry, which are NOT the client's own surfaces "
        "on the rule's own wording — but it deletes the union figure the suite asks for, and it makes the "
        "union unrecoverable by addition: 5 + 2 + 3 = 10 while the true union is 9, because "
        "«ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΚΕ» is published on both row 2 and row 10. Rule (4), 'show every "
        "exclusion as its own step … One collapsed subtraction hides which rule did the work', produced the "
        "per-rule four-step chain in e2 that never surfaces the '26 rows about the company' figure 2.1 "
        "names. In both cases the rewritten method drove a careful deliverable away from the expectation."
      )
    }
  },

  "regressions_vs_baseline": [
    {"id": "4.1", "comparable": True, "baseline": "PASS", "now": "FAIL",
     "one_line": "The 9-distinct-strings-over-12-surfaces figure the baseline carried is gone, replaced by a three-sub-population split.",
     "quote_now": "«**5 διακριτές μορφές σε 5 επιφάνειες.** Έλεγχος: 1+1+1+1+1 = 5 = μέγεθος πληθυσμού ✓» (Πληθυσμός Α) — and no 9-over-12 or 8-over-12 anywhere.",
     "quote_baseline": "«Σε αυτές τις 12 επιφάνειες το όνομα δημοσιεύεται με **εννέα διαφορετικές γραφές**» with the folding rule at eight.",
     "severity": "high — this is the expectation's lead clause and the figure exists in the fixture."},
    {"id": "3.4", "comparable": True, "baseline": "PASS", "now": "FAIL",
     "one_line": "The fixture's verified Wikidata/Wikipedia absence is no longer carried.",
     "quote_now": "Every 'Wikidata'/'Wikipedia' span in e3-out.md printed and read; the closest is the forward-looking «A Wikidata item created, every statement referenced» — no absence stated, no check date, nothing about Wikipedia's in-article absence.",
     "quote_baseline": "«**No item.** Searched 2026-08-06 for `Pharos Marine Data`, `Faros Marine`, «Φάρος Ναυτιλιακή Πληροφορική» and the ΓΕΜΗ number — nothing for this company» and «The inventory records \"no article, and no mention of the company inside any existing article\"».",
     "severity": "medium — the other three legs improved, including the Requested Articles route the baseline lacked."},
    {"id": "1.4", "comparable": True, "baseline": "PASS", "now": "FAIL",
     "one_line": "llms.txt is no longer refused; it is deprioritised and given publication conditions.",
     "quote_now": "«**Ruling: not harmful, not a priority, and not something to report as a completed AI-visibility measure.**» … «publishing it asserts nothing false and costs an hour» … «**Two conditions if it does get published:**»",
     "quote_baseline": "«**Rejected. Do not implement.** … Publishing one is not harmful, but it buys nothing»",
     "severity": "medium — the 'not a lever' reasoning is intact and no effect is claimed, but R1's binding statement is «Do not add» and the prompt asked for a ruling Στέλιος can act on. JUDGEMENT CALL; both texts recorded so it can be overturned."}
  ],

  "suite_level_findings": [
    {"id": "SF1",
     "title": "2.1 and the skill's counting method now prescribe different groupings of the same exclusion chain.",
     "kind": "expectation vs binding skill text — returned, NOT resolved and NOT edited",
     "expectation_text": "«… 29 alert rows fired … Removing the 3 rows the log excludes as other entities … leaves 26 rows about the company; removing the further 2 … leaves 24 third-party mentions — 29 − 3 = 26, 26 − 2 = 24 …»",
     "skill_text": "SKILL.md Step 3, rule (4): «**Show every exclusion as its own step** — the starting figure, what each removal takes out and on which rule, and the subtotal after each. One collapsed subtraction hides which rule did the work, so neither the client nor the next auditor can reproduce or dispute it.»",
     "the_clash": (
       "The log excludes the 3 not-us rows under TWO distinct rules (C3/C4 = the Faros Logistics ΑΕ name "
       "collision; C5 = the ancient Lighthouse) and the 2 owned/paid rows under two more (owned channel; "
       "paid distribution). Writing '29 − 3 = 26' therefore collapses two rules into one subtraction, "
       "which is what rule (4) exists to forbid. The deliverable followed the skill and produced "
       "29 → 28 → 27 → 25 → 24, four steps each naming its own rule, and failed the expectation."
     ),
     "not_strictly_unsatisfiable": (
       "A deliverable could satisfy both by showing the per-rule steps AND naming the 26 aggregate, so this "
       "is a tension rather than a contradiction — which is why it is reported and not treated as an "
       "expectation that enforces a defect. It still cost a graded FAIL to a deliverable that applied the "
       "skill correctly, and it should be adjudicated by whoever owns the suite."
     ),
     "note": "The domain-count leg of 2.1 (7 / 15 / 22 distinct domains) is a clean, uncontested miss and fails on its own regardless of how SF1 is settled."},
    {"id": "SF2",
     "title": "'the twelve inventoried company surfaces' is not what the skill's rule (3) calls the client's own surfaces.",
     "kind": "expectation wording vs binding skill text — returned, NOT resolved",
     "expectation_text": "1.1 and 4.1: «nine distinct name strings across the twelve inventoried company surfaces».",
     "skill_text": "SKILL.md Step 3, rule (3): «**One population per figure — never merge two.** Name strings across the client's own surfaces and name forms across third-party mentions are two counts».",
     "the_clash": (
       "Rows 10–12 of the inventory are vrisko.gr, xo.gr and the Green Corridors EU member entry — created "
       "by the directory and the association, not by the client. A deliverable applying rule (3) literally "
       "must split them out of 'the client's own surfaces', and both e1 and e4 did exactly that, in both "
       "cases losing the required union figure. Two evals failed the same clause the same way in the same "
       "run, which points at the instruction rather than at the run."
     ),
     "note": "Unlike SF1 this one IS jointly satisfiable trivially (state the union, then decompose), so it is a wording risk, not a conflict."},
    {"id": "SF3",
     "title": "1.4's fail list does not catch the wave-through it exists to catch.",
     "kind": "expectation gap — returned, NOT resolved",
     "expectation_text": "«an answer that tells Στέλιος to add it, or that waves it through as 'cheap, might help', fails.»",
     "the_gap": (
       "The deliverable denies the 'might help' half explicitly — «no effect may be claimed from it» — while "
       "keeping the 'cheap' half and adding an implementation checklist. Read literally, neither fail "
       "condition fires; read against R1's «Do not add», the answer is not a refusal. This grader failed it "
       "on the expectation's main clause ('is refused'), which is a narrower hook than the fail list. If "
       "the suite intends R1 to be enforced here, the fail list needs the 'harmless, do it later' form "
       "named."
     )}
  ],

  "defects_outside_the_graded_set": {
    "preamble": (
      "A pass rate counts only what someone thought to ask. These were found by reading the five "
      "deliverables against the fixtures rather than against the expectations. None is covered by any "
      "expectation in this suite."
    ),
    "items": [
      {"ref": "D1", "eval": "e1", "class": "arithmetic error in prose",
       "detail": "§7 action 3 reads «five name strings on your own surfaces, two more on your own profiles, three more on directory listings». Read additively that is 10 distinct strings. The union across the inventory's twelve rows is 9: «ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΚΕ» is published on BOTH row 2 (own contact block and shared footer) and row 10 (vrisko.gr), so only two of the three directory strings are 'more'. Verified by recounting the fixture: union 9, additive sum 10. The same phrasing recurs in §10 («five name strings on owned surfaces»), which is correct in isolation."},
      {"ref": "D2", "eval": "e1", "class": "placeholder shipped inside paste-ready structured data",
       "detail": "The §6 JSON-LD block, introduced as «A concrete starting block» and «ready to paste», carries \"description\": \"DECIDE — see §4.4; one sentence, then used verbatim on every surface\" as a JSON string value. It is labelled honestly in the prose beneath, and the reasoning for leaving it open is sound, but the artefact itself is a non-value in a value slot in copy the engineer is told to paste. Anti-slop §6 family 2 bans exactly this shape («any [CLIENT DATA / [SOURCE NEEDED inside paste-ready copy or schema»); that family is Greek-scoped and binds only 4.5, so nothing in this suite catches it in an English deliverable."},
      {"ref": "D3", "eval": "e1", "class": "internal artefact names on a client-read surface",
       "detail": "§10 'Cross-Reference' carries three raw skill slugs — `content-quality-auditor`, `domain-authority-auditor`, `schema-markup-generator` — plus unglossed framework coordinates: CORE-EEAT, A07, A08, CITE, I01–I10, I09. The deliverable is addressed to a marketing lead assembling an investor diligence pack. This is anti-slop §6 family 8's pattern («a framework item ID is a coordinate in a document they have never seen»), whose exemption requires the block to be LABELLED as an operator surface and each handle to carry its job in the client's words; neither condition is met. Family 8 is Greek-scoped, so no expectation binds it here. Verified with a slug net built from the 20 real SKILL.md directory names, red-probed on a constructed positive first."},
      {"ref": "D4", "eval": "e1", "class": "graded verdict resting partly on an admitted non-observation",
       "detail": "§10 reads «**CORE-EEAT**: A07 (Knowledge Graph Presence) — Fail: no Wikidata item, no Wikipedia article, panel status unchecked.» The item is graded Fail while one of its three legs is stated as unchecked in the same sentence. I weighed this against 1.5's «any CORE-EEAT or CITE score are reported as not evaluated» and passed it, on the reading that an item verdict is not a score and that two verified absences settle the item regardless of the panel. Recording it so the call is visible: the baseline note for the same expectation observed that «no CORE-EEAT or CITE score is produced anywhere», which was true then and is not true now."},
      {"ref": "D5", "eval": "e1", "class": "signal scored ❌ against the file's own stated exclusion rule",
       "detail": "Signal 17 in references/entity-signal-checklist.md is disjunctive — «Wikipedia article (or strong notability path)», pass criteria «Article exists, or entity has 3+ independent sources». Arm 1 is settled false; arm 2 is unsettleable from these files, as the deliverable says: «The notability arm of this signal is *not* assessable from these three files». It scores the signal ❌ anyway, against its own §2 rule «A signal nothing in these three files can settle is excluded from both sides and named — never scored ❌». A disjunction with one false arm and one unknown arm is unknown. The 0 feeds the Knowledge Base category numerator (1.5 of 5 = 30.0%). Self-flagged in §11, which is why this is a consistency defect rather than a fabrication."},
      {"ref": "D6", "eval": "e2", "class": "duration attached to the wrong population",
       "detail": "«24 third-party mentions in nine weeks» (§5 table). The 24 are drawn from the log's window, 1 June – 31 July 2026 = 61 days ≈ 8.7 weeks. Nine weeks is the span from alert creation, 29 May 2026, which the file states correctly one section earlier: «a nine-week window, with the alerts only set up on 29 May 2026». Both endpoints are in the fixture, so nothing is invented; the two spans are conflated in one row."},
      {"ref": "D7", "eval": "e4", "class": "rewritten copy presented in quotation-like form",
       "detail": "§5 supplies two proposed boilerplate lines in markdown blockquotes under source labels: «(από τη διατύπωση της ίδιας μας της σελίδας «Η εταιρεία»)» and «(από την περιγραφή που ήδη δημοσιεύουμε στο LinkedIn)». Both are rewrites — the Greek changes «Αναπτύσσουμε»→«αναπτύσσει» and «χρησιμοποιώντας»→«αξιοποιώντας»; the English expands the LinkedIn line. 4.3 is not breached (it fails reformatting «inside quotation marks», and these carry none, and its scope is the ΓΕΜΗ extract and site copy), but blockquote + 'from the wording of our own page' reads as a quotation to a founder."},
      {"ref": "D8", "eval": "e4", "class": "date-format inconsistency, referred to the editor",
       "detail": "The author's three full dates are DD-MM-YYYY (06-08-2026, 12-08-2026, 23-06-2026) and 14/03/2019 is the verbatim registry value, but the §1 exclusion table renders the window «01/06–31/07». Judged not a breach of 4.4's 'one date and number convention' clause — a day/month range is not a second full-date convention — and referred to the greek-content-editor rather than resolved by this grader."},
      {"ref": "D9", "eval": "e1 and e5", "class": "assigned AI test queries diverge from the skill's set",
       "detail": "SKILL.md:158–160 assigns «What is [entity name]?», «Who founded [entity name]?», «What does [entity name] do?». e1 §1 assigns four queries, replacing the third with a vs-competitor query; e5 §3 does the same and also substitutes «Where is Κύμα Swimwear made?». No e1 expectation covers the query set. For e5 this sits inside 5.3, which I passed on the same reading the baseline grader applied to the identical clause (an equivalent substitution was recorded there as «assigned in detail»)."},
      {"ref": "D10", "eval": "e5", "class": "promise the method contradicts",
       "detail": "«I will score all 47 signals across the seven categories above». The checklist does carry exactly 47 signals (verified), but the method used in e1 — and described in the very next clause of the same sentence — excludes unsettleable signals from scoring rather than scoring them, and e1 excluded 27 of 47. 'All 47' overstates what the client will get."}
    ],
    "what_was_looked_for_and_not_found": [
      "Fabricated entity state: no Wikidata QID, no Knowledge Graph entity ID (/g/ or /m/), no branded search volume, no domain authority or rating value, no numeric entity health score, in any of the five deliverables. Regex-scanned individually, each net red-probed.",
      "Invented external facts: the baseline's '3rd-century-BC' monument date and '3,000-strong corpus' are both gone and no replacement appeared.",
      "Unsourced citations: the Google knowledge-panel URL and its two quotes used in e1 and e3 trace to references/knowledge-graph-guide.md:14–17; the six Wikidata property IDs in e1's roadmap (P856 P571 P17 P159 P452 P112) all exist at references/knowledge-graph-guide.md:142–147; every signal number cited in e1 maps to a real row in references/entity-signal-checklist.md (spot-verified 41 = «ISNI or VIAF identifier (for persons)», matching the file's stated exclusion reason).",
      "Arithmetic: every derived figure in all five deliverables was recounted against the fixtures — name-string sub-populations (5/2/3), address 5-and-2 of 7, phone 4-and-3 of 7, five distinct phone renderings, founding-year rows 3/5/6, per-form mention counts 8/5/4/3/2/1/1, sentiment 16/7/1, June 12 / July 12, dofollow 6 / nofollow 1, the 9 AI cells, 5+1+4=10 SERP grouping, and all seven §2 category percentages including each numerator against its own ✅/⚠️/❌ marks. Every one is exact. The single arithmetic defect found is D1, and it is in prose rather than in a table.",
      "Banned artefacts: no cost-per-mention, ROI or payback figure; no DR, referring-domain, traffic, impression or reach figure; no ranking-uplift or citation-probability number; no panel date, probability or timeline.",
      "Settled-ruling contradictions: none. No action is proposed against the Lighthouse of Alexandria entity, Faros Logistics ΑΕ, or their listings, profiles or rankings — including no use of the panel feedback link, which e3 does not mention at all.",
      "Anti-slop §6 on the Greek deliverable: all seven FAIL-grade families screened with working nets, including a hand-check of all 34 negative-concord candidates. Clean."
    ]
  },

  "executor_ambiguities_adjudicated": [
    {"n": 1, "question": "How to score a disjunctive criterion where one arm is settled false and the other unsettleable (signal 17: «Wikipedia article (or strong notability path)»).",
     "kind": "SKILL improvement (checklist), and it also surfaces as defect D5",
     "executor_resolution": "Scored ❌ on the checked arm, with the unchecked arm recorded separately in §11: «The signal is scored ❌ on the arm that *was* checked … the notability arm is recorded here rather than folded silently into the ❌».",
     "adjudication": "Defensible in transparency, but inconsistent with the deliverable's own stated rule («A signal nothing in these three files can settle is excluded from both sides and named — never scored ❌»), and logically wrong: a disjunction with one false arm and one unknown arm is UNKNOWN. The 0 it contributes is indistinguishable, in the category numerator, from a settled failure. The durable fix belongs in the skill, not in the run: references/entity-signal-checklist.md should state how a disjunctive Pass Criteria resolves when one arm cannot be evaluated — the conservative rule being that the signal is excluded and named unless the SETTLED arms alone determine the verdict. No expectation covers this, so it cost nothing here."},
    {"n": 2, "question": "What mark applies when a signal is present but actively FALSE rather than absent — the sameAs list is populated and 3 of 5 entries are false, one asserting identity with a different entity. ✅/⚠️/❌ has no cell for it.",
     "kind": "SKILL improvement (scoring scale)",
     "executor_resolution": "Scored ❌ and escalated the substance out of the score into the critical-issues list: «**C1 — The site's structured data asserts that the company is the Lighthouse of Alexandria.** … This is the one finding on the list that actively damages the entity rather than merely failing to help it, and it is a deletion, not a project.»",
     "adjudication": "Correct, and the best available move under the current scale. The observation behind the question is right and worth acting on: an absent sameAs asserts nothing, a false one asserts a false identity, and a three-value scale that maps both to 0 loses the distinction exactly where it matters most. Routing it to a critical issue and to priority action 1 preserves it for the reader. Recommend the skill add either a fourth state (e.g. ⛔ for a published falsehood) or an explicit rule that a false-signal finding is reported as a critical issue independent of its score — the executor invented the second of those on the fly and it worked."},
    {"n": 3, "question": "Exclusion granularity in the counting method — how finely must an exclusion chain be broken out?",
     "kind": "EVAL feedback, and the sharpest of the five: it cost a graded FAIL",
     "executor_resolution": "Broke the chain by RULE into four steps (29 → 28 → 27 → 25 → 24), defending it in the text: «Each removal is shown separately on purpose … If those three were collapsed into \"−3 not us\", you would lose the finding that **your alert terms are catching two distinct other things**.»",
     "adjudication": "Defensible against the skill and, on its own terms, better analysis than the expectation's grouping — the C3/C4 vs C5 split is a real finding about the alert terms and it survives only under the finer chain. It nonetheless fails 2.1, which names 26 as an intermediate. See suite_level_findings.SF1: rule (4) of the skill's counting method forbids collapsing two rules into one subtraction, and '29 − 3 = 26' does exactly that. The expectation should require that every exclusion appear with its own rule and that the chain reach 24 without collapsing rules, rather than naming a particular intermediate — but that is the suite owner's call and this grader did not make it. Note that 2.1 fails independently on the missing 7/15/22 domain figures, so settling SF1 does not change the verdict."},
    {"n": 4, "question": "A category status computed from a single surviving signal (0.5 of 1 = 50%).",
     "kind": "SKILL improvement (scoring method)",
     "executor_resolution": "Printed the percentage and disclaimed it in the same cell: «⚠️ **Gaps** — 0.5 of 1 scored = 50.0% | **This status rests on a single signal and should be read as \"not yet assessed\" rather than as a result.**»",
     "adjudication": "Honest and defensible — the disclaimer is in the cell, not in a footnote, and the same row names the six excluded signals and what would move five of them. But a percentage over n=1 is not a measurement of a category, and a reader scanning a seven-row table takes the status word and the number, not the sentence after them. The durable fix is a minimum-denominator rule in the skill: below k scored signals a category reports 'insufficient basis' and no percentage. Until then the executor's handling is the right one."},
    {"n": 5, "question": "Whether an exclusion-chain endpoint spanning both populations (the 24) violates «linked and unlinked are two figures, never one total».",
     "kind": "SKILL improvement (wording), minor",
     "executor_resolution": "Reported the 24 and immediately fenced it: «**A note on the 24.** It reconciles the alert feed; it is not a number to manage to. The two figures that mean something are the 7 and the 17 … a combined \"24 mentions this period\" invites a trend line that would move for reasons that have nothing to do with the company».",
     "adjudication": "No violation, and the resolution is right. Rule (3) bans reporting linked and unlinked as one undifferentiated MENTIONS figure; it does not ban naming the population both are drawn from, and the expectation itself requires the 24 («leaves 24 third-party mentions»). An exclusion chain has to terminate somewhere. Worth one clarifying clause in the skill — that a population's size is not a 'figure' in the merge sense — because the executor had to reason its way there and the next reader will too."}
  ],

  "checker_false_verdicts_caught": [
    "4.4a ALL-CAPS accent detector flagged `ΦΆΡΟΣ` at offset 6872. Opened the raw text: it occurs only inside the deliverable's own prohibition — «γράφεται **χωρίς τόνους** — `ΦΑΡΟΣ` … Ποτέ `ΦΆΡΟΣ`.» The pattern matched its own remediation text. Zero real violations; had this been reported it would have converted an EDITOR-PENDING slot into a FAIL.",
    "4.1e population-merge detector flagged «Χ παραλλαγές». Opened the raw text: «Ένα ενιαίο νούμερο «Χ παραλλαγές ονόματος» δεν θα έδειχνε ποια δουλειά είναι δική μας» — the deliverable REFUSING to merge. Same failure mode as above.",
    "2.4 verbatim-quote checker initially PASSED the B4 quotation because the trimmed clause «η ενσωμάτωση με το ERP μας πήρε τρεις μήνες» is still a SUBSTRING of the fixture, so a containment test returns True. Rebuilt to compare against the whole saved snippet, which exposed the trim. This is the run's only quote-hygiene failure and the first checker would have missed it.",
    "2.3c / 2.5a reported NO MATCH on «not a lifetime count» and «No outreach has been attempted» because the deliverable wraps the first in markdown bold («**not** a lifetime count») and line-breaks the second. Both are present; whitespace- and markup-tolerant patterns found them. Reporting either as absent would have produced a false FAIL on 2.3.",
    "3.6e flagged 'Bing' as present. Opened it: «**Anything about Bing, or any assistant beyond the three tested.**» — in the gaps section, i.e. respecting the fixture's stated absence, which is what the expectation asks for.",
    "The first skill-slug net was built from a broken shell extraction and returned 4,628 hits on e4 by matching ':'. Rebuilt from the 20 real SKILL.md directory names and red-probed on a constructed positive before use (returned ['keyword-research','schema-markup-generator']); the rebuilt net returns 0 hits on e4 and 3 on e1."
  ],

  "notes_for_the_coordinator": [
    "This record and grading.json are written to the scratchpad only. The coordinator commits them, with the five deliverables, under docs/loop/eval-baselines/blind-2026-08-12/ (F16: a run is not complete until its record has a repo path).",
    "Pooling caveat: the 22/29 headline and the baseline's 18/29 differ in how the 4.4 slot is treated (baseline counted it as PASS under the pre-3a8d62c text; this run records it EDITOR-PENDING under the mandated convention). The like-for-like comparison is the 26-expectation comparable subset: 16/26 → 20/26.",
    "One editor referral is outstanding: greek-content-editor on e4-out.md, which decides 4.4. Items to put in front of them are listed in that expectation's evidence and in defect D8.",
    "Three suite-level findings (SF1, SF2, SF3) are returned unresolved and unedited, per charter."
  ]
}

path = os.path.join(OUT, "entity.json")
json.dump(rec, open(path, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print("wrote", path)
s = rec["summary"]
print("summary invariant:", s["passed"] + s["failed"] + s["ungraded"] == s["total"],
      s["passed"], s["failed"], s["ungraded"], s["total"], s["pass_rate"])
