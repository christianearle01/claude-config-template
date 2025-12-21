# Hands-On Practice Guide

**Why practice matters - Jake Nations insight (17:09-17:25):**
> "Pattern recognition from experience, not documentation. Manual work reveals constraints and builds instinct."

---

## Philosophy: Experience > Documentation

**The Problem with Documentation-Only Learning:**
- ❌ Reading ≠ Understanding
- ❌ Theory doesn't stick without practice
- ❌ No muscle memory, no pattern recognition

**The Power of Hands-On Practice:**
- ✅ Learn by doing, not reading
- ✅ Build instinct through trial and error
- ✅ Pattern recognition emerges from experience
- ✅ Mistakes teach what docs cannot

**Constructivist Learning Theory:** People construct understanding through active engagement with problems, not passive consumption of information.

---

## 5 Sandbox Practice Environments

Located in: `examples/sandbox/`

Each sandbox provides:
- **Scenario:** Real-world problem to solve (30 min)
- **Starter files:** Minimal project to work with
- **Challenge:** What to configure/optimize
- **Solution:** Reference implementation
- **Validation:** Self-check script
- **"Break This Config" exercises:** Learn from intentional mistakes

---

### 1. CLAUDE.md Configuration Practice

**File:** `examples/sandbox/01-claude-md-practice/`

**Skill:** Foundation (most important!)
**Duration:** 30 minutes
**Goal:** Create effective CLAUDE.md files

**Challenge:**
You've inherited a Node.js API with no documentation. Create CLAUDE.md that helps Claude understand the project WITHOUT reading every file.

**Key Learning:**
- Document WHAT (business purpose) not HOW (implementation)
- Essential vs detailed information
- Experience projected 50-95% token savings firsthand

**Self-assessment:**
- ✅ Can explain tech stack without looking at code?
- ✅ Documented all API endpoints?
- ✅ Would new developer understand architecture?

---

### 2. Prompt Caching Practice

**File:** `examples/sandbox/02-prompt-caching-practice/`

**Skill:** Optimization
**Duration:** 30 minutes
**Goal:** Structure CLAUDE.md for 90% cache hit rate

**Challenge:**
Large React project with slow queries. Structure CLAUDE.md with stable content first, dynamic content last.

**Key Learning:**
- Stable sections cache well (tech stack, architecture)
- Dynamic sections at end (current sprint, recent changes)
- Calculate break-even point (1.25x write, 0.1x read)
- Exceed model minimum (1024+ tokens for Sonnet)

---

### 3. Model Switching Practice

**File:** `examples/sandbox/03-model-switching-practice/`

**Skill:** Optimization
**Duration:** 20 minutes
**Goal:** Learn when to use Opus/Sonnet/Haiku

**Challenge:**
Cost comparison across 3 tasks. Calculate savings from optimal model selection.

**Tasks:**
- Task 1: Read 10 files → Haiku (91% cheaper)
- Task 2: Implement feature → Sonnet (balanced)
- Task 3: Design architecture → Opus (complex reasoning)

**Key Learning:**
- Haiku for exploration (read files, grep, etc.)
- Sonnet for implementation (write code)
- Opus for architecture (design decisions)
- Calculate: 24% token reduction projected

---

### 4. Git Workflow Testing

**File:** `examples/sandbox/04-git-workflow-practice/`

**Skill:** Foundation
**Duration:** 15 minutes
**Goal:** Configure git commit approval

**Challenge:**
Test 3 approval modes and understand trade-offs.

**Modes:**
- **Full:** Git status + diff + approval (~1200 tokens, safest)
- **Commit-Only:** Skip diff, approval only (~400 tokens, 75% savings)
- **Minimal:** Auto-commit (~100 tokens, but risky)

**Key Learning:**
- Safety vs speed vs tokens trade-off
- When to use each mode
- IDE integration reduces need for diff

---

### 5. MCP Integration Practice

**File:** `examples/sandbox/05-mcp-integration-practice/`

**Skill:** Advanced
**Duration:** 25 minutes
**Goal:** Selective MCP loading for token efficiency

**Challenge:**
Enable only needed MCPs. Understand restart requirements.

**Key Learning:**
- Each MCP adds ~50-100 tokens per request
- Disable unused MCPs: Save 100-200 tokens/request
- Filesystem MCP: Essential
- GitHub MCP: Only if committing via Claude
- Sequential-thinking MCP: Only for complex analysis
- Plugin MCPs require restart (officially documented)

---

## How to Use Sandboxes

**Step 1: Choose a sandbox** (start with #1 - CLAUDE.md)

**Step 2: Read the scenario** (5 min)
- Understand the problem
- Don't skip to solution!

**Step 3: Attempt the challenge** (20 min)
- Try on your own first
- Struggle is learning
- Mistakes are valuable

**Step 4: Run validation** (2 min)
```bash
cd examples/sandbox/01-claude-md-practice
./validation.sh
```

**Step 5: Self-assess** (3 min)
- Can you explain choices?
- Do you understand WHY, not just WHAT?
- Would you do it differently next time?

**Step 6: Review solution** (5 min)
- Compare your approach
- What did solution do better?
- What did you do better?

**Step 7: "Break This Config" exercises** (optional, 10 min)
- Learn from intentional mistakes
- Pattern recognition through comparison
- Deeper understanding of principles

---

## "Break This Config" Exercises

**Concept:** Learn by analyzing intentionally broken examples.

**Format:** Each sandbox includes 3 broken configs:

**Example from CLAUDE.md Practice:**

1. **Missing Tech Stack** - Claude has to guess language/framework
2. **Implementation Details Overload** - 5000 lines of function docs
3. **Vague Business Purpose** - "This is a web application" (tells nothing)

**How to use:**
1. Read broken example
2. Ask: "What's wrong? How would I fix it?"
3. Check answer (hidden in dropdown)
4. Compare with your solution

**Why this works:** Contrast learning - seeing what's WRONG makes what's RIGHT more obvious.

---

## Self-Assessment Guide

**After completing a sandbox, ask:**

### Understanding Score (80%+ target)
- ✅ Can you explain configuration choices without notes?
- ✅ Can you teach this skill to a teammate?
- ✅ Do you understand trade-offs (speed vs safety vs cost)?

### Pattern Recognition (3+ items target)
- ✅ Can you identify similar patterns in your own projects?
- ✅ Can you spot tech debt AI would preserve?
- ✅ Can you apply principles to different contexts?

### Confidence in Maintenance (90%+ target)
- ✅ Can you modify this config without asking AI?
- ✅ Can you debug issues that arise?
- ✅ Can you explain choices to code reviewers?

---

## When You're Ready to Move On

**You've mastered a sandbox when:**

1. **Speed:** Complete in <75% of target time
2. **Accuracy:** Pass 100% of validation checks
3. **Understanding:** Can explain WHY for every choice
4. **Application:** Can apply to real project immediately

**Progression:**
1. Sandbox 1 (CLAUDE.md) → Foundation
2. Sandboxes 2-3 (Caching, Models) → Optimization
3. Sandbox 4 (Git) → Workflow
4. Sandbox 5 (MCP) → Advanced
5. Real project → Apply all skills

---

## Common Mistakes

### ❌ Skipping Straight to Solution
**Why it's wrong:** No struggle = no learning. Pattern recognition comes from trial and error.

**Better:** Attempt challenge first, THEN compare with solution.

---

### ❌ Reading Without Doing
**Why it's wrong:** Theory doesn't stick without practice. You'll forget in a week.

**Better:** Spend 30 min in sandbox > 2 hours reading docs.

---

### ❌ Not Using Validation Scripts
**Why it's wrong:** No feedback = no improvement. You might reinforce bad habits.

**Better:** Run validation after every attempt. Iterate based on feedback.

---

## Success Metrics

**Traditional metrics (Speed-Focused):** ❌
- Setup time: 52 min → 28 min
- Completion rate: 60% → 95%
- Token savings: 50-95%

**Understanding-Focused metrics (Jake Nations):** ✅
- Understanding score: 80%+ can explain choices
- Pattern recognition: 3+ tech debt items identified
- Confidence in maintenance: 90%+ can modify without AI
- Token savings: 5+ validated data points

**Why understanding matters more than speed:** Chronic anxiety from lack of comprehension vs confidence from understanding (Jake 16:37-17:05).

---

## Next Steps

**After completing all 5 sandboxes:**

1. **Apply to real project** (30-60 min)
   - Create CLAUDE.md for your codebase
   - Configure MCP selective loading
   - Test model switching on real tasks

2. **Read theory** (optional, now it will stick)
   - [Skills Paradigm](02_skills-paradigm.md) - Why skills > docs
   - [Prompt Patterns](08_prompt-patterns.md) - 10 reusable templates
   - [Model Selection Strategy](../../docs/02-optimization/01_model-selection-strategy.md)

3. **Join progression map** (systematic learning)
   - [Skills Progression Map](../00-start-here/14_skills-progression-map.md)
   - Foundation → Optimization → Strategic
   - Prerequisites, time estimates, self-assessment

---

## Support

**Stuck on a sandbox?**
- Re-read scenario and challenge
- Check validation output for specific errors
- Compare your work with solution
- Review "Common Mistakes" in sandbox README

**Still confused?**
- Ask: "Am I documenting WHAT (business) or HOW (code)?"
- Ask: "Did I focus on essential or detailed information?"
- Ask: "Would this help a new developer understand the project?"

---

**Remember Jake Nations (Netflix):**
> "Pattern recognition from experience, not documentation. Manual work reveals constraints and builds instinct."

**Spend 30 minutes doing > 2 hours reading. Your future self will thank you.**

---

**Version:** v4.22.0 (2025-12-21)
**Philosophy:** "Understanding Over Speed" - Jake Nations Edition
