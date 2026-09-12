# Records in this directory

**Before comparing any score here against any other score, read
[`../INSTRUMENT-CHANGES.md`](../INSTRUMENT-CHANGES.md).**

It records which baselines stopped measuring what their successors measure. When an expectation
is rewritten, a record taken before the rewrite graded a **different instrument**, and the
difference between the two numbers is the yardstick moving — not a regression and not an
improvement. Nothing inside a JSON record says which expectations it graded, so without that file
the change is invisible and reads as skill drift.

This note exists because a grader is sent to a record **by path**. It arrives in this directory,
runs `ls`, and never sees the file one level up. That was measured, not assumed: `validate-tracking.sh`
check (i) counted 6 record(s) here that could not reach it. The note is the fix check (i) asks for.

The pointer is a sibling file rather than a key inside each record because the records are
machine-written — a hand-added JSON key would be erased by the next run that writes the record.
