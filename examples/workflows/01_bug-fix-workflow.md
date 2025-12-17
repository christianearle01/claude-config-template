# Workflow Example: Bug Fix

**Scenario:** Authentication error in production - users can't log in
**Complexity:** Medium (unknown root cause)
**Time:** 15-20 minutes
**Tokens used:** ~2,800 tokens

---

## Initial State

**Problem report:**
```
Production users reporting "Invalid token" error on login
Error occurs intermittently (30% of login attempts)
Started happening after yesterday's deployment
```

**What we know:**
- Error message: "Invalid token"
- Recent deployment (possible cause)
- Intermittent (not all requests fail)

**What we don't know:**
- Which file has the bug
- Root cause of token invalidation
- Why it's intermittent

---

## Decision Point 1: How to Start Investigation?

**Options considered:**
1. **Grep for error message** - Fast, finds where error is thrown
2. **Explore agent** - Systematic, understands auth flow
3. **Read auth files directly** - Requires knowing which files

**Decision:** Use **Grep first** (simplest tool)

**Reasoning:**
- Error message is specific: "Invalid token"
- Grep will quickly locate where error originates
- Can escalate to Explore if Grep doesn't help

**Tool used:**
```bash
Grep pattern="Invalid token" path=. output_mode=content
```

**Result:**
```
src/auth/tokenValidator.ts:45:  throw new Error('Invalid token');
src/auth/sessionManager.ts:78:  console.log('Invalid token detected');
```

**Tokens:** ~200 tokens

---

## Decision Point 2: Which File to Investigate?

**Finding:** Error thrown in `tokenValidator.ts:45`

**Decision:** **Read that file directly**

**Reasoning:**
- Grep gave us exact location
- No need for Explore agent (we found the file)
- Direct read is fastest next step

**Tool used:**
```bash
Read file_path=src/auth/tokenValidator.ts
```

**Key findings:**
```typescript
// Line 42-50
function validateToken(token: string): boolean {
  const decoded = jwt.verify(token, process.env.JWT_SECRET);
  if (decoded.exp < Date.now()) {  // BUG: Wrong comparison!
    throw new Error('Invalid token');
  }
  return true;
}
```

**Tokens:** ~500 tokens

---

## Decision Point 3: Is Root Cause Clear?

**Observation:** Line 44 compares `decoded.exp < Date.now()`

**Analysis needed:**
- `decoded.exp` is in seconds (JWT standard)
- `Date.now()` returns milliseconds
- Comparison is wrong by factor of 1000

**Decision:** Root cause is **CLEAR** - no need for sequential-thinking MCP

**Reasoning:**
- Bug is obvious once you see it
- Standard JWT timing issue
- Don't need deep analysis, just fix the comparison

---

## Decision Point 4: Fix Strategy

**Options:**
1. Fix inline (divide Date.now() by 1000)
2. Fix by converting exp to milliseconds
3. Use library function that handles this

**Decision:** **Fix inline** (simplest, clearest)

**Tool used:**
```bash
Edit file_path=src/auth/tokenValidator.ts
```

**Change:**
```typescript
// Before:
if (decoded.exp < Date.now()) {

// After:
if (decoded.exp < Math.floor(Date.now() / 1000)) {
```

**Tokens:** ~300 tokens

---

## Decision Point 5: Testing Strategy

**Question:** How to verify the fix?

**Decision:** Use **Testing-workflow skill** for guidance

**Reasoning:**
- This is a cheatsheet query (quick reference)
- Skill will auto-invoke and provide test strategy
- Faster than exploring test files manually

**Skill invoked:** Testing-workflow
**Guidance provided:**
- Run auth unit tests: `npm test -- auth`
- Check integration tests: `npm test -- e2e/login`
- Manual smoke test in staging

**Tool used:**
```bash
Bash command="npm test -- src/auth/tokenValidator.test.ts"
```

**Result:** All tests pass ✅

**Tokens:** ~600 tokens (includes skill + bash)

---

## Decision Point 6: Commit Strategy

**Decision:** Standard commit workflow (no approval needed for clear bug fix in our setup)

**Tools used:**
```bash
git add src/auth/tokenValidator.ts
git commit -m "fix: Correct JWT expiration timestamp comparison

JWT exp is in seconds, Date.now() is in milliseconds.
This was causing 30% of tokens to be incorrectly invalidated.

Fixes authentication errors in production."
```

**Tokens:** ~200 tokens

---

## Final Workflow Summary

```
1. Grep "Invalid token"          →  200 tokens  →  Found error location
2. Read tokenValidator.ts         →  500 tokens  →  Identified bug
3. Edit (fix comparison)          →  300 tokens  →  Applied fix
4. Testing-workflow skill         →  400 tokens  →  Got test strategy
5. Bash (run tests)               →  200 tokens  →  Verified fix
6. Git commit                     →  200 tokens  →  Committed change
                                  ────────────
                            TOTAL: 1,800 tokens
```

**Time:** 15 minutes
**Outcome:** Bug fixed, tested, committed

---

## Alternative Approach (Less Efficient)

**What if we'd used Explore agent first?**

```
1. Explore agent (find auth flow)     → 2,000 tokens
2. Read multiple files                → 1,000 tokens
3. Sequential-thinking (analyze)      → 1,500 tokens
4. Edit (fix)                         → 300 tokens
5. Testing                            → 600 tokens
                                      ────────────
                                TOTAL: 5,400 tokens (3x more!)
```

**Lesson:** Start simple (Grep), escalate only if needed.

---

## Key Takeaways

### ✅ Good Decisions

1. **Started with Grep** - Fastest way to locate error
2. **Read directly** - No exploration needed once location known
3. **Didn't over-think** - Bug was obvious, didn't use sequential-thinking
4. **Used skill for testing** - Quick cheatsheet query, not manual exploration

### ❌ Common Mistakes to Avoid

1. **Using Explore first** - Would waste 2K tokens when Grep suffices
2. **Sequential-thinking for obvious bugs** - Save for complex root causes
3. **Not testing** - Always verify fix works
4. **Vague commit message** - Document the WHY, not just WHAT

### 🎯 Decision Framework Applied

- **Known vs unknown:** Error message known → Start with Grep
- **Simple vs complex:** Bug obvious → No deep analysis needed
- **Tool selection:** Direct tools > Agents for simple tasks
- **Model selection:** N/A (only used direct tools, no agents)

---

## When to Escalate

**Use Explore agent if:**
- Grep doesn't find the error
- Multiple files involved
- Need to understand system architecture first

**Use Sequential-thinking if:**
- Root cause unclear after reading code
- Multiple potential causes
- Complex interaction between components

**Use Plan agent if:**
- Fix requires changes to multiple files
- Architectural implications
- Need to coordinate changes carefully

---

## Related Examples

- [New Feature Workflow](02_new-feature-workflow.md) - See domain memory pattern
- [Refactor Workflow](03_refactor-workflow.md) - See adversarial validation
- [Optimization Workflow](04_optimization-workflow.md) - See graduated complexity

**Guides:**
- [Decision Framework](../../docs/01-fundamentals/09_decision-framework.md) - Master tool selection
- [Integration Patterns](../../docs/02-optimization/06_integration-patterns.md) - Tool combinations

---

**Last updated:** v4.18.0 (2025-12-17)
