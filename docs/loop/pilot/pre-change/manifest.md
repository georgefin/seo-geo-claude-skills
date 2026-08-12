# Pre-change capture manifest — the rollback store

**State: TEMPLATE, empty. DRAFTED 2026-08-12 (R76). Nothing has been captured because nothing has
been published.**

**The rule this file enforces: no page is edited until its pre-change copy is captured, hashed and
recorded here.** A row with an empty `sha256` is a page that may not be touched.

---

## Manifest

| Page ID | ProductId | URL | Locale | Capture date (UTC) | Method | File | sha256 | Field lengths recorded | Captured by |
|---|---|---|---|---|---|---|---|---|---|
| | | | | | | | | | |

`Method` is one of:

- **`cms-source`** — the admin field export. **Authoritative restore artifact** where the CMS is
  the publish surface, which it is here.
- **`rendered`** — a dated public-HTML fetch. The **checksum witness**, not the restore source.
- **`both`** — the target state for every page.

---

## Capture rules

1. **Capture both locales**, even if only one is treated. The platform's cache is per-locale and a
   single-locale capture gives the wrong answer in either direction at restore time.
2. **Record field lengths, not just the file.** The eShopKey deploy records use `Description_1/2`
   byte length as the working fingerprint (e.g. a capsule deploy logged 15,913 → 16,504). A length
   pair makes a restore checkable in one glance and catches a partial save that a diff would show
   only after a careful read.
3. **The rendered fetch must be discriminated against the soft-404 signature.** A non-existent URL
   on this property returns **200 with the homepage** (~81,006 B). Capture a fake-URL probe in the
   same session, record its size and `<title>`, and note both in the row. A 200 alone is not
   evidence the page exists.
4. **Note the encoding path per field.** The cp1253 round-trip applies to product
   `Description_1/2`, the specs slot and `JSON_SCHEMA`; measurements on this property show
   `Categorytext_1/2` behaving as UTF-8 and a metadata write preserving an emoji intact. A restore
   that assumes the wrong path corrupts the thing it is restoring. Record which path each captured
   field is on.
5. **Never overwrite a capture.** A re-capture is a new row referencing the old one.

---

## Restore procedure

1. Restore the **`cms-source`** artifact through the normal publication workflow — same route, same
   approvals.
2. Verify the **admin/DB read-back immediately**. That is authoritative and it is instant.
3. **Then wait for the public page.** The public cache can lag hours, per locale, with no purge and
   no republish control. Re-fetch at **+30 min, +2 h, +6 h**; escalate only if the +6 h fetch still
   disagrees. **Do not re-save to chase the cache** — that is the standing platform rule and
   re-saving makes the state harder to reason about, not easier.
4. Record the restore as a change: date, trigger, who, and the verification timestamps.
