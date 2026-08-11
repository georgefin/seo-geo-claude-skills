# G9 owner read — Google on HowTo / FAQ rich results

Fetched 2026-08-11, both `HTTP 200`, via `curl` from the "Custom 1" environment.
Every passage below is **quoted verbatim** from the article body and re-verified against the
raw HTML after extraction. Nothing here is paraphrased — the point of this record is to
replace second-hand evidence with the owner's own words, and a paraphrase would destroy it.

## Sources

| # | URL | `<title>` | Canonical (as declared) | Byline / date |
|---|---|---|---|---|
| S1 | `https://developers.google.com/search/blog/2023/08/howto-faq-changes` | Changes to HowTo and FAQ rich results \| Google Search Central Blog \| Google for Developers | `https://developers.google.com/search/blog/2023/08/howto-faq-changes` | "Posted by John Mueller, Search Advocate, Google Switzerland" — dated **Tuesday, August 8, 2023** |
| S2 | `https://developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing` | A new resource for optimizing for generative AI in Google Search \| Google Search Central Blog \| Google for Developers | `https://developers.google.com/search/blog/2026/05/a-new-resource-for-optimizing` | "Posted by John Mueller, Google Search" — dated **Friday, May 15, 2026** |

---

## (a) What changed for HowTo rich results, and when

**S1**, opening paragraphs:

> To provide a cleaner and more consistent search experience, we're changing how some rich
> results types are shown in Google's search results.

> In particular, we're reducing the visibility of FAQ rich results, and limiting How-To rich
> results to desktop devices.

> This change should finish rolling out globally within the next week.

**S1**, under "Overview of the changes":

> For site owners, these changes primarily affect the use of FAQ and How-To structured data.

> How-To (from HowTo structured data) rich results will only be shown for desktop users, and
> not for users on mobile devices.

> Note that with mobile indexing, Google indexes the mobile version of a website as the basis
> for indexing: to have How-To rich results shown on desktop, the mobile version of your
> website must include the appropriate markup.

**Timing**, verbatim from S1:

> This update is rolling out globally, in all languages and countries, over the course of the
> next week.

> This should not be considered a ranking change and won't be listed in the Search status
> dashboard.

> Note that there will be a small holdback experiment, so some users may not see these
> changes right away.

Post date is **2023-08-08**, so "within the next week" runs from that date.

**S2 says nothing about HowTo.** Verified by search of the S2 article body: zero occurrences
of "HowTo" as a structured-data reference (the one `how to` match is ordinary prose —
"understand how to optimize their content"), zero occurrences of "FAQ", zero occurrences of
"structured data".

## (b) What changed for FAQ rich results, and when

**S1**, under "Overview of the changes":

> Going forward, FAQ (from FAQPage structured data) rich results will only be shown for
> well-known, authoritative government and health websites.

> For all other sites, this rich result will no longer be shown regularly.

> Sites may automatically be considered for this treatment depending on their eligibility.

Same rollout timing as (a) — the two changes shipped in one announcement, dated
**2023-08-08**, "within the next week", with the same holdback experiment caveat.

**S1**, on Search Console reporting:

> For both of these items, you may also notice this change in the Search Console reporting
> for your website.

> In particular, this will be visible in the metrics shown for FAQ and How-To search
> appearances in the performance report, and in the number of impressions reported in the
> appropriate enhancement reports.

> This change does not affect the number of items reported in the enhancement reports.

> The search appearances, and the reports, will remain in Search Console for the time being.

**S2 says nothing about FAQ.** Same verification as (a).

## (c) Does Google say owners must remove existing FAQPage or HowTo structured data?

**No.** S1 states the opposite, explicitly:

> While you can drop this structured data from your site, there's no need to proactively
> remove it.

> Structured data that's not being used does not cause problems for Search, but also has no
> visible effects in Google Search.

That is the entirety of what S1 says on removal. Two things are worth separating inside it,
since both are the owner's own words: removal is **permitted** ("you can drop this"), and
removal is **not required** ("no need to proactively remove it"). There is no deprecation
notice, no deadline, and no penalty language anywhere in S1.

**S2 says nothing about removing structured data** — no mention of removal, FAQPage, HowTo,
or structured data in any form.

---

## What S2 actually covers

S2 was fetched because the task named it; on the HowTo/FAQ question it is silent. For the
record, its substance, verbatim:

> As people increasingly gravitate to generative AI experiences and find information in new
> ways, we're publishing a new resource to help website owners, SEOs, and developers
> understand how to optimize their content for appearance in generative AI features in
> Search, and in turn Google Search overall.

> In the new guide, optimizing your website for generative AI features on Google Search,
> you'll find:

>   * Guidance on the importance of providing valuable, unique, non-commodity content
>   * Tips about providing local, shopping, image, and video content
>   * Mythbusting common "AEO/GEO" misconceptions
>   * Initial guidance related to AI agents, a quickly emerging and evolving space
>   * Information about why SEO best practices remain relevant and foundational to success
>     with our generative AI features

The guide it announces is linked as `/search/docs/fundamentals/ai-optimization-guide`
(i.e. `https://developers.google.com/search/docs/fundamentals/ai-optimization-guide`).
**That guide was not fetched** — it is outside the two URLs this task authorised. It is the
obvious next owner read.

---

## Observations (not rulings)

Recorded because they bear on `SETTLED-RULINGS.md` R3, and flagged as observations because
adjudicating them is not this run's job:

1. **R3's core decision is directly supported by the owner's own words.** R3 keeps FAQPage
   generation in the library; S1 says in Google's voice that there is "no need to proactively
   remove it" and that unused structured data "does not cause problems for Search". The
   keep-it decision now rests on a primary source rather than on second-hand reporting.

2. **A date discrepancy worth a look.** R3 states "Google retired FAQ rich results in 2026
   (Search Console reporting, API, Enhancements appearance filter, and Rich Results Test
   support all cut)". S1 is a **2023-08-08** *reduction* — FAQ rich results narrowed to
   "well-known, authoritative government and health websites", with Search Console reporting
   explicitly retained ("will remain in Search Console for the time being"). These are
   compatible as two stages of one arc — a 2023 narrowing, then a later full retirement — but
   **S1 is not the source for the 2026 retirement**, and neither is S2. If R3's 2026 claim is
   meant to be primary-sourced, its citation is still outstanding. This run neither confirms
   nor refutes the 2026 retirement; it establishes only what these two pages say.

3. **The HowTo desktop-only limitation (2023) is a separate change from any later
   retirement**, and S1 is the primary source for it.
