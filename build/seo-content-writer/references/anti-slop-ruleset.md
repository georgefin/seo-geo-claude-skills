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
- **Adjective inflation in translated-ad register**: stacked evaluative adjectives with no
  spec («μοναδική, πρωτοποριακή λύση» with nothing measurable behind them).

An EL page showing two or more calque patterns reads as translated, which also fails the
per-locale E-E-A-T step (SKILL.md step 9): locale-native evidence, not literal translation.

---

## 2. Structural Bans

| Banned pattern | Why | Do instead |
|---|---|---|
| Uniform paragraph lengths (every paragraph the same 2–3-sentence shape) | machine rhythm | vary 1–5 sentences by content; O06 chunking still applies |
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
invented** to reach a higher rung (failure-ledger entry F3 exists because a worked example
once modeled the opposite). A rung-1 claim that cannot be raised with real data gets cut,
or rewritten as mechanism — "because" beats "very".

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
