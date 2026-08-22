# Current JSON-LD on pharosmarine.example

**Pasted by:** Στέλιος Παππάς (senior engineer) on 2026-08-06 — view-source of the two pages that carry
structured data. No schema validator and no crawler is connected in this session; what is below is exactly
what ships to the browser today.

---

## 1. Homepage — `/` (single `<script type="application/ld+json">` block)

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Pharos",
  "url": "https://pharosmarine.example",
  "logo": "https://pharosmarine.example/img/logo.png",
  "sameAs": [
    "https://www.linkedin.com/company/pharos-marine-data",
    "https://twitter.com/pharosmarine",
    "https://www.crunchbase.com/organization/pharos-marine-data",
    "https://el.wikipedia.org/wiki/Φάρος_της_Αλεξάνδρειας",
    "https://www.facebook.com/pharosmarinedata"
  ]
}
```

No `@id`, no `description`, no `address`, no `telephone`, no `foundingDate` in this block.

## 2. Company page — `/etaireia` (a second, separate block)

```json
{
  "@context": "https://schema.org",
  "@type": "Organization",
  "name": "Φάρος Ναυτιλιακή Πληροφορική ΙΚΕ",
  "url": "https://pharosmarine.example/etaireia",
  "foundingDate": "2018",
  "address": {
    "@type": "PostalAddress",
    "streetAddress": "Ακτή Μιαούλη 45",
    "addressLocality": "Πειραιάς",
    "postalCode": "18536",
    "addressCountry": "GR"
  },
  "telephone": "+30 210 4177 251"
}
```

No `@id`, no `sameAs`, no `logo` in this block. The English page `/en/about` carries **no** JSON-LD at all.

## 3. Everywhere else

- No JSON-LD on the product pages, the blog index, any blog post, the pricing page or the contact page.
- No `Person` markup anywhere on the site, including the team block.
- No `BreadcrumbList`, no `WebSite`, no `SoftwareApplication`.
- Total pages on the site: 38 (CMS page count, 2026-08-06). Two of them carry the blocks above.

## 4. What I checked by hand on 2026-08-06, one URL at a time

| `sameAs` entry as published | What actually opens |
|---|---|
| `linkedin.com/company/pharos-marine-data` | Our LinkedIn company page — correct, and it is active |
| `twitter.com/pharosmarine` | "This account doesn't exist." We never registered the handle; someone put it in the markup anyway |
| `crunchbase.com/organization/pharos-marine-data` | 404. We have never created a Crunchbase profile |
| `el.wikipedia.org/wiki/Φάρος_της_Αλεξάνδρειας` | The Greek Wikipedia article on the ancient Lighthouse of Alexandria. Nothing to do with this company |
| `facebook.com/pharosmarinedata` | Our Facebook page — it exists, last post 2021-11-03 |

I also searched **wikidata.org** on 2026-08-06 for `Pharos Marine Data`, `Faros Marine`,
«Φάρος Ναυτιλιακή Πληροφορική» and the ΓΕΜΗ number — **no item exists for this company**. (Items do come
back for the ancient lighthouse and for unrelated organisations; none of them is us.)

## 5. Note from Άννα (Marketing Lead), pasted with the file

> The consultant we used before you left a one-page memo. His two structured-data lines were: *"put
> FAQPage, Product, LocalBusiness and Article schema on every page — the more types a page carries, the
> more likely AI engines are to cite it"* and *"publish an llms.txt at the root so the AI crawlers know
> what to quote."* Nothing has been implemented yet. Στέλιος wants a decision before he touches the
> templates.
