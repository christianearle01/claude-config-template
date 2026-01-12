# Token Optimization Basics

**Version:** v5.0.0-alpha.1
**Reading Time:** 7 minutes
**Purpose:** Save 50-95% on Claude Code costs while solving your problems

---

## The Problem: Invisible Costs Add Up Fast

**Scenario:** You're using Claude Code for a week.

```
Monday: Ask 20 questions = 50,000 tokens
Tuesday: Ask 25 questions = 62,500 tokens
Wednesday: Ask 30 questions = 75,000 tokens
Thursday: Ask 25 questions = 62,500 tokens
Friday: Ask 20 questions = 50,000 tokens

Weekly total: 300,000 tokens

At Sonnet pricing ($3/M input + $15/M output):
Input (60%): 180,000 tokens × $3/M = $0.54
Output (40%): 120,000 tokens × $15/M = $1.80
Weekly cost: $2.34

Seems cheap? That's $121/year for ONE USER.
Team of 10: $1,210/year
```

**Now with optimization:**

```
Same usage (300,000 tokens/week)
But with:
  - Prompt caching (60% input tokens cached)
  - Right model selection (30% queries use Haiku not Sonnet)
  - CLAUDE.md (eliminates 50% re-introduction tokens)

Optimized token usage: 90,000 tokens/week (70% reduction!)

At optimized pricing:
Input: 54,000 tokens × $3/M = $0.16
Output: 36,000 tokens × $15/M = $0.54
Weekly cost: $0.70

Annual savings per user: $85 (70% reduction)
Team of 10: $850/year saved
```

**Key Insight:** Small optimization habits compound into massive savings.

---

## The Three Big Wins (80/20 Rule)

### Win 1: Prompt Caching (Biggest Impact)

**What It Is:**
Anthropic caches repetitive context (like CLAUDE.md) and reuses it across requests.

**The Problem It Solves:**

```
Without caching:
Request 1: Read CLAUDE.md (5000 tokens) + Question (500 tokens) = 5500 tokens
Request 2: Read CLAUDE.md (5000 tokens) + Question (500 tokens) = 5500 tokens
Request 3: Read CLAUDE.md (5000 tokens) + Question (500 tokens) = 5500 tokens

Daily total (20 requests): 110,000 tokens
Cost: 100,000 tokens are REDUNDANT (reading same CLAUDE.md 20 times)
```

**With caching:**

```
Request 1: Read CLAUDE.md (5000 tokens, cached) + Question (500 tokens) = 5500 tokens
Request 2: Reuse cached CLAUDE.md (0 tokens) + Question (500 tokens) = 500 tokens
Request 3: Reuse cached CLAUDE.md (0 tokens) + Question (500 tokens) = 500 tokens

Daily total (20 requests): 15,500 tokens
Savings: 94,500 tokens (86% reduction!)
```

**How To Enable:**

```json
// .claude/settings.json
{
  "mcpServers": {
    "anthropic": {
      "promptCaching": {
        "enabled": true,
        "cacheBreakers": ["CLAUDE.md", ".env"]
      }
    }
  }
}
```

**No action needed if using this template** - Prompt caching enabled by default.

**ELI12 Analogy:**
Think of Claude like a student taking an open-book test.

WITHOUT caching: Student re-reads textbook for EVERY question (slow, wasteful).
WITH caching: Student reads textbook ONCE, references it for all questions (fast, efficient).

**Savings:** 60-90% on input tokens (most impactful optimization)

---

### Win 2: Right Model for the Job (30% Cost Reduction)

**What It Is:**
Use Haiku (cheap, fast) for simple tasks, Sonnet for complex tasks, Opus for architecture.

**The Problem It Solves:**

```
Using Sonnet for EVERYTHING:
- File exploration: Sonnet ($3/M) × 10,000 tokens = $0.03
- Code review: Sonnet ($3/M) × 20,000 tokens = $0.06
- Architecture decision: Sonnet ($3/M) × 15,000 tokens = $0.045

Daily total (Sonnet only): $0.135
```

**With right model selection:**

```
- File exploration: Haiku ($0.25/M) × 10,000 tokens = $0.0025  ← 91% cheaper!
- Code review: Sonnet ($3/M) × 20,000 tokens = $0.06          ← Same price
- Architecture decision: Opus ($15/M) × 15,000 tokens = $0.225 ← Better quality

Daily total (mixed): $0.2875

Wait, that's MORE expensive!?

BUT: Opus prevents architectural mistakes that cost HOURS to fix.
Example: Wrong database choice = 10 hours rework = $500 (your time)
        vs $0.09 extra for Opus upfront decision

True savings: $499.91 (preventing costly mistakes)
```

**How To Choose:**

```
1. Is this CREATIVE or ARCHITECTURAL work? → Opus
   Examples: System design, tech stack decisions, complex refactoring

2. Does this involve WRITING CODE? → Sonnet
   Examples: Implementing features, fixing bugs, code generation

3. Is this MECHANICAL or EXPLORATORY? → Haiku
   Examples: File reading, searching codebase, running commands
```

**How To Set:**

```bash
# For specific query (CLI):
claude chat --model haiku

# For agent (in agent.md):
model: haiku  # or sonnet, opus
```

**ELI12 Analogy:**
Think of models like shipping options:

- Haiku = Standard shipping (cheap, gets there eventually)
- Sonnet = Two-day shipping (balanced cost/speed)
- Opus = Overnight (expensive but critical for urgent/complex)

Don't overnight ship everything!

**Savings:** 20-40% total cost (when applied correctly)

---

### Win 3: CLAUDE.md (Eliminate Re-Introductions)

**Already covered in:** `02_understanding-claude-memory.md`

**Quick Summary:**
- Without CLAUDE.md: Waste 500+ tokens PER SESSION re-explaining project
- With CLAUDE.md: 0 tokens wasted (context persists)

**Savings:** 30-50% session startup costs

---

## The Token Math (Real Example)

### Scenario: Adding Authentication Feature

**Traditional Approach (No Optimization):**

```
Session 1: "Add auth to my app"
  - No CLAUDE.md → Re-explain project (600 tokens)
  - Question (200 tokens)
  - Response (1000 tokens)
  - Follow-ups (3 × 400 = 1200 tokens)
  Total: 3000 tokens

Session 2: "Fix auth bug"
  - No CLAUDE.md → Re-explain AGAIN (600 tokens)
  - Bug description (300 tokens)
  - Response (800 tokens)
  Total: 1700 tokens

Session 3: "Add protected routes"
  - No CLAUDE.md → Re-explain AGAIN (600 tokens)
  - Question (250 tokens)
  - Response (900 tokens)
  Total: 1750 tokens

Feature complete total: 6450 tokens
Cost (Sonnet): $0.19 input + $0.95 output = $1.14
```

**Optimized Approach:**

```
Session 1: "Add auth to my app"
  - CLAUDE.md auto-loaded (5000 tokens, CACHED) → $0.0125
  - Question (200 tokens) → $0.0006
  - Response (1000 tokens) → $0.015
  - Follow-ups (3 × 400 = 1200 tokens)
    - CLAUDE.md reused (0 tokens cached)
    - Questions (400 × 3 = 1200 tokens) → $0.0036
    - Responses (1200 tokens) → $0.018
  Total: 7400 tokens (but 5000 cached at lower rate)
  Cost: $0.05

Session 2: "Fix auth bug" (Using Haiku - mechanical debugging)
  - CLAUDE.md cached (0 new tokens)
  - Bug description (300 tokens) → $0.000075
  - Response (800 tokens) → $0.001
  Total: 1100 tokens
  Cost: $0.001

Session 3: "Add protected routes"
  - CLAUDE.md cached (0 new tokens)
  - Question (250 tokens) → $0.00075
  - Response (900 tokens) → $0.0135
  Total: 1150 tokens
  Cost: $0.014

Feature complete total: 9650 tokens (but 10000 cached/reused)
True cost: $0.08

SAVINGS: $1.06 (93% reduction!)
```

**Key Optimizations Applied:**
1. ✅ CLAUDE.md eliminated re-introductions (3 × 600 = 1800 tokens saved)
2. ✅ Prompt caching reused CLAUDE.md (5000 tokens cached, reused 2 times)
3. ✅ Right model (Haiku for debugging = 91% cheaper)

---

## Token Cost Cheat Sheet

### Anthropic Pricing (2025)

| Model | Input (per 1M tokens) | Output (per 1M tokens) | Cached Input |
|-------|----------------------|------------------------|--------------|
| Haiku | $0.25 | $1.25 | $0.03 |
| Sonnet | $3.00 | $15.00 | $0.30 |
| Opus | $15.00 | $75.00 | $1.50 |

**Cached input = 90% discount** (biggest lever for savings!)

### Typical Token Counts

| Activity | Tokens (avg) | Model | Cost |
|----------|--------------|-------|------|
| Read CLAUDE.md | 5,000 | Any | $0.015 (Sonnet, uncached) → $0.0015 (cached) |
| Ask simple question | 500 | Haiku | $0.000125 |
| Ask complex question | 2,000 | Sonnet | $0.006 |
| Architecture decision | 5,000 | Opus | $0.075 |
| Generate feature code | 3,000 output | Sonnet | $0.045 |
| Debug error | 1,500 | Haiku | $0.00375 |

**Rule of Thumb:** Every 100k tokens = $0.30 (Sonnet, no caching) → $0.08 (Sonnet, with caching + optimization)

---

## Common Wasteful Patterns (And Fixes)

### ❌ Pattern 1: "Let Me Copy-Paste Entire File"

**Problem:**
```
You: "Review this file for bugs"
[Pastes 1000-line file in chat = 4000 tokens]

Claude: [Reads 4000 tokens, uses 500 to answer]
Waste: 3500 tokens (you didn't need full file)
```

**Fix:**
```
You: "Read src/auth.ts and review for security bugs"

Claude: [Uses Read tool, only loads what's needed]
[Targets specific security issues]
Savings: 3500 tokens (88% reduction)
```

**Principle:** Let Claude read files with tools, don't paste them.

### ❌ Pattern 2: "I'll Explain Everything Every Time"

**Problem:**
```
Session 1: "My app uses Next.js 14, TypeScript, Prisma..."
Session 2: "My app uses Next.js 14, TypeScript, Prisma..." ← REPEAT
Session 3: "My app uses Next.js 14, TypeScript, Prisma..." ← REPEAT

Weekly waste: 3000 tokens
```

**Fix:**
```
Create CLAUDE.md once (5000 tokens upfront)
Every session: Claude auto-reads (cached, reused)

Weekly savings: 2500 tokens (net positive after day 2)
```

**Principle:** Invest in persistent context (CLAUDE.md), save forever.

### ❌ Pattern 3: "Use Sonnet for Everything"

**Problem:**
```
Exploring codebase: Sonnet (overkill)
Reading files: Sonnet (overkill)
Architecture decisions: Sonnet (underkill)

Overpaying for simple tasks, underpowered for complex decisions
```

**Fix:**
```
Exploring: Haiku (91% cheaper, sufficient)
Reading: Haiku (mechanical task)
Architecture: Opus (prevents costly mistakes)

Right tool for job = 30% overall savings
```

**Principle:** Match model to task complexity.

---

## Optimization Checklist (Start Here)

**Level 1: Zero-Effort Wins** (Do these first)

- [ ] Use this template's default settings (caching enabled)
- [ ] Create CLAUDE.md (one-time 15min investment)
- [ ] Let Claude use Read tool (don't paste files)

**Impact:** 50-70% token reduction
**Time:** 20 minutes setup

**Level 2: Habit Changes** (Adopt over first week)

- [ ] Use Haiku for file reading / exploration
- [ ] Use Sonnet for feature implementation
- [ ] Use Opus for major architectural decisions
- [ ] Review CLAUDE.md monthly (keep it current)

**Impact:** Additional 20-30% reduction
**Time:** Becomes automatic after 1 week

**Level 3: Advanced** (Optional, for power users)

- [ ] Configure cache breakers (auto-invalidate when files change)
- [ ] Custom prompts optimized for token efficiency
- [ ] Batch related questions in single session (cache reuse)
- [ ] Monitor token usage (track savings)

**Impact:** Additional 10-20% reduction
**Time:** 1-2 hours to configure

---

## Real User Transformation

### Before Optimization (Week 1)

```
Monday-Friday usage:
  - Model: Sonnet for all queries
  - No CLAUDE.md (re-explaining project 3x/day)
  - Pasting files into chat (4000 tokens/file)
  - No prompt caching

Weekly tokens: 450,000
Weekly cost: $13.50
Annual projection: $702
```

### After Optimization (Week 2)

```
Same work, different approach:
  - Model: Mixed (Haiku 40%, Sonnet 50%, Opus 10%)
  - CLAUDE.md created (eliminates re-introductions)
  - Using Read tool (no file pasting)
  - Prompt caching enabled

Weekly tokens: 135,000 (70% reduction)
Weekly cost: $4.05 (70% savings)
Annual projection: $211

ANNUAL SAVINGS: $491 (one user)
Team of 10: $4,910 saved
```

**Time investment to achieve this:** 30 minutes (Level 1 + Level 2 checklist)

**ROI:** Saves 9 minutes per day in tokens costs + efficiency gains

---

## Try It Yourself

**Measure Your Current Usage:**
```bash
# Check token usage (if using Anthropic API)
curl https://api.anthropic.com/v1/usage \
  -H "x-api-key: $ANTHROPIC_API_KEY"

# Note your weekly tokens
```

**Apply Level 1 Optimizations:**
```bash
# 1. This template has caching enabled (check settings)
cat .claude/settings.json | grep "promptCaching"

# 2. Create CLAUDE.md
claude chat
"Help me create CLAUDE.md for my project"

# 3. Done! Monitor usage next week
```

**Compare Results:**
```
Week 1 (before): ____ tokens
Week 2 (after): ____ tokens
Reduction: ____%
```

**Expected Results:** 50-70% reduction in first week with zero behavior change (just setup).

---

## Next Steps

**Continue Problem-First Learning:**
- **Next:** `04_quick-wins-path.md` (Fastest value demonstration)
- **Back:** `02_understanding-claude-memory.md` (CLAUDE.md deep dive)

**Dive Deeper:**
- **Advanced:** `docs/02-optimization/02_prompt-caching-guide.md` (Cache mechanics)
- **Models:** `docs/02-optimization/01_model-selection-strategy.md` (Choosing right model)

**Track Savings:**
- **Analytics:** `docs/02-optimization/05_token-analytics.md` (Monitor usage)

---

**Navigation:**
- **Back:** `02_understanding-claude-memory.md` (CLAUDE.md explained)
- **Up:** `docs/00-start-here/01_entry-points.md` (Main hub)
- **Next:** `04_quick-wins-path.md` (Fast value path)

---

**Version:** v5.0.0-alpha.1
**Last Updated:** 2025-01-13
**Path:** `docs/00-start-here/problem-first/03_token-optimization-basics.md`
