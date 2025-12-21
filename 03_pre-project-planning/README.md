# 03 - Pre-Project Planning

**Purpose:** Plan new projects BEFORE writing any code using the project-planner agent.

**When to Use:** You have a project idea but no existing codebase yet. You need architectural guidance, tech stack recommendations, and a structured plan.

---

## What's In This Directory?

### must-have/
**Start here** if you're planning a new project from scratch.

- **[01_planning-guide.md](must-have/01_planning-guide.md)** (25-30 min)
  Complete guide to using the project-planner agent for pre-project planning

---

## Quick Start

```bash
# In Claude Code terminal or VS Code Extension
@project-planner I want to build [describe your project idea]
```

**Example:**
```
@project-planner I want to build a task management SaaS for small teams
```

The agent will guide you through a 4-phase conversation:
1. **Discovery** (5 min) - Understand your idea and constraints
2. **Exploration** (10-15 min) - Discuss architectural approaches
3. **Recommendation** (5 min) - Receive tech stack recommendations
4. **Documentation** (5 min) - Get CLAUDE.md draft and next steps

**Total Time:** 25-30 minutes (time-boxed to prevent over-planning)

---

## What You'll Get

- ✅ **Project Planning Summary** - Complete technical plan with WHY for each decision
- ✅ **Tech Stack Recommendations** - Tailored to your skill level and constraints
- ✅ **CLAUDE.md Draft** - Pre-filled project memory template ready to use
- ✅ **Next Steps Checklist** - Concrete action items to start coding
- ✅ **Learning Resources** - Links to tutorials and documentation
- ✅ **Migration Paths** - How to change decisions later (escape hatches)

See [example project plan](../templates/project-plan-template.md) for complete output.

---

## Who Is This For?

### ✅ Use Pre-Project Planning If You:

- Have a project idea but haven't started coding yet
- Need help choosing tech stack (language, framework, database, hosting)
- Want to validate your architectural decisions before investing time
- Feel overwhelmed by technology choices
- Want to avoid common mistakes (resume-driven development, premature optimization)
- Need a structured plan to follow when you start coding

### ⏭️ Skip This If You:

- Already have an existing codebase → Use [02_project-onboarding](../02_project-onboarding/)
- Prefer "learn by doing" without upfront planning → Start coding and ask Claude as you go
- Have clear technical vision and just need implementation help → Jump straight to development

---

## Success Criteria

**You're ready to start coding when:**

✅ You can articulate your project vision (problem, users, core features)
✅ You understand WHY each technology was recommended
✅ You have a CLAUDE.md draft ready to use
✅ You have concrete next steps (not vague guidance)
✅ You feel confident (not overwhelmed)
✅ You know what to build first (MVP priority)

**Warning:** If planning exceeds 45 minutes, you're over-planning! Start coding and refine as you build.

---

## What Makes This Different?

### vs. Just Asking Claude Directly:

The project-planner agent provides:
- **6 coordinated perspectives** (psychological, educational, technical, product, devops, security)
- **Structured conversation flow** (prevents wandering or going too deep into details)
- **Built-in anti-patterns** (avoids resume-driven development, premature optimization)
- **Time-boxing** (prevents analysis paralysis)
- **Consistent output** (always get CLAUDE.md draft, next steps, migration paths)
- **Persona-aware** (adjusts for your skill level)

### vs. Project Onboarding (02_project-onboarding):

- **Pre-Project Planning** → For NEW projects with no code yet
- **Project Onboarding** → For EXISTING projects to set up Claude Code configuration

---

## After Planning: What's Next?

Once you've completed planning:

1. **Create repository** - Initialize git for your new project
2. **Copy Claude configuration** - `cp -r ~/Developer/claude-config-template/.claude .`
3. **Use your CLAUDE.md draft** - Save the generated template to your project root
4. **Initialize tech stack** - Set up the framework/tools recommended
5. **Start coding** - Build your first MVP feature

Then refer to [02_project-onboarding](../02_project-onboarding/) for ongoing development setup.

---

## Related Resources

- **[Project Planner Agent](../docs/03-advanced/agents/README.md#-project-planner)** - Full agent documentation
- **[Example Output](../templates/project-plan-template.md)** - See what the agent generates
- **[CLAUDE.md Template](../templates/CLAUDE.md.template)** - Template you'll customize
- **[Project Onboarding](../02_project-onboarding/)** - After planning, use this for development setup

---

**Last Updated:** December 5, 2025
**Template Version:** 2.3.0
**Time Investment:** 25-30 minutes per project
