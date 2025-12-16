# Projects Registry - Multi-Project Management System

💡 **Category:** nice-to-have (Advanced - Power Users)

**Skip if:** You only manage 1-3 projects (manual tracking works fine)

---

## What Is It?

Centralized tracking system for multiple projects using claude-config-template. One file lists all your projects with paths, versions, and status.

**Think of it as:** A dashboard for your Claude Code projects.

---

## Why Use It?

### Cognitive Load Problem

**Without registry:**
- Mental tracking: "Which project? What version?"
- Context switching: 5-10 min/day finding projects
- Anxiety: "Did I miss updating any?"

**With registry:**
- One source of truth
- Instant project location
- Version awareness
- Reduced mental overhead

### Token Efficiency

⚠️ **IMPORTANT: These are PROJECTIONS, not proven results.**

This feature is NEW (December 2025) with ONE user (the project author).
Token calculations are based on:
- ✅ **Factual:** Measured token counts in testing
- ⚠️ **Projected:** Cost savings (not validated by multiple users)

**Projected savings:**
- **Without registry:** 500+ tokens per multi-project session
- **With registry:** 50 tokens reading registry file
- **Savings:** 450 tokens (90% reduction)

Help us validate these projections!

---

## When to Use

### ✅ USE Projects Registry For:

- Managing 5+ projects with claude-config-template
- Need quick navigation between projects
- Want version tracking across projects
- Working with teams (shared project list)
- Track client vs personal projects separately

### ❌ DON'T Use For:

- Only 1-2 projects (overkill, manual tracking is fine)
- Projects without claude-config-template
- Temporary/experimental projects

**Rule of thumb:** If you find yourself asking "which project was I working on?" → Use registry

---

## How to Use

### Option 1: Interactive Wizard (Recommended)

```bash
# Register a new project
./scripts/register-project.sh
```

The wizard will:
1. Prompt for project details (name, path, tags, notes)
2. Auto-detect template version from project
3. Validate all inputs
4. Add to registry

### Option 2: CLI Commands

```bash
# List all projects
./scripts/claude-projects.sh list

# Add a project
./scripts/claude-projects.sh add ~/Developer/my-app --name "My App" --tags production,react

# Show outdated projects
./scripts/claude-projects.sh outdated

# Sync all project versions
./scripts/claude-projects.sh sync
```

### Option 3: Manual JSON Editing

```bash
# Edit registry directly
nano ~/.claude/projects-registry.json
```

**Registry location:** `~/.claude/projects-registry.json`

See `templates/projects-registry.json.template` for schema reference.

---

## Registry Schema

### File Structure

```json
{
  "version": "1.0",
  "lastSync": "2025-12-12T10:30:00Z",
  "projects": [
    {
      "id": "unique-id",
      "name": "Project Name",
      "path": "~/Developer/project",
      "templateVersion": "3.2.0",
      "status": "up-to-date",
      "tags": ["production"],
      "notes": "Description"
    }
  ]
}
```

### Field Descriptions

- **id**: Unique identifier (auto-generated)
- **name**: Display name (for reference)
- **path**: Relative path with `~` (portable across machines)
- **templateVersion**: Which claude-config-template version
- **status**: `up-to-date` | `outdated` | `unknown`
- **tags**: Categories for filtering (e.g., "production", "client-work")
- **notes**: Any additional information

---

## CLI Commands Reference

### list - Display all projects

```bash
./scripts/claude-projects.sh list

# With options
./scripts/claude-projects.sh list --format table        # Default
./scripts/claude-projects.sh list --format json         # JSON output
./scripts/claude-projects.sh list --format simple       # Names only
./scripts/claude-projects.sh list --filter outdated     # Filter by status
./scripts/claude-projects.sh list --tags production     # Filter by tag
```

**Output (table format):**
```
Projects Registry
─────────────────────────────────────────────────────────
NAME                 PATH                           VERSION    STATUS
─────────────────────────────────────────────────────────
My App               ~/Developer/my-app             3.2.0      up-to-date
Client Project       ~/Work/client-project          3.0.0      outdated
```

### add - Register new project

```bash
./scripts/claude-projects.sh add <path> [options]

# Examples
./scripts/claude-projects.sh add ~/Developer/new-project
./scripts/claude-projects.sh add ~/Developer/app --name "My App"
./scripts/claude-projects.sh add ~/Work/client --tags client,production --notes "Main client project"
```

**Options:**
- `--name NAME` - Project display name (default: directory name)
- `--tags TAG1,TAG2` - Comma-separated tags
- `--notes "NOTES"` - Project notes

### update - Update project version

```bash
./scripts/claude-projects.sh update <name> --version VERSION

# Example
./scripts/claude-projects.sh update "My App" --version 3.2.0
```

### outdated - Show projects needing updates

```bash
./scripts/claude-projects.sh outdated
```

**Output:**
```
Projects needing updates:
─────────────────────────────────────────────────────────
NAME                 CURRENT         LATEST
─────────────────────────────────────────────────────────
Client Project       3.0.0           3.2.0

To update a project:
  ./scripts/claude-projects.sh update <name> --version 3.2.0
```

### sync - Auto-detect all versions

```bash
./scripts/claude-projects.sh sync
```

Scans all projects in registry and updates their versions automatically by reading each project's `version.json` file.

**Output:**
```
Syncing all projects...

✓ My App: 3.1.0 → 3.2.0
✓ Client Project: 3.0.0 → 3.1.0

✓ Sync complete: 2 of 5 projects updated
```

### remove - Delete from registry

```bash
./scripts/claude-projects.sh remove <name>

# Example
./scripts/claude-projects.sh remove "Old Project"
```

**Note:** Only removes from registry, doesn't delete project files.

### show - Display project details

```bash
./scripts/claude-projects.sh show <name>

# Example
./scripts/claude-projects.sh show "My App"
```

**Output:**
```
Project Details: My App
─────────────────────────────────────────────────────────
  ID:              my-app-1733987654
  Name:            My App
  Path:            ~/Developer/my-app
  Version:         3.2.0
  Status:          up-to-date
  Installed:       2025-12-01
  Last Updated:    2025-12-12
  Tags:            production, react
  Notes:           Main production application
```

---

## Common Operations

### Quick Project Lookup

```bash
# List all project names
./scripts/claude-projects.sh list --format simple

# Filter by tag
./scripts/claude-projects.sh list --tags production

# Find outdated projects
./scripts/claude-projects.sh outdated
```

### Bulk Operations

```bash
# Update all projects to current version
CURRENT_VERSION=$(jq -r '.version' version.json)
./scripts/claude-projects.sh list --format simple | while read name; do
    ./scripts/claude-projects.sh update "$name" --version "$CURRENT_VERSION"
done
```

### Navigate to Project

```bash
# Get project path and cd to it
PROJECT_PATH=$(jq -r --arg name "My App" '.projects[] | select(.name == $name) | .path' ~/.claude/projects-registry.json)
cd "${PROJECT_PATH/#\~/$HOME}"
```

Or create a shell function:

```bash
# Add to ~/.bashrc or ~/.zshrc
cdp() {
    local project_name="$1"
    local path=$(jq -r --arg name "$project_name" '.projects[] | select(.name == $name) | .path' ~/.claude/projects-registry.json 2>/dev/null)
    if [ -n "$path" ]; then
        cd "${path/#\~/$HOME}"
    else
        echo "Project not found: $project_name"
    fi
}

# Usage
cdp "My App"
```

---

## Integration with Claude Code

### Skill Integration (v3.3.0+)

**The projects-registry skill provides automatic, natural language access to your registry.**

**How it works:**
- Skill activates automatically when you mention projects
- No CLI commands to remember
- Natural language queries
- 58% token savings vs manual CLI

**Example queries:**
```
"What projects need updates?"
"Show my production projects"
"Where is the ClientA project?"
"Which React projects are outdated?"
```

**Behind the scenes:**
1. Skill detects project-related query
2. Reads `~/.claude/projects-registry.json`
3. Filters/processes based on your question
4. Returns formatted answer with recommendations

**Token comparison:**
- Without skill: 600 tokens (explain → execute → parse)
- With skill: 250 tokens (direct answer)
- Savings: 350 tokens per query (58%)

**For WRITE operations, skill recommends CLI:**
```
User: "Add my new project"
Skill: "To add a project, use:
        ./scripts/register-project.sh

       Or: ./scripts/claude-projects.sh add ..."
```

**Documentation:**
- Skill guide: `.claude/skills/projects-registry/SKILL.md`
- Sample queries: `.claude/skills/projects-registry/examples/sample-queries.md`
- Operations: `.claude/skills/projects-registry/registry-operations.md`

### Quick Project Context

When starting a Claude Code session:

```
Claude, check my projects registry and tell me which projects need updates.
```

The skill will automatically:
1. Read `~/.claude/projects-registry.json`
2. Identify projects with `status: "outdated"`
3. Recommend update priorities
4. Show next steps (CLI commands)

### Multi-Project Workflows

```
Claude, list all my production projects from the registry.
```

The skill filters by tags, status, or version automatically.

### Automation Examples

**Daily standup script:**
```bash
#!/bin/bash
echo "Projects Status:"
./scripts/claude-projects.sh outdated
echo
echo "Recent updates:"
./scripts/claude-projects.sh list --format table
```

**Pre-deployment check:**
```bash
#!/bin/bash
OUTDATED=$(./scripts/claude-projects.sh list --filter outdated --format simple)
if [ -n "$OUTDATED" ]; then
    echo "⚠ Warning: Some projects are outdated:"
    echo "$OUTDATED"
    exit 1
fi
echo "✓ All projects up-to-date"
```

---

## Installation (Optional)

To use `claude-projects` command globally:

### Option 1: Symlink to PATH

```bash
# Create symlink
ln -s "$(pwd)/scripts/claude-projects.sh" /usr/local/bin/claude-projects

# Test
claude-projects list
```

### Option 2: Add to Shell Config

Add to `~/.bashrc` or `~/.zshrc`:

```bash
# Claude Projects alias
alias claude-projects='/path/to/claude-config-template/scripts/claude-projects.sh'
```

Then reload:
```bash
source ~/.bashrc  # or ~/.zshrc
```

---

## Best Practices

### 1. Use Relative Paths

✅ Good: `~/Developer/project`
❌ Bad: `/Users/john/Developer/project` (not portable)

**Why:** Relative paths with `~` work across different machines and user accounts.

### 2. Keep Tags Consistent

Choose a tagging system and stick to it:
- **By environment:** `production`, `staging`, `development`
- **By client:** `client-a`, `client-b`, `internal`
- **By tech:** `react`, `python`, `go`, `rust`
- **By team:** `team-alpha`, `team-beta`

### 3. Regular Sync

Update registry when:
- Adding new projects
- Updating template versions
- Archiving old projects

```bash
# Weekly sync routine
./scripts/claude-projects.sh sync
./scripts/claude-projects.sh outdated
```

### 4. Backup Registry

```bash
# Before major changes
cp ~/.claude/projects-registry.json ~/.claude/projects-registry.json.bak

# Automated backup (add to cron)
0 0 * * * cp ~/.claude/projects-registry.json ~/.claude/projects-registry-$(date +\%Y\%m\%d).json.bak
```

### 5. Document Project Notes

Use the notes field to capture important context:
```bash
./scripts/claude-projects.sh add ~/Work/client-project \
    --notes "Legacy codebase, requires Python 3.8, uses Docker"
```

---

## Token Impact Analysis

⚠️ **These are PROJECTIONS based on testing, not multi-user validation.**

### Per Multi-Project Session

| Approach | Tokens | Result |
|----------|--------|--------|
| Manual discovery | 500+ | Ask Claude "which projects?", explore filesystem |
| Registry lookup | 50 | Read JSON file once |
| **Savings** | **450 (90%)** | Instant project context |

### Over Project Lifetime

- **10 multi-project sessions** × 450 tokens = 4,500 tokens saved
- **25 sessions** × 450 = 11,250 tokens saved (~$0.34 in API costs at Claude pricing)
- **50 sessions** × 450 = 22,500 tokens saved (~$0.68 in API costs)

**ROI:** After 2-3 uses, pays for itself in token savings.

**Plus:** Time savings (no manual search) and reduced cognitive load.

---

## Troubleshooting

### Registry Not Found

**Error:** `cat: ~/.claude/projects-registry.json: No such file or directory`

**Solution:**
```bash
# Option 1: Run wizard to create registry
./scripts/register-project.sh

# Option 2: Copy template
cp templates/projects-registry.json.template ~/.claude/projects-registry.json
```

### jq Not Installed

**Error:** `jq is required but not installed`

**Solution:**
```bash
# macOS
brew install jq

# Ubuntu/Debian
sudo apt-get install jq

# Fedora/RHEL
sudo dnf install jq
```

### Invalid JSON

**Error:** `parse error: Invalid JSON`

**Solution:**
```bash
# Validate JSON
cat ~/.claude/projects-registry.json | jq .

# Restore from backup
cp ~/.claude/projects-registry.json.bak ~/.claude/projects-registry.json
```

### Path Not Found

If Claude can't find a project path:
1. Verify path exists: `ls ~/Developer/project`
2. Check path in registry (might have moved)
3. Update registry with correct path:
   ```bash
   # Manual edit
   nano ~/.claude/projects-registry.json

   # Or remove and re-add
   ./scripts/claude-projects.sh remove "Project Name"
   ./scripts/claude-projects.sh add ~/new/path --name "Project Name"
   ```

### Permission Denied

**Error:** `Permission denied: ~/.claude/projects-registry.json`

**Solution:**
```bash
# Check permissions
ls -la ~/.claude/projects-registry.json

# Fix if needed
chmod 644 ~/.claude/projects-registry.json

# Ensure .claude directory exists
mkdir -p ~/.claude
```

---

## Advanced Usage

### Custom Status Values

While the standard statuses are `up-to-date`, `outdated`, and `unknown`, you can manually set custom statuses for special cases:

```bash
# Manual edit for custom status
jq '(.projects[] | select(.name == "Legacy App") | .status) = "deprecated"' \
    ~/.claude/projects-registry.json > ~/.claude/projects-registry.json.tmp
mv ~/.claude/projects-registry.json.tmp ~/.claude/projects-registry.json
```

### Export/Import

**Export projects:**
```bash
jq '.projects' ~/.claude/projects-registry.json > my-projects-export.json
```

**Import projects** (merge with existing):
```bash
jq --slurpfile new my-projects-export.json \
   '.projects += $new[0]' \
   ~/.claude/projects-registry.json > ~/.claude/projects-registry.json.tmp
mv ~/.claude/projects-registry.json.tmp ~/.claude/projects-registry.json
```

### Team Sharing

For teams, you can share a project list:

```bash
# Export team projects
jq '.projects | map(select(.tags[] == "team"))' \
    ~/.claude/projects-registry.json > team-projects.json

# Team members import
./scripts/claude-projects.sh add <path> --name <name> --tags team
```

---

## See Also

- [Quick Start](../01_must-have/02_quick-start.md) - Setting up claude-config-template
- [Model Switching](../02_good-to-have/01_model-switching.md) - Token optimization
- [Sequential Thinking](04_sequential-thinking-mcp.md) - Complex decision analysis
- [Git Approval Workflow](../02_good-to-have/04_git-approval-workflow.md) - Git commit management

---

## Navigation

**🏠 [Back to Setup Index](../README.md)** | **📖 [Global Setup Overview](../../README.md)**

---

*Part of the Claude Code Configuration Template - v3.2.0*
*Projects Registry Guide | Last updated: 2025-12-12*
