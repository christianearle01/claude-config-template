---
name: project-analyzer
description: Zero-config project intelligence analyzing features.json and progress.md to provide status summaries, identify blockers, and suggest next actions with confidence scores.
allowed-tools: Read, Grep, Bash
---

# Project Analyzer Skill

**Purpose:** Provide instant project intelligence by analyzing features.json and progress.md without requiring manual exploration.

**When to use:**
- User asks "where are we?" or "what's the status?"
- User asks "what's blocking us?" or "why can't we proceed?"
- User wants category-level analysis
- Need quick project overview without running full bootup ritual

**Confidence-based responses:** Each analysis includes 0.0-1.0 confidence score.

---

## Operation 1: Project Status Summary

**User Queries:**
- "What's our project status?"
- "Give me a summary of where we are"
- "How much progress have we made?"
- "What's the overall state?"

### Confidence Scoring

- 🟢 **High (0.85-1.0):** features.json and progress.md both exist, recently updated (< 7 days), status values consistent
- 🟡 **Medium (0.60-0.84):** Files exist but one is stale (> 7 days old), or minor inconsistencies
- 🔴 **Low (0.0-0.59):** Missing files, corrupted data, or major inconsistencies between files

### Analysis Steps

1. **Read features.json:**
   - Extract: totalFeatures, completedFeatures, projectInfo.name
   - Calculate: completion percentage
   - Identify: in-progress features (status="in-progress")

2. **Read progress.md:**
   - Extract: lastUpdated timestamp
   - Extract: recent session notes
   - Extract: current category focus

3. **Cross-check consistency:**
   - Do completed counts match between files?
   - Are in-progress features listed in both?

### Response Template

```markdown
## 📊 Project Status: [Project Name]

**Overall Progress:** X/Y features complete (Z%)

**Confidence:** 🟢 High (0.92)
- features.json: Valid, updated 2 days ago
- progress.md: Fresh session notes from yesterday
- Status consistent across files

**Breakdown by Category:**
- ✅ Authentication (5/5, 100%) - Complete
- 🟡 Dashboard (2/5, 40%) - In progress
- ⭕ Products (0/8, 0%) - Not started
- ⭕ Cart & Checkout (0/6, 0%) - Not started

**Current Focus:** Dashboard category
- feat-006: Dashboard Layout ✅ Complete
- feat-007: User Profile Widget ✅ Complete
- feat-008: Activity Feed 🟡 In progress (65% complete)

**System Health:**
- **Tests:** 24 passing ✅
- **Git:** Clean working tree ✅
- **Last session:** 1 day ago

**Next Milestone:** Complete Dashboard category (1 feature remaining)
**Estimated time to milestone:** 2-3 hours

---

**Why This Matters:**
- You're 40% through the project with steady momentum
- Current category is 80% complete - finish Activity Feed for quick category win
- After Dashboard, Products category is ready (no blockers)
```

### Example Scenarios

**Scenario 1: New project (0% complete)**

```markdown
## 📊 Project Status: E-Commerce Platform

**Overall Progress:** 0/22 features complete (0%)

**Confidence:** 🟢 High (0.95)
- features.json: Valid, just created
- progress.md: Fresh template
- Ready to start

**Breakdown by Category:**
- ⭕ Authentication (0/5) - Ready to start
- ⭕ Dashboard (0/5) - Blocked (needs auth)
- ⭕ Products (0/8) - Blocked (needs auth)

**First Feature:** feat-001 (User Login)
- No prerequisites ✅
- Beginner complexity
- 2-3 hour estimate
- **Quick win:** Working auth in first session!

---

**Why This Matters:**
- Starting with authentication unlocks 80% of other features
- First feature is beginner-level = confidence builder
- Clear path forward = no decision paralysis
```

**Scenario 2: Mid-project with stale data**

```markdown
## 📊 Project Status: E-Commerce Platform

**Overall Progress:** 12/22 features complete (55%)

**Confidence:** 🟡 Medium (0.65)
- features.json: Valid but stale (last updated 14 days ago)
- progress.md: Last session 2 weeks ago
- ⚠️ May have uncommitted work or forgotten progress

**Recommendation:** Run bootup ritual to verify current state
- Check git status for uncommitted changes
- Verify test suite still passes
- Confirm which features are truly complete

**If status is accurate:**
- Good progress (55% complete)
- 3 categories done, 2 remaining
- 10 features left (estimated 25-30 hours)
```

---

## Operation 2: Blocker Identification

**User Queries:**
- "What's blocking us?"
- "Why can't we proceed?"
- "What features are stuck?"
- "Are there any circular dependencies?"

### Confidence Scoring

- 🟢 **High (0.85-1.0):** Clear blocker identified with specific cause
- 🟡 **Medium (0.60-0.84):** Potential blocker but needs verification
- 🔴 **Low (0.0-0.59):** No obvious blockers OR multiple complex issues

### Analysis Steps

1. **Check for in-progress features:**
   - Any features stuck at < 100% for > 7 days?
   - Any features in-progress without recent session notes?

2. **Analyze learningPath dependencies:**
   - Map all prerequisite relationships
   - Detect circular dependencies
   - Find features with incomplete prerequisites

3. **Check test status:**
   - Failing tests blocking new work?
   - Missing test infrastructure?

4. **Check git status:**
   - Merge conflicts?
   - Large uncommitted changeset?

### Response Template

```markdown
## 🚧 Blocker Analysis

**Confidence:** 🟢 High (0.88)
- Clear blocker identified with specific resolution

**Blocker Type:** Dependency Chain Break

**Issue:**
feat-015 (Real-Time WebSocket Sync) depends on:
- feat-007 (Shopping Cart) ✅ Complete
- feat-011 (Checkout Page) ❌ Not started

**Impact:**
- feat-015 cannot proceed (advanced feature blocked)
- feat-016, feat-017 also depend on feat-015 (cascade effect)
- 3 features blocked total

**Resolution:**
1. Complete feat-011 (Checkout Page) first
   - Estimated time: 5-7 hours
   - Intermediate complexity
   - Unblocks 3 downstream features

2. Then proceed to feat-015 (WebSocket Sync)

---

**Why This Matters:**
- feat-011 is the **critical path** - unlocks 3 features
- Completing it creates momentum (3 features become available)
- Prioritize unblocking over new features in different category
```

### Example Scenarios

**Scenario 1: Circular dependency**

```markdown
## 🚧 Blocker Analysis

**Confidence:** 🟢 High (0.95)
- Circular dependency detected

**Issue:** Circular Dependency Loop

**Affected features:**
- feat-009 depends on feat-010
- feat-010 depends on feat-009

**Result:** Both features stuck, cannot proceed

**Resolution:**
1. Review feature designs - are dependencies accurate?
2. Options:
   - **Break dependency:** One feature doesn't actually need the other
   - **Merge features:** Combine into single larger feature
   - **Create intermediary:** Add feat-009a that both depend on

**Recommended:** Break dependency
- feat-009 (Order History) doesn't need feat-010 (Invoice Generation)
- Remove feat-010 from feat-009's learningPath

---

**Why This Matters:**
- Circular dependencies = project paralysis
- Must be resolved before ANY progress possible
- Quick fix (remove one dependency) unblocks both features
```

**Scenario 2: No blockers (ready to proceed)**

```markdown
## ✅ No Blockers Detected

**Confidence:** 🟢 High (0.92)
- All systems clear, ready to proceed

**Status:**
- ✅ No circular dependencies
- ✅ Multiple features available (3 options)
- ✅ Tests passing
- ✅ Git clean

**Available features:**
1. feat-012 (Product Search) - Intermediate, 4-6 hours
2. feat-013 (Product Filters) - Beginner, 2-3 hours
3. feat-014 (Product Reviews) - Intermediate, 5-7 hours

**Recommendation:** Start with feat-013 (Product Filters)
- Beginner complexity = quick win
- Unblocks feat-015 (has feat-013 as prerequisite)
- 2-3 hours = can complete in single session

---

**Why This Matters:**
- No blockers = choose based on strategy (quick wins vs. high value)
- feat-013 is optimal: easy + unlocks other feature
- Build momentum before tackling harder features
```

**Scenario 3: Failing tests blocker**

```markdown
## 🚧 Blocker Analysis

**Confidence:** 🟢 High (0.90)
- Test failures blocking new development

**Issue:** 5 Failing Tests

**Affected modules:**
- auth/login.test.js (2 failures)
- cart/cart.test.js (3 failures)

**Impact:**
- Can't add new features on broken foundation
- Tests failing for 3 days (not pre-existing)
- High risk of compounding errors

**Resolution:**
1. **Immediate:** Fix failing tests (priority over new features)
2. **Estimated time:** 2-4 hours debugging
3. **Create virtual task:** "feat-XXX: Fix failing tests"

**Root cause (if known from progress.md):**
- Recent refactor broke authentication flow
- Cart discount logic regression

---

**Why This Matters:**
- Building on broken code = technical debt spiral
- Fix foundation before adding features
- 2-4 hours now saves 10+ hours later
```

---

## Operation 3: Category Analysis & Recommendation

**User Queries:**
- "Which category should I focus on?"
- "What's the best category to work on next?"
- "Should I finish current category or switch?"
- "Category status breakdown?"

### Confidence Scoring

- 🟢 **High (0.85-1.0):** Clear category recommendation based on dependencies and progress
- 🟡 **Medium (0.60-0.84):** Multiple valid options, user preference helpful
- 🔴 **Low (0.0-0.59):** No clear direction, needs more context

### Analysis Steps

1. **Calculate category completion:**
   - For each category: completed / total features
   - Sort by completion percentage

2. **Analyze category dependencies:**
   - Which categories unlock others?
   - Which are independent?

3. **Check current category status:**
   - How close to completion? (% done)
   - How many features remaining?
   - Estimated time to finish?

4. **Evaluate switching cost:**
   - Switching mid-category = context loss
   - Finishing current = category milestone = motivation boost

### Response Template

```markdown
## 📂 Category Analysis

**Confidence:** 🟢 High (0.88)
- Clear recommendation based on progress and dependencies

**Current Category:** Dashboard (4/5 features, 80% complete)

**Recommendation:** ✅ Finish Dashboard Category

**Rationale:**
- **80% complete** - only 1 feature remaining (feat-008: Activity Feed)
- **Estimated time:** 2-3 hours to category completion
- **Quick win:** Celebrate milestone, build momentum
- **Switching cost:** High - would lose context built over 4 features

**After Dashboard:**
Recommended next category: **Products** (0/8 features)

**Why Products next:**
- **Dependency satisfied:** Dashboard complete (Products depends on auth + dashboard)
- **High business value:** E-commerce core functionality
- **8 features:** Substantial category, 20-25 hours estimated
- **Independent work:** Can complete without blocking other categories

**Alternative:** Testing Infrastructure (if you want variety)
- **2 features:** Quick category
- **5-7 hours total**
- **High value:** Improves all future development

---

**Why This Matters:**
- Finishing Dashboard now = milestone dopamine hit
- Context preservation (stay in dashboard mindset)
- Products category is ready (no blockers, clear path)
- Momentum > variety (finish what you started)
```

### Example Scenarios

**Scenario 1: Should switch categories (current blocked)**

```markdown
## 📂 Category Analysis

**Confidence:** 🟢 High (0.85)
- Current category blocked, switch recommended

**Current Category:** Dashboard (2/5 features, 40% complete)

**Issue:** Next 3 features all depend on feat-010 (Analytics API)
- feat-010 is blocked (external API not ready)
- ETA for unblock: 2 weeks

**Recommendation:** ✅ Switch to Products Category

**Rationale:**
- **Current category blocked** - can't proceed for 2 weeks
- **Products category ready:** 0/8 features, no blockers
- **Independent work:** Doesn't depend on Analytics API
- **High value:** E-commerce core features

**Switch cost:** Low
- Only 2 features in Dashboard (can resume later)
- Products is separate domain (different codebase area)

**Return plan:**
- Complete Products category (20-25 hours)
- Return to Dashboard when Analytics API ready
- Finish remaining 3 Dashboard features

---

**Why This Matters:**
- Don't let blockers kill momentum
- Products work is valuable and unblocked
- Can resume Dashboard later without penalty
- Parallelized progress (external API + Products dev)
```

**Scenario 2: Multiple categories ready (user choice needed)**

```markdown
## 📂 Category Analysis

**Confidence:** 🟡 Medium (0.70)
- Multiple valid options, user preference helpful

**Current Status:** Authentication complete (100%)

**3 Categories Ready:**

**1. Dashboard (0/3 features, 8-10 hours)**
- **Pros:** Quick category, builds on auth patterns
- **Cons:** Lower business value (internal tool)
- **Complexity:** Beginner → Intermediate

**2. Products (0/8 features, 20-25 hours)**
- **Pros:** High business value, core e-commerce
- **Cons:** Substantial category, longer commitment
- **Complexity:** Beginner → Advanced

**3. Testing Infrastructure (0/2 features, 5-7 hours)**
- **Pros:** Improves all future work, prevents bugs
- **Cons:** Not user-facing, less tangible progress
- **Complexity:** Intermediate

**Recommendation:** Products (if you have time) OR Dashboard (if you want quick win)

**Decision factors:**
- **Time available:** Full commitment? → Products. Limited time? → Dashboard.
- **Motivation:** Need quick win? → Dashboard. Sustained effort? → Products.
- **Business priority:** Revenue-critical? → Products. Internal tools? → Dashboard.

---

**Why This Matters:**
- All 3 are valid choices (no wrong answer)
- Different strategies: quick wins vs. high value vs. foundation
- Your context (time, motivation, priorities) should guide choice
```

---

## Skill Metadata

**Token Efficiency:**
- Traditional exploration: ~1,200 tokens (manual file reads, analysis)
- With this skill: ~400 tokens (pre-compiled expertise)
- **Savings: 67% (800 tokens per query)**

**Use Cases:**
1. **Daily standups:** "What's our status?" (Operation 1)
2. **Sprint planning:** "What should we focus on?" (Operation 3)
3. **Troubleshooting:** "Why are we stuck?" (Operation 2)
4. **Onboarding:** "Help new team member understand project state" (Operation 1)

**Complementary Skills:**
- **testing-workflow:** If Operation 2 finds failing tests
- **api-debugging:** If Operation 2 finds API-related blockers
- **component-finder:** If working on UI categories

**Confidence Philosophy:**
- 🟢 High: Actionable recommendation with clear path
- 🟡 Medium: Multiple options, user input helpful
- 🔴 Low: Need more context or manual investigation

---

## Example Integration (Coder Agent)

When Coder Agent encounters ambiguity, it can invoke this skill:

**User:** "What should I work on?"

**Coder Agent (internal):**
```
Confidence in next feature selection: 0.55 (medium-low)
- Multiple categories ready
- User hasn't expressed preference
- Would benefit from project-level analysis

→ Invoke project-analyzer skill (Operation 3: Category Analysis)
```

**project-analyzer returns:**
"Finish Dashboard category (80% complete, 1 feature remaining)"

**Coder Agent (to user):**
```markdown
Based on project analysis, I recommend finishing the Dashboard category:
- 80% complete (only feat-008 remaining)
- 2-3 hours to category milestone
- High momentum value

After Dashboard, Products category is ready to start.

Proceed with feat-008 (Activity Feed)?
```

---

**Remember:** This skill provides **analysis, not execution**. It informs decisions but doesn't build features. Use Coder Agent to execute recommended features.
