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

## Key Operations

### Operation 1: Installation Walkthrough

**User Query:**
> "How do I set up Claude Code?"

**Confidence:** 🟢 High (0.93)
- Clear setup intent
- Step-by-step process with validation
- Known installation paths

**Skill Response:**
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

**Why This Matters:**
- One-time global setup prevents per-project friction
- Step-by-step validation catches issues early
- MCP servers add 3-5x capability (sequential-thinking, memory, etc.)
- **Quick win:** Run `claude --version` right now to check installation status

**Next Step:** Once installed, ask "How do I configure global settings?"

### Operation 2: Troubleshooting Setup Issues

**User Query:**
> "Claude setup isn't working"

**Confidence:** 🟡 Medium (0.72)
- Vague error description (need more context)
- Multiple possible failure points
- Requires diagnostic questions

**Skill Response:**
```
🔧 Setup Troubleshooting

Common Issues:

1. "Command not found: claude"
   → Install Claude Code first
   → Check PATH includes claude binary

2. "Permission denied" errors
   → Run: chmod +x ~/.claude/*
   → Check ~/.claude/ ownership

3. "MCP server won't start"
   → Verify MCP installed: npm list -g
   → Check MCP config syntax

4. "Settings not loading"
   → Validate JSON: cat ~/.claude/settings.json | python -m json.tool
   → Check for typos in JSON

Which issue matches your situation?
```

**Why This Matters:**
- Setup failures block all Claude Code usage (high-priority fix)
- Common issues have known solutions (fast resolution)
- Diagnostic questions narrow down root cause
- **Quick win:** Run suggested diagnostic command to identify specific issue

**Next Step:** Share error message for targeted troubleshooting

---

**Skill Version:** 3.4.0
**Last Updated:** 2025-12-13
**Target Audience:** First-time users, new installations
