#!/bin/bash

################################################################################
# Claude Code Setup Wizard - Helper Functions
# Version: 2.1
# Purpose: Shared utility functions for all wizard scripts
################################################################################

################################################################################
# Progress Bar Function
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
export -f show_progress
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
