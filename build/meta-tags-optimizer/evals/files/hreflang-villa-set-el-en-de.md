# Villa Thalassia — three-language page set (EL/EN/DE) before the DE launch

Site: https://www.villa-thalassia.gr — a holiday villa in Halkidiki. Three language
versions of the villa page exist. Most international bookings come through the
English page, which the owners treat as the default for visitors from any other
country.

## Head snippet — Greek page (https://www.villa-thalassia.gr/el/villa/)

```html
<link rel="canonical" href="https://www.villa-thalassia.gr/en/villa/" />
<link rel="alternate" hreflang="gr" href="https://www.villa-thalassia.gr/el/villa/" />
<link rel="alternate" hreflang="en" href="https://www.villa-thalassia.gr/en/villa/" />
<link rel="alternate" hreflang="de" href="https://www.villa-thalassia.gr/de/villa/" />
<link rel="alternate" hreflang="x-default" href="https://www.villa-thalassia.gr/en/villa/" />
```

## Head snippet — English page (https://www.villa-thalassia.gr/en/villa/)

```html
<link rel="canonical" href="https://www.villa-thalassia.gr/en/villa/" />
<link rel="alternate" hreflang="en" href="https://www.villa-thalassia.gr/en/villa/" />
<link rel="alternate" hreflang="de" href="https://www.villa-thalassia.gr/de/villa/" />
<link rel="alternate" hreflang="x-default" href="https://www.villa-thalassia.gr/en/villa/" />
```

## Head snippet — German page (https://www.villa-thalassia.gr/de/villa/)

```html
<link rel="canonical" href="https://www.villa-thalassia.gr/de/villa/" />
<link rel="alternate" hreflang="el" href="https://www.villa-thalassia.gr/el/villa/" />
<link rel="alternate" hreflang="en" href="https://www.villa-thalassia.gr/en/villa/" />
<link rel="alternate" hreflang="x-default" href="https://www.villa-thalassia.gr/de/villa/" />
```

## Sitemap excerpt (https://www.villa-thalassia.gr/sitemap.xml)

```xml
<url>
  <loc>https://www.villa-thalassia.gr/en/villa/</loc>
  <xhtml:link rel="alternate" hreflang="en" href="https://www.villa-thalassia.gr/en/villa/"/>
  <xhtml:link rel="alternate" hreflang="de" href="https://www.villa-thalassia.gr/de/villa/"/>
</url>
<url>
  <loc>https://www.villa-thalassia.gr/de/villa/</loc>
  <xhtml:link rel="alternate" hreflang="en" href="https://www.villa-thalassia.gr/en/villa/"/>
  <xhtml:link rel="alternate" hreflang="de" href="https://www.villa-thalassia.gr/de/villa/"/>
</url>
```

There is no `<url>` entry for `/el/villa/` anywhere in the sitemap.
