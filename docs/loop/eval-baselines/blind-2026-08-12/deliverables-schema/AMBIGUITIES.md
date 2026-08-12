# Ambiguity log — `build/schema-markup-generator`

Nine forks. Four are defects in the instrument (A2–A5); three are genuine underdetermination the
requests forced (A6, A7, A9); one is a blocked pointer (A1); one is a silence (A8).

---

## A1 — Blocked pointer: the skill's authority for its central rule is in banned territory

**Where**: every request. SKILL.md step 1 (line 117) and the R2 statement in step 2 (line 172).

**The instruction**: *"The benchmark's Section 5 table and settled ruling R2 (`docs/loop/SETTLED-RULINGS.md`) state one boundary, not two"*. The same file is the cited authority for R3 and for "R3 amendment 9a", which between them govern the entire FAQ treatment.

**Status**: blocked under the run's §1.3. Not followed.

**Effect**: none operationally. The skill restates the substance of R2 and R3 inline at every point of use — the one-primary-type rule, the stacking ban, the auxiliary carve-out, and the FAQ retirement are all fully spelled out in SKILL.md, schema-decision-tree.md and validation-guide.md. I worked from those statements. Nothing in the five deliverables depended on reading the ruling file.

**Adjacent pointer I also did not follow, and this one was a choice, not a block**: schema-templates.md line 17 and SKILL.md's output-validation checklist both cite `build/seo-content-writer/references/anti-slop-ruleset.md` §6 family 7 for the ban on `~~category` tokens on client-facing surfaces. That path is not banned by this run. I did not read it, because the substance is stated inline at both citation sites and reading a sibling skill's references sits outside the reading list I was given. If §6 family 7 carries obligations beyond "no `~~` tokens in front of a client", they are not in my deliverables.

---

## A2 — The skill prescribes an in-repo ruling ID inside client-facing output

**Where**: request 3. SKILL.md step 1, the Eligible Rich Results table template.

**The instruction**: the template row is, verbatim, `| FAQ | ❌ (ended 2026) | No SERP result. Valid markup, no evidenced citation benefit (R3 + 9a) |`. That table is prescribed output — it goes in the deliverable. Twenty lines later the same file says *"`[VERIFY]` is an in-repo tag and never appears in a deliverable"*, and the output-validation checklist bans `~~category` tokens on *"a surface the client reads"*. Neither rule mentions ruling IDs.

**Two readings**:
- (a) Reproduce the prescribed cell verbatim. The template is the template; "(R3 + 9a)" is inside it.
- (b) Strip it. `R3` and `amendment 9a` are in-repo bookkeeping of exactly the same class as `[VERIFY]` and `~~schema validator` — meaningless to a client, and they advertise that the deliverable was assembled from an internal rulebook.

**Took**: (b). The FAQ row in `e3-out.md` reads *"No SERP result. The markup is valid and cheap to keep; no evidenced citation benefit either way"* — substance preserved, citation dropped. Applied consistently: no ruling ID appears in any of the five files.

**What (a) would have produced**: "(R3 + 9a)" printed in a table sent to a paying client. The skill's two explicit token bans both point at (b), but the literal template says (a), and a reader following the template literally will ship the ID.

---

## A3 — schema-templates.md asserts the exact claim SKILL.md forbids

**Where**: request 3, and structurally any FAQPage job.

**The conflict, verbatim**:
- schema-templates.md line 23 (FAQPage section): *"still generated because AI engines extract clean Q&A pairs from it (settled ruling R3)"*.
- SKILL.md line 311: *"R3 amendment 9a retracted the former rationale — that the value is AI-engine parsing — as having no primary source either way, so no AI-citation or answer-engine-extraction benefit may be claimed for it."*
- validation-guide.md line 245: same retraction, and *"a deliverable may say the markup is valid and cheap to keep; it may not say it earns AI citations."*

These cannot both be followed. The templates file states as the reason for shipping FAQPage precisely the sentence the other two files spend their longest passages prohibiting.

**Took**: SKILL.md and validation-guide.md. `e3-out.md` gives three reasons for shipping FAQPage — valid schema.org, near-zero cost, Google advises against proactive removal — and then explicitly refuses the AI-citation claim in a paragraph headed "What I am not claiming".

**Why that branch**: two files against one; both of the two state the retraction *as a retraction*, which is the later position; and SKILL.md is the entry point. But note the failure mode this creates. A reader who goes to schema-templates.md for the FAQPage skeleton — the natural move when the task is "generate FAQ schema" — lands on the superseded sentence, and it reads as a positive instruction with a ruling ID behind it. Nothing in that file warns them. This is the single most consequential claim in the skill and its own template file gets it backwards.

---

## A4 — A mandated output element has no reference data for four of the ten supported types

**Where**: request 4 (Event).

**The instruction**: SKILL.md step 2 requires, for each schema generated, *"Notes on which properties are required vs. optional"*. Supported types are listed as ten: FAQPage, HowTo, Article/BlogPosting/NewsArticle, Product, LocalBusiness, Organization, BreadcrumbList, Event, Recipe, SoftwareApplication.

**The gap**: validation-guide.md's "Required vs Recommended Properties" section supplies that data for six — FAQPage, HowTo, Article, Product, LocalBusiness, Organization. Event, Recipe, BreadcrumbList, VideoObject, Course and SoftwareApplication have none. Event's absence is the sharp one: SKILL.md line 161 names Event, in the same breath as LocalBusiness, as *"as common here as Article"*.

**Two readings**:
- (a) Omit the required-vs-optional note when the skill supplies no table — the note is only mandated to the extent the skill can support it.
- (b) Supply it from outside the skill.

**Took**: (b). `e4-out.md` marks `name`, `startDate` and `location` Required and the rest Recommended, sourced from schema.org and Google's Event documentation rather than from anything in this skill. Reading (a) would have dropped a mandated element from the deliverable.

**Why this is worth logging rather than shrugging at**: the whole architecture of the value rule depends on knowing which properties are Required, because "Required but unavailable" is the case that triggers drop-and-name-the-gap prose. For four supported types the skill cannot tell you which those are, so the rule that is otherwise its spine has nothing to stand on.

---

## A5 — The audit path is advertised but has no documented output shape

**Where**: request 5.

**The instruction**: SKILL.md's "How to Use" offers a third invocation — *"Audit Existing Schema → Review and improve this schema markup: [existing schema]"* — and the front-matter description promises the skill handles *"structured data validation errors"*. The Instructions section then describes three steps that are entirely the generate path: identify content type, generate markup, provide implementation and validation.

**What is undefined**: whether an audit returns a defect list at all; if so in what form; whether defects get severities and on what scale; whether the deliverable leads with findings or with corrected markup; whether removed markup is reported as removed or silently absent; whether the "before" is quoted back.

**Took**: I invented a shape — headline finding first (the page's entire script tag fails to parse), then the standard step-1 analysis block, then a numbered defect table with a three-level severity scale I made up (Fatal / Critical / Warning-and-Cleanup), then the corrected block, then the standard step-2 and step-3 elements.

**What the alternative reading produces**: run the audit through steps 1–3 unmodified — analysis, corrected markup, implementation guide — with no defect list. That deliverable would hand back a clean corrected block and never tell the client that a trailing comma is currently voiding their entire structured-data tag, or that the Product object was deleted rather than repaired. Both are the most important things on that page. The skill does not require either to be said.

---

## A6 — The value rule gives no test for "transcoding a stated fact" vs "inventing a value"

**Where**: requests 1 and 4.

**The instruction**: *"every value inside it is a real value taken from the page or from what the user supplied … Never invent a value."*

**The forced case**: `addressCountry` is Required and must be an ISO 3166-1 alpha-2 code. Neither page states a code. Fixture 1 says «Αττική»; fixture 4 says "United Kingdom". Emitting `GR` / `GB` writes a string that appears nowhere on either page; omitting drops a Required property.

Here the skill resolves it — schema-templates.md and validation-guide.md both mandate the alpha-2 code, and validation-guide even pre-empts the wrong answer by naming "UK" as invalid. So transcoding a stated fact into a required code form is clearly licensed.

**Where it stops resolving**: the same question, one property over, with no guidance. Fixture 1 gives the phone as `210 976 5432`. E.164 would be `+30 210 976 5432`. Is prefixing the country code the same licensed transcoding of a stated fact (the address establishes Greece exactly as it establishes `GR`), or is it adding digits the page does not carry?

**Took**: the strict reading. `e1-out.md` emits the page's literal string and offers `+30 210 976 5432` in prose as a swap the client can make — which the missing-data rule explicitly permits, since it allows an illustrative value in prose but never in the block. That client also said *"use exactly the details listed there, nothing else"*, which points the same way.

**What the permissive reading produces**: `"telephone": "+30 210 976 5432"` in the markup, on the same logic that put `GR` there. I cannot show it is wrong. The rule as written has no discriminator between the two cases, and it licensed one of them explicitly while leaving the other to the executor.

---

## A7 — Nothing covers a day the page explicitly states as closed

**Where**: request 1. Fixture 1's hours table ends: `| Κυριακή | Κλειστά |`.

**The gap**: the LocalBusiness template shows `openingHoursSpecification` entries for open days only. Neither the template, the decision tree nor the validation guide says how to represent a day the page affirmatively marks closed.

**Two readings**:
- (a) Omit Sunday. Days absent from the specification are understood as closed.
- (b) Emit a Sunday entry with `opens` and `closes` both `"00:00"` — Google's documented idiom for a closed day.

**Took**: (a). Reading (b) writes two clock times the page never states, and the skill's date-and-time guidance is emphatic and repeated that a time not stated by the page is not to be manufactured. `e1-out.md` names the omission and the alternative explicitly so the client can overrule it.

**The argument for (b), which I think is real**: the page makes a positive statement about Sunday. Under (a) that statement survives in the markup only as an absence, and the content-match rule is about the markup reflecting what the page says. (b) is arguably the better content match; it just costs two invented-looking numbers to get there. The skill does not adjudicate, and the two rules it does state pull in opposite directions here.

---

## A8 — Output language is undefined

**Where**: request 2, which arrived entirely in Greek about a Greek-language page.

**The gap**: nothing in SKILL.md or the three references says what language a deliverable is written in, or whether prose should track the client's language, the page's language, or default to English. The distinction matters: JSON-LD *values* obviously stay in the page's language, but the analysis, the eligibility note, the property table and the implementation guide are all prose, and they are most of the deliverable.

**Took**: matched the client. `e2-out.md` is in Greek throughout with Greek values; the other four are in English. (I also applied the Greek convention that ALL-CAPS Greek carries no accents, which is a general typographic rule rather than anything this skill says.)

**What the alternative produces**: all five in English, with Greek only inside the JSON values. That is a large surface difference for anyone comparing outputs, and it is not a difference the skill has an opinion about.

---

## A9 — No rule for properties whose true value changes after the markup is written

**Where**: requests 2 and 4, both on `offers.availability`.

**The instruction**: the Product skeleton hard-codes `"availability": "https://schema.org/InStock"`, and validation-guide lists availability under what feeds the price snippet. The value rule is written throughout as though every value is a static fact about the page.

**The two cases, which differ**:
- Fixture 2 states «Διαθεσιμότητα: Άμεσα διαθέσιμο». That is a page-sourced availability claim. I emitted `InStock`.
- Fixture 4 states a booking URL and "Maximum 12 places per session", and never says whether places remain. I omitted `availability` and said why: hard-coding `InStock` into static markup means a sold-out workshop keeps advertising availability until a human remembers.

**Took**: emit where stated, omit where inferred — and in `e4-out.md` I went further and recommended against adding it by hand at all.

**Why it is a fork**: the skill's skeleton presents `InStock` as a default rather than as a claim, and offers no category for "value that is true at authoring time and false a week later". A different executor could reasonably emit `InStock` in both (a live booking page implies availability) or omit it in both (no page states current inventory). The same question sits behind `priceValidUntil`, `eventStatus` and `dateModified`, none of which the skill treats as time-varying either — I handled each ad hoc and flagged the maintenance obligation in the deliverable prose, which is my convention, not the skill's.

---

## Checked for and did not find

- **No contradiction between the CORE-EEAT benchmark's Section 5 mapping and SKILL.md's step-1 table.** SKILL.md claims the two "state one boundary, not two". I compared them row by row; they agree, and SKILL.md's added Homepage row is declared as an addition rather than presented as coming from Section 5. The claim holds.
- **No conflict on date precision.** SKILL.md, schema-templates.md and validation-guide.md all state the same rule in the same terms, and validation-guide's "Time and zone forms" paragraph resolves the one case (request 4) where a page states a time but no zone. That is the skill at its best — a fork anticipated and closed before an executor reaches it.
- **No conflict on the missing-data rule.** The three-way split (drop-and-name / bracketed skeleton / never invent) is stated identically in all four files, and the scope carve-out for skeletons in the output-validation checklist is explicit about which of the three it exempts.
