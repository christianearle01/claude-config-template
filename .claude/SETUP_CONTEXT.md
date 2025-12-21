# Setup Context - Read This First

**Purpose:** Token-optimized guide for Claude to provide efficient setup assistance.

**Instructions for Claude:** Read this file first before exploring the template. It contains everything needed to help users set up this configuration efficiently.

---

## Template Overview (30-Second Scan)

**What is this?** Claude Code configuration template with 50-95% projected token savings.

**Core Value Propositions:**
1. CLAUDE.md system → 95% context token reduction
2. Model switching (Sonnet→Haiku) → 92% cost savings
3. Persona-based setup → 5 user profiles (60s to 120min paths)
4. Visual guides → 40% cognitive load reduction
5. Interactive wizards → Validated setup with knowledge checks
6. Template system (v4.0-v4.5) → Apply team configs with one command
7. Package security (OPTIONAL) → Malware protection for npm/Python projects

**Current Version:** v4.21.0

**Need to update an existing project?** → See [`UPDATE_GUIDE.md`](../docs/04-ecosystem/09_update-guide.md) for quick commands

---

## Directory Structure (What's Where)

```
claude-config-template/
├── docs/                          # Learning journey structure (v3.0.0)
│   ├── 00-start-here/            # Quick start + anti-patterns
│   ├── 01-fundamentals/          # Skills, verification, shortcuts
│   ├── 02-optimization/          # Token saving strategies
│   ├── 03-advanced/              # Power user techniques
│   └── 04-ecosystem/             # Third-party tools, reference
│
├── 01_global-setup/               # One-time machine-wide setup
│   ├── 01_must-have/              # CRITICAL (installation, quick start, permissions)
│   ├── 02_good-to-have/           # HIGH-VALUE (model switching, MCP servers)
│   └── 03_nice-to-have/           # ADVANCED (security, agents)
│
├── 02_project-onboarding/         # Per-project setup (EXISTING codebases)
│   ├── 01_must-have/              # Project setup essentials
│   └── 02_good-to-have/           # Optimization guides
│
├── 03_pre-project-planning/       # NEW projects (plan BEFORE coding)
│   └── 01_must-have/              # Planning guide
│
├── 04_browser-workflow/           # Role-based browser configs (9 roles)
│   └── 01_must-have/              # Custom Instructions + Skills guide
│
├── templates/                     # Reusable templates
│   ├── CLAUDE.md.template         # Project memory template (284 lines)
│   ├── coding-standards.md.template
│   └── project-plan-template.md
│
├── scripts/                       # Interactive wizards
│   ├── claude-wizard.sh           # Main entry point
│   ├── wizard-helpers.sh          # Validation functions
│   └── wizard-[persona].sh        # 5 persona-specific wizards
│
├── examples/                      # Example configs (hooks, MCP, security)
│   ├── npm-security/              # NPM malware protection (5 scripts) - OPTIONAL
│   └── python-security/           # Python malware protection (5 scripts) - OPTIONAL
├── .claude/                       # Claude Code configuration
│   ├── settings.json              # Optimized settings
│   ├── agents/                    # Custom agents (6 agents)
│   ├── commands/                  # Slash commands (3 commands)
│   ├── skills/                    # Skills (personalization-engine, projects-registry, mode-selector)
│   └── SETUP_CONTEXT.md          # This file!
│
└── [Entry Points]
    ├── README.md                  # Landing page (will be 250 lines)
    ├── docs/00-start-here/        # Entry points and navigation
    │   ├── QUICK_WIN.md           # Quick win path
    │   ├── docs/00-start-here/personas/README.md          # Detailed persona router
    │   └── docs/00-start-here/06_visual-guides.md       # 5 Mermaid diagrams
```

---

## Critical Files (Read These for Setup Help)

### Entry Points (User's First Touch)
- **docs/00-start-here/05_anti-patterns.md** - ⚠️ READ FIRST! How projects fail (v3.0.0)
- **docs/00-start-here/03_5-minute-success.md** - 5-min demo (recommend this)
- **docs/00-start-here/07_visual-quickstart.md** - Visual flowchart for path selection
- **docs/README.md** - Master learning journey map (v3.0.0)
- **README.md** - Project overview and value props
- **docs/00-start-here/personas/README.md** - Persona selector with detailed paths

### Templates (What Users Copy)
- **templates/CLAUDE.md.template** (284 lines)
  - Project memory system
  - Users customize for each project
  - Location: Project root (not .claude/)

- **templates/coding-standards.md.template**
  - Global coding standards
  - Location: `~/.claude/coding-standards.md`

### Configuration Files
- **.claude/settings.json**
  - Optimized Claude Code settings
  - model: "sonnet", alwaysThinkingEnabled: true
  - defaultMode: "plan" (safety first)
  - Sandbox enabled

- **.claude/settings-explained.json**
  - Every setting documented with WHY

- **.claude/settings.local.json** (git-ignored)
  - Local development overrides (optional)
  - Never commit (contains dev-only permissions)
  - Automatically created/updated during active work

**Settings Files Pattern:**

| File | Purpose | Git Status |
|------|---------|------------|
| `settings.json` | Base configuration template | Committed |
| `settings.local.json` | Local dev overrides (optional) | Git-ignored |
| `settings-explained.json` | Educational reference | Committed |

**Usage:**
- `settings.json` - Main template users copy/customize
- `settings.local.json` - Personal overrides during development (never commit)
- `settings-explained.json` - Detailed documentation of all options

### MCP Servers

**GitHub MCP (Optional):**
- NOT required for template functionality
- Template author uses manual git + GitHub UI workflow
- Only install if you want Claude to create PRs/issues directly
- See `01_global-setup/02_good-to-have/02_mcp-setup.md` for setup (optional)

**Core MCPs (Recommended):**
- Sequential-Thinking MCP - Enhanced reasoning
- Memory MCP - Knowledge graph persistence
- Filesystem MCP - Advanced file operations

### Scripts & Wizards

**Location:** `scripts/` (19 shell scripts)

#### Interactive Setup Wizards
- **claude-wizard.sh** - Main wizard with persona selector
- **wizard-first-time.sh** - 60-90 min complete learning path
- **wizard-quick-setup.sh** - 15-30 min fast project setup
- **wizard-advanced.sh** - 20-40 min advanced features
- **wizard-team-lead.sh** - 90-120 min team deployment
- **wizard-returning.sh** - 10-20 min refresher
- **wizard-helpers.sh** - Validation functions for all wizards

#### Template Management (v4.x)
- **apply-template.sh** (v4.5.2) - Apply templates with inheritance + parameters
- **validate-template.sh** (v4.4.0) - Validate template JSON structure

#### Project Management (v3.2.0+)
- **claude-projects.sh** - CLI for multi-project registry
- **register-project.sh** - Interactive project registration wizard

#### Skills Management (v3.5.0+)
- **claude-skills.sh** - Skills catalog and management CLI

#### Quality & Analytics (v3.5.0+)
- **claude-health-check.sh** - System health check with confidence scoring
- **claude-analytics.sh** - Usage analytics and insights

#### Development Tools
- **setup-git-workflow.sh** (v2.9.0) - Git commit approval configuration
- **sync-version.sh** (v2.8.0) - Automated version updates across files
- **progress-bar-config.sh** (v3.1.0) - Global progress bar configuration
- **remove-commands.sh** (v3.4.0) - Clean up old slash commands
- **claude-update.sh** - Update template to latest version

---

## Common Setup Tasks (Token-Optimized Responses)

### Task 1: "Help me set up this template"

**Quick Response Pattern:**
1. Ask persona: "Are you new to Claude Code or experienced?"
2. Route to appropriate path:
   - New → docs/00-start-here/03_5-minute-success.md first, then wizard
   - Experienced → docs/00-start-here/personas/02_quick-setup-user.md
   - Team → docs/00-start-here/personas/04_team-lead.md
3. Recommend wizard: `./scripts/claude-wizard.sh`

**Files to Reference:**
- docs/00-start-here/07_visual-quickstart.md (decision tree)
- docs/00-start-here/personas/README.md (detailed paths)

### Task 2: "Copy template to my project"

**Quick Commands:**
```bash
# Navigate to user's project
cd /path/to/user/project

# Copy configuration
cp -r ~/claude-config-template/.claude .
cp ~/claude-config-template/templates/CLAUDE.md.template ./CLAUDE.md

# Customize CLAUDE.md
# (Guide user to edit lines 5, 10-20, 50-60 per template)
```

**Important Notes:**
- CLAUDE.md goes in project ROOT (not .claude/)
- .claude.json is git-ignored (contains API keys)
- .claude/ folder IS committed (shared config)

### Task 3: "What should I document in CLAUDE.md?"

**Essential Sections:**
1. **Business purpose** (WHAT app does, not HOW)
   - "This is a [type] app that [business value]"
   - Example: "E-commerce platform for selling handmade crafts"

2. **Tech stack** (HIGH-LEVEL only)
   - Languages, frameworks, database
   - NOT every library (Claude can see package.json)

3. **External APIs** (business purpose of each)
   - WHY you use each API
   - Example: "Stripe for payment processing"

4. **Code conventions** (project-specific)
   - Naming patterns, file structure rules

5. **Common commands**
   - dev server, tests, build, deploy

**Reference:** templates/CLAUDE.md.template (has inline guidance)

### Task 4: "Run the wizard"

**Command:**
```bash
cd ~/claude-config-template
./scripts/claude-wizard.sh
```

**What It Does:**
- Persona selector (6 options + exit)
- Routes to appropriate wizard script
- Validates each step (JSON syntax, file permissions)
- Knowledge checks (15+ quizzes)
- Progress tracking
- Celebratory milestones

**If Wizard Fails:**
- Check permissions: `chmod +x scripts/*.sh`
- Check dependencies: bash, python (for JSON validation)
- Manual setup: docs/00-start-here/personas/README.md → persona section

### Task 5: "Explain model switching"

**Token-Optimized Explanation:**

**Pattern:** Sonnet (plan) → Haiku (implement)

**Why:**
- Sonnet: Smarter, better at planning, exploring, architecture
- Haiku: 92% cheaper, good at following clear instructions
- Cost: $0.03 (planning) + $0.06 (impl) = $0.09 vs $0.75 (all Sonnet)
- Savings: 88%

**Commands:**
```bash
/model sonnet   # For planning
/model haiku    # For implementation
/model opus     # For very complex problems only
```

**Reference:** 01_global-setup/02_good-to-have/01_model-switching.md

### Task 6: "What are the 5 personas?"

**Quick Reference:**

1. **🆕 First-Time Learner** (60-90 min)
   - New to Claude Code
   - Complete learning path
   - File: docs/00-start-here/personas/01_first-time-learner.md

2. **⚡ Quick Setup** (15-30 min)
   - Experienced, fast project setup
   - File: docs/00-start-here/personas/02_quick-setup-user.md

3. **🚀 Advanced Optimizer** (20-40 min)
   - Security hooks, custom agents, MCP
   - File: docs/00-start-here/personas/03_advanced-optimizer.md

4. **👥 Team Lead** (90-120 min)
   - Team deployment
   - File: docs/00-start-here/personas/04_team-lead.md

5. **🔄 Returning User** (10-20 min)
   - Quick refresher
   - File: docs/00-start-here/personas/05_returning-user.md

### Task 7: "What's the fastest way to see value?"

**Answer:** docs/00-start-here/03_5-minute-success.md

### Task 8: "Which skills should I use?"

**Quick Answer:** See .claude/skills/SKILLS_CATALOG.md (case study from this template)

**IMPORTANT:** The 19 skills are EXAMPLES from this template's workflow, not universal requirements.

**This template is documentation-heavy:**
- 87 markdown files with 11 Mermaid diagrams → mermaid-validator exists
- Weekly releases → version-management exists
- Meta-work (skills about skills) → workflow-analyzer exists

**Your project is different:**
- API-only project? Skip mermaid-validator (no diagrams)
- No releases? version-management less critical
- Use **workflow-analyzer** to discover YOUR patterns

**The Meta-Skill (Start Here):**
**workflow-analyzer** - The truly universal skill
- Analyzes YOUR git commits
- Detects YOUR patterns (repeated tasks, token waste)
- Suggests skills based on YOUR workflow
- ROI calculation: "Is this pattern worth automating?"

**Skills Catalog Structure:**
1. **🆕 Foundation Skills** (3 skills) - Essential starting point
   - version-management, commit-readiness-checker, workflow-analyzer

2. **⚡ Optimization Skills** (10 skills) - Choose by YOUR project type
   - Documentation: documentation-sync-checker, mermaid-validator
   - TDD: testing-workflow, test-generator
   - API: api-debugging, security-scanner
   - Frontend: component-finder
   - Team: standards-enforcer, mode-selector
   - Domain Memory: project-analyzer

3. **🚀 Strategic Skills** (6 skills) - Power users (meta-skills)
   - workflow-analyzer, personalization-engine, project-onboarding-assistant
   - global-setup-assistant, pre-project-planning-assistant, projects-registry

**The Methodology > The List:**
- ✅ Learn: HOW to detect patterns (workflow-analyzer teaches this)
- ✅ Learn: WHEN to create skills (ROI > 3 uses, >500 tokens saved)
- ❌ Don't: Copy all 19 blindly
- ❌ Don't: Assume these are universal

**Skills Auto-Activate:** Just ask naturally, no configuration needed

**Reference:** .claude/skills/SKILLS_CATALOG.md

**Why:**
- 5 minutes total
- Demonstrates 99% token savings
- Builds confidence
- Clear next steps

**Next Step After 5-Min Win:**
- Convinced → Run wizard
- Want more info → docs/00-start-here/personas/README.md
- Just need commands → QUICK_REFERENCE.md (coming soon)

### Task 8: "How do I protect against package malware?" (OPTIONAL)

**Quick Answer:** OPTIONAL feature - only needed if your Claude Code projects install npm/Python packages.

**This template has zero dependencies** - package security is preventative docs for YOUR projects.

See [SETUP_OPTIONAL.md](SETUP_OPTIONAL.md) for:
- NPM security quick setup
- Python security quick setup
- When to implement (and when NOT to worry)
- Real threat examples (factual incidents)
- Complete resource links

---

## File Location Quick Reference

**User asks "where is X?":**

| What | Location |
|------|----------|
| CLAUDE.md template | templates/CLAUDE.md.template |
| Project settings | .claude/settings.json |
| Settings explained | .claude/settings-explained.json |
| Slash commands | .claude/commands/*.md |
| Custom agents | .claude/agents/*.md |
| Setup wizards | scripts/wizard-*.sh |
| Visual guides | docs/00-start-here/06_visual-guides.md |
| 5-min demo | docs/00-start-here/03_5-minute-success.md |
| Decision flowchart | docs/00-start-here/07_visual-quickstart.md |
| Installation guide | 01_global-setup/01_must-have/01_installation.md |
| Quick start | 01_global-setup/01_must-have/02_quick-start.md |
| Permission modes | 01_global-setup/01_must-have/03_permission-modes.md |
| Model switching | 01_global-setup/02_good-to-have/01_model-switching.md |
| MCP setup | 01_global-setup/02_good-to-have/02_mcp-setup.md |
| Security guide | 01_global-setup/03_nice-to-have/01_security-guide.md |
| Project onboarding | 02_project-onboarding/01_must-have/01_onboarding-guide.md |
| Team onboarding | 02_project-onboarding/02_good-to-have/03_team-onboarding.md |

---

## Custom Agents (5 Agents)

### 1. Initializer Agent (v3.6.0)
**Location:** .claude/agents/initializer.md

**Purpose:** Expand user intent into structured domain memory for long-running projects

**Key Features:**
- Creates features.json with task breakdown, dependencies, test criteria
- Defines bootup ritual checklist
- Domain memory architecture (Anthropic two-agent pattern)
- Outputs: Structured artifacts for project continuity

**Usage:** `@initializer [project idea or goal]`

### 2. Coder Agent (v3.6.0)
**Location:** .claude/agents/coder.md

**Purpose:** Execute atomic features with bootup ritual and persistent state

**Key Features:**
- Bootup ritual every session (read memory, verify state)
- Picks ONE feature atomically, builds incrementally
- Tests until passing, updates state, commits
- Suggests next task with confidence score
- 85% token reduction in regrounding

**Usage:** `@coder [continue/next feature]`

### 3. Quality Reviewer Agent (v3.11.0)
**Location:** .claude/agents/quality-reviewer.md

**Purpose:** Automated quality validation (security, testing, standards)

**Key Features:**
- Security scanner (OWASP top 10, CVE checks)
- Test generator (features.json integration)
- Standards enforcer (learns team preferences)
- Parallel quality gates
- 66% reduction in security incidents (projected)

**Usage:** `@quality-reviewer [review/scan/test]`

### 4. Prompt Polisher Agent (v2.4.0)
**Location:** .claude/agents/prompt-polisher.md

**Purpose:** Transform vague prompts into optimized, context-rich requests

**Key Features:**
- 14 optimization techniques (3-tier system)
- Intelligent selection based on task complexity
- 50-80% token savings
- Educational (teaches WHY each improvement helps)

**Usage:** `@prompt-polisher [user's vague prompt]`

### 5. Project Planner Agent (v2.3.0)
**Location:** .claude/agents/project-planner.md

**Purpose:** Collaborative planning for NEW projects (before code exists)

**Key Features:**
- 6-perspective design (Psychological, Educator, SE, Product, DevOps, Security)
- 4-phase conversation (Discovery → Exploration → Recommendation → Documentation)
- 25-30 min time-boxed
- Outputs: Planning summary, tech stack, CLAUDE.md draft, next steps

**Usage:** `@project-planner I want to build [project idea]`

---

## Domain Memory Architecture (v3.6.0)

**Purpose:** Persistent state management for long-running projects

**Inspiration:** [Anthropic's two-agent pattern](https://www.youtube.com/watch?v=xNcEgqzlPqs)

### Core Problem Solved
- Long-running projects lose context across sessions
- Agents are "amnesiacs" without persistent memory
- Developers carry mental load of tracking progress
- 40% productive time lost to context switching

### Two-Agent Pattern

**Initializer Agent** (`.claude/agents/initializer.md`):
- Expands user intent into structured domain memory
- Creates features.json with task breakdown, dependencies, test criteria
- Defines bootup ritual checklist

**Coder Agent** (`.claude/agents/coder.md`):
- Executes bootup ritual every session (read memory, verify state)
- Picks ONE feature atomically, builds incrementally
- Tests until passing, updates state, commits
- Suggests next task with confidence score

### Artifacts (Code Wins Philosophy)
- **features.json** - Structured task list (not GUI, not conversation)
- **progress.md** - Human-readable session journal
- **.claude/bootup-checklist.md** - Formalized discipline
- All state visible, auditable, version-controlled

**Impact:** 85% token reduction in regrounding (350-700 tokens saved per session), mental load reduced 80%, project completion rate 60% → 90% (projected)

**Documentation:** `docs/03-advanced/01_bootup-ritual-guide.md`

---

## Quality Workflows Framework (v3.7.0)

**Purpose:** Automated quality validation breaking the AI productivity glass ceiling

**Inspiration:** [Qodo: State of AI Code Quality](https://www.youtube.com/watch?v=rgjF5o2Qjsc)

### Core Problem Solved
- 67% of developers have quality concerns about AI-generated code
- AI code = 97% more PRs, 90% more review time, 3x security incidents
- Speed gains lost to fixing quality issues
- Productivity glass ceiling: Fast generation without quality = unsustainable

### Quality-First Architecture

**Quality Reviewer Agent** (`.claude/agents/quality-reviewer.md`):
- Security scanner (OWASP top 10, CVE checks)
- Test generator (ensures coverage for features.json)
- Standards enforcer (learns team preferences)
- Performance analyzer (catch issues early)

### SDLC Integration
Quality agents at every phase (planning, development, review, testing, deployment), not just at the end.

### Learning Standards
- Track acceptance/rejection of quality suggestions
- Adapt confidence thresholds based on team behavior
- Dynamic rules (not static), personalized to team culture

**Impact:** Testing doubles trust in AI code, 47% review productivity gain, 66% reduction in security incidents, quality concerns 67% → 20% (projected)

**Documentation:** `docs/00-start-here/11_quality-workflows.md`, `docs/03-advanced/03_quality-workflows-guide.md`

---

## Skills System (v3.3.0+)

**Purpose:** Natural language access to specialized capabilities

**Location:** `.claude/skills/`

### Available Skills

**1. Projects Registry Skill (v3.5.0)**
- Automatic natural language access to multi-project registry
- 58% token savings vs CLI (600 → 250 tokens per query)
- Location: `.claude/skills/projects-registry/`
- Documentation: `.claude/skills/projects-registry/SKILL.md`

**2. Personalization Engine Skill (v4.2.0)**
- Manages user preferences, learning patterns
- Adapts skill behavior based on historical feedback
- "Tell me once" paradigm - system remembers and adapts
- Location: `.claude/skills/personalization-engine/`

### How Skills Work
- Auto-invoked by context (Claude detects relevant queries)
- SKILL.md: Core expertise definitions
- examples/: Sample queries and schemas
- operations guide: Detailed implementation

**Documentation:** `docs/01-fundamentals/02_skills-paradigm.md`

---

## Slash Commands (3 Commands)

**Location:** .claude/commands/

1. **/test** - Run project tests with proper reporting
2. **/build** - Build project and report errors
3. **/review** - Code review against project standards

---

## Template System (v4.0-v4.5)

### Overview
Complete template lifecycle: Create → Validate → Apply → Share

### Import/Export (v4.0.0)
**Purpose:** Share preferences across projects and teams

**Script:** `scripts/apply-template.sh`

**Key Features:**
- Import from file or remote URL
- Export current settings as template
- Merge strategies (replace, merge, additive)
- Git-native distribution (no auth required)
- Checksum verification

### Template Inheritance (v4.1.0)
**Purpose:** Compose templates from base configurations

**Key Features:**
- `extends` field for compositional templates
- Deep merge algorithm (child overrides parent)
- Cycle detection and max depth (5 levels)
- Inheritance chain resolution

**Example:**
```json
{
  "templateMetadata": {
    "id": "gallery-frontend-react",
    "extends": "team-standard"
  }
}
```

### Template Parameters (v4.2.0)
**Purpose:** Dynamic configuration with variable substitution

**Key Features:**
- `${varName}` syntax for placeholders
- Parameter types: string, number, boolean
- Default values support
- Required vs optional parameters
- Interactive prompts or CLI args

**Example:**
```json
{
  "profile": {
    "primaryFrameworks": ["${frontendFramework}", "${backendFramework}"]
  }
}
```

### Template Gallery (v4.3.0)
**Purpose:** 5 ready-to-use domain-specific templates

**Templates:**
1. **gallery-frontend-react** - React + TypeScript + Tailwind
2. **gallery-backend-api** - Node.js/Python API development
3. **gallery-data-science** - Python data science with Jupyter
4. **gallery-devops** - Kubernetes, Terraform, CI/CD
5. **gallery-fullstack** - Customizable full-stack (parameterized)

**Location:** `examples/team-templates/gallery-*.json`

**Documentation:** `docs/02-optimization/08_template-gallery-guide.md`

### Template Validator (v4.4.0)
**Purpose:** Validate template JSON structure

**Script:** `scripts/validate-template.sh`

**Key Features:**
- JSON schema validation
- 3-level validation (Critical/Important/Info)
- Catalog validation with --catalog flag
- Color-coded output

**Usage:**
```bash
./scripts/validate-template.sh my-template.json
./scripts/validate-template.sh catalog.json --catalog
```

**Documentation:** `docs/04-ecosystem/06_template-validator-guide.md`

### Template Application (v4.5.2)
**Purpose:** Apply templates with inheritance and parameter resolution

**Script:** `scripts/apply-template.sh`

**Key Features:**
- Template search by ID or file path
- Automatic inheritance resolution
- Parameter substitution (CLI or interactive)
- Preview with diff before applying
- Backup creation

**Usage:**
```bash
# Simple template
./scripts/apply-template.sh team-standard

# Template with inheritance
./scripts/apply-template.sh gallery-frontend-react

# Parameterized template
./scripts/apply-template.sh gallery-fullstack \
    --param frontendFramework=react \
    --param backendFramework=fastapi
```

**Documentation:** `docs/04-ecosystem/07_apply-template-guide.md`

---

## Token-Saving Patterns for Claude

**When helping with setup:**

1. **Read this file FIRST** before exploring
   - Saves ~20K tokens (don't need to explore 50+ files)

2. **Reference files by path** instead of reading them
   - Example: "See docs/00-start-here/personas/02_quick-setup-user.md"
   - Only read if user needs specific content

3. **Skip these directories:**
   - .git/ (version control)
   - examples/ (just examples, not core)
   - node_modules/ (if exists)
   - Legacy files (anything marked DEPRECATED)

4. **For common questions, use this file's answers**
   - Don't explore docs unless needed
   - Quick answers save tokens

5. **Recommend paths, don't read them all**
   - Guide users to right file
   - Let them read (they're learning anyway)

---

## Known Issues & Quick Fixes

### Issue: "Wizard won't run"
**Fix:**
```bash
chmod +x scripts/*.sh
./scripts/claude-wizard.sh
```

### Issue: "Settings not loading"
**Fix:**
```bash
# Validate JSON
cat .claude/settings.json | python -m json.tool

# Common issues:
# - Trailing comma on last property
# - Missing comma between properties
# - Unquoted string values
```

### Issue: "CLAUDE.md not found"
**Fix:**
- CLAUDE.md goes in PROJECT ROOT (not .claude/)
- Verify: `ls -la CLAUDE.md` (from project root)

### Issue: "Context7 not working"
**Fix:**
- Check MCP connection: `/mcp` command
- Verify API key in .claude.json (NOT committed to git)
- Context7 falls back to WebSearch automatically

### Issue: "Why doesn't Claude execute git push?"
**Answer:** Git authentication requires interactive credential input that the sandbox cannot handle securely.

**Solution:** Claude will display the command for you to run:
```bash
git push origin branch-name
```

**Why this is better:**
- ✅ Secure: No credential workarounds needed
- ✅ Safe: You review branch name before pushing
- ✅ Control: You decide when to push

**See:** `01_global-setup/02_good-to-have/05_git-push-workaround.md`

### Issue: "How do I set up git commit approval?"
**Solution:** Run the interactive wizard:
```bash
./scripts/setup-git-workflow.sh
```

Or ask Claude: "Help me set up git commit approval"

Claude will:
1. Ask about your workflow
2. Recommend the best configuration
3. Guide you through setup

**Options:**
- **Full Protection:** Approval for all git operations (teams/learning)
- **Commit-Only:** Approval only for commits (solo/speed)
- **Minimal:** Approval for commits + destructive ops (experienced)

**See:** `01_global-setup/02_good-to-have/04_git-approval-workflow.md`

### Issue: "How do I apply a template to my project?"
**Solution:** Use the apply-template script (v4.5.2):

```bash
# Simple template
./scripts/apply-template.sh team-standard

# Template with parameters
./scripts/apply-template.sh gallery-fullstack \
    --param frontendFramework=react \
    --param backendFramework=fastapi
```

The script will:
1. Resolve template inheritance automatically
2. Substitute parameters (CLI or interactive)
3. Show preview with diff
4. Ask for confirmation before applying

**See:** `docs/04-ecosystem/07_apply-template-guide.md`

### Issue: "How do I validate my custom template?"
**Solution:** Use the validate-template script (v4.4.0):

```bash
# Validate template JSON
./scripts/validate-template.sh my-template.json

# Validate catalog
./scripts/validate-template.sh catalog.json --catalog
```

The script checks:
- JSON syntax (Critical)
- Required fields (Critical)
- Schema version (Important)
- Parameter format (Info)

**See:** `docs/04-ecosystem/06_template-validator-guide.md`

### Issue: "What templates are available?"
**Answer:** 9 templates in the gallery (v4.3.0+):

**Base Templates:**
- team-standard - Team's standard configuration
- team-security - Security-focused configuration

**Domain Templates:**
- gallery-frontend-react - React + TypeScript + Tailwind
- gallery-backend-api - Node.js/Python API development
- gallery-data-science - Python data science with Jupyter
- gallery-devops - Kubernetes, Terraform, CI/CD
- gallery-fullstack - Customizable full-stack (parameterized)
- team-frontend - Frontend extending team-standard
- team-parameterized - Parameterized team configuration

**Location:** `examples/team-templates/`

**See:** `docs/02-optimization/08_template-gallery-guide.md`

---

## Version Information

**Current:** v4.9.0 (Mode Selection Framework)

**For complete version history and release notes:**
→ See [CHANGELOG.md](../CHANGELOG.md)

---

## Success Metrics (What Users Should Achieve)

### After 5-Minute Win:
- ✅ Understand CLAUDE.md concept
- ✅ See 99% token savings demonstrated
- ✅ Know which full path to take

### After Quick Setup (15-30 min):
- ✅ Project configured with .claude/ folder
- ✅ CLAUDE.md customized
- ✅ Claude can explain project without exploring

### After First-Time Learner (60-90 min):
- ✅ Understand all core concepts
- ✅ Can switch models confidently
- ✅ Know when to use plan/ask/acceptEdits modes
- ✅ First project fully set up

### After Advanced (20-40 min):
- ✅ Security hooks active
- ✅ Custom agents working
- ✅ MCP servers connected

### After Team Lead (90-120 min):
- ✅ 2+ team members onboarded
- ✅ Shared template repository created
- ✅ Team standards documented

---

## Helpful Phrases for Efficient Responses

**When user asks about setup:**
"I recommend starting with the 5-minute demo to see the value: docs/00-start-here/03_5-minute-success.md. Then we can discuss the full setup path that fits your needs."

**When user is experienced:**
"Since you're familiar with Claude Code, the Quick Setup path takes 15-30 minutes: docs/00-start-here/personas/02_quick-setup-user.md. Or run the wizard: `./scripts/claude-wizard.sh`"

**When user wants everything:**
"The First-Time Learner path covers everything in 60-90 minutes: docs/00-start-here/personas/01_first-time-learner.md. Or use the visual guide to choose: docs/00-start-here/07_visual-quickstart.md"

**When user asks about a specific file:**
"That's located at [path]. [1-sentence description]. Would you like me to read it for details?"

**When user is lost:**
"Let's use the visual flowchart to find your path: docs/00-start-here/07_visual-quickstart.md. Or answer this: Are you new to Claude Code, or just new to this template?"

---

## Conclusion

This file should be your **first resource** when helping users set up this template. It contains:
- ✅ Structure overview (what's where)
- ✅ Common tasks (token-optimized responses)
- ✅ File locations (quick reference)
- ✅ Token-saving patterns (read this first!)
- ✅ Quick fixes (known issues)

**Token Impact:**
- Reading this file: ~500 tokens
- Exploring 50+ files: ~20,000 tokens
- **Savings: 96% reduction**

**Next Steps for User:**
1. Recommend docs/00-start-here/03_5-minute-success.md (fastest value)
2. Use docs/00-start-here/07_visual-quickstart.md (if they need help choosing path)
3. Route to appropriate persona path in docs/00-start-here/personas/README.md
4. Or run wizard: `./scripts/claude-wizard.sh`

Happy helping! 🚀
