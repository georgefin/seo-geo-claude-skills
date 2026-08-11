# SUPERSESSION CANDIDATE FOR SANI'S GATE — R3, and proposal 9b

**Label per the header rule in `SETTLED-RULINGS.md`**: supersession candidate, routed to the
gate. **Nothing here is applied.** `SETTLED-RULINGS.md` is untouched; the four 9b library loci
are untouched.

> ## 🔴 THIS FILE WAS SUBSTANTIALLY WRONG AND HAS BEEN REWRITTEN
>
> The first version of this document (commit `bf4041a`) marked four R3 clauses **UNSUPPORTED —
> no source found**, and its §2 proposed **deleting them from the ruling**. That was wrong. All
> four are supported verbatim by a dated Google-primary source. Approving that draft would have
> **deleted four true, primary-sourced facts from a settled ruling** — the exact inversion
> CRITICAL.md **R238** exists to prevent: *"This gate stops an author FABRICATING — never use it
> to DELETE verified truth."*
>
> Caught by the **contrastive second lane** (`ADVERSARIAL-LAYER.md` Protocol A), fired on the
> frozen SHA `f2c6b10`, which found the source by following a link the first version had quoted
> the neighbours of. Every one of its findings was then independently re-verified by the author
> before this rewrite. **This is the adversarial layer working exactly as designed**, and the
> round is recorded as such rather than smoothed over.

---

## 1. The source the first version failed to find

Google's FAQPage structured-data documentation carried an `<aside class="caution">` deprecation
notice. **That page has since been deleted**, which is why a live read could not reach it:
`developers.google.com/search/docs/appearance/structured-data/faqpage` now **301s** (verified,
`num_redirects=1`) to `developers.google.com/search/updates#removing-faq-rich-result`.

Recovered verbatim from `web.archive.org/web/20260512045045/…/structured-data/faqpage`:

> **Upcoming deprecation:** As of **May 7, 2026**, FAQ rich results are no longer appearing in
> Google Search. We will be dropping the **FAQ search appearance, rich result report, and support
> in the Rich results test in June 2026**. To allow time for adjusting your API calls, **support
> for the FAQ rich result in the Search Console API will be removed in August 2026**.

**Live corroboration, still on `developers.google.com` today** — two changelog entries:

- `#faq-deprecation`, **May 8**: *"Deprecating the FAQ rich result feature. What: Added a
  deprecation notice to the FAQ rich result documentation. Why: This feature will no longer
  appear in Google Search starting **May 7, 2026**."*
- `#removing-faq-rich-result`, **June**: *"Removed documentation for the FAQ rich result feature.
  Why: The FAQ rich result feature is **no longer shown in Google Search results**, as announced
  in the changelog entry in May 2026."*

**Negative control (R297)** — the archive probe was proven able to go RED before its green was
trusted. Snapshot `20260402122657` (pre-announcement) contains `Upcoming deprecation`,
`May 7, 2026`, `June 2026`, `August 2026` **zero times each**; snapshot `20260512045045`
contains each **once**. The notice appears between those dates, consistent with the May 8
changelog entry.

---

## 2. R3, clause by clause — CORRECTED

| # | R3 clause | Verdict | Evidence |
|---|---|---|---|
| C1 | "Google ended FAQ rich results in 2026" | 🟢 **SUPPORTED** | "As of May 7, 2026, FAQ rich results are no longer appearing in Google Search"; changelog: "no longer shown in Google Search results". |
| C2 | "search appearance, rich result report and Rich Results Test support were dropped **June 2026**" | 🟢 **SUPPORTED as announced** | "dropping the FAQ search appearance, rich result report, and support in the Rich results test in June 2026." ⚠️ Announced plan; execution unconfirmed (§5). |
| C3 | "Search Console API support is **scheduled for August 2026**" | 🟢 **SUPPORTED, and 9a's wording is exactly right** | "support for the FAQ rich result in the Search Console API will be removed in August 2026." 9a already softened "cut" to **scheduled**; today is in-month. Do not harden it. |
| C4 | "FAQPage generation stays in the library" | 🟢 **SUPPORTED** | S1: "there's no need to proactively remove it"; unused structured data "does not cause problems for Search". |
| C5 | "2023-08-08 narrowed FAQ eligibility to well-known government and health sites" | 🟢 **SUPPORTED, verbatim** | S1, and the 2023 changelog entry restates it. |
| C6 | "**2026-05-07** ended the display entirely" | 🟢 **SUPPORTED, correct to the day** | "As of May 7, 2026…". (Changelog *entry* is dated May 8; May 7 is the stated **effective** date. Both defensible — worth a one-line note, not a correction.) |
| C7 | "this ruling's own rationale has no primary source either way" | 🟢 **SUPPORTED** | S3 says structured data "isn't required for generative AI search" and is silent on parsing. 9a's retraction was correct. |
| C8 | "no need to proactively remove existing FAQPage markup" | 🟢 **SUPPORTED, verbatim** | S1. |
| C9 | "not owner-read; `developers.google.com` refused by this environment's egress policy" | 🟢 **SUPPORTED-AND-SUPERSEDED** | R3 already self-scoped this to "**this environment's** … re-tested through both the HTTP client and WebFetch". A successful read from another machine supersedes it; it never contradicted it. *(The first version labelled this CONTRADICTED — a mislabel, corrected.)* |
| C10 | "**Reopens on**: … primary evidence that AI engines **stopped** parsing it" | ⚠️ **UNFALSIFIABLE AS WRITTEN** | Stands. The condition presupposes a parsing benefit C7 declines to assert, so it can never fire. **This is the one real defect in R3.** |

**Corrected tally: 9 supported (one of them superseded-not-contradicted), 1 unfalsifiable.**
R3's *facts* were sound throughout. What R3 lacked was its **citation** — the 2026 clauses were
true and unsourced-in-file, which is a provenance gap, not a fabrication.

---

## 3. What R3 actually needs — a much smaller change than first proposed

**§2 of the first version is WITHDRAWN in full.** The proposed replacement removed C1/C2/C3/C6.
Do not use it. What is genuinely owed:

1. **Add the citation** the ruling never carried, and record that the page was **withdrawn**:
   the notice at `…/structured-data/faqpage` (archived 2026-05-12), now 301 →
   `…/search/updates#removing-faq-rich-result`, plus the two changelog entries.
2. **Fix C10's reopen-condition**, the one real defect. Replace "primary evidence that AI engines
   stopped parsing it" with something that can fire — e.g. *"schema.org deprecating the FAQPage
   type, or primary evidence that any engine's use of FAQPage markup changed in either
   direction."*
3. **Upgrade the evidence grade** to owner-read, 2026-08-11, and note that one source is now
   **archive-only because Google deleted it** — a live-only re-verification of R3 will fail, and
   a future sweep must not read that failure as the claim being false.
4. **Keep 9a's "scheduled, not observed"** on C3 exactly as written.

---

## 4. Proposal 9b — HowTo. UPHELD after hard contest.

This half survived the adversarial round intact and is unchanged from the first version.

> ### R6 (new) — HowTo rich results are deprecated
>
> - **Statement**: HowTo rich results are **deprecated**. Two stages, one source: **2023-08-08**,
>   "How-To … rich results will only be shown for desktop users, and not for users on mobile
>   devices"; **2023-09-13**, "Google Search no longer shows How-to rich results on desktop,
>   **which means this result type is now deprecated**", with the search appearance, rich result
>   report and Rich Results Test support dropped at 30 days and Search Console API at 180 days.
> - **Corroboration**: `…/structured-data/how-to` 301s to `…/search/updates#how-to-deprecation`:
>   *"Removed the How-to structured data documentation, as this rich result is no longer shown in
>   search results, on both desktop and mobile devices."*
> - **No skill may teach HowTo rich results as an attainable SERP feature.**
> - **Scope — the SERP feature, not the markup.** Whether `HowTo` markup is generated at all is
>   the R3 question. Google's position on removal is the same as for FAQPage: permitted, not
>   required.
> - **Explicitly NOT ruled**: any AI-engine/GEO parsing value — the claim 9a retracted, and open
>   finding **#77**.

**The four loci** should be corrected as before: `serp-feature-taxonomy.md:30` marks HowTo
deprecated; `~:291`'s playbook rows are **deleted** (a playbook for an unattainable feature is not
correctable); `gap-analysis-frameworks.md:150` treats a HowTo gap as a content-format gap;
`ctr-and-social-reference.md:121` drops it (a result type that does not render cannot move CTR).

**The strongest attack the lane could build against 9b**, and why it failed: that the
`<aside class="important">` update might be a rendering artefact or later overlay rather than
served content. Defeated by raw bytes — three independent fetches under three user agents all
contain `<p class="gargardate">Tuesday, August 8, 2023</p><aside class="important"><b>Update on
September 14, 2023</b>…which means this result type is now deprecated.`

---

## 5. Withdrawn claims from the first version — recorded, not deleted

| First version said | Status |
|---|---|
| C1/C2/C3/C6 "UNSUPPORTED — no source found" | **WITHDRAWN.** All four supported verbatim. "No source found" was reported as "no source exists" — **R195** in its pure form. |
| §4: the 2026 narrative is "clause-structure transposition from S1's HowTo update onto FAQ" | **FALSIFIED.** Google wrote the FAQ version itself, reusing its own 2023 wording. The parallel structure is a **shared authorial template**, not a contamination path — the similarity offered as evidence *for* the hypothesis is evidence *against* it. Independent arithmetic disproof: S1's deltas are relative (30/180 days ≈ 150 days apart); R3's are absolute (June→August 2026, ≈61 days). No transposition yields either. |
| §4: "the most likely source of the **fabricated narrative**" | **WITHDRAWN.** The narrative was accurate. The file hedged the hypothesis in one paragraph and then asserted it as fact two paragraphs later. |
| §4(a): S1 "explicitly says the opposite for FAQ" — "reports will remain in Search Console for the time being" | **INVERTS.** "For the time being" is a temporal hedge; a 2023 statement that reports remain *for now* anticipates a later drop rather than contradicting one. |
| §4(b): `2026-05-07` is "the signature of provenance drift — R322" | **INVERTS, and this was the costliest sentence in the file.** May 7 2026 is Google's own stated effective date. An anti-fabrication rule was used to explain away a correctly-sourced fact. |
| §1: "S2 contains zero occurrences of 'FAQ'" | **FALSE at raw-HTML grade** — S2 carries **9 `FAQ`, 6 `deprecat`, 3 `sunset`** (chrome, including a link to S1 itself). Substantively harmless; **evidentially fatal**, because it shows the four verdicts were reached by body-extraction — the very method §6 condemns. |
| §6: R1 upgrades to "evidence of absence" | **WITHDRAWN as overreach.** The supporting quote used an ellipsis spanning ~60 words that contained Google's neutrality clause ("neither harm nor help") **and an explicit carve-out for other services** — which is R1's actual scope, since llms.txt targets LLM providers generally. S3 is evidence-of-absence **for Google Search only**. Google published a June 2026 changelog entry specifically to head off this misreading. |
| C9 "CONTRADICTED — as scope, not as fact" | **Corrected to SUPPORTED-AND-SUPERSEDED.** R3's clause was already self-scoped and re-tested through two clients. |

---

## 6. The method defect — corrected diagnosis

The first version's §5 blamed `<aside>`-stripping and proposed: strip only
`script`/`style`/`nav`/`head`, never `aside`/`callout`/`banner`. **That rule is right and
insufficient**, and the first version proved it by committing the same class of error one section
after diagnosing it.

Two additions the round earns:

> **(a) Follow the links in the sentence you are quoting.** The FAQ notice was one `href` away
> from text the review quoted verbatim at C5 and C8: S1's body reads
> `affects the use of <a href="/search/docs/appearance/structured-data/faqpage">FAQ</a> and
> <a href="…/how-to">How-To</a> structured data.` The answer was inside the quoted sentence and
> the anchor was never followed. An `<aside>` on a page nobody opens is not reached by any
> extraction rule.
>
> **(b) "No source found" is a statement about your search, never about the world (R195), and a
> withdrawn page is the case that breaks a live-only probe.** Before concluding a claim is
> unsourced: follow the links in the sources you have; check whether the obvious URL **redirects**
> (a 301 to a changelog is a deletion notice); and query the archive. R65's qualifier already
> governs this — *the source must EXIST and be RECONCILABLE, not necessarily be VISIBLE TO YOU;
> cut only AFTER reconciliation FAILS.* Reconciliation was never attempted.

**Also worth recording**: `web.archive.org/web/<ts>id_/` returns **gzip bytes**, so a naive grep
of that endpoint silently returns zero hits — a false-negative trap on exactly this probe.

---

## 7. Consequences beyond R3 — corrected

- **R1 (llms.txt)** — **no upgrade.** See §5. R1's conclusion is unchanged and its evidential
  basis is unchanged; S3 speaks only for Google Search.
- **R2 (schema-stacking is not an AI-citation lever) — supported.** S3: "there's no special
  schema.org markup you need to add." Unaffected by this round.
- **Open finding #77** — the benchmark asserts "engines parse the visible Q&A either way" as
  fact. S3 is the closest primary source and does **not** support it: structured data is not
  *required* for generative AI search, and parsing is not addressed. #77's claim remains
  unsourced. Section A — ruling, not edit. Untouched.
- **R5 (unlinked brand mentions)** — nuance, not reopen: S3 confirms the mechanism while warning
  against *seeking inauthentic* mentions.
- Two S3 findings with no current ruling: Google states there is **no requirement to "chunk"
  content** for AI, and **no need to rewrite content specifically for AI systems**.

## 8. Named, not skipped — what this round could not establish

1. **Whether the August 2026 API removal has occurred.** Today is 2026-08-11, in-month; the
   changelog runs to July 2026. Keep 9a's "scheduled".
2. **Whether the June 2026 appearance/report/RRT drop shipped on schedule.** The June changelog
   records the *documentation* removal, not the tooling drop. C2 is sourced as an announced plan.
3. **Which reader originally sourced R3's 2026 clauses.** The clauses are true and a matching
   primary source existed; that the original author read *that page* is not established. The
   origin question is open — it is simply no longer a fabrication question.
