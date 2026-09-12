# Alert thresholds — seven decisions for the owner (2026-08-13)

**What this is.** `monitor/alert-manager` carries seven alert rows whose *value* nobody here can
derive: they need a business judgement, not a documentation pass. They were deliberately left open
rather than filled with a number nobody chose. This file states each one as a question, prices
getting it wrong in each direction, recommends a default you can accept in one word, and says what
the recommendation is **not** based on.

**Nothing here is applied, and this file applies nothing.** Its author edited no skill. Once you
answer, applying the answers belongs to whoever holds `monitor/alert-manager/` — the row text, the
band column and the priority clause all change together, and the two reference files must move in
the same commit.

**This is an operator surface** (`docs/loop/`), so skill slugs, file paths, framework handles and
band vocabulary appear here by design. None of this text goes to a client.

**Why seven when the guide says six.** `references/alert-threshold-guide.md` §3 numbers six rows
under "Open threshold decisions". The seventh — the two citation-rate rows — is carried a few
paragraphs above, in the same section's GEO caveat, and again in
`references/alert-configuration-templates.md`. It is the same class of open question and is decided
here as number 7; whoever applies these should also fix the "six rows" heading count.

**Two words you need, and only two.** A **band** (Info / Warning / Critical / Emergency) says how
far a metric moved from its own baseline. A **priority** (P0-P3) says who is woken and how fast:
P0 is SMS and a phone call, P1 is Slack plus email with same-day resolution, P2 is email within 48
hours, P3 is the weekly digest. They are different axes; most of what follows is about keeping them
matched.

---

## Answer sheet

Reply with this block, edited. Every line is already filled with the recommendation, so agreeing
costs one word: "all as recommended". Overwrite any line you want changed.

```
1. Backlink authority scale ......... Ahrefs DR, cut-off derived from our own link profile
2. Crawl Errors Spike ............... move trigger to 2x baseline, priority P2
3. Homepage traffic ................. week-over-week, guide ladder, keep P0
4. Top-10 pages ..................... week-over-week, guide ladder, keep P1
5. Conversion pages ................. week-over-week, guide ladder, keep P1
6. Blog posts ....................... week-over-week, alert on the blog as a group, keep P2
7. Citation-rate rows ............... drop both to band defaults: Slide P2, Floor P1
```

| # | The question, short | Recommended default | Who really needs to decide |
|---|---|---|---|
| 1 | Which backlink tool's authority score defines a "valuable" lost link, and how high is the bar? | Ahrefs DR; bar read off our own referring-domain distribution | **You** — it is a tool/contract choice |
| 2 | How big a jump in crawl errors is worth an alert? | 2x baseline, P2 | Settleable from our own data |
| 3 | How far can homepage traffic fall, over what window, before you are phoned? | WoW, -25/-40/-60%, P0 | **You** — the night-call question |
| 4 | Same, for a top-10 page | WoW, -25/-40/-60%, P1 | Settleable from our own data |
| 5 | Same, for a page that takes orders or leads | WoW, -25/-40/-60%, P1 | **You** — revenue tolerance |
| 6 | Same, for one blog post | WoW, grouped, P2 | Settleable from our own data |
| 7 | How much does a fall in AI-answer citations matter — night call, or this week's email? | Band defaults: P2 / P1 | **You** — channel value |

---

## 1. Which backlink tool feeds the "high-value link lost" alert, and where is the bar?

**The question.** When a site that links to you removes that link, how important does that site have
to be before you want to hear about it — and which tool's authority score is allowed to answer that?

**Why it is open.** Two rows in this skill measured "high authority" on two different instruments:
**DA 70+** (Moz Domain Authority) in the templates, **DR 60+** (Ahrefs Domain Rating) in the guide.
Both run 0-100 and they are not the same number. **No conversion between them is established
anywhere in this repository**, none is proposed here, and an earlier implementer was right to
decline to pick one silently — that would hand two clients on two different tools the same figure on
incomparable scales.

**Cost of getting it wrong.** *Bar too low:* a steady trickle of P1 alerts about links you would
never have chased, which is how a team learns to ignore the channel. *Bar too high:* a genuinely
valuable link disappears unnoticed. **This row carries more fatigue risk than silence risk** — links
come and go constantly, and aggregate link loss is already covered by a separate ladder (referring
domains lost: >5% in a week Warning, >15% Critical), so one missed link is bounded. Err high.

**Recommended default.** **Ahrefs Domain Rating**, because Ahrefs is the only backlink tool with a
declared connector here (`.mcp.json` lists ahrefs, similarweb, hubspot, amplitude, notion, slack —
no Moz, and nothing else in that list publishes a link-authority score). Then do **not** adopt
an inherited number: set the bar from our own link profile — alert on losses from domains in the
**top 10% of our current referring domains by DR** — and write the resulting figure with its tool
and its date in the row, e.g. "DR >= NN, Ahrefs, from the 2026-08 profile". If your reporting
contract already runs on Moz, use DA and re-derive from the same rule; never translate the number
across.

**What this is not based on.** No verified DR-to-DA conversion, because there is none here. The
inherited DR 60 / DA 70 figures carry **no source in this repository** and are not evidence for
anything, including the decile rule. **No industry "high authority" benchmark is supplied — I have
no sourced one, and a plausible-sounding number would be worse than none.** The top-decile rule is a
construction rule chosen because it is defined entirely in our own data; it is not a measured
optimum.

**What would settle it.** One export of our referring domains with the connected tool's authority
score. The bar is then read off the distribution and re-read whenever the profile changes. Note the
MCP connectors were still unauthenticated as of 2026-08-09 (`docs/loop/PILOT.md` §0, input 2), so a CSV
export does the job equally well. If the top decile turns out to be a handful of domains, the rule
still serves — it names the domains you would actually chase — but eyeball the list before shipping.

---

## 2. Crawl Errors Spike: is a 50% jump worth an alert?

**The question.** How much do crawl errors have to jump before someone stops what they are doing to
look — and is a 50% jump (that is, 1.5x a normal day) big enough to be worth telling anyone?

**Why it is open.** The row triggers at "+50% over baseline". The guide's crawl-error ladder starts
at **>2x baseline** for Warning. So this trigger reaches no band at all — and the row was inherited
carrying **P1**, a priority with nothing under it and no reason beside it.

**Cost of getting it wrong.** *Too tight:* on a site whose normal day is three crawl errors, four
errors is +33% and five is +67%. A 1.5x rule fires on ordinary noise, at a priority that promises
same-day resolution. *Too loose:* a real crawl problem is spotted later. **This row carries far more
fatigue risk** — and a crawl-error spike that actually matters shows up on two other alerts that
already exist (index coverage at -5%, and the traffic ladders), so this row is not the only line of
defence.

**Recommended default.** **Move the trigger to >2x baseline.** The row then sits on the guide's one
crawl-error ladder, lands in the Warning band, and takes **P2** from the default map with no special
pleading. Keep the absolute-count row beside it (>10 new errors/day Warning, >50 Critical) — that is
what covers a site whose baseline is near zero, where any ratio is meaningless. Either way, the
unexplained P1 does not ship: a priority with no band under it needs its reason written in the cell.

**What this is not based on.** Nothing here measures this site's crawl-error variance. **2x is not a
measured optimum** — it is the number already in the guide, chosen for consistency so that one metric
keeps one ladder. No industry crawl-error benchmark is supplied; this library holds none.

**What would settle it.** Two to four weeks of daily crawl-error counts (the guide's own baseline
period for technical metrics). With a mean and a standard deviation, the ratio trigger is replaced
by the standard-deviation ladder, which handles small counts properly — exactly the case where a
percentage trigger misbehaves. **This one does not really need you; it needs two weeks of data.**

---

## 3-6. The four page-level rows: homepage, top-10 pages, conversion pages, blog posts

**What all four have in common.** Each says a percentage — 20%, 30%, 25%, 40% — and **none says
compared with what**. "Down 20%" against yesterday, against last week and against last month are
three different alerts, and until the window is named no band can be read off the row at all, which
is why all four currently sit at band "none".

**Why week-over-week is recommended for all four.** Day-over-day drags in the weekday/weekend cycle
the guide warns about twice (Monday is not Sunday), and on a single page the daily numbers are small
enough to swing on nothing. Month-over-month cannot support the priorities these rows carry — a P0
that can only fire once a month is not a pager. Week-over-week compares like with like and is the
window the guide's own page-level ladder already uses.

**And the percentages then come from the ladder, not from the rows.** The guide bands page-level
traffic at **-25% Warning / -40% Critical / -60% Emergency**, week over week. Adopting it means the
inherited 20/30/25/40 figures — which carry no source in this repository either — are retired, the
band becomes readable, and the difference between page types lives where it belongs: in the
**priority** column, with the reason clause each row already carries. One honest caveat: the guide
states that ladder for "top 10 pages", so applying it to the other three groups is an **extension**
of one ladder rather than the invention of three. Extending it deliberately is the point; three
quietly different ladders for one metric is the defect that produced finding 75.

### 3. Homepage

**The question.** How far can homepage organic traffic fall, compared with the same days a week
earlier, before you want a phone call rather than an email?

**Cost of getting it wrong.** *Too tight:* the homepage is the noisiest single URL on most sites
(brand search, campaigns, seasonality all land there), and a P0 means SMS and a phone call.
*Too loose:* a homepage-specific failure — a stray noindex, a redirect loop, a botched template —
goes unnoticed for days. **This row carries real silence risk**, because the site-wide crash alert
(-50% day-over-day, P0) would **not** fire for a homepage-only failure: one page collapsing rarely
moves site-wide traffic by half in a day. The two rows overlap less than they look.

**Recommended default.** **Week over week on the guide ladder, priority kept at P0.** But note the
mismatch you are accepting: a P0 promises acknowledgement in 15 minutes, while a week-over-week
comparison can be up to seven days behind the event. If you genuinely want the night call for the
homepage, the trigger that earns it is **day-over-day**, and that means borrowing the site-wide DoD
ladder (-25% weekday / -40% / -50%) for a single page — an extension the guide does not currently
make, which whoever applies it must state in the row. Accept with "WoW"; say "WoW+DoD" if you want
the night call as well.

**What this is not based on.** No measurement of this homepage's week-to-week variance. **No
industry figure for "normal homepage fluctuation" is supplied.** The -25/-40/-60 ladder is the
library's existing page-level ladder, adopted for consistency, not a measured constant.

**What would settle it.** Four to eight weeks of homepage sessions. Then the homepage grades against
its own standard deviation and the percentage disappears — and the guide already prefers that.

### 4. Top-10 pages

**The question.** How far can one of your ten biggest pages fall in a week before an analyst
investigates the same day?

**Cost of getting it wrong.** *Too tight:* ten pages times a weekly check is a steady alert volume
at P1. *Too loose:* the pages carrying most of your traffic decay quietly. Roughly balanced, with a
slight lean towards fatigue because these pages usually decline gradually rather than falling off a
cliff.

**Recommended default.** **Week over week, guide ladder, P1 kept** with its existing reason ("these
pages carry most of the traffic", a raise from the Warning band's default P2). This is the least
uncertain of the four: the guide's page-level ladder was written for exactly this row, so nothing is
being extended.

**What this is not based on.** No per-page variance measurement, and no external benchmark. The 30%
in the row today has no source here and is dropped in favour of the ladder.

**What would settle it.** Four to eight weeks of page-level sessions for those ten URLs — then each
page gets its own band. **This one does not really need you either.**

### 5. Conversion pages

**The question.** How far can traffic to a page that takes orders or leads fall in a week before it
is treated as a revenue problem rather than an SEO one?

**Cost of getting it wrong.** *Too tight:* noise on the loudest internal channel, since conversion
alerts are already priced above their band. *Too loose:* revenue leaks for a week before anyone
looks. **This row carries more silence risk than any of the other three** — it is the money line,
which is exactly why the conversion alerts already sit above the default map.

**Recommended default.** **Week over week, guide ladder, P1 kept.** And one neighbour worth using:
where conversion data exists for these pages, alert on the **conversions**, not only the sessions —
the guide already bands organic conversions week over week (-20% Warning, -40% Critical, -60%
Emergency), and a page can hold its traffic while losing its orders. A sessions alert cannot see
that; the conversion ladder can.

**What this is not based on.** No measurement of what a week of degraded conversion-page traffic
costs this business — that number is yours, not the library's. **No industry conversion-drop
benchmark is supplied.** If your tolerance is tighter than -25%, say so and the row is set tighter;
that is a business fact, not a statistic to be looked up.

**What would settle it.** Partly data (four to eight weeks of page-level sessions and conversions),
but partly not: how much lost revenue is worth a same-day interruption is a judgement only you can
make.

### 6. Blog posts

**The question.** How far can a single blog post's traffic fall before anyone is told — and is one
post decaying worth an alert at all?

**Cost of getting it wrong.** *Too tight:* this is the worst fatigue risk in the whole set. A post
getting 20 visits a week hits -40% when it loses eight visits, and a blog of 200 posts generates a
stream of alerts that mean nothing individually. *Too loose:* content decay creeps up, which is a
quarterly-review problem, not an incident. **This row is almost pure fatigue risk.**

**Recommended default.** **Week over week, but alert on the blog as a group rather than post by
post**, priority kept at P2 (email lane, 48 hours). A per-post alert is only meaningful for a post
whose own weekly baseline is stable enough to grade — so give an individual post its own alert only
once it has a baseline, grade it on its own standard deviation, and let everything below that line
be covered by the group row and the periodic content-decay review instead of by a pager.

**What this is not based on.** No traffic floor is proposed, because any floor I named ("only pages
over N visits") would be invented. The stable-baseline test above does the same job using our own
data instead of a number from nowhere. **No industry content-decay benchmark is supplied.**

**What would settle it.** Four to eight weeks of page-level blog sessions. The set of posts big
enough to carry their own alert then names itself, and everything else stays in the group row.

---

## 7. The two citation-rate rows: how loudly should a fall in AI citations shout?

**The question.** When AI answers cite you less often across the board, is that a phone call at
night, an email you act on within the day, or a note you deal with this week?

**Why it is open.** Both rows — **Citation Rate Slide** (P1) and **Citation Rate Floor** (P0) — ship
one level above their band's default, and the justification written beside them was the standing
priority-1 override. That override covers the client's money and brand *queries*; citation rate is a
site-wide line across all tracked queries, so it cannot reach these rows. The false justification has
been corrected and the priorities were left as they stood. **Nothing here establishes that they are
right.**

**Cost of getting it wrong.** *Too loud:* the P0 lane is SMS, a phone call and the on-call rotation,
and this metric runs on a **weekly** check window — the fastest it can possibly detect anything is up
to seven days after the fact. Paging on a week-old signal spends the loudest channel where no clock
is running, and it teaches people that a phone call may mean nothing urgent. *Too quiet:* a genuine
collapse in AI visibility is handled at email pace. **This row carries more mis-pricing risk than
silence risk**, and the silence side is partly covered: the two priority-1 query rows keep their
legitimate lift, so the client's money and brand terms still escalate on their own.

**Recommended default.** **Drop both to their band defaults — Rate Slide P2, Rate Floor P1.** Keep
the raised P1/P0 only if AI answers are a named acquisition channel for this property, and if you do,
write the real reason in the row ("raised: AI answers are a primary acquisition channel for this
site — business call, 2026-08-13"), never the override. A reason that names the wrong mechanism is
worse than a default.

**Two things to fix while you are in there.** First, **the rows do not state their denominator.**
Citation rate is *queries citing you divided by monitored queries that returned an AI answer*
(`monitor/performance-reporter/references/kpi-definitions.md`, AI Citation Rate; same formula in
`monitor/rank-tracker/references/metric-derivations.md` #13). That denominator moves on its own, so
a 10% floor can be crossed because AI Overviews appeared on more queries, not because anything on
the site changed. Whichever priority you pick, the row should name the denominator and carry both
counts — the performance-reporter template already requires that. Second, the **values** themselves
(a 10-point slide, a 10% floor) are unconfirmed too, and the guide labels the whole GEO block
"tunable operational defaults, not measured constants".

**What this is not based on.** Nothing here measures what a falling citation rate costs. **No
industry AI-citation benchmark is supplied** — this library holds none, and the neighbouring pair in
`kpi-definitions.md` ("Good Range >20%, Warning <5%") is another unsourced default in the same
library, not corroboration of the 10% figure.

**What would settle it.** Two things, and only one is data. (a) Eight or more weeks of weekly
citation counts, after which the guide's optional statistical ladder replaces both fixed numbers with
bands derived from our own history. (b) Whether this channel is worth a phone call — check the share
of sessions arriving from AI assistants (performance-reporter's *AI Referral Sessions & Share*),
with that file's own two caveats carried: a referral proves an AI answer *linked* the site, not that
it cited it prominently, and the hostname roster it matches on is **[VERIFY]**-tagged and churns, so
re-check it before leaning on the number.

---

## After you answer

1. Whoever holds `monitor/alert-manager/` applies the answers to both reference files in one commit —
   the trigger, the band cell and the priority clause move together, and the SKILL.md quick-reference
   table quotes the same ladder.
2. Every row that ends up above or below its band's default carries its real reason in the cell.
3. `docs/loop/OPEN-FINDINGS.md` finding 65 closes when the rows are applied, not when this file is
   answered — a decision and its application are different jobs.
4. Four of the seven (2, 4, 6, and half of 3) stop being judgement calls the moment four to eight
   weeks of baseline data exists for this property. If the data lands first, prefer the data: the
   skill already carries a standard-deviation ladder built for exactly that, and a threshold derived
   from our own numbers beats any figure chosen in advance.
