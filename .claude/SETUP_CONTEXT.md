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
6. Package security (OPTIONAL) → Malware protection for npm/Python projects

**Current Version:** v2.7.0

**Need to update an existing project?** → See [`UPDATE_GUIDE.md`](../UPDATE_GUIDE.md) for quick commands

---

## Directory Structure (What's Where)

```
claude-config-template/
├── docs/                          # NEW! UX-optimized guides
│   ├── 5_MINUTE_SUCCESS.md       # Ultra-fast win (5 min demo)
│   └── VISUAL_QUICKSTART.md      # Decision flowchart
│
├── 01_global-setup/               # One-time machine-wide setup
│   ├── must-have/                 # CRITICAL (installation, quick start, permissions)
│   ├── good-to-have/              # HIGH-VALUE (model switching, MCP servers)
│   └── nice-to-have/              # ADVANCED (security, agents)
│
├── 02_project-onboarding/         # Per-project setup (EXISTING codebases)
│   ├── must-have/                 # Project setup essentials
│   └── good-to-have/              # Optimization guides
│
├── 03_pre-project-planning/       # NEW projects (plan BEFORE coding)
│   └── must-have/                 # Planning guide
│
├── 04_browser-workflow/           # COMING SOON: Role-based browser configs
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
│   ├── agents/                    # Custom agents (2 sophisticated ones)
│   ├── commands/                  # Slash commands (5 commands)
│   └── SETUP_CONTEXT.md          # This file!
│
└── [Entry Points]
    ├── README.md                  # Landing page (will be 250 lines)
    ├── GETTING_STARTED.md         # Quick win path (will rename to QUICK_WIN.md)
    ├── START_HERE.md              # Detailed persona router
    └── VISUAL_GUIDES.md           # 5 Mermaid diagrams
```

---

## Critical Files (Read These for Setup Help)

### Entry Points (User's First Touch)
- **docs/5_MINUTE_SUCCESS.md** - 5-min demo (NEW! recommend this first)
- **docs/VISUAL_QUICKSTART.md** - Visual flowchart for path selection (NEW!)
- **README.md** - Overview and value props (540 lines → being reduced to 250)
- **START_HERE.md** - Persona selector with detailed paths

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

### Wizards (Interactive Setup)
- **scripts/claude-wizard.sh** - Main wizard with persona selector
- **scripts/wizard-first-time.sh** - 60-90 min complete learning path
- **scripts/wizard-quick-setup.sh** - 15-30 min fast project setup
- **scripts/wizard-advanced.sh** - 20-40 min advanced features
- **scripts/wizard-team-lead.sh** - 90-120 min team deployment
- **scripts/wizard-returning.sh** - 10-20 min refresher

---

## Common Setup Tasks (Token-Optimized Responses)

### Task 1: "Help me set up this template"

**Quick Response Pattern:**
1. Ask persona: "Are you new to Claude Code or experienced?"
2. Route to appropriate path:
   - New → docs/5_MINUTE_SUCCESS.md first, then wizard
   - Experienced → START_HERE.md#quick-setup-user
   - Team → START_HERE.md#team-lead
3. Recommend wizard: `./scripts/claude-wizard.sh`

**Files to Reference:**
- docs/VISUAL_QUICKSTART.md (decision tree)
- START_HERE.md (detailed paths)

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
- Manual setup: START_HERE.md → persona section

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

**Reference:** 01_global-setup/good-to-have/01_model-switching.md

### Task 6: "What are the 5 personas?"

**Quick Reference:**

1. **🆕 First-Time Learner** (60-90 min)
   - New to Claude Code
   - Complete learning path
   - File: START_HERE.md#first-time-learner

2. **⚡ Quick Setup** (15-30 min)
   - Experienced, fast project setup
   - File: START_HERE.md#quick-setup-user

3. **🚀 Advanced Optimizer** (20-40 min)
   - Security hooks, custom agents, MCP
   - File: START_HERE.md#advanced-optimizer

4. **👥 Team Lead** (90-120 min)
   - Team deployment
   - File: START_HERE.md#team-lead

5. **🔄 Returning User** (10-20 min)
   - Quick refresher
   - File: START_HERE.md#returning-user

### Task 7: "What's the fastest way to see value?"

**Answer:** docs/5_MINUTE_SUCCESS.md

**Why:**
- 5 minutes total
- Demonstrates 99% token savings
- Builds confidence
- Clear next steps

**Next Step After 5-Min Win:**
- Convinced → Run wizard
- Want more info → START_HERE.md
- Just need commands → QUICK_REFERENCE.md (coming soon)

### Task 8: "How do I protect against package malware?" (OPTIONAL)

**Quick Answer:** OPTIONAL feature - only needed if your Claude Code projects install npm/Python packages.

**This template has zero dependencies** - package security is preventative docs for YOUR projects.

**Quick Setup (NPM):**
```bash
# 1. Copy .npmrc to block install scripts
cp ~/claude-config-template/.npmrc .

# 2. Weekly audit
npm audit

# 3. Commit lockfile
git add package-lock.json
```

**Quick Setup (Python):**
```bash
# 1. Copy pip.conf to prefer wheels
cp ~/claude-config-template/pip.conf .

# 2. Weekly audit
pip install pip-audit && pip-audit

# 3. Pin versions
pip freeze > requirements.txt
```

**When to implement:**
- ✅ Projects that install npm packages
- ✅ Projects that use pip/Python packages
- ✅ Team projects with package managers
- ❌ Documentation-only projects (like this template)

**Resources:**
- Universal guide: 01_global-setup/nice-to-have/02_package-security-principles.md
- NPM checklist: 01_global-setup/nice-to-have/03_npm-security-checklist.md
- Python checklist: 01_global-setup/nice-to-have/03_python-security-checklist.md
- NPM scripts: examples/npm-security/ (5 automation scripts)
- Python scripts: examples/python-security/ (5 automation scripts)

**Real threats (factual):**
- event-stream (NPM, 2018): 2M weekly downloads compromised
- ctx/php (Python PyPI, 2022): AWS credentials exfiltrated
- rest-client (Ruby, 2019): Backdoor from compromised account

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
| Visual guides | VISUAL_GUIDES.md |
| 5-min demo | docs/5_MINUTE_SUCCESS.md |
| Decision flowchart | docs/VISUAL_QUICKSTART.md |
| Installation guide | 01_global-setup/must-have/01_installation.md |
| Quick start | 01_global-setup/must-have/02_quick-start.md |
| Permission modes | 01_global-setup/must-have/03_permission-modes.md |
| Model switching | 01_global-setup/good-to-have/01_model-switching.md |
| MCP setup | 01_global-setup/good-to-have/02_mcp-setup.md |
| Security guide | 01_global-setup/nice-to-have/01_security-guide.md |
| Project onboarding | 02_project-onboarding/must-have/01_onboarding-guide.md |
| Team onboarding | 02_project-onboarding/good-to-have/03_team-onboarding.md |

---

## Custom Agents (2 Sophisticated Ones)

### 1. Prompt Polisher Agent (v2.4.0)
**Location:** .claude/agents/prompt-polisher.md

**Purpose:** Transform vague prompts into optimized, context-rich requests

**Key Features:**
- 14 optimization techniques (3-tier system)
- Intelligent selection based on task complexity
- 50-80% token savings
- Educational (teaches WHY each improvement helps)

**Usage:** `@prompt-polisher [user's vague prompt]`

### 2. Project Planner Agent (v2.3.0)
**Location:** .claude/agents/project-planner.md

**Purpose:** Collaborative planning for NEW projects (before code exists)

**Key Features:**
- 6-perspective design (Psychological, Educator, SE, Product, DevOps, Security)
- 4-phase conversation (Discovery → Exploration → Recommendation → Documentation)
- 25-30 min time-boxed
- Outputs: Planning summary, tech stack, CLAUDE.md draft, next steps

**Usage:** `@project-planner I want to build [project idea]`

---

## Slash Commands (5 Commands)

**Location:** .claude/commands/

1. **/onboarding** - Generate friendly project onboarding guide
2. **/standards** - Quick reference to coding standards
3. **/test** - Run project tests with proper reporting
4. **/build** - Build project and report errors
5. **/review** - Code review against project standards

---

## Token-Saving Patterns for Claude

**When helping with setup:**

1. **Read this file FIRST** before exploring
   - Saves ~20K tokens (don't need to explore 50+ files)

2. **Reference files by path** instead of reading them
   - Example: "See START_HERE.md#quick-setup-user"
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

---

## Version Information

**Current:** v2.7.0 (Package Security - OPTIONAL feature)

**Recent Changes (v2.7.0):**
- Added OPTIONAL package security protection (npm/Python malware prevention)
- Universal principles for ALL package managers (npm, pip, gem, cargo, go, etc.)
- NPM security: 3 guides + 5 automation scripts
- Python security: 3 guides + 5 automation scripts
- 20 files, ~4,200 lines of security content
- Clearly marked as OPTIONAL throughout (template has zero dependencies)

**Previous Version:** v2.6.0 (Browser Workflow)
- Added 04_browser-workflow/ (9 role-based Custom Instructions)
- Added docs/5_MINUTE_SUCCESS.md (ultra-fast demo)
- Added docs/VISUAL_QUICKSTART.md (decision flowchart)
- Added .claude/SETUP_CONTEXT.md (token-optimized setup guide)
- Enhanced Prompt Polisher (14 techniques)
- Intelligent technique selection
- Educational output modes refinement

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
"I recommend starting with the 5-minute demo to see the value: docs/5_MINUTE_SUCCESS.md. Then we can discuss the full setup path that fits your needs."

**When user is experienced:**
"Since you're familiar with Claude Code, the Quick Setup path takes 15-30 minutes: START_HERE.md#quick-setup-user. Or run the wizard: `./scripts/claude-wizard.sh`"

**When user wants everything:**
"The First-Time Learner path covers everything in 60-90 minutes: START_HERE.md#first-time-learner. Or use the visual guide to choose: docs/VISUAL_QUICKSTART.md"

**When user asks about a specific file:**
"That's located at [path]. [1-sentence description]. Would you like me to read it for details?"

**When user is lost:**
"Let's use the visual flowchart to find your path: docs/VISUAL_QUICKSTART.md. Or answer this: Are you new to Claude Code, or just new to this template?"

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
1. Recommend docs/5_MINUTE_SUCCESS.md (fastest value)
2. Use docs/VISUAL_QUICKSTART.md (if they need help choosing path)
3. Route to appropriate persona path in START_HERE.md
4. Or run wizard: `./scripts/claude-wizard.sh`

Happy helping! 🚀
