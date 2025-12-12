# Project Memory - Claude Code Configuration Template

**Last Updated:** 2025-12-12
**Version:** v3.0.0

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
│   ├── must-have/          # Essential (3 files)
│   ├── good-to-have/       # High-value (3 files)
│   └── nice-to-have/       # Advanced (3 files)
│
├── 02_project-onboarding/   # Per-project setup
│   ├── must-have/          # Essential (3 files)
│   └── good-to-have/       # Optimization (3 files)
│
├── 03_pre-project-planning/ # New project planning
│   └── must-have/          # Planning guide (2 files)
│
├── 04_browser-workflow/     # Role-based configs for claude.ai
│   └── must-have/          # 9 roles + library overview (10 files)
│
├── templates/               # Reusable templates (3 files)
├── scripts/                 # Wizards & helpers (12 scripts)
├── examples/                # Example configs (6 files)
├── .claude/                 # Claude Code config (8 files)
│   ├── settings.json
│   ├── SETUP_CONTEXT.md    # Token-optimized setup guide
│   ├── agents/             # 2 custom agents
│   └── commands/           # 5 slash commands
│
├── README.md               # Landing page (408 lines)
├── START_HERE.md           # Persona selector (150+ lines)
├── QUICK_REFERENCE.md      # Searchable reference
├── VISUAL_GUIDES.md        # 5 Mermaid diagrams
└── CLAUDE.md              # This file!
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
- **Directories:** Use hyphens, lowercase
  - `01_global-setup/`, `good-to-have/`

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

**Examples: Custom agents, slash commands, MCP configs**

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
- `docs/00-start-here/ENTRY_POINTS.md` - Navigation guide (v3.0.0)
- `docs/00-start-here/SKILLS_PARADIGM.md` - Future of Claude Code (v3.0.0)
- `docs/01-fundamentals/ANTI_PATTERNS.md` - #1 priority guide (v3.0.0)
- `START_HERE.md` - Detailed persona guide

### Critical Templates (What users copy)
- `templates/CLAUDE.md.template` - Project memory template (284 lines)
- `templates/coding-standards.md.template` - Global standards
- `.claude/settings.json` - Optimized Claude settings

### Core Configuration
- `.claude/settings.json` - Project settings
- `.claude/settings-explained.json` - Educational reference
- `.claude/SETUP_CONTEXT.md` - Token-optimized setup guide (v2.5.0)

### Reference Documentation
- `QUICK_REFERENCE.md` - Searchable feature reference (v2.5.0)
- `VISUAL_GUIDES.md` - 5 Mermaid diagrams
- `docs/README.md` - Documentation hub with learning journey (v3.0.0)
- `docs/02-optimization/` - Token & workflow optimization guides (v3.0.0)
- `docs/03-advanced/` - MCP workflows, sub-agents, vision (v3.0.0)
- `docs/04-ecosystem/PROGRESS_BAR_GUIDE.md` - Progress bar config (v3.0.0)

### Version Control
- `CHANGELOG.md` - Complete version history
- `HISTORICAL_VERSIONS.md` - Version evolution documentation
- `README.md.backup` - Backup of previous README (v2.4.0)

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
→ Direct to `docs/00-start-here/ENTRY_POINTS.md` first, then learning journey

**"What should I learn first?"**
→ Start with `docs/01-fundamentals/ANTI_PATTERNS.md` (#1 priority)

**"What's the Skills Paradigm?"**
→ See `docs/00-start-here/SKILLS_PARADIGM.md` (the future of Claude Code)

**"Where is feature X?"**
→ Use `QUICK_REFERENCE.md` (alphabetically organized, searchable)

**"How do I add [agent/command/hook]?"**
→ See "Development Workflow" section above

**"How do I optimize tokens?"**
→ See `docs/02-optimization/` directory (Prompt Caching, MCP Optimization, etc.)

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

### User Approval Required for Commits

**CRITICAL: Always get user approval before committing.**

#### Commit Workflow (Token-Optimized):

**1. Draft Phase:**
   - Draft a commit message from context/file names
   - **Optional:** Run `git status` only if user asks or you need to verify files
   - **Optional:** Run `git diff --stat` only if you need to see change summary
   - **Note:** Users see changes in their IDE, so avoid redundant git commands

**2. Review Phase - MANDATORY:**
   - Present the drafted commit message to the user
   - List which files will be committed (from context or git status if run)
   - Use conversational language: "Here's the commit message I've drafted. Should I proceed?"
   - Wait for explicit approval (user says "yes", "go ahead", "commit it", etc.)

**3. Execute Phase:**
   - Only after user approval, run: `git add [files] && git commit -m "message"`
   - Confirm success briefly

**NEVER auto-commit** even if the user says "commit when done" - always show the message first.

#### Token Efficiency Tips:

**Minimal workflow (recommended):**
```
User: "Commit the login changes"
Claude: Drafts message → Shows message → Waits for approval
Tokens: ~300-500 per commit
```

**When to run git commands:**
- `git status`: Only if user asks "what files changed?" or you're unsure
- `git diff --stat`: Only if you need change context for message quality
- `git diff`: Avoid (users see full diff in IDE, wastes 500-2,000 tokens)

**Cost comparison:**
- With git status + git diff: ~2,000 tokens/commit
- With git diff --stat: ~800 tokens/commit
- Without git commands: ~400 tokens/commit (75% savings!)

**User sees changes in their IDE already** - don't duplicate information unless requested.

### Helping Users Configure Git Workflow

**When users ask about setting up git commit approval globally:**

1. **Understand their needs first.** Ask these questions:
   - "Are you working solo or in a team?"
   - "Do you prefer seeing every change, or do you trust fast automation?"
   - "What git operations worry you most? (commits, pushes, merges, rebases)"
   - "Are you learning Claude Code, or are you already experienced with it?"

2. **Recommend based on their answers:**

   **Recommend Full Protection if:**
   - Working in a team
   - Learning Claude Code
   - Safety-critical work
   - Wants to see everything before it happens

   **Recommend Commit-Only Protection if:**
   - Working solo
   - Experienced developer who wants speed
   - Trusts Claude with file edits
   - Only wants commit message control

   **Recommend Minimal Protection if:**
   - Very experienced with Claude Code
   - Needs maximum speed
   - Only worried about accidents (destructive operations)
   - Comfortable with automation

3. **Guide the setup:**
   - Explain your recommendation clearly with reasoning
   - Offer to help: "I can help you set this up. Would you like me to show you the command to run?"
   - Show: `./scripts/setup-git-workflow.sh`
   - After they run it, mention they should choose option [1/2/3] based on your recommendation
   - Reassure: "You can always change this later by running the wizard again"

4. **Example conversation:**
   ```
   User: "I want to set up git approval globally"

   Claude: "I'll help you choose the best configuration! Let me ask a few questions:

   1. Are you working solo or in a team?
   2. How comfortable are you with Claude Code? (new/experienced)
   3. Do you prefer seeing plans before actions, or fast automation?"

   User: "Solo, pretty experienced, I like speed but want to review commits"

   Claude: "Perfect! Based on that, I recommend **Commit-Only Protection**:

   ✅ You get speed (acceptEdits mode for file changes)
   ✅ You review every commit message before it's committed
   ✅ Git push commands are displayed (not executed due to auth)

   To set this up, run this wizard:
     ./scripts/setup-git-workflow.sh

   When prompted, choose option 2 (Commit-Only Protection).

   This will update your ~/.claude/settings.json globally. Sound good?"
   ```

### Git Push - Display Only

**IMPORTANT: Due to git authentication requirements, Claude cannot execute git push directly.**

Instead of executing git push:
1. Show the user the exact command to run:
   ```bash
   git push origin <branch-name>
   ```
2. **First time in conversation:** Briefly explain why: "This requires your git credentials."
3. **Subsequent times:** Just show the command without explanation (user already knows)
4. **If user asks why:** Explain: "Git authentication requires interactive credential input that Claude Code's sandbox cannot handle."

**Example (first push):**
```
✅ Commit successful!

To push these changes to GitHub, please run:
  git push origin main

This requires your git credentials.
```

**Example (subsequent pushes in same conversation):**
```
✅ Commit successful!

To push:
  git push origin main
```

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

**Common maintenance tasks:**
- Adding new documentation → See "Development Workflow" above
- Fixing broken links → Search and replace, test thoroughly
- Adding features → Follow "Adding New Features" process
- Updating version → Bump in all locations, update CHANGELOG

**This project is a meta-example:** It demonstrates the best practices it teaches. Keep that integrity intact!

---

## Version History (This File)

- **v3.0.0 (2025-12-12):**
  - Major documentation restructure: Learning journey (00-start-here → 01-fundamentals → 02-optimization → 03-advanced → 04-ecosystem)
  - Added 14 comprehensive guides (6,000+ lines): Anti-Patterns, Skills Paradigm, Ctrl+O Workflow, Prompt Caching, MCP Optimization, Environment Variables, Advanced MCP Workflows, Sub-Agent Best Practices, Vision Optimization, Conversation Branching, Third-Party MCPs, Plugins Guide
  - Structured output schemas for agents (prompt-polisher, project-planner)
  - Progress bar global configuration system (v3.0.0 post-release)
  - Browser workflow broken link fix (v3.0.0 post-release)
  - Updated file counts: 87 MD files (from 39), 12 shell scripts (from 8)
- **v2.9.0 (2025-12-11):** Added comprehensive Git Workflow & Commit Approval section with token-optimized patterns (draft → review → approve workflow, 75% token savings)
- **v2.8.0 (2025-12-08):** Version sync script implementation, automated version updates across multiple files
- **v2.7.1 (2025-12-08):** Quick wins documentation and honesty policy refinements
- **v2.7.0 (2025-12-08):** Package security release documentation
- **v2.6.1 (2025-12-08):** Honesty policy enforcement - removed misleading 'battle-tested' language
- **v2.6.0 (2025-12-08):** Added Browser Workflow - 9 role-based Custom Instructions guides for claude.ai users (now 10 files including library overview)
- **v2.5.0 (2025-12-08):** Created CLAUDE.md for template project (meta-example) with comprehensive project documentation
- **v2.4.0 (2025-12-05):** Enhanced prompt-polisher agent documentation (3-tier technique system, intelligent selection)
- **v2.3.0 (2025-12-05):** Added project-planner agent documentation (6-perspective coordination)
- **v2.2.1 (2025-12-07):** Educational modes refinement
- **v2.2.0 (2025-12-06):** Claude Code 2.0 feature documentation
- **v2.1.0 (2025-12-05):** Progressive setup wizard documentation
- **v2.0.0 (2024-XX-XX):** Initial creation with comprehensive project documentation

---

**Note:** This CLAUDE.md serves dual purposes:
1. **Practical:** Helps Claude (and contributors) maintain this project efficiently
2. **Educational:** Shows users a real-world example of a well-structured CLAUDE.md

Users can reference this file to see how to document a large documentation project!