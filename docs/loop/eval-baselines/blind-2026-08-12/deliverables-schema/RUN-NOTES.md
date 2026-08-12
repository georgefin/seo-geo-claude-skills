# Run notes — `build/schema-markup-generator`

## 1. Blindness (§1.1 and §1.2)

Both held for the whole run. Stated as fact, not as intention:

**§1.2 — Grep and Glob.** I made **zero** Grep calls and **zero** Glob calls, for any purpose, at any
point. Not on an allowed path, not to locate a filename. Every file I opened, I opened with `Read` on
a path I already had from the brief or from the skill itself.

**§1.1 — banned files.** I did not open, and did not read any content from:

- any `evals.json`, anywhere;
- anything under `docs/` — I never listed that tree, never read a file in it, and never resolved a
  pointer into it (SKILL.md cites `docs/loop/SETTLED-RULINGS.md` for rulings R2 and R3; logged as
  A1 in `AMBIGUITIES.md` and not followed);
- any file whose name contains `provenance`;
- `VERSIONS.md`;
- git history of any kind. I ran **no git command at all** — not `log`, `show`, `diff`, `blame`,
  `status`, nothing — and did not inspect `.git/`.
- any other file in the brief's own scratchpad directory. I read `brief-schema-markup-generator.md`
  and nothing else from there. `CENSUS.md`, `analysis.json`, `final.json` and `analyze.py` were
  never opened and never listed.

**One thing to disclose precisely, because it is the closest I came to a line.** I ran `ls -la` on
four directories, which the brief permits explicitly (§1.2: *"use `ls` (via Bash) when you need to
see what is in a directory"*). One of them was
`build/schema-markup-generator/evals/`, and that listing displayed the filename `evals.json` with its
size (21690) and mtime. I did not open it, did not infer anything from it, and did not adjust any
deliverable because of it. I mention it because §1.1 bans "listing-and-inferring" and I want the
listing on the record even though no inference followed. I deliberately did **not** `ls` the
repository root, since that would have surfaced `docs/` and `VERSIONS.md` as names; instead I ran
`ls` against the two cited file paths individually to confirm they existed.

**Files I read, in full, and why each was in scope:**

| File | Why |
|---|---|
| the brief | run instructions |
| `build/schema-markup-generator/SKILL.md` | the artefact under test |
| `references/schema-decision-tree.md` | brief §2 — read every file in `references/` |
| `references/schema-templates.md` | as above |
| `references/validation-guide.md` | as above |
| `CONNECTORS.md` (repo root) | brief §2 — the skill's Data Sources section sends you there; needed to resolve the `~~web crawler` / `~~schema validator` tokens the output-validation rule bans from client surfaces |
| `references/core-eeat-benchmark.md` (repo root) | brief §2 — SKILL.md step 1 sends you there for item O05 on every request |
| the five fixtures in `evals/files/` | brief §3 — the client's page copy |

No network access was used. No `WebFetch`, despite it being the skill's one declared tool — correctly
so: the skill's own fetch rule says do not fetch when the copy is supplied and do not fetch a URL that
is merely where the markup will be installed, and all five requests are exactly that case. No
credentials were sought or used. Nothing was written inside the repository.

## 2. Order of work

Strictly 1 → 5, with each deliverable written to disk before the next fixture was opened.

1. Read brief → created the output directory → read SKILL.md and all three references → read
   CONNECTORS.md and core-eeat-benchmark.md.
2. Read fixture 1 → wrote `e1-out.md` → validated its JSON.
3. Read fixture 2 → wrote `e2-out.md` → validated. *(fixture 2 was not opened until e1 was on disk)*
4. Read fixture 3 → wrote `e3-out.md` → validated, plus a byte-exact match check of all four Q&A
   pairs against the fixture.
5. Read fixture 4 → checked the fixture's own date claim → wrote `e4-out.md` → validated.
6. Read fixture 5 → confirmed the supplied JSON-LD genuinely fails to parse → wrote `e5-out.md` →
   validated.
7. Wrote `AMBIGUITIES.md`, then this file.

**One edit after initial save, disclosed in full.** `e1-out.md` was written, then edited once — before
fixture 2 was opened — to replace a truncated-but-syntactically-valid JSON fragment in the
implementation guide's Option 1 example with a non-pasteable placeholder line, matching the shape the
skill's own step-3 template uses. Reason: a valid-looking partial block sitting under a heading that
says "add this to your page" is something a client can paste by mistake. No other deliverable was
revised after being saved, and none was revised after a later request began.

**A scratch file is present in the output directory.** `_check.py` (underscore-prefixed) is a small
helper I wrote to parse every fenced `json` block in each deliverable and assert it is valid JSON,
and to assert that no `_SKELETON` marker, `~~category` token, `TBD`, or SCREAMING-KEBAB bracket slot
survives in any finished file. All five deliverables pass both. It is not a deliverable; I have left
it in place rather than deleting it so the verification is inspectable.

## 3. Things about the fixtures the next reader should know

**Every one of the five fixtures withholds an image URL, and three of the five types need one.**
Product treats `image` as required, Article treats it as required, Event treats it as recommended.
The consequence in fixture 2 is sharp enough to be worth stating plainly: the client's actual stated
goal — get our price into Google's results — is blocked by their own fixture, because the price
snippet will not fire without an image. That looks deliberate rather than accidental, and it means
three of the five deliverables end on "send me the image URL".

**Fixture 1** (`klimatismos-oikonomou-contact.md`) — writes the Greek postal code with an internal
space, `173 43`. I kept the page's own form. Also: «από το 1998» is a *serving-since* claim, not a
founding date, and I declined to convert it into `foundingDate` for that reason. No coordinates, no
price range, no ratings.

**Fixture 2** (`eshop-product-elaiolado.md`) — price is written in Greek convention, `12,90 €`, which
must become `"12.90"` with `"EUR"`; the comma-vs-dot conversion is the one mistake this fixture is
built to catch. Brand («Ελαιώνες Μεσσηνίας») and seller («Ελαιώνες Μεσσηνίας Μονοπρόσωπη Ι.Κ.Ε.») are
deliberately different strings — the trading name and the legal entity — and both belong in, in
different slots. No ratings anywhere on the page, so no `aggregateRating` may be emitted.

**Fixture 3** (`faq-pricing-page.md`) — the client's stated main goal is unachievable and the fixture
knows it: they say their competitors *used to* have the dropdowns. All four Q&A pairs verified
byte-exact against the source after whitespace normalisation (checked programmatically, not by eye).
Three of the four answers contain prices, which makes this markup a standing maintenance
obligation rather than a set-and-forget block.

**Fixture 4** (`workshop-event-page.md`) — **internally consistent**: I checked, and 19 September 2026
genuinely is a Saturday. Two traps sit in the location and time data. The venue is described as
"United Kingdom", where the required `addressCountry` value is `GB` and *not* `UK`; validation-guide
pre-empts exactly this. And the page states "10:00 – 13:00" with no timezone, which the
validation-guide's "Time and zone forms" paragraph resolves to the bare local form `2026-09-19T10:00`
— that paragraph's own worked example uses this fixture's date, so the two were plainly written
together. No county is given (so no `addressRegion`), no instructor is named (so no `performer`).

**Fixture 5** (`blog-existing-schema.md`) — the supplied JSON-LD **genuinely does not parse**. I
confirmed it rather than asserting it: `json.loads` fails at line 11, character 298, on the brace
following the trailing comma after `"name": "Dana Okafor"`. Because both objects share one `<script>`
tag, the page currently has zero working structured data, which is a materially different finding
from "some errors". Two further notes. First, `datePublished: "03/12/2025"` is disambiguated *only*
by the visible byline "Published 12 March 2025" — remove that one line from the fixture and the
correct value becomes a coin flip between March and December, and the honest move would be to ask
rather than fix. Second, the `Product` object is not a repairable defect; it is a false content type
on an article, and it is also incomplete on its own terms (no offers, no price, no image), so it fails
twice over. I deleted it rather than fixing it and said where that markup does belong.

**Cross-cutting**: the five fixtures between them exercise five different primary types, two
languages, three currencies, both date-precision branches, the alpha-2 country-code rule, the
retired-rich-result branch, the "X or Y or both" branch, and the audit branch. Whatever else is true
of the corpus, the coverage is not accidental.
