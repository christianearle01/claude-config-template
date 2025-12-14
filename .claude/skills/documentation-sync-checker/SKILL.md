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

**User:** "Are docs in sync?"

**Response:**
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

### Operation 2: Broken Link Detection

**User:** "Check for broken links"

**Response:**
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

### Operation 3: Version Mismatch Detection

**User:** "Find version inconsistencies"

**Response:**
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
