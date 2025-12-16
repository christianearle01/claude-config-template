# Quick Reference: Version Management

**Just-in-Time Help** for version consistency tracking

---

## Most Common Queries (90% usage)

### 1. "What version is this project?"
```
→ Reads version.json (source of truth)
→ Shows: version number, release date, release name
→ Example: "v3.5.0 - Attentive Sous Chef"
→ Confirms all files are in sync
```

**Quick answer:** Version number + release name

---

### 2. "Check version consistency"
```
→ Validates 7 file locations:
  - version.json (line 2)
  - CLAUDE.md (line 4)
  - README.md (lines 306, 339, 463)
  - SETUP_CONTEXT.md (lines 21, 437)
→ Identifies mismatches with line numbers
→ Provides fix command if out of sync
```

**Result:** All synced ✅ or [N] mismatches found

---

### 3. "Did I run sync-version.sh?"
```
→ Compares version.json to all 7 locations
→ If all match → sync script was run ✅
→ If mismatches → sync script needed
→ Shows which files need updating
```

**Use when:** Forgot if you ran the sync script after version bump

---

### 4. "What's the pre-release checklist?"
```
→ Shows 5-step validation:
  1. version.json updated?
  2. CHANGELOG.md updated?
  3. sync-version.sh executed?
  4. All files show new version?
  5. Git status clean?
→ Each item ✅ or ❌ with fix
```

**Use when:** About to create release, want checklist

---

### 5. "Validate version increment"
```
→ Checks previous version (from git)
→ Checks current version (from version.json)
→ Validates semantic versioning rules
→ Confirms MAJOR.MINOR.PATCH correctness
```

**Example:** 3.4.0 → 3.5.0 is valid MINOR bump ✅

---

## Pro Tips

### Version Sync Workflow
```
1. Update version.json (bump version)
2. Run: ./scripts/sync-version.sh
3. Ask: "Check version consistency"
4. Verify: All 7 locations synced ✅
5. Update CHANGELOG.md
6. Commit
```

**Critical:** ALWAYS run sync-version.sh after editing version.json!

---

### 7 File Locations (Reference)

| File | Line(s) | Format |
|------|---------|--------|
| version.json | 2 | "version": "3.5.0" |
| CLAUDE.md | 4 | **Version:** v3.5.0 |
| README.md | 306 | **Current Version:** v3.5.0 |
| README.md | 339 | Quick Start: v3.5.0 |
| README.md | 463 | Footer: v3.5.0 |
| SETUP_CONTEXT.md | 21 | **Version:** v3.5.0 |
| SETUP_CONTEXT.md | 437 | Footer: v3.5.0 |

**Manual update:** NOT recommended (error-prone)
**Use script:** ./scripts/sync-version.sh (automatic)

---

## Quick Decision Tree

```
Need to... | Use...
-----------|-------
Check current version | "What version is this project?"
Verify sync | "Check version consistency"
Forgot to sync? | "Did I run sync-version.sh?"
Pre-release check | "What's the pre-release checklist?"
Validate bump | "Validate version increment"
```

---

## Common Scenarios

### Scenario 1: Version Mismatch
**Problem:** "README shows v3.4.0 but version.json is v3.5.0"

**Solution:**
```
Ask: "Check version consistency"
→ Skill detects: 3 mismatches in README.md
→ Recommends: ./scripts/sync-version.sh
→ Run script, re-check
```

**Time saved:** 10 minutes of manual find/replace

---

### Scenario 2: Forgot to Sync
**Problem:** "Did I run sync script after bumping version?"

**Solution:**
```
Ask: "Did I run sync-version.sh?"
→ Skill compares all locations
→ If synced: ✅ "All files match v3.5.0"
→ If not: ❌ "Run ./scripts/sync-version.sh"
```

**Time saved:** 5 minutes of checking 7 files manually

---

### Scenario 3: Wrong Version Bump
**Problem:** "Bumped v3.4.0 → v4.0.0 but only added features"

**Solution:**
```
Ask: "Validate version increment"
→ Skill detects MAJOR bump
→ Asks: "Are there breaking changes?"
→ If no: Recommends 3.4.0 → 3.5.0 (MINOR)
```

**Time saved:** Prevents incorrect release tags

---

### Scenario 4: Pre-Release Confusion
**Problem:** "Not sure if ready for release"

**Solution:**
```
Ask: "What's the pre-release checklist?"
→ Skill shows 5-step validation
→ Identifies: CHANGELOG not updated ❌
→ Fix CHANGELOG, re-run checklist
```

**Time saved:** 15 minutes of mental checklist review

---

## Semantic Versioning Quick Guide

```
Format: MAJOR.MINOR.PATCH

MAJOR (X.0.0) - Breaking changes
- Removed features
- API changes incompatible with previous version
- Example: 3.9.9 → 4.0.0

MINOR (0.X.0) - New features (backwards-compatible)
- New skills
- New documentation
- New features
- Example: 3.4.0 → 3.5.0

PATCH (0.0.X) - Bug fixes only
- Typo fixes
- Broken link fixes
- Small improvements
- Example: 3.5.0 → 3.5.1
```

---

## Integration with Skills

### Version Management Skill
Automatic version checking without manual file inspection:

```
You ask: "Check version consistency"
Skill activates automatically:
→ Reads version.json
→ Checks 7 file locations
→ Reports mismatches
```

**Token savings:** 65% (750 → 250 tokens per check)

### Related Skills
- **commit-readiness-checker:** Full pre-commit validation
- **documentation-sync-checker:** Cross-reference validation
- **workflow-analyzer:** Analyze version bump patterns

---

## Troubleshooting

### Issue: "Sync script doesn't update all files"
**Cause:** version.json format incorrect

**Fix:**
```bash
# Validate version.json syntax
cat version.json | python -m json.tool

# Should see:
{
  "version": "3.5.0",
  "release_date": "2025-12-15",
  "release_name": "Attentive Sous Chef"
}

# If syntax error, fix JSON
# Then re-run: ./scripts/sync-version.sh
```

---

### Issue: "Skill reports mismatch but files look correct"
**Cause:** Line numbers changed (docs restructured)

**Fix:**
```
Skill expects specific line numbers:
- CLAUDE.md line 4
- README.md lines 306, 339, 463
- SETUP_CONTEXT.md lines 21, 437

If docs restructured:
1. Update sync-version.sh with new line numbers
2. Or manually fix version strings
3. Verify: grep -r "3.5.0" CLAUDE.md README.md
```

---

### Issue: "Not sure what version to bump to"
**Cause:** Semantic versioning confusion

**Decision Tree:**
```
Did you...
- Remove features? → MAJOR bump (4.0.0)
- Break backwards compatibility? → MAJOR bump
- Add new features? → MINOR bump (3.5.0)
- Only fix bugs/typos? → PATCH bump (3.4.1)
```

**Ask skill:** "Validate version increment" for guidance

---

## Speed Shortcuts

### Quick Version Check
```bash
# Manual check (1 command)
cat version.json | grep version

# Or ask skill (natural language)
# "What version is this project?"
```

---

### Quick Sync Verification
```bash
# Manual (check all 7 files)
grep -r "3.5.0" CLAUDE.md README.md .claude/SETUP_CONTEXT.md

# Or ask skill (1 query)
# "Check version consistency"
```

---

### Quick Bump + Sync
```bash
# 1. Edit version.json (change version field)
vim version.json

# 2. Auto-sync all 7 locations
./scripts/sync-version.sh

# 3. Verify (skill auto-checks)
# "Did I run sync-version.sh?"
```

**Time:** 2 minutes total

---

## Version History Context

### Why 7 Locations?
```
version.json - Source of truth (automation reads this)
CLAUDE.md - Project memory (Claude reads this first)
README.md (3x) - User-facing docs (landing page, quick start, footer)
SETUP_CONTEXT.md (2x) - Token-optimized setup guide (header, footer)
```

**Rationale:** Each file serves different audience (automation, Claude, users)

---

## Additional Resources

- **Skill Documentation:** `.claude/skills/version-management/SKILL.md`
- **Sync Script:** `./scripts/sync-version.sh`
- **CLAUDE.md:** Version history section
- **CHANGELOG.md:** Complete version history
- **Semantic Versioning:** https://semver.org

---

**Last Updated:** 2025-12-15 (v3.5.0)
**Skill:** version-management
**Audience:** Template maintainers, release managers
