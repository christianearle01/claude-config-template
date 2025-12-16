# Model Switching Guide

Understanding how to switch models efficiently and minimize token costs.

---

## 🎯 Overview

Claude Code supports three main models:
- **Opus 4.5** - Best reasoning, most expensive ($15/M input, $75/M output)
- **Sonnet 4.5** - Balanced quality/cost ($3/M input, $15/M output)
- **Haiku 4.5** - Fast & cheap ($0.25/M input, $1.25/M output)

**Key Question:** Can you switch models mid-conversation without wasting tokens?

**Answer:** Yes, but with caveats. This guide shows you how.

---

## Why This Matters

**Without model switching strategy:**
- Use Sonnet for everything = pay $3/million tokens for simple tasks
- Haiku could handle 60-70% of tasks at $0.25/million (92% cheaper)
- Waste $50-150/month on over-powered model for basic operations
- Miss opportunities to use Opus for truly complex problems (rationing incorrectly)

**With strategic model switching:**
- Plan with Sonnet ($3/M) → Implement with Haiku ($0.25/M) = 92% savings on implementation
- Use Opus only for hardest 5% of problems (optimal resource allocation)
- Typical breakdown: 20% Haiku, 70% Sonnet, 10% Opus = 40-60% cost reduction
- Understand when switching helps vs. when it wastes tokens (cache considerations)

**Time investment:** 10 minutes to learn patterns
**Projected savings:** $50-150/month (for typical developer with $200/month baseline)

---

## 🔄 How Model Switching Works

### Basic Command

```bash
# Switch to Opus
/model opus

# Switch to Sonnet
/model sonnet

# Switch to Haiku
/model haiku
```

### What Happens When You Switch

```
Step 1: You run /model opus
Step 2: Entire conversation history → sent to Opus
Step 3: New model continues from where you left off
```

**Important:** The entire conversation context is sent to the new model!

---

## 💰 Token Costs Explained

### Scenario 1: Stay on Same Model (Cheapest)

```
Current conversation: 50K tokens
Model: Sonnet
Cache hit: 45K tokens @ $0.30/M = $0.0135
Fresh input: 5K tokens @ $3/M = $0.015

Total: ~$0.03 per message
```

### Scenario 2: Switch Models (More Expensive)

```
Current conversation: 50K tokens
Switch to: Opus
Cache hit: 45K tokens @ $1.50/M = $0.0675
Fresh input: 5K tokens @ $15/M = $0.075

Total: ~$0.14 per message (5x more expensive!)
```

### Scenario 3: Start Fresh Session (Most Efficient)

```
New conversation: 0 tokens of context
Model: Opus
Input: 1K tokens @ $15/M = $0.015

Total: ~$0.015 per message
```

---

## 🎁 Prompt Caching: The Secret Weapon

**What is prompt caching?**
Claude Code automatically caches your conversation history, dramatically reducing costs when switching models.

### Without Caching (Theoretical)

```
100K token conversation
Switch to Opus: 100K × $15/M = $1.50 😱
```

### With Caching (Reality) ✅

```
100K token conversation
Cache hit: 90K × $1.50/M = $0.135
Fresh: 10K × $15/M = $0.150

Total: $0.285 (81% savings!) 🎉
```

**Cache benefits:**
- ✅ Lasts 5 minutes after last use
- ✅ Automatic (no configuration needed)
- ✅ ~90% cache hit rate for recent context
- ✅ Works across model switches

---

## 📊 Cost Comparison: Real Examples

### Example 1: 50K Token Conversation

| Action | Cache Hit | Input Cost | Total Cost | vs Sonnet |
|--------|-----------|------------|------------|-----------|
| **Stay Sonnet** | 45K @ $0.30/M | 5K @ $3/M | $0.029 | Baseline |
| **Switch to Opus** | 45K @ $1.50/M | 5K @ $15/M | $0.143 | 5x more |
| **Switch to Haiku** | 45K @ $0.025/M | 5K @ $0.25/M | $0.002 | 14x cheaper! |
| **Fresh Opus session** | None | 1K @ $15/M | $0.015 | Best for Opus |

### Example 2: 200K Token Conversation (Long Session)

| Action | Cache Hit | Input Cost | Total Cost | vs Sonnet |
|--------|-----------|------------|------------|-----------|
| **Stay Sonnet** | 180K @ $0.30/M | 20K @ $3/M | $0.114 | Baseline |
| **Switch to Opus** | 180K @ $1.50/M | 20K @ $15/M | $0.570 | 5x more |
| **Switch to Haiku** | 180K @ $0.025/M | 20K @ $0.25/M | $0.010 | 11x cheaper! |
| **Fresh Opus session** | None | 1K @ $15/M | $0.015 | Best for Opus |

**Key Insight:** The longer the conversation, the more expensive switching becomes!

---

## 🎯 When to Switch Models

### Use Opus When:

✅ **Complex architectural decisions**
```
"Design a scalable microservices architecture for..."
```

✅ **Novel problem-solving**
```
"Debug this race condition in concurrent code..."
```

✅ **Multi-step reasoning**
```
"Refactor this legacy system while maintaining backwards compatibility..."
```

✅ **Code review of complex changes**
```
"Review this 2000-line PR for security issues and performance..."
```

### Stay on Sonnet When:

✅ **Most coding tasks** (90% of work)
✅ **File operations**
✅ **Documentation updates**
✅ **Configuration changes**
✅ **Typical debugging**
✅ **Code generation**

### Use Haiku When:

✅ **Implementing from clear plans**
✅ **Repetitive tasks**
✅ **Simple code generation**
✅ **Quick file operations**
✅ **Following established patterns**

---

## 🚀 Optimal Workflows

### Workflow 1: Plan → Implement (Most Cost-Effective)

```bash
# Session 1: Planning with Sonnet (or Opus for complex)
claude --model sonnet
You: "Plan how to implement user authentication"
# Sonnet creates detailed plan
# Cost: ~$0.10

# Session 2: Implement with Haiku
claude --model haiku
You: "Implement the authentication plan from earlier"
# Haiku follows the plan
# Cost: ~$0.05

Total: $0.15 (vs $0.50 if all Opus)
Savings: 70%
```

### Workflow 2: Sonnet → Opus (Mid-Conversation Switch)

```bash
# Start with Sonnet
claude
You: "Implement user authentication"
# Sonnet starts, hits a complex problem

You: "/model opus"
# Switch to Opus for complex reasoning
# Cost: +$0.20 (context transfer)

You: "How should I handle OAuth token refresh edge cases?"
# Opus solves it

You: "/model sonnet"
# Back to Sonnet for implementation
# Cost: +$0.10 (context transfer back)

Total: $0.30 extra for Opus expertise when needed
```

### Workflow 3: OpusPlan Mode (Automated)

```bash
# Use built-in OpusPlan mode
/model opusplan

# Automatic behavior:
# - Planning phase: Uses Opus
# - Execution phase: Switches to Sonnet
# - Best of both worlds!
```

---

## 💡 Best Practices

### ✅ DO:

1. **Start with the right model**
   ```bash
   # Complex task? Start with Opus
   claude --model opus

   # Simple task? Start with Haiku
   claude --model haiku
   ```

2. **Switch at natural breakpoints**
   ```bash
   # Good: After completing a phase
   "Great, planning done. /model haiku - now implement"

   # Bad: Mid-complex-task
   "Analyzing 20 files... /model opus"  # Expensive context transfer
   ```

3. **Use OpusPlan for hybrid workflows**
   ```bash
   /model opusplan
   # Automatic optimal switching
   ```

4. **Monitor your usage**
   ```bash
   /usage
   # Check plan limits and usage
   ```

### ❌ DON'T:

1. **Don't switch models unnecessarily**
   ```bash
   # Bad: Constant switching
   /model opus
   "Do X"
   /model sonnet
   "Do Y"
   /model opus
   "Do Z"
   # Wastes tokens on context transfer!
   ```

2. **Don't use Opus for simple tasks**
   ```bash
   # Bad: Opus for file operations
   claude --model opus
   "Rename all .js files to .ts"
   # Haiku can do this!
   ```

3. **Don't ignore conversation length**
   ```bash
   # Bad: Long conversation → switch to Opus
   # 200K tokens context = expensive!

   # Good: Start fresh Opus session
   claude --model opus
   # Minimal context = cheap
   ```

---

## 📋 Decision Tree

```
┌─────────────────────────────────────────────┐
│  Should I switch models mid-conversation?   │
└─────────────────────────────────────────────┘
                    │
                    ▼
        ┌───────────────────────┐
        │ Is task truly complex │
        │ requiring Opus?       │
        └───────────────────────┘
                    │
        ┌───────────┴───────────┐
        │                       │
       YES                     NO
        │                       │
        ▼                       ▼
┌───────────────────┐   ┌────────────────┐
│ Conversation < 50K│   │ Stay on current│
│ tokens?           │   │ model          │
└───────────────────┘   └────────────────┘
        │
┌───────┴────────┐
│               │
YES             NO
│               │
▼               ▼
┌──────────┐   ┌──────────────┐
│ Switch   │   │ Start fresh  │
│ /model   │   │ Opus session │
│ opus     │   │ (cheaper!)   │
└──────────┘   └──────────────┘
```

---

## 🎓 Learning Path

### Week 1: Stick to Sonnet
```
Goal: Learn Claude Code basics
Model: Sonnet only
Why: Consistent experience, good balance
Cost: ~$1-2 per day
```

### Week 2-3: Experiment with Haiku
```
Goal: Speed up simple tasks
Model: Sonnet for planning, Haiku for implementation
Why: Learn cost optimization
Cost: ~$0.50-1 per day (50% savings!)
```

### Month 2+: Strategic Opus Use
```
Goal: Use right model for right task
Model: Haiku (70%), Sonnet (25%), Opus (5%)
Why: Maximum efficiency
Cost: ~$0.30-0.80 per day (70% savings!)
```

---

## 📊 Monthly Cost Estimates

### Heavy User (8 hours/day, 20 days/month)

| Strategy | Daily Cost | Monthly Cost | Notes |
|----------|------------|--------------|-------|
| **All Opus** | $15-25 | $300-500 | Premium quality, expensive |
| **All Sonnet** | $3-8 | $60-160 | Balanced (recommended start) |
| **All Haiku** | $0.50-2 | $10-40 | Cheap, may miss nuance |
| **Optimized Mix** | $1-4 | $20-80 | 70% Haiku, 25% Sonnet, 5% Opus |
| **OpusPlan Mode** | $2-6 | $40-120 | Automated optimization |

**Savings potential:** 60-90% vs all-Opus approach!

---

## 🔍 Real-World Example

### Scenario: Building a New Feature

**Task:** Add user authentication to your app

**Naive Approach (All Opus):**
```bash
claude --model opus
"Plan and implement user authentication"
# 2 hours of work
# Context: 150K tokens
# Cost: ~$2.50
```

**Optimized Approach:**
```bash
# Step 1: Plan with Sonnet (30 min)
claude --model sonnet
"Plan user authentication implementation"
# Cost: ~$0.20

# Step 2: Get Opus review on plan (5 min)
claude --model opus
"Review this auth plan for security issues"
# Fresh session, minimal context
# Cost: ~$0.05

# Step 3: Implement with Haiku (1.5 hours)
claude --model haiku
"Implement the approved authentication plan"
# Cost: ~$0.15

Total: $0.40 (84% savings!)
```

---

## ⚙️ Configuration Tips

### Set Your Default Model

Edit `.claude/settings.json`:

```json
{
  "model": "sonnet"
}
```

**Recommendations:**
- **Beginners:** Start with `"sonnet"`
- **Cost-conscious:** Use `"haiku"`
- **Quality-focused:** Use `"opus"`
- **Balanced:** Use `"opusplan"` (auto-switches)

### Model Aliases

```bash
/model opus       # Full reasoning power
/model sonnet     # Balanced (default)
/model haiku      # Fast & cheap
/model opusplan   # Opus for planning, Sonnet for execution
/model sonnetplan # Similar to opusplan but starts with Sonnet
```

---

## 🚨 Common Mistakes

### Mistake 1: Opus for Everything
```
❌ Bad: claude --model opus (for all tasks)
✅ Good: Start with sonnet, switch to opus when needed
Savings: 80%
```

### Mistake 2: Switching Too Often
```
❌ Bad: Switch models every 5 minutes
✅ Good: Switch at phase boundaries
Savings: Context transfer costs reduced
```

### Mistake 3: Ignoring OpusPlan
```
❌ Bad: Manually switching between opus/sonnet
✅ Good: /model opusplan (automatic)
Savings: Automated optimization
```

### Mistake 4: Long Conversations + Switch
```
❌ Bad: 200K context → switch to opus
✅ Good: Start fresh opus session
Savings: $0.50+ per switch
```

---

## 💰 Cost Optimization Checklist

Before switching models, ask:

- [ ] Is this task truly complex enough for Opus?
- [ ] Have I accumulated significant context (>50K tokens)?
- [ ] Could I start a fresh session instead?
- [ ] Am I at a natural breakpoint?
- [ ] Have I tried Sonnet first?
- [ ] Is this a one-time complex problem or repetitive task?
- [ ] Can I use OpusPlan instead?

**If you checked 3+ boxes, consider starting a fresh session instead of switching!**

---

## 🎯 Quick Reference

### When to Switch Mid-Conversation
✅ **Switch if:**
- Conversation < 50K tokens
- Hit genuinely complex problem
- At natural phase boundary
- Need Opus expertise temporarily

❌ **Don't switch if:**
- Conversation > 100K tokens (start fresh!)
- Task is routine
- Model is already appropriate
- You're switching frequently

### Cost per Switch (Approximate)

| Conversation Size | Opus Switch | Haiku Switch |
|-------------------|-------------|--------------|
| 10K tokens | $0.02 | $0.001 |
| 50K tokens | $0.10 | $0.003 |
| 100K tokens | $0.20 | $0.006 |
| 200K tokens | $0.40 | $0.012 |

---

## 📚 Additional Resources

- **[OPTIMIZATION_GUIDE.md](./docs/OPTIMIZATION_GUIDE.md)** - Token savings strategies
- **[QUICK_START.md](./QUICK_START.md)** - Initial model selection
- **Official Docs:** https://code.claude.com/docs/en/models

---

## 🎉 Summary

**Key Takeaways:**

1. ✅ **You CAN switch models mid-conversation**
2. ⚠️ **It WILL cost extra tokens** (but prompt caching helps!)
3. 💡 **Starting fresh is often cheaper** for Opus
4. 🎯 **Use OpusPlan for automatic optimization**
5. 💰 **Strategic model use = 60-90% savings**

**Golden Rule:**
> Start with the right model, switch at phase boundaries, and use Opus sparingly for genuinely complex tasks.

**Cost Rule:**
> If conversation > 100K tokens and you need Opus, start a fresh session instead of switching.

**Efficiency Rule:**
> Sonnet for planning, Haiku for implementation = optimal cost/quality balance.

---

**Last Updated:** 2025-12-04
**Part of:** Claude Code Configuration Template

*Save money, code smart!* 💰

---

## ✅ You've Completed: Model Switching

**What you accomplished:**
- Understand the three Claude models (Opus, Sonnet, Haiku)
- Learn when to switch models mid-conversation
- Know the cost implications of model switching
- Understand OpusPlan mode for automatic optimization
- Master the decision tree for optimal model selection
- Calculate potential monthly savings (60-90% vs all-Opus)

**Next logical step:**

**Option A: Master Prompt Optimization (15 min) - Recommended**
→ [Prompt Optimization Guide](../../02_project-onboarding/02_good-to-have/01_prompt-optimization.md)
- Reduce token usage by 50-80%
- Learn to write specific, context-aware prompts
- 5 real-world examples with before/after

**Option B: Set Up MCP Servers (15 min)**
→ [MCP Setup Guide](02_mcp-setup.md)
- GitHub integration for PR creation
- Sequential Thinking for complex problems
- Memory persistence across sessions

**Option C: Add Security Features (10 min)**
→ [Security Guide](../03_nice-to-have/01_security-guide.md)
- Commit approval workflows
- Token-optimized git operations
- Three protection levels

**Option D: Start Using Model Switching**
→ You're ready! Try:
  - `/model haiku` for file exploration
  - `/model sonnet` for feature implementation
  - `/model opus` for architecture planning
  - `/model opusplan` for automatic optimization

---

**Estimated next step time:** 10-15 minutes (depending on choice)
**Projected monthly savings:** $20-80 with optimized model usage
**Having trouble?** Check the Common Mistakes section above or ask: "Why didn't my model switch work?"
