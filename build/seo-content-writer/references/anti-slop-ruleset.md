# Anti-Slop Ruleset (EN + EL)

Writing-side rules that keep deliverables free of AI-tell vocabulary, filler structure,
and zero-information sentences. The enforcement side — audit scans that score these same
rules against existing CORE-EEAT items — lives in
[content-quality-auditor's anti-slop audit checks](../../../cross-cutting/content-quality-auditor/references/anti-slop-audit-checks.md).
The two files change together.

Rationale: slop patterns make a page read as machine-generated boilerplate to readers and
reviewers, and they displace the specific information that makes content quotable. Every
rule below either forces information into a sentence or cuts the sentence.

---

## 1. Vocabulary Bans (Tiered)

The ban targets **metaphorical/filler use**. Literal use passes: "unlock the door" in a
locksmith article is fine; "unlock your potential" never is.

### Tier 1 — Hard bans (rewrite on sight; zero occurrences in deliverables)

| English (banned) | Greek equivalent to ban | Pattern type |
|---|---|---|
| delve (into) | «ας εμβαθύνουμε» / «ας βουτήξουμε» ως μετάβαση | filler transition |
| tapestry (metaphorical) | — (surfaces as awkward calque or untranslated) | ornament, zero info |
| "in today's fast-paced world" / "in today's digital age" | «στη σημερινή ψηφιακή εποχή», «στη σημερινή εποχή των γρήγορων ρυθμών» | throat-clearing opener |
| "in an ever-evolving/ever-changing world (landscape)" | «σε έναν κόσμο που συνεχώς εξελίσσεται…» | throat-clearing opener |
| unlock (metaphorical) | «ξεκλειδώστε (τις δυνατότητες…)» | fake-action verb |
| elevate (metaphorical) | «απογειώστε (την επιχείρησή σας)» | fake-action verb |
| game-changer / game-changing | «αλλάζει τα δεδομένα» ως κλισέ · αμετάφραστο "game-changer" σε ελληνικό κείμενο | hype, no spec |
| "it's important to note (that)" / "it's worth noting" | «είναι σημαντικό να σημειωθεί ότι», «αξίζει να σημειωθεί ότι» | hedge filler — just state the thing |
| "In conclusion" as a section opener | «Εν κατακλείδι» / «Συμπερασματικά» ως μηχανικό άνοιγμα επιλόγου | scaffolding |
| revolutionize / revolutionary (non-literal) | «επαναστατικός» για συνηθισμένα προϊόντα/υπηρεσίες | hype |
| harness / unleash (metaphorical) | «απελευθερώστε τη δύναμη του…» | fake-action verb |
| "navigate the world/complexities of" | «πλοηγηθείτε στον κόσμο του…» | metaphor filler |
| myriad / plethora | «πληθώρα» ως κλισέ (EL: ration as Tier 2 — legitimate word, AI-overused) | fake richness |
| "embark on a journey" | «ξεκινήστε το ταξίδι σας στο…» | metaphor filler |
| "look no further" | «μην ψάχνετε άλλο» | ad-copy filler |
| "a testament to" | — (calque reads unnatural; appears as «αποτελεί απόδειξη του πόσο…» padding) | ornament |
| treasure trove | «θησαυρός πληροφοριών» | fake richness |
| beacon (metaphorical) | «φάρος» (μεταφορικά) | ornament |
| seamless(ly) (metaphorical) | «απρόσκοπτη εμπειρία» | vague quality claim — name the actual behavior |
| "whether you're a … or a …" (audience-flattering opener) | «είτε είστε αρχάριος είτε επαγγελματίας» | fake inclusiveness — name the real audience (C06) |

### Tier 2 — Rationed (allowed, capped)

**Cap (house threshold, a rubric definition — not an empirical claim):** each Tier-2 item
appears at most once per 1,000 words and never twice in the same section. When the cap
forces a rewrite, replace the word with the concrete thing it was gesturing at.

| Word/phrase | EL counterpart | Replace with |
|---|---|---|
| leverage (verb) | «αξιοποιήστε» | the specific action ("use X to do Y") |
| robust | «ισχυρός» / «στιβαρός» | the property that makes it robust |
| comprehensive | «ολοκληρωμένος» | what it actually covers |
| crucial / essential / vital | «κρίσιμος» / «απαραίτητος» / «ζωτικής σημασίας» | why it matters, stated once |
| cutting-edge / state-of-the-art | «τεχνολογία αιχμής» | version, date, or spec |
| landscape (metaphorical) | «το ψηφιακό τοπίο» | the named market or segment |
| journey (metaphorical) | «ταξίδι» | the actual process and its steps |
| furthermore / moreover | «επιπλέον» / «επιπροσθέτως» | often deletable; connect ideas by content |
| boasts / "offers a wealth of" | «διαθέτει πληθώρα» | the feature list itself |
| streamline | «βελτιστοποιήστε» / «απλοποιήστε» | the steps that were removed |
| empower | «ενδυναμώστε» | who can now do what |
| holistic | «ολιστική προσέγγιση» | the components actually covered |
| "not only X but also Y" | «όχι μόνο… αλλά και…» | plain coordination |
| "at the end of the day" | «στο τέλος της ημέρας» (calque — see §1.3) | the conclusion itself |
| meticulous(ly) | «σχολαστικά» | the QA steps actually taken |

### 1.3 Greek calque patterns (translation-ese)

Greek slop is usually **translated English**, not natively bad Greek. Flag these patterns
explicitly:

- **Word-for-word calques of EN idioms/prepositional phrases**: «όταν έρχεται στο [θέμα]…»
  (from "when it comes to…" — write «όσον αφορά…»), «κάνει νόημα» (from "makes sense" —
  write «βγάζει νόημα» / «έχει νόημα»), «στο τέλος της ημέρας» (from "at the end of the
  day" — write «σε τελική ανάλυση»).
- **Translated openers no Greek editor writes unprompted**: «Σε έναν κόσμο που συνεχώς
  εξελίσσεται…», «Στη σημερινή ψηφιακή εποχή…». Delete; start with the answer.
- **Untranslated EN buzzwords where standard Greek exists**: "game-changer", "insights",
  "know-how" dropped into Greek copy. Exception: established loans and terms of art
  (SEO, μάρκετινγκ, e-shop) — the test is whether Greek trade press uses the term natively.
- **Uniform «Ας δούμε…» / «Ας εξερευνήσουμε…» section transitions** — the EL "let's dive in".
- **English abstract subject taking a Greek verb** (ruled 2026-08-10) — an English abstract noun left as the grammatical subject of a Greek clause, so the sentence has English syntax wearing Greek morphology. **No regex exists for this and none should be written**: the defect is a semantic mismatch between subject and verb with no surface string to match, and a pattern here would produce noise plus false confidence — the binding editor said so explicitly and declined to propose one. Prose guidance only; the editor catches it, a grep cannot.
- **Adjective inflation in translated-ad register**: stacked evaluative adjectives with no
  spec («μοναδική, πρωτοποριακή λύση» with nothing measurable behind them).

An EL page showing two or more calque patterns reads as translated, which also fails the
per-locale E-E-A-T step (SKILL.md step 9): locale-native evidence, not literal translation.

---

## 2. Structural Bans

| Banned pattern | Why | Do instead |
|---|---|---|
| Uniform paragraph lengths (every paragraph the same 2–3-sentence shape) | machine rhythm | vary within the O06 3–5-sentence band; an occasional 1–2-sentence paragraph for emphasis is a deliberate, marked exception |
| Every section ends with its own mini-summary ("Overall, …" / «Συμπερασματικά…» per section) | scaffolding; repeats the section it just ended | summarize once — in the O02 summary box and the conclusion |
| Rhetorical-question openers (intro or H2/H3 openers) | delays the answer; C02 wants answer-first | open with the claim, the number, or the definition |
| Listicle padding: "Let's dive in", "Without further ado", "Let's get started", «Ας ξεκινήσουμε» | zero information | delete — the heading already did this job |
| Negation-pivot tic more than once per piece: "It's not just X — it's Y" | AI signature cadence | state Y directly |
| Every H2 phrased identically (all gerunds, all "How to…") | template smell | phrase each heading by what the section proves |

---

## 3. Information-Gain Principle

**The generic-content test:** take any sentence. If it could sit unchanged in any
competitor's page on the topic, it either gets specific — a datum, a case, a mechanism,
a named entity — or it gets cut.

**Section-level rule:** every section must contain at least one element **not derivable
from its own heading**: a number with a unit, a named example, a mechanism ("X causes Y
because Z"), a decision rule, or a first-hand observation. A section that only re-expands
its heading is padding — cut it or merge it.

At audit time this is scored as evidence for E06 (Gap Filling), E08 (Depth Advantage),
and O09 (Information Density).

---

## 4. Specificity Ladder

Every substantive claim climbs as high as **the data you actually have** allows:

| Rung | Form | Example (placeholder form) |
|---|---|---|
| 1 — vague | quality asserted, nothing checkable | "Double opt-in improves deliverability." |
| 2 — quantified | number + unit, from provided data | "Double opt-in cut bounce rate by [CLIENT DATA: bounce-rate change]." |
| 3 — quantified + sourced | number + unit + named source + date | "Double opt-in cut bounce rate by [CLIENT DATA: figure] ([SOURCE: client analytics, date])." |

Deliverables aim for rung 3. The rungs are capped by real data: per the library's
**statistics rule**, every statistic comes from user-supplied data, a cited source, or is
marked as a `[CLIENT DATA: …]` / `[SOURCED STAT: …]` placeholder — a number is **never
invented** to reach a higher rung, and a rung the data cannot reach is simply not climbed.
A rung-1 claim that cannot be raised with real data gets cut, or rewritten as mechanism —
"because" beats "very".

---

## 5. Pre-Delivery Self-Check

- [ ] Zero Tier-1 hits (EN and EL)
- [ ] Tier-2 within caps (≤1 per 1,000 words each; never twice in one section)
- [ ] EL copy: zero calque patterns; reads locale-native
- [ ] No banned structures (uniform paragraphs, per-section summaries, rhetorical-question openers, padding lines)
- [ ] Every section passes the information-gain rule
- [ ] Every claim sits at its highest data-supported rung; placeholders where data is absent

Scored enforcement: content-quality-auditor runs these as audit scans (AS-1 to AS-4)
mapped onto existing CORE-EEAT items O09, O06, C02, E06, E08, R01, R02, R04, and Ept03 —
no new items, no framework changes.

---

## 6. Ruled Greek Regression Classes (binding-editor rulings)

Each family below was ruled FAIL-grade by the binding Greek editor on customer-visible
surfaces; recurrence in any fresh Greek output is an automatic FAIL in Mode B and editor
passes — a ruled lesson lives here as a carrier, never as a note somewhere else. Graders
grep the patterns given; the editor judges the rest.

**This section is rule text plus the measured reach of the screens it hands you** — and the
second half is deliberate, not leftover. *"Measured catching 1 of 5 constructed instances"* and
*"90/90, zero false positives"* tell you how far to trust a clean grep, which is part of using
the rule rather than evidence about it; the amendment requirement below obliges every new
family to record that hit rate **in its own entry**, so a measurement cannot be filed elsewhere
without contradicting the rule that demands it. Ruling dates and shell-check dates stay with
them — a date is what makes a measurement re-runnable.

**What is never here: the run a rule came from.** No suite name, no eval or deliverable label,
no quoted expectation, no count tied to any of them. That record is evidence for whoever audits
a rule, never instruction for whoever is writing one, and it lives in
[anti-slop-provenance.md](anti-slop-provenance.md). **If you are writing a deliverable, you are
finished at the end of §6.**

### FAIL-grade families

| # | Family | Ruled form → native form | Greppable pattern |
|---|---|---|---|
| 1 | Totality-with-numeral calque | «Όλα τα 7 καταστήματα δέχονται παραγγελίες…» → «Και τα 7 καταστήματα δέχονται παραγγελίες…» (or restructure: «Όλα τα καταστήματα — 7 συνολικά — …»). The native form generalises across genders and cases — «και οι 4 πάροχοι», «και τα 6 χρώματα» — so there is no construction this rule leaves you unable to write | `Όλα τα [0-9]` |
| 2 | Agency provenance labels/placeholders in publishable copy or schema | «(απαιτούνται στοιχεία τιμολόγησης)» left standing inside publishable copy or structured data → gap note in the report's gap table only; customer-voice hedging stays legitimate | `απαιτούνται στοιχεία` outside report/gap sections; any `[CLIENT DATA` / `[SOURCE NEEDED` inside paste-ready copy or schema |
| 3 | Mechanically translated UI/label terms | «Εκκρεμεί υποχρεωτικό» as a status label, taken word-for-word off an English UI string → natural Greek labels («Πεδίο / Τιμή / Σημείωση», «Κατάσταση: Εκκρεμεί») | — (editor judgment) |
| 4 | Query-style article-less labels in visible copy | «επισκευή ψυγείο Πάτρα» as page copy → «επισκευή ψυγείων στην Πάτρα»; keyword-export strings on explicitly keyword-list surfaces are exempt | — (editor judgment) |
| 5 | Negative-concord violation — an n-word in a finite clause with no preverbal «δεν» | «η προσφορά ισχύει για όλους και **υποχρεώνει κανέναν**» → «η προσφορά ισχύει για όλους και **δεν υποχρεώνει κανέναν**». Modern Greek is a strict negative-concord language: «κανείς / κανέναν / κανένα / καμία / τίποτα / ποτέ / πουθενά» beside a finite verb REQUIRE a preverbal «δεν». Without it a Greek reader resolves the affirmative — here "it obliges somebody" — and the commercial promise inverts. The telegraphic nominal parallel «Κόστος μηδέν, δέσμευση καμία.» licenses no finite verb, so it is no defence once a verb appears | n-word tokens `κανείς` · `κανέν` · `καμί` · `τίποτ` · `πουθενά` · `ποτέ` — matched CASE-INSENSITIVELY, since sentence-initial «Κανείς», «Κανένα», «Καμία», «Ποτέ» are the same tokens — each hit hand-checked for a preverbal «δεν» in its own clause, that licenser matched case-insensitively too («Δεν») (approximation — limits stated under the table) |
| 6 | "Costs-zero" calque in publishable copy | «κοστίζει μηδέν» → «δεν κοστίζει τίποτα» / «είναι δωρεάν». The defect survives inflection and derivation, and so must the check: «κοστίζ**ουν** μηδέν», «κοστίζει **απολύτως** μηδέν», «κοστίζει **μηδενικά** ευρώ», sentence-initial «**Κ**οστίζει μηδέν», and the digit form «κοστίζει **0** ευρώ» are one family, not five defects | Two-step screen, both steps case-insensitive **under a UTF-8 locale** (see the governing note below). NET: `μηδ[εέ]ν` — the bracket is load-bearing, since «μηδέν» carries the tonos but its derivatives move it off the ε («μηδενικά», «μηδενικό»), so either spelling alone catches only half the family. RANK the hits with the verb stem `κοστίζ`, which covers κοστίζει/κοστίζουν/κοστίζοντας and any intervening adverb. Known escape, hand-checked: a zero written as a digit — `κοστίζ[^.]{0,20}0 ?ευρώ` · `κοστίζ[^.]{0,20}0 ?€` (written as two patterns rather than one alternation because an unescaped pipe inside a table cell splits the row — it did, and this line is the fix). Verbless nominal parallels («Μηδέν κόστος, μηδέν δέσμευση.») surface on the net and are correct Greek — family 5's protected list governs them |
| 8 | Internal artefact names, framework IDs and skill slugs on a client-read surface | «Παραδόσεις σε άλλες **δεξιότητες**» / «τρέξτε τη δεξιότητα `keyword-research`» / «(ρύθμιση R2 / **CORE-EEAT O05**)» **in a sentence the client is meant to read** → name the **job**, never the artefact: «τρέξτε την ανάλυση λέξεων-κλειδιών», «ο κανόνας για τα δομημένα δεδομένα». Translating the artefact name fails the same way leaving it in English does — «δεξιότητα» in Greek is a person's competence, so "hand this to a skill" gives a client nothing to act on, and a framework item ID is a coordinate in a document they have never seen. **Promoted from advisory to FAIL-grade on 2026-08-10**: fix-on-touch failed three recorded passes, which is the promotion threshold this table uses. **Exemption — the test is the reader, not the section** (ruled 2026-08-10; the same test family 7 runs, for the same reason). A **run handle** — a skill slug, a framework item ID, an internal artefact name, a **settled-ruling ID** (`ruling R2`, `ruling R3 + amendment 9a`) or a **repo path** (`docs/loop/SETTLED-RULINGS.md`) — survives on a surface addressed to whoever operates the library, and never in client prose. **Ruling IDs and repo paths joined this list on 2026-08-13 (finding 80)**: the substantive statement stays, in the client's own terms — "One accurate schema type per page, so the markup describes what the page is" says everything a client needs, while "(ruling R2)" adds nothing they can act on and names a register they cannot read. A path into this repository is meaningless on a client surface for the same reason, and moves to the operator block with the handles. The gloss exemption below does not reach either of them: it covers framework **names** a client may meet again in their own analytics, not internal register IDs. An operator-addressed surface **sitting inside a client deliverable is still an operator surface**, and the handle stays: a «Επόμενα βήματα για την ομάδα σας» block, an appendix of follow-up runs, a handoff table of URL → next run. The same handle in a sentence the client is meant to read is family 8. Two conditions, both required: the operator block is **labelled** as one, and each handle carries its job in the client's words beside it — an unlabelled list of slugs dropped into a client report is client prose and fails. Worked both ways under the table | The 20 skill slugs are enumerable, so this is the cleanest net in the section — build it from `.claude-plugin/plugin.json` rather than hand-listing, then add `CORE-EEAT` · `\bCITE\b` · `\b[ACEIORT][0-9]{2}\b` · `\bEpt[0-9]{2}\b` · `\bExp[0-9]{2}\b` (framework item IDs, written as separate pipe-free patterns rather than one alternation because an unescaped pipe splits a table row — **measured 90/90 against the real ID set extracted from `references/core-eeat-benchmark.md` and `references/cite-domain-rating.md`, zero false positives on non-ID tokens**. An earlier form of this pattern was `\b[CORET][0-9]{2}\b` and caught **50 of 90**: its character class omitted `I`, and CITE's dimensions are C/**I**/T/E, so every I-dimension ID escaped, along with all of A, `Ept` and `Exp` — **which is why a probe must exercise each component, not the pattern as a whole**, since the alternation covered for the broken component and the whole-pattern probe passed. **Two known false-positive classes, both hand-checked rather than patterned away.** (i) `\b[ACEIORT][0-9]{2}\b` fires on any ordinary two-digit label of the same shape — a document numbering its own alerts `A10` / `A11` / `A12`, a checklist numbered `R01` — so each hit is checked against whether the document defines the label itself; widening the class to catch A-dimension items necessarily catches A-labels, which is a cost of coverage, not a bug. (ii) **`CITE` is four ordinary English letters.** Matched case-insensitively it fires on *cited*, *citation*, *cite* and *excite*, which appear in any report that sources anything — so match it **case-sensitively and word-bounded**, `grep "\bCITE\b"`, and never with `-i`. Checked at the shell 2026-08-10, GNU grep 3.11: on a line set containing all four English words plus «CITE score is 72», `grep -i CITE` returned every line and `grep "\bCITE\b"` returned only the framework name) · `δεξιότητ` (hand-checked: ordinary Greek for a person's competence, so it has legitimate uses). **Finding-80 additions, 2026-08-13 — ruling IDs and repo paths**: `ruling R[0-9]` · `amendment [0-9]` · `docs/loop/` · `references/`. **Match the first two case-insensitively.** Measured at the shell 2026-08-17 on a 4-line ruling-ID probe: the case-sensitive form returned 2 and missed sentence-initial «Ruling R3» and «RULING R5», while `grep -Ein` returned all 4 — the same component-blindness that cost family 8 its I-dimension IDs, in a different disguise. The `-i` buys no false positive on the statistics r² shape («the regression had r2 = 0.91» was not returned), because the net requires the literal word *ruling* immediately before the digit. Every surviving hit is then put to the reader test above, which has **three** branches and not two: (a) a handle inside a labelled operator block is a pass, not a finding; (b) a framework item ID standing as the **row label of a scored table, with that item's plain-language name beside it in the same row**, is a pass — the row-label carve-out ruled 2026-08-13, stated in full below; (c) a handle that is the **referent in client prose** is the defect. Branch (b) is the newest and the easiest to drop when re-deriving this row; provenance in `anti-slop-provenance.md`. **Exemption — the gloss rule, restored 2026-08-10 from the founding advisory this family was promoted out of.** A framework *name* the client is actually buying (CITE, CORE-EEAT, a named audit methodology) may appear on a client surface **if it is glossed on first use**, the same way «Core Web Vitals» is: name what it measures in the client's own vocabulary, then use the label. A label the client's own paperwork already uses — «Tier 1» off their own plan — is theirs and stays. What **glossing** never rescues is a framework **item ID** (`O05`, `T03`, `C01`) — a coordinate in a document the client has never seen — or a **skill slug**, which names a tool in a library they do not have. The distinction is whether the string denotes something the client can hold: a glossed methodology can be, a row number in an internal rubric cannot. **Exemption — the row-label carve-out, ruled 2026-08-13.** A framework item ID **may** stand as the row label of a scored per-item table on a client surface, provided the item's plain-language name sits beside it in that same row: the client reads «Intent Alignment» and the ID is only a stable handle for the row. It may never be the **referent** — "Items R02 and R03 failed" tells a client nothing, and that is the form this family bans. **A bare list of IDs inside a cell is not a row label and does not qualify**: "C02, C03 Pass; C01 Partial; C09 Fail" is the referent form wearing a table's clothes, and stays a defect — that distinction is what left finding 74's content-refresher fix standing after this ruling rather than reopening it. **The ruling was forced by an unsatisfiable pair**, not chosen as a loosening: both auditors' Output Validation required every one of the 80 (or 40) items scored **and** no item ID inside the client fence, and the scored per-item table is the instrument the client bought. The implementer stopped and asked rather than delete the column or quietly reword a stated rule, which is the behaviour this library wants — an agent that edits a rule to fit its own diff has removed the thing that would have caught it. **Skill slugs, command slugs, ruling IDs and repo paths get no equivalent carve-out** and stay banned fence-wide: none of them is ever a row label carrying its own meaning beside it |
| 7 | Connector placeholders on a client-read surface | «Πηγή δεδομένων: ~~search console» → the resolved source, by the three-step rule in the root `CLAUDE.md` Tool Connector Pattern section: (a) tool connected → its real name, «Search Console» / «Ahrefs»; (b) no tool but the data came from somewhere → that source in plain language, «από το αρχείο εξαγωγής που στείλατε», «χειροκίνητος έλεγχος, 10 Αυγούστου»; (c) no tool and no data → say so and drop the figure, «δεν συνδέθηκε εργαλείο — ο αριθμός δεν είναι διαθέσιμος», never a token in a number's place. A `~~category` token addresses the skill author and the operator; a client sees a double-tilde string with no referent. **Exemption — the test is the reader, not the section**: surfaces read only by author or operator keep the token (skill text and references, eval expectations, `CONNECTORS.md`, in-house gap tables and operator notes). Anything the client reads resolves it, report tables included — the same boundary family 8's run handles are governed by, and NOT family 2's: family 2 governs where a provenance MARKER may sit, this one governs a category token that has no client referent on any surface | `~~` (the double tilde is unique to this convention in the library — no hand-checking needed to spot it; the hand-check is only whether the surface is client-read) |

**Families 5 and 6 are one span, not two coincidences.** Both were ruled on a single clause of
paste-ready customer copy that had lost its negator *and* been built out of a translated
"costs-zero" frame. Where one appears, screen for the other.

**Governing note — every pattern in the right-hand column is a screen, not a verdict, and
two of them have already been measured failing.** A Greek plain-text pattern is defeated by
three things at once, so a clean grep means "nothing surfaced", never "clean": (i) **case** —
`grep -i` case-folds Greek only under a UTF-8 locale, so a default `LC_CTYPE=POSIX` shell
silently misses «Δεν», «Κανένα», «Κοστίζει»; (ii) **the accent moves under inflection and
derivation** — «μηδέν» → «μηδενικά» shifts the tonos off the ε, so an accented pattern and an
unaccented one each catch half of one family; (iii) **the surface form varies** — verbs
inflect, adverbs intervene between the words a fixed string joins, and a number can be
written as a digit. Both holes found so far are of exactly this shape, both had shipped
looking authoritative, and both were caught by the pipeline running the check rather than by
anyone reasoning about it in advance: family 5's lowercase-only token list and family 6's
fixed two-word string, which was measured catching **1 of 5** constructed instances of its
own ruled defect (2 of 5 with `-i`). Both closed 2026-08-10.
Consequence for reviewers: report a grep result as *"screened, nothing surfaced"* in those
words. A FAIL or a clean sheet on any Greek family is the binding editor's call on
hand-checked evidence, and a pattern's silence is not evidence.

**Requirement for adding or amending a family here.** A pattern may not ship
on the strength of matching the instance that motivated it. Before a family lands, write
three to six *constructed variants of its own defect* — inflect the verb, move the accent,
capitalise the first word, insert an adverb, swap the digit for the word — run the pattern
against them, and record the hit rate in the entry. A pattern that catches its founding
instance and nothing else is the failure mode this rule exists to prevent, and re-reading it
will never reveal that, because it still matches the example it was born from. Both of this
table's measured holes would have been caught by five minutes of this before shipping.

**Family 5 in detail — the hardest screen of the seven.** No plain-text
pattern can decide "finite verb, no «δεν» earlier in the clause"; this one is the practical
substitute. Two steps: (1) grep the six n-word tokens, case-insensitively; (2) from the
hits drop the lines that also carry a licenser — «δεν», «δε», «μην», «μη», «ούτε», «χωρίς»,
«πριν» — matched as WHOLE WORDS and, again, case-insensitively, and hand-check what is
left. Its stated limits, each of which produces wrong answers if ignored: **case-insensitive
matching is not free in Greek** — `grep -i` case-folds Greek only under a UTF-8 locale, so
in a default `LC_CTYPE=POSIX` shell `grep -i 'δεν'` silently misses «Δεν» while the same
pattern under `LC_ALL=C.UTF-8` matches it (checked in this repo's environment 2026-08-10,
GNU grep 3.11, on the line «Δεν χρεώνουμε καμία προμήθεια.»), so an implementer rebuilding
this check handles capitals deliberately — set a UTF-8 locale, or write both cases into the
pattern («[δΔ]εν», «[κΚ]ανέν», «[κΚ]αμί»), which is safe in either locale because an explicit
two-character bracket is not a range. A Greek *range* is safe in neither: `[α-ω]` aborts the
grep with `Invalid collation character` and exit status 2, so never reach for one (both
checked 2026-08-10, same environment) — and never assumes `-i` did it; the licenser test
must be word-bounded, because as substrings these
strings misfire badly in both directions («δεσμεύει» contains `δε`, «μηδέν» contains `μη`,
«μηδενικό» contains `δεν` — a substring filter would have exempted the founding instance
itself), and Greek word boundaries are not reliably expressible in every grep; it is
line-based, so a clause split across two lines, or one line holding two clauses with the
«δεν» in the wrong one, both mislead it; verbless fragments are correct Greek and will be
flagged («Κόστος μηδέν, δέσμευση καμία.», «Καμία χρέωση.»); **`ποτέ` matches inside «αποτέλεσμα» / «αποτελέσματα»** — proven at the shell; in a performance or analytics report «αποτέλεσμα» is unavoidable, so this family over-generates badly on any reporting deliverable and its hits there are mostly this. Questions and conditionals
license the n-word with no «δεν» and are correct («Έχετε καμία απορία;», «αν χρειαστείτε
τίποτα»). It proposes candidates; the editor rules.

**Scope — families 7 and 8 are language-neutral, ruled on Greek evidence.** Both sit in a
section headed "Greek" because that is where the editor found them and where their FAIL
grade was ruled, but neither defect is Greek. A `~~category` token has no client referent in
any language, and neither has a run handle: `domain-authority-auditor` and `CORE-EEAT O05`
are exactly as opaque to an English reader as to a Greek one. The same rule has since been
applied on English report surfaces library-wide. Read both families as *ruled here, enforced
everywhere* — an English deliverable does not sit outside their reach. The language-independent
statement of family 7 is the root `CLAUDE.md` Tool Connector Pattern section; this entry is
its Greek carrier and, because the double tilde is unique to the convention, the library's
greppable check for it in any language.

**Family 8 in detail — the reader test, worked both ways.** One slug, one deliverable, two
verdicts, and the only thing that changes is who the surrounding block is addressed to.

- **PASS.** A table headed «Επόμενα βήματα — παραδόσεις» whose row reads
  «/blog/kalliergeia-vasilikou → `content-refresher` (ανανέωση υπάρχοντος άρθρου)». The
  heading says who the block is for, the handle is what that person types, and the job is
  glossed beside it. The block ships inside the client's report and is still not client prose.
- **FAIL.** The same slug in the report's own sentences: «Στείλαμε τις διευθύνσεις στο
  content-refresher για ανανέωση». That asks the client to act on a name they hold nothing
  for — and no gloss rescues it, because the string is not what they are missing.

The test decides **where a handle may sit, and nothing else.** It does not reach the gloss
rule: a framework *name* is still glossed on first use wherever a client meets it, and a
framework *item ID* or a *skill slug* is still never glossed into client prose. Glossing is
not what makes those two opaque, so glossing is not what would fix them.

**When a family-8 hit traces to a template, fix the template.** A skill whose own client-facing
template orders the defect — a client report section that instructs the writer to name another
skill by slug, or prints framework item IDs as the referent of its own prose — will keep producing
it whatever this table says, and the deliverable-side fix will be re-broken by the next run. Treat
a mandated violation as a defect in the ordering skill, not in the output.

**Check the carve-out before you delete a column.** This paragraph read "prints a **column** of
framework item IDs" until 2026-08-17, and in that form it ordered the deletion of the one thing the
row-label carve-out protects: the ID column of a scored per-item table, beside each item's
plain-language name. An implementer sent to "fix the template" on that wording would have removed
the instrument the client bought — and would have been **following this carrier while breaking the
ruling**, with no way to tell from here that the two disagreed. Where a template is *mandated* to
print IDs by a rule one file over, the finding is a contradiction to escalate, not a column to
delete. That escalation is what produced the 2026-08-13 ruling in the first place.

### Advisory families (fix on touch; internal-report surfaces non-blocking)

- **«νίκη» for "win" — net on the noun, not the adjective.** «Γρήγορα κέρδη» / «Γρήγορη νίκη» for "quick wins" → «Άμεσες βελτιώσεις» / «Άμεσα οφέλη» / «Άμεσο όφελος» (or keep EN "quick wins"). Not «Γρήγορες διορθώσεις», which is natural Greek for *quick fixes* — see the protected list below. The ruling is about the metaphor, not the adjective: an entry netting the two-word phrase is escaped by any writer who changes the adjective («η πιο **γρήγορη** νίκη», «η **φθηνότερη** νίκη»), which is family 6's failure shape exactly, so the net is the noun `νίκη`, ranked with `γρήγορ` · `φθηνότερ` · `εύκολ`. **Guard — `νίκη` is a substring of «Θεσσαλονίκη».** Bare, the net fires on «Θεσσαλονίκη» / «Θεσσαλονίκης», a city that belongs in the delivery copy of half the Greek shops there are, and on given names built the same way («Βερονίκη», «Ανδρονίκη»). Screen the city out by negative context — `grep -P "(?<!Θεσσαλο)νίκη"` — which is the one form measured working in **both** locales (checked 2026-08-10, GNU grep 3.11: it returned «Η νίκη ήταν εύκολη» and «η πιο γρήγορη νίκη» and dropped both Θεσσαλονίκη lines under `LC_ALL=POSIX` *and* under `LC_ALL=C.UTF-8`). It does not drop the given names, which stay a hand-check. Do **not** reach for `grep -w` instead: it does the right thing under `LC_ALL=C.UTF-8` and silently returns the Θεσσαλονίκη lines under `LC_ALL=POSIX`, where Greek letters are not word characters — measured, same session. Do not reach for a Greek bracket range either — but **for a reason this file stated wrongly until 2026-08-17**. `[α-ω]` aborts with `Invalid collation character` and exit 2 **under `C.UTF-8` only**. Under `POSIX`, which is this environment's default (`LANG` empty, `LC_CTYPE=POSIX`), it does **not** abort: measured at the shell 2026-08-17, exit **0**, matching all 3 Greek lines by byte. The loud failure is the one the range gives you in one locale; **the quiet one — exit 0 having matched by byte — is the default**, and no exit-status check catches it. The two-character-bracket workaround is not locale-safe either: `ιδανικ[ηήοό]` matched **3** under POSIX against **2** under `C.UTF-8` and `rg`, the extra being «ιδανικά», which shares a UTF-8 lead byte. Set `LC_ALL=C.UTF-8` explicitly, or use `rg`, and record the locale beside the count — an unrecorded locale makes a Greek result unreproducible. Where `-P` is unavailable, run the bare noun and hand-drop the place-name and given-name hits, saying they were dropped
- «ετικέτα ενέργειας» → «ενεργειακή ετικέτα» · «βόρειο δωμάτιο» (orientation) → «βορινό δωμάτιο» · «πάνω μέρος του εύρους» → «άνω άκρο του εύρους»
- «εξουσία domain» → «το κύρος του domain» · «AI-απάντηση» compounds → «απάντηση AI» / «μηχανές AI» · «χάρτης GBP» for "GBP surface mapping" → «αντιστοίχιση σε επιφάνειες GBP»
- «σε φυσικό αναγνώστη» → «σε Έλληνα αναγνώστη» · «κάθε μοντέλο αναγράφει» → «σε κάθε μοντέλο αναγράφεται»
- **English artefact names in Greek client-visible prose** (2026-08-10) — «το skill» / «του skill», «το template» / «του template», «στη βιβλιοθήκη μας», «Εκτελέστε <skill-name>» → «η μεθοδολογία μας» / «η μεθοδολογία ελέγχου» / «το πρότυπο ελέγχου». A Greek reader sees an untranslated token with no referent («Ορισμός (από το skill)»). Fix it on ANY surface the client reads, report surfaces included — this is **not** family 2: report surfaces are family 2's sanctioned home, and this class is the internal artefact's NAME leaking, not a provenance marker sitting where it belongs. Greppable in Greek prose: `το skill` · `του skill` · `το template` · `του template` · `βιβλιοθήκη μας` · `δεξιότητ` (this last one hand-checked — «δεξιότητα» is ordinary Greek for a person's competence and has legitimate uses). Translating the artefact name fails the same way leaving it in English does: «δεξιότητα» in Greek is a personal competence, so «τρέξτε τη **δεξιότητα** keyword-research» gives a client nothing to act on — name the job, not the artefact («τρέξτε την ανάλυση λέξεων-κλειδιών»). This class is the advisory ancestor of family 8, and **family 8's reader test governs it too**: the same handle in a labelled operator block («Επόμενα βήματα για την ομάδα σας») is not a hit. Writing this carrier did not stop the class inside a day, so a Greek pass greps it every time instead of treating it as settled
- **Process machinery as client vocabulary** (2026-08-10) — internal process nouns with no client referent: «σε αυτή την **εκτέλεση**», «**το βήμα** εξόρυξης», «(**χειροκίνητη βαθμίδα**)». Native alternatives, both ruled: «Σε αυτή την **ανάλυση**», «κύκλος». The move is to name what the client gets, not the machinery that produced it; the editor ruled those instances and those two replacements, so any other wording is editor judgment rather than a ruled form. **Sibling of the English-artefact-name class above** — same shape (an internal noun with no client referent), different token set: there the artefact's NAME, here the process's. Review them as one family, grep them as two. Greppable but hand-checked, since each token has legitimate uses («εκτέλεση» of a contract, a «βαθμίδα» in education): `εκτέλεση` · `το βήμα` · `βαθμίδα` · `συνεδρί` (added 2026-08-10; the ruled replacement is the same one «εκτέλεση» already has, «σε αυτή την ανάλυση». Greek-specific aggravation: «Συνεδρίες» is GA4's own Greek UI string for *sessions*, so an analytics report using it for a working session collides with its own key metric — hand-check)
- **English residue never finished into Greek** (2026-08-10) — (a) raw English rubric sentences quoted into Greek body copy where the same sentence is already glossed in Greek beside them: **delete the English**, do not translate it a second time; (b) untranslated framework labels used as client-facing headings («Απόφαση: REFRESH ή rewrite;»); (c) «έτοιμες για copy-paste» → «έτοιμες για αντιγραφή»; (d) «(user-provided)» → «(στοιχεία που παρείχατε εσείς)»; (e) English title-case and «&» inside Greek headings — Greek does not title-case content words, and «&» is written «και». **Exempt, keep verbatim** (flagging these is itself the error): configuration values and identifiers — «DENY or SAMEORIGIN», «1; mode=block», «nosniff», «strict-origin-when-cross-origin», «ERR_TOO_MANY_REDIRECTS» — nginx directives, URLs, and genuine brand names (Solar Keymark, BoxNow, Skroutz)
- «τομέας» for *domain* → keep *domain* («Κύρος domain», «260 αναφέροντα domains», «Παλαιότητα domain»); «τομέας» is a sector, and the same reports use «κλάδοι» for sectors a screen later · «προμηθευτής» for a data provider → «πάροχος» (a supplier supplies goods) · «πάνελ» for a question set → «σετ» (a Greek «πάνελ» is a discussion panel) · «εφευρίσκω» for data → «επινοώ» (εφευρίσκω is for devices). Greppable but hand-checked, since each token has legitimate uses: `τομέα` · `προμηθευτ` · `πάνελ` · `εφευρ`
- «απο-ευρετηρίαση» → «αποευρετηρίαση» — Greek prefixes attach without a hyphen, the same pseudo-compound shape ruled against in «AI-απάντηση» above · «μακριάς ουράς» → «μακράς ουράς» (μακρύς is physical length). Greppable: `απο-ευρετηρίαση`, and the general shape — a Greek prefix immediately followed by a hyphen · `μακριάς`

### Not errors — do not "correct" (editor's protected list)

**Ruled 2026-08-10 on family 6's net, both correct Greek**: «δείχνει μηδέν» — family 6 is a lexical verb calqued out of the negative construction, and «δείχνω» taking a bare numeral is native («το θερμόμετρο δείχνει μηδέν»); and «Ο στόχος είναι μηδέν» — a copula with a numeral predicate stating a target, clean, no edit. Both surfaced on the widened net and both were ruled correct by the editor, which is the net behaving as designed: it proposes, the editor rules. (The first still earned an unrelated edit in its own document, where «δείχνει» is used ~8 times as *points to*, so the heading parsed as "although it points to zero" — a local ambiguity, not a family-6 defect.)

A false positive is itself a defect: §6 must never require a banned phrasing and must never
flag correct Greek. The forms below were checked by the binding editor and ruled correct as
written — leave them alone.

- Regional/administrative forms and place names: «νομό Ηρακλείου», «Θεσσαλονίκη» /
  «Θεσσαλονίκης» (a city, not the quick-wins metaphor — see the `νίκη` guard above)
- Standard Greek vocabulary: «πλαφόν», «ελλείψει», «συναπτά έτη», «αυστηροποίηση»,
  «διαστασιολόγηση», «ευρετηρίαση»
- «Μη αυτόματες ενέργειες» — Search Console's own Greek UI string; reproduce it verbatim
- «Γρήγορες διορθώσεις» — natural Greek for *quick fixes*, NOT the ruled quick-wins calque
- Enclitic double accents («κατάστημά σας», «κείμενό της», «κτήματός μας») and synizesis
  monosyllables (για, μια, πιο, ποιο) — both correct, and the double accent is correctly
  withheld where the host word does not take one («κείμενο του site σας»)
- Authentic quoted client speech in its own register («πόσο πρόστιμο τρώμε;»)

New rulings append here in the same wave they are issued.

**End of rule text.** Everything in this file is a rule, the reasoning that makes one
followable, the measured reach of one — how far a screen was proven to catch and what defeats
it — or the date that makes any of those three re-checkable.
What was separated out on 2026-08-10, and stays out, is the evidence a rule was ruled *on*:
which suite, which run, which deliverable, how many times a class hit one of them, in whose
words. That is the separation that keeps a required read safe to read, and a calibration figure
is not that evidence.

Provenance for the rules above — the evidence each one was ruled on — is kept in
[anti-slop-provenance.md](anti-slop-provenance.md). That file is for graders and rule authors
and is **not** an executor's read: if you are writing a deliverable, you are finished here.
**Every line there carries a `[PROVENANCE — not a rule]` marker**, so a search that reaches into
it announces itself even when the hit arrives as one line with no heading in view.
