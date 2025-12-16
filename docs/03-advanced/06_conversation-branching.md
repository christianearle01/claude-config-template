# Conversation Branching

**Context management with Shift+Click branching**

---

## Sources & Validation

**Official Claude Code Documentation:**
- Conversation branching: Official Claude Code feature ✅ VALIDATED
- Shift+Click: Official keyboard shortcut

**Note:** This is a built-in Claude Code feature, not a third-party tool.

---

## What is Conversation Branching?

**Branching** lets you explore alternative approaches without polluting your main conversation.

**How it works:**
1. Main conversation reaches a decision point
2. Shift+Click on a message to create branch
3. Branch starts from that point with clean context
4. Explore alternative in branch
5. Return to main conversation when done

**Use case:** "What if I tried approach B instead of approach A?"

---

## When to Use Branching

### ✅ Use Branching For:

**1. Exploring Alternatives**
```
Main: Implementing feature with Redux
Branch: What if I used Context API instead?
```

**Benefit:** Compare approaches without losing original work

---

**2. Planning vs. Implementation**
```
Main: Detailed planning discussion
Branch: Quick implementation test
```

**Benefit:** Keep planning conversation clean

---

**3. Debugging Hypotheses**
```
Main: Current debugging attempt
Branch: Testing alternative hypothesis
```

**Benefit:** Try different debug strategies in parallel

---

**4. Refactoring Experiments**
```
Main: Current code structure
Branch: Experimental refactor
```

**Benefit:** Test refactor without committing to it

---

### ❌ Don't Branch For:

**1. Simple Follow-Ups**
- Just continue in main conversation
- No need to branch for linear progress

**2. Small Corrections**
- "Actually, use TypeScript not JavaScript"
- Just correct in main conversation

**3. Every Single Question**
- Branching overhead not worth it
- Reserve for significant explorations

---

## How to Branch

### Method 1: Shift+Click (Official)

```
1. Find the message where you want to branch
2. Shift+Click on that message
3. New branch conversation starts
4. Original conversation remains unchanged
```

---

### Method 2: Explicit Request

```
You: "Create a branch from here to explore using PostgreSQL instead of MySQL"
```

Claude creates branch with that context.

---

## Token Impact

### Without Branching (Exploratory Work in Main)

```
Main conversation:
- Planning with Approach A (2,000 tokens)
- Try Approach B (5,000 tokens - doesn't work)
- Back to Approach A (2,000 tokens re-explaining)
- Continue with A (3,000 tokens)

Total: 12,000 tokens
Context: Polluted with failed Approach B
```

---

### With Branching

```
Main conversation:
- Planning with Approach A (2,000 tokens)
- Continue with A (3,000 tokens)
Total main: 5,000 tokens

Branch (Approach B exploration):
- Try Approach B (5,000 tokens - doesn't work)
- Discard branch
Total branch: 5,000 tokens (isolated)

Overall saving: Cleaner main context (7,000 vs 12,000 tokens)
```

**Token savings:** Not immediate, but prevents context pollution over time.

---

## Real-World Use Cases

### Use Case 1: Architecture Decision

```
Main: Planning microservices architecture
Branch 1: Explore monolith alternative
Branch 2: Explore serverless alternative

Result: Compare all three, choose best
```

---

### Use Case 2: Library Comparison

```
Main: Implementing auth with Passport.js
Branch: Try Auth0 instead

Result: Decide which is better for project
```

---

### Use Case 3: Debugging Strategy

```
Main: Debugging memory leak (hypothesis A: event listeners)
Branch: Test hypothesis B (large object retention)

Result: Branch finds issue, merge solution to main
```

---

### Use Case 4: Refactoring Safety

```
Main: Current working code
Branch: Aggressive refactor experiment

Result: If refactor works, apply to main. If not, keep working code.
```

---

## Best Practices

### 1. Branch at Decision Points

**Good timing:**
- "Should I use library A or B?"
- "What if I refactor this differently?"
- "Let me test this hypothesis"

**Bad timing:**
- Every minor question
- Simple clarifications
- Linear progress

---

### 2. Name Your Branches Mentally

Even though Claude Code doesn't have branch names, keep track:
- Main = "Redux implementation"
- Branch 1 = "Context API exploration"
- Branch 2 = "MobX alternative"

---

### 3. Limit Branch Depth

**Good:**
```
Main
  ↓
Branch A
```

**Acceptable:**
```
Main
  ↓
Branch A
  ↓
Branch A.1
```

**Bad (confusing):**
```
Main
  ↓
Branch A
  ↓
Branch A.1
  ↓
Branch A.1.1
  ↓
Branch A.1.1.1
```

**Rule:** 2 levels deep maximum

---

### 4. Merge Insights Back

**Pattern:**
```
1. Branch to explore
2. Find useful insight
3. Return to main
4. Apply insight in main conversation
```

**Don't:** Leave valuable insights stuck in branch

---

## Context Management Strategy

### Main Conversation = Source of Truth

Keep main conversation:
- Clean and focused
- Linear progression
- Production-ready decisions

---

### Branches = Experiments

Use branches for:
- Risky experiments
- Alternative approaches
- "What if" scenarios
- Debugging tangents

---

## Advanced Branching Patterns

### Pattern 1: Compare Multiple Approaches

```
Main (planning)
  ├─→ Branch A (approach 1)
  ├─→ Branch B (approach 2)
  └─→ Branch C (approach 3)

Result: Analyze all three, choose winner
```

---

### Pattern 2: Incremental Testing

```
Main (stable implementation)
  ↓
Branch (add feature X)
  ↓
If works: Merge to main
If fails: Discard branch, try different approach
```

---

### Pattern 3: Parallel Debugging

```
Main (describe bug)
  ├─→ Branch A (test hypothesis 1)
  ├─→ Branch B (test hypothesis 2)
  └─→ Branch C (test hypothesis 3)

First branch to find issue wins
```

---

## Token Savings Over Time

**Project lifetime without branching:**
- Context pollution from failed experiments: 20,000-50,000 tokens
- Re-explaining after tangents: 10,000-30,000 tokens
- **Total waste:** 30,000-80,000 tokens

**Project lifetime with branching:**
- Clean main conversation: Minimal waste
- Experiments isolated in branches
- **Savings:** 30,000-50,000 tokens over project

**Note:** Savings compound over months of development

---

## FAQ

**Q: Can I return to a branch later?**
A: Yes, if you keep the conversation tab open. Once closed, branch is lost (unless you save it).

**Q: Can I merge branches?**
A: Not automatically. You manually apply insights from branch to main.

**Q: How many branches can I create?**
A: As many as needed, but more branches = harder to manage.

**Q: Do branches share context?**
A: Branches start with context up to the branch point, then diverge.

**Q: Should I branch for every decision?**
A: No, only for significant explorations. Over-branching creates overhead.

---

## Summary

**Conversation Branching Core Principles:**

1. **Shift+Click to branch** - Official Claude Code feature
2. **Explore without pollution** - Test alternatives in branches
3. **Main = source of truth** - Keep main conversation clean
4. **Branches = experiments** - Risky tests, alternatives
5. **30K-50K token savings** - Over project lifetime

**The outcome:**
- ✅ Clean main conversation (no context pollution)
- ✅ Safe experimentation (try without breaking main)
- ✅ Better decision-making (compare multiple approaches)
- ✅ Long-term token savings (compound over months)

**Best practice:**
> Branch at decision points to explore alternatives. Keep main conversation linear and clean. Merge successful insights back to main.

---

**See also:**
- [Vision Optimization](VISION_OPTIMIZATION.md) - Multimodal efficiency
- [Keyboard Shortcuts](../01-fundamentals/KEYBOARD_SHORTCUTS.md) - Shift+Click and other shortcuts
