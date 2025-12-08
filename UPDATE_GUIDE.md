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

- **Full Update System**: See `PHASE3_UPDATES.md` for comprehensive guide
- **Version History**: See `CHANGELOG.md` for what changed
- **Setup Reference**: See `.claude/SETUP_CONTEXT.md` for quick setup help

---

*Quick Update Guide - Part of Claude Code Configuration Template v2.6.0*
*Last updated: 2025-12-08*
