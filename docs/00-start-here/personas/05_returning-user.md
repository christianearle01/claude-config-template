# Returning User

**📍 You are here:** [Home](../README.md) > [Choose Your Persona](README.md) > Returning User

**⬅️ Back:** [Choose Your Persona](README.md)

---

## Brief

Quick refresher on essential commands, model switching strategy, and what's new in the template. Memory jogger for developers who've used Claude Code before but need to recall key concepts. Straight to productivity.

**Time:** 10-20 min | **Difficulty:** Easy | **Outcome:** Refreshed memory, back to work

---

## You Are This Persona If...

- You've used Claude Code before (weeks or months ago)
- You forgot some commands or strategies
- You want to catch up on template updates
- You need a quick refresher, not deep learning
- You're ready to work but need to jog your memory

---

## Quick Refresher Path

### 1. Essential Commands (5 min)

```bash
# Model switching (save 92% on costs)
/model haiku      # Cheap model for exploration
/model sonnet     # Balanced model (default)
/model opus       # Most capable (use sparingly)

# Workflow commands
/usage            # Check your plan limits
/clear            # Start fresh context
/doctor           # Diagnose issues
/help             # Show all commands

# Custom commands (if you have them)
/test             # Run test suite
/build            # Build and report errors
/review           # Code review
```

### 2. Model Switching Strategy (3 min)

**The Pattern You Forgot:**
1. Sonnet for **planning** → "Plan how to add feature X"
2. `/model haiku` → Switch after plan approved
3. Haiku for **implementation** → "Implement the plan you created"

**Why this works:**
- Sonnet: $3/million tokens (smart planning)
- Haiku: $0.25/million tokens (follows instructions well)
- **Savings: 92%** on implementation costs

### 3. CLAUDE.md Reminder (3 min)

**What it does:** Persists project context across sessions

**Where it lives:** Project root (not `.claude/`)

**What to document:**
- ✅ Business purpose (WHAT app does)
- ✅ External APIs (WHY each is used)
- ✅ Coding conventions (team patterns)
- ❌ NOT file structure (Claude reads code)
- ❌ NOT dependencies (Claude reads package.json)

### 4. What's New in Template (5 min)

**→ [Changelog](../../CHANGELOG.md)** - See latest updates

**Recent additions:**
- v4.6.0: Agents show chain-of-thought reasoning
- v4.5.0: Template sharing and inheritance
- v4.4.0: Template validator script
- v4.3.0: Template gallery (5 domain templates)
- v4.0.0: Team template sharing system

---

## Quick Checklist

**Memory Refreshed:**
- [ ] Remember essential commands (`/model`, `/usage`, `/clear`)
- [ ] Recall model switching strategy (Sonnet → Haiku workflow)
- [ ] Know what CLAUDE.md is for (business context persistence)
- [ ] Checked what's new since last usage

**Ready to Work:**
- [ ] ✅ Start Claude Code: `claude`
- [ ] ✅ Verify CLAUDE.md exists in current project
- [ ] ✅ Remember to switch models for cost savings

---

## Success Criteria

You can:
1. Start using Claude Code immediately without confusion
2. Switch models based on task (planning vs implementation)
3. Understand that CLAUDE.md saves tokens

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Forgot to Switch Models
**Problem:** Using Sonnet for everything, wasting money

**Refresh:**
```
❌ Old habit:
You: "List all files in src/"
Claude (Sonnet): [Lists files... costs 11× more]

✅ Correct pattern:
You: "/model haiku"
You: "List all files in src/"
Claude (Haiku): [Lists files... saves 92%]
```

**Pattern:** Haiku for exploration/mechanical tasks, Sonnet for planning/implementation.

---

### ❌ Anti-Pattern #2: Starting Fresh Every Session
**Problem:** Claude re-learns your project every time

**Refresh:**
```
Without CLAUDE.md:
Session 1: "What does this app do?" → Claude reads 20 files
Session 2: "What does this app do?" → Claude reads 20 files AGAIN

With CLAUDE.md:
Session 1: "What does this app do?" → Claude reads CLAUDE.md (100 tokens)
Session 2: "What does this app do?" → Claude reads CLAUDE.md (100 tokens)

Savings: 95% on context queries
```

**Pattern:** Invest 10 minutes in CLAUDE.md once, save tokens forever.

---

### ❌ Anti-Pattern #3: Not Checking What's New
**Problem:** Missing new features that could save you time

**Refresh:**

The template has evolved significantly:

**Before (v2.0):** Basic setup guides
**Now (v4.6.0):**
- 5 custom agents (project-planner, prompt-polisher, coder, initializer, quality-reviewer)
- Template inheritance system (compose templates)
- Template gallery (5 domain-specific templates)
- Chain-of-thought reasoning in agents
- 18 managed skills

**Check:** [Changelog](../../CHANGELOG.md) to see what you've missed

**Pattern:** Spend 5 minutes on changelog = discover time-saving features.

---

## Next Steps

### After Refreshing Your Memory

You're ready to work, but might want to:

**Option A: Catch Up on New Features (20 min)**
→ [What's New in v4.6.0](../../CHANGELOG.md#v460) - Chain-of-thought agents

**Option B: Optimize Your Workflow (30 min)**
→ [Advanced Optimizer](03_advanced-optimizer.md) - Security hooks, custom agents, MCP

**Option C: Set Up New Project (15 min)**
→ [Quick Setup User](02_quick-setup-user.md) - Fast project configuration

**Option D: Just Start Working**
→ You already know what to do, you're ready!

---

## Quick Reference Card

### Model Selection Decision Tree

```
Is this task...

🎯 CREATIVE or ARCHITECTURAL?
   → /model opus
   → Examples: System design, complex refactoring

💻 WRITING CODE or PLANNING?
   → /model sonnet (default)
   → Examples: Implementing features, debugging

🔍 MECHANICAL or EXPLORATORY?
   → /model haiku
   → Examples: Listing files, searching code, simple edits
```

### Cost Comparison

| Model | Price (per 1M tokens) | Best For |
|-------|----------------------|----------|
| Haiku | $0.25 | Exploration, simple tasks |
| Sonnet | $3.00 | Implementation, planning |
| Opus | $15.00 | Architecture, complex problems |

**Typical Session Breakdown:**
- 20% Haiku (exploration)
- 70% Sonnet (implementation)
- 10% Opus (complex problems)

### Keyboard Shortcuts

```
Esc Esc          # Undo last changes (Rewind)
Ctrl-b           # Run command in background
Tab              # Toggle thinking on/off
Shift-Tab        # Cycle permission modes
```

---

## Need Help?

**Forgot how to create CLAUDE.md?**
→ [Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)

**Model switching not working?**
- Check: Are you typing `/model haiku` (with slash)?
- Verify: Run `/model` to see current model
- Test: Try `/model sonnet` to switch back

**Want deeper understanding?**
→ [First-Time Learner](01_first-time-learner.md) - 60-90 min full course

---

**Estimated total time:** 15 minutes (midpoint of 10-20 range)

**🏠 [Back to Persona Selector](README.md)** | **📖 [Full Documentation](../README.md)**
