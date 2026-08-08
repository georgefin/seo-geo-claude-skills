# Anti-Slop Audit Checks (AS-1 to AS-4)

Enforcement side of seo-content-writer's
[anti-slop ruleset](../../../build/seo-content-writer/references/anti-slop-ruleset.md)
(the canonical ban lists — the two files change together). Four scans that produce
**evidence for existing CORE-EEAT items**. They add no new items, change no weights, and
never alter the 80-item frame: each hit is recorded in the Notes column of the item it
evidences, and the item's final score still follows the benchmark's own
Pass/Partial/Fail criteria.

## Scan Summary

| Scan | Detects | Evidences (primary) | Evidences (secondary) |
|---|---|---|---|
| AS-1 Slop-vocabulary density | Tier-1/Tier-2 AI-tell vocabulary, EN + EL calques | O09 Information Density | Ept03 Professional Vocabulary |
| AS-2 Structural patterns | uniform paragraphs, per-section summaries, rhetorical-question openers, padding lines | O06 Section Chunking | O09, C02 Direct Answer |
| AS-3 Per-section information gain | topic-generic sentences; sections adding nothing beyond their heading | E06 Gap Filling | E08 Depth Advantage, O09 |
| AS-4 Specificity rungs | vague claims that available data could have quantified or sourced | R01 Data Precision | R04 Evidence-Claim Mapping, R02 Citation Density |

**Recording format** — in the evidenced item's Notes:
`[AS-n] verbatim quote or measurement — confidence label`. Record each hit once, in the
primary item; cross-reference (do not re-count) in secondary items. Priority improvements
built from scan hits use the standard Finding / Evidence / Impact / Fix + confidence
format from SKILL.md Step 4.

Thresholds below are **house rubric definitions** (like R01's "≥5 data points"), not
empirical claims.

---

## AS-1 — Slop-Vocabulary Density Scan

**Procedure**: scan the full text for Tier-1 (hard-ban) and Tier-2 (rationed) terms.
Canonical lists: anti-slop ruleset §1. Core scan set:

- **EN Tier 1**: delve, tapestry (metaphorical), "in today's fast-paced world" / "in
  today's digital age", "ever-evolving", unlock (metaphorical), elevate (metaphorical),
  game-changer, "it's important to note", "it's worth noting", "in conclusion" as a
  section opener, revolutionize (non-literal), harness/unleash (metaphorical), "navigate
  the world/complexities of", myriad, plethora, "embark on a journey", "look no further",
  "a testament to", treasure trove, beacon (metaphorical), seamless (metaphorical),
  "whether you're a … or a …" openers.
- **EL Tier 1 + calques**: «ας εμβαθύνουμε» / «ας βουτήξουμε», «στη σημερινή ψηφιακή
  εποχή», «σε έναν κόσμο που συνεχώς εξελίσσεται», «ξεκλειδώστε» (μεταφορικά),
  «απογειώστε», «αλλάζει τα δεδομένα» ως κλισέ / αμετάφραστο "game-changer", «είναι
  σημαντικό να σημειωθεί ότι», «εν κατακλείδι» / «συμπερασματικά» ως μηχανικά ανοίγματα,
  «πλοηγηθείτε στον κόσμο του…», «απρόσκοπτη εμπειρία», «είτε είστε … είτε …», and the
  calque patterns («όταν έρχεται στο…», «κάνει νόημα», «στο τέλος της ημέρας»).
- **Tier 2 (both languages)**: leverage, robust, comprehensive, crucial/essential/vital,
  cutting-edge, landscape/journey (metaphorical), furthermore/moreover, boasts,
  streamline, empower, holistic, "not only … but also", meticulous — cap ≤1 per 1,000
  words per term, never twice in one section.

**Scoring guidance** (follows directly from O09's Pass criterion "no filler"):

- Any Tier-1 hit → O09 cannot score Pass; ≥3 Tier-1 hits per 1,000 words → O09 Fail.
- Tier-2 terms over cap → filler evidence against O09.
- EL pages with ≥2 calque patterns → translated-ad register; record also under Ept03
  (professional vocabulary displaced by translation-ese).

**Confidence**: hits are quoted verbatim from the content → **Confirmed**.

## AS-2 — Structural-Pattern Scan

**Procedure**: check —

1. Paragraph-length distribution: nearly all paragraphs the same shape/length = uniform-
   rhythm hit.
2. Per-section closing summaries ("Overall, …" / «Συμπερασματικά…» ending multiple
   sections) — count occurrences.
3. Rhetorical-question openers in the introduction or as H2/H3 openers.
4. Padding lines: "Let's dive in", "Without further ado", "Let's get started",
   «Ας ξεκινήσουμε», «Ας δούμε»-type transitions.
5. Negation-pivot tic ("It's not just X — it's Y") more than once.

**Scoring guidance**: uniform rhythm → O06 evidence (mechanical chunking); repeated
per-section summaries and padding lines → O09 evidence (repetition/filler); a rhetorical-
question opener that delays the core answer past the first 150 words → C02 evidence.

**Confidence**: structure is directly observed → **Confirmed**.

## AS-3 — Per-Section Information-Gain Check

**Procedure**: for each H2/H3 section, ask: does it contain at least one element **not
derivable from its own heading** — a number with a unit, a named example, a mechanism
("X causes Y because Z"), a decision rule, or a first-hand observation? Then spot-check
sentences against the generic-content test: could this sentence sit unchanged in any
competitor's page on the topic?

**Scoring guidance**:

- Section fails the derivability test → O09 evidence (padding) + E08 evidence (no depth
  beyond the outline).
- With competitor content provided: passages interchangeable with competitors' →
  E06 evidence, **Confirmed**.
- Without competitor content: generic-ness is an indirect judgment → record as **Likely**
  (sentence is topic-generic boilerplate) or **Hypothesis** (needs a competitor pull to
  confirm), and say which verification step would confirm it.

## AS-4 — Specificity-Rung Scoring

Ladder (anti-slop ruleset §4): **rung 1** vague claim → **rung 2** quantified claim →
**rung 3** quantified + sourced claim.

**Procedure**: list the content's core claims (the ones its headings promise). Rate each
claim's rung. Then check two directions:

- **Too low**: claims stuck at rung 1 where the user-provided data block could have
  raised them → R01 evidence (vague descriptions where precise data was available).
- **Falsely high**: rung-2/3-shaped numbers with no source and no `[CLIENT DATA: …]` /
  `[SOURCED STAT: …]` placeholder → R04 evidence (claim without evidence); if such
  numbers also contradict each other, that is R10 territory under R10's own criteria.
  Missing/thin sourcing across the piece → R02 evidence.

**Scoring guidance**: rung-1-dominant content → R01 cannot score Pass; unsourced figures
→ R04 evidence.

**Confidence**: rung ratings on the provided text → **Confirmed**. "The data could have
raised this claim" → **Confirmed** if the user supplied the data block, otherwise
**Likely**.

---

## Boundaries

- Do **not** create new item IDs, do not renumber, and do not adjust dimension weights —
  scans supply observations; the benchmark criteria decide scores.
- Do not double-count one hit across multiple items' scores.
- A clean anti-slop scan is not a quality verdict by itself — content can be slop-free
  and still fail on accuracy, coverage, or E-E-A-T grounds.
