# Workflow Example: Refactoring

**Scenario:** Extract duplicate authentication logic across 5 components
**Complexity:** Medium (architectural decision with multiple valid approaches)
**Time:** 45 minutes
**Tokens used:** ~5,200 tokens

---

## Initial State

**Problem report:**
```
Code review feedback: "We have duplicate auth checking logic
in Header.tsx, Sidebar.tsx, Dashboard.tsx, Settings.tsx, and Profile.tsx.
This should be extracted to a shared utility."
```

**What we know:**
- Duplicate code exists in 5 files
- Need to extract to shared location
- Should improve maintainability

**What we don't know:**
- Exact pattern of duplication
- Best extraction approach
- Where to put the shared code
- Whether it's a simple function or needs more structure

---

## Decision Point 1: Understand Before Acting

**Options considered:**
1. **Grep for "auth"** - Fast but may miss context
2. **Read all 5 files directly** - Thorough but token-heavy
3. **Explore agent** - Systematic understanding of auth patterns

**Decision:** Use **Explore agent** (Option 3)

**Reasoning:**
- Need to understand the pattern, not just find it
- Don't know which files have relevant code yet
- Want to discover if there are OTHER places with duplication
- 5 files is enough to warrant systematic exploration

**Tool used:**
```bash
@explore Find all authentication checking logic in components.
Identify patterns and duplication.
```

**Explore agent findings:**
```
Authentication Pattern Discovery:

Found 7 locations (not just 5!):
1. src/components/Header.tsx (lines 34-52)
2. src/components/Sidebar.tsx (lines 18-36)
3. src/pages/Dashboard.tsx (lines 67-85)
4. src/pages/Settings.tsx (lines 23-41)
5. src/pages/Profile.tsx (lines 89-107)
6. src/pages/Admin.tsx (lines 45-63) ← NEW!
7. src/hooks/useAuth.ts (lines 12-20) ← Partial extraction exists!

Common Pattern:
```typescript
const user = useUser();
const navigate = useNavigate();

useEffect(() => {
  if (!user) {
    navigate('/login');
    return;
  }
  if (!user.emailVerified) {
    navigate('/verify-email');
    return;
  }
  if (user.role !== 'admin' && requiresAdmin) {
    navigate('/forbidden');
    return;
  }
}, [user, navigate, requiresAdmin]);
```

Key Insight: useAuth.ts already has PART of this logic!
Recommendation: Extend existing hook rather than create new utility.
```

**Tokens:** ~1,500 tokens (Haiku model for exploration)

**Key discovery:** 7 duplications (not 5), and partial solution already exists!

---

## Decision Point 2: Extraction Approach?

**Problem:** Multiple valid ways to refactor this. Which is best?

**Decision:** Use **Adversarial-validator agent** for high-confidence architectural choice

**Reasoning:**
- High-stakes decision (affects 7 files)
- Multiple valid approaches (hook vs HOC vs utility)
- Want confidence in the choice
- Worth extra tokens for better decision

**Tool used:**
```bash
@adversarial-validator

Should I extract duplicate auth logic as:
A) Extended useAuth hook (build on existing)
B) Higher-Order Component (withAuth wrapper)
C) Separate utility function

Context: 7 components have duplicate auth checking.
Partial hook (useAuth.ts) already exists with basic logic.
```

**Adversarial-validator output:**

**Solution A (Optimist):** Extended useAuth Hook
```typescript
// Proposed API:
const { user, isLoading, requireAuth } = useAuth({
  redirectTo: '/login',
  requireVerified: true,
  requireRole: 'admin' // optional
});
```

**Strengths:**
- Builds on existing code (less disruption)
- React-idiomatic (hook pattern)
- Flexible per-component configuration
- Easy to test

**Weaknesses:**
- Every component must call hook explicitly
- Possible to forget to use it
- Slightly more boilerplate

**Confidence:** 🟢 High (88%)

---

**Solution B (Pragmatist):** Higher-Order Component
```typescript
// Proposed API:
export default withAuth(Dashboard, {
  requireVerified: true,
  requireRole: 'admin'
});
```

**Strengths:**
- Enforced at component boundary (can't forget)
- Clean component code (no hooks needed)
- Single source of truth

**Weaknesses:**
- Adds wrapper complexity
- Harder to debug (extra component layer)
- React community moving away from HOCs

**Confidence:** 🟡 Medium (65%)

---

**Solution C (Innovator):** Route-Level Guards
```typescript
// Proposed API:
<Route
  path="/dashboard"
  element={<Dashboard />}
  guard={authGuard({ requireVerified: true })}
/>
```

**Strengths:**
- Centralized (all auth in routes.tsx)
- Component code completely clean
- Framework-level solution

**Weaknesses:**
- Requires routing refactor
- Doesn't help with non-routed components (modals, etc.)
- More complex implementation

**Confidence:** 🟡 Medium (58%)

---

**Adversarial Critique:**

All three solutions solve the duplication problem. Key differentiators:
1. **Disruption:** A = low, B = medium, C = high
2. **Future flexibility:** A = high, B = medium, C = low (tied to routing)
3. **Developer experience:** A = familiar, B = legacy pattern, C = novel

**Winner: Solution A (Extended useAuth Hook)**

**Final confidence:** 🟢 High (88%)

**Rationale:**
- Builds incrementally (extend what exists)
- React community direction (hooks over HOCs)
- Flexible enough for edge cases
- Lowest risk (can always migrate to B or C later)

**Tokens:** ~2,500 tokens (Opus model for multi-perspective analysis)

---

## Decision Point 3: Implement the Refactoring

**Decision:** Direct implementation with Edit tool (approach is clear)

**Implementation steps:**

**Step 1: Extend useAuth hook**
```bash
Read src/hooks/useAuth.ts
```

**Step 2: Add new logic**
```typescript
// Before (partial):
export function useAuth() {
  const user = useUser();
  return { user, isLoading };
}

// After (extended):
export function useAuth(config?: AuthConfig) {
  const user = useUser();
  const navigate = useNavigate();

  useEffect(() => {
    if (!user && config?.redirectTo) {
      navigate(config.redirectTo);
    }
    if (user && config?.requireVerified && !user.emailVerified) {
      navigate('/verify-email');
    }
    if (user && config?.requireRole && user.role !== config.requireRole) {
      navigate('/forbidden');
    }
  }, [user, navigate, config]);

  return { user, isLoading };
}
```

**Step 3: Update all 7 components**
- Replace 19 lines of duplicate logic with 1 hook call in each
- **Total removed:** 133 lines of duplicate code
- **Total added:** 7 hook calls + 25 lines in useAuth.ts

**Tokens:** ~800 tokens (7 Edit operations + 1 Read)

---

## Testing & Validation

**Run tests:**
```bash
npm test -- --coverage src/hooks/useAuth.test.ts
npm test -- src/components/Header.test.tsx
npm test -- src/pages/Dashboard.test.tsx
# ... test all 7 affected files
```

**Result:** All tests passing ✅

**Manual verification:**
- Navigate to /dashboard without login → Redirects to /login ✅
- Navigate to /admin as non-admin → Redirects to /forbidden ✅
- Email unverified user → Redirects to /verify-email ✅

**Tokens:** ~400 tokens (test output)

---

## Final Workflow Summary

```
1. Explore agent (find patterns)       → 1,500 tokens → Found 7 duplications
2. Adversarial-validator (decide)      → 2,500 tokens → Chose extended hook
3. Read useAuth.ts                     →   100 tokens → Understood existing code
4. Edit useAuth.ts + 7 components      →   800 tokens → Implemented refactor
5. Test (verify correctness)           →   400 tokens → Validated changes
6. Git commit                          →   100 tokens → Committed
                                       ─────────────
                                 TOTAL: 5,400 tokens
```

**Time:** 45 minutes
**Code changes:** -133 lines (removed duplicates), +32 lines (shared hook)
**Maintainability:** 7 places → 1 place for auth logic

---

## Alternative Approach (Direct Refactor)

**What if we'd skipped exploration and adversarial validation?**

```
1. Grep "auth" (find locations)        →   200 tokens
2. Read 5 files mentioned              → 1,000 tokens (missed 2!)
3. Guess HOC approach                  →     0 tokens (no validation)
4. Implement HOC solution              → 1,200 tokens
5. Discover it doesn't fit useAuth     →   500 tokens (debugging)
6. Re-read community best practices    →   800 tokens
7. Realize hooks are better            →     0 tokens (regret)
8. Rewrite as hook                     → 1,500 tokens (rework)
9. Fix bugs from hasty implementation  → 1,000 tokens
                                       ─────────────
                                 TOTAL: 6,200 tokens (15% more)
                        MENTAL COST: High (rework frustration)
                         RISK TAKEN: Medium (wrong pattern)
```

**Lesson:** Spending 2,500 tokens on adversarial validation SAVED 800 tokens of rework AND prevented architectural regret.

---

## Alternative Approach (Over-Engineering)

**What if we'd gone with Solution C (Route-Level Guards)?**

```
1. Explore + Adversarial validation    → 4,000 tokens (same)
2. Refactor routing system             → 2,000 tokens
3. Implement route guards              → 1,500 tokens
4. Discover modals need guards too     →   800 tokens
5. Add second guard system for modals  → 1,200 tokens
6. Now maintaining TWO systems         → Ongoing complexity
                                       ─────────────
                                 TOTAL: 9,500 tokens (76% more!)
                    MAINTAINABILITY: Worse (2 systems)
```

**Lesson:** Most flexible solution (A) was also simplest. Adversarial validation prevented over-engineering.

---

## Key Takeaways

### ✅ Good Decisions

1. **Used Explore agent first** - Discovered 7 (not 5) duplications, found existing partial solution
2. **Used Adversarial-validator** - High-confidence architectural decision
3. **Chose incremental approach** - Extended existing hook rather than replace
4. **Tested thoroughly** - Verified all 7 components work correctly

### ❌ Common Mistakes to Avoid

1. **Skipping exploration** - Would miss 2 duplications and existing hook
2. **Guessing architecture** - Would likely choose HOC (outdated pattern)
3. **Not validating decision** - Risk of implementing wrong approach
4. **Over-engineering** - Route guards would add unnecessary complexity

### 🎯 Decision Framework Applied

- **Known vs unknown:** Unknown patterns → Explore first
- **Simple vs complex:** Architectural choice → Adversarial validation
- **Multiple approaches:** 3 valid solutions → Need confidence scoring
- **Model selection:** Haiku for exploration, Opus for decision, Sonnet for implementation

---

## When to Use Adversarial Validation

**Use Adversarial-validator if:**
- Multiple valid architectural approaches exist
- High-stakes decision (affects many files)
- Team needs rationale for the choice
- Want confidence scoring before implementing

**Use Plan agent if:**
- Single obvious approach, just need implementation steps
- No architectural uncertainty

**Use Sequential-thinking if:**
- Complex root cause diagnosis
- Need to reason through multiple factors

**Use Direct implementation if:**
- Approach is obvious
- Low risk
- Easy to change later

---

## Confidence Breakdown

**Why 88% confidence for extended hook?**

```
Optimist Perspective:
✅ Builds on existing code                    (+15%)
✅ React-idiomatic pattern                    (+15%)
✅ Flexible configuration                     (+10%)
✅ Easy to test                              (+10%)
⚠️  Requires explicit hook calls             (-5%)

Pragmatist Perspective:
✅ Proven pattern (hooks are standard)         (+15%)
✅ Low disruption (extend, don't replace)     (+15%)
✅ Community momentum (hooks > HOCs)          (+10%)
⚠️  Slightly more boilerplate                (-5%)

Innovator Perspective:
✅ Room for future enhancement                (+10%)
⚠️  Not the most novel solution              (-2%)

Combined: 88% confidence
```

**Result:** High enough to proceed with confidence, honest about trade-offs.

---

## Related Examples

- [Bug Fix Workflow](01_bug-fix-workflow.md) - See simple escalation pattern
- [New Feature Workflow](02_new-feature-workflow.md) - See domain memory pattern
- [Optimization Workflow](04_optimization-workflow.md) - See graduated complexity

**Guides:**
- [Decision Framework](../../docs/01-fundamentals/09_decision-framework.md) - When to use which tool
- [Adversarial Validator Agent](../../.claude/agents/adversarial-validator.md) - Playoff method details

---

**Last updated:** v4.18.0 (2025-12-17)
