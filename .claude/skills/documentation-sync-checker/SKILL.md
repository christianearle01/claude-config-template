---
name: documentation-sync-checker
description: Validates documentation consistency across all MD files. Auto-activates when users ask about docs sync, broken links, stale content, or cross-reference validation. Checks version consistency, internal links, and documentation drift.
allowed-tools: Read, Grep
---

# Documentation Sync Checker Skill

## Purpose & Activation

**What it does:** Validates documentation consistency, cross-references, and detects drift across 39 MD files (22,400+ lines).

**When it activates automatically:**
- "Are docs in sync?"
- "Check for broken links"
- "Find stale content"
- "Validate documentation"
- "Check cross-references"

**How it helps:**
- Prevents documentation drift
- Finds broken internal links
- Identifies version mismatches
- Detects stale references
- Validates cross-document consistency

---

## Key Checks

### 1. Version Consistency

Validates version references across:
- README.md (3 locations)
- CLAUDE.md (line 4)
- SETUP_CONTEXT.md (2 locations)
- CHANGELOG.md (latest entry)
- All skill SKILL.md files (footer)

### 2. Internal Links

Checks links in format:
- Relative: `[text](../path/to/file.md)`
- Root-relative: `[text](/path/from/root.md)`
- Anchors: `[text](#section-name)`

Validates:
- Target file exists
- Anchor exists (if specified)
- Path is correct

### 3. Cross-References

Validates bidirectional links:
- README ↔ Documentation files
- Skills ↔ SKILLS_PARADIGM.md
- Setup guides ↔ QUICK_REFERENCE.md

### 4. Stale Content Detection

Finds references to:
- Old version numbers
- Deprecated features
- Removed files
- Outdated examples

---

## Operations

### Operation 1: Full Documentation Sync

**User Query:**
> "Are docs in sync?"

**Confidence:** 🟢 High (0.89)
- Comprehensive check across 39 MD files
- 4 validation types (version, links, cross-refs, stale content)
- Clear pass/fail criteria

**Skill Response:**
```
📚 Documentation Sync Check

VERSION CONSISTENCY ✅
All files reference v3.4.0

INTERNAL LINKS ✅
Checked 156 links, all valid

CROSS-REFERENCES ✅
All bidirectional links verified

STALE CONTENT ✅
No outdated references found

Status: All documentation in sync! ✨
```

**Why This Matters:**
- 22,400+ lines of docs = high drift risk without automated checking
- Broken links erode user trust ("is this template maintained?")
- Version consistency prevents user confusion (which features exist?)
- **Quick win:** All green! Safe to publish updates or onboard new users

**Next Step:** Schedule monthly sync checks to catch drift early

### Operation 2: Broken Link Detection

**User Query:**
> "Check for broken links"

**Confidence:** 🟢 High (0.92)
- Link validation is deterministic (file exists or not)
- Anchor checking via file parsing
- Clear fix guidance for each broken link

**Skill Response:**
```
🔗 Link Validation

Found 2 broken links:

❌ README.md:45
   Link: [Old Guide](docs/deprecated.md)
   Issue: File does not exist
   Fix: Remove link or update to new path

❌ QUICK_REFERENCE.md:120
   Link: [Section](#nonexistent)
   Issue: Anchor not found in target
   Fix: Update anchor to match actual heading

Action: Fix these 2 links
```

**Why This Matters:**
- Broken links = poor first impression for new users
- 2 broken links out of 156 = 98.7% link health (good baseline)
- Specific line numbers enable fast fixes (no hunting)
- **Quick win:** Edit README.md:45 and QUICK_REFERENCE.md:120 now

**Next Step:** After fixing, re-run "Check for broken links" to verify all clear

### Operation 3: Version Mismatch Detection

**User Query:**
> "Find version inconsistencies"

**Confidence:** 🟡 Medium (0.75)
- Can find version references deterministically
- Some mismatches may be intentional (historical context)
- Requires human judgment to distinguish bugs from features

**Skill Response:**
```
🔍 Version References

Expected: v3.4.0

Mismatches found:
❌ docs/old-guide.md:5
   Found: "v3.2.0"
   Context: "This feature was added in v3.2.0"
   Note: May be intentional (historical reference)

❌ examples/config.json:3
   Found: "version": "3.3.0"
   Issue: Example should reflect current version

Fix examples/config.json immediately.
Review docs/old-guide.md (may be intentional).
```

**Why This Matters:**
- Example configs with old versions mislead users ("do I need v3.3.0?")
- Historical references are valid (e.g., "Added in v3.2.0") but need review
- Version drift detection prevents accumulation of stale references
- **Quick win:** Update examples/config.json to "version": "3.4.0"

**Next Step:** Review "v3.2.0" context—if historical, add "(historical)" note for clarity

---

## Token Efficiency

**Without Skill:** 800 tokens (manual exploration)
**With Skill:** 300 tokens (structured validation)
**Savings:** 500 tokens/query (62% reduction, projected)

**Monthly:** 3 checks × 500 = 1,500 tokens saved (~$0.05/month)

---

## See Also

- version-management skill
- commit-readiness-checker skill
- QUICK_REFERENCE.md

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Target Audience:** Template maintainers, documentation managers
