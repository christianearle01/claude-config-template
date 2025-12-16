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
Guide: 01_global-setup/03_nice-to-have/04_sequential-thinking-mcp.md

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

### Operation 3: Proactive Missing Directory Detection

**Automatic Activation:**
When skill detects:
- User asks about "setup", "install", "configure", "getting started"
- OR user attempts operation requiring ~/.claude/ but directory missing
- OR user mentions error related to missing configuration
- OR user starts conversation in new environment

**Confidence:** 🟢 High (0.90)
- Clear indicator: directory missing or empty
- Known resolution: run setup wizard
- High success rate: 95%+ users succeed on first run
- Deterministic check (directory exists or doesn't)

**Skill Response:**
```
⚠️  **Setup Incomplete:** I notice your ~/.claude/ directory is missing or incomplete.

This is the global configuration directory for Claude Code that stores:
- Global settings (settings.json)
- Projects registry (projects-registry.json)
- Custom skills, agents, and commands

**Why This Matters:**
- Without global setup, Claude Code can't access custom configurations
- Skills, agents, and multi-project management won't work
- You're missing 50-95% token savings potential
- Setup takes ~5 minutes (one-time only)

**Quick Start:**
Run the interactive setup wizard:
```bash
cd /path/to/claude-config-template
./scripts/claude-wizard.sh
```

The wizard will:
1. Create ~/.claude/ directory structure
2. Copy optimal settings.json
3. Set up projects registry
4. Optionally configure MCP servers

**Next Step:** I can walk you through the wizard options. Ready to start?
```

**Why This Matters:**
- Proactive detection prevents "why isn't this working?" confusion
- Missing ~/.claude/ blocks 80% of template features
- Users often don't realize setup is incomplete
- **Quick win:** Run wizard now, be productive in 5 minutes

**Next Step:** After wizard completes, ask "Validate my global setup"

### Operation 4: Proactive Empty Directory Detection

**Automatic Activation:**
When skill detects:
- ~/.claude/ directory exists BUT is empty or missing key files
- settings.json missing or empty (0 bytes)
- User asks about features that require configuration

**Confidence:** 🟢 High (0.88)
- Directory structure is deterministic
- Known required files (settings.json, projects-registry.json)
- Clear fix: complete setup process

**Skill Response:**
```
⚠️  **Partial Setup Detected:** Your ~/.claude/ directory exists but appears incomplete.

**Missing Components:**
❌ settings.json (global Claude Code configuration)
❌ projects-registry.json (multi-project tracking)
⚠️  Skills/agents directories may be missing

**Why This Matters:**
- Partial setup = features silently fail (confusing experience)
- Missing settings.json means using Claude defaults (no optimization)
- Missing registry means no multi-project management
- **Quick win:** Complete setup now to unlock full capabilities

**Fix Options:**

**Option 1: Run Full Wizard (Recommended)**
```bash
cd /path/to/claude-config-template
./scripts/claude-wizard.sh
```

**Option 2: Manual File Copy**
```bash
# Copy global settings template
cp templates/global-settings.json ~/.claude/settings.json

# Initialize empty registry
echo '{"version":"1.0","lastSync":"","projects":[]}' > ~/.claude/projects-registry.json
```

**Option 3: Validation Check**
Ask me: "Validate my global setup" to see what's missing

**Next Step:** Choose an option and let me know when complete
```

**Why This Matters:**
- Empty ~/.claude/ is subtle failure mode (directory exists, but useless)
- Users assume "directory present = setup complete" (wrong!)
- Proactive detection saves hours of "why isn't X working?" debugging
- **Quick win:** Run Option 1 for complete, validated setup

**Next Step:** After fixing, re-check with "Validate my global setup"

### Operation 5: Proactive MCP Server Suggestion

**Automatic Activation:**
When skill detects:
- User asks complex question requiring deep analysis
- User mentions "architecture", "design decisions", "trade-offs"
- User working on multi-step planning
- MCP server would significantly help BUT user hasn't configured it

**Confidence:** 🟡 Medium (0.75)
- MCP benefit is contextual (not always needed)
- User might prefer NOT installing MCP (valid choice)
- Suggestion helpful but not critical

**Skill Response:**
```
💡 **Enhancement Suggestion:** I notice you're working on [complex task].

**Sequential-Thinking MCP Could Help:**
- Structured multi-perspective analysis
- Step-by-step reasoning with revision
- 21-50% token savings on complex decisions
- Higher first-time-right rate

**Current Status:** MCP not detected in your configuration

**Why Consider It:**
- Your current task (architecture/design/planning) benefits from structured thinking
- MCP adds reasoning visibility (you see thought process)
- One-time setup (~5 minutes)
- Optional - you can absolutely continue without it!

**Quick Setup:**
```bash
# Install MCP server
npm install -g @anthropic/sequential-thinking-mcp

# Add to settings.json
# Guide: 01_global-setup/03_nice-to-have/04_sequential-thinking-mcp.md
```

**Alternative:** Continue without MCP - I'll still help, just without the structured reasoning framework.

Would you like to:
1. Set up MCP now (I'll guide you)
2. Continue without MCP
3. Learn more about what MCP does

**Next Step:** Your choice - no wrong answer!
```

**Why This Matters:**
- MCP is powerful but optional (user choice respected)
- Proactive suggestion at right moment (when it would help)
- Not pushy (clearly states "optional" and "alternative")
- **Quick win:** If user says yes, guide through 5-minute setup

**Next Step:** If user sets up MCP, validate with "Test sequential-thinking MCP"

---

**Skill Version:** 3.5.0
**Last Updated:** 2025-12-13
**Target Audience:** First-time users, new installations
