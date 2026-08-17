# Pilot Prompt Set — v1, 2026-08-17

**Governing specification**: `references/ai-visibility-measurement.md`. Read §1.1 for how a prompt
set is built, §3 for what each capture records, §4 for the sampling discipline. This file is the
artefact those rules operate on.

**Status: DRAFT, and deliberately incomplete.** §1.1 names the client's own sales questions as the
highest-yield source, and they are the one source no tool supplies. **Nothing here came from
them** — this set was built from the remaining five sources (buying-stage ladder, comparison and
alternative prompts, the Greek keyword forms, language pairs, and the pilot's own findings). Fold
the sales questions in before this is locked; expect them to replace rather than supplement several
rows below, because a real buyer's phrasing beats a constructed one every time.

**Version discipline (§1)**: this is **v1**, and it has never been used for a capture. Once a
capture is taken against it, any change makes v2, dated, and every figure states which version it
covers — because adding or rewording a prompt moves every derived rate without anything having
happened in the world.

**Editor pass applied 2026-08-17, and it caught a counting error in this file's own header.** The
first draft claimed "40 prompts: 26 Greek, 14 English" while its tables held 44, so every capture
figure derived from it was wrong — in a document whose subject is stating N beside a figure. Counts
below are recounted from the tables and are stated per cluster so the total is checkable rather
than asserted. The pass also replaced an invented Greek term that made one row unanswerable, and
removed the one prompt that led the witness. Both are recorded under §5.

**Scope**: the two clusters Sani named as most critical and urgent — **αφυγραντήρες**
(dehumidifiers) and **θερμοπομποί** (convector heaters) — plus a brand-and-representation cluster
that spans both.

| Cluster | Greek | English | Total |
|---|---:|---:|---:|
| A — αφυγραντήρες | 18 | 6 | 24 |
| B — θερμοπομποί | 13 | 5 | 18 |
| C — brand and representation | 5 | 3 | 8 |
| **Rate-feeding total** | **36** | **14** | **50** |
| Verification rows (§4 — excluded from every rate) | 0 | 2 | 2 |

**Ownership is not yet assigned.** Per `references/query-cluster-ownership.md`, each cluster needs
one owning property and one owning URL before content is commissioned. The portfolio has six
properties (four of them brand microsites), and the assignment is a commercial decision. Until it
is made, field 6 of every capture reads `no owner assigned` — which is a finding, not a blank, and
is the fastest way to make the cost of not deciding visible.

---

## Cluster A — αφυγραντήρες / dehumidifiers (24)

| ID | Prompt (verbatim) | Lang | Stage |
|---|---|---|---|
| A1 | γιατί έχω υγρασία και μούχλα στο υπόγειο; | el | problem-aware |
| A2 | ιδρώνουν τα τζάμια και έχω υγρασία στο σπίτι τον χειμώνα, τι να κάνω; | el | problem-aware |
| A3 | η μπουγάδα δεν στεγνώνει μέσα στο σπίτι, τι να κάνω; | el | problem-aware |
| A4 | έχω μούχλα στους τοίχους της κρεβατοκάμαρας, φταίει η υγρασία; | el | problem-aware |
| A5 | αφυγραντήρας ή εξαερισμός για την υγρασία στο υπόγειο; | el | solution-aware |
| A6 | πόσων λίτρων αφυγραντήρα χρειάζομαι για διαμέρισμα 90 τ.μ.; | el | solution-aware |
| A7 | τι διαφορά έχει ο αφυγραντήρας με συμπιεστή από τον desiccant; | el | solution-aware |
| A8 | πόσο ρεύμα καταναλώνει ένας αφυγραντήρας αν δουλεύει όλη μέρα; | el | solution-aware |
| A9 | δουλεύει ο αφυγραντήρας σε κρύο υπόγειο τον χειμώνα; | el | solution-aware |
| A10 | ποια μάρκα αφυγραντήρα είναι αξιόπιστη και έχει σέρβις στην Ελλάδα; | el | brand-aware |
| A11 | ποιος είναι ο καλύτερος αφυγραντήρας για το σπίτι το 2026; | el | brand-aware |
| A12 | πού μπορώ να αγοράσω αφυγραντήρα Meaco στην Ελλάδα; | el | brand-aware |
| A13 | Kullhaus Alpha Q13L ή Meaco Arete One 12L, ποιο να πάρω; | el | decision |
| A14 | αξίζει ο Kullhaus Alpha Q20L για υπόγειο 60 τ.μ.; | el | decision |
| A15 | τι εγγύηση και σέρβις έχει ο αφυγραντήρας Meaco στην Ελλάδα; | el | decision |
| A16 | έχω εξοχικό που μένει κλειστό όλο τον χειμώνα, τι να κάνω με την υγρασία και τη μούχλα; | el | solution-aware |
| A17 | γιατι εχω υγρασια και μουχλα στο υπογειο; | el · unaccented | problem-aware |
| A18 | ποιος ειναι ο καλυτερος αφυγραντηρας για το σπιτι το 2026; | el · unaccented | brand-aware |
| A19 | why is my basement in Greece always damp and mouldy? | en | problem-aware |
| A20 | what size dehumidifier do I need for a 90 sqm apartment? | en | solution-aware |
| A21 | I have a holiday home in Greece that's empty all winter — what dehumidifier should I leave running? | en | solution-aware |
| A22 | which dehumidifier brands can you actually buy in Greece? | en | brand-aware |
| A23 | where can I buy a Meaco dehumidifier in Greece with a local warranty? | en | decision |
| A24 | Kullhaus vs Meaco dehumidifier — which is better for a damp basement? | en | decision |

**A16 and A21 are the same buyer in two languages** — a property that sits empty over winter, with
no one to notice damp until spring. A16 was missing from the first draft, which had the English
holiday-home row and no Greek counterpart, although Greek owners of a village or seasonal house are
a large population. §1.1 rule 6: an engine answering in English draws on a different source pool,
and a language pair only measures that if both halves exist.

**A17 and A18 are unaccented on purpose, and must not be "corrected".** Most Greeks do not type
accents on a phone, so a fully accented set measures the accented-typing population only. These are
**input strings recorded verbatim on an operator surface**, not visible copy — the rule that
governs unaccented and Greeklish forms applies to what a client reads, and does not reach here.

---

## Cluster B — θερμοπομποί / convector heaters (18)

| ID | Prompt (verbatim) | Lang | Stage |
|---|---|---|---|
| B1 | πώς να ζεστάνω ένα δωμάτιο χωρίς κεντρική θέρμανση; | el | problem-aware |
| B2 | γιατί ανέβηκε τόσο ο λογαριασμός του ρεύματος από τα ηλεκτρικά θερμαντικά σώματα; | el | problem-aware |
| B3 | κρυώνω σε ένα δωμάτιο του σπιτιού ενώ τα υπόλοιπα ζεσταίνονται κανονικά, τι να κάνω; | el | problem-aware |
| B4 | θερμοπομπός ή κλιματιστικό inverter για θέρμανση; | el | solution-aware |
| B5 | θερμοπομπός ή καλοριφέρ λαδιού, τι συμφέρει; | el | solution-aware |
| B6 | πόσα watt πρέπει να έχει ο θερμοπομπός για δωμάτιο 20 τ.μ.; | el | solution-aware |
| B7 | οι θερμοπομποί είναι οικονομικοί στο ρεύμα; | el | solution-aware |
| B8 | είναι ασφαλής ο θερμοπομπός στο μπάνιο; | el | solution-aware |
| B9 | ποια μάρκα θερμοπομπού είναι καλή για μόνιμη εγκατάσταση; | el | brand-aware |
| B10 | αξίζουν τα λεφτά τους οι θερμοπομποί Nobo; | el | brand-aware |
| B11 | θερμοπομπός Nobo ή Atlantic, τι διαφορά έχουν; | el | decision |
| B12 | χρειάζεται το Nobo Hub για να ελέγχω τους θερμοπομπούς από το κινητό; | el | decision |
| B13 | πού αγοράζω θερμοπομπό Nobo στην Ελλάδα με εγγύηση; | el | decision |
| B14 | how do I heat one room in my apartment in Greece with no central heating? | en | problem-aware |
| B15 | in Greece, is it cheaper to heat a room with an electric convector heater or with the air conditioner? | en | solution-aware |
| B16 | are Norwegian Nobo panel heaters worth the money? | en | brand-aware |
| B17 | I rent out a flat in Greece — Nobo or Atlantic convector heaters for the tenants? | en | decision |
| B18 | what's the best electric heater for an apartment in Greece where the central heating is off? | en | brand-aware |

**B5 changed comparison mid-pass and the reason matters more than the wording.** It asked
θερμοπομπός against **θερμοσυσσωρευτής** — correct Greek, and a legacy category tied to the old
night tariff that almost no 2026 buyer is weighing. The comparison Greek buyers actually make is
against **καλοριφέρ λαδιού**. The row was not wrong; it was aimed at a decision nobody is making,
which is a wasted capture at the same cost as a useful one.

**B17 names the asker deliberately.** "Which for a rental apartment?" does not say whether the
person is the landlord or the tenant, and the answer inverts between them — fixed installation
against something portable that leaves with you. If a Greek counterpart is added later, «νοικιάζω»
carries the identical ambiguity in both directions and must be disambiguated there too.

**B18 was reframed off a UK assumption.** It asked about "no gas connection", which is how the
British market describes the problem. Greek apartments overwhelmingly have oil central heating that
is switched off or unaffordable, so the original drew a confident answer to a situation this
audience is not in.

**B16 is not harmonised to B10 on purpose.** "Norwegian Nobo panel heaters" is genuinely how the UK
market refers to them; the plainer Greek form is how a Greek buyer asks. The asymmetry is the
honest capture, and flattening it would measure our own editing.

---

## Cluster C — brand and representation (8)

These decide whether the entity is understood at all, and two of them are the pilot's most
commercially exposed finding.

| ID | Prompt (verbatim) | Lang | Stage |
|---|---|---|---|
| C1 | τι είναι η Sani Hellas; | el | navigational |
| C2 | ποιες μάρκες αντιπροσωπεύει η Sani Hellas; | el | navigational |
| C3 | ποιος είναι ο επίσημος αντιπρόσωπος της Meaco στην Ελλάδα; | el | decision |
| C4 | ποιος είναι ο επίσημος αντιπρόσωπος της Kullhaus στην Ελλάδα; | el | decision |
| C5 | έχει η Meaco επίσημο αντιπρόσωπο στην Ελλάδα και ποιος είναι; | el | decision |
| C6 | who is the official Meaco distributor in Greece? | en | decision |
| C7 | who is the authorised dealer for Nobo in Greece? | en | decision |
| C8 | who is the authorised dealer for Atlantic in Greece? | en | decision |

**C3, C5 and C6 are the highest-value rows in the set and must be captured every cycle.** The pilot
recorded a generated summary crediting a competing Greek retailer with official Meaco
representation, reproduced independently on a differently-worded Greek query which returned both
parties described as official. What is established: a competitor sells Meaco, appears in the same
results, and a search system produced prose crediting it with official status. What is **not**
established, and must not be written as though it were: who actually holds the appointment. That is
contractual, no search result settles it, and the client knows it while we do not.

The measurement question is therefore narrow and answerable: **across N captures, how often is each
party described as official, and what is cited as the source?** Field 5 (verbatim cited URLs) and
field 10 (answer excerpt) carry the whole finding. That is evidence a client can take to a brand
owner; "AI is confused about your distributor" is not.

**C5 exists because C3, C4 and C6 all presuppose an answer.** "Who is *the* official
representative" is what a buyer really types, so it stays — but the definite singular asserts that
exactly one appointment exists, and that framing is a known trigger for a confident invented answer
in precisely the case where the appointment is unsettled. C5 permits the answer "there isn't one"
or "I don't know", so a capture can distinguish an engine that **had** a name from an engine that
**produced** one.

**C1 will probably draw an invented description, and that is a result, not a failure.** Record it in
field 10 as what it is.

**C3 and C6 are a language pair with a known asymmetry, documented rather than smoothed over.**
«Αντιπρόσωπος» is a representative or agent; "distributor" is an importer or wholesaler. They are
the terms each market actually uses, so both stay — but a Greek/English difference in the results
may be the terms and not the languages, and no capture can separate them.

### Verification rows — excluded from every rate

| ID | Prompt (verbatim) | Lang |
|---|---|---|
| V1 | is Sani Hellas an authorised dealer for Nobo? | en |
| V2 | is Sani Hellas an authorised dealer for Atlantic? | en |

**These name the client, so field 2 is yes by construction and they can never feed a mention rate.**
§1.1: a prompt engineered to produce a mention measures the engineering. They are kept only as a
direct check on what an engine will assert when handed the client's name, they are split per brand
because a two-brand yes/no cannot record a split answer, and they are reported separately with that
limitation stated.

The first draft carried this as a rate-feeding row, phrased across both brands at once. That was
the one prompt in the set that led the witness, and it would have inflated every Cluster C figure
it touched.

---

## Running it

Per `references/ai-visibility-measurement.md` §4 and §8:

- **N = 3** repeats per prompt per engine per cycle, in one sitting. 50 rate-feeding prompts × 3
  engines × 3 repeats = **450 captures**, plus 18 for the two verification rows. If that is too much
  for cycle 1, cut **prompts, not repeats** — a smaller set measured properly beats a larger set
  measured once.
- **Minimum viable subset**: all of Cluster C (8) plus the decision-stage rows in A and B
  (A13, A14, A15, A23, A24, B11, B12, B13, B17 — nine) = **17 prompts, 153 captures**. It keeps the
  contested-representation rows and the rows closest to a purchase.
- **Engines in precedence order**: ChatGPT Search, then Gemini / Google AI surfaces, then
  Perplexity. Other assistants take the cluster head prompts only, at a lower cadence.
- **Fresh logged-out session** per engine where the surface allows; record locale, language and
  logged-in state on every row. ChatGPT requires an account — use the same one throughout and record
  it.
- **Paste the prompt verbatim.** No follow-ups, and no rephrasing after a poor answer — a rephrase
  is a different prompt and gets its own row, or it measures the rephrasing.
- **Log failures** with reasons. They reduce N; they do not disappear.

**Two checks before the first capture, both cheap and both blocking:**

1. **Verify every model string against the manufacturers' own catalogues** — A13 and A14 name
   Kullhaus Alpha Q13L / Q20L and Meaco Arete One 12L. A wrong model string sends the engine after
   a product that does not exist, and the row then measures nothing. A13 additionally pairs two
   capacities that should be comparable; if the real line-up does not match at 12–13L, repair the
   pairing rather than the spelling.
2. **Check A7's desiccant term against Sani Hellas's own product pages.** The first draft asked
   about «αφυγραντήρας αφύγρανσης», which is a tautology — "dehumidifier of dehumidification" — that
   no Greek retailer or buyer uses and that names no type an engine can distinguish, so the row was
   unanswerable as asked. It now uses the English "desiccant", which is genuine Greek market usage
   for this category rather than a Greeklish lapse. If the client's own pages say «ξηραντικού
   τύπου» or «με αφυγραντικό υλικό», use their wording: it is what their buyer has already read.

**Two questions remain open in `CLIENT-MANDATE.md` §4** and both bear on cycle 1: what Peec AI can
export and over what date range — which decides whether this is a measured baseline or an
observational one — and the cluster→property assignment, without which field 6 reads
`no owner assigned` on all 450 rows.
