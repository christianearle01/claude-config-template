# Registry Operations Guide

Detailed guide for working with the projects registry at `~/.claude/projects-registry.json`.

---

## Table of Contents

1. [Reading the Registry](#reading-the-registry)
2. [Filtering & Querying](#filtering--querying)
3. [Status Interpretation](#status-interpretation)
4. [Integration with CLI](#integration-with-cli)
5. [Common Patterns](#common-patterns)

---

## Reading the Registry

### File Location
`~/.claude/projects-registry.json` in user's home directory

### Reading Approaches

**Method 1: Direct JSON Read**
```bash
cat ~/.claude/projects-registry.json
```

**Method 2: Pretty Print**
```bash
cat ~/.claude/projects-registry.json | python -m json.tool
```

**Method 3: Using jq**
```bash
cat ~/.claude/projects-registry.json | jq '.'
```

### In Claude Code Skill

When this skill activates, it uses the Read tool:
```
Read: ~/.claude/projects-registry.json
```

The skill automatically parses JSON and extracts relevant information based on user query.

---

## Filtering & Querying

### By Status

**Find outdated projects:**
```bash
jq '.projects[] | select(.status == "outdated")' ~/.claude/projects-registry.json
```

**Find up-to-date projects:**
```bash
jq '.projects[] | select(.status == "up-to-date")' ~/.claude/projects-registry.json
```

**Count by status:**
```bash
jq '[.projects[] | .status] | group_by(.) | map({status: .[0], count: length})' ~/.claude/projects-registry.json
```

### By Tags

**Find production projects:**
```bash
jq '.projects[] | select(.tags[] == "production")' ~/.claude/projects-registry.json
```

**Find React projects:**
```bash
jq '.projects[] | select(.tags[] == "react")' ~/.claude/projects-registry.json
```

**Projects with multiple tags (production AND react):**
```bash
jq '.projects[] | select((.tags | contains(["production"])) and (.tags | contains(["react"])))' ~/.claude/projects-registry.json
```

### By Version

**Find specific version:**
```bash
jq '.projects[] | select(.templateVersion == "3.2.0")' ~/.claude/projects-registry.json
```

**Find versions older than 3.0.0:**
```bash
jq '.projects[] | select(.templateVersion | split(".")[0] | tonumber < 3)' ~/.claude/projects-registry.json
```

### By Name or Path

**Find by name:**
```bash
jq '.projects[] | select(.name | contains("ClientA"))' ~/.claude/projects-registry.json
```

**Find by path:**
```bash
jq '.projects[] | select(.path | contains("client-a"))' ~/.claude/projects-registry.json
```

### In Claude Code Skill

The skill handles filtering automatically based on natural language:

**User:** "Show production projects"
→ Skill filters: `projects.filter(p => p.tags.includes('production'))`

**User:** "What's outdated?"
→ Skill filters: `projects.filter(p => p.status === 'outdated')`

---

## Status Interpretation

### Status Values

| Status | Meaning | User Action |
|--------|---------|-------------|
| `up-to-date` | Project template version matches current version | ✅ No action needed |
| `outdated` | Project template version is behind current version | ⚠️ Update recommended |
| `unknown` | Template version could not be detected | ❓ Manual check needed |

### Status Calculation Logic

Status is calculated by comparing `projectVersion` to `currentVersion`:

```javascript
function calculateStatus(projectVersion, currentVersion) {
  if (!projectVersion) return "unknown";
  if (projectVersion === currentVersion) return "up-to-date";
  if (compareVersions(projectVersion, currentVersion) < 0) return "outdated";
  return "up-to-date";
}
```

### Version Comparison

Versions use semantic versioning (MAJOR.MINOR.PATCH):
- `3.2.0` < `3.3.0` (outdated)
- `3.3.0` = `3.3.0` (up-to-date)
- `2.9.0` < `3.0.0` (outdated, major version behind)

### Priority Ranking

When multiple projects are outdated, prioritize by:

1. **Tag priority:** `production` > `staging` > `personal`
2. **Version gap:** More versions behind = higher priority
3. **Last updated:** Older = higher priority

**Example:**
```
HIGH: ClientB API (v3.0.0 → v3.3.0, production, 3 versions behind)
MEDIUM: Staging App (v3.2.0 → v3.3.0, staging, 1 version behind)
LOW: Learning Project (v2.7.0 → v3.3.0, personal, 6 versions behind)
```

---

## Integration with CLI

### Skill → CLI Handoff

The skill is READ-ONLY. For write operations, it recommends CLI commands:

**User:** "Remove the old project"

**Skill Response:**
```
To remove a project from the registry:
  ./scripts/claude-projects.sh remove <project-id>

First, get the project ID:
  ./scripts/claude-projects.sh list

Then remove it (creates backup automatically).
```

### CLI Commands Reference

**Interactive Wizard:**
```bash
./scripts/register-project.sh
```
- Guided registration with validation
- Auto-detects template version
- Prevents duplicates
- Creates backups

**CLI Tool:**
```bash
# List all projects (table format)
./scripts/claude-projects.sh list

# List with JSON output
./scripts/claude-projects.sh list --format json

# Show outdated projects
./scripts/claude-projects.sh outdated

# Add project
./scripts/claude-projects.sh add "Project Name" ~/path/to/project

# Update project version
./scripts/claude-projects.sh update <project-id>

# Sync all versions automatically
./scripts/claude-projects.sh sync

# Remove project
./scripts/claude-projects.sh remove <project-id>

# Show project details
./scripts/claude-projects.sh show <project-id>
```

### When to Use Each Approach

**Use Skill (Natural Language):**
- Quick status checks
- Filtering and discovery
- Understanding registry state
- Getting recommendations

**Use CLI (Commands):**
- Adding new projects
- Updating versions
- Removing projects
- Bulk operations
- Automation/scripting

---

## Common Patterns

### Pattern 1: Status Dashboard

**User Query:** "Give me a dashboard of all my projects"

**Skill Response:**
```
📊 Projects Dashboard:

Total Projects: 5
✅ Up-to-date: 3 (60%)
⚠️  Outdated: 2 (40%)

Production Status:
- ClientA: ✅ v3.3.0
- ClientB: ⚠️ v3.0.0 (needs update)
- ClientC: ✅ v3.3.0

Personal Projects:
- Blog: ✅ v3.3.0
- Learning: ⚠️ v2.7.0
```

**Implementation:**
```javascript
// Read registry
const registry = JSON.parse(readFile('~/.claude/projects-registry.json'));

// Calculate stats
const total = registry.projects.length;
const upToDate = registry.projects.filter(p => p.status === 'up-to-date').length;
const outdated = registry.projects.filter(p => p.status === 'outdated').length;

// Group by tags
const production = registry.projects.filter(p => p.tags.includes('production'));
const personal = registry.projects.filter(p => p.tags.includes('personal'));
```

---

### Pattern 2: Update Prioritization

**User Query:** "What should I update first?"

**Skill Response:**
```
Update Priority (highest to lowest):

🔴 HIGH: ClientB API
   - Production project
   - 3 versions behind (v3.0.0 → v3.3.0)
   - Last updated 45 days ago
   - Path: ~/Developer/client-b-api

🟡 MEDIUM: Staging App
   - Staging project
   - 1 version behind (v3.2.0 → v3.3.0)
   - Last updated 10 days ago
   - Path: ~/Developer/staging-app

To update:
  cd ~/Developer/client-b-api
  ./scripts/claude-update.sh --apply
```

**Implementation:**
```javascript
// Filter outdated projects
const outdated = registry.projects.filter(p => p.status === 'outdated');

// Calculate priority score
outdated.forEach(project => {
  let score = 0;

  // Tag priority
  if (project.tags.includes('production')) score += 100;
  else if (project.tags.includes('staging')) score += 50;

  // Version gap
  const gap = calculateVersionGap(project.templateVersion, currentVersion);
  score += gap * 10;

  // Age
  const daysSinceUpdate = calculateDaysSince(project.lastUpdated);
  score += daysSinceUpdate;

  project.priorityScore = score;
});

// Sort by priority
outdated.sort((a, b) => b.priorityScore - a.priorityScore);
```

---

### Pattern 3: Technology Stack Overview

**User Query:** "Show me my React projects"

**Skill Response:**
```
React Projects (3):

✅ ClientA Dashboard (v3.3.0, production)
   ~/Developer/client-a-dashboard
   Tags: production, react, typescript, client

⚠️  ClientB Portal (v3.1.0, outdated)
   ~/Developer/client-b-portal
   Tags: staging, react, javascript

✅ Personal Blog (v3.3.0, up-to-date)
   ~/Sites/personal-blog
   Tags: personal, react, nextjs

Note: ClientB Portal needs updating (v3.1.0 → v3.3.0)
```

**Implementation:**
```javascript
// Filter by tag
const reactProjects = registry.projects.filter(p =>
  p.tags.includes('react')
);

// Group by status
const upToDate = reactProjects.filter(p => p.status === 'up-to-date');
const outdated = reactProjects.filter(p => p.status === 'outdated');

// Sort by priority (production first, then alphabetical)
reactProjects.sort((a, b) => {
  if (a.tags.includes('production') && !b.tags.includes('production')) return -1;
  if (!a.tags.includes('production') && b.tags.includes('production')) return 1;
  return a.name.localeCompare(b.name);
});
```

---

### Pattern 4: Project Discovery

**User Query:** "Where is the dashboard project?"

**Skill Response:**
```
Found: ClientA Dashboard
Path: ~/Developer/client-a-dashboard
Status: ✅ up-to-date (v3.3.0)
Tags: production, react, typescript, client
Notes: Main client dashboard with analytics

To navigate:
  cd ~/Developer/client-a-dashboard
```

**Implementation:**
```javascript
// Search by name (case-insensitive)
const searchTerm = 'dashboard'.toLowerCase();
const matches = registry.projects.filter(p =>
  p.name.toLowerCase().includes(searchTerm) ||
  p.path.toLowerCase().includes(searchTerm) ||
  p.notes?.toLowerCase().includes(searchTerm)
);

// If multiple matches, rank by relevance
if (matches.length > 1) {
  matches.sort((a, b) => {
    // Exact name match ranks higher
    const aExact = a.name.toLowerCase() === searchTerm;
    const bExact = b.name.toLowerCase() === searchTerm;
    if (aExact && !bExact) return -1;
    if (!aExact && bExact) return 1;

    // Production projects rank higher
    const aProd = a.tags.includes('production');
    const bProd = b.tags.includes('production');
    if (aProd && !bProd) return -1;
    if (!aProd && bProd) return 1;

    // Alphabetical
    return a.name.localeCompare(b.name);
  });
}
```

---

### Pattern 5: Proactive Context

**User mentions multiple projects without asking about registry**

**User:** "I'm juggling ClientA and ClientB projects today..."

**Skill:** (Auto-activates, reads registry)
```
I see you're working on:

✅ ClientA Dashboard (v3.3.0, up-to-date)
   ~/Developer/client-a-dashboard

⚠️  ClientB API (v3.0.0, outdated)
   ~/Developer/client-b-api

Note: ClientB is 3 versions behind. Want to update it while you're working on it?
```

**Implementation:**
- Skill detects project names in user message
- Automatically reads registry
- Provides relevant context without being asked
- Offers helpful suggestions

---

## Advanced Operations

### Bulk Status Check

Check status of all projects in one query:

```bash
./scripts/claude-projects.sh sync
```

This:
1. Loops through all registered projects
2. Reads `version.json` from each project path
3. Compares to current template version
4. Updates status field automatically
5. Updates `lastSync` timestamp

### Registry Backup

The registry is automatically backed up before modifications:

```bash
~/.claude/projects-registry.json.bak
```

To restore:
```bash
cp ~/.claude/projects-registry.json.bak ~/.claude/projects-registry.json
```

### Migration from Old Versions

If upgrading from a version without registry:

```bash
# Create registry
./scripts/register-project.sh

# Register existing projects manually
./scripts/claude-projects.sh add "Project 1" ~/path/to/project1
./scripts/claude-projects.sh add "Project 2" ~/path/to/project2

# Auto-detect versions
./scripts/claude-projects.sh sync
```

---

## Troubleshooting

### Registry Not Found

```
Error: Registry file not found at ~/.claude/projects-registry.json
```

**Solution:**
```bash
./scripts/register-project.sh
```

### Invalid JSON

```
Error: JSON parse error in registry
```

**Solution:**
```bash
# Validate JSON
cat ~/.claude/projects-registry.json | python -m json.tool

# If errors, restore from backup
cp ~/.claude/projects-registry.json.bak ~/.claude/projects-registry.json
```

### Project Path Not Found

```
Warning: Project path does not exist: ~/Developer/old-project
```

**Solution:**
```bash
# Update path if project moved
./scripts/claude-projects.sh update <project-id>

# Or remove if project deleted
./scripts/claude-projects.sh remove <project-id>
```

### Version Detection Failed

```
Warning: Could not detect version for project
Status: unknown
```

**Solution:**
```bash
# Check if version.json exists in project
cat ~/path/to/project/version.json

# If missing, update manually
./scripts/claude-projects.sh update <project-id>
```

---

## See Also

- **Main Skill Documentation:** `SKILL.md` (parent directory)
- **Sample Queries:** `examples/sample-queries.md`
- **Schema Example:** `examples/sample-registry.json`
- **User Guide:** `01_global-setup/nice-to-have/05_projects-registry.md`

---

**Version:** 3.3.0
**Last Updated:** 2025-12-12
