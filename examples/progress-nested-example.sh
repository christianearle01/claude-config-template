#!/bin/bash

################################################################################
# Nested Progress Bar Demo
# Version: 1.0 (v4.16.0 Nested Progress Release)
# Purpose: Runnable demonstration of all progress bar patterns
################################################################################

# Get script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEMPLATE_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

# Source helpers
source "$TEMPLATE_ROOT/scripts/wizard-helpers.sh"

# Colors for output
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

################################################################################
# Introduction
################################################################################

clear
echo -e "${CYAN}╔════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}║         Progress Bar Demo (v4.16.0)                       ║${NC}"
echo -e "${CYAN}║                                                            ║${NC}"
echo -e "${CYAN}╚════════════════════════════════════════════════════════════╝${NC}"
echo ""
echo -e "${GREEN}This demo showcases all progress bar patterns:${NC}"
echo ""
echo "  1. Simple Progress (single-line)"
echo "  2. Nested Progress (phase + task)"
echo "  3. Dynamic Updates (real-time)"
echo "  4. Adaptive Progress (auto-nest)"
echo ""
echo -e "${YELLOW}Educational Note:${NC}"
echo "Progress bars demonstrate:"
echo "  • Transparency builds trust (users see what's happening)"
echo "  • Cognitive load reduction (reduces 'is it frozen?' anxiety)"
echo "  • Process understanding (teaches workflow structure)"
echo ""
read -p "Press Enter to start the demo..."

################################################################################
# Demo 1: Simple Progress (Original Pattern)
################################################################################

clear
echo -e "${MAGENTA}═══ Demo 1: Simple Progress (Original Pattern) ═══${NC}"
echo ""
echo -e "${CYAN}Use case:${NC} Simple operations with < 5 steps"
echo ""
echo "Running:"
echo ""

for i in {1..5}; do
    show_progress $i 5 "Processing step $i"
    sleep 0.8
done

echo ""
echo -e "${GREEN}✅ Simple progress complete!${NC}"
echo ""
read -p "Press Enter for next demo..."

################################################################################
# Demo 2: Nested Progress (Phase + Task Pattern)
################################################################################

clear
echo -e "${MAGENTA}═══ Demo 2: Nested Progress (Phase + Task) ═══${NC}"
echo ""
echo -e "${CYAN}Use case:${NC} Complex operations with logical phases"
echo ""
echo "Example: Project setup wizard (3 phases)"
echo ""
read -p "Press Enter to start..."
echo ""

# Phase 1: Setup (2 tasks)
show_phase_progress 1 3 "Setup"
show_task_progress 1 2 "Get Project Path"
sleep 1.5

show_phase_progress 1 3 "Setup"
show_task_progress 2 2 "Copy Configuration Files"
sleep 1.5

# Phase 2: Configuration (2 tasks)
show_phase_progress 2 3 "Configuration"
show_task_progress 1 2 "Create CLAUDE.md"
sleep 1.5

show_phase_progress 2 3 "Configuration"
show_task_progress 2 2 "Document Business Purpose"
sleep 1.5

# Phase 3: Validation (1 task)
show_phase_progress 3 3 "Validation"
show_task_progress 1 1 "Test Setup"
sleep 1.5

echo ""
echo -e "${GREEN}✅ Nested progress complete!${NC}"
echo ""
echo -e "${CYAN}Notice:${NC} Two-level hierarchy shows both:"
echo "  • High-level phase (where we are in the workflow)"
echo "  • Detailed task (current step within the phase)"
echo ""
read -p "Press Enter for next demo..."

################################################################################
# Demo 3: Dynamic Updates (Real-Time Progress)
################################################################################

clear
echo -e "${MAGENTA}═══ Demo 3: Dynamic Updates (Real-Time) ═══${NC}"
echo ""
echo -e "${CYAN}Use case:${NC} Long-running operations with many steps"
echo ""
echo "Example: Validating 10 templates"
echo ""
echo -e "${YELLOW}Watch:${NC} Progress bars update in-place (no scrolling)"
echo ""
read -p "Press Enter to start..."
echo ""

# Initial display
show_phase_progress 1 3 "Validation"
show_task_progress 1 10 "Validating template 1"
sleep 0.5

# Dynamic updates (overwrites previous)
for i in {2..10}; do
    CURRENT_TASK=$i
    TASK_NAME="Validating template $i"
    update_progress
    sleep 0.3
done

echo ""
echo -e "${GREEN}✅ Dynamic updates complete!${NC}"
echo ""
echo -e "${CYAN}Notice:${NC} Progress bars updated in-place"
echo "  • No scrolling (ANSI cursor movement)"
echo "  • Rate-limited to 10 updates/sec (prevents flicker)"
echo "  • Auto-fallback if ANSI not supported"
echo ""
read -p "Press Enter for next demo..."

################################################################################
# Demo 4: Adaptive Progress (Auto-Nest Based on Complexity)
################################################################################

clear
echo -e "${MAGENTA}═══ Demo 4: Adaptive Progress (Auto-Nest) ═══${NC}"
echo ""
echo -e "${CYAN}Use case:${NC} Variable task counts (could be 2 or 20)"
echo ""
echo "Threshold: 5 tasks (configurable via PROGRESS_NESTED_THRESHOLD)"
echo "  • < 5 tasks: Simple single-line progress"
echo "  • ≥ 5 tasks: Nested task progress"
echo ""

# Demo with 3 tasks (simple)
echo -e "${YELLOW}Example 1: Only 3 tasks → Simple progress${NC}"
echo ""
for i in {1..3}; do
    show_adaptive_progress 3 $i "Copy file $i"
    sleep 0.8
done

echo ""
echo -e "${GREEN}✅ Used simple progress (< 5 tasks)${NC}"
echo ""
read -p "Press Enter for next example..."

# Demo with 8 tasks (nested)
clear
echo -e "${MAGENTA}═══ Demo 4: Adaptive Progress (continued) ═══${NC}"
echo ""
echo -e "${YELLOW}Example 2: 8 tasks → Nested task progress${NC}"
echo ""
echo "(Assumes phase is already shown)"
echo ""

# First show phase
show_phase_progress 2 3 "Processing"
echo ""

# Then show adaptive progress (will use nested because >= 5 tasks)
for i in {1..8}; do
    show_adaptive_progress 8 $i "Process file $i"
    sleep 0.5
done

echo ""
echo -e "${GREEN}✅ Used nested task progress (≥ 5 tasks)${NC}"
echo ""
read -p "Press Enter for summary..."

################################################################################
# Summary
################################################################################

clear
echo -e "${MAGENTA}═══ Demo Complete! ═══${NC}"
echo ""
echo -e "${GREEN}You've seen all progress patterns:${NC}"
echo ""
echo "  ✅ Simple Progress - Single-line for < 5 steps"
echo "  ✅ Nested Progress - Phase + Task for complex workflows"
echo "  ✅ Dynamic Updates - Real-time without scrolling"
echo "  ✅ Adaptive Progress - Auto-choose based on complexity"
echo ""
echo -e "${CYAN}Educational Takeaways:${NC}"
echo ""
echo "  🧠 Psychological: Transparency reduces anxiety"
echo "  📚 Educational: Visual feedback teaches workflow structure"
echo "  💻 Engineering: ANSI codes enable powerful terminal control"
echo ""
echo -e "${YELLOW}Key Principles:${NC}"
echo ""
echo "  • Simple for trivial operations (avoid cognitive overload)"
echo "  • Nested for complex workflows (show hierarchy)"
echo "  • Dynamic for long operations (maintain engagement)"
echo "  • Adaptive for variable complexity (smart UX)"
echo ""
echo -e "${MAGENTA}Try it yourself!${NC}"
echo ""
echo "Source the helpers:"
echo "  ${GREEN}source scripts/wizard-helpers.sh${NC}"
echo ""
echo "Then use any pattern:"
echo "  ${GREEN}show_progress 3 5 \"Task 3\"${NC}"
echo "  ${GREEN}show_phase_progress 1 3 \"Setup\"${NC}"
echo "  ${GREEN}show_task_progress 2 4 \"Copy files\"${NC}"
echo ""
echo -e "${CYAN}Documentation:${NC}"
echo "  ${GREEN}docs/04-ecosystem/02_progress-bar-guide.md${NC}"
echo ""
echo -e "${MAGENTA}Happy coding! 🚀${NC}"
echo ""
