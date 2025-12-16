---
name: version-management
description: Tracks version consistency across version.json, README, CLAUDE.md, CHANGELOG, and SETUP_CONTEXT. Auto-activates when users ask about version updates, version sync, or what files need updating for a release. Validates completeness and suggests next steps.
allowed-tools: Read, Grep
---

# Version Management Skill

## Purpose & Activation

**What it does:** Provides version tracking intelligence for multi-file version consistency across the template.

**When it activates automatically:**
- "What needs updating for v3.4.0?"
- "Did I update all version files?"
- "Is version synced?"
- "Check version consistency"
- "Are all files at the same version?"
- "What's missing for the release?"

**How it helps:**
- Eliminates version anxiety (no more "did I forget a file?")
- Shows current state vs target state
- Validates sync-version.sh was run correctly
- Lists remaining tasks before commit
- Suggests next steps in release workflow

**JIT Help Available:**
For quick reference on version workflow and troubleshooting, see: **[Cheat Sheet](./cheatsheet.md)**
- 5 most common version queries (90% usage)
- Version sync workflow (6 steps, 2 minutes)
- 7 file locations reference table
- Quick decision tree
- Semantic versioning guide
- Troubleshooting mismatch errors

---

## Version File Locations

### Primary Source of Truth
**`version.json`** - Master version file
- Field: `version` (e.g., "3.4.0")
- Field: `release_date` (e.g., "2025-12-13")
- Field: `release_name` (e.g., "Workflow Optimization & Learning Stages")

### Auto-Synced Files (via sync-version.sh)
**`CLAUDE.md:4`** - Project documentation
- Format: `**Version:** v3.4.0`

**`README.md`** - Multiple locations
- Line 306: Feature list footer
- Line 339: Documentation section
- Line 463: Footer version

**`.claude/SETUP_CONTEXT.md`** - Setup guide
- Line 21: Quick reference
- Line 437: Footer version

### Manual Update Required
**`CHANGELOG.md`** - Release notes
- Must add new `## [3.4.0] - YYYY-MM-DD` entry
- Document all features, changes, impacts
- Update `## [Unreleased]` section

---

## Key Operations

### Operation 1: Check Current Version

**User Query:**
> "What version are we at?"

**Confidence:** 🟢 High (0.95)
- Direct version query
- version.json accessible
- Clear information request

**Skill Response:**
```
Current version: v3.3.0 (as of 2025-12-13)
Release: "Skills Architecture & Intelligence Layer"

Files checked:
✅ version.json: 3.3.0
✅ CLAUDE.md:4: v3.3.0
✅ README.md (3 locations): v3.3.0
✅ SETUP_CONTEXT.md (2 locations): v3.3.0
✅ CHANGELOG.md: v3.3.0 entry exists

All files in sync! ✨
```

**Why This Matters:**
- Quick sanity check prevents version confusion during development
- All files in sync = safe to proceed with new work
- Current release name helps maintain context ("Skills Architecture")
- **Quick win:** You're ready to start planning v3.4.0 features

**Next Step:** Want to see what changed in v3.3.0? Ask "Show me CHANGELOG for v3.3.0"

---

### Operation 2: Validate Version Consistency

**User Query:**
> "Is version synced?"

**Confidence:** 🟢 High (0.93)
- Clear validation request
- 6 file locations to check
- Deterministic check (synced or not synced)

**Skill Response:**
```
Checking version consistency...

Primary: version.json = 3.4.0

Synced files:
✅ CLAUDE.md:4 = v3.4.0
✅ README.md:306 = v3.4.0
✅ README.md:339 = v3.4.0
✅ README.md:463 = v3.4.0
✅ SETUP_CONTEXT.md:21 = v3.4.0
✅ SETUP_CONTEXT.md:437 = v3.4.0

All synced! sync-version.sh ran successfully.
```

**OR if inconsistent:**
```
⚠️ Version mismatch detected!

Primary: version.json = 3.4.0

Mismatches:
❌ CLAUDE.md:4 = v3.3.0 (expected v3.4.0)
❌ README.md:306 = v3.3.0 (expected v3.4.0)

Run: ./scripts/sync-version.sh
```

**Why This Matters:**
- Version mismatches cause user confusion and broken links
- 6 file locations must stay in sync (manual tracking is error-prone)
- Catching mismatches before commit saves embarrassing fixes
- **Quick win:** Run `./scripts/sync-version.sh` if any mismatches found

**Next Step:** All synced? Move to "What needs updating for v3.4.0?" to see remaining tasks

---

### Operation 3: Pre-Release Checklist

**User Query:**
> "What needs updating for v3.4.0?"

**Confidence:** 🟢 High (0.88)
- Specific release version referenced
- Checklist has clear completion criteria
- Can check file states deterministically

**Skill Response:**
```
Release Checklist for v3.4.0:

✅ Done:
- version.json updated (3.3.0 → 3.4.0)
- version.json release_date set (2025-12-13)
- version.json release_name set
- sync-version.sh executed
- All version numbers synced

❌ Remaining:
- CHANGELOG.md: Add v3.4.0 entry
  Location: After line 8 (## [Unreleased])
  Template: ## [3.4.0] - 2025-12-13

- CHANGELOG.md: Document features
  - List new skills (7 total)
  - Document Learning Stages
  - Include token impact analysis

Next step: Update CHANGELOG.md, then commit
```

**Why This Matters:**
- Pre-release checklist prevents "oops, forgot CHANGELOG" moments
- Completing items in order reduces rework (sync files before documenting)
- Clear remaining tasks = no ambiguity about "done" state
- **Quick win:** Edit CHANGELOG.md now, then ask "Am I ready to commit?"

**Next Step:** After updating CHANGELOG, ask "Did I commit the version bump?" to validate

---

### Operation 4: Detect Uncommitted Version Changes

**User Query:**
> "Did I commit the version bump?"

**Confidence:** 🟢 High (0.91)
- Git status check is deterministic
- Version-related files easily identifiable
- Clear commit state (staged/unstaged/committed)

**Skill Response:**
```
Checking git status...

Modified files:
- version.json (v3.3.0 → v3.4.0)
- CLAUDE.md (synced to v3.4.0)
- README.md (synced to v3.4.0)
- SETUP_CONTEXT.md (synced to v3.4.0)
- CHANGELOG.md (v3.4.0 entry added)

Status: Changes staged, ready to commit

Suggested commit message:
"🔖 Bump version to v3.4.0 (Workflow Optimization & Learning Stages)"
```

**Why This Matters:**
- Uncommitted version changes create ambiguity (is it official?)
- Git history shows when version became "live"
- Suggested commit message follows project conventions (🔖 emoji)
- **Quick win:** Copy suggested message: `git commit -m "🔖 Bump version to v3.4.0"`

**Next Step:** After committing, run `git tag v3.4.0` to mark the release

---

### Operation 5: Version Increment Validation

**User Query:**
> "Is v3.4.0 the right next version?"

**Confidence:** 🟢 High (0.87)
- Semantic versioning rules are clear
- Can assess change type from description
- Deterministic validation

**Skill Response:**
```
Current: v3.3.0
Proposed: v3.4.0

Semantic versioning check:
✅ MINOR bump (3.3 → 3.4) - Correct!

Reason: Adding new features (7 skills + Learning Stages)
- Not breaking changes (would need MAJOR: 4.0.0)
- Not just bugfixes (would need PATCH: 3.3.1)

v3.4.0 is appropriate for this release.
```

**Why This Matters:**
- Wrong version number confuses users about compatibility
- MAJOR bump (4.0.0) signals breaking changes → users hesitate to upgrade
- PATCH bump (3.3.1) undersells new features → low adoption
- **Quick win:** v3.4.0 correctly signals "new features, backward compatible"

**Next Step:** Proceed with confidence! Update version.json to 3.4.0

---

## Integration with Release Workflow

### Typical Release Flow

**Step 1: Update version.json**
```json
{
  "version": "3.4.0",
  "release_date": "2025-12-13",
  "release_name": "Workflow Optimization & Learning Stages"
}
```

**Step 2: Run sync script**
```bash
./scripts/sync-version.sh
```

**Step 3: Check with skill**
> "Is version synced?"

**Step 4: Update CHANGELOG**
Add v3.4.0 entry with features

**Step 5: Final validation**
> "What needs updating for v3.4.0?"

**Step 6: Commit**
```bash
git commit -am "🔖 Bump version to v3.4.0"
git tag v3.4.0
```

---

## Common Patterns

### Pattern 1: Starting a Release

**User:** "I'm releasing v3.5.0"

**Skill:**
```
Starting v3.5.0 release...

Current version: v3.4.0

Steps to follow:
1. Update version.json:
   - version: "3.5.0"
   - release_date: "YYYY-MM-DD"
   - release_name: "Your Release Name"

2. Run: ./scripts/sync-version.sh

3. Ask me: "Is version synced?"

4. Update CHANGELOG.md with v3.5.0 entry

5. Ask me: "What needs updating for v3.5.0?"

Ready to start!
```

---

### Pattern 2: Mid-Release Check

**User:** "Where am I in the release process?"

**Skill:**
```
Release Progress: v3.4.0

✅ Completed:
- version.json updated
- Files synced (7 files)

⏳ In Progress:
- CHANGELOG.md (needs v3.4.0 entry)

❌ Not Started:
- Git commit
- Git tag

Current phase: Documentation (50% complete)
Next: Finish CHANGELOG, then commit
```

---

### Pattern 3: Post-Sync Validation

**User:** "Did sync-version.sh work?"

**Skill:**
```
Validating sync-version.sh execution...

Expected version: v3.4.0 (from version.json)

Checking 6 locations:
✅ CLAUDE.md:4 = v3.4.0
✅ README.md:306 = v3.4.0
✅ README.md:339 = v3.4.0
✅ README.md:463 = v3.4.0
✅ SETUP_CONTEXT.md:21 = v3.4.0
✅ SETUP_CONTEXT.md:437 = v3.4.0

sync-version.sh executed successfully! ✨

All files updated correctly.
```

---

## Token Efficiency Analysis

⚠️ **These are PROJECTIONS based on testing, not multi-user validation.**

### Without Skill (Current - 600 tokens per query)

**Process:**
1. User: "What files need updating?" (50 tokens)
2. Claude: "Let me check..." (100 tokens)
3. Read version.json (100 tokens)
4. Read multiple files to compare (200 tokens)
5. Format response (150 tokens)

**Total: ~600 tokens**

### With Skill (Proposed - 250 tokens per query)

**Process:**
1. User: "What files need updating?" (50 tokens)
2. Skill activates automatically (50 tokens)
3. Read version.json + check files (100 tokens)
4. Formatted response (50 tokens)

**Total: ~250 tokens**

**Savings: 350 tokens per query (58% reduction)**

### Frequency Impact

**Per Release (2 per week):**
- Check version: 2 queries
- Validate sync: 2 queries
- Pre-release checklist: 1 query
- Post-commit validation: 1 query
- **Total: 6 queries × 350 tokens = 2,100 tokens saved per release**

**Monthly (8 releases):**
- 8 releases × 2,100 tokens = 16,800 tokens saved
- **Cost savings: ~$0.50/month** (at Claude pricing)

**Quarterly:**
- 24 releases × 2,100 tokens = 50,400 tokens saved
- **Cost savings: ~$1.52/quarter**

**ROI:** Pays for implementation cost (~500 tokens) after 1 release.

---

## Troubleshooting

### Issue: Version Mismatch After Sync

**Symptom:** Files show different versions after running sync-version.sh

**Cause:** sync-version.sh may have failed or been interrupted

**Solution:**
```
1. Check sync-version.sh output for errors
2. Manually verify version.json is correct
3. Re-run: ./scripts/sync-version.sh
4. Validate: Ask skill "Is version synced?"
```

---

### Issue: CHANGELOG Not Updated

**Symptom:** Skill reports CHANGELOG missing v3.x.0 entry

**Cause:** CHANGELOG.md requires manual update (not auto-synced)

**Solution:**
```
1. Edit CHANGELOG.md
2. Add entry after ## [Unreleased]:
   ## [3.4.0] - 2025-12-13
3. Document features and changes
4. Ask skill: "What needs updating?"
```

---

### Issue: Git Shows Uncommitted Changes

**Symptom:** Version files modified but not committed

**Cause:** Normal - files changed by version bump

**Solution:**
```
This is expected! Version bump modifies files.

Steps:
1. Review changes: git diff
2. Stage all: git add .
3. Commit: git commit -m "🔖 Bump version to v3.4.0"
4. Tag: git tag v3.4.0
```

---

## See Also

- **commit-readiness-checker skill** - Validates commit prerequisites
- **documentation-sync-checker skill** - Checks doc consistency
- **workflow-analyzer skill** - Analyzes version management patterns
- **CHANGELOG.md** - Manual release notes
- **scripts/sync-version.sh** - Auto-sync script

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Target Audience:** Template maintainers, release managers
**Maintained By:** claude-config-template project
