# Claude Code Agent Setup Guide

**For:** Claude Code AI assistants helping users set up this template
**Purpose:** Step-by-step instructions to efficiently guide new users through setup
**Context:** This file helps you (the AI agent) help users without mistakes

---

## 🎯 Your Mission

Help the user set up this Claude Code template in their project efficiently and correctly.

**Expected outcome:**
- User has working Claude Code configuration
- User understands basic workflow
- User saves 70-90% on token costs
- Setup completed in 10-15 minutes

---

## 📊 Important: Conversation Context Efficiency

**Before you start, consider:**

### Should you keep current conversation context or start fresh?

**Keep Current Context (Recommended) if:**
- ✅ You already explored the user's project
- ✅ You know the tech stack and patterns
- ✅ User has asked follow-up questions about setup
- ✅ Context is < 100K tokens
- ✅ This is part of ongoing work

**Start Fresh Session if:**
- ✅ This is a standalone setup task
- ✅ Current conversation is > 150K tokens
- ✅ Previous context is unrelated to setup
- ✅ User explicitly wants to save tokens

**Cost Comparison:**
```
Keep Context (100K tokens):
  Cache hit: 90K @ $0.30/M = $0.027
  Fresh: 10K @ $3/M = $0.030
  Total: ~$0.06 per message

Fresh Session:
  No context: 0K
  Setup reading: 5K @ $3/M = $0.015
  Total: ~$0.015 per message

Savings: $0.045 per message
But: Takes 3x longer (need to explore first)
```

**Recommendation:** Keep context if < 100K tokens and quality matters. Start fresh for pure cost optimization.

**Tell the user:**
> "I have [X]K tokens of context from our conversation. Keeping it costs ~$0.05 more but I'll work faster with context. Want me to continue here or start fresh?"

---

## 📋 Setup Process (Follow This Order)

### Phase 1: Discovery & Assessment (2-3 minutes)

**IMPORTANT FIRST STEP: Ask for Template Location**

Before starting setup, ALWAYS ask the user:
> "Where did you place the claude-config-template directory?"

**Common locations:**
- `~/Developer/claude-config-template`
- `~/Documents/claude-config-template`
- `~/Projects/claude-config-template`
- Custom path chosen by user

**Store this path as `[TEMPLATE_PATH]` and use it throughout the setup.**

**1. Verify Template Location**

After user provides the path, verify it exists:

```bash
# Check template exists
Bash: ls -la [TEMPLATE_PATH]/

# Should see:
# - docs/00-start-here/START_HERE.md
# - README.md
# - .claude/ directory
# - templates/ directory
# - docs/ directory
```

If not found:
- Ask user to provide the correct path
- Suggest using `find ~ -name "claude-config-template" -type d 2>/dev/null` to locate it

**2. Understand User's Project**

Ask or explore:
- [ ] What's the project tech stack? (Python, JavaScript, etc.)
- [ ] Is this a new project or existing codebase?
- [ ] Are they using git?
- [ ] Do they have a team or solo developer?

**Tools to use:**
```bash
# Check project structure
Glob: "**/package.json" or "**/requirements.txt" or "**/Cargo.toml"

# Check git
Bash: git status

# See project size
Bash: find . -type f -name "*.py" -o -name "*.js" -o -name "*.ts" | wc -l
```

---

### Phase 2: Core Setup (5 minutes)

**3. Copy Template Files**

**IMPORTANT:** Use `[TEMPLATE_PATH]` (obtained in Phase 1) in all commands.

```bash
# Navigate to user's project
cd /path/to/user/project

# Copy .claude directory
cp -r [TEMPLATE_PATH]/.claude .

# Copy CLAUDE.md template
cp [TEMPLATE_PATH]/templates/CLAUDE.md.template ./CLAUDE.md

# Verify
ls -la .claude/
ls -la CLAUDE.md
```

**IMPORTANT:** Use the Bash tool, don't use Write tool to create these files. Copying preserves the exact configuration.

**4. Update .gitignore (Important for Security)**

If project has existing .gitignore, append to it. Otherwise create new one.

```bash
# Add Claude Code entries to .gitignore
echo "" >> .gitignore
echo "# Claude Code - Never commit these files" >> .gitignore
echo ".claude.json           # Contains API keys" >> .gitignore
echo ".claude/memory.json    # Project context" >> .gitignore
echo ".claude/plans/         # Planning artifacts" >> .gitignore

# Verify
cat .gitignore | grep -A 3 "Claude Code"
```

**Why this matters:** `.claude.json` contains API keys. Never commit it!

**5. Customize CLAUDE.md**

Read the file first:
```bash
Read: ./CLAUDE.md
```

Then help user fill in:
- [ ] Project name (replace `[PROJECT NAME]`)
- [ ] Tech stack (languages, frameworks)
- [ ] Code conventions (indentation, naming)
- [ ] Common commands (run, test, build)
- [ ] Important file locations

Use Edit tool for precise replacements:
```bash
Edit: ./CLAUDE.md
  old_string: "[PROJECT NAME]"
  new_string: "User's Actual Project Name"
```

**6. Verify Settings**

```bash
# Check settings.json
Read: .claude/settings.json

# Should have:
# - "model": "sonnet"
# - "defaultMode": "plan"
# - "sandbox": { "enabled": true }
```

---

### Phase 3: Security Setup (3 minutes)

**7. Install Prompt Injection Protection**

```bash
# Copy security hook
cp [TEMPLATE_PATH]/examples/hooks/detect-prompt-injection.js .claude/hooks/

# Make executable
chmod +x .claude/hooks/detect-prompt-injection.js

# Verify
ls -la .claude/hooks/
```

**8. Update Settings with Security Hook**

```bash
Edit: .claude/settings.json

# Add hooks section (if not present)
```

Show user the configuration:
```json
{
  "hooks": {
    "PreToolUse": {
      "command": "node",
      "args": [".claude/hooks/detect-prompt-injection.js"],
      "matchers": [
        "WebFetch(*)",
        "WebSearch(*)",
        "mcp__brave-search__search(*)",
        "mcp__fetch__fetch(*)"
      ],
      "timeout": 2000
    }
  }
}
```

**9. Verify .gitignore**

```bash
Read: .gitignore

# Must include:
# .claude.json (API keys)
# .claude/memory.json (context)
# .env files
```

---

### Phase 4: Permission Mode Education (2 minutes)

**10. Explain Permission Modes**

Tell user:
> "Before we start, let's verify your permission mode. Look at the bottom of your Claude Code window."

**You should see one of:**
- ⏸ plan mode (RECOMMENDED for setup)
- ❓ ask mode (also safe)
- 🔓 acceptEdits mode (AVOID during setup)

**If in acceptEdits mode, instruct user:**
> "Press Shift+Tab to switch to Plan Mode. This lets you see changes before they happen."

**Explain why:**
- Plan Mode = see every change first
- AcceptEdits Mode = auto-applies (you might miss important setup steps)
- Ask Mode = asks for every action (slower but maximum control)

**Reference:**
Point user to: [03_permission-modes.md](../../../01_global-setup/01_must-have/03_permission-modes.md) for details.

---

### Phase 5: Optional Enhancements (5 minutes)

**11. Offer MCP Server Installation**

Ask user: "Want to install essential MCP servers? (GitHub, Sequential Thinking, Memory)"

**If yes:**
```bash
# GitHub MCP (requires token)
claude mcp add github npx -- -y @modelcontextprotocol/server-github

# Sequential Thinking (free, no config)
claude mcp add sequential-thinking npx -- -y @modelcontextprotocol/server-sequential-thinking

# Memory (free, no config)
claude mcp add memory npx -- -y @modelcontextprotocol/server-memory
```

**For GitHub token:**
1. User goes to: https://github.com/settings/tokens
2. Create classic token
3. Scopes: `repo`, `read:org`
4. Claude Code will prompt for token on first use

**Reference:** [02_mcp-setup.md](../../../01_global-setup/02_good-to-have/02_mcp-setup.md) for complete details.

---

### Phase 6: Verification (2 minutes)

**12. Test the Setup**

```bash
# Run doctor command
/doctor

# Should show:
# ✅ Settings loaded from .claude/settings.json
# ✅ CLAUDE.md found and loaded
# ✅ MCP servers (if installed)
```

**13. Verify Permission Mode**

Ask user: "What mode indicator do you see at the bottom?"

**Expected:** ⏸ plan mode on

**14. Test Model Switching**

```bash
/model haiku
# Should switch to Haiku

/model sonnet
# Should switch back to Sonnet
```

**15. Check Usage Tracking**

```bash
/usage
# Shows plan limits and usage statistics
```

---

## ✅ Success Checklist

Confirm user has:

- [ ] `.claude/` directory in project
- [ ] `CLAUDE.md` in project root (customized)
- [ ] `.gitignore` includes `.claude.json`
- [ ] Security hook installed: `.claude/hooks/detect-prompt-injection.js`
- [ ] Permission mode is "plan" (⏸)
- [ ] Can switch models: `/model haiku` works
- [ ] `/doctor` shows no errors
- [ ] `/usage` displays usage stats

**If all checked:** Setup complete! ✅

---

## 🎓 Post-Setup Education (5 minutes)

**16. Teach Essential Commands**

```bash
# Model switching (cost optimization)
/model sonnet    # Default, balanced
/model haiku     # 92% cheaper (use after planning)
/model opus      # Expensive, smart (use sparingly)

# Monitoring
/usage           # Check plan limits and usage

# Utilities
Shift+Tab        # Toggle permission modes
/doctor          # Health check
/mcp             # List MCP servers
```

**17. Teach Cost-Saving Workflow**

The ONE rule:
```
1. Plan with Sonnet
2. Switch to Haiku: /model haiku
3. Implement with Haiku (92% cheaper!)
```

**Example:**
```
User: "Plan how to add user authentication"
You (Sonnet): [Creates detailed plan]

User: "/model haiku"
User: "Implement the authentication plan"
You (Haiku): [Implements - saves 92% on tokens!]
```

**18. Point to Key Resources**

Tell user:
> "You're set up! Here are the key resources:"

**Essential (read first):**
- [docs/00-start-here/START_HERE.md](../../../docs/00-start-here/START_HERE.md) - 5-minute quick start (80/20 rule)

**When needed:**
- [03_permission-modes.md](../../../01_global-setup/01_must-have/03_permission-modes.md) - Print-friendly mode guide
- [01_model-switching.md](../../../01_global-setup/02_good-to-have/01_model-switching.md) - When to switch models
- [01_security-guide.md](../../../01_global-setup/03_nice-to-have/01_security-guide.md) - Security best practices
- [02_mcp-setup.md](../../../01_global-setup/02_good-to-have/02_mcp-setup.md) - More MCP servers

**Full documentation:**
- [README.md](../../../README.md) - Complete overview

---

## 🐛 Common Issues & Solutions

### Issue 1: "Settings not loading"

**Check:**
```bash
# Verify file exists
ls -la .claude/settings.json

# Check JSON syntax
cat .claude/settings.json | python -m json.tool
```

**Fix:** Correct JSON syntax errors, re-copy from template if needed.

---

### Issue 2: "CLAUDE.md not found"

**Check:**
```bash
# Must be in project ROOT, not .claude/
ls -la CLAUDE.md
```

**Fix:** Move to project root: `mv .claude/CLAUDE.md ./CLAUDE.md`

---

### Issue 3: "Permission mode not working"

**Check:**
```bash
# Read settings
Read: .claude/settings.json

# Must have:
"permissions": {
  "defaultMode": "plan"
}
```

**Fix:** User can manually toggle with Shift+Tab

---

### Issue 4: "Security hook not running"

**Check:**
```bash
# Verify file exists and is executable
ls -la .claude/hooks/detect-prompt-injection.js

# Check permissions
stat -f "%A" .claude/hooks/detect-prompt-injection.js
# Should be 755 or 750
```

**Fix:**
```bash
chmod +x .claude/hooks/detect-prompt-injection.js
```

---

### Issue 5: "MCP servers not connecting"

**Check:**
```bash
/mcp

# Look for status
```

**Common causes:**
- First run (they download packages via npx)
- Missing API keys (GitHub, Brave Search)
- Network issues

**Fix:** Wait for first initialization, add API keys when prompted.

---

## 💡 Pro Tips for Agents

### Tip 1: Use Parallel Tool Calls
```bash
# BAD (sequential)
Read: .claude/settings.json
[wait]
Read: CLAUDE.md
[wait]
Read: .gitignore

# GOOD (parallel)
Read: .claude/settings.json
Read: CLAUDE.md
Read: .gitignore
# All in one message!
```

### Tip 2: Use Edit, Not Write
```bash
# For existing files from template, use Edit to modify
Edit: ./CLAUDE.md
  old_string: "[PROJECT NAME]"
  new_string: "Actual Name"

# Don't use Write (overwrites everything)
```

### Tip 3: Verify Before Claiming Success
```bash
# Always verify steps
ls -la .claude/
cat .claude/settings.json
/doctor
```

### Tip 4: Teach, Don't Just Do
```
# BAD
"I've set everything up. You're done."

# GOOD
"I've set everything up. Here's what I did:
1. Copied .claude/ directory (contains optimized settings)
2. Customized CLAUDE.md (your project memory)
3. Added security hook (protects against prompt injection)

Key commands:
- /model haiku (switch to cheap model)
- Shift+Tab (toggle to plan mode)
- /usage (check plan limits)

Read docs/00-start-here/START_HERE.md for the full quick guide!"
```

### Tip 5: Reference Documentation
```
# Don't explain everything inline
# Point to the right doc:

"For model switching details, see: MODEL_SWITCHING_GUIDE.md"
"For security info, see: SECURITY_GUIDE.md"
"For daily usage, see: docs/00-start-here/START_HERE.md"
```

---

## 📊 Estimated Timing

**Total setup: 15-20 minutes**

| Phase | Time | Can Skip? |
|-------|------|-----------|
| Discovery | 2-3 min | No |
| Core Setup | 5 min | No |
| Security | 3 min | No |
| Permission Education | 2 min | No |
| MCP Installation | 5 min | Yes (optional) |
| Verification | 2 min | No |
| Education | 5 min | Yes (can defer) |

**Minimum viable setup: 12 minutes** (skip MCP and defer education)

---

## 🎯 Success Metrics

**Setup is successful when:**
- ✅ User can run `/doctor` without errors
- ✅ User is in Plan Mode (⏸)
- ✅ User can switch models (`/model haiku`)
- ✅ User understands Sonnet→Haiku workflow
- ✅ `.claude.json` is in `.gitignore`
- ✅ Security hook is installed

**User is productive when:**
- ✅ They reference docs/00-start-here/START_HERE.md
- ✅ They use Plan Mode during setup
- ✅ They switch to Haiku for implementation
- ✅ They check `/usage` periodically
- ✅ They know where to find more info (README.md)

---

## 🔄 Conversation Context Decision (Include This!)

**Before starting setup, evaluate:**

### Context Size Check
```bash
# Check approximate context
# (you can estimate based on conversation length)

Small: < 50K tokens → Keep context (minimal cost)
Medium: 50-100K tokens → Keep context (slight cost, better quality)
Large: 100-150K tokens → User's choice (explain trade-offs)
Very Large: > 150K tokens → Recommend fresh session
```

### Trade-off Explanation (Tell User)

```
"Current conversation has ~[X]K tokens.

KEEP CONTEXT:
✅ Faster (I know your project)
✅ Better quality (full context)
⚠️ Costs ~$0.10-0.30 more

START FRESH:
✅ Cheaper (~$0.05 total)
⚠️ Slower (need to explore first)
⚠️ Might miss context

Recommendation: [Your suggestion based on context size]"
```

### When to Recommend Fresh Session
- User explicitly wants to minimize cost
- Context > 150K tokens
- Setup is completely independent of previous conversation
- Previous context is unrelated to this project

### When to Recommend Keeping Context
- You already explored the codebase
- Context < 100K tokens
- Quality and speed matter more than $0.20
- This is part of ongoing work

**Include this in your initial message to user!**

---

## 📝 Final Checklist for Agents

Before claiming setup is complete:

- [ ] All core files copied and verified
- [ ] CLAUDE.md customized with project info
- [ ] Security hook installed and executable
- [ ] .gitignore includes .claude.json
- [ ] User understands permission modes
- [ ] User knows essential commands
- [ ] User knows Sonnet→Haiku workflow
- [ ] /doctor shows no errors
- [ ] User pointed to docs/00-start-here/START_HERE.md
- [ ] User knows where to find more info

**If all checked:** Tell user they're ready to code! 🚀

---

## 🎓 Continuous Learning

**This guide will evolve. Future versions should include:**
- New MCP server recommendations
- Updated security practices
- New cost optimization strategies
- Common setup issues discovered
- User feedback integration

**Version:** 1.0
**Last Updated:** 2025-12-04
**Maintained By:** Template users and contributors

---

## 🎉 You're Ready!

Follow this guide step by step, and you'll set up users efficiently and correctly every time.

**Remember:**
- Quality over speed
- Teach, don't just do
- Verify each step
- Point to documentation
- Consider context efficiency

**Happy setup!** 🚀

---

*This guide helps you (Claude Code agent) help users. Keep it updated as you discover better practices!*
