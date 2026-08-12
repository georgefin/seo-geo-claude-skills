# Run notes — `research/content-gap-analysis`, blind execution 12 Aug 2026

## 1. Blindness compliance

**§1.1 held for the whole run. §1.2 held for the whole run.** Stated as fact, not as intention:

- **No `evals.json` was opened**, in this skill or anywhere else. I ran `ls -la` on
  `research/content-gap-analysis/evals/` to locate the fixture directory; that listing displayed the
  filename `evals.json` and its size. I did not read it. No other eval file was touched.
- **Nothing under `docs/` was opened.** The tree appeared as a directory name in one `ls -la` of the
  repo root. Not entered, not listed, not read.
- **No file whose name contains `provenance` was opened.** I encountered no such filename, because I
  never listed or entered any directory that would show one beyond the four I read from.
- **`VERSIONS.md` was not opened.** It appeared as a name and a size (152,332 bytes) in the repo-root
  `ls -la`. Not read.
- **No git command of any kind was run** — not `log`, `show`, `diff`, `blame`, `status`, nothing.
  `.git/` appeared as a directory name in the repo-root listing and was never entered. No commit
  message was seen at any point.
- **No other file in the brief's scratchpad directory was opened.** I read exactly one file from it —
  `brief-content-gap-analysis.md` — and wrote seven files into
  `runs/content-gap-analysis/`. `CENSUS.md`, `analysis.json`, `final.json` and `analyze.py` were
  never read and never listed; I created the output directory with `mkdir -p` and never ran `ls` on
  the parent.
- **No other skill's directory was opened.** Scenario 4 routes to `keyword-research`,
  `seo-content-writer`, `content-refresher` and `competitor-analysis`. I did not open any of them.
  Everything in that handoff comes from `content-gap-analysis/SKILL.md` and the shipped carrier
  `references/inter-skill-handoff.md`, both of which I was directed to.
- **I made zero Grep calls and zero Glob calls.** Not one, at any point, for any purpose. Every file
  I read was reached by a path I already had — from the brief, from the skill's own citations, or
  from a `ls -la` of a directory I was told to enumerate. Where I could not find something without
  searching, I said so rather than searching (see the `anti-slop-ruleset.md` entry in AMBIGUITIES
  A15).
- **No state-changing command of any kind was run.** No writes inside the repo — every file I
  created is under the scratchpad path the brief names. No network access, no live site, no
  credentials.

**One disclosure that is not a breach but should be on the record.** I read
`references/core-eeat-benchmark.md` (first ~280 lines), which the brief does not name. It is a
second-order citation: `inter-skill-handoff.md` §2.1 — which the brief explicitly authorises —
specifies the handoff's content-type field as "one label, **verbatim**, from the CORE-EEAT
content-type weight table", and that table lives in that file. It is on no banned list, contains no
eval expectations, and reading it was the difference between sending a verbatim label and coining
one, which is precisely what §2.1 and §4.4 grade. It also surfaced a genuine defect (A9: two
competing content-type vocabularies in the same file, neither containing a label for a glossary page
or an interactive tool). I did **not** read the sister file `cite-domain-rating.md` — no CITE score
travels in any handoff here.

**Complete list of files read this run** (nine): the brief · `research/content-gap-analysis/SKILL.md`
· its four `references/` files (`analysis-templates.md`, `gap-analysis-frameworks.md`,
`score-arithmetic.md`, `example-report.md`) · `CONNECTORS.md` · `references/inter-skill-handoff.md` ·
`references/core-eeat-benchmark.md` (partial) · and the six fixture files under `evals/files/`. That
is everything.

## 2. Order of work, and save-before-next

Worked strictly 1 → 5. **Each scenario's deliverable was written to disk before the next scenario's
fixtures were read or its analysis begun.** Confirmed per file:

| Order | File | Written before starting | Note |
|---|---|---|---|
| 1 | `e1-out.md` | Scenario 2 (before reading `gap-export-trailkit.csv`) | Three self-corrections applied before moving on — see §3 |
| 2 | `e2-out.md` | Scenario 3 (before reading either Greek fixture) | Four self-corrections applied before moving on — see §3 |
| 3 | `e3-out.md` | Scenario 4 | — |
| 4 | `e4-out.md` | Scenario 5 | One numbering fix applied before moving on |
| 5 | `e5-out.md` | AMBIGUITIES.md | No fixtures to read |
| 6 | `AMBIGUITIES.md` | RUN-NOTES.md | — |
| 7 | `RUN-NOTES.md` | — | This file |

**No earlier deliverable was revised after a later scenario began.** The corrections logged in §3 all
happened inside their own scenario, before the next one started. No deliverable cross-references
another, and none was reopened for comparison — I did not re-read e1 while writing e4, despite the
shared fixtures.

**On Scenarios 1 and 4 landing on the same twelve scores.** They use identical inputs and the skill
requires that "two runs of the same data must land on the same number". I re-derived each score in
e4 from the fixtures and the factor bands rather than copying, and they agree. That is the skill
working, not a carried conclusion. The two deliverables differ substantially in everything else —
e4's calendar is explicitly gated on demand validation, which e1's is not, because the client asked
for that gate.

## 3. Self-corrections, disclosed

I ran the skill's mandated pre-send recompute pass (score-arithmetic §7) against each finished
deliverable. It caught real errors in my own output, which is worth recording because it is evidence
the check does work:

- **e1**: one factor row inconsistent with its own weighted line (M6 Vanlife, Competitive Density
  printed as 1 against a line computed with 3). Corrected to 3, which matches the band definition —
  one of two competitors covers it. My first attempted fix was itself wrong (I "corrected" the
  weighted line to match the bad factor score, producing 1.20); I caught that and fixed it properly.
  Also corrected a gap-category tally in the Executive Summary that did not sum to 12.
- **e2**: **three Quick Win Scores computed wrongly** — `hiking first aid kit list` (−2 → **+1**),
  `what is scrambling` (−1 → **+2**), `hiking with dogs essentials` (−4 → **−2**). The scrambling
  error changed a tier: at +2 it clears the quick-win bar, so it moved Tier 2 → Tier 1, and the
  Executive Summary's quick-win count moved 4 → 5. All downstream prose and the calendar row were
  updated.
- **e4**: handoff row numbering skipped from 17 to 19.

All corrections were made before the following scenario began.

## 4. Things about the fixtures the next reader should know

**The three TrailKit/competitor files are internally consistent and cross-validate.** All eleven
competitor URLs in `gap-export-trailkit.csv` reconcile exactly to titles and clusters in the two
manual-crawl inventories, which were compiled a day apart by a different method. That is a
deliberate and useful property — it means Scenario 2 can lean on both datasets, and it gives a clean
cross-check that a careless run would miss.

**Both competitor inventory sets carry a deliberate itemisation shortfall, and it is load-bearing.**
Summitline states ~140 pages and itemises 99 (38 cluster articles + 60 glossary + 1 tool); PeakPath
states ~85 and itemises 35. The Greek pair does the same: Ανάπλαση states ~45 and itemises 13,
Κίνηση states ~30 and itemises 11. **Any run that treats a competitor `0` as "proven absent" is
wrong**, and it changes at least one score directly — in Scenario 3 it is the reason the
downloadable-programme gap scores Competitive Density 4 rather than 5.

**Every fixture pre-labels its own provenance, including the traps.** Competitor traffic is flagged
in the file as "rough figure from a free traffic checker; treat as a user-provided estimate, not tool
data". Own-site sessions are flagged as GA4, 90 days. The files are doing the source-labelling work
the skill requires, which makes an unlabelled figure in the output an unforced error.

**The own-site 90-day figures and the competitor monthly estimates are not comparable**, and nothing
in the fixtures says so — different metric, different window, different collection method. Producing
a ratio between them is available and wrong. I computed neither.

**`gap-export-trailkit.csv` contains two deliberate traps pointing in opposite directions.**
`campervan insurance uk` is the highest volume (8,100, 30% of the file's total) and the worst fit;
`rucksack size calculator` is the lowest difficulty (KD 9) and needs a capability the client's own
inventory says they lack. A run that sorts on either column alone gets both wrong.

**The export is a sample, not a census** — 11 keywords against 225 catalogued competitor pages, and
it contains **zero** keywords for two of the strongest gaps visible in the inventories (camping/tents
depth, clothing depth) and one keyword for a 60-page glossary. Treating it as the gap list
understates the opportunity and mis-sequences the plan.

**Both no-tool scenarios are constructed so that the only admissible Search Demand proxy is
partially unavailable.** Own-site adjacent-page sessions exist for the depth gaps and for none of
the largest missing topics (TrailKit: dogs, winter; the clinic: runners, elderly care). Combined with
the #68 ruling that bars cluster depth wherever Competitive Density comes from the same competitor
data, this forces a real decision rather than a default. See AMBIGUITIES A4.

**The Greek fixture names three target audiences in its context note and has zero pages for two of
them** (δρομείς, οικογένειες που φροντίζουν ηλικιωμένους), while both competitors cover both. That
is the strongest single finding available in that scenario and it comes from the client's own words,
not from inference — which also means Business Relevance on those gaps is evidenced rather than
guessed, unlike the TrailKit winter/dog rows where it had to be scored from absence of evidence.

**Scenario 5's four domains were not visited and cannot be**: no crawler is connected and the run has
no network. They are also almost certainly reserved-style fictional names. I neither verified nor
characterised any of them.

## 5. One structural observation about the instrument

Three of the five scenarios (1, 3, 4) hit the same branch — no tools, Search Demand dropped, weights
renormalised, quick-win screen not run. That branch is the skill's most likely real-world operating
mode, and it is where the largest concentration of underspecification sits: the tier mapping is
undefined (A2), ties multiply and have no third-level break (A3), the proxy-or-drop choice has no
criterion (A4), and renormalisation silently inverts the weight design the framework spends a whole
section justifying (A5). The five-factor path is specified in far more detail than the four-factor
path that most runs will actually take.
