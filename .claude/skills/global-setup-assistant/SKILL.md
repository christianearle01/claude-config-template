---
name: global-setup-assistant
description: Guides users through one-time machine setup for claude-config-template. Auto-activates when users ask about installation, global settings, MCP setup, or first-time configuration. Reduces setup friction and validates installation.
allowed-tools: Read, Bash
---

# Global Setup Assistant Skill

## Purpose & Activation

**What it does:** Step-by-step guidance for global (machine-wide) setup.

**When it activates:**
- "How do I install Claude Code?"
- "Setup global settings"
- "Configure MCP servers"
- "First time setup"

**Operations:**
- Installation validation
- Global settings.json configuration
- MCP server setup walkthrough
- Troubleshooting common issues

**Token Savings:** 800 tokens/setup (67% reduction, projected)

---

## Typical Flow

**User:** "How do I set up Claude Code?"

**Assistant:**
```
🚀 Global Setup Guide

Step 1: Install Claude Code
Check: claude --version
✅ Installed | ❌ Not found → Install first

Step 2: Global Settings
Location: ~/.claude/settings.json
Template: templates/global-settings.json
✅ Configured | ⚠️ Needs review

Step 3: MCP Servers (Optional)
- sequential-thinking MCP
- filesystem MCP
- memory MCP
Guide: 01_global-setup/nice-to-have/04_sequential-thinking-mcp.md

Step 4: Validation
Run: claude --help
Expected: Command list appears

Current: Step 1 (Installation)
Next: Verify claude --version
```

**Guides users through each step with validation.**

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Target Audience:** First-time users, new installations
