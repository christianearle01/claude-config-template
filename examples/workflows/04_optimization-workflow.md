# Workflow Example: Token Optimization

**Scenario:** User's prompts are verbose and repetitive - costing 3x more tokens than needed
**Complexity:** Low (optimization task)
**Time:** 20 minutes
**Tokens used:** ~1,200 tokens (educational mode) OR ~400 tokens (fast mode)

---

## Initial State

**User complaint:**
```
"I keep asking Claude to refactor code, but my prompts are really long.
I feel like I'm repeating myself and wasting tokens. Can you help me
write better, more concise prompts?"
```

**Sample user prompt (verbatim):**
```
Hey Claude, I need you to take a look at this code file and refactor it.
What I mean by refactor is I want you to improve the code quality by
making it more readable and maintainable. Specifically, I'd like you to
extract any duplicate logic into shared functions, rename variables to
be more descriptive, add comments where the logic is complex, and make
sure the code follows best practices. Also, please make sure you don't
break any existing functionality - all tests should still pass after
your changes. Let me know if you need any clarification on what I'm
asking for. Here's the file path: src/utils/dataProcessor.ts
```

**Word count:** 112 words
**Estimated tokens:** ~150 tokens
**Actual need:** ~30 tokens (80% waste!)

---

## Decision Point 1: Which Workflow Mode?

**Question:** Should I optimize for speed or learning?

**Decision:** Use **Mode-selector agent** to recommend approach

**Tool used:**
```bash
@mode-selector

Task: Optimize user's verbose prompts for token efficiency
Context: User writes 150-token prompts when 30 tokens would suffice
Goal: Teach better prompting while solving immediate problem
```

**Mode-selector output:**

**6-Dimension Analysis:**

| Dimension | Score | Reasoning |
|-----------|-------|-----------|
| **Speed Priority** | 🟡 Medium (60%) | User wants quick fix but also to learn |
| **Quality Priority** | 🟢 High (85%) | Long-term skill matters more than one-time fix |
| **Exploration Need** | 🟡 Low (20%) | Prompt is known, just needs optimization |
| **Context Availability** | 🟢 High (90%) | User provided exact prompt to optimize |
| **Risk Tolerance** | 🟢 High (95%) | Safe domain (prompt writing, not code) |
| **Learning Value** | 🟢 High (95%) | User explicitly wants to learn better prompting |

**Recommendation: Vibe Engineering Mode** (structured, educational approach)

**Rationale:**
- High learning value (user wants to improve skill, not just fix once)
- Low risk (prompt optimization is safe)
- Quality matters (better prompts = ongoing token savings)
- Context available (clear example to work from)

**Suggested workflow:**
1. Use prompt-polisher agent in **Educational mode** (not fast mode)
2. Show before/after comparison
3. Explain principles (teach the skill)
4. Provide reusable template

**Tokens:** ~800 tokens (includes 6-dimension analysis)

---

## Decision Point 2: Which Prompt-Polisher Mode?

**Based on mode-selector recommendation:** Educational mode

**Options available:**
1. **🚀 Improved Only (Fast)** - Just give polished prompt
2. **📚 With Explanation (Balanced)** - Polished + techniques used
3. **🎓 Educational (Deep)** - Full analysis + diff + learning path

**Decision:** Use **Educational mode** (Option 3)

**Reasoning:**
- Mode-selector scored learning value at 95%
- User wants to "write better prompts" (skill building)
- Upfront token cost (~1,200) saves ongoing tokens (user's future prompts)
- One-time investment for permanent improvement

**Tool used:**
```bash
@prompt-polisher educational: [user's verbose prompt]
```

**Prompt-polisher output (Educational mode):**

---

### ✂️ Before/After Diff

**BEFORE (150 tokens):**
```diff
- Hey Claude, I need you to take a look at this code file and refactor it.
- What I mean by refactor is I want you to improve the code quality by
- making it more readable and maintainable. Specifically, I'd like you to
- extract any duplicate logic into shared functions, rename variables to
- be more descriptive, add comments where the logic is complex, and make
- sure the code follows best practices. Also, please make sure you don't
- break any existing functionality - all tests should still pass after
- your changes. Let me know if you need any clarification on what I'm
- asking for. Here's the file path: src/utils/dataProcessor.ts
```

**AFTER (28 tokens - 81% reduction):**
```diff
+ Refactor src/utils/dataProcessor.ts for readability:
+ - Extract duplicate logic
+ - Rename variables descriptively
+ - Add comments where complex
+ - Preserve test compatibility
```

---

### 📊 Impact Analysis

**Token savings:** 122 tokens per prompt (81% reduction)

**If user asks this 10 times per week:**
- Weekly savings: 1,220 tokens (~$0.04/week on Sonnet)
- Monthly savings: 5,280 tokens (~$0.16/month)
- Annual savings: 63,360 tokens (~$1.90/year)

**Plus:** Faster responses (less input to process)

---

### 🎓 Learning Breakdown

**5 Techniques Applied:**

**Technique 1: Remove Conversational Fluff** (saved 35 tokens)
```diff
- Hey Claude, I need you to take a look at this code file and refactor it.
+ Refactor src/utils/dataProcessor.ts
```
**Why:** Claude doesn't need greetings or "I need you to" preambles. Direct imperatives work better.

**Technique 2: Remove Definition of Known Terms** (saved 28 tokens)
```diff
- What I mean by refactor is I want you to improve the code quality by
- making it more readable and maintainable.
+ (removed - Claude knows what "refactor" means)
```
**Why:** Claude has training on standard terms. Don't explain unless using non-standard terminology.

**Technique 3: Use Bullet Lists** (saved 25 tokens)
```diff
- Specifically, I'd like you to extract any duplicate logic into shared
- functions, rename variables to be more descriptive, add comments where
- the logic is complex, and make sure the code follows best practices.
+ - Extract duplicate logic
+ - Rename variables descriptively
+ - Add comments where complex
```
**Why:** Bullets are more token-efficient than prose for lists.

**Technique 4: Assume Defaults** (saved 22 tokens)
```diff
- Also, please make sure you don't break any existing functionality - all
- tests should still pass after your changes.
+ - Preserve test compatibility
```
**Why:** Claude already knows to preserve functionality. Only specify if deviating from norms.

**Technique 5: Remove Meta-Commentary** (saved 12 tokens)
```diff
- Let me know if you need any clarification on what I'm asking for.
+ (removed)
```
**Why:** Claude will ask if unclear. Pre-emptive "let me know" adds no value.

---

### 📚 Learning Path: Next Steps

**Now that you've seen these techniques:**

1. **Practice with your next 5 prompts** - Apply the 5 techniques manually
2. **Notice patterns** - You'll start seeing fluff in real-time
3. **Internalize brevity** - Direct imperatives become natural
4. **Use the template below** - Copy-paste framework for code tasks

**Reusable Template:**
```
[Action] [file_path] for [goal]:
- [Requirement 1]
- [Requirement 2]
- [Requirement 3]
```

**Examples:**
```
Refactor src/auth.ts for clarity:
- Extract validation logic
- Add error handling
- Update tests

Optimize src/api/users.ts for performance:
- Cache frequent queries
- Batch database calls
- Add request deduplication
```

---

**Tokens (Educational mode):** ~1,200 tokens
- Diff view: 200 tokens
- Impact analysis: 150 tokens
- Learning breakdown: 600 tokens
- Learning path: 250 tokens

**One-time investment:** 1,200 tokens
**Ongoing savings:** 122 tokens/prompt × future prompts

**Break-even point:** 10 prompts (~2 weeks of use)

---

## Decision Point 3: Follow-Up Optimization

**User response:** "That's great! Can you also optimize this other prompt I use a lot?"

**New user prompt:**
```
Could you please review the code in src/components/Header.tsx and let me
know if there are any potential security issues? I'm particularly worried
about XSS attacks and whether user input is being sanitized properly.
```

**Decision:** Use **Fast mode** this time (user already learned the principles)

**Tool used:**
```bash
@prompt-polisher improve only: [new prompt]
```

**Prompt-polisher output (Fast mode):**

**✨ Improved Prompt:**
```
Review src/components/Header.tsx for security issues:
- XSS vulnerabilities
- Input sanitization gaps
```

**Impact:** 75 tokens → 18 tokens (76% reduction)

**One Key Learning:** Remove "Could you please" and "I'm particularly worried" - focus on requirements, not feelings.

**Tokens (Fast mode):** ~200 tokens
- Polished prompt: 50 tokens
- Brief impact: 50 tokens
- Key learning: 100 tokens

**When to use Fast mode:** After you've learned the principles, just want quick optimization.

---

## Decision Point 4: Long-Term Pattern

**Question:** Should the user create a reusable template or skill?

**Decision:** Suggest creating a **slash command** for repeated patterns

**Recommendation:**
```bash
# Create .claude/commands/refactor.md with:

Refactor {{file_path}} for {{goal}}:
- Extract duplicate logic
- Improve naming
- Add clarity comments
- Preserve tests

# Usage:
/refactor src/utils/parser.ts readability
```

**Benefit:** User never has to write refactor prompts again (0 tokens after setup)

---

## Final Workflow Summary

```
1. Mode-selector agent (choose approach)   →   800 tokens → Educational mode
2. Prompt-polisher (educational)           → 1,200 tokens → Learned 5 techniques
3. Prompt-polisher (fast, 2nd prompt)      →   200 tokens → Quick optimization
4. Slash command suggestion                →    50 tokens → Automation path
                                           ─────────────
                                     TOTAL: 2,250 tokens (one-time investment)

ONGOING SAVINGS:
- Per optimized prompt: 122 tokens (avg)
- 10 prompts/week: 1,220 tokens/week saved
- Break-even: ~18 prompts (~2 weeks)
- Annual savings: 63,360 tokens (~$1.90 on Sonnet)
```

**ROI:** 2,250 token investment → 63,360 tokens/year saved (28x return!)

---

## Alternative Approach (No Mode Selection)

**What if we'd skipped mode-selector and just used Fast mode?**

```
1. Prompt-polisher (fast)                  →   200 tokens → Quick fix
2. User still writes verbose prompts       →     0 tokens (no learning)
3. Saves tokens THIS TIME only             → Future: still verbose
4. No skill improvement                    → Ongoing waste

TOTAL IMMEDIATE: 200 tokens (vs 2,250)
TOTAL LONG-TERM: 0 tokens saved (user didn't learn)
```

**Lesson:** Spending 2,000 extra tokens for education pays back in 2 weeks.

---

## Alternative Approach (Manual Optimization)

**What if user tried to optimize manually without agent help?**

```
1. Read prompting documentation             → 3,000 tokens
2. Experiment with variations               → 1,500 tokens (trial and error)
3. Compare results                          →   800 tokens
4. Learn from mistakes                      → 2,000 tokens (rework)
5. Eventually internalize principles        → 7,300 tokens total

PLUS: 2-3 hours of effort
PLUS: Frustration from unclear principles
```

**Lesson:** Educational mode provides structured learning path (saves 5,000 tokens + time).

---

## Key Takeaways

### ✅ Good Decisions

1. **Used Mode-selector first** - Identified this as learning opportunity (not just quick fix)
2. **Chose Educational mode** - User explicitly wanted to improve skill
3. **Switched to Fast mode** - After learning principles, speed is fine
4. **Suggested automation** - Slash command eliminates repeated prompt writing

### ❌ Common Mistakes to Avoid

1. **Always using Fast mode** - Misses learning opportunities
2. **Always using Educational mode** - Wastes tokens when principles known
3. **Optimizing once, not systematizing** - User keeps writing verbose prompts
4. **Skipping mode-selector** - May choose wrong complexity level

### 🎯 Decision Framework Applied

- **Learning value:** High (95%) → Educational mode
- **Frequency:** High (10/week) → Worth investment
- **Skill building:** Yes → Teach principles, not just fix
- **Graduated complexity:** Educational → Fast → Automation

---

## Mode Selection Guide

**Use Educational mode (🎓) when:**
- User wants to learn the skill
- High frequency task (ROI justifies investment)
- Principles are transferable to other prompts

**Use Balanced mode (📚) when:**
- User somewhat familiar with prompting
- Want understanding but not deep dive
- Moderate frequency task

**Use Fast mode (🚀) when:**
- User already knows prompting principles
- One-off optimization
- Speed is priority
- Just need the improved version

**Use Mode-selector when:**
- Uncertain which mode to use
- High-stakes optimization
- Want data-driven mode choice

---

## Related Examples

- [Bug Fix Workflow](01_bug-fix-workflow.md) - See simple tool escalation
- [New Feature Workflow](02_new-feature-workflow.md) - See domain memory pattern
- [Refactor Workflow](03_refactor-workflow.md) - See adversarial validation

**Guides:**
- [Decision Framework](../../docs/01-fundamentals/09_decision-framework.md) - When to use which tool
- [Prompt Patterns](../../docs/01-fundamentals/08_prompt-patterns.md) - 10 reusable templates
- [Prompting Fundamentals](../../docs/01-fundamentals/07_prompting-fundamentals.md) - How AI works
- [Mode-Selector Agent](../../.claude/agents/mode-selector.md) - 6-dimension framework
- [Prompt-Polisher Agent](../../.claude/agents/prompt-polisher.md) - 3 output modes

---

**Last updated:** v4.18.0 (2025-12-17)
