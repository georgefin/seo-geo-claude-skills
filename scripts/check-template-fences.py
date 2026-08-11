import re,sys
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
def check(text):
    bad=[]
    for start,lbl,body in blocks(text):
        if lbl!='markdown': continue
        tail=[b for b in body if b.strip()]
        if not tail: continue
        last=tail[-1].strip()
        # A finished template does not end on a colon, a heading, or a bare label.
        if last.endswith(':') or re.match(r'^#{1,6}\s',last):
            bad.append((start,last[:70]))
    return bad
import glob
def confirm(text):
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

targets=sys.argv[1:] or [p for p in sorted(glob.glob('**/*.md',recursive=True))
                         if '.git' not in p and not p.startswith('docs/')]
fail=0
for p in targets:
    try: txt=open(p,encoding='utf-8').read()
    except OSError: continue
    bad=confirm(txt)
    if bad:
        fail+=len(bad)
        for st,l in bad: print("RED  %s: template block opened L%s truncates, ends on %r"%(p,st,l))
print(("\n%d truncated template block(s)"%fail) if fail else "GREEN - no truncated template blocks")
sys.exit(1 if fail else 0)
