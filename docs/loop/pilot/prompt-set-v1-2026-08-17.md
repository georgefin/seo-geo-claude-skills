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

**Version discipline (§1)**: this is **v1**. Adding or rewording a prompt changes the population and
moves every derived rate without anything having happened in the world. Any change makes v2, dated,
and every figure states which version it covers.

**Scope**: the two clusters Sani named as most critical and urgent — **αφυγραντήρες**
(dehumidifiers) and **θερμοπομποί** (convector heaters) — plus a brand-entity block that spans both.
40 prompts: 26 Greek, 14 English.

**Ownership is not yet assigned.** Per `references/query-cluster-ownership.md`, each cluster needs
one owning property and one owning URL before content is commissioned. The portfolio has six
properties (four of them brand microsites), and the assignment is a commercial decision. Until it
is made, field 6 of every capture reads `no owner assigned` — which is a finding, not a blank, and
is the fastest way to make the cost of not deciding visible.

---

## Cluster A — αφυγραντήρες / dehumidifiers

| ID | Prompt (verbatim) | Lang | Stage |
|---|---|---|---|
| A1 | γιατί έχω υγρασία και μούχλα στο υπόγειο; | el | problem-aware |
| A2 | πώς θα σταματήσω τα θολά τζάμια και την υγρασία στο σπίτι τον χειμώνα; | el | problem-aware |
| A3 | η μπουγάδα δεν στεγνώνει μέσα στο σπίτι, τι μπορώ να κάνω; | el | problem-aware |
| A4 | έχω μούχλα στους τοίχους της κρεβατοκάμαρας, φταίει η υγρασία; | el | problem-aware |
| A5 | αφυγραντήρας ή καλύτερος εξαερισμός για υγρασία σε υπόγειο; | el | solution-aware |
| A6 | πόσα λίτρα αφυγραντήρα χρειάζομαι για διαμέρισμα 90 τ.μ.; | el | solution-aware |
| A7 | τι διαφορά έχει ο αφυγραντήρας με συμπιεστή από τον αφυγραντήρα αφύγρανσης; | el | solution-aware |
| A8 | πόσο ρεύμα καταναλώνει ένας αφυγραντήρας αν δουλεύει όλη μέρα; | el | solution-aware |
| A9 | δουλεύει ο αφυγραντήρας σε κρύο υπόγειο τον χειμώνα; | el | solution-aware |
| A10 | ποια μάρκα αφυγραντήρα είναι αξιόπιστη στην Ελλάδα; | el | brand-aware |
| A11 | ποιος είναι ο καλύτερος αφυγραντήρας για σπίτι το 2026; | el | brand-aware |
| A12 | πού μπορώ να αγοράσω αφυγραντήρα Meaco στην Ελλάδα; | el | brand-aware |
| A13 | Kullhaus alpha Q13L ή Meaco Arete — ποιο να πάρω; | el | decision |
| A14 | αξίζει ο Kullhaus alpha Q20L για υπόγειο 60 τ.μ.; | el | decision |
| A15 | τι εγγύηση και σέρβις έχει ο αφυγραντήρας Meaco στην Ελλάδα; | el | decision |
| A16 | why is my basement damp and mouldy in Greece? | en | problem-aware |
| A17 | what size dehumidifier do I need for a 90 sqm apartment? | en | solution-aware |
| A18 | dehumidifier for a holiday home in Greece that sits empty over winter | en | solution-aware |
| A19 | best dehumidifier brand available in Greece | en | brand-aware |
| A20 | where can I buy a Meaco dehumidifier in Greece with a local warranty? | en | decision |
| A21 | Kullhaus vs Meaco dehumidifier — which is better for a damp basement? | en | decision |

**A18 and A20 carry the mandate's second audience.** An owner of a Greek holiday home, an
English-speaking resident, or an overseas buyer has a materially different problem — an unoccupied
property, no local service relationship, and warranty terms they cannot read in Greek. §1.1 rule 6:
an engine answering in English draws on a different source pool, and collapsing the two languages
into one row hides exactly the gap the client is paying to find.

---

## Cluster B — θερμοπομποί / convector heaters

| ID | Prompt (verbatim) | Lang | Stage |
|---|---|---|---|
| B1 | πώς να ζεστάνω ένα δωμάτιο χωρίς κεντρική θέρμανση; | el | problem-aware |
| B2 | γιατί ανέβηκε τόσο ο λογαριασμός ρεύματος με τα ηλεκτρικά θερμαντικά; | el | problem-aware |
| B3 | κρυώνω σε ένα δωμάτιο του σπιτιού ενώ τα υπόλοιπα ζεσταίνονται, τι λύση υπάρχει; | el | problem-aware |
| B4 | θερμοπομπός ή κλιματιστικό inverter για θέρμανση; | el | solution-aware |
| B5 | θερμοπομπός ή θερμοσυσσωρευτής — τι συμφέρει; | el | solution-aware |
| B6 | πόσα watt θερμοπομπό χρειάζομαι για δωμάτιο 20 τ.μ.; | el | solution-aware |
| B7 | είναι οικονομικοί οι θερμοπομποί στην κατανάλωση ρεύματος; | el | solution-aware |
| B8 | μπορώ να βάλω θερμοπομπό σε μπάνιο ή παιδικό δωμάτιο με ασφάλεια; | el | solution-aware |
| B9 | ποια μάρκα θερμοπομπού είναι καλή για μόνιμη εγκατάσταση; | el | brand-aware |
| B10 | οι νορβηγικοί θερμοπομποί Nobo αξίζουν τα χρήματά τους; | el | brand-aware |
| B11 | Nobo ή Atlantic θερμοπομπός — ποια διαφορά έχουν; | el | decision |
| B12 | πώς δουλεύει ο προγραμματισμός και το wifi στους θερμοπομπούς Nobo; | el | decision |
| B13 | πού αγοράζω θερμοπομπό Nobo στην Ελλάδα με εγγύηση; | el | decision |
| B14 | how do I heat one room in a Greek apartment with no central heating? | en | problem-aware |
| B15 | electric convector heater vs inverter air conditioner for heating in Greece | en | solution-aware |
| B16 | are Norwegian Nobo panel heaters worth the price? | en | brand-aware |
| B17 | Nobo vs Atlantic convector heater — which for a rental apartment? | en | decision |
| B18 | best electric heater for a Greek apartment with no gas connection | en | brand-aware |

---

## Cluster C — brand and representation

These decide whether the entity is understood at all, and one of them is the pilot's most
commercially exposed finding.

| ID | Prompt (verbatim) | Lang | Stage |
|---|---|---|---|
| C1 | ποιες μάρκες αντιπροσωπεύει η Sani Hellas; | el | navigational |
| C2 | ποιος είναι ο επίσημος αντιπρόσωπος της Meaco στην Ελλάδα; | el | decision |
| C3 | Kullhaus Ελλάδα — ποια είναι η επίσημη αντιπροσωπεία; | el | decision |
| C4 | who is the official Meaco distributor in Greece? | en | decision |
| C5 | is Sani Hellas an authorised dealer for Nobo and Atlantic? | en | decision |

**C2 and C4 are the highest-value rows in the set and must be captured every cycle.** The pilot
recorded a generated summary crediting a competing Greek retailer with official Meaco
representation, and that was reproduced independently on a differently-worded Greek query which
returned both parties described as official. What is established: a competitor sells Meaco, appears
in the same results, and a search system produced prose crediting it with official status. What is
**not** established, and must not be written as though it were: who actually holds the appointment.
That is contractual, no search result settles it, and the client knows it while we do not.

The measurement question is therefore narrow and answerable: **across N captures, how often is each
party described as official, and what is cited as the source?** Field 5 (verbatim cited URLs) and
field 10 (answer excerpt) carry the whole finding. That is evidence a client can take to a brand
owner; "AI is confused about your distributor" is not.

---

## Running it

Per `references/ai-visibility-measurement.md` §4 and §8:

- **N = 3** repeats per prompt per engine per cycle, in one sitting. 40 prompts × 3 engines × 3
  repeats = **360 captures** per full cycle. If that is too much for cycle 1, cut **prompts**, not
  repeats — a smaller set measured properly beats a larger set measured once. Cluster C plus the
  decision-stage rows is the minimum viable subset (17 prompts, 153 captures).
- **Engines in precedence order**: ChatGPT Search, then Gemini / Google AI surfaces, then
  Perplexity. Other assistants take the cluster head prompts only, at a lower cadence.
- **Fresh logged-out session** per engine where the surface allows; record locale, language and
  logged-in state on every row. ChatGPT requires an account — use the same one throughout and record
  it.
- **Paste the prompt verbatim.** No follow-ups, and no rephrasing after a poor answer — a rephrase
  is a different prompt and gets its own row, or it measures the rephrasing.
- **Log failures** with reasons. They reduce N; they do not disappear.

**Before cycle 1, two questions need answering** and both are open in `CLIENT-MANDATE.md` §4:
what Peec AI can export and over what date range — which decides whether this is a measured
baseline or an observational one — and the cluster→property assignment, without which field 6
reads `no owner assigned` on all 360 rows.
