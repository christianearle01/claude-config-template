---
name: commit-readiness-checker
description: Validates all release criteria are met before git commit. Auto-activates when users ask if they're ready to commit, what's missing, or request commit validation. Checks version bumped, changelog updated, docs synced, git status, and drafts commit message.
allowed-tools: Read, Bash, Grep
---

# Commit Readiness Checker Skill

## Purpose & Activation

**What it does:** Validates all release prerequisites are met before committing, eliminating pre-commit anxiety and preventing incomplete releases.

**When it activates automatically:**
- "Am I ready to commit?"
- "Can I commit now?"
- "What's missing before commit?"
- "Check if ready for commit"
- "Validate release readiness"
- "Is everything done for the release?"

**How it helps:**
- Eliminates pre-commit anxiety ("Did I forget something?")
- Validates all release checklist items
- Prevents incomplete commits
- Drafts commit messages automatically
- Suggests next steps

---

## Release Checklist Criteria

### Critical (Must Pass)

**1. Version Bumped**
- version.json updated with new version
- Semantic versioning correct (MAJOR.MINOR.PATCH)

**2. CHANGELOG Updated**
- New version entry added
- Features documented
- Changes explained
- Token impact noted (if applicable)

**3. Files Synced**
- sync-version.sh executed successfully
- All version references updated (CLAUDE.md, README, SETUP_CONTEXT)

**4. Git Status Clean**
- No untracked files in critical paths
- No unstaged changes (or all changes intentional)

### Recommended (Should Pass)

**5. Documentation Updated**
- Skills documented (if new skills added)
- README updated (if features changed)
- QUICK_REFERENCE updated (if new features)

**6. Examples/Templates Updated**
- Templates match new version (if changed)
- Examples reflect new features (if applicable)

---

## Key Operations

### Operation 1: Full Readiness Check

**User Query:** "Am I ready to commit?"

**Skill Response (All Pass):**
```
✅ Release Readiness: READY TO COMMIT

Critical Checks:
✅ Version bumped (3.3.0 → 3.4.0)
✅ CHANGELOG updated (v3.4.0 entry present)
✅ Files synced (7 locations verified)
✅ Git status clean (all changes staged)

Recommended Checks:
✅ Skills documented (7 new skills)
✅ README updated
✅ QUICK_REFERENCE updated

All checks passed! ✨

Next step: Review commit message below, then commit.

Suggested commit message:
---
🔖 Release v3.4.0: Workflow Optimization & Learning Stages

Features:
- Add 7 workflow & setup optimization skills
- Create Learning Stages documentation
- Establish progression path (Beginner → Advanced)
- Reduce commands from 5 to 3

Skills added:
- version-management (maintainer workflow)
- commit-readiness-checker (release validation)
- documentation-sync-checker (consistency)
- workflow-analyzer (git-based meta-skill)
- skill-template-generator (accelerate creation)
- global-setup-assistant (user onboarding)
- project-onboarding-assistant (project setup)

Learning Stages:
- Explicit progression documentation
- Commands graduation guide
- remove-commands.sh script

Token impact: 80,000 tokens/month saved (~$2.40/month, projected)

Documentation updates:
- LEARNING_STAGES.md created
- Commands reduced (5 → 3)
- All skills documented

Version synced: v3.4.0

🤖 Generated with Claude Code (https://claude.com/claude-code)

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
---

Execute:
  git commit -F /tmp/commit-message.txt
  git tag v3.4.0
```

---

**Skill Response (Some Failures):**
```
⚠️ Release Readiness: NOT READY

Critical Checks:
✅ Version bumped (3.3.0 → 3.4.0)
❌ CHANGELOG updated
   Missing: v3.4.0 entry in CHANGELOG.md
   Action: Add after line 8 (## [Unreleased])
✅ Files synced (7 locations verified)
❌ Git status clean
   Issue: Untracked files detected
   Files: .claude/skills/new-skill/ (not staged)

Recommended Checks:
✅ Skills documented
⚠️ README updated (partially)
   Note: README feature list may need update

BLOCKED: Fix 2 critical issues before committing.

Next steps:
1. Update CHANGELOG.md with v3.4.0 entry
2. Stage untracked files: git add .claude/skills/new-skill/
3. Re-check: Ask "Am I ready to commit?"
```

---

### Operation 2: Quick Status Check

**User Query:** "What's missing before commit?"

**Skill Response:**
```
Commit Blockers: 1 critical issue

❌ CHANGELOG.md not updated
   Current: Last entry is v3.3.0
   Expected: v3.4.0 entry with features list

Fix:
1. Edit CHANGELOG.md
2. Add entry after ## [Unreleased]:

## [3.4.0] - 2025-12-13

### Added - Workflow Optimization & Learning Stages

[Document features here]

Once fixed, ask: "Am I ready to commit?"
```

---

### Operation 3: Draft Commit Message

**User Query:** "Draft commit message for v3.4.0"

**Skill Response:**
```
Commit Message for v3.4.0:

Based on CHANGELOG and version.json...

---
🔖 Release v3.4.0: Workflow Optimization & Learning Stages

Features:
- 7 new skills (workflow + setup optimization)
- Learning Stages documentation
- Commands reduction (5 → 3)

[Full message with all features, skills, token impact]

🤖 Generated with Claude Code

Co-Authored-By: Claude Sonnet 4.5 <noreply@anthropic.com>
---

Copy this message or save to file:
  echo "[message]" > /tmp/commit-msg.txt
  git commit -F /tmp/commit-msg.txt
```

---

### Operation 4: Git Status Interpretation

**User Query:** "Check git status before commit"

**Skill Response:**
```
Git Status Analysis:

Modified files (staged):
✅ version.json (3.3.0 → 3.4.0)
✅ CHANGELOG.md (v3.4.0 entry added)
✅ CLAUDE.md (version synced)
✅ README.md (version synced)
✅ SETUP_CONTEXT.md (version synced)

New files (staged):
✅ .claude/skills/version-management/SKILL.md
✅ .claude/skills/commit-readiness-checker/SKILL.md
✅ docs/00-start-here/LEARNING_STAGES.md
[... 10 more files]

Untracked files:
(none - all clean!)

Status: ✅ Safe to commit

All changes are intentional and staged.
No accidental modifications detected.
```

---

### Operation 5: Pre-Commit Validation (Detailed)

**User Query:** "Validate everything before commit"

**Skill Response:**
```
🔍 Detailed Pre-Commit Validation

1. VERSION CHECK ✅
   version.json: 3.4.0
   CLAUDE.md: v3.4.0
   README.md (3 locations): v3.4.0
   SETUP_CONTEXT.md (2 locations): v3.4.0
   All synced!

2. CHANGELOG CHECK ✅
   Entry exists: ## [3.4.0] - 2025-12-13
   Features documented: Yes (7 skills + Learning Stages)
   Token impact noted: Yes (~80,000 tokens/month)
   Projections marked: Yes (⚠️ projections noted)

3. DOCUMENTATION CHECK ✅
   New skills documented: 7/7
   LEARNING_STAGES.md: Created ✓
   SKILLS_PARADIGM.md: Updated ✓
   QUICK_REFERENCE.md: Updated ✓

4. FILES CHECK ✅
   New skills: 7 directories created
   Learning Stages: 1 MD file + 1 script
   Commands reduced: Yes (5 → 3)

5. GIT STATUS ✅
   Staged: 18 files
   Untracked: 0 files
   Unstaged: 0 files

6. SEMANTIC VERSIONING ✅
   Previous: 3.3.0
   Current: 3.4.0
   Type: MINOR (new features)
   Correct: Yes ✓

All validations passed! 🎉

Confidence level: 100% ready to commit

Suggested action:
  git commit -m "🔖 Release v3.4.0: Workflow Optimization & Learning Stages"
  git tag v3.4.0
```

---

## Integration with Release Workflow

### Typical Commit Flow

**Before Commit:**
```
1. Make all changes (version bump, CHANGELOG, new features)
2. Run sync-version.sh
3. Ask skill: "Am I ready to commit?"
4. Fix any blockers identified
5. Ask skill: "Draft commit message"
6. Review message
7. Commit
```

**Usage Pattern:**
```
User: Completes feature work
User: Updates version.json
User: Runs sync-version.sh
User: "Am I ready to commit?"
Skill: Validates all criteria
Skill: Drafts commit message
User: Reviews and commits
```

---

## Common Patterns

### Pattern 1: Iterative Validation

**User:** (After fixing CHANGELOG)
"Am I ready to commit now?"

**Skill:**
```
Re-checking readiness...

Critical Checks:
✅ Version bumped (was already done)
✅ CHANGELOG updated (just fixed! ✓)
✅ Files synced (was already done)
✅ Git status clean (CHANGELOG now staged)

All blockers resolved! ✨

Status: READY TO COMMIT

[Provides commit message]
```

---

### Pattern 2: First-Time Release Check

**User:** "What do I need before first commit?"

**Skill:**
```
First Release Checklist:

Not Started:
❌ Update version.json
❌ Run sync-version.sh
❌ Update CHANGELOG.md
❌ Stage all files (git add .)

Follow this order:
1. Update version.json (version, release_date, release_name)
2. Run: ./scripts/sync-version.sh
3. Update CHANGELOG.md with new entry
4. Stage: git add .
5. Ask me: "Am I ready to commit?"

Start with step 1!
```

---

### Pattern 3: Post-Sync Validation

**User:** "I ran sync-version.sh, what now?"

**Skill:**
```
Post-Sync Status:

✅ Completed:
- version.json updated
- Files synced (verified 7 locations)

❌ Remaining:
- CHANGELOG.md (needs v3.4.0 entry)
- Git staging (need to: git add .)

Progress: 50% complete

Next immediate step:
Update CHANGELOG.md with v3.4.0 entry

Then: git add .
Then: Ask "Am I ready to commit?"
```

---

## Token Efficiency Analysis

⚠️ **These are PROJECTIONS based on testing, not multi-user validation.**

### Without Skill (Current - 900 tokens per query)

**Process:**
1. User: "Am I ready to commit?" (50 tokens)
2. Claude: "Let me check several things..." (100 tokens)
3. Read version.json (100 tokens)
4. Read CHANGELOG.md (200 tokens)
5. Check git status (100 tokens)
6. Check multiple files for sync (200 tokens)
7. Format response and draft message (150 tokens)

**Total: ~900 tokens**

### With Skill (Proposed - 300 tokens per query)

**Process:**
1. User: "Am I ready to commit?" (50 tokens)
2. Skill activates (50 tokens)
3. Run checklist validation (150 tokens)
4. Formatted response (50 tokens)

**Total: ~300 tokens**

**Savings: 600 tokens per query (67% reduction)**

### Frequency Impact

**Per Release (2 per week):**
- Pre-commit check: 1 query
- Fix and re-check: 1 query
- Draft commit message: 1 query
- **Total: 3 queries × 600 tokens = 1,800 tokens saved per release**

**Monthly (8 releases):**
- 8 releases × 1,800 tokens = 14,400 tokens saved
- **Cost savings: ~$0.43/month** (at Claude pricing)

**Quarterly:**
- 24 releases × 1,800 tokens = 43,200 tokens saved
- **Cost savings: ~$1.30/quarter**

**ROI:** Pays for implementation cost (~500 tokens) after 1 release.

---

## Troubleshooting

### Issue: False Positive (Says ready but commit fails)

**Symptom:** Skill says "ready" but git commit fails

**Cause:** Git hooks, pre-commit scripts, or file permissions

**Solution:**
```
Skill checks standard criteria but cannot predict:
- Git hooks (pre-commit, commit-msg)
- File permission issues
- Git configuration problems

If commit fails after skill approval:
1. Check git hook output
2. Fix specific issue
3. Re-run commit
```

---

### Issue: CHANGELOG Detection Fails

**Symptom:** Skill says CHANGELOG missing entry, but it exists

**Cause:** Format mismatch or unexpected structure

**Solution:**
```
CHANGELOG must have exact format:
## [3.4.0] - 2025-12-13

Check:
- Square brackets around version
- Dash separator
- YYYY-MM-DD date format
- Spacing matches pattern

Correct any format issues.
```

---

### Issue: Git Status Shows Unexpected Files

**Symptom:** Skill reports untracked/modified files user didn't create

**Cause:** Auto-generated files, IDE configs, OS files

**Solution:**
```
Common culprits:
- .DS_Store (macOS)
- .vscode/ (VS Code)
- node_modules/ (npm)
- __pycache__/ (Python)

Check .gitignore includes these patterns.
If needed, update .gitignore before committing.
```

---

## See Also

- **version-management skill** - Check version consistency
- **documentation-sync-checker skill** - Validate docs
- **workflow-analyzer skill** - Analyze commit patterns
- **Git Approval Workflow** - 01_global-setup/good-to-have/04_git-approval-workflow.md
- **CLAUDE.md** - Git commit workflow documentation

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Target Audience:** Template maintainers, release managers
**Maintained By:** claude-config-template project
