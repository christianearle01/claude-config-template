# Directory Structure Guide

**Version:** 4.5.1
**Last Updated:** 2025-12-16

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

### 01_must-have/ ⚠️ **Read these first**
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

### 02_good-to-have/ ⭐ **Read these next**
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

### 03_nice-to-have/ 💡 **Read when needed**
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

### 01_must-have/ ⚠️ **Essential for project setup**

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

### 02_good-to-have/ ⭐ **Maximize efficiency**

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

### 03_nice-to-have/ 💡 **Reserved for future content**
Placeholder for advanced project-specific topics

---

## 🎯 Pre-Project Planning (03_pre-project-planning/)

**Purpose:** Plan NEW projects BEFORE writing code

**When to use:** Starting a new project from scratch

### 01_must-have/ ⚠️ **Start here for new projects**

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

**Status:** Available (v4.5.2+)

**Purpose:** Role-based Claude browser configurations for claude.ai

**Content:**

### 01_must-have/ ⚠️ **Essential browser configs**

**Files:**
1. **00_all-available-roles-complete-library.md** - Role library index
2. **01_custom-role.md** - Create your own role
3. **02_software-engineer.md** - Software engineer workflow
4. **03_qa-engineer.md** - Quality assurance engineer workflow
5. **04_data-scientist.md** - Data scientist workflow
6. **05_devops-engineer.md** - DevOps engineer workflow
7. **06_product-manager.md** - Product manager workflow
8. **07_technical-writer.md** - Technical writer workflow
9. **08_frontend-developer.md** - Frontend developer workflow
10. **09_security-engineer.md** - Security engineer workflow
11. **10_claude-skills-complete-guide.md** - Account-level skills guide (v3.7.0)

**Customization:** Each role gets optimized Custom Instructions for browser-based Claude

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

## 🎨 Template System (v4.0-v4.5)

**Purpose:** Share and reuse Claude Code preferences across projects and teams

**Location:** `examples/team-templates/`

### Template Gallery (9 Templates)

**Base Templates:**
1. **team-standard.json** - Standard team configuration
2. **team-security.json** - Security-focused configuration

**Gallery Templates (v4.3.0):**
3. **gallery-frontend-react.json** - React + TypeScript + Tailwind
4. **gallery-backend-api.json** - Node.js/Python API development
5. **gallery-data-science.json** - Python data science with Jupyter
6. **gallery-devops.json** - Kubernetes, Terraform, CI/CD
7. **gallery-fullstack.json** - Customizable full-stack (parameterized)

**Demonstration Templates:**
8. **team-frontend.json** - Inheritance example (extends team-standard)
9. **team-parameterized.json** - Parameters example

### Template System Features

**v4.0.0 - Import/Export Foundation**
- Export settings as shareable templates
- Import templates from files or URLs
- Git-native distribution (no authentication required)

**v4.1.0 - Template Inheritance**
- `extends` field for compositional templates
- Deep merge algorithm (child overrides parent)
- Cycle detection and max depth (5 levels)

**v4.2.0 - Template Parameters**
- `${varName}` syntax for dynamic values
- Parameter types: string, number, boolean
- CLI mode and interactive mode support
- Required vs optional parameters with defaults

**v4.3.0 - Template Gallery**
- 9 curated domain-specific templates
- Frontend, backend, data science, devops, full-stack

**v4.4.0 - Template Validator**
- Script: `scripts/validate-template.sh`
- JSON schema validation
- 3-level validation (Critical/Important/Info)
- Catalog validation with --catalog flag

**v4.5.0 - Template Application**
- Script: `scripts/apply-template.sh`
- Automated inheritance resolution
- Parameter substitution (CLI or interactive)
- Preview with diff before applying
- Automatic backup creation

### Documentation

- **Foundation:** `docs/02-optimization/TEMPLATE_SYSTEM_FOUNDATION.md` (v4.0-v4.2)
- **Gallery:** `docs/02-optimization/TEMPLATE_GALLERY_GUIDE.md` (v4.3.0)
- **Validator:** `docs/04-ecosystem/TEMPLATE_VALIDATOR_GUIDE.md` (v4.4.0)
- **Application:** `docs/04-ecosystem/APPLY_TEMPLATE_GUIDE.md` (v4.5.0)

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

**Template Management (v4.x):**
- **validate-template.sh** (v4.4.0) - Validate template JSON structure
  - JSON schema validation
  - 3-level validation (Critical/Important/Info)
  - Catalog validation with `--catalog` flag

- **apply-template.sh** (v4.5.0) - Apply templates to projects
  - Inheritance resolution with cycle detection
  - Parameter substitution (CLI + interactive modes)
  - Preview with diff before applying
  - Automatic backup creation

**Project Management (v3.2.0+):**
- **register-project.sh** - Register project in multi-project registry
- **claude-projects.sh** - CLI for managing multiple projects
- **claude-skills.sh** (v3.5.0) - Skills catalog and management

**Development Tools:**
- **setup-git-workflow.sh** (v2.9.0) - Git commit approval configuration
- **sync-version.sh** (v2.8.0) - Automated version updates across files
- **progress-bar-config.sh** (v3.1.0) - Global progress bar configuration
- **claude-health-check.sh** (v3.5.0) - System health check
- **remove-commands.sh** (v3.4.0) - Clean up old slash commands
- **claude-update.sh** - Keep template current
- **claude-analytics.sh** - Opt-in usage tracking (privacy-first)

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

**Built-in agents (5 total):**

1. **initializer.md** (v3.6.0) - Domain memory expansion
   - Expands user intent into structured task breakdown
   - Creates features.json with dependencies and test criteria
   - Defines bootup ritual checklist
   - Anthropic two-agent pattern

2. **coder.md** (v3.6.0) - Bootup ritual execution
   - Executes bootup ritual every session
   - Picks ONE feature atomically
   - Tests until passing, updates state, commits
   - 85% token reduction in regrounding

3. **quality-reviewer.md** (v3.11.0) - Automated quality validation
   - Security scanner (OWASP top 10, CVE checks)
   - Test generator (features.json integration)
   - Standards enforcer (learns team preferences)
   - Parallel quality gates

4. **prompt-polisher.md** (v2.4.0) - Transform vague prompts
   - 14 optimization techniques
   - Intelligent selection
   - 50-80% token savings
   - Educational output

5. **project-planner.md** (v2.3.0) - Plan new projects
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

**Built-in commands (3 total):**

1. **/test.md** - Run test suite with proper reporting
2. **/build.md** - Build project and report errors
3. **/review.md** - Code review against project standards

**How to create custom commands:**
1. Create `.md` file in `.claude/commands/`
2. Filename becomes command name (e.g., `deploy.md` → `/deploy`)
3. File content is the prompt Claude executes

---

## 🗄️ Version Control (.git/)

**Purpose:** Git repository metadata

**Note:** You don't need to directly interact with this directory

**Branches:**
- `main` - Current stable version (v4.5.1)
- `release/vX.X.X` - Version-specific branches (v4.0-v4.5)
- `historical/v1.0-original` - Original template (pre-v2.0)

**Tags:**
- `v2.0.0` through `v2.9.0` - v2.x releases
- `v3.0.0` through `v3.15.0` - v3.x releases
- `v4.0.0` through `v4.5.1` - v4.x releases (current)

---

## 📊 Directory Summary

**Quick navigation by purpose:**

| I want to... | Go to... |
|--------------|----------|
| **Get started fast** | docs/5_MINUTE_SUCCESS.md |
| **Choose my path** | docs/VISUAL_QUICKSTART.md or START_HERE.md |
| **Install Claude Code** | 01_global-setup/01_must-have/01_installation.md |
| **Set up a project** | 02_project-onboarding/01_must-have/01_onboarding-guide.md |
| **Plan a new project** | 03_pre-project-planning/01_must-have/01_planning-guide.md |
| **Save money (model switching)** | 01_global-setup/02_good-to-have/01_model-switching.md |
| **Optimize prompts** | 02_project-onboarding/02_good-to-have/01_prompt-optimization.md |
| **Set up for team** | 02_project-onboarding/02_good-to-have/03_team-onboarding.md |
| **Add security** | 01_global-setup/03_nice-to-have/01_security-guide.md |
| **Find any feature** | QUICK_REFERENCE.md |
| **Understand concepts** | VISUAL_GUIDES.md |
| **Copy templates** | templates/ directory |
| **Run wizard** | scripts/claude-wizard.sh |
| **See examples** | examples/ directory |

---

## 🎯 Priority System Explained

The template uses a 3-tier system with numerical prefixes:

### ⚠️ 01_must-have/
**Read these first** - Essential for everyone

- Core concepts
- Required setup steps
- Safety fundamentals

**Time:** Usually 30-60 minutes

### ⭐ 02_good-to-have/
**Read these next** - High-value optimizations

- Huge efficiency gains
- Cost savings (92%!)
- Team collaboration

**Time:** Usually 20-40 minutes

### 💡 03_nice-to-have/
**Read when needed** - Advanced topics

- Power user features
- Security hardening
- Custom workflows

**Time:** Usually 10-30 minutes per topic

---

## 📈 How Content Grows

**v4.5.1 structure:**
```
docs/ (44 MD files)
├── 00-start-here/ (14 files) - Entry points
├── 01-fundamentals/ (4 files) - Core concepts
├── 02-optimization/ (7 files) - Token & workflow optimization
├── 03-advanced/ (6 files) - Expert techniques
└── 04-ecosystem/ (8 files) - Tools & reference

01_global-setup/ (9 files organized in 3 tiers)
02_project-onboarding/ (6 files organized in 2 tiers)
03_pre-project-planning/ (2 files)
04_browser-workflow/ (11 files) → Available!
templates/ (3 files + 9 template gallery files)
scripts/ (19 shell scripts)
examples/ (team-templates, hooks, MCP configs)
.claude/ (5 agents, 3 commands, skills/)

Total: 87+ MD files, 49,500+ lines of documentation
Agents: 5 (initializer, coder, quality-reviewer, prompt-polisher, project-planner)
Commands: 3 (test, build, review)
Templates: 9 (team + gallery)
Scripts: 19 (wizards, template tools, project management, dev tools)
```

**Growth areas for v4.6.0+:**
- Analytics & Validation (measuring token savings)
- User Experience & Tooling (CLI tools)
- Template Expansion (mobile, game-dev, AI/ML domains)
- Skills Development (implementing 13+ documented skills)

---

## Navigation

**🏠 [Back to README](../README.md)** | **🗺️ [Choose Your Path](../START_HERE.md)** | **📖 [Quick Reference](../QUICK_REFERENCE.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/christianearle01/claude-config-template) - v4.5.1*
