# Your First Claude Code Win (5 Minutes)

Get one quick success to see the value, then decide your path.

**📝 Note:** This guide uses example scenarios to demonstrate potential benefits. Token savings shown are based on Anthropic's pricing and typical usage patterns.

**Goal:** See Claude Code read your CLAUDE.md and answer a project question without exploring files.

**Why this matters:** This 5-minute exercise demonstrates the core value proposition:
- ✅ **Instant context** - Claude knows your project immediately
- ✅ **Example token savings** - 20K tokens saved (didn't need to explore files)
- ✅ **Example cost savings** - Approximately $0.30 on a single query
- ✅ **Time savings** - No waiting for file exploration

---

## ⏱️ Timed Steps (5 Minutes Total)

💡 **AI-Assisted Alternative:** Instead of running these commands manually, you can ask Claude Code in your terminal:
> "Help me complete the 5-minute success demo for Claude Code configuration"

Claude will guide you through each step interactively. [See full workflow →](../UPDATE_GUIDE.md#-interactive-update-with-claude)

**Or follow the manual steps below:**

### Step 1: Clone Template (1 minute)

```bash
# Clone the template to your home directory
cd ~
git clone https://github.com/your-username/claude-config-template.git

# Navigate into it
cd claude-config-template
```

**✓ Success indicator:** You see the template files listed

---

### Step 2: Copy to ANY Project (1 minute)

You can use **any** project on your machine - even a small test project.

```bash
# Navigate to your project
cd /path/to/any-project

# Copy the CLAUDE.md template
cp ~/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md
```

**Don't have a project handy?** Create a test one:
```bash
mkdir ~/test-claude-project
cd ~/test-claude-project
cp ~/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md
```

**✓ Success indicator:** `CLAUDE.md` exists in your project directory

---

### Step 3: Edit CLAUDE.md - Add ONE Sentence (2 minutes)

Open `CLAUDE.md` in any text editor:

```bash
# Use your favorite editor
code CLAUDE.md     # VS Code
vim CLAUDE.md      # Vim
nano CLAUDE.md     # Nano
open -a TextEdit CLAUDE.md  # Mac TextEdit
```

**Find line 5** (or near the top) and replace the placeholder with one sentence:

```markdown
# Project Memory - [YOUR PROJECT NAME]

## What Does This Application Do?

This is a [type of project] that [what it does].
```

**Examples:**
- "This is a React e-commerce app that sells shoes online"
- "This is a Python CLI tool that analyzes log files"
- "This is a Node.js API that manages user authentication"
- "This is a test project to learn Claude Code"

**Save the file.** That's all you need for this demo!

**✓ Success indicator:** CLAUDE.md has your one-sentence description

---

### Step 4: Test It! (1 minute)

Start Claude Code and ask about your project:

```bash
# Start Claude Code in your project directory
claude
```

**Ask Claude:**
```
What does this project do?
```

**What you should see:**
Claude reads `CLAUDE.md` and answers with the description you wrote - **without exploring any files!**

---

## 🎉 Success! What Just Happened?

You just experienced the power of `CLAUDE.md`:

### ✅ Context Without Exploration
- Claude knew about your project **instantly**
- No time wasted reading files
- No tokens spent on exploration

### ✅ Token Savings Demonstrated

**Example without CLAUDE.md:**
- Claude explores: `src/`, `package.json`, `README.md`, etc.
- Tokens used: ~20,000
- Cost: ~$0.30 (with Sonnet)
- Time: 30-60 seconds

**Example with CLAUDE.md:**
- Claude reads: `CLAUDE.md` (200 tokens)
- Tokens used: ~500
- Cost: ~$0.00075
- Time: Instant

**Example savings: $0.30 → $0.00075 (99.75% reduction on this query!)**

_Note: Actual savings vary based on your project size and usage patterns._

### ✅ Scalable Pattern
Example: Asking 100 questions during development:
- **Without CLAUDE.md:** ~$30 in exploration costs (projected)
- **With CLAUDE.md:** ~$0.075 in context loading (projected)

**Example savings: ~$29.93 per project!**

_Note: Theoretical calculation based on author's experience. Your mileage may vary._

---

## 🤔 Why Did This Work?

Claude Code has a special feature: it **automatically reads `CLAUDE.md`** at the start of every conversation.

Think of `CLAUDE.md` as your project's "business card":
- **What** the project does (business purpose)
- **Why** it exists (problem it solves)
- **How** it's organized (structure, patterns)

This gives Claude instant context without exploring hundreds of files.

---

## 📊 Projected Impact

**⚠️ Note:** This is a new project (1 user). Examples below are theoretical projections, not verified by multiple real users.

This 5-minute demo shows just the beginning. With a fully configured `CLAUDE.md`:

**Projected Token Optimization:**
- First query: 95% token reduction (20K → 1K) - example
- Ongoing queries: 70-85% reduction (estimated)
- Project lifetime: **50-95% total token savings** (projected)

**Projected Cost Optimization:**
- Single developer: $20-40/month saved (theoretical)
- Team of 5: $100-200/month saved (theoretical)
- Enterprise (20+ devs): $500-1000/month saved (theoretical)

**Time Optimization:**
- No waiting for file exploration
- Instant context in every conversation
- Faster onboarding for new team members

_Help us validate these projections! Try the template and share your results._

---

## 🚀 Next Steps - Choose Your Path

You've seen the value. Now decide how deep you want to go:

### ⚡ Quick Setup (15-30 minutes)
**Best for:** You're convinced, want to set up your project properly now

**What you'll do:**
- Copy `.claude/` configuration folder
- Complete the CLAUDE.md template (not just one sentence!)
- Configure project-specific settings

**Go to:** [Quick Setup Guide](START_HERE.md#quick-setup-user)

---

### 🆕 First-Time Learner (60-90 minutes)
**Best for:** You want to understand Claude Code thoroughly

**What you'll learn:**
- How Claude Code works (concepts, architecture)
- Model switching (save 92% with Sonnet→Haiku pattern)
- Permission modes (plan/ask/acceptEdits)
- MCP servers, security hooks, custom agents

**Go to:** [First-Time Learner Path](START_HERE.md#first-time-learner)

---

### 📚 Explore Features First
**Best for:** You want to see what else this template offers

**Check out:**
- [Visual Guides](VISUAL_GUIDES.md) - 5 Mermaid diagrams explaining concepts
- [Quick Reference](QUICK_REFERENCE.md) - Find any feature instantly
- [README](README.md) - Full feature overview

---

### 🎯 Just Use the Wizard
**Best for:** You want guided setup with validation

**Run this:**
```bash
cd ~/claude-config-template
./scripts/claude-wizard.sh
```

The wizard will:
- Ask about your experience level
- Guide you through persona-specific setup
- Validate each step
- Include knowledge checks
- Celebrate your progress

---

## 💡 Pro Tips

**Tip 1: Expand Your CLAUDE.md**
The one-sentence description was just to demonstrate the concept. A complete `CLAUDE.md` includes:
- Tech stack (frameworks, languages, databases)
- External APIs and their business purposes
- Code style conventions
- Common commands
- Project structure

**See:** [CLAUDE.md Template](../templates/CLAUDE.md.template)

---

**Tip 2: Model Switching for Maximum Savings**
You can save even more with the Sonnet→Haiku pattern:
1. Use **Sonnet** for planning (smarter, more thorough)
2. Switch to **Haiku** for implementation (92% cheaper!)

**Example:**
```bash
# Start with Sonnet for planning
claude
You: "Plan how to add user authentication"

# Switch to Haiku for implementation
/model haiku
You: "Implement the authentication plan"
```

**Savings: 92% on implementation costs!**

---

**Tip 3: Share With Your Team**
If this demo impressed you, imagine the impact on your team:
- Consistent project documentation
- Faster onboarding (new devs read CLAUDE.md)
- Standardized Claude Code usage
- Shared cost savings

**See:** [Team Onboarding Guide](../02_project-onboarding/02_good-to-have/03_team-onboarding.md)

---

## ❓ FAQ

### Q: Do I need to write a huge CLAUDE.md?
**A:** No! Start with the basics:
- What the project does (business purpose)
- Tech stack (languages, frameworks)
- Common commands

You can expand it over time as you use Claude Code.

### Q: What if I change my project?
**A:** Just update CLAUDE.md! It's version-controlled with your project, so it evolves as your code evolves.

### Q: Does this work with both Claude Code interfaces?
**A:** Yes! CLAUDE.md works identically with:
- ✅ Claude Code CLI (`claude` command)
- ✅ Claude Code VS Code Extension

### Q: Can I use this for multiple projects?
**A:** Absolutely! Each project gets its own `CLAUDE.md` file. Copy the template to each project and customize.

### Q: What if my team doesn't use Claude Code yet?
**A:** CLAUDE.md is still valuable:
- Serves as project documentation
- Helps new developers understand the project
- Ready for when you adopt Claude Code

---

## 🎓 What You Learned in 5 Minutes

- [ ] ✅ CLAUDE.md provides instant project context
- [ ] ✅ Saves 99% tokens on context queries (demonstrated)
- [ ] ✅ Claude reads CLAUDE.md automatically
- [ ] ✅ One sentence is enough to see the value
- [ ] ✅ Full CLAUDE.md unlocks even more savings
- [ ] ✅ Model switching (Sonnet→Haiku) saves 92% more

---

## 🏁 Ready for More?

**Option 1: Continue Setup Now**
- Run wizard: `./scripts/claude-wizard.sh`
- Or follow manual guide: [START_HERE.md](START_HERE.md)

**Option 2: Learn More First**
- Read projected examples: [docs/PROJECTED_IMPACT.md](PROJECTED_IMPACT.md)
- See visual guides: [VISUAL_GUIDES.md](../VISUAL_GUIDES.md)
- Browse quick reference: [QUICK_REFERENCE.md](../QUICK_REFERENCE.md)

**Option 3: Share This Win**
- Show your team this 5-minute demo
- Calculate your potential savings
- Plan team rollout: [Team Onboarding](../02_project-onboarding/02_good-to-have/03_team-onboarding.md)

---

**🎉 Congratulations!** You've completed your first Claude Code win. The template has much more to offer - choose your path and keep going!

---

## Navigation

**🏠 [Back to README](../README.md)** | **🗺️ [Choose Your Learning Path](../START_HERE.md)** | **📖 [Quick Reference](../QUICK_REFERENCE.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/your-repo) - v4.5.2*
