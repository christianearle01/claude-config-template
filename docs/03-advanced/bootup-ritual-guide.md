# Bootup Ritual Guide: Defeating LLM Amnesia

**Last Updated:** 2025-12-15
**Version:** v3.6.0
**Reading Time:** 15 minutes

---

## What Is the Bootup Ritual?

The **Bootup Ritual** is a formalized 5-step discipline that the Coder Agent runs at the START of EVERY session to instantly recover project context. It's the core mechanism that defeats "LLM amnesia" - the context loss that happens when long-running projects span multiple sessions.

**Problem it solves:**
- Without the ritual: "Where were we? What was I building? What's done? What's next?" (5-10 minutes lost every session)
- With the ritual: Full context recovery in 10-15 seconds by reading persistent state files

**Impact:**
- **Token savings:** 350-700 tokens per session (85% reduction in regrounding)
- **Mental load:** 80% reduction (no need to remember project state)
- **Resume time:** 2-3 minutes → 10-15 seconds
- **Project completion:** 60% → 90% (projected, based on Anthropic's research)

---

## The 5-Step Bootup Ritual

### Overview

```
Step 1: Read features.json (What's the plan?)
   ↓
Step 2: Read progress.md (What's done?)
   ↓
Step 3: Run git status (Uncommitted changes?)
   ↓
Step 4: Run tests (System healthy?)
   ↓
Step 5: Identify next atomic feature (What's next?)
```

**Duration:** 10-15 seconds
**Frequency:** Every session start
**Purpose:** Instant context recovery from persistent files

---

## Step 1: Read features.json (What's the Plan?)

### Purpose

Understand the full project structure and feature roadmap from the authoritative plan file.

### What to Extract

**1. Project metadata:**
- Total features (projectInfo.metadata.totalFeatures)
- Completed features (projectInfo.metadata.completedFeatures)
- Overall progress percentage

**2. Current category focus:**
- Which category has in-progress features?
- Which categories are complete vs. not started?

**3. Feature dependencies:**
- learningPath arrays define prerequisites
- Which features are blocked vs. available?

**4. Bootup ritual checklist:**
- Embedded in features.json for reference
- Self-documenting discipline

### Read Command

```bash
cat features.json
```

### Confidence Check

After reading features.json, assess confidence in understanding the project:

- 🟢 **High (0.90+):** features.json exists, valid JSON, clear status for all features
- 🟡 **Medium (0.60-0.89):** features.json exists but stale (lastUpdated > 7 days ago)
- 🔴 **Low (0.0-0.59):** features.json missing, corrupted, or invalid

**If confidence < 0.60:**
- **Missing file:** "No features.json found. Use Initializer Agent to create one first."
- **Corrupted:** Show JSON error, offer to fix or recreate
- **Stale:** Ask user if project is still active

### What You're Looking For

**Status distribution:**
```json
{
  "status": "completed"  // ✅ Done, move on
  "status": "in-progress"  // 🟡 Resume this one (only ONE should exist)
  "status": "available"  // ⭕ Ready to work on (prerequisites met)
}
```

**Available features = those with:**
- status: "available"
- All features in learningPath have status: "completed"

**Example:**
```json
{
  "id": "feat-007",
  "learningPath": ["feat-004"],  // Prerequisite
  "status": "available"
}
```

Only suggest feat-007 if feat-004 is completed.

### Common Issues

**Issue 1: Circular dependencies**
```json
{
  "id": "feat-010",
  "learningPath": ["feat-009"]
},
{
  "id": "feat-009",
  "learningPath": ["feat-010"]  // ← Circular!
}
```

**Detection:** No features are available despite some being incomplete.
**Response:** Alert user, suggest reviewing learningPath arrays.

**Issue 2: Missing prerequisites**
```json
{
  "id": "feat-005",
  "learningPath": ["feat-999"]  // ← Doesn't exist!
}
```

**Detection:** Referenced feature ID not found in features.json.
**Response:** Alert user, suggest removing invalid ID or creating the feature.

---

## Step 2: Read progress.md (What's Done?)

### Purpose

Understand recent work, session notes, and lessons learned from the human-maintained progress journal.

### What to Extract

**1. Last session date:**
- How long since last work? (hours, days, weeks)
- If > 7 days: "It's been a while! Let me refresh you on where we left off..."

**2. Recently completed features:**
- What's fresh in memory?
- What patterns were used?

**3. In-progress features:**
- Was something left incomplete?
- Check adoption.percentageComplete and notes

**4. Session notes:**
- What was the user thinking?
- What challenges did they encounter?
- What decisions were made?

**5. Lessons learned:**
- Mistakes to avoid
- Patterns that worked well
- Time estimate accuracy

### Read Command

```bash
cat progress.md
```

### Cross-Reference with features.json

**Question:** Do progress.md and features.json agree on status?

**Check:**
```
progress.md says: feat-004 completed on 2025-12-14
features.json says: feat-004 status="completed"
```

✅ **Match:** Proceed confidently.

**Mismatch example:**
```
progress.md: feat-004 completed on 2025-12-14
features.json: feat-004 status="in-progress"
```

⚠️ **Mismatch detected:** Ask user which is source of truth.

**Common causes:**
- User manually edited features.json but forgot progress.md
- Session interrupted before both files updated
- User completed feature but didn't run Coder Agent to finalize

**Resolution:**
```markdown
## ⚠️ Sync Issue Detected

**Mismatch:**
- progress.md: feat-004 marked completed
- features.json: feat-004 marked in-progress

**Which is correct?**
1. feat-004 IS complete (update features.json)
2. feat-004 NOT complete (update progress.md)
```

### What You're Looking For

**Progress by Category section:**
- Which category is current focus?
- How many features complete in that category?

**Feature Adoption Timeline:**
- Recent completions (last 3-5 features)
- Time taken vs. estimated
- Notes about implementation

**Session Notes (most recent):**
- What was worked on last session?
- How long did it take?
- What challenges occurred?
- What's the next step?

**Lessons Learned:**
- Patterns to reuse
- Mistakes to avoid
- Time estimation patterns

### Common Issues

**Issue 1: No progress.md exists**

**Detection:** File not found.
**Response:** "No progress.md found. I'll create one after completing the first feature."

**Issue 2: Stale progress.md (lastUpdated > features.json)**

**Detection:** progress.md hasn't been updated in weeks, but features.json shows recent activity.
**Response:** "progress.md is stale. I'll update it based on features.json status."

---

## Step 3: Run git status (Uncommitted Changes?)

### Purpose

Detect incomplete work from interrupted sessions to help user decide: complete, stash, or discard.

### Command

```bash
git status
```

### Possible States

#### ✅ State 1: Clean Working Tree

```
On branch main
nothing to commit, working tree clean
```

**Interpretation:** Last session ended cleanly (feature completed and committed).
**Action:** Proceed to Step 4.
**Confidence:** High (0.95)

---

#### ⚠️ State 2: Uncommitted Changes

```
Changes not staged for commit:
  modified: src/orders/OrderHistoryPage.js
  modified: src/orders/OrderItem.js
  new file: tests/orders/OrderHistoryPage.test.js
```

**Interpretation:** Last session was interrupted mid-feature.
**Action:** Ask user what to do with uncommitted changes.

**Decision prompt:**
```markdown
## ⚠️ Uncommitted Changes Detected

I see uncommitted changes in 3 files related to orders.

These appear to be for **feat-009 (Order History Page)**.

Should I:
1. **Complete this feature** (continue where you left off)
2. **Stash changes** (work on different feature, come back later)
3. **Discard changes** (start fresh)
```

**If Option 1 (complete):**
- Check features.json for feat-009 status and adoption.percentageComplete
- Resume from that percentage
- Review uncommitted code to understand what's done
- Complete remaining work

**If Option 2 (stash):**
```bash
git stash push -m "WIP: feat-009 Order History Page"
```
- Proceed to select different feature
- User can restore with `git stash pop` later

**If Option 3 (discard):**
```bash
git restore .
```
- Warn: "This will permanently delete uncommitted work."
- Require explicit confirmation

**Confidence:** Medium (0.70) - needs user input to resolve

---

#### ❌ State 3: Merge Conflicts

```
Unmerged paths:
  both modified: src/auth/LoginForm.js
  both modified: src/services/AuthService.js
```

**Interpretation:** User is in middle of resolving a merge.
**Action:** Block execution until conflicts resolved.

**Response:**
```markdown
## ❌ Git Merge Conflicts Detected

**Conflicted files:**
- src/auth/LoginForm.js
- src/services/AuthService.js

**Can't proceed** until conflicts are resolved.

**Resolution steps:**
1. Open conflicted files in your editor
2. Find conflict markers (<<<<<<< HEAD)
3. Choose version or merge manually
4. Remove conflict markers
5. Stage resolved files: `git add <files>`
6. Complete merge: `git commit`

**After resolution:**
Re-run bootup ritual (I'll detect clean state and proceed).
```

**Confidence:** Low (0.30) - cannot proceed

---

### What to Check

**1. Modified files:**
- How many files changed?
- Which feature do they belong to?
- Is this expected or accidental?

**2. New files:**
- Tests created but not committed?
- New components or services?

**3. Deleted files:**
- Refactoring in progress?
- Accidental deletion?

**4. Staging area:**
```bash
git diff --cached  # Shows staged changes
```

If staged changes exist, ask:
```markdown
## Staged Changes Detected

You have staged changes ready to commit.

Should I:
1. **Commit now** (complete the commit)
2. **Unstage** (move back to working directory)
```

### Common Issues

**Issue 1: Large uncommitted diff (50+ files)**

**Detection:** `git diff --stat` shows many changed files.
**Response:** "Large uncommitted changeset detected. This is risky. Consider committing in smaller atomic batches."

**Issue 2: Uncommitted changes don't match any feature**

**Detection:** Changed files don't align with any in-progress feature in features.json.
**Response:** Ask user: "These changes don't match any feature in features.json. Are these experimental? Should I create a new feature for this work?"

---

## Step 4: Run tests (System Healthy?)

### Purpose

Validate current codebase state before adding new code. Don't build on broken foundation.

### Detect Test Framework

```bash
# Node.js project
if [ -f "package.json" ]; then
  npm test
fi

# Python project
if [ -f "pytest.ini" ] || [ -d "tests/" ]; then
  pytest
fi

# Ruby project
if [ -f "Gemfile" ] && grep -q "rspec" Gemfile; then
  rspec
fi

# Go project
if [ -f "go.mod" ]; then
  go test ./...
fi

# Rust project
if [ -f "Cargo.toml" ]; then
  cargo test
fi
```

### Possible States

#### ✅ State 1: All Tests Passing

```
Tests: 42 passed, 42 total
Time: 3.2s
```

**Interpretation:** System is healthy, safe to add new code.
**Action:** Proceed to Step 5.
**Confidence:** High (0.95)

---

#### ⚠️ State 2: Some Tests Failing

```
Tests: 38 passed, 4 failed, 42 total

FAIL src/auth/login.test.js
  ✓ should render login form
  ✗ should reject invalid credentials

FAIL src/cart/cart.test.js
  ✓ should add item to cart
  ✗ should apply discount code
```

**Interpretation:** Broken features detected.
**Action:** Ask user what to do.

**Decision prompt:**
```markdown
## ⚠️ Failing Tests Detected

**Status:** 4 tests failing

**Failed tests:**
- src/auth/login.test.js (invalid credentials handling)
- src/cart/cart.test.js (discount code application)
- [2 more...]

**Should I:**

1. **Fix failing tests first** (recommended if recent failures)
   - Failing tests indicate broken features
   - Don't build on broken foundation

2. **Document as pre-existing** (if these were already failing)
   - Mark failures in progress.md
   - Continue with new feature
   - Fix failures later as separate task

**Which option?**
```

**If Option 1 (fix first):**
- Create virtual "feat-XXX: Fix failing tests" task
- Prioritize over new features
- Debug each failing test
- Don't proceed until all tests pass

**If Option 2 (document and defer):**
- Add to progress.md Known Issues section:
  ```markdown
  ## Known Issues
  - 4 failing tests (pre-existing, documented 2025-12-17)
    - auth/login.test.js: invalid credentials
    - cart/cart.test.js: discount code
  - Will address in separate bug-fix session
  ```
- Proceed with new feature (but monitor for regressions)

**Confidence:** Medium (0.60) - proceed with caution

---

#### ❌ State 3: No Tests Found

```
No test framework detected
```

**Interpretation:** Project has no test infrastructure.
**Action:** Note in bootup summary, proceed with feature development.

**Response:**
```markdown
## ❌ No Tests Detected

No test framework found in this project.

**Recommendation:** Add tests as you build features to ensure quality.

**I'll:**
- Create tests for each feature's testCriteria
- Use appropriate framework for your tech stack
- Build test infrastructure incrementally
```

**Confidence:** Medium (0.70) - can proceed but with caution

---

### What to Check

**1. Test count:**
- How many tests total?
- How many passing vs. failing?
- Is coverage increasing or decreasing?

**2. Failed test patterns:**
- All failures in one module? (localized issue)
- Failures across multiple modules? (systemic problem)
- Timeouts vs. assertion failures?

**3. Test output:**
- Error messages
- Stack traces
- Which test criteria are failing?

**4. Performance:**
- Test suite duration
- Slow tests (> 1 second per test)

### Common Issues

**Issue 1: Tests hanging (timeout)**

**Detection:** Test command runs > 30 seconds without output.
**Response:** Kill test process, suggest:
- Check for infinite loops
- Increase timeout
- Run subset of tests

**Issue 2: Flaky tests (pass/fail randomly)**

**Detection:** Same test fails on some runs, passes on others.
**Response:** Document as known issue, suggest:
- Isolate test (run solo)
- Check for timing dependencies
- Fix race conditions

---

## Step 5: Identify Next Atomic Feature (What's Next?)

### Purpose

Pick ONE feature to work on this session based on dependencies, complexity, and learning path.

### Selection Criteria

#### 1. Status Filter

**Must be:** status: "available" (not in-progress or completed)

#### 2. Prerequisite Check

**All features in learningPath must be** status: "completed"

Example:
```json
{
  "id": "feat-007",
  "learningPath": ["feat-004", "feat-005"],
  "status": "available"
}
```

Only suggest feat-007 if BOTH feat-004 AND feat-005 are completed.

#### 3. Complexity Consideration

Match complexity to session length:

- **Beginner (1-3 hours):** Good for first session or end of day
- **Intermediate (3-8 hours):** Good for full work session
- **Advanced (8+ hours):** May span multiple sessions, break into sub-tasks

#### 4. Risk Assessment

- **Low risk:** Isolated feature, no architectural changes
- **Medium risk:** Touches multiple files, some integration points
- **High risk:** Core system changes, potential breaking changes

### Selection Algorithm

```
1. Filter features:
   - status = "available"
   - All prerequisites complete

2. Sort by priority:
   - Features in current category focus (continue category)
   - Features with most dependents (unlock other features)
   - Beginner → Intermediate → Advanced (progressive difficulty)

3. Match to session context:
   - Short session (< 2 hours)? → Beginner feature
   - Full session (4+ hours)? → Intermediate feature
   - Multi-session available? → Advanced feature (break into sub-tasks)

4. Pick FIRST feature that matches
```

### Confidence Scoring

Estimate confidence in selecting the right feature:

- 🟢 **High (0.85-1.0):** Clear next feature, prerequisites met, appropriate for session
  - Example: feat-002 after completing feat-001 (login → registration)

- 🟡 **Medium (0.60-0.84):** Multiple viable options, user input helpful
  - Example: 3 features available, different categories, ask user preference

- 🔴 **Low (0.0-0.59):** No available features (all blocked by prerequisites)
  - Example: Circular dependencies or missing prerequisites

### Output Format

```markdown
### 🎯 Next Feature Recommendation

**feat-XXX: [Feature Name]** (🟢 0.XX confidence)

**Why This Feature:**
- [Dependency logic: prerequisites met]
- [Learning path: builds on previous work]
- [Business value: user impact]
- **Quick win:** [What user will see after completing this]

**Approach:**
1. [Step 1]
2. [Step 2]
3. [Step 3]
4. Test criteria: [From features.json]

**Estimated Time:** [From features.json]
**Complexity:** [Beginner/Intermediate/Advanced]

**Resources:**
- [Link 1 from features.json]
- [Link 2 from features.json]

---

**Ready to begin?** I'll build this feature incrementally with tests.
```

### Common Scenarios

#### Scenario 1: One clear next feature

**Situation:** Only one feature has prerequisites met.
**Confidence:** 🟢 High (0.95)
**Action:** Suggest that feature, proceed if user confirms.

#### Scenario 2: Multiple options in same category

**Situation:** 3 features available in Authentication category.
**Confidence:** 🟡 Medium (0.75)
**Action:** Suggest feature with most dependents (unlocks other features), mention alternatives.

Example:
```markdown
**Recommended:** feat-003 (Password Reset)
- Unlocks feat-004 (Email Verification)
- Unlocks feat-005 (Two-Factor Auth)

**Alternatives:**
- feat-006 (User Profile) - different category, independent
```

#### Scenario 3: Category complete, move to next

**Situation:** All features in current category complete.
**Confidence:** 🟢 High (0.90)
**Action:** Celebrate category completion, suggest first feature in next category.

#### Scenario 4: No available features (all blocked)

**Situation:** All remaining features have incomplete prerequisites.
**Confidence:** 🔴 Low (0.30)
**Action:** Alert user, suggest reviewing learningPath for circular dependencies.

---

## Bootup Summary Output

After completing all 5 steps, present this summary:

```markdown
## 🔄 Bootup Ritual Complete

**Project:** [Name from features.json]
**Last Session:** [Date from progress.md] ([X] days ago)

---

### 📊 Status Overview

- **Total Features:** X
- **Completed:** Y (Z%)
- **In Progress:** [feat-ID: Name] (if any)
- **Remaining:** N

**Current Focus:** [Category name]

---

### 🛠️ System Health

- **Git Status:** [✅ Clean / ⚠️ Uncommitted / ❌ Conflicts]
- **Tests:** [✅ X passing / ⚠️ Y failing / ❌ No tests]

**Action Needed (if any):**
- [Uncommitted changes detected: complete, stash, or discard?]
- [4 tests failing: fix first or document as pre-existing?]
- [Merge conflicts: resolve before proceeding]

---

### 🎯 Next Feature Recommendation

[Output from Step 5]

---

**Session start time:** [Current timestamp]
**Context recovery:** Complete (10-15 seconds)
```

---

## Variations & Edge Cases

### Variation 1: First Session (New Project)

**Context:** No features completed yet, pristine state.

**Bootup output:**
```markdown
## 🔄 Bootup Ritual Complete (First Session!)

**Project:** [Name]
**Status:** New project, no features completed yet

### 🎯 First Feature

**feat-001: [Name]** (🟢 0.95 confidence)

**Why start here:**
- No prerequisites (good entry point)
- Foundational (other features depend on this)
- **Quick win:** See working feature in [X] hours

**Let's build momentum with the first feature!**
```

### Variation 2: Returning After Long Break (> 7 days)

**Context:** User hasn't worked on project in weeks.

**Bootup output:**
```markdown
## 🔄 Bootup Ritual Complete

**Welcome back!** It's been 14 days since your last session.

**Here's where you left off:**
- Last feature completed: feat-005 (Two-Factor Auth) on 2025-12-01
- Authentication category: 100% complete (5/5 features)
- Next category: Dashboard (0/3 features)

**System health:**
- Git: Clean ✅
- Tests: 24 passing ✅

**Recommended:** Start with feat-006 (Dashboard Layout) - fresh category, beginner complexity.
```

### Variation 3: Mid-Feature Interruption

**Context:** User has uncommitted changes for feat-009 at 60% complete.

**Bootup output:**
```markdown
## 🔄 Bootup Ritual Complete

**Interrupted session detected:**
- feat-009 (Order History Page): 60% complete
- Last updated: 2025-12-16 18:00 (yesterday)
- Uncommitted changes: 3 files

**Resume from 60%?**
- Already done: OrderHistoryPage component, API integration
- Remaining: 2 tests incomplete

**I can continue where you left off!**
```

### Variation 4: All Features Complete (Project Done!)

**Context:** 100% of features completed.

**Bootup output:**
```markdown
## 🎉 Project Complete!

**Congratulations!** All 22 features completed.

**Project stats:**
- Total time: 85 hours (estimated: 90 hours)
- Categories: 5/5 complete
- Tests: 156 passing

**What's next:**
- Deploy to production?
- Add new features (create features.json v2)?
- Start new project?
```

---

## Best Practices

### DO: Run bootup ritual at EVERY session start

**Why:**
- Guarantees context recovery
- Catches uncommitted work
- Detects broken tests early
- Suggests optimal next feature

**Even if:**
- Session is "just 10 minutes"
- You "remember where you were"
- You worked on project yesterday

**The ritual is fast (10-15 seconds)** and prevents costly context loss.

### DO: Trust the files over memory

**features.json and progress.md are source of truth**, not human memory.

**Example:**
- You remember completing feat-004
- features.json says feat-004 is "in-progress"
- **Trust features.json** - probably incomplete or tests failing

### DO: Update files immediately after changes

**When to update:**
- **features.json:** After completing a feature (status → "completed")
- **progress.md:** After every session (session notes, lessons learned)
- **Git:** Commit after every completed feature

**Don't defer updates** - you'll forget details.

### DON'T: Skip steps

**All 5 steps are critical:**
- Step 1: features.json = plan
- Step 2: progress.md = history
- Step 3: git status = current state
- Step 4: tests = system health
- Step 5: next feature = direction

**Skipping even one step** can lead to:
- Building wrong feature
- Building on broken code
- Losing uncommitted work
- Context confusion

### DON'T: Manually override feature selection

**Let the algorithm select** based on:
- Dependencies (prerequisites)
- Complexity (match session length)
- Category progression (logical flow)

**Only override if:**
- User explicitly requests different feature
- Algorithm makes clearly wrong suggestion
- Special circumstances (demo, learning specific tech)

**When overriding:**
- Explain prerequisite concerns
- Flag potential blockers
- Get user confirmation

---

## Troubleshooting

### Problem: Bootup takes > 30 seconds

**Causes:**
- Large features.json (100+ features)
- Large progress.md (6+ months of notes)
- Slow test suite (> 30 seconds)

**Solutions:**
- **features.json:** Archive completed categories to separate file
- **progress.md:** Archive old sessions (keep last 30 days)
- **Tests:** Run subset during bootup (`npm test -- --bail` to stop on first failure)

### Problem: Bootup suggests wrong feature

**Causes:**
- Stale learningPath (prerequisites changed)
- Incorrect status (marked "completed" but actually incomplete)
- User wants to work on different category

**Solutions:**
- Review features.json learningPath arrays
- Verify status matches reality (run tests for "completed" features)
- User can override - just explain why algorithm suggested different feature

### Problem: Confidence always low (< 0.60)

**Causes:**
- Circular dependencies in learningPath
- All features blocked by incomplete prerequisites
- features.json hasn't been updated (stale)

**Solutions:**
- Review features.json for circular dependencies (visualize with diagram)
- Check if some "in-progress" features should be "completed"
- Update lastUpdated timestamp if features.json is current

---

## Integration with v3.5.0 Intelligence

### Confidence Scores

Every bootup step produces a confidence score:

- **Step 1:** Confidence in understanding project (features.json quality)
- **Step 2:** Confidence in history accuracy (progress.md freshness)
- **Step 3:** Confidence in system state (git clean vs. conflicts)
- **Step 4:** Confidence in system health (tests passing vs. failing)
- **Step 5:** Confidence in feature selection (clear next vs. ambiguous)

**Overall bootup confidence = minimum of all 5 steps**

Example:
- Step 1: 0.95 (features.json valid)
- Step 2: 0.90 (progress.md fresh)
- Step 3: 0.70 (uncommitted changes)
- Step 4: 0.95 (tests passing)
- Step 5: 0.88 (clear next feature)

**Overall: 0.70** (limited by Step 3 uncommitted changes)

### Rationale Provision

Every suggestion includes "Why This Matters":

**Example (Step 5 - feature selection):**
```markdown
**Why This Feature (feat-002: Registration):**
- **Dependencies:** Login (feat-001) complete ✅
- **Learning path:** Registration reuses login patterns you just learned
- **Business value:** Users can't log in without accounts
- **Quick win:** Registration form similar to login = 2-3 hours
- **Next:** After registration, you can build feat-003 (Password Reset) or move to different category
```

### JIT Cheat Sheet Linking

Link to relevant skill cheat sheets based on bootup findings:

**Example (Step 4 - failing tests):**
```markdown
## ⚠️ Failing Tests: Auth Module

**For debugging authentication errors, see:**
`.claude/skills/api-debugging/CHEAT_SHEET.md`

**Covers:**
- HTTP 401 vs 403 distinction
- Token handling patterns
- Common auth errors
```

---

## Measuring Success

### Token Savings

**Without bootup ritual:**
- User asks: "Where were we? What's done? What's next?"
- Claude explores: reads multiple files, runs commands, analyzes
- **Cost:** 800-1,500 tokens per session

**With bootup ritual:**
- Automated: reads 2 files (features.json, progress.md), runs 2 commands (git status, tests)
- **Cost:** 100-200 tokens per session
- **Savings:** 85-90% (600-1,300 tokens saved)

**Annual savings (52 sessions/year):**
- Before: ~52,000 tokens/year
- After: ~7,800 tokens/year
- **Saved: ~44,200 tokens/year per project**

### Time Savings

**Without bootup ritual:**
- 5-10 minutes manual regrounding
- Reading files, checking status, remembering context

**With bootup ritual:**
- 10-15 seconds automated context recovery
- Instant project state awareness

**Savings: 5-10 minutes per session**

### Mental Load Reduction

**Without bootup ritual:**
- Remember: What features are done? What's next? Where were we?
- Cognitive load: 7/10

**With bootup ritual:**
- Remember: Nothing (files remember for you)
- Cognitive load: 2/10

**Mental load reduction: 71%**

---

## Further Reading

- **Coder Agent Documentation:** `.claude/agents/coder.md` (see Bootup Ritual section)
- **features.json Template:** `templates/features.json.template`
- **progress.md Template:** `templates/progress.md.template`
- **Domain Memory Architecture:** `CLAUDE.md` (v3.6.0 section)

---

**Remember:** The bootup ritual is not optional. It's the **core discipline** that makes long-running projects sustainable with LLMs. Run it every session, trust the files, and watch your project completion rate soar.
