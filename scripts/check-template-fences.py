"""check-template-fences.py — truncated ```markdown template detector.

CORPUS SCOPE — read this before quoting a green (the sibling of the detection-scope
note on confirm() below; that one documents WHICH DEFECT is looked for, this one
documents WHICH FILES are looked at, and an undocumented scope of either kind gets
read as total — F15-r1).

With no arguments the run scans the repo's `**/*.md`, MINUS two exclusions, and both
are printed with every result rather than left to be inferred:

  1. `docs/` — the loop registers, ledgers and pilot notes. These are the project's
     own bookkeeping, not skill deliverables: nothing there is a template a model
     copies, which is the only thing this detector is about. Measured 2026-08-12:
     14 files, and the whole tree contains ZERO ```markdown-labelled blocks (3 bare
     fences, 2 ```text, 1 ```html), so the exclusion currently hides no finding it
     could ever produce. It is a scope decision, not a green.
  2. Anything inside a dot-directory — `.claude/agents/*.md` and
     `.github/PULL_REQUEST_TEMPLATE.md`, 5 files. These are not excluded by choice;
     Python's `glob` does not match dot-directories, so they never entered the
     candidate set at all. They are walked separately here PURELY so the run can name
     them. Measured 2026-08-12: zero ```markdown blocks between them.

224 .md files exist; the default run scans 205 and reports the other 19. Passing an
explicit path or directory argument bypasses both exclusions — an argument means the
caller has chosen the corpus, so nothing is filtered and nothing is reported as
excluded.

Widening the corpus is deliberately NOT done here: it is a scope change, it belongs to
whoever owns the gate wiring, and on today's measurements it would alter no result.
"""
import re,sys,os,glob
def confirm(text):
    """DETECTION SCOPE — read this before quoting a green.

    This finds ONE signature and is not a general fence linter. It reports a block only when
    BOTH hold:
      (a) the block is labelled ```markdown, and its last non-blank line ends with ':' or is a
          heading — i.e. it visibly stops mid-template; AND
      (b) the NEXT block in the file is unlabelled — the nested block that escaped.

    What it therefore MISSES: a truncated template whose last surviving line is ordinary prose
    (no colon, no heading). Two files with the identical defect, one ending on a colon and one
    on prose, produce one RED and one GREEN. A green from this script means "no block matched
    this signature", never "no truncated templates". Widening (a) raises false positives on
    templates that legitimately end on a heading, which is why it is narrow — but the narrowness
    must be quoted with the result (F15-r1: an undocumented scope gets read as total).
    """
    L=text.split('\n');out=[];i=0;bl=[]
    while i<len(L):
        m=re.match(r'^\s*(`{3,}|~{3,})\s*(\S*)',L[i])
        if m:
            t,lbl=m.group(1),m.group(2);n=len(t);ch=t[0];st=i+1;body=[];i+=1
            while i<len(L) and not re.match(r'^\s*(%s{%d,})\s*$'%(re.escape(ch),n),L[i]):
                body.append(L[i]);i+=1
            bl.append((st,lbl,body))
        i+=1
    for idx,(st,lbl,body) in enumerate(bl):
        if lbl!='markdown': continue
        tail=[b for b in body if b.strip()]
        if not tail: continue
        last=tail[-1].strip()
        if not (last.endswith(':') or re.match(r'^#{1,6}\s',last)): continue
        if idx+1<len(bl) and bl[idx+1][1]=='':
            out.append((st,last[:60]))
    return out

def expand(args):
    """Directory -> its .md files. Missing/unreadable path is an ERROR, never a skip."""
    out, missing = [], []
    for a in args:
        if os.path.isdir(a):
            found = sorted(glob.glob(os.path.join(a, '**', '*.md'), recursive=True))
            if not found: missing.append("%s (directory contains no .md)" % a)
            out += found
        elif os.path.isfile(a):
            out.append(a)
        else:
            missing.append("%s (not found)" % a)
    return out, missing

DOCS_ROOT = 'docs'   # excluded corpus root — rationale in the module docstring

def components(q):
    """Path split into components on either separator.

    Membership tests run against THIS, never against the raw path: `'.git' in q` is an
    unanchored substring test on a namespace we do not own, and a substring match
    against someone else's namespace is not a test (R297). It happens to bite nothing
    today only because glob never yields a dot-directory in the first place, so the
    old form was a latent trap that read as a working guard.
    """
    return q.replace('\\', '/').split('/')

def default_targets():
    """The no-argument corpus AND the exclusions applied to it — returned, never hidden.

    Returns (targets, excluded) where excluded maps a reason to the sorted paths dropped
    for it, so the caller can print the scope alongside the verdict.
    """
    targets, docs_excluded = [], []
    for q in sorted(glob.glob('**/*.md', recursive=True)):
        parts = components(q)
        if '.git' in parts[:-1]:
            continue                      # anchored on the directory component itself
        if parts[0] == DOCS_ROOT:
            docs_excluded.append(q)
            continue
        targets.append(q)

    # glob(recursive=True) never matches dot-directories, so these were absent from the
    # candidate set above rather than filtered out of it. Walked here only to NAME them:
    # they are reported, not scanned. Silently missing files are the failure this whole
    # note exists to prevent.
    dot_excluded = []
    for root, dirs, files in os.walk('.'):
        dirs[:] = [d for d in dirs if d != '.git']
        for fn in files:
            if not fn.endswith('.md'):
                continue
            rel = os.path.relpath(os.path.join(root, fn), '.')
            if any(c.startswith('.') for c in components(rel)[:-1]):
                dot_excluded.append(rel)

    return targets, {
        'under %s/ (project bookkeeping, not skill templates)' % DOCS_ROOT: sorted(docs_excluded),
        'inside a dot-directory (glob does not match these)': sorted(dot_excluded),
    }

if len(sys.argv) > 1:
    targets, missing = expand(sys.argv[1:])
    excluded = {}                          # an explicit argument IS the chosen corpus
else:
    targets, excluded = default_targets()
    missing = []

if missing:
    for m in missing: print("ERROR  unresolvable target: %s" % m, file=sys.stderr)
    sys.exit(2)

fail = 0
scanned = 0
errors = 0
for q in targets:
    try:
        txt = open(q, encoding='utf-8').read()
    except OSError as e:
        print("ERROR  unreadable: %s (%s)" % (q, e.__class__.__name__), file=sys.stderr)
        errors += 1
        continue
    scanned += 1
    for st, l in confirm(txt):
        fail += 1
        print("RED  %s: template block opened L%s truncates, ends on %r" % (q, st, l))

# R-0222: a checker MUST fail closed on an empty scan set. Zero files scanned is
# an ERROR, never a pass — this script printed GREEN on a directory argument
# before this guard existed, having read nothing.
if errors:
    print("\nERROR - %d target(s) unreadable; scanned %d" % (errors, scanned), file=sys.stderr)
    sys.exit(2)
if scanned == 0:
    print("ERROR - scanned 0 files. A checker that scans nothing does not pass (R-0222).",
          file=sys.stderr)
    sys.exit(2)
# Scope goes out WITH the result, both on RED and on GREEN. A run that prints only what
# it scanned invites the reader to supply "…and that was everything", which is the same
# undocumented-scope failure the module docstring names one level up.
n_excluded = sum(len(v) for v in excluded.values())
if n_excluded:
    print("\nCORPUS EXCLUSIONS - %d of %d .md file(s) NOT scanned:" % (n_excluded, scanned + n_excluded))
    for reason in sorted(excluded):
        paths = excluded[reason]
        if not paths:
            continue
        print("  %d %s" % (len(paths), reason))
        for p in paths:
            print("      %s" % p)

scope = "%d file(s) scanned" % scanned
if n_excluded:
    scope += ", %d excluded (listed above)" % n_excluded
print(("\n%d truncated template block(s) in %s" % (fail, scope)) if fail
      else "GREEN - no truncated template blocks (%s)" % scope)
sys.exit(1 if fail else 0)
