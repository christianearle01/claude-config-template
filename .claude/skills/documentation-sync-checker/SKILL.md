---
name: documentation-sync-checker
description: Validates documentation consistency and auto-generates documentation stubs. Auto-activates when users ask about docs sync, broken links, stale content, or when code changes need documentation. Checks version consistency, internal links, documentation drift, and suggests doc templates for new code.
allowed-tools: Read, Grep, Edit
---

# Documentation Sync Checker Skill

## Purpose & Activation

**What it does:**
- **Validation:** Validates documentation consistency, cross-references, and detects drift across MD files
- **Auto-Generation (NEW v4.19.0):** Detects code changes and suggests documentation templates

**When it activates automatically:**
- "Are docs in sync?"
- "Check for broken links"
- "Find stale content"
- "Validate documentation"
- "Check cross-references"
- **NEW:** "Document this function"
- **NEW:** "Generate docs for new code"
- **NEW:** "What docs need updating?"

**How it helps:**
- Prevents documentation drift
- Finds broken internal links
- Identifies version mismatches
- Detects stale references
- Validates cross-document consistency
- **NEW:** Auto-generates docstring templates
- **NEW:** Suggests README updates for new files
- **NEW:** Flags API changes needing documentation

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

## Auto-Generation Operations (NEW v4.19.0)

### Operation 4: Function Documentation Generation

**User Query:**
> "Document this function" or "Generate docs for new code"

**Confidence:** 🟢 High (0.87)
- Pattern-based detection of undocumented functions
- Template generation using prompt patterns (v4.14.0)
- Language-agnostic approach (JS, Python, Bash, etc.)

**Skill Response:**
```
📝 Documentation Template Generated

Function: validateConfig (src/utils.js:45)

Suggested docstring:
/**
 * Validates configuration object against schema
 *
 * @param {Object} config - Configuration object to validate
 * @param {Object} schema - JSON schema for validation
 * @returns {Object} Validation result with errors array
 * @throws {ValidationError} If schema is invalid
 *
 * @example
 * const result = validateConfig(userConfig, configSchema);
 * if (result.errors.length > 0) {
 *   console.error('Validation failed:', result.errors);
 * }
 */

Detected:
- 2 parameters (config, schema)
- 1 return value (object)
- 1 potential throw (ValidationError)
- Used in 3 files

Next: Copy template, adjust details, add to function
```

**Why This Matters:**
- Undocumented functions = cognitive load for future readers (including yourself in 3 months)
- Template provides structure (params, returns, throws, examples) following best practices
- Uses prompt patterns from v4.14.0 (Output Requirements pattern for structured docs)
- **Quick win:** Copy-paste template, customize in 2 minutes vs writing from scratch (15 minutes)

**Next Step:** Paste template above function, adjust param descriptions to match actual usage

### Operation 5: New File README Updates

**User Query:**
> "New file added, update docs" or "What docs need updating?"

**Confidence:** 🟡 Medium (0.76)
- Can detect new files via git status
- Suggests README sections based on file type
- Requires human judgment for integration (where does this fit?)

**Skill Response:**
```
📂 New Files Detected

File: src/validators/deployment-check.js (157 lines)
Type: JavaScript module
Exports: 3 functions (checkTests, checkSecurity, checkDocs)

Suggested README update:
## Deployment Validation

### `deployment-check.js`

Validates deployment readiness by checking:
- Test suite status (all passing)
- Security scans (no vulnerabilities)
- Documentation sync (up-to-date)

Usage:
```js
import { checkTests, checkSecurity, checkDocs } from './validators/deployment-check';

const ready = await checkTests() && await checkSecurity() && await checkDocs();
console.log(`Deployment ready: ${ready}`);
```

Add this section to: src/validators/README.md (before "Contributing")
```

**Why This Matters:**
- New files without README mentions = invisible to users ("does this exist?")
- Template provides usage example (critical for adoption)
- Suggests integration point (where in README to add)
- **Quick win:** Copy template to README, adjust details (5 minutes vs 20 minutes writing from scratch)

**Next Step:** Open src/validators/README.md, paste template before "Contributing" section

### Operation 6: API Change Documentation Flagging

**User Query:**
> "Check if API changes need docs" or "What changed in the API?"

**Confidence:** 🟡 Medium (0.72)
- Can detect signature changes via git diff
- Flags breaking changes (removed params, changed returns)
- Requires human review (is this breaking?)

**Skill Response:**
```
⚠️ API Changes Detected

Function: processConfig (src/config.js:23)

Change:
- OLD: processConfig(config)
- NEW: processConfig(config, options = {})

Impact: Non-breaking (new optional parameter)

Documentation to update:
1. README.md:156 - Usage example still shows old signature
   Update to: processConfig(config, { validate: true })

2. docs/API.md:89 - Parameter list needs new entry
   Add: options (Object, optional) - Processing options

3. CHANGELOG.md - Add entry:
   "Added optional options parameter to processConfig"

Breaking? No (optional parameter with default)
Action: Update 3 locations, add changelog entry
```

**Why This Matters:**
- API changes without doc updates = confused users ("why doesn't this work?")
- Breaking vs non-breaking distinction guides update urgency
- Specific file locations enable fast fixes
- **Quick win:** Update 3 locations now (10 minutes), prevent 5 support questions later (30 minutes)

**Next Step:** Update README.md:156 first (most visible), then API.md, then CHANGELOG.md

---

## Token Efficiency

### Validation Operations (Original v3.5.0)
**Without Skill:** 800 tokens (manual exploration)
**With Skill:** 300 tokens (structured validation)
**Savings:** 500 tokens/query (62% reduction, projected)

**Monthly:** 3 checks × 500 = 1,500 tokens saved (~$0.05/month)

### Auto-Generation Operations (NEW v4.19.0)
**Without Skill:** 1,200 tokens (read code → analyze → draft template)
**With Skill:** 400 tokens (pattern detection → template generation)
**Savings:** 800 tokens/query (67% reduction, projected)

**Monthly:** 5 doc generations × 800 = 4,000 tokens saved (~$0.12/month)

**Combined Monthly Savings:** 5,500 tokens (~$0.17/month)

---

## Integration with v4.18.0 Frameworks

**Decision Framework:**
- Use this skill when: Code changes complete, documentation needed
- Integration Pattern: Code → Documentation-Sync (auto-generate) → Review → Commit

**Prompt Patterns Used (v4.14.0):**
- Output Requirements Pattern (structured docstrings)
- Few-Shot Scaffolding Pattern (template examples)
- Context-Rich Request Pattern (function signature + usage context)

---

## See Also

- version-management skill
- commit-readiness-checker skill
- docs/01-fundamentals/08_prompt-patterns.md
- QUICK_REFERENCE.md

---

**Skill Version:** 4.19.0
**Last Updated:** 2025-12-17
**Target Audience:** Template maintainers, documentation managers, developers
