# Project Memory - Claude Code Configuration Template

**Last Updated:** 2025-12-08
**Version:** v2.6.0

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
- **Markdown** - All documentation (39 MD files, 22,400+ lines)
- **Bash** - Interactive setup wizards (8 shell scripts)
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
├── docs/                    # v2.5.0: UX-optimized guides
│   ├── 5_MINUTE_SUCCESS.md
│   ├── VISUAL_QUICKSTART.md
│   ├── DIRECTORY_GUIDE.md
│   └── SUCCESS_STORIES.md
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
├── 04_browser-workflow/     # COMING: Role-based configs
│
├── templates/               # Reusable templates (3 files)
├── scripts/                 # Wizards & helpers (8 scripts)
├── examples/                # Example configs (6 files)
├── .claude/                 # Claude Code config (8 files)
│   ├── settings.json
│   ├── SETUP_CONTEXT.md    # NEW: Token-optimized setup guide
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
2. **Choose directory:** 01_global-setup, 02_project-onboarding, or 03_pre-project-planning
3. **Number sequentially:** 01_, 02_, 03_ for reading order
4. **Write content:**
   - Start with purpose/goal
   - Include examples
   - Add navigation footer
5. **Update indexes:**
   - Add to README.md documentation hub
   - Add to QUICK_REFERENCE.md
   - Add to DIRECTORY_GUIDE.md
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

- **PATCH (2.5.x):** Bug fixes, typos, small improvements
- **MINOR (2.x.0):** New features, new documentation, backwards-compatible
- **MAJOR (x.0.0):** Breaking changes, major restructuring

**Process:**
1. Update version in:
   - README.md (line 250, 402)
   - CLAUDE.md (line 2)
   - All footer timestamps
2. Update CHANGELOG.md
3. Create git tag: `git tag v2.6.0`
4. Create release branch: `git branch release/v2.6.0`

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
- `docs/5_MINUTE_SUCCESS.md` - Ultra-fast demo (v2.5.0)
- `docs/VISUAL_QUICKSTART.md` - Decision flowchart (v2.5.0)
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
- `docs/DIRECTORY_GUIDE.md` - Project navigation (v2.5.0)
- `docs/PROJECTED_IMPACT.md` - Theoretical examples (v2.5.0, not real user data)

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
→ Direct to `docs/5_MINUTE_SUCCESS.md` first (builds confidence)

**"Which path should I take?"**
→ Use `docs/VISUAL_QUICKSTART.md` decision flowchart

**"Where is feature X?"**
→ Use `QUICK_REFERENCE.md` (alphabetically organized, searchable)

**"How do I add [agent/command/hook]?"**
→ See "Development Workflow" section above

### File Location Quick Reference

See `.claude/SETUP_CONTEXT.md` for complete file location table.

**Key locations:**
- Templates: `templates/`
- Wizards: `scripts/`
- Docs: `docs/` (new), `01_global-setup/`, `02_project-onboarding/`
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

### Future Enhancements
- [ ] 04_browser-workflow/ directory (role-based configs)
- [ ] More custom agents (language-specific, framework-specific)
- [ ] Video tutorials for visual learners
- [ ] Interactive web-based persona selector
- [ ] Automated link checking in CI/CD

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

## Special Instructions for Claude

**When helping maintain/improve this project:**

1. **Always read CLAUDE.md (this file) first** - Saves exploring 50+ files
2. **Check SETUP_CONTEXT.md** for user-facing setup help
3. **Follow the 3-tier priority system** (must/good/nice-to-have)
4. **Maintain consistent formatting** (see Code Style section)
5. **Update all indexes** when adding content (README, QUICK_REFERENCE, DIRECTORY_GUIDE)
6. **Test links** before committing
7. **Version correctly** (MAJOR.MINOR.PATCH)

**Common maintenance tasks:**
- Adding new documentation → See "Development Workflow" above
- Fixing broken links → Search and replace, test thoroughly
- Adding features → Follow "Adding New Features" process
- Updating version → Bump in all locations, update CHANGELOG

**This project is a meta-example:** It demonstrates the best practices it teaches. Keep that integrity intact!

---

## Version History (This File)

- **v2.6.0 (2025-12-08):** Added Browser Workflow - 9 role-based Custom Instructions guides for claude.ai users
- **v2.5.0 (2025-12-08):** Created CLAUDE.md for template project (meta-example)
- Initial creation with comprehensive project documentation

---

**Note:** This CLAUDE.md serves dual purposes:
1. **Practical:** Helps Claude (and contributors) maintain this project efficiently
2. **Educational:** Shows users a real-world example of a well-structured CLAUDE.md

Users can reference this file to see how to document a large documentation project!