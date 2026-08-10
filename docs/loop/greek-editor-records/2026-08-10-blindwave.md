# Binding Greek editor pass — blind Mode B wave, 2026-08-10

Editor: greek-content-editor (binding). Coordinator: Herbert.
Files judged (all read by absolute path in the session scratchpad):

1. `/tmp/claude-0/-home-user-seo-geo-claude-skills/97cf34c3-b42b-5cf3-8465-509fe6d74814/scratchpad/blind-linking-out-e3.md`
2. `/tmp/claude-0/-home-user-seo-geo-claude-skills/97cf34c3-b42b-5cf3-8465-509fe6d74814/scratchpad/blind-keyword-out-e2.md`
3. `/tmp/claude-0/-home-user-seo-geo-claude-skills/97cf34c3-b42b-5cf3-8465-509fe6d74814/scratchpad/blind-schema-out-e2.md`

Also ruled, on referral from the E2 grader: line 123 of
`/tmp/claude-0/-home-user-seo-geo-claude-skills/97cf34c3-b42b-5cf3-8465-509fe6d74814/scratchpad/blind-keyword-out-e1.md`
(that line only — E1 as a whole was not in this batch and is not graded here).

Method: full read of each file; no grep used as a primary method. §6 of
`build/seo-content-writer/references/anti-slop-ruleset.md` was read in full so the family
rulings below are grounded in the carrier text rather than in my recollection of it.
Family 5 was hand-checked by me independently across all three files (result below).

---

## HEADLINE

| File | Verdict | Blocking items | Total required fixes |
|---|---|---|---|
| blind-linking-out-e3.md | **MINOR-EDITS** | 1 (§6 sentence 3 — ungrammatical paste-ready copy) | 6 |
| blind-keyword-out-e2.md | **MINOR-EDITS** (heavy end) | 2 (J13 meaning error; artefact-name recurrence) | 10 |
| blind-schema-out-e2.md | **MINOR-EDITS** | 1 (framework ID on a client surface) | 6 |

**No FAIL-grade §6 family (1–7) is hit in any of the three files.** All three read as
written by a Greek professional; none is translation-ese. Every defect below is localised.
I am not grading any file NATIVE because each contains at least one error a Greek
professional would not have shipped, and I am not grading any NON-NATIVE because no defect
class is systematic across a file's register.

---

## RULINGS REQUESTED

### Ruling 1 — family-6 net hit «δείχνει μηδέν» (file 1, line 143)

Span: `### Δεν είναι ορφανή, παρότι δείχνει μηδέν`

**NOT a family-6 defect.** Family 6 is the *costs-zero* calque — a lexical verb taking
«μηδέν» as a bare complement where Greek requires the negative construction («κοστίζει
μηδέν» → «δεν κοστίζει τίποτα»). «Δείχνει μηδέν» is not that shape: «δείχνω» in the sense
*to read / to display* takes a bare numeral in ordinary native Greek («το θερμόμετρο
δείχνει μηδέν», «ο μετρητής δείχνει μηδέν»). The heading refers to a specific cell in the
reader's own table (line 63, `/` → 0 in the in-text column), so it is also not an
unsupported absolute claim under any reading of the family.

**But it needs an edit for a different reason — a document-internal term collision.**
This same file uses «δείχνει» as its technical verb for *points to* roughly eight times
(«Πού δείχνουν», «πόσοι σύνδεσμοι δείχνουν προς αυτές», «το λογότυπο δείχνει μόνο προς την
αρχική», «Καμία άγκυρα δεν δείχνει σε δύο προορισμούς»). Inside that established sense a
reader parses the heading as *"although it points to zero"* — which is factually false: the
homepage emits 3 links (line 63). Required fix, listed under file 1 as F1-2.

Replacement: «Δεν είναι ορφανή, παρότι ο πίνακας γράφει μηδέν».

### Ruling 2 — family-6 net hit «Ο στόχος είναι μηδέν» (file 1, lines 198–199)

Span: `Κενές άγκυρες («πατήστε εδώ», «διαβάστε περισσότερα»): 2 στις 11 = **18,2%**. Ο
στόχος είναι μηδέν.`

**NOT a family-6 defect. Clean; no edit required.** This is a copula with a numeral
predicate stating a target, not a lexical verb calqued out of the negative construction.
A Greek professional writes exactly this in a KPI context («Στόχος: μηδέν», «ο στόχος είναι
μηδέν»). The same document writes «Ο στόχος είναι 0%» eleven lines later (line 209) with
the same meaning and no one would call that a calque either.

Optional polish only, not a defect: «Ο στόχος είναι το μηδέν.»

*Recorded for the family-6 entry:* the digit-form escape the entry names
(`κοστίζ[^.]{0,20}0 ?ευρώ`) did occur in this wave in benign form — «Ο στόχος είναι 0%»
(line 209) and «Ο στόχος είναι 0%» in the deductions table. Evidence that the escape route
is live in real output, even though here it carries no defect.

### Ruling 3 — Latin-script artefact, blind-keyword-out-e1.md line 123

Span (column (b), the *unaccented Greek* column):
`τι να κανω για ponodonto → τι να κανω για πονοδοντο`

**DEFECT. Required fix.** The cell must read `τι να κανω για πονοδοντο` and nothing else —
delete the Latin string and the arrow.

Classification, stated precisely because two plausible classifications are wrong:

- **It is not a rule-3 (Greeklish-placement) violation.** The four-column coverage table is
  the licensed metadata surface; Greeklish is correct and expected in column (c), and the
  file's own placement legend (E1 lines 102–106) states the rule correctly.
- **It is not a plausible keyword either.** No Greek user types four Greek words and then
  one Latin word for the same query. A wrong-layout accident produces a full Latin-gibberish
  string, not clean Greeklish appended to correct Greek script. So it cannot be defended as
  a real query variant that belongs in an inventory.
- **It is an editing artefact that survived onto a client-read surface** — the arrow is a
  find-and-replace trace, i.e. a note the author wrote to himself. That is the same
  reasoning family 7 was founded on: a token addressed to the author, with no referent for
  the reader, sitting where the client reads it. A dentist reading his keyword report sees a
  half-Latin phrase and an arrow and cannot tell whether it is data or a mistake.

Severity: on its own this is one cell, so it is a MINOR-EDITS-level required fix rather than
a file-level FAIL. It should be recorded as an artefact-leak instance, not as a Greeklish
instance, so the carrier statistics stay honest.

### Ruling 4 — family 5, independent hand-check (not requested, done anyway)

I hand-checked every n-word occurrence in all three files against §6 family 5's two-step
procedure. All licensed or protected: file 1 has 14 n-word clauses, every one with a
preverbal «δεν» in its own clause, plus two protected verbless cells («καμία επανάληψη»,
«καμία απροσπέλαστη»); file 2 has 11, all licensed («δεν», «Μην», «χωρίς»), plus two
protected verbless fragments («τίποτα σε greeklish», «**Ποτέ** ανακατεμένες γλώσσες… και
ποτέ αυτόματη μετάφραση»); file 3 has 6, all licensed. **Family 5: clean sheet, ruled on
hand-checked evidence.**

---

## FILE 1 — blind-linking-out-e3.md (internal-linking-optimizer E3)

### Verdict: MINOR-EDITS — with one blocking item. Do not let the client paste §6 sentence 3 as written.

This is the strongest-voiced Greek of the three. «Τα λαδερά δεν συγχωρούν το μέτριο λάδι»,
«μπαίνουν στο παιχνίδι», «μοιάζει με ξένο σώμα μέσα στο κείμενο», «μένει ως έχει»,
«πετάξτε τη συνταγή», the correct enclitic double accent in «το εξαιρετικό παρθένο
ελαιόλαδό μας» — these are native-writer markers, not machine output. Greek number
formatting is right throughout (decimal comma 1,8 / 12,90; thousands dot 1.850). Dates are
in correct Greek form («10 Αυγούστου 2026», «της 7ης Αυγούστου 2026»), so the settled ISO
date ruling is complied with. Six required fixes.

**F1-1 (BLOCKING). Line 253–254, §6 paste-ready sentence 3 — case government broken in copy
the client is told to paste into a live page.**

> Το νούμερο στην ετικέτα είναι η αρχή· η συνέχεια γίνεται στο ντουλάπι σας — δείτε
> [η σωστή φύλαξη του λαδιού](/blog/apothikefsi-elaioladou).

«δείτε» governs the accusative; «η σωστή φύλαξη» is nominative. *«δείτε η σωστή φύλαξη του
λαδιού»* is not a grammatical Greek sentence. This is the one surface where §6's families 5
and 6 were both founded — paste-ready customer copy — so it must not ship.

Replacement (keeps the anchor string unchanged, makes it the subject):

> Το νούμερο στην ετικέτα είναι η αρχή· τη συνέχεια την κάνει
> [η σωστή φύλαξη του λαδιού](/blog/apothikefsi-elaioladou) στο ντουλάπι σας.

Minimal alternative if the anchor may be inflected instead: «…— δείτε **τη σωστή φύλαξη του
λαδιού**», with the §6 anchor table (line 233) updated to match.

**F1-2. Line 143 — «δείχνει» collides with this document's own technical sense.** See
Ruling 1. `### Δεν είναι ορφανή, παρότι δείχνει μηδέν` → `### Δεν είναι ορφανή, παρότι ο
πίνακας γράφει μηδέν`.

**F1-3. Line 213 — «αλληλοκαλύπτεται με» is ungrammatical.**

> «πατήστε εδώ» στο κεντρικό μπάνερ — αλληλοκαλύπτεται εν μέρει με την πρώτη γραμμή

Greek «αλληλο-» verbs are inherently reciprocal: they take a plural subject
(«αλληλοκαλύπτονται») and cannot take a «με» complement. Replacement: «**επικαλύπτεται** εν
μέρει με την πρώτη γραμμή».

**F1-4. Line 201 — «ο κανόνας που δουλεύουμε».**

> Ο πρακτικός κανόνας που δουλεύουμε είναι 10–20%.

Calque of *the rule of thumb we work to*. «Δουλεύω κάτι» in Greek means to work *on*
something (an idea, a piece), not to work *to* a rule. Replacement: «Ο πρακτικός κανόνας
**που ακολουθούμε** είναι 10–20%.»

**F1-5. Line 45 — «ανακαλύψιμη» is a coined adjective.**

> Αυτός ο αριθμός κρίνει αν μια σελίδα είναι ανακαλύψιμη

*Discoverable* calqued into a word Greek does not have. Replacement: «αν μια σελίδα είναι
**εντοπίσιμη**» or, better for this audience, «αν μια σελίδα **μπορεί να βρεθεί**».

**F1-6. Lines 380 and 414 — «ο κατασκευαστής», unqualified, in an olive-oil deliverable.**

> αυτά είναι δουλειά του κατασκευαστή · **Με τον κατασκευαστή** — ένα μενού τεσσάρων θέσεων

Bare «ο κατασκευαστής» in Greek defaults to *manufacturer*. In a report addressed to a food
producer that is a live misreading — the client has an actual κατασκευαστής/τυποποιητήριο in
his supply chain. Replacement: «του **κατασκευαστή του site**» / «Με τον **προγραμματιστή
σας**». File 3 gets this right («τον προγραμματιστή σας», line 132), which is the in-house
precedent.

### §8's linguistic argument — sound conclusion, under-diagnosed premise (required amendment)

§8 point 2 (lines 338–342) is the section the batch brief flagged. Its verdict is right and
its instinct is right; one clause of its reasoning is not, and as written it can mislead the
client.

> **2. Η φράση δεν είναι ελληνικά, είναι ερώτημα αναζήτησης.** «ελαιόλαδο κρήτης προσφορά»,
> χωρίς άρθρο και με μικρό «κ» σε κύριο όνομα, είναι κάτι που πληκτρολογεί κάποιος σε πεδίο
> αναζήτησης.

- «Δεν είναι ελληνικά» as a formulation is fine — it is a real native idiom for *this isn't
  proper Greek*.
- The lowercase «κ» observation is correct, and the fix given («γράφεται «Κρήτης», με
  κεφαλαίο») is correct.
- **«χωρίς άρθρο» under-diagnoses and, worse, points at the wrong element.**
  «Ελαιόλαδο Κρήτης» *without* an article is perfectly good Greek — it is the ordinary
  genitive of origin, the same shape as «φέτα Δωδεκανήσου», «μέλι Κρήτης», and it appears
  article-less in native prose and packaging every day. What actually makes the string
  unwritable in a sentence is the **third noun stacked on with no syntactic link**:
  «προσφορά» sits there in the nominative with no relation to the two nouns before it. That
  is precisely §6 family 4's shape («παράδοση αεροδρόμιο» → «παράδοση στο αεροδρόμιο
  Ηρακλείου»).
- The practical consequence of the mis-aim: §8 closes (lines 359–361) by telling the client
  to put «ελαιόλαδο Κρήτης» in the title, the H1 and the body — i.e. the phrase point 2 has
  just implied is not Greek. A client who takes point 2 literally will avoid a phrase the
  same section then prescribes.

Required amendment to point 2:

> **2. Η φράση δεν είναι ελληνικά, είναι ερώτημα αναζήτησης.** Το «ελαιόλαδο Κρήτης» από
> μόνο του είναι σωστά ελληνικά — όπως λέμε «μέλι Κρήτης». Αυτό που δεν στέκει είναι το
> τρίτο ουσιαστικό κολλημένο δίπλα χωρίς σύνδεση: η «προσφορά» δεν δένει συντακτικά με τα
> δύο προηγούμενα. Σε πρόταση θα γραφόταν «**προσφορά σε ελαιόλαδο Κρήτης**» ή «**ελαιόλαδο
> Κρήτης σε προσφορά**». Έτσι όπως είναι, με μικρό «κ» σε κύριο όνομα, είναι κάτι που
> πληκτρολογεί κάποιος σε πεδίο αναζήτησης — μέσα σε κείμενο μοιάζει με ξένο σώμα.

### Required verification note (not a language defect, but client-facing and self-inconsistent)

Three anchors and two paste-ready sentences assert a **κτήμα** the intake does not attest:
«πέντε λαδερά με **το λάδι του κτήματος**» (§6 #7, lines 237/274), «**το λάδι του
κτήματος**» (§7 #4, lines 287/315), «εξαιρετικό παρθένο ελαιόλαδο **του κτήματος**» (§8
table, line 370). The brief describes «οικογενειακό e-shop … Ηράκλειο» — a family shop is
not necessarily a grove-owning estate; many are buyers/bottlers. The same document already
demonstrates the correct handling one section earlier (lines 322–324): it flags «σε τέσσερα
βήματα» for verification precisely because the underlying page text was not supplied. The
number **πέντε** in «πέντε λαδερά» is unverified on identical grounds and is not flagged.

Fix: either extend the existing verification note to cover «κτήμα» and «πέντε», or use the
safe form «**το λάδι μας**» / «**το φετινό μας λάδι**», which carries the same warmth with
no factual exposure.

### Advisory (fix on touch, non-blocking)

- Line 20 «η διάκριση **κρατάει** σε όλη την ανάλυση» → «**διατηρείται** σε όλη την ανάλυση»
  (*holds throughout* calque).
- Line 55 «τα δύο δεξιά **κελιά**» → «τις δύο δεξιές **στήλες**» (they are columns).
- Lines 76–77 «μοντέλο τυχαίου επισκέπτη με απόσβεση 0,85» → «μοντέλο **του** τυχαίου
  επισκέπτη με **συντελεστή** απόσβεσης 0,85» (article-less noun stack).
- Line 174 «χωρίς κάποια **αιτία**» → «χωρίς **προφανή λόγο**».
- Line 211 «Ερώτημα **μηχανής** μέσα σε κείμενο» → «Ερώτημα **αναζήτησης** μέσα σε κείμενο»
  (the file's own wording at line 338).
- Line 223 «Οι **προτάσεις** είναι γραμμένες ως ολόκληρες **προτάσεις**» → «Τα κείμενα που
  προτείνουμε είναι γραμμένα ως ολόκληρες προτάσεις» (one word doing two jobs in one
  sentence).
- Line 248 «μισό λεπτό διάβασμα **το κρατάει στα καλύτερά του**» — English abstract subject
  plus a person-shaped idiom applied to oil. → «Μόλις παραλάβετε το λάδι, αξίζει μισό λεπτό
  διάβασμα για να κρατήσει τη γεύση του: [πώς να φυλάξετε σωστά το λάδι στο σπίτι].»
- Line 263 «Ο αριθμός στην ετικέτα **σημαίνει** κάτι συγκεκριμένο: [τι **σημαίνει** η
  οξύτητα…]» → «Ο αριθμός στην ετικέτα δεν είναι διακοσμητικός: δείτε [τι σημαίνει η
  οξύτητα στο ελαιόλαδο].»
- Line 345 «το **πάτημα** καταλήγει σε μικρή απογοήτευση» → «όποιος πατήσει θα απογοητευτεί»
  (abstract subject).
- Line 398 «Το ποσοστό είναι μερίδιο **πίτας**» → «μερίδιο **της πίτας**».
- Line 407 «Σταματάει την **ορφάνια**.» — «ορφάνια» in Greek is the human condition of
  having lost one's parents; on a page it reads as unintended comedy. → «**Λύνει το πρόβλημα
  της ορφανής σελίδας.**»
- Lines 296–297 «Θέλετε το **φετινό** λάδι; [Παραγγείλτε το **φετινό** μας ελαιόλαδο]» —
  redundant repetition inside two lines of banner copy.
- Line 341 «να γράψετε την **περιοχή**» → «να γράψετε **την προέλευση**» (Crete is an
  island/region, and «περιοχή» reads as a neighbourhood here).
- Line 436 «μαζί με τη σελίδα πωλήσεων **ως προτεραιότητα**» → «**με προτεραιότητα** τη
  σελίδα πωλήσεων».

### Out of my remit, visible to me, passed up

§8's closing table (line 370) introduces a new anchor for `/syntages/ladera` («εξαιρετικό
παρθένο ελαιόλαδο του κτήματος») that appears in no §7 change row, so the "five changes"
count and this table do not reconcile. Numeric/structural, not linguistic — for the grader.

---

## FILE 2 — blind-keyword-out-e2.md (keyword-research E2)

### Verdict: MINOR-EDITS, heavy end — two blocking items.

The register is right for the audience and the file has real native texture: «κρικάκια»,
«βεράκι», «ατσάλινο ή ασημένιο;» as observed customer vocabulary is exactly what Greek women
write in DMs; «δουλεύουμε στα τυφλά», «παραγέμισμα», «χωρίς να στριμώχνετε την ονομαστική
παντού», «Προφίλ Επιχείρησης Google» (Google's own Greek product name). Diacritics are
correct throughout, including the hard cases: «ασήμι **ή** ατσάλι» accented in the visible
column and «ασημι **η** ατσαλι» unaccented in the metadata column, and «πώς» accented as an
interrogative in every (α) cell. Ten required fixes.

**Rule-3 clearance, stated explicitly since it is the file's biggest judgement call:** the
Greeklish column (γ) and the unaccented column (β) are the licensed metadata inventory, and
the file's own placement legend (lines 102–109) states the rule correctly and applies it
consistently. **No rule-3 violation in this file.** The Greeklish quoted inside §3's prose
(«asimenia daxtylidia xeiropoiita», line 195) is quoted as the thing not to do — meta-use,
licensed.

**F2-1 (BLOCKING). Line 138, J13 — «δώρο για γιορτή γυναίκας» means the wrong thing.**

The EN column reads *name-day gift for her* and §4 (line 245) argues from «οι ελληνικές
ονομαστικές γιορτές». But «η γιορτή της γυναίκας» in Greek is overwhelmingly **Women's Day,
8 March**. As written the keyword targets a different, seasonal demand from the one the
report reasons about, and the client would build the wrong page. This drives a whole
calendar slot (week 9).

Replacement for the row: (α) «**δώρο για ονομαστική γιορτή**» — or, closer to how people
actually search, «**τι δώρο να πάρω για τη γιορτή της**»; (β) «δωρο για ονομαστικη γιορτη»;
(γ) «doro gia onomastiki giorti»; (δ) "name-day gift for her".

**F2-2 (BLOCKING — ruled-class recurrence). Lines 370–376, «Παραδόσεις σε άλλες ροές
εργασίας» — bare internal artefact names on a client-read surface.**

> **Κείμενα κατηγοριών και άρθρων** → `seo-content-writer` … → `meta-tags-optimizer` … →
> `schema-markup-generator` … → `competitor-analysis`

This is §6's ruled advisory class *English artefact names in Greek client-visible prose*,
whose recorded Recurrence 1 (rank-tracker E3, 11 occurrences) was logged on this same date.
The document is addressed to the shop owner in the second person throughout, including this
section («**Δώστε**: στόχο…»), so under §6 family 7's governing test — *the test is the
reader, not the section* — she reads it, and `seo-content-writer` gives her nothing to act
on. The section heading «ροές εργασίας» is a good save (it avoids the ruled «δεξιότητες»),
which makes the bare slugs the only remaining leak.

Replacement — name the job, not the artefact:

> - **Κείμενα κατηγοριών και άρθρων** → **σύνταξη κειμένων SEO**. Δώστε: στόχο (J4 / J6 /
>   J18), τύπο σελίδας, γλώσσα el-GR…
> - **Τίτλοι και meta descriptions** → **βελτιστοποίηση τίτλων και περιγραφών**.
> - **Δομημένα δεδομένα προϊόντων** → **δημιουργία δομημένων δεδομένων**.
> - **Τι κατατάσσουν οι ανταγωνιστές σας και εσείς όχι** → **ανάλυση ανταγωνισμού**.

If this section is in fact meant for the operator rather than the client, it needs an
explicit marker saying so; as written there is none, and the surrounding second person says
otherwise.

**F2-3 (ruled advisory recurrence). Lines 61 and 361 — the quick-wins calque.**

> **Η πιο γρήγορη νίκη σας δεν είναι οι γενικές λέξεις.** … Είναι η φθηνότερη **νίκη** της
> αναφοράς

§6's advisory list already rules «Γρήγορα κέρδη» / «Γρήγορη νίκη» → «Άμεσες βελτιώσεις» /
«Άμεσα οφέλη» / «Άμεσο όφελος». Replacements: «**Το πιο άμεσο όφελός σας δεν είναι οι
γενικές λέξεις.**» and «Είναι **το φθηνότερο όφελος** της αναφοράς». Note the file itself
produces the ruled-good form as a section heading, «§2 Άμεσες ευκαιρίες» — so this is
residue, not a gap in what the skill knows. Carrier amendment proposed below (the calque
survived adjective substitution: «φθηνότερη νίκη»).

**F2-4. Line 104 — «alt κειμένων» is a case error in a list.**

> τίτλοι, H1, περιγραφές προϊόντων, meta description, **alt κειμένων**, λεζάντες

Every other item is nominative; this one is genitive plural and agrees with nothing.
Replacement: «**alt κείμενα**» (or «**εναλλακτικά κείμενα εικόνων (alt)**»).

**F2-5. Line 89 — «Ζυγίζονται» is a false friend.**

> Ζυγίζονται 2/3 και 1/3 αντίστοιχα

*Weighted* → «**σταθμίζονται**». «Ζυγίζομαι» is to be physically weighed on a scale.
Replacement: «**Σταθμίζονται** 2/3 και 1/3 αντίστοιχα».

**F2-6. Line 282 — English modifier order.**

> Τιμοκατάλογος / «πόσο κοστίζει» ενότητα

Greek puts the quoted title after the noun. Replacement: «Τιμοκατάλογος / **ενότητα «πόσο
κοστίζει»**». The file gets it right nine lines later («Υποκατηγορία «κρίκοι»», line 291),
which is what makes this a slip rather than a pattern.

**F2-7. Lines 261 and 328 — «εκτυπώσιμος μετρητής» is not the sector's word.**

> Βήματα + **εκτυπώσιμος μετρητής** · Οδηγός μεγέθους δαχτυλιδιού με **εκτυπώσιμο μετρητή**

The Greek jewellery trade word for a ring sizer is «**δαχτυλιδόμετρο**»; «μετρητής» reads as
a counter/meter. Replacement: «**εκτυπώσιμο δαχτυλιδόμετρο**».

**F2-8. Line 346 — broken idiom.**

> ο χρόνος σας **πιάνει πολλαπλάσια** στις φράσεις με «χειροποίητα» και «925»

The idiom is «πιάνω **τόπο**». As written it is a half-formed native idiom, which reads
worse than plain phrasing. Replacement: «ο χρόνος σας **πιάνει πολύ περισσότερο τόπο** στις
φράσεις…».

**F2-9. Line 198 — «Δεν προσθέτει κατάταξη».** Calque of *doesn't add ranking*. Replacement:
«**Δεν βελτιώνει την κατάταξη.**»

**F2-10. Line 122, J8 — a query-string stack sitting in the visible-copy column.**

> ασημένιοι κρίκοι σκουλαρίκια

Gender-mismatched noun stack («ασημένιοι» masc. + «σκουλαρίκια» neut.), i.e. §6 family 4's
shape. **I am not ruling this a family-4 FAIL**: family 4 exempts keyword-export strings on
explicitly keyword-list surfaces, and this is one. But this file's own legend promotes
column (α) to «η μόνη μορφή που μπαίνει σε ορατό κείμενο», which cancels the exemption in
practice — the client is told this column is page-ready. E1 solved exactly this with its K9/
K11 note. Fix either way:

- rewrite the (α) cell as «**ασημένια σκουλαρίκια κρίκοι**», or
- add E1's note verbatim in shape: «**Το J8 δεν γράφεται έτσι στη σελίδα.** Ως επικεφαλίδα
  γίνεται «Ασημένια σκουλαρίκια κρίκοι».»

The same treatment covers J10 «ασημένια δαχτυλίδια τιμές».

### Advisory (fix on touch, non-blocking)

- Line 10 «όπως θα διαβάζει και **ο πελάτης σας**» — dangling object, and masculine against a
  document that is consistently feminine («πελάτισσές σας», «Όποια σας είδε»). → «όπως θα τα
  διαβάζουν και **οι πελάτισσές σας**».
- Line 16 «σε αυτή τη **συνεδρία**» → «σε αυτή **την ανάλυση**». See promotion 1 below.
- Line 80 «Ο **κανονικός** τύπος» → «Ο **καθιερωμένος** τύπος».
- Line 91 «μένουν **αβαθμολόγητοι**, όχι **υποτιθέμενοι**» → «μένουν **χωρίς βαθμολογία** —
  δεν τους αντικαταστήσαμε με εικασίες» («υποτιθέμενος» in Greek carries an *alleged/
  so-called* colouring).
- Line 222 «Θα προσελκύσουν **επισκέψεις που δεν μπορούν να αγοράσουν**» → «Θα φέρουν
  **επισκέπτες** που δεν μπορούν να αγοράσουν» (visits don't buy; people do).
- Line 230 «όποια σας βρίσκει **από το Instagram από το εξωτερικό**» → «όποια σας βρίσκει
  **από το εξωτερικό μέσω Instagram**».
- Lines 332 and 366 «**ξαναϊεράρχηση**» / «**ξαναπροτεραιοποίηση**» → «**νέα ιεράρχηση**» /
  «**νέα ιεράρχηση προτεραιοτήτων**» (colloquial ξανα- welded onto learned nominalisations).
- Lines 251/256/267 «συστήματα **ΤΝ**» — §6's advisory list rules the native form as
  «**μηχανές AI**» / «απάντηση AI». Align to the ruled form, or at minimum gloss «ΤΝ» at
  first use; a jewellery-shop owner does not read «ΤΝ» cold. Column header «Δυναμική ΤΝ» is
  vague either way → «**Πιθανότητα αναφοράς από AI**».
- Line 302/327 «Πώς **καθαρίζετε** τα ασημένια σας» as an article title reads as a question
  to the reader → «**Πώς να καθαρίσετε** τα ασημένια σας».
- Line 213 — the file authorises the brand name in Latin script inside the homepage **meta
  title**, a display surface. This is licensed (brand variants are a named Greeklish home in
  the library rule, and the file caps it at «μία φορά η καθεμία»), but it is the one place
  the file lets Latin script onto a surface the searcher reads, so it deserves the guardrail
  in writing: it must read as a brand name, «Χειροποίητα Ασημένια Κοσμήματα | Eleni Jewels»,
  never as a transliterated keyword, «xeiropoiita kosmimata».
- Line 229 «Shipping & about» → «Shipping & About» (English copy, but client-facing).

### Out of my remit, visible to me, passed up

Priority bands and section placement disagree: §2 «Άμεσες ευκαιρίες» contains two P1 rows
(J8, J7 at 3,9) while §4 «Ανάπτυξη (3–6 μήνες)» contains a P0 row (J10 at 4,3). A Greek
reader notices this as fast as an English one. For the grader.

---

## FILE 3 — blind-schema-out-e2.md (schema-markup-generator E2)

### Verdict: MINOR-EDITS — one blocking item.

The Greek around the markup is clean, well-pitched at a shop owner, and culturally exact
where it counts: «ΠΟΠ» expanded correctly as «Προστατευόμενη Ονομασία Προέλευσης»,
«Μονοπρόσωπη Ι.Κ.Ε.» punctuated correctly, «ΦΠΑ» handled correctly including the
12,90 € → `12.90` explanation, «διαδρομή πλοήγησης» (Google's own Greek term for
breadcrumb), «Βελτιώσεις» (Search Console's Greek UI label), «ανίχνευση» for crawl,
«αστεράκια» for star ratings, and the correct colloquial clitic «στείλτε **τες** όλες».
Kalamata PDO/Messinia/Κορωνέικη hang together as a real Greek product. Six required fixes.

**F3-1 (BLOCKING). Line 32 — an internal framework ID on a client-read surface.**

> Ένας κύριος τύπος ανά σελίδα (**ρύθμιση R2 / CORE-EEAT O05**): η προσθήκη επιπλέον τύπων…

Two defects in five words. (a) The reference itself: «R2» and «CORE-EEAT O05» are in-house
machinery with no client referent — same class and same reasoning as §6's ruled artefact-
name / process-machinery advisories, and the same boundary family 7 draws. The reader is an
olive-oil e-shop owner. (b) «ρύθμιση» is *setting/regulation*; as a rendering of *ruling* it
is a mechanical translation that would puzzle a Greek reader even if the ID belonged there.

Replacement — delete the reference, keep the claim:

> Ένας κύριος τύπος ανά σελίδα — **αυτός είναι ο κανόνας που ακολουθούμε**: η προσθήκη
> επιπλέον τύπων δεν αυξάνει ούτε τις εμφανίσεις ούτε τις αναφορές από μηχανές AI…

**F3-2. Lines 8, 100, 204 — «τιμή» meaning *value* inside a document about *price*.**

> κάθε **τιμή** μέσα στο markup προέρχεται από το αρχείο… · (ως **τιμή** της ιδιότητας
> `priceSpecification`) · Δεν υπάρχει επινοημένη **τιμή**

Three occurrences. In a deliverable whose entire subject is the price snippet, the first
sentence of the provenance note reads as *"every price inside the markup"*, and the
checklist line reads as *"there is no invented price"* — which is both true and not what is
meant. Replacements: «κάθε **στοιχείο** μέσα στο markup προέρχεται…», «(**μπαίνει στην
ιδιότητα** `priceSpecification`)», «Δεν υπάρχει **επινοημένο στοιχείο**».

**F3-3. Line 9 — fronted negative-existential, English shape.**

> **Εργαλείο σάρωσης ιστότοπου δεν είναι συνδεδεμένο** σε αυτή τη συνεδρία

Greek puts the negation first. Replacement: «**Δεν είναι συνδεδεμένο κανένα εργαλείο σάρωσης
ιστότοπου σε αυτή την ανάλυση**» (which also clears the «συνεδρία» item below).

**F3-4. Line 78 — the relative clause attaches to the wrong noun.**

> `EUR` — ο κωδικός ISO του ευρώ **που γράφει η σελίδα**

The page writes «€», not «EUR»; as written it claims the page contains the string EUR.
Replacement: «`EUR` — ο κωδικός ISO **για το ευρώ (€) που δείχνει η σελίδα**».

**F3-5. Lines 146–147 — «σε αγορές» is ambiguous.**

> Βελτιώνει την εμφάνιση **σε αγορές**

Reads as *in purchases* as readily as *in shopping surfaces*. Replacement: «Βελτιώνει την
εμφάνιση **στα αποτελέσματα αγορών (Google Shopping)**».

**F3-6. Line 205 — «εκκρεμεί από εσάς».** «Εκκρεμώ» does not take «από» + person.
Replacement: «**εκκρεμεί από την πλευρά σας**» or «**το περιμένουμε από εσάς**».

### Advisory (fix on touch, non-blocking)

- Line 9 «σε αυτή τη **συνεδρία**» → «σε αυτή **την ανάλυση**». Second instance in the wave;
  see promotion 1.
- Line 11 «τα πάντα **είναι μεταφορά** από το αρχείο σας» → «**όλα μεταφέρθηκαν** από το
  αρχείο σας».
- Line 14 «Rich results» unglossed at first use → «Rich results (**εμπλουτισμένα
  αποτελέσματα**)» once, then the English freely.
- Line 77 «**υποδιαστολή με τελεία**» is self-cancelling (η υποδιαστολή *is* the comma) →
  «**το δεκαδικό σημείο γράφεται με τελεία**».
- Line 183 «η σελίδα πρέπει να **σερβίρεται** ως UTF-8» — dev jargon calqued from *served*;
  fine among developers, opaque to this reader → «η σελίδα πρέπει να **αποστέλλεται με
  κωδικοποίηση** UTF-8».
- Line 191 «αυτό είναι ακριβώς το σημείο **που κλείνει με τη φωτογραφία**» → «αυτό ακριβώς
  είναι **το κενό που κλείνει η φωτογραφία**».
- Line 88 «μπορεί να προστεθεί μέσα στο `offers` **και το εξής**» → «…**το παρακάτω
  αντικείμενο**».
- «μηχανές AI» (lines 20, 33) is the §6-ruled native form — **do not "fix" it**, and align
  file 2's «συστήματα ΤΝ» to it rather than the reverse.

### Out of my remit, visible to me, passed up

Line 20 states FAQ rich results «καταργήθηκε το 2026». My understanding is that Google
removed FAQ rich results for most sites in 2023. Factual, not linguistic — for the grader.
Line 45's `description` («ελιές ποικιλίας Κορωνέικη») is declared verbatim client text
(line 84); if it truly is verbatim, leave it, though «ποικιλίας **Κορωνέικης**» is the
stricter Greek.

---

## CARRIER EVIDENCE — ruled-good forms produced unprompted in this wave

Worth recording, because §6 exists to be measured and this is the positive half of the
measurement. None of these executors could see their expectations.

- **Family 1 (totality-with-numeral)**, ruled native form produced twice in file 1: «— **και
  οι 6 σελίδες**, οι 11 σύνδεσμοι…» (line 5) and «**και οι 6 σελίδες** μπαίνουν στο
  παιχνίδι» (line 397). Zero family-1 hits.
- **Family 6**, ruled native form produced unprompted in file 2 line 31: «Δύο πηγές
  δεδομένων που έχετε ήδη και **δεν κοστίζουν τίποτα**» — the exact replacement the family
  prescribes, written spontaneously.
- **Family 7**: zero `~~` tokens; all three files resolve the data source in plain language
  by the three-step rule — «από το αρχείο που μας στείλατε», «Μ/Δ — δεν συνδέθηκε
  εργαλείο», «τα δικά σας νούμερα από το GA4».
- **Advisory (c)**: «έτοιμοι για **αντιγραφή**» (file 1, §6 heading) — the ruled replacement
  for «έτοιμες για copy-paste».
- **Advisory (d)**: «(**στοιχεία που παρείχατε εσείς**)» (file 1, line 8) — the ruled
  replacement for «(user-provided)», verbatim.
- **«εφευρίσκω» advisory**: both files that needed the word chose «**επινοημένος**» (file 2
  line 20, file 3 line 204), the ruled-correct form.
- **Protected list**: enclitic double accents produced correctly and repeatedly —
  «ελαιόλαδό μας», «ζητούμενό σας», «όνομά σας», «κείμενό της» — and correctly withheld
  where the host does not take one.
- **Settled ISO-date ruling**: complied with. Greek date forms throughout («10 Αυγούστου
  2026», «της 7ης Αυγούστου 2026», «Αύγουστος 2026»); no ISO date under a Greek preposition
  in any of the three files.
- **Settled «τομέας» advisory**: complied with. File 2 keeps «domain» in Latin (lines 53,
  212, 360); file 1 writes «κύρος domain», the form §6 line 285 lists as the keep-form.
- **Settled «ουρά» rejection**: the word does not appear in any of the three files.

---

## PROMOTION RECOMMENDATIONS FOR §6

Team threshold is two hits in one wave. Ranked by strength of case.

### P1 — «συνεδρία» for the working session → add to the ruled *Process machinery as client vocabulary* advisory

- **Hits this wave: 2, in 2 files.** file 2 line 16 «Δεν συνδέθηκε κανένα εργαλείο SEO σε
  αυτή τη **συνεδρία**»; file 3 line 9 «…δεν είναι συνδεδεμένο σε αυτή τη **συνεδρία**».
- **Prior wave: yes.** The class is already carried — «σε αυτή την **εκτέλεση**» ×4
  (rank-tracker E3, 2026-08-10), and its ruled native replacement is literally «Σε αυτή την
  **ανάλυση**», which is also the fix here. This is the same defect with a new token.
- **Greek-specific aggravation worth writing into the entry:** «Συνεδρίες» is Google
  Analytics' own Greek UI string for *sessions*. On any analytics-adjacent deliverable the
  word already means something else to the reader, so this is not merely machinery-talk — it
  is machinery-talk that collides with a number the client sees in his own dashboard.
- **Greppable: yes** — `συνεδρί`. Hand-check required: a genuine «συνεδρία» (a meeting, an
  appointment) is ordinary Greek and legitimate.
- **Family kinship:** this belongs with the settled «ουρά» rejection and the live «τομέας»
  advisory — one recurring family of over-literal Greek renderings of English technical
  nouns that collide with an established Greek sense (domain→τομέας, tail→ουρά,
  session→συνεδρία, value→τιμή). Recommend the entry say so, so the next editor recognises
  the shape rather than the token.

### P2 — internal framework IDs and bare skill slugs on client surfaces → promote the artefact-name advisory to a FAIL-grade family

- **Hits this wave: 5, in 2 files.** file 2 lines 370–376, four bare skill slugs
  (`seo-content-writer`, `meta-tags-optimizer`, `schema-markup-generator`,
  `competitor-analysis`) in a section addressed to the client in the second person; file 3
  line 32, «(ρύθμιση R2 / CORE-EEAT O05)».
- **Prior wave: yes, twice.** Founding instance 2026-08-10 (14 occurrences across 5 files);
  Recurrence 1 the same day (rank-tracker E3, 11 occurrences), recorded in §6 with the
  explicit observation that "writing the carrier did not stop the class inside one day".
  This wave is Recurrence 2, in blind output, two files.
- **Recommendation:** fix-on-touch has now failed to hold this class across three recorded
  passes. Promote it out of the advisory list into the FAIL-grade table, and widen the token
  set beyond «το skill / του template / βιβλιοθήκη μας / δεξιότητ» to cover the two forms
  seen here.
- **Greppable: yes, and unusually cleanly.** (i) The 20 skill names are enumerable from
  `.claude-plugin/plugin.json` — grep each literal in any Greek deliverable; that is a
  zero-noise check, since a skill slug has no other reason to appear in Greek prose.
  (ii) Framework IDs: `CORE-EEAT` · `CITE` · the item-ID shape `\b[CORET][0-9]{2}\b`
  (hand-check — C01/T04/R10 are legitimate in internal review text, so the check is the
  surface, not the string).
- **F15 requirement:** before it ships, run the pattern against constructed variants —
  a slug in backticks, a slug bare, a slug inside a Greek sentence with an article
  («το `keyword-research`»), the translated form «δεξιότητα keyword-research», an item ID in
  parentheses, an item ID after a Greek label («ρύθμιση R2»). The last two are what this
  wave produced and neither would have been caught by the current token list.

### P3 — amend the existing quick-wins advisory: the calque survives adjective substitution

- **Hits this wave: 2, in 1 file.** file 2 line 61 «Η πιο **γρήγορη νίκη** σας»; line 361
  «Είναι η **φθηνότερη νίκη** της αναφοράς».
- **Prior wave: yes** — the entry exists («Γρήγορα κέρδη» / «Γρήγορη νίκη» → «Άμεσο
  όφελος»).
- **Amendment:** the current entry is written around the adjective, and this wave escaped it
  by changing the adjective while keeping the calque. Same failure shape §6 already
  documents for family 6's fixed two-word string. Split net from rank exactly as family 6
  does: **NET** on `νίκη` (the noun carries the calque — Greek does not use *νίκη* for a
  marketing gain), **RANK** with `γρήγορ|φθηνότερ|εύκολ|γρήγορα κέρδη`. Hand-check: a real
  «νίκη» (a competition, a court case) is ordinary Greek.

### P4 — English abstract subject taking a Greek verb → §1.3 prose guidance, NO regex

- **Hits this wave: 3, in 2 files.** «**μισό λεπτό διάβασμα** το κρατάει στα καλύτερά του»
  (file 1, 248); «**το πάτημα** καταλήγει σε μικρή απογοήτευση» (file 1, 345); «Θα
  προσελκύσουν **επισκέψεις** που δεν μπορούν να αγοράσουν» (file 2, 222).
- **Greppable: NO.** Stated explicitly, as required. The defect is a semantic mismatch
  between an inanimate/abstract subject and a verb that in Greek wants an animate one; there
  is no surface string, no token list, and no inflectional shape to key on. Any regex
  attempt here would produce noise and, worse, false confidence. This one is editor-judgment
  and must be labelled as such in §1.3, next to the existing Greek calque patterns.
- Detection guidance for the next editor instead of a pattern: in Greek deliverables, look at
  the subject of every sentence whose verb is κρατάω / φέρνει / καταλήγει / πληρώνει /
  αγοράζει; if the subject is a measurement, a duration, an action-noun or a traffic metric,
  recast with a person or an imperative.

### WATCH (below threshold this wave — recorded, not promoted)

- **Case government broken by a paste-ready anchor.** 1 hit (file 1 §6 sentence 3), but the
  highest-severity single defect in the batch and on the exact surface that founded families
  5 and 6. Greppable candidate with genuinely low noise: `(δείτε|διαβάστε|δοκιμάστε|
  επισκεφθείτε)\s+\[?[«"]?(η|ο|οι)\b` — nominative-only articles, since «δείτε το…» and
  «δείτε τη…» are correct. Hand-check needed for quoted speech. Recommend running it over
  the next wave's Greek deliverables before deciding.
- **Quoted modifier placed before its noun (EN order).** 1 hit (file 2, «"πόσο κοστίζει"
  ενότητα»). Cleanly greppable: `»\s*(ενότητα|σελίδα|πίνακας|τμήμα|κατηγορία|άρθρο)`.
- **«τιμή» = *value* in schema deliverables.** 3 hits but all in one file and one skill.
  Proportionate home is a skill-local note in `schema-markup-generator`, not a §6 family:
  reserve «τιμή» for price; use «στοιχείο» / «περιεχόμενο πεδίου» for a JSON value.
  Greppable: `τιμή` within ~40 chars of `ιδιότητ|πεδίο|markup|JSON`.
- **Bare «ο κατασκευαστής» for a web developer.** 2 hits but one file (file 1, 380 and 414).
  Live ambiguity in food/manufacturing verticals specifically. Greppable: `κατασκευαστ`
  (hand-check — a real manufacturer is a legitimate referent in exactly these verticals,
  which is the point).
- **Edit traces surviving into deliverables** (the E1 ruling above): «X → Y» self-correction
  inside a table cell. **No robust regex** — a bare `→` is legitimate in these files
  («Εμπορική → συναλλακτική», ««Άμεσα διαθέσιμο» → `InStock`»), and the reliable detector
  needs a backreference (same leading token on both sides) which ripgrep's engine does not
  support. The implementable check is field-aware, not a grep: *in a four-column keyword
  coverage table, column (β) must contain no Latin letters*. Recommend it as a script in the
  grader's toolkit rather than a §6 pattern, and record the class in §6 prose so an editor
  knows to look.

---

## ONE-LINE SUMMARIES (paste-ready for grading.json evidence fields)

- **blind-linking-out-e3.md** — `MINOR-EDITS (blocking ×1): native voice and correct Greek number/date conventions throughout, but §6 paste-ready sentence 3 «δείτε [η σωστή φύλαξη του λαδιού]» breaks case government in copy the client is told to publish; plus «αλληλοκαλύπτεται με», «ο κανόνας που δουλεύουμε», coined «ανακαλύψιμη», ambiguous «κατασκευαστής», and §8's premise «χωρίς άρθρο» under-diagnoses a noun-stack the section then prescribes; both family-6 net hits ruled clean as Greek («δείχνει μηδέν» needs an unrelated disambiguation edit).`
- **blind-keyword-out-e2.md** — `MINOR-EDITS, heavy end (blocking ×2): rule-3 placement is correct and diacritics are exact, but J13 «δώρο για γιορτή γυναίκας» means Women's Day not name-day, and the client-read handoff section lists bare skill slugs (ruled artefact-name class, Recurrence 2); plus the ruled quick-wins calque ×2, «alt κειμένων», «Ζυγίζονται» for σταθμίζονται, «"πόσο κοστίζει" ενότητα», «εκτυπώσιμος μετρητής» for δαχτυλιδόμετρο ×2, broken idiom «πιάνει πολλαπλάσια».`
- **blind-schema-out-e2.md** — `MINOR-EDITS (blocking ×1): Greek prose is clean and culturally exact (ΠΟΠ, ΦΠΑ, Ι.Κ.Ε., 12,90 €→12.90, «διαδρομή πλοήγησης»), but «(ρύθμιση R2 / CORE-EEAT O05)» puts an internal framework ID on a client-read surface and mistranslates "ruling" as «ρύθμιση»; plus «τιμή» used for JSON value ×3 in a price document, fronted negative-existential, «EUR … που γράφει η σελίδα», ambiguous «σε αγορές», «εκκρεμεί από εσάς».`
- **blind-keyword-out-e1.md:123 (referred ruling)** — `DEFECT, required fix: «τι να κανω για ponodonto → τι να κανω για πονοδοντο» in the unaccented-Greek column is an editing artefact (find-replace trace) on a client-read surface, not a Greeklish-placement violation and not a plausible query; cell must read «τι να κανω για πονοδοντο». Class it as artefact-leak, not Greeklish, so carrier statistics stay honest.`
- **Wave-level** — `No FAIL-grade §6 family (1–7) hit in any of the three files; family 5 hand-checked clean across all three; both family-6 net hits ruled not-family-6. Ruled-good forms produced unprompted (family 1 «και οι 6 σελίδες» ×2, family 6 «δεν κοστίζουν τίποτα», advisory «έτοιμοι για αντιγραφή», «(στοιχεία που παρείχατε εσείς)»). Promotions proposed: «συνεδρία» → process-machinery advisory (2 hits, 2 files, prior-wave sibling «εκτέλεση»); artefact-name class → FAIL-grade family (5 hits, 2 files, Recurrence 2); quick-wins entry amended to net on «νίκη».`
