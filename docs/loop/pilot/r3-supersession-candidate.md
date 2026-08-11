# SUPERSESSION CANDIDATE FOR SANI'S GATE — R3, and proposal 9b

**Label per the header rule in `SETTLED-RULINGS.md`**: this is a *supersession candidate*, routed
to the gate. **Nothing here is applied.** `SETTLED-RULINGS.md` is untouched; the four 9b library
loci are untouched; no skill text changed on account of this file.

**Basis**: owner read, 2026-08-11, from `GIORGOSs-Mac-Studio` (no egress proxy). Three URLs,
all `HTTP 200`. This **discharges R3's own stated evidence caveat**, which says
`developers.google.com` "is refused by this environment's network egress policy" — true of the
cloud environment, not of this machine (R323: a measurement is evidence about the client that
took it).

| ID | URL | Fetched |
|---|---|---|
| **S1** | `developers.google.com/search/blog/2023/08/howto-faq-changes` | 619,516 B — twice, different UAs, `<aside class="important">` present in both |
| **S2** | `developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing` | per the 2026-08-11 cloud owner read |
| **S3** | `developers.google.com/search/docs/fundamentals/ai-optimization-guide` | 190,679 B — **first owner read; not previously cited by R3** |

---

## 0. A correction to the instruction that commissioned this file

The instruction states: *"Google's own 2023-08-08 words say HowTo was LIMITED TO DESKTOP, not
retired — so 9b's premise is false at the source."*

**The first half is right. The conclusion does not follow, and 9b's premise is supported.**
S1 is not a single-date document. It carries an update block, rendered above the article body in
`<aside class="important">`, verbatim:

> **Update on September 14, 2023**: Continuing our efforts to simplify Google's search results,
> we're extending the How-to change to desktop as well. As of September 13, Google Search no
> longer shows How-to rich results on desktop, **which means this result type is now deprecated.**

Verified three ways: raw-byte `grep` on the stored response; an independent re-fetch with a
different user agent (page bytes differ — it renders dynamically — the `<aside>` is identical in
both); and direct extraction of the `<aside>` element. **HowTo rich results ended in 2023.**

This is recorded as a correction and not quietly fixed because the same error has now been made
by three independent readers, including twice by the author of this file. See §5.

---

## 1. R3, clause by clause, against the owner read

Clause IDs are assigned here for reference; they are not in the ruling.

| # | R3 clause (verbatim) | Verdict | Evidence |
|---|---|---|---|
| C1 | "Google ended FAQ rich results in 2026" | 🔴 **UNSUPPORTED** | **No source found.** S1 (2023) *narrows* FAQ eligibility and explicitly retains reporting. S2 contains zero occurrences of "FAQ". S3 contains zero occurrences of "FAQ". No cited URL carries an end-date for FAQ rich results. |
| C2 | "the search appearance, the rich result report and Rich Results Test support were dropped June 2026" | 🔴 **UNSUPPORTED** — and see §4 | **No source found for FAQ.** The identical triple appears in S1 **about How-to**: "we will be dropping the How-to search appearance, rich result report, and support in the Rich results test in 30 days." No "June 2026" anywhere in any source. |
| C3 | "Search Console API support is **scheduled for August 2026**" | 🔴 **UNSUPPORTED** — and see §4 | **No source found for FAQ.** The parallel clause appears in S1 **about How-to**: "support for How-to in the Search Console API will be removed in 180 days." No "August 2026" anywhere. |
| C4 | "FAQPage generation stays in the library" (the keep-decision) | 🟢 **SUPPORTED** | S1: "While you can drop this structured data from your site, **there's no need to proactively remove it.**" and "Structured data that's not being used does not cause problems for Search". |
| C5 | "`2023-08-08` narrowed FAQ rich-result **eligibility** to well-known government and health sites" | 🟢 **SUPPORTED, verbatim** | S1: "Going forward, FAQ (from FAQPage structured data) rich results will only be shown for well-known, authoritative government and health websites. For all other sites, this rich result will no longer be shown regularly." |
| C6 | "`2026-05-07` ended the **display** entirely" | 🔴 **UNSUPPORTED** | **No source found.** S2 is the 2026-05 post and says nothing about FAQ, HowTo, rich results or structured data. The date `2026-05-07` appears in no source read. |
| C7 | "This ruling's own rationale has no primary source either way" (9a's retraction of "its value is AI-engine/GEO parsing") | 🟢 **SUPPORTED, and now strengthened** | S3, first owner read: "**Structured data isn't required for generative AI search, and there's no special schema.org markup you need to add.**" Still silent on whether engines *parse* it — so "no primary source either way" remains exactly right, and the retraction was correct. |
| C8 | "Google's own guidance that there is **no need to proactively remove** existing FAQPage markup" | 🟢 **SUPPORTED, verbatim** | S1, as quoted at C4. |
| C9 | "**not owner-read**… `developers.google.com` is refused by this environment's network egress policy" | ⚫ **CONTRADICTED — as scope, not as fact** | True of the cloud environment when written. All three URLs owner-read from this machine 2026-08-11. The caveat is discharged; the original measurement is not withdrawn. |
| C10 | "**Reopens on**: … primary evidence that AI engines stopped parsing it" | ⚠️ **UNFALSIFIABLE AS WRITTEN** | The reopen-condition asks for evidence that engines *stopped* parsing — but C7 concedes there is no evidence they ever *started*. A condition that presupposes an unestablished premise cannot fire. Flagged, not fixed. |

**Tally: 3 supported, 4 unsupported, 1 contradicted-as-scope, 1 unfalsifiable, 1 supported-and-strengthened.**
Every unsupported clause is in the 2026 FAQ narrative. Nothing in the 2023 record is unsupported.

---

## 2. Drafted replacement R3 — only what the primary source carries

> ### R3 — FAQPage schema is KEPT; its rich results were narrowed in 2023
>
> - **Statement**: On **2023-08-08** Google narrowed FAQ rich results to "well-known,
>   authoritative government and health websites"; for all other sites "this rich result will no
>   longer be shown regularly". **FAQPage generation stays in the library.** Google states that
>   existing markup needs no removal: "there's no need to proactively remove it", and unused
>   structured data "does not cause problems for Search, but also has no visible effects in
>   Google Search."
> - **What this ruling does NOT claim.** Three things previously asserted have **no primary
>   source** and are removed rather than restated at lower confidence:
>   1. that FAQ rich results **ended** in 2026;
>   2. that the search appearance, rich result report and Rich Results Test support were dropped
>      **June 2026**;
>   3. that Search Console API support is cut **August 2026**.
>   If any of the three is true, it is true on a source nobody here has produced. See §4 for
>   where the wording most likely came from.
> - **Rationale, bounded.** A skill may say FAQPage is valid, cheap to keep, and carries no
>   penalty. **It may not say it earns AI citations.** Google: "Structured data isn't required
>   for generative AI search, and there's no special schema.org markup you need to add. However,
>   it's a good idea to continue using it as part of your overall SEO strategy, as it helps with
>   being eligible for rich results on Google Search."
> - **Evidence grade**: **owner-read**, 2026-08-11, S1 + S2 + S3.
> - **Reopens on**: schema.org deprecating the FAQPage type; **or** a dated Google-primary source
>   for any 2026 FAQ change (which would restore a clause, not overturn this one).
>   *The old reopen-condition — "primary evidence that AI engines stopped parsing it" — is
>   dropped: it presupposes a parsing benefit this ruling declines to assert, so it could never
>   fire.*

---

## 3. Drafted replacement 9b — HowTo, and the four loci

**9b's ruling text as drafted is SUPPORTED and needs approval, not redrafting.** What needs a
precision is the **purge scope**.

> ### R6 (new) — HowTo rich results are deprecated
>
> - **Statement**: HowTo rich results are **deprecated**. Two stages, one source:
>   **2023-08-08**, "How-To (from HowTo structured data) rich results will only be shown for
>   desktop users, and not for users on mobile devices"; **2023-09-13**, "Google Search no longer
>   shows How-to rich results on desktop, **which means this result type is now deprecated**",
>   with the How-to search appearance, rich result report and Rich Results Test support dropped
>   at 30 days and Search Console API support at 180 days.
> - **No skill may teach HowTo rich results as an attainable SERP feature.**
> - **Scope — the SERP feature, not the markup.** This rules on the *rich result*. Whether
>   `HowTo` markup is generated at all is the R3 question (schema.org validity + non-Google
>   engines), and 9b must not decide it silently by deleting the type. Google's own position on
>   removal is the same as for FAQPage: permitted, not required.
> - **Explicitly NOT ruled**: any AI-engine/GEO parsing value. Asserting it is the exact claim
>   9a retracted for FAQPage — and it is open finding **#77**.
> - **Evidence grade**: owner-read, 2026-08-11, S1 including its 2023-09-14 update.

**What the four loci should say instead** — correct the SERP-feature claim, keep the markup
guidance:

| Locus | Currently teaches | Should say |
|---|---|---|
| `research/serp-analysis/references/serp-feature-taxonomy.md:30` (Rich Results row) | HowTo as a current SERP feature | HowTo listed as **deprecated (2023-09-13)** in the same register as any other retired feature — present for recognition, never as a target |
| `~:291` (How-To playbook rows) | a playbook for winning the feature | **Delete the playbook rows.** There is no result to win; a playbook for an unattainable feature is not correctable, only removable |
| `research/content-gap-analysis/references/gap-analysis-frameworks.md:150` | HowTo as a gap worth filling | remove HowTo from the attainable-feature list; a HowTo gap is a **content-format** gap, not a rich-result gap |
| `build/meta-tags-optimizer/references/ctr-and-social-reference.md:121` | HowTo as a CTR lever | remove — a result type that does not render cannot move CTR |

⚠️ **Deploy-gate interaction, unresolved**: the STATUS BANNER records that R132's grep gate is
pointed at Greek labels and inverts if parentheticals are dropped. Any purge touching these files
must be re-run against the **current** files, not the staged copies (R217).

---

## 4. The 2026 claims we cannot source, and where they most likely came from

**Cannot source (4)**: C1 "ended in 2026" · C2 "dropped June 2026" · C3 "API August 2026" ·
C6 "`2026-05-07` ended the display entirely".

**Most likely origin — clause-structure transposition from S1's HowTo update onto FAQ.**
Set them side by side:

> **S1, 2023-09-14, about HOW-TO**: "we will be dropping the **How-to search appearance, rich
> result report, and support in the Rich results test** in 30 days. To allow time for adjusting
> your API calls, **support for How-to in the Search Console API will be removed** in 180 days."

> **R3, about FAQ**: "the **search appearance, the rich result report and Rich Results Test
> support** were dropped June 2026, and **Search Console API support is scheduled** for August 2026"

The same three artefacts, in the same order, with the same "…and the API later" tail. This is the
strongest available explanation and it is offered as a **hypothesis with its evidence**, not as an
established fact: what is *established* is that no read source supports the FAQ version.

Two corroborating details:

1. **S1 explicitly says the opposite for FAQ.** "The search appearances, and the reports, will
   remain in Search Console **for the time being**." A drop-triple attributed to FAQ contradicts
   the only source that discusses FAQ reporting at all.
2. **The `2026-05-07` date is adjacent to a real thing that is not about FAQ.** S2 is dated
   2026-05-15 and announces the generative-AI guide (S3). A date near it, attached to a claim it
   does not make, is the signature of provenance drift — R322: proximity is not provenance.

**The irony worth recording**: the `<aside>` block that three readers walked past is the most
likely *source* of the fabricated narrative. Someone read it, and its content travelled to the
wrong feature and the wrong year while the block itself stayed unread by everyone who came after.

---

## 5. The method defect that produced all of this

Three independent reads of S1 — the cloud "Custom 1" environment, and this machine twice —
concluded HowTo was only desktop-restricted. All three extracted the **article body** and dropped
`<aside>`. That is standard readability behaviour, and it is **biased against exactly the class of
fact being asked about**: a deprecation notice is what a vendor puts in `<aside class="important">`.
A "has X been deprecated?" question answered by body scraping returns the pre-deprecation state,
with a genuine verbatim quote attached — which is what lets it survive review.

Convergence between independent readers is **not** corroboration when they share a method; it
re-measures the method's blind spot. Note that `WATCH-ITEMS.md` **W12 had this right** at
search-snippet grade on 2026-08-10, and all three owner reads regressed against it — a lower-grade
source beat three higher-grade ones because its extraction path differed.

**Proposed rule, for the coordinator to number:**

> When reading a primary source to establish whether something is current, deprecated or
> withdrawn, strip only `script`/`style`/`nav`/`head`. **Never strip `aside`, `callout`, `banner`,
> `admonition` or `note` containers** — status changes are announced there. Before concluding,
> grep the raw HTML for `update|deprecat|no longer|sunset|retired`.

---

## 6. Consequences beyond R3 — flagged, not applied

S3 is the first owner read of the AI-optimization guide, and it bears on three other rulings:

- **R1 (llms.txt is a dead lever) — upgrade available.** R1 rests on absence ("no engine-official
  adoption found"). S3 gives **positive primary evidence**: "You don't need to create new machine
  readable files, AI text files, markup, or Markdown to appear in Google Search (including its
  generative AI capabilities), as Google Search itself doesn't use them… **Google Search ignores
  them.**" R1's conclusion is unchanged; its evidential basis moves from absence-of-evidence to
  evidence-of-absence, which is a materially stronger position.
- **R2 (schema-stacking is not an AI-citation lever) — supported.** S3: "there's no special
  schema.org markup you need to add."
- **Open finding #77** — the benchmark asserts "engines parse the visible Q&A either way" as fact.
  S3 is the closest primary source and **does not support it**: it says structured data is not
  *required* for generative AI search and is silent on parsing. So #77's claim remains unsourced,
  and S3 leans against its framing. #77 is a Section A item — ruling, not edit — and is untouched.
- **R5 (unlinked brand mentions are a GEO signal) — nuance, not contradiction.** S3 confirms the
  mechanism ("our generative AI features can show what's being said about products and services
  across the web, including in blogs, videos, and forum discussions") while warning that "seeking
  inauthentic 'mentions'… isn't as helpful as it might seem." R5 is about mentions as a *signal*,
  not about manufacturing them, so this is a boundary worth stating rather than a reopen.

Two further S3 findings with no current ruling, recorded so they are not lost: Google states there
is **no requirement to "chunk" content** for AI, and **no need to rewrite content specifically for
AI systems**. Both are live beliefs in the GEO literature this library draws on.
