# Claude Code Setup Checklist

**Purpose:** Track your Claude Code configuration setup progress. Claude can read this file to help you continue where you left off.

**Usage:**
- Check off items as you complete them
- Ask Claude: "continue the setup" or "what's left to configure?"
- Claude will read this checklist and guide you through remaining steps

---

## 📋 Core Setup Progress

### Phase 1: Prerequisites
- [ ] Claude Code installed (v2.0.58+)
- [ ] Successfully authenticated
- [ ] Template cloned to `~/Developer/claude-config-template` (or other location)
- [ ] Navigated to project directory: `cd /path/to/your/project`

### Phase 2: Essential Configuration
- [ ] **Directory Structure:**
  - [ ] Created `.claude/` directory
  - [ ] Created `.claude/agents/` directory
  - [ ] Created `.claude/commands/` directory (optional but recommended)
  - [ ] Created `.claude/hooks/` directory (if using security hooks)

- [ ] **Settings File:**
  - [ ] Copied `settings.json` to `.claude/settings.json`
  - [ ] Configured `model: "sonnet"`
  - [ ] Enabled `alwaysThinkingEnabled: true`
  - [ ] Set `outputStyle: "concise"`
  - [ ] Enabled sandbox mode
  - [ ] Set `permissions.defaultMode: "plan"`

- [ ] **Project Memory:**
  - [ ] Copied `CLAUDE.md.template` to project root as `CLAUDE.md`
  - [ ] Updated project name in CLAUDE.md
  - [ ] Added tech stack details
  - [ ] Documented coding standards
  - [ ] Added architecture patterns
  - [ ] Documented external integrations
  - [ ] Added common file locations

- [ ] **Git Configuration:**
  - [ ] Updated `.gitignore` with Claude Code patterns:
    - [ ] `.claude/memory.json`
    - [ ] `.claude/plans/`
    - [ ] `.claude/config.json` (if has secrets)
    - [ ] `.env` and `.env.*`
    - [ ] `!.env.example`

### Phase 3: Verification
- [ ] Started Claude Code: `claude`
- [ ] Verified config loaded: `/config`
- [ ] Set permission mode to "plan": `Shift+Tab`
- [ ] Tested CLAUDE.md memory: "Create something following project patterns"

---

## 🔒 Security Setup (Optional - Your Choice)

**Decision Made:** [ ] Install hooks  [ ] Skip hooks  [ ] Defer decision

### If Installing Hooks:
- [ ] Copied `detect-prompt-injection.js` to `.claude/hooks/`
- [ ] Made hook executable: `chmod +x .claude/hooks/detect-prompt-injection.js`
- [ ] Configured hooks in `settings.json`:
  - [ ] PreToolUse hook for WebFetch
  - [ ] PreToolUse hook for WebSearch
  - [ ] PreToolUse hook for MCP fetch tools
  - [ ] Set timeout: 2 seconds
- [ ] Tested hook with suspicious content

### If Adding PostToolUse Protection (High-Security Projects):
- [ ] Copied `scan-response-injection.js` hook
- [ ] Configured PostToolUse hooks in settings
- [ ] Modified script to scan `result` field
- [ ] Tested response scanning
- [ ] Verified 2-3s latency is acceptable

**Security Hook Status:**
- [ ] **Enabled** - Hooks active and protecting
- [ ] **Disabled** - Hooks installed but not configured
- [ ] **Skipped** - No hooks installed

---

## 🤖 Custom Agents (Optional)

- [ ] **Prompt Polisher Agent:**
  - [ ] Copied `prompt-polisher.md` to `.claude/agents/`
  - [ ] Customized with project-specific patterns
  - [ ] Tested: `@prompt-polisher "improve my prompt"`

- [ ] **Custom Agents:**
  - [ ] Created project-specific agents
  - [ ] Documented in `.claude/agents/README.md`

---

## 🔌 MCP Servers (Optional)

### Global MCPs (Recommended for All Projects)
- [ ] **Sequential Thinking MCP** - Enhanced reasoning
  - Command: `npx -y @modelcontextprotocol/server-sequential-thinking`
- [ ] **Memory MCP** - Context persistence
  - Command: `npx -y @modelcontextprotocol/server-memory`
- [ ] **Filesystem MCP** - Advanced file operations
  - Command: `npx -y @modelcontextprotocol/server-filesystem`
- [ ] **Fetch MCP** - Documentation retrieval
  - Command: `npx -y @modelcontextprotocol/server-fetch`

**Configured in:** `~/.claude.json` (global)

### Per-Project MCPs (If Needed)
**Decision:** [ ] Need project-specific MCPs  [ ] Use global only

If project-specific MCPs needed:
- [ ] Created `.claude/config.json` for project MCPs
- [ ] Created `.env` file for API keys
- [ ] Added `.env` to `.gitignore`
- [ ] Configured MCP servers with environment variable references
- [ ] Verified no API key pollution between projects
- [ ] Documented why per-project MCPs are needed

**Examples of per-project MCPs:**
- [ ] Context7 (different API keys per client)
- [ ] GitHub (different tokens per org)
- [ ] Brave Search (different keys per project)
- [ ] Database MCPs (different DBs per project)

**MCP Pollution Prevention:**
- [ ] Read `MCP_POLLUTION_GUIDE.md`
- [ ] Understand global vs per-project strategy
- [ ] Verified no cost contamination risk

---

## ⚙️ Advanced Configuration (Optional)

### Slash Commands
- [ ] Created custom slash commands in `.claude/commands/`
- [ ] Tested commands work
- [ ] Documented command usage

### Hooks Beyond Security
- [ ] **SessionStart:** Created startup hook
- [ ] **SessionEnd:** Created cleanup hook
- [ ] **PostToolUse:** Created validation hooks
- [ ] **UserPromptSubmit:** Created context enrichment

### Status Line
- [ ] Configured custom status line in settings
- [ ] Added useful project context to status

### Output Styles
- [ ] Created custom output styles (optional)
- [ ] Configured preferred output style

---

## 👥 Team Setup (If Sharing with Team)

- [ ] **Repository Configuration:**
  - [ ] Committed `.claude/` directory to git
  - [ ] Committed `CLAUDE.md` to git
  - [ ] Committed `.claude/agents/` to git
  - [ ] Committed `.claude/hooks/` to git
  - [ ] **NOT** committed `.claude/config.json` (if has secrets)
  - [ ] **NOT** committed `.env` files

- [ ] **Global Standards:**
  - [ ] Configured `~/.claude/coding-standards.md`
  - [ ] Team members have same global standards
  - [ ] CLAUDE.md references global standards

- [ ] **Team Onboarding:**
  - [ ] Shared `TEAM_ONBOARDING.md` with team
  - [ ] Documented project-specific conventions
  - [ ] Team trained on permission modes
  - [ ] Team understands hook behavior

- [ ] **Documentation:**
  - [ ] Copied reference guides to `documentation/claude-code/` (optional)
  - [ ] Updated project README with Claude Code instructions
  - [ ] Documented team workflow with Claude

---

## 🎓 Learning & Optimization

- [ ] Read [START_HERE.md](../../../docs/00-start-here/START_HERE.md) (5-minute essentials)
- [ ] Read [02_quick-start.md](../../../01_global-setup/01_must-have/02_quick-start.md) (15-minute full setup)
- [ ] Read [02_optimization-guide.md](../02_good-to-have/02_optimization-guide.md) (token savings strategies)
- [ ] Read [01_prompt-optimization.md](../02_good-to-have/01_prompt-optimization.md) (better prompts)
- [ ] Read [02_mcp-setup.md](../../../01_global-setup/02_good-to-have/02_mcp-setup.md) (MCP installation)
- [ ] Read [01_security-guide.md](../../../01_global-setup/03_nice-to-have/01_security-guide.md) (security best practices)
- [ ] Practiced Sonnet→Haiku workflow for cost savings

---

## 🚀 Post-Setup Verification

### Functionality Tests
- [ ] Created new file with Claude - verified patterns followed
- [ ] Used `@prompt-polisher` - verified agent works
- [ ] Tested `/model haiku` and `/model sonnet` switching
- [ ] Verified MCP servers working: `/mcp list`
- [ ] Tested permission modes: `Shift+Tab` cycles correctly
- [ ] Checked hooks (if installed): Triggered security alert with test

### Performance Verification
- [ ] Measured token usage on typical request
- [ ] Compared with/without CLAUDE.md (70-85% savings expected)
- [ ] Verified Claude doesn't re-read files each request
- [ ] Confirmed Sonnet→Haiku workflow reduces costs

### Team Verification (If Applicable)
- [ ] New team member can clone and start immediately
- [ ] Team member tested setup on their machine
- [ ] Verified consistent behavior across team
- [ ] Team understands when to update CLAUDE.md

---

## 📊 Setup Summary

**Date Setup Started:** ___________
**Date Setup Completed:** ___________
**Setup Completed By:** ___________

**Configuration Choices Made:**
- Permission Mode: [ ] plan  [ ] acceptEdits  [ ] ask
- Security Hooks: [ ] Installed  [ ] Skipped  [ ] Deferred
- MCP Servers: [ ] Global Only  [ ] Per-Project  [ ] None
- Custom Agents: [ ] Installed  [ ] Skipped
- Team Setup: [ ] Yes  [ ] No (Solo)

**Known Customizations:**
-
-
-

**Next Steps / TODO:**
-
-
-

---

## 💡 Tips for Using This Checklist

**For You:**
1. Check off items as you complete them
2. Use this to resume setup after breaks
3. Share with team members for their setup

**For Claude:**
1. When user says "continue setup", read this checklist
2. Identify unchecked items
3. Guide user through next steps
4. Update checklist as items are completed

**Maintenance:**
- Update this checklist when adding new features
- Keep it in sync with actual setup state
- Review periodically to ensure accuracy

---

**Last Updated:** December 4, 2025
**Template Version:** 1.0
**Maintained By:** Development Team
