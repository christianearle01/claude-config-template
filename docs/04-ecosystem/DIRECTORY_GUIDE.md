# Directory Structure Guide

Complete guide to navigating the Claude Code Configuration Template.

**Purpose:** Understand what each directory contains and where to find specific content.

---

## 📁 Root Level Files

### Entry Points
- **README.md** - Landing page with overview and quick navigation
- **START_HERE.md** - Detailed persona selector with customized paths
- **GETTING_STARTED.md** - Quick win path (being renamed to QUICK_WIN.md)
- **VISUAL_GUIDES.md** - 5 Mermaid diagrams explaining key concepts
- **QUICK_REFERENCE.md** - Searchable reference for all features
- **CHANGELOG.md** - Complete version history with detailed release notes (includes v1.0.0 historical reference)

### Configuration Files
- **.gitignore** - Git exclusions (includes .claude.json for API keys)

---

## 📚 Documentation Directories

### docs/ (Added in v2.5.0)
UX-optimized guides for better onboarding

**Files:**
- **5_MINUTE_SUCCESS.md** - Ultra-fast demo (5 minutes)
  - Demonstrates core value
  - 99% token savings example
  - Clear next steps

- **VISUAL_QUICKSTART.md** - Interactive decision flowchart
  - Mermaid flowchart for path selection
  - ASCII alternative
  - 30-second quiz

- **DIRECTORY_GUIDE.md** - This file!
  - Complete directory structure
  - What's where reference

- **PROJECTED_IMPACT.md** - Theoretical examples (not real user data)
  - Before/after examples
  - Team adoption stories
  - Cost savings calculations

---

## 🌍 Global Setup (01_global-setup/)

**Purpose:** One-time machine-wide configuration

**When to use:** Setting up Claude Code on your computer for the first time

### must-have/ ⚠️ **Read these first**
Essential for everyone, regardless of experience level

**Files:**
1. **01_installation.md** - Install Claude Code (CLI or VS Code Extension)
   - Both installation methods covered
   - Platform-specific instructions
   - Verification steps

2. **02_quick-start.md** - Get up and running quickly
   - Essential keyboard shortcuts
   - Part 1: First-time setup
   - Part 2: Project setup
   - Part 4.5: Checkpointing & Rewind
   - Part 4.6: Keyboard shortcuts
   - Permission mode best practices

3. **03_permission-modes.md** - Understand plan/ask/acceptEdits
   - When to use each mode
   - Safety considerations
   - Team environment recommendations

### good-to-have/ ⭐ **Read these next**
High-value optimizations with huge efficiency gains

**Files:**
1. **01_model-switching.md** - Save 92% with Sonnet→Haiku pattern
   - Cost comparison tables
   - When to switch (and when not to)
   - Token caching explained
   - OpusPlan mode

2. **02_mcp-setup.md** - Install MCP servers globally
   - Context7 (up-to-date library docs)
   - Memory (knowledge graph)
   - Filesystem (advanced file ops)
   - GitHub (repository integration)

3. **03_mcp-pollution.md** - Avoid API key conflicts
   - Common pitfalls
   - Best practices
   - Environment variable management

### nice-to-have/ 💡 **Read when needed**
Advanced topics for power users

**Files:**
1. **01_security-guide.md** - Advanced security practices
   - Prompt injection detection
   - Response scanning
   - Hook installation

2. **02_security-summary.md** - Security overview
   - Quick reference
   - Threat model

3. **03_agent-coordination.md** - Advanced agent usage
   - Multi-agent workflows
   - Custom agent creation
   - Best practices

---

## 📦 Project Onboarding (02_project-onboarding/)

**Purpose:** Per-project setup for EXISTING codebases

**When to use:** Adding Claude Code configuration to an existing project

### must-have/ ⚠️ **Essential for project setup**

**Files:**
1. **01_onboarding-guide.md** - Set up Claude Code for your project
   - Copy configuration files
   - Customize CLAUDE.md
   - Test the setup

2. **02_setup-checklist.md** - Track your progress
   - Step-by-step checklist
   - Validation steps
   - Success criteria

3. **03_claude-agent-setup.md** - Configure agents and hooks
   - Custom agent creation
   - Hook installation
   - Slash command setup

### good-to-have/ ⭐ **Maximize efficiency**

**Files:**
1. **01_prompt-optimization.md** - Write better prompts = massive token savings
   - Be specific techniques
   - @-mention patterns
   - Context management
   - 50-80% token reduction strategies

2. **02_optimization-guide.md** - Workflow efficiency tips
   - Daily workflow patterns
   - Team collaboration
   - CI/CD integration

3. **03_team-onboarding.md** - Team adoption strategies
   - Rollout planning (pilot → full team)
   - Shared template repository
   - Team standards documentation
   - Onboarding new team members

### nice-to-have/ 💡 **Reserved for future content**
Placeholder for advanced project-specific topics

---

## 🎯 Pre-Project Planning (03_pre-project-planning/)

**Purpose:** Plan NEW projects BEFORE writing code

**When to use:** Starting a new project from scratch

### must-have/ ⚠️ **Start here for new projects**

**Files:**
1. **01_planning-guide.md** - Complete guide to using project-planner agent
   - How to invoke the agent
   - What to expect (4-phase conversation)
   - Example outputs
   - CLAUDE.md draft generation

**README.md** - Quick overview of the planning process

**Quick start:**
```bash
# In Claude Code
@project-planner I want to build [your project idea]
```

**Output:**
- Project planning summary
- Tech stack recommendations with rationale
- CLAUDE.md template draft
- Next steps checklist
- Learning resources
- Migration paths (escape hatches)

**Example:** See `templates/project-plan-template.md`

---

## 🌐 Browser Workflow (04_browser-workflow/)

**Status:** Available (v2.6.0)

**Purpose:** Role-based Claude browser configurations

**Planned content:**
- Software Engineer workflow
- Quality Assurance Engineer workflow
- DevOps Engineer workflow
- Data Scientist workflow
- Product Manager workflow
- Technical Writer workflow

**Customization:** Each role gets optimized prompts, agents, and commands

---

## 📝 Templates (templates/)

**Purpose:** Reusable templates to copy into your projects

**Files:**

### CLAUDE.md.template (284 lines)
The core project memory template

**Sections:**
- What Does This Application Do? (business purpose)
- Tech Stack (high-level choices with WHY)
- External Services & APIs (business purpose of each)
- Code Style & Conventions
- Testing Requirements
- Development Workflow
- Important Files & Locations
- Project Structure (for agent coordination)
- Security & Privacy Considerations
- Common Commands
- Onboarding Checklist
- Agent Optimization Notes

**Where to use:** Project root directory (NOT .claude/)

**How to use:**
```bash
cp templates/CLAUDE.md.template ./CLAUDE.md
# Edit with your project details
```

### coding-standards.md.template
Global coding standards across all projects

**Sections:**
- Indentation (4 spaces, no tabs)
- Big O notation thinking
- Algorithmic efficiency targets
- Naming conventions
- Edge case handling

**Where to use:** `~/.claude/coding-standards.md` (global)

### project-plan-template.md (480 lines)
Example output from project-planner agent

**Shows:**
- Complete SaaS project plan
- Tech stack with rationale
- Alternatives and when to use them
- Project structure
- Next steps checklist
- Learning resources
- Migration paths
- CLAUDE.md draft

**Use as:** Reference for what to expect from planning agent

---

## 🔧 Scripts (scripts/)

**Purpose:** Interactive setup wizards with validation

**Main wizard:**
- **claude-wizard.sh** - Entry point with persona selector
  - 6 options: 5 personas + exit
  - Routes to appropriate wizard
  - Saves last persona preference

**Persona-specific wizards:**
1. **wizard-first-time.sh** - 60-90 min complete learning path
2. **wizard-quick-setup.sh** - 15-30 min fast project setup
3. **wizard-advanced.sh** - 20-40 min advanced features
4. **wizard-team-lead.sh** - 90-120 min team deployment
5. **wizard-returning.sh** - 10-20 min quick refresher

**Helper functions:**
- **wizard-helpers.sh** - Shared utilities
  - Progress visualization
  - Quiz system with scoring
  - File validation (JSON, CLAUDE.md format)
  - Command availability checks
  - Success celebrations

**Update system:**
- **claude-update.sh** - Keep template current
  - Check for updates: `--check`
  - Apply updates: `--apply`
  - Rollback: `--rollback`
  - 3-way merge, automatic backups

**Analytics:**
- **claude-analytics.sh** - Opt-in usage tracking
  - Privacy-first (local only)
  - Helps improve template
  - Completely optional

---

## 📚 Examples (examples/)

**Purpose:** Example configurations to learn from

### hooks/
Example security hooks

**Files:**
- **detect-prompt-injection.js** - Prompt injection detection
- **response-scanner.js** - Response scanning for sensitive data
- **pre-tool-use-validation.js** - Validate before tool execution

**How to use:**
```bash
cp examples/hooks/detect-prompt-injection.js .claude/hooks/
chmod +x .claude/hooks/detect-prompt-injection.js
```

### mcp-servers/
Example MCP server configurations

**Files:**
- **context7-config.json** - Context7 setup example
- **github-config.json** - GitHub MCP integration
- **memory-config.json** - Memory/knowledge graph example

---

## ⚙️ Configuration (.claude/)

**Purpose:** Claude Code project configuration

**IMPORTANT:** This directory is committed to git (shared config)

**Exception:** `.claude.json` is git-ignored (contains API keys)

### settings.json
Optimized Claude Code settings

**Key settings:**
```json
{
  "model": "sonnet",                    // Start with balanced model
  "alwaysThinkingEnabled": true,        // Enhanced reasoning
  "outputStyle": "concise",             // Token optimization
  "permissions": {
    "defaultMode": "plan"               // Show plans first (safety)
  },
  "sandbox": {
    "enabled": true,                    // Security
    "excludedCommands": [...]           // Git, docker, npm, etc.
  }
}
```

### settings-explained.json
Every setting documented with WHY

**Purpose:**
- Educational reference
- Understand rationale behind each choice
- Customize confidently

### SETUP_CONTEXT.md (Added in v2.5.0)
Token-optimized guide for Claude to scan first

**Purpose:**
- Claude reads this first during setup help
- Saves 96% tokens (500 vs 20,000)
- Quick answers to common questions
- File location reference

**Usage:** Claude automatically reads this when helping with setup

### agents/
Custom agents for specialized workflows

**Built-in agents:**

1. **prompt-polisher.md** - Transform vague prompts
   - 14 optimization techniques
   - Intelligent selection
   - 50-80% token savings
   - Educational output

2. **project-planner.md** - Plan new projects
   - 6-perspective design
   - 4-phase conversation
   - CLAUDE.md draft generation
   - 25-30 min time-boxed

**How to create custom agents:**
1. Create `.md` file in `.claude/agents/`
2. Define agent purpose and behavior
3. Invoke with `@agent-name`

### commands/
Slash commands for common tasks

**Built-in commands:**

1. **/onboarding.md** - Generate project onboarding guide
2. **/standards.md** - Show coding standards
3. **/test.md** - Run test suite
4. **/build.md** - Build project and report errors
5. **/review.md** - Code review against standards

**How to create custom commands:**
1. Create `.md` file in `.claude/commands/`
2. Filename becomes command name (e.g., `deploy.md` → `/deploy`)
3. File content is the prompt Claude executes

---

## 🗄️ Version Control (.git/)

**Purpose:** Git repository metadata

**Note:** You don't need to directly interact with this directory

**Branches:**
- `main` - Current stable version (v2.6.0)
- `release/vX.X.X` - Version-specific branches
- `historical/v1.0-original` - Original template (pre-v2.0)
- `phase-1-persona-routing` - Development branch
- `phase-2-wizard` - Development branch
- `phase-3-updates` - Development branch

**Tags:**
- `v2.0.0`, `v2.1.0`, `v2.2.0`, `v2.2.1`, `v2.4.0` - Version releases

---

## 📊 Directory Summary

**Quick navigation by purpose:**

| I want to... | Go to... |
|--------------|----------|
| **Get started fast** | docs/5_MINUTE_SUCCESS.md |
| **Choose my path** | docs/VISUAL_QUICKSTART.md or START_HERE.md |
| **Install Claude Code** | 01_global-setup/must-have/01_installation.md |
| **Set up a project** | 02_project-onboarding/must-have/01_onboarding-guide.md |
| **Plan a new project** | 03_pre-project-planning/must-have/01_planning-guide.md |
| **Save money (model switching)** | 01_global-setup/good-to-have/01_model-switching.md |
| **Optimize prompts** | 02_project-onboarding/good-to-have/01_prompt-optimization.md |
| **Set up for team** | 02_project-onboarding/good-to-have/03_team-onboarding.md |
| **Add security** | 01_global-setup/nice-to-have/01_security-guide.md |
| **Find any feature** | QUICK_REFERENCE.md |
| **Understand concepts** | VISUAL_GUIDES.md |
| **Copy templates** | templates/ directory |
| **Run wizard** | scripts/claude-wizard.sh |
| **See examples** | examples/ directory |

---

## 🎯 Priority System Explained

The template uses a 3-tier system:

### ⚠️ must-have/
**Read these first** - Essential for everyone

- Core concepts
- Required setup steps
- Safety fundamentals

**Time:** Usually 30-60 minutes

### ⭐ good-to-have/
**Read these next** - High-value optimizations

- Huge efficiency gains
- Cost savings (92%!)
- Team collaboration

**Time:** Usually 20-40 minutes

### 💡 nice-to-have/
**Read when needed** - Advanced topics

- Power user features
- Security hardening
- Custom workflows

**Time:** Usually 10-30 minutes per topic

---

## 📈 How Content Grows

**v2.6.0 structure:**
```
docs/ (4 files) → NEW!
01_global-setup/ (9 files)
02_project-onboarding/ (6 files)
03_pre-project-planning/ (2 files)
04_browser-workflow/ (coming soon)
templates/ (3 files)
scripts/ (8 files)
examples/ (6 files)
.claude/ (8 files)

Total: 50+ files, 22,400+ lines of documentation
```

**Growth areas for v2.6.0:**
- 04_browser-workflow/ (role-based configs)
- More custom agents
- More slash commands
- Language-specific templates
- Framework-specific guides

---

## Navigation

**🏠 [Back to README](../README.md)** | **🗺️ [Choose Your Path](../START_HERE.md)** | **📖 [Quick Reference](../QUICK_REFERENCE.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/your-repo) - v2.6.0*
