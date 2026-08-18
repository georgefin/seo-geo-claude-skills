# Settled Rulings — SEO/GEO Research Baseline

Decisions the weekly skill-update-check must NOT relitigate without **new primary evidence**
(engine-official or Google-official documentation — never blog/vendor claims). If superseding
primary evidence appears, do not edit here directly: label it a **"supersession candidate for
Sani's gate"** in the weekly report and route it through `GATED-ITEMS.md`.

All five rulings were baked into the v1 routine prompt (created 2026-07-18) and re-affirmed by
the 2026-08-08 sweep ("no new evidence found this cycle — all stand"). Origin decision dates
before 2026-07-18 are not recoverable from the current session transcript.

**Last review: 2026-08-11** — R2 gained its "carried where it is scored" clause (C09 corrected
at the benchmark) and R3 gained provenance amendment 9a. R1, R4, R5 unchanged and standing.
Prior full sweep 2026-08-08 (all rulings stood).

**2026-08-17, register maintenance only — no ruling was reviewed, re-affirmed or changed.**
R4's and R5's `Encoded in repo` pointers were re-derived at source and anchor-tagged (four of the
five bare pointers in this file); R3's `schema-markup-generator` SKILL.md pointer was left
alone and referred for a human — see the note in R3. Sani's working-method ruling M1 was added in
its own section below the research rulings.

---

## R1 — llms.txt is a dead lever

- **Statement**: Do not add an `llms.txt` file expecting AI-citation gains; no engine is
  confirmed honoring it.
- **Decided**: on/before 2026-07-18 (in v1 routine prompt); re-affirmed 2026-08-08.
- **Evidence**: No engine-official adoption found; absence re-confirmed each weekly sweep.
- **Encoded in repo**: `build/geo-content-optimizer/SKILL.md:141` ("Not citation levers");
  `build/geo-content-optimizer/references/ai-citation-patterns.md:520` ("Not citation levers");
  `VERSIONS.md:317` ("non-levers")
  (pointers refreshed 2026-08-09 — 4.1.5 module insertion + v4.3.1 changelog shifted both;
  VERSIONS pointer re-refreshed 2026-08-10, +2 from the seo-content-writer 4.2.5 bullet,
  then +2 again from the entity-optimizer 4.1.5 / backlink-analyzer 4.0.4 bullet.
  **Skill pointers re-verified at source 2026-08-10 and both were wrong before this wave
  touched anything** — `:159` had drifted into the step-2 score table and `:478` into
  unrelated prose, so the ruling's own evidence pointed at text that did not carry it. Found
  by the agent doing the R2/C09 work, which reported the true HEAD lines as `:142` and `:489`;
  those then moved again under its own edits, and its follow-up figure of `:491` was **also
  stale by two** when checked. Re-derived by grepping the token rather than trusting any
  reported number — a line number in a report is a claim, and this pointer has now been wrong
  three times from three different causes. Anchor tokens added so `reanchor-pointers.sh` can
  carry these two the way it already carries the VERSIONS pointer.)
- **Reopens on**: engine-official (Google/OpenAI/Perplexity) primary documentation of
  llms.txt ingestion.

## R2 — Schema-stacking is not an AI-citation lever

- **Statement**: Piling multiple schema types on a page adds no citation signal. One accurate
  JSON-LD type per page (CORE-EEAT item O05) is enough.
- **Decided**: on/before 2026-07-18; re-affirmed 2026-08-08.
- **Boundary (clarified 2026-08-08 — precision, not reversal)**: R2 bans *citation-lever
  stacking*: adding schema types on the theory that more types raise AI-citation odds. It
  does NOT ban multi-type markup where each extra type has its own engine-documented,
  non-citation job. Concretely: (a) one PRIMARY content type per page (O05) remains the
  rule; (b) documented auxiliary types alongside it are legitimate — BreadcrumbList
  (Google-documented site-structure feature), Organization/Person nested as
  publisher/author identity, WebSite on the homepage; (c) a second full content type on
  the same page (e.g., FAQPage bolted onto a service page, Article + Product both as
  primaries) IS stacking and stays banned — unless the page genuinely is both things and
  each type is complete, accurate, and independently justified. Skill text and references
  must teach this boundary, not the pre-clarification "pile types" pattern.
- **Encoded in repo**: `build/geo-content-optimizer/SKILL.md:141` ("Not citation levers");
  `build/geo-content-optimizer/references/ai-citation-patterns.md:520` ("Not citation levers");
  `VERSIONS.md:317` ("non-levers")
  (pointers refreshed 2026-08-09, same shift as R1; VERSIONS pointer re-refreshed twice on
  2026-08-10, same two changelog insertions as R1; skill pointers re-derived at source
  2026-08-10 — see R1's note, both were already wrong at HEAD before this wave began);
  earlier boundary alignment in `build/schema-markup-generator/` v4.1.0 (2026-08-08 wave).
- **Carried where it is scored, not only where it is stated (added 2026-08-10)**: the ruling
  had a hole one level below every skill. `references/core-eeat-benchmark.md` item **C09**
  read "Structured FAQ with FAQPage Schema" as its Pass criterion, so the shared framework
  **required what this ruling bans**, and `geo-content-optimizer` was obeying its benchmark
  when it mandated FAQPage in four places. C09 now passes on the visible on-page Q&A block,
  with FAQPage markup creditable only where FAQPage is the page's one primary type. Fixing it
  at the benchmark rather than per-skill is deliberate: a local precedence patch would need
  repeating in every skill that scores C09 and in every skill written afterwards. Section 5 of
  that same file had already been corrected to this boundary, so C09 was the last hold-out and
  this finishes a supersession rather than opening one; it is now named in the file's
  version-sync protection clause so an upstream v3.x sync cannot silently revert it.
  Downstream sweep the same day: `commands/generate-schema.md` was advising the banned shape
  outright ("Combine multiple schemas when appropriate (Article + FAQ, Product + Review)"),
  and `schema-markup-generator` was aligned on the ban while four of its FAQPage entry points
  authorised emitting the type with no primary-type test. Its carrier for this sweep is
  **v4.2.1 (2026-08-10)**.
- **Reopens on**: primary evidence (Google/engine docs or engine-published research) that
  multiple types per page raise citation odds.

## R3 — FAQPage schema is KEPT despite Google rich-result retirement

- **Statement**: Google ended FAQ rich results in 2026 — the search appearance, the rich
  result report and Rich Results Test support were dropped June 2026, and Search Console API
  support is **scheduled for August 2026** — but FAQPage generation stays in the library.
- **Provenance amendment 9a (Sani-accepted 2026-08-11; proposed 2026-08-10)**. Three
  corrections, all of which make this ruling claim *less* than it did:
  - **Two distinct events had been conflated into one.** `2023-08-08` narrowed FAQ
    rich-result **eligibility** to well-known government and health sites. `2026-05-07` ended
    the **display** entirely. Both are real; neither contradicts the other; and this ruling's
    original one-line "retired in 2026" hid the earlier change. Origin of the catch: the
    binding Greek editor, judging an unrelated Greek deliverable, flagged out of remit that
    "retired in 2026" disagreed with its understanding that the deprecation dated to 2023. It
    was right that something was wrong, and wrong about which date was the error — the useful
    shape of an out-of-remit flag.
  - **The API cut is scheduled, not observed.** Softened from "cut" above. Today is
    2026-08-11, so an August 2026 cut is in-month; asserting it as done would be a claim about
    the present tense that nobody here has checked.
  - **This ruling's own rationale has no primary source either way.** The original statement
    ended "Its value is AI-engine/GEO parsing, not SERP monitoring." **No primary source
    supports that clause, and none refutes it** — and Google's 2026 AI-optimization guide
    states that no special structured data is needed for its own AI surfaces. That does not
    overturn the keep-decision, which stands on schema.org validity plus non-Google engines,
    but it does constrain how confidently any skill may phrase the benefit. **A skill may say
    FAQPage is valid and cheap to keep. It may not say it earns AI citations.**
  - Newly-found primary support for the keep-decision, previously uncited: Google's own
    guidance that there is **no need to proactively remove** existing FAQPage markup.
- **Evidence grade, stated rather than implied**: snippet-grade from domain-restricted
  queries against Google's own domain, **not owner-read**. `developers.google.com` is refused
  by this environment's network egress policy — re-tested 2026-08-11 through both the HTTP
  client and WebFetch, both refused at the gateway. The two source URLs are
  `developers.google.com/search/blog/2023/08/howto-faq-changes` and
  `.../2026/05/a-new-resource-for-optimizing`; an owner read of those two would upgrade this
  grade in about two minutes in a browser.
- **What 9a deliberately does NOT do**: proposal 9b — ruling on HowTo and purging the four
  library loci that still teach it as a current SERP feature — is **held**, per Sani's
  2026-08-11 decision, until that owner read happens. 9a is text in one register and reverts
  in one commit; 9b changes four reference files across three skills on evidence nobody here
  could read directly.
- **9a's scope is language-neutral, and 2026-08-17 was the first time anything said so.** The
  amendment bars asserting an engine disposition as fact; every carrier enforcing it — the
  reference text, the reviewer checklists and `scripts/engine-claim-sweep.sh`'s seven shape
  families — was **English-only**, so «Η Google προτιμά σελίδες με σαφή ορισμό στην αρχή.» broke
  9a and passed every net. The sweep was deliberately **not** taught Greek: it scans repository
  text, and measured that day its seven directories held 7 Greek-carrying files and **zero** Greek
  engine-claims, because Greek deliverables are produced at run time and never enter the repo.
  The Greek carrier is `anti-slop-ruleset.md` §6 FAIL-grade **family 9**, on the surface that
  governs deliverables. Full reasoning, including the declined copular family and the locale
  constraint that decided the net's form, in OPEN-FINDINGS 102.
- **Decided**: 2026-08-08 sweep (retirement reflected in schema-markup-generator 4.0.1);
  provenance amended 2026-08-11.
- **Encoded in repo**: `build/schema-markup-generator/SKILL.md:223`; `VERSIONS.md:321`
  ("schema-markup-generator 4.0.1" — anchor-tagged per F12; on any line/token
  mismatch, grep the token — the token is authoritative; VERSIONS pointer refreshed
  2026-08-10, +2 from the entity-optimizer 4.1.5 / backlink-analyzer 4.0.4 bullet).
  **The SKILL.md pointer was NOT anchor-tagged in the 2026-08-17 pass, deliberately.**
  Read at source that day, `:223` resolves to a bare `</script>` line inside a placement
  skeleton — a token that appears three times in the file and carries none of this
  ruling. The ruling's subject is now spread over six candidate lines in that skill
  (:45, :152, :169, :240, :258, :321), and picking one is a judgement about which is
  canonical, not a refresh. That is the ambiguous case `reanchor-pointers.sh` refuses,
  so this pass refused it too and left the bare pointer standing rather than freezing a
  guess into the register. **Needs a human.**
- **Reopens on**: schema.org deprecating the FAQPage type itself, or primary evidence that
  AI engines stopped parsing it.

## R4 — Core Web Vitals "Good" = LCP 2.5s / INP 200ms / CLS 0.1; FID is dead

- **Statement**: Thresholds remain LCP ≤2.5s, INP ≤200ms, CLS ≤0.1. FID retired 03-2024
  (INP-only). The circulating "2.0s LCP" figure is vendor-blog, not Google.
- **Decided**: on/before 2026-07-18; FID cleanup applied 2026-08-08
  (technical-seo-checker 4.0.1).
- **Encoded in repo**: `monitor/performance-reporter/references/kpi-definitions.md:453-455`
  ("**LCP** (Largest Contentful Paint)") — pointer refreshed 2026-08-17: :300-306 had
  drifted onto the AI Citation Position block and carried no CWV row at all; the three
  threshold rows were re-derived by grepping the token, not by trusting the old number;
  previously refreshed 2026-08-08 after the AI-referrals insertion shifted the table;
  `VERSIONS.md:322` ("technical-seo-checker 4.0.1", anchor-tagged per F12 — token
  authoritative on mismatch; refreshed 2026-08-10, +2 from the entity-optimizer 4.1.5 /
  backlink-analyzer 4.0.4 bullet); `optimize/technical-seo-checker/SKILL.md:258`
  ("CWV metrics (LCP/CLS/INP)" — anchor added 2026-08-17. The number moved **during this
  pass**: read at source it was :259, and a concurrently-running skills lane shifted it to
  :258 before the pass finished. Recorded rather than smoothed over, because it is the
  whole argument for the anchor: the token survived the edit and the number did not.
  Re-derive with `scripts/reanchor-pointers.sh` rather than trusting this number;
  previously refreshed 2026-08-09 — an E3 Mode A round found :258
  resolving to a blank line, a pointer class check (g) does not cover; previously
  refreshed 2026-08-08 after the labels wave; FID rows also purged from that skill's two
  reference files the same day — the 4.0.1 cleanup had missed them).
- **Reopens on**: Google-primary threshold change only (web.dev / Google Search Central).

## R5 — Unlinked brand mentions are a GEO/entity visibility signal

- **Statement**: Unlinked brand mentions count as an entity/GEO visibility signal and are
  scored (CITE item I09).
- **Decided**: on/before 2026-07-18 (I09 dates to CITE v2.0.0, 2026-02-08); re-affirmed
  2026-08-08 ("no Google-primary contradiction; not reopened").
- **Encoded in repo**: `references/cite-domain-rating.md:369-372`
  ("I09: Unlinked Brand Mentions") — scoring;
  `references/cite-domain-rating.md:509` ("Brand mention monitoring") — measurement.
  Both pointers refreshed
  2026-08-17: :309-310 had drifted onto the domain-age Partial/Fail rungs and :447 onto
  the C04 Link Velocity row, so neither carried I09 any more. Re-derived by grepping
  `I09`, not from the old numbers, and anchor-tagged so `reanchor-pointers.sh` carries
  them from here on.
- **Reopens on**: Google-official primary evidence only — explicitly **not** blog evidence.

---

## Working-method rulings (Sani; not research rulings)

Kept in this register because they are non-relitigable on the same terms as the rulings above,
and separated from them because their subject is the loop's own working method rather than
search-engine behaviour. The reopening condition is Sani's own word, not primary evidence.

### M1 — PR #9 is not to be merged; work ships split by reviewability

- **Statement**: PR #9 is **not to be merged**. No wave, report or brief may name merging it as
  a goal. Work reaches the tree in slices ordered by how reviewable each slice is: **registers
  first, then scripts, then skills in waves.**
- **Decided**: 2026-08-17, by Sani.
- **Why it is not relitigable here**: the ordering is a review-capacity decision, not a technical
  one. A slice is sized so a reviewer can hold all of it at once; a lane that argues for a bigger
  slice is arguing about somebody else's reading capacity.
- **Reopens on**: Sani's explicit word only.

---

### M2 — a version bump is never waived as "behaviourally empty"

- **Statement**: a blind record whose graded version is behind HEAD's `metadata.version` is
  **not current**, and no lane may clear it by judging the intervening bump empty. Where the
  whole diff is the version lines themselves, the record is still stale and the suite is still
  re-run. `GOALS-SCORECARD.md` G2-C3 is applied as written.
- **Decided**: 2026-08-17, by Sani, on a lane's own recommendation against its own verdict.
- **Why it is not relitigable here**: the lane that proposed the waiver argued for it, applied
  it once, and then asked for it to be refused — because *"the version moved and I decided it
  didn't matter"* is a precedent that, used loosely by the next lane, dissolves the version
  check entirely. The check costs one suite to honour and stops costing anything the moment it
  is optional. One suite is cheaper than a check nobody can rely on.
- **Effect on the 2026-08-17 re-run scope**: `seo-content-writer` moves out of the no-re-run
  tier. The list is **14 of 20**, not 13.
- **Reopens on**: Sani's explicit word only.

### M3 — a gated leg's escape hatch must work, and a trailer is only a trailer in the trailer block

- **Statement**, three parts, all now enforced in `scripts/register-lock.sh` and held by
  fixtures:
  1. **The documented rule stands: a `Register-Lock: none` declaration must carry a reason.**
     Only the implementation was broken, and the header was right about what it should do.
  2. **The separator is a closed list of three — em dash, en dash, `--` — and the em dash is
     canonical**, because it is the form this repo's only real `none` declaration actually uses
     (`Register-Lock: none — new directory, no shared register`). The `--` of the original doc
     string appears in the history only on a `<holder>` declaration, never on a `none` one.
  3. **A trailer is only a trailer in the trailer region.** The region is the trailing run of
     paragraphs in which every non-blank line is trailer-shaped or a continuation; walking
     stops at the first paragraph containing a line of ordinary prose. Never a
     `grep '^Register-Lock:'` over the whole message.
- **Decided**: 2026-08-17, by the coordinator on Sani's instruction to rule it, after the
  fault-injection lane reported the defect and deliberately declined to fix it.
- **THE FIRST IMPLEMENTATION OF PART 3 WAS WRONG, AND MEASUREMENT CAUGHT IT.** It used
  `git interpret-trailers --parse`, which is git's own reader and looks obviously correct.
  Measured against **all 45 `Register-Lock` declarations in this repository's history, it saw
  4.** Git honours only the *final* paragraph, and this repo's convention puts the declaration
  in its own paragraph above `Co-Authored-By:` — so **41 true declarations would have gone
  unseen, and every one of those commits would then have been FAILed for declaring nothing.**
  That is a far worse defect than the bare-`none` hole it was fixing: the original bug let
  commits through, this one would have blocked them
  `[obs:2026-08-17 for each of the 45 commits whose message matches ^Register-Lock:, compared
  grep -ci against git interpret-trailers --parse | grep -ci -> 4 seen, 41 unseen; the same
  comparison against the shipped trailer_region -> 43 seen, 2 unseen]`. The replacement is the
  paragraph walk in part 3, measured on the same 45: **43 preserved, 2 dropped, both drops the two
  revisions of the single commit whose *prose* carries the string** — which is the defect being
  closed, not a loss. *The lesson is not about git: a fix that looks obviously right, written
  by the same party that wrote the ruling, is exactly the one nobody else will re-measure.*
- **Why the lane was right not to fix it, and right to report it**: the fix changes what a
  **gated** leg accepts, and applying it mid-wave would have stopped lanes that were still
  pushing. It asserted the shipped behaviour in a known-gap fixture instead, so the gap stayed
  measured rather than described. That fixture has now flipped to `gate-bare-none-rejected.txt`,
  which is what a known-gap case is for: it turns red the moment the gap closes, and the flip is
  the evidence the fix landed.
- **The second defect was found while ruling the first, in this repo's own history.** The
  commit that documents the bare-`none` bug carries the sentence *"...wave itself past this
  gated leg with a bare Register-Lock: none. Not fixed here because..."* at line-start, and the
  old whole-message grep matched it. It escaped becoming a **false `none` declaration** only
  because its author happened to type a full stop after the word — the arm tested `*" none "*`,
  which needs a space on both sides, and `none.` has a period. **One punctuation mark decided
  whether a gated leg waived a commit.** A guard whose outcome turns on incidental punctuation
  in unrelated prose is a coin flip, not a check. Held by
  `gate-none-prose-is-not-a-trailer.txt`, whose fixture prose deliberately writes the form that
  *would* have fired.
- **What is still NOT claimed**: that a declaration is *true*. It is an auditable claim, the
  same standing as `claims-gate`'s FLIP trailer — the leg requires that a claim be made and be
  well-formed, and never asks whether the diff bears it out. That limit is stated in the
  script's own header, item 6.
- **Reopens on**: a measured false positive against a declaration form in real use. A
  preference for a different dash is not grounds.

### M4 — the lock-journal archive directory is never covered by a tenure

- **Statement**: `path_overlap` returns "no overlap" for any candidate path under
  `docs/loop/register-locks-archive/`, so no `Register-Lock` tenure — however broad the prefix —
  ever covers it. The journal itself needs no carve-out: it is gitignored and never in a commit.
- **Decided**: 2026-08-18, by the coordinator on Sani's instruction, from a defect the
  archive-faultinject lane measured and deliberately did not fix, on the grounds that which
  escape is correct was a coordination call rather than a code one. It was right to hand it back.
- **The defect**: a lane holding the `docs/loop/` prefix held `docs/loop/register-locks-archive/`
  with it, so **the commit gate leg 6 requires was the commit gate leg 5 refuses** — two legs of
  one gate deadlocked. Measured in a throwaway repo, not derived
  `[obs:2026-08-18 temp repo, lane-b holding docs/loop/, commit adding only
  docs/loop/register-locks-archive/<date>.tsv inside that tenure -> gate-check exit 1]`.
- **Why a carve-out and not the escape hatch.** The alternative was routing every archive commit
  through `Register-Lock: none — <reason>`. That trailer asserts *"no holder's content rides in
  this commit."* For an archive commit the statement is **false** — the holder's rows are exactly
  what is being committed. `register-lock.sh`'s own header records that the pre-escape check
  *"taught lying"*, and M3 repaired that escape three commits earlier precisely so it carries an
  auditable true claim. Sending the one unavoidable case through it would teach the same lying the
  escape exists to stop.
- **Why the carve-out is safe, stated as what the directory IS.** F14's defect is one writer's
  **authored** hunk swept into another writer's commit describing unrelated work. Nobody authors an
  archive row: `do_archive` copies them mechanically out of the journal, so the hunk carries no
  one's intent and there is nothing to sweep. Concurrent appends there are expected and safe by
  design — `.gitattributes` gives the directory `merge=union` for that reason.
- **Held by a pair, not a single case.** `gate-archive-dir-never-locked` (must pass) and
  `gate-inside-tenure-undeclared` (same journal, same `docs/loop/` prefix lock, non-archive file,
  must fail). Only the pair separates *"the archive is carved out"* from *"the prefix branch stopped
  working"*, and a carve-out nobody asserts is one a later reader deletes as dead code. Mutation-
  tested: removing the carve-out turns the case red
  `[obs:2026-08-18 carve-out line replaced with a no-op -> PROBE FAIL gate-archive-dir-never-locked,
  expected exit 0 got 1]`.
- **Scope**: this is a carve-out in the *collision* check only. It says nothing about who may write
  the archive, and it does not exempt any other path under `docs/loop/`.
- **Reopens on**: a measured case where two writers' archive rows genuinely conflict in a way
  `merge=union` does not resolve.

### M5 — `domain-authority-auditor` e4.7: the FAIL does not survive the current text, and the record's FAIL still stands

- **Statement**, and the two halves are not in tension:
  1. **Against the expectation as it reads at HEAD, the FAIL does not survive.** Its only explicit
     failure trigger is *"a derived figure that contradicts the report's own tables"*, and no figure
     did — every number in that deliverable recomputes. The grader's stated basis was a **skill**
     rule and a `score-arithmetic` section, not any clause of e4.7.
  2. **The record's FAIL stands as a correct grade of what it graded.** The expectation was rewritten
     at `e06073a`, hours after the run. This is a statement about a re-run, not a correction of the
     record, and the record is **not** to be edited to match.
- **Decided**: 2026-08-18, by the coordinator, on facts the `auditor-outputval` lane established and
  deliberately did not act on — it stated both readings and refused to pick, which was correct.
- **The defect that outlives the ruling, and is the part worth keeping**: **no clause anywhere in
  that suite grades "the report states a rule it then contradicts."** The FAIL was reaching for a
  property — document self-consistency — that the instrument never asks about. If that is to be
  graded it must be **written**, not inferred into an expectation that does not say it. Until it is,
  a deliverable may print one method and apply another and pass.
- **Not relitigable on**: a preference between the two readings. Reopen only on a written expectation
  that grades stated-versus-applied method, at which point this ruling is superseded rather than
  argued with.

### M6 — a fixture that withholds an answer scopes every expectation graded against it, not one

- **Statement**: where a fixture deliberately withholds a value, the Value Rule's skeleton carve-out
  applies to **every** expectation in that eval which would otherwise require the withheld value in
  composed prose — not only to the expectation someone happened to register. A labelled skeleton
  whose label sits inside its own fence satisfies those expectations; inventing the withheld
  substance and shipping it as client copy fails them, bracketed or not, attributed or not.
- **Decided**: 2026-08-18, by the coordinator, on facts the `step7-suites` lane established and
  correctly refused to act on. It repaired `content-refresher` e2.6 as dispatched, then found e2.3
  is the same fixture collision one expectation over, stated both readings, and declined to extend
  a carve-out into an undispatched expectation on its own initiative — *manufacturing a ruling*.
  That was the right call and this is the answer to it.
- **Why fixture-scoped and not expectation-scoped**: the collision is a property of **the fixture**,
  not of the sentence that trips over it. Scoping the carve-out per expectation leaves every
  unregistered sibling punishing the behaviour the ruling sanctions, and leaves the reading to
  whoever grades next. That already happened: the 2026-08-17 grader **passed e2.3 and failed e2.6**
  on the same deliverable and the same withheld value — a difference produced by improvisation, not
  by the instrument. *A half-repaired suite that still punishes the same behaviour one line down is
  not a repaired suite.*
- **What it does NOT license**: the carve-out reaches the *placement* of a value the fixture does
  not carry. It never reaches a value the fixture **does** carry, and it never excuses inventing the
  substance. The blind spot F13 recurrence 5 identified — a fabrication clause scoped to attributed
  statistics, unable to see invented domain advice — stays closed in every expectation it touches.
- **Owed**: `content-refresher` e2.3 carries the carve-out in the same words e2.6 now does, applied
  by a lane that did not write this ruling. Any other expectation in that eval graded against the
  same withheld value is in scope; the applying lane enumerates them rather than taking this list
  on trust.
- **Reopens on**: a fixture whose withholding turns out to be an authoring accident rather than a
  designed test, in which case the fixture is completed and the carve-out lapses for it.

---

## Pinned baselines (drift watch — not rulings)

Last-known-verified states the weekly sweep uses as cheap change-detectors. Drift here is a
FINDING to report (and this section is then updated via normal PR — facts, not decisions, so
no gate needed).

| Baseline | Last verified state | As of |
|---|---|---|
| schema.org release | v30.0 | 2026-03-19 |
| Google Search Quality Rater Guidelines | last known active version dated 2025-09-11 | 2026-08-08 |
| Google AI Mode in Greek | live since 2025-10-08 (`VERSIONS.md:317` ("non-levers")) | 2026-08-09 |
| awesome-generative-engine-optimization (GitHub) | last commit 2026-04-14 (quiet) | 2026-08-08 |
| RSI paper baseline | MetaSkill-Evolve arXiv 2607.05297 · RSI survey arXiv 2607.07663 · AREX arXiv 2607.21461 ("AREX: Towards a Recursively Self-Improving Agent for Deep Research", BAAI, v1/v2 — existence confirmed 2026-08-08, see W1) · PAST-Bench arXiv 2608.04003 | 2026-08-08 |
| Skill-loop literature (2026-08-08 assessment additions) | GRASP arXiv 2605.29668 · SEA-Eval arXiv 2604.08988 · feedback-dynamics arXiv 2608.02636 · OpenSkillEval arXiv 2605.23657 (titles search-verified; contents beyond abstracts [VERIFY]) | 2026-08-08 |
| Last confirmed Google core update | 2026-05-21 → 2026-06-02 (Search Status Dashboard) | 2026-08-08 |

---

*Change protocol: edits to the rulings above land only via a gated PR after Sani's verdict;
each edit updates "Last review" and cites the superseding primary source with its date.
Pinned-baseline rows update via normal PR whenever the weekly sweep verifies a change.*
