# Κύμα Swimwear — entity audit: what I can see from my side

**Date:** 2026-08-12 · **Entity:** Κύμα Swimwear, Rhodes · **Domain given:** kyma-swim.example

---

## The honest answer first

**I cannot see any of it.** Not the knowledge panel, not Wikidata, not the mention count, not how ChatGPT
or Perplexity describe you. Every one of your four questions is a question about the live web, and I have
no connection to it in this session: no SEO tool, no brand monitor, no knowledge-graph tool, no AI-visibility
tool. I also cannot query ChatGPT or Perplexity — no model can interrogate another one — and I cannot run a
live search. So the four answers I could give you right now would all be guesses, and a guess in an entity
audit is worse than a blank, because it reads exactly like a finding.

Specifically, and taking them in your order:

| Your question | What I can say |
|---|---|
| "Do we have a knowledge panel?" | **Unknown.** Nobody has looked. An absence here is only reportable once someone has searched and dated the search |
| "Are we in Wikidata?" | **Unknown.** wikidata.org has not been searched for this brand |
| "How many brand mentions are out there, and how many link to us?" | **Unknown, and these are two separate counts** — never one total. No monitoring has been run, and there is no log to count from |
| "How do ChatGPT and Perplexity describe us?" | **Unknown.** Neither has been asked. This one has to be captured by a human, by typing the question and copying the answer back |

**One thing to confirm before anything else:** `kyma-swim.example` reads as a placeholder rather than a
live domain. Send me the real one — every check below runs against it, and a capture done on the wrong
domain is worse than no capture.

---

## The audit skeleton, filled in as far as it can honestly go

This is the report you will have — the shape is already correct, the cells are simply empty, and each one
names the input that fills it. Nothing here is estimated, hedged or marked "typical for a brand this size".

### Entity Profile

**Entity Name**: Κύμα Swimwear *(need the exact strings — see intake item 1)*
**Entity Type**: Brand and/or Organization — **needs your call**, and it changes the signal set
**Primary Domain**: to be confirmed
**Target Topics**: not yet supplied

| Platform | Status | What would settle it |
|----------|--------|----------------------|
| Google Knowledge Panel | Not checked | A dated, logged-out branded-SERP capture |
| Google Business Profile | Not checked | Open the profile and record the fields listed in the capture pack |
| Wikidata | Not checked | A search of wikidata.org on every name form, dated. **QID: left empty** |
| Wikipedia | Not checked | A search of Wikipedia, dated — article *and* mention-inside-an-article are two different answers |
| Google Knowledge Graph API | Not checked | An API response. **Entity ID, types and `resultScore` left empty** — inventing any of those three is the fastest way to make this document unusable |
| Schema.org on site | Not checked | View-source of the homepage and one product page, pasted |

### AI Entity Resolution Test

**This table has no rows, because no AI system has been queried.** I am not listing ChatGPT and Perplexity
with empty cells: a blank row reads as a check that ran and found nothing, which is a different and much
worse claim than "not run". Rows get added for the systems someone actually queries, and for no others.

### Signal Category Summary

All seven categories appear so that none is silently dropped; none can be scored yet.

| Category | Status | Reason |
|---|---|---|
| Structured Data | **Not assessed** | No markup supplied |
| Knowledge Base | **Not assessed** | No Wikidata/Wikipedia/directory check has been run |
| Consistency (NAP+E) | **Not assessed** | No inventory of name, address, phone and description across surfaces |
| Content-Based | **Not assessed** | No page inventory, no About page copy |
| Third-Party | **Not assessed** | No mention log, no reviews data, no coverage list |
| AI-Specific | **Not assessed** | No AI query results, no `robots.txt` |
| Google Business Profile | **Not assessed** | Profile not opened. *(If the label has no premises open to the public, this category is excluded as not applicable rather than failed — tell me which)* |

---

## What to send me, and how to capture it

Roughly two to three hours of your time — that is an estimate of **your work**, not a prediction of when any
search engine or assistant will respond to anything, because nobody publishes those windows.

### 1. The five basics (five minutes, no tools)

1. Every way the brand's name is written: Greek and Latin, with and without accents, the legal entity name
   from the ΓΕΜΗ record, and the διακριτικός τίτλος if one is registered.
2. The real primary domain.
3. Every profile you know exists — Instagram, Facebook, LinkedIn, Google Business Profile, marketplaces,
   stockists, association or directory listings.
4. The three to five topics the brand should be associated with (swimwear is one; the others might be Greek
   manufacturing, sustainable fabric, resortwear, Rhodes).
5. Any name collision you already know about — another business, a place, a product, or an ordinary word.

**Item 5 is the one to think hardest about, and to check first.** If the brand name is shared with anything
else — a beach, a hotel, a boat, another label, an everyday word — then disambiguation is the whole audit,
because every other signal you build is at risk of being attributed to the other thing. Run the bare-name
query before anything else and record what dominates it.

### 2. The branded-SERP capture (thirty minutes)

Record the conditions, then the results. A capture without its conditions cannot be re-run, and a capture
that cannot be re-run tells you nothing the second time:

- **Conditions to write down:** date, location setting, interface language, device, and that you were logged
  out in a private window.
- **Queries:** the brand name; the brand name + "swimwear"; the brand name + "Rhodes"; the bare name on its
  own if it is also an ordinary word; and the Latin and Greek spellings separately.
- **For each:** is there a knowledge panel on the right, and **whose** is it? Then the top 10 organic
  results, typed out. Then whether an AI Overview appeared.

### 3. The AI resolution capture (thirty minutes)

Ask each assistant you can actually reach, once, and paste the answer back verbatim with the date and the
system name:

1. "What is Κύμα Swimwear?"
2. «Τι είναι η Κύμα Swimwear;»
3. "Who is behind Κύμα Swimwear?" / "Where is Κύμα Swimwear made?"
4. "Κύμα Swimwear vs [a label you lose customers to]"

Note which systems you ran and which you did not. Single runs on one day are observations, not a recognition
rate — their value comes from re-running the identical set later, so keep the file.

### 4. The surface inventory (forty-five minutes)

One row per surface, with the name string copied **character-for-character** rather than from memory — the
whole point is to catch the places where it differs by a word or an accent. Columns: surface · name string
as published · address · phone · description first line · founding year stated · does it link back to the
site · last activity.

Cover: the site header and About page, any JSON-LD on the site, Instagram, Facebook, LinkedIn, Google
Business Profile, every marketplace or stockist page, vrisko.gr, xo.gr, and any Rhodes or Greek-fashion
directory. Add the ΓΕΜΗ publicity extract at the end — it settles the legal name, the number and the
inception date, and it is the reference everything else gets measured against. Leave the ΑΦΜ out of the file.

### 5. Structured data and mentions

- View-source of the homepage and one product page: paste every `<script type="application/ld+json">` block.
  Then open every URL inside any `sameAs` list, one at a time, and write down what actually opens — a
  `sameAs` entry is a claim of identity, so a dead or wrong URL is a published falsehood, not just a broken
  link.
- If any brand-mention monitoring exists — even Google Alerts emails — export the window. Every row needs
  the source, the URL, the date, the name form used in the text, and **whether it links to you**. Linked and
  unlinked get counted separately, because they are two different signals and merging them answers neither
  question.

---

## What happens when it lands

I will score all 47 signals across the seven categories above, print the count behind every category status
(points ÷ signals scored), and exclude — by name, with the reason — every signal your inputs cannot settle
rather than marking it failed. You get a critical-issues list, five priority actions ordered by impact and
then by effort, and a roadmap.

Three things you will not get from me, in this or any later version, because nobody can support them:

- **A date for a knowledge panel.** Google documents that panels are created automatically when there is
  enough information available on the open web, describes its sources no more precisely than public sources,
  licensed data and claimant submissions, publishes no timeframe, and states that panel display "isn't
  something we can or would influence". Any date is invented.
- **A cost-per-mention, cost-per-link or ROI figure.** A mention count measures whatever the alert feed
  caught in one window; dividing a budget by it prices the feed, not the work — and it becomes the target
  the moment anyone sees it.
- **Benchmarks against "brands your size".** No input in this engagement measures other brands, and a number
  that arrives from nowhere is the one a reader will check.

Send the real domain and the five basics, and we can start on the capture pack the same day.
