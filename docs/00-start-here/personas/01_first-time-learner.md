# First-Time Learner

**📍 You are here:** [Home](../README.md) > [Choose Your Persona](README.md) > First-Time Learner

**⬅️ Back:** [Choose Your Persona](README.md)

---

## Brief

Learn Claude Code fundamentals from scratch. Covers installation, core concepts, CLAUDE.md project memory, and model switching basics. Includes hands-on practice with first project setup. Perfect for developers new to AI-assisted coding.

**Time:** 60-90 min | **Difficulty:** Beginner | **Outcome:** Complete understanding + working setup

---

## You Are This Persona If...

- You've never used Claude Code before
- You want to understand WHY things work, not just HOW
- You have 60-90 minutes to learn properly
- You value deep understanding over quick shortcuts
- You prefer learning fundamentals before advanced features

---

## Your Path (Numbered Steps)

### 1. Install Claude Code (20 min)
**→ [Installation Guide](../../01_global-setup/01_must-have/01_installation.md)**

Set up Claude Code on your machine, verify installation, configure basic settings.

### 2. Learn Core Concepts (15 min)
**→ [Quick Start Guide](../../01_global-setup/01_must-have/02_quick-start.md)**

Understand what Claude Code is, how it works, and your first commands.

### 3. Master Model Switching (10 min)
**→ [Model Switching Strategy](../../01_global-setup/02_good-to-have/01_model-switching.md)**

Learn how to save 66.7% on costs by using the right model for each task.

### 4. Set Up Your First Project (30 min)
**→ [Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)**

Create CLAUDE.md for your first project, document business context, test your setup.

---

## Journey Checklist

**Installation Phase:**
- [ ] Installed Claude Code successfully
- [ ] Verified installation with `claude --version`
- [ ] Completed first conversation with Claude

**Understanding Phase:**
- [ ] Understand what CLAUDE.md is for (project memory/business context)
- [ ] Can explain the difference between Sonnet, Haiku, and Opus models
- [ ] Know when to use each model (planning vs implementation)

**Practical Skills Phase:**
- [ ] Can switch between models (`/model haiku`, `/model sonnet`, `/model opus`)
- [ ] Created CLAUDE.md for your first project
- [ ] Documented business purpose (WHAT app does, not HOW it works)

**✅ Final Checkpoint:**
- [ ] Run `/model` - does it show current model?
- [ ] Ask Claude "What does this project do?" - does it know from CLAUDE.md?

---

## Success Criteria

You can:
1. Start Claude Code in any project directory
2. Switch models based on task complexity
3. Have documented your first project's business purpose in CLAUDE.md
4. Understand why CLAUDE.md saves tokens (context persistence)

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Using Sonnet for Everything
**Problem:** Paying $3 per million tokens when $0.25 (Haiku) would work fine

**Example:**
```
You: "List all the files in src/"
Claude (Sonnet): [Lists files... costs 11× more than necessary]
```

**✅ Correct Approach:**
```
You: "/model haiku"
You: "List all the files in src/"
Claude (Haiku): [Lists files... saves 92% on tokens]
```

**Pattern:** Use Haiku for exploration, Sonnet for implementation, Opus for architecture.

---

### ❌ Anti-Pattern #2: Documenting Implementation Details in CLAUDE.md
**Problem:** Wasting tokens on info Claude can read from code

**Example:**
```markdown
## Dependencies
- express v4.18.2 (web framework)
- mongoose v7.0.3 (MongoDB ODM)
- bcrypt v5.1.0 (password hashing)
- jsonwebtoken v9.0.0 (JWT auth)
[... 50+ more dependencies ...]
```

**✅ Correct Approach:**
```markdown
## What Does This App Do?

**TaskFlow** helps remote teams coordinate work with real-time collaboration.

## External APIs

### Twilio (SMS)
- **Purpose:** Send urgent task notifications
- **Business Reason:** Users requested SMS for deadline reminders
```

**Pattern:** Document BUSINESS PURPOSE (why), not technical details (what/how). Claude reads package.json automatically.

---

### ❌ Anti-Pattern #3: Skipping Model Switching to "Save Time"
**Problem:** Lose 30 seconds now, waste $50/month later

**Example:**
```
You: "Implement OAuth authentication"
Claude (Sonnet): [Plans + Implements... costs $4 in tokens]

vs.

You: "Plan OAuth authentication"
Claude (Sonnet): [Creates plan... costs $1]
You: "/model haiku"
You: "Implement the plan you just created"
Claude (Haiku): [Implements... costs $0.10]

Savings: $2.90 per feature (72% cheaper)
```

**✅ Correct Approach:**

Always use the **Sonnet → Haiku workflow**:
1. Sonnet for planning (needs intelligence)
2. `/model haiku` to switch
3. Haiku for implementation (follows instructions well)

**Pattern:** 30 seconds to switch models = $50/month savings (for typical developer).

---

## Next Steps

### After Completing This Path

You're ready to move to one of these paths:

**Option A: Optimize Your Workflow (Recommended Next)**
→ [Advanced Optimizer](03_advanced-optimizer.md) - Add security hooks, custom agents, MCP servers

**Option B: Set Up More Projects**
→ [Quick Setup User](02_quick-setup-user.md) - Now you can set up projects in 15 minutes

**Option C: Deploy to Your Team**
→ [Team Lead](04_team-lead.md) - Share your knowledge with your team

**Option D: Plan a New Project**
→ [Planning a New Project](06_planning-new-project.md) - Use the project-planner agent

---

## Need Help?

**Stuck on installation?** Run `/doctor` in Claude Code to diagnose issues.

**Confused about CLAUDE.md?** See the [Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md) for examples.

**Not sure which model to use?** See the [Model Switching Guide](../../01_global-setup/02_good-to-have/01_model-switching.md) for the decision tree.

---

**Estimated total time:** 75 minutes (midpoint of 60-90 range)

**🏠 [Back to Persona Selector](README.md)** | **📖 [Full Documentation](../README.md)**
