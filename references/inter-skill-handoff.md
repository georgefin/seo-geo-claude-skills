# Inter-Skill Handoff — Skills Reference

> The convention is stated in the repo's root `CLAUDE.md`, section **Inter-Skill Handoff**. This
> file is its carrier — the shipped statement a skill can read at run time. `CLAUDE.md` is a repo
> context file, not part of the installed skill surface, so a rule that lives only there is a rule
> the running library does not carry.
>
> **Sister references**: [CORE-EEAT Content Benchmark](./core-eeat-benchmark.md) — page level, 80
> items · [CITE Domain Rating](./cite-domain-rating.md) — domain level, 40 items. Every score and
> every item ID that travels in a handoff comes from one of those two files; neither invents one.
>
> **Version sync**: when `CLAUDE.md` § Inter-Skill Handoff changes, check Sections 2 and 4 below.
> When any skill's *Recommended Next Steps* block changes, re-derive the Section 5 tables — they
> are a grep result with a date on them, not a design.

**Twenty skills recommend each other.** A handoff is the fixed payload one run passes to the next,
plus the operator-only block it travels in. Without both halves the receiving run starts cold, and
the client reads machinery addressed to somebody else.

---

## 1. What a Handoff Is

Three shapes are easy to confuse. Only the first is a handoff:

| Shape | Where it lives | Carries a payload? |
|-------|----------------|--------------------|
| **Handoff** — this run finished, and names the next run plus the context that run needs | Operator block in the output (Section 3) | **Yes** — Section 2 |
| **Routing pointer** — disambiguation for a request that belongs to a different skill | `description` frontmatter, *Scope Boundary* sections | No — nothing has been run yet |
| **See-also list** — the standing *Related Skills* list at the foot of every SKILL.md | SKILL.md, static | No — a catalogue, not an event |

The test: a `Related Skills` bullet reads identically on every run. A handoff reads differently on
every run, because it carries *this* run's results. Do not attach payload fields to a routing
pointer or a see-also list — there is nothing yet to put in them.

---

## 2. The Payload

### 2.1 Fields

The six fields below are the convention as stated in root `CLAUDE.md`.

| Field | Format | Required or conditional | Example |
|-------|--------|-------------------------|---------|
| **Target keyword** | The exact string the finished run targeted, in quotes. One keyword; a cluster goes as the head term plus a count | **Required** whenever the finished run had one. A run with no keyword (a technical crawl, a domain audit) omits the field rather than inventing one | `"bandsaw blade selection"` |
| **Content type** | One label, verbatim, from the CORE-EEAT content-type weight table (page level) or the CITE domain-type decision tree (domain level) | **Required** for page-level and domain-level handoffs alike — it selects the receiving run's weight profile | `How-to Guide` · `Content Publisher` |
| **CORE-EEAT dimension scores** | Labelled score string — Section 2.2 | **Conditional**: present when a CORE-EEAT audit has actually been run. Never estimated from a partial scan | `CORE-EEAT C:70 O:85 R:40 E:30 Exp:60 Ept:55 A:30 T:75` |
| **CITE scores** | Labelled score string — Section 2.2 | **Conditional**: present when a CITE domain audit has actually been run | `CITE C:62 I:45 T:80 E:55` |
| **Priority item IDs** | Hyphenated framework-first IDs, comma-separated, highest impact first — Section 2.3 | **Conditional**: present when either audit produced a ranked fix list. Send the ones that motivated *this* handoff, not the whole failing set | `CORE-EEAT-R02, CORE-EEAT-R03, CORE-EEAT-E01` |
| **Content URL** | One absolute URL, scheme included. Domain-level handoffs send the bare domain instead, labelled as such | **Required** — a handoff naming no subject is not actionable. Several pages go as an explicit list, one per row | `https://northfield-tools.example/guides/bandsaw-blade-selection` |

### 2.2 Score-string notation

Exact form: the framework label, then one `Abbr:score` pair per dimension, space-separated.

```
CORE-EEAT C:70 O:85 R:40 E:30 Exp:60 Ept:55 A:30 T:75
CITE C:62 I:45 T:80 E:55
```

- **Abbreviations are the framework's own** — CORE-EEAT: `C` `O` `R` `E` `Exp` `Ept` `A` `T`
  ([core-eeat-benchmark.md](./core-eeat-benchmark.md) § 1); CITE: `C` `I` `T` `E`
  ([cite-domain-rating.md](./cite-domain-rating.md) § 1).
- **Scores are integers 0–100**, one per dimension, in the framework's own order. No spaces around
  the colon. A dimension that was not scored is omitted from the string, not sent as `0` — zero is
  a real score meaning every item failed.
- **The half-string is legitimate.** `CORE-EEAT C:70 O:85 R:40 E:30` — the four CORE dimensions
  alone, which is the example `CLAUDE.md` gives — is correct when the receiving run is GEO-side
  only. Say which half you sent; a bare four-pair string is otherwise indistinguishable from a
  full audit that lost half its data.
- **Derived figures do not travel.** GEO Score, SEO Score, Total, Weighted Score and the CITE
  weighted total all recompute from the dimensions plus the content type, both of which are in the
  payload. Sending a derived number invites two runs to disagree about arithmetic.

**The framework label is not optional.** Three abbreviations collide across the two frameworks:

| Abbr | In CORE-EEAT | In CITE |
|------|--------------|---------|
| `C` | Contextual Clarity | Citation |
| `E` | Exclusivity | Eminence |
| `T` | Trust (source/site level) | Trust (manipulation detection) |

A bare `C:62` is unreadable. `CLAUDE.md` states the payload without saying which framework a score
string belongs to; this file settles it by requiring the label, because the collision is real and a
receiving run cannot guess past it. That is a carrier-level resolution of an ambiguity, not a new
rule about what gets passed.

### 2.3 Priority item IDs

**One form, everywhere: hyphenated, framework-first.** `CITE-C01` · `CORE-EEAT-R02` ·
`CORE-EEAT-Ept03` · `CITE-T09`. Every ID carries its own prefix, including inside a list where every
ID happens to come from the same framework: `CORE-EEAT-R02, CORE-EEAT-R03, CORE-EEAT-E01`.

Three reasons the form is this one, so it can be applied rather than memorised:

1. **A bare ID is genuinely ambiguous.** The two frameworks share `C`, `E` and `T` (Section 2.2), so
   `C01` means Intent Alignment in one and Referring Domains Volume in the other. There is no context
   inside the string that resolves it.
2. **The receiving run must act without asking.** That is the whole point of a payload. A group
   prefix — one framework label governing a following list — survives only while the list stays
   intact; the moment one ID is quoted, copied into a memory file, or moved to another row, it is
   bare again. A per-ID prefix cannot come apart.
3. **It already ships.** `domain-authority-auditor` specifies the hyphenated framework-first shape
   for combined 120-item assessments, so this is the least-churn choice rather than a form invented
   at a desk. That skill's prefix for the page-level framework has been aligned to the full
   `CORE-EEAT-` used here, so the library carries one prefix rather than two.

Related but distinct: a **score string** carries the framework as a single leading token followed by
its `Abbr:score` pairs — `CORE-EEAT C:70 O:85 …` (Section 2.2). Same framework-first principle, and
unambiguous for the same reason; it does not hyphenate into every pair, because the pairs are one
reading of one instrument and never travel individually.

- IDs come from the two benchmark files and nowhere else. If an ID is not in
  [core-eeat-benchmark.md](./core-eeat-benchmark.md) § 2 or
  [cite-domain-rating.md](./cite-domain-rating.md) § 2, it does not exist — do not coin one.
- Order by the producing run's own ranking (weight × points lost), highest first.
- An item ID is a coordinate in a document the client has never opened. It belongs in the operator
  block and on no other surface — Section 3.

### 2.4 Two conditional additions (this carrier, not the `CLAUDE.md` list)

Neither field appears in the `CLAUDE.md` payload list. Both are recorded here because a score sent
without them is read wrong by the next run. Drop them if the coordinator rules the payload closed.

| Field | Format | When | Why it is here |
|-------|--------|------|----------------|
| **Veto status** | `vetoes: CORE-EEAT-C01 pass, CORE-EEAT-R10 pass, CORE-EEAT-T04 N/A` · `vetoes: CITE-T03 pass, CITE-T05 pass, CITE-T09 pass` | Whenever a score string is sent | A verified veto caps the CORE-EEAT final at 59 or blocks it outright, and caps CITE at 39. A dimension string with no veto flag reads as a clean score when it may be a capped one |
| **Audit date** | `audited YYYY-MM-DD` | Whenever a score string is sent | A score is a measurement, and a measurement with no date cannot be told from a stale one. R06 and T08 both score freshness; the handoff should not be the one undated figure in the chain |

---

## 3. Where a Handoff Goes — the Test Is the Reader

**Binding ruling.** A run handle — a skill slug, a framework item ID, an internal artefact name —
survives on a surface addressed to whoever operates the library, and **never in client prose**. The
test is the reader, not the section: the same words are correct in an operator note and a FAIL in a
report paragraph one line above it. Failure grade and greppable net:
[`build/seo-content-writer/references/anti-slop-ruleset.md`](../build/seo-content-writer/references/anti-slop-ruleset.md)
§ 6, FAIL-grade family 8.

So: **a handoff is emitted into a clearly-labelled operator block — never into a sentence the client
is meant to read.** Three shapes are sanctioned:

| Shape | Use it when |
|-------|-------------|
| **"Next steps for your team"** section | One or two follow-up runs, at the end of a short deliverable |
| **Handoff table** | Two or more runs, each with its own payload — the default |
| **Appendix of follow-up runs** | Long reports, where the block would otherwise interrupt the client's reading |

Whichever shape, the block is **labelled as operator-addressed**, and — the part that actually
decides it — **the label lives inside the fence**. Section 3.1.

### 3.1 The label lives inside the fence

**Sub-rule (binding).** A block sitting inside a client deliverable is an operator surface **only if
it is labelled inside the fence, in that fence's own syntax**. An unlabelled one is family 8, whatever
the prose above the fence says.

The mechanism is not a style preference and is not new here. It is the same one that produces the
skeleton exception in `CLAUDE.md` § **The Value Rule**, clause 2: **a model copies the fence, not the
heading above it.** A paragraph outside the fence saying "the block below is for your team" is
invisible the moment anyone copies the fence — and copying the fence is what a report template is
*for*. So the label goes where the copy takes it:

| Fence syntax | Label form |
|--------------|------------|
| `markdown` (report templates) | `<!-- OPERATOR BLOCK — … -->` as the first line inside the fence |
| HTML | `<!-- OPERATOR BLOCK — … -->` |
| JSON / JSON-LD | `"_OPERATOR": "…"` as the first member |
| Text formats (`robots.txt`, config, plain) | `# OPERATOR BLOCK — …` |

**The label vocabulary is a CLOSED list of three, ruled 2026-08-17 (finding 112).** Three labels,
because a fence can be non-client for three different reasons and a reader needs to know which:

| Label | Says | Use when |
|-------|------|----------|
| `SKELETON` | structure only — every slot is unfilled and nothing here is paste-ready | a template with `[bracket]` slots |
| `ILLUSTRATIVE FILL` | filled, but **every** number, name and date is invented | a worked example the reader must not copy as data |
| `OPERATOR BLOCK` | addressed to whoever runs the skill library, not to the client | a handoff block, a lookup table, an author's check |

Nothing else. `OPERATOR HANDOFF` was a fourth spelling of `OPERATOR BLOCK` and is **retired**
(4 sites in rank-tracker, renamed 2026-08-17). The list is closed for a measured reason: a sweep
for unlabelled fences carrying a run handle **flagged a correctly-labelled block** — rank-tracker's
— purely because its label word was not on the list the checker knew. **A checker cannot verify a
rule whose vocabulary is open**, and an open vocabulary turns every new synonym into a false
positive that trains people to ignore the checker. `bash scripts/fence-nesting-check.sh --labels`
reports any label word outside these three.

Two ways to satisfy the rule, in order of preference:

1. **Lift it out.** Close the client report's fence before the handoff and emit the operator block as
   a *separate fence of its own*, with its own in-fence label. Structurally separate, so a copy of
   the report fence cannot pick it up at all. Prefer this wherever the template allows it.
2. **Keep it inside, labelled.** Where the block must stay in the same fence, the in-fence label is
   the whole of the fix — and it names the block, says who it is for, and says what to do with it
   before the deliverable ships.

**The test — apply it to every handoff block.** *Could a reader who copies only the fence tell this
block is not for the client?* If no, it is not fixed. Prose outside the fence never answers this
question, so it never settles it.

### 3.2 Worked example — the operator block

Emitted by a finished CORE-EEAT content audit, as a separate fence of its own (form 1). Everything
in it is invented for this file.

```markdown
<!-- OPERATOR BLOCK — for the client's team, not part of the report above. Every row names a
     library run and carries its payload. Nothing in this fence goes to the client as written. -->
### Next steps for your team

| # | Run | Why | Payload |
|---|-----|-----|---------|
| 1 | `geo-content-optimizer` | R and E are the two failing CORE dimensions and both are GEO-First heavy | `"bandsaw blade selection"` · How-to Guide · `CORE-EEAT C:70 O:85 R:40 E:30 Exp:60 Ept:55 A:30 T:75` · priority `CORE-EEAT-R02, CORE-EEAT-R03, CORE-EEAT-E01` · `https://northfield-tools.example/guides/bandsaw-blade-selection` · vetoes `CORE-EEAT-C01` pass, `CORE-EEAT-R10` pass, `CORE-EEAT-T04` N/A · audited 2026-08-10 |
| 2 | `content-quality-auditor` (re-run) | Confirms the R/E gain and catches regressions in the dimensions we are not touching | Same URL and content type; compare against `CORE-EEAT C:70 O:85 R:40 E:30 Exp:60 Ept:55 A:30 T:75`, audited 2026-08-10 |

**Field not sent — CITE scores.** No domain audit exists for northfield-tools.example, so both rows
omit the CITE field rather than estimating it. Run `domain-authority-auditor` on the domain if you
want the combined 120-item picture; without it, "great content, invisible domain" can be neither
ruled in nor out.
```

The same block **without** its first two lines is the failure: a copied fence that opens on a table
of skill slugs and item IDs, sitting in a document the client was handed. Nothing else about it
would need to change for it to be a FAIL.

### 3.3 The same handoff, in the client's report

Same two follow-up runs, no handles. Note what survives: the *work*, named in the client's own
words. What does not: the slugs, the item IDs, the score string, the framework name unglossed.

```markdown
### What we suggest next

Two of the four content-quality measures came in low — how well the guide's claims are sourced,
and how much of it is unavailable anywhere else. Those are the two that answer engines lean on
hardest when they decide what to quote, so that is where the next pass goes: named sources on the
blade-geometry claims, and your own bench-test feed rates published rather than summarised. We
will re-score the page afterwards so the movement is visible against today's baseline.

We have reviewed this page only, not the site as a whole. A site-wide authority review is separate
work, and it would tell you whether this page is being held back by the site around it.
```

### 3.4 What breaks the rule

| Wrong (client-read prose) | Right |
|---------------------------|-------|
| "Run `geo-content-optimizer` next." | "The next pass rewrites the sourcing and the original-data sections." — routing goes in the operator block |
| "Items R02 and R03 failed." | "Claims are under-sourced: fewer than one external citation per 500 words, and no primary sources." |
| "Your CORE-EEAT scores are C:70 O:85 R:40 E:30." | Name the four measures in plain words with their scores, or gloss the framework on first use, then use the label — the gloss-on-first-use exemption in family 8 |
| A handoff table pasted into the report body | The table moves to an operator block or an appendix, labelled **inside its fence** (3.1) |
| An operator block inside the report fence, announced only by a paragraph above the fence | The label moves inside the fence, or the block moves out into a fence of its own (3.1) |

A **framework name** the client is actually buying (CORE-EEAT, CITE, a named audit methodology) may
appear on a client surface **if it is glossed on first use** — the family-8 exemption. A framework
**item ID** and a **skill slug** are never exempt, in any language.

---

## 4. When a Field Is Unavailable

Two binding repo rules govern this, both stated in root `CLAUDE.md`. In a handoff they say the same
thing twice: **a missing field is dropped and named, never filled with something shaped like a
value.**

### 4.1 The connector-token rule

Stated in `CLAUDE.md` § **Tool Connector Pattern**; carried with its FAIL grade in
`build/seo-content-writer/references/anti-slop-ruleset.md` § 6, family 7 (greppable: `~~`).

A `~~category` token names a tool *category* so skill text can stay tool-agnostic. It addresses the
skill author and the operator, and has no referent for a client in any language. Resolve it when the
output is written, three ways:

1. **Tool connected** → the tool's real name — "Google Search Console", "Ahrefs".
2. **No tool, data from elsewhere** → that source in plain language, in the deliverable's language —
   "your 28-day Search Console export", "hand-checked in incognito, 10 Aug".
3. **No tool and no data** → say exactly that, and leave the figure out.

**In a handoff.** An operator block may keep a `~~category` token where it names the category the
next run should draw on — the operator holds the mapping. It may **never** stand in a payload field
where a value belongs: `CITE C:~~link database` is not a score, it is a missing score wearing a
token. And the moment the block, or any line from it, is lifted into client-read prose, the token
resolves by the three steps above like any other.

### 4.2 The Value Rule

Stated in `CLAUDE.md` § **The Value Rule**; carriers listed there.

Any block a user is told to paste carries **resolved values only**. A value that cannot be sourced
means the property is **dropped**, and the gap is named in the report prose: which field, what its
absence costs, exactly what to send. A bracket token, `TBD`, `XX`, or a note shaped like a value
never appears in a value position. The one exception is a block explicitly labelled a skeleton, with
the label **inside the fence in that fence's own syntax** — a model copies the fence, not the
heading above it.

**In a handoff.** A handoff table is pasted — the operator copies the payload into the next run.
Treat it as paste-ready: an unsourceable field is dropped from the row and named in a note beneath
the block, exactly as the worked example does with its missing CITE field. A handoff block is never
introduced with paste-ready framing while carrying bracket tokens; if it is genuinely a template,
label it a skeleton in the fence.

### 4.3 Field by field

| Field unavailable | What that looks like | Emit |
|-------------------|----------------------|------|
| Target keyword | The finished run had none (crawl, domain audit) | Omit the field. Do not back-fill a keyword from the page title |
| Content type | Genuinely ambiguous page | Do not guess — the receiving run's weights depend on it. Name the ambiguity and ask, or send the type you scored with and say it was the assumption |
| CORE-EEAT scores | No content audit run, or only a partial scan | Omit the field and name it: "no 80-item audit has been run on this page." A 17-item quick scan is not a dimension score and never becomes one |
| CITE scores | No domain audit run | Omit and name it, as in 3.1. Never relabel a vendor metric (Semrush Authority Score, Moz DA, Ahrefs DR) as a CITE score — different instruments, not interchangeable |
| Priority item IDs | No ranked fix list produced | Omit. A prose description of the problem is a legitimate substitute; a coined ID is not |
| Content URL | Content supplied as pasted text or a file | Send the file name or "pasted text, no URL supplied" — a subject label the operator can act on |
| Veto status | Veto evidence unassessable | Say so. Under CORE-EEAT that state means no final score is issued at all, and the handoff must transmit that, not a number |
| Audit date | — | There is always a date; it is the day the run happened |

### 4.4 Never

- A `~~category` token in a payload value position.
- `[SCORE]`, `TBD`, `XX`, `N/A` used as a stand-in for a number that exists but was not looked up.
  (`N/A` is legitimate for a genuinely inapplicable item — `CORE-EEAT-T04` with no material
  connection — and only there.)
- A score interpolated, rounded up from a partial scan, or carried over from an older audit without
  its own date.
- A payload field invented so the row looks complete. An incomplete row that names its gap is a
  working handoff; a complete-looking row with one guessed field is a defect that propagates.

---

## 5. Who Produces and Who Consumes

Derived 2026-08-10 by grepping all 20 skill directories (`SKILL.md` plus `references/`, excluding
`evals/`) for the 20 skill slugs, for slash-command invocations, and for next-step section headings.
This is what the grep found, not a target state. Re-derive it after any skill edit that adds or
removes a follow-up recommendation.

**Re-derived 2026-08-13** after `content-gap-analysis` 4.2.4 gained a *Handoff to the Next Run*
section (finding 62 — its eval graded a convention the skill never stated). It is now a producer and
was in neither table. **This is the maintenance obligation working as designed and it only worked
because the implementer flagged it** — nothing in the gate re-derives these tables, so a skill that
gains a follow-up recommendation silently falsifies both. Recorded as a guard candidate rather than
patched: the check is a grep, and this file already states the exact grep.

### 5.1 Producers — a skill whose own output names a follow-up run

| Producer | Where the handoff is emitted | Runs it names |
|----------|------------------------------|---------------|
| `content-quality-auditor` | SKILL.md → *Recommended Next Steps*, inside the report template | `seo-content-writer`, `geo-content-optimizer`, `content-refresher`, `/seo:check-technical` |
| `domain-authority-auditor` | SKILL.md → *Recommended Next Steps* + *Cross-Reference with CORE-EEAT*; `references/example-report.md` | `content-quality-auditor`, `backlink-analyzer`, `competitor-analysis`, `/seo:report`, `/seo:audit-page` |
| `on-page-seo-auditor` | `references/audit-templates.md` → Step 10 CORE-EEAT quick scan | `content-quality-auditor` |
| `technical-seo-checker` | `references/technical-audit-templates.md` → Step 7 structured data | `content-quality-auditor` |
| `internal-linking-optimizer` | SKILL.md → Step 3, anchor-text analysis | `content-quality-auditor` |
| `competitor-analysis` | `references/analysis-templates.md` → Synthesis Report operator notes; SKILL.md → Step 8 | `domain-authority-auditor` |
| `performance-reporter` | `references/report-output-templates.md` → § 6 and § 7 operator notes | `domain-authority-auditor` (`/seo:audit-domain`), `/seo:audit-page` |
| `content-gap-analysis` | SKILL.md → *Handoff to the Next Run*; `references/analysis-templates.md` → Handoff Block Template | `keyword-research` (demand validation on the gap keywords), `seo-content-writer`, `content-refresher` |

### 5.2 Consumers — a skill named as somebody's follow-up run

| Consumer | Named by | What it needs on arrival |
|----------|----------|--------------------------|
| `content-quality-auditor` | `domain-authority-auditor`, `on-page-seo-auditor`, `technical-seo-checker`, `internal-linking-optimizer`, `performance-reporter` | Content URL (or page list), content type. Prior CORE-EEAT string when re-auditing |
| `geo-content-optimizer` | `content-quality-auditor` | Target keyword, content type, CORE-EEAT string, failed GEO-First item IDs, URL |
| `content-refresher` | `content-quality-auditor`, `content-gap-analysis` | URL, content type, weak dimensions as the focus set |
| `domain-authority-auditor` | `competitor-analysis`, `performance-reporter` | The domain (or domain list) and the domain type — see 5.3 |
| `backlink-analyzer` | `domain-authority-auditor` | Domain; the CITE `C` dimension score that motivated the run |
| `competitor-analysis` | `domain-authority-auditor` | Your domain plus competitor domains; CITE scores where they exist |
| `keyword-research` | `content-gap-analysis` | The gap keyword set, and the market/language — it validates demand before anything is written |
| `seo-content-writer` | `content-quality-auditor`, `content-gap-analysis` | Target keyword, content type, the CORE-EEAT constraints to write against |
| `memory-management` | Not named as a next run — it is the store, not a step | See 5.3 |

### 5.3 Follow-up recommendations the convention does not cover

Recorded as found. Each is a real handoff the six-field payload does not fit.

1. **Slash-command handoffs.** `content-quality-auditor` sends the operator to
   `/seo:check-technical`; `domain-authority-auditor` to `/seo:report` and `/seo:audit-page`;
   `performance-reporter` to `/seo:audit-domain`. The convention describes skill-to-skill passing and
   says nothing about a command invocation. Interim reading: a command wraps a skill, so pass the
   same payload — but this is not ruled.
2. **No domain field.** `competitor-analysis` → `domain-authority-auditor` needs *several domains*.
   The payload has "content URL", which is page-level and singular. `competitor-analysis`'s own
   template already says the domains are passed "per the library handoff convention" — a convention
   that, as stated, has no field for them. Section 2.1 handles it by letting the URL field carry a
   labelled bare domain, or a list; that is this carrier's reading, not a ruling.
3. **Page lists.** `domain-authority-auditor` → `content-quality-auditor` "on key pages", and
   `performance-reporter` → `/seo:audit-page` "on the key landing pages". Plural subjects, singular
   field. Same interim handling: one row per page.
4. **`memory-management` is a bus, not a step.** It stores what each producing run emits
   (`references/update-triggers-integration.md` lists the per-skill storage rules) and `CLAUDE.md`
   says prior audit results then load automatically from the hot cache. So a payload can reach a
   later run without any block naming it. The convention has no field for where a result was stored
   or where it was read from.
5. **`alert-manager` and `rank-tracker` take a different payload.** Thresholds, metrics and
   frequencies — none of the six fields except the target keyword applies. Do not force the payload
   onto them.
6. **"Next Steps" that are not handoffs.** `keyword-research` and `serp-analysis` both end their
   reports with a *Next Steps* section, and both contain client action items naming no skill. They
   look like handoff points and are not. Do not attach a payload to them.
7. **Descriptions and `Related Skills` are not handoffs.** Every skill's `description` routes
   ("For a broader on-page audit, see on-page-seo-auditor") and every SKILL.md ends with a see-also
   list. Both are static. Section 1 is the reason no payload belongs there.

---

## 6. Pre-Send Checklist

- [ ] Every score string carries its framework label (`CORE-EEAT …` / `CITE …`), and every item ID
      carries the same prefix
- [ ] Score strings are integers, one per scored dimension, in framework order; unscored dimensions
      omitted, not zeroed
- [ ] Veto status and audit date accompany every score string
- [ ] No derived figure (GEO Score, SEO Score, Total, Weighted) travels — only dimensions and the
      content type
- [ ] Every unavailable field is **absent and named**, never a token, a bracket, `TBD`, or a guess
- [ ] No `~~category` token sits in a payload value position
- [ ] The handoff sits in a block labelled operator-addressed, outside any client-read fence
- [ ] No skill slug, framework item ID, or internal artefact name appears anywhere in client prose;
      framework names that do appear are glossed on first use
- [ ] The client-facing version of the same recommendation names the *work*, in the client's own
      language, and is complete without the operator block
