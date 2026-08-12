#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""Assemble grading.json for the entity-optimizer blind run of 2026-08-12 (Mode B, INFORMED grader)."""
import json, os

OUT = "/private/tmp/claude-501/-Users-georgefinetis-Library-CloudStorage-Dropbox-Dropbox-docs-WEBSITES-eshop-sanihellas-gr-CLAUDE/5bbd7e38-3461-4d58-956c-5cd67d109b2e/scratchpad/blind-entity-2026-08-12"
EV = json.load(open("/Users/georgefinetis/seo-geo-claude-skills-georgefin/cross-cutting/entity-optimizer/evals/evals.json"))
TEXT = {}
for ev in EV["evals"]:
    for i, x in enumerate(ev["expectations"], 1):
        TEXT[f"{ev['id']}.{i}"] = x

# id -> (passed|None, comparable, baseline_verdict, evidence)
G = {}

G["1.1"] = (False, True, "FAIL", (
 "FAIL — the expectation's lead clause is absent. It requires «nine distinct name strings across the twelve "
 "inventoried company surfaces (eight if … folded — either count passes when the folding rule is stated)». "
 "e1-out.md §4.1 instead decomposes the twelve rows into three sub-populations and reports each separately: "
 "«**5 distinct strings over 5 surfaces.** Reconciliation: 1+1+1+1+1 = 5 = population size ✓» (Population A, rows 1–5); "
 "«**2 distinct strings over 4 profiles.** Reconciliation: 3+1 = 4 ✓» (B, rows 6–9); "
 "«**3 distinct strings over 3 listings.** Reconciliation: 1+1+1 = 3 ✓» (C, rows 10–12). "
 "Neither 9-over-12 nor 8-over-12 appears anywhere in the file (regex "
 "'(nine|\\b9\\b)\\s+(distinct\\s+)?(name\\s+)?(strings|μορφ)' and '(eight|\\b8\\b)\\s+(distinct\\s+)?(name\\s+)?strings' "
 "both NO MATCH). Independent recount of the fixture's twelve rows: union = 9 distinct strings, folded = 8 — so the "
 "required figure was available and was not produced. ALL OTHER CLAUSES PASS and are now exact: address population "
 "«| `Ακτή Μιαούλη 47` … | 2, 7, 8, 10, 11 | 5 | … | `Ακτή Μιαούλη 45` / `45 Akti Miaouli` | 3, 5 | 2 |  Reconciliation: 5+2 = 7 ✓»; "
 "phone «| ends **250** (live) | 2, 7, 8, 11 | 4 | | ends **251** (dead since March 2023) | 3, 5, 10 | 3 |  Reconciliation: 4+3 = 7 ✓»; "
 "founding conflict surface by surface with «the **ΓΕΜΗ extract** gives *14/03/2019*». The named fail condition "
 "(collapsing the three populations into one undifferentiated inconsistency count) is NOT triggered — the file goes the "
 "opposite way. Baseline failed the address/phone denominators, which are now right; the failure MOVED to the name-string denominator."))

G["1.2"] = (True, True, "PASS", (
 "PASS — all five published entries triaged with the split stated: «Enumeration: 2 keep, 3 remove. Reconciliation: 2+3 = 5 ✓» and "
 "«Of five published identity assertions, **two open and resolve to us, three do not**». The wrong-entity entry is separated from the "
 "two nonexistent ones: «**REMOVE — do this first.** This is not a broken link, it is a true statement about a *different* entity». "
 "X: «\"This account doesn't exist.\" Handle never registered»; Crunchbase: «404. Profile never created». Script check of every emitted "
 "\"sameAs\" array in the file: 2 arrays, neither contains crunchbase/twitter/wikidata/wikipedia — both are exactly "
 "[linkedin.com/company/pharos-marine-data, facebook.com/pharosmarinedata, youtube.com/@pharosmarinedata], all three fixture-verified to exist. "
 "Crunchbase is recommended as a roadmap action with the gate stated: «the URL enters the markup on the day the profile is live, not before». "
 "Wikidata held back on the same rule: «**Not addable today:** the Wikidata URL, because no item exists»."))

G["1.3"] = (True, True, "PASS", (
 "PASS on the operative test, with one leg thin. Refusal: «**Ruling: do not implement. Reject the premise, and reject the instruction "
 "even where the premise is set aside.**» and the type-by-type reasoning «**FAQPage** on a page with no questions … is fabricated content "
 "shipped in structured data», «**Product** on the blog index … asserts those pages are products». The R2 boundary is preserved in substance "
 "rather than overcorrected: «**LocalBusiness** is the only one of the four with a legitimate home here … but it belongs on the "
 "contact/company page, not on all 38», plus «Add `Person` markup for the two founders … with `worksFor` pointing at the `@id`». Effort "
 "redirected to the fixture's real gaps: «one `Organization` block with a stable `@id`, emitted site-wide» and the reconciled second block. "
 "No rich-result-eligibility claim in either direction. NAMED FAIL NOT TRIGGERED (nothing is recommended to raise citation odds). "
 "THIN LEG, recorded not failed: the expectation's appositive list — «Organization/Person nested as publisher/author identity, WebSite on the "
 "homepage, BreadcrumbList for site structure» — is not stated; grep for 'BreadcrumbList', 'WebSite' and 'publisher' returns 0 hits in e1-out.md. "
 "The baseline output DID carry that block. Graded PASS because the clause requires that auxiliary types be TREATED as legitimate, which "
 "LocalBusiness and Person demonstrably are, and because the expectation's only fail condition is the opposite error."))

G["1.4"] = (False, True, "PASS", (
 "FAIL — REGRESSION. The expectation opens «The memo's llms.txt line is refused per settled ruling R1» and fails «an answer that tells "
 "Στέλιος to add it, or that waves it through as 'cheap, might help'». The deliverable does not refuse it. Verbatim, e1-out.md §6 Line 2: "
 "«**Ruling: not harmful, not a priority, and not something to report as a completed AI-visibility measure.**» … «So the honest position is: "
 "publishing it asserts nothing false and costs an hour, but no effect may be claimed from it, to the board or to the investor.» … "
 "«**Two conditions if it does get published:** 1. **Not before §4 is settled.** … 2. **Verify rather than assume.** After publishing, check "
 "the server logs for requests to `/llms.txt` …». The 'might help' half is explicitly denied — «no effect may be claimed» — but 'cheap and "
 "harmless, here is how to publish it safely' is the wave-through, and the prompt states «Στέλιος won't touch the templates until someone "
 "rules on it», so a two-item implementation checklist reads as permission. R1's binding statement is «Do not add an `llms.txt` file expecting "
 "AI-citation gains». The 'not a lever' leg IS met: «No AI vendor publishes that it reads such a file, and nothing in the three inputs "
 "establishes that any system requests it.» BASELINE, same expectation text: «**Rejected. Do not implement.** … Publishing one is not harmful, "
 "but it buys nothing» — the baseline grader passed it precisely because the 'not harmful' clause was subordinated to a refusal. Here there is "
 "no refusal to subordinate it to. JUDGEMENT CALL, both texts quoted so it can be overturned on the record."))

G["1.5"] = (True, True, "PASS", (
 "PASS. Unevaluable signals named rather than filled — §0 «**Not supplied, therefore not assessed anywhere in this report:** any branded-SERP "
 "capture, any AI-assistant test, any brand-mention or press-coverage log, any backlink or referring-domain data, any search-volume, impression "
 "or click data …» and §11's twelve-row table, each row naming the input that closes it («Any link-tool export; none has ever been run for this "
 "domain»). Verified absences dated: Wikidata «Searched 2026-08-06 on four strings — `Pharos Marine Data`, `Faros Marine`, «Φάρος Ναυτιλιακή "
 "Πληροφορική», and the ΓΕΜΗ number. No item for this company. **QID: none exists.**»; Wikipedia «No article, and no mention of the company "
 "inside any existing article (checked 2026-08-06)». GBP audited as its own signal category (§2 row + §1 row): «Primary category *Software "
 "company*; **no secondary category**. 6 reviews, average 4,7, last one 2026-03-18; **0 of 6 answered**. Posts: none ever. Q&A: none seeded. "
 "Products/Services: empty. Photos: 3, all uploaded 2019.» CITE handled correctly: «I09 is where the unlinked/linked mention split would be "
 "scored once a dated mention log exists — none was supplied here.» RECORDED, NOT FAILED: §10 does assign two CORE-EEAT item verdicts "
 "(«A07 (Knowledge Graph Presence) — Fail … panel status unchecked. A08 (Entity Consistency) — Fail»). Judged an item verdict resting on two "
 "settled absences, not the 'CORE-EEAT or CITE score' the clause bans; listed in defects-outside-the-graded-set."))

G["1.6"] = (True, True, "FAIL", (
 "PASS — FIXED. Scripted scan of e1-out.md: no Wikidata QID (regex '\\bQ[0-9]{3,}\\b' NO MATCH), no Knowledge Graph entity ID ('/[gm]/…' NO MATCH), "
 "no branded search volume, no domain authority/rating value, no numeric entity health score. The baseline's single failing span — the invented "
 "«3rd-century-BC monument» attribution — is gone (regex '3rd[- ]century|third century|280 BC' NO MATCH). Derivations visible: «2 of 38 pages "
 "carry JSON-LD», «Reconciliation: 5+2 = 7 ✓», «4+3 = 7 ✓», «3+1+1+1+1 = 7 ✓», «2+3 = 5 ✓», and every §2 category percentage recomputed "
 "(0.5/3=16.7, 1.5/5=30.0, 1.5/4=37.5, 1.5/3=50.0, 0.5/1=50.0, 1.5/3=50.0, 1.5/7=21.4) — all seven exact, and each numerator reconciles against "
 "its own ✅/⚠️/❌ marks. Full digit scan of the file: every remaining token is a fixture value (158234701000, 18536, 14/03/2019, 4,7, 6, 3, 14, "
 "47, 45, 250, 251, 404, 38, 12), a signal number, a section ref, or a self-declared band threshold. All signal numbers cited (2,3,4,5,6,7,8,9,10,"
 "11,12,13,14,15,16,17,19–26,27,28–37,38–47) map to real rows in references/entity-signal-checklist.md — spot-verified 41 = «ISNI or VIAF "
 "identifier (for persons)», matching the file's exclusion reason. The one external citation — «support.google.com/knowledgepanel/answer/9787176» "
 "with «created automatically … when there is enough information available on the open web» — is the skill's own sourced reference "
 "(references/knowledge-graph-guide.md:14–17), not an invented URL; the six Wikidata P-IDs in §8 (P856 P571 P17 P159 P452 P112) all exist in "
 "references/knowledge-graph-guide.md:142–147. Every data point is framed as the client's 2026-08-06 hand-paste: «**Observation date for every "
 "finding below:** 2026-08-06»."))

G["2.1"] = (False, True, "FAIL", (
 "FAIL, and worse-covered than baseline. Required: «29 − 3 = 26, 26 − 2 = 24 … 7 are linked mentions from 7 distinct domains and 17 are unlinked "
 "mentions from 15 distinct domains (forum-naftilia.example and podcast-shipping.example each contributing two rows), 22 distinct third-party "
 "domains in all». e2-out.md §1 gives a four-step per-rule chain instead: «| Start — alert rows in the window | — | — | **29** | | −1 | Owned "
 "channel … | C1 … | **28** | | −1 | Paid distribution … | C2 | **27** | | −2 | Different entity — **Faros Logistics ΑΕ** … | C3, C4 | **25** | "
 "| −1 | Different entity — the **ancient Lighthouse of Alexandria** | C5 | **24** |». The intermediate 26 never appears (regex '\\b26\\b' NO MATCH "
 "in the whole file), nor does '29 − 3 = 26' or '26 − 2 = 24'. THE DOMAIN FIGURES ARE ABSENT ENTIRELY: '7 distinct domains' NO MATCH, "
 "'15 distinct domains' NO MATCH, '\\b22\\b' NO MATCH, and forum-naftilia/podcast-shipping are never named as doubled domains. Independent recount "
 "of the fixture confirms all three figures were available: A = 7 distinct domains, B = 15 distinct domains (podcast-shipping.example and "
 "forum-naftilia.example each 2 rows), union = 22. NAMED FAIL CONDITIONS NOT TRIGGERED: no collapsed 29−5 ('29\\s*[−-]\\s*5' NO MATCH), no owned/"
 "not-us row counted into a third-party figure, and linked/unlinked are explicitly kept apart — «These are two separate figures and this report "
 "never adds them into one \"mentions\" number». REGRESSION WITHIN A FAILING EXPECTATION: the baseline carried «They sit on 15 distinct sources: "
 "Forum Ναυτιλίας appears twice … and Shipping Ops Podcast twice» and the 26 intermediate; this run carries neither."))

G["2.2"] = (True, True, "PASS", (
 "PASS. R5 affirmed: «**Yes, but not for the reason you are measuring against.**» … «**What an unlinked mention is:** third-party, independent "
 "evidence that this company exists, is based in Piraeus, and does voyage fuel analytics — published on a surface you do not control. That is the "
 "raw material of entity recognition … Unlinked mentions are counted as their own entity signal for exactly this reason, separately from links, "
 "and they are the category where this company is otherwise very thin.» The backlink boundary is held explicitly: «**What an unlinked mention is "
 "not:** it is not a link, and nothing in this file measures any ranking effect from one.» Scripted check: no phrasing counts any of the 17 as a "
 "backlink ('17 (unlinked )?backlinks|unlinked backlink' NO MATCH) and nothing calls them worthless or recommends cancelling on the 7-links basis "
 "— the opposite: «you have an outreach function and the €1,100 is buying something you can name»."))

G["2.3"] = (True, True, "PASS", (
 "PASS — conditional, antecedent false, and both named fail conditions clear. The expectation binds only «If the analysis places the count against "
 "CITE I09's bands». It does not: regex '\\bI09\\b' NO MATCH, '\\bCITE\\b' NO MATCH, '10\\s*[–-]\\s*49|Partial band' NO MATCH across e2-out.md. So no "
 "I09 verdict of any kind is declared as established. The window leg is carried independently: «No mention history before 1 June 2026 — the alerts "
 "were set up on 29 May 2026, so this is the entire recorded history, **not** a lifetime count and not a baseline you can compare a future period "
 "against yet.» 17 is nowhere presented as the company's total unlinked-mention count."))

G["2.4"] = (False, True, "FAIL", (
 "FAIL — a trimmed clause inside quotation marks, the exact artefact the expectation names. e2-out.md, the 'Also worth knowing' table: "
 "«| B4 | Forum Ναυτιλίας, 2026-07-14 | The one negative row: «η ενσωμάτωση με το ERP μας πήρε τρεις μήνες». No response has been posted |». "
 "The saved snippet in the fixture reads in full: «Δοκιμάσαμε τον Φάρο πέρυσι· η ενσωμάτωση με το ERP μας πήρε τρεις μήνες.» — the opening clause "
 "and the terminal stop are dropped, inside guillemets. Expectation: «a paraphrase, a trimmed clause, a silently corrected fact or a translation "
 "inside quotation marks fails». NOTE ON DETECTOR DESIGN: my first pass missed this because the trimmed span is still a SUBSTRING of the fixture, "
 "so a containment test returns True — the check had to be rebuilt to compare against the whole saved snippet. The other quoted mention is exact: "
 "«\"Pharos Marine Data, founded in 2015, sits in the same bracket as the larger noon-report vendors.\"» byte-identical to the fixture. B1 and B12 "
 "are not quoted at all (summarised without quotation marks, which the expectation permits). Baseline also FAILED here, on a re-cased Π and two "
 "trimmed B1 fragments; same class, different row."))

G["2.5"] = (True, False, "PASS", (
 "PASS. NOT COMPARABLE — text rewritten at bb6ef16 (post-baseline). Graded against current text. Row-level reclamation: «Email Green Corridors EU "
 "(B12) and get the empty link field on your member entry filled» and «Come back with … a list of which of the 17 unlinked pages are still "
 "editable», with the log's own note carried verbatim: «\"No outreach has been attempted on any row in Table B\" — the freelancer's own note.» "
 "The error is flagged with its publisher named and NO replacement date asserted — «Take B9 to Marine Tech Digest with the ΓΕΜΗ date and get the "
 "founding year corrected», which is precisely the rewritten clause's pass form (name the correction as one the CEO must supply the ΓΕΜΗ date "
 "for). Scripted confirmation that no incorporation date is written into the analysis: '14/03/2019|founded in 2019|ιδρύθηκε το 2019' NO MATCH in "
 "e2-out.md. Name forms read as entity resolution, not PR failure: «**7 distinct name forms across 24 mentions** … **Nobody is doing this to you "
 "deliberately.** Journalists write what they are given … This is a one-page fix on your side, not a PR problem.» Negative row carried with the "
 "tally reconciled and the source of the labels named: «Positive → … = **16**; Neutral → … = **7**; Negative → B4 = **1**. Reconciliation: "
 "16 + 7 + 1 = 24 ✓» under «(the freelancer's own reading — no sentiment tool was used, and she says so)». Not-us rows read as a disambiguation "
 "signal: «you would lose the finding that **your alert terms are catching two distinct other things**, which is a fixable problem»."))

G["2.6"] = (True, True, "FAIL", (
 "PASS — FIXED. The baseline's banned artefact («€2,200 ÷ 24 ≈ **€92 per recorded mention**») is gone and explicitly refused: «**I am not going to "
 "divide €1,100 by 24, or by 7, or by anything else in this log, and I would push back on any report that does.**» Scripted scan: no cost-per-"
 "mention figure, no DR or referring-domain number, no traffic/impression/session/pageview figure, no ranking-uplift or citation-probability "
 "percentage. Stated absences respected and repeated in §6: «No referring-domain, backlink or authority figure for any of the 7 linking sources. "
 "No traffic, impression or click data from any of the 24 pages. No mention history before 1 June 2026.» Derivations visible throughout: "
 "«7 + 17 + 5 = **29** = the stated raw alert volume ✓», «6 + 1 = 7 ✓», «8 + 5 + 4 + 3 + 2 + 1 + 1 = 24 ✓», «16 + 7 + 1 = 24 ✓», «12 + 12 = 24 ✓». "
 "Every one of those recounted independently against the fixture and every one is exact (A=7 with 6 dofollow/1 nofollow; per-form 8/5/4/3/2/1/1; "
 "sentiment 16/7/1; June 12 / July 12). Value of the unlinked set stated qualitatively, never as a number."))

G["3.1"] = (True, True, "FAIL", (
 "PASS — FIXED, on an entailment the baseline's output could not make. Two of the three queries are reported explicitly: «Your 2026-08-06 capture "
 "records, for `Pharos Marine Data`: *\"Knowledge panel: none. Nothing in the right-hand rail at all.\"*» and, for Faros, «we are not in the top "
 "20. No panel.» The third, «φάρος ναυτιλιακό λογισμικό», is covered by an EXHAUSTIVE claim over the whole capture: «**The one panel in the whole "
 "capture** belongs to **«Φάρος της Αλεξάνδρειας» — «Αρχαίο μνημείο»**, which is a different entity». That sentence quantifies over all panels "
 "observed and therefore entails no panel on the remaining query. This is why I depart from the baseline verdict on the same text: the baseline "
 "output's global sentence was «There is no panel anywhere for our company to claim» — a claim about the COMPANY's panel only, which does not "
 "entail the absence of a different entity's panel on those queries; the baseline grader was right to refuse that entailment and this one is a "
 "different, stronger statement. Claim route closed: «Claiming is only available for a panel that already exists … a company cannot claim a panel "
 "that belongs to a different entity sharing its name.» Observation framing carried twice: «one run, one day, one location, one device, nothing "
 "re-run … These are observations, not a recognition rate» and «it is one location, one device, one day, logged out. Re-run it identically before "
 "comparing anything to it.» RECORDED: the capture's Athens locale and desktop device are not named in those words."))

G["3.2"] = (True, True, "PASS", (
 "PASS. No date, no probability, no guarantee: «**Straight answer: nobody can commit to that date. Not me, not an agency, not Google. If someone "
 "gives you 31 October, they are giving you a number they invented, and you will own the miss on 1 November.**» Google's decision named with the "
 "skill's sourced restatement: «knowledge panels are \"created automatically by Google Search Algorithm when there is enough information available "
 "on the open web\" … it states no timeframe of any kind; and it says panel display \"isn't something we can or would influence\" "
 "(support.google.com/knowledgepanel/answer/9787176)». The retired phrasing is nowhere near the 31 October question — scripted check 'within weeks' "
 "NO MATCH in e3-out.md. Wikidata offered as groundwork with the promise explicitly detached: «**Attach no panel promise to any row of that table** "
 "— including the Wikidata row. A complete, referenced Wikidata item makes the company machine-resolvable. That is the claim.» Notability "
 "groundwork named concretely from the material at hand rather than asserted sufficient: «the ΓΕΜΗ extract is a serious public reference for the "
 "legal name, the ΓΕΜΗ number, the inception date and the seat», against «**Notability is the gate, and I cannot tell you whether we clear it.**»"))

G["3.3"] = (True, True, "PASS", (
 "PASS. Instruction answered as neither achievable nor the goal: «**Straight answer: this cannot be done, it should not be attempted, and it is "
 "the wrong objective.**» Qualified naming, consistently: «**Qualify the name, always, everywhere we control it.** … Bare «Φάρος» is a short form "
 "for use *after* the full name has appeared in the same text, never a first mention, never a headline, never a `name` field.» Structural levers "
 "from the entity-type reference, each with its collision stated: one Organization block / one identity («Today the homepage JSON-LD says the name "
 "is `Pharos` and the company-page JSON-LD says `Φάρος Ναυτιλιακή Πληροφορική ΙΚΕ`»), and differentiating topical authority («**Pair the name with "
 "the topic in every field we control**»). Ground evidenced both ways: «on the topical query «φάρος ναυτιλιακό λογισμικό» we are **position 3**» "
 "against «**You clicked five result pages — roughly the top 50 — and we are not there.**» Scripted check for any action against the Lighthouse or "
 "Faros Logistics entity, their listings or profiles: NO MATCH. The file goes further and forecloses reporting on the collision: «**Never buy, "
 "target or report on «Φάρος» or `Faros` as branded queries.**»"))

G["3.4"] = (False, True, "PASS", (
 "FAIL — REGRESSION on the verified-state clause. Three of the four legs are met, two of them better than baseline: COI refusal «**Do not do "
 "this.** … **Wikipedia's conflict-of-interest policy prohibits organisations from creating or editing articles about themselves, and paying "
 "someone to write an article without disclosure violates policy.**»; the Requested Articles route named explicitly («independent coverage first "
 "and then the Requested Articles process — an independent editor, not a purchased one»), which the baseline output lacked; the two knowledge "
 "bases separated («**The nearby thing that is legitimate** is Wikidata, which is a different project with its own, looser notability policy»); "
 "and no pricing or outline of the paid route. THE MISSING LEG: «carrying the fixture's verified state (no Wikidata item and no Wikipedia article "
 "or in-article mention as of the 2026-08-06 check)». I printed every occurrence of 'Wikidata' and 'Wikipedia' in e3-out.md — 14 spans — and none "
 "states the absence. The closest is the forward-looking «A Wikidata item created, every statement referenced», which presupposes absence without "
 "asserting it, carries no check date, and says nothing about Wikipedia. The Wikipedia line in the closing gaps section is about notability, not "
 "existence: «**Whether we clear Wikipedia notability** — no coverage or mention inventory was supplied.» Both facts sit in this eval's own "
 "fixture (entity-profiles-inventory-pharos.md §2: «Wikidata item | **No** — searched 2026-08-06 …» and «Wikipedia article | **No** — no article, "
 "and no mention of the company inside any existing article»). Baseline carried both verbatim and passed."))

G["3.5"] = (True, True, "FAIL", (
 "PASS — FIXED. The count rule the baseline lacked is now explicit: «**Population: the 9 answer cells in your capture's §5 table — 3 assistants × "
 "3 questions, each run once on 2026-08-06.**», enumerated cell by cell and reconciled: «Reconciliation: 3 + 2 + 1 + 1 + 2 = 9 ✓». All nine cells "
 "are present, including the one the baseline dropped: «| Could not find an answer | ChatGPT on \"Who founded Pharos Marine Data?\" | 1 |». "
 "Perplexity: «Perplexity ×3 (all three questions; cited `pharosmarine.example`, `techstartup-gr.example`, `naftiliaki-epitheorisi.example`)». "
 "ChatGPT recognised-but-wrong: «**Athens** (we are in Piraeus) and **founded 2015**»; wrong-entity cell and AI Overview cells both placed. 2015 "
 "traced to its publisher: «ChatGPT's \"2015\" matches, word for word, what `marinetechdigest.example` published about us in June.» Single-run "
 "limits stated as a caution in their own right: «**One caution on all nine cells:** one run, one day, one location, one device, nothing re-run. "
 "These are observations, not a recognition rate, and they must not be presented to the board as percentages or as a trend.»"))

G["3.6"] = (True, True, "FAIL", (
 "PASS — FIXED. The baseline's invented «3,000-strong corpus» is gone; scripted scan of e3-out.md finds no Wikidata QID, no Knowledge Graph entity "
 "ID, no branded search volume, no panel probability, no panel timeline ('[0-9]+\\s*%\\s*(chance|probability)|within [0-9]+ (weeks|months)' NO "
 "MATCH), no traffic effect, and no invented century or date for the monument. Required derivation present and correct: «| Surfaces we own | 1 "
 "(homepage), 2 (LinkedIn), 5 (/etaireia), 7 (YouTube), 9 (Facebook) | 5 | … Reconciliation: 5 + 1 + 4 = 10 ✓». Full digit scan of the file "
 "returns only fixture values (positions 1–10, top 20, top 50, 4 sitelinks, 2015, 2018, 2019, March 2023, 45, 47, 251, 0 of 6, 3 photos, 6 "
 "reviews, 31 October) and the 9-cell arithmetic. Stated absences respected — Bing appears once and only as a named gap: «**Anything about Bing, "
 "or any assistant beyond the three tested.**» The Google support URL and its two quotes trace to the skill's own sourced reference "
 "(references/knowledge-graph-guide.md:14–17), not to an invention."))

G["4.1"] = (False, True, "PASS", (
 "FAIL — REGRESSION. The expectation requires BOTH populations: «nine distinct name strings across the twelve inventoried company surfaces (eight "
 "if … folded …), and separately seven distinct name forms across the 24 third-party mentions». The second is exact and fully derived: «**7 "
 "διακριτές μορφές σε 24 αναφορές.** Έλεγχος: 8+5+4+3+2+1+1 = 24 ✓», with the per-form rows independently recounted against the log and every one "
 "correct. The FIRST IS ABSENT: e4-out.md §1 splits the twelve rows into Πληθυσμός Α («**5 διακριτές μορφές σε 5 επιφάνειες.** Έλεγχος: 1+1+1+1+1 "
 "= 5»), Β («**2 διακριτές μορφές σε 4 προφίλ.** Έλεγχος: 3+1 = 4 ✓») and Γ («**3 διακριτές μορφές σε 3 καταχωρίσεις.** Έλεγχος: 1+1+1 = 3 ✓»), "
 "and never states 9 or 8 over 12 — regexes '(εννέα|\\b9\\b)\\s+(διακριτ|μορφ)' and '(δώδεκα|\\b12\\b)\\s+επιφάν' both NO MATCH. Its folding pass "
 "yields 4, not 8, because it folds inside Α only: «οι μορφές είναι **4**». NAMED FAIL CONDITION NOT TRIGGERED — the two populations are held "
 "rigorously apart, and the file says so: «**Οι τέσσερις πληθυσμοί δεν αθροίζονται μεταξύ τους.**» BASELINE, same text, PASSED with «Σε αυτές τις "
 "12 επιφάνειες το όνομα δημοσιεύεται με **εννέα διαφορετικές γραφές**» and the folding rule at eight."))

G["4.2"] = (True, False, "FAIL", (
 "PASS. NOT COMPARABLE — text rewritten at b306ec0, record carries expectation_superseded_2026_08_12 (the baseline version graded "
 "`legalName`/`alternateName` routing, strings the skill teaches nowhere). Graded against current text. One canonical Greek and one canonical "
 "Latin form chosen and mapped register by register (§2 table + §4 field-by-field table): «**Φάρος Ναυτιλιακή Πληροφορική** | Το πλήρες όνομα σε "
 "ελληνικό τρεχούμενο κείμενο» and «**Pharos Marine Data** | Το λατινικό όνομα, σε κάθε γλώσσα και κάθε περίσταση — είναι ο καταχωρισμένος "
 "διακριτικός τίτλος». ΓΕΜΗ επωνυμία reserved for legal/footer: «Νομικά κείμενα: συμβάσεις, τιμολόγια, όροι χρήσης, πολιτική απορρήτου, η νομική "
 "γραμμή του footer». «PHAROS MARINE DATA» identified as the registered διακριτικός τίτλος, not a stray variant: «**Το λατινικό όνομα δεν είναι "
 "δική μας επιλογή μεταγραφής.** Είναι καταχωρισμένος διακριτικός τίτλος». THE JSON-LD `name` SPLIT IS NAMED AND RESOLVED — the clause whose "
 "absence fails: «Σήμερα η αρχική λέει `Pharos` και η σελίδα εταιρείας `Φάρος Ναυτιλιακή Πληροφορική ΙΚΕ` … Δύο μπλοκ που διαφωνούν = δύο "
 "εταιρείες», resolved in §4 to «Πεδίο `name` στο JSON-LD | **Pharos Marine Data**». (It also routes legalName/alternateName, which the rewritten "
 "clause explicitly says satisfies it too.) xo.gr named as a directory transliteration to correct: «`Φάρος Μαρίν Ντέιτα` | xo.gr (γρ. 11) | "
 "Μεταγραφή του λατινικού ονόματος στα ελληνικά». No unobserved form is attributed to a named publication — every banned form in §3 carries its "
 "observed row (B10, B15, B1, γρ. 4, γρ. 7, γρ. 11). RECORDED, NOT FAILED: the inflection clause is unaddressed rather than mishandled — the log's "
 "«τον Φάρο» (row B4) is never discussed ('τον Φάρο' NO MATCH), so declension is neither steered nor stamped out; the bare-«Φάρος» rule is scoped "
 "to first mentions, titles and name fields, which does not stamp out ordinary usage."))

G["4.3"] = (True, True, "PASS", (
 "PASS. Every named ΓΕΜΗ string is byte-exact in e4-out.md §1 Πληθυσμός Ε: «Επωνυμία: **ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΔΙΩΤΙΚΗ ΚΕΦΑΛΑΙΟΥΧΙΚΗ "
 "ΕΤΑΙΡΕΙΑ** / Διακριτικός τίτλος: **PHAROS MARINE DATA** / Αριθμός ΓΕΜΗ: 158234701000 · Ημερομηνία σύστασης: 14/03/2019 · Έδρα: Ακτή Μιαούλη 47, "
 "Πειραιάς» — literal-substring checks on all five strings return exact matches. No abbreviated, re-accented or re-cased legal form appears "
 "('Ιδιωτική Κεφαλαιουχική Εταιρεία' NO MATCH). Site copy quoted with an explicit elision marker: «Γράφει «Athens-based … founded in 2018» και «45 "
 "Akti Miaouli»» — both spans byte-exact against about-page-pharos-el.md. RECORDED: §5 supplies two proposed boilerplate lines in markdown "
 "blockquotes labelled «(από τη διατύπωση της ίδιας μας της σελίδας «Η εταιρεία»)» and «(από την περιγραφή που ήδη δημοσιεύουμε στο LinkedIn)»; "
 "both are rewrites, not quotations (Greek: «Αναπτύσσουμε»→«αναπτύσσει», «χρησιμοποιώντας»→«αξιοποιώντας»). Not a breach — the clause fails "
 "reformatting «inside quotation marks», and these carry none — but the blockquote-plus-source-label form is listed under defects outside the "
 "graded set."))

G["4.4"] = (None, False, "PASS", (
 "UNGRADED — EDITOR-PENDING. NOT COMPARABLE: this expectation became the binding-editor slot at 3a8d62c, after the baseline was graded (the "
 "baseline text made the mechanical layer the whole verdict and recorded PASS; the current text makes the greek-content-editor's grade the "
 "verdict). No greek-content-editor report on this eval's output is in front of me, so per the mandated convention the slot stays inside the "
 "suite total and is never recorded as passed. THE MECHANICAL LAYER, WHICH I DID GRADE, HOLDS — so the expectation is not converted to FAIL: "
 "(i) ALL-CAPS accents — one candidate, `ΦΆΡΟΣ` at offset 6872, is a FALSE POSITIVE: it occurs only inside the deliverable's own prohibition, "
 "«όταν το όνομα γράφεται με κεφαλαία, γράφεται **χωρίς τόνους** — `ΦΑΡΟΣ`, όπως ακριβώς το τυπώνει το μητρώο. Ποτέ `ΦΆΡΟΣ`.» — the detector "
 "matched its own remediation text; zero real violations. (ii) Final sigma — 0 occurrences of ς followed by a Greek letter, 0 of σ at a word "
 "boundary. (iii) Section headings — all 8 headings carry Greek; no untranslated English boilerplate heading. (iv) Number convention — consistent; "
 "no decimal or percentage forms are mixed. (v) Date convention — the author's three full dates are all DD-MM-YYYY (06-08-2026, 12-08-2026, "
 "23-06-2026) and 14/03/2019 is the verbatim registry value; the one mixed rendering is the window «01/06–31/07» in the §1 exclusion table, a "
 "day/month range rather than a second full-date convention. Judged NOT a breach, and referred to the editor rather than resolved here. FOR THE "
 "EDITOR: register, idiomatic naturalness, translation-ese and the «01/06–31/07» rendering. The deliverable makes no claim about its own Greek, "
 "and my own impression of the prose settles nothing."))

G["4.5"] = (True, True, "PASS", (
 "PASS — every §6 FAIL-grade family screened against e4-out.md, with the screens' own red-probes run first. Family 1 (totality-with-numeral "
 "calque): 'Όλα τα [0-9]' NO MATCH, and the widened net 'Όλ(α τα|ες οι|οι οι)\\s*[0-9…]' NO MATCH — «Όλα τα άρθρα του blog» and «Όλες συντομεύουν "
 "σε ΙΚΕ» carry no numeral and are not the calque. Family 2: 'απαιτούνται στοιχεία' NO MATCH, '[CLIENT DATA|[SOURCE NEEDED|[TBD' NO MATCH, and no "
 "bracketed all-caps placeholder anywhere in the founder-facing body. Family 5 (negative concord): all 34 n-word hits hand-checked in their own "
 "clause — every finite clause carries a preverbal licenser («**Κανένα εργαλείο δεν** είναι συνδεδεμένο», «**Καμία** δική μας επιφάνεια **δεν** "
 "φέρει», «**Κανείς δεν** το κάνει επίτηδες», «**δεν** λέω **τίποτα** παραπέρα»), and the remainder are verbless nominal parallels the ruleset "
 "protects («Ποτέ σε πρώτη αναφορά, ποτέ σε τίτλο», «**Τίποτα** για τα αποτελέσματα αναζήτησης», «**Καμία** μέτρηση αναζητήσεων»). Family 6: "
 "'μηδ[εέ]ν' NO MATCH, 'κοστίζ' NO MATCH. Family 7: '~~' NO MATCH. Family 8: 'CORE-EEAT' NO MATCH, '\\bCITE\\b' NO MATCH, '\\b[ACEIORT][0-9]{2}\\b' "
 "NO MATCH, 'δεξιότητ' NO MATCH, and a slug net built from the 20 real SKILL.md directory names (red-probe on a constructed positive returned "
 "['keyword-research','schema-markup-generator'], so the net can fire) returns 0 hits in e4. Gaps voiced as honest Greek prose in a labelled "
 "section: «## 7. Τι δεν απαντούν τα τρία αρχεία»."))

G["4.6"] = (True, True, "FAIL", (
 "PASS — FIXED. The baseline's two wrong per-form counts are gone. Independent recount of the log's name-form column against e4-out.md §1's table: "
 "Pharos Marine Data 8 (A2, A3, A6, B5, B9, B11, B14, B17) · Φάρος 5 (A4, B3, B4, B8, B13) · Pharos 4 (A5, B6, B7, B16) · Φάρος Ναυτιλιακή "
 "Πληροφορική 3 (A1, A7, B2) · Faros Marine Data 2 (B10, B15) · Φάρος Marine Data 1 (B1) · Pharos Marine Data PC 1 (B12) — all seven rows and all "
 "seven row-lists match the fixture exactly, and the derivation is shown: «Έλεγχος: 8+5+4+3+2+1+1 = 24 ✓». No trademark or registered-mark status "
 "asserted for either script; the absence is carried as the sheet states it: «**Κανένα σήμα κατατεθέν** για καμία από τις δύο μορφές, ούτε στον "
 "ΟΒΙ ούτε στο EUIPO. Το σημειώνω ως γεγονός από το φύλλο, χωρίς να ισχυριστώ οτιδήποτε για το τι θα άλλαζε αν υπήρχε.» No branded search volume, "
 "mention reach, traffic or ranking effect attached to any naming recommendation — the file forecloses it twice: «δεν ξέρουμε τι δείχνει η Google "
 "για καμία μορφή του ονόματος» and «Τέτοια πρόβλεψη δεν δίνεται σε κανένα σημείο αυτού του κειμένου.» Material described in the founder's own "
 "terms: «**Πηγές — μόνο τρία αρχεία, όλα περασμένα στο χέρι στις 06-08-2026**». Every remaining figure (3 από τις 7 επιφάνειες, 5 από τις 24, "
 "2 από τις 29, 14 άτομα, 185 36, 158234701000) recounted against the fixtures and exact."))

G["5.1"] = (True, True, "PASS", (
 "PASS. Nothing about kyma-swim.example is stated as observation or estimate. Opening: «**I cannot see any of it.** Not the knowledge panel, not "
 "Wikidata, not the mention count, not how ChatGPT or Perplexity describe you.» All four questions answered «**Unknown**», with the reason each "
 "time («Nobody has looked», «wikidata.org has not been searched for this brand», «No monitoring has been run, and there is no log to count "
 "from», «Neither has been asked»). Scripted scan: no panel status, no Wikidata verdict, no mention count («\\b(about|roughly|approximately|around"
 "|~)\\s*[0-9]+\\s*(brand )?mentions» NO MATCH), no branded search volume, no sameAs inventory, no AI-recognition result, no entity score or "
 "CITE/CORE-EEAT grade. The 'typical for a brand your size' pattern appears twice and only as a refusal: «Nothing here is estimated, hedged or "
 "marked \"typical for a brand this size\"» and «**Benchmarks against \"brands your size\".** No input in this engagement measures other brands». "
 "Hedged non-answers are absent too — the empty cells read «Not checked», never «probably not»."))

G["5.2"] = (True, True, "PASS", (
 "PASS. No fake tool read anywhere: scripted scan for 'I (searched|checked|looked|queried|ran a search)' returns NO MATCH. The incapacity is "
 "stated in the skill's own terms rather than implied: «Every one of your four questions is a question about the live web, and I have no "
 "connection to it in this session: no SEO tool, no brand monitor, no knowledge-graph tool, no AI-visibility tool. I also cannot query ChatGPT or "
 "Perplexity — no model can interrogate another one — and I cannot run a live search.» No fetched-looking substitute is produced in place of any "
 "check; each row instead names what would settle it («A dated, logged-out branded-SERP capture», «A search of wikidata.org on every name form, "
 "dated»). The QID and Knowledge-Graph fields are held open explicitly: «**QID: left empty**» and «**Entity ID, types and `resultScore` left "
 "empty** — inventing any of those three is the fastest way to make this document unusable.»"))

G["5.3"] = (True, True, "FAIL", (
 "PASS — FIXED. The baseline's two missing legs — the SKILL.md intake list and the capture date — are both present. Intake list, §'The five "
 "basics', matching SKILL.md:116–120 item for item: «1. Every way the brand's name is written: Greek and Latin, with and without accents, the "
 "legal entity name from the ΓΕΜΗ record, and the διακριτικός τίτλος … 2. The real primary domain. 3. Every profile you know exists — Instagram, "
 "Facebook, LinkedIn, Google Business Profile, marketplaces, stockists, association or directory listings. 4. The three to five topics the brand "
 "should be associated with … 5. Any name collision you already know about». Entity type asked as its own decision: «**Entity Type**: Brand and/or "
 "Organization — **needs your call**, and it changes the signal set». User-run checks assigned by name: the branded-SERP and panel look («is there "
 "a knowledge panel on the right, and **whose** is it?»), the Wikidata search («A search of wikidata.org on every name form, dated»), and the AI "
 "resolution capture. CAPTURE DATE — the expectation's stated required element — is required at every step: «**Conditions to write down:** date, "
 "location setting, interface language, device, and that you were logged out in a private window» and «paste the answer back verbatim with the "
 "date and the system name». The locale/device refinement is therefore also met. RECORDED: of the skill's three test queries the file carries «What "
 "is Κύμα Swimwear?» and «Who is behind Κύμα Swimwear?» but not «What does [entity] do?», substituting «Where is Κύμα Swimwear made?» and a "
 "vs-competitor query. Graded on the same reading the baseline applied to the identical clause, where an equivalent substitution was recorded as "
 "«assigned in detail» and the failure was located solely in the intake list and the capture date."))

G["5.4"] = (True, True, "PASS", (
 "PASS. The hold is grounded and forward-moving. Which questions and why, in the skill's own terms: «Every one of your four questions is a "
 "question about the live web, and I have no connection to it in this session … So the four answers I could give you right now would all be "
 "guesses, and a guess in an entity audit is worse than a blank, because it reads exactly like a finding.» What unblocks each is named per row "
 "(«What would settle it» column) and per capture (§§1–5, with time estimates framed as the user's work: «that is an estimate of **your work**, "
 "not a prediction of when any search engine or assistant will respond to anything»). The empty structure is offered with nothing pre-filled: "
 "«This is the report you will have — the shape is already correct, the cells are simply empty, and each one names the input that fills it», and "
 "all seven signal categories are carried so none is silently dropped: «All seven categories appear so that none is silently dropped; none can be "
 "scored yet.» The AI table is deliberately rowless rather than blank-rowed: «a blank row reads as a check that ran and found nothing, which is a "
 "different and much worse claim than \"not run\".»"))

G["5.5"] = (True, True, "PASS", (
 "PASS. The collision is handled as an assumption to test, never as an observation. It is framed conditionally and routed to the live SERP: «**Item "
 "5 is the one to think hardest about, and to check first.** If the brand name is shared with anything else — a beach, a hotel, a boat, another "
 "label, an everyday word — then disambiguation is the whole audit, because every other signal you build is at risk of being attributed to the "
 "other thing. Run the bare-name query before anything else and record what dominates it.» The intake item that precedes it is likewise a request, "
 "not a finding: «Any name collision you already know about — another business, a place, a product, or an ordinary word.» No competing entity, "
 "panel or ranking result is named for this brand — the illustrative list is a set of collision TYPES, not identified entities, and scripted "
 "checks for a named competitor or a ranking claim return NO MATCH. The file also declines to assert the domain itself: «`kyma-swim.example` reads "
 "as a placeholder rather than a live domain. Send me the real one.»"))

order = [f"{e}.{i}" for e in "12345" for i in range(1, 7 if e != "5" else 6)]
exps = []
for cid in order:
    if cid not in G:
        continue
    passed, comparable, base, ev = G[cid]
    rec = {"id": cid, "text": TEXT[cid], "passed": passed, "evidence": ev,
           "comparable_to_baseline": comparable, "baseline_2026_08_10_verdict": base}
    if passed is None:
        rec["status"] = "EDITOR-PENDING"
    exps.append(rec)

p = sum(1 for e in exps if e["passed"] is True)
f = sum(1 for e in exps if e["passed"] is False)
u = sum(1 for e in exps if e["passed"] is None)
t = len(exps)
assert p + f + u == t, (p, f, u, t)

doc = {
    "expectations": exps,
    "summary": {
        "passed": p, "failed": f, "ungraded": u,
        "ungraded_reasons": [
            "4.4 — EDITOR-PENDING. The expectation's verdict is the binding greek-content-editor's grade on this eval's Greek output "
            "(.claude/agents/greek-content-editor.md). No such report on e4-out.md is in front of this grader, and the expectation states "
            "that an expectation whose evidence is absent does not pass by default (ledger F15). The mechanical layer, which this grader "
            "does own, was checked in full and holds, so the expectation is not converted to FAIL either."
        ],
        "total": t,
        "pass_rate": round(p / t, 4),
        "editor_slot_convention": "Mandated rule, commit 3a8d62c, applied: the greek-content-editor slot (4.4) STAYS IN `total` and is NEVER "
                                  "counted in `passed`. With no editor report in front of the grader it is recorded EDITOR-PENDING and counted "
                                  "in `ungraded`. passed + failed + ungraded == total == 29; pass_rate = passed / total = 22/29 = 0.7586. "
                                  "NOTE FOR POOLING: the 2026-08-10 baseline recorded editor_pending: 0 and counted 4.4 as PASS, because at "
                                  "that revision the expectation carried no editor slot — so the headline 22/29 and the baseline 18/29 are not "
                                  "the same measurement on that slot. The like-for-like figure is the comparable-subset one below.",
        "suite": "entity", "skill": "entity-optimizer",
        "skill_version_under_test": "4.2.0 (frontmatter and metadata.version both 4.2.0)",
        "run": "2026-08-12 blind execute (Mode B), graded INFORMED by a grader that did not write the deliverables and did not re-run the skill",
        "eval_suite_revision_graded": "HEAD (bd6963c) — evals.json last touched at b306ec0",
        "baseline": "docs/loop/eval-baselines/blind-2026-08-10/entity.json — 18 PASS / 11 FAIL / 29 = 0.6207",
        "comparability": {
            "method": "git diff of cross-cutting/entity-optimizer/evals/evals.json from the baseline's grading revision (dad411c) to HEAD, "
                      "compared expectation by expectation. Three expectation texts changed; 26 are byte-identical.",
            "comparable": 26,
            "not_comparable": 3,
            "not_comparable_detail": {
                "2.5": "changed at bb6ef16 (fix: resolve two mutually unsatisfiable expectation pairs)",
                "4.4": "changed at 3a8d62c (feat: the Greek editor's verdict becomes a scored slot in all 20 suites)",
                "4.2": "changed at b306ec0 (entity R64 sweep) — record carries expectation_superseded_2026_08_12"
            },
            "comparable_subset_baseline": "16 passed / 10 failed / 26 = 0.6154",
            "comparable_subset_this_run": "20 passed / 6 failed / 26 = 0.7692",
            "fixed": ["1.6", "2.6", "3.1", "3.5", "3.6", "4.6", "5.3"],
            "regressed": ["1.4", "3.4", "4.1"],
            "still_failing": ["1.1", "2.1", "2.4"]
        }
    }
}
path = os.path.join(OUT, "grading.json")
json.dump(doc, open(path, "w", encoding="utf-8"), ensure_ascii=False, indent=2)
print("wrote", path)
print("passed=%d failed=%d ungraded=%d total=%d rate=%.4f" % (p, f, u, t, p / t))
print("invariant passed+failed+ungraded==total:", p + f + u == t)
