# AI Overview Recovery Playbook

Diagnose and repair pages that keep their rankings but lose clicks to a Google AI Overview
shown above the organic results. Ported concept from the G4 upstream harvest (Apache-2.0
source line; verdict 2026-08-08) — all wording original. Every numeric threshold in this
file is a **house operational default** (tunable per site and market), not a measured fact.

## Trigger Profile

Suspect AI Overview displacement — rather than ordinary content decay — when ALL of the
following hold (defaults tunable):

| Signal | House default | Where to look |
|--------|---------------|---------------|
| CTR drop | Down 20-60% on ≥5 queries | Search Console query report |
| Window | Sustained over 2-4 weeks | 28-day compare |
| Impressions | Flat or rising while clicks fall | Search Console |
| Rankings | Held (top-3) yet clicks reduced | Rank tracker / GSC average position |
| SERP | AI Overview visible above the organic results | Live SERP check |

If rankings ALSO fell, this playbook is the wrong tool — diagnose the ranking loss first
via the ordinary decay path in [content-decay-signals.md](./content-decay-signals.md).

## Diagnostic Sequence

1. **Search Console 28-day compare.** Filter for queries where CTR change < −20% AND
   impressions change > −10%. These are the displacement candidates.
2. **Live SERP check per candidate query.** Record three facts: Is an AI Overview present?
   Is the site cited in it? Is the citation visibly placed (shown without expanding) or
   buried?
3. **Segment the candidate queries into four cases:**

   | Case | Meaning | Priority |
   |------|---------|----------|
   | Cited by the Overview | You already appear; some clicks recoverable | Low — improve citation placement |
   | Overview present, site not cited | The Overview answers "your" query without you | High |
   | Overview citing a competitor | Analyze what their cited page has that yours lacks | High |
   | No Overview, clicks still down | Intent shift or another cause — not this playbook | Re-diagnose as a ranking/intent problem |

4. **Answerability audit** (high-priority cases): does a direct answer appear within
   roughly the first 100 words? Do subheadings mirror how the queries are phrased?
5. **Freshness audit**: visible published/updated dates; cited sources from the last
   12 months.
6. **E-E-A-T audit**: author credentials shown; entity presence (author and brand
   recognizable as entities); external corroboration of the page's key claims.

## Remediation Order

Work top to bottom; re-measure between stages rather than shipping everything at once.

1. **Answer-first rewrite.** Open with a bolded direct answer of roughly 30 words or
   fewer; follow with a two-sentence expansion carrying at least one specific anchor (a
   number, a proper noun, or a date); structure the rest of the page under jump-linked
   H2s so each subtopic is independently addressable.
2. **Standalone quotable sentences.** Add sentences that each make one specific, sourced
   claim and survive being lifted out of context — these are what engines quote.
3. **FAQ section.** Answer the affected queries' people-also-ask variants in 40-60-word
   answers. **R2 rule — read before touching markup**: the FAQ *content* is the port
   here. FAQPage *markup* is added ONLY if the page genuinely passes the R2 both-things
   test — the page truly is both its primary type and an FAQ resource, and each type is
   complete, accurate, and independently justified. Otherwise: add the FAQ content and
   change no schema. (Per R3, FAQPage markup — where justified — is kept only because it
   is valid schema.org and there is no need to remove it. Claim no AI-parsing benefit:
   none is established either way, and Google states structured data is not required for
   its generative AI surfaces. Google's FAQ rich results are retired, so promise no SERP
   feature. On this playbook in particular, adding markup is not a recovery lever — the
   remediation that moves an Overview is the answer-first rewrite in step 1.)
4. **Structured data check.** Existing markup must state only genuine claims and keep one
   primary content type per page (R2). This step never adds types to chase citations.

## Verification Ladder

| Checkpoint (house default) | What to check | Progress looks like |
|----------------------------|---------------|---------------------|
| ~T+7 days | Overview state per query | Overview present/absent state recorded; content shifting toward your framing |
| ~T+14 days | Citation appearances | Site cited in ≥1 previously-uncited query's Overview |
| ~T+28 days | CTR vs the pre-drop baseline | Majority of the pre-drop CTR level recovered (tunable target) |

No movement by ~T+28 → re-run the diagnostic sequence; if the case mix is unchanged,
apply the stop rules below.

## Stop Rules

Stop iterating (or reroute the effort) when any of these hold:

- **The lost traffic was low-value.** The affected queries would not be targeted today on
  their own merits — deprioritize and move on.
- **Authority mismatch.** The Overview cites 3+ established competitors and the site's
  authority is materially lower — any authority score used for this comparison is a
  **directional vendor metric, not a fact**. Route to entity/authority building FIRST:
  hand off to [entity-optimizer](../../../cross-cutting/entity-optimizer/). Content
  edits will not outrun an authority gap.
- **Competitors cited on branded queries.** A competitor cited in the Overview for YOUR
  branded queries signals an entity/knowledge-graph gap, not a content gap — hand off to
  [entity-optimizer](../../../cross-cutting/entity-optimizer/).

Handoff payload (library convention): target queries, the four-case segmentation result,
the page URL, and — where a quick assessment was run — its weak dimensions as a focus set,
labelled as the partial-scan estimate they are. **A quick score is not a CORE-EEAT dimension
score and never travels as one**: with no 80-item audit on the page, the payload says exactly
that ([inter-skill-handoff.md](../../../references/inter-skill-handoff.md) §2.1, §4.3).
