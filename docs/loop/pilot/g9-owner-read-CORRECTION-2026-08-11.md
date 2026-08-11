# G9 / proposal 9b — owner read, CORRECTED

**This corrects, and does not replace, `g9-owner-read-2026-08-11.md`** (committed on branch
`pilot-crawl`). That record's quotations are accurate; its *conclusions* about HowTo are wrong,
because it — and an independent second read from a different machine on a different network —
both missed the same passage in the same source. This file supplies the missed passage, states
what it changes, and stops there. **Nothing here is applied. 9b remains Sani's gated decision.**

Fetched 2026-08-11 from `GIORGOSs-Mac-Studio` (no egress proxy), `HTTP 200`, 619,516 B.

---

## 1. The passage both reads missed

`https://developers.google.com/search/blog/2023/08/howto-faq-changes`, rendered **above** the
article body, immediately under the post date:

> **Update on September 14, 2023**: Continuing our efforts to simplify Google's search results,
> we're extending the How-to change to desktop as well. As of September 13, Google Search no
> longer shows How-to rich results on desktop, **which means this result type is now deprecated.**

> This change will be visible in the metrics for the How-to search appearance in the performance
> report, and in the number of impressions reported in the How-to enhancement reports.

> Since How-to results no longer appear in Google Search, we will be dropping the How-to search
> appearance, rich result report, and support in the Rich results test in 30 days. To allow time
> for adjusting your API calls, support for How-to in the Search Console API will be removed in
> 180 days.

Raw HTML container, verbatim:

```html
<p class="gargardate">Tuesday, August 8, 2023</p>
<aside class="important"><b>Update on September 14, 2023</b>: …
  which means this result type is now deprecated.</aside>
```

## 2. What it changes — the drafted 9b is CORRECT, not falsified

The task that produced this file asked "which primary source falsified the drafted ruling".
**None did.** The honest answer is the opposite of the one expected, and is recorded that way
deliberately: an answer shaped to fit the question would have sent a sound ruling back for
redrafting.

| Claim | Status against the primary source |
|---|---|
| 9b: "HowTo rich results ended in 2023" | **SUPPORTED, verbatim** — "As of September 13 [2023] … this result type is now deprecated." |
| Prior conclusion: "2023 only restricted HowTo to desktop; it did not end it" | **WRONG.** True of the August stage; the same post's September update completes the retirement. |
| Prior conclusion (`g9-owner-read`, obs. 3): the desktop-only limit is "a separate change from any later retirement" | **WRONG.** S1 is the primary source for *both* stages. |
| Prior conclusion (`g9-owner-read`, obs. 2): "S1 is not the source for the 2026 retirement" | **Still TRUE, but only for FAQ.** The September update is HowTo-only and says nothing about FAQ. R3's "FAQ retired in 2026" remains unsourced — that item is untouched by this correction. |

**Two stages, one post, one source.** 2023-08-08 restricted HowTo to desktop; 2023-09-13
removed it from desktop too and deprecated the result type. Quoting only the body yields
stage one and reads as a refutation of stage two.

## 3. What a corrected 9b would say

The **ruling text needs no redraft.** What needs a precision is the **purge scope**, and R3 is
the governing precedent: R3 kept FAQPage generation in the library *after* its rich results were
retired, on the reasoning that the SERP feature and the markup are different things. The same
split applies here, and the source states it in Google's own voice:

> While you can drop this structured data from your site, there's no need to proactively remove
> it.

> Structured data that's not being used does not cause problems for Search, but also has no
> visible effects in Google Search.

So a corrected 9b would read, in substance:

1. **RULE**: HowTo rich results are deprecated. Google stopped showing them on mobile
   2023-08 and on desktop **2023-09-13**, and dropped the search appearance, rich result
   report and Rich Results Test support thereafter. Primary source: S1, including its
   2023-09-14 update. No skill may teach HowTo rich results as an attainable SERP feature.
2. **PURGE — scoped to the SERP-feature claim, not to the markup.** The four loci
   (`serp-feature-taxonomy.md:30` and ~`:291`, `gap-analysis-frameworks.md:150`,
   `ctr-and-social-reference.md:121`) are corrected because they teach a *current SERP
   feature* that does not exist. Whether `HowTo` **schema generation** stays in the library is
   the R3 question, not this one, and 9b should not decide it silently by deleting the type.
3. **Explicitly NOT ruled**: any AI-engine/GEO parsing value for HowTo markup. Asserting it
   would be the exact claim R3-9a retracted for FAQPage (open finding #77), and neither
   designated source addresses it. Silence, not a claim in either direction.

**Not applied.** No locus edited, no ruling written to `SETTLED-RULINGS.md`.

## 4. The method defect — why two independent reads failed identically

Both prior reads extracted the **article body** and dropped `<aside>`. That is standard
readability behaviour: `<aside>` is where sidebars and promo boxes live, so extractors strip it.

But a **deprecation notice is exactly what a vendor puts in `<aside class="important">`.** The
extraction method is therefore biased *against the specific class of fact being asked about*.
A "has X been deprecated?" question answered by body-text scraping returns the pre-deprecation
state — with a genuine verbatim quote attached, which is what makes it survive review.

Two sessions, two machines, two networks, two clients, same wrong answer. Convergence between
independent readers is **not** corroboration when they share a method; it only re-measures the
method's blind spot. Proposed rule, for the coordinator to number:

> When reading a primary source to establish whether something is current, deprecated or
> withdrawn, strip only `script`/`style`/`nav`/`head`. **Never strip `aside`, `callout`,
> `banner`, `admonition` or `note` containers** — status changes are announced there. Grep the
> raw HTML for `update`, `deprecat`, `no longer`, `sunset`, `retired` before concluding.

## 5. Effect on W12

W12's resolve-condition is met and its stated grade caveat is discharged:

- W12 recorded the September update at **search-index snippet grade** and flagged that "the year
  on the 'As of September 13' note is contextually 2023 but not independently pinned."
  **Now pinned by owner read**: the banner reads "Update on **September 14, 2023**".
- W12 also flagged "WebFetch is egress-restricted for `developers.google.com`, so the quotes are
  search-index returns over the primary domain, not owner-read verbatim." **Discharged** — this
  read is owner-read verbatim from an unrestricted network, and the snippet-grade wording W12
  recorded matches the page exactly.

W12 moves `[VERIFY]` → **resolved-primary**. It does **not** move to closed: closing W12 depends
on Sani's G9 verdict, which is still open.

## 6. Effect on the earlier record

`g9-owner-read-2026-08-11.md` (branch `pilot-crawl`) should carry a pointer to this file.
Its quotations stand; observations 2 and 3 are corrected above. It is **not withdrawn** — it is
the record of what those two URLs' article bodies say, and that remains true.
