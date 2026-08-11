import re,sys,os,glob
def blocks(text):
    """CommonMark fence walk -> list of (open_line, label, content_lines)."""
    L=text.split('\n');out=[];i=0
    while i<len(L):
        m=re.match(r'^\s*(`{3,}|~{3,})\s*(\S*)',L[i])
        if m:
            t,lbl=m.group(1),m.group(2);n=len(t);ch=t[0];start=i+1;body=[]
            i+=1
            while i<len(L):
                c=re.match(r'^\s*(%s{%d,})\s*$'%(re.escape(ch),n),L[i])
                if c: break
                body.append(L[i]);i+=1
            out.append((start,lbl,body))
        i+=1
    return out
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

if len(sys.argv) > 1:
    targets, missing = expand(sys.argv[1:])
else:
    targets = [q for q in sorted(glob.glob('**/*.md', recursive=True))
               if '.git' not in q and not q.startswith('docs/')]
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
print(("\n%d truncated template block(s) in %d file(s) scanned" % (fail, scanned)) if fail
      else "GREEN - no truncated template blocks (%d file(s) scanned)" % scanned)
sys.exit(1 if fail else 0)
