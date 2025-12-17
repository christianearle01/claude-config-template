# Quick Reference - Claude Code Template

**How to use:** Press `Cmd+F` (Mac) or `Ctrl+F` (Windows) and search for any keyword.

**Purpose:** Find any feature, command, or concept instantly without browsing documentation.

---

## 📖 Table of Contents (Alphabetical)

Jump to any section:

- [Background Tasks](#background-tasks)
- [Breadcrumb Navigation](#breadcrumb-navigation)
- [Checkpointing / Rewind](#checkpointing--rewind)
- [Cheatsheets](#cheatsheets)
- [CLAUDE.md Template](#claudemd-template)
- [Claude Skills (Account-Level)](#claude-skills-account-level)
- [Commands (Slash)](#commands-slash)
- [Cost Savings](#cost-savings)
- [Decision Framework](#decision-framework)
- [Custom Agents](#custom-agents)
- [Educational Modes](#educational-modes)
- [File Locations](#file-locations)
- [Git Workflow & Commit Approval](#git-workflow--commit-approval)
- [Integration Patterns](#integration-patterns)
- [Keyboard Shortcuts](#keyboard-shortcuts)
- [MCP Servers](#mcp-servers)
- [Model Switching](#model-switching)
- [Permission Modes](#permission-modes)
- [Progress Bars](#progress-bars)
- [Prompt Patterns](#prompt-patterns)
- [Personas (User Profiles)](#personas-user-profiles)
- [Security Hooks](#security-hooks)
- [Setup Paths](#setup-paths)
- [Token Optimization](#token-optimization)
- [Troubleshooting](#troubleshooting)
- [Update System](#update-system)
- [Visual Guides](#visual-guides)
- [Wizards](#wizards)
- [Workflow Examples](#workflow-examples)

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

### /release (NEW in v4.19.0)
Orchestrate complete release workflow with validation
```bash
/release
```

**What it does:**
- Step 1: Quality checks (@quality-reviewer)
- Step 2: Version verification (all files synced)
- Step 3: Changelog validation (entry complete)
- Step 4: Git state verification (clean + ready)
- Step 5: Deployment readiness (@deployment-readiness)

**Output:** Comprehensive release report with confidence scoring

**Pass criteria:** All 5 steps ≥85% confidence

**Token savings:** 3,700 → 1,200 tokens (68% reduction, projected)

**Time savings:** 25-35 min → 2-3 min per release

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

## Decision Framework

**What:** Structured approach to choosing the right tool for each task (v4.18.0)

**Purpose:** Master WHEN to use WHAT tool and WHY - eliminates integration paralysis

**Core problem solved:**
- "I know what each tool does, but which one should I use NOW?"
- Having powerful tools but not knowing which to choose
- Over-using complex tools for simple tasks
- Missing skill shortcuts that save tokens

**Key components:**

### Tool Selection Matrix
Quick reference matching task types to recommended tools:
- Read known file → Read tool (100-500 tokens)
- Find files by pattern → Glob tool (50-200 tokens)
- Search code → Grep tool (100-300 tokens)
- Explore unknown codebase → Explore agent (1K-3K tokens)
- Plan implementation → Plan agent (2K-5K tokens)
- Complex decision → Adversarial-validator (3K-8K tokens)
- Repeated query → Skill auto-invocation (250-600 tokens)

### Complexity Flowchart
When to escalate from simple to complex tools:
1. Known file location? → Use Read directly
2. Simple pattern search? → Use Glob/Grep
3. Need to understand structure? → Use Explore agent
4. Multiple valid approaches? → Use Adversarial-validator
5. Need to plan changes? → Use Plan agent

### Decision Trees by Task Type
- **Bug Fix:** Known file? → Read → Edit; Unknown? → Grep/Explore → Fix
- **New Feature:** Well-defined? → Plan → Implement; Unclear? → Project-planner first
- **Refactoring:** Clear scope? → Plan → Implement; Unclear? → Explore → Adversarial-validator
- **Optimization:** Code performance? → Profile → Plan; Token usage? → Mode-selector → Prompt-polisher

### Anti-Patterns to Avoid
- Over-using agents for simple tasks (Explore when Grep suffices)
- Using sequential-thinking for trivial decisions
- Skipping exploration phase in complex tasks
- Not using skills for repeated questions
- Using wrong model (Opus for exploration, Haiku for architecture)

**Usage:**
1. Define the task (what am I trying to accomplish?)
2. Choose simplest tool that works
3. Escalate only if needed

**Value:**
- 40% faster tool selection (< 30 seconds decision time)
- Avoid over-engineering (right complexity for the situation)
- Learn meta-skill (decision-making, not just tools)

**Docs:** [Decision Framework Guide](../01-fundamentals/09_decision-framework.md)

**See also:** [Workflow Examples](#workflow-examples) - Decision framework applied to real scenarios

**Keywords:** tool selection, which tool, when to use, decision making, integration, complexity, escalation, meta-learning

---

## Custom Agents

**What:** Specialized AI assistants for specific workflows

**Built-in agents:** 8 sophisticated agents included (5 shown below, plus initializer, coder, quality-reviewer)

### 1. Prompt Polisher Agent
**Purpose:** Transform vague prompts into optimized requests

**Usage:**
```bash
@prompt-polisher [your vague prompt]

# Or with specific mode:
@prompt-polisher improve only: [prompt]        # Fast mode
@prompt-polisher educational: [prompt]         # Deep learning mode
```

**NEW in v4.17.0: Fabric-Inspired Enhancements**
- **Inspiration:** Enhanced with insights from [Fabric's improve_prompt pattern](https://github.com/danielmiessler/fabric)
- **Three output modes:** Fast, Balanced, Educational
- **Diff view:** See before/after changes with rationale (educational mode)
- **Learning pathways:** Links to Prompting Fundamentals and Pattern Library
- **Standalone version:** Works in any LLM (`examples/improve-prompt-standalone.md`)

**Features:**
- 14 optimization techniques (3-tier system)
- Intelligent selection based on complexity
- 50-80% token savings (projected)
- Educational (teaches WHY improvements work)

**Three Output Modes:**

**Mode 1: 🚀 Improved Only (Fast)**
- Polished prompt + brief impact + one key learning
- Minimal explanation, maximum speed
- Request with: "improve only", "fast mode"

**Mode 2: 📚 With Explanation (Default)**
- Analysis + polished prompt + improvements + impact + techniques
- Balanced speed and education
- Default behavior

**Mode 3: 🎓 Educational (Deep Learning)**
- Detailed analysis + diff view + learning pathway + personalized next steps
- Maximum learning, builds mastery
- Request with: "educational", "show diff", "teach me"

**Example:**
```bash
Before: "Fix the bug"
After: "Fix the authentication bug in src/auth.ts:45 where
       users with special characters in email can't log in.
       Error: 'Invalid email format'. Skip test files."
```

**Locations:**
- Agent: `.claude/agents/prompt-polisher.md`
- Standalone (any LLM): `examples/improve-prompt-standalone.md`

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

### 4. Adversarial Validator Agent (NEW in v4.13.0)
**Purpose:** Generate and evaluate competing solutions using playoff method

**Usage:**
```bash
@adversarial-validator [decision to make]
```

**Features:**
- 3-persona generation (Optimist, Pragmatist, Innovator)
- Adversarial critique evaluates all solutions
- Confidence-scored recommendations (0.0-1.0 with breakdown)
- Shows winner + when to choose alternatives
- Iteration support ("try solution B instead")

**Example:**
```bash
@adversarial-validator What database should we use for our SaaS app?

Result:
🚀 Optimist: MongoDB (speed) - Confidence: 0.72
⚖️ Pragmatist: PostgreSQL (balance) - Confidence: 0.89
💡 Innovator: CockroachDB (future-proof) - Confidence: 0.58
👁️ Critic: PostgreSQL wins - team skill match, proven at scale
```

**When to use:**
- Multiple valid implementation approaches exist
- High-stakes decisions (architecture, tech stack)
- Need to explore solution space systematically
- Want automated quality through competition

**Location:** `.claude/agents/adversarial-validator.md`
**Inspired by:** [YouTube video](https://www.youtube.com/watch?v=pwWBcsxEoLk) - Adversarial validation (playoff method)

### 5. Deployment-Readiness Agent (NEW in v4.19.0)
**Purpose:** Validate code is ready for deployment with confidence-scored readiness report

**Usage:**
```bash
@deployment-readiness
# or
"Is this ready to deploy?"
"Check deployment readiness"
```

**Features:**
- 5 parallel checks: Tests, Security, Documentation, Version, Git State
- Confidence-scored report (0.0-1.0)
- Platform-agnostic (pre-deploy validation, not execution)
- Ready/Conditional/Not-Ready status with fix estimates
- Orchestrates: quality-reviewer, security-scanner, documentation-sync, version-management

**Output example:**
```markdown
✅ Ready to deploy! (91% confidence)

Checks passed:
- Tests: 127/127 passing (95% confidence)
- Security: No vulnerabilities (94% confidence)
- Documentation: Up-to-date (88% confidence)
- Version: v4.19.0 bumped (92% confidence)
- Git: Clean state (100% confidence)

No blockers. Safe for production deployment.
```

**When to use:**
- Before deploying to production (full validation)
- Staging deployments (lighter checks)
- Hotfix urgency (critical checks only)
- Part of `/release` workflow

**Status guide:**
- ✅ Ready (≥85%): Safe to deploy to production
- ⚠️ Conditional (60-84%): Staging okay, fix for prod
- ❌ Not Ready (<60%): Must fix blockers first

**Location:** `.claude/agents/deployment-readiness.md`
**Validates:** v4.18.0 integration patterns (agent orchestration)

---

**How to create custom agents:**
1. Create `.md` file in `.claude/agents/`
2. Define agent purpose and behavior
3. Invoke with `@agent-name`

**Docs:**
- [Agent Coordination Guide](01_global-setup/03_nice-to-have/03_agent-coordination.md)
- [Prompt Polisher Details](.claude/agents/prompt-polisher.md)
- [Project Planner Details](.claude/agents/project-planner.md)
- [Mode Selector Details](.claude/agents/mode-selector.md)
- [Adversarial Validator Details](.claude/agents/adversarial-validator.md)
- [Deployment-Readiness Details](.claude/agents/deployment-readiness.md)

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
| Release command | `.claude/commands/release.md` |
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

## Integration Patterns

**What:** How to combine tools effectively for maximum impact (v4.18.0)

**Purpose:** Master HOW tools work together - not just individual capabilities

**Core problem solved:**
- Running tools sequentially when parallel is possible (2x slower)
- Using Explore agent when Grep + Read suffices (3x tokens)
- Missing skill shortcuts that eliminate agent overhead
- Not knowing which agent combinations work best

**Key patterns:**

### Sequential Tool Chains
When tools depend on each other's output:
- **Investigate → Decide → Implement:** Grep/Explore → Read → Sequential-thinking/Adversarial-validator → Edit → Test → Commit
- **Explore → Plan → Domain Memory:** Explore → Plan → Initializer → Coder (multi-session)
- **Mode-Selector → Specialized Agent:** Mode-selector → Appropriate agent with right complexity

### Parallel Tool Usage
When tools are independent (run simultaneously):
- **Multi-File Reading:** Read 3 files at once (66% faster)
- **Multi-Agent Exploration:** Explore auth + API + models in parallel
- **Validation in Parallel:** Security-scanner + Test-generator + Standards-enforcer

### Agent Combinations
Common effective pairings:
- **Initializer + Coder:** Domain memory pattern for multi-session projects
- **Plan + Quality-Reviewer:** Implementation strategy + validation
- **Explore + Adversarial-Validator:** Understand patterns + decide between approaches
- **Mode-Selector + Prompt-Polisher:** Determine mode + optimize with selected complexity

### Skill Integration
How skills provide shortcuts:
- **Skill → Agent:** Skill answers question (250 tokens), agent acts on answer
- **Command → Skill → Agent:** Command triggers, skill diagnoses, agent fixes
- **Agent → Skill:** Agent proposes, skill validates feasibility

### Anti-Patterns to Avoid
- ❌ Sequential when parallel is possible (wasted time)
- ❌ Over-using agents for simple tasks (Read file? Don't use Explore)
- ❌ Skipping exploration before decision (leads to rework)
- ❌ Wrong model for agent (Opus for exploration = 3x cost)
- ❌ Not using skills for repeated queries (600 tokens vs 250)

**Examples:**
- [Bug Fix Workflow](../../examples/workflows/01_bug-fix-workflow.md) - Grep → Read → Edit (simple integration)
- [New Feature Workflow](../../examples/workflows/02_new-feature-workflow.md) - Initializer + Coder (domain memory)
- [Refactor Workflow](../../examples/workflows/03_refactor-workflow.md) - Explore + Adversarial-validator
- [Optimization Workflow](../../examples/workflows/04_optimization-workflow.md) - Mode-selector + Prompt-polisher

**Value:**
- 19% token savings from reduced regrounding (domain memory pattern)
- 66% time savings from parallel execution
- 44% diagnosis efficiency (skill shortcuts)
- Prevents architectural regret (validation patterns)

**Docs:** [Integration Patterns Guide](../02-optimization/06_integration-patterns.md)

**See also:** [Decision Framework](#decision-framework) - Which tool to use; [Workflow Examples](#workflow-examples) - Integration in practice

**Keywords:** integration, combining tools, parallel, sequential, agent combinations, skill shortcuts, patterns, efficiency

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

## Prompting Fundamentals

**What:** Foundational guide to effective AI prompting

**Purpose:** Teach the meta-skill of clarity and how to prompt Claude effectively

**→ [Complete Prompting Fundamentals Guide](../01-fundamentals/07_prompting-fundamentals.md)**

### Quick Concepts

**8 Core Principles:**

1. **How AI Actually Works** - LLMs are prediction engines, not magic
2. **Meta-Skill of Clarity** - Clear thinking → clear prompts
3. **Prompting is Programming** - Call to action, not question
4. **Permission to Fail** - #1 hallucination fix: "If uncertain, say 'I don't know'"
5. **Context is King** - Never assume AI knows, always provide context
6. **Few-Shot > Zero-Shot** - Show examples, don't just describe
7. **When to Use Chain of Thought** - Decision tree for COT vs direct prompting
8. **Draft → Plan → Act** - Why plan mode exists and works

### Before vs After Examples

**❌ Vague (without fundamentals):**
```
"Fix the bug"
"Make it better"
"Add authentication"
```

**✅ Clear (with fundamentals):**
```
"Fix the authentication bug in src/auth.ts:45 where users with
special characters in email can't log in. Error: 'Invalid email format'.
If the solution isn't clear from the code, say 'I need more context'."
```

### Quick Decision Tree

**Use this guide when:**
- First time using Claude Code (foundational)
- Getting unclear or hallucinated responses
- Want to reduce token costs through better prompts
- Teaching others how to use AI effectively

**See full guide for:**
- Mental models (prediction engine vs magic)
- Adversarial validation (playoff method)
- Output requirements specification
- Educational examples from this template

**Complements:**
- [Coding Principles Handbook](../01-fundamentals/06_coding-principles-handbook.md) - WHAT to write
- Prompting Fundamentals - HOW to ask for it

**Keywords:** prompting, clarity, context, hallucinations, few-shot, chain of thought, meta-skill, prediction engine

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

## Prompt Patterns

**What:** Copy-paste templates for common AI prompting scenarios

**Purpose:** Reusable prompt structures that get better results faster

**10 Patterns Available:**

### Foundational Patterns
1. **Context-Rich Request** - Provide comprehensive background (60-80% fewer clarifications)
2. **Permission to Fail** - Reduce hallucinations by 95%
3. **Output Requirements** - Standardize response format (70% fewer revisions)

### Reasoning Patterns
4. **Chain of Thought** - Step-by-step thinking for complex decisions
5. **Few-Shot Scaffolding** - Show examples (85% reduction in formatting corrections)
6. **Iterative Refinement** - Draft → Plan → Act (90% less rework)

### Specialized Patterns
7. **Role-Based Persona** - Expert perspective (50% deeper insights)
8. **Constraint Specification** - Clear boundaries (80% fewer back-and-forth cycles)
9. **Example-Driven Generation** - Pattern matching (95% time savings)
10. **Verification Checklist** - Quality assurance (66% reduction in incidents)

**Quick Example (Context-Rich Request):**
```
I'm working on [PROJECT NAME/TYPE].

Context:
- Tech stack: [languages, frameworks, libraries]
- Architecture: [monolith/microservices, patterns]
- Current state: [what exists now]
- Problem: [what's not working or missing]

Goal: [specific outcome you want]

Requirements:
- [bullet point 1]
- [bullet point 2]
- [bullet point 3]

Constraints:
- [limitations]
```

**Pattern Selection Quick Guide:**
- Simple task? → Direct request (no pattern)
- Have examples? → Use Few-Shot (#5)
- Research/facts? → Use Permission to Fail (#2)
- Complex decision? → Use Chain of Thought (#4)
- Need specific format? → Use Output Requirements (#3)
- Need context? → Use Context-Rich (#1)

**Combining Patterns:**
Patterns work better together! Example: Context + Output Requirements + Verification

**Full Library:** `docs/01-fundamentals/08_prompt-patterns.md` (~550 lines)

**Related:**
- [Prompting Fundamentals](../01-fundamentals/07_prompting-fundamentals.md) - Learn the theory
- [Adversarial Validator Agent](#custom-agents) - 3-persona decision exploration
- [Prompt Polisher Agent](#custom-agents) - Transform vague prompts

### Standalone Patterns (NEW in v4.17.0)

**What:** Copy-paste patterns that work in ANY LLM (ChatGPT, Gemini, local models)

**Why:** Share patterns with non-Claude-Code teams, use in browser, API, etc.

#### Improve Prompt Pattern (Fabric-Inspired)

**File:** `examples/improve-prompt-standalone.md`

**How to use:**
1. Copy entire file into any LLM
2. Say "improve my prompt: [vague prompt]"
3. Get improved prompt with explanation

**Features:**
- 6 core optimization techniques
- Before/after examples
- Quick reference guide
- Educational approach (shows WHY, not just WHAT)

**Credit:** Inspired by [Fabric's improve_prompt pattern](https://github.com/danielmiessler/fabric) by Daniel Miessler

**Philosophy:**
- Fabric optimizes for **speed** and immediate gratification
- Our approach optimizes for **depth** and long-term competence
- **Complementary, not competing:** Use Fabric for quick wins, our trilogy for mastery

**Related:**
- [Prompting Fundamentals](../01-fundamentals/07_prompting-fundamentals.md) - Understanding WHY
- [Prompt Pattern Library](../01-fundamentals/08_prompt-patterns.md) - 10 copy-paste templates
- [@prompt-polisher agent](#custom-agents) - 3 output modes

### Three Output Modes (@prompt-polisher agent)

The prompt-polisher agent now supports graduated complexity (v4.17.0):

**Mode 1: 🚀 Improved Only (Fabric-Fast)**
```bash
@prompt-polisher improve only: [your prompt]
```
- Polished prompt + brief impact + ONE key learning
- Minimal explanation, maximum speed
- **Use when:** Time pressure, quick wins, exploring

**Mode 2: 📚 With Explanation (Default)**
```bash
@prompt-polisher [your prompt]
```
- Full analysis + polished prompt + improvements + techniques
- Balanced speed and education
- **Use when:** Standard usage, learning while improving

**Mode 3: 🎓 Educational (Deep Learning)**
```bash
@prompt-polisher educational: [your prompt]
```
- Detailed analysis + **diff view** + learning pathway + next steps
- Maximum learning, builds mastery
- **Use when:** Deliberate learning, building long-term skills

**Diff View Example (Mode 3):**
```diff
- Original: "Fix the login bug"
+ Polished: "Fix the login authentication bug in `app/auth/LoginController.ts`"

Why this change:
- Added file path (Technique #1: Be Specific)
- Specified bug type "authentication"
- Token impact: Eliminates 2,000 token file discovery phase
```

**Pattern:** Choose mode based on current need (speed vs depth)

**Keywords:** prompting, templates, patterns, reusable, copy-paste, examples, best practices, clarity, fabric, standalone, modes

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

### Documentation-Sync-Checker Skill (ENHANCED in v4.19.0)

**Purpose:** Documentation consistency validation + auto-generation

**Features:**
- **Validation (v3.5.0):** Version consistency, broken links, cross-references, stale content
- **Auto-Generation (NEW v4.19.0):** Function docstring templates, README updates for new files, API change detection

**Example queries:**
```
"Are docs in sync?"
"Check for broken links"
"Document this function"
"Generate docs for new code"
"What docs need updating?"
```

**Auto-Generation Examples:**
- Detect undocumented function → suggest JSDoc/docstring template
- Detect new file → suggest README section with usage example
- Detect API signature change → flag affected documentation locations

**Token savings:**
- Validation: 800 → 300 tokens (62% reduction)
- Auto-generation: 1,200 → 400 tokens (67% reduction)
- Combined monthly savings: ~5,500 tokens

**Location:** `.claude/skills/documentation-sync-checker/`

**Integration:** Uses v4.14.0 Prompt Patterns (Output Requirements, Few-Shot Scaffolding, Context-Rich Request)

**Examples:** See `.claude/skills/documentation-sync-checker/examples/auto-generation.md`

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
- [Documentation-Sync-Checker Skill](.claude/skills/documentation-sync-checker/SKILL.md)
- [Auto-Generation Examples](.claude/skills/documentation-sync-checker/examples/auto-generation.md)

**Keywords:** skills, expertise, automatic, knowledge, intelligence

---

## Cheatsheets

Quick reference guides for common tasks. More detailed than skills, focused on immediate problem-solving.

**When to use:** You need a quick answer to "How do I..." without reading full skill documentation.

### Available Cheatsheets

1. **API Debugging** (`.claude/skills/api-debugging/cheatsheet.md`)
   - HTTP status codes (200, 401, 403, 404, 500, etc.)
   - CORS issues and fixes
   - Common error patterns
   - Authentication troubleshooting
   - **Use when:** API request fails, unclear error response

2. **Component Finder** (`.claude/skills/component-finder/cheatsheet.md`)
   - React component search patterns
   - Vue component location patterns
   - Angular component structure
   - **Use when:** Can't find where UI element is defined

3. **Commit Readiness** (`.claude/skills/commit-readiness-checker/cheatsheet.md`)
   - Pre-commit validation checklist
   - Version bump verification
   - Changelog requirements
   - **Use when:** Ready to commit but want to verify completeness

4. **Projects Registry** (`.claude/skills/projects-registry/cheatsheet.md`)
   - Multi-project tracking commands
   - Registry query patterns
   - Status checking shortcuts
   - **Use when:** Managing multiple Claude Code projects

5. **Version Management** (`.claude/skills/version-management/cheatsheet.md`)
   - Version sync commands
   - File consistency checks
   - Release checklist
   - **Use when:** Bumping version or releasing new version

6. **Testing Workflow** (`.claude/skills/testing-workflow/cheatsheet.md`)
   - Test execution commands
   - Failure diagnosis patterns
   - Coverage checking shortcuts
   - **Use when:** Running tests or debugging test failures

**Pattern:** Each cheatsheet lives alongside its parent skill as `cheatsheet.md`

**Related:** See [Skills](#skills-v330) for full skill documentation

**Keywords:** cheatsheets, quick reference, how-to, troubleshooting, debugging, testing, version, commit

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

---

## 📖 Coding Principles

**→ [Complete Principles Handbook](../01-fundamentals/06_coding-principles-handbook.md)**

### Quick Lookup

| Principle | Key Question | Example from Project |
|-----------|--------------|----------------------|
| **SOLID** | Is my code modular? | Each skill = one responsibility |
| **DRY** | Am I repeating logic? | Version sync script (single source) |
| **KISS** | Is this simplest solution? | Markdown catalog (not JSON+generator) |
| **YAGNI** | Do I need this now? | Removed unused JSON catalog |
| **Vibe Coding** | Speed or structure? | 6-dimension decision framework |
| **Trust but Verify** | Did I check Ctrl+O? | Prevents fake actions |
| **Quality-First** | Will quality gates help? | Automated checks enable speed |
| **Big O** | Time complexity? | Think O(n) vs O(n²) upfront |

**Progressive learning:**
- **Beginner**: Anti-Patterns → KISS → YAGNI
- **Intermediate**: SOLID → Quality-First → Verification
- **Advanced**: Security → Agent Design → Algorithmic Efficiency

**See handbook for:**
- Complete examples from this project
- Context-specific principles (AI-assisted coding, Vibe Engineering)
- Cross-references to detailed guides

---

### Package Security - Universal Principles (ALL Languages)

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

## YouTube Sources

**What:** Central reference for all 10 YouTube videos that inspired template features

**Location:** [YouTube Sources Reference](../04-ecosystem/11_youtube-sources.md)

**Purpose:** Quick scan of all video sources without searching multiple files

**10 Videos Included:**
1. You SUCK at Prompting AI → Prompting Fundamentals (v4.12.0)
2. Anthropic 10× Claude Code → Prompt optimization
3. AI Agents That Actually Work → Domain Memory (v3.6.0)
4. AI-Native Companies → "Code wins" philosophy
5. Vibe Coding to Vibe Engineering → Mode selector (v4.9.0)
6. State of AI Code Quality → Quality Workflows (v3.7.0)
7. Jewels Proactive Patterns → Proactive Intelligence (v3.5.0)
8. Vibe Coding vs AI Augmented → Workflow patterns
9. 800+ Hours Experience → Real-world best practices
10. Claude Code Skills → Skills paradigm

**Each video includes:**
- Direct YouTube link
- What it inspired (features/docs)
- Referenced in (file list)
- Key takeaways

**Verification:** All links verified as of 2025-12-17 (v4.12.0)

**Keywords:** youtube, videos, sources, inspiration, references, credits

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

## Progress Bars

Visual workflow transparency for multi-step operations. Added in v4.16.0.

**Related Guide:** [`docs/04-ecosystem/02_progress-bar-guide.md`](../04-ecosystem/02_progress-bar-guide.md)

### Four Progress Patterns

1. **Simple Progress** (single bar)
   ```bash
   show_progress 3 5 "Installing dependencies"
   # [■■■□□] 60% - Installing dependencies (3/5)
   ```
   - **Use when:** Single-phase task, < 5 steps
   - Example: File copy, package install

2. **Nested Progress** (phase + task)
   ```bash
   show_phase_progress 2 3 "Configuration"
   show_task_progress 3 5 "Writing settings.json"
   # Phase: [■■□] 67% - Configuration (2/3)
   # Task:  [■■■□□] 60% - Writing settings.json (3/5)
   ```
   - **Use when:** Multi-phase workflow, >= 5 tasks total
   - Example: Wizard with Setup → Configure → Validate phases

3. **Dynamic Updates** (real-time updates)
   ```bash
   # Initial display
   show_phase_progress 1 3 "Validation"
   show_task_progress 1 10 "Validating template 1"

   # Update progress (overwrites previous)
   CURRENT_TASK=2
   TASK_NAME="Validating template 2"
   update_progress  # Re-renders both bars
   ```
   - **Use when:** Long-running operation with many incremental updates
   - Uses ANSI cursor movement to update in-place (no scrolling)

4. **Adaptive Progress** (auto-nests based on complexity)
   ```bash
   show_adaptive_progress 8 12 "Complex workflow"
   # Automatically uses nested if PROGRESS_NESTED_THRESHOLD met
   ```
   - **Use when:** Workflow complexity varies
   - Threshold: Default 5 tasks (configure via `PROGRESS_NESTED_THRESHOLD`)

### Configuration

Set in `~/.claude/progress-bar-config` or environment:
```bash
PROGRESS_NESTED_ENABLED=true        # Enable nested progress
PROGRESS_NESTED_THRESHOLD=5         # Auto-nest if >= 5 tasks
PROGRESS_UPDATE_RATE_MS=100         # Min time between updates (ms)
PROGRESS_DYNAMIC_UPDATE=true        # Enable ANSI cursor movement
PROGRESS_PHASE_LABEL="Phase"        # Phase bar label
PROGRESS_TASK_LABEL="Task"          # Task bar label
```

### Interactive Demo

Run the demo to see all 4 patterns:
```bash
bash examples/progress-nested-example.sh
```

Demonstrates:
- Simple progress (5 steps)
- Nested progress (3 phases, 5 tasks each)
- Dynamic updates (real-time progress bar updates)
- Adaptive progress (switches based on threshold)

**Why it matters:**
- **Psychological:** Transparency reduces anxiety during long operations
- **Educational:** Users see workflow structure (phases → tasks)
- **Professional:** CLI standards matching tools like npm, cargo

**Keywords:** progress, progress bar, visual feedback, transparency, nested, dynamic, adaptive, workflow, UX

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

## Workflow Examples

**What:** End-to-end scenarios showing tool selection and integration in practice (v4.18.0)

**Purpose:** Learn decision-making by seeing real workflows - not just tool documentation

**Core problem solved:**
- "I understand individual tools, but how do I use them together?"
- Decision paralysis when facing real tasks
- Not knowing if you're using optimal approach
- Learning through trial-and-error instead of examples

**Available workflows:**

### 1. Bug Fix Workflow
**Scenario:** Authentication error in production
**Tools:** Grep → Read → Edit → Test → Commit
**Complexity:** Simple (minimal escalation)
**Tokens:** ~1,800 tokens
**Time:** 15 minutes

**Key learning:**
- Start with simplest tool (Grep for error message)
- Escalate only if needed (didn't need Explore agent)
- Alternative approach: 5,400 tokens (3x more!) if used Explore first

**File:** [examples/workflows/01_bug-fix-workflow.md](../../examples/workflows/01_bug-fix-workflow.md)

---

### 2. New Feature Workflow
**Scenario:** Build user profile page with avatar upload
**Tools:** Initializer (Opus) → Coder (Sonnet) across 3 sessions
**Complexity:** High (multi-session, domain memory)
**Tokens:** ~8,500 tokens across sessions
**Time:** 3 sessions (~90 minutes total)

**Key learning:**
- Domain memory pattern prevents regrounding (19% savings)
- Bootup ritual maintains context across sessions
- Atomic feature delivery (test each incrementally)
- Alternative approach: 15,000 tokens (67% more!) without domain memory

**File:** [examples/workflows/02_new-feature-workflow.md](../../examples/workflows/02_new-feature-workflow.md)

---

### 3. Refactoring Workflow
**Scenario:** Extract duplicate auth logic across 7 components
**Tools:** Explore (Haiku) → Adversarial-validator (Opus) → Edit → Test
**Complexity:** Medium (architectural decision)
**Tokens:** ~5,200 tokens
**Time:** 45 minutes

**Key learning:**
- Explore discovered 7 duplications (not just 5 reported)
- Adversarial-validator compared 3 valid approaches
- Confidence scoring (88%) prevented architectural regret
- Alternative approach: 6,200 tokens (15% more) if guessed approach

**File:** [examples/workflows/03_refactor-workflow.md](../../examples/workflows/03_refactor-workflow.md)

---

### 4. Optimization Workflow
**Scenario:** User writes verbose prompts (150 tokens when 30 suffices)
**Tools:** Mode-selector → Prompt-polisher (Educational mode)
**Complexity:** Low-Medium (graduated complexity)
**Tokens:** 1,200 tokens (educational) OR 400 tokens (fast) depending on mode
**Time:** 20 minutes

**Key learning:**
- Mode-selector determined learning value was high (95%)
- Educational mode: 1,200 upfront, saves 122 tokens/prompt forever
- Break-even: 10 prompts (~2 weeks)
- Fast mode after learning principles (200 tokens)

**File:** [examples/workflows/04_optimization-workflow.md](../../examples/workflows/04_optimization-workflow.md)

---

**How to use these:**
1. **Find similar scenario** - Match your task to workflow type
2. **Follow decision points** - See why each tool was chosen
3. **Apply patterns** - Use same decision framework for your tasks
4. **Compare alternatives** - Learn from "what if we'd done X instead?"

**Token impact:**
- Bug fix: 67% savings (simple tools vs agents)
- New feature: 19% savings (domain memory vs ad-hoc)
- Refactoring: 15% savings (validation vs guessing)
- Optimization: 28x ROI (2,250 investment → 63,360/year saved)

**See also:**
- [Decision Framework](#decision-framework) - Tool selection principles
- [Integration Patterns](#integration-patterns) - How tools combine

**Keywords:** examples, workflows, end-to-end, scenarios, real-world, bug fix, new feature, refactoring, optimization, domain memory, adversarial validation, token savings

---

## Navigation

**🏠 [Back to README](README.md)** | **🗺️ [Choose Your Path](START_HERE.md)** | **⚡ [5-Minute Win](docs/5_MINUTE_SUCCESS.md)**

---

*Part of the [Claude Code Configuration Template](https://github.com/christianearle01/claude-config-template) - v4.5.2*

*Last updated: 2025-12-08*
