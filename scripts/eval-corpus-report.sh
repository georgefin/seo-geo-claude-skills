#!/usr/bin/env bash
# eval-corpus-report.sh — read every committed blind eval record and report the corpus.
#
# WHY THIS EXISTS (ledger F16 recurrence 1, 2026-08-10):
# The pooled blind figure 427/476 = 89.71% was correct, and it was produced by a hand tally.
# Recomputing it from the committed files exposed two things the tally could not show:
#   (c) TWO SCHEMAS IN ONE DAY. Wave-a records key their numbers under
#       `totals.pass / totals.fail / totals.total`; wave-b under
#       `summary.passed / summary.failed / summary.total`. One record carries no pass_rate at
#       all. The first extractor written against the corpus found only one schema and silently
#       returned 209 of 476 expectations — the failure mode that matters is not an error, it
#       is a smaller number that still looks like an answer.
#   (d) THE EDITOR SLOT IS COUNTED TWO WAYS. Five suites of sixteen record
#       passed + failed = total - 1, leaving the Greek editor's slot uncounted so the published
#       rate treats it as not-passed; eleven count it. The expectations do not explain the
#       split — internal-linking-optimizer e3.4 and performance-reporter e5.3 give the same
#       instruction and were counted opposite ways.
#
# SO THIS SCRIPT REFUSES THE TWO THINGS THAT WENT WRONG:
#   1. It FAILS LOUDLY on any record under a blind-*/ directory it cannot parse, naming the
#      file. A record this cannot read is not skipped, because a silently smaller corpus is
#      exactly F15's "passed by matching nothing" wearing different clothes.
#   2. When the corpus mixes editor-slot conventions it prints BOTH pooled figures, labelled,
#      and prints no single headline. F16(b) is a pooled number quoted as if one thing were
#      being measured; the fix is structural, not a warning in prose.
#
# USAGE
#   scripts/eval-corpus-report.sh            # report; exit 1 if any record is unreadable
#   scripts/eval-corpus-report.sh --strict   # additionally exit 1 if conventions are mixed
#
# ADVISORY BY DEFAULT, and deliberately NOT wired into pre-push-gate.sh: a mixed corpus is a
# true statement about history, and a gate that fails on history cannot be made to pass.
# --strict is for the point where #25 has landed and the mixing should be over.

set -uo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
STRICT=0
[ "${1:-}" = "--strict" ] && STRICT=1

python3 - "$ROOT" "$STRICT" <<'PY'
import json, sys, pathlib

root = pathlib.Path(sys.argv[1]); strict = sys.argv[2] == "1"
GREEN, RED, YEL, DIM, OFF = "\033[0;32m", "\033[0;31m", "\033[1;33m", "\033[2m", "\033[0m"
base = root / "docs/loop/eval-baselines"

# Known record schemas. Add a row here rather than a special case at the call site — the
# point of this script is that every record is read by the same reader.
SCHEMAS = [
    ("totals",  "pass",   "fail",   "total", "pass_rate"),
    ("summary", "passed", "failed", "total", "pass_rate"),
]

def read_record(d):
    for key, p, f, t, r in SCHEMAS:
        s = d.get(key)
        if isinstance(s, dict) and isinstance(s.get(t), int):
            return key, s.get(p), s.get(f), s.get(t), s.get(r)
    return None, None, None, None, None

records = sorted(base.glob("blind-*/*.json"))
indexes = sorted(p for p in base.glob("*.json"))

if not records:
    print(f"{RED}FAIL{OFF}: no per-suite records found under {base}/blind-*/ — "
          f"this reader cannot confirm anything (F15: never pass by matching nothing)")
    sys.exit(1)

print("eval-corpus-report — every committed blind record, one reader (F16-r1)")
print("=" * 86)
print(f"{'suite':16s} {'schema':8s} {'pass':>5} {'fail':>5} {'total':>6} {'uncounted':>10}  rate")

rows, unreadable = [], []
for p in records:
    name = p.stem
    try:
        d = json.loads(p.read_text(encoding="utf-8"))
    except Exception as e:
        unreadable.append((p, f"unparseable JSON: {e}")); continue
    key, pas, fail, tot, rate = read_record(d)
    if key is None:
        unreadable.append((p, "no known schema — expected totals.total or summary.total (int)"))
        continue
    gap = tot - (pas + fail) if isinstance(pas, int) and isinstance(fail, int) else None
    rows.append((name, key, pas, fail, tot, gap, rate))
    flag = f"{YEL}{gap}{OFF}" if gap else str(gap)
    print(f"{name:16s} {key:8s} {str(pas):>5} {str(fail):>5} {str(tot):>6} {flag:>19}  "
          f"{rate if rate is not None else YEL+'(absent)'+OFF}")

for p, why in unreadable:
    print(f"{RED}UNREADABLE{OFF} {p.relative_to(root)}: {why}")

print("=" * 86)
if indexes:
    print(f"{DIM}not pooled — index / multi-suite files, listed so they are not silently "
          f"dropped:{OFF}")
    for p in indexes:
        print(f"{DIM}  {p.relative_to(root)}{OFF}")
    print()

P = sum(r[2] for r in rows); T = sum(r[4] for r in rows)
mixed = [r[0] for r in rows if r[5]]
counted = [r[0] for r in rows if r[5] == 0]

if unreadable:
    print(f"{RED}{len(unreadable)} record(s) unreadable — every figure below is computed over "
          f"{len(rows)} of {len(records)} records and must not be quoted.{OFF}")

if mixed and counted:
    # The corpus mixes conventions. Print both, headline neither.
    print(f"{YEL}MIXED EDITOR-SLOT CONVENTION — no single pooled figure is printed.{OFF}")
    print(f"  {len(mixed)} suite(s) leave the editor slot uncounted (rate treats it as "
          f"not-passed): {', '.join(mixed)}")
    print(f"  {len(counted)} suite(s) count it.")
    print(f"  as recorded, slot not-passed : {P}/{T} = {P/T:.4f}")
    print(f"  slot counted passed throughout: {P+len(mixed)}/{T} = {(P+len(mixed))/T:.4f}")
    print(f"{DIM}  Both are true of this corpus; neither is 'the' rate. Quote the pair or "
          f"quote a suite.{OFF}")
else:
    print(f"pooled {P}/{T} = {P/T:.4f} over {len(rows)} suite(s), one convention throughout")

rates = sorted((r[2] / r[4], r[0]) for r in rows if r[4])
if rates:
    print(f"range: {rates[0][0]:.4f} ({rates[0][1]}) – {rates[-1][0]:.4f} ({rates[-1][1]})")

bad = bool(unreadable) or (strict and mixed and counted)
if unreadable:
    print(f"\n{RED}FAILED{OFF}: unreadable records above.")
elif strict and mixed and counted:
    print(f"\n{RED}FAILED (--strict){OFF}: corpus mixes editor-slot conventions.")
else:
    print(f"\n{GREEN}OK{OFF}: every record under blind-*/ was read by this reader.")
sys.exit(1 if bad else 0)
PY
