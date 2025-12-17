---
name: release
description: Orchestrate complete release workflow with quality, version, and deployment checks
---

Execute a complete release workflow, validating all requirements before creating a release.

**When to use:**
- Preparing for production deployment
- Creating versioned releases
- Validating release readiness across all checks

**What this command does:**
Orchestrates 5 sequential checks to validate release readiness:
1. Quality checks (code standards, tests, security)
2. Version consistency (all files updated)
3. Changelog validation (release notes complete)
4. Git state (clean, ready to tag)
5. Deployment readiness (comprehensive pre-deploy validation)

**First, confirm with the user:**
"This will run a comprehensive release workflow. Proceed? (This may take 2-3 minutes)"

---

## Release Workflow (Sequential Execution)

### Step 1: Quality Checks

**Invoke:** `@quality-reviewer`

**What it checks:**
- Security: OWASP Top 10, CVE vulnerabilities, secrets
- Tests: Coverage, passing status, test quality
- Standards: Code style, patterns, team preferences

**Pass criteria:** ≥85% confidence (no critical issues)

**If fails:** Stop workflow, report blockers, suggest fixes

---

### Step 2: Version Verification

**Use:** version-management skill

**Check files:**
- `version.json` - version field updated
- `README.md` - version references updated
- `CLAUDE.md` - version history entry added
- `CHANGELOG.md` - latest version matches
- `.claude/SETUP_CONTEXT.md` - version references updated

**Commands to run:**
```bash
# Check version.json
cat version.json | grep '"version"'

# Verify sync script ran
git log -1 --oneline | grep -i "version\|bump\|release"
```

**Pass criteria:** All version references consistent, no mismatches found

**If fails:** Report which files need version updates, stop workflow

---

### Step 3: Changelog Validation

**Use:** commit-readiness-checker skill

**Validate:**
- `CHANGELOG.md` has entry for current version
- Entry includes: date, features, breaking changes (if any)
- Entry is complete (not "TBD" or placeholders)
- Version format matches semantic versioning (MAJOR.MINOR.PATCH)

**Check format:**
```markdown
## [X.Y.Z] - YYYY-MM-DD

### Added
- Feature descriptions

### Changed
- Changes made

### Fixed
- Bugs fixed
```

**Pass criteria:** Changelog entry complete and properly formatted

**If fails:** Report missing/incomplete changelog entry, stop workflow

---

### Step 4: Git State Verification

**Check git status:**
```bash
# Verify clean working directory
git status --porcelain

# Verify on correct branch
git branch --show-current

# Check remote sync
git fetch origin && git status
```

**Validate:**
- [ ] Working directory clean (no uncommitted changes)
- [ ] On main/master branch (or specified release branch)
- [ ] Up to date with remote (no unpushed commits from others)
- [ ] All changes committed

**Pass criteria:** Clean git state, ready to tag

**If fails:** Report git issues (uncommitted files, wrong branch, etc.), stop workflow

---

### Step 5: Deployment Readiness

**Invoke:** `@deployment-readiness`

**Final comprehensive check:**
- Tests: All test suites passing
- Security: No vulnerabilities
- Documentation: Up-to-date
- Version: Bumped and synced
- Git: Clean state

**Pass criteria:** ≥85% confidence (Ready status)

**If fails:** Report blockers with confidence breakdown, stop workflow

---

## Output Format

After all checks pass:

```
🚀 Release Workflow Report

Version: vX.Y.Z
Branch: main
Date: YYYY-MM-DD

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

STEP 1: QUALITY CHECKS ✅
Confidence: 91%
- Security: No vulnerabilities (94% confidence)
- Tests: 127/127 passing (95% confidence)
- Standards: All checks passed (88% confidence)

STEP 2: VERSION VERIFICATION ✅
All files synced to v4.19.0
- version.json ✓
- README.md ✓
- CLAUDE.md ✓
- CHANGELOG.md ✓
- SETUP_CONTEXT.md ✓

STEP 3: CHANGELOG VALIDATION ✅
Entry complete for v4.19.0
- Date: 2025-12-17 ✓
- Features: 3 listed ✓
- Format: Valid ✓

STEP 4: GIT STATE ✅
- Working directory: Clean
- Branch: main
- Remote sync: Up to date
- Ready to tag: Yes

STEP 5: DEPLOYMENT READINESS ✅
Overall confidence: 91%
Status: Ready to deploy
No blockers found

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ RELEASE VALIDATION COMPLETE

Ready to create release!

Next steps:
1. Create git tag:
   git tag -a v4.19.0 -m "Release v4.19.0: Complete Workflows"

2. Push tag to remote:
   git push origin v4.19.0

3. Push commits:
   git push origin main

4. Create GitHub release (optional):
   gh release create v4.19.0 --notes "See CHANGELOG.md"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## If Workflow Fails

**Output format for failures:**

```
❌ Release Workflow Failed at Step [N]: [Step Name]

Issue: [Description of what failed]

Confidence: [X]% (below 85% threshold)

Blockers:
1. [Specific issue with file:line if applicable]
2. [Another issue]

Recommended fixes:
→ [Action 1]
→ [Action 2]

After fixing, re-run: /release
```

**Do NOT proceed** to subsequent steps if any step fails below 85% confidence.

---

## Success Criteria Summary

| Step | Check | Pass Threshold | Stop on Fail? |
|------|-------|----------------|---------------|
| 1 | Quality | ≥85% confidence | Yes |
| 2 | Version | 100% consistency | Yes |
| 3 | Changelog | Complete entry | Yes |
| 4 | Git State | Clean + synced | Yes |
| 5 | Deployment | ≥85% confidence | Yes |

**Overall pass:** All 5 steps must pass

---

## Integration with v4.18.0 Frameworks

**Decision Framework Application:**
- Use /release when: Code complete, ready to ship
- Don't use when: Still developing, tests failing, experimental changes

**Integration Pattern:**
Sequential tool chain: quality-reviewer → version-management → commit-readiness → deployment-readiness

**Validates:**
- v4.18.0 Integration Patterns (agent orchestration)
- v4.18.0 Decision Framework (when to release)

---

## Confidence Scoring

**How confidence is calculated:**

1. **Quality (30% weight):** Average of security + tests + standards confidence
2. **Version (20% weight):** 100% if all files match, 0% if any mismatch
3. **Changelog (15% weight):** 100% if complete, 0% if missing
4. **Git State (10% weight):** 100% if clean, 0% if dirty
5. **Deployment (25% weight):** Deployment-readiness agent confidence

**Overall confidence = weighted average of all 5 steps**

**Status:**
- ✅ Ready (≥85%): Safe to release
- ⚠️ Conditional (60-84%): Fix warnings first
- ❌ Not Ready (<60%): Must fix blockers

---

## Token Efficiency

**Without /release command:**
- Manual quality check: 1,200 tokens
- Manual version verification: 800 tokens
- Manual changelog check: 400 tokens
- Manual git status: 300 tokens
- Manual deployment check: 1,000 tokens
- **Total: ~3,700 tokens**

**With /release command:**
- Orchestrated workflow: 1,200 tokens
- **Savings: 2,500 tokens (68% reduction, projected)**

**Time savings:**
- Manual: 25-35 minutes (checking each step)
- Automated: 2-3 minutes (command execution)
- **Time saved: 22-32 minutes per release**

---

## Related Resources

- Agents: quality-reviewer, deployment-readiness
- Skills: version-management, commit-readiness-checker, documentation-sync-checker
- Decision Framework: `docs/01-fundamentals/09_decision-framework.md`
- Integration Patterns: `docs/02-optimization/06_integration-patterns.md`

---

**Command Version:** 4.19.0
**Added:** 2025-12-17
**Part of:** v4.19.0 "Complete Workflows" - From Code to Production
