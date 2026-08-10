# Content Refresh Templates

Detailed output templates for content-refresher steps 5-9. Referenced from [SKILL.md](../SKILL.md).

---

## Step 5: Create Refresh Plan

```markdown
## Content Refresh Plan

### Title/URL
**Current**: [current title]
**Refreshed**: [updated title with year/hook]

### Structural Changes

**Keep As-Is**:
- [Section 1] - Still relevant and accurate
- [Section 2] - Still relevant and accurate

**Update/Expand**:
- [Section 3] - Update statistics, add [X] words
- [Section 4] - Add new examples from [current year]

**Add New Sections**:
- [New Section 1] - [description, ~X words]
- [New Section 2] - [description, ~X words]
- FAQ Section - [X questions for featured snippets]

**Remove/Consolidate**:
- [Section 5] - Outdated, remove or redirect topic

### Content Additions

**New Word Count Target**: [X] words (+[Y] from current)

| Section | Current | After Refresh | Notes |
|---------|---------|---------------|-------|
| Introduction | [X] | [X] | Add hook, update context |
| [Section 1] | [X] | [X] | Keep |
| [Section 2] | [X] | [X] | Update stats |
| [New Section] | 0 | [X] | Add entirely |
| FAQ | 0 | [X] | Add for GEO |
| Conclusion | [X] | [X] | Update CTA |

### Specific Updates

**Statistics to Update**:

| Old Statistic | New Statistic | Source |
|---------------|---------------|--------|
| "[old stat]" | "[find current]" | [source] |
| "[old stat]" | "[find current]" | [source] |

**Links to Update**:

| Anchor Text | Old URL | New URL | Reason |
|-------------|---------|---------|--------|
| "[anchor]" | [old] | [new] | Broken |
| "[anchor]" | [old] | [new] | Better resource |

**Images to Update**:

| Image | Action | New Alt Text |
|-------|--------|--------------|
| [img 1] | Replace | "[keyword-rich alt]" |
| [img 2] | Keep | Update alt text |
```

---

## Step 6: Write Refresh Content

```markdown
## Refreshed Content Sections

### Updated Introduction

[Write new introduction with:]
- Updated hook for current year
- Fresh statistics
- Clear value proposition
- Primary keyword in first 100 words

### New Section: [Title]

[Write new section covering:]
- [Topic competitors now cover]
- Current information and examples
- GEO-optimized with quotable statements

### Updated Statistics Section

<!-- SKELETON — not publishable copy. The replacement figure comes from a source you
     have open right now, and the citation carries THAT SOURCE'S OWN publication year.
     Never stamp the year you are writing in onto a citation. If no source can be
     found, the statistic comes out of the article rather than being restated with a
     fresher-looking date. -->

**Replace**:
> "[Old statement with outdated stat]"

**With**:
> "[SOURCED STAT: what this sentence needs to claim --- cite the source by name and
> its own publication year]"

### New FAQ Section

## Frequently Asked Questions

### [Question matching PAA/common query]?

[Direct answer in 40-60 words, optimized for featured snippets]

### [Question 2]?

[Direct answer]

### [Question 3]?

[Direct answer]
```

---

## Step 7: Optimize for GEO During Refresh

```markdown
## GEO Enhancement Opportunities

### Add Clear Definitions

**Add at start of article**:
> **[Topic]** is [clear, quotable definition in 40-60 words that
> AI systems can cite directly].

### Add Quotable Statements

<!-- SKELETON — not publishable copy. What makes a statement quotable is a real figure
     with a real source, so the slot below stays a slot until you have consulted one.
     A statement that cannot be filled from a source you have read gets cut, not
     guessed. -->

**Transform**:
> "Email marketing is effective for businesses."

**Into**:
> "Email marketing remains one of the highest-ROI channels available to
> small businesses ([SOURCED STAT: average email ROI --- cite the source
> by name and its own publication year])."

### Add Q&A Sections

Structure content with questions AI might answer:
- What is [topic]?
- How does [topic] work?
- Why is [topic] important?
- What are the benefits of [topic]?

### Update Citations

- Every statistic names the source it came from, and links to it where a public URL exists
- The date in a citation is the **publication year printed on the source you actually
  consulted** — never the current year, and never a year inferred to make a source look
  recent. A citation date is a fact about the source, not a freshness lever
- Prefer sources published in the last 2 years; when the best available source is older,
  cite its real date and say in the sentence how old the figure is
- A statistic with no consultable source does not ship: cut the claim, or leave the
  `[SOURCED STAT: ...]` slot open in the draft so the gap is visible before publication
```

---

## Step 8: Generate Republishing Strategy

```markdown
## Republishing Strategy

### Date Strategy

**Options**:

1. **Update Published Date**
   - Use when: Major overhaul (50%+ new content)
   - Pros: Signals freshness to Google
   - Cons: Loses "original" authority

2. **Add "Last Updated" Date**
   - Use when: Moderate updates (20-50% new)
   - Pros: Shows both original and fresh
   - Cons: Original date visible

3. **Keep Original Date**
   - Use when: Minor updates (<20% new)
   - Pros: Maintains authority
   - Cons: Doesn't signal update

**Recommendation**: [Option X] because [reason]

### Technical Implementation

- [ ] Update `dateModified` in schema
- [ ] Update sitemap lastmod
- [ ] Clear cache after publishing
- [ ] Resubmit to Search Console

### Promotion Strategy

**Immediately after refresh**:
- [ ] Share on social media as "updated for [current year]"
- [ ] Send to email list if significant update
- [ ] Update internal links with fresh anchors
- [ ] Reach out for new backlinks

**Track Results**:
- [ ] Monitor rankings for 4-6 weeks
- [ ] Track traffic changes
- [ ] Watch for featured snippet capture
- [ ] Check AI citation improvements
```

---

## Step 9: Create Refresh Report

```markdown
# Content Refresh Report

## Summary

**Content**: [Title]
**Refresh Date**: [Date]
**Refresh Level**: [Major/Moderate/Minor]

## Changes Made

| Element | Before | After |
|---------|--------|-------|
| Word count | [X] | [Y] (+[Z]%) |
| Sections | [X] | [Y] |
| Statistics | [X] outdated | [Y] current |
| Internal links | [X] | [Y] |
| Images | [X] | [Y] |
| FAQ questions | 0 | [X] |

## Updates Completed

- [x] Updated title with current year
- [x] Refreshed meta description
- [x] Added [X] new sections
- [x] Updated [X] statistics with sources
- [x] Fixed [X] broken links
- [x] Added FAQ section for GEO
- [x] Implemented FAQ schema
- [x] Updated images and alt text

## Expected Outcomes

| Metric | Current | 30-Day Target | 90-Day Target |
|--------|---------|---------------|---------------|
| Avg Position | [X] | [Y] | [Z] |
| Organic Traffic | [X]/mo | [Y]/mo | [Z]/mo |
| Featured Snippets | [X] | [Y] | [Z] |

Every target in this table states the assumption it rests on, in the sentence
underneath it — otherwise write "not projected; to be measured after republishing".
A refresh does not convert into a position or a traffic figure by any model this
skill carries, so a bare number here is a guess wearing a target.

## Next Review

Schedule next refresh review: [Date - 6 months from now]
```
