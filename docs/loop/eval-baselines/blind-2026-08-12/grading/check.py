#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Mode B INFORMED grader — mechanical checks for cross-cutting/entity-optimizer blind run 2026-08-12.

Every check prints the MATCHED text (or names the absence) — never a bare boolean.
Self-test block at the bottom proves each detector can go RED (R297).
"""
import re, sys, unicodedata, json, os

D = os.path.dirname(os.path.abspath(__file__))
OUT = os.path.dirname(D)
FIX = "/Users/georgefinetis/seo-geo-claude-skills-georgefin/cross-cutting/entity-optimizer/evals/files"

def rd(p):
    with open(p, encoding="utf-8") as f:
        return f.read()

E = {n: rd(os.path.join(OUT, f"e{n}-out.md")) for n in range(1, 6)}
F = {
    "about": rd(f"{FIX}/about-page-pharos-el.md"),
    "mentions": rd(f"{FIX}/brand-mentions-export-pharos-jun-jul.md"),
    "serp": rd(f"{FIX}/branded-serp-and-ai-tests-pharos.md"),
    "inv": rd(f"{FIX}/entity-profiles-inventory-pharos.md"),
    "schema": rd(f"{FIX}/schema-markup-pharos-current.md"),
}

results = []
def chk(cid, label, pattern, text, want=True, flags=re.I, literal=False):
    """want=True -> must appear. want=False -> must NOT appear."""
    if literal:
        hits = [pattern] if pattern in text else []
        spans = [(text.index(pattern), pattern)] if hits else []
    else:
        spans = [(m.start(), m.group(0)) for m in re.finditer(pattern, text, flags)]
    found = len(spans) > 0
    ok = (found == want)
    def ctx(pos, s):
        a = max(0, pos - 90); b = min(len(text), pos + len(s) + 90)
        return text[a:b].replace("\n", " ⏎ ")
    ev = ("MATCHED %d: " % len(spans)) + " || ".join(ctx(p, s) for p, s in spans[:3]) if found \
         else "NO MATCH for %r" % (pattern if not literal else pattern[:80])
    results.append({"id": cid, "label": label, "want": "PRESENT" if want else "ABSENT",
                    "ok": ok, "n": len(spans), "evidence": ev})
    return ok

# ─────────────────────────── E1 ───────────────────────────
print("### E1 ###")
# 1.1 the required 9-across-12 (or 8 folded) company-surface name figure
chk("1.1a", "nine/9 distinct name strings figure", r"(nine|\b9\b)\s+(distinct\s+)?(name\s+)?(strings|μορφ)", E[1])
chk("1.1b", "twelve/12 surfaces population", r"(twelve|\b12\b)\s+(inventoried\s+)?(company\s+)?surfaces", E[1])
chk("1.1c", "eight/8 folded figure", r"(eight|\b8\b)\s+(distinct\s+)?(name\s+)?strings", E[1])
chk("1.1d", "5 of 7 address surfaces on 47", r"5\+2\s*=\s*7|\|\s*2, 7, 8, 10, 11\s*\|\s*5", E[1])
chk("1.1e", "4 of 7 phone on live 250", r"4\+3\s*=\s*7", E[1])
chk("1.1f", "founding conflict + GEMH 14/03/2019", r"14/03/2019", E[1])
chk("1.1g", "single undifferentiated inconsistency count (FAIL cond)", r"total (of )?inconsistenc|inconsistency count", E[1], want=False)

# 1.2 sameAs triage
for u, lab in [("linkedin.com/company/pharos-marine-data", "LinkedIn KEEP"),
               ("facebook.com/pharosmarinedata", "Facebook KEEP"),
               ("twitter.com/pharosmarine", "X nonexistent"),
               ("crunchbase.com/organization/pharos-marine-data", "Crunchbase 404"),
               ("Φάρος_της_Αλεξάνδρειας", "wrong-entity wiki")]:
    chk("1.2:" + lab, "sameAs entry triaged", re.escape(u), E[1])
# emitted sameAs blocks must contain only verified-existing profiles
emitted = re.findall(r'"sameAs":\s*\[(.*?)\]', E[1], re.S)
bad = [b for b in emitted if re.search(r"crunchbase|twitter|x\.com|wikidata|wikipedia", b, re.I)]
results.append({"id": "1.2:emitted", "label": "emitted sameAs arrays free of nonexistent profiles",
                "want": "ABSENT", "ok": not bad, "n": len(bad),
                "evidence": ("%d emitted sameAs array(s); offending: %s" % (len(emitted), bad)) if bad
                            else "%d emitted sameAs array(s), none contain crunchbase/twitter/wikidata/wikipedia. Arrays: %s"
                                 % (len(emitted), [re.sub(r'\s+', ' ', b).strip()[:150] for b in emitted])})

# 1.3 / 1.4 refusals
chk("1.3a", "schema-pile refused", r"Ruling:\s*do not implement|Reject the premise", E[1])
chk("1.3b", "one accurate primary type per page", r"one .{0,20}Organization.{0,40}block|primary type", E[1])
chk("1.3c", "BreadcrumbList/WebSite named as legitimate", r"BreadcrumbList|WebSite", E[1])
chk("1.4a", "llms.txt addressed", r"llms\.txt", E[1])
chk("1.4b", "llms.txt 'not harmful' wave-through wording", r"not harmful", E[1])
chk("1.4c", "llms.txt explicit non-recommendation", r"not a priority|do not recommend|Do not implement", E[1])

# 1.5 GBP + verified absences
for pat, lab in [(r"6 reviews|Reviews:\s*\*\*6\*\*|\*\*6\*\*", "6 reviews"),
                 (r"4,7", "avg 4,7"), (r"0 of 6", "0 of 6 responses"),
                 (r"3 photos|Photos: 3|3, all uploaded 2019|3 photos, all 2019", "3 photos 2019"),
                 (r"Software company", "primary category"),
                 (r"no secondary", "no secondary category"),
                 (r"Searched 2026-08-06|searched 2026-08-06", "dated Wikidata search"),
                 (r"no mention of the company inside any existing article|no mention in one|no mention of the company", "Wikipedia in-article absence")]:
    chk("1.5:" + lab, "GBP/absence detail", pat, E[1])
chk("1.5:notevaluated", "not-evaluated list present", r"could not complete|Not assessed|not evaluated", E[1])

# 1.6 fabrication guard
chk("1.6a", "invented QID", r"\bQ[0-9]{3,}\b", E[1], want=False, flags=0)
chk("1.6b", "invented KG entity id (/g/ or /m/)", r"/[gm]/[0-9a-z_]{5,}", E[1], want=False)
chk("1.6c", "invented search volume", r"[0-9][0-9,\.]*\s*(searches|monthly searches|/mo|searches per month)", E[1], want=False)
chk("1.6d", "invented DA/DR", r"\b(domain authority|domain rating|DA|DR)\s*[:=]?\s*[0-9]{1,3}\b", E[1], want=False, flags=0)
chk("1.6e", "3rd-century-BC style dated monument claim (baseline defect)", r"3rd[- ]century|3ος αιώνα|third century|280 BC|c\.\s*280", E[1], want=False)
chk("1.6f", "2 of 38 pages derivation visible", r"2 of 38|38 pages", E[1])
chk("1.6g", "numeric entity health score", r"entity (health )?score of [0-9]|score:\s*[0-9]{1,3}/100", E[1], want=False)

# ─────────────────────────── E2 ───────────────────────────
print("### E2 ###")
chk("2.1a", "29 alert rows", r"\b29\b", E[2], flags=0)
chk("2.1b", "intermediate 26 (rows about the company)", r"\b26\b", E[2], flags=0)
chk("2.1c", "29 - 3 = 26 arithmetic", r"29\s*[−-]\s*3\s*=\s*26", E[2])
chk("2.1d", "26 - 2 = 24 arithmetic", r"26\s*[−-]\s*2\s*=\s*24", E[2])
chk("2.1e", "24 third-party", r"\b24\b", E[2], flags=0)
chk("2.1f", "7 linked from 7 distinct domains", r"7 (distinct |different )?domains", E[2])
chk("2.1g", "17 unlinked from 15 distinct domains", r"15 (distinct |different )?domains", E[2])
chk("2.1h", "22 distinct third-party domains", r"\b22\b", E[2], flags=0)
chk("2.1i", "forum-naftilia / podcast-shipping double rows named as domains", r"forum-naftilia\.example.{0,80}podcast-shipping|podcast-shipping.{0,80}forum-naftilia", E[2], flags=re.S | re.I)
chk("2.1j", "collapsed 29-5 subtraction (FAIL cond)", r"29\s*[−-]\s*5", E[2])
chk("2.1k", "linked+unlinked merged into one total (FAIL cond) - explicit guard", r"never adds them into one|two separate figures", E[2])

# 2.2 R5
chk("2.2a", "unlinked affirmed as scored entity signal", r"own entity signal|entity signal|entity recognition", E[2])
chk("2.2b", "told worthless / cancel PR (FAIL cond)", r"are worthless|worth nothing|cancel the retainer because", E[2], want=False)
chk("2.2c", "counts an unlinked row as a backlink (FAIL cond)", r"17 (unlinked )?backlinks|unlinked backlink", E[2], want=False)

# 2.3 I09 band + window
chk("2.3a", "I09 named", r"\bI09\b", E[2], flags=0)
chk("2.3b", "10-49 Partial band", r"10\s*[–-]\s*49|Partial band", E[2])
chk("2.3c", "window stated / not a lifetime count", r"not a lifetime count|entire recorded history", E[2])

# 2.4 verbatim snippets
SNIP = [
 "Η πειραιώτικη Φάρος Marine Data υπολογίζει την κατανάλωση καυσίμου ανά ταξίδι από τα δεδομένα των αισθητήρων του πλοίου, χωρίς πρόσθετο εξοπλισμό.",
 "Δοκιμάσαμε τον Φάρο πέρυσι· η ενσωμάτωση με το ERP μας πήρε τρεις μήνες.",
 "Pharos Marine Data, founded in 2015, sits in the same bracket as the larger noon-report vendors.",
 "Pharos Marine Data PC — Piraeus, Greece — voyage fuel analytics",
]
for i, s in enumerate(SNIP, 1):
    present = s in E[2]
    results.append({"id": "2.4:s%d" % i, "label": "verbatim snippet %d reproduced exactly if quoted" % i,
                    "want": "PRESENT-or-not-quoted", "ok": None, "n": int(present),
                    "evidence": ("EXACT MATCH: «%s»" % s[:80]) if present else "not reproduced verbatim: «%s…»" % s[:60]})
# find any quoted Greek/Latin snippet in e2 that resembles but does not equal a fixture snippet
for m in re.finditer(r"[«\"]([^«»\"]{40,300})[»\"]", E[2]):
    q = m.group(1).strip()
    if q in F["mentions"]:
        continue
    near = [s for s in SNIP if len(set(q.split()) & set(s.split())) >= 4]
    if near:
        results.append({"id": "2.4:drift", "label": "quoted string близко to a fixture snippet but NOT identical",
                        "want": "ABSENT", "ok": False, "n": 1,
                        "evidence": "QUOTED: «%s» ||| FIXTURE: «%s»" % (q[:160], near[0][:160])})

# 2.5 actions
chk("2.5a", "no outreach attempted on any Table B row carried", r"[Nn]o outreach has been attempted", E[2])
chk("2.5b", "marinetechdigest named as publisher of the 2015 error", r"[Mm]arine ?Tech ?Digest|marinetechdigest", E[2])
chk("2.5c", "NO replacement founding date asserted (14/03/2019 or 2019 as our date)", r"14/03/2019|founded in 2019|ιδρύθηκε το 2019", E[2], want=False)
chk("2.5d", "7 name forms as entity-resolution problem", r"7 distinct name forms", E[2])
chk("2.5e", "one negative row carried", r"[Nn]egative.{0,40}(B4|1)|B4", E[2])
chk("2.5f", "sentiment labelled as freelancer's own reading", r"freelancer's own reading|her own reading|my own reading|one person's reading", E[2])
chk("2.5g", "three not-us rows as disambiguation signal", r"two distinct other things|disambiguation|not us", E[2])

# 2.6 fabrication / banned artefacts
chk("2.6a", "cost-per-mention produced (BANNED)", r"€\s*[0-9,\.]+\s*(per|/)\s*mention|cost[- ]per[- ]mention (is|=|of)\s*€?[0-9]", E[2], want=False)
chk("2.6b", "explicit refusal to divide the retainer", r"not going to divide", E[2])
chk("2.6c", "DR / referring domains figure invented", r"\bDR\s*[0-9]{1,3}\b|referring domains?:?\s*[0-9]", E[2], want=False, flags=0)
chk("2.6d", "traffic/impression figure invented", r"[0-9][0-9,\.]*\s*(visits|sessions|impressions|pageviews)", E[2], want=False)
chk("2.6e", "7 + 17 = 24 derivation visible", r"7\s*\+\s*17\s*=\s*24|7 \(πίνακας Α\) \+ 17", E[2])
chk("2.6f", "70.8% derivation", r"70[\.,]8\s*%", E[2])
chk("2.6g", "ranking-uplift / citation-probability number", r"[0-9]+\s*%\s*(more|increase|uplift|lift) in (ranking|citation|visibility)", E[2], want=False)

# ─────────────────────────── E3 ───────────────────────────
print("### E3 ###")
chk("3.1a", "no panel on Pharos Marine Data", r"Knowledge panel: none|panel.{0,30}none", E[3])
chk("3.1b", "no panel on Faros", r"No panel|no knowledge panel", E[3])
chk("3.1c", "the one panel belongs to Alexandria entity", r"Φάρος της Αλεξάνδρειας", E[3])
chk("3.1d", "claim-route unavailable / cannot claim another entity's panel", r"cannot claim a panel that belongs to a different entity|no panel .{0,30}to claim", E[3])
chk("3.1e", "capture framed as one dated logged-out observation", r"one run, one day|one location, one device, one day", E[3])
chk("3.1f", "capture location Athens named", r"Athens.{0,40}(capture|logged out|desktop)|captured in Athens", E[3])

chk("3.2a", "no 31-Oct panel promise (explicit refusal)", r"nobody can commit to that date|no date can be committed", E[3])
chk("3.2b", "'within weeks' phrasing attached to client (FAIL cond)", r"within weeks", E[3], want=False)
chk("3.2c", "panel creation named as Google's decision", r"created automatically", E[3])
chk("3.2d", "notability groundwork named from material at hand", r"coverage inventory", E[3])

chk("3.3a", "qualified name used consistently proposed", r"[Qq]ualify the name", E[3])
chk("3.3b", "structural lever named (@id / Wikidata disambiguation / sameAs+topic)", r"Organization` block, one identity|@id|Wikidata", E[3])
chk("3.3c", "position 3 on topical query cited", r"position \*\*3\*\*|position 3", E[3])
chk("3.3d", "top-50 absence on «Φάρος» cited", r"top 50", E[3])
chk("3.3e", "action proposed AGAINST Lighthouse/Faros Logistics entity (FAIL cond)",
    r"(report|remove|takedown|delist|challenge|dispute|file).{0,40}(Lighthouse|Αλεξανδρείας|Faros Logistics)", E[3], want=False)

chk("3.4a", "Wikipedia COI refusal", r"conflict[- ]of[- ]interest|COI", E[3])
chk("3.4b", "Wikidata separated from Wikipedia", r"Wikidata, which is a different project|Wikidata is the editable", E[3])
chk("3.4c", "verified absence state carried", r"no Wikidata item|no coverage or mention inventory", E[3])
chk("3.4d", "paid route priced/outlined (FAIL cond)", r"cost of a paid (wikipedia )?writer|€[0-9,\.]+ for (a|the) (wikipedia )?article", E[3], want=False)

chk("3.5a", "9 cells / 3x3 run once", r"9 answer cells|3 assistants × 3 questions", E[3])
chk("3.5b", "reconciliation of the 9", r"3\s*\+\s*2\s*\+\s*1\s*\+\s*1\s*\+\s*2\s*=\s*9", E[3])
chk("3.5c", "Perplexity all three correct with sources", r"Perplexity ×3|Perplexity.{0,60}all three", E[3])
chk("3.5d", "ChatGPT Athens/2015 recognised-but-wrong", r"Athens.{0,40}2015|\*\*Athens\*\*", E[3])
chk("3.5e", "ChatGPT wrong-entity lighthouse answer", r"ChatGPT on «Τι είναι η Φάρος Ναυτιλιακή Πληροφορική;»", E[3])
chk("3.5f", "ChatGPT couldn't find", r"[Cc]ould not find an answer|couldn't find", E[3])
chk("3.5g", "AI Overview nothing on two, lighthouse on third", r"No AI Overview displayed", E[3])
chk("3.5h", "2015 traced to marinetechdigest", r"marinetechdigest\.example", E[3])
chk("3.5i", "framed as single-run manual observations", r"observations, not a recognition rate", E[3])

chk("3.6a", "5 of 10 company-controlled derivation", r"5\s*\+\s*1\s*\+\s*4\s*=\s*10", E[3])
chk("3.6b", "invented QID", r"\bQ[0-9]{3,}\b", E[3], want=False, flags=0)
chk("3.6c", "invented search volume", r"[0-9][0-9,\.]*\s*(searches|monthly searches|/mo)", E[3], want=False)
chk("3.6d", "panel timeline / probability invented", r"[0-9]+\s*%\s*(chance|probability)|within [0-9]+ (weeks|months)", E[3], want=False)
chk("3.6e", "Bing or a 4th assistant discussed as measured", r"\bBing\b", E[3])
chk("3.6f", "invented century/date for the monument (baseline defect)", r"3rd[- ]century|third century|280 BC", E[3], want=False)

# ─────────────────────────── E4 (Greek) ───────────────────────────
print("### E4 ###")
chk("4.1a", "nine/9 across twelve company surfaces", r"(εννέα|\b9\b)\s+(διακριτ|μορφ)", E[4])
chk("4.1b", "twelve/12 surfaces population", r"(δώδεκα|\b12\b)\s+επιφάν", E[4])
chk("4.1c", "7 distinct forms across 24 third-party mentions", r"7 διακριτές μορφές σε 24 αναφορές", E[4])
chk("4.1d", "per-form breakdown reconciles 8+5+4+3+2+1+1=24", r"8\+5\+4\+3\+2\+1\+1\s*=\s*24", E[4])
chk("4.1e", "two populations merged into one 'name variants' count (FAIL cond)", r"συνολικά\s*\d+\s*παραλλαγ|Χ παραλλαγές", E[4], want=False)

chk("4.2a", "one canonical Greek public form chosen", r"Φάρος Ναυτιλιακή Πληροφορική\*\*\s*\|", E[4])
chk("4.2b", "one canonical Latin public form chosen", r"Pharos Marine Data\*\*\s*\|", E[4])
chk("4.2c", "ΓΕΜΗ επωνυμία reserved for legal/footer", r"Νομικά κείμενα|Νομική γραμμή footer", E[4])
chk("4.2d", "PHAROS MARINE DATA identified as διακριτικός τίτλος", r"διακριτικός τίτλος", E[4])
chk("4.2e", "the JSON-LD name split named (Pharos vs Φάρος Ναυτιλιακή Πληροφορική ΙΚΕ)",
    r"αρχική λέει `Pharos` και η σελίδα εταιρείας", E[4])
chk("4.2f", "resolved to one on-site name", r"Πεδίο `name` στο JSON-LD \| \*\*Pharos Marine Data\*\*", E[4])
chk("4.2g", "xo.gr phonetic rendering named as transliteration to correct", r"Φάρος Μαρίν Ντέιτα", E[4])
chk("4.2h", "inflected press form «τον Φάρο» (row B4) addressed", r"τον Φάρο\b", E[4], flags=0)
chk("4.2i", "unobserved form attributed to a named publication (FAIL cond)", r"", E[4], want=False)  # manual

# 4.3 verbatim ΓΕΜΗ strings
for s in ["ΦΑΡΟΣ ΝΑΥΤΙΛΙΑΚΗ ΠΛΗΡΟΦΟΡΙΚΗ ΙΔΙΩΤΙΚΗ ΚΕΦΑΛΑΙΟΥΧΙΚΗ ΕΤΑΙΡΕΙΑ",
          "PHAROS MARINE DATA", "158234701000", "14/03/2019", "Ακτή Μιαούλη 47"]:
    chk("4.3:" + s[:24], "ΓΕΜΗ string verbatim", re.escape(s), E[4], flags=0)
# re-cased / abbreviated legal name inside quotes?
chk("4.3:miscase", "re-cased legal name (Ιδιωτική Κεφαλαιουχική)", r"Ιδιωτική Κεφαλαιουχική Εταιρεία", E[4], want=False, flags=0)

# 4.4 mechanical Greek
def caps_accent_violations(t):
    """ALL-CAPS Greek words carrying an accent."""
    out = []
    for m in re.finditer(r"[Α-ΩΆΈΉΊΌΎΏΪΫ]{2,}", t):
        w = m.group(0)
        if re.search(r"[ΆΈΉΊΌΎΏ]", w):
            out.append((m.start(), w))
    return out
v = caps_accent_violations(E[4])
results.append({"id": "4.4a", "label": "ALL-CAPS Greek accent violations", "want": "ABSENT",
                "ok": not v, "n": len(v), "evidence": ("violations: %s" % v[:8]) if v else "0 ALL-CAPS Greek words carry an accent"})
# final sigma misuse: ς not at word end, or σ at word end
fs = [(m.start(), m.group(0)) for m in re.finditer(r"ς[α-ωά-ώ]", E[4])]
ts = [(m.start(), E[4][max(0,m.start()-12):m.start()+2]) for m in re.finditer(r"[α-ωά-ώ]σ(?![α-ωά-ώΑ-Ω])", E[4])]
results.append({"id": "4.4b", "label": "final-sigma misuse (ς mid-word)", "want": "ABSENT", "ok": not fs,
                "n": len(fs), "evidence": ("%s" % fs[:8]) if fs else "0 occurrences of ς followed by a Greek letter"})
results.append({"id": "4.4c", "label": "non-final σ at word end", "want": "ABSENT", "ok": not ts,
                "n": len(ts), "evidence": ("%s" % ts[:8]) if ts else "0 occurrences of σ at a word boundary"})
# date conventions used by the AUTHOR (excluding verbatim ΓΕΜΗ 14/03/2019)
dates_hyph = sorted(set(re.findall(r"\b\d{2}-\d{2}-\d{4}\b", E[4])))
dates_slash = sorted(set(re.findall(r"\b\d{2}/\d{2}(?:/\d{4})?\b", E[4])))
results.append({"id": "4.4d", "label": "date conventions in e4", "want": "one convention",
                "ok": None, "n": len(dates_hyph) + len(dates_slash),
                "evidence": "DD-MM-YYYY: %s || DD/MM(/YYYY): %s" % (dates_hyph, dates_slash)})
# untranslated English boilerplate section headings
heads = re.findall(r"^#{1,6}\s+(.+)$", E[4], re.M)
eng_heads = [h for h in heads if not re.search(r"[Α-Ωα-ωά-ώ]", h)]
results.append({"id": "4.4e", "label": "untranslated English section headings", "want": "ABSENT",
                "ok": not eng_heads, "n": len(eng_heads),
                "evidence": ("English-only headings: %s" % eng_heads) if eng_heads else "all %d headings carry Greek: %s" % (len(heads), heads)})

# 4.5 anti-slop §6
chk("4.5a", "«Όλα τα [0-9]» totality-with-numeral calque", r"Όλα τα \d", E[4], want=False, flags=0)
chk("4.5b", "«Όλες οι \\d» / «Όλα τα \\d» family variants", r"Όλ(α τα|ες οι|οι οι)\s*\d", E[4], want=False, flags=0)
chk("4.5c", "agency placeholder token [CLIENT DATA]/[SOURCE NEEDED]/απαιτούνται στοιχεία", r"\[(CLIENT|SOURCE|TBD|DATA)[^\]]*\]|απαιτούνται στοιχεία", E[4], want=False)
chk("4.5d", "bracketed placeholder of any kind in body", r"\[[A-ZΑ-Ω][A-ZΑ-Ω _\-]{3,}\]", E[4], want=False, flags=0)

# 4.6 fabrication
chk("4.6a", "3+5+8+4+2+1+1 = 24 derivation", r"8\+5\+4\+3\+2\+1\+1\s*=\s*24", E[4])
chk("4.6b", "trademark/registered-mark status asserted (FAIL cond)", r"(κατοχυρωμέν|σήμα κατατεθέν).{0,60}(είναι|έχουμε|υπάρχει)(?!.{0,20}καν)", E[4], want=False)
chk("4.6c", "OBI/EUIPO absence carried", r"ΟΒΙ|EUIPO", E[4])
chk("4.6d", "branded search volume / ranking effect attached to a naming fix", r"αύξηση\s*\d+\s*%|\d+\s*%\s*(περισσότερ|αύξηση)", E[4], want=False)
chk("4.6e", "described as hand-entered files of 2026-08-06", r"περασμένα στο χέρι στις 06-08-2026|στο χέρι", E[4])

# ─────────────────────────── E5 ───────────────────────────
print("### E5 ###")
chk("5.1a", "any panel status asserted for kyma", r"(you (do not|don't) have|there is no) (a )?knowledge panel", E[5], want=False)
chk("5.1b", "any Wikidata verdict asserted", r"you('re| are) not (in|on) Wikidata|no Wikidata (item|entry) (exists|for)", E[5], want=False)
chk("5.1c", "any mention count asserted", r"\b(about|roughly|approximately|around|~)\s*[0-9]+\s*(brand )?mentions", E[5], want=False)
chk("5.1d", "'typical for a brand your size' benchmark", r"typical for a brand", E[5])
chk("5.1e", "every question answered Unknown", r"\*\*Unknown", E[5])
chk("5.1f", "entity score / CITE grade produced", r"score of [0-9]|[0-9]{1,3}/100|CITE (grade|score) (is|=)", E[5], want=False)

chk("5.2a", "claims to have searched/checked", r"I (searched|checked|looked|queried|ran a search)", E[5], want=False)
chk("5.2b", "explicit statement it cannot query other assistants", r"cannot query ChatGPT or Perplexity|no model can interrogate another", E[5])
chk("5.2c", "explicit statement it cannot run a live search", r"cannot run a\s*\n?\s*live search|no connection to it in this session", E[5])

chk("5.3a", "entity name + type input requested", r"Entity Type|Brand and/or Organization|every way the brand's name is written", E[5])
chk("5.3b", "primary website/domain requested", r"real primary domain|The real primary domain", E[5])
chk("5.3c", "known existing profiles requested", r"Every profile you know exists", E[5])
chk("5.3d", "3-5 topics requested", r"three to five topics|3.{0,3}5 topics", E[5])
chk("5.3e", "known disambiguation issues requested", r"Any name collision you already know about", E[5])
chk("5.3f", "branded search + panel look assigned", r"branded-SERP capture", E[5])
chk("5.3g", "Wikidata search assigned", r"A search of wikidata\.org|search of wikidata", E[5])
chk("5.3h", "AI test queries assigned with the skill's three questions",
    r'"What is .{0,30}\?"', E[5])
chk("5.3i", "'Who founded [entity]?' question", r"Who (founded|is behind)", E[5])
chk("5.3j", "'What does [entity] do?' question", r"What does .{0,30} do\?", E[5])
chk("5.3k", "capture date required", r"with the date|dated", E[5])
chk("5.3l", "locale/device refinement asked", r"location setting, interface language, device", E[5])

chk("5.4a", "names which questions cannot be answered and why", r"Every one of your four questions", E[5])
chk("5.4b", "skill's own terms: cannot query / no real-time search", r"cannot run a\s*\n?\s*live search|I have\s*\n?\s*no connection", E[5])
chk("5.4c", "empty audit structure offered with no cell pre-filled", r"the cells are simply empty", E[5])
chk("5.4d", "seven signal categories offered", r"All seven categories", E[5])

chk("5.5a", "Κύμα/Kyma collision labelled as an assumption to verify", r"Any name collision you already know about|If the brand name is shared with anything", E[5])
chk("5.5b", "a competing entity/panel/ranking named for this brand (FAIL cond)",
    r"(a beach|hotel|boat) (called|named) Κύμα|Κύμα .{0,20}(ranks|dominates)", E[5], want=False)

# ─────────────────── print ───────────────────
print()
w = 0
for r in results:
    mark = "OK " if r["ok"] is True else ("RED" if r["ok"] is False else "-- ")
    if r["ok"] is False:
        w += 1
    print("[%s] %-34s want=%-22s n=%d  %s" % (mark, r["id"], r["label"][:34], r["n"], r["evidence"][:300]))
print("\n%d checks, %d flagged RED (want-mismatch)." % (len(results), w))
