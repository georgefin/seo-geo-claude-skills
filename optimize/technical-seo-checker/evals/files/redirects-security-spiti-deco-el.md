# Τεχνική συλλογή στοιχείων — spiti-deco.gr (χειροκίνητη)

**Πελάτης:** Σπίτι Deco — spiti-deco.gr (ηλεκτρονικό κατάστημα ειδών διακόσμησης)
**Συλλογή:** ο προγραμματιστής μας, 2026-08-07 — έλεγχοι redirect μέσω online redirect checker, κεφαλίδες με curl, κονσόλα browser για mixed content· όλα μεταφέρθηκαν εδώ με το χέρι.
**Εργαλεία:** κανένα συνδεδεμένο. Δεν έχει τρέξει crawler. Αυτό το αρχείο είναι το σύνολο των δεδομένων. Ελέγχθηκαν ΜΟΝΟ τα 5 URLs της πρώτης ενότητας, οι κεφαλίδες της αρχικής σελίδας και η κονσόλα μίας μόνο σελίδας (ενότητα 3).

## 1. Έλεγχοι redirect (5 URLs, online redirect checker)

**Έλεγχος 1 — παλιό URL κατηγορίας φωτιστικών** (υπάρχει τυπωμένο σε παλιά έντυπα φυλλάδιά μας):

```
http://spiti-deco.gr/fotistika
  → 301 → https://spiti-deco.gr/fotistika
  → 301 → https://www.spiti-deco.gr/fotistika
  → 301 → https://www.spiti-deco.gr/collections/fotistika   (τελικό: 200)
```

(3 redirects μέχρι την τελική σελίδα)

**Έλεγχος 2 — περσινή σελίδα προσφορών:**

```
https://www.spiti-deco.gr/prosfores-kalokairi-2025
  → 302 → https://www.spiti-deco.gr/prosfores   (τελικό: 200)
```

Σημείωση: η παλιά σελίδα καταργήθηκε οριστικά τον Σεπτέμβριο του 2025 και δεν πρόκειται να ξαναχρησιμοποιηθεί.

**Έλεγχος 3 — σελίδα επιστροφών:**

```
https://www.spiti-deco.gr/epistrofes
  → 301 → https://www.spiti-deco.gr/oroi-epistrofon
  → 301 → https://www.spiti-deco.gr/epistrofes
  → 301 → https://www.spiti-deco.gr/oroi-epistrofon
  → …
```

Ο browser σταματά με «ERR_TOO_MANY_REDIRECTS» — η σελίδα δεν ανοίγει καθόλου.

**Έλεγχος 4 — αρχική σελίδα:**

```
http://spiti-deco.gr/
  → 301 → https://www.spiti-deco.gr/   (τελικό: 200)
```

(1 redirect)

**Έλεγχος 5 — παλιό άρθρο blog:**

```
https://www.spiti-deco.gr/blog/diakosmisi-saloni-2023   →   404
```

Σημείωση: το άρθρο μεταφέρθηκε πέρυσι στη διεύθυνση https://www.spiti-deco.gr/blog/diakosmisi-saloniou (ανοίγει κανονικά με 200 — το επιβεβαιώσαμε στον browser)· η παλιά διεύθυνση απλώς βγάζει «δεν βρέθηκε».

## 2. Κεφαλίδες αρχικής σελίδας (curl -I https://www.spiti-deco.gr/ — η απόκριση όπως γύρισε)

```
HTTP/2 200
content-type: text/html; charset=utf-8
x-frame-options: SAMEORIGIN
cache-control: max-age=600
server: nginx
```

Σημείωση προγραμματιστή: στην απόκριση ΔΕΝ εμφανίζεται strict-transport-security, ούτε x-content-type-options, ούτε content-security-policy, ούτε referrer-policy. Το πιστοποιητικό SSL είναι έγκυρο — λήγει στις 12/11/2026 (έλεγχος από το λουκέτο του browser).

## 3. Mixed content — κονσόλα browser στη σελίδα https://www.spiti-deco.gr/collections/xalia (4 προειδοποιήσεις, αντιγραμμένες)

```
Mixed Content: The page at 'https://www.spiti-deco.gr/collections/xalia' was loaded over HTTPS, but requested an insecure image 'http://cdn-old.spiti-deco.gr/img/xali-persiko-01.jpg'.
Mixed Content: The page at 'https://www.spiti-deco.gr/collections/xalia' was loaded over HTTPS, but requested an insecure image 'http://cdn-old.spiti-deco.gr/img/xali-flokati-02.jpg'.
Mixed Content: The page at 'https://www.spiti-deco.gr/collections/xalia' was loaded over HTTPS, but requested an insecure image 'http://cdn-old.spiti-deco.gr/img/xali-moderno-05.jpg'.
Mixed Content: The page at 'https://www.spiti-deco.gr/collections/xalia' was loaded over HTTPS, but requested an insecure image 'http://cdn-old.spiti-deco.gr/img/xali-paidiko-03.jpg'.
```

Σε άλλες σελίδες δεν κοιτάξαμε την κονσόλα — μόνο σε αυτήν.
