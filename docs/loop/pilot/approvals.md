# Approvals log — append-only

**State: TEMPLATE, empty. DRAFTED 2026-08-12 (R76). No approval has been given and no page has
been published.**

**The rule: no approval, no publication.** An approval must **name the page(s)** it covers. A list
of named pages in one message counts per page; an unnamed blanket "publish" does not satisfy the
per-change HITL gate, and neither does a general "proceed".

Approvals are recorded **verbatim**, with the date and where the words were given. A paraphrase is
not an approval.

---

## Approval rows

| # | Date | Page ID | ProductId | Locale(s) | Sani's words (verbatim) | Channel | Gates passed before approval | Published (UTC) | **W0 live-render confirmed (UTC)** | Verifier |
|---|---|---|---|---|---|---|---|---|---|---|
| | | | | | | | | | | |

**`Gates passed before approval`** records all four, in order, each with its result:

1. **CORE-EEAT** at the locked threshold (GEO / SEO scores, veto items) — `content-quality-auditor`
2. **Greek editor**, binding, for EL pages — register, diacritics, Greeklish
3. **cp1253 pre-flight** — a codepoint scan on the *new* text of the cp1253-scoped fields only
   (product `Description_1/2`, specs slot, `JSON_SCHEMA`). Entity escaping is **not** a shield:
   `&rarr;` was observed on this platform decoding back to a literal `→` on save. Character
   substitution is the only working defence.
4. **Sani's per-page approval** — the row's verbatim words

**No page ships with placeholder or TBD text.** TBD markers are fine in these internal documents;
they are not fine in customer copy.

---

## The two timestamp columns are different things and both are required

- **`Published`** — when the save went through and the admin read-back confirmed it.
- **`W0 live-render confirmed`** — when a fresh public GET confirmed the change actually rendered,
  discriminated against the soft-404 signature (a fake URL on this property returns 200 with the
  homepage).

**The measurement clock starts at the second one.** The public page can lag hours after a save,
per locale, with no purge available. Anchoring W0 to the save date opens the evaluation window
before the change exists to be crawled, and CP1 then measures a page Google has not yet seen.
`W0` for the pilot as a whole is the earliest live-render confirmation across the treatment pages.

---

## Rollback rows

| # | Date | Page ID | Trigger | Authorised by | Restore artifact (manifest row) | DB read-back | Public re-fetch +30 m / +2 h / +6 h | Outcome |
|---|---|---|---|---|---|---|---|---|
| | | | | | | | | |

Triggers, per `PILOT.md` §7: **(a)** Sani's directive — immediate, no debate; **(b)** a factual,
legal or compliance defect in a published page — single page, same day; **(c)** the pre-registered
harm criterion breached at two consecutive checkpoints.

A rollback is recorded like any other change, and Sani's word is required unless the rollback *is*
Sani's directive.
