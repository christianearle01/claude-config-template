#!/bin/bash

################################################################################
# Claude Code Setup Wizard - Helper Functions
# Version: 2.1
# Purpose: Shared utility functions for all wizard scripts
################################################################################

################################################################################
# Progress Bar Function (Original - Maintained for Backward Compatibility)
# Usage: show_progress <current> <total> <description>
################################################################################
show_progress() {
    local current=$1
    local total=$2
    local description=$3

    # Use environment variables with defaults
    local bar_width=${PROGRESS_BAR_WIDTH:-50}
    local label=${PROGRESS_BAR_LABEL:-"Progress"}
    local char_filled=${PROGRESS_CHAR_FILLED:-'█'}
    local char_empty=${PROGRESS_CHAR_EMPTY:-'░'}
    local color_label=${PROGRESS_COLOR_LABEL:-${CYAN:-'\033[0;36m'}}
    local color_reset=${PROGRESS_COLOR_RESET:-${NC:-'\033[0m'}}

    local percentage=$((current * 100 / total))
    local filled=$((current * bar_width / total))
    local empty=$((bar_width - filled))

    echo -n -e "${color_label}${label}:${color_reset} ["
    printf "%${filled}s" | tr ' ' "$char_filled"
    printf "%${empty}s" | tr ' ' "$char_empty"
    echo -n -e "] ${percentage}%"

    if [ -n "$description" ]; then
        echo -e " - ${description}"
    else
        echo ""
    fi
}

################################################################################
# ANSI Support Detection
# WHY: Different terminals have different capabilities
# EDUCATIONAL: Teaches importance of graceful degradation in CLI tools
################################################################################
detect_ansi_support() {
    # Check if terminal supports ANSI escape codes
    # TERM=dumb, empty TERM, or missing TERM means no ANSI support
    if [[ $TERM == "dumb" ]] || [[ $TERM == "" ]] || [[ -z $TERM ]]; then
        export PROGRESS_ANSI_SUPPORTED=false
        export PROGRESS_DYNAMIC_UPDATE=false
        return 1
    else
        export PROGRESS_ANSI_SUPPORTED=true
        return 0
    fi
}

# Initialize ANSI support detection
detect_ansi_support

# Global state for nested progress
# WHY: Allows progress bars to know their context (phase + task)
# EDUCATIONAL: Shows trade-off between global state (convenient) vs pure functions (safer)
CURRENT_PHASE=0
TOTAL_PHASES=0
PHASE_NAME=""
CURRENT_TASK=0
TOTAL_TASKS=0
TASK_NAME=""
LAST_UPDATE_TIME=0

################################################################################
# Cleanup Progress State
# WHY: Prevents state pollution across script executions
# EDUCATIONAL: Demonstrates proper resource cleanup in bash scripts
################################################################################
cleanup_progress_state() {
    unset CURRENT_PHASE TOTAL_PHASES PHASE_NAME
    unset CURRENT_TASK TOTAL_TASKS TASK_NAME
    unset LAST_UPDATE_TIME
}

# Register cleanup handler
trap cleanup_progress_state EXIT

################################################################################
# Phase-Level Progress Bar
# Usage: show_phase_progress <current_phase> <total_phases> <phase_name>
# WHY: Shows high-level workflow structure (Exploration → Design → Review)
# EDUCATIONAL: Nested progress teaches users about system architecture
################################################################################
show_phase_progress() {
    local current=$1
    local total=$2
    local description=$3

    # Store state for nested display
    CURRENT_PHASE=$current
    TOTAL_PHASES=$total
    PHASE_NAME="$description"

    # Use environment variables with defaults
    local bar_width=${PROGRESS_BAR_WIDTH:-50}
    local label=${PROGRESS_PHASE_LABEL:-"Phase"}
    local char_filled=${PROGRESS_CHAR_FILLED:-'█'}
    local char_empty=${PROGRESS_CHAR_EMPTY:-'░'}
    local color_label=${PROGRESS_COLOR_LABEL:-${CYAN:-'\033[0;36m'}}
    local color_reset=${PROGRESS_COLOR_RESET:-${NC:-'\033[0m'}}

    local percentage=$((current * 100 / total))
    local filled=$((current * bar_width / total))
    local empty=$((bar_width - filled))

    echo -n -e "${color_label}${label}:${color_reset} ["
    printf "%${filled}s" | tr ' ' "$char_filled"
    printf "%${empty}s" | tr ' ' "$char_empty"
    echo -e "] ${percentage}% - ${description}"
}

################################################################################
# Task-Level Progress Bar (Nested under Phase)
# Usage: show_task_progress <current_task> <total_tasks> <task_name>
# WHY: Shows detailed steps within each phase
# EDUCATIONAL: Two-level hierarchy matches how humans think about complex work
################################################################################
show_task_progress() {
    local current=$1
    local total=$2
    local description=$3

    # Store state
    CURRENT_TASK=$current
    TOTAL_TASKS=$total
    TASK_NAME="$description"

    # Use environment variables with defaults
    local bar_width=${PROGRESS_BAR_WIDTH:-50}
    local label=${PROGRESS_TASK_LABEL:-"Task"}
    local indent=${PROGRESS_TASK_INDENT:-"  "}
    local char_filled=${PROGRESS_CHAR_FILLED:-'█'}
    local char_empty=${PROGRESS_CHAR_EMPTY:-'░'}
    local color_label=${PROGRESS_COLOR_LABEL:-${CYAN:-'\033[0;36m'}}
    local color_reset=${PROGRESS_COLOR_RESET:-${NC:-'\033[0m'}}

    local percentage=$((current * 100 / total))
    local filled=$((current * bar_width / total))
    local empty=$((bar_width - filled))

    # Indented to show nesting under phase
    echo -n -e "${indent}${color_label}${label}:${color_reset} ["
    printf "%${filled}s" | tr ' ' "$char_filled"
    printf "%${empty}s" | tr ' ' "$char_empty"
    echo -e "] ${percentage}% - ${description}"
}

################################################################################
# Dynamic Progress Update (Overwrites Previous Progress)
# Usage: update_progress
# WHY: Real-time updates without scrolling = better UX for long operations
# EDUCATIONAL: ANSI escape codes enable powerful terminal control
# NOTE: Only works when ANSI is supported, otherwise prints new line
################################################################################
update_progress() {
    # Rate limiting: Don't update more than once per 100ms
    # WHY: Prevents flicker and reduces terminal stress on slow connections
    local current_time=$(date +%s%3N 2>/dev/null || echo "0")  # milliseconds
    local rate_limit=${PROGRESS_UPDATE_RATE_MS:-100}

    if [[ $current_time -gt 0 ]] && [[ $LAST_UPDATE_TIME -gt 0 ]]; then
        local elapsed=$((current_time - LAST_UPDATE_TIME))
        if [[ $elapsed -lt $rate_limit ]]; then
            return  # Skip update, too soon
        fi
    fi
    LAST_UPDATE_TIME=$current_time

    # Check if ANSI is supported and dynamic updates are enabled
    if [[ ${PROGRESS_ANSI_SUPPORTED:-true} == "true" ]] && [[ ${PROGRESS_DYNAMIC_UPDATE:-true} == "true" ]]; then
        # Move cursor up 2 lines, clear from cursor to end of screen
        echo -ne "\033[2A\033[J"

        # Redraw phase progress
        if [[ $CURRENT_PHASE -gt 0 ]] && [[ $TOTAL_PHASES -gt 0 ]]; then
            show_phase_progress $CURRENT_PHASE $TOTAL_PHASES "$PHASE_NAME"
        fi

        # Redraw task progress
        if [[ $CURRENT_TASK -gt 0 ]] && [[ $TOTAL_TASKS -gt 0 ]]; then
            show_task_progress $CURRENT_TASK $TOTAL_TASKS "$TASK_NAME"
        fi
    else
        # Fallback: Just print new progress lines without cursor movement
        # WHY: Ensures functionality even in limited terminal environments
        if [[ $CURRENT_PHASE -gt 0 ]] && [[ $TOTAL_PHASES -gt 0 ]]; then
            show_phase_progress $CURRENT_PHASE $TOTAL_PHASES "$PHASE_NAME"
        fi
        if [[ $CURRENT_TASK -gt 0 ]] && [[ $TOTAL_TASKS -gt 0 ]]; then
            show_task_progress $CURRENT_TASK $TOTAL_TASKS "$TASK_NAME"
        fi
    fi
}

################################################################################
# Adaptive Progress (Auto-chooses Simple vs Nested)
# Usage: show_adaptive_progress <total_tasks> <current_task> <description>
# WHY: Prevents cognitive overload on trivial operations (< 5 tasks)
# EDUCATIONAL: Teaches that appropriate UX adapts to context, not one-size-fits-all
################################################################################
show_adaptive_progress() {
    local total=$1
    local current=$2
    local description=$3

    local threshold=${PROGRESS_NESTED_THRESHOLD:-5}

    if [[ $total -lt $threshold ]]; then
        # Simple operation: Use single-line progress
        show_progress $current $total "$description"
    else
        # Complex operation: Use task progress (assumes phase is already shown)
        show_task_progress $current $total "$description"
    fi
}

################################################################################
# Checkpoint Function
# Usage: checkpoint <step_number> <step_name>
################################################################################
checkpoint() {
    local step_num=$1
    local step_name=$2

    echo ""
    echo -e "${GREEN}✅ Checkpoint ${step_num}: ${step_name} Complete!${NC}"
    echo ""
}

################################################################################
# Celebration Function
# Usage: celebrate <milestone_name>
################################################################################
celebrate() {
    local milestone=$1

    echo ""
    echo -e "${MAGENTA}🎉 ${milestone}!${NC}"
    echo ""
}

################################################################################
# Validation Quiz Function
# Usage: quiz <question> <correct_answer> <option_a> <option_b> <option_c>
################################################################################
quiz() {
    local question=$1
    local correct=$2
    local option_a=$3
    local option_b=$4
    local option_c=$5

    echo ""
    echo -e "${YELLOW}📝 Quick Knowledge Check:${NC}"
    echo "$question"
    echo ""
    echo "A) $option_a"
    echo "B) $option_b"
    echo "C) $option_c"
    echo ""

    local attempts=0
    local max_attempts=2

    while [ $attempts -lt $max_attempts ]; do
        echo -n -e "${GREEN}Your answer (A/B/C): ${NC}"
        read -r answer

        # Convert to uppercase
        answer=$(echo "$answer" | tr '[:lower:]' '[:upper:]')

        if [ "$answer" = "$correct" ]; then
            echo -e "${GREEN}✅ Correct! Great job!${NC}"
            return 0
        else
            attempts=$((attempts + 1))
            if [ $attempts -lt $max_attempts ]; then
                echo -e "${RED}❌ Not quite. Try again!${NC}"
            else
                echo -e "${RED}❌ The correct answer is ${correct}.${NC}"
                echo -e "${YELLOW}💡 Review tip: Check the relevant guide for more details.${NC}"
                return 1
            fi
        fi
    done
}

################################################################################
# File Copy with Validation
# Usage: copy_with_validation <source> <destination>
################################################################################
copy_with_validation() {
    local source=$1
    local dest=$2

    if [ ! -e "$source" ]; then
        echo -e "${RED}❌ Error: Source file not found: $source${NC}"
        return 1
    fi

    # Create parent directory if it doesn't exist
    mkdir -p "$(dirname "$dest")"

    # Copy file
    cp -r "$source" "$dest"

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✅ Copied: $(basename "$source")${NC}"
        return 0
    else
        echo -e "${RED}❌ Failed to copy: $source${NC}"
        return 1
    fi
}

################################################################################
# Validate JSON File
# Usage: validate_json <file_path>
################################################################################
validate_json() {
    local file=$1

    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ File not found: $file${NC}"
        return 1
    fi

    # Check if jq is available
    if command -v jq &> /dev/null; then
        if jq empty "$file" 2>/dev/null; then
            echo -e "${GREEN}✅ Valid JSON: $(basename "$file")${NC}"
            return 0
        else
            echo -e "${RED}❌ Invalid JSON syntax in: $file${NC}"
            echo -e "${YELLOW}💡 Tip: Check for missing commas, brackets, or quotes${NC}"
            return 1
        fi
    else
        # Basic JSON validation without jq
        if python3 -c "import json; json.load(open('$file'))" 2>/dev/null; then
            echo -e "${GREEN}✅ Valid JSON: $(basename "$file")${NC}"
            return 0
        else
            echo -e "${RED}❌ Invalid JSON syntax in: $file${NC}"
            return 1
        fi
    fi
}

################################################################################
# Check Command Exists
# Usage: check_command <command_name> <install_instructions>
################################################################################
check_command() {
    local cmd=$1
    local install_msg=$2

    if command -v "$cmd" &> /dev/null; then
        echo -e "${GREEN}✅ Found: $cmd${NC}"
        return 0
    else
        echo -e "${RED}❌ Missing: $cmd${NC}"
        if [ -n "$install_msg" ]; then
            echo -e "${YELLOW}💡 Install with: $install_msg${NC}"
        fi
        return 1
    fi
}

################################################################################
# Validate CLAUDE.md Format
# Usage: validate_claude_md <file_path>
################################################################################
validate_claude_md() {
    local file=$1

    if [ ! -f "$file" ]; then
        echo -e "${RED}❌ CLAUDE.md not found${NC}"
        return 1
    fi

    local errors=0

    # Check for template placeholders (shouldn't exist after customization)
    if grep -q "\[PROJECT NAME\]" "$file" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Warning: CLAUDE.md still contains [PROJECT NAME] placeholder${NC}"
        errors=$((errors + 1))
    fi

    if grep -q "\[type of application\]" "$file" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Warning: CLAUDE.md still contains [type of application] placeholder${NC}"
        errors=$((errors + 1))
    fi

    # Check for required sections
    if ! grep -q "## What Does This Application Do?" "$file" 2>/dev/null; then
        echo -e "${YELLOW}⚠️  Warning: Missing 'What Does This Application Do?' section${NC}"
        errors=$((errors + 1))
    fi

    if [ $errors -eq 0 ]; then
        echo -e "${GREEN}✅ CLAUDE.md looks good!${NC}"
        return 0
    else
        echo -e "${YELLOW}💡 Tip: Complete the customization of CLAUDE.md${NC}"
        return 1
    fi
}

################################################################################
# Timer Function
# Usage: start_timer then check_timer <description>
################################################################################
START_TIME=0

start_timer() {
    START_TIME=$(date +%s)
}

check_timer() {
    local description=$1
    local current_time=$(date +%s)
    local elapsed=$((current_time - START_TIME))
    local minutes=$((elapsed / 60))
    local seconds=$((elapsed % 60))

    echo -e "${CYAN}⏱️  Time: ${minutes}m ${seconds}s - ${description}${NC}"
}

################################################################################
# Pause Function
# Usage: pause <message>
################################################################################
pause() {
    local message=${1:-"Press Enter to continue..."}
    echo ""
    echo -n -e "${CYAN}${message}${NC}"
    read -r
}

################################################################################
# Show Tip Function
# Usage: show_tip <tip_text>
################################################################################
show_tip() {
    local tip=$1
    echo ""
    echo -e "${YELLOW}💡 Pro Tip: ${NC}${tip}"
    echo ""
}

################################################################################
# Error Handler
# Usage: handle_error <error_message>
################################################################################
handle_error() {
    local error_msg=$1
    echo ""
    echo -e "${RED}❌ Error: ${error_msg}${NC}"
    echo ""
    echo -e "${YELLOW}Troubleshooting:${NC}"
    echo "  • Check error message above for details"
    echo "  • Review START_HERE.md for manual setup"
    echo "  • Run: ${GREEN}claude /doctor${NC} for diagnostics"
    echo ""
    exit 1
}

################################################################################
# Success Banner
# Usage: success_banner <persona_name>
################################################################################
success_banner() {
    local persona=$1
    echo ""
    echo -e "${GREEN}╔════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                                                            ║${NC}"
    echo -e "${GREEN}║         🎉 ${persona} Setup Complete!                     ║${NC}"
    echo -e "${GREEN}║                                                            ║${NC}"
    echo -e "${GREEN}╚════════════════════════════════════════════════════════════╝${NC}"
    echo ""
}

################################################################################
# Ask Yes/No Question
# Usage: ask_yes_no <question>
# Returns: 0 for yes, 1 for no
################################################################################
ask_yes_no() {
    local question=$1
    echo -n -e "${CYAN}${question} (y/n): ${NC}"
    read -r response

    if [[ $response =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

################################################################################
# Detect Project Type
# Usage: detect_project_type <project_path>
################################################################################
detect_project_type() {
    local project_path=$1

    if [ -f "$project_path/package.json" ]; then
        echo "Node.js/TypeScript"
    elif [ -f "$project_path/requirements.txt" ] || [ -f "$project_path/setup.py" ]; then
        echo "Python"
    elif [ -f "$project_path/go.mod" ]; then
        echo "Go"
    elif [ -f "$project_path/Cargo.toml" ]; then
        echo "Rust"
    elif [ -f "$project_path/pom.xml" ] || [ -f "$project_path/build.gradle" ]; then
        echo "Java"
    elif [ -f "$project_path/Gemfile" ]; then
        echo "Ruby"
    else
        echo "Unknown"
    fi
}

################################################################################
# Create Directory Structure
# Usage: create_claude_structure <project_path>
################################################################################
create_claude_structure() {
    local project_path=$1

    # Create .claude directory structure
    mkdir -p "$project_path/.claude/agents"
    mkdir -p "$project_path/.claude/commands"
    mkdir -p "$project_path/.claude/hooks"
    mkdir -p "$project_path/.claude/plans"

    # Create .gitkeep for empty directories
    touch "$project_path/.claude/plans/.gitkeep"

    echo -e "${GREEN}✅ Created .claude directory structure${NC}"
}

################################################################################
# Export all functions
################################################################################
# Original progress function
export -f show_progress

# Nested progress functions (v4.16.0)
export -f detect_ansi_support
export -f cleanup_progress_state
export -f show_phase_progress
export -f show_task_progress
export -f update_progress
export -f show_adaptive_progress

# Other helper functions
export -f checkpoint
export -f celebrate
export -f quiz
export -f copy_with_validation
export -f validate_json
export -f check_command
export -f validate_claude_md
export -f start_timer
export -f check_timer
export -f pause
export -f show_tip
export -f handle_error
export -f success_banner
export -f ask_yes_no
export -f detect_project_type
export -f create_claude_structure
