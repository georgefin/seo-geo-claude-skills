# Browser verification pack — five checks, about ten minutes

**For Sani. No technical knowledge needed. You need a web browser and ten minutes.**

Every step is the same three moves: **open a link, search the page for an exact word, write down
what you see.** You do not need to understand what any of it means. You are the only person who
can do this, for one boring reason: these checks need an ordinary browser on an ordinary
connection, and the machines this project runs on do not have one. Yours does.

---

## Start here if you only have three minutes

**Do Check 1 and nothing else.** Check 1 is the one that matters. Six dated statements that
currently sit in our written material all trace back to that single page — and nobody has ever
opened it. Not you, not any of the automated runs, nobody. Every other check in this pack is a
supporting detail next to that.

Checks 2 to 5 are worth doing. Check 1 is worth doing on its own.

---

## Before you start — four small things

1. **Open a private window** (Chrome: File → New Incognito Window. Safari: File → New Private
   Window. Edge: New InPrivate window). This just makes sure you see the ordinary public version
   of each page rather than anything shaped by your own history.
2. **Do not sign in** to anything.
3. **"Search the page"** means: press **Ctrl-F** (on a Mac, **Cmd-F**), type the text we give
   you, press Enter. The browser jumps to it and usually shows a count like `1/7`. If it finds
   nothing it will say so, or show `0/0`.
4. **Type the search text exactly as we print it**, including any missing letters at the end.
   `deprecat` is deliberately cut short — it catches *deprecated*, *deprecation* and
   *deprecating* in one search. That is not a typo.

### Paste the words, do not summarise them

When a check asks for the sentence, **select it with your mouse, copy it, and paste it in.**
Do not retype it and do not describe it.

This is the whole point of the exercise, so it is worth one honest paragraph. This pack exists
because somewhere back in the chain, an automated research step read something and returned a
*summary* of it instead of the words. The summary was passed along, then written down, then
quoted, then treated as settled fact — four steps, and by the end nobody could check it, because
the original words were gone. If you send us summaries, we will have done the same thing again,
just slower. **Copied text can be re-checked by anyone forever. A summary cannot be re-checked
by anybody, including you, an hour later.**

### What we honestly do not know

Stated plainly, because it changes how you should read the checks:

- **Nobody has ever opened the page in Check 1.** We do not know what is on it. We do not know
  whether it is laid out the way we describe below. Our description is an expectation, not
  something anyone here has seen.
- **We cannot tell whether the original research ever really read a page, or produced a
  convincing-sounding summary from an older page.** No record survives from before the point
  where a person copied the summary down by hand. Those two possibilities look identical from
  here. Your Check 1 is what separates them.
- **We do not know whether these five web addresses are still the right ones.** Documentation
  sites get reorganised. That is why every check has a "what if the page has changed" branch —
  see the section near the bottom, and use it.
- **We are not going to tell you what we expect you to find.** Not on any check. If we told you,
  you would find it, and the pack would be worthless. Every check below reads exactly the same
  whether the answer turns out to be yes or no.

---

# CHECK 1 — the Google changelog page

**About four minutes. This is the decisive one.**

**What this check decides, in plain terms:** six statements in our material describe changes to
a Google search feature and give them specific 2026 dates. This page is where those six
statements are supposed to have come from. **If the entries are there, all six are correct,
properly sourced at last, and stay exactly as they are. If they are not there, all six were
never sourced by anyone, and every one of them has to come out of anything a client reads.**

**How much material this touches** *(counted at the shell on 2026-08-13, not estimated — an
earlier internal note said "roughly fourteen places across six tools" and undercounted by about
half)*:

- **28 lines across 14 files** say some version of *"FAQ rich results ended in 2026"*. This is
  the broad claim, and it is everywhere.
- **5 lines across 3 files** carry the specific dated events — the search appearance dropped,
  the Search Console report dropped, the testing-tool support dropped, the API cut scheduled for
  August 2026. These are the load-bearing ones and they are concentrated, which is good news:
  if your answer is "not there", the sharp edges are in three files, not fourteen.

The rest of the 28 would soften rather than vanish — from "ended in 2026" to the one thing we
can actually source, which is that Google restricted the feature to government and health sites
in August 2023.

### Open this link

```
https://developers.google.com/search/updates
```

This is Google's own running list of changes to its search documentation — a "changelog", which
is just a dated diary of what they altered and when.

### First: open up the entries

We expect this page to group its entries under **month headings** (like "May 2026", "June 2026")
that are **folded shut** until you click them. A closed section may hide its text from the
browser's search, so the search would report nothing even if the words are right there.

**So before searching: scroll down the page and click every month heading you can see for 2026,
so the entries underneath unfold.** If there is a year selector or a "2026" filter in a sidebar,
use it. If nothing on the page folds or unfolds — if it is just a long list — that is fine, skip
straight to the searches.

### Then search the page for each of these, one at a time

Type each exactly. After each one, note the count the browser shows.

| # | Search for this exactly | Count you see |
|---|---|---|
| 1a | `FAQ` | |
| 1b | `rich result` | |
| 1c | `deprecat` | |
| 1d | `FAQPage` | |
| 1e | `May 2026` | |
| 1f | `June 2026` | |
| 1g | `August 2026` | |
| 1h | `Search Console API` | |
| 1i | `How-to` | |

### What to write down

- The count for each of the nine searches (`0` is a real and useful answer).
- **For any search that finds something: paste the whole entry it lands in** — the date heading
  above it and the full paragraph. Not your description of it. If a word appears several times,
  paste each one, or at minimum the ones that mention a date.
- The earliest and latest dates you can see anywhere on the page, whatever they are. This tells
  us how much of the page you were actually looking at.

→ Record under **CHECK 1** in the form at the bottom.

---

# CHECK 2 — is one particular Google page still there?

**About one minute.**

**What this check decides:** one of our records claims Google deleted its documentation page for
this feature. That claim never made it into our official written rulings, but it has been used
as supporting evidence for the six statements in Check 1. **If the page is gone, that is
independent support for Check 1's six statements. If the page is still there and looks
ordinary, it substantially weakens all six** — which would matter even if Check 1 came back
empty.

### Open this link

```
https://developers.google.com/search/docs/appearance/structured-data/faqpage
```

### What to do

1. Wait for it to settle, then **copy the web address out of the address bar exactly as it now
   reads.** If the site sent you somewhere else, the address will have changed, and that is
   itself an answer.
2. **Copy the big heading at the top of the page.**
3. If there is any coloured strip, banner or boxed notice near the top, **paste its full text.**
4. Search the page for: `deprecat` — then `no longer` — then `2026`. Note each count, and paste
   the sentence around any hit.
5. If instead you get an error page, **paste the largest text on that error page word for word**
   (pages say different things — "Not found", "We couldn't find that page", and so on — and the
   exact wording matters to us).

→ Record under **CHECK 2** in the form at the bottom.

---

# CHECK 3 — one sentence we quote but have never seen

**About two minutes.**

**What this check decides:** our material contains one sentence that we attribute to this Google
page, about what website owners need to do for Google's AI features. It is used to justify a
recommendation we give. Nobody here has ever opened this page. **If the sentence is on the page,
we can keep quoting it — with its exact wording corrected to match. If nothing like it is there,
we are attributing words to Google that Google may not have written, and the recommendation
resting on it has to be rewritten.**

**We are deliberately not showing you our version of the sentence before you look.** If we did,
you would recognise it and confirm it, and we would learn nothing. Please paste whatever the
page actually says, even if it seems to be about something else entirely.

### Open this link

```
https://developers.google.com/search/docs/fundamentals/ai-optimization-guide
```

### Search the page for each of these

| # | Search for this exactly | Count you see |
|---|---|---|
| 3a | `structured data` | |
| 3b | `schema.org` | |
| 3c | `machine readable` | |
| 3d | `AI text files` | |
| 3e | `FAQPage` | |

### What to write down

- The count for each.
- **For every hit, paste the complete sentence it sits in** — from the capital letter to the full
  stop, and if it is inside a bulleted list, paste the whole bullet. If a sentence contains two
  or three of these phrases at once, one paste covers them; just say so.
- If the page does not load, say so and copy the address bar.

→ Record under **CHECK 3** in the form at the bottom.

---

# CHECK 4 — one word on a page we have already read

**About one minute. The easiest check in the pack.**

**What this check decides:** we have already read this 2023 page in full, so this is a
single-word confirmation rather than an investigation. Three places in one of our tools quote
this page as saying something specific about a September date. Our own reading of it did not
record that. **If the word "September" appears here in that context, those three passages are
correct. If the word does not appear on the page at all, those three passages attribute to this
page something it does not say, and they get corrected** — and a change to four further files,
currently held and waiting, gets unblocked either way.

### Open this link

```
https://developers.google.com/search/blog/2023/08/howto-faq-changes
```

### Search the page for each of these

| # | Search for this exactly | Count you see |
|---|---|---|
| 4a | `September` | |
| 4b | `no longer shows` | |
| 4c | `30 days` | |
| 4d | `180 days` | |

### Your control search — do this one too

| # | Search for this exactly | Count you see |
|---|---|---|
| 4e | `reducing the visibility of FAQ rich results` | |

We know from a previous reading that **4e is on this page.** So if 4e comes back `0`, you are not
looking at the page we mean — something has moved, and none of 4a–4d should be trusted. Say so
and stop. If 4e finds its text, the page is the right one and your other four answers stand,
zero or not.

→ Record under **CHECK 4** in the form at the bottom.

---

# CHECK 5 — is a second Google page still there?

**About one minute. The least decisive check — skip it if you are short of time.**

**What this check decides:** four places in our material give guidance about a different Google
search feature, and that guidance assumes its documentation still exists. **If the page loads,
those four
passages keep their footing. If it is gone, they need review** — this does not settle the
question on its own, it only points at it.

### Open this link

```
https://developers.google.com/search/docs/appearance/structured-data/how-to
```

Same three moves as Check 2: **copy the address bar after it settles, copy the big heading at the
top, and paste the text of any banner or notice.** If you get an error page, paste its largest
text word for word.

→ Record under **CHECK 5** in the form at the bottom.

---

## What if the page has changed?

This matters more than it sounds. **"I searched and found nothing" has two completely different
meanings**, and telling them apart is most of this pack's value:

- **The claim isn't there** — you were looking at the right page, properly opened, and the words
  simply are not on it. That is a real finding and it settles things.
- **You were looking at the wrong thing** — the page moved, or it loaded only halfway, or the
  part you needed was folded shut. That finds nothing too, and means nothing at all.

Treating the second as if it were the first is how a page reorganisation turns into a false
conclusion. So, three ways to tell them apart:

**1. Does the page have *any* content of the kind you expect?** On Check 1's changelog, the test
is other months. If you can see dated entries for various months — 2024, 2025, whatever — then
the page is working and loaded, and an absence of 2026 entries is a real answer. **But if you see
no dated entries at all, for any month, you are looking at the wrong view of the page** — perhaps
a landing page, perhaps a page that has not finished loading. That is not "not found". Write
**"page did not load properly"** and say what you did see.

**2. Did the address change?** After each page settles, glance at the address bar. If it no longer
matches the link you clicked, you have been redirected somewhere else, and anything you search
for is a search of a different page. Copy the new address; it is useful evidence on its own.

**3. Try once more, differently.** If a page fails: reload it once; if it still fails, try it in
a normal (non-private) window; if it still fails, try your phone on mobile data rather than
office wifi. If all three fail, that is a genuine answer — write **"page did not load"** and move
on. Do not guess at what would have been on it.

**Any of these outcomes is a good result to send back.** "Page did not load" is information.
A guess is not.

---

## The form

Copy everything between FORM START and FORM END into your reply, fill in the blanks, and send it.
Leave anything you did not do as it is — a partly filled form is useful; a form padded out with
guesses is not.

```
# FORM — blanks are yours to fill in. Nothing here is a value; it is an empty answer sheet.

FORM START
Date and time I did this: ______________
Browser used: ______________   Private window? yes / no

CHECK 1 — changelog page
  Page loaded?  loaded / did not load / loaded but looked wrong
  Did I unfold the month sections?  yes / no / there were none to unfold
  Earliest date visible anywhere on the page: ______
  Latest date visible anywhere on the page:   ______
  Counts:  FAQ ___   rich result ___   deprecat ___   FAQPage ___
           May 2026 ___   June 2026 ___   August 2026 ___
           Search Console API ___   How-to ___
  PASTED TEXT (every entry any of the above landed in, date heading included):
  ---
  (paste here)
  ---

CHECK 2 — FAQ documentation page
  Page loaded?  loaded / error page / did not load
  Address bar after loading: ______________________________
  Heading at top of page: ______________________________
  Counts:  deprecat ___   no longer ___   2026 ___
  PASTED TEXT (any banner or notice, plus the sentence around each hit,
               or the largest text on the error page):
  ---
  (paste here)
  ---

CHECK 3 — AI guide page
  Page loaded?  loaded / error page / did not load
  Address bar after loading: ______________________________
  Counts:  structured data ___   schema.org ___   machine readable ___
           AI text files ___   FAQPage ___
  PASTED TEXT (the full sentence or bullet around every hit):
  ---
  (paste here)
  ---

CHECK 4 — 2023 blog page
  Page loaded?  loaded / error page / did not load
  Control search "reducing the visibility of FAQ rich results": count ___
    (if this is 0, stop — wrong page, and ignore the rest of Check 4)
  Counts:  September ___   no longer shows ___   30 days ___   180 days ___
  PASTED TEXT (the sentence around every hit):
  ---
  (paste here)
  ---

CHECK 5 — How-to documentation page
  Page loaded?  loaded / error page / did not load
  Address bar after loading: ______________________________
  Heading at top of page: ______________________________
  PASTED TEXT (any banner or notice, or the largest text on the error page):
  ---
  (paste here)
  ---

Anything odd I noticed that these questions did not ask about:
  ---
  (paste here)
  ---
FORM END
```

---

## After you send it

Nothing in our written rulings changes until you say so — that decision is yours and this pack
does not pre-empt it. What your answers do is remove the reason the decision is currently stuck:
five of the open questions can only be answered from a browser outside our network, and there is
exactly one of those in this building.

---

*Not part of your ten minutes — for whoever files the answers.* The egress fact behind this
pack, stated once with its evidence rather than asserted in the reader's second paragraph:
`developers.google.com` is refused to this environment `[obs:2026-08-11T03:40:00Z curl +
WebFetch, both refused at the gateway]`. The reader-facing line above says the same thing in
plain language and deliberately carries no apparatus — same reader test the library applies to
`~~category` tokens and framework item IDs. This pack executes the
browser-settleable rows of the K1–K8 unknowns table in `docs/loop/r3-supersession-candidate.md`
§5. Check 1 = K1 (and covers K4's first half); Check 2 = K6; Check 3 = K2; Check 4 = K3;
Check 5 = K4's second half. K5 is moot unless Check 1 confirms the timeline; K7 and K8 are not
browser-settleable. File the returned form as a dated record alongside the 2026-08-11 owner read,
verbatim and unsummarised, before any register is touched. Raised 2026-08-13. This file proposes
no edit to any register; `SETTLED-RULINGS.md` and `GATED-ITEMS.md` remain reserved to the gate.
