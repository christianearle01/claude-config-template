# Claude Code Setup Wizard Scripts

**Version:** 2.1
**Purpose:** Progressive setup wizard with persona-based routing, validation checkpoints, and celebratory milestones.

---

## Quick Start

Run the main wizard:

```bash
./scripts/claude-wizard.sh
```

The wizard will guide you through persona selection and run the appropriate setup script.

---

## Wizard Scripts

### Main Entry Point

**`claude-wizard.sh`** - Main wizard with persona selector
- Interactive persona selection (5 profiles)
- Routes to appropriate wizard script
- Saves persona preference for future sessions
- Colorized terminal output with progress tracking

### Persona-Specific Wizards

**`wizard-first-time.sh`** - First-Time Learner (60-90 min)
- Complete onboarding for beginners
- Teaches Claude Code fundamentals
- Includes formative assessments
- Validates understanding at each step

**`wizard-quick-setup.sh`** - Quick Setup User (15-30 min)
- Fast project setup for experienced users
- Assumes Claude Code knowledge
- Focus on CLAUDE.md documentation
- Minimal reading, maximum efficiency

**`wizard-advanced.sh`** - Advanced Optimizer (20-40 min)
- Security hooks installation
- Custom agents creation
- MCP servers configuration
- Production-grade features

**`wizard-team-lead.sh`** - Team Lead (90-120 min)
- Team rollout strategy planning
- Shared template repository setup
- Team-specific standards documentation
- Pilot user onboarding process

**`wizard-returning.sh`** - Returning User (10-20 min)
- Quick refresher on commands
- Model switching strategy review
- What's new in v2.1
- Quick reference card generation

### Helper Functions

**`wizard-helpers.sh`** - Shared utilities
- Progress bars and checkpoints
- Validation functions (JSON, CLAUDE.md)
- Quiz system for knowledge checks
- File copy with validation
- Celebration messages
- Error handling

---

## Features

### ✅ Phase 2 Implementation Complete

All Phase 2 features are implemented:

1. **Progressive Setup Wizard**
   - Main wizard entry point (claude-wizard.sh)
   - 5 persona-specific wizard scripts
   - Modular helper functions

2. **Persona Routing (Step 0)**
   - Interactive persona selector
   - Decision tree logic
   - Persona preference saved to ~/.claude/last-persona
   - Customized experience per persona

3. **Validation Checkpoints**
   - CLAUDE.md format validation
   - JSON configuration validation
   - Command availability checks
   - Knowledge check quizzes (2-3 per wizard)
   - Formative assessments throughout

4. **Celebratory Milestones**
   - Progress tracking (X/Y steps)
   - Checkpoint celebrations (🎉)
   - Success banners
   - Time tracking with feedback
   - Motivational tips and pro advice

---

## Usage Examples

### Standard Setup

```bash
# Run main wizard (recommended)
./scripts/claude-wizard.sh
```

### Direct Persona Access

```bash
# Skip persona selector, run specific wizard
./scripts/wizard-quick-setup.sh ~/claude-config-template

# Run for specific project
cd /path/to/your/project
~/claude-config-template/scripts/wizard-quick-setup.sh ~/claude-config-template
```

### Team Deployment

```bash
# Set up shared template for team
./scripts/wizard-team-lead.sh ~/claude-config-template
```

---

## Validation Features

### CLAUDE.md Validation
- Checks for template placeholders
- Verifies required sections exist
- Provides improvement suggestions

### JSON Validation
- Validates .claude/settings.json syntax
- Checks for required fields
- Uses jq or Python for validation

### Knowledge Checks
- Quiz system with 2 attempts
- Immediate feedback on answers
- Learning tips for incorrect answers

---

## Color Codes

Wizards use color-coded output for clarity:

- 🟢 **Green** - Success, checkpoints, correct answers
- 🔵 **Blue** - Informational messages, commands
- 🟡 **Yellow** - Warnings, pro tips, important notes
- 🔴 **Red** - Errors, incorrect answers, critical warnings
- 🟣 **Magenta** - Milestones, celebrations, examples
- 🔵 **Cyan** - Section headers, prompts, next steps

---

## Progress Tracking

Each wizard tracks:
- **Step Progress:** X/Y steps complete
- **Time Elapsed:** Duration since start
- **Checkpoints:** Major milestone markers
- **Quizzes:** Knowledge validation points

Example output:
```
Progress: [████████████░░░░░░] 60% - Document Business Purpose
⏱️  Time: 15m 30s - Progress check
✅ Checkpoint 3: Business purpose documented
```

---

## Exit Codes

- **0** - Success, setup completed
- **1** - User cancelled or error occurred
- **2** - Missing dependencies

---

## Requirements

### Required
- Bash 4.0+
- Git (for version control)
- Node.js (for security hooks)

### Optional
- `jq` - Better JSON validation
- `nano` or `code` - Text editors
- `claude` - Claude Code CLI (installed by First-Time wizard)

---

## File Structure

```
scripts/
├── README.md                      # This file
├── claude-wizard.sh               # Main entry point (10KB)
├── wizard-helpers.sh              # Shared utilities (12KB)
├── wizard-first-time.sh           # First-Time Learner (16KB)
├── wizard-quick-setup.sh          # Quick Setup (10KB)
├── wizard-advanced.sh             # Advanced Optimizer (13KB)
├── wizard-team-lead.sh            # Team Lead (16KB)
└── wizard-returning.sh            # Returning User (13KB)
```

**Total:** 7 scripts, 90KB, 2,800+ lines of bash

---

## Development Notes

### Adding New Wizards

1. Create new wizard script in `scripts/`
2. Source `wizard-helpers.sh` for utilities
3. Follow existing pattern:
   - Introduction with time estimate
   - Progress tracking (show_progress)
   - Checkpoints (checkpoint)
   - Validation quizzes (quiz)
   - Final summary (success_banner)
4. Add persona to main wizard selector
5. Make executable: `chmod +x scripts/wizard-*.sh`

### Testing Wizards

```bash
# Test specific wizard
./scripts/wizard-quick-setup.sh ~/claude-config-template

# Test with dry-run (no actual changes)
# Note: Implement DRY_RUN flag if needed

# Test all wizards
for wizard in scripts/wizard-*.sh; do
    echo "Testing $wizard..."
    $wizard ~/claude-config-template
done
```

---

## Troubleshooting

### "Permission denied" Error
```bash
chmod +x scripts/*.sh
```

### "Command not found: claude"
Install Claude Code first:
```bash
npm install -g @anthropic-ai/claude-code
```

### Scripts not working in PowerShell/Windows
Use Git Bash or WSL (Windows Subsystem for Linux).

### Color codes not displaying
Ensure terminal supports ANSI colors. Most modern terminals do.

---

## Version History

**v2.1** (2025-12-05)
- ✨ Initial release with 5 persona wizards
- ✨ Progressive setup with validation
- ✨ Celebratory milestones
- ✨ Knowledge check quizzes
- ✨ Colorized terminal output

---

## Contributing

Improvements welcome! Focus areas:
- Additional validation checks
- More quiz questions
- Windows/PowerShell support
- Automated testing suite
- Wizard recording/replay

---

## License

Same as parent Claude Config Template project.

---

**Last Updated:** 2025-12-05
**Author:** CE
**Template Version:** 2.1
