# Progress Bar Configuration

**Version:** v4.16.0 (Nested Progress Release)
**Updated:** 2025-12-17

Comprehensive guide to using simple and nested progress bars in scripts.

---

## Table of Contents

1. [Why Nested Progress Matters](#why-nested-progress-matters)
2. [Basic Usage](#basic-usage)
3. [Nested Progress API](#nested-progress-api)
4. [Dynamic Updates](#dynamic-updates)
5. [Examples from Wizards](#examples-from-wizards)
6. [Configuration Reference](#configuration-reference)
7. [Migration Guide](#migration-guide)
8. [See Also](#see-also)

---

## Why Nested Progress Matters

**Educational Value:** Understanding WHY nested progress improves UX.

### Transparency Builds Trust
Users trust systems they can see working. When operations happen in a "black box," anxiety increases ("Is it frozen?"). Nested progress shows:
- **Phase-level:** High-level workflow structure (e.g., "Setup → Configuration → Validation")
- **Task-level:** Detailed steps within each phase (e.g., "Copying file 3 of 7")

### Cognitive Load Reduction
Seeing progress reduces anxiety and mental load. Users know:
- What phase they're in (big picture)
- What task is executing (current step)
- How much is left (estimated completion)

### Process Understanding
Nested progress teaches users about system architecture through visual feedback:
- **Wizards:** Users learn the setup workflow (3 phases, X tasks each)
- **Validation:** Users see what validation involves (discovery → validation → summary)
- **Registration:** Users understand registration steps (input → validation → registration)

### Time Calibration
Users learn realistic expectations about operation duration:
- Phase 1 typically takes 40% of total time
- Task X is the longest step
- This helps set expectations for future runs

### Meta-Example
This project demonstrates professional CLI UX standards. Nested progress is a quality indicator.

---

## Basic Usage

```bash
# Source the config
source scripts/progress-bar-config.sh

# Simple single-line progress
show_progress 3 5 "Installing dependencies"
# Output: Progress: [██████████░░░░░░░░░] 60% - Installing dependencies
```

---

## Nested Progress API

**New in v4.16.0:** Two-level progress visualization (phase + task).

### Phase-Level Progress

```bash
show_phase_progress <current_phase> <total_phases> <phase_name>

# Example:
show_phase_progress 1 3 "Setup"
# Output: Phase: [████░░░░░░░░░░░░] 33% - Setup
```

### Task-Level Progress (Nested under Phase)

```bash
show_task_progress <current_task> <total_tasks> <task_name>

# Example (displayed indented under phase):
show_task_progress 1 2 "Copy Configuration Files"
# Output:   Task: [████████░░░░░░░░] 50% - Copy Configuration Files
```

### Complete Nested Example

```bash
# Phase 1: Setup (2 tasks)
show_phase_progress 1 3 "Setup"
show_task_progress 1 2 "Get Project Path"
# ... gather project path ...

show_phase_progress 1 3 "Setup"
show_task_progress 2 2 "Copy Configuration Files"
# ... copy files ...

# Phase 2: Configuration (2 tasks)
show_phase_progress 2 3 "Configuration"
show_task_progress 1 2 "Create CLAUDE.md"
# ... create file ...

show_phase_progress 2 3 "Configuration"
show_task_progress 2 2 "Document Business Purpose"
# ... edit file ...

# Phase 3: Validation (1 task)
show_phase_progress 3 3 "Validation"
show_task_progress 1 1 "Test Setup"
# ... validate ...
```

**Output:**
```
Phase: [████░░░░░░░░░░░░] 33% - Setup
  Task: [████████░░░░░░░░] 50% - Get Project Path

Phase: [████░░░░░░░░░░░░] 33% - Setup
  Task: [████████████████] 100% - Copy Configuration Files

Phase: [████████░░░░░░░░] 66% - Configuration
  Task: [████████░░░░░░░░] 50% - Create CLAUDE.md

...and so on
```

### Adaptive Progress (Auto-Nest)

Automatically chooses simple vs nested based on task count:

```bash
show_adaptive_progress <total_tasks> <current_task> <description>

# Example: Only 3 tasks → uses simple progress
show_adaptive_progress 3 1 "Copy file 1"

# Example: 10 tasks → uses nested task progress
show_adaptive_progress 10 5 "Copy file 5"
```

**Threshold:** Default is 5 tasks (configurable via `PROGRESS_NESTED_THRESHOLD`).
- < 5 tasks: Simple single-line progress
- ≥ 5 tasks: Nested task progress (assumes phase is already shown)

---

## Dynamic Updates

**New in v4.16.0:** Real-time progress updates without scrolling.

### Basic Dynamic Update

```bash
# Show initial progress
show_phase_progress 1 3 "Validation"
show_task_progress 1 10 "Validating template 1"

# Update progress (overwrites previous)
CURRENT_TASK=2
TASK_NAME="Validating template 2"
update_progress  # Re-renders both phase and task bars

# Continue updating...
CURRENT_TASK=3
TASK_NAME="Validating template 3"
update_progress
```

**How it works:**
- Uses ANSI escape codes to move cursor up 2 lines
- Clears and redraws progress bars
- Rate-limited to max 10 updates/second (prevents flicker)
- Auto-fallback: If ANSI not supported, prints new lines instead

**Terminal compatibility:**
- ✅ Works: Most modern terminals (macOS Terminal, iTerm2, Linux terminals)
- ⚠️ Fallback: Windows CMD, TERM=dumb, CI/CD environments
- Fallback mode: Prints progress lines without cursor movement

---

## Examples from Wizards

### Quick Setup Wizard (wizard-quick-setup.sh)

**3 phases, 5 tasks total:**

```bash
# Phase 1: Setup (2 tasks)
show_phase_progress 1 3 "Setup"
show_task_progress 1 2 "Get Project Path"
# [user inputs project path]

show_phase_progress 1 3 "Setup"
show_task_progress 2 2 "Copy Configuration Files"
# [copy .claude/ files]

# Phase 2: Configuration (2 tasks)
show_phase_progress 2 3 "Configuration"
show_task_progress 1 2 "Create CLAUDE.md"
# [create from template]

show_phase_progress 2 3 "Configuration"
show_task_progress 2 2 "Document Business Purpose"
# [user edits CLAUDE.md]

# Phase 3: Validation (1 task)
show_phase_progress 3 3 "Validation"
show_task_progress 1 1 "Test Setup"
# [validate setup]
```

### First-Time Learner Wizard (wizard-first-time.sh)

**3 phases, 4 tasks total:**

```bash
# Phase 1: Learning (2 tasks)
show_phase_progress 1 3 "Learning"
show_task_progress 1 2 "Installation"

show_phase_progress 1 3 "Learning"
show_task_progress 2 2 "Core Concepts"

# Phase 2: Optimization (1 task)
show_phase_progress 2 3 "Optimization"
show_task_progress 1 1 "Model Switching"

# Phase 3: Application (1 task)
show_phase_progress 3 3 "Application"
show_task_progress 1 1 "First Project Setup"
```

---

## Configuration Reference

### Basic Configuration (Pre-v4.16.0)

**Bar Appearance:**
- `PROGRESS_BAR_WIDTH=50` - Width in characters (default: 50)
- `PROGRESS_CHAR_FILLED='█'` - Character for filled portion (default: █)
- `PROGRESS_CHAR_EMPTY='░'` - Character for empty portion (default: ░)
- `PROGRESS_BAR_LABEL="Progress"` - Label text (default: "Progress")

**Colors:**
- `PROGRESS_COLOR_LABEL='\033[0;36m'` - Label color (default: cyan)
- `PROGRESS_COLOR_RESET='\033[0m'` - Reset code (default: reset)

### Nested Progress Configuration (v4.16.0)

**Nested Display:**
- `PROGRESS_NESTED_ENABLED=true` - Enable nested progress (default: true)
- `PROGRESS_PHASE_LABEL="Phase"` - Phase bar label (default: "Phase")
- `PROGRESS_TASK_LABEL="Task"` - Task bar label (default: "Task")
- `PROGRESS_TASK_INDENT="  "` - Task bar indentation (default: 2 spaces)

**Dynamic Updates:**
- `PROGRESS_DYNAMIC_UPDATE=true` - Enable ANSI cursor movement (default: true)
- `PROGRESS_UPDATE_RATE_MS=100` - Min time between updates in ms (default: 100)
- `PROGRESS_ANSI_SUPPORTED=true` - Auto-detected by `detect_ansi_support()`

**Adaptive Complexity:**
- `PROGRESS_NESTED_THRESHOLD=5` - Auto-nest if >= 5 tasks (default: 5)

### Example: Custom Nested Progress

```bash
# Set custom appearance
export PROGRESS_BAR_WIDTH=30
export PROGRESS_PHASE_LABEL="📦"
export PROGRESS_TASK_LABEL="  →"
export PROGRESS_CHAR_FILLED='▓'
export PROGRESS_CHAR_EMPTY='▒'

# Source config
source scripts/progress-bar-config.sh

# Use nested progress
show_phase_progress 1 3 "Building"
show_task_progress 2 4 "Compiling modules"
# Output:
# 📦: [▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒] 33% - Building
#   →: [▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒] 50% - Compiling modules
```

---

## Migration Guide

### Converting from Simple to Nested Progress

**Old approach (simple progress):**
```bash
show_progress 1 5 "Get Project Path"
show_progress 2 5 "Copy Files"
show_progress 3 5 "Create CLAUDE.md"
show_progress 4 5 "Document Purpose"
show_progress 5 5 "Test Setup"
```

**New approach (nested progress):**
```bash
# Group into logical phases
# Phase 1: Setup (2 tasks)
show_phase_progress 1 3 "Setup"
show_task_progress 1 2 "Get Project Path"
# ...
show_phase_progress 1 3 "Setup"
show_task_progress 2 2 "Copy Files"

# Phase 2: Configuration (2 tasks)
show_phase_progress 2 3 "Configuration"
show_task_progress 1 2 "Create CLAUDE.md"
# ...
show_phase_progress 2 3 "Configuration"
show_task_progress 2 2 "Document Purpose"

# Phase 3: Validation (1 task)
show_phase_progress 3 3 "Validation"
show_task_progress 1 1 "Test Setup"
```

### Decision Framework: When to Nest vs Keep Simple

**Use Simple Progress (`show_progress`) when:**
- < 5 total steps in entire script
- Flat workflow (no logical phases)
- Quick operations (< 1 minute total)
- Example: Simple file copy script

**Use Nested Progress when:**
- ≥ 5 total steps, or
- Clear logical phases exist (setup → config → validate), or
- Complex multi-step operations, or
- Educational value in showing workflow structure
- Example: Setup wizards, validation scripts, registration workflows

**Use Adaptive Progress when:**
- Task count varies dynamically
- Want automatic nesting based on complexity
- Example: Validating N templates (N could be 2 or 20)

### Backward Compatibility

All old scripts using `show_progress()` continue to work unchanged:
- ✅ `show_progress()` function maintained
- ✅ All environment variables backward compatible
- ✅ No breaking changes

New functions are additions, not replacements.

---

## See Also

- **Implementation:** `scripts/wizard-helpers.sh` (all progress functions)
- **Config script:** `scripts/progress-bar-config.sh` (defaults and sourcing)
- **Example usage:** All wizard scripts in `scripts/wizard-*.sh`
- **Demo:** `examples/progress-nested-example.sh` (runnable demo)
- **Plan:** `/Users/christianearle01/.claude/plans/delightful-wiggling-backus.md` (implementation plan)
