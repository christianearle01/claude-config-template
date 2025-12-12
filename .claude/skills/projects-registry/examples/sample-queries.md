# Sample Queries - Projects Registry Skill

Real-world examples of natural language queries and expected skill responses.

---

## Query Category: Status & Overview

### Query 1: General Status
**User:** "What's the status of my projects?"

**Skill Response:**
```
You have 5 projects registered:

✅ Up-to-date: 3 (60%)
⚠️  Outdated: 2 (40%)

Outdated projects:
- ClientB API (v3.0.0 → v3.3.0)
- Learning Playground (v2.7.0 → v3.3.0)

Would you like to see details on what needs updating?
```

---

### Query 2: Outdated Projects
**User:** "What projects need updates?"

**Skill Response:**
```
2 projects need updates:

🔴 ClientB API (v3.0.0 → v3.3.0)
   Priority: HIGH (production, 3 versions behind)
   ~/Developer/client-b-api
   Last updated: 45 days ago

🟡 Learning Playground (v2.7.0 → v3.3.0)
   Priority: LOW (personal, 6 versions behind)
   ~/Developer/learning-playground
   Last updated: 120 days ago

To update:
  cd <project-path>
  ./scripts/claude-update.sh --apply
```

---

### Query 3: Full List
**User:** "List all my projects"

**Skill Response:**
```
All Projects (5):

Production:
✅ ClientA Dashboard (v3.3.0)
   ~/Developer/client-a-dashboard

⚠️  ClientB API (v3.0.0, outdated)
   ~/Developer/client-b-api

✅ ClientC Portal (v3.3.0)
   ~/Developer/client-c-portal

Personal:
✅ Personal Blog (v3.3.0)
   ~/Sites/personal-blog

⚠️  Learning Playground (v2.7.0, outdated)
   ~/Developer/learning-playground
```

---

## Query Category: Filtering

### Query 4: By Tag (Production)
**User:** "Show my production projects"

**Skill Response:**
```
Production Projects (3):

✅ ClientA Dashboard (v3.3.0, up-to-date)
   ~/Developer/client-a-dashboard
   Tags: production, react, typescript

⚠️  ClientB API (v3.0.0, outdated)
   ~/Developer/client-b-api
   Tags: production, node, api

✅ ClientC Portal (v3.3.0, up-to-date)
   ~/Developer/client-c-portal
   Tags: production, react, dashboard

Note: ClientB API needs updating.
```

---

### Query 5: By Technology
**User:** "Which projects use React?"

**Skill Response:**
```
React Projects (3):

✅ ClientA Dashboard (v3.3.0, production)
   ~/Developer/client-a-dashboard

✅ ClientC Portal (v3.3.0, production)
   ~/Developer/client-c-portal

✅ Personal Blog (v3.3.0, personal)
   ~/Sites/personal-blog

All React projects are up-to-date!
```

---

### Query 6: Multi-Filter
**User:** "Show production React projects"

**Skill Response:**
```
Production React Projects (2):

✅ ClientA Dashboard (v3.3.0)
   ~/Developer/client-a-dashboard
   Tags: production, react, typescript, client

✅ ClientC Portal (v3.3.0)
   ~/Developer/client-c-portal
   Tags: production, react, javascript, dashboard

Both are up-to-date!
```

---

## Query Category: Discovery

### Query 7: Find by Name
**User:** "Where is the ClientA project?"

**Skill Response:**
```
Found: ClientA Dashboard
Path: ~/Developer/client-a-dashboard
Status: ✅ up-to-date (v3.3.0)
Tags: production, react, typescript, client
Notes: Main client dashboard with real-time analytics

To navigate:
  cd ~/Developer/client-a-dashboard
```

---

### Query 8: Find by Partial Name
**User:** "Where's my blog?"

**Skill Response:**
```
Found: Personal Blog
Path: ~/Sites/personal-blog
Status: ✅ up-to-date (v3.3.0)
Tags: personal, react, nextjs, markdown
Notes: Personal website and blog using Next.js

To navigate:
  cd ~/Sites/personal-blog
```

---

### Query 9: Multiple Matches
**User:** "Show client projects"

**Skill Response:**
```
Found 3 projects matching "client":

✅ ClientA Dashboard (v3.3.0, production)
   ~/Developer/client-a-dashboard

⚠️  ClientB API (v3.0.0, production, outdated)
   ~/Developer/client-b-api

✅ ClientC Portal (v3.3.0, production)
   ~/Developer/client-c-portal

Which one would you like to work on?
```

---

## Query Category: Version-Specific

### Query 10: Specific Version
**User:** "What projects are on v3.0.0?"

**Skill Response:**
```
1 project on v3.0.0:

⚠️  ClientB API (v3.0.0, outdated)
   ~/Developer/client-b-api
   3 versions behind (current: v3.3.0)

This project needs updating:
  cd ~/Developer/client-b-api
  ./scripts/claude-update.sh --apply
```

---

### Query 11: Version Range
**User:** "Which projects are behind v3.0.0?"

**Skill Response:**
```
1 project is on a version older than v3.0.0:

⚠️  Learning Playground (v2.7.0)
   ~/Developer/learning-playground
   6 versions behind (current: v3.3.0)
   Last updated: 120 days ago

Consider updating or archiving this project.
```

---

### Query 12: Up-to-Date Check
**User:** "Are all my projects up-to-date?"

**Skill Response:**
```
No, 2 out of 5 projects need updates:

⚠️  ClientB API (v3.0.0 → v3.3.0)
⚠️  Learning Playground (v2.7.0 → v3.3.0)

3 projects are up-to-date ✅

Want to see update priorities?
```

---

## Query Category: Proactive Context

### Query 13: User Mentions Projects
**User:** "I'm working on ClientA and ClientB today"

**Skill:** (Auto-activates)
```
I see you're working on:

✅ ClientA Dashboard (v3.3.0, up-to-date)
   ~/Developer/client-a-dashboard

⚠️  ClientB API (v3.0.0, outdated)
   ~/Developer/client-b-api

Note: ClientB is 3 versions behind. Want to update it while you're working on it?
```

---

### Query 14: Project Confusion
**User:** "I have too many projects and losing track..."

**Skill:** (Auto-activates)
```
Let me help! You have 5 projects registered:

By Status:
- 3 up-to-date ✅
- 2 need updates ⚠️

By Category:
- 3 production (2 up-to-date, 1 outdated)
- 2 personal (1 up-to-date, 1 outdated)

Want to see details on specific projects, or focus on the outdated ones first?
```

---

### Query 15: Implicit Question
**User:** "Haven't touched the learning project in months"

**Skill:** (Auto-activates)
```
Found: Learning Playground
Status: ⚠️ outdated (v2.7.0, 6 versions behind)
Last updated: 120 days ago
Path: ~/Developer/learning-playground

This project is significantly behind. Options:
1. Update it: ./scripts/claude-update.sh --apply
2. Archive it if no longer needed
3. Remove from registry: ./scripts/claude-projects.sh remove <id>
```

---

## Query Category: Management

### Query 16: Add Project (Redirect to CLI)
**User:** "Add my new project to the registry"

**Skill Response:**
```
To add a project to the registry, use the interactive wizard:
  ./scripts/register-project.sh

Or use the CLI directly:
  ./scripts/claude-projects.sh add "Project Name" ~/path/to/project

The wizard will:
- Auto-detect your template version
- Validate the project path
- Prevent duplicates
- Create a backup

Want me to guide you through the questions?
```

---

### Query 17: Update Project (Redirect to CLI)
**User:** "Update ClientB's version in the registry"

**Skill Response:**
```
To update ClientB API's version in the registry:

  ./scripts/claude-projects.sh update client-b-api-<id>

Or sync all project versions automatically:
  ./scripts/claude-projects.sh sync

The sync command will:
- Check each project's version.json
- Update the registry
- Recalculate status

Run sync after updating a project with ./scripts/claude-update.sh
```

---

### Query 18: Remove Project (Redirect to CLI)
**User:** "Remove the old learning project"

**Skill Response:**
```
To remove Learning Playground from the registry:

1. Get the project ID:
   ./scripts/claude-projects.sh list

2. Remove it:
   ./scripts/claude-projects.sh remove <project-id>

Note: This only removes from registry, not your filesystem.
A backup will be created automatically.
```

---

## Query Category: Empty States

### Query 19: Empty Registry
**User:** "What projects do I have?"

**Skill Response:**
```
Your projects registry is empty (no projects registered yet).

To get started:
  ./scripts/register-project.sh

Or from the main wizard:
  ./scripts/claude-wizard.sh
  (Choose option 6: Register Project)

Once registered, I can help you:
- Track versions across projects
- Filter by tags or technology
- Prioritize updates
- Navigate quickly
```

---

### Query 20: No Outdated Projects
**User:** "What needs updating?"

**Skill Response:**
```
Great news! All your projects are up-to-date ✅

5 projects on v3.3.0 (current version):
- ClientA Dashboard
- ClientB API
- ClientC Portal
- Personal Blog
- Learning Playground

No action needed. Keep up the good work!
```

---

## Query Category: Troubleshooting

### Query 21: Registry Location
**User:** "Where is my registry file?"

**Skill Response:**
```
Your projects registry is located at:
  ~/.claude/projects-registry.json

This is your home directory: /Users/yourname/

To view it:
  cat ~/.claude/projects-registry.json

To edit it (advanced):
  nano ~/.claude/projects-registry.json

For safe modifications, use the CLI tools instead.
```

---

### Query 22: JSON Errors
**User:** "My registry has errors"

**Skill Response:**
```
If your registry has JSON syntax errors:

1. Validate it:
   cat ~/.claude/projects-registry.json | python -m json.tool

2. If errors shown, restore from backup:
   cp ~/.claude/projects-registry.json.bak ~/.claude/projects-registry.json

3. If no backup exists, recreate:
   mv ~/.claude/projects-registry.json ~/.claude/projects-registry.json.broken
   ./scripts/register-project.sh

Need help fixing specific JSON errors? Share the error message.
```

---

### Query 23: Missing Projects
**User:** "Some projects are missing from the registry"

**Skill Response:**
```
To add missing projects to the registry:

Interactive (recommended):
  ./scripts/register-project.sh

CLI (for each project):
  ./scripts/claude-projects.sh add "Project Name" ~/path/to/project

After adding, sync versions:
  ./scripts/claude-projects.sh sync

This will auto-detect template versions and calculate status.
```

---

## Query Category: Analytics

### Query 24: Statistics
**User:** "Give me statistics on my projects"

**Skill Response:**
```
📊 Project Statistics:

Total Projects: 5

By Status:
- Up-to-date: 3 (60%)
- Outdated: 2 (40%)
- Unknown: 0 (0%)

By Category:
- Production: 3 (1 needs update)
- Personal: 2 (1 needs update)

By Technology:
- React: 3
- Node.js: 1
- Next.js: 1

Average template version: v3.1.6
Current version: v3.3.0

Average age since last update: 45 days
```

---

### Query 25: Trends
**User:** "How's my project maintenance looking?"

**Skill Response:**
```
📈 Maintenance Overview:

Update Status: ⚠️ Needs Attention
- 60% of projects are current
- 40% need updates

Priority Actions:
1. Update ClientB API (production, 3 versions behind)
2. Review Learning Playground (personal, 6 versions behind)

Recent Activity:
- Last registry sync: 2 days ago
- Last project update: ClientA Dashboard (5 days ago)

Recommendation: Run updates weekly to stay current.
```

---

## Notes on Skill Behavior

### Auto-Activation Triggers

The skill automatically activates when user mentions:
- Project names (e.g., "ClientA", "blog")
- Status keywords (e.g., "outdated", "update", "version")
- Categories (e.g., "production", "personal")
- Technologies (e.g., "React", "Node")
- Organization (e.g., "registry", "tracking")

### Response Characteristics

**Concise:**
- Use emoji for visual scanning (✅ ⚠️ ❓)
- Show most relevant info first
- Suggest next actions

**Helpful:**
- Provide CLI commands when needed
- Offer context and recommendations
- Answer follow-up questions

**Token-Efficient:**
- Structured responses (250 tokens vs 600 without skill)
- Pre-compiled knowledge
- Direct to-the-point answers

---

**Version:** 3.3.0
**Last Updated:** 2025-12-12
