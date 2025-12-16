# Quick Reference: Projects Registry

**Just-in-Time Help** for common projects registry queries

---

## Most Common Queries (90% usage)

### 1. "What projects do I have?"
```
→ Shows all projects with status indicators
→ Emoji guide: ✅ up-to-date, ⚠️ outdated, ❓ unknown
→ Displays: name, version, path, tags
→ Example output: "You have 5 projects registered"
```

**Quick command:**
```bash
./scripts/claude-projects.sh list
```

---

### 2. "Which projects are outdated?"
```
→ Filters to outdated projects only
→ Shows version gap (e.g., "3 versions behind")
→ Priority ranking (production > personal)
→ Update commands included
```

**Quick command:**
```bash
./scripts/claude-projects.sh outdated
```

---

### 3. "Show me project X details"
```
→ Full metadata for specific project
→ Includes: path, status, tags, tech stack, version
→ Shows when last updated
→ Provides navigation command (cd path)
```

**Quick command:**
```bash
./scripts/claude-projects.sh show <project-name>
```

---

### 4. "Show my production projects"
```
→ Filters by tag (production, client, personal, etc.)
→ Works with any tag you've defined
→ Combines filters: "outdated production projects"
```

**Natural language:** Just ask with the tag name!
```
"Show my client projects"
"Which production projects are outdated?"
"List personal projects"
```

---

### 5. "Where is project X?"
```
→ Fuzzy search by name, tag, or notes
→ Returns full path for navigation
→ Works with partial names ("dash" → "client-dashboard")
→ Provides cd command ready to copy
```

**Pro tip:** Search works even if you don't remember exact name!

---

## Pro Tips

### Filtering Shortcuts
- **By status:** "Show outdated projects"
- **By tag:** "Show production projects"
- **Combined:** "Which production projects are outdated?"

### Tag Strategies
```
✅ Good tags:
- "production", "staging", "development" (environment)
- "react", "vue", "node" (technology)
- "client-a", "client-b", "internal" (ownership)
- "active", "archived", "maintenance" (lifecycle)

❌ Avoid:
- Too many tags per project (use 2-4 max)
- Generic tags ("project", "code", "app")
- Duplicate information already in tech stack
```

### Speed Commands
```bash
# List all projects (table format)
./scripts/claude-projects.sh list

# List all projects (JSON format)
./scripts/claude-projects.sh list --format json

# Show statistics
./scripts/claude-projects.sh stats

# Filter outdated only
./scripts/claude-projects.sh outdated
```

---

## When to Update Registry

### ✅ Update When:
- Creating new project with this template
- Project moves to new location (path changes)
- Major tech stack changes (framework migration)
- Project status changes (production → archived)
- Template version updated in project

### ❌ NOT Needed For:
- Day-to-day coding
- Minor dependency updates
- File changes within project
- Git commits/branches
- Code refactoring

### How to Update
```bash
# Interactive wizard (recommended)
./scripts/register-project.sh

# CLI update (if you know project ID)
./scripts/claude-projects.sh update <project-id>

# Bulk sync all versions
./scripts/claude-projects.sh sync
```

---

## Common Scenarios

### Scenario 1: Lost Track of Projects
**Problem:** "I have multiple projects but forgot where they are"

**Solution:**
```
Ask: "What projects do I have?"
→ See all 5 projects with paths
→ Copy `cd` command for desired project
→ Navigate instantly
```

**Time saved:** 5-10 minutes of searching

---

### Scenario 2: Template Updates
**Problem:** "Which projects need template updates?"

**Solution:**
```
Ask: "Which projects are outdated?"
→ See priority ranking (production first)
→ Note version gaps (3.0.0 → 3.4.0 = 4 versions)
→ Run update script on high-priority projects
```

**Time saved:** 15-20 minutes of checking each project manually

---

### Scenario 3: Client Work
**Problem:** "Which client projects am I working on?"

**Solution:**
```
Ask: "Show my client projects"
→ Filtered list with status
→ Identify which need attention
→ Focus work accordingly
```

**Time saved:** 5 minutes of mental recall

---

### Scenario 4: New Team Member
**Problem:** "New dev needs to know our project landscape"

**Solution:**
```
Ask: "Give me a status overview"
→ Total projects, pass rates, outdated count
→ Share output with team member
→ Instant project landscape visibility
```

**Time saved:** 30 minutes of verbal explanation

---

## Integration with Skills

### Projects Registry Skill
The skill provides **automatic natural language access** without CLI commands:

```
You ask: "What's the status of my React projects?"
Skill activates automatically:
→ Filters registry for React tag
→ Shows status for each
→ Recommends updates if needed
```

**Token savings:** 58% (600 → 250 tokens per query)

### Related Skills
- **version-management:** Check version consistency across files
- **commit-readiness-checker:** Validate before commits
- **project-onboarding-assistant:** Setup new projects

---

## Quick Decision Tree

```
Need to... | Use...
-----------|-------
Find project path | "Where is project X?"
Check update status | "Which projects are outdated?"
See all projects | "What projects do I have?"
Filter by type | "Show [tag] projects"
Add new project | ./scripts/register-project.sh
Update project info | ./scripts/claude-projects.sh update
Get statistics | ./scripts/claude-projects.sh stats
```

---

## Troubleshooting

### Issue: "Project not showing"
**Causes:**
- Not registered yet
- Path changed and registry not updated
- Registry file corrupted

**Fix:**
```bash
# Re-register project
./scripts/register-project.sh

# Verify registry file
cat ~/.claude/projects-registry.json | python -m json.tool
```

---

### Issue: "Status shows 'unknown'"
**Causes:**
- No version.json in project
- version.json malformed
- Project not using template

**Fix:**
```bash
# Check if version.json exists
cat /path/to/project/version.json

# If missing, project might not use template
# If exists but malformed, fix JSON syntax
```

---

### Issue: "Registry file not found"
**Cause:** Registry hasn't been created yet

**Fix:**
```bash
# Run registration wizard (creates registry)
./scripts/register-project.sh
```

---

## Additional Resources

- **Full Documentation:** `01_global-setup/03_nice-to-have/05_projects-registry.md`
- **Skill Documentation:** `.claude/skills/projects-registry/SKILL.md`
- **CLI Reference:** `./scripts/claude-projects.sh --help`
- **Schema Example:** `.claude/skills/projects-registry/examples/sample-registry.json`

---

**Last Updated:** 2025-12-15 (v3.5.0)
**Skill:** projects-registry
**Audience:** Users managing 2+ projects
