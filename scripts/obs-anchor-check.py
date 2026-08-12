#!/usr/bin/env python3
"""obs-anchor-check.py — re-runs the [obs:] anchors that assert a measurement.

WHY THIS EXISTS
    `claims-gate.sh:8-10` says of itself: it "enforces FORM, not truth ... The truth leg
    stays with the mandatory Mode A review." So the gate accepts any well-formed
    `[obs:...]` anchor, including one whose own quoted command refutes it. That is not
    hypothetical: `docs/loop/OPEN-FINDINGS.md` shipped in `ceddc85` claiming
    "31 rows / 8 in D" under the anchor
    `[obs: `grep -cE '^\\| [0-9]+ \\|'` = 31 ...]`, and running the anchor's own quoted
    command against that same blob returns 32. Mode A pass 4 caught it by hand.

    A false [obs:] anchor is worse than an unanchored claim, because it retires the
    reader's obligation to check. Where an anchor's content IS a runnable command and its
    asserted output, that obligation is machine-dischargeable. This script discharges it.

WHAT IT CHECKS (and only this)
    A "claim" is a backticked command inside an [obs:...] anchor followed by an assertion
    of one of exactly two shapes:
        `<cmd>` = <int>                     the command's stdout must be that integer
        `<cmd>` = <int> in <file.md>        ... measured against a named file,
                                            with `, <int> in <file.md>` continuations
    The command is re-run and stdout compared. Nothing else is compared to anything.

WHAT IT PROVABLY CANNOT CHECK (never counted as a pass; printed with a reason code)
    - `prose`                     an anchor with no command at all ("re-read of the three
                                  loci", "curl + WebFetch, both refused at the gateway").
                                  Most anchors in this corpus are this. They are
                                  UNCHECKABLE, full stop — no amount of tooling re-runs a
                                  human observation.
    - `template-mention`          the literal string `[obs:]` or `[obs:<PLACEHOLDER>]`
                                  written as an EXAMPLE of the form (the plan's spec line,
                                  the ledger prose about anchors). Parsed as an anchor
                                  because it is one syntactically; counted apart so it
                                  cannot pad either the checkable or the prose figure.
    - `not-a-command`             a backticked span that is a filename, a literal, an env
                                  assignment or a Greek phrase, not an invocation.
                                  Markdown inline code marks all of these. Distinguished
                                  from `head-not-allowlisted` on purpose: "11 refused
                                  commands" and "2 refused commands plus 9 filenames" are
                                  different facts about this corpus.
    - `no-assertion`              a command with no asserted output (`git log -1 <sha>`) —
                                  a provenance pointer, not a measurement. Routed to the
                                  weaker PROVENANCE leg below.
    - `assertion-shape`           an assertion the command's stdout cannot be compared to:
                                  "= 7 files" after a grep that prints lines, not files;
                                  "-> 15 passed / 0 failed"; "GREEN, 205 files scanned".
                                  Rewriting the author's command to make it checkable
                                  would be checking a command nobody ran.
    - `assertion-without-command` a bare "= <int>" in the anchor bound to no command
                                  ("section D = 9").
    - `head-not-allowlisted`      the command is a project script or anything else outside
                                  the read-only allowlist. See SAFETY.
    - `unsafe-syntax`             shell metacharacters or an unexpanded glob (see SAFETY).
    - `unparseable-argv`          the flag table cannot decide whether a file operand is
                                  present, so the implicit-target rule cannot be applied
                                  safely. Bails rather than guessing.
    - `ambiguous-target`          a named target basename resolves to 0 or >1 files.
    - `output-shape`              the command ran but stdout is not a single integer.

    A run states the checkable / uncheckable split every time. Uncheckable is reported in
    its own block with per-reason counts and is NEVER folded into the pass count.

    Deeper boundary, stated plainly: this verifies that a command still reproduces its
    asserted number. It cannot verify that the number supports the sentence built on it.
    "32 rows" reproducing says nothing about whether "8 in D" was ever true. The claim
    that a measurement means what the prose says it means stays with Mode A.

SAFETY — anchor content is UNTRUSTED INPUT
    A register is a text file. Anyone who can write to it can write a command into it, and
    this script's whole job is to run commands it found in that file. Therefore:
      * No shell, ever. No `eval`, no `shell=True`, no `os.system`. Commands are tokenised
        by a quote-aware splitter here and executed as argv lists via subprocess, so
        nothing in the anchor is ever re-interpreted by /bin/sh.
      * Pipelines are split at UNQUOTED `|` and chained with Popen. Every stage's head must
        appear in ALLOWED_HEADS (below) — a fixed, read-only list. `git` is further
        restricted to read-only subcommands by GIT_SUBCOMMANDS.
      * Any unquoted `; & < > ( ) $ \\ ` newline` REJECTS the claim (`unsafe-syntax`) —
        it is never run. So does an unquoted `*` or `?`: without a shell those would be
        passed through literally instead of globbing, which silently changes what the
        command means.
      * stdin is /dev/null (a stdin-reading stage cannot hang the gate) and the whole
        pipeline is killed at TIMEOUT_S.
      * No network: nothing in the allowlist reaches one, and none is added.
    The allowlist is a whitelist, not a blacklist: an unknown head is refused, so adding a
    dangerous tool requires a deliberate edit to this file.

CORPUS SCOPE (printed with every run — an undocumented scope gets quoted as total, F15-r1)
    Default corpus = the register set `claims-gate.sh` guards:
        docs/loop/*.md   (top level only)   +   VERSIONS.md
    Deliberately NOT scanned, and named in the output rather than left to be inferred:
        docs/loop/archive/, eval-baselines/, pilot/, greek-editor-records/ — frozen dated
        snapshots. Re-running a snapshot's anchor measures TODAY's tree against a record
        frozen weeks ago; a mismatch there would be an artefact of the corpus choice, not a
        finding. Skill files (SKILL.md, references/) are also out of scope: they are not
        where live-state claims are recorded.
    An explicit path/directory argument bypasses the default entirely — an argument IS the
    chosen corpus, so nothing is filtered and nothing is reported as excluded.

WHICH TREE (this distinction is the difference between two different findings)
    Default: the WORKING TREE — what a pre-push gate would see.
    `--at <rev>`: the tree at <rev>, materialised read-only via `git archive` into a temp
    dir (no worktree is created, no repo state is written).
    They answer different questions. A mismatch in the working tree can mean the anchor was
    false when written OR that the file moved on afterwards — an anchor is a DATED
    observation and a register is live. `--at <the commit that wrote it>` separates those.
    The verdict word is MISMATCH, never "false": this script establishes that an anchor no
    longer reproduces, and a human reads which of the two it is.

EXIT CODES
    0  every checkable claim matched, every provenance pointer resolved, no errors
    1  at least one MISMATCH, an unresolvable provenance pointer, or fewer checkable
       claims than --min-checkable
    2  error: nothing scanned, no anchors found, an unparseable anchor, an unreadable
       file, or an unusable --at revision. Fails CLOSED (R-0222): a checker that scanned
       nothing does not pass, and neither does one whose anchor parser found nothing in a
       corpus known to contain anchors.

    A run in which every anchor was refused compares nothing and says GREEN (VACUOUS),
    never plain GREEN — because "all anchors rewritten into forms the parser refuses" and
    "all anchors verified" would otherwise print the same word. `--min-checkable N` turns
    that into a hard floor: wire the register corpus with the floor it currently meets and
    a collapse in the checkable population fails the gate instead of passing it silently.

USAGE
    scripts/obs-anchor-check.py                        # working tree, default corpus
    scripts/obs-anchor-check.py --at HEAD              # the committed state
    scripts/obs-anchor-check.py --at ceddc85           # fault injection from history
    scripts/obs-anchor-check.py docs/loop/PILOT.md     # explicit corpus
    scripts/obs-anchor-check.py --min-checkable 3      # fail if the checkable set shrinks
    scripts/obs-anchor-check.py --allow-zero-anchors <path>   # corpus genuinely has none

Dependencies: python3, git (only for --at), and the allowlisted tools. No network.
"""

import os
import re
import subprocess
import sys
import tempfile
import shutil
import glob as globmod

# --- safety configuration ---------------------------------------------------

#: Read-only tools a pipeline stage may invoke. Whitelist. `sed` and `awk` are
#: deliberately ABSENT: both can write files (`sed 's//w f'`, awk's `print > f`,
#: awk's `system()`), which makes them unfit to run from an untrusted text file.
ALLOWED_HEADS = {
    'grep', 'egrep', 'fgrep', 'ugrep',
    'sort', 'uniq', 'wc', 'head', 'tail', 'cut', 'tr', 'cat', 'nl', 'comm',
    'git',
}

#: `git` is allowed only for these subcommands; all of them are read-only.
GIT_SUBCOMMANDS = {'log', 'show', 'grep', 'rev-parse', 'cat-file', 'diff', 'ls-files',
                   'ls-tree', 'describe', 'status', 'shortlog'}

#: Rejected when they appear UNQUOTED inside a command. The first group would be
#: shell syntax (we never use a shell, so their presence means the author's command
#: cannot be faithfully reproduced without one); the glob chars would be expanded by
#: a shell and passed literally by us, which silently changes the measurement.
UNSAFE_UNQUOTED = set(';&<>()$`\\\n{}*?')

TIMEOUT_S = 20

#: Short grep-family flags that consume the following token as their argument.
ARG_TAKING_SHORT = set('efmABCDd')
#: Long flags (no `=`) that consume the following token.
ARG_TAKING_LONG = {
    '--regexp', '--file', '--max-count', '--after-context', '--before-context',
    '--context', '--include', '--exclude', '--exclude-dir', '--exclude-from',
    '--binary-files', '--color', '--colour', '--devices', '--directories', '--label',
}
#: Heads whose trailing non-flag operands are FILES, so a missing operand means
#: "the containing register file" under the implicit-target rule.
FILE_OPERAND_HEADS = {'grep', 'egrep', 'fgrep', 'ugrep', 'cat', 'wc', 'head', 'tail', 'nl'}
#: Of those, the ones whose FIRST non-flag operand is a pattern rather than a file.
PATTERN_FIRST_HEADS = {'grep', 'egrep', 'fgrep', 'ugrep'}

DEFAULT_CORPUS_GLOB = 'docs/loop/*.md'
DEFAULT_CORPUS_EXTRA = ['VERSIONS.md']
DEFAULT_EXCLUDED_DIRS = [
    'docs/loop/archive', 'docs/loop/eval-baselines', 'docs/loop/pilot',
    'docs/loop/greek-editor-records',
]


# --- tokenising -------------------------------------------------------------

class Unsafe(Exception):
    """The command cannot be run faithfully without a shell, so it is not run."""


def split_pipeline(cmd):
    """Split on UNQUOTED `|`, tokenise each stage, and refuse shell syntax.

    Returns a list of argv lists. Raises Unsafe with a human reason otherwise. Quote
    handling is the whole point: `grep -cE '^\\| [0-9]+ \\|'` contains a pipe that is
    NOT a pipeline separator, and a naive split on `|` would silently run a different
    command than the one the anchor quotes.
    """
    stages, argv, tok, quote, had_tok = [], [], [], None, False
    for ch in cmd:
        if quote:
            if ch == quote:
                quote = None
            else:
                tok.append(ch)
            continue
        if ch in ("'", '"'):
            quote = ch
            had_tok = True
            continue
        if ch in UNSAFE_UNQUOTED:
            raise Unsafe("unquoted %r is shell syntax or an unexpanded glob" % ch)
        if ch == '|':
            if tok or had_tok:
                argv.append(''.join(tok))
            tok, had_tok = [], False
            stages.append(argv)
            argv = []
            continue
        if ch.isspace():
            if tok or had_tok:
                argv.append(''.join(tok))
            tok, had_tok = [], False
            continue
        tok.append(ch)
    if quote:
        raise Unsafe("unterminated %s quote" % quote)
    if tok or had_tok:
        argv.append(''.join(tok))
    stages.append(argv)
    if any(not s for s in stages):
        raise Unsafe("empty pipeline stage")
    return stages


def split_pipeline_safe(cmd):
    """First stage's head, or '' when the command cannot be tokenised. Never raises."""
    try:
        return split_pipeline(cmd)[0][0]
    except (Unsafe, IndexError):
        return ''


def head_allowed(argv):
    """(ok, reason). Whitelist check on a stage's head, plus git's subcommand list."""
    head = os.path.basename(argv[0])
    if head not in ALLOWED_HEADS:
        return False, "head %r is not in the read-only allowlist" % head
    if head == 'git':
        sub = next((a for a in argv[1:] if not a.startswith('-')), None)
        if sub not in GIT_SUBCOMMANDS:
            return False, "git subcommand %r is not in the read-only allowlist" % (sub,)
    return True, ''


class Unparseable(Exception):
    """The flag table cannot decide where the operands start. Bails, never guesses."""


def file_operand_count(argv):
    """How many FILE operands a grep-family/cat-family argv carries.

    Only needed to decide whether the implicit-target rule applies. Any flag the table
    does not know raises Unparseable — guessing here would either drop a real operand or
    invent one, and both change the measurement.
    """
    head = os.path.basename(argv[0])
    if head not in FILE_OPERAND_HEADS:
        raise Unparseable("no operand model for %r" % head)
    rest, i, operands, pattern_taken = argv[1:], 0, 0, head not in PATTERN_FIRST_HEADS
    while i < len(rest):
        a = rest[i]
        if a == '--':
            operands += len(rest[i + 1:]) - (0 if pattern_taken else 1)
            return max(operands, 0)
        if a.startswith('--'):
            name = a.split('=', 1)[0]
            if '=' in a:
                i += 1
                continue
            if name in ARG_TAKING_LONG:
                i += 2
                continue
            i += 1
            continue
        if a.startswith('-') and len(a) > 1:
            letters = a[1:]
            for pos, c in enumerate(letters):
                if c in ARG_TAKING_SHORT:
                    if pos != len(letters) - 1:
                        # e.g. -e in "-ec": its argument is glued or missing; the two
                        # readings differ, so refuse rather than pick one.
                        raise Unparseable("argument-taking -%s is not last in %r" % (c, a))
                    if c in 'ef':
                        pattern_taken = True
                    i += 1  # consume its argument
            i += 1
            continue
        if not pattern_taken:
            pattern_taken = True
        else:
            operands += 1
        i += 1
    return operands


def run_pipeline(stages, cwd):
    """Execute a validated pipeline as chained argv processes. No shell involved.

    Returns (stdout_text, last_exit, error_or_None).
    """
    procs, prev = [], subprocess.DEVNULL
    try:
        for n, argv in enumerate(stages):
            p = subprocess.Popen(
                argv, cwd=cwd, stdin=prev,
                stdout=subprocess.PIPE,
                stderr=subprocess.DEVNULL if n < len(stages) - 1 else subprocess.PIPE,
            )
            if prev not in (subprocess.DEVNULL, None):
                prev.close()
            prev = p.stdout
            procs.append(p)
        out, _err = procs[-1].communicate(timeout=TIMEOUT_S)
        for p in procs[:-1]:
            p.wait(timeout=TIMEOUT_S)
        # returncode is read straight off the process object, never through a pipe:
        # a shell's `cmd | tail; echo $?` reports the LAST STAGE's status, not the
        # tool's, which is how a green gets fabricated.
        return out.decode('utf-8', 'replace'), procs[-1].returncode, None
    except FileNotFoundError as e:
        return '', None, "command not found: %s" % e.filename
    except subprocess.TimeoutExpired:
        for p in procs:
            p.kill()
        return '', None, "timed out after %ds" % TIMEOUT_S
    except OSError as e:
        return '', None, "%s: %s" % (e.__class__.__name__, e)


# --- anchor parsing ---------------------------------------------------------

ANCHOR_OPEN = '[obs:'
MAX_ANCHOR_LINES = 8        # anchors wrap; 4 in this corpus span 2-4 lines


def find_anchors(text):
    """Yield (start_line, anchor_text) plus a list of unparseable-anchor reports.

    Bracket-depth matching, because anchor bodies legitimately contain brackets
    (`grep -oE '[0-9]+'`). An anchor that does not close within MAX_ANCHOR_LINES is
    REPORTED, never skipped — a silently dropped anchor is an unchecked claim that
    looks checked.
    """
    anchors, broken, i = [], [], 0
    while True:
        i = text.find(ANCHOR_OPEN, i)
        if i < 0:
            return anchors, broken
        line_no = text.count('\n', 0, i) + 1
        depth, j, nl = 0, i, 0
        while j < len(text):
            c = text[j]
            if c == '[':
                depth += 1
            elif c == ']':
                depth -= 1
                if depth == 0:
                    break
            elif c == '\n':
                nl += 1
                if nl >= MAX_ANCHOR_LINES:
                    break
            j += 1
        if j >= len(text) or depth != 0:
            broken.append((line_no, text[i:i + 120].replace('\n', ' ')))
            i += len(ANCHOR_OPEN)
            continue
        anchors.append((line_no, text[i:j + 1]))
        i = j + 1


CODE_SPAN = re.compile(r'`([^`]+)`')
#: A code span is treated as an INVOCATION only if its first token looks like a program
#: name: lowercase, no `:` or `=`, ASCII, and either extensionless or a script extension.
#: Everything else in backticks (`SKILL.md:93`, `LC_ALL=C.UTF-8`, `μηδ[εέ]ν`, a path to a
#: .md file) is a literal the prose is quoting, and calling it a refused command would
#: overstate how many commands this corpus actually contains.
PROGRAM_NAME = re.compile(r'^[a-z][a-z0-9_-]*(\.(sh|py|pl|rb|bash))?$')
#: `[obs:]`, `[obs:<TOKEN>]`, `[obs:…]` — the form written as an example of itself, in prose
#: that is ABOUT anchors. Three spellings are in live use across the registers and the plan.
TEMPLATE_ANCHOR = re.compile(r'^\[obs:\s*(<[^>]*>[\s\S]*|\.{3}|…)?\]$')
INT_ASSERT = re.compile(r'\s*(?:=|→|->)\s*(\d+)')
IN_FILE = re.compile(r'\s*in\s+(\S+?\.md)\b')
CONT_ASSERT = re.compile(r'\s*,\s*(\d+)\s+in\s+(\S+?\.md)\b')
#: Words which, following the integer, mean the integer is NOT the command's stdout —
#: "= 7 files" after a grep that prints matching LINES, "-> 15 passed / 0 failed".
#: Everything else following the integer (a connective, a clause, punctuation, the end of
#: the anchor) leaves the assertion readable as the command's own output.
#:
#: This is a refusal list, not an acceptance list, and the asymmetry is deliberate. An
#: unknown word read as "bare" produces a comparison a human can see and dispute; an
#: unknown word read as "shaped" produces a claim that is silently never checked. The
#: second is the F20 failure this script exists to catch, and the first version of this
#: file made exactly that mistake: an acceptance list of terminators (`· , ; ) ]`) let the
#: founding defect `= 31 and ...` through as UNCHECKABLE, and the run came back GREEN.
REINTERPRETING_UNITS = {
    'files', 'file', 'hits', 'hit', 'matches', 'occurrences', 'surfaces',
    'passed', 'failed', 'skipped', 'errors', 'warnings', 'distinct', 'unique',
    'of', 'out', '%',
}
NEXT_WORD = re.compile(r'\s*([%A-Za-z]+)')


class Claim(object):
    def __init__(self, path, line, cmd, asserted, target, reason=None):
        self.path, self.line, self.cmd = path, line, cmd
        self.asserted, self.target, self.reason = asserted, target, reason
        self.observed = self.verdict = self.detail = None


def looks_like_invocation(span):
    """True when a code span's first token has the shape of a program name."""
    first = span.strip().split()[0] if span.strip() else ''
    return bool(PROGRAM_NAME.match(os.path.basename(first)))


def parse_anchor(path, line_no, body):
    """Split one anchor into claims (checkable or not). Never returns nothing."""
    claims, consumed, spans = [], [], []
    if TEMPLATE_ANCHOR.match(body.strip()):
        c = Claim(path, line_no, None, None, None, 'template-mention')
        c.detail = body[:100].replace('\n', ' ')
        return [c]
    for m in CODE_SPAN.finditer(body):
        spans.append((m.start(), m.end()))
        cmd, tail_at = m.group(1).strip(), m.end()
        if not looks_like_invocation(cmd):
            c = Claim(path, line_no, None, None, None, 'not-a-command')
            c.detail = '`%s`' % cmd
            claims.append(c)
            continue
        a = INT_ASSERT.match(body, tail_at)
        if not a:
            claims.append(Claim(path, line_no, cmd, None, None, 'no-assertion'))
            continue
        consumed.append((a.start(1), a.end(1)))
        f = IN_FILE.match(body, a.end())
        if f:
            claims.append(Claim(path, line_no, cmd, int(a.group(1)), f.group(1)))
            pos = f.end()
            while True:
                c = CONT_ASSERT.match(body, pos)
                if not c:
                    break
                consumed.append((c.start(1), c.end(1)))
                claims.append(Claim(path, line_no, cmd, int(c.group(1)), c.group(2)))
                pos = c.end()
            continue
        nxt = NEXT_WORD.match(body, a.end())
        if nxt and nxt.group(1).lower() in REINTERPRETING_UNITS:
            trailing = body[a.end():a.end() + 40].strip().split()[:3]
            c = Claim(path, line_no, cmd, None, None, 'assertion-shape')
            c.detail = 'asserted %s %s' % (a.group(1), ' '.join(trailing))
            claims.append(c)
        else:
            claims.append(Claim(path, line_no, cmd, int(a.group(1)), None))
    # "= <int>" occurrences bound to no command at all ("section D = 9"). Occurrences
    # INSIDE a code span are skipped: `TRUE_EXIT=0` is quoted text, not an assertion the
    # anchor is making about a command's output.
    for m in re.finditer(r'(?:=|→|->)\s*(\d+)', body):
        if any(s <= m.start(1) < e for s, e in consumed):
            continue
        if any(s <= m.start() < e for s, e in spans):
            continue
        c = Claim(path, line_no, None, int(m.group(1)), None,
                  'assertion-without-command')
        c.detail = '…' + body[max(0, m.start() - 24):m.end()].strip().replace('\n', ' ')
        claims.append(c)
    if not claims:
        c = Claim(path, line_no, None, None, None, 'prose')
        c.detail = body[:100].replace('\n', ' ')
        claims.append(c)
    return claims


# --- corpus -----------------------------------------------------------------

def default_corpus(root):
    """(targets, excluded) — both returned so the scope prints with the verdict."""
    targets, excluded = [], {}
    for q in sorted(globmod.glob(os.path.join(root, DEFAULT_CORPUS_GLOB))):
        targets.append(os.path.relpath(q, root))
    for extra in DEFAULT_CORPUS_EXTRA:
        if os.path.isfile(os.path.join(root, extra)):
            targets.append(extra)
    # Every excluded directory is listed even when it currently holds zero .md files.
    # "no exclusions printed" and "exclusions printed as zero" look identical to a reader
    # otherwise, and only the second one proves the exclusion was considered.
    for d in DEFAULT_EXCLUDED_DIRS:
        found = sorted(os.path.relpath(p, root) for p in
                       globmod.glob(os.path.join(root, d, '**', '*.md'), recursive=True))
        excluded['%s/ (frozen dated snapshot)' % d] = found
    return sorted(set(targets)), excluded


def inside(root, p):
    return not os.path.relpath(p, root).startswith('..')


def expand(root, args):
    """Explicit-corpus resolution.

    A path inside the scanned tree is kept relative (short, and it is what the implicit-
    target rule feeds to grep); a path outside it stays ABSOLUTE rather than becoming a
    forty-segment `../../../private/tmp/...` chain. An evidence line has to be readable to
    function as evidence (house evidence-print rule).
    """
    out, missing = [], []
    for a in args:
        p = a if os.path.isabs(a) else os.path.join(root, a)
        if os.path.isdir(p):
            found = sorted(globmod.glob(os.path.join(p, '**', '*.md'), recursive=True))
            if not found:
                missing.append('%s (directory contains no .md)' % a)
            out += [os.path.relpath(f, root) if inside(root, f) else os.path.abspath(f)
                    for f in found]
        elif os.path.isfile(p):
            out.append(os.path.relpath(p, root) if inside(root, p) else os.path.abspath(p))
        else:
            missing.append('%s (not found)' % a)
    return out, missing


def materialise(rev, repo):
    """Read-only copy of <rev> via `git archive`. Creates no worktree, writes no repo state."""
    tmp = tempfile.mkdtemp(prefix='obs-anchor-%s-' % re.sub(r'\W', '', rev)[:12])
    ar = subprocess.run(['git', 'archive', '--format=tar', rev],
                        cwd=repo, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if ar.returncode != 0:
        shutil.rmtree(tmp, ignore_errors=True)
        return None, ar.stderr.decode('utf-8', 'replace').strip()
    tar = subprocess.run(['tar', '-x', '-C', tmp], input=ar.stdout,
                         stdout=subprocess.PIPE, stderr=subprocess.PIPE)
    if tar.returncode != 0:
        shutil.rmtree(tmp, ignore_errors=True)
        return None, tar.stderr.decode('utf-8', 'replace').strip()
    return tmp, None


# --- main -------------------------------------------------------------------

def main(argv):
    repo = os.path.abspath(os.path.join(os.path.dirname(os.path.abspath(__file__)), '..'))
    rev, allow_zero, paths, min_checkable = None, False, [], 0
    i = 0
    while i < len(argv):
        a = argv[i]
        if a == '--at':
            i += 1
            if i >= len(argv):
                print('ERROR  --at needs a revision', file=sys.stderr)
                return 2
            rev = argv[i]
        elif a == '--min-checkable':
            i += 1
            if i >= len(argv) or not argv[i].isdigit():
                print('ERROR  --min-checkable needs a non-negative integer',
                      file=sys.stderr)
                return 2
            min_checkable = int(argv[i])
        elif a == '--allow-zero-anchors':
            allow_zero = True
        elif a in ('-h', '--help'):
            print(__doc__)
            return 0
        elif a.startswith('-'):
            print('ERROR  unknown option %r' % a, file=sys.stderr)
            return 2
        else:
            paths.append(a)
        i += 1

    tmp = None
    if rev:
        tmp, err = materialise(rev, repo)
        if tmp is None:
            print('ERROR  cannot materialise %r: %s' % (rev, err), file=sys.stderr)
            return 2
        root, tree_desc = tmp, 'rev %s (materialised read-only)' % rev
    else:
        root, tree_desc = repo, 'working tree'

    try:
        if paths:
            targets, missing = expand(root, paths)
            excluded = {}
        else:
            targets, excluded = default_corpus(root)
            missing = []
        if missing:
            for m in missing:
                print('ERROR  unresolvable target: %s' % m, file=sys.stderr)
            return 2

        print('TREE   %s' % tree_desc)
        print('CORPUS %s' % (', '.join(paths) if paths else
                             '%s + %s (default register set)'
                             % (DEFAULT_CORPUS_GLOB, ' '.join(DEFAULT_CORPUS_EXTRA))))
        print('ENV    LANG=%r LC_ALL=%r  (locale is inherited, not forced: a result is '
              'reproducible only under the same one)'
              % (os.environ.get('LANG', ''), os.environ.get('LC_ALL', '')))
        print('')

        scanned, errors, broken_all, claims = 0, 0, [], []
        for rel in targets:
            try:
                text = open(os.path.join(root, rel), encoding='utf-8').read()
            except OSError as e:
                print('ERROR  unreadable: %s (%s)' % (rel, e.__class__.__name__),
                      file=sys.stderr)
                errors += 1
                continue
            scanned += 1
            found, broken = find_anchors(text)
            for ln, snippet in broken:
                broken_all.append((rel, ln, snippet))
            for ln, body in found:
                claims += parse_anchor(rel, ln, body)

        if errors:
            print('\nERROR - %d target(s) unreadable; scanned %d' % (errors, scanned),
                  file=sys.stderr)
            return 2
        # R-0222: fail CLOSED on an empty scan set.
        if scanned == 0:
            print('ERROR - scanned 0 files. A checker that scans nothing does not pass '
                  '(R-0222).', file=sys.stderr)
            return 2
        for rel, ln, snippet in broken_all:
            print('ERROR  %s:%d unparseable anchor (no closing ] within %d lines): %s'
                  % (rel, ln, MAX_ANCHOR_LINES, snippet), file=sys.stderr)
        if broken_all:
            print('\nERROR - %d unparseable anchor(s); an anchor this script cannot read '
                  'is an unchecked claim, not an absent one.' % len(broken_all),
                  file=sys.stderr)
            return 2
        # Second fail-closed leg: a corpus with files but no anchors usually means the
        # anchor parser broke, not that the claims vanished.
        n_anchors = len({(c.path, c.line) for c in claims})
        if n_anchors == 0 and not allow_zero:
            print('ERROR - %d file(s) scanned, 0 [obs:] anchors parsed. Either the parser '
                  'is broken or this corpus genuinely has none; pass '
                  '--allow-zero-anchors to assert the latter (R-0222).' % scanned,
                  file=sys.stderr)
            return 2

        # --- evaluate ---
        mismatches, matches, prov_ok, prov_fail, uncheckable = [], [], [], [], []
        for c in claims:
            if c.reason == 'no-assertion':
                _provenance(c, root, repo, prov_ok, prov_fail, uncheckable)
                continue
            if c.reason:
                uncheckable.append(c)
                continue
            _measure(c, root, repo, matches, mismatches, uncheckable)

        # --- report ---
        if mismatches:
            print('MISMATCH - an anchor no longer reproduces (see WHICH TREE above '
                  'before calling it false):')
            for c in mismatches:
                print('  RED  %s:%d' % (c.path, c.line))
                print('       cmd      `%s`' % c.cmd)
                print('       target   %s' % c.target)
                print('       asserted %s' % c.asserted)
                print('       observed %s' % c.observed)
            print('')
        if prov_fail:
            print('UNRESOLVABLE - a provenance pointer whose command does not resolve:')
            for c in prov_fail:
                print('  RED  %s:%d  `%s`  -> %s' % (c.path, c.line, c.cmd, c.detail))
            print('')
        if matches:
            print('MATCHED - %d claim(s) re-run, stdout equals the asserted value:'
                  % len(matches))
            for c in matches:
                print('  ok   %s:%d  `%s` = %s  [target: %s]'
                      % (c.path, c.line, c.cmd, c.asserted, c.target))
            print('')
        if prov_ok:
            print('RESOLVED - %d provenance pointer(s) run, exit 0, nothing to compare:'
                  % len(prov_ok))
            for c in prov_ok:
                print('  ok   %s:%d  `%s`' % (c.path, c.line, c.cmd))
            print('')

        by_reason = {}
        for c in uncheckable:
            by_reason.setdefault(c.reason, []).append(c)
        print('UNCHECKABLE - %d claim(s). NOT passes: no comparison was performed.'
              % len(uncheckable))
        for reason in sorted(by_reason):
            group = by_reason[reason]
            print('  %d  %s' % (len(group), reason))
            for c in group:
                what = c.cmd and '`%s`' % c.cmd or (c.detail or '')
                print('       %s:%d  %s' % (c.path, c.line, what[:110]))
        print('')

        if excluded:
            n_ex = sum(len(v) for v in excluded.values())
            print('CORPUS EXCLUSIONS - %d .md file(s) NOT scanned, across %d excluded '
                  'location(s):' % (n_ex, len(excluded)))
            for reason in sorted(excluded):
                print('  %d  %s' % (len(excluded[reason]), reason))
            print('')

        n_check = len(matches) + len(mismatches)
        print('SCANNED   %d file(s), %d anchor(s), %d claim(s)'
              % (scanned, n_anchors, len(claims)))
        print('SPLIT     %d checkable (%d matched / %d MISMATCH) · %d provenance '
              '(%d resolved / %d unresolvable) · %d uncheckable'
              % (n_check, len(matches), len(mismatches),
                 len(prov_ok) + len(prov_fail), len(prov_ok), len(prov_fail),
                 len(uncheckable)))
        bad = len(mismatches) + len(prov_fail)
        if bad:
            print('\nRED - %d anchor claim(s) do not reproduce against the %s.'
                  % (bad, tree_desc))
            return 1
        if n_check < min_checkable:
            print('\nRED - only %d checkable claim(s), floor is %d (--min-checkable). '
                  'The comparisons did not fail; there were too few of them. Anchors '
                  'rewritten into unrunnable prose pass a checker that only checks '
                  'runnable ones.' % (n_check, min_checkable))
            return 1
        if n_check == 0:
            print('\nGREEN (VACUOUS) - %d anchor(s) found and NOT ONE was compared to '
                  'anything. This is not evidence about the anchors; it is evidence that '
                  'none of them are in a checkable form. Use --min-checkable to make this '
                  'state fail.' % n_anchors)
            return 0
        print('\nGREEN - all %d checkable anchor claim(s) reproduce against the %s. '
              'This says nothing about the %d uncheckable claim(s) above.'
              % (n_check, tree_desc, len(uncheckable)))
        return 0
    finally:
        if tmp:
            shutil.rmtree(tmp, ignore_errors=True)


def _prepare(c, root, repo):
    """(stages, cwd, err_reason) — validate and resolve the target, or refuse.

    cwd is `root` (the scanned tree) EXCEPT for a pipeline containing a `git` stage, which
    runs in the real repository: `git log -1 <sha>` is a claim about history, not about
    tree content, and a `git archive` materialisation is not a repository at all — running
    it there produced exit 128 on every git anchor, which read as "the SHA does not exist"
    when the truth was "there is no .git here".
    """
    try:
        stages = split_pipeline(c.cmd)
    except Unsafe as e:
        return None, None, ('unsafe-syntax', str(e))
    for st in stages:
        ok, why = head_allowed(st)
        if not ok:
            return None, None, ('head-not-allowlisted', why)
    if any(os.path.basename(st[0]) == 'git' for st in stages):
        root = repo
    head = os.path.basename(stages[0][0])
    if head in FILE_OPERAND_HEADS:
        try:
            n_files = file_operand_count(stages[0])
        except Unparseable as e:
            return None, None, ('unparseable-argv', str(e))
        if n_files == 0:
            if c.target:
                hits = [os.path.relpath(p, root) for p in globmod.glob(
                    os.path.join(root, '**', os.path.basename(c.target)), recursive=True)]
                hits = [h for h in hits if not h.startswith('.git' + os.sep)]
                if len(hits) != 1:
                    return None, None, ('ambiguous-target',
                                        '%r resolves to %d files' % (c.target, len(hits)))
                c.target = hits[0]
            else:
                # IMPLICIT-TARGET RULE, stated because it is an inference: a
                # file-operandless grep inside a register is read as measuring THAT
                # register. It is the convention these anchors are written in. The
                # resolved target prints with every result so a wrong reading is
                # visible rather than buried in a number.
                c.target = c.path + '  (implicit: the file containing the anchor)'
            stages[0].append(c.target.split('  (')[0])
        elif c.target:
            return None, None, ('assertion-shape',
                                'command names its own file(s) AND the anchor names one')
        else:
            c.target = '(named in the command)'
    elif c.target:
        return None, None, ('ambiguous-target',
                            'anchor names a file but %r takes no file operand' % head)
    else:
        c.target = '(no file operand model for %s)' % head
    return stages, root, None


def _measure(c, root, repo, matches, mismatches, uncheckable):
    stages, cwd, err = _prepare(c, root, repo)
    if err:
        c.reason, c.detail = err
        uncheckable.append(c)
        return
    out, _rc, runerr = run_pipeline(stages, cwd)
    if runerr:
        c.reason, c.detail = 'output-shape', runerr
        uncheckable.append(c)
        return
    s = out.strip()
    if not re.fullmatch(r'\d+', s):
        c.reason = 'output-shape'
        c.detail = 'stdout is not a single integer: %r' % s[:60]
        uncheckable.append(c)
        return
    c.observed = int(s)
    (matches if c.observed == c.asserted else mismatches).append(c)


def _provenance(c, root, repo, prov_ok, prov_fail, uncheckable):
    """Weaker leg: a command with no asserted output can still be checked for RESOLVING.

    `git log -1 <sha>` asserts nothing to compare, but a citation to a SHA that does not
    exist is still a broken anchor, and that IS detectable. RESOLVED is a weaker verdict
    than MATCHED and is reported in its own block so the two are never added together.

    Restricted to git-headed commands ON PURPOSE. A `grep`/`sort` with no assertion
    resolves trivially — an early version ran the prose fragment "`sort -un` over the ids"
    against the containing register, got exit 0, and printed RESOLVED. That is a green
    manufactured out of nothing: the command had no operand, no assertion, and no meaning
    on its own. Only a reference that can genuinely fail to resolve is worth resolving.
    """
    if os.path.basename(split_pipeline_safe(c.cmd)) != 'git':
        c.reason = 'no-assertion'
        uncheckable.append(c)
        return
    stages, cwd, err = _prepare(c, root, repo)
    if err:
        c.reason, c.detail = err
        uncheckable.append(c)
        return
    out, rc, runerr = run_pipeline(stages, cwd)
    if runerr:
        c.detail = runerr
        prov_fail.append(c)
        return
    if rc != 0:
        c.detail = 'exit %s' % rc
        prov_fail.append(c)
        return
    prov_ok.append(c)


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
