# R3 — supersession candidate for Sani's gate

> # ⛔ DO NOT RULE ON THIS DOCUMENT AS DRAFTED
>
> **Adversarial review, 2026-08-13: BLOCK.** The audit's method is sound and its central finding
> (row 19) is real and important. The problem is the **replacement text it proposes to write into
> `SETTLED-RULINGS.md`** at §2, which reintroduces a falsehood this library removed from thirteen
> shipped surfaces earlier the same day:
>
> > *"a skill may say FAQPage is valid and cheap to keep, **and that Google advises against
> > proactively removing it**"* — §2, and labelled *"carried unchanged from 9a"*.
>
> Three things make this worse than an ordinary drafting slip:
>
> 1. **Google never said it.** Its words are *"While you can drop this structured data from your
>    site, there's no need to proactively remove it"* — a permission, and an explicit permission to
>    drop. Ledger **F11 recurrence 6** records this exact rewrite as instance 1 of three.
> 2. **The guard cannot catch it here.** `validate-tracking.sh` now hard-fails that phrase, but
>    scopes the scan to the shipped skill trees; `docs/loop/` is deliberately exempt so the registers
>    can quote retired states. Written into R3, it ships silently — and becomes the source every
>    future downstream sweep copies from.
> 3. **It is mislabelled as a carry-forward.** 9a's actual clause is *"A skill may say FAQPage is
>    valid and cheap to keep. It may not say it earns AI citations."* The removal half is an
>    **addition** presented as unchanged, which is the one shape a gate cannot catch by diffing.
>
> The faithful sentence is three lines above the defective paraphrase, in this same file (rows 6
> and 16 quote Google correctly). **Fix before this reaches the gate**: replace with *"…and that
> Google's own guidance is that there is no need to proactively remove it — a permission to leave
> existing markup alone, not advice to keep it"*, and either drop "carried unchanged" or state
> what was added.
>
> **Seven further FIX items** are recorded in the review, and two are worth the owner knowing
> before reading anything below:
>
> - **The verdict counts understate the case for supersession.** Applied strictly to this
>   document's own vocabulary, four rows graded SUPPORTED are `[repo]` or normative claims that no
>   Google quote could carry, and row 13 concedes in its own basis cell that it cannot be
>   established. The honest split is closer to **2 SUPPORTED / 10 UNSUPPORTED / 4 CONSISTENT /
>   2 CONTRADICTED**. The error runs in R3's favour — the case against R3 is *stronger* than the
>   table says.
> - **§6's collateral list is wrong in both directions.** It undercounts the extent (see
>   `r3-decision-brief.md`: 28 lines across 14 files, not ~14), misses three shipped surfaces
>   asserting the retracted rationale, carries two pointers that no longer resolve, and its
>   `content-refresher` line is stale — that skill was swept on 2026-08-13. What it misses there
>   matters most: **`optimize/content-refresher/evals/evals.json` requires the retracted rationale
>   as a pass condition** in three expectations, and check (f) excludes `evals/`, so no guard sees
>   them.
>
> Full review: the Mode A report for this document, 2026-08-13. **Everything below this banner is
> unchanged from the original draft** — it has not been silently repaired, so the review's line
> references still resolve.


> **PROPOSED, NOT APPLIED.** This file is a draft placed in front of the gate. Nothing in it
> has been written into `SETTLED-RULINGS.md`, `GATED-ITEMS.md`, `WATCH-ITEMS.md` or any skill.
> `SETTLED-RULINGS.md:5-6` requires exactly this: *"If superseding primary evidence appears, do
> not edit here directly: label it a 'supersession candidate for Sani's gate' in the weekly
> report and route it through `GATED-ITEMS.md`."* Both registers were left untouched. This file
> is the only artefact of this run.
>
> **Raised**: 2026-08-13. **Subject**: ruling R3 and its applied amendment 9a; held proposal 9b.
> **Verdict sought**: supersede R3's timeline clauses; re-scope 9b from a purge to a correction.

## The evidence this rests on

One document: `docs/loop/pilot/g9-owner-read-2026-08-11.md`, on branch
`origin/claude/pilot-crawl-2026-08-11`. A session on an unrestricted network fetched both URLs
R3 names, at `HTTP 200`, and quoted them verbatim against the raw HTML. Two sources:

| # | URL | Date on the post |
|---|---|---|
| S1 | `developers.google.com/search/blog/2023/08/howto-faq-changes` | **2023-08-08** |
| S2 | `developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing` | **2026-05-15** |

Every quotation below is lifted verbatim from that record. Where a claim has no quote, the cell
says **"no source found in either fetched document"** — which means exactly that and **does not
mean the claim is false**. This file records absence of evidence. It does not manufacture
evidence of absence.

**R3's keep-decision survives, and is now better sourced than it has ever been.** Its dates do
not. One of the failing clauses was written into the register on 2026-08-11 by this loop's own
coordinator, as amendment 9a, and is included in the table below on the same terms as the rest.

**Line numbers in this file are as at commit `378212e` (2026-08-13 05:39 UTC), and every one was
verified against that HEAD by grepping its token.** The repo moved twice while this file was
being written — `f3c9bca` fixed a directly-related finding and `378212e` re-anchored R3's own
`VERSIONS.md` pointer from `:232` to `:233` — so each pointer below carries its **anchor token**
per F12. On any mismatch, grep the token; the token is authoritative and the line number is not.

---

## 1. Clause-by-clause audit of R3 as it stands

**Verdict vocabulary.** SUPPORTED — a verbatim quote in S1 or S2 carries it. UNSUPPORTED — no
source found in either fetched document. CONTRADICTED — a verbatim quote in S1 or S2 says
otherwise. Rows marked **[repo]** are claims about this repository, not about the world; they
are checked against the repo at HEAD, not against S1/S2, and are counted separately.

### Block A — R3's Statement (`SETTLED-RULINGS.md:86-88`)

| # | Clause, verbatim from R3 | Verdict | Basis |
|---|---|---|---|
| 1 | "Google ended FAQ rich results in 2026" | **UNSUPPORTED** | No source found in either fetched document. S1 carries a *narrowing*, not an end: "Going forward, FAQ (from FAQPage structured data) rich results will only be shown for well-known, authoritative government and health websites." |
| 2 | "the search appearance … [was] dropped June 2026" | **UNSUPPORTED** | No source found in either fetched document. |
| 3 | "the rich result report … [was] dropped June 2026" | **UNSUPPORTED** | No source found in either fetched document. S1's only statement on the reports, dated 2023-08-08: "The search appearances, and the reports, will remain in Search Console for the time being." |
| 4 | "Rich Results Test support [was] dropped June 2026" | **UNSUPPORTED** | No source found in either fetched document. |
| 5 | "Search Console API support is **scheduled for August 2026**" | **UNSUPPORTED** | No source found in either fetched document. |
| 6 | "but FAQPage generation stays in the library" | **SUPPORTED** | "While you can drop this structured data from your site, there's no need to proactively remove it." · "Structured data that's not being used does not cause problems for Search, but also has no visible effects in Google Search." |

### Block B — amendment 9a (`SETTLED-RULINGS.md:89-110`, applied 2026-08-11)

| # | Clause, verbatim from 9a | Verdict | Basis |
|---|---|---|---|
| 7 | "`2023-08-08` narrowed FAQ rich-result **eligibility** to well-known government and health sites" | **SUPPORTED** | Post dated "Tuesday, August 8, 2023". "FAQ (from FAQPage structured data) rich results will only be shown for well-known, authoritative government and health websites." · "For all other sites, this rich result will no longer be shown regularly." |
| 8 | "`2026-05-07` ended the **display** entirely" | **UNSUPPORTED** | No source found in either fetched document. S2 is dated 2026-05-15 and, per the owner read, has "zero occurrences of 'FAQ'". |
| 9 | "Both are real; neither contradicts the other" | **UNSUPPORTED** | Sound for the 2023 event (row 7). No source found in either fetched document for the 2026 event, so "both are real" asserts more than the evidence carries. |
| 10 | "this ruling's original one-line 'retired in 2026' hid the earlier change" | **SUPPORTED** **[repo]** | True of the pre-9a register text. The correction was right; it was made in the wrong direction (row 11). |
| 11 | The Greek editor "was right that something was wrong, and **wrong about which date was the error**" | **CONTRADICTED** | The editor's date is the sourced one. 2023-08-08 is the only dated FAQ change in either fetched document; the 2026 date has no source in either. 9a resolved the disagreement in favour of the unsourced date. The editor was imprecise on one point only — the 2023 change is a narrowing, not a full deprecation, and S1 says the reports "will remain in Search Console for the time being". |
| 12 | "The API cut is **scheduled, not observed**" | **UNSUPPORTED** | Directionally the right instinct, applied to an event with no source at all. No source found in either fetched document for an August 2026 API cut, scheduled or executed. Softening an unsourced claim leaves it unsourced. |
| 13 | "**No primary source supports that clause** [FAQPage's value is AI-engine/GEO parsing], **and none refutes it**" | **SUPPORTED** | Consistent with both documents: S1 says nothing about AI parsing; S2 has "zero occurrences of 'structured data'". Scope limit: two fetches cannot establish a universal negative over all primary sources. |
| 14 | "Google's 2026 AI-optimization guide states that no special structured data is needed for its own AI surfaces" | **UNSUPPORTED** | No source found in either fetched document. The guide itself (`/search/docs/fundamentals/ai-optimization-guide`) **was never fetched**; S2 merely announces it and mentions no structured data. |
| 15 | "A skill may say FAQPage is valid and cheap to keep. It may not say it earns AI citations." | **SUPPORTED** | Both halves hold: the permission on row 6's quotes, the prohibition on row 13. This is 9a's most durable clause and the draft keeps it verbatim. |
| 16 | "Google's own guidance that there is **no need to proactively remove** existing FAQPage markup" | **SUPPORTED** | "While you can drop this structured data from your site, there's no need to proactively remove it." Verbatim, and now owner-read rather than snippet-grade. |

### Block C — R3's apparatus: evidence grade, hold, pointers, reopen condition

| # | Clause, verbatim from R3 | Verdict | Basis |
|---|---|---|---|
| 17 | "snippet-grade from domain-restricted queries against Google's own domain, **not owner-read**" | **SUPPORTED** **[repo]** | Accurate self-description at the time. Now superseded for S1/S2 by the owner read; still accurate for every claim sourced elsewhere (see §4). |
| 18 | "`developers.google.com` is refused by this environment's network egress policy" | **SUPPORTED** **[repo]** | Unchallenged. The owner read ran from a different network ("Custom 1"), so the block is a property of this environment, not of the URL. |
| 19 | "The two source URLs are `…/2023/08/howto-faq-changes` and `…/2026/05/a-new-resource-for-optimizing`" | **CONTRADICTED** | **The central finding.** Both were fetched at `HTTP 200` and **neither carries any clause of the 2026 narrative they are cited for.** R3 cites, as its sources, two documents that do not contain its claims. |
| 20 | "an owner read of those two would upgrade this grade in about two minutes in a browser" | **SUPPORTED** | Correct, and executed 2026-08-11. The upgrade ran in the opposite direction to the one anticipated: it removed support for five clauses and added support for one. |
| 21 | "proposal 9b … is **held** … until that owner read happens" | **SUPPORTED** **[repo]** | The stated condition is now met. 9b is unblocked — and, on this evidence, unblocked into a different shape (§3). |
| 22 | "**Decided**: 2026-08-08 sweep (retirement reflected in schema-markup-generator 4.0.1)" | **SUPPORTED** **[repo]** | `VERSIONS.md:232` carries the row. |
| 23 | "**Encoded in repo**: `build/schema-markup-generator/SKILL.md:223`" | **CONTRADICTED** **[repo]** | Stale by 7 lines. The FAQ-exception text is at `:230` at HEAD; `:223` resolves to "2. **Schema.org Validator**". Unlike R3's `VERSIONS.md` pointer, this one carries **no anchor token**, so `reanchor-pointers.sh` cannot carry it. |
| 24 | "`VERSIONS.md:233` ('schema-markup-generator 4.0.1')" | **SUPPORTED** **[repo]** | Pointer resolves — and it moved from `:232` to `:233` during the writing of this file (commit `378212e`), which is the anchor contract working as designed. But see §6: the line it resolves to reads "FAQPage generation kept for **AI-engine/GEO parsing**" — R3's own anchor token still asserts the rationale 9a retracted. |
| 25 | "**Reopens on**: … primary evidence that AI engines **stopped** parsing it" | **UNSUPPORTED** | The condition presupposes that AI engines currently parse it — the state row 13 records as having no primary source either way. A reopen condition whose premise is unsourced cannot be evaluated. |

### Verdict counts

| | SUPPORTED | UNSUPPORTED | CONTRADICTED | Total |
|---|---|---|---|---|
| Source-turning rows | 6 | 10 | 2 | **18** |
| **[repo]** rows | 6 | 0 | 1 | **7** |
| **All rows** | **12** | **10** | **3** | **25** |

Every clause of R3's headline timeline — rows 1-5 and 8 — is UNSUPPORTED. Every clause of its
keep-decision — rows 6, 15, 16 — is SUPPORTED.

---

## 2. Drafted replacement R3

Proposed to replace `SETTLED-RULINGS.md` lines 84-130 in full. Not applied.

> ### R3 — FAQPage schema is KEPT; the retirement timeline is unsourced and stated as such
>
> - **Statement**: FAQPage generation stays in the library. Google's own words: *"While you can
>   drop this structured data from your site, there's no need to proactively remove it.
>   Structured data that's not being used does not cause problems for Search, but also has no
>   visible effects in Google Search."* The markup is a valid schema.org type (v30.0, pinned
>   baseline) and costs nothing to keep. **That, and no more, is the basis.**
> - **What the primary source establishes about FAQ rich results — one dated change, 2023-08-08**:
>   *"Going forward, FAQ (from FAQPage structured data) rich results will only be shown for
>   well-known, authoritative government and health websites."* · *"For all other sites, this
>   rich result will no longer be shown regularly."* · *"Sites may automatically be considered
>   for this treatment depending on their eligibility."* Rollout: *"This update is rolling out
>   globally, in all languages and countries, over the course of the next week"*, with *"a small
>   holdback experiment"*. Google adds: *"This should not be considered a ranking change and
>   won't be listed in the Search status dashboard."*
> - **What the primary source establishes about Search Console, as of 2023-08-08**: *"The search
>   appearances, and the reports, will remain in Search Console for the time being."* · *"This
>   change does not affect the number of items reported in the enhancement reports."* **No later
>   state is documented in anything this loop has read.**
> - **What this ruling asserted until 2026-08-13 and can no longer source.** Recorded, not
>   deleted — a ruling that quietly loses a claim teaches nothing:
>   1. that Google ended FAQ rich results in 2026; 2. an end-of-display date of `2026-05-07`;
>   3. that the search appearance was dropped June 2026; 4. that the rich result report was
>   dropped June 2026; 5. that the Enhancements appearance filter was dropped June 2026;
>   6. that Rich Results Test support was dropped June 2026; 7. that Search Console API support
>   was scheduled for August 2026; 8. that Google's 2026 AI-optimization guide states no special
>   structured data is needed for its AI surfaces.
>   **Each of the eight: no source found in either fetched document.** They are **not** ruled
>   false. They are ruled unsourced, which is a different thing and is why the library's text
>   must stop asserting them as fact. If they are true, a document says so and nobody here has
>   read it — see §5 of `docs/loop/r3-supersession-candidate.md` for exactly which document.
> - **What a skill may say** (carried unchanged from 9a, its most durable clause): **a skill may
>   say FAQPage is valid and cheap to keep, and that Google advises against proactively removing
>   it. It may not say it earns AI citations, and it may not date the end of FAQ rich results.**
>   Where a deliverable needs to characterise FAQ SERP status, the sourced sentence is: since
>   2023-08-08 Google shows FAQ rich results only for well-known, authoritative government and
>   health sites, and for all other sites they are no longer shown regularly.
> - **Evidence grade — owner-read verbatim, upgraded 2026-08-11.** Both cited URLs fetched at
>   `HTTP 200` on an unrestricted network and quoted against raw HTML:
>   `developers.google.com/search/blog/2023/08/howto-faq-changes` (2023-08-08) and
>   `developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing` (2026-05-15).
>   Record: `docs/loop/pilot/g9-owner-read-2026-08-11.md`. The 2026 article is silent on this
>   subject — zero occurrences of "HowTo", "FAQ" or "structured data" in the whole piece; it
>   announces a generative-AI guide. Previous grade was snippet-grade from domain-restricted
>   queries; `developers.google.com` was refused by this environment's egress policy
>   `[obs:2026-08-11T03:40:00Z curl + WebFetch, both refused at the gateway]` — **not re-tested by
>   the run that raised this candidate**, so any further upgrade should assume the same
>   off-network route until someone re-tests it.
> - **Decided**: 2026-08-08 sweep. Provenance amended 2026-08-11 (9a). **Timeline clauses
>   superseded [DATE OF SANI'S VERDICT] on owner-read primary evidence** — the first supersession
>   in this register, and one that removed claims rather than adding them.
> - **Encoded in repo**: `build/schema-markup-generator/SKILL.md` (anchor token: "FAQ exception:"
>   — `:230` at the time of writing; the token is authoritative on any mismatch, per F12);
>   `VERSIONS.md` (anchor token: "schema-markup-generator 4.0.1"). Both need the rewrite this
>   supersession implies before they are quoted as encoding it — see §6.
> - **Reopens on**: schema.org deprecating the FAQPage type itself; **or** a Google-primary
>   document establishing the 2026 timeline, which would restore the superseded clauses with a
>   citation; **or** primary evidence bearing on whether AI engines parse FAQPage — in **either**
>   direction, since no primary source currently establishes that they do.

**What changed and why**: the reopen condition's second limb is rewritten because the old one
(row 25) presupposed a fact 9a had already retracted, and so could never fire. The old first
limb is unchanged. A third limb is added so that finding the missing 2026 document is a
recognised route back, not a relitigation.

---

## 3. Drafted replacement for proposal 9b

**9b's premise is gone, and the verb was wrong.** 9b proposed to *"rule that HowTo rich results
ended in 2023 and purge the four library loci still teaching them as a current SERP feature"*.
S1 does not end them. S1 limits them:

> How-To (from HowTo structured data) rich results will only be shown for desktop users, and
> not for users on mobile devices.

> In particular, we're reducing the visibility of FAQ rich results, and limiting How-To rich
> results to desktop devices.

> Note that with mobile indexing, Google indexes the mobile version of a website as the basis
> for indexing: to have How-To rich results shown on desktop, the mobile version of your
> website must include the appropriate markup.

A purge executed on the old premise would have **deleted true, sourced, operationally useful
guidance** — including the mobile-markup requirement above, which the library does not carry
anywhere and which changes what an implementer does. **9b becomes a correction, not a purge.**

### 9b-r2 — the four loci, named, with the text they should carry

| # | Locus (anchor token authoritative) | What it says now | What it should say |
|---|---|---|---|
| L1 | `research/serp-analysis/references/serp-feature-taxonomy.md:30` · token `How-To, Review Stars, Recipe, Event, Product (FAQ retired 2026)` | Lists How-To as a current rich result; parenthesises FAQ as "retired 2026" | How-To listed as **desktop-only since 2023-08-08**; the FAQ parenthetical replaced with "FAQ: government/health sites only since 2023-08-08" — the "retired 2026" claim is unsourced (§1 row 1) |
| L2 | `research/serp-analysis/references/serp-feature-taxonomy.md:291` · token `\| How-To \| HowTo \| Step-by-step instructions \| Steps with optional images \|` | Promises a SERP appearance ("Steps with optional images") with no device qualifier | Same row, appearance column qualified: desktop only, per Google 2023-08-08; **and** the mobile-markup requirement stated, because it is the actionable half — the mobile version must carry the markup for the desktop result to show. No post-2023 status is documented |
| L3 | `research/content-gap-analysis/references/gap-analysis-frameworks.md:161` · token `\| Step-by-step tutorials \| How-To rich results, Featured Snippet (list) \| HowTo \|` | "How-To rich results" as an unqualified opportunity | "How-To rich results (desktop only since 2023-08-08)". **Note the pointer drift**: W12 and G9 both cite `:150`; the token is at `:161` at HEAD |
| L4 | `build/meta-tags-optimizer/references/ctr-and-social-reference.md:155` · token `Rich results (schema)` | "FAQ rich results were retired in 2026, and whether How-to results are still offered is `[VERIFY]`-tagged … promise no How-to appearance" | The How-to `[VERIFY]` **resolves in part**: desktop-only is now owner-read fact, so say that; keep "promise no How-to appearance" as the operating rule, since the post-2023 state is undocumented. The FAQ half needs the §1 row 1 correction. **Pointer drift**: W12 and G9 both cite `:121`; the token is at `:155` at HEAD |

### 9b-r2 must also fix its own premise where the library already carries it

The false premise is not confined to the proposal. Three surfaces state it in `[VERIFY]` prose,
attributing to S1 a September update S1 does not contain:

- `build/schema-markup-generator/SKILL.md:163`
- `build/schema-markup-generator/references/validation-guide.md:257`
- `build/schema-markup-generator/references/schema-decision-tree.md:34` (and the `:20` table cell that points at it)

All three read, near-identically: *"quoted as taking How-to results desktop-only and then
dropping them 'as of September 13', with the How-to report and Rich Results Test support
withdrawn."* The first half is verbatim-confirmed. The second half is **contradicted by the
document it is attributed to**: S1, fetched at `HTTP 200` in 2026, says of both HowTo and FAQ,
*"The search appearances, and the reports, will remain in Search Console for the time being."*
These `[VERIFY]` tags stay `[VERIFY]` — the post-2023 status genuinely is unknown — but the
sourced half and the unsourced half must be separated, and the "as of September 13" quote must
stop being attributed to S1.

**Residual, stated because it changes how hard this bites**: the owner read recorded an explicit
zero-occurrence search for S2 but not for S1. Its treatment of S1 is a verbatim walk through
exactly this question and mentions no September update, and its own observation 3 separates "the
HowTo desktop-only limitation (2023)" from "any later retirement". A one-line string search of S1
for "September" would convert this from strong inference to settled (§5).

### What 9b-r2 does not do

It does not rule on HowTo's status after 2023-08-08. Nothing read establishes it. `W12` stays
open with its resolve-condition **partly** met: the desktop-only limitation is settled at
owner-read grade; the retirement question is not, and its previous "CORROBORATED" verification
bullet (`WATCH-ITEMS.md:218-231`) is the specific text that needs withdrawing.

---

## 4. The unsourceable claims, named — and where they came from

### The list

| ID | Claim | Where it lives now |
|---|---|---|
| U1 | FAQ rich results ended / display ended **2026-05-07** | R3 statement; 9a; ~14 skill surfaces (§6) |
| U2 | FAQ **search appearance** dropped **June 2026** | R3 statement; `schema-markup-generator` |
| U3 | FAQ **rich result report** dropped **June 2026** | R3 statement; `schema-markup-generator` |
| U4 | **Enhancements appearance filter** dropped **June 2026** | Dropped from R3 by 9a; **survives** at `validation-guide.md:31` and `:243` |
| U5 | **Rich Results Test** support dropped **June 2026** | R3 statement; `schema-markup-generator`; `schema-templates.md:23` |
| U6 | Search Console **API** support scheduled **August 2026** | R3 statement; 9a; 5+ surfaces |
| U7 | Google "removed documentation for the FAQ rich result feature" (May/June 2026) | Research lane finding 7 only; never reached a register |
| U8 | The AI-optimization guide states no special structured data is needed | 9a, in R3 today; `validation-guide.md:245`; `VERSIONS.md:135` |
| U9 | *(not a 2026 claim; same failure)* S1's "September update": *"As of September 13, Google Search no longer shows How-to rich results on desktop"*, with appearance/report/RRT dropped in 30 days and API at 180 days | `W12`; 9b's premise; three `schema-markup-generator` surfaces |

### Reconstruction: it was neither a bad source nor no source — it was a **substituted** source

The proximate source of U1-U7 is **not either URL R3 cites**. It is a third URL that appears
nowhere in R3, G9 or W12: `https://developers.google.com/search/updates`, the Search Central
documentation changelog. It is named in findings 3, 4 and 7 of the coordinator's 2026-08-10
research transcription (scratchpad `research-r3-faq-timeline.md`), which is the earliest
surviving artefact of the chain.

R3's evidence clause then offered, for owner-read verification, the two blog URLs — which were
the sources for the *2023* material (finding 1) and the *AI-guide* material (finding 8). **The
two URLs that got verified were never the two URLs the disputed claims came from.** That is why
an owner read designed to upgrade the evidence grade instead removed it: it verified the wrong
documents, exactly as instructed.

**The chain, with what survives at each hop:**

1. A research lane runs WebSearch (its own header: `[BLOCKED-EGRESS: developers.google.com …]`,
   *"every Google-primary quote below is primary-domain snippet/summary-verified … It is not
   owner-read verbatim"*). **Nothing survives** — no raw return, no query string, no timestamp.
2. The lane returns a narrative summary. It *"had no Write/Bash tool"*, so it wrote nothing.
   **Nothing survives.**
3. The coordinator hand-transcribes that narrative into the scratchpad, 2026-08-10. **This is the
   earliest artefact that exists.**
4. G9 quotes the transcription. R3 quotes G9. Skill surfaces quote R3.

**Can I tell whether a real snippet ever returned those strings? No — and I will not guess.**
At hop 3, "a real `/search/updates` entry, accurately transcribed" and "a plausible continuation
generated from the real 2023 document, transcribed in good faith" are observationally identical.
No HTTP status, no fetch time, no captured text exists at any earlier hop to separate them.

Two things do bear on it. Both are recorded here rather than weighed into a conclusion:

- **Against the lane's reliability**: U9 is the one claim from that lane whose named source has
  now actually been fetched — and the document does not contain it, and says something close to
  its opposite about the reports. One falsified sibling does not falsify U1-U7, which come from a
  different, still-unfetched URL. It does remove the clean record that made the lane's other
  quotes worth trusting at snippet grade.
- **Neutral, and easily over-read in either direction**: U9's "30 days / 180 days" and U1-U6's
  "June 2026 / August 2026" are the same deprecation template with the intervals moved. Google
  genuinely writes deprecations that way, so this is equally consistent with a real changelog
  entry and with a pattern completed from the 2023 post. **It distinguishes nothing.**

**The one test that would settle it** is in §5, and it is cheap.

### The process defect this exposes, stated once

Snippet grade was the accepted grade (W5, W7 precedent). The failure is not that snippet grade
was used. It is that **the citation and the evidence came apart**: a ruling named two URLs as its
sources while its load-bearing claims came from a third, and no check in the loop compares a
ruling's cited URLs against the URLs its claims were actually drawn from. Nothing in
`pre-push-gate.sh` or the claims-gate looks at that, and the 2026-08-11 owner read only caught it
by accident — it fetched what it was told to fetch and found nothing there.

---

## 5. What is still unknown, and what would settle it

Ordered by value. Every item is a fetch nobody in this loop can perform from this environment;
all need the off-network route that produced the 2026-08-11 owner read.

| # | Unknown | What settles it |
|---|---|---|
| K1 | **Did the 2026 FAQ retirement happen at all?** U1-U6 stand or fall together. | Owner read of `https://developers.google.com/search/updates`, May and June 2026 entries. This is the URL the claims actually came from and **it has never been fetched by anyone**. Also decides §4's "bad source or no source": if the entries are there, it was a real source badly cited; if they are absent, the claims had no source. |
| K2 | **The next owner read, and the obvious one.** `https://developers.google.com/search/docs/fundamentals/ai-optimization-guide` — linked from S2, **never fetched**. It is the sole source for U8, which stands unqualified in R3 `[obs:2026-08-13T05:41:00Z SETTLED-RULINGS.md:104-105 read at commit 378212e]`, and the only Google-primary surface that could bear on R3's rationale in either direction. | Fetch it and string-search: `structured data`, `schema.org`, `machine readable`, `AI text files`, `FAQPage`. The lane's finding 8 quotes it as saying *"You don't need to create new machine readable files, AI text files, or markup to appear in AI Overviews and AI Mode features, and there's no special schema.org structured data that you need to add"* — at snippet grade, tagged by the lane itself as `[VERIFY]` for exact wording, and asserted in 9a without that tag. |
| K3 | **Is there a September 2023 update to S1?** Decides U9 and the §3 residual. | A string search of S1 for `September` and `no longer shows`. The owner read recorded an explicit zero-occurrence search for S2 only. Roughly thirty seconds on the already-fetched page. |
| K4 | **HowTo's status after 2023-08-08.** Desktop-only is settled; whether it was later withdrawn is not. | `/search/updates` (K1's fetch covers it), plus whether `https://developers.google.com/search/docs/appearance/structured-data/how-to` still resolves. |
| K5 | **Did the August 2026 API removal execute?** Today is 2026-08-13 — in-month if U6 is real at all. | Moot unless K1 confirms U6. Then: the changelog, or an actual Search Console API call for the FAQ search-appearance dimension. |
| K6 | **Current HTTP state of `/search/docs/appearance/structured-data/faqpage`** — U7's subject. | Fetch it: `200`, `404`, redirect, or notice-only. A removed page is corroboration for K1; a page that still resolves substantially undercuts U1-U7. |
| K7 | **Do AI engines parse FAQPage?** Nothing found either way; R3's original rationale and OPEN-FINDINGS 77's twin both turn on it. | Engine-published documentation or research. **Absence of evidence, and it should stay recorded as absence** — nothing here licenses asserting the negative either. |
| K8 | **Whether the lane's snippets were ever real.** | Not recoverable from the repo — no artefact survives before hop 3. The only available proxy is re-running the same domain-restricted queries from an unrestricted network and seeing whether the returns reproduce. Combined with K1, this is decisive; alone, it is suggestive. |

---

## 6. Collateral this supersession would reach — named, not proposed here

Recorded so the gate can size the wave. **No edit to any of these is proposed in this file**;
several sit inside another session's claimed paths per `OPEN-FINDINGS.md`.

**Surfaces asserting the unsourced 2026 dates as fact** (~14, across 6 skills):
`build/schema-markup-generator/SKILL.md` (`:4` description frontmatter, `:61`, `:230`, `:248`,
`:346`) · `build/schema-markup-generator/references/validation-guide.md` (`:31`, `:231`, `:241`,
`:243`, `:403`) · `build/schema-markup-generator/references/schema-decision-tree.md:21` ·
`build/schema-markup-generator/references/schema-templates.md:23` ·
`research/serp-analysis/references/serp-feature-taxonomy.md` (`:30`, `:83`, `:290`) ·
`research/serp-analysis/references/analysis-templates.md:162` ·
`research/content-gap-analysis/references/gap-analysis-frameworks.md:160` ·
`build/seo-content-writer/references/content-structure-templates.md` (`:808`, `:896`) ·
`build/meta-tags-optimizer/references/ctr-and-social-reference.md:155` · `VERSIONS.md:232`.

**The 9a downstream sweep is incomplete, and its own changelog entry overstates it.**
`VERSIONS.md:135` records that sweep as having found and fixed "ten, spread over six skills",
naming `commands/generate-schema.md` as the sharpest case. At HEAD, four surfaces still assert
the retracted AI-parsing rationale as fact:

- `commands/generate-schema.md:54` — "FAQPage: none, retired 2026; **value is AI-engine/GEO parsing** (settled ruling R3)", inside a template block the operator copies. This is the exact file and the exact defect `VERSIONS.md:135` claims it fixed.
- `build/schema-markup-generator/references/schema-templates.md:23` — "still generated because **AI engines extract clean Q&A pairs from it** (settled ruling R3)" — in the skill that carried the sweep's version bump.
- `research/content-gap-analysis/references/gap-analysis-frameworks.md:160` — "AI-engine Q&A extraction … FAQPage (**GEO parsing only**, ruling R3)".
- `VERSIONS.md:233` · token `schema-markup-generator 4.0.1` — "FAQPage generation kept for **AI-engine/GEO parsing**" — which is R3's own **anchor token**. The ruling's encoded-in-repo pointer resolves to a line asserting what the ruling retracted.

Plus the four `content-refresher` surfaces deliberately deferred behind a blind run
(`OPEN-FINDINGS.md` finding 66) — already tracked, and pointed the same way by this evidence.

**One precedent, and it is this loop's own, from today.** OPEN-FINDINGS finding 77 — the
benchmark asserting the mirror of what 9a retracted — was fixed on 2026-08-13 in commit
`f3c9bca`. `references/core-eeat-benchmark.md:314` (token `Structured FAQ covering long-tail
follow-ups`) now reads: *"This previously read 'engines parse the visible Q&A either way',
asserting engine behaviour as fact … the criterion now rests on what the page contains rather
than on what an engine does with it."* That is precisely the move this candidate asks R3 to make
about its own dates, already accepted once at the framework level.

**Registers that would need to follow, once Sani has ruled**: `WATCH-ITEMS.md` W12 (withdraw the
"CORROBORATED" verification bullet at `:218-231`; correct the stale `:150`/`:121` pointers to
`:161`/`:155`), `GATED-ITEMS.md` G9 (record the split verdict's second half and 9b's re-scope),
`docs/loop/FAILURE-LEDGER.md` (the citation/evidence-divergence class in §4 has no ledger entry).

---

*Raised 2026-08-13 by the R3 supersession lane, which holds this file per the `OPEN-FINDINGS.md`
work claim. Files edited by this run: this one. `SETTLED-RULINGS.md` and `GATED-ITEMS.md`
deliberately untouched — the protocol at `SETTLED-RULINGS.md:5-6` reserves both to Sani's gate.*
