#!/bin/bash
# Progress Bar Configuration
# Source this file to use progress bar in your scripts
#
# Usage:
#   source scripts/progress-bar-config.sh
#   show_progress 3 5 "Installing dependencies"
#
# Customize via environment variables before sourcing:
#   export PROGRESS_BAR_WIDTH=30
#   export PROGRESS_BAR_LABEL="Status"
#   source scripts/progress-bar-config.sh

# Color definitions (can be overridden by environment)
: ${PROGRESS_COLOR_LABEL:='\033[0;36m'}  # Cyan
: ${PROGRESS_COLOR_FILLED:=''}            # Default terminal color
: ${PROGRESS_COLOR_EMPTY:=''}             # Default terminal color
: ${PROGRESS_COLOR_RESET:='\033[0m'}      # Reset

# Progress bar settings (can be overridden by environment)
: ${PROGRESS_BAR_WIDTH:=50}
: ${PROGRESS_BAR_LABEL:="Progress"}
: ${PROGRESS_CHAR_FILLED:='█'}
: ${PROGRESS_CHAR_EMPTY:='░'}

# Nested progress settings (v4.16.0)
# WHY: Enables two-level progress visualization (phase + task)
# EDUCATIONAL: Demonstrates adaptive UX that prevents cognitive overload
: ${PROGRESS_NESTED_ENABLED:=true}
: ${PROGRESS_PHASE_LABEL:="Phase"}
: ${PROGRESS_TASK_LABEL:="Task"}
: ${PROGRESS_TASK_INDENT:="  "}

# Dynamic update settings
# WHY: Real-time progress without scrolling = better UX
# EDUCATIONAL: Shows how to optimize terminal I/O performance
: ${PROGRESS_DYNAMIC_UPDATE:=true}
: ${PROGRESS_NESTED_THRESHOLD:=5}      # Auto-nest if >= 5 tasks (prevents spam)
: ${PROGRESS_ANSI_SUPPORTED:=true}      # Auto-detected by detect_ansi_support()
: ${PROGRESS_UPDATE_RATE_MS:=100}       # Min 100ms between updates (prevents flicker)

# Export for use in functions
export PROGRESS_COLOR_LABEL
export PROGRESS_COLOR_FILLED
export PROGRESS_COLOR_EMPTY
export PROGRESS_COLOR_RESET
export PROGRESS_BAR_WIDTH
export PROGRESS_BAR_LABEL
export PROGRESS_CHAR_FILLED
export PROGRESS_CHAR_EMPTY

# Export nested progress settings (v4.16.0)
export PROGRESS_NESTED_ENABLED
export PROGRESS_PHASE_LABEL
export PROGRESS_TASK_LABEL
export PROGRESS_TASK_INDENT
export PROGRESS_DYNAMIC_UPDATE
export PROGRESS_NESTED_THRESHOLD
export PROGRESS_ANSI_SUPPORTED
export PROGRESS_UPDATE_RATE_MS

# Import the show_progress function
if [ -f "$(dirname "${BASH_SOURCE[0]}")/wizard-helpers.sh" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/wizard-helpers.sh"
fi
