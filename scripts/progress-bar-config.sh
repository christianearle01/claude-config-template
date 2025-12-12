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

# Export for use in functions
export PROGRESS_COLOR_LABEL
export PROGRESS_COLOR_FILLED
export PROGRESS_COLOR_EMPTY
export PROGRESS_COLOR_RESET
export PROGRESS_BAR_WIDTH
export PROGRESS_BAR_LABEL
export PROGRESS_CHAR_FILLED
export PROGRESS_CHAR_EMPTY

# Import the show_progress function
if [ -f "$(dirname "${BASH_SOURCE[0]}")/wizard-helpers.sh" ]; then
    source "$(dirname "${BASH_SOURCE[0]}")/wizard-helpers.sh"
fi
