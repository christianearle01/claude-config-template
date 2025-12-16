# Quick Reference - Claude Code Template

**How to use:** Press `Cmd+F` (Mac) or `Ctrl+F` (Windows) and search for any keyword.

**Purpose:** Find any feature, command, or concept instantly without browsing documentation.

---

## 📖 Table of Contents (Alphabetical)

Jump to any section:

- [Background Tasks](#background-tasks)
- [Breadcrumb Navigation](#breadcrumb-navigation)
- [Checkpointing / Rewind](#checkpointing--rewind)
- [CLAUDE.md Template](#claudemd-template)
- [Claude Skills (Account-Level)](#claude-skills-account-level)
- [Commands (Slash)](#commands-slash)
- [Cost Savings](#cost-savings)
- [Custom Agents](#custom-agents)
- [Educational Modes](#educational-modes)
- [File Locations](#file-locations)
- [Git Workflow & Commit Approval](#git-workflow--commit-approval)
- [Keyboard Shortcuts](#keyboard-shortcuts)
- [MCP Servers](#mcp-servers)
- [Model Switching](#model-switching)
- [Permission Modes](#permission-modes)
- [Personas (User Profiles)](#personas-user-profiles)
- [Security Hooks](#security-hooks)
- [Setup Paths](#setup-paths)
- [Token Optimization](#token-optimization)
- [Troubleshooting](#troubleshooting)
- [Update System](#update-system)
- [Visual Guides](#visual-guides)
- [Wizards](#wizards)

---

## Background Tasks

**What:** Run long-running bash commands without blocking Claude's work

**How:** Press `Ctrl-b` before running a command

**Example:**
```bash
Ctrl-b npm test        # Tests run in background
Ctrl-b npm run dev     # Dev server starts in background
Ctrl-b python train.py # ML training in background
```

**When to use:**
- 🧪 Test suites (continue coding while tests run)
- 🏗️ Build processes (start build, keep working)
- 🚀 Dev servers (launch server, continue conversation)
- 📊 Log monitoring (tail logs without blocking)

**How to check status:**
- Check separate terminal window
- Or ask Claude: "What's the status of my background tasks?"

**How to stop:**
```bash
ps aux | grep [process-name]
kill [PID]
```

**Docs:** [Quick Start Guide § Background Tasks](01_global-setup/01_must-have/02_quick-start.md#background-tasks)

**Keywords:** ctrl-b, background, long-running, parallel, multitask

---

## Breadcrumb Navigation

**What:** Navigation links at the top of documentation files showing your current location

**Format:**
```markdown
📍 You are here: Home > Global Setup > Installation
⬅️ Previous: Quick Start | ➡️ Next: Permission Modes
```

**Why useful:**
- Always know where you are in 39+ docs
- Easy to backtrack
- Skip ahead to next topic

**Status:** Available (v4.5.2)

**Keywords:** navigation, breadcrumbs, lost, where am i, back

---

## Checkpointing / Rewind

**What:** Automatic save points before Claude makes changes, with instant undo capability

**How to undo:**
```bash
# Method 1: Keyboard (fastest)
Press Esc twice

# Method 2: Command
/rewind
```

**When checkpoints are created:**
- ✅ Before each file edit
- ✅ Before potentially destructive commands
- ✅ Before major refactoring
- ✅ When Claude uses Write or Edit tools

**Checkpoints vs Git:**

| Feature | Checkpoints | Git Commits |
|---------|-------------|-------------|
| Purpose | Session-level undo | Long-term version control |
| Scope | Current session only | Permanent history |
| Speed | Instant (Esc Esc) | Requires commit message |
| Persistence | Lost when session ends | Permanent |
| Best for | Quick experiments | Milestones, team sharing |

**Important:** Checkpoints are NOT a replacement for git! Always commit important changes.

**Available in:** Claude Code v2.0+

**Docs:** [Quick Start Guide § Checkpointing](01_global-setup/01_must-have/02_quick-start.md#part-45-checkpointing--rewind-system)

**Keywords:** undo, revert, rollback, esc esc, safety, experiments

---

## CLAUDE.md Template

**What:** Project memory file that gives Claude instant context about your project

**Purpose:**
- Documents business purpose (WHAT app does, not HOW)
- Saves 95% tokens on context queries
- Speeds up onboarding for new team members

**Location:** Project ROOT directory (not `.claude/`)

**Template location:** `templates/CLAUDE.md.template`

**Essential sections:**
1. **Business purpose** - What the app does
2. **Tech stack** - Languages, frameworks, database
3. **External APIs** - Business reason for each
4. **Code conventions** - Project-specific patterns
5. **Common commands** - dev, test, build, deploy

**Token savings example:**
- Without CLAUDE.md: 20K tokens (file exploration)
- With CLAUDE.md: 200 tokens (direct context)
- **Savings: 99% reduction**

**Quick start:**
```bash
cp templates/CLAUDE.md.template ./CLAUDE.md
# Edit the file - add your project details
```

**Docs:** [Project Onboarding Guide](02_project-onboarding/01_must-have/01_onboarding-guide.md)

**Keywords:** project memory, context, documentation, business purpose, onboarding

---

## Claude Skills (Account-Level)

**What:** Reusable instruction manuals available across all claude.ai projects, Claude Code, and Claude API

**Location:** `04_browser-workflow/01_must-have/10_claude-skills-complete-guide.md`

**Purpose:** Package workflows into portable skills that reduce repetitive context setting

**Types:**
1. **Official/Partner Skills** - Pre-built by Anthropic and partners (e.g., skill-creator, Notion)
2. **Custom Skills** - Created by you using skill-creator for your specific workflows

**Access:** Settings → Capabilities in claude.ai

**Key Features:**
- ✅ **Portable:** Works across claude.ai, Claude Code CLI, and Claude API
- ✅ **Stackable:** Combine multiple skills in one conversation
- ✅ **Auto-trigger:** Activates based on context (no manual invocation)
- ✅ **Token efficient:** 60-80% reduction in repetitive context (Projected)

**When to create a custom skill:**
- You repeat the same instructions 3+ times across different chats
- The process is complex enough to train a real human
- Quality or format consistency is critical every time

**How to create:**
1. Enable "skill-creator" official skill (Settings → Capabilities)
2. Describe your workflow to skill-creator
3. Review and refine the generated skill
4. Enable and start using account-wide

**Comparison:**

| Feature | Account Skills | Custom Instructions | Local Skills |
|---------|---------------|---------------------|--------------|
| **Availability** | claude.ai + Code + API | claude.ai only | Claude Code CLI only |
| **Scope** | Per-task workflows | Global role context | Project-specific |
| **Portability** | All projects | All chats | Single codebase |
| **Best For** | Repeated workflows | Professional role | Project knowledge |

**Token Savings Example (Projected):**
- Without skills: ~3,000 tokens per email (context setting)
- With skills: ~1,200 tokens (60% savings)

**Docs:** [Claude Skills Complete Guide](../04_browser-workflow/01_must-have/10_claude-skills-complete-guide.md)

**Related:**
- [Local Claude Code Skills](SKILLS_PARADIGM.md) - Project-specific skills for CLI
- [Custom Instructions Guide](../04_browser-workflow/README.md) - Global role preferences

**Keywords:** skills, account-level, reusable, portable, stackable, skill-creator, workflows, automation, token efficiency

---

## Commands (Slash)

**What:** Custom slash commands for common project tasks

**Location:** `.claude/commands/*.md`

**Built-in commands:**

### /onboarding
Generate friendly project onboarding guide
```bash
/onboarding
```

### /standards
Quick reference to coding standards
```bash
/standards
```

### /test
Run project test suite with proper reporting
```bash
/test
```

### /build
Build project and report errors
```bash
/build
```

### /review
Code review against project standards
```bash
/review [file]
```

**How to create custom commands:**
1. Create `.md` file in `.claude/commands/`
2. Filename becomes command name
3. File content is the prompt Claude executes

**Example:**
```markdown
# File: .claude/commands/deploy.md
Run the deployment process:
1. Run tests
2. Build production bundle
3. Deploy to staging
4. Show deployment URL
```

**Docs:** [Agent Setup Guide § Slash Commands](02_project-onboarding/01_must-have/03_claude-agent-setup.md)

**Keywords:** custom commands, slash, workflow, automation

---

## Cost Savings

**What:** Strategies to reduce Claude Code token costs by 50-95%

**📝 Note:** Savings examples are theoretical projections based on Anthropic pricing and author's experience.

**3 Main Strategies:**

### 1. CLAUDE.md (95% context savings - projected)
- Write project context once
- Claude reads it instead of exploring files
- Saves ~20K tokens per context query (estimated)

### 2. Model Switching (92% implementation savings - projected)
- Use Sonnet for planning (smarter)
- Switch to Haiku for implementation (92% cheaper)
- Pattern: Plan → Switch → Implement

### 3. Prompt Optimization (50-80% query savings - projected)
- Be specific, provide context
- Reference files with `@` mentions
- Tell Claude what to skip
- Use @prompt-polisher agent

**Projected savings (examples):**
- Single developer: $20-40/month (theoretical)
- Team of 5: $100-200/month (theoretical)
- Enterprise (20+ devs): $500-1000/month (theoretical)

**Example calculation:**
```
Without optimization: 100 queries × $0.30 = $30
With CLAUDE.md: 100 queries × $0.015 = $1.50
Example savings: $28.50 (95%)
```

_Note: This is a new project. Help us validate these projections with your real usage!_

**Docs:**
- [Model Switching Guide](01_global-setup/02_good-to-have/01_model-switching.md)
- [Prompt Optimization Guide](02_project-onboarding/02_good-to-have/01_prompt-optimization.md)

**Keywords:** money, savings, cheap, expensive, tokens, cost, budget

---

## Custom Agents

**What:** Specialized AI assistants for specific workflows

**Built-in agents:** 2 sophisticated agents included

### 1. Prompt Polisher Agent
**Purpose:** Transform vague prompts into optimized requests

**Usage:**
```bash
@prompt-polisher [your vague prompt]
```

**Features:**
- 14 optimization techniques
- Intelligent selection based on complexity
- 50-80% token savings
- Educational (teaches WHY)

**Example:**
```bash
Before: "Fix the bug"
After: "Fix the authentication bug in src/auth.ts:45 where
       users with special characters in email can't log in.
       Error: 'Invalid email format'. Skip test files."
```

**Location:** `.claude/agents/prompt-polisher.md`

### 2. Project Planner Agent
**Purpose:** Plan NEW projects before writing code

**Usage:**
```bash
@project-planner I want to build [project idea]
```

**Features:**
- 6-perspective design (Psychology, Education, Engineering, Product, DevOps, Security)
- 4-phase conversation (25-30 min)
- Outputs: Planning summary, tech stack, CLAUDE.md draft, next steps

**Location:** `.claude/agents/project-planner.md`

### 3. Mode Selector Agent
**Purpose:** Choose between Vibe Coding (speed) and Vibe Engineering (quality)

**Usage:**
```bash
@mode-selector I'm about to [describe task]. What mode should I use?
```

**Features:**
- 6-dimension context analysis (phase, requirements, longevity, risk, team size, timeline)
- Confidence-scored recommendations
- Transition guidance (prototype → production)
- Prevents over-engineering MVPs and under-engineering production systems

**Location:** `.claude/agents/mode-selector.md`
**Docs:** `docs/01-fundamentals/01_vibe-coding-vs-engineering.md`

**How to create custom agents:**
1. Create `.md` file in `.claude/agents/`
2. Define agent purpose and behavior
3. Invoke with `@agent-name`

**Docs:**
- [Agent Coordination Guide](01_global-setup/03_nice-to-have/03_agent-coordination.md)
- [Prompt Polisher Details](.claude/agents/prompt-polisher.md)
- [Project Planner Details](.claude/agents/project-planner.md)
- [Mode Selector Details](.claude/agents/mode-selector.md)

**Keywords:** agents, subagents, specialized, workflow, automation, @mention

---

## Educational Modes

**What:** Special output modes when learning new concepts

**Two modes available:**

### 1. Explanatory Mode
Detailed explanations with context for every change

**Best for:**
- Understanding complex logic
- Architectural decisions
- Connecting concepts

**Example output:**
```
Added error handling using try-catch because:
- The API call can fail due to network issues
- We need user-friendly messages
- Application should gracefully degrade
- Follows project pattern in auth.ts
```

### 2. Learning Mode
Step-by-step breakdown with educational notes

**Best for:**
- First exposure to patterns
- Breaking down unfamiliar code
- Learning new frameworks

**Example output:**
```
Step 1: Convert .then() to async/await
Why: More readable, better error handling

Step 2: Add try-catch
Why: Async functions can throw

Learning note: Async/await is syntactic sugar for Promises
```

**How to enable:**
```bash
# Request by mode name
"Use explanatory mode for this task"
"Use learning mode to teach me this"

# Or request naturally
"Explain this refactoring in detail"
"Teach me how this works step by step"
```

**When to use:**
- 🆕 First-time learners: Use 80-90% of the time
- 📚 Intermediate devs: Use 40-60% when learning new patterns
- 🚀 Advanced devs: Use 10-20% in unfamiliar domains

**Available in:** Claude Code v2.0+

**Docs:** [Quick Start Guide § Educational Modes](01_global-setup/01_must-have/02_quick-start.md#educational-output-styles)

**Keywords:** learning, teaching, explain, understand, beginner, tutorial

---

## File Locations

**Quick file finder** - Where is X located?

| What You're Looking For | Location |
|------------------------|----------|
| **Entry Points** | |
| 5-minute demo | `docs/5_MINUTE_SUCCESS.md` |
| Visual flowchart | `docs/VISUAL_QUICKSTART.md` |
| Main README | `README.md` |
| Persona selector | `START_HERE.md` |
| Visual guides | `VISUAL_GUIDES.md` |
| Quick reference | `QUICK_REFERENCE.md` (this file!) |
| **Templates** | |
| CLAUDE.md template | `templates/CLAUDE.md.template` |
| Coding standards template | `templates/coding-standards.md.template` |
| Project plan template | `templates/project-plan-template.md` |
| **Configuration** | |
| Claude settings | `.claude/settings.json` |
| Settings explained | `.claude/settings-explained.json` |
| Setup context (for Claude) | `.claude/SETUP_CONTEXT.md` |
| **Slash Commands** | |
| All commands | `.claude/commands/*.md` |
| Onboarding command | `.claude/commands/onboarding.md` |
| Standards command | `.claude/commands/standards.md` |
| Test command | `.claude/commands/test.md` |
| Build command | `.claude/commands/build.md` |
| Review command | `.claude/commands/review.md` |
| **Custom Agents** | |
| All agents | `.claude/agents/*.md` |
| Prompt Polisher | `.claude/agents/prompt-polisher.md` |
| Project Planner | `.claude/agents/project-planner.md` |
| **Wizards** | |
| Main wizard | `scripts/claude-wizard.sh` |
| Wizard helpers | `scripts/wizard-helpers.sh` |
| First-time wizard | `scripts/wizard-first-time.sh` |
| Quick setup wizard | `scripts/wizard-quick-setup.sh` |
| Advanced wizard | `scripts/wizard-advanced.sh` |
| Team lead wizard | `scripts/wizard-team-lead.sh` |
| Returning user wizard | `scripts/wizard-returning.sh` |
| **Documentation** | |
| Installation guide | `01_global-setup/01_must-have/01_installation.md` |
| Quick start guide | `01_global-setup/01_must-have/02_quick-start.md` |
| Permission modes | `01_global-setup/01_must-have/03_permission-modes.md` |
| Model switching | `01_global-setup/02_good-to-have/01_model-switching.md` |
| MCP setup | `01_global-setup/02_good-to-have/02_mcp-setup.md` |
| Security guide | `01_global-setup/03_nice-to-have/01_security-guide.md` |
| Project onboarding | `02_project-onboarding/01_must-have/01_onboarding-guide.md` |
| Prompt optimization | `02_project-onboarding/02_good-to-have/01_prompt-optimization.md` |
| Team onboarding | `02_project-onboarding/02_good-to-have/03_team-onboarding.md` |
| Planning guide | `03_pre-project-planning/01_must-have/01_planning-guide.md` |

**Keywords:** find, location, path, where, file

---

## Keyboard Shortcuts

**Essential shortcuts** for faster Claude Code usage

**Universal Shortcuts** (CLI + VS Code Extension):

| Shortcut | Action | Use When |
|----------|--------|----------|
| `Esc` `Esc` | Rewind/Undo last changes | Made a mistake, want to undo |
| `Ctrl-b` | Run command in background | Long-running commands (tests, builds) |
| `Tab` | Toggle thinking on/off | Want to see/hide Claude's reasoning |
| `Shift-Tab` | Cycle permission modes | Switch between plan/ask/acceptEdits |

**VS Code Extension Only:**

| Shortcut | Action |
|----------|--------|
| `Cmd-N` / `Ctrl-N` | New conversation |
| `Cmd-Shift-P` | Command palette (Claude commands) |

**Permission Mode Indicators:**
- ⏸ plan mode - Shows plan before executing
- ❓ ask mode - Asks permission for each tool
- 🔓 acceptEdits mode - Auto-applies changes

**Docs:** [Quick Start Guide § Keyboard Shortcuts](01_global-setup/01_must-have/02_quick-start.md#part-46-keyboard-shortcuts--productivity)

**Keywords:** shortcuts, hotkeys, keybindings, keyboard, fast, quick

---

## MCP Servers

**What:** Model Context Protocol servers that extend Claude's capabilities

**Built-in / Recommended MCP Servers:**

### Sequential Thinking
- Enables multi-step reasoning
- Better problem-solving
- Install: Included by default

### Memory (Knowledge Graph)
- Persistent knowledge storage
- Remembers context across sessions
- Install: `claude mcp add memory`

### Filesystem
- Advanced file operations
- Install: Included by default

### GitHub
- Repository operations
- PR management, issue tracking
- Install: `claude mcp add github`

### Context7
- Up-to-date library documentation
- Eliminates API hallucinations
- Install: `claude mcp add context7 npx -- -y @upstash/context7-mcp`
- API key: Get free tier at https://context7.com/dashboard

**How to check MCP status:**
```bash
claude
/mcp
# Shows all connected MCP servers
```

**Configuration location:** `.claude/settings.json`

**Docs:** [MCP Setup Guide](01_global-setup/02_good-to-have/02_mcp-setup.md)

**Keywords:** mcp, servers, extensions, plugins, integrations, context7, memory, github

---

## Model Switching

**What:** Switch between Claude models mid-conversation for optimal cost/performance

**The 3 Models:**

| Model | Cost | Best For | Speed |
|-------|------|----------|-------|
| **Haiku** | $0.25/M input, $1.25/M output (cheapest) | Exploration, file reading, mechanical tasks | Fastest |
| **Sonnet** | $3/M input, $15/M output (balanced) | Implementation, coding, refactoring | Medium |
| **Opus** | $15/M input, $75/M output (most capable) | Architecture, planning, complex analysis | Slower |

**Commands:**
```bash
/model haiku    # Switch to cheapest (exploration, simple edits)
/model sonnet   # Switch to balanced (implementation)
/model opus     # Switch to most powerful (architecture)
```

**The Three-Question Method (v3.11.0):**

```
1. Is this CREATIVE or ARCHITECTURAL work? → Opus
2. Does this involve WRITING CODE? → Sonnet
3. Is this MECHANICAL or EXPLORATORY? → Haiku
```

**Agent-Level Model Defaults:**

Configure agents to auto-select optimal models:
```markdown
# .claude/agents/explorer.md
model: haiku  # File reading is cheap and fast

# .claude/agents/implementer.md
model: sonnet  # Code writing needs balance

# .claude/agents/architect.md
model: opus  # Architecture needs deep reasoning
```

**When to use each:**
- **Haiku:** File exploration, simple edits, prompt optimization, quality checks
- **Sonnet:** Feature implementation, refactoring, bug fixes, code review
- **Opus:** Architecture decisions, multi-perspective analysis, high-stakes planning

**Cost comparison (10K input, 2K output):**
- Opus: $0.30 | Sonnet: $0.06 | Haiku: $0.005
- **Haiku is 91% cheaper than Sonnet for exploration tasks**

**Important:** Model switches reset context, but CLAUDE.md persists!

**Docs:**
- [Model Switching Guide](../../01_global-setup/02_good-to-have/01_model-switching.md)
- [Model Selection Strategy](../02-optimization/MODEL_SELECTION_STRATEGY.md) (comprehensive guide)

**Keywords:** models, haiku, sonnet, opus, switch, cost, cheap, expensive, /model, agent defaults

---

## Permission Modes

**What:** Control how Claude makes changes to your codebase

**The 3 Modes:**

### ⏸ Plan Mode (RECOMMENDED for setup)
**What it does:** Claude shows you a plan BEFORE executing

**When to use:**
- Initial setup and learning
- Complex tasks
- Team environments
- Any time you want to review first

**Toggle:** Press `Shift-Tab`

### ❓ Ask Mode
**What it does:** Claude asks permission for EVERY tool use

**When to use:**
- Maximum control
- Sensitive operations
- Production environments

**Toggle:** Press `Shift-Tab` twice

### 🔓 AcceptEdits Mode
**What it does:** Claude automatically applies changes

**When to use:**
- After you're comfortable
- Repetitive tasks
- When speed is critical

**⚠️ NOT recommended for:**
- Setup or learning
- Team onboarding
- First time using features

**Toggle:** Press `Shift-Tab` (cycle through modes)

**Configuration:**
```json
// In .claude/settings.json
{
  "permissions": {
    "defaultMode": "plan"  // or "ask" or "acceptEdits"
  }
}
```

**Docs:** [Permission Modes Guide](01_global-setup/01_must-have/03_permission-modes.md)

**Keywords:** permissions, plan, ask, accept, modes, safety, control, shift-tab

---

## Git Workflow & Commit Approval

**What:** Configure Claude to always show commit messages for approval before committing

**Quick Start:**
```bash
./scripts/setup-git-workflow.sh
```

**Or Ask Claude:** "Help me set up git commit approval"

**The 3 Options:**

### 1️⃣  Full Protection (Recommended)
- Approval required for all git operations
- Permission mode: plan
- Best for: Teams, learning, safety-critical work

### 2️⃣  Commit-Only Protection
- Approval required only for commits
- Permission mode: acceptEdits (fast for file changes)
- Best for: Solo developers who want speed with safety

### 3️⃣  Minimal Protection
- Approval only for commits and destructive operations
- Permission mode: acceptEdits
- Best for: Experienced users who want maximum speed

**How It Works:**
1. You: "Commit these changes"
2. Claude: Shows drafted commit message and files
3. Claude: "Should I proceed with this commit?"
4. You: "Yes" or "No, change it to..."
5. Claude: Only commits after approval

**Git Push:**
- **Note:** Git push commands are displayed, not executed
- **Why:** Authentication requires interactive credential input
- **Solution:** Copy and run the command Claude shows you

**Manual Configuration:**
```json
// ~/.claude/settings.json (global)
{
  "permissions": {
    "defaultMode": "plan",  // or "acceptEdits"
    "neverAutoApprove": [
      "Bash(git commit*)",
      "Bash(git push*)"
    ]
  }
}
```

**Docs:**
- [Git Approval Workflow](01_global-setup/02_good-to-have/04_git-approval-workflow.md)
- [Git Push Workaround](01_global-setup/02_good-to-have/05_git-push-workaround.md)
- [Wizard Script](scripts/setup-git-workflow.sh)

**Keywords:** git, commit, approval, workflow, push, authentication, wizard, global

---

## Personas (User Profiles)

**What:** 5 user profiles with customized setup paths

**Choose your persona:**

### 🆕 First-Time Learner
- **Time:** 60-90 minutes
- **For:** New to Claude Code
- **Get:** Complete understanding + working setup
- **Path:** [START_HERE.md#first-time-learner](START_HERE.md#first-time-learner)

### ⚡ Quick Setup
- **Time:** 15-30 minutes
- **For:** Experienced, need fast project setup
- **Get:** Configured project, ready to code
- **Path:** [START_HERE.md#quick-setup-user](START_HERE.md#quick-setup-user)

### 🚀 Advanced Optimizer
- **Time:** 20-40 minutes
- **For:** Want security hooks, custom agents, MCP
- **Get:** Production-grade advanced features
- **Path:** [START_HERE.md#advanced-optimizer](START_HERE.md#advanced-optimizer)

### 👥 Team Lead
- **Time:** 90-120 minutes
- **For:** Setting up for entire team
- **Get:** Repeatable deployment process
- **Path:** [START_HERE.md#team-lead](START_HERE.md#team-lead)

### 🔄 Returning User
- **Time:** 10-20 minutes
- **For:** Used before, need refresher
- **Get:** Quick command review
- **Path:** [START_HERE.md#returning-user](START_HERE.md#returning-user)

**Visual guide:** [docs/VISUAL_QUICKSTART.md](docs/VISUAL_QUICKSTART.md)

**Keywords:** personas, profiles, paths, routes, beginner, advanced, team, first-time

---

## Skills (v3.3.0+)

**What:** Organized collections of expertise that Claude can automatically invoke

**How they work:**
- Activate automatically based on context
- Provide insights without explicit invocation
- READ-only (complement CLI tools)
- 58% token savings vs manual commands

### Projects Registry Skill

**Purpose:** Multi-project management intelligence

**Example queries:**
```
"What projects need updates?"
"Show my production projects"
"Where is the ClientA project?"
"Which React projects are outdated?"
```

**Token savings:** 600 tokens → 250 tokens (58% reduction)

**Location:** `.claude/skills/projects-registry/`

**Complements:** CLI tools (`./scripts/claude-projects.sh`)

### Skills vs Agents vs Commands

| Feature | Skills | Agents | Commands |
|---------|--------|--------|----------|
| Invoke | Automatic | `@agent-name` | `/command` |
| Purpose | Knowledge | Task execution | Workflow |
| Scope | READ-only | READ+WRITE | READ+WRITE |
| Best for | Frequent queries | Complex tasks | Repeated ops |

**Docs:**
- [Skills Paradigm](SKILLS_PARADIGM.md)
- [Projects Registry Skill](.claude/skills/projects-registry/SKILL.md)

**Keywords:** skills, expertise, automatic, knowledge, intelligence

---

## Security Hooks

**What:** Automated security checks that run before Claude executes commands

**Available hooks:**

### Prompt Injection Detection
- Scans prompts for injection attempts
- Warns before execution
- Location: `examples/hooks/detect-prompt-injection.js`

### Response Scanning
- Checks Claude's responses for sensitive data
- Prevents accidental exposure of credentials
- Location: `examples/hooks/response-scanner.js`

**How to install:**
1. Copy hook to `.claude/hooks/`
2. Make executable: `chmod +x .claude/hooks/*.js`
3. Configure in `.claude/settings.json`

**Example config:**
```json
{
  "hooks": {
    "preToolUse": [".claude/hooks/detect-prompt-injection.js"],
    "postResponse": [".claude/hooks/response-scanner.js"]
  }
}
```

**Docs:** [Security Guide](01_global-setup/03_nice-to-have/01_security-guide.md)

**Keywords:** security, safety, hooks, injection, validation, protection

---

## Package Security (OPTIONAL)

**What:** Protection against npm/Python malware attacks in your Claude Code projects

**Note:** OPTIONAL - Only implement if your projects use package managers (npm, pip, etc.)

**This template has zero dependencies** - Package security is preventative documentation for YOUR projects.

### Quick Start

**JavaScript/NPM:**
```bash
# 1. Copy .npmrc to block install scripts
cp /path/to/claude-config-template/.npmrc .

# 2. Weekly audit
npm audit

# 3. Commit lockfile
git add package-lock.json
```

**Python/pip:**
```bash
# 1. Copy pip.conf to prefer wheels
cp /path/to/claude-config-template/pip.conf .

# 2. Weekly audit
pip install pip-audit && pip-audit

# 3. Pin versions
pip freeze > requirements.txt
```

### Universal Principles (ALL Languages)

Works with npm, pip, gem, cargo, go, Maven, NuGet, etc.

1. ✅ Verify before install (check downloads, maintainers)
2. ✅ Block auto-execution (disable install scripts)
3. ✅ Lock dependencies (commit lockfiles)
4. ✅ Regular audits (weekly scans)
5. ✅ Minimal dependencies (reduce attack surface)
6. ✅ Inspect critical code (review source)

### Available Resources

**Universal Guide:**
- [Package Security Principles](01_global-setup/03_nice-to-have/02_package-security-principles.md) - Works with ALL languages

**NPM/JavaScript:**
- [NPM Security Checklist](01_global-setup/03_nice-to-have/03_npm-security-checklist.md) - 2-minute scan
- [NPM Security Guide](01_global-setup/03_nice-to-have/04_npm-security-guide.md) - Comprehensive (653 lines)
- Automation scripts: `examples/npm-security/` (5 scripts)

**Python/pip:**
- [Python Security Checklist](01_global-setup/03_nice-to-have/03_python-security-checklist.md) - 2-minute scan
- [Python Security Guide](01_global-setup/03_nice-to-have/05_python-security-guide.md) - Comprehensive (557 lines)
- Automation scripts: `examples/python-security/` (5 scripts)

### When to Use

**Implement if:**
- ✅ Your Claude Code projects install npm packages
- ✅ Your projects use pip/Python packages
- ✅ You work in teams with package managers
- ✅ You deploy projects to production

**Skip if:**
- ❌ Documentation-only projects (like this template)
- ❌ No third-party packages installed
- ❌ Languages without package managers

### Real Threats (Factual)

- **event-stream (NPM, 2018):** 2M weekly downloads compromised
- **ctx/php (Python PyPI, 2022):** AWS credentials exfiltrated
- **rest-client (Ruby, 2019):** Backdoor from compromised account

**Keywords:** npm, pip, malware, supply chain, typosquatting, lockfile, audit, poetry, dependencies, security

---

## Setup Paths

**Quick decision:** What should I do first?

### ⚡ Super Fast (5 minutes)
**Goal:** See the value immediately

**Do this:**
1. Go to [docs/5_MINUTE_SUCCESS.md](docs/5_MINUTE_SUCCESS.md)
2. Copy CLAUDE.md template
3. Add one sentence
4. Test with Claude

**Result:** Demonstrated 99% token savings

---

### 🎯 Fast Setup (15-30 minutes)
**Goal:** Get project ready to code

**Do this:**
```bash
cd /your/project
cp -r ~/claude-config-template/.claude .
cp ~/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md
# Edit CLAUDE.md with your project details
claude
```

**Result:** Fully configured project

**Guide:** [START_HERE.md#quick-setup-user](START_HERE.md#quick-setup-user)

---

### 📚 Complete Learning (60-90 minutes)
**Goal:** Understand everything

**Do this:**
1. Read [Installation Guide](01_global-setup/01_must-have/01_installation.md)
2. Read [Quick Start](01_global-setup/01_must-have/02_quick-start.md)
3. Read [Model Switching](01_global-setup/02_good-to-have/01_model-switching.md)
4. Set up first project

**Result:** Complete understanding + setup

**Guide:** [START_HERE.md#first-time-learner](START_HERE.md#first-time-learner)

---

### 🧙 Wizard-Guided (Time varies)
**Goal:** Let the wizard guide you

**Do this:**
```bash
cd ~/claude-config-template
./scripts/claude-wizard.sh
```

**Result:** Validated setup with knowledge checks

---

**Keywords:** setup, start, begin, getting started, first steps, how to

---

## Token Optimization

**What:** Strategies to reduce token usage by 50-95%

**Top 5 Techniques:**

### 1. Use CLAUDE.md
- Saves 95% on context queries
- Write context once, reuse forever
- [See CLAUDE.md section](#claudemd-template)

### 2. Be Specific
```bash
# Bad (20K tokens)
"Fix the bug"

# Good (2K tokens)
"Fix the authentication bug in src/auth.ts:45 where
 users with special characters in email can't log in.
 Error: 'Invalid email format'. Skip test files."
```

### 3. Use @-mentions
```bash
# References files without reading them
"Update the error handling in @src/auth.ts"
```

### 4. Tell Claude What to Skip
```bash
"Add logging to all API routes. Skip: test files,
 node_modules, examples, documentation"
```

### 5. Use Model Switching
- Sonnet for planning (smart)
- Haiku for implementation (cheap)
- [See Model Switching section](#model-switching)

**Tools:**
- @prompt-polisher agent (transforms vague→optimized)
- SETUP_CONTEXT.md (for Claude to read first)

**Docs:** [Prompt Optimization Guide](02_project-onboarding/02_good-to-have/01_prompt-optimization.md)

**Keywords:** tokens, optimization, savings, reduce, efficient, cheap

---

## Template Gallery (v4.3.0)

**What:** Curated collection of 9 domain-specific templates demonstrating inheritance and parameterization

**Location:** `examples/team-templates/`

**Templates Available:**
- `gallery-frontend-react` - React + TypeScript + Tailwind
- `gallery-backend-api` - Node.js/Python API development
- `gallery-data-science` - Python data science with Jupyter/ML
- `gallery-devops` - Kubernetes, Terraform, CI/CD
- `gallery-fullstack` - Customizable full-stack (5 parameters)

**Features:**
- Demonstrates template inheritance (extends field)
- Shows parameter substitution (${varName})
- Ready-to-use configurations for common scenarios
- 9 total templates (4 base + 5 gallery)

**How to Use:**
1. Browse catalog: `cat examples/team-templates/catalog.json | jq`
2. Inspect template: `cat examples/team-templates/gallery-frontend-react.json | jq`
3. Validate: `./scripts/validate-template.sh examples/team-templates/gallery-frontend-react.json`
4. Copy and customize OR use apply script (v4.5.0)

**Documentation:** [Template Gallery Guide](../02-optimization/TEMPLATE_GALLERY_GUIDE.md)

**Keywords:** templates, gallery, examples, inheritance, parameters, domain-specific

---

## Template Validator (v4.4.0)

**What:** Validate template JSON files against Claude preferences schema

**Script:** `scripts/validate-template.sh`

**Features:**
- JSON syntax validation
- Schema compliance checking (claude-preferences-export-v1)
- 3-level validation (Critical/Important/Info)
- Catalog validation with --catalog flag
- Batch validation for directories

**Usage:**
```bash
# Single template
./scripts/validate-template.sh examples/team-templates/gallery-frontend-react.json

# All templates in directory
./scripts/validate-template.sh examples/team-templates/

# Catalog file
./scripts/validate-template.sh --catalog examples/team-templates/catalog.json
```

**Validation Levels:**
- **Critical (Errors):** JSON syntax, schema, required fields (id, name, minVersion)
- **Important (Warnings):** Description, category enum, semver version, checksum
- **Info:** extends inheritance, parameters, recommendedFor

**Exit Codes:**
- 0: All validations passed (warnings OK)
- 1: One or more critical errors

**Documentation:** [Template Validator Guide](../04-ecosystem/TEMPLATE_VALIDATOR_GUIDE.md)

**Keywords:** validate, validation, template, schema, quality, lint, check

---

## Template Application (v4.5.0)

**What:** Apply templates to projects with inheritance and parameter resolution

**Script:** `scripts/apply-template.sh`

**Features:**
- Template search by ID or file path
- Automatic inheritance resolution
- Parameter substitution (CLI or interactive)
- Preview with diff before applying
- Backup creation

**Usage:**
```bash
# Simple template (no params)
./scripts/apply-template.sh team-standard

# Template with inheritance
./scripts/apply-template.sh gallery-frontend-react

# Parameterized template (CLI)
./scripts/apply-template.sh gallery-fullstack \
    --param frontendFramework=react \
    --param backendFramework=fastapi

# Interactive mode (prompts for params)
./scripts/apply-template.sh gallery-fullstack
```

**How It Works:**
1. Finds template by ID or path
2. Resolves `extends` inheritance chains
3. Discovers and collects `${varName}` parameters
4. Merges parent + child + parameters
5. Generates preview (.claude/settings.preview.json)
6. Shows diff against current settings
7. Asks for confirmation
8. Creates backup and applies

**Documentation:** [Apply Template Guide](../04-ecosystem/APPLY_TEMPLATE_GUIDE.md)

**Keywords:** apply, template, inheritance, parameters, merge, preview

---

## Troubleshooting

**Common issues and quick fixes:**

### Issue: Settings not loading
**Symptoms:** Claude doesn't respect .claude/settings.json

**Fix:**
```bash
# Validate JSON syntax
cat .claude/settings.json | python -m json.tool

# Common issues:
# - Trailing comma on last property
# - Missing comma between properties
# - Unquoted string values
```

---

### Issue: CLAUDE.md not found
**Symptoms:** Claude says it can't find CLAUDE.md

**Fix:**
- CLAUDE.md must be in PROJECT ROOT (not .claude/)
- Verify: `ls -la CLAUDE.md` from project root
- Check filename exactly: CLAUDE.md (all caps)

---

### Issue: Wizard won't run
**Symptoms:** Permission denied or command not found

**Fix:**
```bash
chmod +x scripts/*.sh
./scripts/claude-wizard.sh
```

---

### Issue: Context7 not working
**Symptoms:** MCP shows "disconnected"

**Fix:**
1. Check MCP status: `/mcp`
2. Verify API key in `.claude.json` (NOT committed to git)
3. Check internet connection
4. Context7 falls back to WebSearch automatically

---

### Issue: Checkpointing/Rewind not working
**Symptoms:** Esc Esc doesn't undo

**Causes:**
- Not in active Claude session
- No changes made yet (need at least one edit)
- Session was restarted (checkpoints don't persist)

**Fix:** Make a change first, then try Esc Esc

---

### Issue: Model switching seems expensive
**Symptoms:** Unexpectedly high costs

**Cause:** Context transfer when switching models

**Fix:**
- Use CLAUDE.md (reduces context size)
- Don't switch models mid-implementation
- Switch once: Sonnet (plan) → Haiku (implement)
- Not: Sonnet → Haiku → Sonnet → Haiku

**Docs:** [Model Switching § When Not to Switch](01_global-setup/02_good-to-have/01_model-switching.md)

---

**More help:**
- Run `/doctor` in Claude Code for diagnostics
- Check [START_HERE.md](START_HERE.md) persona checklist
- Read specific guide for your issue

**Keywords:** problem, error, issue, help, not working, broken, fix

---

## Update System

**What:** Keep your template up-to-date with latest improvements

**Check for updates:**
```bash
./scripts/claude-update.sh --check
```

**Apply updates:**
```bash
./scripts/claude-update.sh --apply
```

**Rollback if needed:**
```bash
./scripts/claude-update.sh --rollback
```

**Features:**
- ✅ 3-way merge (preserves your customizations)
- ✅ Automatic backups before updating
- ✅ Persona-specific update notifications
- ✅ Rollback capability

**Current version:** v4.5.2

**Docs:** [CHANGELOG.md](CHANGELOG.md)

**Keywords:** update, upgrade, version, latest, new, changes, changelog

---

## Visual Guides

**What:** 5 Mermaid diagrams explaining key concepts

**Available guides:**

### 1. Configuration Hierarchy
Shows where settings come from (global vs project)

### 2. Model Selection Flowchart
Decision tree: which model for which task?

### 3. CLAUDE.md Anatomy
Visual breakdown of what to document

### 4. Setup Roadmap
Time estimates by persona with visual progression

### 5. Token Cost Waterfall
Visualize 92% savings with optimizations

**Format:** Mermaid diagrams + ASCII alternatives

**Location:** [VISUAL_GUIDES.md](VISUAL_GUIDES.md)

**NEW in v2.5.0:**
- [Visual Quickstart](docs/VISUAL_QUICKSTART.md) - Decision flowchart

**Keywords:** visual, diagram, flowchart, graphic, image, picture

---

## Wizards

**What:** Interactive setup scripts with validation

**Main wizard:**
```bash
cd ~/claude-config-template
./scripts/claude-wizard.sh
```

**Features:**
- Persona selection (6 options)
- Step-by-step guidance
- JSON validation
- Knowledge checks (15+ quizzes)
- Progress tracking
- Celebratory milestones

**5 Persona-Specific Wizards:**

### First-Time Learner Wizard
- 60-90 min complete learning path
- Script: `scripts/wizard-first-time.sh`

### Quick Setup Wizard
- 15-30 min fast project setup
- Script: `scripts/wizard-quick-setup.sh`

### Advanced Optimizer Wizard
- 20-40 min advanced features
- Script: `scripts/wizard-advanced.sh`

### Team Lead Wizard
- 90-120 min team deployment
- Script: `scripts/wizard-team-lead.sh`

### Returning User Wizard
- 10-20 min quick refresher
- Script: `scripts/wizard-returning.sh`

**If wizard fails:**
- Check permissions: `chmod +x scripts/*.sh`
- Check dependencies: bash, python
- Manual setup: Use START_HERE.md

**Keywords:** wizard, interactive, setup, guided, assistant, automation

---

## 💡 Pro Tips

### Tip 1: Start with the 5-Minute Win
Even if you're experienced, [docs/5_MINUTE_SUCCESS.md](docs/5_MINUTE_SUCCESS.md) demonstrates the value in 5 minutes.

### Tip 2: Bookmark This File
Press `Cmd+D` (Mac) or `Ctrl+D` (Windows) to bookmark. Use Cmd+F to find anything instantly.

### Tip 3: Use the Visual Flowchart
Can't decide which path? [docs/VISUAL_QUICKSTART.md](docs/VISUAL_QUICKSTART.md) has an interactive decision tree.

### Tip 4: Model Switching is Your Friend
Plan with Sonnet, implement with Haiku. Save 92% on implementation costs.

### Tip 5: CLAUDE.md Evolves
Don't try to write a perfect CLAUDE.md upfront. Start with basics, add as you go.

---

## 🚀 Next Steps

**If you're new here:**
1. Try the [5-Minute Win](docs/5_MINUTE_SUCCESS.md)
2. Use the [Visual Flowchart](docs/VISUAL_QUICKSTART.md) to choose your path
3. Run the wizard: `./scripts/claude-wizard.sh`

**If you're set up already:**
- Keep this file bookmarked for quick reference
- Check [Update System](#update-system) for new versions
- Share with your team: [Team Onboarding](02_project-onboarding/02_good-to-have/03_team-onboarding.md)

**If you're stuck:**
- Search this file with Cmd+F
- Check [Troubleshooting](#troubleshooting)
- Read the detailed guide for your issue

---

## Navigation

**🏠 [Back to README](README.md)** | **🗺️ [Choose Your Path](START_HERE.md)** | **⚡ [5-Minute Win](docs/5_MINUTE_SUCCESS.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/your-repo) - v4.5.2*

*Last updated: 2025-12-08*
