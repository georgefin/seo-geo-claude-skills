# Greek YMYL Credential Conventions

Author-credential conventions for **Greek-language YMYL content** — health, legal, and
finance, the standard client verticals. Applied at SKILL.md step 9 (Per-Locale E-E-A-T
Adaptation), where the generic "author/entity signals" row tightens for EL YMYL pages.

**Basis:** Google's Search Quality Rater Guidelines hold YMYL pages to the strictest
E-E-A-T scrutiny. Cited against the pinned QRG baseline — last known active version dated
2025-09-11 (pinned in `docs/loop/SETTLED-RULINGS.md`, as of 2026-08-08) — cited as pinned,
not re-verified here.

---

## The Rule

> **YMYL author bio = full name + credential + registry-verifiable affiliation +
> (where public) registry number. Unverifiable credentials are omitted — never
> approximated.**

"Registry-verifiable" means the stated affiliation can be checked against the relevant
Greek professional registry by a reader, a rater, or the client's own compliance review.
A credential that cannot be verified is left out of the bio entirely; it is never softened
into an approximation ("έμπειρος στον χώρο της υγείας") that implies a credential the
registry cannot confirm.

## Registry Landscape

The institutions below are the standard verification anchors for Greek professionals —
their existence is common knowledge. Their **lookup mechanics** (portal URLs, whether a
public member search exists, which fields it exposes) change and must be checked during
the engagement, not assumed:

| Vertical | Registry / body | What it verifies | Bio element | Lookup mechanics |
|---|---|---|---|---|
| Health (physicians) | Πανελλήνιος Ιατρικός Σύλλογος (ΠΙΣ) — national umbrella; membership held at the regional ιατρικοί σύλλογοι (e.g., Ιατρικός Σύλλογος Αθηνών) | physician status, specialty | «μέλος του Ιατρικού Συλλόγου [πόλης]» + Α.Μ. where public | [VERIFY at build time: current lookup portal; whether specialty is publicly searchable] |
| Legal | δικηγορικοί σύλλογοι (bar associations), e.g., Δικηγορικός Σύλλογος Αθηνών (ΔΣΑ) | lawyer status, bar membership | «δικηγόρος, μέλος του [συλλόγου]» + Α.Μ. where public | [VERIFY at build time: per-bar online member search availability] |
| Engineering / technical–property content | Τεχνικό Επιμελητήριο Ελλάδας (ΤΕΕ) | chamber membership, registry number | «μέλος ΤΕΕ» + Α.Μ. ΤΕΕ where public | [VERIFY at build time: ΤΕΕ member lookup mechanics] |
| Finance / accounting | Οικονομικό Επιμελητήριο Ελλάδας (ΟΕΕ) | economist membership; accountant–tax-consultant licensing (λογιστής-φοροτεχνικός) | «μέλος ΟΕΕ» / license class where applicable | [VERIFY at build time: ΟΕΕ lookup mechanics; current license classes] |
| Company legitimacy (any vertical) | ΓΕΜΗ (Γενικό Εμπορικό Μητρώο) | company registration | «Αρ. ΓΕΜΗ [number]» in the site footer/imprint | [VERIFY at build time: public ΓΕΜΗ search mechanics] |

Other health professions (dentists, pharmacists, psychologists, dietitians, …) follow the
same pattern through their own professional bodies — identify the specific body per
engagement and [VERIFY at build time: relevant body + lookup mechanics].

## Bio Templates (EL, placeholder form)

Byline:

```
[Ονοματεπώνυμο], [ιδιότητα/ειδικότητα], μέλος του [συλλόγου/επιμελητηρίου]
(Α.Μ. [αριθμός μητρώου — μόνο εφόσον είναι δημόσια διαθέσιμος])
```

Reviewed-by variant (writer without credential + verifiable reviewer):

```
Επιστημονική επιμέλεια: [Ονοματεπώνυμο], [ειδικότητα], μέλος του [συλλόγου/επιμελητηρίου]
```

All bracketed fields are placeholders — filled only with real, registry-checked values at
write time; never with invented names or numbers.

## Fallback Rules (no verifiable credential available)

1. **Reviewed-by pattern**: keep the staff-writer byline, add a registry-verifiable
   reviewer («Επιστημονική επιμέλεια: …»).
2. **Team byline**: «Συντακτική ομάδα [brand]» linking to a team page that lists whoever
   *is* verifiable — only when no individual credential applies.
3. **If nothing is verifiable**: publishing Greek YMYL content with no verifiable expert
   is an E-E-A-T gap, not a formatting problem. Flag it to the client as such; Ept01/Ept02
   will score low in the audit, and that honest score stands.
4. **Never**: approximated credentials, degree-implying titles without registry-checkable
   substance, or credentials borrowed from someone not actually involved in the content.

## CORE-EEAT Items This Evidences

Ept01 (Author Identity) and Ept02 (Credentials Display) — primary; R07 (Entity Precision —
exact person and body names, no vague «ειδικοί» references). T08 (Risk Disclaimers) is
adjacent for health/finance pages but governed by its own criteria. No new items; this
convention only sharpens how existing items are satisfied for EL YMYL pages.

## Workflow Hook

Before publishing an EL YMYL page (step 9 gate):

- [ ] Registry/body named for every credentialed author or reviewer
- [ ] Affiliation stated in the bio exactly as the registry records it
- [ ] Registry number included where publicly available; omitted where not
- [ ] Every [VERIFY at build time] item above resolved by an actual lookup during this
      engagement — results are engagement-specific and never cached across clients as fact
- [ ] Unverifiable credentials removed, with the gap flagged to the client
