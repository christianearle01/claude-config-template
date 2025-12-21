# Quick Setup User

**📍 You are here:** [Home](../README.md) > [Choose Your Persona](README.md) > Quick Setup User

**⬅️ Back:** [Choose Your Persona](README.md)

---

## Brief

Get a single project configured with Claude Code in 15-30 minutes. Focuses on CLAUDE.md template, model switching basics, and first slash command. Perfect for experienced developers who want immediate productivity without deep theory.

**Time:** 15-30 min | **Difficulty:** Easy | **Outcome:** One production-ready project

---

## You Are This Persona If...

- You've used AI coding assistants before (GitHub Copilot, Cursor, etc.)
- You want to set up ONE project today
- You'll explore advanced features later
- You value speed over comprehensive understanding
- You're comfortable learning by doing

---

## Your Path (Fast Track)

### Step 1: Copy Configuration (2 min)

```bash
cd /path/to/your/project
cp -r ~/Developer/claude-config-template/.claude .
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md
```

### Step 2: Edit CLAUDE.md (10 min)

Open `CLAUDE.md` and document:
1. **What does this app DO?** (business purpose, not technical details)
2. **Why each external API?** (business reason, not just "we use Stripe")

### Step 3: Test Your Setup (1 min)

```bash
claude
# Ask: "What does this project do?"
```

Claude should explain your project's business purpose without exploring files.

---

## Quick Checklist

**Configuration Phase:**
- [ ] Copied `.claude/` folder to your project root
- [ ] Created `CLAUDE.md` from template
- [ ] Verified `.claude/settings.json` exists

**Documentation Phase:**
- [ ] Documented business purpose (WHAT app does, not HOW it's built)
- [ ] Documented external API purposes (WHY each is used)
- [ ] Added coding conventions (if your project has specific patterns)

**Verification Phase:**
- [ ] Started Claude Code in project directory
- [ ] Asked "What does this project do?"
- [ ] Claude can explain business purpose without exploring files

**✅ Done!**
- [ ] Ready to start coding with Claude

---

## Success Criteria

You can:
1. Open Claude Code in your project directory
2. Claude can explain your project's business purpose from CLAUDE.md
3. You understand that CLAUDE.md saves tokens by persisting context

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Skipping CLAUDE.md Documentation
**Problem:** Claude re-reads files every session, wastes 500-2,000 tokens

**Example:**
```
Session 1:
You: "What does this app do?"
Claude: *reads 20 files* "It's a task management app..."

Session 2 (next day):
You: "Add a feature to tasks"
Claude: *reads 20 files again* "Okay, I see this is a task app..."

Cost: 2,000 tokens × 2 sessions = 4,000 tokens wasted
```

**✅ Correct Approach:**
```markdown
<!-- CLAUDE.md -->
## What Does This App Do?

**TaskFlow** helps remote teams coordinate work with real-time collaboration.
```

```
Session 1:
You: "What does this app do?"
Claude: *reads CLAUDE.md* "TaskFlow helps remote teams coordinate..."

Session 2 (next day):
You: "Add a feature to tasks"
Claude: *reads CLAUDE.md* "I know this is TaskFlow, a team coordination app..."

Cost: 100 tokens per session (95% savings)
```

**Pattern:** Invest 10 minutes in CLAUDE.md, save 95% on context queries forever.

---

### ❌ Anti-Pattern #2: Putting .claude/ in Wrong Location
**Problem:** Claude Code doesn't find your configuration

**Example:**
```
your-project/
├── src/
│   └── .claude/          ❌ WRONG (too deep)
├── package.json
└── README.md
```

**✅ Correct Approach:**
```
your-project/
├── .claude/              ✅ CORRECT (project root)
│   ├── settings.json
│   ├── commands/
│   └── agents/
├── CLAUDE.md             ✅ CORRECT (project root)
├── src/
├── package.json
└── README.md
```

**Pattern:** `.claude/` and `CLAUDE.md` live in project root, not subdirectories.

---

### ❌ Anti-Pattern #3: Over-Documenting in CLAUDE.md
**Problem:** Documenting things Claude can read from code wastes tokens

**Example:**
```markdown
<!-- CLAUDE.md -->
## File Structure
- src/
  - app.js (Express server setup)
  - routes/
    - users.js (User CRUD operations)
    - auth.js (Authentication logic)
  - models/
    - User.js (User schema with Mongoose)
[... 100+ lines of file descriptions ...]
```

**✅ Correct Approach:**
```markdown
<!-- CLAUDE.md -->
## What Does This App Do?

**TaskFlow** helps remote teams coordinate work.

## External APIs

### Twilio (SMS)
- **Purpose:** Send urgent notifications
- **Used By:** Deadline reminder system
```

**Pattern:** Document business purpose and WHY, not file structure and WHAT. Claude can read the code.

---

## Next Steps

### After Setting Up Your Project

You're ready to explore more features:

**Option A: Learn Model Switching (10 min)**
→ [Model Switching Strategy](../../01_global-setup/02_good-to-have/01_model-switching.md) - Save 66.7% on costs

**Option B: Add More Projects (15 min each)**
→ Repeat this Quick Setup process for other projects

**Option C: Go Deeper (60 min)**
→ [First-Time Learner](01_first-time-learner.md) - Learn the fundamentals you skipped

**Option D: Add Advanced Features (30 min)**
→ [Advanced Optimizer](03_advanced-optimizer.md) - Security hooks, custom agents, MCP servers

---

## Need Help?

**CLAUDE.md not working?**
- Check filename: Must be `CLAUDE.md` (all caps, .md extension)
- Check location: Must be in project root (not .claude/)
- Test: Ask Claude "What does this project do?"

**Configuration not loading?**
- Check location: `.claude/` must be in project root
- Verify JSON syntax: `cat .claude/settings.json | python -m json.tool`
- Run diagnostics: `/doctor` in Claude Code

**Still stuck?**
→ [Full Project Onboarding Guide](../../02_project-onboarding/01_must-have/01_onboarding-guide.md)

---

**Estimated total time:** 22 minutes (midpoint of 15-30 range)

**🏠 [Back to Persona Selector](README.md)** | **📖 [Full Documentation](../README.md)**
