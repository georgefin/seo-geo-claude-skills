# Greek E-Shop Trust & Compliance Audit Items

Supplementary trust/staleness checks for **Greek e-commerce domains**, applied during the
T (Trust) dimension pass of a CITE audit. For E-commerce domains, T carries its highest
weight (35%), so these observations move the CITE Score more than for any other domain type.

These checks **map onto existing CITE items** (T06, T08, T10). They do not add, remove,
or renumber CITE items, and they do not change dimension weights. Record observations in
the mapped item's Notes column; they inform that item's Pass/Partial/Fail judgment.

> ⚠️ **Audit signals, not legal advice.** Every item below is a trust/staleness scoring
> signal only. This skill does not determine legal compliance, and findings must never be
> phrased as compliance conclusions. What the law requires — and whether the client meets
> it — is a question for the client's lawyer.

## Mapping to CITE T-Dimension Items

| # | Audit item | CITE item | Why it maps there |
|---|---|---|---|
| 1 | Stale EU ODR platform link | T08 Content Freshness Signal | Dead legal boilerplate = unmaintained-site signal |
| 2 | ΓΕΜΗ number + legal entity details | T06 WHOIS & Registration Transparency | On-site transparency of who legally operates the domain |
| 3 | Physical address + ΑΦΜ (VAT number) | T06 WHOIS & Registration Transparency | Same — operator identity transparency |
| 4 | 14-day withdrawal disclosure + returns policy | T10 Review & Reputation Signals | Consumer-trust furniture; gaps surface as disputes and negative reviews |
| 5 | Terms of service + shipping/payment transparency | T10 Review & Reputation Signals | Same — policy transparency underpins consumer trust |
| 6 | myDATA e-invoicing | — (no mapping) | UNVERIFIED (watch-item W2) — do not assert, do not score |

## 1. Stale EU ODR Platform Link (→ T08)

**Background**: The EU Online Dispute Resolution (ODR) platform was **discontinued as of
2025-07-20** under Regulation (EU) 2024/3228 (adopted 2024-12-19). The former obligation
for online traders to link to the ODR platform was removed with it. Sources: European
Commission consumer-redress relocation page; ECC Finland press release (2025).

**Check**: Does the footer, terms page, or checkout flow still link to (or reference) the
discontinued ODR platform?

**Finding if present**: Staleness/trust finding under T08 — the site's legal boilerplate
is unmaintained (site-maintenance signal). **Fix**: recommend removing the dead ODR
link/reference. **Confidence**: usually *Confirmed* (the footer is directly observable in
a crawl); *Hypothesis* if no page access — confirm by fetching the footer and terms pages.

## 2. ΓΕΜΗ Number & Legal Entity Details (→ T06)

**Background**: Greek companies display their ΓΕΜΗ number (Γενικό Εμπορικό Μητρώο —
General Commercial Registry) on business communications and websites. Exact statutory
scope of the display obligation: [VERIFY — legal specifics with the client's lawyer].

**Check**: Is a ΓΕΜΗ number present on the site (typically footer, legal notice, or
company/contact page), together with legal entity details (registered company name and
legal form)?

**Finding if absent or hard to find**: Operator-transparency gap — record in T06 Notes
and weigh toward Partial. Phrase it as a trust-signal gap, not a compliance breach (see
disclaimer above).

## 3. Physical Address & ΑΦΜ (→ T06)

**Check**: Registered physical address and ΑΦΜ (Αριθμός Φορολογικού Μητρώου — Greek tax
registration / VAT number) visible on the site (footer, legal notice, or contact page).
Standard trust furniture for a Greek e-shop; anonymity here also depresses consumer
confidence.

**Finding if absent**: Record in T06 Notes; weigh toward Partial/Fail together with item 2.

## 4. Withdrawal Right & Returns Policy (→ T10)

**Check**:
- Disclosure of the EU consumer right of withdrawal (14 days): present and findable.
- A returns policy page exists and is findable (footer link, reachable within one click).
- Returns terms consistent between the policy page and checkout messaging.

**Finding if missing or unfindable**: Consumer-trust gap under T10 — shops that hide or
omit withdrawal/returns information accumulate disputes and negative reviews. Record both
presence and findability observations in T10 Notes.

## 5. Terms of Service & Shipping/Payment Transparency (→ T10)

**Check**:
- Terms of service page present and findable.
- Shipping methods and costs visible before checkout.
- Payment methods listed transparently.

**Finding if missing**: Trust-furniture gap — record in T10 Notes, same reasoning as item 4.

## 6. myDATA E-Invoicing — Pending Verification, Do Not Assert

myDATA e-invoicing obligations are tracked as **UNVERIFIED** in the library's watch queue
(**watch-item W2**, `docs/loop/WATCH-ITEMS.md`). Do **not** assert myDATA obligations,
phases, or dates in any audit report, and do not score them under any CITE item.

**Where the watch-item handle may appear.** `W2` and the queue it lives in are addressed to
whoever runs this library — they belong on this page, in an operator note, and in the audit's
internal record. They never reach the client, who cannot open that register and gains nothing
from its name (`CLAUDE.md` § The Reader Test, clause 1). If the client raises the topic, the
answer is the substance in their own terms and nothing else: verification against primary
sources is still pending, so nothing is asserted here, and their accountant or lawyer is the
person to settle it. No handle, no register name, no repo path in that sentence.

## Greek Footer Terms — Quick Reference

Labels to look for when reviewing a Greek e-shop's footer and legal pages:

| Greek label | English meaning | Audit item |
|---|---|---|
| Όροι Χρήσης | Terms of use | 5 |
| Πολιτική Επιστροφών | Returns policy | 4 |
| Δικαίωμα υπαναχώρησης | Right of withdrawal | 4 |
| Τρόποι Πληρωμής | Payment methods | 5 |
| Τρόποι / Έξοδα Αποστολής | Shipping methods / costs | 5 |
| ΑΦΜ | Tax registration (VAT) number | 3 |
| ΓΕΜΗ | General Commercial Registry number | 2 |

## Reporting Reminder

Every finding from this checklist follows the skill's standard finding format (Finding /
Evidence / Impact / Fix + Confidence label) and repeats the disclaimer: **audit signals
for trust/staleness scoring — not legal advice; compliance conclusions go to the client's
lawyer.**
