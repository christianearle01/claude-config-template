#!/bin/bash

################################################################################
# Claude Workflow Progress Visualization
# Version: 1.0 (v4.16.0)
# Purpose: Helper functions for Claude to show workflow progress to users
#
# OPTIONAL FEATURE: This is the author's preference for transparency
# - Other users can disable by removing instruction #10 from their CLAUDE.md
# - Not required for template functionality
# - Provides visibility into Claude's multi-phase workflow
#
# USAGE: Source this file in CLAUDE.md to enable workflow progress
# WHY: Provides transparency into Claude's multi-phase workflow
# EDUCATIONAL: Users see what Claude is doing (reduces "black box" anxiety)
################################################################################

# Source the core progress functions
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
if [ -f "$SCRIPT_DIR/wizard-helpers.sh" ]; then
    source "$SCRIPT_DIR/wizard-helpers.sh"
elif [ -f "$SCRIPT_DIR/../scripts/wizard-helpers.sh" ]; then
    source "$SCRIPT_DIR/../scripts/wizard-helpers.sh"
else
    echo "Error: Cannot find wizard-helpers.sh"
    return 1
fi

################################################################################
# Claude Workflow Phases
#
# Standard workflow: Understand → Plan → Implement → Validate → Document
# Phase count may vary based on task complexity
################################################################################

# Common workflow phase counts
WORKFLOW_3_PHASE="3"  # Simple tasks: Understand → Implement → Validate
WORKFLOW_4_PHASE="4"  # Standard: Understand → Plan → Implement → Validate
WORKFLOW_5_PHASE="5"  # Complex: Understand → Plan → Implement → Validate → Document

################################################################################
# Phase 1: Understanding/Exploration
# Usage: claude_progress_understanding <current_step> <total_steps> <description>
# Example: claude_progress_understanding 1 3 "Reading codebase files"
################################################################################
claude_progress_understanding() {
    local current=${1:-1}
    local total=${2:-3}
    local description=${3:-"Understanding requirements"}

    show_phase_progress 1 $WORKFLOW_4_PHASE "Understanding"
    show_task_progress $current $total "$description"
}

################################################################################
# Phase 2: Planning/Design
# Usage: claude_progress_planning <current_step> <total_steps> <description>
# Example: claude_progress_planning 1 2 "Designing implementation approach"
################################################################################
claude_progress_planning() {
    local current=${1:-1}
    local total=${2:-2}
    local description=${3:-"Planning implementation"}

    show_phase_progress 2 $WORKFLOW_4_PHASE "Planning"
    show_task_progress $current $total "$description"
}

################################################################################
# Phase 3: Implementation/Coding
# Usage: claude_progress_implementing <current_step> <total_steps> <description>
# Example: claude_progress_implementing 3 5 "Updating wizard-helpers.sh"
################################################################################
claude_progress_implementing() {
    local current=${1:-1}
    local total=${2:-5}
    local description=${3:-"Writing code"}

    show_phase_progress 3 $WORKFLOW_4_PHASE "Implementation"
    show_task_progress $current $total "$description"
}

################################################################################
# Phase 4: Validation/Testing
# Usage: claude_progress_validating <current_step> <total_steps> <description>
# Example: claude_progress_validating 1 2 "Running test suite"
################################################################################
claude_progress_validating() {
    local current=${1:-1}
    local total=${2:-2}
    local description=${3:-"Validating changes"}

    show_phase_progress 4 $WORKFLOW_4_PHASE "Validation"
    show_task_progress $current $total "$description"
}

################################################################################
# Phase 5: Documentation (Optional - for complex changes)
# Usage: claude_progress_documenting <current_step> <total_steps> <description>
# Example: claude_progress_documenting 1 1 "Updating documentation"
################################################################################
claude_progress_documenting() {
    local current=${1:-1}
    local total=${2:-1}
    local description=${3:-"Updating documentation"}

    show_phase_progress 5 $WORKFLOW_5_PHASE "Documentation"
    show_task_progress $current $total "$description"
}

################################################################################
# Simplified Workflow (3-phase for simple tasks)
################################################################################

claude_progress_simple_understand() {
    show_phase_progress 1 $WORKFLOW_3_PHASE "Understanding"
    show_task_progress ${1:-1} ${2:-1} "${3:-Analyzing request}"
}

claude_progress_simple_implement() {
    show_phase_progress 2 $WORKFLOW_3_PHASE "Implementation"
    show_task_progress ${1:-1} ${2:-1} "${3:-Making changes}"
}

claude_progress_simple_validate() {
    show_phase_progress 3 $WORKFLOW_3_PHASE "Validation"
    show_task_progress ${1:-1} ${2:-1} "${3:-Verifying changes}"
}

################################################################################
# Waiting Indicator (for background operations)
# Usage: claude_progress_waiting <operation_description>
# Example: claude_progress_waiting "Explore agent analyzing codebase"
################################################################################
claude_progress_waiting() {
    local description=${1:-"Processing"}
    local spinner=("⣾" "⣽" "⣻" "⢿" "⡿" "⣟" "⣯" "⣷")
    local idx=0

    # Note: This is a single frame display, not animated
    # For animation, would need background process (not practical in this context)
    echo -ne "  ${spinner[$idx]} Waiting: $description...\n"
}

################################################################################
# Agent Operation Indicator (when launching Task tool agents)
# Usage: claude_progress_agent <agent_type> <purpose>
# Example: claude_progress_agent "Explore" "Searching for component definitions"
################################################################################
claude_progress_agent() {
    local agent_type=${1:-"Agent"}
    local purpose=${2:-"Processing"}

    echo -e "${CYAN}🤖 Launching $agent_type agent: $purpose${NC}"
    claude_progress_waiting "$agent_type agent running"
}

################################################################################
# Quick Status Update (one-liner for minor operations)
# Usage: claude_progress_status <message>
# Example: claude_progress_status "Reading file: src/components/Header.tsx"
################################################################################
claude_progress_status() {
    local message=${1:-"Working"}
    echo -e "${CYAN}  → $message${NC}"
}

################################################################################
# Export all functions
################################################################################
export -f claude_progress_understanding
export -f claude_progress_planning
export -f claude_progress_implementing
export -f claude_progress_validating
export -f claude_progress_documenting
export -f claude_progress_simple_understand
export -f claude_progress_simple_implement
export -f claude_progress_simple_validate
export -f claude_progress_waiting
export -f claude_progress_agent
export -f claude_progress_status

################################################################################
# Usage Examples
################################################################################
#
# Standard 4-phase workflow:
# ------------------------
# # Phase 1: Understanding (3 steps)
# claude_progress_understanding 1 3 "Reading user request"
# claude_progress_understanding 2 3 "Exploring codebase"
# claude_progress_understanding 3 3 "Identifying affected files"
#
# # Phase 2: Planning (2 steps)
# claude_progress_planning 1 2 "Designing approach"
# claude_progress_planning 2 2 "Identifying dependencies"
#
# # Phase 3: Implementation (5 steps)
# claude_progress_implementing 1 5 "Updating file 1"
# claude_progress_implementing 2 5 "Updating file 2"
# claude_progress_implementing 3 5 "Updating file 3"
# claude_progress_implementing 4 5 "Updating file 4"
# claude_progress_implementing 5 5 "Updating file 5"
#
# # Phase 4: Validation (2 steps)
# claude_progress_validating 1 2 "Running tests"
# claude_progress_validating 2 2 "Verifying output"
#
# Simple 3-phase workflow:
# ----------------------
# claude_progress_simple_understand 1 1 "Analyzing request"
# claude_progress_simple_implement 1 1 "Making changes"
# claude_progress_simple_validate 1 1 "Verifying changes"
#
# Agent operations:
# ---------------
# claude_progress_agent "Explore" "Searching for component files"
# # ... wait for agent ...
# claude_progress_agent "Plan" "Designing implementation"
#
# Quick status updates:
# -------------------
# claude_progress_status "Reading CLAUDE.md"
# claude_progress_status "Analyzing dependencies"
#
################################################################################
