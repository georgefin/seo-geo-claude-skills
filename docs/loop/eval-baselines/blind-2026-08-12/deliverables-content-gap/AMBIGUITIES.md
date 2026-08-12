# Ambiguity log — `research/content-gap-analysis`, blind execution 12 Aug 2026

Fifteen entries. Each records where I was, both readings, which I took, and what the other reading
would have produced. Ordered roughly by how much the fork changed the output.

---

## A1 · The tier rule admits a keyword the analysis cannot rank, and nothing in the model can see it

**Where**: Scenario 2, SKILL.md Step 9 tier rule + frameworks §4 Quick-Win Identification.

**Instruction**: "**Tier 1** = P0 or P1 with a Quick Win Score of 2+". Quick Win Score inputs are
Search Demand, Business Relevance, Creation Effort and Competitive Density.

**The fork**: `best gps watch for hiking` — volume 5,400, **KD 52, the hardest term in the export by
7 points**, competitor only reaching position 6 — scores P1 / 3.85 with a Quick Win Score of +2, and
therefore lands in **Tier 1, "Do Now"** by the letter of the rule.

**Keyword difficulty is not an input to either score.** It appears in the Step 4 bucket definitions
("achievable difficulty", "low difficulty"), in the §2 Step 4 filter table, and in the report
template's own Difficulty column — but not among the five priority factors and not among the four
quick-win inputs. Creation Effort measures *production* cost, not *SERP entry* cost, and the skill
is explicit about that distinction elsewhere. So the two systems can and do disagree.

**Both readings**: (a) apply the tier rule as written and let a KD-52 keyword sit in Tier 1;
(b) treat the Step-4 Long-term bucket ("high volume, high difficulty") as overriding the tier rule
and demote it to Tier 3.

**Taken**: (a). Demoting it would make the ranking unreproducible — the skill requires that two runs
of the same data land on the same number, and a silent difficulty override is not in the model.
I flagged the disagreement prominently in the deliverable, on the row and in a boxed warning, and
honoured the difficulty in *scheduling* (last of the Tier 1 set, with a hard dependency) rather than
in scoring.

**(b) would have produced**: a three-keyword Tier 1 and the highest-volume viable keyword in the
export buried in Tier 3 with no stated rule for how it got there.

**Why it is a defect, not a preference**: the same mechanism runs in the other direction too.
`rucksack size calculator` has the lowest KD in the export (9) and scores Creation Effort 1, because
the SERP wants a tool. Difficulty and effort are genuinely orthogonal, the skill knows it, and the
scoring model has a slot for only one of them. Three further keywords (`crampons`, `dogs
essentials`, `dog hiking boots`) sit in the low-difficulty Quick Wins *bucket* while scoring P2 with
zero or negative quick-win scores. **Four of eleven rows disagree between the two systems.**

---

## A2 · What Tier 1/2/3 mean when the quick-win screen did not run

**Where**: Scenarios 1, 3, 4 — SKILL.md Step 9; score-arithmetic §5 last bullet.

**Instruction**: Step 9 defines the three tiers using the Quick Win Score. score-arithmetic §5 says
"Where the quick-win screen did not run (Search Demand dropped), say so and **read the tiers from
the priority score alone**." It does not say what mapping that produces.

**Both readings**: (a) Tier 1 = P0, Tier 2 = P1, Tier 3 = P2+P3 — inferred from Step 9's own "let P0
carry the *start here* job"; (b) Tier 1 = P0+P1 (the set Step 9 makes tier-1-eligible before the
quick-win condition filters it), Tier 2 = empty or a judgement split, Tier 3 = P2+P3.

**Taken**: (a), stated explicitly in each deliverable.

**(b) would have produced**: in Scenario 1, a Tier 1 of eight gaps out of twelve and an empty Tier
2 — i.e. a "do now" list larger than a two-articles-a-month team's entire year.

**Why it matters**: three of five scenarios hit this branch, so the undefined mapping governs most
runs of this skill under its own most-likely operating condition (no tools connected).

---

## A3 · No third-level tie-break exists, and ties are common once a factor is dropped

**Where**: Scenarios 1, 3, 4 — score-arithmetic §4 "Combined Priority" and §5 "Report tiers".

**Instruction**: "where two scores tie, the higher GEO Value goes first". Silent on what happens
when GEO Value ties too.

**The fork**: dropping Search Demand removes 25% of the score's variance and collapses the
attainable set from multiples of 0.05 to multiples of 1/15, so ties get much more likely. Scenario 1
produced a two-way tie at 3.53 with both gaps at GEO Value 5. **Scenario 3 produced a three-way tie
at 4.27, all three at GEO Value 5.**

**Taken**: chose a tertiary tie-break per scenario and **stated it in the deliverable** rather than
applying it silently — Scenario 1: weight of observed competitor evidence; Scenario 3: session
weight of the adjacent existing page (the only *measured* quantity available and independent of both
scored factors). In both I told the client the model does not distinguish the tied rows and they may
reorder freely.

**Alternative**: leave tied rows in arbitrary order. That would have been unreproducible across
runs, which the skill's own "two runs of the same data must land on the same number" forbids.

**Suggested fix for the instrument**: the tie-break chain needs a documented third step, and the
drop-a-factor path should probably say so explicitly, because that is where ties concentrate.

---

## A4 · "Named proxy or drop" is offered as a free choice, and the two are not equivalent

**Where**: Scenarios 1, 3, 4 — SKILL.md Step 9; frameworks §4 "When a factor cannot be scored".

**Instruction**: "Either score it from a **named proxy** … or **drop the factor** and renormalise."
No criterion is given for choosing.

**The fork is sharper than it looks because of the #68 ruling.** Competitive Density is scored from
competitor coverage in every one of these scenarios, so cluster depth is inadmissible as a Demand
proxy. That leaves "own-site sessions on adjacent pages" as the only named admissible proxy — and in
both no-tool scenarios, adjacent pages exist for the *depth* gaps and for **none** of the largest
*missing* topics (Scenario 1: no page adjacent to dogs or winter; Scenario 3: none adjacent to
runners or elderly care). So the proxy route is only ever partially available.

**Both readings**: (a) proxy the rows that have an adjacent page, drop the factor on the rest —
which score-arithmetic §7.1 contemplates ("for the weight set that row **actually used**", implying
per-row weight sets); (b) drop uniformly so one weight set governs the whole ranked list.

**Taken**: (b) in all three scenarios, with the reasoning printed for the client.

**(a) would have produced**: a ranked list mixing published-weight scores (multiples of 0.05,
1.00–5.00) with renormalised ones (multiples of 1/15), plus Quick Win Scores on some rows and not
others. **The skill never says whether scores computed on different weight sets are comparable
enough to rank against each other** — and its own §7.1 note that the two sets have different
attainable values is an argument that they are not.

**Second-order issue worth recording**: the skill names own-site sessions as admissible without
noting that mapping sessions onto *search-volume* bands runs the searches→visits conversion
backwards, through the same unknown CTR that score-arithmetic §6 uses to forbid traffic projections.
The proxy is blessed in one place and undercut by the reasoning in another.

---

## A5 · Dropping Search Demand makes Business Relevance the biggest weight, where it discriminates least

**Where**: Scenario 3 most acutely; Scenarios 1 and 4 also.

**Not an ambiguity in wording — an unstated consequence of a documented mechanism**, recorded because
a reader of the skill would not predict it and the instrument gives no warning.

Renormalisation moves Business Relevance from 0.25 to **0.3333**, making it the heaviest factor. For
a single-service local business (Scenario 3, a physiotherapy centre writing about conditions it
treats), Business Relevance is close to constant at 5 across every gap. **The heaviest factor
therefore carries almost no discriminating information**, and the ranking is driven in practice by
Creation Effort and Conversion Potential at 0.20 each — the two factors the published weight set
deliberately made *joint-lowest*. Six of nine Scenario-3 gaps came out P0.

The skill anticipates the mirror-image problem (frameworks §4 "Where Creation Effort Actually
Binds", explaining why effort is only 15%) but not this one. **Renormalisation silently inverts that
design decision**: effort's share rises by a third, and relevance becomes a near-constant with the
largest weight.

**Handled by**: stating it plainly in the Scenario 3 deliverable and telling the client to read the
order within Tier 1 rather than the P0 badge. Nothing in the skill authorises re-weighting to
compensate, and Tips #2 explicitly says not to compensate by scoring a factor against its own scale.

---

## A6 · Slugs are banned from client prose; this client explicitly asked for the slugs

**Where**: Scenario 4 — SKILL.md "Routing the gaps onward"; inter-skill-handoff §3, §3.4.

**Instruction**: "A run handle — a skill slug, a framework item ID, an internal artefact name —
survives on a surface addressed to whoever operates the library, and **never in client prose**. The
test is the reader, not the section."

**The fork**: the client's message is *"tell us … which skill takes it onward and exactly what
context you would hand over, so we can run that skill without re-explaining everything."* They are
asking, in the client message, for the operator content.

**Both readings**: (a) the test is the reader, and this reader has declared themselves the operator,
so the handles are permitted — but still confined to a properly labelled operator block, which is
also the format that best serves "so we can run that skill"; (b) the rule is absolute regardless of
the request, so the report describes the runs in plain words and names no slug anywhere, leaving the
client's actual question unanswered.

**Taken**: (a). Narrative report contains zero slugs and zero item IDs; the entire routing sits in
one operator block in a fence of its own with `<!-- OPERATOR BLOCK — … -->` as its first in-fence
line, per §3.1 form 1; a plain-language "What we suggest next" section precedes it and is complete
without it, per §6's last checkbox.

**(b) would have produced**: a deliverable that refuses the client's explicit request on a rule
whose own stated test ("the reader") points the other way.

**Worth an owner ruling**: §3 gives a reader test and then a surface rule, and does not address a
client who *is* the operator. This will recur — it is the natural request from any customer running
the library themselves.

---

## A7 · "Each routed item gets its own handoff block" vs "handoff table … the default"

**Where**: Scenario 4 — SKILL.md "Routing the gaps onward" vs inter-skill-handoff §3.

**Instruction A** (SKILL.md): "Each routed item gets its own **handoff block** carrying the payload
fields §2.1 requires as far as this run has them."
**Instruction B** (carrier §3): "**Handoff table** — Two or more runs, each with its own payload —
**the default**."

**Both readings**: (a) one block per routed item — eight separate labelled fences for eight gaps;
(b) one operator block containing a table with one row per routed item, each row carrying its own
payload.

**Taken**: (b), because the carrier explicitly makes the table the default for two or more runs, and
eight separate fences would be unusable. Read "block" as "entry with its own payload".

**(a) would have produced**: eight (or eighteen, across both stages) separate fenced blocks, each
repeating the same field-availability preamble.

---

## A8 · Payload says omit a missing keyword; the skill says send the topic

**Where**: Scenario 4 — SKILL.md "Routing the gaps onward" vs inter-skill-handoff §2.1 / §4.3.

**Instruction A** (carrier §4.3): "Target keyword — the finished run had none (crawl, domain audit)
→ **Omit the field.** Do not back-fill a keyword from the page title."
**Instruction B** (SKILL.md): "Each routed item gets its own handoff block carrying … **target
keyword(s)/topic**, intended content type, and the site/content URL."

A no-tool gap analysis produces **topics and never keywords**, so this branch is not an edge case —
it is the default state of this skill.

**Both readings**: (a) omit the subject entirely, leaving rows with a content type and a URL and no
statement of what they are about; (b) omit the *keyword* field, name its absence, and carry the
**topic** in the subject position explicitly labelled as a topic.

**Taken**: (b). §4.3's concern is a keyword-shaped value invented from a title; a labelled topic is
not that, and the skill's own payload wording licenses it.

**(a) would have produced**: handoff rows that name no subject — which §2.1 itself calls
"not actionable".

---

## A9 · The content-type field points at one of two vocabularies in the same reference file

**Where**: Scenario 4 — inter-skill-handoff §2.1; core-eeat-benchmark §3 vs §5–§6.

**Instruction**: "Content type — One label, **verbatim**, from the CORE-EEAT content-type weight
table (page level) … **Required** … it selects the receiving run's weight profile."

**The fork**: the benchmark file carries **two non-identical content-type vocabularies**. §3's
Content-Type Weight Table gives nine labels — *Product Review · How-to Guide · Comparison · Landing
Page · Blog Post · FAQ Page · Alternative · Best-of · Testimonial*. §5's schema table and §6's
decision tree give a different, partially overlapping ten — *Blog (guides) · Blog (tools) · Blog
(insights) · Alternative · Best-of · E-commerce category · Use-case · FAQ · Landing · Testimonial*.
Four labels are common; the rest differ or are renamed.

**Taken**: the §3 weight-table set, because §2.1 names it specifically and gives the reason (it
selects the weight profile). Recorded the divergence in the operator block so a downstream reader
does not resolve it the other way.

**Consequence worth naming**: neither vocabulary has a label for a **glossary/definition page** or
for an **interactive tool**, and both were real routed items in Scenario 4. I applied §4.3
("genuinely ambiguous page → do not guess … name the ambiguity and ask") and sent no type on those
two rows, with a note giving the two candidate labels and the weight consequences of each. The
alternative — forcing `FAQ Page` or `Landing Page` — would have misdescribed the page to every
downstream run while looking complete, which §4.4 calls "a defect that propagates".

---

## A10 · The skill mandates a report shape and is silent on what to deliver when input validation fails

**Where**: Scenario 5 — SKILL.md "Content Gap Report" + Validation Checkpoints → Input Validation.

**The fork**: two of the four input checks fail outright with no data ("content inventory complete
or representative sample provided"; "business goals and priorities clarified"). The skill mandates
the report shape as "the deliverable" and never says what happens when the analysis cannot run.

**Both readings**: (a) emit the mandated shape with every section present and every cell marked
unavailable; (b) emit the data request that the Data Sources section calls for ("**With manual data
only:** Ask the user to provide…"), plus a statement of what the shape will contain once inputs
arrive.

**Taken**: (b). Reading (a) collides with score-arithmetic §6 and the Value Rule it cites — "A cell
whose only honest value is a bracket token does not survive into a deliverable … drop the cell, name
what it would have taken to fill it, and say what the client would have to send." A report of empty
cells is precisely the artefact that rule exists to prevent.

**(a) would have produced**: an eight-section document in which every table is empty — which reads
as an analysis and contains none.

**Secondary tension in the same place**: the Data Sources section ends "**Proceed with the full
analysis using provided data**", which reads as an instruction to proceed regardless, while Input
Validation gates it. With zero data there is nothing to proceed with.

---

## A11 · The Quick Win Score band labels misdescribe what the score measures once effort is a build

**Where**: Scenario 2 — frameworks §4 Quick-Win band table.

**Instruction**: the Negative band is labelled "**Avoid** — high effort/competition relative to
demand".

**The fork**: `rucksack size calculator` scores −2, driven entirely by Creation Effort 1 (it needs
software, not writing). It also carries the **highest Conversion Potential in the export (5)** and
scores P1 / 3.00. "Avoid" is exactly the wrong instruction. `hiking first aid kit list` at +1 lands
in "not a quick win" for the opposite reason — nothing is weak, nothing is strong.

**Taken**: printed the band arithmetic as the model produces it and **overrode the band's English in
prose on the row**, telling the client to read −2 as "cannot be delivered by your writer", not as
"not worth having". The tier (Tier 2, P1) was left exactly as the rule produces it.

**Note**: the skill already does this kind of correction elsewhere — Tips #2 and frameworks §4
"Where Creation Effort Actually Binds" both explain that a gap is not worth less for being
expensive. **The band label contradicts that explanation in one word.**

---

## A12 · "Executive Summary must carry keyword-gap count and combined volume" — three of five runs have neither

**Where**: Scenarios 1, 3, 4 — SKILL.md Content Gap Report → Executive Summary block.

**Instruction**: "**Total opportunity**: [X] keyword gaps · combined search volume [X]/month where
volumes exist (search volume, not visits) · [X] quick wins".

"where volumes exist" covers the volume clause. Nothing covers the other two: with no keyword data
there are **no keyword gaps to count** (the gaps are topics), and with no quick-win screen there are
**no quick wins to count**.

**Taken**: reported the gap count with an explicit statement that these are topic/depth/format gaps
and **not** keyword gaps, said no combined volume exists, and said the screen did not run. The
analysis-templates note ("*Total Opportunity* carries the gap count alone, and says so, when no
volumes exist") supports this for the volume clause and is silent on the noun.

**Alternative**: report "0 keyword gaps", which would be false — zero means counted and none found.

---

## A13 · Calendar cadence table has no band for a team below four pieces a month

**Where**: Scenarios 1, 3, 4 — frameworks §5 "Calendar Cadence by Team Size".

**Instruction**: the report shape says the calendar is "capped by the team's **real monthly
output**". The §5 table's smallest band is Solo = 4–6 pieces/month, with a "Full Gap Close Timeline"
column keyed to it.

**The fork**: two of the three clients stated capacity **below** the smallest band — TrailKit ~2
articles/month, the Greek clinic 1–2. Their stated capacity falls off the bottom of the table, so
the closure timeline cannot be read from it.

**Taken**: used the client's stated figure, computed the horizon from it, and noted the divergence
from the table in the deliverable.

**Why worth logging**: the report-shape sentence resolves it, but only if you notice the conflict.
A reader working from §5 alone would schedule 4–6 pieces a month for a team that writes two, and the
Full Gap Close Timeline column has no row that applies.

---

## A14 · "Every score prints its working" vs "no score at all is printed" — how to show a gap with no printable score

**Where**: SKILL.md Scoring & Derivation Rules, second and third rules.

**Instruction A**: "A gap's row carries its five factor scores, the weighted line that produced the
total and the rounded total the tier was read from."
**Instruction B**: "No score at all is printed for a gap whose factors could not be judged: `not
scored — no coverage data`, never `1.00`."

**The fork**: in a Search-Demand-dropped run, *every* row shows **four** factor scores, not five.
Rule A's "five factor scores" is stated unconditionally.

**Taken**: printed four factor scores per row under an explicit four-factor column header
(Den/Rel/Eff/Conv), with the dropped factor named and the renormalised weight set printed above the
table. Read A's "five" as "all the factors that were scored" rather than as a literal count.

**Alternative**: print five columns with the Search Demand cell showing an explained N/A. Rejected —
score-arithmetic §7.1 tests scores against "the weight set that row **actually used**", implying the
row is a four-factor object, and a fifth column of N/As is a cell whose only honest value is a token.

**No case of rule B arose**: every gap in every scenario had judgeable factors once Search Demand
was dropped.

---

## A15 · Blocked references

Per brief §1.3, recorded and worked around. **Neither turned out to be load-bearing**: in both cases
the skill or its permitted references state the substance inline.

| Blocked pointer | Where it appears | How I proceeded |
|---|---|---|
| `evals/evals.json` | Not cited by the skill; the fixture files sit beside it in `evals/files/` | Never opened. Read only the six fixture files named in the brief. Listing the directory showed the filename and nothing else |
| `anti-slop-ruleset.md` §6 families 7 and 8 | Cited by SKILL.md Output Validation (family 7, `~~` tokens) and by inter-skill-handoff §3 and §4.1 (family 8, run handles in client prose) | Not read — it sits inside another skill's directory (`build/seo-content-writer/references/`), which brief §1.2 puts out of bounds. **Both rules are stated in full in the citing text**: family 7's substance is the three-step resolution in inter-skill-handoff §4.1, family 8's is the binding ruling in §3 plus the wrong/right table in §3.4. I applied both from those statements. No `~~` token appears on any client surface in any of the five deliverables; no slug or item ID appears in any client prose |

**One further pointer, read rather than blocked, and flagged for transparency**: inter-skill-handoff
§2.1 sends the content-type field to `references/core-eeat-benchmark.md`, a second-order citation the
brief does not name. It is on no banned list, and reading it was the difference between a verbatim
label and a coined one — the exact distinction §2.1 and §4.4 grade. I read approximately the first
280 lines (framework overview, the 80-item checklist, the scoring system including the content-type
weight table, and the schema/decision-tree sections). I did not read `cite-domain-rating.md`: no CITE
score travels in any handoff here, so it was not needed.

---

## Not logged

Things I considered and rejected as below the bar of "a fork someone else could also hit":

- Preferences about report length, section order, or table styling.
- The choice of specific article titles in the calendars — judgement, not instruction ambiguity.
- Greek number formatting (comma decimal, dot thousands) in Scenario 3 — the skill says the language
  is the client's, and Greek convention settles it without a fork.
- Individual factor scores I found hard to judge (e.g. whether a buying guide is Consideration or
  Decision). The skill's four-stage table plus my own stated classification rules resolve these; a
  different analyst would score some differently, but that is judgement variance, not an
  underdetermined instruction. I stated the classification rules used in each deliverable so the
  variance is at least visible and reproducible.
