# Performance report transcription — trailkit.ie/collections/hiking

**Client:** TrailKit — trailkit.ie (outdoor and hiking gear e-shop, Ireland)
**Source:** Lighthouse runs by our front-end developer on 2026-08-05 — one navigation run per device profile, plus one timespan run with a scripted interaction (open the nav menu, tap add-to-cart). Lab data, transcribed by hand.
**Field data:** none — the tool showed no real-user (CrUX) data for this URL: "insufficient real-user sample".
**Tools connected now:** none. This transcription is the complete data set. Only this one URL was tested.

## Navigation runs — https://trailkit.ie/collections/hiking

| Metric | Mobile (emulated) | Desktop |
|--------|-------------------|---------|
| LCP | 3.9 s | 2.5 s |
| CLS | 0.31 | 0.06 |
| FCP | 2.6 s | 1.1 s |
| TTFB | 1,060 ms | 610 ms |
| Total Blocking Time | 480 ms | 120 ms |
| Speed Index | 5.1 s | 1.9 s |
| Page weight | 4.2 MB | 4.1 MB |
| Requests | 118 | 114 |

## Timespan run (scripted interaction: open nav menu, tap add-to-cart)

| Metric | Mobile | Desktop |
|--------|--------|---------|
| INP | 168 ms | 200 ms |

## Diagnostics (mobile run, transcribed)

- **LCP element**: hero image `/img/hero-hiking-2026.jpg` — 2,650 KB JPEG, rendered at 390×250 px on mobile.
- **Render-blocking / unused JavaScript**: `/js/carousel.js` (214 KB), `/js/analytics-bundle.js` (187 KB), `/js/chat-widget.js` (156 KB) — tool-estimated savings 1.2 s.
- **Layout shift culprit**: promo banner ("FREE SHIPPING OVER €80") injected above the product grid after load, no reserved space — shift contribution 0.24 of the 0.31 mobile total.
- **Images without explicit width/height attributes**: 14 product thumbnails.
