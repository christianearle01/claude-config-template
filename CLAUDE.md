# Project Memory - Claude Code Configuration Template

**Last Updated:** 2025-12-21
**Version:** v4.27.0

---

## ⚠️ CRITICAL: Documentation Honesty Policy

**For Claude (or any AI maintaining this project):**

**NEVER create misleading information:**
- ❌ Do NOT invent fake user stories or testimonials
- ❌ Do NOT claim "50+ user reports" when there are none
- ❌ Do NOT present theoretical projections as factual results
- ❌ Do NOT create fictional success metrics

**This is a NEW PROJECT by ONE developer.**

When documenting:
- ✅ Be honest about project status ("new", "one user", "looking for adopters")
- ✅ Mark projections clearly: "Projected", "Estimated", "Theoretical"
- ✅ Token math is factual (Anthropic pricing), but savings are projections
- ✅ Examples must be labeled: "Example scenario" or "Projected case"
- ✅ Invite validation: "Help us validate these projections!"

**Integrity over marketing.** Users trust honest documentation.

---

## What Does This Application Do?

This is an **educational documentation project** that provides a comprehensive configuration template for Claude Code users. It helps developers set up Claude Code with optimized settings that save 50-95% on token costs through intelligent context management and model switching patterns.

**Business Purpose:**
- Reduce Claude Code token costs by 50-95% for users
- Accelerate setup time from 52 minutes → 28 minutes average
- Increase setup completion rate from 60% → 95%
- Enable teams to adopt Claude Code consistently

**Not a code project:** This is a documentation/configuration template repository, not a software application. The "product" is the knowledge, templates, and scripts that help others configure their Claude Code environments.

---

## Proactive Intelligence Framework (v3.5.0) ✅

**Status:** Implemented in v3.5.0 - Transforming from reactive template → proactive assistant

**Inspiration:** [Jewels Proactive Agent Patterns](https://www.youtube.com/watch?v=v3u8xc0zLec) - A research project demonstrating how AI agents can proactively assist developers by reducing mental load and context switching.

### Four Essential Ingredients

The framework builds on four core principles:

1. **Observation** - Continuously understand project state (code changes, patterns, workflow)
2. **Personalization** - Learn user preferences and working style over time
3. **Timeliness** - Intervene at exactly the right moment (not too soon or late)
4. **Seamlessness** - Work where developers already are (terminal, IDE, repo)

### Three Levels of Proactivity

**Level 1: Attentive Sous Chef (v3.5.0)** ✅ - Task-level automation
- Detect and auto-fix immediate issues while performing other tasks
- Confidence-scored suggestions (High/Medium/Low reliability)
- Just-in-time cheat sheets for self-troubleshooting
- Proactive setup assistant and TODO discovery
- **Target:** Reduce mental load by 70%, recover 40% productive time lost to context switching

**Level 2: Kitchen Manager (v3.6.0)** ✅ - Project-level awareness
- Contextually aware of entire project, anticipates next need
- Project analyzer with zero-config environment intelligence
- Personalization engine learning user preferences
- Living CLAUDE.md that agents can propose updates to
- **Target:** Predictive suggestions before user asks

**Level 3: Alignment & Collective Intelligence (v4.0.0+)** ✅ - Multi-project orchestration
- Template sharing across teams (v4.0.0)
- Template inheritance for composition (v4.1.0)
- Template parameters for customization (v4.2.0)
- **Target:** Cross-system improvements and team alignment

**Learn more:** `docs/00-start-here/10_proactive-paradigm.md`

---

## Domain Memory Architecture (v3.6.0) ✅

**Status:** Implemented in v3.6.0 - Persistent state management for long-running projects

**Inspiration:**
- [AI Agents That Actually Work: The Pattern Anthropic Just Revealed](https://www.youtube.com/watch?v=xNcEgqzlPqs) - Two-agent pattern, domain memory, bootup ritual
- [Why AI-Native Companies Are Deleting Software You're Still Paying For](https://www.youtube.com/watch?v=4Bg0Q1enwS4) - "Code wins" philosophy, $56K lesson
- [From Vibe Coding To Vibe Engineering – Kitze, Sizzy](https://www.youtube.com/watch?v=JV-wY5pxXLo) - Active steering vs passive acceptance

### Core Problem Solved

- Long-running projects lose context across sessions ("where were we?")
- Agents are "amnesiacs" without persistent memory
- Developers carry mental load of tracking progress
- **40% productive time lost** to context switching and regrounding

### Anthropic's Two-Agent Pattern

**Initializer Agent** (`.claude/agents/initializer.md`):
- Expands user intent into structured domain memory
- Creates features.json with task breakdown, dependencies, test criteria
- Defines bootup ritual checklist

**Coder Agent** (`.claude/agents/coder.md`):
- Executes bootup ritual every session (read memory, verify state)
- Picks ONE feature atomically, builds incrementally
- Tests until passing, updates state, commits
- Suggests next task with confidence score

**Artifacts (Code Wins Philosophy):**
- `features.json` - Structured task list (not GUI, not conversation)
- `progress.md` - Human-readable session journal
- `.claude/bootup-checklist.md` - Formalized discipline
- All state visible, auditable, version-controlled

**Impact:** Token savings 350-700 per session (85% reduction in regrounding), mental load reduced 80%, project completion rate 60% → 90% (projected)

**Learn more:** `.claude/agents/initializer.md` and `.claude/agents/coder.md`

---

## Quality Workflows Framework (v3.7.0) ✅

**Status:** Implemented in v3.7.0 - Breaking the AI productivity glass ceiling through automated quality

**Inspiration:** [The State of AI Code Quality: Hype vs Reality — Itamar Friedman, Qodo](https://www.youtube.com/watch?v=rgjF5o2Qjsc)

### Core Problem Solved

- 67% of developers have serious quality concerns about AI-generated code
- AI code = 97% more PRs, 90% more review time, 3x security incidents
- "Vibe coding" speed gains lost to fixing quality issues
- **Productivity glass ceiling**: Fast generation without quality = unsustainable

### Quality-First Architecture

**Quality Reviewer Agent** (`.claude/agents/quality-reviewer.md`):
- Security scanner (OWASP top 10, CVE checks)
- Test generator (ensures coverage for features.json)
- Standards enforcer (learns team preferences)
- Performance analyzer (catch issues early)

**SDLC Integration:**
Quality agents at every phase (planning, development, review, testing, deployment), not just at the end.

**Learning Standards:**
- Track acceptance/rejection of quality suggestions
- Adapt confidence thresholds based on team behavior
- Dynamic rules (not static), personalized to team culture

**Context Engine:**
Quality improves with better context: codebase + organizational standards + PR history + test results + security logs.

**Impact:** Testing doubles trust in AI code, 47% review productivity gain, 66% reduction in security incidents, quality concerns 67% → 20% (projected, based on industry research)

**Learn more:** `docs/00-start-here/11_quality-workflows.md`

---

## Agent Orchestration Philosophy (v4.26.0) ✅

**Status:** Documented in v4.26.0 - Educational framework for Wave 5-6 transition

**Context:** Steve Yegge's "Welcome to Gas Town" identifies agent orchestration as the next evolution (Wave 5-6: agent clusters → agent fleets). This template provides educational foundation for understanding when orchestration is needed.

### Template's Position: Stage 5 (Multi-Agent CLI)

**Where We Are:**
- 10 specialized agents (coder, initializer, quality-reviewer, project-planner, etc.)
- Point-to-point handoffs (not mesh orchestration)
- features.json + bootup ritual (persistent state management)
- Work-claiming pattern (GUPP-inspired coordination)

**Where Orchestration Lives: Stage 6-7**
- 10+ hand-managed agents (Stage 6)
- Automated orchestration (Stage 7 - Gas Town, etc.)

### Transparent State Over Automation

**Template Philosophy:**
- **Educational mission:** Teach patterns, don't hide complexity
- **Transparent state:** features.json visible, auditable, version-controlled
- **Understanding over speed:** Users learn agent coordination manually before automating

**Why This Matters:**
- Jake Nations Test: "Smarter over faster"
- Users who understand manual coordination can better use orchestration tools
- Premature orchestration = loss of learning opportunity

### When to Graduate to Orchestration

**Stay at Stage 5 (Template) When:**
- Learning agent patterns (educational priority)
- Under 5 agents in regular use
- Small team or solo developer
- Understanding still building

**Graduate to Stage 6-7 (Gas Town, etc.) When:**
- 10+ agents needed regularly
- Coordination overhead > manual capacity
- Production reliability required
- Agent patterns fully internalized

### Complementary Tools

**Template is NOT:**
- An orchestrator (no automation layer)
- A replacement for Gas Town (different purposes)
- Production-ready for large agent fleets

**Template IS:**
- Educational foundation for agent patterns
- Configuration template for Claude Code
- Bridge from Stage 4 (single agent) → Stage 5 (multi-agent)
- Decision framework for when to orchestrate

### Integration with Orchestration Tools

**Gas Town + Template:**
- Use template's features.json schema
- Apply template's agent role patterns
- Graduate when orchestration needed
- See: `docs/03-advanced/08_orchestration-decision-framework.md`

**Learn more:**
- Agent Evolution Stages: `docs/03-advanced/07_agent-evolution-stages.md`
- Orchestration Decision Framework: `docs/03-advanced/08_orchestration-decision-framework.md`
- External Perspectives Pattern 10: `.claude/skills/external-perspectives/SKILL.md`

---

## Model Selection Strategy (v3.11.0)

**Optimizing model usage across agents and conversations**

### The Problem Solved

Users default to Sonnet for all tasks, even when:
- Haiku would be faster and cheaper (exploration, file reading)
- Opus would provide better reasoning (architecture, planning)

**Result:** Sonnet at 80% utilization while other models sit unused.

### The Three-Question Method

```
1. Is this CREATIVE or ARCHITECTURAL work? → Opus
2. Does this involve WRITING CODE? → Sonnet
3. Is this MECHANICAL or EXPLORATORY? → Haiku
```

### Agent-Level Smart Defaults

Configured in this project's agents (`.claude/agents/`):

| Agent | Model | Rationale |
|-------|-------|-----------|
| prompt-polisher | Haiku | Mechanical prompt optimization |
| project-planner | Opus | 6-perspective architecture analysis |
| initializer | Opus | Feature decomposition, learning paths |
| quality-reviewer | Haiku | Rule-based orchestration |
| coder | Sonnet | Balanced implementation |

### Cost Impact (Projected)

- **Exploration tasks:** 91% cheaper with Haiku vs Sonnet
- **Architecture decisions:** Opus prevents costly rework
- **Overall:** 24% token reduction (projected)

**Learn more:** `docs/02-optimization/01_model-selection-strategy.md`

---

## Tech Stack

**Primary Technologies:**
- **Markdown** - All documentation (87 MD files, 30,000+ lines)
- **Bash** - Interactive setup wizards (12 shell scripts)
- **JSON** - Configuration files (.claude/settings.json)
- **Mermaid** - Visual diagrams (5 flowcharts)

**Tools:**
- Git for version control
- GitHub for hosting
- Python (optional) - JSON validation in wizards

**No build process:** This is a documentation template, not compiled software.

---

## Project Structure

```
claude-config-template/
├── docs/                    # v3.0.0: Learning journey structure
│   ├── 00-start-here/      # Entry points & navigation
│   ├── 01-fundamentals/    # Core concepts (must-learn)
│   ├── 02-optimization/    # Token & workflow optimization
│   ├── 03-advanced/        # Expert techniques (MCP, agents)
│   └── 04-ecosystem/       # Progress bar, integrations, tools
│
├── 01_global-setup/         # One-time machine setup
│   ├── 01_must-have/       # Essential (3 files)
│   ├── 02_good-to-have/    # High-value (3 files)
│   └── 03_nice-to-have/    # Advanced (3 files)
│
├── 02_project-onboarding/   # Per-project setup
│   ├── 01_must-have/       # Essential (3 files)
│   └── 02_good-to-have/    # Optimization (3 files)
│
├── 03_pre-project-planning/ # New project planning
│   └── 01_must-have/       # Planning guide (2 files)
│
├── 04_browser-workflow/     # Role-based configs for claude.ai
│   └── 01_must-have/       # 10 files: 9 roles + skills guide (11 files total)
│
├── templates/               # Reusable templates (3 files)
├── scripts/                 # Wizards & helpers (12 scripts)
├── examples/                # Example configs (6 files)
├── .claude/                 # Claude Code config
│   ├── settings.json
│   ├── SETUP_CONTEXT.md    # Token-optimized setup guide
│   ├── agents/             # 5 custom agents (coder, initializer, project-planner, prompt-polisher, quality-reviewer)
│   ├── skills/             # Skill definitions (personalization-engine, projects-registry)
│   └── commands/           # 5 skills
│
├── README.md               # Landing page (408 lines)
├── CLAUDE.md              # This file!
├── CHANGELOG.md           # Version history
└── version.json           # Automation metadata
```

---

## External Services & APIs

**None.** This is a standalone documentation/template project with no external dependencies or API integrations.

**GitHub hosting:**
- Purpose: Source code hosting and distribution
- Users clone the repo to use the template
- No GitHub API usage in the template itself

---

## Code Style & Conventions

### Markdown Documentation
- **Headers:** Sentence case with emojis for visual scanning
- **Lists:** Use bullet points (- not *) for consistency
- **Code blocks:** Always specify language for syntax highlighting
- **Links:** Use descriptive text, not "click here"
- **Line length:** No hard limit (readability over rules)

### File Naming
- **Documentation:** Use descriptive names with priority prefix
  - `01_installation.md`, `02_quick-start.md`
  - Numbered for reading sequence
- **Directories:** Use hyphens, lowercase, with numeric prefixes for hierarchy
  - `01_global-setup/`, `02_good-to-have/`

### Bash Scripts
- **Shebang:** Always `#!/bin/bash`
- **Exit on error:** Use `set -e`
- **Variables:** UPPERCASE for constants, lowercase for local vars
- **Functions:** Descriptive names, snake_case
- **Comments:** Explain WHY, not WHAT

### JSON Configuration
- **2-space indentation**
- **No trailing commas**
- **Alphabetical keys** within sections
- **Comments:** Use JSON5 style in settings-explained.json

### Emoji Usage
Use consistently for visual hierarchy:
- ⚠️ must-have (critical)
- ⭐ good-to-have (high-value)
- 💡 nice-to-have (advanced)
- ✅ Success/completion
- 🚀 Getting started
- 📚 Documentation
- 🎯 Goals/targets

---

## Development Workflow

### Adding New Documentation

1. **Determine priority:** must-have / good-to-have / nice-to-have
2. **Choose directory:**
   - Learning content: `docs/00-start-here/` through `docs/04-ecosystem/`
   - Setup guides: `01_global-setup/`, `02_project-onboarding/`, `03_pre-project-planning/`
   - Browser workflow: `04_browser-workflow/`
3. **Number sequentially:** 01_, 02_, 03_ for reading order (if applicable)
4. **Write content:**
   - Start with purpose/goal
   - Include examples
   - Add navigation footer
5. **Update indexes:**
   - Add to `docs/README.md` if learning content
   - Add to QUICK_REFERENCE.md
   - Add to main README.md if major feature
6. **Test all links**

### Adding New Features

**Examples: Custom agents, skills, MCP configs**

1. **Create the feature file:**
   - Agent: `.claude/agents/new-agent.md`
   - Command: `.claude/commands/new-command.md`
   - Example: `examples/[category]/example.ext`

2. **Document the feature:**
   - Add section to QUICK_REFERENCE.md
   - Add to README.md if major feature
   - Create detailed guide in appropriate directory

3. **Update SETUP_CONTEXT.md:**
   - Add to file location reference
   - Include usage example
   - Update feature count

4. **Update CHANGELOG.md**

### Jake Nations Test (4 Questions for Every Feature) - v4.22.0

**Before adding any feature, ask:**

1. **Does this make users faster, or smarter?**
   - ✅ Smarter wins
   - Example: Understanding checkpoint (smarter) > Auto-complete (faster)
   - Principle: Speed without comprehension = chronic anxiety

2. **Does this encourage "easy" or "simple"?**
   - ✅ Simple wins (one-fold, no entanglement)
   - ❌ Easy = frictionless but may bypass learning
   - Example: Wizard with checkpoints (simple) > Wizard without (easy)

3. **Will users understand the code this generates?**
   - ✅ If no, add understanding checkpoint
   - Example: Spec-generator shows plan before code
   - Principle: Ship with understanding, not just working code

4. **Are we preserving complexity or creating clarity?**
   - ✅ Clarity wins
   - Example: Tech debt detection removes accidental complexity
   - Principle: AI treats tech debt as patterns - we must identify it

**Source:** "The Infinite Software Crisis" - Jake Nations (Netflix)
**Link:** https://www.youtube.com/watch?v=eIoohUmYpGI

**This test ensures every feature aligns with "Understanding Over Speed" philosophy.**

### Version Bumping

**Semantic versioning:** MAJOR.MINOR.PATCH

- **PATCH (2.7.x):** Bug fixes, typos, small improvements
- **MINOR (2.x.0):** New features, new documentation, backwards-compatible
- **MAJOR (x.0.0):** Breaking changes, major restructuring

**Process:**
1. Edit `version.json`:
   - Update `version` field (e.g., "2.7.1" → "2.8.0")
   - Update `release_date`
   - Update `release_name`
2. Run version sync script:
   ```bash
   ./scripts/sync-version.sh
   ```
3. Review changes:
   ```bash
   git diff
   ```
4. Update CHANGELOG.md with release notes
5. Commit and tag:
   ```bash
   git commit -am "Bump version to v2.8.0"
   git tag v2.8.0
   ```
6. Push:
   ```bash
   git push origin main v2.8.0
   ```

**Files automatically updated by sync-version.sh:**
- CLAUDE.md (line 4)
- README.md (lines 306, 339, 463)
- .claude/SETUP_CONTEXT.md (lines 21, 437)

---

## Common Commands

### Documentation Commands

```bash
# Count total lines of documentation
find . -name "*.md" -not -path "./.git/*" | xargs wc -l

# Find broken internal links
grep -r "\[.*\](.*\.md)" *.md */*.md --color

# Check for TODO/FIXME markers
grep -r "TODO\|FIXME\|XXX" . --exclude-dir=.git

# Preview markdown (if using grip)
grip README.md
```

### Script Commands

```bash
# Make all scripts executable
chmod +x scripts/*.sh

# Test wizard (dry run)
./scripts/claude-wizard.sh
# Then select option 6 (exit) to test without running

# Validate JSON configuration
cat .claude/settings.json | python -m json.tool

# Test progress bar with custom settings
export PROGRESS_BAR_WIDTH=30
export PROGRESS_BAR_LABEL="Status"
source scripts/progress-bar-config.sh
show_progress 3 5 "Testing"
```

### Git Commands

```bash
# Create new feature branch
git checkout -b feature/new-guide

# View file history
git log --follow -- path/to/file.md

# Compare versions
git diff v2.5.0..v2.6.0 --stat

# Tag a release
git tag -a v2.6.0 -m "Browser Workflow Release"
git push origin v2.6.0
```

---

## Important Files & Locations

### Entry Points (What users see first)
- `README.md` - Landing page, 408 lines (reduced from 539)
- `docs/00-start-here/01_entry-points.md` - Navigation guide
- `docs/00-start-here/personas/README.md` - Detailed persona guide
- `docs/01-fundamentals/02_skills-paradigm.md` - Future of Claude Code
- `docs/01-fundamentals/ANTI_PATTERNS.md` - #1 priority guide

### Critical Templates (What users copy)
- `templates/CLAUDE.md.template` - Project memory template (284 lines)
- `templates/coding-standards.md.template` - Global standards
- `.claude/settings.json` - Optimized Claude settings

### Core Configuration
- `.claude/settings.json` - Project settings
- `.claude/settings-explained.json` - Educational reference
- `.claude/SETUP_CONTEXT.md` - Token-optimized setup guide

### User Configuration
- `~/.claude/projects-registry.json` - Multi-project tracking
  - Centralized registry for managing multiple projects
  - See: `01_global-setup/03_nice-to-have/05_projects-registry.md`
  - CLI: `scripts/claude-projects.sh`
  - Wizard: `scripts/register-project.sh`

### Skills
- `.claude/skills/projects-registry/` - Projects Registry Skill
  - Automatic natural language access to registry
  - SKILL.md: Core expertise (auto-invoked by context)
  - registry-operations.md: Detailed operations guide
  - examples/: Sample queries and schema
  - 58% token savings vs CLI (600 → 250 tokens per query)
  - See: `.claude/skills/projects-registry/SKILL.md`

### Reference Documentation
- `docs/00-start-here/09_quick-reference.md` - Searchable feature reference
- `docs/00-start-here/06_visual-guides.md` - 5 Mermaid diagrams
- `docs/00-start-here/04_quick-start.md` - Quick setup guide
- `docs/00-start-here/02_quick-win.md` - Fast wins path
- `docs/README.md` - Documentation hub with learning journey
- `docs/02-optimization/` - Token & workflow optimization guides
- `docs/03-advanced/` - MCP workflows, sub-agents, vision
- `docs/04-ecosystem/02_progress-bar-guide.md` - Progress bar config
- `docs/04-ecosystem/09_update-guide.md` - Update instructions

### Browser Workflow (claude.ai)
- `04_browser-workflow/README.md` - Entry point for role-based Custom Instructions
- `04_browser-workflow/01_must-have/00_all-available-roles-complete-library.md` - Role library index
- `04_browser-workflow/01_must-have/01-09_*.md` - 9 role-specific guides
- `04_browser-workflow/01_must-have/10_claude-skills-complete-guide.md` - Account-level skills guide

### Version Control
- `CHANGELOG.md` - Complete version history (includes v1.0.0 in historical/v1.0-original branch)
- `README.md.backup` - Backup of previous README

---

## Testing Requirements

**No automated tests** (documentation project, not code).

**Manual validation checklist:**

### Before Release
- [ ] All internal links work (no 404s)
- [ ] All code examples are syntactically correct
- [ ] JSON files validate (`python -m json.tool`)
- [ ] Scripts are executable (`chmod +x scripts/*.sh`)
- [ ] Version numbers updated in all files
- [ ] CHANGELOG.md updated with changes
- [ ] Git tag created for release

### User Testing
- [ ] First-time user can complete 5-minute demo
- [ ] Wizard completes successfully for each persona
- [ ] CLAUDE.md template copies correctly
- [ ] All wizards show correct paths and validation
- [ ] Links in README point to correct sections

---

## Security & Privacy

**No sensitive data.** This is a public documentation/template repository.

**What's NOT committed:**
- `.claude.json` (contains API keys - in .gitignore)
- User-specific settings
- Project-specific CLAUDE.md files (users create these)

**What IS committed:**
- Template files
- Example configurations
- Documentation
- Setup scripts

**Security considerations for users:**
- Wizards validate JSON syntax before writing
- Scripts use `set -e` to exit on errors
- Documentation warns about committing API keys
- Examples show proper .gitignore patterns

---

## Optimization Notes for Claude

### Read These Files First (Token Efficiency)

**When helping with setup:**
1. `.claude/SETUP_CONTEXT.md` (500 tokens) - Comprehensive setup guide
2. `QUICK_REFERENCE.md` (if specific feature question)

**Don't explore unless needed:**
- Individual documentation files (link to them instead)
- Example directories
- .git/ directory

### Common User Questions & Quick Answers

**"How do I set this up?"**
→ Direct to `docs/00-start-here/01_entry-points.md` first, then learning journey

**"What should I learn first?"**
→ Start with `docs/01-fundamentals/ANTI_PATTERNS.md` (#1 priority)

**"What's the Skills Paradigm?"**
→ See `docs/01-fundamentals/02_skills-paradigm.md` (the future of Claude Code)

**"Where is feature X?"**
→ Use `QUICK_REFERENCE.md` (alphabetically organized, searchable)

**"How do I add [agent/command/hook]?"**
→ See "Development Workflow" section above

**"How do I optimize tokens?"**
→ See `docs/02-optimization/` directory (Prompt Caching, MCP Optimization, Model Selection, etc.)

**"Which model should I use?"**
→ See `docs/02-optimization/01_model-selection-strategy.md` (Three-Question Method: Opus for architecture, Sonnet for implementation, Haiku for exploration)

**"What coding principles should I follow?"**
→ See `docs/01-fundamentals/06_coding-principles-handbook.md` (SOLID, DRY, KISS, YAGNI + AI-specific principles from 9 consolidated files)

**"How do I prompt effectively?"**
→ See `docs/01-fundamentals/07_prompting-fundamentals.md` (How AI works, meta-skill of clarity, permission to fail, context is king, few-shot > zero-shot)

**"Can I get copy-paste prompt templates?"**
→ See `docs/01-fundamentals/08_prompt-patterns.md` (10 reusable patterns: Context-Rich Request, Permission to Fail, Chain of Thought, Few-Shot Scaffolding, Output Requirements, and more. Practical companion to Prompting Fundamentals)

**"How do I choose between multiple valid approaches?"**
→ Use `@adversarial-validator [decision]` - Playoff method generates 3 competing solutions (Optimist, Pragmatist, Innovator), adversarial critique selects winner with confidence scores. Perfect for high-stakes decisions (architecture, tech stack). See `.claude/agents/adversarial-validator.md`

### File Location Quick Reference

See `.claude/SETUP_CONTEXT.md` for complete file location table.

**Key locations:**
- Templates: `templates/`
- Wizards: `scripts/` (12 shell scripts including progress-bar-config.sh)
- Learning Journey: `docs/00-start-here/` → `docs/03-advanced/`
- Setup Guides: `01_global-setup/`, `02_project-onboarding/`, `03_pre-project-planning/`
- Browser Workflow: `04_browser-workflow/` (9 roles for claude.ai)
- Config: `.claude/`

---

## Project Goals & Success Metrics

### Primary Goals
1. **Reduce token costs:** 50-95% savings for users
2. **Accelerate setup:** 52 min → 28 min average
3. **Increase completion:** 60% → 95% success rate
4. **Enable teams:** Consistent adoption across organizations

### Success Metrics (Goals - Not Yet Validated)
- Setup time target: 28 min average (projected, not measured)
- Completion rate goal: 95% (aspirational, not tested with multiple users)
- Token savings: 50-95% (theoretical estimate based on author's experience)
- User satisfaction target: 9.1/10 (goal, not measured)

**Current reality:** 1 user (the author), metrics are projections pending real-world validation.

---

## Contributing Guidelines

### Adding New Content

**Documentation:**
1. Follow existing structure and formatting
2. Use consistent emoji system
3. Number files sequentially in directories
4. Include navigation footer
5. Update all indexes

**Examples:**
1. Place in `examples/[category]/`
2. Include inline comments explaining WHY
3. Document in appropriate guide
4. Add to QUICK_REFERENCE.md

**Agents/Commands:**
1. Create in `.claude/agents/` or `.claude/commands/`
2. Document thoroughly with examples
3. Add to SETUP_CONTEXT.md
4. Update QUICK_REFERENCE.md

### Pull Request Process

1. Create feature branch: `feature/description`
2. Make changes following conventions above
3. Update CHANGELOG.md (Unreleased section)
4. Test all links and examples
5. Submit PR with clear description
6. Respond to feedback

---

## Git Workflow & Commit Approval

### Core Rules
1. **ALWAYS get user approval before committing** - Draft message, show files, wait for approval
2. **Git push is display-only** - Show command, explain credentials requirement (first time only)
3. **NEVER auto-commit** even if user says "commit when done"

### Token Efficiency
- Skip `git diff` (users see changes in IDE) - saves 500-2,000 tokens
- Minimal workflow: ~400 tokens/commit (75% savings)
- Run `git status/diff` only when context needed for message quality

### Configuration
Run `./scripts/setup-git-workflow.sh` to choose protection level (Full/Commit-Only/Minimal).

**Full guide:** `docs/00-start-here/09_quick-reference.md#git-workflow--commit-approval`

---

## MCP Usage Guidelines (Workflow Quality)

### Sequential-Thinking MCP

**Purpose:** Structured reasoning for complex decisions

**When to use:**
- Multi-perspective analyses (Psychological, Educator, Engineering)
- Architecture and design decisions
- Complex refactoring with multiple approaches
- Trade-off analysis and problem diagnosis
- Ambiguous requirements or high-stakes decisions

**When NOT to use:**
- Mechanical updates (file paths, renames)
- Simple fixes (typos, broken links)
- Straightforward execution (git commands)
- Well-scoped tasks with explicit instructions

**Token efficiency:**
- Upfront cost: +500-1000 tokens per analysis
- Rework savings: -1,500+ tokens from prevented mistakes
- Net benefit: 21-50% token savings on complex tasks
- Quality benefit: Higher first-time-right rate

**Decision framework:**
When in doubt → Use sequential-thinking (educational project = teaching value > speed)

### Other MCPs

**Memory MCP:** For knowledge graph operations (entity/relation management)
**Filesystem MCP:** Automatically used for file operations
**GitHub MCP (Optional):** For repository operations (issues, PRs, commits) - Template uses manual git workflow

---

## Special Instructions for Claude

**⚠️ CRITICAL - Read First:**

**0. FOLLOW THE DOCUMENTATION HONESTY POLICY (see top of this file)**
   - NEVER present projections as proven results
   - ALWAYS label: "Projected", "Theoretical", "Example scenario"
   - This is a NEW project by ONE user (the author)
   - Token math is factual, but savings are projections
   - Invite users to validate claims
   - **Integrity over marketing** - Users trust honest documentation

**When helping maintain/improve this project:**

1. **Always read CLAUDE.md (this file) first** - Saves exploring 50+ files
2. **Check SETUP_CONTEXT.md** for user-facing setup help
3. **Follow the 3-tier priority system** (must/good/nice-to-have)
4. **Maintain consistent formatting** (see Code Style section)
5. **Update all indexes** when adding content (README, QUICK_REFERENCE, DIRECTORY_GUIDE)
6. **Test links** before committing
7. **Version correctly** (MAJOR.MINOR.PATCH)
8. **Honesty check ALL documentation** before committing
9. **Use sequential-thinking MCP for non-trivial decisions**
   - This is an educational project - teaching value > speed
   - Users learn from watching structured reasoning
   - Prevents rework by catching issues early (saves tokens overall)
   - See "MCP Usage Guidelines" section above for decision framework

10. **Show workflow progress (v4.16.0) - OPTIONAL**
   - Author preference for transparency - not required for other users
   - Use `scripts/claude-progress.sh` for multi-step operations
   - Standard phases: Understanding → Planning → Implementation → Validation
   - **Full guide:** `docs/04-ecosystem/02_progress-bar-guide.md`

**Common maintenance tasks:**
- Adding new documentation → See "Development Workflow" above
- Fixing broken links → Search and replace, test thoroughly
- Adding features → Follow "Adding New Features" process
- Updating version → Bump in all locations, update CHANGELOG

**This project is a meta-example:** It demonstrates the best practices it teaches. Keep that integrity intact!

---

## Version History (This File)

**Recent changes:**
- **v4.21.0 (2025-12-20):** External Perspectives - Complete Edition 🎉 (100% research complete - 9/9 patterns documented. Pattern 1: Cursor @ Context Management - INDUSTRY ALIGNMENT VALIDATION, 14+ @ symbols, AGENTS.md support, 50%+ Fortune 500. Pattern 6: Fabric Prompt Engineering - PHILOSOPHICAL VALIDATION, 233+ community patterns, "clarity is primary currency". CRITICAL DISCOVERY: Cross-pattern validation - AGENTS.md in both Pattern 9 and Pattern 1, proving industry-wide convergence on persistent context files)
- **v4.20.2 (2025-12-19):** External Perspectives - Industry Standards Validation (Pattern 9: Beads + AAIF validates v3.6.0 Domain Memory Architecture and CLAUDE.md approach, three-tier validation with 60K+ AGENTS.md projects, dual validation for persistent state + project context, 78% research complete - 7/9 patterns)
- **v4.20.1 (2025-12-19):** External Perspectives - Enterprise Edition (Added Patterns 7-8: The 70/30 Problem validates our quality-first architecture, Socratic Review Framework with comprehensive guidelines, 75% research complete - 6/8 patterns documented)
- **v4.20.0 (2025-12-19):** External Perspectives - Community Patterns Framework (4 complete patterns: Compounding Loop validates our approach, Pre-Task Scoring adoption, Workflow Automation comparison, Transparent Process enhancement, 2 patterns pending research)
- **v4.19.0 (2025-12-17):** Complete Workflows - Deployment-readiness agent, /release command, documentation-sync-checker enhancements
- **v4.18.0 (2025-12-17):** Mastering What You Have - Decision framework, integration patterns, workflow examples

**Full history:** See `CHANGELOG.md`

---

**Note:** This CLAUDE.md serves dual purposes:
1. **Practical:** Helps Claude (and contributors) maintain this project efficiently
2. **Educational:** Shows users a real-world example of a well-structured CLAUDE.md

Users can reference this file to see how to document a large documentation project!
- CLAUDE.md