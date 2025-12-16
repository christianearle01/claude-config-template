# Quick Reference: Commit Readiness Checker

**Just-in-Time Help** for pre-commit validation

---

## Most Common Queries (90% usage)

### 1. "Am I ready to commit?"
```
→ Full validation checklist (6 categories)
→ Critical checks: version, CHANGELOG, sync, git status
→ Recommended checks: docs, examples, templates
→ Generates ready-to-use commit message
→ Identifies blockers with fix instructions
```

**Result:** READY or NOT READY with specific actions

---

### 2. "What's missing before commit?"
```
→ Quick blocker check (critical items only)
→ Skips recommended checks for speed
→ Actionable fix instructions with line numbers
→ Re-check command provided
```

**Use when:** You know you're almost ready, just need to see what's left

---

### 3. "Draft commit message for vX.X.X"
```
→ Reads CHANGELOG.md for feature list
→ Reads version.json for release name
→ Uses standard template format
→ Includes Co-Authored-By attribution
→ Ready to copy or save to file
```

**Use when:** All checks pass, just need message text

---

### 4. "Check git status before commit"
```
→ Categorizes files (staged/unstaged/untracked)
→ Interprets changes (version updates, new features)
→ Identifies accidental modifications
→ Confirms safe to commit
```

**Use when:** Want to review what will be committed

---

### 5. "Validate everything before commit"
```
→ Most comprehensive check (all 6 categories)
→ Version consistency (7 locations)
→ CHANGELOG completeness
→ Documentation updates
→ Git status interpretation
→ Semantic versioning validation
→ 100% confidence when all pass
```

**Use when:** First release, high-stakes commit, or paranoid double-check

---

## Pro Tips

### Pre-Commit Workflow
```
1. Make all changes (version bump, features, docs)
2. Run: ./scripts/sync-version.sh
3. Ask: "Am I ready to commit?"
4. Fix any blockers
5. Ask: "Draft commit message"
6. Review and commit
```

**Time:** 5 minutes (vs 20 minutes manual checking)

---

### Blocker Patterns

#### Common Blocker 1: CHANGELOG Not Updated
```
❌ Missing: v3.5.0 entry in CHANGELOG.md

Fix:
1. Edit CHANGELOG.md
2. Add after ## [Unreleased]:

## [3.5.0] - 2025-12-15

### Added - [Release Name]

[Features list]
```

#### Common Blocker 2: Files Not Synced
```
❌ Version mismatch detected

Fix:
1. Run: ./scripts/sync-version.sh
2. Verify: git diff (should show updated files)
3. Stage: git add .
```

#### Common Blocker 3: Untracked Files
```
❌ Untracked files detected

Fix:
1. Review files: git status
2. Stage intentional files: git add <files>
3. Ignore noise: Update .gitignore
```

---

## Quick Decision Tree

```
Situation | Ask...
----------|-------
First-time release | "Validate everything before commit"
Quick check | "What's missing before commit?"
Standard release | "Am I ready to commit?"
Just need message | "Draft commit message for v3.5.0"
Review changes | "Check git status before commit"
```

---

## Release Checklist (Manual Reference)

### Critical (Must Pass)
- [ ] version.json updated with new version
- [ ] CHANGELOG.md has new version entry
- [ ] sync-version.sh executed successfully
- [ ] All changes staged (git status clean)

### Recommended (Should Pass)
- [ ] Skills documented (if new skills added)
- [ ] README updated (if features changed)
- [ ] QUICK_REFERENCE updated (if new features)

### Validation
- [ ] Ask: "Am I ready to commit?"
- [ ] All checks green ✅
- [ ] Commit message drafted

---

## Common Scenarios

### Scenario 1: Forgot to Update CHANGELOG
**Problem:** "Committed but realized CHANGELOG empty"

**Prevention:**
```
BEFORE committing:
Ask: "Am I ready to commit?"
→ Skill catches missing CHANGELOG
→ Provides template to add
→ Prevents embarrassing empty release notes
```

**Time saved:** 10 minutes + 1 extra commit to fix

---

### Scenario 2: Version Out of Sync
**Problem:** "CLAUDE.md shows v3.4.0 but version.json is v3.5.0"

**Prevention:**
```
Ask: "Am I ready to commit?"
→ Skill detects mismatch across 7 files
→ Recommends: ./scripts/sync-version.sh
→ Verifies all locations consistent
```

**Time saved:** 15 minutes of manual checking

---

### Scenario 3: Unintentional Files
**Problem:** "Accidentally committed debug files"

**Prevention:**
```
Ask: "Check git status before commit"
→ Skill lists all staged files
→ Identifies unexpected files (debug.log, test.tmp)
→ Unstage before committing
```

**Time saved:** 1 hour of cleanup + force push explanation

---

### Scenario 4: Pre-Commit Hook Failure
**Problem:** "Git hook rejects commit, not sure why"

**Solution:**
```
Ask: "Validate everything before commit"
→ Skill runs same checks git hooks expect
→ Identifies issue (missing file, wrong format)
→ Fix before attempting commit
```

**Time saved:** 20 minutes of hook debugging

---

## Integration with Skills

### Commit Readiness Checker Skill
Automatic validation without manual checklist review:

```
You ask: "Am I ready to commit?"
Skill activates automatically:
→ Validates 6 categories
→ Generates commit message
→ Provides next steps
```

**Token savings:** 67% (900 → 300 tokens per check)

### Related Skills
- **version-management:** Check version consistency specifically
- **documentation-sync-checker:** Validate cross-references
- **workflow-analyzer:** Analyze commit patterns over time

---

## Commit Message Template

```
🔖 Release vX.X.X: [Release Name]

Features:
- [Feature 1 description]
- [Feature 2 description]

[Additional details: skills added, docs updated, etc.]

Token impact: [X tokens/month saved] (projected)

Documentation updates:
- [File 1]
- [File 2]

Version synced: vX.X.X

🤖 Generated with Claude Code (https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
```

**Copy this structure** or ask skill to draft for you!

---

## Troubleshooting

### Issue: "Skill says ready but commit fails"
**Cause:** Git hooks, pre-commit scripts, or permissions

**Fix:**
```
Skill checks standard criteria but cannot predict:
- Custom git hooks
- File permissions
- Git configuration

If commit fails after skill approval:
1. Check hook output: git commit --verbose
2. Fix specific issue
3. Re-run commit
```

---

### Issue: "CHANGELOG detection fails"
**Cause:** Format mismatch

**Fix:**
```
CHANGELOG must match exact format:
## [X.X.X] - YYYY-MM-DD

Check:
- Square brackets around version
- Dash separator
- YYYY-MM-DD date format
- Proper spacing

Correct example:
## [3.5.0] - 2025-12-15
```

---

### Issue: "False negative on sync"
**Cause:** sync-version.sh didn't update all files

**Fix:**
```bash
# Re-run sync script
./scripts/sync-version.sh

# Verify all locations updated
grep -r "3.5.0" CLAUDE.md README.md .claude/SETUP_CONTEXT.md

# If still failing, check version.json format
cat version.json | python -m json.tool
```

---

## Speed Shortcuts

### Option 1: Fast Path (Experienced Users)
```bash
# 1. Update version
vim version.json

# 2. Sync files
./scripts/sync-version.sh

# 3. Update CHANGELOG
vim CHANGELOG.md

# 4. Stage all
git add .

# 5. Quick check
# Ask: "What's missing before commit?"

# 6. Commit
git commit -m "..."
```

**Time:** 3 minutes

---

### Option 2: Safe Path (First Release)
```bash
# 1. Update version
vim version.json

# 2. Sync files
./scripts/sync-version.sh

# 3. Update CHANGELOG
vim CHANGELOG.md

# 4. Stage all
git add .

# 5. Full validation
# Ask: "Validate everything before commit"

# 6. Draft message
# Ask: "Draft commit message for v3.5.0"

# 7. Commit
git commit -F /tmp/commit-msg.txt
```

**Time:** 5 minutes (but 100% confidence)

---

## Semantic Versioning Guide

```
Version format: MAJOR.MINOR.PATCH

MAJOR (X.0.0) - Breaking changes
- API changes
- Removed features
- Major restructuring

MINOR (0.X.0) - New features (backwards-compatible)
- New documentation
- New skills
- New features

PATCH (0.0.X) - Bug fixes
- Typos
- Broken links
- Small improvements
```

**Skill validates** semantic versioning correctness!

---

## Additional Resources

- **Skill Documentation:** `.claude/skills/commit-readiness-checker/SKILL.md`
- **Git Workflow Guide:** `01_global-setup/02_good-to-have/04_git-approval-workflow.md`
- **CLAUDE.md:** Git commit workflow section
- **Version Sync Script:** `./scripts/sync-version.sh`

---

**Last Updated:** 2025-12-15 (v3.5.0)
**Skill:** commit-readiness-checker
**Audience:** Template maintainers, release managers
