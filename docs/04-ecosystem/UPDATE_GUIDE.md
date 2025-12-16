# Quick Update Guide - Project-Based Setup

**For:** Updating 02_project-onboarding configs in existing projects

---

## 🚀 Quick Update Commands

### Check What Needs Updating

```bash
# Check template version
cat version.json | grep version

# Check your project's CLAUDE.md version
grep "Version:" CLAUDE.md
```

### Update Project Setup (Automated)

```bash
# From template root directory
./scripts/claude-update.sh --check    # See what's new
./scripts/claude-update.sh --apply    # Apply updates
```

**What it updates:**
- ✅ Custom agents (.claude/agents/)
- ✅ Slash commands (.claude/commands/)
- ✅ Settings template references
- ❌ Preserves: Your CLAUDE.md, memory.json, plans/

---

## 🤖 Interactive Update with Claude

**For:** Get Claude's help to review and selectively apply updates

### Step-by-Step Workflow

**1. Start the update conversation:**

```
Claude, help me update my project's setup from the claude-config-template.

Please compare:
- Custom agents (.claude/agents/)
- Slash commands (.claude/commands/)
- CLAUDE.md structure
- Settings (.claude/settings.json)

Show me what's new or changed in the template, categorized as Recommended vs Optional.
```

**2. Claude will analyze and present changes like:**

```
I'll analyze your project against the template. Here's what I found:

## Recommended Updates

### Custom Agents
- ✨ NEW: prompt-polisher.md - Enhanced prompt optimization (v2.4.0)
- 📝 UPDATED: project-planner.md - Added 6-perspective analysis

### Slash Commands
- ✨ NEW: /review - Code review command
- ✨ NEW: /standards - Quick reference to coding standards

### CLAUDE.md Structure
- Missing section: "## Common Commands"
- Missing section: "## Testing Requirements"

## Optional Updates

### Settings
- New feature: "chat.codeAutoReview": true (auto-review on save)
- New feature: "memory.summarize": "incremental" (better context)

Would you like me to show you diffs for any of these?
```

**3. Review specific changes:**

```
Claude, show me the diff for the prompt-polisher agent.
```

Claude will show:
```diff
+ NEW FILE: .claude/agents/prompt-polisher.md
+
+ This agent uses 14 comprehensive techniques to optimize your prompts:
+ - Tier 1: Context (CLAUDE.md reading, project awareness)
+ - Tier 2: Structure (task breakdown, examples)
+ - Tier 3: Advanced (constraints, validation)
+ ...
```

**4. Accept or reject changes:**

```
Claude:
- Accept: prompt-polisher agent
- Accept: /review command
- Reject: /standards command (we have our own)
- Accept: CLAUDE.md "Common Commands" section
- Reject: Settings changes (not ready yet)

Please apply the accepted changes.
```

**5. Claude applies changes:**

Claude will:
- Copy accepted agents/commands from template
- Show you the new CLAUDE.md section to add
- Skip rejected changes
- Confirm what was applied

---

### Example Prompts for Claude

**Full analysis:**
```
Claude, analyze my project setup and tell me what's outdated
compared to the template. Categorize as Recommended vs Optional.
```

**Specific file type:**
```
Claude, check if my custom agents are up to date. Show me
what's new in the template that I don't have.
```

**With diffs:**
```
Claude, compare my .claude/settings.json with the template.
Show me diffs for any new settings I'm missing.
```

**Apply specific changes:**
```
Claude, I want to add the prompt-polisher agent from the template.
Please:
1. Show me what it does
2. Copy it to my project
3. Tell me how to use it
```

---

### What Claude Can Help With

✅ **Claude can:**
- Compare files between template and your project
- Show diffs of what changed
- Explain what each change does
- Copy approved files for you
- Update your CLAUDE.md with new sections
- Validate JSON syntax in settings

⚠️ **Claude will:**
- Preserve your existing CLAUDE.md content
- Not overwrite memory.json, plans/, or config.json
- Ask before making changes
- Show you what it's doing

❌ **Claude won't:**
- Auto-update without your approval
- Modify files containing your project-specific data
- Push changes to git (you control commits)

---

### Tips for Best Results

1. **Be specific about scope:**
   - "Check custom agents only" vs "Check everything"

2. **Ask for explanations:**
   - "Why is this change recommended?"
   - "What will break if I skip this update?"

3. **Review before accepting:**
   - Always ask to see diffs for major changes
   - Test after applying updates

4. **Use version context:**
   - "I'm on v2.4.0, what's new in v4.5.2?"
   - Helps Claude prioritize important changes

5. **Iterate:**
   - You don't need to accept everything at once
   - Update in phases: agents first, then commands, then settings

---

### Example Full Session

**User:**
```
Claude, I haven't updated my project setup in a while. My CLAUDE.md
says v2.3.0 and the template is now v4.5.2. Please analyze what I'm
missing and categorize as Recommended vs Optional.
```

**Claude:**
```
I'll compare your v2.3.0 setup against template v4.5.2...

## Recommended (3 releases behind)

### Critical Updates:
- prompt-polisher agent (v2.4.0) - 14 techniques, 50-80% token savings
- project-planner agent (v2.3.0) - 6-perspective analysis before coding

### New Commands:
- /review - Code review against standards
- /test - Run tests with proper reporting

### CLAUDE.md Sections:
- "Common Commands" section - Quick CLI reference
- "Version History" section - Track your project evolution

## Optional

### Settings Enhancements:
- chat.codeAutoReview - Auto-review on save (experimental)
- memory.summarize: "incremental" - Better context management

Would you like me to show diffs for the recommended updates?
```

**User:**
```
Yes, show me the prompt-polisher diff.
```

**Claude:**
```
[Shows detailed diff...]

This agent is highly recommended because:
- Saves 50-80% tokens on complex prompts
- Teaches prompt engineering while polishing
- Uses your CLAUDE.md for project context

Would you like me to add it to your project?
```

**User:**
```
Yes, add it. Also add the /review and /test commands. Skip the
settings changes for now.
```

**Claude:**
```
I'll apply these changes:
✅ Adding prompt-polisher agent...
✅ Adding /review command...
✅ Adding /test command...
⏭️ Skipping settings changes

Done! Your project now has:
- .claude/agents/prompt-polisher.md
- .claude/commands/review.md
- .claude/commands/test.md

Try it: Type "polish this prompt..." in any conversation.

Would you like me to update your CLAUDE.md to track this update?
```

---

### Update Project Setup (Manual)

**If automated update isn't suitable:**

#### 1. Update CLAUDE.md Template
```bash
# Compare your CLAUDE.md with latest template
diff CLAUDE.md templates/CLAUDE.md.template

# Manually merge new sections you want
```

#### 2. Update Custom Agents
```bash
# Copy new/updated agents from template
cp -r /path/to/template/.claude/agents/* .claude/agents/

# Keep your custom agents, skip if they already exist
cp -n /path/to/template/.claude/agents/* .claude/agents/
```

#### 3. Update Slash Commands
```bash
# Copy new/updated commands
cp -r /path/to/template/.claude/commands/* .claude/commands/
```

#### 4. Update Settings Reference
```bash
# Review settings for new features
diff .claude/settings.json /path/to/template/.claude/settings.json

# Merge new settings manually
```

---

## 🔧 Common Update Scenarios

### Scenario 1: Add New Agent to Existing Project
```bash
# Example: Add prompt-polisher agent
cp /path/to/template/.claude/agents/prompt-polisher.md .claude/agents/
```

### Scenario 2: Update Existing Agent
```bash
# Backup your version first
cp .claude/agents/prompt-polisher.md .claude/agents/prompt-polisher.md.backup

# Copy new version
cp /path/to/template/.claude/agents/prompt-polisher.md .claude/agents/

# Review differences
diff .claude/agents/prompt-polisher.md.backup .claude/agents/prompt-polisher.md
```

### Scenario 3: Add New Slash Command
```bash
# Example: Add /review command
cp /path/to/template/.claude/commands/review.md .claude/commands/
```

### Scenario 4: Sync CLAUDE.md Structure (Keep Your Content)
```bash
# Review new CLAUDE.md sections
cat templates/CLAUDE.md.template | grep "^##"

# Manually add missing sections to your CLAUDE.md
# Keep your project-specific content intact
```

---

## 🎯 What to Update vs Keep

### ✅ Safe to Update (No Data Loss)
- Custom agents (unless you customized them)
- Slash commands (unless you customized them)
- Settings template structure
- Hook examples

### ⚠️ Review Before Updating
- .claude/settings.json (may have your customizations)
- Custom agents you've modified
- Slash commands you've customized

### ❌ Never Overwrite
- CLAUDE.md (your project memory)
- .claude/memory.json (conversation history)
- .claude/plans/ (your plans)
- .claude/config.json (your API keys)

---

## 🔄 Rollback

**If update breaks something:**

```bash
# Restore from backup (if using automated update)
./scripts/claude-update.sh --rollback

# Manual rollback
cd ~/.claude/backups/
ls -lt    # Find latest backup
# Copy files back manually
```

---

## 📋 Update Checklist

- [ ] Check current version: `cat version.json`
- [ ] Backup current setup: `cp -r .claude .claude.backup`
- [ ] Run update: `./scripts/claude-update.sh --apply`
- [ ] Test: Verify agents/commands work
- [ ] Check CLAUDE.md: Ensure your content is intact
- [ ] Verify settings: .claude/settings.json still valid

---

## 🆘 Troubleshooting

**Update script not found?**
```bash
# You're in a project directory, not template root
cd /path/to/claude-config-template
./scripts/claude-update.sh --apply
```

**Settings not loading?**
```bash
# Validate JSON syntax
cat .claude/settings.json | python -m json.tool
```

**Agent not working after update?**
```bash
# Check file permissions
ls -la .claude/agents/

# Ensure files are readable
chmod 644 .claude/agents/*.md
```

---

## 📚 Related Documentation

- **Version History**: See `CHANGELOG.md` for what changed
- **Setup Reference**: See `.claude/SETUP_CONTEXT.md` for quick setup help

---

*Quick Update Guide - Part of Claude Code Configuration Template v4.5.2*
*Last updated: 2025-12-08*
