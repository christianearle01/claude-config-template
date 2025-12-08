# Claude Code Setup - Choose Your Profile

<!-- Breadcrumb Navigation -->
**📍 You are here:** [Home](README.md) > Choose Your Profile

**⬅️ Back:** [README](README.md) | **⚡ Quick Demo:** [5-Minute Success](docs/5_MINUTE_SUCCESS.md) | **🗺️ Visual Guide:** [Flowchart](docs/VISUAL_QUICKSTART.md)

---

**Welcome!** This template helps you set up Claude Code efficiently based on YOUR needs.

**⏱️ Take 30 seconds** to select the profile that matches your situation, then follow your personalized path.

💡 **Cross-Platform:** Works with both Claude Code CLI (`claude` command) and VS Code Extension.

---

## 🆕 First-Time Learner

**You are:** New to Claude Code, want to learn fundamentals
**Time commitment:** 60-90 minutes
**What you'll get:** Complete understanding + working setup

### Your Personalized Path

1. **[Install Claude Code](01_global-setup/must-have/01_installation.md)** (20 min)
   Set up Claude Code on your machine

2. **[Quick Start Guide](01_global-setup/must-have/02_quick-start.md)** (15 min)
   Learn core concepts and first commands

3. **[Model Switching Strategy](01_global-setup/good-to-have/01_model-switching.md)** (10 min)
   Save 92% on costs with smart model usage

4. **[Project Onboarding](02_project-onboarding/must-have/01_onboarding-guide.md)** (30 min)
   Set up your first project with CLAUDE.md

### Journey Checklist

- [ ] Installed Claude Code successfully
- [ ] Understand what CLAUDE.md is for (business context)
- [ ] Can switch between models (`/model haiku`, `/model sonnet`)
- [ ] Created CLAUDE.md for first project
- [ ] ✅ **Checkpoint:** Run `/model` - does it show current model?

### Success Criteria

You can start Claude Code, switch models, and have documented one project's business purpose in CLAUDE.md.

---

## ⚡ Quick Setup User

**You are:** Already use Claude Code, just need project setup
**Time commitment:** 15-30 minutes
**What you'll get:** Configured project, ready to code

### Your Personalized Path

**→ Jump to:** [Project Setup Checklist](02_project-onboarding/must-have/02_setup-checklist.md)

**Fast track:**
```bash
# 1. Copy configuration (2 min)
cd /path/to/your/project
cp -r ~/Developer/claude-config-template/.claude .
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md

# 2. Edit CLAUDE.md (10 min)
# Document: What does this app DO? (business purpose)
# Document: Why each external API? (business reason)

# 3. Test (1 min)
claude
# Ask: "What does this project do?"
```

### Quick Checklist

- [ ] Copied `.claude/` folder to project
- [ ] Created `CLAUDE.md` from template
- [ ] Documented business purpose (WHAT app does, not HOW)
- [ ] Documented external API purposes (WHY each is used)
- [ ] ✅ **Done!** Test with: `claude` then ask "What does this project do?"

### Success Criteria

Claude Code can explain your project's business purpose without exploring files.

---

## 🚀 Advanced Optimizer

**You are:** Want security hooks, custom agents, MCP servers
**Time commitment:** 20-40 minutes
**What you'll get:** Production-grade advanced features

### Your Personalized Path

1. **[Security Hooks](01_global-setup/nice-to-have/01_security-guide.md)** (10 min)
   Prompt injection detection, response scanning

2. **[Custom Agents](01_global-setup/good-to-have/03_custom-agents.md)** (15 min)
   Build specialized agents for your workflow

3. **[MCP Servers](01_global-setup/good-to-have/02_mcp-setup.md)** (10 min)
   Install context7, GitHub, database integrations

### Advanced Checklist

- [ ] Installed prompt injection detection hook
- [ ] Created at least one custom agent
- [ ] Configured project-specific MCP servers
- [ ] Tested hooks with suspicious input
- [ ] ✅ **Checkpoint:** Run `/doctor` - shows all green?

### Success Criteria

Security hooks active, custom agents working, MCP servers connected.

---

## 👥 Team Lead

**You are:** Setting up Claude Code for your entire team
**Time commitment:** 90-120 minutes (one-time investment)
**What you'll get:** Repeatable process, team documentation

### Your Personalized Path

1. **[Team Onboarding Guide](02_project-onboarding/good-to-have/03_team-onboarding.md)** (20 min)
   Understand team rollout strategy

2. **[Create Shared Template](02_project-onboarding/good-to-have/02_optimization-guide.md)** (30 min)
   Fork this template for your organization

3. **[Write Team Guidelines](templates/CLAUDE.md.template)** (30 min)
   Document your team's coding standards

4. **[Pilot Deployment](02_project-onboarding/must-have/02_setup-checklist.md)** (30 min)
   Onboard 2-3 developers first

### Team Deployment Checklist

- [ ] Planned rollout strategy (pilot → full team)
- [ ] Created shared template repository
- [ ] Documented team-specific standards in `~/.claude/coding-standards.md`
- [ ] Successfully onboarded 2+ pilot users
- [ ] Gathered feedback and refined process
- [ ] ✅ **Checkpoint:** 2+ team members can use Claude Code independently?

### Success Criteria

At least 2 team members successfully set up and using Claude Code with consistent standards.

---

## 🔄 Returning User

**You are:** Used Claude Code before, need a quick refresher
**Time commitment:** 10-20 minutes
**What you'll get:** Memory refreshed, back to productivity

### Your Personalized Path

**→ Jump to:** [Quick Reference Card](#quick-reference-card) (below)

### Refresher Checklist

- [ ] Reviewed essential commands (5 min)
- [ ] Recalled model switching strategy (3 min)
- [ ] Checked what's new in template (5 min)
- [ ] ✅ **Ready to code!**

### Success Criteria

Remember key commands, model switching strategy, and any new template features.

---

## 🎯 Planning a New Project

**You are:** Have a project idea but NO code yet, need planning help
**Time commitment:** 25-30 minutes
**What you'll get:** Complete project plan, tech stack recommendations, CLAUDE.md draft

### Your Personalized Path

**→ Jump to:** [Pre-Project Planning Guide](03_pre-project-planning/must-have/01_planning-guide.md)

**Quick Start:**
```bash
# In Claude Code, invoke the project-planner agent:
@project-planner I want to build [describe your project idea]

# Example:
@project-planner I want to build a task management SaaS for small teams
```

### Planning Conversation Flow

The project-planner agent will guide you through 4 phases:

1. **Discovery** (5 min) - Understand your idea and constraints
2. **Exploration** (10-15 min) - Discuss architectural approaches
3. **Recommendation** (5 min) - Receive tech stack recommendations
4. **Documentation** (5 min) - Get CLAUDE.md draft and next steps

### What You'll Receive

- [ ] Project Planning Summary (problem, users, features)
- [ ] Tech stack recommendations with WHY for each choice
- [ ] CLAUDE.md template draft (ready to use)
- [ ] Next steps checklist (concrete action items)
- [ ] Learning resources (tailored to your skill level)
- [ ] Migration paths (how to change decisions later)
- [ ] ✅ **Ready to start coding!**

### Success Criteria

You can articulate your project vision, understand recommended tech choices, and have a concrete plan to start building.

### After Planning

Once you've completed planning:
1. Create your project repository
2. Copy `.claude/` configuration: `cp -r ~/Developer/claude-config-template/.claude .`
3. Use your generated CLAUDE.md draft
4. Initialize your tech stack (framework, database, etc.)
5. **Then use:** [Project Onboarding](02_project-onboarding/) for ongoing development

---

## Quick Reference Card

### Essential Commands

```bash
/model haiku      # Switch to cheap model (92% cost savings)
/model sonnet     # Switch to balanced model (default)
/model opus       # Switch to most capable model (use sparingly)
/usage            # Check your plan limits and usage
/clear            # Start fresh context (reset conversation)
/doctor           # Diagnose Claude Code installation issues
/help             # Show all available commands
```

### Model Switching Strategy (Save 92% on costs!)

**The Strategy:**
1. **🎯 Sonnet for Planning** - "Plan how to implement feature X"
2. **⚡ Haiku for Implementation** - After plan approved, switch: `/model haiku`
3. **🧠 Opus for Complex Problems** - Only when Sonnet struggles

**Example Workflow:**
```
You: "Plan how to add OAuth authentication"
Claude (Sonnet): [Creates detailed plan]
You: "/model haiku"
You: "Implement the plan you just created"
Claude (Haiku): [Implements at 92% lower cost]
```

**Cost Comparison:**
- Sonnet: $3 per million input tokens
- Haiku: $0.25 per million input tokens
- **Savings: 92%** when using Haiku for implementation!

### Token Optimization Tips

**Be Specific:**
```
❌ "Fix the bug"
✅ "Fix the NoneType error in app/user.py:127 where email is accessed without None check"
```

**Reference Files:**
```
❌ "Add validation"
✅ "Add email validation to signup() in app/auth.py, follow the pattern in app/utils.py:45"
```

**Tell What to Skip:**
```
❌ "Review the code"
✅ "Review app/auth.py for security issues. Skip: tests/, migrations/, node_modules/"
```

**Provide Context:**
```
❌ "Implement the feature"
✅ "Implement OAuth following the pattern in app/google_auth.py. Use OAUTH_CLIENT_ID from .env. Skip exploring - I'll tell you what you need."
```

### CLAUDE.md Purpose

**What to Document:**
- ✅ **Business Purpose:** "This app helps X users do Y"
- ✅ **Key Features:** From user perspective (not technical details)
- ✅ **External APIs:** WHY each is used (business reason)
- ✅ **Coding Conventions:** Naming, formatting, patterns

**What NOT to Document:**
- ❌ Full dependency list (Claude reads package.json)
- ❌ Implementation details (Claude reads the code)
- ❌ Function signatures (Claude sees them in code)

**Example:**
```markdown
## What Does This App Do?

**TaskFlow** helps remote teams coordinate work with real-time collaboration.

**Core Features:**
1. Real-time document editing (WebSockets)
2. Smart notifications (Twilio SMS, SendGrid email)

## External APIs

### Twilio (SMS)
- **Purpose:** Send urgent task notifications
- **Used By:** Notification system, deadline reminders
```

### Common Workflows

**Starting New Project:**
```bash
cd /path/to/project
cp -r ~/Developer/claude-config-template/.claude .
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md
# Edit CLAUDE.md to document business purpose
claude
```

**Switching Projects:**
```bash
cd /path/to/different/project
claude
# Claude automatically reads that project's CLAUDE.md
```

**Optimizing Costs:**
```bash
# 1. Start with Sonnet for planning
claude
You: "Plan feature X"

# 2. Switch to Haiku for implementation
/model haiku
You: "Implement the plan"

# 3. Back to Sonnet if stuck
/model sonnet
```

**Creating Git Commit:**
```bash
# Ask Claude to create commit (it follows conventions)
You: "Create a commit for these changes"
Claude: [Analyzes changes, creates semantic commit message]
```

---

## Still Not Sure Which Profile?

### Decision Tree

**Question 1: Do you have an existing project or starting from scratch?**
- **New project, no code yet** → 🎯 **Planning a New Project**
- **Existing project** → Continue to Question 2

**Question 2: Have you used Claude Code before?**
- **No** → 🆕 **First-Time Learner**
- **Yes, but it's been months** → 🔄 **Returning User**
- **Yes, I use it regularly** → Continue to Question 3

**Question 3: What's your goal today?**
- **Set up one project** → ⚡ **Quick Setup User**
- **Add advanced features** → 🚀 **Advanced Optimizer**
- **Set up for my team** → 👥 **Team Lead**

**Question 4: How much time do you have?**
- **10-20 minutes** → 🔄 Returning User or ⚡ Quick Setup
- **15-30 minutes** → ⚡ Quick Setup User or 🎯 Planning a New Project
- **30-60 minutes** → 🚀 Advanced Optimizer
- **60-90 minutes** → 🆕 First-Time Learner
- **90-120 minutes** → 👥 Team Lead

**Still confused?** Start with 🆕 **First-Time Learner** - you can always skip ahead!

---

## 📚 Full Template Structure

```
claude-config-template/
├── 01_global-setup/              ← Global, one-time setup
│   ├── must-have/               ← Start here (required)
│   │   ├── 01_installation.md
│   │   ├── 02_quick-start.md
│   │   └── 03_workflow-guide.md
│   ├── good-to-have/            ← Read next (huge benefits)
│   │   ├── 01_model-switching.md
│   │   ├── 02_mcp-setup.md
│   │   └── 03_custom-agents.md
│   └── nice-to-have/            ← Advanced topics
│       └── 01_security-guide.md
│
├── 02_project-onboarding/       ← Per-project setup (existing code)
│   ├── must-have/               ← Start here (required)
│   │   ├── 01_onboarding-guide.md
│   │   └── 02_setup-checklist.md
│   └── good-to-have/            ← Read next (optimization)
│       ├── 01_prompt-optimization.md
│       ├── 02_optimization-guide.md
│       └── 03_team-onboarding.md
│
├── 03_pre-project-planning/     ← NEW! Plan new projects (no code yet)
│   ├── must-have/               ← Start here
│   │   └── 01_planning-guide.md
│   └── README.md                ← Overview
│
├── templates/                    ← Copy these to your project
│   ├── CLAUDE.md.template
│   ├── project-plan-template.md ← NEW! Example output
│   └── .gitignore.template
│
└── .claude/                      ← Configuration files
    ├── agents/                   ← Custom agents
    │   └── project-planner.md   ← NEW! Planning agent
    ├── commands/                 ← Slash commands
    ├── hooks/                    ← Security hooks
    └── settings.json             ← Template settings
```

---

## ⚡ Why This Matters

### Without This Template
- 😰 Spend hours figuring out Claude Code setup
- 💸 Waste tokens re-reading files every session
- 🤷 No clear learning path (what do I read first?)
- 📚 Knowledge overload (too many features!)
- 🔄 Re-explain project context every session

### With This Template
- ✅ Clear path: Follow your persona's checklist
- ✅ Save 50-90% on token costs (CLAUDE.md + model switching)
- ✅ Set up once, benefit across ALL projects
- ✅ Numbered files (01 → 02 → 03) show exact sequence
- ✅ Claude remembers project context (via CLAUDE.md)

### Success Stories

**Before:** "I spent $50 in tokens having Claude re-read my codebase"
**After:** "CLAUDE.md saves me $40/month - Claude knows the context instantly"

**Before:** "45 minutes to set up each new project"
**After:** "15 minutes with the Quick Setup path"

**Before:** "My team uses Claude inconsistently"
**After:** "Shared template = everyone follows same patterns"

---

## 🚀 Ready to Start?

### Planning a New Project → Start Here
```bash
# In Claude Code, invoke the project-planner agent:
@project-planner I want to build [your project idea]

# Or read the guide:
cd 03_pre-project-planning/must-have
# Read 01_planning-guide.md
```

### First-Time Learner → Start Here
```bash
cd 01_global-setup/must-have
# Read files in order: 01 → 02 → 03
```

### Quick Setup User → Fast Track
```bash
cd 02_project-onboarding/must-have
# Read 01_onboarding-guide.md
# Follow the copy-paste commands
```

### Advanced Optimizer → Jump to Advanced
```bash
cd 01_global-setup/nice-to-have
# Read 01_security-guide.md first
```

### Team Lead → Plan First
```bash
cd 02_project-onboarding/good-to-have
# Read 03_team-onboarding.md
# Create your deployment plan
```

### Returning User → You're Already Reading It!
Scroll up to [Quick Reference Card](#quick-reference-card) ↑

---

## Need Help?

**Template Issues:** Check [README.md](README.md) for complete documentation
**Claude Code Issues:** Run `/doctor` to diagnose
**Questions?** Review your persona's checklist above

---

## Navigation

**🏠 [Back to README](README.md)** | **⚡ [5-Minute Demo](docs/5_MINUTE_SUCCESS.md)** | **🗺️ [Visual Flowchart](docs/VISUAL_QUICKSTART.md)** | **📖 [Quick Reference](QUICK_REFERENCE.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/your-repo) - v2.6.0*

**Last Updated:** 2025-12-08
**Persona-Based Routing:** ✅ Active
