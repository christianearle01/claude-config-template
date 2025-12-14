---
name: project-onboarding-assistant
description: Guides users through per-project Claude Code setup. Auto-activates when users ask about project setup, CLAUDE.md creation, or project-specific configuration. Reduces per-project setup time from 20min to 5min.
allowed-tools: Read, Write, Bash
---

# Project Onboarding Assistant Skill

## Purpose & Activation

**What it does:** Step-by-step guidance for per-project setup.

**When it activates:**
- "Setup Claude Code for this project"
- "Create CLAUDE.md"
- "Configure project settings"
- "Onboard new project"

**Operations:**
- Create .claude/ directory structure
- Guide CLAUDE.md template filling
- Project settings.json setup
- Validation (all files created)

**Token Savings:** 650 tokens/project (65% reduction, projected)

---

## Typical Flow

**User:** "Setup Claude Code for this project"

**Assistant:**
```
📁 Project Onboarding Guide

Step 1: Create .claude/ directory
mkdir .claude

Step 2: Copy CLAUDE.md template
Source: templates/CLAUDE.md.template
Destination: ./CLAUDE.md

I'll help you fill these sections:
- What Does This Application Do?
- Tech Stack
- Project Structure
- Important Files & Locations

Step 3: Project settings.json (optional)
Copy: .claude/settings.json
Customize: Per-project overrides

Step 4: Validation
✅ CLAUDE.md exists
✅ .claude/ directory created
✅ Git ignores .claude/settings.local.json

Ready to use Claude Code on this project!

Current: Step 1
Shall I create .claude/ directory?
```

**Guides users through personalized project setup.**

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Target Audience:** Users setting up new projects
