# Prohibited Tactics — Skills Reference

> The convention is stated in the repo's root `CLAUDE.md`, section **Prohibited Tactics**. This
> file is its carrier — the shipped statement a skill can read at run time. `CLAUDE.md` is a repo
> context file, not part of the installed skill surface, so a rule that lives only there is a rule
> the running library does not carry.
>
> **Sister references**: [Query-Cluster Ownership](./query-cluster-ownership.md) — the duplicate
> microsite prohibition is the enforcement edge of that file's one-owner rule ·
> [AI Visibility Measurement](./ai-visibility-measurement.md) §7 — what may never be promised ·
> [CORE-EEAT Content Benchmark](./core-eeat-benchmark.md) — items C01, T04 and R10 are the scored
> vetoes several of these tactics trip.

**No skill in this library recommends, drafts, or implements anything on this list — in any
deliverable, in any language, at any tier, and regardless of how the request is phrased.** Where a
client's existing setup already contains one, the skill names it as a risk with a remediation and
an owner; it does not quietly leave it in place, and it does not build on top of it.

This is not a stylistic preference. Entries 1–10 each fail on at least two of three counts: they
misrepresent something to a reader, they are retractable by the platform they target, and they
damage the client when found. The list is short because it is meant to be remembered.

**Entry 11 does not fit that test, and is on this list deliberately.** Entries 1–10 are tactics a
skill might *recommend to a client*; entry 11 is a floor on what the library *itself writes into
files it controls*. It misrepresents nothing and no platform retracts it — it fails the third
count alone, and hardest. It is here because this is the file a skill reads to find out what must
never be produced, and a data-handling floor kept somewhere else is a floor no run would meet.
Its enforcement surface is the skill that builds the hazard: `cross-cutting/memory-management/`,
whose hot cache auto-loads into every session.

---

## 1. The List

| # | Tactic | What it looks like | Why it is out | What to do instead |
|---|---|---|---|---|
| 1 | **Doorway pages** | Thin near-duplicate pages generated per city, per keyword variant, or per model number, existing to catch a query and funnel elsewhere | The page has no purpose for its own reader; it exists to intercept. Explicitly targeted by search platform spam policy, and the penalty lands on the whole site | One substantive page per genuine intent. Where geography or model genuinely differs, the page carries genuinely different content — stock, price, service, availability |
| 2 | **Duplicate microsites** | A second property targeting the same clusters as an existing one, with reworded but equivalent content | It creates the collision that [Query-Cluster Ownership](./query-cluster-ownership.md) exists to prevent: two of the client's own URLs competing, splitting equity, and handing a generative engine a choice the client does not control | Assign the cluster one owner. A new property is justified by a distinct commercial purpose, audience and query territory, or it is not justified |
| 3 | **Fake or incentivised reviews** | Written, bought, or solicited-with-reward reviews; review gating that suppresses negatives | Misrepresents customer experience to a buyer. Illegal in many jurisdictions as unfair commercial practice, independent of any platform policy, and platform removal is retroactive | Ask every customer, reward none, gate nothing, and reply to negatives in public. Volume comes from asking systematically |
| 4 | **Manipulative link acquisition** | Bought links, PBNs, reciprocal schemes, mass guest-post placement, comment and directory spam, anchor-text-for-hire | Links are supposed to be evidence of someone else's judgement. Bought ones are evidence of a transaction, and the whole class is devaluable retroactively — the risk survives long after the spend | Earn citations with things worth citing: original data, tools, primary research, genuine partnerships. See `monitor/backlink-analyzer/` for the quality read |
| 5 | **Fabricated citations, statistics or quotes** | A statistic with no source, a source that does not say it, an invented expert, a fabricated case study or testimonial, a made-up date | It is false. It is trivially checkable by the reader, it is the fastest way to lose an authority position that took years to build, and it puts the client's name behind a claim they cannot defend — the exact opposite of what the rest of this work is for | Cite a primary source with its date, or drop the claim and say what would establish it. Every figure in this library carries its derivation for this reason |
| 6 | **Hidden content and cloaking** | Text hidden by CSS, colour, or off-screen positioning; keyword-stuffed alt or meta content; content served to crawlers that differs from what users see; schema describing content not on the page | The reader and the engine are shown different things, which is a misrepresentation whichever one is misled. Schema mismatch additionally invalidates the markup | If it is worth saying, it is worth showing. Structured data describes what is actually on the page — settled ruling R2 |
| 7 | **Undisclosed AI-generated content at scale** | Bulk-generated pages published without human subject-matter review, no author accountability, no editorial pass | Nothing verifies the claims, so entry 5 arrives by accident and at volume. The accountability gap is itself the defect — CORE-EEAT scores it | Generation is a drafting tool with a named human reviewer and a stated review step. The library's own outputs carry the same requirement |
| 8 | **Scraped, spun or translated-without-review content** | Competitor content reworded; machine translation published unreviewed | Adds nothing a reader could not get from the original, and machine translation into Greek produces exactly the calques the anti-slop ruleset rules FAIL-grade | Original substance. Translation is a first draft that a native reviewer signs off — see the Greek editor protocol |
| 9 | **Guaranteed-outcome promises** | "We will get you into ChatGPT's answers", "guaranteed position 1", a fixed AI-ranking commitment | No engine publishes citation criteria, none guarantees determinism, and generated answers vary run to run. The promise is a claim about a mechanism nobody has documented | State the mechanism as a working model, the leading indicator, the baseline and the measurement plan. [AI Visibility Measurement](./ai-visibility-measurement.md) §7 |
| 10 | **Expired-domain and redirect appropriation** | Buying expired domains for their links; redirecting an unrelated acquired domain into the money site; parasite hosting on a borrowed authority domain | The authority was earned by content that no longer exists, for an audience that is not this one. Devalued when detected, and the redirect is the evidence | Build the authority on the property that will carry it |
| 11 | **Credentials or personal data written into a file the library controls** | A password, API key, service-account private key, OAuth token or shared admin login pasted into an auto-loaded context file, a `memory/` note, a report, a config file or a commit; a person's home address, personal mobile, ID number, or health or financial detail recorded because it was to hand | The value is then at rest in plain text in a directory that is normally version-controlled, so **deleting it later does not unpublish it** — it survives in history, and rotation becomes the only real remediation. An auto-loaded file reaches every session and everyone on the project, not just whoever the credential was issued to. A **shared login additionally destroys the audit trail**: once two people share one account, no change in the CMS, the analytics property or the search console can be attributed to a person, and that loss outlasts the engagement. Personal data kept for convenience is kept for a purpose its owner never agreed to | Record **that** the credential exists, **who** holds it, and **which** secret store or password manager it lives in, plus who grants access — never the value, and never an echo of a value already pasted into the conversation. Treat an already-pasted value as exposed: say so and say it needs rotating. For personal data, name what was asked for and leave the decision with the person it belongs to. **Moving the value to a `.env`, a gitignored file, or "a different file" is not compliance** — the rule is that the library does not write it anywhere |

---

## 2. When the Client Already Has One

Finding a prohibited tactic in an existing setup is a normal audit result, and it is handled the
same way every other risk finding is:

1. **Name it plainly**, in the client's own language, without the jargon and without the lecture.
2. **State the exposure** — what happens if it is found, and what is already being lost.
3. **Give the remediation** with an owner and an acceptance criterion, per
   [Action Output Contract](./action-output-contract.md).
4. **Rank it against everything else.** Most of these are urgent; a stale directory listing from
   2014 is not more urgent than a broken conversion path, and a report that says everything is
   critical has ranked nothing.
5. **Do not build on it.** A recommendation that depends on a prohibited tactic staying in place is
   withdrawn, and the dependency is stated.

**A skill never removes or alters a client's live property on its own initiative.** It reports and
proposes; the client decides and approves.

---

## 3. What This List Is Not

It is not a ban on ordinary competitive practice. Each of the following is legitimate and is
sometimes confused with an entry above:

- **Multiple properties** with genuinely distinct purpose, audience and query territory — the
  portfolio model in [Query-Cluster Ownership](./query-cluster-ownership.md) §4.
- **Location pages** with real, differing content — stock, staff, hours, service area, local
  evidence.
- **Asking customers for reviews**, systematically and without reward or gating.
- **Digital PR and outreach** that earns a link by giving someone a reason to cite you.
- **Comparison content naming competitors**, where the comparison is accurate and the commercial
  relationship is disclosed.
- **Getting listed on comparison and review platforms** — a placement, not a manipulation.
- **AI-assisted drafting** with a named reviewer and a real editorial pass.
- **Translation** with native review.
- **Recording that a credential exists** — which system it opens, who holds it, which secret store
  or password manager it lives in, and who grants access. This is useful project memory and is
  precisely the alternative entry 11 asks for; what is prohibited is the **value**, never the fact.
  "Search Console access — held by the marketing lead, in the company password manager" is a
  complete and correct memory entry.
- **Holding a work contact for a role** — a client's SEO lead, their work email, their job title.
  Entry 11 is about a person's *private* details recorded because they were convenient, not about
  knowing who to send the report to.
- **Naming a credential as a blocker.** "The audit cannot run until someone with Search Console
  access grants it" is a finding with an owner, and stating it is the opposite of the defect.

The distinction throughout is the same one: does a reader end up with an accurate picture, and
would the client be comfortable if the method were described to them in full?

---

## 4. Output Rules

- No deliverable recommends an entry from §1, and no template, example or worked case demonstrates
  one.
- An existing instance is reported per §2 — named, costed, remediated, owned, ranked.
- The prohibition is not itself a deliverable section. A client report does not carry a list of
  things the agency declined to do; it carries findings and actions.
