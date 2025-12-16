# Applying Template Updates to Your Projects

**How to get the latest improvements into your existing projects**

**Time:** 5-15 minutes per project
**When to use:** After the template updates (new agents, better guides, etc.)

---

## Why This Matters

**Without this guide:**
- Waste tokens asking Claude "How do I update my project with the latest template?"
- Miss improvements (new agent features, better workflows, anti-patterns)
- Manually figure out what changed and how to apply it
- Risk overwriting your project-specific customizations

**With this guide:**
- Copy-paste commands to update in 5 minutes
- Get all improvements without asking Claude
- Understand what you're updating and why
- Preserve your customizations

**Time investment:** 5 minutes reading, 5-10 minutes per project update
**Benefit:** Access all template improvements without Claude's help

---

## What Gets Updated vs What Stays

### Template Repository Changed (What We Updated)

**Location:** `~/Developer/claude-config-template/`

**What changed:**
- `.claude/agents/*.md` - Enhanced with chain-of-thought reasoning
- `docs/` - New persona guides, workflow integration, visual workflows
- File numbering - Sequential ordering for clear reading
- Templates - CLAUDE.md.template, coding-standards.md.template

### Your Projects (What's NOT Automatically Updated)

**Location:** `/path/to/your-project/`

**What's unchanged:**
- `.claude/agents/` - Still has old agent definitions
- `CLAUDE.md` - Your project-specific content (unchanged)
- `.claude/settings.json` - Your project settings (unchanged)

**Your global settings are also unchanged:**
- `~/.claude/settings.json`
- `~/.claude/coding-standards.md`

---

## Option 1: Update Existing Projects (Recommended)

**Use this when:** You have projects already using the template and want the improvements

### Quick Update (Enhanced Agents Only)

**What you get:** Chain-of-thought reasoning, negative examples, better explanations

```bash
# 1. Go to your project
cd /path/to/your-project

# 2. Backup current config (optional but recommended)
cp -r .claude .claude.backup

# 3. Copy enhanced agents
cp ~/Developer/claude-config-template/.claude/agents/*.md ./.claude/agents/

# 4. Test the improvements
claude
```

**Test commands:**
```
@prompt-polisher "Add authentication"
# Should show: 🔍 Analyzing your request... with reasoning

@coder "Implement login feature"
# Should show: Feature Selection Reasoning with 3 candidates

@quality-reviewer
# Should show: Visual progress bars for parallel execution
```

**Time:** 2 minutes per project

---

### Full Update (Everything)

**What you get:** Enhanced agents + updated settings + latest templates

```bash
# 1. Go to your project
cd /path/to/your-project

# 2. Backup everything
cp -r .claude .claude.backup
cp CLAUDE.md CLAUDE.md.backup

# 3. Copy ALL configuration
cp -r ~/Developer/claude-config-template/.claude/* ./.claude/

# 4. Merge your CLAUDE.md customizations
# Compare your backup with the new template
diff CLAUDE.md.backup ~/Developer/claude-config-template/templates/CLAUDE.md.template

# 5. Manually merge important sections
# Keep your: Business purpose, External APIs, Project-specific conventions
# Add from template: New sections you like
```

**Warning:** This overwrites ALL `.claude/` files. Use if you haven't customized much.

**Time:** 10 minutes per project

---

### Selective Update (Pick What You Want)

**What you get:** Only the pieces you choose

```bash
cd /path/to/your-project

# Pick one or more:

# Update only specific agents
cp ~/Developer/claude-config-template/.claude/agents/coder.md ./.claude/agents/
cp ~/Developer/claude-config-template/.claude/agents/quality-reviewer.md ./.claude/agents/

# Update only commands
cp ~/Developer/claude-config-template/.claude/commands/*.md ./.claude/commands/

# Update only settings.json (careful - will overwrite)
cp ~/Developer/claude-config-template/.claude/settings.json ./.claude/settings.json

# Update global coding standards
cp ~/Developer/claude-config-template/templates/coding-standards.md.template ~/.claude/coding-standards.md
```

**Time:** 3-5 minutes per project

---

## Option 2: Set Up New Project with Latest Template

**Use this when:** Starting a fresh project, want all improvements from day 1

### For New Projects (No Code Yet)

```bash
# 1. Create project directory
mkdir my-new-project
cd my-new-project

# 2. Copy entire configuration (gets all improvements)
cp -r ~/Developer/claude-config-template/.claude .

# 3. Copy CLAUDE.md template
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md

# 4. Fill in CLAUDE.md with your project details
# Edit: Business purpose, tech stack, external APIs

# 5. Initialize git (optional)
git init
git add .claude/ CLAUDE.md
git commit -m "Initial Claude Code configuration"

# 6. Test the setup
claude
# Ask: "What does this project do?"
# Should read CLAUDE.md and understand context
```

**Time:** 10 minutes for new project

---

### For Existing Projects (Adding Claude Code)

```bash
# 1. Go to your existing project
cd /path/to/existing-project

# 2. Copy configuration
cp -r ~/Developer/claude-config-template/.claude .

# 3. Copy CLAUDE.md template
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md

# 4. Document your existing project in CLAUDE.md
# Use Claude to help:
claude
```

Then ask Claude:
```
I just added CLAUDE.md to this existing project. Help me document:
1. What does this app DO? (Read README.md, package.json, main files)
2. What are the key features? (User perspective)
3. What external APIs do we use and WHY?

Focus on WHAT the app does (business value), not HOW it's built.
Skip reading: node_modules/, dist/, build/, vendor/, .git/
```

**Time:** 30 minutes for existing project

---

## Option 3: Just Use the Documentation

**Use this when:** You want to read new guides but not update project configs yet

### Access Documentation Anytime

```bash
# Read from template directory
cd ~/Developer/claude-config-template

# Browse persona guides
ls docs/00-start-here/personas/
cat docs/00-start-here/personas/01_first-time-learner.md

# Read workflow integration
cat docs/01-fundamentals/03_workflow-integration.md

# View visual workflows (Mermaid diagrams)
cat docs/00-start-here/08_visual-workflows.md
```

### Or Browse on GitHub

After pushing template updates:
- https://github.com/christianearle01/claude-config-template/
- Navigate to `docs/` → Browse guides
- GitHub renders Mermaid diagrams automatically

**Time:** 0 minutes (read as needed)

---

## What Each Update Gives You

### Enhanced Agents (v4.6.0+)

**Files:** `.claude/agents/*.md`

**What you get:**
- **Chain-of-thought reasoning** - Agents explain WHY they make decisions
- **Confidence score breakdowns** - Itemized +/- factors
- **Negative examples** - Anti-patterns (TDD mistakes, security issues)
- **Strategic magic phrases** - Confidence-building language

**Example:**
```
Before: "I recommend feat-002 next."
After: "I recommend feat-002 (Registration) next. Here's my reasoning:
✅ [+0.30] Standard CRUD pattern (you've done this before)
✅ [+0.25] Clear requirements
⚠️ [-0.12] Email verification adds complexity
Total: 0.88 confidence → Highly confident this will go smoothly"
```

---

### Documentation Improvements (v4.7.0+)

**Files:** `docs/00-start-here/personas/*.md`, `docs/01-fundamentals/*.md`

**What you get:**
- **Architected briefs** - 50-word scannable summaries
- **Persona guides** - 6 paths (01-06 numbered for reading order)
- **"Why This Matters" headers** - Value-first explanations
- **Anti-patterns sections** - Common mistakes with ❌/✅ examples
- **"Next Logical Step" footers** - Clear navigation

**Example:**
```
## Why This Matters

Without CLAUDE.md: Claude re-reads 20-50 files every session (2,000-10,000 tokens)
With CLAUDE.md: Claude reads 1 file (200-500 tokens) = 95% savings
```

---

### Workflow Integration (v4.8.0+)

**Files:** `docs/01-fundamentals/03_workflow-integration.md`, `docs/00-start-here/08_visual-workflows.md`

**What you get:**
- **4-layer system explained** - Context → Commands → Skills → Agents
- **3 complete workflows** - New project, existing project, debugging
- **5 Mermaid diagrams** - Visual workflow representations
- **When to use what** - Decision framework with clear guidance
- **Power combinations** - Tool synergy for 2-3× productivity gains

**Example:**
```
Layer 4: AGENTS (Complex tasks) → @project-planner, @coder
         ↑ uses
Layer 3: SKILLS (Domain automation) → testing-workflow, component-finder
         ↑ triggers
Layer 2: COMMANDS (Quick operations) → /test, /build, /review
         ↑ reads
Layer 1: CONTEXT (Foundation) → CLAUDE.md, settings.json
```

---

## Preserving Your Customizations

### Before Updating: Check What You Customized

```bash
cd /path/to/your-project

# Check if you modified agents
diff ./.claude/agents/ ~/Developer/claude-config-template/.claude/agents/

# Check if you modified commands
diff ./.claude/commands/ ~/Developer/claude-config-template/.claude/commands/

# Check if you modified settings
diff ./.claude/settings.json ~/Developer/claude-config-template/.claude/settings.json
```

### If You Have Customizations

**Option A: Selective copy (recommended)**
- Copy only files you haven't customized
- Keep your custom agents/commands

**Option B: Manual merge**
- Use a merge tool (VS Code, diff, meld)
- Merge template improvements with your changes

**Option C: Note your customizations, then overwrite**
```bash
# 1. Document your changes
cat ./.claude/agents/my-custom-agent.md > ~/my-customizations.txt

# 2. Overwrite with template
cp -r ~/Developer/claude-config-template/.claude .

# 3. Restore your customizations
cp ~/my-customizations.txt ./.claude/agents/my-custom-agent.md
```

---

## Common Mistakes to Avoid

### ❌ Anti-Pattern #1: Overwriting CLAUDE.md Without Backup

**Problem:** Lose all your project-specific documentation

**Example:**
```bash
# DON'T DO THIS (overwrites your project documentation!)
cp ~/Developer/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md

# Result: Lost your business purpose, external APIs, conventions
```

**✅ Correct Approach:**
```bash
# Backup first
cp CLAUDE.md CLAUDE.md.backup

# Then selectively merge sections you want from template
# Compare what's new in template:
diff CLAUDE.md ~/Developer/claude-config-template/templates/CLAUDE.md.template
```

**Pattern:** Always backup CLAUDE.md before touching it.

---

### ❌ Anti-Pattern #2: Updating Without Testing

**Problem:** Broken config blocks your work

**Example:**
```bash
# Copy everything
cp -r ~/Developer/claude-config-template/.claude .

# Start working immediately without testing
claude
# Error: settings.json syntax error (copied over with your customizations overridden)
```

**✅ Correct Approach:**
```bash
# Copy everything
cp -r ~/Developer/claude-config-template/.claude .

# Test immediately
claude
# Verify: Agents work? Commands work? Settings load?

# If broken, restore backup:
cp -r .claude.backup .claude
```

**Pattern:** Test after every update. Keep backups until verified working.

---

### ❌ Anti-Pattern #3: Forgetting to Update Multiple Projects

**Problem:** Inconsistent experience across projects

**Example:**
```
Project A: Has enhanced agents (updated)
Project B: Has old agents (forgot to update)
Project C: Has enhanced agents (updated)

Result: Confused when Project B agents behave differently
```

**✅ Correct Approach:**

Create an update script:

```bash
#!/bin/bash
# update-all-projects.sh

PROJECTS=(
  "/path/to/project-a"
  "/path/to/project-b"
  "/path/to/project-c"
)

for project in "${PROJECTS[@]}"; do
  echo "Updating $project..."
  cp ~/Developer/claude-config-template/.claude/agents/*.md "$project/.claude/agents/"
  echo "✓ Updated $project"
done

echo "All projects updated!"
```

**Pattern:** Update all projects at once for consistency.

---

## Verification Checklist

After updating, verify these work:

### Test Enhanced Agents

```bash
claude

# Test @prompt-polisher
@prompt-polisher "Add a feature"
# Should show: 🔍 Analyzing your request... with reasoning

# Test @coder
@coder "Implement something"
# Should show: Feature Selection Reasoning

# Test @quality-reviewer
@quality-reviewer
# Should show: Parallel execution progress
```

### Test Configuration

```bash
# Check settings load
claude
/doctor
# Should show: No issues found

# Check CLAUDE.md reads
claude
# Ask: "What does this project do?"
# Should accurately describe from CLAUDE.md

# Check commands work
/test
/build
/review
```

### Test Documentation Access

```bash
# Can you find guides?
ls ~/Developer/claude-config-template/docs/00-start-here/personas/
# Should show: 01-06 persona files

# Can you read workflows?
cat ~/Developer/claude-config-template/docs/01-fundamentals/03_workflow-integration.md
# Should display guide
```

---

## Rollback If Needed

If something breaks:

```bash
cd /path/to/your-project

# Option 1: Restore full backup
cp -r .claude.backup .claude

# Option 2: Restore specific file
cp .claude.backup/agents/coder.md .claude/agents/coder.md

# Option 3: Restore CLAUDE.md
cp CLAUDE.md.backup CLAUDE.md

# Test again
claude
```

---

## Next Steps

### After Updating Projects

**Option A: Learn New Features (15 min)**
→ [Workflow Integration Guide](../01-fundamentals/WORKFLOW_INTEGRATION.md) - Understand how tools connect

**Option B: Try Enhanced Agents (10 min)**
→ Use @coder or @quality-reviewer on a real task, see chain-of-thought reasoning

**Option C: Update More Projects (5 min each)**
→ Apply to all your active projects for consistency

**Having trouble?** Check the Troubleshooting section above or ask Claude: "I updated my project with the template but [specific issue]"

---

## ✅ You've Completed: Applying Template Updates

**What you learned:**
- How to update existing projects (3 options: quick, full, selective)
- How to set up new projects with latest template
- How to preserve your customizations during updates
- What each update gives you (agents, docs, workflows)
- Common mistakes to avoid (backup first, test after, update all projects)

**Next logical step:**

**Option A: Update Your Most Important Project (10 min)**
→ Apply improvements to your main project

**Option B: Create Update Script (15 min)**
→ Automate updates for all your projects

**Option C: Explore New Features (20 min)**
→ Read workflow integration guide, try visual workflows

---

**Estimated next step time:** 10-20 minutes (depending on choice)
**Last Updated:** 2025-12-16
